require "net/http"
require "uri"

class SitesController < ApplicationController

  def index
    if params[:name]
      puts "params set"
      @name = params[:name].downcase
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

      # Github username cannot have multiple consecutive hyphens.

      # Github username cannot begin or end with a hyphen.

      # Maximum is 39 characters.
      if name.length > 39
        result << "Username must be less than 40 characters long."
      end
      response = Net::HTTP.get_response(URI.parse("https://github.com/#{name}"))
      if response.code == '200'

        result = "Username taken"
      end

      return result
    end

    def check_linkedin(name)
      result = ""
      # if name violates any of the rules, add "Wrong format..."

      # Your custom LinkedIn URL must contain 5-30 characters.
      # if wrong length...
      if name.length > 30 or name.length < 5
        result << "Username must be between 5 and 30 characters long."
      end

      # Letters or numbers
      # if anything else...

      response = Net::HTTP.get_response(URI.parse("https://www.linkedin.com/in/#{name}"))
      return result
    end

    def check_twitter(name)
      result = ""
      # if name violates any of the rules, add "Wrong format..."

      # Letters, numbers, and underscores only.
      # if anything else...

      # My note: do underscores get converted to something else in URL?

      # There is apparently no minimum-length requirement; the user a exists on Twitter. Maximum length is 15 characters.
      if name.length > 15
        result << "Username must be less than 16 characters long."
      end
      # There is also no requirement that the name contain letters at all; the user 69 exists, as does a user whose name I can’t pronounce.
      response = Net::HTTP.get_response(URI.parse("https://twitter.com/#{name}"))
      return result
    end

    def check_instagram(name)
      result = ""
      # if name violates any of the rules, add "Wrong format..."

      # Limit - 30 chars. Username must contains only letters, numbers, periods and underscores.
      # If > 30 chars...
      if name.length > 30
        result << "Max length = 30 characters."
      end

      # if contains anytihng else besides letters, numbers, periods, underscores...

      response = Net::HTTP.get_response(URI.parse("https://www.instagram.com/#{name}/"))
      return result
    end

end
