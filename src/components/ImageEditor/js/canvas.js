export class Canvases{
    constructor(){
        this.canvas_img = document.getElementById('imageCanvas');
        this.ctx_img = canvas_img.getContext('2d');
        this.canvas_img.width=this.width, canvas_img.height=this.height
        
        // канвас для блоков
        this.canvas = document.getElementById('canvas_blocks');
        this.ctx = canvas.getContext('2d');
        this.canvas.width=this.width, canvas.height=this.height
    }
}


export let canvas
export let ctx
export let canvas_img
export let ctx_img;

export const canvases_init=()=>{
    canvas_img = document.getElementById('imageCanvas');
    ctx_img = canvas_img.getContext('2d');
    canvas_img.width=this.width, canvas_img.height=this.height
    
    // канвас для блоков
    canvas = document.getElementById('canvas_blocks');
    ctx = canvas.getContext('2d');
    canvas.width=this.width, canvas.height=this.height
}
