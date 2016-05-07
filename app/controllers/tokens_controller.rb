class TokensController < ApplicationController

  # TODO Check what to do whith this.
  skip_before_filter :verify_authenticity_token

  def create
    #TODO Upsert the credit card.
    @credit_card = CreditCard.new credit_card_params

    # TODO Build the real token.
    @token = {token: 'temporal token'}

    respond_to do |format|
      # TODO Actually redirect to the token on success.
      format.json { render :show, status: :created }
    end
  end

  private

    def credit_card_params
      params.permit(:owner_name, :number, :cvc,
        :expiration_date, :scheme, :brand)
    end
end
