//
//  SavedBlendsTableViewController.swift
//  BlendApp
//
//  Created by Amanda Aizuss on 8/16/16.
//  Copyright © 2016 aaizuss. All rights reserved.
//

import UIKit

class SavedBlendsTableViewController: UITableViewController {

    var selectedTopColor = UIColor.red
    var selectedBotColor = UIColor.red
    var savedGrads = NSMutableArray()
    var plistPath: String!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        plistPath = appDelegate.plistPathInDocDirectory
        
        // Extract the content of the file as NSData
        let data: Data = FileManager.default.contents(atPath: plistPath)!
        do {
            savedGrads = try PropertyListSerialization.propertyList(from: data, options: .mutableContainersAndLeaves, format: nil) as! NSMutableArray
        } catch {
            print("Error occurred while reading from the plist file")
        }
        self.tableView.reloadData()
        print("#️⃣ saved grads: \(savedGrads.count)")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedGrads.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gradientCell", for: indexPath) as! SavedBlendsTableViewCell

        let (topColor, bottomColor, rotation) = grabSavedInfoFor(indexPath)
        let cellGradLayer = CAGradientLayer()
        cell.backgroundView = UIView(frame: cell.frame)
        cellGradLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        rotateGradBy(amount: rotation, gradLayer: cellGradLayer)
        cell.backgroundColor = UIColor.clear
        cell.backgroundView?.layer.insertSublayer(cellGradLayer, at: 0)
        cellGradLayer.frame = cell.bounds

        return cell
    }
    
    
    func grabSavedInfoFor(_ indexPath: IndexPath) -> (UIColor, UIColor, Float) {
        var rotation: Float = 0.0
        let gradInfo: NSDictionary = savedGrads[indexPath.row] as! NSDictionary
        let topColorData = gradInfo["top"] as! Data
        let bottomColorData = gradInfo["bottom"] as! Data
        if let savedRotation = gradInfo["rotation"] as? Float {
            rotation = savedRotation
        }
        let topColor = NSKeyedUnarchiver.unarchiveObject(with: topColorData) as! UIColor
        let bottomColor = NSKeyedUnarchiver.unarchiveObject(with: bottomColorData) as! UIColor
        return (topColor:topColor, bottomColor: bottomColor, rotation: rotation)
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            savedGrads.removeObject(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            savedGrads.write(toFile: plistPath, atomically: true)
        }
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let itemToMove = savedGrads[fromIndexPath.row]
        savedGrads.removeObject(at: fromIndexPath.row)
        savedGrads.insert(itemToMove, at: to.row)
        savedGrads.write(toFile: plistPath, atomically: true)
    }
 

    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("about to perform segue")
        self.performSegue(withIdentifier: "UnwindFromBlendCell", sender: self)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UnwindFromBlendCell" {
            let indexPath = tableView.indexPathForSelectedRow
            let (topColor, bottomColor, rotation) = grabSavedInfoFor(indexPath!)
            selectedTopColor = topColor
            selectedBotColor = bottomColor
            if let blendViewController = segue.destination as? BlendViewController {
                blendViewController.topColor = selectedTopColor
                blendViewController.bottomColor = selectedBotColor
                blendViewController.gradRotation = rotation
            }
        }
    }
    
    
    // move to another file?
    func getColorFromData(data: Data) -> UIColor {
        return NSKeyedUnarchiver.unarchiveObject(with: data) as! UIColor
    }
    
    func rotateGradBy(amount: Float, gradLayer: CAGradientLayer) {
        let a: Float = pow(sinf((2*Float(M_PI)*((amount+0.75)/2))),2)
        let b: Float = pow(sinf((2*Float(M_PI)*((amount+0.0)/2))),2)
        let c: Float = pow(sinf((2*Float(M_PI)*((amount+0.25)/2))),2)
        let d: Float = pow(sinf((2*Float(M_PI)*((amount+0.5)/2))),2)
        
        gradLayer.startPoint = CGPoint(x: CGFloat(a), y: CGFloat(b))
        gradLayer.endPoint = CGPoint(x: CGFloat(c), y: CGFloat(d))
    }

}
