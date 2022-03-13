<template>
  <div class="row">
    <div class="col-md-6 offset-md-3">
      <hr class="invisible" />
      <h4>
        {{ $t('users.register.title') }}
      </h4>
      <form class="simple_form form-horizontal">
        <div class="form-group">
          <label class="control-label">
            {{ $t('users.register.first_name') }}
          </label>
          <input
            v-model="form.firstName"
            class="form-control string"
            autofocus="autofocus">
        </div>
        <div class="form-group ">
          <label class="control-label">
            {{ $t('users.register.last_name') }}
          </label>
          <input
            v-model="form.lastName"
            class="form-control string"
            autofocus="autofocus">
        </div>
        <div class="form-group">
          <label class="control-label">
            {{ $t('users.register.alias_name') }}
          </label>
          <input
            v-model="form.aliasName"
            class="form-control string"
            autofocus="autofocus"
            maxlength="3"
            @input="upper($event)">
        </div>
        <div class="form-group">
          <label class="control-label email">
            {{ $t('users.register.email') }}
          </label>
          <input
            v-model="form.email"
            class="form-control string email"
            autofocus="autofocus">
        </div>
        <div class="form-group password">
          <label class="control-label password">
            {{ $t('users.register.password') }}
          </label>
          <input
            v-model="form.password"
            type="password"
            class="form-control password">
        </div>
        <div class="text-center">
          <button
            class="btn btn-default btn btn-primary"
            @click.prevent="handleRegisterUser">
            {{ $t('users.register.submit') }}
          </button>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import { mapMutations } from 'vuex';
import registerUser from '../../mutations/registerUser';
import { AUTH_TOKEN_KEY } from '../../configuration/appConstants';
import _get from 'lodash/get';
export default {
  name: 'RegisterUser',
  data() {
    return {
      errors: [],
      form: {},
    };
  },
  methods: {
    ...mapMutations(['registerUser']),
    upper(e) {
      e.target.value = e.target.value.toUpperCase()
    },
    handleRegisterUser() {
      registerUser({
        apollo: this.$apollo,
        ...this.form,
      }).then(response => _get(response, 'data.registerUser', {}))
      .then(response => {
        if (response.success) {
          let user = response.user;
          localStorage.setItem(AUTH_TOKEN_KEY, user.authenticationToken);
          this.registerUser(user);
          this.$router.push({ name: 'home' });
          this.$toast.info(this.$t('users.register.success'));
        } else {
          this.$toast.warning(this.$t('users.register.failure'));
          this.errors = this.errorMessages(response.data.registerUser.errors);
        }
      }).catch(error => {
        this.$toast.warning(error);
        this.errors = [error];
      });
    },
  },
};
</script>
