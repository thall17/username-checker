require "net/http"
require "uri"

class SitesController < ApplicationController

  def index
    username = "timjhall"

    #URI's
    # @github_uri = uri = URI.parse("https://github.com/#{username}")
    # @linkedin_uri = uri = URI.parse("https://www.linkedin.com/in/#{username}")

    #Responses
    @github_response = Net::HTTP.get_response(URI.parse("https://github.com/#{username}"))
    @linkedin_response = Net::HTTP.get_response(URI.parse("https://www.linkedin.com/in/#{username}"))

  end

end
