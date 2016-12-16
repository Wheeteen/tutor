#!/usr/bin/env python
# -*- coding:utf-8 -*-
__author__ = 'youmi'
from django.conf.urls import url
from api import views
urlpatterns = [
    url(r'^loginSuc', views.loginSuc),
    url(r'^createTeacher', views.createTeacher),
    url(r'^updateTeacher', views.updateTeacher),
    url(r'^getTeachers', views.getTeachers),
    url(r'^getParentOrder', views.getParentOrder),
    url(r'^createParentOrder', views.createParentOrder),
    url(r'^applyParent', views.applyParent),
    url(r'^inviteTeacher', views.inviteTeacher),
]
