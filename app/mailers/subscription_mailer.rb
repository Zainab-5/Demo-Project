class SubscriptionMailer < ApplicationMailer
  def new_subscription_email
    @subscription = params[:subscription]
    mail(to: "zainab.ayaz@devsinc.com", subject: "You got a new order!")
  end
end
