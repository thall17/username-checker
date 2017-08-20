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
      linkedin: check_linkedin(@name),
      twitter: check_twitter(@name),
      instagram: check_instagram(@name),
      facebook: check_instagram(@name), # Need to update
      bitbucket: check_instagram(@name) # Need to update
    }


    #URI's
    # @github_uri = uri = URI.parse("https://github.com/#{username}")
    # @linkedin_uri = uri = URI.parse("https://www.linkedin.com/in/#{username}")

    # #Responses
    # @github_response = Net::HTTP.get_response(URI.parse("https://github.com/#{@name}"))
    # @linkedin_response = Net::HTTP.get_response(URI.parse("https://www.linkedin.com/in/#{@name}"))
    # @twitter_response = Net::HTTP.get_response(URI.parse("https://twitter.com/#{@name}"))
    # @instagram_response = Net::HTTP.get_response(URI.parse("https://www.instagram.com/#{@name}/"))
  end


  private
    def check_github(name)
      result = ""
      result = Net::HTTP.get_response(URI.parse("https://github.com/#{name}"))
      return result
    end

    def check_linkedin(name)
      result = ""
      result = Net::HTTP.get_response(URI.parse("https://www.linkedin.com/in/#{name}"))
      return result
    end

    def check_twitter(name)
      result = ""
      result = Net::HTTP.get_response(URI.parse("https://twitter.com/#{name}"))
      return result
    end

    def check_instagram(name)
      result = ""
      result = Net::HTTP.get_response(URI.parse("https://www.instagram.com/#{name}/"))
      return result
    end

end
