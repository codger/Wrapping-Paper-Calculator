//
//  ContentView.swift
//  Shared
//
//  Created by John James on 12/22/20.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var paperCalc = PaperCalc()
    
    var body: some View {
        Form{
            Text("Package Wrapper Calculator")
                .font(.headline)
                .fontWeight(.bold)
            HStack{
                Toggle(isOn: $paperCalc.isCM) {
                    Text(paperCalc.isCM ? "Units CM" : "Units Inch")
                }
                Divider()
                Button(action: { self.hideKeyboard()}, label: {
                    Image(systemName: "keyboard.chevron.compact.down")                        
                        .font(.largeTitle)
                        
                })
                .padding()
            }
            Section{
                Text("Package Size")
                    .font(.headline)
                    .fontWeight(.bold)
                
                HStack{
                    Text("Length")
                    TextField("", text: $paperCalc.length)
                }
                HStack{
                    Text("Width")
                    TextField("", text: $paperCalc.width)
                }
                HStack{
                    Text("height")
                    TextField("", text: $paperCalc.height)
                }
            }
            Section{
                Text("Cut Paper Size")
                    .font(.headline)
                    .fontWeight(.bold)
                HStack{
                    Text("Paper Length")
                    Text(paperCalc.paperLength)
                        .fontWeight(.bold)
                }
                HStack{
                    Text("Paper Width")
                    Text(paperCalc.paperWidth)
                        .fontWeight(.bold)
                }
            }
            .onAppear{
                paperCalc.calcPaperSize()
            }
        }
        .keyboardType(.decimalPad)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
