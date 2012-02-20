require 'pathname'

class Song

  attr_reader :name, :artist, :type, :album

  def initialize(type, string)
    case type
    when :label
      split = string.split(" - ")
      @artist, @name = split
      @type = :playlist
    when :path
      database_infos string
      @type = :database
    else
      raise "Type '#{type}' not set in Song#initialize"
    end
  end

  def database_infos(path)
    @path = Pathname.new(path)
    @dir = @path.dirname
    split = @dir.to_s.split("/")
    if split
      @artist = split[0]
      @album  = split[1] if split.size >= 2
    end
    @name = @path.basename(".*")
  end

end