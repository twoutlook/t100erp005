#該程式未解開Section, 採用最新樣板產出!
{<section id="abgi410_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-11-12 21:02:01), PR版次:0001(2016-12-13 10:33:32)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: abgi410_01
#+ Description: 預算料件BOM批次產生
#+ Creator....: 02114(2016-11-12 20:58:15)
#+ Modifier...: 02114 -SD/PR- 02114
 
{</section>}
 
{<section id="abgi410_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#Memos
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
PRIVATE type type_g_bgda_m        RECORD
       source LIKE type_t.chr500, 
   bgcj002 LIKE bgcj_t.bgcj002, 
   bgcj003 LIKE bgcj_t.bgcj003, 
   bgda001 LIKE bgda_t.bgda001, 
   bgda001_desc LIKE type_t.chr80, 
   bgda003 LIKE bgda_t.bgda003
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_wc            STRING
#end add-point
 
DEFINE g_bgda_m        type_g_bgda_m
 
   DEFINE g_bgda001_t LIKE bgda_t.bgda001
DEFINE g_bgda003_t LIKE bgda_t.bgda003
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="abgi410_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION abgi410_01(--)
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
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_flag          LIKE type_t.chr1
   DEFINE l_site_str      STRING
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_abgi410_01 WITH FORM cl_ap_formpath("abg","abgi410_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   CALL s_fin_create_account_center_tmp()
   CALL cl_set_combo_scc('source','8960')   
   LET g_bgda_m.source = '1'
   CALL cl_set_comp_visible('bgcj002,bgcj003',TRUE) 
   LET g_bgda_m.bgda003 = g_today
   
   CALL cl_set_comp_entry("bgda001",TRUE)
   IF g_prog = 'abgi415' THEN 
      SELECT ooef017 INTO g_bgda_m.bgda001
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = g_site
      CALL s_desc_get_department_desc(g_bgda_m.bgda001) RETURNING g_bgda_m.bgda001_desc
      DISPLAY BY NAME g_bgda_m.bgda001_desc   
   ELSE
      LET g_bgda_m.bgda001 = 'ALL'
      CALL cl_set_comp_entry("bgda001",FALSE)
   END IF
   LET l_site_str = ''
   LET g_errshow = 1
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_bgda_m.source,g_bgda_m.bgcj002,g_bgda_m.bgcj003,g_bgda_m.bgda001,g_bgda_m.bgda003  
          ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD source
            #add-point:BEFORE FIELD source name="input.b.source"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD source
            
            #add-point:AFTER FIELD source name="input.a.source"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE source
            #add-point:ON CHANGE source name="input.g.source"
            IF g_bgda_m.source = '1' THEN 
               CALL cl_set_comp_visible('bgcj002,bgcj003',TRUE) 
            ELSE
               CALL cl_set_comp_visible('bgcj002,bgcj003',FALSE) 
            END IF
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj002
            
            #add-point:AFTER FIELD bgcj002 name="input.a.bgcj002"
            IF NOT cl_null(g_bgda_m.bgcj002) THEN 
#應用 a17 樣板自動產生(Version:3)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
 
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_bgda_m.bgcj002

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_bgaa001") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  LET g_bgda_m.bgcj002 = ''
                  NEXT FIELD CURRENT
               END IF
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj002
            #add-point:BEFORE FIELD bgcj002 name="input.b.bgcj002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj002
            #add-point:ON CHANGE bgcj002 name="input.g.bgcj002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj003
            #add-point:BEFORE FIELD bgcj003 name="input.b.bgcj003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj003
            
            #add-point:AFTER FIELD bgcj003 name="input.a.bgcj003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj003
            #add-point:ON CHANGE bgcj003 name="input.g.bgcj003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgda001
            
            #add-point:AFTER FIELD bgda001 name="input.a.bgda001"
            IF NOT cl_null(g_bgda_m.bgda001) THEN 
#應用 a19 樣板自動產生(Version:2)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_bgda_m.bgda001
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooef001_24") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  CALL s_abg2_get_budget_site(g_bgda_m.bgcj002,'',g_user,'02') RETURNING l_site_str
                  IF cl_null(l_site_str) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'abg-00248'
                     LET g_errparam.extend = g_bgda_m.bgda001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgda_m.bgda001 = ''
                     LET g_bgda_m.bgda001_desc = ''
                     DISPLAY BY NAME g_bgda_m.bgda001_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  #檢查預算組織是否在abgi090中可操作的組織中
                  IF s_chr_get_index_of(l_site_str,g_bgda_m.bgda001,1) = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'abg-00247'
                     LET g_errparam.extend = g_bgda_m.bgda001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgda_m.bgda001 = ''
                     LET g_bgda_m.bgda001_desc = ''
                     DISPLAY BY NAME g_bgda_m.bgda001_desc
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  #檢查失敗時後續處理
                  LET g_bgda_m.bgda001 = ''
                  LET g_bgda_m.bgda001_desc = ''
                  NEXT FIELD CURRENT
               END IF
            END IF 
            CALL s_desc_get_department_desc(g_bgda_m.bgda001) RETURNING g_bgda_m.bgda001_desc
            DISPLAY BY NAME g_bgda_m.bgda001_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgda001
            #add-point:BEFORE FIELD bgda001 name="input.b.bgda001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgda001
            #add-point:ON CHANGE bgda001 name="input.g.bgda001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgda003
            #add-point:BEFORE FIELD bgda003 name="input.b.bgda003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgda003
            
            #add-point:AFTER FIELD bgda003 name="input.a.bgda003"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgda003
            #add-point:ON CHANGE bgda003 name="input.g.bgda003"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.source
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD source
            #add-point:ON ACTION controlp INFIELD source name="input.c.source"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgcj002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj002
            #add-point:ON ACTION controlp INFIELD bgcj002 name="input.c.bgcj002"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgda_m.bgcj002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

 
            CALL q_bgaa001()                                #呼叫開窗
 
            LET g_bgda_m.bgcj002 = g_qryparam.return1              

            DISPLAY g_bgda_m.bgcj002 TO bgcj002              #

            NEXT FIELD bgcj002                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgcj003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj003
            #add-point:ON ACTION controlp INFIELD bgcj003 name="input.c.bgcj003"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgda001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgda001
            #add-point:ON ACTION controlp INFIELD bgda001 name="input.c.bgda001"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgda_m.bgda001             #給予default值
            
            #檢查預算組織是否在abgi090中可操作的組織中
            CALL s_abg2_get_budget_site(g_bgda_m.bgcj002,'',g_user,'02') RETURNING l_site_str
            CALL s_fin_get_wc_str(l_site_str) RETURNING l_site_str
            IF NOT cl_null(g_qryparam.where) THEN
               LET g_qryparam.where = g_qryparam.where,
                                      " AND ooef001 IN ",l_site_str
            ELSE
               LET g_qryparam.where = " ooef001 IN ",l_site_str
            END IF
            
            #給予arg
            LET g_qryparam.arg1 = "" #

 
            CALL q_ooef001_77()                                #呼叫開窗
 
            LET g_bgda_m.bgda001 = g_qryparam.return1              

            DISPLAY g_bgda_m.bgda001 TO bgda001              #

            NEXT FIELD bgda001                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgda003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgda003
            #add-point:ON ACTION controlp INFIELD bgda003 name="input.c.bgda003"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            
            #end add-point
            
      END INPUT
    
      #add-point:自定義input name="input.more_input"
      CONSTRUCT BY NAME g_wc ON bgas001,bgas004
            BEFORE CONSTRUCT
      
         ON ACTION controlp INFIELD bgas001
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_bgas001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgas001  #顯示到畫面上
            NEXT FIELD bgas001    
      
         ON ACTION controlp INFIELD bgas004
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imca001_1()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgas004  #顯示到畫面上
            NEXT FIELD bgas004
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
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      CLOSE WINDOW w_abgi410_01 
      RETURN
   END IF
   
   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   
   IF g_bgda_m.source = '1' THEN 
      CALL abgi410_01_ins_1() RETURNING l_success,l_flag
   ELSE
      CALL abgi410_01_ins_2('') RETURNING l_success,l_flag
   END IF
   IF l_success = TRUE THEN 
      IF l_flag = 'N' THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ""
         LET g_errparam.code   = 'axc-00530' 
         LET g_errparam.popup = TRUE
         CALL cl_err()
         CALL s_transaction_end('N','0')  
      ELSE
         CALL s_transaction_end('Y','1')
      END IF
   ELSE
      CALL s_transaction_end('N','1')
   END IF
   CALL cl_err_collect_show()
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_abgi410_01 
   
   #add-point:input段after input name="input.post_input"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="abgi410_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="abgi410_01.other_function" readonly="Y" >}
# 依销售预测产生
PRIVATE FUNCTION abgi410_01_ins_1()
   DEFINE l_sql          STRING 
   DEFINE l_bgcj009      LIKE bgcj_t.bgcj009
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_flag         LIKE type_t.chr1
   DEFINE r_flag         LIKE type_t.chr1
   DEFINE r_success      LIKE type_t.num5
   
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   LET l_success = TRUE
   LET r_flag = 'N'
   
   IF cl_null(g_wc) THEN 
      LET g_wc = " 1=1 "
   END IF
   
   LET l_sql = "SELECT DISTINCT bgcj009 FROM bgcj_t ",
               " WHERE bgcjent = ",g_enterprise,
               "   AND bgcj002 = '",g_bgda_m.bgcj002,"'",
               "   AND bgcj003 = '",g_bgda_m.bgcj003,"'"
   PREPARE abgi410_01_ins_1_pre FROM l_sql
   DECLARE abgi410_01_ins_1_cs CURSOR FOR abgi410_01_ins_1_pre
   
   FOREACH abgi410_01_ins_1_cs INTO l_bgcj009
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'abgi410_01_ins_2_cs'
         LET g_errparam.popup = TRUE
         CALL cl_err()
       
         LET r_success = FALSE
      END IF
      
      CALL abgi410_01_ins_2(l_bgcj009) RETURNING l_success,l_flag
      
      IF l_success = FALSE THEN 
         LET r_success = FALSE
      END IF
      
      IF l_flag = 'Y' THEN 
         LET r_flag = 'Y'
      END IF
   END FOREACH
   
   RETURN r_success,r_flag
END FUNCTION
# 依预算料件产生
PRIVATE FUNCTION abgi410_01_ins_2(p_bgcj009)
   DEFINE p_bgcj009      LIKE bgcj_t.bgcj009
   DEFINE l_sql          STRING
   DEFINE l_bgas001      LIKE bgas_t.bgas001
   DEFINE l_bgas002      LIKE bgas_t.bgas002
   DEFINE l_imae037      LIKE imae_t.imae037
   DEFINE l_bmaasite     LIKE bmaa_t.bmaasite 
   DEFINE l_bmaa001      LIKE bmaa_t.bmaa001
   DEFINE l_bmaa002      LIKE bmaa_t.bmaa002
   DEFINE l_bgat001      LIKE bgat_t.bgat001
   DEFINE l_bmba003      LIKE bmba_t.bmba003
   DEFINE l_bmba004      LIKE bmba_t.bmba004
   DEFINE l_bmba005      LIKE bmba_t.bmba005
   DEFINE l_bmba007      LIKE bmba_t.bmba007
   DEFINE l_bmba008      LIKE bmba_t.bmba008
   DEFINE l_bmba010      LIKE bmba_t.bmba010
   DEFINE l_bmba011      LIKE bmba_t.bmba011
   DEFINE l_bmba012      LIKE bmba_t.bmba012
   DEFINE l_bmba029      LIKE bmba_t.bmba029
   DEFINE l_today        DATETIME YEAR TO SECOND
   DEFINE l_wc           STRING
   DEFINE l_n            LIKE type_t.num5
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_delete       LIKE type_t.chr1     #是否存在同一生效日期相同料件需要删除重产
   DEFINE l_invalid      LIKE type_t.chr1     #是否存在不同生效日期相同料件需要上失效日期
   DEFINE r_flag         LIKE type_t.chr1
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_bgda RECORD  #預算產品結構主檔
                 bgdaent LIKE bgda_t.bgdaent, #企業編號
                 bgdaownid LIKE bgda_t.bgdaownid, #資料所有者
                 bgdaowndp LIKE bgda_t.bgdaowndp, #資料所屬部門
                 bgdacrtid LIKE bgda_t.bgdacrtid, #資料建立者
                 bgdacrtdp LIKE bgda_t.bgdacrtdp, #資料建立部門
                 bgdacrtdt LIKE bgda_t.bgdacrtdt, #資料創建日
                 bgdamodid LIKE bgda_t.bgdamodid, #資料修改者
                 bgdamoddt LIKE bgda_t.bgdamoddt, #最近修改日
                 bgdacnfid LIKE bgda_t.bgdacnfid, #資料確認者
                 bgdacnfdt LIKE bgda_t.bgdacnfdt, #資料確認日
                 bgdastus LIKE bgda_t.bgdastus, #狀態碼
                 bgda001 LIKE bgda_t.bgda001, #預算組織
                 bgda002 LIKE bgda_t.bgda002, #預算主件料號
                 bgda003 LIKE bgda_t.bgda003, #生效日期
                 bgda004 LIKE bgda_t.bgda004, #主件生產單位
                 bgda005 LIKE bgda_t.bgda005, #失效日期
                 bgda006 LIKE bgda_t.bgda006, #參考主件
                 bgda007 LIKE bgda_t.bgda007, #參考據點
                 bgda008 LIKE bgda_t.bgda008, #參考來源
                 bgda009 LIKE bgda_t.bgda009, #參考預算編號
                 bgdaud001 LIKE bgda_t.bgdaud001, #自定義欄位(文字)001
                 bgdaud002 LIKE bgda_t.bgdaud002, #自定義欄位(文字)002
                 bgdaud003 LIKE bgda_t.bgdaud003, #自定義欄位(文字)003
                 bgdaud004 LIKE bgda_t.bgdaud004, #自定義欄位(文字)004
                 bgdaud005 LIKE bgda_t.bgdaud005, #自定義欄位(文字)005
                 bgdaud006 LIKE bgda_t.bgdaud006, #自定義欄位(文字)006
                 bgdaud007 LIKE bgda_t.bgdaud007, #自定義欄位(文字)007
                 bgdaud008 LIKE bgda_t.bgdaud008, #自定義欄位(文字)008
                 bgdaud009 LIKE bgda_t.bgdaud009, #自定義欄位(文字)009
                 bgdaud010 LIKE bgda_t.bgdaud010, #自定義欄位(文字)010
                 bgdaud011 LIKE bgda_t.bgdaud011, #自定義欄位(數字)011
                 bgdaud012 LIKE bgda_t.bgdaud012, #自定義欄位(數字)012
                 bgdaud013 LIKE bgda_t.bgdaud013, #自定義欄位(數字)013
                 bgdaud014 LIKE bgda_t.bgdaud014, #自定義欄位(數字)014
                 bgdaud015 LIKE bgda_t.bgdaud015, #自定義欄位(數字)015
                 bgdaud016 LIKE bgda_t.bgdaud016, #自定義欄位(數字)016
                 bgdaud017 LIKE bgda_t.bgdaud017, #自定義欄位(數字)017
                 bgdaud018 LIKE bgda_t.bgdaud018, #自定義欄位(數字)018
                 bgdaud019 LIKE bgda_t.bgdaud019, #自定義欄位(數字)019
                 bgdaud020 LIKE bgda_t.bgdaud020, #自定義欄位(數字)020
                 bgdaud021 LIKE bgda_t.bgdaud021, #自定義欄位(日期時間)021
                 bgdaud022 LIKE bgda_t.bgdaud022, #自定義欄位(日期時間)022
                 bgdaud023 LIKE bgda_t.bgdaud023, #自定義欄位(日期時間)023
                 bgdaud024 LIKE bgda_t.bgdaud024, #自定義欄位(日期時間)024
                 bgdaud025 LIKE bgda_t.bgdaud025, #自定義欄位(日期時間)025
                 bgdaud026 LIKE bgda_t.bgdaud026, #自定義欄位(日期時間)026
                 bgdaud027 LIKE bgda_t.bgdaud027, #自定義欄位(日期時間)027
                 bgdaud028 LIKE bgda_t.bgdaud028, #自定義欄位(日期時間)028
                 bgdaud029 LIKE bgda_t.bgdaud029, #自定義欄位(日期時間)029
                 bgdaud030 LIKE bgda_t.bgdaud030  #自定義欄位(日期時間)030
                 END RECORD
   DEFINE l_bgdb RECORD  #預算產品結構明細檔
                 bgdbent LIKE bgdb_t.bgdbent, #企業編號
                 bgdb001 LIKE bgdb_t.bgdb001, #預算組織
                 bgdb002 LIKE bgdb_t.bgdb002, #預算主件料號
                 bgdb003 LIKE bgdb_t.bgdb003, #生效日期
                 bgdbseq LIKE bgdb_t.bgdbseq, #項次
                 bgdb004 LIKE bgdb_t.bgdb004, #元件料號
                 bgdb005 LIKE bgdb_t.bgdb005, #組成用量
                 bgdb006 LIKE bgdb_t.bgdb006, #主件底數
                 bgdb007 LIKE bgdb_t.bgdb007, #發料單位
                 bgdb008 LIKE bgdb_t.bgdb008, #損耗率
                 bgdb009 LIKE bgdb_t.bgdb009, #失效日期
                 bgdbud001 LIKE bgdb_t.bgdbud001, #自定義欄位(文字)001
                 bgdbud002 LIKE bgdb_t.bgdbud002, #自定義欄位(文字)002
                 bgdbud003 LIKE bgdb_t.bgdbud003, #自定義欄位(文字)003
                 bgdbud004 LIKE bgdb_t.bgdbud004, #自定義欄位(文字)004
                 bgdbud005 LIKE bgdb_t.bgdbud005, #自定義欄位(文字)005
                 bgdbud006 LIKE bgdb_t.bgdbud006, #自定義欄位(文字)006
                 bgdbud007 LIKE bgdb_t.bgdbud007, #自定義欄位(文字)007
                 bgdbud008 LIKE bgdb_t.bgdbud008, #自定義欄位(文字)008
                 bgdbud009 LIKE bgdb_t.bgdbud009, #自定義欄位(文字)009
                 bgdbud010 LIKE bgdb_t.bgdbud010, #自定義欄位(文字)010
                 bgdbud011 LIKE bgdb_t.bgdbud011, #自定義欄位(數字)011
                 bgdbud012 LIKE bgdb_t.bgdbud012, #自定義欄位(數字)012
                 bgdbud013 LIKE bgdb_t.bgdbud013, #自定義欄位(數字)013
                 bgdbud014 LIKE bgdb_t.bgdbud014, #自定義欄位(數字)014
                 bgdbud015 LIKE bgdb_t.bgdbud015, #自定義欄位(數字)015
                 bgdbud016 LIKE bgdb_t.bgdbud016, #自定義欄位(數字)016
                 bgdbud017 LIKE bgdb_t.bgdbud017, #自定義欄位(數字)017
                 bgdbud018 LIKE bgdb_t.bgdbud018, #自定義欄位(數字)018
                 bgdbud019 LIKE bgdb_t.bgdbud019, #自定義欄位(數字)019
                 bgdbud020 LIKE bgdb_t.bgdbud020, #自定義欄位(數字)020
                 bgdbud021 LIKE bgdb_t.bgdbud021, #自定義欄位(日期時間)021
                 bgdbud022 LIKE bgdb_t.bgdbud022, #自定義欄位(日期時間)022
                 bgdbud023 LIKE bgdb_t.bgdbud023, #自定義欄位(日期時間)023
                 bgdbud024 LIKE bgdb_t.bgdbud024, #自定義欄位(日期時間)024
                 bgdbud025 LIKE bgdb_t.bgdbud025, #自定義欄位(日期時間)025
                 bgdbud026 LIKE bgdb_t.bgdbud026, #自定義欄位(日期時間)026
                 bgdbud027 LIKE bgdb_t.bgdbud027, #自定義欄位(日期時間)027
                 bgdbud028 LIKE bgdb_t.bgdbud028, #自定義欄位(日期時間)028
                 bgdbud029 LIKE bgdb_t.bgdbud029, #自定義欄位(日期時間)029
                 bgdbud030 LIKE bgdb_t.bgdbud030  #自定義欄位(日期時間)030
                 END RECORD
   
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   LET l_success = TRUE
   LET l_delete = 'N'  
   LET l_invalid = 'N'   
   LET r_flag = 'N'
   LET l_wc = " 1=1 "
   
   IF cl_null(g_wc) THEN 
      LET g_wc = " 1=1 "
   END IF
   
   LET l_wc = g_wc
   IF NOT cl_null(p_bgcj009) THEN 
      LET l_wc = g_wc," AND bgas001 = '",p_bgcj009,"'"
   END IF
   
   LET l_today  = cl_get_current()
   
   #抓取abgi165的资料
   LET l_sql = "SELECT bgas001,bgas002 FROM bgas_t ",
               " WHERE bgasent = ",g_enterprise,
               "   AND bgasstus = 'Y' ",
               "   AND ",l_wc
   PREPARE abgi410_01_ins_2_pre FROM l_sql
   DECLARE abgi410_01_ins_2_cs CURSOR FOR abgi410_01_ins_2_pre
   
   LET l_sql = "SELECT bmaasite,bmaa001,bmaa002 ",
               "  FROM bmaa_t ",
               " WHERE bmaaent = ",g_enterprise,
               "   AND bmaasite = ? ",
               "   AND bmaa001 = ? ",
               "   AND bmaastus = 'Y'  "
   PREPARE bmaa_pre1 FROM l_sql
   DECLARE bmaa_cur1 SCROLL CURSOR WITH HOLD FOR bmaa_pre1
   
   LET l_sql = "SELECT DISTINCT bmaa001 FROM bmaa_t ,bmba_t ",
               " WHERE bmaaent = bmbaent ",
               "   AND bmaasite = bmbasite ",
               "   AND bmaa001 = bmba001 ",
               "   AND bmaa002 = bmba002 ",
               "   AND bmaastus = 'Y' ",
               " START WITH bmaa001 = ? ",
               "        AND bmaasite = ? ",
               "        AND bmaa002 = ? ",
               "CONNECT BY PRIOR bmba003 = bmaa001 ",
               "        AND bmaasite = ? ",
               "        AND bmaa002 = ? ",
               "  ORDER BY bmaa001"
   PREPARE abgi410_01_ins_2_pre1 FROM l_sql
   DECLARE abgi410_01_ins_2_cs1 CURSOR FOR abgi410_01_ins_2_pre1
   
   #通过单头主件料件抓取abmm200单身元件料件
   LET l_sql = "SELECT bmba003,bmba004,bmba005,bmba007,bmba008,",
               "       bmba010,bmba011,bmba012,bmba029 ",
               "  FROM bmba_t ",
               " WHERE bmbaent = ",g_enterprise,
               "   AND bmbasite = ? ",
               "   AND bmba001 = ? ",
               "   AND bmba002 = ? ",
               "   AND bmba005 <= to_date('",l_today,"','YYYY-MM-DD hh24:mi:ss') ",
               "   AND bmba006 IS NULL "
   PREPARE abgi410_01_ins_2_pre2 FROM l_sql
   DECLARE abgi410_01_ins_2_cs2 CURSOR FOR abgi410_01_ins_2_pre2
   
   FOREACH abgi410_01_ins_2_cs INTO l_bgas001,l_bgas002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'abgi410_01_ins_2_cs'
         LET g_errparam.popup = TRUE
         CALL cl_err()
       
         LET r_success = FALSE
      END IF
   
      #到aimm205工单预设页签抓预设BOM特性,若没有值,则abmm200有多笔相同资料时,抓第一笔
      SELECT imae037 INTO l_imae037
        FROM imae_t
       WHERE imaeent = g_enterprise
         AND imaesite = g_bgda_m.bgda001
         AND imae001 = l_bgas002
         
      IF l_imae037 IS NULL THEN 
         OPEN bmaa_cur1 USING g_bgda_m.bgda001,l_bgas002
         FETCH FIRST bmaa_cur1 INTO l_bmaasite,l_bmaa001,l_bmaa002
         CLOSE bmaa_cur1
      ELSE
         SELECT bmaasite,bmaa001,bmaa002
           INTO l_bmaasite,l_bmaa001,l_bmaa002
           FROM bmaa_t
          WHERE bmaaent = g_enterprise
            AND bmaasite = g_bgda_m.bgda001
            AND bmaa001 = l_bgas002
            AND bmaa002 = l_imae037
            AND bmaastus = 'Y' 
      END IF
   
      #抓取abmm200单头的资料
      FOREACH abgi410_01_ins_2_cs1 USING l_bmaa001,l_bmaasite,l_bmaa002,l_bmaasite,l_bmaa002 INTO l_bmaa001                            
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'abgi410_01_ins_2_cs'
            LET g_errparam.popup = TRUE
            CALL cl_err()
          
            LET r_success = FALSE
         END IF      

         #若 bom 單身元件不存在於 abgi165 則自動產生
         LET l_n = 0
         SELECT COUNT(1) INTO l_n
           FROM bgas_t
          WHERE bgasent = g_enterprise
            AND bgas002 = l_bmaa001
        
         IF l_n = 0 THEN         
           CALL abgi410_01_ins_bgas(l_bmaa001) RETURNING l_success
         END IF
         
         #通过abgi165里面的对应料件页签抓预算料件
         CALL abgi410_01_get_bgat001(l_bmaa001) RETURNING l_bgat001

         IF cl_null(l_bgat001) THEN   #若抓不到值,则失败 
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'abg-00239'
            LET g_errparam.extend = l_bmaa001
            LET g_errparam.popup = TRUE
            CALL cl_err()
            
            LET r_success = FALSE
            CONTINUE FOREACH
         END IF
         
         #插入单头
         LET l_n = 0
         
         #同一生效日期存在相同料件,则提问是否删除重产
         SELECT COUNT(1) INTO l_n
           FROM bgda_t
          WHERE bgdaent = g_enterprise
            AND bgda001 = g_bgda_m.bgda001
            AND bgda002 = l_bgat001
            AND bgda003 = g_bgda_m.bgda003
            AND bgda005 IS NULL
         
         IF l_n > 0 THEN 
            LET l_delete = 'Y'
            DELETE FROM bgda_t 
             WHERE bgdaent = g_enterprise
               AND bgda001 = g_bgda_m.bgda001
               AND bgda002 = l_bgat001
               AND bgda003 = g_bgda_m.bgda003 

            DELETE FROM bgdb_t 
             WHERE bgdbent = g_enterprise
               AND bgdb001 = g_bgda_m.bgda001
               AND bgdb002 = l_bgat001
               AND bgdb003 = g_bgda_m.bgda003 
         END IF
         
         #同一生效日期存在相同料件但已经失效,则不可再产生
         SELECT COUNT(1) INTO l_n
           FROM bgda_t
          WHERE bgdaent = g_enterprise
            AND bgda001 = g_bgda_m.bgda001
            AND bgda002 = l_bgat001
            AND bgda003 = g_bgda_m.bgda003
            AND bgda005 IS NOT NULL
            
         IF l_n > 0 THEN 
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'abg-00242'
            LET g_errparam.extend = l_bgat001
            LET g_errparam.popup = TRUE
            CALL cl_err()
            
            LET r_success = FALSE
            CONTINUE FOREACH
         END IF
         
         #不同生效日期存在相同料件,则提问是否上失效日期
         SELECT COUNT(1) INTO l_n
           FROM bgda_t
          WHERE bgdaent = g_enterprise
            AND bgda001 = g_bgda_m.bgda001
            AND bgda002 = l_bgat001
            AND bgda003 <> g_bgda_m.bgda003
            AND bgda005 IS NULL
            
         IF l_n > 0 THEN    
            LET l_invalid = 'Y'    
            CALL s_abgi410_invalid(g_bgda_m.bgda001,l_bgat001) RETURNING l_success
         END IF
         
         LET l_bgda.bgdaent = g_enterprise
         LET l_bgda.bgda001 = g_bgda_m.bgda001
         LET l_bgda.bgda002 = l_bgat001
         LET l_bgda.bgda003 = g_bgda_m.bgda003
         SELECT bgas310 INTO l_bgda.bgda004
           FROM bgas_t
          WHERE bgasent = g_enterprise
            AND bgas001 = l_bgda.bgda002
         LET l_bgda.bgda005 = ''
            
         LET l_bgda.bgdaownid = g_user
         LET l_bgda.bgdaowndp = g_dept
         LET l_bgda.bgdacrtid = g_user
         LET l_bgda.bgdacrtdp = g_dept 
         LET l_bgda.bgdacrtdt = cl_get_current()
         LET l_bgda.bgdamodid = g_user
         LET l_bgda.bgdamoddt = cl_get_current()
         LET l_bgda.bgdastus = 'Y'

         INSERT INTO bgda_t(bgdaent,bgda001,bgda002,bgda003,bgda004,
                            bgda005,bgda006,bgda007,bgda008,bgda009,
                            bgdaownid,bgdaowndp,bgdacrtid,bgdacrtdp,bgdacrtdt,
                            bgdamodid,bgdamoddt,bgdacnfid,bgdacnfdt,bgdastus
                            ) 
         VALUES(l_bgda.bgdaent,l_bgda.bgda001,l_bgda.bgda002,l_bgda.bgda003,l_bgda.bgda004,
                l_bgda.bgda005,l_bgda.bgda006,l_bgda.bgda007,l_bgda.bgda008,l_bgda.bgda009,
                l_bgda.bgdaownid,l_bgda.bgdaowndp,l_bgda.bgdacrtid,l_bgda.bgdacrtdp,l_bgda.bgdacrtdt,
                l_bgda.bgdamodid,l_bgda.bgdamoddt,l_bgda.bgdacnfid,l_bgda.bgdacnfdt,l_bgda.bgdastus
               )
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = ''
            LET g_errparam.code   = sqlca.sqlcode
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET r_success = FALSE
         END IF 
         
         #插入单身
         FOREACH abgi410_01_ins_2_cs2 USING l_bmaasite,l_bmaa001,l_bmaa002 
                                       INTO l_bmba003,l_bmba004,l_bmba005,l_bmba007,l_bmba008,
                                            l_bmba010,l_bmba011,l_bmba012,l_bmba029
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'abgi410_01_ins_2_cs'
               LET g_errparam.popup = TRUE
               CALL cl_err()
             
               LET r_success = FALSE
            END IF
            
            #若 bom 單身元件不存在於 abgi165 則自動產生
            LET l_n = 0
            SELECT COUNT(1) INTO l_n
              FROM bgas_t
             WHERE bgasent = g_enterprise
               AND bgas002 = l_bmba003
            
            IF l_n = 0 THEN         
              CALL abgi410_01_ins_bgas(l_bmba003) RETURNING l_success
            END IF
            
            #通过abgi165里面的对应料件页签抓预算料件
            CALL abgi410_01_get_bgat001(l_bmba003) RETURNING l_bgat001
            
            IF cl_null(l_bgat001) THEN   #若抓不到值,则失败 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'abg-00239'
               LET g_errparam.extend = l_bmba003
               LET g_errparam.popup = TRUE
               CALL cl_err()
               
               LET r_success = FALSE
               CONTINUE FOREACH
            END IF
            
            SELECT MAX(bgdbseq)+1 INTO l_bgdb.bgdbseq
              FROM bgdb_t
             WHERE bgdbent = g_enterprise
               AND bgdb001 = l_bgda.bgda001
               AND bgdb002 = l_bgda.bgda002
               AND bgdb003 = l_bgda.bgda003
               
            IF cl_null(l_bgdb.bgdbseq) THEN 
               LET l_bgdb.bgdbseq = 1
            END IF 

            LET l_bgdb.bgdbent = g_enterprise
            LET l_bgdb.bgdb001 = l_bgda.bgda001
            LET l_bgdb.bgdb002 = l_bgda.bgda002
            LET l_bgdb.bgdb003 = l_bgda.bgda003
            LET l_bgdb.bgdb004 = l_bgat001
            LET l_bgdb.bgdb005 = l_bmba011
            LET l_bgdb.bgdb006 = l_bmba012
            LET l_bgdb.bgdb007 = l_bmba010
            LET l_bgdb.bgdb009 = ''
            
            IF l_bmba029 = '2' THEN 
               SELECT MAX(bmbb011) INTO l_bgdb.bgdb008
                 FROM bmbb_t
                WHERE bmbbent = g_enterprise
                  AND bmbbsite = l_bgda.bgda001
                  AND bmbb001 = l_bmaa001
                  AND bmbb002 = l_bmaa002
                  AND bmbb003 = l_bmba003
                  AND bmbb004 = l_bmba004
                  AND bmbb005 = l_bmba005
                  AND bmbb007 = l_bmba007
                  AND bmbb008 = l_bmba008
            ELSE
               LET l_bgdb.bgdb008 = 0
            END IF

            INSERT INTO bgdb_t(bgdbent,bgdb001,bgdb002,bgdb003,bgdbseq,bgdb004,
                               bgdb005,bgdb006,bgdb007,bgdb008,bgdb009)
            VALUES(l_bgdb.bgdbent,l_bgdb.bgdb001,l_bgdb.bgdb002,l_bgdb.bgdb003,l_bgdb.bgdbseq,l_bgdb.bgdb004,
                   l_bgdb.bgdb005,l_bgdb.bgdb006,l_bgdb.bgdb007,l_bgdb.bgdb008,l_bgdb.bgdb009)
            
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ''
               LET g_errparam.code   = sqlca.sqlcode
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET r_success = FALSE
            END IF
            
            LET r_flag = 'Y'
         END FOREACH
      END FOREACH   
   END FOREACH
   
   IF l_delete = 'Y' OR l_invalid = 'Y' THEN 
      IF cl_ask_confirm('abg-00241') THEN 
         LET r_success = TRUE
      ELSE
         LET r_success = FALSE
      END IF
   END IF
   
   RETURN r_success,r_flag
END FUNCTION
# #通过abgi165里面的对应料件页签抓预算料件
PRIVATE FUNCTION abgi410_01_get_bgat001(p_bmaa001)
   DEFINE p_bmaa001          LIKE bmaa_t.bmaa001
   DEFINE r_bgat001          LIKE bgat_t.bgat001
   
   LET r_bgat001 = ''
   
   SELECT bgat001 INTO r_bgat001
     FROM bgat_t
    WHERE bgatent = g_enterprise
      AND bgat002 = p_bmaa001
      
   RETURN r_bgat001
END FUNCTION
# 若abgi165没有资料,则自动塞一笔资料进去
PRIVATE FUNCTION abgi410_01_ins_bgas(p_bmaa001)
   DEFINE p_bmaa001     LIKE bmaa_t.bmaa001
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
   DEFINE l_wc          STRING
   DEFINE r_success     LIKE type_t.num5

   LET r_success = TRUE
   WHENEVER ERROR CONTINUE
   
   LET l_wc = " imaa001 = '",p_bmaa001,"'"
   
   LET ld_date = cl_get_current()  
   LET l_cntdo = 0

   LET l_ooef016 = ''
   LET l_ooef017 = ''
   SELECT ooef016,ooef017 INTO l_ooef016,l_ooef017
     FROM ooef_t
    WHERE ooefent = g_enterprise AND ooef001 = g_bgda_m.bgda001

   #檢查若已有資料存在,是否重新產生_是:刪除後產生 / 否:取消執行
   LET l_cnt = 0
   LET l_sql = " SELECT COUNT(1) ",
               "   FROM bgas_t  ",
               "  WHERE bgasent = ",g_enterprise,
               "    AND bgas003 = '",g_bgda_m.bgda001,"' ",
               "    AND bgas001 IN (SELECT DISTINCT imaf001 FROM imaf_t,imaa_t   ",
               "                     WHERE imafent = ",g_enterprise," AND imafsite = '",g_bgda_m.bgda001,"' ",
               "                       AND ",l_wc," AND imafent = imaaent AND imaf001 = imaa001 ) "
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
   LET l_sql1 = " INSERT INTO bgasl_t ",
                " SELECT imaalent,imaal001,imaal002,imaal003,imaal004,imaal005 ",
                "   FROM imaal_t ",
                "  WHERE imaalent ='",g_enterprise,"'",
                "    AND imaal001 = ? "  #參考料件
   DECLARE abgi165_01_imaal_c CURSOR FROM l_sql1
 
   #撈出據點級料件資訊
   INITIALIZE l_imaf.* TO NULL
   LET l_sql = " SELECT DISTINCT imaa001,imaa003,imaa004,imaa005,imaa006, ",
               "                 imaf111,imaf112,imaf017,imaf141,imaf143, ",
               "                 imaf153,imaf146,imaf164,imaf053,imaf026 ",
               "   FROM imaf_t,imaa_t ",
               "  WHERE imafent = ",g_enterprise,
               "    AND imafsite = '",g_bgda_m.bgda001,"' ",
               "    AND imafent = imaaent AND imaf001 = imaa001 ",
               "    AND ",l_wc,               
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
      LET l_bgas.bgasent	= g_enterprise
      LET l_bgas.bgas001	= l_imaf.imaa001
      LET l_bgas.bgas002	= l_imaf.imaa001
      LET l_bgas.bgas003	= g_bgda_m.bgda001
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
      SELECT xcbb006,xcbb007 INTO l_bgas.bgas411,l_bgas.bgas412
        FROM xcbb_t
       WHERE xcbbent = g_enterprise 
         AND xcbbcomp = l_ooef017
         AND xcbb001 = (SELECT MAX(xcbb001) FROM xcbb_t 
                         WHERE xcbbent = g_enterprise AND xcbb003 = l_bgas.bgas001 AND xcbbcomp = l_ooef017)
         AND xcbb002 = (SELECT MAX(xcbb002) FROM xcbb_t 
                         WHERE xcbbent = g_enterprise AND xcbb003 = l_bgas.bgas001 AND xcbbcomp = l_ooef017 
                           AND xcbb001 = (SELECT MAX(xcbb001) FROM xcbb_t 
                                           WHERE xcbbent = g_enterprise AND xcbb003 = l_bgas.bgas001 
                                             AND xcbbcomp = l_ooef017))
         AND xcbb003 = l_bgas.bgas001 AND rownum = '1'
      
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
                          bgas005,bgas006,bgas008,bgas110,bgas111,	 
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
      
      INSERT INTO bgat_t(bgatent,bgat001,bgat002) VALUES(g_enterprise,l_bgas.bgas001,l_bgas.bgas002)
      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = "ins_bgat_wrong"
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
 
