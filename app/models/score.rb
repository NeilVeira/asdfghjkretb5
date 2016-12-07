class Score < ApplicationRecord
	validates :name, :tournament, :date, presence: true
	validates_uniqueness_of :name, scope: [:tournament, :date], on: :create
end
