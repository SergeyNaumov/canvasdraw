# UPDATE manager set password=sha2('123',256);
config={
  'connect':{
      'user':'marketplace',
      'password':'',
      'host':'localhost',
      'dbname':'marketplace',
  },
  'encrypt_method':'mysql_sha2',
  'login':{
    'register':True, # возможность регистрации
    'remember':True, # возможность напоминания пароля
    
    # Доступно без авторизации
    'not_login_access': [
        '/login','/test/mailsend','/register','/remember/get-access-code','/remember/check-access-code','/remember/change-password'
    ]
  },
  'debug':{ # для отладки
    'hosts':['!!!sv-home','sv-digital','sv-HP-EliteBook-2570p','asus-tarusa'],
    'manager_id': 328, # представитель ООО "Ринал"

    
  },

}