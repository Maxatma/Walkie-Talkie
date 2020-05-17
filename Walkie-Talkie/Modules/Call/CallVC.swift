//
//  ViewController.swift
//  Walkie-Talkie
//
//  Created by Zaporozhchenko Oleksandr on 4/3/20.
//  Copyright © 2020 maxatma. All rights reserved.
//

import WebRTC
import PIPKit


final class CallVC: BondVC {
    var vm: CallVM {
        return viewModel as! CallVM
    }
    
    @IBOutlet var caller: WebRTCView!
    @IBOutlet var settings: SettingsView!
    
    let pipVC = PIPVideoVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        advise()
        PIPKit.show(with: pipVC)
        hideViewsWhenTappedAround()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        PIPKit.dismiss(animated: false)
    }
    
    override func advise() {
        super.advise()
        caller.videoView.vm = vm.videoVM
        settings.viewModel = vm.settingsVM
        pipVC.viewModel = vm.meVideoVM
    }
    
    @objc override func hideViews() {
        settings.alpha = settings.alpha == 0 ? 1 : 0
        pipVC.view.alpha = pipVC.view.alpha == 0 ? 1 : 0
    }
}

extension UIViewController {
    
    func hideViewsWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(Self.hideViews))
        tap.cancelsTouchesInView = false
        tap.numberOfTapsRequired = 1
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    
    @objc func hideViews() {
        
    }
}


extension UIViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let isControllTapped = touch.view is UIControl
        return !isControllTapped
    }
}
