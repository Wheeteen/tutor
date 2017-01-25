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
