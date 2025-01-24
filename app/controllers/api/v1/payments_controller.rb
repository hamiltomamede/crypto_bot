module Api
    module V1
class PaymentsController < ApplicationController
    skip_before_action :authenticate_request, only: [ :webhook ]

    def create_subscription
      subscription = StripeService.create_subscription(@current_user, params[:plan])
      if subscription
        render json: { subscription: subscription }, status: :ok
      else
        render json: { error: "Failed to create subscription" }, status: :unprocessable_entity
      end
    end

    def cancel_subscription
      success = StripeService.cancel_subscription(@current_user)
      if success
        render json: { message: "Subscription cancelled successfully" }
      else
        render json: { error: "Failed to cancel subscription" }, status: :unprocessable_entity
      end
    end

    def webhook
      StripeService.handle_webhook(request)
      head :ok
    end
end
    end
end
