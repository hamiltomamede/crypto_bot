# This modules enables active engine in models to avoid destroy from database
module Active
  extend ActiveSupport::Concern
  extend ActiveModel::Callbacks

  def self.included(base)
    base.class_eval do
      default_scope { where(active: true) }
      define_model_callbacks :deny, only: %i[before after]
      define_model_callbacks :allow, only: %i[before after]
    end
  end

  def activated?
    active == true
  end

  def deactivated?
    active == false
  end

  def deny
    run_callbacks :deny do
      self.active = false
      true
    end
  end

  def allow
    self.active = true
    true
  end
end
