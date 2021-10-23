//
//  NewsViewModel.swift
//  AppcentNews
//
//  Created by Barış Can Akkaya on 21.10.2021.
//

import Foundation

struct NewsArrayViewModel {
    let news: News
}
extension NewsArrayViewModel {
    init(_ news: News) {
        self.news = news
    }
    func newsAtIndex(_ index: Int) -> ArticlesViewModel {
        let news = self.news.articles?[index]
        return ArticlesViewModel(article: news!)
    }
    func numberOfRowsInSection() -> Int{
        return self.news.totalResults ?? 0
    }
}

struct ArticlesViewModel {
    let article: Article
}
extension ArticlesViewModel {
    init(_ article: Article) {
        self.article = article
    }
    var title: String {
        if let data = self.article.title {
            return data
        }
        return ""
    }
    var description: String {
        if let data = self.article.description {
            return data
        }
        return ""
    }
    var picUrl: String {
        if let data = self.article.urlToImage {
            return data
        }
        return ""
    }
    var content: String {
        if let data = self.article.content {
            return data
        }
        return ""
    }
    var date: String {
        if let data = self.article.publishedAt {
            return data
        }
        return ""
    }
    var source: String {
        if let source = self.article.source?.name {
            return source
        }
        return ""
    }
    var url: String {
        if let url = self.article.url {
            return url
        }
        return ""
    }
    var author: String {
        if let author = self.article.author {
            return author
        }
        return ""
    }
}

