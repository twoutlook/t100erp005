#該程式未解開Section, 採用最新樣板產出!
{<section id="afat410_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0010(2014-10-11 12:17:26), PR版次:0010(2016-11-28 15:45:15)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000112
#+ Filename...: afat410_01
#+ Description: 自動產生
#+ Creator....: 02291(2014-10-11 10:06:51)
#+ Modifier...: 02291 -SD/PR- 01531
 
{</section>}
 
{<section id="afat410_01.global" >}
#應用 c01c 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160329-00022#1   2016/04/06  By 07673    afat410自动产生时，财产编号+卡片编号+附号开窗应过虑法人且开窗的折旧方式只能是工作量法。
#160905-00007#2   2016/09/05  by 08742    调整系统中无ENT的SQL条件增加ent
#160922-00042#1   2016/09/22  BY 02114    无法整批产生单身
#160930-00022#1   2016/10/10  BY 02114    自动产生单身的弹窗，【卡片编号】、【财产编号】、【附号】栏位开窗出的资料未排除掉afai100未审核的资料
#161017-00023#1   2016/10/26  By 02114    权限调整
#161111-00028#7   2016/11/23  by 02481    标准程式定义采用宣告模式,弃用.*写法
#161111-00049#11  2016/11/28  By 01531    二阶段FA问题7~14 调整作业:afap200/afat300/afat400/afat410/afat420/afat421/afat430/afat440
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
DEFINE g_fabadocno           LIKE faba_t.fabadocno
DEFINE g_faba001             LIKE faba_t.faba001
DEFINE g_faba003             LIKE faba_t.faba003
#161111-00028#7---modify--begin-----------
#DEFINE g_faba     RECORD LIKE faba_t.*
DEFINE g_faba RECORD  #資產異動單頭檔
       fabaent LIKE faba_t.fabaent, #企業編號
       fabadocno LIKE faba_t.fabadocno, #單據編號
       fabadocdt LIKE faba_t.fabadocdt, #單據日期
       fabasite LIKE faba_t.fabasite, #資產中心
       fabacomp LIKE faba_t.fabacomp, #法人
       faba001 LIKE faba_t.faba001, #帳務人員
       faba002 LIKE faba_t.faba002, #No Use
       faba003 LIKE faba_t.faba003, #單據性質
       fabastus LIKE faba_t.fabastus, #確認碼
       fabaownid LIKE faba_t.fabaownid, #資料所有者
       fabaowndp LIKE faba_t.fabaowndp, #資料所屬部門
       fabacrtid LIKE faba_t.fabacrtid, #資料建立者
       fabacrtdp LIKE faba_t.fabacrtdp, #資料建立部門
       fabacrtdt LIKE faba_t.fabacrtdt, #資料創建日
       fabamodid LIKE faba_t.fabamodid, #資料修改者
       fabamoddt LIKE faba_t.fabamoddt, #最近修改日
       fabacnfid LIKE faba_t.fabacnfid, #資料確認者
       fabacnfdt LIKE faba_t.fabacnfdt, #資料確認日
       faba004 LIKE faba_t.faba004, #申請人員
       faba005 LIKE faba_t.faba005, #申請部門
       faba006 LIKE faba_t.faba006, #申請日期
       faba007 LIKE faba_t.faba007, #解除文號
       faba008 LIKE faba_t.faba008, #解除日期
       faba009 LIKE faba_t.faba009, #帳務單號
       faba010 LIKE faba_t.faba010, #帳務日期
       faba011 LIKE faba_t.faba011, #調撥流水號
       faba012 LIKE faba_t.faba012, #在途否
       faba013 LIKE faba_t.faba013, #撥出過帳
       faba014 LIKE faba_t.faba014, #撥入過帳
       faba015 LIKE faba_t.faba015, #保險公司
       faba016 LIKE faba_t.faba016, #付款對象
       faba017 LIKE faba_t.faba017, #帳務單據
       faba018 LIKE faba_t.faba018, #投資抵減/免稅狀態
       faba019 LIKE faba_t.faba019, #投資抵減/免税年度
       faba020 LIKE faba_t.faba020, #管理局/開工核准日期
       faba021 LIKE faba_t.faba021, #管理局/開工核准文號
       faba022 LIKE faba_t.faba022, #國稅局/免稅核准日期
       faba023 LIKE faba_t.faba023, #國稅局/免稅核准文號
       faba024 LIKE faba_t.faba024  #免稅金額
       END RECORD

#161111-00028#7---modify--end-------------
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point  
 
{</section>}
 
{<section id="afat410_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION afat410_01(--)
   #add-point:construct段變數傳入 name="construct.get_var"
   p_fabadocno,p_faba001,p_faba003
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
   DEFINE p_fabadocno     LIKE faba_t.fabadocno
   DEFINE p_faba001       LIKE faba_t.faba001
   DEFINE p_faba003       LIKE faba_t.faba003
   DEFINE l_fabacomp      LIKE faba_t.fabacomp  #160329-00022#1 add
   DEFINE l_comp_str      STRING                #161017-00023#1 add lujh
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_afat410_01 WITH FORM cl_ap_formpath("afa","afat410_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   #輸入前處理
   #add-point:單頭前置處理 name="construct.pre_construct"
   LET g_fabadocno = p_fabadocno
   LET g_faba001 = p_faba001
   LET g_faba003 = p_faba003
   #160329-00022#1 add -str
   SELECT fabacomp INTO  l_fabacomp
     FROM faba_t
    WHERE fabaent = g_enterprise
      AND fabadocno  =  p_fabadocno
   #160329-00022#1 add -end 
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      CONSTRUCT BY NAME g_wc ON faah001,faah003,faah004,faah008,faah030,faah031,faah028,faah000 
      
            #add-point:自定義action name="construct.action"
            ON ACTION controlp INFIELD faah001
               #此段落由子樣板a08產生
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE 
			      IF p_faba003 = '11' THEN
		            LET g_qryparam.where = " faah019 > 0 "               
		         END IF
		         #160329-00022#1 add -str
		         IF NOT cl_null(g_qryparam.where)THEN
                  LET g_qryparam.where = g_qryparam.where," AND faah032 = '",l_fabacomp,"'",
                                                          " AND faahstus = 'Y' "   #160930-00022#1 add lujh
               ELSE 
                  LET g_qryparam.where = "   faah032 = '",l_fabacomp,"'",
                                         " AND faahstus = 'Y' "  #160930-00022#1 add lujh
               END IF
               #161111-00049#12 add s---
               LET g_qryparam.where =  g_qryparam.where," AND  faah032 = '",l_fabacomp,"'" 
               #161111-00049#12 add e---		         
		         IF g_prog != 'afat410'  THEN
                  CALL q_faah001()                           #呼叫開窗  
               ELSE
                  LET g_qryparam.where = g_qryparam.where," AND faaj003 = '4' AND faah015 NOT IN ('0','5','6','8','10') "
                  CALL q_faah003_7() 
               END IF                   
               #160329-00022#1 add -end 
#               DISPLAY g_qryparam.return1 TO faah001  #顯示到畫面上   #160329-00022#1
                DISPLAY g_qryparam.return3 TO faah001                 #160329-00022#1
               
               NEXT FIELD faah001                     #返回原欄位
            
            ON ACTION controlp INFIELD faah003
               #此段落由子樣板a08產生
               #開窗c段
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE             
               IF p_faba003 = '11' THEN
		            LET g_qryparam.where = " faah019 > 0 " 
		         END IF

		         #160329-00022#1 add -str
		         IF NOT cl_null(g_qryparam.where)THEN
                  LET g_qryparam.where = g_qryparam.where," AND faah032 = '",l_fabacomp,"'",
                                                          " AND faahstus = 'Y' "   #160930-00022#1 add lujh
               ELSE 
                  LET g_qryparam.where = "   faah032 = '",l_fabacomp,"'",
                                         " AND faahstus = 'Y' "   #160930-00022#1 add lujh
               END IF
               #161111-00049#12 add s---
               LET g_qryparam.where =  g_qryparam.where," AND  faah032 = '",l_fabacomp,"'" 
               #161111-00049#12 add e---		               
		         IF g_prog != 'afat410'  THEN
                  CALL q_faah003()                          #呼叫開窗  
               ELSE
                  LET g_qryparam.where = g_qryparam.where," AND faaj003 = '4' AND faah015 NOT IN ('0','5','6','8','10') "
                  CALL q_faah003_5()
               END IF                   
               #160329-00022#1 add -end 
               DISPLAY g_qryparam.return1 TO faah003  #顯示到畫面上
               
               NEXT FIELD faah003                     #返回原欄位
               
            ON ACTION controlp INFIELD faah004
               #此段落由子樣板a08產生
               #開窗c段
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE              
                IF p_faba003 = '11' THEN
		            LET g_qryparam.where = " faah019 > 0 " 
		         END IF         
		         #160329-00022#1 add -str
		         IF NOT cl_null(g_qryparam.where)THEN
                  LET g_qryparam.where = g_qryparam.where," AND faah032 = '",l_fabacomp,"'",
                                                          " AND faahstus = 'Y' "   #160930-00022#1 add lujh
               ELSE 
                  LET g_qryparam.where = "   faah032 = '",l_fabacomp,"'",
                                         " AND faahstus = 'Y' "   #160930-00022#1 add lujh
               END IF
               #161111-00049#12 add s---
               LET g_qryparam.where =  g_qryparam.where," AND  faah032 = '",l_fabacomp,"'" 
               #161111-00049#12 add e---		
               
		         IF g_prog != 'afat410'  THEN
                  CALL q_faah004()                          #呼叫開窗  
               ELSE
                  LET g_qryparam.where = g_qryparam.where," AND faaj003 = '4' AND faah015 NOT IN ('0','5','6','8','10') "
                  CALL q_faah003_6()
               END IF                   
               #160329-00022#1 add -end 
#               DISPLAY g_qryparam.return1 TO faah004  #顯示到畫面上   #160329-00022#1
               DISPLAY g_qryparam.return2 TO faah004                   #160329-00022#1
               
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
            
            ON ACTION controlp INFIELD faah030
               #此段落由子樣板a08產生
               #開窗c段
               CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str    #161017-00023#1 add lujh
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               #161017-00023#1--add--str--lujh
               LET g_qryparam.where = " ooef207 = 'Y' AND ",l_comp_str   
               CALL q_ooef001()         
               #161017-00023#1--add--end--lujh
               #CALL q_faah030()                      #呼叫開窗     #161017-00023#1 mark lujh
               DISPLAY g_qryparam.return1 TO faah030  #顯示到畫面上
               
               NEXT FIELD faah030                     #返回原欄位
            
            ON ACTION controlp INFIELD faah031
               #此段落由子樣板a08產生
               #開窗c段
               CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str    #161017-00023#1 add lujh
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               #161017-00023#1--add--str--lujh
               LET g_qryparam.where = " ooef204 = 'Y' AND ",l_comp_str     
               CALL q_ooef001()          
               #161017-00023#1--add--end--lujh               
               #CALL q_faah031()                      #呼叫開窗      #161017-00023#1 mark lujh
               DISPLAY g_qryparam.return1 TO faah031  #顯示到畫面上
               
               NEXT FIELD faah031                     #返回原欄位
            
            ON ACTION controlp INFIELD faah028
               #此段落由子樣板a08產生
               #開窗c段
               CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str    #161017-00023#1 add lujh
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               #161017-00023#1--add--str--lujh
               LET g_qryparam.where = l_comp_str     
               CALL q_ooef001()  
               #161017-00023#1--add--end--lujh
               #CALL q_faah028()                      #呼叫開窗      #161017-00023#1 mark lujh
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
      CASE g_faba003
         WHEN '1' 
            CALL afat410_01_fabn_ins()
         WHEN '5'     
            CALL afat410_01_fabb_ins()
         WHEN '7'
            CALL afat410_01_fabb_ins()
         WHEN '10'
            CALL afat410_01_fabk_ins()
         WHEN '11'
            CALL afat410_01_fabk_ins()
        #140122-00001#117--add--str--lujh
         WHEN '32'
            CALL afat410_01_fabv_ins()
        #140122-00001#117--add--end--lujh
      END CASE
   END IF
   #end add-point 
   
   #畫面關閉
   CLOSE WINDOW w_afat410_01 
   
   #add-point:construct段after construct name="construct.post_construct"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="afat410_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="afat410_01.other_function" readonly="Y" >}

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
PRIVATE FUNCTION afat410_01_fabb_ins()
DEFINE  l_sql        STRING
#161111-00028#7---modify--begin-----------
#DEFINE  l_faah       RECORD LIKE faah_t.*
#DEFINE  l_fabb       RECORD LIKE fabb_t.*
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
DEFINE l_fabb RECORD  #資產異動單身明細檔
       fabbent LIKE fabb_t.fabbent, #企業編號
       fabbcomp LIKE fabb_t.fabbcomp, #法人
       fabbdocno LIKE fabb_t.fabbdocno, #單據編號
       fabbseq LIKE fabb_t.fabbseq, #項次
       fabblegl LIKE fabb_t.fabblegl, #核算組織
       fabb000 LIKE fabb_t.fabb000, #卡片編號
       fabb001 LIKE fabb_t.fabb001, #財產編號
       fabb002 LIKE fabb_t.fabb002, #附號
       fabb003 LIKE fabb_t.fabb003, #部門
       fabb004 LIKE fabb_t.fabb004, #人員
       fabb005 LIKE fabb_t.fabb005, #工作量值
       fabb006 LIKE fabb_t.fabb006, #備註
       fabb007 LIKE fabb_t.fabb007, #資產狀態
       fabb008 LIKE fabb_t.fabb008, #停用否
       fabb009 LIKE fabb_t.fabb009, #存放位置
       fabb010 LIKE fabb_t.fabb010, #部門(舊)
       fabb011 LIKE fabb_t.fabb011, #人員(舊)
       fabb012 LIKE fabb_t.fabb012, #存放位置(舊)
       fabb013 LIKE fabb_t.fabb013, #單一部門分攤時同時更新分攤部門
       fabb014 LIKE fabb_t.fabb014, #資產科目(舊)
       fabb015 LIKE fabb_t.fabb015, #資產科目
       fabb016 LIKE fabb_t.fabb016, #累折科目(舊)
       fabb017 LIKE fabb_t.fabb017, #累折科目
       fabb018 LIKE fabb_t.fabb018, #折舊科目(舊)
       fabb019 LIKE fabb_t.fabb019, #折舊科目
       fabb020 LIKE fabb_t.fabb020, #減值準備科目(舊)
       fabb021 LIKE fabb_t.fabb021, #減值準備科目
       fabb022 LIKE fabb_t.fabb022, #異動原因
       fabb023 LIKE fabb_t.fabb023, #所有組織(舊)
       fabb024 LIKE fabb_t.fabb024, #所有組織
       fabb025 LIKE fabb_t.fabb025, #管理組織(舊)
       fabb026 LIKE fabb_t.fabb026, #管理組織
       fabb027 LIKE fabb_t.fabb027, #核算組織(舊)
       fabb028 LIKE fabb_t.fabb028, #核算組織
       fabb029 LIKE fabb_t.fabb029, #分攤部門/類別
       fabb030 LIKE fabb_t.fabb030  #分攤部門/類別(新)
       END RECORD
#161111-00028#7---modify--end-----------
DEFINE  l_ooag004    LIKE ooag_t.ooag004
DEFINE  l_origin_str  STRING
DEFINE tok        base.StringTokenizer
DEFINE l_str      STRING
DEFINE l_glaald      LIKE glaa_t.glaald
DEFINE l_faaj003     LIKE faaj_t.faaj003

   #SELECT ooag004 INTO l_ooag004 FROM ooag_t
   # WHERE ooagent = g_enterprise AND ooag001 = g_faba001
   #
   #LET l_sql = " SELECT faah003,faah004,faah001,faah031,faah032 FROM faah_t",
   #            "  WHERE faahent = ",g_enterprise," AND faahstus = 'Y' ",
   #            "    AND faah028 IN ( SELECT ooef001 FROM ooef_t WHERE ooefent = ",g_enterprise,
   #            "    AND ooef017 = '",l_ooag004,"')",
   #            "    AND faah019 > 0  ",
   #            "    AND ",g_wc CLIPPED
   #161111-00028#7---modify--begin-----------
   #SELECT * INTO g_faba.* 
   SELECT fabaent,fabadocno,fabadocdt,fabasite,fabacomp,faba001,faba002,faba003,fabastus,fabaownid,fabaowndp,
          fabacrtid,fabacrtdp,fabacrtdt,fabamodid,fabamoddt,fabacnfid,fabacnfdt,faba004,faba005,faba006,faba007,
          faba008,faba009,faba010,faba011,faba012,faba013,faba014,faba015,faba016,faba017,faba018,faba019,faba020,
          faba021,faba022,faba023,faba024 INTO g_faba.* 
   #161111-00028#7---modify--end-----------
   FROM faba_t WHERE fabaent = g_enterprise AND fabadocno = g_fabadocno
   CALL s_fin_create_account_center_tmp() 
   CALL s_fin_account_center_sons_query('5',g_faba.fabasite,g_faba.fabadocdt,'1')
   CALL s_fin_account_center_comp_str() RETURNING l_origin_str
   
   CALL afat410_01_change_to_sql(l_origin_str)RETURNING l_origin_str
   LET l_origin_str = "(",l_origin_str,")"
   #161111-00028#7---modify--begin-----------
   #LET l_sql = " SELECT * FROM faah_t",
   LET l_sql = " SELECT faahent,faah000,faah001,faah002,faah003,faah004,faah005,faah006,faah007,faah008,faah009,",
              "faah010,faah011,faah012,faah013,faah014,faah015,faah016,faah017,faah018,faah019,faah020,faah021,",
              "faah022,faah023,faah024,faah025,faah026,faah027,faah028,faah029,faah030,faah031,faah032,faah033,",
              "faah034,faah035,faah036,faah037,faah038,faah039,faah040,faah041,faah042,faah043,faah044,faah045,",
              "faahownid,faahowndp,faahcrtid,faahcrtdp,faahcrtdt,faahmodid,faahmoddt,faahstus,faah046,faah047,",
              "faah048,faah049,faah050,faah051,faah052,faah053,faah054,faah055,faah056 FROM faah_t",
  #161111-00028#7---modify--end-----------
  
               "  WHERE faahent = ",g_enterprise," AND faahstus = 'Y' ",
               "    AND faah028 IN ( SELECT ooef001 FROM ooef_t WHERE ooefent = ",g_enterprise,
               "    AND ooef017 = '",g_faba.fabacomp,"' AND ooef001 IN ",l_origin_str,")",
               "    AND ",g_wc CLIPPED
   IF g_faba003 = '5' THEN
      LET l_sql = l_sql," AND faah015 NOT IN ('0','5','6','8','10')"
   END IF
   IF g_faba003 = '7' THEN
      LET l_sql = l_sql," AND faah015 NOT IN ('0','5','6','10')"
   END IF
   PREPARE afat410_01_faah_prep FROM l_sql
   DECLARE afat410_01_faah_curs CURSOR FOR afat410_01_faah_prep
   
  # LET l_fabb004 = g_user
  # SELECT ooag003 INTO l_fabb003 FROM ooag_t
  #  WHERE ooagent = g_enterprise AND ooag001 = g_user
    
   FOREACH afat410_01_faah_curs INTO l_faah.*
      #160329-00022#1 add -str
      #160905-00007#2 -S
     #SELECT glaald INTO l_glaald 
     #  FROM glaa_t 
     # WHERE glaacomp = g_faba.fabacomp 
     #   AND glaa014 = 'Y'
      SELECT glaald INTO l_glaald 
        FROM glaa_t 
       WHERE glaacomp = g_faba.fabacomp 
         AND glaa014 = 'Y'
         AND glaaent = g_enterprise
      #160905-00007#2  -E
         
      SELECT faaj003 INTO l_faaj003 
        FROM faaj_t
       WHERE faajent = g_enterprise
         AND faaj001 = l_faah.faah003
         AND faaj002 = l_faah.faah004
         AND faaj037 = l_faah.faah001
         AND faajld  = l_glaald
      
      IF l_faaj003 ! = 4 AND g_faba003 = '5' THEN    #160922-00042#1 add AND g_faba003 = '5' lujh
         CONTINUE FOREACH      
      END IF
      #160329-00022#1 add -end
      SELECT MAX(fabbseq) INTO l_fabb.fabbseq   FROM fabb_t
       WHERE fabbent = g_enterprise AND fabbdocno = g_fabadocno
      IF cl_null(l_fabb.fabbseq) THEN
         LET l_fabb.fabbseq = 1
      ELSE
         LET l_fabb.fabbseq = l_fabb.fabbseq +1
      END IF
      LET l_fabb.fabbent = g_enterprise
      LET l_fabb.fabbcomp = g_faba.fabacomp
      LET l_fabb.fabbdocno = g_fabadocno
      LET l_fabb.fabblegl = l_faah.faah031
      LET l_fabb.fabb000 = l_faah.faah001
      LET l_fabb.fabb001 = l_faah.faah003
      LET l_fabb.fabb002 = l_faah.faah004
      LET l_fabb.fabb003 = l_faah.faah026
      LET l_fabb.fabb004 = l_faah.faah025 
      LET l_fabb.fabb005 = 0
      LET l_fabb.fabb007 = l_faah.faah015
      LET l_fabb.fabb008 = 'Y'
      
      #161111-00028#7---modify--begin-----------
      #INSERT INTO fabb_t VALUES(l_fabb.*)
      INSERT INTO fabb_t (fabbent,fabbcomp,fabbdocno,fabbseq,fabblegl,fabb000,fabb001,fabb002,fabb003,fabb004,
                          fabb005,fabb006,fabb007,fabb008,fabb009,fabb010,fabb011,fabb012,fabb013,fabb014,fabb015,
                          fabb016,fabb017,fabb018,fabb019,fabb020,fabb021,fabb022,fabb023,fabb024,fabb025,fabb026,
                          fabb027,fabb028,fabb029,fabb030)
        VALUES(l_fabb.fabbent,l_fabb.fabbcomp,l_fabb.fabbdocno,l_fabb.fabbseq,l_fabb.fabblegl,l_fabb.fabb000,l_fabb.fabb001,l_fabb.fabb002,l_fabb.fabb003,l_fabb.fabb004,
               l_fabb.fabb005,l_fabb.fabb006,l_fabb.fabb007,l_fabb.fabb008,l_fabb.fabb009,l_fabb.fabb010,l_fabb.fabb011,l_fabb.fabb012,l_fabb.fabb013,l_fabb.fabb014,l_fabb.fabb015,
               l_fabb.fabb016,l_fabb.fabb017,l_fabb.fabb018,l_fabb.fabb019,l_fabb.fabb020,l_fabb.fabb021,l_fabb.fabb022,l_fabb.fabb023,l_fabb.fabb024,l_fabb.fabb025,l_fabb.fabb026,
               l_fabb.fabb027,l_fabb.fabb028,l_fabb.fabb029,l_fabb.fabb030)
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
PRIVATE FUNCTION afat410_01_fabk_ins()
DEFINE  l_sql        STRING
DEFINE  l_faah001    LIKE faah_t.faah001
DEFINE  l_faah003    LIKE faah_t.faah003
DEFINE  l_faah004    LIKE faah_t.faah004
DEFINE  l_faah031    LIKE faah_t.faah031
DEFINE  l_faah032    LIKE faah_t.faah032
DEFINE  l_fabkseq    LIKE fabk_t.fabkseq
DEFINE  l_faah006    LIKE faah_t.faah006
DEFINE  l_faah007    LIKE faah_t.faah007
DEFINE  l_faah015    LIKE faah_t.faah015
DEFINE  l_faah017    LIKE faah_t.faah017
DEFINE  l_faah018    LIKE faah_t.faah018
DEFINE  l_faah019    LIKE faah_t.faah019
DEFINE  l_ooag004    LIKE ooag_t.ooag004
DEFINE  l_origin_str  STRING
DEFINE tok        base.StringTokenizer
DEFINE l_str      STRING

   #SELECT ooag004 INTO l_ooag004 FROM ooag_t
   # WHERE ooagent = g_enterprise AND ooag001 = g_faba001
   #
   #LET l_sql = " SELECT faah003,faah004,faah001,faah006,faah007,faah015,faah017,faah018,faah019,faah032 FROM faah_t",
   #            "  WHERE faahent = ",g_enterprise," AND faahstus = 'Y' ",
   #            "    AND faah028 IN ( SELECT ooef001 FROM ooef_t WHERE ooefent = ",g_enterprise,
   #            "    AND ooef017 = '",l_ooag004,"')",
   #            "    AND faah019 > 0  ",
   #            "    AND ",g_wc CLIPPED
   
   #161111-00028#7---modify--begin-----------
   #SELECT * INTO g_faba.* 
   SELECT fabaent,fabadocno,fabadocdt,fabasite,fabacomp,faba001,faba002,faba003,fabastus,fabaownid,fabaowndp,
          fabacrtid,fabacrtdp,fabacrtdt,fabamodid,fabamoddt,fabacnfid,fabacnfdt,faba004,faba005,faba006,faba007,
          faba008,faba009,faba010,faba011,faba012,faba013,faba014,faba015,faba016,faba017,faba018,faba019,faba020,
          faba021,faba022,faba023,faba024 INTO g_faba.* 
   #161111-00028#7---modify--end-----------
   
   FROM faba_t WHERE fabaent = g_enterprise AND fabadocno = g_fabadocno
   CALL s_fin_create_account_center_tmp() 
   CALL s_fin_account_center_sons_query('5',g_faba.fabasite,g_faba.fabadocdt,'1')
   CALL s_fin_account_center_comp_str() RETURNING l_origin_str
   
   CALL afat410_01_change_to_sql(l_origin_str)RETURNING l_origin_str
   LET l_origin_str = "(",l_origin_str,")"
   LET l_sql = " SELECT faah003,faah004,faah001,faah006,faah007,faah015,faah017,faah018,faah019,faah032 FROM faah_t",
               "  WHERE faahent = ",g_enterprise," AND faahstus = 'Y' AND faah015 NOT IN ('5','6','8','10') ",
               "    AND faah028 IN ( SELECT ooef001 FROM ooef_t WHERE ooefent = ",g_enterprise,
               "    AND ooef017 = '",g_faba.fabacomp,"' AND ooef001 IN ",l_origin_str,")",
               "    AND ",g_wc CLIPPED
   
   IF g_faba003 = '11' THEN
      LET l_sql = l_sql," AND faah019 > 0  "
   END IF
   
   PREPARE afat410_01_faah_prep1 FROM l_sql
   DECLARE afat410_01_faah_curs1 CURSOR FOR afat410_01_faah_prep1
    
   FOREACH afat410_01_faah_curs1 INTO l_faah003,l_faah004,l_faah001,l_faah006,l_faah007,l_faah015,l_faah017,
                                      l_faah018,l_faah019,l_faah032
      SELECT MAX(fabkseq) INTO l_fabkseq
        FROM fabk_t
       WHERE fabkent = g_enterprise
         AND fabkdocno = g_fabadocno
      IF cl_null(l_fabkseq) THEN
         LET l_fabkseq = 1
      ELSE
         LET l_fabkseq = l_fabkseq +1
      END IF
      
      INSERT INTO fabk_t(fabkent,fabkcomp,fabkdocno,fabkseq,fabk000,fabk001,fabk002,fabk003,fabk004,fabk005,
                         fabk006,fabk009)
                 VALUES(g_enterprise,l_faah032,g_fabadocno,l_fabkseq,
                        l_faah001,l_faah003,l_faah004,l_faah017,l_faah018,l_faah019,0,l_faah015)
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
PUBLIC FUNCTION afat410_01_change_to_sql(p_wc)
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
PUBLIC FUNCTION afat410_01_fabn_ins()
DEFINE  l_sql        STRING
#161111-00028#7---modify--begin-----------
#DEFINE  l_faah     RECORD LIKE faah_t.*
#DEFINE  l_fabn     RECORD LIKE fabn_t.*
DEFINE l_fabn RECORD  #資產資本化單身明細檔
       fabnent LIKE fabn_t.fabnent, #企業編碼
       fabncomp LIKE fabn_t.fabncomp, #法人
       fabndocno LIKE fabn_t.fabndocno, #單據編號
       fabnseq LIKE fabn_t.fabnseq, #項次
       fabn001 LIKE fabn_t.fabn001, #財產編號
       fabn002 LIKE fabn_t.fabn002, #附號
       fabn003 LIKE fabn_t.fabn003, #卡片編號
       fabn004 LIKE fabn_t.fabn004, #正式財產編號
       fabn005 LIKE fabn_t.fabn005, #正式附號
       fabn006 LIKE fabn_t.fabn006, #計提日期
       fabn007 LIKE fabn_t.fabn007, #幣別
       fabn008 LIKE fabn_t.fabn008, #匯率
       fabn009 LIKE fabn_t.fabn009, #原幣金額
       fabn010 LIKE fabn_t.fabn010, #本幣金額
       fabn011 LIKE fabn_t.fabn011, #保管人員
       fabn012 LIKE fabn_t.fabn012, #保管部門
       fabn013 LIKE fabn_t.fabn013, #存放位置
       fabn014 LIKE fabn_t.fabn014, #管理組織
       fabn015 LIKE fabn_t.fabn015, #所有組織
       fabn016 LIKE fabn_t.fabn016, #核算組織
       fabn017 LIKE fabn_t.fabn017, #原因碼
       fabn018 LIKE fabn_t.fabn018  #正式卡片編號
       END RECORD

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

#161111-00028#7---modify--end-----------
DEFINE  l_origin_str  STRING
DEFINE  tok        base.StringTokenizer
DEFINE  l_str      STRING
   
   #161111-00028#7---modify--begin-----------
  #SELECT * INTO g_faba.* 
   SELECT fabaent,fabadocno,fabadocdt,fabasite,fabacomp,faba001,faba002,faba003,fabastus,fabaownid,fabaowndp,
          fabacrtid,fabacrtdp,fabacrtdt,fabamodid,fabamoddt,fabacnfid,fabacnfdt,faba004,faba005,faba006,faba007,
          faba008,faba009,faba010,faba011,faba012,faba013,faba014,faba015,faba016,faba017,faba018,faba019,faba020,
          faba021,faba022,faba023,faba024 INTO g_faba.* 
   #161111-00028#7---modify--end-----------
   FROM faba_t WHERE fabaent = g_enterprise AND fabadocno = g_fabadocno
   CALL s_fin_create_account_center_tmp() 
   CALL s_fin_account_center_sons_query('5',g_faba.fabasite,g_faba.fabadocdt,'1')
   CALL s_fin_account_center_comp_str() RETURNING l_origin_str
   
   CALL afat410_01_change_to_sql(l_origin_str)RETURNING l_origin_str
   LET l_origin_str = "(",l_origin_str,")"
  #161111-00028#7---modify--begin-----------
  #LET l_sql = " SELECT * FROM faah_t",
   LET l_sql = " SELECT faahent,faah000,faah001,faah002,faah003,faah004,faah005,faah006,faah007,faah008,faah009,",
              "faah010,faah011,faah012,faah013,faah014,faah015,faah016,faah017,faah018,faah019,faah020,faah021,",
              "faah022,faah023,faah024,faah025,faah026,faah027,faah028,faah029,faah030,faah031,faah032,faah033,",
              "faah034,faah035,faah036,faah037,faah038,faah039,faah040,faah041,faah042,faah043,faah044,faah045,",
              "faahownid,faahowndp,faahcrtid,faahcrtdp,faahcrtdt,faahmodid,faahmoddt,faahstus,faah046,faah047,",
              "faah048,faah049,faah050,faah051,faah052,faah053,faah054,faah055,faah056 FROM faah_t",
  #161111-00028#7---modify--end-----------
               "  WHERE faahent = ",g_enterprise," AND faahstus = 'Y' AND faah015 ='0' ",
               "    AND faah028 IN ( SELECT ooef001 FROM ooef_t WHERE ooefent = ",g_enterprise,
               "    AND ooef017 = '",g_faba.fabacomp,"' AND ooef001 IN ",l_origin_str,")",
               "    AND ",g_wc CLIPPED
   
    
   PREPARE afat410_01_faah_prep2 FROM l_sql
   DECLARE afat410_01_faah_curs2 CURSOR FOR afat410_01_faah_prep2
    
   FOREACH afat410_01_faah_curs2 INTO l_faah.*
   
      SELECT MAX(fabnseq) INTO l_fabn.fabnseq
        FROM fabn_t WHERE fabnent = g_enterprise  AND fabndocno = g_fabadocno
      IF cl_null(l_fabn.fabnseq) THEN
         LET l_fabn.fabnseq = 1
      ELSE
         LET l_fabn.fabnseq = l_fabn.fabnseq +1
      END IF
      
      LET l_fabn.fabnent = g_enterprise 
      LET l_fabn.fabncomp = g_faba.fabacomp
      LET l_fabn.fabndocno =g_fabadocno
      LET l_fabn.fabn001 =  l_faah.faah003
      LET l_fabn.fabn002 =  l_faah.faah004
      LET l_fabn.fabn003 =  l_faah.faah001
      LET l_fabn.fabn004 =  l_fabn.fabn001
      LET l_fabn.fabn005 =  l_fabn.fabn002
      LET l_fabn.fabn018 =  l_fabn.fabn003
      LET l_fabn.fabn006 =  l_faah.faah014
      LET l_fabn.fabn007 =  l_faah.faah020
      IF cl_null(l_faah.faah024) OR l_faah.faah024 = 0 THEN
         LET l_fabn.fabn008 = 1
      ELSE
         LET l_fabn.fabn008  =  l_faah.faah022/l_faah.faah024      
      END IF
      LET l_fabn.fabn009 =  l_faah.faah022
      LET l_fabn.fabn010 =  l_faah.faah024
      LET l_fabn.fabn011 =  l_faah.faah025
      LET l_fabn.fabn012 =  l_faah.faah026
      LET l_fabn.fabn013 =  l_faah.faah027
      LET l_fabn.fabn014 =  l_faah.faah030
      LET l_fabn.fabn015 =  l_faah.faah028
      LET l_fabn.fabn016 =  l_faah.faah031
      LET l_fabn.fabn017 =  ''
      
      #161111-00028#7---modify--begin-----------      
      #INSERT INTO fabn_t  VALUES(l_fabn.*)
      INSERT INTO fabn_t (fabnent,fabncomp,fabndocno,fabnseq,fabn001,fabn002,fabn003,fabn004,fabn005,fabn006,
                          fabn007,fabn008,fabn009,fabn010,fabn011,fabn012,fabn013,fabn014,fabn015,
                          fabn016,fabn017,fabn018)
        VALUES(l_fabn.fabnent,l_fabn.fabncomp,l_fabn.fabndocno,l_fabn.fabnseq,l_fabn.fabn001,l_fabn.fabn002,l_fabn.fabn003,l_fabn.fabn004,l_fabn.fabn005,l_fabn.fabn006,
               l_fabn.fabn007,l_fabn.fabn008,l_fabn.fabn009,l_fabn.fabn010,l_fabn.fabn011,l_fabn.fabn012,l_fabn.fabn013,l_fabn.fabn014,l_fabn.fabn015,
               l_fabn.fabn016,l_fabn.fabn017,l_fabn.fabn018)
      #161111-00028#7---modify--end-----------
      
   END FOREACH
END FUNCTION
# 插入调拨单身档
PRIVATE FUNCTION afat410_01_fabv_ins()
#160329-00022#1 mark -str  暂时不用过正
#   DEFINE l_sql             STRING
#   DEFINE l_faah            RECORD LIKE faah_t.*
#   DEFINE l_faaj            RECORD LIKE faaj_t.*
#   DEFINE l_fabv            RECORD LIKE fabv_t.*
#   DEFINE l_ooag004         LIKE ooag_t.ooag004
#   DEFINE l_origin_str      STRING
#   DEFINE tok               base.StringTokenizer
#   DEFINE l_str             STRING
#   DEFINE l_glaald          LIKE glaa_t.glaald
#   DEFINE l_ooab002         LIKE ooab_t.ooab002   
#   
#   SELECT * INTO g_faba.* FROM faba_t WHERE fabaent = g_enterprise AND fabadocno = g_fabadocno
#   
#   SELECT glaald INTO l_glaald FROM glaa_t WHERE glaacomp = g_faba.fabacomp AND glaa014 = 'Y'
#   CALL cl_get_para(g_enterprise,g_faba.fabacomp,'S-FIN-9016') RETURNING l_ooab002
#   
#   CALL s_fin_create_account_center_tmp() 
#   CALL s_fin_account_center_sons_query('5',g_faba.fabasite,g_faba.fabadocdt,'1')
#   CALL s_fin_account_center_comp_str() RETURNING l_origin_str
#   
#   CALL afat410_01_change_to_sql(l_origin_str)RETURNING l_origin_str
#   LET l_origin_str = "(",l_origin_str,")"
#   LET l_sql = " SELECT * FROM faah_t",
#               "  WHERE faahent = ",g_enterprise," AND faahstus = 'Y' ",
#               "    AND faah028 IN ( SELECT ooef001 FROM ooef_t WHERE ooefent = ",g_enterprise,
#               "    AND ooef017 = '",g_faba.fabacomp,"' AND ooef001 IN ",l_origin_str,")",
#               "    AND ",g_wc CLIPPED
#   IF g_faba003 = '32' THEN
#      LET l_sql = l_sql," AND faah015 NOT IN ('0','5','6','10')"
#   END IF
#   PREPARE afat410_01_faah_prep3 FROM l_sql
#   DECLARE afat410_01_faah_curs3 CURSOR FOR afat410_01_faah_prep3
#    
#   FOREACH afat410_01_faah_curs3 INTO l_faah.*
#      
#      SELECT * INTO l_faaj.*
#        FROM faaj_t
#       WHERE faajent = g_enterprise
#         AND faajld = l_glaald
#         AND faaj001 = l_faah.faah003
#         AND faaj002 = l_faah.faah004
#         AND faaj037 = l_faah.faah001
#         
#      IF cl_null(l_faaj.faaj033) THEN LET l_faaj.faaj033 = 0 END IF
#      IF cl_null(l_faaj.faaj016) THEN LET l_faaj.faaj016 = 0 END IF
#      IF cl_null(l_faaj.faaj020) THEN LET l_faaj.faaj020 = 0 END IF
#      IF cl_null(l_faaj.faaj034) THEN LET l_faaj.faaj034 = 0 END IF
#      IF cl_null(l_faaj.faaj028) THEN LET l_faaj.faaj028 = 0 END IF
#      IF cl_null(l_faaj.faaj017) THEN LET l_faaj.faaj017 = 0 END IF
#      IF cl_null(l_faaj.faaj035) THEN LET l_faaj.faaj035 = 0 END IF
#      IF cl_null(l_faaj.faaj021) THEN LET l_faaj.faaj021 = 0 END IF
#      IF cl_null(l_faaj.faaj027) THEN LET l_faaj.faaj027 = 0 END IF
#      
#      SELECT MAX(fabvseq) INTO l_fabv.fabvseq   
#        FROM fabv_t
#       WHERE fabvent = g_enterprise 
#         AND fabvdocno = g_fabadocno
#      IF cl_null(l_fabv.fabvseq) THEN
#         LET l_fabv.fabvseq = 1
#      ELSE
#         LET l_fabv.fabvseq = l_fabv.fabvseq +1
#      END IF
#      LET l_fabv.fabvent = g_enterprise
#      LET l_fabv.fabvdocno = g_fabadocno
#      LET l_fabv.fabv001 = g_faba003
#      LET l_fabv.fabv004 = l_faah.faah003 
#      LET l_fabv.fabv005 = l_faah.faah004
#      LET l_fabv.fabv006 = l_faah.faah001
#      LET l_fabv.fabv007 = l_faah.faah006
#      LET l_fabv.fabv008 = l_faah.faah027
#      LET l_fabv.fabv009 = g_faba.fabacomp
#      LET l_fabv.fabv011 = l_faah.faah031
#      LET l_fabv.fabv012 = l_faah.faah031
#      LET l_fabv.fabv013 = l_faah.faah030
#      LET l_fabv.fabv014 = l_faah.faah030
#      
#      #调拨数量=数量faah018-处置数量faaj033    
#      LET l_fabv.fabv015 = l_faah.faah018 - l_faaj.faaj033
#      
#      IF l_ooab002 = '1' THEN 
#         #成本价
#         #成本=固定资产的原价faaj016+调整成本faaj020-处置成本faaj034
#         #累计折旧=（计提的累计折旧faaj017-处置的累折faaj035）/(数量faah018-处置数量faaj033）
#         #减值准备=（计提的减值准备faaj021-处置的减值准备faaj027）/(数量faah018-处置数量faaj033）       
#         LET l_fabv.fabv016 = l_faaj.faaj016 - l_faaj.faaj020 - l_faaj.faaj034
#         LET l_fabv.fabv017 = (l_faaj.faaj017 - l_faaj.faaj035) / l_fabv.fabv015
#         LET l_fabv.fabv019 = (l_faaj.faaj021 - l_faaj.faaj027) / l_fabv.fabv015
#      ELSE
#         LET l_fabv.fabv016 = l_faaj.faaj028
#         LET l_fabv.fabv017 = 0
#         LET l_fabv.fabv019 = 0
#      END IF    
#      
#      INSERT INTO fabv_t VALUES(l_fabv.*)
#   END FOREACH
#160329-00022#1 mark -end
END FUNCTION

 
{</section>}
 
