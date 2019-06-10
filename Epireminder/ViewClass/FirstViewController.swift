//
//  FirstViewController.swift
//  Epireminder
//
//  Created by Maxime Gernath on 08/06/2019.
//  Copyright © 2019 MaximeCorp. All rights reserved.
//

import UIKit
import RealmSwift

class FirstViewController: UIViewController {
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Realm is located at:", realm.configuration.fileURL!)
        if (objectExist(id: 1) == true) {
            print("Autolog")
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Main")
                self.present(viewController, animated: false, completion: nil)
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login")
                self.present(viewController, animated: false, completion: nil)
            }
        }
        // Do any additional setup after loading the view.
    }

    func objectExist (id: Int) -> Bool {
        let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        Realm.Configuration.defaultConfiguration = config
        let realm = try! Realm()
        return realm.object(ofType: User.self, forPrimaryKey: id) != nil
    }
}
