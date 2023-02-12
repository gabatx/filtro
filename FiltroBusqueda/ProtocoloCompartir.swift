//
//  ProtocoloCompartir.swift
//  FiltroBusqueda
//
//  Created by Escuela de Tecnologias Aplicadas on 12/12/22.
//

import Foundation
import UIKit

protocol ProtocoloCompartir: AnyObject {
    func compartir(_ sender: Any, texto: String, imagen:UIImageView)
}
