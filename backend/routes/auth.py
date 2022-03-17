from fastapi import FastAPI, APIRouter
from config import config
from db import db
#from fastapi_mail import FastMail, MessageSchema,ConnectionConfig
from lib.engine import s
from lib.session import *


router = APIRouter()


@router.get('/auth')
async def test_headers():
  #comp_list=db.get(table='investing_com_stock')
  return {
    'success':True,
    
    'data':{

    }
  }

@router.post('/login')
async def login(R: dict):
  # insert into manager(id,login,password,name) values(1,'admin', sha2('RZzVYUHs',256),'Администратор' );
  
  response={'success':False}
  if R:
    response=session_create(
      s,
      login=R['login'],
      password=R['password'],
      ip=s.env['x-real-ip'],
      encrypt_method=config['encrypt_method'],
      max_fails_login=10,
      max_fails_login_interval=3600,
      max_fails_ip=20,
      max_fails_ip_interval=3600
    )

  return response