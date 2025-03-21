module Identity::UserScoped
  extend ActiveSupport::Concern

  included do
    before_action :set_user
  end

  private

    def set_user
      @user = Current.user
    end
end
