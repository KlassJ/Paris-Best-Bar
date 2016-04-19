//
//  Bar.swift
//  Paris Best Bars
//
//  Created by Vilayvone Bouahom on 18/04/16.
//  Copyright © 2016 Jbouahom. All rights reserved.
//

import UIKit

class Bar {
//MARK: Properties
    var id: Int
    var address: String
    var name : String
    var url : String
    var image_url: String
    var tags: String?
    var latitude: Float
    var longitude: Float

    

//MARK: Initialization
    init(id:Int,address:String,name:String,url:String,image_url:String,tags:String?,latitude:Float,longitude:Float){
        self.id=id
        self.address=address
        self.name=name
        self.url=url
        self.image_url=image_url
        self.tags=tags
        self.latitude=latitude
        self.longitude=longitude
    }
    
}