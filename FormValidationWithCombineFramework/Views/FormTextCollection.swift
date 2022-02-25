//
//  FormTextCollection.swift
//  FormValidationWithCombineFramework
//
//  Created by alican on 24.02.2022.
//

import UIKit
import Combine

class FormTextCollectionViewCell: UICollectionViewCell {
    
    private var item: TextFormComponent?
    private var indexPath: IndexPath?
    
    private(set) var subject = PassthroughSubject<(String,IndexPath),Never>()
    private var subscriptions = Set<AnyCancellable>()
    
    private lazy var txtField: UITextField = {
        let txtField = UITextField()
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.layer.borderColor = UIColor.systemGray5.cgColor
        txtField.layer.borderWidth = 1
        txtField.layer.cornerRadius = 8
        return txtField
    }()
    
    private lazy var errorLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = UIColor.systemRed
        lbl.text = ""
        return lbl
    }()
    
    private lazy var contentStackVw: UIStackView = {
        let stackVw = UIStackView()
        stackVw.translatesAutoresizingMaskIntoConstraints = false
        stackVw.axis = .vertical
        stackVw.spacing = 8
        return stackVw
    }()
    
    func bind(_ item: FormComponent,
              at indexPath: IndexPath) {
        guard let item = item as? TextFormComponent else { return }
        self.indexPath = indexPath
        self.item = item
        setup(item: item)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        removeViews()
        self.item = nil
        self.indexPath = nil
        subscriptions = []
    }
}

private extension FormTextCollectionViewCell {
    
    func setup(item: TextFormComponent) {
        
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: txtField).compactMap {
            ($0.object as? UITextField)?.text}.map(String.init).sink{ [weak self] val in
                guard let self = self ,let indexPath = self.indexPath else { return }
                
                do{
                    for validator in item.validations{
                        try validator.validate(val)
                    }
                    
                    self.txtField.valid()
                    self.errorLbl.text = " "
                    self.subject.send((val,indexPath))
                }catch{
                    self.txtField.invalid()
                    if let validationError = error as? ValidationError{
                        switch validationError {
                        case .custom(let message):
                            self.errorLbl.text = message
                        }
                    }
                }
                
            }.store(in: &subscriptions)
        
        // Setup
        txtField.delegate = self
        txtField.placeholder = " \(item.placeholder)"
        txtField.keyboardType = item.keyboardType

        // Layout
        
        contentView.addSubview(contentStackVw)
        
        contentStackVw.addArrangedSubview(txtField)
        contentStackVw.addArrangedSubview(errorLbl)
        
        NSLayoutConstraint.activate([
            txtField.heightAnchor.constraint(equalToConstant: 44),
            errorLbl.heightAnchor.constraint(equalToConstant: 22),
            contentStackVw.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentStackVw.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            contentStackVw.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentStackVw.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}

extension FormTextCollectionViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
