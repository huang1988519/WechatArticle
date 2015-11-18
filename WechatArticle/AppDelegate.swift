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
        config(launchOptions)
        
        return true
    }
    
    //MARK: -- 
    func config(launchOption: [NSObject: AnyObject]?) {
        //配置log
        log.showFunctionName = true
        log.showDateTime     = false
        log.verboseColor = UIColor.darkGrayColor()
        //配置 崩溃 日志
        Fabric.with([Crashlytics.self])
        //配置 leanCloud
        AVOSCloud.setApplicationId("qfrsSEumQvfkvyR7gMSXErKg", clientKey: "nTSTQrCGKDFm9zQoexAJHhGW")
        //配置缓存
        cacheManager.calculateDiskCacheSizeWithCompletionHandler { (size) -> () in
            log.debug("图片缓存已占用:\(size)")
        }
        //注册通知
        let types : UIUserNotificationType = [.Alert,.Sound,.Badge]
        UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes: types, categories: nil))
    }
    
}

