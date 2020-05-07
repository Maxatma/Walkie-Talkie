//
//  UIScrollView+Bond.swift
//
//
//  Created by Alexandr on 1/1/19.
//  Copyright © 2017 Alexander Zaporozhchenko. All rights reserved.
//

import Bond
import ReactiveKit

extension ReactiveExtensions where Base: UIScrollView {
    public var delegate: ProtocolProxy {
        return base.reactive.protocolProxy(for: UIScrollViewDelegate.self, selector: NSSelectorFromString("setDelegate:"))
    }
}

extension UIScrollView {
    var scrolledY: SafeSignal<Float> {
        return reactive.delegate.signal(for: #selector(UIScrollViewDelegate.scrollViewDidScroll(_:))) { (subject: SafePublishSubject<Float>, scrollview: UIScrollView) in
            subject.next(Float(scrollview.contentOffset.y))
        }
    }
    
    var currentPage: SafeSignal<Int> {
        return reactive.delegate.signal(for: #selector(UIScrollViewDelegate.scrollViewDidEndDecelerating(_:))) {
            (subject: SafePublishSubject<Int>, scrollview: UIScrollView) in
            let rounded = round(scrollview.contentOffset.x / scrollview.frame.size.width)
            let page = Int(rounded)
            subject.next(page)
        }
    }
}

