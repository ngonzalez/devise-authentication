module Types
  class UserType < Types::BaseObject
    graphql_name "User"

    implements GraphQL::Types::Relay::Node
    global_id_field :id

    field :last_name, String, null: false
    field :first_name, String, null: false
    field :alias_name, String, null: false
    field :email, String, null: false
    field :authentication_token, String, null: false
  end
end
