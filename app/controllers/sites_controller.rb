require "net/http"
require "uri"

class SitesController < ApplicationController

  def index
    @username = params[:q]
    #URI's
    # @github_uri = uri = URI.parse("https://github.com/#{username}")
    # @linkedin_uri = uri = URI.parse("https://www.linkedin.com/in/#{username}")

    #Responses
    @github_response = Net::HTTP.get_response(URI.parse("https://github.com/#{@username}"))
    @linkedin_response = Net::HTTP.get_response(URI.parse("https://www.linkedin.com/in/#{@username}"))
    @twitter_response = Net::HTTP.get_response(URI.parse("https://twitter.com/#{@username}"))
    @instagram_response = Net::HTTP.get_response(URI.parse("https://www.instagram.com/#{@username}/"))
  end

  def form
    @username = "timjhall"
    render :action => :index
  end

end
