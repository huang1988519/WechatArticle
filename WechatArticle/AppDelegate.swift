//
//  AppDelegate.swift
//  WechatArticle
//
//  Created by hwh on 15/11/8.
//  Copyright © 2015年 hwh. All rights reserved.
//

import UIKit
import Loggerithm
import Fabric
import Crashlytics
import AVOSCloud
import Kingfisher

var log = Loggerithm()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

        func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        config()
        
        return true
    }
//    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
//        return ShareSDK.handleOpenURL(url, wxDelegate: self)
//    }
//    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
//        return ShareSDK.handleOpenURL(url, sourceApplication: sourceApplication, annotation: annotation, wxDelegate: self)
//    }
    
    //MARK: -- 
    func config() {
        //配置log
        log.showFunctionName = true
        log.showDateTime     = false
        log.verboseColor = UIColor.darkGrayColor()
        //配置 崩溃 日志
        Fabric.with([Crashlytics.self])
        //配置 leanCloud
        AVOSCloud.setApplicationId("qfrsSEumQvfkvyR7gMSXErKg", clientKey: "nTSTQrCGKDFm9zQoexAJHhGW")
        //配置SharedSDK
//        ShareSDK.registerApp("c640d0a572fb")
        //配置缓存
        cacheManager.calculateDiskCacheSizeWithCompletionHandler { (size) -> () in
            log.debug("图片缓存已占用:\(size)")
        }
        initializePlat()
    }
    
    /**
     初始化 分享平台
     
     - returns: nil
     */
    func initializePlat() {
//        ShareSDK.connectSinaWeiboWithAppKey("", appSecret: "", redirectUri: "")
    }
}

