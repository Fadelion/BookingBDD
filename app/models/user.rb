class User < ApplicationRecord
  # Relations
  has_many :accomodations, dependent: :restrict_with_error
  has_many :bookings, dependent: :restrict_with_error
  has_many :accomodations_as_guest, through: :bookings, source: :accomodation

  # Validations
  validates :email, presence: true, uniqueness: true, 
            format: { with: URI::MailTo::EMAIL_REGEXP, message: "format d'email invalide" }
  validates :telephone, presence: true, 
            format: { with: /\A(?:\+33|0)[1-9](?:[\s.-]?[0-9]{2}){4}\z/, message: "format de téléphone invalide" }
  
  # Callbacks
  before_save :normalize_email
  
  private
  
  def normalize_email
    self.email = email.downcase.strip if email.present?
      
  end
end
