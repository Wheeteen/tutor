#!/usr/bin/env python
# -*- coding:utf-8 -*-
__author__ = 'youmi'

from wechat_sdk import WechatConf
import json

def get_access_token_function():
    """ 注意返回值为一个 Tuple，第一个元素为 access_token 的值，第二个元素为 access_token_expires_at 的值 """
    with open('access_token.json', 'r') as f:
        data = json.loads(f.read())
        return (data['access_token'],data['access_token_expires_at'])


def set_access_token_function(access_token=None, access_token_expires_at=None):
    data = {
        "access_token": access_token,
        "access_token_expires_at": access_token_expires_at
    }
    with open('access_token.json',"w") as f:
        f.write(json.dumps(data))

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
)

print conf.get_access_token()

sendTemplateMessage()

