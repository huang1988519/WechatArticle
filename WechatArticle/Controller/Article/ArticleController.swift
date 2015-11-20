//
//  ArticleController.swift
//  WechatArticle
//
//  Created by hwh on 15/11/13.
//  Copyright © 2015年 hwh. All rights reserved.
//

import UIKit
import Spring

class ArticleController: UIViewController ,UIWebViewDelegate,UIScrollViewDelegate{
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dismissButton: SpringButton!
    
    var inputDic : [String:AnyObject]?
    
    class func Nib() -> ArticleController{
        let sb = UIStoryboard(name: "Main", bundle: nil)
        return (sb.instantiateViewControllerWithIdentifier("ArticleController") as? ArticleController)!
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if let title = inputDic!["title"] as? String {
            titleLabel.text = title
        }
        if let _url = inputDic!["url"] as? String {
            let url = NSURL(string: _url)

            webView.loadRequest(NSURLRequest(URL: url!))
            webView.scrollView.delegate = self
        }
    }
    @IBAction func dismiss(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func showMore(sender: AnyObject) {
        let shareView = ShareViewController.Nib()
        shareView.show(self)
    }
    //MARK: -- UIWebViewDelegate
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        self.hideHUD()
    }
    func webViewDidFinishLoad(webView: UIWebView) {
        self.hideHUD()
        changeReadState()
        self.dismissButton.alpha = 1
    }
    func webViewDidStartLoad(webView: UIWebView) {
        self.showHUD()
    }
    
    //MARK: --
    func changeReadState() {
        if let id = inputDic!["id"] as? String{
            hadReadList.append(id)
//            DB.inertReadRecord(id) //暂时不使用数据库了
        }
    }
    //MARK: -- ScrollView Delegate 
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        UIView.animateWithDuration(0.5) { () -> Void in
            self.dismissButton.alpha = 1
        }
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.dismissButton.alpha = 0.1
    }
}
