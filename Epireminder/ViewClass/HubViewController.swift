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
    let realm = try! Realm()
    var nbTalk = 0
    var nbWork = 0
    var nbShare = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        let parameters: Parameters = [:]
        let user = realm.objects(User.self).first._rlmInferWrappedType()

        Alamofire.request("https://intra.epitech.eu/\(user.autoLog)/module/2018/B-INN-000/PAR-0-1/?format=json",
            method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .responseString { response in
                do {
                    let hubWork : Hub = try JSONDecoder().decode(Hub.self, from: response.data!)
                    hubWork.activites.forEach({ (hubElem) in
                        hubElem.events.forEach({ (hubEvent) in
                            if (hubElem.title.contains("maxime.gernath@epitech.eu")) {
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
        }
        // Do any additional setup after loading the view.
    }
}
