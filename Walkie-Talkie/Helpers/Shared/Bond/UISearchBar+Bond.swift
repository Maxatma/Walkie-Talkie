//
//  UISearchBar+Bond.swift
//
//
//  Created by Alexander Zaporozhchenko on 1/1/19.
//  Copyright © 2018 Alexander Zaporozhchenko. All rights reserved.
//

import Bond
import ReactiveKit

extension ReactiveExtensions where Base: UISearchBar {
	public var delegate: ProtocolProxy {
		return base.reactive.protocolProxy(for: UISearchBarDelegate.self,
                                           selector: NSSelectorFromString("setDelegate:"))
	}
}

extension UISearchBar {
	var textChanged: SafeSignal<String> {
		return reactive.delegate.signal(for: #selector(UISearchBarDelegate.searchBar(_:textDidChange:))) { (subject: SafePublishSubject<String>, _: UISearchBar, searchText: NSString) in
			subject.next(searchText as String)
		}
	}

	var textBeginEdited: SafeSignal<()> {
		return reactive.delegate.signal(for: #selector(UISearchBarDelegate.searchBarTextDidBeginEditing(_:))) { (subject: SafePublishSubject<()>, _: UISearchBar) in
			subject.next(())
		}
	}
}
