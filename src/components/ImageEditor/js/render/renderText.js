//import {convertHex} from './convertHex.js';
export const renderText = (ctx,block)=>{
    // текст
    if(block.text){
        ctx.font = `${block.font_bold?'bold ':''}${block.font_italic?'italic ':''}${block.font_size}px ${block.font_family}`
        
        ctx.fillStyle=block.font_color
        
        let lines=block.text.split("\n")
        let dy=0
        
        for(let line of lines){
          if(block.font_stroke){
            ctx.strokeText(line, block.font_x + parseInt(block.x), dy + parseInt(block.font_y) + block.y)
          }
          else{
            ctx.fillText(line, block.font_x + parseInt(block.x), dy + parseInt(block.font_y) + block.y)
          }
          dy+=block.font_size*1.2
        }
    }
}