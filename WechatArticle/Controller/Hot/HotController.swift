//
//  HotController.swift
//  WechatArticle
//
//  Created by hwh on 15/11/12.
//  Copyright © 2015年 hwh. All rights reserved.
//

import UIKit
import Spring

class HotController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let hotModel = HotViewModel()
    var resultArray :[[String:AnyObject]]?
    
    //MARK: -
    class func Nib() -> HotController {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        return (sb.instantiateViewControllerWithIdentifier("HotController") as? HotController)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hotModel.requestList(
            { () -> () in
                self.tableView.showLoading()
            }) { [unowned self](result, error) -> Void in
                self.tableView.hideLoading()
                
                if let list = result as? [[String:AnyObject]] {
                    self.resultArray = list
                    self.tableView.reloadData()
                }
        }
    }
    
    //MARK: - UITableView Datasource & Delegate
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let node = resultArray![indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let label = cell.contentView.viewWithTag(100) as? SpringLabel
        label?.text =  node["name"] as? String

        
        label?.delay =  CGFloat(0.1 * Double(indexPath.row))
        label?.animate()
        
        return  cell
    }
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if resultArray == nil {
            return 0
        }
        return (resultArray?.count)!
    }
}
