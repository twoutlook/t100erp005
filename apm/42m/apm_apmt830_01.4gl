#該程式未解開Section, 採用最新樣板產出!
{<section id="apmt830_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0008(2015-04-06 11:06:25), PR版次:0008(2017-01-19 16:29:59)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000066
#+ Filename...: apmt830_01
#+ Description: 依要貨組織預設要貨資料整批產生要貨單身子作業
#+ Creator....: 04226(2015-04-01 18:55:45)
#+ Modifier...: 04226 -SD/PR- 08172
 
{</section>}
 
{<section id="apmt830_01.global" >}
#應用 c02b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#Memos
#Modify...........:No.170116-00018#1   2017/01/19  by 08172  要货单身配送仓赋值
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_pmeu_d        RECORD
       sel LIKE type_t.chr500, 
   pmeusite LIKE pmeu_t.pmeusite, 
   pmeu001 LIKE pmeu_t.pmeu001, 
   pmeuseq LIKE pmeu_t.pmeuseq, 
   pmeu002 LIKE pmeu_t.pmeu002, 
   pmeu003 LIKE pmeu_t.pmeu003, 
   pmeu003_desc LIKE type_t.chr500, 
   pmeu003_desc_desc LIKE type_t.chr500, 
   pmeu004 LIKE pmeu_t.pmeu004, 
   pmeu004_desc LIKE type_t.chr500, 
   pmeu005 LIKE pmeu_t.pmeu005, 
   pmeu006 LIKE pmeu_t.pmeu006, 
   pmeu006_desc LIKE type_t.chr500, 
   pmeu007 LIKE pmeu_t.pmeu007
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_where_sql           STRING
DEFINE g_pmeusite            LIKE pmeu_t.pmeusite    #要貨組織
DEFINE g_pmeu001             LIKE pmeu_t.pmeu001     #要貨部門
DEFINE g_pmdadocno           LIKE pmda_t.pmdadocno   #要貨單號
DEFINE g_pmda                RECORD
       pmdadocdt             LIKE pmda_t.pmdadocdt,  #單據日期
       pmdasite              LIKE pmda_t.pmdasite,   #要貨組織
       pmda003               LIKE pmda_t.pmda003,    #要貨部門
       pmda201               LIKE pmda_t.pmda201,    #採購方式
       pmda202               LIKE pmda_t.pmda202,    #所屬品類
       pmda203               LIKE pmda_t.pmda203,    #需求組織
       pmda204               LIKE pmda_t.pmda204,    #採購組織
       pmda205               LIKE pmda_t.pmda205,    #配送中心
       pmda206               LIKE pmda_t.pmda206,    #配送倉
       pmda207               LIKE pmda_t.pmda207     #到貨日期  #151113-00003#11 151130 By pomelo add
                             END RECORD
#end add-point
 
DEFINE g_pmeu_d          DYNAMIC ARRAY OF type_g_pmeu_d
DEFINE g_pmeu_d_t        type_g_pmeu_d
 
 
DEFINE g_pmeusite_t   LIKE pmeu_t.pmeusite    #Key值備份
DEFINE g_pmeuseq_t      LIKE pmeu_t.pmeuseq    #Key值備份
DEFINE g_pmeu001_t      LIKE pmeu_t.pmeu001    #Key值備份
 
 
DEFINE l_ac                  LIKE type_t.num10
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rec_b               LIKE type_t.num10 
DEFINE g_detail_idx          LIKE type_t.num10
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
    
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point    
 
{</section>}
 
{<section id="apmt830_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION apmt830_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_pmdadocno,            #要貨單號
   p_pmeusite,             #要貨組織
   p_pmeu001               #要貨部門
   #end add-point
   )
   #add-point:input段define name="input.define_customerization"
   
   #end add-point
   DEFINE l_ac_t          LIKE type_t.num10       #未取消的ARRAY CNT 
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num10
   DEFINE l_insert        LIKE type_t.num5
   DEFINE l_cmd           LIKE type_t.chr5
   #add-point:input段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   DEFINE p_pmdadocno     LIKE pmda_t.pmdadocno   #要貨單號
   DEFINE p_pmeusite      LIKE pmeu_t.pmeusite    #要貨組織
   DEFINE p_pmeu001       LIKE pmeu_t.pmeu001     #要貨部門
   DEFINE l_success       LIKE type_t.num5
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_apmt830_01 WITH FORM cl_ap_formpath("apm","apmt830_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單身前置處理 name="input.pre_input"
   WHENEVER ERROR CONTINUE
   IF NOT apmt830_01_create_tmp() THEN
      RETURN
   END IF
   LET g_pmdadocno = p_pmdadocno  #要貨單號
   LET g_pmeusite = p_pmeusite    #要貨組織
   LET g_pmeu001 = p_pmeu001      #要貨部門
   CALL apmt830_01_get_pmda()
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT ARRAY g_pmeu_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
         
         #自訂ACTION
         #add-point:單身前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(detail_input)
         
         
         BEFORE INPUT
            #add-point:單身輸入前處理 name="input.before_input"
            CALL apmt830_01_b_fill()
            
         BEFORE ROW
            LET l_ac = ARR_CURR()
            LET g_pmeu_d_t.* = g_pmeu_d[l_ac].*
            DISPLAY l_ac TO FORMONLY.idx
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sel
            #add-point:BEFORE FIELD sel name="input.b.page1.sel"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sel
            
            #add-point:AFTER FIELD sel name="input.a.page1.sel"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sel
            #add-point:ON CHANGE sel name="input.g.page1.sel"
            #當勾選的時候，檢查商品生命週期
            IF g_pmeu_d[l_ac].sel = 'Y' THEN
               #IF NOT s_life_cycle_chk(g_prog,g_pmda.pmdasite,'1',g_pmeu_d[l_ac].pmeu003) THEN   #150616-00035#78-mark by dongsz
               IF NOT s_life_cycle_chk(g_prog,g_pmda.pmdasite,'1',g_pmeu_d[l_ac].pmeu003,'','') THEN   #150616-00035#78-add by dongsz
                  LET g_pmeu_d[l_ac].sel = 'N'
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL apmt830_01_upd_tmp()
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.sel
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sel
            #add-point:ON ACTION controlp INFIELD sel name="input.c.page1.sel"
            
            #END add-point
 
 
 
 
         #自訂ACTION
         #add-point:單身其他段落處理(EX:on row change, etc...) name="input.other"
         
         #end add-point
 
         AFTER INPUT
            #add-point:單身輸入後處理 name="input.after_input"
            
            #end add-point
            
      END INPUT
      
 
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      #公用action
      ON ACTION accept
         ACCEPT DIALOG
        
      ON ACTION cancel
         #add-point:cancel name="input.cancel"
         
         #end add-point
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION close
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit
         LET INT_FLAG = TRUE 
         EXIT DIALOG
   
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
 
   #add-point:畫面關閉前 name="input.before_close"
   
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_apmt830_01 
   
   #add-point:input段after input name="input.post_input"
   IF INT_FLAG = FALSE THEN
      CALL apmt830_01_gen_detail()
   END IF
   LET INT_FLAG = FALSE
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="apmt830_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="apmt830_01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 建立temp table
# Memo...........:
# Usage..........: CALL apmt830_01_create_tmp()
#                     RETURNING r_success
# Input parameter: 無
# Return code....: r_success     True/False
# Date & Author..: 2015/04/06 By pomelo
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt830_01_create_tmp()
DEFINE r_success        LIKE type_t.num5

   LET r_success = TRUE
   
   CALL apmt830_01_drop_tmp()
   
   CREATE TEMP TABLE apmt830_01_tmp(
      pmeusite  VARCHAR(10),         #要貨組織
      pmeu001  VARCHAR(10),           #要貨部門
      pmeuseq  INTEGER,           #項次
      pmeu002  VARCHAR(40),           #商品條碼
      pmeu003  VARCHAR(40),           #商品編號
      pmeu004  VARCHAR(10),           #要貨包裝單位
      pmeu005  DECIMAL(20,6),           #要貨包裝數量
      pmeu006  VARCHAR(10),           #要貨單位
      pmeu007  DECIMAL(20,6)     #要貨數量
   )
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Create Temp Table apmt830_01_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 刪除temp table
# Memo...........:
# Usage..........: CALL apmt830_01_drop_tmp()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/04/06 By pomelo
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt830_01_drop_tmp()

   DROP TABLE apmt830_01_tmp
   
END FUNCTION

################################################################################
# Descriptions...: 取得要貨單單頭
# Memo...........:
# Usage..........: CALL apmt830_01_get_pmda()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/04/06 By pomelo
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt830_01_get_pmda()
DEFINE l_sys     LIKE type_t.num5 

   INITIALIZE g_pmda.* TO NULL
   
   SELECT pmdadocdt, pmdasite, pmda003, pmda201,
          pmda202,   pmda203,  pmda204, pmda205,
          pmda206,   pmda207                     #151113-00003#11 151130 By pomelo add pmda207
     INTO g_pmda.pmdadocdt, g_pmda.pmdasite, g_pmda.pmda003, g_pmda.pmda201,
          g_pmda.pmda202,   g_pmda.pmda203,  g_pmda.pmda204, g_pmda.pmda205,
          g_pmda.pmda206,   g_pmda.pmda207       #151113-00003#11 151130 By pomelo add pmda207
     FROM pmda_t
    WHERE pmdaent = g_enterprise
      AND pmdadocno = g_pmdadocno

   #品類設定加上部門過濾該作業可使用的商品
   LET g_where_sql = s_arti204_control_where(g_prog,g_pmda.pmda003,'1')
   
   #採購方式
   IF NOT cl_null(g_pmda.pmda201) THEN
      LET g_where_sql = g_where_sql," AND rtdx027 = '",g_pmda.pmda201,"'"
   END IF
   
   #所屬品類
   IF NOT cl_null(g_pmda.pmda202) THEN
      LET l_sys = 0
      CALL cl_get_para(g_enterprise,g_site,'E-CIR-0001') RETURNING l_sys
      LET g_where_sql = g_where_sql," AND imaa009 IN (SELECT DISTINCT rtax001",
                                    "                   FROM rtax_t ",
                                    "                  WHERE rtaxent =",g_enterprise,
                                    "                    AND rtax004 >= ",l_sys,
                                    "                    AND rtaxstus = 'Y'", 
                                    "                  START WITH rtax003 = '",g_pmda.pmda202,"'",
                                    "                    AND rtaxstus = 'Y'",
                                    "                CONNECT BY NOCYCLE PRIOR rtax001 = rtax003 " , 
                                    "                  UNION ",
                                    "                 SELECT DISTINCT rtax001",
                                    "                            FROM rtax_t ",
                                    "                           WHERE rtaxent =",g_enterprise,
                                    "                             AND rtax004 = ",l_sys,
                                    "                             AND rtax005 = 0 ",
                                    "                             AND rtaxstus = 'Y' ",
                                    "                             AND rtax001 = '",g_pmda.pmda202,"' )"                                                                        
   END IF
   
   #採購中心
   IF NOT cl_null(g_pmda.pmda204) THEN
      LET g_where_sql = g_where_sql," AND rtdx028 = '",g_pmda.pmda204,"'"
   END IF
   
   #配送中心
   IF NOT cl_null(g_pmda.pmda205) THEN
      LET g_where_sql = g_where_sql," AND rtdx029 = '",g_pmda.pmda205,"'"
   END IF
END FUNCTION

################################################################################
# Descriptions...: 顯示符合的要貨組織預設資料
# Memo...........:
# Usage..........: CALL apmt830_01_b_fill()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/04/04 By pomelo
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt830_01_b_fill()
DEFINE l_sql            STRING

   LET l_sql = "SELECT 'N',         pmeusite,    pmeu001,     pmeuseq,",
               "       pmeu002,     pmeu003,     t1.imaal003, t1.imaal004,",
               "       pmeu004,     t2.oocal003, pmeu005,     pmeu006,",
               "       t3.oocal003, pmeu007",
               "  FROM imaa_t,imay_t,rtdx_t,imaf_t,pmeu_t",  #150424-00021#1 Add-S By Ken 150714
               "  LEFT OUTER JOIN imaal_t t1 ON pmeuent = t1.imaalent",
               "                            AND pmeu003 = t1.imaal001",
               "                            AND t1.imaal002 = '",g_dlang,"'",
               "  LEFT OUTER JOIN oocal_t t2 ON pmeuent = t2.oocalent",
               "                            AND pmeu004 = t2.oocal001",
               "                            AND t2.oocal002 = '",g_dlang,"'",
               "  LEFT OUTER JOIN oocal_t t3 ON pmeuent = t3.oocalent",
               "                            AND pmeu006 = t3.oocal001",
               "                            AND t3.oocal002 = '",g_dlang,"'",
               " WHERE pmeuent = rtdxent",
               "   AND pmeusite = rtdxsite",
               "   AND pmeu003 = rtdx001",
               "   AND rtdxent = imaaent",
               "   AND rtdx001 = imaa001",
               "   AND rtdxent = imayent",
               "   AND rtdx001 = imay001",
               "   AND rtdx002 = imay003",
               #150424-00021#1 Add-S By Ken 150714
               "   AND rtdxent = imafent ",
               "   AND rtdxsite= imafsite ",
               "   AND rtdx001 = imaf001 ",
               #150424-00021#1 Add-E By Ken 150714             
               "   AND pmeuent = ",g_enterprise,
               "   AND pmeusite = '",g_pmeusite,"'",
               "   AND pmeu001 = '",g_pmeu001,"'",
               "   AND imaastus = 'Y'",
               "   AND imaystus = 'Y'",
               "   AND rtdxstus = 'Y'",
               #150424-00021#1 Modify-S By Ken 150714
               #"   AND (COALESCE(rtdx031,'-1') = '-1'",
               "   AND (COALESCE(imaf153,'-1') = '-1'",
               #150424-00021#1 Modify-E By Ken 150714
               "    OR EXISTS (SELECT 1",
               "                 FROM stan_t, star_t, stas_t",
               "                WHERE stanent = starent",
               "                  AND stan001 = star004",
               "                  AND starent = stasent",
               "                  AND star001 = stas001",
               "                  AND starsite = stassite",   #add by geza 
               "                  AND stasent = rtdxent", 
               "                  AND stas003 = rtdx001",
               #150424-00021#1 Modify-S By Ken 150714
               #"                  AND star003 = rtdx031",
               "                  AND star003 = imaf153",
               #150424-00021#1 Modify-E By Ken 150714
               "                  AND starstus = 'Y'",
               "                  AND starsite = rtdxsite ", #add by geza  20150603
               #"                  AND '",g_pmda.pmdadocdt,"' BETWEEN stan017 AND stan018",   #160104-00014#1 20160104 mark by beckxie
               "                  AND '",g_pmda.pmdadocdt,"' BETWEEN stas018 AND stas019",    #160104-00014#1 20160104  add by beckxie
               #150424-00021#1 Modify-S By Ken 150714
               #"                  AND COALESCE(rtdx031,'-1') != '-1'))"
               "                  AND COALESCE(imaf153,'-1') != '-1'))" ,
               #150424-00021#1 Modify-E By Ken 150714
               "   AND ",g_where_sql
   DISPLAY 'apmt830_01_b_fill = ' ,l_sql
   PREPARE apmt830_b_fill_pre FROM l_sql
   DECLARE apmt830_b_fill_cs CURSOR FOR apmt830_b_fill_pre
   LET l_ac = 1
   FOREACH apmt830_b_fill_cs
      INTO g_pmeu_d[l_ac].sel,          g_pmeu_d[l_ac].pmeusite,     g_pmeu_d[l_ac].pmeu001,      g_pmeu_d[l_ac].pmeuseq,
           g_pmeu_d[l_ac].pmeu002,      g_pmeu_d[l_ac].pmeu003,      g_pmeu_d[l_ac].pmeu003_desc, g_pmeu_d[l_ac].pmeu003_desc_desc,
           g_pmeu_d[l_ac].pmeu004,      g_pmeu_d[l_ac].pmeu004_desc, g_pmeu_d[l_ac].pmeu005,      g_pmeu_d[l_ac].pmeu006,
           g_pmeu_d[l_ac].pmeu006_desc, g_pmeu_d[l_ac].pmeu007
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "Foreach apmt830_b_fill_cs"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
   END FOREACH
   
   CALL g_pmeu_d.deleteElement(g_pmeu_d.getLength())
   LET g_rec_b = l_ac - 1
   DISPLAY g_rec_b TO FORMONLY.cnt
END FUNCTION

################################################################################
# Descriptions...: 更新temp table
# Memo...........:
# Usage..........: CALL apmt830_01_upd_tmp()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/04/06 By pomelo
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt830_01_upd_tmp()

   IF g_pmeu_d[l_ac].sel = 'Y' THEN
      INSERT INTO apmt830_01_tmp(pmeusite, pmeu001, pmeuseq, pmeu002,
                                 pmeu003,  pmeu004, pmeu005, pmeu006,
                                 pmeu007)
         VALUES(g_pmeu_d[l_ac].pmeusite, g_pmeu_d[l_ac].pmeu001, g_pmeu_d[l_ac].pmeuseq, g_pmeu_d[l_ac].pmeu002,
                g_pmeu_d[l_ac].pmeu003,  g_pmeu_d[l_ac].pmeu004, g_pmeu_d[l_ac].pmeu005, g_pmeu_d[l_ac].pmeu006,
                g_pmeu_d[l_ac].pmeu007)
   ELSE
      DELETE FROM apmt830_01_tmp
       WHERE pmeusite = g_pmeu_d[l_ac].pmeusite
         AND pmeu001 = g_pmeu_d[l_ac].pmeu001
         AND pmeuseq = g_pmeu_d[l_ac].pmeuseq
   END IF

END FUNCTION

################################################################################
# Descriptions...: 準備產生要貨單單身所需要的SQL
# Memo...........:
# Usage..........: CALL apmt830_01_gen_detail_pre()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/04/06 By pomelo
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt830_01_gen_detail_pre()
DEFINE l_sql     STRING

   LET l_sql = "SELECT pmeusite, pmeu001, pmeuseq, pmeu002,",
               "       pmeu003,  pmeu004, pmeu005, pmeu006,",
               "       pmeu007",
               "  FROM apmt830_01_tmp"
   PREPARE apmt830_01_sel_pre FROM l_sql
   DECLARE apmt830_01_sel_cs CURSOR FOR apmt830_01_sel_pre
   
   #項次
   LET l_sql = "SELECT COALESCE(MAX(pmdbseq),0)+1",
               "  FROM pmdb_t",
               " WHERE pmdbent = ",g_enterprise,
               "   AND pmdbdocno = '",g_pmdadocno,"'"
   PREPARE apmt830_01_pmdbseq FROM l_sql
   
   #供應商
   LET l_sql = "SELECT imaf153",
               "  FROM imaf_t",
               " WHERE imafent = ",g_enterprise,
               #"   AND imafsite = 'ALL'", #150714 Mark
               "   AND imafsite = ? ",
               "   AND imaf001 = ?"
   PREPARE apmt830_01_imaf153 FROM l_sql
   
   #結算方式、採購員
   LET l_sql = "SELECT DISTINCT star006,stas009",
               "  FROM stan_t,star_t,stas_t",
               " WHERE starent = stasent",
               "   AND star001 = stas001",
               "   AND starsite = stassite",   #add by geza 
               "   AND stanent = starent",
               "   AND stan001 = star004",
               "   AND stanent = ",g_enterprise,
               "   AND starsite = ?", #add by geza  20150603
               "   AND stas003 = ?",
               "   AND star003 = ?",
               "   AND starstus = 'Y'",
               #"   AND '",g_pmda.pmdadocdt,"' BETWEEN stan017 AND stan018"   #160104-00014#1 20160104  mark by beckxie
               "   AND '",g_pmda.pmdadocdt,"' BETWEEN stas018 AND stas019"    #160104-00014#1 20160104   add by beckxie
   PREPARE apmt830_01_get_star FROM l_sql
   
   #採購方式
   LET l_sql = "SELECT rtdx027,rtdx003",
               "  FROM rtdx_t",
               " WHERE rtdxent = ",g_enterprise,
               "   AND rtdxsite = ?",
               "   AND rtdx001 = ?"
   PREPARE apmt830_01_get_rtdx FROM l_sql
   
   #160325-00039#1 Add By Ken 160329(S)
   #配送中心
   LET l_sql = "SELECT rtdx029 ",
               "  FROM rtdx_t ",
               " WHERE rtdxent = ",g_enterprise,
               "   AND rtdxsite = ?",
               "   AND rtdx001 = ?" 
   PREPARE apmt830_01_get_rtdx029 FROM l_sql 

   #採購中心
   LET l_sql = "SELECT rtdx028 ",
               "  FROM rtdx_t ",
               " WHERE rtdxent = ",g_enterprise,
               "   AND rtdxsite = ?",
               "   AND rtdx001 = ?" 
   PREPARE apmt830_01_get_rtdx028 FROM l_sql
   #160325-00039#1 Add By Ken 160329(E)
END FUNCTION

################################################################################
# Descriptions...: 依據所勾選的資料，產生要貨單單身資料
# Memo...........:
# Usage..........: CALL apmt830_01_gen_detail()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/04/06 By pomelo
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt830_01_gen_detail()
DEFINE l_success        LIKE type_t.num5
DEFINE l_i              LIKE type_t.num5
DEFINE l_pmeu           RECORD
       pmeusite         LIKE pmeu_t.pmeusite,    #要貨組織
       pmeu001          LIKE pmeu_t.pmeu001,     #要貨部門
       pmeuseq          LIKE pmeu_t.pmeuseq,     #項次
       pmeu002          LIKE pmeu_t.pmeu002,     #商品條碼
       pmeu003          LIKE pmeu_t.pmeu003,     #商品編號
       pmeu004          LIKE pmeu_t.pmeu004,     #要貨包裝單位
       pmeu005          LIKE pmeu_t.pmeu005,     #要貨包裝數量
       pmeu006          LIKE pmeu_t.pmeu006,     #要貨單位
       pmeu007          LIKE pmeu_t.pmeu007      #要貨數量
                        END RECORD
DEFINE l_pmdb           RECORD
       pmdbent          LIKE pmdb_t.pmdbent,     #企業編號
       pmdbsite         LIKE pmdb_t.pmdbsite,    #營運據點
       pmdbdocno        LIKE pmdb_t.pmdbdocno,   #請購單號
       pmdbseq          LIKE pmdb_t.pmdbseq,     #項次
       pmdb001          LIKE pmdb_t.pmdb001,     #來源單號
       pmdb002          LIKE pmdb_t.pmdb002,     #來源項次
       pmdb003          LIKE pmdb_t.pmdb003,     #來源項序
       pmdb004          LIKE pmdb_t.pmdb004,     #料件編號
       pmdb005          LIKE pmdb_t.pmdb005,     #產品特徵
       pmdb006          LIKE pmdb_t.pmdb006,     #需求數量
       pmdb007          LIKE pmdb_t.pmdb007,     #單位
       pmdb015          LIKE pmdb_t.pmdb015,     #供應商編號
       pmdb019          LIKE pmdb_t.pmdb019,     #參考單價
       pmdb020          LIKE pmdb_t.pmdb020,     #參考未稅金額
       pmdb021          LIKE pmdb_t.pmdb021,     #參考含稅金額
       pmdb030          LIKE pmdb_t.pmdb030,     #需求日期
       pmdb032          LIKE pmdb_t.pmdb032,     #行狀態
       pmdb033          LIKE pmdb_t.pmdb033,     #緊急度
       pmdb037          LIKE pmdb_t.pmdb037,     #收貨據點
       pmdb038          LIKE pmdb_t.pmdb038,     #收貨庫位
       pmdb039          LIKE pmdb_t.pmdb039,     #收貨儲位
       pmdb044          LIKE pmdb_t.pmdb044,     #納入MRP
       pmdb046          LIKE pmdb_t.pmdb046,     #費用部門
       pmdb048          LIKE pmdb_t.pmdb048,     #收貨時段
       pmdb049          LIKE pmdb_t.pmdb049,     #已轉採購量
       pmdb050          LIKE pmdb_t.pmdb050,     #備註
       pmdb051          LIKE pmdb_t.pmdb051,     #結案/留置理由
       pmdb200          LIKE pmdb_t.pmdb200,     #商品條碼
       pmdb201          LIKE pmdb_t.pmdb201,     #包裝單位
       pmdb202          LIKE pmdb_t.pmdb202,     #件裝數
       pmdb203          LIKE pmdb_t.pmdb203,     #配送中心
       pmdb204          LIKE pmdb_t.pmdb204,     #配送倉庫
       pmdb205          LIKE pmdb_t.pmdb205,     #採購中心
       pmdb206          LIKE pmdb_t.pmdb206,     #採購員
       pmdb207          LIKE pmdb_t.pmdb207,     #採購方式
       pmdb208          LIKE pmdb_t.pmdb208,     #經營方式
       pmdb209          LIKE pmdb_t.pmdb209,     #結算方式
       pmdb210          LIKE pmdb_t.pmdb210,     #促銷開始日
       pmdb211          LIKE pmdb_t.pmdb211,     #促銷結束日
       pmdb212          LIKE pmdb_t.pmdb212,     #要貨件數
       pmdb250          LIKE pmdb_t.pmdb250,     #合理庫存
       pmdb251          LIKE pmdb_t.pmdb251,     #最高庫存
       pmdb252          LIKE pmdb_t.pmdb252,     #現有庫存
       pmdb253          LIKE pmdb_t.pmdb253,     #入庫在途量
       pmdb254          LIKE pmdb_t.pmdb254,     #前一週銷量
       pmdb255          LIKE pmdb_t.pmdb255,     #前二週銷量
       pmdb256          LIKE pmdb_t.pmdb256,     #前三週銷量
       pmdb257          LIKE pmdb_t.pmdb257,     #前四周銷量
       pmdb258          LIKE pmdb_t.pmdb258,     #要貨在途量
       pmdb259          LIKE pmdb_t.pmdb259,     #周平均銷量
       pmdb260          LIKE pmdb_t.pmdb260      #收貨部門
                        END RECORD
DEFINE l_amount              LIKE inag_t.inag009     #数量 
#170116-00018#1 -s by 08172
DEFINE l_inaasite       LIKE inaa_t.inaasite
DEFINE l_inaa142        LIKE inaa_t.inaa142
DEFINE l_inaa010        LIKE inaa_t.inaa010
DEFINE l_sql            STRING
DEFINE l_sel_sql        STRING
DEFINE l_sql3           STRING
#170116-00018#1 -e by 08172
   LET l_success = TRUE
   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   #170116-00018#1 -s by 08172
   #抓取库位
   LET l_sel_sql = "SELECT UNIQUE inaasite, inaa001,inaa142,inaa010 " 
   LET l_sql3 = s_aint700_adbi261_sql('N','Y')  
   LET l_sql = l_sel_sql,l_sql3
   PREPARE apmt830_01_adbi261_sel_pr FROM l_sql
   DECLARE apmt830_01_adbi261_sel_cur SCROLL CURSOR FOR apmt830_01_adbi261_sel_pr
   #170116-00018#1 -e by 08172
   CALL apmt830_01_gen_detail_pre()
   
   FOREACH apmt830_01_sel_cs
      INTO l_pmeu.pmeusite, l_pmeu.pmeu001, l_pmeu.pmeuseq, l_pmeu.pmeu002,
           l_pmeu.pmeu003,  l_pmeu.pmeu004, l_pmeu.pmeu005, l_pmeu.pmeu006,
           l_pmeu.pmeu007
           
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "Foreach apmt830_01_sel_cs"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET l_success = FALSE
         EXIT FOREACH
      END IF
      
      LET l_pmdb.pmdbent   = g_enterprise       #企業編號
      
      #營運據點
      #單頭需求組織(pmda203)非空白時，Default = 需求組織(pmda203)
      IF NOT cl_null(g_pmda.pmda203) THEN
         LET l_pmdb.pmdbsite = g_pmda.pmda203
      ELSE
         #LET l_pmdb.pmdbsite = g_site           #151113-00003#11 151130 By pomelo mark
         LET l_pmdb.pmdbsite = g_pmda.pmdasite   #151113-00003#11 151130 By pomelo add
      END IF
      
      LET l_pmdb.pmdbdocno = g_pmdadocno        #請購單號
      
      #項次
      EXECUTE apmt830_01_pmdbseq INTO l_pmdb.pmdbseq
      LET l_pmdb.pmdb004   = l_pmeu.pmeu003     #料件編號
      LET l_pmdb.pmdb005   = ' '                #產品特徵
      LET l_pmdb.pmdb006   = l_pmeu.pmeu007     #需求數量
      LET l_pmdb.pmdb007   = l_pmeu.pmeu006     #單位
      
      #供應商編號
      EXECUTE apmt830_01_imaf153 USING l_pmdb.pmdbsite,l_pmdb.pmdb004
         INTO l_pmdb.pmdb015
      #商品編號的採購主要供應商不可為空！
      IF cl_null(l_pmdb.pmdb015) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apm-00846'
         LET g_errparam.extend = l_pmdb.pmdb004
         LET g_errparam.popup = TRUE
         CALL cl_err()
         CONTINUE FOREACH
      END IF
      
      LET l_pmdb.pmdb019   = 0                  #參考單價
      LET l_pmdb.pmdb020   = 0                  #參考未稅金額
      LET l_pmdb.pmdb021   = 0                  #參考含稅金額
      #LET l_pmdb.pmdb030   = g_pmda.pmdadocdt   #需求日期   #151113-00003#11 151130 By pomelo mark
      #151113-00003#11 151130 By pomelo add(S)
      #需求日期
      IF cl_null(g_pmda.pmda207) THEN
         LET l_pmdb.pmdb030   = g_pmda.pmdadocdt
      ELSE
         LET l_pmdb.pmdb030   = g_pmda.pmda207
      END IF
      #151113-00003#11 151130 By pomelo add(E)
      LET l_pmdb.pmdb032   = '1'                #行狀態
      LET l_pmdb.pmdb033   = '1'                #緊急度
      LET l_pmdb.pmdb037   = l_pmdb.pmdbsite    #收貨據點
      LET l_pmdb.pmdb038   = ''                 #收貨庫位
      LET l_pmdb.pmdb039   = ''                 #收貨儲位
      LET l_pmdb.pmdb044   = 'Y'                #納入MRP
      LET l_pmdb.pmdb046   = g_pmda.pmda003     #費用部門
      LET l_pmdb.pmdb048   = ''                 #收貨時段
      LET l_pmdb.pmdb049   = 0                  #已轉採購量
      LET l_pmdb.pmdb050   = ''                 #備註
      LET l_pmdb.pmdb051   = ''                 #結案/留置理由
      LET l_pmdb.pmdb200   = l_pmeu.pmeu002     #商品條碼
      LET l_pmdb.pmdb201   = l_pmeu.pmeu004     #包裝單位
      LET l_pmdb.pmdb202   = l_pmeu.pmeu005     #件裝數
      
      #配送中心
      #當單頭有指定配送中心時，單身配送中心預設為單頭配送中心
      IF NOT cl_null(g_pmda.pmda205) THEN
         LET l_pmdb.pmdb203 = g_pmda.pmda205
      END IF
      
      #配送倉庫
      #當單頭有指定配送倉時，單身等於單頭的配送倉且不可修改
      IF NOT cl_null(g_pmda.pmda206) THEN
         LET l_pmdb.pmdb204 = g_pmda.pmda206
      #170116-00018#1 -s by 08172
      ELSE
         OPEN apmt830_01_adbi261_sel_cur USING l_pmdb.pmdb203,l_pmdb.pmdb004,l_pmdb.pmdbsite
         FETCH FIRST apmt830_01_adbi261_sel_cur INTO l_inaasite,l_pmdb.pmdb204,l_inaa142,l_inaa010
         CLOSE apmt830_01_adbi261_sel_cur
      #170116-00018#1 -e by 08172
      END IF
      
      #採購中心
      #當單頭有指定採購中心時，單身採購中心預設為採購配送中心
      IF NOT cl_null(g_pmda.pmda204) THEN
         LET l_pmdb.pmdb205 = g_pmda.pmda204
      END IF
      
      #160325-00039#1 Add By Ken 160329(S)
      #單身配送中心取門店清單的配送中心
      IF cl_null(l_pmdb.pmdb203) THEN
         EXECUTE apmt830_01_get_rtdx029 USING l_pmdb.pmdbsite,l_pmdb.pmdb004
            INTO l_pmdb.pmdb203          
      END IF
      
      #單身採購中心取門店清單的採購中心
      IF cl_null(l_pmdb.pmdb205) THEN
         EXECUTE apmt830_01_get_rtdx028 USING l_pmdb.pmdbsite,l_pmdb.pmdb004
            INTO l_pmdb.pmdb205          
      END IF      
      
      #160325-00039#1 Add By Ken 160329(E)
      
      #結算方式、採購員
      EXECUTE apmt830_01_get_star USING l_pmeu.pmeusite,l_pmdb.pmdb004,l_pmdb.pmdb015
         INTO l_pmdb.pmdb209,l_pmdb.pmdb206
         
      #採購方式、經營方式
      EXECUTE apmt830_01_get_rtdx USING l_pmdb.pmdbsite,l_pmdb.pmdb004
         INTO l_pmdb.pmdb207,l_pmdb.pmdb208
      
      LET l_pmdb.pmdb210   = ''                 #促銷開始日
      LET l_pmdb.pmdb211   = ''                 #促銷結束日
      LET l_pmdb.pmdb212   = l_pmeu.pmeu007     #要貨件數
      LET l_pmdb.pmdb250   = 0                  #合理庫存
      LET l_pmdb.pmdb251   = 0                  #最高庫存
      
      #現有庫存
      CALL s_apmt840_sum_inag008(l_pmdb.pmdbsite,l_pmdb.pmdb004,l_pmdb.pmdb005) #150401-00005#3 sakura add pmdb005
         RETURNING l_pmdb.pmdb252
      
      #入庫在途量
      #CALL s_apmt840_sum_in_way(l_pmdb.pmdbsite,l_pmdb.pmdb200)               #150413-00018#1 sakura mark
      CALL s_apmt840_sum_in_way(l_pmdb.pmdbsite,l_pmdb.pmdb004,l_pmdb.pmdb005) #150413-00018#1 sakura add
         RETURNING l_pmdb.pmdb253
      
      #前一週銷量
      CALL s_daily_sale(l_pmdb.pmdbsite,g_pmda.pmdadocdt,1,7,l_pmdb.pmdb004,l_pmdb.pmdb005)
         RETURNING l_pmdb.pmdb254
      
      #前二週銷量
      CALL s_daily_sale(l_pmdb.pmdbsite,g_pmda.pmdadocdt,8,14,l_pmdb.pmdb004,l_pmdb.pmdb005)
         RETURNING l_pmdb.pmdb255
         
      #前三週銷量
      CALL s_daily_sale(l_pmdb.pmdbsite,g_pmda.pmdadocdt,15,21,l_pmdb.pmdb004,l_pmdb.pmdb005)
         RETURNING l_pmdb.pmdb256
         
      #前四周銷量
      CALL s_daily_sale(l_pmdb.pmdbsite,g_pmda.pmdadocdt,22,28,l_pmdb.pmdb004,l_pmdb.pmdb005)
         RETURNING l_pmdb.pmdb257
      
      #要貨在途量
      CALL s_apmt830_sum_pmdb258(l_pmdb.pmdbsite,l_pmdb.pmdb004,l_pmdb.pmdb005)
         RETURNING l_pmdb.pmdb258
      
      #週平均銷量
      LET l_pmdb.pmdb259 = (l_pmdb.pmdb254 + l_pmdb.pmdb255 + l_pmdb.pmdb256 + l_pmdb.pmdb257)/4
      
      LET l_pmdb.pmdb260   = g_pmda.pmda003     #收貨部門
            
      INSERT INTO pmdb_t(pmdbent, pmdbsite, pmdbdocno, pmdbseq,
                         pmdb001, pmdb002,  pmdb003,   pmdb004,
                         pmdb005, pmdb006,  pmdb007,   pmdb015,
                         pmdb019, pmdb020,  pmdb021,   pmdb030,
                         pmdb032, pmdb033,  pmdb037,   pmdb038,
                         pmdb039, pmdb044,  pmdb046,   pmdb048,
                         pmdb049, pmdb050,  pmdb051,   pmdb200,
                         pmdb201, pmdb202,  pmdb203,   pmdb204,
                         pmdb205, pmdb206,  pmdb207,   pmdb208,
                         pmdb209, pmdb210,  pmdb211,   pmdb212,
                         pmdb250, pmdb251,  pmdb252,   pmdb253,
                         pmdb254, pmdb255,  pmdb256,   pmdb257,
                         pmdb258, pmdb259,  pmdb260    ) 
         VALUES(l_pmdb.pmdbent, l_pmdb.pmdbsite, l_pmdb.pmdbdocno, l_pmdb.pmdbseq,
                l_pmdb.pmdb001, l_pmdb.pmdb002,  l_pmdb.pmdb003,   l_pmdb.pmdb004,
                l_pmdb.pmdb005, l_pmdb.pmdb006,  l_pmdb.pmdb007,   l_pmdb.pmdb015,
                l_pmdb.pmdb019, l_pmdb.pmdb020,  l_pmdb.pmdb021,   l_pmdb.pmdb030,
                l_pmdb.pmdb032, l_pmdb.pmdb033,  l_pmdb.pmdb037,   l_pmdb.pmdb038,
                l_pmdb.pmdb039, l_pmdb.pmdb044,  l_pmdb.pmdb046,   l_pmdb.pmdb048,
                l_pmdb.pmdb049, l_pmdb.pmdb050,  l_pmdb.pmdb051,   l_pmdb.pmdb200,
                l_pmdb.pmdb201, l_pmdb.pmdb202,  l_pmdb.pmdb203,   l_pmdb.pmdb204,
                l_pmdb.pmdb205, l_pmdb.pmdb206,  l_pmdb.pmdb207,   l_pmdb.pmdb208,
                l_pmdb.pmdb209, l_pmdb.pmdb210,  l_pmdb.pmdb211,   l_pmdb.pmdb212,
                l_pmdb.pmdb250, l_pmdb.pmdb251,  l_pmdb.pmdb252,   l_pmdb.pmdb253,
                l_pmdb.pmdb254, l_pmdb.pmdb255,  l_pmdb.pmdb256,   l_pmdb.pmdb257,
                l_pmdb.pmdb258, l_pmdb.pmdb259,  l_pmdb.pmdb260 ) 
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "Ins pmdb_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET l_success = FALSE
         EXIT FOREACH
      END IF
      INITIALIZE l_pmdb.* TO NULL
      INITIALIZE l_pmeu.* TO NULL
   END FOREACH
   
   IF l_success THEN
      CALL s_transaction_end('Y',0)
   ELSE
      CALL s_transaction_end('N',0)
   END IF
   CALL cl_err_collect_show()
END FUNCTION

 
{</section>}
 
