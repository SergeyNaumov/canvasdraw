from fastapi import FastAPI, APIRouter
from config import config
from db import db,db_read,db_write
#from fastapi_mail import FastMail, MessageSchema,ConnectionConfig
from parse.InvestingCom.rates_list import get_key_list



router = APIRouter()


@router.get('/')
async def test_headers():
  comp_list=db.get(table='investing_com_stock')
  return {
    'success':True,
    
    'data':{
      'comp_list':comp_list,
      'key_list':key_list
    }
  }

