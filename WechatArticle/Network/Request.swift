//
//  Request.swift
//  WechatArticle
//
//  Created by hwh on 15/11/10.
//  Copyright © 2015年 hwh. All rights reserved.
//

import UIKit
enum REQUEST_TYPE: Int {
    case Get
    case Post
}
enum Request_Path: String {
    case detail_list  = "weixin_num_list"     //详情列表（关键字搜索）
    case type_list    = "winxin_num_type"     //类型列表
    case goodArticle  = "weixin_article_list" //精选
    case goodArticles = "weixin_article_type" //文章_微信精选文章类别
}
class Request: NSObject {
    var BASEURL = "http://apis.baidu.com/showapi_open_bus/weixin/"
    var methed  = REQUEST_TYPE.Get
    
    var path: Request_Path?
    
}
