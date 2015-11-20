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
    
    class func Nib() -> ShareViewController {
        let sb = MainSB().instantiateViewControllerWithIdentifier("ShareViewController")
        return (sb as? ShareViewController)!
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        insertBlurView(shareView, style: .Light)
    }
    func show(controller: UIViewController) {
        let rootViewController = controller
        parentVC = controller
        
        rootViewController.addChildViewController(self)
        let rect = rootViewController.view.bounds
        var undisplayRect = rect
        undisplayRect.origin.y = (rect.size.height)

        self.view.frame = undisplayRect
        rootViewController.view.addSubview(self.view)
        
        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: [.CurveEaseIn], animations: { () -> Void in
            self.view.frame = rect

            }) { (sucess) -> Void in
                
        }
    }
    @IBAction func dismiss(sender: AnyObject) {
        if let controller = parentVC {
            let rect = controller.view.bounds
            var undisplayRect = rect
            undisplayRect.origin.y = (rect.size.height)
            
           UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.view.frame = undisplayRect
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
        return cell
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
}
