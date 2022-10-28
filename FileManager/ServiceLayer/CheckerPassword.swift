//
//  CheckerPassword.swift
//  FileManager
//
//  Created by Александр Хмыров on 27.10.2022.
//

import Foundation
import KeychainSwift



class CheckerPassword {



    static func checkPassword(password: String, passwordCorrect completion: @escaping (Bool) -> Void) {

        if KeychainSwift().get("password") == password {
            completion(true)
        }
        else {
            completion(false)
        }

    }



}
