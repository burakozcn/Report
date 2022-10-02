import Vapor
import Fluent

struct CustomerPageData: Encodable {
  let title: String
  let customers: [Customer]
}

struct PageData: Encodable {
  let title: String
}

struct FinPageData: Encodable {
  let title: String
  let fins: [FinItem]
}

struct Fin2PageData: Encodable {
  let title: String
  let fins: [FinItem2]
}

final class Row: Model, Content {
  static let schema = "todos"
  
  @ID(key: .id)
  var id: UUID?
  
  @Field(key: "title")
  var title: String
  
  init() { }
  
  init(id: UUID? = nil, title: String) {
    self.id = id
    self.title = title
  }
}
