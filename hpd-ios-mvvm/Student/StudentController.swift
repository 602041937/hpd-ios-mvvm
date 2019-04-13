//
//  StudentController.swift
//  hpd-ios-mvvm
//
//  Created by huangpeidong on 2019/2/13.
//  Copyright © 2019年 huangpeidong. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class StudentController: BaseViewController {
    
    @IBOutlet weak var addStudentBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    private var vm: StudentVM!
    private let disposeBag = DisposeBag()
    
    static func newInstance() -> StudentController {
        let vc = UIStoryboard(name: "student", bundle: nil).instantiateViewController(withIdentifier: "StudentController") as! StudentController
        vc.vm = StudentVM()
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        TAG = "StudentController"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: StudentCell.ID, bundle: nil), forCellReuseIdentifier: StudentCell.ID)
        tableView.rowHeight = 155
        
        addStudentBtn.rx.tap.subscribe(onNext:{ [weak self] in
            self?.vm.addStudent()
        }).disposed(by: disposeBag)
        
        vm.students.subscribe(onNext:{ [weak self] (_) in
             self?.tableView.reloadData()
        }).disposed(by: disposeBag)

        vm.goBooksController.subscribe(onNext:{ [weak self](id,count) in
            self?.show(BooksController.newInstance(id: id,bookCount:count), sender: nil)
        }).disposed(by: disposeBag)
    }
}

extension StudentController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.studentCellVMs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: StudentCell.ID) as! StudentCell
        
        cell.disposeBag = DisposeBag()
    
        let studentCellVM = vm.studentCellVMs[indexPath.row]
        
        studentCellVM.name.subscribe(onNext:{ (text) in
            cell.nameLB.text = text
        }).disposed(by: cell.disposeBag)
        
        studentCellVM.age.subscribe(onNext:{ (text) in
            cell.infoLB.text = text
        }).disposed(by: cell.disposeBag)
        
        studentCellVM.booksCount.subscribe(onNext:{ (text) in
            cell.booksBtn.setTitle(text, for: .normal)
        }).disposed(by: cell.disposeBag)
        
        cell.booksBtn.rx.tap.subscribe(onNext:{[weak self] in
            self?.vm.booksCountTap(index: indexPath.row)
        }).disposed(by: cell.disposeBag)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let studentCellVM = vm.studentCellVMs[indexPath.row]
        studentCellVM.cellTap()
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
