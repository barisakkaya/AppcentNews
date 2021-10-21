//
//  ViewController.swift
//  AppcentNews
//
//  Created by Barış Can Akkaya on 21.10.2021.
//

import UIKit
import SnapKit
import Lottie

class ViewController: UIViewController {
    
    @IBOutlet weak var tapButtob: UIButton!
    var animationView: AnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        createLayout()
    }
    
    @IBAction func tapClicked(_ sender: UIButton) {
        animationView?.stop()
        performSegue(withIdentifier: "goToMain", sender: self)
    }
    
    func createLayout() {
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        animationView = AnimationView(name: "news")
        animationView?.loopMode = .loop
        view.addSubview(animationView!)
        animationView?.play()
        animationView?.snp.makeConstraints({ make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(0)
            make.centerX.equalToSuperview()
            make.width.equalTo(width)
            make.height.equalTo(width)
        })
        if let animationView = animationView {
            tapButtob.snp.makeConstraints { make in
                make.top.equalTo(animationView.snp.bottom).offset(height * 0.2)
                make.centerX.equalToSuperview()
                make.width.equalTo(width * 0.75)
                make.height.equalToSuperview().multipliedBy(0.08)
            }
        }
    }
    
}

