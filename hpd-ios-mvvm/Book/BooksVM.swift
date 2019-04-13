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
    
    let books:BehaviorSubject<[Book]> = BehaviorSubject(value: [])
    var bookCellVMs: [BookCellVM] = []

    var id:Int!
    var bookCount:Int!
    
    init(id:Int,bookCount:Int) {
        self.id = id
        self.bookCount = bookCount
        
        for i in 0..<bookCount {
            let book = Book()
            book.title = "书本\(i)"
            
            var list = try! books.value()
            list.append(book)
            bookCellVMs.append(BookCellVM(book: book))
            books.onNext(list)
        }
    }
    
    func addBookTap() {
  
        let book = Book()
        book.title = "书本\(bookCount ?? 0)"
        
        var list = try! books.value()
        list.append(book)
        bookCellVMs.append(BookCellVM(book: book))
        books.onNext(list)
        
        bookCount = bookCount + 1
        NotificationCenter.default.post(name: NSNotification.Name.addBook, object: id)
    }
}

extension NSNotification.Name {
    public static let addBook = Notification.Name("addBook")
}

