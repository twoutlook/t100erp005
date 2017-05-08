#該程式未解開Section, 採用最新樣板產出!
{<section id="afat421_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2015-03-24 11:16:02), PR版次:0006(2016-12-08 17:20:09)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000070
#+ Filename...: afat421_01
#+ Description: 自動產生
#+ Creator....: 02003(2015-02-05 16:39:32)
#+ Modifier...: 02003 -SD/PR- 07900
 
{</section>}
 
{<section id="afat421_01.global" >}
#應用 c01c 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#+ Modifier...: 160318-00025#28  2016/04/05  By pengxin  修正azzi920重复定义之错误讯息
#161111-00028#7     2016/11/23 by 02481       标准程式定义采用宣告模式,弃用.*写法
#161123-00029#1   2016/12/07 By 07900      1、分摊方式：由资产带回，只读。
#                                          2、分摊方式(新)：default 分摊方式，可修改，checkbox值同afai100（1/2/4）。分摊部门/类别(新)按所选分摊方式(新)来处理，处理同afai100：1时为部门，2时为类别，4时不可输入，系统自动产生，同时生成afai060数据。审核后要以分摊方式(新)更新afai100的分摊方式。
#                                          3、自动产生单身资料的程式也要一并修改
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

DEFINE g_faah025             LIKE faah_t.faah025
DEFINE g_faah026             LIKE faah_t.faah026
DEFINE g_faah027             LIKE faah_t.faah027
DEFINE g_faah025_desc        LIKE type_t.chr50
DEFINE g_faah026_desc        LIKE type_t.chr50
DEFINE g_faah027_desc        LIKE type_t.chr50
DEFINE g_fabb013             LIKE fabb_t.fabb013
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point  
 
{</section>}
 
{<section id="afat421_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION afat421_01(--)
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
   DEFINE l_origin_str    STRING
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_afat421_01 WITH FORM cl_ap_formpath("afa","afat421_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   #輸入前處理
   #add-point:單頭前置處理 name="construct.pre_construct"
   LET g_fabadocno = p_fabadocno
   LET g_faba001 = p_faba001
   LET g_faba003 = p_faba003
   LET g_fabb013 = 'N' 
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
   CALL afat421_01_change_to_sql(l_origin_str)RETURNING l_origin_str
   LET l_origin_str = "(",l_origin_str,")"   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      CONSTRUCT BY NAME g_wc ON faah001,faah003,faah004,faah026,faah025,faah027 
      
            #add-point:自定義action name="construct.action"
            ON ACTION controlp INFIELD faah001
               #此段落由子樣板a08產生
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
		         LET g_qryparam.where = " faahstus = 'Y' AND faah028 IN ( SELECT ooef001 FROM ooef_t ",
		                                "                                  WHERE ooefent = ",g_enterprise,
		                                "                                    AND ooef017 = '",g_faba.fabacomp,"'",
		                                "                                    AND ooef001 IN ",l_origin_str,")",
		                                " AND faah015 NOT IN ('5','6','10')"
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
		                                "                                    AND ooef017 = '",g_faba.fabacomp,"'",
		                                "                                    AND ooef001 IN ",l_origin_str,")",
		                                " AND faah015 NOT IN ('5','6','10')"
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
		                                "                                    AND ooef017 = '",g_faba.fabacomp,"'",
		                                "                                    AND ooef001 IN ",l_origin_str,")",
		                                " AND faah015 NOT IN ('5','6','10')"
               CALL q_faah004()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO faah004  #顯示到畫面上
               
               NEXT FIELD faah004                     #返回原欄位
            
           ON ACTION controlp INFIELD faah025
			     INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'c'
			     LET g_qryparam.reqry = FALSE
              CALL q_ooag001()                           #呼叫開窗
              DISPLAY g_qryparam.return1 TO faah025 
              NEXT FIELD faah025                     #返回原欄位
               
           ON ACTION controlp INFIELD faah026
			     INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'c'
			     LET g_qryparam.reqry = FALSE
              LET g_qryparam.arg1 = g_today
              CALL q_ooeg001_4()
              DISPLAY g_qryparam.return1 TO faah026
              NEXT FIELD faah026
              
           ON ACTION controlp INFIELD faah027
			     INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'c'
			     LET g_qryparam.reqry = FALSE
			     LET g_qryparam.arg1 = '3900'
              CALL q_oocq002()                           #呼叫開窗
              DISPLAY g_qryparam.return1 TO faah027  #顯示到畫面上
              NEXT FIELD faah027
            #end add-point
      
         BEFORE CONSTRUCT
            #add-point:單頭輸入前處理 name="construct.before_construct"
            
            #end add-point
            
         AFTER CONSTRUCT
            #add-point:單頭輸入後處理 name="construct.after_construct"
            IF NOT INT_FLAG THEN
               IF g_wc = " 1=1" THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00417'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err() 
                  NEXT FIELD faah001
               END IF
            END IF 
            #end add-point
            
         
 
         
       
      END CONSTRUCT
 
      #add-point:自定義construct name="construct.more_construct"
      INPUT g_faah026,g_faah025,g_faah027,g_fabb013 FROM b_faah026,b_faah025,b_faah027,fabb013 ATTRIBUTE(WITHOUT DEFAULTS)
      
         AFTER FIELD b_faah025
            IF NOT cl_null(g_faah025) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#28  add
               LET g_chkparam.arg1 = g_faah025
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"#要執行的建議程式待補#160318-00025#28  add
               IF cl_chk_exist("v_ooag001") THEN
               ELSE
                  LET g_faah025 = ''
                  DISPLAY g_faah025 TO b_faah025
                  NEXT FIELD CURRENT
               END IF
            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_faah025
            CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM oofa_t WHERE oofaent='"||g_enterprise||"' AND oofa003=? ","") RETURNING g_rtn_fields
            LET g_faah025_desc = '', g_rtn_fields[1] , ''
            DISPLAY g_faah025_desc TO b_faah025_desc
            
         AFTER FIELD b_faah026
            IF NOT cl_null(g_faah026) THEN 
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#28  add
               LET g_chkparam.arg1 = g_faah026
               LET g_chkparam.arg2 = g_today
               LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"#要執行的建議程式待補#160318-00025#28  add
               IF cl_chk_exist("v_ooeg001_3") THEN
               ELSE
                  LET g_faah026 =''
                  DISPLAY g_faah026 TO b_faah026
                  NEXT FIELD CURRENT
               END IF
            END IF 
            LET g_ref_fields[1] = g_faah026
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_faah026_desc = '', g_rtn_fields[1] , ''
            DISPLAY g_faah026_desc TO b_faah026_desc

         AFTER FIELD b_faah027
            IF NOT cl_null(g_faah027) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_faah027
               IF cl_chk_exist("v_oocq002_3900") THEN
               ELSE
                  LET g_faah027 = ''
                  DISPLAY g_faah027 TO b_faah027
                  NEXT FIELD CURRENT
               END IF
            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_faah027
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='3900' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_faah027_desc = '', g_rtn_fields[1] , ''
            DISPLAY g_faah027_desc TO b_faah027_desc
            
            
         ON ACTION controlp INFIELD b_faah026
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_faah026
            #給予arg
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001_4()
            LET g_faah026 = g_qryparam.return1              #將開窗取得的值回傳到變數
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_faah026
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_faah026_desc = '', g_rtn_fields[1] , ''
            DISPLAY g_faah026 TO b_faah026              #顯示到畫面上
            DISPLAY g_faah026_desc TO b_faah026_desc
            NEXT FIELD b_faah026                          #返回原欄位

         ON ACTION controlp INFIELD b_faah025
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah025             #給予default值
            CALL q_ooag001()
            LET g_faah025 = g_qryparam.return1              
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_faah025
            CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM oofa_t WHERE oofaent='"||g_enterprise||"' AND oofa003=? ","") RETURNING g_rtn_fields
            LET g_faah025_desc = '', g_rtn_fields[1] , ''
            DISPLAY g_faah025 TO b_faah025              #
            DISPLAY g_faah025_desc TO b_faah025_desc  
            NEXT FIELD b_faah025 
            
         ON ACTION controlp INFIELD b_faah027
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_faah027
            LET g_qryparam.arg1 = "3900" 
            CALL q_oocq002()          
            LET g_faah027 = g_qryparam.return1              
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_faah027
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='3900' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_faah027_desc = '', g_rtn_fields[1] , ''
            DISPLAY g_faah027 TO b_faah027
            DISPLAY g_faah027_desc TO b_faah027_desc
            NEXT FIELD b_faah027    
            
      END INPUT 
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
   
   IF INT_FLAG THEN
      LET INT_FLAG = 0
   ELSE
      CALL afat421_01_fabb_ins()
   END IF
   #end add-point 
   
   #畫面關閉
   CLOSE WINDOW w_afat421_01 
   
   #add-point:construct段after construct name="construct.post_construct"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="afat421_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="afat421_01.other_function" readonly="Y" >}

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
PRIVATE FUNCTION afat421_01_fabb_ins()
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
       fabb030 LIKE fabb_t.fabb030, #分攤部門/類別(新)
       fabb031 LIKE fabb_t.fabb031, #分摊方式（旧） #161123-00029#1 add
       fabb032 LIKE fabb_t.fabb032  #分摊方式（新） #161123-00029#1 add
       END RECORD
#161111-00028#7---modify--end-----------

DEFINE  l_ooag004    LIKE ooag_t.ooag004
DEFINE  l_origin_str  STRING
DEFINE  tok        base.StringTokenizer
DEFINE  l_str      STRING
DEFINE  l_n        LIKE type_t.num5
DEFINE  l_glaald   LIKE glaa_t.glaald

   #161111-00028#7---modify--begin-----------
   #SELECT * INTO g_faba.* 
   SELECT fabaent,fabadocno,fabadocdt,fabasite,fabacomp,faba001,faba002,faba003,fabastus,fabaownid,fabaowndp,
          fabacrtid,fabacrtdp,fabacrtdt,fabamodid,fabamoddt,fabacnfid,fabacnfdt,faba004,faba005,faba006,faba007,
          faba008,faba009,faba010,faba011,faba012,faba013,faba014,faba015,faba016,faba017,faba018,faba019,faba020,
          faba021,faba022,faba023,faba024 INTO g_faba.* 
   #161111-00028#7---modify--end-----------
   FROM faba_t WHERE fabaent = g_enterprise AND fabadocno = g_fabadocno
   #獲取主帳套
   SELECT glaald INTO l_glaald
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaacomp = g_faba.fabacomp
      AND glaa014 = 'Y' 
   CALL s_fin_create_account_center_tmp() 
   CALL s_fin_account_center_sons_query('5',g_faba.fabasite,g_faba.fabadocdt,'1')
   CALL s_fin_account_center_comp_str() RETURNING l_origin_str
   
   CALL afat421_01_change_to_sql(l_origin_str)RETURNING l_origin_str
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
               "    AND faah015 NOT IN ('5','6','10') ",
               "    AND ",g_wc CLIPPED
   PREPARE afat421_01_faah_prep FROM l_sql
   DECLARE afat421_01_faah_curs CURSOR FOR afat421_01_faah_prep
   
   FOREACH afat421_01_faah_curs INTO l_faah.*
      LET l_n = 0
      #检查是否已存在未审核的faab资料档中
      SELECT COUNT(*) INTO l_n FROM faba_t,fabb_t
       WHERE fabaent = fabbent 
         AND fabadocno = fabbdocno
         AND fabbent = g_enterprise
         AND fabbdocno <> g_faba.fabadocno
         AND faba003 = '27'
         AND fabb001 = l_faah.faah003
         AND fabb002 = l_faah.faah004
         AND fabb000 = l_faah.faah001
         AND fabastus = 'N'
      IF l_n > 0 THEN 
         CONTINUE FOREACH 
      END IF 
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
      #部門、人員、存放位置舊值
      LET l_fabb.fabb010 = l_faah.faah026
      LET l_fabb.fabb011 = l_faah.faah025
      LET l_fabb.fabb012 = l_faah.faah027
      IF NOT cl_null(g_faah025) THEN 
         LET l_fabb.fabb004 = g_faah025
      ELSE
         LET l_fabb.fabb004 = l_fabb.fabb011
      END IF 
      IF NOT cl_null(g_faah026) THEN 
         LET l_fabb.fabb003 = g_faah026
      ELSE
         LET l_fabb.fabb003 = l_fabb.fabb010
      END IF 
      IF NOT cl_null(g_faah027) THEN 
         LET l_fabb.fabb009 = g_faah027
      ELSE
         LET l_fabb.fabb009 = l_fabb.fabb012
      END IF 
      LET l_fabb.fabb013 = g_fabb013
      
      #獲取科目舊值
      SELECT faaj023,faaj024,faaj025,faaj026,faaj006,faaj007   #161123-00029#1 add faaj0006,faaj007
        INTO l_fabb.fabb014,l_fabb.fabb016,l_fabb.fabb018,l_fabb.fabb020,l_fabb.fabb031,l_fabb.fabb029  #161123-00029#1 add l_fabb.fabb031,l_fabb.fabb029 
        FROM faaj_t
       WHERE faajent = g_enterprise
         AND faaj001 = l_faah.faah003
         AND faaj002 = l_faah.faah004
         AND faaj037 = l_faah.faah001
         AND faajld = l_glaald
         
      LET l_fabb.fabb015 = l_fabb.fabb014
      LET l_fabb.fabb017 = l_fabb.fabb016
      LET l_fabb.fabb019 = l_fabb.fabb018
      LET l_fabb.fabb021 = l_fabb.fabb020
      LET l_fabb.fabb023 = l_faah.faah028
      LET l_fabb.fabb024 = l_faah.faah028
      LET l_fabb.fabb025 = l_faah.faah030
      LET l_fabb.fabb026 = l_faah.faah030
      LET l_fabb.fabb027 = l_faah.faah031
      LET l_fabb.fabb028 = l_faah.faah031
      LET l_fabb.fabb032 = l_fabb.fabb031    #161123-00029#1 add
      LET l_fabb.fabb030 = l_fabb.fabb029    #161123-00029#1 add
      #161123-00029#1 add--s--
      IF  l_fabb.fabb032 = '4' THEN
           LET l_n = 0 
           SELECT COUNT(*) INTO l_n FROM faai_t
            WHERE faaient = g_enterprise
              AND faai001 = l_fabb.fabb000
              AND faai002 = l_fabb.fabb001
              AND faai003 = l_fabb.fabb002
           IF l_n = 0 THEN            
              LET l_fabb.fabb032 = ''     
           END IF      
      END IF     
      #161123-00029#1 add--e--
      #161111-00028#7---modify--begin-----------
      #INSERT INTO fabb_t VALUES(l_fabb.*)
      INSERT INTO fabb_t (fabbent,fabbcomp,fabbdocno,fabbseq,fabblegl,fabb000,fabb001,fabb002,fabb003,fabb004,
                          fabb005,fabb006,fabb007,fabb008,fabb009,fabb010,fabb011,fabb012,fabb013,fabb014,fabb015,
                          fabb016,fabb017,fabb018,fabb019,fabb020,fabb021,fabb022,fabb023,fabb024,fabb025,fabb026,
                          fabb027,fabb028,fabb029,fabb030,fabb031,fabb032) #161123-00029#1 add fabb031,fabb032
        VALUES(l_fabb.fabbent,l_fabb.fabbcomp,l_fabb.fabbdocno,l_fabb.fabbseq,l_fabb.fabblegl,l_fabb.fabb000,l_fabb.fabb001,l_fabb.fabb002,l_fabb.fabb003,l_fabb.fabb004,
               l_fabb.fabb005,l_fabb.fabb006,l_fabb.fabb007,l_fabb.fabb008,l_fabb.fabb009,l_fabb.fabb010,l_fabb.fabb011,l_fabb.fabb012,l_fabb.fabb013,l_fabb.fabb014,l_fabb.fabb015,
               l_fabb.fabb016,l_fabb.fabb017,l_fabb.fabb018,l_fabb.fabb019,l_fabb.fabb020,l_fabb.fabb021,l_fabb.fabb022,l_fabb.fabb023,l_fabb.fabb024,l_fabb.fabb025,l_fabb.fabb026,
               l_fabb.fabb027,l_fabb.fabb028,l_fabb.fabb029,l_fabb.fabb030,l_fabb.fabb031,l_fabb.fabb032) #161123-00029#1 add l_fabb.fabb031,l_fabb.fabb032
      #161111-00028#7---modify--end-----------
      #161123-00029#1 add--S--
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fabb_t:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN       
      END IF
      #161123-00029#1 add--E--
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
PUBLIC FUNCTION afat421_01_change_to_sql(p_wc)
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

 
{</section>}
 
