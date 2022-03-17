<template>
  
  <v-app>
        <v-container>
            <v-card max-width="344" class="mx-auto auth">
                <v-card-title  class="headline">
                  Авторизуйтесь
                </v-card-title>
                <v-card-text>
                  <v-text-field :label="show_labels?'Ваш логин':''" v-model="login"  id="login"/>
                  <v-text-field :label="show_labels?'Пароль':''" type="password" v-model="password" id="password"/>
                  <div class="err" v-if="errors.length">
                      <div v-for="e in errors" :key="e">{{e}}</div>
                  </div>
                </v-card-text>
                <v-card-actions>
                  <v-btn color="primary" ref="button" :disabled="submit_disabled" @click="on_login()" small>Войти</v-btn>&nbsp;
                  <div>
                    <small><a href="/register">регистрация в системе</a></small>&nbsp;
                    <small><a href="/remember">забыли пароль?</a></small>
                  </div>
                </v-card-actions>

            </v-card>
        </v-container>

  </v-app>
  
</template>
<script>


import {fetchInit, httpPost} from './javascript/fetch.js'
import {config} from './config.js'
export default({
    name: 'Login',
    components: {
        
    },
    mounted () {
        setTimeout(
            ()=>{ // для того, чтобы не было глюков с автоподстановкой логина и пароля при отображении
            
              let l=document.querySelectorAll('.auth label');
              l[0].classList.add('v-label--active');
              l[1].classList.add('v-label--active');
              document.getElementById('login').focus();
            },1

        )
    },
    watch:{
      login(){
        this.errors=[]
      },
      password(){
        this.errors=[]
      },
    },
    data(){
      return {
        show_labels:true,
        errors:[],
        login: '',
        password: '',
      }

    },
    methods:{
      on_login(){
        // this.$http.post(
        //   config.baseURL+'/login',
        //   {
        //     login: this.login,
        //     password: this.password
        //   }
        // )
        
        // httpPost(
        //   {
        //     url:'/login',
        //     data:{
        //         login:this.login,
        //         password:this.password              
        //     },
        //     success: (d)=>{
        //       //this.$router.push('/lk')
        //       console.log('d: ',d)
              
        //     },
        //     errors: (d)=>{
        //       this.errors=d.errors
        //     }
        //   }
        // )
        this.$http.post({
          url: '/login',
          data: {
            login:this.login,
            password:this.password
          },
          success: d=>{
            location.href='/lk'
          },
          error: d=>{
            this.errors=d.errors
          }
        })
      }
    },
    computed:{
          submit_disabled(){
            if(this.errors.length || !this.login || !this.password)
              return true
            else 
              return false

          }
    }
})
</script>
<style scoped>

</style>
