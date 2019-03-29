class DosesController < ApplicationController
  def new
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.new
  end

  def create
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.new(dose_params)
    @dose.cocktail = @cocktail
    # raise
    if @dose.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  def destroy
    @dose = Dose.find(params[:id])
    @cocktail = @dose.cocktail
    @dose.destroy
    redirect_to @cocktail
  end

  private

  def dose_params
    params.require(:dose).permit(:description, :ingredient_id)
  end
end



# @cocktail = => #<Cocktail id: 8, name: "Pink Gin", created_at: "2019-03-28 06:39:08", updated_at: "2019-03-28 06:39:08">
# @dose =  #<Dose id: nil, cocktail_id: nil, ingredient_id: 801, description: "4 oz", created_at: nil, updated_at: nil>

# @dose.cocktail = @cocktail
#<Dose id: nil, cocktail_id: 8, ingredient_id: 801, description: "4 oz", created_at: nil, updated_at: nil>
