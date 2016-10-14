require_relative '../entity/persona'
require_relative '../entity/account'
require_relative '../entity/card'

module Utility

  def self.populate
    personas = YAML.load_file("#{File.dirname(__FILE__)}/../data/users.yml")
    personas.each do |persona|
      _persona = Persona.create(:name => persona['name'],
                                :idc => persona['idc'])
      persona['cards'].each do |card|
        _card = Card.create(:number => card['number'],
                            :pin4 => card['pin4'],
                            :expiry_date => card['expiry_date'],
                            :status => card['status'])
        card['accounts'].each do |account|
          _account = Account.create(:number => account['number'],
                                    :currency => account['currency'],
                                    :balance => account['balance'],
                                    :type => account['type'])
          _card.accounts << _account
        end
        _persona.cards << _card
        _persona.save
      end
    end
  end

end