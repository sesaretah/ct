class HomeController < ApplicationController
  def graph
    #render layout: false
  end

  def logs

  end
  def index
  end
  def registeration_steps
    render layout: "layouts/devise"
    @profile = Profile.new
  end
end
