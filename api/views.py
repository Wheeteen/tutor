#!/usr/bin/env python
# -*- coding:utf-8 -*-
import time

__author__ = 'yinzishao'
from django.shortcuts import render

# Create your views here.
from api.bll.teacher import *
from api.bll.parent import *
from api.bll.order import *
from api.bll.message import *
from rest_framework.decorators import api_view,authentication_classes
from api.serializers import TeacherSerializer,ParentOrderSerializer,MessageSerializer,OrderApplySerializer
from django.contrib.auth.decorators import login_required
from django.utils import timezone
from django.views.decorators.csrf import csrf_exempt
from rest_framework.response import Response
from tutor.http import JsonResponse,JsonError
from api.models import Teacher,AuthUser,ParentOrder,OrderApply,Message,Config
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
    pd = ParentOrder.objects.filter(pd_id=pd_id)
    if len(pd) and len(teachers):
        teacher = teachers[0]
        if method == 1:
            #老师报名家长
            #老师可以报名多个家长!!
            #事务
            try:
                with transaction.atomic():
                    #新建订单
                    order = OrderApply(apply_type=1, pd=pd[0],tea=teacher,parent_willing=1,teacher_willing=2,
                                       pass_not=1,update_time=timezone.now(),expectation=expectation,finished=0)
                    order.save()
                    message_title = teacher.name + u"向您报名!"
                    message_content = teacher.name + u"向您报名!请到“我的老师”处查看详细信息!"
                    #新建消息
                    message = Message(sender=user, receiver=pd[0].wechat,message_title=message_title, message_content=message_content,status=0)
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
                    order = OrderApply.objects.get(apply_type=1, pd=pd[0],tea=teacher)
                    # order.finished = 1
                    # order.save()
                    order.delete()
                    message_title = teacher.name + u"取消了报名!"
                    message_content = teacher.name + u"取消了报名!"
                    #新建消息
                    message = Message(sender=user, receiver=teacher.wechat, message_title=message_title, message_content=message_content,status=0)
                    message.save()
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
    #查找家长订单
    #TODO： 每个家长是否只有一个需求
    parentorders = user.parentorder_set.all()
    #查找教师
    teachers = Teacher.objects.filter(tea_id=tea_id)
    if len(parentorders) and len(teachers):
        parentorder = parentorders[0]
        teacher = teachers[0]
        if method == 1 :
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
                                       pass_not=1,update_time=timezone.now(),finished=0)
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
                    order = OrderApply.objects.get(apply_type=2, pd=parentorder,tea=teacher)
                    order.delete()
                    # order.finished = 1
                    # order.save()
                    message_title = parentorder.name + u"取消了邀请!"
                    message_content = parentorder.name + u"取消了邀请!"
                    #新建消息
                    message = Message(sender=user, receiver=teacher.wechat, message_title=message_title, message_content=message_content,status=0)
                    message.save()
                    #TODO:推送到微信端

            except Exception,e:
                return JsonError(e.message)
            return JsonResponse()
    else:
        return JsonError(u"不存在家长订单或老师!")

@login_required()
@api_view(['GET'])
@authentication_classes((CsrfExemptSessionAuthentication, BasicAuthentication))
def getWechatInfo(request):
    return Response(request.session.get("info",None))

@login_required()
@api_view(['GET','POST'])
@authentication_classes((CsrfExemptSessionAuthentication, BasicAuthentication))
def handleSalary(request):
    if request.method == "GET":
        salary = Config.objects.get(key='salary')
        result = {'value': salary.value}
        return JsonResponse(result)
    elif request.method == "POST":
        salary = Config.objects.get(key='salary')
        value = request.data.get('value', None)
        print value
        if value:
            salary.value = value
            salary.save()
            return JsonResponse()
    return JsonError('出错了！')
