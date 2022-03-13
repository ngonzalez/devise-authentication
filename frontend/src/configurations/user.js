import _isEmpty from 'lodash/isEmpty';
import { mapGetters } from 'vuex';

export default {
  computed: {
    ...mapGetters(['user']),
    signedIn() {
      return !_isEmpty(this.user)
    },
    userFullName() {
      return `${this.user.firstName} ${this.user.lastName}`;
    },
    aliasName() {
      return `${this.user.aliasName}`
    }
  },
};
