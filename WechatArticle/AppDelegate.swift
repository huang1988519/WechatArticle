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

var log = Loggerithm()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func config() {
        //配置log
        log.showFunctionName = true
        log.showDateTime     = false
        log.verboseColor = UIColor.darkGrayColor()
        //配置 崩溃 日志
        Fabric.with([Crashlytics.self])
        //配置 leanCloud
        AVOSCloud.setApplicationId("qfrsSEumQvfkvyR7gMSXErKg", clientKey: "nTSTQrCGKDFm9zQoexAJHhGW")
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        config()
        
        return true
    }
}

