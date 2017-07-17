import Foundation
import Vapor
import FluentProvider


final class Note: Model {

  var id: Node?
  let code: String
  let message: String
  // let message: Valid<Count<String>> = try "Vapor".validated(by: Count.max(3000)) // not working. undeclared type 'Valid'

  let storage = Storage()

  init(row: Row) throws {
    code = try row.get("code")
    message = try row.get("message")
  }

  init(message: String) {
    self.code = UUID().uuidString
    self.message = message
  }

  func makeRow() throws -> Row {
    var row = Row()
    try row.set("code", code)
    try row.set("message", message)
    return row
  }

}

extension Note: Preparation {
    static func prepare(_ database: Database) throws {
        try database.create(self) { builder in
            builder.id()
            builder.string("code")
            builder.string("message")
        }
    }

    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}

