//
//  courseController.swift
//  TestCollectionView
//
//  Created by Yaoqi Shou on 6/19/20.
//  Copyright © 2020 Yaoqi Shou. All rights reserved.
//

import Foundation
class courseController{
    func fetchCourseInfo(url:URL,completion: @escaping ([detailCourse])-> Void){
        let task = URLSession.shared.dataTask(with: url){(data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let collection:[detailCourse] = try?  jsonDecoder.decode([detailCourse].self, from: data){
                completion(collection)
            }else{
                print("Either no data was returned, or data was not properly decoded.")
            }
        }
        task.resume()
    }

}
