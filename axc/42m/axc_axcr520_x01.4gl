#該程式未解開Section, 採用最新樣板產出!
{<section id="axcr520_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2015-04-08 10:30:04), PR版次:0001(2015-04-24 17:56:19)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000044
#+ Filename...: axcr520_x01
#+ Description: ...
#+ Creator....: 05947(2015-04-07 14:46:23)
#+ Modifier...: 05947 -SD/PR- 05947
 
{</section>}
 
{<section id="axcr520_x01.global" readonly="Y" >}
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
       comp LIKE xcco_t.xccocomp,         #法人组织 
       ld LIKE xcco_t.xccold,         #账套 
       year LIKE xcco_t.xcco004,         #年度 
       month LIKE xcco_t.xcco005,         #期别 
       order LIKE xcco_t.xcco001,         #本位币顺序 
       type LIKE xcco_t.xcco003,         #成本计算类型 
       chk LIKE type_t.chr1          #成本要素明细
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_range LIKE type_t.chr1  #成本域
DEFINE g_spec  LIKE type_t.chr1  #特性
DEFINE g_chk   LIKE type_t.chr1
#end add-point
 
{</section>}
 
{<section id="axcr520_x01.main" readonly="Y" >}
PUBLIC FUNCTION axcr520_x01(p_arg1,p_arg2,p_arg3,p_arg4,p_arg5,p_arg6,p_arg7,p_arg8)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE xcco_t.xccocomp         #tm.comp  法人组织 
DEFINE  p_arg3 LIKE xcco_t.xccold         #tm.ld  账套 
DEFINE  p_arg4 LIKE xcco_t.xcco004         #tm.year  年度 
DEFINE  p_arg5 LIKE xcco_t.xcco005         #tm.month  期别 
DEFINE  p_arg6 LIKE xcco_t.xcco001         #tm.order  本位币顺序 
DEFINE  p_arg7 LIKE xcco_t.xcco003         #tm.type  成本计算类型 
DEFINE  p_arg8 LIKE type_t.chr1         #tm.chk  成本要素明细
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.comp = p_arg2
   LET tm.ld = p_arg3
   LET tm.year = p_arg4
   LET tm.month = p_arg5
   LET tm.order = p_arg6
   LET tm.type = p_arg7
   LET tm.chk = p_arg8
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_range   #采用成本域否
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_spec  #采用特性否
   LET g_chk = tm.chk
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "axcr520_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL axcr520_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL axcr520_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL axcr520_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL axcr520_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL axcr520_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axcr520_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION axcr520_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "xcco002.xcco_t.xcco002,xcco002_desc.type_t.chr100,xcco006.xcco_t.xcco006,xcco006_desc.type_t.chr100,xcco006_desc2.type_t.chr100,xcco007.xcco_t.xcco007,xcco008.xcco_t.xcco008,xcco102a.xcco_t.xcco102a,xcco102b.xcco_t.xcco102b,xcco102c.xcco_t.xcco102c,xcco102d.xcco_t.xcco102d,xcco102e.xcco_t.xcco102e,xcco102f.xcco_t.xcco102f,xcco102g.xcco_t.xcco102g,xcco102h.xcco_t.xcco102h,xcco102.xcco_t.xcco102" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="axcr520_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION axcr520_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="axcr520_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axcr520_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
DEFINE l_wc          STRING
#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
   
   #end add-point
   LET g_select = " SELECT xcco002,NULL,xcco006,NULL,NULL,xcco007,xcco008,xcco102a,xcco102b,xcco102c, 
       xcco102d,xcco102e,xcco102f,xcco102g,xcco102h,xcco102"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_select = " SELECT UNIQUE xcco002,t1.xcbfl003,xcco006,t2.imaal003,t2.imaal004,xcco007,xcco008,xcco102a,xcco102b,xcco102c, 
       xcco102d,xcco102e,xcco102f,xcco102g,xcco102h,xcco102"

   #end add-point
    LET g_from = " FROM xcco_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET l_wc=tm.wc
   LET g_from  = g_from CLIPPED,
                 " LEFT JOIN xcbfl_t t1 ON t1.xcbflent='"||g_enterprise||"' AND t1.xcbfl001=xcco002 AND t1.xcbfl002='"||g_dlang||"' ",
                 " LEFT JOIN imaal_t t2 ON t2.imaalent='"||g_enterprise||"' AND t2.imaal001=xcco006 AND t2.imaal002='"||g_dlang||"' "

    IF l_wc.getIndexOf("imag011",1) THEN
       LET g_from  = g_from CLIPPED,
                 " LEFT JOIN imag_t ON imagent=xccoent AND imagsite=xccocomp AND imag001=xcco006"
    END IF
    IF l_wc.getIndexOf("xcbb006",1) THEN
       LET g_from  = g_from CLIPPED,
                 " LEFT JOIN xcbb_t ON xcbbent=xccoent AND xcbbcomp=xccocomp AND xcbb001=xcco004 AND xcbb002=xcco005 AND xcbb003=xcco006 AND xcbb004=xcco007 "
    END IF
    IF l_wc.getIndexOf("imaa003",1) THEN
       LET g_from  = g_from CLIPPED,
                 " LEFT JOIN imaa_t ON imaaent=xccoent AND imaa001=xcco006"
    END IF
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   LET g_where =  g_where CLIPPED," AND xccoent='",g_enterprise,"' "
   IF NOT cl_null(tm.ld) THEN
      LET g_where = g_where CLIPPED," AND xccold ='",tm.ld,"' "
   END IF
   IF NOT cl_null(tm.order) THEN
      LET g_where = g_where CLIPPED," AND xcco001 ='",tm.order,"' "
   END IF   
   IF NOT cl_null(tm.type) THEN
      LET g_where = g_where CLIPPED," AND xcco003 ='",tm.type,"' "
   END IF   
   IF NOT cl_null(tm.year) THEN
      LET g_where = g_where CLIPPED," AND xcco004 ='",tm.year,"' "
   END IF   
   IF NOT cl_null(tm.month) THEN
      LET g_where = g_where CLIPPED," AND xcco005 ='",tm.month,"' "
   END IF   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("xcco_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE axcr520_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE axcr520_x01_curs CURSOR FOR axcr520_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axcr520_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION axcr520_x01_ins_data()
DEFINE sr RECORD 
   xcco002 LIKE xcco_t.xcco002, 
   xcco002_desc LIKE type_t.chr100, 
   xcco006 LIKE xcco_t.xcco006, 
   xcco006_desc LIKE type_t.chr100, 
   xcco006_desc2 LIKE type_t.chr100, 
   xcco007 LIKE xcco_t.xcco007, 
   xcco008 LIKE xcco_t.xcco008, 
   xcco102a LIKE xcco_t.xcco102a, 
   xcco102b LIKE xcco_t.xcco102b, 
   xcco102c LIKE xcco_t.xcco102c, 
   xcco102d LIKE xcco_t.xcco102d, 
   xcco102e LIKE xcco_t.xcco102e, 
   xcco102f LIKE xcco_t.xcco102f, 
   xcco102g LIKE xcco_t.xcco102g, 
   xcco102h LIKE xcco_t.xcco102h, 
   xcco102 LIKE xcco_t.xcco102
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH axcr520_x01_curs INTO sr.*                               
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
       EXECUTE insert_prep USING sr.xcco002,sr.xcco002_desc,sr.xcco006,sr.xcco006_desc,sr.xcco006_desc2,sr.xcco007,sr.xcco008,sr.xcco102a,sr.xcco102b,sr.xcco102c,sr.xcco102d,sr.xcco102e,sr.xcco102f,sr.xcco102g,sr.xcco102h,sr.xcco102
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "axcr520_x01_execute"
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
 
{<section id="axcr520_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION axcr520_x01_rep_data()
#add-point:rep_data.define (客製用) name="rep_data.define_customerization"

#end add-point:rep_data.define
#add-point:rep_data.define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="rep_data.define"

#end add-point:rep_data.define
 
    #add-point:rep_data.before name="rep_data.before"

    #动态隐藏 成本域 或 特性
    IF g_range = 'N' THEN
       LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED,"|xcco002|xcco002_desc"
    END IF
    IF g_spec ='N' THEN
       LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED,"|xcco007|xcco008"
    END IF 
    IF g_chk = 'N' THEN  #汇总
       LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED,"|xcco102a|xcco102b|xcco102c|xcco102d|xcco102e|xcco102f|xcco102g|xcco102h"
    END IF
    #end add-point:rep_data.before
    
    CALL cl_xg_view()
    #add-point:rep_data.after name="rep_data.after"
 
    #end add-point:rep_data.after
END FUNCTION
 
{</section>}
 
{<section id="axcr520_x01.other_function" readonly="Y" >}

 
{</section>}
 
