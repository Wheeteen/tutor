#!/usr/bin/env python
# -*- coding:utf-8 -*-
__author__ = 'yinzishao'
from django.shortcuts import render

# Create your views here.
from rest_framework.decorators import api_view
from api.serializers import TeacherSerializer,ParentOrderSerializer
from django.contrib.auth.decorators import login_required
from django.utils import timezone
from rest_framework.response import Response
from api.models import Teacher,AuthUser,ParentOrder,OrderApply
from rest_framework import status
import datetime
@login_required()
@api_view(['GET'])
def loginSuc(request):

    teachers = Teacher.objects.all()
    serializer = TeacherSerializer(teachers, many=True)
    return Response(serializer.data)

@login_required()
@api_view(['POST'])
#TODO：为家长推荐老师
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
        where = ['FIND_IN_SET('+subject+'),subject']
    #年级
    if grade:
        where = ['FIND_IN_SET('+grade+'),grade']
    teachers = Teacher.objects.extra(where=where).order_by(order)[start:start + size]
    serializer = TeacherSerializer(teachers, many=True)
    return Response(serializer.data)

@login_required()
@api_view(['POST'])
def createTeacher(request):
    """
    创建老师
    :param request:
    :return:
    """
    if request.method == 'POST':
        teacher = Teacher(**request.data)
        user = AuthUser.objects.get(username=request.user.username)
        teacher.wechat = user
        teacher.save()
    return Response("")

@login_required()
@api_view(['POST'])
def updateTeacher(request):
    """
    修改老师
    :param request:
    :return:
    """
    user = AuthUser.objects.get(username=request.user.username)
    if request.method == 'POST':
        teacher = user.teacher_set.update(**request.data)
    return Response("更新成功")

@login_required()
@api_view(['POST'])
def createParentOrder(request):
    """
    创建家长订单
    :param request:
    :return:
    """
    if request.method == 'POST':
        po = ParentOrder(**request.data)
        user = AuthUser.objects.get(username=request.user.username)
        po.wechat = user
        po.save()
    return Response("")

@login_required()
@api_view(['POST'])
def updateParentOrder(request):
    """
    更新家长订单
    :param request:
    :return:
    """
    user = AuthUser.objects.get(username=request.user.username)
    if request.method == 'POST':
        po = user.parentorder_set.update(**request.data)
    return Response("更新成功")

@login_required()
@api_view(['POST'])
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
def applyParent(request):
    """
    老师报名家长
    :param request:
    {

    }
    :return:
    """
    #TODO:消息提醒
    #获取家长id
    pd_id = request.data.get("pd_id", None)
    user = AuthUser.objects.get(username=request.user.username)
    #查找教师
    teacher = user.teacher_set.all()[0]
    #查找家长订单
    pd = ParentOrder.objects.get(pd_id=pd_id)
    order = OrderApply(apply_type=1, pd=pd,tea=teacher,parent_willing=1,teacher_willing=2,
                       pass_not=1,update_time=timezone.now())
    order.save()
    return Response("success")

@login_required()
@api_view(['POST'])
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
    order = OrderApply(apply_type=2, pd=parentorder,tea=teacher,parent_willing=2,teacher_willing=1,
                       pass_not=1,update_time=timezone.now())
    order.save()
    return Response("success")

