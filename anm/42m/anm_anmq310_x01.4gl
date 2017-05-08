#該程式未解開Section, 採用最新樣板產出!
{<section id="anmq310_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:4(2015-12-16 16:25:44), PR版次:0004(2015-12-16 16:45:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000064
#+ Filename...: anmq310_x01
#+ Description: ...
#+ Creator....: 00810(2015-03-19 10:58:57)
#+ Modifier...: 02159 -SD/PR- 02159
 
{</section>}
 
{<section id="anmq310_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#151127-00002#4 151216 By sakura   XG列印時，單頭增加增加日期顯示
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
       table LIKE type_t.chr100,         #  
       wc STRING                   #where condition
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="anmq310_x01.main" readonly="Y" >}
PUBLIC FUNCTION anmq310_x01(p_arg1,p_arg2)
DEFINE  p_arg1 LIKE type_t.chr100         #tm.table    
DEFINE  p_arg2 STRING                  #tm.wc  where condition
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.table = p_arg1
   LET tm.wc = p_arg2
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "anmq310_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL anmq310_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL anmq310_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL anmq310_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL anmq310_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL anmq310_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="anmq310_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION anmq310_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "nmbcent.nmbc_t.nmbcent,nmbcsite.nmbc_t.nmbcsite,l_glab005.glab_t.glab005,l_nmbc002.type_t.chr500,nmbc100.nmbc_t.nmbc100,nmbccomp.nmbc_t.nmbccomp,glaa001.glaa_t.glaa001,yy.type_t.chr10,dd.type_t.chr10,nmbc005.nmbc_t.nmbc005,nmbcdocno.nmbc_t.nmbcdocno,nmbcseq.nmbc_t.nmbcseq,glaqdocno.glaq_t.glaqdocno,glaq001.glaq_t.glaq001,nmbc003.nmbc_t.nmbc003,l_nmbc003_desc.type_t.chr500,nmbc012.nmbc_t.nmbc012,l_nmaa004.nmaa_t.nmaa004,l_nmaa004_desc.type_t.chr100,l_average.type_t.num26_10,nmbc101.nmbc_t.nmbc101,nmbc103d.nmbc_t.nmbc103,nmbc113d.nmbc_t.nmbc113,nmbc103c.nmbc_t.nmbc103,nmbc113c.nmbc_t.nmbc113,amty.nmbc_t.nmbc103,amt.nmbc_t.nmbc113,l_date_desc.type_t.chr500" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="anmq310_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION anmq310_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="anmq310_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION anmq310_x01_sel_prep()
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
#   LET g_select = " SELECT nmbcent,nmbcsite,'','',nmbc100,nmbccomp,NULL,NULL,NULL,nmbc005,nmbcdocno, 
#       nmbcseq,NULL,NULL,nmbc003,'',nmbc012,'','','',nmbc101,0,0,0,0,0,0,''"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   #150817-00025#1 add nmbc101
   #151005-00009#1 add nmaa004,nmaa004_desc
   #151008-00011#1 add glab005
   #151105-00001#6 mod nmbc002 > l_nmbc002
   #151127-00002#4 add l_date_desc
   LET g_select = " SELECT nmbcent,nmbcsite,glab005,l_nmbc002,nmbc100,nmbccomp,glaa001,yy,dd,nmbc005,nmbcdocno,nmbcseq,   
                    glaqdocno,glaq001,nmbc003,nmbc003_desc,nmbc012,nmaa004,nmaa004_desc,average,nmbc101,nmbc103d,nmbc113d,nmbc103c,nmbc113c,amty,amt,l_date_desc"
#   #end add-point
#    LET g_from = " FROM nmbc_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_from = " FROM ",tm.table
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
 
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("nmbc_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = g_sql," ORDER BY seq"
   #end add-point
   PREPARE anmq310_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE anmq310_x01_curs CURSOR FOR anmq310_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="anmq310_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION anmq310_x01_ins_data()
DEFINE sr RECORD 
   nmbcent LIKE nmbc_t.nmbcent, 
   nmbcsite LIKE nmbc_t.nmbcsite, 
   l_glab005 LIKE glab_t.glab005, 
   l_nmbc002 LIKE type_t.chr500, 
   nmbc100 LIKE nmbc_t.nmbc100, 
   nmbccomp LIKE nmbc_t.nmbccomp, 
   glaa001 LIKE glaa_t.glaa001, 
   yy LIKE type_t.chr10, 
   dd LIKE type_t.chr10, 
   nmbc005 LIKE nmbc_t.nmbc005, 
   nmbcdocno LIKE nmbc_t.nmbcdocno, 
   nmbcseq LIKE nmbc_t.nmbcseq, 
   glaqdocno LIKE glaq_t.glaqdocno, 
   glaq001 LIKE glaq_t.glaq001, 
   nmbc003 LIKE nmbc_t.nmbc003, 
   l_nmbc003_desc LIKE type_t.chr500, 
   nmbc012 LIKE nmbc_t.nmbc012, 
   l_nmaa004 LIKE nmaa_t.nmaa004, 
   l_nmaa004_desc LIKE type_t.chr100, 
   l_average LIKE type_t.num26_10, 
   nmbc101 LIKE nmbc_t.nmbc101, 
   nmbc103d LIKE nmbc_t.nmbc103, 
   nmbc113d LIKE nmbc_t.nmbc113, 
   nmbc103c LIKE nmbc_t.nmbc103, 
   nmbc113c LIKE nmbc_t.nmbc113, 
   amty LIKE nmbc_t.nmbc103, 
   amt LIKE nmbc_t.nmbc113, 
   l_date_desc LIKE type_t.chr500
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH anmq310_x01_curs INTO sr.*                               
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
       EXECUTE insert_prep USING sr.nmbcent,sr.nmbcsite,sr.l_glab005,sr.l_nmbc002,sr.nmbc100,sr.nmbccomp,sr.glaa001,sr.yy,sr.dd,sr.nmbc005,sr.nmbcdocno,sr.nmbcseq,sr.glaqdocno,sr.glaq001,sr.nmbc003,sr.l_nmbc003_desc,sr.nmbc012,sr.l_nmaa004,sr.l_nmaa004_desc,sr.l_average,sr.nmbc101,sr.nmbc103d,sr.nmbc113d,sr.nmbc103c,sr.nmbc113c,sr.amty,sr.amt,sr.l_date_desc
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "anmq310_x01_execute"
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
 
{<section id="anmq310_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION anmq310_x01_rep_data()
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
 
{<section id="anmq310_x01.other_function" readonly="Y" >}

 
{</section>}
 
