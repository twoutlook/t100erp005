#該程式未解開Section, 採用最新樣板產出!
{<section id="anmq210_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2015-12-16 15:23:53), PR版次:0003(2015-12-16 15:38:42)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000047
#+ Filename...: anmq210_x01
#+ Description: ...
#+ Creator....: 04152(2015-08-21 15:09:33)
#+ Modifier...: 02159 -SD/PR- 02159
 
{</section>}
 
{<section id="anmq210_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#151127-00002#4  2015/12/16 By sakura   XG列印時，單頭增加增加日期顯示
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
       wc STRING,                  #Where Condition 
       a1 STRING                   #TEMP TABLE名稱
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_tmp_table           STRING
#end add-point
 
{</section>}
 
{<section id="anmq210_x01.main" readonly="Y" >}
PUBLIC FUNCTION anmq210_x01(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  Where Condition 
DEFINE  p_arg2 STRING                  #tm.a1  TEMP TABLE名稱
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
   LET g_rep_code = "anmq210_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL anmq210_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL anmq210_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL anmq210_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL anmq210_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL anmq210_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="anmq210_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION anmq210_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "l_nmaa001.nmaa_t.nmaa001,l_nmaa002_desc.type_t.chr500,l_nmaa003_desc.type_t.chr500,l_nmas002.type_t.chr500,nmbc100.nmbc_t.nmbc100,nmbc005.nmbc_t.nmbc005,nmbcdocno.nmbc_t.nmbcdocno,nmbcseq.nmbc_t.nmbcseq,l_nmbc006_desc.type_t.chr500,nmbc007.nmbc_t.nmbc007,l_nmbc007_desc.type_t.chr500,nmbc003.nmbc_t.nmbc003,l_nmbc003_desc.type_t.chr30,nmbc012.nmbc_t.nmbc012,l_average.type_t.num26_10,nmbc101.nmbc_t.nmbc101,nmbc103.nmbc_t.nmbc103,l_nmbc1031.type_t.num20_6,nmbc113.nmbc_t.nmbc113,l_nmbc1131.type_t.num20_6,nmbc011.nmbc_t.nmbc011,nmbc010.nmbc_t.nmbc010,l_nmbc005_desc.type_t.chr500" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="anmq210_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION anmq210_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="anmq210_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION anmq210_x01_sel_prep()
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
   LET g_select = " SELECT '','','','','',nmbc100,nmbc005,nmbcdocno,nmbcseq,'',nmbc007,NULL,nmbc003, 
       '',nmbc012,nmbc013,'',nmbc101,nmbc103,'',nmbc113,'',nmbc011,nmbc010,''"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
 
#   #end add-point
#    LET g_from = " FROM nmbc_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
 
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   #151105-00001#6 mod nmas002 > l_nmas002
   LET g_sql = "SELECT l_seq,nmaa001,nmaa002_desc,nmaa003_desc,l_nmas002,nmbc100,nmbc005,nmbcdocno, ",
               "       nmbcseq,nmbc006,nmbc007,l_nmbc007_desc,nmbc003,l_nmbc003_desc,nmbc012,nmbc013,l_average,    ",   
               "       nmbc101,nmbc103,l_nmbc1031,nmbc113,l_nmbc1131,nmbc011,nmbc010,l_nmbc005_desc  ",   #151127-00002#4 add l_nmbc005_desc
               "FROM ",g_tmp_table CLIPPED," ORDER BY l_seq                    "
#   #end add-point:sel_prep.sql.before
#   LET g_where = g_where ,cl_sql_add_filter("nmbc_t")   #資料過濾功能
#   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
#   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
# 
#   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE anmq210_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE anmq210_x01_curs CURSOR FOR anmq210_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="anmq210_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION anmq210_x01_ins_data()
DEFINE sr RECORD 
   l_seq LIKE type_t.num10, 
   l_nmaa001 LIKE nmaa_t.nmaa001, 
   l_nmaa002_desc LIKE type_t.chr500, 
   l_nmaa003_desc LIKE type_t.chr500, 
   l_nmas002 LIKE type_t.chr500, 
   nmbc100 LIKE nmbc_t.nmbc100, 
   nmbc005 LIKE nmbc_t.nmbc005, 
   nmbcdocno LIKE nmbc_t.nmbcdocno, 
   nmbcseq LIKE nmbc_t.nmbcseq, 
   l_nmbc006_desc LIKE type_t.chr500, 
   nmbc007 LIKE nmbc_t.nmbc007, 
   l_nmbc007_desc LIKE type_t.chr500, 
   nmbc003 LIKE nmbc_t.nmbc003, 
   l_nmbc003_desc LIKE type_t.chr30, 
   nmbc012 LIKE nmbc_t.nmbc012, 
   nmbc013 LIKE nmbc_t.nmbc013, 
   l_average LIKE type_t.num26_10, 
   nmbc101 LIKE nmbc_t.nmbc101, 
   nmbc103 LIKE nmbc_t.nmbc103, 
   l_nmbc1031 LIKE type_t.num20_6, 
   nmbc113 LIKE nmbc_t.nmbc113, 
   l_nmbc1131 LIKE type_t.num20_6, 
   nmbc011 LIKE nmbc_t.nmbc011, 
   nmbc010 LIKE nmbc_t.nmbc010, 
   l_nmbc005_desc LIKE type_t.chr500
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH anmq210_x01_curs INTO sr.*                               
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
       EXECUTE insert_prep USING sr.l_nmaa001,sr.l_nmaa002_desc,sr.l_nmaa003_desc,sr.l_nmas002,sr.nmbc100,sr.nmbc005,sr.nmbcdocno,sr.nmbcseq,sr.l_nmbc006_desc,sr.nmbc007,sr.l_nmbc007_desc,sr.nmbc003,sr.l_nmbc003_desc,sr.nmbc012,sr.l_average,sr.nmbc101,sr.nmbc103,sr.l_nmbc1031,sr.nmbc113,sr.l_nmbc1131,sr.nmbc011,sr.nmbc010,sr.l_nmbc005_desc
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "anmq210_x01_execute"
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
 
{<section id="anmq210_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION anmq210_x01_rep_data()
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
 
{<section id="anmq210_x01.other_function" readonly="Y" >}

 
{</section>}
 
