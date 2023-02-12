import Foundation
import UIKit

class FiltraElementos: NSObject {

    let arrayElementosIniciales: [String]
    var arrayElementosFiltrados: [String] = []
    let miTableView: UITableView
    let navigationItem: UINavigationItem
    let searchController = UISearchController(searchResultsController: nil)
    var estaSearchBarVacio: Bool {
        // Mira si el searchController está activo. Si lo está y el texto es vacío, devuelve true. Si no está vacío, devuelve false
        return searchController.searchBar.text?.isEmpty ?? true
    }
    var estaFiltrando: Bool {
        // Solo devuelve true cuando está activo y además vacío. Decir que está activo es lo mismo que decir que el usuario lo tiene seleccionado.
        return searchController.isActive && !estaSearchBarVacio
    }

    init(arrayElementosIniciales: [String], miTableView: UITableView, navigationItem: UINavigationItem) {
        self.arrayElementosIniciales = arrayElementosIniciales
        self.miTableView = miTableView
        self.navigationItem = navigationItem
    }

    func inicializarSearchController(contexto definesPresentationContext: inout Bool, navigationItem: UINavigationItem) {
        // Le estamos diciendo cual es la clase que va a gestionar los resultados de la búsqueda. Nos pedirá conformarnos con UISearchResultsUpdating
        searchController.searchResultsUpdater = self
        // Ocultar la barra de navegación cuando se active el searchController
        searchController.obscuresBackgroundDuringPresentation = false
        // Ponemos un placeholder.
        searchController.searchBar.placeholder = "Buscar"
        // Indicamos que cuando se haga scroll se oculte la barra de búsqueda
        navigationItem.hidesSearchBarWhenScrolling = true
        // Le decimos que ponga en el espacio de la barra de navegación el searchController
        navigationItem.searchController = searchController

        // Introducimos dos botones que filtrarán alfábeticamente
        searchController.searchBar.scopeButtonTitles = ["A-Z", "Z-A"]
        searchController.searchBar.delegate = self

        // Definimos el contexto. Le decimos que el contexto de la vista es el mismo que el de la barra de navegación
        definesPresentationContext = true
    }
}

extension FiltraElementos:  UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {

        if estaFiltrando{
            // Si se pulsa A-Z
            if selectedScope == 0 {
                arrayElementosFiltrados.sort(by: {$0 > $1})
            } else {
                arrayElementosFiltrados.sort(by: {$0 < $1})
            }
        } else {
            if selectedScope == 0 {
                arrayElementosFiltrados = arrayElementosIniciales.sorted()
            } else {
                arrayElementosFiltrados = arrayElementosIniciales.sorted().reversed()
            }
        }

        print(arrayElementosFiltrados)
        self.miTableView.reloadData()
    }
}

extension FiltraElementos: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let textoDelSearchController = searchController.searchBar.text!
        // Filtramos el array de datos
        arrayElementosFiltrados = arrayElementosIniciales.filter({ (item: String) -> Bool in
            return item.lowercased().localizedCaseInsensitiveContains(textoDelSearchController)
        })
        // Recargamos la tabla
        miTableView.reloadData()
    }
}
