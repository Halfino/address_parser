require 'zip'
require 'csv'
require 'benchmark'
require 'json'
require 'elasticsearch'
require_relative 'address_downloader'
require_relative 'address'
require_relative 'zip_parser'

time = Benchmark.measure {
  downloader = AddressDownloader.new()
  downloader.download_csv_files()

  file = 'csv.zip'
  parser = ZipParser.new(file)
  address_book = parser.parse_zip
  puts address_book.size

  client = Elasticsearch::Client.new url: 'http://localhost:9200', log:true

  address_book.each_with_index  do |address, index|
    client.index index: 'addresses', type: 'address', id: index + 1, body: address.to_hash
  end
}

puts time.real