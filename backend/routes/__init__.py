from fastapi import APIRouter
#from config import config
from db import db
from .auth import router as auth
from .canvas_editor import router as canvas_editor
from lib.engine import s

# Роутеры, не входящие в систему
#from .testing import router as router_testing
#from .anna import router as router_anna

# Расширения
#from .extend_routes import router as router_extend

router = APIRouter()

router.include_router(auth, prefix='')
router.include_router(canvas_editor, prefix='/canvas-editor')

#router.include_router(router_admin_table)

@router.get("/")
async def startpage():
  
  return {
    'success':True,
    'manager':s.manager
  }






