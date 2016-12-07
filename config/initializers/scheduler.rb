require 'rufus-scheduler'

ENV['TZ'] = 'America/New_York'
scheduler = Rufus::Scheduler::singleton


scheduler.every '8m' do
  # do stuff
  Score.where(date: DateTime.now.beginning_of_day..DateTime.now.end_of_day).or( Score.where(date: DateTime.new(1999,9,9))).each do |s| 
			if s.hole < 18
				if rand < 0.3
					s.hole +=1
					prob = rand
					if prob < 0.1
						s.score += 2
					elsif prob < 0.2 and prob >= 0.1
						s.score -= 4
					elsif prob < 0.35 and prob >=0.2
						s.score -=3
					elsif prob < 0.5 and prob >=0.35
						s.score += 1
					end
				end
			s.save
			end
		end
end

scheduler.every '7h' do
	Score.all.each do |s|
		s.hole = 0
		s.score = 0
		s.save
	end
end

scheduler.every '2h' do
	@players = Array.new()
	@todaytours = Tournament.where(date: DateTime.now.beginning_of_day..DateTime.now.end_of_day)
	@todaytours.each do |t|
		to= t.name
		date = t.date
		@pid= Player.where(tournament: t.id).pluck(:person_id)
		@pid.each do |pi|
			first = Person.find(pi).firstname
			second = Person.find(pi).lastname
			@players.push(([first+"."+second,to,0,0,date]))
		end
	end
	@players.each do |name,  tournament, score, hole,date|
		Score.create(name: name,  tournament: tournament, score: score, hole: hole,date: date)
	end
end