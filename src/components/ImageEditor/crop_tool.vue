<template>
    <div>
        <div v-if="step==1" class="load_image_block">
                
                    для начала выберите изображение:<br>
                    <v-file-input @change="loadImgToCrop" 
                        label="выберите изображение"
                        accept="image/png, image/jpeg"
                    />



        </div>
        <div v-if="step==2" class="mt-3 mr-5 ml-2" >
            <v-row>
                
                
                <v-col  cols="12" lg="2" sm="4" md="3">
                    <div class="pb-4" style="border-bottom: 1px solid gray;">
                        <v-btn color="primary" x-small @click="setStep(1)">загрузить новое фото</v-btn>

                    </div>
                    <div v-if="!crop_error && selected_marketplace && selected_marketplace.size" class="img_info">
                            
                            <div v-if="crop_info.coordinates">
                                Исходное изображение: {{width}}x{{height}}<br><br>
                                Новые размеры: {{crop_info.coordinates.width}}x{{crop_info.coordinates.height}}
                            </div>
                            <v-btn class="mt-2 mb-2" @click="crop">crop</v-btn>
                    </div>
                    
                    <div class="mt-4">
                        Выберите Marketplace:  
                        <div v-for="(m,idx) in marketplace_list" :key="idx">
                            <v-checkbox
                                v-model="selected_marketplace"
                                :value="m"
                                v-if="!selected_marketplace || selected_marketplace.name==m.name"
                                :label="m.header"
                                @change="calc_crop_canvas(false)"
                            />
                            <template v-if="selected_marketplace && m.name==selected_marketplace.name">
                                <v-radio-group v-model="selected_marketplace.size">
                                    <v-radio
                                        v-for="(s,idx) in selected_marketplace.sizes" :key="idx"
                                        :value="s"
                                        :label="s.header"
                                        @change="calc_crop_canvas(s)"
                                    />
                                </v-radio-group>


                                
                                <div v-if="0 && m.name==selected_marketplace.name" v-html="m.body"></div>
                            </template>
                        </div>
                    </div>
                </v-col>
                
                <v-col  cols="12" lg="10" sm="8" md="9" >
                    
                    <template v-if="crop_img && selected_marketplace && selected_marketplace.size">
                        
                        <div v-if="crop_error" class="error">
                            {{crop_error}}
                        </div>

                        <cropper class="mt-4"
                            
                            :src="crop_img.src"
                            
                            :canvas="crop_canvas"
                            :stencil-props="stencil_props"
                            @change="crop_change"
                            ref="cropper"
                        />
                    </template>
                </v-col>
                
            </v-row>
        </div>
    </div>
</template>
<script>
import { Cropper } from 'vue-advanced-cropper';
import 'vue-advanced-cropper/dist/style.css';
import {marketplace_list} from './js/marketplace_list.js'
//let crop_img=''
export default({
    name: 'crop_tool',
    props:['step','setStep','imageToCanvas'],

    components: {Cropper},
    data(){
        return {
            selected_marketplace:undefined,
            marketplace_list:marketplace_list,
            crop_img:'',
            // размеры исходного изображения
            width:0,
            height:0,
            // для ресайзов
            coordinates: {
                width: 0,
				height: 0,
				left: 0,
				top: 0
            },
            crop_canvas:{},
            stencil_props:{
                
            },
            crop_error:'',
            crop_info: {}
        }
    },
    watch:{
        selected_marketplace(){
            this.selected_marketplace.size=this.selected_marketplace.sizes[0]
            this.calc_crop_canvas(this.selected_marketplace.size)
        },
    },
    methods:{
        crop(){
            
            let image
            {
                const { coordinates, canvas, } = this.$refs.cropper.getResult();
                this.coordinates = coordinates;
                image=canvas.toDataURL()
            }
            this.imageToCanvas(image)
            

        },
        loadImgToCrop(e){
            
            this.show_canvas=true
            this.$nextTick(
                ()=>{
                    let reader = new FileReader();
                    reader.onload = event=>{
                        this.crop_img = new Image();
                        this.crop_img.src = event.target.result
                        this.width=this.crop_img.width, this.height=this.crop_img.height

                        console.log(`${this.width}x${this.height}`)

                        this.setStep(2)
                        this.$nextTick(
                            ()=>{
                                this.window_height=window.outerHeight
                            }
                        )

                    }
                    reader.readAsDataURL(e);
                }
            )

            
        
        },
        crop_change(d){
            this.crop_error=''
            this.crop_info=d
            if(this.crop_canvas.minHeight){
                if(d.image.width < this.crop_canvas.minWidth){
                    this.crop_error=`Ширина Вашего изображения (${d.image.width}px) меньше, чем минимальная ширина (${this.crop_canvas.minHeight}px)`
                }

                if(this.crop_canvas.minWidth && this.crop_canvas.minWidth<d.coordinates.width){
                    this.$refs.cropper.setCoordinates({width: this.crop_canvas.minWidth})
                }
            }
            if(this.crop_canvas.minHeight){
                if(d.image.height < this.crop_canvas.minHeight){
                    this.crop_error=`Высота Вашего изображения (${d.image.height}px) меньше, чем минимальная высота (${this.crop_canvas.minHeight}px). Загрузите изображение большего размера`
                }
                if(this.crop_canvas.minHeight && this.crop_canvas.minHeight>d.coordinates.height){
                    this.$refs.cropper.setCoordinates({height: this.crop_canvas.minHeight})
                }
            }
            


        },
        calc_crop_canvas(size){
            let mp=this.selected_marketplace
            let c={};
            let sp={
                handlers: {},
                movable: true,
                resizable: true,
                //aspectRatio: false
            }

            if(size){
                
                mp=size
                if(mp && mp.min_height){
                    c.minHeight=mp.min_height
                }
                if(mp && mp.max_height){
                    c.maxHeight=mp.max_height
                }
                if(mp && mp.min_width){
                    c.minWidth=mp.min_width
                }
                if(mp && mp.max_width){
                    c.maxWidth=mp.max_width
                }
                if(mp && mp.height){
                    c.height=mp.height
                }
                if(mp && mp.width){
                    c.width=mp.width
                }
                if(c.width && c.height){
                    sp.aspectRatio=c.width / c.height
                }    
                
            }


            this.stencil_props=sp
            this.crop_canvas=c                
            
            
        },
    }
})
</script>
<style scoped>
    .load_image_block{
        text-align: center;
        color: rgb(128, 128, 128);
        vertical-align: middle;
        width: 300px;
        height: 100%;
        margin-top: 10%;
        margin-left: calc( 50% - 150px);
    }
    .v-application .error {color: red; background: #fff !important;}
    .img_info{ 
        margin-bottom: 20px;
        font-size: 12px;
        
        
        padding: 10px;
        background-color: #ece9e9;
    }
</style>

