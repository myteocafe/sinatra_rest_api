require 'sinatra'
require 'bundler'
require 'nokogiri'

Bundler.require

require_relative 'entity/persona'
require_relative 'entity/card'
require_relative 'entity/account'
require_relative 'utilities/utility'


DataMapper.setup(:default, 'sqlite:memory:')
DataMapper.finalize
DataMapper.auto_migrate!

# BCP Message Broker Mocked Services

post '/svc/CardVldV2' do
  # Get the request body (XML)
  req_body = request.body.read

  # Parse the card number from the request body
  regex = /.*<mfx:ProdNro>(.*)<\/mfx:ProdNro>.*/
  card_number = req_body.match(regex).captures.first

  # Which persona owns above card number?
  persona = Persona.all(Persona.cards.number => card_number).first

  # Preparing the response
  xml_content = File.read("#{File.dirname(__FILE__)}/data/CardVldV2/response_template.xml")
  xml_content.gsub!('[NAME]', persona.name)
  xml_content.gsub!('[IDC]', persona.idc)

  # Response ready
  content_type 'text/xml'
  xml_content
end

post '/another_url' do

end

# Database services
get '/db-migrate' do
  Persona.destroy!
  Card.destroy!
  Account.destroy!
  Utility.populate
  content_type 'html/text'
  'BCP Message Broker has been populated successfully'
end

get '/data' do
  content_type 'html/text'
  "Personas: #{Persona.all.inspect}\nCards: #{Card.all.inspect}\nAccounts: #{Account.all.inspect}"
end