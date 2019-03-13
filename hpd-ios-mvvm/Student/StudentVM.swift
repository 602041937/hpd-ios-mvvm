//
//  StudentVM.swift
//  hpd-ios-mvvm
//
//  Created by huangpeidong on 2019/2/13.
//  Copyright © 2019年 huangpeidong. All rights reserved.
//

import UIKit
import RxSwift

class StudentVM {

    var students: [BehaviorSubject<Student>] = []
    var count = 1
    let tableViewReloadData = PublishSubject<Void>()
    let goBooksController = PublishSubject<(Int,Int)>()
    
    private let disposeBag = DisposeBag()
    private var vm: StudentVM!
    
    init() {
        NotificationCenter.default.rx
            .notification(NSNotification.Name.addBook)
            .subscribe(onNext: { [weak self] (notification) in
                guard let `self` = self else { return }
                if let position = notification.object as? Int {
                    let subject = self.students[position]
                    if let student = try? subject.value() {
                        student.bookCount = (student.bookCount ?? 0) + 1
                        subject.onNext(student)
                    }
                }
            })
            .disposed(by: disposeBag)
    }
    
    func addStudent() {
        let newStudent = Student()
        newStudent.name = "dog\(count)"
        newStudent.age = count
        newStudent.bookCount = 0
        students.append(BehaviorSubject(value: newStudent))
        count = count + 1
        tableViewReloadData.onNext(())
    }
    
    func booksCountTap(index:Int) {
        print("index=\(index)")
        let subject = students[index]
        if let student = try? subject.value() {
            goBooksController.onNext((index,student.bookCount ?? 0))
        }
    }
    
    func cellTap(index:Int) {
        let subject = students[index]
        if let student = try? subject.value() {
            student.age = (student.age ?? 0) + 1
            subject.onNext(student)
        }
    }
}
