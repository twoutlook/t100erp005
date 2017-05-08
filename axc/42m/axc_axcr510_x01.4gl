#該程式未解開Section, 採用最新樣板產出!
{<section id="axcr510_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2016-09-26 15:38:43), PR版次:0003(2016-09-26 15:42:57)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000050
#+ Filename...: axcr510_x01
#+ Description: ...
#+ Creator....: 05426(2015-02-13 14:07:02)
#+ Modifier...: 02295 -SD/PR- 02295
 
{</section>}
 
{<section id="axcr510_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#160816-00001#11  2016/08/17  By 08734     抓取理由碼改CALL sub
#160906-00021#1   2016/08/26  By 02295     出库是异动金额都为负数，入库时则为正数
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
       flag LIKE type_t.chr1,         #隱藏成本域否 
       flag1 LIKE type_t.chr1,         #隱藏明細否 
       flag2 LIKE type_t.chr1,         #隱藏特性否 
       flag3 LIKE type_t.chr1,         #隱藏要素否 
       out LIKE type_t.chr1          #異動類型
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE  g_acc  LIKE gzcb_t.gzcb007
#end add-point
 
{</section>}
 
{<section id="axcr510_x01.main" readonly="Y" >}
PUBLIC FUNCTION axcr510_x01(p_arg1,p_arg2,p_arg3,p_arg4,p_arg5,p_arg6)
DEFINE  p_arg1 STRING                  #tm.wc  QBE条件 
DEFINE  p_arg2 LIKE type_t.chr1         #tm.flag  隱藏成本域否 
DEFINE  p_arg3 LIKE type_t.chr1         #tm.flag1  隱藏明細否 
DEFINE  p_arg4 LIKE type_t.chr1         #tm.flag2  隱藏特性否 
DEFINE  p_arg5 LIKE type_t.chr1         #tm.flag3  隱藏要素否 
DEFINE  p_arg6 LIKE type_t.chr1         #tm.out  異動類型
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"
 
#end add-point
 
   LET tm.wc = p_arg1
   LET tm.flag = p_arg2
   LET tm.flag1 = p_arg3
   LET tm.flag2 = p_arg4
   LET tm.flag3 = p_arg5
   LET tm.out = p_arg6
 
   #add-point:報表元件參數準備 name="component.arg.prep"

   #抓取[T:系統分類值檔].[C:系統分類碼]=24且[T:系統分類值檔].[C:系統分類碼]=g_prog 的[T:系統分類值檔].[C:參考欄位二]的欄位值
  # SELECT gzcb004 INTO g_acc FROM gzcb_t WHERE gzcb001 = '24' AND gzcb002 = 'aint302'  #160816-00001#11  2016/08/17  By 08734 Mark
   LET g_acc = s_fin_get_scc_value('24','aint302','2')  #160816-00001#11  2016/08/17  By 08734 add
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "axcr510_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL axcr510_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL axcr510_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL axcr510_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL axcr510_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL axcr510_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axcr510_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION axcr510_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
 
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "xccksite.xcck_t.xccksite,ooefl_t_ooefl003.ooefl_t.ooefl003,xcck002.xcck_t.xcck002,l_xcck002_xcbfl003.type_t.chr1000,xcck003.xcck_t.xcck003,xcatl_t_xcatl003.xcatl_t.xcatl003,xcck013.xcck_t.xcck013,xcck006.xcck_t.xcck006,xcck007.xcck_t.xcck007,xcck008.xcck_t.xcck008,xcck015.xcck_t.xcck015,lbl_inayl001.type_t.chr30,xcck025.xcck_t.xcck025,t2_ooefl003.ooefl_t.ooefl003,xcck021.xcck_t.xcck021,lbl_oocql004.type_t.chr100,xcck010.xcck_t.xcck010,imaal_t_imaal003.imaal_t.imaal003,imaal004.imaal_t.imaal004,xcck011.xcck_t.xcck011,xcck017.xcck_t.xcck017,xcck044.xcck_t.xcck044,lbl_oocal003.type_t.chr100,xcck009.xcck_t.xcck009,xcck201.xcck_t.xcck201,xcck282a.xcck_t.xcck282a,xcck282b.xcck_t.xcck282b,xcck282c.xcck_t.xcck282c,xcck282d.xcck_t.xcck282d,xcck282e.xcck_t.xcck282e,xcck282f.xcck_t.xcck282f,xcck282g.xcck_t.xcck282g,xcck282h.xcck_t.xcck282h,xcck282.xcck_t.xcck282,xcck202a.xcck_t.xcck202a,xcck202b.xcck_t.xcck202b,xcck202c.xcck_t.xcck202c,xcck202d.xcck_t.xcck202d,xcck202e.xcck_t.xcck202e,xcck202f.xcck_t.xcck202f,xcck202g.xcck_t.xcck202g,xcck202h.xcck_t.xcck202h,xcck202.xcck_t.xcck202,xcckcomp.xcck_t.xcckcomp,xcckent.xcck_t.xcckent,xcckld.xcck_t.xcckld,l_flag.type_t.chr10,l_flag1.type_t.chr10,l_flag2.type_t.chr10,l_flag3.type_t.chr30" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="axcr510_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION axcr510_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)" 
 
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
 
{<section id="axcr510_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axcr510_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
DEFINE ls_wc2        STRING
DEFINE ls_wc3        STRING
#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
   #異動類型tm.out：為‘2’，則打印全部；為‘1’，則打印雜項出庫；為‘0’，則打印雜項入庫
   IF cl_null(tm.out) OR tm.out='2' THEN
      LET tm.wc=tm.wc," AND 1=1  AND xcck055 IN ('309','3091','3092','211')"
   END IF  
   IF tm.out='1' THEN                        
      LET tm.wc=tm.wc," AND xcck009=-1  AND xcck055 IN ('309','3091','3092')"
   END IF   
   IF tm.out='0' THEN                        
      LET tm.wc=tm.wc," AND xcck009=1 AND xcck055='211' "
   END IF
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
   
   #end add-point
   LET g_select = " SELECT xccksite,( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooeflent = xcck_t.xcckent AND ooefl_t.ooefl001 = xcck_t.xcckcomp AND ooefl_t.ooefl002 = '" , 
       g_dlang,"'" ,"),xcck002,trim(xcck002)||'.'||trim((SELECT xcbfl003 FROM xcbfl_t WHERE xcbfl_t.xcbfl001 = xcck_t.xcck002 AND xcbfl_t.xcbflent = xcck_t.xcckent AND xcbfl_t.xcbfl002 = '" , 
       g_dlang,"'" ,")),xcck003,( SELECT xcatl003 FROM xcatl_t WHERE xcatl_t.xcatlent = xcck_t.xcckent AND xcatl_t.xcatl001 = xcck_t.xcck003 AND xcatl_t.xcatl002 = '" , 
       g_dlang,"'" ,"),xcck013,xcck006,xcck007,xcck008,xcck015,NULL,xcck025,( SELECT ooefl003 FROM ooefl_t t2 WHERE t2.ooefl001 = xcck_t.xcck025 AND t2.ooeflent = xcck_t.xcckent AND t2.ooefl002 = '" , 
       g_dlang,"'" ,"),xcck021,NULL,xcck010,( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaal001 = xcck_t.xcck010 AND imaal_t.imaalent = xcck_t.xcckent AND imaal_t.imaal002 = '" , 
       g_dlang,"'" ,"),NULL,xcck011,xcck017,xcck044,NULL,xcck009,xcck201,xcck282a,xcck282b,xcck282c, 
       xcck282d,xcck282e,xcck282f,xcck282g,xcck282h,xcck282,xcck202a,xcck202b,xcck202c,xcck202d,xcck202e, 
       xcck202f,xcck202g,xcck202h,xcck202,xcckcomp,xcckent,xcckld,NULL,NULL,NULL,NULL,xcck004,xcck005, 
       xcck001"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_select = "SELECT xccksite,ooefl_t.ooefl003,xcck002,xcbfl_t.xcbfl003, 
       xcck003,xcatl_t.xcatl003,xcck013,xcck006,xcck007,xcck008,xcck015,inayl003,xcck025,t2.ooefl003,xcck021, 
       oocql004,xcck010,imaal_t.imaal003,imaal_t.imaal004,xcck011,xcck017,xcck044,oocal_t.oocal003,xcck009,xcck201,xcck282a,xcck282b, 
       xcck282c,xcck282d,xcck282e,xcck282f,xcck282g,xcck282h,xcck282,xcck202a,xcck202b,xcck202c,xcck202d, 
       xcck202e,xcck202f,xcck202g,xcck202h,xcck202,xcckcomp,xcckent,xcckld,NULL,NULL,NULL,NULL,xcck004,xcck005,xcck001"


#LET g_select = " SELECT xcck001,xcck002,xcck003,xcck004,xcck005,xcck006,xcck007,xcck008,xcck009,xcck010, 
#       xcck011,xcck013,trim(xcck015),xcck017,xcck021,xcck025,xcck040,xcck042,xcck044,xcck201,xcck202,xcck282, 
#       xcckcomp,xcckent,xcckld,xccksite,ooail_t.ooail003,t1.ooail003,xcbfl_t.xcbfl003,xcatl_t.xcatl003, 
#       trim(imaal_t.imaal003)||'.'||trim(imaal_t.imaal004),ooefl_t.ooefl003,t2.ooefl003,oocal_t.oocal003,glaal_t.glaal002,trim(xcck002)||'.'||trim(xcbfl_t.xcbfl003), 
#       trim(xcckcomp)||'.'||trim(ooefl_t.ooefl003),xcck202a,xcck202b,xcck202c,xcck202d,xcck202e,xcck202f, 
#       xcck202g,xcck202h,xcck282a,xcck282b,xcck282c,xcck282d,xcck282e,xcck282f,xcck282g,xcck282h,oocql004,inayl003"
{
   #end add-point
    LET g_from = " FROM xcck_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   }
   LET g_from=" FROM  xcck_t","    LEFT JOIN imag_t ON  imag001=xcck010 AND imagsite=xccksite AND imagent=xcckent",
                     "             LEFT JOIN imaa_t ON  imaaent=xcckent AND imaa001=xcck010",
                     "             LEFT JOIN xcbb_t ON  xcbbent=xcckent AND xcbbcomp=xcckcomp AND xcbb001=xcck004 AND xcbb002=xcck005 AND xcbb003=xcck010 AND xcbb004=xcck011 ",   
                     "             LEFT JOIN xccd_t ON   xccdent=xcckent AND  xccdld=xcckld AND xccd001=xcck001 AND xccd002=xcck002 AND xccd003=xcck003 AND xccd004=xcck004 AND xccd005=xcck005 AND xccd006=xcck006 ",
                                          
                     "             LEFT OUTER JOIN ooail_t ON ooail_t.ooail001 = xcck_t.xcck001 AND ooail_t.ooailent = xcck_t.xcckent AND ooail_t.ooail002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN xcbfl_t ON xcbfl_t.xcbfl001 = xcck_t.xcck002 AND xcbfl_t.xcbflent = xcck_t.xcckent AND xcbfl_t.xcbfl002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN xcatl_t ON xcatl_t.xcatlent = xcck_t.xcckent AND xcatl_t.xcatl001 = xcck_t.xcck003 AND xcatl_t.xcatl002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN imaal_t ON imaal_t.imaal001 = xcck_t.xcck010 AND imaal_t.imaalent = xcck_t.xcckent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN glaal_t ON glaal_t.glaalent = xcck_t.xcckent AND glaal_t.glaalld = xcck_t.xcckld AND glaal_t.glaal001 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN ooail_t t1 ON t1.ooail001 = xcck_t.xcck040 AND t1.ooailent = xcck_t.xcckent AND t1.ooail002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN oocal_t ON oocal_t.oocal001 = xcck_t.xcck044 AND oocal_t.oocalent = xcck_t.xcckent AND oocal_t.oocal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN ooefl_t ON ooefl_t.ooeflent = xcck_t.xcckent AND ooefl_t.ooefl001 = xcck_t.xcckcomp AND ooefl_t.ooefl002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN ooefl_t t2 ON t2.ooefl001 = xcck_t.xcck025 AND t2.ooeflent = xcck_t.xcckent AND t2.ooefl002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN inayl_t ON inaylent=xcckent AND inayl001=xcck015 AND inayl002='",
        g_dlang,"'" ,"             LEFT OUTER JOIN oocql_t ON xcck021 = oocql002 AND oocql001='",g_acc,"' AND xcckent = oocqlent AND oocql003 ='",
        g_dlang,"'" 
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
#   LET g_where="WHERE xccdent=xcckent AND  xccdld=xcckld AND xccd001=xcck001 AND xccd002=xcck002 AND xccd003=xcck003 AND xccd004=xcck004 AND xccd005=xcck005 AND xccd006=xcck006",
#   " AND imag001=xcck010 AND imagsite=xccksite AND imagent=xcckent ",
#   " AND imaaent=xcckent AND imaa001=xcck010",
#   " AND xcbbent=xcckent AND xcbbcomp=xcckcomp AND xcbb001=xcck004 AND xcbb002=xcck005 AND xcbb003=xcck010 AND xcbb004=xcck011 ",
#                 "AND xcckent=",g_enterprise,"  AND xcckcomp='",tm.comp,"' AND xcckld='",tm.ld,"' AND xcck001='",tm.order,"' AND xcck004=",tm.y," AND xcck005=",tm.m," AND xcck003='",tm.type,"' AND ",tm.wc CLIPPED
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("xcck_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
 
   #end add-point
   PREPARE axcr510_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE axcr510_x01_curs CURSOR FOR axcr510_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axcr510_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION axcr510_x01_ins_data()
DEFINE sr RECORD 
   xccksite LIKE xcck_t.xccksite, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   xcck002 LIKE xcck_t.xcck002, 
   l_xcck002_xcbfl003 LIKE type_t.chr1000, 
   xcck003 LIKE xcck_t.xcck003, 
   xcatl_t_xcatl003 LIKE xcatl_t.xcatl003, 
   xcck013 LIKE xcck_t.xcck013, 
   xcck006 LIKE xcck_t.xcck006, 
   xcck007 LIKE xcck_t.xcck007, 
   xcck008 LIKE xcck_t.xcck008, 
   xcck015 LIKE xcck_t.xcck015, 
   lbl_inayl001 LIKE type_t.chr30, 
   xcck025 LIKE xcck_t.xcck025, 
   t2_ooefl003 LIKE ooefl_t.ooefl003, 
   xcck021 LIKE xcck_t.xcck021, 
   lbl_oocql004 LIKE type_t.chr100, 
   xcck010 LIKE xcck_t.xcck010, 
   imaal_t_imaal003 LIKE imaal_t.imaal003, 
   imaal004 LIKE imaal_t.imaal004, 
   xcck011 LIKE xcck_t.xcck011, 
   xcck017 LIKE xcck_t.xcck017, 
   xcck044 LIKE xcck_t.xcck044, 
   lbl_oocal003 LIKE type_t.chr100, 
   xcck009 LIKE xcck_t.xcck009, 
   xcck201 LIKE xcck_t.xcck201, 
   xcck282a LIKE xcck_t.xcck282a, 
   xcck282b LIKE xcck_t.xcck282b, 
   xcck282c LIKE xcck_t.xcck282c, 
   xcck282d LIKE xcck_t.xcck282d, 
   xcck282e LIKE xcck_t.xcck282e, 
   xcck282f LIKE xcck_t.xcck282f, 
   xcck282g LIKE xcck_t.xcck282g, 
   xcck282h LIKE xcck_t.xcck282h, 
   xcck282 LIKE xcck_t.xcck282, 
   xcck202a LIKE xcck_t.xcck202a, 
   xcck202b LIKE xcck_t.xcck202b, 
   xcck202c LIKE xcck_t.xcck202c, 
   xcck202d LIKE xcck_t.xcck202d, 
   xcck202e LIKE xcck_t.xcck202e, 
   xcck202f LIKE xcck_t.xcck202f, 
   xcck202g LIKE xcck_t.xcck202g, 
   xcck202h LIKE xcck_t.xcck202h, 
   xcck202 LIKE xcck_t.xcck202, 
   xcckcomp LIKE xcck_t.xcckcomp, 
   xcckent LIKE xcck_t.xcckent, 
   xcckld LIKE xcck_t.xcckld, 
   l_flag LIKE type_t.chr10, 
   l_flag1 LIKE type_t.chr10, 
   l_flag2 LIKE type_t.chr10, 
   l_flag3 LIKE type_t.chr30, 
   xcck004 LIKE xcck_t.xcck004, 
   xcck005 LIKE xcck_t.xcck005, 
   xcck001 LIKE xcck_t.xcck001
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_xcck012         LIKE xcck_t.xcck012
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH axcr510_x01_curs INTO sr.*                               
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
       LET sr.xcck201=sr.xcck201*sr.xcck009
       LET sr.xcck202=sr.xcck202*sr.xcck009
       #160906-00021#1---add---s
       LET sr.xcck202a=sr.xcck202a*sr.xcck009
       LET sr.xcck202b=sr.xcck202b*sr.xcck009
       LET sr.xcck202c=sr.xcck202c*sr.xcck009
       LET sr.xcck202d=sr.xcck202d*sr.xcck009
       LET sr.xcck202e=sr.xcck202e*sr.xcck009
       LET sr.xcck202f=sr.xcck202f*sr.xcck009
       LET sr.xcck202g=sr.xcck202g*sr.xcck009
       LET sr.xcck202h=sr.xcck202h*sr.xcck009
       #160906-00021#1---add---e
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       #成本中心為空時賦值默認值
       IF cl_null(sr.xcck025) THEN
          #库存调整单的成本中心没抓到
          LET l_xcck012 = ' ' 
          SELECT xcck012 INTO l_xcck012 FROM xcck_t
             WHERE xcckent = g_enterprise AND xcckld = sr.xcckld
               AND xcck001 = sr.xcck001 AND xcck002 = sr.xcck002
               AND xcck003 = sr.xcck003 AND xcck004 = sr.xcck004
               AND xcck005 = sr.xcck005 AND xcck006 = sr.xcck006
               AND xcck007 = sr.xcck007 AND xcck008 = sr.xcck008
               AND xcck009 = sr.xcck009
          IF l_xcck012 = 'aint170' THEN   
             SELECT inbf002 INTO sr.xcck025
                 FROM inbf_t
                WHERE inbfent = g_enterprise
                  AND inbfdocno =sr.xcck006
          ELSE
             #库存调整单的成本中心没抓到         
             SELECT inba004 INTO sr.xcck025 FROM inba_t
                WHERE inbaent = g_enterprise AND inbadocno = sr.xcck006
               #没抓到aint311的部门
             IF cl_null(sr.xcck025) THEN
                SELECT inbj017 INTO sr.xcck025 FROM inbj_t
                      WHERE inbjent = g_enterprise AND inbjdocno = sr.xcck006
                        AND inbjseq = sr.xcck007
             END IF
          END IF
          SELECT ooefl003 INTO sr.t2_ooefl003 FROM ooefl_t WHERE ooeflent=g_enterprise AND ooefl001=sr.xcck025 AND ooefl002=g_dlang
       END IF
       IF cl_null(sr.xcck021) THEN
            SELECT inbb016 INTO sr.xcck021 FROM inbb_t
             WHERE inbbent = g_enterprise AND inbbdocno = sr.xcck006
               AND inbbseq = sr.xcck007  
          SELECT oocql004 INTO sr.lbl_oocql004 FROM oocql_t WHERE oocqlent=g_enterprise AND oocql001=g_acc AND oocql002 = sr.xcck021 AND oocql003=g_dlang               
       END IF
       IF cl_null(sr.xcck015) THEN
          SELECT inbc005 INTO sr.xcck015 FROM inbc_t
           WHERE inbcent = g_enterprise AND inbcdocno = sr.xcck006
             AND inbcseq = sr.xcck007 AND inbcseq1 = sr.xcck008
       END IF
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.xccksite,sr.ooefl_t_ooefl003,sr.xcck002,sr.l_xcck002_xcbfl003,sr.xcck003,sr.xcatl_t_xcatl003,sr.xcck013,sr.xcck006,sr.xcck007,sr.xcck008,sr.xcck015,sr.lbl_inayl001,sr.xcck025,sr.t2_ooefl003,sr.xcck021,sr.lbl_oocql004,sr.xcck010,sr.imaal_t_imaal003,sr.imaal004,sr.xcck011,sr.xcck017,sr.xcck044,sr.lbl_oocal003,sr.xcck009,sr.xcck201,sr.xcck282a,sr.xcck282b,sr.xcck282c,sr.xcck282d,sr.xcck282e,sr.xcck282f,sr.xcck282g,sr.xcck282h,sr.xcck282,sr.xcck202a,sr.xcck202b,sr.xcck202c,sr.xcck202d,sr.xcck202e,sr.xcck202f,sr.xcck202g,sr.xcck202h,sr.xcck202,sr.xcckcomp,sr.xcckent,sr.xcckld,sr.l_flag,sr.l_flag1,sr.l_flag2,sr.l_flag3
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "axcr510_x01_execute"
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
 
{<section id="axcr510_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION axcr510_x01_rep_data()
#add-point:rep_data.define (客製用) name="rep_data.define_customerization"

#end add-point:rep_data.define
#add-point:rep_data.define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="rep_data.define"

#end add-point:rep_data.define
 
    #add-point:rep_data.before name="rep_data.before"
    #隐藏成本域否
    IF tm.flag = 'N' THEN
      LET g_xgrid.visible_column = "xcck002|l_xcck002_xcbfl003"
    END IF
    #隐藏明细否
    IF tm.flag1 = 'N' THEN
      LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED,"|xcck013|xcck006|xcck007|xcck008|xcck015|lbl_inayl001"
    END IF
    #隐藏特性否
    IF tm.flag2 = 'N' THEN
      LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED,"|xcck011"
    END IF
    #隐藏要素否
    IF tm.flag3 = 'N' THEN
      LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED,"|xcck282a|xcck282b|xcck282c|xcck282d|xcck282e|xcck282f|xcck282g|xcck282h|xcck202a|xcck202b|xcck202c|xcck202d|xcck202e|xcck202f|xcck202g|xcck202h"
    END IF

    #end add-point:rep_data.before
    
    CALL cl_xg_view()
    #add-point:rep_data.after name="rep_data.after"
    
    #end add-point:rep_data.after
END FUNCTION
 
{</section>}
 
{<section id="axcr510_x01.other_function" readonly="Y" >}

 
{</section>}
 
