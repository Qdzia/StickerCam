//
//  Log.swift
//  StickerCam
//
//  Created by Łukasz Kudzia on 26/06/2023.
//

import Foundation

class Log: NSObject {
    static func error(_ error: Error) {
        print("\(error)")
    }
}
