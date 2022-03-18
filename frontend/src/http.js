import axios from "axios";
import {config} from '/src/config'
export const http={
    get: opt=>{
        //console.log('request get')
        axios.get(
            config.baseURL+opt.url
        ).then(
            r=>{
                let d=r.data
                if(d.redirect){
                    if(location.pathname != d.redirect)
                        location.href=d.redirect
                }
                else if(d.success && opt.success){
                    opt.success(d)
                }
                else if(opt.error){
                    opt.errors(d)
                }
                
            }
        ).catch(
            e=>{
                if(opt.error){
                    opt.error({errors:[e]})
                }
            }
        )
    },
    post: opt=>{
        axios.post(
            config.baseURL+opt.url,
            opt.data
        ).then(
            r=>{
                let d=r.data
                if(d.redirect){
                    if(location.pathname != d.redirect)
                        location.href=d.redirect
                }
                else if(d.success && opt.success){
                    opt.success(d)
                }
                else if(opt.error){
                    opt.errors(d)
                }
            }
        ).catch(
            e=>{
                if(opt.error){
                    opt.error({errors:[e]})
                }
            }
        )
    }
}
//Vue.prototype.$http = require('axios');