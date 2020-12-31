//
//  itemModel.swift
//  Todoey
//
//  Created by Álvaro Santillan on 12/30/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

// For item to be encodable and decodable all properties must use standard data types.
struct ItemModel: Codable {
    var name: String = ""
    var done: Bool = false
}
