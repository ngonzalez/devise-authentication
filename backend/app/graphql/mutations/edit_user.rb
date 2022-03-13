module Mutations
  class EditUser < Mutations::BaseMutation
    graphql_name "EditUser"

    argument :token, String, required: true
    argument :first_name, String, required: true
    argument :last_name, String, required: true
    argument :alias_name, String, required: true

    field :user, Types::UserType, null: false

    def resolve(args)
      user = User.find_by(authentication_token: args[:token])
      if user.present?
        begin
          success = user.update!(
            first_name: args[:first_name],
            last_name: args[:last_name],
            alias_name: args[:alias_name],
          )

          MutationResult.call(
            obj: { user: user },
            success: success,
            errors: user.errors,
          )
        rescue ActiveRecord::RecordInvalid => exception
          GraphQL::ExecutionError.new(exception.message)
        end
      else
        GraphQL::ExecutionError.new("Invalid user parameters")
      end
    end
  end
end
