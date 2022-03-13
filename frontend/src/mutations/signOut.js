import gql from 'graphql-tag';

const mutation = gql`
  mutation signOut($token: String!) {
    signOut(input: { token: $token }) {
      success
      errors
    }
  }
`;

export default function signOut({
  apollo,
  token,
}) {
  return apollo.mutate({
    mutation,
    variables: {
      token,
    },
  });
}
