class TVShows

  def initialize section
    @section = section
  end

  def all
    @list ||= @section.all
  end  

end