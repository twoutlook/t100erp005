#該程式未解開Section, 採用最新樣板產出!
{<section id="apsr311_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2016-02-18 14:32:25), PR版次:0001(2016-02-18 14:38:32)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000026
#+ Filename...: apsr311_x01
#+ Description: ...
#+ Creator....: 07024(2016-02-18 14:04:26)
#+ Modifier...: 07024 -SD/PR- 07024
 
{</section>}
 
{<section id="apsr311_x01.global" readonly="Y" >}
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
       wc STRING                   #condition
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="apsr311_x01.main" readonly="Y" >}
PUBLIC FUNCTION apsr311_x01(p_arg1)
DEFINE  p_arg1 STRING                  #tm.wc  condition
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "apsr311_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL apsr311_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL apsr311_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL apsr311_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL apsr311_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL apsr311_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="apsr311_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION apsr311_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "psacdocno.psac_t.psacdocno,psacdocdt.psac_t.psacdocdt,psac001.psac_t.psac001,ooag_t_ooag011.ooag_t.ooag011,psac002.psac_t.psac002,ooefl_t_ooefl003.ooefl_t.ooefl003,psac003.psac_t.psac003,l_psacstus_desc.gzcbl_t.gzcbl004,psadseq.psad_t.psadseq,psad001.psad_t.psad001,x_imaal_t_imaal003.imaal_t.imaal003,x_imaal_t_imaal004.imaal_t.imaal004,psad002.psad_t.psad002,l_psad002_desc.type_t.chr1000,psad003.psad_t.psad003,psad004.psad_t.psad004,psad005.psad_t.psad005,psad006.psad_t.psad006,l_qty.type_t.num20_6,psad007.psad_t.psad007,psad008.psad_t.psad008,psad009.psad_t.psad009" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="apsr311_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION apsr311_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="apsr311_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apsr311_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
DEFINE g_order       STRING
#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
   LET g_select = " SELECT psacent,psacsite,psacdocno,psacdocdt,psac001,ooag_t.ooag011,psac002,ooefl_t.ooefl003, 
                           psac003,gzcbl_t.gzcbl004,psadseq,psad001,x.imaal_t_imaal003,x.imaal_t_imaal004,psad002,
                           NULL,psad003,psad004,psad005,psad006,(psad005-psad006),psad007,psad008,
                           psad009,psadsite"
#   #end add-point
#   LET g_select = " SELECT psacent,psacsite,psacdocno,psacdocdt,psac001,( SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = psac_t.psac001 AND ooag_t.ooagent = psac_t.psacent), 
#       psac002,( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = psac_t.psac002 AND ooefl_t.ooeflent = psac_t.psacent AND ooefl_t.ooefl002 = '" , 
#       g_dlang,"'" ,"),psac003,NULL,psadseq,psad001,x.imaal_t_imaal003,x.imaal_t_imaal004,psad002,NULL, 
#       psad003,psad004,psad005,psad006,(trim(psad005)||'-'||trim(psad006)),psad007,psad008,psad009,psadsite" 
#
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_from = " FROM psac_t ",
                " LEFT OUTER JOIN ooefl_t ON ooefl_t.ooefl001 = psac_t.psac002 AND ooefl_t.ooeflent = psac_t.psacent AND ooefl_t.ooefl002 = '",g_dlang,"'" , 
                " LEFT OUTER JOIN ooag_t ON ooag_t.ooag001 = psac_t.psac001 AND ooag_t.ooagent = psac_t.psacent ",
                " LEFT OUTER JOIN gzcbl_t ON gzcbl001='13' AND gzcbl002=psac_t.psacstus AND gzcbl003='",g_dlang,"'",
                " LEFT OUTER JOIN ( SELECT psad_t.*,imaal_t.imaal003 imaal_t_imaal003,imaal_t.imaal004 imaal_t_imaal004 ",
                "                    FROM psad_t ",
                "                    LEFT OUTER JOIN oocal_t ON oocal_t.oocal001 = psad_t.psad004 AND oocal_t.oocalent = psad_t.psadent AND oocal_t.oocal002 = '",g_dlang,"'" ,
                "                    LEFT OUTER JOIN imaal_t ON imaal_t.imaal001 = psad_t.psad001 AND imaal_t.imaalent = psad_t.psadent AND imaal_t.imaal002 = '",g_dlang,"'" ,
                "                 ) x  ON psac_t.psacent = x.psadent AND psac_t.psacdocno = x.psaddocno"
#   #end add-point
#    LET g_from = " FROM psac_t LEFT OUTER JOIN ( SELECT psad_t.*,( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaal001 = psad_t.psad001 AND imaal_t.imaalent = psad_t.psadent AND imaal_t.imaal002 = '" , 
#        g_dlang,"'" ,") imaal_t_imaal003,( SELECT imaal004 FROM imaal_t WHERE imaal_t.imaal001 = psad_t.psad001 AND imaal_t.imaalent = psad_t.psadent AND imaal_t.imaal002 = '" , 
#        g_dlang,"'" ,") imaal_t_imaal004 FROM psad_t ) x  ON psac_t.psacent = x.psadent AND psac_t.psacdocno  
#        = x.psaddocno"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
 
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   LET g_order = " ORDER BY psacdocno,psadseq"
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("psac_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = g_sql CLIPPED,g_order
   #end add-point
   PREPARE apsr311_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE apsr311_x01_curs CURSOR FOR apsr311_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="apsr311_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION apsr311_x01_ins_data()
DEFINE sr RECORD 
   psacent LIKE psac_t.psacent, 
   psacsite LIKE psac_t.psacsite, 
   psacdocno LIKE psac_t.psacdocno, 
   psacdocdt LIKE psac_t.psacdocdt, 
   psac001 LIKE psac_t.psac001, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   psac002 LIKE psac_t.psac002, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   psac003 LIKE psac_t.psac003, 
   l_psacstus_desc LIKE gzcbl_t.gzcbl004, 
   psadseq LIKE psad_t.psadseq, 
   psad001 LIKE psad_t.psad001, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_imaal_t_imaal004 LIKE imaal_t.imaal004, 
   psad002 LIKE psad_t.psad002, 
   l_psad002_desc LIKE type_t.chr1000, 
   psad003 LIKE psad_t.psad003, 
   psad004 LIKE psad_t.psad004, 
   psad005 LIKE psad_t.psad005, 
   psad006 LIKE psad_t.psad006, 
   l_qty LIKE type_t.num20_6, 
   psad007 LIKE psad_t.psad007, 
   psad008 LIKE psad_t.psad008, 
   psad009 LIKE psad_t.psad009, 
   psadsite LIKE psad_t.psadsite
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_success LIKE type_t.num5
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH apsr311_x01_curs INTO sr.*                               
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
       #產品特徵說明
       CALL s_feature_description(sr.psad001,sr.psad002) RETURNING l_success,sr.l_psad002_desc
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.psacdocno,sr.psacdocdt,sr.psac001,sr.ooag_t_ooag011,sr.psac002,sr.ooefl_t_ooefl003,sr.psac003,sr.l_psacstus_desc,sr.psadseq,sr.psad001,sr.x_imaal_t_imaal003,sr.x_imaal_t_imaal004,sr.psad002,sr.l_psad002_desc,sr.psad003,sr.psad004,sr.psad005,sr.psad006,sr.l_qty,sr.psad007,sr.psad008,sr.psad009
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "apsr311_x01_execute"
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
 
{<section id="apsr311_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION apsr311_x01_rep_data()
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
 
{<section id="apsr311_x01.other_function" readonly="Y" >}

 
{</section>}
 
