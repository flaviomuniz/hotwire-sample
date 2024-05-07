class EmployeeBelongsToLanguage < ActiveRecord::Migration[7.1]
  def change
    add_reference :employees, :language, null: false, foreign_key: true
  end
end