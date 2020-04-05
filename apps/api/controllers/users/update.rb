module Api
  module Controllers
    module Users
      class Update
        include Api::Action

        before :authenticate!

        params do
          required(:user).schema do
            optional(:email).filled(:str?)
            optional(:username).filled(:str?)
            optional(:password).filled(:str?)
            optional(:bio).maybe(:str?)
            optional(:image).maybe(:str?)
          end
        end

        def call(_params)
          if params.valid?
            self.body = Hash[user: update_user.to_hash].to_json
          else
            self.status = 400
            self.body = Hash[errors: params.errors.to_h].to_json
          end
        end

        private

        def update_user
          UserPresenter.new(
            UserRepository.new.update(current_user_id, params[:user])
          )
        end
      end
    end
  end
end
