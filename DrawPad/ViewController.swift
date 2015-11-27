//
//  ViewController.swift
//  DrawPad
//
//  Created by Jean-Pierre Distler on 13.11.14.
//  Copyright (c) 2014 Ray Wenderlich. All rights reserved.
//actual

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    private var player: AVAudioPlayer = AVAudioPlayer()
    
    @IBOutlet weak var mainImageView: UIImageView!

    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var tempImageView: UIImageView!

    
    var nombreLetra:String?
    
    var mayuscula:BooleanType?
    
    var lastPoint = CGPoint.zero
    var red: CGFloat = 255.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var brushWidth: CGFloat = 10.0
    var opacity: CGFloat = 1.0
    var swiped = false
    
    let colors: [(CGFloat, CGFloat, CGFloat)] = [
        (0, 0, 0),
        (105.0 / 255.0, 105.0 / 255.0, 105.0 / 255.0),
        (1.0, 0, 0),
        (0, 0, 1.0),
        (51.0 / 255.0, 204.0 / 255.0, 1.0),
        (102.0 / 255.0, 204.0 / 255.0, 0),
        (102.0 / 255.0, 1.0, 0),
        (160.0 / 255.0, 82.0 / 255.0, 45.0 / 255.0),
        (1.0, 102.0 / 255.0, 0),
        (1.0, 1.0, 0),
        (1.0, 1.0, 1.0),
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let letterImage = UIImageView()
        if self.mayuscula?.boolValue == false{
            letterImage.image = UIImage(named: nombreLetra!)
        }
        else{
            letterImage.image = UIImage(named: "\(nombreLetra!.lowercaseString)-1")
        }
        
        
        letterImage.frame.size.height = 200
        letterImage.frame.size.width = 200
        letterImage.center = self.view.center
        
        
        let palabraImage = UIImageView()
        palabraImage.image = UIImage(named: "\(nombreLetra!.lowercaseString)_i")
        
        palabraImage.frame.size.height = 50
        palabraImage.frame.size.width = 200
        palabraImage.frame.origin.y = self.view.bounds.size.height - palabraImage.frame.size.height - 5
        palabraImage.frame.origin.x = (self.view.bounds.size.width - palabraImage.frame.size.width) / 2.0
        
        self.view.addSubview(palabraImage)
        view.sendSubviewToBack(palabraImage)
        
        self.view.addSubview(letterImage)
        view.sendSubviewToBack(letterImage)
        
        print(self.mayuscula)
        
        if let url = NSBundle.mainBundle().URLForResource(nombreLetra!.lowercaseString, withExtension: "mp3"){
            if let player = try? AVAudioPlayer(contentsOfURL: url){
                self.player = player
                self.player.prepareToPlay()
            }
        }
        print(self.nombreLetra!.lowercaseString)
        
        let backButton = UIBarButtonItem(
            title: "Atras",
            style: UIBarButtonItemStyle.Plain,
            target: nil,
            action: nil
        );
        
        self.navigationController!.navigationBar.topItem!.backBarButtonItem = backButton;
    
    }
    
    
    @IBAction func reproducir(sender: AnyObject) {
        if self.player.playing{
            self.player.stop()
        }
        self.player.play()
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        
        reset(resetBtn)
        reset(resetBtn)
        reset(resetBtn)
        
    }
    
    @IBAction func reset(sender: AnyObject) {
        
        loadView()
        
        mainImageView.image = nil
        
        let letterImage = UIImageView()
        letterImage.image = UIImage(named: nombreLetra!)
        
        letterImage.frame.size.height = 200
        letterImage.frame.size.width = 200
        letterImage.center = self.view.center
        
        self.view.addSubview(letterImage)
        view.sendSubviewToBack(letterImage)
        
        let palabraImage = UIImageView()
        palabraImage.image = UIImage(named: "\(nombreLetra!.lowercaseString)_i")
        
        palabraImage.frame.size.height = 50
        palabraImage.frame.size.width = 200
        palabraImage.frame.origin.y = self.view.bounds.size.height - palabraImage.frame.size.height - 5
        palabraImage.frame.origin.x = (self.view.bounds.size.width - palabraImage.frame.size.width) / 2.0
        
        self.view.addSubview(palabraImage)
        view.sendSubviewToBack(palabraImage)
        
        if let url = NSBundle.mainBundle().URLForResource(nombreLetra!.lowercaseString, withExtension: "mp3"){
            if let player = try? AVAudioPlayer(contentsOfURL: url){
                self.player = player
                self.player.prepareToPlay()
            }
        }

    }
    
    @IBAction func share(sender: AnyObject) {
        UIGraphicsBeginImageContext(mainImageView.bounds.size)
        mainImageView.image?.drawInRect(CGRect(x: 0, y: 0,
            width: mainImageView.frame.size.width, height: mainImageView.frame.size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let activity = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        presentViewController(activity, animated: true, completion: nil)
    }
    
    @IBAction func pencilPressed(sender: AnyObject) {
        
        var index = sender.tag ?? 0
        if index < 0 || index >= colors.count {
            index = 0
        }
        
        (red, green, blue) = colors[index]
        
        if index == colors.count - 1 {
            opacity = 1.0
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        swiped = false
        let touchesSet=touches as NSSet
        
        if let touch=touchesSet.anyObject() as? UITouch {
            lastPoint = touch.locationInView(self.view)
        }
    }
    
    func drawLineFrom(fromPoint: CGPoint, toPoint: CGPoint) {
        
        // 1
        UIGraphicsBeginImageContext(view.frame.size)
        let context = UIGraphicsGetCurrentContext()
        tempImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        
        // 2
        CGContextMoveToPoint(context, fromPoint.x, fromPoint.y)
        CGContextAddLineToPoint(context, toPoint.x, toPoint.y)
        
        // 3
        CGContextSetLineCap(context, 	CGLineCap.Round)
        CGContextSetBlendMode(context, CGBlendMode.Normal)
        
        CGContextSetLineWidth(context, brushWidth)
        CGContextSetRGBStrokeColor(context, red, green, blue, 1.0)
        
        //CGContextSetBlendMode(context, CGBlendMode.Normal)
        
        // 4
        CGContextStrokePath(context)
        
        // 5
        tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        tempImageView.alpha = opacity
        UIGraphicsEndImageContext()
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?)  {
        // 6
        swiped = true
        let touchesSet=touches as NSSet
        
        if let touch=touchesSet.anyObject() as? UITouch {
            let currentPoint = touch.locationInView(view)
            drawLineFrom(lastPoint, toPoint: currentPoint)
            
            // 7
            lastPoint = currentPoint
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if !swiped {
            // draw a single point
            drawLineFrom(lastPoint, toPoint: lastPoint)
        }
        
        // Merge tempImageView into mainImageView
        UIGraphicsBeginImageContext(mainImageView.frame.size)
        mainImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: CGBlendMode.Normal, alpha: 1.0)
        //tempImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: kCGBlendModeNormal, alpha: opacity)
        tempImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: CGBlendMode.Normal, alpha: opacity)
        mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        tempImageView.image = nil
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let settingsViewController = segue.destinationViewController as! SettingsViewController
        settingsViewController.delegate = self
        settingsViewController.brush = brushWidth
        settingsViewController.opacity = opacity
        settingsViewController.red = red
        settingsViewController.green = green
        settingsViewController.blue = blue
    }
    
}

extension ViewController: SettingsViewControllerDelegate {
    func settingsViewControllerFinished(settingsViewController: SettingsViewController) {
        self.brushWidth = settingsViewController.brush
        self.opacity = settingsViewController.opacity
        self.red = settingsViewController.red
        self.green = settingsViewController.green
        self.blue = settingsViewController.blue
    }
}

