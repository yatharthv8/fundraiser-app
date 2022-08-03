<template>
  <div>
    <nav class="navbar navbar-dark bg-dark extras">
      <div class="container-fluid">
        <router-link class="navbar-brand" to="/">GrowFund</router-link>
        <div class="d-flex">
          <router-link class="nav-link active" aria-current="page" to="/"
            >Campaigns</router-link
          >
          <router-link to="/new-campaigns">
            <button class="btn">
              <img :src="plus" />
            </button>
          </router-link>
        </div>
      </div>
    </nav>
  </div>
</template>

<script>
import plus from "../assets/icons/plus.svg";
export default {
  data() {
    return {
      plus,
    };
  },
};
</script>

<style scoped>
.extras {
  margin-top: 1rem;
}
</style>
