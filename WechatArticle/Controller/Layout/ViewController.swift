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
    
    var hotController: HotController!
    var catogariesController: CatogariesController!
    
    static var token :dispatch_once_t = 0
    let model =  HotViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        hotController = HotController.Nib()
        catogariesController = CatogariesController.Nib()
        
        self.addChildViewController(hotController)
        self.addChildViewController(catogariesController)
        
        setUpViews()
    }
    /**
     创建视图
     */
    func setUpViews() {
        print(model)
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
        if indexPath.row == 0 {
            cell.contentView.addSubview(hotController.view)
            hotController.view.frame = cell.contentView.bounds
        }
        if indexPath.row == 1 {
            cell.contentView.addSubview(catogariesController.view)
            catogariesController.view.frame = cell.contentView.bounds
        }
        return cell
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        mCollectionView.layoutIfNeeded()
        let bodyRect = mCollectionView.frame
        
        return bodyRect.size
    }
    func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        log.debug(indexPath)
    }
}

