class PaymentService
    def initialize(user)
      @user = user
    end

    def active_subscription?
      @user.payments.where("expires_at > ?", Time.current).exists?
    end
end
