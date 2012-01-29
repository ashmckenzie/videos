class Videos

  def initialize host, port
    @server = Plex::Server.new(host, port)
  end

  def tv_shows key='TV shows'
    @tv_shows ||= @server.library.sections.detect { |x| x.title == key }
  end

  def movies key='Movies'
    @movies ||= Movies.new @server.library.sections.detect { |x| x.title == key }
  end  

end