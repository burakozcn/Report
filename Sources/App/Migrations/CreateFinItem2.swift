import Fluent

struct CreateFinItem2: AsyncMigration {
  func prepare(on database: Database) async throws {
    try await database.schema("finitem2")
      .field("id", .int, .required, .identifier(auto: true))
      .field("findoctype", .sql(raw: "character varying(4)"))
      .field("findocnum", .sql(raw: "character varying(30)"))
      .field("docdate", .sql(raw: "date"))
      .field("acctype", .sql(raw: "character varying(1)"))
      .field("glaccount", .sql(raw: "character varying(30)"))
      .field("gltext", .sql(raw: "character varying(100)"))
      .field("account", .sql(raw: "character varying(30)"))
      .field("atext", .sql(raw: "character varying(100)"))
      .field("postway", .int)
      .field("hpostamnt", .sql(raw: "numeric(21,2)"))
      .field("dpostamnt", .sql(raw: "numeric(21,2)"))
      .field("dbalance", .sql(raw: "numeric(21,2)"))
      .field("hbalance", .sql(raw: "numeric(21,2)"))
      .field("debitd", .sql(raw: "numeric(21,2)"))
      .field("creditd", .sql(raw: "numeric(21,2)"))
      .field("debith", .sql(raw: "numeric(21,2)"))
      .field("credith", .sql(raw: "numeric(21,2)"))
      .field("dprice", .sql(raw: "numeric(21,2)"))
      .field("hprice", .sql(raw: "numeric(21,2)"))
      .field("currdate", .sql(raw: "date"))
      .field("currency", .sql(raw: "character varying(3)"))
      .field("hcurrency", .sql(raw: "character varying(3)"))
      .field("paymtype", .sql(raw: "character varying(4)"))
      .field("paymcond", .sql(raw: "character varying(4)"))
      .field("duedate", .sql(raw: "date"))
      .field("vencusdept", .sql(raw: "character varying(30)"))
      .create()
  }
  
  func revert(on database: Database) async throws {
    try await database.schema("finitem2").delete()
  }
}
