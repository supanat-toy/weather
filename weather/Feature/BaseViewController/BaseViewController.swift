//
//  BaseViewController.swift
//  weather
//
//  Created by Supanat on 3/11/2563 BE.
//

import UIKit

class BaseViewController: ViewController {
    
    let alertLoadingView = UINib(nibName: LoadingView.identifier, bundle: .main).instantiate(withOwner: nil, options: nil).first as? LoadingView
    
    func showLoadingView() {
        if let view = alertLoadingView {
            view.setTitle(title: "Loading...")
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn, animations: {
                view.frame = self.view.bounds
                self.view.addSubview(view)
            })
        }
    }
    
    func dismissLoadingView(completion: @escaping (() -> Void)) {
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
            self.alertLoadingView?.removeFromSuperview()
        }, completion: { _ in
            completion()
        })
    }
    
    func alertError(code: String?, message: String) {
        alert(title: code ?? "", message: message)
    }
    
    func alert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        alertController.present(animated: true, completion: nil)
    }
}
