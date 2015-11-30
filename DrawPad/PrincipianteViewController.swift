//
//  ViewController.swift
//  PathRecognizer
//
//  Created by Didier Brun on 15/03/2015.
//  Copyright (c) 2015 Didier Brun. All rights reserved.
//

import UIKit
import AVFoundation
import MessageUI

class PrincipianteViewController: UIViewController,MFMailComposeViewControllerDelegate {
    
    private var player: AVAudioPlayer = AVAudioPlayer()
   
    var image: UIImage?
    
    @IBAction func reset(sender: AnyObject) {
        self.arreglo = []
        self.renderView.arreglo = []
        self.lblResultado.text = ""
        
    }
    @IBAction func reproducir(sender: AnyObject) {
        if self.player.playing{
            self.player.stop()
        }
        self.player.play()
        
    }
    @IBAction func btnRevisar(sender: AnyObject) {
        var path:Path = Path()
        //path.addPointFromRaw(arreglo.last!)
        
        var gesture:PathModel? = self.recognizer!.recognizePath(path)   // comparar el trazo con los trazos predeterminados
        for var index = 0; index < arreglo.count ;++index {
            path.addPointFromRaw(arreglo[index])
            //print(arreglo[index]
            gesture = self.recognizer!.recognizePath(path)
        }
        //letter.text = gesture!.datas as? String
        print(gesture?.datas as? String)
        if gesture?.datas as? String == letra {
            lblResultado.text = " Es correcto"
            print("correcto")
        } else {
            lblResultado.text = " Es incorrecto, prueba otra vez"
        }
        arreglo=[]
        
    }
    var indice:Int = 0
    var arreglo:[[Int]] = []
    //var rawPoints:[Int] = []
    var recognizer:DBPathRecognizer?
    var mayuscula:DarwinBoolean?
    var letra:String?
    var numTrazos:Int?
    
    @IBOutlet weak var letter: UILabel!
    @IBOutlet weak var renderView: RenderView!
    @IBOutlet weak var lblResultado: UILabel!
    
    enum FilterOperation {
        case Maximum
        case Minimum
    }
    
    enum FilterField {
        case LastPointX
        case LastPointY
    }
    
    override func viewDidLoad() {
        
        
        let letterImage = UIImageView()
        if self.mayuscula?.boolValue == true{
            letterImage.image = UIImage(named: letra!)
        }
        else{
            letterImage.image = UIImage(named: "\(letra!.lowercaseString)-1")
        }
        
        
        letterImage.frame.size.height = 300
        letterImage.frame.size.width = 300
        letterImage.center = self.view.center
        
        self.view.addSubview(letterImage)
        view.sendSubviewToBack(letterImage)
        
        if mayuscula == false{
            self.letra = letra?.lowercaseString
        }
        
        self.letter.text = letra
        
        let recognizer = DBPathRecognizer(sliceCount: 8, deltaMove: 16.0)
        
        let palabraImage = UIImageView()
        palabraImage.image = UIImage(named: "\(letra!.lowercaseString)_i")
        
        palabraImage.frame.size.height = 150
        palabraImage.frame.size.width = 450
        palabraImage.frame.origin.y = self.view.bounds.size.height - palabraImage.frame.size.height - 5
        palabraImage.frame.origin.x = (self.view.bounds.size.width - palabraImage.frame.size.width) / 2.0
        
        self.view.addSubview(palabraImage)
        view.sendSubviewToBack(palabraImage)
        
        let maxy3 = PrincipianteViewController.customFilter(self)(.Maximum, .LastPointY, 0.3)
        let miny3 = PrincipianteViewController.customFilter(self)(.Minimum, .LastPointY, 0.3)
        let maxy7 = PrincipianteViewController.customFilter(self)(.Maximum, .LastPointY, 0.7)
        let miny7 = PrincipianteViewController.customFilter(self)(.Minimum, .LastPointY, 0.7)
        
        if self.mayuscula?.boolValue == true{
            recognizer.addModel(PathModel(directions: [7,1,0], datas:"A"))      //Escribir los modelos predeterminados
            recognizer.addModel(PathModel(directions: [6,0,1,2,3,4,0,1,2,3,4], datas:"B"))
            recognizer.addModel(PathModel(directions: [4,3,2,1,0], datas:"C"))
            recognizer.addModel(PathModel(directions: [6,0,1,2,3,4], datas:"D", filter:miny7))
            recognizer.addModel(PathModel(directions: [4,2,0,0], datas:"E"))
            recognizer.addModel(PathModel(directions: [6,0,0], datas:"F"))
            recognizer.addModel(PathModel(directions: [5,4,3,2,1,0,7,6,5,4], datas:"G", filter:miny3))
            recognizer.addModel(PathModel(directions: [2,2,0], datas:"H"))
            recognizer.addModel(PathModel(directions: [2,0,0], datas:"I"))
            recognizer.addModel(PathModel(directions: [1,0,7,6,0], datas:"J"))
            recognizer.addModel(PathModel(directions: [2,7,1], datas:"K"))
            recognizer.addModel(PathModel(directions: [2,0], datas:"L"))
            recognizer.addModel(PathModel(directions: [2,1,7,2], datas:"M"))
            recognizer.addModel(PathModel(directions: [6,1,6], datas:"N"))
            recognizer.addModel(PathModel(directions: [0,1,2,3,4,5,6,7], datas:"O", filter:maxy3))
            recognizer.addModel(PathModel(directions: [6,0,1,2,3,4], datas:"P", filter:maxy7))
            recognizer.addModel(PathModel(directions: [4,3,2,1,0,7,6,5,4,1], datas:"Q", filter: maxy3))
            recognizer.addModel(PathModel(directions: [6,0,1,2,3,4,1], datas:"R"))
            recognizer.addModel(PathModel(directions: [5,4,3,2,1,0,1,2,3,4,5], datas:"S"))
            recognizer.addModel(PathModel(directions: [0,2], datas:"T"))
            recognizer.addModel(PathModel(directions: [2,1,0,7,6], datas:"U"))
            recognizer.addModel(PathModel(directions: [1,7], datas:"V"))
            recognizer.addModel(PathModel(directions: [1,7,1,7], datas:"W"))
            recognizer.addModel(PathModel(directions: [1,7], datas:"X"))
            recognizer.addModel(PathModel(directions: [1,2,7], datas:"Y"))
            recognizer.addModel(PathModel(directions: [0,3,0], datas:"Z"))
        }
        
        else{
        recognizer.addModel(PathModel(directions: [4,3,2,1,0,2], datas:"a"))      //Escribir los modelos predeterminados
        recognizer.addModel(PathModel(directions: [0,1,2,3,4,2], datas:"b"))
        recognizer.addModel(PathModel(directions: [4,3,2,1,0,2], datas:"b"))
        recognizer.addModel(PathModel(directions: [4,3,2,1,0], datas:"c"))
        recognizer.addModel(PathModel(directions: [4,3,2,1,0,2], datas:"d", filter:miny7))
        recognizer.addModel(PathModel(directions: [0,5,4,3,2,1,0], datas:"e"))
        recognizer.addModel(PathModel(directions: [6,0,1,0], datas:"f"))
        recognizer.addModel(PathModel(directions: [4,3,2,1,0,2,3,4], datas:"g", filter:miny3))
        recognizer.addModel(PathModel(directions: [2,7,0,1,2], datas:"h"))
        recognizer.addModel(PathModel(directions: [2,2], datas:"i"))
        recognizer.addModel(PathModel(directions: [2,2,3], datas:"j"))
        recognizer.addModel(PathModel(directions: [2,7,1], datas:"k"))
        recognizer.addModel(PathModel(directions: [2], datas:"l"))
        recognizer.addModel(PathModel(directions: [2,7,0,1,2,7,0,1,2], datas:"m"))
        recognizer.addModel(PathModel(directions: [2,7,0,1,2], datas:"n"))
        recognizer.addModel(PathModel(directions: [4,3,2,1,0,7,6,5,4], datas:"o", filter:maxy3))
        recognizer.addModel(PathModel(directions: [1,0,7,6,5,4,3,2], datas:"p", filter:maxy7))
        recognizer.addModel(PathModel(directions: [4,3,2,1,0,2], datas:"q", filter: maxy3))
        recognizer.addModel(PathModel(directions: [2,7,0], datas:"r"))
        recognizer.addModel(PathModel(directions: [4,3,2,1,0,1,2,3,4], datas:"s"))
        recognizer.addModel(PathModel(directions: [2,0], datas:"t"))
        recognizer.addModel(PathModel(directions: [2,4,0,7,2], datas:"u"))
        recognizer.addModel(PathModel(directions: [1,7], datas:"v"))
        recognizer.addModel(PathModel(directions: [1,7,1,7], datas:"w"))
        recognizer.addModel(PathModel(directions: [1,3], datas:"x"))
        recognizer.addModel(PathModel(directions: [1,3], datas:"y"))
        recognizer.addModel(PathModel(directions: [0,3,0], datas:"z"))
        }
        
        self.recognizer = recognizer
        
        if let url = NSBundle.mainBundle().URLForResource(letra!.lowercaseString, withExtension: "mp3"){
            if let player = try? AVAudioPlayer(contentsOfURL: url){
                self.player = player
                self.player.prepareToPlay()
            }
        }
        
        
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem(
            title: "Atrás",
            style: UIBarButtonItemStyle.Plain,
            target: nil,
            action: nil
        );
        
        self.navigationController!.navigationBar.topItem!.backBarButtonItem = backButton;
        
    }
    
    
    
    
    func minLastY(cost:Int, infos:PathInfos, minValue:Double)->Int {
        let py:Double = (Double(infos.deltaPoints.last!.y) - Double(infos.boundingBox.top)) / Double(infos.height)
        return py < minValue ? Int.max : cost
    }
    
    func maxLastY(cost:Int, infos:PathInfos, maxValue:Double)->Int {
        let py:Double = (Double(infos.deltaPoints.last!.y) - Double(infos.boundingBox.top)) / Double(infos.height)
        return py > maxValue ? Int.max : cost
    }
    
    
    
    func customFilter(operation:FilterOperation,_ field:FilterField, _ value:Double)(cost:Int, infos:PathInfos)->Int {
        
        var pvalue:Double
        
        switch field {
        case .LastPointY:
            pvalue = (Double(infos.deltaPoints.last!.y) - Double(infos.boundingBox.top)) / Double(infos.height)
        case .LastPointX:
            pvalue = (Double(infos.deltaPoints.last!.x) - Double(infos.boundingBox.left)) / Double(infos.width)
        }
        
        switch operation {
        case .Maximum:
            return pvalue > value ? Int.max : cost
        case .Minimum:
            return pvalue < value ? Int.max : cost
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        var temporal:[Int] = []
        //rawPoints = []
        //let touch = touches.first as? UITouch
        let touchesSet=touches as NSSet
        let touch=touchesSet.anyObject() as? UITouch
        let location = touch!.locationInView(view)
        temporal.append(Int(location.x))
        temporal.append(Int(location.y))
        arreglo.append(temporal)
        super.touchesBegan(touches, withEvent:event)
    }
    
    
    
    
    
    
    //override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //let touch = touches.first as? UITouch
        var temporal = arreglo.popLast()!
        let touchesSet=touches as NSSet
        let touch=touchesSet.anyObject() as? UITouch
        let location = touch!.locationInView(view)
        temporal.append(Int(location.x))
        temporal.append(Int(location.y))
        arreglo.append(temporal)
        
        self.renderView.arreglo = arreglo
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        var path:Path = Path()
        var gesture:PathModel? = self.recognizer!.recognizePath(path)
        
        for var index = 0; index < arreglo.count ;++index {
            path.addPointFromRaw(arreglo[index])
            //print(arreglo[index]
            gesture = self.recognizer!.recognizePath(path)
        }
        print(gesture?.datas as? String)
        if arreglo.count == numTrazos{                      //     ------          Número de trazos máximo por cada dibujo
            //revisar(touches, withEvent: event)
            //arreglo = []
            
            //let gesture:PathModel? = self.recognizer!.recognizePath(path)
            
        }
    }
    
    private func revisar(touches: Set<UITouch>, withEvent event: UIEvent?){
        
        var path:Path = Path()
        path.addPointFromRaw(arreglo.last!)
        
        var gesture:PathModel? = self.recognizer!.recognizePath(path)   // comparar el trazo con los trazos predeterminados
        for var index = 0; index < arreglo.count ;++index {
            path.addPointFromRaw(arreglo[index])
            //print(arreglo[index]
            gesture = self.recognizer!.recognizePath(path)
        }
        //letter.text = gesture!.datas as? String
        print(gesture?.datas as? String)
        if gesture?.datas as? String == letra {
            lblResultado.text = " Es correcto"
            print("correcto")
        } else {
            lblResultado.text = " Es incorrecto, prueba otra vez"
        }
    }
    
    
    @IBAction func guardarImagen(sender: AnyObject) {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        self.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //Save it to the camera roll
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
        
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
        
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        let usuario = NSUserDefaults.standardUserDefaults()
        
        if usuario.valueForKey("Usuario") != nil {
            mailComposerVC.setSubject("Trabajo de \(usuario.valueForKey("Usuario") as! NSString)")
        }
        else {
            mailComposerVC.setSubject("WriteIt")
        }
        let destinatarios = NSUserDefaults.standardUserDefaults()
        
        if destinatarios.valueForKey("Destinatarios") != nil {
            mailComposerVC.setToRecipients(["\(destinatarios.valueForKey("Destinatarios")as!String)"])
        }
        else {
            mailComposerVC.setToRecipients([""])
        }
        
        mailComposerVC.setMessageBody("WriteIt", isHTML: false)
        let imageData = UIImageJPEGRepresentation(image!, 1.0)
        
        mailComposerVC.addAttachmentData(imageData!, mimeType: "image/jpeg", fileName: "image.jpg")
        //mailComposerVC.addAttachmentData(UIImageJPEGRepresentation(UIImage(named: "emailImage")!, CGFloat(1.0))!, mimeType: "image/jpeg", fileName:  "image.jpeg")
        
        return mailComposerVC
        
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "No se pudo enviar", message: "Tu dispositvo no pudo enviar el e-mail.  Revisa la configuración e intenta de nuevo.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

