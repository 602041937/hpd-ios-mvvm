//
//  PlayerController.swift
//  hpd-ios-mvvm
//
//  Created by huangpeidong on 2019/3/14.
//  Copyright © 2019年 huangpeidong. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import AVFoundation

class PlayerController: BaseViewController {
    
    private var vm: PlayerVM!
    
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var pauseBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet weak var positionLB: UILabel!
    @IBOutlet weak var stateLB: UILabel!
    
    var audioPlayer: AVAudioPlayer?
    
    static func newInstance() -> PlayerController {
        let vc = UIStoryboard(name: "player", bundle: nil).instantiateViewController(withIdentifier: "PlayerController") as! PlayerController
        vc.vm = PlayerVM()
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let data = try? Data(contentsOf: URL(string: vm.map3Url)!)
        audioPlayer = try? AVAudioPlayer(data: data!)
        audioPlayer?.volume = 1
        audioPlayer?.numberOfLoops = 0
        audioPlayer?.delegate = self
        audioPlayer?.prepareToPlay()
        
        playBtn.rx.tap.subscribe(onNext:{ [weak self] in
            guard let `self` = self else { return }
            self.audioPlayer?.play()
            self.vm.playerStatus.onNext(.play)
        }).disposed(by: disposeBag)
        
        pauseBtn.rx.tap.subscribe(onNext:{ [weak self] in
            guard let `self` = self else { return }
            self.audioPlayer?.pause()
            self.vm.playerStatus.onNext(.pause)
        }).disposed(by: disposeBag)
        
        stopBtn.rx.tap.subscribe(onNext:{ [weak self] in
            guard let `self` = self else { return }
            self.audioPlayer?.stop()
            self.vm.playerStatus.onNext(.stop)
        }).disposed(by: disposeBag)
        
        vm.playerStatus.subscribe(onNext:{ [weak self] (status: PlayerStatus) in
            guard let `self` = self else { return }
            self.playBtn.isEnabled = (status != .play)
            self.pauseBtn.isEnabled = (status != .pause)
            self.stopBtn.isEnabled = (status != .stop)
        }).disposed(by: disposeBag)
    }
}

extension PlayerController: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.vm.playerStatus.onNext(.stop)
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        self.vm.playerStatus.onNext(.stop)
    }
}

