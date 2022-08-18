import Vapor

struct CustomerPageData: Encodable {
  let title: String
  let customers: [Customer]
}

struct PageData: Encodable {
  let title: String
}
