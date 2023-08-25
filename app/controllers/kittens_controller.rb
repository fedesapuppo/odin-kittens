class KittensController < ApplicationController
  def index
    @kittens = Kitten.all
    respond_to do |format|
      format.html
      format.json { render json: @kittens }
    end
  end

  def show
    @kitten = Kitten.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @kitten }
    end
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
    respond_to do |format|
      format.html
      format.json { render json: @kittens }
    end
  end

  def update
    @kitten = Kitten.find(params[:id])
    if @kitten.update(kitten_params)
      flash[:success] = "Kitten updated successfully!"
      respond_to do |format|
        format.html { redirect_to @kitten }
        format.json { render json: @kitten, status: :ok }
      end
    else
      flash[:error] = "Error updating kitten. Please check the form."
      respond_to do |format|
        format.html { render "edit" }
        format.json { render json: { error: "Error updating kitten. Please check the data." }, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @kitten = Kitten.find(params[:id])
    @kitten.destroy
    flash[:success] = "Kitten deleted successfully!"
    redirect_to kittens_path
    respond_to do |format|
      format.html
      format.json { render json: @kittens }
    end
  end

  def edit
    @kitten = Kitten.find(params[:id])
  end

  private

  def kitten_params
    params.require(:kitten).permit(:name, :age, :cuteness, :softness)
  end
end
