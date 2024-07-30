class EventMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def participation_email(attendance)
    @attendance = attendance
    @event = @attendance.event
    @user = @event.user
    mail(to: @user.email, subject: 'New Participant for Your Event')
  end
end