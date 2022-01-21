<template>
<div>
    
    <dialog-drag
        :title="block_name"
                            v-if="selectedBlock"
                            :options="tool_drag_options"
                            :buttonPin="false"
                            @drag-end="drag_end"
                            @close="selectedBlock.selected=false"
                           class="tools"
                                
                             


                        >
                            <div   @mouseover="block_delete_active=false">
                                <div  >
                                    <div class="mb-2">
                                        <v-btn @click.prevent="copy_block(selectedBlock)" x-small color="primary">Копировать</v-btn>
                                        <v-btn @click.prevent="delete_block" x-small color="primary" >Удалить</v-btn>
                                    </div>             
                                    {{selectedBlock.type}}                                                          
                                    <div v-if="show_block.rotating">
                                            Вращение:
                                            <v-slider
                                                
                                                v-model="selectedBlock.rotate"
                                                min="0"
                                                max="360"
                                                @input="rerender_all"
                                            />
                                    </div>
                                    <!-- Закруглённые углы -->
                                    <template v-if="show_block.rounding">
                                        <input type="checkbox" v-model="selectedBlock.rounded" @change="rerender_all"> закруглённые углы<br>    
                                        <div v-if="selectedBlock.rounded" class="row" >
                                            
                                            <table class="mt-4 ml-4 mb-4">
                                                <tr>
                                                    <td>левый верхний:</td>
                                                    <td><input type="number" class="number2" min="1" :max="width" v-model.number="selectedBlock.round_left_top" @input="rerender_all"></td>
                                                </tr>
                                                <tr>
                                                    <td>левый нижний:</td>
                                                    <td><input type="number" class="number2" min="1" :max="width" v-model.number="selectedBlock.round_left_bottom" @input="rerender_all"></td>
                                                </tr>
                                                <tr>
                                                    <td>правый верхний:</td>
                                                    <td><input type="number" class="number2" min="1" :max="width" v-model.number="selectedBlock.round_right_top" @input="rerender_all"></td>
                                                </tr>
                                                <tr>
                                                    <td>правый нижний:</td>
                                                    <td><input type="number" class="number2" min="1" :max="width" v-model.number="selectedBlock.round_right_bottom" @input="rerender_all"></td>
                                                </tr>
                                                </table>


                                        </div>
                                    </template>
                                    <div v-if="show_block.feeling"> 
                                        <input type="checkbox" v-model="selectedBlock.need_fill" @change="rerender_all"> закрасить фигуру
                                        <div v-if="selectedBlock.need_fill" class="ml-2">
                                            <table>
                                                <tr>
                                                    <td>цвет:&nbsp;</td>
                                                    <td><input type="color" class="color"  v-model.number="selectedBlock.background_color" @change="rerender_all"></td>
                                                    
                                                </tr>

                                            </table>
                                            полупрозрачность ({{selectedBlock.background_opacity}}):
                                            <v-slider
                                                
                                                v-model="selectedBlock.font_x"
                                                min="0"
                                                max="1"
                                                step="0.1"
                                                v-model.number="selectedBlock.background_opacity"
                                                @input="rerender_all"
                                            />                                   
                                            
                                        </div>
                                    </div>
                                        <div class="mt-1"><b>Размеры блока:</b></div>
                                        <template v-if="selectedBlock.type=='circle'">
                                            <table class="ml-2">
                                                <tr>
                                                    <td>Диаметр:</td><td><input type="number" class="number3" min="1" :max="width" v-model.number="selectedBlock.width"     
                                                        @input="rerender_all"
                                                    ></td>
                                                </tr>
                                                
                                            </table>
                                        </template>
                                        <template v-else>
                                            <table class="ml-2">
                                                <tr>
                                                    <td>Ширина:</td><td><input type="number" class="number3" min="1" :max="width" v-model.number="selectedBlock.width"     
                                                        @input="rerender_all"
                                                    ></td>
                                                </tr>
                                                <tr>
                                                    <td>Высота:</td>
                                                    <td><input type="number" 
                                                        class="number3" min="1" :max="height" v-model.number="selectedBlock.height" 
                                                        @input="rerender_all"
                                                    ></td>
                                                </tr>
                                                <!-- Для стрелки -->


                                            </table>
                                            <div v-if="selectedBlock.type=='arrow'" class="ml-2">
                                                Ширина хвоста:
                                                <v-slider
                                                :max="selectedBlock.height"
                                                v-model="selectedBlock.tail_height"
                                                min="1"
                                                hide-details
                                                @input="rerender_all"/>
                                                
                                                Передняя часть наконечника:                                               
                                                <v-slider
                                                :max="selectedBlock.width"
                                                v-model="selectedBlock.spike_head"
                                                min="1"
                                                hide-details
                                                @input="rerender_all"/>

                                                Задняя часть наконечника:
                                                <v-slider
                                                :max="selectedBlock.width"
                                                v-model="selectedBlock.spike_tail"
                                                min="1"
                                                hide-details
                                                @input="rerender_all"/>
                                            </div>
                                        </template>
                                        

                                        <div class="mt-1"><input type="checkbox" v-model="selectedBlock.need_border" @change="rerender_all"> <b>Контуры:</b></div>
                                        <table class="ml-2" v-if="selectedBlock.need_border">
                                            <tr>
                                                <td>Толщина:</td>
                                                <td>

                                                    <input type="number" class="number2" min="0" max="50" v-model.lazy="selectedBlock.lineWidth" @input="rerender_all"></td>
                                            </tr>
                                            <tr>
                                                <td>Цвет:</td>
                                                <td><input type="color"  class="color" min="0" max="50" v-model.lazy="selectedBlock.border_color" @change="rerender_all"></td>
                                            </tr>
                                        </table>

                                        
                                </div>
                                <hr>

                                <div>
                                    <div class="mt-2 mb-1"><b>Надпись в блоке:</b></div>
                                        <div class="ml-2">
                                            <textarea v-model="selectedBlock.text" @input="rerender_all"  placeholder="введите слово или фразу"></textarea>

                                            
                                            <v-select
                                                label="выбор шрифта:"
                                                :items="['Arial','Calibri','Courier','Cursive', 'Monospace', 'Serif', 'Tahoma','Helvetica','Times','Impact','Fantasy','Verdana','Wingding']"
                                                v-model="selectedBlock.font_family"
                                                @input="rerender_all"
                                            />
                                            
                                            Размер ({{selectedBlock.font_size}}):
                                            <v-slider
                                                
                                                v-model="selectedBlock.font_size"
                                                min="1"
                                                max="500"
                                                @input="rerender_all"
                                            />

                                            <table class="mb-4">
                                                <!--<tr>
                                                    <td>Размер:</td>
                                                    <td><input type="number" v-model="selectedBlock.font_size" @input="rerender_all" class="number2"></td>
                                                </tr>-->
                                                <tr>
                                                    <td>Цвет текста:</td>
                                                    <td><input type="color" v-model="selectedBlock.font_color" @change="rerender_all" class="color"></td>
                                                </tr>
                                            </table>
                                            <div class="ml-1">
                                                <input type="checkbox" v-model="selectedBlock.font_bold" @change="rerender_all"> полужирный<br>
                                                <input type="checkbox" v-model="selectedBlock.font_italic" @change="rerender_all"> курсив<br>
                                                <input type="checkbox" v-model="selectedBlock.font_stroke" @change="rerender_all"> показывать только контур тексты<br>
                                            </div>


                                            Горизонтальное положение:
                                            <v-slider
                                                :max="selectedBlock.width"
                                                v-model="selectedBlock.font_x"
                                                min="0"
                                                @input="rerender_all"
                                            />
                                        
                                        

                                            Вертикальное положение:
                                            <v-slider
                                                :max="selectedBlock.height"
                                                v-model="selectedBlock.font_y"
                                                min="0"
                                                @input="rerender_all"
                                                
                                            />
                                        </div>
                                        
                                </div>
                            </div>
                            
    </dialog-drag>
    </div>
</template>
<script>
    import DialogDrag from 'vue-dialog-drag'
    export default {
        components: {  DialogDrag },
        name: 'tools',
        props:['selectedBlock','rerender_all','width','height','copy_block','delete_block'],
        data(){
            return {
                tool_drag_options:{ 
                    buttonPin:false,
                    width:300,top:-30,
                    height: this.max_tool_height,
                    
                    left: (window.innerWidth-320), // отображаем справа
                    x:0,y:0,z:0,id:'drag_tools' },
            }
        },
        methods:{
            drag_end(e){
                this.tool_drag_options.x=e.x, this.tool_drag_options.y=e.y
                console.log('drag end:',e)
                this.tool_drag_options.height=500
            },
        },
        computed:{
            show_block(){
                if(!this.selectedBlock){
                    return {}
                }
                let type=this.selectedBlock.type
                return {
                    rotating: (type != 'circle'), // вращение
                    rounding: (type != 'circle' && type != 'arrow'), // закруглённые углы
                    feeling: (type != 'text'),

                }
            },
            block_name(){
                let t=this.selectedBlock.type
                if(t=='circle')
                    return 'Круг'
                if(t=='text')
                    return 'Надпись'
                
                if(t=='square')
                    return 'Квадрат'
                if(t=='hexagone')
                    return 'Многоугольник'
                if(t=='star')
                    return 'Звезда'
                if(t=='arrow')
                    return 'Стрелка'
                return 'Прямоугольник'
                
            }
        }
    }
</script>
<style src='./vue-dialog-drag.css'></style>
<style  scoped>
    div {color: rgb(128, 128, 128);}
    .number2 {width: 50px; height: 25px; vertical-align: middle; font-size:  10pt !important; margin-bottom: 5px !important;}
    .number3 {width: 75px; height: 25px; vertical-align: middle; font-size:  10pt !important; margin-bottom: 5px !important;}
    .v-text-field input {
        font-size: 1rem;
    }
    .dialog-drag .dialog-header {
        background-color: blue !important;
    }
    .tools{
        height: calc(100% - 50px) !important;
        max-height: calc(100%) !important;
        overflow-y: scroll;
    }
    .color { width: 30px; vertical-align: middle; margin-bottom: 5px !important; }
    .v-btn {margin: 10px;}
    input, textarea, select {border: 1px solid gray; margin-bottom: 5px; padding: 0 3px;}
    textarea {width: 100%;}
</style>> 