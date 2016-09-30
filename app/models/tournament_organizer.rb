class TournamentOrganizer < ApplicationRecord
  belongs_to :person
  belongs_to :tournament
end
