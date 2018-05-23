//
//  Profile.swift
//  PerretesFashion
//
//  Created by DAM2T1 on 6/4/18.
//  Copyright © 2018 DAM2T1. All rights reserved.
//

import UIKit
import CoreData

class Profile: UIViewController {
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var profileImg: UIImageView!
    
    var contexto: NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //DATABASE
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        contexto = (appDelegate?.persistentContainer.viewContext)!
        
        //ESCONDEMOS Y DESHABILITAMOS CAMPOS
        isEditingFields(isEditValues: false)
        saveButton.isHidden = true
        
        //CARGAMOS LOS DATOS DEL USUARIO
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editProfile(_ sender: Any) {
        saveButton.isHidden = false
        editButton.isHidden = true
        isEditingFields(isEditValues: true)
        password.isSecureTextEntry = false
        
    }
    
    @IBAction func saveProfile(_ sender: Any) {
        updateUserDB(name: userName.text!, pass: password.text!)
        saveButton.isHidden = true
        isEditingFields(isEditValues: false)
        password.isSecureTextEntry = true
        editButton.isHidden = false
    }
    
    func updateUserDB(name : String, pass : String){
        userSession?.username = userName.text
        userSession?.password = password.text
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName : "User")
        fetchRequest.predicate = NSPredicate(format: "username == %@", name)
        do{
            let results = try contexto?.fetch(fetchRequest)
            if results!.count > 0 {
                var user = results?.first as! User
                user.username = name
                user.password = pass
                try contexto?.save()
            }else{
                print ("Error, no hay usuarios en la db)")
            }
        } catch let error as NSError {
            print ("Error al recuperar: \(error)")
        }
    }
    
    func isEditingFields(isEditValues : Bool){
        userName.isUserInteractionEnabled = isEditValues
        password.isUserInteractionEnabled = isEditValues
    }
    
    func loadData(){
        userName.text = userSession?.username
        password.text = userSession?.password
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
