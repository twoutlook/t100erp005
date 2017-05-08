#該程式未解開Section, 採用最新樣板產出!
#應用 s01 樣板自動產生(Version:12)
# Filename.......: aoos020.4gl
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
   CALL cl_ap_init("aoo","")
 
   #作業初始化
   CALL aoos020_fill_data()   # 整體參數
 
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call name="main.servicecall"
      {<point name="main.servicecall" />}
      #end add-point
 
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aoos020 WITH FORM cl_ap_formpath("aoo",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL aoos020_init()
 
      #進入選單 Menu (="N")
      CALL aoos020_show()
      CALL aoos020_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      {<point name="main.before_close" />}
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aoos020
 
   END IF
 
   #add-point:作業離開前 name="main.exit"
   {<point name="main.exit" />}
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
 
END MAIN
 
 
PRIVATE FUNCTION aoos020_init()
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
   
    CALL cl_set_combo_scc('doctype_base_92','52') 
   CALL cl_set_combo_scc('doctype_base_95','53') 
   CALL cl_set_combo_scc('doctype_base_96','54') 
   CALL cl_set_combo_scc('doctype_base_97','53') 
   CALL cl_set_combo_scc('doctype_base_98','54') 
   CALL cl_set_combo_scc('sales_base_3','2095') 
   CALL cl_set_combo_scc('sales_exchange_1','40') 
   CALL cl_set_combo_scc('sales_exchange_2','40') 
   CALL cl_set_combo_scc('sales_exchange_4','40') 
   CALL cl_set_combo_scc('purchase_base_3','2047') 
   CALL cl_set_combo_scc('purchase_base_5','2094') 
   CALL cl_set_combo_scc('purchase_exchange_1','40') 
   CALL cl_set_combo_scc('purchase_exchange_2','40') 
   CALL cl_set_combo_scc('cirrection_autorepl_2','2005') 
   CALL cl_set_combo_scc('cirrection_autorepl_3','2005') 
   CALL cl_set_combo_scc('cirrection_autorepl_4','2005') 
   CALL cl_set_combo_scc('cirrection_counter_1','6845') 
   CALL cl_set_combo_scc('cirrection_counter_5','6846') 
   CALL cl_set_combo_scc('cirrection_counter_8','6873') 
   CALL cl_set_combo_scc('cirrection_counter_12','6871') 
   CALL cl_set_combo_scc('cirrection_rent_2','6919') 
   CALL cl_set_combo_scc('cirrection_rent_8','6919') 
   CALL cl_set_combo_scc('cirrection_rent_11','6929') 
   CALL cl_set_combo_scc('finance_axc_4','9601') 
   CALL cl_set_combo_scc('finance_axc_6','9602') 
   CALL cl_set_combo_scc('finance_axc_7','9604') 
   CALL cl_set_combo_scc('finance_axc_8','9603') 
   CALL cl_set_combo_scc('finance_axc_9','9605') 
   CALL cl_set_combo_scc('finance_axc_11','9605') 
   CALL cl_set_combo_scc('finance_axc_13','9607') 
   CALL cl_set_combo_scc('finance_axc_18','9606') 
   CALL cl_set_combo_scc('finance_axr_1','8336') 
   CALL cl_set_combo_scc('finance_axr_2','8309') 
   CALL cl_set_combo_scc('finance_axr_6','9742') 
   CALL cl_set_combo_scc('finance_axr_13','9995') 
   CALL cl_set_combo_scc('finance_axr_17','9750') 
   CALL cl_set_combo_scc('finance_aap_1','8336') 
   CALL cl_set_combo_scc('finance_aap_2','9742') 
   CALL cl_set_combo_scc('finance_aap_25','9995') 
   CALL cl_set_combo_scc('finance_anm_3','8728') 
   CALL cl_set_combo_scc('finance_anm_4','40') 
   CALL cl_set_combo_scc('finance_afa_1','9923') 
   CALL cl_set_combo_scc('finance_afa_6','9899') 
   CALL cl_set_combo_scc('finance_cit_3','8352') 
   CALL cl_set_combo_scc('manufactor_wo_1','4063') 
   CALL cl_set_combo_scc('manufactor_wo_3','201') 
   CALL cl_set_combo_scc('aps_base_1','5419') 
      
   CALL aoos020_area_information()
   CALL aoos020_parameter_switch("basic") 
   CALL aoos020_show_field_help("","")
 
END FUNCTION
 
# 指定各參數區塊資料 ( 方便切換參數內容 )
PRIVATE FUNCTION aoos020_area_information()
 
   
   LET g_parameter[1].id = "basic"
   LET g_parameter[1].name = "aoo-702"
   LET g_parameter[1].comp = "scrgr1"
   LET g_parameter[1].img = "24/s_setting.png"
   LET g_parameter[2].id = "doctype"
   LET g_parameter[2].name = "aoo-702"
   LET g_parameter[2].comp = "scrgr2"
   LET g_parameter[2].img = "24/s_setting.png"
   LET g_parameter[3].id = "aws"
   LET g_parameter[3].name = "aoo-702"
   LET g_parameter[3].comp = "scrgr3"
   LET g_parameter[3].img = "24/s_setting.png"
   LET g_parameter[4].id = "inv"
   LET g_parameter[4].name = "aoo-702"
   LET g_parameter[4].comp = "scrgr4"
   LET g_parameter[4].img = "24/s_setting.png"
   LET g_parameter[5].id = "sales"
   LET g_parameter[5].name = "aoo-702"
   LET g_parameter[5].comp = "scrgr5"
   LET g_parameter[5].img = "24/s_setting.png"
   LET g_parameter[6].id = "purchase"
   LET g_parameter[6].name = "aoo-702"
   LET g_parameter[6].comp = "scrgr6"
   LET g_parameter[6].img = "24/s_setting.png"
   LET g_parameter[7].id = "cirrection"
   LET g_parameter[7].name = "aoo-702"
   LET g_parameter[7].comp = "scrgr7"
   LET g_parameter[7].img = "24/s_setting.png"
   LET g_parameter[8].id = "finance"
   LET g_parameter[8].name = "aoo-702"
   LET g_parameter[8].comp = "scrgr8"
   LET g_parameter[8].img = "24/s_setting.png"
   LET g_parameter[9].id = "manufactor"
   LET g_parameter[9].name = "aoo-702"
   LET g_parameter[9].comp = "scrgr9"
   LET g_parameter[9].img = "24/s_setting.png"
   LET g_parameter[10].id = "APS"
   LET g_parameter[10].name = "aoo-702"
   LET g_parameter[10].comp = "scrgr10"
   LET g_parameter[10].img = "24/s_setting.png"
   LET g_parameter[11].id = "AQC"
   LET g_parameter[11].name = "aoo-702"
   LET g_parameter[11].comp = "scrgr11"
   LET g_parameter[11].img = "24/s_setting.png"
   LET g_parameter[12].id = "abx"
   LET g_parameter[12].name = "aoo-702"
   LET g_parameter[12].comp = "scrgr12"
   LET g_parameter[12].img = "24/s_setting.png"
   LET g_parameter[13].id = "abc"
   LET g_parameter[13].name = "aoo-702"
   LET g_parameter[13].comp = "scrgr13"
   LET g_parameter[13].img = "24/s_setting.png"
 
END FUNCTION
 
# 切換參數區塊 & 更換參數Title圖示文字
PRIVATE FUNCTION aoos020_parameter_switch(ps_paramid)
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
          CALL gfrm_curr.setElementText("page_parameterbox",aoos020_show_page_title(ps_paramid))   
          # 設定參數按鈕格式
          CALL gfrm_curr.setElementStyle(g_parameter[li_cnt].id, "menuitemfocus")
       END IF
   END FOR
 
END FUNCTION
 
 
# 子參數區塊開關
PRIVATE FUNCTION aoos020_parameter_group_switch(ps_paramgroup)
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
PRIVATE FUNCTION aoos020_ui_dialog()
   MENU ""
#     BEFORE MENU
#       CALL aoos020_modify()   #預設進入修改狀態
         
      ON ACTION modify
         LET g_action_choice="modify"
         IF cl_auth_chk_act("modify") THEN
            CALL aoos020_modify()
         END IF
 
      
      ON ACTION basic
         CALL aoos020_parameter_switch("basic")
      ON ACTION doctype
         CALL aoos020_parameter_switch("doctype")
      ON ACTION aws
         CALL aoos020_parameter_switch("aws")
      ON ACTION inv
         CALL aoos020_parameter_switch("inv")
      ON ACTION sales
         CALL aoos020_parameter_switch("sales")
      ON ACTION purchase
         CALL aoos020_parameter_switch("purchase")
      ON ACTION cirrection
         CALL aoos020_parameter_switch("cirrection")
      ON ACTION finance
         CALL aoos020_parameter_switch("finance")
      ON ACTION manufactor
         CALL aoos020_parameter_switch("manufactor")
      ON ACTION APS
         CALL aoos020_parameter_switch("APS")
      ON ACTION AQC
         CALL aoos020_parameter_switch("AQC")
      ON ACTION abx
         CALL aoos020_parameter_switch("abx")
      ON ACTION abc
         CALL aoos020_parameter_switch("abc")
 
      
      ON ACTION btn_paramsubgp1_1
         CALL aoos020_parameter_group_switch("paramsubgp1_1")
      ON ACTION btn_paramsubgp2_1
         CALL aoos020_parameter_group_switch("paramsubgp2_1")
      ON ACTION btn_paramsubgp3_1
         CALL aoos020_parameter_group_switch("paramsubgp3_1")
      ON ACTION btn_paramsubgp3_2
         CALL aoos020_parameter_group_switch("paramsubgp3_2")
      ON ACTION btn_paramsubgp3_3
         CALL aoos020_parameter_group_switch("paramsubgp3_3")
      ON ACTION btn_paramsubgp3_4
         CALL aoos020_parameter_group_switch("paramsubgp3_4")
      ON ACTION btn_paramsubgp3_5
         CALL aoos020_parameter_group_switch("paramsubgp3_5")
      ON ACTION btn_paramsubgp4_1
         CALL aoos020_parameter_group_switch("paramsubgp4_1")
      ON ACTION btn_paramsubgp5_1
         CALL aoos020_parameter_group_switch("paramsubgp5_1")
      ON ACTION btn_paramsubgp5_2
         CALL aoos020_parameter_group_switch("paramsubgp5_2")
      ON ACTION btn_paramsubgp6_1
         CALL aoos020_parameter_group_switch("paramsubgp6_1")
      ON ACTION btn_paramsubgp6_2
         CALL aoos020_parameter_group_switch("paramsubgp6_2")
      ON ACTION btn_paramsubgp6_3
         CALL aoos020_parameter_group_switch("paramsubgp6_3")
      ON ACTION btn_paramsubgp7_1
         CALL aoos020_parameter_group_switch("paramsubgp7_1")
      ON ACTION btn_paramsubgp7_2
         CALL aoos020_parameter_group_switch("paramsubgp7_2")
      ON ACTION btn_paramsubgp7_3
         CALL aoos020_parameter_group_switch("paramsubgp7_3")
      ON ACTION btn_paramsubgp7_4
         CALL aoos020_parameter_group_switch("paramsubgp7_4")
      ON ACTION btn_paramsubgp7_5
         CALL aoos020_parameter_group_switch("paramsubgp7_5")
      ON ACTION btn_paramsubgp7_6
         CALL aoos020_parameter_group_switch("paramsubgp7_6")
      ON ACTION btn_paramsubgp7_7
         CALL aoos020_parameter_group_switch("paramsubgp7_7")
      ON ACTION btn_paramsubgp8_1
         CALL aoos020_parameter_group_switch("paramsubgp8_1")
      ON ACTION btn_paramsubgp8_2
         CALL aoos020_parameter_group_switch("paramsubgp8_2")
      ON ACTION btn_paramsubgp8_3
         CALL aoos020_parameter_group_switch("paramsubgp8_3")
      ON ACTION btn_paramsubgp8_4
         CALL aoos020_parameter_group_switch("paramsubgp8_4")
      ON ACTION btn_paramsubgp8_5
         CALL aoos020_parameter_group_switch("paramsubgp8_5")
      ON ACTION btn_paramsubgp8_6
         CALL aoos020_parameter_group_switch("paramsubgp8_6")
      ON ACTION btn_paramsubgp8_7
         CALL aoos020_parameter_group_switch("paramsubgp8_7")
      ON ACTION btn_paramsubgp8_8
         CALL aoos020_parameter_group_switch("paramsubgp8_8")
      ON ACTION btn_paramsubgp9_1
         CALL aoos020_parameter_group_switch("paramsubgp9_1")
      ON ACTION btn_paramsubgp9_2
         CALL aoos020_parameter_group_switch("paramsubgp9_2")
      ON ACTION btn_paramsubgp10_1
         CALL aoos020_parameter_group_switch("paramsubgp10_1")
      ON ACTION btn_paramsubgp10_2
         CALL aoos020_parameter_group_switch("paramsubgp10_2")
      ON ACTION btn_paramsubgp10_3
         CALL aoos020_parameter_group_switch("paramsubgp10_3")
      ON ACTION btn_paramsubgp11_1
         CALL aoos020_parameter_group_switch("paramsubgp11_1")
      ON ACTION btn_paramsubgp12_1
         CALL aoos020_parameter_group_switch("paramsubgp12_1")
      ON ACTION btn_paramsubgp13_1
         CALL aoos020_parameter_group_switch("paramsubgp13_1")
 
      # 以下為每一個欄位的說明功能鍵
      
      ON ACTION help_basic_base_1
         CALL aoos020_show_field_help("ooab_t","S-SYS-0001")
      ON ACTION help_doctype_base_80
         CALL aoos020_show_field_help("ooab_t","S-COM-0002")
      ON ACTION help_doctype_base_92
         CALL aoos020_show_field_help("ooab_t","S-COM-0004")
      ON ACTION help_doctype_base_94
         CALL aoos020_show_field_help("ooab_t","S-COM-0006")
      ON ACTION help_doctype_base_95
         CALL aoos020_show_field_help("ooab_t","S-BAS-0029")
      ON ACTION help_doctype_base_96
         CALL aoos020_show_field_help("ooab_t","S-BAS-0030")
      ON ACTION help_doctype_base_97
         CALL aoos020_show_field_help("ooab_t","S-BAS-0031")
      ON ACTION help_doctype_base_98
         CALL aoos020_show_field_help("ooab_t","S-BAS-0032")
      ON ACTION help_aws_B2B_1
         CALL aoos020_show_field_help("ooab_t","S-SYS-0002")
      ON ACTION help_aws_MES_1
         CALL aoos020_show_field_help("ooab_t","S-SYS-0003")
      ON ACTION help_aws_HRM_1
         CALL aoos020_show_field_help("ooab_t","S-SYS-0004")
      ON ACTION help_aws_Light_1
         CALL aoos020_show_field_help("ooab_t","S-SYS-0005")
      ON ACTION help_aws_EBCHAIN_1
         CALL aoos020_show_field_help("ooab_t","S-SYS-0006")
      ON ACTION help_inv_Base_1
         CALL aoos020_show_field_help("ooab_t","S-BAS-0028")
      ON ACTION help_inv_Base_2
         CALL aoos020_show_field_help("ooab_t","S-BAS-0036")
      ON ACTION help_inv_Base_5
         CALL aoos020_show_field_help("ooab_t","S-MFG-0031")
      ON ACTION help_sales_base_2
         CALL aoos020_show_field_help("ooab_t","S-BAS-0018")
      ON ACTION help_sales_base_3
         CALL aoos020_show_field_help("ooab_t","S-BAS-0023")
      ON ACTION help_sales_base_4
         CALL aoos020_show_field_help("ooab_t","S-BAS-0007")
      ON ACTION help_sales_base_5
         CALL aoos020_show_field_help("ooab_t","S-BAS-0034")
      ON ACTION help_sales_base_6
         CALL aoos020_show_field_help("ooab_t","S-BAS-0047")
      ON ACTION help_sales_base_7
         CALL aoos020_show_field_help("ooab_t","S-BAS-0051")
      ON ACTION help_sales_base_8
         CALL aoos020_show_field_help("ooab_t","S-BAS-0048")
      ON ACTION help_sales_base_9
         CALL aoos020_show_field_help("ooab_t","S-BAS-0009")
      ON ACTION help_sales_exchange_1
         CALL aoos020_show_field_help("ooab_t","S-BAS-0010")
      ON ACTION help_sales_exchange_2
         CALL aoos020_show_field_help("ooab_t","S-BAS-0011")
      ON ACTION help_sales_exchange_4
         CALL aoos020_show_field_help("ooab_t","S-BAS-0013")
      ON ACTION help_purchase_base_1
         CALL aoos020_show_field_help("ooab_t","S-BAS-0017")
      ON ACTION help_purchase_base_2
         CALL aoos020_show_field_help("ooab_t","S-BAS-0019")
      ON ACTION help_purchase_base_3
         CALL aoos020_show_field_help("ooab_t","S-BAS-0020")
      ON ACTION help_purchase_base_4
         CALL aoos020_show_field_help("ooab_t","S-BAS-0021")
      ON ACTION help_purchase_base_5
         CALL aoos020_show_field_help("ooab_t","S-BAS-0022")
      ON ACTION help_purchase_base_6
         CALL aoos020_show_field_help("ooab_t","S-BAS-0043")
      ON ACTION help_purchase_base_7
         CALL aoos020_show_field_help("ooab_t","S-BAS-0044")
      ON ACTION help_purchase_base_8
         CALL aoos020_show_field_help("ooab_t","S-BAS-0045")
      ON ACTION help_purchase_base_9
         CALL aoos020_show_field_help("ooab_t","S-BAS-0046")
      ON ACTION help_purchase_base_10
         CALL aoos020_show_field_help("ooab_t","S-BAS-0033")
      ON ACTION help_purchase_base_11
         CALL aoos020_show_field_help("ooab_t","S-BAS-0049")
      ON ACTION help_purchase_base_12
         CALL aoos020_show_field_help("ooab_t","S-BAS-0050")
      ON ACTION help_purchase_exchange_1
         CALL aoos020_show_field_help("ooab_t","S-BAS-0014")
      ON ACTION help_purchase_exchange_2
         CALL aoos020_show_field_help("ooab_t","S-BAS-0015")
      ON ACTION help_purchase_leadtime_1
         CALL aoos020_show_field_help("ooab_t","S-BAS-0024")
      ON ACTION help_purchase_leadtime_2
         CALL aoos020_show_field_help("ooab_t","S-BAS-0025")
      ON ACTION help_purchase_leadtime_3
         CALL aoos020_show_field_help("ooab_t","S-BAS-0026")
      ON ACTION help_purchase_leadtime_4
         CALL aoos020_show_field_help("ooab_t","S-BAS-0027")
      ON ACTION help_cirrection_base_1
         CALL aoos020_show_field_help("ooab_t","S-CIR-0003")
      ON ACTION help_cirrection_base_2
         CALL aoos020_show_field_help("ooab_t","S-CIR-0001")
      ON ACTION help_cirrection_base_7
         CALL aoos020_show_field_help("ooab_t","S-BAS-0035")
      ON ACTION help_cirrection_base_8
         CALL aoos020_show_field_help("ooab_t","S-CIR-2008")
      ON ACTION help_cirrection_base_9
         CALL aoos020_show_field_help("ooab_t","S-CIR-2015")
      ON ACTION help_cirrection_base_10
         CALL aoos020_show_field_help("ooab_t","S-CIR-2037")
      ON ACTION help_cirrection_autorepl_1
         CALL aoos020_show_field_help("ooab_t","S-CIR-1000")
      ON ACTION help_cirrection_autorepl_2
         CALL aoos020_show_field_help("ooab_t","S-CIR-1001")
      ON ACTION help_cirrection_autorepl_3
         CALL aoos020_show_field_help("ooab_t","S-CIR-1002")
      ON ACTION help_cirrection_autorepl_4
         CALL aoos020_show_field_help("ooab_t","S-CIR-1003")
      ON ACTION help_cirrection_shelf_1
         CALL aoos020_show_field_help("ooab_t","S-CIR-2000")
      ON ACTION help_cirrection_shelf_2
         CALL aoos020_show_field_help("ooab_t","S-CIR-2001")
      ON ACTION help_cirrection_shelf_3
         CALL aoos020_show_field_help("ooab_t","S-CIR-2002")
      ON ACTION help_cirrection_counter_1
         CALL aoos020_show_field_help("ooab_t","S-CIR-2003")
      ON ACTION help_cirrection_counter_2
         CALL aoos020_show_field_help("ooab_t","S-CIR-2004")
      ON ACTION help_cirrection_counter_3
         CALL aoos020_show_field_help("ooab_t","S-CIR-2005")
      ON ACTION help_cirrection_counter_4
         CALL aoos020_show_field_help("ooab_t","S-CIR-2006")
      ON ACTION help_cirrection_counter_5
         CALL aoos020_show_field_help("ooab_t","S-CIR-2007")
      ON ACTION help_cirrection_counter_6
         CALL aoos020_show_field_help("ooab_t","S-CIR-2009")
      ON ACTION help_cirrection_counter_7
         CALL aoos020_show_field_help("ooab_t","S-CIR-2010")
      ON ACTION help_cirrection_counter_8
         CALL aoos020_show_field_help("ooab_t","S-CIR-2011")
      ON ACTION help_cirrection_counter_9
         CALL aoos020_show_field_help("ooab_t","S-CIR-2012")
      ON ACTION help_cirrection_counter_10
         CALL aoos020_show_field_help("ooab_t","S-CIR-2013")
      ON ACTION help_cirrection_counter_11
         CALL aoos020_show_field_help("ooab_t","S-CIR-2014")
      ON ACTION help_cirrection_counter_12
         CALL aoos020_show_field_help("ooab_t","S-CIR-2016")
      ON ACTION help_cirrection_counter_13
         CALL aoos020_show_field_help("ooab_t","S-CIR-2017")
      ON ACTION help_cirrection_stock_1
         CALL aoos020_show_field_help("ooab_t","S-CIR-2018")
      ON ACTION help_cirrection_stock_2
         CALL aoos020_show_field_help("ooab_t","S-CIR-2036")
      ON ACTION help_cirrection_rent_1
         CALL aoos020_show_field_help("ooab_t","S-CIR-2019")
      ON ACTION help_cirrection_rent_2
         CALL aoos020_show_field_help("ooab_t","S-CIR-2020")
      ON ACTION help_cirrection_rent_3
         CALL aoos020_show_field_help("ooab_t","S-CIR-2021")
      ON ACTION help_cirrection_rent_4
         CALL aoos020_show_field_help("ooab_t","S-CIR-2022")
      ON ACTION help_cirrection_rent_5
         CALL aoos020_show_field_help("ooab_t","S-CIR-2023")
      ON ACTION help_cirrection_rent_6
         CALL aoos020_show_field_help("ooab_t","S-CIR-2024")
      ON ACTION help_cirrection_rent_7
         CALL aoos020_show_field_help("ooab_t","S-CIR-2025")
      ON ACTION help_cirrection_rent_8
         CALL aoos020_show_field_help("ooab_t","S-CIR-2026")
      ON ACTION help_cirrection_rent_9
         CALL aoos020_show_field_help("ooab_t","S-CIR-2027")
      ON ACTION help_cirrection_rent_10
         CALL aoos020_show_field_help("ooab_t","S-CIR-2028")
      ON ACTION help_cirrection_rent_11
         CALL aoos020_show_field_help("ooab_t","S-CIR-2030")
      ON ACTION help_cirrection_rent_12
         CALL aoos020_show_field_help("ooab_t","S-CIR-2031")
      ON ACTION help_cirrection_rent_13
         CALL aoos020_show_field_help("ooab_t","S-CIR-2032")
      ON ACTION help_cirrection_rent_14
         CALL aoos020_show_field_help("ooab_t","S-CIR-2033")
      ON ACTION help_cirrection_rent_15
         CALL aoos020_show_field_help("ooab_t","S-CIR-2034")
      ON ACTION help_cirrection_rent_16
         CALL aoos020_show_field_help("ooab_t","S-CIR-2035")
      ON ACTION help_cirrection_distribution_1
         CALL aoos020_show_field_help("ooab_t","S-CIR-2029")
      ON ACTION help_finance_AXC_1
         CALL aoos020_show_field_help("ooab_t","S-FIN-6015")
      ON ACTION help_finance_AXC_2
         CALL aoos020_show_field_help("ooab_t","S-FIN-6013")
      ON ACTION help_finance_AXC_3
         CALL aoos020_show_field_help("ooab_t","S-FIN-6001")
      ON ACTION help_finance_AXC_4
         CALL aoos020_show_field_help("ooab_t","S-FIN-6002")
      ON ACTION help_finance_AXC_5
         CALL aoos020_show_field_help("ooab_t","S-FIN-6003")
      ON ACTION help_finance_AXC_6
         CALL aoos020_show_field_help("ooab_t","S-FIN-6004")
      ON ACTION help_finance_AXC_7
         CALL aoos020_show_field_help("ooab_t","S-FIN-6006")
      ON ACTION help_finance_AXC_8
         CALL aoos020_show_field_help("ooab_t","S-FIN-6005")
      ON ACTION help_finance_AXC_9
         CALL aoos020_show_field_help("ooab_t","S-FIN-6007")
      ON ACTION help_finance_AXC_10
         CALL aoos020_show_field_help("ooab_t","S-FIN-6023")
      ON ACTION help_finance_AXC_11
         CALL aoos020_show_field_help("ooab_t","S-FIN-6024")
      ON ACTION help_finance_AXC_13
         CALL aoos020_show_field_help("ooab_t","S-FIN-6014")
      ON ACTION help_finance_AXC_14
         CALL aoos020_show_field_help("ooab_t","S-FIN-6016")
      ON ACTION help_finance_AXC_16
         CALL aoos020_show_field_help("ooab_t","S-FIN-6008")
      ON ACTION help_finance_AXC_17
         CALL aoos020_show_field_help("ooab_t","S-FIN-6022")
      ON ACTION help_finance_AXC_18
         CALL aoos020_show_field_help("ooab_t","S-FIN-6009")
      ON ACTION help_finance_AXC_19
         CALL aoos020_show_field_help("ooab_t","S-FIN-6017")
      ON ACTION help_finance_AXC_32
         CALL aoos020_show_field_help("ooab_t","S-FIN-6018")
      ON ACTION help_finance_AXC_33
         CALL aoos020_show_field_help("ooab_t","S-FIN-6019")
      ON ACTION help_finance_AXC_35
         CALL aoos020_show_field_help("ooab_t","S-FIN-6020")
      ON ACTION help_finance_AXC_36
         CALL aoos020_show_field_help("ooab_t","S-FIN-6021")
      ON ACTION help_finance_AXC_37
         CALL aoos020_show_field_help("ooab_t","S-FIN-6012")
      ON ACTION help_finance_AXC_38
         CALL aoos020_show_field_help("ooab_t","S-FIN-6010")
      ON ACTION help_finance_AXC_39
         CALL aoos020_show_field_help("ooab_t","S-FIN-6011")
      ON ACTION help_finance_AGL_1
         CALL aoos020_show_field_help("ooab_t","S-FIN-0001")
      ON ACTION help_finance_AGL_2
         CALL aoos020_show_field_help("ooab_t","S-FIN-0002")
      ON ACTION help_finance_AXR_1
         CALL aoos020_show_field_help("ooab_t","S-FIN-1002")
      ON ACTION help_finance_AXR_2
         CALL aoos020_show_field_help("ooab_t","S-FIN-1003")
      ON ACTION help_finance_AXR_3
         CALL aoos020_show_field_help("ooab_t","S-FIN-1004")
      ON ACTION help_finance_AXR_4
         CALL aoos020_show_field_help("ooab_t","S-FIN-1005")
      ON ACTION help_finance_AXR_5
         CALL aoos020_show_field_help("ooab_t","S-FIN-1006")
      ON ACTION help_finance_AXR_6
         CALL aoos020_show_field_help("ooab_t","S-FIN-2012")
      ON ACTION help_finance_AXR_7
         CALL aoos020_show_field_help("ooab_t","S-FIN-2010")
      ON ACTION help_finance_AXR_8
         CALL aoos020_show_field_help("ooab_t","S-FIN-2011")
      ON ACTION help_finance_AXR_9
         CALL aoos020_show_field_help("ooab_t","S-FIN-2007")
      ON ACTION help_finance_AXR_10
         CALL aoos020_show_field_help("ooab_t","S-FIN-2013")
      ON ACTION help_finance_AXR_12
         CALL aoos020_show_field_help("ooab_t","S-FIN-2017")
      ON ACTION help_finance_AXR_13
         CALL aoos020_show_field_help("ooab_t","S-FIN-2009")
      ON ACTION help_finance_AXR_14
         CALL aoos020_show_field_help("ooab_t","S-FIN-2020")
      ON ACTION help_finance_AXR_15
         CALL aoos020_show_field_help("ooab_t","S-FIN-2019")
      ON ACTION help_finance_AXR_16
         CALL aoos020_show_field_help("ooab_t","S-FIN-2021")
      ON ACTION help_finance_AXR_17
         CALL aoos020_show_field_help("ooab_t","S-FIN-2022")
      ON ACTION help_finance_AXR_18
         CALL aoos020_show_field_help("ooab_t","S-FIN-2024")
      ON ACTION help_finance_AAP_1
         CALL aoos020_show_field_help("ooab_t","S-FIN-2002")
      ON ACTION help_finance_AAP_2
         CALL aoos020_show_field_help("ooab_t","S-FIN-3012")
      ON ACTION help_finance_AAP_3
         CALL aoos020_show_field_help("ooab_t","S-FIN-3010")
      ON ACTION help_finance_AAP_4
         CALL aoos020_show_field_help("ooab_t","S-FIN-3011")
      ON ACTION help_finance_AAP_10
         CALL aoos020_show_field_help("ooab_t","S-FIN-3003")
      ON ACTION help_finance_AAP_11
         CALL aoos020_show_field_help("ooab_t","S-FIN-3004")
      ON ACTION help_finance_AAP_12
         CALL aoos020_show_field_help("ooab_t","S-FIN-3005")
      ON ACTION help_finance_AAP_13
         CALL aoos020_show_field_help("ooab_t","S-FIN-3006")
      ON ACTION help_finance_AAP_21
         CALL aoos020_show_field_help("ooab_t","S-FIN-3007")
      ON ACTION help_finance_AAP_22
         CALL aoos020_show_field_help("ooab_t","S-FIN-3008")
      ON ACTION help_finance_AAP_23
         CALL aoos020_show_field_help("ooab_t","S-FIN-3015")
      ON ACTION help_finance_AAP_25
         CALL aoos020_show_field_help("ooab_t","S-FIN-3009")
      ON ACTION help_finance_AAP_26
         CALL aoos020_show_field_help("ooab_t","S-FIN-3020")
      ON ACTION help_finance_AAP_27
         CALL aoos020_show_field_help("ooab_t","S-FIN-3017")
      ON ACTION help_finance_AAP_28
         CALL aoos020_show_field_help("ooab_t","S-FIN-3018")
      ON ACTION help_finance_AAP_29
         CALL aoos020_show_field_help("ooab_t","S-FIN-3019")
      ON ACTION help_finance_AAP_30
         CALL aoos020_show_field_help("ooab_t","S-FIN-3021")
      ON ACTION help_finance_ANM_1
         CALL aoos020_show_field_help("ooab_t","S-FIN-4001")
      ON ACTION help_finance_ANM_2
         CALL aoos020_show_field_help("ooab_t","S-FIN-4007")
      ON ACTION help_finance_ANM_3
         CALL aoos020_show_field_help("ooab_t","S-FIN-4012")
      ON ACTION help_finance_ANM_4
         CALL aoos020_show_field_help("ooab_t","S-FIN-4004")
      ON ACTION help_finance_ANM_5
         CALL aoos020_show_field_help("ooab_t","S-FIN-4008")
      ON ACTION help_finance_ANM_6
         CALL aoos020_show_field_help("ooab_t","S-FIN-4009")
      ON ACTION help_finance_ANM_7
         CALL aoos020_show_field_help("ooab_t","S-FIN-4010")
      ON ACTION help_finance_ANM_8
         CALL aoos020_show_field_help("ooab_t","S-FIN-4011")
      ON ACTION help_finance_ANM_9
         CALL aoos020_show_field_help("ooab_t","S-FIN-3016")
      ON ACTION help_finance_ANM_10
         CALL aoos020_show_field_help("ooab_t","S-FIN-4015")
      ON ACTION help_finance_ANM_11
         CALL aoos020_show_field_help("ooab_t","S-FIN-4016")
      ON ACTION help_finance_AFM_1
         CALL aoos020_show_field_help("ooab_t","S-FIN-4013")
      ON ACTION help_finance_AFM_2
         CALL aoos020_show_field_help("ooab_t","S-FIN-4014")
      ON ACTION help_finance_AFA_1
         CALL aoos020_show_field_help("ooab_t","S-FIN-9009")
      ON ACTION help_finance_AFA_2
         CALL aoos020_show_field_help("ooab_t","S-FIN-9005")
      ON ACTION help_finance_AFA_3
         CALL aoos020_show_field_help("ooab_t","S-FIN-9002")
      ON ACTION help_finance_AFA_4
         CALL aoos020_show_field_help("ooab_t","S-FIN-9010")
      ON ACTION help_finance_AFA_5
         CALL aoos020_show_field_help("ooab_t","S-FIN-9003")
      ON ACTION help_finance_AFA_6
         CALL aoos020_show_field_help("ooab_t","S-FIN-9016")
      ON ACTION help_finance_AFA_7
         CALL aoos020_show_field_help("ooab_t","S-FIN-9017")
      ON ACTION help_finance_AFA_8
         CALL aoos020_show_field_help("ooab_t","S-FIN-9015")
      ON ACTION help_finance_AFA_9
         CALL aoos020_show_field_help("ooab_t","S-FIN-9018")
      ON ACTION help_finance_AFA_10
         CALL aoos020_show_field_help("ooab_t","S-FIN-9019")
      ON ACTION help_finance_CIT_1
         CALL aoos020_show_field_help("ooab_t","S-FIN-7001")
      ON ACTION help_finance_CIT_2
         CALL aoos020_show_field_help("ooab_t","S-FIN-7002")
      ON ACTION help_finance_CIT_3
         CALL aoos020_show_field_help("ooab_t","S-FIN-2023")
      ON ACTION help_manufactor_wo_1
         CALL aoos020_show_field_help("ooab_t","S-MFG-0056")
      ON ACTION help_manufactor_wo_2
         CALL aoos020_show_field_help("ooab_t","S-MFG-0055")
      ON ACTION help_manufactor_wo_3
         CALL aoos020_show_field_help("ooab_t","S-MFG-0002")
      ON ACTION help_manufactor_routing_1
         CALL aoos020_show_field_help("ooab_t","S-MFG-0033")
      ON ACTION help_manufactor_routing_2
         CALL aoos020_show_field_help("ooab_t","S-MFG-0035")
      ON ACTION help_APS_base_1
         CALL aoos020_show_field_help("ooab_t","S-MFG-0036")
      ON ACTION help_APS_base_2
         CALL aoos020_show_field_help("ooab_t","S-MFG-0039")
      ON ACTION help_APS_aps_runtime_1
         CALL aoos020_show_field_help("ooab_t","S-MFG-0050")
      ON ACTION help_APS_aps_runtime_2
         CALL aoos020_show_field_help("ooab_t","S-MFG-0052")
      ON ACTION help_APS_aps_runtime_3
         CALL aoos020_show_field_help("ooab_t","S-MFG-0053")
      ON ACTION help_APS_aps_runtime_4
         CALL aoos020_show_field_help("ooab_t","S-MFG-0054")
      ON ACTION help_APS_apsadv_1
         CALL aoos020_show_field_help("ooab_t","S-MFG-0057")
      ON ACTION help_APS_apsadv_2
         CALL aoos020_show_field_help("ooab_t","S-MFG-0058")
      ON ACTION help_APS_apsadv_3
         CALL aoos020_show_field_help("ooab_t","S-MFG-0059")
      ON ACTION help_APS_apsadv_4
         CALL aoos020_show_field_help("ooab_t","S-MFG-0063")
      ON ACTION help_APS_apsadv_5
         CALL aoos020_show_field_help("ooab_t","S-MFG-0064")
      ON ACTION help_APS_apsadv_6
         CALL aoos020_show_field_help("ooab_t","S-MFG-0060")
      ON ACTION help_APS_apsadv_7
         CALL aoos020_show_field_help("ooab_t","S-MFG-0061")
      ON ACTION help_APS_apsadv_8
         CALL aoos020_show_field_help("ooab_t","S-MFG-0062")
      ON ACTION help_AQC_base_1
         CALL aoos020_show_field_help("ooab_t","S-MFG-0046")
      ON ACTION help_abx_base_1
         CALL aoos020_show_field_help("ooab_t","S-MFG-0065")
      ON ACTION help_abx_base_2
         CALL aoos020_show_field_help("ooab_t","S-MFG-0066")
      ON ACTION help_abx_base_3
         CALL aoos020_show_field_help("ooab_t","S-MFG-0067")
      ON ACTION help_abx_base_4
         CALL aoos020_show_field_help("ooab_t","S-MFG-0068")
      ON ACTION help_abx_base_5
         CALL aoos020_show_field_help("ooab_t","S-MFG-0069")
      ON ACTION help_abx_base_6
         CALL aoos020_show_field_help("ooab_t","S-MFG-0070")
      ON ACTION help_abx_base_7
         CALL aoos020_show_field_help("ooab_t","S-MFG-0071")
      ON ACTION help_abx_base_8
         CALL aoos020_show_field_help("ooab_t","S-MFG-0072")
      ON ACTION help_abx_base_9
         CALL aoos020_show_field_help("ooab_t","S-MFG-0074")
      ON ACTION help_abc_bcse_1
         CALL aoos020_show_field_help("ooab_t","S-APP-0001")
      ON ACTION help_abc_bcse_2
         CALL aoos020_show_field_help("ooab_t","S-APP-0012")
      ON ACTION help_abc_bcse_3
         CALL aoos020_show_field_help("ooab_t","S-APP-0009")
      ON ACTION help_abc_bcse_4
         CALL aoos020_show_field_help("ooab_t","S-APP-0010")
      ON ACTION help_abc_bcse_5
         CALL aoos020_show_field_help("ooab_t","S-APP-0008")
      ON ACTION help_abc_bcse_6
         CALL aoos020_show_field_help("ooab_t","S-APP-0011")
      ON ACTION help_abc_bcse_7
         CALL aoos020_show_field_help("ooab_t","S-APP-0002")
      ON ACTION help_abc_bcse_8
         CALL aoos020_show_field_help("ooab_t","S-APP-0003")
      ON ACTION help_abc_bcse_9
         CALL aoos020_show_field_help("ooab_t","S-APP-0004")
      ON ACTION help_abc_bcse_10
         CALL aoos020_show_field_help("ooab_t","S-APP-0005")
      ON ACTION help_abc_bcse_11
         CALL aoos020_show_field_help("ooab_t","S-APP-0006")
      ON ACTION help_abc_bcse_12
         CALL aoos020_show_field_help("ooab_t","S-APP-0007")
 
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
PRIVATE FUNCTION aoos020_fill_data()
   DEFINE ls_sql     STRING
   DEFINE li_cnt     LIKE type_t.num5
 
   LET ls_sql = " SELECT gzsv005,gzsv006 FROM gzsv_t,gzsx_t ",
                 " WHERE gzsv001 = 'aoos020' ",   #程式編號
                   " AND gzsx001 = gzsv001 ",     #作業名稱
                   " AND gzsx002 = gzsv002 ",     #分頁編號
                   " AND gzsx003 = gzsv003 ",     #分項編號
                 #" ORDER BY gzsx004,gzsx005,gzsv004"
                 " ORDER BY gzsx004,gzsx002,gzsx005,gzsx003,gzsv004 "
 
   CALL g_gzsv.clear()
   DECLARE aoos020_fill_data_cs CURSOR FROM ls_sql
   LET li_cnt = 1
   FOREACH aoos020_fill_data_cs INTO g_gzsv[li_cnt].*
      CALL aoos020_fill_detail(li_cnt,g_gzsv[li_cnt].gzsv005,g_gzsv[li_cnt].gzsv006)
      LET li_cnt = li_cnt + 1
   END FOREACH
   CALL g_gzsv.deleteElement(li_cnt)
 
   CLOSE aoos020_fill_data_cs 
   FREE aoos020_fill_data_cs 
 
END FUNCTION
 
#+ 填寫細項
PRIVATE FUNCTION aoos020_fill_detail(li_cnt,lc_gzsv005,lc_gzsv006)
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
 
   PREPARE aoos020_fill_detail_cs FROM ls_sql
   
   LET ls_sql = "SELECT COUNT(1) FROM gzsv_t ",
                 "WHERE gzsv001 = 'aoos020' ",
                 "  AND gzsv006 = ? " 
   PREPARE aoos020_cnt_detail_cs FROM ls_sql 
   EXECUTE aoos020_cnt_detail_cs USING lc_gzsv006 INTO li_cnt2
   FREE aoos020_cnt_detail_cs
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
   PREPARE aoos020_ins_detail_cs FROM ls_sql 
   
   EXECUTE aoos020_fill_detail_cs USING lc_gzsv006 INTO g_ooab_d[li_cnt].*
   IF SQLCA.SQLCODE = 100 THEN
      LET ls_sql = "SELECT gzsz008 FROM gzsz_t",
                   " WHERE gzsz001 = '",ls_tab,"_t'",
                     " AND gzsz002 = '",lc_gzsv006,"'"
      
      PREPARE aoos020_sel_detail_cs FROM ls_sql
      EXECUTE aoos020_sel_detail_cs INTO lc_gzsz008
  
      EXECUTE aoos020_ins_detail_cs USING lc_gzsv006,lc_gzsz008,g_enterprise,g_site
      LET g_ooab_d[li_cnt].ooab002 = lc_gzsz008
   END IF 
 
   FREE aoos020_fill_detail_cs
   FREE aoos020_ins_detail_cs
   FREE aoos020_sel_detail_cs   
END FUNCTION
 
#+ 顯示畫面
PRIVATE FUNCTION aoos020_show()
 
   DISPLAY g_ooab_d[1].ooab002,g_ooab_d[2].ooab002,g_ooab_d[3].ooab002,g_ooab_d[4].ooab002,g_ooab_d[5].ooab002,
      g_ooab_d[6].ooab002,g_ooab_d[7].ooab002,g_ooab_d[8].ooab002,g_ooab_d[9].ooab002,g_ooab_d[10].ooab002,
      g_ooab_d[11].ooab002,g_ooab_d[12].ooab002,g_ooab_d[13].ooab002,g_ooab_d[14].ooab002,g_ooab_d[15].ooab002,
      g_ooab_d[16].ooab002,g_ooab_d[17].ooab002,g_ooab_d[18].ooab002,g_ooab_d[19].ooab002,g_ooab_d[20].ooab002,
      g_ooab_d[21].ooab002,g_ooab_d[22].ooab002,g_ooab_d[23].ooab002,g_ooab_d[24].ooab002,g_ooab_d[25].ooab002,
      g_ooab_d[26].ooab002,g_ooab_d[27].ooab002,g_ooab_d[28].ooab002,g_ooab_d[29].ooab002,g_ooab_d[30].ooab002,
      g_ooab_d[31].ooab002,g_ooab_d[32].ooab002,g_ooab_d[33].ooab002,g_ooab_d[34].ooab002,g_ooab_d[35].ooab002,
      g_ooab_d[36].ooab002,g_ooab_d[37].ooab002,g_ooab_d[38].ooab002,g_ooab_d[39].ooab002,g_ooab_d[40].ooab002,
      g_ooab_d[41].ooab002,g_ooab_d[42].ooab002,g_ooab_d[43].ooab002,g_ooab_d[44].ooab002,g_ooab_d[45].ooab002,
      g_ooab_d[46].ooab002,g_ooab_d[47].ooab002,g_ooab_d[48].ooab002,g_ooab_d[49].ooab002,g_ooab_d[50].ooab002,
      g_ooab_d[51].ooab002,g_ooab_d[52].ooab002,g_ooab_d[53].ooab002,g_ooab_d[54].ooab002,g_ooab_d[55].ooab002,
      g_ooab_d[56].ooab002,g_ooab_d[57].ooab002,g_ooab_d[58].ooab002,g_ooab_d[59].ooab002,g_ooab_d[60].ooab002,
      g_ooab_d[61].ooab002,g_ooab_d[62].ooab002,g_ooab_d[63].ooab002,g_ooab_d[64].ooab002,g_ooab_d[65].ooab002,
      g_ooab_d[66].ooab002,g_ooab_d[67].ooab002,g_ooab_d[68].ooab002,g_ooab_d[69].ooab002,g_ooab_d[70].ooab002,
      g_ooab_d[71].ooab002,g_ooab_d[72].ooab002,g_ooab_d[73].ooab002,g_ooab_d[74].ooab002,g_ooab_d[75].ooab002,
      g_ooab_d[76].ooab002,g_ooab_d[77].ooab002,g_ooab_d[78].ooab002,g_ooab_d[79].ooab002,g_ooab_d[80].ooab002,
      g_ooab_d[81].ooab002,g_ooab_d[82].ooab002,g_ooab_d[83].ooab002,g_ooab_d[84].ooab002,g_ooab_d[85].ooab002,
      g_ooab_d[86].ooab002,g_ooab_d[87].ooab002,g_ooab_d[88].ooab002,g_ooab_d[89].ooab002,g_ooab_d[90].ooab002,
      g_ooab_d[91].ooab002,g_ooab_d[92].ooab002,g_ooab_d[93].ooab002,g_ooab_d[94].ooab002,g_ooab_d[95].ooab002,
      g_ooab_d[96].ooab002,g_ooab_d[97].ooab002,g_ooab_d[98].ooab002,g_ooab_d[99].ooab002,g_ooab_d[100].ooab002,
      g_ooab_d[101].ooab002,g_ooab_d[102].ooab002,g_ooab_d[103].ooab002,g_ooab_d[104].ooab002,g_ooab_d[105].ooab002,
      g_ooab_d[106].ooab002,g_ooab_d[107].ooab002,g_ooab_d[108].ooab002,g_ooab_d[109].ooab002,g_ooab_d[110].ooab002,
      g_ooab_d[111].ooab002,g_ooab_d[112].ooab002,g_ooab_d[113].ooab002,g_ooab_d[114].ooab002,g_ooab_d[115].ooab002,
      g_ooab_d[116].ooab002,g_ooab_d[117].ooab002,g_ooab_d[118].ooab002,g_ooab_d[119].ooab002,g_ooab_d[120].ooab002,
      g_ooab_d[121].ooab002,g_ooab_d[122].ooab002,g_ooab_d[123].ooab002,g_ooab_d[124].ooab002,g_ooab_d[125].ooab002,
      g_ooab_d[126].ooab002,g_ooab_d[127].ooab002,g_ooab_d[128].ooab002,g_ooab_d[129].ooab002,g_ooab_d[130].ooab002,
      g_ooab_d[131].ooab002,g_ooab_d[132].ooab002,g_ooab_d[133].ooab002,g_ooab_d[134].ooab002,g_ooab_d[135].ooab002,
      g_ooab_d[136].ooab002,g_ooab_d[137].ooab002,g_ooab_d[138].ooab002,g_ooab_d[139].ooab002,g_ooab_d[140].ooab002,
      g_ooab_d[141].ooab002,g_ooab_d[142].ooab002,g_ooab_d[143].ooab002,g_ooab_d[144].ooab002,g_ooab_d[145].ooab002,
      g_ooab_d[146].ooab002,g_ooab_d[147].ooab002,g_ooab_d[148].ooab002,g_ooab_d[149].ooab002,g_ooab_d[150].ooab002,
      g_ooab_d[151].ooab002,g_ooab_d[152].ooab002,g_ooab_d[153].ooab002,g_ooab_d[154].ooab002,g_ooab_d[155].ooab002,
      g_ooab_d[156].ooab002,g_ooab_d[157].ooab002,g_ooab_d[158].ooab002,g_ooab_d[159].ooab002,g_ooab_d[160].ooab002,
      g_ooab_d[161].ooab002,g_ooab_d[162].ooab002,g_ooab_d[163].ooab002,g_ooab_d[164].ooab002,g_ooab_d[165].ooab002,
      g_ooab_d[166].ooab002,g_ooab_d[167].ooab002,g_ooab_d[168].ooab002,g_ooab_d[169].ooab002,g_ooab_d[170].ooab002,
      g_ooab_d[171].ooab002,g_ooab_d[172].ooab002,g_ooab_d[173].ooab002,g_ooab_d[174].ooab002,g_ooab_d[175].ooab002,
      g_ooab_d[176].ooab002,g_ooab_d[177].ooab002,g_ooab_d[178].ooab002,g_ooab_d[179].ooab002,g_ooab_d[180].ooab002,
      g_ooab_d[181].ooab002,g_ooab_d[182].ooab002,g_ooab_d[183].ooab002,g_ooab_d[184].ooab002,g_ooab_d[185].ooab002,
      g_ooab_d[186].ooab002,g_ooab_d[187].ooab002,g_ooab_d[188].ooab002,g_ooab_d[189].ooab002,g_ooab_d[190].ooab002,
      g_ooab_d[191].ooab002,g_ooab_d[192].ooab002,g_ooab_d[193].ooab002,g_ooab_d[194].ooab002,g_ooab_d[195].ooab002,
      g_ooab_d[196].ooab002,g_ooab_d[197].ooab002,g_ooab_d[198].ooab002,g_ooab_d[199].ooab002,g_ooab_d[200].ooab002,
      g_ooab_d[201].ooab002,g_ooab_d[202].ooab002,g_ooab_d[203].ooab002,g_ooab_d[204].ooab002,g_ooab_d[205].ooab002,
      g_ooab_d[206].ooab002,g_ooab_d[207].ooab002,g_ooab_d[208].ooab002,g_ooab_d[209].ooab002,g_ooab_d[210].ooab002,
      g_ooab_d[211].ooab002,g_ooab_d[212].ooab002,g_ooab_d[213].ooab002,g_ooab_d[214].ooab002,g_ooab_d[215].ooab002,
      g_ooab_d[216].ooab002,g_ooab_d[217].ooab002,g_ooef001
      
   TO basic_base_1,doctype_base_80,doctype_base_92,doctype_base_94,doctype_base_95,
   doctype_base_96,doctype_base_97,doctype_base_98,aws_B2B_1,aws_MES_1,
   aws_HRM_1,aws_Light_1,aws_EBCHAIN_1,inv_Base_1,inv_Base_2,
   inv_Base_5,sales_base_2,sales_base_3,sales_base_4,sales_base_5,
   sales_base_6,sales_base_7,sales_base_8,sales_base_9,sales_exchange_1,
   sales_exchange_2,sales_exchange_4,purchase_base_1,purchase_base_2,purchase_base_3,
   purchase_base_4,purchase_base_5,purchase_base_6,purchase_base_7,purchase_base_8,
   purchase_base_9,purchase_base_10,purchase_base_11,purchase_base_12,purchase_exchange_1,
   purchase_exchange_2,purchase_leadtime_1,purchase_leadtime_2,purchase_leadtime_3,purchase_leadtime_4,
   cirrection_base_1,cirrection_base_2,cirrection_base_7,cirrection_base_8,cirrection_base_9,
   cirrection_base_10,cirrection_autorepl_1,cirrection_autorepl_2,cirrection_autorepl_3,cirrection_autorepl_4,
   cirrection_shelf_1,cirrection_shelf_2,cirrection_shelf_3,cirrection_counter_1,cirrection_counter_2,
   cirrection_counter_3,cirrection_counter_4,cirrection_counter_5,cirrection_counter_6,cirrection_counter_7,
   cirrection_counter_8,cirrection_counter_9,cirrection_counter_10,cirrection_counter_11,cirrection_counter_12,
   cirrection_counter_13,cirrection_stock_1,cirrection_stock_2,cirrection_rent_1,cirrection_rent_2,
   cirrection_rent_3,cirrection_rent_4,cirrection_rent_5,cirrection_rent_6,cirrection_rent_7,
   cirrection_rent_8,cirrection_rent_9,cirrection_rent_10,cirrection_rent_11,cirrection_rent_12,
   cirrection_rent_13,cirrection_rent_14,cirrection_rent_15,cirrection_rent_16,cirrection_distribution_1,
   finance_AXC_1,finance_AXC_2,finance_AXC_3,finance_AXC_4,finance_AXC_5,
   finance_AXC_6,finance_AXC_7,finance_AXC_8,finance_AXC_9,finance_AXC_10,
   finance_AXC_11,finance_AXC_13,finance_AXC_14,finance_AXC_16,finance_AXC_17,
   finance_AXC_18,finance_AXC_19,finance_AXC_32,finance_AXC_33,finance_AXC_35,
   finance_AXC_36,finance_AXC_37,finance_AXC_38,finance_AXC_39,finance_AGL_1,
   finance_AGL_2,finance_AXR_1,finance_AXR_2,finance_AXR_3,finance_AXR_4,
   finance_AXR_5,finance_AXR_6,finance_AXR_7,finance_AXR_8,finance_AXR_9,
   finance_AXR_10,finance_AXR_12,finance_AXR_13,finance_AXR_14,finance_AXR_15,
   finance_AXR_16,finance_AXR_17,finance_AXR_18,finance_AAP_1,finance_AAP_2,
   finance_AAP_3,finance_AAP_4,finance_AAP_10,finance_AAP_11,finance_AAP_12,
   finance_AAP_13,finance_AAP_21,finance_AAP_22,finance_AAP_23,finance_AAP_25,
   finance_AAP_26,finance_AAP_27,finance_AAP_28,finance_AAP_29,finance_AAP_30,
   finance_ANM_1,finance_ANM_2,finance_ANM_3,finance_ANM_4,finance_ANM_5,
   finance_ANM_6,finance_ANM_7,finance_ANM_8,finance_ANM_9,finance_ANM_10,
   finance_ANM_11,finance_AFM_1,finance_AFM_2,finance_AFA_1,finance_AFA_2,
   finance_AFA_3,finance_AFA_4,finance_AFA_5,finance_AFA_6,finance_AFA_7,
   finance_AFA_8,finance_AFA_9,finance_AFA_10,finance_CIT_1,finance_CIT_2,
   finance_CIT_3,manufactor_wo_1,manufactor_wo_2,manufactor_wo_3,manufactor_routing_1,
   manufactor_routing_2,APS_base_1,APS_base_2,APS_aps_runtime_1,APS_aps_runtime_2,
   APS_aps_runtime_3,APS_aps_runtime_4,APS_apsadv_1,APS_apsadv_2,APS_apsadv_3,
   APS_apsadv_4,APS_apsadv_5,APS_apsadv_6,APS_apsadv_7,APS_apsadv_8,
   AQC_base_1,abx_base_1,abx_base_2,abx_base_3,abx_base_4,
   abx_base_5,abx_base_6,abx_base_7,abx_base_8,abx_base_9,
   abc_bcse_1,abc_bcse_2,abc_bcse_3,abc_bcse_4,abc_bcse_5,
   abc_bcse_6,abc_bcse_7,abc_bcse_8,abc_bcse_9,abc_bcse_10,
   abc_bcse_11,abc_bcse_12,ooef001
      
    INITIALIZE g_ref_fields TO NULL 
          LET g_ref_fields[1] = g_ooef001 
          CALL ap_ref_array2(g_ref_fields," SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields 
          LET ooef001_desc = '', g_rtn_fields[1] , '' 
          DISPLAY BY NAME ooef001_desc 
END FUNCTION
 
#+ 資料修改
PRIVATE FUNCTION aoos020_modify()
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE li_exit LIKE type_t.num5
   DEFINE ls_tmp  STRING 
   
   # 跨Table維護資料, 在修改階段除修改歷程外, 其他區塊都可直接切換
   DIALOG ATTRIBUTES(UNBUFFERED)
      INPUT g_ooab_d[1].ooab002,g_ooab_d[2].ooab002,g_ooab_d[3].ooab002,g_ooab_d[4].ooab002,g_ooab_d[5].ooab002,
      g_ooab_d[6].ooab002,g_ooab_d[7].ooab002,g_ooab_d[8].ooab002,g_ooab_d[9].ooab002,g_ooab_d[10].ooab002,
      g_ooab_d[11].ooab002,g_ooab_d[12].ooab002,g_ooab_d[13].ooab002,g_ooab_d[14].ooab002,g_ooab_d[15].ooab002,
      g_ooab_d[16].ooab002,g_ooab_d[17].ooab002,g_ooab_d[18].ooab002,g_ooab_d[19].ooab002,g_ooab_d[20].ooab002,
      g_ooab_d[21].ooab002,g_ooab_d[22].ooab002,g_ooab_d[23].ooab002,g_ooab_d[24].ooab002,g_ooab_d[25].ooab002,
      g_ooab_d[26].ooab002,g_ooab_d[27].ooab002,g_ooab_d[28].ooab002,g_ooab_d[29].ooab002,g_ooab_d[30].ooab002,
      g_ooab_d[31].ooab002,g_ooab_d[32].ooab002,g_ooab_d[33].ooab002,g_ooab_d[34].ooab002,g_ooab_d[35].ooab002,
      g_ooab_d[36].ooab002,g_ooab_d[37].ooab002,g_ooab_d[38].ooab002,g_ooab_d[39].ooab002,g_ooab_d[40].ooab002,
      g_ooab_d[41].ooab002,g_ooab_d[42].ooab002,g_ooab_d[43].ooab002,g_ooab_d[44].ooab002,g_ooab_d[45].ooab002,
      g_ooab_d[46].ooab002,g_ooab_d[47].ooab002,g_ooab_d[48].ooab002,g_ooab_d[49].ooab002,g_ooab_d[50].ooab002,
      g_ooab_d[51].ooab002,g_ooab_d[52].ooab002,g_ooab_d[53].ooab002,g_ooab_d[54].ooab002,g_ooab_d[55].ooab002,
      g_ooab_d[56].ooab002,g_ooab_d[57].ooab002,g_ooab_d[58].ooab002,g_ooab_d[59].ooab002,g_ooab_d[60].ooab002,
      g_ooab_d[61].ooab002,g_ooab_d[62].ooab002,g_ooab_d[63].ooab002,g_ooab_d[64].ooab002,g_ooab_d[65].ooab002,
      g_ooab_d[66].ooab002,g_ooab_d[67].ooab002,g_ooab_d[68].ooab002,g_ooab_d[69].ooab002,g_ooab_d[70].ooab002,
      g_ooab_d[71].ooab002,g_ooab_d[72].ooab002,g_ooab_d[73].ooab002,g_ooab_d[74].ooab002,g_ooab_d[75].ooab002,
      g_ooab_d[76].ooab002,g_ooab_d[77].ooab002,g_ooab_d[78].ooab002,g_ooab_d[79].ooab002,g_ooab_d[80].ooab002,
      g_ooab_d[81].ooab002,g_ooab_d[82].ooab002,g_ooab_d[83].ooab002,g_ooab_d[84].ooab002,g_ooab_d[85].ooab002,
      g_ooab_d[86].ooab002,g_ooab_d[87].ooab002,g_ooab_d[88].ooab002,g_ooab_d[89].ooab002,g_ooab_d[90].ooab002,
      g_ooab_d[91].ooab002,g_ooab_d[92].ooab002,g_ooab_d[93].ooab002,g_ooab_d[94].ooab002,g_ooab_d[95].ooab002,
      g_ooab_d[96].ooab002,g_ooab_d[97].ooab002,g_ooab_d[98].ooab002,g_ooab_d[99].ooab002,g_ooab_d[100].ooab002,
      g_ooab_d[101].ooab002,g_ooab_d[102].ooab002,g_ooab_d[103].ooab002,g_ooab_d[104].ooab002,g_ooab_d[105].ooab002,
      g_ooab_d[106].ooab002,g_ooab_d[107].ooab002,g_ooab_d[108].ooab002,g_ooab_d[109].ooab002,g_ooab_d[110].ooab002,
      g_ooab_d[111].ooab002,g_ooab_d[112].ooab002,g_ooab_d[113].ooab002,g_ooab_d[114].ooab002,g_ooab_d[115].ooab002,
      g_ooab_d[116].ooab002,g_ooab_d[117].ooab002,g_ooab_d[118].ooab002,g_ooab_d[119].ooab002,g_ooab_d[120].ooab002,
      g_ooab_d[121].ooab002,g_ooab_d[122].ooab002,g_ooab_d[123].ooab002,g_ooab_d[124].ooab002,g_ooab_d[125].ooab002,
      g_ooab_d[126].ooab002,g_ooab_d[127].ooab002,g_ooab_d[128].ooab002,g_ooab_d[129].ooab002,g_ooab_d[130].ooab002,
      g_ooab_d[131].ooab002,g_ooab_d[132].ooab002,g_ooab_d[133].ooab002,g_ooab_d[134].ooab002,g_ooab_d[135].ooab002,
      g_ooab_d[136].ooab002,g_ooab_d[137].ooab002,g_ooab_d[138].ooab002,g_ooab_d[139].ooab002,g_ooab_d[140].ooab002,
      g_ooab_d[141].ooab002,g_ooab_d[142].ooab002,g_ooab_d[143].ooab002,g_ooab_d[144].ooab002,g_ooab_d[145].ooab002,
      g_ooab_d[146].ooab002,g_ooab_d[147].ooab002,g_ooab_d[148].ooab002,g_ooab_d[149].ooab002,g_ooab_d[150].ooab002,
      g_ooab_d[151].ooab002,g_ooab_d[152].ooab002,g_ooab_d[153].ooab002,g_ooab_d[154].ooab002,g_ooab_d[155].ooab002,
      g_ooab_d[156].ooab002,g_ooab_d[157].ooab002,g_ooab_d[158].ooab002,g_ooab_d[159].ooab002,g_ooab_d[160].ooab002,
      g_ooab_d[161].ooab002,g_ooab_d[162].ooab002,g_ooab_d[163].ooab002,g_ooab_d[164].ooab002,g_ooab_d[165].ooab002,
      g_ooab_d[166].ooab002,g_ooab_d[167].ooab002,g_ooab_d[168].ooab002,g_ooab_d[169].ooab002,g_ooab_d[170].ooab002,
      g_ooab_d[171].ooab002,g_ooab_d[172].ooab002,g_ooab_d[173].ooab002,g_ooab_d[174].ooab002,g_ooab_d[175].ooab002,
      g_ooab_d[176].ooab002,g_ooab_d[177].ooab002,g_ooab_d[178].ooab002,g_ooab_d[179].ooab002,g_ooab_d[180].ooab002,
      g_ooab_d[181].ooab002,g_ooab_d[182].ooab002,g_ooab_d[183].ooab002,g_ooab_d[184].ooab002,g_ooab_d[185].ooab002,
      g_ooab_d[186].ooab002,g_ooab_d[187].ooab002,g_ooab_d[188].ooab002,g_ooab_d[189].ooab002,g_ooab_d[190].ooab002,
      g_ooab_d[191].ooab002,g_ooab_d[192].ooab002,g_ooab_d[193].ooab002,g_ooab_d[194].ooab002,g_ooab_d[195].ooab002,
      g_ooab_d[196].ooab002,g_ooab_d[197].ooab002,g_ooab_d[198].ooab002,g_ooab_d[199].ooab002,g_ooab_d[200].ooab002,
      g_ooab_d[201].ooab002,g_ooab_d[202].ooab002,g_ooab_d[203].ooab002,g_ooab_d[204].ooab002,g_ooab_d[205].ooab002,
      g_ooab_d[206].ooab002,g_ooab_d[207].ooab002,g_ooab_d[208].ooab002,g_ooab_d[209].ooab002,g_ooab_d[210].ooab002,
      g_ooab_d[211].ooab002,g_ooab_d[212].ooab002,g_ooab_d[213].ooab002,g_ooab_d[214].ooab002,g_ooab_d[215].ooab002,
      g_ooab_d[216].ooab002,g_ooab_d[217].ooab002,g_ooef001
       FROM basic_base_1,doctype_base_80,doctype_base_92,doctype_base_94,doctype_base_95,
   doctype_base_96,doctype_base_97,doctype_base_98,aws_B2B_1,aws_MES_1,
   aws_HRM_1,aws_Light_1,aws_EBCHAIN_1,inv_Base_1,inv_Base_2,
   inv_Base_5,sales_base_2,sales_base_3,sales_base_4,sales_base_5,
   sales_base_6,sales_base_7,sales_base_8,sales_base_9,sales_exchange_1,
   sales_exchange_2,sales_exchange_4,purchase_base_1,purchase_base_2,purchase_base_3,
   purchase_base_4,purchase_base_5,purchase_base_6,purchase_base_7,purchase_base_8,
   purchase_base_9,purchase_base_10,purchase_base_11,purchase_base_12,purchase_exchange_1,
   purchase_exchange_2,purchase_leadtime_1,purchase_leadtime_2,purchase_leadtime_3,purchase_leadtime_4,
   cirrection_base_1,cirrection_base_2,cirrection_base_7,cirrection_base_8,cirrection_base_9,
   cirrection_base_10,cirrection_autorepl_1,cirrection_autorepl_2,cirrection_autorepl_3,cirrection_autorepl_4,
   cirrection_shelf_1,cirrection_shelf_2,cirrection_shelf_3,cirrection_counter_1,cirrection_counter_2,
   cirrection_counter_3,cirrection_counter_4,cirrection_counter_5,cirrection_counter_6,cirrection_counter_7,
   cirrection_counter_8,cirrection_counter_9,cirrection_counter_10,cirrection_counter_11,cirrection_counter_12,
   cirrection_counter_13,cirrection_stock_1,cirrection_stock_2,cirrection_rent_1,cirrection_rent_2,
   cirrection_rent_3,cirrection_rent_4,cirrection_rent_5,cirrection_rent_6,cirrection_rent_7,
   cirrection_rent_8,cirrection_rent_9,cirrection_rent_10,cirrection_rent_11,cirrection_rent_12,
   cirrection_rent_13,cirrection_rent_14,cirrection_rent_15,cirrection_rent_16,cirrection_distribution_1,
   finance_AXC_1,finance_AXC_2,finance_AXC_3,finance_AXC_4,finance_AXC_5,
   finance_AXC_6,finance_AXC_7,finance_AXC_8,finance_AXC_9,finance_AXC_10,
   finance_AXC_11,finance_AXC_13,finance_AXC_14,finance_AXC_16,finance_AXC_17,
   finance_AXC_18,finance_AXC_19,finance_AXC_32,finance_AXC_33,finance_AXC_35,
   finance_AXC_36,finance_AXC_37,finance_AXC_38,finance_AXC_39,finance_AGL_1,
   finance_AGL_2,finance_AXR_1,finance_AXR_2,finance_AXR_3,finance_AXR_4,
   finance_AXR_5,finance_AXR_6,finance_AXR_7,finance_AXR_8,finance_AXR_9,
   finance_AXR_10,finance_AXR_12,finance_AXR_13,finance_AXR_14,finance_AXR_15,
   finance_AXR_16,finance_AXR_17,finance_AXR_18,finance_AAP_1,finance_AAP_2,
   finance_AAP_3,finance_AAP_4,finance_AAP_10,finance_AAP_11,finance_AAP_12,
   finance_AAP_13,finance_AAP_21,finance_AAP_22,finance_AAP_23,finance_AAP_25,
   finance_AAP_26,finance_AAP_27,finance_AAP_28,finance_AAP_29,finance_AAP_30,
   finance_ANM_1,finance_ANM_2,finance_ANM_3,finance_ANM_4,finance_ANM_5,
   finance_ANM_6,finance_ANM_7,finance_ANM_8,finance_ANM_9,finance_ANM_10,
   finance_ANM_11,finance_AFM_1,finance_AFM_2,finance_AFA_1,finance_AFA_2,
   finance_AFA_3,finance_AFA_4,finance_AFA_5,finance_AFA_6,finance_AFA_7,
   finance_AFA_8,finance_AFA_9,finance_AFA_10,finance_CIT_1,finance_CIT_2,
   finance_CIT_3,manufactor_wo_1,manufactor_wo_2,manufactor_wo_3,manufactor_routing_1,
   manufactor_routing_2,APS_base_1,APS_base_2,APS_aps_runtime_1,APS_aps_runtime_2,
   APS_aps_runtime_3,APS_aps_runtime_4,APS_apsadv_1,APS_apsadv_2,APS_apsadv_3,
   APS_apsadv_4,APS_apsadv_5,APS_apsadv_6,APS_apsadv_7,APS_apsadv_8,
   AQC_base_1,abx_base_1,abx_base_2,abx_base_3,abx_base_4,
   abx_base_5,abx_base_6,abx_base_7,abx_base_8,abx_base_9,
   abc_bcse_1,abc_bcse_2,abc_bcse_3,abc_bcse_4,abc_bcse_5,
   abc_bcse_6,abc_bcse_7,abc_bcse_8,abc_bcse_9,abc_bcse_10,
   abc_bcse_11,abc_bcse_12,ooef001
      ATTRIBUTE(WITHOUT DEFAULTS)
 
         BEFORE INPUT 
            #進行備份陣列抄寫
            FOR li_cnt = 1 TO g_ooab_d.getLength()
               LET g_ooab_d_t[li_cnt].* = g_ooab_d[li_cnt].*
            END FOR 
 
         
         BEFORE FIELD basic_base_1
            CALL aoos020_show_field_help("ooab_t","S-SYS-0001")
 
         AFTER FIELD basic_base_1

         BEFORE FIELD doctype_base_80
            CALL aoos020_show_field_help("ooab_t","S-COM-0002")
 
         AFTER FIELD doctype_base_80

         BEFORE FIELD doctype_base_92
            CALL aoos020_show_field_help("ooab_t","S-COM-0004")
 
         AFTER FIELD doctype_base_92
         
         

         BEFORE FIELD doctype_base_94
            CALL aoos020_show_field_help("ooab_t","S-COM-0006")
 
         AFTER FIELD doctype_base_94

         BEFORE FIELD doctype_base_95
            CALL aoos020_show_field_help("ooab_t","S-BAS-0029")
 
         AFTER FIELD doctype_base_95
         

         BEFORE FIELD doctype_base_96
            CALL aoos020_show_field_help("ooab_t","S-BAS-0030")
 
         AFTER FIELD doctype_base_96
         

         BEFORE FIELD doctype_base_97
            CALL aoos020_show_field_help("ooab_t","S-BAS-0031")
 
         AFTER FIELD doctype_base_97
         

         BEFORE FIELD doctype_base_98
            CALL aoos020_show_field_help("ooab_t","S-BAS-0032")
 
         AFTER FIELD doctype_base_98
         

         BEFORE FIELD aws_B2B_1
            CALL aoos020_show_field_help("ooab_t","S-SYS-0002")
 
         AFTER FIELD aws_B2B_1

         BEFORE FIELD aws_MES_1
            CALL aoos020_show_field_help("ooab_t","S-SYS-0003")
 
         AFTER FIELD aws_MES_1

         BEFORE FIELD aws_HRM_1
            CALL aoos020_show_field_help("ooab_t","S-SYS-0004")
 
         AFTER FIELD aws_HRM_1

         BEFORE FIELD aws_Light_1
            CALL aoos020_show_field_help("ooab_t","S-SYS-0005")
 
         AFTER FIELD aws_Light_1

         BEFORE FIELD aws_EBCHAIN_1
            CALL aoos020_show_field_help("ooab_t","S-SYS-0006")
 
         AFTER FIELD aws_EBCHAIN_1

         BEFORE FIELD inv_Base_1
            CALL aoos020_show_field_help("ooab_t","S-BAS-0028")
 
         AFTER FIELD inv_Base_1

         BEFORE FIELD inv_Base_2
            CALL aoos020_show_field_help("ooab_t","S-BAS-0036")
 
         AFTER FIELD inv_Base_2

         BEFORE FIELD inv_Base_5
            CALL aoos020_show_field_help("ooab_t","S-MFG-0031")
 
         AFTER FIELD inv_Base_5

          IF NOT cl_null (g_ooab_d[16].ooab002) THEN 
             
             IF NOT cl_chk_is_date(g_ooab_d[16].ooab002) THEN 
             
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = g_ooab_d[16].ooab002
                LET g_errparam.code   = "lib-00407"
                LET g_errparam.popup  = TRUE
                CALL cl_err()
                NEXT FIELD CURRENT 
 
             END IF 
          END IF 

         BEFORE FIELD sales_base_2
            CALL aoos020_show_field_help("ooab_t","S-BAS-0018")
 
         AFTER FIELD sales_base_2

         BEFORE FIELD sales_base_3
            CALL aoos020_show_field_help("ooab_t","S-BAS-0023")
 
         AFTER FIELD sales_base_3
         

         BEFORE FIELD sales_base_4
            CALL aoos020_show_field_help("ooab_t","S-BAS-0007")
 
         AFTER FIELD sales_base_4

         BEFORE FIELD sales_base_5
            CALL aoos020_show_field_help("ooab_t","S-BAS-0034")
 
         AFTER FIELD sales_base_5

         BEFORE FIELD sales_base_6
            CALL aoos020_show_field_help("ooab_t","S-BAS-0047")
 
         AFTER FIELD sales_base_6
              #此段落由子樣板ss03產生(Version:2)
             
             IF NOT cl_null(g_ooab_d[21].ooab002)  AND g_ooab_d[21].ooab002 <> g_ooab_d_t[21].ooab002  THEN  
                
                #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                INITIALIZE g_chkparam.* TO NULL
                #設定g_chkparam.*的參數
                LET g_chkparam.arg1 = g_ooab_d[21].ooab002
                #呼叫檢查存在的library
                IF NOT cl_chk_exist("v_oocq002_297") THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_ooab_d[21].ooab002
                  LET g_errparam.code   = "lib-00089"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_ooab_d[21].ooab002 = g_ooab_d_t[21].ooab002 #放回舊值
                  NEXT FIELD sales_base_6 
                END IF
                
            END IF
      




         BEFORE FIELD sales_base_7
            CALL aoos020_show_field_help("ooab_t","S-BAS-0051")
 
         AFTER FIELD sales_base_7
              #此段落由子樣板ss03產生(Version:2)
             
             IF NOT cl_null(g_ooab_d[22].ooab002)  AND g_ooab_d[22].ooab002 <> g_ooab_d_t[22].ooab002  THEN  
                
                #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                INITIALIZE g_chkparam.* TO NULL
                #設定g_chkparam.*的參數
                LET g_chkparam.arg1 = g_ooab_d[22].ooab002
                #呼叫檢查存在的library
                IF NOT cl_chk_exist("v_oocq002_297") THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_ooab_d[22].ooab002
                  LET g_errparam.code   = "lib-00089"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_ooab_d[22].ooab002 = g_ooab_d_t[22].ooab002 #放回舊值
                  NEXT FIELD sales_base_7 
                END IF
                
            END IF
      




         BEFORE FIELD sales_base_8
            CALL aoos020_show_field_help("ooab_t","S-BAS-0048")
 
         AFTER FIELD sales_base_8

         BEFORE FIELD sales_base_9
            CALL aoos020_show_field_help("ooab_t","S-BAS-0009")
 
         AFTER FIELD sales_base_9
              #此段落由子樣板ss03產生(Version:2)
             
             IF NOT cl_null(g_ooab_d[24].ooab002)  AND g_ooab_d[24].ooab002 <> g_ooab_d_t[24].ooab002  THEN  
                
                #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                INITIALIZE g_chkparam.* TO NULL
                #設定g_chkparam.*的參數
                LET g_chkparam.arg1 = g_ooab_d[24].ooab002
                #呼叫檢查存在的library
                IF NOT cl_chk_exist("v_ooal002_15") THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_ooab_d[24].ooab002
                  LET g_errparam.code   = "lib-00089"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_ooab_d[24].ooab002 = g_ooab_d_t[24].ooab002 #放回舊值
                  NEXT FIELD sales_base_9 
                END IF
                
            END IF
      




         BEFORE FIELD sales_exchange_1
            CALL aoos020_show_field_help("ooab_t","S-BAS-0010")
 
         AFTER FIELD sales_exchange_1
         

         BEFORE FIELD sales_exchange_2
            CALL aoos020_show_field_help("ooab_t","S-BAS-0011")
 
         AFTER FIELD sales_exchange_2
         

         BEFORE FIELD sales_exchange_4
            CALL aoos020_show_field_help("ooab_t","S-BAS-0013")
 
         AFTER FIELD sales_exchange_4
         

         BEFORE FIELD purchase_base_1
            CALL aoos020_show_field_help("ooab_t","S-BAS-0017")
 
         AFTER FIELD purchase_base_1

         BEFORE FIELD purchase_base_2
            CALL aoos020_show_field_help("ooab_t","S-BAS-0019")
 
         AFTER FIELD purchase_base_2

         BEFORE FIELD purchase_base_3
            CALL aoos020_show_field_help("ooab_t","S-BAS-0020")
 
         AFTER FIELD purchase_base_3
         

         BEFORE FIELD purchase_base_4
            CALL aoos020_show_field_help("ooab_t","S-BAS-0021")
 
         AFTER FIELD purchase_base_4
              #此段落由子樣板ss03產生(Version:2)
             
             IF NOT cl_null(g_ooab_d[31].ooab002)  AND g_ooab_d[31].ooab002 <> g_ooab_d_t[31].ooab002  THEN  
                
                #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                INITIALIZE g_chkparam.* TO NULL
                #設定g_chkparam.*的參數
                LET g_chkparam.arg1 = g_ooab_d[31].ooab002
                #呼叫檢查存在的library
                IF NOT cl_chk_exist("v_ooal002_14") THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_ooab_d[31].ooab002
                  LET g_errparam.code   = "lib-00089"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_ooab_d[31].ooab002 = g_ooab_d_t[31].ooab002 #放回舊值
                  NEXT FIELD purchase_base_4 
                END IF
                
            END IF
      




         BEFORE FIELD purchase_base_5
            CALL aoos020_show_field_help("ooab_t","S-BAS-0022")
 
         AFTER FIELD purchase_base_5
         

         BEFORE FIELD purchase_base_6
            CALL aoos020_show_field_help("ooab_t","S-BAS-0043")
 
         AFTER FIELD purchase_base_6
         

         BEFORE FIELD purchase_base_7
            CALL aoos020_show_field_help("ooab_t","S-BAS-0044")
 
         AFTER FIELD purchase_base_7
         

         BEFORE FIELD purchase_base_8
            CALL aoos020_show_field_help("ooab_t","S-BAS-0045")
 
         AFTER FIELD purchase_base_8
         

         BEFORE FIELD purchase_base_9
            CALL aoos020_show_field_help("ooab_t","S-BAS-0046")
 
         AFTER FIELD purchase_base_9
         

         BEFORE FIELD purchase_base_10
            CALL aoos020_show_field_help("ooab_t","S-BAS-0033")
 
         AFTER FIELD purchase_base_10

         BEFORE FIELD purchase_base_11
            CALL aoos020_show_field_help("ooab_t","S-BAS-0049")
 
         AFTER FIELD purchase_base_11

         BEFORE FIELD purchase_base_12
            CALL aoos020_show_field_help("ooab_t","S-BAS-0050")
 
         AFTER FIELD purchase_base_12

         BEFORE FIELD purchase_exchange_1
            CALL aoos020_show_field_help("ooab_t","S-BAS-0014")
 
         AFTER FIELD purchase_exchange_1
         

         BEFORE FIELD purchase_exchange_2
            CALL aoos020_show_field_help("ooab_t","S-BAS-0015")
 
         AFTER FIELD purchase_exchange_2
         

         BEFORE FIELD purchase_leadtime_1
            CALL aoos020_show_field_help("ooab_t","S-BAS-0024")
 
         AFTER FIELD purchase_leadtime_1
         #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooab_d[42].ooab002,"0","1","999","1","azz-00087",1) THEN
               NEXT FIELD purchase_leadtime_1
            END IF 



         #此段落由子樣板ss01產生
            IF NOT cl_null(g_ooab_d[42].ooab002) THEN
               LET ls_tmp = g_ooab_d[42].ooab002
               IF ls_tmp.getIndexOf(".",1) THEN                  
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.extend = g_ooab_d[42].ooab002
                   LET g_errparam.code   = "azz-00138"
                   LET g_errparam.popup  = TRUE
                   CALL cl_err()
                   NEXT FIELD purchase_leadtime_1
               END IF   
            END IF


         

         BEFORE FIELD purchase_leadtime_2
            CALL aoos020_show_field_help("ooab_t","S-BAS-0025")
 
         AFTER FIELD purchase_leadtime_2
         #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooab_d[43].ooab002,"0","1","999","1","azz-00087",1) THEN
               NEXT FIELD purchase_leadtime_2
            END IF 



         #此段落由子樣板ss01產生
            IF NOT cl_null(g_ooab_d[43].ooab002) THEN
               LET ls_tmp = g_ooab_d[43].ooab002
               IF ls_tmp.getIndexOf(".",1) THEN                  
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.extend = g_ooab_d[43].ooab002
                   LET g_errparam.code   = "azz-00138"
                   LET g_errparam.popup  = TRUE
                   CALL cl_err()
                   NEXT FIELD purchase_leadtime_2
               END IF   
            END IF


         

         BEFORE FIELD purchase_leadtime_3
            CALL aoos020_show_field_help("ooab_t","S-BAS-0026")
 
         AFTER FIELD purchase_leadtime_3
         #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooab_d[44].ooab002,"0","1","999","1","azz-00087",1) THEN
               NEXT FIELD purchase_leadtime_3
            END IF 



         #此段落由子樣板ss01產生
            IF NOT cl_null(g_ooab_d[44].ooab002) THEN
               LET ls_tmp = g_ooab_d[44].ooab002
               IF ls_tmp.getIndexOf(".",1) THEN                  
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.extend = g_ooab_d[44].ooab002
                   LET g_errparam.code   = "azz-00138"
                   LET g_errparam.popup  = TRUE
                   CALL cl_err()
                   NEXT FIELD purchase_leadtime_3
               END IF   
            END IF


         

         BEFORE FIELD purchase_leadtime_4
            CALL aoos020_show_field_help("ooab_t","S-BAS-0027")
 
         AFTER FIELD purchase_leadtime_4
         #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooab_d[45].ooab002,"0","1","999","1","azz-00087",1) THEN
               NEXT FIELD purchase_leadtime_4
            END IF 



         #此段落由子樣板ss01產生
            IF NOT cl_null(g_ooab_d[45].ooab002) THEN
               LET ls_tmp = g_ooab_d[45].ooab002
               IF ls_tmp.getIndexOf(".",1) THEN                  
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.extend = g_ooab_d[45].ooab002
                   LET g_errparam.code   = "azz-00138"
                   LET g_errparam.popup  = TRUE
                   CALL cl_err()
                   NEXT FIELD purchase_leadtime_4
               END IF   
            END IF


         

         BEFORE FIELD cirrection_base_1
            CALL aoos020_show_field_help("ooab_t","S-CIR-0003")
 
         AFTER FIELD cirrection_base_1

          IF NOT cl_null (g_ooab_d[46].ooab002) THEN 
             
             IF NOT cl_chk_is_date(g_ooab_d[46].ooab002) THEN 
             
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = g_ooab_d[46].ooab002
                LET g_errparam.code   = "lib-00407"
                LET g_errparam.popup  = TRUE
                CALL cl_err()
                NEXT FIELD CURRENT 
 
             END IF 
          END IF 

         BEFORE FIELD cirrection_base_2
            CALL aoos020_show_field_help("ooab_t","S-CIR-0001")
 
         AFTER FIELD cirrection_base_2

          IF NOT cl_null (g_ooab_d[47].ooab002) THEN 
             
             IF NOT cl_chk_is_date(g_ooab_d[47].ooab002) THEN 
             
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = g_ooab_d[47].ooab002
                LET g_errparam.code   = "lib-00407"
                LET g_errparam.popup  = TRUE
                CALL cl_err()
                NEXT FIELD CURRENT 
 
             END IF 
          END IF 

         BEFORE FIELD cirrection_base_7
            CALL aoos020_show_field_help("ooab_t","S-BAS-0035")
 
         AFTER FIELD cirrection_base_7
         #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooab_d[48].ooab002,"1","1","24","1","azz-00087",1) THEN
               NEXT FIELD cirrection_base_7
            END IF 



         #此段落由子樣板ss01產生
            IF NOT cl_null(g_ooab_d[48].ooab002) THEN
               LET ls_tmp = g_ooab_d[48].ooab002
               IF ls_tmp.getIndexOf(".",1) THEN                  
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.extend = g_ooab_d[48].ooab002
                   LET g_errparam.code   = "azz-00138"
                   LET g_errparam.popup  = TRUE
                   CALL cl_err()
                   NEXT FIELD cirrection_base_7
               END IF   
            END IF


         

         BEFORE FIELD cirrection_base_8
            CALL aoos020_show_field_help("ooab_t","S-CIR-2008")
 
         AFTER FIELD cirrection_base_8

         BEFORE FIELD cirrection_base_9
            CALL aoos020_show_field_help("ooab_t","S-CIR-2015")
 
         AFTER FIELD cirrection_base_9
         #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooab_d[50].ooab002,"0","0","","","azz-00079",1) THEN
               NEXT FIELD cirrection_base_9
            END IF 



         #此段落由子樣板ss01產生
            IF NOT cl_null(g_ooab_d[50].ooab002) THEN
               LET ls_tmp = g_ooab_d[50].ooab002
               IF ls_tmp.getIndexOf(".",1) THEN                  
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.extend = g_ooab_d[50].ooab002
                   LET g_errparam.code   = "azz-00138"
                   LET g_errparam.popup  = TRUE
                   CALL cl_err()
                   NEXT FIELD cirrection_base_9
               END IF   
            END IF


         

         BEFORE FIELD cirrection_base_10
            CALL aoos020_show_field_help("ooab_t","S-CIR-2037")
 
         AFTER FIELD cirrection_base_10

         BEFORE FIELD cirrection_autorepl_1
            CALL aoos020_show_field_help("ooab_t","S-CIR-1000")
 
         AFTER FIELD cirrection_autorepl_1
              #此段落由子樣板ss03產生(Version:2)
             
             IF NOT cl_null(g_ooab_d[52].ooab002)  AND g_ooab_d[52].ooab002 <> g_ooab_d_t[52].ooab002  THEN  
                
                #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                INITIALIZE g_chkparam.* TO NULL
                #設定g_chkparam.*的參數
                LET g_chkparam.arg1 = g_ooab_d[52].ooab002
                #呼叫檢查存在的library
                IF NOT cl_chk_exist("v_rtkh001") THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_ooab_d[52].ooab002
                  LET g_errparam.code   = "lib-00089"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_ooab_d[52].ooab002 = g_ooab_d_t[52].ooab002 #放回舊值
                  NEXT FIELD cirrection_autorepl_1 
                END IF
                
            END IF
      




         BEFORE FIELD cirrection_autorepl_2
            CALL aoos020_show_field_help("ooab_t","S-CIR-1001")
 
         AFTER FIELD cirrection_autorepl_2
         

         BEFORE FIELD cirrection_autorepl_3
            CALL aoos020_show_field_help("ooab_t","S-CIR-1002")
 
         AFTER FIELD cirrection_autorepl_3
         

         BEFORE FIELD cirrection_autorepl_4
            CALL aoos020_show_field_help("ooab_t","S-CIR-1003")
 
         AFTER FIELD cirrection_autorepl_4
         

         BEFORE FIELD cirrection_shelf_1
            CALL aoos020_show_field_help("ooab_t","S-CIR-2000")
 
         AFTER FIELD cirrection_shelf_1

         BEFORE FIELD cirrection_shelf_2
            CALL aoos020_show_field_help("ooab_t","S-CIR-2001")
 
         AFTER FIELD cirrection_shelf_2
              #此段落由子樣板ss03產生(Version:2)
             
             IF NOT cl_null(g_ooab_d[57].ooab002)  AND g_ooab_d[57].ooab002 <> g_ooab_d_t[57].ooab002  THEN  
                
                #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                INITIALIZE g_chkparam.* TO NULL
                #設定g_chkparam.*的參數
                LET g_chkparam.arg1 = g_ooab_d[57].ooab002
                #呼叫檢查存在的library
                IF NOT cl_chk_exist("v_infc001_1") THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_ooab_d[57].ooab002
                  LET g_errparam.code   = "lib-00089"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_ooab_d[57].ooab002 = g_ooab_d_t[57].ooab002 #放回舊值
                  NEXT FIELD cirrection_shelf_2 
                END IF
                
            END IF
      




         BEFORE FIELD cirrection_shelf_3
            CALL aoos020_show_field_help("ooab_t","S-CIR-2002")
 
         AFTER FIELD cirrection_shelf_3
              #此段落由子樣板ss03產生(Version:2)
             
             IF NOT cl_null(g_ooab_d[58].ooab002)  AND g_ooab_d[58].ooab002 <> g_ooab_d_t[58].ooab002  THEN  
                
                #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                INITIALIZE g_chkparam.* TO NULL
                #設定g_chkparam.*的參數
                LET g_chkparam.arg1 = g_ooab_d[58].ooab002
                #呼叫檢查存在的library
                IF NOT cl_chk_exist("v_infc001_2") THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_ooab_d[58].ooab002
                  LET g_errparam.code   = "lib-00089"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_ooab_d[58].ooab002 = g_ooab_d_t[58].ooab002 #放回舊值
                  NEXT FIELD cirrection_shelf_3 
                END IF
                
            END IF
      




         BEFORE FIELD cirrection_counter_1
            CALL aoos020_show_field_help("ooab_t","S-CIR-2003")
 
         AFTER FIELD cirrection_counter_1
         

         BEFORE FIELD cirrection_counter_2
            CALL aoos020_show_field_help("ooab_t","S-CIR-2004")
 
         AFTER FIELD cirrection_counter_2

         BEFORE FIELD cirrection_counter_3
            CALL aoos020_show_field_help("ooab_t","S-CIR-2005")
 
         AFTER FIELD cirrection_counter_3
         #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooab_d[61].ooab002,"0","1","100","1","azz-00087",1) THEN
               NEXT FIELD cirrection_counter_3
            END IF 



         #此段落由子樣板ss01產生
            IF NOT cl_null(g_ooab_d[61].ooab002) THEN
               LET ls_tmp = g_ooab_d[61].ooab002
               IF ls_tmp.getIndexOf(".",1) THEN                  
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.extend = g_ooab_d[61].ooab002
                   LET g_errparam.code   = "azz-00138"
                   LET g_errparam.popup  = TRUE
                   CALL cl_err()
                   NEXT FIELD cirrection_counter_3
               END IF   
            END IF


         

         BEFORE FIELD cirrection_counter_4
            CALL aoos020_show_field_help("ooab_t","S-CIR-2006")
 
         AFTER FIELD cirrection_counter_4
         #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooab_d[62].ooab002,"","0","","0","azz-00079",1) THEN
               NEXT FIELD cirrection_counter_4
            END IF 



         #此段落由子樣板ss01產生
            IF NOT cl_null(g_ooab_d[62].ooab002) THEN
               LET ls_tmp = g_ooab_d[62].ooab002
               IF ls_tmp.getIndexOf(".",1) THEN                  
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.extend = g_ooab_d[62].ooab002
                   LET g_errparam.code   = "azz-00138"
                   LET g_errparam.popup  = TRUE
                   CALL cl_err()
                   NEXT FIELD cirrection_counter_4
               END IF   
            END IF


         

         BEFORE FIELD cirrection_counter_5
            CALL aoos020_show_field_help("ooab_t","S-CIR-2007")
 
         AFTER FIELD cirrection_counter_5
         

         BEFORE FIELD cirrection_counter_6
            CALL aoos020_show_field_help("ooab_t","S-CIR-2009")
 
         AFTER FIELD cirrection_counter_6

         BEFORE FIELD cirrection_counter_7
            CALL aoos020_show_field_help("ooab_t","S-CIR-2010")
 
         AFTER FIELD cirrection_counter_7

         BEFORE FIELD cirrection_counter_8
            CALL aoos020_show_field_help("ooab_t","S-CIR-2011")
 
         AFTER FIELD cirrection_counter_8
         

         BEFORE FIELD cirrection_counter_9
            CALL aoos020_show_field_help("ooab_t","S-CIR-2012")
 
         AFTER FIELD cirrection_counter_9

         BEFORE FIELD cirrection_counter_10
            CALL aoos020_show_field_help("ooab_t","S-CIR-2013")
 
         AFTER FIELD cirrection_counter_10
              #此段落由子樣板ss03產生(Version:2)
             
             IF NOT cl_null(g_ooab_d[68].ooab002)  AND g_ooab_d[68].ooab002 <> g_ooab_d_t[68].ooab002  THEN  
                
                #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                INITIALIZE g_chkparam.* TO NULL
                #設定g_chkparam.*的參數
                LET g_chkparam.arg1 = g_ooab_d[68].ooab002
                #呼叫檢查存在的library
                IF NOT cl_chk_exist("v_ooca001") THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_ooab_d[68].ooab002
                  LET g_errparam.code   = "lib-00089"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_ooab_d[68].ooab002 = g_ooab_d_t[68].ooab002 #放回舊值
                  NEXT FIELD cirrection_counter_10 
                END IF
                
            END IF
      




         BEFORE FIELD cirrection_counter_11
            CALL aoos020_show_field_help("ooab_t","S-CIR-2014")
 
         AFTER FIELD cirrection_counter_11
              #此段落由子樣板ss03產生(Version:2)
             
             IF NOT cl_null(g_ooab_d[69].ooab002)  AND g_ooab_d[69].ooab002 <> g_ooab_d_t[69].ooab002  THEN  
                
                #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                INITIALIZE g_chkparam.* TO NULL
                #設定g_chkparam.*的參數
                LET g_chkparam.arg1 = g_ooab_d[69].ooab002
                #呼叫檢查存在的library
                IF NOT cl_chk_exist("v_rtda001") THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_ooab_d[69].ooab002
                  LET g_errparam.code   = "lib-00089"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_ooab_d[69].ooab002 = g_ooab_d_t[69].ooab002 #放回舊值
                  NEXT FIELD cirrection_counter_11 
                END IF
                
            END IF
      




         BEFORE FIELD cirrection_counter_12
            CALL aoos020_show_field_help("ooab_t","S-CIR-2016")
 
         AFTER FIELD cirrection_counter_12
         

         BEFORE FIELD cirrection_counter_13
            CALL aoos020_show_field_help("ooab_t","S-CIR-2017")
 
         AFTER FIELD cirrection_counter_13

          IF NOT cl_null (g_ooab_d[71].ooab002) THEN 
             
             IF NOT cl_chk_is_date(g_ooab_d[71].ooab002) THEN 
             
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = g_ooab_d[71].ooab002
                LET g_errparam.code   = "lib-00407"
                LET g_errparam.popup  = TRUE
                CALL cl_err()
                NEXT FIELD CURRENT 
 
             END IF 
          END IF 

         BEFORE FIELD cirrection_stock_1
            CALL aoos020_show_field_help("ooab_t","S-CIR-2018")
 
         AFTER FIELD cirrection_stock_1

         BEFORE FIELD cirrection_stock_2
            CALL aoos020_show_field_help("ooab_t","S-CIR-2036")
 
         AFTER FIELD cirrection_stock_2

         BEFORE FIELD cirrection_rent_1
            CALL aoos020_show_field_help("ooab_t","S-CIR-2019")
 
         AFTER FIELD cirrection_rent_1

         BEFORE FIELD cirrection_rent_2
            CALL aoos020_show_field_help("ooab_t","S-CIR-2020")
 
         AFTER FIELD cirrection_rent_2
         

         BEFORE FIELD cirrection_rent_3
            CALL aoos020_show_field_help("ooab_t","S-CIR-2021")
 
         AFTER FIELD cirrection_rent_3

         BEFORE FIELD cirrection_rent_4
            CALL aoos020_show_field_help("ooab_t","S-CIR-2022")
 
         AFTER FIELD cirrection_rent_4
         #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooab_d[77].ooab002,"","0","","0","azz-00079",1) THEN
               NEXT FIELD cirrection_rent_4
            END IF 



         #此段落由子樣板ss01產生
            IF NOT cl_null(g_ooab_d[77].ooab002) THEN
               LET ls_tmp = g_ooab_d[77].ooab002
               IF ls_tmp.getIndexOf(".",1) THEN                  
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.extend = g_ooab_d[77].ooab002
                   LET g_errparam.code   = "azz-00138"
                   LET g_errparam.popup  = TRUE
                   CALL cl_err()
                   NEXT FIELD cirrection_rent_4
               END IF   
            END IF


         

         BEFORE FIELD cirrection_rent_5
            CALL aoos020_show_field_help("ooab_t","S-CIR-2023")
 
         AFTER FIELD cirrection_rent_5
         #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooab_d[78].ooab002,"","0","","0","azz-00079",1) THEN
               NEXT FIELD cirrection_rent_5
            END IF 



         #此段落由子樣板ss01產生
            IF NOT cl_null(g_ooab_d[78].ooab002) THEN
               LET ls_tmp = g_ooab_d[78].ooab002
               IF ls_tmp.getIndexOf(".",1) THEN                  
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.extend = g_ooab_d[78].ooab002
                   LET g_errparam.code   = "azz-00138"
                   LET g_errparam.popup  = TRUE
                   CALL cl_err()
                   NEXT FIELD cirrection_rent_5
               END IF   
            END IF


         

         BEFORE FIELD cirrection_rent_6
            CALL aoos020_show_field_help("ooab_t","S-CIR-2024")
 
         AFTER FIELD cirrection_rent_6
         #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooab_d[79].ooab002,"","0","","0","azz-00079",1) THEN
               NEXT FIELD cirrection_rent_6
            END IF 



         #此段落由子樣板ss01產生
            IF NOT cl_null(g_ooab_d[79].ooab002) THEN
               LET ls_tmp = g_ooab_d[79].ooab002
               IF ls_tmp.getIndexOf(".",1) THEN                  
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.extend = g_ooab_d[79].ooab002
                   LET g_errparam.code   = "azz-00138"
                   LET g_errparam.popup  = TRUE
                   CALL cl_err()
                   NEXT FIELD cirrection_rent_6
               END IF   
            END IF


         

         BEFORE FIELD cirrection_rent_7
            CALL aoos020_show_field_help("ooab_t","S-CIR-2025")
 
         AFTER FIELD cirrection_rent_7
         #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooab_d[80].ooab002,"","0","","0","azz-00079",1) THEN
               NEXT FIELD cirrection_rent_7
            END IF 



         #此段落由子樣板ss01產生
            IF NOT cl_null(g_ooab_d[80].ooab002) THEN
               LET ls_tmp = g_ooab_d[80].ooab002
               IF ls_tmp.getIndexOf(".",1) THEN                  
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.extend = g_ooab_d[80].ooab002
                   LET g_errparam.code   = "azz-00138"
                   LET g_errparam.popup  = TRUE
                   CALL cl_err()
                   NEXT FIELD cirrection_rent_7
               END IF   
            END IF


         

         BEFORE FIELD cirrection_rent_8
            CALL aoos020_show_field_help("ooab_t","S-CIR-2026")
 
         AFTER FIELD cirrection_rent_8
         

         BEFORE FIELD cirrection_rent_9
            CALL aoos020_show_field_help("ooab_t","S-CIR-2027")
 
         AFTER FIELD cirrection_rent_9

         BEFORE FIELD cirrection_rent_10
            CALL aoos020_show_field_help("ooab_t","S-CIR-2028")
 
         AFTER FIELD cirrection_rent_10

         BEFORE FIELD cirrection_rent_11
            CALL aoos020_show_field_help("ooab_t","S-CIR-2030")
 
         AFTER FIELD cirrection_rent_11
         

         BEFORE FIELD cirrection_rent_12
            CALL aoos020_show_field_help("ooab_t","S-CIR-2031")
 
         AFTER FIELD cirrection_rent_12

         BEFORE FIELD cirrection_rent_13
            CALL aoos020_show_field_help("ooab_t","S-CIR-2032")
 
         AFTER FIELD cirrection_rent_13

         BEFORE FIELD cirrection_rent_14
            CALL aoos020_show_field_help("ooab_t","S-CIR-2033")
 
         AFTER FIELD cirrection_rent_14

         BEFORE FIELD cirrection_rent_15
            CALL aoos020_show_field_help("ooab_t","S-CIR-2034")
 
         AFTER FIELD cirrection_rent_15

         BEFORE FIELD cirrection_rent_16
            CALL aoos020_show_field_help("ooab_t","S-CIR-2035")
 
         AFTER FIELD cirrection_rent_16

         BEFORE FIELD cirrection_distribution_1
            CALL aoos020_show_field_help("ooab_t","S-CIR-2029")
 
         AFTER FIELD cirrection_distribution_1
              #此段落由子樣板ss03產生(Version:2)
             
             IF NOT cl_null(g_ooab_d[90].ooab002)  AND g_ooab_d[90].ooab002 <> g_ooab_d_t[90].ooab002  THEN  
                
                #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                INITIALIZE g_chkparam.* TO NULL
                #設定g_chkparam.*的參數
                LET g_chkparam.arg1 = g_ooab_d[90].ooab002
                #呼叫檢查存在的library
                IF NOT cl_chk_exist("v_imaa001_12") THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_ooab_d[90].ooab002
                  LET g_errparam.code   = "lib-00089"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_ooab_d[90].ooab002 = g_ooab_d_t[90].ooab002 #放回舊值
                  NEXT FIELD cirrection_distribution_1 
                END IF
                
            END IF
      




         BEFORE FIELD finance_AXC_1
            CALL aoos020_show_field_help("ooab_t","S-FIN-6015")
 
         AFTER FIELD finance_AXC_1

         BEFORE FIELD finance_AXC_2
            CALL aoos020_show_field_help("ooab_t","S-FIN-6013")
 
         AFTER FIELD finance_AXC_2

         BEFORE FIELD finance_AXC_3
            CALL aoos020_show_field_help("ooab_t","S-FIN-6001")
 
         AFTER FIELD finance_AXC_3

         BEFORE FIELD finance_AXC_4
            CALL aoos020_show_field_help("ooab_t","S-FIN-6002")
 
         AFTER FIELD finance_AXC_4
         

         BEFORE FIELD finance_AXC_5
            CALL aoos020_show_field_help("ooab_t","S-FIN-6003")
 
         AFTER FIELD finance_AXC_5

         BEFORE FIELD finance_AXC_6
            CALL aoos020_show_field_help("ooab_t","S-FIN-6004")
 
         AFTER FIELD finance_AXC_6
         

         BEFORE FIELD finance_AXC_7
            CALL aoos020_show_field_help("ooab_t","S-FIN-6006")
 
         AFTER FIELD finance_AXC_7
         

         BEFORE FIELD finance_AXC_8
            CALL aoos020_show_field_help("ooab_t","S-FIN-6005")
 
         AFTER FIELD finance_AXC_8
         

         BEFORE FIELD finance_AXC_9
            CALL aoos020_show_field_help("ooab_t","S-FIN-6007")
 
         AFTER FIELD finance_AXC_9
         

         BEFORE FIELD finance_AXC_10
            CALL aoos020_show_field_help("ooab_t","S-FIN-6023")
 
         AFTER FIELD finance_AXC_10
         

         BEFORE FIELD finance_AXC_11
            CALL aoos020_show_field_help("ooab_t","S-FIN-6024")
 
         AFTER FIELD finance_AXC_11
         

         BEFORE FIELD finance_AXC_13
            CALL aoos020_show_field_help("ooab_t","S-FIN-6014")
 
         AFTER FIELD finance_AXC_13
         

         BEFORE FIELD finance_AXC_14
            CALL aoos020_show_field_help("ooab_t","S-FIN-6016")
 
         AFTER FIELD finance_AXC_14

         BEFORE FIELD finance_AXC_16
            CALL aoos020_show_field_help("ooab_t","S-FIN-6008")
 
         AFTER FIELD finance_AXC_16

         BEFORE FIELD finance_AXC_17
            CALL aoos020_show_field_help("ooab_t","S-FIN-6022")
 
         AFTER FIELD finance_AXC_17

         BEFORE FIELD finance_AXC_18
            CALL aoos020_show_field_help("ooab_t","S-FIN-6009")
 
         AFTER FIELD finance_AXC_18
         

         BEFORE FIELD finance_AXC_19
            CALL aoos020_show_field_help("ooab_t","S-FIN-6017")
 
         AFTER FIELD finance_AXC_19

         BEFORE FIELD finance_AXC_32
            CALL aoos020_show_field_help("ooab_t","S-FIN-6018")
 
         AFTER FIELD finance_AXC_32

         BEFORE FIELD finance_AXC_33
            CALL aoos020_show_field_help("ooab_t","S-FIN-6019")
 
         AFTER FIELD finance_AXC_33

         BEFORE FIELD finance_AXC_35
            CALL aoos020_show_field_help("ooab_t","S-FIN-6020")
 
         AFTER FIELD finance_AXC_35
         

         BEFORE FIELD finance_AXC_36
            CALL aoos020_show_field_help("ooab_t","S-FIN-6021")
 
         AFTER FIELD finance_AXC_36

         BEFORE FIELD finance_AXC_37
            CALL aoos020_show_field_help("ooab_t","S-FIN-6012")
 
         AFTER FIELD finance_AXC_37

          IF NOT cl_null (g_ooab_d[112].ooab002) THEN 
             
             IF NOT cl_chk_is_date(g_ooab_d[112].ooab002) THEN 
             
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = g_ooab_d[112].ooab002
                LET g_errparam.code   = "lib-00407"
                LET g_errparam.popup  = TRUE
                CALL cl_err()
                NEXT FIELD CURRENT 
 
             END IF 
          END IF 

         BEFORE FIELD finance_AXC_38
            CALL aoos020_show_field_help("ooab_t","S-FIN-6010")
 
         AFTER FIELD finance_AXC_38
         #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooab_d[113].ooab002,"2013","0","","","azz-00079",1) THEN
               NEXT FIELD finance_AXC_38
            END IF 



         #此段落由子樣板ss01產生
            IF NOT cl_null(g_ooab_d[113].ooab002) THEN
               LET ls_tmp = g_ooab_d[113].ooab002
               IF ls_tmp.getIndexOf(".",1) THEN                  
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.extend = g_ooab_d[113].ooab002
                   LET g_errparam.code   = "azz-00138"
                   LET g_errparam.popup  = TRUE
                   CALL cl_err()
                   NEXT FIELD finance_AXC_38
               END IF   
            END IF


         

         BEFORE FIELD finance_AXC_39
            CALL aoos020_show_field_help("ooab_t","S-FIN-6011")
 
         AFTER FIELD finance_AXC_39
         #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooab_d[114].ooab002,"1","1","13","1","azz-00087",1) THEN
               NEXT FIELD finance_AXC_39
            END IF 



         #此段落由子樣板ss01產生
            IF NOT cl_null(g_ooab_d[114].ooab002) THEN
               LET ls_tmp = g_ooab_d[114].ooab002
               IF ls_tmp.getIndexOf(".",1) THEN                  
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.extend = g_ooab_d[114].ooab002
                   LET g_errparam.code   = "azz-00138"
                   LET g_errparam.popup  = TRUE
                   CALL cl_err()
                   NEXT FIELD finance_AXC_39
               END IF   
            END IF


         

         BEFORE FIELD finance_AGL_1
            CALL aoos020_show_field_help("ooab_t","S-FIN-0001")
 
         AFTER FIELD finance_AGL_1
              #此段落由子樣板ss03產生(Version:2)
             
             IF NOT cl_null(g_ooab_d[115].ooab002)  AND g_ooab_d[115].ooab002 <> g_ooab_d_t[115].ooab002  THEN  
                
                #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                INITIALIZE g_chkparam.* TO NULL
                #設定g_chkparam.*的參數
                LET g_chkparam.arg1 = g_ooab_d[115].ooab002
                #呼叫檢查存在的library
                IF NOT cl_chk_exist("v_glaa023_1") THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_ooab_d[115].ooab002
                  LET g_errparam.code   = "lib-00089"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_ooab_d[115].ooab002 = g_ooab_d_t[115].ooab002 #放回舊值
                  NEXT FIELD finance_AGL_1 
                END IF
                
            END IF
      




         BEFORE FIELD finance_AGL_2
            CALL aoos020_show_field_help("ooab_t","S-FIN-0002")
 
         AFTER FIELD finance_AGL_2
              #此段落由子樣板ss03產生(Version:2)
             
             IF NOT cl_null(g_ooab_d[116].ooab002)  AND g_ooab_d[116].ooab002 <> g_ooab_d_t[116].ooab002  THEN  
                
                #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                INITIALIZE g_chkparam.* TO NULL
                #設定g_chkparam.*的參數
                LET g_chkparam.arg1 = g_ooab_d[116].ooab002
                #呼叫檢查存在的library
                IF NOT cl_chk_exist("v_glaa023_2") THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_ooab_d[116].ooab002
                  LET g_errparam.code   = "lib-00089"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_ooab_d[116].ooab002 = g_ooab_d_t[116].ooab002 #放回舊值
                  NEXT FIELD finance_AGL_2 
                END IF
                
            END IF
      




         BEFORE FIELD finance_AXR_1
            CALL aoos020_show_field_help("ooab_t","S-FIN-1002")
 
         AFTER FIELD finance_AXR_1
         

         BEFORE FIELD finance_AXR_2
            CALL aoos020_show_field_help("ooab_t","S-FIN-1003")
 
         AFTER FIELD finance_AXR_2
         

         BEFORE FIELD finance_AXR_3
            CALL aoos020_show_field_help("ooab_t","S-FIN-1004")
 
         AFTER FIELD finance_AXR_3
              #此段落由子樣板ss03產生(Version:2)
             
             IF NOT cl_null(g_ooab_d[119].ooab002)  AND g_ooab_d[119].ooab002 <> g_ooab_d_t[119].ooab002  THEN  
                
                #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                INITIALIZE g_chkparam.* TO NULL
                #設定g_chkparam.*的參數
                LET g_chkparam.arg1 = g_ooab_d[119].ooab002
                #呼叫檢查存在的library
                IF NOT cl_chk_exist("v_oobx001") THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_ooab_d[119].ooab002
                  LET g_errparam.code   = "lib-00089"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_ooab_d[119].ooab002 = g_ooab_d_t[119].ooab002 #放回舊值
                  NEXT FIELD finance_AXR_3 
                END IF
                
            END IF
      




         BEFORE FIELD finance_AXR_4
            CALL aoos020_show_field_help("ooab_t","S-FIN-1005")
 
         AFTER FIELD finance_AXR_4
              #此段落由子樣板ss03產生(Version:2)
             
             IF NOT cl_null(g_ooab_d[120].ooab002)  AND g_ooab_d[120].ooab002 <> g_ooab_d_t[120].ooab002  THEN  
                
                #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                INITIALIZE g_chkparam.* TO NULL
                #設定g_chkparam.*的參數
                LET g_chkparam.arg1 = g_ooab_d[120].ooab002
                #呼叫檢查存在的library
                IF NOT cl_chk_exist("v_inaa001_11") THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_ooab_d[120].ooab002
                  LET g_errparam.code   = "lib-00089"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_ooab_d[120].ooab002 = g_ooab_d_t[120].ooab002 #放回舊值
                  NEXT FIELD finance_AXR_4 
                END IF
                
            END IF
      




         BEFORE FIELD finance_AXR_5
            CALL aoos020_show_field_help("ooab_t","S-FIN-1006")
 
         AFTER FIELD finance_AXR_5
              #此段落由子樣板ss03產生(Version:2)
             
             IF NOT cl_null(g_ooab_d[121].ooab002)  AND g_ooab_d[121].ooab002 <> g_ooab_d_t[121].ooab002  THEN  
                
                #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                INITIALIZE g_chkparam.* TO NULL
                #設定g_chkparam.*的參數
                LET g_chkparam.arg1 = g_ooab_d[121].ooab002
                #呼叫檢查存在的library
                IF NOT cl_chk_exist("v_inaa001_12") THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_ooab_d[121].ooab002
                  LET g_errparam.code   = "lib-00089"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_ooab_d[121].ooab002 = g_ooab_d_t[121].ooab002 #放回舊值
                  NEXT FIELD finance_AXR_5 
                END IF
                
            END IF
      




         BEFORE FIELD finance_AXR_6
            CALL aoos020_show_field_help("ooab_t","S-FIN-2012")
 
         AFTER FIELD finance_AXR_6
         

         BEFORE FIELD finance_AXR_7
            CALL aoos020_show_field_help("ooab_t","S-FIN-2010")
 
         AFTER FIELD finance_AXR_7
              #此段落由子樣板ss03產生(Version:2)
             
             IF NOT cl_null(g_ooab_d[123].ooab002)  AND g_ooab_d[123].ooab002 <> g_ooab_d_t[123].ooab002  THEN  
                
                #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                INITIALIZE g_chkparam.* TO NULL
                #設定g_chkparam.*的參數
                LET g_chkparam.arg1 = g_ooab_d[123].ooab002
                #呼叫檢查存在的library
                IF NOT cl_chk_exist("v_oodb002_3") THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_ooab_d[123].ooab002
                  LET g_errparam.code   = "lib-00089"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_ooab_d[123].ooab002 = g_ooab_d_t[123].ooab002 #放回舊值
                  NEXT FIELD finance_AXR_7 
                END IF
                
            END IF
      




         BEFORE FIELD finance_AXR_8
            CALL aoos020_show_field_help("ooab_t","S-FIN-2011")
 
         AFTER FIELD finance_AXR_8

         BEFORE FIELD finance_AXR_9
            CALL aoos020_show_field_help("ooab_t","S-FIN-2007")
 
         AFTER FIELD finance_AXR_9

          IF NOT cl_null (g_ooab_d[125].ooab002) THEN 
             
             IF NOT cl_chk_is_date(g_ooab_d[125].ooab002) THEN 
             
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = g_ooab_d[125].ooab002
                LET g_errparam.code   = "lib-00407"
                LET g_errparam.popup  = TRUE
                CALL cl_err()
                NEXT FIELD CURRENT 
 
             END IF 
          END IF 

         BEFORE FIELD finance_AXR_10
            CALL aoos020_show_field_help("ooab_t","S-FIN-2013")
 
         AFTER FIELD finance_AXR_10

         BEFORE FIELD finance_AXR_12
            CALL aoos020_show_field_help("ooab_t","S-FIN-2017")
 
         AFTER FIELD finance_AXR_12
         

         BEFORE FIELD finance_AXR_13
            CALL aoos020_show_field_help("ooab_t","S-FIN-2009")
 
         AFTER FIELD finance_AXR_13
         

         BEFORE FIELD finance_AXR_14
            CALL aoos020_show_field_help("ooab_t","S-FIN-2020")
 
         AFTER FIELD finance_AXR_14

         BEFORE FIELD finance_AXR_15
            CALL aoos020_show_field_help("ooab_t","S-FIN-2019")
 
         AFTER FIELD finance_AXR_15

         BEFORE FIELD finance_AXR_16
            CALL aoos020_show_field_help("ooab_t","S-FIN-2021")
 
         AFTER FIELD finance_AXR_16

         BEFORE FIELD finance_AXR_17
            CALL aoos020_show_field_help("ooab_t","S-FIN-2022")
 
         AFTER FIELD finance_AXR_17
         

         BEFORE FIELD finance_AXR_18
            CALL aoos020_show_field_help("ooab_t","S-FIN-2024")
 
         AFTER FIELD finance_AXR_18
         

         BEFORE FIELD finance_AAP_1
            CALL aoos020_show_field_help("ooab_t","S-FIN-2002")
 
         AFTER FIELD finance_AAP_1
         

         BEFORE FIELD finance_AAP_2
            CALL aoos020_show_field_help("ooab_t","S-FIN-3012")
 
         AFTER FIELD finance_AAP_2
         

         BEFORE FIELD finance_AAP_3
            CALL aoos020_show_field_help("ooab_t","S-FIN-3010")
 
         AFTER FIELD finance_AAP_3
              #此段落由子樣板ss03產生(Version:2)
             
             IF NOT cl_null(g_ooab_d[136].ooab002)  AND g_ooab_d[136].ooab002 <> g_ooab_d_t[136].ooab002  THEN  
                
                #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                INITIALIZE g_chkparam.* TO NULL
                #設定g_chkparam.*的參數
                LET g_chkparam.arg1 = g_ooab_d[136].ooab002
                #呼叫檢查存在的library
                IF NOT cl_chk_exist("v_oodb002_3") THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_ooab_d[136].ooab002
                  LET g_errparam.code   = "lib-00089"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_ooab_d[136].ooab002 = g_ooab_d_t[136].ooab002 #放回舊值
                  NEXT FIELD finance_AAP_3 
                END IF
                
            END IF
      




         BEFORE FIELD finance_AAP_4
            CALL aoos020_show_field_help("ooab_t","S-FIN-3011")
 
         AFTER FIELD finance_AAP_4

         BEFORE FIELD finance_AAP_10
            CALL aoos020_show_field_help("ooab_t","S-FIN-3003")
 
         AFTER FIELD finance_AAP_10
         

         BEFORE FIELD finance_AAP_11
            CALL aoos020_show_field_help("ooab_t","S-FIN-3004")
 
         AFTER FIELD finance_AAP_11
         

         BEFORE FIELD finance_AAP_12
            CALL aoos020_show_field_help("ooab_t","S-FIN-3005")
 
         AFTER FIELD finance_AAP_12
         

         BEFORE FIELD finance_AAP_13
            CALL aoos020_show_field_help("ooab_t","S-FIN-3006")
 
         AFTER FIELD finance_AAP_13
         

         BEFORE FIELD finance_AAP_21
            CALL aoos020_show_field_help("ooab_t","S-FIN-3007")
 
         AFTER FIELD finance_AAP_21

          IF NOT cl_null (g_ooab_d[142].ooab002) THEN 
             
             IF NOT cl_chk_is_date(g_ooab_d[142].ooab002) THEN 
             
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = g_ooab_d[142].ooab002
                LET g_errparam.code   = "lib-00407"
                LET g_errparam.popup  = TRUE
                CALL cl_err()
                NEXT FIELD CURRENT 
 
             END IF 
          END IF 

         BEFORE FIELD finance_AAP_22
            CALL aoos020_show_field_help("ooab_t","S-FIN-3008")
 
         AFTER FIELD finance_AAP_22

         BEFORE FIELD finance_AAP_23
            CALL aoos020_show_field_help("ooab_t","S-FIN-3015")
 
         AFTER FIELD finance_AAP_23

         BEFORE FIELD finance_AAP_25
            CALL aoos020_show_field_help("ooab_t","S-FIN-3009")
 
         AFTER FIELD finance_AAP_25
         

         BEFORE FIELD finance_AAP_26
            CALL aoos020_show_field_help("ooab_t","S-FIN-3020")
 
         AFTER FIELD finance_AAP_26

         BEFORE FIELD finance_AAP_27
            CALL aoos020_show_field_help("ooab_t","S-FIN-3017")
 
         AFTER FIELD finance_AAP_27
         

         BEFORE FIELD finance_AAP_28
            CALL aoos020_show_field_help("ooab_t","S-FIN-3018")
 
         AFTER FIELD finance_AAP_28
         

         BEFORE FIELD finance_AAP_29
            CALL aoos020_show_field_help("ooab_t","S-FIN-3019")
 
         AFTER FIELD finance_AAP_29
         

         BEFORE FIELD finance_AAP_30
            CALL aoos020_show_field_help("ooab_t","S-FIN-3021")
 
         AFTER FIELD finance_AAP_30
         

         BEFORE FIELD finance_ANM_1
            CALL aoos020_show_field_help("ooab_t","S-FIN-4001")
 
         AFTER FIELD finance_ANM_1
              #此段落由子樣板ss03產生(Version:2)
             
             IF NOT cl_null(g_ooab_d[151].ooab002)  AND g_ooab_d[151].ooab002 <> g_ooab_d_t[151].ooab002  THEN  
                
                #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                INITIALIZE g_chkparam.* TO NULL
                #設定g_chkparam.*的參數
                LET g_chkparam.arg1 = g_ooab_d[151].ooab002
                #呼叫檢查存在的library
                IF NOT cl_chk_exist("v_ooal002") THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_ooab_d[151].ooab002
                  LET g_errparam.code   = "lib-00089"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_ooab_d[151].ooab002 = g_ooab_d_t[151].ooab002 #放回舊值
                  NEXT FIELD finance_ANM_1 
                END IF
                
            END IF
      




         BEFORE FIELD finance_ANM_2
            CALL aoos020_show_field_help("ooab_t","S-FIN-4007")
 
         AFTER FIELD finance_ANM_2

          IF NOT cl_null (g_ooab_d[152].ooab002) THEN 
             
             IF NOT cl_chk_is_date(g_ooab_d[152].ooab002) THEN 
             
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = g_ooab_d[152].ooab002
                LET g_errparam.code   = "lib-00407"
                LET g_errparam.popup  = TRUE
                CALL cl_err()
                NEXT FIELD CURRENT 
 
             END IF 
          END IF 

         BEFORE FIELD finance_ANM_3
            CALL aoos020_show_field_help("ooab_t","S-FIN-4012")
 
         AFTER FIELD finance_ANM_3
         

         BEFORE FIELD finance_ANM_4
            CALL aoos020_show_field_help("ooab_t","S-FIN-4004")
 
         AFTER FIELD finance_ANM_4
         

         BEFORE FIELD finance_ANM_5
            CALL aoos020_show_field_help("ooab_t","S-FIN-4008")
 
         AFTER FIELD finance_ANM_5
         

         BEFORE FIELD finance_ANM_6
            CALL aoos020_show_field_help("ooab_t","S-FIN-4009")
 
         AFTER FIELD finance_ANM_6
         

         BEFORE FIELD finance_ANM_7
            CALL aoos020_show_field_help("ooab_t","S-FIN-4010")
 
         AFTER FIELD finance_ANM_7
         

         BEFORE FIELD finance_ANM_8
            CALL aoos020_show_field_help("ooab_t","S-FIN-4011")
 
         AFTER FIELD finance_ANM_8
         

         BEFORE FIELD finance_ANM_9
            CALL aoos020_show_field_help("ooab_t","S-FIN-3016")
 
         AFTER FIELD finance_ANM_9

         BEFORE FIELD finance_ANM_10
            CALL aoos020_show_field_help("ooab_t","S-FIN-4015")
 
         AFTER FIELD finance_ANM_10
         

         BEFORE FIELD finance_ANM_11
            CALL aoos020_show_field_help("ooab_t","S-FIN-4016")
 
         AFTER FIELD finance_ANM_11
         

         BEFORE FIELD finance_AFM_1
            CALL aoos020_show_field_help("ooab_t","S-FIN-4013")
 
         AFTER FIELD finance_AFM_1

         BEFORE FIELD finance_AFM_2
            CALL aoos020_show_field_help("ooab_t","S-FIN-4014")
 
         AFTER FIELD finance_AFM_2

         BEFORE FIELD finance_AFA_1
            CALL aoos020_show_field_help("ooab_t","S-FIN-9009")
 
         AFTER FIELD finance_AFA_1
         

         BEFORE FIELD finance_AFA_2
            CALL aoos020_show_field_help("ooab_t","S-FIN-9005")
 
         AFTER FIELD finance_AFA_2

         BEFORE FIELD finance_AFA_3
            CALL aoos020_show_field_help("ooab_t","S-FIN-9002")
 
         AFTER FIELD finance_AFA_3

         BEFORE FIELD finance_AFA_4
            CALL aoos020_show_field_help("ooab_t","S-FIN-9010")
 
         AFTER FIELD finance_AFA_4

         BEFORE FIELD finance_AFA_5
            CALL aoos020_show_field_help("ooab_t","S-FIN-9003")
 
         AFTER FIELD finance_AFA_5

          IF NOT cl_null (g_ooab_d[168].ooab002) THEN 
             
             IF NOT cl_chk_is_date(g_ooab_d[168].ooab002) THEN 
             
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = g_ooab_d[168].ooab002
                LET g_errparam.code   = "lib-00407"
                LET g_errparam.popup  = TRUE
                CALL cl_err()
                NEXT FIELD CURRENT 
 
             END IF 
          END IF 

         BEFORE FIELD finance_AFA_6
            CALL aoos020_show_field_help("ooab_t","S-FIN-9016")
 
         AFTER FIELD finance_AFA_6
         

         BEFORE FIELD finance_AFA_7
            CALL aoos020_show_field_help("ooab_t","S-FIN-9017")
 
         AFTER FIELD finance_AFA_7

         BEFORE FIELD finance_AFA_8
            CALL aoos020_show_field_help("ooab_t","S-FIN-9015")
 
         AFTER FIELD finance_AFA_8

         BEFORE FIELD finance_AFA_9
            CALL aoos020_show_field_help("ooab_t","S-FIN-9018")
 
         AFTER FIELD finance_AFA_9
         #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooab_d[172].ooab002,"2000","0","","","azz-00079",1) THEN
               NEXT FIELD finance_AFA_9
            END IF 



         #此段落由子樣板ss01產生
            IF NOT cl_null(g_ooab_d[172].ooab002) THEN
               LET ls_tmp = g_ooab_d[172].ooab002
               IF ls_tmp.getIndexOf(".",1) THEN                  
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.extend = g_ooab_d[172].ooab002
                   LET g_errparam.code   = "azz-00138"
                   LET g_errparam.popup  = TRUE
                   CALL cl_err()
                   NEXT FIELD finance_AFA_9
               END IF   
            END IF


         

         BEFORE FIELD finance_AFA_10
            CALL aoos020_show_field_help("ooab_t","S-FIN-9019")
 
         AFTER FIELD finance_AFA_10
         #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooab_d[173].ooab002,"1","1","13","1","azz-00087",1) THEN
               NEXT FIELD finance_AFA_10
            END IF 



         #此段落由子樣板ss01產生
            IF NOT cl_null(g_ooab_d[173].ooab002) THEN
               LET ls_tmp = g_ooab_d[173].ooab002
               IF ls_tmp.getIndexOf(".",1) THEN                  
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.extend = g_ooab_d[173].ooab002
                   LET g_errparam.code   = "azz-00138"
                   LET g_errparam.popup  = TRUE
                   CALL cl_err()
                   NEXT FIELD finance_AFA_10
               END IF   
            END IF


         

         BEFORE FIELD finance_CIT_1
            CALL aoos020_show_field_help("ooab_t","S-FIN-7001")
 
         AFTER FIELD finance_CIT_1

         BEFORE FIELD finance_CIT_2
            CALL aoos020_show_field_help("ooab_t","S-FIN-7002")
 
         AFTER FIELD finance_CIT_2

         BEFORE FIELD finance_CIT_3
            CALL aoos020_show_field_help("ooab_t","S-FIN-2023")
 
         AFTER FIELD finance_CIT_3
         

         BEFORE FIELD manufactor_wo_1
            CALL aoos020_show_field_help("ooab_t","S-MFG-0056")
 
         AFTER FIELD manufactor_wo_1
         

         BEFORE FIELD manufactor_wo_2
            CALL aoos020_show_field_help("ooab_t","S-MFG-0055")
 
         AFTER FIELD manufactor_wo_2

         BEFORE FIELD manufactor_wo_3
            CALL aoos020_show_field_help("ooab_t","S-MFG-0002")
 
         AFTER FIELD manufactor_wo_3
         

         BEFORE FIELD manufactor_routing_1
            CALL aoos020_show_field_help("ooab_t","S-MFG-0033")
 
         AFTER FIELD manufactor_routing_1

         BEFORE FIELD manufactor_routing_2
            CALL aoos020_show_field_help("ooab_t","S-MFG-0035")
 
         AFTER FIELD manufactor_routing_2
              #此段落由子樣板ss03產生(Version:2)
             
             IF NOT cl_null(g_ooab_d[181].ooab002)  AND g_ooab_d[181].ooab002 <> g_ooab_d_t[181].ooab002  THEN  
                
                #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                INITIALIZE g_chkparam.* TO NULL
                #設定g_chkparam.*的參數
                LET g_chkparam.arg1 = g_ooab_d[181].ooab002
                #呼叫檢查存在的library
                IF NOT cl_chk_exist("v_ooba002_10") THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_ooab_d[181].ooab002
                  LET g_errparam.code   = "lib-00089"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_ooab_d[181].ooab002 = g_ooab_d_t[181].ooab002 #放回舊值
                  NEXT FIELD manufactor_routing_2 
                END IF
                
            END IF
      




         BEFORE FIELD APS_base_1
            CALL aoos020_show_field_help("ooab_t","S-MFG-0036")
 
         AFTER FIELD APS_base_1
         

         BEFORE FIELD APS_base_2
            CALL aoos020_show_field_help("ooab_t","S-MFG-0039")
 
         AFTER FIELD APS_base_2
         #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooab_d[183].ooab002,"1","1","120","1","azz-00087",1) THEN
               NEXT FIELD APS_base_2
            END IF 



         

         BEFORE FIELD APS_aps_runtime_1
            CALL aoos020_show_field_help("ooab_t","S-MFG-0050")
 
         AFTER FIELD APS_aps_runtime_1
              #此段落由子樣板ss03產生(Version:2)
             
             IF NOT cl_null(g_ooab_d[184].ooab002)  AND g_ooab_d[184].ooab002 <> g_ooab_d_t[184].ooab002  THEN  
                
                #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                INITIALIZE g_chkparam.* TO NULL
                #設定g_chkparam.*的參數
                LET g_chkparam.arg1 = g_ooab_d[184].ooab002
                #呼叫檢查存在的library
                IF NOT cl_chk_exist("v_psca001") THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_ooab_d[184].ooab002
                  LET g_errparam.code   = "lib-00089"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_ooab_d[184].ooab002 = g_ooab_d_t[184].ooab002 #放回舊值
                  NEXT FIELD APS_aps_runtime_1 
                END IF
                
            END IF
      




         BEFORE FIELD APS_aps_runtime_2
            CALL aoos020_show_field_help("ooab_t","S-MFG-0052")
 
         AFTER FIELD APS_aps_runtime_2
         #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooab_d[185].ooab002,"0","1","1000","1","azz-00087",1) THEN
               NEXT FIELD APS_aps_runtime_2
            END IF 



         

         BEFORE FIELD APS_aps_runtime_3
            CALL aoos020_show_field_help("ooab_t","S-MFG-0053")
 
         AFTER FIELD APS_aps_runtime_3

         BEFORE FIELD APS_aps_runtime_4
            CALL aoos020_show_field_help("ooab_t","S-MFG-0054")
 
         AFTER FIELD APS_aps_runtime_4
         #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooab_d[187].ooab002,"0","1","1000","1","azz-00087",1) THEN
               NEXT FIELD APS_aps_runtime_4
            END IF 



         

         BEFORE FIELD APS_apsadv_1
            CALL aoos020_show_field_help("ooab_t","S-MFG-0057")
 
         AFTER FIELD APS_apsadv_1
         

         BEFORE FIELD APS_apsadv_2
            CALL aoos020_show_field_help("ooab_t","S-MFG-0058")
 
         AFTER FIELD APS_apsadv_2
         

         BEFORE FIELD APS_apsadv_3
            CALL aoos020_show_field_help("ooab_t","S-MFG-0059")
 
         AFTER FIELD APS_apsadv_3
         

         BEFORE FIELD APS_apsadv_4
            CALL aoos020_show_field_help("ooab_t","S-MFG-0063")
 
         AFTER FIELD APS_apsadv_4
         

         BEFORE FIELD APS_apsadv_5
            CALL aoos020_show_field_help("ooab_t","S-MFG-0064")
 
         AFTER FIELD APS_apsadv_5
         

         BEFORE FIELD APS_apsadv_6
            CALL aoos020_show_field_help("ooab_t","S-MFG-0060")
 
         AFTER FIELD APS_apsadv_6
         

         BEFORE FIELD APS_apsadv_7
            CALL aoos020_show_field_help("ooab_t","S-MFG-0061")
 
         AFTER FIELD APS_apsadv_7
         

         BEFORE FIELD APS_apsadv_8
            CALL aoos020_show_field_help("ooab_t","S-MFG-0062")
 
         AFTER FIELD APS_apsadv_8
         
         
            IF NOT cl_null (g_ooab_d[195].ooab002) THEN 
             
               IF g_ooab_d[195].ooab002 <> g_ooab_d_t[195].ooab002 THEN 
             
                  LET g_ooab_d[195].ooab002 = cl_hashkey_user_encode(g_ooab_d[195].ooab002) 

               END IF 
            END IF 
         BEFORE FIELD AQC_base_1
            CALL aoos020_show_field_help("ooab_t","S-MFG-0046")
 
         AFTER FIELD AQC_base_1
              #此段落由子樣板ss03產生(Version:2)
             
             IF NOT cl_null(g_ooab_d[196].ooab002)  AND g_ooab_d[196].ooab002 <> g_ooab_d_t[196].ooab002  THEN  
                
                #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                INITIALIZE g_chkparam.* TO NULL
                #設定g_chkparam.*的參數
                LET g_chkparam.arg1 = g_ooab_d[196].ooab002
                #呼叫檢查存在的library
                IF NOT cl_chk_exist("v_ooal002_5") THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_ooab_d[196].ooab002
                  LET g_errparam.code   = "lib-00089"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_ooab_d[196].ooab002 = g_ooab_d_t[196].ooab002 #放回舊值
                  NEXT FIELD AQC_base_1 
                END IF
                
            END IF
      




         BEFORE FIELD abx_base_1
            CALL aoos020_show_field_help("ooab_t","S-MFG-0065")
 
         AFTER FIELD abx_base_1
         #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooab_d[197].ooab002,"","0","","0","azz-00079",1) THEN
               NEXT FIELD abx_base_1
            END IF 



         #此段落由子樣板ss01產生
            IF NOT cl_null(g_ooab_d[197].ooab002) THEN
               LET ls_tmp = g_ooab_d[197].ooab002
               IF ls_tmp.getIndexOf(".",1) THEN                  
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.extend = g_ooab_d[197].ooab002
                   LET g_errparam.code   = "azz-00138"
                   LET g_errparam.popup  = TRUE
                   CALL cl_err()
                   NEXT FIELD abx_base_1
               END IF   
            END IF


         

         BEFORE FIELD abx_base_2
            CALL aoos020_show_field_help("ooab_t","S-MFG-0066")
 
         AFTER FIELD abx_base_2

          IF NOT cl_null (g_ooab_d[198].ooab002) THEN 
             
             IF NOT cl_chk_is_date(g_ooab_d[198].ooab002) THEN 
             
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = g_ooab_d[198].ooab002
                LET g_errparam.code   = "lib-00407"
                LET g_errparam.popup  = TRUE
                CALL cl_err()
                NEXT FIELD CURRENT 
 
             END IF 
          END IF 

         BEFORE FIELD abx_base_3
            CALL aoos020_show_field_help("ooab_t","S-MFG-0067")
 
         AFTER FIELD abx_base_3

          IF NOT cl_null (g_ooab_d[199].ooab002) THEN 
             
             IF NOT cl_chk_is_date(g_ooab_d[199].ooab002) THEN 
             
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = g_ooab_d[199].ooab002
                LET g_errparam.code   = "lib-00407"
                LET g_errparam.popup  = TRUE
                CALL cl_err()
                NEXT FIELD CURRENT 
 
             END IF 
          END IF 

         BEFORE FIELD abx_base_4
            CALL aoos020_show_field_help("ooab_t","S-MFG-0068")
 
         AFTER FIELD abx_base_4

          IF NOT cl_null (g_ooab_d[200].ooab002) THEN 
             
             IF NOT cl_chk_is_date(g_ooab_d[200].ooab002) THEN 
             
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = g_ooab_d[200].ooab002
                LET g_errparam.code   = "lib-00407"
                LET g_errparam.popup  = TRUE
                CALL cl_err()
                NEXT FIELD CURRENT 
 
             END IF 
          END IF 

         BEFORE FIELD abx_base_5
            CALL aoos020_show_field_help("ooab_t","S-MFG-0069")
 
         AFTER FIELD abx_base_5
         

         BEFORE FIELD abx_base_6
            CALL aoos020_show_field_help("ooab_t","S-MFG-0070")
 
         AFTER FIELD abx_base_6
         

         BEFORE FIELD abx_base_7
            CALL aoos020_show_field_help("ooab_t","S-MFG-0071")
 
         AFTER FIELD abx_base_7
         

         BEFORE FIELD abx_base_8
            CALL aoos020_show_field_help("ooab_t","S-MFG-0072")
 
         AFTER FIELD abx_base_8
         

         BEFORE FIELD abx_base_9
            CALL aoos020_show_field_help("ooab_t","S-MFG-0074")
 
         AFTER FIELD abx_base_9
         

         BEFORE FIELD abc_bcse_1
            CALL aoos020_show_field_help("ooab_t","S-APP-0001")
 
         AFTER FIELD abc_bcse_1

         BEFORE FIELD abc_bcse_2
            CALL aoos020_show_field_help("ooab_t","S-APP-0012")
 
         AFTER FIELD abc_bcse_2

         BEFORE FIELD abc_bcse_3
            CALL aoos020_show_field_help("ooab_t","S-APP-0009")
 
         AFTER FIELD abc_bcse_3

         BEFORE FIELD abc_bcse_4
            CALL aoos020_show_field_help("ooab_t","S-APP-0010")
 
         AFTER FIELD abc_bcse_4

         BEFORE FIELD abc_bcse_5
            CALL aoos020_show_field_help("ooab_t","S-APP-0008")
 
         AFTER FIELD abc_bcse_5
         

         BEFORE FIELD abc_bcse_6
            CALL aoos020_show_field_help("ooab_t","S-APP-0011")
 
         AFTER FIELD abc_bcse_6
         

         BEFORE FIELD abc_bcse_7
            CALL aoos020_show_field_help("ooab_t","S-APP-0002")
 
         AFTER FIELD abc_bcse_7
              #此段落由子樣板ss03產生(Version:2)
             
             IF NOT cl_null(g_ooab_d[212].ooab002)  AND g_ooab_d[212].ooab002 <> g_ooab_d_t[212].ooab002  THEN  
                
                #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                INITIALIZE g_chkparam.* TO NULL
                #設定g_chkparam.*的參數
                LET g_chkparam.arg1 = g_ooab_d[212].ooab002
                #呼叫檢查存在的library
                IF NOT cl_chk_exist("v_ooba002_13") THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_ooab_d[212].ooab002
                  LET g_errparam.code   = "lib-00089"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_ooab_d[212].ooab002 = g_ooab_d_t[212].ooab002 #放回舊值
                  NEXT FIELD abc_bcse_7 
                END IF
                
            END IF
      




         BEFORE FIELD abc_bcse_8
            CALL aoos020_show_field_help("ooab_t","S-APP-0003")
 
         AFTER FIELD abc_bcse_8
              #此段落由子樣板ss03產生(Version:2)
             
             IF NOT cl_null(g_ooab_d[213].ooab002)  AND g_ooab_d[213].ooab002 <> g_ooab_d_t[213].ooab002  THEN  
                
                #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                INITIALIZE g_chkparam.* TO NULL
                #設定g_chkparam.*的參數
                LET g_chkparam.arg1 = g_ooab_d[213].ooab002
                #呼叫檢查存在的library
                IF NOT cl_chk_exist("v_ooba002_14") THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_ooab_d[213].ooab002
                  LET g_errparam.code   = "lib-00089"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_ooab_d[213].ooab002 = g_ooab_d_t[213].ooab002 #放回舊值
                  NEXT FIELD abc_bcse_8 
                END IF
                
            END IF
      




         BEFORE FIELD abc_bcse_9
            CALL aoos020_show_field_help("ooab_t","S-APP-0004")
 
         AFTER FIELD abc_bcse_9
              #此段落由子樣板ss03產生(Version:2)
             
             IF NOT cl_null(g_ooab_d[214].ooab002)  AND g_ooab_d[214].ooab002 <> g_ooab_d_t[214].ooab002  THEN  
                
                #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                INITIALIZE g_chkparam.* TO NULL
                #設定g_chkparam.*的參數
                LET g_chkparam.arg1 = g_ooab_d[214].ooab002
                #呼叫檢查存在的library
                IF NOT cl_chk_exist("v_ooba002_15") THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_ooab_d[214].ooab002
                  LET g_errparam.code   = "lib-00089"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_ooab_d[214].ooab002 = g_ooab_d_t[214].ooab002 #放回舊值
                  NEXT FIELD abc_bcse_9 
                END IF
                
            END IF
      




         BEFORE FIELD abc_bcse_10
            CALL aoos020_show_field_help("ooab_t","S-APP-0005")
 
         AFTER FIELD abc_bcse_10
              #此段落由子樣板ss03產生(Version:2)
             
             IF NOT cl_null(g_ooab_d[215].ooab002)  AND g_ooab_d[215].ooab002 <> g_ooab_d_t[215].ooab002  THEN  
                
                #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                INITIALIZE g_chkparam.* TO NULL
                #設定g_chkparam.*的參數
                LET g_chkparam.arg1 = g_ooab_d[215].ooab002
                #呼叫檢查存在的library
                IF NOT cl_chk_exist("v_ooba002_16") THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_ooab_d[215].ooab002
                  LET g_errparam.code   = "lib-00089"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_ooab_d[215].ooab002 = g_ooab_d_t[215].ooab002 #放回舊值
                  NEXT FIELD abc_bcse_10 
                END IF
                
            END IF
      




         BEFORE FIELD abc_bcse_11
            CALL aoos020_show_field_help("ooab_t","S-APP-0006")
 
         AFTER FIELD abc_bcse_11
              #此段落由子樣板ss03產生(Version:2)
             
             IF NOT cl_null(g_ooab_d[216].ooab002)  AND g_ooab_d[216].ooab002 <> g_ooab_d_t[216].ooab002  THEN  
                
                #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                INITIALIZE g_chkparam.* TO NULL
                #設定g_chkparam.*的參數
                LET g_chkparam.arg1 = g_ooab_d[216].ooab002
                #呼叫檢查存在的library
                IF NOT cl_chk_exist("v_inaa001_11") THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_ooab_d[216].ooab002
                  LET g_errparam.code   = "lib-00089"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_ooab_d[216].ooab002 = g_ooab_d_t[216].ooab002 #放回舊值
                  NEXT FIELD abc_bcse_11 
                END IF
                
            END IF
      




         BEFORE FIELD abc_bcse_12
            CALL aoos020_show_field_help("ooab_t","S-APP-0007")
 
         AFTER FIELD abc_bcse_12
              #此段落由子樣板ss03產生(Version:2)
             
             IF NOT cl_null(g_ooab_d[217].ooab002)  AND g_ooab_d[217].ooab002 <> g_ooab_d_t[217].ooab002  THEN  
                
                #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                INITIALIZE g_chkparam.* TO NULL
                #設定g_chkparam.*的參數
                LET g_chkparam.arg1 = g_ooab_d[217].ooab002
                #呼叫檢查存在的library
                IF NOT cl_chk_exist("v_inaa001_12") THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_ooab_d[217].ooab002
                  LET g_errparam.code   = "lib-00089"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_ooab_d[217].ooab002 = g_ooab_d_t[217].ooab002 #放回舊值
                  NEXT FIELD abc_bcse_12 
                END IF
                
            END IF
      




      
          
      ON ACTION controlp INFIELD sales_base_6
            #此段落由子樣板ss04產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooab_d[21].ooab002             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #${mdl_arg_desc1}

            CALL q_oocq002_24()                                #呼叫開窗

            LET g_ooab_d[21].ooab002 = g_qryparam.return1              

            DISPLAY g_ooab_d[21].ooab002 TO sales_base_6              #${mdl_desc$}

            NEXT FIELD sales_base_6                          #返回原欄位


      ON ACTION controlp INFIELD sales_base_7
            #此段落由子樣板ss04產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooab_d[22].ooab002             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #${mdl_arg_desc1}

            CALL q_oocq002_24()                                #呼叫開窗

            LET g_ooab_d[22].ooab002 = g_qryparam.return1              

            DISPLAY g_ooab_d[22].ooab002 TO sales_base_7              #${mdl_desc$}

            NEXT FIELD sales_base_7                          #返回原欄位


      ON ACTION controlp INFIELD sales_base_9
            #此段落由子樣板ss04產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooab_d[24].ooab002             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #${mdl_arg_desc1}

            CALL q_ooal002_15()                                #呼叫開窗

            LET g_ooab_d[24].ooab002 = g_qryparam.return1              

            DISPLAY g_ooab_d[24].ooab002 TO sales_base_9              #${mdl_desc$}

            NEXT FIELD sales_base_9                          #返回原欄位


      ON ACTION controlp INFIELD purchase_base_4
            #此段落由子樣板ss04產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooab_d[31].ooab002             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #${mdl_arg_desc1}

            CALL q_ooal002_14()                                #呼叫開窗

            LET g_ooab_d[31].ooab002 = g_qryparam.return1              

            DISPLAY g_ooab_d[31].ooab002 TO purchase_base_4              #${mdl_desc$}

            NEXT FIELD purchase_base_4                          #返回原欄位


      ON ACTION controlp INFIELD cirrection_autorepl_1
            #此段落由子樣板ss04產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooab_d[52].ooab002             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #${mdl_arg_desc1}

            CALL q_rtkh001()                                #呼叫開窗

            LET g_ooab_d[52].ooab002 = g_qryparam.return1              

            DISPLAY g_ooab_d[52].ooab002 TO cirrection_autorepl_1              #${mdl_desc$}

            NEXT FIELD cirrection_autorepl_1                          #返回原欄位


      ON ACTION controlp INFIELD cirrection_shelf_2
            #此段落由子樣板ss04產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooab_d[57].ooab002             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #${mdl_arg_desc1}

            CALL q_infc001_2()                                #呼叫開窗

            LET g_ooab_d[57].ooab002 = g_qryparam.return1              

            DISPLAY g_ooab_d[57].ooab002 TO cirrection_shelf_2              #${mdl_desc$}

            NEXT FIELD cirrection_shelf_2                          #返回原欄位


      ON ACTION controlp INFIELD cirrection_shelf_3
            #此段落由子樣板ss04產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooab_d[58].ooab002             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #${mdl_arg_desc1}

            CALL q_infc001_3()                                #呼叫開窗

            LET g_ooab_d[58].ooab002 = g_qryparam.return1              

            DISPLAY g_ooab_d[58].ooab002 TO cirrection_shelf_3              #${mdl_desc$}

            NEXT FIELD cirrection_shelf_3                          #返回原欄位


      ON ACTION controlp INFIELD cirrection_counter_10
            #此段落由子樣板ss04產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooab_d[68].ooab002             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #${mdl_arg_desc1}

            CALL q_ooca001_1()                                #呼叫開窗

            LET g_ooab_d[68].ooab002 = g_qryparam.return1              

            DISPLAY g_ooab_d[68].ooab002 TO cirrection_counter_10              #${mdl_desc$}

            NEXT FIELD cirrection_counter_10                          #返回原欄位


      ON ACTION controlp INFIELD cirrection_counter_11
            #此段落由子樣板ss04產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooab_d[69].ooab002             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #${mdl_arg_desc1}

            CALL q_rtda001_2()                                #呼叫開窗

            LET g_ooab_d[69].ooab002 = g_qryparam.return1              

            DISPLAY g_ooab_d[69].ooab002 TO cirrection_counter_11              #${mdl_desc$}

            NEXT FIELD cirrection_counter_11                          #返回原欄位


      ON ACTION controlp INFIELD cirrection_distribution_1
            #此段落由子樣板ss04產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooab_d[90].ooab002             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #${mdl_arg_desc1}

            CALL q_imaa001_23()                                #呼叫開窗

            LET g_ooab_d[90].ooab002 = g_qryparam.return1              

            DISPLAY g_ooab_d[90].ooab002 TO cirrection_distribution_1              #${mdl_desc$}

            NEXT FIELD cirrection_distribution_1                          #返回原欄位


      ON ACTION controlp INFIELD finance_AGL_1
            #此段落由子樣板ss04產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooab_d[115].ooab002             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #${mdl_arg_desc1}

            CALL q_glaald_1()                                #呼叫開窗

            LET g_ooab_d[115].ooab002 = g_qryparam.return1              

            DISPLAY g_ooab_d[115].ooab002 TO finance_AGL_1              #${mdl_desc$}

            NEXT FIELD finance_AGL_1                          #返回原欄位


      ON ACTION controlp INFIELD finance_AGL_2
            #此段落由子樣板ss04產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooab_d[116].ooab002             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #${mdl_arg_desc1}

            CALL q_glaald_2()                                #呼叫開窗

            LET g_ooab_d[116].ooab002 = g_qryparam.return1              

            DISPLAY g_ooab_d[116].ooab002 TO finance_AGL_2              #${mdl_desc$}

            NEXT FIELD finance_AGL_2                          #返回原欄位


      ON ACTION controlp INFIELD finance_AXR_3
            #此段落由子樣板ss04產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooab_d[119].ooab002             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #${mdl_arg_desc1}

            CALL q_ooba002_6()                                #呼叫開窗

            LET g_ooab_d[119].ooab002 = g_qryparam.return1              

            DISPLAY g_ooab_d[119].ooab002 TO finance_AXR_3              #${mdl_desc$}

            NEXT FIELD finance_AXR_3                          #返回原欄位


      ON ACTION controlp INFIELD finance_AXR_4
            #此段落由子樣板ss04產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooab_d[120].ooab002             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #${mdl_arg_desc1}

            CALL q_inaa001_16()                                #呼叫開窗

            LET g_ooab_d[120].ooab002 = g_qryparam.return1              

            DISPLAY g_ooab_d[120].ooab002 TO finance_AXR_4              #${mdl_desc$}

            NEXT FIELD finance_AXR_4                          #返回原欄位


      ON ACTION controlp INFIELD finance_AXR_5
            #此段落由子樣板ss04產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooab_d[121].ooab002             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #${mdl_arg_desc1}

            CALL q_inaa001_17()                                #呼叫開窗

            LET g_ooab_d[121].ooab002 = g_qryparam.return1              

            DISPLAY g_ooab_d[121].ooab002 TO finance_AXR_5              #${mdl_desc$}

            NEXT FIELD finance_AXR_5                          #返回原欄位


      ON ACTION controlp INFIELD finance_AXR_7
            #此段落由子樣板ss04產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooab_d[123].ooab002             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #${mdl_arg_desc1}

            CALL q_oodb_01()                                #呼叫開窗

            LET g_ooab_d[123].ooab002 = g_qryparam.return1              

            DISPLAY g_ooab_d[123].ooab002 TO finance_AXR_7              #${mdl_desc$}

            NEXT FIELD finance_AXR_7                          #返回原欄位


      ON ACTION controlp INFIELD finance_AXR_12
            #此段落由子樣板ss04產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooab_d[127].ooab002             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #${mdl_arg_desc1}

            CALL q_oocq002()                                #呼叫開窗

            LET g_ooab_d[127].ooab002 = g_qryparam.return1              

            DISPLAY g_ooab_d[127].ooab002 TO finance_AXR_12              #${mdl_desc$}

            NEXT FIELD finance_AXR_12                          #返回原欄位


      ON ACTION controlp INFIELD finance_AAP_3
            #此段落由子樣板ss04產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooab_d[136].ooab002             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #${mdl_arg_desc1}

            CALL q_oodb_01()                                #呼叫開窗

            LET g_ooab_d[136].ooab002 = g_qryparam.return1              

            DISPLAY g_ooab_d[136].ooab002 TO finance_AAP_3              #${mdl_desc$}

            NEXT FIELD finance_AAP_3                          #返回原欄位


      ON ACTION controlp INFIELD finance_AAP_27
            #此段落由子樣板ss04產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooab_d[147].ooab002             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #${mdl_arg_desc1}

            CALL q_ooba002()                                #呼叫開窗

            LET g_ooab_d[147].ooab002 = g_qryparam.return1              

            DISPLAY g_ooab_d[147].ooab002 TO finance_AAP_27              #${mdl_desc$}

            NEXT FIELD finance_AAP_27                          #返回原欄位


      ON ACTION controlp INFIELD finance_AAP_28
            #此段落由子樣板ss04產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooab_d[148].ooab002             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #${mdl_arg_desc1}

            CALL q_nmas002_5()                                #呼叫開窗

            LET g_ooab_d[148].ooab002 = g_qryparam.return1              

            DISPLAY g_ooab_d[148].ooab002 TO finance_AAP_28              #${mdl_desc$}

            NEXT FIELD finance_AAP_28                          #返回原欄位


      ON ACTION controlp INFIELD finance_AAP_29
            #此段落由子樣板ss04產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooab_d[149].ooab002             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #${mdl_arg_desc1}

            CALL q_nmaj001_2()                                #呼叫開窗

            LET g_ooab_d[149].ooab002 = g_qryparam.return1              

            DISPLAY g_ooab_d[149].ooab002 TO finance_AAP_29              #${mdl_desc$}

            NEXT FIELD finance_AAP_29                          #返回原欄位


      ON ACTION controlp INFIELD finance_ANM_1
            #此段落由子樣板ss04產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooab_d[151].ooab002             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #${mdl_arg_desc1}

            CALL q_ooal002_5()                                #呼叫開窗

            LET g_ooab_d[151].ooab002 = g_qryparam.return1              

            DISPLAY g_ooab_d[151].ooab002 TO finance_ANM_1              #${mdl_desc$}

            NEXT FIELD finance_ANM_1                          #返回原欄位


      ON ACTION controlp INFIELD finance_ANM_5
            #此段落由子樣板ss04產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooab_d[155].ooab002             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #${mdl_arg_desc1}

            CALL q_nmaj001()                                #呼叫開窗

            LET g_ooab_d[155].ooab002 = g_qryparam.return1              

            DISPLAY g_ooab_d[155].ooab002 TO finance_ANM_5              #${mdl_desc$}

            NEXT FIELD finance_ANM_5                          #返回原欄位


      ON ACTION controlp INFIELD finance_ANM_6
            #此段落由子樣板ss04產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooab_d[156].ooab002             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #${mdl_arg_desc1}

            CALL q_nmaj001()                                #呼叫開窗

            LET g_ooab_d[156].ooab002 = g_qryparam.return1              

            DISPLAY g_ooab_d[156].ooab002 TO finance_ANM_6              #${mdl_desc$}

            NEXT FIELD finance_ANM_6                          #返回原欄位


      ON ACTION controlp INFIELD finance_ANM_7
            #此段落由子樣板ss04產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooab_d[157].ooab002             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #${mdl_arg_desc1}

            CALL q_nmaj001()                                #呼叫開窗

            LET g_ooab_d[157].ooab002 = g_qryparam.return1              

            DISPLAY g_ooab_d[157].ooab002 TO finance_ANM_7              #${mdl_desc$}

            NEXT FIELD finance_ANM_7                          #返回原欄位


      ON ACTION controlp INFIELD finance_ANM_8
            #此段落由子樣板ss04產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooab_d[158].ooab002             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #${mdl_arg_desc1}

            CALL q_nmaj001()                                #呼叫開窗

            LET g_ooab_d[158].ooab002 = g_qryparam.return1              

            DISPLAY g_ooab_d[158].ooab002 TO finance_ANM_8              #${mdl_desc$}

            NEXT FIELD finance_ANM_8                          #返回原欄位


      ON ACTION controlp INFIELD manufactor_routing_2
            #此段落由子樣板ss04產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooab_d[181].ooab002             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #${mdl_arg_desc1}

            CALL q_ooba002_5()                                #呼叫開窗

            LET g_ooab_d[181].ooab002 = g_qryparam.return1              

            DISPLAY g_ooab_d[181].ooab002 TO manufactor_routing_2              #${mdl_desc$}

            NEXT FIELD manufactor_routing_2                          #返回原欄位


      ON ACTION controlp INFIELD APS_aps_runtime_1
            #此段落由子樣板ss04產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooab_d[184].ooab002             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #${mdl_arg_desc1}

            CALL q_psca001()                                #呼叫開窗

            LET g_ooab_d[184].ooab002 = g_qryparam.return1              

            DISPLAY g_ooab_d[184].ooab002 TO APS_aps_runtime_1              #${mdl_desc$}

            NEXT FIELD APS_aps_runtime_1                          #返回原欄位


      ON ACTION controlp INFIELD AQC_base_1
            #此段落由子樣板ss04產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooab_d[196].ooab002             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #${mdl_arg_desc1}

            CALL q_ooal002_4()                                #呼叫開窗

            LET g_ooab_d[196].ooab002 = g_qryparam.return1              

            DISPLAY g_ooab_d[196].ooab002 TO AQC_base_1              #${mdl_desc$}

            NEXT FIELD AQC_base_1                          #返回原欄位


      ON ACTION controlp INFIELD abc_bcse_7
            #此段落由子樣板ss04產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooab_d[212].ooab002             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #${mdl_arg_desc1}

            CALL q_ooba002_14()                                #呼叫開窗

            LET g_ooab_d[212].ooab002 = g_qryparam.return1              

            DISPLAY g_ooab_d[212].ooab002 TO abc_bcse_7              #${mdl_desc$}

            NEXT FIELD abc_bcse_7                          #返回原欄位


      ON ACTION controlp INFIELD abc_bcse_8
            #此段落由子樣板ss04產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooab_d[213].ooab002             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #${mdl_arg_desc1}

            CALL q_ooba002_15()                                #呼叫開窗

            LET g_ooab_d[213].ooab002 = g_qryparam.return1              

            DISPLAY g_ooab_d[213].ooab002 TO abc_bcse_8              #${mdl_desc$}

            NEXT FIELD abc_bcse_8                          #返回原欄位


      ON ACTION controlp INFIELD abc_bcse_9
            #此段落由子樣板ss04產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooab_d[214].ooab002             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #${mdl_arg_desc1}

            CALL q_ooba002_16()                                #呼叫開窗

            LET g_ooab_d[214].ooab002 = g_qryparam.return1              

            DISPLAY g_ooab_d[214].ooab002 TO abc_bcse_9              #${mdl_desc$}

            NEXT FIELD abc_bcse_9                          #返回原欄位


      ON ACTION controlp INFIELD abc_bcse_10
            #此段落由子樣板ss04產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooab_d[215].ooab002             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #${mdl_arg_desc1}

            CALL q_ooba002_17()                                #呼叫開窗

            LET g_ooab_d[215].ooab002 = g_qryparam.return1              

            DISPLAY g_ooab_d[215].ooab002 TO abc_bcse_10              #${mdl_desc$}

            NEXT FIELD abc_bcse_10                          #返回原欄位


      ON ACTION controlp INFIELD abc_bcse_11
            #此段落由子樣板ss04產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooab_d[216].ooab002             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #${mdl_arg_desc1}

            CALL q_inaa001_16()                                #呼叫開窗

            LET g_ooab_d[216].ooab002 = g_qryparam.return1              

            DISPLAY g_ooab_d[216].ooab002 TO abc_bcse_11              #${mdl_desc$}

            NEXT FIELD abc_bcse_11                          #返回原欄位


      ON ACTION controlp INFIELD abc_bcse_12
            #此段落由子樣板ss04產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooab_d[217].ooab002             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #${mdl_arg_desc1}

            CALL q_inaa001_17()                                #呼叫開窗

            LET g_ooab_d[217].ooab002 = g_qryparam.return1              

            DISPLAY g_ooab_d[217].ooab002 TO abc_bcse_12              #${mdl_desc$}

            NEXT FIELD abc_bcse_12                          #返回原欄位


      ON ACTION controlp INFIELD ooef001 
         CALL cl_site_select()
         LET g_ooef001 = g_site
         DISPLAY g_ooef001 TO ooef001
         CALL aoos020_fill_data()
         CALL cl_ask_confirm3("adz-00541","") 
         INITIALIZE g_ref_fields TO NULL 
         LET g_ref_fields[1] = g_ooef001  CALL ap_ref_array2(g_ref_fields," SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields 
         LET ooef001_desc = '', g_rtn_fields[1] , '' 
         DISPLAY BY NAME ooef001_desc 
      END INPUT
 
      
      ON ACTION basic
         CALL aoos020_parameter_switch("basic")
         NEXT FIELD basic_base_1
      ON ACTION doctype
         CALL aoos020_parameter_switch("doctype")
         NEXT FIELD doctype_base_80
      ON ACTION aws
         CALL aoos020_parameter_switch("aws")
         NEXT FIELD aws_B2B_1
      ON ACTION inv
         CALL aoos020_parameter_switch("inv")
         NEXT FIELD inv_Base_1
      ON ACTION sales
         CALL aoos020_parameter_switch("sales")
         NEXT FIELD sales_base_2
      ON ACTION purchase
         CALL aoos020_parameter_switch("purchase")
         NEXT FIELD purchase_base_1
      ON ACTION cirrection
         CALL aoos020_parameter_switch("cirrection")
         NEXT FIELD cirrection_base_1
      ON ACTION finance
         CALL aoos020_parameter_switch("finance")
         NEXT FIELD finance_AXC_1
      ON ACTION manufactor
         CALL aoos020_parameter_switch("manufactor")
         NEXT FIELD manufactor_wo_1
      ON ACTION APS
         CALL aoos020_parameter_switch("APS")
         NEXT FIELD APS_base_1
      ON ACTION AQC
         CALL aoos020_parameter_switch("AQC")
         NEXT FIELD AQC_base_1
      ON ACTION abx
         CALL aoos020_parameter_switch("abx")
         NEXT FIELD abx_base_1
      ON ACTION abc
         CALL aoos020_parameter_switch("abc")
         NEXT FIELD abc_bcse_1
 
      
      ON ACTION btn_paramsubgp1_1
         CALL aoos020_parameter_group_switch("paramsubgp1_1")
      ON ACTION btn_paramsubgp2_1
         CALL aoos020_parameter_group_switch("paramsubgp2_1")
      ON ACTION btn_paramsubgp3_1
         CALL aoos020_parameter_group_switch("paramsubgp3_1")
      ON ACTION btn_paramsubgp3_2
         CALL aoos020_parameter_group_switch("paramsubgp3_2")
      ON ACTION btn_paramsubgp3_3
         CALL aoos020_parameter_group_switch("paramsubgp3_3")
      ON ACTION btn_paramsubgp3_4
         CALL aoos020_parameter_group_switch("paramsubgp3_4")
      ON ACTION btn_paramsubgp3_5
         CALL aoos020_parameter_group_switch("paramsubgp3_5")
      ON ACTION btn_paramsubgp4_1
         CALL aoos020_parameter_group_switch("paramsubgp4_1")
      ON ACTION btn_paramsubgp5_1
         CALL aoos020_parameter_group_switch("paramsubgp5_1")
      ON ACTION btn_paramsubgp5_2
         CALL aoos020_parameter_group_switch("paramsubgp5_2")
      ON ACTION btn_paramsubgp6_1
         CALL aoos020_parameter_group_switch("paramsubgp6_1")
      ON ACTION btn_paramsubgp6_2
         CALL aoos020_parameter_group_switch("paramsubgp6_2")
      ON ACTION btn_paramsubgp6_3
         CALL aoos020_parameter_group_switch("paramsubgp6_3")
      ON ACTION btn_paramsubgp7_1
         CALL aoos020_parameter_group_switch("paramsubgp7_1")
      ON ACTION btn_paramsubgp7_2
         CALL aoos020_parameter_group_switch("paramsubgp7_2")
      ON ACTION btn_paramsubgp7_3
         CALL aoos020_parameter_group_switch("paramsubgp7_3")
      ON ACTION btn_paramsubgp7_4
         CALL aoos020_parameter_group_switch("paramsubgp7_4")
      ON ACTION btn_paramsubgp7_5
         CALL aoos020_parameter_group_switch("paramsubgp7_5")
      ON ACTION btn_paramsubgp7_6
         CALL aoos020_parameter_group_switch("paramsubgp7_6")
      ON ACTION btn_paramsubgp7_7
         CALL aoos020_parameter_group_switch("paramsubgp7_7")
      ON ACTION btn_paramsubgp8_1
         CALL aoos020_parameter_group_switch("paramsubgp8_1")
      ON ACTION btn_paramsubgp8_2
         CALL aoos020_parameter_group_switch("paramsubgp8_2")
      ON ACTION btn_paramsubgp8_3
         CALL aoos020_parameter_group_switch("paramsubgp8_3")
      ON ACTION btn_paramsubgp8_4
         CALL aoos020_parameter_group_switch("paramsubgp8_4")
      ON ACTION btn_paramsubgp8_5
         CALL aoos020_parameter_group_switch("paramsubgp8_5")
      ON ACTION btn_paramsubgp8_6
         CALL aoos020_parameter_group_switch("paramsubgp8_6")
      ON ACTION btn_paramsubgp8_7
         CALL aoos020_parameter_group_switch("paramsubgp8_7")
      ON ACTION btn_paramsubgp8_8
         CALL aoos020_parameter_group_switch("paramsubgp8_8")
      ON ACTION btn_paramsubgp9_1
         CALL aoos020_parameter_group_switch("paramsubgp9_1")
      ON ACTION btn_paramsubgp9_2
         CALL aoos020_parameter_group_switch("paramsubgp9_2")
      ON ACTION btn_paramsubgp10_1
         CALL aoos020_parameter_group_switch("paramsubgp10_1")
      ON ACTION btn_paramsubgp10_2
         CALL aoos020_parameter_group_switch("paramsubgp10_2")
      ON ACTION btn_paramsubgp10_3
         CALL aoos020_parameter_group_switch("paramsubgp10_3")
      ON ACTION btn_paramsubgp11_1
         CALL aoos020_parameter_group_switch("paramsubgp11_1")
      ON ACTION btn_paramsubgp12_1
         CALL aoos020_parameter_group_switch("paramsubgp12_1")
      ON ACTION btn_paramsubgp13_1
         CALL aoos020_parameter_group_switch("paramsubgp13_1")
 
      # 以下為每一個欄位的說明功能鍵
      
      ON ACTION help_basic_base_1
         CALL aoos020_show_field_help("ooab_t","S-SYS-0001")
      ON ACTION help_doctype_base_80
         CALL aoos020_show_field_help("ooab_t","S-COM-0002")
      ON ACTION help_doctype_base_92
         CALL aoos020_show_field_help("ooab_t","S-COM-0004")
      ON ACTION help_doctype_base_94
         CALL aoos020_show_field_help("ooab_t","S-COM-0006")
      ON ACTION help_doctype_base_95
         CALL aoos020_show_field_help("ooab_t","S-BAS-0029")
      ON ACTION help_doctype_base_96
         CALL aoos020_show_field_help("ooab_t","S-BAS-0030")
      ON ACTION help_doctype_base_97
         CALL aoos020_show_field_help("ooab_t","S-BAS-0031")
      ON ACTION help_doctype_base_98
         CALL aoos020_show_field_help("ooab_t","S-BAS-0032")
      ON ACTION help_aws_B2B_1
         CALL aoos020_show_field_help("ooab_t","S-SYS-0002")
      ON ACTION help_aws_MES_1
         CALL aoos020_show_field_help("ooab_t","S-SYS-0003")
      ON ACTION help_aws_HRM_1
         CALL aoos020_show_field_help("ooab_t","S-SYS-0004")
      ON ACTION help_aws_Light_1
         CALL aoos020_show_field_help("ooab_t","S-SYS-0005")
      ON ACTION help_aws_EBCHAIN_1
         CALL aoos020_show_field_help("ooab_t","S-SYS-0006")
      ON ACTION help_inv_Base_1
         CALL aoos020_show_field_help("ooab_t","S-BAS-0028")
      ON ACTION help_inv_Base_2
         CALL aoos020_show_field_help("ooab_t","S-BAS-0036")
      ON ACTION help_inv_Base_5
         CALL aoos020_show_field_help("ooab_t","S-MFG-0031")
      ON ACTION help_sales_base_2
         CALL aoos020_show_field_help("ooab_t","S-BAS-0018")
      ON ACTION help_sales_base_3
         CALL aoos020_show_field_help("ooab_t","S-BAS-0023")
      ON ACTION help_sales_base_4
         CALL aoos020_show_field_help("ooab_t","S-BAS-0007")
      ON ACTION help_sales_base_5
         CALL aoos020_show_field_help("ooab_t","S-BAS-0034")
      ON ACTION help_sales_base_6
         CALL aoos020_show_field_help("ooab_t","S-BAS-0047")
      ON ACTION help_sales_base_7
         CALL aoos020_show_field_help("ooab_t","S-BAS-0051")
      ON ACTION help_sales_base_8
         CALL aoos020_show_field_help("ooab_t","S-BAS-0048")
      ON ACTION help_sales_base_9
         CALL aoos020_show_field_help("ooab_t","S-BAS-0009")
      ON ACTION help_sales_exchange_1
         CALL aoos020_show_field_help("ooab_t","S-BAS-0010")
      ON ACTION help_sales_exchange_2
         CALL aoos020_show_field_help("ooab_t","S-BAS-0011")
      ON ACTION help_sales_exchange_4
         CALL aoos020_show_field_help("ooab_t","S-BAS-0013")
      ON ACTION help_purchase_base_1
         CALL aoos020_show_field_help("ooab_t","S-BAS-0017")
      ON ACTION help_purchase_base_2
         CALL aoos020_show_field_help("ooab_t","S-BAS-0019")
      ON ACTION help_purchase_base_3
         CALL aoos020_show_field_help("ooab_t","S-BAS-0020")
      ON ACTION help_purchase_base_4
         CALL aoos020_show_field_help("ooab_t","S-BAS-0021")
      ON ACTION help_purchase_base_5
         CALL aoos020_show_field_help("ooab_t","S-BAS-0022")
      ON ACTION help_purchase_base_6
         CALL aoos020_show_field_help("ooab_t","S-BAS-0043")
      ON ACTION help_purchase_base_7
         CALL aoos020_show_field_help("ooab_t","S-BAS-0044")
      ON ACTION help_purchase_base_8
         CALL aoos020_show_field_help("ooab_t","S-BAS-0045")
      ON ACTION help_purchase_base_9
         CALL aoos020_show_field_help("ooab_t","S-BAS-0046")
      ON ACTION help_purchase_base_10
         CALL aoos020_show_field_help("ooab_t","S-BAS-0033")
      ON ACTION help_purchase_base_11
         CALL aoos020_show_field_help("ooab_t","S-BAS-0049")
      ON ACTION help_purchase_base_12
         CALL aoos020_show_field_help("ooab_t","S-BAS-0050")
      ON ACTION help_purchase_exchange_1
         CALL aoos020_show_field_help("ooab_t","S-BAS-0014")
      ON ACTION help_purchase_exchange_2
         CALL aoos020_show_field_help("ooab_t","S-BAS-0015")
      ON ACTION help_purchase_leadtime_1
         CALL aoos020_show_field_help("ooab_t","S-BAS-0024")
      ON ACTION help_purchase_leadtime_2
         CALL aoos020_show_field_help("ooab_t","S-BAS-0025")
      ON ACTION help_purchase_leadtime_3
         CALL aoos020_show_field_help("ooab_t","S-BAS-0026")
      ON ACTION help_purchase_leadtime_4
         CALL aoos020_show_field_help("ooab_t","S-BAS-0027")
      ON ACTION help_cirrection_base_1
         CALL aoos020_show_field_help("ooab_t","S-CIR-0003")
      ON ACTION help_cirrection_base_2
         CALL aoos020_show_field_help("ooab_t","S-CIR-0001")
      ON ACTION help_cirrection_base_7
         CALL aoos020_show_field_help("ooab_t","S-BAS-0035")
      ON ACTION help_cirrection_base_8
         CALL aoos020_show_field_help("ooab_t","S-CIR-2008")
      ON ACTION help_cirrection_base_9
         CALL aoos020_show_field_help("ooab_t","S-CIR-2015")
      ON ACTION help_cirrection_base_10
         CALL aoos020_show_field_help("ooab_t","S-CIR-2037")
      ON ACTION help_cirrection_autorepl_1
         CALL aoos020_show_field_help("ooab_t","S-CIR-1000")
      ON ACTION help_cirrection_autorepl_2
         CALL aoos020_show_field_help("ooab_t","S-CIR-1001")
      ON ACTION help_cirrection_autorepl_3
         CALL aoos020_show_field_help("ooab_t","S-CIR-1002")
      ON ACTION help_cirrection_autorepl_4
         CALL aoos020_show_field_help("ooab_t","S-CIR-1003")
      ON ACTION help_cirrection_shelf_1
         CALL aoos020_show_field_help("ooab_t","S-CIR-2000")
      ON ACTION help_cirrection_shelf_2
         CALL aoos020_show_field_help("ooab_t","S-CIR-2001")
      ON ACTION help_cirrection_shelf_3
         CALL aoos020_show_field_help("ooab_t","S-CIR-2002")
      ON ACTION help_cirrection_counter_1
         CALL aoos020_show_field_help("ooab_t","S-CIR-2003")
      ON ACTION help_cirrection_counter_2
         CALL aoos020_show_field_help("ooab_t","S-CIR-2004")
      ON ACTION help_cirrection_counter_3
         CALL aoos020_show_field_help("ooab_t","S-CIR-2005")
      ON ACTION help_cirrection_counter_4
         CALL aoos020_show_field_help("ooab_t","S-CIR-2006")
      ON ACTION help_cirrection_counter_5
         CALL aoos020_show_field_help("ooab_t","S-CIR-2007")
      ON ACTION help_cirrection_counter_6
         CALL aoos020_show_field_help("ooab_t","S-CIR-2009")
      ON ACTION help_cirrection_counter_7
         CALL aoos020_show_field_help("ooab_t","S-CIR-2010")
      ON ACTION help_cirrection_counter_8
         CALL aoos020_show_field_help("ooab_t","S-CIR-2011")
      ON ACTION help_cirrection_counter_9
         CALL aoos020_show_field_help("ooab_t","S-CIR-2012")
      ON ACTION help_cirrection_counter_10
         CALL aoos020_show_field_help("ooab_t","S-CIR-2013")
      ON ACTION help_cirrection_counter_11
         CALL aoos020_show_field_help("ooab_t","S-CIR-2014")
      ON ACTION help_cirrection_counter_12
         CALL aoos020_show_field_help("ooab_t","S-CIR-2016")
      ON ACTION help_cirrection_counter_13
         CALL aoos020_show_field_help("ooab_t","S-CIR-2017")
      ON ACTION help_cirrection_stock_1
         CALL aoos020_show_field_help("ooab_t","S-CIR-2018")
      ON ACTION help_cirrection_stock_2
         CALL aoos020_show_field_help("ooab_t","S-CIR-2036")
      ON ACTION help_cirrection_rent_1
         CALL aoos020_show_field_help("ooab_t","S-CIR-2019")
      ON ACTION help_cirrection_rent_2
         CALL aoos020_show_field_help("ooab_t","S-CIR-2020")
      ON ACTION help_cirrection_rent_3
         CALL aoos020_show_field_help("ooab_t","S-CIR-2021")
      ON ACTION help_cirrection_rent_4
         CALL aoos020_show_field_help("ooab_t","S-CIR-2022")
      ON ACTION help_cirrection_rent_5
         CALL aoos020_show_field_help("ooab_t","S-CIR-2023")
      ON ACTION help_cirrection_rent_6
         CALL aoos020_show_field_help("ooab_t","S-CIR-2024")
      ON ACTION help_cirrection_rent_7
         CALL aoos020_show_field_help("ooab_t","S-CIR-2025")
      ON ACTION help_cirrection_rent_8
         CALL aoos020_show_field_help("ooab_t","S-CIR-2026")
      ON ACTION help_cirrection_rent_9
         CALL aoos020_show_field_help("ooab_t","S-CIR-2027")
      ON ACTION help_cirrection_rent_10
         CALL aoos020_show_field_help("ooab_t","S-CIR-2028")
      ON ACTION help_cirrection_rent_11
         CALL aoos020_show_field_help("ooab_t","S-CIR-2030")
      ON ACTION help_cirrection_rent_12
         CALL aoos020_show_field_help("ooab_t","S-CIR-2031")
      ON ACTION help_cirrection_rent_13
         CALL aoos020_show_field_help("ooab_t","S-CIR-2032")
      ON ACTION help_cirrection_rent_14
         CALL aoos020_show_field_help("ooab_t","S-CIR-2033")
      ON ACTION help_cirrection_rent_15
         CALL aoos020_show_field_help("ooab_t","S-CIR-2034")
      ON ACTION help_cirrection_rent_16
         CALL aoos020_show_field_help("ooab_t","S-CIR-2035")
      ON ACTION help_cirrection_distribution_1
         CALL aoos020_show_field_help("ooab_t","S-CIR-2029")
      ON ACTION help_finance_AXC_1
         CALL aoos020_show_field_help("ooab_t","S-FIN-6015")
      ON ACTION help_finance_AXC_2
         CALL aoos020_show_field_help("ooab_t","S-FIN-6013")
      ON ACTION help_finance_AXC_3
         CALL aoos020_show_field_help("ooab_t","S-FIN-6001")
      ON ACTION help_finance_AXC_4
         CALL aoos020_show_field_help("ooab_t","S-FIN-6002")
      ON ACTION help_finance_AXC_5
         CALL aoos020_show_field_help("ooab_t","S-FIN-6003")
      ON ACTION help_finance_AXC_6
         CALL aoos020_show_field_help("ooab_t","S-FIN-6004")
      ON ACTION help_finance_AXC_7
         CALL aoos020_show_field_help("ooab_t","S-FIN-6006")
      ON ACTION help_finance_AXC_8
         CALL aoos020_show_field_help("ooab_t","S-FIN-6005")
      ON ACTION help_finance_AXC_9
         CALL aoos020_show_field_help("ooab_t","S-FIN-6007")
      ON ACTION help_finance_AXC_10
         CALL aoos020_show_field_help("ooab_t","S-FIN-6023")
      ON ACTION help_finance_AXC_11
         CALL aoos020_show_field_help("ooab_t","S-FIN-6024")
      ON ACTION help_finance_AXC_13
         CALL aoos020_show_field_help("ooab_t","S-FIN-6014")
      ON ACTION help_finance_AXC_14
         CALL aoos020_show_field_help("ooab_t","S-FIN-6016")
      ON ACTION help_finance_AXC_16
         CALL aoos020_show_field_help("ooab_t","S-FIN-6008")
      ON ACTION help_finance_AXC_17
         CALL aoos020_show_field_help("ooab_t","S-FIN-6022")
      ON ACTION help_finance_AXC_18
         CALL aoos020_show_field_help("ooab_t","S-FIN-6009")
      ON ACTION help_finance_AXC_19
         CALL aoos020_show_field_help("ooab_t","S-FIN-6017")
      ON ACTION help_finance_AXC_32
         CALL aoos020_show_field_help("ooab_t","S-FIN-6018")
      ON ACTION help_finance_AXC_33
         CALL aoos020_show_field_help("ooab_t","S-FIN-6019")
      ON ACTION help_finance_AXC_35
         CALL aoos020_show_field_help("ooab_t","S-FIN-6020")
      ON ACTION help_finance_AXC_36
         CALL aoos020_show_field_help("ooab_t","S-FIN-6021")
      ON ACTION help_finance_AXC_37
         CALL aoos020_show_field_help("ooab_t","S-FIN-6012")
      ON ACTION help_finance_AXC_38
         CALL aoos020_show_field_help("ooab_t","S-FIN-6010")
      ON ACTION help_finance_AXC_39
         CALL aoos020_show_field_help("ooab_t","S-FIN-6011")
      ON ACTION help_finance_AGL_1
         CALL aoos020_show_field_help("ooab_t","S-FIN-0001")
      ON ACTION help_finance_AGL_2
         CALL aoos020_show_field_help("ooab_t","S-FIN-0002")
      ON ACTION help_finance_AXR_1
         CALL aoos020_show_field_help("ooab_t","S-FIN-1002")
      ON ACTION help_finance_AXR_2
         CALL aoos020_show_field_help("ooab_t","S-FIN-1003")
      ON ACTION help_finance_AXR_3
         CALL aoos020_show_field_help("ooab_t","S-FIN-1004")
      ON ACTION help_finance_AXR_4
         CALL aoos020_show_field_help("ooab_t","S-FIN-1005")
      ON ACTION help_finance_AXR_5
         CALL aoos020_show_field_help("ooab_t","S-FIN-1006")
      ON ACTION help_finance_AXR_6
         CALL aoos020_show_field_help("ooab_t","S-FIN-2012")
      ON ACTION help_finance_AXR_7
         CALL aoos020_show_field_help("ooab_t","S-FIN-2010")
      ON ACTION help_finance_AXR_8
         CALL aoos020_show_field_help("ooab_t","S-FIN-2011")
      ON ACTION help_finance_AXR_9
         CALL aoos020_show_field_help("ooab_t","S-FIN-2007")
      ON ACTION help_finance_AXR_10
         CALL aoos020_show_field_help("ooab_t","S-FIN-2013")
      ON ACTION help_finance_AXR_12
         CALL aoos020_show_field_help("ooab_t","S-FIN-2017")
      ON ACTION help_finance_AXR_13
         CALL aoos020_show_field_help("ooab_t","S-FIN-2009")
      ON ACTION help_finance_AXR_14
         CALL aoos020_show_field_help("ooab_t","S-FIN-2020")
      ON ACTION help_finance_AXR_15
         CALL aoos020_show_field_help("ooab_t","S-FIN-2019")
      ON ACTION help_finance_AXR_16
         CALL aoos020_show_field_help("ooab_t","S-FIN-2021")
      ON ACTION help_finance_AXR_17
         CALL aoos020_show_field_help("ooab_t","S-FIN-2022")
      ON ACTION help_finance_AXR_18
         CALL aoos020_show_field_help("ooab_t","S-FIN-2024")
      ON ACTION help_finance_AAP_1
         CALL aoos020_show_field_help("ooab_t","S-FIN-2002")
      ON ACTION help_finance_AAP_2
         CALL aoos020_show_field_help("ooab_t","S-FIN-3012")
      ON ACTION help_finance_AAP_3
         CALL aoos020_show_field_help("ooab_t","S-FIN-3010")
      ON ACTION help_finance_AAP_4
         CALL aoos020_show_field_help("ooab_t","S-FIN-3011")
      ON ACTION help_finance_AAP_10
         CALL aoos020_show_field_help("ooab_t","S-FIN-3003")
      ON ACTION help_finance_AAP_11
         CALL aoos020_show_field_help("ooab_t","S-FIN-3004")
      ON ACTION help_finance_AAP_12
         CALL aoos020_show_field_help("ooab_t","S-FIN-3005")
      ON ACTION help_finance_AAP_13
         CALL aoos020_show_field_help("ooab_t","S-FIN-3006")
      ON ACTION help_finance_AAP_21
         CALL aoos020_show_field_help("ooab_t","S-FIN-3007")
      ON ACTION help_finance_AAP_22
         CALL aoos020_show_field_help("ooab_t","S-FIN-3008")
      ON ACTION help_finance_AAP_23
         CALL aoos020_show_field_help("ooab_t","S-FIN-3015")
      ON ACTION help_finance_AAP_25
         CALL aoos020_show_field_help("ooab_t","S-FIN-3009")
      ON ACTION help_finance_AAP_26
         CALL aoos020_show_field_help("ooab_t","S-FIN-3020")
      ON ACTION help_finance_AAP_27
         CALL aoos020_show_field_help("ooab_t","S-FIN-3017")
      ON ACTION help_finance_AAP_28
         CALL aoos020_show_field_help("ooab_t","S-FIN-3018")
      ON ACTION help_finance_AAP_29
         CALL aoos020_show_field_help("ooab_t","S-FIN-3019")
      ON ACTION help_finance_AAP_30
         CALL aoos020_show_field_help("ooab_t","S-FIN-3021")
      ON ACTION help_finance_ANM_1
         CALL aoos020_show_field_help("ooab_t","S-FIN-4001")
      ON ACTION help_finance_ANM_2
         CALL aoos020_show_field_help("ooab_t","S-FIN-4007")
      ON ACTION help_finance_ANM_3
         CALL aoos020_show_field_help("ooab_t","S-FIN-4012")
      ON ACTION help_finance_ANM_4
         CALL aoos020_show_field_help("ooab_t","S-FIN-4004")
      ON ACTION help_finance_ANM_5
         CALL aoos020_show_field_help("ooab_t","S-FIN-4008")
      ON ACTION help_finance_ANM_6
         CALL aoos020_show_field_help("ooab_t","S-FIN-4009")
      ON ACTION help_finance_ANM_7
         CALL aoos020_show_field_help("ooab_t","S-FIN-4010")
      ON ACTION help_finance_ANM_8
         CALL aoos020_show_field_help("ooab_t","S-FIN-4011")
      ON ACTION help_finance_ANM_9
         CALL aoos020_show_field_help("ooab_t","S-FIN-3016")
      ON ACTION help_finance_ANM_10
         CALL aoos020_show_field_help("ooab_t","S-FIN-4015")
      ON ACTION help_finance_ANM_11
         CALL aoos020_show_field_help("ooab_t","S-FIN-4016")
      ON ACTION help_finance_AFM_1
         CALL aoos020_show_field_help("ooab_t","S-FIN-4013")
      ON ACTION help_finance_AFM_2
         CALL aoos020_show_field_help("ooab_t","S-FIN-4014")
      ON ACTION help_finance_AFA_1
         CALL aoos020_show_field_help("ooab_t","S-FIN-9009")
      ON ACTION help_finance_AFA_2
         CALL aoos020_show_field_help("ooab_t","S-FIN-9005")
      ON ACTION help_finance_AFA_3
         CALL aoos020_show_field_help("ooab_t","S-FIN-9002")
      ON ACTION help_finance_AFA_4
         CALL aoos020_show_field_help("ooab_t","S-FIN-9010")
      ON ACTION help_finance_AFA_5
         CALL aoos020_show_field_help("ooab_t","S-FIN-9003")
      ON ACTION help_finance_AFA_6
         CALL aoos020_show_field_help("ooab_t","S-FIN-9016")
      ON ACTION help_finance_AFA_7
         CALL aoos020_show_field_help("ooab_t","S-FIN-9017")
      ON ACTION help_finance_AFA_8
         CALL aoos020_show_field_help("ooab_t","S-FIN-9015")
      ON ACTION help_finance_AFA_9
         CALL aoos020_show_field_help("ooab_t","S-FIN-9018")
      ON ACTION help_finance_AFA_10
         CALL aoos020_show_field_help("ooab_t","S-FIN-9019")
      ON ACTION help_finance_CIT_1
         CALL aoos020_show_field_help("ooab_t","S-FIN-7001")
      ON ACTION help_finance_CIT_2
         CALL aoos020_show_field_help("ooab_t","S-FIN-7002")
      ON ACTION help_finance_CIT_3
         CALL aoos020_show_field_help("ooab_t","S-FIN-2023")
      ON ACTION help_manufactor_wo_1
         CALL aoos020_show_field_help("ooab_t","S-MFG-0056")
      ON ACTION help_manufactor_wo_2
         CALL aoos020_show_field_help("ooab_t","S-MFG-0055")
      ON ACTION help_manufactor_wo_3
         CALL aoos020_show_field_help("ooab_t","S-MFG-0002")
      ON ACTION help_manufactor_routing_1
         CALL aoos020_show_field_help("ooab_t","S-MFG-0033")
      ON ACTION help_manufactor_routing_2
         CALL aoos020_show_field_help("ooab_t","S-MFG-0035")
      ON ACTION help_APS_base_1
         CALL aoos020_show_field_help("ooab_t","S-MFG-0036")
      ON ACTION help_APS_base_2
         CALL aoos020_show_field_help("ooab_t","S-MFG-0039")
      ON ACTION help_APS_aps_runtime_1
         CALL aoos020_show_field_help("ooab_t","S-MFG-0050")
      ON ACTION help_APS_aps_runtime_2
         CALL aoos020_show_field_help("ooab_t","S-MFG-0052")
      ON ACTION help_APS_aps_runtime_3
         CALL aoos020_show_field_help("ooab_t","S-MFG-0053")
      ON ACTION help_APS_aps_runtime_4
         CALL aoos020_show_field_help("ooab_t","S-MFG-0054")
      ON ACTION help_APS_apsadv_1
         CALL aoos020_show_field_help("ooab_t","S-MFG-0057")
      ON ACTION help_APS_apsadv_2
         CALL aoos020_show_field_help("ooab_t","S-MFG-0058")
      ON ACTION help_APS_apsadv_3
         CALL aoos020_show_field_help("ooab_t","S-MFG-0059")
      ON ACTION help_APS_apsadv_4
         CALL aoos020_show_field_help("ooab_t","S-MFG-0063")
      ON ACTION help_APS_apsadv_5
         CALL aoos020_show_field_help("ooab_t","S-MFG-0064")
      ON ACTION help_APS_apsadv_6
         CALL aoos020_show_field_help("ooab_t","S-MFG-0060")
      ON ACTION help_APS_apsadv_7
         CALL aoos020_show_field_help("ooab_t","S-MFG-0061")
      ON ACTION help_APS_apsadv_8
         CALL aoos020_show_field_help("ooab_t","S-MFG-0062")
      ON ACTION help_AQC_base_1
         CALL aoos020_show_field_help("ooab_t","S-MFG-0046")
      ON ACTION help_abx_base_1
         CALL aoos020_show_field_help("ooab_t","S-MFG-0065")
      ON ACTION help_abx_base_2
         CALL aoos020_show_field_help("ooab_t","S-MFG-0066")
      ON ACTION help_abx_base_3
         CALL aoos020_show_field_help("ooab_t","S-MFG-0067")
      ON ACTION help_abx_base_4
         CALL aoos020_show_field_help("ooab_t","S-MFG-0068")
      ON ACTION help_abx_base_5
         CALL aoos020_show_field_help("ooab_t","S-MFG-0069")
      ON ACTION help_abx_base_6
         CALL aoos020_show_field_help("ooab_t","S-MFG-0070")
      ON ACTION help_abx_base_7
         CALL aoos020_show_field_help("ooab_t","S-MFG-0071")
      ON ACTION help_abx_base_8
         CALL aoos020_show_field_help("ooab_t","S-MFG-0072")
      ON ACTION help_abx_base_9
         CALL aoos020_show_field_help("ooab_t","S-MFG-0074")
      ON ACTION help_abc_bcse_1
         CALL aoos020_show_field_help("ooab_t","S-APP-0001")
      ON ACTION help_abc_bcse_2
         CALL aoos020_show_field_help("ooab_t","S-APP-0012")
      ON ACTION help_abc_bcse_3
         CALL aoos020_show_field_help("ooab_t","S-APP-0009")
      ON ACTION help_abc_bcse_4
         CALL aoos020_show_field_help("ooab_t","S-APP-0010")
      ON ACTION help_abc_bcse_5
         CALL aoos020_show_field_help("ooab_t","S-APP-0008")
      ON ACTION help_abc_bcse_6
         CALL aoos020_show_field_help("ooab_t","S-APP-0011")
      ON ACTION help_abc_bcse_7
         CALL aoos020_show_field_help("ooab_t","S-APP-0002")
      ON ACTION help_abc_bcse_8
         CALL aoos020_show_field_help("ooab_t","S-APP-0003")
      ON ACTION help_abc_bcse_9
         CALL aoos020_show_field_help("ooab_t","S-APP-0004")
      ON ACTION help_abc_bcse_10
         CALL aoos020_show_field_help("ooab_t","S-APP-0005")
      ON ACTION help_abc_bcse_11
         CALL aoos020_show_field_help("ooab_t","S-APP-0006")
      ON ACTION help_abc_bcse_12
         CALL aoos020_show_field_help("ooab_t","S-APP-0007")
 
       
      
      ON ACTION accept
         
         LET li_exit = FALSE
         ACCEPT DIALOG
 
      ON ACTION cancel
         # 返回舊值, 並顯示
         LET li_exit = TRUE
         CALL aoos020_fill_data()   # 整體參數
         CALL aoos020_show()
         EXIT DIALOG
   END DIALOG
 
   IF NOT li_exit THEN
      # 做存檔動作
      CALL aoos020_update()
      
     IF NOT s_apsp500_advanced_para(g_ooab_d[192].ooab002) THEN END IF 

   END IF
 
END FUNCTION 
 
#+ 更新參數資料
PRIVATE FUNCTION aoos020_update()
 
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
         PREPARE aoos020_update_cs FROM ls_sql
         EXECUTE aoos020_update_cs USING g_ooab_d[li_cnt].ooab002,g_user,
                                         g_ooab_d[li_cnt].ooabmoddt,
                                         g_ooab_d[li_cnt].ooab001
         FREE aoos020_update_cs
 
         CALL cl_log_parameter_update(g_ooab_d[li_cnt].ooab001,g_site,g_ooab_d_t[li_cnt].ooab002,g_ooab_d[li_cnt].ooab002)
      END IF
   END FOR
 
END FUNCTION
 
#+ 抓取右側說明方塊
PRIVATE FUNCTION aoos020_show_field_help(ps_tabid,ps_field)
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
PRIVATE FUNCTION aoos020_show_page_title(ps_paramid)
   DEFINE ps_paramid   STRING 
   DEFINE pc_gzswl004  LIKE gzswl_t.gzswl004
   DEFINE ls_sql       STRING 
 
   LET ls_sql = "SELECT gzswl004 FROM gzswl_t", 
                " WHERE gzswl001 = '", g_code ,"'" ,
                  " AND gzswl002 = '",ps_paramid,"'",
                  " AND gzswl003 = '",g_lang ,"'"
 
   PREPARE  aoos020_show_page_title_pre FROM ls_sql  
   EXECUTE aoos020_show_page_title_pre  INTO pc_gzswl004 
   FREE aoos020_show_page_title_pre
 
   RETURN pc_gzswl004 
END FUNCTION 
