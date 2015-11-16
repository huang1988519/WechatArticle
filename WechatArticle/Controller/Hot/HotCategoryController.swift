//
//  HotCategoryController.swift
//  WechatArticle
//
//  Created by hwh on 15/11/13.
//  Copyright © 2015年 hwh. All rights reserved.
//

import UIKit
import Spring

@objc class HotCategoryController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate, UIViewControllerTransitioningDelegate,ArticleDelegate {
    let hotModel = HotViewModel()

    @IBOutlet weak var collectionView: UICollectionView!
    var resultArray :[[String:AnyObject]]?
    lazy var presentAnimation: PresentTransition = {
        return PresentTransition()
    }()
    
    
    //MARK: -
    class func Nib() -> HotCategoryController {
        return (MainSB().instantiateViewControllerWithIdentifier("HotCategoryController") as? HotCategoryController)!
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        hotModel.requestList(
            { () -> () in
                self.collectionView.showLoading()
            }) { [unowned self](result, error) -> Void in
                self.collectionView.hideLoading()
                
                if let list = result as? [[String:AnyObject]] {
                    self.resultArray = list
                    self.collectionView.reloadData()
                }
    
        }
    }
    
    var delayValue:CGFloat = 0.08
    
    //MARK: -- CollectionView Datasource & Delegate
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let node = resultArray![indexPath.row]

        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
        
        let label = cell.contentView.viewWithTag(100) as? SpringLabel
        label?.text =  node["name"] as? String
        label?.delay =  CGFloat(delayValue  * CGFloat(indexPath.row))
        label?.animate()
        
        let headerView = cell.contentView.viewWithTag(101) as? SpringView
        headerView?.delay = CGFloat(delayValue * CGFloat(indexPath.row))
        headerView?.animate()
        let RRandom = CGFloat(rand()%255)/255.0
        let GRandom = CGFloat(rand()%255)/255.0
        let BRandom = CGFloat(rand()%255)/255.0

        headerView?.backgroundColor = UIColor(red: RRandom, green: GRandom, blue: BRandom, alpha: 1)
        delay(0.3) {[unowned self] () -> () in
            self.delayValue = 0.08
        }
        
        return cell
    }
    @objc func resetDelay() {
        delayValue = 0.08
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if resultArray == nil || resultArray?.isEmpty == true {
            return 0
        }
        return resultArray!.count
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let node = resultArray![indexPath.row]
        log.debug(node)
        
        let articleVC = ArticleListController.Nib()
        articleVC.articleDelegate = self
        articleVC.transitioningDelegate = self
        articleVC.inputDic  = node
        
        self.presentViewController(articleVC, animated: true) { () -> Void in
        }

    }
    
    //MARK: -- Animatin Transition
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentAnimation.animationControllerForPresentedController(presented, presentingController: presenting, sourceController: source)
    }
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentAnimation.animationControllerForDismissedController(dismissed)
    }
    //MARK: --
    func dismissArticle() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
