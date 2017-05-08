#該程式未解開Section, 採用最新樣板產出!
{<section id="abxr330_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2016-09-29 15:52:11), PR版次:0001(2016-09-29 16:28:44)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000006
#+ Filename...: abxr330_x01
#+ Description: ...
#+ Creator....: 02159(2016-09-29 09:53:05)
#+ Modifier...: 02159 -SD/PR- 02159
 
{</section>}
 
{<section id="abxr330_x01.global" readonly="Y" >}
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
       year LIKE bxdf_t.bxdf001,         #年度 
       print LIKE type_t.chr500          #是否列印盤點
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_pring LIKE type_t.chr500
#end add-point
 
{</section>}
 
{<section id="abxr330_x01.main" readonly="Y" >}
PUBLIC FUNCTION abxr330_x01(p_arg1,p_arg2,p_arg3)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE bxdf_t.bxdf001         #tm.year  年度 
DEFINE  p_arg3 LIKE type_t.chr500         #tm.print  是否列印盤點
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"
 
#end add-point
 
   LET tm.wc = p_arg1
   LET tm.year = p_arg2
   LET tm.print = p_arg3
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   LET g_pring = p_arg3
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "abxr330_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL abxr330_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL abxr330_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL abxr330_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL abxr330_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL abxr330_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="abxr330_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION abxr330_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "bxdf001.bxdf_t.bxdf001,bxdfdocdt.bxdf_t.bxdfdocdt,bxdfdocno.bxdf_t.bxdfdocno,bxdf002.bxdf_t.bxdf002,l_bxdf002_desc.type_t.chr1000,bxdf003.bxdf_t.bxdf003,l_bxdf003_desc.type_t.chr1000,bxdgseq.bxdg_t.bxdgseq,bxdg001.bxdg_t.bxdg001,l_bxdb002.type_t.chr1000,l_bxdb003.type_t.chr1000,l_bxdb004.type_t.chr1000,bxdg002.bxdg_t.bxdg002,l_bxdc004.type_t.chr1000,l_bxdc004_desc.type_t.chr1000,l_bxdc003.type_t.chr1000,l_bxdc003_desc.type_t.chr1000,l_bxdb005.type_t.chr1000,l_bxdb008.type_t.chr20,l_bxdb008_desc.type_t.chr30,bxdg003.bxdg_t.bxdg003,bxdg004.bxdg_t.bxdg004,bxdg005.bxdg_t.bxdg005" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="abxr330_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION abxr330_x01_ins_prep()
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
 
{<section id="abxr330_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION abxr330_x01_sel_prep()
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
   LET g_select = " SELECT bxdf001 ,bxdfdocdt  ,bxdfdocno,bxdf002   ,t1.ooag011, ",
                  "        bxdf003 ,t2.ooefl003,bxdf010  ,bxdfent   ,bxdfsite, ",
                  "        bxdfstus,bxdgseq    ,bxdg001  ,t3.bxdb002,t3.bxdb003, ",
                  "        t3.bxdb004,bxdg002,t4.bxdc004,t5.ooag011,t4.bxdc003, ",
                  "        t6.ooefl003, ",
                  "       (SELECT t3.bxdb005||'：'||gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '4074' AND gzcbl002 = t3.bxdb005 AND gzcbl003= '",g_dlang,"' ),",
                  "        t3.bxdb008,t7.oocal003,bxdg003,bxdg004,bxdg005, ",
                  "        bxdg006,bxdgsite "
#   #end add-point
#   LET g_select = " SELECT bxdf001,bxdfdocdt,bxdfdocno,bxdf002,'',bxdf003,'',bxdf010,bxdfent,bxdfsite, 
#       bxdfstus,bxdgseq,bxdg001,'','','',bxdg002,'','','','','','','',bxdg003,bxdg004,bxdg005,bxdg006, 
#       bxdgsite"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_from = " FROM bxdf_t  ",
                " LEFT OUTER JOIN ( SELECT bxdg_t.* FROM bxdg_t  ) x  ON bxdf_t.bxdfent = x.bxdgent AND bxdf_t.bxdfdocno = x.bxdgdocno ",
                " LEFT JOIN ooag_t  t1 ON t1.ooagent = "||g_enterprise||" AND t1.ooag001 = bxdf002  ",
                " LEFT JOIN ooefl_t t2 ON t2.ooeflent = "||g_enterprise||" AND t2.ooefl001 = bxdf003 AND t2.ooefl002='"||g_dlang||"' ",
                " LEFT JOIN bxdb_t t3 ON t3.bxdbent = "||g_enterprise||" AND t3.bxdbsite = x.bxdgsite AND t3.bxdb001 = x.bxdg001 ",
                " LEFT JOIN bxdc_t t4 ON t4.bxdcent = "||g_enterprise||" AND t4.bxdcsite = x.bxdgsite AND t4.bxdc001 = x.bxdg001 AND t4.bxdc002 = x.bxdg002 ",
                " LEFT JOIN ooag_t  t5 ON t5.ooagent = "||g_enterprise||" AND t5.ooag001 = t4.bxdc004  ",
                " LEFT JOIN ooefl_t t6 ON t6.ooeflent = "||g_enterprise||" AND t6.ooefl001 = t4.bxdc003 AND t6.ooefl002='"||g_dlang||"' ",                 
                " LEFT JOIN oocal_t t7 ON t7.oocalent = "||g_enterprise||" AND t7.oocal001 = t3.bxdb008 AND t7.oocal002='"||g_dlang||"' "
#   #end add-point
#    LET g_from = " FROM  bxdf_t  LEFT OUTER JOIN ( SELECT bxdg_t.* FROM bxdg_t  ) x  ON bxdf_t.bxdfent  
#        = x.bxdgent AND bxdf_t.bxdfdocno = x.bxdgdocno"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_where = " WHERE bxdfent = ",g_enterprise,
                 "   AND bxdf001 = ",tm.year,
                 "   AND ",tm.wc CLIPPED
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
 
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("bxdf_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE abxr330_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE abxr330_x01_curs CURSOR FOR abxr330_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="abxr330_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION abxr330_x01_ins_data()
DEFINE sr RECORD 
   bxdf001 LIKE bxdf_t.bxdf001, 
   bxdfdocdt LIKE bxdf_t.bxdfdocdt, 
   bxdfdocno LIKE bxdf_t.bxdfdocno, 
   bxdf002 LIKE bxdf_t.bxdf002, 
   l_bxdf002_desc LIKE type_t.chr1000, 
   bxdf003 LIKE bxdf_t.bxdf003, 
   l_bxdf003_desc LIKE type_t.chr1000, 
   bxdf010 LIKE bxdf_t.bxdf010, 
   bxdfent LIKE bxdf_t.bxdfent, 
   bxdfsite LIKE bxdf_t.bxdfsite, 
   bxdfstus LIKE bxdf_t.bxdfstus, 
   bxdgseq LIKE bxdg_t.bxdgseq, 
   bxdg001 LIKE bxdg_t.bxdg001, 
   l_bxdb002 LIKE type_t.chr1000, 
   l_bxdb003 LIKE type_t.chr1000, 
   l_bxdb004 LIKE type_t.chr1000, 
   bxdg002 LIKE bxdg_t.bxdg002, 
   l_bxdc004 LIKE type_t.chr1000, 
   l_bxdc004_desc LIKE type_t.chr1000, 
   l_bxdc003 LIKE type_t.chr1000, 
   l_bxdc003_desc LIKE type_t.chr1000, 
   l_bxdb005 LIKE type_t.chr1000, 
   l_bxdb008 LIKE type_t.chr20, 
   l_bxdb008_desc LIKE type_t.chr30, 
   bxdg003 LIKE bxdg_t.bxdg003, 
   bxdg004 LIKE bxdg_t.bxdg004, 
   bxdg005 LIKE bxdg_t.bxdg005, 
   bxdg006 LIKE bxdg_t.bxdg006, 
   bxdgsite LIKE bxdg_t.bxdgsite
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH abxr330_x01_curs INTO sr.*                               
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
       IF g_pring = 'N' THEN
          LET sr.bxdg005 = null
       END IF
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.bxdf001,sr.bxdfdocdt,sr.bxdfdocno,sr.bxdf002,sr.l_bxdf002_desc,sr.bxdf003,sr.l_bxdf003_desc,sr.bxdgseq,sr.bxdg001,sr.l_bxdb002,sr.l_bxdb003,sr.l_bxdb004,sr.bxdg002,sr.l_bxdc004,sr.l_bxdc004_desc,sr.l_bxdc003,sr.l_bxdc003_desc,sr.l_bxdb005,sr.l_bxdb008,sr.l_bxdb008_desc,sr.bxdg003,sr.bxdg004,sr.bxdg005
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "abxr330_x01_execute"
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
 
{<section id="abxr330_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION abxr330_x01_rep_data()
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
 
{<section id="abxr330_x01.other_function" readonly="Y" >}

 
{</section>}
 
