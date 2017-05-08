#該程式未解開Section, 採用最新樣板產出!
{<section id="axcr516_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2015-04-07 16:29:46), PR版次:0001(2015-04-09 17:25:03)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000047
#+ Filename...: axcr516_x01
#+ Description: ...
#+ Creator....: 05426(2015-03-12 14:47:56)
#+ Modifier...: 05426 -SD/PR- 05426
 
{</section>}
 
{<section id="axcr516_x01.global" readonly="Y" >}
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
       wc STRING,                  #QBE条件 
       flag LIKE type_t.chr10,         #隐藏成本域否 
       flag1 LIKE type_t.chr10,         #隐藏特性否 
       flag2 LIKE type_t.chr10          #隐藏明细否
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="axcr516_x01.main" readonly="Y" >}
PUBLIC FUNCTION axcr516_x01(p_arg1,p_arg2,p_arg3,p_arg4)
DEFINE  p_arg1 STRING                  #tm.wc  QBE条件 
DEFINE  p_arg2 LIKE type_t.chr10         #tm.flag  隐藏成本域否 
DEFINE  p_arg3 LIKE type_t.chr10         #tm.flag1  隐藏特性否 
DEFINE  p_arg4 LIKE type_t.chr10         #tm.flag2  隐藏明细否
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.flag = p_arg2
   LET tm.flag1 = p_arg3
   LET tm.flag2 = p_arg4
 
   #add-point:報表元件參數準備 name="component.arg.prep"
 
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "axcr516_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL axcr516_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL axcr516_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL axcr516_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL axcr516_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL axcr516_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axcr516_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION axcr516_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "xccc002.xccc_t.xccc002,l_xccc002_xcbfl003.type_t.chr1000,xccc006.xccc_t.xccc006,imaal_t_imaal003.imaal_t.imaal003,imaal004.imaal_t.imaal004,xccc007.xccc_t.xccc007,xccc008.xccc_t.xccc008,xccc903.xccc_t.xccc903,xccc903a.xccc_t.xccc903a,xccc903b.xccc_t.xccc903b,xccc903c.xccc_t.xccc903c,xccc903d.xccc_t.xccc903d,xccc903e.xccc_t.xccc903e,xccc903f.xccc_t.xccc903f,xccc903g.xccc_t.xccc903g,xccc903h.xccc_t.xccc903h,xccccomp.xccc_t.xccccomp,xcccent.xccc_t.xcccent,xcccld.xccc_t.xcccld,l_flag.type_t.chr10,l_flag1.type_t.chr10,l_flag2.type_t.chr10" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="axcr516_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION axcr516_x01_ins_prep()
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
 
{<section id="axcr516_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axcr516_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"

#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   IF cl_null(tm.wc) THEN LET tm.wc=' 1=1' END IF
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
   
   #end add-point
   LET g_select = " SELECT xccc002,trim(xccc002)||'.'||trim((SELECT xcbfl003 FROM xcbfl_t WHERE xcbfl_t.xcbfl001 = xccc_t.xccc002 AND xcbfl_t.xcbflent = xccc_t.xcccent AND xcbfl_t.xcbfl002 = '" , 
       g_dlang,"'" ,")),xccc006,( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaal001 = xccc_t.xccc006 AND imaal_t.imaalent = xccc_t.xcccent AND imaal_t.imaal002 = '" , 
       g_dlang,"'" ,"),NULL,xccc007,xccc008,xccc903,xccc903a,xccc903b,xccc903c,xccc903d,xccc903e,xccc903f, 
       xccc903g,xccc903h,xccccomp,xcccent,xcccld,NULL,NULL,NULL"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_select = " SELECT xccc002,xcbfl_t.xcbfl003,xccc006,imaal_t.imaal003,imaal004, 
       xccc007,xccc008,xccc903,xccc903a,xccc903b,xccc903c,xccc903d,xccc903e,xccc903f,xccc903g,xccc903h, 
       xccccomp,xcccent,xcccld,NULL,NULL,NULL"
   #end add-point
    LET g_from = " FROM xccc_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
    LET g_from = " FROM xccc_t  ",
                " LEFT JOIN xcbb_t ON xcbbcomp = xccccomp AND xcbb001 = xccc004 AND xcbbent = xcccent AND ",
                "                     xcbb002 = xccc005   AND xcbb004 = xccc007 AND xcbb003 = xccc006 ",
                " LEFT JOIN imag_t ON imag001 = xccc006 AND imagsite = '",g_site,"' AND imagent = xcccent ",
                " LEFT JOIN imaa_t ON imaa001 = xccc006 AND imaaent = xcccent ",
                " LEFT OUTER JOIN xcbfl_t ON xcbfl_t.xcbfl001 = xccc_t.xccc002 AND xcbfl_t.xcbflent = xccc_t.xcccent AND xcbfl_t.xcbfl002 = '" , g_dlang,"'" ,
                " LEFT OUTER JOIN imaal_t ON imaal_t.imaal001 = xccc_t.xccc006 AND imaal_t.imaalent = xccc_t.xcccent AND imaal_t.imaal002 = '" , g_dlang,"'"

   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
 
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("xccc_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE axcr516_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE axcr516_x01_curs CURSOR FOR axcr516_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axcr516_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION axcr516_x01_ins_data()
DEFINE sr RECORD 
   xccc002 LIKE xccc_t.xccc002, 
   l_xccc002_xcbfl003 LIKE type_t.chr1000, 
   xccc006 LIKE xccc_t.xccc006, 
   imaal_t_imaal003 LIKE imaal_t.imaal003, 
   imaal004 LIKE imaal_t.imaal004, 
   xccc007 LIKE xccc_t.xccc007, 
   xccc008 LIKE xccc_t.xccc008, 
   xccc903 LIKE xccc_t.xccc903, 
   xccc903a LIKE xccc_t.xccc903a, 
   xccc903b LIKE xccc_t.xccc903b, 
   xccc903c LIKE xccc_t.xccc903c, 
   xccc903d LIKE xccc_t.xccc903d, 
   xccc903e LIKE xccc_t.xccc903e, 
   xccc903f LIKE xccc_t.xccc903f, 
   xccc903g LIKE xccc_t.xccc903g, 
   xccc903h LIKE xccc_t.xccc903h, 
   xccccomp LIKE xccc_t.xccccomp, 
   xcccent LIKE xccc_t.xcccent, 
   xcccld LIKE xccc_t.xcccld, 
   l_flag LIKE type_t.chr10, 
   l_flag1 LIKE type_t.chr10, 
   l_flag2 LIKE type_t.chr10
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH axcr516_x01_curs INTO sr.*                               
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
       LET sr.l_flag = tm.flag
       LET sr.l_flag1 = tm.flag1
       LET sr.l_flag2 = tm.flag2
       
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.xccc002,sr.l_xccc002_xcbfl003,sr.xccc006,sr.imaal_t_imaal003,sr.imaal004,sr.xccc007,sr.xccc008,sr.xccc903,sr.xccc903a,sr.xccc903b,sr.xccc903c,sr.xccc903d,sr.xccc903e,sr.xccc903f,sr.xccc903g,sr.xccc903h,sr.xccccomp,sr.xcccent,sr.xcccld,sr.l_flag,sr.l_flag1,sr.l_flag2
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "axcr516_x01_execute"
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
 
{<section id="axcr516_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION axcr516_x01_rep_data()
#add-point:rep_data.define (客製用) name="rep_data.define_customerization"

#end add-point:rep_data.define
#add-point:rep_data.define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="rep_data.define"

#end add-point:rep_data.define
 
    #add-point:rep_data.before name="rep_data.before"
    IF tm.flag = 'N' THEN
      LET g_xgrid.visible_column = "xccc002|l_xccc002_xcbfl003"
    END IF
    IF tm.flag1 = 'N' THEN
      LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED,"|xccc007"
    END IF
    IF tm.flag2 = 'N' THEN
      LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED,"|xccc903a|xccc903b|xccc903c|xccc903d|xccc903e|xccc903f|xccc903g|xccc903h"
    END IF

    #end add-point:rep_data.before
    
    CALL cl_xg_view()
    #add-point:rep_data.after name="rep_data.after"
    
    #end add-point:rep_data.after
END FUNCTION
 
{</section>}
 
{<section id="axcr516_x01.other_function" readonly="Y" >}

 
{</section>}
 
