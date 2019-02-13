//
//  BooksController.swift
//  hpd-ios-mvvm
//
//  Created by huangpeidong on 2019/2/13.
//  Copyright © 2019年 huangpeidong. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BooksController: BaseViewController {

    private var vm: BooksVM!
    @IBOutlet weak var addBookBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    private let disposeBag = DisposeBag()
    
    static func newInstance(position:Int,bookCount:Int) -> BooksController {
        let vc = UIStoryboard(name: "books", bundle: nil).instantiateViewController(withIdentifier: "BooksController") as! BooksController
        vc.vm = BooksVM(position: position,bookCount:bookCount)
        return vc
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TAG = "BooksController"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 75
        tableView.register(UINib(nibName: "BookCell", bundle: nil), forCellReuseIdentifier: BookCell.ID)
        
        addBookBtn.rx.tap.subscribe(onNext:{ [weak self]  in
            self?.vm.addBookTap()
        }).disposed(by: disposeBag)
        
        vm.tableViewReloadDataSubject.subscribe(onNext:{ [weak self] () in
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
    }
}

extension BooksController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: BookCell.ID) as! BookCell
        cell.setData(bookSubject: vm.books[indexPath.row])
        return cell
    }
}
