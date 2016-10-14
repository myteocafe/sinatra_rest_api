class Persona
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :idc, String
  has n, :cards
  validates_presence_of :name
  validates_presence_of :idc
end