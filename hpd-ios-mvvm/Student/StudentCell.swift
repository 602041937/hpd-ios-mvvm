//
//  StudentCell.swift
//  hpd-ios-mvvm
//
//  Created by huangpeidong on 2019/2/13.
//  Copyright © 2019年 huangpeidong. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class StudentCell: UITableViewCell {
    
    static let ID = "StudentCell"
    
    @IBOutlet weak var nameLB: UILabel!
    @IBOutlet weak var infoLB: UILabel!
    @IBOutlet weak var booksBtn: UIButton!
    
    var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
