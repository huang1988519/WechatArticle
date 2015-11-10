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
    UIViewController,MenuItemSelectDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var mCollectionView: UICollectionView!

    static var token :dispatch_once_t = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpViews()
    }
    /**
     创建视图
     */
    func setUpViews() {
    }
    /**
     打开左侧菜单
     
     - parameter sender: 按钮
     */
    @IBAction func click(sender: AnyObject) {
        self.slideMenuController()?.openLeft()
    }
    //MARK: - colectionview Datasource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
        cell.backgroundColor = UIColor.redColor()
        return cell
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        mCollectionView.layoutIfNeeded()
        let bodyRect = mCollectionView.frame
        
        return bodyRect.size
    }
}

