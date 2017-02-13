#!/usr/bin/env python
# -*- coding:utf-8 -*-
__author__ = 'youmi'
from rest_framework import serializers
from api.models import Teacher,ParentOrder,OrderApply,Message,Feedback

class TeacherSerializer(serializers.ModelSerializer):
    class Meta:
        model = Teacher
        fields = '__all__'
    parent_willing = serializers.IntegerField(read_only=True)   #读取家长列表时对应该教师的处理意愿
    teacher_willing = serializers.IntegerField(read_only=True)
    isInvited = serializers.CharField(read_only=True)

class ParentOrderSerializer(serializers.ModelSerializer):
    class Meta:
        model = ParentOrder
        fields = '__all__'
    parent_willing = serializers.IntegerField(read_only=True)   #读取家长列表时对应该教师的处理意愿
    teacher_willing = serializers.IntegerField(read_only=True)
    isInvited = serializers.CharField(read_only=True)

class MessageSerializer(serializers.ModelSerializer):
    class Meta:
        model = Message
        fields = '__all__'
    isDetailed = serializers.BooleanField(read_only=True)

class FeedbackSerializer(serializers.ModelSerializer):
    class Meta:
        model = Feedback
        fields = '__all__'
    name = serializers.CharField(read_only=True)
    one = serializers.BooleanField(read_only=True)
    two = serializers.BooleanField(read_only=True)
    three = serializers.BooleanField(read_only=True)
    four = serializers.BooleanField(read_only=True)
    five = serializers.BooleanField(read_only=True)

class OrderApplySerializer(serializers.ModelSerializer):
    class Meta:
        model = OrderApply
        fields = ['oa_id','pd','tea','name','content','result','finish','type','screenshot_path','pd_name','expectation']
    name = serializers.CharField(read_only=True)
    pd_name = serializers.CharField(read_only=True)
    content = serializers.CharField(read_only=True)
    result = serializers.CharField(read_only=True)
    finish = serializers.IntegerField(read_only=True)
    type = serializers.CharField(read_only=True)
