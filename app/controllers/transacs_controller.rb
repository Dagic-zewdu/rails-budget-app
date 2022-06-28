class TransacsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_transac, only: %i[show edit update destroy]

  # GET /transacs or /transacs.json
  def index
    @transacs = Transac.where(user: current_user)
  end

  # GET /transacs/new
  def new
    @transac = Transac.new
    @categories = Category.where(user: current_user)
  end

  # POST /transacs or /transacs.json
  def create
    @transac = Transac.new(transac_params)
    @transac.user = current_user
    @transac.save
    create_cat_transacs unless params[:categories].blank?
    respond_to do |format|
      if @transac.persisted?
        if @transac.categories.blank?
          @transac.destroy
          format.html { redirect_to new_transac_path, alert: 'Transaction must have at least one category.' }
        else
          format.html do
            redirect_to category_url(@transac.categories.first), notice: 'Transaction was successfully created.'
          end
        end
      else
        format.html { redirect_to new_transac_path, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_transac
    @transac = Transac.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def transac_params
    params.require(:transac).permit(:name, :amount)
  end

  def create_cat_transacs
    params[:categories].each do |k, _v|
      CategoryTransac.create(category: Category.find(k), transac: @transac)
    end
  end
end