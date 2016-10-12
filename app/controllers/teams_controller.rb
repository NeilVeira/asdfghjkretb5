class TeamsController < ApplicationController
   def index
      @teams = Team.all
   end

   def show 
      @team = Team.find(params[:id])
   end

   def new 
   end
 
   def edit
      @team = Team.find(params[:id])

   end
  
   def create
      @team = Team.new(team_params)
      @team.save
      redirect_to @team
   end

   def update
      @team = Team.find(params[:id])
      @team.update(team_params)
      redirect_to @team
   end
 
   def destroy 
      @team = Team.find(params[:id])
      @team.destroy
      redirect_to teams_path
   end


   private 
      def team_params
         params.require(:team).permit(:name, :tournament_id)
      end 
end
