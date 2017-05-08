#該程式未解開Section, 採用最新樣板產出!
{<section id="axmr441_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2015-11-24 14:15:52), PR版次:0002(2015-11-24 18:09:12)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000054
#+ Filename...: axmr441_x01
#+ Description: ...
#+ Creator....: 05384(2015-03-05 14:37:15)
#+ Modifier...: 06815 -SD/PR- 06815
 
{</section>}
 
{<section id="axmr441_x01.global" readonly="Y" >}
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
       wc STRING                   #where condition
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="axmr441_x01.main" readonly="Y" >}
PUBLIC FUNCTION axmr441_x01(p_arg1)
DEFINE  p_arg1 STRING                  #tm.wc  where condition
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
   LET g_rep_code = "axmr441_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL axmr441_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL axmr441_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL axmr441_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL axmr441_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL axmr441_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axmr441_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION axmr441_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "xmde001.xmde_t.xmde001,xmde002.xmde_t.xmde002,l_xmdk003.xmdk_t.xmdk003,l_xmdk003_ooag011.ooag_t.ooag011,l_xmdk004.xmdk_t.xmdk004,l_xmdk004_ooefl003.ooefl_t.ooefl003,l_xmdk007.xmdk_t.xmdk007,l_xmdk007_pmaal004.pmaal_t.pmaal004,xmde005.xmde_t.xmde005,xmde003.xmde_t.xmde003,xmde004.xmde_t.xmde004,l_imaa009.imaa_t.imaa009,l_imaa009_rtaxl003.rtaxl_t.rtaxl003,l_imaf111.imaf_t.imaf111,l_imaf111_oocql004.oocql_t.oocql004,xmde006.xmde_t.xmde006,l_imaal003.imaal_t.imaal003,l_imaal004.imaal_t.imaal004,xmde007.xmde_t.xmde007,l_xmde007_desc.type_t.chr1000,l_imaa127.type_t.chr30,l_imaa127_desc.type_t.chr50,l_imaa127desc.type_t.chr80,xmde020.xmde_t.xmde020,xmde017.xmde_t.xmde017,xmde018.xmde_t.xmde018,xmde019.xmde_t.xmde019,xmde021.xmde_t.xmde021,xmde014.xmde_t.xmde014,xmde015.xmde_t.xmde015,xmde016.xmde_t.xmde016,xmde010.xmde_t.xmde010,xmde011.xmde_t.xmde011,xmde012.xmde_t.xmde012,xmde013.xmde_t.xmde013,xmde008.xmde_t.xmde008,xmde009.xmde_t.xmde009,l_xmde025_desc.gzcbl_t.gzcbl004,xmde027.xmde_t.xmde027,xmde028.xmde_t.xmde028" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="axmr441_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION axmr441_x01_ins_prep()
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
 
{<section id="axmr441_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axmr441_x01_sel_prep()
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
   #151113-00022#12 20151124 s983961--MOD(S)
   #LET g_select = " SELECT xmde001,xmde002,xmdk003,ooag011,xmdk004,ooefl003,xmdk007,pmaal004,xmde005,xmde003,xmde004,imaa009,'',imaf111,'',xmde006, 
   #    imaal003,imaal004,xmde007,'','','','',xmde020,xmde017,xmde018,xmde019,xmde021,xmde014,xmde015,xmde016,xmde010,xmde011, 
   #    xmde012,xmde013,xmde008,xmde009,xmde025,gzcbl004,xmde027,xmde028,xmdeent,xmdesite"
   LET g_select = " SELECT xmde001,xmde002,xmdk003,ooag011,xmdk004,ooefl003,xmdk007,pmaal004,xmde005,xmde003,xmde004,imaa009,rtaxl003,imaf111,a1.oocql004,xmde006, 
       imaal003,imaal004,xmde007,'',imaa127,a2.oocql004, trim(imaa127)||'.'||trim(a2.oocql004),
       xmde020,xmde017,xmde018,xmde019,xmde021,xmde014,xmde015,xmde016,xmde010,xmde011, 
       xmde012,xmde013,xmde008,xmde009,xmde025,gzcbl004,xmde027,xmde028,xmdeent,xmdesite"
  #151113-00022#12 20151124 s983961--MOD(S)     
#   #end add-point
#   LET g_select = " SELECT xmde001,xmde002,'','','','','','',xmde005,xmde003,xmde004,'','','','',xmde006, 
#       '','',xmde007,'','','','',xmde020,xmde017,xmde018,xmde019,xmde021,xmde014,xmde015,xmde016,xmde010, 
#       xmde011,xmde012,xmde013,xmde008,xmde009,xmde025,'',xmde027,xmde028,xmdeent,xmdesite"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   #151113-00022#12 20151124 s983961--MOD(S)
   #LET g_from = " FROM xmde_t LEFT OUTER JOIN imaa_t ON imaaent = xmdeent AND imaa001 = xmde006 ",
   #             "             LEFT OUTER JOIN imaf_t ON imafent = xmdeent AND imaf001 = xmde006 AND imafsite = xmdesite ",
   #             "             LEFT OUTER JOIN imaal_t ON imaalent = xmdeent AND imaal001 = xmde006 AND imaal002 = '",g_dlang,"' ",
   #             "             LEFT OUTER JOIN gzcbl_t ON gzcbl001 = '5450' AND gzcbl002 = xmde025 AND gzcbl003 = '",g_dlang,"' ",
   #             "     ,xmdk_t LEFT OUTER JOIN ooag_t ON ooag001 = xmdk003 AND ooagent = xmdkent ",
   #             "             LEFT OUTER JOIN ooefl_t ON ooefl001 = xmdk004 AND ooeflent = xmdkent AND ooefl002 = '",g_dlang,"' ",
   #             "             LEFT OUTER JOIN pmaal_t ON pmaal001 = xmdk007 AND pmaalent = xmdkent AND pmaal002 = '",g_dlang,"' "
   LET g_from = " FROM xmde_t LEFT OUTER JOIN imaa_t ON imaaent = xmdeent AND imaa001 = xmde006 ",
                "             LEFT OUTER JOIN imaf_t ON imafent = xmdeent AND imaf001 = xmde006 AND imafsite = xmdesite ",
                "             LEFT OUTER JOIN imaal_t ON imaalent = xmdeent AND imaal001 = xmde006 AND imaal002 = '",g_dlang,"' ",
                "             LEFT OUTER JOIN gzcbl_t ON gzcbl001 = '5450' AND gzcbl002 = xmde025 AND gzcbl003 = '",g_dlang,"' ",
                "             LEFT OUTER JOIN rtaxl_t ON rtaxlent = xmdeent AND rtaxl001 = imaa009 AND rtaxl002 = '",g_dlang,"' ",
                "             LEFT OUTER JOIN oocql_t a1 ON a1.oocqlent = xmdeent AND a1.oocql001 = '202' AND a1.oocql002 = imaf111 AND a1.oocql003 = '",g_dlang,"' ",
                "             LEFT OUTER JOIN oocql_t a2 ON a2.oocqlent = xmdeent AND a2.oocql001 = '2003' AND a2.oocql002 = imaa127 AND a2.oocql003 = '",g_dlang,"' ",
                "     ,xmdk_t LEFT OUTER JOIN ooag_t ON ooag001 = xmdk003 AND ooagent = xmdkent ",
                "             LEFT OUTER JOIN ooefl_t ON ooefl001 = xmdk004 AND ooeflent = xmdkent AND ooefl002 = '",g_dlang,"' ",
                "             LEFT OUTER JOIN pmaal_t ON pmaal001 = xmdk007 AND pmaalent = xmdkent AND pmaal002 = '",g_dlang,"' "
    #151113-00022#12 20151124 s983961--MOD(E)            
#   #end add-point
#    LET g_from = " FROM xmde_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
    LET g_where = " WHERE xmdeent = xmdkent AND xmde003 = xmdkdocno AND " ,tm.wc CLIPPED
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("xmde_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = g_sql CLIPPED ," ORDER BY xmde001,xmde002,xmde003,xmde004"
   #end add-point
   PREPARE axmr441_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE axmr441_x01_curs CURSOR FOR axmr441_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axmr441_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION axmr441_x01_ins_data()
DEFINE sr RECORD 
   xmde001 LIKE xmde_t.xmde001, 
   xmde002 LIKE xmde_t.xmde002, 
   l_xmdk003 LIKE xmdk_t.xmdk003, 
   l_xmdk003_ooag011 LIKE ooag_t.ooag011, 
   l_xmdk004 LIKE xmdk_t.xmdk004, 
   l_xmdk004_ooefl003 LIKE ooefl_t.ooefl003, 
   l_xmdk007 LIKE xmdk_t.xmdk007, 
   l_xmdk007_pmaal004 LIKE pmaal_t.pmaal004, 
   xmde005 LIKE xmde_t.xmde005, 
   xmde003 LIKE xmde_t.xmde003, 
   xmde004 LIKE xmde_t.xmde004, 
   l_imaa009 LIKE imaa_t.imaa009, 
   l_imaa009_rtaxl003 LIKE rtaxl_t.rtaxl003, 
   l_imaf111 LIKE imaf_t.imaf111, 
   l_imaf111_oocql004 LIKE oocql_t.oocql004, 
   xmde006 LIKE xmde_t.xmde006, 
   l_imaal003 LIKE imaal_t.imaal003, 
   l_imaal004 LIKE imaal_t.imaal004, 
   xmde007 LIKE xmde_t.xmde007, 
   l_xmde007_desc LIKE type_t.chr1000, 
   l_imaa127 LIKE type_t.chr30, 
   l_imaa127_desc LIKE type_t.chr50, 
   l_imaa127desc LIKE type_t.chr80, 
   xmde020 LIKE xmde_t.xmde020, 
   xmde017 LIKE xmde_t.xmde017, 
   xmde018 LIKE xmde_t.xmde018, 
   xmde019 LIKE xmde_t.xmde019, 
   xmde021 LIKE xmde_t.xmde021, 
   xmde014 LIKE xmde_t.xmde014, 
   xmde015 LIKE xmde_t.xmde015, 
   xmde016 LIKE xmde_t.xmde016, 
   xmde010 LIKE xmde_t.xmde010, 
   xmde011 LIKE xmde_t.xmde011, 
   xmde012 LIKE xmde_t.xmde012, 
   xmde013 LIKE xmde_t.xmde013, 
   xmde008 LIKE xmde_t.xmde008, 
   xmde009 LIKE xmde_t.xmde009, 
   xmde025 LIKE xmde_t.xmde025, 
   l_xmde025_desc LIKE gzcbl_t.gzcbl004, 
   xmde027 LIKE xmde_t.xmde027, 
   xmde028 LIKE xmde_t.xmde028, 
   xmdeent LIKE xmde_t.xmdeent, 
   xmdesite LIKE xmde_t.xmdesite
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_success   LIKE type_t.num5
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH axmr441_x01_curs INTO sr.*                               
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
       CALL s_feature_description(sr.xmde006,sr.xmde007) RETURNING l_success,sr.l_xmde007_desc
       IF NOT l_success THEN
          LET sr.l_xmde007_desc = ''
       END IF
       #151113-00022#12 20151124 s983961--MARK(S) 
       ##產品分類說明
       #CALL s_desc_get_rtaxl003_desc(sr.l_imaa009) RETURNING sr.l_imaa009_rtaxl003
       
       ##銷售分群說明
       #CALL s_desc_get_acc_desc(202,sr.l_imaf111) RETURNING sr.l_imaf111_oocql004
       
       ##系列說明  20150819 by dorislai add   (S)
       ##用料號抓取系列
       #SELECT imaa127 INTO sr.l_imaa127 FROM imaa_t
       # WHERE imaa001 = sr.xmde006
       #   AND imaaent = g_enterprise
       #   #抓取系列說明
       #CALL s_desc_get_acc_desc('2003',sr.l_imaa127)  RETURNING sr.l_imaa127_desc   
       #IF NOT cl_null(sr.l_imaa127_desc) THEN
       #   LET sr.l_imaa127desc = sr.l_imaa127,'.',sr.l_imaa127_desc
       #ELSE
       #   LET sr.l_imaa127desc = ''  
       #END IF
       ##         20150819 by dorislai add   (E)
       #151113-00022#12 20151124 s983961--MARK(E)
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.xmde001,sr.xmde002,sr.l_xmdk003,sr.l_xmdk003_ooag011,sr.l_xmdk004,sr.l_xmdk004_ooefl003,sr.l_xmdk007,sr.l_xmdk007_pmaal004,sr.xmde005,sr.xmde003,sr.xmde004,sr.l_imaa009,sr.l_imaa009_rtaxl003,sr.l_imaf111,sr.l_imaf111_oocql004,sr.xmde006,sr.l_imaal003,sr.l_imaal004,sr.xmde007,sr.l_xmde007_desc,sr.l_imaa127,sr.l_imaa127_desc,sr.l_imaa127desc,sr.xmde020,sr.xmde017,sr.xmde018,sr.xmde019,sr.xmde021,sr.xmde014,sr.xmde015,sr.xmde016,sr.xmde010,sr.xmde011,sr.xmde012,sr.xmde013,sr.xmde008,sr.xmde009,sr.l_xmde025_desc,sr.xmde027,sr.xmde028
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "axmr441_x01_execute"
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
 
{<section id="axmr441_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION axmr441_x01_rep_data()
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
 
{<section id="axmr441_x01.other_function" readonly="Y" >}

 
{</section>}
 
