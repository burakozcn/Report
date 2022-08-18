import Fluent
import Vapor

final class Customer: Model, Content {
  static let schema = "customer"
  
  @ID(custom: "id")
  var id: Int?
  
  @Field(key: "customer")
  var customer: String
  
  @Field(key: "name")
  var name: String
  
  @Field(key: "taxNum")
  var taxNum: String
  
  @Field(key: "paymtype")
  var paymtype: String
  
  @Field(key: "paymcond")
  var paymcond: String
  
  @Field(key: "paymtype2")
  var paymtype2: String
  
  @Field(key: "paymcond2")
  var paymcond2: String
  
  init() { }
  
  init(id: Int? = nil, customer: String, name: String, taxNum: String, paymtype: String, paymcond: String, paymtype2: String, paymcond2: String) {
    self.id = id
    self.customer = customer
    self.name = name
    self.taxNum = taxNum
    self.paymtype = paymtype
    self.paymcond = paymcond
    self.paymtype2 = paymtype2
    self.paymcond2 = paymcond2
  }
}
