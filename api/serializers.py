#!/usr/bin/env python
# -*- coding:utf-8 -*-
__author__ = 'youmi'
from rest_framework import serializers
from api.models import Teacher,ParentOrder,OrderApply

class TeacherSerializer(serializers.ModelSerializer):
    class Meta:
        model = Teacher
        fields = ('tea_id', 'wechat', 'name', 'qualification', 'sex', 'native_place','campus_major','tel','subject',
                  'place','teacher_method','score','self_comment','salary_bottom','salary_top',
                  'certificate_photo','teach_show_photo','massage_warn','create_time','pass_not',
                  'mon_begin','mon_end','tues_begin','tues_end','wed_begin','wed_end','thur_begin',
                  'thur_end','fri_begin','fri_end','sat_morning','sat_afternoon','sat_evening',
                  'sun_morning','sun_afternoon','sun_evening','hot_not')

class ParentOrderSerializer(serializers.ModelSerializer):
    class Meta:
        model = ParentOrder
        fields = '__all__'

