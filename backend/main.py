from fastapi import FastAPI, Request, Response, Header
from fastapi.middleware.cors import CORSMiddleware

from lib.engine import s
from routes import router

# uvicorn main:app --reload --port=7000
app = FastAPI(Debug=True)
@app.middleware("http")
async def for_all_requests(request: Request,call_next, response=Response):
  response_obj=response()

  s.reset(
    request=request,
    status_code=200
    #response=response_obj
  )

  if( s._end):
    response=Response(s.to_json(s._content))
    #print('Response:',R.headers)
    #return response
  else:

    response = await call_next(request)
    # set cookies
    for k in s.cookies.keys():
      response.set_cookie(key=k,value=s.cookies[k])
    # delete_cookies
    for k in s.cookies_for_delete:
      response.delete_cookie(k)
    
    # print_headers
    for h in s.headers:
      response.headers[h[0]] = h[1]

  return response
app.include_router(router)
