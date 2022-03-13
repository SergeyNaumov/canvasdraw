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

      <v-app-bar-nav-icon @click="drawer = !drawer" color="white">
      </v-app-bar-nav-icon>
      <v-app-bar-title>
        <div style="color: #fff;"><b>OctopusArt</b> <span>Мастер карточек товаров</span></div>
      </v-app-bar-title>      

      
    </v-app-bar>
    <v-main>
      <ImageEditor/>
    </v-main>
    
  </v-app>
</template>
<script>
import ImageEditor from './components/ImageEditor/ImageEditor.vue'


export default({
    name: 'Lk',
    data(){
       return {
         drawer:false
       }
    },
    components: {
        ImageEditor
    },
})
</script>
<style scoped>

</style>
