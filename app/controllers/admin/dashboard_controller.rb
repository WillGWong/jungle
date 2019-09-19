class Admin::DashboardController < ApplicationController
  def show
    @product = Product.all.count
    @category = Category.all.count
  end
end
