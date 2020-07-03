//
//  Snapshot Extension.swift
//  TestCollectionView
//
//  Created by Yaoqi Shou on 6/29/20.
//  Copyright © 2020 Yaoqi Shou. All rights reserved.
//

import Foundation
import FirebaseFirestore

extension QueryDocumentSnapshot{
    
    func decode<Type: Decodable> () throws -> Type {
        let jsonData = try JSONSerialization.data(withJSONObject: data(), options: [])
         let jsonDecoder = JSONDecoder()
        let object = try jsonDecoder.decode(Type.self, from: jsonData)
        return object
    }
    
}

extension QuerySnapshot{
    func decoded<Type: Decodable>() throws -> [Type]{
        let objects:[Type] = try documents.map({try $0.decode()})
        return objects 
        
    }
}

extension String {
    var formattedDate: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ssZZZZ"
        if let date = dateFormatter.date(from: self) {
            print(date)
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: date)
        }
        return nil
    }
}
