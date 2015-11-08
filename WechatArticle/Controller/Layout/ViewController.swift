//
//  ViewController.swift
//  WechatArticle
//
//  Created by hwh on 15/11/8.
//  Copyright © 2015年 hwh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MenuItemSelectDelegate{
    @IBAction func click(sender: AnyObject) {
        self.slideMenuController()?.openLeft()
    }
}

