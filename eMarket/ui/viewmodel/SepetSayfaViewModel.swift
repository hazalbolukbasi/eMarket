//
//  SepetSayfaViewModel.swift
//  eMarket
//
//  Created by Hazal Bölükbaşı on 18.10.2024.
//

import Foundation
import RxSwift

class SepetSayfaViewModel{
    
    var urepo = UrunlerRepository()
    var sepetListesi: BehaviorSubject<[UrunlerSepeti]> = BehaviorSubject(value: [])
    var urunlerSepet: [UrunlerSepeti] = []
    
    init(){
        sepettekiUrunleriGetir(kullaniciAdi: "hazalbolukbasii")
    }
    
    func sepettekiUrunleriGetir(kullaniciAdi: String) {
        urepo.sepettekiUrunleriGetir(kullaniciAdi: kullaniciAdi) { [weak self] urunlerSepeti in
            if let urunlerSepeti = urunlerSepeti {
                print("Sepet ürünleri güncelleniyor: \(urunlerSepeti)")
                self?.sepetListesi.onNext(urunlerSepeti)
            } 
        }
    }
    
    func resimURLOlustur(resimAdi: String) -> String {
        urepo.resimURLOlustur(resimAdi: resimAdi)
    }
     
    func sepetUrun(at index : Int) -> UrunlerSepeti {
        return urunlerSepet[index]
    }
    
    func sil(sepetId: Int, kullaniciAdi: String) {
            urepo.sil(sepetId: sepetId, kullaniciAdi: kullaniciAdi)
            if let index = urunlerSepet.firstIndex(where: { $0.sepetId == sepetId }) {
                urunlerSepet.remove(at: index)
                sepetListesi.onNext(urunlerSepet)
            }
        }
    
        func removeItem(at index: Int) {
            urunlerSepet.remove(at: index)
            sepetListesi.onNext(urunlerSepet)
        }
}
