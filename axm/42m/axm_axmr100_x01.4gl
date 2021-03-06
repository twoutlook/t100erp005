#該程式未解開Section, 採用最新樣板產出!
{<section id="axmr100_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:4(2017-02-16 10:50:56), PR版次:0004(2017-02-21 18:41:01)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000029
#+ Filename...: axmr100_x01
#+ Description: ...
#+ Creator....: 07024(2016-05-06 17:46:46)
#+ Modifier...: 08993 -SD/PR- 08993
 
{</section>}
 
{<section id="axmr100_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#160517-00015#1  2016/05/17   By  dorislai  當"排除多角內部交易單據"為"Y"時，排除多角性質="中間交易"的單據
#161006-00004#1  2016/10/06   By  dorislai  將xmdkdocdt換成xmdk001
#170123-00051#1  2017/02/16   By 08993      新增料號、品名、規格欄位
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
       curr LIKE type_t.chr1,         #curr 
       chk1 LIKE type_t.chr1,         #chk1 
       chk2 LIKE type_t.chr1,         #chk2 
       chk3 LIKE type_t.chr1          #chk3
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="axmr100_x01.main" readonly="Y" >}
PUBLIC FUNCTION axmr100_x01(p_arg1,p_arg2,p_arg3,p_arg4,p_arg5)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr1         #tm.curr  curr 
DEFINE  p_arg3 LIKE type_t.chr1         #tm.chk1  chk1 
DEFINE  p_arg4 LIKE type_t.chr1         #tm.chk2  chk2 
DEFINE  p_arg5 LIKE type_t.chr1         #tm.chk3  chk3
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.curr = p_arg2
   LET tm.chk1 = p_arg3
   LET tm.chk2 = p_arg4
   LET tm.chk3 = p_arg5
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "axmr100_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL axmr100_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL axmr100_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL axmr100_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL axmr100_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL axmr100_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axmr100_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION axmr100_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "xmdasite.xmda_t.xmdasite,l_xmdasite_desc.ooefl_t.ooefl003,xmda002.xmda_t.xmda002,ooag_t_ooag011.ooag_t.ooag011,xmda003.xmda_t.xmda003,ooefl_t_ooefl003.ooefl_t.ooefl003,xmda004.xmda_t.xmda004,pmaal_t_pmaal004.pmaal_t.pmaal004,imaa_t_imaa009.imaa_t.imaa009,l_imaa009_desc.oocql_t.oocql004,xmda024.xmda_t.xmda024,l_xmda024_desc.oocql_t.oocql004,imaa_t_imaa127.imaa_t.imaa127,l_year.type_t.num5,l_month.type_t.num5,xmda015.xmda_t.xmda015,xmdc_t_xmdc007.xmdc_t.xmdc007,l_xmdc007_ratio.type_t.num20_6,xmdc_t_xmdc046.xmdc_t.xmdc046,l_xmdc046_ratio.type_t.num20_6,xmdl_t_xmdl018.xmdl_t.xmdl018,l_xmdl018_ratio.type_t.num20_6,xmdl_t_xmdl027.xmdl_t.xmdl027,l_xmdl027_ratio.type_t.num20_6,l_xmdl018_1.xmdl_t.xmdl018,l_xmdl018_1_ratio.type_t.num20_6,l_xmdl027_1.xmdl_t.xmdl027,l_xmdl027_1_ratio.type_t.num20_6,l_cqty.type_t.num20_6,l_cqty_ratio.type_t.num20_6,l_cnum.type_t.num20_6,l_cnum_ratio.type_t.num20_6,xmdc_t_xmdc001.xmdc_t.xmdc001,l_imaal003_desc.imaal_t.imaal003,l_imaal004_desc.imaal_t.imaal004" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="axmr100_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION axmr100_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="axmr100_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axmr100_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
DEFINE l_sql         STRING
DEFINE l_sql1        STRING
DEFINE l_sql2        STRING
#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
   #訂單
   #170123-00051#1-s mark
#   LET l_sql = " SELECT xmdasite a1,
#                        (SELECT ooefl003 FROM ooefl_t WHERE ooeflent=xmdaent AND ooefl001=xmdasite AND ooefl002='",g_dlang,"') a2,                
#                        xmda002  a3,
#                        (SELECT ooag011 FROM ooag_t WHERE ooagent=xmdaent AND ooag001=xmda002) a4,
#                        xmda003  a5,
#                        (SELECT ooefl003 FROM ooefl_t WHERE ooeflent=xmdaent AND ooefl001=xmda003 AND ooefl002='",g_dlang,"') a6,
#                        xmda004  a7,
#                        (SELECT pmaal004 FROM pmaal_t WHERE pmaalent=xmdaent AND pmaal001=xmda004 AND pmaal002='",g_dlang,"') a8,
#                        imaa009  a9,
#                        (SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent=imaaent AND rtaxl001=imaa009 AND rtaxl002='",g_dlang,"') a10,
#                        xmda024  a11,
#                        (SELECT oocql004 FROM oocql_t WHERE oocqlent=xmdaent AND oocql001='295' AND oocql002=xmda024 AND oocql003='",g_dlang,"') a12,
#                        imaa127 a13,to_char(xmdadocdt,'yyyy') a14,to_char(xmdadocdt,'mm') a15,
#                        (CASE '",tm.curr,"' WHEN '0' THEN xmda015 ELSE ooef016 END) a16,
#                        NVL(xmdc007,0) a17,0 a18,
#                        (CASE '",tm.curr,"' WHEN '0' THEN NVL(xmdc046,0) ELSE NVL(xmdc046*xmda016,0) END) a19,0 a20,0 a21,0 a22,0 a23,0 a24,
#                        0 a25,0 a26,0 a27,0 a28,0 a29,0 a30,0 a31,0 a32,
#                        (SELECT imaf112 FROM imaf_t WHERE xmdcent=imafent AND xmdcsite=imafsite AND xmdc001=imaf001 ) a33,
#                        xmdc001 a34,xmdc006 a35,NULL a36,NULL a37,NULL a38,NULL a39
#                   FROM xmda_t ",
   #170123-00051#1-e mark
   #170123-00051#1-s mod
   LET l_sql = " SELECT xmdasite a1,
                        (SELECT ooefl003 FROM ooefl_t WHERE ooeflent=xmdaent AND ooefl001=xmdasite AND ooefl002='",g_dlang,"') a2,                
                        xmda002  a3,
                        (SELECT ooag011 FROM ooag_t WHERE ooagent=xmdaent AND ooag001=xmda002) a4,
                        xmda003  a5,
                        (SELECT ooefl003 FROM ooefl_t WHERE ooeflent=xmdaent AND ooefl001=xmda003 AND ooefl002='",g_dlang,"') a6,
                        xmda004  a7,
                        (SELECT pmaal004 FROM pmaal_t WHERE pmaalent=xmdaent AND pmaal001=xmda004 AND pmaal002='",g_dlang,"') a8,
                        imaa009  a9,
                        (SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent=imaaent AND rtaxl001=imaa009 AND rtaxl002='",g_dlang,"') a10,
                        xmda024  a11,
                        (SELECT oocql004 FROM oocql_t WHERE oocqlent=xmdaent AND oocql001='295' AND oocql002=xmda024 AND oocql003='",g_dlang,"') a12,
                        imaa127 a13,to_char(xmdadocdt,'yyyy') a14,to_char(xmdadocdt,'mm') a15,
                        (CASE '",tm.curr,"' WHEN '0' THEN xmda015 ELSE ooef016 END) a16,
                        NVL(xmdc007,0) a17,0 a18,
                        (CASE '",tm.curr,"' WHEN '0' THEN NVL(xmdc046,0) ELSE NVL(xmdc046*xmda016,0) END) a19,0 a20,0 a21,0 a22,0 a23,0 a24,
                        0 a25,0 a26,0 a27,0 a28,0 a29,0 a30,0 a31,0 a32,
                        (SELECT imaf112 FROM imaf_t WHERE xmdcent=imafent AND xmdcsite=imafsite AND xmdc001=imaf001 ) a33,
                        xmdc001 a34,xmdc006 a35,NULL a36,NULL a37,NULL a38,NULL a39,xmdc001 a40,
                        (SELECT imaal003 FROM imaal_t WHERE imaalent=xmdcent AND imaal001=xmdc001 AND imaal002='",g_dlang,"') a41,
                        (SELECT imaal004 FROM imaal_t WHERE imaalent=xmdcent AND imaal001=xmdc001 AND imaal002='",g_dlang,"') a42 
                   FROM xmda_t ",
   #170123-00051#1-e mod
                   #僅能查詢出使用者有權限的資料
                 " LEFT OUTER JOIN gzxc_t ON xmdaent=gzxcent AND xmdasite=gzxc004 AND gzxc001='",g_user,"'",  
                 " LEFT OUTER JOIN ooef_t ON xmdaent=ooefent AND xmdasite=ooef001
                   LEFT OUTER JOIN pmaa_t ON xmdaent=pmaaent AND xmda004=pmaa001 
                       ,xmdc_t
                   LEFT OUTER JOIN imaa_t ON xmdcent=imaaent AND xmdc001=imaa001 
                   WHERE xmdaent=xmdcent AND xmdasite=xmdcsite AND xmdadocno=xmdcdocno AND ",tm.wc," AND xmda005 IN ('1','3') AND xmdasite=gzxc004 "
   #僅列印已確認訂單
   IF tm.chk1 = 'Y' THEN
      LET l_sql = l_sql CLIPPED," AND xmdastus IN ('Y','C')"
   ELSE
      LET l_sql = l_sql CLIPPED," AND xmdastus <> 'X' "
   END IF
   #160517-00015#1-add-(S)
   #排除多角內部交易單據
   IF tm.chk3 = 'Y' THEN
      LET l_sql = l_sql CLIPPED," AND (xmda006<>'5' OR xmda006 IS NULL) " #有些舊單，這個欄位的值是空的
   END IF
   #160517-00015#1-add-(E)
   #出貨單/出貨簽收單
   LET tm.wc = cl_replace_str(tm.wc,'xmda002','xmdk003')
   LET tm.wc = cl_replace_str(tm.wc,'xmda003','xmdk004')
   LET tm.wc = cl_replace_str(tm.wc,'xmda004','xmdk007')
   LET tm.wc = cl_replace_str(tm.wc,'xmda024','xmdk031')
   LET tm.wc = cl_replace_str(tm.wc,'xmdadocdt','xmdk001')   #161006-00004#1-add
   LET tm.wc = cl_replace_str(tm.wc,'xmdc001','xmdl008')
   LET tm.wc = cl_replace_str(tm.wc,'xmda','xmdk')
   LET l_sql1 = " SELECT xmdksite a1,",
                "        (SELECT ooefl003 FROM ooefl_t WHERE ooeflent=xmdkent AND ooefl001=xmdksite AND ooefl002='",g_dlang,"') a2,",
                "        xmdk003  a3,",
                "        (SELECT ooag011 FROM ooag_t WHERE ooagent=xmdkent AND ooag001=xmdk003) a4,",
                "        xmdk004  a5,",
                "        (SELECT ooefl003 FROM ooefl_t WHERE ooeflent=xmdkent AND ooefl001=xmdk004 AND ooefl002='",g_dlang,"') a6,",
                "        xmdk007  a7,",
                "        (SELECT pmaal004 FROM pmaal_t WHERE pmaalent=xmdkent AND pmaal001=xmdk007 AND pmaal002='",g_dlang,"') a8,",
                "        imaa009  a9,",
                "        (SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent=imaaent AND rtaxl001=imaa009 AND rtaxl002='",g_dlang,"') a10,",
                "        xmdk031  a11,",
                "        (SELECT oocql004 FROM oocql_t WHERE oocqlent=xmdkent AND oocql001='295' AND oocql002=xmdk031 AND oocql003='",g_dlang,"') a12, ",
                #"        imaa127  a13,to_char(xmdkdocdt,'yyyy') a14,to_char(xmdkdocdt,'mm') a15,",  #161006-00004#1-s-mod
                "        imaa127  a13,to_char(xmdk001,'yyyy') a14,to_char(xmdk001,'mm') a15,",       #161006-00004#1-e-mod
                "        (CASE '",tm.curr,"' WHEN '0' THEN xmdk016 ELSE ooef016 END) a16,",
                "        0 a17,0 a18,0 a19,0 a20,NVL(xmdl018,0) a21,0 a22,",
                "        (CASE '",tm.curr,"' WHEN '0' THEN NVL(xmdl027,0) ELSE NVL(xmdl027*xmdk017,0) END) a23,0 a24,0 a25,0 a26,0 a27,0 a28,0 a29,0 a30,0 a31,0 a32,",
                "        (SELECT imaf112 FROM imaf_t WHERE xmdlent=imafent AND xmdlsite=imafsite AND xmdl008=imaf001 ) a33,",
#                "        NULL a34,NULL a35,xmdl008 a36,xmdl017 a37,NULL a38,NULL a39",              #170123-00051#1 mark
                #170123-00051#1-s mod
                "        NULL a34,NULL a35,xmdl008 a36,xmdl017 a37,NULL a38,NULL a39,xmdl008 a40,",
                "        (SELECT imaal003 FROM imaal_t WHERE imaalent=xmdlent AND imaal001=xmdl008 AND imaal002='",g_dlang,"') a41,",
                "        (SELECT imaal004 FROM imaal_t WHERE imaalent=xmdlent AND imaal001=xmdl008 AND imaal002='",g_dlang,"') a42 " ,
                #170123-00051#1-e mod
                "   FROM xmdk_t ",
                    #僅能查詢出使用者有權限的資料
                "   LEFT OUTER JOIN gzxc_t ON xmdkent=gzxcent AND xmdksite=gzxc004 AND gzxc001='",g_user,"'",  
                "   LEFT OUTER JOIN ooef_t ON xmdkent=ooefent AND xmdksite=ooef001
                    LEFT OUTER JOIN pmaa_t ON xmdkent=pmaaent AND xmdk007=pmaa001 
                         ,xmdl_t
                    LEFT OUTER JOIN imaa_t ON xmdlent=imaaent AND xmdl008=imaa001      
                   WHERE xmdkent=xmdlent AND xmdksite=xmdlsite AND xmdkdocno=xmdldocno AND ",tm.wc," AND xmdksite=gzxc004
                     AND ( (xmdk000 IN ('1','2') AND xmdk002 = '1') OR (xmdk000='4' AND xmdk002='3') ) "
   #僅列印已過帳出貨單
   IF tm.chk2 = 'Y' THEN
      LET l_sql1 = l_sql1 CLIPPED," AND xmdkstus='S' "
   ELSE
      LET l_sql1 = l_sql1 CLIPPED," AND xmdkstus<>'X'"
   END IF
   #160517-00015#1-add-(S)
   #排除多角內部交易單據
   IF tm.chk3 = 'Y' THEN
      LET l_sql1 = l_sql1 CLIPPED," AND (xmdk045<>'5' OR xmdk045 IS NULL) " #有些舊單，這個欄位的值是空的
   END IF
   #160517-00015#1-add-(E)
   #銷退單
   LET l_sql2 = " SELECT xmdksite a1,",
                "        (SELECT ooefl003 FROM ooefl_t WHERE ooeflent=xmdkent AND ooefl001=xmdksite AND ooefl002='",g_dlang,"') a2,",
                "        xmdk003  a3,",
                "        (SELECT ooag011 FROM ooag_t WHERE ooagent=xmdkent AND ooag001=xmdk003) a4,",
                "        xmdk004  a5,",
                "        (SELECT ooefl003 FROM ooefl_t WHERE ooeflent=xmdkent AND ooefl001=xmdk004 AND ooefl002='",g_dlang,"') a6,",
                "        xmdk007  a7,",
                "        (SELECT pmaal004 FROM pmaal_t WHERE pmaalent=xmdkent AND pmaal001=xmdk007 AND pmaal002='",g_dlang,"') a8,",
                "        imaa009  a9,",
                "        (SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent=imaaent AND rtaxl001=imaa009 AND rtaxl002='",g_dlang,"') a10,",
                "        xmdk031  a11,",
                "        (SELECT oocql004 FROM oocql_t WHERE oocqlent=xmdkent AND oocql001='295' AND oocql002=xmdk031 AND oocql003='",g_dlang,"') a12,",
                #"        imaa127 a13,to_char(xmdkdocdt,'yyyy') a14,to_char(xmdkdocdt,'mm') a15,",  #161006-00004#1-s-mod
                "        imaa127 a13,to_char(xmdk001,'yyyy') a14,to_char(xmdk001,'mm') a15,",       #161006-00004#1-e-mod
                "        (CASE '",tm.curr,"' WHEN '0' THEN xmdk016 ELSE ooef016 END) a16,",
                "        0 a17,0 a18,0 a19,0 a20,0 a21,0 a22,0 a23,0 a24,NVL(xmdl018,0) a25,0 a26,",
                "        (CASE '",tm.curr,"' WHEN '0' THEN NVL(xmdl027,0) ELSE NVL(xmdl027*xmdk017,0) END) a27,0 a28,0 a29,0 a30,0 a31,0 a32,",
                "        (SELECT imaf112 FROM imaf_t WHERE xmdlent=imafent AND xmdlsite=imafsite AND xmdl008=imaf001 ) a33,",
#                "        NULL a34,NULL a35,NULL a36,NULL a37,xmdl008 a38,xmdl017 a39",             #170123-00051#1 mark
                #170123-00051#1-s mod
                "        NULL a34,NULL a35,NULL a36,NULL a37,xmdl008 a38,xmdl017 a39,xmdl008 a40,",
                "        (SELECT imaal003 FROM imaal_t WHERE imaalent=xmdlent AND imaal001=xmdl008 AND imaal002='",g_dlang,"') a41,",
                "        (SELECT imaal004 FROM imaal_t WHERE imaalent=xmdlent AND imaal001=xmdl008 AND imaal002='",g_dlang,"') a42 ",
                #170123-00051#1-s mod
                "   FROM xmdk_t ",
                    #僅能查詢出使用者有權限的資料
                "   LEFT OUTER JOIN gzxc_t ON xmdkent=gzxcent AND xmdksite=gzxc004 AND gzxc001='",g_user,"'",  
                "   LEFT OUTER JOIN ooef_t ON xmdkent=ooefent AND xmdksite=ooef001
                    LEFT OUTER JOIN pmaa_t ON xmdkent=pmaaent AND xmdk007=pmaa001 
                         ,xmdl_t
                    LEFT OUTER JOIN imaa_t ON xmdlent=imaaent AND xmdl008=imaa001      
                   WHERE xmdkent=xmdlent AND xmdksite=xmdlsite AND xmdkdocno=xmdldocno AND ",tm.wc," AND xmdk000='6' AND xmdksite=gzxc004 "
   #僅列印已過帳出貨單
   IF tm.chk2 = 'Y' THEN
      LET l_sql2 = l_sql2 CLIPPED," AND xmdkstus='S' "
   ELSE
      LET l_sql2 = l_sql2 CLIPPED," AND xmdkstus<>'X'"
   END IF
   #160517-00015#1-add-(S)
   #排除多角內部交易單據
   IF tm.chk3 = 'Y' THEN
      LET l_sql2 = l_sql2 CLIPPED," AND (xmdk045<>'5' OR xmdk045 IS NULL) " #有些舊單，這個欄位的值是空的
   END IF
   #160517-00015#1-add-(E)
  
   #開始組SQL
   LET g_select = " SELECT a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,
                           a27,a28,a29,a30,a31,a32,a33,a34,a35,a36,a37,a38,a39, 
                           a40,a41,a42 ",                                   #170123-00051#1 add
                  "   FROM ( ",l_sql,
                  "            UNION ALL ",
                               l_sql1,
                  "            UNION ALL ",
                               l_sql2,") WHERE 1=1 "
                          
                  
#   #end add-point
#   LET g_select = " SELECT xmdasite,NULL,xmda002,ooag_t.ooag011,xmda003,ooefl_t.ooefl003,xmda004,pmaal_t.pmaal004, 
#       imaa_t.imaa009,NULL,xmda024,NULL,imaa_t.imaa127,NULL,NULL,xmda015,xmdc_t.xmdc007,0,xmdc_t.xmdc046, 
#       NULL,xmdl_t.xmdl018,NULL,xmdl_t.xmdl027,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,xmdd001, 
#       xmdd004,xmdl_t.xmdl008,xmdl_t.xmdl017,NULL,NULL,xmdc_t.xmdc001,NULL,NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"


#   #end add-point
#    LET g_from = " FROM xmda_t,xmdd_t,xmdc_t,xmdg_t,xmdk_t,xmdl_t,pmaa_t,imaa_t,ooag_t,ooefl_t,pmaal_t" 
#
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
 
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("xmda_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = g_sql CLIPPED ,"  ORDER BY a14,a15 " #年/月排序
   #DISPLAY "g_sql:",g_sql
   #end add-point
   PREPARE axmr100_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE axmr100_x01_curs CURSOR FOR axmr100_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axmr100_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION axmr100_x01_ins_data()
DEFINE sr RECORD 
   xmdasite LIKE xmda_t.xmdasite, 
   l_xmdasite_desc LIKE ooefl_t.ooefl003, 
   xmda002 LIKE xmda_t.xmda002, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   xmda003 LIKE xmda_t.xmda003, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   xmda004 LIKE xmda_t.xmda004, 
   pmaal_t_pmaal004 LIKE pmaal_t.pmaal004, 
   imaa_t_imaa009 LIKE imaa_t.imaa009, 
   l_imaa009_desc LIKE oocql_t.oocql004, 
   xmda024 LIKE xmda_t.xmda024, 
   l_xmda024_desc LIKE oocql_t.oocql004, 
   imaa_t_imaa127 LIKE imaa_t.imaa127, 
   l_year LIKE type_t.num5, 
   l_month LIKE type_t.num5, 
   xmda015 LIKE xmda_t.xmda015, 
   xmdc_t_xmdc007 LIKE xmdc_t.xmdc007, 
   l_xmdc007_ratio LIKE type_t.num20_6, 
   xmdc_t_xmdc046 LIKE xmdc_t.xmdc046, 
   l_xmdc046_ratio LIKE type_t.num20_6, 
   xmdl_t_xmdl018 LIKE xmdl_t.xmdl018, 
   l_xmdl018_ratio LIKE type_t.num20_6, 
   xmdl_t_xmdl027 LIKE xmdl_t.xmdl027, 
   l_xmdl027_ratio LIKE type_t.num20_6, 
   l_xmdl018_1 LIKE xmdl_t.xmdl018, 
   l_xmdl018_1_ratio LIKE type_t.num20_6, 
   l_xmdl027_1 LIKE xmdl_t.xmdl027, 
   l_xmdl027_1_ratio LIKE type_t.num20_6, 
   l_cqty LIKE type_t.num20_6, 
   l_cqty_ratio LIKE type_t.num20_6, 
   l_cnum LIKE type_t.num20_6, 
   l_cnum_ratio LIKE type_t.num20_6, 
   l_imaf112 LIKE imaf_t.imaf112, 
   xmdd001 LIKE xmdd_t.xmdd001, 
   xmdd004 LIKE xmdd_t.xmdd004, 
   xmdl_t_xmdl008 LIKE xmdl_t.xmdl008, 
   xmdl_t_xmdl017 LIKE xmdl_t.xmdl017, 
   l_xmdl008_1 LIKE xmdl_t.xmdl008, 
   l_xmdl017_1 LIKE xmdl_t.xmdl017, 
   xmdc_t_xmdc001 LIKE xmdc_t.xmdc001, 
   l_imaal003_desc LIKE imaal_t.imaal003, 
   l_imaal004_desc LIKE imaal_t.imaal004
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_success LIKE type_t.num5
TYPE type_convert_unit RECORD
   l_year    LIKE type_t.num5,    #年
   l_month   LIKE type_t.num5,    #月
   xmdc007   LIKE xmdc_t.xmdc007, #訂單數量
   xmdc046   LIKE xmdc_t.xmdc046, #訂單金額
   xmdl018   LIKE xmdl_t.xmdl018, #銷貨數量
   xmdl027   LIKE xmdl_t.xmdl027, #銷貨金額
   xmdl018_1 LIKE xmdl_t.xmdl018, #銷退數量
   xmdl027_1 LIKE xmdl_t.xmdl027, #銷退金額
   qty       LIKE xmdl_t.xmdl018, #銷貨淨量
   num       LIKE xmdl_t.xmdl027  #銷貨淨額
END RECORD
DEFINE l_sum           type_convert_unit
DEFINE l_record_year   LIKE type_t.num5 #紀錄年
DEFINE l_record_month  LIKE type_t.num5 #紀錄月
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    IF NOT axmr100_x01_create_tmp() THEN
       RETURN
    END IF
    
    LET l_record_year = 0 # 若為null值，會出現無法比對的問題
    LET l_sum.xmdc007 = 0
    LET l_sum.xmdc046 = 0
    LET l_sum.xmdl018 = 0
    LET l_sum.xmdl027 = 0
    LET l_sum.xmdl018_1 = 0
    LET l_sum.xmdl027_1 = 0
    LET l_sum.qty = 0
    LET l_sum.num = 0
    #161109-00085#11-s mod
#    FOREACH axmr100_x01_curs INTO sr.*   #161109-00085#11-s mark  
    FOREACH axmr100_x01_curs INTO sr.xmdasite,sr.l_xmdasite_desc,sr.xmda002,sr.ooag_t_ooag011,sr.xmda003,
                                  sr.ooefl_t_ooefl003,sr.xmda004,sr.pmaal_t_pmaal004,sr.imaa_t_imaa009,sr.l_imaa009_desc,
                                  sr.xmda024,sr.l_xmda024_desc,sr.imaa_t_imaa127,sr.l_year,sr.l_month,
                                  sr.xmda015,sr.xmdc_t_xmdc007,sr.l_xmdc007_ratio,sr.xmdc_t_xmdc046,sr.l_xmdc046_ratio,
                                  sr.xmdl_t_xmdl018,sr.l_xmdl018_ratio,sr.xmdl_t_xmdl027,sr.l_xmdl027_ratio,sr.l_xmdl018_1,
                                  sr.l_xmdl018_1_ratio,sr.l_xmdl027_1,sr.l_xmdl027_1_ratio,sr.l_cqty,sr.l_cqty_ratio,
                                  sr.l_cnum,sr.l_cnum_ratio,sr.l_imaf112,sr.xmdd001,sr.xmdd004,
                                  sr.xmdl_t_xmdl008,sr.xmdl_t_xmdl017,sr.l_xmdl008_1,sr.l_xmdl017_1,
                                  sr.xmdc_t_xmdc001,sr.l_imaal003_desc,sr.l_imaal004_desc    #170123-00051#1 add
                                  
    #161109-00085#11-e mod
       IF STATUS THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = 'foreach:'
          LET g_errparam.code   = STATUS
          LET g_errparam.popup  = TRUE
          CALL cl_err()
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
       
       IF NOT cl_null(sr.l_imaf112) THEN
          #訂單數量(xmdc007)
          IF sr.xmdc_t_xmdc007<>0 AND NOT cl_null(sr.xmdd004) AND sr.xmdd004<>sr.l_imaf112 THEN
             CALL s_aooi250_convert_qty(sr.xmdd001,sr.xmdd004,sr.l_imaf112,sr.xmdc_t_xmdc007)
                  RETURNING l_success,sr.xmdc_t_xmdc007
          END IF
          #銷貨數量(xmdl018)
          IF sr.xmdl_t_xmdl018<>0 AND NOT cl_null(sr.xmdl_t_xmdl017) AND sr.xmdl_t_xmdl017<>sr.l_imaf112 THEN
             CALL s_aooi250_convert_qty(sr.xmdl_t_xmdl008,sr.xmdl_t_xmdl017,sr.l_imaf112,sr.xmdl_t_xmdl018)
                  RETURNING l_success,sr.xmdl_t_xmdl018
          END IF
          #銷退數量(xmdl018_1)
          IF sr.l_xmdl018_1<>0 AND NOT cl_null(sr.l_xmdl017_1) AND sr.l_xmdl017_1<>sr.l_imaf112 THEN
             CALL s_aooi250_convert_qty(sr.l_xmdl008_1,sr.l_xmdl017_1,sr.l_imaf112,sr.l_xmdl018_1)
                  RETURNING l_success,sr.l_xmdl018_1
          END IF
       END IF

        
       IF l_record_year <> sr.l_year OR l_record_month <> sr.l_month THEN
          #第一次跑進來時，會跑else段，紀錄第一筆的 年/月
          #過第一次之後，再進來，都會跑then段，去寫進tmp(年/月的加總資料)
          IF l_record_year <> 0 THEN
             LET l_sum.l_year = l_record_year    #年
             LET l_sum.l_month = l_record_month  #月
             #161109-00085#11-mod-s
             #INSERT INTO axmr100_tmp VALUES (l_sum.*)   #161109-00085#11   mark
             INSERT INTO axmr100_tmp(l_year,l_month,xmdc007,xmdc046,xmdl018,xmdl027,xmdl018_1,xmdl027_1,qty,num      ) 
                         VALUES (l_sum.l_year,l_sum.l_month,l_sum.xmdc007,l_sum.xmdc046,l_sum.xmdl018,l_sum.xmdl027,
                                 l_sum.xmdl018_1,l_sum.xmdl027_1,l_sum.qty,l_sum.num )
             #161109-00085#11-mod-e
             IF SQLCA.sqlcode THEN
                INITIALIZE g_errparam TO NULL 
                LET g_errparam.extend = "INSERT INTO tmp"
                LET g_errparam.code   = SQLCA.sqlcode 
                LET g_errparam.popup  = TRUE 
                CALL cl_err()
                EXIT FOREACH
             END IF
             LET l_sum.xmdc007 = 0
             LET l_sum.xmdc046 = 0
             LET l_sum.xmdl018 = 0
             LET l_sum.xmdl027 = 0
             LET l_sum.xmdl018_1 = 0
             LET l_sum.xmdl027_1 = 0
             LET l_sum.qty = 0
             LET l_sum.num = 0
             #tmp寫完，才把sr的值給l_record_XXX，這樣tmp的年月資料才不會有問題
             LET l_record_year = sr.l_year    #年
             LET l_record_month = sr.l_month  #月
          ELSE
             LET l_record_year = sr.l_year    #年
             LET l_record_month = sr.l_month  #月
          END IF
       END IF
       LET l_sum.xmdc007   = l_sum.xmdc007 + sr.xmdc_t_xmdc007
       LET l_sum.xmdc046   = l_sum.xmdc046 + sr.xmdc_t_xmdc046
       LET l_sum.xmdl018   = l_sum.xmdl018 + sr.xmdl_t_xmdl018
       LET l_sum.xmdl027   = l_sum.xmdl027 + sr.xmdl_t_xmdl027
       LET l_sum.xmdl018_1 = l_sum.xmdl018_1 + sr.l_xmdl018_1 
       LET l_sum.xmdl027_1 = l_sum.xmdl027_1 + sr.l_xmdl027_1 
       LET l_sum.qty       = l_sum.qty + (sr.xmdl_t_xmdl018 - sr.l_xmdl018_1) 
       LET l_sum.num       = l_sum.num + (sr.xmdl_t_xmdl027 - sr.l_xmdl027_1) 
    END FOREACH
    #最後的年/月，因不會有下一個不一樣的年/月做比對，上方foreach中的insert tmp的部分不會跑到
    #所以要在foreach之後，讓它寫入最後的年/月的加總資料
    IF l_record_year <> 0 THEN
       LET l_sum.l_year = l_record_year    #年
       LET l_sum.l_month = l_record_month  #月
       #161109-00085#11-mod-s
       #INSERT INTO axmr100_tmp VALUES (l_sum.*)   #161109-00085#11   mark
       INSERT INTO axmr100_tmp(l_year,l_month,xmdc007,xmdc046,xmdl018,xmdl027,xmdl018_1,xmdl027_1,qty,num)
                   VALUES (l_sum.l_year,l_sum.l_month,l_sum.xmdc007,l_sum.xmdc046,l_sum.xmdl018,l_sum.xmdl027,
                           l_sum.xmdl018_1,l_sum.xmdl027_1,l_sum.qty,l_sum.num )
       #161109-00085#11-mod-e
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "INSERT INTO tmp"
          LET g_errparam.code   = SQLCA.sqlcode 
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
       END IF
    END IF
    INITIALIZE sr.* TO NULL
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH axmr100_x01_curs INTO sr.*                               
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
       IF NOT cl_null(sr.l_imaf112) THEN
          #訂單數量(xmdc007)
          IF sr.xmdc_t_xmdc007<>0 AND NOT cl_null(sr.xmdd004) AND sr.xmdd004<>sr.l_imaf112 THEN
             CALL s_aooi250_convert_qty(sr.xmdd001,sr.xmdd004,sr.l_imaf112,sr.xmdc_t_xmdc007)
                  RETURNING l_success,sr.xmdc_t_xmdc007
          END IF
          #銷貨數量(xmdl018)
          IF sr.xmdl_t_xmdl018<>0 AND NOT cl_null(sr.xmdl_t_xmdl017) AND sr.xmdl_t_xmdl017<>sr.l_imaf112 THEN
             CALL s_aooi250_convert_qty(sr.xmdl_t_xmdl008,sr.xmdl_t_xmdl017,sr.l_imaf112,sr.xmdl_t_xmdl018)
                  RETURNING l_success,sr.xmdl_t_xmdl018
          END IF
          #銷退數量(xmdl018_1)
          IF sr.l_xmdl018_1<>0 AND NOT cl_null(sr.l_xmdl017_1) AND sr.l_xmdl017_1<>sr.l_imaf112 THEN
             CALL s_aooi250_convert_qty(sr.l_xmdl008_1,sr.l_xmdl017_1,sr.l_imaf112,sr.l_xmdl018_1)
                  RETURNING l_success,sr.l_xmdl018_1
          END IF
       END IF
       LET sr.l_cqty = sr.xmdl_t_xmdl018 - sr.l_xmdl018_1 #銷貨淨量
       LET sr.l_cnum = sr.xmdl_t_xmdl027 - sr.l_xmdl027_1 #銷貨淨額
       
       SELECT l_year,l_month,xmdc007,xmdc046,xmdl018,xmdl027,xmdl018_1,xmdl027_1,qty,num
         #161109-00085#11-s mod
#         INTO l_sum.*   #161109-00085#11-s mark
         INTO l_sum.l_year,l_sum.l_month,l_sum.xmdc007,l_sum.xmdc046,l_sum.xmdl018,
              l_sum.xmdl027,l_sum.xmdl018_1,l_sum.xmdl027_1,l_sum.qty,l_sum.num
         #161109-00085#11-e mod
         FROM axmr100_tmp
        WHERE l_year = sr.l_year AND l_month = sr.l_month
       
       LET sr.l_xmdc007_ratio = sr.xmdc_t_xmdc007 / l_sum.xmdc007 #訂單數量比率
       LET sr.l_xmdc046_ratio = sr.xmdc_t_xmdc046 / l_sum.xmdc046 #訂單金額比率
       LET sr.l_xmdl018_ratio = sr.xmdl_t_xmdl018 / l_sum.xmdl018 #銷貨數量比率
       LET sr.l_xmdl027_ratio = sr.xmdl_t_xmdl027 / l_sum.xmdl027 #銷貨金額比率
       LET sr.l_xmdl018_1_ratio = sr.l_xmdl018_1 / l_sum.xmdl018_1 #銷退數量比率
       LET sr.l_xmdl027_1_ratio = sr.l_xmdl027_1 / l_sum.xmdl027_1 #銷退金額比率
       LET sr.l_cqty_ratio = sr.l_cqty / l_sum.qty #銷貨淨量比率
       LET sr.l_cnum_ratio = sr.l_cnum / l_sum.num #銷貨淨額比率

       
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.xmdasite,sr.l_xmdasite_desc,sr.xmda002,sr.ooag_t_ooag011,sr.xmda003,sr.ooefl_t_ooefl003,sr.xmda004,sr.pmaal_t_pmaal004,sr.imaa_t_imaa009,sr.l_imaa009_desc,sr.xmda024,sr.l_xmda024_desc,sr.imaa_t_imaa127,sr.l_year,sr.l_month,sr.xmda015,sr.xmdc_t_xmdc007,sr.l_xmdc007_ratio,sr.xmdc_t_xmdc046,sr.l_xmdc046_ratio,sr.xmdl_t_xmdl018,sr.l_xmdl018_ratio,sr.xmdl_t_xmdl027,sr.l_xmdl027_ratio,sr.l_xmdl018_1,sr.l_xmdl018_1_ratio,sr.l_xmdl027_1,sr.l_xmdl027_1_ratio,sr.l_cqty,sr.l_cqty_ratio,sr.l_cnum,sr.l_cnum_ratio,sr.xmdc_t_xmdc001,sr.l_imaal003_desc,sr.l_imaal004_desc
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "axmr100_x01_execute"
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
    DROP TABLE axmr100_tmp;
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axmr100_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION axmr100_x01_rep_data()
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
 
{<section id="axmr100_x01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 建立tmp，用來儲存年月的總量or總額
# Memo...........:
# Usage..........: CALL axmr100_x01_create_tmp()
# Input parameter: 
# Return code....: r_success  TRUE/FALSE
# Date & Author..: 2016/05/23 By dorislai
# Modify.........:
################################################################################
PRIVATE FUNCTION axmr100_x01_create_tmp()
   DEFINE r_success  LIKE type_t.num5
   
   WHENEVER ERROR CONTINUE
   
   LET r_success = TRUE
   
   #檢查事務中
   IF NOT s_transaction_chk('N',1) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   DROP TABLE axmr100_tmp;
   CREATE TEMP TABLE axmr100_tmp(
       l_year     SMALLINT,         #年
       l_month    SMALLINT,         #月
       xmdc007    DECIMAL(20,6),      #訂單數量
       xmdc046    DECIMAL(20,6),      #訂單金額
       xmdl018    DECIMAL(20,6),      #銷貨數量
       xmdl027    DECIMAL(20,6),      #銷貨金額
       xmdl018_1  DECIMAL(20,6),      #銷退數量
       xmdl027_1  DECIMAL(20,6),      #銷退金額
       qty        DECIMAL(20,6),      #銷貨淨量
       num        DECIMAL(20,6)     #銷貨淨額
       );

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      
      LET r_success = FALSE
      RETURN r_success
   END IF  

   RETURN r_success
END FUNCTION

 
{</section>}
 
