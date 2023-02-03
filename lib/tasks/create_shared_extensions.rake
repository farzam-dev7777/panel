namespace :db do
    desc 'create shared_extensions Schema'
    task extensions: :environment do
      ActiveRecord::Base.connection.execute 'CREATE SCHEMA IF NOT EXISTS shared_extensions;'
      ActiveRecord::Base.connection.execute 'GRANT USAGE ON SCHEMA shared_extensions TO public;'
  
      ActiveRecord::Base.connection.execute 'GRANT EXECUTE ON ALL functions IN SCHEMA shared_extensions TO public;'
      ActiveRecord::Base.connection.execute 'ALTER DEFAULT PRIVILEGES IN SCHEMA shared_extensions GRANT EXECUTE ON functions TO public;'
      ActiveRecord::Base.connection.execute 'ALTER DEFAULT PRIVILEGES IN SCHEMA shared_extensions GRANT USAGE ON types TO public;'
  
      ActiveRecord::Base.connection.execute 'CREATE EXTENSION IF NOT EXISTS "hstore" SCHEMA shared_extensions;'
      ActiveRecord::Base.connection.execute 'CREATE EXTENSION IF NOT EXISTS "uuid-ossp" SCHEMA shared_extensions;'
      ActiveRecord::Base.connection.execute 'CREATE EXTENSION IF NOT EXISTS "pgcrypto" SCHEMA shared_extensions;'
      ActiveRecord::Base.connection.execute 'CREATE EXTENSION IF NOT EXISTS "plpgsql" SCHEMA shared_extensions;'
    end
  end
  
  Rake::Task["db:create"].enhance do
    Rake::Task["db:extensions"].invoke
  end
  
  Rake::Task["db:test:purge"].enhance do
    Rake::Task["db:extensions"].invoke
  end