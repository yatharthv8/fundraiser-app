<template>
  <div>
    <h2 class="fw-bold">Open Campaigns</h2>
    <button type="button" class="btn btn-outline-info btn-sm btn-extra">
      <router-link
        class="nav-link active"
        aria-current="page"
        to="/new-campaigns"
      >
        <img :src="plus" />Create Campaigns
      </router-link>
    </button>
    <div
      v-for="campaign in campaignInfoLog"
      :key="campaign.address"
      class="card"
      style="width: 75%"
    >
      <!-- <img src="..." class="card-img-top" alt="..." /> -->
      <div class="card-body">
        <!-- <h5 class="card-title">{{ campaign.name }}</h5> -->
        <p class="card-text">{{ campaign.address }}</p>
        <!-- <p class="card-text">
          {{ campaign.description }}
        </p> -->
        <router-link
          :to="{
            path: `/campaigns/${campaign.address}`,
            params: { address: campaign.address },
          }"
        >
          <button type="button" class="btn btn-primary">View Details</button>
        </router-link>
      </div>
    </div>
  </div>
</template>

<script>
import factory from "../../ethereum/factory.js";
import plus from "../assets/icons/plus.svg";

export default {
  data() {
    return {
      campaigns: [],
      plus,
    };
  },
  computed: {
    campaignInfoLog() {
      const displayData = [];
      for (const key in this.campaigns) {
        const campaign = {
          name: "Test",
          address: this.campaigns[key],
          description: "Dummy data",
        };
        // console.log("Campaign info->", campaign);
        displayData.push(campaign);
        // console.log("address", this.campaigns[key]);
      }
      return displayData;
    },
    // gotoCampaign() {
    //   return "/campaigns/" + this.campaigns[0];
    // },
  },
  async mounted() {
    this.campaigns = await factory.methods.getDeployedCampaigns().call();
  },
  methods: {
    // campaignInfo(address) {
    //   this.$emit('view-details', address);
    // },
  },
};
</script>

<style scoped>
.btn-extra {
  float: right;
}
</style>
