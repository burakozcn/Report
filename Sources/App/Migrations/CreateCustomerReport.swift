import Fluent

struct CreateCustomerReport: AsyncMigration {
  func prepare(on database: Database) async throws {
    try await database.schema("customer")
      .field("id", .int, .required, .identifier(auto: true))
      .field("customer", .sql(raw: "character varying(30)"))
      .field("name", .sql(raw: "character varying(80)"))
      .field("taxNum", .sql(raw: "character varying(20)"))
      .field("paymtype", .sql(raw: "character varying(2)"))
      .field("paymcond", .sql(raw: "character varying(4)"))
      .field("paymtype2", .sql(raw: "character varying(2)"))
      .field("paymcond2", .sql(raw: "character varying(4)"))
      .create()
  }
  
  func revert(on database: Database) async throws {
    try await database.schema("customer").delete()
  }
}
