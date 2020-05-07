//
//  UIPageViewController+Bond.swift
//  Login
//
//  Created by Oleksandr Zaporozhchenko on 2/19/19.
//  Copyright © 2019 Oleksandr Zaporozhchenko. All rights reserved.
//

import Bond
import ReactiveKit

extension ReactiveExtensions where Base: UIPageViewController {
    public var delegate: ProtocolProxy {
        return base.reactive.protocolProxy(for: UIPageViewControllerDelegate.self, selector: NSSelectorFromString("setDelegate:"))
    }
}

