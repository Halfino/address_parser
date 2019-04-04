require 'open-uri'
require 'date'
require_relative 'file_not_found_exception'

class AddressDownloader

  attr_reader :url

  def initialize
    @uri = 'http://vdp.cuzk.cz'
  end

  def download_csv_files()
    begin
      File.open('csv.zip', "wb") do |file|
        file.write open(build_url).read
      end
    rescue FileNotFoundException => e
      e.inspect
      e.message
    end

  end

  private

  def build_url
    return "#{@uri}/vymenny_format/csv/#{build_file_name}"
  end

  def build_file_name
    date = Date.today()
    first_day_of_this_month = Date.new(date.year, date.month,1 )
    last_day_of_prev_month = first_day_of_this_month.prev_day
    file_name_string = "#{last_day_of_prev_month.year}0#{last_day_of_prev_month.month}#{last_day_of_prev_month.day}_OB_ADR_csv.zip"

    return file_name_string
  end
end
