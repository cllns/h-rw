module Api
  module Controllers
    module Users
      class Create
        include Api::Action

        params do
          required(:user).schema do
            required(:email).filled(:str?)
            required(:username).filled(:str?)
            required(:password).filled(:str?)
          end
        end

        def call(_params)
          if params.valid?
            self.body = Hash[user: user_hash].to_json
          else
            self.status = 422
            self.body = Hash[errors: params.errors.to_h].to_json
          end
        end

        private

        def user_hash
          UserPresenter.new(create_user).to_hash
        end

        def create_user
          UserRepository.new.create(
            email: params.dig(:user, :email),
            username: params.dig(:user, :username),
            encrypted_password: bcrypted_password
          )
        end

        def bcrypted_password
          BCrypt::Password.create(params.dig(:user, :password))
        end
      end
    end
  end
end
