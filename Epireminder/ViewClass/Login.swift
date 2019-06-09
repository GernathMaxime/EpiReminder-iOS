//
//  Login.swift
//  Epireminder
//
//  Created by Maxime Gernath on 02/05/2019.
//  Copyright © 2019 MaximeCorp. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire

class Login: UIViewController {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet weak var autologTextField: UITextField!

    @IBAction func intraConnectionButton(_ sender: Any) {
        if let url = URL(string: "https://intra.epitech.eu/admin/autolog"),
            UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:])
        }
    }

    @IBAction func loginButton(_ sender: Any) {
        let myString = autologTextField.text

        if (myString == "") {
            print("fail")
        } else {
            print(String(myString!.dropFirst(25)))
            let parameters: Parameters = [:]

//            Alamofire.request("https://intra.epitech.eu/\(String(myString!.dropFirst(25)))/module/2018/B-INN-000/PAR-0-1/?format=json",
//                method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
//                .responseString { response in
//                    do {
//                        let hubWork : Hub = try JSONDecoder().decode(Hub.self, from: response.data!)
//                        hubWork.activites.forEach({ (hubElem) in
//                            hubElem.events.forEach({ (hubEvent) in
//                                if (hubElem.title.contains("maxime.gernath@epitech.eu")) {
//                                    print("Sharing")
//                                    self.nbShare = self.nbShare + 1
//                                }
//                                if (hubEvent.userStatus == "present") {
//                                    print(hubElem.title)
//                                    self.nbWork = self.nbWork + 1
//                                }
//                            })
//                        })
//                    } catch { print("fail work") }
//            }
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Main")
            self.present(viewController, animated: false, completion: nil)
            let realm = try! Realm()
            print("\nSaving model in the database\n")
            try! realm.write {
                realm.create(User.self, value: ["ip": 1, "autoLog": String(myString!.dropFirst(25))], update: true)
            }
        }

        // Mettre dans la base de données Realm
    }
}
