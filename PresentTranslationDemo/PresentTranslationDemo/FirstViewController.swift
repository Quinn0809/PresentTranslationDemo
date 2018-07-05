//
//  FirstViewController.swift
//  PresentTranslationDemo
//
//  Created by Quinn_F on 2018/6/2.
//  Copyright © 2018年 Quinn. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var bt: UIButton!
    let translate:QTransitionController = QTransitionController()
    let moveView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        moveView.frame = CGRect.init(x: 0, y: 330, width: 20, height: 20)
        moveView.backgroundColor = .red
        view.addSubview(moveView)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toSecondVC(_ sender: Any) {
        
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        translate.presentType = .viewIn
        translate.dismissType = .fadeOut
        translate.fromView = bt
        vc.transitioningDelegate = translate
        
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
}
