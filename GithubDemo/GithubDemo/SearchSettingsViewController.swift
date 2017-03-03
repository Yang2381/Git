//
//  SearchSettingsViewController.swift
//  GithubDemo
//
//  Created by YangSzu Kai on 2017/3/2.
//  Copyright © 2017年 codepath. All rights reserved.
//

import UIKit

class SearchSettingsViewController: UIViewController {
    
    @IBOutlet weak var numberLabel: UILabel!
    var delegate: SettingsPresentingViewControllerDelegate?
    var settings: GithubRepoSearchSettings?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSave(_ sender: Any) {
        self.delegate?.didSaveSettings(settings: settings!)
        self.dismiss(animated: true, completion: nil) //dismiss view controller
    }
   
    
    @IBAction func onCancel(_ sender: Any) {
        self.delegate?.didCancelSettings()
        self.dismiss(animated: true, completion: nil)
    }
   
    @IBAction func onSlideBar(_ sender: Any) {
        
        let slider = sender as! UISlider
        settings?.minStars = Int(slider.value * 1000.0)
        numberLabel.text = "\(settings!.minStars)"
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
