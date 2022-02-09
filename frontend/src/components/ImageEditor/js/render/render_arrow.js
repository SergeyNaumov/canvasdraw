
import {convertHex} from './convertHex.js';
import {renderText} from './renderText.js';

export const render_arrow=(canvas, ctx,block)=>{ // Прорисовка прямоугольника
    ctx.save()
    
    if(block.rotate>0){
        let cx=block.x+block.width/2, cy=block.y+block.height/2
        ctx.translate(cx,cy)
        ctx.rotate(block.rotate * Math.PI/180)
        ctx.translate(-cx, -cy)
    }
    {
      ctx.beginPath();

        // tail coordinates
        let t_x1=block.x,
            t_x2=t_x1 + block.width - block.spike_head,
            t_y1=block.y + block.height /2 -block.tail_height/2,
            
            t_y2=block.y + block.height /2 +block.tail_height/2,
            
            // координаты верхней части наконечника
            sp_t_x = t_x2 - block.spike_tail,
            sp_t_y = block.y ,

            // координаты наконечника
            sp_x= block.x+ block.width, sp_y = block.y + block.height/2,

            // координаты нижней части наконечника
            sp_b_x = t_x2 - block.spike_tail,
            sp_b_y = block.y + block.height

            console.log(`
            t_x1: ${t_x1} t_x2: ${t_x2}
            t_y1: ${t_y1} t_y2: ${t_y2}
            
             ${sp_x} ${sp_y}
            // координаты верхней части наконечника
            ${sp_t_x}
            ${sp_t_y}
            ${sp_b_x}
            ${sp_b_y}
            `)

            ctx.lineWidth = block.lineWidth
            ctx.moveTo(t_x1,t_y1)
            ctx.lineTo(t_x2,t_y1)
            ctx.lineTo(sp_t_x,sp_t_y)

            ctx.lineTo(sp_x,sp_y)
            ctx.lineTo(sp_b_x,sp_b_y)
            ctx.lineTo(t_x2,t_y2)
            ctx.lineTo(t_x1,t_y2)
            ctx.lineTo(t_x1,t_y1)
            /*
            
            
            ctx.lineTo(t_x2,t_y1)

            ctx.lineTo(t_x2,t_y1)
            ctx.lineTo(sp_t_x,sp_t_y)
            ctx.lineTo(sp_x,sp_y)
            
            */
            //ctx.lineTo(t_x2,t_y2)
            //console.log('line to: ',tail_x2,tail_y2)
            //ctx.lineTo(tail_x2,tail_y2)
            if(block.need_border)
              ctx.stroke()
        if(block.need_fill){
          ctx.fillStyle=convertHex(block.background_color,block.background_opacity)
          //console.log(ctx.fillStyle)
          ctx.fill();
        }        
      ctx.closePath();
    }
    renderText(ctx,block)
    ctx.restore()
    
    if(block.selected){ // рисуем выделение
      block.draw_selected(block) 
    }
}