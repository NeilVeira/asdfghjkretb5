require 'rufus-scheduler'

ENV['TZ'] = 'America/New_York'
scheduler = Rufus::Scheduler::singleton


scheduler.every '1m' do
  # do stuff
  Score.all.each do |s| 
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