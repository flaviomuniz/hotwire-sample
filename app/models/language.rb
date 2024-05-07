# rubocop:disable all

class Language < ApplicationRecord
  # Association with Employee model. Destroy associated employees when a language is deleted.
  has_many :employees, dependent: :destroy

  # Defines the attributes that can be searched using the Ransack gem
  def self.ransackable_attributes(*)
    %["name"]
  end
end
