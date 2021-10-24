//
//  FavoritesViewController.swift
//  AppcentNews
//
//  Created by Barış Can Akkaya on 21.10.2021.
//

import UIKit
import SnapKit
import Kingfisher
import FirebaseFirestore

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var favLabel: UILabel!
    
    var newsArrayViewModel: NewsArrayViewModel!
    var titleText = ""
    var desc = ""
    var source = ""
    var date = ""
    var imgUrl = ""
    var contentText = ""
    var authorText = ""
    var url = ""
    var datas = [[String: Any]]()
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createLayout()
        tableView.dataSource = self
        tableView.delegate = self
        getDatas()
        print("datas: \(datas)")
        
    }
    
    func getDatas() {
        createLayout()
        db.collection("Favorites").getDocuments() { snapshot, error in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        if let snapshot = snapshot {
                            self.datas.removeAll()
                            for doc in snapshot.documents {
                                self.datas.append(["authorText":doc.get("authorText")!,"contentText":doc.get("contentText")!,"date":doc.get("date")!,"description":doc.get("description")!,"imgUrl":doc.get("imgUrl")!,"source":doc.get("source")!,"title":doc.get("title")!,"url":doc.get("url")!])
                            }
                            self.tableView.reloadData()
                        }
                    }
                }
    }
    
    func createLayout() {
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        favLabel.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(0)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.favLabel.snp.bottom).offset(0)
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(0)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toDetailsVC2") {
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
                    dest.from = 1
                }
            }
        }
    }
    
    func setLayout(cell: inout FavoritesTableViewCell, height: CGFloat, width: CGFloat) {
        
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
        }
        cell.newsImageView.snp.makeConstraints { make in
            make.top.equalTo(cell.titleLabel.snp_bottomMargin).offset(height * 0.04)
            make.trailing.equalTo(width * -0.01)
            make.width.equalTo(width * 0.36)
            make.height.equalTo(height * 0.1)
        }
        cell.sourceLabel.snp.makeConstraints { make in
            make.width.equalTo(width * 0.5)
            make.top.equalTo(cell.descriptionLabel.snp.bottom).offset(height * 0.02)
            make.leading.equalTo(width * 0.02)
            make.bottom.equalTo(height * -0.035)
        }
        cell.dateLabel.snp.makeConstraints { make in
            make.width.equalTo(width * 0.45)
            make.top.equalTo(cell.descriptionLabel.snp.bottom).offset(height * 0.02)
            make.trailing.equalTo(width * -0.02)
            make.bottom.equalTo(height * -0.035)
        }
        
    }

}

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        var cell = tableView.dequeueReusableCell(withIdentifier: "favoritesCell", for: indexPath) as! FavoritesTableViewCell
        let data = datas[indexPath.row]
        
        cell.titleLabel.text = data["title"] as? String
        cell.titleLabel.font = cell.titleLabel.font.withSize(height * 0.04)
        cell.dateLabel.text = data["description"] as? String
        let url = URL(string: data["imgUrl"] as? String ?? "")
        cell.newsImageView.kf.setImage(with: url)
        cell.sourceLabel.text = "-\(data["source"] as? String ?? "Unknown")"
        cell.dateLabel.text = data["date"] as? String
        cell.dateLabel.font = cell.dateLabel.font.withSize(height * 0.02)
        cell.descriptionLabel.text = data["description"] as? String
        
        setLayout(cell: &cell, height: height, width: width)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newsViewModel = datas[indexPath.row]
        
        titleText = newsViewModel["title"] as? String ?? ""
        desc = newsViewModel["description"] as? String ?? ""
        imgUrl = newsViewModel["imgUrl"] as? String ?? ""
        date = newsViewModel["date"] as? String ?? ""
        source = newsViewModel["title"] as? String ?? ""
        contentText = newsViewModel["contentText"] as? String ?? ""
        url = newsViewModel["url"] as? String ?? ""
        authorText = newsViewModel["authorText"] as? String ?? ""
        
        performSegue(withIdentifier: "toDetailsVC2", sender: nil)
    }

}
