//
//  DetaySayfa.swift
//  eMarket
//
//  Created by Hazal Bölükbaşı on 18.10.2024.
//

import UIKit

class DetaySayfa: UIViewController {

    var urun: Urunler?
    
    var viewModel = DetaySayfaViewModel()
    
    @IBOutlet weak var urunImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var fiyatLabel: UILabel!
    @IBOutlet weak var adetLabel: UILabel!
    @IBOutlet weak var markaLabel: UILabel!
    
    @IBOutlet weak var tumOzelikler: UIButton!
    
    var adet: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let u = urun {
            titleLabel.text = u.ad
            fiyatLabel.text = "\(u.fiyat!) TL"
            markaLabel.text = u.marka
            urunImageView.sd_setImage(with: URL(string: "http://kasimadalan.pe.hu/urunler/resimler/\(u.resim!)"))
            adetLabel.text = "\(adet)"
        }
      
    }
    

    @IBAction func sepeteEkle(_ sender: Any) {
        
        guard let urun = urun else { return } // Eğer ürün mevcutsa

            // Ürün bilgilerini kullanarak sepete ekle
            viewModel.sepeteUrunEkle(
                ad: urun.ad ?? "",
                resim: urun.resim ?? "", // Resim boşsa boş bir string kullan
                kategori: urun.kategori ?? "", // Kategori boşsa boş bir string kullan
                fiyat: urun.fiyat ?? 0, // Fiyat boşsa 0 kullan
                marka: urun.marka ?? "", // Marka boşsa boş bir string kullan
                siparisAdet: adet, // Varsayılan sipariş adeti
                kullaniciAdi: "hazalbolukbasii" // Kullanıcı adını burada belirt
                
                
            )
        
        // Kullanıcıya bilgilendirme mesajı göster
        let alert = UIAlertController(title: "Başarılı", message: "\(urun.ad!) sepete eklendi.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: { _ in
            // Sepet sayfasına yönlendir
            self.performSegue(withIdentifier: "toSepet", sender: nil)
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func adetCikar(_ sender: Any) {
        if adet > 1 {
            adet -= 1
            adetLabel.text = "\(adet)"
        }
    }
    
    
    @IBAction func adetEkle(_ sender: Any) {
        adet += 1
        adetLabel.text = "\(adet)"
    }
    
    
}
