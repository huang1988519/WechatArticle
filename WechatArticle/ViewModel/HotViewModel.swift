//
//  HotViewModel.swift
//  WechatArticle
//
//  Created by hwh on 15/11/11.
//  Copyright © 2015年 hwh. All rights reserved.
//

import UIKit
import RxSwift


class HotViewModel: NSObject {
    let request = HotRequest()

    override init() {
        super.init()
        
        loadViewModel()
    }
    deinit {
        log.warning("消除")
    }
    
    func loadViewModel() {
        request.start()
        
    }
}
