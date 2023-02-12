/*
- Creamos una instancia de UISearchController:
    let searchController = UISearchController(searchResultsController: nil)
 - Creamos la función inicializarSearchController():
        func initacializarSearchController() {
        // Creamos una instancia de UISearchController
        let searchController = UISearchController(searchResultsController: nil)
        // Asignamos el delegado. Le está diciendo cual es la clase que va a gestionar los resultados de la búsqueda
        searchController.searchResultsUpdater = self
        // Ocultamos el fondo. Si no lo ponemos, se vería el fondo de la tabla
        searchController.obscuresBackgroundDuringPresentation = false
        // Ponemos un placeholder.
        searchController.searchBar.placeholder = "Buscar"
        // Lo asignamos a la barra de navegación (lo asignamos al navigationItem). Le decimos que ponga en el espacio de la barra de navegación el searchController
        navigationItem.searchController = searchController

        // De esta manera podemos elegir el lugar donde queramos presentarlo. En este caso sería por ejemplo la cabecera de la tabla
        // self.miTableView.tableHeaderView = searchController.searchBar

        // Definimos el contexto.
        definesPresentationContext = true
    }

 - La linea searchController.searchResultsUpdater = self -> Nos pedirá que nos conformemos con el protocolo UISearchResultsUpdating, lo cual haremos en una extensión.
 - En la extensi´ón, en la función creada (se ejecuta en cada pulsación) le añadimos una función que filtre.
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filtraContenidoBuscadorTexto(searchBar.text!)
    }
 - Creamos la función de filtrado:
    func filtraContenidoBuscadorTexto(_ texto: String) {
        // Filtramos el array de datos
        arrayFiltrado = arrayDatos.filter({ (datos) -> Bool in
            return datos.lowercased().contains(texto.lowercased())
        })
        // Recargamos la tabla
        miTableView.reloadData()
    }

 - Creamos las propiedades computadas:
        // Creamos propiedades calculadas
    var estaSearchBarVacio: Bool {
        // Mira si el searchController está activo. Si lo está y el texto es vacío, devuelve true. Si no, devuelve false
        return navigationItem.searchController?.searchBar.text?.isEmpty ?? true
    }

    var estaFiltrando: Bool {
        // Solo devuelve false cuando el searchController está activo y el texto de la searchBar no está vacío
        return navigationItem.searchController?.isActive ?? false && !estaSearchBarVacio
    }
*/

import UIKit

class InicioViewController: UIViewController {
    // Referencias
    @IBOutlet weak var miTableView: UITableView!

    // Instancias
    // La realizamos con lazy para que se cree cuando se necesite. De esta manera no dará error.
    lazy var filtrado: FiltraElementos = {
        let ciudadesListado = ["Linares", "Granada", "Málaga", "Madrid", "Barcelona"]
        return FiltraElementos(arrayElementosIniciales: ciudadesListado, miTableView: miTableView, navigationItem: navigationItem)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        miTableView.delegate = self
        miTableView.dataSource = self
        
        filtrado.inicializarSearchController(contexto: &definesPresentationContext, navigationItem: navigationItem)
    }
}

extension InicioViewController: ProtocoloCompartir {
    func compartir(_ sender: Any, texto: String, imagen:UIImageView) {
        // Creamos un array con el texto y la imagen
        let objetoACompartir: [Any] = [texto, imagen.image!]
        // Creamos una instancia de UIActivityViewController. Sirve para compartir contenido. Le pasamos el array con el texto e imagen
        let activityVC = UIActivityViewController(activityItems: objetoACompartir, applicationActivities: nil)
        // Le decimos que se presente desde el botón pulsado. El sender es el botón pulsado
        activityVC.popoverPresentationController?.sourceView = sender as? UIView
        // Lo presentamos
        self.present(activityVC, animated: true, completion: nil)
    }
}
