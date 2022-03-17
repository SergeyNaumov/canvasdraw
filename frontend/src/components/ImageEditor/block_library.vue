<template>
<div>
    <div class="mt-10" >
        <div> Библиотека блоков <a href="" @click.prevent="show_objects_list=!show_objects_list">{{show_objects_list?'скрыть':'показать'}}</a>:</div>
        <div style="border: 1px solid black; padding: 10px" v-if="show_objects_list">
            <div v-for="(o,idx) in objects_list" :key="idx">             
                <div class="list_header"><a href="#" @click.prevent="loadBlock(o.object)">{{o.header}}</a></div>
                <v-icon small @click.prevent="deleteBlock(o.id)">mdi-delete</v-icon>

            </div>

            <div class="mt-10" v-if="selectedBlock">
                <v-btn @click.prevent="step=2" x-small color="primary" v-if="step==1">сохранить в библиотеку</v-btn>
                <div v-if="step==2">
                    <div class="success" v-if="success">Объект успешно сохранён</div>
                    <div v-else>
                        <v-text-field v-model="header" label="введите название объекта"/>
                        <v-btn @click.prevent="saveBlock()" x-small color="primary" >сохранить</v-btn>
                    </div>
                    
                </div>
            </div>
        </div>

    </div>

    <div class="mt-10">
        <div> Библиотека шаблонов <a href="" @click.prevent="show_templates_list=!show_templates_list">{{show_templates_list?'скрыть':'показать'}}</a>:</div>
        <div style="border: 1px solid black; padding: 10px" v-if="show_templates_list">
            <template v-if="templates_list.length">
                <div v-for="(t,idx) in templates_list" :key="idx">
                    <div class="list_header"><a href="#" @click.prevent="loadTemplate(t.id)">{{t.header}}</a></div>
                    <v-icon small @click.prevent="deleteTemplate(t.id)">mdi-delete</v-icon>
                </div>
            </template>
            <template v-else>
                нет сохранённых шаблонов
            </template>

            <div class="mt-10">
                <v-btn @click.prevent="template_step=2" x-small color="primary" v-if="block_list.length && template_step==1">сохранить в библиотеку</v-btn>
                <div v-if="template_step==2">
                    <div class="success" v-if="template_success">Шаблон успешно сохранён</div>
                    <div v-else>
                        <v-text-field v-model="header_template" label="введите название шаблона"/>
                        <v-btn @click.prevent="saveTemplate()" :disabled="!block_list.length || !header_template" x-small color="primary" >сохранить</v-btn>
                    </div>
                    
                </div>
            </div>

        </div>
    </div>

    
</div>

</template>
<script>

export default({
    name: 'block_library',
    props:['selectedBlock','loadBlock','block_list','delete_all_blocks'],
    mounted(){
        this.init_blocks()
        this.init_templates()
    },
    components: {},
    data(){
        return {
            show_templates_list: false,
            template_step: 1,
            templates_list: [],
            show_objects_list: false,
            objects_list:[],
            step:1,
            success:false,
            template_success:false,
            header:'',
            header_template:''
        }
    },
    watch:{

    },
    methods:{
        init_templates(){
            this.$http.get({
                url:'/canvas-editor/load-all-templates',
                success: d=>{
                    this.templates_list=d.list
                }
            })
        },
        init_blocks(){
            this.$http.get({
                url:'/canvas-editor/load-all-objects',
                success: d=>{
                    this.objects_list=d.list
                }
            })
        },
        saveBlock(){
            if(this.selectedBlock){
                
                this.$http.post({
                    url:'/canvas-editor/save-object',
                    data:{
                        block:this.selectedBlock,
                        header: this.header
                    },
                    success: d=>{
                        this.success=true
                        setTimeout(
                            ()=>{
                                this.success=false, this.step=1, this.header=''
                                this.init_blocks()
                            },1000
                        )
                    }
                })
            }
            
        },
        deleteBlock(id){
            this.$http.get({
                url:`/canvas-editor/delete-object/${id}`,
                success:d=>{
                    this.init_blocks()
                }
            })
        },
        saveTemplate(){
            if(this.block_list.length){
                this.$http.post({
                    url:'/canvas-editor/save-template',
                    data:{
                        header: this.header_template,
                        list:this.block_list
                    },
                    success:d=>{
                        this.template_success=true
                        setTimeout(
                            ()=>{
                                this.success=false, this.step=1, this.header_template=''
                                this.init_templates()
                            },1000
                        )
                        
                    }
                })
            }
        },
        deleteTemplate(id){
            this.$http.get({
                url:`/canvas-editor/delete-template/${id}`,
                success:d=>{
                    this.init_templates()
                }
            })
        },
        loadTemplate(template_id){
            this.$http.get({
                url:`/canvas-editor/load-template/${template_id}`,
                success: d=>{
                    this.delete_all_blocks()
                    let list=JSON.parse(d.template)
                    for(let b of list){
                        this.loadBlock(b)
                    }
                    

                }
            })

        }
    },
    computed:{
        make_save_graph(){
            return (window.app.manager && window.app.manager.make_save_graph==1)?true:false

            
        }
    }
})
</script>
<style scoped>
    .list_header{
        display: inline-block; width: calc( 100% - 20px)
    }
</style>

