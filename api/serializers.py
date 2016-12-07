#!/usr/bin/env python
# -*- coding:utf-8 -*-
__author__ = 'youmi'
from rest_framework import serializers
from tutor.models import Teacher,ParentOrder,OrderApply

class TeacherSerializer(serializers.ModelSerializer):
    class Meta:
        model = Teacher
        fields = ('tea_id', 'wechat_id', 'name', 'qualification', 'sex', 'native_place')