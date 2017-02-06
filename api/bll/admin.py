#!/usr/bin/env python
# -*- coding:utf-8 -*-
import time

__author__ = 'yinzishao'

from rest_framework.decorators import api_view,authentication_classes,permission_classes
from api.serializers import OrderApplySerializer,ParentOrderSerializer,TeacherSerializer,FeedbackSerializer
from django.contrib.auth.decorators import login_required
from rest_framework.response import Response
from tutor.http import JsonResponse,JsonError
from api.models import Teacher,AuthUser,ParentOrder,OrderApply,Message,Config,Feedback
from django.db import transaction
from wechat_auth.helpers import changeSingleBaseToImg,getParentOrderObj,changeTime,getTeacherObj
from rest_framework.authentication import SessionAuthentication, BasicAuthentication
from rest_framework.permissions import IsAdminUser
from wechat_auth.helpers import changeBaseToImg,changeObejct,getParentOrderObj,getTeacherObj,changeTime
class CsrfExemptSessionAuthentication(SessionAuthentication):
    def enforce_csrf(self, request):
        return  # To not perform the csrf check previously happening


@login_required()
@api_view(['GET'])
@authentication_classes((CsrfExemptSessionAuthentication, BasicAuthentication))
@permission_classes((IsAdminUser,))
def getNum(request):
    """
    get获取家长和老师的数目
    :param request:
    :return:
    """
    teacherNum = Teacher.objects.count()
    parentNum = ParentOrder.objects.count()
    return JsonResponse({
        "teacherNum":teacherNum,
        "parentNum":parentNum
    })

@login_required()
@api_view(['POST'])
@authentication_classes((CsrfExemptSessionAuthentication, BasicAuthentication))
@permission_classes((IsAdminUser,))
def deleteUser(request):
    """
    删除用户
    :param request: {"id":1,"user":"parent/teacher"}
    :return:
    """
    #TODO：删除外键约束
    userType = request.data.get('user',None)
    id = request.data.get('id',None)
    if userType == "parent":
        obj = ParentOrder.objects.filter(pd_id=id)
    elif userType == "teacher":
        obj = Teacher.objects.filter(tea_id=id)
    else:
        return JsonError(u"输入数据的user值不对")
    if len(obj):
        obj[0].delete()
    else:
        return JsonError(u"找不到该用户")
    return JsonResponse()

@login_required()
@api_view(['POST'])
@authentication_classes((CsrfExemptSessionAuthentication, BasicAuthentication))
@permission_classes((IsAdminUser,))
def getInfo(request):
    """
    获取某个家长或者老师的信息
    :param request:
    {
      "id":1,
      "format":true/false,
      "user":"parent/teacher"
    }
    :return:
    """
    id = request.data.get('id',None)
    format = request.data.get('format',None)
    userType = request.data.get('user',None)
    if userType == "parent":
        pds = ParentOrder.objects.filter(pd_id = id)
        if len(pds):
            serializer = ParentOrderSerializer(pds[0])
            result = serializer.data
        else:
            return JsonError("not found")
        if format:
            getParentOrderObj(result)
        else:
            changeTime(result)
    elif userType == "teacher":
        teas = Teacher.objects.filter(tea_id=id)
        if len(teas):
            serializer = TeacherSerializer(teas[0])
            result = serializer.data
        else:
            return JsonError("not found")
        if format:
            getTeacherObj(result)
        else:
            changeTime(result)
    else:
        return JsonError(u"输入数据的user值不对")
    return JsonResponse(result)

@login_required()
@api_view(['POST'])
@authentication_classes((CsrfExemptSessionAuthentication, BasicAuthentication))
@permission_classes((IsAdminUser,))
def updateInfo(request):
    """
    更新某个家长或者老师用户信息
    :param request:
    {
      "id":1,
      "userInfo":{"name":"管理员修改过"},
      "user":"parent/teacher"
    }
    :return:
    """
    id = request.data.get('id',None)
    userType = request.data.get('user',None)
    temp = request.data.dict()  if (type(request.data.get('userInfo', {})) != type({})) else request.data.get('userInfo', {})
    now = time.strftime('%Y-%m-%d %H:%M:%S',time.localtime(time.time()))
    changeObejct(temp)
    if userType == "parent":
        temp['update_time']= now
        resNum = ParentOrder.objects.filter(pd_id = id).update(**temp)
    elif userType == "teacher":
        resNum = Teacher.objects.filter(tea_id = id).update(**temp)
    else:
        return JsonError(u"输入数据的user值不对")
    if resNum == 1:
        return JsonResponse()
    else:
        return JsonError("not found")

@login_required()
@api_view(['POST'])
@authentication_classes((CsrfExemptSessionAuthentication, BasicAuthentication))
@permission_classes((IsAdminUser,))
def getOrders(request):
    """
    获取某个家长或者老师用户订单信息
    :param request:{"id":1,"user":"parent/teacher","start":0,"size":6}
    :return:
    """
    id = request.data.get('id',None)
    userType = request.data.get('user',None)
    size = int(request.data.get("size",0))
    start = int(request.data.get("start",0)) * size
    if userType == "parent":
        oas = OrderApply.objects.filter(pd_id=id)[start:start+size]
        #家长的订单详情
        results = []
        for oa in oas:
            oa.name= oa.tea.name
            if oa.apply_type == 2:
                oa.type = "parent"
                if oa.finished == 0:
                    if oa.teacher_willing == 1:
                        oa.result = u"您已邀请"
                    elif oa.teacher_willing == 2:
                        oa.result = u"管理员审核中"
                if oa.finished == 1:
                    if oa.teacher_willing == 0:
                        oa.result = u"老师已拒绝"
                    if oa.teacher_willing == 2:
                        oa.result = u"已成交"
            elif oa.apply_type == 1:
                oa.type = "teacher"
                if oa.finished == 0:
                    if oa.parent_willing == 1:
                        oa.result = u"向您报名"
                    elif oa.parent_willing == 2 and oa.teacher_willing == 1:
                        oa.result = u"您已同意"
                    elif oa.parent_willing == 2 and oa.teacher_willing == 2:
                        oa.result = u"管理员审核中"
                if oa.finished == 1:
                    if oa.parent_willing == 0:
                        oa.result = u"已拒绝"
                    elif oa.parent_willing == 2:
                        oa.result = u"已成交"
        return Response(OrderApplySerializer(oas,many=True).data)
    elif userType == "teacher":
        oas = OrderApply.objects.filter(tea_id=id)[start:start+size]
        results = []
        for oa in oas:
            oa.name= oa.pd.name
            if oa.apply_type == 2:
                oa.type = "parent"
                if oa.finished == 0:
                    if oa.teacher_willing == 1:
                        oa.result = u"对方已邀请"
                    elif oa.teacher_willing == 2:
                        oa.result = u"请上传截图"
                if oa.finished ==1:
                    if oa.teacher_willing == 0:
                        oa.result = u"您已拒绝"
                    if oa.teacher_willing == 2:
                        oa.result = u"已成交"
            elif oa.apply_type == 1:
                oa.type = "teacher"
                if oa.finished == 0:
                    if oa.parent_willing == 1:
                        oa.result = u"您已报名"
                    elif oa.parent_willing == 2 and oa.teacher_willing == 1:
                        oa.result = u"对方已同意"
                    elif oa.parent_willing == 2 and oa.teacher_willing ==2:
                        oa.result = u"请上传截图"
                if oa.finished == 1:
                    if oa.parent_willing == 0:
                        oa.result = u"家长已拒绝"
                    elif oa.parent_willing == 2 and oa.teacher_willing == 0:
                        oa.result = u"您未按时上传截图"
                    elif oa.parent_willing == 2:
                        oa.result = u"已成交"
        return Response(OrderApplySerializer(oas,many=True).data)
    else:
        return JsonError(u"输入数据的user值不对")

@login_required()
@api_view(['POST'])
@authentication_classes((CsrfExemptSessionAuthentication, BasicAuthentication))
@permission_classes((IsAdminUser,))
def setHot(request):
    """
    设置某个老师为热门或者非热门
    :param request:
    :return:
    """
    id = request.data.get('id',None)
    userType = request.data.get('user',None)
    method = request.data.get('type',None)
    if userType == "parent":
        if method:
            #设为热门
            resNum = ParentOrder.objects.filter(tea_id = id).update(hot_not=1)
        else:
            resNum = ParentOrder.objects.filter(tea_id = id).update(hot_not=0)
    elif userType == "teacher":
        if method:
            #设为热门
            resNum = Teacher.objects.filter(tea_id = id).update(hot_not=1)
        else:
            resNum = Teacher.objects.filter(tea_id = id).update(hot_not=0)
    else:
        return JsonError(u"输入数据的user值不对")
    if resNum == 1:
        return JsonResponse()
    else:
        return JsonError("not found")

@login_required()
@api_view(['POST'])
@authentication_classes((CsrfExemptSessionAuthentication, BasicAuthentication))
@permission_classes((IsAdminUser,))
def setPass(request):
    """
    审核某个家长或老师简历，是否通过
    :param request:
    {
      "id":1,
      "type":0,
      "user":"parent"
    }
    :return:
    """
    id = request.data.get('id',None)
    method = request.data.get('type',None)
    userType = request.data.get('user',None)
    if userType == "parent":
        if method:
            resNum = ParentOrder.objects.filter(pd_id = id).update(pass_not=2)
        else:
            resNum = ParentOrder.objects.filter(pd_id = id).update(pass_not=0)
    elif userType == "teacher":

        #TODO:消息通知？
        if method:
            resNum = Teacher.objects.filter(tea_id = id).update(pass_not=2)
        else:
            resNum = Teacher.objects.filter(tea_id = id).update(pass_not=0)
    if resNum == 1:
        return JsonResponse()
    else:
        return JsonError("not found")

@login_required()
@api_view(['POST'])
@authentication_classes((CsrfExemptSessionAuthentication, BasicAuthentication))
@permission_classes((IsAdminUser,))
def getCheckList(request):
    """
    获取审核页面的信息
    :param request:
    :return:
    """
    selected = request.data.get('selected',None)    #当为1时：简历投递, 2：家长需求  3：简历修改
    format = request.data.get('format',None)
    size = int(request.data.get("size",0))
    start = int(request.data.get("start",0)) * size
    if selected == 1:
        pds = ParentOrder.objects.filter(pass_not = 1)[start:start+size]
        serializer = ParentOrderSerializer(pds,many=True)
        result = serializer.data
        if format:
            getParentOrderObj(result,many=True)
        else:
            for res in result:
                changeTime(res)
    elif selected == 2:
        teas = Teacher.objects.filter(pass_not = 1)[start:start+size]
        serializer = TeacherSerializer(teas,many=True)
        result = serializer.data
        if format:
            getTeacherObj(result,many=True)
        else:
            for res in result:
                changeTime(res)
    elif selected == 3:
        pds = ParentOrder.objects.filter(pass_not = 2)[start:start+size]
        serializer = ParentOrderSerializer(pds,many=True)
        result = serializer.data
        if format:
            getParentOrderObj(result)
        else:
            for res in result:
                changeTime(res)
    else:
        return JsonError(u"传入的数据有误")
    return JsonResponse(result)
@login_required()
@api_view(['POST'])
@authentication_classes((CsrfExemptSessionAuthentication, BasicAuthentication))
@permission_classes((IsAdminUser,))
def changeText(request):
    """
    修改系统配置的文本
    :return:
    """
    data = request.data
    try:
        with transaction.atomic():
            for k in data.keys():
                Config.objects.filter(key=k).update(value=data[k])
    except Exception,e:
        return JsonError(e.message)
    return JsonResponse()

@login_required()
@api_view(['POST'])
@authentication_classes((CsrfExemptSessionAuthentication, BasicAuthentication))
@permission_classes((IsAdminUser,))
def getDoneList(request):
    """
    获取成交记录页面
    :param request:
    :return:
    """
    size = int(request.data.get("size",0))
    start = int(request.data.get("start",0)) * size
    oas = OrderApply.objects.filter(teacher_willing=2,parent_willing=2)[start:start+size]
    for oa in oas:
        oa.name= oa.tea.name
        oa.pd_name= oa.pd.name
        if oa.finished == 0:
            oa.result = u"未处理"
        elif oa.finished == 1:
            oa.result = u"已成交"
    return Response(OrderApplySerializer(oas,many=True).data)

@login_required()
@api_view(['POST'])
@authentication_classes((CsrfExemptSessionAuthentication, BasicAuthentication))
@permission_classes((IsAdminUser,))
def sendPhone(request):
    """
    发送联系方式给某个老师
    :param request:{"tea_id":1,"tel":18812345678,"oa_id":3}
    :return:
    """
    tea_id = request.data.get('tea_id',None)
    oa_id = request.data.get('oa_id',None)
    tel = request.data.get('tel',None)
    teas = Teacher.objects.filter(tea_id=tea_id)
    oas = OrderApply.objects.filter(oa_id=oa_id)
    user = AuthUser.objects.get(username=request.user.username)
    if len(teas) and len(oas):
        tea = teas[0]
        oa = oas[0]
        message_title = u"向您发送了XX家长的联系方式！"
        message_content = u"XX家长的联系方式的" + str(tel)
        message = Message(sender=user, receiver=tea.wechat, message_title=message_title, message_content=message_content,status=0)
        message.save()
        oa.finished = 1
        oa.save()
        return JsonResponse()
    else:
        return JsonError(u"输入数据有误")

@login_required()
@api_view(['POST'])
@authentication_classes((CsrfExemptSessionAuthentication, BasicAuthentication))
@permission_classes((IsAdminUser,))
def remindFeedBack(request):
    """
    提醒某个用户提交反馈
    :param request:
    :return:
    """
    id = request.data.get('id',None)
    userType = request.data.get('user',None)
    user = AuthUser.objects.get(username=request.user.username)
    message_title = u"XX家教邀请您填写反馈意见！"
    message_content = u"XX家教邀请您填写反馈意见！"
    if userType == "parent":
        objs = ParentOrder.objects.filter(pd_id = id)
    elif userType == "teacher":
        objs = Teacher.objects.filter(tea_id = id)
    else:
        return JsonError(u"输入数据的user值不对")
    if len(objs):
        obj = objs[0]
        message = Message(sender=user, receiver=obj.wechat, message_title=message_title, message_content=message_content,status=0)
        message.save()
        return JsonResponse()
    else:
        return JsonError(u"找不到用户！")

@login_required()
@api_view(['POST'])
@authentication_classes((CsrfExemptSessionAuthentication, BasicAuthentication))
def submitFeedBack(request):
    """
    提交反馈
    :param request:
    {
        "tutorservice":"tutorService",
        "appservice":"appService",
        "rate":4
    }
    :return:
    """
    try:
        user = AuthUser.objects.get(username=request.user.username)
        data = request.data
        data['create_time'] = time.strftime('%Y-%m-%d %H:%M:%S',time.localtime(time.time()))
        data['wechat'] = user
        fb = Feedback(**data)
        fb.save()
    except Exception,e:
        return JsonError(e.message)
    return JsonResponse()

@login_required()
@api_view(['POST'])
@authentication_classes((CsrfExemptSessionAuthentication, BasicAuthentication))
@permission_classes((IsAdminUser,))
def getFeedBack(request):
    """
    查看反馈
    :param request:
    {
        "start":0,
        "size":6
    }
    :return:
    """
    size = int(request.data.get("size",0))
    start = int(request.data.get("start",0)) * size
    fbs = Feedback.objects.all()[start : start + size]
    rating = ['one','two','three','four','five']
    for fb in fbs:
        user = fb.wechat
        teacher = user.teacher_set.all()
        parent =  user.parentorder_set.all()
        if len(parent):
            fb.name = parent[0].name
        if len(teacher):
            fb.name = teacher[0].name
        rate = int(fb.rate)
        for i,v in enumerate(rating):
            if i < rate:
                setattr(fb,v,True)
            else:
                setattr(fb,v,False)
    serializer = FeedbackSerializer(fbs,many=True)
    return JsonResponse(serializer.data)
