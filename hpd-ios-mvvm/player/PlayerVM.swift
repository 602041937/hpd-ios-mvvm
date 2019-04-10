//
//  PlayerVM.swift
//  hpd-ios-mvvm
//
//  Created by huangpeidong on 2019/3/14.
//  Copyright © 2019年 huangpeidong. All rights reserved.
//

import UIKit
import RxSwift

class PlayerVM: NSObject {
    
    private let disposeBag = DisposeBag()
    let playerStatus = PublishSubject<PlayerStatus>()
    
    let map3Url = "https://app-cdn.ieltsbro.com/uploads/app_oral_practice_comment/audio_record/1/record.mp3"
    
    override init() {
        super.init()
    
        playerStatus.subscribe(onNext:{ [weak self] (state: PlayerStatus) in
            //可能做一些统计工作
        }).disposed(by: disposeBag)
    }
}



enum PlayerStatus:Int {
    case play = 0
    case pause = 1
    case stop = 2
}
