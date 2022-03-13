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
    setUser(context, user) {
      context.commit('setUser', user);
    },
    clearUser(context) {
      context.commit('clearUser');
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
    setUser(state, user) {
      state.user = user;
    },
    clearUser(state) {
      state.user = {};
    },
  }
})
