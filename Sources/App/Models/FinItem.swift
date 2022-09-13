import Fluent
import Vapor

final class FinItem: Model, Content {
  static let schema = "finitem"
  
  @ID(custom: "id")
  var id: Int?
  
  @Field(key: "acctype")
  var acctype: String
  
  @Field(key: "account")
  var account: String
  
  @Field(key: "currency")
  var currency: String
  
  @Field(key: "ddebit")
  var ddebit: Float
  
  @Field(key: "dcredit")
  var dcredit: Float
  
  @Field(key: "hdebit")
  var hdebit: Float
  
  @Field(key: "hcredit")
  var hcredit: Float
  
  @Field(key: "rdebit")
  var rdebit: Float
  
  @Field(key: "rcredit")
  var rcredit: Float
  
  @Field(key: "dmatched")
  var dmatched: Float
  
  @Field(key: "dbalance")
  var dbalance: Float
  
  @Field(key: "hmatched")
  var hmatched: Float
  
  @Field(key: "hbalance")
  var hbalance: Float
  
  @Field(key: "postdate")
  var postdate: Date
  
  @Field(key: "findoctype")
  var findoctype: String
  
  @Field(key: "findocnum")
  var findocnum: String
  
  @Field(key: "findocitem")
  var findocitem: Int
  
  @Field(key: "postway")
  var postway: Int
  
  @Field(key: "hcurrency")
  var hcurrency: String
  
  @Field(key: "accname")
  var accname: String
  
  @Field(key: "glaccount")
  var glaccount: String
  
  @Field(key: "docdate")
  var docdate: Date
  
  @Field(key: "customer")
  var customer: String
  
  @Field(key: "vencusname")
  var vencusname: String
  
  @Field(key: "paymtype")
  var paymtype: String
  
  @Field(key: "paymcond")
  var paymcond: String
  
  @Field(key: "salinvtype")
  var salinvtype: String
  
  @Field(key: "salinvnum")
  var salinvnum: String
  
  @Field(key: "deltype")
  var deltype: String
  
  @Field(key: "delnum")
  var delnum: String
  
  @Field(key: "extinvtype")
  var extinvtype: String
  
  @Field(key: "extinvnum")
  var extinvnum: String
  
  init() {  }
  
  init(id: Int? = nil, acctype: String, account: String, currency: String, ddebit: Float, dcredit: Float, hdebit: Float, hcredit: Float, rdebit: Float, rcredit: Float, dmatched: Float, dbalance: Float, hmatched: Float, hbalance: Float, postdate: Date, findoctype: String, findocnum: String, findocitem: Int, postway: Int, hcurrency: String, accname: String, glaccount: String, docdate: Date, customer: String, vencusname: String, paymtype: String, paymcond: String, salinvtype: String, salinvnum: String, deltype: String, delnum: String, extinvtype: String, extinvnum: String) {
    self.id = id
    self.acctype = acctype
    self.account = account
    self.currency = currency
    self.ddebit = ddebit
    self.dcredit = dcredit
    self.hdebit = hdebit
    self.hcredit = hcredit
    self.rdebit = rdebit
    self.rcredit = rcredit
    self.dmatched = dmatched
    self.dbalance = dbalance
    self.hmatched = hmatched
    self.hbalance = hbalance
    self.postdate = postdate
    self.findoctype = findoctype
    self.findocnum = findocnum
    self.findocitem = findocitem
    self.postway = postway
    self.hcurrency = hcurrency
    self.accname = accname
    self.glaccount = glaccount
    self.docdate = docdate
    self.customer = customer
    self.vencusname = vencusname
    self.paymtype = paymtype
    self.paymcond = paymcond
    self.salinvtype = salinvtype
    self.salinvnum = salinvnum
    self.deltype = deltype
    self.delnum = delnum
    self.extinvtype = extinvtype
    self.extinvnum = extinvnum
  }
}
