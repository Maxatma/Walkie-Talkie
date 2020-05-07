//
//  UITableView+Bond.swift
//
//
//  Created by Alexander Zaporozhchenko on 1/1/19.
//  Copyright © 2018 Alexander Zaporozhchenko. All rights reserved.
//

import Bond
import ReactiveKit

extension UITableView {
	var selectedRow: SafeSignal<Int> {
		return reactive.delegate.signal(for: #selector(UITableViewDelegate.tableView(_:didSelectRowAt:))) { (subject: SafePublishSubject<Int>, _: UITableView, indexPath: NSIndexPath) in
			subject.next(indexPath.row)
		}
	}
}
