//
//  StudentCellVM.swift
//  hpd-ios-mvvm
//
//  Created by huangpeidong on 2019/4/13.
//  Copyright © 2019 huangpeidong. All rights reserved.
//

import UIKit
import RxSwift

class StudentCellVM {
    
    private let student: Student!
    
    private let disposeBag = DisposeBag()
    
    let name: BehaviorSubject<String> = BehaviorSubject(value: "")
    let age: BehaviorSubject<String> = BehaviorSubject(value: "")
    let booksCount: BehaviorSubject<String> = BehaviorSubject(value: "")
    
    init(student: Student) {
        self.student = student
        
        name.onNext("姓名:\(student.name ?? "")")
        age.onNext("年龄:\(student.age ?? 0)")
        booksCount.onNext("书本的数量:\(student.bookCount ?? 0)")
        
        NotificationCenter.default.rx
            .notification(NSNotification.Name.addBook)
            .subscribe(onNext: { [weak self] (notification) in
                guard let `self` = self else { return }
                if let studentId = notification.object as? Int,let currentId = self.student.id {
                    if studentId == currentId {
                        self.student.bookCount = (self.student.bookCount ?? 0) + 1
                        self.booksCount.onNext("书本的数量:\(self.student.bookCount ?? 0)")
                    }
                }
            })
            .disposed(by: disposeBag)
    }
    
    func cellTap() {
        student.age = (student.age ?? 0) + 1
        age.onNext("年龄:\(student.age ?? 0)")
    }
}
