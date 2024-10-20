//
//  SepetSayfa.swift
//  eMarket
//
//  Created by Hazal Bölükbaşı on 18.10.2024.
//

import UIKit
import RxSwift

class SepetSayfa: UIViewController {

    @IBOutlet weak var fiyatBaslikLabel: UILabel!
    @IBOutlet weak var fiyatLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var sepetiOnayla: UIButton!
    
    var viewModel = SepetSayfaViewModel()
    let disposeBag = DisposeBag()
    var sepetListesi = [UrunlerSepeti]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        // Sepet ürünlerini yükleme
        viewModel.sepettekiUrunleriGetir(kullaniciAdi: "hazalbolukbasii")
        
        viewModel.sepetListesi
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] urunlerSepeti in
                self?.sepetListesi = urunlerSepeti
                self?.tableView.reloadData()
                self?.toplamFiyatiGuncelle()
                
            })
            .disposed(by: disposeBag)

 
    }
    
    func toplamFiyatiGuncelle() {
       let toplamFiyat = sepetListesi.reduce(0) { (toplam, urun) in
           toplam + (urun.fiyat ?? 0 * (urun.siparisAdet ?? 1))
       }
       fiyatLabel.text = "\(toplamFiyat) TL"
   }

}

extension SepetSayfa: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sepetListesi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SepetHucre", for: indexPath) as! SepetHucre
        
        let secilenUrun = sepetListesi[indexPath.row]
        cell.titleLabel.text = secilenUrun.ad
        cell.fiyatLabel.text = "\(secilenUrun.fiyat!) TL"
        cell.adetLabel.text = "\(secilenUrun.siparisAdet ?? 1)"
        
        if let resim = secilenUrun.resim {
            let resimURL = viewModel.resimURLOlustur(resimAdi: resim)
            cell.urunImageView.sd_setImage(with: URL(string: resimURL))
        }
        
        cell.sepetUrunleri = secilenUrun
        cell.viewModel = viewModel
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let secilenUrun = sepetListesi[indexPath.row]
        let silAction = UIContextualAction(style: .destructive, title: "Sil") { [weak self] contextualAction, view, bool in
            guard let self = self else { return }
            
            let alert = UIAlertController(title: "Silme İşlemi", message: "\(secilenUrun.ad!) silinsin mi?", preferredStyle: .alert)
            let iptalAction = UIAlertAction(title: "İptal", style: .cancel)
            alert.addAction(iptalAction)
            let evetAction = UIAlertAction(title: "Evet", style: .destructive) { action in
                self.viewModel.sil(sepetId: Int(secilenUrun.sepetId!), kullaniciAdi: "hazalbolukbasii")
                
                // Sepet listesinden ürünü kaldır ve tabloyu güncelle
                self.sepetListesi.remove(at: indexPath.row)
                self.tableView.performBatchUpdates({
                    self.tableView.deleteRows(at: [indexPath], with: .automatic)
                }, completion: { _ in
                    self.toplamFiyatiGuncelle() // Update total price immediately
                })
            }
            
            alert.addAction(evetAction)
            self.present(alert, animated: true)
        }
        return UISwipeActionsConfiguration(actions: [silAction])
    }
    
    // Hücre yüksekliğini ayarla
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            let ekranGenislik = UIScreen.main.bounds.width
            let itemGenislik = (ekranGenislik - 50) / 2 // 50'yi toplam kenar boşluğu için ayarlayabilirsin
            return itemGenislik * 1.0 // Yükseklik
        }
}
