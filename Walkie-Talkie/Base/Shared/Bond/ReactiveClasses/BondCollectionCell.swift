//
//  BondCollectionCell.swift
//  Login
//
//  Created by Oleksandr Zaporozhchenko on 2/4/19.
//  Copyright © 2019 Oleksandr Zaporozhchenko. All rights reserved.
//

import Bond
import ReactiveKit

class BondCollectionCell: UICollectionViewCell {
    let onReuseBag = DisposeBag()
    
    override func prepareForReuse() {
        onReuseBag.dispose()
    }
    
    private var model: BondVMProtocol?
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var viewModel: BondVMProtocol? {
        get {
            return model
        }
        set(newViewModel) {
            if model !== newViewModel {
                unadvise()
                model = newViewModel
                if model != nil {
                    advise()
                }
            }
        }
    }
    
    deinit {
        viewModel = nil
    }
    
    // called to bind needed for cell
    func advise() {}
    
    // called to dispose binds needed for cell
    func unadvise() {
        bag.dispose()
        let views = subviews.compactMap { $0 as? BondView }
        for view in views {
            view.viewModel = nil
        }
    }
}
