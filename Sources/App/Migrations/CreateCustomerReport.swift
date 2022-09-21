import Fluent

struct CreateCustomerReport: AsyncMigration {
  func prepare(on database: Database) async throws {
    try await database.schema("customer")
      .field("id", .int, .required, .identifier(auto: true))
      .field("customer", .sql(raw: "character varying(30)"))
      .field("name", .sql(raw: "character varying(80)"))
      .field("custcond", .sql(raw: "character varying(2)"))
      .field("city", .sql(raw: "character varying(40)"))
      .field("country", .sql(raw: "character varying(3)"))
      .field("sortby", .sql(raw: "character varying(10)"))
      .field("taxdept", .sql(raw: "character varying(25)"))
      .field("taxNum", .sql(raw: "character varying(20)"))
      .field("iseinvomember", .int)
      .field("isedelmember", .int)
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
