//
//  Urunler.swift
//  eShop
//
//  Created by Hazal Bölükbaşı on 16.10.2024.
//

import Foundation

class Urunler : Codable {
    var id:Int?
    var ad:String?
    var resim:String?
    var kategori:String?
    var fiyat: Int?
    var marka:String?
    
    var siparisAdet: Int?  // Sipariş adeti eklendi
    
    init(id: Int, ad: String, resim: String, kategori: String, fiyat: Int, marka: String,siparisAdet: Int = 0) {
        self.id = id
        self.ad = ad
        self.resim = resim
        self.kategori = kategori
        self.fiyat = fiyat
        self.marka = marka
        self.siparisAdet = siparisAdet  // Başlangıçta sipariş adeti
    }
    
    // This computed property will return the full image URL
        var resimUrl: String {
            return "http://kasimadalan.pe.hu/urunler/resimler/\(resim!)"
        }
}

