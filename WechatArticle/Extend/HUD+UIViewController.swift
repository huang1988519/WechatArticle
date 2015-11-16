//
//  UIViewControllerExtend.swift
//  WechatArticle
//
//  Created by hwh on 15/11/16.
//  Copyright © 2015年 hwh. All rights reserved.
//

import UIKit

extension UIViewController {
    func showHUD() -> UIViewController {
        let size   = CGSizeMake(80, 80)
        let center = self.view.center
        let loader = LiquidLoader(frame: CGRectMake(0, 0, size.width, size.height), effect: .GrowCircle(UIColor.redColor()))
        loader.center = center
        self.view.addSubview(loader)
        return self
    }
}
