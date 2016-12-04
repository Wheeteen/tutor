#!/usr/bin/env python
# -*- coding:utf-8 -*-
__author__ = 'youmi'
from django.conf.urls import include, url
from auth import views
urlpatterns = [
    url(r'^index', views.index),
    url(r'^hello', views.hello),
    url(r'^login', views.login),
    url(r'^authorization', views.authorization),
]