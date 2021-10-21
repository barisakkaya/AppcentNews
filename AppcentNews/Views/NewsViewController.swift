//
//  NewsViewController.swift
//  AppcentNews
//
//  Created by Barış Can Akkaya on 21.10.2021.
//

import UIKit

class NewsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: CustomTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        createLayout()
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
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
            make.top.equalTo(self.textField.snp.bottom).offset(height * 0.02)
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(0)
        }
        
    }
    
}

extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell") as! NewsTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToResult", sender: self)
    }
    
}
