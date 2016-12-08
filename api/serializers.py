#!/usr/bin/env python
# -*- coding:utf-8 -*-
__author__ = 'youmi'
from rest_framework import serializers
from tutor.models import Teacher,ParentOrder,OrderApply

class TeacherSerializer(serializers.ModelSerializer):
    class Meta:
        model = Teacher
        fields = ('wechat_id', 'name', 'qualification', 'sex', 'native_place','campus_major','tel','subject',
                  'place','teacher_method','score','self_comment','salary_bottom','salary_top',
                  'certificate_photo','teach_show_photo','massage_warn','create_time','pass_not')