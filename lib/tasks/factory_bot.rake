# Lint for factory bot in order to avoid issues with cache
namespace :factory_bot do
  desc 'Verify that all FactoryBot factories are valid'
  task lint: :environment do
    if Rails.env.test?
      DatabaseCleaner.cleaning do
        FactoryBot.lint
      end
    else
      system(`bundle exec rake factory_bot:lint RAILS_ENV="test"`)
      fail if $?.exitstatus.nonzero?
    end
  end
end
