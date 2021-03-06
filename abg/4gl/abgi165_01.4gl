#該程式未解開Section, 採用最新樣板產出!
{<section id="abgi165_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2016-08-09 09:49:58), PR版次:0005(2017-01-24 17:21:10)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: abgi165_01
#+ Description: 批次產生預算料件
#+ Creator....: 06821(2016-08-08 11:51:35)
#+ Modifier...: 06821 -SD/PR- 06821
 
{</section>}
 
{<section id="abgi165_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#Memos
#161006-00005#43  2016/11/22  By 08732    組織類型與職能開窗調整
#161105-00004#3   2016/11/24  By Hans    2.批次產生也同時寫入一筆參考料件到對應料號
#161221-00034#1   2016/12/21  By 06821   abgi165_01寫入多語言調整
#170123-00045#2   2017/01/24  By 06821   SQL中撈取資料時使用 rownum 語法撰寫方式調整
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc" name="global.inc"

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_bgas_m        RECORD
       bgas002 LIKE type_t.chr500, 
   bgas005 LIKE type_t.chr10, 
   bgas004 LIKE type_t.chr10, 
   bgas003 LIKE bgas_t.bgas003, 
   bgas003_desc LIKE type_t.chr80
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_wc         STRING  
#end add-point
 
DEFINE g_bgas_m        type_g_bgas_m
 
   
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="abgi165_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION abgi165_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   
   #end add-point
   )
   #add-point:input段define name="input.define_customerization"
   
   #end add-point
   DEFINE l_ac_t          LIKE type_t.num10       #未取消的ARRAY CNT 
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num10
   DEFINE l_insert        LIKE type_t.num5
   DEFINE p_cmd           LIKE type_t.chr5
   #add-point:input段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   DEFINE l_n             LIKE type_t.num10
   DEFINE r_success       LIKE type_t.num5
   DEFINE r_bgas003       LIKE bgas_t.bgas003
   #161006-00005#43   add---s
   DEFINE g_wc_cs_comp    STRING   #在azzi800權限中的法人
   DEFINE  l_cnt_comp            LIKE type_t.num10
   DEFINE  l_sql                 STRING   
   #161006-00005#43   add---e
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_abgi165_01 WITH FORM cl_ap_formpath("abg","abgi165_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   CLEAR FORM
   WHENEVER ERROR CONTINUE
   
   INITIALIZE g_bgas_m.* TO NULL
   
   CALL cl_set_combo_scc('bgas005','1001')
   
   #161006-00005#43   add---s
   CALL s_fin_create_account_center_tmp()
   CALL s_fin_azzi800_sons_query(g_today)                      
   CALL s_fin_account_center_sons_str() RETURNING g_wc_cs_comp 
   CALL s_fin_get_wc_str(g_wc_cs_comp) RETURNING g_wc_cs_comp  
   #161006-00005#43   add---e
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_bgas_m.bgas003 ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgas003
            
            #add-point:AFTER FIELD bgas003 name="input.a.bgas003"
            LET g_bgas_m.bgas003_desc = ''
            DISPLAY BY NAME g_bgas_m.bgas003_desc
            IF NOT cl_null(g_bgas_m.bgas003) THEN
               IF NOT ap_chk_isExist(g_bgas_m.bgas003,"SELECT COUNT(*) FROM ooef_t WHERE ooefent ='" ||g_enterprise||"' AND ooef001 = ? ","aoo-00090",0 ) THEN
                  LET g_bgas_m.bgas003 = ''
                  CALL s_desc_get_department_desc(g_bgas_m.bgas003) RETURNING g_bgas_m.bgas003_desc
                  DISPLAY BY NAME g_bgas_m.bgas003_desc
                  NEXT FIELD bgas003
               END IF
               IF NOT ap_chk_isExist(g_bgas_m.bgas003,"SELECT COUNT(*) FROM ooef_t WHERE ooefent = '" ||g_enterprise||"' AND ooefstus = 'Y' AND ooef001 = ? ","sub-01302","aooi100") THEN
                  LET g_bgas_m.bgas003 = ''
                  CALL s_desc_get_department_desc(g_bgas_m.bgas003) RETURNING g_bgas_m.bgas003_desc
                  DISPLAY BY NAME g_bgas_m.bgas003_desc
                  NEXT FIELD bgas003
               END IF
               #161006-00005#43   add---s
               CALL s_fin_comp_chk(g_bgas_m.bgas003)  RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_bgas_m.bgas003 = ''
                  CALL s_desc_get_department_desc(g_bgas_m.bgas003) RETURNING g_bgas_m.bgas003_desc
                  DISPLAY BY NAME g_bgas_m.bgas003_desc
                  NEXT FIELD bgas003
               END IF
               
               #檢核法人是否有azzi800權限
               LET l_cnt_comp = 0                     
               LET l_sql = "SELECT COUNT(*) FROM ooef_t WHERE ooefent = ",g_enterprise," ",
                           "   AND ooef001 = '",g_bgas_m.bgas003,"' ",
                           "   AND ooef001 IN ",g_wc_cs_comp CLIPPED
               PREPARE sel_cnt_comp FROM l_sql
               EXECUTE sel_cnt_comp INTO l_cnt_comp
                  
               IF cl_null(l_cnt_comp)THEN LET l_cnt_comp = 0 END IF
               
               IF l_cnt_comp = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ais-00228'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_bgas_m.bgas003 = ''
                  CALL s_desc_get_department_desc(g_bgas_m.bgas003) RETURNING g_bgas_m.bgas003_desc
                  DISPLAY BY NAME g_bgas_m.bgas003_desc
                  NEXT FIELD bgas003
               END IF
               #161006-00005#43   add---e
            END IF
            CALL s_desc_get_department_desc(g_bgas_m.bgas003) RETURNING g_bgas_m.bgas003_desc
            DISPLAY BY NAME g_bgas_m.bgas003_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgas003
            #add-point:BEFORE FIELD bgas003 name="input.b.bgas003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgas003
            #add-point:ON CHANGE bgas003 name="input.g.bgas003"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.bgas003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgas003
            #add-point:ON ACTION controlp INFIELD bgas003 name="input.c.bgas003"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL   
            LET g_qryparam.state = 'i'  
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgas_m.bgas003        #給予default值
            #給予arg
            #LET g_qryparam.where = " ooef201 = 'Y' "                              #161006-00005#43   mark
            LET g_qryparam.where = " ooef003 = 'Y' AND ooef001 IN ",g_wc_cs_comp   #161006-00005#43   add
            CALL q_ooef001()                                  #呼叫開窗
            LET g_bgas_m.bgas003 = g_qryparam.return1         #將開窗取得的值回傳到變數
            CALL s_desc_get_department_desc(g_bgas_m.bgas003) RETURNING g_bgas_m.bgas003_desc
            DISPLAY BY NAME g_bgas_m.bgas003,g_bgas_m.bgas003_desc
            NEXT FIELD bgas003  
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            
            #end add-point
            
      END INPUT
    
      #add-point:自定義input name="input.more_input"
      CONSTRUCT BY NAME g_wc ON bgas002,bgas005,bgas004
      
         BEFORE CONSTRUCT
         
         ON ACTION controlp INFIELD bgas002
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgas002  #顯示到畫面上
            NEXT FIELD bgas002                     #返回原欄位


         ON ACTION controlp INFIELD bgas005
       
         ON ACTION controlp INFIELD bgas004
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imca001_1()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgas004  #顯示到畫面上
            NEXT FIELD bgas004                     #返回原欄位

      END CONSTRUCT
      #end add-point
    
      #公用action
      ON ACTION accept
         ACCEPT DIALOG
        
      ON ACTION cancel
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
   CLOSE WINDOW w_abgi165_01 
   
   #add-point:input段after input name="input.post_input"
   LET r_success = TRUE
   LET r_bgas003 = ''
   
   CALL cl_err_collect_init()
   IF INT_FLAG THEN
      LET r_success= FALSE
      LET INT_FLAG = 0
   ELSE
      CALL abgi165_01_ins_bgas() RETURNING g_sub_success
      IF NOT g_sub_success THEN
         LET r_success= FALSE
      ELSE
         LET r_bgas003 = g_bgas_m.bgas003
      END IF
   END IF
   CALL cl_err_collect_show()
   
   RETURN r_success,r_bgas003 
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="abgi165_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="abgi165_01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 寫入預算料件
# Memo...........:
# Usage..........: CALL abgi165_01_ins_bgas()
# Date & Author..: 160808 By 06821
# Modify.........:
################################################################################
PRIVATE FUNCTION abgi165_01_ins_bgas()
DEFINE ld_date       DATETIME YEAR TO SECOND
DEFINE l_sql         STRING
DEFINE l_sql1        STRING         
DEFINE l_cnt         LIKE type_t.num10
DEFINE l_cntdo       LIKE type_t.num10        #實際執行筆數
DEFINE l_bgas        RECORD                   #主table
         bgasent	   LIKE bgas_t.bgasent,	    #企業編號
         bgas001	   LIKE bgas_t.bgas001,	    #預算料號
         bgas002	   LIKE bgas_t.bgas002,	    #參考料號
         bgas003	   LIKE bgas_t.bgas003,	    #進銷存/成本參考據點
         bgas004	   LIKE bgas_t.bgas004,	    #主分群碼
         bgas005	   LIKE bgas_t.bgas005,	    #料件類別
         bgas006	   LIKE bgas_t.bgas006,	    #產品特徵組別
         bgas008	   LIKE bgas_t.bgas008,	    #基礎單位
         bgas009     LIKE bgas_t.bgas009,     #161105-00004#3
         bgas010     LIKE bgas_t.bgas010,     #161105-00004#3
         bgas110	   LIKE bgas_t.bgas110,	    #銷售分群
         bgas111	   LIKE bgas_t.bgas111,	    #銷售單位
         bgas112	   LIKE bgas_t.bgas112,	    #主要客戶
         bgas113	   LIKE bgas_t.bgas113,	    #銷售稅別
         bgas114	   LIKE bgas_t.bgas114,	    #銷售幣別
         bgas115	   LIKE bgas_t.bgas115,	    #標準售價
         bgas210	   LIKE bgas_t.bgas210,	    #採購分群
         bgas211	   LIKE bgas_t.bgas211,	    #採購單位
         bgas212	   LIKE bgas_t.bgas212,	    #主供應商
         bgas213	   LIKE bgas_t.bgas213,	    #採購稅別
         bgas214	   LIKE bgas_t.bgas214,	    #標準採購幣別
         bgas215	   LIKE bgas_t.bgas215,	    #標準採購單價
         bgas216	   LIKE bgas_t.bgas216,	    #最小採購量
         bgas217	   LIKE bgas_t.bgas217,	    #M件採購比率
         bgas218	   LIKE bgas_t.bgas218,	    #內採比率
         bgas219	   LIKE bgas_t.bgas219,	    #採購損耗率
         bgas310	   LIKE bgas_t.bgas310,	    #生產單位
         bgas311	   LIKE bgas_t.bgas311,	    #庫存單位
         bgas312	   LIKE bgas_t.bgas312,	    #發料單位
         bgas313	   LIKE bgas_t.bgas313,	    #安全庫存量
         bgas314	   LIKE bgas_t.bgas314,	    #生產提前比率
         bgas315	   LIKE bgas_t.bgas315,	    #生產損耗率
         bgas410	   LIKE bgas_t.bgas410,	    #成本分群
         bgas411	   LIKE bgas_t.bgas411,	    #預計成本階數
         bgas412	   LIKE bgas_t.bgas412,	    #低階碼
         bgas413	   LIKE bgas_t.bgas413,	    #成本幣別
         bgas414	   LIKE bgas_t.bgas414,	    #標準工時
         bgas415	   LIKE bgas_t.bgas415,	    #標準機時
         bgas416	   LIKE bgas_t.bgas416,	    #標準單位材料成本
         bgas417	   LIKE bgas_t.bgas417,	    #標準單位人工成本
         bgas418	   LIKE bgas_t.bgas418,	    #標準單位委外加工費
         bgas419	   LIKE bgas_t.bgas419,	    #標準單位製造費用一
         bgas420	   LIKE bgas_t.bgas420,	    #標準單位製造費用二
         bgas421	   LIKE bgas_t.bgas421,	    #標準單位製造費用三
         bgas422	   LIKE bgas_t.bgas422,	    #標準單位製造費用四
         bgas423	   LIKE bgas_t.bgas423,	    #標準單位製造費用五
         bgasstus	   LIKE bgas_t.bgasstus,    #狀態碼
         bgasownid   LIKE bgas_t.bgasownid,   #資料所有者
         bgasowndp   LIKE bgas_t.bgasowndp,   #資料所屬部門
         bgascrtid   LIKE bgas_t.bgascrtid,   #資料建立者
         bgascrtdp   LIKE bgas_t.bgascrtdp,   #資料建立部門
         bgascrtdt   LIKE bgas_t.bgascrtdt,   #資料創建日
         bgasmodid   LIKE bgas_t.bgasmodid,   #資料修改者
         bgasmoddt   LIKE bgas_t.bgasmoddt    #最近修改日
                     END RECORD                                     
DEFINE l_imaf        RECORD                   #來源table
         imaa001     LIKE imaa_t.imaa001,     #料件編號(imaa_t)
         imaa003     LIKE imaa_t.imaa003,     #主分群碼
         imaa004     LIKE imaa_t.imaa004,     #料件類別
         imaa005     LIKE imaa_t.imaa005,     #特徵組別
         imaa006     LIKE imaa_t.imaa006,     #基礎單位
         imaa009     LIKE imaa_t.imaa009,     #161105-00004#3
         imaa126     LIKE imaa_t.imaa126,     #161105-00004#3
         imaf111     LIKE imaf_t.imaf111,     #銷售分群(imaf_t)
         imaf112     LIKE imaf_t.imaf112,     #銷售單位
         imaf017     LIKE imaf_t.imaf017,     #銷售稅別
         imaf141     LIKE imaf_t.imaf141,     #採購分群
         imaf143     LIKE imaf_t.imaf143,     #採購單位
         imaf153     LIKE imaf_t.imaf153,     #主供應商
         imaf146     LIKE imaf_t.imaf146,     #最小採購量
         imaf164     LIKE imaf_t.imaf164,     #採購損耗率
         imaf053     LIKE imaf_t.imaf053,     #庫存單位
         imaf026     LIKE imaf_t.imaf026      #安全庫存量         
                     END RECORD                                     
DEFINE l_ooef016     LIKE ooef_t.ooef016
DEFINE l_ooef017     LIKE ooef_t.ooef017
DEFINE r_success     LIKE type_t.num5

   LET r_success = TRUE
   WHENEVER ERROR CONTINUE
   
   IF cl_null(g_wc) THEN 
      LET g_wc = " 1=1"  
   ELSE
      LET g_wc = cl_replace_str(g_wc,"bgas002","imaa001")  #料件編號
      LET g_wc = cl_replace_str(g_wc,"bgas005","imaa004")  #料件類別
      LET g_wc = cl_replace_str(g_wc,"bgas004","imaa003")  #主分群碼
   END IF
   
   LET ld_date = cl_get_current()  
   LET l_cntdo = 0

   LET l_ooef016 = ''
   LET l_ooef017 = ''
   SELECT ooef016,ooef017 INTO l_ooef016,l_ooef017
     FROM ooef_t
    WHERE ooefent = g_enterprise AND ooef001 = g_bgas_m.bgas003

   #檢查若已有資料存在,是否重新產生_是:刪除後產生 / 否:取消執行
   LET l_cnt = 0
   LET l_sql = " SELECT COUNT(*) ",
               "   FROM bgas_t  ",
               "  WHERE bgasent = ",g_enterprise,
               "    AND bgas003 = '",g_bgas_m.bgas003,"' ",
               "    AND bgas001 IN (SELECT DISTINCT imaf001 FROM imaf_t,imaa_t   ",
               "                     WHERE imafent = ",g_enterprise," AND imafsite = '",g_bgas_m.bgas003,"' ",
               "                       AND ",g_wc," AND imafent = imaaent AND imaf001 = imaa001 ) "
   DECLARE abgi165_01_sqlcnt CURSOR FROM l_sql
   EXECUTE abgi165_01_sqlcnt INTO l_cnt

   IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
   
   IF l_cnt > 0 THEN
      IF NOT cl_ask_confirm("ais-00196") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF 

   #取得參考料件說明 
   #LET l_sql1 = " INSERT INTO bgasl_t ",                                                       #161221-00034#1 mark
   LET l_sql1 = " INSERT INTO bgasl_t(bgaslent,bgasl001,bgasl002,bgasl003,bgasl004,bgasl005) ", #161221-00034#1 add
                " SELECT imaalent,imaal001,imaal002,imaal003,imaal004,imaal005 ",
                "   FROM imaal_t ",
                "  WHERE imaalent ='",g_enterprise,"'",
                "    AND imaal001 = ? "  #參考料件
   DECLARE abgi165_01_imaal_c CURSOR FROM l_sql1
 
   #撈出據點級料件資訊
   INITIALIZE l_imaf.* TO NULL
   LET l_sql = " SELECT DISTINCT imaa001,imaa003,imaa004,imaa005,imaa006, ",
               "                 imaa009,imaa126,                         ",
               "                 imaf111,imaf112,imaf017,imaf141,imaf143, ",
               "                 imaf153,imaf146,imaf164,imaf053,imaf026 ",
               "   FROM imaf_t,imaa_t ",
               "  WHERE imafent = ",g_enterprise,
               "    AND imafsite = '",g_bgas_m.bgas003,"' ",
               "    AND imafent = imaaent AND imaf001 = imaa001 ",
               "    AND ",g_wc,               
               "  ORDER BY imaa001 "
               
   PREPARE abgi165_01_p FROM l_sql
   DECLARE abgi165_01_c CURSOR FOR abgi165_01_p
   FOREACH abgi165_01_c INTO l_imaf.*
      
      #預算料件主檔_因可重覆執行,寫入前先刪除資料
      DELETE FROM bgas_t 
       WHERE bgasent = g_enterprise 
         AND bgas001 = l_imaf.imaa001
     
      #預算料號對應檔_因可重覆執行,寫入前先刪除資料
      DELETE FROM bgat_t 
       WHERE bgatent = g_enterprise 
         AND bgat001 = l_imaf.imaa001
     
      INITIALIZE l_bgas.* TO NULL
      LET l_bgas.bgas009   = l_imaf.imaa009 #161105-00004#3
      LET l_bgas.bgas010   = l_imaf.imaa126 #161105-00004#3
      LET l_bgas.bgasent	= g_enterprise
      LET l_bgas.bgas001	= l_imaf.imaa001
      LET l_bgas.bgas002	= l_imaf.imaa001
      LET l_bgas.bgas003	= g_bgas_m.bgas003
      LET l_bgas.bgas004	= l_imaf.imaa003
      LET l_bgas.bgas005	= l_imaf.imaa004
      LET l_bgas.bgas006	= l_imaf.imaa005
      LET l_bgas.bgas008	= l_imaf.imaa006
      LET l_bgas.bgas110	= l_imaf.imaf111
      LET l_bgas.bgas111	= l_imaf.imaf112
      LET l_bgas.bgas112	= ''
      LET l_bgas.bgas113	= l_imaf.imaf017
      LET l_bgas.bgas114	= l_ooef016
      
      #標準售價/採購單價
      SELECT imai223,imai023 INTO l_bgas.bgas115,l_bgas.bgas215
        FROM imai_t
       WHERE imaient = g_enterprise AND imaisite = l_bgas.bgas003 AND imai001 = l_bgas.bgas001
       
      LET l_bgas.bgas210	= l_imaf.imaf141
      LET l_bgas.bgas211	= l_imaf.imaf143
      LET l_bgas.bgas212	= l_imaf.imaf153
      LET l_bgas.bgas213	= l_imaf.imaf017
      LET l_bgas.bgas214	= l_ooef016
      LET l_bgas.bgas216	= l_imaf.imaf146
      LET l_bgas.bgas217	= 0
      LET l_bgas.bgas218	= 0
      LET l_bgas.bgas219	= l_imaf.imaf164
      
      #生產單位/發料單位/生產損耗率
      SELECT imae016,imae081,imae015 INTO l_bgas.bgas310,l_bgas.bgas312,l_bgas.bgas315
        FROM imae_t
       WHERE imaeent = g_enterprise AND imaesite = l_bgas.bgas003 AND imae001 = l_bgas.bgas001
      
      LET l_bgas.bgas311	= l_imaf.imaf053
      LET l_bgas.bgas313	= l_imaf.imaf026
      LET l_bgas.bgas314	= 0
      
      #成本分群/標準單位工時/標準單位機時
      SELECT imag011,imag016,imag017 INTO l_bgas.bgas410,l_bgas.bgas414,l_bgas.bgas415
        FROM imag_t
       WHERE imagent = g_enterprise AND imagsite = l_bgas.bgas003 AND imag001 = l_bgas.bgas001 
      
      #預計成本階數/低階碼
      #170123-00045#2 --s mark
      #SELECT xcbb006,xcbb007 INTO l_bgas.bgas411,l_bgas.bgas412
      #  FROM xcbb_t
      # WHERE xcbbent = g_enterprise 
      #   AND xcbbcomp = l_ooef017
      #   AND xcbb001 = (SELECT MAX(xcbb001) FROM xcbb_t 
      #                   WHERE xcbbent = g_enterprise AND xcbb003 = l_bgas.bgas001 AND xcbbcomp = l_ooef017)
      #   AND xcbb002 = (SELECT MAX(xcbb002) FROM xcbb_t 
      #                   WHERE xcbbent = g_enterprise AND xcbb003 = l_bgas.bgas001 AND xcbbcomp = l_ooef017 
      #                     AND xcbb001 = (SELECT MAX(xcbb001) FROM xcbb_t 
      #                                     WHERE xcbbent = g_enterprise AND xcbb003 = l_bgas.bgas001 
      #                                       AND xcbbcomp = l_ooef017))
      #   AND xcbb003 = l_bgas.bgas001 AND rownum = '1'
      #170123-00045#2 --e mark
      
      #170123-00045#2 --s add
      LET l_sql = " SELECT xcbb006,xcbb007 ",
                  "   FROM xcbb_t ",
                  "  WHERE xcbbent = ",g_enterprise,"   ",
                  "    AND xcbbcomp = '",l_ooef017,"' ",
                  "    AND xcbb001 = (SELECT MAX(xcbb001) FROM xcbb_t  ",
                  "                    WHERE xcbbent = ",g_enterprise," AND xcbb003 = '",l_bgas.bgas001,"' AND xcbbcomp = '",l_ooef017,"') ",
                  "    AND xcbb002 = (SELECT MAX(xcbb002) FROM xcbb_t  ",
                  "                    WHERE xcbbent = ",g_enterprise," AND xcbb003 = '",l_bgas.bgas001,"' AND xcbbcomp = '",l_ooef017,"'  ",
                  "                      AND xcbb001 = (SELECT MAX(xcbb001) FROM xcbb_t  ",
                  "                                      WHERE xcbbent = ",g_enterprise," AND xcbb003 = '",l_bgas.bgas001,"' ",
                  "                                        AND xcbbcomp = '",l_ooef017,"')) ",
                  "    AND xcbb003 = '",l_bgas.bgas001,"'   "
      PREPARE abgi165_01_xcbb_p FROM l_sql
      DECLARE abgi165_01_xcbb_c SCROLL CURSOR FOR abgi165_01_xcbb_p
      OPEN abgi165_01_xcbb_c
      FETCH FIRST abgi165_01_xcbb_c INTO l_bgas.bgas411,l_bgas.bgas412
      CLOSE abgi165_01_xcbb_c        
      #170123-00045#2 --e add       
      
      LET l_bgas.bgas413	= l_ooef016
      
      #單位成本-材料/單位成本-人工/單位成本-委外/單位成本-制費一/
      #單位成本-制費二/單位成本-制費三/單位成本-制費四/單位成本-制費五
      SELECT xcag102a,xcag102b,xcag102c,xcag102d,
             xcag102e,xcag102f,xcag102g,xcag102h
        INTO l_bgas.bgas416,l_bgas.bgas417,l_bgas.bgas418,l_bgas.bgas419,
             l_bgas.bgas420,l_bgas.bgas421,l_bgas.bgas422,l_bgas.bgas423
        FROM xcag_t
       WHERE xcagent = g_enterprise AND xcagsite = l_bgas.bgas003 
         AND xcag001 = l_bgas.bgas410
         AND xcag002 <= g_today
         AND (xcag003 IS NULL OR xcag003 >= g_today)
         AND xcag004 = l_bgas.bgas001
      
      LET l_bgas.bgasstus	= 'Y'
      LET l_bgas.bgasownid = g_user
      LET l_bgas.bgasowndp = g_dept
      LET l_bgas.bgascrtid = g_user
      LET l_bgas.bgascrtdp = g_dept
      LET l_bgas.bgascrtdt = ld_date
      LET l_bgas.bgasmodid = ''
      LET l_bgas.bgasmoddt = ''
      
      IF cl_null(l_bgas.bgas115) THEN LET l_bgas.bgas115 = "0" END IF
      IF cl_null(l_bgas.bgas215) THEN LET l_bgas.bgas215 = "0" END IF
      IF cl_null(l_bgas.bgas216) THEN LET l_bgas.bgas216 = "0" END IF
      IF cl_null(l_bgas.bgas217) THEN LET l_bgas.bgas217 = "0" END IF
      IF cl_null(l_bgas.bgas218) THEN LET l_bgas.bgas218 = "0" END IF
      IF cl_null(l_bgas.bgas219) THEN LET l_bgas.bgas219 = "0" END IF
      IF cl_null(l_bgas.bgas313) THEN LET l_bgas.bgas313 = "0" END IF
      IF cl_null(l_bgas.bgas314) THEN LET l_bgas.bgas314 = "0" END IF
      IF cl_null(l_bgas.bgas315) THEN LET l_bgas.bgas315 = "0" END IF
      IF cl_null(l_bgas.bgas411) THEN LET l_bgas.bgas411 = "0" END IF
      IF cl_null(l_bgas.bgas412) THEN LET l_bgas.bgas412 = "0" END IF
      IF cl_null(l_bgas.bgas414) THEN LET l_bgas.bgas414 = "0" END IF
      IF cl_null(l_bgas.bgas415) THEN LET l_bgas.bgas415 = "0" END IF
      IF cl_null(l_bgas.bgas416) THEN LET l_bgas.bgas416 = "0" END IF
      IF cl_null(l_bgas.bgas417) THEN LET l_bgas.bgas417 = "0" END IF
      IF cl_null(l_bgas.bgas418) THEN LET l_bgas.bgas418 = "0" END IF
      IF cl_null(l_bgas.bgas419) THEN LET l_bgas.bgas419 = "0" END IF
      IF cl_null(l_bgas.bgas420) THEN LET l_bgas.bgas420 = "0" END IF
      IF cl_null(l_bgas.bgas421) THEN LET l_bgas.bgas421 = "0" END IF
      IF cl_null(l_bgas.bgas422) THEN LET l_bgas.bgas422 = "0" END IF
      IF cl_null(l_bgas.bgas423) THEN LET l_bgas.bgas423 = "0" END IF
      
      #寫入bgas_t 
      INSERT INTO bgas_t (bgasent,bgas001,bgas002,bgas003,bgas004,	 
                          bgas005,bgas006,bgas008,bgas009,bgas010, #161105-00004#3 add bgas009, bgas010
                          bgas110,bgas111,	                      #161105-00004#3
                          bgas112,bgas113,bgas114,bgas115,bgas210,	 
                          bgas211,bgas212,bgas213,bgas214,bgas215, 
                          bgas216,bgas217,bgas218,bgas219,bgas310,
                          bgas311,bgas312,bgas313,bgas314,bgas315,	 
                          bgas410,bgas411,bgas412,bgas413,bgas414,	 
                          bgas415,bgas416,bgas417,bgas418,bgas419,	 
                          bgas420,bgas421,bgas422,bgas423,bgasstus, 
                          bgasownid,bgasowndp,bgascrtid,bgascrtdp,bgascrtdt,
                          bgasmodid,bgasmoddt)
                  VALUES (l_bgas.*)                                                   
                         
      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = "ins_bgas_wrong"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      
      #刪除bgasl 原多語言
      DELETE FROM bgasl_t 
       WHERE bgaslent = g_enterprise
         AND bgasl001 = l_imaf.imaa001
      
      #一併寫入多語言
      EXECUTE abgi165_01_imaal_c USING l_imaf.imaa001

      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = "ins_bgasl_wrong"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      #161105-00004#3 ---s---
      IF NOT cl_null(l_bgas.bgas002) THEN
         INSERT INTO bgat_t(bgatent,bgat001,bgat002) 
              VALUES(g_enterprise,l_bgas.bgas001,l_bgas.bgas002)
         IF SQLCA.SQLcode  THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.extend = "ins_bgas_wrong"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            EXIT FOREACH
         END IF
      END IF
      #161105-00004#3 ---e---
      LET l_cntdo = l_cntdo +1
   END FOREACH
   
   IF l_cntdo <= 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00230'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
   END IF
   
   RETURN r_success
END FUNCTION

 
{</section>}
 
