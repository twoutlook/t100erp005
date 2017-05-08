#該程式未解開Section, 採用最新樣板產出!
{<section id="afar001_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2016-04-28 09:48:29), PR版次:0003(2016-04-28 11:33:20)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000055
#+ Filename...: afar001_g01
#+ Description: ...
#+ Creator....: 02003(2015-01-27 15:45:11)
#+ Modifier...: 01531 -SD/PR- 01531
 
{</section>}
 
{<section id="afar001_g01.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:13)
#add-point:填寫註解說明 name="global.memo"

#end add-point
#add-point:填寫註解說明 name="global.memo_customerization"

 
IMPORT os
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_report.inc"                  #報表使用的global
 
#報表 type 宣告
PRIVATE TYPE sr1_r RECORD
   faah_t_faah006 LIKE faah_t.faah006, 
   faah006_desc LIKE type_t.chr200, 
   faam009 LIKE faam_t.faam009, 
   faam009_desc LIKE type_t.chr200, 
   faah_t_faah025 LIKE faah_t.faah025, 
   faah025_desc LIKE type_t.chr200, 
   faah_t_faah028 LIKE faah_t.faah028, 
   faah028_desc LIKE type_t.chr200, 
   faah_t_faah003 LIKE faah_t.faah003, 
   faah_t_faah004 LIKE faah_t.faah004, 
   faah_t_faah001 LIKE faah_t.faah001, 
   faah_t_faah018 LIKE faah_t.faah018, 
   faah_t_faah014 LIKE faah_t.faah014, 
   faah_t_faah012 LIKE faah_t.faah012, 
   faajld LIKE faaj_t.faajld, 
   faaj004 LIKE faaj_t.faaj004, 
   faam003 LIKE faam_t.faam003, 
   faam003_desc LIKE type_t.chr200, 
   faam007 LIKE faam_t.faam007, 
   faam007_desc LIKE type_t.chr200, 
   faam010 LIKE faam_t.faam010, 
   faam010_desc LIKE type_t.chr200, 
   faam011 LIKE faam_t.faam011, 
   faam014 LIKE faam_t.faam014, 
   faam015_016 LIKE type_t.num20_6, 
   faam015 LIKE faam_t.faam015, 
   faam016 LIKE faam_t.faam016, 
   sumfaam013 LIKE type_t.num20_6, 
   faam013 LIKE faam_t.faam013, 
   faam01_015 LIKE type_t.num20_6, 
   faam014_015_018 LIKE type_t.num20_6, 
   faam018 LIKE faam_t.faam018, 
   groupby LIKE type_t.chr200, 
   faament LIKE faam_t.faament
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING,                  #where condition 
       site LIKE type_t.chr20,         #資產中心 
       ld LIKE type_t.chr20,         #帳套 
       year LIKE type_t.num5,         #年度 
       peri LIKE type_t.num5,         #期別 
       a LIKE type_t.chr1,         #分攤前後 
       b LIKE type_t.chr1,         #開賬/折舊 
       c LIKE type_t.chr1,         #多本位幣 
       d LIKE type_t.chr1,         #主要類型分頁 
       e LIKE type_t.chr1,         #幣別分頁 
       f LIKE type_t.chr1,         #部門分頁 
       g LIKE type_t.chr1          #人員分頁
       END RECORD
DEFINE sr DYNAMIC ARRAY OF sr1_r                   #宣告sr為sr1_t資料結構的動態陣列
DEFINE g_select        STRING
DEFINE g_from          STRING
DEFINE g_where         STRING
DEFINE g_order         STRING
DEFINE g_sql           STRING                         #report_select_prep,REPORT段使用
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="afar001_g01.main" readonly="Y" >}
PUBLIC FUNCTION afar001_g01(p_arg1,p_arg2,p_arg3,p_arg4,p_arg5,p_arg6,p_arg7,p_arg8,p_arg9,p_arg10,p_arg11,p_arg12)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr20         #tm.site  資產中心 
DEFINE  p_arg3 LIKE type_t.chr20         #tm.ld  帳套 
DEFINE  p_arg4 LIKE type_t.num5         #tm.year  年度 
DEFINE  p_arg5 LIKE type_t.num5         #tm.peri  期別 
DEFINE  p_arg6 LIKE type_t.chr1         #tm.a  分攤前後 
DEFINE  p_arg7 LIKE type_t.chr1         #tm.b  開賬/折舊 
DEFINE  p_arg8 LIKE type_t.chr1         #tm.c  多本位幣 
DEFINE  p_arg9 LIKE type_t.chr1         #tm.d  主要類型分頁 
DEFINE  p_arg10 LIKE type_t.chr1         #tm.e  幣別分頁 
DEFINE  p_arg11 LIKE type_t.chr1         #tm.f  部門分頁 
DEFINE  p_arg12 LIKE type_t.chr1         #tm.g  人員分頁
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.site = p_arg2
   LET tm.ld = p_arg3
   LET tm.year = p_arg4
   LET tm.peri = p_arg5
   LET tm.a = p_arg6
   LET tm.b = p_arg7
   LET tm.c = p_arg8
   LET tm.d = p_arg9
   LET tm.e = p_arg10
   LET tm.f = p_arg11
   LET tm.g = p_arg12
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "afar001_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL afar001_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL afar001_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL afar001_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="afar001_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION afar001_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   
   #end add-point
   LET g_select = " SELECT faah_t.faah006,NULL,faam009,NULL,faah_t.faah025,NULL,faah_t.faah028,NULL, 
       faah_t.faah003,faah_t.faah004,faah_t.faah001,faah_t.faah018,faah_t.faah014,faah_t.faah012,faajld, 
       faaj004,faam003,NULL,faam007,NULL,faam010,NULL,faam011,faam014,NULL,faam015,faam016,NULL,faam013, 
       NULL,NULL,faam018,NULL,faament"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
#160427-00002#1 mod--str--
#   LET g_select = " SELECT UNIQUE faah_t.faah006,NULL,faam009,NULL,faah_t.faah025,NULL,faah_t.faah028,NULL,faah_t.faah003,faah_t.faah004, 
#       faah_t.faah001,faah_t.faah018,faah_t.faah014,faah_t.faah012,faajld,faaj004,faam003,NULL,faam007,NULL,faam010,NULL, 
#       faam011,faam014,NULL,faam015,faam016,NULL,faam013,NULL,NULL,faam018,NULL,faament"
   LET g_select = " SELECT UNIQUE faah_t.faah006,(SELECT faacl003 FROM faacl_t WHERE faacl001 = faah006 AND faaclent = faahent AND faacl002 = '",g_lang,"'),",
                  "               CASE WHEN faam007='2' AND ",tm.a,"= '1' THEN faam010 ELSE faam009 END, ",
                  "               (SELECT ooefl003 FROM ooefl_t WHERE ooeflent= faament AND ooefl001= faam009 AND ooefl002  = '",g_lang,"'),",
                  "               faah_t.faah025,(SELECT ooag011 FROM ooag_t WHERE ooagent = faahent AND ooag001= faah025),",
                  "               faah_t.faah028,(SELECT ooefl003 FROM ooefl_t WHERE ooeflent= faahent AND ooefl001= faah028 AND ooefl002  = '",g_lang,"'),",
                  "               faah_t.faah003,faah_t.faah004, ",
                  "               faah_t.faah001,faah_t.faah018,faah_t.faah014,faah_t.faah012,faajld,faaj004,",
                  "               faam003,(SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001='9904' AND gzcbl002 = faam003 AND gzcbl003 = '",g_lang,"'),",
                  "               faam007,(SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001='9912' AND gzcbl002 = faam007 AND gzcbl003 = '",g_lang,"'),",
                  "               faam010,(SELECT ooefl003 FROM ooefl_t WHERE ooeflent= faament AND ooefl001= faam010 AND ooefl002  = '",g_lang,"'), ",
                  "               faam011,faam014,(faam015-faam016),",
                  "               CASE WHEN faam015 IS NULL THEN 0 ELSE faam015 END,",
                  "               CASE WHEN faam016 IS NULL THEN 0 ELSE faam016 END,",
                  "               CASE WHEN (SELECT faam016 FROM faam_t WHERE faament = faahent AND faamld = faajld AND faam000 = faah001 ",
                  "                             AND faam001 = faah003 AND faam002 = faah004 AND faam004 = ",tm.year," AND faam005 = ",tm.peri,") IS NULL THEN 0  ",
                  "                 ELSE    (SELECT faam016 FROM faam_t WHERE faament = faahent AND faamld = faajld AND faam000 = faah001 ",
                  "                             AND faam001 = faah003 AND faam002 = faah004 AND faam004 = ",tm.year," AND faam005 = ",tm.peri,") END,",
                  "               faam013,(faam014-faam015),(faam014-faam015-faam018),faam018,NULL,faament "
#160427-00002#1 mod--end--       
   #end add-point
    LET g_from = " FROM faam_t,faaj_t,faah_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
    LET g_where = " WHERE faahent = faajent AND faajent = faament ",
                  "   AND faah003 = faaj001 AND faah004 = faaj002 ",
                  "   AND faaj001 = faam001 AND faaj002 = faam002 ",  
                  "   AND faah001 = faaj037 AND faaj037 = faam000 ",
                  "   AND faajld = faamld ",
                  "   AND faahstus = 'Y' ",
                  "   AND faament= '",g_enterprise,"'",
                  "   AND faamld = '",tm.ld,"'",
                  "   AND faam004 = ",tm.year,
                  "   AND faam005 = ",tm.peri,
                  "   AND ", tm.wc CLIPPED   
   IF tm.a = '1' THEN
      LET g_where = g_where CLIPPED," AND (faam007 = '1' OR faam007 = '2' )" 
   ELSE
      LET g_where = g_where CLIPPED," AND (faam007 = '1' OR faam007 = '3' )" 
   END IF   

   IF tm.b = '1' THEN
      LET g_where = g_where CLIPPED," AND faam006 = '1' " 
   ELSE
      LET g_where = g_where CLIPPED," AND faam006 = '0' " 
   END IF                  
   #end add-point
    LET g_order = " ORDER BY groupby"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   LET g_order = " ORDER BY faament"
   IF tm.d='Y' THEN
      LET g_order = g_order,",faah006"
   END IF
   IF tm.e='Y' THEN
      LET g_order = g_order,",faam011"
   END IF   
   IF tm.f='Y' THEN
      LET g_order = g_order,",faam009"
   END IF   
   IF tm.g='Y' THEN
      LET g_order = g_order,",faah025"
   END IF      
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("faam_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE afar001_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE afar001_g01_curs CURSOR FOR afar001_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="afar001_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION afar001_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   faah_t_faah006 LIKE faah_t.faah006, 
   faah006_desc LIKE type_t.chr200, 
   faam009 LIKE faam_t.faam009, 
   faam009_desc LIKE type_t.chr200, 
   faah_t_faah025 LIKE faah_t.faah025, 
   faah025_desc LIKE type_t.chr200, 
   faah_t_faah028 LIKE faah_t.faah028, 
   faah028_desc LIKE type_t.chr200, 
   faah_t_faah003 LIKE faah_t.faah003, 
   faah_t_faah004 LIKE faah_t.faah004, 
   faah_t_faah001 LIKE faah_t.faah001, 
   faah_t_faah018 LIKE faah_t.faah018, 
   faah_t_faah014 LIKE faah_t.faah014, 
   faah_t_faah012 LIKE faah_t.faah012, 
   faajld LIKE faaj_t.faajld, 
   faaj004 LIKE faaj_t.faaj004, 
   faam003 LIKE faam_t.faam003, 
   faam003_desc LIKE type_t.chr200, 
   faam007 LIKE faam_t.faam007, 
   faam007_desc LIKE type_t.chr200, 
   faam010 LIKE faam_t.faam010, 
   faam010_desc LIKE type_t.chr200, 
   faam011 LIKE faam_t.faam011, 
   faam014 LIKE faam_t.faam014, 
   faam015_016 LIKE type_t.num20_6, 
   faam015 LIKE faam_t.faam015, 
   faam016 LIKE faam_t.faam016, 
   sumfaam013 LIKE type_t.num20_6, 
   faam013 LIKE faam_t.faam013, 
   faam01_015 LIKE type_t.num20_6, 
   faam014_015_018 LIKE type_t.num20_6, 
   faam018 LIKE faam_t.faam018, 
   groupby LIKE type_t.chr200, 
   faament LIKE faam_t.faament
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH afar001_g01_curs INTO sr_s.*
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
#160427-00002#1 mark--str--
#      #資產主要類型
#      SELECT faacl003 INTO sr_s.faah006_desc
#        FROM faacl_t 
#       WHERE faacl001=sr_s.faah_t_faah006
#         AND faacl002 = g_dlang 
#         AND faaclent = g_enterprise
 
       
#       #部門  
#       #單一部門分攤
#       IF sr_s.faam007='1' THEN
#          LET sr_s.faam009=sr_s.faam009
#       END IF  
#       #多部門分攤---分攤前
#       IF sr_s.faam007='2' AND tm.a='1' THEN
#          LET sr_s.faam009=sr_s.faam010
#       END IF   
#       #多部門分攤---分攤后 
#       IF sr_s.faam007='3' AND tm.a='2' THEN
#          LET sr_s.faam009=sr_s.faam009
#       END IF        
#       SELECT ooefl003 INTO sr_s.faam009_desc
#         FROM ooefl_t 
#        WHERE ooeflent=g_enterprise
#          AND ooefl001=sr_s.faam009
#          AND ooefl002 =g_dlang 


#       #存放組織          
#       SELECT ooefl003 INTO sr_s.faah028_desc
#         FROM ooefl_t 
#        WHERE ooeflent=g_enterprise
#          AND ooefl001=sr_s.faah_t_faah028
#          AND ooefl002 =g_dlang 


#       #分攤部門名稱
#       SELECT ooefl003 INTO sr_s.faam010_desc
#         FROM ooefl_t 
#        WHERE ooeflent=g_enterprise
#          AND ooefl001=sr_s.faam010
#          AND ooefl002 =g_dlang 
          
#      #保管人員名稱          
#      SELECT ooag011 INTO sr_s.faah025_desc
#        FROM ooag_t
#       WHERE ooagent=g_enterprise
#         AND ooag001= sr_s.faah_t_faah025    
         
#       #折舊方式
#       SELECT gzcbl004 INTO sr_s.faam003_desc
#         FROM gzcbl_t
#        WHERE gzcbl001='9904'
#          AND gzcbl002=sr_s.faam003
#          AND gzcbl003=g_dlang

#       #折舊費用分攤方式
#       SELECT gzcbl004 INTO sr_s.faam007_desc
#         FROM gzcbl_t
#        WHERE gzcbl001='9912'
#          AND gzcbl002=sr_s.faam007
#          AND gzcbl003=g_dlang       
#160427-00002#1 mark--end--        
          
      LET sr_s.groupby = sr_s.faament
      IF tm.d='Y' THEN
         LET sr_s.groupby = sr_s.groupby||','||sr_s.faah_t_faah006
      END IF
      IF tm.e='Y' THEN
         LET sr_s.groupby = sr_s.groupby||','||sr_s.faam011
      END IF   
      IF tm.f='Y' THEN
         LET sr_s.groupby = sr_s.groupby||','||sr_s.faam009
      END IF   
      IF tm.g='Y' THEN
         LET sr_s.groupby = sr_s.groupby||','||sr_s.faah_t_faah025
      END IF           

#160427-00002#1 mark--str--
#      IF cl_null(sr_s.faam015) THEN
#          LET sr_s.faam015=0
#       END IF
#       IF cl_null(sr_s.faam016) THEN
#          LET sr_s.faam016=0
#       END IF   
 

#       #前期折舊       
#       LET sr_s.faam015_016=sr_s.faam015-sr_s.faam016
#       IF cl_null(sr_s.faam014) THEN
#          LET sr_s.faam014=0
#       END IF
#       #帳面價值
#       LET sr_s.faam01_015=sr_s.faam014-sr_s.faam015 
#       IF cl_null(sr_s.faam018) THEN
#          LET sr_s.faam018=0
#       END IF      
#       #資產淨額       
#       LET sr_s.faam014_015_018=sr_s.faam014-sr_s.faam015-sr_s.faam018  
    

#       #本年折舊
#       SELECT faam016 INTO sr_s.sumfaam013
#         FROM faam_t
#        WHERE faament=g_enterprise
#          AND faamld=sr_s.faajld
#          AND faam000=sr_s.faah_t_faah001
#          AND faam001=sr_s.faah_t_faah003
#          AND faam002=sr_s.faah_t_faah004
#          AND faam004=tm.year
#          AND faam005=tm.peri
#       IF cl_null(sr_s.sumfaam013) THEN
#          LET sr_s.sumfaam013=0
#       END IF
#160427-00002#1 mark--end--        
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].faah_t_faah006 = sr_s.faah_t_faah006
       LET sr[l_cnt].faah006_desc = sr_s.faah006_desc
       LET sr[l_cnt].faam009 = sr_s.faam009
       LET sr[l_cnt].faam009_desc = sr_s.faam009_desc
       LET sr[l_cnt].faah_t_faah025 = sr_s.faah_t_faah025
       LET sr[l_cnt].faah025_desc = sr_s.faah025_desc
       LET sr[l_cnt].faah_t_faah028 = sr_s.faah_t_faah028
       LET sr[l_cnt].faah028_desc = sr_s.faah028_desc
       LET sr[l_cnt].faah_t_faah003 = sr_s.faah_t_faah003
       LET sr[l_cnt].faah_t_faah004 = sr_s.faah_t_faah004
       LET sr[l_cnt].faah_t_faah001 = sr_s.faah_t_faah001
       LET sr[l_cnt].faah_t_faah018 = sr_s.faah_t_faah018
       LET sr[l_cnt].faah_t_faah014 = sr_s.faah_t_faah014
       LET sr[l_cnt].faah_t_faah012 = sr_s.faah_t_faah012
       LET sr[l_cnt].faajld = sr_s.faajld
       LET sr[l_cnt].faaj004 = sr_s.faaj004
       LET sr[l_cnt].faam003 = sr_s.faam003
       LET sr[l_cnt].faam003_desc = sr_s.faam003_desc
       LET sr[l_cnt].faam007 = sr_s.faam007
       LET sr[l_cnt].faam007_desc = sr_s.faam007_desc
       LET sr[l_cnt].faam010 = sr_s.faam010
       LET sr[l_cnt].faam010_desc = sr_s.faam010_desc
       LET sr[l_cnt].faam011 = sr_s.faam011
       LET sr[l_cnt].faam014 = sr_s.faam014
       LET sr[l_cnt].faam015_016 = sr_s.faam015_016
       LET sr[l_cnt].faam015 = sr_s.faam015
       LET sr[l_cnt].faam016 = sr_s.faam016
       LET sr[l_cnt].sumfaam013 = sr_s.sumfaam013
       LET sr[l_cnt].faam013 = sr_s.faam013
       LET sr[l_cnt].faam01_015 = sr_s.faam01_015
       LET sr[l_cnt].faam014_015_018 = sr_s.faam014_015_018
       LET sr[l_cnt].faam018 = sr_s.faam018
       LET sr[l_cnt].groupby = sr_s.groupby
       LET sr[l_cnt].faament = sr_s.faament
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="afar001_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION afar001_g01_rep_data()
   DEFINE HANDLER         om.SaxDocumentHandler
   DEFINE l_i             INTEGER
 
    #判斷是否有報表資料，若回彈出訊息視窗
    IF sr.getLength() = 0 THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = "adz-00285"
       LET g_errparam.extend = NULL
       LET g_errparam.popup  = FALSE
       LET g_errparam.replace[1] = ''
       CALL cl_err()  
       RETURN 
    END IF
    WHILE TRUE   
       #add-point:rep_data段印前 name="rep_data.before"
       
       #end add-point     
       LET handler = cl_gr_handler()
       IF handler IS NOT NULL THEN
          START REPORT afar001_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT afar001_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT afar001_g01_rep
       END IF
       #add-point:rep_data段印完 name="rep_data.after"
       
       #end add-point       
       IF g_rep_flag = TRUE THEN
          LET g_rep_flag = FALSE
          EXIT WHILE
       END IF
    END WHILE
    #add-point:rep_data段離開while印完前 name="rep_data.end.before"
    
    #end add-point
    CALL cl_gr_close_report()
    #add-point:rep_data段離開while印完後 name="rep_data.end.after"
    
    #end add-point    
END FUNCTION
 
{</section>}
 
{<section id="afar001_g01.rep" readonly="Y" >}
PRIVATE REPORT afar001_g01_rep(sr1)
DEFINE sr1 sr1_r
DEFINE sr2 sr2_r
DEFINE l_subrep01_show  LIKE type_t.chr1,
       l_subrep02_show  LIKE type_t.chr1,
       l_subrep03_show  LIKE type_t.chr1,
       l_subrep04_show  LIKE type_t.chr1
DEFINE l_cnt           LIKE type_t.num10
DEFINE l_sub_sql       STRING
#add-point:rep段define  (客製用) name="rep.define_customerization"

#end add-point
#add-point:rep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="rep.define"
DEFINE l_faam014_sum             LIKE faam_t.faam014
DEFINE l_faam015_016_sum         LIKE faam_t.faam015
DEFINE l_sumfaam013_sum          LIKE faam_t.faam013
DEFINE l_faam013_sum             LIKE faam_t.faam013
DEFINE l_faam01_015_sum          LIKE faam_t.faam014
DEFINE l_aam014_015_018_sum      LIKE faam_t.faam014
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER EXTERNAL BY sr1.groupby
    #add-point:rep段ORDER_after name="rep.order.after"
    
    #end add-point
    
    FORMAT
       FIRST PAGE HEADER          
          PRINTX g_user,g_pdate,g_rep_code,g_company,g_ptime,g_user_name,g_date_fmt
          PRINTX tm.*
          PRINTX g_grNumFmt.*
          PRINTX g_rep_wcchp
 
          #讀取beforeGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.groupby
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.groupby
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'faament=' ,sr1.faament,'{+}faam007=' ,sr1.faam007,'{+}faam009=' ,sr1.faam009         
            CALL cl_gr_init_apr(sr1.groupby)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.groupby.before name="rep.b_group.groupby.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.faament CLIPPED ,"'", " AND  ooff003 = '", sr1.groupby CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE afar001_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE afar001_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT afar001_g01_subrep01
           DECLARE afar001_g01_repcur01 CURSOR FROM g_sql
           FOREACH afar001_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "afar001_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT afar001_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT afar001_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.groupby.after name="rep.b_group.groupby.after"
           
           #end add-point:
 
 
 
 
       ON EVERY ROW
          #add-point:rep.everyrow.before name="rep.everyrow.before"
          
          #end add-point:rep.everyrow.before
 
          #單身前備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub02.before name="rep.sub02.before"
           
           #end add-point:rep.sub02.before
 
           #add-point:rep.sub02.sql name="rep.sub02.sql"
           
           #end add-point:rep.sub02.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='2' AND ooffent = '", 
                sr1.faament CLIPPED ,"'", " AND  ooff003 = '", sr1.groupby CLIPPED ,"'"
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE afar001_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE afar001_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT afar001_g01_subrep02
           DECLARE afar001_g01_repcur02 CURSOR FROM g_sql
           FOREACH afar001_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "afar001_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT afar001_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT afar001_g01_subrep02
           #add-point:rep.sub02.after name="rep.sub02.after"
           
           #end add-point:rep.sub02.after
 
 
 
          #add-point:rep.everyrow.beforerow name="rep.everyrow.beforerow"
          
          #end add-point:rep.everyrow.beforerow
            
          PRINTX sr1.*
 
          #add-point:rep.everyrow.afterrow name="rep.everyrow.afterrow"
          
          #end add-point:rep.everyrow.afterrow
 
          #單身後備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub03.before name="rep.sub03.before"
           
           #end add-point:rep.sub03.before
 
           #add-point:rep.sub03.sql name="rep.sub03.sql"
           
           #end add-point:rep.sub03.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooff003 = '", 
                sr1.faament CLIPPED ,"'"
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE afar001_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE afar001_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT afar001_g01_subrep03
           DECLARE afar001_g01_repcur03 CURSOR FROM g_sql
           FOREACH afar001_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "afar001_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT afar001_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT afar001_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.groupby
 
           #add-point:rep.a_group.groupby.before name="rep.a_group.groupby.before"
           LET l_faam014_sum         = GROUP SUM(sr1.faam014)
           LET l_faam015_016_sum     = GROUP SUM(sr1.faam015_016)
           LET l_sumfaam013_sum      = GROUP SUM(sr1.sumfaam013)
           LET l_faam013_sum         = GROUP SUM(sr1.faam013)
           LET l_faam01_015_sum      = GROUP SUM(sr1.faam01_015)
           LET l_aam014_015_018_sum  = GROUP SUM(sr1.faam014_015_018)
           
           PRINTX l_faam014_sum
           PRINTX l_faam015_016_sum
           PRINTX l_sumfaam013_sum
           PRINTX l_faam013_sum
           PRINTX l_faam01_015_sum
           PRINTX l_aam014_015_018_sum
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.faament CLIPPED ,"'", " AND  ooff003 = '", sr1.groupby CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE afar001_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE afar001_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT afar001_g01_subrep04
           DECLARE afar001_g01_repcur04 CURSOR FROM g_sql
           FOREACH afar001_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "afar001_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT afar001_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT afar001_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.groupby.after name="rep.a_group.groupby.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
        
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="afar001_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT afar001_g01_subrep01(sr2)
DEFINE  sr2  sr2_r
#add-point:query段define(客製用) name="sub01.define_customerization" 

#end add-point
#add-point:sub01.define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sub01.define" 

#end add-point:sub01.define
 
    #add-point:sub01.order.before name="sub01.order.before" 
    
    #end add-point:sub01.order.before
 
 
 
    FORMAT
 
 
 
       ON EVERY ROW
            #add-point:sub01.everyrow.before name="sub01.everyrow.before" 
                          
            #end add-point:sub01.everyrow.before
 
            PRINTX sr2.*
 
            #add-point:sub01.everyrow.after name="sub01.everyrow.after" 
            
            #end add-point:sub01.everyrow.after
 
 
END REPORT
 
 
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT afar001_g01_subrep02(sr2)
DEFINE  sr2  sr2_r
#add-point:query段define(客製用) name="sub02.define_customerization" 

#end add-point
#add-point:sub02.define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sub02.define" 

#end add-point:sub02.define
 
    #add-point:sub02.order.before name="sub02.order.before" 
    
    #end add-point:sub02.order.before
 
 
 
    FORMAT
 
 
 
       ON EVERY ROW
            #add-point:sub02.everyrow.before name="sub02.everyrow.before" 
                          
            #end add-point:sub02.everyrow.before
 
            PRINTX sr2.*
 
            #add-point:sub02.everyrow.after name="sub02.everyrow.after" 
            
            #end add-point:sub02.everyrow.after
 
 
END REPORT
 
 
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT afar001_g01_subrep03(sr2)
DEFINE  sr2  sr2_r
#add-point:query段define(客製用) name="sub03.define_customerization" 

#end add-point
#add-point:sub03.define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sub03.define" 

#end add-point:sub03.define
 
    #add-point:sub03.order.before name="sub03.order.before" 
    
    #end add-point:sub03.order.before
 
 
 
    FORMAT
 
 
 
       ON EVERY ROW
            #add-point:sub03.everyrow.before name="sub03.everyrow.before" 
                          
            #end add-point:sub03.everyrow.before
 
            PRINTX sr2.*
 
            #add-point:sub03.everyrow.after name="sub03.everyrow.after" 
            
            #end add-point:sub03.everyrow.after
 
 
END REPORT
 
 
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT afar001_g01_subrep04(sr2)
DEFINE  sr2  sr2_r
#add-point:query段define(客製用) name="sub04.define_customerization" 

#end add-point
#add-point:sub04.define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sub04.define" 

#end add-point:sub04.define
 
    #add-point:sub04.order.before name="sub04.order.before" 
    
    #end add-point:sub04.order.before
 
 
 
    FORMAT
 
 
 
       ON EVERY ROW
            #add-point:sub04.everyrow.before name="sub04.everyrow.before" 
                          
            #end add-point:sub04.everyrow.before
 
            PRINTX sr2.*
 
            #add-point:sub04.everyrow.after name="sub04.everyrow.after" 
            
            #end add-point:sub04.everyrow.after
 
 
END REPORT
 
 
 
 
{</section>}
 
{<section id="afar001_g01.other_function" readonly="Y" >}

 
{</section>}
 
{<section id="afar001_g01.other_report" readonly="Y" >}

 
{</section>}
 
