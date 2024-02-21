//
//  RouterViewController.swift
//  MyProjectMaxim
//
//  Created by 1 on 13.01.2024.
//

import Foundation
import UIKit

class RouterViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        clearDefaults()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Keys.age != "Error" && Keys.age != nil && Keys.gender != "Error" && Keys.gender != nil && Keys.height != "Error" && Keys.height != nil && Keys.weight != "Error" && Keys.weight != nil {
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "Home")
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false, completion: nil)
        } else {
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "Start")
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false, completion: nil)
        }
    }
    
    func clearDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
}
