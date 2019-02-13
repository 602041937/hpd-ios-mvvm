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
    
    private var vm: StudentVM!
    private var disposeBag = DisposeBag()
    
    func setData(vm: StudentVM,studentObservable: BehaviorSubject<Student>,position: Int) {
        
        self.disposeBag = DisposeBag()
        
        self.vm = vm
        
        studentObservable.subscribe(onNext:{ [weak self] (student) in
            guard let `self` = self else { return }
            self.nameLB.text = "姓名:\(student.name ?? "")"
            self.infoLB.text = "年龄:\(student.age ?? 0)"
            self.booksBtn.setTitle("书本的数量:\(student.bookCount ?? 0)", for: .normal)
        }).disposed(by: disposeBag)
        
        booksBtn.rx.tap.subscribe(onNext:{[weak self] in
            self?.vm.booksCountTap(index: position)
        }).disposed(by: disposeBag)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
