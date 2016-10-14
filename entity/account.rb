class Account
  include DataMapper::Resource

  property :id, Serial
  property :number, String
  property :currency, String
  property :balance, String
  property :type, String
  belongs_to :card
end