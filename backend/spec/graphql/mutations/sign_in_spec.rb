require "rails_helper"

RSpec.describe Mutations::SignIn do
  context "Authentication" do
    it "Sign-in the user" do
      user = create(:user)
      variables = {
        "email" => user.email,
        "password" => user.password,
      }

      query = GraphQL::Query.new(
        BackendSchema,
        mutation,
        variables: variables.deep_stringify_keys,
        context: {},
      )

      result = query.result

      expect(result.dig("data", "signIn", "user", "authenticationToken")).to eq(user.authentication_token)
      expect(result.dig("data", "signIn", "success")).to eq(true)
      expect(result.dig("errors")).to eq(nil)
    end

    it "Does not sign-in the user because of incorrect password" do
      user = create(:user)
      variables = {
        "email" => user.email,
        "password" => "test",
      }

      query = GraphQL::Query.new(
        BackendSchema,
        mutation,
        variables: variables.deep_stringify_keys,
        context: {},
      )

      result = query.result

      expect(result.dig("data", "signIn")).to eq(nil)
      expect(result.dig("data", "signIn", "success")).to eq(nil)
      expect(result.dig("errors").length).to eq(1)
      expect(result.dig("errors").first["message"]).to eq("Invalid E-Mail or Password")
    end

    it "Does not sign-in user that is not found" do
      variables = {
        "email" => "text@example.com",
        "password" => "test",
      }

      query = GraphQL::Query.new(
        BackendSchema,
        mutation,
        variables: variables.deep_stringify_keys,
        context: {},
      )

      result = query.result

      expect(result.dig("data", "signIn")).to eq(nil)
      expect(result.dig("errors").length).to eq(1)
      expect(result.dig("errors").first["message"]).to eq("User not found")
    end
  end

  def mutation
    <<~GQL
      mutation signIn($email: String!, $password: String!) {
        signIn(input: { email: $email, password: $password }) {
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
