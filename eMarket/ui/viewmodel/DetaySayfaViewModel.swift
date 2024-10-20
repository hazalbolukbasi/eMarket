//
//  DetaySayfaViewModel.swift
//  eMarket
//
//  Created by Hazal Bölükbaşı on 18.10.2024.
//

import Foundation

class DetaySayfaViewModel{
    var urepo = UrunlerRepository()
    
    func sepeteUrunEkle(ad: String, resim: String, kategori: String, fiyat: Int, marka: String, siparisAdet: Int, kullaniciAdi: String){
        urepo.sepeteUrunEkle(ad: ad, resim: resim, kategori: kategori, fiyat: fiyat, marka: marka, siparisAdet: siparisAdet, kullaniciAdi: kullaniciAdi)
    }
    
}
