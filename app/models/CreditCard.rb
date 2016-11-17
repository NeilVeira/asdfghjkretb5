# note: this is not in the database
# purpose is for validation of credit card

class CreditCard

  include ActiveModel::Model


  attr_accessor :number, :month, :year, :cvc, :amount

  validates :number, presence: true, length: {in: 14..18} # dunno how long standard credit cards are but approx

end