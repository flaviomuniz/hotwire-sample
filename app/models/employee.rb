class Employee < ApplicationRecord
  belongs_to :language

  def self.ransackable_attributes(auth_object = nil)
    ["status", "created_at", "email", "name", "id", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["language"]
  end
end
