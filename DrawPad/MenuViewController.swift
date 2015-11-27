//
//  ViewController.swift
//  proyecto
//
//  Created by Steeven Elvis Muñoz Pincay on 14/09/15.
//  Copyright (c) 2015 Steeven Elvis Muñoz Pincay. All rights reserved.
//

import UIKit


class MenuViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "fondo.jpg")!)
        let bgImage     = UIImage(named: "fondo3.jpg");
        let imageView   = UIImageView(frame: self.view.bounds);
        imageView.image = bgImage
        self.view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldAutorotate() -> Bool {
    
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
}