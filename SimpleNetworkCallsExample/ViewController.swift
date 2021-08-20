//
//  ViewController.swift
//  RetrofitExample-iOS
//
//  Created by Sitaram Gupta on 8/17/21.
//

import UIKit

import Alamofire

class ViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    let userDefaults = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        let url = "https://jsonplaceholder.typicode.com/users"
        
        //                        getData(from: url)
        //        getDataUsingAlamofire(from: url)
        saveButton.layer.cornerRadius = 12
        
        getDataFromMyData()
        
//        textField.delegate = self
        textView.delegate = self
        
        if let value = userDefaults.value(forKey: "name") as? String{
            label.text = value
        }
        
    }
    // This is for the text field of one line text only
//    private func textFieldShouldReturn(_ textField: UITextField) -> String {
//        userDefaults.setValue(textField.text, forKey: "name")
//        textField.resignFirstResponder() // to hide keyboard after return tap
//
//        return (textField.text)!
//    }
    
   
//    func textViewDidBeginEditing(textView: UITextView) {
//        textView.text = String()
//    }
    
    
    @IBAction func saveText(_ sender: Any) {
        userDefaults.setValue(textView.text, forKey: "name")
        textView.text = String()
        print("Saved")
    }
    
    
    private   func getDataFromMyData(){
        getUpdateInfo { (response) in
            print(response.first?.username! as Any)
        } failure: { (error) in
            print(error)
            print(error.localizedDescription)
        }
    }
    
    func getUpdateInfo(completion: @escaping (_ response: [ApiResponse])->Void, failure: @escaping(_ error: Error)->()){
        AF.request(URLPath.myData.urlString, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).responseData { (response) in
            switch response.result{
            case .failure(let error):
                failure(error)
            case .success(let data):
                do{
                    let parsed = try JSONDecoder().decode([ApiResponse].self, from: data)
                    completion(parsed)
                }catch{
                    failure(error)
                }
            }
        }
    }
    
    func getDataUsingAlamofire(from url: String){
        
        AF.request(url)
            .response{ response in
                // print(response)
                //to get status code
                
                
                if let data = response.data{
                    do{
                        let decoder = JSONDecoder()
                        let apiResponse = try decoder.decode([ApiResponse].self, from: data)
                        print(apiResponse)
                    }catch let err{
                        print(err.localizedDescription)
                    }
                }
                
                if let status = response.response?.statusCode {
                    switch(status){
                    case 200:
                        print("example success: ")
                    default:
                        print("error with response status: \(status)")
                    }
                }
                //to get JSON return value
                //                switch response.result {
                //                case .success(let value):
                //                    if let JSON = value as? [String: Any] {
                //                        print("my name ", JSON["name"] as! String)
                //                        print("my username ", JSON["username"] as! String)
                //
                //                    }
                //                case .failure( _): break
                //                // error handling
                //                }
                
            }
        
    }
    
    
    
    func getData(from url : String)  {
        let task =  URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response, error in
            
            guard let data  = data, error == nil else {
                print("Something went wrong")
                return
            }
            
            // have data
            
            do{
                let decoder = JSONDecoder()
                let result = try decoder.decode([ApiResponse].self, from: data)
                print(result.first?.username as Any)
            }
            catch{
                print("faild to convert \(error.localizedDescription)")
            }
            
            
            
            
            //        print(json.name)
            //        print(json.username)
            //        print(json.address?.city)
            //        print(json.address?.geo?.lat)
            //        print(json.company?.name)
            
        })
        task.resume()
    }
}



