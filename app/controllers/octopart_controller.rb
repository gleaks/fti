class OctopartController < ApplicationController
  require "net/http"
  require "uri"
  before_action :require_login

  def index
    url = 'http://octopart.com/api/v3/parts/match?'
    url += '&queries=' + URI.encode(JSON.generate([{:mpn => params['id']}]))
    url += '&apikey=61bd2134df2ff01ffbae'

    resp = Net::HTTP.get_response(URI.parse(url))
    server_response = JSON.parse(resp.body)
    @results = server_response
  end
end
