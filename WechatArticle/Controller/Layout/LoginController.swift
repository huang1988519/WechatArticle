//
//  LoginController.swift
//  WechatArticle
//
//  Created by hwh on 15/11/18.
//  Copyright © 2015年 hwh. All rights reserved.
//

import UIKit
import AVOSCloud
import JLToast

class LoginController: UIViewController {

    @IBOutlet weak var nameTextLabel: UITextField!
    @IBOutlet weak var phoneTextLabel: UITextField!
    @IBOutlet weak var checkCodeTextLabel: UITextField!
    @IBOutlet weak var unReachButton: SwiftCountdownButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.unReachButton.setTitle("second 秒重新获取", forState: .Disabled)
        self.unReachButton.setTitle("获取验证码", forState: .Normal)
    }
    @IBAction func dismiss(sender: AnyObject) {
        self.navigationController!.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func getCheckCode(sender: AnyObject) {
        if ((phoneTextLabel.text?.isEmpty) == true) {
            alertWithMsg("手机号在哪里？？")
            return
        }
        let phone = phoneTextLabel.text
        AVUser.requestMobilePhoneVerify(phone) { [unowned self](sucess, error) -> Void in
            if sucess {

                JLToast.makeText("发送成功").show()
                self.unReachButton.countdown = true
            }else{
                JLToast.makeText("发送失败").show()
                self.unReachButton.countdown = false
            }
        }
    }
    @IBAction func Login(sender: AnyObject) {
        if nameTextLabel.text?.isEmpty == true {
            alertWithMsg("名字呢?")
            return
        }
        if ((phoneTextLabel.text?.isEmpty) == true) {
            alertWithMsg("手机号在哪里？？")
            return
        }
        if ((checkCodeTextLabel.text?.isEmpty) == true) {
            alertWithMsg("不输入验证码怎么让你过去。。。")
            return
        }
        let name = nameTextLabel.text
        let phone = phoneTextLabel.text
        
        let user = AVUser()
        user.username = name
        user.password = phone
        user.mobilePhoneNumber = phone
        
        var error :NSError?
        user.signUp(&error)
        if error != nil {
            alertWithMsg((error?.description)!)
        }
    }
}
