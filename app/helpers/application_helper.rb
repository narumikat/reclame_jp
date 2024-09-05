module ApplicationHelper
  def display_website(url)
    url.sub(/^https?:\/\//, '').sub(/^www\./, '').chomp('/')
  end  
end
