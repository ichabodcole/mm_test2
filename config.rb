require 'net/http'
require 'json'

activate :livereload
###
# Compass
###

# Susy grids in Compass
# First: gem install susy
# require 'susy'

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy (fake) files
# page "/this-page-has-no-template.html", :proxy => "/template-file.html" do
#   @which_fake_page = "Rendering a fake page with a variable"
# end

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Methods defined in the helpers block are available in templates
helpers do

  def get_kitten_name
    url = "http://randomword.setgetgo.com/get.php"
    resp = Net::HTTP.get_response(URI.parse(url))
    #data = JSON.parse(resp.body)
    k_name = resp.body.force_encoding('UTF-8')
    return k_name
  end

  def get_meat_text
    url = "http://baconipsum.com/api/?paras=1&sentences=1&type=meat-and-filler"
    resp = Net::HTTP.get_response(URI.parse(url))
    data = JSON.parse(resp.body)
    return data[0]
  end

  def get_kittens(kitten_amount)
    str = ""
    (1..kitten_amount).each do
      k_width  = rand(100..200)
      k_height  = rand(100..200)
      kitten_size = "#{k_width}/#{k_height}"
      str +="<div class='kitten'>\n"
        str+="<img src='http://placekitten.com/#{kitten_size}'>\n"
        str+="<h3>Hello, I'm "+get_kitten_name+"!</h3>\n"
        str+="<p>"+get_meat_text+"</p>\n"
      str+="</div>\n"
    end
    return str
  end
end

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :cache_buster

  # Use relative URLs
  # activate :relative_assets

  # Compress PNGs after build
  # First: gem install middleman-smusher
  # require "middleman-smusher"
  # activate :smusher

  # Or use a different image path
  # set :http_path, "/Content/images/"
end