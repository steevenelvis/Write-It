//
//  ViewController.swift
//  proyecto
//
//  Created by Steeven Elvis Muñoz Pincay on 14/09/15.
//  Copyright (c) 2015 Steeven Elvis Muñoz Pincay. All rights reserved.
//

import UIKit


class SelecNivelViewController: UIViewController {
    
    var seleccion: BooleanType = true
    var arregloAbc: [String] = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    
    
    @IBOutlet var abecedario: UISegmentedControl!
    @IBOutlet var mayuscula: UISegmentedControl!
    
    @IBAction func SeleccionNivel(sender: UIButton) {
        if sender.titleLabel?.text == "Principiante"{
            seleccion = true
        }
        else{
            seleccion = false
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "principiante" {
            let destinoVC = segue.destinationViewController as! ViewController
            
            destinoVC.nombreLetra = arregloAbc[abecedario.selectedSegmentIndex]
            
            if mayuscula.selectedSegmentIndex == 0{
                destinoVC.mayuscula = false
            }
            else{
                destinoVC.mayuscula = true
            }
            
        }
            
        else{
            let destinoVC = segue.destinationViewController as! RecognizerViewController
            
            destinoVC.letra = arregloAbc[abecedario.selectedSegmentIndex]
            
            if mayuscula.selectedSegmentIndex == 0{
                destinoVC.mayuscula = false
            }
            else{
                destinoVC.mayuscula = true
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "fondo.jpg")!)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}