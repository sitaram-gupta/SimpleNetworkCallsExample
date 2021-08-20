//
//  CustomViewController.swift
//  SimpleNetworkCallsExample
//
//  Created by Sitaram Gupta on 8/20/21.
//

import UIKit

class CustomViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet var cityTextField: UITextField!
    @IBOutlet weak var contactTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func saveData(_ sender: Any) {
        
        let object = CustomDetails()
        object.cName = nameTextField.text!
        object.cAge = Int (ageTextField.text!) ?? 0
        object.cCity = cityTextField.text!
        object.cContact = contactTextField.text!
        
        UserDefaults.standard.set(try? PropertyListEncoder().encode(object), forKey: "customer_details")
        
        print("Data has been saved in UserDefaults")
    }
    
   
    @IBAction func getDataFromUserDefaults(_ sender: Any) {
        
        var retreiveObject  = CustomDetails()
        
        if let userData =  UserDefaults.standard.value(forKey: "customer_details") as? Data
        {
            let retrieveObject = try? PropertyListDecoder().decode(CustomDetails.self, from: userData)
            
            
            print("Customer Name \(retrieveObject?.cName ?? "")")
            print("Customer Age \(retrieveObject?.cAge ?? 0)")
            print("Customer City \(retrieveObject?.cCity ?? "")")
            print("Customer Contact \(retrieveObject?.cContact ?? "")")
        }
        
    }
    
}
