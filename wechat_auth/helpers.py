#!/usr/bin/env python
# -*- coding:utf-8 -*-
__author__ = 'youmi'

from wechat_sdk import WechatConf
from wechat_sdk import WechatBasic
import json
from django.conf import settings
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
    changeWeek(obj, "mon_begin")
    changeWeek(obj, "mon_end")
    changeWeek(obj, "tues_begin")
    changeWeek(obj, "tues_end")
    changeWeek(obj, "wed_begin")
    changeWeek(obj, "wed_end")
    changeWeek(obj, "thur_begin")
    changeWeek(obj, "thur_end")
    changeWeek(obj, "fri_begin")
    changeWeek(obj, "fri_end")
    changeWeek(obj, "sat_morning")
    changeWeek(obj, "sat_afternoon")
    changeWeek(obj, "sat_evening")
    changeWeek(obj, "sun_morning")
    changeWeek(obj, "sun_afternoon")
    changeWeek(obj, "sun_evening")
    if obj.has_key('salary'):
        obj['salary'] = float('%.2f' % float(obj['salary'])) if obj['salary'] != "" else 0.00
    if obj.has_key('deadline') and obj['deadline'] == "":
        del obj['deadline']
    return obj
def changeWeek(obj, time):
    if obj.has_key(time):
        m = obj.get(time, None)
        if m != "":
            obj[time] = int(m)
        else:
            del obj[time]
