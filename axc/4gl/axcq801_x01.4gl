#該程式未解開Section, 採用最新樣板產出!
{<section id="axcq801_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2015-09-07 12:07:55), PR版次:0002(2015-09-09 11:10:33)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000041
#+ Filename...: axcq801_x01
#+ Description: ...
#+ Creator....: 05016(2015-04-13 13:43:11)
#+ Modifier...: 03297 -SD/PR- 03297
 
{</section>}
 
{<section id="axcq801_x01.global" readonly="Y" >}
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
       a1 STRING,                  #axcq801_tmp 
       a2 LIKE type_t.num5,         #g_flag 
       a3 LIKE type_t.chr1,         #xcfj001_hide 
       a4 LIKE type_t.chr1          #xcfj006_hide
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_tmp_table     STRING
#end add-point
 
{</section>}
 
{<section id="axcq801_x01.main" readonly="Y" >}
PUBLIC FUNCTION axcq801_x01(p_arg1,p_arg2,p_arg3,p_arg4,p_arg5)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 STRING                  #tm.a1  axcq801_tmp 
DEFINE  p_arg3 LIKE type_t.num5         #tm.a2  g_flag 
DEFINE  p_arg4 LIKE type_t.chr1         #tm.a3  xcfj001_hide 
DEFINE  p_arg5 LIKE type_t.chr1         #tm.a4  xcfj006_hide
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"
 
#end add-point
 
   LET tm.wc = p_arg1
   LET tm.a1 = p_arg2
   LET tm.a2 = p_arg3
   LET tm.a3 = p_arg4
   LET tm.a4 = p_arg5
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   LET g_tmp_table = tm.a1
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "axcq801_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL axcq801_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL axcq801_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL axcq801_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL axcq801_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL axcq801_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axcq801_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION axcq801_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "l_xcfb010_desc.type_t.chr80,l_imaa003_desc.type_t.chr80,l_imag011_desc.type_t.chr80,l_xcfj001_desc.type_t.chr80,l_xcfj005_desc.type_t.chr80,l_xcfj006.xcfj_t.xcfj006,l_xcfj007.xcfj_t.xcfj007,l_xcfj009.xcfj_t.xcfj009,l_xccc280.xccc_t.xccc280,l_amount.xccc_t.xccc280,l_idle.xccc_t.xccc280,l_qty1.xcfj_t.xcfj009,l_amt1.xccc_t.xccc280,l_rate1.xcfc_t.xcfc012,l_idle1.xccc_t.xccc280,l_qty2.xcfj_t.xcfj009,l_amt2.xccc_t.xccc280,l_rate2.xcfc_t.xcfc012,l_idle2.xccc_t.xccc280,l_qty3.xcfj_t.xcfj009,l_amt3.xccc_t.xccc280,l_rate3.xcfc_t.xcfc012,l_idle3.xccc_t.xccc280,l_qty4.xcfj_t.xcfj009,l_amt4.xccc_t.xccc280,l_rate4.xcfc_t.xcfc012,l_idle4.xccc_t.xccc280,l_qty5.xcfj_t.xcfj009,l_amt5.xccc_t.xccc280,l_rate5.xcfc_t.xcfc012,l_idle5.xccc_t.xccc280,l_qty6.xcfj_t.xcfj009,l_amt6.xccc_t.xccc280,l_rate6.xcfc_t.xcfc012,l_idle6.xccc_t.xccc280,l_qty7.xcfj_t.xcfj009,l_amt7.xccc_t.xccc280,l_rate7.xcfc_t.xcfc012,l_idle7.xccc_t.xccc280,l_qty8.xcfj_t.xcfj009,l_amt8.xccc_t.xccc280,l_rate8.xcfc_t.xcfc012,l_idle8.xccc_t.xccc280,l_qty9.xcfj_t.xcfj009,l_amt9.xccc_t.xccc280,l_rate9.xcfc_t.xcfc012,l_idle9.xccc_t.xccc280,l_qty10.xcfj_t.xcfj009,l_amt10.xccc_t.xccc280,l_rate10.xcfc_t.xcfc012,l_idle10.xccc_t.xccc280,l_qty11.xcfj_t.xcfj009,l_amt11.xccc_t.xccc280,l_rate11.xcfc_t.xcfc012,l_idle11.xccc_t.xccc280,l_qty12.xcfj_t.xcfj009,l_amt12.xccc_t.xccc280,l_rate12.xcfc_t.xcfc012,l_idle12.xccc_t.xccc280,l_qty13.xcfj_t.xcfj009,l_amt13.xccc_t.xccc280,l_rate13.xcfc_t.xcfc012,l_idle13.xccc_t.xccc280,l_qty14.xcfj_t.xcfj009,l_amt14.xccc_t.xccc280,l_rate14.xcfc_t.xcfc012,l_idle14.xccc_t.xccc280,l_qty15.xcfj_t.xcfj009,l_amt15.xccc_t.xccc280,l_rate15.xcfc_t.xcfc012,l_idle15.xccc_t.xccc280,l_qty16.xcfj_t.xcfj009,l_amt16.xccc_t.xccc280,l_rate16.xcfc_t.xcfc012,l_idle16.xccc_t.xccc280,l_qty17.xcfj_t.xcfj009,l_amt17.xccc_t.xccc280,l_rate17.xcfc_t.xcfc012,l_idle17.xccc_t.xccc280,l_qty18.xcfj_t.xcfj009,l_amt18.xccc_t.xccc280,l_rate18.xcfc_t.xcfc012,l_idle18.xccc_t.xccc280,l_qty19.xcfj_t.xcfj009,l_amt19.xccc_t.xccc280,l_rate19.xcfc_t.xcfc012,l_idle19.xccc_t.xccc280,l_qty20.xcfj_t.xcfj009,l_amt20.xccc_t.xccc280,l_rate20.xcfc_t.xcfc012,l_idle20.xccc_t.xccc280,l_ld_desc.type_t.chr80,l_comp_desc.type_t.chr80,l_yaer.xcfj_t.xcfj003,l_mon.xcfj_t.xcfj004,l_xcfj002.type_t.chr80,l_xrcc001.type_t.chr80,l_xcfa004.type_t.chr80,l_flag1.type_t.chr1,l_flag2.type_t.chr1,l_flag3.type_t.chr1,l_flag4.type_t.chr1,l_flag5.type_t.chr1,l_flag6.type_t.chr1,l_flag7.type_t.chr1,l_flag8.type_t.chr1,l_flag9.type_t.chr1,l_flag10.type_t.chr1,l_flag11.type_t.chr1,l_flag12.type_t.chr1,l_flag13.type_t.chr1,l_flag14.type_t.chr1,l_flag15.type_t.chr1,l_flag16.type_t.chr1,l_flag17.type_t.chr1,l_flag18.type_t.chr1,l_flag19.type_t.chr1,l_flag20.type_t.chr1,l_xcfj001_hide.type_t.chr1,l_xcfj006_hide.type_t.chr1" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="axcq801_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION axcq801_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="axcq801_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axcq801_x01_sel_prep()
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
 
#   #end add-point
#   LET g_select = " SELECT '','','','','','','','','','','','','','','','','','','','','','','','','', 
#       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
#       '','','','','','','','','','','','','','','','','','','',NULL,'','','','','','','','','','','', 
#       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
#       '',''"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
 
#   #end add-point
#    LET g_from = " FROM xccc_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
 
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
 
#   #end add-point:sel_prep.sql.before
#   LET g_where = g_where ,cl_sql_add_filter("xccc_t")   #資料過濾功能
#   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
#   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
# 
#   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = " SELECT * FROM ", g_tmp_table CLIPPED
   #end add-point
   PREPARE axcq801_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE axcq801_x01_curs CURSOR FOR axcq801_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axcq801_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION axcq801_x01_ins_data()
DEFINE sr RECORD 
   l_xcfb010_desc LIKE type_t.chr80, 
   l_imaa003_desc LIKE type_t.chr80, 
   l_imag011_desc LIKE type_t.chr80, 
   l_xcfj001_desc LIKE type_t.chr80, 
   l_xcfj005_desc LIKE type_t.chr80, 
   l_xcfj006 LIKE xcfj_t.xcfj006, 
   l_xcfj007 LIKE xcfj_t.xcfj007, 
   l_xcfj009 LIKE xcfj_t.xcfj009, 
   l_xccc280 LIKE xccc_t.xccc280, 
   l_amount LIKE xccc_t.xccc280, 
   l_idle LIKE xccc_t.xccc280, 
   l_qty1 LIKE xcfj_t.xcfj009, 
   l_amt1 LIKE xccc_t.xccc280, 
   l_rate1 LIKE xcfc_t.xcfc012, 
   l_idle1 LIKE xccc_t.xccc280, 
   l_qty2 LIKE xcfj_t.xcfj009, 
   l_amt2 LIKE xccc_t.xccc280, 
   l_rate2 LIKE xcfc_t.xcfc012, 
   l_idle2 LIKE xccc_t.xccc280, 
   l_qty3 LIKE xcfj_t.xcfj009, 
   l_amt3 LIKE xccc_t.xccc280, 
   l_rate3 LIKE xcfc_t.xcfc012, 
   l_idle3 LIKE xccc_t.xccc280, 
   l_qty4 LIKE xcfj_t.xcfj009, 
   l_amt4 LIKE xccc_t.xccc280, 
   l_rate4 LIKE xcfc_t.xcfc012, 
   l_idle4 LIKE xccc_t.xccc280, 
   l_qty5 LIKE xcfj_t.xcfj009, 
   l_amt5 LIKE xccc_t.xccc280, 
   l_rate5 LIKE xcfc_t.xcfc012, 
   l_idle5 LIKE xccc_t.xccc280, 
   l_qty6 LIKE xcfj_t.xcfj009, 
   l_amt6 LIKE xccc_t.xccc280, 
   l_rate6 LIKE xcfc_t.xcfc012, 
   l_idle6 LIKE xccc_t.xccc280, 
   l_qty7 LIKE xcfj_t.xcfj009, 
   l_amt7 LIKE xccc_t.xccc280, 
   l_rate7 LIKE xcfc_t.xcfc012, 
   l_idle7 LIKE xccc_t.xccc280, 
   l_qty8 LIKE xcfj_t.xcfj009, 
   l_amt8 LIKE xccc_t.xccc280, 
   l_rate8 LIKE xcfc_t.xcfc012, 
   l_idle8 LIKE xccc_t.xccc280, 
   l_qty9 LIKE xcfj_t.xcfj009, 
   l_amt9 LIKE xccc_t.xccc280, 
   l_rate9 LIKE xcfc_t.xcfc012, 
   l_idle9 LIKE xccc_t.xccc280, 
   l_qty10 LIKE xcfj_t.xcfj009, 
   l_amt10 LIKE xccc_t.xccc280, 
   l_rate10 LIKE xcfc_t.xcfc012, 
   l_idle10 LIKE xccc_t.xccc280, 
   l_qty11 LIKE xcfj_t.xcfj009, 
   l_amt11 LIKE xccc_t.xccc280, 
   l_rate11 LIKE xcfc_t.xcfc012, 
   l_idle11 LIKE xccc_t.xccc280, 
   l_qty12 LIKE xcfj_t.xcfj009, 
   l_amt12 LIKE xccc_t.xccc280, 
   l_rate12 LIKE xcfc_t.xcfc012, 
   l_idle12 LIKE xccc_t.xccc280, 
   l_qty13 LIKE xcfj_t.xcfj009, 
   l_amt13 LIKE xccc_t.xccc280, 
   l_rate13 LIKE xcfc_t.xcfc012, 
   l_idle13 LIKE xccc_t.xccc280, 
   l_qty14 LIKE xcfj_t.xcfj009, 
   l_amt14 LIKE xccc_t.xccc280, 
   l_rate14 LIKE xcfc_t.xcfc012, 
   l_idle14 LIKE xccc_t.xccc280, 
   l_qty15 LIKE xcfj_t.xcfj009, 
   l_amt15 LIKE xccc_t.xccc280, 
   l_rate15 LIKE xcfc_t.xcfc012, 
   l_idle15 LIKE xccc_t.xccc280, 
   l_qty16 LIKE xcfj_t.xcfj009, 
   l_amt16 LIKE xccc_t.xccc280, 
   l_rate16 LIKE xcfc_t.xcfc012, 
   l_idle16 LIKE xccc_t.xccc280, 
   l_qty17 LIKE xcfj_t.xcfj009, 
   l_amt17 LIKE xccc_t.xccc280, 
   l_rate17 LIKE xcfc_t.xcfc012, 
   l_idle17 LIKE xccc_t.xccc280, 
   l_qty18 LIKE xcfj_t.xcfj009, 
   l_amt18 LIKE xccc_t.xccc280, 
   l_rate18 LIKE xcfc_t.xcfc012, 
   l_idle18 LIKE xccc_t.xccc280, 
   l_qty19 LIKE xcfj_t.xcfj009, 
   l_amt19 LIKE xccc_t.xccc280, 
   l_rate19 LIKE xcfc_t.xcfc012, 
   l_idle19 LIKE xccc_t.xccc280, 
   l_qty20 LIKE xcfj_t.xcfj009, 
   l_amt20 LIKE xccc_t.xccc280, 
   l_rate20 LIKE xcfc_t.xcfc012, 
   l_idle20 LIKE xccc_t.xccc280, 
   l_ld_desc LIKE type_t.chr80, 
   l_comp_desc LIKE type_t.chr80, 
   l_yaer LIKE xcfj_t.xcfj003, 
   l_mon LIKE xcfj_t.xcfj004, 
   l_xcfj002 LIKE type_t.chr80, 
   l_xrcc001 LIKE type_t.chr80, 
   l_xcfa004 LIKE type_t.chr80, 
   l_flag1 LIKE type_t.chr1, 
   l_flag2 LIKE type_t.chr1, 
   l_flag3 LIKE type_t.chr1, 
   l_flag4 LIKE type_t.chr1, 
   l_flag5 LIKE type_t.chr1, 
   l_flag6 LIKE type_t.chr1, 
   l_flag7 LIKE type_t.chr1, 
   l_flag8 LIKE type_t.chr1, 
   l_flag9 LIKE type_t.chr1, 
   l_flag10 LIKE type_t.chr1, 
   l_flag11 LIKE type_t.chr1, 
   l_flag12 LIKE type_t.chr1, 
   l_flag13 LIKE type_t.chr1, 
   l_flag14 LIKE type_t.chr1, 
   l_flag15 LIKE type_t.chr1, 
   l_flag16 LIKE type_t.chr1, 
   l_flag17 LIKE type_t.chr1, 
   l_flag18 LIKE type_t.chr1, 
   l_flag19 LIKE type_t.chr1, 
   l_flag20 LIKE type_t.chr1, 
   l_xcfj001_hide LIKE type_t.chr1, 
   l_xcfj006_hide LIKE type_t.chr1
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_flag   DYNAMIC ARRAY OF VARCHAR(500)
DEFINE i    LIKE type_t.num5
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH axcq801_x01_curs INTO sr.*                               
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
       EXECUTE insert_prep USING sr.l_xcfb010_desc,sr.l_imaa003_desc,sr.l_imag011_desc,sr.l_xcfj001_desc,sr.l_xcfj005_desc,sr.l_xcfj006,sr.l_xcfj007,sr.l_xcfj009,sr.l_xccc280,sr.l_amount,sr.l_idle,sr.l_qty1,sr.l_amt1,sr.l_rate1,sr.l_idle1,sr.l_qty2,sr.l_amt2,sr.l_rate2,sr.l_idle2,sr.l_qty3,sr.l_amt3,sr.l_rate3,sr.l_idle3,sr.l_qty4,sr.l_amt4,sr.l_rate4,sr.l_idle4,sr.l_qty5,sr.l_amt5,sr.l_rate5,sr.l_idle5,sr.l_qty6,sr.l_amt6,sr.l_rate6,sr.l_idle6,sr.l_qty7,sr.l_amt7,sr.l_rate7,sr.l_idle7,sr.l_qty8,sr.l_amt8,sr.l_rate8,sr.l_idle8,sr.l_qty9,sr.l_amt9,sr.l_rate9,sr.l_idle9,sr.l_qty10,sr.l_amt10,sr.l_rate10,sr.l_idle10,sr.l_qty11,sr.l_amt11,sr.l_rate11,sr.l_idle11,sr.l_qty12,sr.l_amt12,sr.l_rate12,sr.l_idle12,sr.l_qty13,sr.l_amt13,sr.l_rate13,sr.l_idle13,sr.l_qty14,sr.l_amt14,sr.l_rate14,sr.l_idle14,sr.l_qty15,sr.l_amt15,sr.l_rate15,sr.l_idle15,sr.l_qty16,sr.l_amt16,sr.l_rate16,sr.l_idle16,sr.l_qty17,sr.l_amt17,sr.l_rate17,sr.l_idle17,sr.l_qty18,sr.l_amt18,sr.l_rate18,sr.l_idle18,sr.l_qty19,sr.l_amt19,sr.l_rate19,sr.l_idle19,sr.l_qty20,sr.l_amt20,sr.l_rate20,sr.l_idle20,sr.l_ld_desc,sr.l_comp_desc,sr.l_yaer,sr.l_mon,sr.l_xcfj002,sr.l_xrcc001,sr.l_xcfa004,sr.l_flag1,sr.l_flag2,sr.l_flag3,sr.l_flag4,sr.l_flag5,sr.l_flag6,sr.l_flag7,sr.l_flag8,sr.l_flag9,sr.l_flag10,sr.l_flag11,sr.l_flag12,sr.l_flag13,sr.l_flag14,sr.l_flag15,sr.l_flag16,sr.l_flag17,sr.l_flag18,sr.l_flag19,sr.l_flag20,sr.l_xcfj001_hide,sr.l_xcfj006_hide
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "axcq801_x01_execute"
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
    FOR i= 1 TO tm.a2
       LET l_flag[i]  = 'Y'
    END FOR
    LET sr.l_flag1  = l_flag[1] 
    LET sr.l_flag2  = l_flag[2] 
    LET sr.l_flag3  = l_flag[3] 
    LET sr.l_flag4  = l_flag[4] 
    LET sr.l_flag5  = l_flag[5] 
    LET sr.l_flag6  = l_flag[6] 
    LET sr.l_flag7  = l_flag[7] 
    LET sr.l_flag8  = l_flag[8] 
    LET sr.l_flag9  = l_flag[9] 
    LET sr.l_flag10 = l_flag[10]  
#fengmy150909----begin
    LET sr.l_flag11  = l_flag[11] 
    LET sr.l_flag12  = l_flag[12] 
    LET sr.l_flag13  = l_flag[13] 
    LET sr.l_flag14  = l_flag[14] 
    LET sr.l_flag15  = l_flag[15] 
    LET sr.l_flag16  = l_flag[16] 
    LET sr.l_flag17  = l_flag[17] 
    LET sr.l_flag18  = l_flag[18] 
    LET sr.l_flag19  = l_flag[19] 
    LET sr.l_flag20  = l_flag[20]  
#fengmy150909----end
    IF cl_null(sr.l_flag1)  THEN LET sr.l_flag1 = 'N'  END IF
    IF cl_null(sr.l_flag2)  THEN LET sr.l_flag2 = 'N'  END IF
    IF cl_null(sr.l_flag3)  THEN LET sr.l_flag3 = 'N'  END IF
    IF cl_null(sr.l_flag4)  THEN LET sr.l_flag4 = 'N'  END IF
    IF cl_null(sr.l_flag5)  THEN LET sr.l_flag5 = 'N'  END IF
    IF cl_null(sr.l_flag6)  THEN LET sr.l_flag6 = 'N'  END IF
    IF cl_null(sr.l_flag7)  THEN LET sr.l_flag7 = 'N'  END IF
    IF cl_null(sr.l_flag8)  THEN LET sr.l_flag8 = 'N'  END IF
    IF cl_null(sr.l_flag9)  THEN LET sr.l_flag9 = 'N'  END IF
    IF cl_null(sr.l_flag10) THEN LET sr.l_flag10 = 'N' END IF 
#fengmy150909----begin
    IF cl_null(sr.l_flag11)  THEN LET sr.l_flag11 = 'N'  END IF
    IF cl_null(sr.l_flag12)  THEN LET sr.l_flag12 = 'N'  END IF
    IF cl_null(sr.l_flag13)  THEN LET sr.l_flag13 = 'N'  END IF
    IF cl_null(sr.l_flag14)  THEN LET sr.l_flag14 = 'N'  END IF
    IF cl_null(sr.l_flag15)  THEN LET sr.l_flag15 = 'N'  END IF
    IF cl_null(sr.l_flag16)  THEN LET sr.l_flag16 = 'N'  END IF
    IF cl_null(sr.l_flag17)  THEN LET sr.l_flag17 = 'N'  END IF
    IF cl_null(sr.l_flag18)  THEN LET sr.l_flag18 = 'N'  END IF
    IF cl_null(sr.l_flag19)  THEN LET sr.l_flag19 = 'N'  END IF
    IF cl_null(sr.l_flag20)  THEN LET sr.l_flag20 = 'N' END IF 
#fengmy150909----end    
    LET sr.l_xcfj001_hide = tm.a3
    LET sr.l_xcfj006_hide = tm.a4
    
    
    LET g_xgrid.visible_column = NULL
  
    IF sr.l_flag1 = 'N' THEN 
      IF cl_null(g_xgrid.visible_column)THEN
         LET g_xgrid.visible_column ="l_qty1|l_amt1|l_rate1|l_idle1" 
      ELSE
         LET g_xgrid.visible_column =g_xgrid.visible_column CLIPPED,"|l_qty1|l_amt1|l_rate1|l_idle1" 
      END IF  
    END IF    
    
    IF sr.l_flag2 = 'N' THEN
       IF cl_null(g_xgrid.visible_column)THEN
          LET g_xgrid.visible_column = "l_qty2|l_amt2|l_rate2|l_idle2"
       ELSE
          LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED ,"|l_qty2|l_amt2|l_rate2|l_idle2"
       END IF
    END IF
    IF sr.l_flag3 = 'N' THEN
       IF cl_null(g_xgrid.visible_column)THEN
          LET g_xgrid.visible_column = "l_qty3|l_amt3|l_rate3|l_idle3"
       ELSE
          LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED ,"|l_qty3|l_amt3|l_rate3|l_idle3"
       END IF
    END IF
    IF sr.l_flag4 = 'N' THEN
       IF cl_null(g_xgrid.visible_column)THEN
          LET g_xgrid.visible_column = "l_qty4|l_amt4|l_rate4|l_idle4"
       ELSE
         #LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED ,"|l_qty5|l_amt5|l_rate5|l_idle5"   #150816 by 03538 mark
          LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED ,"|l_qty4|l_amt4|l_rate4|l_idle4"   #150816 by 03538
       END IF
    END IF
    IF sr.l_flag5 = 'N' THEN
       IF cl_null(g_xgrid.visible_column)THEN
          LET g_xgrid.visible_column = "l_qty5|l_amt5|l_rate5|l_idle5"
       ELSE
          LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED ,"|l_qty5|l_amt5|l_rate5|l_idle5"
       END IF
    END IF
    IF sr.l_flag6 = 'N' THEN
       IF cl_null(g_xgrid.visible_column)THEN
          LET g_xgrid.visible_column = "l_qty6|l_amt6|l_rate6|l_idle6"
       ELSE
          LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED ,"|l_qty6|l_amt6|l_rate6|l_idle6"
       END IF
    END IF
    IF sr.l_flag7 = 'N' THEN
       IF cl_null(g_xgrid.visible_column)THEN
          LET g_xgrid.visible_column = "l_qty7|l_amt7|l_rate7|l_idle7"
       ELSE
          LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED ,"|l_qty7|l_amt7|l_rate7|l_idle7"
       END IF
    END IF
    IF sr.l_flag8 = 'N' THEN
       IF cl_null(g_xgrid.visible_column)THEN
          LET g_xgrid.visible_column = "l_qty8|l_amt8|l_rate8|l_idle8"
       ELSE
          LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED ,"|l_qty8|l_amt8|l_rate8|l_idle8"
       END IF
    END IF
    IF sr.l_flag9 = 'N' THEN
       IF cl_null(g_xgrid.visible_column)THEN
          LET g_xgrid.visible_column = "l_qty9|l_amt9|l_rate9|l_idle9"
       ELSE
          LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED ,"|l_qty9|l_amt9|l_rate9|l_idle9"
       END IF
    END IF
    IF sr.l_flag10 = 'N' THEN
       IF cl_null(g_xgrid.visible_column)THEN
          LET g_xgrid.visible_column = "l_qty10|l_amt10|l_rate10|l_idle10"
       ELSE
          LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED ,"|l_qty10|l_amt10|l_rate10|l_idle10"
       END IF
    END IF
#fengmy150908---begin  
    IF sr.l_flag11 = 'N' THEN
       IF cl_null(g_xgrid.visible_column)THEN
          LET g_xgrid.visible_column = "l_qty11|l_amt11|l_rate11|l_idle11"
       ELSE
          LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED ,"|l_qty11|l_amt11|l_rate11|l_idle11"
       END IF
    END IF
    IF sr.l_flag12 = 'N' THEN
       IF cl_null(g_xgrid.visible_column)THEN
          LET g_xgrid.visible_column = "l_qty12|l_amt12|l_rate12|l_idle12"
       ELSE
          LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED ,"|l_qty12|l_amt12|l_rate12|l_idle12"
       END IF
    END IF
    IF sr.l_flag13 = 'N' THEN
       IF cl_null(g_xgrid.visible_column)THEN
          LET g_xgrid.visible_column = "l_qty13|l_amt13|l_rate13|l_idle13"
       ELSE
          LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED ,"|l_qty13|l_amt13|l_rate13|l_idle13"
       END IF
    END IF
    IF sr.l_flag14 = 'N' THEN
       IF cl_null(g_xgrid.visible_column)THEN
          LET g_xgrid.visible_column = "l_qty14|l_amt14|l_rate14|l_idle14"
       ELSE
          LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED ,"|l_qty14|l_amt14|l_rate14|l_idle14"
       END IF
    END IF
    IF sr.l_flag15 = 'N' THEN
      IF cl_null(g_xgrid.visible_column)THEN
         LET g_xgrid.visible_column = "l_qty15|l_amt15|l_rate15|l_idle15"
      ELSE
         LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED ,"|l_qty15|l_amt15|l_rate15|l_idle15"
      END IF
   END IF
    IF sr.l_flag16 = 'N' THEN
       IF cl_null(g_xgrid.visible_column)THEN
          LET g_xgrid.visible_column = "l_qty16|l_amt16|l_rate16|l_idle16"
       ELSE
          LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED ,"|l_qty16|l_amt16|l_rate16|l_idle16"
       END IF
    END IF
    IF sr.l_flag17 = 'N' THEN
       IF cl_null(g_xgrid.visible_column)THEN
          LET g_xgrid.visible_column = "l_qty17|l_amt17|l_rate17|l_idle17"
       ELSE
          LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED ,"|l_qty17|l_amt17|l_rate17|l_idle17"
       END IF
    END IF
    IF sr.l_flag18 = 'N' THEN
       IF cl_null(g_xgrid.visible_column)THEN
          LET g_xgrid.visible_column = "l_qty18|l_amt18|l_rate18|l_idle18"
       ELSE
          LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED ,"|l_qty18|l_amt18|l_rate18|l_idle18"
       END IF
    END IF
    IF sr.l_flag19 = 'N' THEN
       IF cl_null(g_xgrid.visible_column)THEN
          LET g_xgrid.visible_column = "l_qty19|l_amt19|l_rate19|l_idle19"
       ELSE
          LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED ,"|l_qty19|l_amt19|l_rate19|l_idle19"
       END IF
    END IF
    IF sr.l_flag20 = 'N' THEN
       IF cl_null(g_xgrid.visible_column)THEN
          LET g_xgrid.visible_column = "l_qty20|l_amt20|l_rate20|l_idle20"
       ELSE
          LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED ,"|l_qty20|l_amt20|l_rate20|l_idle20"
       END IF
    END IF
#fengmy150908---end
    IF sr.l_xcfj001_hide = 'N' THEN
       LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED , "|l_xcfj001_desc"
    END IF
    IF sr.l_xcfj006_hide = 'N' THEN
       LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED , "|l_xcfj006"
    END IF
    
   
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axcq801_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION axcq801_x01_rep_data()
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
 
{<section id="axcq801_x01.other_function" readonly="Y" >}

 
{</section>}
 
