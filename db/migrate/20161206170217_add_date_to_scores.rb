class AddDateToScores < ActiveRecord::Migration[5.0]
  def change
    add_column :scores, :date, :datetime
  end
end
