class UserMailer < Devise::Mailer
  helper :application
  include Devise::Controllers::UrlHelpers
  default template_path: 'devise/mailer'

  default from: 'jessicakoch136@icloud.com'

  def confirmation_instructions
    MyMailer.confirmation_instructions(User.first, "faketoken", {})
  end
end
