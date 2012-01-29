require 'erb'

class Movies

  def initialize section
    @section = section
  end

  def all
    @list ||= @section.all
  end

  def search opts
    filters = opts.collect do |f|
      lambda do |movie| 
        if f[2]
          !movie.send(f[0]).match(f[1])
        else
          movie.send(f[0]).match(f[1])
        end
      end 
    end
    results = all.select do |movie|
      !filters.collect do |filter|
        filter.call(movie) ? true : false
      end.include?(false)
    end
    results
  end

  def create_html
    InlineStyle.process(generate_html, :stylesheets_path => "./lib/templates/styles")
  end

  def generate_html
    title = 'Movies'
    body = generate_body_html
    template = ERB.new(File.read('./lib/templates/default.html.erb'))
    template.result(binding)    
  end

  def generate_body_html
    movies = []
    all.each do |movie|
      movies << generate_movie_html(Movie.new(movie))
    end
    movies.join("\n")    
  end

  def generate_movie_html movie
    @template ||= ERB.new(File.read('./lib/templates/shared/_movie.html.erb'))
    @template.result(binding)
  end

end