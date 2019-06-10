//
//  Database.swift
//  Epireminder
//
//  Created by Maxime Gernath on 08/06/2019.
//  Copyright © 2019 MaximeCorp. All rights reserved.
//

import RealmSwift

class User: Object
{
    @objc dynamic var id = 1
    @objc dynamic var autoLog = ""
    @objc dynamic var email = ""
    @objc dynamic var year = ""

    override static func primaryKey() -> String? {
        return "id"
    }
}
