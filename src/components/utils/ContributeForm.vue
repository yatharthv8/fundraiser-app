<template>
  <div>
    <h4 class="fw-bold">Amount to Contribute</h4>
    <form class="mb-3" @submit.prevent="submitData">
      <label for="contribution" class="form-label"
        >Minimum Contribution<span class="badge bg-secondary">
          in Ether
        </span></label
      >
      <input
        type="text"
        class="form-control"
        id="contribution"
        placeholder="Amount in Wei"
        v-model="contribution"
      />
      <button
        type="submit"
        class="btn btn-primary"
        :class="{ disabled: isLoading }"
      >
        <div v-if="!isLoading">Contribute!</div>
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
import Campaign from "../../../ethereum/campaign.js";
import web3 from "../../../ethereum/web3.js";
import danger from "../../assets/icons/danger.svg";

export default {
  props: ["address"],
  data() {
    return {
      contribution: "0",
      errMessage: "",
      isError: false,
      isLoading: false,
      danger,
    };
  },
  methods: {
    async submitData() {
      // console.log("address from ContributeForm->", this.address);
      this.isLoading = true;
      this.isError = false;
      try {
        const campaign = Campaign(this.address);
        const accounts = await web3.eth.getAccounts();
        await campaign.methods.contribute().send({
          from: accounts[0],
          value: web3.utils.toWei(this.contribution, "ether"),
        });
        this.$router.go();
      } catch (err) {
        this.isError = true;
        this.errMessage = err.message;
      }
      this.isLoading = false;
    },
  },
};
</script>
