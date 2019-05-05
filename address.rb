
class Address
  attr_accessor :city, :momc_name, :prague_part_name,:city_part_name, :street_name, :orientation_number,
                :zip, :evidence_number, :description_number

  def to_hash
    hash = {}
    instance_variables.each {|var| hash[var.to_s.delete("@")] = instance_variable_get(var) }
    hash
  end
end


# :adm_code, :city_code, :momc_code, :prague_part_code, :street_code,:orientation_number_symbol,:city_part_code,