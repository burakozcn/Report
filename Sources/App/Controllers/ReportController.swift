import Fluent
import Vapor
import PostgresKit

struct ReportController: RouteCollection {
  func boot(routes: RoutesBuilder) throws {
    let report = routes.grouped("report")
    report.get(use: index)
    report.post(use: create)
    report.group(":todoID") { report in
      report.delete(use: delete)
    }
    
    let home = routes.grouped("customer")
    home.get("home", use: getCustomerPage)
    home.get("index", use: indexPage)
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
      SELECT * from customer
  """).all(decoding: Customer.self).flatMap { custos in
      var custs = [Customer]()
      for custo in custos {
        custs.append(Customer(customer: custo.customer, name: custo.name, taxNum: custo.taxNum, paymtype: custo.paymtype, paymcond: custo.paymcond, paymtype2: custo.paymtype2, paymcond2: custo.paymcond2))
      }
      let context = CustomerPageData(title: "Customers", customers: custs)
      return req.view.render("home", context)
    }
  }
}
