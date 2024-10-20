//
//  UrunlerHucre.swift
//  eMarket
//
//  Created by Hazal Bölükbaşı on 18.10.2024.
//



import UIKit


class SepetHucre: UITableViewCell {
    
    
    @IBOutlet weak var urunImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var fiyatLabel: UILabel!
    @IBOutlet weak var adetLabel: UILabel!
    @IBOutlet weak var adetBaslik: UILabel!
    
    @IBAction func favoriekle(_ sender: Any) {
    }
    
    var sepetUrunleri : UrunlerSepeti?
    var viewModel: SepetSayfaViewModel?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    @IBAction func copSepeti(_ sender: Any) {
    }
    
}
