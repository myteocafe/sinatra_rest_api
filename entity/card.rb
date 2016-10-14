class Card
  include DataMapper::Resource

  property :id, Serial
  property :number, String
  property :expiry_date, String
  property :pin4, String
  property :status, String
  has n, :accounts
  belongs_to :persona
end