class ClientsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :new, :create]
  before_action :set_client, only: [:show]

  def create
    @client = Client.new(client_params)
    if @client.valid?
      @client.save!
      redirect_to client_path(@client)
    else
      render :index
    end
  end

  def index
    @client = Client.new
  end

  def show

    # Taxa-base dinâmica variando com o faturamento mensal da empresa
    if @client.monthly_revenue >= 100000
      @fee_per_ten_days = 1.5
    else
      @client.monthly_revenue > 50000 ? @fee_per_ten_days = 1.65 : @fee_per_ten_days = 1.8
    end

    @due_date_in_days = (Date.today - @client.due_date).to_i.abs

    @times_to_apply_fee = (@due_date_in_days / 10) + 1

    @total_fee = (@fee_per_ten_days * @times_to_apply_fee).round(2)

    @asset_with_descount = (@client.asset_value * ((100 - @total_fee) / 100)).round(2)
  end


  private

    def client_params
      params.require(:client).permit(:name, :email, :company_name, :monthly_revenue, :asset_value, :due_date)
    end

    def set_client
      @client = Client.find(params[:id])
    end

end
