import {config} from '/src/config'
let app='';

export const fetchInit=self=>{
    app=self
}
const httpRequest=opt=>{
    let method=opt.method?opt.method:'GET'
    let cache=opt.cache?opt.cache:'no-cache'
    //let mode=opt.mode?opt.mode:'cors'
    console.log('app:',app)
    console.log('opt2:',opt)
    fetch(config.baseURL+opt.url,{
        method: method,
        cache: cache,
        //mode: mode  
    })
    .then((r) => {
      console.log('r:',r)
      r=r.json()
      console.log('r2:',r)
      return r
    })
  .then((data) => {
      console.log('data:',data)
      if(data.success){
        
        if('success' in opt){
          console.log('type:',typeof(opt.success))
          if(typeof(opt.success) == 'function' ){
            opt.success(data.data)
          }
          else{
            for(let i in data.data){
              opt.success[i]=data[i]
            }
            
          }
        }
      }
  });  
}
export const httpGet=opt=>{
    
  opt.method='GET'
  httpRequest(opt)
}

export const httpPost=opt=>{
    opt.method='GET'
    httpRequest(opt)

}