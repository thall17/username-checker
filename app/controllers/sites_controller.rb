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

      # Set booleans for each condition of github username
      too_shoort_or_long = 0 < name.length < 39
      bookend_hyphen = name[0] == "-" or name[-1] == "-" # Cannot begin or end with a hyphen.
      non_alphanum_or_hyphen = false # Github username may only contain alphanumeric characters or hyphens.
      consecutive_hypens = false # Github username cannot have multiple consecutive hyphens.

      if too_shoort_or_long or bookend_hyphen or non_alphanum_or_hyphen or consecutive_hypens
        result << "Wrong format."
        if too_shoort_or_long
          result << " Must be between 1 and 39 chars."
        end
        if bookend_hyphen
          result << " Cannot start or end with a hyphen."
        end
        if non_alphanum_or_hyphen
          result << " Must only contain alphanumeric characters or hyphens."
        end
        if consecutive_hypens
          result << " Cannot have consecutive hyphens"
        end
      else
        response = Net::HTTP.get_response(URI.parse("https://github.com/#{name}"))
        if response.code == '200'
          result = "Username taken"
        end
      end

      return result
    end

    def check_linkedin(name)
      result = ""
      # if name violates any of the rules, add "Wrong format..."

      # Your custom LinkedIn URL must contain 5-30 characters.
      # if wrong length...
      # if name.length > 30 or name.length < 5
      #   result << "Username must be between 5 and 30 characters long."
      # end

      # Letters or numbers
      # if anything else...

      response = Net::HTTP.get_response(URI.parse("https://www.linkedin.com/in/#{name}"))
      result = response
      return result
    end

    def check_twitter(name)
      result = ""
      # if name violates any of the rules, add "Wrong format..."

      # Letters, numbers, and underscores only.
      # if anything else...

      # My note: do underscores get converted to something else in URL?

      # There is apparently no minimum-length requirement; the user a exists on Twitter. Maximum length is 15 characters.
      # if name.length > 15
      #   result << "Username must be less than 16 characters long."
      # end
      # There is also no requirement that the name contain letters at all; the user 69 exists, as does a user whose name I can’t pronounce.
      response = Net::HTTP.get_response(URI.parse("https://twitter.com/#{name}"))
      result = response
      return result
    end

    def check_instagram(name)
      result = ""
      # if name violates any of the rules, add "Wrong format..."

      # Limit - 30 chars. Username must contains only letters, numbers, periods and underscores.
      # If > 30 chars...
      # if name.length > 30
      #   result << "Max length = 30 characters."
      # end

      # if contains anytihng else besides letters, numbers, periods, underscores...

      response = Net::HTTP.get_response(URI.parse("https://www.instagram.com/#{name}/"))
      result = response
    end

end
