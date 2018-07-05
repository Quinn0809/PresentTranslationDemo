//
//  FirstViewController.swift
//  PresentTranslationDemo
//
//  Created by Quinn_F on 2018/6/2.
//  Copyright © 2018年 Quinn. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toSecondVC(_ sender: Any) {
    
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        let translate:QTransitionController = QTransitionController()
        translate.presentType = .fadeIn
        translate.dismissType = .fadeOut
        vc.transitioningDelegate = translate
        self.present(vc, animated: true, completion: nil)
    }
    


}
