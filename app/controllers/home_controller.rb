class HomeController < ApplicationController
  def index
  end
  def registeration_steps
    render layout: "layouts/devise"
    @profile = Profile.new
  end
end
