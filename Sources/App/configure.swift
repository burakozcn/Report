import Fluent
import FluentPostgresDriver
import Leaf
import Vapor

// configures your application
public func configure(_ app: Application) throws {
  // uncomment to serve files from /Public folder
  app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
  
  app.http.server.configuration.port = 8085
  
  app.databases.use(.postgres(
    hostname: Environment.get("localhost") ?? "localhost",
    port: Environment.get("5432").flatMap(Int.init(_:)) ?? PostgresConfiguration.ianaPortNumber,
    username: Environment.get("postgres") ?? "postgres",
    password: Environment.get("burak") ?? "burak",
    database: Environment.get("ziligenreport") ?? "ziligenreport"
  ), as: .psql)
  
  app.migrations.add(CreateCustomerReport())
  app.migrations.add(CreateFinItem())
  app.migrations.add(CreateFinFullItem())
  
  app.views.use(.leaf)
  try app.autoMigrate().wait()
  // register routes
  try routes(app)
}
