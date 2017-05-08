#+ Version..: T100-12.01.21(00000)'
#
# Program name...: aqcs040.4gl
# Descriptions...: 參數作業-參數維護模式
# Date & Author..: 
 
IMPORT os
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#單身 type 宣告
PRIVATE TYPE type_g_ooab_d RECORD
   ooab001 LIKE ooab_t.ooab001,
   ooab001_desc LIKE type_t.chr80,
   ooab002 LIKE ooab_t.ooab002,
   ooabownid LIKE ooab_t.ooabownid,
   ooabownid_desc LIKE type_t.chr80,
   ooabcrtid LIKE ooab_t.ooabcrtid,
   ooabcrtid_desc LIKE type_t.chr80,
   ooabcrtdp LIKE ooab_t.ooabcrtdp,
   ooabcrtdp_desc LIKE type_t.chr80,
   ooabcrtdt DATETIME YEAR TO SECOND ,
   ooabmodid LIKE ooab_t.ooabmodid,
   ooabmodid_desc LIKE type_t.chr80,
   ooabmoddt DATETIME YEAR TO SECOND 
       END RECORD
 
DEFINE g_ooab_d    DYNAMIC ARRAY OF type_g_ooab_d
DEFINE g_ooab_d_t  DYNAMIC ARRAY OF type_g_ooab_d
 
 
 
DEFINE g_chr                 LIKE type_t.chr1  
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_i                   LIKE type_t.num5
DEFINE g_msg                 STRING
DEFINE g_before_input_done   LIKE type_t.num5 
DEFINE g_forupd_sql          STRING
DEFINE g_wc                  STRING
DEFINE g_sql                 STRING
DEFINE g_curr_diag           ui.Dialog        #Current Dialog
DEFINE g_idx                 LIKE type_t.num5	
DEFINE label_parametergroup  STRING 
 
DEFINE l_ac LIKE type_t.num5  
 
# 畫面處理 -- Saki start
DEFINE g_argv1             STRING                    # 參數多版未確認 
DEFINE g_form              STRING                    # 畫面檔名
DEFINE gwin_curr           ui.Window
DEFINE gfrm_curr           ui.Form
DEFINE g_infobox_hidden    LIKE type_t.num5
DEFINE g_parameter         DYNAMIC ARRAY OF RECORD
         id                LIKE type_t.chr50,   #參數ID ( Action ID )
         name              LIKE type_t.chr100,  #參數名稱多語言代碼
         comp              LIKE type_t.chr50,   #對應畫面檔元件(參數群組包起來的container)
         img               LIKE type_t.chr200   #圖片路徑 (主要給pictureFlow用)
                           END RECORD
DEFINE g_helptitle         STRING                    # 說明Title
DEFINE g_helpdesc          STRING                    # 說明內容
 
MAIN
   #add-point:main段define
   {<point name="main.define"/>}
   #end add-point   
 
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
 
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("aqc","")
 
   #add-point:作業初始化
   CALL aqcs040_fill_data()   # 整體參數
   #end add-point
 
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call
      {<point name="main.servicecall" />}
      #end add-point
 
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aqcs040 WITH FORM cl_ap_formpath("aqc",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL aqcs040_init()
 
      #進入選單 Menu (="N")
      CALL aqcs040_show()
      CALL aqcs040_ui_dialog()
 
      #add-point:畫面關閉前
      {<point name="main.before_close" />}
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aqcs040
 
   END IF
 
   #add-point:作業離開前
   {<point name="main.exit" />}
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
 
END MAIN
 
 
PRIVATE FUNCTION aqcs040_init()
   DEFINE lnode_frm   om.DomNode
 
   # 是否進入共用函式, 共用變數
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()
   
     
   
    CALL cl_set_combo_scc('aaa_aaaa_1','40') 
      
   CALL aqcs040_area_information()
   CALL aqcs040_parameter_switch("basic") 
   CALL aqcs040_show_field_help("")
 
END FUNCTION
 
# 指定各參數區塊資料 ( 方便切換參數內容 )
PRIVATE FUNCTION aqcs040_area_information()
 
   
   LET g_parameter[1].id = "basic"
   LET g_parameter[1].name = "aoo-702"
   LET g_parameter[1].comp = "scrgr1"
   LET g_parameter[1].img = "24/s_setting.png"
   LET g_parameter[2].id = "aaa"
   LET g_parameter[2].name = "aoo-702"
   LET g_parameter[2].comp = "scrgr2"
   LET g_parameter[2].img = "24/s_setting.png"
 
END FUNCTION
 
# 切換參數區塊 & 更換參數Title圖示文字
PRIVATE FUNCTION aqcs040_parameter_switch(ps_paramid)
   DEFINE ps_paramid   STRING
   DEFINE li_cnt       LIKE type_t.num5
   DEFINE lnode_item   om.DomNode
   DEFINE llst_items   om.NodeList
 
   FOR li_cnt = 1 TO g_parameter.getLength()
       # 傳入的id代表開啟, 其他都隱藏
       IF ps_paramid != g_parameter[li_cnt].id THEN
          CALL gfrm_curr.setElementHidden(g_parameter[li_cnt].comp, TRUE)
          # 設定參數按鈕格式
          CALL gfrm_curr.setElementStyle(g_parameter[li_cnt].id, "menuitem")
       ELSE
          CALL gfrm_curr.setElementHidden(g_parameter[li_cnt].comp, FALSE)
          # 設定參數主欄的icon & Label
          CALL gfrm_curr.setElementImage("page_parameterbox",g_parameter[li_cnt].img)   
          CALL gfrm_curr.setElementText("page_parameterbox",aqcs040_show_page_title(ps_paramid))   
          # 設定參數按鈕格式
          CALL gfrm_curr.setElementStyle(g_parameter[li_cnt].id, "menuitemfocus")
       END IF
   END FOR
 
END FUNCTION
 
 
# 子參數區塊開關
PRIVATE FUNCTION aqcs040_parameter_group_switch(ps_paramgroup)
   DEFINE ps_paramgroup   STRING
   DEFINE lnode_item      om.DomNode
   DEFINE li_hidden       LIKE type_t.num5
 
   LET lnode_item = gfrm_curr.findNode("Group", ps_paramgroup)
   IF lnode_item IS NOT NULL THEN
      LET li_hidden = lnode_item.getAttribute("hidden")
      IF li_hidden THEN
         CALL lnode_item.setAttribute("hidden", 0)
      ELSE
         CALL lnode_item.setAttribute("hidden", 1)
      END IF
   END IF
 
END FUNCTION
 
PRIVATE FUNCTION aqcs040_ui_dialog()
   MENU ""
      BEFORE MENU
#       CALL aqcs040_modify()   #預設進入修改狀態
         
      ON ACTION modify
         CALL aqcs040_modify()
 
      
      ON ACTION basic
         CALL aqcs040_parameter_switch("basic")
      ON ACTION aaa
         CALL aqcs040_parameter_switch("aaa")
 
      
      ON ACTION btn_paramsubgp1_1
         CALL aqcs040_parameter_group_switch("paramsubgp1_1")
      ON ACTION btn_paramsubgp2_1
         CALL aqcs040_parameter_group_switch("paramsubgp2_1")
      ON ACTION btn_paramsubgp2_2
         CALL aqcs040_parameter_group_switch("paramsubgp2_2")
      ON ACTION btn_paramsubgp2_3
         CALL aqcs040_parameter_group_switch("paramsubgp2_3")
 
      # 以下為每一個欄位的說明功能鍵
      
      ON ACTION help_basic_base_1
         CALL aqcs040_show_field_help("S-MFG-0046")
      ON ACTION help_aaa_aaaa_1
         CALL aqcs040_show_field_help("S-BAS-0010")
      ON ACTION help_aaa_aaaa_2
         CALL aqcs040_show_field_help("S-BAS-0003")
      ON ACTION help_aaa_bbbb_1
         CALL aqcs040_show_field_help("S-FIN-0002")
      ON ACTION help_aaa_123abc_1
         CALL aqcs040_show_field_help("S-CIR-0040")
 
      ON ACTION exit
         LET g_action_choice = "exit"
         EXIT MENU
      ON ACTION close
         LET g_action_choice = "exit"
         EXIT MENU
 
         #主選單用ACTION
         &include "main_menu.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE MENU
   END MENU
 
END FUNCTION
 
# 從DB取得要設定的資料
# 不清楚最後參數Schema規則, 先用舊參數取代, 未存在參數情況由Pattern考慮
PRIVATE FUNCTION aqcs040_fill_data()
   DEFINE ls_sql  STRING
   DEFINE li_cnt  LIKE type_t.num5
 
   LET ls_sql = "SELECT  ooab001,'',ooab002,ooabownid,'',ooabcrtid,'',ooabcrtdp,'',ooabcrtdt,ooabmodid,'',ooabmoddt ",
                " FROM ooab_t,gzsz_t,gzsx_t,gzsv_t ",
                " WHERE ",
                 "ooabent = " ,g_enterprise," AND ", "ooabsite = '",g_site,"' AND ",                  
                " ooab001 = gzsz002 ",
                " AND gzsz001 = 'ooab_t' ",
                " AND gzsx001 = 'aqcs040' ",   #程式編號
                " AND gzsx001 = gzsv001 ",     #作業名稱
                " AND gzsx002 = gzsv002 ",     #分頁編號
                " AND gzsx003 = gzsv003 ",     #分項編號
                " AND gzsv005 = gzsz001 ",
                " AND gzsv006 = gzsz002 ",
                " ORDER BY gzsx004,gzsx005,gzsv004"
 
   DECLARE aqcs040_fill_data_cs CURSOR FROM ls_sql
   LET li_cnt = 1
   FOREACH aqcs040_fill_data_cs INTO g_ooab_d[li_cnt].*
      LET li_cnt = li_cnt + 1
   END FOREACH
   CALL g_ooab_d.deleteElement(li_cnt)
 
   CLOSE aqcs040_fill_data_cs 
   FREE aqcs040_fill_data_cs 
 
   #進行備份陣列抄寫
   #FOR li_cnt = 1 TO g_ooab_d.getLength()
   #   LET g_ooab_d_t[li_cnt].* = g_ooab_d[li_cnt].*
   #END FOR
 
END FUNCTION
 
 
#+ 顯示畫面
PRIVATE FUNCTION aqcs040_show()
 
   DISPLAY g_ooab_d[1].ooab002,g_ooab_d[2].ooab002,g_ooab_d[3].ooab002,g_ooab_d[4].ooab002,g_ooab_d[5].ooab002 
      
   TO basic_base_1,aaa_aaaa_1,aaa_aaaa_2,aaa_bbbb_1,aaa_123abc_1 
      
    
END FUNCTION
 
#資料修改
PRIVATE FUNCTION aqcs040_modify()
   DEFINE li_cnt  LIKE  type_t.num5
   DEFINE li_exit LIKE  type_t.num5
   DEFINE ls_tmp  STRING 
   
   # 跨Table維護資料, 在修改階段除修改歷程外, 其他區塊都可直接切換
   DIALOG ATTRIBUTES(UNBUFFERED)
      INPUT g_ooab_d[1].ooab002,g_ooab_d[2].ooab002,g_ooab_d[3].ooab002,g_ooab_d[4].ooab002,g_ooab_d[5].ooab002 
        FROM basic_base_1,aaa_aaaa_1,aaa_aaaa_2,aaa_bbbb_1,aaa_123abc_1 
        ATTRIBUTE(WITHOUT DEFAULTS)
       
      
         BEFORE INPUT 
             #進行備份陣列抄寫
                FOR li_cnt = 1 TO g_ooab_d.getLength()
                    LET g_ooab_d_t[li_cnt].* = g_ooab_d[li_cnt].*
                END FOR 
 
         
         BEFORE FIELD basic_base_1
            CALL aqcs040_show_field_help("S-MFG-0046")
 
         AFTER FIELD basic_base_1
             #此段落由子樣板ss03產生
             
             IF NOT cl_null(g_ooab_d[1].ooab002)  AND g_ooab_d[1].ooab002 <> g_ooab_d_t[1].ooab002  THEN  
                
                #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                INITIALIZE g_chkparam.* TO NULL
                #設定g_chkparam.*的參數
                LET g_chkparam.arg1 = g_ooab_d[1].ooab002
                #呼叫檢查存在的library
                IF NOT cl_chk_exist("v_ooal002_5") THEN
                  LET g_ooab_d[1].ooab002 = g_ooab_d_t[1].ooab002 #放回舊值
                  CALL cl_err(g_ooab_d[1].ooab002,"lib-00089",1)
                  NEXT FIELD basic_base_1 
                END IF
                
            END IF
      




         BEFORE FIELD aaa_aaaa_1
            CALL aqcs040_show_field_help("S-BAS-0010")
 
         AFTER FIELD aaa_aaaa_1
         
         

         BEFORE FIELD aaa_aaaa_2
            CALL aqcs040_show_field_help("S-BAS-0003")
 
         AFTER FIELD aaa_aaaa_2
         #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_ooab_d[3].ooab002,"1","1","365","1","azz-00087",1) THEN
               NEXT FIELD aaa_aaaa_2
            END IF


         #此段落由子樣板ss01產生
            IF NOT cl_null(g_ooab_d[3].ooab002) THEN
               LET ls_tmp = g_ooab_d[3].ooab002
               IF ls_tmp.getIndexOf(".",1) THEN 
                   CALL cl_err(g_ooab_d[3].ooab002,"azz-00138",1)
                   NEXT FIELD aaa_aaaa_2
               END IF   
            END IF


         

         BEFORE FIELD aaa_bbbb_1
            CALL aqcs040_show_field_help("S-FIN-0002")
 
         AFTER FIELD aaa_bbbb_1
         #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_ooab_d[4].ooab002,"","0","","0","azz-00079",1) THEN
               NEXT FIELD aaa_bbbb_1
            END IF


         

         BEFORE FIELD aaa_123abc_1
            CALL aqcs040_show_field_help("S-CIR-0040")
 
         AFTER FIELD aaa_123abc_1
         #此段落由子樣板ss02產生
            IF NOT cl_null(g_ooab_d[5].ooab002) THEN
               IF NOT cl_chk_discrete_data("1,2,3",g_ooab_d[5].ooab002) THEN 
                   CALL cl_err(g_ooab_d[5].ooab002,"azz-00144",1)
                   NEXT FIELD aaa_123abc_1
               END IF   
            END IF


         #此段落由子樣板ss01產生
            IF NOT cl_null(g_ooab_d[5].ooab002) THEN
               LET ls_tmp = g_ooab_d[5].ooab002
               IF ls_tmp.getIndexOf(".",1) THEN 
                   CALL cl_err(g_ooab_d[5].ooab002,"azz-00138",1)
                   NEXT FIELD aaa_123abc_1
               END IF   
            END IF


         

      
           
      ON ACTION controlp INFIELD basic_base_1
            #此段落由子樣板ss04產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooab_d[1].ooab002             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #${mdl_arg_desc1}

            CALL q_ooal002_4()                                #呼叫開窗

            LET g_ooab_d[1].ooab002 = g_qryparam.return1              

            DISPLAY g_ooab_d[1].ooab002 TO basic_base_1              #${mdl_desc$}

            NEXT FIELD basic_base_1                          #返回原欄位


      ON ACTION controlp INFIELD aaa_bbbb_1
            #此段落由子樣板ss04產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooab_d[4].ooab002             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #${mdl_arg_desc1}

            CALL q_glaa()                                #呼叫開窗

            LET g_ooab_d[4].ooab002 = g_qryparam.return1              

            DISPLAY g_ooab_d[4].ooab002 TO aaa_bbbb_1              #${mdl_desc$}

            NEXT FIELD aaa_bbbb_1                          #返回原欄位


      END INPUT
 
      
      ON ACTION basic
         CALL aqcs040_parameter_switch("basic")
         NEXT FIELD basic_base_1
      ON ACTION aaa
         CALL aqcs040_parameter_switch("aaa")
         NEXT FIELD aaa_aaaa_1
 
      
      ON ACTION btn_paramsubgp1_1
         CALL aqcs040_parameter_group_switch("paramsubgp1_1")
      ON ACTION btn_paramsubgp2_1
         CALL aqcs040_parameter_group_switch("paramsubgp2_1")
      ON ACTION btn_paramsubgp2_2
         CALL aqcs040_parameter_group_switch("paramsubgp2_2")
      ON ACTION btn_paramsubgp2_3
         CALL aqcs040_parameter_group_switch("paramsubgp2_3")
      
     
 
      # 以下為每一個欄位的說明功能鍵
      
      ON ACTION help_basic_base_1
         CALL aqcs040_show_field_help("S-MFG-0046")
      ON ACTION help_aaa_aaaa_1
         CALL aqcs040_show_field_help("S-BAS-0010")
      ON ACTION help_aaa_aaaa_2
         CALL aqcs040_show_field_help("S-BAS-0003")
      ON ACTION help_aaa_bbbb_1
         CALL aqcs040_show_field_help("S-FIN-0002")
      ON ACTION help_aaa_123abc_1
         CALL aqcs040_show_field_help("S-CIR-0040")
 
      ON ACTION accept
         # 做存檔動作
         LET li_exit = FALSE
         ACCEPT DIALOG
 
      ON ACTION cancel
         # 返回舊值, 並顯示
         LET li_exit = TRUE
         CALL aqcs040_fill_data()   # 整體參數
         CALL aqcs040_show()
         EXIT DIALOG
   END DIALOG
 
   IF NOT li_exit THEN
      CALL aqcs040_update()
   END IF
 
END FUNCTION 
 
#+ 更新參數資料
PRIVATE FUNCTION aqcs040_update()
 
   DEFINE li_cnt  LIKE type_t.num5
 
   FOR li_cnt = 1 TO g_ooab_d.getLength()
      #若新值與舊值不同,進行更新 #更新參數資料 
      IF (g_ooab_d[li_cnt].ooab002 IS NULL AND g_ooab_d_t[li_cnt].ooab002 IS NOT NULL) OR
         (g_ooab_d[li_cnt].ooab002 IS NOT NULL AND g_ooab_d_t[li_cnt].ooab002 IS NULL) OR
         (g_ooab_d[li_cnt].ooab002 IS NOT NULL AND g_ooab_d_t[li_cnt].ooab002 IS NOT NULL AND
          g_ooab_d[li_cnt].ooab002 <> g_ooab_d_t[li_cnt].ooab002 ) THEN
         
         LET g_ooab_d[li_cnt].ooabmoddt = cl_get_current()
         UPDATE ooab_t SET ooab002 = g_ooab_d[li_cnt].ooab002,
                           ooabmodid = g_user,
                           ooabmoddt  = g_ooab_d[li_cnt].ooabmoddt
          WHERE  ooabent=g_enterprise  AND  ooabsite=g_site  AND 
          ooab001 = g_ooab_d[li_cnt].ooab001
      END IF
   END FOR
 
END FUNCTION
 
 
PRIVATE FUNCTION aqcs040_show_field_help(ps_field)
   DEFINE ps_field       STRING
   DEFINE ls_html        STRING
   DEFINE ls_title       STRING
   DEFINE ls_span_style  STRING 
   DEFINE ls_tabid       STRING
   
   LET ls_tabid = "ooab_t"
   # fake 
   CALL cl_help_param_field(ls_tabid,ps_field) RETURNING g_helptitle, g_helpdesc
 
 
   IF FGL_GETENV("GWC") THEN                                
      LET ls_span_style = "style=\"color: #027E88;line-height:20px; font-size: small;\""      
   ELSE
      LET ls_span_style = "style=\"color: #027E88;\""
   END IF                                                   
 
   LET ls_html = "<div><span ",ls_span_style CLIPPED,">"
   LET ls_html = ls_html, g_helpdesc
   LET ls_html = ls_html, "</span></div>"
   DISPLAY g_helptitle, ls_html TO helptitle,helpdesc
 
   LET ls_title = cl_getmsg("lib-00080",g_lang) #"參數說明"
   IF NOT cl_null(ps_field) AND NOT cl_null(g_helptitle) THEN    
      LET ls_title = ls_title CLIPPED," - ",g_helptitle
   END IF
   CALL gfrm_curr.setElementText("page_helptitle",ls_title)   
 
END FUNCTION
 
 
PRIVATE FUNCTION aqcs040_show_page_title(ps_paramid)
   DEFINE ps_paramid   STRING 
   DEFINE pc_gzswl004  LIKE gzswl_t.gzswl004
   DEFINE ls_sql       STRING 
 
   LET ls_sql = "SELECT gzswl004 FROM gzswl_t", 
                "    WHERE gzswl001 = '", g_code ,"'" ,
                "    AND  gzswl002 = '",ps_paramid,"'",
                "    AND  gzswl003 ='",g_lang ,"'"
   PREPARE  aqcs040_show_page_title_pre FROM ls_sql  
 
   EXECUTE aqcs040_show_page_title_pre  INTO pc_gzswl004 
   FREE aqcs040_show_page_title_pre
   RETURN pc_gzswl004 
END FUNCTION 
