//
//  SettingController.swift
//  WechatArticle
//
//  Created by hwh on 15/11/17.
//  Copyright © 2015年 hwh. All rights reserved.
//

import UIKit

class SettingController: UITableViewController {

    class func Nib() -> SettingController {
        let sb = MainSB()
        return (sb.instantiateViewControllerWithIdentifier("SettingController") as? SettingController)!
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
