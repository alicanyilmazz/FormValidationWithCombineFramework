//
//  Builder.swift
//  FormValidationWithCombineFramework
//
//  Created by alican on 24.02.2022.
//

import Foundation

final class formComponentBuilderImpl{
    private(set) var formContent = [
        FormSectionComponent(items: [
            TextFormComponent(id: .firstName, placeholder: "First Name",validations: [RegexValidationManagerImpl([RegexFormItem(pattern: RegexPatterns.name, error: .custom(message: "Invalid Name Entered"))])]),
            TextFormComponent(id: .lastName, placeholder: "Last Name",validations: [RegexValidationManagerImpl([RegexFormItem(pattern: RegexPatterns.name, error: .custom(message: "Invalid Last Name Entered"))])]),
            TextFormComponent(id: .email, placeholder: "Email",keyboardType: .emailAddress,validations: [RegexValidationManagerImpl([RegexFormItem(pattern: RegexPatterns.emailChars, error: .custom(message: "Invalid Email missing @")),RegexFormItem(pattern: RegexPatterns.higherThanSixChars, error: .custom(message: "Less than 6 characters"))])]),
            DateFormComponent(id: .dob, mode: .date,validations: [DateValidationManagerImpl()]),
            ButtonFormItem(id: .submit, title: "Confirm")
        ])
    ]
}

