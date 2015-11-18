//
//  SettingController.swift
//  WechatArticle
//
//  Created by hwh on 15/11/17.
//  Copyright © 2015年 hwh. All rights reserved.
//

import UIKit

class SettingController: UITableViewController{

    class func Nib() -> SettingController {
        let sb = MainSB()
        return (sb.instantiateViewControllerWithIdentifier("SettingController") as? SettingController)!
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: --
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            if let _ = GetUserInfo() {
                
            }else{
                let nav = MainSB().instantiateViewControllerWithIdentifier("LoginControllerNav")
                App().window?.rootViewController?.presentViewController(nav, animated: true, completion: nil)
            }
        }
    }
}
