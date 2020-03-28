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
          Hash[
            email: params.dig(:user, :email),
            username: params.dig(:user, :username),
            bio: "",
            image: "",
            token: "",
          ]
        end
      end
    end
  end
end
