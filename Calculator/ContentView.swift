//
//  ContentView.swift
//  Calculator
//
//  Created by sglee237 on 2023/01/18.
//

import SwiftUI

extension String {
    var isDigit: Bool {
        let digitCharacters = CharacterSet(charactersIn: "0123456789")
        return CharacterSet(charactersIn: self).isSubset(of: digitCharacters)
    }
}



struct ContentView: View {
    @ObservedObject private var brain: CalculatorModel = CalculatorModel()
    //@State private var result:String = "0"
    
    func inputToken(token:String) {
        brain.inputToken(input: token)
      //  result = brain.result
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text(brain.displayValue)
                        .padding()
                        .font(.system(size: 73))
                        .foregroundColor(.white)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                }
                ForEach(Array(brain.getButtonCodeList().enumerated()), id: \.offset) {vIdx, line in
                    HStack {
                        let hLast = line.count - 1
                        ForEach(Array(line.enumerated()), id: \.offset) {hIdx, buttonTitle in
                            Button(action: {inputToken(token: buttonTitle)}) {
                                Text(buttonTitle)
                                    .frame(
                                        width: (buttonTitle == "0" ? 170 : 80),
                                        height: 80)
                                    .background(hIdx == hLast ? .orange :
                                                    vIdx == 0 ? .gray : .secondary)
                                    .cornerRadius(40)
                                    .foregroundColor(.white)
                                    .font(.system(size: 33))
                            }
                            
                        }
                    }
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
