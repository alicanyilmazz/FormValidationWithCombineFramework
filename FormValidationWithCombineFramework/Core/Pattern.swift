//
//  Pattern.swift
//  FormValidationWithCombineFramework
//
//  Created by alican on 24.02.2022.
//

import Foundation

enum RegexPatterns{
    static let emailChars = ".*[@].*"
    static let higherThanSixChars = "^.{6,}$"
    static let name = "^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$"
}
