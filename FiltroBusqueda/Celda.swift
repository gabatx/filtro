import UIKit

class Celda: UITableViewCell {
    @IBOutlet weak var imagenCelda: UIImageView!
    @IBOutlet weak var tituloImagenCelda: UILabel!
    @IBOutlet weak var botonCompartir: UIButton!

    weak var delegate: ProtocoloCompartir?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    // Listener del botón compartir
    @IBAction func botonCompartir(_ sender: Any) {
        delegate?.compartir( sender, texto: tituloImagenCelda.text ?? "", imagen: imagenCelda)
    }
}
