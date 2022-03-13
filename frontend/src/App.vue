
<template>
  <div>
    <div class="wrapper">
      <Navbar></Navbar>
      <main class="container content">
        <div class="row">
          <div class="col-md-10 offset-md-1">
            <router-view/>
          </div>
        </div>
      </main>
    </div>
  </div>
</template>

<script>
import Navbar from './components/Navbar.vue';
export default {
  name: 'ApplicationRootComponent',
  components: { Navbar },
};
</script>
