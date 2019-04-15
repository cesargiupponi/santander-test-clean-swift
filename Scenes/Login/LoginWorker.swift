//
//  LoginWorker.swift
//  santander-test-clean-swift
//
//  Created by Cesar Giupponi Paiva on 12/04/19.
//  Copyright (c) 2019 Cesar Paiva. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

class LoginWorker {
    
    let url: String = "https://bank-app-test.herokuapp.com/api/login"
    
    func requestLogin(user: String, password: String, responseData: @escaping(_ response: LoginModel.Data.Response,  _ errorResponse: Error) -> ()) {
        let user: [String: String] = ["user": user, "password": password]
        let service: Service<LoginModel.Data.Response> = Service(url: self.url)
        service.request(httpMethod: HttpMethod.POST.rawValue, parameters: user, completion: { (response) in
            if let userAccount = response.userAccount {
                responseData(LoginModel.Data.Response(userAccount: userAccount, error: nil), Error())
            }
            
            if let error = response.error {
                responseData(LoginModel.Data.Response(), error)
            }
            
        }) { (failure) in
            print("error", failure)
        }
  }
}
