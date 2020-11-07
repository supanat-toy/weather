//
//  BaseViewController.swift
//  weather
//
//  Created by Supanat on 3/11/2563 BE.
//

import UIKit

class BaseViewController: ViewController {
    
    var alertLoadingView = UINib(nibName: LoadingView.identifier, bundle: .main).instantiate(withOwner: nil, options: nil).first as? LoadingView
    
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
    
    func alertError(message: String) {
        alert(title: "Error", message: message)
    }
    
    func alert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    var statusBarStyle: UIStatusBarStyle = .lightContent {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
    
    func setTapGestureKeyboard(tapView: UIView) {
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(tap))
        tapView.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func tap(gesture: UITapGestureRecognizer) {
        hideKeyboard()
    }
    
    func hideKeyboard() {
        self.view.endEditing(true)
    }
}
