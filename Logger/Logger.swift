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
        case debug, info, success, warning, error
    }
    
    class func landmark(_ function: String = #function, file: String = #file, line: Int = #line) {
        Logger.write(function, file: file, line: line)
    }
    
    class func write(_ function: String, file: String, line: Int) {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.timeStyle = .medium
        dateFormatter.dateStyle = .medium
        //println(dateFormatter.stringFromDate(now)) // => 2014/12/11 15:19:04
        
        let nowdate = dateFormatter.string(from: now as Date)
        
        var filename = file
        if let match = filename.range(of: "[^/]*$", options: .regularExpression) {
            filename = filename.substring(with: match)
        }
        ColorLog.info("\(nowdate) [\(filename) - \(function) \(line)]")
    }
    
    class func debug(_ message: String, function: String = #function, file: String = #file, line: Int = #line) {
        Logger.write("DEBUG", message: message, function: function, file: file, line: line, color: .debug)
    }
    
    class func info(_ message: String, function: String = #function, file: String = #file, line: Int = #line) {
        Logger.write("INFO", message: message, function: function, file: file, line: line, color: .info)
    }
    
    class func success(_ message: String, function: String = #function, file: String = #file, line: Int = #line) {
        Logger.write("SUCCESS", message: message, function: function, file: file, line: line, color: .success)
    }
    
    class func warning(_ message: String, function: String = #function, file: String = #file, line: Int = #line) {
        Logger.write("WARNING", message: message, function: function, file: file, line: line, color: .warning)
    }
    
    class func error(_ message: String?, function: String = #function, file: String = #file, line: Int = #line) {
        if message != nil {
            Logger.write("ERROR", message: message, function: function, file: file, line: line, color: .error)
        }
    }
    
    class func write(_ loglevel: String, message: String?, function: String, file: String, line: Int, color: Colors) {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.timeStyle = .medium
        dateFormatter.dateStyle = .medium
        //println(dateFormatter.stringFromDate(now)) // => 2014/12/11 15:19:04
        
        let nowdate = dateFormatter.string(from: now as Date)
        
        var filename = file
        if let match = filename.range(of: "[^/]*$", options: .regularExpression) {
            filename = filename.substring(with: match)
        }
        let _message = message != nil ? "\(nowdate) [\(loglevel)][\(filename) - \(function) \(line)] \(message!)" : ""
        
        switch color {
        case .debug:	ColorLog.debug(_message)
        case .info:		ColorLog.info(_message)
        case .warning:	ColorLog.warning(_message)
        case .error:	ColorLog.error(_message)
        case .success:	ColorLog.success(_message)
        }
        
    }
}

struct ColorLog {
    static let ESCAPE = "\u{001b}["
    
    static let RESET_FG = ESCAPE + "fg;" // Clear any foreground color
    static let RESET_BG = ESCAPE + "bg;" // Clear any background color
    static let RESET = ESCAPE + ";"   // Clear any foreground or background color
    
    static func error<T>(_ object: T) {
        print("\(ESCAPE)fg255,0,0;\(object)\(RESET)")
    }
    
    static func success<T>(_ object: T) {
        print("\(ESCAPE)fg200,238,90;\(object)\(RESET)")
    }
    
    static func debug<T>(_ object: T) {
        print("\(ESCAPE)fg115,171,236;\(object)\(RESET)")
    }
    
    static func warning<T>(_ object: T) {
        print("\(ESCAPE)fg245,156,35;\(object)\(RESET)")
    }
    
    static func purple<T>(_ object: T) {
        print("\(ESCAPE)fg255,0,255;\(object)\(RESET)")
    }
    
    static func info<T>(_ object: T) {
        print("\(ESCAPE)fg200,200,200;\(object)\(RESET)")
    }
}
