#!/usr/bin/env python
# -*- coding:utf-8 -*-
__author__ = 'yinzishao'

from rest_framework.decorators import api_view,authentication_classes
from api.serializers import OrderApplySerializer
from django.contrib.auth.decorators import login_required
from rest_framework.response import Response
from tutor.http import JsonResponse,JsonError
from api.models import Teacher,AuthUser,ParentOrder,OrderApply,Message
from django.db import transaction
from rest_framework.authentication import SessionAuthentication, BasicAuthentication

class CsrfExemptSessionAuthentication(SessionAuthentication):
    def enforce_csrf(self, request):
        return  # To not perform the csrf check previously happening


def judge(teach_willing,result):
    if teach_willing == 2:
        result = u"愿意"
    elif teach_willing == 0:
        result = u"拒绝"
    return result
@login_required()
@api_view(['GET'])
@authentication_classes((CsrfExemptSessionAuthentication, BasicAuthentication))
def getOrder(request):
    user = AuthUser.objects.get(username=request.user.username)
    t = user.teacher_set.all()
    pd = user.parentorder_set.all()
    oas = None
    if len(t) > 0:
        #老师的订单详情
        oas = OrderApply.objects.filter(tea=t[0])
        results = []
        for oa in oas:
            oa.name= oa.pd.name
            if oa.apply_type == 2:
                oa.type = "parent"
                #家长主动
                oa.result= judge(oa.teacher_willing,u"已邀请") #默认是待处理
                #是否接受邀请
                if oa.teacher_willing == 1:
                    #家长主动，并且教师待处理，应该弹出接受或者拒绝
                    oa.finish = 0
                    pass
                else:
                    #教师已经处理，则直接返回结果。
                    oa.finish = 1
                    pass

            elif oa.apply_type == 1:
                oa.type = "teacher"
                #教师主动
                oa.result= judge(oa.parent_willing,u"已报名")
                #是否取消报名
                if oa.parent_willing == 1:
                    #教师主动，并且家长待处理，应该弹出取消报名
                    oa.finish = 0
                else:
                    #家长已经处理，则直接返回结果。
                    oa.finish = 1
        return Response(OrderApplySerializer(oas,many=True).data)

    elif len(pd) > 0:
        #家长的订单详情
        oas = OrderApply.objects.filter(pd=pd[0])
        results = []
        for oa in oas:
            oa.name= oa.tea.name
            if oa.apply_type == 2:
                oa.type = "parent"
                #家长主动
                oa.result= judge(oa.teacher_willing,u"已邀请")
                #是否取消邀请
                if oa.teacher_willing == 1:
                    #家长主动，并且老师待处理，应该弹出取消邀请
                    oa.finish = 0
                else:
                    #老师已经处理，则直接返回结果。
                    oa.finish = 1
            elif oa.apply_type == 1:
                oa.type = "teacher"
                #教师主动
                oa.result= judge(oa.parent_willing,u"已报名")
                #是否接受报名
                if oa.parent_willing == 1:
                    #教师主动，并且家长待处理，应该弹出取消报名
                    oa.finish = 0
                else:
                    #家长已经处理，则直接返回结果。
                    oa.finish = 1
        return Response(OrderApplySerializer(oas,many=True).data)

    if not oas:
        return Response({"info":"没有订单！"})


@login_required()
@api_view(['POST'])
@authentication_classes((CsrfExemptSessionAuthentication, BasicAuthentication))
def handleOrder(request):
    """
    处理订单的各种情况，接受或者拒绝老师的报名或者家长的邀请
    :param request:
     {
     "type": 0/1        0：老师处理家长 1：家长处理老师
     "id":1,            如果是老师处理家长，则填对应的pd_id，如果家长处理老师，则填对应的tea_id
     "accept": 0/1      0/1  0：拒绝 1：接受
     }
    :return:
    """
    type = request.data.get('type', None)
    id = request.data.get('id', None)
    accept = request.data.get('accept', None)
    if (type != None and id != None and accept != None):
        user = AuthUser.objects.get(username=request.user.username)
        #家长处理老师
        if (type):
            parentorders = user.parentorder_set.all()
            teas = Teacher.objects.filter(tea_id = id)
            if ( len(parentorders ) and  len(teas) ):
                pd = parentorders[0]
                tea = teas[0]
                orders = OrderApply.objects.filter(apply_type=1, tea=tea, pd=pd)
                if len(orders) :
                    order = orders[0]
                    #对订单进行处理
                    if (accept):
                        order.parent_willing = 2
                        message_title = pd.name + u"接受了你的报名！"
                        message_content = pd.name + u"接受了你的报名！请到“我的家长”处查看详细信息!"
                    else:
                        order.parent_willing = 0
                        message_title = pd.name + u"拒绝了你的报名！"
                        message_content = pd.name + u"拒绝了你的报名！请到“我的家长”处查看详细信息!"
                    #新建消息
                    message = Message(sender=user, receiver=tea.wechat, message_title=message_title, message_content=message_content,status=0)
                    try:
                        with transaction.atomic():
                            message.save()
                            order.finished = 1
                            order.save()
                        #TODO:消息推送到微信端
                    except Exception,e:
                        return JsonError(e.message)
                    return JsonResponse()
                else:
                    return JsonError(u"处理错误，请确定数据无误！")
            else:
                return JsonError(u"处理错误，请确定数据无误！")
        else:
        #老师处理家长
            teas = user.teacher_set.all()
            parentorders = ParentOrder.objects.filter(pd_id = id)
            if ( len(parentorders ) and  len(teas) ):
                pd = parentorders[0]
                tea = teas[0]
                orders = OrderApply.objects.filter(apply_type=2, tea=tea, pd=pd)
                if len(orders) :
                    order = orders[0]
                    #对订单进行处理
                    if (accept):
                        order.teacher_willing = 2
                        message_title = tea.name + u"接受了你的邀请！"
                        message_content = tea.name + u"接受了你的邀请！请到“我的老师”处查看详细信息!"
                    else:
                        order.teacher_willing = 0
                        message_title = tea.name + u"拒绝了你的邀请！"
                        message_content = tea.name + u"拒绝了你的邀请！请到“我的老师”处查看详细信息!"
                    message = Message(sender=user, receiver=pd.wechat, message_title=message_title, message_content=message_content,status=0)
                    try:
                        with transaction.atomic():
                            message.save()
                            order.finished = 1
                            order.save()
                        #消息推送到微信端
                    except Exception,e:
                        return JsonError(e.message)
                    return JsonResponse()
                    #TODO:消息推送到微信端
                else:
                    return JsonError(u"处理错误，请确定数据无误！")
            else:
                return JsonError(u"处理错误，请确定数据无误！")

        pass

    else:
        return JsonError(u"发送的数据有误！")
