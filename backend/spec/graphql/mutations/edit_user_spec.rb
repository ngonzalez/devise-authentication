require "rails_helper"

RSpec.describe Mutations::EditUser do
  context "Authentication" do
    it "Edit the user" do
      user = create(:user)
      variables = {
        "firstName" => "First Name",
        "lastName" => "Last Name",
        "aliasName" => "Alt. Name",
        "token" => user.authentication_token,
      }

      query = GraphQL::Query.new(
        BackendSchema,
        mutation,
        variables: variables.deep_stringify_keys,
        context: {},
      )

      result = query.result

      expect(result.dig("data", "editUser", "user", "firstName")).to eq("First Name")
      expect(result.dig("data", "editUser", "user", "lastName")).to eq("Last Name")
      expect(result.dig("data", "editUser", "user", "aliasName")).to eq("ALT") # 3 characters
      expect(result.dig("data", "editUser", "user", "authenticationToken")).not_to eq(user.authentication_token) # token changes
      expect(result.dig("data", "editUser", "success")).to eq(true)
      expect(result.dig("data", "editUser", "errors")).to eq([])
    end

    it "Does not edit the user if invalid params" do
      user = create(:user)
      variables = {
        "token" => user.authentication_token,
      }

      query = GraphQL::Query.new(
        BackendSchema,
        mutation,
        variables: variables.deep_stringify_keys,
        context: {},
      )

      result = query.result

      expect(result.dig("data", "editUser", "user")).to eq(nil)
      expect(result.dig("data", "editUser", "success")).to eq(nil)
      expect(result.dig("errors").length).to eq(3)
    end
  end

  def mutation
    <<~GQL
      mutation editUser(
        $token: String!,
        $firstName: String!,
        $lastName: String!,
        $aliasName: String!,
      ) {
        editUser(input: {
          token: $token
          firstName: $firstName,
          lastName: $lastName,
          aliasName: $aliasName,
        }) {
          user {
            id
            firstName
            lastName
            aliasName
            authenticationToken
          }
          success
          errors
        }
      }
    GQL
  end
end
