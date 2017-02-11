#!/usr/bin/env python
# -*- coding:utf-8 -*-
__author__ = 'youmi'
from django.conf.urls import url
from api import views
from django.views.decorators.csrf import csrf_exempt
urlpatterns = [
    url(r'^loginSuc', csrf_exempt(views.loginSuc)),
    url(r'^createTeacher', csrf_exempt(views.createTeacher)),
    url(r'^updateTeacher', csrf_exempt(views.updateTeacher)),
    url(r'^updateParentOrder', csrf_exempt(views.updateParentOrder)),
    url(r'^getTeachers', csrf_exempt(views.getTeachers)),
    url(r'^getParentOrder', csrf_exempt(views.getParentOrder)),
    url(r'^createParentOrder', csrf_exempt(views.createParentOrder)),
    url(r'^applyParent', csrf_exempt(views.applyParent)),
    url(r'^inviteTeacher', csrf_exempt(views.inviteTeacher)),
    url(r'^readMessage', csrf_exempt(views.readMessage)),
    url(r'^deleteTeacher', csrf_exempt(views.deleteTeacher)),
    url(r'^getTeacherInfo', csrf_exempt(views.getTeacherInfo)),
    url(r'^getParentInfo', csrf_exempt(views.getParentInfo)),
    url(r'^deleteParent', csrf_exempt(views.deleteParent)),
    url(r'^getMsg', csrf_exempt(views.getMsg)),
    url(r'^getWechatInfo', csrf_exempt(views.getWechatInfo)),
    url(r'^getOrder', csrf_exempt(views.getOrder)),
    url(r'^handleOrder', csrf_exempt(views.handleOrder)),
    url(r'^getText', csrf_exempt(views.getText)),
    url(r'^uploadScreenshot', csrf_exempt(views.uploadScreenshot)),
    url(r'^getPayInfo', csrf_exempt(views.getPayInfo)),
    url(r'^getNum', csrf_exempt(views.getNum)),
    url(r'^setPass', csrf_exempt(views.setPass)),
    url(r'^deleteUser', csrf_exempt(views.deleteUser)),
    url(r'^getInfo', csrf_exempt(views.getInfo)),
    url(r'^updateInfo', csrf_exempt(views.updateInfo)),
    url(r'^getUserOrders', csrf_exempt(views.getOrders)),
    url(r'^setHot', csrf_exempt(views.setHot)),
    url(r'^getCheckList', csrf_exempt(views.getCheckList)),
    url(r'^changeText', csrf_exempt(views.changeText)),
    url(r'^getDoneList', csrf_exempt(views.getDoneList)),
    url(r'^sendPhone', csrf_exempt(views.sendPhone)),
    url(r'^remindFeedBack', csrf_exempt(views.remindFeedBack)),
    url(r'^submitFeedBack', csrf_exempt(views.submitFeedBack)),
    url(r'^getFeedBack', csrf_exempt(views.getFeedBack)),
    url(r'^deleteOrder', csrf_exempt(views.deleteOrder)),
    url(r'^deleteBanner', csrf_exempt(views.deleteBanner)),
]


