import Fluent
import Vapor

final class ExportReady: Model, Content {
  static let schema = "customer"
  
  @ID(custom: "id")
  var id: Int?
  
  @Field(key: "custordertype")
  var custordertype: String
  
  @Field(key: "custordernum")
  var custordernum: String
  
  @Field(key: "name1")
  var name1: String
  
  @Field(key: "createdat")
  var createdat: String
  
  @Field(key: "material")
  var material: String
  
  @Field(key: "mtext")
  var mtext: String
  
  @Field(key: "skquantity")
  var skquantity: Double
  
  @Field(key: "skunit")
  var skunit: String
  
  @Field(key: "quantity")
  var quantity: Double
  
  @Field(key: "qunitx")
  var qunitx: String
  
  @Field(key: "voptions")
  var voptions: String
  
  init() { }
  
  init(id: Int? = nil, custordertype: String, custordernum: String, name1: String, createdat: String, material: String, mtext: String, skquantity: Double, skunit: String, quantity: Double, qunitx: String, voptions: String) {
    self.id = id
    self.custordertype = custordertype
    self.custordernum = custordernum
    self.name1 = name1
    self.createdat = createdat
    self.material = material
    self.mtext = mtext
    self.skquantity = skquantity
    self.skunit = skunit
    self.quantity = quantity
    self.qunitx = qunitx
    self.voptions = voptions
  }
}
