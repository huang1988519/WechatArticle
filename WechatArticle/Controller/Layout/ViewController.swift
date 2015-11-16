//
//  ViewController.swift
//  WechatArticle
//
//  Created by hwh on 15/11/8.
//  Copyright © 2015年 hwh. All rights reserved.
//

import UIKit
import PushKit
import SnapKit

class ViewController:
    UIViewController,MenuItemSelectDelegate{
    
    @IBOutlet weak var containerView: UIView!
    
    var hotController: HotController!
    var catogariesController: CatogariesController!
    
    static var token :dispatch_once_t = 0
    let model =  HotViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        hotController = HotController.Nib()
        catogariesController = CatogariesController.Nib()
        
        setUpViews()
    }
    // 切换到 热点视图
    func showHotController() {
        self.addChildViewController(hotController)
        containerView.addSubview(hotController.view)
        hotController.didMoveToParentViewController(self)
    }
    // 切换到 全部类目视图
    func showCategoryController() {
        self.addChildViewController(catogariesController)
        containerView.addSubview(catogariesController.view)
        catogariesController.didMoveToParentViewController(self)
    }
    /**
     创建视图
     */
    func setUpViews() {
        print(model, terminator: "")
    }
    /**
     打开左侧菜单
     
     - parameter sender: 按钮
     */
    @IBAction func click(sender: AnyObject) {
        self.slideMenuController()?.openLeft()
    }
}

