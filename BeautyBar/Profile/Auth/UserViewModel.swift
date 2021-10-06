//
//  ProfileViewModel.swift
//  BeautyBar
//
//  Created by Илья on 15.08.2021.
//

import Foundation
import UIKit

struct UserViewModel {
    
    
    
    var profilePhoto = UIImage(named: "Avatar")!
    var email = ""
    var password = ""
    var confirmPassword = ""
    var city = ""
    var isWorkerBool = Bool()
    var isCompanyBool = Bool()
    var firstName = ""
    var secondName = ""
    var fullName: String {
        return ("\(firstName)  \(secondName)")
    }
    
    // MARK: Проверка полей
    
    func passwordMatch(ConfirmPassword: String) -> Bool {
        return ConfirmPassword == password
    }
    
    func isEmpty(field: String) -> Bool {
        return field.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    func isEmailValid(email: String) -> Bool {
        let emailTest = NSPredicate(format: "SELF MATCHES %@",
                                    "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        return emailTest.evaluate(with: email)
    }
    
    func isPasswordValid(password: String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@",
                                       "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$")
        return passwordTest.evaluate(with: password)
    }
    
    var isSignUpIsComplete: Bool {
        if !isEmailValid(email: email) ||
            !isPasswordValid(password: password) ||
            !passwordMatch(ConfirmPassword: confirmPassword) ||
            isEmpty(field: firstName) ||
            isEmpty(field: secondName) ||
            isEmpty(field: city) {
            return false
        } else { return true }
    }
    
    var isLogInComplete: Bool {
        if isEmpty(field: email) ||
            isEmpty(field: password) {
            return false
        } else { return true }
    }
    
    // MARK: Ошибки проверки
    
    var validEmailText: String {
        if isEmailValid(email: email) {
            return ""
        } else {
            return "Введите ваш email адрес"
        }
    }
    
    var validPasswordText: String {
        if isPasswordValid(password: password) {
            return ""
        } else {
            return "Пароль должен содержать 8 символов, минимум одно число и одну Заглавную букву"
        }
    }
    
    var validConfirmPasswordText: String {
        if passwordMatch(ConfirmPassword: confirmPassword) {
            return ""
        } else {
            return "Пароли должны совпадать"
        }
    }
    
    var validFullnameText: String {
        if !isEmpty(field: firstName) &&
            !isEmpty(field: secondName) {
            return ""
        } else {
            return "Введите ваше имя и фамилию"
        }
    }
    
    var validCityText: String {
        if !isEmpty(field: city) {
            return ""
        } else {
            return "Введите ваш город"
        }
    }
    
    var filledPhotoAndFullname: Bool {
        if isEmpty(field: firstName) ||
            isEmpty(field: secondName) ||
            profilePhoto == UIImage(named: "Avatar") {
            return false
        } else { return true }
    }    
}
