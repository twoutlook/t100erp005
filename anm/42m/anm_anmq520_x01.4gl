#該程式未解開Section, 採用最新樣板產出!
{<section id="anmq520_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2016-11-30 15:08:16), PR版次:0003(2016-11-30 15:14:22)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000039
#+ Filename...: anmq520_x01
#+ Description: ...
#+ Creator....: 06816(2015-10-21 18:18:27)
#+ Modifier...: 03080 -SD/PR- 03080
 
{</section>}
 
{<section id="anmq520_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#160526-00037#2   2016/06/16 By 02599   報表改為採用明細+子報表模式
#161125-00036#7   161130     By albireo 增加實際兌現日l_nmck012
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
       wc STRING,                  #WHERE CONDITION 
       a1 STRING                   #TEMP TABLE
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_tmp_table           STRING
#end add-point
 
{</section>}
 
{<section id="anmq520_x01.main" readonly="Y" >}
PUBLIC FUNCTION anmq520_x01(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  WHERE CONDITION 
DEFINE  p_arg2 STRING                  #tm.a1  TEMP TABLE
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
   LET g_rep_code = "anmq520_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL anmq520_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL anmq520_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL anmq520_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL anmq520_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL anmq520_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="anmq520_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION anmq520_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "nmbadocno.nmba_t.nmbadocno,nmbbseq.nmbb_t.nmbbseq,nmba004.nmba_t.nmba004,l_nmba004.type_t.chr500,nmbb030.nmbb_t.nmbb030,nmbb028.nmbb_t.nmbb028,l_nmbb028.type_t.chr500,nmbb043.nmbb_t.nmbb043,l_nmbb043.type_t.chr500,nmbb065.nmbb_t.nmbb065,nmbb031.nmbb_t.nmbb031,l_nmck012.type_t.dat,l_nmbb004.type_t.chr500,nmbb006.nmbb_t.nmbb006,nmbb005.nmbb_t.nmbb005,nmbb007.nmbb_t.nmbb007,l_nmbb044.type_t.chr500,nmbb045.nmbb_t.nmbb045,l_nmbb042.type_t.chr500,nmbacomp.nmba_t.nmbacomp,l_keys.type_t.chr1000" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   #160526-00037#2--add--str--
   #子報表TEMP TABLE的欄位SQL   
   LET g_sql = "nmcqdocdt.nmcq_t.nmcqdocdt,l_nmcq001.type_t.chr500,nmcqdocno.nmcq_t.nmcqdocno,nmcr103.nmcr_t.nmcr103,nmcr113.nmcr_t.nmcr113,l_nmcqstus.type_t.chr500,l_key.type_t.chr1000" 
   
   #建立TEMP TABLE,子報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,2) THEN
      LET g_rep_success = 'N'            
   END IF
   #160526-00037#2--add--end
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="anmq520_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION anmq520_x01_ins_prep()
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
         #160526-00037#2--add--str--
         WHEN 2
         #子報表 PREP
         LET g_sql = " INSERT INTO ",g_rep_db CLIPPED,g_rep_tmpname[2] CLIPPED," VALUES(?,?,?,?,?,?,?)"
         PREPARE insert_prep1 FROM g_sql
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
         #160526-00037#2--add--end
         #end add-point                  
 
 
      END CASE
   END FOR
END FUNCTION
 
{</section>}
 
{<section id="anmq520_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION anmq520_x01_sel_prep()
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
#   LET g_select = " SELECT nmbadocno,nmbbseq,nmba004,'',nmbb030,nmbb028,'',nmbb043,NULL,nmbb065,nmbb031, 
#       '','',nmbb006,nmbb005,nmbb007,'',nmbb045,'',nmbacomp,''"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
 
#   #end add-point
#    LET g_from = " FROM nmbb_t,nmba_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
 
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
 
#   #end add-point:sel_prep.sql.before
#   LET g_where = g_where ,cl_sql_add_filter("nmbb_t")   #資料過濾功能
#   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
#   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
# 
#   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
#   LET g_sql = "SELECT * FROM ",g_tmp_table ," ORDER BY seq" #160526-00037#2 mark
   LET g_sql = "SELECT * FROM ",g_tmp_table ," ORDER BY nmbb004,nmbadocno " #160526-00037#2 add
   #end add-point
   PREPARE anmq520_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE anmq520_x01_curs CURSOR FOR anmq520_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="anmq520_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION anmq520_x01_ins_data()
DEFINE sr RECORD 
   nmbadocno LIKE nmba_t.nmbadocno, 
   nmbbseq LIKE nmbb_t.nmbbseq, 
   nmba004 LIKE nmba_t.nmba004, 
   l_nmba004 LIKE type_t.chr500, 
   nmbb030 LIKE nmbb_t.nmbb030, 
   nmbb028 LIKE nmbb_t.nmbb028, 
   l_nmbb028 LIKE type_t.chr500, 
   nmbb043 LIKE nmbb_t.nmbb043, 
   l_nmbb043 LIKE type_t.chr500, 
   nmbb065 LIKE nmbb_t.nmbb065, 
   nmbb031 LIKE nmbb_t.nmbb031, 
   l_nmck012 LIKE type_t.dat, 
   l_nmbb004 LIKE type_t.chr500, 
   nmbb006 LIKE nmbb_t.nmbb006, 
   nmbb005 LIKE nmbb_t.nmbb005, 
   nmbb007 LIKE nmbb_t.nmbb007, 
   l_nmbb044 LIKE type_t.chr500, 
   nmbb045 LIKE nmbb_t.nmbb045, 
   l_nmbb042 LIKE type_t.chr500, 
   nmbacomp LIKE nmba_t.nmbacomp, 
   l_keys LIKE type_t.chr1000
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
#160526-00037#2--add--str--
DEFINE sr1 RECORD 
   nmcqdocdt LIKE nmcq_t.nmcqdocdt,
   l_nmcq001 LIKE type_t.chr500, 
   nmcqdocno LIKE nmcq_t.nmcqdocno, 
   nmcr103   LIKE nmcr_t.nmcr103,  
   nmcr113   LIKE nmcr_t.nmcr113,  
   l_nmcqstus LIKE type_t.chr500,
   l_key     LIKE type_t.chr1000
         END RECORD
DEFINE l_nmcq001_desc LIKE type_t.chr500
DEFINE l_nmcq001_1_desc LIKE type_t.chr500
DEFINE l_nmcqstus_desc LIKE type_t.chr500
DEFINE l_nmbadocdt LIKE nmba_t.nmbadocdt
DEFINE l_nmbastus  LIKE nmba_t.nmbastus
#160526-00037#2--add--end
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    #160526-00037#2--add--str--
    #抓取子報表
    #票據異動歷程資料
    LET g_sql = " SELECT DISTINCT nmcqdocdt,nmcq001,nmcqdocno,nmcr103,nmcr113,nmcqstus,",
                "        nmcr003||'-'||nmcqcomp||'-'||nmcr001",
                "   FROM nmcq_t,nmcr_t ",
                "  WHERE nmcqent = nmcrent AND nmcqdocno = nmcrdocno AND nmcqcomp = nmcrcomp",
                "    AND nmcqent = ",g_enterprise," AND nmcr003 = ? ",
                "    AND nmcqcomp = ? ",
                "    AND nmcr001 = ?",
                "  ORDER BY nmcqdocdt,nmcq001 "
    PREPARE anmq520_x01_prepare2 FROM g_sql
    IF STATUS THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.extend = 'prepare:'
       LET g_errparam.code   = STATUS
       LET g_errparam.popup  = TRUE
       CALL cl_err()
       LET g_rep_success = 'N' 
    END IF
    DECLARE anmq520_x01_curs2 CURSOR FOR anmq520_x01_prepare2  
    #票況=1.開票
    CALL s_desc_gzcbl004_desc('8714',1)  RETURNING l_nmcq001_1_desc
    LET l_nmcq001_1_desc="1:",l_nmcq001_1_desc
    #160526-00037#2--add--end  
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH anmq520_x01_curs INTO sr.*                               
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
       EXECUTE insert_prep USING sr.nmbadocno,sr.nmbbseq,sr.nmba004,sr.l_nmba004,sr.nmbb030,sr.nmbb028,sr.l_nmbb028,sr.nmbb043,sr.l_nmbb043,sr.nmbb065,sr.nmbb031,sr.l_nmck012,sr.l_nmbb004,sr.nmbb006,sr.nmbb005,sr.nmbb007,sr.l_nmbb044,sr.nmbb045,sr.l_nmbb042,sr.nmbacomp,sr.l_keys
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "anmq520_x01_execute"
          LET g_errparam.code   = SQLCA.sqlcode
          LET g_errparam.popup  = FALSE
          CALL cl_err()       
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
 
       #add-point:ins_data段after_save name="ins_data.after.save"
       #160526-00037#2--add--str--
       #抓取子報表資料
       #第一筆：開票單
       SELECT nmbadocdt,nmbastus
         INTO l_nmbadocdt,l_nmbastus
         FROM nmba_t
        WHERE nmbaent = g_enterprise AND nmbadocno = sr.nmbadocno AND nmbacomp = sr.nmbacomp
       #狀態碼
       CALL s_desc_gzcbl004_desc('13',l_nmbastus)  RETURNING l_nmcqstus_desc
       LET sr1.l_nmcqstus=l_nmbastus,":",l_nmcqstus_desc
       EXECUTE insert_prep1 USING l_nmbadocdt,l_nmcq001_1_desc,sr.nmbadocno,sr.nmbb006,sr.nmbb007,
                                  sr1.l_nmcqstus,sr.l_keys
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "insert_prep1"
          LET g_errparam.code   = SQLCA.sqlcode
          LET g_errparam.popup  = FALSE
          CALL cl_err()       
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
       #票據異動歷程資料
       FOREACH anmq520_x01_curs2 USING sr.nmbadocno,sr.nmbacomp,sr.nmbb030
                                  INTO sr1.nmcqdocdt,sr1.l_nmcq001,sr1.nmcqdocno,sr1.nmcr103,sr1.nmcr113,
                                       sr1.l_nmcqstus,sr1.l_key
          IF STATUS THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = 'foreach:'
             LET g_errparam.code   = STATUS
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             LET g_rep_success = 'N'
             EXIT FOREACH
          END IF
          #票況
          CALL s_desc_gzcbl004_desc('8714',sr1.l_nmcq001)  RETURNING l_nmcq001_desc
          LET sr1.l_nmcq001=sr1.l_nmcq001,":",l_nmcq001_desc
          #狀態碼
          CALL s_desc_gzcbl004_desc('13',sr1.l_nmcqstus)  RETURNING l_nmcqstus_desc
          LET sr1.l_nmcqstus=sr1.l_nmcqstus,":",l_nmcqstus_desc
          EXECUTE insert_prep1 USING sr1.nmcqdocdt,sr1.l_nmcq001,sr1.nmcqdocno,sr1.nmcr103,sr1.nmcr113,
                                     sr1.l_nmcqstus,sr1.l_key
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = "insert_prep1"
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.popup  = FALSE
             CALL cl_err()       
             LET g_rep_success = 'N'
             EXIT FOREACH
          END IF
       END FOREACH
       #160526-00037#2--add--str--
       #end add-point
       
    END FOREACH
    
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="anmq520_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION anmq520_x01_rep_data()
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
 
{<section id="anmq520_x01.other_function" readonly="Y" >}

 
{</section>}
 
