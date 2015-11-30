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
    var arregloNumTrazos: [Int] = [3,3,1,2,4,3,2,3,3,2,3,2,4,3,1,2,2,3,1,2,1,2,4,2,2,3]
    
    var letra: String? = "A"
    var numTrazos: Int? = 3
    
    @IBOutlet var lblMayus: UILabel!
    @IBOutlet var abecedario: UISegmentedControl!
    @IBOutlet var mayuscula: UISegmentedControl!
    @IBOutlet var abecedario1: UISegmentedControl!
    @IBOutlet var abecedario2: UISegmentedControl!
    @IBOutlet var abecedario3: UISegmentedControl!
    @IBOutlet var abecedario4: UISegmentedControl!
    
    @IBAction func SeleccionNivel(sender: UIButton) {
        if sender.titleLabel?.text == "Principiante"{
            seleccion = true
        }
        else{
            seleccion = false
        }
        
    }
    
    @IBAction func obtenerLetra(sender: AnyObject) {
        /*let letraIndex = arregloAbc[abecedario.selectedSegmentIndex]
        mayuscula.setTitle(letraIndex, forSegmentAtIndex: 0)
        mayuscula.setTitle(letraIndex.lowercaseString, forSegmentAtIndex: 1)*/
        
        
        switch sender as! UISegmentedControl{
        case abecedario:
            self.letra = arregloAbc[abecedario.selectedSegmentIndex]
            self.numTrazos = arregloNumTrazos[abecedario.selectedSegmentIndex]
            abecedario1.selectedSegmentIndex = -1
            abecedario2.selectedSegmentIndex = -1
            abecedario3.selectedSegmentIndex = -1
            abecedario4.selectedSegmentIndex = -1
            break
        case abecedario1:
            self.letra = arregloAbc[abecedario1.selectedSegmentIndex + 5]
            self.numTrazos = arregloNumTrazos[abecedario.selectedSegmentIndex + 5]
            abecedario.selectedSegmentIndex = -1
            abecedario2.selectedSegmentIndex = -1
            abecedario3.selectedSegmentIndex = -1
            abecedario4.selectedSegmentIndex = -1
            break
        case abecedario2:
            self.letra = arregloAbc[abecedario2.selectedSegmentIndex + 10]
            self.numTrazos = arregloNumTrazos[abecedario.selectedSegmentIndex + 10]
            abecedario.selectedSegmentIndex = -1
            abecedario1.selectedSegmentIndex = -1
            abecedario3.selectedSegmentIndex = -1
            abecedario4.selectedSegmentIndex = -1
            break
        case abecedario3:
            self.letra = arregloAbc[abecedario3.selectedSegmentIndex + 15]
            self.numTrazos = arregloNumTrazos[abecedario.selectedSegmentIndex + 15]
            abecedario.selectedSegmentIndex = -1
            abecedario1.selectedSegmentIndex = -1
            abecedario2.selectedSegmentIndex = -1
            abecedario4.selectedSegmentIndex = -1
            break
        case abecedario4:
            self.letra = arregloAbc[abecedario4.selectedSegmentIndex + 20]
            self.numTrazos = arregloNumTrazos[abecedario.selectedSegmentIndex + 20]
            abecedario.selectedSegmentIndex = -1
            abecedario1.selectedSegmentIndex = -1
            abecedario2.selectedSegmentIndex = -1
            abecedario3.selectedSegmentIndex = -1
            break
        default: break
        }
        mayuscula.setTitle(self.letra, forSegmentAtIndex: 0)
        mayuscula.setTitle(self.letra!.lowercaseString, forSegmentAtIndex: 1)
        
    }
    
    @IBAction func cambiarLblMayus(sender: AnyObject) {
        if sender.selectedSegmentIndex == 0{
            lblMayus.text = "Mayúscula"
        }else{
            lblMayus.text = "Minúscula"
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "principiante" {
            let destinoVC = segue.destinationViewController as! PrincipianteViewController
            
            destinoVC.letra = self.letra
            
            if mayuscula.selectedSegmentIndex == 0{
                destinoVC.mayuscula = true
            }
            else{
                destinoVC.mayuscula = false
            }
            
        }
            
        else if segue.identifier == "avanzado"{
            let destinoVC = segue.destinationViewController as! RecognizerViewController
            
            destinoVC.letra = self.letra
            destinoVC.numTrazos = self.numTrazos
            
            if mayuscula.selectedSegmentIndex == 0{
                destinoVC.mayuscula = true
            }
            else{
                destinoVC.mayuscula = false
            }
            
        }
        else{
            let destinoVC = segue.destinationViewController as! RandomViewController
            
            destinoVC.letra = self.letra
            destinoVC.numTrazos = self.numTrazos
            
            if mayuscula.selectedSegmentIndex == 0{
                destinoVC.mayuscula = true
            }
            else{
                destinoVC.mayuscula = false
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "fondo.jpg")!)
        abecedario.selectedSegmentIndex = 0
        
        let backButton = UIBarButtonItem(
            title: "Atrás",
            style: UIBarButtonItemStyle.Plain,
            target: nil,
            action: nil
        );
        
        self.navigationController!.navigationBar.topItem!.backBarButtonItem = backButton;
        
        abecedario.selectedSegmentIndex = 0
        abecedario1.selectedSegmentIndex = -1
        abecedario2.selectedSegmentIndex = -1
        abecedario3.selectedSegmentIndex = -1
        abecedario4.selectedSegmentIndex = -1
        
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
    
    
}