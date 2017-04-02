require 'oauth'
require 'mysql'
require "addressable/uri"
$domain = 'https://api.twitter.com/'
$version = '1.1/'

def tweet(key, status)
	consumer_key        = key[0]
	consumer_secret     = key[1]
	access_token        = key[2]
	access_token_secret = key[3]

	consumer = OAuth::Consumer.new(
		consumer_key,
		consumer_secret,
		site: $domain
	)
	endpoint = OAuth::AccessToken.new(consumer, access_token, access_token_secret)
	response = endpoint.post($domain + $version + 'statuses/update.json', { :status => status})
	return response.body
end
