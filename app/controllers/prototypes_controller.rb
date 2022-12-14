class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:create,:edit,:new,:destroy,:update]

  def index 
    @users = User.all
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      @prototype = Prototype.new(prototype_params)
      render :new
    end
  end

  def edit
    @prototype = Prototype.find(params[:id])
    unless user_signed_in? && current_user.id == @prototype.user.id
      redirect_to action: :index
    end 
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def update
       @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path
    else
      @prototype = Prototype.find(params[:id])
      render :edit
    end
  end

  def destroy
    @destroy = Prototype.find(params[:id])
    @destroy.destroy
    redirect_to root_path
  end

  
  private
  def prototype_params
    params.require(:prototype).permit(:image, :title, :catch_copy, :concept).merge(user_id: current_user.id)
   
  end 

end
