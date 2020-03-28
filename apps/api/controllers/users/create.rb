module Api
  module Controllers
    module Users
      class Create
        include Api::Action

        def call(_params)
          self.body = '{}'
        end
      end
    end
  end
end
