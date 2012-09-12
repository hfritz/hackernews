class UserMailer < ActionMailer::Base
  default :from => "test@paddypower.com"
  
  def send_results(values_hash, test_email)
    @mean = values_hash["mean"]
    @median = values_hash["median"]
    @mode = values_hash["mode"]
    mail(:to => test_email, :subject => "Test results")
  end
end
