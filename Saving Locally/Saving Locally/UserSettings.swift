//
//  UserSettings.swift
//  Saving Locally
//
//  Created by Steven Berard on 8/3/16.
//  Copyright © 2016 Learn Swift LA. All rights reserved.
//

import UIKit

class UserSettings: NSObject, NSCoding {
    
    var arrayOfObjects = [ObjectToSave]()

    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init()
        
        guard let arrayOfObjects = aDecoder.decodeObject(forKey: "arrayOfObjects") as? [ObjectToSave] else {
            
                print("Decoding arrayOfObjects failed")
                return
        }
        
        self.arrayOfObjects = arrayOfObjects
    }
    
    func encode(with aCoder: NSCoder) {
        print("UserSetting encoded properly")
        aCoder.encode(arrayOfObjects, forKey: "arrayOfObjects")
    }
}
