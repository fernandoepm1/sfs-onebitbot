configure :test do
  set :database, {
    adapter: 'postgresql',
    encoding: 'utf8',
    database: 'onebitbot_test',
    pool: 5,
    host: 'db',
    username: 'postgres',
    password: ''
  }
end

configure :development do
  set :database, {
    adapter: 'postgresql',
    encoding: 'utf8',
    database: 'onebitbot_development',
    pool: 5,
    host: 'db',
    username: 'postgres',
    password: ''
  }
end

configure :production do
  db = URI.parse(ENV['DATABASE_URL'] || 'postgres:///postgres/onebitbot_production')

  set :database, {
    adapter:  'postgresql',
    encoding: 'utf8',
    database: db.path[1..-1],
    host:     db.host,
    username: db.user,
    password: db.password,
  }
end
