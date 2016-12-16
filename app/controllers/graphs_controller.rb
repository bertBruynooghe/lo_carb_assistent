class GraphsController < ApplicationController
  def index
    @graphs = Graph.for_week(params[:week])
  end
end
