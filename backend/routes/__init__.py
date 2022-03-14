from fastapi import APIRouter
#from config import config
from db import db
from .auth import router as auth


# Роутеры, не входящие в систему
#from .testing import router as router_testing
#from .anna import router as router_anna

# Расширения
#from .extend_routes import router as router_extend

router = APIRouter()

router.include_router(auth, prefix='/auth')






#router.include_router(router_admin_table)

@router.get("/")
async def mainpage():
  
  return {
    'ok':True,
  }






