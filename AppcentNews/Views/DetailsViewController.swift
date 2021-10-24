//
//  ResultViewController.swift
//  AppcentNews
//
//  Created by Barış Can Akkaya on 21.10.2021.
//

import UIKit
import FirebaseFirestore
import SnapKit
import Kingfisher
import Firebase

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var likeButton: UIBarButtonItem!
    @IBOutlet weak var sourceButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    var titleText = ""
    var desc = ""
    var source = ""
    var date = ""
    var imgUrl = ""
    var contentText = ""
    var authorText = ""
    var url = ""
    var from = 0
    let db = Firestore.firestore()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if from == 1 {
            likeButton.isEnabled = false
            likeButton.tintColor = UIColor.clear
        }
        setLayout()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goToWebView") {
            if let destination = segue.destination as? UINavigationController {
                if let dest = destination.topViewController as? NewsSourceViewController{
                    dest.url = URL(string: url)
                }
            }
        }
    }
    @IBAction func souceClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "goToWebView", sender: nil)
    }
    
    @IBAction func dismissClicked(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func shareClicked(_ sender: UIBarButtonItem) {
        let ac = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        present(ac, animated: true)
    }
    @IBAction func likeClicked(_ sender: UIBarButtonItem) {
        if likeButton.image == UIImage(systemName: "heart") {
            let data = [
                "title": titleText,
                "description": desc,
                "date": date,
                "source": source,
                "imgUrl": imgUrl,
                "contentText": contentText,
                "authorText": authorText,
                "url": url,
] as [String: Any]
            likeButton.image = UIImage(systemName: "heart.fill")
            db.collection("Favorites").addDocument(data: data) { (error) in
                            if let error = error {
                                print(error.localizedDescription)
                            } else {
                                print("Başarılı")
                            }
                        }
            
        } else {
            likeButton.image = UIImage(systemName: "heart")
        }
    }
    
    func setLayout() {
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        scrollView.isPagingEnabled = true
        
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        scrollView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: self.view.frame.height * -0.15).isActive = true
        
        scrollView.contentSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height)
        
        
        let url = URL(string: imgUrl)
        imageView.kf.setImage(with: url)
        titleLabel.text = titleText
        authorLabel.text = authorText
        descriptionLabel.text = desc
        contentLabel.text = contentText
        dateLabel.text = date
        
        
        
        imageView.snp.makeConstraints { make in
            make.height.equalTo(width * 0.45)
            make.top.equalTo(height * 0.02)
            make.centerX.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(width * 0.95)
            make.top.equalTo(self.imageView.snp.bottom).offset(height * 0.02)
        }
        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(height * 0.02)
            make.width.equalTo(width * 0.95)
            make.centerX.equalToSuperview()
        }
        dateLabel.snp.makeConstraints { make in
            make.width.equalTo(width * 0.95)
            make.top.equalTo(self.authorLabel.snp.bottom).offset(height * 0.02)
            make.centerX.equalToSuperview()
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.dateLabel.snp.bottom).offset(height * 0.02)
            make.centerX.equalToSuperview()
            make.width.equalTo(width * 0.95)
        }
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(self.descriptionLabel.snp.bottom).offset(height * 0.02)
            make.centerX.equalToSuperview()
            make.width.equalTo(width * 0.95)
        }
        sourceButton.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.75)
            make.centerX.equalToSuperview()
            make.height.equalTo(height * 0.066)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(height * -0.03)
        }
        
        
    }
    
}
