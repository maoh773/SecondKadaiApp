//
//  ViewController.swift
//  SecondKadaiApp
//
//  Created by AiTH2 on 2018/12/08.
//  Copyright © 2018 hirohisa.kimura. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var button: UIButton!
    
    var rippleTransition = ViewControllerTransition()
    
    @IBAction func goResult(_ sender: UIButton) {
        
        let vc = UIStoryboard(name: "Main",bundle: nil)
            .instantiateViewController(withIdentifier: "resultViewController") as! ResultViewController
        vc.transitioningDelegate = rippleTransition
        vc.resultStr = textField.text
        present(vc, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.returnKeyType = .done
        textField.delegate = self
        
        button.backgroundColor = UIColor.init(hex: "e000e0")
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.init(hex: "ff00ff").cgColor
        button.layer.cornerRadius = 25
        button.setTitleColor(UIColor.white, for: .normal)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        textField.resignFirstResponder()
        return true
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }

}

