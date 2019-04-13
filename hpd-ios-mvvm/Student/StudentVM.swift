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

    let students: BehaviorSubject<[Student]> = BehaviorSubject(value: [])
    var studentCellVMs: [StudentCellVM] = []
    var count = 1

    let goBooksController = PublishSubject<(Int,Int)>()
    
    private let disposeBag = DisposeBag()
    private var vm: StudentVM!
    
    func addStudent() {
        let newStudent = Student()
        newStudent.id = count
        newStudent.name = "dog\(count)"
        newStudent.age = count
        newStudent.bookCount = 0
        
        var list = try! students.value()
        list.append(newStudent)
        
        let studentCellVM = StudentCellVM(student: newStudent)
        studentCellVMs.append(studentCellVM)
    
        students.onNext(list)
        count = count + 1
    }
    
    func booksCountTap(index:Int) {
        if let list = try? students.value() {
            let student = list[index]
            if let id = student.id,let bookCount = student.bookCount {
                goBooksController.onNext((id,bookCount))
            }
        }
    }
 
}
