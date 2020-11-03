//
//  UIAlertController+Extension.swift
//  weather
//
//  Created by Supanat on 3/11/2563 BE.
//

import UIKit

private var window: UIWindow!

extension UIAlertController {
    func present(animated: Bool, completion: (() -> Void)?) {
        window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UIViewController()
        window.windowLevel = .alert + 1
        window.makeKeyAndVisible()
        window.rootViewController?.present(self, animated: animated, completion: completion)
    }

    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        window = nil
    }
}
