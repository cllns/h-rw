module Api
  module Controllers
    module Users
      class Create
        include Api::Action

        def call(_params)
          self.body = Hash[
            user: user_hash
          ].to_json
        end

        private

        def user_hash
          Hash[
            email: "",
            username: "",
            bio: "",
            image: "",
            token: "",
          ]
        end
      end
    end
  end
end
