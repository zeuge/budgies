class MainController < ApplicationController
  def index
    render component: "Farm"
  end
end
