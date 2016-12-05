module CreditCardsHelper
  def mask_credit_card(number)
    "XXXX-XXXX-XXXX-#{last_digits(number)}"
  end

  private
  def last_digits(number)
    number.to_s.slice(-4..-1)
  end
end
