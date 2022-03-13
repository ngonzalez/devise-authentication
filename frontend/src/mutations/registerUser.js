import gql from 'graphql-tag';

const mutation = gql`
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
`;

export default function({
  apollo,
  firstName,
  lastName,
  aliasName,
  email,
  password,
}) {
  return apollo.mutate({
    mutation,
    variables: {
      firstName,
      lastName,
      aliasName,
      email,
      password,
    },
  });
}