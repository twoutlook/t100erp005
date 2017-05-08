
PRIVATE TYPE type_g_field        RECORD
   seq         LIKE type_t.num10,      #序號
   gzgg001     LIKE gzgg_t.gzgg001,    #報表欄位代碼
   gzge003     LIKE gzge_t.gzge003,    #報表欄位說明
   gzgg019     LIKE gzgg_t.gzgg019,    #區塊類別(單頭/單身)
   posx        STRING,                 #定位點X
   posy        STRING,                 #定位點Y
   gzgg005     LIKE gzgg_t.gzgg005,    #欄位寬度
   gzgg027     LIKE gzgg_t.gzgg027,    #行序
   gzgg004     LIKE gzgg_t.gzgg004,    #欄位順序
   l_font      STRING,                 #字型
   l_size      DECIMAL,                #字型大小
   l_bold      LIKE type_t.chr1,       #粗體否
   color       STRING,                 #顏色
   lblwid      STRING,                 #欄位說明寬度
   lblfont     STRING,                 #欄位說明字型
   lblsize     DECIMAL,                #欄位說明字型大小
   lblbold     LIKE type_t.chr1,       #欄位說明粗體否
   lblcolor    STRING,                 #欄位說明顏色
   l_wrap      LIKE type_t.chr1,       #折行否
   vc          STRING,                 #隱藏否
   lblbvc      STRING,                 #欄位說明隱藏否
   agl         LIKE type_t.chr1,       #欄位對齊
   lblagl      LIKE type_t.chr1,       #欄位說明對齊
   vcrtl       STRING,                 #控制欄位隱藏公式
   lblvcrtl    STRING,                 #欄位說明隱藏公式
   draw        STRING,                 #物件名稱
   lbldraw     STRING                  #欄位物件名稱   
END RECORD

PRIVATE DEFINE ga_field_new         DYNAMIC ARRAY OF type_g_field
PRIVATE DEFINE ga_field_old         DYNAMIC ARRAY OF type_g_field

#指定檔案比對程式資訊
TYPE T_FILE_INFO RECORD
                 left_orig  STRING,
                 right_orig STRING
                 END RECORD
