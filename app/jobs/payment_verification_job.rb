class PaymentVerificationJob < ApplicationJob
    queue_as :default

    def perform
      User.joins(:payments).each do |user|
        unless PaymentService.new(user).active_subscription?
          user.bots.update_all(status: :paused)
        end
      end
    end
end
