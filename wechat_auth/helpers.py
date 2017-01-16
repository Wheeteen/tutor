#!/usr/bin/env python
# -*- coding:utf-8 -*-
__author__ = 'youmi'

from wechat_sdk import WechatConf
from wechat_sdk import WechatBasic
import json
from django.conf import settings

week = ["mon_begin","mon_end","tues_begin","tues_end",
            "wed_begin","wed_end","thur_begin","thur_end","fri_begin","fri_end"]
weekend = ["sat_morning","sat_afternoon","sat_evening",
               "sun_morning","sun_afternoon","sun_evening"]
def get_access_token_function():
    """ 注意返回值为一个 Tuple，第一个元素为 access_token 的值，第二个元素为 access_token_expires_at 的值 """
    with open('access_token.json', 'r') as f:
        data = json.loads(f.read())
        return (data['access_token'],data['access_token_expires_at'])


def set_access_token_function(access_token=None, access_token_expires_at=None):
    with open('access_token.json', 'r+') as f :
        data = f.read()
        d = json.loads(data)
        d["access_token"] = access_token
        d["access_token_expires_at"] = access_token_expires_at
        f.seek(0)
        f.write(json.dumps(d))


def get_jsapi_ticket_function():
    with open('access_token.json', 'r') as f:
        data = json.loads(f.read())
        return (data['jsapi_ticket'],data['jsapi_ticket_expires_at'])

def set_jsapi_ticket_function(jsapi_ticket=None, jsapi_ticket_expires_at=None):
    with open('access_token.json', 'r+') as f :
        data = f.read()
        d = json.loads(data)
        d["jsapi_ticket"] = jsapi_ticket
        d["jsapi_ticket_expires_at"] = jsapi_ticket_expires_at
        f.seek(0)
        f.write(json.dumps(d))

def sendTemplateMessage():
    token = conf.get_access_token()['access_token']
    url = "https://api.weixin.qq.com/cgi-bin/message/template/send?access_token=%s" % token
    openid = "odE4WwK3g05pesjOYGbwcbmOWTnc"
    template_id = "LUdCxE5cvGT1GI-NX8UpNFq1Ywde8H2VN_NV-AjpZCg"
    redir_url = "http://www.yinzishao.cn/login"
    abstarct = "你的报名有最新消息！ＸＸ接受／拒绝了你的报名！"
    name = "黄先生"
    telephone = "1234567890"
    date = "2016/12/22"
    post_data = {
        "touser":openid,
        "template_id":template_id,
        "url":redir_url,
        "topcolor":"#FF0000",
        "data":{
            "first": {
                "value":abstarct,
                "color":"#173177"
            },
            "keyword1":{
                "value":name,
                "color":"#173177"
            },
            "keyword2": {
                "value":telephone,
                "color":"#173177"
            },
            "keyword3":{
                "value":date,
                "color":"#173177"
            },
            "keyword4":{
                "value":"请查阅！",
                "color":"#173177"
            },
            "remark":{
                "value":"谢谢关注家教平台",
                "color":"#173177"
            }
        }
    }
    print post_data
    import requests
    requests.post(url,json=post_data)

conf = WechatConf(
    token='yinzishao',
    appid='wx6fe7f0568b75d925',
    appsecret='bb5550ec25cfdd716dcf8202ffe03eeb',
    access_token_getfunc=get_access_token_function,
    access_token_setfunc=set_access_token_function,
    jsapi_ticket_getfunc=get_jsapi_ticket_function,
    jsapi_ticket_setfunc=set_jsapi_ticket_function
)

# print conf.get_access_token()
# print conf.get_jsapi_ticket()
# import time
# jt = conf.get_jsapi_ticket()
# print jt['jsapi_ticket']
# print WechatBasic().generate_jsapi_signature(1482652615,"yinzishao","http://www.yinzishao.cn/testjs",jt['jsapi_ticket'])
# # sendTemplateMessage()
import base64
import re
import time
def changeBaseToImg(data):
    dir = settings.BASE_DIR + '/api/static/'
    result = []
    for imgData in data:
        p = r"image/(.*?);base64,(.*)"
        r = re.search(p,imgData["img"])
        type = r.group(1)
        base64Data = r.group(2)
        name = str(int(time.time() * 1000000)) + '.' + type
        path = dir+name
        print path
        with open(path, "wb") as fh:
            fh.write(base64.decodestring(base64Data))
            result.append('/static/'+name)
    return ','.join(result)

def changeObejct(obj):
    """
    兼容接受到的对象
    :param obj:
    :return:
    """
    w = week + weekend
    changeWeek(obj,w)
    print obj
    if obj.has_key('salary'):
        obj['salary'] = float('%.2f' % float(obj['salary'])) if obj['salary'] != "" else 0.00
    if obj.has_key('deadline') and obj['deadline'] == "":
        del obj['deadline']
    return obj

def getParentOrderObj(objs,many=False):

    """
    将对象转换为前端所需对象
    :param obj:
    :return:
    """
    if many:
        for obj in objs:
            changeParentOrderObj(obj)
    else:
        changeParentOrderObj(objs)
def changeParentOrderObj(obj):
    pw = obj.get('parent_willing', None)
    obj["isInvited"] = ''
    if pw:
        if pw == 1:
            obj["isInvited"] = u"已报名"
        elif pw == 2:
            obj["isInvited"] = u"已接受"
        elif pw == 0:
            obj["isInvited"] = u"已拒绝"
    #性别
    teacher_sex = obj.get('teacher_sex', 0)
    if teacher_sex == 0 or teacher_sex == None:
        obj["teacher_sex"] = u"不限"
    elif teacher_sex == 1:
        obj["teacher_sex"] = u"男"
    elif teacher_sex == 2:
        obj["teacher_sex"] = u"女"



    changeWeekToRange(obj, week)
    changeWeekEndToRange(obj, weekend)

def changeWeek(obj, times):
    for time in times:
        if obj.has_key(time):
            m = obj.get(time, None)
            if m != "":
                obj[time] = int(m)
            else:
                del obj[time]


def changeWeekToRange(obj, time):
    obj["time"]  = ""
    for index in range(0, len(time),2):
        field_name = time[index]
        if obj[field_name] != None:
            if field_name.startswith("mon"):
                date = u"一"
            if field_name.startswith("tues"):
                date = u"二"
            if field_name.startswith("wed"):
                date = u"三"
            if field_name.startswith("thur"):
                date = u"四"
            if field_name.startswith("fri"):
                date = u"五"
            start = obj.get(field_name, None)
            end = obj.get(time[index+1], None)
            obj["time"] = obj["time"] + u"星期" + date + str(start) + u"点到" + str(end) + u"点 "

def changeWeekEndToRange(obj, time):
    obj["time"] = obj.get("time", "")
    for field_name in time:
        if obj[field_name] != None:
            if field_name == "sat_morning":
                date = u"星期六早上 "
            if field_name == "sat_afternoon":
                date = u"星期六下午 "
            if field_name == "sat_evening":
                date = u"星期六晚上 "
            if field_name == "sun_morning":
                date = u"星期日早上 "
            if field_name == "sun_afternoon":
                date = u"星期日下午 "
            if field_name == "sun_evening":
                date = u"星期日晚上 "
            obj["time"] = obj["time"] + date




