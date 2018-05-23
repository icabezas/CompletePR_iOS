//
//  ViewController.swift
//  PerretesFashion
//
//  Created by DAM2T1 on 5/3/18.
//  Copyright © 2018 DAM2T1. All rights reserved.
//

import UIKit
import CoreData
var userSession: User?
var categorias: [Categoria] = []
var categoriaSeleccionada : Categoria?
var perretesPorCategoria : [PerreteFashion] = []
var infoPerrete : [String] = []
var imagenes : [UIImage] = []

class ViewController: UIViewController {
    
    var contexto: NSManagedObjectContext?
    
    override func viewDidLoad() {
        errorMessage.isHidden = true
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        //let managedObjectContext = appDelegate?.persistentContainer.viewContext
        contexto = (appDelegate?.persistentContainer.viewContext)!
        
        //AÑADIMOS LAS IMAGENES POR DEFECTO EN EL ARRAY PARA UTILIZARLAS EN OTRAS VISTAS
        imagenes.append(#imageLiteral(resourceName: "img1"))
        imagenes.append(#imageLiteral(resourceName: "img2"))
        imagenes.append(#imageLiteral(resourceName: "img3"))
        imagenes.append(#imageLiteral(resourceName: "img4"))
        
        //CREAMOS CATEGORIAS
        establecerCategoria(tipo: "Fashion")
        establecerCategoria(tipo: "Casual")
        establecerCategoria(tipo: "Street")
        establecerCategoria(tipo: "Formal")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var intUserName: UITextField!
    
    @IBOutlet weak var intPassword: UITextField!
    
    @IBOutlet weak var errorMessage: UILabel!
    
    @IBAction func loginUser(_ sender: Any) {
        let inputUserName = intUserName.text
        let password = intPassword.text
        
        //COMPROBAMOS QUE HAY DATOS EN EL INPUT
        if(inputUserName != "" && password != ""){
            //COMPROBAMOS QUE EXISTE EL USUARIO
            userSession = doesUserExist(username: inputUserName!)?.first as User!
            if userSession != nil {
                //COMPROBAMOS QUE USUARIO Y CONTRASEÑA SON CORRECTOS
                if password == userSession?.password {
                    //LOGIN CORRECTO, GUARDAMOS USER PARA PASARLO A LA SIGUIENTE VISTA Y LANZAMOS
                    self.performSegue(withIdentifier: "loginOK", sender: self)
                }else{
                    showMessage(message: "Username o password incorrecto")
                }
            }else{
                showMessage(message: "El nombre de usuario no existe")
            }
        }
    }
    
    
    
    @IBAction func newUser(_ sender: Any) {
        let inputUserName = intUserName.text
        let password = intPassword.text
        
        if(inputUserName != "" && password != ""){
            
            //RECUPERAMOS LOS USUARIOS DE LA BASE DE DATOS PARA COMPROBAR QUE NO EXISTE EL NOMBRE DE USER
            if doesUserExist(username: inputUserName!) == nil{
                
                //INSERTAMOS NUEVO USUARIO
                //CREAMOS UN TIPO DE ENTIDAD: USER
                let userEntity = NSEntityDescription.entity(forEntityName: "User", in: contexto!)
                
                //CREAMOS UNA ENTIDAD DEL TIPO USER
                let user = User(entity: userEntity!, insertInto: contexto)
                
                //ASIGNAMOS VALORES
                user.username = inputUserName
                user.password = password
                
                //GUARDAMOS USUARIO EN CONTEXTO
                do {
                    try contexto?.save()
                    performSegue(withIdentifier: "loginOK", sender: self)
                    showMessage(message: "Usuario registrado correctamente")
                }catch let error as NSError {
                    print ("Error al insertar: \(error)")
                }
            }else{
                
                //HACEMOS TEXTO VISIBLE CON MENSAJE DE ERROR DE USUARIO YA EXISTE
                showMessage(message: "Ya existe este username")
            }
        }else{
            showMessage(message: "Introduce algún valor para usuario y contraseña")
        }
    }
    func doesUserExist(username: String) -> [User]?{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName : "User")
        fetchRequest.predicate = NSPredicate(format: "username == %@", username)
        do{
            let results = try contexto?.fetch(fetchRequest)
            if results!.count > 0 {
                showMessage(message: "Algun usuario hay")
                return results as? [User]
            }else{
                showMessage(message: "No hay usuarios")
            }
        } catch let error as NSError {
            print ("Error al recuperar: \(error)")
        }
        return nil
    }
    
    //FUNCION PARA CREAR CATEGORIAS
    //AÑADE A LA BASE DE DATOS UNA CATEGORIA
    func establecerCategoria(tipo : String){
        //INSERTAMOS NUEVAS CATEGORIAS
        //CREAMOS UN TIPO DE ENTIDAD: CATEGORIA
        let categoriaEntity = NSEntityDescription.entity(forEntityName: "Categoria", in: contexto!)
        
        //CREAMOS UNA ENTIDAD DEL TIPO CATEGORIA
        let categoria = Categoria(entity: categoriaEntity!, insertInto: contexto)
        
        //ASIGNAMOS VALORES
        categoria.tipoVestimenta = tipo
        
        //GUARDAMOS CATEGORIA EN CONTEXTO
        do {
            try contexto?.save()
        }catch let error as NSError {
            print ("Error al insertar: \(error)")
        }
        categorias.append(categoria)
    }
    
    //prepara lo que quieres que se muestre en la siguiente pantalla
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let pantalla: UITabBarController = segue.destination as! UITabBarController
        //pantalla.userSession = userSession!
    }
    
    func showMessage(message: String){
        errorMessage.text = message
        errorMessage.isHidden = false
    }
}


