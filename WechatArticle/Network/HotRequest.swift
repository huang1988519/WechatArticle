//
//  HotRequest.swift
//  WechatArticle
//
//  Created by hwh on 15/11/11.
//  Copyright © 2015年 hwh. All rights reserved.
//

import UIKit

class HotRequest: Request {

    override func configRequest() {
        urlPath = Request_Path.goodArticles
    }
    override func handleResult() -> AnyObject? {
        if let _jsonObject = jsonObject {
            log.verbose(_jsonObject)
        }
        return jsonObject
    }
}
