#該程式未解開Section, 採用最新樣板產出!
#應用 s01 樣板自動產生(Version:12)
# Filename.......: apms010.4gl
# Descriptions...: 參數作業-參數維護模式
# Date & Author..: 
 
#add-point:填寫註解說明 name="global.memo"
{<point name="global.memo" edit="s"/>}
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"
{<point name="global.memo_customerization" edit="c"/>}
#end add-point
 
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
   ooabcrtdt DATETIME YEAR TO SECOND,
   ooabmodid LIKE ooab_t.ooabmodid,
   ooabmodid_desc LIKE type_t.chr80,
   ooabmoddt DATETIME YEAR TO SECOND
       END RECORD
 
DEFINE g_ooab_d    DYNAMIC ARRAY OF type_g_ooab_d
DEFINE g_ooab_d_t  DYNAMIC ARRAY OF type_g_ooab_d
 
 DEFINE g_ooef001 LIKE type_t.chr10 
          DEFINE ooef001_desc LIKE type_t.chr80 
        
DEFINE g_gzsv DYNAMIC ARRAY OF RECORD
         gzsv005 LIKE gzsv_t.gzsv005,
         gzsv006 LIKE gzsv_t.gzsv006
              END RECORD
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
DEFINE g_ref_fields        DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields        DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
MAIN
   #add-point:main段define name="main.define"
   {<point name="main.define"/>}
   #end add-point   
 
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
 
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   {<point name="main.before_ap_init"/>}
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("apm","")
 
   #作業初始化
   CALL apms010_fill_data()   # 整體參數
 
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call name="main.servicecall"
      {<point name="main.servicecall" />}
      #end add-point
 
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apms010 WITH FORM cl_ap_formpath("apm",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL apms010_init()
 
      #進入選單 Menu (="N")
      CALL apms010_show()
      CALL apms010_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      {<point name="main.before_close" />}
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_apms010
 
   END IF
 
   #add-point:作業離開前 name="main.exit"
   {<point name="main.exit" />}
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
 
END MAIN
 
 
PRIVATE FUNCTION apms010_init()
   DEFINE lnode_frm   om.DomNode
   DEFINE ls_title    STRING
 
   # 是否進入共用函式, 共用變數
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = "standard"
   LET g_ref_fields[2] = "lbl_s_title"
   CALL ap_ref_array2(g_ref_fields," SELECT gzzd005 FROM gzzd_t WHERE gzzd001 = ? AND gzzd002 = '"||g_lang CLIPPED||"' AND gzzd003 = ? AND gzzd004 = 's'","") RETURNING g_rtn_fields
   LET ls_title = "\n     ", g_rtn_fields[1], "\n\n"
   DISPLAY ls_title TO FORMONLY.s_title
 
   LET g_ooef001 = g_site  
   
    CALL cl_set_combo_scc('basic_base_3','2047') 
   CALL cl_set_combo_scc('basic_base_5','2094') 
   CALL cl_set_combo_scc('exchange_exchange_1','40') 
   CALL cl_set_combo_scc('exchange_exchange_2','40') 
      
   CALL apms010_area_information()
   CALL apms010_parameter_switch("basic") 
   CALL apms010_show_field_help("","")
 
END FUNCTION
 
# 指定各參數區塊資料 ( 方便切換參數內容 )
PRIVATE FUNCTION apms010_area_information()
 
   
   LET g_parameter[1].id = "basic"
   LET g_parameter[1].name = "aoo-702"
   LET g_parameter[1].comp = "scrgr1"
   LET g_parameter[1].img = "24/s_setting.png"
   LET g_parameter[2].id = "exchange"
   LET g_parameter[2].name = "aoo-702"
   LET g_parameter[2].comp = "scrgr2"
   LET g_parameter[2].img = "24/s_setting.png"
   LET g_parameter[3].id = "leadtime"
   LET g_parameter[3].name = "aoo-702"
   LET g_parameter[3].comp = "scrgr3"
   LET g_parameter[3].img = "24/s_setting.png"
 
END FUNCTION
 
# 切換參數區塊 & 更換參數Title圖示文字
PRIVATE FUNCTION apms010_parameter_switch(ps_paramid)
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
          CALL gfrm_curr.setElementText("page_parameterbox",apms010_show_page_title(ps_paramid))   
          # 設定參數按鈕格式
          CALL gfrm_curr.setElementStyle(g_parameter[li_cnt].id, "menuitemfocus")
       END IF
   END FOR
 
END FUNCTION
 
 
# 子參數區塊開關
PRIVATE FUNCTION apms010_parameter_group_switch(ps_paramgroup)
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
 
#+ 選單
PRIVATE FUNCTION apms010_ui_dialog()
   MENU ""
#     BEFORE MENU
#       CALL apms010_modify()   #預設進入修改狀態
         
      ON ACTION modify
         LET g_action_choice="modify"
         IF cl_auth_chk_act("modify") THEN
            CALL apms010_modify()
         END IF
 
      
      ON ACTION basic
         CALL apms010_parameter_switch("basic")
      ON ACTION exchange
         CALL apms010_parameter_switch("exchange")
      ON ACTION leadtime
         CALL apms010_parameter_switch("leadtime")
 
      
      ON ACTION btn_paramsubgp1_1
         CALL apms010_parameter_group_switch("paramsubgp1_1")
      ON ACTION btn_paramsubgp2_1
         CALL apms010_parameter_group_switch("paramsubgp2_1")
      ON ACTION btn_paramsubgp3_1
         CALL apms010_parameter_group_switch("paramsubgp3_1")
 
      # 以下為每一個欄位的說明功能鍵
      
      ON ACTION help_basic_base_1
         CALL apms010_show_field_help("ooab_t","S-BAS-0017")
      ON ACTION help_basic_base_2
         CALL apms010_show_field_help("ooab_t","S-BAS-0019")
      ON ACTION help_basic_base_3
         CALL apms010_show_field_help("ooab_t","S-BAS-0020")
      ON ACTION help_basic_base_4
         CALL apms010_show_field_help("ooab_t","S-BAS-0021")
      ON ACTION help_basic_base_5
         CALL apms010_show_field_help("ooab_t","S-BAS-0022")
      ON ACTION help_basic_base_6
         CALL apms010_show_field_help("ooab_t","S-BAS-0043")
      ON ACTION help_basic_base_7
         CALL apms010_show_field_help("ooab_t","S-BAS-0044")
      ON ACTION help_basic_base_8
         CALL apms010_show_field_help("ooab_t","S-BAS-0045")
      ON ACTION help_basic_base_9
         CALL apms010_show_field_help("ooab_t","S-BAS-0046")
      ON ACTION help_basic_base_10
         CALL apms010_show_field_help("ooab_t","S-BAS-0033")
      ON ACTION help_basic_base_11
         CALL apms010_show_field_help("ooab_t","S-BAS-0049")
      ON ACTION help_basic_base_12
         CALL apms010_show_field_help("ooab_t","S-BAS-0050")
      ON ACTION help_exchange_exchange_1
         CALL apms010_show_field_help("ooab_t","S-BAS-0014")
      ON ACTION help_exchange_exchange_2
         CALL apms010_show_field_help("ooab_t","S-BAS-0015")
      ON ACTION help_leadtime_leadtime_1
         CALL apms010_show_field_help("ooab_t","S-BAS-0024")
      ON ACTION help_leadtime_leadtime_2
         CALL apms010_show_field_help("ooab_t","S-BAS-0025")
      ON ACTION help_leadtime_leadtime_3
         CALL apms010_show_field_help("ooab_t","S-BAS-0026")
      ON ACTION help_leadtime_leadtime_4
         CALL apms010_show_field_help("ooab_t","S-BAS-0027")
 
      ON ACTION exit
         LET g_action_choice = "exit"
         EXIT MENU
      ON ACTION close
         LET g_action_choice = "exit"
         EXIT MENU
 
      ON ACTION home           #回首頁 (在toolbar button)
         CALL cl_cmdrun("azzi000")
 
      ON ACTION personalwork   #職能作業 (我的最愛)(在toolbar button)
         CALL cl_user_favorite()
 
         #主選單用ACTION
         #&include "main_menu.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE MENU
   END MENU
 
END FUNCTION
 
# 從DB取得要設定的資料
# 不清楚最後參數Schema規則, 先用舊參數取代, 未存在參數情況由Pattern考慮
PRIVATE FUNCTION apms010_fill_data()
   DEFINE ls_sql     STRING
   DEFINE li_cnt     LIKE type_t.num5
 
   LET ls_sql = " SELECT gzsv005,gzsv006 FROM gzsv_t,gzsx_t ",
                 " WHERE gzsv001 = 'apms010' ",   #程式編號
                   " AND gzsx001 = gzsv001 ",     #作業名稱
                   " AND gzsx002 = gzsv002 ",     #分頁編號
                   " AND gzsx003 = gzsv003 ",     #分項編號
                 #" ORDER BY gzsx004,gzsx005,gzsv004"
                 " ORDER BY gzsx004,gzsx002,gzsx005,gzsx003,gzsv004 "
 
   CALL g_gzsv.clear()
   DECLARE apms010_fill_data_cs CURSOR FROM ls_sql
   LET li_cnt = 1
   FOREACH apms010_fill_data_cs INTO g_gzsv[li_cnt].*
      CALL apms010_fill_detail(li_cnt,g_gzsv[li_cnt].gzsv005,g_gzsv[li_cnt].gzsv006)
      LET li_cnt = li_cnt + 1
   END FOREACH
   CALL g_gzsv.deleteElement(li_cnt)
 
   CLOSE apms010_fill_data_cs 
   FREE apms010_fill_data_cs 
 
END FUNCTION
 
#+ 填寫細項
PRIVATE FUNCTION apms010_fill_detail(li_cnt,lc_gzsv005,lc_gzsv006)
   DEFINE li_cnt     LIKE type_t.num5
   DEFINE lc_gzsv005 LIKE gzsv_t.gzsv005
   DEFINE lc_gzsv006 LIKE gzsv_t.gzsv006
   DEFINE ls_sql     STRING
   DEFINE ls_tab     STRING
   DEFINE lc_gzsz008 LIKE gzsz_t.gzsz008
   DEFINE li_cnt2    LIKE type_t.num5
   
   IF lc_gzsv006 IS NULL THEN
      RETURN
   END IF
 
   LET ls_tab = lc_gzsv005 CLIPPED
   LET ls_tab = ls_tab.subString(1,ls_tab.getIndexOf("_t",1)-1)
 
   LET ls_sql = "SELECT ",ls_tab,"001,'',",ls_tab,"002,",ls_tab,"ownid,'',",ls_tab,"crtid,'',",ls_tab,"crtdp,",
                    "'',",ls_tab,"crtdt,",ls_tab,"modid,'',",ls_tab,"moddt ",
                 " FROM ",ls_tab,"_t ",
                 " WHERE ",ls_tab,"001 = ? "
                      ," AND ",ls_tab,"ent = ",g_enterprise ," AND ",ls_tab,"site = '",g_site CLIPPED,"'"
 
   PREPARE apms010_fill_detail_cs FROM ls_sql
   
   LET ls_sql = "SELECT COUNT(1) FROM gzsv_t ",
                 "WHERE gzsv001 = 'apms010' ",
                 "  AND gzsv006 = ? " 
   PREPARE apms010_cnt_detail_cs FROM ls_sql 
   EXECUTE apms010_cnt_detail_cs USING lc_gzsv006 INTO li_cnt2
   FREE apms010_cnt_detail_cs
   #參數設定>1 要提示訊息 
   IF li_cnt2 > 1 THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code = "azz-00341"
      LET g_errparam.replace[1] = lc_gzsv006
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL cl_ap_exitprogram("0")
   END IF 
   
   LET ls_sql = "INSERT INTO ",ls_tab,"_t (",ls_tab,"001,",ls_tab,"002 ,",ls_tab,"ent,",ls_tab,"site)VALUES(?,?,?,?) "
   PREPARE apms010_ins_detail_cs FROM ls_sql 
   
   EXECUTE apms010_fill_detail_cs USING lc_gzsv006 INTO g_ooab_d[li_cnt].*
   IF SQLCA.SQLCODE = 100 THEN
      LET ls_sql = "SELECT gzsz008 FROM gzsz_t",
                   " WHERE gzsz001 = '",ls_tab,"_t'",
                     " AND gzsz002 = '",lc_gzsv006,"'"
      
      PREPARE apms010_sel_detail_cs FROM ls_sql
      EXECUTE apms010_sel_detail_cs INTO lc_gzsz008
  
      EXECUTE apms010_ins_detail_cs USING lc_gzsv006,lc_gzsz008,g_enterprise,g_site
      LET g_ooab_d[li_cnt].ooab002 = lc_gzsz008
   END IF 
 
   FREE apms010_fill_detail_cs
   FREE apms010_ins_detail_cs
   FREE apms010_sel_detail_cs   
END FUNCTION
 
#+ 顯示畫面
PRIVATE FUNCTION apms010_show()
 
   DISPLAY g_ooab_d[1].ooab002,g_ooab_d[2].ooab002,g_ooab_d[3].ooab002,g_ooab_d[4].ooab002,g_ooab_d[5].ooab002,
      g_ooab_d[6].ooab002,g_ooab_d[7].ooab002,g_ooab_d[8].ooab002,g_ooab_d[9].ooab002,g_ooab_d[10].ooab002,
      g_ooab_d[11].ooab002,g_ooab_d[12].ooab002,g_ooab_d[13].ooab002,g_ooab_d[14].ooab002,g_ooab_d[15].ooab002,
      g_ooab_d[16].ooab002,g_ooab_d[17].ooab002,g_ooab_d[18].ooab002,g_ooef001
      
   TO basic_base_1,basic_base_2,basic_base_3,basic_base_4,basic_base_5,
   basic_base_6,basic_base_7,basic_base_8,basic_base_9,basic_base_10,
   basic_base_11,basic_base_12,exchange_exchange_1,exchange_exchange_2,leadtime_leadtime_1,
   leadtime_leadtime_2,leadtime_leadtime_3,leadtime_leadtime_4,ooef001
      
    INITIALIZE g_ref_fields TO NULL 
          LET g_ref_fields[1] = g_ooef001 
          CALL ap_ref_array2(g_ref_fields," SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields 
          LET ooef001_desc = '', g_rtn_fields[1] , '' 
          DISPLAY BY NAME ooef001_desc 
END FUNCTION
 
#+ 資料修改
PRIVATE FUNCTION apms010_modify()
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE li_exit LIKE type_t.num5
   DEFINE ls_tmp  STRING 
   
   # 跨Table維護資料, 在修改階段除修改歷程外, 其他區塊都可直接切換
   DIALOG ATTRIBUTES(UNBUFFERED)
      INPUT g_ooab_d[1].ooab002,g_ooab_d[2].ooab002,g_ooab_d[3].ooab002,g_ooab_d[4].ooab002,g_ooab_d[5].ooab002,
      g_ooab_d[6].ooab002,g_ooab_d[7].ooab002,g_ooab_d[8].ooab002,g_ooab_d[9].ooab002,g_ooab_d[10].ooab002,
      g_ooab_d[11].ooab002,g_ooab_d[12].ooab002,g_ooab_d[13].ooab002,g_ooab_d[14].ooab002,g_ooab_d[15].ooab002,
      g_ooab_d[16].ooab002,g_ooab_d[17].ooab002,g_ooab_d[18].ooab002,g_ooef001
       FROM basic_base_1,basic_base_2,basic_base_3,basic_base_4,basic_base_5,
   basic_base_6,basic_base_7,basic_base_8,basic_base_9,basic_base_10,
   basic_base_11,basic_base_12,exchange_exchange_1,exchange_exchange_2,leadtime_leadtime_1,
   leadtime_leadtime_2,leadtime_leadtime_3,leadtime_leadtime_4,ooef001
      ATTRIBUTE(WITHOUT DEFAULTS)
 
         BEFORE INPUT 
            #進行備份陣列抄寫
            FOR li_cnt = 1 TO g_ooab_d.getLength()
               LET g_ooab_d_t[li_cnt].* = g_ooab_d[li_cnt].*
            END FOR 
 
         
         BEFORE FIELD basic_base_1
            CALL apms010_show_field_help("ooab_t","S-BAS-0017")
 
         AFTER FIELD basic_base_1

         BEFORE FIELD basic_base_2
            CALL apms010_show_field_help("ooab_t","S-BAS-0019")
 
         AFTER FIELD basic_base_2

         BEFORE FIELD basic_base_3
            CALL apms010_show_field_help("ooab_t","S-BAS-0020")
 
         AFTER FIELD basic_base_3
         

         BEFORE FIELD basic_base_4
            CALL apms010_show_field_help("ooab_t","S-BAS-0021")
 
         AFTER FIELD basic_base_4
              #此段落由子樣板ss03產生(Version:2)
             
             IF NOT cl_null(g_ooab_d[4].ooab002)  AND g_ooab_d[4].ooab002 <> g_ooab_d_t[4].ooab002  THEN  
                
                #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                INITIALIZE g_chkparam.* TO NULL
                #設定g_chkparam.*的參數
                LET g_chkparam.arg1 = g_ooab_d[4].ooab002
                #呼叫檢查存在的library
                IF NOT cl_chk_exist("v_ooal002_14") THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_ooab_d[4].ooab002
                  LET g_errparam.code   = "lib-00089"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_ooab_d[4].ooab002 = g_ooab_d_t[4].ooab002 #放回舊值
                  NEXT FIELD basic_base_4 
                END IF
                
            END IF
      




         BEFORE FIELD basic_base_5
            CALL apms010_show_field_help("ooab_t","S-BAS-0022")
 
         AFTER FIELD basic_base_5
         

         BEFORE FIELD basic_base_6
            CALL apms010_show_field_help("ooab_t","S-BAS-0043")
 
         AFTER FIELD basic_base_6
         

         BEFORE FIELD basic_base_7
            CALL apms010_show_field_help("ooab_t","S-BAS-0044")
 
         AFTER FIELD basic_base_7
         

         BEFORE FIELD basic_base_8
            CALL apms010_show_field_help("ooab_t","S-BAS-0045")
 
         AFTER FIELD basic_base_8
         

         BEFORE FIELD basic_base_9
            CALL apms010_show_field_help("ooab_t","S-BAS-0046")
 
         AFTER FIELD basic_base_9
         

         BEFORE FIELD basic_base_10
            CALL apms010_show_field_help("ooab_t","S-BAS-0033")
 
         AFTER FIELD basic_base_10

         BEFORE FIELD basic_base_11
            CALL apms010_show_field_help("ooab_t","S-BAS-0049")
 
         AFTER FIELD basic_base_11

         BEFORE FIELD basic_base_12
            CALL apms010_show_field_help("ooab_t","S-BAS-0050")
 
         AFTER FIELD basic_base_12

         BEFORE FIELD exchange_exchange_1
            CALL apms010_show_field_help("ooab_t","S-BAS-0014")
 
         AFTER FIELD exchange_exchange_1
         

         BEFORE FIELD exchange_exchange_2
            CALL apms010_show_field_help("ooab_t","S-BAS-0015")
 
         AFTER FIELD exchange_exchange_2
         

         BEFORE FIELD leadtime_leadtime_1
            CALL apms010_show_field_help("ooab_t","S-BAS-0024")
 
         AFTER FIELD leadtime_leadtime_1
         #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooab_d[15].ooab002,"0","1","999","1","azz-00087",1) THEN
               NEXT FIELD leadtime_leadtime_1
            END IF 



         #此段落由子樣板ss01產生
            IF NOT cl_null(g_ooab_d[15].ooab002) THEN
               LET ls_tmp = g_ooab_d[15].ooab002
               IF ls_tmp.getIndexOf(".",1) THEN                  
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.extend = g_ooab_d[15].ooab002
                   LET g_errparam.code   = "azz-00138"
                   LET g_errparam.popup  = TRUE
                   CALL cl_err()
                   NEXT FIELD leadtime_leadtime_1
               END IF   
            END IF


         

         BEFORE FIELD leadtime_leadtime_2
            CALL apms010_show_field_help("ooab_t","S-BAS-0025")
 
         AFTER FIELD leadtime_leadtime_2
         #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooab_d[16].ooab002,"0","1","999","1","azz-00087",1) THEN
               NEXT FIELD leadtime_leadtime_2
            END IF 



         #此段落由子樣板ss01產生
            IF NOT cl_null(g_ooab_d[16].ooab002) THEN
               LET ls_tmp = g_ooab_d[16].ooab002
               IF ls_tmp.getIndexOf(".",1) THEN                  
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.extend = g_ooab_d[16].ooab002
                   LET g_errparam.code   = "azz-00138"
                   LET g_errparam.popup  = TRUE
                   CALL cl_err()
                   NEXT FIELD leadtime_leadtime_2
               END IF   
            END IF


         

         BEFORE FIELD leadtime_leadtime_3
            CALL apms010_show_field_help("ooab_t","S-BAS-0026")
 
         AFTER FIELD leadtime_leadtime_3
         #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooab_d[17].ooab002,"0","1","999","1","azz-00087",1) THEN
               NEXT FIELD leadtime_leadtime_3
            END IF 



         #此段落由子樣板ss01產生
            IF NOT cl_null(g_ooab_d[17].ooab002) THEN
               LET ls_tmp = g_ooab_d[17].ooab002
               IF ls_tmp.getIndexOf(".",1) THEN                  
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.extend = g_ooab_d[17].ooab002
                   LET g_errparam.code   = "azz-00138"
                   LET g_errparam.popup  = TRUE
                   CALL cl_err()
                   NEXT FIELD leadtime_leadtime_3
               END IF   
            END IF


         

         BEFORE FIELD leadtime_leadtime_4
            CALL apms010_show_field_help("ooab_t","S-BAS-0027")
 
         AFTER FIELD leadtime_leadtime_4
         #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooab_d[18].ooab002,"0","1","999","1","azz-00087",1) THEN
               NEXT FIELD leadtime_leadtime_4
            END IF 



         #此段落由子樣板ss01產生
            IF NOT cl_null(g_ooab_d[18].ooab002) THEN
               LET ls_tmp = g_ooab_d[18].ooab002
               IF ls_tmp.getIndexOf(".",1) THEN                  
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.extend = g_ooab_d[18].ooab002
                   LET g_errparam.code   = "azz-00138"
                   LET g_errparam.popup  = TRUE
                   CALL cl_err()
                   NEXT FIELD leadtime_leadtime_4
               END IF   
            END IF


         

      
          
      ON ACTION controlp INFIELD basic_base_4
            #此段落由子樣板ss04產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooab_d[4].ooab002             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #${mdl_arg_desc1}

            CALL q_ooal002_14()                                #呼叫開窗

            LET g_ooab_d[4].ooab002 = g_qryparam.return1              

            DISPLAY g_ooab_d[4].ooab002 TO basic_base_4              #${mdl_desc$}

            NEXT FIELD basic_base_4                          #返回原欄位


      ON ACTION controlp INFIELD ooef001 
         CALL cl_site_select()
         LET g_ooef001 = g_site
         DISPLAY g_ooef001 TO ooef001
         CALL apms010_fill_data()
         CALL cl_ask_confirm3("adz-00541","") 
         INITIALIZE g_ref_fields TO NULL 
         LET g_ref_fields[1] = g_ooef001  CALL ap_ref_array2(g_ref_fields," SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields 
         LET ooef001_desc = '', g_rtn_fields[1] , '' 
         DISPLAY BY NAME ooef001_desc 
      END INPUT
 
      
      ON ACTION basic
         CALL apms010_parameter_switch("basic")
         NEXT FIELD basic_base_1
      ON ACTION exchange
         CALL apms010_parameter_switch("exchange")
         NEXT FIELD exchange_exchange_1
      ON ACTION leadtime
         CALL apms010_parameter_switch("leadtime")
         NEXT FIELD leadtime_leadtime_1
 
      
      ON ACTION btn_paramsubgp1_1
         CALL apms010_parameter_group_switch("paramsubgp1_1")
      ON ACTION btn_paramsubgp2_1
         CALL apms010_parameter_group_switch("paramsubgp2_1")
      ON ACTION btn_paramsubgp3_1
         CALL apms010_parameter_group_switch("paramsubgp3_1")
 
      # 以下為每一個欄位的說明功能鍵
      
      ON ACTION help_basic_base_1
         CALL apms010_show_field_help("ooab_t","S-BAS-0017")
      ON ACTION help_basic_base_2
         CALL apms010_show_field_help("ooab_t","S-BAS-0019")
      ON ACTION help_basic_base_3
         CALL apms010_show_field_help("ooab_t","S-BAS-0020")
      ON ACTION help_basic_base_4
         CALL apms010_show_field_help("ooab_t","S-BAS-0021")
      ON ACTION help_basic_base_5
         CALL apms010_show_field_help("ooab_t","S-BAS-0022")
      ON ACTION help_basic_base_6
         CALL apms010_show_field_help("ooab_t","S-BAS-0043")
      ON ACTION help_basic_base_7
         CALL apms010_show_field_help("ooab_t","S-BAS-0044")
      ON ACTION help_basic_base_8
         CALL apms010_show_field_help("ooab_t","S-BAS-0045")
      ON ACTION help_basic_base_9
         CALL apms010_show_field_help("ooab_t","S-BAS-0046")
      ON ACTION help_basic_base_10
         CALL apms010_show_field_help("ooab_t","S-BAS-0033")
      ON ACTION help_basic_base_11
         CALL apms010_show_field_help("ooab_t","S-BAS-0049")
      ON ACTION help_basic_base_12
         CALL apms010_show_field_help("ooab_t","S-BAS-0050")
      ON ACTION help_exchange_exchange_1
         CALL apms010_show_field_help("ooab_t","S-BAS-0014")
      ON ACTION help_exchange_exchange_2
         CALL apms010_show_field_help("ooab_t","S-BAS-0015")
      ON ACTION help_leadtime_leadtime_1
         CALL apms010_show_field_help("ooab_t","S-BAS-0024")
      ON ACTION help_leadtime_leadtime_2
         CALL apms010_show_field_help("ooab_t","S-BAS-0025")
      ON ACTION help_leadtime_leadtime_3
         CALL apms010_show_field_help("ooab_t","S-BAS-0026")
      ON ACTION help_leadtime_leadtime_4
         CALL apms010_show_field_help("ooab_t","S-BAS-0027")
 
       
      
      ON ACTION accept
         
         LET li_exit = FALSE
         ACCEPT DIALOG
 
      ON ACTION cancel
         # 返回舊值, 並顯示
         LET li_exit = TRUE
         CALL apms010_fill_data()   # 整體參數
         CALL apms010_show()
         EXIT DIALOG
   END DIALOG
 
   IF NOT li_exit THEN
      # 做存檔動作
      CALL apms010_update()
      
   END IF
 
END FUNCTION 
 
#+ 更新參數資料
PRIVATE FUNCTION apms010_update()
 
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE ls_sql  STRING
   DEFINE ls_tab  STRING
 
   FOR li_cnt = 1 TO g_ooab_d.getLength()
      #若新值與舊值不同,進行更新 #更新參數資料 
      IF (g_ooab_d[li_cnt].ooab002 IS NULL AND g_ooab_d_t[li_cnt].ooab002 IS NOT NULL) OR
         (g_ooab_d[li_cnt].ooab002 IS NOT NULL AND g_ooab_d_t[li_cnt].ooab002 IS NULL) OR
         (g_ooab_d[li_cnt].ooab002 IS NOT NULL AND g_ooab_d_t[li_cnt].ooab002 IS NOT NULL AND
          g_ooab_d[li_cnt].ooab002 <> g_ooab_d_t[li_cnt].ooab002 ) THEN
 
         LET ls_tab = g_gzsv[li_cnt].gzsv005 CLIPPED
         LET ls_tab = ls_tab.subString(1,ls_tab.getIndexOf("_t",1)-1)
         LET g_ooab_d[li_cnt].ooabmoddt = cl_get_current()
 
         LET ls_sql = " UPDATE ",ls_tab,"_t ",
                         " SET ",ls_tab,"002 = ?, ",
                                 ls_tab,"modid = ?, ",
                                 ls_tab,"moddt = ? ",
                       " WHERE ",ls_tab,"001 = ? "
                        ," AND ",ls_tab,"ent = ",g_enterprise ," AND ",ls_tab,"site = '",g_site CLIPPED,"'"
         PREPARE apms010_update_cs FROM ls_sql
         EXECUTE apms010_update_cs USING g_ooab_d[li_cnt].ooab002,g_user,
                                         g_ooab_d[li_cnt].ooabmoddt,
                                         g_ooab_d[li_cnt].ooab001
         FREE apms010_update_cs
 
         CALL cl_log_parameter_update(g_ooab_d[li_cnt].ooab001,g_site,g_ooab_d_t[li_cnt].ooab002,g_ooab_d[li_cnt].ooab002)
      END IF
   END FOR
 
END FUNCTION
 
#+ 抓取右側說明方塊
PRIVATE FUNCTION apms010_show_field_help(ps_tabid,ps_field)
   DEFINE ps_tabid       STRING
   DEFINE ps_field       STRING
   DEFINE ls_html        STRING
   DEFINE ls_title       STRING
   DEFINE ls_span_style  STRING 
   
   CALL cl_help_param_field(ps_tabid,ps_field) RETURNING g_helptitle, g_helpdesc
 
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
 
#+ 取得頁簽上的標註title
PRIVATE FUNCTION apms010_show_page_title(ps_paramid)
   DEFINE ps_paramid   STRING 
   DEFINE pc_gzswl004  LIKE gzswl_t.gzswl004
   DEFINE ls_sql       STRING 
 
   LET ls_sql = "SELECT gzswl004 FROM gzswl_t", 
                " WHERE gzswl001 = '", g_code ,"'" ,
                  " AND gzswl002 = '",ps_paramid,"'",
                  " AND gzswl003 = '",g_lang ,"'"
 
   PREPARE  apms010_show_page_title_pre FROM ls_sql  
   EXECUTE apms010_show_page_title_pre  INTO pc_gzswl004 
   FREE apms010_show_page_title_pre
 
   RETURN pc_gzswl004 
END FUNCTION 
