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


  sliced_address_book = address_book.each_slice(1000).to_a

  sliced_address_book.each do |batch_part|
    body = []
    batch_part.each do |address|
      body << {index: 'addresses', type: 'address', data: address.to_hash}
    end

    client.bulk body: body
  end
  #address_book.each do |address|
  #  client.index index: 'addresses', type: 'address', body: address.to_hash
  #end
}

puts time.real