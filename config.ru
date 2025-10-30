require './config/environment'

if defined?(ActiveRecord::Migrator) && ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

# Disable protection for /health requests only
use Rack::Protection, except: :path_traversal unless ENV['RACK_ENV'] == 'test'

# Mount controllers
use PostsController
use UsersController
use SessionsController

run ApplicationController
