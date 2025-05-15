class Booking < ApplicationRecord
  belongs_to :accomodation
  belongs_to :user

  # Attribut virtuel pour la durée
  attr_readonly :duree
  
  # Validations
  validates :start_date, :end_date, :amount_total, presence: true
  validates :amount_total, numericality: { greater_than: 0 }
  validate :end_date_after_start_date
  validate :no_overlapping_bookings, on: :create
  validate :not_own_accomodation

  # Callbacks
  before_validation :calculate_total_amount, if: :dates_changed?
  
  # Méthodes d'instance
  def duree
    return 0 unless end_date && start_date
    (end_date - start_date).to_i
  end
  
  private
  
  def end_date_after_start_date
    return if start_date.blank? || end_date.blank?
    
    if end_date <= start_date
      errors.add(:end_date, "doit être postérieure à la date de début")
    end
  end
  
  def no_overlapping_bookings
    return if accomodation.nil? || start_date.nil? || end_date.nil?
    
    overlapping_bookings = accomodation.bookings
                                      .where.not(id: id)
                                      .where.not("end_date <= ? OR start_date >= ?", end_date, start_date)
    
    if overlapping_bookings.exists?
      errors.add(:base, "Le logement est déjà réservé pour cette période")
    end
  end
  
  def not_own_accomodation
    return if accomodation.nil? || user.nil?
    
    if accomodation.user_id == user_id
      errors.add(:base, "Vous ne pouvez pas réserver votre propre logement")
    end
  end
  
  def calculate_total_amount
    return if accomodation.nil? || start_date.nil? || end_date.nil?
    
    self.amount_total = accomodation.price_night * duree
  end
  
  def dates_changed?
    start_date_changed? || end_date_changed? || accomodation_id_changed?
  end
end
