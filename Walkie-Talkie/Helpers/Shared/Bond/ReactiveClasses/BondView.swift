//
//  BondView.swift
//
//
//  Created by Alexander Zaporozhchenko on 1/1/17.
//  Copyright © 2017 Alexander Zaporozhchenko. All rights reserved.
//

import Bond
import SnapKit
import IQKeyboardManagerSwift


class XibLoadedView: UIView {
    
    func xibSetup() {
        let view = self.loadFromNib()
        self.addSubview(view)
        view.snp.makeConstraints { make -> Void in
            make.edges.equalTo(self)
        }
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    var nibname: String {
        return String(describing: type(of: self))
    }
    
    func loadFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib    = UINib(nibName: nibname, bundle: bundle)
        let view   = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.xibSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.xibSetup()
    }
}

class BondView: XibLoadedView, BondViewProtocol {
    var _viewModel: BondVMProtocol?
    
    var viewModel: BondVMProtocol? {
        get {
            return _viewModel
        }
        set(newViewModel) {
            if _viewModel !== newViewModel {
                unadvise()
                _viewModel = newViewModel
                if _viewModel != nil {
                    advise()
                }
            }
        }
    }
    
    deinit {
        viewModel = nil
    }
    
    // called to dispose binds needed for view
    
    func unadvise() {
        bag.dispose()
        let views = subviews.compactMap { $0 as? BondView }
        for view in views {
            view.viewModel = nil
        }
    }
    
    // called to bind needed for view
    
    func advise() {}
}


protocol BondViewProtocol {
    var _viewModel: BondVMProtocol? { get set }
    var viewModel: BondVMProtocol? { get set }
    func advise()
    func unadvise()
}

extension BondViewProtocol where Self: UIView {
    var viewModel: BondVMProtocol? {
        get {
            return _viewModel
        }
        mutating set(newViewModel) {
            if _viewModel !== newViewModel {
                unadvise()
                _viewModel = newViewModel
                if _viewModel != nil {
                    advise()
                }
            }
        }
    }

    func unadvise() {
        bag.dispose()
        let views = subviews.compactMap { $0 as? BondView }
        for view in views {
            view.viewModel = nil
        }
    }
}

class BondButton: UIButton, BondViewProtocol {
    var _viewModel: BondVMProtocol?
    
    var viewModel: BondVMProtocol? {
        get {
            return _viewModel
        }
        set(newViewModel) {
            if _viewModel !== newViewModel {
                unadvise()
                _viewModel = newViewModel
                if _viewModel != nil {
                    advise()
                }
            }
        }
    }
    
    deinit {
        viewModel = nil
    }
    
    // called to dispose binds needed for view
    
    func unadvise() {
        bag.dispose()
        let views = subviews.compactMap { $0 as? BondView }
        for view in views {
            view.viewModel = nil
        }
    }
    
    // called to bind needed for view
    
    func advise() {}
}
