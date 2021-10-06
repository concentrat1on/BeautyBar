//
//  AddServiceViewModel.swift
//  BeautyBar
//
//  Created by Илья on 29.09.2021.
//

import Foundation
import UIKit

struct AddServiceViewModel {
    
    var image = UIImage(named: "Camera")!
    var title = ""
    var price = ""
    var city = ""
    var service = ""
    var phoneNumber = ""
    var email = ""
    var text = ""
    let citySelection = ["Киев", "Днепр"]
    let serviceSelection = ["MakeUp", "Ногти", "Прическа мужская", "Прическа женская"]
    
    func isEmpty(field: String) -> Bool {
        return field.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var isFieldsFilled: Bool {
        if image == UIImage(named: "Camera") ||
            isEmpty(field: title) ||
            isEmpty(field: city) ||
            isEmpty(field: text) ||
            isEmpty(field: service) ||
            isEmpty(field: price) ||
            isEmpty(field: phoneNumber) {
            return false
        } else { return true }
    }
    
    
}
