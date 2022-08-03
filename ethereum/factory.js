import web3 from "./web3.js";
import CampaignFactory from "./build/CampaignFactory.json";

const instance = new web3.eth.Contract(
  CampaignFactory.abi,
  "0xB2a14a5e2c24d1A92726871C86207FBf40B80dd4"
);

export default instance;
