#該程式未解開Section, 採用最新樣板產出!
{<section id="axcr571_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2017-01-06 10:00:33), PR版次:0001(2017-01-06 10:12:06)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000001
#+ Filename...: axcr571_x01
#+ Description: 
#+ Creator....: 01996(2016-12-06 10:12:36)
#+ Modifier...: 01996 -SD/PR- 01996
 
{</section>}
 
{<section id="axcr571_x01.global" readonly="Y" >}
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
       wc STRING,                  #条件 
       chk2 STRING                   #打印成本要素
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="axcr571_x01.main" readonly="Y" >}
PUBLIC FUNCTION axcr571_x01(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  条件 
DEFINE  p_arg2 STRING                  #tm.chk2  打印成本要素
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.chk2 = p_arg2
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "axcr571_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL axcr571_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL axcr571_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL axcr571_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL axcr571_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL axcr571_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axcr571_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION axcr571_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "xchbcomp.xchb_t.xchbcomp,l_xchbcomp_desc.ooefl_t.ooefl003,xchb002.xchb_t.xchb002,l_xchb002_desc.xcbfl_t.xcbfl003,xchb006.xchb_t.xchb006,xchb007.xchb_t.xchb007,l_xchb007_desc.type_t.chr80,xchb008.xchb_t.xchb008,xchb009.xchb_t.xchb009,l_imaal003.imaal_t.imaal003,l_imaal004.imaal_t.imaal004,l_imag011.imag_t.imag011,l_imag011_desc.imag_t.imag011,xchb010.xchb_t.xchb010,l_xchb010_desc.inaml_t.inaml004,xchb011.xchb_t.xchb011,xchb012.xchb_t.xchb012,l_xchb012_desc.pjbal_t.pjbal003,l_xcbb005.xcbb_t.xcbb005,l_xcbb005_desc.xcbb_t.xcbb005,xchb014.xchb_t.xchb014,l_xchb014_desc.oocql_t.oocql004,xchb015.xchb_t.xchb015,xchb101.xchb_t.xchb101,xchb102a.xchb_t.xchb102a,xchb102b.xchb_t.xchb102b,xchb102c.xchb_t.xchb102c,xchb102d.xchb_t.xchb102d,xchb102e.xchb_t.xchb102e,xchb102f.xchb_t.xchb102f,xchb102g.xchb_t.xchb102g,xchb102h.xchb_t.xchb102h,xchb102.xchb_t.xchb102,xchb203.xchb_t.xchb203,xchb204a.xchb_t.xchb204a,xchb204b.xchb_t.xchb204b,xchb204c.xchb_t.xchb204c,xchb204d.xchb_t.xchb204d,xchb204e.xchb_t.xchb204e,xchb204f.xchb_t.xchb204f,xchb204g.xchb_t.xchb204g,xchb204h.xchb_t.xchb204h,xchb204.xchb_t.xchb204,l_xchb201_xchb207_xchb209.xchb_t.xchb201,l_xchb202a_xchb208a_xchb210a.xchb_t.xchb202a,l_xchb202b_xchb208b_xchb210b.xchb_t.xchb202b,l_xchb202c_xchb208c_xchb210c.xchb_t.xchb202c,l_xchb202d_xchb208d_xchb210d.xchb_t.xchb202d,l_xchb202e_xchb208e_xchb210e.xchb_t.xchb202e,l_xchb202f_xchb208f_xchb210f.xchb_t.xchb202f,l_xchb202g_xchb208g_xchb210g.xchb_t.xchb202g,l_xchb202h_xchb208h_xchb210h.xchb_t.xchb202h,l_xchb202_xchb208_xchb210.xchb_t.xchb202,xchb305.xchb_t.xchb305,xchb306a.xchb_t.xchb306a,xchb306b.xchb_t.xchb306b,xchb306c.xchb_t.xchb306c,xchb306d.xchb_t.xchb306d,xchb306e.xchb_t.xchb306e,xchb306f.xchb_t.xchb306f,xchb306g.xchb_t.xchb306g,xchb306h.xchb_t.xchb306h,xchb306.xchb_t.xchb306,xchb301.xchb_t.xchb301,xchb302a.xchb_t.xchb302a,xchb302b.xchb_t.xchb302b,xchb302c.xchb_t.xchb302c,xchb302d.xchb_t.xchb302d,xchb302e.xchb_t.xchb302e,xchb302f.xchb_t.xchb302f,xchb302g.xchb_t.xchb302g,xchb302h.xchb_t.xchb302h,xchb302.xchb_t.xchb302,xchb303.xchb_t.xchb303,xchb304a.xchb_t.xchb304a,xchb304b.xchb_t.xchb304b,xchb304c.xchb_t.xchb304c,xchb304d.xchb_t.xchb304d,xchb304e.xchb_t.xchb304e,xchb304f.xchb_t.xchb304f,xchb304g.xchb_t.xchb304g,xchb304h.xchb_t.xchb304h,xchb304.xchb_t.xchb304,xchb307.xchb_t.xchb307,xchb308a.xchb_t.xchb308a,xchb308b.xchb_t.xchb308b,xchb308c.xchb_t.xchb308c,xchb308d.xchb_t.xchb308d,xchb308e.xchb_t.xchb308e,xchb308f.xchb_t.xchb308f,xchb308g.xchb_t.xchb308g,xchb308h.xchb_t.xchb308h,xchb308.xchb_t.xchb308,xchb309.xchb_t.xchb309,xchb310a.xchb_t.xchb310a,xchb310b.xchb_t.xchb310b,xchb310c.xchb_t.xchb310c,xchb310d.xchb_t.xchb310d,xchb310e.xchb_t.xchb310e,xchb310f.xchb_t.xchb310f,xchb310g.xchb_t.xchb310g,xchb310h.xchb_t.xchb310h,xchb310.xchb_t.xchb310,xchb901.xchb_t.xchb901,xchb902a.xchb_t.xchb902a,xchb902b.xchb_t.xchb902b,xchb902c.xchb_t.xchb902c,xchb902d.xchb_t.xchb902d,xchb902e.xchb_t.xchb902e,xchb902f.xchb_t.xchb902f,xchb902g.xchb_t.xchb902g,xchb902h.xchb_t.xchb902h,xchb902.xchb_t.xchb902" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="axcr571_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION axcr571_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?, 
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?, 
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="axcr571_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axcr571_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
DEFINE g_order       STRING
#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
     LET g_select = " SELECT xchbcomp,ooefl003,xchb002,xcbfl003,xchb006,xchb007,t1.oocql004,xchb008,xchb009,imaal003,imaal004,imag011,t2.oocql004,xchb010,'', 
       xchb011,xchb012,pjbal003,xcbb005,oocal003,xchb014,t3.oocql004,xchb015,
       xchb101,xchb102a,xchb102b,xchb102c,xchb102d,xchb102e,xchb102f,xchb102g,xchb102h,xchb102,
       xchb203,xchb204a,xchb204b,xchb204c,xchb204d,xchb204e,xchb204f,xchb204g,xchb204h,xchb204,
       xchb201+xchb207+xchb209,xchb202a+xchb208a+xchb210a,xchb202b+xchb208b+xchb210b,xchb202c+xchb208c+xchb210c,
       xchb202d+xchb208d+xchb210d,xchb202e+xchb208e+xchb210e,xchb202f+xchb208f+xchb210f,xchb202g+xchb208g+xchb210g,
       xchb202h+xchb208h+xchb210h,xchb202+xchb208+xchb210,
       xchb305,xchb306a,xchb306b,xchb306c,xchb306d,xchb306e,xchb306f,xchb306g,xchb306h,xchb306, 
       xchb301,xchb302a,xchb302b,xchb302c,xchb302d,xchb302e,xchb302f,xchb302g,xchb302h,xchb302,
       xchb303,xchb304a,xchb304b,xchb304c,xchb304d,xchb304e,xchb304f,xchb304g,xchb304h,xchb304,
       xchb307,xchb308a,xchb308b,xchb308c,xchb308d,xchb308e,xchb308f,xchb308g,xchb308h,xchb308,
       xchb309,xchb310a,xchb310b,xchb310c,xchb310d,xchb310e,xchb310f,xchb310g,xchb310h,xchb310,
       xchb901,xchb902a,xchb902b,xchb902c,xchb902d,xchb902e,xchb902f,xchb902g,xchb902h,xchb902,
       NVL(xcbt008,9999) xcbt008"
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
 
#   #end add-point
#   LET g_select = " SELECT xchbcomp,'',xchb002,NULL,xchb006,xchb007,NULL,xchb008,xchb009,NULL,NULL,NULL, 
#       NULL,xchb010,NULL,xchb011,xchb012,NULL,NULL,NULL,xchb014,'',xchb015,xchb101,xchb102a,xchb102b, 
#       xchb102c,xchb102d,xchb102e,xchb102f,xchb102g,xchb102h,xchb102,xchb203,xchb204a,xchb204b,xchb204c, 
#       xchb204d,xchb204e,xchb204f,xchb204g,xchb204h,xchb204,0,0,0,0,0,NULL,0,NULL,0,0,xchb305,xchb306a, 
#       xchb306b,xchb306c,xchb306d,xchb306e,xchb306f,xchb306g,xchb306h,xchb306,xchb301,xchb302a,xchb302b, 
#       xchb302c,xchb302d,xchb302e,xchb302f,xchb302g,xchb302h,xchb302,xchb303,xchb304a,xchb304b,xchb304c, 
#       xchb304d,xchb304e,xchb304f,xchb304g,xchb304h,xchb304,xchb307,xchb308a,xchb308b,xchb308c,xchb308d, 
#       xchb308e,xchb308f,xchb308g,xchb308h,xchb308,xchb309,xchb310a,xchb310b,xchb310c,xchb310d,xchb310e, 
#       xchb310f,xchb310g,xchb310h,xchb310,xchb901,xchb902a,xchb902b,xchb902c,xchb902d,xchb902e,xchb902f, 
#       xchb902g,xchb902h,xchb902,''"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_from = " FROM xchb_t LEFT OUTER JOIN xcha_t ON  xchbent = xchaent AND xchbcomp = xchacomp AND xchbld = xchald  AND xchb001 = xcha001 AND xchb002 = xcha002 AND xchb003 = xcha003",
                "                               AND xchb004 = xcha004 AND xchb005 = xcha005 AND xchb006 = xcha006 AND xchb007 = xcha007 AND xchb008 = xcha008",
                "             LEFT OUTER JOIN xcbt_t ON xcbtent = xchaent AND xcbtcomp = xchacomp AND xcbt001 = xcha004 AND xcbt002 = xcha005 AND xcbt003 = xcha006 AND xcbt004 = xcha007 AND xcbt005 = xcha008",
                "             LEFT OUTER JOIN ooefl_t ON xchbent = ooeflent AND ooefl001 = xchbcomp AND ooefl002 = '",g_dlang,"'",
                "             LEFT OUTER JOIN xcbfl_t ON xchbent = xcbflent AND xchbcomp = xcbflcomp AND xchb002 = xcbfl001 AND xcbfl002 = '",g_dlang,"'",
                "             LEFT OUTER JOIN oocql_t t1 ON t1.oocqlent = xchbent AND t1.oocql001 = 221 AND t1.oocql002 = xchb007 AND t1.oocql003 = '",g_dlang,"'"   ,
                "             LEFT OUTER JOIN imaal_t ON imaalent = xchbent AND imaal001 = xchb009 AND imaal002 = '",g_dlang,"'",
                "             LEFT OUTER JOIN pjbal_t ON pjbalent = xchbent AND pjbal001 = xchb012 AND pjbal002 = '",g_dlang,"'",
                "             LEFT OUTER JOIN xcbb_t ON xcbbent = xchaent AND xcbbcomp = xchacomp AND xcbb001 = xcha004 AND xcbb002 = xcha005 AND xcbb003 = xcha009 AND xcbb004 = xcha010",
                "             LEFT OUTER JOIN oocal_t ON oocalent = xchbent AND oocal001 = xcbb005 AND oocal002 = '",g_dlang,"'",
                "             LEFT OUTER JOIN imag_t ON imagent = xchbent AND imagsite='",g_site,"' AND imag001 = xchb009 ",
                "             LEFT OUTER JOIN oocql_t t2 ON t2.oocqlent = xchbent AND t2.oocql001 = 200 AND t2.oocql002 = imag011 AND t2.oocql003 = '",g_dlang,"'",
                "             LEFT OUTER JOIN oocql_t t3 ON t3.oocqlent = xchbent AND t3.oocql001 = 221 AND t3.oocql002 = xchb014 AND t3.oocql003 = '",g_dlang,"'"                
                               
#   #end add-point
#    LET g_from = " FROM xchb_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   LET g_order = " ORDER BY xchbcomp,xchb002,xchb006,xcbt008 "
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   LET g_where = g_where ,cl_sql_add_filter("xchb_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
#   #end add-point:sel_prep.sql.before
#   LET g_where = g_where ,cl_sql_add_filter("xchb_t")   #資料過濾功能
#   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
#   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
# 
#   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE axcr571_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE axcr571_x01_curs CURSOR FOR axcr571_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axcr571_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION axcr571_x01_ins_data()
DEFINE sr RECORD 
   xchbcomp LIKE xchb_t.xchbcomp, 
   l_xchbcomp_desc LIKE ooefl_t.ooefl003, 
   xchb002 LIKE xchb_t.xchb002, 
   l_xchb002_desc LIKE xcbfl_t.xcbfl003, 
   xchb006 LIKE xchb_t.xchb006, 
   xchb007 LIKE xchb_t.xchb007, 
   l_xchb007_desc LIKE type_t.chr80, 
   xchb008 LIKE xchb_t.xchb008, 
   xchb009 LIKE xchb_t.xchb009, 
   l_imaal003 LIKE imaal_t.imaal003, 
   l_imaal004 LIKE imaal_t.imaal004, 
   l_imag011 LIKE imag_t.imag011, 
   l_imag011_desc LIKE imag_t.imag011, 
   xchb010 LIKE xchb_t.xchb010, 
   l_xchb010_desc LIKE inaml_t.inaml004, 
   xchb011 LIKE xchb_t.xchb011, 
   xchb012 LIKE xchb_t.xchb012, 
   l_xchb012_desc LIKE pjbal_t.pjbal003, 
   l_xcbb005 LIKE xcbb_t.xcbb005, 
   l_xcbb005_desc LIKE xcbb_t.xcbb005, 
   xchb014 LIKE xchb_t.xchb014, 
   l_xchb014_desc LIKE oocql_t.oocql004, 
   xchb015 LIKE xchb_t.xchb015, 
   xchb101 LIKE xchb_t.xchb101, 
   xchb102a LIKE xchb_t.xchb102a, 
   xchb102b LIKE xchb_t.xchb102b, 
   xchb102c LIKE xchb_t.xchb102c, 
   xchb102d LIKE xchb_t.xchb102d, 
   xchb102e LIKE xchb_t.xchb102e, 
   xchb102f LIKE xchb_t.xchb102f, 
   xchb102g LIKE xchb_t.xchb102g, 
   xchb102h LIKE xchb_t.xchb102h, 
   xchb102 LIKE xchb_t.xchb102, 
   xchb203 LIKE xchb_t.xchb203, 
   xchb204a LIKE xchb_t.xchb204a, 
   xchb204b LIKE xchb_t.xchb204b, 
   xchb204c LIKE xchb_t.xchb204c, 
   xchb204d LIKE xchb_t.xchb204d, 
   xchb204e LIKE xchb_t.xchb204e, 
   xchb204f LIKE xchb_t.xchb204f, 
   xchb204g LIKE xchb_t.xchb204g, 
   xchb204h LIKE xchb_t.xchb204h, 
   xchb204 LIKE xchb_t.xchb204, 
   l_xchb201_xchb207_xchb209 LIKE xchb_t.xchb201, 
   l_xchb202a_xchb208a_xchb210a LIKE xchb_t.xchb202a, 
   l_xchb202b_xchb208b_xchb210b LIKE xchb_t.xchb202b, 
   l_xchb202c_xchb208c_xchb210c LIKE xchb_t.xchb202c, 
   l_xchb202d_xchb208d_xchb210d LIKE xchb_t.xchb202d, 
   l_xchb202e_xchb208e_xchb210e LIKE xchb_t.xchb202e, 
   l_xchb202f_xchb208f_xchb210f LIKE xchb_t.xchb202f, 
   l_xchb202g_xchb208g_xchb210g LIKE xchb_t.xchb202g, 
   l_xchb202h_xchb208h_xchb210h LIKE xchb_t.xchb202h, 
   l_xchb202_xchb208_xchb210 LIKE xchb_t.xchb202, 
   xchb305 LIKE xchb_t.xchb305, 
   xchb306a LIKE xchb_t.xchb306a, 
   xchb306b LIKE xchb_t.xchb306b, 
   xchb306c LIKE xchb_t.xchb306c, 
   xchb306d LIKE xchb_t.xchb306d, 
   xchb306e LIKE xchb_t.xchb306e, 
   xchb306f LIKE xchb_t.xchb306f, 
   xchb306g LIKE xchb_t.xchb306g, 
   xchb306h LIKE xchb_t.xchb306h, 
   xchb306 LIKE xchb_t.xchb306, 
   xchb301 LIKE xchb_t.xchb301, 
   xchb302a LIKE xchb_t.xchb302a, 
   xchb302b LIKE xchb_t.xchb302b, 
   xchb302c LIKE xchb_t.xchb302c, 
   xchb302d LIKE xchb_t.xchb302d, 
   xchb302e LIKE xchb_t.xchb302e, 
   xchb302f LIKE xchb_t.xchb302f, 
   xchb302g LIKE xchb_t.xchb302g, 
   xchb302h LIKE xchb_t.xchb302h, 
   xchb302 LIKE xchb_t.xchb302, 
   xchb303 LIKE xchb_t.xchb303, 
   xchb304a LIKE xchb_t.xchb304a, 
   xchb304b LIKE xchb_t.xchb304b, 
   xchb304c LIKE xchb_t.xchb304c, 
   xchb304d LIKE xchb_t.xchb304d, 
   xchb304e LIKE xchb_t.xchb304e, 
   xchb304f LIKE xchb_t.xchb304f, 
   xchb304g LIKE xchb_t.xchb304g, 
   xchb304h LIKE xchb_t.xchb304h, 
   xchb304 LIKE xchb_t.xchb304, 
   xchb307 LIKE xchb_t.xchb307, 
   xchb308a LIKE xchb_t.xchb308a, 
   xchb308b LIKE xchb_t.xchb308b, 
   xchb308c LIKE xchb_t.xchb308c, 
   xchb308d LIKE xchb_t.xchb308d, 
   xchb308e LIKE xchb_t.xchb308e, 
   xchb308f LIKE xchb_t.xchb308f, 
   xchb308g LIKE xchb_t.xchb308g, 
   xchb308h LIKE xchb_t.xchb308h, 
   xchb308 LIKE xchb_t.xchb308, 
   xchb309 LIKE xchb_t.xchb309, 
   xchb310a LIKE xchb_t.xchb310a, 
   xchb310b LIKE xchb_t.xchb310b, 
   xchb310c LIKE xchb_t.xchb310c, 
   xchb310d LIKE xchb_t.xchb310d, 
   xchb310e LIKE xchb_t.xchb310e, 
   xchb310f LIKE xchb_t.xchb310f, 
   xchb310g LIKE xchb_t.xchb310g, 
   xchb310h LIKE xchb_t.xchb310h, 
   xchb310 LIKE xchb_t.xchb310, 
   xchb901 LIKE xchb_t.xchb901, 
   xchb902a LIKE xchb_t.xchb902a, 
   xchb902b LIKE xchb_t.xchb902b, 
   xchb902c LIKE xchb_t.xchb902c, 
   xchb902d LIKE xchb_t.xchb902d, 
   xchb902e LIKE xchb_t.xchb902e, 
   xchb902f LIKE xchb_t.xchb902f, 
   xchb902g LIKE xchb_t.xchb902g, 
   xchb902h LIKE xchb_t.xchb902h, 
   xchb902 LIKE xchb_t.xchb902, 
   l_order LIKE xcbt_t.xcbt008
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH axcr571_x01_curs INTO sr.*                               
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
       EXECUTE insert_prep USING sr.xchbcomp,sr.l_xchbcomp_desc,sr.xchb002,sr.l_xchb002_desc,sr.xchb006,sr.xchb007,sr.l_xchb007_desc,sr.xchb008,sr.xchb009,sr.l_imaal003,sr.l_imaal004,sr.l_imag011,sr.l_imag011_desc,sr.xchb010,sr.l_xchb010_desc,sr.xchb011,sr.xchb012,sr.l_xchb012_desc,sr.l_xcbb005,sr.l_xcbb005_desc,sr.xchb014,sr.l_xchb014_desc,sr.xchb015,sr.xchb101,sr.xchb102a,sr.xchb102b,sr.xchb102c,sr.xchb102d,sr.xchb102e,sr.xchb102f,sr.xchb102g,sr.xchb102h,sr.xchb102,sr.xchb203,sr.xchb204a,sr.xchb204b,sr.xchb204c,sr.xchb204d,sr.xchb204e,sr.xchb204f,sr.xchb204g,sr.xchb204h,sr.xchb204,sr.l_xchb201_xchb207_xchb209,sr.l_xchb202a_xchb208a_xchb210a,sr.l_xchb202b_xchb208b_xchb210b,sr.l_xchb202c_xchb208c_xchb210c,sr.l_xchb202d_xchb208d_xchb210d,sr.l_xchb202e_xchb208e_xchb210e,sr.l_xchb202f_xchb208f_xchb210f,sr.l_xchb202g_xchb208g_xchb210g,sr.l_xchb202h_xchb208h_xchb210h,sr.l_xchb202_xchb208_xchb210,sr.xchb305,sr.xchb306a,sr.xchb306b,sr.xchb306c,sr.xchb306d,sr.xchb306e,sr.xchb306f,sr.xchb306g,sr.xchb306h,sr.xchb306,sr.xchb301,sr.xchb302a,sr.xchb302b,sr.xchb302c,sr.xchb302d,sr.xchb302e,sr.xchb302f,sr.xchb302g,sr.xchb302h,sr.xchb302,sr.xchb303,sr.xchb304a,sr.xchb304b,sr.xchb304c,sr.xchb304d,sr.xchb304e,sr.xchb304f,sr.xchb304g,sr.xchb304h,sr.xchb304,sr.xchb307,sr.xchb308a,sr.xchb308b,sr.xchb308c,sr.xchb308d,sr.xchb308e,sr.xchb308f,sr.xchb308g,sr.xchb308h,sr.xchb308,sr.xchb309,sr.xchb310a,sr.xchb310b,sr.xchb310c,sr.xchb310d,sr.xchb310e,sr.xchb310f,sr.xchb310g,sr.xchb310h,sr.xchb310,sr.xchb901,sr.xchb902a,sr.xchb902b,sr.xchb902c,sr.xchb902d,sr.xchb902e,sr.xchb902f,sr.xchb902g,sr.xchb902h,sr.xchb902
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "axcr571_x01_execute"
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
 
{<section id="axcr571_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION axcr571_x01_rep_data()
#add-point:rep_data.define (客製用) name="rep_data.define_customerization"

#end add-point:rep_data.define
#add-point:rep_data.define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="rep_data.define"

#end add-point:rep_data.define
 
    #add-point:rep_data.before name="rep_data.before"
    IF NOT cl_get_para(g_enterprise,g_site,'S-FIN-6013') = 'N' THEN     
       LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED,"|xchb010|l_xchb010_desc"
    END IF
    IF NOT cl_get_para(g_enterprise,g_site,'S-FIN-6001') = 'N' THEN     
       LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED,"|xchb002|l_xchb002_desc"
    END IF
    IF tm.chk2 = 'N' THEN
       LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED,"|xchb102a|xchb102b|xchb102c|xchb102d|xchb102e|xchb102f|xchb102g|xchb102h"
       LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED,"|xchb202a|xchb202b|xchb202c|xchb202d|xchb202e|xchb202f|xchb202g|xchb202h"
       LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED,"|xchb204a|xchb204b|xchb204c|xchb204d|xchb204e|xchb204f|xchb204g|xchb204h"
       LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED,"|xchb302a|xchb302b|xchb302c|xchb302d|xchb302e|xchb302f|xchb302g|xchb302h"
       LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED,"|xchb304a|xchb304b|xchb304c|xchb304d|xchb304e|xchb304f|xchb304g|xchb304h"
       LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED,"|xchb306a|xchb306b|xchb306c|xchb306d|xchb306e|xchb306f|xchb306g|xchb306h"
       LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED,"|xchb308a|xchb308b|xchb308c|xchb308d|xchb308e|xchb308f|xchb308g|xchb308h"
       LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED,"|xchb310a|xchb310b|xchb310c|xchb310d|xchb310e|xchb310f|xchb310g|xchb310h"
       LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED,"|xchb902a|xchb902b|xchb902c|xchb902d|xchb902e|xchb902f|xchb902g|xchb902h"
    END IF
    #end add-point:rep_data.before
    
    CALL cl_xg_view()
    #add-point:rep_data.after name="rep_data.after"
    
    #end add-point:rep_data.after
END FUNCTION
 
{</section>}
 
{<section id="axcr571_x01.other_function" readonly="Y" >}

 
{</section>}
 
