//
//  Router.swift
//  Walkie-Talkie
//
//  Created by Zaporozhchenko Oleksandr on 4/25/20.
//  Copyright © 2020 maxatma. All rights reserved.
//

import ReactiveKit
import Bond
import IQKeyboardManagerSwift


public final class Router: NSObject {
    
    public static let shared = Router()
    
    var window: UIWindow!
    private var rootNavigation: UINavigationController!
    
    //MARK: - Initialization
    
    public override init() {
        super.init()
        
        let rootVC = MainVC()
        rootVC.viewModel = MainVM()
        rootNavigation = UINavigationController(rootViewController: rootVC)
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.previousNextDisplayMode = .alwaysShow
        IQKeyboardManager.shared.toolbarManageBehaviour = .byPosition
        IQKeyboardManager.shared.disabledDistanceHandlingClasses = [MainVC.self, CallVC.self]
        IQKeyboardManager.shared.toolbarTintColor = .black
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
    }
    
    public func configureAppearance() {
        let navigationBarAppearace          = UINavigationBar.appearance()
        navigationBarAppearace.tintColor    = .white
        navigationBarAppearace.barTintColor = UIColor(red: 0.149, green: 0.09, blue: 0.345, alpha: 1)
    }
    
    public func makeVisible()  {
        window = UIWindow()
        window!.rootViewController = rootNavigation
        window!.makeKeyAndVisible()
    }
    
    //MARK: - Routing
    
    
    //MARK: - Global
    
    public func showAlert(title: String? = "Something went wrong",
                          message: String? = "Try again") {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        let secondAction = UIAlertAction(title: "Okay",
                                         style: .default,
                                         handler: nil)
        alert.addAction(secondAction)
        self.rootNavigation.viewControllers.first!.present(alert, animated: true, completion: nil)
    }
    
    func pop() {
        rootNavigation.popViewController(animated: true)
    }
    
    func present(vc: UIViewController) {
        if let topController = UIApplication.topViewController() {
            topController.present(vc, animated: true, completion: nil)
        } else {
            print("no topViewController ")
        }
    }
    
    func presentLandscape(vc: UIViewController) {
        if UIDevice.current.orientation.isLandscape, !vc.isBeingPresented {
            present(vc: vc)
        } else {
            vc.dismiss(animated: false)
        }
    }
    
    func poptoRoot() {
        rootNavigation.popToRootViewController(animated: true)
    }
    
    func poptoVC(vcClass: AnyClass) {
        
        let controllers = rootNavigation.viewControllers
        let maybeOurs   = controllers.filter { $0.isKind(of: vcClass)}.first
        
        if let vc = maybeOurs {
            rootNavigation.popToViewController(vc, animated: true)
        }
    }
    
    func showActivity(_ items: [AnyObject]) {
        let activityVC                   = UIActivityViewController(activityItems: items, applicationActivities: nil)
        activityVC.excludedActivityTypes = [UIActivity.ActivityType.assignToContact, UIActivity.ActivityType.print]
        rootNavigation.present(activityVC, animated: true, completion: nil)
    }
    
    func push(_ controller: UIViewController) {
        rootNavigation.navigationBar.isHidden = false
        rootNavigation.pushViewController(controller, animated: true)
    }
    
    func dissmissTop()  {
        if let topController = UIApplication.topViewController() {
            topController.dismiss(animated: true, completion: nil)
        }
    }
    
    //MARK: - Global Signals
    
    func popSignal() -> SafeSignal<Void> {
        return SafeSignal<Void> { observer in
            self.pop()
            observer.next(())
            observer.completed()
            return SimpleDisposable()
        }
    }
    
    func dissmissTopSignal() -> SafeSignal<Void>  {
        
        return SafeSignal<Void> { observer in
            
            if let topController = UIApplication.topViewController() {
                topController.dismiss(animated: true, completion: nil)
            }
            
            observer.next(())
            observer.completed()
            return SimpleDisposable()
        }
    }
}


extension Router {
    func showCall(webRTCClient: WebRTCClient) {
        DispatchQueue.main.async {
            let vm = CallVM(webRTCClient: webRTCClient)
            let vc = CallVC()
            vc.viewModel = vm
            self.push(vc)
        }
    }
    
    func showSource(webRTCClient: WebRTCClient) {
        DispatchQueue.main.async {
            let vm = SourceVM(webRTCClient: webRTCClient)
            let vc = SourceVC()
            vc.viewModel = vm
            self.push(vc)
        }
    }
    
    func showContacts() {
        DispatchQueue.main.async {
            let vm = ContactsVM()
            let vc = ContactsVC()
            vc.viewModel = vm
            self.push(vc)
        }
    }
}

