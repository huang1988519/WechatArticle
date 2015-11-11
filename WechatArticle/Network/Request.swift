//
//  Request.swift
//  WechatArticle
//
//  Created by hwh on 15/11/10.
//  Copyright © 2015年 hwh. All rights reserved.
//

import UIKit
import RxSwift

enum REQUEST_TYPE: Int {
    case Get
    case Post
}
enum ResponseStatus: Int {
    case Start      //请求开始
    case Requesting //请求中。。。
    case Failed     //请求失败
    case Sucess     //请求成功
    
    case Suspend    //请求暂停
    case Resume     //请求重新开始
}
public struct Request_Path {
    static let detail_list  = "weixin_num_list"     //详情列表（关键字搜索）
    static let type_list    = "winxin_num_type"     //类型列表
    static let goodArticle  = "weixin_article_list" //精选
    static let goodArticles = "weixin_article_type" //文章_微信精选文章类别
}
public class Request: NSObject {
    private var BASEURL = "http://apis.baidu.com/showapi_open_bus/weixin/"
    var methed  = REQUEST_TYPE.Get
    public var urlPath = Request_Path.detail_list

    private var respondeData  : NSData?
    private var respondeString: String?
    internal var jsonObject    :AnyObject?
    
    internal var resultObject:AnyObject?
    
    let session = NSURLSession.sharedSession()
    var task: NSURLSessionTask?
    
    var state: Variable<ResponseStatus>?
    deinit {
        log.warning("消除")
    }
    //配置 生成 request
    func configRequest() {
        log.verbose("配置 request")
    }
    func start() {
        configRequest()
        
        let url = generateUrl()
        let request = NSMutableURLRequest(URL: NSURL(string: url!)!)
        request.addValue("9fe31d289ac7abf25244f79300c41ca4", forHTTPHeaderField: "apikey")
        request.timeoutInterval = 30
        #if DEBUG
        request.timeoutInterval = 10
        #endif

        task = session.dataTaskWithRequest(request) { [weak self](data, response, error) -> Void in
            
            let strongSelf = self
            
            if let _err = error {
                log.error(_err)
                strongSelf?.state = Variable(.Failed)
                return
            }else{
                strongSelf?.handleSucess(data!)
                strongSelf?.handleResult()
                
                strongSelf?.state = Variable(.Sucess)
            }
            
        }
        task?.resume()
        
        state = Variable(.Start)
    }
    func resume() {
        if let _task = task {
            _task.resume()
        }
    }
    func suspend() {
        if let _task = task {
            _task.suspend()
        }
    }
    func cancel() {
        if let _task = task {
            _task.cancel()
        }
        task = nil
    }
    private func handleSucess(data:NSData) {
        respondeData = data
        respondeString = NSString(data: data, encoding: NSUTF8StringEncoding) as? String

        do {
            try jsonObject = NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
            resultObject = jsonObject //默认 结果不做处理，= json object
            log.verbose("结果:\(resultObject)")
        }catch {
            log.error(error)
        }
        
    }
    //重写此方法，处理返回 结果
    func handleResult() -> AnyObject? {
        return resultObject
    }
    //MARK: -
    private func generateUrl() -> String?{
        
        let paras = parasForSelf()
        var paramsString = ""
        for (key,value) in paras {
            paramsString += "\(key)=\(value)"
            paramsString += "&"
        }
        return BASEURL + urlPath  + "?" + paramsString
    }
    private func parasForSelf() -> [String:AnyObject] {

        var count:UInt32 = 0
        let properties = class_copyPropertyList(self.classForCoder, &count)
        
        var paras = [String: AnyObject]()
        
        for var i = 0 ; i < Int(count); i++ {
            let property = properties[i]
            let key = NSString(CString: property_getName(property), encoding: NSUTF8StringEncoding)
            
            if let value = valueForKey(String(key)) {
                log.verbose("\(key) = \(value)")
                paras[String(key)] = value
            }

        }
        return paras
    }
}
