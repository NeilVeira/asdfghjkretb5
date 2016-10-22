class AddTournamentToTickets < ActiveRecord::Migration[5.0]
  def change
    add_reference :tickets, :tournament, foreign_key: true
  end
end
