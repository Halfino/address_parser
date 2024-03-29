require 'json'
class ZipParser
  attr_reader :file

  def initialize(file)
    @file = file
    @address_book = []
  end

  def parse_zip
    Zip::File.open(@file) do |zip_file|
      zip_file.each do |file|
        parse_csv(file)
      end
    end
    File.delete(@file)

    return @address_book
  end

  private

  def parse_csv(file)
    csv = CSV.parse(file.get_input_stream.read.encode('utf-8','Windows-1250'), :headers => true, :col_sep => ';')
    csv.each do |row|
      a = Address.new
      #a.adm_code = row['Kód ADM']
      #a.city_code = row['Kód obce']
      a.city = row['Název obce']
      #a.momc_code = row['Kód MOMC']
      a.momc_name = row['Název MOMC']
      #a.prague_part_code = row['Kód MOP']
      a.prague_part_name = row['Název MOP']
      #a.city_part_code = row['Kód části obce']
      a.city_part_name = row['Název části obce']
      #a.street_code = row['Kód ulice']
      a.street_name = row['Název ulice']
      if row['Typ SO'] == 'č.ev.'
        a.evidence_number = row['Číslo domovní']
      elsif row['Typ SO'] == 'č.p.'
        a.description_number = row['Číslo domovní']
      end
      a.orientation_number = row['Číslo orientační']
      #a.orientation_number_symbol = row['Znak čísla orientačního']
      a.zip = row['PSČ']
      @address_book << a
    end
  end
end