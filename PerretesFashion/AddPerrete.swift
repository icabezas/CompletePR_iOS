//
//  AddPerrete.swift
//  PerretesFashion
//
//  Created by DAM2T1 on 9/4/18.
//  Copyright © 2018 DAM2T1. All rights reserved.
//

import UIKit
import CoreData

class AddPerrete: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var contexto: NSManagedObjectContext?

    
    @IBOutlet weak var pickerCategoria: UIPickerView!

    @IBOutlet weak var inputNombre: UITextField!
    
    @IBOutlet weak var inputDescripcion: UITextField!
    
    @IBOutlet weak var inputPopularidad: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //PICKERVIEW
        pickerCategoria.dataSource = self
        pickerCategoria.delegate = self
        
        //DATABASE
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        contexto = (appDelegate?.persistentContainer.viewContext)!
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //AÑADE UN PERRETEFASHION A LA BASE DE DATOS
    @IBAction func savePerrete(_ sender: Any) {
        //CREAMOS UN TIPO DE ENTIDAD: PERRETEFASHION
        let perreteFashionEntity = NSEntityDescription.entity(forEntityName: "PerreteFashion", in: contexto!)
        
        //CREAMOS UNA ENTIDAD DEL TIPO CATEGORIA
        let perreteFashion = PerreteFashion(entity: perreteFashionEntity!, insertInto: contexto)
        
        //ASIGNAMOS VALORES
        perreteFashion.descripcion = inputDescripcion.text
        perreteFashion.nombre = inputNombre.text
        perreteFashion.perreteCategoria = categorias[pickerCategoria.selectedRow(inComponent: 0)]
        perreteFashion.perreteUser = userSession
        
        perreteFashion.popularidad = Double(inputPopularidad.text!)!
        
        
        //GUARDAMOS CATEGORIA EN CONTEXTO
        do {
            try contexto?.save()
            _ = navigationController?.popViewController(animated: true)
            
        }catch let error as NSError {
            print ("Error al insertar: \(error)")
        }
    }
    
    //Métodos que nos obliga a sobreescribir por heredar de UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categorias.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categorias[row].tipoVestimenta
    }
    
    
}
