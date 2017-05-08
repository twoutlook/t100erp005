#該程式未解開Section, 採用最新樣板產出!
{<section id="anmq940_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2016-03-21 17:01:00), PR版次:0001(2016-03-18 15:07:47)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000024
#+ Filename...: anmq940_x01
#+ Description: ...
#+ Creator....: 02114(2016-03-17 14:31:30)
#+ Modifier...: 02114 -SD/PR- 02114
 
{</section>}
 
{<section id="anmq940_x01.global" readonly="Y" >}
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
       a1 STRING,                  #Temp table name 
       a2 LIKE type_t.num5          #hide_flag
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="anmq940_x01.main" readonly="Y" >}
PUBLIC FUNCTION anmq940_x01(p_arg1,p_arg2,p_arg3)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 STRING                  #tm.a1  Temp table name 
DEFINE  p_arg3 LIKE type_t.num5         #tm.a2  hide_flag
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.a1 = p_arg2
   LET tm.a2 = p_arg3
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "anmq940_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL anmq940_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL anmq940_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL anmq940_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL anmq940_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL anmq940_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="anmq940_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION anmq940_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "l_seq.type_t.num10,nmfd002.nmfd_t.nmfd002,l_nmfd002_desc.type_t.chr80,l_nmbd003_desc.type_t.chr80,l_nmbd004_desc.type_t.chr80,l_sum.type_t.num20_6,l_date1.type_t.num20_6,l_date2.type_t.num20_6,l_date3.type_t.num20_6,l_date4.type_t.num20_6,l_date5.type_t.num20_6,l_date6.type_t.num20_6,l_date7.type_t.num20_6,l_date8.type_t.num20_6,l_date9.type_t.num20_6,l_date10.type_t.num20_6,l_date11.type_t.num20_6,l_date12.type_t.num20_6,l_date13.type_t.num20_6,l_date14.type_t.num20_6,l_date15.type_t.num20_6,l_date16.type_t.num20_6,l_date17.type_t.num20_6,l_date18.type_t.num20_6,l_date19.type_t.num20_6,l_date20.type_t.num20_6,l_date21.type_t.num20_6,l_date22.type_t.num20_6,l_date23.type_t.num20_6,l_date24.type_t.num20_6,l_date25.type_t.num20_6,l_date26.type_t.num20_6,l_date27.type_t.num20_6,l_date28.type_t.num20_6,l_date29.type_t.num20_6,l_date30.type_t.num20_6,l_date31.type_t.num20_6,l_date32.type_t.num20_6,l_date33.type_t.num20_6,l_date34.type_t.num20_6,l_date35.type_t.num20_6,l_date36.type_t.num20_6,l_date37.type_t.num20_6,l_date38.type_t.num20_6,l_date39.type_t.num20_6,l_date40.type_t.num20_6,l_date41.type_t.num20_6,l_date42.type_t.num20_6,l_date43.type_t.num20_6,l_date44.type_t.num20_6,l_date45.type_t.num20_6,l_date46.type_t.num20_6,l_date47.type_t.num20_6,l_date48.type_t.num20_6,l_date49.type_t.num20_6,l_date50.type_t.num20_6,l_date51.type_t.num20_6,l_date52.type_t.num20_6,l_date53.type_t.num20_6,l_date54.type_t.num20_6,l_date55.type_t.num20_6,l_date56.type_t.num20_6,l_date57.type_t.num20_6,l_date58.type_t.num20_6,l_date59.type_t.num20_6,l_date60.type_t.num20_6,l_date61.type_t.num20_6,l_date62.type_t.num20_6,l_date63.type_t.num20_6,l_date64.type_t.num20_6,l_date65.type_t.num20_6,l_date66.type_t.num20_6,l_date67.type_t.num20_6,l_date68.type_t.num20_6,l_date69.type_t.num20_6,l_date70.type_t.num20_6,l_date71.type_t.num20_6,l_date72.type_t.num20_6,l_date73.type_t.num20_6,l_date74.type_t.num20_6,l_date75.type_t.num20_6,l_date76.type_t.num20_6,l_date77.type_t.num20_6,l_date78.type_t.num20_6,l_date79.type_t.num20_6,l_date80.type_t.num20_6,l_date81.type_t.num20_6,l_date82.type_t.num20_6,l_date83.type_t.num20_6,l_date84.type_t.num20_6,l_date85.type_t.num20_6,l_date86.type_t.num20_6,l_date87.type_t.num20_6,l_date88.type_t.num20_6,l_date89.type_t.num20_6,l_date90.type_t.num20_6,l_date91.type_t.num20_6,l_date92.type_t.num20_6,l_date93.type_t.num20_6,l_date94.type_t.num20_6,l_date95.type_t.num20_6,l_date96.type_t.num20_6,l_date97.type_t.num20_6,l_date98.type_t.num20_6,l_date99.type_t.num20_6,l_date100.type_t.num20_6" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="anmq940_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION anmq940_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?, 
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?, 
             ?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="anmq940_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION anmq940_x01_sel_prep()
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
   
   #end add-point
   LET g_select = " SELECT 0,nmfd002,NULL,NULL,NULL,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 
       0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 
       0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,nmfdsite,nmfdent"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   
   #end add-point
    LET g_from = " FROM nmfd_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("nmfd_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = " SELECT * FROM ", tm.a1 CLIPPED,
               "  ORDER BY seq"
   #end add-point
   PREPARE anmq940_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE anmq940_x01_curs CURSOR FOR anmq940_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="anmq940_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION anmq940_x01_ins_data()
DEFINE sr RECORD 
   l_seq LIKE type_t.num10, 
   nmfd002 LIKE nmfd_t.nmfd002, 
   l_nmfd002_desc LIKE type_t.chr80, 
   l_nmbd003_desc LIKE type_t.chr80, 
   l_nmbd004_desc LIKE type_t.chr80, 
   l_sum LIKE type_t.num20_6, 
   l_date1 LIKE type_t.num20_6, 
   l_date2 LIKE type_t.num20_6, 
   l_date3 LIKE type_t.num20_6, 
   l_date4 LIKE type_t.num20_6, 
   l_date5 LIKE type_t.num20_6, 
   l_date6 LIKE type_t.num20_6, 
   l_date7 LIKE type_t.num20_6, 
   l_date8 LIKE type_t.num20_6, 
   l_date9 LIKE type_t.num20_6, 
   l_date10 LIKE type_t.num20_6, 
   l_date11 LIKE type_t.num20_6, 
   l_date12 LIKE type_t.num20_6, 
   l_date13 LIKE type_t.num20_6, 
   l_date14 LIKE type_t.num20_6, 
   l_date15 LIKE type_t.num20_6, 
   l_date16 LIKE type_t.num20_6, 
   l_date17 LIKE type_t.num20_6, 
   l_date18 LIKE type_t.num20_6, 
   l_date19 LIKE type_t.num20_6, 
   l_date20 LIKE type_t.num20_6, 
   l_date21 LIKE type_t.num20_6, 
   l_date22 LIKE type_t.num20_6, 
   l_date23 LIKE type_t.num20_6, 
   l_date24 LIKE type_t.num20_6, 
   l_date25 LIKE type_t.num20_6, 
   l_date26 LIKE type_t.num20_6, 
   l_date27 LIKE type_t.num20_6, 
   l_date28 LIKE type_t.num20_6, 
   l_date29 LIKE type_t.num20_6, 
   l_date30 LIKE type_t.num20_6, 
   l_date31 LIKE type_t.num20_6, 
   l_date32 LIKE type_t.num20_6, 
   l_date33 LIKE type_t.num20_6, 
   l_date34 LIKE type_t.num20_6, 
   l_date35 LIKE type_t.num20_6, 
   l_date36 LIKE type_t.num20_6, 
   l_date37 LIKE type_t.num20_6, 
   l_date38 LIKE type_t.num20_6, 
   l_date39 LIKE type_t.num20_6, 
   l_date40 LIKE type_t.num20_6, 
   l_date41 LIKE type_t.num20_6, 
   l_date42 LIKE type_t.num20_6, 
   l_date43 LIKE type_t.num20_6, 
   l_date44 LIKE type_t.num20_6, 
   l_date45 LIKE type_t.num20_6, 
   l_date46 LIKE type_t.num20_6, 
   l_date47 LIKE type_t.num20_6, 
   l_date48 LIKE type_t.num20_6, 
   l_date49 LIKE type_t.num20_6, 
   l_date50 LIKE type_t.num20_6, 
   l_date51 LIKE type_t.num20_6, 
   l_date52 LIKE type_t.num20_6, 
   l_date53 LIKE type_t.num20_6, 
   l_date54 LIKE type_t.num20_6, 
   l_date55 LIKE type_t.num20_6, 
   l_date56 LIKE type_t.num20_6, 
   l_date57 LIKE type_t.num20_6, 
   l_date58 LIKE type_t.num20_6, 
   l_date59 LIKE type_t.num20_6, 
   l_date60 LIKE type_t.num20_6, 
   l_date61 LIKE type_t.num20_6, 
   l_date62 LIKE type_t.num20_6, 
   l_date63 LIKE type_t.num20_6, 
   l_date64 LIKE type_t.num20_6, 
   l_date65 LIKE type_t.num20_6, 
   l_date66 LIKE type_t.num20_6, 
   l_date67 LIKE type_t.num20_6, 
   l_date68 LIKE type_t.num20_6, 
   l_date69 LIKE type_t.num20_6, 
   l_date70 LIKE type_t.num20_6, 
   l_date71 LIKE type_t.num20_6, 
   l_date72 LIKE type_t.num20_6, 
   l_date73 LIKE type_t.num20_6, 
   l_date74 LIKE type_t.num20_6, 
   l_date75 LIKE type_t.num20_6, 
   l_date76 LIKE type_t.num20_6, 
   l_date77 LIKE type_t.num20_6, 
   l_date78 LIKE type_t.num20_6, 
   l_date79 LIKE type_t.num20_6, 
   l_date80 LIKE type_t.num20_6, 
   l_date81 LIKE type_t.num20_6, 
   l_date82 LIKE type_t.num20_6, 
   l_date83 LIKE type_t.num20_6, 
   l_date84 LIKE type_t.num20_6, 
   l_date85 LIKE type_t.num20_6, 
   l_date86 LIKE type_t.num20_6, 
   l_date87 LIKE type_t.num20_6, 
   l_date88 LIKE type_t.num20_6, 
   l_date89 LIKE type_t.num20_6, 
   l_date90 LIKE type_t.num20_6, 
   l_date91 LIKE type_t.num20_6, 
   l_date92 LIKE type_t.num20_6, 
   l_date93 LIKE type_t.num20_6, 
   l_date94 LIKE type_t.num20_6, 
   l_date95 LIKE type_t.num20_6, 
   l_date96 LIKE type_t.num20_6, 
   l_date97 LIKE type_t.num20_6, 
   l_date98 LIKE type_t.num20_6, 
   l_date99 LIKE type_t.num20_6, 
   l_date100 LIKE type_t.num20_6, 
   nmfdsite LIKE nmfd_t.nmfdsite, 
   nmfdent LIKE nmfd_t.nmfdent
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
   DEFINE l_i      LIKE type_t.num5
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH anmq940_x01_curs INTO sr.*                               
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
       
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.l_seq,sr.nmfd002,sr.l_nmfd002_desc,sr.l_nmbd003_desc,sr.l_nmbd004_desc,sr.l_sum,sr.l_date1,sr.l_date2,sr.l_date3,sr.l_date4,sr.l_date5,sr.l_date6,sr.l_date7,sr.l_date8,sr.l_date9,sr.l_date10,sr.l_date11,sr.l_date12,sr.l_date13,sr.l_date14,sr.l_date15,sr.l_date16,sr.l_date17,sr.l_date18,sr.l_date19,sr.l_date20,sr.l_date21,sr.l_date22,sr.l_date23,sr.l_date24,sr.l_date25,sr.l_date26,sr.l_date27,sr.l_date28,sr.l_date29,sr.l_date30,sr.l_date31,sr.l_date32,sr.l_date33,sr.l_date34,sr.l_date35,sr.l_date36,sr.l_date37,sr.l_date38,sr.l_date39,sr.l_date40,sr.l_date41,sr.l_date42,sr.l_date43,sr.l_date44,sr.l_date45,sr.l_date46,sr.l_date47,sr.l_date48,sr.l_date49,sr.l_date50,sr.l_date51,sr.l_date52,sr.l_date53,sr.l_date54,sr.l_date55,sr.l_date56,sr.l_date57,sr.l_date58,sr.l_date59,sr.l_date60,sr.l_date61,sr.l_date62,sr.l_date63,sr.l_date64,sr.l_date65,sr.l_date66,sr.l_date67,sr.l_date68,sr.l_date69,sr.l_date70,sr.l_date71,sr.l_date72,sr.l_date73,sr.l_date74,sr.l_date75,sr.l_date76,sr.l_date77,sr.l_date78,sr.l_date79,sr.l_date80,sr.l_date81,sr.l_date82,sr.l_date83,sr.l_date84,sr.l_date85,sr.l_date86,sr.l_date87,sr.l_date88,sr.l_date89,sr.l_date90,sr.l_date91,sr.l_date92,sr.l_date93,sr.l_date94,sr.l_date95,sr.l_date96,sr.l_date97,sr.l_date98,sr.l_date99,sr.l_date100
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "anmq940_x01_execute"
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
    LET g_xgrid.visible_column = NULL
    IF tm.a2 < 100 THEN
       FOR l_i = 100 TO tm.a2 STEP -1
          IF NOT cl_null(g_xgrid.visible_column)THEN       
             LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED,"|"
          END IF
          LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED ,"l_date" CLIPPED,l_i USING '<<<<<' CLIPPED
       END FOR
    END IF
    LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED,"|","l_seq"
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="anmq940_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION anmq940_x01_rep_data()
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
 
{<section id="anmq940_x01.other_function" readonly="Y" >}

 
{</section>}
 
