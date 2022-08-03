<template>
  <div>
    <h3 class="fw-bold">Create a Campaign</h3>
    <form class="mb-3" @submit.prevent="submitData">
      <label for="contribution" class="form-label"
        >Minimum Contribution(in Wei)</label
      >
      <input
        type="number"
        class="form-control"
        id="contribution"
        placeholder="Amount in Wei"
        v-model="minContri"
      />
      <button
        type="submit"
        class="btn btn-primary"
        :class="{ disabled: isLoading }"
      >
        <div v-if="!isLoading">Create!</div>
        <div v-else>
          <span
            class="spinner-border spinner-border-sm"
            role="status"
            aria-hidden="true"
          ></span>
          <span>Please Wait...</span>
        </div>
      </button>
      <div
        class="alert alert-danger alert-dismissible fade"
        :class="{ show: isError }"
        role="alert"
      >
        <img :src="danger" />
        <strong>Oops!</strong> {{ errMessage }}
        <button
          type="button"
          class="btn-close"
          data-bs-dismiss="alert"
          aria-label="Close"
        ></button>
      </div>
    </form>
  </div>
</template>

<script>
import factory from "../../ethereum/factory.js";
import web3 from "../../ethereum/web3.js";
import danger from "../assets/icons/danger.svg";

export default {
  data() {
    return {
      minContri: 0,
      errMessage: "",
      isError: false,
      isLoading: false,
      danger,
    };
  },
  methods: {
    async submitData() {
      console.log("amount deposited->", this.minContri);
      this.isLoading = true;
      this.isError = false;
      try {
        const accounts = await web3.eth.getAccounts();
        await factory.methods.createCampaign(this.minContri).send({
          from: accounts[0],
        });
        this.$router.replace("/");
      } catch (err) {
        this.isError = true;
        this.errMessage = err.message;
      }
      this.isLoading = false;
    },
  },
};
</script>
