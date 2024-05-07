# rubocop:disable all

class Employee < ApplicationRecord
  # Associations
  belongs_to :language

  # Defines the attributes that can be searched using the Ransack gem
  def self.ransackable_attributes(*)
    %w[status created_at email name id updated_at]
  end

  # Defines the associations that can be included in Ransack search queries
  def self.ransackable_associations(*)
    %w[language]
  end
end
