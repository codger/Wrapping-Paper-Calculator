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
    
    init() {
        self.isCM = UserDefaults.standard.object(forKey: "isCM") as? Bool ?? false
        self.length = UserDefaults.standard.object(forKey: "length") as? String ?? "10.0"
        self.width = UserDefaults.standard.object(forKey: "width") as? String ?? "10.0"
        self.height = UserDefaults.standard.object(forKey: "height") as? String ?? "10.0"
    }
    
    @Published var isCM : Bool {
        didSet{
            UserDefaults.standard.set(isCM, forKey: "isCM")
            calcPaperSize()
        }
    }
    
    @Published var height : String{
        didSet {
            guard (height.doubleValue != nil) else {
                height = oldValue
                return
            }
            UserDefaults.standard.set(height, forKey: "height")
            calcPaperSize()
        }
    }
    
    @Published var length : String {
        didSet {
            guard (length.doubleValue != nil) else {
                length = oldValue
                return
            }
            UserDefaults.standard.set(length, forKey: "length")
            calcPaperSize()
        }
    }
    
    @Published var width : String {
        didSet {
            guard (width.doubleValue != nil) else {
                width = oldValue
                return
            }
            UserDefaults.standard.set(width, forKey: "width")
            calcPaperSize()
        }
    }
    
    func calcPaperSize(){
        let w = (width as NSString).doubleValue
        let h = (height as NSString).doubleValue
        let l = (length as NSString).doubleValue
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

