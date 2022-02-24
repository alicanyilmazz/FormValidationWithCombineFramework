//
//  RegexFormItem.swift
//  FormValidationWithCombineFramework
//
//  Created by alican on 24.02.2022.
//

import Foundation

struct RegexFormItem{
    let pattern : String
    let error : ValidationError
}

protocol ValidationManager{
    func validate(_ val:Any) throws
}

struct RegexValidationManagerImpl : ValidationManager{
    
    private let items: [RegexFormItem]
    
    init(_ items: [RegexFormItem]){
        self.items = items
    }
    
    func validate(_ val: Any) throws {
        let val = (val as? String) ?? ""
        
        try items.forEach({ regexItem in
            let regex = try? NSRegularExpression(pattern: regexItem.pattern, options: .allowCommentsAndWhitespace)
            let range = NSRange(location: 0, length: val.count)
            if regex?.firstMatch(in: val, options: [], range: range) == nil{
                throw regexItem.error
            }
        })
        
    }
}

struct DateValidationManagerImpl : ValidationManager{

    private let ageLimit: Int = 18
    
    func validate(_ val: Any) throws {
        guard let date = val as? Date else { throw ValidationError.custom(message: "Invalid Value Passed") }
        
        if let calculatedYr = Calendar.current.dateComponents([.year], from: date,to: Date()).year , calculatedYr < ageLimit{
            throw ValidationError.custom(message: "User is below the age of 18")
        }
    }
}


