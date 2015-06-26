class UsersController < ApplicationController

  def index
    @users = User.by_karma.limit(50)
    @num_pages = User.all.count / 100
  end

  def show
    @num_pages = User.all.count / 100
    if params[:id].nil?
      @current_page = 1
    else
      @current_page = params[:id].to_i
    end
    @users = User.page(@current_page)
  end
end
