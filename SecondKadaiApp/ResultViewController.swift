//
//  ResultViewController.swift
//  SecondKadaiApp
//
//  Created by AiTH2 on 2018/12/08.
//  Copyright © 2018 hirohisa.kimura. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    var resultStr: String?
    
    @IBOutlet weak var backButton: UIButton!
    @IBAction func back(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backButton.backgroundColor = UIColor.init(hex: "ffffff")
        backButton.layer.borderWidth = 1.0
        backButton.layer.borderColor = UIColor.init(hex: "f0f0f0").cgColor
        backButton.layer.cornerRadius = 25
        backButton.setTitleColor(UIColor.init(hex: "e000e0"), for: .normal)
        
        if resultStr!.count == 0 {resultStr = "名無し"}
        resultLabel.text = "こんにちは、" + resultStr! + " さん"
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
