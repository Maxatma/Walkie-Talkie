//
//  BondTableView.swift
//
//
//  Created by Alexander Zaporozhchenko on 1/1/19.
//  Copyright © 2018 Alexander Zaporozhchenko. All rights reserved.
//

import Bond

class BondTableView: UITableView {
	private var _viewModel: BondVMProtocol?

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	override init(frame: CGRect, style: UITableView.Style) {
		super.init(frame: frame, style: style)
	}

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
