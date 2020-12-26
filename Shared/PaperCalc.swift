//
//  PaperCalc.swift
//  Wrapping Paper Calculator
//
//  Created by John James on 12/23/20.
//

import Foundation
import SwiftUI

class PaperCalc: ObservableObject {
    
    @Published var paperLength : String = ""
    @Published var paperWidth : String = ""
    @AppStorage("isCM") var isCM = false {
        didSet{
            calcPaperSize()
        }
    }
    @AppStorage("height") var height = "10.0" {
        didSet {
            guard (height.doubleValue != nil) else {
                height = oldValue
                return
            }
            calcPaperSize()
        }
    }
    @AppStorage("width") var width = "20.0" {
        didSet {
            guard (width.doubleValue != nil) else {
                width = oldValue
                return
            }
            calcPaperSize()
        }
    }
    @AppStorage("length") var length = "30.0" {
        didSet {
            guard (length.doubleValue != nil) else {
                length = oldValue
                return
            }
            calcPaperSize()
        }
    }
    
    func calcPaperSize(){
        let w = Double(width) ?? 0.0
        let h = Double(height) ?? 0.0
        let l = Double(length) ?? 0.0
        paperLength = "\((2 * w) + (2 * h) + (isCM ? 5 : 2))"
        paperWidth = "\((h * 1.5) + l)"
    }
}

extension String {
    struct NumFormatter {
        static let instance = NumberFormatter()
    }
    
    var doubleValue: Double? {
        if self.count == 0 {
            return 0
        }
        return NumFormatter.instance.number(from: self)?.doubleValue
    }
    
    var integerValue: Int? {
        return NumFormatter.instance.number(from: self)?.intValue
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

