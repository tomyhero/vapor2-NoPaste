import Vapor
import HTTP

final class NotesController {

  func addRoutes(drop: Droplet) {
    drop.get(handler: index)
    drop.post(handler: create)
    drop.get(String.parameter, handler: show)
  }

  func index(request: Request) throws -> ResponseRepresentable {

    return try drop.view.make("index.leaf")
  }

  func show(req: Request ) throws -> ResponseRepresentable {
    let code = try req.parameters.next(String.self)


    let note = try Note.makeQuery().filter("code",code).first()

    // should have more better way to do this?
    let n = try Node(node: [ "code": note!.code, "message": note!.message ])

    return try drop.view.make("show.leaf", [ "note": n ] )
  }

  func create(request: Request) throws -> ResponseRepresentable {
    drop.log.info("create action called")

    guard let message = request.data["message"]?.string else { 
      throw Abort(.badRequest)
    }

    let note = Note(message: message)
    try note.save();

    return Response(redirect: "/" + note.code)

  }
}

