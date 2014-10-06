require 'uri'
require 'net/http'
require 'simple_oauth'

class OAuthClient
  attr_reader :credentials

  def initialize(credentials)
    raise ArgumentError, "must provide consumer_key, consumer_secret, token, and token_secret" unless valid_credentials?(credentials)
    @credentials = credentials
  end

  def get(url)
    # create the HTTP GET request
    # request = # fill this in

    # set the Authorization Header using the oauth helper
    request["Authorization"] = oauth_header(request)

    # connect to the server and send the request
    # response = # fill this in
  end

  private

  # A helper method to generate the OAuth Authorization header given
  # an Net::HTTP::GenericRequest object and a Hash of params
  def oauth_header(request, params = {})
    SimpleOAuth::Header.new(request.method, request.uri, params, credentials).to_s
  end

  def valid_credentials?(credentials)
    [:consumer_key, :consumer_secret, :token, :token_secret].all? { |key| credentials[key] }
  end
end

# sample usage:
#
# client = OAuthClient.new(
#   consumer_key: "YOUR TWITTER API KEY",
#   consumer_secret: "YOUR TWITTER API SECRET",
#   token: "YOUR TWITTER ACCESS TOKEN",
#   token_secret: "YOUR TWITTER ACCESS TOKEN SECRET"
# )
#
# p JSON.parse(client.get("https://api.twitter.com/1.1/statuses/user_timeline.json").body)