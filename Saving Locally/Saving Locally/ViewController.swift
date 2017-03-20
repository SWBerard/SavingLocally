//
//  ViewController.swift
//  Saving Locally
//
//  Created by Steven Berard on 8/3/16.
//  Copyright © 2016 Learn Swift LA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var isSelectedSwitch: UISwitch!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    var userSettings: UserSettings?
    var objectArray = [ObjectToSave]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        isSelectedSwitch.isOn = UserDefaultsHelper.preferences.bool(forKey: UserDefaultsHelper.isSelectedKey)
        
        userNameTextField.text = UserDefaultsHelper.preferences.string(forKey: UserDefaultsHelper.userNameKey)
        
        savedUserSettingsArchivePath()
        
        if let userSettings =  NSKeyedUnarchiver.unarchiveObject(withFile: self.savedUserSettingsArchivePath()) as? UserSettings {
            
            self.userSettings = userSettings
            
            print("We got our user settings from our file")
        }
        else {
            
            print("User settings wasn't saved")
            userSettings = UserSettings()
        }
        
        guard let userSettings = self.userSettings else {
            
            return
        }
        
        print("userSettings: \(userSettings.arrayOfObjects.count)")
        
        for object in userSettings.arrayOfObjects {
            
            print("This is working")
            textView.text = textView.text + (object.stringToSave ?? "??") + "\n"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func userTappedSaveButton(_ sender: AnyObject) {
        
        if userNameTextField.text != "" {
            
            let newObject = ObjectToSave()
            
            newObject.stringToSave = userNameTextField.text
            
            userSettings?.arrayOfObjects.append(newObject)
            
            textView.text = textView.text + (newObject.stringToSave ?? "") + "\n"
        }
        
        userNameTextField.text = ""
        saveUserSettings()
    }
    
    @IBAction func userTappedSwitch(_ sender: UISwitch) {
        
        UserDefaultsHelper.preferences.set(sender.isOn, forKey: UserDefaultsHelper.isSelectedKey)
        
        if sender.isOn {
            
            UserDefaultsHelper.preferences.set(userNameTextField.text, forKey: UserDefaultsHelper.userNameKey)
        }
        else {
            
            UserDefaultsHelper.preferences.set("", forKey: UserDefaultsHelper.userNameKey)
        }
    }
    
    func saveUserSettings() {
        
        print("This is saving")
        
        guard let userSettings = self.userSettings else {
            
            print("Error: self.userSettings was never set")
            return
        }
        
        
        NSKeyedArchiver.archiveRootObject(userSettings, toFile: self.savedUserSettingsArchivePath())
    }
    
    func savedUserSettingsArchivePath() -> String {
        
        let documentDirectories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        print("documentDirectories: \(documentDirectories)")
        
        // Get one and only document directory from that list
        let documentDirectory = documentDirectories[0]
        
        return documentDirectory + "/savedUserSettings.archive"
    }
}

