//
//  LoginController.swift
//  hpd-ios-mvvm
//
//  Created by huangpeidong on 2019/2/13.
//  Copyright © 2019年 huangpeidong. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginController: BaseViewController {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var nameWarnLB: UILabel!
    @IBOutlet weak var passwordWarnLB: UILabel!
    @IBOutlet weak var LoginBtn: UIButton!
    
    private let disposeBag :DisposeBag = DisposeBag()
    
    private var vm: LoginVM!
    
    static func newInstance() -> LoginController {
        let vc = UIStoryboard(name: "login", bundle: nil).instantiateViewController(withIdentifier: "LoginController") as! LoginController
        vc.vm = LoginVM()
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TAG = "LoginController"
        
        nameTF.rx.text.orEmpty.subscribe(onNext:{ [weak self] (text) in
            guard let `self` = self else { return }
            LogUtil.log(tag: self.TAG, message: "nameTF=" + text)
            self.vm.name.onNext(text)
        }).disposed(by: disposeBag)
        
        passwordTF.rx.text.orEmpty.subscribe(onNext:{ [weak self] (text) in
            guard let `self` = self else { return }
            LogUtil.log(tag: self.TAG, message: "passwordTF=" + text)
            self.vm.password.onNext(text)
        }).disposed(by: disposeBag)
        
        vm.nameWarnIsHidden.skip(1).subscribe(onNext: { [weak self] (isHidden) in
            guard let `self` = self else { return }
            LogUtil.log(tag: self.TAG, message: "nameWarnLB=\(isHidden)")
            self.nameWarnLB.isHidden = isHidden
        }).disposed(by: disposeBag)
        
        vm.paswordWarnIsHidden.skip(1).subscribe(onNext: { [weak self] (isHidden) in
            guard let `self` = self else { return }
            LogUtil.log(tag: self.TAG, message: "passwordWarnLB=\(isHidden)")
            self.passwordWarnLB.isHidden = isHidden
        }).disposed(by: disposeBag)
        
        vm.loginEnable.bind(to: LoginBtn.rx.isEnabled).disposed(by: disposeBag)
        
        vm.goStudentController.subscribe(onNext:{ () in
            UIApplication.shared.keyWindow?.rootViewController?.show(StudentController.newInstance(), sender: nil)
        }).disposed(by: disposeBag)

        LoginBtn.rx.tap.subscribe(onNext:{ [weak self] () in
            self?.vm.login()
        }).disposed(by: disposeBag)
    }
}
