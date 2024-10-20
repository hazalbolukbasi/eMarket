//
//  ViewController.swift
//  eMarket
//
//  Created by Hazal Bölükbaşı on 18.10.2024.
//

import UIKit
import SDWebImage

class Anasayfa: UIViewController {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var urunlerListesi = [Urunler]()
    
    var viewModel = AnasayfaViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // ViewModel'den veri almak için subscribe ol
        _ = viewModel.urunlerListesi.subscribe(onNext: { liste in
            self.urunlerListesi = liste
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }).disposed(by: viewModel.disposeBag) // DisposeBag ekle
        
        // Başlangıçta ürünleri çek
        viewModel.tumUrunleriGetir()
        
        
        let tasarim = UICollectionViewFlowLayout()
        tasarim.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        tasarim.minimumInteritemSpacing = 10
        tasarim.minimumLineSpacing = 10
                
        let ekranGenislik = UIScreen.main.bounds.width
        let itemGenislik = (ekranGenislik - 50) / 2
        tasarim.itemSize = CGSize(width: itemGenislik, height: itemGenislik * 1.5)
                
        collectionView.collectionViewLayout = tasarim
    }
}

extension Anasayfa : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}



extension Anasayfa : UICollectionViewDelegate , UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberofUrun()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let hucre = collectionView.dequeueReusableCell(withReuseIdentifier: "urunlerHucre", for: indexPath) as! UrunlerHucre
        
        let urun = viewModel.urun(at: indexPath.row)
        
        hucre.layer.borderColor = UIColor.lightGray.cgColor
        hucre.layer.borderWidth = 0.3
        hucre.layer.cornerRadius = 10
        hucre.backgroundColor = UIColor.white
        
        hucre.urunLabel.text = urun.ad
        hucre.fiyatLabel.text = "\(urun.fiyat!) TL"
        //hucre.urunImageView.image = urun.resim
        
        let imageUrl = viewModel.resimAl(for: urun)
        hucre.urunImageView.sd_setImage(with: URL(string: imageUrl))
        
        
        return hucre
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let secilenUrun = viewModel.urunler[indexPath.row]
        performSegue(withIdentifier: "toDetay", sender: secilenUrun)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetay" {
            if let urun = sender as? Urunler {
                let gidilecekVC = segue.destination as! DetaySayfa
                gidilecekVC.urun = urun
            }
        }
    }
    
    
}
