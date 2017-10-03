require "net/http"
require "uri"

class SitesController < ApplicationController

  def index
    if params[:name]
      @name = params[:name].downcase
      if @name.match(/\s/)
        @name = ""
      end
    else
      @name = ""
    end

    # If form field is blank, don't return anything in the table (show an empty string).
    if @name == ""
      @results = { 
        GitHub: {icon: "fa-github", result: ""},
        LinkedIn: {icon: "fa-linkedin", result: ""},
        Twitter: {icon: "fa-twitter", result: ""},
        Instagram: {icon: "fa-instagram", result: ""},
        Facebook: {icon: "fa-facebook", result: ""},
        Bitbucket: {icon: "fa-bitbucket", result: ""}
      }
    # If form field is not blank, validate it per each site's rules to populate each row in the table.
    else
      @results = { 
        GitHub: {icon: "fa-github", result: check_github(@name)},
        LinkedIn: {icon: "fa-linkedin", esult: check_linkedin(@name)},
        Twitter: {icon: "fa-twitter", esult: check_twitter(@name)},
        Instagram: {icon: "fa-instagram", result: check_instagram(@name)},
        Facebook: {icon: "fa-facebook", result: check_facebook(@name)},
        Bitbucket: {icon: "fa-bitbucket", result: check_bitbucket(@name)}
      }
    end

  end


  private
    def check_github(name)
      result = ""

      # Set booleans for each rule
      too_shoort_or_long = (name.length <= 0 or name.length > 39) # Must be a certain length.
      bookend_hyphen = (name[0] == "-" or name[-1] == "-") # Cannot begin or end with a hyphen.

      # Github username may only contain alphanumeric characters or hyphens.
      anh_regex = /^[a-zA-Z0-9-]*$/
      if (anh_regex =~ name).is_a? Integer
        non_alphanum_or_hyphen = false
      else
        print"in the else"
        non_alphanum_or_hyphen = true
      end

      # Github username cannot have multiple consecutive hyphens.
      ch_regex = /--+/
      if (ch_regex =~ name).is_a? Integer
        consecutive_hypens = true
      else
        consecutive_hypens = false
      end

      # Print errors for violated rules:
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
          result << " Cannot have consecutive hyphens."
        end
      else
        response = Net::HTTP.get_response(URI.parse("https://github.com/#{name}"))
        if response.code == '200'
          result = "Username taken"
        else
          result = "Available"
        end
      end

      return result
    end

    def check_linkedin(name)
      result = ""
      # if name violates any of the rules, add "Wrong format..."

      # Letters or numbers
      # if anything else...
      too_shoort_or_long = (name.length < 5 or name.length > 30) # Must be a certain length.

      
      if too_shoort_or_long
        result << "Wrong format."
        if too_shoort_or_long
          result << " Must be between 5 and 30 chars."
        end
      else
        if response.code == '200'
          result = "Username taken"
        else
          result = "Available"
        end
      end
      return result
    end

    def check_twitter(name)
      # Letters, numbers, underscores only.
      # Max length: 15 characters

      result = ""

      # Check if length is okay
      too_shoort_or_long = (name.length > 15) # Must be a certain length.

      # Check if alphanumeric/undercores only
      anu_regex = /^[a-zA-Z0-9_]*$/
      regex_result = anu_regex =~ name
      if (regex_result.is_a? Integer) and (regex_result != 0)
        print("regex_result = #{regex_result}")
        non_alphanum_or_underscore = false
      else
        non_alphanum_or_underscore = true
      end

      # Create result string based on rule checks
      if too_shoort_or_long or non_alphanum_or_underscore
        result << "Wrong format."
        if too_shoort_or_long
          result << " Must be less than 16 characters."
        end
        if non_alphanum_or_underscore
          result << " Must only contain alphanumeric characters or underscores."
        end
      else
        response = Net::HTTP.get_response(URI.parse("https://twitter.com/#{name}"))
        if response.code == '200'
          result = "Username taken"
        else
          result = "Available"
        end
      end
      return result
    end

    def check_instagram(name)
      # Letters, numbers, periods, underscores only
      # Max length is 30
      result = ""

      # Check if length is okay
      too_shoort_or_long = (name.length > 30) # Must be a certain length.

      # Check if alphanumeric/undercores only
      anu_regex = /^[a-zA-Z0-9_]*$/
      regex_result = anu_regex =~ name
      if (regex_result.is_a? Integer) and (regex_result != 0)
        print("regex_result = #{regex_result}")
        non_alphanum_or_underscore = false
      else
        non_alphanum_or_underscore = true
      end

      # Create result string based on rule checks
      if too_shoort_or_long or non_alphanum_or_underscore
        result << "Wrong format."
        if too_shoort_or_long
          result << " Must be less than 16 characters."
        end
        if non_alphanum_or_underscore
          result << " Must only contain alphanumeric characters or underscores."
        end
      else
        response = Net::HTTP.get_response(URI.parse("https://instagram.com/#{name}"))
        if response.code == '200'
          result = "Username taken"
        else
          result = "Available"
        end
      end
      return result
    end
  
    def check_facebook(name)
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
      return result
    end
  
    def check_bitbucket(name)
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
      return result
    end

end
