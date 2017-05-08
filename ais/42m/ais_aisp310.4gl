#該程式未解開Section, 採用最新樣板產出!
{<section id="aisp310.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2015-09-01 11:28:20), PR版次:0004(2016-09-26 15:31:39)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000335
#+ Filename...: aisp310
#+ Description: (取消)出貨單轉對帳單作業
#+ Creator....: 02114(2015-08-18 15:47:27)
#+ Modifier...: 02114 -SD/PR- 01727
 
{</section>}
 
{<section id="aisp310.global" >}
#應用 p02 樣板自動產生(Version:17)
#add-point:填寫註解說明
#160318-00025#36  2016/04/15 BY pengxin  將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160802-00007#1   2016/09/26 By 01727    一次性交易對象識別碼(pmaa004=2)功能應用
#end add-point
 
IMPORT os
IMPORT util
#add-point:增加匯入項目

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc" 
#add-point:增加匯入變數檔
#
##end add-point
 
#模組變數(Module Variables)
DEFINE g_wc                 STRING
DEFINE g_wc_t               STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                STRING
DEFINE g_wc_filter          STRING
DEFINE g_wc_filter_t        STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                        #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10    
DEFINE l_ac                 LIKE type_t.num10              
DEFINE l_ac_d               LIKE type_t.num10             #單身idx 
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_current_page       LIKE type_t.num10             #目前所在頁數
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_master_idx         LIKE type_t.num10
 
TYPE type_parameter RECORD
   #add-point:自定背景執行須傳遞的參數(Module Variable)
        glaacomp         LIKE glaa_t.glaacomp,
        glaacomp_desc    LIKE type_t.chr80,
        isaf056          LIKE isaf_t.isaf056,
        isac002          LIKE isac_t.isac002,
        isac002_desc     LIKE type_t.chr80, 
        xmdk016          LIKE xmdk_t.xmdk016, 
        xmdk017          LIKE xmdk_t.xmdk017,
        isah_type        LIKE type_t.chr1,
        confirm          LIKE type_t.chr1,     
        type             LIKE type_t.chr1,  
   #end add-point
        wc               STRING
                     END RECORD
 
TYPE type_g_detail_d RECORD
#add-point:自定義模組變數(Module Variable)  #注意要在add-point內寫入END RECORD
     sel           LIKE type_t.chr1,
     xmdk007       LIKE type_t.chr80,
     xmdk000       LIKE xmdk_t.xmdk000,
     xmdk016       LIKE xmdk_t.xmdk016,
     xmdldocno     LIKE xmdl_t.xmdldocno,
     xmdlseq       LIKE xmdl_t.xmdlseq,
     xmdl008       LIKE xmdl_t.xmdl008,
     xmdl008_desc  LIKE type_t.chr80,
     xmdl022       LIKE xmdl_t.xmdl022,
     xmdl024       LIKE xmdl_t.xmdl024,
     xmdl028       LIKE xmdl_t.xmdl028,
     qty           LIKE isag_t.isag004,
     xmdl025       LIKE xmdl_t.xmdl025,
     xmdl026       LIKE xmdl_t.xmdl026,
     isag103       LIKE isag_t.isag103,
     isag104       LIKE isag_t.isag104,
     isag105       LIKE isag_t.isag105,
     xmdk202       LIKE xmdk_t.xmdk202,
     xmdk001       LIKE xmdk_t.xmdk001
     END RECORD
     
TYPE type_g_isae_m RECORD
       isafdocno           LIKE isaf_t.isafdocno,
       isafdocdt           LIKE isaf_t.isafdocdt,
       isaf014             LIKE isaf_t.isaf014,
       isaesite            LIKE isae_t.isaesite,
       isaesite_desc       LIKE type_t.chr80,
       isae001             LIKE isae_t.isae001,
       isae014             LIKE isae_t.isae014,
       isae008             LIKE isae_t.isae008,
       isae020             LIKE isae_t.isae020,
       isae012             LIKE isae_t.isae012
       END RECORD
       
DEFINE g_isae_m        type_g_isae_m
DEFINE g_isae_m_t      type_g_isae_m                #備份舊值
    
DEFINE g_input        type_parameter
DEFINE g_rec_b        LIKE type_t.num5 
DEFINE g_ooef019      LIKE ooef_t.ooef019
DEFINE g_glaald       LIKE glaa_t.glaald
DEFINE g_glaa001      LIKE glaa_t.glaa001
DEFINE g_glaa025      LIKE glaa_t.glaa025
DEFINE g_glaa_t       RECORD LIKE glaa_t.*
DEFINE g_glaacomp     LIKE glaa_t.glaacomp
DEFINE g_isai002      LIKE isai_t.isai002
DEFINE g_isai006      LIKE isai_t.isai006
DEFINE g_isae005      LIKE isae_t.isae005
DEFINE g_isae012      LIKE isae_t.isae012
DEFINE g_detail_d_t   type_g_detail_d
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable)

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明

#end add-point
 
{</section>}
 
{<section id="aisp310.main" >}
#+ 作業開始 
MAIN
   DEFINE ls_js  STRING
   #add-point:main段define
   
   #end add-point   
   #add-point:main段define
   
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ais","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js
   
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aisp310 WITH FORM cl_ap_formpath("ais",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aisp310_init()   
 
      #進入選單 Menu (="N")
      CALL aisp310_ui_dialog() 
 
      #add-point:畫面關閉前
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aisp310
   END IF 
   
   #add-point:作業離開前
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aisp310.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aisp310_init()
   #add-point:init段define
   
   #end add-point   
   #add-point:init段define
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化
   CALL cl_set_combo_scc('isaf056','9960')
   CALL cl_set_combo_scc('isah_type','9731')
   CALL cl_set_combo_scc('b_xmdk000','2077')
   CALL cl_set_combo_scc_part('xmdk000','2077','1,2,3,4,5,6')
   CALL cl_set_combo_scc_part('xmdk002','2063','1,2,3,4,5')
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aisp310.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aisp310_ui_dialog()
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_errno         LIKE gzze_t.gzze001 
   DEFINE l_ooef003       LIKE ooef_t.ooef003
   DEFINE l_n             LIKE type_t.num5
   DEFINE l_isag004       LIKE isag_t.isag004
   DEFINE l_isag004_1     LIKE isag_t.isag004
   DEFINE l_isag004_2     LIKE isag_t.isag004
   DEFINE l_oodb005       LIKE oodb_t.oodb005
   DEFINE l_isag113       LIKE isag_t.isag113
   DEFINE l_isag114       LIKE isag_t.isag114
   DEFINE l_isag115       LIKE isag_t.isag115
   #end add-point 
   #add-point:ui_dialog段define
   
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog 
   CALL aisp310_qbe_clear()
   LET g_errshow = 1
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aisp310_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct
         
         #end add-point
         #add-point:ui_dialog段input
         INPUT BY NAME g_input.glaacomp,g_input.glaacomp_desc,g_input.isaf056,g_input.isac002,g_input.isac002_desc,
                       g_input.xmdk016,g_input.xmdk017,g_input.isah_type,g_input.type
               ATTRIBUTE(WITHOUT DEFAULTS)
               
            BEFORE INPUT
               #150127-00007#1 mark---
               #為了掃把清空時給預設所以移至 aisp320_qbe_clear()裡面
               #LET g_input.confirm = 'N'
               #LET g_input.type = '1'
               #LET g_input.isah_type = '1'
               #CALL s_fin_ld_carry('',g_user) RETURNING l_success,g_glaald,g_glaacomp,l_errno
               #SELECT ooef016,ooef019 INTO g_input.xmdk016,g_ooef019
               #  FROM ooef_t
               # WHERE ooefent = g_enterprise
               #   AND ooef001 = g_glaacomp
               #LET g_input.glaacomp = g_glaacomp
               #LET g_input.xmdk017 = 1
               #CALL aisp320_glaacomp_desc()
               #150127-00007#1 mark end---

             AFTER FIELD glaacomp
                CALL aisp310_glaacomp_desc()
                IF NOT cl_null(g_input.glaacomp) THEN  
                   #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                   INITIALIZE g_chkparam.* TO NULL      
                   
                   #設定g_chkparam.*的參數
                   LET g_chkparam.arg1 = g_input.glaacomp
                   #160318-00025#35  2016/04/15  by pengxin  add(S)
                   LET g_errshow = TRUE #是否開窗 
                   LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                   #160318-00025#35  2016/04/15  by pengxin  add(E)
                   #呼叫檢查存在並帶值的library
                   IF cl_chk_exist("v_ooef001") THEN
                      SELECT glaald INTO g_glaald
                        FROM glaa_t
                       WHERE glaaent = g_enterprise
                         AND glaacomp = g_input.glaacomp
                         AND glaa014 = 'Y'
                   
                      SELECT * INTO g_glaa_t.*
                        FROM glaa_t
                       WHERE glaaent = g_enterprise
                         AND glaald = g_glaald
                   
                      #檢查成功時後續處理
                      SELECT ooef003,ooef016,ooef019 INTO l_ooef003,g_input.xmdk016,g_ooef019
                        FROM ooef_t
                       WHERE ooefent = g_enterprise
                         AND ooef001 = g_input.glaacomp
                         
                      IF l_ooef003 = 'N' THEN 
                         INITIALIZE g_errparam TO NULL 
                         LET g_errparam.extend = "" 
                         LET g_errparam.code   = "axc-00203" 
                         LET g_errparam.popup  = TRUE 
                         CALL cl_err()
                         
                         LET g_input.glaacomp = ''
                         CALL aisp310_glaacomp_desc()
                         NEXT FIELD CURRENT
                      END IF

                   ELSE
                      #檢查失敗時後續處理
                      LET g_input.glaacomp = ''
                      CALL aisp310_glaacomp_desc()
                      NEXT FIELD CURRENT
                   END IF
                END IF 
                
                
             AFTER FIELD isac002
                CALL aisp310_isac002_desc()
                IF NOT cl_null(g_input.isac002) THEN  
                   #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                   INITIALIZE g_chkparam.* TO NULL      
                   
                   #設定g_chkparam.*的參數
                   LET g_chkparam.arg1 = g_ooef019
                   LET g_chkparam.arg2 = g_input.isac002
                
                   #呼叫檢查存在並帶值的library
                   IF cl_chk_exist("v_isac002_2") THEN
                      #檢查成功時後續處理

                   ELSE
                      #檢查失敗時後續處理
                      LET g_input.isac002 = ''
                      CALL aisp310_isac002_desc()
                      NEXT FIELD CURRENT
                   END IF
                
                END IF 
                
             AFTER FIELD xmdk016   
                IF NOT cl_null(g_input.xmdk016) THEN 
#應用 a19 樣板自動產生(Version:2)
                  #校驗代值
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_input.xmdk016
                  #160318-00025#35  2016/05/15  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "aoo-00011:sub-01302|aooi140|",cl_get_progname("aooi140",g_lang,"2"),"|:EXEPROGaooi140"
                  #160318-00025#35  2016/05/15  by pengxin  add(E)
                     
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooai001") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
                                             #匯率參照表;帳套; 日期;      來源幣別
                     CALL s_aooi160_get_exrate('2',g_glaald,g_today,g_input.xmdk016,
                                              #目的幣別;      交易金額;   匯類類型
                                               g_glaa_t.glaa001,0,g_glaa_t.glaa025)
                     RETURNING g_input.xmdk017
                  ELSE
                     #檢查失敗時後續處理
                     LET g_input.xmdk016 = ''
                     LET g_input.xmdk017 = 1
                     NEXT FIELD CURRENT
                  END IF
               END IF    
                
             ON ACTION controlp INFIELD glaacomp
              #add-point:ON ACTION controlp INFIELD glaacomp
#此段落由子樣板a07產生            
              #開窗i段
			     INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'i'
			     LET g_qryparam.reqry = FALSE
            
              LET g_qryparam.default1 = g_input.glaacomp             #給予default值
              LET g_qryparam.where = " ooef003 = 'Y'"
              #給予arg
            
              CALL q_ooef001()                                #呼叫開窗
            
              LET g_input.glaacomp = g_qryparam.return1              #將開窗取得的值回傳到變數
            
              DISPLAY g_input.glaacomp TO glaacomp              #顯示到畫面上
              CALL aisp310_glaacomp_desc()
              NEXT FIELD glaacomp    

             ON ACTION controlp INFIELD isac002
               #add-point:ON ACTION controlp INFIELD isaf008
#此段落由子樣板a07產生            
               #開窗i段
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
		    	   LET g_qryparam.reqry = FALSE
               
               LET g_qryparam.default1 = g_input.isac002             #給予default值
               LET g_qryparam.where = "     isac001 = '",g_ooef019,"'"
               #給予arg
               
               CALL q_isac002()                                #呼叫開窗
               
               LET g_input.isac002 = g_qryparam.return1              #將開窗取得的值回傳到變數
               
               DISPLAY g_input.isac002 TO isac002              #顯示到畫面上
               CALL aisp310_isac002_desc()
               NEXT FIELD isac002                          #返回原欄位  
               
            ON ACTION controlp INFIELD xmdk016
               #add-point:ON ACTION controlp INFIELD isaf008
#此段落由子樣板a07產生            
               #開窗i段
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
		    	   LET g_qryparam.reqry = FALSE
               
               LET g_qryparam.default1 = g_input.xmdk016             #給予default值
               #給予arg
               
               CALL q_aooi001_1()                                #呼叫開窗
               
               LET g_input.xmdk016 = g_qryparam.return1              #將開窗取得的值回傳到變數
               
               DISPLAY g_input.xmdk016 TO xmdk016              #顯示到畫面上
               NEXT FIELD xmdk016                          #返回原欄位     
            
               
         END INPUT
         #查詢QBE
         CONSTRUCT BY NAME g_wc ON xmdksite,xmdk000,xmdk007,xmdkdocno,xmdkdocdt,xmdk003,xmdl003,xmdk002

            BEFORE CONSTRUCT
               CALL cl_qbe_init()
            
            AFTER CONSTRUCT
               #呼叫P次作業
               
               ON ACTION controlp INFIELD xmdksite
                  #add-point:ON ACTION controlp INFIELD xmdksite
                  #應用 a08 樣板自動產生(Version:2)
                  #開窗c段
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'c' 
                  LET g_qryparam.reqry = FALSE
                  CALL q_ooef001()                            #呼叫開窗
                  DISPLAY g_qryparam.return1 TO xmdksite      #顯示到畫面上
                  NEXT FIELD xmdksite                         #返回原欄位
                  
               ON ACTION controlp INFIELD xmdk007
                  #add-point:ON ACTION controlp INFIELD xmdk007
                  #此段落由子樣板a08產生
                  #開窗c段
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'c'
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.arg1 = g_site
                  CALL q_pmaa001_6()                           #呼叫開窗
                  DISPLAY g_qryparam.return1 TO xmdk007        #顯示到畫面上
                  NEXT FIELD xmdk007                           #返回原欄位
                  
               ON ACTION controlp INFIELD xmdkdocno
                  #add-point:ON ACTION controlp INFIELD xmdkdocno
                  #此段落由子樣板a08產生
                  #開窗c段
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'c'
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.where =" (SELECT ooef017 FROM ooef_t ",
                                        "   WHERE ooefent = ",g_enterprise,
                                        "     AND ooef001 = xmdksite ",
                                        " ) = '",g_input.glaacomp,"'"
                  CALL q_xmdkdocno()                           #呼叫開窗
                  DISPLAY g_qryparam.return1 TO xmdkdocno      #顯示到畫面上
                  NEXT FIELD xmdkdocno                         #返回原欄位
                  
               ON ACTION controlp INFIELD xmdk003
                  #add-point:ON ACTION controlp INFIELD xmdk003
                  
                  #此段落由子樣板a08產生
                  #開窗c段
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'c'
                  LET g_qryparam.reqry = FALSE
                  CALL q_ooag001()                           #呼叫開窗
                  DISPLAY g_qryparam.return1 TO xmdk003      #顯示到畫面上
                  NEXT FIELD xmdk003                         #返回原欄位
                  
               ON ACTION controlp INFIELD xmdl003
                  #add-point:ON ACTION controlp INFIELD xmdl003
                  
                  #此段落由子樣板a08產生
                  #開窗c段
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'c'
                  LET g_qryparam.reqry = FALSE
                  CALL q_xmdadocno_2()                           #呼叫開窗
                  DISPLAY g_qryparam.return1 TO xmdl003          #顯示到畫面上
                  NEXT FIELD xmdl003                             #返回原欄位
    
               
         END CONSTRUCT
         
         INPUT ARRAY g_detail_d FROM s_detail1.* 
              ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                        INSERT ROW = FALSE,
                        DELETE ROW = FALSE,
                        APPEND ROW = FALSE)
            BEFORE INPUT
               IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
                 CALL FGL_SET_ARR_CURR(g_detail_d.getLength()+1) 
                 LET g_insert = 'N' 
               END IF 
             
            BEFORE ROW
               LET l_ac = ARR_CURR()
               LET g_master_idx = l_ac
               DISPLAY l_ac TO FORMONLY.h_index
               CALL aisp310_fetch() 
               
               LET g_detail_d_t.* = g_detail_d[l_ac].*
               
               SELECT oodb005 INTO l_oodb005
                 FROM oodb_t
                WHERE oodbent = g_enterprise
                  AND oodb001 = g_ooef019
                  AND oodb002 = g_detail_d[l_ac].xmdl025
                  
               IF l_oodb005 = 'Y' THEN 
                  CALL cl_set_comp_entry("b_isag105",TRUE)
                  CALL cl_set_comp_entry("b_isag103",FALSE)
               ELSE
                  CALL cl_set_comp_entry("b_isag103",TRUE)
                  CALL cl_set_comp_entry("b_isag105",FALSE)
               END IF
 
            ON CHANGE sel
                IF g_detail_d[l_ac].sel = "Y" THEN  
                   UPDATE aisp310_tmp SET sel = 'Y' 
                    WHERE xmdldocno = g_detail_d[l_ac].xmdldocno 
                      AND xmdlseq = g_detail_d[l_ac].xmdlseq
                ELSE
                   UPDATE aisp310_tmp SET sel = 'N' 
                    WHERE xmdldocno = g_detail_d[l_ac].xmdldocno 
                      AND xmdlseq = g_detail_d[l_ac].xmdlseq
                END IF 
                
            AFTER FIELD qty
               IF NOT cl_null(g_detail_d[l_ac].qty) THEN 
                  CALL aisp310_get_isag004(g_detail_d[l_ac].xmdldocno,g_detail_d[l_ac].xmdlseq) 
                  RETURNING l_isag004_1,l_isag004_2
               
                  LET l_isag004 = g_detail_d[l_ac].xmdl022 - g_detail_d[l_ac].qty - l_isag004_1 - l_isag004_2
      
                  IF l_isag004 < 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "ais-00133" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD qty
                  END IF
                  
                  IF g_detail_d[l_ac].qty <> g_detail_d_t.qty THEN 
                     CALL s_tax_count(g_input.glaacomp,g_detail_d[l_ac].xmdl025,g_detail_d[l_ac].xmdl024 * g_detail_d[l_ac].qty,
                                      g_detail_d[l_ac].qty,g_input.xmdk016,g_input.xmdk017)
                     RETURNING g_detail_d[l_ac].isag103,g_detail_d[l_ac].isag104,g_detail_d[l_ac].isag105,
                               l_isag113,l_isag114,l_isag115
                  END IF
                  
                  UPDATE aisp310_tmp SET     qty = g_detail_d[l_ac].qty,
                                         isag103 = g_detail_d[l_ac].isag103,
                                         isag104 = g_detail_d[l_ac].isag104,
                                         isag105 = g_detail_d[l_ac].isag105
                                   WHERE xmdldocno = g_detail_d[l_ac].xmdldocno
                                     AND xmdlseq = g_detail_d[l_ac].xmdlseq
                                     
                  LET g_detail_d_t.qty = g_detail_d[l_ac].qty
               END IF

            AFTER FIELD b_isag103
               IF NOT cl_null(g_detail_d[l_ac].isag103) AND g_detail_d[l_ac].isag103 <> g_detail_d_t.isag103 THEN 
                  LET g_detail_d[l_ac].xmdl024 = g_detail_d[l_ac].isag103 / g_detail_d[l_ac].qty
                  LET g_detail_d[l_ac].xmdl024 = s_curr_round(g_input.glaacomp,g_input.xmdk016,g_detail_d[l_ac].xmdl024,2)
                  
                  CALL s_tax_count(g_input.glaacomp,g_detail_d[l_ac].xmdl025,g_detail_d[l_ac].xmdl024 * g_detail_d[l_ac].qty,
                                   g_detail_d[l_ac].qty,g_input.xmdk016,g_input.xmdk017)
                  RETURNING g_detail_d[l_ac].isag103,g_detail_d[l_ac].isag104,g_detail_d[l_ac].isag105,
                            l_isag113,l_isag114,l_isag115
                            
                  UPDATE aisp310_tmp SET xmdl024 = g_detail_d[l_ac].xmdl024,
                                         isag103 = g_detail_d[l_ac].isag103,
                                         isag104 = g_detail_d[l_ac].isag104,
                                         isag105 = g_detail_d[l_ac].isag105
                                   WHERE xmdldocno = g_detail_d[l_ac].xmdldocno
                                     AND xmdlseq = g_detail_d[l_ac].xmdlseq
                                     
                  LET g_detail_d_t.isag103 = g_detail_d[l_ac].isag103
               END IF
               
            AFTER FIELD b_isag105
               IF NOT cl_null(g_detail_d[l_ac].isag105) AND g_detail_d[l_ac].isag105 <> g_detail_d_t.isag105 THEN 
                  LET g_detail_d[l_ac].xmdl024 = g_detail_d[l_ac].isag105 / g_detail_d[l_ac].qty
                  LET g_detail_d[l_ac].xmdl024 = s_curr_round(g_input.glaacomp,g_input.xmdk016,g_detail_d[l_ac].xmdl024,2)
                  
                  CALL s_tax_count(g_input.glaacomp,g_detail_d[l_ac].xmdl025,g_detail_d[l_ac].xmdl024 * g_detail_d[l_ac].qty,
                                   g_detail_d[l_ac].qty,g_input.xmdk016,g_input.xmdk017)
                  RETURNING g_detail_d[l_ac].isag103,g_detail_d[l_ac].isag104,g_detail_d[l_ac].isag105,
                            l_isag113,l_isag114,l_isag115
                            
                  UPDATE aisp310_tmp SET xmdl024 = g_detail_d[l_ac].xmdl024,
                                         isag103 = g_detail_d[l_ac].isag103,
                                         isag104 = g_detail_d[l_ac].isag104,
                                         isag105 = g_detail_d[l_ac].isag105
                                   WHERE xmdldocno = g_detail_d[l_ac].xmdldocno
                                     AND xmdlseq = g_detail_d[l_ac].xmdlseq
                   DISPLAY g_detail_d[l_ac].xmdl024 TO s_detail1[l_ac].b_xmdl024
                   LET g_detail_d_t.isag105 = g_detail_d[l_ac].isag105
               END IF
         END INPUT
         #end add-point
         #add-point:ui_dialog段自定義display array
         
         #end add-point
 
         BEFORE DIALOG
            IF g_detail_d.getLength() > 0 THEN
               CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
            ELSE
               CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
            END IF
            #add-point:ui_dialog段before_dialog2
            CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
            #end add-point
 
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            #add-point:ui_dialog段on action selall
            
            #end add-point            
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
               #add-point:ui_dialog段on action selall
               UPDATE aisp310_tmp 
                  SET sel = g_detail_d[li_idx].sel
                WHERE xmdldocno = g_detail_d[li_idx].xmdldocno 
                  AND xmdlseq = g_detail_d[li_idx].xmdlseq
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selall
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "N"
               #add-point:ui_dialog段on action selnone
               UPDATE aisp310_tmp 
                  SET sel = g_detail_d[li_idx].sel
                WHERE xmdldocno = g_detail_d[li_idx].xmdldocno 
                  AND xmdlseq = g_detail_d[li_idx].xmdlseq
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selnone
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "Y"
               END IF
            END FOR
            #add-point:ui_dialog段on action sel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "Y"
                  UPDATE aisp310_tmp 
                     SET sel = g_detail_d[li_idx].sel
                   WHERE xmdldocno = g_detail_d[li_idx].xmdldocno 
                     AND xmdlseq = g_detail_d[li_idx].xmdlseq
               END IF
            END FOR
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
            END FOR
            #add-point:ui_dialog段on action unsel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "N"
                  UPDATE aisp310_tmp 
                     SET sel = g_detail_d[li_idx].sel
                   WHERE xmdldocno = g_detail_d[li_idx].xmdldocno 
                     AND xmdlseq = g_detail_d[li_idx].xmdlseq
               END IF
            END FOR
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL aisp310_filter()
            #add-point:ON ACTION filter
            
            #END add-point
            EXIT DIALOG
      
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice = "exit"
            EXIT DIALOG
      
         ON ACTION exit
            LET g_action_choice="exit"
            EXIT DIALOG
 
         ON ACTION accept
            #add-point:ui_dialog段accept之前
            
            #end add-point
            CALL aisp310_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段
            CALL aisp310_qbe_clear()
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh
            
            #end add-point
            CALL aisp310_b_fill()
 
         #add-point:ui_dialog段action
         ON ACTION batch_execute     
            SELECT COUNT(*) INTO l_n
              FROM aisp310_tmp
             WHERE sel = 'Y'
            IF l_n = 0 THEN 
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "" 
               LET g_errparam.code   = 'axr-00159' 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               
               EXIT DIALOG
            END IF
            
            #CALL cl_err_collect_init()
            #CALL axrp330_chk() RETURNING l_success
            #
            #IF l_success = FALSE THEN
            #   CALL cl_err_collect_show()  
            #   EXIT DIALOG
            #END IF
            
            CALL aisp310_s01()
            CALL aisp310_b_fill()
         #end add-point
 
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
      
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="aisp310.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aisp310_query()
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define
   
   #end add-point 
   #add-point:query段define
   
   #end add-point 
    
   #add-point:cs段after_construct
   
   #end add-point
        
   LET g_error_show = 1
   CALL aisp310_b_fill()
   LET l_ac = g_master_idx
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = -100 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
   END IF
   
   #add-point:cs段after_query
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aisp310.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aisp310_b_fill()
 
   DEFINE ls_wc           STRING
   #add-point:b_fill段define
   DEFINE l_xmdl047       LIKE xmdl_t.xmdl047
   DEFINE l_xmdl018       LIKE xmdl_t.xmdl018
   DEFINE l_xmdl024       LIKE xmdl_t.xmdl024
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_oodbl004      LIKE oodbL_t.oodbl004
   DEFINE l_oodb005       LIKE oodb_t.oodb005
   DEFINE l_oodb006       LIKE oodb_t.oodb006
   DEFINE l_oodb011       LIKE oodb_t.oodb011
   DEFINE r_xrcd103       LIKE xrcd_t.xrcd103
   DEFINE r_xrcd104       LIKE xrcd_t.xrcd104
   DEFINE r_xrcd105       LIKE xrcd_t.xrcd105
   DEFINE r_xrcd113       LIKE xrcd_t.xrcd113
   DEFINE r_xrcd114       LIKE xrcd_t.xrcd114
   DEFINE r_xrcd115       LIKE xrcd_t.xrcd115
   DEFINE r_xrcd123       LIKE xrcd_t.xrcd123
   DEFINE r_xrcd124       LIKE xrcd_t.xrcd124
   DEFINE r_xrcd125       LIKE xrcd_t.xrcd125
   DEFINE r_xrcd133       LIKE xrcd_t.xrcd133
   DEFINE r_xrcd134       LIKE xrcd_t.xrcd134
   DEFINE r_xrcd135       LIKE xrcd_t.xrcd135
   DEFINE l_xmdk007_desc  LIKE type_t.chr80
   DEFINE l_imaal003      LIKE imaal_t.imaal003
   DEFINE l_imaal004      LIKE imaal_t.imaal004
   DEFINE l_isag004       LIKE isag_t.isag004
   DEFINE l_isag004_1     LIKE isag_t.isag004
   DEFINE l_isag004_2     LIKE isag_t.isag004
   DEFINE l_xmdl003       LIKE xmdl_t.xmdl003
   DEFINE l_xmdl004       LIKE xmdl_t.xmdl004
   DEFINE l_isag113       LIKE isag_t.isag113
   DEFINE l_isag114       LIKE isag_t.isag114
   DEFINE l_isag115       LIKE isag_t.isag115
   #end add-point
   #add-point:b_fill段define
   
   #end add-point
 
   #add-point:b_fill段sql_before
   IF cl_null(g_wc) THEN 
      LET g_wc = " 1=1 "
   END IF 
   
   CALL aisp310_cre_tmp() RETURNING l_success
   DELETE FROM aisp310_tmp
   
   LET g_sql = "SELECT 'N',xmdk007,xmdk000,xmdk016,xmdldocno,xmdlseq,xmdl008,'',xmdl022,xmdl024,xmdl028,0,",
               "           xmdl025,xmdl026,0,0,0,xmdk202,xmdk001,xmdl047 ",
               "  FROM xmdk_t,xmdl_t ",
               " WHERE xmdkent = xmdkent ",
               "   AND xmdkdocno = xmdldocno",
               "   AND xmdkent = ?",
               "   AND xmdk015 = '",g_input.isac002,"'",
               "   AND xmdk016 = '",g_input.xmdk016,"'",
               "   AND (SELECT ooef017 FROM ooef_t ",
               "         WHERE ooefent = ",g_enterprise,
               "           AND ooef001 = xmdksite ",
               "       ) = '",g_input.glaacomp,"'",
               "   AND xmdkstus = 'S' ",
               "   AND (xmdl022-xmdl047) > 0 ",
               "   AND ",g_wc
               
   IF g_input.isaf056 = '2' THEN 
      LET g_sql = g_sql," AND xmdk000 = '6' "
   END IF
   #end add-point
 
   PREPARE aisp310_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aisp310_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空
   
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into
   g_detail_d[l_ac].*,l_xmdl047
   #end add-point
   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #add-point:b_fill段資料填充
      CALL aisp310_get_isag004(g_detail_d[l_ac].xmdldocno,g_detail_d[l_ac].xmdlseq) RETURNING l_isag004_1,l_isag004_2
	   
      LET l_isag004 = g_detail_d[l_ac].xmdl022 - l_isag004_1 - l_isag004_2
      
      IF l_isag004 <= 0 THEN
         CONTINUE FOREACH
      END IF
      
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_detail_d[l_ac].xmdk007
      CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET l_xmdk007_desc = '', g_rtn_fields[1] , ''
      LET g_detail_d[l_ac].xmdk007 = g_detail_d[l_ac].xmdk007,l_xmdk007_desc
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_detail_d[l_ac].xmdl008
      CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET l_imaal003 = '', g_rtn_fields[1] , ''
      LET l_imaal004 = '', g_rtn_fields[1] , ''
      IF NOT cl_null(l_imaal003) AND NOT cl_null(l_imaal004) THEN 
         LET g_detail_d[l_ac].xmdl008_desc = l_imaal003,'/',l_imaal004
      END IF
      IF NOT cl_null(l_imaal003) AND cl_null(l_imaal004) THEN 
         LET g_detail_d[l_ac].xmdl008_desc = l_imaal003
      END IF
      IF cl_null(l_imaal003) AND NOT cl_null(l_imaal004) THEN 
         LET g_detail_d[l_ac].xmdl008_desc = l_imaal004
      END IF
      DISPLAY g_detail_d[l_ac].xmdl008_desc TO s_detail1[l_ac].xmdl008_desc
      
      IF cl_null(l_xmdl047) THEN 
         LET l_xmdl047 = 0
      END IF
      
      LET g_detail_d[l_ac].qty = g_detail_d[l_ac].xmdl022 - l_xmdl047 - l_isag004_1 - l_isag004_2
         
      IF g_detail_d[l_ac].qty = g_detail_d[l_ac].xmdl022 THEN 
         SELECT xmdl027,xmdl029,xmdl028
           INTO g_detail_d[l_ac].isag103,g_detail_d[l_ac].isag104,g_detail_d[l_ac].isag105
           FROM xmdl_t
          WHERE xmdlent = g_enterprise
            AND xmdldocno = g_detail_d[l_ac].xmdldocno
            AND xmdlseq = g_detail_d[l_ac].xmdlseq
      ELSE
         CALL s_tax_count(g_input.glaacomp,g_detail_d[l_ac].xmdl025,g_detail_d[l_ac].xmdl024 * g_detail_d[l_ac].qty,
                          g_detail_d[l_ac].qty,g_input.xmdk016,g_input.xmdk017)
         RETURNING g_detail_d[l_ac].isag103,g_detail_d[l_ac].isag104,g_detail_d[l_ac].isag105,
                   l_isag113,l_isag114,l_isag115     
      END IF
      
      IF cl_null(g_detail_d[l_ac].isag103) THEN 
         LET g_detail_d[l_ac].isag103 = 0
      END IF
      
      IF cl_null(g_detail_d[l_ac].isag104) THEN 
         LET g_detail_d[l_ac].isag104 = 0
      END IF
      
      IF cl_null(g_detail_d[l_ac].isag105) THEN 
         LET g_detail_d[l_ac].isag105 = 0
      END IF
      
      INSERT INTO aisp310_tmp VALUES(g_detail_d[l_ac].*)
      #end add-point
      
      CALL aisp310_detail_show()      
 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend =  "" 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
         END IF
         EXIT FOREACH
      END IF
      
   END FOREACH
   LET g_error_show = 0
   
   #add-point:b_fill段資料填充(其他單身)
   CALL g_detail_d.deleteElement(g_detail_d.getLength())
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aisp310_sel
   
   LET l_ac = 1
   CALL aisp310_fetch()
   #add-point:b_fill段資料填充(其他單身)
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aisp310.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aisp310_fetch()
 
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define
   
   #end add-point
   #add-point:fetch段define
   
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後
   
   #end add-point 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="aisp310.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aisp310_detail_show()
   #add-point:show段define
   
   #end add-point
   #add-point:show段define
   
   #end add-point
   
   #add-point:detail_show段
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aisp310.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aisp310_filter()
   #add-point:filter段define
   
   #end add-point    
   #add-point:filter段define
   
   #end add-point    
   
   DISPLAY ARRAY g_detail_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
      ON UPDATE
 
   END DISPLAY
 
   LET l_ac = 1
   LET g_detail_cnt = 1
   #add-point:filter段define
   
   #end add-point    
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   
   CALL aisp310_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="aisp310.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aisp310_filter_parser(ps_field)
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num10
   DEFINE li_tmp2    LIKE type_t.num10
   DEFINE ls_var     STRING
   #add-point:filter段define
   
   #end add-point    
   #add-point:filter段define
   
   #end add-point    
   
   #一般條件解析
   LET ls_tmp = ps_field, "='"
   LET li_tmp = g_wc_filter.getIndexOf(ls_tmp,1)
   IF li_tmp > 0 THEN
      LET li_tmp = ls_tmp.getLength() + li_tmp
      LET li_tmp2 = g_wc_filter.getIndexOf("'",li_tmp + 1) - 1
      LET ls_var = g_wc_filter.subString(li_tmp,li_tmp2)
   END IF
 
   #模糊條件解析
   LET ls_tmp = ps_field, " like '"
   LET li_tmp = g_wc_filter.getIndexOf(ls_tmp,1)
   IF li_tmp > 0 THEN
      LET li_tmp = ls_tmp.getLength() + li_tmp
      LET li_tmp2 = g_wc_filter.getIndexOf("'",li_tmp + 1) - 1
      LET ls_var = g_wc_filter.subString(li_tmp,li_tmp2)
      LET ls_var = cl_replace_str(ls_var,'%','*')
   END IF
 
   RETURN ls_var
 
END FUNCTION
 
{</section>}
 
{<section id="aisp310.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aisp310_filter_show(ps_field,ps_object)
   DEFINE ps_field         STRING
   DEFINE ps_object        STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
 
   LET ls_name = "formonly.", ps_object
 
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = aisp310_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aisp310.other_function" readonly="Y" >}
#add-point:自定義元件(Function)
# 法人名稱
PRIVATE FUNCTION aisp310_glaacomp_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_input.glaacomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_input.glaacomp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_input.glaacomp_desc
END FUNCTION
# 發票名稱
PRIVATE FUNCTION aisp310_isac002_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_ooef019
   LET g_ref_fields[2] = g_input.isac002
   CALL ap_ref_array2(g_ref_fields,"SELECT isacl004 FROM isacl_t WHERE isaclent='"||g_enterprise||"' AND isacl001=? AND isacl002 = ? AND isacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_input.isac002_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_input.isac002_desc
END FUNCTION
# 清空&給預設
PRIVATE FUNCTION aisp310_qbe_clear()
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_errno       LIKE gzze_t.gzze001
   
   CLEAR FORM
   INITIALIZE g_input.* TO NULL
   CALL g_detail_d.clear()

   LET g_input.isaf056 = '1'
   LET g_input.type = '1'
   LET g_input.isah_type = '1'
   CALL s_fin_ld_carry('',g_user) RETURNING l_success,g_glaald,g_glaacomp,l_errno
   
   SELECT * INTO g_glaa_t.*
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = g_glaald
      
   SELECT ooef016,ooef019 INTO g_input.xmdk016,g_ooef019
   FROM ooef_t
   WHERE ooefent = g_enterprise
   AND ooef001 = g_glaacomp
   LET g_input.glaacomp = g_glaacomp
   LET g_input.xmdk017 = 1
   CALL aisp310_glaacomp_desc()
END FUNCTION
# 创建临时表
PRIVATE FUNCTION aisp310_cre_tmp()
   DEFINE r_success       LIKE type_t.num5
   
   WHENEVER ERROR CONTINUE
   LET r_success = FALSE
   
   DROP TABLE aisp310_tmp;
   CREATE TEMP TABLE aisp310_tmp(
   sel            VARCHAR(1),
   xmdk007        VARCHAR(80),
   xmdk000        VARCHAR(10),
   xmdk016        VARCHAR(10),
   xmdldocno      VARCHAR(20),
   xmdlseq        INTEGER,
   xmdl008        VARCHAR(40),
   xmdl008_desc   VARCHAR(80),
   xmdl022        DECIMAL(20,6),
   xmdl024        DECIMAL(20,6),
   xmdl028        DECIMAL(20,6),
   qty            DECIMAL(20,6),
   xmdl025        VARCHAR(10),
   xmdl026        DECIMAL(5,2),
   isag103        DECIMAL(20,6),
   isag104        DECIMAL(20,6),
   isag105        DECIMAL(20,6),
   xmdk202        VARCHAR(10),
   xmdk001        DATE
   );
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "create" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      
      RETURN r_success
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION
# 發票條件
PRIVATE FUNCTION aisp310_s01()
   DEFINE lwin_curr     ui.Window
   DEFINE lfrm_curr     ui.Form
   DEFINE ls_path       STRING
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_msg         STRING
   DEFINE l_today       LIKE isaf_t.isafdocdt
   DEFINE l_isao014     LIKE isao_t.isao014
   DEFINE l_isao015     LIKE isao_t.isao015
   DEFINE l_n           LIKE type_t.num5
   DEFINE l_isae012     LIKE type_t.num20
   DEFINE l_isaq005     LIKE isaq_t.isaq005
   
   OPEN WINDOW w_aisp310_s01 WITH FORM cl_ap_formpath("ais","aisp310_s01")
   LET lwin_curr = ui.Window.getCurrent()
   LET lfrm_curr = lwin_curr.getForm()
   LET ls_path = os.Path.join(os.Path.join(FGL_GETENV("ERP"),"cfg"),"4tb")
   LET ls_path = os.Path.join(ls_path,"toolbar_lib.4tb")
   CALL lfrm_curr.loadToolBar(ls_path)
   
   SELECT isai002,isai006 INTO g_isai002,g_isai006
     FROM isai_t 
    WHERE isaient = g_enterprise
      AND isai001 = g_ooef019
      
   IF g_isai002 = '1' THEN 
      LET l_msg = cl_getmsg('ais-00112',g_dlang)
      CALL cl_set_comp_att_text('isae008',l_msg)
   END IF
   IF g_isai002 = '2' THEN 
      LET l_msg = cl_getmsg('ais-00113',g_dlang)
      CALL cl_set_comp_att_text('isae008',l_msg)
   END IF
   
   SELECT isaq005 INTO l_isaq005
     FROM isaq_t
    WHERE isaqent = g_enterprise
      AND isaqsite = g_input.glaacomp
      AND isaq001 = g_input.isac002

   IF l_isaq005 = '1' THEN 
      CALL cl_set_comp_visible('lbl_group2',FALSE)  
   ELSE
      CALL cl_set_comp_visible('lbl_group2',TRUE)  
   END IF
   #WHILE TRUE

      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

         INPUT BY NAME g_isae_m.isafdocno, g_isae_m.isafdocdt    , g_isae_m.isaf014,
                       g_isae_m.isaesite , g_isae_m.isaesite_desc, g_isae_m.isae001,
                       g_isae_m.isae014  , g_isae_m.isae008      , g_isae_m.isae020,
                       g_isae_m.isae012                   

            BEFORE INPUT
               SELECT isao014,isao015 INTO l_isao014,l_isao015
                 FROM isao_t
                WHERE isaoent = g_enterprise
                  AND isaosite = g_input.glaacomp
                  
               IF g_input.isaf056 = '1' THEN 
                  LET g_isae_m.isafdocno = l_isao014
               ELSE
                  LET g_isae_m.isafdocno = l_isao015
               END IF
               
               LET g_isae_m.isafdocdt = g_today
               LET g_isae_m.isaf014 = g_today
               LET g_isae_m.isaesite = g_site
               CALL aisp310_isaesite_desc()
               CALL aisp310_isae_get() 
         
            AFTER FIELD isafdocno
               IF NOT cl_null(g_isae_m.isafdocno) THEN
                  CALL s_aooi200_fin_chk_slip(g_glaald,g_glaa_t.glaa024,g_isae_m.isafdocno,'aist310') RETURNING l_success
                  IF l_success = FALSE THEN 
                     LET g_isae_m.isafdocno = ''
                     NEXT FIELD isafdocno
                  END IF
               END IF             

            AFTER FIELD isaesite
               IF NOT cl_null(g_isae_m.isaesite) THEN            
                  CALL aisp310_isaesite_chk()             
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
               
                     LET g_isae_m.isaesite = ''
                     NEXT FIELD CURRENT
                  END IF
               END IF
               CALL aisp310_isaesite_desc()
               CALL aisp310_isae_get()
               
            AFTER FIELD isae001
               IF NOT cl_null(g_isae_m.isae001) THEN    
                 #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                 INITIALIZE g_chkparam.* TO NULL      
                 
                 #設定g_chkparam.*的參數
                 LET g_chkparam.arg1 = g_isae_m.isaesite
                 LET g_chkparam.arg2 = g_isae_m.isae001
              
                 #呼叫檢查存在並帶值的library
                 IF cl_chk_exist("v_isae001") THEN
                    #檢查成功時後續處理
                    CALL aisp310_isae_get()
                 ELSE
                    #檢查失敗時後續處理
                    LET g_isae_m.isae001 = ''
                    NEXT FIELD CURRENT
                 END IF
              
              END IF   

            AFTER FIELD isae012
               IF NOT cl_null(g_isae_m.isae012) THEN 
                  IF g_isae_m.isae012 <> g_isae012 THEN 
                     IF NOT cl_ask_confirm('ais-00238') THEN
                        LET g_isae_m.isae012 = g_isae012
                     END IF
                  END IF
               
                  LET l_isae012 = g_isae_m.isae012
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n FROM isae_t          
                   WHERE isaeent = g_enterprise
                     AND isaesite = g_isae_m.isaesite
                     AND isae001  = g_isae_m.isae001
                     AND isae002 <= g_isae_m.isaf014
                     AND isae003 >= g_isae_m.isaf014
                     AND isae009 <= l_isae012
                     AND isae010 >= l_isae012

                  IF l_n = 0 THEN
                     INITIALIZE g_errparam.* TO NULL
                     LET g_errparam.code = 'ais-00236'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_isae_m.isae012 = g_isae012
                     NEXT FIELD isae012
                  END IF 
               END IF

            ON ACTION controlp INFIELD isafdocno
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
			      LET g_qryparam.reqry = FALSE
			
               LET g_qryparam.default1 = g_isae_m.isafdocno             #給予default值

               LET g_qryparam.arg1 = g_glaa_t.glaa024
               LET g_qryparam.arg2 = "aist310"
               CALL q_ooba002_1() 
			
               LET g_isae_m.isafdocno = g_qryparam.return1              #將開窗取得的值回傳到變數
			
               DISPLAY g_isae_m.isafdocno TO isafdocno              #顯示到畫面上
               NEXT FIELD isafdocno                          #返回原欄位
               
            ON ACTION controlp INFIELD isaesite
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
	    		   LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_isae_m.isaesite             #給予default值
               LET g_qryparam.where = "   isaesite IN ('",g_isae_m.isaesite,"','",g_input.glaacomp,"' ) ",
                                         "   AND isae004  = '",g_input.isac002,"'",
                                         "   AND isae002 <= '",g_isae_m.isaf014,"'",
                                         "   AND isae003 >= '",g_isae_m.isaf014,"'"            
               CALL q_isaesite_3()                                        #呼叫開窗
               LET g_isae_m.isaesite = g_qryparam.return1              #將開窗取得的值回傳到變數
               LET g_isae_m.isae001  = g_qryparam.return2 
               DISPLAY g_isae_m.isaesite TO isaesite                   #顯示到畫面上
               CALL aisp310_isaesite_desc()
               NEXT FIELD isaesite 
               
            ON ACTION controlp INFIELD isae001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
	    		   LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_isae_m.isae001             #給予default值
               LET g_qryparam.where = "   isaesite IN ('",g_isae_m.isaesite,"','",g_input.glaacomp,"' ) ",
                                         "   AND isae004  = '",g_input.isac002,"'",
                                         "   AND isae002 <= '",g_isae_m.isaf014,"'",
                                         "   AND isae003 >= '",g_isae_m.isaf014,"'"            
               CALL q_isaesite_3()                                        #呼叫開窗
               LET g_isae_m.isae001 = g_qryparam.return2              #將開窗取得的值回傳到變數
               DISPLAY g_isae_m.isae001 TO isae001                   #顯示到畫面上
               NEXT FIELD isae001 
           

            AFTER INPUT
               

         END INPUT

         ON ACTION accept
            ACCEPT DIALOG

         ON ACTION cancel      #在dialog button (放棄)
            LET g_action_choice=""
            LET INT_FLAG = TRUE
            EXIT DIALOG

         ON ACTION close
            LET INT_FLAG = TRUE
            EXIT DIALOG

         ON ACTION exit
            LET INT_FLAG = TRUE
            EXIT DIALOG
      END DIALOG

     IF INT_FLAG THEN
        LET INT_FLAG = TRUE 
        #EXIT WHILE
     ELSE
        CALL aisp310_p()
        #CONTINUE WHILE
     END IF
  
  #END WHILE

  #畫面關閉
  CLOSE WINDOW w_aisp310_s01
END FUNCTION
# 營運據點檢查
PRIVATE FUNCTION aisp310_isaesite_chk()
   DEFINE l_count     LIKE type_t.num10  # 錯誤數目  
   DEFINE l_site      LIKE isae_t.isaesite  
   DEFINE l_isae012   LIKE isae_t.isae012   

   LET g_errno = ''
   
   LET l_count = 0
   SELECT count (*) INTO l_count 
     FROM isae_t 
    WHERE isaeent = g_enterprise
      AND isaesite IN (g_isae_m.isaesite,g_input.glaacomp) 
      AND isae004  = g_input.isac002
      AND isae002 <= g_isae_m.isaf014
      AND isae003 >= g_isae_m.isaf014
    
   IF l_count = 0 THEN
      LET g_errno ='ais-00144'
      RETURN
   END IF
    
   SELECT isaesite INTO l_site 
     FROM isae_t 
    WHERE isaeent = g_enterprise
      AND isaesite = g_isae_m.isaesite
      AND isae004  = g_input.isac002
      AND isae002 <= g_isae_m.isaf014
      AND isae003 >= g_isae_m.isaf014

   IF cl_null(l_site) THEN
      LET g_errno ='ais-00144'
      RETURN
   END IF
   
   IF NOT cl_null(g_isae_m.isae001) THEN 
      SELECT isae012
        INTO l_isae012
        FROM isae_t           
       WHERE isaeent = g_enterprise
         AND isaesite IN (g_isae_m.isaesite,g_input.glaacomp) 
         AND isae001  = g_isae_m.isae001
         AND isae002 <= g_isae_m.isaf014
         AND isae003 >= g_isae_m.isaf014
         AND isae004 = g_input.isac002
         
      IF cl_null(l_isae012)THEN
         LET g_errno = 'ais-00234'
         RETURN
      END IF
   END IF
END FUNCTION
# 營運據點說明
PRIVATE FUNCTION aisp310_isaesite_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_isae_m.isaesite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_isae_m.isaesite_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_isae_m.isaesite_desc
END FUNCTION
# 抓取發票簿預設值
PRIVATE FUNCTION aisp310_isae_get()
   DEFINE l_isae007     LIKE isae_t.isae007
   DEFINE l_isae008     LIKE isae_t.isae008
   
   SELECT isae005,isae014,isae007,isae008,isae012,isae020
     INTO g_isae005,g_isae_m.isae014,l_isae007,l_isae008,g_isae012,g_isae_m.isae020
     FROM isae_t           
    WHERE isaeent = g_enterprise
      AND isaesite = g_isae_m.isaesite
      AND isae001  = g_isae_m.isae001
      AND isae002 <= g_isae_m.isaf014
      AND isae003 >= g_isae_m.isaf014
   
   IF g_isai002 = '1' THEN 
      LET g_isae_m.isae008 = l_isae007
   END IF
   
   IF g_isai002 = '2' THEN 
      LET g_isae_m.isae008 = l_isae008
   END IF

   LET g_isae_m.isae012 = g_isae012
END FUNCTION
# 批处理逻辑
PRIVATE FUNCTION aisp310_p()
   DEFINE l_tmp          RECORD 
                         xmdkdocno       LIKE xmdk_t.xmdkdocno,
                         xmdk001         LIKE xmdk_t.xmdk001,
                         xmdk202         LIKE xmdk_t.xmdk202,
                         xmdk004         LIKE xmdk_t.xmdk004,
                         xmdk008         LIKE xmdk_t.xmdk008,
                         xmdk012         LIKE xmdk_t.xmdk012,
                         xmdksite        LIKE xmdk_t.xmdksite,
                         xmdk003         LIKE xmdk_t.xmdk003,
                         xmdk010         LIKE xmdk_t.xmdk010,
                         xmdk047         LIKE xmdk_t.xmdk047   #160802-00007#1 Add
                         END RECORD
   DEFINE l_array        DYNAMIC ARRAY OF RECORD
                         chr    LIKE type_t.chr1000,
                         dat    LIKE type_t.dat
                         END RECORD
   DEFINE l_isaf         RECORD LIKE isaf_t.* 
   DEFINE l_isai         RECORD LIKE isai_t.*
   DEFINE l_ooef019      LIKE ooef_t.ooef019
   DEFINE l_pmaa003      LIKE pmaa_t.pmaa003
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_strno1       LIKE isaf_t.isafdocno
   DEFINE l_endno1       LIKE isaf_t.isafdocno
   DEFINE l_doais        LIKE type_t.num5
   DEFINE l_isaf011      LIKE isaf_t.isaf011
   DEFINE l_wc           STRING
   DEFINE l_str          STRING
   
   LET l_strno1 = NULL   LET l_endno1 = NULL
   LET l_doais = 0
   
   CALL cl_err_collect_init()
   
   #依单据个别产生
   IF g_input.type = '1' THEN 
      LET g_sql = "SELECT DISTINCT xmdkdocno,xmdk001,xmdk202,xmdk004,xmdk008,xmdk012,xmdksite,xmdk003,xmdk010 "             
   END IF
   
   #依扣賬日期合併產生
   IF g_input.type = '2' THEN 
      LET g_sql = "SELECT DISTINCT '',xmdk001,xmdk202,xmdk004,xmdk008,xmdk012,xmdksite,xmdk003,xmdk010 "
   END IF   
   
   #依發票客戶產生
   IF g_input.type = '3' THEN 
      LET g_sql = "SELECT DISTINCT '','',xmdk202,xmdk004,xmdk008,xmdk012,xmdksite,xmdk003,xmdk010 "
   END IF
   LET g_sql = g_sql,",xmdk047"   #160802-00007#1 Add
   LET g_sql = g_sql,"  FROM xmdk_t ",
                     " WHERE xmdkent = ",g_enterprise,
                     "   AND xmdkdocno IN (SELECT DISTINCT xmdldocno FROM aisp310_tmp WHERE sel = 'Y')"  
               
   
   PREPARE aisp310_pre FROM g_sql
   DECLARE aisp310_cs CURSOR WITH HOLD FOR aisp310_pre
   FOREACH aisp310_cs INTO l_tmp.*
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = 'FOREACH:aisp310_cs'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF

      LET l_success = TRUE 
      
      CALL s_transaction_begin() 
      
      INITIALIZE l_isaf.* TO NULL
      LET l_isaf.isafent = g_enterprise
      LET l_isaf.isafsite = l_tmp.xmdksite
      CALL s_fin_orga_get_comp_ld(l_isaf.isafsite) RETURNING g_sub_success,g_errno,l_isaf.isafcomp,g_glaald
   
      LET l_ooef019 = NULL   
      SELECT ooef019 INTO l_ooef019
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = l_isaf.isafcomp
      LET l_isaf.isafdocno = g_isae_m.isafdocno
   
      LET l_isaf.isafdocdt = g_isae_m.isafdocdt

      CALL s_aooi200_fin_gen_docno(g_glaald,'','',l_isaf.isafdocno,l_isaf.isafdocdt,'aist310')
         RETURNING g_sub_success,l_isaf.isafdocno
      IF NOT g_sub_success THEN
         LET l_success = FALSE
      END IF
     
      LET l_isaf.isaf002   = l_tmp.xmdk202
      LET l_isaf.isaf003   = l_tmp.xmdk008
      LET l_isaf.isaf004   = l_tmp.xmdk004
      LET l_isaf.isaf005   = g_user
      SELECT ooag003 INTO l_isaf.isaf006 FROM ooag_t
       WHERE ooagent = g_enterprise
         AND ooag001 = l_isaf.isaf005
         
      LET l_isaf.isaf008   = g_input.isac002
      
      #LET l_isaf.isaf009   = #從發票簿抓 預設N
      #LET l_isaf.isaf010   = #發票代碼後面呼叫展算回寫
      #LET l_isaf.isaf011   = #發票號碼
      LET l_isaf.isaf014   = g_isae_m.isaf014
      LET l_isaf.isaf016   = l_tmp.xmdk012
      #含稅否/稅率
      SELECT oodb005,oodb006 INTO l_isaf.isaf017,l_isaf.isaf018
        FROM oodb_t
       WHERE oodbent = g_enterprise
         AND oodb001 = g_ooef019
         AND oodb002 = l_isaf.isaf016
      
      SELECT isak008,isak009,
             isak010,isak011,isak012
        INTO l_isaf.isaf022,l_isaf.isaf023,
             l_isaf.isaf024,l_isaf.isaf025,l_isaf.isaf026
        FROM isak_t
       WHERE isakent = g_enterprise
         AND isak001 = l_isaf.isaf002
         AND isak002 = g_ooef019
         AND isakstus = 'Y'
      
      #稅務編號處理(isaf022)
      #國別為台灣的處理
      SELECT * INTO l_isai.* FROM isai_t
       WHERE isaient = g_enterprise
         AND isai001 = g_ooef019
      
      IF l_isai.isai008 = 'TW' THEN
         #isaf022 用pmaa003
         LET l_pmaa003 = NULL
         SELECT pmaa003 INTO l_pmaa003
           FROM pmaa_t
          WHERE pmaaent = g_enterprise
            AND pmaa001 = l_isaf.isaf002
            AND pmaastus = 'Y'
         LET l_isaf.isaf022 = l_pmaa003
      ELSE
         #isaf022 用isak008(aisi020)
      END IF
         
      SELECT ooefl004 INTO l_isaf.isaf027 FROM ooefl_t
       WHERE ooeflent = g_enterprise
         AND ooefl001 = l_isaf.isafcomp
         AND ooefl002 = g_dlang      
         
      SELECT isao001,isao002,isao003,
             isao004,isao005
        INTO l_isaf.isaf028,l_isaf.isaf029,l_isaf.isaf030,
             l_isaf.isaf031,l_isaf.isaf032
        FROM isao_t
       WHERE isaoent = g_enterprise
         AND isaosite = l_isaf.isafcomp
         AND isaostus = 'Y'   
         
      LET l_isaf.isaf039 = g_today
      LET l_isaf.isaf040 = cl_get_time()
      LET l_isaf.isaf041 = g_user   
      
      LET l_isaf.isaf044   = 0 
      SELECT ooef002 INTO l_isaf.isaf046 FROM isaf_t
       WHERE ooefent = g_enterprise
         AND ooef001 = l_isaf.isafcomp
         
      LET l_isaf.isaf050   = 0
      LET l_isaf.isaf051   = g_isae_m.isae001
      LET l_isaf.isaf052   = g_isae_m.isaesite
      #LET l_isaf.isaf053   #發票聯別  用發票類型串
      #LET l_isaf.isaf054   #課稅別    用發票類型串
      LET l_isaf.isaf055   = l_tmp.xmdk008
      
      IF g_input.isaf056 = '2' THEN
         LET l_isaf.isaf056 = '2'  #出貨單1藍字發票       銷退單2紅字發票
         LET l_isaf.isaf001 = '4'
      ELSE
         LET l_isaf.isaf056 = '1'
         LET l_isaf.isaf001 = '1'
      END IF
      
      LET l_isaf.isaf057   = l_tmp.xmdk003
      LET l_isaf.isaf058   = l_tmp.xmdk010
      
      SELECT oodb008 INTO l_isaf.isaf054
        FROM oodb_t
       WHERE oodbent = g_enterprise
         AND oodb001 = g_ooef019
         AND oodb002 = l_isaf.isaf016
      #發票簿預設值
      SELECT isae005,isae008   ,isae012,isae007
        INTO l_isaf.isaf009,l_isaf.isaf010 ,l_isaf.isaf011
        FROM isae_t
       WHERE isaeent = g_enterprise
         AND isaecomp = l_isaf.isafcomp
         AND isaesite = l_isaf.isaf052
         AND isae001 = l_isaf.isaf051
         AND isae002 <= l_isaf.isaf014
         AND isae003 >= l_isaf.isaf014
         AND isae004 = l_isaf.isaf008
      
        
      #媒申格式
      SELECT isac004,isac008 INTO l_isaf.isaf019,l_isaf.isaf053
        FROM isac_t
       WHERE isacent = g_enterprise
         AND isac001 = g_ooef019
         AND isac002 = l_isaf.isaf008
      #發票客戶帶出交易對象全名   
      SELECT pmaal004 INTO l_isaf.isaf021
        FROM pmaal_t
       WHERE pmaalent = g_enterprise
         AND pmaal001 = l_isaf.isaf002
         AND pmaal002 = g_dlang
      
      LET l_isaf.isaf100   = g_input.xmdk016
      LET l_isaf.isaf101   = g_input.xmdk017
      LET l_isaf.isaf103   = 0
      LET l_isaf.isaf104   = 0
      LET l_isaf.isaf105   = 0
      LET l_isaf.isaf106   = 0 
      LET l_isaf.isaf107   = 0
      LET l_isaf.isaf108   = 0
      LET l_isaf.isaf113   = 0 
      LET l_isaf.isaf114   = 0
      LET l_isaf.isaf115   = 0
      LET l_isaf.isaf116   = 0
      LET l_isaf.isaf117   = 0
      LET l_isaf.isaf118   = 0
      LET l_isaf.isaf119   = 0
      
                                           #if  isaf054課稅別= '1' then 
                                           #    應稅類金額= isaf105
                                           #    零稅類金額= 0 
                                           #    免稅類金額= 0 
                                           #end if 
      LET l_isaf.isaf120   = 0
                                          #= if  isaf054課稅別 = '2' then 
                                          #   應稅類金額= 0
                                          #   零稅類金額= isaf105
                                          #   免稅類金額= 0 
                                          # end if         
      
      LET l_isaf.isaf121   = 0
                                          #= if isaf054課稅別 = '3' then 
                                          #     應稅類金額= 0
                                          #     零稅類金額= 0 
                                          #     免稅類金額= isaf105 
                                          # end if      
      LET l_isaf.isaf122           = 0                                          
      LET l_isaf.isaf123           = 0
      LET l_isaf.isaf124           = 0
      #產生單頭
      
      #狀態碼及modifydt等
      LET l_isaf.isafownid = g_user
      LET l_isaf.isafowndp = g_dept
      LET l_isaf.isafcrtid = g_user
      LET l_isaf.isafcrtdp = g_dept
      LET l_isaf.isafcrtdt = cl_get_current()
      LET l_isaf.isafmodid = g_user
      LET l_isaf.isafmoddt = cl_get_current()
      LET l_isaf.isafstus = 'N'
      
      LET l_isaf.isaf205 = 'N'
      LET l_isaf.isaf067 = l_tmp.xmdk047   #160802-00007#1 Add
      
      INSERT INTO isaf_t VALUES(l_isaf.*)
      IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
         LET l_success = FALSE
      END IF
   
   
      #產生來源明細單身
      CALL aisp310_ins_isag(l_isaf.isafdocno,l_isaf.isafcomp,l_tmp.*) RETURNING g_sub_success,l_str
      IF NOT g_sub_success THEN
         LET l_success = FALSE
      END IF
      
      IF NOT cl_null(g_isae_m.isae001) THEN 
         #產生發票明細 AND 歷程
         LET l_wc = ' 1=1'
         CALL l_array.clear()
         LET l_array[1].chr = l_isaf.isafdocno
         LET l_array[2].chr = l_isaf.isafcomp
         LET l_array[3].chr = g_input.isah_type
         LET l_array[4].chr = g_isae_m.isae020
         LET l_array[5].chr = g_isae_m.isae001
         LET l_array[6].chr = g_isae_m.isaesite
         LET l_array[7].chr = g_isae_m.isae008
         LET l_array[8].chr = g_isae_m.isae012
         CALL s_aisp320_ins_isah(l_wc,l_array)RETURNING g_sub_success
         IF NOT g_sub_success THEN
            LET l_success = FALSE
         END IF
         
         CALL aisp310_update_isae(l_isaf.isafcomp,l_isaf.isafdocno) RETURNING g_sub_success
         IF NOT g_sub_success THEN
            LET l_success = FALSE
         END IF
      END IF

      IF l_success THEN
         #產生aist310成功會有發票號碼 把發票號碼回寫來源單
         LET l_isaf011 = NULL
         SELECT isaf011 INTO l_isaf011
           FROM isaf_t
          WHERE isafent = g_enterprise
            AND isafcomp = l_isaf.isafcomp
            AND isafdocno = l_isaf.isafdocno
          
         LET g_sql = "UPDATE xmdk_t SET xmdk037 = '", l_isaf011,"'",
                     " WHERE xmdkent = ",g_enterprise,
                     "   AND xmdkdocno IN ",l_str     
         PREPARE aisp310_upd_xmdk037_pre FROM g_sql
         EXECUTE aisp310_upd_xmdk037_pre         
            
         CALL s_transaction_end('Y',0)
         IF cl_null(l_strno1) THEN
            LET l_strno1 = l_isaf.isafdocno
         END IF
         LET l_endno1 = l_isaf.isafdocno
         LET l_doais = l_doais + 1
      ELSE
         CALL s_transaction_end('N',0)     
      END IF  
   END FOREACH 
   
   IF l_doais = 0 THEN
      INITIALIZE g_errparam.* TO NULL
      LET g_errparam.code = 'aap-00313'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()   
   ELSE
      #顯示成功的對帳單
      INITIALIZE g_errparam.* TO NULL
      LET g_errparam.code = 'aap-00379'
      LET g_errparam.replace[1] = l_strno1
      LET g_errparam.replace[2] = l_endno1
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   CALL cl_err_collect_show()
END FUNCTION
# 插入发票档立账来源明细单身
PRIVATE FUNCTION aisp310_ins_isag(p_docno,p_comp,l_tmp)
   DEFINE l_tmp              RECORD 
                             xmdkdocno       LIKE xmdk_t.xmdkdocno,
                             xmdk001         LIKE xmdk_t.xmdk001,
                             xmdk202         LIKE xmdk_t.xmdk202,
                             xmdk004         LIKE xmdk_t.xmdk004,
                             xmdk008         LIKE xmdk_t.xmdk008,
                             xmdk012         LIKE xmdk_t.xmdk012,
                             xmdksite        LIKE xmdk_t.xmdksite,
                             xmdk003         LIKE xmdk_t.xmdk003,
                             xmdk010         LIKE xmdk_t.xmdk010,
                             xmdk047         LIKE xmdk_t.xmdk047   #160802-00007#1 Add
                             END RECORD
   DEFINE p_docno            LIKE isaf_t.isafdocno
   DEFINE p_comp             LIKE isaf_t.isafcomp
   DEFINE l_sql              STRING 
   DEFINE l_xmdl             RECORD LIKE xmdl_t.*
   DEFINE l_isaf             RECORD LIKE isaf_t.*  
   DEFINE l_isag             RECORD LIKE isag_t.*    
   DEFINE l_xmdldocno        LIKE xmdl_t.xmdldocno
   DEFINE l_xmdlseq          LIKE xmdl_t.xmdlseq
   DEFINE l_xmdk000          LIKE xmdk_t.xmdk000
   DEFINE l_xmdl003          LIKE xmdl_t.xmdl003
   DEFINE l_xmdl004          LIKE xmdl_t.xmdl004
   DEFINE l_isag004          LIKE isag_t.isag004
   DEFINE l_isag004_2        LIKE isag_t.isag004
   DEFINE r_xrcd123          LIKE xrcd_t.xrcd113
   DEFINE r_xrcd124          LIKE xrcd_t.xrcd114
   DEFINE r_xrcd125          LIKE xrcd_t.xrcd115
   DEFINE r_xrcd133          LIKE xrcd_t.xrcd113
   DEFINE r_xrcd134          LIKE xrcd_t.xrcd114
   DEFINE r_xrcd135          LIKE xrcd_t.xrcd115
   DEFINE r_success          LIKE type_t.num5
   DEFINE l_flag             LIKE type_t.chr1
   DEFINE r_str              STRING
   
   LET r_success = TRUE
   LET l_flag = 'N'
   LET r_str = ''
   
   INITIALIZE l_isaf.* TO NULL
   SELECT * INTO l_isaf.* FROM isaf_t
    WHERE isafent = g_enterprise
      AND isafcomp = p_comp
      AND isafdocno = p_docno
   
   LET l_sql = "SELECT xmdldocno,xmdlseq FROM xmdl_t,xmdk_t ",
               " WHERE xmdlent = ",g_enterprise,
               "   AND xmdlent = xmdkent ",
               "   AND xmdldocno = xmdkdocno ",
               "   AND xmdldocno || xmdlseq IN (SELECT DISTINCT xmdldocno || xmdlseq FROM aisp310_tmp WHERE sel = 'Y')"
               
   #依单据个别产生
   IF g_input.type = '1' THEN 
      LET l_sql = l_sql," AND xmdldocno = '",l_tmp.xmdkdocno,"'",
                        " AND xmdk001 = '",l_tmp.xmdk001,"'",
                        " AND xmdk202 = '",l_tmp.xmdk202,"'",
                        " AND xmdk004 = '",l_tmp.xmdk004,"'",
                        " AND xmdk008 = '",l_tmp.xmdk008,"'",
                        " AND xmdk012 = '",l_tmp.xmdk012,"'",
                        " AND xmdksite = '",l_tmp.xmdksite,"'",
                        " AND xmdk003 = '",l_tmp.xmdk003,"'",
                        " AND xmdk010 = '",l_tmp.xmdk010,"'"
   END IF
   
   #依扣賬日期合併產生
   IF g_input.type = '2' THEN
      LET l_sql = l_sql," AND xmdk001 = '",l_tmp.xmdk001,"'",
                        " AND xmdk202 = '",l_tmp.xmdk202,"'",
                        " AND xmdk004 = '",l_tmp.xmdk004,"'",
                        " AND xmdk008 = '",l_tmp.xmdk008,"'",
                        " AND xmdk012 = '",l_tmp.xmdk012,"'",
                        " AND xmdksite = '",l_tmp.xmdksite,"'",
                        " AND xmdk003 = '",l_tmp.xmdk003,"'",
                        " AND xmdk010 = '",l_tmp.xmdk010,"'"
   END IF
              
   #依扣賬日期合併產生
   IF g_input.type = '3' THEN
      LET l_sql = l_sql," AND xmdk202 = '",l_tmp.xmdk202,"'",
                        " AND xmdk004 = '",l_tmp.xmdk004,"'",
                        " AND xmdk008 = '",l_tmp.xmdk008,"'",
                        " AND xmdk012 = '",l_tmp.xmdk012,"'",
                        " AND xmdksite = '",l_tmp.xmdksite,"'",
                        " AND xmdk003 = '",l_tmp.xmdk003,"'",
                        " AND xmdk010 = '",l_tmp.xmdk010,"'"
   END IF
               
   PREPARE aisp310_isag_pre FROM l_sql
   DECLARE aisp310_isag_cs CURSOR FOR aisp310_isag_pre
   FOREACH aisp310_isag_cs INTO l_xmdldocno,l_xmdlseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF 
      
      INITIALIZE l_xmdl.* TO NULL
      SELECT * INTO l_xmdl.* 
        FROM xmdl_t
       WHERE xmdlent = g_enterprise
         AND xmdldocno = l_xmdldocno
         AND xmdlseq = l_xmdlseq
         
      SELECT xmdk000 INTO l_xmdk000
        FROM xmdk_t
       WHERE xmdkent = g_enterprise
         AND xmdkdocno = l_xmdldocno
      
      SELECT MAX(isagseq) INTO l_isag.isagseq
        FROM isag_t
       WHERE isagent = g_enterprise
         AND isagdocno = l_isaf.isafdocno
         AND isagcomp = l_isaf.isafcomp
         
      IF cl_null(l_isag.isagseq) THEN 
         LET l_isag.isagseq = 1
      ELSE
         LET l_isag.isagseq = l_isag.isagseq + 1
      END IF 
      
      LET l_isag.isagent = g_enterprise
      LET l_isag.isagcomp = l_isaf.isafcomp
      LET l_isag.isagdocno = l_isaf.isafdocno
      LET l_isag.isagorga = l_xmdl.xmdlsite
      
      IF l_xmdk000 = '6' THEN 
         LET l_isag.isag001 = '21'    #仓退
      ELSE
         LET l_isag.isag001 = '11'    #出货
      END IF
      
      LET l_isag.isag002 = l_xmdl.xmdldocno
      LET l_isag.isag003 = l_xmdl.xmdlseq
      
      SELECT xmdl024,qty INTO l_isag.isag101,l_isag.isag004
        FROM aisp310_tmp 
       WHERE xmdldocno = l_xmdldocno
         AND xmdlseq = l_xmdlseq 
      
      LET l_isag.isag005 = l_xmdl.xmdl021
      LET l_isag.isag006 = l_isaf.isaf016
      LET l_isag.isag007 = l_isaf.isaf017
      LET l_isag.isag008 = l_isaf.isaf018
      LET l_isag.isag009 = l_xmdl.xmdl008
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_isag.isag009
      CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET l_isag.isag010 = '', g_rtn_fields[1] , ''

      LET l_isag.isag011 = 0
      LET l_isag.isag012 = l_tmp.xmdk010
      LET l_isag.isag013 = l_xmdl.xmdl048
      LET l_isag.isag014 = l_xmdl.xmdl049
      
      IF l_isag.isag001 = '11' THEN 
         LET l_isag.isag015 = 1
      ELSE
         LET l_isag.isag015 = -1
      END IF
      
      LET l_isag.isag016 = l_xmdl.xmdl033
      LET l_isag.isag017 = ''
      #LET l_isag.isag101 = l_xmdl.xmdl024
      
      CALL s_tax_ins(l_isaf.isafdocno,l_isag.isagseq,0,l_isag.isagorga,
                     l_isag.isag004 * l_isag.isag101,l_isag.isag006,
                     l_isag.isag004,l_isaf.isaf100,l_isaf.isaf101,g_glaald,0,0)
        RETURNING l_isag.isag103,l_isag.isag104,l_isag.isag105,
                  l_isag.isag113,l_isag.isag114,l_isag.isag115,
                  r_xrcd123,r_xrcd124,r_xrcd125,r_xrcd133,r_xrcd134,r_xrcd135
                  
      
      INSERT INTO isag_t(isagent,isagcomp,isagdocno,isagseq,isagorga,isag001,isag002,isag003,
                         isag004,isag005,isag006,isag007,isag008,isag009,isag010,isag011,isag012,
                         isag013,isag014,isag015,isag016,isag017,isag101,isag103,isag104,isag105,
                         isag113,isag114,isag115)
                  VALUES(g_enterprise,l_isag.isagcomp,l_isag.isagdocno,
                         l_isag.isagseq,l_isag.isagorga,
                         l_isag.isag001,l_isag.isag002,l_isag.isag003,
                         l_isag.isag004,l_isag.isag005,l_isag.isag006,
                         l_isag.isag007,l_isag.isag008,l_isag.isag009,
                         l_isag.isag010,l_isag.isag011,l_isag.isag012,
                         l_isag.isag013,l_isag.isag014,l_isag.isag015,
                         l_isag.isag016,l_isag.isag017,l_isag.isag101,
                         l_isag.isag103,l_isag.isag104,l_isag.isag105,
                         l_isag.isag113,l_isag.isag114,l_isag.isag115)
                 
      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "isag_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
      
         LET r_success = FALSE                        
      END IF   
      LET l_flag = 'Y'   

      IF cl_null(r_str) THEN 
         LET r_str = "'",l_xmdldocno,"'"
      ELSE
         LET r_str = r_str,",","'",l_xmdldocno,"'"
      END IF
   END FOREACH
   
   IF l_flag = 'N' THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = ""
      LET g_errparam.code   = 'axc-00530' 
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
   END IF
  
   LET r_str = "(",r_str,")"  
  
   RETURN r_success,r_str
END FUNCTION
# 获取已立发票的数量
PRIVATE FUNCTION aisp310_get_isag004(p_xmdldocno,p_xmdlseq)
   DEFINE p_xmdldocno     LIKE xmdl_t.xmdldocno
   DEFINE p_xmdlseq       LIKE xmdl_t.xmdlseq
   DEFINE l_xmdl003       LIKE xmdl_t.xmdl003
   DEFINE l_xmdl004       LIKE xmdl_t.xmdl004 
   DEFINE r_isag004_1     LIKE isag_t.isag004
   DEFINE r_isag004_2     LIKE isag_t.isag004
   
   #由出貨單串訂單
   SELECT xmdl003,xmdl004 INTO l_xmdl003,l_xmdl004  
     FROM xmdl_t 
    WHERE xmdlent = g_enterprise
      AND xmdldocno = p_xmdldocno
      AND xmdlseq = p_xmdlseq
   
   SELECT SUM(isag004) INTO r_isag004_1 
     FROM isag_t,isaf_t 
    WHERE isagent = g_enterprise
      AND isag002 = l_xmdl003  # 訂單號碼 
      AND isag003 = l_xmdl004  #-訂單項次
      AND isafent = isagent
      AND isafdocno = isagdocno
      AND isafcomp = isafcomp
      AND isafstus <> 'X'  
    
   IF cl_null(r_isag004_1) THEN 
      LET r_isag004_1 = 0
   END IF
	  
	#出貨單 
　 SELECT SUM(isag004) INTO r_isag004_2 
     FROM isag_t,isaf_t 
    WHERE isagent = g_enterprise
      AND isag002 = p_xmdldocno
      AND isag003 = p_xmdlseq
      AND isafent = isagent
      AND isafdocno = isagdocno
      AND isafcomp = isafcomp　
      AND isafstus <> 'X'   
   
   IF cl_null(r_isag004_2) THEN 
      LET r_isag004_2 = 0
   END IF
   
   RETURN r_isag004_1,r_isag004_2
END FUNCTION
# 回写发票薄下次列印号码
PRIVATE FUNCTION aisp310_update_isae(p_comp,p_docno)
   DEFINE p_comp                   LIKE isaf_t.isafcomp
   DEFINE p_docno                  LIKE isaf_t.isafdocno
   DEFINE l_len                    LIKE type_t.num5
   DEFINE l_isae012                LIKE isae_t.isae012    
   DEFINE l_isae012_n              LIKE isae_t.isae012    #下次列印號碼
   DEFINE l_cnt                    LIKE type_t.num5
   DEFINE l_isae012_str            STRING
   DEFINE l_xmdl047                LIKE xmdl_t.xmdl047
   DEFINE l_isag115_sum            LIKE isag_t.isag115
   DEFINE l_sql                    STRING 
   DEFINE l_isaf                   RECORD LIKE isaf_t.*  
   DEFINE r_success                LIKE type_t.num5
   DEFINE l_isae007                LIKE isae_t.isae007
   DEFINE l_isae007_str            STRING
   DEFINE l_isae07_len             LIKE type_t.num5

   LET r_success = TRUE
   
   SELECT * INTO l_isaf.* FROM isaf_t WHERE isafent = g_enterprise AND isafcomp = p_comp AND isafdocno = p_docno
   
   IF g_isai002 = '1' THEN     #如果使用的是字轨,计算下次列印发票时要去掉字轨
      IF l_isaf.isaf056 = '2' AND g_isai006 = 'Y' THEN
         SELECT isae007 INTO l_isae007
           FROM isae_t
          WHERE isaeent  = g_enterprise
            AND isaesite = l_isaf.isaf052
            AND isae001  = l_isaf.isaf051
            AND isae002 <= l_isaf.isaf014  
            AND isae003 >= l_isaf.isaf014
      ELSE
         SELECT isae007 INTO l_isae007
           FROM isae_t
          WHERE isaeent  = g_enterprise
            AND isaesite = l_isaf.isaf052
            AND isae001  = l_isaf.isaf051
            AND isae002 <= l_isaf.isaf014  
            AND isae003 >= l_isaf.isaf014
            AND isae004  = l_isaf.isaf008
      END IF
      
      #计算字轨的长度
      LET l_isae007_str = l_isae007
      LET l_isae07_len = l_isae007_str.getLength()
   END IF
   
   #本次开立的最大的发票
   SELECT MAX(isah002) INTO l_isae012
     FROM isah_t
    WHERE isahent = g_enterprise
      AND isahcomp = p_comp
      AND isahdocno = p_docno
      
   #计算下次列印号码
   LET l_isae012_str = l_isae012
   IF g_isai002 = '1' THEN
      LET l_len = l_isae012_str.getLength()
      LET l_isae012_str = l_isae012_str.subString(l_isae07_len+1,l_len)
   END IF
   LET l_len = l_isae012_str.getLength()
   LET l_sql = "SELECT lpad('",l_isae012_str,"'+1,",l_len,",'0') FROM dual"
   PREPARE isae012_pre2 FROM l_sql
   EXECUTE isae012_pre2 INTO l_isae012_n
   
   #本次开了几张发票
   SELECT COUNT(DISTINCT isah002) INTO l_cnt
     FROM isah_t
    WHERE isahent = g_enterprise
      AND isahcomp = p_comp
      AND isahdocno = p_docno

   IF l_isaf.isaf056 = '2' AND g_isai006 = 'Y' THEN
      UPDATE isae_t SET isae012 = l_isae012_n,                      #發票簿下次列印號碼
                        isae013 = isae013 + l_cnt,                  #已開張數 
                        isae014 = l_isaf.isaf014                    #已開發票日期 = 目前列印發票日期
       WHERE isaeent  = g_enterprise
         AND isaesite = l_isaf.isaf052
         AND isae001  = l_isaf.isaf051
         AND isae002 <= l_isaf.isaf014  
         AND isae003 >= l_isaf.isaf014
   ELSE
      UPDATE isae_t SET isae012 = l_isae012_n,                      #發票簿下次列印號碼
                        isae013 = isae013 + l_cnt,                  #已開張數 
                        isae014 = l_isaf.isaf014                    #已開發票日期 = 目前列印發票日期
       WHERE isaeent  = g_enterprise
         AND isaesite = l_isaf.isaf052
         AND isae001  = l_isaf.isaf051
         AND isae002 <= l_isaf.isaf014  
         AND isae003 >= l_isaf.isaf014
         AND isae004  = l_isaf.isaf008
   END IF
      
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "update"
      LET g_errparam.popup = TRUE
      CALL cl_err()
  
      LET r_success = FALSE                    
   END IF

   RETURN r_success
END FUNCTION

#end add-point
 
{</section>}
 
