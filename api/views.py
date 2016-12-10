#!/usr/bin/env python
# -*- coding:utf-8 -*-
__author__ = 'yinzishao'
from django.shortcuts import render

# Create your views here.
from rest_framework.decorators import api_view
from api.models import Teacher
from api.serializers import TeacherSerializer
from django.contrib.auth.decorators import login_required
from rest_framework.response import Response
from rest_framework import status
from api.models import AuthUser
@login_required()
@api_view(['GET'])
def loginSuc(request):

    teachers = Teacher.objects.all()
    serializer = TeacherSerializer(teachers, many=True)
    return Response(serializer.data)

@login_required()
@api_view(['GET'])
def getTeachers(request):
    teachers = Teacher.objects.all()
    serializer = TeacherSerializer(teachers, many=True)
    return Response(serializer.data)

@login_required()
@api_view(['POST'])
def createTeacher(request):
    if request.method == 'POST':
        teacher = Teacher(**request.data)
        user = AuthUser.objects.get(username=request.user.username)
        teacher.wechat = user
        teacher.save()
    return Response("")

@login_required()
@api_view(['POST'])
def updateTeacher(request):
    user = AuthUser.objects.get(username=request.user.username)
    if request.method == 'POST':
        teacher = user.teacher_set.update(**request.data)
        # teacher.update(**request.data)
    return Response("更新成功")