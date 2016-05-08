class CreditCard
  include Mongoid::Document
  include Mongoid::Timestamps

  # TODO Missing expiration_date validations.
  # TODO Derivate :bin, :scheme from :number.
  # TODO Ensure :number and :cvc are never persisted.

  SCHEMES = %w(CR DB)
  BRANDS = %w(AMEX VISA MC)

  field :owner_name, type: String
  field :bin, type: String
  field :last_four, type: String
  field :expiration_date, type: Date
  field :scheme, type: String
  field :brand, type: String

  validates :owner_name, :bin, :last_four, :expiration_date, :scheme, :brand, presence: true
  validates :owner_name, length: { minimum: 10, maximum: 50 }
  validates :bin, length: { is: 6 }
  validates :last_four, length: { is: 4 }
  validates :bin, :last_four, numericality: {only_integer: true}
  validates :scheme, inclusion: { in: SCHEMES }
  validates :brand, inclusion: { in: BRANDS }

  attr_accessor :cvc, :number

  def expired?
    return expiration_date < Date.today
  end

end
