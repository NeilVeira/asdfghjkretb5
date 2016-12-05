class CreditCard < ApplicationRecord
  belongs_to :person
  validates :number, presence: true, length: {in: 14..18} # dunno how long standard credit cards are but approx
  validates :month, presence: true, numericality: true
  validates :year, presence: true, numericality: true
  validates :cvc, presence: true, numericality: true

  def self.existance(c_number, c_person_id)
    return CreditCard.where(number: c_number, person_id: c_person_id).any?
  end
end
