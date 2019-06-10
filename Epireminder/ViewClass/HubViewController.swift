//
//  HubViewController.swift
//  Epireminder
//
//  Created by Maxime Gernath on 03/05/2019.
//  Copyright © 2019 MaximeCorp. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire

class HubViewController: UIViewController {
    
    @IBOutlet weak var Talk3: UILabel!
    @IBOutlet weak var Talk5: UILabel!
    @IBOutlet weak var Talk8: UILabel!
    @IBOutlet weak var Exp3: UILabel!
    @IBOutlet weak var Exp5: UILabel!
    @IBOutlet weak var Exp8: UILabel!
    @IBOutlet weak var Fruit3: UILabel!
    @IBOutlet weak var Fruit5: UILabel!
    @IBOutlet weak var Fruit8: UILabel!
    @IBOutlet weak var Sharing5: UILabel!
    @IBOutlet weak var Sharing8: UILabel!
    @IBOutlet weak var Check3: UIImageView!
    @IBOutlet weak var Check5: UIImageView!
    @IBOutlet weak var Check8: UIImageView!
    
    let realm = try! Realm()
    var nbTalk = 0
    var nbWork = 0
    var nbShare = 0
    var nbMaker = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        Check3.alpha = 0
        Check5.alpha = 0
        Check8.alpha = 0

        let parameters: Parameters = [:]
        let user = realm.objects(User.self).first._rlmInferWrappedType()

        Alamofire.request("https://intra.epitech.eu/\(user.autoLog)/module/\(user.year)/B-INN-000/PAR-0-1/?format=json",
            method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .responseString { response in
                do {
                    let hubWork : Hub = try JSONDecoder().decode(Hub.self, from: response.data!)
                    hubWork.activites.forEach({ (hubElem) in
                        hubElem.events.forEach({ (hubEvent) in
                            if (hubElem.title.contains(user.email)) {
                                print("Sharing")
                                self.nbShare = self.nbShare + 1
                            }
                            if (hubEvent.userStatus == "present") {
                                print(hubElem.title)
                                self.nbWork = self.nbWork + 1
                            }
                        })
                    })
                } catch { print("fail work") }
        }
        
        Alamofire.request("https://intra.epitech.eu/\(user.autoLog)/module/2018/B-INN-001/PAR-0-1/?format=json",
            method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .responseString { response in
                do {
                    let hubTalk : Hub = try JSONDecoder().decode(Hub.self, from: response.data!)
                    hubTalk.activites.forEach({ (hubElem) in
                        hubElem.events.forEach({ (hubEvent) in
                            if (hubEvent.userStatus == "present") {
                                print(hubElem.title)
                                self.nbTalk = self.nbTalk + 1
                            }
                        })
                    })
                } catch { print("fail talk") }
                self.updateview()
        }
        // Do any additional setup after loading the view.
    }
    func updateview() {
        Talk3.text = "\(nbTalk)/4"
        Talk5.text = "\(nbTalk)/4"
        Talk8.text = "\(nbTalk)/4"
        Exp3.text = "\(nbWork)/3"
        Exp5.text = "\(nbWork)/3"
        Exp8.text = "\(nbWork)/3"
        Fruit3.text = "0/1"
        Fruit3.text = "0/1"
        Fruit8.text = "0/2"
        Sharing5.text = "\(nbShare)/1"
        Sharing8.text = "\(nbShare)/2"
        if (nbTalk >= 4 && nbWork >= 3 && nbMaker >= 1) {
            Check3.alpha = 100
        }
        if (nbTalk >= 4 && nbWork >= 3 && nbShare >= 1 && nbMaker >= 1) {
            Check5.alpha = 100
        }
        if (nbTalk >= 4 && nbWork >= 3 && nbShare >= 2 && nbMaker >= 2) {
            Check8.alpha = 100
        }
    }
}
