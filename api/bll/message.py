#!/usr/bin/env python
# -*- coding:utf-8 -*-
__author__ = 'yinzishao'

from rest_framework.decorators import api_view,authentication_classes
from api.serializers import MessageSerializer
from django.contrib.auth.decorators import login_required
from rest_framework.response import Response
from tutor.http import JsonResponse,JsonError
from api.models import AuthUser,Message
from rest_framework.authentication import SessionAuthentication, BasicAuthentication

class CsrfExemptSessionAuthentication(SessionAuthentication):
    def enforce_csrf(self, request):
        return  # To not perform the csrf check previously happening


@login_required()
@api_view(['POST'])
@authentication_classes((CsrfExemptSessionAuthentication, BasicAuthentication))
def getMsg(request):
    """
    获取消息列表
    :param request:
    {
        "start":0,
        "size":6
    }
    :return:
    """
    size = int(request.data.get("size",0))
    start = int(request.data.get("start",0)) * size
    user = AuthUser.objects.get(username=request.user.username)
    msgs = user.receiver.all()[start:start + size]
    for msg in msgs:
        msg.isDetailed = False
    serializer = MessageSerializer(msgs, many=True)
    result = serializer.data
    for r in result:
        r["status"] = True if r["status"] else False
    return Response(result)

@login_required()
@api_view(['POST'])
@authentication_classes((CsrfExemptSessionAuthentication, BasicAuthentication))
def readMessage(request):
    """
    阅读消息，将status改为１
    :param request:
    {
        "msg_id":1
    }
    :return:
    """
    msg_id = request.data.get("msg_id", None)
    user = AuthUser.objects.get(username=request.user.username)
    msg = Message.objects.filter(msg_id=msg_id, receiver = user).update(status=1)
    return JsonResponse()
