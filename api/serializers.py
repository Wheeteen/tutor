#!/usr/bin/env python
# -*- coding:utf-8 -*-
__author__ = 'youmi'
from rest_framework import serializers
from api.models import Teacher,ParentOrder,OrderApply

class TeacherSerializer(serializers.ModelSerializer):
    class Meta:
        model = Teacher
        fields = '__all__'

class ParentOrderSerializer(serializers.ModelSerializer):
    class Meta:
        model = ParentOrder
        fields = '__all__'
    parent_willing = serializers.IntegerField(read_only=True)   #读取家长列表时对应该教师的处理意愿

