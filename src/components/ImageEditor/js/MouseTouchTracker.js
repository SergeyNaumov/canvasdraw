
export class MouseTouchTracker {
  constructor(self, ctx, canvas, callback){
    
    this.self=self
    this.ctx=ctx
    this.canvas=canvas
    //this.callback=callback
    const processEvent=evt=>{
        let rect = canvas.getBoundingClientRect()
        let offsetTop = rect.top;
        let offsetLeft = rect.left;
    
        if (evt.touches) {
          return {
            x: evt.touches[0].clientX - offsetLeft,
            y: evt.touches[0].clientY - offsetTop
          }
        } else {
          return {
            x: evt.clientX - offsetLeft,
            y: evt.clientY - offsetTop
          }
        }
    }
    const onDown=evt=>{
        evt.preventDefault()
        let coords = processEvent(evt)
        callback('down', coords.x, coords.y)
    }
    const onUp = evt=>{
        evt.preventDefault();
        callback('up');
    }
    const onMove = evt => {
        evt.preventDefault();
        let coords = processEvent(evt);
        callback('move', coords.x, coords.y);
    }
    this.processEvent=processEvent
    this.onDown=onDown
    this.onUp=onUp
    canvas.ontouchmove = onMove;
    canvas.onmousemove = onMove;
  
    canvas.ontouchstart = onDown;
    canvas.onmousedown = onDown;
    canvas.ontouchend = onUp;
    canvas.onmouseup = onUp;
    document.addEventListener('keydown', function(event) {
          
          if (event.key === "Delete") {
              if(!self.block_delete_active)
                return
  
              
              let i=0
              for(let b of self.block_list){
                  if(b.selected){
                      self.block_list.splice(i,1)
                  }
                  i++
  
              }
              ctx.clearRect(0, 0, canvas.width, canvas.height);
              
              for(let b of self.block_list){
                  b.render(ctx)
              }
          }
    });
  }




  




}
