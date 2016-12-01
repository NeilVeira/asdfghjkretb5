class TicketMailer < ApplicationMailer

  default from: "andysaladgolferman@gmail.com"

  def ticket_mailer(recipient)
    @person = recipient
    # @tournament = Tournament.find(session[:tournament_id])
    # subject = "Ticket to " + @tournament.name + " happening on " + @tournament.date

    subject = "hi"

    mail(to: @person.user.email, subject: subject)
  end

end
