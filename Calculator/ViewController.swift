//
//  ViewController.swift
//  Calculator
//
//  Created by 이혜빈 on 2022/06/21.
//  Copyright © 2022 swiftPractice. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var display: UILabel!

    //display value -> double type
    private var displayValue: Double {
        get { // displayValue의 값을 가져오기 위한 코드
            return Double(display.text!)!
        }
        set { // 누군가가 이 변수의 값을 설정하려고 할 때 실행되는 코드
            display.text = String(newValue)
        }
    }
    private var brain: CalculatorBrain = CalculatorBrain()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    private var userIsInTheMiddleOfTyping = false
    
    @IBAction private func touchdigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisply = display!.text!
            display!.text = textCurrentlyInDisply + digit
            print("middle digit = \(digit)")
        } else {
            if !(digit == "0" || digit == "."){
                display!.text = digit
            }
            print("first digit = \(digit)")
        }
        userIsInTheMiddleOfTyping = true
    }

    @IBAction private func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping { //상수값 입력을 하는 중에 연산 버튼을 눌렀다면
            brain.setOperand(operand: displayValue)// 상수값 보내기
            userIsInTheMiddleOfTyping = false // 상수값 입력을 그만받기
        }
        if let mathematicalSymbol = sender.currentTitle { //mathematicalSymbol이 들어오면
            brain.performOperation(symbol: mathematicalSymbol)
            //해당 연산자를 전송하여 연산 요청
        }
        displayValue = brain.accumulator
        //연산 결과값 가져오기
        
    }
    
}

