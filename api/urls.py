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
    url(r'^getTeachers', csrf_exempt(views.getTeachers)),
    url(r'^getParentOrder', csrf_exempt(views.getParentOrder)),
    url(r'^createParentOrder', csrf_exempt(views.createParentOrder)),
    url(r'^applyParent', csrf_exempt(views.applyParent)),
    url(r'^inviteTeacher', csrf_exempt(views.inviteTeacher)),
    url(r'^readMessage', csrf_exempt(views.readMessage)),
    url(r'^getInfo', csrf_exempt(views.getInfo)),
    url(r'^deleteTeacher', csrf_exempt(views.deleteTeacher)),
]
