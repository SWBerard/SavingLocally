//
//  ObjectToSave.swift
//  Saving Locally
//
//  Created by Steven Berard on 8/3/16.
//  Copyright © 2016 Learn Swift LA. All rights reserved.
//

import UIKit

class ObjectToSave: NSObject, NSCoding {
    
    var stringToSave: String?
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        stringToSave = aDecoder.decodeObjectForKey("stringToSave") as? String ?? ""
        
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        print("ObjectToSave encoded properly")
        aCoder.encodeObject(stringToSave, forKey: "stringToSave")
    }
}
