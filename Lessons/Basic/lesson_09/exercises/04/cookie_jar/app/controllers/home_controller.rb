class HomeController < ApplicationController
  def set_cookies
    cookies[:user_name]       = "Smith"
    cookies[:customer_number] = "1234567890"
  end

  def show_cookies
    @user_name = cookies[:user_name]
    @customer_number = cookies[:customer_number]
  end

  def delete_cookies
    cookies.delete :user_name
    cookies.delete :customer_number
  end
end
