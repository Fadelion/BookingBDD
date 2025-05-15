class Accomodation < ApplicationRecord
  # Relations
  belongs_to :city
  belongs_to :user
  has_many :bookings, dependent: :restrict_with_error
  has_many :guests, through: :bookings, source: :user

  # Validations
  validates :numb_beds, presence: true, numericality: { greater_than: 0, only_integer: true }
  validates :price_night, presence: true, numericality: { greater_than: 0 }
  validates :description, presence: true
  validates :welcome_word, presence: true
  
  # La colonne wifi est un booléen, pas besoin de validation spécifique
  
  # Scopes utiles
  scope :with_wifi, -> { where(wifi: true) }
  scope :in_city, ->(city_id) { where(city_id: city_id) }
  scope :by_price, ->(min, max) { where(price_night: min..max) if min.present? && max.present? }

  # Méthodes d'instance pour vérifier la disponibilité
  def available?(start_date, end_date)
    return false unless start_date < end_date
    
    bookings.where.not("start_date <= ? OR end_date >= ?", start_date, end_date).none?
  end
  
  def unavailable_dates
    bookings.pluck(:start_date, :end_date).map do |starting, ending|
      (starting..ending).to_a
    end.flatten.uniq
  end
end
