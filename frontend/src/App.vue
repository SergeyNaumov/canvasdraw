<template>
  <div>
     <router-view></router-view>
  </div>

</template>
<script>


//import {fetchInit, httpGet} from './javascript/fetch.js' // ,httpPost
import {config} from '/src/config'
export default {
  name: 'App',



  data: () => {
    return {
      manager:undefined
    }
  },
  created(){
    this.init()
  },
  methods:{
    init(){
      window.app=this
      this.$http.get({
        url: '/',
        success: d => {
          this.$router.push('/lk')
          this.manager=d.manager
        },
        error: d=>{
          //this.$router.push('/login')
          //location.href='/login'
        }
      })
      // this.$http.get(
      //   config.baseURL + '/'
      // ).then(
      //   r=>{
      //     console.log('R:',r)
      //   }
      // )
      // fetchInit(this)
      // httpGet(
      //   {
      //     url:'/',
      //     success: (d)=>{
      //       this.$router.push('/lk')
      //       console.log('d: ',d)
      //     },

      //   }
      // )
    }
  }
};
</script>
<style>
.err {color: red;}
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



