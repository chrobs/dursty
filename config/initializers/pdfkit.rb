PDFKit.configure do |config|
  # config.wkhtmltopdf = '/path/to/wkhtmltopdf'
  config.default_options = {
    :page_size => 'A4',
    :orientation => "Landscape",
    :encoding=>"UTF-8"
    #:print_media_type => true
  }
  # config.root_url = "http://localhost" # Use only if your external hostname is unavailable on the server.
  config.wkhtmltopdf = '/usr/local/bin/wkhtmltopdf-static-amd64' if Rails.env.production?
end
