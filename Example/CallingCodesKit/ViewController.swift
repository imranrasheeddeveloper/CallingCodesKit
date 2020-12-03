//
//  ViewController.swift
//  CallingCodesKit
//
//  Created by imranrasheeddeveloper on 12/03/2020.
//  Copyright (c) 2020 imranrasheeddeveloper. All rights reserved.
//

import UIKit
import CallingCodesKit
class ViewController: UIViewController,callingCodeData {
    
   @IBOutlet weak var textLabel  : UILabel!

    func countryCodeAndFlag(name: String, flag: String, code: String, dialCode: String) {
        textLabel.text = "\(flag) \(name) \(dialCode)"
    }
    @objc func callingCodeVC(){
        let vc = CallingCodesVC()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(callingCodeVC))
        textLabel.addGestureRecognizer(tap)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

