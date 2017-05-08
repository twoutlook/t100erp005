#該程式未解開Section, 採用最新樣板產出!
{<section id="anmq311_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:4(2016-07-04 16:29:13), PR版次:0004(2016-07-04 16:30:46)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000041
#+ Filename...: anmq311_x01
#+ Description: ...
#+ Creator....: 06816(2015-10-15 14:29:06)
#+ Modifier...: 04152 -SD/PR- 04152
 
{</section>}
 
{<section id="anmq311_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#151127-00002#5 2015/12/17 By sakura   增加一欄【備註】
#160704-00018#1 2016/07/07 By Reanna   調整XG列印時順序與Q查詢不一致
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
       a1 STRING                   #Temp table名稱
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_tmp_table           STRING
#end add-point
 
{</section>}
 
{<section id="anmq311_x01.main" readonly="Y" >}
PUBLIC FUNCTION anmq311_x01(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 STRING                  #tm.a1  Temp table名稱
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.a1 = p_arg2
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   LET g_tmp_table = tm.a1
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "anmq311_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL anmq311_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL anmq311_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL anmq311_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL anmq311_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL anmq311_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="anmq311_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION anmq311_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "apca010.apca_t.apca010,nmaa001.nmaa_t.nmaa001,l_nmaa001_desc.type_t.chr500,apca100.apca_t.apca100,l_amt1.type_t.num20_6,l_amt2.type_t.num20_6,l_amt4.type_t.num20_6,l_amt5.type_t.num20_6,l_amt6.type_t.num20_6,l_sum1.type_t.num20_6,pmdt_t_pmdtdocno.pmdt_t.pmdtdocno,apca005.apca_t.apca005,l_apca005_desc.type_t.chr500,l_gzzz001.gzzz_t.gzzz001,l_gzzz001_desc.type_t.chr500,l_apcc009.apcc_t.apcc009,l_comp_desc.type_t.chr500,l_enddate.type_t.dat,l_type.type_t.chr500,l_flag.type_t.chr1,l_seq.type_t.num10" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="anmq311_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION anmq311_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="anmq311_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION anmq311_x01_sel_prep()
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
#   LET g_select = " SELECT apca010,nmaa001,'',apca100,'','','','','','','',pmdt_t.pmdtdocno,apca005, 
#       '','','',pmdt_t.pmdtseq,'','','','','',0"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
 
#   #end add-point
#    LET g_from = " FROM apca_t,nmaa_t,pmdt_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
 
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
 
#   #end add-point:sel_prep.sql.before
#   LET g_where = g_where ,cl_sql_add_filter("apca_t")   #資料過濾功能
#   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
#   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
# 
#   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   #151127-00002#5 add apcc009
   LET g_sql = "SELECT apca010,nmas002,nmaa001_desc,apca100,amt1,amt2,amt3,amt4,",
               "       amt5,amt6,sum1,pmdtdocno,apca005,apca005_desc,gzzz001,",
              #"       gzzz001_desc,pmdtseq,apcc009,l_comp_desc,l_enddate,l_type,l_flag ",    #160704-00018#1 mark
               "       gzzz001_desc,pmdtseq,apcc009,l_comp_desc,l_enddate,l_type,l_flag,seq", #160704-00018#1
               "  FROM ",g_tmp_table CLIPPED,
               " ORDER BY seq"
   #end add-point
   PREPARE anmq311_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE anmq311_x01_curs CURSOR FOR anmq311_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="anmq311_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION anmq311_x01_ins_data()
DEFINE sr RECORD 
   apca010 LIKE apca_t.apca010, 
   nmaa001 LIKE nmaa_t.nmaa001, 
   l_nmaa001_desc LIKE type_t.chr500, 
   apca100 LIKE apca_t.apca100, 
   l_amt1 LIKE type_t.num20_6, 
   l_amt2 LIKE type_t.num20_6, 
   l_amt3 LIKE type_t.num20_6, 
   l_amt4 LIKE type_t.num20_6, 
   l_amt5 LIKE type_t.num20_6, 
   l_amt6 LIKE type_t.num20_6, 
   l_sum1 LIKE type_t.num20_6, 
   pmdt_t_pmdtdocno LIKE pmdt_t.pmdtdocno, 
   apca005 LIKE apca_t.apca005, 
   l_apca005_desc LIKE type_t.chr500, 
   l_gzzz001 LIKE gzzz_t.gzzz001, 
   l_gzzz001_desc LIKE type_t.chr500, 
   pmdt_t_pmdtseq LIKE pmdt_t.pmdtseq, 
   l_apcc009 LIKE apcc_t.apcc009, 
   l_comp_desc LIKE type_t.chr500, 
   l_enddate LIKE type_t.dat, 
   l_type LIKE type_t.chr500, 
   l_flag LIKE type_t.chr1, 
   l_seq LIKE type_t.num10
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH anmq311_x01_curs INTO sr.*                               
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
       EXECUTE insert_prep USING sr.apca010,sr.nmaa001,sr.l_nmaa001_desc,sr.apca100,sr.l_amt1,sr.l_amt2,sr.l_amt4,sr.l_amt5,sr.l_amt6,sr.l_sum1,sr.pmdt_t_pmdtdocno,sr.apca005,sr.l_apca005_desc,sr.l_gzzz001,sr.l_gzzz001_desc,sr.l_apcc009,sr.l_comp_desc,sr.l_enddate,sr.l_type,sr.l_flag,sr.l_seq
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "anmq311_x01_execute"
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
    IF sr.l_flag  THEN 
       LET g_xgrid.visible_column ="apca005|l_apca005_desc|pmdt_t_pmdtdocno|l_gzzz001|l_gzzz001_desc|l_apcc009"   #151127-00002#5 add l_apcc009
    END IF
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="anmq311_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION anmq311_x01_rep_data()
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
 
{<section id="anmq311_x01.other_function" readonly="Y" >}

 
{</section>}
 
