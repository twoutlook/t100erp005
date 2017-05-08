#該程式未解開Section, 採用最新樣板產出!
{<section id="axcq530_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:5(2016-05-20 18:00:42), PR版次:0005(2016-05-20 18:58:10)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000058
#+ Filename...: axcq530_x01
#+ Description: ...
#+ Creator....: 06021(2015-03-17 16:25:11)
#+ Modifier...: 02294 -SD/PR- 02294
 
{</section>}
 
{<section id="axcq530_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#160520-00003#5   2016/05/20  By lixiang 效能优化
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
       wc STRING,                  #QBE 
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
 
{<section id="axcq530_x01.main" readonly="Y" >}
PUBLIC FUNCTION axcq530_x01(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  QBE 
DEFINE  p_arg2 STRING                  #tm.tmp  臨時表
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.tmp = p_arg2
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_range   #采用成本域否
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_spec  #采用特性否
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "axcq530_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL axcq530_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL axcq530_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL axcq530_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL axcq530_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL axcq530_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axcq530_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION axcq530_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "xccc004.xccc_t.xccc004,xccc005.xccc_t.xccc005,imag011.type_t.chr100,imag011_desc.type_t.chr100,xccc002.xccc_t.xccc002,xccc002_desc.type_t.chr100,xccc006.xccc_t.xccc006,xccc006_desc.type_t.chr100,xccc006_desc_1.type_t.chr100,xcbb005.type_t.chr100,xccc007.xccc_t.xccc007,xccc008.xccc_t.xccc008,inadsite.inad_t.inadsite,inadsite_desc.ooefl_t.ooefl003,inad010.inad_t.inad010,inad010_desc.pmaal_t.pmaal004,xccc101.xccc_t.xccc101,l_unit.type_t.num20_6,xccc102.xccc_t.xccc102,xccc201.xccc_t.xccc201,xccc202.xccc_t.xccc202,xccc203.xccc_t.xccc203,xccc204.xccc_t.xccc204,xccc205.xccc_t.xccc205,xccc206.xccc_t.xccc206,xccc207.xccc_t.xccc207,xccc208.xccc_t.xccc208,xccc209.xccc_t.xccc209,xccc210.xccc_t.xccc210,xccc211.xccc_t.xccc211,xccc212.xccc_t.xccc212,xccc213.xccc_t.xccc213,xccc214.xccc_t.xccc214,xccc215.xccc_t.xccc215,xccc216.xccc_t.xccc216,xccc217.xccc_t.xccc217,xccc218.xccc_t.xccc218,xccc301.xccc_t.xccc301,xccc302.xccc_t.xccc302,xccc303.xccc_t.xccc303,xccc304.xccc_t.xccc304,xccc305.xccc_t.xccc305,xccc306.xccc_t.xccc306,xccc307.xccc_t.xccc307,xccc308.xccc_t.xccc308,xccc309.xccc_t.xccc309,xccc310.xccc_t.xccc310,xccc311.xccc_t.xccc311,xccc312.xccc_t.xccc312,xccc313.xccc_t.xccc313,xccc314.xccc_t.xccc314,xccc901.xccc_t.xccc901,xccc902.xccc_t.xccc902,xccc903.xccc_t.xccc903,xccc903a.xccc_t.xccc903a,xccc903b.xccc_t.xccc903b,xccc903c.xccc_t.xccc903c,xccc903d.xccc_t.xccc903d,xccc903e.xccc_t.xccc903e,xccc903f.xccc_t.xccc903f,xccc903g.xccc_t.xccc903g,xccc903h.xccc_t.xccc903h,xccccomp.xccc_t.xccccomp,xccccomp_desc.type_t.chr100,xccc001.xccc_t.xccc001,xccc001_desc.type_t.chr100,xcccld.xccc_t.xcccld,xcccld_desc.type_t.chr100,xccc003.xccc_t.xccc003,xccc003_desc.type_t.chr100,xcccent.xccc_t.xcccent,xccckey.type_t.chr1000,l_xccc004_s.type_t.chr100,l_xccc004_e.type_t.chr100" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="axcq530_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION axcq530_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="axcq530_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axcq530_x01_sel_prep()
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
   LET g_select =" SELECT * "
#   #end add-point
#   LET g_select = " SELECT xccc004,xccc005,NULL,NULL,xccc002,NULL,xccc006,NULL,NULL,NULL,xccc007,xccc008, 
#       NULL,NULL,NULL,NULL,xccc101,NULL,xccc102,xccc201,xccc202,xccc203,xccc204,xccc205,xccc206,xccc207, 
#       xccc208,xccc209,xccc210,xccc211,xccc212,xccc213,xccc214,xccc215,xccc216,xccc217,xccc218,xccc301, 
#       xccc302,xccc303,xccc304,xccc305,xccc306,xccc307,xccc308,xccc309,xccc310,xccc311,xccc312,xccc313, 
#       xccc314,xccc901,xccc902,xccc903,xccc903a,xccc903b,xccc903c,xccc903d,xccc903e,xccc903f,xccc903g, 
#       xccc903h,xccccomp,NULL,xccc001,NULL,xcccld,NULL,xccc003,NULL,xcccent,NULL,'',''"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
    LET g_from =" FROM ",tm.tmp
#   #end add-point
#    LET g_from = " FROM xccc_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
 
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
   PREPARE axcq530_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE axcq530_x01_curs CURSOR FOR axcq530_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axcq530_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION axcq530_x01_ins_data()
DEFINE sr RECORD 
   xccc004 LIKE xccc_t.xccc004, 
   xccc005 LIKE xccc_t.xccc005, 
   imag011 LIKE type_t.chr100, 
   imag011_desc LIKE type_t.chr100, 
   xccc002 LIKE xccc_t.xccc002, 
   xccc002_desc LIKE type_t.chr100, 
   xccc006 LIKE xccc_t.xccc006, 
   xccc006_desc LIKE type_t.chr100, 
   xccc006_desc_1 LIKE type_t.chr100, 
   xcbb005 LIKE type_t.chr100, 
   xccc007 LIKE xccc_t.xccc007, 
   xccc008 LIKE xccc_t.xccc008, 
   inadsite LIKE inad_t.inadsite, 
   inadsite_desc LIKE ooefl_t.ooefl003, 
   inad010 LIKE inad_t.inad010, 
   inad010_desc LIKE pmaal_t.pmaal004, 
   xccc101 LIKE xccc_t.xccc101, 
   l_unit LIKE type_t.num20_6, 
   xccc102 LIKE xccc_t.xccc102, 
   xccc201 LIKE xccc_t.xccc201, 
   xccc202 LIKE xccc_t.xccc202, 
   xccc203 LIKE xccc_t.xccc203, 
   xccc204 LIKE xccc_t.xccc204, 
   xccc205 LIKE xccc_t.xccc205, 
   xccc206 LIKE xccc_t.xccc206, 
   xccc207 LIKE xccc_t.xccc207, 
   xccc208 LIKE xccc_t.xccc208, 
   xccc209 LIKE xccc_t.xccc209, 
   xccc210 LIKE xccc_t.xccc210, 
   xccc211 LIKE xccc_t.xccc211, 
   xccc212 LIKE xccc_t.xccc212, 
   xccc213 LIKE xccc_t.xccc213, 
   xccc214 LIKE xccc_t.xccc214, 
   xccc215 LIKE xccc_t.xccc215, 
   xccc216 LIKE xccc_t.xccc216, 
   xccc217 LIKE xccc_t.xccc217, 
   xccc218 LIKE xccc_t.xccc218, 
   xccc301 LIKE xccc_t.xccc301, 
   xccc302 LIKE xccc_t.xccc302, 
   xccc303 LIKE xccc_t.xccc303, 
   xccc304 LIKE xccc_t.xccc304, 
   xccc305 LIKE xccc_t.xccc305, 
   xccc306 LIKE xccc_t.xccc306, 
   xccc307 LIKE xccc_t.xccc307, 
   xccc308 LIKE xccc_t.xccc308, 
   xccc309 LIKE xccc_t.xccc309, 
   xccc310 LIKE xccc_t.xccc310, 
   xccc311 LIKE xccc_t.xccc311, 
   xccc312 LIKE xccc_t.xccc312, 
   xccc313 LIKE xccc_t.xccc313, 
   xccc314 LIKE xccc_t.xccc314, 
   xccc901 LIKE xccc_t.xccc901, 
   xccc902 LIKE xccc_t.xccc902, 
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
   xccccomp_desc LIKE type_t.chr100, 
   xccc001 LIKE xccc_t.xccc001, 
   xccc001_desc LIKE type_t.chr100, 
   xcccld LIKE xccc_t.xcccld, 
   xcccld_desc LIKE type_t.chr100, 
   xccc003 LIKE xccc_t.xccc003, 
   xccc003_desc LIKE type_t.chr100, 
   xcccent LIKE xccc_t.xcccent, 
   xccckey LIKE type_t.chr1000, 
   l_xccc004_s LIKE type_t.chr100, 
   l_xccc004_e LIKE type_t.chr100
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_glaa001        LIKE glaa_t.glaa001  #使用币别
DEFINE l_glaa016        LIKE glaa_t.glaa016  #本位幣二
DEFINE l_glaa020        LIKE glaa_t.glaa020  #本位幣三
DEFINE l_currency_desc  LIKE type_t.chr100
DEFINE  l_xcat005       LIKE xcat_t.xcat005    #wujie 150611
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH axcq530_x01_curs INTO sr.*                               
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
       IF NOT cl_null(sr.xccccomp_desc) THEN
         LET sr.xccccomp_desc = sr.xccccomp,"(",sr.xccccomp_desc CLIPPED,")"
       ELSE
         LET sr.xccccomp_desc = sr.xccccomp
       END IF
       
       IF NOT cl_null(sr.xcccld_desc) THEN
         LET sr.xcccld_desc = sr.xcccld,"(",sr.xcccld_desc CLIPPED,")"
       ELSE
         LET sr.xcccld_desc = sr.xcccld
       END IF
       
       IF NOT cl_null(sr.xccc003_desc) THEN
         LET sr.xccc003_desc = sr.xccc003,"(",sr.xccc003_desc CLIPPED,")"
       ELSE
         LET sr.xccc003_desc = sr.xccc003
       END IF

       
      #本位顺序说明
       #SELECT gzcbl004 INTO sr.xccc001_desc FROM gzcbl_t WHERE  gzcbl001='8914' AND gzcbl002=sr.xccc001 AND gzcbl003=g_dlang   #160520-00003#5
       LET sr.xccc001_desc=sr.xccc001,".",sr.xccc001_desc CLIPPED
       
       SELECT glaa001,glaa016,glaa020 INTO l_glaa001,l_glaa016,l_glaa020
         FROM glaa_t
         WHERE glaaent = g_enterprise
         AND glaald  = sr.xcccld
       CASE sr.xccc001
          WHEN '1'
             CALL s_desc_get_currency_desc(l_glaa001) RETURNING l_currency_desc
          WHEN '2'
             CALL s_desc_get_currency_desc(l_glaa016) RETURNING l_currency_desc
          WHEN '3'
             CALL s_desc_get_currency_desc(l_glaa020) RETURNING l_currency_desc
       END CASE
       IF NOT cl_null(l_currency_desc) THEN
          LET sr.xccc001_desc=sr.xccc001_desc,'(',l_currency_desc,')'
       END IF
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.xccc004,sr.xccc005,sr.imag011,sr.imag011_desc,sr.xccc002,sr.xccc002_desc,sr.xccc006,sr.xccc006_desc,sr.xccc006_desc_1,sr.xcbb005,sr.xccc007,sr.xccc008,sr.inadsite,sr.inadsite_desc,sr.inad010,sr.inad010_desc,sr.xccc101,sr.l_unit,sr.xccc102,sr.xccc201,sr.xccc202,sr.xccc203,sr.xccc204,sr.xccc205,sr.xccc206,sr.xccc207,sr.xccc208,sr.xccc209,sr.xccc210,sr.xccc211,sr.xccc212,sr.xccc213,sr.xccc214,sr.xccc215,sr.xccc216,sr.xccc217,sr.xccc218,sr.xccc301,sr.xccc302,sr.xccc303,sr.xccc304,sr.xccc305,sr.xccc306,sr.xccc307,sr.xccc308,sr.xccc309,sr.xccc310,sr.xccc311,sr.xccc312,sr.xccc313,sr.xccc314,sr.xccc901,sr.xccc902,sr.xccc903,sr.xccc903a,sr.xccc903b,sr.xccc903c,sr.xccc903d,sr.xccc903e,sr.xccc903f,sr.xccc903g,sr.xccc903h,sr.xccccomp,sr.xccccomp_desc,sr.xccc001,sr.xccc001_desc,sr.xcccld,sr.xcccld_desc,sr.xccc003,sr.xccc003_desc,sr.xcccent,sr.xccckey,sr.l_xccc004_s,sr.l_xccc004_e
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "axcq530_x01_execute"
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
#wujie 150611 --begin
    LET g_xgrid.visible_column = NULL
    LET l_xcat005 = NULL
    SELECT xcat005 INTO l_xcat005 
      FROM xcat_t
     WHERE xcatent = g_enterprise
       AND xcat001 = sr.xccc003
    IF l_xcat005 <> '3' THEN   #不是批次成本的，隐藏门店和供应商
       LET g_xgrid.visible_column = "inadsite|inadsite_desc|inad010|inad010_desc"
    END IF
#wujie 150611 --end
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axcq530_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION axcq530_x01_rep_data()
#add-point:rep_data.define (客製用) name="rep_data.define_customerization"

#end add-point:rep_data.define
#add-point:rep_data.define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="rep_data.define"

#end add-point:rep_data.define
 
    #add-point:rep_data.before name="rep_data.before"
    #动态隐藏 成本域 或 特性
    IF g_range = 'N' THEN
       LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED,"|xccc002|xccc002_desc"
    END IF
    IF g_spec ='N' THEN
       LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED,"|xccc007"
    END IF 
    #end add-point:rep_data.before
    
    CALL cl_xg_view()
    #add-point:rep_data.after name="rep_data.after"
    
    #end add-point:rep_data.after
END FUNCTION
 
{</section>}
 
{<section id="axcq530_x01.other_function" readonly="Y" >}

 
{</section>}
 
