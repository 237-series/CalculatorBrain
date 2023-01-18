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

class CalculatorBrain {
    var result:String = "0"
    var tokenList:[String]  = []
    
    private let buttonCodeVertical: [[String]] = [
        ["C", "±", "%", "÷"],
        ["7", "8", "9", "×"],
        ["4", "5", "6", "−"],
        ["1", "2", "3", "+"],
        ["0", "0", ",", "="]
    ]
    
    private let buttonCodeHorizontal: [[String]] = [
        ["(",   ")",    "mc",   "m+",   "m-",   "mr",   "C",    "±",    "%",    "÷"],
        ["2nd", "x²",   "x³",   "xʸ",   "eˣ",   "10ˣ",  "7",    "8",    "9",    "×"],
        ["√x",  "2/x",  "3/x",  "y/x",  "ln",   "log10","4",    "5",    "6",    "−"],
        ["x!",  "sin",  "cos",  "tan",  "e",    "EE",   "1",    "2",    "3",    "+"],
        ["Rad", "sinh", "cosh", "tanh", "pi",   "Rand", "0",    "0",    ",",    "="]
    ]
    
    func getButtonCodeList()->[[String]] {
        return buttonCodeVertical
    }
    
    func inputToken(input:String) {
        tokenList.append(input)
        cal()
    }
    
    func cal() {
        var ret:String = ""
        for token in tokenList {
            ret += token
        }
        result = ret
    }
}


struct ContentView: View {
    private var brain: CalculatorBrain = CalculatorBrain()
    @State private var result:String = "0"
    
    func inputToken(token:String) {
        brain.inputToken(input: token)
        result = brain.result
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text(result)
                        .padding()
                        .font(.system(size: 73))
                        .foregroundColor(.white)
                }
                ForEach(Array(brain.getButtonCodeList().enumerated()), id: \.offset) {vIdx, line in
                    HStack {
                        let hLast = line.count - 1
                        ForEach(Array(line.enumerated()), id: \.offset) {hIdx, buttonTitle in
                            Button(action: {inputToken(token: buttonTitle)}) {
                                Text(buttonTitle)
                                    .frame(width: 80, height: 80)
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
