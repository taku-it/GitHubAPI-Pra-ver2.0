//
//  ViewController.swift
//  APIPractice3
//
//  Created by 生田拓登 on 2021/05/17.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    
    var userName = String()
    var responseImageString = String()
    @IBOutlet weak var errorLabel: UILabel!
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.delegate = self
        errorLabel.adjustsFontSizeToFitWidth = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true

    }
    
    @IBAction func search(_ sender: Any) {
        errorLabel.text = ""
        
        if searchTextField.text == ""{
            errorLabel.text = "Please Enter GitHub Account Name."
        }else{
            userName = searchTextField.text!
            getUserImage(userName: userName)
        }
    }
    
    func getUserImage(userName: String){
        let url = "https://api.github.com/search/users?q=\(userName)"
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (resonse) in
            
            switch resonse.result{
            
            case .success(_):
                
                let json: JSON = JSON(resonse.data as Any)
                let imageString = json["items"][self.count]["avatar_url"].string
                
                if imageString != nil{
                    print("found user")
                    self.responseImageString = imageString!
                    self.performSegue(withIdentifier: "next", sender: nil)
                    
                }else{
                    self.errorLabel.text = "not found user"
                }
            
            case .failure(let error):
                print(error)
            }
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as? DetailViewController
        detailVC?.responseImageString = responseImageString
        detailVC?.userName = userName
    }
    
}

extension ViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        userName = searchTextField.text!
        return true
    }
    
}
