<template>
<div>
    <crop_tool 
        :step="step"
        :setStep="setStep"
        :imageToCanvas="imageToCanvas"
    />
    <v-row style="width: 100%; height: 100%;" v-show="step==3">
        
        <v-col  cols="12" lg="2" sm="4" md="3" class="col-left mt-4">

            <template >
                <v-btn @click.prevent="step=1" x-small color="primary">загрузить новое фото</v-btn>
            </template>
                        <Tools
                            :selectedBlock="selectedBlock"
                            :rerender_all="rerender_all"
                            :width="width"
                            :height="height"
                            :copy_block="copy_block"
                            :delete_block="delete_block"
                            :block_delete_active="block_delete_active"
                            :set_block_delete_active="set_block_delete_active"
                        />
                        
                        <div v-if="step==3" class="mt-2 ml-2">
                            <div>
                                <template v-if="!block_list.length">
                                    Отлично! Теперь, когда изображение загружено, добавьте нужные фигуры:
                                </template>

                            </div>
                            <v-select 
                                v-model="selected_figure"
                                :items="figures"
                                item-value="v"
                                item-text="d"
                                
                                hide-details
                                x-small
                                label="выбор фигуры"
                            />
                            
                            <v-btn  @click.prevent="draw" :disabled="!selected_figure" x-small color="primary">вставить</v-btn>
                            
                            <v-checkbox v-model="show_grid" label="показать сетку" @change="rerender_all" class="mt-10"/>
                            <div v-if="show_grid" class="ml-2">
                                толщина линий ({{grid_width}}):
                                            
                                            <v-slider
                                                
                                                
                                                min="1"
                                                max="10"
                                                v-model.number="grid_width"
                                                @change="rerender_all"
                                                hide-details
                                            />
                                шаг ({{grid_step}}):
                                            <v-slider

                                                min="10"
                                                max="500"
                                                step="10"
                                                v-model.number="grid_step"
                                                @input="rerender_all"
                                                hide-details
                                            />
                                цвет:<br>
                                <input type="color" v-model="grid_color" @change="rerender_all" class="color">

                            </div>
                            <block_library 
                                :loadBlock="loadBlock"
                                :selectedBlock="selectedBlock"
                                :block_list="block_list"
                                :delete_all_blocks="delete_all_blocks"
                            />
                            <div class="mt-10" v-if="img_loaded && block_list.length">
                                <v-btn @click.prevent="save_result" x-small color="primary">скачать изображение</v-btn>
                            </div>
                        </div>



                    
        </v-col>
        <v-col cols="12" lg="10" sm="8" md="9" class="mt-5 "  :style="{'cursor': cursor_style,'height': canvas_height}">
            размер изображения: {{width}}x{{height}}
            <div style="top: 20px; position: relative;">
            <canvas id="imageCanvas" class="maincanvas" ></canvas>
            <canvas id="canvas_blocks" class="maincanvas" ></canvas>
            </div>
        </v-col>

            
    </v-row>
</div>
</template>

<script>
  //let file_field=document.getElementById('file_field')
  import { MouseTouchTracker } from './js/MouseTouchTracker.js';
  import { Block } from './js/Block.js';
  import Tools from './tools/tools.vue'
  import crop_tool from './crop_tool.vue'
  // блок для сохранения объекта (для дизайнера)
  import block_library from './block_library.vue'

  let source_img='' // изображение , которое загружают фоном
  let  canvas, ctx, canvas_img, ctx_img, startX, startY
  
  export default {
    
    name: 'ImageEditor',
    components: {crop_tool, block_library, Tools},
    data(){
        return {
            step:1, 
            canvases:undefined,         
            show_grid: false,
            grid_step: 100,
            grid_width: 1,
            grid_color: 'gray',
            mtt:undefined, // MouseTouchTracker
            width:4000,
            height:3000,
            
            window_height: window.innerHeight,
            canvas_height: 500,
            show_canvas:true,
            img_loaded: false,
            img_load_force: false,
            source_img:'',
            figures:[
                //{'d':'Блок','v':'block'},
                {'d':'Прямоугольник','v':'rectangle'},
                //{'d':'Текстовый блок','v':'text'},
                {'d':'Круг','v':'circle'},
                {'d':'Квадрат','v':'square'},
                {'d':'Только текст','v':'text'},
                {'d':'Стрелка','v':'arrow'},
                {'d':'Многоугольник','v':'arrow'},
                {'d':'Звезда','v':'arrow'},
                
            ],
            selected_figure: '',
            block_list:[],
            block_clipboard:undefined,
            block_delete_active:false, // можно удалять блок клавишей delete (когда находимся в панели инструментов запрещаем, потому что клавиша del в этом случае используется для других целей)
            cursor_style: '',
            

        }
    },
    mounted(){
        canvas_img = document.getElementById('imageCanvas');
        ctx_img = canvas_img.getContext('2d');
        canvas_img.width=this.width, canvas_img.height=this.height
        

        this.start_mtt()

        

    },
    watch:{

        step(){
            
            if(this.step==3){
                this.$nextTick(
                    ()=>{
                        // копируем картинку в canvas
                            canvas.width = source_img.width
                            canvas.height = source_img.height

                            canvas_img.width=source_img.width
                            canvas_img.height = source_img.height

                            this.width=source_img.width
                            this.height=source_img.height
                            ctx_img.drawImage(source_img,0,0)
                    }
                )
            }
            
        }
    },
    methods:{

        set_block_delete_active(v){
            this.block_delete_active=v
        },
        imageToCanvas(image){ // Переносим изображение из кропа в нашу рисовалку
            source_img = new Image();
            source_img.src=image

            source_img.onload=()=>{
                canvas.width = source_img.width
                canvas.height = source_img.height

                canvas_img.width=source_img.width
                canvas_img.height = source_img.height

                this.width=source_img.width
                this.height=source_img.height
                ctx_img.drawImage(source_img,0,0)
                this.block_list=[]
                this.img_loaded=true
                this.img_load_force=false
            }
            this.setStep(3)
        },
        blockToClicpboard(){
            let attr={}, b=this.selectedBlock
            for(let a of b.get_copy_attr()) attr[a]=b[a]
            this.block_clipboard=attr
        },
        blockFromClicpboard(){
            let attr=this.block_clipboard
            if(attr){
                attr.x=this.width/10+this.width /10
                attr.y=this.height/10+this.height /10
                
                let block = new Block(canvas, ctx, attr);
                block.render(ctx);
                this.block_list.push(block)                
            }

        },
        start_mtt(){


            // канвас для блоков
            canvas = document.getElementById('canvas_blocks');
            ctx = canvas.getContext('2d');
            canvas.width=this.width, canvas.height=this.height

            

            this.canvases={
                canvas_img: canvas_img,
                ctx_img: ctx_img,
                canvas: canvas,
                ctx: ctx 
            }

            this.mtt=new MouseTouchTracker(this, ctx, canvas,
                (evtType, x, y)=>{
                    let k=canvas.width / document.getElementById('canvas_blocks').offsetWidth
                    
                    let flag=false // для того, чтобы нельзя было драгать и выделять несколько блоков
                    let need_block_top=false
                    let need_render_all=false
                    let dx = x - startX;
                    let dy = y - startY;
                    
                    switch(evtType) {
                     
                      case 'down':
                        startX = x;
                        startY = y;
                        
                        for(let b of this.block_list){
                            if(b.selected){
                                need_render_all=true
                            }
                            if(!flag && b.isHit(x,y) ){
                                b.selected = true
                                need_render_all=true
                                let point_result=b.resize_point(x,y)
                                if(point_result || b.isResize){
                                    b.isResize=point_result
                                    b.isDragging = false
                                }
                                else{
                                    b.isResize=false
                                    
                                    if(!b.isDragging){
                                        b.isDragging = true
                                        this.block_delete_active=true
                                        need_block_top=true
                                    }
                                    
                                    
                                }
                                flag=true
                            }
                            else{

                                b.selected=false
                                b.isResize=false
                            }

                        }
                        if(need_block_top){
                            this.moveBlockTop()
                        }
                        break;

                      case 'up':
                        for(let b of this.block_list){
                            b.isDragging=false
                            b.isResize=false
                        }

                        break;

                      case 'move':

                        startX = x;
                        startY = y;
                        
                        for(let b of this.block_list){
                            let point_result=b.resize_point(x,y)

                            if(point_result && b.isHit(x,y)){
                                
                                if( (point_result[0] + point_result[1])  == 0 || (point_result[0] + point_result[1]) ==2 ){
                                    this.cursor_style='nw-resize'
                                }
                                else{
                                    this.cursor_style='ne-resize'
                                }
                            }
                            else{
                                this.cursor_style=''

                            }

                            if(b.isResize){ // происходит ресайз
                                this.block_delete_active=true
                                b.goResize(x,y)
                                need_render_all=true
                                //log('resize: ',b.isResize, dx*k, dy*k)
                            }
                            else if(b.isDragging){
                                this.block_delete_active=true
                                b.x += dx*k
                                b.y += dy*k
                                need_render_all=true
                            }

                        }
                        break;
                    }
                    if(need_render_all){
                        this.rerender_all()
                    }

                }
            )
            
            
        },
        setStep(v){
            this.step=v
        },
        draw_greed(){
            if(this.show_grid){
                let k=canvas.width / document.getElementById('canvas_blocks').offsetWidth;
                
                
                // grid_step
                let step=this.grid_step // *k
                let x1=0,x2=canvas.width,y1=0,y2=canvas.height
                ctx.beginPath();
                
                ctx.strokeStyle = this.grid_color
                ctx.lineWidth = this.grid_width*k
                while(y1 < y2){
                    ctx.moveTo(x1,y1)
                    ctx.lineTo(x2,y1)
                    y1+=step
                }
                
                
                y1=0
                while(x1< x2){
                    ctx.moveTo(x1,y1)
                    ctx.lineTo(x1,y2)
                    x1+=step
                }
                ctx.stroke()
                ctx.closePath();

            }
        },
        delete_all_blocks(){
            this.block_list=[]
            this.rerender_all()
        },
        rerender_all(){
            ctx.clearRect(0, 0, canvas.width, canvas.height);
            this.draw_greed()
            for(let b of this.block_list){
                b.render(ctx)
            }
        },
        draw(){
            {
                let attr={
                    x:this.width/10+this.width /10,
                    y: this.width /10+this.width /10, 
                    type: this.selected_figure
                }
                if(attr.type=='arrow'){
                    attr.width=this.width/4
                    attr.height=this.height/15
                }
                else{

                    attr.width=this.width/5
                    attr.height=this.height/5
                    
                }
                
                attr.font_size=(attr.width/10)
                let b = new Block(canvas, ctx, attr);
                
                b.render(ctx);
                this.block_list.push(b)
                
            }

            this.selected_figure=''


        },
        save_result(){

            // рендерим на канвасе-фоне все наши фигуры и сохраняем
            for(let b of this.block_list){
                b.render(ctx_img)
            }
            // выгружаем полученное изображение
            let link = document.createElement('a');
            link.download = 'for_marketplace.png';
            link.href = canvas_img.toDataURL()
            link.click();
            
           // после чего по новой отчерчиваем нашу картинку
           ctx_img.drawImage(source_img,0,0)
            

        },
        copy_block(b){
            let attr={}
            for(let a of b.get_copy_attr()){
                attr[a]=b[a]
            }
            attr.x=this.width/10+this.width /10
            attr.y=this.height /10+this.height /10
            
            let block = new Block(canvas, ctx, attr);
            block.render(ctx);
            this.block_list.push(block)
            
        },
        delete_block(){
            let i=0
            for(let b of this.block_list){
                if(b.selected){
                    this.block_list.splice(i,1)
                }
                i++

            }
            this.rerender_all()
        },
        moveBlockTop(){
            let new_list=[]
            let cur_block=undefined
            for(let b of this.block_list){
                if(b.selected){
                    cur_block=b
                }
                else{
                    new_list.push(b)
                }
            }
            if(cur_block){
                new_list.push(cur_block)
            }
            this.block_list=new_list

        },

        loadBlock(attr){
            if(typeof(attr)=='string')
                attr=JSON.parse(attr)

            let block = new Block(canvas, ctx, attr);
            block.render(ctx);
            
            this.block_list.push(block)


        }
    },
    computed:{
        selectedBlock(){
            for(let b of this.block_list){
                if(b.selected)
                    return b
            }
            return undefined
        },
        max_tool_height(){
            return window.innerHeight-50
        },


        




    }
  }
</script>


<style scoped>

    .col-left {
        font-size: 10pt;
        padding: 20px;
    }
    .maincanvas {
        max-width: 100%;
        max-height: 800px;
        
        border:  1px solid rgb(128, 128, 128);
        position:  absolute; left: 0; top: 0;
    }
    .imageCanvas{
        z-index: 0;
    }
    .canvas_blocks{
        z-index: 1;
    }
    .v-application .error {color: red; background: #fff !important;}
</style>