#該程式未解開Section, 採用最新樣板產出!
#應用 s01 樣板自動產生(Version:12)
# Filename.......: aoos010.4gl
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
PRIVATE TYPE type_g_ooaa_d RECORD
   ooaa001 LIKE ooaa_t.ooaa001,
   ooaa001_desc LIKE type_t.chr80,
   ooaa002 LIKE ooaa_t.ooaa002,
   ooaaownid LIKE ooaa_t.ooaaownid,
   ooaaownid_desc LIKE type_t.chr80,
   ooaacrtid LIKE ooaa_t.ooaacrtid,
   ooaacrtid_desc LIKE type_t.chr80,
   ooaacrtdp LIKE ooaa_t.ooaacrtdp,
   ooaacrtdp_desc LIKE type_t.chr80,
   ooaacrtdt DATETIME YEAR TO SECOND,
   ooaamodid LIKE ooaa_t.ooaamodid,
   ooaamodid_desc LIKE type_t.chr80,
   ooaamoddt DATETIME YEAR TO SECOND
       END RECORD
 
DEFINE g_ooaa_d    DYNAMIC ARRAY OF type_g_ooaa_d
DEFINE g_ooaa_d_t  DYNAMIC ARRAY OF type_g_ooaa_d
 
 
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
   CALL aoos010_fill_data()   # 整體參數
 
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call name="main.servicecall"
      {<point name="main.servicecall" />}
      #end add-point
 
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aoos010 WITH FORM cl_ap_formpath("aoo",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL aoos010_init()
 
      #進入選單 Menu (="N")
      CALL aoos010_show()
      CALL aoos010_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      {<point name="main.before_close" />}
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aoos010
 
   END IF
 
   #add-point:作業離開前 name="main.exit"
   {<point name="main.exit" />}
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
 
END MAIN
 
 
PRIVATE FUNCTION aoos010_init()
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
 
     
   
    CALL cl_set_combo_scc('basic_base_1','60') 
   CALL cl_set_combo_scc('basic_base_9','12') 
   CALL cl_set_combo_scc('basic_related_doc_1','76') 
   CALL cl_set_combo_scc('basic_base2_6','57') 
   CALL cl_set_combo_scc('basic_base2_8','95') 
   CALL cl_set_combo_scc('basic_password_1','141') 
   CALL cl_set_combo_scc('basic_password_3','134') 
   CALL cl_set_combo_scc('basic_password_6','246') 
   CALL cl_set_combo_scc('aws_bpm_3','117') 
   CALL cl_set_combo_scc('uisetting_homepage_5','238') 
   CALL cl_set_combo_scc('ain_base_34','6100') 
   CALL cl_set_combo_scc('ain_base_35','6094') 
   CALL cl_set_combo_scc('amm_base_9','6964') 
   CALL cl_set_combo_scc('art_basic_3','6772') 
   CALL cl_set_combo_scc('acr_base_3','6065') 
   CALL cl_set_combo_scc('ast_base_1','6074') 
   CALL cl_set_combo_scc('ast_base_6','6883') 
   CALL cl_set_combo_scc('ast_giveback_1','6102') 
   CALL cl_set_combo_scc('cir_settle_account_1','6892') 
   CALL cl_set_combo_scc('cir_settle_account_2','6948') 
   CALL cl_set_combo_scc('cir_settle_account_3','6957') 
   CALL cl_set_combo_scc('cir_trans_1','6945') 
   CALL cl_set_combo_scc('apm_base_1','6743') 
   CALL cl_set_combo_scc('agc_base_1','6886') 
   CALL cl_set_combo_scc('apc_touch_1','6104') 
      
   CALL aoos010_area_information()
   CALL aoos010_parameter_switch("basic") 
   CALL aoos010_show_field_help("","")
 
END FUNCTION
 
# 指定各參數區塊資料 ( 方便切換參數內容 )
PRIVATE FUNCTION aoos010_area_information()
 
   
   LET g_parameter[1].id = "basic"
   LET g_parameter[1].name = "aoo-702"
   LET g_parameter[1].comp = "scrgr1"
   LET g_parameter[1].img = "24/s_setting.png"
   LET g_parameter[2].id = "aws"
   LET g_parameter[2].name = "aoo-702"
   LET g_parameter[2].comp = "scrgr2"
   LET g_parameter[2].img = "24/s_setting.png"
   LET g_parameter[3].id = "uisetting"
   LET g_parameter[3].name = "aoo-702"
   LET g_parameter[3].comp = "scrgr3"
   LET g_parameter[3].img = "24/s_setting.png"
   LET g_parameter[4].id = "ain"
   LET g_parameter[4].name = "aoo-702"
   LET g_parameter[4].comp = "scrgr4"
   LET g_parameter[4].img = "24/s_setting.png"
   LET g_parameter[5].id = "amm"
   LET g_parameter[5].name = "aoo-702"
   LET g_parameter[5].comp = "scrgr5"
   LET g_parameter[5].img = "24/s_setting.png"
   LET g_parameter[6].id = "aec"
   LET g_parameter[6].name = "aoo-702"
   LET g_parameter[6].comp = "scrgr6"
   LET g_parameter[6].img = "24/s_setting.png"
   LET g_parameter[7].id = "aim"
   LET g_parameter[7].name = "aoo-702"
   LET g_parameter[7].comp = "scrgr7"
   LET g_parameter[7].img = "24/s_setting.png"
   LET g_parameter[8].id = "abm"
   LET g_parameter[8].name = "aoo-702"
   LET g_parameter[8].comp = "scrgr8"
   LET g_parameter[8].img = "24/s_setting.png"
   LET g_parameter[9].id = "art"
   LET g_parameter[9].name = "aoo-702"
   LET g_parameter[9].comp = "scrgr9"
   LET g_parameter[9].img = "24/s_setting.png"
   LET g_parameter[10].id = "acr"
   LET g_parameter[10].name = "aoo-702"
   LET g_parameter[10].comp = "scrgr10"
   LET g_parameter[10].img = "24/s_setting.png"
   LET g_parameter[11].id = "ast"
   LET g_parameter[11].name = "aoo-702"
   LET g_parameter[11].comp = "scrgr11"
   LET g_parameter[11].img = "24/s_setting.png"
   LET g_parameter[12].id = "fin"
   LET g_parameter[12].name = "aoo-702"
   LET g_parameter[12].comp = "scrgr12"
   LET g_parameter[12].img = "24/s_setting.png"
   LET g_parameter[13].id = "cir"
   LET g_parameter[13].name = "aoo-702"
   LET g_parameter[13].comp = "scrgr13"
   LET g_parameter[13].img = "24/s_setting.png"
   LET g_parameter[14].id = "ais"
   LET g_parameter[14].name = "aoo-702"
   LET g_parameter[14].comp = "scrgr14"
   LET g_parameter[14].img = "24/s_setting.png"
   LET g_parameter[15].id = "scm"
   LET g_parameter[15].name = "aoo-702"
   LET g_parameter[15].comp = "scrgr15"
   LET g_parameter[15].img = "24/s_setting.png"
   LET g_parameter[16].id = "stock"
   LET g_parameter[16].name = "aoo-702"
   LET g_parameter[16].comp = "scrgr16"
   LET g_parameter[16].img = "24/s_setting.png"
   LET g_parameter[17].id = "apm"
   LET g_parameter[17].name = "aoo-702"
   LET g_parameter[17].comp = "scrgr17"
   LET g_parameter[17].img = "24/s_setting.png"
   LET g_parameter[18].id = "apj"
   LET g_parameter[18].name = "aoo-702"
   LET g_parameter[18].comp = "scrgr18"
   LET g_parameter[18].img = "24/s_setting.png"
   LET g_parameter[19].id = "agc"
   LET g_parameter[19].name = "aoo-702"
   LET g_parameter[19].comp = "scrgr19"
   LET g_parameter[19].img = "24/s_setting.png"
   LET g_parameter[20].id = "apc"
   LET g_parameter[20].name = "aoo-702"
   LET g_parameter[20].comp = "scrgr20"
   LET g_parameter[20].img = "24/s_setting.png"
 
END FUNCTION
 
# 切換參數區塊 & 更換參數Title圖示文字
PRIVATE FUNCTION aoos010_parameter_switch(ps_paramid)
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
          CALL gfrm_curr.setElementText("page_parameterbox",aoos010_show_page_title(ps_paramid))   
          # 設定參數按鈕格式
          CALL gfrm_curr.setElementStyle(g_parameter[li_cnt].id, "menuitemfocus")
       END IF
   END FOR
 
END FUNCTION
 
 
# 子參數區塊開關
PRIVATE FUNCTION aoos010_parameter_group_switch(ps_paramgroup)
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
PRIVATE FUNCTION aoos010_ui_dialog()
   MENU ""
#     BEFORE MENU
#       CALL aoos010_modify()   #預設進入修改狀態
         
      ON ACTION modify
         LET g_action_choice="modify"
         IF cl_auth_chk_act("modify") THEN
            CALL aoos010_modify()
         END IF
 
      
      ON ACTION basic
         CALL aoos010_parameter_switch("basic")
      ON ACTION aws
         CALL aoos010_parameter_switch("aws")
      ON ACTION uisetting
         CALL aoos010_parameter_switch("uisetting")
      ON ACTION ain
         CALL aoos010_parameter_switch("ain")
      ON ACTION amm
         CALL aoos010_parameter_switch("amm")
      ON ACTION aec
         CALL aoos010_parameter_switch("aec")
      ON ACTION aim
         CALL aoos010_parameter_switch("aim")
      ON ACTION abm
         CALL aoos010_parameter_switch("abm")
      ON ACTION art
         CALL aoos010_parameter_switch("art")
      ON ACTION acr
         CALL aoos010_parameter_switch("acr")
      ON ACTION ast
         CALL aoos010_parameter_switch("ast")
      ON ACTION fin
         CALL aoos010_parameter_switch("fin")
      ON ACTION cir
         CALL aoos010_parameter_switch("cir")
      ON ACTION ais
         CALL aoos010_parameter_switch("ais")
      ON ACTION scm
         CALL aoos010_parameter_switch("scm")
      ON ACTION stock
         CALL aoos010_parameter_switch("stock")
      ON ACTION apm
         CALL aoos010_parameter_switch("apm")
      ON ACTION apj
         CALL aoos010_parameter_switch("apj")
      ON ACTION agc
         CALL aoos010_parameter_switch("agc")
      ON ACTION apc
         CALL aoos010_parameter_switch("apc")
 
      
      ON ACTION btn_paramsubgp1_1
         CALL aoos010_parameter_group_switch("paramsubgp1_1")
      ON ACTION btn_paramsubgp1_2
         CALL aoos010_parameter_group_switch("paramsubgp1_2")
      ON ACTION btn_paramsubgp1_3
         CALL aoos010_parameter_group_switch("paramsubgp1_3")
      ON ACTION btn_paramsubgp1_4
         CALL aoos010_parameter_group_switch("paramsubgp1_4")
      ON ACTION btn_paramsubgp1_5
         CALL aoos010_parameter_group_switch("paramsubgp1_5")
      ON ACTION btn_paramsubgp1_6
         CALL aoos010_parameter_group_switch("paramsubgp1_6")
      ON ACTION btn_paramsubgp2_1
         CALL aoos010_parameter_group_switch("paramsubgp2_1")
      ON ACTION btn_paramsubgp2_2
         CALL aoos010_parameter_group_switch("paramsubgp2_2")
      ON ACTION btn_paramsubgp2_3
         CALL aoos010_parameter_group_switch("paramsubgp2_3")
      ON ACTION btn_paramsubgp2_4
         CALL aoos010_parameter_group_switch("paramsubgp2_4")
      ON ACTION btn_paramsubgp2_5
         CALL aoos010_parameter_group_switch("paramsubgp2_5")
      ON ACTION btn_paramsubgp2_6
         CALL aoos010_parameter_group_switch("paramsubgp2_6")
      ON ACTION btn_paramsubgp3_1
         CALL aoos010_parameter_group_switch("paramsubgp3_1")
      ON ACTION btn_paramsubgp3_2
         CALL aoos010_parameter_group_switch("paramsubgp3_2")
      ON ACTION btn_paramsubgp4_1
         CALL aoos010_parameter_group_switch("paramsubgp4_1")
      ON ACTION btn_paramsubgp5_1
         CALL aoos010_parameter_group_switch("paramsubgp5_1")
      ON ACTION btn_paramsubgp6_1
         CALL aoos010_parameter_group_switch("paramsubgp6_1")
      ON ACTION btn_paramsubgp7_1
         CALL aoos010_parameter_group_switch("paramsubgp7_1")
      ON ACTION btn_paramsubgp8_1
         CALL aoos010_parameter_group_switch("paramsubgp8_1")
      ON ACTION btn_paramsubgp9_1
         CALL aoos010_parameter_group_switch("paramsubgp9_1")
      ON ACTION btn_paramsubgp10_1
         CALL aoos010_parameter_group_switch("paramsubgp10_1")
      ON ACTION btn_paramsubgp10_2
         CALL aoos010_parameter_group_switch("paramsubgp10_2")
      ON ACTION btn_paramsubgp11_1
         CALL aoos010_parameter_group_switch("paramsubgp11_1")
      ON ACTION btn_paramsubgp11_2
         CALL aoos010_parameter_group_switch("paramsubgp11_2")
      ON ACTION btn_paramsubgp12_1
         CALL aoos010_parameter_group_switch("paramsubgp12_1")
      ON ACTION btn_paramsubgp12_2
         CALL aoos010_parameter_group_switch("paramsubgp12_2")
      ON ACTION btn_paramsubgp13_1
         CALL aoos010_parameter_group_switch("paramsubgp13_1")
      ON ACTION btn_paramsubgp13_2
         CALL aoos010_parameter_group_switch("paramsubgp13_2")
      ON ACTION btn_paramsubgp13_3
         CALL aoos010_parameter_group_switch("paramsubgp13_3")
      ON ACTION btn_paramsubgp13_4
         CALL aoos010_parameter_group_switch("paramsubgp13_4")
      ON ACTION btn_paramsubgp14_1
         CALL aoos010_parameter_group_switch("paramsubgp14_1")
      ON ACTION btn_paramsubgp15_1
         CALL aoos010_parameter_group_switch("paramsubgp15_1")
      ON ACTION btn_paramsubgp16_1
         CALL aoos010_parameter_group_switch("paramsubgp16_1")
      ON ACTION btn_paramsubgp17_1
         CALL aoos010_parameter_group_switch("paramsubgp17_1")
      ON ACTION btn_paramsubgp18_1
         CALL aoos010_parameter_group_switch("paramsubgp18_1")
      ON ACTION btn_paramsubgp19_1
         CALL aoos010_parameter_group_switch("paramsubgp19_1")
      ON ACTION btn_paramsubgp20_1
         CALL aoos010_parameter_group_switch("paramsubgp20_1")
 
      # 以下為每一個欄位的說明功能鍵
      
      ON ACTION help_basic_base_1
         CALL aoos010_show_field_help("ooaa_t","E-COM-0008")
      ON ACTION help_basic_base_4
         CALL aoos010_show_field_help("ooaa_t","E-COM-0001")
      ON ACTION help_basic_base_5
         CALL aoos010_show_field_help("ooaa_t","E-COM-0002")
      ON ACTION help_basic_base_6
         CALL aoos010_show_field_help("ooaa_t","E-COM-0003")
      ON ACTION help_basic_base_7
         CALL aoos010_show_field_help("ooaa_t","E-COM-0004")
      ON ACTION help_basic_base_8
         CALL aoos010_show_field_help("ooaa_t","E-COM-0005")
      ON ACTION help_basic_base_9
         CALL aoos010_show_field_help("ooaa_t","E-COM-0006")
      ON ACTION help_basic_base_10
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0727")
      ON ACTION help_basic_base_11
         CALL aoos010_show_field_help("gzsb_t","E-SYS-2010")
      ON ACTION help_basic_process_1
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0005")
      ON ACTION help_basic_related_doc_1
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0006")
      ON ACTION help_basic_related_doc_2
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0007")
      ON ACTION help_basic_related_doc_3
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0008")
      ON ACTION help_basic_base2_1
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0001")
      ON ACTION help_basic_base2_2
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0710")
      ON ACTION help_basic_base2_3
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0002")
      ON ACTION help_basic_base2_4
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0003")
      ON ACTION help_basic_base2_5
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0004")
      ON ACTION help_basic_base2_6
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0009")
      ON ACTION help_basic_base2_7
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0010")
      ON ACTION help_basic_base2_8
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0035")
      ON ACTION help_basic_base2_9
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0011")
      ON ACTION help_basic_base2_10
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0036")
      ON ACTION help_basic_base2_11
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0712")
      ON ACTION help_basic_log_1
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0012")
      ON ACTION help_basic_log_2
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0013")
      ON ACTION help_basic_log_3
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0014")
      ON ACTION help_basic_log_4
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0015")
      ON ACTION help_basic_log_5
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0016")
      ON ACTION help_basic_log_6
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0017")
      ON ACTION help_basic_log_7
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0034")
      ON ACTION help_basic_log_8
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0018")
      ON ACTION help_basic_log_9
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0019")
      ON ACTION help_basic_log_10
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0020")
      ON ACTION help_basic_log_11
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0021")
      ON ACTION help_basic_log_12
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0022")
      ON ACTION help_basic_log_13
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0023")
      ON ACTION help_basic_log_14
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0024")
      ON ACTION help_basic_log_15
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0025")
      ON ACTION help_basic_log_16
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0026")
      ON ACTION help_basic_log_17
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0027")
      ON ACTION help_basic_password_1
         CALL aoos010_show_field_help("gzsb_t","E-SYS-2006")
      ON ACTION help_basic_password_2
         CALL aoos010_show_field_help("gzsb_t","E-SYS-2003")
      ON ACTION help_basic_password_3
         CALL aoos010_show_field_help("gzsb_t","E-SYS-2004")
      ON ACTION help_basic_password_4
         CALL aoos010_show_field_help("gzsb_t","E-SYS-2005")
      ON ACTION help_basic_password_5
         CALL aoos010_show_field_help("gzsb_t","E-SYS-2002")
      ON ACTION help_basic_password_6
         CALL aoos010_show_field_help("gzsb_t","E-SYS-2009")
      ON ACTION help_aws_bpm_1
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0700")
      ON ACTION help_aws_bpm_2
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0701")
      ON ACTION help_aws_bpm_3
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0702")
      ON ACTION help_aws_bpm_4
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0703")
      ON ACTION help_aws_EAI_1
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0705")
      ON ACTION help_aws_EAI_2
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0704")
      ON ACTION help_aws_EAI_3
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0715")
      ON ACTION help_aws_EAI_4
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0716")
      ON ACTION help_aws_EAI_6
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0707")
      ON ACTION help_aws_EAI_7
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0717")
      ON ACTION help_aws_MCloud_1
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0708")
      ON ACTION help_aws_MCloud_2
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0709")
      ON ACTION help_aws_PLM_1
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0718")
      ON ACTION help_aws_PLM_2
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0719")
      ON ACTION help_aws_EC_B2B_1
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0720")
      ON ACTION help_aws_EC_B2B_2
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0721")
      ON ACTION help_aws_EC_B2B_3
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0722")
      ON ACTION help_aws_POSB2B_1
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0724")
      ON ACTION help_aws_POSB2B_2
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0725")
      ON ACTION help_aws_POSB2B_3
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0726")
      ON ACTION help_uisetting_homepage_1
         CALL aoos010_show_field_help("gzsb_t","E-SYS-2001")
      ON ACTION help_uisetting_homepage_2
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0033")
      ON ACTION help_uisetting_homepage_3
         CALL aoos010_show_field_help("gzsb_t","E-SYS-2007")
      ON ACTION help_uisetting_homepage_4
         CALL aoos010_show_field_help("gzsb_t","E-SYS-2008")
      ON ACTION help_uisetting_homepage_5
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0723")
      ON ACTION help_uisetting_layout_1
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0711")
      ON ACTION help_uisetting_layout_2
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0028")
      ON ACTION help_uisetting_layout_3
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0031")
      ON ACTION help_uisetting_layout_4
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0029")
      ON ACTION help_uisetting_layout_5
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0030")
      ON ACTION help_ain_base_32
         CALL aoos010_show_field_help("ooaa_t","E-BAS-0013")
      ON ACTION help_ain_base_33
         CALL aoos010_show_field_help("ooaa_t","E-BAS-0014")
      ON ACTION help_ain_base_34
         CALL aoos010_show_field_help("ooaa_t","E-BAS-0015")
      ON ACTION help_ain_base_35
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0029")
      ON ACTION help_ain_base_36
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0047")
      ON ACTION help_ain_base_37
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0048")
      ON ACTION help_ain_base_38
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0050")
      ON ACTION help_ain_base_39
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0053")
      ON ACTION help_ain_base_40
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0055")
      ON ACTION help_amm_base_3
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0003")
      ON ACTION help_amm_base_6
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0004")
      ON ACTION help_amm_base_7
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0051")
      ON ACTION help_amm_base_8
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0063")
      ON ACTION help_amm_base_9
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0073")
      ON ACTION help_amm_base_10
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0075")
      ON ACTION help_aec_base_32
         CALL aoos010_show_field_help("ooaa_t","E-MFG-0001")
      ON ACTION help_aec_base_33
         CALL aoos010_show_field_help("ooaa_t","E-MFG-0002")
      ON ACTION help_aim_base_24
         CALL aoos010_show_field_help("ooaa_t","E-BAS-0003")
      ON ACTION help_aim_base_25
         CALL aoos010_show_field_help("ooaa_t","E-BAS-0004")
      ON ACTION help_aim_base_27
         CALL aoos010_show_field_help("ooaa_t","E-BAS-0006")
      ON ACTION help_aim_base_28
         CALL aoos010_show_field_help("ooaa_t","E-BAS-0007")
      ON ACTION help_aim_base_35
         CALL aoos010_show_field_help("ooaa_t","E-BAS-0012")
      ON ACTION help_aim_base_36
         CALL aoos010_show_field_help("ooaa_t","E-BAS-0017")
      ON ACTION help_aim_base_37
         CALL aoos010_show_field_help("ooaa_t","E-BAS-0027")
      ON ACTION help_abm_base_23
         CALL aoos010_show_field_help("ooaa_t","E-BAS-0002")
      ON ACTION help_abm_base_29
         CALL aoos010_show_field_help("ooaa_t","E-BAS-0008")
      ON ACTION help_art_basic_1
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0001")
      ON ACTION help_art_basic_2
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0062")
      ON ACTION help_art_basic_3
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0028")
      ON ACTION help_art_basic_6
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0010")
      ON ACTION help_art_basic_7
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0032")
      ON ACTION help_art_basic_8
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0043")
      ON ACTION help_art_basic_9
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0046")
      ON ACTION help_art_basic_10
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0052")
      ON ACTION help_art_basic_11
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0056")
      ON ACTION help_art_basic_12
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0074")
      ON ACTION help_acr_base_1
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0005")
      ON ACTION help_acr_base_2
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0006")
      ON ACTION help_acr_base_3
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0007")
      ON ACTION help_acr_abc_1
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0008")
      ON ACTION help_acr_abc_2
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0009")
      ON ACTION help_ast_base_1
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0011")
      ON ACTION help_ast_base_2
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0045")
      ON ACTION help_ast_base_3
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0049")
      ON ACTION help_ast_base_4
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0054")
      ON ACTION help_ast_base_5
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0057")
      ON ACTION help_ast_base_6
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0058")
      ON ACTION help_ast_base_7
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0060")
      ON ACTION help_ast_giveback_1
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0064")
      ON ACTION help_fin_anm_1
         CALL aoos010_show_field_help("ooaa_t","E-FIN-0001")
      ON ACTION help_fin_axr_1
         CALL aoos010_show_field_help("ooaa_t","E-FIN-0002")
      ON ACTION help_fin_axr_2
         CALL aoos010_show_field_help("ooaa_t","E-FIN-0003")
      ON ACTION help_cir_application_1
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0035")
      ON ACTION help_cir_application_2
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0036")
      ON ACTION help_cir_application_3
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0018")
      ON ACTION help_cir_application_4
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0023")
      ON ACTION help_cir_application_5
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0025")
      ON ACTION help_cir_application_6
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0044")
      ON ACTION help_cir_application_7
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0022")
      ON ACTION help_cir_application_8
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0016")
      ON ACTION help_cir_application_9
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0024")
      ON ACTION help_cir_application_10
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0017")
      ON ACTION help_cir_application_11
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0038")
      ON ACTION help_cir_application_12
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0037")
      ON ACTION help_cir_application_13
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0019")
      ON ACTION help_cir_application_14
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0033")
      ON ACTION help_cir_application_15
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0027")
      ON ACTION help_cir_application_16
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0034")
      ON ACTION help_cir_application_19
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0002")
      ON ACTION help_cir_application_20
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0076")
      ON ACTION help_cir_cashreturn_1
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0030")
      ON ACTION help_cir_cashreturn_2
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0031")
      ON ACTION help_cir_cashreturn_3
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0042")
      ON ACTION help_cir_cashreturn_4
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0072")
      ON ACTION help_cir_settle_account_1
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0061")
      ON ACTION help_cir_settle_account_2
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0067")
      ON ACTION help_cir_settle_account_3
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0071")
      ON ACTION help_cir_settle_account_4
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0078")
      ON ACTION help_cir_settle_account_5
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0079")
      ON ACTION help_cir_trans_1
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0065")
      ON ACTION help_ais_base_1
         CALL aoos010_show_field_help("ooaa_t","E-BAS-0018")
      ON ACTION help_ais_base_2
         CALL aoos010_show_field_help("ooaa_t","E-BAS-0022")
      ON ACTION help_scm_base_1
         CALL aoos010_show_field_help("ooaa_t","E-BAS-0019")
      ON ACTION help_stock_base_1
         CALL aoos010_show_field_help("ooaa_t","E-BAS-0020")
      ON ACTION help_apm_base_1
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0026")
      ON ACTION help_apm_base_2
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0041")
      ON ACTION help_apj_base_1
         CALL aoos010_show_field_help("ooaa_t","E-COM-0007")
      ON ACTION help_agc_base_1
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0059")
      ON ACTION help_apc_touch_1
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0070")
      ON ACTION help_apc_touch_2
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0068")
      ON ACTION help_apc_touch_3
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0069")
      ON ACTION help_apc_touch_4
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0077")
 
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
PRIVATE FUNCTION aoos010_fill_data()
   DEFINE ls_sql     STRING
   DEFINE li_cnt     LIKE type_t.num5
 
   LET ls_sql = " SELECT gzsv005,gzsv006 FROM gzsv_t,gzsx_t ",
                 " WHERE gzsv001 = 'aoos010' ",   #程式編號
                   " AND gzsx001 = gzsv001 ",     #作業名稱
                   " AND gzsx002 = gzsv002 ",     #分頁編號
                   " AND gzsx003 = gzsv003 ",     #分項編號
                 #" ORDER BY gzsx004,gzsx005,gzsv004"
                 " ORDER BY gzsx004,gzsx002,gzsx005,gzsx003,gzsv004 "
 
   CALL g_gzsv.clear()
   DECLARE aoos010_fill_data_cs CURSOR FROM ls_sql
   LET li_cnt = 1
   FOREACH aoos010_fill_data_cs INTO g_gzsv[li_cnt].*
      CALL aoos010_fill_detail(li_cnt,g_gzsv[li_cnt].gzsv005,g_gzsv[li_cnt].gzsv006)
      LET li_cnt = li_cnt + 1
   END FOREACH
   CALL g_gzsv.deleteElement(li_cnt)
 
   CLOSE aoos010_fill_data_cs 
   FREE aoos010_fill_data_cs 
 
END FUNCTION
 
#+ 填寫細項
PRIVATE FUNCTION aoos010_fill_detail(li_cnt,lc_gzsv005,lc_gzsv006)
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
                      ," AND ",ls_tab,"ent = ",g_enterprise  
 
   PREPARE aoos010_fill_detail_cs FROM ls_sql
   
   LET ls_sql = "SELECT COUNT(1) FROM gzsv_t ",
                 "WHERE gzsv001 = 'aoos010' ",
                 "  AND gzsv006 = ? " 
   PREPARE aoos010_cnt_detail_cs FROM ls_sql 
   EXECUTE aoos010_cnt_detail_cs USING lc_gzsv006 INTO li_cnt2
   FREE aoos010_cnt_detail_cs
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
   
   LET ls_sql = "INSERT INTO ",ls_tab,"_t (",ls_tab,"001,",ls_tab,"002 ,",ls_tab,"ent )VALUES(?,?,? ) "
   PREPARE aoos010_ins_detail_cs FROM ls_sql 
   
   EXECUTE aoos010_fill_detail_cs USING lc_gzsv006 INTO g_ooaa_d[li_cnt].*
   IF SQLCA.SQLCODE = 100 THEN
      LET ls_sql = "SELECT gzsz008 FROM gzsz_t",
                   " WHERE gzsz001 = '",ls_tab,"_t'",
                     " AND gzsz002 = '",lc_gzsv006,"'"
      
      PREPARE aoos010_sel_detail_cs FROM ls_sql
      EXECUTE aoos010_sel_detail_cs INTO lc_gzsz008
  
      EXECUTE aoos010_ins_detail_cs USING lc_gzsv006,lc_gzsz008,g_enterprise 
      LET g_ooaa_d[li_cnt].ooaa002 = lc_gzsz008
   END IF 
 
   FREE aoos010_fill_detail_cs
   FREE aoos010_ins_detail_cs
   FREE aoos010_sel_detail_cs   
END FUNCTION
 
#+ 顯示畫面
PRIVATE FUNCTION aoos010_show()
 
   DISPLAY g_ooaa_d[1].ooaa002,g_ooaa_d[2].ooaa002,g_ooaa_d[3].ooaa002,g_ooaa_d[4].ooaa002,g_ooaa_d[5].ooaa002,
      g_ooaa_d[6].ooaa002,g_ooaa_d[7].ooaa002,g_ooaa_d[8].ooaa002,g_ooaa_d[9].ooaa002,g_ooaa_d[10].ooaa002,
      g_ooaa_d[11].ooaa002,g_ooaa_d[12].ooaa002,g_ooaa_d[13].ooaa002,g_ooaa_d[14].ooaa002,g_ooaa_d[15].ooaa002,
      g_ooaa_d[16].ooaa002,g_ooaa_d[17].ooaa002,g_ooaa_d[18].ooaa002,g_ooaa_d[19].ooaa002,g_ooaa_d[20].ooaa002,
      g_ooaa_d[21].ooaa002,g_ooaa_d[22].ooaa002,g_ooaa_d[23].ooaa002,g_ooaa_d[24].ooaa002,g_ooaa_d[25].ooaa002,
      g_ooaa_d[26].ooaa002,g_ooaa_d[27].ooaa002,g_ooaa_d[28].ooaa002,g_ooaa_d[29].ooaa002,g_ooaa_d[30].ooaa002,
      g_ooaa_d[31].ooaa002,g_ooaa_d[32].ooaa002,g_ooaa_d[33].ooaa002,g_ooaa_d[34].ooaa002,g_ooaa_d[35].ooaa002,
      g_ooaa_d[36].ooaa002,g_ooaa_d[37].ooaa002,g_ooaa_d[38].ooaa002,g_ooaa_d[39].ooaa002,g_ooaa_d[40].ooaa002,
      g_ooaa_d[41].ooaa002,g_ooaa_d[42].ooaa002,g_ooaa_d[43].ooaa002,g_ooaa_d[44].ooaa002,g_ooaa_d[45].ooaa002,
      g_ooaa_d[46].ooaa002,g_ooaa_d[47].ooaa002,g_ooaa_d[48].ooaa002,g_ooaa_d[49].ooaa002,g_ooaa_d[50].ooaa002,
      g_ooaa_d[51].ooaa002,g_ooaa_d[52].ooaa002,g_ooaa_d[53].ooaa002,g_ooaa_d[54].ooaa002,g_ooaa_d[55].ooaa002,
      g_ooaa_d[56].ooaa002,g_ooaa_d[57].ooaa002,g_ooaa_d[58].ooaa002,g_ooaa_d[59].ooaa002,g_ooaa_d[60].ooaa002,
      g_ooaa_d[61].ooaa002,g_ooaa_d[62].ooaa002,g_ooaa_d[63].ooaa002,g_ooaa_d[64].ooaa002,g_ooaa_d[65].ooaa002,
      g_ooaa_d[66].ooaa002,g_ooaa_d[67].ooaa002,g_ooaa_d[68].ooaa002,g_ooaa_d[69].ooaa002,g_ooaa_d[70].ooaa002,
      g_ooaa_d[71].ooaa002,g_ooaa_d[72].ooaa002,g_ooaa_d[73].ooaa002,g_ooaa_d[74].ooaa002,g_ooaa_d[75].ooaa002,
      g_ooaa_d[76].ooaa002,g_ooaa_d[77].ooaa002,g_ooaa_d[78].ooaa002,g_ooaa_d[79].ooaa002,g_ooaa_d[80].ooaa002,
      g_ooaa_d[81].ooaa002,g_ooaa_d[82].ooaa002,g_ooaa_d[83].ooaa002,g_ooaa_d[84].ooaa002,g_ooaa_d[85].ooaa002,
      g_ooaa_d[86].ooaa002,g_ooaa_d[87].ooaa002,g_ooaa_d[88].ooaa002,g_ooaa_d[89].ooaa002,g_ooaa_d[90].ooaa002,
      g_ooaa_d[91].ooaa002,g_ooaa_d[92].ooaa002,g_ooaa_d[93].ooaa002,g_ooaa_d[94].ooaa002,g_ooaa_d[95].ooaa002,
      g_ooaa_d[96].ooaa002,g_ooaa_d[97].ooaa002,g_ooaa_d[98].ooaa002,g_ooaa_d[99].ooaa002,g_ooaa_d[100].ooaa002,
      g_ooaa_d[101].ooaa002,g_ooaa_d[102].ooaa002,g_ooaa_d[103].ooaa002,g_ooaa_d[104].ooaa002,g_ooaa_d[105].ooaa002,
      g_ooaa_d[106].ooaa002,g_ooaa_d[107].ooaa002,g_ooaa_d[108].ooaa002,g_ooaa_d[109].ooaa002,g_ooaa_d[110].ooaa002,
      g_ooaa_d[111].ooaa002,g_ooaa_d[112].ooaa002,g_ooaa_d[113].ooaa002,g_ooaa_d[114].ooaa002,g_ooaa_d[115].ooaa002,
      g_ooaa_d[116].ooaa002,g_ooaa_d[117].ooaa002,g_ooaa_d[118].ooaa002,g_ooaa_d[119].ooaa002,g_ooaa_d[120].ooaa002,
      g_ooaa_d[121].ooaa002,g_ooaa_d[122].ooaa002,g_ooaa_d[123].ooaa002,g_ooaa_d[124].ooaa002,g_ooaa_d[125].ooaa002,
      g_ooaa_d[126].ooaa002,g_ooaa_d[127].ooaa002,g_ooaa_d[128].ooaa002,g_ooaa_d[129].ooaa002,g_ooaa_d[130].ooaa002,
      g_ooaa_d[131].ooaa002,g_ooaa_d[132].ooaa002,g_ooaa_d[133].ooaa002,g_ooaa_d[134].ooaa002,g_ooaa_d[135].ooaa002,
      g_ooaa_d[136].ooaa002,g_ooaa_d[137].ooaa002,g_ooaa_d[138].ooaa002,g_ooaa_d[139].ooaa002,g_ooaa_d[140].ooaa002,
      g_ooaa_d[141].ooaa002,g_ooaa_d[142].ooaa002,g_ooaa_d[143].ooaa002,g_ooaa_d[144].ooaa002,g_ooaa_d[145].ooaa002,
      g_ooaa_d[146].ooaa002,g_ooaa_d[147].ooaa002,g_ooaa_d[148].ooaa002,g_ooaa_d[149].ooaa002,g_ooaa_d[150].ooaa002,
      g_ooaa_d[151].ooaa002,g_ooaa_d[152].ooaa002,g_ooaa_d[153].ooaa002,g_ooaa_d[154].ooaa002,g_ooaa_d[155].ooaa002,
      g_ooaa_d[156].ooaa002,g_ooaa_d[157].ooaa002,g_ooaa_d[158].ooaa002,g_ooaa_d[159].ooaa002,g_ooaa_d[160].ooaa002,
      g_ooaa_d[161].ooaa002,g_ooaa_d[162].ooaa002,g_ooaa_d[163].ooaa002,g_ooaa_d[164].ooaa002,g_ooaa_d[165].ooaa002,
      g_ooaa_d[166].ooaa002,g_ooaa_d[167].ooaa002,g_ooaa_d[168].ooaa002,g_ooaa_d[169].ooaa002 
      
   TO basic_base_1,basic_base_4,basic_base_5,basic_base_6,basic_base_7,
   basic_base_8,basic_base_9,basic_base_10,basic_base_11,basic_process_1,
   basic_related_doc_1,basic_related_doc_2,basic_related_doc_3,basic_base2_1,basic_base2_2,
   basic_base2_3,basic_base2_4,basic_base2_5,basic_base2_6,basic_base2_7,
   basic_base2_8,basic_base2_9,basic_base2_10,basic_base2_11,basic_log_1,
   basic_log_2,basic_log_3,basic_log_4,basic_log_5,basic_log_6,
   basic_log_7,basic_log_8,basic_log_9,basic_log_10,basic_log_11,
   basic_log_12,basic_log_13,basic_log_14,basic_log_15,basic_log_16,
   basic_log_17,basic_password_1,basic_password_2,basic_password_3,basic_password_4,
   basic_password_5,basic_password_6,aws_bpm_1,aws_bpm_2,aws_bpm_3,
   aws_bpm_4,aws_EAI_1,aws_EAI_2,aws_EAI_3,aws_EAI_4,
   aws_EAI_6,aws_EAI_7,aws_MCloud_1,aws_MCloud_2,aws_PLM_1,
   aws_PLM_2,aws_EC_B2B_1,aws_EC_B2B_2,aws_EC_B2B_3,aws_POSB2B_1,
   aws_POSB2B_2,aws_POSB2B_3,uisetting_homepage_1,uisetting_homepage_2,uisetting_homepage_3,
   uisetting_homepage_4,uisetting_homepage_5,uisetting_layout_1,uisetting_layout_2,uisetting_layout_3,
   uisetting_layout_4,uisetting_layout_5,ain_base_32,ain_base_33,ain_base_34,
   ain_base_35,ain_base_36,ain_base_37,ain_base_38,ain_base_39,
   ain_base_40,amm_base_3,amm_base_6,amm_base_7,amm_base_8,
   amm_base_9,amm_base_10,aec_base_32,aec_base_33,aim_base_24,
   aim_base_25,aim_base_27,aim_base_28,aim_base_35,aim_base_36,
   aim_base_37,abm_base_23,abm_base_29,art_basic_1,art_basic_2,
   art_basic_3,art_basic_6,art_basic_7,art_basic_8,art_basic_9,
   art_basic_10,art_basic_11,art_basic_12,acr_base_1,acr_base_2,
   acr_base_3,acr_abc_1,acr_abc_2,ast_base_1,ast_base_2,
   ast_base_3,ast_base_4,ast_base_5,ast_base_6,ast_base_7,
   ast_giveback_1,fin_anm_1,fin_axr_1,fin_axr_2,cir_application_1,
   cir_application_2,cir_application_3,cir_application_4,cir_application_5,cir_application_6,
   cir_application_7,cir_application_8,cir_application_9,cir_application_10,cir_application_11,
   cir_application_12,cir_application_13,cir_application_14,cir_application_15,cir_application_16,
   cir_application_19,cir_application_20,cir_cashreturn_1,cir_cashreturn_2,cir_cashreturn_3,
   cir_cashreturn_4,cir_settle_account_1,cir_settle_account_2,cir_settle_account_3,cir_settle_account_4,
   cir_settle_account_5,cir_trans_1,ais_base_1,ais_base_2,scm_base_1,
   stock_base_1,apm_base_1,apm_base_2,apj_base_1,agc_base_1,
   apc_touch_1,apc_touch_2,apc_touch_3,apc_touch_4 
      
    
END FUNCTION
 
#+ 資料修改
PRIVATE FUNCTION aoos010_modify()
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE li_exit LIKE type_t.num5
   DEFINE ls_tmp  STRING 
   
   # 跨Table維護資料, 在修改階段除修改歷程外, 其他區塊都可直接切換
   DIALOG ATTRIBUTES(UNBUFFERED)
      INPUT g_ooaa_d[1].ooaa002,g_ooaa_d[2].ooaa002,g_ooaa_d[3].ooaa002,g_ooaa_d[4].ooaa002,g_ooaa_d[5].ooaa002,
      g_ooaa_d[6].ooaa002,g_ooaa_d[7].ooaa002,g_ooaa_d[8].ooaa002,g_ooaa_d[9].ooaa002,g_ooaa_d[10].ooaa002,
      g_ooaa_d[11].ooaa002,g_ooaa_d[12].ooaa002,g_ooaa_d[13].ooaa002,g_ooaa_d[14].ooaa002,g_ooaa_d[15].ooaa002,
      g_ooaa_d[16].ooaa002,g_ooaa_d[17].ooaa002,g_ooaa_d[18].ooaa002,g_ooaa_d[19].ooaa002,g_ooaa_d[20].ooaa002,
      g_ooaa_d[21].ooaa002,g_ooaa_d[22].ooaa002,g_ooaa_d[23].ooaa002,g_ooaa_d[24].ooaa002,g_ooaa_d[25].ooaa002,
      g_ooaa_d[26].ooaa002,g_ooaa_d[27].ooaa002,g_ooaa_d[28].ooaa002,g_ooaa_d[29].ooaa002,g_ooaa_d[30].ooaa002,
      g_ooaa_d[31].ooaa002,g_ooaa_d[32].ooaa002,g_ooaa_d[33].ooaa002,g_ooaa_d[34].ooaa002,g_ooaa_d[35].ooaa002,
      g_ooaa_d[36].ooaa002,g_ooaa_d[37].ooaa002,g_ooaa_d[38].ooaa002,g_ooaa_d[39].ooaa002,g_ooaa_d[40].ooaa002,
      g_ooaa_d[41].ooaa002,g_ooaa_d[42].ooaa002,g_ooaa_d[43].ooaa002,g_ooaa_d[44].ooaa002,g_ooaa_d[45].ooaa002,
      g_ooaa_d[46].ooaa002,g_ooaa_d[47].ooaa002,g_ooaa_d[48].ooaa002,g_ooaa_d[49].ooaa002,g_ooaa_d[50].ooaa002,
      g_ooaa_d[51].ooaa002,g_ooaa_d[52].ooaa002,g_ooaa_d[53].ooaa002,g_ooaa_d[54].ooaa002,g_ooaa_d[55].ooaa002,
      g_ooaa_d[56].ooaa002,g_ooaa_d[57].ooaa002,g_ooaa_d[58].ooaa002,g_ooaa_d[59].ooaa002,g_ooaa_d[60].ooaa002,
      g_ooaa_d[61].ooaa002,g_ooaa_d[62].ooaa002,g_ooaa_d[63].ooaa002,g_ooaa_d[64].ooaa002,g_ooaa_d[65].ooaa002,
      g_ooaa_d[66].ooaa002,g_ooaa_d[67].ooaa002,g_ooaa_d[68].ooaa002,g_ooaa_d[69].ooaa002,g_ooaa_d[70].ooaa002,
      g_ooaa_d[71].ooaa002,g_ooaa_d[72].ooaa002,g_ooaa_d[73].ooaa002,g_ooaa_d[74].ooaa002,g_ooaa_d[75].ooaa002,
      g_ooaa_d[76].ooaa002,g_ooaa_d[77].ooaa002,g_ooaa_d[78].ooaa002,g_ooaa_d[79].ooaa002,g_ooaa_d[80].ooaa002,
      g_ooaa_d[81].ooaa002,g_ooaa_d[82].ooaa002,g_ooaa_d[83].ooaa002,g_ooaa_d[84].ooaa002,g_ooaa_d[85].ooaa002,
      g_ooaa_d[86].ooaa002,g_ooaa_d[87].ooaa002,g_ooaa_d[88].ooaa002,g_ooaa_d[89].ooaa002,g_ooaa_d[90].ooaa002,
      g_ooaa_d[91].ooaa002,g_ooaa_d[92].ooaa002,g_ooaa_d[93].ooaa002,g_ooaa_d[94].ooaa002,g_ooaa_d[95].ooaa002,
      g_ooaa_d[96].ooaa002,g_ooaa_d[97].ooaa002,g_ooaa_d[98].ooaa002,g_ooaa_d[99].ooaa002,g_ooaa_d[100].ooaa002,
      g_ooaa_d[101].ooaa002,g_ooaa_d[102].ooaa002,g_ooaa_d[103].ooaa002,g_ooaa_d[104].ooaa002,g_ooaa_d[105].ooaa002,
      g_ooaa_d[106].ooaa002,g_ooaa_d[107].ooaa002,g_ooaa_d[108].ooaa002,g_ooaa_d[109].ooaa002,g_ooaa_d[110].ooaa002,
      g_ooaa_d[111].ooaa002,g_ooaa_d[112].ooaa002,g_ooaa_d[113].ooaa002,g_ooaa_d[114].ooaa002,g_ooaa_d[115].ooaa002,
      g_ooaa_d[116].ooaa002,g_ooaa_d[117].ooaa002,g_ooaa_d[118].ooaa002,g_ooaa_d[119].ooaa002,g_ooaa_d[120].ooaa002,
      g_ooaa_d[121].ooaa002,g_ooaa_d[122].ooaa002,g_ooaa_d[123].ooaa002,g_ooaa_d[124].ooaa002,g_ooaa_d[125].ooaa002,
      g_ooaa_d[126].ooaa002,g_ooaa_d[127].ooaa002,g_ooaa_d[128].ooaa002,g_ooaa_d[129].ooaa002,g_ooaa_d[130].ooaa002,
      g_ooaa_d[131].ooaa002,g_ooaa_d[132].ooaa002,g_ooaa_d[133].ooaa002,g_ooaa_d[134].ooaa002,g_ooaa_d[135].ooaa002,
      g_ooaa_d[136].ooaa002,g_ooaa_d[137].ooaa002,g_ooaa_d[138].ooaa002,g_ooaa_d[139].ooaa002,g_ooaa_d[140].ooaa002,
      g_ooaa_d[141].ooaa002,g_ooaa_d[142].ooaa002,g_ooaa_d[143].ooaa002,g_ooaa_d[144].ooaa002,g_ooaa_d[145].ooaa002,
      g_ooaa_d[146].ooaa002,g_ooaa_d[147].ooaa002,g_ooaa_d[148].ooaa002,g_ooaa_d[149].ooaa002,g_ooaa_d[150].ooaa002,
      g_ooaa_d[151].ooaa002,g_ooaa_d[152].ooaa002,g_ooaa_d[153].ooaa002,g_ooaa_d[154].ooaa002,g_ooaa_d[155].ooaa002,
      g_ooaa_d[156].ooaa002,g_ooaa_d[157].ooaa002,g_ooaa_d[158].ooaa002,g_ooaa_d[159].ooaa002,g_ooaa_d[160].ooaa002,
      g_ooaa_d[161].ooaa002,g_ooaa_d[162].ooaa002,g_ooaa_d[163].ooaa002,g_ooaa_d[164].ooaa002,g_ooaa_d[165].ooaa002,
      g_ooaa_d[166].ooaa002,g_ooaa_d[167].ooaa002,g_ooaa_d[168].ooaa002,g_ooaa_d[169].ooaa002 
       FROM basic_base_1,basic_base_4,basic_base_5,basic_base_6,basic_base_7,
   basic_base_8,basic_base_9,basic_base_10,basic_base_11,basic_process_1,
   basic_related_doc_1,basic_related_doc_2,basic_related_doc_3,basic_base2_1,basic_base2_2,
   basic_base2_3,basic_base2_4,basic_base2_5,basic_base2_6,basic_base2_7,
   basic_base2_8,basic_base2_9,basic_base2_10,basic_base2_11,basic_log_1,
   basic_log_2,basic_log_3,basic_log_4,basic_log_5,basic_log_6,
   basic_log_7,basic_log_8,basic_log_9,basic_log_10,basic_log_11,
   basic_log_12,basic_log_13,basic_log_14,basic_log_15,basic_log_16,
   basic_log_17,basic_password_1,basic_password_2,basic_password_3,basic_password_4,
   basic_password_5,basic_password_6,aws_bpm_1,aws_bpm_2,aws_bpm_3,
   aws_bpm_4,aws_EAI_1,aws_EAI_2,aws_EAI_3,aws_EAI_4,
   aws_EAI_6,aws_EAI_7,aws_MCloud_1,aws_MCloud_2,aws_PLM_1,
   aws_PLM_2,aws_EC_B2B_1,aws_EC_B2B_2,aws_EC_B2B_3,aws_POSB2B_1,
   aws_POSB2B_2,aws_POSB2B_3,uisetting_homepage_1,uisetting_homepage_2,uisetting_homepage_3,
   uisetting_homepage_4,uisetting_homepage_5,uisetting_layout_1,uisetting_layout_2,uisetting_layout_3,
   uisetting_layout_4,uisetting_layout_5,ain_base_32,ain_base_33,ain_base_34,
   ain_base_35,ain_base_36,ain_base_37,ain_base_38,ain_base_39,
   ain_base_40,amm_base_3,amm_base_6,amm_base_7,amm_base_8,
   amm_base_9,amm_base_10,aec_base_32,aec_base_33,aim_base_24,
   aim_base_25,aim_base_27,aim_base_28,aim_base_35,aim_base_36,
   aim_base_37,abm_base_23,abm_base_29,art_basic_1,art_basic_2,
   art_basic_3,art_basic_6,art_basic_7,art_basic_8,art_basic_9,
   art_basic_10,art_basic_11,art_basic_12,acr_base_1,acr_base_2,
   acr_base_3,acr_abc_1,acr_abc_2,ast_base_1,ast_base_2,
   ast_base_3,ast_base_4,ast_base_5,ast_base_6,ast_base_7,
   ast_giveback_1,fin_anm_1,fin_axr_1,fin_axr_2,cir_application_1,
   cir_application_2,cir_application_3,cir_application_4,cir_application_5,cir_application_6,
   cir_application_7,cir_application_8,cir_application_9,cir_application_10,cir_application_11,
   cir_application_12,cir_application_13,cir_application_14,cir_application_15,cir_application_16,
   cir_application_19,cir_application_20,cir_cashreturn_1,cir_cashreturn_2,cir_cashreturn_3,
   cir_cashreturn_4,cir_settle_account_1,cir_settle_account_2,cir_settle_account_3,cir_settle_account_4,
   cir_settle_account_5,cir_trans_1,ais_base_1,ais_base_2,scm_base_1,
   stock_base_1,apm_base_1,apm_base_2,apj_base_1,agc_base_1,
   apc_touch_1,apc_touch_2,apc_touch_3,apc_touch_4 
      ATTRIBUTE(WITHOUT DEFAULTS)
 
         BEFORE INPUT 
            #進行備份陣列抄寫
            FOR li_cnt = 1 TO g_ooaa_d.getLength()
               LET g_ooaa_d_t[li_cnt].* = g_ooaa_d[li_cnt].*
            END FOR 
 
         
         BEFORE FIELD basic_base_1
            CALL aoos010_show_field_help("ooaa_t","E-COM-0008")
 
         AFTER FIELD basic_base_1
         

         BEFORE FIELD basic_base_4
            CALL aoos010_show_field_help("ooaa_t","E-COM-0001")
 
         AFTER FIELD basic_base_4
         #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooaa_d[2].ooaa002,"1","1","5","1","azz-00087",1) THEN
               NEXT FIELD basic_base_4
            END IF 



         #此段落由子樣板ss01產生
            IF NOT cl_null(g_ooaa_d[2].ooaa002) THEN
               LET ls_tmp = g_ooaa_d[2].ooaa002
               IF ls_tmp.getIndexOf(".",1) THEN                  
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.extend = g_ooaa_d[2].ooaa002
                   LET g_errparam.code   = "azz-00138"
                   LET g_errparam.popup  = TRUE
                   CALL cl_err()
                   NEXT FIELD basic_base_4
               END IF   
            END IF


         

         BEFORE FIELD basic_base_5
            CALL aoos010_show_field_help("ooaa_t","E-COM-0002")
 
         AFTER FIELD basic_base_5

         BEFORE FIELD basic_base_6
            CALL aoos010_show_field_help("ooaa_t","E-COM-0003")
 
         AFTER FIELD basic_base_6
         #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooaa_d[4].ooaa002,"1","1","5","1","azz-00087",1) THEN
               NEXT FIELD basic_base_6
            END IF 



         #此段落由子樣板ss01產生
            IF NOT cl_null(g_ooaa_d[4].ooaa002) THEN
               LET ls_tmp = g_ooaa_d[4].ooaa002
               IF ls_tmp.getIndexOf(".",1) THEN                  
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.extend = g_ooaa_d[4].ooaa002
                   LET g_errparam.code   = "azz-00138"
                   LET g_errparam.popup  = TRUE
                   CALL cl_err()
                   NEXT FIELD basic_base_6
               END IF   
            END IF


         

         BEFORE FIELD basic_base_7
            CALL aoos010_show_field_help("ooaa_t","E-COM-0004")
 
         AFTER FIELD basic_base_7

         BEFORE FIELD basic_base_8
            CALL aoos010_show_field_help("ooaa_t","E-COM-0005")
 
         AFTER FIELD basic_base_8
         #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooaa_d[6].ooaa002,"","0","20","1","azz-00079",1) THEN
               NEXT FIELD basic_base_8
            END IF 



         #此段落由子樣板ss01產生
            IF NOT cl_null(g_ooaa_d[6].ooaa002) THEN
               LET ls_tmp = g_ooaa_d[6].ooaa002
               IF ls_tmp.getIndexOf(".",1) THEN                  
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.extend = g_ooaa_d[6].ooaa002
                   LET g_errparam.code   = "azz-00138"
                   LET g_errparam.popup  = TRUE
                   CALL cl_err()
                   NEXT FIELD basic_base_8
               END IF   
            END IF


         

         BEFORE FIELD basic_base_9
            CALL aoos010_show_field_help("ooaa_t","E-COM-0006")
 
         AFTER FIELD basic_base_9
         

         BEFORE FIELD basic_base_10
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0727")
 
         AFTER FIELD basic_base_10
         

         BEFORE FIELD basic_base_11
            CALL aoos010_show_field_help("gzsb_t","E-SYS-2010")
 
         AFTER FIELD basic_base_11

         BEFORE FIELD basic_process_1
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0005")
 
         AFTER FIELD basic_process_1

         BEFORE FIELD basic_related_doc_1
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0006")
 
         AFTER FIELD basic_related_doc_1
              #此段落由子樣板ss03產生(Version:2)
             
             IF NOT cl_null(g_ooaa_d[11].ooaa002)  AND g_ooaa_d[11].ooaa002 <> g_ooaa_d_t[11].ooaa002  THEN  
                
                
                #設定額外檢查功能 (gzsv007)         
                IF NOT s_aoos010_att_file_save_format(g_ooaa_d[11].ooaa002,g_ooaa_d_t[11].ooaa002) THEN  
                  LET g_ooaa_d[11].ooaa002 = g_ooaa_d_t[11].ooaa002 #放回舊值 
                  NEXT FIELD  basic_related_doc_1 #原欄位  
                END IF 
            END IF
      




         BEFORE FIELD basic_related_doc_2
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0007")
 
         AFTER FIELD basic_related_doc_2
         #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooaa_d[12].ooaa002,"1","1","1000","1","azz-00087",1) THEN
               NEXT FIELD basic_related_doc_2
            END IF 



         

         BEFORE FIELD basic_related_doc_3
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0008")
 
         AFTER FIELD basic_related_doc_3
         

         BEFORE FIELD basic_base2_1
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0001")
 
         AFTER FIELD basic_base2_1
         #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooaa_d[14].ooaa002,"100","1","30000","1","azz-00087",1) THEN
               NEXT FIELD basic_base2_1
            END IF 



         #此段落由子樣板ss01產生
            IF NOT cl_null(g_ooaa_d[14].ooaa002) THEN
               LET ls_tmp = g_ooaa_d[14].ooaa002
               IF ls_tmp.getIndexOf(".",1) THEN                  
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.extend = g_ooaa_d[14].ooaa002
                   LET g_errparam.code   = "azz-00138"
                   LET g_errparam.popup  = TRUE
                   CALL cl_err()
                   NEXT FIELD basic_base2_1
               END IF   
            END IF


         

         BEFORE FIELD basic_base2_2
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0710")
 
         AFTER FIELD basic_base2_2
         #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooaa_d[15].ooaa002,"1","1","3000","1","azz-00087",1) THEN
               NEXT FIELD basic_base2_2
            END IF 



         #此段落由子樣板ss01產生
            IF NOT cl_null(g_ooaa_d[15].ooaa002) THEN
               LET ls_tmp = g_ooaa_d[15].ooaa002
               IF ls_tmp.getIndexOf(".",1) THEN                  
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.extend = g_ooaa_d[15].ooaa002
                   LET g_errparam.code   = "azz-00138"
                   LET g_errparam.popup  = TRUE
                   CALL cl_err()
                   NEXT FIELD basic_base2_2
               END IF   
            END IF


         

         BEFORE FIELD basic_base2_3
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0002")
 
         AFTER FIELD basic_base2_3
         #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooaa_d[16].ooaa002,"10","1","","","azz-00079",1) THEN
               NEXT FIELD basic_base2_3
            END IF 



         #此段落由子樣板ss01產生
            IF NOT cl_null(g_ooaa_d[16].ooaa002) THEN
               LET ls_tmp = g_ooaa_d[16].ooaa002
               IF ls_tmp.getIndexOf(".",1) THEN                  
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.extend = g_ooaa_d[16].ooaa002
                   LET g_errparam.code   = "azz-00138"
                   LET g_errparam.popup  = TRUE
                   CALL cl_err()
                   NEXT FIELD basic_base2_3
               END IF   
            END IF


         

         BEFORE FIELD basic_base2_4
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0003")
 
         AFTER FIELD basic_base2_4
         #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooaa_d[17].ooaa002,"200","1","","","azz-00079",1) THEN
               NEXT FIELD basic_base2_4
            END IF 



         #此段落由子樣板ss01產生
            IF NOT cl_null(g_ooaa_d[17].ooaa002) THEN
               LET ls_tmp = g_ooaa_d[17].ooaa002
               IF ls_tmp.getIndexOf(".",1) THEN                  
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.extend = g_ooaa_d[17].ooaa002
                   LET g_errparam.code   = "azz-00138"
                   LET g_errparam.popup  = TRUE
                   CALL cl_err()
                   NEXT FIELD basic_base2_4
               END IF   
            END IF


         

         BEFORE FIELD basic_base2_5
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0004")
 
         AFTER FIELD basic_base2_5
         #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooaa_d[18].ooaa002,"1000","0","","","azz-00079",1) THEN
               NEXT FIELD basic_base2_5
            END IF 



         #此段落由子樣板ss01產生
            IF NOT cl_null(g_ooaa_d[18].ooaa002) THEN
               LET ls_tmp = g_ooaa_d[18].ooaa002
               IF ls_tmp.getIndexOf(".",1) THEN                  
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.extend = g_ooaa_d[18].ooaa002
                   LET g_errparam.code   = "azz-00138"
                   LET g_errparam.popup  = TRUE
                   CALL cl_err()
                   NEXT FIELD basic_base2_5
               END IF   
            END IF


         

         BEFORE FIELD basic_base2_6
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0009")
 
         AFTER FIELD basic_base2_6
         

         BEFORE FIELD basic_base2_7
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0010")
 
         AFTER FIELD basic_base2_7

         BEFORE FIELD basic_base2_8
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0035")
 
         AFTER FIELD basic_base2_8
         

         BEFORE FIELD basic_base2_9
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0011")
 
         AFTER FIELD basic_base2_9
         #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooaa_d[22].ooaa002,"60","1","30000","1","azz-00087",1) THEN
               NEXT FIELD basic_base2_9
            END IF 



         #此段落由子樣板ss01產生
            IF NOT cl_null(g_ooaa_d[22].ooaa002) THEN
               LET ls_tmp = g_ooaa_d[22].ooaa002
               IF ls_tmp.getIndexOf(".",1) THEN                  
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.extend = g_ooaa_d[22].ooaa002
                   LET g_errparam.code   = "azz-00138"
                   LET g_errparam.popup  = TRUE
                   CALL cl_err()
                   NEXT FIELD basic_base2_9
               END IF   
            END IF


         

         BEFORE FIELD basic_base2_10
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0036")
 
         AFTER FIELD basic_base2_10
         #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooaa_d[23].ooaa002,"30","1","300","1","azz-00087",1) THEN
               NEXT FIELD basic_base2_10
            END IF 



         #此段落由子樣板ss01產生
            IF NOT cl_null(g_ooaa_d[23].ooaa002) THEN
               LET ls_tmp = g_ooaa_d[23].ooaa002
               IF ls_tmp.getIndexOf(".",1) THEN                  
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.extend = g_ooaa_d[23].ooaa002
                   LET g_errparam.code   = "azz-00138"
                   LET g_errparam.popup  = TRUE
                   CALL cl_err()
                   NEXT FIELD basic_base2_10
               END IF   
            END IF


         

         BEFORE FIELD basic_base2_11
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0712")
 
         AFTER FIELD basic_base2_11
         #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooaa_d[24].ooaa002,"0","1","50","1","azz-00087",1) THEN
               NEXT FIELD basic_base2_11
            END IF 



         #此段落由子樣板ss01產生
            IF NOT cl_null(g_ooaa_d[24].ooaa002) THEN
               LET ls_tmp = g_ooaa_d[24].ooaa002
               IF ls_tmp.getIndexOf(".",1) THEN                  
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.extend = g_ooaa_d[24].ooaa002
                   LET g_errparam.code   = "azz-00138"
                   LET g_errparam.popup  = TRUE
                   CALL cl_err()
                   NEXT FIELD basic_base2_11
               END IF   
            END IF


         

         BEFORE FIELD basic_log_1
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0012")
 
         AFTER FIELD basic_log_1

         BEFORE FIELD basic_log_2
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0013")
 
         AFTER FIELD basic_log_2

         BEFORE FIELD basic_log_3
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0014")
 
         AFTER FIELD basic_log_3

         BEFORE FIELD basic_log_4
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0015")
 
         AFTER FIELD basic_log_4

         BEFORE FIELD basic_log_5
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0016")
 
         AFTER FIELD basic_log_5

         BEFORE FIELD basic_log_6
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0017")
 
         AFTER FIELD basic_log_6

         BEFORE FIELD basic_log_7
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0034")
 
         AFTER FIELD basic_log_7

         BEFORE FIELD basic_log_8
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0018")
 
         AFTER FIELD basic_log_8

         BEFORE FIELD basic_log_9
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0019")
 
         AFTER FIELD basic_log_9

         BEFORE FIELD basic_log_10
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0020")
 
         AFTER FIELD basic_log_10

         BEFORE FIELD basic_log_11
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0021")
 
         AFTER FIELD basic_log_11

         BEFORE FIELD basic_log_12
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0022")
 
         AFTER FIELD basic_log_12

         BEFORE FIELD basic_log_13
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0023")
 
         AFTER FIELD basic_log_13

         BEFORE FIELD basic_log_14
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0024")
 
         AFTER FIELD basic_log_14

         BEFORE FIELD basic_log_15
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0025")
 
         AFTER FIELD basic_log_15

         BEFORE FIELD basic_log_16
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0026")
 
         AFTER FIELD basic_log_16

         BEFORE FIELD basic_log_17
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0027")
 
         AFTER FIELD basic_log_17

         BEFORE FIELD basic_password_1
            CALL aoos010_show_field_help("gzsb_t","E-SYS-2006")
 
         AFTER FIELD basic_password_1
         

         BEFORE FIELD basic_password_2
            CALL aoos010_show_field_help("gzsb_t","E-SYS-2003")
 
         AFTER FIELD basic_password_2
         #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooaa_d[43].ooaa002,"6","1","12","1","azz-00087",1) THEN
               NEXT FIELD basic_password_2
            END IF 



         

         BEFORE FIELD basic_password_3
            CALL aoos010_show_field_help("gzsb_t","E-SYS-2004")
 
         AFTER FIELD basic_password_3
         

         BEFORE FIELD basic_password_4
            CALL aoos010_show_field_help("gzsb_t","E-SYS-2005")
 
         AFTER FIELD basic_password_4

         BEFORE FIELD basic_password_5
            CALL aoos010_show_field_help("gzsb_t","E-SYS-2002")
 
         AFTER FIELD basic_password_5

         BEFORE FIELD basic_password_6
            CALL aoos010_show_field_help("gzsb_t","E-SYS-2009")
 
         AFTER FIELD basic_password_6
         

         BEFORE FIELD aws_bpm_1
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0700")
 
         AFTER FIELD aws_bpm_1

         BEFORE FIELD aws_bpm_2
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0701")
 
         AFTER FIELD aws_bpm_2
         

         BEFORE FIELD aws_bpm_3
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0702")
 
         AFTER FIELD aws_bpm_3
         

         BEFORE FIELD aws_bpm_4
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0703")
 
         AFTER FIELD aws_bpm_4
         

         BEFORE FIELD aws_EAI_1
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0705")
 
         AFTER FIELD aws_EAI_1

         BEFORE FIELD aws_EAI_2
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0704")
 
         AFTER FIELD aws_EAI_2
         

         BEFORE FIELD aws_EAI_3
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0715")
 
         AFTER FIELD aws_EAI_3
         

         BEFORE FIELD aws_EAI_4
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0716")
 
         AFTER FIELD aws_EAI_4
         

         BEFORE FIELD aws_EAI_6
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0707")
 
         AFTER FIELD aws_EAI_6

         BEFORE FIELD aws_EAI_7
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0717")
 
         AFTER FIELD aws_EAI_7
         

         BEFORE FIELD aws_MCloud_1
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0708")
 
         AFTER FIELD aws_MCloud_1

         BEFORE FIELD aws_MCloud_2
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0709")
 
         AFTER FIELD aws_MCloud_2
         

         BEFORE FIELD aws_PLM_1
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0718")
 
         AFTER FIELD aws_PLM_1

         BEFORE FIELD aws_PLM_2
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0719")
 
         AFTER FIELD aws_PLM_2
         

         BEFORE FIELD aws_EC_B2B_1
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0720")
 
         AFTER FIELD aws_EC_B2B_1

         BEFORE FIELD aws_EC_B2B_2
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0721")
 
         AFTER FIELD aws_EC_B2B_2
         

         BEFORE FIELD aws_EC_B2B_3
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0722")
 
         AFTER FIELD aws_EC_B2B_3
         

         BEFORE FIELD aws_POSB2B_1
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0724")
 
         AFTER FIELD aws_POSB2B_1

         BEFORE FIELD aws_POSB2B_2
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0725")
 
         AFTER FIELD aws_POSB2B_2
         

         BEFORE FIELD aws_POSB2B_3
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0726")
 
         AFTER FIELD aws_POSB2B_3
         

         BEFORE FIELD uisetting_homepage_1
            CALL aoos010_show_field_help("gzsb_t","E-SYS-2001")
 
         AFTER FIELD uisetting_homepage_1
         

         BEFORE FIELD uisetting_homepage_2
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0033")
 
         AFTER FIELD uisetting_homepage_2
         

         BEFORE FIELD uisetting_homepage_3
            CALL aoos010_show_field_help("gzsb_t","E-SYS-2007")
 
         AFTER FIELD uisetting_homepage_3
              #此段落由子樣板ss03產生(Version:2)
             
             IF NOT cl_null(g_ooaa_d[70].ooaa002)  AND g_ooaa_d[70].ooaa002 <> g_ooaa_d_t[70].ooaa002  THEN  
                
                #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                INITIALIZE g_chkparam.* TO NULL
                #設定g_chkparam.*的參數
                LET g_chkparam.arg1 = g_ooaa_d[70].ooaa002
                #呼叫檢查存在的library
                IF NOT cl_chk_exist("v_gzzy001") THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_ooaa_d[70].ooaa002
                  LET g_errparam.code   = "lib-00089"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_ooaa_d[70].ooaa002 = g_ooaa_d_t[70].ooaa002 #放回舊值
                  NEXT FIELD uisetting_homepage_3 
                END IF
                
            END IF
      




         BEFORE FIELD uisetting_homepage_4
            CALL aoos010_show_field_help("gzsb_t","E-SYS-2008")
 
         AFTER FIELD uisetting_homepage_4

         BEFORE FIELD uisetting_homepage_5
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0723")
 
         AFTER FIELD uisetting_homepage_5
         

         BEFORE FIELD uisetting_layout_1
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0711")
 
         AFTER FIELD uisetting_layout_1
         

         BEFORE FIELD uisetting_layout_2
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0028")
 
         AFTER FIELD uisetting_layout_2

         BEFORE FIELD uisetting_layout_3
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0031")
 
         AFTER FIELD uisetting_layout_3
         

         BEFORE FIELD uisetting_layout_4
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0029")
 
         AFTER FIELD uisetting_layout_4

         BEFORE FIELD uisetting_layout_5
            CALL aoos010_show_field_help("ooaa_t","E-SYS-0030")
 
         AFTER FIELD uisetting_layout_5

         BEFORE FIELD ain_base_32
            CALL aoos010_show_field_help("ooaa_t","E-BAS-0013")
 
         AFTER FIELD ain_base_32

         BEFORE FIELD ain_base_33
            CALL aoos010_show_field_help("ooaa_t","E-BAS-0014")
 
         AFTER FIELD ain_base_33

         BEFORE FIELD ain_base_34
            CALL aoos010_show_field_help("ooaa_t","E-BAS-0015")
 
         AFTER FIELD ain_base_34
         

         BEFORE FIELD ain_base_35
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0029")
 
         AFTER FIELD ain_base_35
         

         BEFORE FIELD ain_base_36
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0047")
 
         AFTER FIELD ain_base_36

         BEFORE FIELD ain_base_37
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0048")
 
         AFTER FIELD ain_base_37

         BEFORE FIELD ain_base_38
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0050")
 
         AFTER FIELD ain_base_38
              #此段落由子樣板ss03產生(Version:2)
             
             IF NOT cl_null(g_ooaa_d[84].ooaa002)  AND g_ooaa_d[84].ooaa002 <> g_ooaa_d_t[84].ooaa002  THEN  
                
                #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                INITIALIZE g_chkparam.* TO NULL
                #設定g_chkparam.*的參數
                LET g_chkparam.arg1 = g_ooaa_d[84].ooaa002
                #呼叫檢查存在的library
                IF NOT cl_chk_exist("v_oocq002_216") THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_ooaa_d[84].ooaa002
                  LET g_errparam.code   = "lib-00089"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_ooaa_d[84].ooaa002 = g_ooaa_d_t[84].ooaa002 #放回舊值
                  NEXT FIELD ain_base_38 
                END IF
                
            END IF
      




         BEFORE FIELD ain_base_39
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0053")
 
         AFTER FIELD ain_base_39

         BEFORE FIELD ain_base_40
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0055")
 
         AFTER FIELD ain_base_40

         BEFORE FIELD amm_base_3
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0003")
 
         AFTER FIELD amm_base_3

         BEFORE FIELD amm_base_6
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0004")
 
         AFTER FIELD amm_base_6
         

         BEFORE FIELD amm_base_7
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0051")
 
         AFTER FIELD amm_base_7
              #此段落由子樣板ss03產生(Version:2)
             
             IF NOT cl_null(g_ooaa_d[89].ooaa002)  AND g_ooaa_d[89].ooaa002 <> g_ooaa_d_t[89].ooaa002  THEN  
                
                #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                INITIALIZE g_chkparam.* TO NULL
                #設定g_chkparam.*的參數
                LET g_chkparam.arg1 = g_ooaa_d[89].ooaa002
                #呼叫檢查存在的library
                IF NOT cl_chk_exist("v_oocq002_216") THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_ooaa_d[89].ooaa002
                  LET g_errparam.code   = "lib-00089"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_ooaa_d[89].ooaa002 = g_ooaa_d_t[89].ooaa002 #放回舊值
                  NEXT FIELD amm_base_7 
                END IF
                
            END IF
      




         BEFORE FIELD amm_base_8
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0063")
 
         AFTER FIELD amm_base_8
              #此段落由子樣板ss03產生(Version:2)
             
             IF NOT cl_null(g_ooaa_d[90].ooaa002)  AND g_ooaa_d[90].ooaa002 <> g_ooaa_d_t[90].ooaa002  THEN  
                
                #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                INITIALIZE g_chkparam.* TO NULL
                #設定g_chkparam.*的參數
                LET g_chkparam.arg1 = g_ooaa_d[90].ooaa002
                #呼叫檢查存在的library
                IF NOT cl_chk_exist("v_mmcu001") THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_ooaa_d[90].ooaa002
                  LET g_errparam.code   = "lib-00089"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_ooaa_d[90].ooaa002 = g_ooaa_d_t[90].ooaa002 #放回舊值
                  NEXT FIELD amm_base_8 
                END IF
                
            END IF
      




         BEFORE FIELD amm_base_9
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0073")
 
         AFTER FIELD amm_base_9
         

         BEFORE FIELD amm_base_10
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0075")
 
         AFTER FIELD amm_base_10

         BEFORE FIELD aec_base_32
            CALL aoos010_show_field_help("ooaa_t","E-MFG-0001")
 
         AFTER FIELD aec_base_32
         #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooaa_d[93].ooaa002,"0","0","","","azz-00079",1) THEN
               NEXT FIELD aec_base_32
            END IF 



         #此段落由子樣板ss01產生
            IF NOT cl_null(g_ooaa_d[93].ooaa002) THEN
               LET ls_tmp = g_ooaa_d[93].ooaa002
               IF ls_tmp.getIndexOf(".",1) THEN                  
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.extend = g_ooaa_d[93].ooaa002
                   LET g_errparam.code   = "azz-00138"
                   LET g_errparam.popup  = TRUE
                   CALL cl_err()
                   NEXT FIELD aec_base_32
               END IF   
            END IF


         

         BEFORE FIELD aec_base_33
            CALL aoos010_show_field_help("ooaa_t","E-MFG-0002")
 
         AFTER FIELD aec_base_33

         BEFORE FIELD aim_base_24
            CALL aoos010_show_field_help("ooaa_t","E-BAS-0003")
 
         AFTER FIELD aim_base_24
         #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooaa_d[95].ooaa002,"5","1","40","1","azz-00087",1) THEN
               NEXT FIELD aim_base_24
            END IF 



         #此段落由子樣板ss01產生
            IF NOT cl_null(g_ooaa_d[95].ooaa002) THEN
               LET ls_tmp = g_ooaa_d[95].ooaa002
               IF ls_tmp.getIndexOf(".",1) THEN                  
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.extend = g_ooaa_d[95].ooaa002
                   LET g_errparam.code   = "azz-00138"
                   LET g_errparam.popup  = TRUE
                   CALL cl_err()
                   NEXT FIELD aim_base_24
               END IF   
            END IF


         

         BEFORE FIELD aim_base_25
            CALL aoos010_show_field_help("ooaa_t","E-BAS-0004")
 
         AFTER FIELD aim_base_25

         BEFORE FIELD aim_base_27
            CALL aoos010_show_field_help("ooaa_t","E-BAS-0006")
 
         AFTER FIELD aim_base_27
         #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooaa_d[97].ooaa002,"40","1","255","1","azz-00087",1) THEN
               NEXT FIELD aim_base_27
            END IF 



         #此段落由子樣板ss01產生
            IF NOT cl_null(g_ooaa_d[97].ooaa002) THEN
               LET ls_tmp = g_ooaa_d[97].ooaa002
               IF ls_tmp.getIndexOf(".",1) THEN                  
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.extend = g_ooaa_d[97].ooaa002
                   LET g_errparam.code   = "azz-00138"
                   LET g_errparam.popup  = TRUE
                   CALL cl_err()
                   NEXT FIELD aim_base_27
               END IF   
            END IF


         

         BEFORE FIELD aim_base_28
            CALL aoos010_show_field_help("ooaa_t","E-BAS-0007")
 
         AFTER FIELD aim_base_28
         #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooaa_d[98].ooaa002,"40","1","255","1","azz-00087",1) THEN
               NEXT FIELD aim_base_28
            END IF 



         #此段落由子樣板ss01產生
            IF NOT cl_null(g_ooaa_d[98].ooaa002) THEN
               LET ls_tmp = g_ooaa_d[98].ooaa002
               IF ls_tmp.getIndexOf(".",1) THEN                  
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.extend = g_ooaa_d[98].ooaa002
                   LET g_errparam.code   = "azz-00138"
                   LET g_errparam.popup  = TRUE
                   CALL cl_err()
                   NEXT FIELD aim_base_28
               END IF   
            END IF


         

         BEFORE FIELD aim_base_35
            CALL aoos010_show_field_help("ooaa_t","E-BAS-0012")
 
         AFTER FIELD aim_base_35

         BEFORE FIELD aim_base_36
            CALL aoos010_show_field_help("ooaa_t","E-BAS-0017")
 
         AFTER FIELD aim_base_36

         BEFORE FIELD aim_base_37
            CALL aoos010_show_field_help("ooaa_t","E-BAS-0027")
 
         AFTER FIELD aim_base_37

         BEFORE FIELD abm_base_23
            CALL aoos010_show_field_help("ooaa_t","E-BAS-0002")
 
         AFTER FIELD abm_base_23

         BEFORE FIELD abm_base_29
            CALL aoos010_show_field_help("ooaa_t","E-BAS-0008")
 
         AFTER FIELD abm_base_29
         #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooaa_d[103].ooaa002,"0","1","10","1","azz-00087",1) THEN
               NEXT FIELD abm_base_29
            END IF 



         #此段落由子樣板ss01產生
            IF NOT cl_null(g_ooaa_d[103].ooaa002) THEN
               LET ls_tmp = g_ooaa_d[103].ooaa002
               IF ls_tmp.getIndexOf(".",1) THEN                  
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.extend = g_ooaa_d[103].ooaa002
                   LET g_errparam.code   = "azz-00138"
                   LET g_errparam.popup  = TRUE
                   CALL cl_err()
                   NEXT FIELD abm_base_29
               END IF   
            END IF


         

         BEFORE FIELD art_basic_1
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0001")
 
         AFTER FIELD art_basic_1
         #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooaa_d[104].ooaa002,"0","0","","","azz-00079",1) THEN
               NEXT FIELD art_basic_1
            END IF 



         #此段落由子樣板ss01產生
            IF NOT cl_null(g_ooaa_d[104].ooaa002) THEN
               LET ls_tmp = g_ooaa_d[104].ooaa002
               IF ls_tmp.getIndexOf(".",1) THEN                  
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.extend = g_ooaa_d[104].ooaa002
                   LET g_errparam.code   = "azz-00138"
                   LET g_errparam.popup  = TRUE
                   CALL cl_err()
                   NEXT FIELD art_basic_1
               END IF   
            END IF


         

         BEFORE FIELD art_basic_2
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0062")
 
         AFTER FIELD art_basic_2
         #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooaa_d[105].ooaa002,"0","0","","","azz-00079",1) THEN
               NEXT FIELD art_basic_2
            END IF 



         #此段落由子樣板ss01產生
            IF NOT cl_null(g_ooaa_d[105].ooaa002) THEN
               LET ls_tmp = g_ooaa_d[105].ooaa002
               IF ls_tmp.getIndexOf(".",1) THEN                  
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.extend = g_ooaa_d[105].ooaa002
                   LET g_errparam.code   = "azz-00138"
                   LET g_errparam.popup  = TRUE
                   CALL cl_err()
                   NEXT FIELD art_basic_2
               END IF   
            END IF


         

         BEFORE FIELD art_basic_3
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0028")
 
         AFTER FIELD art_basic_3
         

         BEFORE FIELD art_basic_6
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0010")
 
         AFTER FIELD art_basic_6

         BEFORE FIELD art_basic_7
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0032")
 
         AFTER FIELD art_basic_7
              #此段落由子樣板ss03產生(Version:2)
             
             IF NOT cl_null(g_ooaa_d[108].ooaa002)  AND g_ooaa_d[108].ooaa002 <> g_ooaa_d_t[108].ooaa002  THEN  
                
                #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                INITIALIZE g_chkparam.* TO NULL
                #設定g_chkparam.*的參數
                LET g_chkparam.arg1 = g_ooaa_d[108].ooaa002
                #呼叫檢查存在的library
                IF NOT cl_chk_exist("v_imaa004") THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_ooaa_d[108].ooaa002
                  LET g_errparam.code   = "lib-00089"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_ooaa_d[108].ooaa002 = g_ooaa_d_t[108].ooaa002 #放回舊值
                  NEXT FIELD art_basic_7 
                END IF
                
            END IF
      




         BEFORE FIELD art_basic_8
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0043")
 
         AFTER FIELD art_basic_8
              #此段落由子樣板ss03產生(Version:2)
             
             IF NOT cl_null(g_ooaa_d[109].ooaa002)  AND g_ooaa_d[109].ooaa002 <> g_ooaa_d_t[109].ooaa002  THEN  
                
                #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                INITIALIZE g_chkparam.* TO NULL
                #設定g_chkparam.*的參數
                LET g_chkparam.arg1 = g_ooaa_d[109].ooaa002
                #呼叫檢查存在的library
                IF NOT cl_chk_exist("v_imaa004") THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_ooaa_d[109].ooaa002
                  LET g_errparam.code   = "lib-00089"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_ooaa_d[109].ooaa002 = g_ooaa_d_t[109].ooaa002 #放回舊值
                  NEXT FIELD art_basic_8 
                END IF
                
            END IF
      




         BEFORE FIELD art_basic_9
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0046")
 
         AFTER FIELD art_basic_9
         #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooaa_d[110].ooaa002,"1","1","5","1","azz-00087",1) THEN
               NEXT FIELD art_basic_9
            END IF 



         

         BEFORE FIELD art_basic_10
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0052")
 
         AFTER FIELD art_basic_10

         BEFORE FIELD art_basic_11
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0056")
 
         AFTER FIELD art_basic_11
              #此段落由子樣板ss03產生(Version:2)
             
             IF NOT cl_null(g_ooaa_d[112].ooaa002)  AND g_ooaa_d[112].ooaa002 <> g_ooaa_d_t[112].ooaa002  THEN  
                
                #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                INITIALIZE g_chkparam.* TO NULL
                #設定g_chkparam.*的參數
                LET g_chkparam.arg1 = g_ooaa_d[112].ooaa002
                #呼叫檢查存在的library
                IF NOT cl_chk_exist("v_rtda001_1") THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_ooaa_d[112].ooaa002
                  LET g_errparam.code   = "lib-00089"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_ooaa_d[112].ooaa002 = g_ooaa_d_t[112].ooaa002 #放回舊值
                  NEXT FIELD art_basic_11 
                END IF
                
            END IF
      




         BEFORE FIELD art_basic_12
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0074")
 
         AFTER FIELD art_basic_12
              #此段落由子樣板ss03產生(Version:2)
             
             IF NOT cl_null(g_ooaa_d[113].ooaa002)  AND g_ooaa_d[113].ooaa002 <> g_ooaa_d_t[113].ooaa002  THEN  
                
                #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                INITIALIZE g_chkparam.* TO NULL
                #設定g_chkparam.*的參數
                LET g_chkparam.arg1 = g_ooaa_d[113].ooaa002
                #呼叫檢查存在的library
                IF NOT cl_chk_exist("v_imaa001") THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_ooaa_d[113].ooaa002
                  LET g_errparam.code   = "lib-00089"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_ooaa_d[113].ooaa002 = g_ooaa_d_t[113].ooaa002 #放回舊值
                  NEXT FIELD art_basic_12 
                END IF
                
            END IF
      




         BEFORE FIELD acr_base_1
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0005")
 
         AFTER FIELD acr_base_1
         #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooaa_d[114].ooaa002,"1","1","24","1","azz-00087",1) THEN
               NEXT FIELD acr_base_1
            END IF 



         #此段落由子樣板ss01產生
            IF NOT cl_null(g_ooaa_d[114].ooaa002) THEN
               LET ls_tmp = g_ooaa_d[114].ooaa002
               IF ls_tmp.getIndexOf(".",1) THEN                  
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.extend = g_ooaa_d[114].ooaa002
                   LET g_errparam.code   = "azz-00138"
                   LET g_errparam.popup  = TRUE
                   CALL cl_err()
                   NEXT FIELD acr_base_1
               END IF   
            END IF


         

         BEFORE FIELD acr_base_2
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0006")
 
         AFTER FIELD acr_base_2
         #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooaa_d[115].ooaa002,"1","1","24","1","azz-00087",1) THEN
               NEXT FIELD acr_base_2
            END IF 



         #此段落由子樣板ss01產生
            IF NOT cl_null(g_ooaa_d[115].ooaa002) THEN
               LET ls_tmp = g_ooaa_d[115].ooaa002
               IF ls_tmp.getIndexOf(".",1) THEN                  
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.extend = g_ooaa_d[115].ooaa002
                   LET g_errparam.code   = "azz-00138"
                   LET g_errparam.popup  = TRUE
                   CALL cl_err()
                   NEXT FIELD acr_base_2
               END IF   
            END IF


         

         BEFORE FIELD acr_base_3
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0007")
 
         AFTER FIELD acr_base_3
         

         BEFORE FIELD acr_abc_1
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0008")
 
         AFTER FIELD acr_abc_1
         #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooaa_d[117].ooaa002,"1","1","100","1","azz-00087",1) THEN
               NEXT FIELD acr_abc_1
            END IF 



         

         BEFORE FIELD acr_abc_2
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0009")
 
         AFTER FIELD acr_abc_2
         #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooaa_d[118].ooaa002,"1","1","100","1","azz-00087",1) THEN
               NEXT FIELD acr_abc_2
            END IF 



         

         BEFORE FIELD ast_base_1
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0011")
 
         AFTER FIELD ast_base_1
         

         BEFORE FIELD ast_base_2
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0045")
 
         AFTER FIELD ast_base_2
              #此段落由子樣板ss03產生(Version:2)
             
             IF NOT cl_null(g_ooaa_d[120].ooaa002)  AND g_ooaa_d[120].ooaa002 <> g_ooaa_d_t[120].ooaa002  THEN  
                
                #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                INITIALIZE g_chkparam.* TO NULL
                #設定g_chkparam.*的參數
                LET g_chkparam.arg1 = g_ooaa_d[120].ooaa002
                #呼叫檢查存在的library
                IF NOT cl_chk_exist("v_stae001") THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_ooaa_d[120].ooaa002
                  LET g_errparam.code   = "lib-00089"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_ooaa_d[120].ooaa002 = g_ooaa_d_t[120].ooaa002 #放回舊值
                  NEXT FIELD ast_base_2 
                END IF
                
            END IF
      




         BEFORE FIELD ast_base_3
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0049")
 
         AFTER FIELD ast_base_3

         BEFORE FIELD ast_base_4
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0054")
 
         AFTER FIELD ast_base_4

         BEFORE FIELD ast_base_5
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0057")
 
         AFTER FIELD ast_base_5
         #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooaa_d[123].ooaa002,"0","1","200","1","azz-00087",1) THEN
               NEXT FIELD ast_base_5
            END IF 



         #此段落由子樣板ss01產生
            IF NOT cl_null(g_ooaa_d[123].ooaa002) THEN
               LET ls_tmp = g_ooaa_d[123].ooaa002
               IF ls_tmp.getIndexOf(".",1) THEN                  
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.extend = g_ooaa_d[123].ooaa002
                   LET g_errparam.code   = "azz-00138"
                   LET g_errparam.popup  = TRUE
                   CALL cl_err()
                   NEXT FIELD ast_base_5
               END IF   
            END IF


         

         BEFORE FIELD ast_base_6
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0058")
 
         AFTER FIELD ast_base_6
         

         BEFORE FIELD ast_base_7
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0060")
 
         AFTER FIELD ast_base_7

         BEFORE FIELD ast_giveback_1
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0064")
 
         AFTER FIELD ast_giveback_1
         

         BEFORE FIELD fin_anm_1
            CALL aoos010_show_field_help("ooaa_t","E-FIN-0001")
 
         AFTER FIELD fin_anm_1

         BEFORE FIELD fin_axr_1
            CALL aoos010_show_field_help("ooaa_t","E-FIN-0002")
 
         AFTER FIELD fin_axr_1

         BEFORE FIELD fin_axr_2
            CALL aoos010_show_field_help("ooaa_t","E-FIN-0003")
 
         AFTER FIELD fin_axr_2

         BEFORE FIELD cir_application_1
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0035")
 
         AFTER FIELD cir_application_1

         BEFORE FIELD cir_application_2
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0036")
 
         AFTER FIELD cir_application_2

         BEFORE FIELD cir_application_3
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0018")
 
         AFTER FIELD cir_application_3

         BEFORE FIELD cir_application_4
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0023")
 
         AFTER FIELD cir_application_4

         BEFORE FIELD cir_application_5
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0025")
 
         AFTER FIELD cir_application_5

         BEFORE FIELD cir_application_6
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0044")
 
         AFTER FIELD cir_application_6

         BEFORE FIELD cir_application_7
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0022")
 
         AFTER FIELD cir_application_7

         BEFORE FIELD cir_application_8
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0016")
 
         AFTER FIELD cir_application_8

         BEFORE FIELD cir_application_9
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0024")
 
         AFTER FIELD cir_application_9

         BEFORE FIELD cir_application_10
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0017")
 
         AFTER FIELD cir_application_10

         BEFORE FIELD cir_application_11
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0038")
 
         AFTER FIELD cir_application_11

         BEFORE FIELD cir_application_12
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0037")
 
         AFTER FIELD cir_application_12

         BEFORE FIELD cir_application_13
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0019")
 
         AFTER FIELD cir_application_13

         BEFORE FIELD cir_application_14
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0033")
 
         AFTER FIELD cir_application_14

         BEFORE FIELD cir_application_15
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0027")
 
         AFTER FIELD cir_application_15

         BEFORE FIELD cir_application_16
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0034")
 
         AFTER FIELD cir_application_16

         BEFORE FIELD cir_application_19
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0002")
 
         AFTER FIELD cir_application_19

         BEFORE FIELD cir_application_20
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0076")
 
         AFTER FIELD cir_application_20

         BEFORE FIELD cir_cashreturn_1
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0030")
 
         AFTER FIELD cir_cashreturn_1

         BEFORE FIELD cir_cashreturn_2
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0031")
 
         AFTER FIELD cir_cashreturn_2

         BEFORE FIELD cir_cashreturn_3
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0042")
 
         AFTER FIELD cir_cashreturn_3
         #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooaa_d[150].ooaa002,"0","1","","","azz-00079",1) THEN
               NEXT FIELD cir_cashreturn_3
            END IF 



         #此段落由子樣板ss01產生
            IF NOT cl_null(g_ooaa_d[150].ooaa002) THEN
               LET ls_tmp = g_ooaa_d[150].ooaa002
               IF ls_tmp.getIndexOf(".",1) THEN                  
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.extend = g_ooaa_d[150].ooaa002
                   LET g_errparam.code   = "azz-00138"
                   LET g_errparam.popup  = TRUE
                   CALL cl_err()
                   NEXT FIELD cir_cashreturn_3
               END IF   
            END IF


         

         BEFORE FIELD cir_cashreturn_4
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0072")
 
         AFTER FIELD cir_cashreturn_4

         BEFORE FIELD cir_settle_account_1
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0061")
 
         AFTER FIELD cir_settle_account_1
         

         BEFORE FIELD cir_settle_account_2
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0067")
 
         AFTER FIELD cir_settle_account_2
         

         BEFORE FIELD cir_settle_account_3
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0071")
 
         AFTER FIELD cir_settle_account_3
         

         BEFORE FIELD cir_settle_account_4
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0078")
 
         AFTER FIELD cir_settle_account_4

         BEFORE FIELD cir_settle_account_5
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0079")
 
         AFTER FIELD cir_settle_account_5

         BEFORE FIELD cir_trans_1
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0065")
 
         AFTER FIELD cir_trans_1
         

         BEFORE FIELD ais_base_1
            CALL aoos010_show_field_help("ooaa_t","E-BAS-0018")
 
         AFTER FIELD ais_base_1

         BEFORE FIELD ais_base_2
            CALL aoos010_show_field_help("ooaa_t","E-BAS-0022")
 
         AFTER FIELD ais_base_2

         BEFORE FIELD scm_base_1
            CALL aoos010_show_field_help("ooaa_t","E-BAS-0019")
 
         AFTER FIELD scm_base_1

         BEFORE FIELD stock_base_1
            CALL aoos010_show_field_help("ooaa_t","E-BAS-0020")
 
         AFTER FIELD stock_base_1

         BEFORE FIELD apm_base_1
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0026")
 
         AFTER FIELD apm_base_1
         

         BEFORE FIELD apm_base_2
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0041")
 
         AFTER FIELD apm_base_2

         BEFORE FIELD apj_base_1
            CALL aoos010_show_field_help("ooaa_t","E-COM-0007")
 
         AFTER FIELD apj_base_1
         #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooaa_d[164].ooaa002,"0","0","","","azz-00079",1) THEN
               NEXT FIELD apj_base_1
            END IF 



         #此段落由子樣板ss01產生
            IF NOT cl_null(g_ooaa_d[164].ooaa002) THEN
               LET ls_tmp = g_ooaa_d[164].ooaa002
               IF ls_tmp.getIndexOf(".",1) THEN                  
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.extend = g_ooaa_d[164].ooaa002
                   LET g_errparam.code   = "azz-00138"
                   LET g_errparam.popup  = TRUE
                   CALL cl_err()
                   NEXT FIELD apj_base_1
               END IF   
            END IF


         

         BEFORE FIELD agc_base_1
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0059")
 
         AFTER FIELD agc_base_1
         

         BEFORE FIELD apc_touch_1
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0070")
 
         AFTER FIELD apc_touch_1
         

         BEFORE FIELD apc_touch_2
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0068")
 
         AFTER FIELD apc_touch_2
         #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooaa_d[167].ooaa002,"1","1","10","1","azz-00087",1) THEN
               NEXT FIELD apc_touch_2
            END IF 



         #此段落由子樣板ss01產生
            IF NOT cl_null(g_ooaa_d[167].ooaa002) THEN
               LET ls_tmp = g_ooaa_d[167].ooaa002
               IF ls_tmp.getIndexOf(".",1) THEN                  
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.extend = g_ooaa_d[167].ooaa002
                   LET g_errparam.code   = "azz-00138"
                   LET g_errparam.popup  = TRUE
                   CALL cl_err()
                   NEXT FIELD apc_touch_2
               END IF   
            END IF


         

         BEFORE FIELD apc_touch_3
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0069")
 
         AFTER FIELD apc_touch_3
         #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooaa_d[168].ooaa002,"1","1","99","1","azz-00087",1) THEN
               NEXT FIELD apc_touch_3
            END IF 



         #此段落由子樣板ss01產生
            IF NOT cl_null(g_ooaa_d[168].ooaa002) THEN
               LET ls_tmp = g_ooaa_d[168].ooaa002
               IF ls_tmp.getIndexOf(".",1) THEN                  
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.extend = g_ooaa_d[168].ooaa002
                   LET g_errparam.code   = "azz-00138"
                   LET g_errparam.popup  = TRUE
                   CALL cl_err()
                   NEXT FIELD apc_touch_3
               END IF   
            END IF


         

         BEFORE FIELD apc_touch_4
            CALL aoos010_show_field_help("ooaa_t","E-CIR-0077")
 
         AFTER FIELD apc_touch_4

      
          
      ON ACTION controlp INFIELD basic_base_10
            #此段落由子樣板ss04產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooaa_d[8].ooaa002             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #${mdl_arg_desc1}

            CALL q_ooef001_1()                                #呼叫開窗

            LET g_ooaa_d[8].ooaa002 = g_qryparam.return1              

            DISPLAY g_ooaa_d[8].ooaa002 TO basic_base_10              #${mdl_desc$}

            NEXT FIELD basic_base_10                          #返回原欄位


      ON ACTION controlp INFIELD uisetting_layout_1
            #此段落由子樣板ss04產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooaa_d[73].ooaa002             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #${mdl_arg_desc1}

            CALL q_gzsa002()                                #呼叫開窗

            LET g_ooaa_d[73].ooaa002 = g_qryparam.return1              

            DISPLAY g_ooaa_d[73].ooaa002 TO uisetting_layout_1              #${mdl_desc$}

            NEXT FIELD uisetting_layout_1                          #返回原欄位


      ON ACTION controlp INFIELD ain_base_38
            #此段落由子樣板ss04產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooaa_d[84].ooaa002             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #${mdl_arg_desc1}

            CALL q_oocq002_216()                                #呼叫開窗

            LET g_ooaa_d[84].ooaa002 = g_qryparam.return1              

            DISPLAY g_ooaa_d[84].ooaa002 TO ain_base_38              #${mdl_desc$}

            NEXT FIELD ain_base_38                          #返回原欄位


      ON ACTION controlp INFIELD amm_base_7
            #此段落由子樣板ss04產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooaa_d[89].ooaa002             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #${mdl_arg_desc1}

            CALL q_oocq002_216()                                #呼叫開窗

            LET g_ooaa_d[89].ooaa002 = g_qryparam.return1              

            DISPLAY g_ooaa_d[89].ooaa002 TO amm_base_7              #${mdl_desc$}

            NEXT FIELD amm_base_7                          #返回原欄位


      ON ACTION controlp INFIELD amm_base_8
            #此段落由子樣板ss04產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooaa_d[90].ooaa002             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #${mdl_arg_desc1}

            CALL q_mmcu001()                                #呼叫開窗

            LET g_ooaa_d[90].ooaa002 = g_qryparam.return1              

            DISPLAY g_ooaa_d[90].ooaa002 TO amm_base_8              #${mdl_desc$}

            NEXT FIELD amm_base_8                          #返回原欄位


      ON ACTION controlp INFIELD art_basic_7
            #此段落由子樣板ss04產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooaa_d[108].ooaa002             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #${mdl_arg_desc1}

            CALL q_imaa001_1()                                #呼叫開窗

            LET g_ooaa_d[108].ooaa002 = g_qryparam.return1              

            DISPLAY g_ooaa_d[108].ooaa002 TO art_basic_7              #${mdl_desc$}

            NEXT FIELD art_basic_7                          #返回原欄位


      ON ACTION controlp INFIELD art_basic_8
            #此段落由子樣板ss04產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooaa_d[109].ooaa002             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #${mdl_arg_desc1}

            CALL q_imaa001_1()                                #呼叫開窗

            LET g_ooaa_d[109].ooaa002 = g_qryparam.return1              

            DISPLAY g_ooaa_d[109].ooaa002 TO art_basic_8              #${mdl_desc$}

            NEXT FIELD art_basic_8                          #返回原欄位


      ON ACTION controlp INFIELD art_basic_11
            #此段落由子樣板ss04產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooaa_d[112].ooaa002             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #${mdl_arg_desc1}

            CALL q_rtda001_1()                                #呼叫開窗

            LET g_ooaa_d[112].ooaa002 = g_qryparam.return1              

            DISPLAY g_ooaa_d[112].ooaa002 TO art_basic_11              #${mdl_desc$}

            NEXT FIELD art_basic_11                          #返回原欄位


      ON ACTION controlp INFIELD art_basic_12
            #此段落由子樣板ss04產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooaa_d[113].ooaa002             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #${mdl_arg_desc1}

            CALL q_imaa001()                                #呼叫開窗

            LET g_ooaa_d[113].ooaa002 = g_qryparam.return1              

            DISPLAY g_ooaa_d[113].ooaa002 TO art_basic_12              #${mdl_desc$}

            NEXT FIELD art_basic_12                          #返回原欄位


      ON ACTION controlp INFIELD ast_base_2
            #此段落由子樣板ss04產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooaa_d[120].ooaa002             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #${mdl_arg_desc1}

            CALL q_stae001()                                #呼叫開窗

            LET g_ooaa_d[120].ooaa002 = g_qryparam.return1              

            DISPLAY g_ooaa_d[120].ooaa002 TO ast_base_2              #${mdl_desc$}

            NEXT FIELD ast_base_2                          #返回原欄位


      END INPUT
 
      
      ON ACTION basic
         CALL aoos010_parameter_switch("basic")
         NEXT FIELD basic_base_1
      ON ACTION aws
         CALL aoos010_parameter_switch("aws")
         NEXT FIELD aws_bpm_1
      ON ACTION uisetting
         CALL aoos010_parameter_switch("uisetting")
         NEXT FIELD uisetting_homepage_1
      ON ACTION ain
         CALL aoos010_parameter_switch("ain")
         NEXT FIELD ain_base_32
      ON ACTION amm
         CALL aoos010_parameter_switch("amm")
         NEXT FIELD amm_base_3
      ON ACTION aec
         CALL aoos010_parameter_switch("aec")
         NEXT FIELD aec_base_32
      ON ACTION aim
         CALL aoos010_parameter_switch("aim")
         NEXT FIELD aim_base_24
      ON ACTION abm
         CALL aoos010_parameter_switch("abm")
         NEXT FIELD abm_base_23
      ON ACTION art
         CALL aoos010_parameter_switch("art")
         NEXT FIELD art_basic_1
      ON ACTION acr
         CALL aoos010_parameter_switch("acr")
         NEXT FIELD acr_base_1
      ON ACTION ast
         CALL aoos010_parameter_switch("ast")
         NEXT FIELD ast_base_1
      ON ACTION fin
         CALL aoos010_parameter_switch("fin")
         NEXT FIELD fin_anm_1
      ON ACTION cir
         CALL aoos010_parameter_switch("cir")
         NEXT FIELD cir_application_1
      ON ACTION ais
         CALL aoos010_parameter_switch("ais")
         NEXT FIELD ais_base_1
      ON ACTION scm
         CALL aoos010_parameter_switch("scm")
         NEXT FIELD scm_base_1
      ON ACTION stock
         CALL aoos010_parameter_switch("stock")
         NEXT FIELD stock_base_1
      ON ACTION apm
         CALL aoos010_parameter_switch("apm")
         NEXT FIELD apm_base_1
      ON ACTION apj
         CALL aoos010_parameter_switch("apj")
         NEXT FIELD apj_base_1
      ON ACTION agc
         CALL aoos010_parameter_switch("agc")
         NEXT FIELD agc_base_1
      ON ACTION apc
         CALL aoos010_parameter_switch("apc")
         NEXT FIELD apc_touch_1
 
      
      ON ACTION btn_paramsubgp1_1
         CALL aoos010_parameter_group_switch("paramsubgp1_1")
      ON ACTION btn_paramsubgp1_2
         CALL aoos010_parameter_group_switch("paramsubgp1_2")
      ON ACTION btn_paramsubgp1_3
         CALL aoos010_parameter_group_switch("paramsubgp1_3")
      ON ACTION btn_paramsubgp1_4
         CALL aoos010_parameter_group_switch("paramsubgp1_4")
      ON ACTION btn_paramsubgp1_5
         CALL aoos010_parameter_group_switch("paramsubgp1_5")
      ON ACTION btn_paramsubgp1_6
         CALL aoos010_parameter_group_switch("paramsubgp1_6")
      ON ACTION btn_paramsubgp2_1
         CALL aoos010_parameter_group_switch("paramsubgp2_1")
      ON ACTION btn_paramsubgp2_2
         CALL aoos010_parameter_group_switch("paramsubgp2_2")
      ON ACTION btn_paramsubgp2_3
         CALL aoos010_parameter_group_switch("paramsubgp2_3")
      ON ACTION btn_paramsubgp2_4
         CALL aoos010_parameter_group_switch("paramsubgp2_4")
      ON ACTION btn_paramsubgp2_5
         CALL aoos010_parameter_group_switch("paramsubgp2_5")
      ON ACTION btn_paramsubgp2_6
         CALL aoos010_parameter_group_switch("paramsubgp2_6")
      ON ACTION btn_paramsubgp3_1
         CALL aoos010_parameter_group_switch("paramsubgp3_1")
      ON ACTION btn_paramsubgp3_2
         CALL aoos010_parameter_group_switch("paramsubgp3_2")
      ON ACTION btn_paramsubgp4_1
         CALL aoos010_parameter_group_switch("paramsubgp4_1")
      ON ACTION btn_paramsubgp5_1
         CALL aoos010_parameter_group_switch("paramsubgp5_1")
      ON ACTION btn_paramsubgp6_1
         CALL aoos010_parameter_group_switch("paramsubgp6_1")
      ON ACTION btn_paramsubgp7_1
         CALL aoos010_parameter_group_switch("paramsubgp7_1")
      ON ACTION btn_paramsubgp8_1
         CALL aoos010_parameter_group_switch("paramsubgp8_1")
      ON ACTION btn_paramsubgp9_1
         CALL aoos010_parameter_group_switch("paramsubgp9_1")
      ON ACTION btn_paramsubgp10_1
         CALL aoos010_parameter_group_switch("paramsubgp10_1")
      ON ACTION btn_paramsubgp10_2
         CALL aoos010_parameter_group_switch("paramsubgp10_2")
      ON ACTION btn_paramsubgp11_1
         CALL aoos010_parameter_group_switch("paramsubgp11_1")
      ON ACTION btn_paramsubgp11_2
         CALL aoos010_parameter_group_switch("paramsubgp11_2")
      ON ACTION btn_paramsubgp12_1
         CALL aoos010_parameter_group_switch("paramsubgp12_1")
      ON ACTION btn_paramsubgp12_2
         CALL aoos010_parameter_group_switch("paramsubgp12_2")
      ON ACTION btn_paramsubgp13_1
         CALL aoos010_parameter_group_switch("paramsubgp13_1")
      ON ACTION btn_paramsubgp13_2
         CALL aoos010_parameter_group_switch("paramsubgp13_2")
      ON ACTION btn_paramsubgp13_3
         CALL aoos010_parameter_group_switch("paramsubgp13_3")
      ON ACTION btn_paramsubgp13_4
         CALL aoos010_parameter_group_switch("paramsubgp13_4")
      ON ACTION btn_paramsubgp14_1
         CALL aoos010_parameter_group_switch("paramsubgp14_1")
      ON ACTION btn_paramsubgp15_1
         CALL aoos010_parameter_group_switch("paramsubgp15_1")
      ON ACTION btn_paramsubgp16_1
         CALL aoos010_parameter_group_switch("paramsubgp16_1")
      ON ACTION btn_paramsubgp17_1
         CALL aoos010_parameter_group_switch("paramsubgp17_1")
      ON ACTION btn_paramsubgp18_1
         CALL aoos010_parameter_group_switch("paramsubgp18_1")
      ON ACTION btn_paramsubgp19_1
         CALL aoos010_parameter_group_switch("paramsubgp19_1")
      ON ACTION btn_paramsubgp20_1
         CALL aoos010_parameter_group_switch("paramsubgp20_1")
 
      # 以下為每一個欄位的說明功能鍵
      
      ON ACTION help_basic_base_1
         CALL aoos010_show_field_help("ooaa_t","E-COM-0008")
      ON ACTION help_basic_base_4
         CALL aoos010_show_field_help("ooaa_t","E-COM-0001")
      ON ACTION help_basic_base_5
         CALL aoos010_show_field_help("ooaa_t","E-COM-0002")
      ON ACTION help_basic_base_6
         CALL aoos010_show_field_help("ooaa_t","E-COM-0003")
      ON ACTION help_basic_base_7
         CALL aoos010_show_field_help("ooaa_t","E-COM-0004")
      ON ACTION help_basic_base_8
         CALL aoos010_show_field_help("ooaa_t","E-COM-0005")
      ON ACTION help_basic_base_9
         CALL aoos010_show_field_help("ooaa_t","E-COM-0006")
      ON ACTION help_basic_base_10
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0727")
      ON ACTION help_basic_base_11
         CALL aoos010_show_field_help("gzsb_t","E-SYS-2010")
      ON ACTION help_basic_process_1
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0005")
      ON ACTION help_basic_related_doc_1
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0006")
      ON ACTION help_basic_related_doc_2
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0007")
      ON ACTION help_basic_related_doc_3
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0008")
      ON ACTION help_basic_base2_1
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0001")
      ON ACTION help_basic_base2_2
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0710")
      ON ACTION help_basic_base2_3
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0002")
      ON ACTION help_basic_base2_4
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0003")
      ON ACTION help_basic_base2_5
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0004")
      ON ACTION help_basic_base2_6
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0009")
      ON ACTION help_basic_base2_7
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0010")
      ON ACTION help_basic_base2_8
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0035")
      ON ACTION help_basic_base2_9
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0011")
      ON ACTION help_basic_base2_10
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0036")
      ON ACTION help_basic_base2_11
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0712")
      ON ACTION help_basic_log_1
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0012")
      ON ACTION help_basic_log_2
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0013")
      ON ACTION help_basic_log_3
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0014")
      ON ACTION help_basic_log_4
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0015")
      ON ACTION help_basic_log_5
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0016")
      ON ACTION help_basic_log_6
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0017")
      ON ACTION help_basic_log_7
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0034")
      ON ACTION help_basic_log_8
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0018")
      ON ACTION help_basic_log_9
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0019")
      ON ACTION help_basic_log_10
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0020")
      ON ACTION help_basic_log_11
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0021")
      ON ACTION help_basic_log_12
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0022")
      ON ACTION help_basic_log_13
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0023")
      ON ACTION help_basic_log_14
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0024")
      ON ACTION help_basic_log_15
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0025")
      ON ACTION help_basic_log_16
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0026")
      ON ACTION help_basic_log_17
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0027")
      ON ACTION help_basic_password_1
         CALL aoos010_show_field_help("gzsb_t","E-SYS-2006")
      ON ACTION help_basic_password_2
         CALL aoos010_show_field_help("gzsb_t","E-SYS-2003")
      ON ACTION help_basic_password_3
         CALL aoos010_show_field_help("gzsb_t","E-SYS-2004")
      ON ACTION help_basic_password_4
         CALL aoos010_show_field_help("gzsb_t","E-SYS-2005")
      ON ACTION help_basic_password_5
         CALL aoos010_show_field_help("gzsb_t","E-SYS-2002")
      ON ACTION help_basic_password_6
         CALL aoos010_show_field_help("gzsb_t","E-SYS-2009")
      ON ACTION help_aws_bpm_1
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0700")
      ON ACTION help_aws_bpm_2
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0701")
      ON ACTION help_aws_bpm_3
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0702")
      ON ACTION help_aws_bpm_4
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0703")
      ON ACTION help_aws_EAI_1
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0705")
      ON ACTION help_aws_EAI_2
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0704")
      ON ACTION help_aws_EAI_3
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0715")
      ON ACTION help_aws_EAI_4
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0716")
      ON ACTION help_aws_EAI_6
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0707")
      ON ACTION help_aws_EAI_7
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0717")
      ON ACTION help_aws_MCloud_1
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0708")
      ON ACTION help_aws_MCloud_2
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0709")
      ON ACTION help_aws_PLM_1
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0718")
      ON ACTION help_aws_PLM_2
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0719")
      ON ACTION help_aws_EC_B2B_1
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0720")
      ON ACTION help_aws_EC_B2B_2
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0721")
      ON ACTION help_aws_EC_B2B_3
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0722")
      ON ACTION help_aws_POSB2B_1
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0724")
      ON ACTION help_aws_POSB2B_2
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0725")
      ON ACTION help_aws_POSB2B_3
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0726")
      ON ACTION help_uisetting_homepage_1
         CALL aoos010_show_field_help("gzsb_t","E-SYS-2001")
      ON ACTION help_uisetting_homepage_2
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0033")
      ON ACTION help_uisetting_homepage_3
         CALL aoos010_show_field_help("gzsb_t","E-SYS-2007")
      ON ACTION help_uisetting_homepage_4
         CALL aoos010_show_field_help("gzsb_t","E-SYS-2008")
      ON ACTION help_uisetting_homepage_5
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0723")
      ON ACTION help_uisetting_layout_1
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0711")
      ON ACTION help_uisetting_layout_2
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0028")
      ON ACTION help_uisetting_layout_3
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0031")
      ON ACTION help_uisetting_layout_4
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0029")
      ON ACTION help_uisetting_layout_5
         CALL aoos010_show_field_help("ooaa_t","E-SYS-0030")
      ON ACTION help_ain_base_32
         CALL aoos010_show_field_help("ooaa_t","E-BAS-0013")
      ON ACTION help_ain_base_33
         CALL aoos010_show_field_help("ooaa_t","E-BAS-0014")
      ON ACTION help_ain_base_34
         CALL aoos010_show_field_help("ooaa_t","E-BAS-0015")
      ON ACTION help_ain_base_35
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0029")
      ON ACTION help_ain_base_36
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0047")
      ON ACTION help_ain_base_37
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0048")
      ON ACTION help_ain_base_38
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0050")
      ON ACTION help_ain_base_39
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0053")
      ON ACTION help_ain_base_40
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0055")
      ON ACTION help_amm_base_3
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0003")
      ON ACTION help_amm_base_6
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0004")
      ON ACTION help_amm_base_7
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0051")
      ON ACTION help_amm_base_8
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0063")
      ON ACTION help_amm_base_9
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0073")
      ON ACTION help_amm_base_10
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0075")
      ON ACTION help_aec_base_32
         CALL aoos010_show_field_help("ooaa_t","E-MFG-0001")
      ON ACTION help_aec_base_33
         CALL aoos010_show_field_help("ooaa_t","E-MFG-0002")
      ON ACTION help_aim_base_24
         CALL aoos010_show_field_help("ooaa_t","E-BAS-0003")
      ON ACTION help_aim_base_25
         CALL aoos010_show_field_help("ooaa_t","E-BAS-0004")
      ON ACTION help_aim_base_27
         CALL aoos010_show_field_help("ooaa_t","E-BAS-0006")
      ON ACTION help_aim_base_28
         CALL aoos010_show_field_help("ooaa_t","E-BAS-0007")
      ON ACTION help_aim_base_35
         CALL aoos010_show_field_help("ooaa_t","E-BAS-0012")
      ON ACTION help_aim_base_36
         CALL aoos010_show_field_help("ooaa_t","E-BAS-0017")
      ON ACTION help_aim_base_37
         CALL aoos010_show_field_help("ooaa_t","E-BAS-0027")
      ON ACTION help_abm_base_23
         CALL aoos010_show_field_help("ooaa_t","E-BAS-0002")
      ON ACTION help_abm_base_29
         CALL aoos010_show_field_help("ooaa_t","E-BAS-0008")
      ON ACTION help_art_basic_1
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0001")
      ON ACTION help_art_basic_2
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0062")
      ON ACTION help_art_basic_3
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0028")
      ON ACTION help_art_basic_6
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0010")
      ON ACTION help_art_basic_7
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0032")
      ON ACTION help_art_basic_8
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0043")
      ON ACTION help_art_basic_9
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0046")
      ON ACTION help_art_basic_10
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0052")
      ON ACTION help_art_basic_11
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0056")
      ON ACTION help_art_basic_12
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0074")
      ON ACTION help_acr_base_1
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0005")
      ON ACTION help_acr_base_2
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0006")
      ON ACTION help_acr_base_3
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0007")
      ON ACTION help_acr_abc_1
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0008")
      ON ACTION help_acr_abc_2
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0009")
      ON ACTION help_ast_base_1
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0011")
      ON ACTION help_ast_base_2
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0045")
      ON ACTION help_ast_base_3
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0049")
      ON ACTION help_ast_base_4
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0054")
      ON ACTION help_ast_base_5
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0057")
      ON ACTION help_ast_base_6
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0058")
      ON ACTION help_ast_base_7
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0060")
      ON ACTION help_ast_giveback_1
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0064")
      ON ACTION help_fin_anm_1
         CALL aoos010_show_field_help("ooaa_t","E-FIN-0001")
      ON ACTION help_fin_axr_1
         CALL aoos010_show_field_help("ooaa_t","E-FIN-0002")
      ON ACTION help_fin_axr_2
         CALL aoos010_show_field_help("ooaa_t","E-FIN-0003")
      ON ACTION help_cir_application_1
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0035")
      ON ACTION help_cir_application_2
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0036")
      ON ACTION help_cir_application_3
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0018")
      ON ACTION help_cir_application_4
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0023")
      ON ACTION help_cir_application_5
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0025")
      ON ACTION help_cir_application_6
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0044")
      ON ACTION help_cir_application_7
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0022")
      ON ACTION help_cir_application_8
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0016")
      ON ACTION help_cir_application_9
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0024")
      ON ACTION help_cir_application_10
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0017")
      ON ACTION help_cir_application_11
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0038")
      ON ACTION help_cir_application_12
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0037")
      ON ACTION help_cir_application_13
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0019")
      ON ACTION help_cir_application_14
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0033")
      ON ACTION help_cir_application_15
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0027")
      ON ACTION help_cir_application_16
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0034")
      ON ACTION help_cir_application_19
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0002")
      ON ACTION help_cir_application_20
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0076")
      ON ACTION help_cir_cashreturn_1
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0030")
      ON ACTION help_cir_cashreturn_2
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0031")
      ON ACTION help_cir_cashreturn_3
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0042")
      ON ACTION help_cir_cashreturn_4
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0072")
      ON ACTION help_cir_settle_account_1
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0061")
      ON ACTION help_cir_settle_account_2
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0067")
      ON ACTION help_cir_settle_account_3
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0071")
      ON ACTION help_cir_settle_account_4
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0078")
      ON ACTION help_cir_settle_account_5
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0079")
      ON ACTION help_cir_trans_1
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0065")
      ON ACTION help_ais_base_1
         CALL aoos010_show_field_help("ooaa_t","E-BAS-0018")
      ON ACTION help_ais_base_2
         CALL aoos010_show_field_help("ooaa_t","E-BAS-0022")
      ON ACTION help_scm_base_1
         CALL aoos010_show_field_help("ooaa_t","E-BAS-0019")
      ON ACTION help_stock_base_1
         CALL aoos010_show_field_help("ooaa_t","E-BAS-0020")
      ON ACTION help_apm_base_1
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0026")
      ON ACTION help_apm_base_2
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0041")
      ON ACTION help_apj_base_1
         CALL aoos010_show_field_help("ooaa_t","E-COM-0007")
      ON ACTION help_agc_base_1
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0059")
      ON ACTION help_apc_touch_1
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0070")
      ON ACTION help_apc_touch_2
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0068")
      ON ACTION help_apc_touch_3
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0069")
      ON ACTION help_apc_touch_4
         CALL aoos010_show_field_help("ooaa_t","E-CIR-0077")
 
       
      ON ACTION set_func 
         CALL s_azzi000_set_func("default")
      
      ON ACTION accept
         
         LET li_exit = FALSE
         ACCEPT DIALOG
 
      ON ACTION cancel
         # 返回舊值, 並顯示
         LET li_exit = TRUE
         CALL aoos010_fill_data()   # 整體參數
         CALL aoos010_show()
         EXIT DIALOG
   END DIALOG
 
   IF NOT li_exit THEN
      # 做存檔動作
      CALL aoos010_update()
      
   END IF
 
END FUNCTION 
 
#+ 更新參數資料
PRIVATE FUNCTION aoos010_update()
 
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE ls_sql  STRING
   DEFINE ls_tab  STRING
 
   FOR li_cnt = 1 TO g_ooaa_d.getLength()
      #若新值與舊值不同,進行更新 #更新參數資料 
      IF (g_ooaa_d[li_cnt].ooaa002 IS NULL AND g_ooaa_d_t[li_cnt].ooaa002 IS NOT NULL) OR
         (g_ooaa_d[li_cnt].ooaa002 IS NOT NULL AND g_ooaa_d_t[li_cnt].ooaa002 IS NULL) OR
         (g_ooaa_d[li_cnt].ooaa002 IS NOT NULL AND g_ooaa_d_t[li_cnt].ooaa002 IS NOT NULL AND
          g_ooaa_d[li_cnt].ooaa002 <> g_ooaa_d_t[li_cnt].ooaa002 ) THEN
 
         LET ls_tab = g_gzsv[li_cnt].gzsv005 CLIPPED
         LET ls_tab = ls_tab.subString(1,ls_tab.getIndexOf("_t",1)-1)
         LET g_ooaa_d[li_cnt].ooaamoddt = cl_get_current()
 
         LET ls_sql = " UPDATE ",ls_tab,"_t ",
                         " SET ",ls_tab,"002 = ?, ",
                                 ls_tab,"modid = ?, ",
                                 ls_tab,"moddt = ? ",
                       " WHERE ",ls_tab,"001 = ? "
                        ," AND ",ls_tab,"ent = ",g_enterprise  
         PREPARE aoos010_update_cs FROM ls_sql
         EXECUTE aoos010_update_cs USING g_ooaa_d[li_cnt].ooaa002,g_user,
                                         g_ooaa_d[li_cnt].ooaamoddt,
                                         g_ooaa_d[li_cnt].ooaa001
         FREE aoos010_update_cs
 
         CALL cl_log_parameter_update(g_ooaa_d[li_cnt].ooaa001,g_site,g_ooaa_d_t[li_cnt].ooaa002,g_ooaa_d[li_cnt].ooaa002)
      END IF
   END FOR
 
END FUNCTION
 
#+ 抓取右側說明方塊
PRIVATE FUNCTION aoos010_show_field_help(ps_tabid,ps_field)
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
PRIVATE FUNCTION aoos010_show_page_title(ps_paramid)
   DEFINE ps_paramid   STRING 
   DEFINE pc_gzswl004  LIKE gzswl_t.gzswl004
   DEFINE ls_sql       STRING 
 
   LET ls_sql = "SELECT gzswl004 FROM gzswl_t", 
                " WHERE gzswl001 = '", g_code ,"'" ,
                  " AND gzswl002 = '",ps_paramid,"'",
                  " AND gzswl003 = '",g_lang ,"'"
 
   PREPARE  aoos010_show_page_title_pre FROM ls_sql  
   EXECUTE aoos010_show_page_title_pre  INTO pc_gzswl004 
   FREE aoos010_show_page_title_pre
 
   RETURN pc_gzswl004 
END FUNCTION 
