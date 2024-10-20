//
//  UrunlerSepeti.swift
//  eShop
//
//  Created by Hazal Bölükbaşı on 16.10.2024.
//

import Foundation

class UrunlerSepeti : Codable {
    var sepetId:Int?
    var ad:String?
    var resim:String?
    var kategori:String?
    var fiyat:Int?
    var marka:String?
    var siparisAdet: Int?
    var kullaniciAdi:String?
    
    init(id: Int, ad: String, resim: String, kategori: String, fiyat: Int, marka: String, siparisAdet: Int, kullaniciAdi: String) {
        self.sepetId = id
        self.ad = ad
        self.resim = resim
        self.kategori = kategori
        self.fiyat = fiyat
        self.marka = marka
        self.siparisAdet = siparisAdet
        self.kullaniciAdi = kullaniciAdi
    }
 
    func updateAdet(adet: Int) {
            self.siparisAdet = (self.siparisAdet ?? 0) + adet
        }
  }
