from fastapi import FastAPI, APIRouter
from config import config
from db import db

from lib.engine import s
import json 


router = APIRouter()
# все блоки
@router.get('/load-all-objects')
async def load_all_objects():
    all_objects=db.query(
        query='''
            SELECT * from obj_library order by header
        '''
    )
    return {
        'success':True,
        'list':all_objects
    }
# все шаблоны 
@router.get('/load-all-templates')
async def load_all_objects():
    all_templates=db.query(
        query='''
            SELECT * from obj_template order by header
        '''
    )
    return {
        'success':True,
        'list':all_templates
    }

# Сохранение блока
@router.post('/save-object')
async def save_object(r: dict):
    if not s.manager['make_save_graph']:
        return {'success':False,'errors':['Нет прав для сохранения объекта']}

    success=True
    errors=[]
    r['block']=json.dumps(r['block'])
    #print('block:', json.dumps(r['block']))
    if not r['header']:
        errors.append('Вы не указани название объекта')
    
    if len(errors):
        success=False
    else:
        log=''
        db.save(
            table='obj_library',
            data={
                'header': r['header'],
                'object': r['block'],
                'manager_id': s.manager['id']
            },
            log=log,
            debug=1
        )
    return {'success':success, 'errors':errors}

# Удаление блока из библиотеки
@router.get('/delete-object/{id}')
async def delete_object(id:int):
    success=False
    errors=[]
    if s.manager['make_save_graph']:
        success=True
        db.query(
            query="DELETE FROM obj_library WHERE id=%s",
            values=[id]
        )
    else:
        errors.append('Нет прав для удаления объекта')

    return {'success':success,'errors':errors}

# Сохранение шаблона
@router.post('/save-template')
async def save_template(r:dict):
    if not s.manager['make_save_graph']:
        return {'success':False,'errors':['Нет прав для сохранения шаблона']}

    success=True
    errors=[]
    r['list']=json.dumps(r['list'])
    #print('block:', json.dumps(r['block']))
    if not r['header']:
        errors.append('Вы не указани название шаблона')
    
    if len(errors):
        success=False
    else:
        
        db.save(
            table='obj_template',
            data={
                'header': r['header'],
                'template': r['list'],
                'manager_id': s.manager['id']
            },
            
            debug=1
        )
    return {'success':success, 'errors':errors}

# Удаление шаблона из библиотеки
@router.get('/delete-template/{id}')
async def delete_object(id:int):
    success=False
    errors=[]
    if s.manager['make_save_graph']:
        success=True
        db.query(
            query="DELETE FROM obj_template WHERE id=%s",
            values=[id]
        )
    else:
        errors.append('Нет прав для удаления шаблона')

    return {'success':success,'errors':errors}


# Загрузка шаблона
@router.get('/load-template/{id}')
async def load_template(id:int):
    success=True
    errors=[]
    template=db.query(
        query="select template from obj_template where id=%s",
        values=[id],
        onevalue=1
    )
    if not(template):
        success=False

    return {
        'success': success,
        'errors':errors,
        'template': template
    }