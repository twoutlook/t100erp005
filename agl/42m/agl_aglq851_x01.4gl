#該程式未解開Section, 採用最新樣板產出!
{<section id="aglq851_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2016-08-01 15:04:31), PR版次:0002(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000041
#+ Filename...: aglq851_x01
#+ Description: ...
#+ Creator....: 02114(2015-05-27 14:27:54)
#+ Modifier...: 08742 -SD/PR- 00000
 
{</section>}
 
{<section id="aglq851_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#160727-00019#3  2016/08/01  By 08742  系统中定义的临时表名称超过15码在执行时会出错,所以需要将系统中定义的临时表长度超过15码的全部改掉	 	
#                                      Mod   aglq851_print_tmp -->aglq851_tmp01
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
       a1 STRING,                  #aglq851_print_tmp 
       a2 LIKE type_t.num5,         #hide_flag 
       a3 LIKE type_t.chr10          #type
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_type           LIKE type_t.chr10
#end add-point
 
{</section>}
 
{<section id="aglq851_x01.main" readonly="Y" >}
PUBLIC FUNCTION aglq851_x01(p_arg1,p_arg2,p_arg3,p_arg4)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 STRING                  #tm.a1  aglq851_print_tmp 
DEFINE  p_arg3 LIKE type_t.num5         #tm.a2  hide_flag 
DEFINE  p_arg4 LIKE type_t.chr10         #tm.a3  type
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.a1 = p_arg2
   LET tm.a2 = p_arg3
   LET tm.a3 = p_arg4
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   LET g_type = p_arg4
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "aglq851_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL aglq851_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL aglq851_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL aglq851_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL aglq851_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL aglq851_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="aglq851_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION aglq851_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "glaq002.glaq_t.glaq002,glaq002_desc.type_t.chr80,l_amt1.type_t.num20_6,l_amt2.type_t.num20_6,l_amt3.type_t.num20_6,l_amt4.type_t.num20_6,l_amt5.type_t.num20_6,l_amt6.type_t.num20_6,l_amt7.type_t.num20_6,l_amt8.type_t.num20_6,l_amt9.type_t.num20_6,l_amt10.type_t.num20_6,l_amt11.type_t.num20_6,l_amt12.type_t.num20_6,l_amt13.type_t.num20_6,l_amt14.type_t.num20_6,l_amt15.type_t.num20_6,l_amt16.type_t.num20_6,l_amt17.type_t.num20_6,l_amt18.type_t.num20_6,l_amt19.type_t.num20_6,l_amt20.type_t.num20_6,l_amt21.type_t.num20_6,l_amt22.type_t.chr30,l_amt23.type_t.num20_6,l_amt24.type_t.num20_6,l_amt25.type_t.num20_6,l_amt26.type_t.num20_6,l_amt27.type_t.num20_6,l_amt28.type_t.num20_6,l_amt29.type_t.num20_6,l_amt30.type_t.num20_6,l_amt31.type_t.num20_6,l_amt32.type_t.num20_6,l_amt33.type_t.num20_6,l_amt34.type_t.num20_6,l_amt35.type_t.num20_6,l_amt36.type_t.num20_6,l_amt37.type_t.num20_6,l_amt38.type_t.num20_6,l_amt39.type_t.num20_6,l_amt40.type_t.num20_6,l_amt41.type_t.num20_6,l_amt42.type_t.num20_6,l_amt43.type_t.num20_6,l_amt44.type_t.num20_6,l_amt45.type_t.num20_6,l_amt46.type_t.num20_6,l_amt47.type_t.num20_6,l_amt48.type_t.num20_6,l_amt49.type_t.num20_6,l_amt50.type_t.num20_6,l_amt51.type_t.num20_6,l_amt52.type_t.num20_6,l_amt53.type_t.num20_6,l_amt54.type_t.num20_6,l_amt55.type_t.num20_6,l_amt56.type_t.num20_6,l_amt57.type_t.num20_6,l_amt58.type_t.num20_6,l_amt59.type_t.num20_6,l_amt60.type_t.num20_6,l_amt61.type_t.num20_6,l_amt62.type_t.num20_6,l_amt63.type_t.num20_6,l_amt64.type_t.num20_6,l_amt65.type_t.num20_6,l_amt66.type_t.num20_6,l_amt67.type_t.num20_6,l_amt68.type_t.num20_6,l_amt69.type_t.num20_6,l_amt70.type_t.num20_6,l_amt71.type_t.num20_6,l_amt72.type_t.num20_6,l_amt73.type_t.num20_6,l_amt74.type_t.num20_6,l_amt75.type_t.num20_6,l_amt76.type_t.num20_6,l_amt77.type_t.num20_6,l_amt78.type_t.num20_6,l_amt79.type_t.num20_6,l_amt80.type_t.num20_6,l_amt81.type_t.num20_6,l_amt82.type_t.num20_6,l_amt83.type_t.num20_6,l_amt84.type_t.num20_6,l_amt85.type_t.num20_6,l_amt86.type_t.num20_6,l_amt87.type_t.num20_6,l_amt88.type_t.num20_6,l_amt89.type_t.num20_6,l_amt90.type_t.num20_6,l_amt91.type_t.num20_6,l_amt92.type_t.num20_6,l_amt93.type_t.num20_6,l_amt94.type_t.num20_6,l_amt95.type_t.num20_6,l_amt96.type_t.num20_6,l_amt97.type_t.num20_6,l_amt98.type_t.num20_6,l_amt99.type_t.num20_6,l_amt100.type_t.num20_6" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="aglq851_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION aglq851_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?)"
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
 
{<section id="aglq851_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aglq851_x01_sel_prep()
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
   LET g_select = " SELECT glaq002,'',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 
       0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 
       0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   
   #end add-point
    LET g_from = " FROM glaq_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("glaq_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = " SELECT * FROM ", tm.a1 CLIPPED
   #end add-point
   PREPARE aglq851_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE aglq851_x01_curs CURSOR FOR aglq851_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aglq851_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION aglq851_x01_ins_data()
DEFINE sr RECORD 
   glaq002 LIKE glaq_t.glaq002, 
   glaq002_desc LIKE type_t.chr80, 
   l_amt1 LIKE type_t.num20_6, 
   l_amt2 LIKE type_t.num20_6, 
   l_amt3 LIKE type_t.num20_6, 
   l_amt4 LIKE type_t.num20_6, 
   l_amt5 LIKE type_t.num20_6, 
   l_amt6 LIKE type_t.num20_6, 
   l_amt7 LIKE type_t.num20_6, 
   l_amt8 LIKE type_t.num20_6, 
   l_amt9 LIKE type_t.num20_6, 
   l_amt10 LIKE type_t.num20_6, 
   l_amt11 LIKE type_t.num20_6, 
   l_amt12 LIKE type_t.num20_6, 
   l_amt13 LIKE type_t.num20_6, 
   l_amt14 LIKE type_t.num20_6, 
   l_amt15 LIKE type_t.num20_6, 
   l_amt16 LIKE type_t.num20_6, 
   l_amt17 LIKE type_t.num20_6, 
   l_amt18 LIKE type_t.num20_6, 
   l_amt19 LIKE type_t.num20_6, 
   l_amt20 LIKE type_t.num20_6, 
   l_amt21 LIKE type_t.num20_6, 
   l_amt22 LIKE type_t.chr30, 
   l_amt23 LIKE type_t.num20_6, 
   l_amt24 LIKE type_t.num20_6, 
   l_amt25 LIKE type_t.num20_6, 
   l_amt26 LIKE type_t.num20_6, 
   l_amt27 LIKE type_t.num20_6, 
   l_amt28 LIKE type_t.num20_6, 
   l_amt29 LIKE type_t.num20_6, 
   l_amt30 LIKE type_t.num20_6, 
   l_amt31 LIKE type_t.num20_6, 
   l_amt32 LIKE type_t.num20_6, 
   l_amt33 LIKE type_t.num20_6, 
   l_amt34 LIKE type_t.num20_6, 
   l_amt35 LIKE type_t.num20_6, 
   l_amt36 LIKE type_t.num20_6, 
   l_amt37 LIKE type_t.num20_6, 
   l_amt38 LIKE type_t.num20_6, 
   l_amt39 LIKE type_t.num20_6, 
   l_amt40 LIKE type_t.num20_6, 
   l_amt41 LIKE type_t.num20_6, 
   l_amt42 LIKE type_t.num20_6, 
   l_amt43 LIKE type_t.num20_6, 
   l_amt44 LIKE type_t.num20_6, 
   l_amt45 LIKE type_t.num20_6, 
   l_amt46 LIKE type_t.num20_6, 
   l_amt47 LIKE type_t.num20_6, 
   l_amt48 LIKE type_t.num20_6, 
   l_amt49 LIKE type_t.num20_6, 
   l_amt50 LIKE type_t.num20_6, 
   l_amt51 LIKE type_t.num20_6, 
   l_amt52 LIKE type_t.num20_6, 
   l_amt53 LIKE type_t.num20_6, 
   l_amt54 LIKE type_t.num20_6, 
   l_amt55 LIKE type_t.num20_6, 
   l_amt56 LIKE type_t.num20_6, 
   l_amt57 LIKE type_t.num20_6, 
   l_amt58 LIKE type_t.num20_6, 
   l_amt59 LIKE type_t.num20_6, 
   l_amt60 LIKE type_t.num20_6, 
   l_amt61 LIKE type_t.num20_6, 
   l_amt62 LIKE type_t.num20_6, 
   l_amt63 LIKE type_t.num20_6, 
   l_amt64 LIKE type_t.num20_6, 
   l_amt65 LIKE type_t.num20_6, 
   l_amt66 LIKE type_t.num20_6, 
   l_amt67 LIKE type_t.num20_6, 
   l_amt68 LIKE type_t.num20_6, 
   l_amt69 LIKE type_t.num20_6, 
   l_amt70 LIKE type_t.num20_6, 
   l_amt71 LIKE type_t.num20_6, 
   l_amt72 LIKE type_t.num20_6, 
   l_amt73 LIKE type_t.num20_6, 
   l_amt74 LIKE type_t.num20_6, 
   l_amt75 LIKE type_t.num20_6, 
   l_amt76 LIKE type_t.num20_6, 
   l_amt77 LIKE type_t.num20_6, 
   l_amt78 LIKE type_t.num20_6, 
   l_amt79 LIKE type_t.num20_6, 
   l_amt80 LIKE type_t.num20_6, 
   l_amt81 LIKE type_t.num20_6, 
   l_amt82 LIKE type_t.num20_6, 
   l_amt83 LIKE type_t.num20_6, 
   l_amt84 LIKE type_t.num20_6, 
   l_amt85 LIKE type_t.num20_6, 
   l_amt86 LIKE type_t.num20_6, 
   l_amt87 LIKE type_t.num20_6, 
   l_amt88 LIKE type_t.num20_6, 
   l_amt89 LIKE type_t.num20_6, 
   l_amt90 LIKE type_t.num20_6, 
   l_amt91 LIKE type_t.num20_6, 
   l_amt92 LIKE type_t.num20_6, 
   l_amt93 LIKE type_t.num20_6, 
   l_amt94 LIKE type_t.num20_6, 
   l_amt95 LIKE type_t.num20_6, 
   l_amt96 LIKE type_t.num20_6, 
   l_amt97 LIKE type_t.num20_6, 
   l_amt98 LIKE type_t.num20_6, 
   l_amt99 LIKE type_t.num20_6, 
   l_amt100 LIKE type_t.num20_6
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
   DEFINE l_i      LIKE type_t.num5
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH aglq851_x01_curs INTO sr.*                               
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
       EXECUTE insert_prep USING sr.glaq002,sr.glaq002_desc,sr.l_amt1,sr.l_amt2,sr.l_amt3,sr.l_amt4,sr.l_amt5,sr.l_amt6,sr.l_amt7,sr.l_amt8,sr.l_amt9,sr.l_amt10,sr.l_amt11,sr.l_amt12,sr.l_amt13,sr.l_amt14,sr.l_amt15,sr.l_amt16,sr.l_amt17,sr.l_amt18,sr.l_amt19,sr.l_amt20,sr.l_amt21,sr.l_amt22,sr.l_amt23,sr.l_amt24,sr.l_amt25,sr.l_amt26,sr.l_amt27,sr.l_amt28,sr.l_amt29,sr.l_amt30,sr.l_amt31,sr.l_amt32,sr.l_amt33,sr.l_amt34,sr.l_amt35,sr.l_amt36,sr.l_amt37,sr.l_amt38,sr.l_amt39,sr.l_amt40,sr.l_amt41,sr.l_amt42,sr.l_amt43,sr.l_amt44,sr.l_amt45,sr.l_amt46,sr.l_amt47,sr.l_amt48,sr.l_amt49,sr.l_amt50,sr.l_amt51,sr.l_amt52,sr.l_amt53,sr.l_amt54,sr.l_amt55,sr.l_amt56,sr.l_amt57,sr.l_amt58,sr.l_amt59,sr.l_amt60,sr.l_amt61,sr.l_amt62,sr.l_amt63,sr.l_amt64,sr.l_amt65,sr.l_amt66,sr.l_amt67,sr.l_amt68,sr.l_amt69,sr.l_amt70,sr.l_amt71,sr.l_amt72,sr.l_amt73,sr.l_amt74,sr.l_amt75,sr.l_amt76,sr.l_amt77,sr.l_amt78,sr.l_amt79,sr.l_amt80,sr.l_amt81,sr.l_amt82,sr.l_amt83,sr.l_amt84,sr.l_amt85,sr.l_amt86,sr.l_amt87,sr.l_amt88,sr.l_amt89,sr.l_amt90,sr.l_amt91,sr.l_amt92,sr.l_amt93,sr.l_amt94,sr.l_amt95,sr.l_amt96,sr.l_amt97,sr.l_amt98,sr.l_amt99,sr.l_amt100
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "aglq851_x01_execute"
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
       LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED ,"l_amt" CLIPPED,l_i USING '<<<<<' CLIPPED
       END FOR
    END IF
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aglq851_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION aglq851_x01_rep_data()
#add-point:rep_data.define (客製用) name="rep_data.define_customerization"

#end add-point:rep_data.define
#add-point:rep_data.define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="rep_data.define"
   DEFINE l_gzdel003     LIKE gzdel_t.gzdel003
#end add-point:rep_data.define
 
    #add-point:rep_data.before name="rep_data.before"
    LET l_gzdel003 = ''
    SELECT gzdel003 INTO l_gzdel003 
      FROM gzdel_t
     WHERE gzdel001 = 'aglq851_x01' 
       AND gzdel002 = g_dlang
        
    IF g_type = '1' THEN 
       LET g_xgrid.title2 = l_gzdel003
    END IF
    IF g_type = '2' THEN
       LET g_xgrid.title2 = l_gzdel003 CLIPPED,cl_getmsg('agl-00352',g_dlang)
    END IF
    IF g_type = '3' THEN 
       LET g_xgrid.title2 = l_gzdel003 CLIPPED,cl_getmsg('agl-00353',g_dlang)
    END IF
    LET g_rep_code_desc = g_xgrid.title2
    #end add-point:rep_data.before
    
    CALL cl_xg_view()
    #add-point:rep_data.after name="rep_data.after"
    
    #end add-point:rep_data.after
END FUNCTION
 
{</section>}
 
{<section id="aglq851_x01.other_function" readonly="Y" >}

 
{</section>}
 
