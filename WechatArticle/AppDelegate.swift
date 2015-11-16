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
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        config()

        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        let mainVC = sb.instantiateViewControllerWithIdentifier("Main")
        let menuVC = sb.instantiateViewControllerWithIdentifier("Left")
        
        let root = SlideMenuController(mainViewController: mainVC, leftMenuViewController: menuVC)
        
        self.window?.rootViewController = root
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

