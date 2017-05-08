#該程式未解開Section, 採用最新樣板產出!
{<section id="axcr570_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2016-12-28 18:41:42), PR版次:0001(2016-12-28 18:43:51)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000001
#+ Filename...: axcr570_x01
#+ Description: 工艺在制主件成本表
#+ Creator....: 05423(2016-12-06 11:17:22)
#+ Modifier...: 05423 -SD/PR- 05423
 
{</section>}
 
{<section id="axcr570_x01.global" readonly="Y" >}
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
       chk LIKE type_t.chr2          #print option
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="axcr570_x01.main" readonly="Y" >}
PUBLIC FUNCTION axcr570_x01(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr2         #tm.chk  print option
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
   LET g_rep_code = "axcr570_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL axcr570_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL axcr570_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL axcr570_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL axcr570_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL axcr570_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axcr570_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION axcr570_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "xchacomp.xcha_t.xchacomp,l_xchacomp.ooefl_t.ooefl004,xcha002.xcha_t.xcha002,l_xcha002.xcbfl_t.xcbfl003,xcha006.xcha_t.xcha006,xcha007.xcha_t.xcha007,l_xcha007.oocql_t.oocql004,xcha008.xcha_t.xcha008,xcha009.xcha_t.xcha009,l_imaal003.imaal_t.imaal003,l_imaal004.imaal_t.imaal004,l_imag011.imag_t.imag011,l_imag011_desc.oocql_t.oocql004,xcha010.xcha_t.xcha010,l_xcha010.inaml_t.inaml004,xcha011.xcha_t.xcha011,xcha012.xcha_t.xcha012,l_xcha012.pjabl_t.pjabl003,xcbb005.xcbb_t.xcbb005,l_xcbb005.oocal_t.oocal003,xcha101.xcha_t.xcha101,xcha102a.xcha_t.xcha102a,xcha102b.xcha_t.xcha102b,xcha102c.xcha_t.xcha102c,xcha102d.xcha_t.xcha102d,xcha102e.xcha_t.xcha102e,xcha102f.xcha_t.xcha102f,xcha102g.xcha_t.xcha102g,xcha102h.xcha_t.xcha102h,xcha102.xcha_t.xcha102,xcha203.xcha_t.xcha203,xcha204a.xcha_t.xcha204a,xcha204b.xcha_t.xcha204b,xcha204c.xcha_t.xcha204c,xcha204d.xcha_t.xcha204d,xcha204e.xcha_t.xcha204e,xcha204f.xcha_t.xcha204f,xcha204g.xcha_t.xcha204g,xcha204h.xcha_t.xcha204h,xcha204.xcha_t.xcha204,xcha201.xcha_t.xcha201,xcha202a.xcha_t.xcha202a,xcha202b.xcha_t.xcha202b,xcha202c.xcha_t.xcha202c,xcha202d.xcha_t.xcha202d,xcha202e.xcha_t.xcha202e,xcha202f.xcha_t.xcha202f,xcha202g.xcha_t.xcha202g,xcha202h.xcha_t.xcha202h,xcha202.xcha_t.xcha202,xcha301.xcha_t.xcha301,xcha302a.xcha_t.xcha302a,xcha302b.xcha_t.xcha302b,xcha302c.xcha_t.xcha302c,xcha302d.xcha_t.xcha302d,xcha302e.xcha_t.xcha302e,xcha302f.xcha_t.xcha302f,xcha302g.xcha_t.xcha302g,xcha302h.xcha_t.xcha302h,xcha302.xcha_t.xcha302,xcha303.xcha_t.xcha303,xcha304a.xcha_t.xcha304a,xcha304b.xcha_t.xcha304b,xcha304c.xcha_t.xcha304c,xcha304d.xcha_t.xcha304d,xcha304e.xcha_t.xcha304e,xcha304f.xcha_t.xcha304f,xcha304g.xcha_t.xcha304g,xcha304h.xcha_t.xcha304h,xcha304.xcha_t.xcha304,xcha305.xcha_t.xcha305,xcha306a.xcha_t.xcha306a,xcha306b.xcha_t.xcha306b,xcha306c.xcha_t.xcha306c,xcha306d.xcha_t.xcha306d,xcha306e.xcha_t.xcha306e,xcha306f.xcha_t.xcha306f,xcha306g.xcha_t.xcha306g,xcha306h.xcha_t.xcha306h,xcha306.xcha_t.xcha306,xcha307.xcha_t.xcha307,xcha308a.xcha_t.xcha308a,xcha308b.xcha_t.xcha308b,xcha308c.xcha_t.xcha308c,xcha308d.xcha_t.xcha308d,xcha308e.xcha_t.xcha308e,xcha308f.xcha_t.xcha308f,xcha308g.xcha_t.xcha308g,xcha308h.xcha_t.xcha308h,xcha308.xcha_t.xcha308,xcha309.xcha_t.xcha309,xcha310a.xcha_t.xcha310a,xcha310b.xcha_t.xcha310b,xcha310c.xcha_t.xcha310c,xcha310d.xcha_t.xcha310d,xcha310e.xcha_t.xcha310e,xcha310f.xcha_t.xcha310f,xcha310g.xcha_t.xcha310g,xcha310h.xcha_t.xcha310h,xcha310.xcha_t.xcha310,xcha901.xcha_t.xcha901,xcha902a.xcha_t.xcha902a,xcha902b.xcha_t.xcha902b,xcha902c.xcha_t.xcha902c,xcha902d.xcha_t.xcha902d,xcha902e.xcha_t.xcha902e,xcha902f.xcha_t.xcha902f,xcha902g.xcha_t.xcha902g,xcha902h.xcha_t.xcha902h,xcha902.xcha_t.xcha902" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="axcr570_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION axcr570_x01_ins_prep()
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
 
{<section id="axcr570_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axcr570_x01_sel_prep()
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
   LET g_select = " SELECT xchacomp,",
                  " (SELECT ooefl003 FROM ooefl_t WHERE ooeflent = xchaent AND ooefl001 = xchacomp AND ooefl002 = '",g_dlang,"') ooefl003,",
                  " xcha002,",
                  " (SELECT xcbfl003 FROM xcbfl_t WHERE xcbflent = xchaent AND xcbflcomp = xchacomp AND xcbfl001 = xcha002 AND xcbfl002 = '",g_dlang,"') xcbfl003,",
                  " xcha006,xcha007,",
                  " (SELECT oocql004 FROM oocql_t WHERE oocqlent = xchaent AND oocql001 = '221' AND oocql002 = xcha007 AND oocql003 = '",g_dlang,"') t1_oocql004,",
                  " xcha008,xcha009,",
                  " (SELECT imaal003 FROM imaal_t WHERE imaalent = xchaent AND imaal001 = xcha009 AND imaal002 = '",g_dlang,"') imaal003,",
                  " (SELECT imaal004 FROM imaal_t WHERE imaalent = xchaent AND imaal001 = xcha009 AND imaal002 = '",g_dlang,"') imaal004,",
                  " imag011,",
                  " (SELECT oocql004 FROM oocql_t WHERE oocqlent = imagent AND oocql001 = '200' AND oocql002 = imag011 AND oocql003 = '",g_dlang,"') t2_oocql004,",
                  " xcha010,",
                  " (SELECT inaml004 FROM inaml_t WHERE inamlent = xchaent AND inaml001 = xcha009 AND inaml002 = xcha010 AND inaml003 = '",g_dlang,"') inaml004,",
                  " xcha011,xcha012,",
                  " (SELECT pjabl003 FROM pjabl_t WHERE pjablent = xchaent AND pjabl001 = xcha012 AND pjabl002 = '",g_dlang,"') pjabl003,",
                  " xcbb005,",
                  " (SELECT oocal003 FROM oocal_t WHERE oocalent = xchaent AND oocal001 = xcbb005 AND oocal002 = '",g_dlang,"') oocal003,",
                  " xcha101,xcha102a,xcha102b,xcha102c,xcha102d,xcha102e,xcha102f,xcha102g,xcha102h,xcha102,",
                  " xcha203,xcha204a,xcha204b,xcha204c,xcha204d,xcha204e,xcha204f,xcha204g,xcha204h,xcha204,",
                  " xcha201,xcha202a,xcha202b,xcha202c,xcha202d,xcha202e,xcha202f,xcha202g,xcha202h,xcha202,",
                  " xcha301,xcha302a,xcha302b,xcha302c,xcha302d,xcha302e,xcha302f,xcha302g,xcha302h,xcha302,",
                  " xcha303,xcha304a,xcha304b,xcha304c,xcha304d,xcha304e,xcha304f,xcha304g,xcha304h,xcha304,",
                  " xcha305,xcha306a,xcha306b,xcha306c,xcha306d,xcha306e,xcha306f,xcha306g,xcha306h,xcha306,",
                  " xcha307,xcha308a,xcha308b,xcha308c,xcha308d,xcha308e,xcha308f,xcha308g,xcha308h,xcha308,",
                  " xcha309,xcha310a,xcha310b,xcha310c,xcha310d,xcha310e,xcha310f,xcha310g,xcha310h,xcha310,",
                  " xcha901,xcha902a,xcha902b,xcha902c,xcha902d,xcha902e,xcha902f,xcha902g,xcha902h,xcha902,",
                  " NVL((SELECT xcbt008 FROM xcbt_t WHERE xcbtent = xchaent AND xcbtcomp = xchacomp AND xcbt001 = xcha004 AND xcbt002 = xcha005 AND xcbt003 = xcha006 AND xcbt004 = xcha007 AND xcbt005 = xcha008),9999) xcbt008"
#   #end add-point
#   LET g_select = " SELECT xchacomp,NULL,xcha002,NULL,xcha006,xcha007,NULL,xcha008,xcha009,NULL,NULL, 
#       NULL,NULL,xcha010,NULL,xcha011,xcha012,NULL,xcbb005,NULL,xcha101,xcha102a,xcha102b,xcha102c,xcha102d, 
#       xcha102e,xcha102f,xcha102g,xcha102h,xcha102,xcha203,xcha204a,xcha204b,xcha204c,xcha204d,xcha204e, 
#       xcha204f,xcha204g,xcha204h,xcha204,xcha201,xcha202a,xcha202b,xcha202c,xcha202d,xcha202e,xcha202f, 
#       xcha202g,xcha202h,xcha202,xcha301,xcha302a,xcha302b,xcha302c,xcha302d,xcha302e,xcha302f,xcha302g, 
#       xcha302h,xcha302,xcha303,xcha304a,xcha304b,xcha304c,xcha304d,xcha304e,xcha304f,xcha304g,xcha304h, 
#       xcha304,xcha305,xcha306a,xcha306b,xcha306c,xcha306d,xcha306e,xcha306f,xcha306g,xcha306h,xcha306, 
#       xcha307,xcha308a,xcha308b,xcha308c,xcha308d,xcha308e,xcha308f,xcha308g,xcha308h,xcha308,xcha309, 
#       xcha310a,xcha310b,xcha310c,xcha310d,xcha310e,xcha310f,xcha310g,xcha310h,xcha310,xcha901,xcha902a, 
#       xcha902b,xcha902c,xcha902d,xcha902e,xcha902f,xcha902g,xcha902h,xcha902,NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_from = " FROM xcha_t LEFT OUTER JOIN xcbb_t ON xcbbent = xchaent AND xcbbcomp = xchacomp AND xcbb001 = xcha004 AND xcbb002 = xcha005 AND xcbb003 = xcha009 AND xcbb004 = xcha010 ",
                "             LEFT OUTER JOIN imag_t ON imagent = xchaent AND imagsite='",g_site,"' AND imag001 = xcha009 "
#   #end add-point
#    LET g_from = " FROM xcbb_t,xcha_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   LET g_order = " ORDER BY xchacomp,xcha002,xcha006,xcbt008 "
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   LET g_where = g_where ,cl_sql_add_filter("xcbb_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
#   #end add-point:sel_prep.sql.before
#   LET g_where = g_where ,cl_sql_add_filter("xcbb_t")   #資料過濾功能
#   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
#   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
# 
#   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE axcr570_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE axcr570_x01_curs CURSOR FOR axcr570_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axcr570_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION axcr570_x01_ins_data()
DEFINE sr RECORD 
   xchacomp LIKE xcha_t.xchacomp, 
   l_xchacomp LIKE ooefl_t.ooefl004, 
   xcha002 LIKE xcha_t.xcha002, 
   l_xcha002 LIKE xcbfl_t.xcbfl003, 
   xcha006 LIKE xcha_t.xcha006, 
   xcha007 LIKE xcha_t.xcha007, 
   l_xcha007 LIKE oocql_t.oocql004, 
   xcha008 LIKE xcha_t.xcha008, 
   xcha009 LIKE xcha_t.xcha009, 
   l_imaal003 LIKE imaal_t.imaal003, 
   l_imaal004 LIKE imaal_t.imaal004, 
   l_imag011 LIKE imag_t.imag011, 
   l_imag011_desc LIKE oocql_t.oocql004, 
   xcha010 LIKE xcha_t.xcha010, 
   l_xcha010 LIKE inaml_t.inaml004, 
   xcha011 LIKE xcha_t.xcha011, 
   xcha012 LIKE xcha_t.xcha012, 
   l_xcha012 LIKE pjabl_t.pjabl003, 
   xcbb005 LIKE xcbb_t.xcbb005, 
   l_xcbb005 LIKE oocal_t.oocal003, 
   xcha101 LIKE xcha_t.xcha101, 
   xcha102a LIKE xcha_t.xcha102a, 
   xcha102b LIKE xcha_t.xcha102b, 
   xcha102c LIKE xcha_t.xcha102c, 
   xcha102d LIKE xcha_t.xcha102d, 
   xcha102e LIKE xcha_t.xcha102e, 
   xcha102f LIKE xcha_t.xcha102f, 
   xcha102g LIKE xcha_t.xcha102g, 
   xcha102h LIKE xcha_t.xcha102h, 
   xcha102 LIKE xcha_t.xcha102, 
   xcha203 LIKE xcha_t.xcha203, 
   xcha204a LIKE xcha_t.xcha204a, 
   xcha204b LIKE xcha_t.xcha204b, 
   xcha204c LIKE xcha_t.xcha204c, 
   xcha204d LIKE xcha_t.xcha204d, 
   xcha204e LIKE xcha_t.xcha204e, 
   xcha204f LIKE xcha_t.xcha204f, 
   xcha204g LIKE xcha_t.xcha204g, 
   xcha204h LIKE xcha_t.xcha204h, 
   xcha204 LIKE xcha_t.xcha204, 
   xcha201 LIKE xcha_t.xcha201, 
   xcha202a LIKE xcha_t.xcha202a, 
   xcha202b LIKE xcha_t.xcha202b, 
   xcha202c LIKE xcha_t.xcha202c, 
   xcha202d LIKE xcha_t.xcha202d, 
   xcha202e LIKE xcha_t.xcha202e, 
   xcha202f LIKE xcha_t.xcha202f, 
   xcha202g LIKE xcha_t.xcha202g, 
   xcha202h LIKE xcha_t.xcha202h, 
   xcha202 LIKE xcha_t.xcha202, 
   xcha301 LIKE xcha_t.xcha301, 
   xcha302a LIKE xcha_t.xcha302a, 
   xcha302b LIKE xcha_t.xcha302b, 
   xcha302c LIKE xcha_t.xcha302c, 
   xcha302d LIKE xcha_t.xcha302d, 
   xcha302e LIKE xcha_t.xcha302e, 
   xcha302f LIKE xcha_t.xcha302f, 
   xcha302g LIKE xcha_t.xcha302g, 
   xcha302h LIKE xcha_t.xcha302h, 
   xcha302 LIKE xcha_t.xcha302, 
   xcha303 LIKE xcha_t.xcha303, 
   xcha304a LIKE xcha_t.xcha304a, 
   xcha304b LIKE xcha_t.xcha304b, 
   xcha304c LIKE xcha_t.xcha304c, 
   xcha304d LIKE xcha_t.xcha304d, 
   xcha304e LIKE xcha_t.xcha304e, 
   xcha304f LIKE xcha_t.xcha304f, 
   xcha304g LIKE xcha_t.xcha304g, 
   xcha304h LIKE xcha_t.xcha304h, 
   xcha304 LIKE xcha_t.xcha304, 
   xcha305 LIKE xcha_t.xcha305, 
   xcha306a LIKE xcha_t.xcha306a, 
   xcha306b LIKE xcha_t.xcha306b, 
   xcha306c LIKE xcha_t.xcha306c, 
   xcha306d LIKE xcha_t.xcha306d, 
   xcha306e LIKE xcha_t.xcha306e, 
   xcha306f LIKE xcha_t.xcha306f, 
   xcha306g LIKE xcha_t.xcha306g, 
   xcha306h LIKE xcha_t.xcha306h, 
   xcha306 LIKE xcha_t.xcha306, 
   xcha307 LIKE xcha_t.xcha307, 
   xcha308a LIKE xcha_t.xcha308a, 
   xcha308b LIKE xcha_t.xcha308b, 
   xcha308c LIKE xcha_t.xcha308c, 
   xcha308d LIKE xcha_t.xcha308d, 
   xcha308e LIKE xcha_t.xcha308e, 
   xcha308f LIKE xcha_t.xcha308f, 
   xcha308g LIKE xcha_t.xcha308g, 
   xcha308h LIKE xcha_t.xcha308h, 
   xcha308 LIKE xcha_t.xcha308, 
   xcha309 LIKE xcha_t.xcha309, 
   xcha310a LIKE xcha_t.xcha310a, 
   xcha310b LIKE xcha_t.xcha310b, 
   xcha310c LIKE xcha_t.xcha310c, 
   xcha310d LIKE xcha_t.xcha310d, 
   xcha310e LIKE xcha_t.xcha310e, 
   xcha310f LIKE xcha_t.xcha310f, 
   xcha310g LIKE xcha_t.xcha310g, 
   xcha310h LIKE xcha_t.xcha310h, 
   xcha310 LIKE xcha_t.xcha310, 
   xcha901 LIKE xcha_t.xcha901, 
   xcha902a LIKE xcha_t.xcha902a, 
   xcha902b LIKE xcha_t.xcha902b, 
   xcha902c LIKE xcha_t.xcha902c, 
   xcha902d LIKE xcha_t.xcha902d, 
   xcha902e LIKE xcha_t.xcha902e, 
   xcha902f LIKE xcha_t.xcha902f, 
   xcha902g LIKE xcha_t.xcha902g, 
   xcha902h LIKE xcha_t.xcha902h, 
   xcha902 LIKE xcha_t.xcha902, 
   l_order LIKE xcbt_t.xcbt008
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH axcr570_x01_curs INTO sr.*                               
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
       EXECUTE insert_prep USING sr.xchacomp,sr.l_xchacomp,sr.xcha002,sr.l_xcha002,sr.xcha006,sr.xcha007,sr.l_xcha007,sr.xcha008,sr.xcha009,sr.l_imaal003,sr.l_imaal004,sr.l_imag011,sr.l_imag011_desc,sr.xcha010,sr.l_xcha010,sr.xcha011,sr.xcha012,sr.l_xcha012,sr.xcbb005,sr.l_xcbb005,sr.xcha101,sr.xcha102a,sr.xcha102b,sr.xcha102c,sr.xcha102d,sr.xcha102e,sr.xcha102f,sr.xcha102g,sr.xcha102h,sr.xcha102,sr.xcha203,sr.xcha204a,sr.xcha204b,sr.xcha204c,sr.xcha204d,sr.xcha204e,sr.xcha204f,sr.xcha204g,sr.xcha204h,sr.xcha204,sr.xcha201,sr.xcha202a,sr.xcha202b,sr.xcha202c,sr.xcha202d,sr.xcha202e,sr.xcha202f,sr.xcha202g,sr.xcha202h,sr.xcha202,sr.xcha301,sr.xcha302a,sr.xcha302b,sr.xcha302c,sr.xcha302d,sr.xcha302e,sr.xcha302f,sr.xcha302g,sr.xcha302h,sr.xcha302,sr.xcha303,sr.xcha304a,sr.xcha304b,sr.xcha304c,sr.xcha304d,sr.xcha304e,sr.xcha304f,sr.xcha304g,sr.xcha304h,sr.xcha304,sr.xcha305,sr.xcha306a,sr.xcha306b,sr.xcha306c,sr.xcha306d,sr.xcha306e,sr.xcha306f,sr.xcha306g,sr.xcha306h,sr.xcha306,sr.xcha307,sr.xcha308a,sr.xcha308b,sr.xcha308c,sr.xcha308d,sr.xcha308e,sr.xcha308f,sr.xcha308g,sr.xcha308h,sr.xcha308,sr.xcha309,sr.xcha310a,sr.xcha310b,sr.xcha310c,sr.xcha310d,sr.xcha310e,sr.xcha310f,sr.xcha310g,sr.xcha310h,sr.xcha310,sr.xcha901,sr.xcha902a,sr.xcha902b,sr.xcha902c,sr.xcha902d,sr.xcha902e,sr.xcha902f,sr.xcha902g,sr.xcha902h,sr.xcha902
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "axcr570_x01_execute"
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
 
{<section id="axcr570_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION axcr570_x01_rep_data()
#add-point:rep_data.define (客製用) name="rep_data.define_customerization"

#end add-point:rep_data.define
#add-point:rep_data.define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="rep_data.define"

#end add-point:rep_data.define
 
    #add-point:rep_data.before name="rep_data.before"
    IF NOT cl_get_para(g_enterprise,g_site,'S-FIN-6013') = 'N' THEN     
       LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED,"|xcha010|l_xcha010"
    END IF
    IF NOT cl_get_para(g_enterprise,g_site,'S-FIN-6001') = 'N' THEN     
       LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED,"|xcha002|l_xcha002"
    END IF
    IF tm.chk = 'N' THEN
       LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED,"|xcha102a|xcha102b|xcha102c|xcha102d|xcha102e|xcha102f|xcha102g|xcha102h"
       LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED,"|xcha202a|xcha202b|xcha202c|xcha202d|xcha202e|xcha202f|xcha202g|xcha202h"
       LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED,"|xcha204a|xcha204b|xcha204c|xcha204d|xcha204e|xcha204f|xcha204g|xcha204h"
       LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED,"|xcha302a|xcha302b|xcha302c|xcha302d|xcha302e|xcha302f|xcha302g|xcha302h"
       LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED,"|xcha304a|xcha304b|xcha304c|xcha304d|xcha304e|xcha304f|xcha304g|xcha304h"
       LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED,"|xcha306a|xcha306b|xcha306c|xcha306d|xcha306e|xcha306f|xcha306g|xcha306h"
       LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED,"|xcha308a|xcha308b|xcha308c|xcha308d|xcha308e|xcha308f|xcha308g|xcha308h"
       LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED,"|xcha310a|xcha310b|xcha310c|xcha310d|xcha310e|xcha310f|xcha310g|xcha310h"
       LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED,"|xcha902a|xcha902b|xcha902c|xcha902d|xcha902e|xcha902f|xcha902g|xcha902h"
    END IF
    #end add-point:rep_data.before
    
    CALL cl_xg_view()
    #add-point:rep_data.after name="rep_data.after"
    
    #end add-point:rep_data.after
END FUNCTION
 
{</section>}
 
{<section id="axcr570_x01.other_function" readonly="Y" >}

 
{</section>}
 
