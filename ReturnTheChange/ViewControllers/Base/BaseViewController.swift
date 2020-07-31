//
//  BaseViewController.swift
//  ReturnMoney
//
//  Created by Touch on 30/7/2563 BE.
//  Copyright © 2563 Demo. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showAlert(msg: String) {
         let alert = UIAlertController(title: "", message: msg, preferredStyle: UIAlertController.Style.alert)
         alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
         self.present(alert, animated: true, completion: nil)
     }
}
