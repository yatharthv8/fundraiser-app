<template>
  <div id="app">
    <page-header></page-header>
    <router-view></router-view>
    <page-footer></page-footer>
  </div>
</template>

<script>
import PageHeader from "./components/Header.vue";
import PageFooter from "./components/Footer.vue";

export default {
  components: { PageHeader, PageFooter },
};
</script>

<style scoped>
#app {
  margin-left: 2rem;
  margin-right: 2rem;
}
</style>
