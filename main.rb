require 'zip'
require 'csv'
require 'benchmark'
require_relative 'address_downloader'
require_relative 'address'
require_relative 'zip_parser'

time = Benchmark.measure {
  downloader = AddressDownloader.new()
  downloader.download_csv_files()


  file = 'csv.zip'

  parser = ZipParser.new(file)

  address_book = parser.parse_zip

  prague = address_book.find_all{|x| x.prague_part_code != nil}
  p address_book.size
  prague.each do |a|
    puts "momc: #{a.momc_name}"
    puts "cast prahy: #{a.prague_part_name}"
    puts "Mestska cast: #{a.city_part_name}"
    puts "Mesto: #{a.city}"
    puts "=" * 25
  end
}

puts time.real