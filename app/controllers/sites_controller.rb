require "net/http"
require "uri"

class SitesController < ApplicationController

  def index
    if params[:username]
      @username = params[:username]
      if @username.match(/\s/)
        @username = ""
      end
    else
      @username = ""
    end
    
    #Responses
    @github_response = Net::HTTP.get_response(URI.parse("https://github.com/#{@username}"))
    @linkedin_response = Net::HTTP.get_response(URI.parse("https://www.linkedin.com/in/#{@username}"))
    @twitter_response = Net::HTTP.get_response(URI.parse("https://twitter.com/#{@username}"))
    @instagram_response = Net::HTTP.get_response(URI.parse("https://www.instagram.com/#{@username}/"))
  end


end
