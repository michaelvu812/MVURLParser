MVURLParser
===========

A delightful URL Parser class for iOS written in Swift

MVURLParser parses a URL and returns an associative array containing any of the variables of the URL that are present.

## Methods

```objective-c
MVURLParser.init(urlString)
parse.count()
parse.isValid()
parse.valueForVariable(variable)
parse.valueForVariable(variable, pattern)
parse.valueForVariable(variable, regex)
parse.updateVariable(variable, value, url)
parse.updateURLByVariable(variable, value)
```

## Example

```objective-c
var parse = MVURLParser(urlString: "http://example.com?var1=Value1&var2=Value2&var3=Value2&var4=Value2&var10=Value10")
NSLog("Count %d", parse.count())
NSLog("is Valid %@", parse.isValid().description)
NSLog("Null %@", parse.valueForVariable(nil))
NSLog("Empty %@", parse.valueForVariable(""))
NSLog("Var1 %@", parse.valueForVariable("var1"))
NSLog("Var2 %@", parse.valueForVariable("var2"))
NSLog("Var3 %@", parse.valueForVariable("var3"))
NSLog("Var4 %@", parse.valueForVariable("var4"))
NSLog("Pattern %@", parse.valueForVariable("v", pattern: "3$"))
let regex = NSRegularExpression(pattern: "\\d{2}", options: .CaseInsensitive, error: nil)
NSLog("Regex %@", parse.valueForVariable("var", regex: regex))
var newUrl = String()
parse.updateVariable("var1", value: "Test1", url: &newUrl)
NSLog("Updated URL %@", newUrl)
NSLog("New URL %@", parse.updateURLByVariable("var2", value: "Test2"))
NSLog("New Value for Var2 %@", parse.valueForVariable("var2"))
```

## Installation

Add MVURLParser.swif file to your project and use it

## Author

Michael Vu

- https://github.com/Namvt
- namvt@rubify.com

## License

MVURLParser is available under the MIT license. See the LICENSE file for more info.