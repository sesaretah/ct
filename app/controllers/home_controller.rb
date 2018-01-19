class HomeController < ApplicationController
    before_action :authenticate_user!, :except => [:public_key]
  def public_key
    #render layout: false
    @pub_key_ruby = "-----BEGIN DH PARAMETERS-----\nMIIBCAKCAQEA73NoG8jrazIpJat+7c57Pld6UdBI0m6dOYGGArFyfT0PEkx/ViAJ\nfTKE4aOV396EILXQIq9UBoSVX8ikabfvvre3W23LMTYE7ZNnA6uUq/5DImPnHZNz\nXCktjk+YXldl4TaT0Ug2hdVre7Do4PiUq5nXe8vVYxig7KflF0wnjtqN0Bnt5aZz\ntgDhcamaGUIujviMNJnyfBiuvmENw6dj/xAH9H5Z4KFsdJVZQuiYYtk/UQjztycy\nhBN8Cr5uX45oMAWcPMg5ri90kzJcdrncTJbySLJart9aFJ+fNfTVLTEE2Ny+ZMHi\nU2XZ1WUFBVvHyZYtXqo55HUevq+JYtg7cwIBAg==\n-----END DH PARAMETERS-----\n"
    @pub_key_js = "MIIBCAKCAQEA73NoG8jrazIpJat+7c57Pld6UdBI0m6dOYGGArFyfT0PEkx/ViAJ\nfTKE4aOV396EILXQIq9UBoSVX8ikabfvvre3W23LMTYE7ZNnA6uUq/5DImPnHZNz\nXCktjk+YXldl4TaT0Ug2hdVre7Do4PiUq5nXe8vVYxig7KflF0wnjtqN0Bnt5aZz\ntgDhcamaGUIujviMNJnyfBiuvmENw6dj/xAH9H5Z4KFsdJVZQuiYYtk/UQjztycy\nhBN8Cr5uX45oMAWcPMg5ri90kzJcdrncTJbySLJart9aFJ+fNfTVLTEE2Ny+ZMHi\nU2XZ1WUFBVvHyZYtXqo55HUevq+JYtg7cwIBAg=="
    render json: {data: @pub_key_js}
  end

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

  def mobile
    @qrcode = RQRCode::QRCode.new("http://github.com/")
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
