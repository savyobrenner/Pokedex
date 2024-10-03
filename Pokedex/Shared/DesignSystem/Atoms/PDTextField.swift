//
//  PDTextField.swift
//  Pokedex
//
//  Created by Savyo Brenner on 03/10/24.
//


import SwiftUI
import UIKit

struct PDTextField: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String

    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: PDTextField

        init(parent: PDTextField) {
            self.parent = parent
        }

        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        textField.placeholder = placeholder
        textField.borderStyle = .none
        textField.returnKeyType = .done
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
        uiView.addTarget(context.coordinator, action: #selector(Coordinator.updateText(_:)), for: .editingChanged)
    }
}

private extension PDTextField.Coordinator {
    @objc func updateText(_ textField: UITextField) {
        parent.text = textField.text ?? ""
    }
}
