# frozen_string_literal: true

class SubscriptionMailer < ApplicationMailer
  def new_subscription_email
    @subscription = params[:subscription]
    mail(to: 'zainabayaz59@gmail.com', subject: 'You got a new order!')
  end
end
