//
//  PhrasePodket.swift
//  PhrasePocket
//
//  Created by 森 仁奈 on 2021/12/12.
//

import Foundation
import RealmSwift

class Phrase: Object{
 @objc dynamic var content: String = ""
@objc dynamic var type: String = ""
}
