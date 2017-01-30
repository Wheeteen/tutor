#!/usr/bin/env python
# -*- coding:utf-8 -*-
__author__ = 'yinzishao'

from rest_framework.decorators import api_view,authentication_classes,permission_classes
from api.serializers import OrderApplySerializer,ParentOrderSerializer,TeacherSerializer
from django.contrib.auth.decorators import login_required
from rest_framework.response import Response
from tutor.http import JsonResponse,JsonError
from api.models import Teacher,AuthUser,ParentOrder,OrderApply,Message
from django.db import transaction
from wechat_auth.helpers import changeSingleBaseToImg,getParentOrderObj,changeTime,getTeacherObj
from rest_framework.authentication import SessionAuthentication, BasicAuthentication
from rest_framework.permissions import IsAdminUser

class CsrfExemptSessionAuthentication(SessionAuthentication):
    def enforce_csrf(self, request):
        return  # To not perform the csrf check previously happening


@login_required()
@api_view(['GET'])
@authentication_classes((CsrfExemptSessionAuthentication, BasicAuthentication))
@permission_classes((IsAdminUser,))
def getNum(request):
    """
    get获取家长和老师的数目
    :param request:
    :return:
    """
    teacherNum = Teacher.objects.count()
    parentNum = ParentOrder.objects.count()
    return JsonResponse({
        "teacherNum":teacherNum,
        "parentNum":parentNum
    })

@login_required()
@api_view(['POST'])
@authentication_classes((CsrfExemptSessionAuthentication, BasicAuthentication))
@permission_classes((IsAdminUser,))
def deleteUser(request):
    """
    删除用户
    :param request: {"id":1,"user":"parent/teacher"}
    :return:
    """
    #TODO：删除外键约束
    userType = request.data.get('user',None)
    id = request.data.get('id',None)
    if userType == "parent":
        obj = ParentOrder.objects.filter(pa_id=id)
    elif userType == "teacher":
        obj = Teacher.objects.filter(tea_id=id)
    else:
        return JsonError(u"输入数据的user值不对")
    if len(obj):
        obj[0].delete()
    else:
        return JsonError(u"找不到该用户")
    return JsonResponse()

@login_required()
@api_view(['POST'])
@authentication_classes((CsrfExemptSessionAuthentication, BasicAuthentication))
@permission_classes((IsAdminUser,))
def getInfo(request):
    """
    获取某个家长或者老师的信息
    :param request:
    :return:
    """
    id = request.data.get('id',None)
    format = request.data.get('format',None)
    userType = request.data.get('user',None)
    if userType == "parent":
        pds = ParentOrder.objects.filter(pd_id = id)
        if len(pds):
            serializer = ParentOrderSerializer(pds[0])
            result = serializer.data
        else:
            return JsonError("not found")
        if format:
            getParentOrderObj(result)
        else:
            changeTime(result)
    elif userType == "teacher":
        teas = Teacher.objects.filter(tea_id=id)
        if len(teas):
            serializer = TeacherSerializer(teas[0])
            result = serializer.data
        if format:
            getTeacherObj(result)
        else:
            changeTime(result)
    else:
        return JsonError(u"输入数据的user值不对")
    return JsonResponse(result)
