//
//  BlendViewController.swift
//  BlendApp
//
//  Created by Amanda Aizuss on 6/16/16.
//  Copyright © 2016 aaizuss. All rights reserved.
//

import UIKit

// Note to self: weird bug
// on first launch, save blend, open blend from table view
// goes to blend screen and then jumps to last page of tutorial...?

class BlendViewController: UIViewController, UIGestureRecognizerDelegate {

    // MARK: Properties
    var colorIndicator = UIView()
    let transitionManager = TransitionManager()
    
    /* The Gradient */
    var gradAnimationLayer = CAGradientLayer()
    var gradLayer = CAGradientLayer()
    var gradRotation: Float = 0
    
    /* Initial Colors (these will change with touch point) */
    var hueTop = CGFloat()
    var satTop = CGFloat()
    var brightTop = CGFloat()
    
    var hueBot = CGFloat()
    var satBot = CGFloat()
    var brightBot = CGFloat()
    
    var a: CGFloat = 1.0
    //var topColor = UIColor(netHex: 0xd53369)
    var topColor = UIColor(netHex: 0xB60084)
    var bottomColor = UIColor(netHex: 0xF4D03F)
    //var bottomColor = UIColor(netHex: 0xcbad6d)
    
    /* Outlets */
    @IBOutlet weak var topCircle: ColorPickerView!
    @IBOutlet weak var bottomCircle: ColorPickerView!
    
    /* For Saving */
    var savedGrads: NSMutableArray!
    var plistPath:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAnimationLayer(layer: gradAnimationLayer)
        animateGradient(layer: gradAnimationLayer)
        self.transitionManager.sourceViewController = self
        
        // Make CirclePickerViews nearly transparent
        topCircle.alpha = 0.1
        bottomCircle.alpha = 0.1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        showGradient()
        updateIndicatorLocationFromColors(t: topColor, b: bottomColor)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: Gesture Recognizers
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer is UIScreenEdgePanGestureRecognizer {
            return true
        } else {
            return false
        }
    }
    
    func addIndicatorPanToPickerView(_ view: ColorPickerView) {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleIndicatorPan))
        panGesture.delegate = self
        view.addGestureRecognizer(panGesture)
    }
    
    @IBAction func didTapColorPicker(_ sender: UITapGestureRecognizer) {
        let pickerView = sender.view as? ColorPickerView
        
        if pickerView == topCircle {
            activatePicker(topCircle)
        }
        
        if pickerView == bottomCircle {
            activatePicker(bottomCircle)
        }
        
        //pickerView?.alpha = 0.7
        pickerView?.fade(toAlpha: 0.8, withDuration: 0.2)
        colorIndicator = pickerView!.indicator
        
        // Make the Indicator draggable in the picker
        addIndicatorPanToPickerView(pickerView!)
    }
    
    func handleIndicatorPan(_ sender: UIPanGestureRecognizer) {
        let picker = sender.view as! ColorPickerView
        var touchPoint = sender.location(in: picker)
        let pickerCenter = CGPoint(x: picker.frame.width/2, y: picker.frame.height/2)
        let pickerRadius = picker.frame.width/2
        let indicator = picker.indicator
        
        if !picker.inCircle(point: touchPoint, center: pickerCenter, radius: pickerRadius) {
            let coord = picker.getNewCoord(tpoint: touchPoint, center: pickerCenter, radius: pickerRadius)
            touchPoint = coord
            indicator.center = coord
        } else {
            // touch point is in the circle, so we can just move the dot there
            indicator.center = CGPoint(x: touchPoint.x, y: touchPoint.y)
        }
        changeColor(point: touchPoint, picker: picker)
    }
    
    @IBAction func handleBrightnessPan(_ sender: UIPanGestureRecognizer) {
        let view = sender.view
        let touchPointY = sender.location(in: view).y
        let viewBottom = self.view.frame.height - 100
        let viewTop:CGFloat = 150
        let b = lerp(w: unlerp(x: touchPointY, x0: viewBottom, x1: viewTop), a: 0, b: 1)
        if topCircle.tag == 111 {
            brightTop = b
            topColor = UIColor(hue: hueTop, saturation: satTop, brightness: brightTop, alpha: a)
        }
        if bottomCircle.tag == 111 {
            brightBot = b
            bottomColor = UIColor(hue: hueBot, saturation: satBot, brightness: brightBot, alpha: a)
        }
        
        // Adjust the gradient colors
        gradLayer.colors = [topColor.cgColor, bottomColor.cgColor]
    }
    
    /// Swap top and bottom colos when view is double tapped
    @IBAction func didDoubleTapView(_ sender: UITapGestureRecognizer) {
        print("view was double tapped. swapping colors.")
        let oldTop = topColor
        let oldBot = bottomColor
        
        topColor = oldBot
        bottomColor = oldTop
        gradLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        
        updateIndicatorLocationFromColors(t: topColor, b: bottomColor)
    }
    
    @IBAction func handleRotate(_ sender: UIRotationGestureRecognizer) {
        print("calling rotate")
        if topCircle.tag == 100 && bottomCircle.tag == 101 {
            
            // Only apply the rotation when starting and continuing to rotate
            guard sender.state == UIGestureRecognizerState.ended || sender.state == UIGestureRecognizerState.changed else {
                return
            }
            
            rotateGradient(Float(sender.rotation))
        }

    }
    
    /// When view is tapped, hide the color pickers
    @IBAction func didTapView(_ sender: UITapGestureRecognizer) {
        topCircle.tag = 100
        bottomCircle.tag = 101
        topCircle.alpha = 0.1
        bottomCircle.alpha = 0.1
    }
    
    @IBAction func didLongPressView(_ sender: UILongPressGestureRecognizer) {
        print("Long Press: Resetting gradient angle")
        rotateGradient(0.0)
        gradRotation = 0.0
    }
    
    
    
    
    // MARK: Gradient Layer
    
    /// Create gradient using CAGradientLayer and add as sublayer at index 0
    /// to make the gradient background
    func showGradient() {
        gradLayer.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        // update the color components
        var th = CGFloat(); var ts = CGFloat(); var tb = CGFloat(); var ta = CGFloat();
        var bh = CGFloat(); var bs = CGFloat(); var bb = CGFloat(); var ba = CGFloat();
        let tsuccess: Bool = topColor.getHue(&th, saturation: &ts, brightness: &tb, alpha: &ta)
        let bsuccess: Bool = bottomColor.getHue(&bh, saturation: &bs, brightness: &bb, alpha: &ba)
        if tsuccess && bsuccess {
            hueTop = th
            hueBot = bh
            satTop = ts
            satBot = bs
            brightBot = bb
            brightTop = tb
        }
        gradLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        //rotateGradient(gradRotation)
        view.layer.insertSublayer(gradLayer, at: 0)
    }
    
    /// x = 0 is horizontal
    func rotateGradient(_ x: Float) {
        gradRotation = x // want to be able to save this to plist later
        let a: Float = pow(sinf((2*Float(M_PI)*((x+0.75)/2))),2)
        let b: Float = pow(sinf((2*Float(M_PI)*((x+0.0)/2))),2)
        let c: Float = pow(sinf((2*Float(M_PI)*((x+0.25)/2))),2)
        let d: Float = pow(sinf((2*Float(M_PI)*((x+0.5)/2))),2)
        
        gradLayer.startPoint = CGPoint(x: CGFloat(a), y: CGFloat(b))
        gradLayer.endPoint = CGPoint(x: CGFloat(c), y: CGFloat(d))
    }

    
    // MARK: Color
    /// Finds hue and saturation from point,
    /// checks which circle is being interacted with (top or bottom), and
    /// updates the gradient colors accordingly
    func changeColor(point: CGPoint, picker: ColorPickerView) {
        let color = picker.hueSaturationAtPoint(point)
        let hue = color.hue
        let sat = color.saturation
        
        if topCircle.tag == 111 {
            hueTop = hue
            satTop = sat
            topColor = UIColor(hue: hueTop, saturation: satTop, brightness: brightTop, alpha: a)
        }
        if bottomCircle.tag == 111 {
            hueBot = hue
            satBot = sat
            bottomColor = UIColor(hue: hueBot, saturation: satBot, brightness: brightBot, alpha: a)
        }
        
        // Adjust the gradient colors
        gradLayer.colors = [topColor.cgColor, bottomColor.cgColor]
    }
    
    
    // MARK: Shake
    
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            // get random gradient
            let randomGrad = UIColor().getRandomGrad()
            let t = UIColor(cgColor: randomGrad.top)
            let b = UIColor(cgColor: randomGrad.bottom)
            gradLayer.colors = [randomGrad.top, randomGrad.bottom]
            topColor = t
            bottomColor = b
            updateIndicatorLocationFromColors(t: t, b: b)
        }
    }

    
    // MARK: Picker View Utils
    
    // Uses the top and bottom colors to determine where to place the indicators
    func updateIndicatorLocationFromColors(t: UIColor, b: UIColor) {
        var th = CGFloat(); var ts = CGFloat(); var tb = CGFloat(); var ta = CGFloat()
        var bh = CGFloat(); var bs = CGFloat(); var bb = CGFloat(); var ba = CGFloat()
        let tsuccess: Bool = t.getHue(&th, saturation: &ts, brightness: &tb, alpha: &ta)
        let bsuccess: Bool = b.getHue(&bh, saturation: &bs, brightness: &bb, alpha: &ba)
        if tsuccess && bsuccess {
            topCircle.indicator.center = topCircle.pointAtHueSaturation(hue: th, saturation: ts)
            bottomCircle.indicator.center = bottomCircle.pointAtHueSaturation(hue: bh, saturation: bs)
            hueBot = bh; hueTop = th; satBot = bs; satTop = ts; brightBot = bb; brightTop = tb;
        }
    }
    
    
    /// Helper function for didTapColorPicker.
    /// Handles hiding/showing views associated with `theCircle` top or bottom
    /// Set the tag of the circle view that was tapped to 111
    /// This helps us determine if we should change the top or bottom color when user drags
    /// - Parameter picker: the color picker view that you want to activate
    func activatePicker(_ picker: ColorPickerView) {
        if picker == topCircle {
            print("activating top picker")
            // Change tags to indicate which circle is active
            topCircle.tag = 111
            // bottom circle tag is 101 unless it is currently active
            bottomCircle.tag = 101
            
            //bottomCircle.alpha = 0.05
            bottomCircle.fade(toAlpha: 0.05, withDuration: 0.3)
            topCircle.indicator.center = picker.pointAtHueSaturation(hue: hueTop, saturation: satTop)
        }
        
        if picker == bottomCircle {
            print("activating bottom picker")

            // top circle tag is 100 unless it is currently active
            topCircle.tag = 100
            bottomCircle.tag = 111
            
            //topCircle.alpha = 0.05
            topCircle.fade(toAlpha: 0.05, withDuration: 0.3)
            bottomCircle.indicator.center = picker.pointAtHueSaturation(hue: hueBot, saturation: satBot)
        }
    }

    // MARK: - Save
    
    @IBAction func didTapSave(_ sender: UIButton) {
        saveColorDataToPlist()
        saveToAlbum()
    }
    
    func saveToAlbum() {
        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, true, 0.0)
        gradLayer.render(in: UIGraphicsGetCurrentContext()!)
        let wallpaper = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(wallpaper!, nil, nil, nil)
        
        showSaveAlert()
    }
    
    func saveColorDataToPlist() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let pathForPlistFile = appDelegate.plistPathInDocDirectory
        let topColorData: Data = NSKeyedArchiver.archivedData(withRootObject: topColor)
        let bottomColorData: Data = NSKeyedArchiver.archivedData(withRootObject: bottomColor)
        let color: [String: Any] = ["top":topColorData, "bottom":bottomColorData, "rotation":gradRotation]
        
        let data: Data = FileManager.default.contents(atPath: pathForPlistFile)!
        
        addColorInfoToPlist(plistFilePath: pathForPlistFile, colorInfo: color, plistContent: data)
    }
    
    func addColorInfoToPlist(plistFilePath: String, colorInfo: [String:Any], plistContent: Data) {
        do {
            let gradArray = try PropertyListSerialization.propertyList(from: plistContent, options: .mutableContainersAndLeaves, format: nil) as AnyObject
            gradArray.add!(colorInfo)
            
            _ = gradArray.write(toFile: plistFilePath, atomically: true)
            print("path for plist file after saving: \(plistFilePath)")
        } catch {
            print("an error occurred while writing to plist")
        }
    }
    
    /// Show confirmation that image was saved successfully
    /// and give option to go to wallpaper settings
    func showSaveAlert() {
        let alertController = UIAlertController(title: "Blend Saved!", message: "Go to settings to change your wallpaper now?", preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "Go to Settings", style: .default) { (_) -> Void in
            let settingsURL = URL(string: "prefs:root=Wallpaper")
            if let url = settingsURL {
                UIApplication.shared.openURL(url)
            }
            else if let url = URL(string: "prefs:root=General") {
                UIApplication.shared.openURL(url)
            } else {
                let oopsController = UIAlertController(title: "Oops!", message: "Sorry, you'll have to go to settings manually.", preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                oopsController.addAction(OKAction)
                self.present(oopsController, animated: true, completion: nil)
            }
        }
        
        let noAction = UIAlertAction(title: "Not now", style: .cancel, handler: nil)
        alertController.addAction(noAction)
        
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // idea: embed blend vc in a nav controller, instead of embedding the table view
        // (i think i've tried this before though)
        if segue.identifier == "ShowSavedBlends" {
            let toViewController = segue.destination as! UINavigationController
//            let toViewController = segue.destination as! SavedBlendsTableViewController
            toViewController.transitioningDelegate = self.transitionManager
            self.transitionManager.destViewController = toViewController
        }
    }
    
    
    @IBAction func unwindToBlendViewController (sender: UIStoryboardSegue){
        if sender.source.isKind(of: SavedBlendsTableViewController.self) {
            // note to self: this gets called twice when I select a cell
            // figure out why it's being called more than once
            print("✅ unwinding to blend view controller with segue called \(sender.identifier)")
        }
    }
    
    // MARK: Math
    func lerp(w: CGFloat, a: CGFloat, b: CGFloat) -> CGFloat {
        return (1.0-w)*a + w*b
    }
    
    func unlerp(x: CGFloat, x0: CGFloat, x1: CGFloat) -> CGFloat {
        return (x-x0)/(x1-x0)
    }

}
