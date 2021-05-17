//
//  DetailViewController.swift
//  APIPractice3
//
//  Created by 生田拓登 on 2021/05/17.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {

    var responseImageString = String()
    var userName = String()
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userImageView.layer.cornerRadius = 75
        userImageView.layer.borderWidth = 2
        userImageView.layer.borderColor = UIColor.black.cgColor
        nameLabel.text = userName
        userImageView.sd_setImage(with: URL(string: responseImageString), completed: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }

    
}
