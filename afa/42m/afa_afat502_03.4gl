#該程式未解開Section, 採用最新樣板產出!
{<section id="afat502_03.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0009(2015-03-24 14:45:27), PR版次:0009(2016-12-29 09:29:48)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000123
#+ Filename...: afat502_03
#+ Description: 自動產生
#+ Creator....: 01533(2014-11-30 21:10:44)
#+ Modifier...: 02003 -SD/PR- 01531
 
{</section>}
 
{<section id="afat502_03.global" >}
#應用 c01c 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160627-00025#1   2016/07/14   By 01531   afat504自动输入单身，输入卡片编号等栏位确定后程序退出，后台报错[Value too large to fit in a SMALLINT.]
#160426-00014#7   2016/07/24   By 01531   免税不可以出售(faah036)，免税为1为可免税的不可以出售，自动产生单身+单身栏位检核修改
#160426-00014#10  2016/07/25   By 01531   afat532科目异动调整
#161017-00032#1   2016/10/17   By 02114   整批产生单身时，财编存在未过账单据，不可插入单身
#161111-00028#7   2016/11/23   by 02481   标准程式定义采用宣告模式,弃用.*写法
#161111-00049#12  2016/11/28   By 01531   二阶段FA问题7~14 调整作业:afat450/afat500/afat501/afat502/afat503/afat504/afat505/afat506
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
 
DEFINE g_rec_b               LIKE type_t.num10
DEFINE g_wc                  STRING
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_fabgdocno     LIKE fabg_t.fabgdocno
DEFINE g_fabgld        LIKE fabg_t.fabgld
DEFINE g_fabg005       LIKE fabg_t.fabg005
DEFINE g_glaacomp      LIKE glaa_t.glaacomp  #161111-00049#12
#161111-00028#7---modify--begin-----------
#DEFINE g_fabg     RECORD LIKE fabg_t.*
DEFINE g_fabg RECORD  #資產異動單頭檔(一帳套)
       fabgent LIKE fabg_t.fabgent, #企業編號
       fabgcomp LIKE fabg_t.fabgcomp, #法人
       fabgld LIKE fabg_t.fabgld, #帳套
       fabgdocno LIKE fabg_t.fabgdocno, #來源單號
       fabgdocdt LIKE fabg_t.fabgdocdt, #單據日期
       fabgsite LIKE fabg_t.fabgsite, #資產中心
       fabg001 LIKE fabg_t.fabg001, #帳務人員
       fabg002 LIKE fabg_t.fabg002, #申請人員
       fabg003 LIKE fabg_t.fabg003, #申請部門
       fabg004 LIKE fabg_t.fabg004, #申請日期
       fabg005 LIKE fabg_t.fabg005, #異動類型
       fabg006 LIKE fabg_t.fabg006, #帳款客戶
       fabg007 LIKE fabg_t.fabg007, #收款客戶
       fabg008 LIKE fabg_t.fabg008, #傳票號碼
       fabg009 LIKE fabg_t.fabg009, #傳票日期
       fabg010 LIKE fabg_t.fabg010, #所有組織
       fabg011 LIKE fabg_t.fabg011, #產生應收帳款編號
       fabg012 LIKE fabg_t.fabg012, #產生應付帳款編號
       fabg013 LIKE fabg_t.fabg013, #稅別
       fabg014 LIKE fabg_t.fabg014, #稅率
       fabg015 LIKE fabg_t.fabg015, #幣別
       fabg016 LIKE fabg_t.fabg016, #匯率
       fabg017 LIKE fabg_t.fabg017, #調撥流水碼
       fabg018 LIKE fabg_t.fabg018, #核算組織
       fabg019 LIKE fabg_t.fabg019, #來源單號
       fabgstus LIKE fabg_t.fabgstus, #狀態碼
       fabgownid LIKE fabg_t.fabgownid, #資料所有者
       fabgowndp LIKE fabg_t.fabgowndp, #資料所屬部門
       fabgcrtid LIKE fabg_t.fabgcrtid, #資料建立者
       fabgcrtdp LIKE fabg_t.fabgcrtdp, #資料建立部門
       fabgcrtdt LIKE fabg_t.fabgcrtdt, #資料創建日
       fabgmodid LIKE fabg_t.fabgmodid, #資料修改者
       fabgmoddt LIKE fabg_t.fabgmoddt, #最近修改日
       fabgcnfid LIKE fabg_t.fabgcnfid, #資料確認者
       fabgcnfdt LIKE fabg_t.fabgcnfdt, #資料確認日
       fabgpstid LIKE fabg_t.fabgpstid, #資料過帳者
       fabgpstdt LIKE fabg_t.fabgpstdt, #資料過帳日
       fabg020 LIKE fabg_t.fabg020 #資產性質
       END RECORD

#161111-00028#7---modify--end-----------
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point  
 
{</section>}
 
{<section id="afat502_03.input" >}
#+ 資料輸入
PUBLIC FUNCTION afat502_03(--)
   #add-point:construct段變數傳入 name="construct.get_var"
   p_fabgdocno,p_fabgld,p_fabg005
   #end add-point
   )
   #add-point:construct段define name="construct.define_customerization"
   
   #end add-point
   DEFINE l_ac_t          LIKE type_t.num10       #未取消的ARRAY CNT 
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num10
   DEFINE l_insert        LIKE type_t.num5
   #add-point:construct段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="construct.define"
   DEFINE p_fabgdocno     LIKE fabg_t.fabgdocno
   DEFINE p_fabgld        LIKE fabg_t.fabgld
   DEFINE p_fabg005       LIKE fabg_t.fabg005
   DEFINE l_origin_str    STRING
   DEFINE l_glaacomp      LIKE glaa_t.glaacomp
   LET g_fabgdocno = p_fabgdocno
   LET g_fabgld = p_fabgld
   #161111-00028#7---modify--begin-----------
   #SELECT * INTO g_fabg.* 
   SELECT fabgent,fabgcomp,fabgld,fabgdocno,fabgdocdt,fabgsite,fabg001,fabg002,fabg003,fabg004,fabg005,fabg006,
          fabg007,fabg008,fabg009,fabg010,fabg011,fabg012,fabg013,fabg014,fabg015,fabg016,fabg017,fabg018,fabg019,
          fabgstus,fabgownid,fabgowndp,fabgcrtid,fabgcrtdp,fabgcrtdt,fabgmodid,fabgmoddt,fabgcnfid,fabgcnfdt,
          fabgpstid,fabgpstdt,fabg020 INTO g_fabg.* 
   #161111-00028#7---modify--end-----------
   FROM fabg_t WHERE fabgent = g_enterprise AND fabgdocno = g_fabgdocno AND fabgld = g_fabgld
   SELECT glaacomp INTO l_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_fabgld
   
   CALL s_fin_create_account_center_tmp() 
   CALL s_fin_account_center_sons_query('5',g_fabg.fabgsite,g_fabg.fabgdocdt,'1')
   CALL s_fin_account_center_comp_str() RETURNING l_origin_str
   
   CALL afat502_03_change_to_sql(l_origin_str)RETURNING l_origin_str
   LET l_origin_str = "(",l_origin_str,")"   
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_afat502_03 WITH FORM cl_ap_formpath("afa","afat502_03")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   #輸入前處理
   #add-point:單頭前置處理 name="construct.pre_construct"
   LET g_fabgdocno = p_fabgdocno
   LET g_fabgld = p_fabgld
   LET g_fabg005 = p_fabg005
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      CONSTRUCT BY NAME g_wc ON faah001,faah003,faah004,faah008,faah025,faah026,faah030,faah031,faah028, 
          faah000 
      
            #add-point:自定義action name="construct.action"
            ON ACTION controlp INFIELD faah001
               #此段落由子樣板a08產生
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
			      LET g_qryparam.where = " faahstus = 'Y' AND faah028 IN ( SELECT ooef001 FROM ooef_t ",
		                                "                                  WHERE ooefent = ",g_enterprise,
		                                "                                    AND ooef017 = '",l_glaacomp,"'",
		                                "                                    AND ooef001 IN ",l_origin_str,")",
		                                " AND faah015 NOT IN ('0','5','6','8','10')"
		         #160426-00014#7 add s---                       
		         IF g_prog = "afat504" THEN 
		            LET g_qryparam.where = g_qryparam.where," AND faah036 != '1' "
               END IF	
               #160426-00014#7 add e---   
               #161111-00049#12 add s---
               SELECT glaacomp INTO g_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = p_fabgld
               LET g_qryparam.where =  g_qryparam.where," AND  faah032 = '",g_glaacomp,"'" 
               #161111-00049#12 add e---
               CALL q_faah001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO faah001  #顯示到畫面上
               
               NEXT FIELD faah001                     #返回原欄位
            
            ON ACTION controlp INFIELD faah003
               #此段落由子樣板a08產生
               #開窗c段
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " faahstus = 'Y' AND faah028 IN ( SELECT ooef001 FROM ooef_t ",
		                                "                                  WHERE ooefent = ",g_enterprise,
		                                "                                    AND ooef017 = '",l_glaacomp,"'",
		                                "                                    AND ooef001 IN ",l_origin_str,")",
		                                " AND faah015 NOT IN ('0','5','6','8','10')"
		         #160426-00014#7 add s---                       
		         IF g_prog = "afat504" THEN 
		            LET g_qryparam.where = g_qryparam.where," AND faah036 != '1' "
               END IF	
               #160426-00014#7 add e---  	
               #161111-00049#12 add s---
               SELECT glaacomp INTO g_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = p_fabgld
               LET g_qryparam.where =  g_qryparam.where," AND  faah032 = '",g_glaacomp,"'" 
               #161111-00049#12 add e---               
               CALL q_faah003()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO faah003  #顯示到畫面上
               
               NEXT FIELD faah003                     #返回原欄位
               
            ON ACTION controlp INFIELD faah004
               #此段落由子樣板a08產生
               #開窗c段
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " faahstus = 'Y' AND faah028 IN ( SELECT ooef001 FROM ooef_t ",
		                                "                                  WHERE ooefent = ",g_enterprise,
		                                "                                    AND ooef017 = '",l_glaacomp,"'",
		                                "                                    AND ooef001 IN ",l_origin_str,")",
		                                " AND faah015 NOT IN ('0','5','6','8','10')"
		         #160426-00014#7 add s---                       
		         IF g_prog = "afat504" THEN 
		            LET g_qryparam.where = g_qryparam.where," AND faah036 != '1' "
               END IF	
               #160426-00014#7 add e--- 
               #161111-00049#12 add s---
               SELECT glaacomp INTO g_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = p_fabgld
               LET g_qryparam.where =  g_qryparam.where," AND  faah032 = '",g_glaacomp,"'" 
               #161111-00049#12 add e---               
               CALL q_faah004()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO faah004  #顯示到畫面上
               
               NEXT FIELD faah004                     #返回原欄位
            
            ON ACTION controlp INFIELD faah008
               #此段落由子樣板a08產生
               #開窗c段
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_faah008()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO faah008  #顯示到畫面上
               
               NEXT FIELD faah008                     #返回原欄位
            
            ON ACTION controlp INFIELD faah025
		      	INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO faah025  #顯示到畫面上
               NEXT FIELD faah025                     #返回原欄位
               
            ON ACTION controlp INFIELD faah026
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = g_today
               CALL q_ooeg001_4()                                #呼叫開窗
               DISPLAY g_qryparam.return1 TO faah026  #顯示到畫面上
               NEXT FIELD faah026                     #返回原欄位
            
            ON ACTION controlp INFIELD faah030
               #此段落由子樣板a08產生
               #開窗c段
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               #161111-00049#12 add s---
               SELECT glaacomp INTO g_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = p_fabgld
               LET g_qryparam.where =  " faah032 = '",g_glaacomp,"' AND faah030 IS NOT NULL" 
               #161111-00049#12 add e---               
               CALL q_faah030()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO faah030  #顯示到畫面上
               
               NEXT FIELD faah030                     #返回原欄位
            
            ON ACTION controlp INFIELD faah031
               #此段落由子樣板a08產生
               #開窗c段
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               #161111-00049#12 add s---
               SELECT glaacomp INTO g_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = p_fabgld
               LET g_qryparam.where =  " faah032 = '",g_glaacomp,"' AND faah031 IS NOT NULL " 
               #161111-00049#12 add e---               
               CALL q_faah031()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO faah031  #顯示到畫面上
               
               NEXT FIELD faah031                     #返回原欄位
            
            ON ACTION controlp INFIELD faah028
               #此段落由子樣板a08產生
               #開窗c段
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               #161111-00049#12 add s---
               SELECT glaacomp INTO g_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = p_fabgld
               LET g_qryparam.where = " faah032 = '",g_glaacomp,"' AND faah028 IS NOT NULL " 
               #161111-00049#12 add e---               
               CALL q_faah028()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO faah028  #顯示到畫面上
               
               NEXT FIELD faah028                     #返回原欄位
               
            #end add-point
      
         BEFORE CONSTRUCT
            #add-point:單頭輸入前處理 name="construct.before_construct"
            
            #end add-point
            
         AFTER CONSTRUCT
            #add-point:單頭輸入後處理 name="construct.after_construct"
            
            #end add-point
            
         
 
         
       
      END CONSTRUCT
 
      #add-point:自定義construct name="construct.more_construct"
      
      #end add-point
      
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
 
   #add-point:畫面關閉前 name="construct.before_close"
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   
   IF INT_FLAG THEN
      LET INT_FLAG = 0 
   ELSE
     CALL cl_err_collect_init()
     IF g_fabg005 = '4' THEN   
        CALL afat502_03_fabo_ins()
     ELSE
        IF g_fabg005 = '30' THEN           #add by yangxf 
           CALL afat502_03_fabp_ins()      #add by yangxf 
        ELSE
           CALL afat502_03_fabh_ins()
        END IF 
     END IF
     CALL cl_err_collect_show()
   END IF
   #end add-point 
   
   #畫面關閉
   CLOSE WINDOW w_afat502_03 
   
   #add-point:construct段after construct name="construct.post_construct"
  
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="afat502_03.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="afat502_03.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 整批自動生成到單身
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
PRIVATE FUNCTION afat502_03_fabh_ins()
DEFINE  l_sql        STRING
#161111-00028#7---modify--begin-----------
#DEFINE  l_faah       RECORD LIKE faah_t.*
#DEFINE  l_faaj       RECORD LIKE faaj_t.*
#DEFINE  l_fabh       RECORD LIKE fabh_t.*
DEFINE l_faah RECORD  #固定資產基礎資料檔
       faahent LIKE faah_t.faahent, #企業編號
       faah000 LIKE faah_t.faah000, #產生批號
       faah001 LIKE faah_t.faah001, #卡片編號
       faah002 LIKE faah_t.faah002, #型態
       faah003 LIKE faah_t.faah003, #財產編號
       faah004 LIKE faah_t.faah004, #附號
       faah005 LIKE faah_t.faah005, #資產性質
       faah006 LIKE faah_t.faah006, #資產主要類型
       faah007 LIKE faah_t.faah007, #資產次要類型
       faah008 LIKE faah_t.faah008, #資產組
       faah009 LIKE faah_t.faah009, #供應供應商
       faah010 LIKE faah_t.faah010, #製造供應商
       faah011 LIKE faah_t.faah011, #產地
       faah012 LIKE faah_t.faah012, #名稱
       faah013 LIKE faah_t.faah013, #規格型號
       faah014 LIKE faah_t.faah014, #取得日期
       faah015 LIKE faah_t.faah015, #資產狀態
       faah016 LIKE faah_t.faah016, #取得方式
       faah017 LIKE faah_t.faah017, #單位
       faah018 LIKE faah_t.faah018, #數量
       faah019 LIKE faah_t.faah019, #在外數量
       faah020 LIKE faah_t.faah020, #幣別
       faah021 LIKE faah_t.faah021, #原幣單價
       faah022 LIKE faah_t.faah022, #原幣金額
       faah023 LIKE faah_t.faah023, #本幣單價
       faah024 LIKE faah_t.faah024, #本幣金額
       faah025 LIKE faah_t.faah025, #保管人員
       faah026 LIKE faah_t.faah026, #保管部門
       faah027 LIKE faah_t.faah027, #存放位置
       faah028 LIKE faah_t.faah028, #存放組織
       faah029 LIKE faah_t.faah029, #負責人員
       faah030 LIKE faah_t.faah030, #管理組織
       faah031 LIKE faah_t.faah031, #核算組織
       faah032 LIKE faah_t.faah032, #歸屬法人
       faah033 LIKE faah_t.faah033, #直接資本化
       faah034 LIKE faah_t.faah034, #保稅
       faah035 LIKE faah_t.faah035, #保險
       faah036 LIKE faah_t.faah036, #免稅
       faah037 LIKE faah_t.faah037, #抵押
       faah038 LIKE faah_t.faah038, #採購單號
       faah039 LIKE faah_t.faah039, #收貨單號
       faah040 LIKE faah_t.faah040, #帳款單號
       faah041 LIKE faah_t.faah041, #來源營運中心
       faah042 LIKE faah_t.faah042, #資產屬性
       faah043 LIKE faah_t.faah043, #預計總工作量
       faah044 LIKE faah_t.faah044, #已使用工作量
       faah045 LIKE faah_t.faah045, #帳款編號項次
       faahownid LIKE faah_t.faahownid, #資料所有者
       faahowndp LIKE faah_t.faahowndp, #資料所屬部門
       faahcrtid LIKE faah_t.faahcrtid, #資料建立者
       faahcrtdp LIKE faah_t.faahcrtdp, #資料建立部門
       faahcrtdt LIKE faah_t.faahcrtdt, #資料創建日
       faahmodid LIKE faah_t.faahmodid, #資料修改者
       faahmoddt LIKE faah_t.faahmoddt, #最近修改日
       faahstus LIKE faah_t.faahstus, #狀態碼
       faah046 LIKE faah_t.faah046, #備註
       faah047 LIKE faah_t.faah047, #保稅機器擷取否
       faah048 LIKE faah_t.faah048, #投資抵減狀態
       faah049 LIKE faah_t.faah049, #投資抵減合併碼
       faah050 LIKE faah_t.faah050, #抵減率
       faah051 LIKE faah_t.faah051, #投資抵減用途
       faah052 LIKE faah_t.faah052, #抵減金額
       faah053 LIKE faah_t.faah053, #已抵減金額
       faah054 LIKE faah_t.faah054, #投資抵減否
       faah055 LIKE faah_t.faah055, #投資抵減年限
       faah056 LIKE faah_t.faah056  #免稅狀態
       END RECORD 

DEFINE l_faaj RECORD  #固定資產帳套折舊資訊資料檔
       faajent LIKE faaj_t.faajent, #企業編碼
       faajld LIKE faaj_t.faajld, #帳套別編碼
       faajsite LIKE faaj_t.faajsite, #營運據點
       faaj000 LIKE faaj_t.faaj000, #批號
       faaj001 LIKE faaj_t.faaj001, #財產編號
       faaj002 LIKE faaj_t.faaj002, #附號
       faaj003 LIKE faaj_t.faaj003, #折舊方式
       faaj004 LIKE faaj_t.faaj004, #耐用年限(月數)
       faaj005 LIKE faaj_t.faaj005, #未使用年限(月數)
       faaj006 LIKE faaj_t.faaj006, #分攤方式
       faaj007 LIKE faaj_t.faaj007, #分攤類別
       faaj008 LIKE faaj_t.faaj008, #開始折舊年月
       faaj009 LIKE faaj_t.faaj009, #最近折舊年度
       faaj010 LIKE faaj_t.faaj010, #最近折舊期別
       faaj011 LIKE faaj_t.faaj011, #折畢再提
       faaj012 LIKE faaj_t.faaj012, #折畢再提預留殘值
       faaj013 LIKE faaj_t.faaj013, #折畢再提預留年月（數）
       faaj014 LIKE faaj_t.faaj014, #幣別
       faaj015 LIKE faaj_t.faaj015, #匯率
       faaj016 LIKE faaj_t.faaj016, #成本
       faaj017 LIKE faaj_t.faaj017, #累折
       faaj018 LIKE faaj_t.faaj018, #本期累折
       faaj019 LIKE faaj_t.faaj019, #預留殘值
       faaj020 LIKE faaj_t.faaj020, #調整成本
       faaj021 LIKE faaj_t.faaj021, #已提列減值準備
       faaj022 LIKE faaj_t.faaj022, #年折舊額
       faaj023 LIKE faaj_t.faaj023, #資產科目
       faaj024 LIKE faaj_t.faaj024, #累折科目
       faaj025 LIKE faaj_t.faaj025, #折舊科目
       faaj026 LIKE faaj_t.faaj026, #減值準備科目
       faaj027 LIKE faaj_t.faaj027, #銷帳減值準備
       faaj028 LIKE faaj_t.faaj028, #未折減額
       faaj029 LIKE faaj_t.faaj029, #第一個月未折減額
       faaj030 LIKE faaj_t.faaj030, #帳款編號
       faaj031 LIKE faaj_t.faaj031, #帳款編號項次
       faaj032 LIKE faaj_t.faaj032, #本期處置累折
       faaj033 LIKE faaj_t.faaj033, #處置數量
       faaj034 LIKE faaj_t.faaj034, #處置成本
       faaj035 LIKE faaj_t.faaj035, #處置累折
       faaj036 LIKE faaj_t.faaj036, #交易價格差異
       faaj037 LIKE faaj_t.faaj037, #卡片編號
       faaj038 LIKE faaj_t.faaj038, #資產狀態
       faaj039 LIKE faaj_t.faaj039, #部門
       faaj040 LIKE faaj_t.faaj040, #利潤/成本中心
       faaj041 LIKE faaj_t.faaj041, #區域
       faaj042 LIKE faaj_t.faaj042, #交易客商
       faaj043 LIKE faaj_t.faaj043, #帳款客商
       faaj044 LIKE faaj_t.faaj044, #客群
       faaj045 LIKE faaj_t.faaj045, #專案編號
       faaj046 LIKE faaj_t.faaj046, #WBS
       faaj047 LIKE faaj_t.faaj047, #人員
       faaj101 LIKE faaj_t.faaj101, #本位幣二幣別
       faaj102 LIKE faaj_t.faaj102, #本位幣二匯率
       faaj103 LIKE faaj_t.faaj103, #本位幣二成本
       faaj104 LIKE faaj_t.faaj104, #本位幣二累折
       faaj105 LIKE faaj_t.faaj105, #本位幣二預留殘值
       faaj106 LIKE faaj_t.faaj106, #本位幣二折畢再提預留殘值
       faaj107 LIKE faaj_t.faaj107, #本位幣二年折舊額
       faaj108 LIKE faaj_t.faaj108, #本位幣二未折減額
       faaj109 LIKE faaj_t.faaj109, #本位幣二第一月未折減額
       faaj110 LIKE faaj_t.faaj110, #本位幣二處置減值準備
       faaj111 LIKE faaj_t.faaj111, #本位幣二本年累折
       faaj112 LIKE faaj_t.faaj112, #本位幣二已提列減值準備
       faaj113 LIKE faaj_t.faaj113, #本位幣二處置成本
       faaj114 LIKE faaj_t.faaj114, #本位幣二處置累折
       faaj115 LIKE faaj_t.faaj115, #本位幣二本期處置累折
       faaj116 LIKE faaj_t.faaj116, #本位幣二交易價格差異
       faaj117 LIKE faaj_t.faaj117, #本位幣二調整成本
       faaj151 LIKE faaj_t.faaj151, #本位幣三幣別
       faaj152 LIKE faaj_t.faaj152, #本位幣三匯率
       faaj153 LIKE faaj_t.faaj153, #本位幣三成本
       faaj154 LIKE faaj_t.faaj154, #本位幣三累折
       faaj155 LIKE faaj_t.faaj155, #本位幣三預留殘值
       faaj156 LIKE faaj_t.faaj156, #本位幣三折畢再提預留殘值
       faaj157 LIKE faaj_t.faaj157, #本位幣三年折舊額
       faaj158 LIKE faaj_t.faaj158, #本位幣三未折減額
       faaj159 LIKE faaj_t.faaj159, #本位幣三第一月未折減額
       faaj160 LIKE faaj_t.faaj160, #本位幣三處置減值準備
       faaj161 LIKE faaj_t.faaj161, #本位幣三本年累折
       faaj162 LIKE faaj_t.faaj162, #本位幣三已提列減值準備
       faaj163 LIKE faaj_t.faaj163, #本位幣三處置成本
       faaj164 LIKE faaj_t.faaj164, #本位幣三處置累折
       faaj165 LIKE faaj_t.faaj165, #本位幣三本期處置累折
       faaj166 LIKE faaj_t.faaj166, #本位幣三交易價格差異
       faaj167 LIKE faaj_t.faaj167, #本位幣三調整成本
       faajownid LIKE faaj_t.faajownid, #資料所有者
       faajowndp LIKE faaj_t.faajowndp, #資料所屬部門
       faajcrtid LIKE faaj_t.faajcrtid, #資料建立者
       faajcrtdp LIKE faaj_t.faajcrtdp, #資料建立部門
       faajcrtdt LIKE faaj_t.faajcrtdt, #資料創建日
       faajmodid LIKE faaj_t.faajmodid, #資料修改者
       faajmoddt LIKE faaj_t.faajmoddt, #最近修改日
       faajstus LIKE faaj_t.faajstus, #狀態碼
       faaj048 LIKE faaj_t.faaj048 #資產分類
       END RECORD
DEFINE l_fabh RECORD  #資產異動單身檔
       fabhent LIKE fabh_t.fabhent, #企業編號
       fabhld LIKE fabh_t.fabhld, #帳套
       fabhsite LIKE fabh_t.fabhsite, #營運據點
       fabhdocno LIKE fabh_t.fabhdocno, #異動單號
       fabhseq LIKE fabh_t.fabhseq, #項次
       fabh000 LIKE fabh_t.fabh000, #卡片編號
       fabh001 LIKE fabh_t.fabh001, #財產編號
       fabh002 LIKE fabh_t.fabh002, #附號
       fabh003 LIKE fabh_t.fabh003, #資產狀態
       fabh004 LIKE fabh_t.fabh004, #未折減餘額
       fabh005 LIKE fabh_t.fabh005, #單位
       fabh006 LIKE fabh_t.fabh006, #數量
       fabh007 LIKE fabh_t.fabh007, #處置數量
       fabh008 LIKE fabh_t.fabh008, #成本
       fabh009 LIKE fabh_t.fabh009, #累計調整成本
       fabh010 LIKE fabh_t.fabh010, #調整成本/公允價值
       fabh011 LIKE fabh_t.fabh011, #累折
       fabh012 LIKE fabh_t.fabh012, #重估累計折舊
       fabh013 LIKE fabh_t.fabh013, #未用年限
       fabh014 LIKE fabh_t.fabh014, #重估未用年限
       fabh015 LIKE fabh_t.fabh015, #預留殘值
       fabh016 LIKE fabh_t.fabh016, #重估預留殘值
       fabh017 LIKE fabh_t.fabh017, #已計提減值準備
       fabh018 LIKE fabh_t.fabh018, #異動
       fabh019 LIKE fabh_t.fabh019, #減值準備金額
       fabh020 LIKE fabh_t.fabh020, #異動原因
       fabh021 LIKE fabh_t.fabh021, #異動科目
       fabh022 LIKE fabh_t.fabh022, #調整成本
       fabh023 LIKE fabh_t.fabh023, #累計折舊科目
       fabh024 LIKE fabh_t.fabh024, #資產科目
       fabh025 LIKE fabh_t.fabh025, #減值準備科目
       fabh026 LIKE fabh_t.fabh026, #營運據點
       fabh027 LIKE fabh_t.fabh027, #部門
       fabh028 LIKE fabh_t.fabh028, #利潤/成本中心
       fabh029 LIKE fabh_t.fabh029, #區域
       fabh030 LIKE fabh_t.fabh030, #交易客商
       fabh031 LIKE fabh_t.fabh031, #帳款客商
       fabh032 LIKE fabh_t.fabh032, #客群
       fabh033 LIKE fabh_t.fabh033, #人員
       fabh034 LIKE fabh_t.fabh034, #專案編號
       fabh035 LIKE fabh_t.fabh035, #WBS
       fabh036 LIKE fabh_t.fabh036, #摘要
       fabh037 LIKE fabh_t.fabh037, #來源編號
       fabh038 LIKE fabh_t.fabh038, #來源項次
       fabh039 LIKE fabh_t.fabh039, #盤點編號
       fabh040 LIKE fabh_t.fabh040, #盤點序號
       fabh041 LIKE fabh_t.fabh041, #經營方式
       fabh042 LIKE fabh_t.fabh042, #通路
       fabh043 LIKE fabh_t.fabh043, #品牌
       fabh060 LIKE fabh_t.fabh060, #自由核算項一
       fabh061 LIKE fabh_t.fabh061, #自由核算項二
       fabh062 LIKE fabh_t.fabh062, #自由核算項三
       fabh063 LIKE fabh_t.fabh063, #自由核算項四
       fabh064 LIKE fabh_t.fabh064, #自由核算項五
       fabh065 LIKE fabh_t.fabh065, #自由核算項六
       fabh066 LIKE fabh_t.fabh066, #自由核算項七
       fabh067 LIKE fabh_t.fabh067, #自由核算項八
       fabh068 LIKE fabh_t.fabh068, #自由核算項九
       fabh069 LIKE fabh_t.fabh069, #自由核算項十
       fabh100 LIKE fabh_t.fabh100, #本位幣二幣別
       fabh101 LIKE fabh_t.fabh101, #本位幣二匯率
       fabh102 LIKE fabh_t.fabh102, #本位幣二成本
       fabh103 LIKE fabh_t.fabh103, #本位幣二調整成本
       fabh104 LIKE fabh_t.fabh104, #本位幣二累折
       fabh105 LIKE fabh_t.fabh105, #本位幣二重估累折
       fabh106 LIKE fabh_t.fabh106, #本位幣二預留殘值
       fabh107 LIKE fabh_t.fabh107, #本位幣二重估殘值
       fabh108 LIKE fabh_t.fabh108, #本位幣二未折減額
       fabh109 LIKE fabh_t.fabh109, #本位幣二已計提減值準備
       fabh110 LIKE fabh_t.fabh110, #本位幣二減值準備金額
       fabh150 LIKE fabh_t.fabh150, #本位幣三幣別
       fabh151 LIKE fabh_t.fabh151, #本位幣三匯率
       fabh152 LIKE fabh_t.fabh152, #本位幣三成本
       fabh153 LIKE fabh_t.fabh153, #本位幣三調整成本
       fabh154 LIKE fabh_t.fabh154, #本位幣三累折
       fabh155 LIKE fabh_t.fabh155, #本位幣三重估累折
       fabh156 LIKE fabh_t.fabh156, #本位幣三預留殘值
       fabh157 LIKE fabh_t.fabh157, #本位幣三重估殘值
       fabh158 LIKE fabh_t.fabh158, #本位幣三未折減額
       fabh159 LIKE fabh_t.fabh159, #本位幣三已計提減值準備
       fabh160 LIKE fabh_t.fabh160, #本位幣三減值準備金額
       fabh070 LIKE fabh_t.fabh070, #累計折舊科目(舊)
       fabh071 LIKE fabh_t.fabh071, #資產科目(舊)
       fabh072 LIKE fabh_t.fabh072, #減值準備科目(舊)
       fabh073 LIKE fabh_t.fabh073, #處置本年累折
       fabh111 LIKE fabh_t.fabh111, #本位幣二處置本年累折
       fabh161 LIKE fabh_t.fabh161, #本位幣三處置本年累折
       fabh074 LIKE fabh_t.fabh074, #保險費用科目
       fabh075 LIKE fabh_t.fabh075, #主要類別
       fabh076 LIKE fabh_t.fabh076  #主要類別新
       END RECORD

#161111-00028#7---modify--end-----------
DEFINE  l_ooag004    LIKE ooag_t.ooag004
DEFINE  l_origin_str STRING
DEFINE  l_glaacomp   LIKE glaa_t.glaacomp
DEFINE  tok          base.StringTokenizer
DEFINE  l_str        STRING
DEFINE  l_faal003    LIKE faal_t.faal003
DEFINE  l_year       LIKE type_t.num5
DEFINE  l_month      LIKE type_t.num5
DEFINE  l_n          LIKE type_t.num5
DEFINE  l_para_data  LIKE ooab_t.ooab002
DEFINE  l_faah015    LIKE faah_t.faah015
DEFINE  l_yy         LIKE faaj_t.faaj008  #161229-00007#1 add
DEFINE  l_mm         LIKE faaj_t.faaj008  #161229-00007#1 add
DEFINE  l_ym         LIKE faaj_t.faaj008  #161229-00007#1 add

  #161111-00028#7---modify--begin-----------
  #SELECT * INTO g_fabg.* 
   SELECT fabgent,fabgcomp,fabgld,fabgdocno,fabgdocdt,fabgsite,fabg001,fabg002,fabg003,fabg004,fabg005,fabg006,
          fabg007,fabg008,fabg009,fabg010,fabg011,fabg012,fabg013,fabg014,fabg015,fabg016,fabg017,fabg018,fabg019,
          fabgstus,fabgownid,fabgowndp,fabgcrtid,fabgcrtdp,fabgcrtdt,fabgmodid,fabgmoddt,fabgcnfid,fabgcnfdt,
          fabgpstid,fabgpstdt,fabg020 INTO g_fabg.* 
   #161111-00028#7---modify--end----------- 
   FROM fabg_t WHERE fabgent = g_enterprise AND fabgdocno = g_fabgdocno AND fabgld = g_fabgld
   SELECT glaacomp INTO l_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_fabgld
   
   CALL s_fin_create_account_center_tmp() 
   CALL s_fin_account_center_sons_query('5',g_fabg.fabgsite,g_fabg.fabgdocdt,'1')
   CALL s_fin_account_center_comp_str() RETURNING l_origin_str
   
   CALL afat502_03_change_to_sql(l_origin_str)RETURNING l_origin_str
   LET l_origin_str = "(",l_origin_str,")"
#   LET l_sql = " SELECT faah_t.*,faaj_t.* FROM faah_t,faaj_t",                                                             #160627-00025#1 mark
   LET l_sql = " SELECT faah001,faah002,faah003,faah004,faah006,faah007,faah008,faah012,faah013,faah015,faah017,faah018, ", #160627-00025#1 add
             #161111-00028#7---modify--begin-----------             
             # "        faaj_t.* FROM faah_t,faaj_t",                                                                       #160627-00025#1 add 
               "faajent,faajld,faajsite,faaj000,faaj001,faaj002,faaj003,faaj004,faaj005,faaj006,faaj007,",
               "faaj008,faaj009,faaj010,faaj011,faaj012,faaj013,faaj014,faaj015,faaj016,faaj017,faaj018,",
               "faaj019,faaj020,faaj021,faaj022,faaj023,faaj024,faaj025,faaj026,faaj027,faaj028,faaj029,",
               "faaj030,faaj031,faaj032,faaj033,faaj034,faaj035,faaj036,faaj037,faaj038,faaj039,faaj040,",
               "faaj041,faaj042,faaj043,faaj044,faaj045,faaj046,faaj047,faaj101,faaj102,faaj103,faaj104,",
               "faaj105,faaj106,faaj107,faaj108,faaj109,faaj110,faaj111,faaj112,faaj113,faaj114,faaj115,",
               "faaj116,faaj117,faaj151,faaj152,faaj153,faaj154,faaj155,faaj156,faaj157,faaj158,faaj159,",
               "faaj160,faaj161,faaj162,faaj163,faaj164,faaj165,faaj166,faaj167,faajownid,faajowndp,",
               "faajcrtid,faajcrtdp,faajcrtdt,faajmodid,faajmoddt,faajstus,faaj048 FROM faah_t,faaj_t",   
             #161111-00028#7---modify--end-----------               
               "  WHERE faahent = ",g_enterprise," AND faahstus = 'Y' AND faah015 NOT IN ('0','5','6','8','10') ",
               "    AND faahent = faajent AND faah001 = faaj037 AND faah003 = faaj001 AND faah004 = faaj002 AND faajld = '",g_fabgld,"'",
               "    AND faah028 IN ( SELECT ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"'",
               "    AND ooef017 = '",l_glaacomp,"' AND ooef001 IN ",l_origin_str,")",
               "    AND ",g_wc CLIPPED
   
   PREPARE afat502_03_faah_prep FROM l_sql
   DECLARE afat502_03_faah_curs CURSOR FOR afat502_03_faah_prep

    SELECT ooag003 INTO l_fabh.fabh027 FROM ooag_t
     WHERE ooagent = g_enterprise AND ooag001 = g_user

    #161229-00007#1 add s---
    CALL cl_get_para(g_enterprise,l_glaacomp,'S-FIN-9018') RETURNING l_year
    CALL cl_get_para(g_enterprise,l_glaacomp,'S-FIN-9019') RETURNING l_month    
    LET l_yy = l_year
    LET l_mm = l_month
    LET l_yy = l_yy USING "&&&&"
    LET l_mm = l_mm USING "&&"
    LET l_ym = l_yy,l_mm      
    #161229-00007#1 add e---
      
#   FOREACH afat502_03_faah_curs INTO l_faah.*,l_faaj.*                                                   #160627-00025#1 mark
   FOREACH afat502_03_faah_curs INTO l_faah.faah001,l_faah.faah002,l_faah.faah003,l_faah.faah004,         #160627-00025#1 add
                                      l_faah.faah006,l_faah.faah007,l_faah.faah008,l_faah.faah012,         #160627-00025#1 add
                                      l_faah.faah013,l_faah.faah015,l_faah.faah017,l_faah.faah018,l_faaj.* #160627-00025#1 add

      IF l_faaj.faaj008 < l_ym AND l_faaj.faaj003 <> '5' AND NOT cl_null(l_faaj.faaj003) THEN  #161229-00007#1 add  
     
         SELECT faal003 INTO l_faal003 FROM faal_t 
          WHERE faalent = g_enterprise AND faalld = g_fabgld AND faal001 = l_faah.faah006
         
         IF STATUS =100 OR cl_null(l_faal003) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'afa-00183'      #过单
            LET g_errparam.extend = g_fabgld||'|'||l_faah.faah006
            LET g_errparam.popup = TRUE
            CALL cl_err()      
            CONTINUE FOREACH
         ELSE
            LET l_year = YEAR(g_fabg.fabgdocdt)     #g_today-->g_fabg.fabgdocdt by chenying
            LET l_month = MONTH(g_fabg.fabgdocdt)   #g_today-->g_fabg.fabgdocdt by chenying
            IF l_faal003 = 'Y' THEN   
               SELECT COUNT(*) INTO l_n FROM faam_t
                 WHERE faament = g_enterprise AND faamld = g_fabgld
                   AND faam000 = l_faah.faah001 AND faam001 = l_faah.faah003 AND faam002= l_faah.faah004
                   AND faam004 = l_year AND faam005 = l_month
                IF l_n = 0 THEN 
                   SELECT faah015 INTO l_faah015
                     FROM faah_t
                    WHERE faahent = g_enterprise
                      AND faah001 = l_faah.faah001
                      AND faah003 = l_faah.faah003
                      AND faah004 = l_faah.faah004
                   IF l_faah015 <> '4' THEN 
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = 'afa-00280'
                      LET g_errparam.extend =l_faah.faah003||'|'||l_faah.faah004||'|'||l_faah.faah001 
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                      CONTINUE FOREACH
                   END IF 
                END IF
            END IF
         END IF
      END IF #161229-00007#1 add
     
      SELECT MAX(fabhseq) INTO l_fabh.fabhseq
        FROM fabh_t
       WHERE fabhent = g_enterprise
         AND fabhdocno = g_fabgdocno AND fabhld = g_fabgld
      IF cl_null(l_fabh.fabhseq) THEN
         LET l_fabh.fabhseq = 1
      ELSE
         LET l_fabh.fabhseq = l_fabh.fabhseq +1
      END IF
      LET l_fabh.fabhent   = g_enterprise 
      LET l_fabh.fabhld    = g_fabgld
      LET l_fabh.fabhsite  = g_fabg.fabgsite
      LET l_fabh.fabhdocno = g_fabgdocno
       
      LET l_fabh.fabh000   = l_faah.faah001
      LET l_fabh.fabh001   = l_faah.faah003
      LET l_fabh.fabh002   = l_faah.faah004
      LET l_fabh.fabh003   = l_faah.faah015
      LET l_fabh.fabh004   = l_faaj.faaj028 - l_faaj.faaj029                                      #未折減餘額
      LET l_fabh.fabh005   = l_faah.faah017                                      #单位
      LET l_fabh.fabh006   = l_faah.faah018-l_faaj.faaj033                       #数量 = faah中的数量-faaj中的处置数量
      IF cl_null(l_fabh.fabh006) THEN
         LET l_fabh.fabh006 = 0
      END IF
      LET l_fabh.fabh007   = l_fabh.fabh006                                      #處置數量
      LET l_fabh.fabh008   = l_faaj.faaj016+l_faaj.faaj020-l_faaj.faaj034        #成本 
      LET l_fabh.fabh010   = 0
      LET l_fabh.fabh011   = l_faaj.faaj017-l_faaj.faaj035                       #累折
      LET l_fabh.fabh012   = l_fabh.fabh011                                      #重估累計折舊
      LET l_fabh.fabh013   = l_faaj.faaj004                                      #未用年限
      LET l_fabh.fabh014   = l_fabh.fabh013                                      #重估未用年限
      IF l_faah.faah015 = '7' THEN
         LET l_fabh.fabh015   = l_faaj.faaj012                                   #預留殘值
      ELSE
         LET l_fabh.fabh015   = l_faaj.faaj019
      END IF
      LET l_fabh.fabh016   =  l_fabh.fabh015                                     #重估預留殘值
      LET l_fabh.fabh017   =  l_faaj.faaj021
      LET l_fabh.fabh018   = '1'
      LET l_fabh.fabh019   =  0
      #科目
      #異動科目
      #######################################################################
      IF g_fabg.fabg005 =  '8' THEN
         SELECT glab005 INTO l_fabh.fabh021 FROM glab_t
          WHERE glabent=g_enterprise AND glabld=g_fabgld AND glab001='90' AND glab002='8' AND glab003='9902_01' 
      END IF
     #160426-00014#10 add s---    
      IF g_fabg.fabg005 =  '39' THEN
         SELECT glab005 INTO l_fabh.fabh021 FROM glab_t
          WHERE glabent=g_enterprise AND glabld=g_fabgld AND glab001='90' AND glab002='39' AND glab003='9902_17'  
      END IF
      #160426-00014#10 add e--- 
      
      IF g_fabg.fabg005 = '9' THEN
         SELECT glab005 INTO l_fabh.fabh021 FROM glab_t
          WHERE glabent=g_enterprise AND glabld=g_fabgld AND glab001='90' AND glab002='9' AND glab003='9902_02' 
      END IF               
      IF g_fabg.fabg005 = '23' THEN
         SELECT glab005 INTO l_fabh.fabh021 FROM glab_t
          WHERE glabent=g_enterprise AND glabld=g_fabgld AND glab001='90' AND glab002='23' AND glab003='9902_09' 
      END IF
      IF g_fabg.fabg005 = '24' THEN
         SELECT glab005 INTO l_fabh.fabh021 FROM glab_t
          WHERE glabent=g_enterprise AND glabld=g_fabgld AND glab001='90' AND glab002='24' AND glab003='9902_10' 
      END IF
      
      #减值准备异动
      IF g_fabg.fabg005 = '14' THEN
         SELECT glab005 INTO l_fabh.fabh021 FROM glab_t
         WHERE glabent=g_enterprise AND glabld=g_fabgld AND glab001='90' AND glab002='14' AND glab003='9902_11' 
      END IF
  
      SELECT glaacomp INTO l_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_fabgld
      CALL cl_get_para(g_enterprise,l_glaacomp,'S-FIN-9017') RETURNING l_para_data                 
      #6:銷帳
      IF g_fabg.fabg005 = '6' THEN
         IF l_para_data = 'Y' THEN
            SELECT glab005 INTO l_fabh.fabh021 FROM glab_t
             WHERE glabent = g_enterprise AND glabld = g_fabgld
               AND glab001 = '90' AND glab002 = '25' AND glab003 = '9902_12' 
         ELSE
            SELECT glab005 INTO l_fabh.fabh021 FROM glab_t
             WHERE glabent = g_enterprise AND glabld = g_fabgld
               AND glab001 = '90' AND glab002 = '6' AND glab003 = '9902_04' 
         END IF
      END IF
               
     # #出售
     # IF g_fabg.fabg005 = '4' THEN
     #    IF l_para_data = 'Y' THEN        
     #       SELECT glab005 INTO l_fabh.fabh021 FROM glab_t
     #        WHERE glabent=g_enterprise AND glabld=g_fabgld
     #          AND glab002='25' AND glab001='90' AND glab003='9902_12'
     #    ELSE
     #       SELECT glab005 INTO l_fabh.fabh021 FROM glab_t
     #        WHERE glabent=g_enterprise AND glabld=g_fabgld
     #          AND glab002='40' AND glab001='90' AND glab003='9902_05'       
     #    END IF 
     # END IF                   

      #报废
      IF g_fabg.fabg005 = '21' THEN
         IF l_para_data = 'Y' THEN        
            SELECT glab005 INTO l_fabh.fabh021 FROM glab_t
             WHERE glabent=g_enterprise AND glabld=g_fabgld
               AND glab002='25' AND glab001='90' AND glab003='9902_12'
         ELSE
            SELECT glab005 INTO l_fabh.fabh021 FROM glab_t
             WHERE glabent=g_enterprise AND glabld=g_fabgld
               AND glab002='21' AND glab001='90' AND glab003='9902_03'       
         END IF 
      END IF        
      #######################################################################
      LET l_fabh.fabh023   =  l_faaj.faaj024                                     #累計折舊科目
      LET l_fabh.fabh024   =  l_faaj.faaj023                                     #資產科目
      LET l_fabh.fabh025   =  l_faaj.faaj026                                     #減值準備科目
      #核算项
      LET l_fabh.fabh026   =  l_faaj.faajsite                                    #營運據點
      LET l_fabh.fabh027   =  ''                                                 #部門
      LET l_fabh.fabh028   =  ''                                                 #利潤/成本中心
      LET l_fabh.fabh029   =  ''                                                 #區域
      LET l_fabh.fabh030   =  l_faaj.faaj042                                     #交易客商
      LET l_fabh.fabh031   =  l_faaj.faaj043                                     #帳款客商
      LET l_fabh.fabh032   =  ''                                                 #客群
      LET l_fabh.fabh033   =  ''                                                 #人員
      LET l_fabh.fabh034   =  l_faaj.faaj045                                     #專案編號
      LET l_fabh.fabh035   =  l_faaj.faaj046                                     #WBS 
      
      LET l_fabh.fabh100   =  l_faaj.faaj101                                     #本位幣二幣別
      LET l_fabh.fabh101   =  l_faaj.faaj102                                     #本位幣二匯率
      LET l_fabh.fabh102   =  l_faaj.faaj103+l_faaj.faaj117-l_faaj.faaj113       #本位幣二成本
      LET l_fabh.fabh103   =  l_faaj.faaj117                                     #本位幣二調整成本
      LET l_fabh.fabh104   =  l_faaj.faaj104                                     #本位幣二累折
      LET l_fabh.fabh105   =  l_fabh.fabh104                                     #本位幣二重估累折
      LET l_fabh.fabh106   =  l_faaj.faaj105                                     #本位幣二預留殘值
      LET l_fabh.fabh107   =  l_fabh.fabh106                                     #本位幣二重估殘值
      LET l_fabh.fabh108   =  l_faaj.faaj108                                     #本位幣二未折減額
      LET l_fabh.fabh109   =  l_faaj.faaj112                                     #本位幣二已計提減值準備
      LET l_fabh.fabh110   =  l_fabh.fabh109                                     #本位幣二減值準備金額
     
      LET l_fabh.fabh150   =  l_faaj.faaj151                                     #本位幣三幣別
      LET l_fabh.fabh151   =  l_faaj.faaj152                                     #本位幣三匯率
      LET l_fabh.fabh152   =  l_faaj.faaj153                                     #本位幣三成本
      LET l_fabh.fabh153   =  l_faaj.faaj167                                     #本位幣三調整成本
      LET l_fabh.fabh154   =  l_faaj.faaj154                                     #本位幣三累折
      LET l_fabh.fabh155   =  l_fabh.fabh154                                     #本位幣三重估累折
      LET l_fabh.fabh156   =  l_faaj.faaj155                                     #本位幣三預留殘值
      LET l_fabh.fabh157   =  l_fabh.fabh156                                     #本位幣三重估殘值
      LET l_fabh.fabh158   =  l_faaj.faaj158                                     #本位幣三未折減額
      LET l_fabh.fabh159   =  l_faaj.faaj162                                     #本位幣三已計提減值準備
      LET l_fabh.fabh160   =  l_fabh.fabh159                                     #本位幣三減值準備金額
      #161111-00028#7---modify--begin-----------     
     #INSERT INTO fabh_t VALUES(l_fabh.*)
      INSERT INTO fabh_t (fabhent,fabhld,fabhsite,fabhdocno,fabhseq,fabh000,fabh001,fabh002,fabh003,fabh004,fabh005,
                          fabh006,fabh007,fabh008,fabh009,fabh010,fabh011,fabh012,fabh013,fabh014,fabh015,fabh016,
                          fabh017,fabh018,fabh019,fabh020,fabh021,fabh022,fabh023,fabh024,fabh025,fabh026,fabh027,
                          fabh028,fabh029,fabh030,fabh031,fabh032,fabh033,fabh034,fabh035,fabh036,fabh037,fabh038,
                          fabh039,fabh040,fabh041,fabh042,fabh043,fabh060,fabh061,fabh062,fabh063,fabh064,fabh065,
                          fabh066,fabh067,fabh068,fabh069,fabh100,fabh101,fabh102,fabh103,fabh104,fabh105,fabh106,
                          fabh107,fabh108,fabh109,fabh110,fabh150,fabh151,fabh152,fabh153,fabh154,fabh155,fabh156,
                          fabh157,fabh158,fabh159,fabh160,fabh070,fabh071,fabh072,fabh073,fabh111,fabh161,fabh074,
                          fabh075,fabh076)
        VALUES(l_fabh.fabhent,l_fabh.fabhld,l_fabh.fabhsite,l_fabh.fabhdocno,l_fabh.fabhseq,l_fabh.fabh000,l_fabh.fabh001,l_fabh.fabh002,l_fabh.fabh003,l_fabh.fabh004,l_fabh.fabh005,
               l_fabh.fabh006,l_fabh.fabh007,l_fabh.fabh008,l_fabh.fabh009,l_fabh.fabh010,l_fabh.fabh011,l_fabh.fabh012,l_fabh.fabh013,l_fabh.fabh014,l_fabh.fabh015,l_fabh.fabh016,
               l_fabh.fabh017,l_fabh.fabh018,l_fabh.fabh019,l_fabh.fabh020,l_fabh.fabh021,l_fabh.fabh022,l_fabh.fabh023,l_fabh.fabh024,l_fabh.fabh025,l_fabh.fabh026,l_fabh.fabh027,
               l_fabh.fabh028,l_fabh.fabh029,l_fabh.fabh030,l_fabh.fabh031,l_fabh.fabh032,l_fabh.fabh033,l_fabh.fabh034,l_fabh.fabh035,l_fabh.fabh036,l_fabh.fabh037,l_fabh.fabh038,
               l_fabh.fabh039,l_fabh.fabh040,l_fabh.fabh041,l_fabh.fabh042,l_fabh.fabh043,l_fabh.fabh060,l_fabh.fabh061,l_fabh.fabh062,l_fabh.fabh063,l_fabh.fabh064,l_fabh.fabh065,
               l_fabh.fabh066,l_fabh.fabh067,l_fabh.fabh068,l_fabh.fabh069,l_fabh.fabh100,l_fabh.fabh101,l_fabh.fabh102,l_fabh.fabh103,l_fabh.fabh104,l_fabh.fabh105,l_fabh.fabh106,
               l_fabh.fabh107,l_fabh.fabh108,l_fabh.fabh109,l_fabh.fabh110,l_fabh.fabh150,l_fabh.fabh151,l_fabh.fabh152,l_fabh.fabh153,l_fabh.fabh154,l_fabh.fabh155,l_fabh.fabh156,
               l_fabh.fabh157,l_fabh.fabh158,l_fabh.fabh159,l_fabh.fabh160,l_fabh.fabh070,l_fabh.fabh071,l_fabh.fabh072,l_fabh.fabh073,l_fabh.fabh111,l_fabh.fabh161,l_fabh.fabh074,
               l_fabh.fabh075,l_fabh.fabh076)
      #161111-00028#7---modify--end-----------     
      
   END FOREACH

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
PRIVATE FUNCTION afat502_03_fabo_ins()
DEFINE  l_sql        STRING
#161111-00028#7---modify--begin-----------
#DEFINE  l_faah       RECORD LIKE faah_t.*
#DEFINE  l_faaj       RECORD LIKE faaj_t.*
#DEFINE  l_fabo       RECORD LIKE fabo_t.*
DEFINE l_faah RECORD  #固定資產基礎資料檔
       faahent LIKE faah_t.faahent, #企業編號
       faah000 LIKE faah_t.faah000, #產生批號
       faah001 LIKE faah_t.faah001, #卡片編號
       faah002 LIKE faah_t.faah002, #型態
       faah003 LIKE faah_t.faah003, #財產編號
       faah004 LIKE faah_t.faah004, #附號
       faah005 LIKE faah_t.faah005, #資產性質
       faah006 LIKE faah_t.faah006, #資產主要類型
       faah007 LIKE faah_t.faah007, #資產次要類型
       faah008 LIKE faah_t.faah008, #資產組
       faah009 LIKE faah_t.faah009, #供應供應商
       faah010 LIKE faah_t.faah010, #製造供應商
       faah011 LIKE faah_t.faah011, #產地
       faah012 LIKE faah_t.faah012, #名稱
       faah013 LIKE faah_t.faah013, #規格型號
       faah014 LIKE faah_t.faah014, #取得日期
       faah015 LIKE faah_t.faah015, #資產狀態
       faah016 LIKE faah_t.faah016, #取得方式
       faah017 LIKE faah_t.faah017, #單位
       faah018 LIKE faah_t.faah018, #數量
       faah019 LIKE faah_t.faah019, #在外數量
       faah020 LIKE faah_t.faah020, #幣別
       faah021 LIKE faah_t.faah021, #原幣單價
       faah022 LIKE faah_t.faah022, #原幣金額
       faah023 LIKE faah_t.faah023, #本幣單價
       faah024 LIKE faah_t.faah024, #本幣金額
       faah025 LIKE faah_t.faah025, #保管人員
       faah026 LIKE faah_t.faah026, #保管部門
       faah027 LIKE faah_t.faah027, #存放位置
       faah028 LIKE faah_t.faah028, #存放組織
       faah029 LIKE faah_t.faah029, #負責人員
       faah030 LIKE faah_t.faah030, #管理組織
       faah031 LIKE faah_t.faah031, #核算組織
       faah032 LIKE faah_t.faah032, #歸屬法人
       faah033 LIKE faah_t.faah033, #直接資本化
       faah034 LIKE faah_t.faah034, #保稅
       faah035 LIKE faah_t.faah035, #保險
       faah036 LIKE faah_t.faah036, #免稅
       faah037 LIKE faah_t.faah037, #抵押
       faah038 LIKE faah_t.faah038, #採購單號
       faah039 LIKE faah_t.faah039, #收貨單號
       faah040 LIKE faah_t.faah040, #帳款單號
       faah041 LIKE faah_t.faah041, #來源營運中心
       faah042 LIKE faah_t.faah042, #資產屬性
       faah043 LIKE faah_t.faah043, #預計總工作量
       faah044 LIKE faah_t.faah044, #已使用工作量
       faah045 LIKE faah_t.faah045, #帳款編號項次
       faahownid LIKE faah_t.faahownid, #資料所有者
       faahowndp LIKE faah_t.faahowndp, #資料所屬部門
       faahcrtid LIKE faah_t.faahcrtid, #資料建立者
       faahcrtdp LIKE faah_t.faahcrtdp, #資料建立部門
       faahcrtdt LIKE faah_t.faahcrtdt, #資料創建日
       faahmodid LIKE faah_t.faahmodid, #資料修改者
       faahmoddt LIKE faah_t.faahmoddt, #最近修改日
       faahstus LIKE faah_t.faahstus, #狀態碼
       faah046 LIKE faah_t.faah046, #備註
       faah047 LIKE faah_t.faah047, #保稅機器擷取否
       faah048 LIKE faah_t.faah048, #投資抵減狀態
       faah049 LIKE faah_t.faah049, #投資抵減合併碼
       faah050 LIKE faah_t.faah050, #抵減率
       faah051 LIKE faah_t.faah051, #投資抵減用途
       faah052 LIKE faah_t.faah052, #抵減金額
       faah053 LIKE faah_t.faah053, #已抵減金額
       faah054 LIKE faah_t.faah054, #投資抵減否
       faah055 LIKE faah_t.faah055, #投資抵減年限
       faah056 LIKE faah_t.faah056  #免稅狀態
       END RECORD 

DEFINE l_faaj RECORD  #固定資產帳套折舊資訊資料檔
       faajent LIKE faaj_t.faajent, #企業編碼
       faajld LIKE faaj_t.faajld, #帳套別編碼
       faajsite LIKE faaj_t.faajsite, #營運據點
       faaj000 LIKE faaj_t.faaj000, #批號
       faaj001 LIKE faaj_t.faaj001, #財產編號
       faaj002 LIKE faaj_t.faaj002, #附號
       faaj003 LIKE faaj_t.faaj003, #折舊方式
       faaj004 LIKE faaj_t.faaj004, #耐用年限(月數)
       faaj005 LIKE faaj_t.faaj005, #未使用年限(月數)
       faaj006 LIKE faaj_t.faaj006, #分攤方式
       faaj007 LIKE faaj_t.faaj007, #分攤類別
       faaj008 LIKE faaj_t.faaj008, #開始折舊年月
       faaj009 LIKE faaj_t.faaj009, #最近折舊年度
       faaj010 LIKE faaj_t.faaj010, #最近折舊期別
       faaj011 LIKE faaj_t.faaj011, #折畢再提
       faaj012 LIKE faaj_t.faaj012, #折畢再提預留殘值
       faaj013 LIKE faaj_t.faaj013, #折畢再提預留年月（數）
       faaj014 LIKE faaj_t.faaj014, #幣別
       faaj015 LIKE faaj_t.faaj015, #匯率
       faaj016 LIKE faaj_t.faaj016, #成本
       faaj017 LIKE faaj_t.faaj017, #累折
       faaj018 LIKE faaj_t.faaj018, #本期累折
       faaj019 LIKE faaj_t.faaj019, #預留殘值
       faaj020 LIKE faaj_t.faaj020, #調整成本
       faaj021 LIKE faaj_t.faaj021, #已提列減值準備
       faaj022 LIKE faaj_t.faaj022, #年折舊額
       faaj023 LIKE faaj_t.faaj023, #資產科目
       faaj024 LIKE faaj_t.faaj024, #累折科目
       faaj025 LIKE faaj_t.faaj025, #折舊科目
       faaj026 LIKE faaj_t.faaj026, #減值準備科目
       faaj027 LIKE faaj_t.faaj027, #銷帳減值準備
       faaj028 LIKE faaj_t.faaj028, #未折減額
       faaj029 LIKE faaj_t.faaj029, #第一個月未折減額
       faaj030 LIKE faaj_t.faaj030, #帳款編號
       faaj031 LIKE faaj_t.faaj031, #帳款編號項次
       faaj032 LIKE faaj_t.faaj032, #本期處置累折
       faaj033 LIKE faaj_t.faaj033, #處置數量
       faaj034 LIKE faaj_t.faaj034, #處置成本
       faaj035 LIKE faaj_t.faaj035, #處置累折
       faaj036 LIKE faaj_t.faaj036, #交易價格差異
       faaj037 LIKE faaj_t.faaj037, #卡片編號
       faaj038 LIKE faaj_t.faaj038, #資產狀態
       faaj039 LIKE faaj_t.faaj039, #部門
       faaj040 LIKE faaj_t.faaj040, #利潤/成本中心
       faaj041 LIKE faaj_t.faaj041, #區域
       faaj042 LIKE faaj_t.faaj042, #交易客商
       faaj043 LIKE faaj_t.faaj043, #帳款客商
       faaj044 LIKE faaj_t.faaj044, #客群
       faaj045 LIKE faaj_t.faaj045, #專案編號
       faaj046 LIKE faaj_t.faaj046, #WBS
       faaj047 LIKE faaj_t.faaj047, #人員
       faaj101 LIKE faaj_t.faaj101, #本位幣二幣別
       faaj102 LIKE faaj_t.faaj102, #本位幣二匯率
       faaj103 LIKE faaj_t.faaj103, #本位幣二成本
       faaj104 LIKE faaj_t.faaj104, #本位幣二累折
       faaj105 LIKE faaj_t.faaj105, #本位幣二預留殘值
       faaj106 LIKE faaj_t.faaj106, #本位幣二折畢再提預留殘值
       faaj107 LIKE faaj_t.faaj107, #本位幣二年折舊額
       faaj108 LIKE faaj_t.faaj108, #本位幣二未折減額
       faaj109 LIKE faaj_t.faaj109, #本位幣二第一月未折減額
       faaj110 LIKE faaj_t.faaj110, #本位幣二處置減值準備
       faaj111 LIKE faaj_t.faaj111, #本位幣二本年累折
       faaj112 LIKE faaj_t.faaj112, #本位幣二已提列減值準備
       faaj113 LIKE faaj_t.faaj113, #本位幣二處置成本
       faaj114 LIKE faaj_t.faaj114, #本位幣二處置累折
       faaj115 LIKE faaj_t.faaj115, #本位幣二本期處置累折
       faaj116 LIKE faaj_t.faaj116, #本位幣二交易價格差異
       faaj117 LIKE faaj_t.faaj117, #本位幣二調整成本
       faaj151 LIKE faaj_t.faaj151, #本位幣三幣別
       faaj152 LIKE faaj_t.faaj152, #本位幣三匯率
       faaj153 LIKE faaj_t.faaj153, #本位幣三成本
       faaj154 LIKE faaj_t.faaj154, #本位幣三累折
       faaj155 LIKE faaj_t.faaj155, #本位幣三預留殘值
       faaj156 LIKE faaj_t.faaj156, #本位幣三折畢再提預留殘值
       faaj157 LIKE faaj_t.faaj157, #本位幣三年折舊額
       faaj158 LIKE faaj_t.faaj158, #本位幣三未折減額
       faaj159 LIKE faaj_t.faaj159, #本位幣三第一月未折減額
       faaj160 LIKE faaj_t.faaj160, #本位幣三處置減值準備
       faaj161 LIKE faaj_t.faaj161, #本位幣三本年累折
       faaj162 LIKE faaj_t.faaj162, #本位幣三已提列減值準備
       faaj163 LIKE faaj_t.faaj163, #本位幣三處置成本
       faaj164 LIKE faaj_t.faaj164, #本位幣三處置累折
       faaj165 LIKE faaj_t.faaj165, #本位幣三本期處置累折
       faaj166 LIKE faaj_t.faaj166, #本位幣三交易價格差異
       faaj167 LIKE faaj_t.faaj167, #本位幣三調整成本
       faajownid LIKE faaj_t.faajownid, #資料所有者
       faajowndp LIKE faaj_t.faajowndp, #資料所屬部門
       faajcrtid LIKE faaj_t.faajcrtid, #資料建立者
       faajcrtdp LIKE faaj_t.faajcrtdp, #資料建立部門
       faajcrtdt LIKE faaj_t.faajcrtdt, #資料創建日
       faajmodid LIKE faaj_t.faajmodid, #資料修改者
       faajmoddt LIKE faaj_t.faajmoddt, #最近修改日
       faajstus LIKE faaj_t.faajstus, #狀態碼
       faaj048 LIKE faaj_t.faaj048 #資產分類
       END RECORD
DEFINE l_fabo RECORD  #資產出售單身檔
       faboent LIKE fabo_t.faboent, #企業編碼
       fabold LIKE fabo_t.fabold, #帳套
       fabodocno LIKE fabo_t.fabodocno, #異動單號
       faboseq LIKE fabo_t.faboseq, #項次
       fabo000 LIKE fabo_t.fabo000, #資產類型
       fabo001 LIKE fabo_t.fabo001, #財產編號
       fabo002 LIKE fabo_t.fabo002, #附號
       fabo003 LIKE fabo_t.fabo003, #卡片編號
       fabo004 LIKE fabo_t.fabo004, #未折減額
       fabo005 LIKE fabo_t.fabo005, #單位
       fabo006 LIKE fabo_t.fabo006, #單價
       fabo007 LIKE fabo_t.fabo007, #調撥/出售數量
       fabo008 LIKE fabo_t.fabo008, #成本
       fabo009 LIKE fabo_t.fabo009, #稅別
       fabo010 LIKE fabo_t.fabo010, #交易幣別
       fabo011 LIKE fabo_t.fabo011, #原幣匯率
       fabo012 LIKE fabo_t.fabo012, #原幣未稅金額
       fabo013 LIKE fabo_t.fabo013, #原幣稅額
       fabo014 LIKE fabo_t.fabo014, #原幣應收金額
       fabo015 LIKE fabo_t.fabo015, #本幣未稅金額
       fabo016 LIKE fabo_t.fabo016, #本幣稅額
       fabo017 LIKE fabo_t.fabo017, #本幣應收金額
       fabo018 LIKE fabo_t.fabo018, #處置成本
       fabo019 LIKE fabo_t.fabo019, #處置累折
       fabo020 LIKE fabo_t.fabo020, #處置減值準備
       fabo021 LIKE fabo_t.fabo021, #處置本期折舊
       fabo022 LIKE fabo_t.fabo022, #處置未折減額
       fabo023 LIKE fabo_t.fabo023, #異動原因
       fabo024 LIKE fabo_t.fabo024, #異動科目
       fabo025 LIKE fabo_t.fabo025, #處置預留殘值
       fabo026 LIKE fabo_t.fabo026, #累折科目
       fabo027 LIKE fabo_t.fabo027, #減值準備科目
       fabo028 LIKE fabo_t.fabo028, #資產科目
       fabo029 LIKE fabo_t.fabo029, #應收帳款科目
       fabo030 LIKE fabo_t.fabo030, #稅額科目
       fabo031 LIKE fabo_t.fabo031, #營運據點
       fabo032 LIKE fabo_t.fabo032, #部門
       fabo033 LIKE fabo_t.fabo033, #利潤/成本中心
       fabo034 LIKE fabo_t.fabo034, #區域
       fabo035 LIKE fabo_t.fabo035, #交易客商
       fabo036 LIKE fabo_t.fabo036, #帳款客商
       fabo037 LIKE fabo_t.fabo037, #客群
       fabo038 LIKE fabo_t.fabo038, #人員
       fabo039 LIKE fabo_t.fabo039, #專案編號
       fabo040 LIKE fabo_t.fabo040, #WBS
       fabo041 LIKE fabo_t.fabo041, #帳款編號
       fabo042 LIKE fabo_t.fabo042, #摘要
       fabo043 LIKE fabo_t.fabo043, #調出管理組織
       fabo044 LIKE fabo_t.fabo044, #調出所有組織
       fabo045 LIKE fabo_t.fabo045, #調出核算組織
       fabo046 LIKE fabo_t.fabo046, #調入管理組織
       fabo047 LIKE fabo_t.fabo047, #調入所有組織
       fabo048 LIKE fabo_t.fabo048, #調入核算組織
       fabo049 LIKE fabo_t.fabo049, #處分損益
       fabo050 LIKE fabo_t.fabo050, #應收帳款單號
       fabo051 LIKE fabo_t.fabo051, #交易價格差異
       fabo052 LIKE fabo_t.fabo052, #應付帳款單號
       fabo053 LIKE fabo_t.fabo053, #已計提減值準備
       fabo054 LIKE fabo_t.fabo054, #經營方式
       fabo055 LIKE fabo_t.fabo055, #通路
       fabo056 LIKE fabo_t.fabo056, #品牌
       fabo060 LIKE fabo_t.fabo060, #自由核算項一
       fabo061 LIKE fabo_t.fabo061, #自由核算項二
       fabo062 LIKE fabo_t.fabo062, #自由核算項三
       fabo063 LIKE fabo_t.fabo063, #自由核算項四
       fabo064 LIKE fabo_t.fabo064, #自由核算項五
       fabo065 LIKE fabo_t.fabo065, #自由核算項六
       fabo066 LIKE fabo_t.fabo066, #自由核算項七
       fabo067 LIKE fabo_t.fabo067, #自由核算項八
       fabo068 LIKE fabo_t.fabo068, #自由核算項九
       fabo069 LIKE fabo_t.fabo069, #自由核算項十
       fabo101 LIKE fabo_t.fabo101, #本位幣二幣別
       fabo102 LIKE fabo_t.fabo102, #本位幣二匯率
       fabo103 LIKE fabo_t.fabo103, #本位幣二未稅金額
       fabo104 LIKE fabo_t.fabo104, #本位幣二稅額
       fabo105 LIKE fabo_t.fabo105, #本位幣二應收金額
       fabo106 LIKE fabo_t.fabo106, #本位幣二處份損益
       fabo107 LIKE fabo_t.fabo107, #本位幣二處置成本
       fabo108 LIKE fabo_t.fabo108, #本位幣二處置累折
       fabo109 LIKE fabo_t.fabo109, #本位幣二處置減值準備
       fabo110 LIKE fabo_t.fabo110, #本位幣二本期處置折舊
       fabo111 LIKE fabo_t.fabo111, #本位幣二處置後未折減額
       fabo150 LIKE fabo_t.fabo150, #本位幣三幣別
       fabo151 LIKE fabo_t.fabo151, #本位幣三匯率
       fabo152 LIKE fabo_t.fabo152, #本位幣三未稅金額
       fabo153 LIKE fabo_t.fabo153, #本位幣三稅額
       fabo154 LIKE fabo_t.fabo154, #本位幣三應收金額
       fabo155 LIKE fabo_t.fabo155, #本位幣三處份損益
       fabo156 LIKE fabo_t.fabo156, #本位幣三處置成本
       fabo157 LIKE fabo_t.fabo157, #本位幣三處置累折
       fabo158 LIKE fabo_t.fabo158, #本位幣三處置減值準備
       fabo159 LIKE fabo_t.fabo159, #本位幣三本期處置折舊
       fabo160 LIKE fabo_t.fabo160, #本位幣三處置後未折減額
       fabo112 LIKE fabo_t.fabo112, #本位幣二處置預留殘值
       fabo161 LIKE fabo_t.fabo161  #本位幣三處置預留殘值
       END RECORD

#161111-00028#7---modify--end-----------
DEFINE  l_ooag004    LIKE ooag_t.ooag004
DEFINE  l_origin_str STRING
DEFINE  tok          base.StringTokenizer
DEFINE  l_str        STRING
DEFINE  l_glaacomp   LIKE glaa_t.glaacomp
DEFINE  l_faal003    LIKE faal_t.faal003 #20141223 add by chenying 
DEFINE  l_year       LIKE type_t.num5    #20141223 add by chenying 
DEFINE  l_month      LIKE type_t.num5    #20141223 add by chenying
DEFINE  l_n          LIKE type_t.num5    #20141223 add by chenying
DEFINE  l_para_data  LIKE ooab_t.ooab002
DEFINE  l_pmab105    LIKE pmab_t.pmab105
DEFINE  l_faah015    LIKE faah_t.faah015
DEFINE  l_errmsg     STRING              #161017-00032#1 add lujh
DEFINE  l_yy         LIKE faaj_t.faaj008  #161229-00007#1 add
DEFINE  l_mm         LIKE faaj_t.faaj008  #161229-00007#1 add
DEFINE  l_ym         LIKE faaj_t.faaj008  #161229-00007#1 add

  #161111-00028#7---modify--begin-----------
  #SELECT * INTO g_fabg.* 
   SELECT fabgent,fabgcomp,fabgld,fabgdocno,fabgdocdt,fabgsite,fabg001,fabg002,fabg003,fabg004,fabg005,fabg006,
          fabg007,fabg008,fabg009,fabg010,fabg011,fabg012,fabg013,fabg014,fabg015,fabg016,fabg017,fabg018,fabg019,
          fabgstus,fabgownid,fabgowndp,fabgcrtid,fabgcrtdp,fabgcrtdt,fabgmodid,fabgmoddt,fabgcnfid,fabgcnfdt,
          fabgpstid,fabgpstdt,fabg020 INTO g_fabg.* 
   #161111-00028#7---modify--end-----------
   FROM fabg_t WHERE fabgent = g_enterprise AND fabgdocno = g_fabgdocno AND fabgld = g_fabgld
   SELECT glaacomp INTO l_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_fabgld
   
   CALL s_fin_create_account_center_tmp() 
   CALL s_fin_account_center_sons_query('5',g_fabg.fabgsite,g_fabg.fabgdocdt,'1')
   CALL s_fin_account_center_comp_str() RETURNING l_origin_str
   
   CALL afat502_03_change_to_sql(l_origin_str)RETURNING l_origin_str
   LET l_origin_str = "(",l_origin_str,")"
   
#   LET l_sql = " SELECT faah_t.*,faaj_t.* FROM faah_t,faaj_t",                                                             #160627-00025#1 mark
   LET l_sql = " SELECT faah001,faah002,faah003,faah004,faah006,faah007,faah008,faah012,faah013,faah015,faah017,faah018, ", #160627-00025#1 add
               #161111-00028#7---modify--begin-----------             
             # "        faaj_t.* FROM faah_t,faaj_t",                                                                       #160627-00025#1 add 
               "faajent,faajld,faajsite,faaj000,faaj001,faaj002,faaj003,faaj004,faaj005,faaj006,faaj007,",
               "faaj008,faaj009,faaj010,faaj011,faaj012,faaj013,faaj014,faaj015,faaj016,faaj017,faaj018,",
               "faaj019,faaj020,faaj021,faaj022,faaj023,faaj024,faaj025,faaj026,faaj027,faaj028,faaj029,",
               "faaj030,faaj031,faaj032,faaj033,faaj034,faaj035,faaj036,faaj037,faaj038,faaj039,faaj040,",
               "faaj041,faaj042,faaj043,faaj044,faaj045,faaj046,faaj047,faaj101,faaj102,faaj103,faaj104,",
               "faaj105,faaj106,faaj107,faaj108,faaj109,faaj110,faaj111,faaj112,faaj113,faaj114,faaj115,",
               "faaj116,faaj117,faaj151,faaj152,faaj153,faaj154,faaj155,faaj156,faaj157,faaj158,faaj159,",
               "faaj160,faaj161,faaj162,faaj163,faaj164,faaj165,faaj166,faaj167,faajownid,faajowndp,",
               "faajcrtid,faajcrtdp,faajcrtdt,faajmodid,faajmoddt,faajstus,faaj048 FROM faah_t,faaj_t",   
             #161111-00028#7---modify--end-----------   
               "  WHERE faahent = ",g_enterprise," AND faahstus = 'Y' AND faah015 NOT IN ('0','5','6','8','10') ",
               "    AND faahent = faajent AND faah001 = faaj037 AND faah003 = faaj001 AND faah004 = faaj002 AND faajld = '",g_fabgld,"'",
               "    AND faah028 IN ( SELECT ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"'",
               "    AND ooef017 = '",l_glaacomp,"' AND ooef001 IN ",l_origin_str,")",
               "    AND ",g_wc CLIPPED

    #160426-00014#7 add s---                       
	 IF g_prog = "afat504" THEN 
	    LET l_sql = l_sql," AND faah036 != '1' "
    END IF	
    #160426-00014#7 add e--- 
               
   PREPARE afat502_03_faah_prep1 FROM l_sql
   DECLARE afat502_03_faah_curs1 CURSOR FOR afat502_03_faah_prep1

    #161229-00007#1 add s---
    CALL cl_get_para(g_enterprise,l_glaacomp,'S-FIN-9018') RETURNING l_year
    CALL cl_get_para(g_enterprise,l_glaacomp,'S-FIN-9019') RETURNING l_month    
    LET l_yy = l_year
    LET l_mm = l_month
    LET l_yy = l_yy USING "&&&&"
    LET l_mm = l_mm USING "&&"
    LET l_ym = l_yy,l_mm      
    #161229-00007#1 add e---
    
#   FOREACH afat502_03_faah_curs1 INTO l_faah.*,l_faaj.*                                                   #160627-00025#1 mark
   FOREACH afat502_03_faah_curs1 INTO l_faah.faah001,l_faah.faah002,l_faah.faah003,l_faah.faah004,         #160627-00025#1 add
                                      l_faah.faah006,l_faah.faah007,l_faah.faah008,l_faah.faah012,         #160627-00025#1 add
                                      l_faah.faah013,l_faah.faah015,l_faah.faah017,l_faah.faah018,l_faaj.* #160627-00025#1 add                                                                                #160627-00025#1 add
      IF l_faaj.faaj008 < l_ym AND l_faaj.faaj003 <> '5' AND NOT cl_null(l_faaj.faaj003) THEN  #161229-00007#1 add 
         #20141223 add by chenying
         #检查当月是否计提折旧
         SELECT faal003 INTO l_faal003 FROM faal_t 
          WHERE faalent = g_enterprise AND faalld = g_fabgld AND faal001 = l_faah.faah006
         
         IF STATUS =100 OR cl_null(l_faal003) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'afa-00183'     
            LET g_errparam.extend = g_fabgld||'|'||l_faah.faah006
            LET g_errparam.popup = TRUE
            CALL cl_err()      
            CONTINUE FOREACH
         ELSE
            LET l_year = YEAR(g_fabg.fabgdocdt)
            LET l_month = MONTH(g_fabg.fabgdocdt)
            IF l_faal003 = 'Y' THEN   
               SELECT COUNT(*) INTO l_n FROM faam_t
                 WHERE faament = g_enterprise AND faamld = g_fabgld
                   AND faam000 = l_faah.faah001 AND faam001 = l_faah.faah003 AND faam002= l_faah.faah004
                   AND faam004 = l_year AND faam005 = l_month
                IF l_n = 0 THEN 
                   SELECT faah015 INTO l_faah015
                     FROM faah_t
                    WHERE faahent = g_enterprise
                      AND faah001 = l_faah.faah001
                      AND faah003 = l_faah.faah003
                      AND faah004 = l_faah.faah004
                   IF l_faah015 <> '4' THEN 
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = 'afa-00280'
                      LET g_errparam.extend =l_faah.faah003||'|'||l_faah.faah004||'|'||l_faah.faah001 
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                      CONTINUE FOREACH
                   END IF 
                END IF
            END IF
         END IF      
         #20141223 add by chenying
      END IF #161229-00007#1 add   
      
      #161017-00032#1--add--str--lujh
      LET l_n = 0
      SELECT COUNT(1) INTO l_n 
        FROM fabg_t 
        LEFT OUTER JOIN fabo_t 
          ON fabgent = faboent AND fabgdocno = fabodocno 
       WHERE faboent = g_enterprise 
         AND fabgld  = g_fabgld 
         AND fabo001 = l_faah.faah003
         AND fabo002 = l_faah.faah004
         AND fabo003 = l_faah.faah001
         AND fabgstus IN ('N','Y')    
         AND fabg005 IN ('4')
         AND fabgdocno <> g_fabgdocno
         
      IF l_n > 0 THEN 
          LET l_errmsg = l_faah.faah003||'/'||l_faah.faah004||'/'||l_faah.faah001
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = l_errmsg
          LET g_errparam.code   = 'afa-00458'     
          LET g_errparam.popup  = TRUE 
          CALL cl_err() 
          CONTINUE FOREACH
      END IF
      #161017-00032#1--add--end--lujh

      
      SELECT MAX(faboseq) INTO l_fabo.faboseq
        FROM fabo_t
       WHERE faboent = g_enterprise
         AND fabodocno = g_fabgdocno AND fabold = g_fabgld
      IF cl_null(l_fabo.faboseq) THEN
         LET l_fabo.faboseq = 1
      ELSE
         LET l_fabo.faboseq = l_fabo.faboseq +1
      END IF
      LET l_fabo.faboent = g_enterprise 
      LET l_fabo.fabold  = g_fabgld
      LET l_fabo.fabodocno = g_fabgdocno
      LET l_fabo.fabo000 = l_faah.faah002
      LET l_fabo.fabo001 = l_faah.faah003
      LET l_fabo.fabo002 = l_faah.faah004
      LET l_fabo.fabo003 = l_faah.faah001

      LET l_fabo.fabo004 = l_faaj.faaj028                   #未折金额
      LET l_fabo.fabo005 = l_faah.faah017                   #单位
      LET l_fabo.fabo006 = 0                                #单价
      LET l_fabo.fabo007 = l_faah.faah018-l_faaj.faaj033    #调拨/出售数量
      LET l_fabo.fabo008 = l_faaj.faaj016+l_faaj.faaj020-l_faaj.faaj034          #成本
      LET l_fabo.fabo009 = g_fabg.fabg013                   #稅別
      LET l_fabo.fabo010 = g_fabg.fabg015                   #币别
      LET l_fabo.fabo011 = g_fabg.fabg016                   #汇率
      LET l_fabo.fabo012 = 0                                #原幣稅前金額
      LET l_fabo.fabo013 = 0                                #原幣稅額
      LET l_fabo.fabo014 = 0                                #原幣應收金額
      LET l_fabo.fabo015 = 0                                #本幣稅前金額
      LET l_fabo.fabo016 = 0                                #本幣稅額
      LET l_fabo.fabo017 = 0                                #本幣應收金額
      LET l_fabo.fabo018 = l_fabo.fabo008                   #處置成本
      LET l_fabo.fabo019 = l_faaj.faaj017-l_faaj.faaj035    #處置累折      
      LET l_fabo.fabo020 = l_faaj.faaj021-l_faaj.faaj027    #處置減值準備     
      LET l_fabo.fabo021 = l_faaj.faaj018-l_faaj.faaj032    #處置本期折舊
      LET l_fabo.fabo022 = l_fabo.fabo004                   #處置未折減額
      
      SELECT glaacomp INTO l_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_fabgld
      CALL cl_get_para(g_enterprise,l_glaacomp,'S-FIN-9017') RETURNING l_para_data     
      #出售
      IF g_fabg.fabg005 = '4' THEN
         IF l_para_data = 'Y' THEN        
            SELECT glab005 INTO l_fabo.fabo024 FROM glab_t
             WHERE glabent=g_enterprise AND glabld=g_fabgld
               AND glab002='25' AND glab001='90' AND glab003='9902_12'
         ELSE
            SELECT glab005 INTO l_fabo.fabo024 FROM glab_t
             WHERE glabent=g_enterprise AND glabld=g_fabgld
               AND glab002='40' AND glab001='90' AND glab003='9902_05'       
         END IF 
      END IF 
      LET l_fabo.fabo025 = l_faaj.faaj019                   #處置預留殘值     
      LET l_fabo.fabo026 = l_faaj.faaj024                   #累計折舊科目
      LET l_fabo.fabo027 = l_faaj.faaj026                   #減值準備科目
      LET l_fabo.fabo028 = l_faaj.faaj023                   #資產科目
      
      SELECT glab005 INTO l_fabo.fabo029 FROM glab_t
       WHERE glabent = g_enterprise AND glabld = g_fabgld
         AND glab001 = '90' AND glab002 = '40' AND glab003 = '9902_05'     #應收帳款科目
         
          
      #應收有帳套時要取帳套慣用稅別設定會科
      SELECT glab005 INTO l_fabo.fabo030
        FROM glab_t
       WHERE glabent = g_enterprise
         AND glabld = g_fabgld
         AND glab001 = '14'
         AND glab002 = '2'  # 銷項
         AND glab003 = l_fabo.fabo009
      #取不到會科時表示以常用會科設定
      IF cl_null(l_fabo.fabo030) THEN
         SELECT glab005 INTO l_fabo.fabo030
           FROM glab_t
          WHERE glabent = g_enterprise
            AND glabld = g_fabgld
            AND glab001 ='12'
            AND glab002  ='9711'
            AND glab003 = '9711_91'
      END IF
      #再取不到，取帐款客户对应的账款类别设定的科目axri011
      IF cl_null(l_fabo.fabo030) THEN 
          SELECT pmab105 INTO l_pmab105 FROM pmab_t
           WHERE pmabent = g_enterprise AND pmabsite = g_fabg.fabgsite AND pmab001 =g_fabg.fabg006
                      
          SELECT glab005 INTO l_fabo.fabo030 FROM glab_t 
           WHERE glabld = g_fabgld
             AND glab001 = '14'              
             AND glab003 = '8304_29'
             AND glabent = g_enterprise
             AND glab002 =  l_pmab105                           
       END IF   
    
      LET l_fabo.fabo031 = l_faaj.faajsite               #营运据点          
      LET l_fabo.fabo032 = ''                            #部门
      LET l_fabo.fabo033 = ''                            #利润/成本中心
      LET l_fabo.fabo034 = ''                            #区域
      LET l_fabo.fabo035 = l_faaj.faaj042                #交易客商
      LET l_fabo.fabo036 = l_faaj.faaj043                #帳款客商
      LET l_fabo.fabo037 = ''                            #客群
      LET l_fabo.fabo038 = ''                            #人员
      LET l_fabo.fabo039 = l_faaj.faaj045                #专案编号
      LET l_fabo.fabo040 = l_faaj.faaj046                #WBS
      LET l_fabo.fabo041 = ''                            #账款编号
      #LET l_fabo.fabo049 =                              #处分损益
      LET l_fabo.fabo053 = l_faaj.faaj021                #已计提减值准备
      
      LET l_fabo.fabo101 = l_faaj.faaj101                #本位币二币别
      LET l_fabo.fabo102 = l_faaj.faaj102                #本位币二汇率
      LET l_fabo.fabo103 = 0                             #本位币二税前金额
      LET l_fabo.fabo104 = 0                             #本位币二税额
      LET l_fabo.fabo105 = 0                             #本位币二应收金额
      LET l_fabo.fabo106 = 0                             #本位币二处份损益
      LET l_fabo.fabo107 = l_faaj.faaj113                #本位币二处置成本
      LET l_fabo.fabo108 = l_faaj.faaj104                #本位币二处置累折
      LET l_fabo.fabo109 = l_faaj.faaj110                #本位币二处置减值准备
      LET l_fabo.fabo110 = l_faaj.faaj115                #本位币二本期处置折旧
      LET l_fabo.fabo111 = l_faaj.faaj108                #本位币二处置后未折减额
      
      LET l_fabo.fabo150 = l_faaj.faaj151                #本位币三币别
      LET l_fabo.fabo151 = l_faaj.faaj152                #本位币三汇率
      LET l_fabo.fabo152 = 0                             #本位币三税前金额
      LET l_fabo.fabo153 = 0                             #本位币三税额
      LET l_fabo.fabo154 = 0                             #本位币三应收金额
      LET l_fabo.fabo155 = 0                             #本位币三处份损益
      LET l_fabo.fabo156 = l_faaj.faaj163                #本位币三处置成本
      LET l_fabo.fabo157 = l_faaj.faaj164                #本位币三处置累折
      LET l_fabo.fabo158 = l_faaj.faaj160                #本位币三处置减值准备
      LET l_fabo.fabo159 = l_faaj.faaj165                #本位币三本期处置折旧
      LET l_fabo.fabo160 = l_faaj.faaj158                #本位币三处置后未折减额
      
      #161111-00028#7---modify--begin-----------  
      #INSERT INTO fabo_t VALUES(l_fabo.*)
      INSERT INTO fabo_t (faboent,fabold,fabodocno,faboseq,fabo000,fabo001,fabo002,fabo003,fabo004,fabo005,fabo006,
                          fabo007,fabo008,fabo009,fabo010,fabo011,fabo012,fabo013,fabo014,fabo015,fabo016,fabo017,
                          fabo018,fabo019,fabo020,fabo021,fabo022,fabo023,fabo024,fabo025,fabo026,fabo027,fabo028,
                          fabo029,fabo030,fabo031,fabo032,fabo033,fabo034,fabo035,fabo036,fabo037,fabo038,fabo039,
                          fabo040,fabo041,fabo042,fabo043,fabo044,fabo045,fabo046,fabo047,fabo048,fabo049,fabo050,
                          fabo051,fabo052,fabo053,fabo054,fabo055,fabo056,fabo060,fabo061,fabo062,fabo063,fabo064,
                          fabo065,fabo066,fabo067,fabo068,fabo069,fabo101,fabo102,fabo103,fabo104,fabo105,fabo106,
                          fabo107,fabo108,fabo109,fabo110,fabo111,fabo150,fabo151,fabo152,fabo153,fabo154,fabo155,
                          fabo156,fabo157,fabo158,fabo159,fabo160,fabo112,fabo161)
        VALUES(l_fabo.faboent,l_fabo.fabold,l_fabo.fabodocno,l_fabo.faboseq,l_fabo.fabo000,l_fabo.fabo001,l_fabo.fabo002,l_fabo.fabo003,l_fabo.fabo004,l_fabo.fabo005,l_fabo.fabo006,
               l_fabo.fabo007,l_fabo.fabo008,l_fabo.fabo009,l_fabo.fabo010,l_fabo.fabo011,l_fabo.fabo012,l_fabo.fabo013,l_fabo.fabo014,l_fabo.fabo015,l_fabo.fabo016,l_fabo.fabo017,
               l_fabo.fabo018,l_fabo.fabo019,l_fabo.fabo020,l_fabo.fabo021,l_fabo.fabo022,l_fabo.fabo023,l_fabo.fabo024,l_fabo.fabo025,l_fabo.fabo026,l_fabo.fabo027,l_fabo.fabo028,
               l_fabo.fabo029,l_fabo.fabo030,l_fabo.fabo031,l_fabo.fabo032,l_fabo.fabo033,l_fabo.fabo034,l_fabo.fabo035,l_fabo.fabo036,l_fabo.fabo037,l_fabo.fabo038,l_fabo.fabo039,
               l_fabo.fabo040,l_fabo.fabo041,l_fabo.fabo042,l_fabo.fabo043,l_fabo.fabo044,l_fabo.fabo045,l_fabo.fabo046,l_fabo.fabo047,l_fabo.fabo048,l_fabo.fabo049,l_fabo.fabo050,
               l_fabo.fabo051,l_fabo.fabo052,l_fabo.fabo053,l_fabo.fabo054,l_fabo.fabo055,l_fabo.fabo056,l_fabo.fabo060,l_fabo.fabo061,l_fabo.fabo062,l_fabo.fabo063,l_fabo.fabo064,
               l_fabo.fabo065,l_fabo.fabo066,l_fabo.fabo067,l_fabo.fabo068,l_fabo.fabo069,l_fabo.fabo101,l_fabo.fabo102,l_fabo.fabo103,l_fabo.fabo104,l_fabo.fabo105,l_fabo.fabo106,
               l_fabo.fabo107,l_fabo.fabo108,l_fabo.fabo109,l_fabo.fabo110,l_fabo.fabo111,l_fabo.fabo150,l_fabo.fabo151,l_fabo.fabo152,l_fabo.fabo153,l_fabo.fabo154,l_fabo.fabo155,
               l_fabo.fabo156,l_fabo.fabo157,l_fabo.fabo158,l_fabo.fabo159,l_fabo.fabo160,l_fabo.fabo112,l_fabo.fabo161)
      #161111-00028#7---modify--end-----------  
   END FOREACH
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
PUBLIC FUNCTION afat502_03_change_to_sql(p_wc)
   DEFINE p_wc       STRING
   DEFINE r_wc       STRING
   DEFINE tok        base.StringTokenizer
   DEFINE l_str      STRING

   LET tok = base.StringTokenizer.create(p_wc,",")
   WHILE tok.hasMoreTokens()
      IF cl_null(l_str) THEN
         LET l_str = tok.nextToken()
      ELSE
         LET l_str = l_str,"','",tok.nextToken()
      END IF
   END WHILE
   LET r_wc = "'",l_str,"'"

   RETURN r_wc

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
PRIVATE FUNCTION afat502_03_fabp_ins()
DEFINE  l_sql        STRING
#161111-00028#7---modify--begin-----------
#DEFINE  l_faah       RECORD LIKE faah_t.*
#DEFINE  l_faaj       RECORD LIKE faaj_t.*
#DEFINE  l_fabp       RECORD LIKE fabp_t.*
DEFINE l_faah RECORD  #固定資產基礎資料檔
       faahent LIKE faah_t.faahent, #企業編號
       faah000 LIKE faah_t.faah000, #產生批號
       faah001 LIKE faah_t.faah001, #卡片編號
       faah002 LIKE faah_t.faah002, #型態
       faah003 LIKE faah_t.faah003, #財產編號
       faah004 LIKE faah_t.faah004, #附號
       faah005 LIKE faah_t.faah005, #資產性質
       faah006 LIKE faah_t.faah006, #資產主要類型
       faah007 LIKE faah_t.faah007, #資產次要類型
       faah008 LIKE faah_t.faah008, #資產組
       faah009 LIKE faah_t.faah009, #供應供應商
       faah010 LIKE faah_t.faah010, #製造供應商
       faah011 LIKE faah_t.faah011, #產地
       faah012 LIKE faah_t.faah012, #名稱
       faah013 LIKE faah_t.faah013, #規格型號
       faah014 LIKE faah_t.faah014, #取得日期
       faah015 LIKE faah_t.faah015, #資產狀態
       faah016 LIKE faah_t.faah016, #取得方式
       faah017 LIKE faah_t.faah017, #單位
       faah018 LIKE faah_t.faah018, #數量
       faah019 LIKE faah_t.faah019, #在外數量
       faah020 LIKE faah_t.faah020, #幣別
       faah021 LIKE faah_t.faah021, #原幣單價
       faah022 LIKE faah_t.faah022, #原幣金額
       faah023 LIKE faah_t.faah023, #本幣單價
       faah024 LIKE faah_t.faah024, #本幣金額
       faah025 LIKE faah_t.faah025, #保管人員
       faah026 LIKE faah_t.faah026, #保管部門
       faah027 LIKE faah_t.faah027, #存放位置
       faah028 LIKE faah_t.faah028, #存放組織
       faah029 LIKE faah_t.faah029, #負責人員
       faah030 LIKE faah_t.faah030, #管理組織
       faah031 LIKE faah_t.faah031, #核算組織
       faah032 LIKE faah_t.faah032, #歸屬法人
       faah033 LIKE faah_t.faah033, #直接資本化
       faah034 LIKE faah_t.faah034, #保稅
       faah035 LIKE faah_t.faah035, #保險
       faah036 LIKE faah_t.faah036, #免稅
       faah037 LIKE faah_t.faah037, #抵押
       faah038 LIKE faah_t.faah038, #採購單號
       faah039 LIKE faah_t.faah039, #收貨單號
       faah040 LIKE faah_t.faah040, #帳款單號
       faah041 LIKE faah_t.faah041, #來源營運中心
       faah042 LIKE faah_t.faah042, #資產屬性
       faah043 LIKE faah_t.faah043, #預計總工作量
       faah044 LIKE faah_t.faah044, #已使用工作量
       faah045 LIKE faah_t.faah045, #帳款編號項次
       faahownid LIKE faah_t.faahownid, #資料所有者
       faahowndp LIKE faah_t.faahowndp, #資料所屬部門
       faahcrtid LIKE faah_t.faahcrtid, #資料建立者
       faahcrtdp LIKE faah_t.faahcrtdp, #資料建立部門
       faahcrtdt LIKE faah_t.faahcrtdt, #資料創建日
       faahmodid LIKE faah_t.faahmodid, #資料修改者
       faahmoddt LIKE faah_t.faahmoddt, #最近修改日
       faahstus LIKE faah_t.faahstus, #狀態碼
       faah046 LIKE faah_t.faah046, #備註
       faah047 LIKE faah_t.faah047, #保稅機器擷取否
       faah048 LIKE faah_t.faah048, #投資抵減狀態
       faah049 LIKE faah_t.faah049, #投資抵減合併碼
       faah050 LIKE faah_t.faah050, #抵減率
       faah051 LIKE faah_t.faah051, #投資抵減用途
       faah052 LIKE faah_t.faah052, #抵減金額
       faah053 LIKE faah_t.faah053, #已抵減金額
       faah054 LIKE faah_t.faah054, #投資抵減否
       faah055 LIKE faah_t.faah055, #投資抵減年限
       faah056 LIKE faah_t.faah056  #免稅狀態
       END RECORD 

DEFINE l_faaj RECORD  #固定資產帳套折舊資訊資料檔
       faajent LIKE faaj_t.faajent, #企業編碼
       faajld LIKE faaj_t.faajld, #帳套別編碼
       faajsite LIKE faaj_t.faajsite, #營運據點
       faaj000 LIKE faaj_t.faaj000, #批號
       faaj001 LIKE faaj_t.faaj001, #財產編號
       faaj002 LIKE faaj_t.faaj002, #附號
       faaj003 LIKE faaj_t.faaj003, #折舊方式
       faaj004 LIKE faaj_t.faaj004, #耐用年限(月數)
       faaj005 LIKE faaj_t.faaj005, #未使用年限(月數)
       faaj006 LIKE faaj_t.faaj006, #分攤方式
       faaj007 LIKE faaj_t.faaj007, #分攤類別
       faaj008 LIKE faaj_t.faaj008, #開始折舊年月
       faaj009 LIKE faaj_t.faaj009, #最近折舊年度
       faaj010 LIKE faaj_t.faaj010, #最近折舊期別
       faaj011 LIKE faaj_t.faaj011, #折畢再提
       faaj012 LIKE faaj_t.faaj012, #折畢再提預留殘值
       faaj013 LIKE faaj_t.faaj013, #折畢再提預留年月（數）
       faaj014 LIKE faaj_t.faaj014, #幣別
       faaj015 LIKE faaj_t.faaj015, #匯率
       faaj016 LIKE faaj_t.faaj016, #成本
       faaj017 LIKE faaj_t.faaj017, #累折
       faaj018 LIKE faaj_t.faaj018, #本期累折
       faaj019 LIKE faaj_t.faaj019, #預留殘值
       faaj020 LIKE faaj_t.faaj020, #調整成本
       faaj021 LIKE faaj_t.faaj021, #已提列減值準備
       faaj022 LIKE faaj_t.faaj022, #年折舊額
       faaj023 LIKE faaj_t.faaj023, #資產科目
       faaj024 LIKE faaj_t.faaj024, #累折科目
       faaj025 LIKE faaj_t.faaj025, #折舊科目
       faaj026 LIKE faaj_t.faaj026, #減值準備科目
       faaj027 LIKE faaj_t.faaj027, #銷帳減值準備
       faaj028 LIKE faaj_t.faaj028, #未折減額
       faaj029 LIKE faaj_t.faaj029, #第一個月未折減額
       faaj030 LIKE faaj_t.faaj030, #帳款編號
       faaj031 LIKE faaj_t.faaj031, #帳款編號項次
       faaj032 LIKE faaj_t.faaj032, #本期處置累折
       faaj033 LIKE faaj_t.faaj033, #處置數量
       faaj034 LIKE faaj_t.faaj034, #處置成本
       faaj035 LIKE faaj_t.faaj035, #處置累折
       faaj036 LIKE faaj_t.faaj036, #交易價格差異
       faaj037 LIKE faaj_t.faaj037, #卡片編號
       faaj038 LIKE faaj_t.faaj038, #資產狀態
       faaj039 LIKE faaj_t.faaj039, #部門
       faaj040 LIKE faaj_t.faaj040, #利潤/成本中心
       faaj041 LIKE faaj_t.faaj041, #區域
       faaj042 LIKE faaj_t.faaj042, #交易客商
       faaj043 LIKE faaj_t.faaj043, #帳款客商
       faaj044 LIKE faaj_t.faaj044, #客群
       faaj045 LIKE faaj_t.faaj045, #專案編號
       faaj046 LIKE faaj_t.faaj046, #WBS
       faaj047 LIKE faaj_t.faaj047, #人員
       faaj101 LIKE faaj_t.faaj101, #本位幣二幣別
       faaj102 LIKE faaj_t.faaj102, #本位幣二匯率
       faaj103 LIKE faaj_t.faaj103, #本位幣二成本
       faaj104 LIKE faaj_t.faaj104, #本位幣二累折
       faaj105 LIKE faaj_t.faaj105, #本位幣二預留殘值
       faaj106 LIKE faaj_t.faaj106, #本位幣二折畢再提預留殘值
       faaj107 LIKE faaj_t.faaj107, #本位幣二年折舊額
       faaj108 LIKE faaj_t.faaj108, #本位幣二未折減額
       faaj109 LIKE faaj_t.faaj109, #本位幣二第一月未折減額
       faaj110 LIKE faaj_t.faaj110, #本位幣二處置減值準備
       faaj111 LIKE faaj_t.faaj111, #本位幣二本年累折
       faaj112 LIKE faaj_t.faaj112, #本位幣二已提列減值準備
       faaj113 LIKE faaj_t.faaj113, #本位幣二處置成本
       faaj114 LIKE faaj_t.faaj114, #本位幣二處置累折
       faaj115 LIKE faaj_t.faaj115, #本位幣二本期處置累折
       faaj116 LIKE faaj_t.faaj116, #本位幣二交易價格差異
       faaj117 LIKE faaj_t.faaj117, #本位幣二調整成本
       faaj151 LIKE faaj_t.faaj151, #本位幣三幣別
       faaj152 LIKE faaj_t.faaj152, #本位幣三匯率
       faaj153 LIKE faaj_t.faaj153, #本位幣三成本
       faaj154 LIKE faaj_t.faaj154, #本位幣三累折
       faaj155 LIKE faaj_t.faaj155, #本位幣三預留殘值
       faaj156 LIKE faaj_t.faaj156, #本位幣三折畢再提預留殘值
       faaj157 LIKE faaj_t.faaj157, #本位幣三年折舊額
       faaj158 LIKE faaj_t.faaj158, #本位幣三未折減額
       faaj159 LIKE faaj_t.faaj159, #本位幣三第一月未折減額
       faaj160 LIKE faaj_t.faaj160, #本位幣三處置減值準備
       faaj161 LIKE faaj_t.faaj161, #本位幣三本年累折
       faaj162 LIKE faaj_t.faaj162, #本位幣三已提列減值準備
       faaj163 LIKE faaj_t.faaj163, #本位幣三處置成本
       faaj164 LIKE faaj_t.faaj164, #本位幣三處置累折
       faaj165 LIKE faaj_t.faaj165, #本位幣三本期處置累折
       faaj166 LIKE faaj_t.faaj166, #本位幣三交易價格差異
       faaj167 LIKE faaj_t.faaj167, #本位幣三調整成本
       faajownid LIKE faaj_t.faajownid, #資料所有者
       faajowndp LIKE faaj_t.faajowndp, #資料所屬部門
       faajcrtid LIKE faaj_t.faajcrtid, #資料建立者
       faajcrtdp LIKE faaj_t.faajcrtdp, #資料建立部門
       faajcrtdt LIKE faaj_t.faajcrtdt, #資料創建日
       faajmodid LIKE faaj_t.faajmodid, #資料修改者
       faajmoddt LIKE faaj_t.faajmoddt, #最近修改日
       faajstus LIKE faaj_t.faajstus, #狀態碼
       faaj048 LIKE faaj_t.faaj048 #資產分類
       END RECORD
DEFINE l_fabp RECORD  #資產類型異動單身檔
       fabpent LIKE fabp_t.fabpent, #企業編碼
       fabpld LIKE fabp_t.fabpld, #帳套
       fabpsite LIKE fabp_t.fabpsite, #資產中心
       fabpdocno LIKE fabp_t.fabpdocno, #異動單號
       fabpseq LIKE fabp_t.fabpseq, #項次
       fabp000 LIKE fabp_t.fabp000, #卡片編號
       fabp001 LIKE fabp_t.fabp001, #財產編號
       fabp002 LIKE fabp_t.fabp002, #附號
       fabp003 LIKE fabp_t.fabp003, #資產狀態
       fabp004 LIKE fabp_t.fabp004, #名稱
       fabp005 LIKE fabp_t.fabp005, #規格
       fabp006 LIKE fabp_t.fabp006, #成本
       fabp007 LIKE fabp_t.fabp007, #累計折舊
       fabp010 LIKE fabp_t.fabp010, #主要類型
       fabp011 LIKE fabp_t.fabp011, #次要類型
       fabp012 LIKE fabp_t.fabp012, #資產組
       fabp013 LIKE fabp_t.fabp013, #資產科目
       fabp014 LIKE fabp_t.fabp014, #累折科目
       fabp015 LIKE fabp_t.fabp015, #折舊科目
       fabp016 LIKE fabp_t.fabp016, #減值準備科目
       fabp020 LIKE fabp_t.fabp020, #異動後主要類型
       fabp021 LIKE fabp_t.fabp021, #異動後次要類型
       fabp022 LIKE fabp_t.fabp022, #異動後資產組織
       fabp023 LIKE fabp_t.fabp023, #異動後資產科目
       fabp024 LIKE fabp_t.fabp024, #異動後累折科目
       fabp025 LIKE fabp_t.fabp025, #異動後折舊科目
       fabp026 LIKE fabp_t.fabp026, #異動後減值準備科目
       fabp027 LIKE fabp_t.fabp027, #營運據點
       fabp028 LIKE fabp_t.fabp028, #部門
       fabp029 LIKE fabp_t.fabp029, #利潤/成本中心
       fabp030 LIKE fabp_t.fabp030, #區域
       fabp031 LIKE fabp_t.fabp031, #交易客商
       fabp032 LIKE fabp_t.fabp032, #帳款客商
       fabp033 LIKE fabp_t.fabp033, #客群
       fabp034 LIKE fabp_t.fabp034, #人員
       fabp035 LIKE fabp_t.fabp035, #專案編號
       fabp036 LIKE fabp_t.fabp036, #WBS
       fabp037 LIKE fabp_t.fabp037, #摘要
       fabp038 LIKE fabp_t.fabp038, #經營方式
       fabp039 LIKE fabp_t.fabp039, #渠道
       fabp040 LIKE fabp_t.fabp040, #品牌
       fabp041 LIKE fabp_t.fabp041, #自由核算項一
       fabp042 LIKE fabp_t.fabp042, #自由核算項二
       fabp043 LIKE fabp_t.fabp043, #自由核算項三
       fabp044 LIKE fabp_t.fabp044, #自由核算項四
       fabp045 LIKE fabp_t.fabp045, #自由核算項五
       fabp046 LIKE fabp_t.fabp046, #自由核算項六
       fabp047 LIKE fabp_t.fabp047, #自由核算項七
       fabp048 LIKE fabp_t.fabp048, #自由核算項八
       fabp049 LIKE fabp_t.fabp049, #自由核算項九
       fabp050 LIKE fabp_t.fabp050, #自由核算項十
       fabp100 LIKE fabp_t.fabp100, #本位幣二幣別
       fabp101 LIKE fabp_t.fabp101, #本位幣二匯率
       fabp102 LIKE fabp_t.fabp102, #本位幣二成本
       fabp103 LIKE fabp_t.fabp103, #本位幣二累折
       fabp110 LIKE fabp_t.fabp110, #本位幣三幣別
       fabp111 LIKE fabp_t.fabp111, #本位幣三匯率
       fabp112 LIKE fabp_t.fabp112, #本位幣三成本
       fabp113 LIKE fabp_t.fabp113  #本位幣三累折
       END RECORD

#161111-00028#7---modify--end-----------
DEFINE  l_ooag004    LIKE ooag_t.ooag004
DEFINE  l_origin_str STRING
DEFINE  l_glaacomp   LIKE glaa_t.glaacomp
DEFINE  tok          base.StringTokenizer
DEFINE  l_str        STRING
DEFINE  l_faal003    LIKE faal_t.faal003
DEFINE  l_year       LIKE type_t.num5
DEFINE  l_month      LIKE type_t.num5
DEFINE  l_n          LIKE type_t.num5
DEFINE  l_para_data  LIKE ooab_t.ooab002
DEFINE  l_faah015    LIKE faah_t.faah015
DEFINE  l_yy         LIKE faaj_t.faaj008  #161229-00007#1 add
DEFINE  l_mm         LIKE faaj_t.faaj008  #161229-00007#1 add
DEFINE  l_ym         LIKE faaj_t.faaj008  #161229-00007#1 add

   #161111-00028#7---modify--begin-----------
  #SELECT * INTO g_fabg.* 
   SELECT fabgent,fabgcomp,fabgld,fabgdocno,fabgdocdt,fabgsite,fabg001,fabg002,fabg003,fabg004,fabg005,fabg006,
          fabg007,fabg008,fabg009,fabg010,fabg011,fabg012,fabg013,fabg014,fabg015,fabg016,fabg017,fabg018,fabg019,
          fabgstus,fabgownid,fabgowndp,fabgcrtid,fabgcrtdp,fabgcrtdt,fabgmodid,fabgmoddt,fabgcnfid,fabgcnfdt,
          fabgpstid,fabgpstdt,fabg020 INTO g_fabg.* 
   #161111-00028#7---modify--end-----------
   FROM fabg_t WHERE fabgent = g_enterprise AND fabgdocno = g_fabgdocno AND fabgld = g_fabgld
   SELECT glaacomp INTO l_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_fabgld
   
   CALL s_fin_create_account_center_tmp() 
   CALL s_fin_account_center_sons_query('5',g_fabg.fabgsite,g_fabg.fabgdocdt,'1')
   CALL s_fin_account_center_comp_str() RETURNING l_origin_str
   
   CALL afat502_03_change_to_sql(l_origin_str)RETURNING l_origin_str
   LET l_origin_str = "(",l_origin_str,")"
#   LET l_sql = " SELECT faah_t.*,faaj_t.* FROM faah_t,faaj_t",                                                             #160627-00025#1 mark
   LET l_sql = " SELECT faah001,faah002,faah003,faah004,faah006,faah007,faah008,faah012,faah013,faah015,faah017,faah018, ", #160627-00025#1 add
               #161111-00028#7---modify--begin-----------             
             # "        faaj_t.* FROM faah_t,faaj_t",                                                                       #160627-00025#1 add 
               "faajent,faajld,faajsite,faaj000,faaj001,faaj002,faaj003,faaj004,faaj005,faaj006,faaj007,",
               "faaj008,faaj009,faaj010,faaj011,faaj012,faaj013,faaj014,faaj015,faaj016,faaj017,faaj018,",
               "faaj019,faaj020,faaj021,faaj022,faaj023,faaj024,faaj025,faaj026,faaj027,faaj028,faaj029,",
               "faaj030,faaj031,faaj032,faaj033,faaj034,faaj035,faaj036,faaj037,faaj038,faaj039,faaj040,",
               "faaj041,faaj042,faaj043,faaj044,faaj045,faaj046,faaj047,faaj101,faaj102,faaj103,faaj104,",
               "faaj105,faaj106,faaj107,faaj108,faaj109,faaj110,faaj111,faaj112,faaj113,faaj114,faaj115,",
               "faaj116,faaj117,faaj151,faaj152,faaj153,faaj154,faaj155,faaj156,faaj157,faaj158,faaj159,",
               "faaj160,faaj161,faaj162,faaj163,faaj164,faaj165,faaj166,faaj167,faajownid,faajowndp,",
               "faajcrtid,faajcrtdp,faajcrtdt,faajmodid,faajmoddt,faajstus,faaj048 FROM faah_t,faaj_t",   
             #161111-00028#7---modify--end-----------  
               "  WHERE faahent = ",g_enterprise," AND faahstus = 'Y' AND faah015 NOT IN ('0','5','6','8','10') ",
               "    AND faahent = faajent AND faah001 = faaj037 AND faah003 = faaj001 AND faah004 = faaj002 AND faajld = '",g_fabgld,"'",
               "    AND faah028 IN ( SELECT ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"'",
               "    AND ooef017 = '",l_glaacomp,"' AND ooef001 IN ",l_origin_str,")",
               "    AND ",g_wc CLIPPED
   
   PREPARE afat502_03_faah_prep2 FROM l_sql
   DECLARE afat502_03_faah_curs2 CURSOR FOR afat502_03_faah_prep2

    SELECT ooag003 INTO l_fabp.fabp027 FROM ooag_t
     WHERE ooagent = g_enterprise AND ooag001 = g_user
     
    #161229-00007#1 add s---
    CALL cl_get_para(g_enterprise,l_glaacomp,'S-FIN-9018') RETURNING l_year
    CALL cl_get_para(g_enterprise,l_glaacomp,'S-FIN-9019') RETURNING l_month    
    LET l_yy = l_year
    LET l_mm = l_month
    LET l_yy = l_yy USING "&&&&"
    LET l_mm = l_mm USING "&&"
    LET l_ym = l_yy,l_mm      
    #161229-00007#1 add e---
    
#   FOREACH afat502_03_faah_curs2 INTO l_faah.*,l_faaj.*                                                   #160627-00025#1 mark
   FOREACH afat502_03_faah_curs2 INTO l_faah.faah001,l_faah.faah002,l_faah.faah003,l_faah.faah004,         #160627-00025#1 add
                                      l_faah.faah006,l_faah.faah007,l_faah.faah008,l_faah.faah012,         #160627-00025#1 add
                                      l_faah.faah013,l_faah.faah015,l_faah.faah017,l_faah.faah018,l_faaj.* #160627-00025#1 add
      IF l_faaj.faaj008 < l_ym AND l_faaj.faaj003 <> '5' AND NOT cl_null(l_faaj.faaj003) THEN  #161229-00007#1 add   
         SELECT faal003 INTO l_faal003 FROM faal_t 
          WHERE faalent = g_enterprise AND faalld = g_fabgld AND faal001 = l_faah.faah006
         
         IF STATUS =100 OR cl_null(l_faal003) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'afa-00183'      #过单
            LET g_errparam.extend = g_fabgld||'|'||l_faah.faah006
            LET g_errparam.popup = TRUE
            CALL cl_err()      
            CONTINUE FOREACH
         ELSE
            LET l_year = YEAR(g_fabg.fabgdocdt)
            LET l_month = MONTH(g_fabg.fabgdocdt)
            IF l_faal003 = 'Y' THEN   
               SELECT COUNT(*) INTO l_n FROM faam_t
                 WHERE faament = g_enterprise AND faamld = g_fabgld
                   AND faam000 = l_faah.faah001 AND faam001 = l_faah.faah003 AND faam002= l_faah.faah004
                   AND faam004 = l_year AND faam005 = l_month
                IF l_n = 0 THEN 
                   SELECT faah015 INTO l_faah015
                     FROM faah_t
                    WHERE faahent = g_enterprise
                      AND faah001 = l_faah.faah001
                      AND faah003 = l_faah.faah003
                      AND faah004 = l_faah.faah004
                   IF l_faah015 <> '4' THEN 
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = 'afa-00280'
                      LET g_errparam.extend =l_faah.faah003||'|'||l_faah.faah004||'|'||l_faah.faah001 
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                      CONTINUE FOREACH
                   END IF 
                END IF
            END IF
         END IF
      END IF #161229-00007#1 add   

     
      SELECT MAX(fabpseq) INTO l_fabp.fabpseq
        FROM fabp_t
       WHERE fabpent = g_enterprise
         AND fabpdocno = g_fabgdocno AND fabpld = g_fabgld
      IF cl_null(l_fabp.fabpseq) THEN
         LET l_fabp.fabpseq = 1
      ELSE
         LET l_fabp.fabpseq = l_fabp.fabpseq +1
      END IF
      LET l_fabp.fabpent   = g_enterprise 
      LET l_fabp.fabpld    = g_fabgld
      LET l_fabp.fabpsite  = g_fabg.fabgsite
      LET l_fabp.fabpdocno = g_fabgdocno
       
      LET l_fabp.fabp000   = l_faah.faah001
      LET l_fabp.fabp001   = l_faah.faah003
      LET l_fabp.fabp002   = l_faah.faah004
      LET l_fabp.fabp003   = l_faah.faah015
      LET l_fabp.fabp004   = l_faah.faah012
      LET l_fabp.fabp005   = l_faah.faah013                                      
      LET l_fabp.fabp006   = l_faaj.faaj016
      IF cl_null(l_fabp.fabp006) THEN
         LET l_fabp.fabp006 = 0
      END IF
      LET l_fabp.fabp007   = l_faaj.faaj017
      LET l_fabp.fabp010   = l_faah.faah006
      LET l_fabp.fabp011   = l_faah.faah007
      LET l_fabp.fabp012   = l_faah.faah008
      LET l_fabp.fabp013   = l_faaj.faaj023                                      
      LET l_fabp.fabp014   = l_faaj.faaj024
      LET l_fabp.fabp015   = l_faaj.faaj025
      LET l_fabp.fabp016   = l_faaj.faaj026
      LET l_fabp.fabp020   = l_faah.faah006
      LET l_fabp.fabp021   = l_faah.faah007
      LET l_fabp.fabp022   = l_faah.faah008
      LET l_fabp.fabp023   = l_faaj.faaj023
      LET l_fabp.fabp024   = l_faaj.faaj024
      LET l_fabp.fabp025   = l_faaj.faaj025
      LET l_fabp.fabp026   = l_faaj.faaj026                                    
      #核算项
      LET l_fabp.fabp027   =  l_faaj.faajsite                                    #營運據點
      LET l_fabp.fabp028   =  ''                                                 #利潤/成本中心
      LET l_fabp.fabp029   =  ''                                                 #區域
      LET l_fabp.fabp030   =  l_faaj.faaj042                                     #交易客商
      LET l_fabp.fabp031   =  l_faaj.faaj043                                     #帳款客商
      LET l_fabp.fabp032   =  ''                                                 #客群
      LET l_fabp.fabp033   =  ''                                                 #人員
      LET l_fabp.fabp034   =  l_faaj.faaj045                                     #專案編號
      LET l_fabp.fabp035   =  l_faaj.faaj046                                     #WBS 
      
      LET l_fabp.fabp100   =  l_faaj.faaj101                                     #本位幣二幣別
      LET l_fabp.fabp101   =  l_faaj.faaj102                                     #本位幣二匯率
      LET l_fabp.fabp102   =  l_faaj.faaj103                                     #本位幣二成本
      LET l_fabp.fabp103   =  l_faaj.faaj104                                     #本位幣二累折
     
      LET l_fabp.fabp110   =  l_faaj.faaj151                                     #本位幣三幣別
      LET l_fabp.fabp111   =  l_faaj.faaj152                                     #本位幣三匯率
      LET l_fabp.fabp112   =  l_faaj.faaj153                                     #本位幣三成本
      LET l_fabp.fabp113   =  l_faaj.faaj154                                     #本位幣三調整成本
      #161111-00028#7---modify--begin-----------  
      #INSERT INTO fabp_t VALUES(l_fabp.*)
      INSERT INTO fabp_t (fabpent,fabpld,fabpsite,fabpdocno,fabpseq,fabp000,fabp001,fabp002,fabp003,fabp004,fabp005,fabp006,
                          fabp007,fabp010,fabp011,fabp012,fabp013,fabp014,fabp015,fabp016,fabp020,fabp021,fabp022,fabp023,
                          fabp024,fabp025,fabp026,fabp027,fabp028,fabp029,fabp030,fabp031,fabp032,fabp033,fabp034,fabp035,
                          fabp036,fabp037,fabp038,fabp039,fabp040,fabp041,fabp042,fabp043,fabp044,fabp045,fabp046,fabp047,
                          fabp048,fabp049,fabp050,fabp100,fabp101,fabp102,fabp103,fabp110,fabp111,fabp112,fabp113)
       VALUES(l_fabp.fabpent,l_fabp.fabpld,l_fabp.fabpsite,l_fabp.fabpdocno,l_fabp.fabpseq,l_fabp.fabp000,l_fabp.fabp001,l_fabp.fabp002,l_fabp.fabp003,l_fabp.fabp004,l_fabp.fabp005,l_fabp.fabp006,
              l_fabp.fabp007,l_fabp.fabp010,l_fabp.fabp011,l_fabp.fabp012,l_fabp.fabp013,l_fabp.fabp014,l_fabp.fabp015,l_fabp.fabp016,l_fabp.fabp020,l_fabp.fabp021,l_fabp.fabp022,l_fabp.fabp023,
              l_fabp.fabp024,l_fabp.fabp025,l_fabp.fabp026,l_fabp.fabp027,l_fabp.fabp028,l_fabp.fabp029,l_fabp.fabp030,l_fabp.fabp031,l_fabp.fabp032,l_fabp.fabp033,l_fabp.fabp034,l_fabp.fabp035,
              l_fabp.fabp036,l_fabp.fabp037,l_fabp.fabp038,l_fabp.fabp039,l_fabp.fabp040,l_fabp.fabp041,l_fabp.fabp042,l_fabp.fabp043,l_fabp.fabp044,l_fabp.fabp045,l_fabp.fabp046,l_fabp.fabp047,
              l_fabp.fabp048,l_fabp.fabp049,l_fabp.fabp050,l_fabp.fabp100,l_fabp.fabp101,l_fabp.fabp102,l_fabp.fabp103,l_fabp.fabp110,l_fabp.fabp111,l_fabp.fabp112,l_fabp.fabp113)
      #161111-00028#7---modify--end-----------  
      
   END FOREACH
END FUNCTION

 
{</section>}
 
