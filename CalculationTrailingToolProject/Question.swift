//
//  Question.swift
//  CalculationTrailingToolProject
//
//  Created by nice2meet on 2023/3/4.
//

import Foundation

class Question:Identifiable,Equatable {
    let id = UUID()
    let firstOperand: Int
    let operation: String
    let secondOperand: Int
    
    init(firstOperand: Int,operation: String,secondOperand: Int){
        self.firstOperand = firstOperand
        self.operation = operation
        self.secondOperand = secondOperand
        
    }
    
    var display: String{
        insertParenthesis(opd: firstOperand) + operation + insertParenthesis(opd: secondOperand)
    }
    
    
    func insertParenthesis(opd: Int) -> String{
        if (opd < 0){
            return("(\(opd))")
        }
        return "\(opd)"
    }
    
    static func == (lhs: Question, rhs: Question) -> Bool{
        return lhs.id == rhs.id
    }

}

class QuestionLib: ObservableObject{
    @Published private(set) var questions:[Question] = []
    var setting = SettingPad()
    var operationLib: Dictionary<String,(first:ClosedRange<Int>,second:ClosedRange<Int>?)> {
        [
            "➕":(setting.firstOpMinPlus...setting.firstOpMaxPlus,setting.secondOpMinPlus...setting.secondOpMaxPlus),
            "➖":(setting.firstOpMinMinus...setting.firstOpMaxMinus,setting.secondOpMinMinus...setting.secondOpMaxMinus),
            "✖️":(setting.firstOpMinMuliply...setting.firstOpMaxMuliply,setting.secondOpMinMuliply...setting.secondOpMaxMuliply),
            "➗":(setting.firstOpMinDivide...setting.firstOpMaxDivide,nil)
        ]
    }
    
    var currentOperations: [String] {
        var opts = [String]()
        if setting.optPlus{opts.append("➕")}
        if setting.optMinus{opts.append("➖")}
        if setting.optMultiply{opts.append("✖️")}
        if setting.optDivide{opts.append("➗")}
        return opts
    }
    
    func addQuestion(){
        for _ in 1...setting.numbereOfQuestion{
            //                FIXME: - 待补充确保currentOperations不为空验证
            let operation = currentOperations.randomElement()!
            let firstOpd = Int.random(in: operationLib[operation]!.first)
            
            var secondOpd: Int {
                if let secondScope = operationLib[operation]!.second{
                    return Int.random(in: secondScope)
                }
                else{
                    return factor(number: firstOpd).randomElement()!
                }
            }
            questions.append(Question.init(firstOperand: firstOpd, operation: operation, secondOperand: secondOpd))
        }
        
    }
    
    private func factor(number: Int) -> [Int]{
        var allFactors = [Int]()
        if (number != 0){
            for factor in 1...Int(sqrt(Double(abs(number)))) {
                if number % factor == 0{
                    allFactors.append(factor)
                    let result = abs(number) / factor
                    if (result != factor){
                        allFactors.append(result)
                    }
                }
            }
        }
        else{
            var randomNum: Int
            repeat{
                randomNum = Int.random(in: -10...10)
                
            }while(randomNum == 0)
            allFactors.append(randomNum)
        }
        if (allFactors.count > 2){
            allFactors = allFactors.sorted()
            allFactors.removeFirst()
            allFactors.removeLast()
        }
        return allFactors
    }
    
    struct SettingPad{
        var numbereOfQuestion = 1
        
        var firstOpMinPlus = 0
        var firstOpMaxPlus = 20
        var secondOpMinPlus = 0
        var secondOpMaxPlus = 20
     
        var firstOpMinMinus = 0
        var firstOpMaxMinus = 20
        var secondOpMinMinus = 0
        var secondOpMaxMinus = 20
        
        var firstOpMinMuliply = 0
        var firstOpMaxMuliply = 20
        var secondOpMinMuliply = 0
        var secondOpMaxMuliply = 20
        
        var firstOpMinDivide = -10
        var firstOpMaxDivide = 10
        
        
        var optPlus = false
        var optMinus = false
        var optMultiply = false
        var optDivide = true
    }
}
