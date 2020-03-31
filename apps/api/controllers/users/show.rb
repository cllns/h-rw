module Api
  module Controllers
    module Users
      class Show
        include Api::Action

        def call(_params)
          self.body = Hash["Token" => authorization_token].to_json
        end

        private

        def authorization_token
          params.env["HTTP_AUTHORIZATION"]
        end
      end
    end
  end
end
