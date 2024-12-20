# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    User.create!(name: "Test User")
    @users = User.all
    render "home/index"
  end
end
