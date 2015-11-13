//
//  ArticleListController.swift
//  WechatArticle
//
//  Created by hwh on 15/11/13.
//  Copyright © 2015年 hwh. All rights reserved.
//

import UIKit
import Spring

@objc protocol ArticleDelegate {
    func dismissArticle()
}
enum InputDictionayKeys:String {
    case ID   = "id"
    case Name = "name"
}
struct Result {
    var pageCount   = 0
    var totalNumber = 0
    var list:[[String:AnyObject]]?
}
class ArticleListController: UIViewController,UITableViewDataSource,UITableViewDelegate ,UIViewControllerTransitioningDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    weak var articleDelegate: ArticleDelegate?
    let request = ArticleListRequest()
    
    var inputDic:[String: AnyObject]?
    var resultModel = Result()
    
    lazy var presentAnimation:TransitionZoom = {
        return TransitionZoom()
    }()
    
    
    //MARK: -
    class func Nib() -> ArticleListController {
        let vc = MainSB().instantiateViewControllerWithIdentifier("ArticleListController")
        return (vc as? ArticleListController)!
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let _id = inputDic![InputDictionayKeys.ID.rawValue] as? String {
            request.typeId = Int(_id)!
        }

        request.request({ [unowned self](data) -> Void in
            log.debug(data)
            self.unpackageResult(data)
            }) { (msg) -> Void in
                alertWithMsg(msg)
        }
    }
    func unpackageResult(result:AnyObject?) {
        if let dic = result as? [String: AnyObject] {
            let pages   = dic["allPages"]
            let numbers = dic["allNum"]
            
            let lists   = dic["contentlist"]
            
            resultModel.pageCount   = (pages as? Int)!
            resultModel.totalNumber = (numbers as? Int)!
            resultModel.list        = lists as? [[String :AnyObject]]
            
            tableView.reloadData()
        }
    }
    //MARK: --
    @IBAction func goBack(sender: UIButton) {
        if let _delgate = articleDelegate {
            _delgate.dismissArticle()
        }
    }
    //MARK: --
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let node = resultModel.list![indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let label = cell.contentView.viewWithTag(100) as? UILabel
        let imageView = cell.contentView.viewWithTag(101) as? AsyncImageView
        let imageUrl  = NSURL(string: (node["contentImg"] as? String)!)
        label?.text = node["title"] as? String
        imageView?.url = imageUrl
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if resultModel.list == nil || resultModel.list?.isEmpty == true {
            return 0
        }
        return (resultModel.list?.count)!
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 250
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let node = resultModel.list![indexPath.row]
        
        let detailVC = ArticleController.Nib()
        detailVC.inputDic = node
        detailVC.transitioningDelegate = self
        self.presentViewController(detailVC, animated: true, completion: nil)
    }
    //MARK: -- Animatin Transition
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentAnimation.animationControllerForPresentedController(presented, presentingController: presenting, sourceController: source)
    }
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentAnimation.animationControllerForDismissedController(dismissed)
    }

}
