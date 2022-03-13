module Mutations
  class SignOut < Mutations::BaseMutation
    graphql_name "SignOut"

    argument :token, String, required: true

    field :user, Types::UserType, null: false

    def resolve(args)
      user = User.find_by(authentication_token: args[:token])
      success = user.present? && user.reset_authentication_token!

      MutationResult.call(
        success: success,
        errors: [],
      )
    rescue
      GraphQL::ExecutionError.new("Could not sign out user")
    end
  end
end
