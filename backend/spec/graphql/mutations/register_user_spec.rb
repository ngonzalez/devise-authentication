require "rails_helper"

RSpec.describe Mutations::RegisterUser do
  context "Authentication" do
    it "Register the user" do
      variables = {
        "firstName" => Faker::Name.first_name,
        "lastName" => Faker::Name.last_name,
        "aliasName" => "ALTNAME",
        "email" => Faker::Internet.email,
        "password" => Faker::Internet.password,
      }

      query = GraphQL::Query.new(
        BackendSchema,
        mutation,
        variables: variables.deep_stringify_keys,
        context: {},
      )

      result = query.result

      expect(result.dig("data", "registerUser", "user", "firstName")).to eq(variables["firstName"])
      expect(result.dig("data", "registerUser", "user", "lastName")).to eq(variables["lastName"])
      expect(result.dig("data", "registerUser", "user", "aliasName")).to eq("ALT") # 3 characters
      expect(result.dig("data", "registerUser", "user", "email")).to eq(variables["email"])
      expect(result.dig("data", "registerUser", "user", "authenticationToken")).to be_kind_of(String)
      expect(result.dig("data", "registerUser", "success")).to eq(true)
      expect(result.dig("errors")).to eq(nil)
    end

    it "Does not register the user if invalid params" do
      variables = {
        "email" => Faker::Internet.email,
      }

      query = GraphQL::Query.new(
        BackendSchema,
        mutation,
        variables: variables.deep_stringify_keys,
        context: {},
      )

      result = query.result

      expect(result.dig("data", "registerUser", "user")).to eq(nil)
      expect(result.dig("data", "registerUser", "success")).to eq(nil)
      expect(result.dig("errors").length).to eq(4)
    end
  end

  def mutation
    <<~GQL
      mutation registerUser(
        $firstName: String!,
        $lastName: String!,
        $aliasName: String!,
        $email: String!,
        $password: String!,
      ) {
        registerUser(input: {
          firstName: $firstName,
          lastName: $lastName,
          aliasName: $aliasName,
          email: $email,
          password: $password,
        }) {
          user {
            id
            firstName
            lastName
            aliasName
            email
            authenticationToken
          }
          success
          errors
        }
      }
    GQL
  end
end
