class City < ApplicationRecord
  # Relations
  has_many :accomodations, dependent: :restrict_with_error

  # Validations
  validates :name, presence: true, uniqueness: true
  
  # Callbacks
  before_save :capitalize_name
  
  private
  
  def capitalize_name
    self.name = name.strip.titleize if name.present?
  end
end
