import {config} from '/src/config'
let app='';

export const fetchInit=self=>{
    app=self
}
const httpRequest=opt=>{
    let method=opt.method?opt.method:'GET'
    let cache=opt.cache?opt.cache:'no-cache'
    let options={
      method: method,
      cache: cache,
      mode: 'no-cors'
    }

    if(opt.data){
      options.body=JSON.stringify(opt.data)
      /*options.headers={
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      }*/
    }
    console.log('options:',options)
    fetch(config.baseURL+opt.url,options)
    .then((r) => {
      console.log('r:',r)
      r=r.json()
      console.log('r2:',r)
      return r
    })
  .then((data) => {
      console.log('data:',data)
      if(data.success){
        if(data.redirect){
          if(location.pathname != data.redirect){
            //console.log('redirect',location.href.data.redirect)
            location.href=data.redirect; //+'?from_url='+encodeURI(location.pathname)
          }
          else{
            //console.log('not redirect')
          }
        }
        else if('success' in opt){
          //console.log('type:',typeof(opt.success))

          if(typeof(opt.success) == 'function' ){
            opt.success(data)
          }
          else{
            //for(let i in data.data){
            //  opt.success[i]=data[i]
            //}
            
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
    opt.method='POST'
    
    httpRequest(opt)

}