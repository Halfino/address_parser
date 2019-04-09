
class Address
  attr_accessor :adm_code, :city_code, :city, :momc_code, :momc_name, :prague_part_code, :prague_part_name,
                :city_part_code, :city_part_name, :street_code, :street_name, :building_type, :house_number,
                :orientation_number, :orientation_number_symbol, :zip

  def to_hash
    hash = {}
    instance_variables.each {|var| hash[var.to_s.delete("@")] = instance_variable_get(var) }
    hash
  end
end
