class PagesController < ApplicationController
  include PublicIndex
  skip_before_action :authenticate_user!, only: [:about]

  def index
    @purchases = Purchase.order('created_at DESC').limit(8)
  end

  def about
  end
end
