//
//  ViewController.swift
//  Calculator
//
//  Created by Jinhyang on 2020/03/04.
//  Copyright © 2020 Jinhyang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var result: UILabel!
    
    var printNum = 0
    var tempNum = 0
    var isSelectedOperatior: Bool = false
    
    var operation = 0 // +1, -2, *3, /4, %5
    
    // MARK: - 숫자 클릭
    func resultChange(_ a: Int) {
        printNum = printNum * 10 + a
        result.text = String(printNum)
    }
    
    @IBAction func num1(_ sender: Any) { resultChange(1) }
    
    @IBAction func num2(_ sender: Any) { resultChange(2) }
    
    @IBAction func num3(_ sender: Any) { resultChange(3) }
    
    @IBAction func num4(_ sender: Any) { resultChange(4) }
    
    @IBAction func num5(_ sender: Any) { resultChange(5) }
    
    @IBAction func num6(_ sender: Any) { resultChange(6) }
    
    @IBAction func num7(_ sender: Any) { resultChange(7) }
    
    @IBAction func num8(_ sender: Any) { resultChange(8) }
    
    @IBAction func num9(_ sender: Any) { resultChange(9) }
    
    @IBAction func num0(_ sender: Any) { resultChange(0) }
    
    // MARK: - 연산자 클릭
    @IBAction func plus(_ sender: Any) {
        whenSelectedOperator(1)
    }
    
    @IBAction func minus(_ sender: Any) {
        whenSelectedOperator(2)
    }
    
    @IBAction func multiple(_ sender: Any) {
        whenSelectedOperator(3)
    }
    
    @IBAction func divide(_ sender: Any) {
        whenSelectedOperator(4)
    }
    
    @IBAction func remainder(_ sender: Any) {
        whenSelectedOperator(5)
    }
    
    @IBAction func dot(_ sender: Any) {
        var printNumString = String(printNum)
        printNumString.append(".")
        result.text = printNumString
    }
    
    @IBAction func clear(_ sender: Any) {
        printNum = 0
        result.text = "0"
    }
    
    @IBAction func toggle(_ sender: Any) {
        printNum *= -1
        result.text = String(printNum)
    }
    
    @IBAction func braketFirst(_ sender: Any) {
        
    }
    @IBAction func bracketSecond(_ sender: Any) {
        
    }
    
    // MARK: - 연산 기능 함수
    @IBAction func print(_ sender: Any) {
        switch operation {
        case 1:
            operateTwoNum(tempNum, printNum, operation: operateAdd)
        case 2:
            operateTwoNum(tempNum, printNum, operation: operateSub)
        case 3:
            operateTwoNum(tempNum, printNum, operation: operateMultiply)
        case 4:
            operateTwoNum(tempNum, printNum, operation: operateDivide)
        case 5:
            operateTwoNum(tempNum, printNum, operation: operateRemainder)
        default:
            break
        }
        operation = 0
        isSelectedOperatior = false
    }
    
    func whenSelectedOperator(_ num:Int) {
        guard !isSelectedOperatior else {
            return
        }
        isSelectedOperatior = true
        operation = num
        tempNum = printNum
        printNum = 0
    }
    
    func operateTwoNum(_ a: Int, _ b: Int, operation: (Int, Int) -> Int) {
        printNum = operation(a, b)
        result.text = String(printNum)
    }
    
    var operateAdd: (Int, Int) -> Int = { $0 + $1 }
    var operateSub: (Int, Int) -> Int = { $0 - $1 }
    var operateMultiply: (Int, Int) -> Int = { $0 * $1 }
    var operateDivide: (Int, Int) -> Int = { $0 / $1 }
    var operateRemainder: (Int, Int) -> Int = { $0 % $1 }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

