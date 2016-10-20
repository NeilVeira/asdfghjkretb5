class TicketsController < ApplicationController
    def index
    end
    
    def show
        @ticket = Ticket.find(params[:id])
    end
    
    def new
    end
    
    def edit
    end
    
    def create
      @ticket = Ticket.new(params.require(:ticket).permit(:person_id,:tickettype))
      @ticket.save
      render action: "show"
    end
    
    def update
    end
    
    def destroy
    end

end