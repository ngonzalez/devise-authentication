module Mutations
  class SignIn < Mutations::BaseMutation
    graphql_name "SignIn"

    argument :email, String, required: true
    argument :password, String, required: true

    field :user, Types::UserType, null: false

    def resolve(args)
      user = User.find_for_database_authentication(email: args[:email])

      if user.present?
        if user.valid_password?(args[:password])
          MutationResult.call(obj: { user: user }, success: true)
        else
          GraphQL::ExecutionError.new("Invalid E-Mail or Password")
        end
      else
        GraphQL::ExecutionError.new("User not found")
      end
    end
  end
end
