

const fillRoundedRect=(ctx,b)=>{
    //x, y, w, h, r
    let w=b.width
    let h=b.height
    let x=b.x 
    let y=b.y 
    
    ctx.lineWidth = b.lineWidth;
    ctx.strokeStyle = b.border_color
    ctx.beginPath();
    ctx.moveTo(x + (w /2), y);
    ctx.arcTo(x + w, y, x + w, y + (h / 2), b.round_right_top);
    ctx.arcTo(x + w, y + h, x + (w / 2), y + h, b.round_right_bottom);
    ctx.arcTo(x, y + h, x, y + (h / 2), b.round_left_bottom);
    ctx.arcTo(x, y, x + (w / 2), y, b.round_left_top);
    ctx.closePath();

}
import {convertHex} from './convertHex.js';
import {renderText} from './renderText.js';
export const render_rect=(canvas, ctx,block)=>{ // Прорисовка прямоугольника
    ctx.save()
    
    if(block.rotate>0){
        ctx.translate(block.x,block.y)
        ctx.rotate(block.rotate * Math.PI/180)
        ctx.translate(-block.x, -block.y)
    }
    if(block.rounded){
            //let w=self.width, h=self.height, x=self.x-self.width/2, y=self.y
            
            //fillRoundedRect(this.x - this.width * 0.5, this.y - this.height * 0.5, this.width, this.height,50)
            fillRoundedRect(ctx,block)
            if(block.need_border){
              ctx.stroke()
            }
    }
    else{
      ctx.beginPath();
      //let x0=block.x+width/2
      ctx.rect(block.x, block.y, block.width, block.height);
      if(block.need_border){
        ctx.strokeStyle = block.border_color;
        ctx.lineWidth = block.lineWidth;
        ctx.stroke()
      }

      ctx.closePath();
    }
    if(block.need_fill){
      //ctx.fillStyle=this.background_color//`rgba(${this.background_color},${this.this.background_color})`
      //console.log(convertHex(this.background_color,this.background_color))

      ctx.fillStyle=convertHex(block.background_color,block.background_opacity)

      //console.log(ctx.fillStyle)
      ctx.fill();
    }
    


    renderText(ctx,block)

    ctx.restore()
    
    if(block.selected){ // рисуем выделение
      block.draw_selected(block) 
    }
}