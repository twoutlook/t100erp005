#該程式未解開Section, 採用最新樣板產出!
{<section id="axmr060_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2015-10-30 10:27:11), PR版次:0001(2015-10-30 11:53:06)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000038
#+ Filename...: axmr060_x01
#+ Description: ...
#+ Creator....: 07024(2015-10-27 17:18:20)
#+ Modifier...: 07024 -SD/PR- 07024
 
{</section>}
 
{<section id="axmr060_x01.global" readonly="Y" >}
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
       year STRING,                  #year 
       month STRING                   #month
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="axmr060_x01.main" readonly="Y" >}
PUBLIC FUNCTION axmr060_x01(p_arg1,p_arg2,p_arg3)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 STRING                  #tm.year  year 
DEFINE  p_arg3 STRING                  #tm.month  month
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.year = p_arg2
   LET tm.month = p_arg3
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "axmr060_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL axmr060_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL axmr060_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL axmr060_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL axmr060_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL axmr060_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axmr060_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION axmr060_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "xmdkdocno.xmdk_t.xmdkdocno,xmdkdocdt.xmdk_t.xmdkdocdt,l_xmdk007_pmaal004.type_t.chr1000,l_xmdk003_ooag011.type_t.chr1000,l_xmdk004_ooefl003.type_t.chr1000,l_xmdk012_oodbl004.type_t.chr1000,xmdk013.xmdk_t.xmdk013,xmdk014.xmdk_t.xmdk014,xmdlseq.xmdl_t.xmdlseq,xmdl008.xmdl_t.xmdl008,l_imaal003.imaal_t.imaal003,l_imaal004.imaal_t.imaal004,l_imaf111_oocql004.type_t.chr1000,l_imaa009_rtaxl003.type_t.chr1000,l_imaa127_oocql004.type_t.chr1000,l_imag011.imag_t.imag011,l_imag011_desc.oocql_t.oocql004,xmdl018.xmdl_t.xmdl018,xmdl017.xmdl_t.xmdl017,xmdl022.xmdl_t.xmdl022,xmdl021.xmdl_t.xmdl021,xmdl024.xmdl_t.xmdl024,xmdl027.xmdl_t.xmdl027,xmdl028.xmdl_t.xmdl028,xmdk017.xmdk_t.xmdk017,l_qty1.xmdl_t.xmdl027,l_qty2.xmdl_t.xmdl047,l_imag014.imag_t.imag014,l_qty3.xmdl_t.xmdl018,l_qty4.xcca_t.xcca110,l_qty5.type_t.num20_6,l_qty6.type_t.num20_6,l_qty7.type_t.num20_6" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="axmr060_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION axmr060_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="axmr060_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axmr060_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
DEFINE l_comp        LIKE xccc_t.xccccomp
DEFINE l_ld          LIKE xccc_t.xcccld
DEFINE l_year        LIKE xccc_t.xccc004
DEFINE l_period      LIKE xccc_t.xccc005
DEFINE l_calc_type   LIKE xccc_t.xccc003
DEFINE l_sql         STRING
DEFINE l_sql1        STRING
DEFINE l_success     LIKE type_t.num5
DEFINE l_ooef019     LIKE ooef_t.ooef019 #稅區
#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   #取得稅區
   CALL s_tax_get_ooef019(g_site) RETURNING l_success,l_ooef019
   #依據點抓法人、帳套、年度、期別、成本
   CALL s_axc_set_site_default() RETURNING l_comp,l_ld,l_year,l_period,l_calc_type
   #axct300,抓xcca110         
   LET l_sql = " LEFT OUTER JOIN xcca_t ON xccaent=xmdlent AND xcca006=xmdl008 AND xccacomp='",l_comp,"'",
               " AND xccald='",l_ld,"' AND xcca003='",l_calc_type,"' AND xcca001='1'"
   #axcq500,抓xccc280
   LET l_sql1 = " LEFT OUTER JOIN xccc_t ON xcccent=xmdlent AND xccc006=xmdl008 AND xccc003='",l_calc_type,"'",
                " AND xccccomp='",l_comp,"' AND xcccld='",l_ld,"' AND xccc001='1'"
   #若條件有輸入年，則將年加入條件
   IF NOT cl_null(tm.year) THEN
      LET l_sql = l_sql CLIPPED," AND xcca004=",tm.year
      LET l_sql1 = l_sql1 CLIPPED," AND xccc004=",tm.year
   END IF
   #若條件有輸入月，則將月加入條件
   IF NOT cl_null(tm.month) THEN
      LET l_sql = l_sql CLIPPED," AND xcca005=",tm.month
      LET l_sql1 = l_sql1 CLIPPED," AND xccc005=",tm.month
   END IF
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
   LET g_select = " SELECT xmdkdocno,xmdkdocdt,",
                  " CASE WHEN pmaal_t.pmaal004 IS NULL THEN xmdk007 ELSE trim(xmdk007)||'.'||trim(pmaal_t.pmaal004) END,",
                  " CASE WHEN ooag_t.ooag011 IS NULL THEN xmdk003 ELSE trim(xmdk003)||'.'||trim(ooag_t.ooag011) END,",
                  " CASE WHEN ooefl_t.ooefl003 IS NULL THEN xmdk004 ELSE trim(xmdk004)||'.'||trim(ooefl_t.ooefl003) END,",
                  " CASE WHEN oodbl_t.oodbl004 IS NULL THEN xmdk012 ELSE trim(xmdk012)||'.'||trim(oodbl_t.oodbl004) END ,",
                  " xmdk013/100,xmdk014,xmdlseq,xmdl008,imaal003,imaal004,",
                  " CASE WHEN A1.oocql004 IS NULL THEN imaf111 ELSE trim(imaf111)||'.'||trim(A1.oocql004) END,",
                  " CASE WHEN rtaxl_t.rtaxl003 IS NULL THEN imaa009 ELSE trim(imaa009)||'.'||trim(rtaxl_t.rtaxl003) END,",
                  " CASE WHEN oocql_t.oocql004 IS NULL THEN imaa127 ELSE trim(imaa127)||'.'||trim(oocql_t.oocql004) END,",
                  " imag011,A2.oocql004,xmdl018,xmdl017,xmdl022,xmdl021,xmdl024,xmdl027,xmdl028,xmdk017,",
                  " 0,0,imag014,0,xcca110,COALESCE(xccc280,0),0,0,0,0"
  
   
#   #end add-point
#   LET g_select = " SELECT xmdkdocno,xmdkdocdt,NULL,NULL,NULL,NULL,xmdk013,xmdk014,xmdlseq,xmdl008,NULL, 
#       NULL,NULL,NULL,NULL,NULL,NULL,xmdl018,xmdl017,xmdl022,xmdl021,xmdl024,xmdl027,xmdl028,xmdk017, 
#       0,0,NULL,0,0,0,0,0,0"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_from = " FROM xmdk_t",
                " LEFT OUTER JOIN xmdl_t ON xmdlent=xmdkent AND xmdldocno=xmdkdocno ",
                " LEFT OUTER JOIN imaa_t ON imaaent=xmdlent AND imaa001=xmdl008 ",
                " LEFT OUTER JOIN imaal_t ON imaalent=xmdlent AND imaal001=xmdl008 AND imaal002='"||g_dlang||"'",
                " LEFT OUTER JOIN imaf_t ON imafent=xmdlent AND imafsite=xmdlsite AND imaf001=xmdl008",
                " LEFT OUTER JOIN imag_t ON imagent=xmdlent AND imagsite=xmdlsite AND imag001=xmdl008",
                " LEFT OUTER JOIN rtaxl_t ON rtaxlent=imaaent AND rtaxl001=imaa009 AND rtaxl002='",g_dlang,"'",
                " LEFT OUTER JOIN pmaal_t ON pmaalent=xmdkent AND pmaal001=xmdk007 AND pmaal002='",g_dlang,"'",
                " LEFT OUTER JOIN ooag_t ON ooagent=xmdkent AND ooag001=xmdk003 ",
                " LEFT OUTER JOIN ooefl_t ON ooeflent=xmdkent AND ooefl001=xmdk004 AND ooefl002='",g_dlang,"'",
                " LEFT OUTER JOIN oodbl_t ON oodblent=xmdkent AND oodbl001='",l_ooef019,"' AND oodbl002=xmdk012 AND oodbl003='",g_dlang,"'",
                #ACC
                " LEFT OUTER JOIN oocql_t ON oocqlent=imaaent AND oocql001='2003' AND oocql002=imaa127 AND oocql003='",g_dlang,"'",
                " LEFT OUTER JOIN oocql_t A1 ON A1.oocqlent=imafent AND A1.oocql001='202' AND A1.oocql002=imaf111 AND A1.oocql003='",g_dlang,"'",
                " LEFT OUTER JOIN oocql_t A2 ON A2.oocqlent=imagent AND A2.oocql001='206' AND A2.oocql002=imag011 AND A2.oocql003='",g_dlang,"'",
                l_sql,l_sql1


#   #end add-point
#    LET g_from = " FROM xmdk_t,xmdl_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("xmdk_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = g_sql CLIPPED," ORDER BY xmdkdocno,xmdlseq,xmdl008"
   #end add-point
   PREPARE axmr060_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE axmr060_x01_curs CURSOR FOR axmr060_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axmr060_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION axmr060_x01_ins_data()
DEFINE sr RECORD 
   xmdkdocno LIKE xmdk_t.xmdkdocno, 
   xmdkdocdt LIKE xmdk_t.xmdkdocdt, 
   l_xmdk007_pmaal004 LIKE type_t.chr1000, 
   l_xmdk003_ooag011 LIKE type_t.chr1000, 
   l_xmdk004_ooefl003 LIKE type_t.chr1000, 
   l_xmdk012_oodbl004 LIKE type_t.chr1000, 
   xmdk013 LIKE xmdk_t.xmdk013, 
   xmdk014 LIKE xmdk_t.xmdk014, 
   xmdlseq LIKE xmdl_t.xmdlseq, 
   xmdl008 LIKE xmdl_t.xmdl008, 
   l_imaal003 LIKE imaal_t.imaal003, 
   l_imaal004 LIKE imaal_t.imaal004, 
   l_imaf111_oocql004 LIKE type_t.chr1000, 
   l_imaa009_rtaxl003 LIKE type_t.chr1000, 
   l_imaa127_oocql004 LIKE type_t.chr1000, 
   l_imag011 LIKE imag_t.imag011, 
   l_imag011_desc LIKE oocql_t.oocql004, 
   xmdl018 LIKE xmdl_t.xmdl018, 
   xmdl017 LIKE xmdl_t.xmdl017, 
   xmdl022 LIKE xmdl_t.xmdl022, 
   xmdl021 LIKE xmdl_t.xmdl021, 
   xmdl024 LIKE xmdl_t.xmdl024, 
   xmdl027 LIKE xmdl_t.xmdl027, 
   xmdl028 LIKE xmdl_t.xmdl028, 
   xmdk017 LIKE xmdk_t.xmdk017, 
   l_qty1 LIKE xmdl_t.xmdl027, 
   l_qty2 LIKE xmdl_t.xmdl047, 
   l_imag014 LIKE imag_t.imag014, 
   l_qty3 LIKE xmdl_t.xmdl018, 
   l_qty4 LIKE xcca_t.xcca110, 
   l_xccc280 LIKE xccc_t.xccc280, 
   l_qty5 LIKE type_t.num20_6, 
   l_qty6 LIKE type_t.num20_6, 
   l_qty7 LIKE type_t.num20_6
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
   DEFINE l_success LIKE type_t.num5
   DEFINE l_tax_calc LIKE type_t.num20_6

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH axmr060_x01_curs INTO sr.*                               
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
       #成本單位數量
       IF NOT cl_null(sr.xmdl017) AND NOT cl_null(sr.xmdl021) THEN
          CALL s_aooi250_convert_qty(sr.xmdl008,sr.xmdl017,sr.xmdl021,sr.xmdl018) 
               RETURNING l_success,sr.l_qty3
       END IF
       IF cl_null(sr.l_qty3) OR sr.l_qty3=0 THEN
          LET sr.l_qty3 = 1
       END IF
       #本幣未稅單價
       IF sr.xmdk014='Y' THEN
          LET sr.l_qty1 = sr.xmdl024/(1+sr.xmdk013)*sr.xmdk017
       ELSE
          LET sr.l_qty1 = sr.xmdl024*sr.xmdk017
       END IF
       #本幣未稅金額
       LET sr.l_qty2 = sr.l_qty1*sr.xmdl022
       #本幣成本單價
          #若開帳單價(xcca110)沒有值或0，再抓本期成本單價(xccc280)
       IF cl_null(sr.l_qty4) OR sr.l_qty4=0 THEN
          LET sr.l_qty4 = sr.l_xccc280
       END IF
       
       #本幣預估成本
       LET sr.l_qty5 = sr.l_qty4*sr.xmdl022
       #本幣預估毛利
       LET sr.l_qty6 = sr.l_qty2 - sr.l_qty5
       #預估毛利率
       LET sr.l_qty7 = sr.l_qty6 / sr.l_qty2
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.xmdkdocno,sr.xmdkdocdt,sr.l_xmdk007_pmaal004,sr.l_xmdk003_ooag011,sr.l_xmdk004_ooefl003,sr.l_xmdk012_oodbl004,sr.xmdk013,sr.xmdk014,sr.xmdlseq,sr.xmdl008,sr.l_imaal003,sr.l_imaal004,sr.l_imaf111_oocql004,sr.l_imaa009_rtaxl003,sr.l_imaa127_oocql004,sr.l_imag011,sr.l_imag011_desc,sr.xmdl018,sr.xmdl017,sr.xmdl022,sr.xmdl021,sr.xmdl024,sr.xmdl027,sr.xmdl028,sr.xmdk017,sr.l_qty1,sr.l_qty2,sr.l_imag014,sr.l_qty3,sr.l_qty4,sr.l_qty5,sr.l_qty6,sr.l_qty7
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "axmr060_x01_execute"
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
 
{<section id="axmr060_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION axmr060_x01_rep_data()
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
 
{<section id="axmr060_x01.other_function" readonly="Y" >}

 
{</section>}
 
