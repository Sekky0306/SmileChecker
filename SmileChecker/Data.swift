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
}
