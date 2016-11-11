module TicketHelper
	@@tickettypes = ["","Player","Sponsor","General Admission","Organizer"]
	def get_tickettype_name(tickettype)
		if tickettype < @@tickettypes.length
			return @@tickettypes[tickettype]
		else
			return NIL
		end
	end
end
