//
//  ViewController.swift
//  proyecto
//
//  Created by Steeven Elvis Muñoz Pincay on 14/09/15.
//  Copyright (c) 2015 Steeven Elvis Muñoz Pincay. All rights reserved.
//

import UIKit


class AjustesViewController: UIViewController {
    
    @IBOutlet weak var lblUsuario: UITextField!
    @IBOutlet weak var lblDestinatarios: UITextField!
    @IBOutlet weak var lblGuardados: UILabel!
    
    var usuario = NSUserDefaults.standardUserDefaults()
    var destinatarios = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "fondo.jpg")!)
        let bgImage     = UIImage(named: "fondo3.jpg");
        let imageView   = UIImageView(frame: self.view.bounds);
        imageView.image = bgImage
        self.view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        
        let backButton = UIBarButtonItem(
            title: "Atrás",
            style: UIBarButtonItemStyle.Plain,
            target: nil,
            action: nil
        );
        self.navigationController!.navigationBar.topItem!.backBarButtonItem = backButton;
        
        let usuario = NSUserDefaults.standardUserDefaults()
        if usuario.valueForKey("Usuario") != nil{
            lblUsuario.text = usuario.valueForKey("Usuario") as? String
        }
        let destinatarios = NSUserDefaults.standardUserDefaults()
        if destinatarios.valueForKey("Destinatarios") != nil{
            lblDestinatarios.text = destinatarios.valueForKey("Destinatarios") as? String
        }
        
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
    
    @IBAction func guardarAjustes(sender: AnyObject) {
        usuario.setValue(lblUsuario.text, forKey: "Usuario")
        destinatarios.setValue(lblDestinatarios.text, forKey: "Destinatarios")
        usuario.synchronize()
        destinatarios.synchronize()
    
        lblGuardados.hidden = false
    }
}