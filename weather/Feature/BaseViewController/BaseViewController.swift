//
//  BaseViewController.swift
//  weather
//
//  Created by Supanat on 3/11/2563 BE.
//

import UIKit

class BaseViewController: ViewController {
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
