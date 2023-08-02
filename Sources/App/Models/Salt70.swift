import Fluent
import Vapor

final class Salt70: Model, Content {
  static let schema = "salt70"
  
  @ID(custom: "id")
  var id: Int?
  
  @Field(key: "malzeme")
  var malzeme: String
  
  @Field(key: "malzeme_aciklamasi")
  var malzeme_aciklamasi: String
  
  @Field(key: "musteri")
  var musteri: String
  
  @Field(key: "musteri_adi")
  var musteri_adi: String
  
  @Field(key: "ulke")
  var ulke: String
  
  @Field(key: "tarih")
  var tarih: String
  
  @Field(key: "fatura_tipi")
  var fatura_tipi: String
  
  @Field(key: "fatura_no")
  var fatura_no: String
  
  @Field(key: "item_no")
  var item_no: Int
  
  @Field(key: "miktar")
  var miktar: Double
  
  @Field(key: "miktar_br")
  var miktar_br: String
  
  @Field(key: "birim_fiyat")
  var birim_fiyat: Double
  
  @Field(key: "indirimsiz_net")
  var indirimsiz_net: Double
  
  @Field(key: "indirimli_net")
  var indirimli_net: Double
  
  @Field(key: "kdv")
  var kdv: Double
  
  @Field(key: "genel_toplam")
  var genel_toplam: Double
  
  @Field(key: "para_birimi")
  var para_birimi: String
  
  @Field(key: "kur_indirimsiz")
  var kur_indirimsiz: Double
  
  @Field(key: "kur_indirimli")
  var kur_indirimli: Double
  
  @Field(key: "kur_vergi")
  var kur_vergi: Double
  
  @Field(key: "kur_toplam")
  var kur_toplam: Double
  
  init() { }
  
  init(id: Int? = nil, malzeme: String, malzeme_aciklamasi: String, musteri: String, musteri_adi: String, ulke: String, tarih: String, fatura_tipi: String, fatura_no: String, item_no: Int, miktar: Double, miktar_br: String, birim_fiyat: Double, indirimsiz_net: Double, indirimli_net: Double, kdv: Double, genel_toplam: Double, para_birimi: String, kur_indirimsiz: Double, kur_indirimli: Double, kur_vergi: Double, kur_toplam: Double) {
    self.id = id
    self.malzeme = malzeme
    self.malzeme_aciklamasi = malzeme_aciklamasi
    self.musteri = musteri
    self.musteri_adi = musteri_adi
    self.ulke = ulke
    self.tarih = tarih
    self.fatura_tipi = fatura_tipi
    self.fatura_no = fatura_no
    self.item_no = item_no
    self.miktar = miktar
    self.miktar_br = miktar_br
    self.birim_fiyat = birim_fiyat
    self.indirimsiz_net = indirimsiz_net
    self.indirimli_net = indirimli_net
    self.kdv = kdv
    self.genel_toplam = genel_toplam
    self.para_birimi = para_birimi
    self.kur_indirimsiz = kur_indirimsiz
    self.kur_indirimli = kur_indirimli
    self.kur_vergi = kur_vergi
    self.kur_toplam = kur_toplam
  }
}
