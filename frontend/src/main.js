import { ApolloClient, createHttpLink, InMemoryCache } from '@apollo/client/core'
import { createApolloProvider } from '@vue/apollo-option'
import VueApolloComponents from '@vue/apollo-components'

// HTTP connection to the API
const httpLink = createHttpLink({
  // You should use an absolute URL here
  uri: 'http://localhost:3000/graphql',
})

// Cache implementation
const cache = new InMemoryCache()

// Create the apollo client
const apolloClient = new ApolloClient({
  link: httpLink,
  cache,
})

// The provider holds the Apollo client instances that can then be used by all the child components.
const apolloProvider = createApolloProvider({
  defaultClient: apolloClient,
})

/*
  vue-router
*/
import { createRouter, createWebHistory } from 'vue-router'
import routes from './router/index'
// Create the router instance and pass the `routes` option
// You can pass in additional options here, but let's
// keep it simple for now.
const router = createRouter({
  // Provide the history implementation to use. We are using the hash history for simplicity here.
  history: createWebHistory(),
  routes, // short for `routes: routes`
})

/*
  vue
*/
import { createApp, h } from 'vue';
import { VueCookies } from 'vue-cookies';
import VueToast from 'vue-toast-notification';
import UsersStore from './stores/users';
import AppSettings from './configuration/appSettings';
import App from './App.vue';
import { createI18n } from 'vue-i18n'
import messages from './locales/en.json';

const i18n = createI18n({
  // something vue-i18n options here ...
  locale: 'en',
  fallbackLocale: 'en',
  messages: messages,
})

// Create the application
const app = createApp({
  render: () => h(App),
})

app.use(i18n)
app.use(router)
app.use(apolloProvider)
app.use(VueApolloComponents)
app.use(UsersStore)
app.use(VueCookies)
app.use(VueToast)
app.mixin(AppSettings)

// Import CSS
import './assets/base.css';
import 'vue-toast-notification/dist/theme-sugar.css';

document.addEventListener('DOMContentLoaded', () => {
  app.mount('#app')
})
