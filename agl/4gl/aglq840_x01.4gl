#該程式未解開Section, 採用最新樣板產出!
{<section id="aglq840_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2015-10-12 10:31:09), PR版次:0001(2015-09-15 16:08:10)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000055
#+ Filename...: aglq840_x01
#+ Description: ...
#+ Creator....: 01727(2015-05-27 10:47:00)
#+ Modifier...: 02599 -SD/PR- 02599
 
{</section>}
 
{<section id="aglq840_x01.global" readonly="Y" >}
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
       a1 LIKE type_t.chr20,         #xrea_tmp 
       a2 LIKE type_t.num5,         #hide_flag 
       a3 LIKE type_t.chr1          #是否顯示XRBL
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="aglq840_x01.main" readonly="Y" >}
PUBLIC FUNCTION aglq840_x01(p_arg1,p_arg2,p_arg3,p_arg4)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr20         #tm.a1  xrea_tmp 
DEFINE  p_arg3 LIKE type_t.num5         #tm.a2  hide_flag 
DEFINE  p_arg4 LIKE type_t.chr1         #tm.a3  是否顯示XRBL
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.a1 = p_arg2
   LET tm.a2 = p_arg3
   LET tm.a3 = p_arg4
 
   #add-point:報表元件參數準備 name="component.arg.prep"
 
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "aglq840_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL aglq840_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL aglq840_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL aglq840_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL aglq840_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL aglq840_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="aglq840_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION aglq840_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "glfbseq.glfb_t.glfbseq,glfbseq1.glfb_t.glfbseq1,glfb002.glfb_t.glfb002,l_glfb002_desc.type_t.chr80,glfb003.glfb_t.glfb003,l_mon1.type_t.num20_6,l_mon2.type_t.num20_6,l_mon3.type_t.num20_6,l_mon4.type_t.num20_6,l_mon5.type_t.num20_6,l_mon6.type_t.num20_6,l_mon7.type_t.num20_6,l_mon8.type_t.num20_6,l_mon9.type_t.num20_6,l_mon10.type_t.num20_6,l_mon11.type_t.num20_6,l_mon12.type_t.num20_6,l_mon13.type_t.num20_6,l_mon14.type_t.num20_6,l_mon15.type_t.num20_6,l_mon16.type_t.num20_6,l_mon17.type_t.num20_6,l_mon18.type_t.num20_6,l_mon19.type_t.num20_6,l_mon20.type_t.num20_6,l_mon21.type_t.num20_6,l_mon22.type_t.num20_6,l_mon23.type_t.num20_6,l_mon24.type_t.num20_6,l_mon25.type_t.num20_6,l_mon26.type_t.num20_6,l_mon27.type_t.num20_6,l_mon28.type_t.num20_6,l_mon29.type_t.num20_6,l_mon30.type_t.num20_6,l_mon31.type_t.num20_6,l_mon32.type_t.num20_6,l_mon33.type_t.num20_6,l_mon34.type_t.num20_6,l_mon35.type_t.num20_6,l_mon36.type_t.num20_6,l_mon37.type_t.num20_6,l_mon38.type_t.num20_6,l_mon39.type_t.num20_6,l_mon40.type_t.num20_6,l_mon41.type_t.num20_6,l_mon42.type_t.num20_6,l_mon43.type_t.num20_6,l_mon44.type_t.num20_6,l_mon45.type_t.num20_6,l_mon46.type_t.num20_6,l_mon47.type_t.num20_6,l_mon48.type_t.num20_6,l_mon49.type_t.num20_6,l_mon50.type_t.num20_6,l_mon51.type_t.num20_6,l_mon52.type_t.num26_10,l_mon53.type_t.num20_6,l_mon54.type_t.num20_6,l_mon55.type_t.num20_6,l_mon56.type_t.num20_6,l_mon57.type_t.num20_6,l_mon58.type_t.num20_6,l_mon59.type_t.num20_6,l_mon60.type_t.num20_6,l_mon61.type_t.num20_6,l_mon62.type_t.num20_6,l_mon63.type_t.num20_6,l_mon64.type_t.num20_6,l_mon65.type_t.num20_6,l_mon66.type_t.num20_6,l_mon67.type_t.num20_6,l_mon68.type_t.num20_6,l_mon69.type_t.num20_6,l_mon70.type_t.num20_6,l_mon71.type_t.num20_6,l_mon72.type_t.num20_6,l_mon73.type_t.num20_6,l_mon74.type_t.num20_6,l_mon75.type_t.num20_6,l_mon76.type_t.num20_6,l_mon77.type_t.num20_6,l_mon78.type_t.num20_6,l_mon79.type_t.num20_6,l_mon80.type_t.num20_6,l_mon81.type_t.num20_6,l_mon82.type_t.num20_6,l_mon83.type_t.num20_6,l_mon84.type_t.num20_6,l_mon85.type_t.num20_6,l_mon86.type_t.num20_6,l_mon87.type_t.num20_6,l_mon88.type_t.num20_6,l_mon89.type_t.num20_6,l_mon90.type_t.num20_6,l_mon91.type_t.num20_6,l_mon92.type_t.num20_6,l_mon93.type_t.num20_6,l_mon94.type_t.num20_6,l_mon95.type_t.num20_6,l_mon96.type_t.num20_6,l_mon97.type_t.num20_6,l_mon98.type_t.num20_6,l_mon99.type_t.num20_6,l_mon100.type_t.num20_6,l_per.type_t.num20_6,glfb008.glfb_t.glfb008" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="aglq840_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION aglq840_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="aglq840_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aglq840_x01_sel_prep()
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
   LET g_select = " SELECT glfbseq,glfbseq1,glfb002,'',glfb003,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 
       0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 
       0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,glfb008"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   
   #end add-point
    LET g_from = " FROM glfb_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("glfb_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = " SELECT * FROM ", tm.a1 CLIPPED
   #end add-point
   PREPARE aglq840_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE aglq840_x01_curs CURSOR FOR aglq840_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aglq840_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION aglq840_x01_ins_data()
DEFINE sr RECORD 
   glfbseq LIKE glfb_t.glfbseq, 
   glfbseq1 LIKE glfb_t.glfbseq1, 
   glfb002 LIKE glfb_t.glfb002, 
   l_glfb002_desc LIKE type_t.chr80, 
   glfb003 LIKE glfb_t.glfb003, 
   l_mon1 LIKE type_t.num20_6, 
   l_mon2 LIKE type_t.num20_6, 
   l_mon3 LIKE type_t.num20_6, 
   l_mon4 LIKE type_t.num20_6, 
   l_mon5 LIKE type_t.num20_6, 
   l_mon6 LIKE type_t.num20_6, 
   l_mon7 LIKE type_t.num20_6, 
   l_mon8 LIKE type_t.num20_6, 
   l_mon9 LIKE type_t.num20_6, 
   l_mon10 LIKE type_t.num20_6, 
   l_mon11 LIKE type_t.num20_6, 
   l_mon12 LIKE type_t.num20_6, 
   l_mon13 LIKE type_t.num20_6, 
   l_mon14 LIKE type_t.num20_6, 
   l_mon15 LIKE type_t.num20_6, 
   l_mon16 LIKE type_t.num20_6, 
   l_mon17 LIKE type_t.num20_6, 
   l_mon18 LIKE type_t.num20_6, 
   l_mon19 LIKE type_t.num20_6, 
   l_mon20 LIKE type_t.num20_6, 
   l_mon21 LIKE type_t.num20_6, 
   l_mon22 LIKE type_t.num20_6, 
   l_mon23 LIKE type_t.num20_6, 
   l_mon24 LIKE type_t.num20_6, 
   l_mon25 LIKE type_t.num20_6, 
   l_mon26 LIKE type_t.num20_6, 
   l_mon27 LIKE type_t.num20_6, 
   l_mon28 LIKE type_t.num20_6, 
   l_mon29 LIKE type_t.num20_6, 
   l_mon30 LIKE type_t.num20_6, 
   l_mon31 LIKE type_t.num20_6, 
   l_mon32 LIKE type_t.num20_6, 
   l_mon33 LIKE type_t.num20_6, 
   l_mon34 LIKE type_t.num20_6, 
   l_mon35 LIKE type_t.num20_6, 
   l_mon36 LIKE type_t.num20_6, 
   l_mon37 LIKE type_t.num20_6, 
   l_mon38 LIKE type_t.num20_6, 
   l_mon39 LIKE type_t.num20_6, 
   l_mon40 LIKE type_t.num20_6, 
   l_mon41 LIKE type_t.num20_6, 
   l_mon42 LIKE type_t.num20_6, 
   l_mon43 LIKE type_t.num20_6, 
   l_mon44 LIKE type_t.num20_6, 
   l_mon45 LIKE type_t.num20_6, 
   l_mon46 LIKE type_t.num20_6, 
   l_mon47 LIKE type_t.num20_6, 
   l_mon48 LIKE type_t.num20_6, 
   l_mon49 LIKE type_t.num20_6, 
   l_mon50 LIKE type_t.num20_6, 
   l_mon51 LIKE type_t.num20_6, 
   l_mon52 LIKE type_t.num26_10, 
   l_mon53 LIKE type_t.num20_6, 
   l_mon54 LIKE type_t.num20_6, 
   l_mon55 LIKE type_t.num20_6, 
   l_mon56 LIKE type_t.num20_6, 
   l_mon57 LIKE type_t.num20_6, 
   l_mon58 LIKE type_t.num20_6, 
   l_mon59 LIKE type_t.num20_6, 
   l_mon60 LIKE type_t.num20_6, 
   l_mon61 LIKE type_t.num20_6, 
   l_mon62 LIKE type_t.num20_6, 
   l_mon63 LIKE type_t.num20_6, 
   l_mon64 LIKE type_t.num20_6, 
   l_mon65 LIKE type_t.num20_6, 
   l_mon66 LIKE type_t.num20_6, 
   l_mon67 LIKE type_t.num20_6, 
   l_mon68 LIKE type_t.num20_6, 
   l_mon69 LIKE type_t.num20_6, 
   l_mon70 LIKE type_t.num20_6, 
   l_mon71 LIKE type_t.num20_6, 
   l_mon72 LIKE type_t.num20_6, 
   l_mon73 LIKE type_t.num20_6, 
   l_mon74 LIKE type_t.num20_6, 
   l_mon75 LIKE type_t.num20_6, 
   l_mon76 LIKE type_t.num20_6, 
   l_mon77 LIKE type_t.num20_6, 
   l_mon78 LIKE type_t.num20_6, 
   l_mon79 LIKE type_t.num20_6, 
   l_mon80 LIKE type_t.num20_6, 
   l_mon81 LIKE type_t.num20_6, 
   l_mon82 LIKE type_t.num20_6, 
   l_mon83 LIKE type_t.num20_6, 
   l_mon84 LIKE type_t.num20_6, 
   l_mon85 LIKE type_t.num20_6, 
   l_mon86 LIKE type_t.num20_6, 
   l_mon87 LIKE type_t.num20_6, 
   l_mon88 LIKE type_t.num20_6, 
   l_mon89 LIKE type_t.num20_6, 
   l_mon90 LIKE type_t.num20_6, 
   l_mon91 LIKE type_t.num20_6, 
   l_mon92 LIKE type_t.num20_6, 
   l_mon93 LIKE type_t.num20_6, 
   l_mon94 LIKE type_t.num20_6, 
   l_mon95 LIKE type_t.num20_6, 
   l_mon96 LIKE type_t.num20_6, 
   l_mon97 LIKE type_t.num20_6, 
   l_mon98 LIKE type_t.num20_6, 
   l_mon99 LIKE type_t.num20_6, 
   l_mon100 LIKE type_t.num20_6, 
   l_per LIKE type_t.num20_6, 
   glfb008 LIKE glfb_t.glfb008
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
   DEFINE l_i      LIKE type_t.num5
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH aglq840_x01_curs INTO sr.*                               
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
       EXECUTE insert_prep USING sr.glfbseq,sr.glfbseq1,sr.glfb002,sr.l_glfb002_desc,sr.glfb003,sr.l_mon1,sr.l_mon2,sr.l_mon3,sr.l_mon4,sr.l_mon5,sr.l_mon6,sr.l_mon7,sr.l_mon8,sr.l_mon9,sr.l_mon10,sr.l_mon11,sr.l_mon12,sr.l_mon13,sr.l_mon14,sr.l_mon15,sr.l_mon16,sr.l_mon17,sr.l_mon18,sr.l_mon19,sr.l_mon20,sr.l_mon21,sr.l_mon22,sr.l_mon23,sr.l_mon24,sr.l_mon25,sr.l_mon26,sr.l_mon27,sr.l_mon28,sr.l_mon29,sr.l_mon30,sr.l_mon31,sr.l_mon32,sr.l_mon33,sr.l_mon34,sr.l_mon35,sr.l_mon36,sr.l_mon37,sr.l_mon38,sr.l_mon39,sr.l_mon40,sr.l_mon41,sr.l_mon42,sr.l_mon43,sr.l_mon44,sr.l_mon45,sr.l_mon46,sr.l_mon47,sr.l_mon48,sr.l_mon49,sr.l_mon50,sr.l_mon51,sr.l_mon52,sr.l_mon53,sr.l_mon54,sr.l_mon55,sr.l_mon56,sr.l_mon57,sr.l_mon58,sr.l_mon59,sr.l_mon60,sr.l_mon61,sr.l_mon62,sr.l_mon63,sr.l_mon64,sr.l_mon65,sr.l_mon66,sr.l_mon67,sr.l_mon68,sr.l_mon69,sr.l_mon70,sr.l_mon71,sr.l_mon72,sr.l_mon73,sr.l_mon74,sr.l_mon75,sr.l_mon76,sr.l_mon77,sr.l_mon78,sr.l_mon79,sr.l_mon80,sr.l_mon81,sr.l_mon82,sr.l_mon83,sr.l_mon84,sr.l_mon85,sr.l_mon86,sr.l_mon87,sr.l_mon88,sr.l_mon89,sr.l_mon90,sr.l_mon91,sr.l_mon92,sr.l_mon93,sr.l_mon94,sr.l_mon95,sr.l_mon96,sr.l_mon97,sr.l_mon98,sr.l_mon99,sr.l_mon100,sr.l_per,sr.glfb008
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "aglq840_x01_execute"
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
    #当不显示XRBL科目时隐藏该栏位
    IF tm.a3 = 'N' THEN
       LET g_xgrid.visible_column="glfb008"
    END IF
    IF tm.a2 < 99 THEN
       FOR l_i = 99 TO tm.a2 STEP -1
          IF NOT cl_null(g_xgrid.visible_column)THEN       
             LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED,"|"
          END IF
          LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED ,"l_mon" CLIPPED,l_i USING '<<<<<' CLIPPED
       END FOR
    END IF

    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aglq840_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION aglq840_x01_rep_data()
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
 
{<section id="aglq840_x01.other_function" readonly="Y" >}

 
{</section>}
 
