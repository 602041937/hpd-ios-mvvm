//
//  BaseViewController.swift
//  hpd-ios-mvvm
//
//  Created by huangpeidong on 2019/2/13.
//  Copyright © 2019年 huangpeidong. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    static let TAG = #file
    
    deinit {
        LogUtil.log(tag: "\(self)", message: #file)
    }
}
