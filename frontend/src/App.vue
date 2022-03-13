<template>
  <div>
     <router-view></router-view>
  </div>

</template>
<script>


import {fetchInit, httpGet} from './javascript/fetch.js' // ,httpPost
export default {
  name: 'App',



  data: () => ({
   
  }),
  created(){
    this.init()
  },
  methods:{
    init(){
      fetchInit(this)
      httpGet(
        {
          url:'/',
          success: (d)=>{
            this.$router.push('/lk')
            console.log('d: ',d)
          }
        }
      )
    }
  }
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



