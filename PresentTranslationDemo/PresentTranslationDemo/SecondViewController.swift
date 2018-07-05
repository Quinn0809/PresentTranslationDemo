//
//  SecondViewController.swift
//  PresentTranslationDemo
//
//  Created by Quinn_F on 2018/6/2.
//  Copyright © 2018年 Quinn. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func gobackFirstVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
