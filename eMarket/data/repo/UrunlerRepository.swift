import Foundation
import RxSwift
import Alamofire

class UrunlerRepository {
    
    var urunlerListesi = BehaviorSubject<[Urunler]>(value: [Urunler]())
    var sepetListesi = BehaviorSubject<[UrunlerSepeti]>(value: [UrunlerSepeti]())
    let disposeBag = DisposeBag() // To manage subscriptions
    
    func tumUrunleriGetir() {
        let url = "http://kasimadalan.pe.hu/urunler/tumUrunleriGetir.php"
        
        AF.request(url, method: .get).response { response in
            if let data = response.data {
                do {
                    let cevap = try JSONDecoder().decode(UrunlerCevap.self, from: data)
                    if let liste = cevap.urunler {
                        self.urunlerListesi.onNext(liste) // Tetikleme
                        
                        // Subscribe to the BehaviorSubject to access its values
                        self.urunlerListesi.subscribe(onNext: { urunler in
                            for urun in urunler {
                                if let resimAdi = urun.resim {
                                    _ = self.resimURLOlustur(resimAdi: resimAdi)
                                }
                            }
                        }).disposed(by: self.disposeBag) // Dispose the subscription properly
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func resimURLOlustur(resimAdi: String) -> String {
        let baseUrl = "http://kasimadalan.pe.hu/urunler/resimler/"
        if resimAdi.hasSuffix(".png") {
            return baseUrl + resimAdi // Eğer zaten ".png" varsa direkt ekle
        } else {
            return baseUrl + resimAdi + ".png" // Eğer yoksa ".png" ekle
        }
    }
    
    func sepeteUrunEkle(ad: String, resim: String, kategori: String, fiyat: Int, marka: String, siparisAdet: Int, kullaniciAdi: String) {
        let url = "http://kasimadalan.pe.hu/urunler/sepeteUrunEkle.php"
        let params: Parameters = [
            "ad": ad,
            "resim": resim,
            "kategori": kategori,
            "fiyat": fiyat,
            "marka": marka,
            "siparisAdeti": siparisAdet,
            "kullaniciAdi": kullaniciAdi
        ]
        
        AF.request(url, method: .post, parameters: params).response { response in
            if let data = response.data {
                do {
                    let cevap = try JSONDecoder().decode(CRUDCevap.self, from: data)
                    print("Başarı : \(cevap.success ?? 0)")
                    print("Mesaj : \(cevap.message ?? "Bilinmiyor")")
                    
                } catch {
                    print("Hata: \(error.localizedDescription)")
                }
            }
        }
       
    }
    
    
    func sepettekiUrunleriGetir(kullaniciAdi: String, completion: @escaping ([UrunlerSepeti]?) -> Void) {
        let url = "http://kasimadalan.pe.hu/urunler/sepettekiUrunleriGetir.php?kullaniciAdi=\(kullaniciAdi)"

        let params: Parameters = [
            "kullaniciAdi": kullaniciAdi
        ]
        
        AF.request(url, method: .post, parameters: params).responseDecodable(of: UrunlerSepetiCevap.self) { response in
                switch response.result {
                case .success(let jsonCevap):
                    // Emit the cart list to the subject
                    if let urunlerSepeti = jsonCevap.urunler_sepeti {
                        self.sepetListesi.onNext(urunlerSepeti) // Emit the cart list
                        completion(urunlerSepeti)
                    } else {
                        completion(nil)
                    }
                case .failure(let error):
                    print("Decoding error: \(error)")
                    completion(nil)
                }
            }
        }
    
    func sil(sepetId:Int,kullaniciAdi:String){
        let url = "http://kasimadalan.pe.hu/urunler/sepettenUrunSil.php"
        let params:Parameters = ["sepetId":sepetId,"kullaniciAdi":kullaniciAdi]
        
        AF.request(url,method: .post,parameters: params).response { response in
            if let data = response.data {
                do{
                    let cevap = try JSONDecoder().decode(CRUDCevap.self, from: data)
                    print("Başarı : \(cevap.success!)")
                    print("Mesaj : \(cevap.message!)")
                    
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    


    
}
