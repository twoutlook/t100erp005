#該程式未解開Section, 採用最新樣板產出!
{<section id="agli060_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0009(2014-08-28 15:07:19), PR版次:0009(2016-12-16 15:46:55)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000245
#+ Filename...: agli060_01
#+ Description: 整批產生
#+ Creator....: 02295(2013-08-27 14:09:20)
#+ Modifier...: 02599 -SD/PR- 02481
 
{</section>}
 
{<section id="agli060_01.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"
#160913-00017#3   2016/09/21  By 07900    AGL模组调整交易客商开窗
#160929-00003#1   2016/09/29  By 02599    修正核算项值开窗,修正核算项抓取值SQL语句
#161021-00037#1   2016/10/24  By 06821    組織類型與職能開窗調整
#161118-00019#1   2016/11/21  By 07900    numt5 to num10(需人工调整部分)
#161215-00044#2   2016/12/16  by 02481    标准程式定义采用宣告模式,弃用.*写
#end add-point
#add-point:填寫註解說明(客製用) name="main.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="main.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
{</section>}
 
{<section id="agli060_01.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
{<Module define>}
#單頭 type 宣告
PRIVATE type type_g_glak_m        RECORD
       glak003 LIKE glak_t.glak003,
       glak004 LIKE glak_t.glak004
       END RECORD
DEFINE g_glak_m        type_g_glak_m
DEFINE g_wc1           STRING
DEFINE g_wc2           STRING
{</Module define>}
#end add-point
 
{</section>}
 
{<section id="agli060_01.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_glakld        LIKE glak_t.glakld
DEFINE g_glak001       LIKE glak_t.glak001
DEFINE g_glak002       LIKE glak_t.glak002
#end add-point
 
{</section>}
 
{<section id="agli060_01.other_dialog" >}

 
{</section>}
 
{<section id="agli060_01.other_function" readonly="Y" >}

PUBLIC FUNCTION agli060_01(--)
   #add-point:construct段變數傳入
   p_glakld,p_glak001,p_glak002
   #end add-point
   )
   {<Local define>}
   DEFINE l_ac_t          LIKE type_t.num10        #未取消的ARRAY CNT    #161118-00019#1 mod type_t.num5 -> type_t.num10
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否
   DEFINE l_count         LIKE type_t.num5
   DEFINE l_insert        LIKE type_t.num5
   {</Local define>}
   #add-point:construct段define
   DEFINE p_glakld        LIKE glak_t.glakld
   DEFINE p_glak001       LIKE glak_t.glak001
   DEFINE p_glak002       LIKE glak_t.glak002
   DEFINE l_ooaa002       LIKE ooaa_t.ooaa002  #160929-00003#1 add
   #end add-point

   #畫面開啟 (identifier)
   OPEN WINDOW w_agli060_01 WITH FORM cl_ap_formpath("agl","agli060_01")

   #瀏覽頁簽資料初始化
   CALL cl_ui_init()

   #輸入前處理
   #add-point:單頭前置處理
   LET g_glakld = p_glakld
   LET g_glak001 = p_glak001
   LET g_glak002 = p_glak002
   #end add-point

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #輸入開始
      CONSTRUCT BY NAME g_wc1 ON glak003

         BEFORE CONSTRUCT
            #add-point:單頭輸入前處理
            {<point name="construct.before_construct"/>}
            #end add-point
            
         ON ACTION controlp INFIELD glak003
            #add-point:ON ACTION controlp INFIELD glak003
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            #LET g_qryparam.arg1 = g_glakld
            LET g_qryparam.where = " glac001 = (SELECT glaa004 FROM glaa_t WHERE glaald = '",g_glakld,"' AND glaaent=",g_enterprise,")",
                                   " AND glac003 <> '1' AND glac006 = 1 ",
                                   " AND glac002 IN (SELECT glad001 FROM glad_t WHERE gladld = '",g_glakld,"' AND gladent=",g_enterprise,
                                   "                 AND gladstus='Y' ",  #151117-00009#1 add
                                   "                 )"
            
            CALL aglt310_04()                                #呼叫開窗
            DISPLAY g_qryparam.return1 TO glak003
            NEXT FIELD glak003                     #返回原欄位
            
         AFTER CONSTRUCT
            #add-point:單頭輸入後處理
            {<point name="construct.after_construct"/>}
            #end add-point



         #---------------------------<  Master  >---------------------------


      END CONSTRUCT
      CONSTRUCT BY NAME g_wc2 ON glak004

         BEFORE CONSTRUCT
         ON ACTION controlp INFIELD glak004
            #add-point:ON ACTION controlp INFIELD glak004
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			#160929-00003#1--mod--str--
#            CASE p_glak001
#               WHEN 1                       #營運據點
#                  LET g_qryparam.where = " ooefstus = 'Y'"
#                  CALL q_ooef001()             
#               WHEN 2                       #部門管理
#                  LET g_qryparam.where = " ooef203 = 'Y' AND ooefstus = 'Y'"
#                  CALL q_ooef001()
#               WHEN 3                       #利潤成本管理
#                  LET g_qryparam.where = " ooef204 = 'Y' AND ooefstus = 'Y'" 
#                  CALL q_ooef001()
#                  LET g_qryparam.where = '' 
#               WHEN 4                       #區域管理
#                  LET g_qryparam.arg1 = '287'
#                  LET g_qryparam.where = " oocqstus = 'Y'"
#                  CALL q_oocq002()                         
#               WHEN 5                       #交易客商
#                  LET g_qryparam.where = " pmaastus = 'Y'"
#                  CALL q_pmaa001_25()      #160913-00017#3  add
#                 #CALL q_pmaa001()        #160913-00017#3  mark               #呼叫開窗      
#               WHEN 6                       #帳款客商
#                  LET g_qryparam.where = " pmaastus = 'Y'"
#                  CALL q_pmaa001_25()      #160913-00017#3  add
#                 #CALL q_pmaa001()        #160913-00017#3  mark               #呼叫開窗             
#               WHEN 7                       #客群管理
#                  LET g_qryparam.arg1 = '281'
#                  LET g_qryparam.where = " oocqstus = 'Y'"
#                  CALL q_oocq002()                        
#               WHEN 8                       #產品類別管理
#                  LET g_qryparam.where = " rtaxstus = 'Y'"
#                  CALL q_rtax001_1()                         
#               WHEN 9                       #人員管理
#                  LET g_qryparam.where = " ooagstus = 'Y'"
#                  CALL q_ooag001_2()                         
#               WHEN 10                      #預算管理
#                  LET g_qryparam.where = " bgaastus = 'Y'"
#                  CALL q_bgaa001()                         
#               WHEN 11                      #專案管理
#                                           
#               WHEN 10                      #WBS
#              
#            END CASE 
            CASE p_glak001
               WHEN '01'                       #營運據點
                  #LET g_qryparam.where ="ooefstus='Y'"                       #161021-00037#1  mark
                  LET g_qryparam.where = " ooefstus='Y' AND ooef201 = 'Y' "   #161021-00037#1  add
                  CALL q_ooef001()             
               WHEN '02'                       #部門管理
                  LET g_qryparam.arg1=g_today
                  CALL q_ooeg001_4()
               WHEN '03'                       #利潤成本管理
                  LET g_qryparam.where = " ooeg003 IN ('1','2','3')"
                  LET g_qryparam.arg1=g_today 
                  CALL q_ooeg001_4()
               WHEN '04'                       #區域管理 
                  CALL q_oocq002_287()                         
               WHEN '05'                       #交易客商
                 CALL q_pmaa001_25()      
               WHEN '06'                       #帳款客商               
                  CALL q_pmaa001_25()                        
               WHEN '07'                       #客群管理
                  CALL q_oocq002_281()                        
               WHEN '08'                       #產品類別管理
                  #品类管理层级aoos010
                  CALL cl_get_para(g_enterprise,'','E-CIR-0001') RETURNING l_ooaa002 #160929-00003#1 add
                  LET g_qryparam.where = " rtax004='",l_ooaa002,"'"
                  CALL q_rtax001()  
               WHEN '09'                       #經營方式
                  LET g_qryparam.arg1 = '6013'
                  CALL q_gzcb001()
               WHEN '10'                      #渠道
                  LET g_qryparam.where = " oojdstus='Y' "
                  CALL q_oojd001_2() 
               WHEN '11'                      #品牌
                  CALL q_oocq002_2002()
               WHEN '12'                      #人員管理
                  CALL q_ooag001_8()
               WHEN '13'                      #專案管理
                   CALL q_pjba001()                         
               WHEN '14'                      #WBS
                  LET g_qryparam.where = "pjbb012='1'"
                  CALL q_pjbb002()  
            END CASE 
         #160929-00003#1--mod--end
            DISPLAY g_qryparam.return1 TO glak004
            NEXT FIELD glak004 
            
         AFTER CONSTRUCT

      END CONSTRUCT
	
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

   #add-point:畫面關閉前
   {<point name="construct.before_close"/>}
   #end add-point

   #畫面關閉
   CLOSE WINDOW w_agli060_01

   IF NOT INT_FLAG THEN
      CALL agli060_01_get_glak()
   END IF

END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION agli060_01_get_glak()
DEFINE l_sql     STRING
DEFINE l_glak003 LIKE glak_t.glak003
DEFINE l_glak004 LIKE glak_t.glak004
DEFINE l_success LIKE type_t.chr1
DEFINE l_ooaa002 LIKE ooaa_t.ooaa002  #160929-00003#1 add

   CALL s_transaction_begin()
   IF g_wc1 IS NULL THEN LET g_wc1 = " 1=1" END IF
   IF g_wc2 IS NULL THEN LET g_wc2 = " 1=1" END IF
   LET g_wc1 = cl_replace_str(g_wc1,"glak003","glac002")   
   LET l_sql = "SELECT glac002 FROM glac_t ",
               " WHERE glacent = ",g_enterprise," AND glacstus = 'Y' AND ",g_wc1,
               " AND glac001 = (SELECT glaa004 FROM glaa_t WHERE glaald = '",g_glakld,"' AND glaaent=",g_enterprise,")",
               " AND glac003 <> '1' AND glac006 = 1 ",
               " AND glac002 IN (SELECT glad001 FROM glad_t WHERE gladld = '",g_glakld,"' AND gladent=",g_enterprise,
               "                 AND gladstus='Y' ",  #151117-00009#1 add
               "                )"  
   PREPARE glak003_pre FROM l_sql
   DECLARE glak003_cur CURSOR FOR glak003_pre
   #glak001是字符类型，将以下WHEN后数字改成字符
   CASE g_glak001
      WHEN '01'                      #營運據點 #160929-00003#1 mod 1-->'01'
         LET g_wc2 = cl_replace_str(g_wc2,"glak004","ooef001")
         LET l_sql = "SELECT ooef001 FROM ooef_t WHERE ooefent='",g_enterprise,"' AND ",g_wc2," AND ooefstus = 'Y' " 
      WHEN '02'                     #部門管理 #160929-00003#1 mod 2-->'02'
         #160929-00003#1--mod--str--
#         LET g_wc2 = cl_replace_str(g_wc2,"glak004","ooef001")
#         LET l_sql = "SELECT ooef001 FROM ooef_t WHERE ooefent='",g_enterprise,"' AND ",g_wc2," AND ooef203 = 'Y' AND ooefstus = 'Y' "
         LET g_wc2 = cl_replace_str(g_wc2,"glak004","ooeg001")
         LET l_sql = "SELECT ooeg001 FROM ooeg_t WHERE ooegent='",g_enterprise,"' AND ",g_wc2,
                     " AND ooegstus = 'Y' AND ooeg006<='",g_today,"'",
                     " AND (ooeg007 IS NULL OR ooeg007>'",g_today,"')"
         #160929-00003#1--mod--end
      WHEN '03'                      #利潤成本管理 #160929-00003#1 mod 3-->'03'
         #160929-00003#1--mod--str--
#         LET g_wc2 = cl_replace_str(g_wc2,"glak004","ooef001")
#         LET l_sql = "SELECT ooef001 FROM ooef_t WHERE ooefent='",g_enterprise,"' AND ",g_wc2," AND ooef204 = 'Y' AND ooefstus = 'Y' " 
         LET g_wc2 = cl_replace_str(g_wc2,"glak004","ooeg001")
         LET l_sql = "SELECT ooeg001 FROM ooeg_t WHERE ooegent='",g_enterprise,"' AND ",g_wc2,
                     " AND ooegstus = 'Y' AND ooeg006<='",g_today,"'",
                     " AND (ooeg007 IS NULL OR ooeg007>'",g_today,"')",
                     " AND ooeg003 IN ('1','2','3')"
         #160929-00003#1--mod--end
      WHEN '04'                       #區域管理 #160929-00003#1 mod 4-->'04'
         LET g_wc2 = cl_replace_str(g_wc2,"glak004","oocq002")
         LET l_sql = "SELECT oocq002 FROM oocq_t WHERE oocqent='",g_enterprise,"' AND oocq001= '287' AND ",g_wc2," AND oocqstus= 'Y' "         
      WHEN '05'                       #交易客商 #160929-00003#1 mod 5-->'05'
         LET g_wc2 = cl_replace_str(g_wc2,"glak004","pmaa001")      
         LET l_sql = "SELECT pmaa001 FROM pmaa_t WHERE pmaaent='",g_enterprise,"' AND ",g_wc2," AND pmaastus = 'Y'"        
      WHEN '06'                       #帳款客商 #160929-00003#1 mod 6-->'06'
         LET g_wc2 = cl_replace_str(g_wc2,"glak004","pmaa001")      
         LET l_sql = "SELECT pmaa001 FROM pmaa_t WHERE pmaaent='",g_enterprise,"' AND ",g_wc2," AND pmaastus = 'Y'"                 
      WHEN '07'                       #客群管理 #160929-00003#1 mod 7-->'07'
         LET g_wc2 = cl_replace_str(g_wc2,"glak004","oocq002")
         LET l_sql = "SELECT oocq002 FROM oocq_t WHERE oocqent='",g_enterprise,"' AND oocq001= '281' AND ",g_wc2," AND oocqstus= 'Y' "        
      WHEN '08'                       #產品類別管理 #160929-00003#1 mod 8-->'08'
         LET g_wc2 = cl_replace_str(g_wc2,"glak004","rtax001")
         LET l_sql = "SELECT rtax001 FROM rtax_t WHERE rtaxent='",g_enterprise,"' AND ",g_wc2," AND rtaxstus = 'Y' "        
      #160929-00003#1--add--str--
         #品类管理层级aoos010
         CALL cl_get_para(g_enterprise,'','E-CIR-0001') RETURNING l_ooaa002
         LET l_sql=l_sql," AND rtax004='",l_ooaa002,"'"
      WHEN '09' #經營方式
         LET g_wc2 = cl_replace_str(g_wc2,"glak004","gzcb002")
         LET l_sql="SELECT gzcb002 FROM gzcb_t WHERE gzcb001='6013' AND ",g_wc2   
      WHEN '10' #渠道
         LET g_wc2 = cl_replace_str(g_wc2,"glak004","oojd001")
         LET l_sql="SELECT oojd001 FROM oojd_t WHERE oojdent=",g_enterprise," AND ",g_wc2," AND oojdstus='Y' "
      WHEN '11' #品牌
         LET g_wc2 = cl_replace_str(g_wc2,"glak004","oocq002")
         LET l_sql = "SELECT oocq002 FROM oocq_t WHERE oocqent='",g_enterprise,"' AND oocq001= '2002' AND ",g_wc2," AND oocqstus= 'Y' "  
      #160929-00003#1--add--end
      WHEN '12'                       #人員管理 #160929-00003#1 mod 9-->'12'
         LET g_wc2 = cl_replace_str(g_wc2,"glak004","ooag001")
         LET l_sql = "SELECT ooag001 FROM ooag_t WHERE ooagent='",g_enterprise,"' AND ",g_wc2," AND ooagstus = 'Y' "        
      #160929-00003#1--add--str--
      WHEN '13' #專案管理
         LET g_wc2 = cl_replace_str(g_wc2,"glak004","pjba001")
         LET l_sql = "SELECT pjba001 FROM pjba_t WHERE pjbaent = ",g_enterprise," AND pjbastus='Y' AND (pjba011<>'Y' OR pjba011 IS NULL) AND ",g_wc2
      WHEN '14' #WBS
         LET g_wc2 = cl_replace_str(g_wc2,"glak004","pjbb002")
         LET l_sql = "SELECT DISTINCT pjbb002 FROM pjbb_t WHERE pjbbent = ",g_enterprise," AND pjbb012='1' AND ",g_wc2
      #160929-00003#1--add--end
      
#160929-00003#1--mark--str--
#      WHEN 10                      #預算管理
#         LET g_wc2 = cl_replace_str(g_wc2,"glak004","bgaa001")  
#         LET l_sql = "SELECT bgaa001 FROM bgaa_t WHERE bgaaent='",g_enterprise,"' AND ",g_wc2," AND bgaastus = 'Y' "         
#      WHEN 11                      #專案管理
#         RETURN                         
#      WHEN 10                      #WBS
#         RETURN
#160929-00003#1--mark--end
   END CASE
   PREPARE glak004_pre FROM l_sql
   DECLARE glak004_cur CURSOR FOR glak004_pre      
   LET l_success = 'Y'
   FOREACH glak003_cur INTO l_glak003
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET l_success = 'N'
         EXIT FOREACH
      END IF   
      FOREACH glak004_cur INTO l_glak004
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

            LET l_success = 'N'
            EXIT FOREACH
         END IF      
         IF NOT agli060_01_ins_glak(l_glak003,l_glak004) THEN 
            LET l_success = 'N'
            EXIT FOREACH 
         END IF         
      END FOREACH
      IF l_success = 'N' THEN 
         EXIT FOREACH
      END IF
   END FOREACH
   IF l_success = 'N' THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00167'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CALL s_transaction_end('N','0')                    
   ELSE
      CALL s_transaction_end('Y','0')    
   END IF      

END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL agli060_01_ins_glak(p_glak003,p_glak004)
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION agli060_01_ins_glak(p_glak003,p_glak004)
DEFINE p_glak003   LIKE glak_t.glak003
DEFINE p_glak004   LIKE glak_t.glak004
#161215-00044#2---modify----begin-----------------
#DEFINE l_glak      RECORD LIKE glak_t.*
DEFINE l_glak RECORD  #會計科目設限檔
       glakent LIKE glak_t.glakent, #企業編號
       glakownid LIKE glak_t.glakownid, #資料所有者
       glakowndp LIKE glak_t.glakowndp, #資料所屬部門
       glakcrtid LIKE glak_t.glakcrtid, #資料建立者
       glakcrtdp LIKE glak_t.glakcrtdp, #資料建立部門
       glakcrtdt LIKE glak_t.glakcrtdt, #資料創建日
       glakmodid LIKE glak_t.glakmodid, #資料修改者
       glakmoddt LIKE glak_t.glakmoddt, #最近修改日
       glakstus LIKE glak_t.glakstus, #狀態碼
       glakld LIKE glak_t.glakld, #帳套
       glak001 LIKE glak_t.glak001, #固定核算項
       glak002 LIKE glak_t.glak002, #正負向表列
       glak003 LIKE glak_t.glak003, #科目編號
       glak004 LIKE glak_t.glak004  #固定核算項值
       END RECORD

#161215-00044#2---modify----end-----------------


   IF NOT agli060_01_key_chk(p_glak003,p_glak004) THEN RETURN FALSE END IF
   LET l_glak.glakld = g_glakld
   LET l_glak.glak001 = g_glak001
   LET l_glak.glak002 = g_glak002
   LET l_glak.glak003 = p_glak003
   LET l_glak.glak004 = p_glak004
   LET l_glak.glakownid = g_user
   LET l_glak.glakowndp = g_dept
   LET l_glak.glakcrtid = g_user
   LET l_glak.glakcrtdp = g_dept 
   LET l_glak.glakcrtdt = cl_get_current()
   LET l_glak.glakmodid = ''
   LET l_glak.glakmoddt = ''
   LET l_glak.glakstus = "Y"
   LET l_glak.glakent = g_enterprise
   
   #161215-00044#2---modify----begin-----------------
   #INSERT INTO glak_t VALUES(l_glak.*)
   INSERT INTO glak_t (glakent,glakownid,glakowndp,glakcrtid,glakcrtdp,glakcrtdt,glakmodid,glakmoddt,
                       glakstus,glakld,glak001,glak002,glak003,glak004)
   VALUES(l_glak.glakent,l_glak.glakownid,l_glak.glakowndp,l_glak.glakcrtid,l_glak.glakcrtdp,l_glak.glakcrtdt,l_glak.glakmodid,l_glak.glakmoddt,
          l_glak.glakstus,l_glak.glakld,l_glak.glak001,l_glak.glak002,l_glak.glak003,l_glak.glak004)
   #161215-00044#2---modify----end-----------------
   IF SQLCA.SQLcode  THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "glak_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
  
      RETURN FALSE      
   END IF
   RETURN TRUE
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL agli060_01_key_chk(p_glak003,p_glak004)
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION agli060_01_key_chk(p_glak003,p_glak004)
DEFINE p_glak003   LIKE glak_t.glak003
DEFINE p_glak004   LIKE glak_t.glak004

   IF NOT cl_null(g_glakld) AND NOT cl_null(g_glak001) AND NOT cl_null(p_glak003) AND NOT cl_null(p_glak004) THEN 
      IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM glak_t WHERE "||"glakent = '" ||g_enterprise|| "' AND "||"glak001 = '"||g_glak001 ||"' AND "|| "glakld = '"||g_glakld ||"' AND "|| "glak003 = '"||p_glak003 ||"' AND "|| "glak004 = '"||p_glak004 ||"'",'std-00004',0) THEN 
         RETURN FALSE
      END IF
   END IF
   RETURN TRUE
END FUNCTION

 
{</section>}
 
