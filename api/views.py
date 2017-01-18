#!/usr/bin/env python
# -*- coding:utf-8 -*-
import time

__author__ = 'yinzishao'
from django.shortcuts import render

# Create your views here.
from rest_framework.decorators import api_view,authentication_classes
from api.serializers import TeacherSerializer,ParentOrderSerializer,MessageSerializer,OrderApplySerializer
from django.contrib.auth.decorators import login_required
from django.utils import timezone
from django.views.decorators.csrf import csrf_exempt
from rest_framework.response import Response
from tutor.http import JsonResponse,JsonError
from api.models import Teacher,AuthUser,ParentOrder,OrderApply,Message
from django.db import transaction
from wechat_auth.helpers import changeBaseToImg,changeObejct,getParentOrderObj,getTeacherObj
from rest_framework.authentication import SessionAuthentication, BasicAuthentication
class CsrfExemptSessionAuthentication(SessionAuthentication):

    def enforce_csrf(self, request):
        return  # To not perform the csrf check previously happening
@login_required()
@api_view(['GET'])
def loginSuc(request):

    teachers = Teacher.objects.all()
    serializer = TeacherSerializer(teachers, many=True)
    return Response(serializer.data)
#TODO：为家长推荐老师
@login_required()
@api_view(['POST'])
@authentication_classes((CsrfExemptSessionAuthentication, BasicAuthentication))
def getTeachers(request):
    """
        全部老师根据类别获取老师列表
        :param request:
        {
        "size":6,
        "start":0,
        "subject":"语文",
        "grade":1,
        "hot":1,
        }
        :return:
            teacher obejcts
    """
    #TODO:排序与选择
    size = int(request.data.get("size",0))
    start = int(request.data.get("start",0)) * size
    #根据学科排序
    subject = request.data.get("subject", 0)
    #根据年级排序
    grade = request.data.get("grade", 0)
    #根据最新最热排序,两个参数是最热门和最新，默认为最热门（参数为1），然后是最新（参数为2）
    hot = request.data.get("hot",1)
    where = []
    order = '-hot_not'
    if hot == 2:
        order = '-create_time'
    if subject:
        where = ['FIND_IN_SET("'+subject+'",subject)']
    #年级,如果里面是字符串，需要加引号
    if grade:
        where = ['FIND_IN_SET("'+grade+'",grade)']
    teachers = Teacher.objects.extra(where=where).order_by(order)[start:start + size]
    user = AuthUser.objects.get(username=request.user.username)
    pds = user.parentorder_set.all()
    if len(pds) > 0:
        pd = pds[0]
    else:
        return JsonError("家长不存在！请重新填问卷")
    for t in teachers:
        orderApply = t.orderapply_set.filter(apply_type=2, pd=pd)
        t.parent_willing = orderApply[0].parent_willing if len(orderApply) else None
    serializer = TeacherSerializer(teachers, many=True)
    result = serializer.data
    getTeacherObj(result,many=True)
    return Response(result)

@login_required()
@api_view(['GET'])
@csrf_exempt
def getInfo(request):
    """
    获取个人信息
    :param request:
    :return:
    """
    user = AuthUser.objects.get(username=request.user.username)
    teacher = user.teacher_set.all()
    parent =  user.parentorder_set.all()
    if len(parent):
        serializer = ParentOrderSerializer(parent[0])
    if len(teacher):
        serializer = TeacherSerializer(teacher[0])
    return Response(serializer.data)

@login_required()
@api_view(['GET'])
@csrf_exempt
def getTeacherInfo(request):
    """
    获取个人信息
    :param request:
    :return:
    """
    user = AuthUser.objects.get(username=request.user.username)
    teacher = user.teacher_set.all()
    if len(teacher):
        serializer = TeacherSerializer(teacher[0])
        result = serializer.data
        getTeacherObj(result)
        return Response(result)
    return JsonError("not found")
@login_required()
@api_view(['GET'])
@csrf_exempt
def getParentInfo(request):
    """
    获取个人信息
    :param request:
    :return:
    """
    user = AuthUser.objects.get(username=request.user.username)
    parent =  user.parentorder_set.all()
    if len(parent):
        serializer = ParentOrderSerializer(parent[0])
        po = serializer.data
        getParentOrderObj(po)
        return Response(po)
    return JsonError("not found")
@login_required()
@api_view(['POST'])
@authentication_classes((CsrfExemptSessionAuthentication, BasicAuthentication))
def createTeacher(request):
    """
    创建老师
    :param request:
    :return:
    """
    user = AuthUser.objects.get(username=request.user.username)
    teachers = user.teacher_set.all()
    if len(teachers) > 0:
        return JsonError("already existed")
    if request.method == 'POST':
        temp = request.data.dict()  if (type(request.data) != type({})) else request.data
        changeObejct(temp)
        photos = temp.get('teach_show_photo',None)
        if photos:
            temp['teach_show_photo'] = changeBaseToImg(photos)
        temp['create_time']= time.strftime('%Y-%m-%d %H:%M:%S',time.localtime(time.time()))
        teacher = Teacher(**temp)
        teacher.wechat = user
        teacher.save()
    return JsonResponse({"wechat_id":teacher.wechat_id})


@login_required()
@api_view(['POST'])
@authentication_classes((CsrfExemptSessionAuthentication, BasicAuthentication))
def updateTeacher(request):
    """
    修改老师
    :param request:
    :return:
    """
    user = AuthUser.objects.get(username=request.user.username)
    teachers = user.teacher_set.all()
    if request.method == 'POST' and len(teachers) > 0:
        temp = request.data.dict()  if (type(request.data) != type({})) else request.data
        changeObejct(temp)
        teacher = user.teacher_set.update(**temp)
        serializer = TeacherSerializer(user.teacher_set.all()[0])
        result = serializer.data
        getTeacherObj(result)
        return Response(result)
    return JsonError("not found")
@login_required()
@api_view(['GET'])
@csrf_exempt
def deleteTeacher(request):
    """
    删除
    :param request:
    :return:
    """
    #TODO：删除外键约束
    user = AuthUser.objects.get(username=request.user.username)
    teachers = user.teacher_set.all()
    if len(teachers) > 0:
        teachers[0].delete()
        return JsonResponse()
    return JsonError("not found")

@login_required()
@api_view(['POST'])
@authentication_classes((CsrfExemptSessionAuthentication, BasicAuthentication))
def createParentOrder(request):
    """
    创建家长订单
    :param request:
    :return:
    """
    user = AuthUser.objects.get(username=request.user.username)
    parentorder = user.parentorder_set.all()
    if len(parentorder) > 0:
        return JsonError("already existed")
    if request.method == 'POST':
        temp = request.data.dict()  if (type(request.data) != type({})) else request.data
        changeObejct(temp)
        now = time.strftime('%Y-%m-%d %H:%M:%S',time.localtime(time.time()))
        temp['create_time']= now
        temp['update_time']= now
        po = ParentOrder(**temp)
        po.wechat = user
        po.save()
    return JsonResponse({"wechat_id":po.wechat_id})

@login_required()
@api_view(['POST'])
@authentication_classes((CsrfExemptSessionAuthentication, BasicAuthentication))
def updateParentOrder(request):
    """
    更新家长订单
    :param request:
    :return:
    """
    user = AuthUser.objects.get(username=request.user.username)
    parentorder = user.parentorder_set.all()
    if request.method == 'POST' and len(parentorder) > 0:
        now = time.strftime('%Y-%m-%d %H:%M:%S',time.localtime(time.time()))
        temp = request.data.dict()  if (type(request.data) != type({})) else request.data
        changeObejct(temp)
        temp['update_time']= now
        po = user.parentorder_set.update(**temp)
        serializer = ParentOrderSerializer(user.parentorder_set.all()[0])
        result = serializer.data
        getParentOrderObj(result)
        return Response(result)
    return JsonError("not found")
@login_required()
@api_view(['GET'])
def deleteParent(request):
    """
    删除
    :param request:
    :return:
    """
    #TODO：删除外键约束
    user = AuthUser.objects.get(username=request.user.username)
    parentorder = user.parentorder_set.all()
    if len(parentorder) > 0:
        parentorder[0].delete()
        return JsonResponse()
    return JsonError("not found")

@login_required()
@api_view(['POST'])
@authentication_classes((CsrfExemptSessionAuthentication, BasicAuthentication))
def getParentOrder(request):
    """
    获取家长列表。家长对于老师的申请处理
    :param request:
    {"start":0,"size":6}
    :return:
    """
    size = int(request.data.get("size",0))
    start = int(request.data.get("start",0)) * size
    user = AuthUser.objects.get(username=request.user.username)
    teas = user.teacher_set.all()
    if len(teas) > 0:
        tea = teas[0]
    else:
        return JsonError("家长不存在！请重新填问卷")
    parentOrders = ParentOrder.objects.all()[start:start + size]
    for po in parentOrders:
        #老师主动申请
        orderApply = po.orderapply_set.filter(apply_type=1, tea=tea)
        po.parent_willing = orderApply[0].parent_willing if len(orderApply) else None
        #家长主动报名
    serializer = ParentOrderSerializer(parentOrders, many=True)
    result = serializer.data
    getParentOrderObj(result, many=True)
    return Response(result)

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
    pd_id = request.data.get("pd_id", None)
    expectation = request.data.get("expectation", None)
    user = AuthUser.objects.get(username=request.user.username)
    #查找教师
    teacher = user.teacher_set.all()[0]
    #查找家长订单
    pd = ParentOrder.objects.get(pd_id=pd_id)
    if type == 1:
        #老师报名家长
        #如果老师可以报名多个家长
        #事务
        try:
            with transaction.atomic():
                #新建订单
                order = OrderApply(apply_type=1, pd=pd,tea=teacher,parent_willing=1,teacher_willing=2,
                                   pass_not=1,update_time=timezone.now(),expectation=expectation)
                order.save()
                message_content = teacher.name + u"向您报名!"
                #新建消息
                message = Message(sender=user, receiver=pd.wechat, message_content=message_content,status=0)
                message.save()
                #TODO:推送到微信端

        except Exception,e:
            return JsonError(e.message)
        return JsonResponse()
    elif type == 0 :
        #老师取消报名家长
        try:
            with transaction.atomic():
                #删除订单
                order = OrderApply.objects.get(apply_type=1, pd=pd,tea=teacher)
                order.delete()
                message_title = teacher.name + u"取消了报名!"
                message_content = teacher.name + u"取消了报名!"
                #新建消息
                message = Message(sender=user, receiver=teacher.wechat, message_title=message_title, message_content=message_content,status=0)
                message.save()
                #TODO:推送到微信端

        except Exception,e:
            print e
            return JsonError(e.message)
        return JsonResponse()
@login_required()
@api_view(['POST'])
@authentication_classes((CsrfExemptSessionAuthentication, BasicAuthentication))
def inviteTeacher(request):
    """
    家长邀请老师,取消邀请
    :param request:
    {
        "tea_id"：2,
        "type":1/0
    }
    :return:
    """
    #TODO:消息提醒
    #获取老师id
    tea_id = request.data.get("tea_id", None)
    type = request.data.get("type", None)
    user = AuthUser.objects.get(username=request.user.username)
    #查找家长订单
    #TODO： 每个家长是否只有一个需求
    parentorder = user.parentorder_set.all()[0]
    #查找教师
    teacher = Teacher.objects.get(tea_id=tea_id)
    if type == 1 :
        #家长邀请老师
        #如果家长已经邀请了老师，返回错误
        oa = OrderApply.objects.filter(apply_type=2, pd=parentorder)
        if len(oa) != 0:
            return JsonError("已经邀请了老师")
        #事务
        try:
            with transaction.atomic():
                #新建订单
                order = OrderApply(apply_type=2, pd=parentorder,tea=teacher,parent_willing=2,teacher_willing=1,
                                   pass_not=1,update_time=timezone.now())
                order.save()
                message_title = parentorder.name + u"向您发起了邀请!"
                message_content = parentorder.name + u"向您发起了邀请!请到“我的老师”处查看详细信息!"
                #新建消息
                message = Message(sender=user, receiver=teacher.wechat, message_title=message_title, message_content=message_content,status=0)
                message.save()
                #TODO:推送到微信端

        except Exception,e:
            print e
            return JsonError(e.message)
        return JsonResponse()
    elif type == 0 :
        try:
            with transaction.atomic():
                #新建订单
                order = OrderApply.objects.get(apply_type=2, pd=parentorder,tea=teacher)
                order.delete()
                message_title = parentorder.name + u"取消了邀请!"
                message_content = parentorder.name + u"取消了邀请!"
                #新建消息
                message = Message(sender=user, receiver=teacher.wechat, message_title=message_title, message_content=message_content,status=0)
                message.save()
                #TODO:推送到微信端

        except Exception,e:
            print e
            return JsonError(e.message)
        return JsonResponse()

def judge(teach_willing,result):
    if teach_willing == 2:
        result = u"愿意"
    elif teach_willing == 0:
        result = u"拒绝"
    print result
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
            temp = {}
            oa.type = "teacher"
            oa.name= str(oa.pd.name)
            if oa.apply_type == 2:
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
            temp = {}
            oa.type = "parent"
            oa.name= str(oa.tea.name)
            if oa.apply_type == 2:
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
                #教师主动
                oa.result= judge(oa.parent_willing,u"已报名")
                print '-----------'
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
def getMsg(request):
    """
    获取消息列表
    :param request:
    {
        "start":0,
        "size":6
    }
    :return:
    """
    size = int(request.data.get("size",0))
    start = int(request.data.get("start",0)) * size
    user = AuthUser.objects.get(username=request.user.username)
    msgs = user.receiver.all()[start:start + size]
    for msg in msgs:
        msg.isDetailed = False
    serializer = MessageSerializer(msgs, many=True)
    result = serializer.data
    for r in result:
        r["status"] = True if r["status"] else False
    return Response(result)
@login_required()
@api_view(['POST'])
@authentication_classes((CsrfExemptSessionAuthentication, BasicAuthentication))
def readMessage(request):
    """
    阅读消息，将status改为１
    :param request:
    {
        "msg_id":1
    }
    :return:
    """
    msg_id = request.data.get("msg_id", None)
    user = AuthUser.objects.get(username=request.user.username)
    msg = Message.objects.filter(msg_id=msg_id, receiver = user).update(status=1)
    return JsonResponse()

@login_required()
@api_view(['GET'])
@authentication_classes((CsrfExemptSessionAuthentication, BasicAuthentication))
def getWechatInfo(request):
    return Response(request.session.get("info",None))
