<template>
  <div class="container">
    <router-view></router-view>
    <h3 class="fw-bold">Campaign Show</h3>
    <div class="row row-cols-2">
      <div class="col">
        <div class="row row-cols-1">
          <div
            v-for="detail in detailsOfCampaigns"
            :key="detail.id"
            class="card border-dark mb-3 col"
            style="max-width: 40%"
          >
            <div class="card-header">{{ detail.data }}</div>
            <div class="card-body text-dark">
              <h5 class="card-title">{{ detail.text }}</h5>
              <p class="card-text">{{ detail.desc }}</p>
            </div>
          </div>
        </div>
      </div>
      <div class="col">
        <div class="col">
          <contribute-form :address="addr"></contribute-form>
        </div>
      </div>
    </div>
    <router-link to="/">
      <button type="button" class="btn btn-primary">Back</button>
    </router-link>

    <router-link :to="gotoRequests">
      <button type="button" class="btn btn-primary">View Requests</button>
    </router-link>
  </div>
</template>

<script>
import Campaign from "../../ethereum/campaign.js";
import web3 from "../../ethereum/web3.js";
import ContributeForm from "../components/utils/ContributeForm.vue";

export default {
  components: { ContributeForm },
  props: ["address"],
  data() {
    return {
      details: [],
      balance: 0,
      add: this.address,
    };
  },
  computed: {
    addr() {
      return this.add;
    },
    detailsOfCampaigns() {
      const keyValPair = [
        {
          id: 4,
          text: "Manager",
          data: this.details[4],
          desc: "The Manager created this campaign and can create requests to withdraw money",
        },
        {
          id: 0,
          text: "Minimum Contribution",
          data: this.details[0],
          desc: "You must contribute at least this much wei to become an approver.",
        },
        {
          id: 2,
          text: "Requests Count",
          data: this.details[2],
          desc: "A request tries to withdraw money from the contract. Requests must be approved by approvers.",
        },
        {
          id: 3,
          text: "Approvers Count",
          data: this.details[3],
          desc: "Number of people who have already donated to this campaign.",
        },
        {
          id: 1,
          text: "Balance(in ether)",
          data: this.balance,
          desc: "The balance is how much money this campaign has left to spend.",
        },
      ];

      return keyValPair;
    },
    gotoRequests() {
      return this.$route.path + "/requests";
    },
  },
  async mounted() {
    const campaign = Campaign(this.address);
    this.details = await campaign.methods.getSummary().call();
    this.balance = Number(web3.utils.fromWei(this.details[1], "ether"));
    // );
    // console.log("Deatils->", this.details);
    // this.campaigns = await factory.methods.getDeployedCampaigns().call();
  },
};
</script>

<style scoped>
.row {
  justify-content: space-evenly;
  align-items: stretch;
  flex-wrap: wrap;
}
</style>
