class NewApartmentMailer < ActionMailer::Base

  def sendout(apartment:, recipients:, area:)
    mail(to: recipients, subject: "Novi stan na #{area}: #{apartment.name}", from: 'damir.svrtan@gmail.com') do |format|
      format.html { render html: "<a href=#{apartment.link}>#{apartment.name}</a>".html_safe }
    end
  end

end
