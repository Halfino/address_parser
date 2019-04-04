class FileNotFoundException < StandardError
  def initialize(message)
    super(message)
  end

end