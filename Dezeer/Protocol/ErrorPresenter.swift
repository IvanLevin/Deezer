//
//  ErrorPresentor.swift
//  Dezeer
//
//  Created by Levin Ivan on 11.07.2020.
//  Copyright © 2020 Levin Ivan. All rights reserved.
//

import Foundation
import UIKit
//
//protocol ErrorMessagePresentationLogic: class {
//    var errorViewController: ErrorMessageDisplayLogic? { get }
//}
//
//extension ErrorMessagePresentationLogic {
//    func presentError(_ error: AppError) {
//        errorViewController?.displayError(error)
//    }
//
//    func presentTryAgain(_ error: AppError) {
//        errorViewController?.displayTryAgain(error)
//    }
//
//    func hideTryAgain() {
//        errorViewController?.hideTryAgain()
//    }
//
//}
//
//protocol ErrorMessageDisplayLogic: class {
//}
//
//extension ErrorMessageDisplayLogic {
//
//    func displayError(_ error: AppError) {
//        Messages.shared.showErrorMessage(error.message)
//    }
//
//    func displayTryAgain(_ error: AppError) {
//        if let vc = self as? UIViewController, let view = vc.view {
//            let tryAgain = TryAgainView(view: view, tabBarVisible: vc.isTabBarVisible)
//            tryAgain.delegate = self as? TryAgainDelegate
//            tryAgain.shouldDestroyWhenHidden = true
//            tryAgain.show(type: .text(error.message))
//        }
//    }
//
//    func hideTryAgain() {
//        guard let vc = self as? UIViewController,
//            let view = vc.view,
//            let tryAgainView = view.subview(of: TryAgainView.self) else { return }
//        tryAgainView.hide()
//    }
//
//}
