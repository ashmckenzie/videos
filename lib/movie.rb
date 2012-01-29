class Movie

  def initialize movie
    @movie = movie
  end

  def thumb_url
    begin
      "http://#{$CONFIG['host']}:#{$CONFIG['port']}#{@movie.thumb}"
    rescue => e
      #puts e
    end
  end

  def title
    @movie.title
  end

  def summary
    @movie.summary
  end
end