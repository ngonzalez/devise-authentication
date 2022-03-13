// Apollo
import { ApolloClient, createHttpLink, InMemoryCache } from '@apollo/client/core';
import { createApolloProvider } from '@vue/apollo-option';
import VueApolloComponents from '@vue/apollo-components';

// Router
import { createRouter, createWebHistory } from 'vue-router';
import routes from './router/index';

// Vue
import { createApp, h } from 'vue';

// VueCookies
import { VueCookies } from 'vue-cookies';

// Store
import Store from './stores/store';

// Configuration
import UserConfiguration from './configurations/user';

// VueToastNotification
import VueToast from 'vue-toast-notification';

// i18n
import { createI18n } from 'vue-i18n';
import messages from './locales/en.json';

// Vuetify
// https://next.vuetifyjs.com/en/
import { createVuetify } from 'vuetify';
import * as components from 'vuetify/components';
import * as directives from 'vuetify/directives';
import colors from 'vuetify/lib/util/colors'

// Import CSS
import 'vuetify/styles'; // Global CSS has to be imported
import '@mdi/font/css/materialdesignicons.css'; // Ensure you are using css-loader
import 'vue-toast-notification/dist/theme-sugar.css';
import './assets/base.css';

// Application
import App from './App.vue';

// HTTP connection to the API
const httpLink = createHttpLink({
  // You should use an absolute URL here
  uri: 'http://localhost:3000/graphql',
});

// Cache implementation
const cache = new InMemoryCache();

// Create the apollo client
const apolloClient = new ApolloClient({
  link: httpLink,
  cache,
});

// The provider holds the Apollo client instances that can then be used by all the child components.
const apolloProvider = createApolloProvider({
  defaultClient: apolloClient,
});
// Create the router instance and pass the `routes` option
// You can pass in additional options here, but let's
// keep it simple for now.
const Router = createRouter({
  // Provide the history implementation to use. We are using the hash history for simplicity here.
  history: createWebHistory(),
  routes, // short for `routes: routes`
});

const i18n = createI18n({
  // something vue-i18n options here ...
  locale: 'en',
  fallbackLocale: 'en',
  messages,
});

const Vuetify = createVuetify({
  components,
  directives,
  icons: {
    iconfont: 'mdiSvg',
  },
  theme: {
    dark: true,
    defaultTheme: 'dark'
  },
});

// Create the application
const app = createApp({
  render: () => h(App),
});

app.use(i18n);
app.use(Router);
app.use(apolloProvider);
app.use(VueApolloComponents);
app.use(Vuetify);
app.use(Store);
app.use(VueCookies);
app.use(VueToast);
app.mixin(UserConfiguration);

document.addEventListener('DOMContentLoaded', () => {
  app.mount('#app');
});
