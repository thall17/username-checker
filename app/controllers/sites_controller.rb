require "net/http"
require "uri"

class SitesController < ApplicationController

  def index
    if params[:name]
      @name = params[:name]
      if @name.match(/\s/)
        @name = ""
      end
    else
      @name = ""
    end

    @results = { 
      github: check_github(@name),
      linkedin: "",
      twitter: "",
      instagram: ""
    }


    #URI's
    # @github_uri = uri = URI.parse("https://github.com/#{username}")
    # @linkedin_uri = uri = URI.parse("https://www.linkedin.com/in/#{username}")

    #Responses
    @github_response = Net::HTTP.get_response(URI.parse("https://github.com/#{@name}"))
    @linkedin_response = Net::HTTP.get_response(URI.parse("https://www.linkedin.com/in/#{@name}"))
    @twitter_response = Net::HTTP.get_response(URI.parse("https://twitter.com/#{@name}"))
    @instagram_response = Net::HTTP.get_response(URI.parse("https://www.instagram.com/#{@name}/"))
  end

  # def form
  #   @username = "timjhall"
  #   render :action => :index
  # end

  private
    def check_github(name)
      return Net::HTTP.get_response(URI.parse("https://github.com/#{name}"))
    end

end
