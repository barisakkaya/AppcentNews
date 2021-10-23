//
//  Service.swift
//  AppcentNews
//
//  Created by Barış Can Akkaya on 21.10.2021.
//

import Foundation
import Alamofire

class Service {
    
    func httpRequest(url: URL, completionHandler: @escaping (News?) -> ()) {
        
        AF.request(url, method: .get)
            .validate()
            .responseDecodable(of: News.self) { (response) in
                if let model = response.value {
                    completionHandler(model)
                }
            }
    }
}
    
    
