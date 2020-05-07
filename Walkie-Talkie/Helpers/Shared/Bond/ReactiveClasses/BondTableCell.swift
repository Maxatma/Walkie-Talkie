//
//  BondTableCell.swift
//
//
//  Created by Alexander Zaporozhchenko on 1/1/19.
//  Copyright © 2017 Alexander Zaporozhchenko. All rights reserved.
//

import Bond
import ReactiveKit

class BondTableCell: UITableViewCell {

	override func prepareForReuse() {
		bag.dispose()
        advise()
	}

	private var model: BondVMProtocol?

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
