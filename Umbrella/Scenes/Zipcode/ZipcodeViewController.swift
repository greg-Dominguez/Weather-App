//
//  ZipcodeViewController.swift
//  Umbrella
//
//  Created by Greg Dominguez on 10/3/17.
//  Copyright © 2017 greg.dominguez. All rights reserved.
//

import UIKit

protocol ZipcodeVCDelegate: class {
    
    func zipcodeEntered()
}

class ZipcodeViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    weak var delegate: ZipcodeVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBlur()
        setupFields()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func setupFields(){
        errorLabel.text = ""
        if let zipcode = UserPreferences.zipCode() {
            textField.text = zipcode
        }
    }
    
    func addBlur(){
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        //always fill the view
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(blurEffectView)
        view.sendSubview(toBack: blurEffectView)
    }
    
    @IBAction func textFieldEdited() {
        errorLabel.text = ""
    }
    
    @IBAction func submitButtonPressed() {
        
        guard let zipcode = textField.text, !zipcode.isEmpty else {
            errorLabel.text = "No Zipcode Entered"
            return
        }
        
        if ZipcodeReader.isValid(zipcode: zipcode){
            WeatherDataManager.shared.set(zipcode: zipcode)
            delegate?.zipcodeEntered()
            presentingViewController?.dismiss(animated: true, completion: nil)
        }else{
            errorLabel.text = "Invalid Zipcode"
        }
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
