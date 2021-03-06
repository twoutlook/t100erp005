#該程式未解開Section, 採用最新樣板產出!
{<section id="aisq380_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2017-01-24 17:30:33), PR版次:0003(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000006
#+ Filename...: aisq380_x01
#+ Description: ...
#+ Creator....: 08732(2016-09-19 10:04:58)
#+ Modifier...: 08729 -SD/PR- 00000
 
{</section>}
 
{<section id="aisq380_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#161021-00002#1  2016/11/01  By 08732   1.補上發票類型以及稅別說明欄位  2.稅率(isat023)型態調整
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
       a1 STRING,                  #gldn_tmp 
       a2 STRING                   #visible_column
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_tmp_table     STRING
#end add-point
 
{</section>}
 
{<section id="aisq380_x01.main" readonly="Y" >}
PUBLIC FUNCTION aisq380_x01(p_arg1,p_arg2,p_arg3)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 STRING                  #tm.a1  gldn_tmp 
DEFINE  p_arg3 STRING                  #tm.a2  visible_column
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.a1 = p_arg2
   LET tm.a2 = p_arg3
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   LET g_tmp_table = tm.a1
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "aisq380_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL aisq380_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL aisq380_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL aisq380_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL aisq380_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL aisq380_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="aisq380_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION aisq380_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "isatent.isat_t.isatent,isatsite.isat_t.isatsite,isatcomp.isat_t.isatcomp,l_isatcomp_desc.type_t.chr100,isatdocno.isat_t.isatdocno,isatseq.isat_t.isatseq,l_isaf002.type_t.chr100,isat009.isat_t.isat009,isat007.isat_t.isat007,isat003.isat_t.isat003,isat004.isat_t.isat004,isat002.isat_t.isat002,isat001.isat_t.isat001,l_isat001_desc.type_t.chr100,l_isat025_desc.type_t.chr100,isat028.isat_t.isat028,l_isat028_desc.type_t.chr100,isat029.isat_t.isat029,isat023.isat_t.isat023,isat100.isat_t.isat100,isat101.isat_t.isat101,isat103.isat_t.isat103,isat104.isat_t.isat104,isat105.isat_t.isat105,isat113.isat_t.isat113,isat114.isat_t.isat114,isat115.isat_t.isat115" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="aisq380_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION aisq380_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="aisq380_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aisq380_x01_sel_prep()
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
#   LET g_select = " SELECT isatent,isatsite,isatcomp,NULL,isatdocno,isatseq,NULL,isat009,isat007,isat003, 
#       isat004,isat002,isat001,NULL,isat025,NULL,isat028,NULL,isat029,isat023,isat100,isat101,isat103, 
#       isat104,isat105,isat113,isat114,isat115"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
 
#   #end add-point
#    LET g_from = " FROM isat_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
 
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
 
#   #end add-point:sel_prep.sql.before
#   LET g_where = g_where ,cl_sql_add_filter("isat_t")   #資料過濾功能
#   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
#   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
# 
#   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = " SELECT * FROM ", g_tmp_table CLIPPED 
   #end add-point
   PREPARE aisq380_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE aisq380_x01_curs CURSOR FOR aisq380_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aisq380_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION aisq380_x01_ins_data()
DEFINE sr RECORD 
   isatent LIKE isat_t.isatent, 
   isatsite LIKE isat_t.isatsite, 
   isatcomp LIKE isat_t.isatcomp, 
   l_isatcomp_desc LIKE type_t.chr100, 
   isatdocno LIKE isat_t.isatdocno, 
   isatseq LIKE isat_t.isatseq, 
   l_isaf002 LIKE type_t.chr100, 
   isat009 LIKE isat_t.isat009, 
   isat007 LIKE isat_t.isat007, 
   isat003 LIKE isat_t.isat003, 
   isat004 LIKE isat_t.isat004, 
   isat002 LIKE isat_t.isat002, 
   isat001 LIKE isat_t.isat001, 
   l_isat001_desc LIKE type_t.chr100, 
   isat025 LIKE isat_t.isat025, 
   l_isat025_desc LIKE type_t.chr100, 
   isat028 LIKE isat_t.isat028, 
   l_isat028_desc LIKE type_t.chr100, 
   isat029 LIKE isat_t.isat029, 
   isat023 LIKE isat_t.isat023, 
   isat100 LIKE isat_t.isat100, 
   isat101 LIKE isat_t.isat101, 
   isat103 LIKE isat_t.isat103, 
   isat104 LIKE isat_t.isat104, 
   isat105 LIKE isat_t.isat105, 
   isat113 LIKE isat_t.isat113, 
   isat114 LIKE isat_t.isat114, 
   isat115 LIKE isat_t.isat115
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
 
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH aisq380_x01_curs INTO sr.*                               
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
       LET sr.isat023 = sr.isat023/100   #161021-00002#1   add
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.isatent,sr.isatsite,sr.isatcomp,sr.l_isatcomp_desc,sr.isatdocno,sr.isatseq,sr.l_isaf002,sr.isat009,sr.isat007,sr.isat003,sr.isat004,sr.isat002,sr.isat001,sr.l_isat001_desc,sr.l_isat025_desc,sr.isat028,sr.l_isat028_desc,sr.isat029,sr.isat023,sr.isat100,sr.isat101,sr.isat103,sr.isat104,sr.isat105,sr.isat113,sr.isat114,sr.isat115
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "aisq380_x01_execute"
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
 
{<section id="aisq380_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION aisq380_x01_rep_data()
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
 
{<section id="aisq380_x01.other_function" readonly="Y" >}

 
{</section>}
 
