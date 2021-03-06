#該程式未解開Section, 採用最新樣板產出!
{<section id="axcr540_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2016-09-10 16:29:31), PR版次:0002(2016-09-10 16:30:52)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000047
#+ Filename...: axcr540_x01
#+ Description: ...
#+ Creator....: 05426(2015-03-04 09:02:29)
#+ Modifier...: 02040 -SD/PR- 02040
 
{</section>}
 
{<section id="axcr540_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#160813-00002#1   2016/09/10 By 02040     工單號一張會由多個成本域領料，因此拿掉工單單頭的成本域對單身的成本域的條件
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
       flag1 LIKE type_t.chr1,         #隐藏成本域否 
       flag2 LIKE type_t.chr1,         #隐藏特性否 
       flag3 LIKE type_t.chr1,         #隐藏成本要素 
       flag4 LIKE type_t.chr1,         #隐藏明细否 
       wc2 STRING                   #QBE条件2
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 
#end add-point
 
{</section>}
 
{<section id="axcr540_x01.main" readonly="Y" >}
PUBLIC FUNCTION axcr540_x01(p_arg1,p_arg2,p_arg3,p_arg4,p_arg5,p_arg6)
DEFINE  p_arg1 STRING                  #tm.wc  QBE条件 
DEFINE  p_arg2 LIKE type_t.chr1         #tm.flag1  隐藏成本域否 
DEFINE  p_arg3 LIKE type_t.chr1         #tm.flag2  隐藏特性否 
DEFINE  p_arg4 LIKE type_t.chr1         #tm.flag3  隐藏成本要素 
DEFINE  p_arg5 LIKE type_t.chr1         #tm.flag4  隐藏明细否 
DEFINE  p_arg6 STRING                  #tm.wc2  QBE条件2
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.flag1 = p_arg2
   LET tm.flag2 = p_arg3
   LET tm.flag3 = p_arg4
   LET tm.flag4 = p_arg5
   LET tm.wc2 = p_arg6
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "axcr540_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL axcr540_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL axcr540_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL axcr540_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL axcr540_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL axcr540_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axcr540_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION axcr540_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "xccecomp.xcce_t.xccecomp,lbl_ooefl003.type_t.chr100,xcce002.xcce_t.xcce002,lbl_xcbfl003.type_t.chr30,xcce006.xcce_t.xcce006,xcce007.xcce_t.xcce007,lbl_imaal003.type_t.chr100,imaal004.imaal_t.imaal004,xcce008.xcce_t.xcce008,xcce009.xcce_t.xcce009,lbl_oocal003.type_t.chr100,xcce101.xcce_t.xcce101,xcce102a.xcce_t.xcce102a,xcce102b.xcce_t.xcce102b,xcce102c.xcce_t.xcce102c,xcce102d.xcce_t.xcce102d,xcce102e.xcce_t.xcce102e,xcce102f.xcce_t.xcce102f,xcce102g.xcce_t.xcce102g,xcce102h.xcce_t.xcce102h,xcce102.xcce_t.xcce102,xcce201.xcce_t.xcce201,xcce202.xcce_t.xcce202,xcce202a.xcce_t.xcce202a,xcce202b.xcce_t.xcce202b,xcce202c.xcce_t.xcce202c,xcce202d.xcce_t.xcce202d,xcce202e.xcce_t.xcce202e,xcce202f.xcce_t.xcce202f,xcce202g.xcce_t.xcce202g,xcce202h.xcce_t.xcce202h,xcce301.xcce_t.xcce301,xcce302.xcce_t.xcce302,xcce302a.xcce_t.xcce302a,xcce302b.xcce_t.xcce302b,xcce302c.xcce_t.xcce302c,xcce302d.xcce_t.xcce302d,xcce302e.xcce_t.xcce302e,xcce302f.xcce_t.xcce302f,xcce302g.xcce_t.xcce302g,xcce302h.xcce_t.xcce302h,xcce303.xcce_t.xcce303,xcce304.xcce_t.xcce304,xcce304a.xcce_t.xcce304a,xcce304b.xcce_t.xcce304b,xcce304c.xcce_t.xcce304c,xcce304d.xcce_t.xcce304d,xcce304e.xcce_t.xcce304e,xcce304f.xcce_t.xcce304f,xcce304g.xcce_t.xcce304g,xcce304h.xcce_t.xcce304h,xcce307.xcce_t.xcce307,xcce308.xcce_t.xcce308,xcce308a.xcce_t.xcce308a,xcce308b.xcce_t.xcce308b,xcce308c.xcce_t.xcce308c,xcce308d.xcce_t.xcce308d,xcce308e.xcce_t.xcce308e,xcce308f.xcce_t.xcce308f,xcce308g.xcce_t.xcce308g,xcce308h.xcce_t.xcce308h,xcce901.xcce_t.xcce901,xcce902.xcce_t.xcce902,xcce902a.xcce_t.xcce902a,xcce902b.xcce_t.xcce902b,xcce902c.xcce_t.xcce902c,xcce902d.xcce_t.xcce902d,xcce902e.xcce_t.xcce902e,xcce902f.xcce_t.xcce902f,xcce902g.xcce_t.xcce902g,xcce902h.xcce_t.xcce902h,xcceent.xcce_t.xcceent,xcceld.xcce_t.xcceld,xcce001.xcce_t.xcce001,xcce003.xcce_t.xcce003,xcce004.xcce_t.xcce004,xcce005.xcce_t.xcce005,xcce010.xcce_t.xcce010,l_flag1.type_t.chr10,l_flag2.type_t.chr10,l_flag3.type_t.chr30,l_flag4.type_t.chr10" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="axcr540_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION axcr540_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="axcr540_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axcr540_x01_sel_prep()
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
   LET g_select = " SELECT xccecomp,NULL,xcce002,NULL,xcce006,xcce007,NULL,NULL,xcce008,xcce009,NULL, 
       xcce101,xcce102a,xcce102b,xcce102c,xcce102d,xcce102e,xcce102f,xcce102g,xcce102h,xcce102,xcce201, 
       xcce202,xcce202a,xcce202b,xcce202c,xcce202d,xcce202e,xcce202f,xcce202g,xcce202h,xcce301,xcce302, 
       xcce302a,xcce302b,xcce302c,xcce302d,xcce302e,xcce302f,xcce302g,xcce302h,xcce303,xcce304,xcce304a, 
       xcce304b,xcce304c,xcce304d,xcce304e,xcce304f,xcce304g,xcce304h,xcce307,xcce308,xcce308a,xcce308b, 
       xcce308c,xcce308d,xcce308e,xcce308f,xcce308g,xcce308h,xcce901,xcce902,xcce902a,xcce902b,xcce902c, 
       xcce902d,xcce902e,xcce902f,xcce902g,xcce902h,xcceent,xcceld,xcce001,xcce003,xcce004,xcce005,xcce010, 
       NULL,NULL,NULL,NULL"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_select = " SELECT xccecomp,ooefl_t.ooefl003,xcce002,xcbfl_t.xcbfl003,xcce006,xcce007,imaal_t.imaal003,imaal_t.imaal004,
       xcce008,xcce009,NULL, 
       xcce101,xcce102a,xcce102b,xcce102c,xcce102d,xcce102e,xcce102f,xcce102g,xcce102h,xcce102,
       
       xcce201+xcce205+xcce207+xcce209 AS xcce201,xcce202+xcce206+xcce208+xcce210 AS xcce202,xcce202a+xcce206a+xcce208a+xcce210a AS xcce202a, 
       xcce202b+xcce206b+xcce208b+xcce210b AS xcce202b,xcce202c+xcce206c+xcce208c+xcce210c AS xcce202c,xcce202d+xcce206d+xcce208d+xcce210d AS xcce202d,
       xcce202e+xcce206e+xcce208e+xcce210e AS xcce202e,xcce202f+xcce206f+xcce208f+xcce210f AS xcce202f,xcce202g+xcce206g+xcce208g+xcce210g AS xcce202g,
       xcce202h+xcce206h+xcce208h+xcce210h AS xcce202h,
       
       xcce301,xcce302,xcce302a,xcce302b,xcce302c,xcce302d,xcce302e,xcce302f,xcce302g,xcce302h,xcce303,xcce304,xcce304a, 
       xcce304b,xcce304c,xcce304d,xcce304e,xcce304f,xcce304g,xcce304h,xcce307,xcce308,xcce308a,xcce308b, 
       xcce308c,xcce308d,xcce308e,xcce308f,xcce308g,xcce308h,xcce901,xcce902,xcce902a,xcce902b,xcce902c, 
       xcce902d,xcce902e,xcce902f,xcce902g,xcce902h,xcceent,xcceld,xcce001,xcce003,xcce004,xcce005,xcce010, 
       NULL,NULL,NULL,NULL"
   #end add-point
    LET g_from = " FROM xcce_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_from = " FROM xcce_t ",
                " LEFT JOIN ooefl_t ON ooeflent = xcce_t.xcceent AND ooefl_t.ooefl001 = xcce_t.xccecomp AND ooefl_t.ooefl002 ='",g_dlang,"'",
                " LEFT JOIN imaal_t ON imaal_t.imaal001 = xcce_t.xcce007 AND imaal_t.imaalent = xcce_t.xcceent AND imaal_t.imaal002 = '",g_dlang,"'",
                " LEFT JOIN xcbfl_t ON xcbfl_t.xcbfl001 = xcce_t.xcce002 AND xcbfl_t.xcbflent = xcce_t.xcceent AND xcbfl_t.xcbfl002 = '",g_dlang,"'",
               #" LEFT JOIN xccd_t ON xcceent=xccdent AND  xcceld=xccdld AND xcce004=xccd004 AND xcce005=xccd005 AND xccd001=xcce001 AND xccd002=xcce002 AND xccd003=xcce003 AND xccd006=xcce006 ",  #160813-00002#1 mark
                " LEFT JOIN xccd_t ON xcceent=xccdent AND  xcceld=xccdld AND xcce004=xccd004 AND xcce005=xccd005 AND xccd001=xcce001 AND xccd003=xcce003 AND xccd006=xcce006 ",   #160813-00002#1 add
                " LEFT JOIN sfaa_t ON sfaaent=xcceent AND sfaadocno=xcce006",
                " LEFT JOIN imag_t ON imagent=xcceent AND imagsite='",g_site,"' AND imag001=xcce007",
                " LEFT JOIN imaa_t ON imaaent=xcceent AND imaa001=xcce007"
   

               
               
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
 
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("xcce_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE axcr540_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE axcr540_x01_curs CURSOR FOR axcr540_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axcr540_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION axcr540_x01_ins_data()
DEFINE sr RECORD 
   xccecomp LIKE xcce_t.xccecomp, 
   lbl_ooefl003 LIKE type_t.chr100, 
   xcce002 LIKE xcce_t.xcce002, 
   lbl_xcbfl003 LIKE type_t.chr30, 
   xcce006 LIKE xcce_t.xcce006, 
   xcce007 LIKE xcce_t.xcce007, 
   lbl_imaal003 LIKE type_t.chr100, 
   imaal004 LIKE imaal_t.imaal004, 
   xcce008 LIKE xcce_t.xcce008, 
   xcce009 LIKE xcce_t.xcce009, 
   lbl_oocal003 LIKE type_t.chr100, 
   xcce101 LIKE xcce_t.xcce101, 
   xcce102a LIKE xcce_t.xcce102a, 
   xcce102b LIKE xcce_t.xcce102b, 
   xcce102c LIKE xcce_t.xcce102c, 
   xcce102d LIKE xcce_t.xcce102d, 
   xcce102e LIKE xcce_t.xcce102e, 
   xcce102f LIKE xcce_t.xcce102f, 
   xcce102g LIKE xcce_t.xcce102g, 
   xcce102h LIKE xcce_t.xcce102h, 
   xcce102 LIKE xcce_t.xcce102, 
   xcce201 LIKE xcce_t.xcce201, 
   xcce202 LIKE xcce_t.xcce202, 
   xcce202a LIKE xcce_t.xcce202a, 
   xcce202b LIKE xcce_t.xcce202b, 
   xcce202c LIKE xcce_t.xcce202c, 
   xcce202d LIKE xcce_t.xcce202d, 
   xcce202e LIKE xcce_t.xcce202e, 
   xcce202f LIKE xcce_t.xcce202f, 
   xcce202g LIKE xcce_t.xcce202g, 
   xcce202h LIKE xcce_t.xcce202h, 
   xcce301 LIKE xcce_t.xcce301, 
   xcce302 LIKE xcce_t.xcce302, 
   xcce302a LIKE xcce_t.xcce302a, 
   xcce302b LIKE xcce_t.xcce302b, 
   xcce302c LIKE xcce_t.xcce302c, 
   xcce302d LIKE xcce_t.xcce302d, 
   xcce302e LIKE xcce_t.xcce302e, 
   xcce302f LIKE xcce_t.xcce302f, 
   xcce302g LIKE xcce_t.xcce302g, 
   xcce302h LIKE xcce_t.xcce302h, 
   xcce303 LIKE xcce_t.xcce303, 
   xcce304 LIKE xcce_t.xcce304, 
   xcce304a LIKE xcce_t.xcce304a, 
   xcce304b LIKE xcce_t.xcce304b, 
   xcce304c LIKE xcce_t.xcce304c, 
   xcce304d LIKE xcce_t.xcce304d, 
   xcce304e LIKE xcce_t.xcce304e, 
   xcce304f LIKE xcce_t.xcce304f, 
   xcce304g LIKE xcce_t.xcce304g, 
   xcce304h LIKE xcce_t.xcce304h, 
   xcce307 LIKE xcce_t.xcce307, 
   xcce308 LIKE xcce_t.xcce308, 
   xcce308a LIKE xcce_t.xcce308a, 
   xcce308b LIKE xcce_t.xcce308b, 
   xcce308c LIKE xcce_t.xcce308c, 
   xcce308d LIKE xcce_t.xcce308d, 
   xcce308e LIKE xcce_t.xcce308e, 
   xcce308f LIKE xcce_t.xcce308f, 
   xcce308g LIKE xcce_t.xcce308g, 
   xcce308h LIKE xcce_t.xcce308h, 
   xcce901 LIKE xcce_t.xcce901, 
   xcce902 LIKE xcce_t.xcce902, 
   xcce902a LIKE xcce_t.xcce902a, 
   xcce902b LIKE xcce_t.xcce902b, 
   xcce902c LIKE xcce_t.xcce902c, 
   xcce902d LIKE xcce_t.xcce902d, 
   xcce902e LIKE xcce_t.xcce902e, 
   xcce902f LIKE xcce_t.xcce902f, 
   xcce902g LIKE xcce_t.xcce902g, 
   xcce902h LIKE xcce_t.xcce902h, 
   xcceent LIKE xcce_t.xcceent, 
   xcceld LIKE xcce_t.xcceld, 
   xcce001 LIKE xcce_t.xcce001, 
   xcce003 LIKE xcce_t.xcce003, 
   xcce004 LIKE xcce_t.xcce004, 
   xcce005 LIKE xcce_t.xcce005, 
   xcce010 LIKE xcce_t.xcce010, 
   l_flag1 LIKE type_t.chr10, 
   l_flag2 LIKE type_t.chr10, 
   l_flag3 LIKE type_t.chr30, 
   l_flag4 LIKE type_t.chr10
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_xcbb005        LIKE xcbb_t.xcbb005
DEFINE l_select      STRING
DEFINE l_from        STRING
DEFINE l_where       STRING

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    #拆件在制明细
    IF cl_null(tm.wc2) THEN LET tm.wc2="1=1" END IF
    LET l_select = " SELECT xccicomp,ooefl_t.ooefl003,xcci002,xcbfl_t.xcbfl003,xcci006,xcci007,imaal_t.imaal003,imaal_t.imaal004,
       xcci008,xcci009,NULL, 
       xcci101,xcci102a,xcci102b,xcci102c,xcci102d,xcci102e,xcci102f,xcci102g,xcci102h,xcci102,
       xcci201, xcci202, xcci202a,xcci202b,xcci202c, xcci202d,xcci202e, xcci202f, xcci202g,xcci202h,
       xcci301,xcci302,xcci302a,xcci302b,xcci302c,xcci302d,xcci302e,xcci302f,xcci302g,xcci302h,xcci303,xcci304,xcci304a, 
       xcci304b,xcci304c,xcci304d,xcci304e,xcci304f,xcci304g,xcci304h,0,0,0,0, 0,0,0,0,0,0,xcci901,xcci902,xcci902a,xcci902b,xcci902c, 
       xcci902d,xcci902e,xcci902f,xcci902g,xcci902h,xccient,xccild,xcci001,xcci003,xcci004,xcci005,xcci010, 
       NULL,NULL,NULL,NULL"

      LET l_from = " FROM xcci_t ",
                " LEFT JOIN ooefl_t ON ooeflent = xcci_t.xccient AND ooefl_t.ooefl001 = xcci_t.xccicomp AND ooefl_t.ooefl002 ='",g_dlang,"'",
                " LEFT JOIN imaal_t ON imaal_t.imaal001 = xcci_t.xcci007 AND imaal_t.imaalent = xcci_t.xccient AND imaal_t.imaal002 = '",g_dlang,"'",
                " LEFT JOIN xcbfl_t ON xcbfl_t.xcbfl001 = xcci_t.xcci002 AND xcbfl_t.xcbflent = xcci_t.xccient AND xcbfl_t.xcbfl002 = '",g_dlang,"'",
                " LEFT JOIN xccd_t ON xccient=xccdent AND  xccild=xccdld AND xcci004=xccd004 AND xcci005=xccd005 AND xccd001=xcci001 AND xccd002=xcci002 AND xccd003=xcci003 AND xccd006=xcci006 ",
                " LEFT JOIN sfaa_t ON sfaaent=xccient AND sfaadocno=xcci006",
                " LEFT JOIN imag_t ON imagent=xccient AND imagsite='",g_site,"' AND imag001=xcci007",
                " LEFT JOIN imaa_t ON imaaent=xccient AND imaa001=xcci007" 
   
    LET l_where = " WHERE " ,tm.wc2 CLIPPED
    LET l_where = l_where ,cl_sql_add_filter("xcci_t")   #資料過濾功能
    LET g_sql = l_select CLIPPED ," ",l_from CLIPPED ," ",l_where CLIPPED
    LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
    PREPARE axcr540_x01_xcci_prepare FROM g_sql
    IF STATUS THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.extend = 'prepare:'
       LET g_errparam.code   = STATUS
       LET g_errparam.popup  = TRUE
       CALL cl_err()
       LET g_rep_success = 'N' 
    END IF
    DECLARE axcr540_x01_xcci_curs CURSOR FOR axcr540_x01_xcci_prepare
    LET g_rep_success = 'Y'
 
    FOREACH axcr540_x01_xcci_curs INTO sr.*                               
       IF STATUS THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = 'foreach xcci:'
          LET g_errparam.code   = STATUS
          LET g_errparam.popup  = TRUE
          CALL cl_err()
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
       #抓取成本单位+说明
       SELECT xcbb005 INTO l_xcbb005 FROM xcbb_t WHERE xcbbent=g_enterprise AND xcbbcomp=sr.xccecomp AND xcbb001=sr.xcce004 AND xcbb002=sr.xcce005 AND xcbb003=sr.xcce007 AND xcbb004=sr.xcce008
       IF NOT cl_null(l_xcbb005) THEN 
          SELECT oocal003 INTO sr.lbl_oocal003 FROM oocal_t WHERE oocalent=g_enterprise AND oocal001=l_xcbb005 AND oocal002=g_dlang       
          IF NOT cl_null(sr.lbl_oocal003) THEN 
            LET sr.lbl_oocal003=l_xcbb005,".",sr.lbl_oocal003 CLIPPED
          ELSE
              LET sr.lbl_oocal003=l_xcbb005
          END IF
       END IF
       #EXECUTE
       EXECUTE insert_prep USING sr.xccecomp,sr.lbl_ooefl003,sr.xcce002,sr.lbl_xcbfl003,sr.xcce006,sr.xcce007,sr.lbl_imaal003,sr.imaal004,sr.xcce008,sr.xcce009,sr.lbl_oocal003,sr.xcce101,sr.xcce102a,sr.xcce102b,sr.xcce102c,sr.xcce102d,sr.xcce102e,sr.xcce102f,sr.xcce102g,sr.xcce102h,sr.xcce102,sr.xcce201,sr.xcce202,sr.xcce202a,sr.xcce202b,sr.xcce202c,sr.xcce202d,sr.xcce202e,sr.xcce202f,sr.xcce202g,sr.xcce202h,sr.xcce301,sr.xcce302,sr.xcce302a,sr.xcce302b,sr.xcce302c,sr.xcce302d,sr.xcce302e,sr.xcce302f,sr.xcce302g,sr.xcce302h,sr.xcce303,sr.xcce304,sr.xcce304a,sr.xcce304b,sr.xcce304c,sr.xcce304d,sr.xcce304e,sr.xcce304f,sr.xcce304g,sr.xcce304h,sr.xcce307,sr.xcce308,sr.xcce308a,sr.xcce308b,sr.xcce308c,sr.xcce308d,sr.xcce308e,sr.xcce308f,sr.xcce308g,sr.xcce308h,sr.xcce901,sr.xcce902,sr.xcce902a,sr.xcce902b,sr.xcce902c,sr.xcce902d,sr.xcce902e,sr.xcce902f,sr.xcce902g,sr.xcce902h,sr.xcceent,sr.xcceld,sr.xcce001,sr.xcce003,sr.xcce004,sr.xcce005,sr.xcce010,sr.l_flag1,sr.l_flag2,sr.l_flag3,sr.l_flag4
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "axcr540_x01__xcci_execute"
          LET g_errparam.code   = SQLCA.sqlcode
          LET g_errparam.popup  = FALSE
          CALL cl_err()       
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
    END FOREACH
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH axcr540_x01_curs INTO sr.*                               
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
       #抓取成本单位+说明
       SELECT xcbb005 INTO l_xcbb005 FROM xcbb_t WHERE xcbbent=g_enterprise AND xcbbcomp=sr.xccecomp AND xcbb001=sr.xcce004 AND xcbb002=sr.xcce005 AND xcbb003=sr.xcce007 AND xcbb004=sr.xcce008
       SELECT oocal003 INTO sr.lbl_oocal003 FROM oocal_t WHERE oocalent=g_enterprise AND oocal001=l_xcbb005 AND oocal002=g_dlang
       LET sr.lbl_oocal003=l_xcbb005,".",sr.lbl_oocal003 CLIPPED
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.xccecomp,sr.lbl_ooefl003,sr.xcce002,sr.lbl_xcbfl003,sr.xcce006,sr.xcce007,sr.lbl_imaal003,sr.imaal004,sr.xcce008,sr.xcce009,sr.lbl_oocal003,sr.xcce101,sr.xcce102a,sr.xcce102b,sr.xcce102c,sr.xcce102d,sr.xcce102e,sr.xcce102f,sr.xcce102g,sr.xcce102h,sr.xcce102,sr.xcce201,sr.xcce202,sr.xcce202a,sr.xcce202b,sr.xcce202c,sr.xcce202d,sr.xcce202e,sr.xcce202f,sr.xcce202g,sr.xcce202h,sr.xcce301,sr.xcce302,sr.xcce302a,sr.xcce302b,sr.xcce302c,sr.xcce302d,sr.xcce302e,sr.xcce302f,sr.xcce302g,sr.xcce302h,sr.xcce303,sr.xcce304,sr.xcce304a,sr.xcce304b,sr.xcce304c,sr.xcce304d,sr.xcce304e,sr.xcce304f,sr.xcce304g,sr.xcce304h,sr.xcce307,sr.xcce308,sr.xcce308a,sr.xcce308b,sr.xcce308c,sr.xcce308d,sr.xcce308e,sr.xcce308f,sr.xcce308g,sr.xcce308h,sr.xcce901,sr.xcce902,sr.xcce902a,sr.xcce902b,sr.xcce902c,sr.xcce902d,sr.xcce902e,sr.xcce902f,sr.xcce902g,sr.xcce902h,sr.xcceent,sr.xcceld,sr.xcce001,sr.xcce003,sr.xcce004,sr.xcce005,sr.xcce010,sr.l_flag1,sr.l_flag2,sr.l_flag3,sr.l_flag4
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "axcr540_x01_execute"
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
 
{<section id="axcr540_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION axcr540_x01_rep_data()
#add-point:rep_data.define (客製用) name="rep_data.define_customerization"

#end add-point:rep_data.define
#add-point:rep_data.define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="rep_data.define"

#end add-point:rep_data.define
 
    #add-point:rep_data.before name="rep_data.before"
    IF tm.flag1 = 'N' THEN
      LET g_xgrid.visible_column = "xcce002|lbl_xcbfl003"
    END IF
    IF tm.flag2 = 'N' THEN
      LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED,"|xccc008"
    END IF
    IF tm.flag3 = 'N' THEN
      LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED,"|xcce102a|xcce102b|xcce102c|xcce102d|xcce102e|xcce102f|xcce102g|xcce102h|",
                                                                   "xcce202a|xcce202b|xcce202c|xcce202d|xcce202e|xcce202f|xcce202g|xcce202h|",
                                                                   "xcce302a|xcce302b|xcce302c|xcce302d|xcce302e|xcce302f|xcce302g|xcce302h|",
                                                                   "xcce304a|xcce304b|xcce304c|xcce304d|xcce304e|xcce304f|xcce304g|xcce304h|",
                                                                   "xcce308a|xcce308b|xcce308c|xcce308d|xcce308e|xcce308f|xcce308g|xcce308h|",
                                                                   "xcce902a|xcce902b|xcce902c|xcce902d|xcce902e|xcce902f|xcce902g|xcce902h"
    END IF
    #end add-point:rep_data.before
    
    CALL cl_xg_view()
    #add-point:rep_data.after name="rep_data.after"
    
    #end add-point:rep_data.after
END FUNCTION
 
{</section>}
 
{<section id="axcr540_x01.other_function" readonly="Y" >}

 
{</section>}
 
