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
    
    let maxNumButton = 9
    
    var printNum: Double = 0
    var tempNum: Double = 0
    var howManyFraction: Int = 0
    var howManyDecimal: Int = 0
    var expressionArray: [String] = []
    var isSelectedOperator = false // 곱하기, 나누기, 나머지가 선택된지
    
    var operation = 0 // +1, -2, *3, /4, %5
    
    // MARK: - 숫자 클릭
    func resultChange(_ newNum: Double) {
        guard howManyDecimal < maxNumButton else {
            return
        }
        
        howManyDecimal += 1
        var fraction = newNum
        var powTen = 1
        
        if howManyFraction > 0 {
            for _ in 0..<howManyFraction {
                fraction *= 0.1
                powTen *= 10
            }
            fraction = round(fraction * Double(powTen)) / Double(powTen)
            printNum += fraction
            printNum = round(printNum * Double(powTen)) / Double(powTen)
            howManyFraction += 1
        }
            
        else {
            printNum = printNum * 10 + newNum
        }
        
        self.result.text = removePoint(num: printNum)
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
        howManyFraction += 1
        self.result.text = removePoint(num: printNum) + "."
    }
    
    @IBAction func clear(_ sender: Any) {
        printNum = 0
        howManyFraction = 0
        howManyDecimal = 0
        expressionArray.removeAll()
        self.result.text = "0"
    }
    
    @IBAction func toggle(_ sender: Any) {
        printNum *= -1
        self.result.text = removePoint(num: printNum)
    }
    
    @IBAction func braketFirst(_ sender: Any) {
        
    }
    @IBAction func bracketSecond(_ sender: Any) {
        
    }
    
    // MARK: - 연산 기능 함수
    @IBAction func printResult(_ sender: Any) {
        expressionArray.append(String(printNum))
        
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
        howManyFraction = 0
        howManyDecimal = 0
        
        print(expressionArray)
        print(expressionArrayResult())
    }
    
    func whenSelectedOperator(_ num:Int) {
        expressionArray.append(String(removePoint(num: printNum)))
        switch num {
        case 1:
            expressionArray.append("+")
        case 2:
            expressionArray.append("-")
        case 3:
            expressionArray.append("*")
        case 4:
            expressionArray.append("/")
        case 5:
            expressionArray.append("%")
        default:
            break
        }
        
        operation = num
        tempNum = printNum
        
        printNum = 0
        howManyFraction = 0
        howManyDecimal = 0
        
    }
    
    func operateTwoNum(_ a: Double, _ b: Double, operation: (Double, Double) -> Double) {
        printNum = round(operation(a, b) * 100000000) / 100000000 // 소수점 아래 8자리에서 자르기
        self.result.text = removePoint(num: printNum) // 이하 0은 삭제 됨
    }
    
    var operateAdd: (Double, Double) -> Double = { $0 + $1 }
    var operateSub: (Double, Double) -> Double = { $0 - $1 }
    var operateMultiply: (Double, Double) -> Double = { $0 * $1 }
    var operateDivide: (Double, Double) -> Double = { $0 / $1 }
    var operateRemainder: (Double, Double) -> Double = { $0.truncatingRemainder(dividingBy: $1) }
    
    
    // MARK: 소수점 제거
    func removePoint(num: Double) -> String {
        let floatNumString = num == floor(num) ? String(format: "%.f", num) : String(num)
        return floatNumString
    }
    
    
    // MARK: 최종 계산
    func expressionArrayResult() -> String {
        expressionArray.append("\n")
        var i: Int = -1
        var insertNum: Double = 0
        
        repeat {
            i += 1
            switch expressionArray[i] {
            case "*" :
                insertNum = operateMultiply(Double(expressionArray[i-1])!, Double(expressionArray[i+1])!)
                for _ in 0..<3 { expressionArray.remove(at: i-1) }
                expressionArray.insert(String(insertNum), at: i-1)
                i -= 1
                print(expressionArray)
            case "/" :
                insertNum = operateDivide(Double(expressionArray[i-1])!, Double(expressionArray[i+1])!)
                for _ in 0..<3 { expressionArray.remove(at: i-1) }
                expressionArray.insert(String(insertNum), at: i-1)
                 print(expressionArray)
                i -= 1
            case "%" :
                insertNum = operateRemainder(Double(expressionArray[i-1])!, Double(expressionArray[i+1])!)
                for _ in 0..<3 { expressionArray.remove(at: i-1) }
                expressionArray.insert(String(insertNum), at: i-1)
                 print(expressionArray)
                i -= 1
            default:
                break
            }
            
            
        } while expressionArray[i] != "\n"
        
        
        i = -1
        insertNum = 0
        
        repeat {
            i += 1
            switch expressionArray[i] {
            case "+" :
                insertNum = operateAdd(Double(expressionArray[i-1])!, Double(expressionArray[i+1])!)
                for _ in 0..<3 { expressionArray.remove(at: i-1) }
                expressionArray.insert(String(insertNum), at: i-1)
                 print(expressionArray)
                i -= 1
            case "-" :
                insertNum = operateSub(Double(expressionArray[i-1])!, Double(expressionArray[i+1])!)
                for _ in 0..<3 { expressionArray.remove(at: i-1) }
                expressionArray.insert(String(insertNum), at: i-1)
                 print(expressionArray)
                i -= 1
            default:
                break
            }
        } while expressionArray[i] != "\n"
        
        self.result.text = removePoint(num: (Double(expressionArray.first!)!))
        return " "
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

