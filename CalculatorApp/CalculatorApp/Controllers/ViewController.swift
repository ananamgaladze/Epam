//
//  ViewController.swift
//  CalculatorApp
//
//  Created by ana namgaladze on 27.06.25.
//
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - UI Component
    private var displayLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont.systemFont(ofSize: 40)
        label.textColor = .white
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let buttonTitles: [[String]] = [
        ["C", "+/-", "%", "÷"],
        ["7", "8", "9", "×"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "+"],
        ["🧮", "0", ".", "="]
    ]
    
    private let operatorSymbols: Set<String> = ["+", "-", "×", "÷", "="]
    
    private var currentInput: String = ""
    private var firstValue: String?
    private var currentOperator: String?
    private var isTypingNumber = false
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        setupDisplayLabel()
        setupCalculatorButtons()
    }
    
    // MARK: - Setup
    
    private func setupDisplayLabel() {
        view.addSubview(displayLabel)
        NSLayoutConstraint.activate([
            displayLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            displayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            displayLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            displayLabel.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func setupCalculatorButtons() {
        let mainStackView = UIStackView()
        mainStackView.axis = .vertical
        mainStackView.alignment = .center
        mainStackView.spacing = 15
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: displayLabel.bottomAnchor, constant: 20),
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        for row in buttonTitles {
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.alignment = .fill
            rowStack.spacing = 15
            
            for title in row {
                let buttonColor: UIColor = operatorSymbols.contains(title) ? .orange : .darkGray
                let button = CalculatorButton(title: title, backgroundColor: buttonColor) { [weak self] in
                    self?.handleInput(title)
                }
                rowStack.addArrangedSubview(button)
            }
            mainStackView.addArrangedSubview(rowStack)
        }
    }
    
    // MARK: - Input Handling
    private func handleInput(_ symbol: String) {
        switch symbol {
        case "0"..."9", ".":
            if isTypingNumber {
                currentInput += symbol
            } else {
                currentInput = symbol
                isTypingNumber = true
            }
            updateDisplay()
            
        case "+", "-", "×", "÷":
            if !currentInput.isEmpty {
                firstValue = currentInput
                currentOperator = symbol
                currentInput = ""
                isTypingNumber = false
                updateDisplay()
            }
            
        case "=":
            guard let first = firstValue,
                  let op = currentOperator,
                  let firstNum = Double(first),
                  let secondNum = Double(currentInput)
            else { return }
            
            let result: Double?
            switch op {
            case "+": result = firstNum + secondNum
            case "-": result = firstNum - secondNum
            case "×": result = firstNum * secondNum
            case "÷": result = secondNum == 0 ? nil : firstNum / secondNum
            default: result = nil
            }
            
            if let final = result {
                displayLabel.text = String(final)
                currentInput = String(final)
            } else {
                displayLabel.text = "Error"
                currentInput = ""
            }
            
            firstValue = nil
            currentOperator = nil
            isTypingNumber = false
            
        case "C":
            currentInput = ""
            firstValue = nil
            currentOperator = nil
            isTypingNumber = false
            displayLabel.text = "0"
            
        case "+/-":
            if let value = Double(currentInput) {
                currentInput = String(-value)
                updateDisplay()
            }
            
        case "%":
            if let value = Double(currentInput) {
                currentInput = String(value / 100)
                updateDisplay()
            }
            
        case "🧮":
            displayLabel.text = "Let's calculate!"
            currentInput = ""
            firstValue = nil
            currentOperator = nil
            isTypingNumber = false
            
        default:
            break
        }
    }
    
    private func updateDisplay() {
        if let op = currentOperator, let first = firstValue {
            displayLabel.text = "\(first) \(op) \(currentInput)"
        } else {
            displayLabel.text = currentInput
        }
    }
}
