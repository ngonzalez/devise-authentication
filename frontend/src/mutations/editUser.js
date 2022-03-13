import gql from 'graphql-tag';

const mutation = gql`
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
`;

export default function({
  apollo,
  token,
  firstName,
  lastName,
  aliasName,
}) {
  return apollo.mutate({
    mutation,
    variables: {
      token,
      firstName,
      lastName,
      aliasName,
    },
  });
}