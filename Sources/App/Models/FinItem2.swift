import Fluent
import Vapor

final class FinItem2: Model, Content {
  static let schema = "finitem2"
  
  @ID(custom: "id")
  var id: Int?
  
  @Field(key: "findoctype")
  var findoctype: String
  
  @Field(key: "findocnum")
  var findocnum: String
  
  @Field(key: "docdate")
  var docdate: String
  
  @Field(key: "acctype")
  var acctype: String
  
  @Field(key: "glaccount")
  var glaccount: String
  
  @Field(key: "gltext")
  var gltext: String
  
  @Field(key: "account")
  var account: String
  
  @Field(key: "atext")
  var atext: String
  
  @Field(key: "postway")
  var postway: Int
  
  @Field(key: "hpostamnt")
  var hpostamnt: Double
  
  @Field(key: "dpostamnt")
  var dpostamnt: Double
  
  @Field(key: "dbalance")
  var dbalance: Double
  
  @Field(key: "hbalance")
  var hbalance: Double
  
  @Field(key: "debitd")
  var debitd: Double
  
  @Field(key: "creditd")
  var creditd: Double
  
  @Field(key: "debith")
  var debith: Double
  
  @Field(key: "credith")
  var credith: Double
  
  @Field(key: "dprice")
  var dprice: Double
  
  @Field(key: "hprice")
  var hprice: Double
  
  @Field(key: "currdate")
  var currdate: String
  
  @Field(key: "currency")
  var currency: String
  
  @Field(key: "hcurrency")
  var hcurrency: String
  
  @Field(key: "paymtype")
  var paymtype: String

  @Field(key: "paymcond")
  var paymcond: String
  
  @Field(key: "duedate")
  var duedate: String
  
  @Field(key: "vencusdept")
  var vencusdept: String
  
  init() {  }
  
  init(id: Int? = nil, findoctype: String, findocnum: String, docdate: String, acctype: String, glaccount: String, gltext: String, account: String, atext: String, postway: Int, hpostamnt: Double, dpostamnt: Double, dbalance: Double, hbalance: Double, debitd: Double, creditd: Double, debith: Double, credith: Double, dprice: Double, hprice: Double, currdate: String, currency: String, hcurrency: String, paymtype: String, paymcond: String, duedate: String, vencusdept: String) {
    self.id = id
    self.findoctype = findoctype
    self.findocnum = findocnum
    self.docdate = docdate
    self.acctype = acctype
    self.glaccount = glaccount
    self.gltext = gltext
    self.account = account
    self.atext = atext
    self.postway = postway
    self.hpostamnt = hpostamnt
    self.dpostamnt = dpostamnt
    self.dbalance = dbalance
    self.hbalance = hbalance
    self.debitd = debitd
    self.creditd = creditd
    self.debith = debith
    self.credith = credith
    self.dprice = dprice
    self.hprice = hprice
    self.currdate = currdate
    self.currency = currency
    self.hcurrency = hcurrency
    self.paymtype = paymtype
    self.paymcond = paymcond
    self.duedate = duedate
    self.vencusdept = vencusdept
  }
}
