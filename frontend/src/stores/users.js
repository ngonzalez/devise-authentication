import { createStore } from "vuex";
import createPersistedState from 'vuex-persistedstate';

export default createStore({
  state: {
    user: {},
  },
  getters: {
    user: state => {
      return state.user;
    },
  },
  actions: {
    signIn(context, user) {
      context.commit('signIn', user);
    },
    signOut(context) {
      context.commit('signOut');
    },
    editUser(context, user) {
      context.commit('editUser', user);
    },
    registerUser(context, user) {
      context.commit('registerUser', user);
    },
  },
  plugins: [
    createPersistedState({
      getState: (key) => {
        return $cookies.get(key);
      },
      setState: (key, state) => {
        $cookies.set(key, state, { expires: 1 });
      },
    }),
  ],
  mutations: {
    signIn(state, user) {
      state.user = user;
    },
    signOut(state) {
      state.user = {};
    },
    editUser(state, user) {
      state.user = user;
    },
    registerUser(state, user) {
      state.user = user;
    },
  }
})
