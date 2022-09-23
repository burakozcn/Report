import Fluent
import Vapor
import PostgresKit

struct ReportController: RouteCollection {
  func boot(routes: RoutesBuilder) throws {
    let report = routes.grouped("reports")
    report.get(use: index)
    report.post(use: create)
    report.group(":todoID") { report in
      report.delete(use: delete)
    }
    
    let home = report.grouped("customer")
    home.get("home", use: getCustomerPage)
    home.get("index", use: indexPage)
    
    let fin = report.grouped("fin")
    fin.get("home", use: getFinPage)
    
    let fin2 = report.grouped("fin2")
    fin2.get("home", use: getFin2Page)
    
    let finfull = report.grouped("finfull")
    finfull.get("home", use: getFinFullPage)
  }
  
  func index(req: Request) async throws -> [Customer] {
    try await Customer.query(on: req.db).all()
  }
  
  func create(req: Request) async throws -> Customer {
    let todo = try req.content.decode(Customer.self)
    try await todo.save(on: req.db)
    return todo
  }
  
  func delete(req: Request) async throws -> HTTPStatus {
    guard let todo = try await Customer.find(req.parameters.get("todoID"), on: req.db) else {
      throw Abort(.notFound)
    }
    try await todo.delete(on: req.db)
    return .noContent
  }
  
  func indexPage(req: Request) -> EventLoopFuture<View> {
    let context = PageData(title: "Customers")
    return req.view.render("index", context)
  }
  
  func getCustomerPage(req: Request) -> EventLoopFuture<View> {
    return (req.db as! SQLDatabase).raw("""
      Select * from customer
      order by customer
  """).all(decoding: Customer.self).flatMap { custos in
      var custs = [Customer]()
      for custo in custos {
        custs.append(Customer(customer: custo.customer, name: custo.name, custcond: custo.custcond, city: custo.city, country: custo.country, sortby: custo.sortby, taxdept: custo.taxdept, taxNum: custo.taxNum, iseinvomember: custo.iseinvomember, isedelmember: custo.isedelmember, paymtype: custo.paymtype, paymcond: custo.paymcond, paymtype2: custo.paymtype2, paymcond2: custo.paymcond2))
      }
      let context = CustomerPageData(title: "Customers", customers: custs)
      return req.view.render("home", context)
    }
  }
  
  func getFinPage(req: Request) -> EventLoopFuture<View> {
    return (req.db as! SQLDatabase).raw("""
      Select * from finitem
  """).all(decoding: FinItem.self).flatMap { finances in
      var fins = [FinItem]()
      for fin in finances {
        fins.append(FinItem(acctype: fin.acctype, account: fin.account, currency: fin.currency, ddebit: fin.ddebit, dcredit: fin.dcredit, hdebit: fin.hdebit, hcredit: fin.hcredit, rdebit: fin.rdebit, rcredit: fin.rcredit, dmatched: fin.dmatched, dbalance: fin.dbalance, hmatched: fin.hmatched, hbalance: fin.hbalance, postdate: fin.postdate, findoctype: fin.findoctype, findocnum: fin.findocnum, findocitem: fin.findocitem, postway: fin.postway, hcurrency: fin.hcurrency, accname: fin.accname, glaccount: fin.glaccount, docdate: fin.docdate, customer: fin.customer, vencusname: fin.vencusname, paymtype: fin.paymtype, paymcond: fin.paymcond, salinvtype: fin.salinvtype, salinvnum: fin.salinvnum, deltype: fin.deltype, delnum: fin.delnum, extinvtype: fin.extinvtype, extinvnum: fin.extinvnum))
      }
      let context = FinPageData(title: "Finance Items", fins: fins)
      return req.view.render("finfull", context)
    }
  }
  
  func getFinFullPage(req: Request) -> EventLoopFuture<View> {
    return (req.db as! SQLDatabase).raw("""
      Select * from finfullitem
      LIMIT 5000
  """).all(decoding: FinItem.self).flatMap { finances in
      var fins = [FinItem]()
      for fin in finances {
        fins.append(FinItem(acctype: fin.acctype, account: fin.account, currency: fin.currency, ddebit: fin.ddebit, dcredit: fin.dcredit, hdebit: fin.hdebit, hcredit: fin.hcredit, rdebit: fin.rdebit, rcredit: fin.rcredit, dmatched: fin.dmatched, dbalance: fin.dbalance, hmatched: fin.hmatched, hbalance: fin.hbalance, postdate: fin.postdate, findoctype: fin.findoctype, findocnum: fin.findocnum, findocitem: fin.findocitem, postway: fin.postway, hcurrency: fin.hcurrency, accname: fin.accname, glaccount: fin.glaccount, docdate: fin.docdate, customer: fin.customer, vencusname: fin.vencusname, paymtype: fin.paymtype, paymcond: fin.paymcond, salinvtype: fin.salinvtype, salinvnum: fin.salinvnum, deltype: fin.deltype, delnum: fin.delnum, extinvtype: fin.extinvtype, extinvnum: fin.extinvnum))
      }
      let context = FinPageData(title: "Finance Items Full", fins: fins)
      return req.view.render("finfull", context)
    }
  }
  
  func getFin2Page(req: Request) -> EventLoopFuture<View> {
    return (req.db as! SQLDatabase).raw("""
      Select * from finitem2
      order by docdate
  """).all(decoding: FinItem2.self).flatMap { finances in
      var fins = [FinItem2]()
      for fin in finances {
        fins.append(FinItem2(findoctype: fin.findoctype, findocnum: fin.findocnum, docdate: fin.docdate, acctype: fin.acctype, glaccount: fin.glaccount, gltext: fin.gltext, account: fin.account, atext: fin.atext, postway: fin.postway, hpostamnt: fin.hpostamnt, dpostamnt: fin.dpostamnt, dbalance: fin.dbalance, hbalance: fin.hbalance, debitd: fin.debitd, creditd: fin.creditd, debith: fin.debith, credith: fin.credith, dprice: fin.dprice, hprice: fin.hprice, paymtype: fin.paymtype, paymcond: fin.paymcond, duedate: fin.duedate, vencusdept: fin.vencusdept))
      }
      let context = Fin2PageData(title: "Finance Items", fins: fins)
      return req.view.render("fin2", context)
    }
  }
}
