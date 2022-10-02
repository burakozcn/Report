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
    
    let tableTruncate = routes.grouped("tabletruncate")
    tableTruncate.get("iascustomer", use: truncateIasCustomer)
    tableTruncate.get("iasfinhead", use: truncateIasFinHead)
    tableTruncate.get("iasfinitem", use: truncateIasFinItem)
    tableTruncate.get("finitem2", use: truncateFinItem2)
    tableTruncate.get("customer", use: truncateCustomer)
    
    let tableInsert = routes.grouped("tableinsert")
    tableInsert.get("customer", use: insertCustomer)
    tableInsert.get("finitem2", use: insertFinItem2)
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
        fins.append(FinItem2(findoctype: fin.findoctype, findocnum: fin.findocnum, docdate: fin.docdate, acctype: fin.acctype, glaccount: fin.glaccount, gltext: fin.gltext, account: fin.account, atext: fin.atext, postway: fin.postway, hpostamnt: fin.hpostamnt, dpostamnt: fin.dpostamnt, dbalance: fin.dbalance, hbalance: fin.hbalance, debitd: fin.debitd, creditd: fin.creditd, debith: fin.debith, credith: fin.credith, dprice: fin.dprice, hprice: fin.hprice, punit: fin.punit, currdate: fin.currdate, currency: fin.currency, hcurrency: fin.hcurrency, paymtype: fin.paymtype, paymcond: fin.paymcond, duedate: fin.duedate, vencusdept: fin.vencusdept))
      }
      let context = Fin2PageData(title: "Finance Items", fins: fins)
      return req.view.render("fin2", context)
    }
  }
  
  func truncateIasCustomer(_ req: Request) -> EventLoopFuture<Response> {
    return (req.db as! SQLDatabase).raw("""
      Truncate iascustomer
      """).all(decoding: Row.self).map { result in
      let response = Response(status: .ok)
      do {
        try response.content.encode(result, as: .json)
      } catch {
        print("catch match")
      }
      return response
    }
  }
  
  func truncateIasFinHead(_ req: Request) -> EventLoopFuture<Response> {
    return (req.db as! SQLDatabase).raw("""
      Truncate iasfinhead
      """).all(decoding: Row.self).map { result in
      let response = Response(status: .ok)
      do {
        try response.content.encode(result, as: .json)
      } catch {
        print("catch match")
      }
      return response
    }
  }
  
  func truncateIasFinItem(_ req: Request) -> EventLoopFuture<Response> {
    return (req.db as! SQLDatabase).raw("""
      Truncate iasfinitem
      """).all(decoding: Row.self).map { result in
      let response = Response(status: .ok)
      do {
        try response.content.encode(result, as: .json)
      } catch {
        print("catch match")
      }
      return response
    }
  }
  
  func truncateCustomer(_ req: Request) -> EventLoopFuture<Response> {
    return (req.db as! SQLDatabase).raw("""
      Truncate customer
      """).all(decoding: Row.self).map { result in
      let response = Response(status: .ok)
      do {
        try response.content.encode(result, as: .json)
      } catch {
        print("catch match")
      }
      return response
    }
  }
  
  func truncateFinItem2(_ req: Request) -> EventLoopFuture<Response> {
    return (req.db as! SQLDatabase).raw("""
      Truncate finitem2
      """).all(decoding: Row.self).map { result in
      let response = Response(status: .ok)
      do {
        try response.content.encode(result, as: .json)
      } catch {
        print("catch match")
      }
      return response
    }
  }
  
  func insertCustomer(_ req: Request) -> EventLoopFuture<Response> {
    return (req.db as! SQLDatabase).raw("""
      Insert into customer
      Select row_number() over() as id,
             customer,
             name1,
             custcond,
             city,
             country,
             sortby,
             taxdept,
             taxnum,
             iseinvomember,
             isedelmember,
             paymcond,
             paymtype,
             paymcond2,
             paymtype2
      from iascustomer
      """).all(decoding: Row.self).map { result in
      let response = Response(status: .ok)
      do {
        try response.content.encode(result, as: .json)
      } catch {
        print("catch match")
      }
      return response
    }
  }
  
  func insertFinItem2(_ req: Request) -> EventLoopFuture<Response> {
    return (req.db as! SQLDatabase).raw("""
      Insert into finitem2
      Select row_number() over() as id,
             iasfinitem.findoctype,
             iasfinitem.findocnum,
             iasfinitem.docdate,
             iasfinitem.acctype,
             iasfinitem.glaccount,
             iasfinitem.gltext,
             iasfinitem.account,
             iasfinitem.atext,
             iasfinitem.postway,
             iasfinitem.hpostamnt,
             iasfinitem.dpostamnt,
             iasfinitem.dbalance,
             iasfinitem.hbalance,
             iasfinitem.debitd,
             iasfinitem.creditd,
             iasfinitem.debith,
             iasfinitem.credith,
             iasfinitem.dprice,
             iasfinitem.hprice,
             iasfinitem.punit,
             iasfinitem.currdate,
             iasfinitem.currency,
             iasfinitem.hcurrency,
             iasfinitem.paymtype,
             iasfinitem.paymcond,
             iasfinitem.duedate,
             iasfinitem.vencusdept
      from iasfinhead, iasfinitem
      where iasfinhead.findocnum = iasfinitem.findocnum and iasfinhead.findoctype = iasfinitem.findoctype
      and iasfinitem.accstd = iasfinhead.accstd and (iasfinitem.acctype = 'T' or iasfinitem.acctype = 'M') and iasfinhead.iscancel = 0
      """).all(decoding: Row.self).map { result in
      let response = Response(status: .ok)
      do {
        try response.content.encode(result, as: .json)
      } catch {
        print("catch match")
      }
      return response
    }
  }
}
