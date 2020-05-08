//
//  ForgotpasswordAPImanager.swift
//  KFC
//
//  Created by Banque's Macbook Pro on 6/5/2563 BE.
//  Copyright © 2563 Kittinun Chobtham. All rights reserved.
//

import Foundation
protocol ForgotPasswordAPIManager {
    func sendForgotPassword(optionalEmail:String?)
    func setDelegate(_ delegate: ForgotPasswordAPIManagerDelegete)
    }
protocol ForgotPasswordAPIManagerDelegete {
    func didSendForgotPasswordCompletion()
    func didSendForgotPasswordFailure(error: Error)
}
final class ForgotPasswordAPIManagerImplementation:ForgotPasswordAPIManager{
    
    var delegate: ForgotPasswordAPIManagerDelegete?
    let apiClient: ForgotPasswordAPIClient
    
    init(apiClient : ForgotPasswordAPIClient = ForgotPasswordAPIClientImplementation()) {
        self.apiClient = apiClient
    }
    func setDelegate(_ delegate: ForgotPasswordAPIManagerDelegete) {
        self.delegate = delegate
    
    }
    func sendForgotPassword(optionalEmail: String?) {
        apiClient.sendForgotPassword(optionalEmail: optionalEmail)
        {(status,optionalError) in
            if let error = optionalError{
                self.delegate?.didSendForgotPasswordFailure(error: error)
                return
            }
            
            if status {
                self .delegate?.didSendForgotPasswordCompletion()
        }
    }
}
}
