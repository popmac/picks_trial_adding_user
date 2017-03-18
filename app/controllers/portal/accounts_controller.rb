class Portal::AccountsController < ApplicationController
  def signup
    @token = AccountEmailToken.new
  end

end
