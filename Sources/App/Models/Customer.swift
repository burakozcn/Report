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
  
  @Field(key: "custcond")
  var custcond: String
  
  @Field(key: "city")
  var city: String
  
  @Field(key: "country")
  var country: String
  
  @Field(key: "sortby")
  var sortby: String
  
  @Field(key: "taxdept")
  var taxdept: String
  
  @Field(key: "taxNum")
  var taxNum: String
  
  @Field(key: "iseinvomember")
  var iseinvomember: Int
  
  @Field(key: "isedelmember")
  var isedelmember: Int
  
  @Field(key: "paymtype")
  var paymtype: String
  
  @Field(key: "paymcond")
  var paymcond: String
  
  @Field(key: "paymtype2")
  var paymtype2: String
  
  @Field(key: "paymcond2")
  var paymcond2: String
  
  init() { }
  
  init(id: Int? = nil, customer: String, name: String, custcond: String, city: String, country: String, sortby: String, taxdept: String, taxNum: String, iseinvomember: Int, isedelmember: Int, paymtype: String, paymcond: String, paymtype2: String, paymcond2: String) {
    self.id = id
    self.customer = customer
    self.name = name
    self.custcond = custcond
    self.city = city
    self.country = country
    self.sortby = sortby
    self.taxdept = taxdept
    self.taxNum = taxNum
    self.iseinvomember = iseinvomember
    self.isedelmember = isedelmember
    self.paymtype = paymtype
    self.paymcond = paymcond
    self.paymtype2 = paymtype2
    self.paymcond2 = paymcond2
  }
}
