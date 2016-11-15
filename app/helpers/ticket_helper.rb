module TicketHelper
	@@tickettypes = ["","Player","Sponsor","General Admission","Organizer"]
	def get_tickettype_name(tickettype)
		if tickettype < @@tickettypes.length
			return @@tickettypes[tickettype]
		else
			return NIL
		end
	end

	def get_price(ticket)
		case ticket.tickettype
			when 1
				return Tournament.where(id: @ticket.tournament_id).first.pricePlayer
			when 2
				return Tournament.where(id: @ticket.tournament_id).first.priceSpectator
			else
				return -5 #test
		end
	end
end
