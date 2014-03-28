class ProductsController < ApplicationController
  def index
    @products = Product.published

    respond_to do |format|
      format.html
    end
  end

  def show
    @product = Product.friendly.find params[:id]

    respond_to do |format|
      format.html
    end
  end
end
