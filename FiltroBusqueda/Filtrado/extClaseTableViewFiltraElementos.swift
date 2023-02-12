import Foundation
import UIKit

extension InicioViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Si estamos filtrando, devolvemos el número de elementos del array filtrado. Si no, devolvemos el número de elementos del array original
        return filtrado.estaFiltrando ? filtrado.arrayElementosFiltrados.count : filtrado.arrayElementosIniciales.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Creamos una instancia de la celda
        let celda = miTableView.dequeueReusableCell(withIdentifier: "idCelda", for: indexPath) as! Celda
        celda.delegate = self
        // Si estamos filtrando, devolvemos el array filtrado. Si no, devolvemos el array original
        let arrayElementos: [String] = filtrado.estaFiltrando ? filtrado.arrayElementosFiltrados : filtrado.arrayElementosIniciales
        celda.tituloImagenCelda.text = arrayElementos[indexPath.row]
        celda.imagenCelda.image = UIImage(named: arrayElementos[indexPath.row])

        return celda
    }

    func numberOfSections(in tableView: UITableView) -> Int { 1 }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 204 }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(filtrado.estaFiltrando ? filtrado.arrayElementosFiltrados[indexPath.row] : filtrado.arrayElementosIniciales[indexPath.row])
    }
}
