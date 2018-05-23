//
//  EditPerreteView.swift
//  PerretesFashion
//
//  Created by DAM2T1 on 12/5/18.
//  Copyright © 2018 DAM2T1. All rights reserved.
//

import UIKit
import CoreData

class EditPerreteView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {

    @IBOutlet weak var collectionView: UICollectionView!
    var perretesFashion : [PerreteFashion] = []
    var contexto: NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //COLLECTION CELL
        collectionView.delegate = self
        collectionView.dataSource = self
        //showButtons(show : false)
        
        //DATABASE
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        contexto = (appDelegate?.persistentContainer.viewContext)!
    }

    override func viewDidAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return perretesPorCategoria.count
    }

    
    //DEVUELVE LA CANTIDAD DE PERRETESFASHION QUE TIENE EL USUARIO DE CADA CATEGORIA
    func getPerretesPorCategoria(tipoVestimenta : Categoria) -> [PerreteFashion]{
        let fetchNote = NSFetchRequest<NSFetchRequestResult>(entityName: "PerreteFashion")
        let otherResult = try! contexto?.fetch(fetchNote) as? [PerreteFashion]
        fetchNote.predicate = NSPredicate(format: "perreteCategoria.tipoVestimenta  == %@ AND perreteUser.username == %@", tipoVestimenta.tipoVestimenta!, userSession!.username!)
        let notes = try! contexto?.fetch(fetchNote) as? [PerreteFashion]
        return notes!
    }
    
    // DEFINE QUE QUEREMOS QUE MUESTRE EN CADA CELDA
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollecCell
        perretesFashion = getPerretesPorCategoria(tipoVestimenta: categoriaSeleccionada!)
        cell.perreteName.text = perretesFashion[indexPath.row].nombre
        switch perretesFashion[indexPath.row].perreteCategoria?.tipoVestimenta {
        case "Fashion"?:
            cell.image.image = #imageLiteral(resourceName: "img3")
            break
        case "Casual"?:
            cell.image.image = #imageLiteral(resourceName: "img2")
            break
        case "Street"?:
            cell.image.image = #imageLiteral(resourceName: "img1")
            break
        case "Formal"?:
            cell.image.image = #imageLiteral(resourceName: "img4")
            break
        default:
            break
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        infoPerrete.removeAll()
        infoPerrete.append(perretesFashion[indexPath.row].nombre!)
        infoPerrete.append(perretesFashion[indexPath.row].descripcion!)
        infoPerrete.append(String(perretesFashion[indexPath.row].popularidad))
        infoPerrete.append((perretesFashion[indexPath.row].perreteCategoria?.tipoVestimenta)!)
        var imgPerrete : UIImage
        switch perretesFashion[indexPath.row].perreteCategoria?.tipoVestimenta {
        case "Fashion"?:
            imgPerrete = #imageLiteral(resourceName: "img3")
            break
        case "Casual"?:
            imgPerrete = #imageLiteral(resourceName: "img2")
            break
        case "Street"?:
            imgPerrete = #imageLiteral(resourceName: "img1")
            break
        case "Formal"?:
            imgPerrete = #imageLiteral(resourceName: "img4")
            break
        default:
            break
        }
    }
    

}
