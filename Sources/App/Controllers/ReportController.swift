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
  """).all(decoding: Customer.self).flatMap { custos in
      var custs = [Customer]()
      for custo in custos {
        custs.append(Customer(customer: custo.customer, name: custo.name, taxNum: custo.taxNum, paymtype: custo.paymtype, paymcond: custo.paymcond, paymtype2: custo.paymtype2, paymcond2: custo.paymcond2))
      }
      let context = CustomerPageData(title: "Customers", customers: custs)
      return req.view.render("home", context)
    }
  }
  
  func getFinPage(req: Request) -> EventLoopFuture<View> {
    return (req.db as! SQLDatabase).raw("""
      Select * from finitem
  """).all(decoding: FinItem.self).flatMap { fins in
      var fins = [FinItem]()
      for fin in fins {
        fins.append(FinItem(acctype: fin.acctype, account: fin.account, currency: fin.currency, ddebit: fin.ddebit, dcredit: fin.dcredit, hdebit: fin.hdebit, hcredit: fin.hcredit, rdebit: fin.rdebit, rcredit: fin.rcredit, dmatched: fin.dmatched, dbalance: fin.dbalance, hmatched: fin.hmatched, hbalance: fin.hbalance, postdate: fin.postdate, findoctype: fin.findoctype, findocnum: fin.findocnum, findocitem: fin.findocitem, postway: fin.postway, hcurrency: fin.hcurrency, accname: fin.accname, glaccount: fin.glaccount, docdate: fin.docdate, customer: fin.customer, vencusname: fin.vencusname, paymtype: fin.paymtype, paymcond: fin.paymcond, salinvtype: fin.salinvtype, salinvnum: fin.salinvnum, deltype: fin.deltype, delnum: fin.delnum, extinvtype: fin.extinvtype, extinvnum: fin.extinvnum))
      }
      let context = FinPageData(title: "Finance Items", fins: [FinItem]())
      return req.view.render("fin", context)
    }
  }
}
