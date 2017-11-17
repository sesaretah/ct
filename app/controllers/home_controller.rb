class HomeController < ApplicationController
  def graph
    @nodes = JSON.parse '[' + Graph.last.nodes.gsub(/'/, "\"") + ']'
    if Graph.last.edges.gsub(/'/, "\"")[-1] == ','
      @edges = JSON.parse '[' + Graph.last.edges.gsub(/'/, "\"").chop + ']'
    else
      @edges = JSON.parse '[' + Graph.last.edges.gsub(/'/, "\"") + ']'
    end
    @n = {}
    for n in @nodes
      @n[n['name']] = { 'id' => n['id'], 'type' => n['type'], 'title' => n['title'], 'href' => n['href'], 'active' => true}
    end
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
