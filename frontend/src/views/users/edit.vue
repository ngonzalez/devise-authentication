<template>
  <div class="row">
    <div class="col-md-6 offset-md-3">
      <hr class="invisible" />
      <h4>
        {{ $t('users.edit.title') }}
      </h4>
      <form class="simple_form form-horizontal">
        <div class="form-group">
          <label class="control-label">
            {{ $t('users.edit.first_name') }}
          </label>
          <input
            v-model="user.firstName"
            class="form-control string"
            autofocus="autofocus">
        </div>
        <div class="form-group">
          <label class="control-label">
            {{ $t('users.edit.last_name') }}
          </label>
          <input
            v-model="user.lastName"
            class="form-control string"
            autofocus="autofocus">
        </div>
        <div class="form-group">
          <label class="control-label">
            {{ $t('users.register.alias_name') }}
          </label>
          <input
            v-model="user.aliasName"
            class="form-control string"
            autofocus="autofocus"
            maxlength="3"
            @input="upper($event)">
        </div>
        <div class="text-center">
          <button
            class="btn btn-default btn btn-primary"
            @click.prevent="handleEdit">
            {{ $t('users.edit.submit') }}
          </button>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import { mapMutations } from 'vuex';
import editUser from '../../mutations/editUser';
import { AUTH_TOKEN_KEY } from '../../configuration/appConstants';
import _get from 'lodash/get';
export default {
  name: 'EditUser',
  data() {
    return {
      errors: [],
      form: {},
    };
  },
  methods: {
    ...mapMutations(['editUser']),
    upper(e) {
      e.target.value = e.target.value.toUpperCase()
    },
    handleEdit() {
      editUser({
        apollo: this.$apollo,
        token: localStorage.getItem(AUTH_TOKEN_KEY),
        firstName: this.user.firstName,
        lastName: this.user.lastName,
        aliasName: this.user.aliasName,
      }).then(response => _get(response, 'data.editUser', {}))
      .then(response => {
        if (response.success) {
          let user = response.user;
          localStorage.setItem(AUTH_TOKEN_KEY, user.authenticationToken);
          this.editUser(user);
          this.$router.push({ name: 'home' });
          this.$toast.success(this.$t('users.edit.success'));
        } else {
          this.$toast.warning(this.$t('users.edit.failure'));
          this.errors = this.errorMessages(response.data.editUser.errors);
        }
      }).catch(error => {
        this.$toast.warning(error);
        this.errors = [error];
      });
    },
  },
};
</script>
