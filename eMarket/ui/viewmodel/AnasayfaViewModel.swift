//
//  AnasayfaViewModel.swift
//  eMarket
//
//  Created by Hazal Bölükbaşı on 18.10.2024.
//

import Foundation
import RxSwift

class AnasayfaViewModel{
    var urepo = UrunlerRepository()
    var urunler: [Urunler] = []
    var urunlerListesi = BehaviorSubject<[Urunler]>(value: [Urunler]())
    let disposeBag = DisposeBag()
    
    init(){
        tumUrunleriGetir()
    }
    
    func tumUrunleriGetir() {
            urepo.tumUrunleriGetir()
            _ = urepo.urunlerListesi.subscribe(onNext: { liste in
                self.urunler = liste // Urunler dizisini güncelle
                self.urunlerListesi.onNext(liste) // BehaviorSubject'ini de güncelle
            }).disposed(by: disposeBag)
        }
        
    func numberofUrun() -> Int {
        return urunler.count
    }
    
    func urun(at index : Int) -> Urunler {
        return urunler[index]
    }
    
    func resimAl(for product: Urunler) -> String {
        return "http://kasimadalan.pe.hu/urunler/resimler/\(product.resim!)"
    }
    
    
}
