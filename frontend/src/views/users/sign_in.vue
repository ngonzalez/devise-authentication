<template>
  <div class="row">
    <div class="col-md-6 offset-md-3">
      <hr class="invisible" />
      <h4>{{ $t('users.sign_in.title') }}</h4>
      <form class="simple_form form-horizontal">
        <div class="form-group email optional user_email">
          <label class="control-label email optional">
            {{ $t('users.sign_in.email') }}
          </label>
          <input
            v-model="form.email"
            class="form-control string email optional"
            autofocus="autofocus">
        </div>
        <div class="form-group password optional user_password">
          <label class="control-label password optional">
            {{ $t('users.sign_in.password') }}
          </label>
          <input
            v-model="form.password"
            type="password"
            class="form-control password optional">
        </div>
        <div class="text-center">
          <button
            class="btn btn-default btn btn-primary"
            @click.prevent="handleSignIn">
            {{ $t('users.sign_in.submit') }}
          </button>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import { mapMutations } from 'vuex';
import signIn from '../../mutations/signIn';
import _get from 'lodash/get';

export default {
  name: 'SignInUser',
  data() {
    return {
      errors: [],
      form: {},
    };
  },
  methods: {
    ...mapMutations(['setUser']),
    handleSignIn() {
      signIn({
        apollo: this.$apollo,
        ...this.form,
      }).then(response => _get(response, 'data.signIn', {}))
        .then(response => {
          if (response.success) {
            this.$toast.success(this.$t('users.sign_in.success'));
            this.setUser(response.user);
            this.$router.push({ name: 'home' });
          } else {
            this.$toast.warning(this.$t('users.sign_in.failure'));
            this.errors = this.errorMessages(response.data.signIn.errors);
          }
        }).catch(error => {
          this.$toast.warning(error);
          this.errors = [error];
        });
    },
  },
};
</script>
