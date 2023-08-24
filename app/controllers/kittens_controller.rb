class KittensController < ApplicationController
  def index
    @kittens = Kitten.all
  end

  def show
    @kitten = Kitten.find(params[:id])
  end

  def new
    @kitten = Kitten.new
  end

  def create
    @kitten = Kitten.new(kitten_params)
    if @kitten.save
      flash[:success] = "Kitten added successfully!"
      redirect_to @kitten
    else
      flash[:error] = "Error adding kitten. Please check the form."
      render "new"
    end
  end

  def update
    @kitten = Kitten.find(params[:id])
    if @kitten.update(kitten_params)
      flash[:success] = "Kitten updated successfully!"
      redirect_to @kitten
    else
      flash[:error] = "Error updating kitten. Please check the form."
      render "edit"
    end
  end

  def destroy
    @kitten = Kitten.find(params[:id])
    @kitten.destroy
    flash[:success] = "Kitten deleted successfully!"
    redirect_to kittens_path
  end

  def edit
    @kitten = Kitten.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @kitten } # Handle JSON response
    end
  end

  private

  def kitten_params
    params.require(:kitten).permit(:name, :age, :cuteness, :softness)
  end
end
