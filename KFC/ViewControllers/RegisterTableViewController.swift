//
//  RegisterTableViewController.swift
//  KFC
//
//  Created by Kittinun Chobtham on 3/5/2563 BE.
//  Copyright © 2563 Kittinun Chobtham. All rights reserved.
//

import UIKit

final class RegisterTableViewController: UITableViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var confirmEmailTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var eyePasswordButton: UIButton!
    @IBOutlet weak var eyeConfirmPasswordButton: UIButton!
    
    var registerAPIManager: RegisterAPIManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupData()
    }
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        tableView.endEditing(true)
    }
    private func setupView() {
        setupTextFields()
        setupGesture()
    }
    private func setupGesture(){
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        
        tableView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func hideKeyBoard () {
        tableView.endEditing(true)
    }
    private func setupTextFields() {
        let textFields = [nameTextField,
        emailTextField,
        confirmEmailTextField,
        passwordTextField,
        confirmPasswordTextField]
        
        textFields.forEach{$0?.delegate = self}
    }
    private func setupData() {
        setupRegisterService()
    }
    
    private func setupRegisterService() {
        registerAPIManager = RegisterAPIManagerImplementation()
        registerAPIManager?.setDelegate(self)
    }
    
    @IBAction func registerButtonTapped() {
        registerAPIManager?.register(optionalName: nameTextField.text,
                                     optionalEmail: emailTextField.text,
                                     optionalConfirmEmail: confirmEmailTextField.text,
                                     optionalPassword: passwordTextField.text,
                                     optionalConfirmPassword: confirmPasswordTextField.text)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true,
                completion: nil)
    }
    
    @IBAction func eyePasswordButtonTapped(_ sender: Any) {
        updatePasswordTextFieldIsSecureTextEntry()
        updateEyePasswrodButton()
    }
    
    @IBAction func eyeConfirmPasswordButtonTapped(_ sender: Any) {
        updateConfirmPasswordTextFieldIsSecureTextEntey()
        updateEyeConfirmPasswordButton()
    }
    
    private func updateEyePasswrodButton() {
        eyePasswordButton.setImage(
            eyePasswordImage(
                isSecureTextEntry: passwordTextField.isSecureTextEntry),
            for: .normal)
    }
    
    private func updateEyeConfirmPasswordButton() {
        eyeConfirmPasswordButton.setImage(eyePasswordImage(
            isSecureTextEntry: confirmPasswordTextField.isSecureTextEntry),
                                          for: .normal)
    }
    
    private func eyePasswordImage(isSecureTextEntry: Bool) -> UIImage? {
        return isSecureTextEntry
            ? UIImage(named: "button_eye") : UIImage(named: "button_eye_close")
    }
    
    private func updatePasswordTextFieldIsSecureTextEntry() {
        passwordTextField.isSecureTextEntry
            = !passwordTextField.isSecureTextEntry
    }
    
    private func updateConfirmPasswordTextFieldIsSecureTextEntey() {
        confirmPasswordTextField.isSecureTextEntry
            = !confirmPasswordTextField.isSecureTextEntry
    }
    
}

extension RegisterTableViewController: RegisterAPIManagerDelegate {
    
    func didRegisterCompletion() {
        let alertController = UIAlertController(title: "Success",
                                                message: "ลงทะเบียนเสร็จสิ้น",
                                                preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Confirm",
                                          style: .default)
        { (_) in
            self.dismiss(animated: true,
                         completion: nil)
        }
        
        alertController.addAction(confirmAction)
        
        present(alertController,
                animated: true,
                completion: nil)
    }
    
    func didRegisterFailure(error: Error) {
        let alertController = UIAlertController(title: "Warning",
                                                message: ErrorHelper.errorMessage(genernalError: error as! GeneralError),
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

extension RegisterTableViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if  textField == nameTextField {
            emailTextField.becomeFirstResponder()
        } else if textField == emailTextField{
            confirmEmailTextField.becomeFirstResponder()
        } else if textField == confirmEmailTextField{
        confirmEmailTextField.becomeFirstResponder()
        } else if textField == passwordTextField{
        passwordTextField.becomeFirstResponder()
        } else if textField == confirmPasswordTextField{
            confirmPasswordTextField.resignFirstResponder()
            
            registerButtonTapped()
        }
        
    return true
    
    }
}
