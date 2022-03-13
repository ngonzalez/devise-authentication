require "rails_helper"

RSpec.describe Mutations::SignOut do
  context "Authentication" do
    it "Sign-out the user" do
      user = create(:user)
      variables = {
        "token": user.authentication_token,
      }

      query = GraphQL::Query.new(
        BackendSchema,
        mutation,
        variables: variables.deep_stringify_keys,
        context: {},
      )

      result = query.result

      expect(result.dig("data", "signOut", "success")).to eq(true)
      expect(result.dig("errors")).to eq(nil)
    end

    it "Does not sign-out the user because of invalid params" do
      user = create(:user)
      variables = {
        "token" => "test",
      }

      query = GraphQL::Query.new(
        BackendSchema,
        mutation,
        variables: variables.deep_stringify_keys,
        context: {},
      )

      result = query.result

      expect(result.dig("data", "signOut", "success")).to eq(false)
      expect(result.dig("errors")).to eq(nil)
    end
  end

  def mutation
    <<~GQL
      mutation signOut($token: String!) {
        signOut(input: { token: $token }) {
          success
          errors
        }
      }
    GQL
  end
end
