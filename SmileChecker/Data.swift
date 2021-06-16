//
//  Data.swift
//  SmileChecker
//
//  Created by 関戸優紀 on 2021/05/26.
//

import Foundation
import RealmSwift

class Content: Object {
@objc dynamic var level:  Int = 0
@objc dynamic var place: String = ""
@objc dynamic var topic: String = ""
@objc dynamic var score: String = ""
@objc dynamic var data: NSData!


//let pictureDates = List<PictureData>()
}

class PictureData: Object {
    // 写真を保存するdata
@objc dynamic var data: NSData!
   
}
