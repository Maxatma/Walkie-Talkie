//
//  Bond+TapExtensions.swift
//
//
//  Created by Alexander Zaporozhchenko on 1/1/19.
//  Copyright © 2018 Alexander Zaporozhchenko. All rights reserved.
//

import ReactiveKit
import UIKit

public extension ReactiveExtensions where Base: UIButton {
    var throttledTap: SafeSignal<()> {
		return tap.throttle(seconds: 0.5)
	}
}

public extension ReactiveExtensions where Base: UIBarButtonItem {
    var throttledTap: SafeSignal<()> {
		return tap.throttle(seconds: 0.5)
	}
}
 
