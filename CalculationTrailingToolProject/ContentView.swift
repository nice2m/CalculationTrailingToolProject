//
//  ContentView.swift
//  CalculationTrailingToolProject
//
//  Created by nice2meet on 2023/3/4.
//

import SwiftUI

struct ContentView: View {
    
    @State private var clickCount: Int = 0
    
    @StateObject var questionLib = QuestionLib()
    
    var body: some View {
        VStack{
            StackOfCardsView()
            Spacer()
            Text("共计点击\(clickCount)")
            Button("新增一个卡牌", action: btnAction)
        }
        .environmentObject(questionLib)
    }
    
    func btnAction(){
        clickCount += 1
//        questionLib.questions.publisher
//            .sequence
//            .append(Question.init(firstOperand: 1, operation: "-", secondOperand: 2))
//        questionLib.questions
//            .publisher
//            .append(<#T##elements: Publishers.Sequence<[Question], Never>.Output...##Publishers.Sequence<[Question], Never>.Output#>)
        questionLib.addQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
