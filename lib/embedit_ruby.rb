require 'open-uri'
require 'net/http'
require 'rexml/document'
require 'cgi'
$KCODE = "u"

class EmbeditRuby
  
  attr_reader :title, :format, :url, :html, :fbml
  
  def initialize(url, size={})
    url = CGI.escape(url)
    data = REXML::Document.new(open("http://embedit.me/home/index.xml/?url=#{url}&height=#{size[:height]}&width=#{size[:width]}"))
    @title = REXML::XPath.first(data, "//title").text
    @format = REXML::XPath.first(data, "//format").text
    @html = REXML::XPath.first(data, "//html").text   # Service will provide a way to change size, this may be providing user with regex pattern to the sizes, so the wrapper can change it
    @url = REXML::XPath.first(data, "//url").text
    @fbml = REXML::XPath.first(data, "//fbml").text
    @valid = REXML::XPath.first(data, "//valid").text
  end
  
  def valid?
    @valid
  end
      
end