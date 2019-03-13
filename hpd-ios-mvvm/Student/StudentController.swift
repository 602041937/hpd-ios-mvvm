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
        
        vm.tableViewReloadData.subscribe(onNext:{ [weak self] in
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        vm.goBooksController.subscribe(onNext:{ [weak self](index,count) in
            self?.show(BooksController.newInstance(position: index,bookCount:count), sender: nil)
        }).disposed(by: disposeBag)
    }
}

extension StudentController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: StudentCell.ID) as! StudentCell
        cell.setData(vm: self.vm, studentObservable: vm.students[indexPath.row], position: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        vm.cellTap(index: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
