module Api
  module Controllers
    module Sessions
      class Create
        include Api::Action

        params do
          required(:user).schema do
            required(:email).filled(:str?)
            required(:password).filled(:str?)
          end
        end

        def call(params)
          if params.valid?
            self.body = Hash[user: user_hash].to_json
          else
            self.status = 422
            self.body = Hash[errors: params.errors.to_h].to_json
          end
        end

        private

        def user_hash
          UserPresenter.new(retrieve_user).to_hash
        end

        def retrieve_user
          UserRepository.new.find_by_email_and_password(
            email: params.dig(:user, :email),
            password: params.dig(:user, :password)
          )
        end
      end
    end
  end
end
