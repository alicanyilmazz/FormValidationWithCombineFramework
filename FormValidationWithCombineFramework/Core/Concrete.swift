//
//  Concrete.swift
//  FormValidationWithCombineFramework
//
//  Created by alican on 25.02.2022.
//

import Foundation

protocol FormItem{
    var id: UUID {get}
    var formId: FormField {get}
    var validations: [ValidationManager] {get}
}

protocol FormSectionItem{
    var id : UUID {get}
    var items: [FormComponent] {get}
    init(items: [FormComponent])
}

enum FormField: String,CaseIterable{
    case firstName
    case lastName
    case email
    case dob
    case submit
}
