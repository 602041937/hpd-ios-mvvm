//
//  BookCell.swift
//  hpd-ios-mvvm
//
//  Created by huangpeidong on 2019/2/13.
//  Copyright © 2019年 huangpeidong. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class BookCell: UITableViewCell {
    
    static let ID = "BookCell"
    
    @IBOutlet weak var titleLB: UILabel!
    
    var disposeBag = DisposeBag()
}
