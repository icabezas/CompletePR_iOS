//
//  DetallesPerrete.swift
//  PerretesFashion
//
//  Created by DAM2T1 on 12/5/18.
//  Copyright © 2018 DAM2T1. All rights reserved.
//

import UIKit

class DetallesPerrete: UIViewController {
    @IBOutlet weak var imgPerrete: UIImageView!
    
    @IBOutlet weak var lblPopu: UILabel!
    @IBOutlet weak var lblDescripcion: UILabel!
    @IBOutlet weak var lblNombre: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        lblNombre.text = infoPerrete[0]
        lblDescripcion.text = infoPerrete[1]
        lblPopu.text = infoPerrete[2]
        
        switch infoPerrete[3] {
        case "Fashion":
            imgPerrete.image = #imageLiteral(resourceName: "img3")
            break
        case "Casual":
            imgPerrete.image = #imageLiteral(resourceName: "img2")
            break
        case "Street":
            imgPerrete.image = #imageLiteral(resourceName: "img1")
            break
        case "Formal":
            imgPerrete.image = #imageLiteral(resourceName: "img4")
            break
        default:
            break
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
