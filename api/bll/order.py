#!/usr/bin/env python
# -*- coding:utf-8 -*-
from django.utils import timezone

__author__ = 'yinzishao'

from rest_framework.decorators import api_view,authentication_classes
from api.serializers import OrderApplySerializer
from django.contrib.auth.decorators import login_required
from rest_framework.response import Response
from tutor.http import JsonResponse,JsonError
from api.models import Teacher,AuthUser,ParentOrder,OrderApply,Message
from django.db import transaction
from wechat_auth.helpers import changeSingleBaseToImg
from rest_framework.authentication import SessionAuthentication, BasicAuthentication

class CsrfExemptSessionAuthentication(SessionAuthentication):
    def enforce_csrf(self, request):
        return  # To not perform the csrf check previously happening


@login_required()
@api_view(['POST'])
@authentication_classes((CsrfExemptSessionAuthentication, BasicAuthentication))
def applyParent(request):
    """
    老师报名家长,取消报名
    :param request:
    {
        "pd_id":2,
        "type": 1/0,
        "expectation":""
    }
    :return:
    """
    #获取家长id
    temp = request.data.dict()  if (type(request.data) != type({})) else request.data
    pd_id = int(temp.get("pd_id", -1))
    method = int(temp.get("type", -1))
    expectation = temp.get("expectation", None)

    user = AuthUser.objects.get(username=request.user.username)
    #查找教师
    teachers = user.teacher_set.all()
    #查找家长订单
    pds = ParentOrder.objects.filter(pd_id=pd_id)
    if len(pds) and len(teachers):
        teacher = teachers[0]
        pd = pds[0]
        if method == 1:
            #老师报名家长，老师可以报名多个家长!!

            #检查家长是否已经邀请该老师，是否已经存在两个人的对应订单
            orders = OrderApply.objects.filter(apply_type=2,pd=pd,tea=teacher)
            if len(orders):
                return JsonError(u"该家长已经邀请了您！")

            #家长之前拒绝了该老师，老师再次报名家长
            orders = OrderApply.objects.filter(apply_type=1,pd=pd,tea=teacher)
            if len(orders):
                order = orders[0]
                order.finished = 0
                order.parent_willing = 1
                order.teacher_willing =1
                order.update_time = timezone.now()
                order.expectation = expectation
            else:
                order = OrderApply(apply_type=1, pd=pd,tea=teacher,parent_willing=1,teacher_willing=1,
                               pass_not=1,update_time=timezone.now(),expectation=expectation,finished=0)
            #事务
            try:
                with transaction.atomic():
                    #新建订单
                    order.save()
                    message_title = teacher.name + u"向您报名!"
                    message_content = teacher.name + u"向您报名!请到“我的老师”处查看详细信息!"
                    #新建消息
                    message = Message(sender=user, receiver=pd.wechat,message_title=message_title, message_content=message_content,status=0)
                    message.save()
                    #TODO:推送到微信端

            except Exception,e:
                return JsonError(e.message)
            return JsonResponse()

        elif method == 0 :
            #老师取消报名家长
            try:
                with transaction.atomic():
                    #删除订单
                    orders = OrderApply.objects.filter(apply_type=1, pd=pd,tea=teacher,finished=0)
                    if len(orders):
                        order = orders[0]
                        order.delete()
                        message_title = teacher.name + u"取消了报名!"
                        message_content = teacher.name + u"取消了报名!"
                        #新建消息
                        message = Message(sender=user, receiver=teacher.wechat, message_title=message_title, message_content=message_content,status=0)
                        message.save()
                    else:
                        return JsonError(u"找不到该订单")
                        #TODO:推送到微信端

            except Exception,e:
                return JsonError(e.message)
            return JsonResponse()
    else:
        return JsonError(u"不存在家长订单或老师!")

@login_required()
@api_view(['POST'])
@authentication_classes((CsrfExemptSessionAuthentication, BasicAuthentication))
def inviteTeacher(request):
    """
    家长邀请老师,取消邀请
    :param request:
    {
        "tea_id":2,
        "type":1/0
    }
    :return:
    """
    #TODO:消息提醒
    #获取老师id
    tea_id = int(request.data.get("tea_id", -1))
    method = int(request.data.get("type", -1))
    user = AuthUser.objects.get(username=request.user.username)
    parentorders = user.parentorder_set.all()   #查找家长订单
    teachers = Teacher.objects.filter(tea_id=tea_id)    #查找教师
    if len(parentorders) and len(teachers):
        parentorder = parentorders[0]
        teacher = teachers[0]
        if method == 1 :
            #家长邀请老师
            #如果家长已经邀请了其他老师，并且未完全，返回错误
            oa = OrderApply.objects.filter(apply_type=2, pd=parentorder,finished=0)
            if len(oa) != 0:
                return JsonError(u"您有未完成处理的订单！")
            #如果老师已经报名了该家长
            orders = OrderApply.objects.filter(apply_type=1,pd=parentorder,tea=teacher)
            if len(orders):
                return JsonError(u"该老师已经向您报名了！")
            #老师之前拒绝了该家长，家长再次报名老师
            orders = OrderApply.objects.filter(apply_type=2,pd=parentorder,tea=teacher)
            if len(orders):
                order = orders[0]
                order.finished = 0
                order.parent_willing = 2
                order.teacher_willing = 1
                order.update_time = timezone.now()
            else:
                order = OrderApply(apply_type=2, pd=parentorder,tea=teacher,parent_willing=2,teacher_willing=1,
                                       pass_not=1,update_time=timezone.now(),finished=0)
            #事务
            try:
                with transaction.atomic():
                    #新建订单
                    order.save()
                    message_title = parentorder.name + u"向您发起了邀请!"
                    message_content = parentorder.name + u"向您发起了邀请!请到“我的家长”处查看详细信息!"
                    #新建消息
                    message = Message(sender=user, receiver=teacher.wechat, message_title=message_title, message_content=message_content,status=0)
                    message.save()
                    #TODO:推送到微信端

            except Exception,e:
                return JsonError(e.message)
            return JsonResponse()
        elif method == 0 :
            try:
                with transaction.atomic():
                    #取消订单
                    orders = OrderApply.objects.filter(apply_type=2, pd=parentorder,tea=teacher,finished=0)
                    if len(orders):
                        order = orders[0]
                        order.delete()
                        message_title = parentorder.name + u"取消了邀请!"
                        message_content = parentorder.name + u"取消了邀请!"
                        #新建消息
                        message = Message(sender=user, receiver=teacher.wechat, message_title=message_title, message_content=message_content,status=0)
                        message.save()
                        #TODO:推送到微信端
                    else:
                        return JsonError(u"找不到订单！")
            except Exception,e:
                return JsonError(e.message)
            return JsonResponse()
    else:
        return JsonError(u"不存在家长订单或老师!")

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
                #家长主动,finish为0,老师端订单显示为“已邀请”
                #finished为1,老师端接受：未上传截图，“待处理”
                #finished为2，
                oa.result= judge(oa.teacher_willing,u"已邀请") #默认是待处理
                #是否接受邀请,
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
                        order.finished = 1
                        message_title = pd.name + u"拒绝了你的报名！"
                        message_content = pd.name + u"拒绝了你的报名！请到“我的家长”处查看详细信息!"
                    #新建消息
                    message = Message(sender=user, receiver=tea.wechat, message_title=message_title, message_content=message_content,status=0)
                    try:
                        with transaction.atomic():
                            message.save()
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
        # 第一种情况：老师处理家长的邀请
        # 第二种情况：老师报名家长后，家长同意后，老师再次处理同意
            teas = user.teacher_set.all()
            parentorders = ParentOrder.objects.filter(pd_id = id)
            if ( len(parentorders ) and  len(teas) ):
                pd = parentorders[0]
                tea = teas[0]
                orders = OrderApply.objects.filter(apply_type=2, tea=tea, pd=pd,finished=0)
                if len(orders) :
                    order = orders[0]
                    #对订单进行处理
                    if (accept):
                        order.teacher_willing = 2
                        message_title = tea.name + u"接受了你的邀请！"
                        message_content = tea.name + u"接受了你的邀请！请到“我的老师”处查看详细信息!"
                    else:
                        order.teacher_willing = 0
                        order.finished = 1
                        message_title = tea.name + u"拒绝了你的邀请！"
                        message_content = tea.name + u"拒绝了你的邀请！请到“我的老师”处查看详细信息!"
                    message = Message(sender=user, receiver=pd.wechat, message_title=message_title, message_content=message_content,status=0)
                    try:
                        with transaction.atomic():
                            message.save()
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

@login_required()
@api_view(['POST'])
@authentication_classes((CsrfExemptSessionAuthentication, BasicAuthentication))
def uploadScreenshot(request):
    """
    上传订单截图
    :param request:
    :return:
    """
    user = AuthUser.objects.get(username=request.user.username)
    teas = user.teacher_set.all()
    pic = request.data.get('pic',None)
    oa_id = int(request.data.get('oa_id', -1))
    if len(teas):
        tea = teas[0]
        order_applys = OrderApply.objects.filter(oa_id=oa_id,tea=tea)
        if len(order_applys):
            name = changeSingleBaseToImg(pic)
            order_apply = order_applys[0]
            order_apply.screenshot_path = '/static/' + name
            order_apply.finished = 2
            order_apply.save()
            return  JsonResponse()
        else:
            return JsonError(u"找不到该订单")
    else:
        return JsonError(u"出错，你的老师信息不存在，请重新调调查问卷！")
