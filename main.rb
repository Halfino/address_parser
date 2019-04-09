require 'zip'
require 'csv'
require 'benchmark'
require 'json'
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
  p address_book.first
}

puts time.real