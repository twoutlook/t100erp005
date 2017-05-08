#該程式未解開Section, 採用最新樣板產出!
{<section id="asfr004_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2016-03-07 15:31:04), PR版次:0002(2016-03-07 19:03:35)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000051
#+ Filename...: asfr004_x01
#+ Description: ...
#+ Creator....: 04441(2014-11-19 11:09:20)
#+ Modifier...: 07024 -SD/PR- 07024
 
{</section>}
 
{<section id="asfr004_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#160128-00019#1  2016/03/07  By dorislai  1.增加作業說明、工作站名稱欄位，將原先的作業編號、工作站欄位給予編號值；子報表亦同
#                                         2.子報表與主報表 對應的key欄位，更換為以代號串

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
       chk LIKE type_t.chr1          #列印工單明細
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="asfr004_x01.main" readonly="Y" >}
PUBLIC FUNCTION asfr004_x01(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr1         #tm.chk  列印工單明細
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.chk = p_arg2
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "asfr004_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL asfr004_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL asfr004_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL asfr004_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL asfr004_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL asfr004_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="asfr004_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION asfr004_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "sfcb003.sfcb_t.sfcb003,l_sfcb003_ref.type_t.chr30,sfcb004.sfcb_t.sfcb004,sfcb011.sfcb_t.sfcb011,l_sfcb011_ref.type_t.chr30,sfcb050.sfcb_t.sfcb050,sfcb046.sfcb_t.sfcb046,sfcb047.sfcb_t.sfcb047,sfcb048.sfcb_t.sfcb048,sfcb049.sfcb_t.sfcb049,sfcb051.sfcb_t.sfcb051" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   #160128-00019#1-mod-(S)
#   LET g_sql = "l_sfcb003.type_t.chr30, ",
#               "l_sfcb004.sfcb_t.sfcb004, ",
#               "l_sfcb011.type_t.chr30, ",
   LET g_sql = "l_sfcb003.sfcb_t.sfcb003,",
               "l_sfcb003_desc.type_t.chr30, ",
               "l_sfcb004.sfcb_t.sfcb004, ",
               "l_sfcb011.sfcb_t.sfcb011,",
               "l_sfcb011_desc.type_t.chr30, ",
   #160128-00019#1-mod-(E)            
               "l_sfcbdocno.sfcb_t.sfcbdocno,",
               "l_sfcb001.sfcb_t.sfcb001, ",
               "l_sfaa010.sfaa_t.sfaa010, ",
               "l_imaal003.imaal_t.imaal003, ",
               "l_imaal004.imaal_t.imaal004, ",
               "l_sfaa011.sfaa_t.sfaa011, ",
               "l_sfaa013.sfaa_t.sfaa013, ",
               "l_sfaa012.sfaa_t.sfaa012, ",
               "l_sfcb050.sfcb_t.sfcb050, ",
               "l_sfcb046.sfcb_t.sfcb046, ",
               "l_sfcb047.sfcb_t.sfcb047, ",
               "l_sfcb048.sfcb_t.sfcb048, ",
               "l_sfcb049.sfcb_t.sfcb049, ",
               "l_sfcb051.sfcb_t.sfcb051 "
   IF NOT cl_xg_create_tmptable(g_sql,2) THEN
      LET g_rep_success = 'N'
   END IF

   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="asfr004_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION asfr004_x01_ins_prep()
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
             ?,?,?,?,?)"
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
         WHEN 2 #160128-00019#1-add多加兩個?
         LET g_sql = " INSERT INTO ",g_rep_db CLIPPED,g_rep_tmpname[2] CLIPPED," VALUES(?,?,?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?)"
         PREPARE insert_prep1 FROM g_sql
         IF STATUS THEN
            LET l_prep_str ="insert_prep1",i
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_prep_str
            LET g_errparam.code   = status
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            CALL cl_xg_drop_tmptable()
            LET g_rep_success = 'N'
         END IF
         #end add-point                  
 
 
      END CASE
   END FOR
END FUNCTION
 
{</section>}
 
{<section id="asfr004_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION asfr004_x01_sel_prep()
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
   LET g_select = " SELECT sfcb003,'',sfcb004,sfcb011,'',SUM(sfcb050),SUM(sfcb046),SUM(sfcb047),SUM(sfcb048),SUM(sfcb049),SUM(sfcb051) "

#   #end add-point
#   LET g_select = " SELECT sfcb003,'',sfcb004,sfcb011,'',sfcb050,sfcb046,sfcb047,sfcb048,sfcb049,sfcb051" 
#
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_from = " FROM sfcb_t LEFT OUTER JOIN sfaa_t ON sfaaent = sfcbent AND sfaadocno = sfcbdocno "

#   #end add-point
#    LET g_from = " FROM sfcb_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
 
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("sfcb_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = g_sql ," GROUP BY sfcb003,sfcb004,sfcb011 "

   #end add-point
   PREPARE asfr004_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE asfr004_x01_curs CURSOR FOR asfr004_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="asfr004_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION asfr004_x01_ins_data()
DEFINE sr RECORD 
   sfcb003 LIKE sfcb_t.sfcb003, 
   l_sfcb003_ref LIKE type_t.chr30, 
   sfcb004 LIKE sfcb_t.sfcb004, 
   sfcb011 LIKE sfcb_t.sfcb011, 
   l_sfcb011_ref LIKE type_t.chr30, 
   sfcb050 LIKE sfcb_t.sfcb050, 
   sfcb046 LIKE sfcb_t.sfcb046, 
   sfcb047 LIKE sfcb_t.sfcb047, 
   sfcb048 LIKE sfcb_t.sfcb048, 
   sfcb049 LIKE sfcb_t.sfcb049, 
   sfcb051 LIKE sfcb_t.sfcb051
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE sr1  RECORD 
    #160128-00019#1-mod-(S)
#    l_sfcb003    LIKE type_t.chr30,
#    l_sfcb004    LIKE sfcb_t.sfcb004,
#    l_sfcb011    LIKE type_t.chr30,
    l_sfcb003    LIKE sfcb_t.sfcb003,
    l_sfcb003_desc LIKE type_t.chr30,
    l_sfcb004    LIKE sfcb_t.sfcb004,
    l_sfcb011    LIKE sfcb_t.sfcb011,
    l_sfcb011_desc LIKE type_t.chr30,
    #160128-00019#1-mod-(E)
    l_sfcbdocno  LIKE sfcb_t.sfcbdocno,
    l_sfcb001    LIKE sfcb_t.sfcb001,
    l_sfaa010    LIKE sfaa_t.sfaa010,
    l_imaal003   LIKE imaal_t.imaal003,
    l_imaal004   LIKE imaal_t.imaal004,
    l_sfaa011    LIKE sfaa_t.sfaa011,
    l_sfaa013    LIKE sfaa_t.sfaa013,
    l_sfaa012    LIKE sfaa_t.sfaa012,
    l_sfcb050    LIKE sfcb_t.sfcb050,
    l_sfcb046    LIKE sfcb_t.sfcb046,
    l_sfcb047    LIKE sfcb_t.sfcb047,
    l_sfcb048    LIKE sfcb_t.sfcb048,
    l_sfcb049    LIKE sfcb_t.sfcb049,
    l_sfcb051    LIKE sfcb_t.sfcb051
             END RECORD
DEFINE l_sfcb003 LIKE sfcb_t.sfcb003
DEFINE l_sfcb011 LIKE sfcb_t.sfcb011
DEFINE l_sql     STRING
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH asfr004_x01_curs INTO sr.*                               
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
       #作業編號
       CALL s_desc_get_acc_desc('221',sr.sfcb003) RETURNING sr.l_sfcb003_ref
       
       #工作站
       SELECT ecaa002 INTO sr.l_sfcb011_ref FROM ecaa_t
        WHERE ecaaent = g_enterprise AND ecaasite = g_site AND ecaa001 = sr.sfcb011


       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.sfcb003,sr.l_sfcb003_ref,sr.sfcb004,sr.sfcb011,sr.l_sfcb011_ref,sr.sfcb050,sr.sfcb046,sr.sfcb047,sr.sfcb048,sr.sfcb049,sr.sfcb051
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "asfr004_x01_execute"
          LET g_errparam.code   = SQLCA.sqlcode
          LET g_errparam.popup  = FALSE
          CALL cl_err()       
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
 
       #add-point:ins_data段after_save name="ins_data.after.save"
       #列印工單明細
       IF tm.chk = 'Y' THEN
          LET l_sql = " SELECT sfcb003,sfcb004,sfcb011,sfcbdocno,sfcb001,sfaa010,'','',sfaa011, ",
                      "        sfaa013,sfaa012,sfcb050,sfcb046,sfcb047,sfcb048,sfcb049,sfcb051 ",
                      "   FROM sfcb_t LEFT OUTER JOIN sfaa_t ON sfaaent = sfcbent AND sfaadocno = sfcbdocno ",
                      "  WHERE sfcbent = '",g_enterprise,"' ",
                      "    AND sfcb003 = '",sr.sfcb003,"' ",
                      "    AND sfcb004 = '",sr.sfcb004,"' ",
                      "    AND sfcb011 = '",sr.sfcb011,"' "
          DECLARE asfr004_x01_repcur CURSOR FROM l_sql
          #160128-00019#1-mod-(S)
#          FOREACH asfr004_x01_repcur INTO sr1.l_sfcb003,sr1.l_sfcb004,sr1.l_sfcb011,sr1.l_sfcbdocno,sr1.l_sfcb001,sr1.l_sfaa010,
          FOREACH asfr004_x01_repcur INTO sr1.l_sfcb003,sr1.l_sfcb004,sr1.l_sfcb011,sr1.l_sfcbdocno,sr1.l_sfcb001,sr1.l_sfaa010,
          #160128-00019#1-mod-(E)
                                          sr1.l_imaal003,sr1.l_imaal004,sr1.l_sfaa011,sr1.l_sfaa013,sr1.l_sfaa012,
                                          sr1.l_sfcb050,sr1.l_sfcb046,sr1.l_sfcb047,sr1.l_sfcb048,sr1.l_sfcb049,sr1.l_sfcb051
             IF STATUS THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = 'foreach:'
                LET g_errparam.code   = STATUS
                LET g_errparam.popup  = TRUE
                CALL cl_err()
                LET g_rep_success = 'N'
                EXIT FOREACH
             END IF

             #作業編號
             #160128-00019#1-mod-(S)
#             CALL s_desc_get_acc_desc('221',l_sfcb003) RETURNING sr1.l_sfcb003
             CALL s_desc_get_acc_desc('221',sr1.l_sfcb003) RETURNING sr1.l_sfcb003_desc
             #160128-00019#1-mod-(E)
             
             #工作站
             #160128-00019#1-mod-(S)
#             SELECT ecaa002 INTO sr1.l_sfcb011 FROM ecaa_t
#              WHERE ecaaent = g_enterprise AND ecaasite = g_site AND ecaa001 = l_sfcb011
             SELECT ecaa002 INTO sr1.l_sfcb011_desc FROM ecaa_t
              WHERE ecaaent = g_enterprise AND ecaasite = g_site AND ecaa001 = sr1.l_sfcb011
             #160128-00019#1-mod-(E)
             
             #料件
             CALL s_desc_get_item_desc(sr1.l_sfaa010) RETURNING sr1.l_imaal003,sr1.l_imaal004
             #160128-00019#1-add-sr1.l_sfcb003_desc,sr1.l_sfcb011_desc
             EXECUTE insert_prep1 USING sr1.l_sfcb003,sr1.l_sfcb003_desc,sr1.l_sfcb004,sr1.l_sfcb011,sr1.l_sfcb011_desc,sr1.l_sfcbdocno,
                                        sr1.l_sfcb001,sr1.l_sfaa010,sr1.l_imaal003,sr1.l_imaal004,sr1.l_sfaa011,sr1.l_sfaa013,sr1.l_sfaa012,
                                        sr1.l_sfcb050,sr1.l_sfcb046,sr1.l_sfcb047,sr1.l_sfcb048,sr1.l_sfcb049,sr1.l_sfcb051
             IF SQLCA.sqlcode THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = "asfr004_x01_execute1"
                LET g_errparam.code   = SQLCA.sqlcode
                LET g_errparam.popup  = FALSE
                CALL cl_err()
                LET g_rep_success = 'N'
                EXIT FOREACH
             END IF
          END FOREACH
       END IF

       #end add-point
       
    END FOREACH
    
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="asfr004_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION asfr004_x01_rep_data()
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
 
{<section id="asfr004_x01.other_function" readonly="Y" >}

 
{</section>}
 
