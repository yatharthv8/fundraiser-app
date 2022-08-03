import { createRouter, createWebHistory } from "vue-router";

import HomePage from "../pages/HomePage.vue";
import CreateCampaign from "../pages/CreateCampaign.vue";
import DisplayRequests from "../pages/DisplayRequests.vue";
import NewRequests from "../pages/NewRequests.vue";
import CampaignDetails from "../pages/CampaignDetails.vue";
import NotFound from "../pages/NotFoundPage.vue";

const routes = [
  { path: "/", component: HomePage },
  {
    path: "/new-campaigns",
    component: CreateCampaign,
  },
  {
    path: "/campaigns/:address",
    component: CampaignDetails,
    props: true,
    children: [
      { path: "requests", component: DisplayRequests },
      { path: "new-requests", component: NewRequests },
    ],
  },
  { path: "/:notFound(.*)", component: NotFound },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
