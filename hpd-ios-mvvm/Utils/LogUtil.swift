//
//  LogUtil.swift
//  hpd-ios-mvvm
//
//  Created by huangpeidong on 2019/2/13.
//  Copyright © 2019年 huangpeidong. All rights reserved.
//

import UIKit

class LogUtil: NSObject {

    private static let TAG = "hpd-tag-"
    
    static func log(tag:String,message:String) {
        print(TAG + tag + " " + message)
    }
}
