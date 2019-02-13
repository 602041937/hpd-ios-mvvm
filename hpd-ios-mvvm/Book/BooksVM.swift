//
//  BooksVM.swift
//  hpd-ios-mvvm
//
//  Created by huangpeidong on 2019/2/13.
//  Copyright © 2019年 huangpeidong. All rights reserved.
//

import UIKit
import RxSwift

class BooksVM {
    
    var books:[BehaviorSubject<Book>] = []
    let tableViewReloadDataSubject = PublishSubject<Void>()

    var position:Int!
    var bookCount:Int!
    
    init(position:Int,bookCount:Int) {
        self.position = position
        self.bookCount = bookCount
        
        for i in 0..<bookCount {
            let book = Book()
            book.title = "书本\(i)"
            self.books.append(BehaviorSubject(value: book))
        }
    }
    
    func addBookTap() {
  
        let book = Book()
        book.title = "书本\(bookCount ?? 0)"
        self.books.append(BehaviorSubject(value: book))
        tableViewReloadDataSubject.onNext(())
        bookCount = bookCount + 1
        NotificationCenter.default.post(name: NSNotification.Name.addBook, object: position)
    }
}

extension NSNotification.Name {
    public static let addBook = Notification.Name("addBook")
}

