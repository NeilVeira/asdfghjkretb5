class RemovePeopleRefFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_reference :users, :person, foreign_key: true
  end
end
