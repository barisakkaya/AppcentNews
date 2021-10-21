//
//  NewsViewModel.swift
//  AppcentNews
//
//  Created by Barış Can Akkaya on 21.10.2021.
//

import Foundation

struct NewsViewModel {
    let newsModel: News?
}

extension NewsViewModel {
    
    init(_ newsModel: News) {
        self.newsModel = newsModel
    }
    
    
    
    //    var base: String {
    //        return self.newsModel. ?? "nil"
    //    }
    //
    //    var rates: [String: Double] {
    //        return currencyModel?.rates ?? ["nil": 3.14]
    //    }
    
}
