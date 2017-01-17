#!/usr/bin/env python
# -*- coding:utf-8 -*-
__author__ = 'youmi'
from django.conf.urls import url
from wechat_auth import views
urlpatterns = [
    url(r'^index', views.index),
    url(r'^login_from_pwd/(?P<id>.*?$)', views.login_from_pwd),
    # url(r'^loginSuc', views.loginSuc),
    url(r'^authorization', views.authorization),
]
