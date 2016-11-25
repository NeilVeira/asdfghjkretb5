class CreditCard < ApplicationRecord
  belongs_to :person
  validates :number, presence: true, length: {in: 14..18} # dunno how long standard credit cards are but approx
  validates :month, presence: true, numericality: true
  validates :year, presence: true, numericality: true
  validates :cvc, presence: true, numericality: true
end
