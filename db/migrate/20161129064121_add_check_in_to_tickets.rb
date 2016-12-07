class AddCheckInToTickets < ActiveRecord::Migration[5.0]
  def change
    add_column :tickets, :checked_in, :boolean, :default => false
    add_column :tickets, :has_paid, :boolean, :default => false
  end
end
