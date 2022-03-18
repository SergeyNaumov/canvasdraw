<template>
    <div>
        
        <div v-if="step==1" class="load_image_block mt-1">
                    
                    <div style="text-align: center;" class="mb-3">
                        <div v-if="block_list.length">
                            <v-btn class="mb-2 ml-5 mt-4 mb-8" @click="setStep(3)" color="red">вернуться в редактор</v-btn><br>
                            <img src="/img/octopus.png">
                        </div>    
                        <div v-else>
                            <img src="/img/octopus.png">
                        </div>
                        Добавьте изображение одним из способов:<br>
                        <div class="mt-2"><b>I. Загрузите фото с Вашего устройства"</b></div>
                    </div>

                    <v-row >

                        <v-col  cols="12" md="6" >
                            
                                
                                <v-file-input @change="loadImgToCrop" 
                                    label="выбрать"
                                    accept="image/png, image/jpeg"

                                />
                        </v-col>
                        <v-col  cols="12" md="6">
                                <v-checkbox class="ml-4" v-model="need_save_objects" label="Сохранить все существующие объекты"/>
                        </v-col>
                    </v-row>
                    <v-row>
                        <v-col  cols="12" md="12">
                        <div class="mt-10" >
                            <b>II. Вставьте изображение из буфера обмена:</b>
                        </div>
                        </v-col>
                        <v-col  cols="12" md="12" class="mt-5">
                        
                           изображение из буфера обмена:
                            <div>
                                <v-btn small class="mt-2 mb-2">вставить</v-btn>
                                
                            </div>
                            (или нажмите CTRL+V)
                        
                        </v-col>
                    </v-row>




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
                    <template v-else>
                        <div class="mt-10 pl-10">
                            Отлично!, теперь выберите площадку, на которой хотите разместить фото товара
                        </div>
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
    props:['step','setStep','imageToCanvas','block_list'],

    components: {Cropper},
    data(){
        return {
            selected_marketplace:undefined,
            need_save_objects: true,
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
            if(this.selected_marketplace){
                this.selected_marketplace.size=this.selected_marketplace.sizes[0]
                this.calc_crop_canvas(this.selected_marketplace.size)
            }

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
            this.imageToCanvas(image,this.need_save_objects)
            

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
                minWidth:0,
                maxHeight:0
                //aspectRatio: false
            }

            if(size){
                
                mp=size
                if(mp && mp.min_height){
                    //c.minHeight=mp.min_height
                }
                if(mp && mp.max_height){
                    //c.maxHeight=mp.max_height
                }
                if(mp && mp.min_width){
                    //c.minWidth=mp.min_width
                }
                if(mp && mp.max_width){
                    //c.maxWidth=mp.max_width
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
        max-width: 800px;
        color: rgb(128, 128, 128);
        vertical-align: middle;
        margin-left: 200px;
        text-align: center;
        height: 100%;
        
        
    }
    .load_image_block img {height: 250px;}
    .v-application .error {color: red; background: #fff !important;}
    .img_info{ 
        margin-bottom: 20px;
        font-size: 12px;
        
        
        padding: 10px;
        background-color: #ece9e9;
    }
    @media (max-width: 1000px) {
        .load_image_block{
            margin: 0 20px;
        }
    }
</style>

