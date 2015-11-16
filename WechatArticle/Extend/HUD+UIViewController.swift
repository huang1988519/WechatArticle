//
//  UIViewControllerExtend.swift
//  WechatArticle
//
//  Created by hwh on 15/11/16.
//  Copyright © 2015年 hwh. All rights reserved.
//

import UIKit

let loadingViewTag = 100

extension UIViewController {
    func showHUD() -> LiquidLoader {
        
        let size   = CGSizeMake(80, 80)
        let center = self.view.center
        
        let loader = LiquidLoader(frame: CGRectMake(0, 0, size.width, size.height), effect: .Line(UIColor(hex: "2EA2C2")))
        loader.tag = loadingViewTag
        loader.center = center
        self.view.addSubview(loader)
        return loader
    }
    func hideHUD() {
        if let view = self.view.viewWithTag(loadingViewTag) {
            view.removeFromSuperview()
        }
    }
    func addSubViewToSelfView(view:UIView) {
        self.view.addSubview(view)
        if let view = self.view.viewWithTag(loadingViewTag) {
            self.view.bringSubviewToFront(view)
        }
    }
}
