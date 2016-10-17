//
//  Logger.swift
//  Logger
//
//  Created by Satomi Suyama on 1/9/16.
//  Copyright © 2016 amysound. All rights reserved.
//

import Foundation

class Logger {

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
        Logger.info("\(nowdate) [\(filename) - \(function) \(line)]")
    }

    class func debug(_ message: String, function: String = #function, file: String = #file, line: Int = #line) {
        Logger.write("DEBUG", message: message, function: function, file: file, line: line)
    }

    class func info(_ message: String, function: String = #function, file: String = #file, line: Int = #line) {
        Logger.write("INFO", message: message, function: function, file: file, line: line)
    }

    class func success(_ message: String, function: String = #function, file: String = #file, line: Int = #line) {
        Logger.write("SUCCESS", message: message, function: function, file: file, line: line)
    }

    class func warning(_ message: String, function: String = #function, file: String = #file, line: Int = #line) {
        Logger.write("WARNING", message: message, function: function, file: file, line: line)
    }

    class func error(_ message: String?, function: String = #function, file: String = #file, line: Int = #line) {
        if message != nil {
            Logger.write("ERROR", message: message, function: function, file: file, line: line)
        }
    }

    class func write(_ loglevel: String, message: String?, function: String, file: String, line: Int) {
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
        
        print(_message)
    }
}
