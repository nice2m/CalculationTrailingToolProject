//
//  StackOfCardsView.swift
//  CalculationTrailingToolProject
//
//  Created by nice2meet on 2023/3/4.
//

import SwiftUI

struct StackOfCardsView: View {
//    @ObservedObject var questionLib = QuestionLib()
    @EnvironmentObject var questionLib: QuestionLib
    
    var body: some View {
        ZStack{
            ForEach(questionLib.questions) { question in
                let index = questionLib.questions.firstIndex(of: question)!
                QuestionCardView(question: question)
                    .offset(CGSize.init(width: 0, height: 20 * CGFloat(questionLib.questions.count - (index + 1))))
            }
        }
        .environmentObject(questionLib)
    }
}

struct StackOfCardsView_Previews: PreviewProvider {
//    static var exampleQuestionLib = QuestionLib()
    static var previews: some View {
//        StackOfCardsView(questionLib: exampleQuestionLib)
//            .onAppear {
//                exampleQuestionLib.questions.append(.init(firstOperand: 1, operation: "+", secondOperand: 2))
//                exampleQuestionLib.questions.append(.init(firstOperand: 2, operation: "+", secondOperand: 3))
//            }
        StackOfCardsView()
            .environmentObject(QuestionLib())
    }
}
