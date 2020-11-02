# frozen_string_literal: true

require 'spec_helper'

module AuthHelper
  def login_user(user_type)
    @request.env['devise.mapping'] = Devise.mappings[:user]
    if user_type == 'Admin'
      user = create(:Admin)
      user.confirm # or set a confirmed_at inside the factory. Only      necessary if you are using the "confirmable" module
      sign_in user
    else
      user = create(:user)
      user.confirm # or set a confirmed_at inside the factory. Only      necessary if you are using the "confirmable" module
      sign_in user
    end
  end
end
