//
//  Model.swift
//  FormValidationWithCombineFramework
//
//  Created by alican on 24.02.2022.
//

import Foundation
import UIKit



final class FormSectionComponent : FormSectionItem, Hashable{
    let id: UUID = UUID()
    var items: [FormComponent]
    
    required init(items: [FormComponent]){
        self.items = items
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: FormSectionComponent, rhs: FormSectionComponent) -> Bool{
        lhs.id == rhs.id
    }
}

class FormComponent: FormItem,Hashable{
   
    let id = UUID()
    let formId: FormField
    var value: Any?
    var validations: [ValidationManager]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: FormComponent, rhs: FormComponent) -> Bool{
        lhs.id == rhs.id
    }
    
    init(_ id: FormField , validations: [ValidationManager] = []){
        self.formId = id
        self.validations = validations
    }
}

final class TextFormComponent: FormComponent{
    let placeholder : String
    let keyboardType : UIKeyboardType
    
    init(id: FormField,placeholder: String, keyboardType: UIKeyboardType = .default,validations: [ValidationManager] = []) {
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        super.init(id,validations: validations)
    }
}

final class DateFormComponent: FormComponent{
    let mode: UIDatePicker.Mode
    
    init(id: FormField,mode: UIDatePicker.Mode,validations: [ValidationManager] = []){
        self.mode = mode
        super.init(id,validations: validations)
    }
}

final class ButtonFormItem: FormComponent{
    let title: String
    
    init(id: FormField,title: String){
        self.title = title
        super.init(id)
    }
}

