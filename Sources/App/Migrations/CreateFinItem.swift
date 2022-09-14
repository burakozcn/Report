import Fluent

struct CreateFinItem: AsyncMigration {
  func prepare(on database: Database) async throws {
    try await database.schema("finitem")
      .field("id", .int, .required, .identifier(auto: true))
      .field("acctype", .sql(raw: "character varying(1)"))
      .field("account", .sql(raw: "character varying(30)"))
      .field("currency", .sql(raw: "character varying(3)"))
      .field("ddebit", .double)
      .field("dcredit", .double)
      .field("hdebit", .double)
      .field("hcredit", .double)
      .field("rdebit", .double)
      .field("rcredit", .double)
      .field("dmatched", .double)
      .field("dbalance", .double)
      .field("hmatched", .double)
      .field("hbalance", .double)
      .field("postdate", .sql(raw: "date"))
      .field("findoctype", .sql(raw: "character varying(4)"))
      .field("findocnum", .sql(raw: "character varying(30)"))
      .field("findocitem", .sql(raw: "integer"))
      .field("postway", .sql(raw: "integer"))
      .field("hcurrency", .sql(raw: "character varying(3)"))
      .field("accname", .sql(raw: "character varying(100)"))
      .field("glaccount", .sql(raw: "character varying(30)"))
      .field("docdate", .sql(raw: "date"))
      .field("customer", .sql(raw: "character varying(30)"))
      .field("vencusname", .sql(raw: "character varying(100)"))
      .field("paymtype", .sql(raw: "character varying(2)"))
      .field("paymcond", .sql(raw: "character varying(4)"))
      .field("salinvtype", .sql(raw: "character varying(4)"))
      .field("salinvnum", .sql(raw: "character varying(30)"))
      .field("deltype", .sql(raw: "character varying(4)"))
      .field("delnum", .sql(raw: "character varying(30)"))
      .field("extinvtype", .sql(raw: "character varying(4)"))
      .field("extinvnum", .sql(raw: "character varying(80)"))
      .create()
  }
  
  func revert(on database: Database) async throws {
    try await database.schema("finitem").delete()
  }
}
