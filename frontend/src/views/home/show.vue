<template>
  <div>
    <hr class="invisible" />
    <h4>{{ $t('home.title') }}</h4>
    <div v-if="signedIn">
      <div>{{ $t('home.content') }}</div>
    </div>
    <div v-else>
      <h1>{{ $t('home.not_signed_in') }}</h1>
    </div>
  </div>
</template>

<script>
export default {
  name: 'HomeShow',
};
</script>
