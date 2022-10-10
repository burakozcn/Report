import Fluent

struct CreateSalt70: AsyncMigration {
  func prepare(on database: Database) async throws {
    try await database.schema("salt70")
      .field("id", .int, .required, .identifier(auto: true))
      .field("malzeme", .sql(raw: "character varying(40)"))
      .field("malzeme_aciklamasi", .sql(raw: "character varying(80)"))
      .field("musteri", .sql(raw: "character varying(30)"))
      .field("musteri_adi", .sql(raw: "character varying(80)"))
      .field("tarih", .sql(raw: "date"))
      .field("fatura_tipi", .sql(raw: "character varying(4)"))
      .field("fatura_no", .sql(raw: "character varying(30)"))
      .field("item_no", .int)
      .field("miktar", .sql(raw: "numeric(21,8)"))
      .field("miktar_br", .sql(raw: "character varying(3)"))
      .field("birim_fiyat", .sql(raw: "numeric(21,2)"))
      .field("indirimsiz_net", .sql(raw: "numeric(21,2)"))
      .field("indirimli_net", .sql(raw: "numeric(21,2)"))
      .field("kdv", .sql(raw: "numeric(21,2)"))
      .field("genel_toplam", .sql(raw: "numeric(21,2)"))
      .field("para_birimi", .sql(raw: "character varying(3)"))
      .field("kur_indirimsiz", .sql(raw: "numeric"))
      .field("kur_indirimli", .sql(raw: "numeric"))
      .field("kur_vergi", .sql(raw: "numeric"))
      .field("kur_toplam", .sql(raw: "numeric"))
      .create()
  }
  
  func revert(on database: Database) async throws {
    try await database.schema("salt70").delete()
  }
}
