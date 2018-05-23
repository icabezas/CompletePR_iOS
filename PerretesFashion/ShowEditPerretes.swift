//
//  ShowEditPerretes.swift
//  PerretesFashion
//
//  Created by DAM2T1 on 12/5/18.
//  Copyright © 2018 DAM2T1. All rights reserved.
//

import UIKit
import CoreData

class ShowEditPerretes: UIViewController {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var intNombre: UITextField!
    @IBOutlet weak var intDescripcion: UITextField!
    @IBOutlet weak var intPopularidad: UITextField!
    
    var contexto: NSManagedObjectContext?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //DATABASE
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        contexto = (appDelegate?.persistentContainer.viewContext)!
        
        
        intNombre.text = infoPerrete[0]
        intDescripcion.text = infoPerrete[1]
        intPopularidad.text = infoPerrete[2]
        
        switch infoPerrete[3] {
        case "Fashion":
            img.image = #imageLiteral(resourceName: "img3")
            break
        case "Casual":
            img.image = #imageLiteral(resourceName: "img2")
            break
        case "Street":
            img.image = #imageLiteral(resourceName: "img1")
            break
        case "Formal":
            img.image = #imageLiteral(resourceName: "img4")
            break
        default:
            break
        }
    }
    
    @IBAction func btnGaurdar(_ sender: Any) {
        var arrayPopu = intPopularidad.text?.components(separatedBy: ".")
        print(arrayPopu![0])
        var entero = Int(arrayPopu![0])
        var decimal = Int(arrayPopu![1])
        var doublePopu = Double(entero! + decimal!/10)
        updatePerreteDB(nombre: intNombre.text!, descripcion: intDescripcion.text!, popularidad: doublePopu)
    }
    
    func updatePerreteDB(nombre : String, descripcion : String, popularidad: Double){
        var arrayPopu = intPopularidad.text?.components(separatedBy: ".")

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName : "PerreteFashion")
        fetchRequest.predicate = NSPredicate(format: "nombre == %@", infoPerrete[0])
        fetchRequest.predicate = NSPredicate(format: "descripcion == %@", infoPerrete[1])
        
        do{
            let results = try contexto?.fetch(fetchRequest)
            if results!.count > 0 {
                var perrete = results?.first as! PerreteFashion
                perrete.nombre = nombre
                perrete.descripcion = descripcion
                perrete.popularidad = popularidad
                try contexto?.save()
            }else{
                print ("Error, no hay perretes en la db)")
            }
        } catch let error as NSError {
            print ("Error al recuperar: \(error)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
