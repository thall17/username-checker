require "net/http"
require "uri"

class SitesController < ApplicationController

  def index
    @github_uri = uri = URI.parse("https://github.com/timjhall")
    @github_response = Net::HTTP.get_response(uri)
  end

end
