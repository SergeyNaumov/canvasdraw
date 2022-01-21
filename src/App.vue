/* eslint-disable vue/no-unused-components */
<template>
  <v-app>
    <v-navigation-drawer
      app
      left
      absolute
      temporary
      v-model="drawer"
    >
      <v-list-item-group>
        
        <v-list-item>
          <v-list-item-title>
            Здесь будет какое-то<br> меню для фоток
          </v-list-item-title>
        </v-list-item>
        
      </v-list-item-group>
    </v-navigation-drawer>
    <v-app-bar
      app
      color="primary"
    >
      <v-app-bar-nav-icon @click="drawer = !drawer">
      </v-app-bar-nav-icon>
      <v-app-bar-title>
        <h3 class="text-h4 white--text">Image marketplace editor</h3>
      </v-app-bar-title>
    </v-app-bar>
    <v-main>
      <ImageEditor/>
    </v-main>
  </v-app>
</template>
<script>

import ImageEditor from './components/ImageEditor/index.vue'

export default {
  name: 'App',

  components: {

    ImageEditor
  },

  data: () => ({
    drawer:false
  }),
};
</script>
<style>
.v-label, .v-input {
  font-size: 12px;
}
.v-list-item{
  min-height: 20px;
}
.v-list-item__title {
    align-self: center;
    font-size: .8rem;
}
</style>



