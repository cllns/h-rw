module Api
  module Controllers
    module Users
      class Show
        include Api::Action

        def call(_params)
          self.body = Hash[user: user_hash].to_json
        end

        private

        def user_hash
          UserPresenter.new(UserRepository.new.find(current_user_id)).to_hash
        end
      end
    end
  end
end
