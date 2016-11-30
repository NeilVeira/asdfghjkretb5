class AddCheckInToTickets < ActiveRecord::Migration[5.0]
  def change
    add_column :tickets, :checked_in, :boolean
    add_column :tickets, :has_paid, :boolean
  end
end
