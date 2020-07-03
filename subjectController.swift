//
//  subjectController.swift
//  courseCatalog
//
//  Created by Yaoqi Shou on 6/17/20.
//  Copyright © 2020 Yaoqi Shou. All rights reserved.
//

import Foundation
class subjectController{
func fetchClassInfo(index:Int,completion: @escaping ([clase])-> Void){
    let url = getUrlFromBook().book[index]
    let task = URLSession.shared.dataTask(with: url){(data, response, error) in
        let jsonDecoder = JSONDecoder()
        if let data = data,
            let collection:[clase] = try?  jsonDecoder.decode([clase].self, from: data){
            completion(collection)
        }else{
            print("Either no data was returned, or data was not properly decoded.")
        }
    }
    task.resume()
}

}
