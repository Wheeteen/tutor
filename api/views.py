#!/usr/bin/env python
# -*- coding:utf-8 -*-
import time

__author__ = 'yinzishao'
from django.shortcuts import render

# Create your views here.
from rest_framework.decorators import api_view,authentication_classes
from api.serializers import TeacherSerializer,ParentOrderSerializer,MessageSerializer
from django.contrib.auth.decorators import login_required
from django.utils import timezone
from django.views.decorators.csrf import csrf_exempt
from rest_framework.response import Response
from tutor.http import JsonResponse,JsonError
from api.models import Teacher,AuthUser,ParentOrder,OrderApply,Message
from django.db import transaction

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
        "subject":1,
        "grade":1,
        "hot":1,
        "newest":1
        }
        :return:
            teacher obejcts
    """
    #TODO:排序与选择
    size = request.data.get("size",0)
    start = request.data.get("start",0)
    #根据学科排序
    subject = request.data.get("subject", 0)
    #根据年级排序
    grade = request.data.get("grade", 0)
    #根据最新最热排序
    hot = request.data.get("hot",0)
    newest = request.data.get("newest",0)
    where = []
    order = 'name'
    if hot:
        order = '-hot_not'
    if newest:
        order = '-create_time'
    if subject:
        where = ['FIND_IN_SET('+str(subject)+',subject)']
    #年级,如果里面是字符串，需要加引号
    if grade:
        where = ['FIND_IN_SET("'+str(grade)+'",grade)']
    teachers = Teacher.objects.extra(where=where).order_by(order)[start:start + size]
    user = AuthUser.objects.get(username=request.user.username)
    pd = user.parentorder_set.all()[0]
    for t in teachers:
        orderApply = t.orderapply_set.filter(apply_type=2, pd=pd)
        t.parent_willing = orderApply[0].parent_willing if len(orderApply) else None
    serializer = TeacherSerializer(teachers, many=True)
    return Response(serializer.data)

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
        return Response(serializer.data)
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
        return Response(serializer.data)
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
        request.data['create_time']= time.strftime('%Y-%m-%d %H:%M:%S',time.localtime(time.time()))
        teacher = Teacher(**request.data)
        teacher.wechat = user
        teacher.save()
    return JsonResponse()


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
        teacher = user.teacher_set.update(**request.data)
        return JsonResponse()
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
        now = time.strftime('%Y-%m-%d %H:%M:%S',time.localtime(time.time()))
        request.data['create_time']= now
        request.data['update_time']= now
        po = ParentOrder(**request.data)
        po.wechat = user
        po.save()
    return JsonResponse()

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
        request.data['update_time']= now
        po = user.parentorder_set.update(**request.data)
        return JsonResponse()
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
    :return:
    """
    size = request.data.get("size",0)
    start = request.data.get("start",0)
    user = AuthUser.objects.get(username=request.user.username)
    tea = user.teacher_set.all()[0]
    parentOrders = ParentOrder.objects.all()[start:start + size]
    for po in parentOrders:
        orderApply = po.orderapply_set.filter(apply_type=1, tea=tea)
        po.parent_willing = orderApply[0].parent_willing if len(orderApply) else None
    serializer = ParentOrderSerializer(parentOrders, many=True)
    return Response(serializer.data)

@login_required()
@api_view(['POST'])
@authentication_classes((CsrfExemptSessionAuthentication, BasicAuthentication))
def applyParent(request):
    """
    老师报名家长
    :param request:
    {

    }
    :return:
    """
    #获取家长id
    pd_id = request.data.get("pd_id", None)
    user = AuthUser.objects.get(username=request.user.username)
    #查找教师
    teacher = user.teacher_set.all()[0]
    #查找家长订单
    pd = ParentOrder.objects.get(pd_id=pd_id)

    #事务
    try:
        with transaction.atomic():
            #新建订单
            order = OrderApply(apply_type=1, pd=pd,tea=teacher,parent_willing=1,teacher_willing=2,
                               pass_not=1,update_time=timezone.now())
            order.save()
            message_content = teacher.name + u"向您报名!"
            #新建消息
            message = Message(sender=user, receiver=pd.wechat, message_content=message_content,status=0)
            message.save()
            #TODO:推送到微信端

    except Exception,e:
        return JsonError(e.message)
    return JsonResponse()

@login_required()
@api_view(['POST'])
@authentication_classes((CsrfExemptSessionAuthentication, BasicAuthentication))
def inviteTeacher(request):
    """
    家长邀请老师
    :param request:
    {

    }
    :return:
    """
    #TODO:消息提醒
    #获取老师id
    tea_id = request.data.get("tea_id", None)
    user = AuthUser.objects.get(username=request.user.username)
    #查找家长订单
    #TODO： 每个家长是否只有一个需求
    parentorder = user.parentorder_set.all()[0]
    #查找教师
    teacher = Teacher.objects.get(tea_id=tea_id)

    #事务
    try:
        with transaction.atomic():
            #新建订单
            order = OrderApply(apply_type=2, pd=parentorder,tea=teacher,parent_willing=2,teacher_willing=1,
                               pass_not=1,update_time=timezone.now())
            order.save()
            message_title = str(parentorder.name) + u"向您发起了邀请!"
            message_content = str(parentorder.name) + u"向您发起了邀请!请到“我的老师”处查看详细信息!"
            #新建消息
            message = Message(sender=user, receiver=teacher.wechat, message_title=message_title, message_content=message_content,status=0)
            message.save()
            #TODO:推送到微信端

    except Exception,e:
        print e
        return JsonError(e.message)
    return JsonResponse()

@login_required()
@api_view(['GET'])
@authentication_classes((CsrfExemptSessionAuthentication, BasicAuthentication))
def getMsg(request):
    """
    获取消息列表
    :param request:
    :return:
    """
    user = AuthUser.objects.get(username=request.user.username)
    msgs = user.receiver.all()
    for msg in msgs:
        msg.isDetailed = False
    serializer = MessageSerializer(msgs, many=True)
    return Response(serializer.data)
@login_required()
@api_view(['POST'])
@authentication_classes((CsrfExemptSessionAuthentication, BasicAuthentication))
def readMessage(request):
    """
    阅读消息，将status改为１
    :param request:
    :return:
    """
    msg_id = request.data.get("msg_id", None)
    user = AuthUser.objects.get(username=request.user.username)
    msg = Message.objects.filter(msg_id=msg_id, receiver = user).update(status=1)
    return JsonResponse()

