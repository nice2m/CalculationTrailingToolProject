//
//  QuestionCardView.swift
//  CalculationTrailingToolProject
//
//  Created by nice2meet on 2023/3/4.
//

import SwiftUI

struct QuestionCardView: View {
    var question: Question
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.white)
            
            Text(question.display)
                    .font(.largeTitle)
                    .padding()
        }
        .frame(width: 200, height: 100, alignment: .center)
        .shadow(color: .init(white: 0.2), radius: 5, x: 0, y: 0)
    }
}

struct QuestionCardView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionCardView(question: Question.init(firstOperand: 1, operation: "+", secondOperand: 2))
    }
}
