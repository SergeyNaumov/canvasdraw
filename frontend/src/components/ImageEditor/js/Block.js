
import { render_rect } from './render/render_rect.js';
import {render_arrow} from './render/render_arrow.js';
var CONST={
    delta_selected:1,
    sel_square_width: 3
}

const isHit=(t, x,y)=>{
    let k=t.getK()
    x*=k
    y*=k
    let delta=3*k*(CONST.delta_selected + CONST.sel_square_width)
    //console.log(`x:${x}, y:${y}, tx: ${t.x}, ty:${t.y}`)
    if(t.rotate.value){ // Фишура повёрнута?
        
    }
    if (x > t.x -delta && y > t.y -delta && x < t.x +  t.width + delta && y < t.y + t.height  + delta) {
        
        return true;
    }
    
    
    return false;
}

const resize_point=(t,x,y)=>{
    let k=t.getK()
    let delta=k*(CONST.delta_selected + CONST.sel_square_width)
    let on_left =  x > (t.x  - delta)/k &&  x < (t.x  + delta)/k  
    let on_right =  x > (t.x + t.width - delta)/k &&  x < (t.x + t.width + delta)/k  
    let on_top= y > (t.y  - delta)/k  &&  y < (t.y  + delta)/k 
    let on_bottom= y > (t.y + t.height - delta)/k  &&  y < (t.y + t.height + delta)/k 
    //console.log([on_bottom])
    if(on_left && on_top)
      return [0,0]
    
    if(on_right && on_top)
      return [1,0]

    if(on_left && on_bottom)
      return [0,1]
    
    if(on_right && on_bottom)
      return [1,1]
    
    return ''
}

const goResize=(t,x,y)=>{
    
    let k=t.getK()
    //x=x/k
    if(t.isResize[0]==0){ // left
        t.width+=(t.x-x*k)
        t.x=x*k
    }
    if(t.isResize[0]==1){ // right

        let nw=parseInt( (x*k-t.x) )
        if(nw<0){
        nw*=-1
        t.isResize[0]=0
        }
        t.width=nw
        
    }
    if(t.isResize[1]==0){ // top
        t.height+=(t.y - y*k)
        t.y=y*k
    }
    if(t.isResize[1]==1){ // bottom
        let nh=parseInt( (y*k-t.y) )
        if(nh<0){
        nh*=-1
        t.isResize[1]=0
        }
        t.height=nh
    }
    t.init()
      
}
const draw_selected = (canvas,ctx,b)=>{ // рисуем область выделения
    ctx.save()
    if(b.rotate>0){
        ctx.translate(-b.x,-b.y)
        ctx.rotate(self.rotate * Math.PI/180)
        ctx.translate(b.x, b.y)
    }
    ctx.beginPath();
    let k=canvas.width / document.getElementById('canvas_blocks').offsetWidth
    ctx.strokeStyle = '#222222';
    let delta_selected=CONST.delta_selected*k
    let x1=b.x - delta_selected
    let y1=b.y - delta_selected
    let x2=b.width + delta_selected*2
    let y2=b.height + delta_selected*2

    ctx.rect(x1, y1, x2 , y2);
    
    let ssw=CONST.sel_square_width * k 
    // маркеры для ресайза
    ctx.rect(x1-ssw, y1-ssw, ssw*2+1 , ssw*2+1)
    ctx.rect(x1+x2-ssw, y1-ssw, ssw*2+1 , ssw*2+1)
    ctx.rect(x1+x2-ssw, y1+y2-ssw, ssw*2+1 , ssw*2+1)
    ctx.rect(x1-ssw, y1+y2-ssw, ssw*2+1 , ssw*2+1)
    
    
    ctx.lineWidth = 1*k;
    ctx.stroke()
    ctx.closePath();
    ctx.restore()
}
const init_rectangle=()=>{

}
const init_circle=(b)=>{
    b.height=b.width
    
    b.rounded=true
    for(let a of ['round_left_top','round_left_bottom','round_right_top','round_right_bottom']){
        b[a]=b.width/2
    }
    b.font_y=b.width/2
}
const init_square=b=>{
    b.height=b.width
}
const init_text=b=>{
    b.need_border=false
    b.need_fill=false
    b.font_x=0
    b.height=b.font_size*(b.text.split("\n").length)
    //b.font_size=b.height
    b.font_y=b.height
}
export class Block {
    constructor(canvas, ctx, attr){
        let t=this
        t.x = attr.x;
        t.y = attr.y;
        t.rotate=attr.rotate || 0 // угол вращения фигуры
        t.width = attr.width
        t.height = attr.height
        t.isDragging = false;
        t.selected=false
        t.isResize=false
        t.type=attr.type || 'rectangle' 
        t.lineWidth=attr.lineWidth ?? 2
       
        t.need_border=attr.need_border ?? true
        
        if(t.type=='arrow'){ // Доп. параметры для стрелки

            let spike=t.width / 2
            t.spike_head=spike / 2 // Передняя часть наконечника
            t.spike_tail=t.width/20 // задняя часть наконечника
            t.tail_height=t.height / 3
            t.lineWidth=4
        }
        else{
            t.text = attr.text || 'Текст'
        }

        // закруглённые края
        t.rounded=attr.rounded || false 
        t.round_left_top= attr.round_left_top ?? 50
        t.round_left_bottom = attr.round_left_bottom ?? 50
        t.round_right_top = attr.round_right_top ?? 50
        t.round_right_bottom = attr.round_right_bottom ?? 50
      
        // заливка цветом
        t.need_fill = attr.need_fill || true
        t.border_color=attr.border_color || '#101093'
        t.background_color=attr.background_color || '#101093'
        t.background_opacity=attr.background_opacity || 1 //0.8
      
        // Текст 
        t.font_bold=attr.font_bold || false
        t.font_italic=attr.font_italic || false
        t.font_color= attr.font_color || '#ffffff'
        t.font_size=attr.font_size || 46
        t.font_family=attr.font_family || 'Serif'
        t.font_x=attr.font_x ?? t.font_size
        t.font_stroke=false
        t.font_y=attr.font_y ?? (this.height / 2 - this.font_size)
        
        t.get_copy_attr=()=>{
            let result=[
                'width','height','type','lineWidth','border_color','need_border','rounded','round_left_top',
                'round_right_bottom','need_fill','background_color','background_opacity','text','font_color',
                'font_size','font_family','font_x','font_y','rotate','font_bold','font_italic'
            ]
            if(t.type=='arrow'){
                for(let a of ['spike_head','spike_tail','tail_height']){
                    result.push(a)
                }
            }
            return result
        }
      
        t.getK=()=>{
          return canvas.width / document.getElementById('canvas_blocks').offsetWidth
        }
        /*t.is_start_resize=(x,y)=>{
          //log('is_start_resize?',x,y,this.x,this.y)
          return false
        }*/
        t.render = (ctxn)=>{
            if(!ctxn) // рендерить можно опционально на любом canvas-е
                ctxn=ctx
            if(t.type=='arrow'){
                render_arrow(canvas, ctxn, t)
            }
            else{
                render_rect(canvas, ctxn, t)
            }
            

            
        }

        t.isHit=(x,y)=>{
            
            return isHit(this,x,y)
        }

        t.resize_point=(x,y)=>{
            return resize_point(t,x,y)
        }

        t.goResize=(x,y)=>{
            return goResize(t,x,y)
        }
        t.draw_selected=()=>{
            draw_selected(canvas, ctx,t)
            
        }
        t.init=()=>{
            if(t.type == 'circle'){
                return init_circle(t)
            }
            else if(t.type == 'rectangle'){
                return init_rectangle(t)
            }
            else if(t.type == 'square'){
                return init_square(t)
            }
            else if(t.type == 'text'){
                return init_text(t)
            }
        }

        t.init()
    }
}

  
