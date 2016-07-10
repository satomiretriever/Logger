//
//  Logger.swift
//  Logger
//
//  Created by Satomi Suyama on 1/9/16.
//  Copyright © 2016 amysound. All rights reserved.
//

import Foundation

class Logger {
    
    enum Colors {
        case Debug, Info, Success, Warning, Error
    }
    
    class func landmark(function: String = #function, file: String = #file, line: Int = #line) {
        Logger.write(function: function, file: file, line: line)
    }
    
    class func write(function: String, file: String, line: Int) {
        let now = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(localeIdentifier: "ja_JP")
        dateFormatter.timeStyle = .mediumStyle
        dateFormatter.dateStyle = .mediumStyle
        //println(dateFormatter.stringFromDate(now)) // => 2014/12/11 15:19:04
        
        let nowdate = dateFormatter.string(from: now as Date)
        
        var filename = file
        if let match = filename.range(of: "[^/]*$", options: .regularExpressionSearch) {
            filename = filename.substring(with: match)
        }
        ColorLog.info(object: "\(nowdate) [\(filename) - \(function) \(line)]")
    }
    
    class func debug(message: String, function: String = #function, file: String = #file, line: Int = #line) {
        Logger.write(loglevel: "DEBUG", message: message, function: function, file: file, line: line, color: .Debug)
    }
    
    class func info(message: String, function: String = #function, file: String = #file, line: Int = #line) {
        Logger.write(loglevel: "INFO", message: message, function: function, file: file, line: line, color: .Info)
    }
    
    class func success(message: String, function: String = #function, file: String = #file, line: Int = #line) {
        Logger.write(loglevel: "SUCCESS", message: message, function: function, file: file, line: line, color: .Success)
    }
    
    class func warning(message: String, function: String = #function, file: String = #file, line: Int = #line) {
        Logger.write(loglevel: "WARNING", message: message, function: function, file: file, line: line, color: .Warning)
    }
    
    class func error(message: String?, function: String = #function, file: String = #file, line: Int = #line) {
        if message != nil {
            Logger.write(loglevel: "ERROR", message: message, function: function, file: file, line: line, color: .Error)
        }
    }
    
    class func write(loglevel: String, message: String?, function: String, file: String, line: Int, color: Colors) {
        let now = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(localeIdentifier: "ja_JP")
        dateFormatter.timeStyle = .mediumStyle
        dateFormatter.dateStyle = .mediumStyle
        //println(dateFormatter.stringFromDate(now)) // => 2014/12/11 15:19:04
        
        let nowdate = dateFormatter.string(from: now as Date)
        
        var filename = file
        if let match = filename.range(of: "[^/]*$", options: .regularExpressionSearch) {
            filename = filename.substring(with: match)
        }
        let _message = message != nil ? "\(nowdate) [\(loglevel)][\(filename) - \(function) \(line)] \(message!)" : ""
        
        switch color {
        case .Debug:	ColorLog.debug(object: _message)
        case .Info:		ColorLog.info(object: _message)
        case .Warning:	ColorLog.warning(object: _message)
        case .Error:	ColorLog.error(object: _message)
        case .Success:	ColorLog.success(object: _message)
        }
        
    }
}

struct ColorLog {
    static let ESCAPE = "\u{001b}["
    
    static let RESET_FG = ESCAPE + "fg;" // Clear any foreground color
    static let RESET_BG = ESCAPE + "bg;" // Clear any background color
    static let RESET = ESCAPE + ";"   // Clear any foreground or background color
    
    static func error<T>(object: T) {
        print("\(ESCAPE)fg255,0,0;\(object)\(RESET)")
    }
    
    static func success<T>(object: T) {
        print("\(ESCAPE)fg200,238,90;\(object)\(RESET)")
    }
    
    static func debug<T>(object: T) {
        print("\(ESCAPE)fg115,171,236;\(object)\(RESET)")
    }
    
    static func warning<T>(object: T) {
        print("\(ESCAPE)fg245,156,35;\(object)\(RESET)")
    }
    
    static func purple<T>(object: T) {
        print("\(ESCAPE)fg255,0,255;\(object)\(RESET)")
    }
    
    static func info<T>(object: T) {
        print("\(ESCAPE)fg200,200,200;\(object)\(RESET)")
    }
}
