//
//  ArticleController.swift
//  WechatArticle
//
//  Created by hwh on 15/11/13.
//  Copyright © 2015年 hwh. All rights reserved.
//

import UIKit


class ArticleController: UIViewController {
    @IBOutlet weak var webView: UIWebView!

    var inputDic : [String:AnyObject]?
    
    class func Nib() -> ArticleController{
        let sb = UIStoryboard(name: "Main", bundle: nil)
        return (sb.instantiateViewControllerWithIdentifier("ArticleController") as? ArticleController)!
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let _url = inputDic!["url"] as? String {
            let url = NSURL(string: _url)
            webView.loadRequest(NSURLRequest(URL: url!))
        }
    }
    @IBAction func dismiss(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
