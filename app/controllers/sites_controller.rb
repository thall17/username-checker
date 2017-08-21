require "net/http"
require "uri"

class SitesController < ApplicationController

  def index
    if params[:name]
      puts "params set"
      @name = params[:name]
      if @name.match(/\s/)
        puts "in Regex"
        @name = ""
      end
    else
      @name = ""
    end

    if @name == ""
      @results = { 
        github: "",
        linkedin: "",
        twitter: "",
        instagram: "",
        facebook: "",
        bitbucket: ""
      }
    else
      @results = { 
        github: check_github(@name),
        linkedin: check_linkedin(@name),
        twitter: check_twitter(@name),
        instagram: check_instagram(@name),
        facebook: check_instagram(@name), # Need to update
        bitbucket: check_instagram(@name) # Need to update
      }
    end


    
  end


  private
    def check_github(name)
      result = ""

      # if name violates any of the rules, add "Wrong format..."

      # Github username may only contain alphanumeric characters or hyphens.
      # if name contains anything else, add specifics

      # Github username cannot have multiple consecutive hyphens.
      # if name has multiple hyphens, add specifics

      # Github username cannot begin or end with a hyphen.
      # if name begins with hyphen...
      # if name ends with hyphen...

      # Maximum is 39 characters.
      # if name > 39 characters long...

      response = Net::HTTP.get_response(URI.parse("https://github.com/#{name}"))
      if response.code == '200'
        return "Username taken"
      end
    end

    def check_linkedin(name)
      result = ""
      # if name violates any of the rules, add "Wrong format..."

      # Your custom LinkedIn URL must contain 5-30 characters.
      # if wrong length...

      # Letters or numbers
      # if anything else...

      response = Net::HTTP.get_response(URI.parse("https://www.linkedin.com/in/#{name}"))
      return result
    end

    def check_twitter(name)
      result = ""
      ### Twitter Username Rules:
      # Letters, numbers, and underscores only.
      # It’s case-blind, so you can enter hi_there, Hi_There, or HI_THERE and they’ll all work the same (and be treated as a single account).
      # My note: do underscores get converted to something else in URL?
      # There is apparently no minimum-length requirement; the user a exists on Twitter. Maximum length is 15 characters.
      # There is also no requirement that the name contain letters at all; the user 69 exists, as does a user whose name I can’t pronounce.
      response = Net::HTTP.get_response(URI.parse("https://twitter.com/#{name}"))
      return result
    end

    def check_instagram(name)
      result = ""
      ### Instagram Username Rules:
      # Limit - 30 symbols. Username must contains only letters, numbers, periods and underscores.
      response = Net::HTTP.get_response(URI.parse("https://www.instagram.com/#{name}/"))
      return result
    end

end
