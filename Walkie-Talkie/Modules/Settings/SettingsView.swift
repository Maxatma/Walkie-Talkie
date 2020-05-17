//
//  SettingsView.swift
//  Walkie-Talkie
//
//  Created by Zaporozhchenko Oleksandr on 5/5/20.
//  Copyright © 2020 maxatma. All rights reserved.
//

import Bond


final class SettingsView: BondView {
    var vm: SettingsVM {
        return viewModel as! SettingsVM
    }
    @IBOutlet var microphone: OnOffButton!
    @IBOutlet var sound: OnOffButton!
    @IBOutlet var video: OnOffButton!
    @IBOutlet var hangup: UIButton!
    
    override func advise() {
        super.advise()
        microphone.isOn.bind(to: vm.microphone).dispose(in: bag)
        sound.isOn.bind(to: vm.sound).dispose(in: bag)
        video.isOn.bind(to: vm.video).dispose(in: bag)
        hangup.reactive.tap.bind(to: vm.hangup).dispose(in: bag)
    }
}


@IBDesignable
final class OnOffButton: BondButton {
    @IBInspectable var on: UIImage!
    @IBInspectable var off: UIImage!
    
    let isOn = Observable<Bool>(true)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        reactive.tap.map { [unowned self] _ in !self.isOn.value }.bind(to: isOn).dispose(in: bag)
        isOn.map { [unowned self] value in value ? self.on : self.off }.bind(to: reactive.image).dispose(in: bag)
    }
    
    override func advise() {
        super.advise()
    }
}

