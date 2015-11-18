//
//  Tool.swift
//  WechatArticle
//
//  Created by hwh on 15/11/12.
//  Copyright © 2015年 hwh. All rights reserved.
//

import UIKit
import Kingfisher
// 获取 主代理
func App() -> AppDelegate {
    return (UIApplication.sharedApplication().delegate as? AppDelegate)!
}
func MainSB() -> UIStoryboard {
    let sb = UIStoryboard(name: "Main", bundle: nil)
    return sb
}
var hadReadList = [String]() //已读列表，内存保存，退出销毁

let cacheManager = KingfisherManager.sharedManager.cache  //图片缓存

// 全局提示框
func alertWithMsg(msg: String) {
    let alert = UIAlertController(title: "提示", message: msg, preferredStyle: .Alert)
    let action = UIAlertAction(title: "确定", style: .Default) { (alert) -> Void in
        log.debug("[Alert]确定")
    }
    alert.addAction(action)
    alert.showViewController((App().window?.rootViewController)!, sender: nil)
}

//MARK: - 扩展 手写字体 
extension UIFont {
    class func handWriteFontOfSize(size: CGFloat) -> UIFont {
        let font = UIFont.systemFontOfSize(size)
        return font
    }
}

//MARK: -  登录相关
func GetUserInfo() -> AnyObject? {
    return nil
}