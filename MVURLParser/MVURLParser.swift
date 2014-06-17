//
//  MVURLParser.swift
//  MVURLParser
//
//  Created by Michael on 17/6/14.
//  Copyright (c) 2014 Michael Vu. All rights reserved.
//

import Foundation
import CoreFoundation

@objc class MVURLParser: NSObject {
    var variables: String[] = String[]()
    var url: String = String()
    init(urlString:String) {
        self.url = urlString.stringByReplacingOccurrencesOfString("&amp;", withString: "&", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
        self.url = self.url.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        let scanner = NSScanner.scannerWithString(self.url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding))
        scanner.charactersToBeSkipped = NSCharacterSet(charactersInString: "&?")
        var tempString: NSString? = nil
        var vars: String[] = String[]()
        scanner.scanUpToString("?", intoString: nil)
        while scanner.scanUpToString("&", intoString: &tempString) {
            vars.append(tempString!)
        }
        self.variables = vars.copy()
    }
    
    func count() -> Int {
        return variables.count
    }
    
    func isValid() -> Bool {
        let pattern = "(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"
        let regex = NSRegularExpression(pattern: pattern, options: .CaseInsensitive, error: nil)
        let match = regex.numberOfMatchesInString(self.url, options: NSMatchingOptions.ReportCompletion, range: NSMakeRange(0, countElements(self.url)))
        return match > 0
    }
    
    func valueForVariable(variable:String?) -> String {
        if !variable { return String() }
        for varString in variables {
            let length = countElements(varString)
            let varLength = countElements(variable!) + 1
            if length > varLength && varString.sub(0, length: varLength) == variable!.stringByAppendingString("=") {
                return varString.substringFromIndex(varLength)
            }
        }
        return String()
    }
    
    func valueForVariable(variable:String?, pattern:String) -> String {
        return self.valueForVariable(variable, regex: NSRegularExpression(pattern: pattern, options: .CaseInsensitive, error: nil))
    }
    
    func valueForVariable(variable:String?, regex:NSRegularExpression) -> String {
        for varString in variables {
            let firstVar = varString.componentsSeparatedByString("=").bridgeToObjectiveC().firstObject as String
            if firstVar.isEmpty { return String() }
            var variableMatch:Bool = true
            if variable && firstVar.rangeOfString(variable!, options: .RegularExpressionSearch, range: nil, locale: nil).isEmpty {
                variableMatch = false
            }
            if regex.numberOfMatchesInString(firstVar, options: NSMatchingOptions.ReportCompletion, range: NSMakeRange(0, countElements(firstVar))) <= 0 {
                variableMatch = false
            }
            if variableMatch {
                return varString.componentsSeparatedByString("=").bridgeToObjectiveC().lastObject as String
            }
        }
        return String()
    }
    
    func updateVariable(variable:String, value:String, inout url:String) {
        let target = variable + "=" + self.valueForVariable(variable)
        let replace = variable + "=" + value
        url = self.url.stringByReplacingOccurrencesOfString(target, withString: replace, options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
    }
    
    func updateURLByVariable(variable:String, value:String) -> String {
        if self.valueForVariable(variable).isEmpty {
            return self.url
        } else {
            let target = variable + "=" + self.valueForVariable(variable)
            let replace = variable + "=" + value
            for var index = 0; index < self.variables.count; ++index {
                if self.variables[index] == target {
                    self.variables.insert(replace, atIndex: index)
                    break
                }
            }
            self.url = self.url.stringByReplacingOccurrencesOfString(target, withString: replace, options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
            return self.url
        }
    }
}

extension String {
    func sub(start: Int, length: Int) -> String {
        assert(start >= 0)
        assert(length >= 0)
        assert(start <= countElements(self) - 1)
        assert(start + length <= countElements(self))
        var a = self.substringFromIndex(start)
        var b = a.substringToIndex(length)
        return b
    }
}