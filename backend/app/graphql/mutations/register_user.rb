module Mutations
  class RegisterUser < Mutations::BaseMutation
    graphql_name "RegisterUser"

    argument :first_name, String, required: true
    argument :last_name, String, required: true
    argument :alias_name, String, required: true
    argument :email, String, required: true
    argument :password, String, required: true

    field :user, Types::UserType, null: false

    def resolve(args)
      begin
        user = User.create!(
          first_name: args[:first_name],
          last_name: args[:last_name],
          alias_name: args[:alias_name],
          email: args[:email],
          password: args[:password],
        )

        MutationResult.call(
          obj: { user: user },
          success: user.persisted?,
          errors: user.errors,
        )
      rescue ActiveRecord::RecordInvalid => exception
        GraphQL::ExecutionError.new(exception.message)
      end
    end
  end
end
