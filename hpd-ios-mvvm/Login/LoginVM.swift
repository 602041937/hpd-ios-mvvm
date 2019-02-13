//
//  LoginVM.swift
//  hpd-ios-mvvm
//
//  Created by huangpeidong on 2019/2/13.
//  Copyright © 2019年 huangpeidong. All rights reserved.
//

import UIKit
import RxSwift

class LoginVM {
    
    let name: BehaviorSubject = BehaviorSubject(value: "")
    let password: BehaviorSubject = BehaviorSubject(value: "")
    
    let nameWarnIsHidden: BehaviorSubject = BehaviorSubject(value: true)
    let paswordWarnIsHidden: BehaviorSubject = BehaviorSubject(value: true)
    let loginEnable: BehaviorSubject = BehaviorSubject(value: false)
    
    private let disposeBag = DisposeBag()
    
    init() {
        name.subscribe(onNext: { [weak self] (text) in
            self?.nameWarnIsHidden.onNext(text.count != 0)
        }).disposed(by: disposeBag)
        
        password.subscribe(onNext: { [weak self] (text) in
            self?.paswordWarnIsHidden.onNext(text.count != 0)
        }).disposed(by: disposeBag)
        
        Observable.combineLatest(name, password) { (nameTemp, passwordTemp) -> Bool in
            return nameTemp.count == 0 || passwordTemp.count == 0
            }.subscribe(onNext:{ [weak self] (enable) in
                self?.loginEnable.onNext(!enable)
            }).disposed(by: disposeBag)
    }
    
    func login() {
        if let name = try? name.value(),let password = try? password.value() {
            if name == "123456" && password == "123456" {
                UIApplication.shared.keyWindow?.rootViewController?.show(StudentController.newInstance(), sender: nil)
            }
        }
    }
}
