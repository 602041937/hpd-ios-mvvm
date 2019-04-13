//
//  BookCellVM.swift
//  hpd-ios-mvvm
//
//  Created by huangpeidong on 2019/4/13.
//  Copyright © 2019 huangpeidong. All rights reserved.
//

import UIKit
import RxSwift

class BookCellVM {
    
    private var book: Book!
    let name: BehaviorSubject<String> = BehaviorSubject(value: "")

    init(book: Book) {
        self.book = book
        name.onNext(book.title ?? "")
    }
}
