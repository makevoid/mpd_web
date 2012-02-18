class Song
  attr_reader :path, :name
  
  def initialize(path)
    @path = path
    @name = path
  end
end