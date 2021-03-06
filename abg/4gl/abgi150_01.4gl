#該程式未解開Section, 採用最新樣板產出!
{<section id="abgi150_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2016-10-07 18:05:55), PR版次:0002(2016-11-14 14:40:56)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: abgi150_01
#+ Description: 整批產生
#+ Creator....: 06821(2016-07-29 18:19:52)
#+ Modifier...: 06821 -SD/PR- 05016
 
{</section>}
 
{<section id="abgi150_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#Memos
#161105-00004#1    2016/11/09  by Hans  客戶/供應商分類修改
#161114            2016/11/14  By 06821 參考據點帶對象資訊時不限制g_site
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
PRIVATE type type_g_bgap_m        RECORD
       l_comp_chk LIKE type_t.chr1
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_wc            STRING     #預算交易對象
DEFINE g_wc2           STRING     #交易對象類型/企業內關係人/法人類型
DEFINE g_wc_return     STRING     #取預算交易對象
#end add-point
 
DEFINE g_bgap_m        type_g_bgap_m
 
   
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="abgi150_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION abgi150_01(--)
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
   DEFINE r_success       LIKE type_t.num5
   DEFINE r_bgap001_wc    STRING
   DEFINE l_cnt           LIKE type_t.num10
   DEFINE l_sql           STRING
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_abgi150_01 WITH FORM cl_ap_formpath("abg","abgi150_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   CLEAR FORM
   WHENEVER ERROR CONTINUE
   
   INITIALIZE g_bgap_m.* TO NULL
   
   CALL cl_set_combo_scc('pmaa002','2014')      #交易對象類型
   CALL cl_set_combo_scc('pmaa004','2015')      #法人類型
   
   #預設值
   LET g_bgap_m.l_comp_chk = 'Y'
   
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_bgap_m.l_comp_chk ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_comp_chk
            #add-point:BEFORE FIELD l_comp_chk name="input.b.l_comp_chk"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_comp_chk
            
            #add-point:AFTER FIELD l_comp_chk name="input.a.l_comp_chk"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_comp_chk
            #add-point:ON CHANGE l_comp_chk name="input.g.l_comp_chk"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.l_comp_chk
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_comp_chk
            #add-point:ON ACTION controlp INFIELD l_comp_chk name="input.c.l_comp_chk"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            
            #end add-point
            
      END INPUT
    
      #add-point:自定義input name="input.more_input"
      CONSTRUCT g_wc ON pmaa001 FROM pmaa001
           
         ON ACTION controlp INFIELD pmaa001
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL   
            LET g_qryparam.state = 'c'       
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " pmaastus = 'Y' "
            CALL q_pmaa001_4()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmaa001  #顯示到畫面上
            NEXT FIELD pmaa001                     #返回原欄位
            
      END CONSTRUCT
      
      CONSTRUCT g_wc2 ON pmaa002,pmaa047,pmaa004 FROM pmaa002,pmaa047,pmaa004
      
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
   CLOSE WINDOW w_abgi150_01 
   
   #add-point:input段after input name="input.post_input"
   LET r_success = TRUE
   LET r_bgap001_wc = ''
   LET g_wc_return = ''

   IF cl_null(g_wc) THEN LET g_wc = " 1=1" END IF
   IF cl_null(g_wc2) THEN LET g_wc2 = " 1=1" END IF
   
   LET g_wc_return = cl_replace_str(g_wc,'pmaa001','bgap001')
   CALL cl_err_collect_init()
   
   IF INT_FLAG THEN
      LET r_success= FALSE
      LET INT_FLAG = 0
   ELSE
      #確認資料無重複
      LET l_cnt = 0
      LET l_sql = " SELECT COUNT(1) FROM bgap_t  ",
                  "  WHERE bgapent = '",g_enterprise,"' ",
                  "    AND ",g_wc_return CLIPPED

      PREPARE cnt_01_p FROM l_sql
      EXECUTE cnt_01_p INTO l_cnt 
      
      IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
      
      IF l_cnt > 0 THEN
         IF NOT cl_ask_confirm("anm-00213") THEN
            LET r_success = FALSE
            LET r_bgap001_wc = ''
            CALL cl_err_collect_show()
            RETURN r_success,r_bgap001_wc 
         END IF 
      END IF
      CALL abgi150_01_ins_bgap() RETURNING g_sub_success
      IF NOT g_sub_success THEN
         LET r_success = FALSE
      ELSE
         LET r_bgap001_wc = g_wc_return
      END IF
   END IF
   
   CALL cl_err_collect_show()
   RETURN r_success,r_bgap001_wc 
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="abgi150_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="abgi150_01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 寫入單頭檔bgap_t
# Memo...........:
# Usage..........: CALL abgi150_01_ins_bgap()
# Date & Author..: 160729 By 06821
# Modify.........:
################################################################################
PRIVATE FUNCTION abgi150_01_ins_bgap()
DEFINE l_date          LIKE bgap_t.bgapmoddt
DEFINE l_sql           STRING
DEFINE l_cnt           LIKE type_t.num10  
DEFINE l_pmaa001       LIKE pmaa_t.pmaa001
DEFINE l_pmaa002       LIKE pmaa_t.pmaa002
DEFINE l_pmaa047       LIKE pmaa_t.pmaa047
DEFINE l_pmaa004       LIKE pmaa_t.pmaa004
DEFINE l_wc1           STRING
DEFINE l_wc2           STRING  
DEFINE r_success       LIKE type_t.num5

   LET r_success = TRUE
   LET l_wc1 = ''
   LET l_wc2 = ''  
   
   LET l_date = cl_get_current()
   
   LET l_wc1 = cl_replace_str(g_wc,'pmaa001','bgaq001')
   LET l_wc2 = cl_replace_str(g_wc,'pmaa001','bgar001')
   
   #先刪除後再寫入---------------------------------
   #bgap_t(單頭)
   LET l_sql = " DELETE FROM bgap_t  ",
               "  WHERE bgapent = '",g_enterprise,"' ",
               "    AND ",g_wc_return CLIPPED
   PREPARE del_bgap FROM l_sql
   EXECUTE del_bgap 

   #bgaq_t(單身)
   LET l_sql = " DELETE FROM bgaq_t  ",
               "  WHERE bgaqent = '",g_enterprise,"' ",
               "    AND ",l_wc1 CLIPPED
   PREPARE del_bgaq FROM l_sql
   EXECUTE del_bgaq 
   
   #先bgar_t(單身)
   LET l_sql = " DELETE FROM bgar_t  ",
               "  WHERE bgarent = '",g_enterprise,"' ",
               "    AND ",l_wc2 CLIPPED
   PREPARE del_bgar FROM l_sql
   EXECUTE del_bgar 

   #------------------------------------------------
   
   #寫入參考交易對象說明
   LET l_sql = " INSERT INTO bgapl_t ",
               " SELECT pmaalent,pmaal001,pmaal002,pmaal003,pmaal005,pmaal004 ",
               "   FROM pmaal_t ",
               "  WHERE pmaalent ='",g_enterprise,"'",
               "    AND pmaal001 = ? "
   PREPARE bgapl_t_p FROM l_sql
   
   #寫入bgap_t單頭-----------------------------------
   #單頭來源pmaa_t
   LET l_pmaa001 = ''
   LET l_pmaa002 = ''
   LET l_pmaa047 = ''
   LET l_pmaa004 = ''
   LET l_sql = " SELECT UNIQUE pmaa001,pmaa002,pmaa047,pmaa004 FROM pmaa_t ",
               "  WHERE pmaaent = '",g_enterprise,"' ",
               "    AND ",g_wc CLIPPED,
               "    AND ",g_wc2 CLIPPED,
               "    AND pmaastus = 'Y' "               
               
   PREPARE sel_01_pmaap FROM l_sql
   DECLARE sel_01_pmaac CURSOR FOR sel_01_pmaap   
   FOREACH sel_01_pmaac INTO l_pmaa001,l_pmaa002,l_pmaa047,l_pmaa004
   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = 'Foreach:sel_01_pmaac' 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
   
      #寫入單頭
      INSERT INTO bgap_t (bgapent,bgap001,bgap002,bgap003,bgap004,bgap005,bgapstus,bgapownid, 
                          bgapowndp,bgapcrtid,bgapcrtdp,bgapcrtdt,bgapmodid,bgapmoddt)
                  VALUES (g_enterprise,l_pmaa001,l_pmaa002,l_pmaa001,l_pmaa047,l_pmaa004,'N',g_user,
                          g_dept,g_user,g_dept,l_date,'','') 
      
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = "ins bgap_t_erro:",l_pmaa001
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         CONTINUE FOREACH
      END IF 
      
      #bgapl_t(單頭)--多語言處理
      DELETE FROM bgapl_t WHERE bgaplent = g_enterprise AND bgapl001 = l_pmaa001
      EXECUTE bgapl_t_p USING l_pmaa001
      
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = "ins bgapl_t_erro:",l_pmaa001
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         CONTINUE FOREACH
      END IF
      
      #寫入單身
      CALL abgi150_01_ins_bgaq(l_pmaa001,l_pmaa002)RETURNING g_sub_success
      IF NOT g_sub_success THEN
         LET r_success = FALSE
         CONTINUE FOREACH
      END IF 
   END FOREACH
   
   RETURN  r_success
END FUNCTION

################################################################################
# Descriptions...: 填入單身資料
# Memo...........:
# Usage..........: CALL abgi150_01_ins_bgaq(p_bgaq001,p_bgap002)
# Date & Author..: 160729 By 06821
# Modify.........:
################################################################################
PRIVATE FUNCTION abgi150_01_ins_bgaq(p_bgaq001,p_bgap002)
DEFINE p_bgaq001       LIKE bgaq_t.bgaq001    #預算交易對象
DEFINE p_bgap002       LIKE bgap_t.bgap002    #交易對象類型
DEFINE l_sql           STRING
DEFINE l_n             LIKE type_t.num10
DEFINE l_cnt           LIKE type_t.num10  
DEFINE l_date          LIKE bgap_t.bgapmoddt
#DEFINE l_pmabsite      LIKE pmab_t.pmabsite  #161114 mark 
DEFINE l_pmab          RECORD                 #來源資料
         pmabsite      LIKE pmab_t.pmabsite,
         pmab080       LIKE pmab_t.pmab080,   #客戶ABC分類
         pmab083       LIKE pmab_t.pmab083,   #客戶慣用交易幣別
         pmab084       LIKE pmab_t.pmab084,   #客戶慣用交易稅別
         pmab103       LIKE pmab_t.pmab103,   #慣用交易條件
         pmab104       LIKE pmab_t.pmab104,   #慣用取價方式
         pmab087       LIKE pmab_t.pmab087,   #客戶慣用收款條件
         pmab105       LIKE pmab_t.pmab105,   #應收帳款類別
         pmab088       LIKE pmab_t.pmab088,   #客戶慣用銷售通路
         pmab089       LIKE pmab_t.pmab089,   #客戶慣用銷售分類
         pmab030       LIKE pmab_t.pmab030,   #供應商ABC分類
         pmab033       LIKE pmab_t.pmab033,   #供應商慣用交易幣別
         pmab034       LIKE pmab_t.pmab034,   #供應商慣用交易稅別
         pmab053       LIKE pmab_t.pmab053,   #慣用交易條件
         pmab054       LIKE pmab_t.pmab054,   #慣用取價方式
         pmab037       LIKE pmab_t.pmab037,   #供應商慣用付款條件
         pmab055       LIKE pmab_t.pmab055,   #應付帳款類別
         pmab038       LIKE pmab_t.pmab038,   #供應商慣用採購通路
         pmab039       LIKE pmab_t.pmab039    #供應商慣用採購分類
                       END RECORD
DEFINE r_success       LIKE type_t.num5

DEFINE l_pmaa080 LIKE pmaa_t.pmaa080
DEFINE l_pmaa090 LIKE pmaa_t.pmaa090

   LET r_success = TRUE

   #若取不到據點層資料pmab_t 則取 pmabsite ='ALL' 之資料
   LET l_n = 0
   SELECT COUNT(1) INTO l_n 
     FROM pmaa_t,pmab_t 
    #WHERE pmabent = g_enterprise AND pmabsite = g_site AND pmab001 = p_bgaq001 #161114 mark
    WHERE pmabent = g_enterprise AND pmab001 = p_bgaq001                        #161114 add
      AND pmaaent = pmabent AND pmaa001 = pmab001 AND pmaastus = 'Y'
   
   #定義DECLARE-------------------------------------------------------------------
   #符合條件據點  #############
   LET l_sql = " SELECT UNIQUE pmabsite,pmab080,pmab083,pmab084,pmab103,pmab104, ",
               "               pmab087,pmab105,pmab088,pmab089,pmab030,pmab033, ",
               "               pmab034,pmab053,pmab054,pmab037,pmab055,pmab038, ",
               "               pmab039 ",
               "              ,pmaa080,pmaa090 ",            #161105-00004#1
               "   FROM pmaa_t,pmab_t ",
               "  WHERE pmabent = '",g_enterprise,"' ",
               #"    AND pmabsite = ? ",  #161114 mark
               "    AND pmab001 = '",p_bgaq001,"' ",
                "   AND pmaaent = pmabent AND pmaa001 = pmab001 AND pmaastus = 'Y' "
   
   #交易條件"只產生集團法人層"參數不影響ALL據點,因此非ALL據點需加串條件 
   IF l_n > 0 THEN           
      IF g_bgap_m.l_comp_chk = 'Y' THEN
         LET l_sql = l_sql," AND pmabsite IN (SELECT ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"' AND ooef003 = 'Y' AND ooefstus = 'Y') "
      END IF
   END IF
  
   PREPARE sel_01_pmabp FROM l_sql
   DECLARE sel_01_pmabc CURSOR FOR sel_01_pmabp  
   
   #161114 --s add
   #ALL據點  #############
   LET l_sql = " SELECT UNIQUE pmabsite,pmab080,pmab083,pmab084,pmab103,pmab104, ",
               "               pmab087,pmab105,pmab088,pmab089,pmab030,pmab033, ",
               "               pmab034,pmab053,pmab054,pmab037,pmab055,pmab038, ",
               "               pmab039 ",
               "              ,pmaa080,pmaa090 ",           
               "   FROM pmaa_t,pmab_t ",
               "  WHERE pmabent = '",g_enterprise,"' ",
               "    AND pmabsite = 'ALL'  ",  
               "    AND pmab001 = '",p_bgaq001,"' ",
                "   AND pmaaent = pmabent AND pmaa001 = pmab001 AND pmaastus = 'Y' "
                
   PREPARE sel_01_pmabp_all FROM l_sql
   DECLARE sel_01_pmabc_all CURSOR FOR sel_01_pmabp_all  
   #161114 --e add

   #------------------------------------------------------------------------------

   IF cl_null(l_n) THEN LET l_n = 0 END IF
   
   #161114 --s mark
   #LET l_pmabsite = ''
   #IF l_n > 0 THEN
   #   #取據點層資料pmab_t
   #   LET l_pmabsite = g_site
   #ELSE
   #   #取pmabsite ='ALL'之資料
   #   LET l_pmabsite = 'ALL'
   #END IF
   #161114 --e mark

   #寫入單身------------------------------------------------------------------------
   IF l_n > 0 THEN  #161114 add
      #FOREACH sel_01_pmabc USING l_pmabsite INTO l_pmab.*,l_pmaa080,l_pmaa090  #161105-00004#1 add l_pmaa080,l_pmaa090 #161114 mark 
      FOREACH sel_01_pmabc INTO l_pmab.*,l_pmaa080,l_pmaa090                                                            #161114 add
      
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = 'Foreach:sel_01_pmabc' 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         
         CASE p_bgap002
            WHEN '1'  #供應商
               INSERT INTO bgaq_t
                           (bgaqent,bgaq002,bgaqsite,bgaq001,bgaq003,bgaq004,
                            bgaq005,bgaq006,bgaq007,bgaq008,bgaq009,
                            bgaq010,bgaq011,bgaqownid,bgaqowndp,bgaqcrtid,
                            bgaqcrtdp,bgaqcrtdt,bgaqmodid,bgaqmoddt,bgaqstus) 
                     # VALUES(g_enterprise,'2',l_pmab.pmabsite,p_bgaq001,l_pmab.pmab030,l_pmab.pmab033,  #161105-00004#1
                       VALUES( g_enterprise,'2',l_pmab.pmabsite,p_bgaq001,l_pmaa080,l_pmab.pmab033,      #161105-00004#1 add l_pmaa080
                            l_pmab.pmab034,l_pmab.pmab053,l_pmab.pmab054,l_pmab.pmab037,l_pmab.pmab055,
                            l_pmab.pmab038,l_pmab.pmab039,g_user,g_dept,g_user,
                            g_dept,l_date,'','','N') 
                            
            WHEN '2'  #客戶
               INSERT INTO bgaq_t
                           (bgaqent,bgaq002,bgaqsite,bgaq001,bgaq003,bgaq004,
                            bgaq005,bgaq006,bgaq007,bgaq008,bgaq009,
                            bgaq010,bgaq011,bgaqownid,bgaqowndp,bgaqcrtid,
                            bgaqcrtdp,bgaqcrtdt,bgaqmodid,bgaqmoddt,bgaqstus) 
                    # VALUES(g_enterprise,'1',l_pmab.pmabsite,p_bgaq001,l_pmab.pmab080,l_pmab.pmab083,
                     VALUES( g_enterprise,'1',l_pmab.pmabsite,p_bgaq001,l_pmaa090,l_pmab.pmab033,      #161105-00004#1 add l_pmaa090
                            l_pmab.pmab084,l_pmab.pmab103,l_pmab.pmab104,l_pmab.pmab087,l_pmab.pmab105,
                            l_pmab.pmab088,l_pmab.pmab089,g_user,g_dept,g_user,
                            g_dept,l_date,'','','N')  
               
            WHEN '3'  #兩者皆是
               INSERT INTO bgaq_t
                           (bgaqent,bgaq002,bgaqsite,bgaq001,bgaq003,bgaq004,
                            bgaq005,bgaq006,bgaq007,bgaq008,bgaq009,
                            bgaq010,bgaq011,bgaqownid,bgaqowndp,bgaqcrtid,
                            bgaqcrtdp,bgaqcrtdt,bgaqmodid,bgaqmoddt,bgaqstus) 
                     #VALUES(g_enterprise,'1',l_pmab.pmabsite,p_bgaq001,l_pmab.pmab080,l_pmab.pmab083,
                     VALUES(g_enterprise,'1',l_pmab.pmabsite,p_bgaq001,l_pmaa090,l_pmab.pmab083,   #161105-00004#1 add l_pmaa090
                            l_pmab.pmab084,l_pmab.pmab103,l_pmab.pmab104,l_pmab.pmab087,l_pmab.pmab105,
                            l_pmab.pmab088,l_pmab.pmab089,g_user,g_dept,g_user,
                            g_dept,l_date,'','','N')  
                            
               INSERT INTO bgaq_t
                           (bgaqent,bgaq002,bgaqsite,bgaq001,bgaq003,bgaq004,
                            bgaq005,bgaq006,bgaq007,bgaq008,bgaq009,
                            bgaq010,bgaq011,bgaqownid,bgaqowndp,bgaqcrtid,
                            bgaqcrtdp,bgaqcrtdt,bgaqmodid,bgaqmoddt,bgaqstus) 
                     #VALUES(g_enterprise,'2',l_pmab.pmabsite,p_bgaq001,l_pmab.pmab030,l_pmab.pmab033,
                     VALUES( g_enterprise,'2',l_pmab.pmabsite,p_bgaq001,l_pmaa080,l_pmab.pmab033,        #161105-00004#1 add l_pmaa080
                            l_pmab.pmab034,l_pmab.pmab053,l_pmab.pmab054,l_pmab.pmab037,l_pmab.pmab055,
                            l_pmab.pmab038,l_pmab.pmab039,g_user,g_dept,g_user,
                            g_dept,l_date,'','','N') 
                            
         END CASE
         
         IF SQLCA.SQLcode THEN  
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "INSERT bgaq_t_erro:",p_bgaq001
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET r_success = FALSE
            CONTINUE FOREACH
         END IF     
      END FOREACH 
   #161114 --s add
   ELSE 
      FOREACH sel_01_pmabc_all INTO l_pmab.*,l_pmaa080,l_pmaa090    
      
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = 'Foreach:sel_01_pmabc_all' 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         
         CASE p_bgap002
            WHEN '1'  #供應商
               INSERT INTO bgaq_t
                           (bgaqent,bgaq002,bgaqsite,bgaq001,bgaq003,bgaq004,
                            bgaq005,bgaq006,bgaq007,bgaq008,bgaq009,
                            bgaq010,bgaq011,bgaqownid,bgaqowndp,bgaqcrtid,
                            bgaqcrtdp,bgaqcrtdt,bgaqmodid,bgaqmoddt,bgaqstus) 
                       VALUES( g_enterprise,'2',l_pmab.pmabsite,p_bgaq001,l_pmaa080,l_pmab.pmab033,   
                            l_pmab.pmab034,l_pmab.pmab053,l_pmab.pmab054,l_pmab.pmab037,l_pmab.pmab055,
                            l_pmab.pmab038,l_pmab.pmab039,g_user,g_dept,g_user,
                            g_dept,l_date,'','','N') 
                            
            WHEN '2'  #客戶
               INSERT INTO bgaq_t
                           (bgaqent,bgaq002,bgaqsite,bgaq001,bgaq003,bgaq004,
                            bgaq005,bgaq006,bgaq007,bgaq008,bgaq009,
                            bgaq010,bgaq011,bgaqownid,bgaqowndp,bgaqcrtid,
                            bgaqcrtdp,bgaqcrtdt,bgaqmodid,bgaqmoddt,bgaqstus) 
                     VALUES( g_enterprise,'1',l_pmab.pmabsite,p_bgaq001,l_pmaa090,l_pmab.pmab033,   
                            l_pmab.pmab084,l_pmab.pmab103,l_pmab.pmab104,l_pmab.pmab087,l_pmab.pmab105,
                            l_pmab.pmab088,l_pmab.pmab089,g_user,g_dept,g_user,
                            g_dept,l_date,'','','N')  
               
            WHEN '3'  #兩者皆是
               INSERT INTO bgaq_t
                           (bgaqent,bgaq002,bgaqsite,bgaq001,bgaq003,bgaq004,
                            bgaq005,bgaq006,bgaq007,bgaq008,bgaq009,
                            bgaq010,bgaq011,bgaqownid,bgaqowndp,bgaqcrtid,
                            bgaqcrtdp,bgaqcrtdt,bgaqmodid,bgaqmoddt,bgaqstus) 
                     VALUES(g_enterprise,'1',l_pmab.pmabsite,p_bgaq001,l_pmaa090,l_pmab.pmab083, 
                            l_pmab.pmab084,l_pmab.pmab103,l_pmab.pmab104,l_pmab.pmab087,l_pmab.pmab105,
                            l_pmab.pmab088,l_pmab.pmab089,g_user,g_dept,g_user,
                            g_dept,l_date,'','','N')  
                            
               INSERT INTO bgaq_t
                           (bgaqent,bgaq002,bgaqsite,bgaq001,bgaq003,bgaq004,
                            bgaq005,bgaq006,bgaq007,bgaq008,bgaq009,
                            bgaq010,bgaq011,bgaqownid,bgaqowndp,bgaqcrtid,
                            bgaqcrtdp,bgaqcrtdt,bgaqmodid,bgaqmoddt,bgaqstus) 
                     VALUES( g_enterprise,'2',l_pmab.pmabsite,p_bgaq001,l_pmaa080,l_pmab.pmab033,     
                            l_pmab.pmab034,l_pmab.pmab053,l_pmab.pmab054,l_pmab.pmab037,l_pmab.pmab055,
                            l_pmab.pmab038,l_pmab.pmab039,g_user,g_dept,g_user,
                            g_dept,l_date,'','','N') 
         END CASE
         
         IF SQLCA.SQLcode THEN  
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "INSERT bgaq_t_erro:",p_bgaq001
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET r_success = FALSE
            CONTINUE FOREACH
         END IF     
      END FOREACH 
   END IF
   #161114 --e add
   
   #寫入對應對象檔
   INSERT INTO bgar_t 
              (bgarent,bgar001,bgar002,bgarownid,bgarowndp,bgarcrtid,bgarcrtdp,
               bgarcrtdt,bgarmodid,bgarmoddt,bgarstus)
        VALUES(g_enterprise,p_bgaq001,p_bgaq001,g_user,g_dept,g_user,g_dept,
               l_date,'','','N') 
               
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "INSERT bgar_t_erro:",p_bgaq001
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()   
      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success
END FUNCTION

 
{</section>}
 
