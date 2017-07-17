// https://swift.org/package-manager/#example-usage
// https://medium.com/developermind/migrating-from-vapor-1-to-vapor-2-f81012ddc22c

import PackageDescription

let package = Package(
 name: "NoPaste",
 targets: [
   Target(name: "App"),
   // Target(name: "Run", dependencies: ["App"]),
 ],
 dependencies: [
   .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 2),
   .Package(url: "https://github.com/vapor/fluent-provider.git", majorVersion: 1),
   .Package(url: "https://github.com/vapor/leaf-provider.git", majorVersion: 1),
 //   .Package(url: "https://github.com/vapor/validation-provider", majorVersion: 1), // won't work..
 ],
 exclude: [
   "Config",
   "Database",
   "Localization",
   "Public",
   "Resources",
 ]
 )
