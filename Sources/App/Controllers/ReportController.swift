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
    
    let salt70 = report.grouped("salt70")
    salt70.get("home", use: getSalt70)
    
    let export = report.grouped("export")
    export.get("home", use: getExportReady)
    
    let tableTruncate = routes.grouped("tabletruncate")
    tableTruncate.get("iascustomer", use: truncateIasCustomer)
    tableTruncate.get("iasfinhead", use: truncateIasFinHead)
    tableTruncate.get("iasfinitem", use: truncateIasFinItem)
    tableTruncate.get("finitem2", use: truncateFinItem2)
    tableTruncate.get("customer", use: truncateCustomer)
    tableTruncate.get("iassalhead", use: truncateIasSalHead)
    tableTruncate.get("iassalitem", use: truncateIasSalItem)
    tableTruncate.get("salt70", use: truncateSalt70)
    tableTruncate.get("iasbas012", use: truncateIasBas012)
    tableTruncate.get("exportready", use: truncateExportReady)
    tableTruncate.get("iasbas005x", use: truncateIasBas005x)
    tableTruncate.get("iasbas039x", use: truncateIasBas039x)
    tableTruncate.get("iasprdorder", use: truncateIasPrdOrder)
    tableTruncate.get("iasinvitem", use: truncateIasPrdOrder)
    tableTruncate.get("iasinvhead", use: truncateIasInvHead)
    
    let tableCreate = routes.grouped("tablecreate")
    tableCreate.get("opensales", use: createOpenSales)
    tableCreate.get("tempfinishedorders", use: createTempFinishedOrd)
    
    let tableDrop = routes.grouped("tabledrop")
    tableDrop.get("aopensales", use: dropAOpenSales)
    tableDrop.get("tempfinishedorders", use: dropTempFinishedOrders)
    
    let tableInsert = routes.grouped("tableinsert")
    tableInsert.get("customer", use: insertCustomer)
    tableInsert.get("finitem2", use: insertFinItem2)
    tableInsert.get("salt70", use: insertSalt70)
    tableInsert.get("exportready", use: insertExportReady)
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
  
  func getSalt70(req: Request) -> EventLoopFuture<View> {
    return (req.db as! SQLDatabase).raw("""
      Select * from salt70
      order by tarih
  """).all(decoding: Salt70.self).flatMap { sales in
      var sals = [Salt70]()
      for sale in sales {
        sals.append(Salt70(malzeme: sale.malzeme, malzeme_aciklamasi: sale.malzeme_aciklamasi, musteri: sale.musteri, musteri_adi: sale.musteri_adi, tarih: sale.tarih, fatura_tipi: sale.fatura_tipi, fatura_no: sale.fatura_no, item_no: sale.item_no, miktar: sale.miktar, miktar_br: sale.miktar_br, birim_fiyat: sale.birim_fiyat, indirimsiz_net: sale.indirimsiz_net, indirimli_net: sale.indirimli_net, kdv: sale.kdv, genel_toplam: sale.genel_toplam, para_birimi: sale.para_birimi, kur_indirimsiz: sale.kur_indirimsiz.rounded(toPlaces: 2), kur_indirimli: sale.kur_indirimli.rounded(toPlaces: 2), kur_vergi: sale.kur_vergi.rounded(toPlaces: 2), kur_toplam: sale.kur_toplam.rounded(toPlaces: 2)))
      }
      let context = Salt70PageData(title: "SALT70", sales: sals)
      return req.view.render("salt70", context)
    }
  }
  
  func getExportReady(req: Request) -> EventLoopFuture<View> {
    return (req.db as! SQLDatabase).raw("""
      Select * from exportready
  """).all(decoding: ExportReady.self).flatMap { exprs in
      var exps = [ExportReady]()
      for expr in exprs {
        exps.append(ExportReady(custordertype: expr.custordertype, custordernum: expr.custordernum, name1: expr.name1, createdat: expr.createdat, material: expr.material, mtext: expr.mtext, skquantity: expr.skquantity, skunit: expr.skunit, quantity: expr.quantity, qunitx: expr.qunitx, voptions: expr.voptions))
      }
      let context = ExportReadyPageData(title: "Ready", exps: exps)
      return req.view.render("exportready", context)
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
  
  func truncateIasSalHead(_ req: Request) -> EventLoopFuture<Response> {
    return (req.db as! SQLDatabase).raw("""
      Truncate iassalhead
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
  
  func truncateIasSalItem(_ req: Request) -> EventLoopFuture<Response> {
    return (req.db as! SQLDatabase).raw("""
      Truncate iassalitem
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
  
  func truncateIasBas012(_ req: Request) -> EventLoopFuture<Response> {
    return (req.db as! SQLDatabase).raw("""
      Truncate iasbas012
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
  
  func truncateIasInvHead(_ req: Request) -> EventLoopFuture<Response> {
    return (req.db as! SQLDatabase).raw("""
      Truncate iasinvhead
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
  
  func truncateIasInvItem(_ req: Request) -> EventLoopFuture<Response> {
    return (req.db as! SQLDatabase).raw("""
      Truncate iasinvitem
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
  
  func truncateIasPrdOrder(_ req: Request) -> EventLoopFuture<Response> {
    return (req.db as! SQLDatabase).raw("""
      Truncate iasprdorder
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
  
  func truncateIasBas039x(_ req: Request) -> EventLoopFuture<Response> {
    return (req.db as! SQLDatabase).raw("""
      Truncate iasbas039x
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
  
  func truncateIasBas005x(_ req: Request) -> EventLoopFuture<Response> {
    return (req.db as! SQLDatabase).raw("""
      Truncate iasbas005x
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
  
  func truncateSalt70(_ req: Request) -> EventLoopFuture<Response> {
    return (req.db as! SQLDatabase).raw("""
      Truncate salt70
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
  
  func truncateExportReady(_ req: Request) -> EventLoopFuture<Response> {
    return (req.db as! SQLDatabase).raw("""
    Truncate exportReady
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
  
  func dropAOpenSales(_ req: Request) -> EventLoopFuture<Response> {
    return (req.db as! SQLDatabase).raw("""
    Drop aopensales
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
  
  func dropTempFinishedOrders(_ req: Request) -> EventLoopFuture<Response> {
    return (req.db as! SQLDatabase).raw("""
    Drop tempfinishedorders
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
  
  func insertSalt70(_ req: Request) -> EventLoopFuture<Response> {
    return (req.db as! SQLDatabase).raw("""
      Insert into salt70
      Select row_number() over() as id,
             t1.material as Malzeme,
             t1.mtext as Malzeme_Aciklamasi,
             t2.customer as Musteri,
             t2.name1 as Musteri_Adi,
             t1.validfrom as Tarih,
             t2.doctype as Fatura_Tipi,
             t2.docnum as Fatura_No,
             t1.itemnum as Item_No,
             t1.invoicedqty as Miktar,
             t1.qunit as Miktar_Br,
             t1.sprice as Birim_Fiyat,
             t1.gross as Indirimsiz_Net,
             t1.subtotal as Indirimli_Net,
             t1.vatamnt as Kdv,
             t1.grandtotal as Genel_Toplam,
             t2.currency as Para_Birimi,
             (t1.gross * t2.exchrate) / t3.effexchratepur as Kur_Indirimsiz,
             (t1.subtotal * t2.exchrate) / t3.effexchratepur as Kur_Indirimli,
             (t1.vatamnt * t2.exchrate) / t3.effexchratepur as Kur_Vergi,
             (t1.grandtotal * t2.exchrate) / t3.effexchratepur as Kur_Toplam
      from iassalitem t1
      left join iassalhead t2 on t1.doctype = t2.doctype and t1.docnum = t2.docnum
      left join iasbas012 t3 on t1.validfrom = t3.curdate
      where t2.isdelete = 0
      and (t1.itemtype = 'L' or t1.itemtype = 'C' or t1.itemtype = 'H' or t1.itemtype = 'P')
      and t2.doctype like 'F%'
      and ((t3.createdby = 'IASOTODOVIZ' and t3.curdate between '2022-04-01' and '2022-05-25' and t3.currency = 'EUR' and t3.company = '01')
      or (t3.createdby = 'KUR' and t3.curdate > '2022-05-25' and t3.currency = 'EUR' and t3.company = '01')
      or (t3.createdby = 'EVARDAR' and t3.curdate between '2022-06-01' and '2022-06-30' and t3.currency = 'EUR' and t3.company = '01'))
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
  
  func createOpenSales(_ req: Request) -> EventLoopFuture<Response> {
    return (req.db as! SQLDatabase).raw("""
      Create table aopensales as
      Select * from iassalhead
      where doctype = 'YDS'
      and ordstat != 2
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
  
  func createTempFinishedOrd(_ req: Request) -> EventLoopFuture<Response> {
    return (req.db as! SQLDatabase).raw("""
      Create table tempfinishedorders as
      Select * from iasprdorder
      where iasprdorder.potype = '80' and ((iasprdorder.status1 = 1) or (2 = 1)) and iasprdorder.isdelete = 0
      and iasprdorder.opendate <= '2100-01-01 00:00:00'
      and iasprdorder.custordertype = 'YDS'
      and iasprdorder.custordernum in (Select docnum from aopensales)
      and exists (Select client from iasprd001 where client = '00' and company = iasprdorder.company
                  and plant = iasprdorder.plant and potype = iasprdorder.potype and isproject <> 1 and ismaintenance <> 1
                  and isserviceorder <> 1)
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
  
  func insertExportReady(_ req: Request) -> EventLoopFuture<Response> {
    return (req.db as! SQLDatabase).raw("""
      Insert into exportready
      Select row_number() over() as id, iasinvitem.custordertype, iasinvitem.custordernum, iassalhead.name1, iasinvitem.createdat, iasinvitem.material,
      iasinvitem.mtext, iasinvitem.skquantity, iasinvitem.skunit, iasinvitem.quantityx * count(iasinvitem.batchnum) as quantity2, iasinvitem.qunitx,
      iasinvitem.voptions
      from iasinvhead, iasinvitem
      left outer join iasbas039x on (iasbas039x.client = iasinvitem.client and iasbas039x.company = iasinvitem.company
                                    and iasbas039x.plant = iasinvitem.plant and iasbas039x.warehouse = iasinvitem.warehouse
                                    and iasbas039x.langu = 'T')
      left outer join iasbas005x on (iasbas005x.client = iasinvitem.client and iasbas005x.company = iasinvitem.company
                                     and iasbas005x.plant = iasinvitem.plant and iasbas005x.langu = 'T')
      left join iassalhead on (iassalhead.doctype = iasinvitem.custordertype and iassalhead.docnum = iasinvitem.custordernum)
      inner join iassalitem on (iassalitem.doctype = iasinvitem.custordertype and iassalitem.docnum = iasinvitem.custordernum
                                and iassalitem.material = iasinvitem.material)
      where iasinvitem.company = iasinvhead.company and iasinvitem.invdoctype = iasinvitem.invdoctype
      and iasinvitem.invdocnum = iasinvhead.invdocnum and iasinvhead.docdate <= '2100-01-01' and iasinvitem.warehouse = '700'
      and iasinvitem.qpostway >= 0 and iasinvitem.qpostway <= 1 and iasinvitem.iscanceled = 0
      and iasinvhead.sourcedoctype = '80' and iasinvhead.sourcedocnum in (Select prdorder from tempfinishedorders) and iasinvhead.sourcetype >= 3
      and iasinvhead.sourcetype <= 3 and iasinvitem.custordertype = 'YDS'
      and iassalitem.ordstat != '2'
      group by iasinvitem.custordertype, iasinvitem.custordernum, iasinvitem.material, iasinvitem.mtext, iasinvitem.voptions,
      iassalhead.name1, iasinvitem.createdat, iasinvitem.skquantity, iasinvitem.skunit, iasinvitem.quantityx, iasinvitem.quantityx, iasinvitem.qunitx
      order by iassalhead.name1, iasinvitem.custordertype, iasinvitem.custordernum;
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
