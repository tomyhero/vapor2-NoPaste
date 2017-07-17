import Vapor
import LeafProvider
import FluentProvider

// import ValidationProvider
// XXX having same kind of error. give up for now.
// https://stackoverflow.com/questions/44762706/vapor-2-validation-valid-type-throws-use-of-undeclared-type-valid 
// XXX and document may be outdated
// https://docs.vapor.codes/2.0/validation/overview/ ( This section may contain outdated information. )

let config = try Config()
Node.fuzzy = [Row.self, JSON.self, Node.self]

// require when you want to use Leaf as view engine. SEE ALSO Config/droplet.json
try config.addProvider(LeafProvider.Provider.self)


try config.addProvider(FluentProvider.Provider.self)

try config.preparations.append(Note.self)

let drop = try Droplet(config)

// try drop.preprations.append(Note.self)


let notesController = NotesController()
notesController.addRoutes(drop: drop)

try drop.run()
