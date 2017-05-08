#該程式未解開Section, 採用最新樣板產出!
{<section id="abxr012_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2016-07-28 13:57:22), PR版次:0001(2016-08-17 11:31:39)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000016
#+ Filename...: abxr012_x01
#+ Description: ...
#+ Creator....: 08732(2016-07-25 15:08:47)
#+ Modifier...: 08732 -SD/PR- 08732
 
{</section>}
 
{<section id="abxr012_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"

#end add-point
#add-point:填寫註解說明 name="global.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_report.inc"                  #報表使用的global
 
#報表 type 宣告
DEFINE tm RECORD
       wc STRING,                  #where condition 
       ai LIKE type_t.num5,         #bxga000 
       ab LIKE type_t.num5,         #bxfa003 
       bm LIKE type_t.num5          #bxfa004
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="abxr012_x01.main" readonly="Y" >}
PUBLIC FUNCTION abxr012_x01(p_arg1,p_arg2,p_arg3,p_arg4)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.num5         #tm.ai  bxga000 
DEFINE  p_arg3 LIKE type_t.num5         #tm.ab  bxfa003 
DEFINE  p_arg4 LIKE type_t.num5         #tm.bm  bxfa004
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.ai = p_arg2
   LET tm.ab = p_arg3
   LET tm.bm = p_arg4
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "abxr012_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL abxr012_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL abxr012_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL abxr012_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL abxr012_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL abxr012_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="abxr012_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION abxr012_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "bxgadocno.bxga_t.bxgadocno,bxga001.bxga_t.bxga001,imaal_t_imaal003.imaal_t.imaal003,imaal_t_imaal004.imaal_t.imaal004,imaa_t_imaa009.imaa_t.imaa009,rtaxl_t_rtaxl003.rtaxl_t.rtaxl003,bxga005.bxga_t.bxga005,oocal_t_oocal003.oocal_t.oocal003,bxfa007.bxfa_t.bxfa007,bxga006.bxga_t.bxga006,l_bxga006_01.bxga_t.bxga006,l_bxga006_02.bxfa_t.bxfa007,l_bxfa007_01.bxfa_t.bxfa007,l_bxfa007_02.bxfa_t.bxfa007,iman_t_iman025.iman_t.iman025,l_iman025.iman_t.iman025" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="abxr012_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION abxr012_x01_ins_prep()
DEFINE i              INTEGER
DEFINE l_prep_str     STRING
#add-point:ins_prep.define (客製用) name="ins_prep.define_customerization"

#end add-point:ins_prep.define
#add-point:ins_prep.define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_prep.define"

#end add-point:ins_prep.define
 
   FOR i = 1 TO g_rep_tmpname.getLength()
      CALL cl_xg_del_data(g_rep_tmpname[i])
      #LET g_sql = g_rep_ins_prep[i]              #透過此lib取得prepare字串 lib精簡
      CASE i
         WHEN 1
         #INSERT INTO PREP
         LET g_sql = " INSERT INTO ",g_rep_db CLIPPED,g_rep_tmpname[1] CLIPPED," VALUES(?,?,?,?,?,?, 
             ?,?,?,?,?,?,?,?,?,?)"
         PREPARE insert_prep FROM g_sql
         IF STATUS THEN
            LET l_prep_str ="insert_prep",i
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_prep_str
            LET g_errparam.code   = status
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            CALL cl_xg_drop_tmptable()
            LET g_rep_success = 'N'           
         END IF 
         #add-point:insert_prep段 name="insert_prep"
         
         #end add-point                  
 
 
      END CASE
   END FOR
END FUNCTION
 
{</section>}
 
{<section id="abxr012_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION abxr012_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"

#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
   LET g_select = " SELECT bxgadocno,bxga001,imaal003,imaal004,imaa009,
                    rtaxl003,bxga005,oocal003,bxfa007,bxga006,0,0,0,0,COALESCE(iman025,0),COALESCE(0,0)"
#   #end add-point
#   LET g_select = " SELECT bxgadocno,bxga001,imaal_t.imaal003,imaal_t.imaal004,imaa_t.imaa009,rtaxl_t.rtaxl003, 
#       bxga005,oocal_t.oocal003,bxfa007,bxga006,0,0,0,0,iman_t.iman025,0"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_from = " FROM bxga_t",
                " LEFT JOIN bxfa_t ON bxfaent = bxgaent AND bxfasite = bxgasite AND bxfa001 = bxga001",
                " LEFT JOIN iman_t ON imanent = bxgaent AND imansite = bxgasite AND iman001 = bxga001",
                " LEFT JOIN imaa_t ON imaaent = bxgaent AND imaa001 = bxga001",
                " LEFT JOIN imaal_t ON imaalent = imaaent AND imaal001 = imaa001 AND imaal002 = '"||g_dlang||"'",
                " LEFT JOIN  rtaxl_t ON rtaxlent = imaaent AND rtaxl001 =imaa009 AND rtaxl002 = '"||g_dlang||"'",
                " LEFT JOIN oocal_t ON oocalent = bxgaent AND oocal001 = bxga005 AND oocal002 = '"||g_dlang||"'"
#   #end add-point
#    LET g_from = " FROM bxga_t,bxfa_t,iman_t,imaa_t,imaal_t,rtaxl_t,oocal_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_where = " WHERE bxgaent = '"||g_enterprise||"'",
                   " AND bxgasite = '"||g_site||"'",
                   " AND bxga000 ='",tm.ai,"'",
                   " AND bxfa003 ='",tm.ab,"'",
                   " AND bxfa004 ='",tm.bm,"'",
                   " AND ",tm.wc CLIPPED
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("bxga_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE abxr012_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE abxr012_x01_curs CURSOR FOR abxr012_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="abxr012_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION abxr012_x01_ins_data()
DEFINE sr RECORD 
   bxgadocno LIKE bxga_t.bxgadocno, 
   bxga001 LIKE bxga_t.bxga001, 
   imaal_t_imaal003 LIKE imaal_t.imaal003, 
   imaal_t_imaal004 LIKE imaal_t.imaal004, 
   imaa_t_imaa009 LIKE imaa_t.imaa009, 
   rtaxl_t_rtaxl003 LIKE rtaxl_t.rtaxl003, 
   bxga005 LIKE bxga_t.bxga005, 
   oocal_t_oocal003 LIKE oocal_t.oocal003, 
   bxfa007 LIKE bxfa_t.bxfa007, 
   bxga006 LIKE bxga_t.bxga006, 
   l_bxga006_01 LIKE bxga_t.bxga006, 
   l_bxga006_02 LIKE bxfa_t.bxfa007, 
   l_bxfa007_01 LIKE bxfa_t.bxfa007, 
   l_bxfa007_02 LIKE bxfa_t.bxfa007, 
   iman_t_iman025 LIKE iman_t.iman025, 
   l_iman025 LIKE iman_t.iman025
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
   DEFINE l_imaf053   LIKE imaf_t.imaf053
   DEFINE l_success   LIKE type_t.num5
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH abxr012_x01_curs INTO sr.*                               
       IF STATUS THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = 'foreach:'
          LET g_errparam.code   = STATUS
          LET g_errparam.popup  = TRUE
          CALL cl_err()
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
 
       #add-point:ins_data段foreach name="ins_data.foreach"
       LET l_imaf053 = ''
       LET l_success = ''
       LET sr.l_bxga006_01 = ''
       LET sr.l_bxga006_02 = ''
       
       IF sr.bxga006 - sr.bxfa007 > 0 THEN                           #盤盈
          LET sr.l_bxga006_01 = sr.bxga006 - sr.bxfa007              #帳面與盤點數量比較(盤盈)
          LET sr.l_bxga006_02 = 0                             
       ELSE                                                 
          LET sr.l_bxga006_01 = 0                            
          LET sr.l_bxga006_02 = (sr.bxga006 - sr.bxfa007) * (-1)      #帳面與盤點數量比較(盤虧)
       END IF                                               
       
       SELECT imaf053 INTO l_imaf053 
         FROM imaf_t 
         LEFT JOIN bxfa_t ON imafent = bxfaent AND imafsite = bxfasite AND imaf001 = bxfa001
        WHERE imafent = g_enterprise
          AND imafsite = g_site
       #帳面結存數3%數量                                     
       LET sr.l_bxfa007_01 = sr.bxfa007 * 0.03 
       
       #帳面結存數3%數量取位
       CALL s_aooi250_take_decimals(l_imaf053,sr.bxfa007) RETURNING l_success,sr.bxfa007 
       CALL s_aooi250_take_decimals(l_imaf053,sr.l_bxfa007_01) RETURNING l_success,sr.l_bxfa007_01
       
       IF  sr.l_bxga006_02 - sr.l_bxfa007_01 > 0 THEN                #帳面與盤點數量比較(盤虧) - 帳面結存數3%數量
          LET sr.l_bxfa007_02 = sr.l_bxga006_02 - sr.l_bxfa007_01    #盤虧逾帳面結存數3%以上數量 = 帳面與盤點數量比較(盤虧) - 帳面結存數3%數量
       END IF
       
       #盤虧逾帳面結存數3%以上數量總價(新台幣元) = 盤虧逾帳面結存數3%以上數量 * iman025
       LET sr.l_iman025 = sr.l_bxfa007_02 * sr.iman_t_iman025 

       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.bxgadocno,sr.bxga001,sr.imaal_t_imaal003,sr.imaal_t_imaal004,sr.imaa_t_imaa009,sr.rtaxl_t_rtaxl003,sr.bxga005,sr.oocal_t_oocal003,sr.bxfa007,sr.bxga006,sr.l_bxga006_01,sr.l_bxga006_02,sr.l_bxfa007_01,sr.l_bxfa007_02,sr.iman_t_iman025,sr.l_iman025
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "abxr012_x01_execute"
          LET g_errparam.code   = SQLCA.sqlcode
          LET g_errparam.popup  = FALSE
          CALL cl_err()       
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
 
       #add-point:ins_data段after_save name="ins_data.after.save"
       
       #end add-point
       
    END FOREACH
    
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="abxr012_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION abxr012_x01_rep_data()
#add-point:rep_data.define (客製用) name="rep_data.define_customerization"

#end add-point:rep_data.define
#add-point:rep_data.define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="rep_data.define"

#end add-point:rep_data.define
 
    #add-point:rep_data.before name="rep_data.before"
    
    #end add-point:rep_data.before
    
    CALL cl_xg_view()
    #add-point:rep_data.after name="rep_data.after"
    
    #end add-point:rep_data.after
END FUNCTION
 
{</section>}
 
{<section id="abxr012_x01.other_function" readonly="Y" >}

 
{</section>}
 
