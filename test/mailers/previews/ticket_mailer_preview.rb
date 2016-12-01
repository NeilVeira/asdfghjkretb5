# Preview all emails at http://localhost:3000/rails/mailers/example_mailer
class TicketMailerPreview < ActionMailer::Preview
  def sample_mail_preview
    TicketMailer.ticket_mailer(Person.first)
  end
end