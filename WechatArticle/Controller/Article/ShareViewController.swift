//
//  ShareViewController.swift
//  WechatArticle
//
//  Created by hwh on 15/11/20.
//  Copyright © 2015年 hwh. All rights reserved.
//

import UIKit
import Spring

class ShareViewController: UIViewController {

    var parentVC : UIViewController?
    @IBOutlet weak var shareView: UIView!
    @IBOutlet weak var shareViewBottomConstant: NSLayoutConstraint!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var upCollectionView: UICollectionView!
    @IBOutlet weak var downCollectionView: UICollectionView!
    
    class func Nib() -> ShareViewController {
        let sb = MainSB().instantiateViewControllerWithIdentifier("ShareViewController")
        return (sb as? ShareViewController)!
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        insertBlurView(backView, style: .Light)
        backView.alpha = 0.5
    }
    func show(controller: UIViewController) {
        let rootViewController = controller
        parentVC = controller
        
        rootViewController.addChildViewController(self)
        let rect = rootViewController.view.bounds

        self.view.frame = rect
        backView.alpha = 0
        rootViewController.view.addSubview(self.view)
        shareViewBottomConstant.constant = -260
        self.view.layoutIfNeeded()
        
        shareViewBottomConstant.constant = 0
        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: [.CurveEaseIn], animations: { () -> Void in
            self.backView.alpha = 0.5
            self.view.layoutIfNeeded()
            
            }) { (sucess) -> Void in
                
        }
    }
    @IBAction func dismiss(sender: AnyObject) {
        if let _ = parentVC {

            shareViewBottomConstant.constant = -260
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.view.layoutIfNeeded()
                self.backView.alpha = 0
            }, completion: { (complete) -> Void in
                self.view.removeFromSuperview()
                
                if self.parentViewController != nil {
                    self.removeFromParentViewController()
                }
           })
        }
    }
    //MARK: -- Collectionview datasource & delegate
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
        if collectionView == upCollectionView {
            
        }else{
            
        }
        return cell
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView ==  upCollectionView {
            return 1
        }else{
            return 2
        }
    }
}
