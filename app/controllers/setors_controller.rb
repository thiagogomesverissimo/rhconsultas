class SetorsController < ApplicationController
  before_filter :check_logged

  # GET /setors
  # GET /setors.json
  def index
    @setors = Setor.all.where(codund: 42)

    respond_to do |format|
      format.html
      format.xlsx
    end

  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def setor_params
      params.require(:setor).permit(:codund)
    end
end
