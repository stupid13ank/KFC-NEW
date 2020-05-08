//
//  ForgotpasswordViewController.swift
//  KFC
//
//  Created by Banque's Macbook Pro on 6/5/2563 BE.
//  Copyright © 2563 Kittinun Chobtham. All rights reserved.
//

import UIKit

final class ForgotpasswordViewController: UIViewController {
    var forgotPasswordAPIManager:ForgotPasswordAPIManager?
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupData()
    }
    private func setupData() {
        forgotPasswordAPIManager = ForgotPasswordAPIManagerImplementation ()
        
        forgotPasswordAPIManager?.setDelegate(self)
    }
    @IBAction func sendForgotPassword(_ send: Any?) {
        forgotPasswordAPIManager?.sendForgotPassword(optionalEmail: emailTextField.text)
    }
    @IBAction func closeScreen(_ sender: Any?){
        dismiss(animated: true,
                completion: nil)
    }
}

extension ForgotpasswordViewController : ForgotPasswordAPIManagerDelegete {
  
    func didSendForgotPasswordCompletion() {
       let alertController = UIAlertController(title: "Success", message: "Please check email", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Confirm",
                                          style: .default)
        {(_) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(confirmAction)
        
        present(alertController,
                animated: true,
                completion: nil)
      }
    func didSendForgotPasswordFailure(error: Error) {
        let alertController = UIAlertController(title: "Warning", message: ErrorHelper.errorMessage(genernalError: error as! GeneralError),
                                                preferredStyle: .alert)
          let confirmAction = UIAlertAction(title: "Confirm",
                                            style: .cancel,
                                            handler: nil)
        
          alertController.addAction(confirmAction)
          
          present(alertController,
                  animated: true,
                  completion: nil)
      }
      
}
