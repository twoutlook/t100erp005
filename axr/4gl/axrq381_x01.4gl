#該程式未解開Section, 採用最新樣板產出!
{<section id="axrq381_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2016-12-22 14:35:45), PR版次:0001(2016-12-22 14:39:24)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: axrq381_x01
#+ Description: ...
#+ Creator....: 03080(2016-12-22 13:53:19)
#+ Modifier...: 03080 -SD/PR- 03080
 
{</section>}
 
{<section id="axrq381_x01.global" readonly="Y" >}
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
       wc STRING,                  #wc 
       site STRING,                  #site 
       ld STRING,                  #ld 
       date LIKE type_t.dat,         #date 
       a LIKE type_t.chr1          #a
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="axrq381_x01.main" readonly="Y" >}
PUBLIC FUNCTION axrq381_x01(p_arg1,p_arg2,p_arg3,p_arg4,p_arg5)
DEFINE  p_arg1 STRING                  #tm.wc  wc 
DEFINE  p_arg2 STRING                  #tm.site  site 
DEFINE  p_arg3 STRING                  #tm.ld  ld 
DEFINE  p_arg4 LIKE type_t.dat         #tm.date  date 
DEFINE  p_arg5 LIKE type_t.chr1         #tm.a  a
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.site = p_arg2
   LET tm.ld = p_arg3
   LET tm.date = p_arg4
   LET tm.a = p_arg5
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "axrq381_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL axrq381_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL axrq381_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL axrq381_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL axrq381_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL axrq381_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axrq381_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION axrq381_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "l_docno.type_t.chr500,l_xrcasite.type_t.chr500,l_xrcald.type_t.chr500,l_edata.type_t.dat,xrca001.xrca_t.xrca001,xrcadocno.xrca_t.xrcadocno,xrcadocdt.xrca_t.xrcadocdt,xrca007.xrca_t.xrca007,l_xrca007_desc.type_t.chr500,xrca004.xrca_t.xrca004,l_xrca004_desc.type_t.chr500,xrca005.xrca_t.xrca005,l_xrca005_desc.type_t.chr500,xrca014.xrca_t.xrca014,l_xrca014_desc.type_t.chr500,xrca009.xrca_t.xrca009,xrca010.xrca_t.xrca010,xrca100.xrca_t.xrca100,xrca101.xrca_t.xrca101,l_xrcc108_109.type_t.num20_6,l_xrca103_104.type_t.num20_6,l_xrcc118_119_113.type_t.num20_6,xrca118.xrca_t.xrca118,xrca103.xrca_t.xrca103,xrca104.xrca_t.xrca104,xrca113.xrca_t.xrca113,xrca114.xrca_t.xrca114" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   LET g_sql ="l_docno1.type_t.chr500,",
              " xrcedocno.type_t.chr500, ",
              " l_docdt.type_t.dat, ",
              " xrce002.type_t.chr500, ",
              " xrce109.type_t.num20_6, ",
              " xrce119.type_t.num20_6 "
   IF NOT cl_xg_create_tmptable(g_sql,2) THEN
      LET g_rep_success = 'N'
   END IF 
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="axrq381_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION axrq381_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
         WHEN 2
            LET g_sql = " INSERT INTO ",g_rep_db CLIPPED,g_rep_tmpname[2] CLIPPED,
                        " VALUES(?,?,?,?,?,?)"
            PREPARE insert_prep1 FROM g_sql
            IF STATUS THEN
               LET l_prep_str = "insert_prep1",i
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = l_prep_str
               LET g_errparam.code   = STATUS
               LET g_errparam.popup  = TRUE
               CALL cl_err()
            
               CALL cl_xg_drop_tmptable()
               LET g_rep_success = 'N'
            END IF
         #end add-point                  
 
 
      END CASE
   END FOR
END FUNCTION
 
{</section>}
 
{<section id="axrq381_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axrq381_x01_sel_prep()
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
    LET g_select = " SELECT UNIQUE '','','','',xrca001,xrcadocno,xrcadocdt,",
                   "               xrca007,(SELECT oocql004 FROM oocql_t WHERE oocqlent = '",g_enterprise,"' AND oocql001 = '3111' AND oocql002 = xrca007 AND oocql003 = '",g_dlang,"'),",
                   "               xrca004,(SELECT pmaal004 FROM pmaal_t WHERE pmaalent='",g_enterprise,"' AND pmaal001=xrca004 AND pmaal002='",g_dlang,"'),",
                   "               xrca005,(SELECT pmaal004 FROM pmaal_t WHERE pmaalent='",g_enterprise,"' AND pmaal001=xrca004 AND pmaal002='",g_dlang,"'),",
                   "               xrca014,(SELECT ooag010 FROM ooag_t WHERE ooagent='",g_enterprise,"' AND ooag001=xrca014),",
                   "               xrca009,xrca010,xrca100,xrca101, ",
                   "   CASE WHEN (xrca001 ='02' OR xrca001 = '04' OR xrca001 LIKE '2%') THEN AVG(xrca103+xrca104) * -1 ELSE AVG(xrca103+xrca104) END, ",
                   "   CASE WHEN (xrca001 ='02' OR xrca001 = '04' OR xrca001 LIKE '2%') THEN SUM(xrcc108-xrcc109) * -1 ELSE SUM(xrcc108-xrcc109) END, ",
                   "   CASE WHEN (xrca001 ='02' OR xrca001 = '04' OR xrca001 LIKE '2%') THEN SUM(xrcc118-xrcc119+xrcc113) * -1 ELSE SUM(xrcc118-xrcc119+xrcc113) END, ",
                   "   CASE WHEN (xrca001 ='02' OR xrca001 = '04' OR xrca001 LIKE '2%') THEN AVG(xrca113+xrca114) * -1 ELSE AVG(xrca113+xrca114) END, ",
                   "   CASE WHEN (xrca001 ='02' OR xrca001 = '04' OR xrca001 LIKE '2%') THEN AVG(xrca103) * -1 ELSE AVG(xrca103) END, ",
                   "   CASE WHEN (xrca001 ='02' OR xrca001 = '04' OR xrca001 LIKE '2%') THEN AVG(xrca104) * -1 ELSE AVG(xrca104) END, ",
                   "   CASE WHEN (xrca001 ='02' OR xrca001 = '04' OR xrca001 LIKE '2%') THEN AVG(xrca113) * -1 ELSE AVG(xrca113) END, ",
                   "   CASE WHEN (xrca001 ='02' OR xrca001 = '04' OR xrca001 LIKE '2%') THEN AVG(xrca114) * -1 ELSE AVG(xrca114) END "
#   #end add-point
#   LET g_select = " SELECT NULL,NULL,NULL,NULL,xrca001,xrcadocno,xrcadocdt,xrca007,NULL,xrca004,NULL, 
#       xrca005,NULL,xrca014,NULL,xrca009,xrca010,xrca100,xrca101,0,0,0,xrca118,xrca103,xrca104,xrca113, 
#       xrca114"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_from = "   FROM xrca_t,xrcc_t" 
#   #end add-point
#    LET g_from = " FROM xrca_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_where = 
               "   WHERE xrcaent=xrccent AND xrcald=xrccld AND xrcadocno=xrccdocno ",
               "     AND xrcaent=",g_enterprise," AND xrcald='",tm.ld,"'",
               "     AND xrcasite = '",tm.site,"'",
               "     AND xrcastus = 'Y' ",
               "     AND xrca001 LIKE ('2%')",
               "     AND ",tm.wc           
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("xrca_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_where = g_where CLIPPED,
               "   GROUP BY xrca001,xrcadocno,xrcadocdt,xrca007,'',xrca004,'',xrca005,'',xrca014,'',xrca009,xrca010,xrca100,xrca101",
               "   ORDER BY xrca001,xrcadocno,xrcadocdt,xrca007,xrca004,xrca005,xrca014,xrca009,xrca010,xrca100,xrca101"
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段            
   #end add-point
   PREPARE axrq381_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE axrq381_x01_curs CURSOR FOR axrq381_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axrq381_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION axrq381_x01_ins_data()
DEFINE sr RECORD 
   l_docno LIKE type_t.chr500, 
   l_xrcasite LIKE type_t.chr500, 
   l_xrcald LIKE type_t.chr500, 
   l_edata LIKE type_t.dat, 
   xrca001 LIKE xrca_t.xrca001, 
   xrcadocno LIKE xrca_t.xrcadocno, 
   xrcadocdt LIKE xrca_t.xrcadocdt, 
   xrca007 LIKE xrca_t.xrca007, 
   l_xrca007_desc LIKE type_t.chr500, 
   xrca004 LIKE xrca_t.xrca004, 
   l_xrca004_desc LIKE type_t.chr500, 
   xrca005 LIKE xrca_t.xrca005, 
   l_xrca005_desc LIKE type_t.chr500, 
   xrca014 LIKE xrca_t.xrca014, 
   l_xrca014_desc LIKE type_t.chr500, 
   xrca009 LIKE xrca_t.xrca009, 
   xrca010 LIKE xrca_t.xrca010, 
   xrca100 LIKE xrca_t.xrca100, 
   xrca101 LIKE xrca_t.xrca101, 
   l_xrcc108_109 LIKE type_t.num20_6, 
   l_xrca103_104 LIKE type_t.num20_6, 
   l_xrcc118_119_113 LIKE type_t.num20_6, 
   xrca118 LIKE xrca_t.xrca118, 
   xrca103 LIKE xrca_t.xrca103, 
   xrca104 LIKE xrca_t.xrca104, 
   xrca113 LIKE xrca_t.xrca113, 
   xrca114 LIKE xrca_t.xrca114
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE sr1 RECORD
   l_docno1      LIKE type_t.chr500,     #与主报表关联栏位组合
   xrcedocno     LIKE xrce_t.xrcedocno,
   l_docdt       LIKE xrca_t.xrcadocdt,
   xrce002       LIKE xrce_t.xrce002,
   xrce109       LIKE xrce_t.xrce109,
   xrce119       LIKE xrce_t.xrce119 
END RECORD
DEFINE l_sql     STRING
DEFINE l_docno   LIKE type_t.chr500
DEFINE l_xrce109 LIKE xrce_t.xrce109
DEFINE l_xrce119 LIKE xrce_t.xrce119

    LET l_sql = " SELECT '',xrcedocno,xrcadocdt,'1',SUM(xrce109),SUM(xrce119) ",
                "   FROM xrca_t,xrce_t ",
                "  WHERE xrcaent=xrceent AND xrcald=xrceld AND xrcadocno=xrcedocno ",
                "    AND xrcaent=",g_enterprise," AND xrcald='",tm.ld,"' ",
                "    AND xrcasite= '",tm.site,"'",
                "    AND xrce003=? AND xrcastus='Y' ",
                "  GROUP BY '',xrcedocno ,xrcadocdt",
                " UNION ",
                " SELECT '',xrcfdocno,xrcadocdt,'3',SUM(xrcf105),SUM(xrcf115)  ",
                "   FROM xrca_t,xrcb_t,xrcf_t ",
                "  WHERE xrcaent=xrcbent AND xrcald=xrcbld AND xrcadocno=xrcbdocno ",
                "    AND xrcbent=xrcfent AND xrcbld=xrcfld AND xrcbdocno=xrcfdocno AND xrcbseq=xrcfseq ",
                "    AND xrcaent=",g_enterprise," AND xrcald='",tm.ld,"' ",
                "    AND xrcasite= '",tm.site,"'",
                "    AND xrcf008=? AND xrcastus='Y' ",
                "    AND xrcadocdt <= '",tm.date,"'",
                "  GROUP BY '',xrcfdocno,xrcadocdt ",
                " UNION ",
                " SELECT '',xrdadocno,xrdadocdt,'2',SUM(xrce109),SUM(xrce119) ",
                "   FROM xrda_t,xrce_t ",
                "  WHERE xrdaent=xrceent AND xrdald=xrceld AND xrdadocno=xrcedocno ",
                "    AND xrdaent=",g_enterprise," AND xrdald='",tm.ld,"' ",
                "    AND xrdasite= '",tm.site,"'",
                "    AND xrce003=? AND xrdastus='Y' ",
                "    AND xrdadocdt <= '",tm.date,"'",             
                "  GROUP BY '',xrdadocno,xrdadocdt ", 
                " UNION ",             
                " SELECT '',apdadocno,apdadocdt,'4',SUM(apce109),SUM(apce119) ",
                "   FROM apda_t,apce_t ",
                "  WHERE apdaent=apceent AND apdald=apceld AND apdadocno=apcedocno ",
                "    AND apdaent=",g_enterprise," AND apdald='",tm.ld,"' ",
                "    AND apdasite= '",tm.site,"'",
                "    AND apdadocdt <= '",tm.date,"'",
                "    AND apce003=? AND apdastus='Y' ",
                "    AND apda001 <> '43' ",
                "  GROUP BY '',apdadocno ,apdadocdt",
                " UNION ",             
                " SELECT '',xrdedocno,xrde032,'5',SUM(xrde109),SUM(xrde119) ",
                "   FROM xrde_t,xrca_t ",
                "  WHERE xrdeent=xrcaent AND xrdeld=xrcald AND xrdedocno=xrcadocno ",
                "    AND xrdeent=",g_enterprise," AND xrdeld='",tm.ld,"' ",
                "    AND xrdesite= '",tm.site,"'",
                "    AND xrde032 <= '",tm.date,"'",
                "    AND xrdedocno=? ",
                "    AND xrcastus='Y' ",
                "  GROUP BY '',xrdedocno,xrde032 "                
    PREPARE axrq381_x01_subprep FROM l_sql
    DECLARE axrq381_x01_subcurs CURSOR FOR axrq381_x01_subprep
    
    LET g_sql=" SELECT SUM(xrce109),SUM(xrce119) ",
              "   FROM xrda_t,xrce_t ",
              "  WHERE xrdaent=xrceent AND xrdald=xrceld AND xrdadocno=xrcedocno ",
              "    AND xrdaent=",g_enterprise," AND xrdald='",tm.ld,"' ",
              "    AND xrdasite= '",tm.site,"'",
              "    AND xrce003= ? AND xrdastus='Y' ",
              "    AND xrdadocdt > '",tm.date,"'"  
    PREPARE axrq381_x01_prep_1 FROM g_sql            
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH axrq381_x01_curs INTO sr.*                               
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
       #预收axrt310 xrcc108-xrcc109=0则不显示预收单，且待底单(21,23)负数显示
       IF sr.xrca001 = '11' OR sr.xrca001 = '13' OR sr.xrca001 = '16' THEN
          IF sr.l_xrcc108_109 = 0 THEN
             CONTINUE FOREACH
          END IF 
       END IF     

      EXECUTE axrq381_x01_prep_1 INTO l_xrce109,l_xrce119 USING sr.xrcadocno
      IF cl_null(l_xrce109) OR l_xrce109 IS NULL THEN LET l_xrce109 = 0 END IF
      IF cl_null(l_xrce119) OR l_xrce119 IS NULL THEN LET l_xrce119 = 0 END IF
      LET sr.l_xrcc108_109 = sr.l_xrcc108_109 + l_xrce109
      LET sr.l_xrcc108_109 = sr.l_xrcc108_109 + l_xrce119
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       LET sr.l_xrcasite = tm.site
       LET sr.l_xrcald = tm.ld
       LET sr.l_edata = tm.date
       LET sr.l_docno = sr.xrcadocno,",",sr.xrcadocno,",",sr.xrcadocno,",",sr.xrcadocno #用于跟子报表关联
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.l_docno,sr.l_xrcasite,sr.l_xrcald,sr.l_edata,sr.xrca001,sr.xrcadocno,sr.xrcadocdt,sr.xrca007,sr.l_xrca007_desc,sr.xrca004,sr.l_xrca004_desc,sr.xrca005,sr.l_xrca005_desc,sr.xrca014,sr.l_xrca014_desc,sr.xrca009,sr.xrca010,sr.xrca100,sr.xrca101,sr.l_xrcc108_109,sr.l_xrca103_104,sr.l_xrcc118_119_113,sr.xrca118,sr.xrca103,sr.xrca104,sr.xrca113,sr.xrca114
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "axrq381_x01_execute"
          LET g_errparam.code   = SQLCA.sqlcode
          LET g_errparam.popup  = FALSE
          CALL cl_err()       
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
 
       #add-point:ins_data段after_save name="ins_data.after.save"

       LET l_docno = ''
       OPEN axrq381_x01_subcurs USING sr.xrcadocno,sr.xrcadocno,sr.xrcadocno,sr.xrcadocno,sr.xrcadocno
       FOREACH axrq381_x01_subcurs INTO sr1.*
          LET sr1.l_docno1 = sr.xrcadocno,",",sr.xrcadocno,",",sr.xrcadocno,",",sr.xrcadocno        
          EXECUTE insert_prep1 USING sr1.l_docno1,sr1.xrcedocno,sr1.l_docdt,sr1.xrce002,
                                     sr1.xrce109,sr1.xrce119
                        
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = "axrq381_x01_subcurs"
             LET g_errparam.code   = SQLCA.sqlcode 
             LET g_errparam.popup  = FALSE
             CALL cl_err()        
             LET g_rep_success = 'N'
             EXIT FOREACH
          END IF
       END FOREACH
       CLOSE axrq381_x01_subcurs
       #end add-point
       
    END FOREACH
    
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrq381_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION axrq381_x01_rep_data()
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
 
{<section id="axrq381_x01.other_function" readonly="Y" >}

 
{</section>}
 
