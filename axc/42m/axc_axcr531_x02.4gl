#該程式未解開Section, 採用最新樣板產出!
{<section id="axcr531_x02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2015-12-15 14:42:27), PR版次:0001(2015-12-15 17:20:59)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000032
#+ Filename...: axcr531_x02
#+ Description: ...
#+ Creator....: 05384(2015-12-15 14:41:26)
#+ Modifier...: 05384 -SD/PR- 05384
 
{</section>}
 
{<section id="axcr531_x02.global" readonly="Y" >}
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
       chk1 LIKE type_t.chr1,         #列印異動明細 
       tmp STRING                   #臨時表
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_range LIKE type_t.chr1  #成本域
DEFINE g_spec  LIKE type_t.chr1  #特性
#end add-point
 
{</section>}
 
{<section id="axcr531_x02.main" readonly="Y" >}
PUBLIC FUNCTION axcr531_x02(p_arg1,p_arg2,p_arg3)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr1         #tm.chk1  列印異動明細 
DEFINE  p_arg3 STRING                  #tm.tmp  臨時表
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.chk1 = p_arg2
   LET tm.tmp = p_arg3
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_range   #采用成本域否
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_spec  #采用特性否
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "axcr531_x02"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL axcr531_x02_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL axcr531_x02_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL axcr531_x02_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL axcr531_x02_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL axcr531_x02_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axcr531_x02.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION axcr531_x02_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "l_glcc002.glcc_t.glcc002,l_glcc002_desc.type_t.chr500,xcck010.xcck_t.xcck010,l_xcck010_desc.type_t.chr500,l_xcck010_desc1.type_t.chr500,xcck002.xcck_t.xcck002,l_xcck002_desc.type_t.chr500,xcck011.xcck_t.xcck011,xcck017.xcck_t.xcck017,l_xcbb005.xcbb_t.xcbb005,l_xcck020_desc.type_t.chr500,l_xcck055_desc.type_t.chr500,xcck006.xcck_t.xcck006,xcck007.xcck_t.xcck007,xcck008.xcck_t.xcck008,xcck013.xcck_t.xcck013,l_xceb102.xceb_t.xceb102,l_xcea101.xcea_t.xcea101,l_xcea102.xcea_t.xcea102,xcck201.xcck_t.xcck201,xcck202.xcck_t.xcck202,xcck301.xcck_t.xcck301,xcck302.xcck_t.xcck302,l_dc.type_t.chr500,l_qty.type_t.num20_6,l_amt.type_t.num20_6,xcckcomp.xcck_t.xcckcomp,l_xcckcomp_desc.type_t.chr500,xcckld.xcck_t.xcckld,l_xcckld_desc.type_t.chr500,xcck004.xcck_t.xcck004,xcck005.xcck_t.xcck005,l_xcck004_e.xcck_t.xcck004,l_xcck005_e.xcck_t.xcck005,xcck001.xcck_t.xcck001,l_xcck001_desc.type_t.chr500,xcck003.xcck_t.xcck003,l_xcck003_desc.type_t.chr500,l_key.type_t.chr1000,l_count.type_t.num5" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="axcr531_x02.ins_prep" readonly="Y" >}
PRIVATE FUNCTION axcr531_x02_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="axcr531_x02.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axcr531_x02_sel_prep()
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
   LET g_select = " SELECT * "
#   #end add-point
#   LET g_select = " SELECT NULL,NULL,xcck010,NULL,NULL,xcck002,NULL,xcck011,xcck017,NULL,NULL,NULL,xcck006, 
#       xcck007,xcck008,xcck013,NULL,NULL,NULL,xcck201,xcck202,xcck301,xcck302,NULL,0,0,xcckcomp,NULL, 
#       xcckld,NULL,xcck004,xcck005,NULL,NULL,xcck001,NULL,xcck003,NULL,NULL,0"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_from =" FROM ",tm.tmp
   LET g_from  = g_from CLIPPED,
                 " LEFT OUTER JOIN imag_t t1 ON t1.imagent='"||g_enterprise||"' AND t1.imagsite=xcckcomp AND t1.imag001=xcck010 ",
                 " LEFT OUTER JOIN xcbb_t t2 ON t2.xcbbent='"||g_enterprise||"' AND t2.xcbbcomp=xcckcomp AND t2.xcbb001=xcck004 AND t2.xcbb002=xcck005 AND t2.xcbb003=xcck010 AND t2.xcbb004=xcck011 ",
                 " LEFT OUTER JOIN imaa_t t3 ON t3.imaaent='"||g_enterprise||"' AND t3.imaa001=xcck010 "                 
#   #end add-point
#    LET g_from = " FROM xcck_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
 
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("xcck_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
 
   #end add-point
   PREPARE axcr531_x02_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE axcr531_x02_curs CURSOR FOR axcr531_x02_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axcr531_x02.ins_data" readonly="Y" >}
PRIVATE FUNCTION axcr531_x02_ins_data()
DEFINE sr RECORD 
   l_glcc002 LIKE glcc_t.glcc002, 
   l_glcc002_desc LIKE type_t.chr500, 
   xcck010 LIKE xcck_t.xcck010, 
   l_xcck010_desc LIKE type_t.chr500, 
   l_xcck010_desc1 LIKE type_t.chr500, 
   xcck002 LIKE xcck_t.xcck002, 
   l_xcck002_desc LIKE type_t.chr500, 
   xcck011 LIKE xcck_t.xcck011, 
   xcck017 LIKE xcck_t.xcck017, 
   l_xcbb005 LIKE xcbb_t.xcbb005, 
   l_xcck020_desc LIKE type_t.chr500, 
   l_xcck055_desc LIKE type_t.chr500, 
   xcck006 LIKE xcck_t.xcck006, 
   xcck007 LIKE xcck_t.xcck007, 
   xcck008 LIKE xcck_t.xcck008, 
   xcck013 LIKE xcck_t.xcck013, 
   l_xceb102 LIKE xceb_t.xceb102, 
   l_xcea101 LIKE xcea_t.xcea101, 
   l_xcea102 LIKE xcea_t.xcea102, 
   xcck201 LIKE xcck_t.xcck201, 
   xcck202 LIKE xcck_t.xcck202, 
   xcck301 LIKE xcck_t.xcck301, 
   xcck302 LIKE xcck_t.xcck302, 
   l_dc LIKE type_t.chr500, 
   l_qty LIKE type_t.num20_6, 
   l_amt LIKE type_t.num20_6, 
   xcckcomp LIKE xcck_t.xcckcomp, 
   l_xcckcomp_desc LIKE type_t.chr500, 
   xcckld LIKE xcck_t.xcckld, 
   l_xcckld_desc LIKE type_t.chr500, 
   xcck004 LIKE xcck_t.xcck004, 
   xcck005 LIKE xcck_t.xcck005, 
   l_xcck004_e LIKE xcck_t.xcck004, 
   l_xcck005_e LIKE xcck_t.xcck005, 
   xcck001 LIKE xcck_t.xcck001, 
   l_xcck001_desc LIKE type_t.chr500, 
   xcck003 LIKE xcck_t.xcck003, 
   l_xcck003_desc LIKE type_t.chr500, 
   l_key LIKE type_t.chr1000, 
   l_count LIKE type_t.num5
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
#add-point:ins_data段define
DEFINE l_glaa001        LIKE glaa_t.glaa001  #使用币别
DEFINE l_glaa016        LIKE glaa_t.glaa016  #本位幣二
DEFINE l_glaa020        LIKE glaa_t.glaa020  #本位幣三
DEFINE l_currency_desc  LIKE type_t.chr100
DEFINE l_xcck020_desc   LIKE type_t.chr500
DEFINE l_xcck055_desc   LIKE type_t.chr500
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH axcr531_x02_curs INTO sr.*                               
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
       INITIALIZE l_glaa001,l_glaa016,l_glaa020,l_currency_desc,l_xcck020_desc,l_xcck055_desc TO NULL
       
       IF NOT cl_null(sr.l_xcckcomp_desc) THEN
         LET sr.l_xcckcomp_desc = sr.xcckcomp,"(",sr.l_xcckcomp_desc CLIPPED,")"
       ELSE
         LET sr.l_xcckcomp_desc = sr.xcckcomp
       END IF
       
       IF NOT cl_null(sr.l_xcckld_desc) THEN
         LET sr.l_xcckld_desc = sr.xcckld,"(",sr.l_xcckld_desc CLIPPED,")"
       ELSE
         LET sr.l_xcckld_desc = sr.xcckld
       END IF
       
       IF NOT cl_null(sr.l_xcck003_desc) THEN
         LET sr.l_xcck003_desc = sr.xcck003,"(",sr.l_xcck003_desc CLIPPED,")"
       ELSE
         LET sr.l_xcck003_desc = sr.xcck003
       END IF
       
       IF NOT cl_null(sr.l_glcc002_desc) THEN
         LET sr.l_glcc002_desc = sr.l_glcc002_desc,"(",sr.l_glcc002 CLIPPED,")"
       ELSE
         LET sr.l_glcc002_desc = sr.l_glcc002
       END IF

       
      #本位顺序说明
       SELECT gzcbl004 INTO sr.l_xcck001_desc FROM gzcbl_t WHERE  gzcbl001='8914' AND gzcbl002=sr.xcck001 AND gzcbl003=g_dlang  
       LET sr.l_xcck001_desc=sr.xcck001,".",sr.l_xcck001_desc CLIPPED
       
       SELECT glaa001,glaa016,glaa020 INTO l_glaa001,l_glaa016,l_glaa020
         FROM glaa_t
         WHERE glaaent = g_enterprise
         AND glaald  = sr.xcckld
       CASE sr.xcck001
          WHEN '1'
             CALL s_desc_get_currency_desc(l_glaa001) RETURNING l_currency_desc
          WHEN '2'
             CALL s_desc_get_currency_desc(l_glaa016) RETURNING l_currency_desc
          WHEN '3'
             CALL s_desc_get_currency_desc(l_glaa020) RETURNING l_currency_desc
       END CASE
       IF NOT cl_null(l_currency_desc) THEN
          LET sr.l_xcck001_desc=sr.l_xcck001_desc,'(',l_currency_desc,')'
       END IF
       
       CALL s_desc_gzcbl004_desc('200',sr.l_xcck020_desc) RETURNING l_xcck020_desc
       CALL s_desc_gzcbl004_desc('8542',sr.l_xcck055_desc) RETURNING l_xcck055_desc
       IF NOT cl_null(sr.l_xcck020_desc) THEN
          LET sr.l_xcck020_desc = sr.l_xcck020_desc,":",l_xcck020_desc
       END IF
       IF NOT cl_null(sr.l_xcck055_desc) THEN
          LET sr.l_xcck055_desc = sr.l_xcck020_desc,":",l_xcck055_desc
       END IF
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.l_glcc002,sr.l_glcc002_desc,sr.xcck010,sr.l_xcck010_desc,sr.l_xcck010_desc1,sr.xcck002,sr.l_xcck002_desc,sr.xcck011,sr.xcck017,sr.l_xcbb005,sr.l_xcck020_desc,sr.l_xcck055_desc,sr.xcck006,sr.xcck007,sr.xcck008,sr.xcck013,sr.l_xceb102,sr.l_xcea101,sr.l_xcea102,sr.xcck201,sr.xcck202,sr.xcck301,sr.xcck302,sr.l_dc,sr.l_qty,sr.l_amt,sr.xcckcomp,sr.l_xcckcomp_desc,sr.xcckld,sr.l_xcckld_desc,sr.xcck004,sr.xcck005,sr.l_xcck004_e,sr.l_xcck005_e,sr.xcck001,sr.l_xcck001_desc,sr.xcck003,sr.l_xcck003_desc,sr.l_key,sr.l_count
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "axcr531_x02_execute"
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
 
{<section id="axcr531_x02.rep_data" readonly="Y" >}
PRIVATE FUNCTION axcr531_x02_rep_data()
#add-point:rep_data.define (客製用) name="rep_data.define_customerization"

#end add-point:rep_data.define
#add-point:rep_data.define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="rep_data.define"

#end add-point:rep_data.define
 
    #add-point:rep_data.before name="rep_data.before"
    #动态隐藏 成本域 或 特性
    IF g_range = 'N' THEN
       CALL axcr531_x02_hide("xcck002|l_xcck002_desc")
    END IF
    IF g_spec ='N' THEN
       CALL axcr531_x02_hide("xcck011")
    END IF 
    IF tm.chk1 ='N' THEN
      CALL axcr531_x02_hide("l_xcck020_desc|l_xcck055_desc|xcck006|xcck007|xcck008")
    END IF 

    #end add-point:rep_data.before
    
    CALL cl_xg_view()
    #add-point:rep_data.after name="rep_data.after"
    
    #end add-point:rep_data.after
END FUNCTION
 
{</section>}
 
{<section id="axcr531_x02.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 動態隱藏控制
# Memo...........:
# Usage..........: CALL axcr531_x02_hide(p_str)
# Input parameter: p_str   隱藏欄位名稱
# Return code....: 
# Date & Author..: 2015/12/14 By shiun
# Modify.........:
################################################################################
PRIVATE FUNCTION axcr531_x02_hide(p_str)
DEFINE p_str   STRING

   IF NOT cl_null(g_xgrid.visible_column) THEN
      LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED,"|",p_str CLIPPED
   ELSE
     LET g_xgrid.visible_column = p_str
   END IF
END FUNCTION

 
{</section>}
 
