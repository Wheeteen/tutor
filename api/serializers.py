#!/usr/bin/env python
# -*- coding:utf-8 -*-
__author__ = 'youmi'
from rest_framework import serializers
from api.models import Teacher,ParentOrder,OrderApply,Message

class TeacherSerializer(serializers.ModelSerializer):
    class Meta:
        model = Teacher
        fields = '__all__'
    parent_willing = serializers.IntegerField(read_only=True)   #读取家长列表时对应该教师的处理意愿

class ParentOrderSerializer(serializers.ModelSerializer):
    class Meta:
        model = ParentOrder
        fields = '__all__'
    parent_willing = serializers.IntegerField(read_only=True)   #读取家长列表时对应该教师的处理意愿


class MessageSerializer(serializers.ModelSerializer):
    class Meta:
        model = Message
        fields = '__all__'
    isDetailed = serializers.BooleanField(read_only=True, default='false')
class OrderApplySerializer(serializers.ModelSerializer):
    class Meta:
        model = OrderApply
        fields = '__all__'
