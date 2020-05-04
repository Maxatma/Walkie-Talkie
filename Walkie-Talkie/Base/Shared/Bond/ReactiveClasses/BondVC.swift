//
//  BondVC.swift
//  Login
//
//  Created by Oleksandr Zaporozhchenko on 2/20/19.
//  Copyright © 2019 Oleksandr Zaporozhchenko. All rights reserved.
//

import Foundation


class BondVC: XibLoadedVC, BondViewProtocol {
    var _viewModel: BondVMProtocol?
    
    var viewModel: BondVMProtocol? {
        get {
            return _viewModel
        }
        set(newViewModel) {
            if _viewModel !== newViewModel {
                if _viewModel != nil {
                    unadvise()
                }
                _viewModel = newViewModel
                if _viewModel != nil && self.isViewLoaded {
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
    }
    
    // called to bind needed for view
    
    func advise() {}
}

import UIKit

class BondPageVC: UIPageViewController, BondViewProtocol {
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
    }
    
    
    // called to bind needed for view
    
    func advise() {}
            
}


