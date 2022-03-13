<template>
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
      <div
        id="navbarSupportedContent"
        class="collapse navbar-collapse">
        <ul
          v-if="signedIn"
          class="navbar-nav">
          <li class="nav-item active">
            <router-link
              :to="{ name: 'edit_user' }"
              class="nav-link">
              {{ userFullName }} ({{ aliasName}})
            </router-link>
          </li>
          <li class="nav-item">
            <router-link
              :to="{ name: 'home' }"
              class="nav-link">
              {{ $t('navbar.home') }}
            </router-link>
          </li>
          <li class="nav-item">
            <a
              class="nav-link"
              href="#"
              @click.prevent="handleSignOut">
              {{ $t('navbar.sign_out') }}
            </a>
          </li>
        </ul>
        <ul
          v-else
          class="navbar-nav">
          <li class="nav-item">
            <router-link
              :to="{ name: 'sign_in' }"
              class="nav-link">
              {{ $t('navbar.sign_in') }}
            </router-link>
          </li>
          <li class="nav-item">
            <router-link
              :to="{ name: 'sign_up' }"
              class="nav-link">
              {{ $t('navbar.register') }}
            </router-link>
          </li>
        </ul>
      </div>
    </div>
  </nav>
</template>

<script>
import _get from 'lodash/get';
import signOut from '../mutations/signOut';
import { mapMutations } from 'vuex';

export default {
  name: 'Navbar',
  methods: {
    ...mapMutations(['clearUser']),
    handleSignOut() {
      signOut({
        apollo: this.$apollo,
        token: this.user.authenticationToken
      }).then(response => _get(response, 'data.signOut', {}))
        .then(response => {
          if (response.success) {
            this.$toast.info(this.$t('navbar.sign_out_success'));
          } else {
            this.$toast.warning(this.$t('navbar.sign_out_failure'));
          }
          this.clearUser();
          this.$router.push({ name: 'sign_in' });
        }).catch(error => {
          this.errors = [error];
        });
    },
  },
};
</script>
