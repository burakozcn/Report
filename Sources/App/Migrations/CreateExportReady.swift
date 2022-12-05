import Fluent

struct CreateExportReady: AsyncMigration {
  func prepare(on database: Database) async throws {
    try await database.schema("exportready")
      .field("id", .int, .required, .identifier(auto: true))
      .field("custordertype", .sql(raw: "character varying(4)"))
      .field("custordernum", .sql(raw: "character varying(30)"))
      .field("name1", .sql(raw: "character varying(80)"))
      .field("createdat", .sql(raw: "timestamp"))
      .field("material", .sql(raw: "character varying(40)"))
      .field("mtext", .sql(raw: "character varying(80)"))
      .field("skquantity", .sql(raw: "numeric(21,8)"))
      .field("skunit", .sql(raw: "character varying(3)"))
      .field("quantity", .sql(raw: "numeric(21,8)"))
      .field("qunitx", .sql(raw: "character varying(3)"))
      .field("voptions", .sql(raw: "character varying(255)"))
      .create()
  }
  
  func revert(on database: Database) async throws {
    try await database.schema("exportready").delete()
  }
}
