# # frozen_string_literal: true

Capybara.register_driver :chrome_headless do |app|
  chrome_capabilities = ::Selenium::WebDriver::Remote::Capabilities.chrome(
    'goog:chromeOptions' => {
      'args': %w[no-sandbox headless disable-gpu window-size=1400,1400]
    }
  )

  if ENV['HUB_URL']
    Capybara::Selenium::Driver.new(app,
                                   browser: :chrome,
                                   url: ENV['HUB_URL'],
                                   desired_capabilities: chrome_capabilities)
  else
    Capybara::Selenium::Driver.new(app,
                                   browser: :chrome,
                                   desired_capabilities: chrome_capabilities)
  end
end
# ...
RSpec.configure do |config|
  # ...
  config.before(:each, type: :feature) do
    Capybara.javascript_driver = ENV['HUB_URL'] ? :chrome_headless : :selenium_chrome

    Capybara.app_host = "http://#{IPSocket.getaddress(Socket.gethostname)}:3001"
    Capybara.server_host = IPSocket.getaddress(Socket.gethostname)
    Capybara.server_port = 3001
  end
end

