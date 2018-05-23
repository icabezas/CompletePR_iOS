//
//  Table.swift
//  PerretesFashion
//
//  Created by DAM2T1 on 23/3/18.
//  Copyright © 2018 DAM2T1. All rights reserved.
//

import UIKit
import CoreData


class Table: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var contexto: NSManagedObjectContext?
    
   
    @IBOutlet weak var tabla: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categorias.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tabla.dequeueReusableCell(withIdentifier: "celda") as! MiCelda
        celda.lblCantidad.text = String(getPerretesPorCategoria(tipoVestimenta: categorias[indexPath.row]).count)
        celda.lblCategoria.text = categorias[indexPath.row].tipoVestimenta
        return celda
    }
  
    //SE EJECUTA AL HACER CLIC EN UNA FILA DE LA TABLA PASANDO LOS DATOS AL SIGUIENTE VIEW
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        categoriaSeleccionada = categorias[indexPath.row]
        perretesPorCategoria = getPerretesPorCategoria(tipoVestimenta: categoriaSeleccionada!)
        //performSegue(withIdentifier: "showPerretesFashionetes", sender: self)
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabla.delegate = self
        tabla.dataSource = self
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        contexto = (appDelegate?.persistentContainer.viewContext)!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //DEVUELVE LA CANTIDAD DE PERRETESFASHION QUE TIENE EL USUARIO DE CADA CATEGORIA
    func getPerretesPorCategoria(tipoVestimenta : Categoria) -> [PerreteFashion]{
        let fetchNote = NSFetchRequest<NSFetchRequestResult>(entityName: "PerreteFashion")
        if(tipoVestimenta.tipoVestimenta == nil){
            tipoVestimenta.tipoVestimenta = ""
        }
        let otherResult = try! contexto?.fetch(fetchNote) as? [PerreteFashion]
        fetchNote.predicate = NSPredicate(format: "perreteCategoria.tipoVestimenta  == %@ AND perreteUser.username == %@", tipoVestimenta.tipoVestimenta!, userSession!.username!)
        let notes = try! contexto?.fetch(fetchNote) as? [PerreteFashion]
        return notes!
    }
    override func viewDidAppear(_ animated: Bool) {
        tabla.reloadData()
    }

    
    
    //DEVUELVE UN ARRAY CON LAS CATEGORIAS TOTALES
    func categoriasTotales() -> Int{
        var categoriasTotales = 0
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName : "Categoria")
        do {
            let results = try contexto?.fetch(fetchRequest)
            for categoria in results! {
                categorias.append(categoria as! Categoria)
            }
            categoriasTotales = results!.count
        } catch let error as NSError {
            print ("Error al recuperar: \(error)")
        }
        return categoriasTotales
    }
    
    
    
}
