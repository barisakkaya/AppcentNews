//
//  NewsViewController.swift
//  AppcentNews
//
//  Created by Barış Can Akkaya on 21.10.2021.
//

import UIKit
import SnapKit
import Kingfisher

class NewsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: CustomTextField!
    var newsArrayViewModel: NewsArrayViewModel!
    var textFieldText: String?
    var titleText = ""
    var desc = ""
    var source = ""
    var date = ""
    var imgUrl = ""
    var contentText = ""
    var authorText = ""
    var url = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createLayout()
        tableView.dataSource = self
        tableView.delegate = self
        textField.searchButton.addTarget(self, action: #selector(searchClicked), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    @objc func searchClicked(sender: UIButton) {
        if let text = textField.text {
            if let url = URL(string: "https://newsapi.org/v2/everything?q=\(text)&apiKey=69c66990c2124ef7b447612fbebd9431") {
                print("url : \(url)")
                Service().httpRequest(url: url) { news in
                    if let news = news {
                        self.newsArrayViewModel = NewsArrayViewModel(news)
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
            
        }
        
    }
    
    
    func createLayout() {
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        label.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(10)
            make.width.equalToSuperview().multipliedBy(0.9)
            make.centerX.equalToSuperview()
        }
        label.font = label.font.withSize(height / 20)
        textField.snp.makeConstraints { make in
            make.top.equalTo(self.label.snp.bottom).offset(height * 0.02)
            make.width.equalToSuperview().multipliedBy(0.9)
            make.centerX.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.06)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.textField.snp.bottom).offset(0)
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(0)
        }
        
    }
    
    func setLayout(cell: inout NewsTableViewCell, height: CGFloat, width: CGFloat) {
        
        cell.contentView.frame.size.width = width
        
        cell.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(height * 0.02)
            make.width.equalTo(width * 0.8)
            make.centerX.equalToSuperview()
        }
        cell.descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(cell.titleLabel.snp_bottomMargin).offset(height * 0.04)
            make.leading.equalTo(width * 0.01)
            make.width.equalTo(width * 0.60)
            make.height.equalTo(height * 0.1)
        }
        cell.newsImageView.snp.makeConstraints { make in
            make.top.equalTo(cell.titleLabel.snp_bottomMargin).offset(height * 0.04)
            make.trailing.equalTo(width * -0.01)
            make.width.equalTo(width * 0.36)
            make.height.equalTo(height * 0.1)
        }
        cell.sourceLabel.snp.makeConstraints { make in
            make.width.equalTo(width * 0.47)
            make.top.equalTo(cell.descriptionLabel.snp.bottom).offset(height * 0.02)
            make.leading.equalTo(width * 0.02)
            make.bottom.equalTo(height * -0.035)
        }
        cell.dateLabel.snp.makeConstraints { make in
            make.width.equalTo(width * 0.47)
            make.top.equalTo(cell.descriptionLabel.snp.bottom).offset(height * 0.02)
            make.trailing.equalTo(width * -0.02)
            make.bottom.equalTo(height * -0.035)
        }
        
    }
    
  
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toDetailsVC") {
            if let destination = segue.destination as? UINavigationController {
                if let dest = destination.topViewController as? DetailsViewController{
                    dest.titleText = titleText
                    dest.desc = desc
                    dest.authorText = authorText
                    dest.date = date
                    dest.contentText = contentText
                    dest.imgUrl = imgUrl
                    dest.url = url
                    dest.source = source
                }
            }
        }
    }
}

extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsArrayViewModel == nil ? 0 : self.newsArrayViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        var cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableViewCell
        let newsViewModel = self.newsArrayViewModel.newsAtIndex(indexPath.row)
        
        cell.titleLabel.text = newsViewModel.title
        cell.titleLabel.font = cell.titleLabel.font.withSize(height * 0.025)
        cell.descriptionLabel.text = newsViewModel.description
        let url = URL(string: newsViewModel.picUrl)
        cell.newsImageView.kf.setImage(with: url)
        cell.sourceLabel.text = "-\(newsViewModel.source)"
        cell.dateLabel.text = newsViewModel.date
        
        setLayout(cell: &cell, height: height, width: width)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Tap tap")
        let newsViewModel = self.newsArrayViewModel.newsAtIndex(indexPath.row)
        
        titleText = newsViewModel.title
        desc = newsViewModel.description
        imgUrl = newsViewModel.picUrl
        date = newsViewModel.date
        source = newsViewModel.source
        contentText = newsViewModel.content
        url = newsViewModel.url
        authorText = newsViewModel.author
        
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
}
