import Fluent

struct CreateFinItem: AsyncMigration {
  func prepare(on database: Database) async throws {
    try await database.schema("finitem")
      .field("id", .int, .required, .identifier(auto: true))
      .field("acctype", .sql(raw: "character varying(1)"))
      .field("account", .sql(raw: "character varying(30)"))
      .field("currency", .sql(raw: "character varying(3)"))
      .field("ddebit", .sql(raw: "numeric"))
      .field("dcredit", .sql(raw: "numeric"))
      .field("hdebit", .sql(raw: "numeric"))
      .field("hcredit", .sql(raw: "numeric"))
      .field("rdebit", .sql(raw: "numeric"))
      .field("rcredit", .sql(raw: "numeric"))
      .field("dmatched", .sql(raw: "numeric(21,2)"))
      .field("dbalance", .sql(raw: "numeric"))
      .field("hmatched", .sql(raw: "numeric(21,2)"))
      .field("hbalance", .sql(raw: "numeric"))
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
