#該程式未解開Section, 採用最新樣板產出!
{<section id="artm301.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0013(2016-08-04 09:10:16), PR版次:0013(2016-08-24 11:06:57)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000169
#+ Filename...: artm301
#+ Description: 商品條碼維護作業
#+ Creator....: 02749(2014-06-18 10:19:47)
#+ Modifier...: 06814 -SD/PR- 06814
 
{</section>}
 
{<section id="artm301.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160318-00025#40  2016/04/22  By pengxin  將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160801-00017#1   2016/08/03  By beckxie  1.单身增加产品特征字段，
#                                         管控当前料件的条码分类(imay002)为3.款色，且料件特征组不为空时，此字段必填。
#                                         特征组为空時，产品特征不可输
#                                         可手动录入或开窗选填，参照apmt500采购单身修改状态时的产品特征字段
#160803-00008#1   2016/08/11  By 06814    1.條碼分類為3.款色，且料件特徵組不為空時，
#                                            新增資料時可開窗二維勾選多個特徵(參照apmt500採購單身產品特徵字段，
#                                            但需將二維開窗中的數量字段變為勾選字段),
#                                            根據勾選的特徵自動生成多筆條碼資料(商品條碼=料號+產品特徵值(無下劃線))。
#                                         2.當條碼分類為3.款色時,不走條碼校驗
#160822-00036#4   2016/08/24  By 06814    1.產品特徵開窗完畢後,馬上顯示出所有產出筆數
#                                         2.aoos020 若不使用產品特徵,將產品特徵隱藏
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"

#end add-point 
 
SCHEMA ds 
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_imaa_m        RECORD
       imaa001 LIKE imaa_t.imaa001, 
   imaa002 LIKE imaa_t.imaa002, 
   imaal003 LIKE type_t.chr500, 
   imaal004 LIKE type_t.chr500, 
   imaa108 LIKE imaa_t.imaa108, 
   imaa100 LIKE imaa_t.imaa100, 
   imaa109 LIKE imaa_t.imaa109, 
   imaa014 LIKE imaa_t.imaa014, 
   imaa005 LIKE imaa_t.imaa005, 
   imaa005_desc LIKE type_t.chr80, 
   imaa006 LIKE imaa_t.imaa006, 
   imaa006_desc LIKE type_t.chr80, 
   imaa105 LIKE imaa_t.imaa105, 
   imaa105_desc LIKE type_t.chr80, 
   imaa104 LIKE imaa_t.imaa104, 
   imaa104_desc LIKE type_t.chr80, 
   imaa107 LIKE imaa_t.imaa107, 
   imaa107_desc LIKE type_t.chr80, 
   imaa106 LIKE imaa_t.imaa106, 
   imaa106_desc LIKE type_t.chr80, 
   imaa145 LIKE imaa_t.imaa145, 
   imaa145_desc LIKE type_t.chr80, 
   imaa146 LIKE imaa_t.imaa146, 
   imaa146_desc LIKE type_t.chr80, 
   imaa113 LIKE imaa_t.imaa113, 
   imaastus LIKE imaa_t.imaastus
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_imay_d        RECORD
       imaystus LIKE imay_t.imaystus, 
   imay002 LIKE imay_t.imay002, 
   imay019 LIKE imay_t.imay019, 
   imay019_desc LIKE type_t.chr500, 
   imay003 LIKE imay_t.imay003, 
   imay004 LIKE imay_t.imay004, 
   imay004_desc LIKE type_t.chr500, 
   imay005 LIKE imay_t.imay005, 
   imay006 LIKE imay_t.imay006, 
   imay018 LIKE imay_t.imay018, 
   imay007 LIKE imay_t.imay007, 
   imay008 LIKE imay_t.imay008, 
   imay009 LIKE imay_t.imay009, 
   imay015 LIKE imay_t.imay015, 
   imay015_desc LIKE type_t.chr500, 
   imay010 LIKE imay_t.imay010, 
   imay016 LIKE imay_t.imay016, 
   imay016_desc LIKE type_t.chr500, 
   imay011 LIKE imay_t.imay011, 
   imay017 LIKE imay_t.imay017, 
   imay017_desc LIKE type_t.chr500, 
   imay012 LIKE imay_t.imay012, 
   imay013 LIKE imay_t.imay013, 
   imay014 LIKE imay_t.imay014
       END RECORD
PRIVATE TYPE type_g_imay2_d RECORD
       imay003 LIKE imay_t.imay003, 
   imayownid LIKE imay_t.imayownid, 
   imayownid_desc LIKE type_t.chr500, 
   imayowndp LIKE imay_t.imayowndp, 
   imayowndp_desc LIKE type_t.chr500, 
   imaycrtid LIKE imay_t.imaycrtid, 
   imaycrtid_desc LIKE type_t.chr500, 
   imaycrtdp LIKE imay_t.imaycrtdp, 
   imaycrtdp_desc LIKE type_t.chr500, 
   imaycrtdt DATETIME YEAR TO SECOND, 
   imaymodid LIKE imay_t.imaymodid, 
   imaymodid_desc LIKE type_t.chr500, 
   imaymoddt DATETIME YEAR TO SECOND
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_imaa001 LIKE imaa_t.imaa001
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
       
#模組變數(Module Variables)
DEFINE g_imaa_m          type_g_imaa_m
DEFINE g_imaa_m_t        type_g_imaa_m
DEFINE g_imaa_m_o        type_g_imaa_m
DEFINE g_imaa_m_mask_o   type_g_imaa_m #轉換遮罩前資料
DEFINE g_imaa_m_mask_n   type_g_imaa_m #轉換遮罩後資料
 
   DEFINE g_imaa001_t LIKE imaa_t.imaa001
 
 
DEFINE g_imay_d          DYNAMIC ARRAY OF type_g_imay_d
DEFINE g_imay_d_t        type_g_imay_d
DEFINE g_imay_d_o        type_g_imay_d
DEFINE g_imay_d_mask_o   DYNAMIC ARRAY OF type_g_imay_d #轉換遮罩前資料
DEFINE g_imay_d_mask_n   DYNAMIC ARRAY OF type_g_imay_d #轉換遮罩後資料
DEFINE g_imay2_d          DYNAMIC ARRAY OF type_g_imay2_d
DEFINE g_imay2_d_t        type_g_imay2_d
DEFINE g_imay2_d_o        type_g_imay2_d
DEFINE g_imay2_d_mask_o   DYNAMIC ARRAY OF type_g_imay2_d #轉換遮罩前資料
DEFINE g_imay2_d_mask_n   DYNAMIC ARRAY OF type_g_imay2_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
 
 
DEFINE g_wc2_extend          STRING
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
 
DEFINE g_sql                 STRING
DEFINE g_forupd_sql          STRING
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_current_idx         LIKE type_t.num10     
DEFINE g_jump                LIKE type_t.num10        
DEFINE g_no_ask              LIKE type_t.num5        
DEFINE g_rec_b               LIKE type_t.num10           
DEFINE l_ac                  LIKE type_t.num10    
DEFINE g_curr_diag           ui.Dialog                         #Current Dialog
                                                               
DEFINE g_pagestart           LIKE type_t.num10                 
DEFINE gwin_curr             ui.Window                         #Current Window
DEFINE gfrm_curr             ui.Form                           #Current Form
DEFINE g_page_action         STRING                            #page action
DEFINE g_header_hidden       LIKE type_t.num5                  #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5                  #隱藏工作Panel
DEFINE g_page                STRING                            #第幾頁
DEFINE g_state               STRING       
DEFINE g_header_cnt          LIKE type_t.num10
DEFINE g_detail_cnt          LIKE type_t.num10                  #單身總筆數
DEFINE g_detail_idx          LIKE type_t.num10                  #單身目前所在筆數
DEFINE g_detail_idx_tmp      LIKE type_t.num10                  #單身目前所在筆數
DEFINE g_detail_idx2         LIKE type_t.num10                  #單身2目前所在筆數
DEFINE g_detail_idx_list     DYNAMIC ARRAY OF LIKE type_t.num10 #單身2目前所在筆數
DEFINE g_browser_cnt         LIKE type_t.num10                  #Browser總筆數
DEFINE g_browser_idx         LIKE type_t.num10                  #Browser目前所在筆數
DEFINE g_temp_idx            LIKE type_t.num10                  #Browser目前所在筆數(暫存用)
DEFINE g_order               STRING                             #查詢排序欄位
                                                        
DEFINE g_current_row         LIKE type_t.num10                  #Browser所在筆數
DEFINE g_current_sw          BOOLEAN                            #Browser所在筆數用開關
DEFINE g_current_page        LIKE type_t.num10                  #目前所在頁數
DEFINE g_insert              LIKE type_t.chr5                   #是否導到其他page
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys               DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak           DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_bfill               LIKE type_t.chr5              #是否刷新單身
DEFINE g_error_show          LIKE type_t.num5              #是否顯示筆數提示訊息
DEFINE g_master_insert       BOOLEAN                       #確認單頭資料是否寫入
 
DEFINE g_wc_frozen           STRING                        #凍結欄位使用
DEFINE g_chk                 BOOLEAN                       #助記碼判斷用
DEFINE g_aw                  STRING                        #確定當下點擊的單身
DEFINE g_default             BOOLEAN                       #是否有外部參數查詢
DEFINE g_log1                STRING                        #log用
DEFINE g_log2                STRING                        #log用
DEFINE g_loc                 LIKE type_t.chr5              #判斷游標所在位置
DEFINE g_add_browse          STRING                        #新增填充用WC
DEFINE g_update              BOOLEAN                       #確定單頭/身是否異動過
DEFINE g_idx_group           om.SaxAttributes              #頁籤群組
DEFINE g_master_commit       LIKE type_t.chr1              #確認單頭是否修改過
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="artm301.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("art","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT imaa001,imaa002,'','',imaa108,imaa100,imaa109,imaa014,imaa005,'',imaa006, 
       '',imaa105,'',imaa104,'',imaa107,'',imaa106,'',imaa145,'',imaa146,'',imaa113,imaastus", 
                      " FROM imaa_t",
                      " WHERE imaaent= ? AND imaa001=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE artm301_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.imaa001,t0.imaa002,t0.imaa108,t0.imaa100,t0.imaa109,t0.imaa014,t0.imaa005, 
       t0.imaa006,t0.imaa105,t0.imaa104,t0.imaa107,t0.imaa106,t0.imaa145,t0.imaa146,t0.imaa113,t0.imaastus, 
       t1.oocql004 ,t2.oocal003 ,t3.oocal003 ,t4.oocal003 ,t5.oocal003 ,t6.oocal003 ,t7.oocal003 ,t8.oocal003", 
 
               " FROM imaa_t t0",
                              " LEFT JOIN oocql_t t1 ON t1.oocqlent="||g_enterprise||" AND t1.oocql001='211' AND t1.oocql002=t0.imaa005 AND t1.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t2 ON t2.oocalent="||g_enterprise||" AND t2.oocal001=t0.imaa006 AND t2.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t3 ON t3.oocalent="||g_enterprise||" AND t3.oocal001=t0.imaa105 AND t3.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t4 ON t4.oocalent="||g_enterprise||" AND t4.oocal001=t0.imaa104 AND t4.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t5 ON t5.oocalent="||g_enterprise||" AND t5.oocal001=t0.imaa107 AND t5.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t6 ON t6.oocalent="||g_enterprise||" AND t6.oocal001=t0.imaa106 AND t6.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t7 ON t7.oocalent="||g_enterprise||" AND t7.oocal001=t0.imaa145 AND t7.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t8 ON t8.oocalent="||g_enterprise||" AND t8.oocal001=t0.imaa146 AND t8.oocal002='"||g_dlang||"' ",
 
               " WHERE t0.imaaent = " ||g_enterprise|| " AND t0.imaa001 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE artm301_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_artm301 WITH FORM cl_ap_formpath("art",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL artm301_init()   
 
      #進入選單 Menu (="N")
      CALL artm301_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_artm301
      
   END IF 
   
   CLOSE artm301_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="artm301.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION artm301_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_values      STRING               
   DEFINE l_items       STRING
   DEFINE l_gzcb002     LIKE gzcb_t.gzcb002
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill       = "Y"
   LET g_detail_idx  = 1 #第一層單身指標
   LET g_detail_idx2 = 1 #第二層單身指標
   
   #各個page指標
   LET g_detail_idx_list[1] = 1 
   LET g_detail_idx_list[2] = 1
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('imaastus','50','N,Y,X')
 
      CALL cl_set_combo_scc('imaa108','2002') 
   CALL cl_set_combo_scc('imaa100','2003') 
   CALL cl_set_combo_scc('imaa109','2004') 
   CALL cl_set_combo_scc('imay002','2003') 
   CALL cl_set_combo_scc('imay018','6749') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1','2',","1")
   CALL g_idx_group.addAttribute("","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   #160408-00021#1 Modify By Ken 160413(S)
   ##ken---add---s 需求單號：141224-00014 項次：3
   #DECLARE i110_gzcb_cs CURSOR FOR
   # SELECT gzcb002 FROM gzcb_t
   #  WHERE gzcb001 = '6749'  
   #  ORDER BY gzcb002
   #FOREACH i110_gzcb_cs INTO l_gzcb002
   #   LET l_values = l_values CLIPPED ,",",l_gzcb002
   #   LET l_items  = l_items CLIPPED ,",",l_gzcb002
   #END FOREACH
   #CALL cl_set_combo_items("imaa113",l_values,l_items)
   #CALL cl_set_combo_items("imay018",l_values,l_items)
   ##ken---add---e
   CALL cl_set_combo_scc('imaa113','6749')
   CALL cl_set_combo_scc('imay018','6749')
   #160408-00021#1 Modify By Ken 160413(E)
   
   #CALL cl_set_combo_scc('imaa113','6749') #ken---add 需求單號：141224-00014 項次：3
   CALL cl_set_combo_scc_part('imaa109','6553','1,4,5')#Add By geza 150505
   
   #160801-00017#1 20160803 add by beckxie---S
   CALL artm301_set_comp_visible_b()
   CALL artm301_set_comp_no_visible_b()
   #160801-00017#1 20160803 add by beckxie---E
   #判斷據點參數若不使用產品特徵時，則產品特徵需隱藏不可以維護(據點參數:S-BAS-0036)
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'N' THEN
      CALL cl_set_comp_visible("pmdn002,pmdn002_desc",FALSE)
   END IF
   #end add-point
   
   #初始化搜尋條件
   CALL artm301_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="artm301.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION artm301_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_idx     LIKE type_t.num10
   DEFINE ls_wc      STRING
   DEFINE lb_first   BOOLEAN
   DEFINE la_wc      DYNAMIC ARRAY OF RECORD
          tableid    STRING,
          wc         STRING
          END RECORD
   DEFINE la_param   RECORD
          prog       STRING,
          actionid   STRING,
          background LIKE type_t.chr1,
          param      DYNAMIC ARRAY OF STRING
          END RECORD
   DEFINE ls_js      STRING
   DEFINE la_output  DYNAMIC ARRAY OF STRING   #報表元件鬆耦合使用
   DEFINE  l_cmd_token           base.StringTokenizer   #報表作業cmdrun使用 
   DEFINE  l_cmd_next            STRING                 #報表作業cmdrun使用
   DEFINE  l_cmd_cnt             LIKE type_t.num5       #報表作業cmdrun使用
   DEFINE  l_cmd_prog_arg        STRING                 #報表作業cmdrun使用
   DEFINE  l_cmd_arg             STRING                 #報表作業cmdrun使用
   #add-point:ui_dialog段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
 
   
   #action default動作
   
   
   LET lb_first = TRUE
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE 
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_imaa_m.* TO NULL
         CALL g_imay_d.clear()
         CALL g_imay2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL artm301_init()
      END IF
   
            
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
    
         DISPLAY ARRAY g_imay_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL artm301_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1','2',",l_ac)
               
               #add-point:page1, before row動作 name="ui_dialog.page1.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1','2',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
               #顯示單身筆數
               CALL artm301_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_imay2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL artm301_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[2] = l_ac
               CALL g_idx_group.addAttribute("",l_ac)
               
               #add-point:page2, before row動作 name="ui_dialog.body2.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_current_page = 2
               #顯示單身筆數
               CALL artm301_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
      
         BEFORE DIALOG
            #先填充browser資料
            CALL artm301_browser_fill("")
            CALL cl_notice()
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            
            #確保g_current_idx位於正常區間內
            #小於,等於0則指到第1筆
            IF g_current_idx <= 0 THEN
               LET g_current_idx = 1
            END IF
            #超過最大筆數則指到最後1筆
            IF g_current_idx > g_browser.getLength() THEN
               LEt g_current_idx = g_browser.getLength()
            END IF 
            
            LET g_current_sw = TRUE
            LET g_current_row = g_current_idx #目前指標
            
            #有資料才進行fetch
            IF g_current_idx <> 0 THEN
               CALL artm301_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL artm301_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL artm301_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL artm301_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL artm301_set_act_visible()   
            CALL artm301_set_act_no_visible()
            IF NOT (g_imaa_m.imaa001 IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " imaaent = " ||g_enterprise|| " AND",
                                  " imaa001 = '", g_imaa_m.imaa001, "' "
 
               #填到對應位置
               CALL artm301_browser_fill("")
            END IF
         
          
         #查詢方案選擇 
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "imaa_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "imay_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  #組合g_wc2
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
 
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
               END IF
               CALL artm301_browser_fill("F")   #browser_fill()會將notice區塊清空
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "imaa_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "imay_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1)
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL artm301_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL artm301_fetch("F")
                  END IF
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
          
         
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL artm301_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL artm301_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL artm301_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL artm301_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL artm301_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL artm301_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL artm301_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL artm301_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL artm301_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL artm301_idx_chk()
          
         #excel匯出功能          
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               #browser
               CALL g_export_node.clear()
               IF g_main_hidden = 1 THEN
                  LET g_export_node[1] = base.typeInfo.create(g_browser)
                  LET g_export_id[1]   = "s_browse"
                  CALL cl_export_to_excel()
               #非browser
               ELSE
                  LET g_export_node[1] = base.typeInfo.create(g_imay_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_imay2_d)
                  LET g_export_id[2]   = "s_detail2"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  
                  #END add-point
                  CALL cl_export_to_excel_getpage()
                  CALL cl_export_to_excel()
               END IF
            END IF
        
         ON ACTION close
            LET INT_FLAG = FALSE
            LET g_action_choice = "exit"
            EXIT DIALOG
          
         ON ACTION exit
            LET g_action_choice = "exit"
            EXIT DIALOG
    
         #主頁摺疊
         ON ACTION mainhidden       
            IF g_main_hidden THEN
               CALL gfrm_curr.setElementHidden("mainlayout",0)
               CALL gfrm_curr.setElementHidden("worksheet",1)
               LET g_main_hidden = 0
            ELSE
               CALL gfrm_curr.setElementHidden("mainlayout",1)
               CALL gfrm_curr.setElementHidden("worksheet",0)
               LET g_main_hidden = 1
               CALL cl_notice()
            END IF
            
       
         #單頭摺疊，可利用hot key "Alt-s"開啟/關閉單頭
         ON ACTION controls     
            IF g_header_hidden THEN
               CALL gfrm_curr.setElementHidden("vb_master",0)
               CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
               LET g_header_hidden = 0     #visible
            ELSE
               CALL gfrm_curr.setElementHidden("vb_master",1)
               CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
               LET g_header_hidden = 1     #hidden     
            END IF
    
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL artm301_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL artm301_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL artm301_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL artm301_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL artm301_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL artm301_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow('')
 
 
 
         
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
    
         #交談指令共用ACTION
         &include "common_action.4gl" 
            CONTINUE DIALOG
      END DIALOG
 
      #(ver:79) ---add start---
      #add-point:ui_dialog段 after dialog name="ui_dialog.exit_dialog"
      
      #end add-point
      #(ver:79) --- add end ---
    
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         #add-point:ui_dialog段離開dialog前 name="ui_dialog.b_exit"
         
         #end add-point
         EXIT WHILE
      END IF
    
   END WHILE    
      
   CALL cl_set_act_visible("accept,cancel", TRUE)
    
END FUNCTION
 
{</section>}
 
{<section id="artm301.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION artm301_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   
   #end add-point    
   
   #add-point:Function前置處理 name="browser_fill.before_browser_fill"
   
   #end add-point
   
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
   LET l_wc  = g_wc.trim() 
   LET l_wc2 = g_wc2.trim()
 
   #add-point:browser_fill,foreach前 name="browser_fill.before_foreach"
   
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT imaa001 ",
                      " FROM imaa_t ",
                      " ",
                      " LEFT JOIN imay_t ON imayent = imaaent AND imaa001 = imay001 ", "  ",
                      #add-point:browser_fill段sql(imay_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE imaaent = " ||g_enterprise|| " AND imayent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("imaa_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT imaa001 ",
                      " FROM imaa_t ", 
                      "  ",
                      "  ",
                      " WHERE imaaent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("imaa_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   
   #end add-point
   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
   
   #add-point:browser_fill,count前 name="browser_fill.before_count"
   LET l_sub_sql = l_sub_sql,
                   " AND EXISTS (SELECT imaf001 FROM imaf_t ",
                   "              WHERE imafent = ",g_enterprise," AND imafsite = 'ALL' AND imaf001 = imaa001) "
   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"                
   #end add-point
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE header_cnt_pre FROM g_sql
      EXECUTE header_cnt_pre INTO g_browser_cnt   #總筆數
      FREE header_cnt_pre
   END IF
    
   IF g_browser_cnt > g_max_browse THEN
      IF g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_browser_cnt
         LET g_errparam.code = 9035 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
      END IF
      LET g_browser_cnt = g_max_browse
   END IF
   
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
 
   #根據行為確定資料填充位置及WC
   IF cl_null(g_add_browse) THEN
      #清除畫面
      CLEAR FORM                
      INITIALIZE g_imaa_m.* TO NULL
      CALL g_imay_d.clear()        
      CALL g_imay2_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.imaa001 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.imaastus,t0.imaa001 ",
                  " FROM imaa_t t0",
                  "  ",
                  "  LEFT JOIN imay_t ON imayent = imaaent AND imaa001 = imay001 ", "  ", 
                  #add-point:browser_fill段sql(imay_t1) name="browser_fill.join.imay_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                  
                  " WHERE t0.imaaent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("imaa_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.imaastus,t0.imaa001 ",
                  " FROM imaa_t t0",
                  "  ",
                  
                  " WHERE t0.imaaent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("imaa_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY imaa001 ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   LET g_sql = " SELECT DISTINCT imaastus,imaa001 ",
               " FROM imaa_t ",
               "  LEFT JOIN imay_t ON imayent = imaaent AND imaa001 = imay001 ",
               " WHERE imaaent = '" ||g_enterprise|| "' AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("imaa_t"),
               "   AND EXISTS (SELECT imaf001 FROM imaf_t ",
               "                WHERE imafent = ",g_enterprise," AND imafsite = 'ALL' AND imaf001 = imaa001) " ,              
               #" ORDER BY ",l_searchcol," ",g_order
               " ORDER BY imaa001"
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"imaa_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_imaa001
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
      
         #add-point:browser_fill段reference name="browser_fill.reference"
         
         #end add-point
      
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/open.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/valid.png"
         WHEN "X"
            LET g_browser[g_cnt].b_statepic = "stus/16/void.png"
         
      END CASE
 
 
 
         LET g_cnt = g_cnt + 1
         IF g_cnt > g_max_browse THEN
            EXIT FOREACH
         END IF
         
      END FOREACH
      FREE browse_pre
   END IF
   
   #清空g_add_browse, 並指定指標位置
   IF NOT cl_null(g_add_browse) THEN
      LET g_add_browse = ""
      CALL g_curr_diag.setCurrentRow("s_browse",g_current_idx)
   END IF
   
   IF cl_null(g_browser[g_cnt].b_imaa001) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   LET g_header_cnt  = g_browser.getLength()
   LET g_browser_cnt = g_browser.getLength()
   
   #筆數顯示
   IF g_browser_cnt > 0 THEN
      DISPLAY g_browser_idx TO FORMONLY.b_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.b_count #總筆數
      DISPLAY g_browser_idx TO FORMONLY.h_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.h_count #總筆數
      DISPLAY g_detail_idx  TO FORMONLY.idx     #單身當下筆數
      DISPLAY g_detail_cnt  TO FORMONLY.cnt     #單身總筆數
   ELSE
      DISPLAY '' TO FORMONLY.b_index #當下筆數
      DISPLAY '' TO FORMONLY.b_count #總筆數
      DISPLAY '' TO FORMONLY.h_index #當下筆數
      DISPLAY '' TO FORMONLY.h_count #總筆數
      DISPLAY '' TO FORMONLY.idx     #單身當下筆數
      DISPLAY '' TO FORMONLY.cnt     #單身總筆數
   END IF
 
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
 
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
                  
   
   #add-point:browser_fill段結束前 name="browser_fill.after"
   
   #end add-point   
 
END FUNCTION
 
{</section>}
 
{<section id="artm301.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION artm301_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_imaa_m.imaa001 = g_browser[g_current_idx].b_imaa001   
 
   EXECUTE artm301_master_referesh USING g_imaa_m.imaa001 INTO g_imaa_m.imaa001,g_imaa_m.imaa002,g_imaa_m.imaa108, 
       g_imaa_m.imaa100,g_imaa_m.imaa109,g_imaa_m.imaa014,g_imaa_m.imaa005,g_imaa_m.imaa006,g_imaa_m.imaa105, 
       g_imaa_m.imaa104,g_imaa_m.imaa107,g_imaa_m.imaa106,g_imaa_m.imaa145,g_imaa_m.imaa146,g_imaa_m.imaa113, 
       g_imaa_m.imaastus,g_imaa_m.imaa005_desc,g_imaa_m.imaa006_desc,g_imaa_m.imaa105_desc,g_imaa_m.imaa104_desc, 
       g_imaa_m.imaa107_desc,g_imaa_m.imaa106_desc,g_imaa_m.imaa145_desc,g_imaa_m.imaa146_desc
   
   CALL artm301_imaa_t_mask()
   CALL artm301_show()
      
END FUNCTION
 
{</section>}
 
{<section id="artm301.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION artm301_ui_detailshow()
   #add-point:ui_detailshow段define(客製用) name="ui_detailshow.define_customerization"
   
   #end add-point    
   #add-point:ui_detailshow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
 
   #add-point:Function前置處理 name="ui_detailshow.before"
   
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="artm301.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION artm301_ui_browser_refresh()
   #add-point:ui_browser_refresh段define(客製用) name="ui_browser_refresh.define_customerization"
   
   #end add-point    
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_browser_refresh.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="ui_browser_refresh.pre_function"
   
   #end add-point
   
   LET g_browser_cnt = g_browser.getLength()
   LET g_header_cnt  = g_browser.getLength()
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_imaa001 = g_imaa_m.imaa001 
 
         THEN
         CALL g_browser.deleteElement(l_i)
         EXIT FOR
      END IF
   END FOR
   LET g_browser_cnt = g_browser_cnt - 1
   LET g_header_cnt = g_header_cnt - 1
    
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
      CLEAR FORM
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
   
   #add-point:ui_browser_refresh段after name="ui_browser_refresh.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="artm301.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION artm301_construct()
   #add-point:cs段define(客製用) name="cs.define_customerization"
   
   #end add-point    
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   DEFINE la_wc       DYNAMIC ARRAY OF RECORD
          tableid     STRING,
          wc          STRING
          END RECORD
   DEFINE li_idx      LIKE type_t.num10
   #add-point:cs段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_imaa_m.* TO NULL
   CALL g_imay_d.clear()        
   CALL g_imay2_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON imaa001,imaa002,imaal003,imaal004,imaa108,imaa100,imaa109,imaa014,imaa005, 
          imaa006,imaa105,imaa104,imaa107,imaa106,imaa145,imaa146,imaa113,imaastus
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<imaacrtdt>>----
 
         #----<<imaamoddt>>----
         
         #----<<imaacnfdt>>----
         
         #----<<imaapstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.imaa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa001
            #add-point:ON ACTION controlp INFIELD imaa001 name="construct.c.imaa001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa001  #顯示到畫面上
            NEXT FIELD imaa001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa001
            #add-point:BEFORE FIELD imaa001 name="construct.b.imaa001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa001
            
            #add-point:AFTER FIELD imaa001 name="construct.a.imaa001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa002
            #add-point:BEFORE FIELD imaa002 name="construct.b.imaa002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa002
            
            #add-point:AFTER FIELD imaa002 name="construct.a.imaa002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa002
            #add-point:ON ACTION controlp INFIELD imaa002 name="construct.c.imaa002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaal003
            #add-point:BEFORE FIELD imaal003 name="construct.b.imaal003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaal003
            
            #add-point:AFTER FIELD imaal003 name="construct.a.imaal003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaal003
            #add-point:ON ACTION controlp INFIELD imaal003 name="construct.c.imaal003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaal004
            #add-point:BEFORE FIELD imaal004 name="construct.b.imaal004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaal004
            
            #add-point:AFTER FIELD imaal004 name="construct.a.imaal004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaal004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaal004
            #add-point:ON ACTION controlp INFIELD imaal004 name="construct.c.imaal004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa108
            #add-point:BEFORE FIELD imaa108 name="construct.b.imaa108"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa108
            
            #add-point:AFTER FIELD imaa108 name="construct.a.imaa108"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa108
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa108
            #add-point:ON ACTION controlp INFIELD imaa108 name="construct.c.imaa108"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa100
            #add-point:BEFORE FIELD imaa100 name="construct.b.imaa100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa100
            
            #add-point:AFTER FIELD imaa100 name="construct.a.imaa100"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa100
            #add-point:ON ACTION controlp INFIELD imaa100 name="construct.c.imaa100"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa109
            #add-point:BEFORE FIELD imaa109 name="construct.b.imaa109"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa109
            
            #add-point:AFTER FIELD imaa109 name="construct.a.imaa109"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa109
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa109
            #add-point:ON ACTION controlp INFIELD imaa109 name="construct.c.imaa109"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa014
            #add-point:BEFORE FIELD imaa014 name="construct.b.imaa014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa014
            
            #add-point:AFTER FIELD imaa014 name="construct.a.imaa014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa014
            #add-point:ON ACTION controlp INFIELD imaa014 name="construct.c.imaa014"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imaa005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa005
            #add-point:ON ACTION controlp INFIELD imaa005 name="construct.c.imaa005"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imea001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa005  #顯示到畫面上
            NEXT FIELD imaa005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa005
            #add-point:BEFORE FIELD imaa005 name="construct.b.imaa005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa005
            
            #add-point:AFTER FIELD imaa005 name="construct.a.imaa005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa006
            #add-point:ON ACTION controlp INFIELD imaa006 name="construct.c.imaa006"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa006  #顯示到畫面上
            NEXT FIELD imaa006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa006
            #add-point:BEFORE FIELD imaa006 name="construct.b.imaa006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa006
            
            #add-point:AFTER FIELD imaa006 name="construct.a.imaa006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa105
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa105
            #add-point:ON ACTION controlp INFIELD imaa105 name="construct.c.imaa105"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa105  #顯示到畫面上
            NEXT FIELD imaa105                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa105
            #add-point:BEFORE FIELD imaa105 name="construct.b.imaa105"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa105
            
            #add-point:AFTER FIELD imaa105 name="construct.a.imaa105"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa104
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa104
            #add-point:ON ACTION controlp INFIELD imaa104 name="construct.c.imaa104"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa104  #顯示到畫面上
            NEXT FIELD imaa104                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa104
            #add-point:BEFORE FIELD imaa104 name="construct.b.imaa104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa104
            
            #add-point:AFTER FIELD imaa104 name="construct.a.imaa104"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa107
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa107
            #add-point:ON ACTION controlp INFIELD imaa107 name="construct.c.imaa107"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa107  #顯示到畫面上
            NEXT FIELD imaa107                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa107
            #add-point:BEFORE FIELD imaa107 name="construct.b.imaa107"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa107
            
            #add-point:AFTER FIELD imaa107 name="construct.a.imaa107"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa106
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa106
            #add-point:ON ACTION controlp INFIELD imaa106 name="construct.c.imaa106"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa106  #顯示到畫面上
            NEXT FIELD imaa106                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa106
            #add-point:BEFORE FIELD imaa106 name="construct.b.imaa106"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa106
            
            #add-point:AFTER FIELD imaa106 name="construct.a.imaa106"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa145
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa145
            #add-point:ON ACTION controlp INFIELD imaa145 name="construct.c.imaa145"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa145  #顯示到畫面上
            NEXT FIELD imaa145                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa145
            #add-point:BEFORE FIELD imaa145 name="construct.b.imaa145"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa145
            
            #add-point:AFTER FIELD imaa145 name="construct.a.imaa145"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa146
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa146
            #add-point:ON ACTION controlp INFIELD imaa146 name="construct.c.imaa146"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa146  #顯示到畫面上
            NEXT FIELD imaa146                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa146
            #add-point:BEFORE FIELD imaa146 name="construct.b.imaa146"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa146
            
            #add-point:AFTER FIELD imaa146 name="construct.a.imaa146"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa113
            #add-point:BEFORE FIELD imaa113 name="construct.b.imaa113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa113
            
            #add-point:AFTER FIELD imaa113 name="construct.a.imaa113"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa113
            #add-point:ON ACTION controlp INFIELD imaa113 name="construct.c.imaa113"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaastus
            #add-point:BEFORE FIELD imaastus name="construct.b.imaastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaastus
            
            #add-point:AFTER FIELD imaastus name="construct.a.imaastus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaastus
            #add-point:ON ACTION controlp INFIELD imaastus name="construct.c.imaastus"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON imaystus,imay002,imay019,imay019_desc,imay003,imay004,imay005,imay006, 
          imay018,imay007,imay008,imay009,imay015,imay010,imay016,imay011,imay017,imay012,imay013,imay014, 
          imayownid,imayowndp,imaycrtid,imaycrtdp,imaycrtdt,imaymodid,imaymoddt
           FROM s_detail1[1].imaystus,s_detail1[1].imay002,s_detail1[1].imay019,s_detail1[1].imay019_desc, 
               s_detail1[1].imay003,s_detail1[1].imay004,s_detail1[1].imay005,s_detail1[1].imay006,s_detail1[1].imay018, 
               s_detail1[1].imay007,s_detail1[1].imay008,s_detail1[1].imay009,s_detail1[1].imay015,s_detail1[1].imay010, 
               s_detail1[1].imay016,s_detail1[1].imay011,s_detail1[1].imay017,s_detail1[1].imay012,s_detail1[1].imay013, 
               s_detail1[1].imay014,s_detail2[1].imayownid,s_detail2[1].imayowndp,s_detail2[1].imaycrtid, 
               s_detail2[1].imaycrtdp,s_detail2[1].imaycrtdt,s_detail2[1].imaymodid,s_detail2[1].imaymoddt 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<imaycrtdt>>----
         AFTER FIELD imaycrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<imaymoddt>>----
         AFTER FIELD imaymoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<imaycnfdt>>----
         
         #----<<imaypstdt>>----
 
 
 
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaystus
            #add-point:BEFORE FIELD imaystus name="construct.b.page1.imaystus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaystus
            
            #add-point:AFTER FIELD imaystus name="construct.a.page1.imaystus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imaystus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaystus
            #add-point:ON ACTION controlp INFIELD imaystus name="construct.c.page1.imaystus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay002
            #add-point:BEFORE FIELD imay002 name="construct.b.page1.imay002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay002
            
            #add-point:AFTER FIELD imay002 name="construct.a.page1.imay002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imay002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay002
            #add-point:ON ACTION controlp INFIELD imay002 name="construct.c.page1.imay002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay019
            #add-point:BEFORE FIELD imay019 name="construct.b.page1.imay019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay019
            
            #add-point:AFTER FIELD imay019 name="construct.a.page1.imay019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imay019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay019
            #add-point:ON ACTION controlp INFIELD imay019 name="construct.c.page1.imay019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay019_desc
            #add-point:BEFORE FIELD imay019_desc name="construct.b.page1.imay019_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay019_desc
            
            #add-point:AFTER FIELD imay019_desc name="construct.a.page1.imay019_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imay019_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay019_desc
            #add-point:ON ACTION controlp INFIELD imay019_desc name="construct.c.page1.imay019_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.imay003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay003
            #add-point:ON ACTION controlp INFIELD imay003 name="construct.c.page1.imay003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imay003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imay003  #顯示到畫面上
            NEXT FIELD imay003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay003
            #add-point:BEFORE FIELD imay003 name="construct.b.page1.imay003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay003
            
            #add-point:AFTER FIELD imay003 name="construct.a.page1.imay003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imay004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay004
            #add-point:ON ACTION controlp INFIELD imay004 name="construct.c.page1.imay004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imay004  #顯示到畫面上
            NEXT FIELD imay004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay004
            #add-point:BEFORE FIELD imay004 name="construct.b.page1.imay004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay004
            
            #add-point:AFTER FIELD imay004 name="construct.a.page1.imay004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay005
            #add-point:BEFORE FIELD imay005 name="construct.b.page1.imay005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay005
            
            #add-point:AFTER FIELD imay005 name="construct.a.page1.imay005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imay005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay005
            #add-point:ON ACTION controlp INFIELD imay005 name="construct.c.page1.imay005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay006
            #add-point:BEFORE FIELD imay006 name="construct.b.page1.imay006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay006
            
            #add-point:AFTER FIELD imay006 name="construct.a.page1.imay006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imay006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay006
            #add-point:ON ACTION controlp INFIELD imay006 name="construct.c.page1.imay006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay018
            #add-point:BEFORE FIELD imay018 name="construct.b.page1.imay018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay018
            
            #add-point:AFTER FIELD imay018 name="construct.a.page1.imay018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imay018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay018
            #add-point:ON ACTION controlp INFIELD imay018 name="construct.c.page1.imay018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay007
            #add-point:BEFORE FIELD imay007 name="construct.b.page1.imay007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay007
            
            #add-point:AFTER FIELD imay007 name="construct.a.page1.imay007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imay007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay007
            #add-point:ON ACTION controlp INFIELD imay007 name="construct.c.page1.imay007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay008
            #add-point:BEFORE FIELD imay008 name="construct.b.page1.imay008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay008
            
            #add-point:AFTER FIELD imay008 name="construct.a.page1.imay008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imay008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay008
            #add-point:ON ACTION controlp INFIELD imay008 name="construct.c.page1.imay008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay009
            #add-point:BEFORE FIELD imay009 name="construct.b.page1.imay009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay009
            
            #add-point:AFTER FIELD imay009 name="construct.a.page1.imay009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imay009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay009
            #add-point:ON ACTION controlp INFIELD imay009 name="construct.c.page1.imay009"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.imay015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay015
            #add-point:ON ACTION controlp INFIELD imay015 name="construct.c.page1.imay015"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imay015  #顯示到畫面上
            NEXT FIELD imay015                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay015
            #add-point:BEFORE FIELD imay015 name="construct.b.page1.imay015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay015
            
            #add-point:AFTER FIELD imay015 name="construct.a.page1.imay015"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay010
            #add-point:BEFORE FIELD imay010 name="construct.b.page1.imay010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay010
            
            #add-point:AFTER FIELD imay010 name="construct.a.page1.imay010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imay010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay010
            #add-point:ON ACTION controlp INFIELD imay010 name="construct.c.page1.imay010"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.imay016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay016
            #add-point:ON ACTION controlp INFIELD imay016 name="construct.c.page1.imay016"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imay016  #顯示到畫面上
            NEXT FIELD imay016                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay016
            #add-point:BEFORE FIELD imay016 name="construct.b.page1.imay016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay016
            
            #add-point:AFTER FIELD imay016 name="construct.a.page1.imay016"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay011
            #add-point:BEFORE FIELD imay011 name="construct.b.page1.imay011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay011
            
            #add-point:AFTER FIELD imay011 name="construct.a.page1.imay011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imay011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay011
            #add-point:ON ACTION controlp INFIELD imay011 name="construct.c.page1.imay011"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.imay017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay017
            #add-point:ON ACTION controlp INFIELD imay017 name="construct.c.page1.imay017"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imay017  #顯示到畫面上
            NEXT FIELD imay017                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay017
            #add-point:BEFORE FIELD imay017 name="construct.b.page1.imay017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay017
            
            #add-point:AFTER FIELD imay017 name="construct.a.page1.imay017"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay012
            #add-point:BEFORE FIELD imay012 name="construct.b.page1.imay012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay012
            
            #add-point:AFTER FIELD imay012 name="construct.a.page1.imay012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imay012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay012
            #add-point:ON ACTION controlp INFIELD imay012 name="construct.c.page1.imay012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay013
            #add-point:BEFORE FIELD imay013 name="construct.b.page1.imay013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay013
            
            #add-point:AFTER FIELD imay013 name="construct.a.page1.imay013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imay013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay013
            #add-point:ON ACTION controlp INFIELD imay013 name="construct.c.page1.imay013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay014
            #add-point:BEFORE FIELD imay014 name="construct.b.page1.imay014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay014
            
            #add-point:AFTER FIELD imay014 name="construct.a.page1.imay014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imay014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay014
            #add-point:ON ACTION controlp INFIELD imay014 name="construct.c.page1.imay014"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.imayownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imayownid
            #add-point:ON ACTION controlp INFIELD imayownid name="construct.c.page2.imayownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imayownid  #顯示到畫面上
            NEXT FIELD imayownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imayownid
            #add-point:BEFORE FIELD imayownid name="construct.b.page2.imayownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imayownid
            
            #add-point:AFTER FIELD imayownid name="construct.a.page2.imayownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.imayowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imayowndp
            #add-point:ON ACTION controlp INFIELD imayowndp name="construct.c.page2.imayowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imayowndp  #顯示到畫面上
            NEXT FIELD imayowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imayowndp
            #add-point:BEFORE FIELD imayowndp name="construct.b.page2.imayowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imayowndp
            
            #add-point:AFTER FIELD imayowndp name="construct.a.page2.imayowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.imaycrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaycrtid
            #add-point:ON ACTION controlp INFIELD imaycrtid name="construct.c.page2.imaycrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaycrtid  #顯示到畫面上
            NEXT FIELD imaycrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaycrtid
            #add-point:BEFORE FIELD imaycrtid name="construct.b.page2.imaycrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaycrtid
            
            #add-point:AFTER FIELD imaycrtid name="construct.a.page2.imaycrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.imaycrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaycrtdp
            #add-point:ON ACTION controlp INFIELD imaycrtdp name="construct.c.page2.imaycrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaycrtdp  #顯示到畫面上
            NEXT FIELD imaycrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaycrtdp
            #add-point:BEFORE FIELD imaycrtdp name="construct.b.page2.imaycrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaycrtdp
            
            #add-point:AFTER FIELD imaycrtdp name="construct.a.page2.imaycrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaycrtdt
            #add-point:BEFORE FIELD imaycrtdt name="construct.b.page2.imaycrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.imaymodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaymodid
            #add-point:ON ACTION controlp INFIELD imaymodid name="construct.c.page2.imaymodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaymodid  #顯示到畫面上
            NEXT FIELD imaymodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaymodid
            #add-point:BEFORE FIELD imaymodid name="construct.b.page2.imaymodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaymodid
            
            #add-point:AFTER FIELD imaymodid name="construct.a.page2.imaymodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaymoddt
            #add-point:BEFORE FIELD imaymoddt name="construct.b.page2.imaymoddt"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
      
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="cs.b_dialog"
         
         #end add-point  
 
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
         IF NOT cl_null(ls_wc) THEN
            CALL util.JSON.parse(ls_wc, la_wc)
            INITIALIZE g_wc, g_wc2, g_wc2_table1, g_wc2_extend TO NULL
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "imaa_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "imay_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
 
               END CASE
            END FOR
         END IF
    
      #條件儲存為方案
      ON ACTION qbe_save
         CALL cl_qbe_save()
 
      ON ACTION accept
         ACCEPT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG 
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG
   END DIALOG
   
   #組合g_wc2
   LET g_wc2 = g_wc2_table1
 
 
 
   
   #add-point:cs段結束前 name="cs.after_construct"
   
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="artm301.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION artm301_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="query.pre_function"
   
   #end add-point
   
   #切換畫面
   
   LET ls_wc = g_wc
   
   LET INT_FLAG = 0
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   ERROR ""
   
   #清除畫面及相關資料
   CLEAR FORM
   CALL g_browser.clear()       
   CALL g_imay_d.clear()
   CALL g_imay2_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL artm301_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL artm301_browser_fill("")
      CALL artm301_fetch("")
      RETURN
   END IF
   
   #儲存WC資訊
   CALL cl_dlg_save_user_latestqry("("||g_wc||") AND ("||g_wc2||")")
   
   #搜尋後資料初始化 
   LET g_detail_cnt  = 0
   LET g_current_idx = 1
   LET g_current_row = 0
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_detail_idx_list[1] = 1
   LET g_detail_idx_list[2] = 1
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
   CALL artm301_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL artm301_fetch("F") 
      #顯示單身筆數
      CALL artm301_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="artm301.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION artm301_fetch(p_flag)
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point    
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="fetch.pre_function"
   
   #end add-point
   
   IF g_browser_cnt = 0 THEN
      RETURN
   END IF
 
   #清空第二階單身
 
   
   CALL cl_ap_performance_next_start()
   CASE p_flag
      WHEN 'F' 
         LET g_current_idx = 1
      WHEN 'L'  
         LET g_current_idx = g_browser.getLength()              
      WHEN 'P'
         IF g_current_idx > 1 THEN               
            LET g_current_idx = g_current_idx - 1
         END IF 
      WHEN 'N'
         IF g_current_idx < g_header_cnt THEN
            LET g_current_idx =  g_current_idx + 1
         END IF        
      WHEN '/'
         IF (NOT g_no_ask) THEN    
            CALL cl_set_act_visible("accept,cancel", TRUE)    
            CALL cl_getmsg('fetch',g_lang) RETURNING ls_msg
            LET INT_FLAG = 0
 
            PROMPT ls_msg CLIPPED,':' FOR g_jump
               #交談指令共用ACTION
               &include "common_action.4gl" 
            END PROMPT
 
            CALL cl_set_act_visible("accept,cancel", FALSE)    
            IF INT_FLAG THEN
                LET INT_FLAG = 0
                EXIT CASE  
            END IF           
         END IF
         
         IF g_jump > 0 AND g_jump <= g_browser.getLength() THEN
             LET g_current_idx = g_jump
         END IF
         LET g_no_ask = FALSE  
   END CASE 
 
   
   LET g_current_row = g_current_idx
   LET g_detail_cnt = g_header_cnt                  
   
   #單身總筆數顯示
   IF g_detail_cnt > 0 THEN
      #若單身有資料時, idx至少為1
      IF g_detail_idx <= 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx  
   ELSE
      LET g_detail_idx = 0
      DISPLAY '' TO FORMONLY.idx    
   END IF
   
   #瀏覽頁筆數顯示
   LET g_pagestart = g_current_idx
   DISPLAY g_pagestart TO FORMONLY.b_index   #當下筆數
   DISPLAY g_pagestart TO FORMONLY.h_index   #當下筆數
   
   CALL cl_navigator_setting( g_pagestart, g_browser_cnt )
 
   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF
   
   #避免超出browser資料筆數上限
   IF g_current_idx > g_browser.getLength() THEN
      LET g_browser_idx = g_browser.getLength()
      LET g_current_idx = g_browser.getLength()
   END IF
   
   LET g_imaa_m.imaa001 = g_browser[g_current_idx].b_imaa001
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE artm301_master_referesh USING g_imaa_m.imaa001 INTO g_imaa_m.imaa001,g_imaa_m.imaa002,g_imaa_m.imaa108, 
       g_imaa_m.imaa100,g_imaa_m.imaa109,g_imaa_m.imaa014,g_imaa_m.imaa005,g_imaa_m.imaa006,g_imaa_m.imaa105, 
       g_imaa_m.imaa104,g_imaa_m.imaa107,g_imaa_m.imaa106,g_imaa_m.imaa145,g_imaa_m.imaa146,g_imaa_m.imaa113, 
       g_imaa_m.imaastus,g_imaa_m.imaa005_desc,g_imaa_m.imaa006_desc,g_imaa_m.imaa105_desc,g_imaa_m.imaa104_desc, 
       g_imaa_m.imaa107_desc,g_imaa_m.imaa106_desc,g_imaa_m.imaa145_desc,g_imaa_m.imaa146_desc
   
   #遮罩相關處理
   LET g_imaa_m_mask_o.* =  g_imaa_m.*
   CALL artm301_imaa_t_mask()
   LET g_imaa_m_mask_n.* =  g_imaa_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL artm301_set_act_visible()   
   CALL artm301_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   CALL cl_set_act_visible("insert,delete,reproduce",FALSE)   #不允許增刪修料號資訊
   #end add-point
   
   #保存單頭舊值
   LET g_imaa_m_t.* = g_imaa_m.*
   LET g_imaa_m_o.* = g_imaa_m.*
   
   
   #重新顯示   
   CALL artm301_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="artm301.insert" >}
#+ 資料新增
PRIVATE FUNCTION artm301_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_imay_d.clear()   
   CALL g_imay2_d.clear()  
 
 
   INITIALIZE g_imaa_m.* TO NULL             #DEFAULT 設定
   
   LET g_imaa001_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_imaa_m.imaastus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_imaa_m.imaa108 = "1"
      LET g_imaa_m.imaa100 = "1"
      LET g_imaa_m.imaa109 = "1"
      LET g_imaa_m.imaa113 = "1"
      LET g_imaa_m.imaastus = "N"
 
  
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_imaa_m_t.* = g_imaa_m.*
      LET g_imaa_m_o.* = g_imaa_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_imaa_m.imaastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
         
      END CASE
 
 
 
    
      CALL artm301_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
      
      IF NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_imaa_m.* TO NULL
         INITIALIZE g_imay_d TO NULL
         INITIALIZE g_imay2_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL artm301_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_imay_d.clear()
      #CALL g_imay2_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL artm301_set_act_visible()   
   CALL artm301_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_imaa001_t = g_imaa_m.imaa001
 
   
   #組合新增資料的條件
   LET g_add_browse = " imaaent = " ||g_enterprise|| " AND",
                      " imaa001 = '", g_imaa_m.imaa001, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL artm301_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE artm301_cl
   
   CALL artm301_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE artm301_master_referesh USING g_imaa_m.imaa001 INTO g_imaa_m.imaa001,g_imaa_m.imaa002,g_imaa_m.imaa108, 
       g_imaa_m.imaa100,g_imaa_m.imaa109,g_imaa_m.imaa014,g_imaa_m.imaa005,g_imaa_m.imaa006,g_imaa_m.imaa105, 
       g_imaa_m.imaa104,g_imaa_m.imaa107,g_imaa_m.imaa106,g_imaa_m.imaa145,g_imaa_m.imaa146,g_imaa_m.imaa113, 
       g_imaa_m.imaastus,g_imaa_m.imaa005_desc,g_imaa_m.imaa006_desc,g_imaa_m.imaa105_desc,g_imaa_m.imaa104_desc, 
       g_imaa_m.imaa107_desc,g_imaa_m.imaa106_desc,g_imaa_m.imaa145_desc,g_imaa_m.imaa146_desc
   
   
   #遮罩相關處理
   LET g_imaa_m_mask_o.* =  g_imaa_m.*
   CALL artm301_imaa_t_mask()
   LET g_imaa_m_mask_n.* =  g_imaa_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_imaa_m.imaa001,g_imaa_m.imaa002,g_imaa_m.imaal003,g_imaa_m.imaal004,g_imaa_m.imaa108, 
       g_imaa_m.imaa100,g_imaa_m.imaa109,g_imaa_m.imaa014,g_imaa_m.imaa005,g_imaa_m.imaa005_desc,g_imaa_m.imaa006, 
       g_imaa_m.imaa006_desc,g_imaa_m.imaa105,g_imaa_m.imaa105_desc,g_imaa_m.imaa104,g_imaa_m.imaa104_desc, 
       g_imaa_m.imaa107,g_imaa_m.imaa107_desc,g_imaa_m.imaa106,g_imaa_m.imaa106_desc,g_imaa_m.imaa145, 
       g_imaa_m.imaa145_desc,g_imaa_m.imaa146,g_imaa_m.imaa146_desc,g_imaa_m.imaa113,g_imaa_m.imaastus 
 
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   
   #功能已完成,通報訊息中心
   CALL artm301_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="artm301.modify" >}
#+ 資料修改
PRIVATE FUNCTION artm301_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_imaa_m_t.* = g_imaa_m.*
   LET g_imaa_m_o.* = g_imaa_m.*
   
   IF g_imaa_m.imaa001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_imaa001_t = g_imaa_m.imaa001
 
   CALL s_transaction_begin()
   
   OPEN artm301_cl USING g_enterprise,g_imaa_m.imaa001
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN artm301_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE artm301_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE artm301_master_referesh USING g_imaa_m.imaa001 INTO g_imaa_m.imaa001,g_imaa_m.imaa002,g_imaa_m.imaa108, 
       g_imaa_m.imaa100,g_imaa_m.imaa109,g_imaa_m.imaa014,g_imaa_m.imaa005,g_imaa_m.imaa006,g_imaa_m.imaa105, 
       g_imaa_m.imaa104,g_imaa_m.imaa107,g_imaa_m.imaa106,g_imaa_m.imaa145,g_imaa_m.imaa146,g_imaa_m.imaa113, 
       g_imaa_m.imaastus,g_imaa_m.imaa005_desc,g_imaa_m.imaa006_desc,g_imaa_m.imaa105_desc,g_imaa_m.imaa104_desc, 
       g_imaa_m.imaa107_desc,g_imaa_m.imaa106_desc,g_imaa_m.imaa145_desc,g_imaa_m.imaa146_desc
   
   #檢查是否允許此動作
   IF NOT artm301_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_imaa_m_mask_o.* =  g_imaa_m.*
   CALL artm301_imaa_t_mask()
   LET g_imaa_m_mask_n.* =  g_imaa_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL artm301_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_imaa001_t = g_imaa_m.imaa001
 
      
      #寫入修改者/修改日期資訊(單頭)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL artm301_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
 
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_imaa_m.* = g_imaa_m_t.*
            CALL artm301_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_imaa_m.imaa001 != g_imaa_m_t.imaa001
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE imay_t SET imay001 = g_imaa_m.imaa001
 
          WHERE imayent = g_enterprise AND imay001 = g_imaa_m_t.imaa001
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "imay_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "imay_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         
         #add-point:單身fk修改後 name="modify.body.a_fk_update"
         
         #end add-point
         
 
         
 
         
         #UPDATE 多語言table key值
         
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL artm301_set_act_visible()   
   CALL artm301_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " imaaent = " ||g_enterprise|| " AND",
                      " imaa001 = '", g_imaa_m.imaa001, "' "
 
   #填到對應位置
   CALL artm301_browser_fill("")
 
   CLOSE artm301_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL artm301_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="artm301.input" >}
#+ 資料輸入
PRIVATE FUNCTION artm301_input(p_cmd)
   #add-point:input段define(客製用) name="input.define_customerization"
   
   #end add-point  
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd_t               LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_n                   LIKE type_t.num10                #檢查重複用  
   DEFINE  l_cnt                 LIKE type_t.num10                #檢查重複用  
   DEFINE  l_lock_sw             LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert        LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete        LIKE type_t.num5                #可刪除否  
   DEFINE  l_count               LIKE type_t.num10
   DEFINE  l_i                   LIKE type_t.num10
   DEFINE  l_ac_t                LIKE type_t.num10
   DEFINE  l_insert              BOOLEAN
   DEFINE  ls_return             STRING
   DEFINE  l_var_keys            DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys          DYNAMIC ARRAY OF STRING
   DEFINE  l_vars                DYNAMIC ARRAY OF STRING
   DEFINE  l_fields              DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak        DYNAMIC ARRAY OF STRING
   DEFINE  lb_reproduce          BOOLEAN
   DEFINE  li_reproduce          LIKE type_t.num10
   DEFINE  li_reproduce_target   LIKE type_t.num10
   DEFINE  ls_keys               DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:input段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   DEFINE  l_type                LIKE rtaj_t.rtaj001
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_upd_imaa014         LIKE type_t.chr1
   DEFINE  l_imay005             LIKE imay_t.imay005 #150602-00072#1 Add By Ken 150603   
   DEFINE  l_time                DATETIME YEAR TO SECOND #add by geza 20150717
   DEFINE  l_imay004             LIKE imay_t.imay004 #160510-00031#1 Add By pengxin 20160511 
   #160803-00008#1 20160811 add by beckxie---S
   DEFINE  l_inam            DYNAMIC ARRAY OF RECORD   #記錄產品特徵
           inam001           LIKE inam_t.inam001,  #料號
           inam002           LIKE inam_t.inam002,  #產品特徵
           inam004           LIKE inam_t.inam004   #nouse
                             END RECORD
   #160803-00008#1 20160811 add by beckxie---E
   #end add-point  
   
   #add-point:Function前置處理  name="input.pre_function"
   
   #end add-point
   
   #先做狀態判定
   IF p_cmd = 'r' THEN
      LET l_cmd_t = 'r'
      LET p_cmd   = 'a'
   ELSE
      LET l_cmd_t = p_cmd
   END IF   
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_imaa_m.imaa001,g_imaa_m.imaa002,g_imaa_m.imaal003,g_imaa_m.imaal004,g_imaa_m.imaa108, 
       g_imaa_m.imaa100,g_imaa_m.imaa109,g_imaa_m.imaa014,g_imaa_m.imaa005,g_imaa_m.imaa005_desc,g_imaa_m.imaa006, 
       g_imaa_m.imaa006_desc,g_imaa_m.imaa105,g_imaa_m.imaa105_desc,g_imaa_m.imaa104,g_imaa_m.imaa104_desc, 
       g_imaa_m.imaa107,g_imaa_m.imaa107_desc,g_imaa_m.imaa106,g_imaa_m.imaa106_desc,g_imaa_m.imaa145, 
       g_imaa_m.imaa145_desc,g_imaa_m.imaa146,g_imaa_m.imaa146_desc,g_imaa_m.imaa113,g_imaa_m.imaastus 
 
   
   #切換畫面
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql name="input.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT imaystus,imay002,imay019,imay003,imay004,imay005,imay006,imay018,imay007, 
       imay008,imay009,imay015,imay010,imay016,imay011,imay017,imay012,imay013,imay014,imay003,imayownid, 
       imayowndp,imaycrtid,imaycrtdp,imaycrtdt,imaymodid,imaymoddt FROM imay_t WHERE imayent=? AND imay001=?  
       AND imay003=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE artm301_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL artm301_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL artm301_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_imaa_m.imaa002
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="artm301.input.head" >}
      #單頭段
      INPUT BY NAME g_imaa_m.imaa002 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN artm301_cl USING g_enterprise,g_imaa_m.imaa001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN artm301_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE artm301_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL artm301_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            NEXT FIELD imaystus
            #end add-point
            CALL artm301_set_no_entry(p_cmd)
    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa002
            #add-point:BEFORE FIELD imaa002 name="input.b.imaa002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa002
            
            #add-point:AFTER FIELD imaa002 name="input.a.imaa002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa002
            #add-point:ON CHANGE imaa002 name="input.g.imaa002"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.imaa002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa002
            #add-point:ON ACTION controlp INFIELD imaa002 name="input.c.imaa002"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_imaa_m.imaa001
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               
               #end add-point
               
               INSERT INTO imaa_t (imaaent,imaa001,imaa002,imaa108,imaa100,imaa109,imaa014,imaa005,imaa006, 
                   imaa105,imaa104,imaa107,imaa106,imaa145,imaa146,imaa113,imaastus)
               VALUES (g_enterprise,g_imaa_m.imaa001,g_imaa_m.imaa002,g_imaa_m.imaa108,g_imaa_m.imaa100, 
                   g_imaa_m.imaa109,g_imaa_m.imaa014,g_imaa_m.imaa005,g_imaa_m.imaa006,g_imaa_m.imaa105, 
                   g_imaa_m.imaa104,g_imaa_m.imaa107,g_imaa_m.imaa106,g_imaa_m.imaa145,g_imaa_m.imaa146, 
                   g_imaa_m.imaa113,g_imaa_m.imaastus) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_imaa_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL artm301_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL artm301_b_fill()
                  CALL artm301_b_fill2('0')
               END IF
               
               #add-point:單頭新增後 name="input.head.a_insert2"
               
               #end add-point
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL artm301_imaa_t_mask_restore('restore_mask_o')
               
               UPDATE imaa_t SET (imaa001,imaa002,imaa108,imaa100,imaa109,imaa014,imaa005,imaa006,imaa105, 
                   imaa104,imaa107,imaa106,imaa145,imaa146,imaa113,imaastus) = (g_imaa_m.imaa001,g_imaa_m.imaa002, 
                   g_imaa_m.imaa108,g_imaa_m.imaa100,g_imaa_m.imaa109,g_imaa_m.imaa014,g_imaa_m.imaa005, 
                   g_imaa_m.imaa006,g_imaa_m.imaa105,g_imaa_m.imaa104,g_imaa_m.imaa107,g_imaa_m.imaa106, 
                   g_imaa_m.imaa145,g_imaa_m.imaa146,g_imaa_m.imaa113,g_imaa_m.imaastus)
                WHERE imaaent = g_enterprise AND imaa001 = g_imaa001_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "imaa_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL artm301_imaa_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_imaa_m_t)
               LET g_log2 = util.JSON.stringify(g_imaa_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_imaa001_t = g_imaa_m.imaa001
 
            
      END INPUT
   
 
{</section>}
 
{<section id="artm301.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_imay_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_imay_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL artm301_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1','2',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_imay_d.getLength()
            #add-point:資料輸入前 name="input.d.before_input"
           
            #end add-point
         
         BEFORE ROW
            #add-point:modify段before row2 name="input.body.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_detail_idx_list[1] = l_ac
            LET g_current_page = 1
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN artm301_cl USING g_enterprise,g_imaa_m.imaa001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN artm301_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE artm301_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_imay_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_imay_d[l_ac].imay003 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_imay_d_t.* = g_imay_d[l_ac].*  #BACKUP
               LET g_imay_d_o.* = g_imay_d[l_ac].*  #BACKUP
               CALL artm301_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               #根据商品种类值判断条码类型条码分类的值  geza 2015/05/05  add
               IF NOT cl_null(g_imaa_m.imaa108) THEN   
                  IF g_imaa_m.imaa108 = '1' THEN 
                     CALL cl_set_combo_scc('imay002','2003')
                  END IF
                  IF g_imaa_m.imaa108 = '3' THEN 
                     CALL cl_set_combo_scc_part('imay002','2003','2')              
                  END IF 
                  IF g_imaa_m.imaa108 = '4' THEN 
                     CALL cl_set_combo_scc_part('imay002','2003','2')          
                  END IF
                  IF g_imaa_m.imaa108 = '2' THEN 
                     CALL cl_set_combo_scc('imay002','2003')                
                  END IF                
               END IF 
               #end add-point  
               CALL artm301_set_no_entry_b(l_cmd)
               IF NOT artm301_lock_b("imay_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH artm301_bcl INTO g_imay_d[l_ac].imaystus,g_imay_d[l_ac].imay002,g_imay_d[l_ac].imay019, 
                      g_imay_d[l_ac].imay003,g_imay_d[l_ac].imay004,g_imay_d[l_ac].imay005,g_imay_d[l_ac].imay006, 
                      g_imay_d[l_ac].imay018,g_imay_d[l_ac].imay007,g_imay_d[l_ac].imay008,g_imay_d[l_ac].imay009, 
                      g_imay_d[l_ac].imay015,g_imay_d[l_ac].imay010,g_imay_d[l_ac].imay016,g_imay_d[l_ac].imay011, 
                      g_imay_d[l_ac].imay017,g_imay_d[l_ac].imay012,g_imay_d[l_ac].imay013,g_imay_d[l_ac].imay014, 
                      g_imay2_d[l_ac].imay003,g_imay2_d[l_ac].imayownid,g_imay2_d[l_ac].imayowndp,g_imay2_d[l_ac].imaycrtid, 
                      g_imay2_d[l_ac].imaycrtdp,g_imay2_d[l_ac].imaycrtdt,g_imay2_d[l_ac].imaymodid, 
                      g_imay2_d[l_ac].imaymoddt
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_imay_d_t.imay003,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_imay_d_mask_o[l_ac].* =  g_imay_d[l_ac].*
                  CALL artm301_imay_t_mask()
                  LET g_imay_d_mask_n[l_ac].* =  g_imay_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL artm301_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            #160801-00017#1 20160803 add by beckxie---S
            CALL artm301_set_no_required_b(l_cmd)
            CALL artm301_set_required_b(l_cmd)
            #160801-00017#1 20160803 add by beckxie---E
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
 
            #其他table進行lock
            
 
 
        
         BEFORE INSERT  
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_imay_d[l_ac].* TO NULL 
            INITIALIZE g_imay_d_t.* TO NULL 
            INITIALIZE g_imay_d_o.* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_imay2_d[l_ac].imayownid = g_user
      LET g_imay2_d[l_ac].imayowndp = g_dept
      LET g_imay2_d[l_ac].imaycrtid = g_user
      LET g_imay2_d[l_ac].imaycrtdp = g_dept 
      LET g_imay2_d[l_ac].imaycrtdt = cl_get_current()
      LET g_imay2_d[l_ac].imaymodid = g_user
      LET g_imay2_d[l_ac].imaymoddt = cl_get_current()
      LET g_imay_d[l_ac].imaystus = 'N'
 
 
 
            #自定義預設值
                  LET g_imay_d[l_ac].imaystus = "Y"
      LET g_imay_d[l_ac].imay005 = "0"
      LET g_imay_d[l_ac].imay006 = "N"
      LET g_imay_d[l_ac].imay018 = "1"
      LET g_imay_d[l_ac].imay007 = "0"
      LET g_imay_d[l_ac].imay008 = "0"
      LET g_imay_d[l_ac].imay009 = "0"
      LET g_imay_d[l_ac].imay010 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            #150906-00005#2 20151126 add by beckxie---S
            LET g_imay_d[l_ac].imay002=g_imaa_m.imaa100
            #150906-00005#2 20151126 add by beckxie---E
            SELECT imaa019,imaa020,imaa021,imaa022,imaa025,
                   imaa026,imaa016,imaa018
              INTO g_imay_d[l_ac].imay007,   #深
                   g_imay_d[l_ac].imay008,   #寬
                   g_imay_d[l_ac].imay009,   #高
                   g_imay_d[l_ac].imay015,   #長度單位
                   g_imay_d[l_ac].imay010,   #體積
                   g_imay_d[l_ac].imay016,   #體積單位
                   g_imay_d[l_ac].imay011,   #毛重
                   g_imay_d[l_ac].imay017    #重量單位
              FROM imaa_t
             WHERE imaaent = g_enterprise
               AND imaa001 = g_imaa_m.imaa001
               
            LET g_imay_d[l_ac].imay015_desc = s_desc_get_unit_desc(g_imay_d[l_ac].imay015)
            LET g_imay_d[l_ac].imay016_desc = s_desc_get_unit_desc(g_imay_d[l_ac].imay016)            
            LET g_imay_d[l_ac].imay017_desc = s_desc_get_unit_desc(g_imay_d[l_ac].imay017)
            #根据商品种类值判断条码类型条码分类的值  geza 2015/05/05  add
            IF NOT cl_null(g_imaa_m.imaa108) THEN   
               IF g_imaa_m.imaa108 = '1' THEN 
                  CALL cl_set_combo_scc('imay002','2003')
               END IF
               IF g_imaa_m.imaa108 = '3' THEN 
                  CALL cl_set_combo_scc_part('imay002','2003','2')              
               END IF 
               IF g_imaa_m.imaa108 = '4' THEN 
                  CALL cl_set_combo_scc_part('imay002','2003','2')          
               END IF
               IF g_imaa_m.imaa108 = '2' THEN 
                  CALL cl_set_combo_scc('imay002','2003')                
               END IF                
            END IF 
            #传秤因子赋值  150505  geza  add
            IF g_imaa_m.imaa108 = '3' THEN 
               LET  g_imay_d[l_ac].imay018 = 1000
            ELSE
               LET  g_imay_d[l_ac].imay018 = 1
            END IF 
            #条码赋值  150505  geza  add            
            #end add-point
            LET g_imay_d_t.* = g_imay_d[l_ac].*     #新輸入資料
            LET g_imay_d_o.* = g_imay_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL artm301_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL artm301_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_imay_d[li_reproduce_target].* = g_imay_d[li_reproduce].*
               LET g_imay2_d[li_reproduce_target].* = g_imay2_d[li_reproduce].*
 
               LET g_imay_d[li_reproduce_target].imay003 = NULL
 
            END IF
            
 
 
            #add-point:modify段before insert name="input.body.before_insert"
            LET g_imay_d[l_ac].imay012 = g_imaa_m.imaa106
            LET g_imay_d[l_ac].imay014 = g_imaa_m.imaa104
            LET l_upd_imaa014 = 'N'
            #end add-point  
  
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身新增 name="input.body.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM imay_t 
             WHERE imayent = g_enterprise AND imay001 = g_imaa_m.imaa001
 
               AND imay003 = g_imay_d[l_ac].imay003
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               IF g_imay_d[l_ac].imay002 = '2' THEN
#                  IF g_imaa_m.imaa109 = '1' OR g_imaa_m.imaa109 = '4' THEN   #20150505--mark--geza
                  IF g_imaa_m.imaa109 = '1'  THEN   #20150505--mark--geza
                     IF g_imay_d[l_ac].imay005 = 1 THEN
                        CALL s_auto_barcode('1') RETURNING g_imay_d[l_ac].imay003,l_success
                     END IF
                     IF g_imay_d[l_ac].imay005 > 1 THEN
                        CALL s_auto_barcode('2') RETURNING g_imay_d[l_ac].imay003,l_success
                     END IF
                  END IF
                  #20150505--mark--geza---start 
#                  IF g_imaa_m.imaa109 = '2' THEN
#                     CALL s_auto_barcode('4') RETURNING g_imay_d[l_ac].imay003,l_success
#                  END IF
#                  IF g_imaa_m.imaa109 = '3' THEN
#                     CALL s_auto_barcode('5') RETURNING g_imay_d[l_ac].imay003,l_success
#                  END IF
                  #20150505--mark--geza---end 
                  #20150505--add--geza---start 
                  IF g_imaa_m.imaa109 = '4' THEN
                     CALL s_auto_barcode('4') RETURNING g_imay_d[l_ac].imay003,l_success
                  END IF
                  IF g_imaa_m.imaa109 = '5' THEN
                     CALL s_auto_barcode('5') RETURNING g_imay_d[l_ac].imay003,l_success
                  END IF
                  #20150505--add--geza---end  
                  IF NOT l_success THEN
                     INITIALIZE g_imay_d[l_ac].* TO NULL
                     CALL s_transaction_end('N','0')
                     CANCEL INSERT
                  END IF
               END IF
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_imaa_m.imaa001
               LET gs_keys[2] = g_imay_d[g_detail_idx].imay003
               CALL artm301_insert_b('imay_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_imay_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "imay_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL artm301_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               #160822-00036#4 20160823 mark by beckxie---S
               ##160803-00008#1 20160811 add by beckxie---S
               #IF l_inam.getlength() >1 THEN
               #   #根據選的特徵自動生成多筆條碼資料
               #   CALL cl_err_collect_init()
               #   CALL s_transaction_begin()
               #   IF NOT s_artm300_ins_imay(l_inam) THEN
               #      CALL s_transaction_end('N','0')
               #   ELSE
               #      CALL s_transaction_end('Y','0')
               #   END IF
               #   CALL cl_err_collect_show()
               #   CALL artm301_b_fill()
               #END IF           
               ##160803-00008#1 20160811 add by beckxie---E
               #160822-00036#4 20160823 mark by beckxie---E
               IF NOT artm301_upd_imaa014(l_upd_imaa014) THEN
                  CALL s_transaction_end('N','0')
               END IF
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身刪除後(=d) name="input.body.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body.b_delete_ask"
               
               #end add-point 
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code = -263 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身刪除前 name="input.body.b_delete"
               LET l_imay004 = g_imay_d[l_ac].imay004
               #end add-point 
               
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_imaa_m.imaa001
 
               LET gs_keys[gs_keys.getLength()+1] = g_imay_d_t.imay003
 
            
               #刪除同層單身
               IF NOT artm301_delete_b('imay_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE artm301_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT artm301_key_delete_b(gs_keys,'imay_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE artm301_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE artm301_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_imay_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_imay_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaystus
            #add-point:BEFORE FIELD imaystus name="input.b.page1.imaystus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaystus
            
            #add-point:AFTER FIELD imaystus name="input.a.page1.imaystus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaystus
            #add-point:ON CHANGE imaystus name="input.g.page1.imaystus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay002
            #add-point:BEFORE FIELD imay002 name="input.b.page1.imay002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay002
            
            #add-point:AFTER FIELD imay002 name="input.a.page1.imay002"
            IF NOT cl_null(g_imay_d[l_ac].imay002) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imay_d[l_ac].imay002 != g_imay_d_t.imay002 OR g_imay_d_t.imay002 IS NULL )) THEN
                  IF p_cmd = 'a' THEN        
                     IF g_imay_d[l_ac].imay002 = '1' AND NOT cl_null(g_imay_d[l_ac].imay003) THEN
                        CALL s_chk_barcode(g_imay_d[l_ac].imay003) RETURNING g_success
                        IF g_success = 'N' THEN
                           LET g_imay_d[l_ac].imay003 = g_imay_d[l_ac].imay003
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  ELSE
                     #150906-00005#2 20151126 add by beckxie---S
                     IF g_imay_d[l_ac].imay002 = '1' THEN
                        IF NOT cl_null(g_imay_d[l_ac].imay003) THEN
                           CALL s_chk_barcode(g_imay_d[l_ac].imay003) RETURNING g_success
                           IF g_success = 'N' THEN
                              LET g_imay_d[l_ac].imay003 = g_imay_d_t.imay003
                              NEXT FIELD CURRENT
                           END IF
                        END IF
                     END IF     
                     #150906-00005#2 20151126 add by beckxie---E
                     IF g_imay_d[l_ac].imay003 = '1' AND g_imay_d_t.imay002 = '2' THEN
                        LET g_imay_d[l_ac].imay003 = ""
                     END IF
                  END IF
               END IF
            END IF
            CALL artm301_set_entry_b(l_cmd)
            #160801-00017#1 20160803 add by beckxie---S
            CALL artm301_set_no_required_b(l_cmd)
            CALL artm301_set_required_b(l_cmd)
            #160801-00017#1 20160803 add by beckxie---E
            CALL artm301_set_no_entry_b(l_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imay002
            #add-point:ON CHANGE imay002 name="input.g.page1.imay002"
            #160801-00017#1 20160803 add by beckxie---S
            CALL artm301_set_no_required_b(l_cmd)
            CALL artm301_set_required_b(l_cmd)
            #160801-00017#1 20160803 add by beckxie---E
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay019
            
            #add-point:AFTER FIELD imay019 name="input.a.page1.imay019"
            #160801-00017#1 20160803 add by beckxie---S
            LET g_imay_d[l_ac].imay019_desc=''
            IF NOT cl_null(g_imay_d[l_ac].imay019) THEN
               IF NOT s_feature_check_t('2','',g_imaa_m.imaa001,g_imay_d[l_ac].imay019) THEN
                  LET g_imay_d[l_ac].imay019 = g_imay_d_o.imay019
                  CALL s_feature_description(g_imaa_m.imaa001,g_imay_d[l_ac].imay019) 
                       RETURNING l_success,g_imay_d[l_ac].imay019_desc
                  NEXT FIELD CURRENT
               ELSE
                  LET g_imay_d_o.imay019 = g_imay_d[l_ac].imay019 
                  CALL s_feature_description(g_imaa_m.imaa001,g_imay_d[l_ac].imay019) 
                       RETURNING l_success,g_imay_d[l_ac].imay019_desc
                  DISPLAY BY NAME g_imay_d[l_ac].imay019,g_imay_d[l_ac].imay019_desc     
               END IF
            END IF
            #160801-00017#1 20160803 add by beckxie---E
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay019
            #add-point:BEFORE FIELD imay019 name="input.b.page1.imay019"
            #160801-00017#1 20160804 add by beckxie---S
            CALL artm301_set_no_required_b(l_cmd)
            CALL artm301_set_required_b(l_cmd)
            #160801-00017#1 20160804 add by beckxie---E
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imay019
            #add-point:ON CHANGE imay019 name="input.g.page1.imay019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay019_desc
            #add-point:BEFORE FIELD imay019_desc name="input.b.page1.imay019_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay019_desc
            
            #add-point:AFTER FIELD imay019_desc name="input.a.page1.imay019_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imay019_desc
            #add-point:ON CHANGE imay019_desc name="input.g.page1.imay019_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay003
            #add-point:BEFORE FIELD imay003 name="input.b.page1.imay003"
            LET  l_type = NULL
            IF g_imay_d[l_ac].imay002 = '2' AND cl_null(g_imay_d[l_ac].imay003) THEN
             #20150505--mark--geza---start 
#               CASE g_imaa_m.imaa109
#                  WHEN '1' 
#                     LET l_type = '1'              
#                  WHEN '2' 
#                     LET l_type = '4'
#                  WHEN '3' 
#                     LET l_type = '5'
#                  WHEN '4' 
#                     LET l_type = '1' 
#
#               END CASE
               #20150505--mark--geza---start 
               #20150505--add--geza---start 
               CASE g_imaa_m.imaa109
                  WHEN '1' 
                     LET l_type = '1'              
                  WHEN '4' 
                     LET l_type = '4'
                  WHEN '5' 
                     LET l_type = '5'

               END CASE
               #20150505--add--geza---end  
               CALL s_auto_barcode(l_type) RETURNING g_imay_d[l_ac].imay003,l_success
               IF NOT l_success THEN
                  LET g_imay_d[l_ac].imay003 = g_imay_d_t.imay003
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay003
            
            #add-point:AFTER FIELD imay003 name="input.a.page1.imay003"
            #此段落由子樣板a05產生
            IF  g_imaa_m.imaa001 IS NOT NULL AND g_imay_d[g_detail_idx].imay003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_imaa_m.imaa001 != g_imaa001_t OR g_imay_d[g_detail_idx].imay003 != g_imay_d_t.imay003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM imay_t WHERE "||"imayent = '" ||g_enterprise|| "' AND "||"imay001 = '"||g_imaa_m.imaa001 ||"' AND "|| "imay003 = '"||g_imay_d[g_detail_idx].imay003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
                  
                  CALL artm301_chk_barcode(g_imay_d[l_ac].imay003)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_imay_d[l_ac].imay003
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_imay_d[l_ac].imay003 = g_imay_d_t.imay003
                     NEXT FIELD CURRENT
                  END IF
                  
                  IF g_imay_d[l_ac].imay002 = '1' THEN
                     CALL s_chk_barcode(g_imay_d[l_ac].imay003) RETURNING g_success
                     IF g_success = 'N' THEN
                        LET g_imay_d[l_ac].imay003 = g_imay_d_t.imay003
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  IF g_imay_d[l_ac].imay002 != 3 THEN   #160803-00008#1 20160812 add by beckxie
                     #150906-00005#2 20151126 add by beckxie---S
                     IF NOT s_artt300_chk_imba014(g_imay_d[l_ac].imay003) THEN
                        IF NOT cl_null(g_imay_d[l_ac].imay003) THEN
                           LET g_imay_d[l_ac].imay003 = g_imay_d_t.imay003
                        END IF
                        NEXT FIELD CURRENT
                     END IF
                     #150906-00005#2 20151126 add by beckxie---E
                  END IF   #160803-00008#1 20160812 add by beckxie
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imay003
            #add-point:ON CHANGE imay003 name="input.g.page1.imay003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay004
            
            #add-point:AFTER FIELD imay004 name="input.a.page1.imay004"
            LET g_imay_d[l_ac].imay004_desc  = ' '
            DISPLAY BY NAME g_imay_d[l_ac].imay004_desc 
            IF NOT cl_null(g_imay_d[l_ac].imay004) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imay_d[l_ac].imay004 != g_imay_d_t.imay004 OR g_imay_d_t.imay004 IS NULL )) THEN
               IF (g_imay_d[l_ac].imay004 != g_imay_d_o.imay004 OR g_imay_d_o.imay004 IS NULL ) THEN               
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_imay_d[l_ac].imay004
                  #160318-00025#40  2016/04/22  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
                  #160318-00025#40  2016/04/22  by pengxin  add(E)
                  IF NOT cl_chk_exist("v_ooca001") THEN
                     LET g_imay_d[l_ac].imay004 = g_imay_d_o.imay004
                     LET g_imay_d[l_ac].imay004_desc = s_desc_get_unit_desc(g_imay_d[l_ac].imay004)
                     NEXT FIELD CURRENT
                  END IF
                  #160406-00007#1 20160419 mark by beckxie---S
                  ##在原校驗前,先行檢查 此包裝單位與銷售計價單位之間 是否存在換算率 對應關係
                  #IF NOT artm301_imay013_default() THEN
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.columns[1] = "lbl_imay004"
                  #   LET g_errparam.values[1] = g_imay_d[l_ac].imay004
                  #   LET g_errparam.columns[2] = "lbl_imaa106"
                  #   LET g_errparam.values[2] = g_imaa_m.imaa106
                  #   LET g_errparam.code   = "art-00402" 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   
                  #   LET g_imay_d[l_ac].imay004 = g_imay_d_o.imay004
                  #   LET g_imay_d[l_ac].imay004_desc = s_desc_get_unit_desc(g_imay_d[l_ac].imay004)
                  #   NEXT FIELD CURRENT 
                  #END IF
                  #160406-00007#1 20160419 mark by beckxie---E
                  
                  #150602-00072#1 Add-S By Ken 150602
                  CALL artm301_imay005_chk() RETURNING l_success,l_imay005
                  IF l_success THEN  #商品的多條碼包裝單位已存在時，預帶申請單中的同包裝單位件裝數
                     LET g_imay_d[l_ac].imay005 = l_imay005
                  ELSE               #商品多條碼包裝單位不存在時，預帶轉換率中的包裝單位件裝數 
                  #150602-00072#1 Add-E By Ken 150602  
                     CALL artm301_imay005_default()
                  END IF
                                       
                  #150602-00072#1 Add-S By Ken 150602
                  IF NOT artm301_imay005_chk_1() THEN
                    INITIALIZE g_errparam TO NULL
                       LET g_errparam.code = 'art-00591'
                       LET g_errparam.extend = '輸入件裝數：',g_imay_d[l_ac].imay005
                       LET g_errparam.popup = TRUE
                       LET g_errparam.replace[1] = g_imaa_m.imaa001
                       LET g_errparam.replace[2] = g_imay_d[l_ac].imay004
                       LET g_errparam.replace[3] = g_imay_d_o.imay005                
                       CALL cl_err()
                    
                    LET g_imay_d[l_ac].imay004 = g_imay_d_o.imay004
                    LET g_imay_d[l_ac].imay004_desc = s_desc_get_unit_desc(g_imay_d[l_ac].imay004)
                    NEXT FIELD CURRENT            
                  END IF
                  #150602-00072#1 Add-E By Ken 150602                                       
               END IF
            END IF
            LET g_imay_d[l_ac].imay004_desc = s_desc_get_unit_desc(g_imay_d[l_ac].imay004)
            LET g_imay_d_o.imay004 = g_imay_d[l_ac].imay004
            LET g_imay_d_o.imay005 = g_imay_d[l_ac].imay005
            CALL artm301_set_entry_b(l_cmd)
            CALL artm301_set_no_entry_b(l_cmd)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay004
            #add-point:BEFORE FIELD imay004 name="input.b.page1.imay004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imay004
            #add-point:ON CHANGE imay004 name="input.g.page1.imay004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay005
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imay_d[l_ac].imay005,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imay005
            END IF 
 
 
 
            #add-point:AFTER FIELD imay005 name="input.a.page1.imay005"
            IF NOT cl_null(g_imay_d[l_ac].imay005) THEN
               #150602-00072#1 Add-S By Ken 150602
               IF NOT artm301_imay005_chk_1() THEN
                 INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = 'art-00591'
                    LET g_errparam.extend = '輸入件裝數：',g_imay_d[l_ac].imay005
                    LET g_errparam.popup = TRUE
                    LET g_errparam.replace[1] = g_imaa_m.imaa001
                    LET g_errparam.replace[2] = g_imay_d[l_ac].imay004
                    LET g_errparam.replace[3] = g_imay_d_o.imay005                
                    CALL cl_err()
                 
                 LET g_imay_d[l_ac].imay005 = g_imay_d_o.imay005
                 NEXT FIELD CURRENT            
               END IF
               #150602-00072#1 Add-E By Ken 150602              
            END IF 
            LET g_imay_d_o.imay005 = g_imay_d[l_ac].imay005

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay005
            #add-point:BEFORE FIELD imay005 name="input.b.page1.imay005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imay005
            #add-point:ON CHANGE imay005 name="input.g.page1.imay005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay006
            #add-point:BEFORE FIELD imay006 name="input.b.page1.imay006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay006
            
            #add-point:AFTER FIELD imay006 name="input.a.page1.imay006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imay006
            #add-point:ON CHANGE imay006 name="input.g.page1.imay006"
            IF NOT cl_null(g_imay_d[l_ac].imay006)
               AND (g_imay_d[l_ac].imay006 != g_imay_d_t.imay006 OR g_imay_d_t.imay006 IS NULL) THEN
               
               CALL artm301_imay006_chk() RETURNING l_success,l_upd_imaa014
               IF NOT l_success THEN
                  NEXT FIELD CURRENT
               END IF
            END IF
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay018
            #add-point:BEFORE FIELD imay018 name="input.b.page1.imay018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay018
            
            #add-point:AFTER FIELD imay018 name="input.a.page1.imay018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imay018
            #add-point:ON CHANGE imay018 name="input.g.page1.imay018"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay007
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imay_d[l_ac].imay007,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imay007
            END IF 
 
 
 
            #add-point:AFTER FIELD imay007 name="input.a.page1.imay007"
            IF NOT cl_null(g_imay_d[l_ac].imay007) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay007
            #add-point:BEFORE FIELD imay007 name="input.b.page1.imay007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imay007
            #add-point:ON CHANGE imay007 name="input.g.page1.imay007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay008
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imay_d[l_ac].imay008,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imay008
            END IF 
 
 
 
            #add-point:AFTER FIELD imay008 name="input.a.page1.imay008"
            IF NOT cl_null(g_imay_d[l_ac].imay008) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay008
            #add-point:BEFORE FIELD imay008 name="input.b.page1.imay008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imay008
            #add-point:ON CHANGE imay008 name="input.g.page1.imay008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay009
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imay_d[l_ac].imay009,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imay009
            END IF 
 
 
 
            #add-point:AFTER FIELD imay009 name="input.a.page1.imay009"
            IF NOT cl_null(g_imay_d[l_ac].imay009) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay009
            #add-point:BEFORE FIELD imay009 name="input.b.page1.imay009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imay009
            #add-point:ON CHANGE imay009 name="input.g.page1.imay009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay015
            
            #add-point:AFTER FIELD imay015 name="input.a.page1.imay015"
            LET g_imay_d[l_ac].imay015_desc = ''
            IF NOT cl_null(g_imay_d[l_ac].imay015) THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND g_imay_d[l_ac].imay015 != g_imay_d_t.imay015 OR g_imay_d_t.imay015 IS NULL ) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_imay_d[l_ac].imay015
                  #160318-00025#40  2016/04/22  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
                  #160318-00025#40  2016/04/22  by pengxin  add(E)
                  IF NOT cl_chk_exist("v_ooca001") THEN
                     LET g_imay_d[l_ac].imay015 = g_imay_d_t.imay015
                     LET g_imay_d[l_ac].imay015_desc = s_desc_get_unit_desc(g_imay_d[l_ac].imay015)
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_imay_d[l_ac].imay015_desc = s_desc_get_unit_desc(g_imay_d[l_ac].imay015)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay015
            #add-point:BEFORE FIELD imay015 name="input.b.page1.imay015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imay015
            #add-point:ON CHANGE imay015 name="input.g.page1.imay015"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay010
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imay_d[l_ac].imay010,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imay010
            END IF 
 
 
 
            #add-point:AFTER FIELD imay010 name="input.a.page1.imay010"
            IF NOT cl_null(g_imay_d[l_ac].imay010) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay010
            #add-point:BEFORE FIELD imay010 name="input.b.page1.imay010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imay010
            #add-point:ON CHANGE imay010 name="input.g.page1.imay010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay016
            
            #add-point:AFTER FIELD imay016 name="input.a.page1.imay016"
                        LET g_imay_d[l_ac].imay016_desc = ''
            IF NOT cl_null(g_imay_d[l_ac].imay016) THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND g_imay_d[l_ac].imay016 != g_imay_d_t.imay016 OR g_imay_d_t.imay016 IS NULL ) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_imay_d[l_ac].imay016
                  #160318-00025#40  2016/04/22  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
                  #160318-00025#40  2016/04/22  by pengxin  add(E)
                  IF NOT cl_chk_exist("v_ooca001") THEN
                     LET g_imay_d[l_ac].imay016 = g_imay_d_t.imay016
                     LET g_imay_d[l_ac].imay016_desc = s_desc_get_unit_desc(g_imay_d[l_ac].imay016)
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_imay_d[l_ac].imay016_desc = s_desc_get_unit_desc(g_imay_d[l_ac].imay016)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay016
            #add-point:BEFORE FIELD imay016 name="input.b.page1.imay016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imay016
            #add-point:ON CHANGE imay016 name="input.g.page1.imay016"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay011
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imay_d[l_ac].imay011,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imay011
            END IF 
 
 
 
            #add-point:AFTER FIELD imay011 name="input.a.page1.imay011"
            IF NOT cl_null(g_imay_d[l_ac].imay011) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay011
            #add-point:BEFORE FIELD imay011 name="input.b.page1.imay011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imay011
            #add-point:ON CHANGE imay011 name="input.g.page1.imay011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay017
            
            #add-point:AFTER FIELD imay017 name="input.a.page1.imay017"
            LET g_imay_d[l_ac].imay017_desc = ''
            IF NOT cl_null(g_imay_d[l_ac].imay017) THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND g_imay_d[l_ac].imay017 != g_imay_d_t.imay017 OR g_imay_d_t.imay017 IS NULL ) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_imay_d[l_ac].imay017
                  #160318-00025#40  2016/04/22  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
                  #160318-00025#40  2016/04/22  by pengxin  add(E)
                  IF NOT cl_chk_exist("v_ooca001") THEN
                     LET g_imay_d[l_ac].imay017 = g_imay_d_t.imay017
                     LET g_imay_d[l_ac].imay017_desc = s_desc_get_unit_desc(g_imay_d[l_ac].imay017)
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_imay_d[l_ac].imay017_desc = s_desc_get_unit_desc(g_imay_d[l_ac].imay017)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay017
            #add-point:BEFORE FIELD imay017 name="input.b.page1.imay017"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imay017
            #add-point:ON CHANGE imay017 name="input.g.page1.imay017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay012
            #add-point:BEFORE FIELD imay012 name="input.b.page1.imay012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay012
            
            #add-point:AFTER FIELD imay012 name="input.a.page1.imay012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imay012
            #add-point:ON CHANGE imay012 name="input.g.page1.imay012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay013
            #add-point:BEFORE FIELD imay013 name="input.b.page1.imay013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay013
            
            #add-point:AFTER FIELD imay013 name="input.a.page1.imay013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imay013
            #add-point:ON CHANGE imay013 name="input.g.page1.imay013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay014
            #add-point:BEFORE FIELD imay014 name="input.b.page1.imay014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay014
            
            #add-point:AFTER FIELD imay014 name="input.a.page1.imay014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imay014
            #add-point:ON CHANGE imay014 name="input.g.page1.imay014"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.imaystus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaystus
            #add-point:ON ACTION controlp INFIELD imaystus name="input.c.page1.imaystus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imay002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay002
            #add-point:ON ACTION controlp INFIELD imay002 name="input.c.page1.imay002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imay019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay019
            #add-point:ON ACTION controlp INFIELD imay019 name="input.c.page1.imay019"
            #160801-00017#1 20160803 add by beckxie---S
            IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'Y' AND NOT cl_null(g_imaa_m.imaa005) THEN
               #160803-00008#1 20160811 add by beckxie---S
               IF l_cmd = 'a' AND g_imay_d[l_ac].imay002 = '3' THEN            
                  CALL l_inam.clear()            
                  CALL s_feature_1(l_cmd,'2',g_imaa_m.imaa001,'',g_site,'') 
                       RETURNING l_success,l_inam
                  LET g_imay_d[l_ac].imay019 = l_inam[1].inam002
                  CALL s_feature_description(g_imaa_m.imaa001,g_imay_d[l_ac].imay019) 
                       RETURNING l_success,g_imay_d[l_ac].imay019_desc
                  IF NOT cl_null(l_inam[1].inam002) THEN
                     LET g_imay_d[l_ac].imay003 = g_imaa_m.imaa001,s_feature_get_feature_str(g_imay_d[l_ac].imay019)
                  END IF
                  #160822-00036#4 20160823 add by beckxie---S
                  IF l_inam.getlength() >1 THEN
                     #根據選的特徵自動生成多筆條碼資料
                     CALL cl_err_collect_init()
                     CALL s_transaction_begin()
                     IF NOT s_artm300_ins_imay(l_inam) THEN
                        CALL s_transaction_end('N','0')
                     ELSE
                        CALL s_transaction_end('Y','0')
                     END IF
                     CALL cl_err_collect_show()
                     CALL artm301_show()
                     #因為可能會修改此筆資料,顯示後需刪除
                     DELETE FROM imay_t WHERE imayent = g_enterprise AND imay003 = g_imay_d[l_ac].imay003
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "DELETE FROM :"
                        LET g_errparam.code   = SQLCA.sqlcode 
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                     END IF
                  END IF           
                  #160822-00036#4 20160823 add by beckxie---E
               ELSE
               #160803-00008#1 20160811 add by beckxie---E
                  CALL s_feature_single(g_imaa_m.imaa001,g_imay_d[l_ac].imay019,g_site,'')
                       RETURNING l_success,g_imay_d[l_ac].imay019
                  CALL s_feature_description(g_imaa_m.imaa001,g_imay_d[l_ac].imay019) 
                       RETURNING l_success,g_imay_d[l_ac].imay019_desc
               END IF   #160803-00008#1 20160811 add by beckxie
            END IF
            DISPLAY BY NAME g_imay_d[l_ac].imay019,g_imay_d[l_ac].imay019_desc     
            #160801-00017#1 20160803 add by beckxie---E
            #END add-point
 
 
         #Ctrlp:input.c.page1.imay019_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay019_desc
            #add-point:ON ACTION controlp INFIELD imay019_desc name="input.c.page1.imay019_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imay003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay003
            #add-point:ON ACTION controlp INFIELD imay003 name="input.c.page1.imay003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imay004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay004
            #add-point:ON ACTION controlp INFIELD imay004 name="input.c.page1.imay004"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imay_d[l_ac].imay004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooca001_1()                                #呼叫開窗

            LET g_imay_d[l_ac].imay004 = g_qryparam.return1              

            DISPLAY g_imay_d[l_ac].imay004 TO imay004              #
            LET g_imay_d[l_ac].imay004_desc = s_desc_get_unit_desc(g_imay_d[l_ac].imay004)
            DISPLAY BY NAME g_imay_d[l_ac].imay004_desc
            NEXT FIELD imay004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.imay005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay005
            #add-point:ON ACTION controlp INFIELD imay005 name="input.c.page1.imay005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imay006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay006
            #add-point:ON ACTION controlp INFIELD imay006 name="input.c.page1.imay006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imay018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay018
            #add-point:ON ACTION controlp INFIELD imay018 name="input.c.page1.imay018"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imay007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay007
            #add-point:ON ACTION controlp INFIELD imay007 name="input.c.page1.imay007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imay008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay008
            #add-point:ON ACTION controlp INFIELD imay008 name="input.c.page1.imay008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imay009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay009
            #add-point:ON ACTION controlp INFIELD imay009 name="input.c.page1.imay009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imay015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay015
            #add-point:ON ACTION controlp INFIELD imay015 name="input.c.page1.imay015"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imay_d[l_ac].imay015             #給予default值
            CALL q_ooca001_1()                                #呼叫開窗

            LET g_imay_d[l_ac].imay015 = g_qryparam.return1   
            DISPLAY g_imay_d[l_ac].imay015 TO imay015              #
            LET g_imay_d[l_ac].imay015_desc = s_desc_get_unit_desc(g_imay_d[l_ac].imay015)
            NEXT FIELD imay015                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.imay010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay010
            #add-point:ON ACTION controlp INFIELD imay010 name="input.c.page1.imay010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imay016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay016
            #add-point:ON ACTION controlp INFIELD imay016 name="input.c.page1.imay016"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imay_d[l_ac].imay016             #給予default值
            CALL q_ooca001_1()                                #呼叫開窗

            LET g_imay_d[l_ac].imay016 = g_qryparam.return1              

            DISPLAY g_imay_d[l_ac].imay016 TO imay016              #
            LET g_imay_d[l_ac].imay016_desc = s_desc_get_unit_desc(g_imay_d[l_ac].imay016)
            NEXT FIELD imay016                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.imay011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay011
            #add-point:ON ACTION controlp INFIELD imay011 name="input.c.page1.imay011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imay017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay017
            #add-point:ON ACTION controlp INFIELD imay017 name="input.c.page1.imay017"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imay_d[l_ac].imay017             #給予default值
            CALL q_ooca001_1()                                #呼叫開窗

            LET g_imay_d[l_ac].imay017 = g_qryparam.return1              

            DISPLAY g_imay_d[l_ac].imay017 TO imay017              #
            LET g_imay_d[l_ac].imay017_desc = s_desc_get_unit_desc(g_imay_d[l_ac].imay017)
            NEXT FIELD imay017                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.imay012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay012
            #add-point:ON ACTION controlp INFIELD imay012 name="input.c.page1.imay012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imay013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay013
            #add-point:ON ACTION controlp INFIELD imay013 name="input.c.page1.imay013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imay014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay014
            #add-point:ON ACTION controlp INFIELD imay014 name="input.c.page1.imay014"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_imay_d[l_ac].* = g_imay_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE artm301_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_imay_d[l_ac].imay003 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_imay_d[l_ac].* = g_imay_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               #LET l_cnt = 0
               #
               #SELECT COUNT(*) INTO l_cnt
               #  FROM imay_t 
               # WHERE imayent = g_enterprise 
               #   AND imay001 = g_imaa_m.imaa001
               #   AND imay003 != g_imay_d[l_ac].imay003
               #   AND imay006 = 'Y'
                  
               #IF g_imay_d.getLength() > 0 AND l_cnt = 0 AND g_imay_d[l_ac].imay006 ='N' THEN
               #   INITIALIZE g_errparam TO NULL
               #   LET g_errparam.code = 'art-00396'
               #   LET g_errparam.extend = ''
               #   LET g_errparam.popup = TRUE
               #   CALL cl_err()
               #   
               #   LET g_imay_d[l_ac].imay006 = 'Y'
               #   CALL s_transaction_end('N','0')
               #   
               #   NEXT FIELD imay006
               #END IF
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               LET g_imay2_d[l_ac].imaymodid = g_user 
LET g_imay2_d[l_ac].imaymoddt = cl_get_current()
LET g_imay2_d[l_ac].imaymodid_desc = cl_get_username(g_imay2_d[l_ac].imaymodid)
      
               #將遮罩欄位還原
               CALL artm301_imay_t_mask_restore('restore_mask_o')
      
               UPDATE imay_t SET (imay001,imaystus,imay002,imay019,imay003,imay004,imay005,imay006,imay018, 
                   imay007,imay008,imay009,imay015,imay010,imay016,imay011,imay017,imay012,imay013,imay014, 
                   imayownid,imayowndp,imaycrtid,imaycrtdp,imaycrtdt,imaymodid,imaymoddt) = (g_imaa_m.imaa001, 
                   g_imay_d[l_ac].imaystus,g_imay_d[l_ac].imay002,g_imay_d[l_ac].imay019,g_imay_d[l_ac].imay003, 
                   g_imay_d[l_ac].imay004,g_imay_d[l_ac].imay005,g_imay_d[l_ac].imay006,g_imay_d[l_ac].imay018, 
                   g_imay_d[l_ac].imay007,g_imay_d[l_ac].imay008,g_imay_d[l_ac].imay009,g_imay_d[l_ac].imay015, 
                   g_imay_d[l_ac].imay010,g_imay_d[l_ac].imay016,g_imay_d[l_ac].imay011,g_imay_d[l_ac].imay017, 
                   g_imay_d[l_ac].imay012,g_imay_d[l_ac].imay013,g_imay_d[l_ac].imay014,g_imay2_d[l_ac].imayownid, 
                   g_imay2_d[l_ac].imayowndp,g_imay2_d[l_ac].imaycrtid,g_imay2_d[l_ac].imaycrtdp,g_imay2_d[l_ac].imaycrtdt, 
                   g_imay2_d[l_ac].imaymodid,g_imay2_d[l_ac].imaymoddt)
                WHERE imayent = g_enterprise AND imay001 = g_imaa_m.imaa001 
 
                  AND imay003 = g_imay_d_t.imay003 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_imay_d[l_ac].* = g_imay_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imay_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_imay_d[l_ac].* = g_imay_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imay_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_imaa_m.imaa001
               LET gs_keys_bak[1] = g_imaa001_t
               LET gs_keys[2] = g_imay_d[g_detail_idx].imay003
               LET gs_keys_bak[2] = g_imay_d_t.imay003
               CALL artm301_update_b('imay_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL artm301_imay_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_imay_d[g_detail_idx].imay003 = g_imay_d_t.imay003 
 
                  ) THEN
                  LET gs_keys[01] = g_imaa_m.imaa001
 
                  LET gs_keys[gs_keys.getLength()+1] = g_imay_d_t.imay003
 
                  CALL artm301_key_update_b(gs_keys,'imay_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_imaa_m),util.JSON.stringify(g_imay_d_t)
               LET g_log2 = util.JSON.stringify(g_imaa_m),util.JSON.stringify(g_imay_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               IF NOT artm301_upd_imaa014(l_upd_imaa014) THEN
                  CALL s_transaction_end('N','0')
               END IF
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            #160406-00007#1 20160419 add by beckxie---S
            IF NOT cl_null(g_imay_d[l_ac].imay004) THEN     #160510-00031#1   2016/05/18  add 判断单身中包装单位是否为空,不为空就走转换单位逻辑
               LET g_imay2_d[l_ac].imaymoddt = cl_get_current()
               LET l_cnt = 0
               SELECT COUNT(*) INTO l_cnt FROM imad_t
                WHERE imadent = g_enterprise
                  AND imad001 = g_imaa_m.imaa001
                  AND imad002 = g_imaa_m.imaa104
                  AND imad004 = g_imay_d[l_ac].imay004
#                  AND imad004 =l_imay004
               IF l_cnt = 0 THEN
                  INSERT INTO imad_t(imadent,imad001,imad002,imad003,
                                     imad004,imad005,imadstus,imadownid,
                                     imadowndp,imadcrtid,imadcrtdt,imadcrtdp)
                       VALUES(g_enterprise,g_imaa_m.imaa001,g_imaa_m.imaa104,g_imay_d[l_ac].imay005,
                              g_imay_d[l_ac].imay004,1,'Y',g_imay2_d[l_ac].imayownid,
#                              l_imay004,1,'Y',g_imay2_d[l_ac].imayownid,
                              g_imay2_d[l_ac].imayowndp,g_imay2_d[l_ac].imaycrtid,g_imay2_d[l_ac].imaycrtdt,g_imay2_d[l_ac].imaycrtdp) 
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = 'Ins imad_t'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  END IF  
               ELSE
                  UPDATE imad_t SET  imad003   = g_imay_d[l_ac].imay005,
                                     imad005   = 1 ,
                                     imadstus  = 'Y',
                                     imadmodid = g_user,
                                     imadmoddt = g_imay2_d[l_ac].imaymoddt 
                   WHERE imadent = g_enterprise
                     AND imad001 = g_imaa_m.imaa001
                     AND imad002 = g_imaa_m.imaa104
                     AND imad004 = g_imay_d[l_ac].imay004
#                     AND imad004 =l_imay004
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = 'Upd imad_t'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  END IF  
               END IF
               #
               LET l_cnt = 0
               SELECT COUNT(*) INTO l_cnt FROM imad_t
                WHERE imadent = g_enterprise
                  AND imad001 = g_imaa_m.imaa001
                  AND imad002 = g_imay_d[l_ac].imay004
#                  AND imad002 = l_imay004
                  AND imad004 = g_imaa_m.imaa104
               IF l_cnt = 0 THEN
                  INSERT INTO imad_t(imadent,imad001,imad002,imad003,
                                     imad004,imad005,imadstus,imadownid,
                                     imadowndp,imadcrtid,imadcrtdt,imadcrtdp)
                       VALUES(g_enterprise,g_imaa_m.imaa001,g_imay_d[l_ac].imay004,1,
#                       VALUES(g_enterprise,g_imaa_m.imaa001,l_imay004,1,
                              g_imaa_m.imaa104,g_imay_d[l_ac].imay005,'Y',g_imay2_d[l_ac].imayownid,
                              g_imay2_d[l_ac].imayowndp,g_imay2_d[l_ac].imaycrtid,g_imay2_d[l_ac].imaycrtdt,g_imay2_d[l_ac].imaycrtdp) 
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = 'Ins imad_t'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  END IF  
               ELSE
                  UPDATE imad_t SET  imad003   = 1,
                                     imad005   = g_imay_d[l_ac].imay005,
                                     imadstus  = 'Y',
                                     imadmodid = g_user,
                                     imadmoddt = g_imay2_d[l_ac].imaymoddt
                   WHERE imadent = g_enterprise
                     AND imad001 = g_imaa_m.imaa001
                     AND imad002 = g_imay_d[l_ac].imay004
#                     AND imad002 =l_imay004
                     AND imad004 = g_imaa_m.imaa104
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = 'Upd imad_t'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  END IF  
               END IF
               CALL artm301_imay013_default() RETURNING l_success       #依包裝單位和銷售計價單位取換算率
            END IF      #160510-00031#1   如果包装单位不为空,则进行包装单位转换
               
               #160406-00007#1 20160419 add by beckxie---E
            #end add-point
            CALL artm301_unlock_b("imay_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            #add-point:單身after_row2 name="input.body.after_row2"
            
            #end add-point
              
         AFTER INPUT
            #add-point:input段after input  name="input.body.after_input"
            LET l_cnt = 0
            SELECT COUNT(*) INTO l_cnt
              FROM imay_t
             WHERE imay001 = g_imaa_m.imaa001
               AND imayent   = g_enterprise
               AND imay006   = 'Y'
            IF l_cnt = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'art-00034'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               
               LET g_imaa_m.imaa100 = ""
               LET g_imaa_m.imaa014 = ""
               UPDATE imaa_t SET imaa100 = g_imaa_m.imaa100,
                                 imaa014 = g_imaa_m.imaa014
                WHERE imaaent = g_enterprise
                  AND imaa001 = g_imaa_m.imaa001
               DISPLAY BY NAME g_imaa_m.imaa100,g_imaa_m.imaa014
            ELSE
               IF l_cnt = 1 THEN
                  LET l_cnt = 0
                  SELECT COUNT(*) INTO l_cnt
                    FROM imay_t
                   WHERE imayent = g_enterprise
                     AND imay001 = g_imaa_m.imaa001
                     AND imay006 = 'Y'
                     AND imaystus = 'Y'
                  IF l_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'art-00033'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD imay006
                  END IF
                  SELECT imay002,imay003
                    INTO g_imaa_m.imaa100,g_imaa_m.imaa014
                    FROM imay_t
                   WHERE imayent = g_enterprise
                     AND imay001 = g_imaa_m.imaa001
                     AND imay006 = 'Y'

                  UPDATE imaa_t SET imaa100 = g_imaa_m.imaa100,
                                    imaa014 = g_imaa_m.imaa014
                   WHERE imaaent = g_enterprise
                     AND imaa001 = g_imaa_m.imaa001
                  DISPLAY BY NAME g_imaa_m.imaa100,g_imaa_m.imaa014
                  IF g_imaa_m.imaa100 = '1' THEN
                     UPDATE imaa_t SET imaa109 = '1'
                      WHERE imaaent = g_enterprise
                        AND imaa001 = g_imaa_m.imaa001
                     DISPLAY BY NAME g_imaa_m.imaa109
                  END IF
                  #更新商品的主條碼時，一併修改門店商品清單的主條碼資料
                  LET l_time = cl_get_current()
                  UPDATE rtdx_t
                     SET rtdx002 = g_imaa_m.imaa014,
                         rtdxmodid = g_user,
                         rtdxmoddt = l_time
                   WHERE rtdxent = g_enterprise
                     AND rtdx001 = g_imaa_m.imaa001
               ELSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'art-00035'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD imay006
               END IF
            END IF
            #end add-point 
    
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_imay_d[li_reproduce_target].* = g_imay_d[li_reproduce].*
               LET g_imay2_d[li_reproduce_target].* = g_imay2_d[li_reproduce].*
 
               LET g_imay_d[li_reproduce_target].imay003 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_imay_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_imay_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
      DISPLAY ARRAY g_imay2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
         BEFORE ROW
            CALL artm301_idx_chk()
            LET l_ac = DIALOG.getCurrentRow("s_detail2")
            LET g_detail_idx = l_ac
            
            #add-point:page2, before row動作 name="input.body2.before_row"
            
            #end add-point
            
         BEFORE DISPLAY
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
            END IF
            LET g_loc = 'm'
            LET l_ac = DIALOG.getCurrentRow("s_detail2")
            CALL artm301_idx_chk()
            LET g_current_page = 2
      
         #add-point:page2自定義行為 name="input.body2.action"
         
         #end add-point
      
      END DISPLAY
 
 
 
{</section>}
 
{<section id="artm301.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1','2',"))      
         CALL DIALOG.setCurrentRow("s_detail2",g_idx_group.getValue(""))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD imaa001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD imaystus
               WHEN "s_detail2"
                  NEXT FIELD imay003_2
 
               #add-point:input段modify_detail  name="input.modify_detail.other"
               
               #end add-point  
            END CASE
         END IF
      
      AFTER DIALOG
         #add-point:input段after_dialog name="input.after_dialog"
         
         #end add-point    
         
      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang)
 
      ON ACTION controlr
         CALL cl_show_req_fields()
 
      ON ACTION controls
         IF g_header_hidden THEN
            CALL gfrm_curr.setElementHidden("vb_master",0)
            CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
            LET g_header_hidden = 0     #visible
         ELSE
            CALL gfrm_curr.setElementHidden("vb_master",1)
            CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
            LET g_header_hidden = 1     #hidden     
         END IF
 
      ON ACTION accept
         #add-point:input段accept  name="input.accept"
 
         #end add-point    
         ACCEPT DIALOG
        
      ON ACTION cancel      #在dialog button (放棄)
         #add-point:input段cancel name="input.cancel"
         
         #end add-point  
         LET INT_FLAG = TRUE 
         LET g_detail_idx  = 1
         LET g_detail_idx2 = 1
         #各個page指標
         LET g_detail_idx_list[1] = 1 
         LET g_detail_idx_list[2] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
         EXIT DIALOG
 
      ON ACTION close       #在dialog 右上角 (X)
         #add-point:input段close name="input.close"
         
         #end add-point  
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         #add-point:input段exit name="input.exit"
         
         #end add-point
         LET INT_FLAG = TRUE 
         LET g_detail_idx  = 1
         LET g_detail_idx2 = 1
         #各個page指標
         LET g_detail_idx_list[1] = 1 
         LET g_detail_idx_list[2] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
  
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="artm301.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION artm301_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE l_success LIKE type_t.num5   #160801-00017#1 20160803 add by beckxie
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL artm301_b_fill() #單身填充
      CALL artm301_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL artm301_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   CALL s_desc_get_item_desc(g_imaa_m.imaa001) RETURNING g_imaa_m.imaal003,g_imaa_m.imaal004
   DISPLAY BY NAME g_imaa_m.imaal003,g_imaa_m.imaal004
   
   LET g_imaa_m.imaa005_desc = s_desc_get_acc_desc('211',g_imaa_m.imaa005)
   DISPLAY BY NAME g_imaa_m.imaa005_desc

   LET g_imaa_m.imaa006_desc = s_desc_get_unit_desc(g_imaa_m.imaa006)
   DISPLAY BY NAME g_imaa_m.imaa006_desc

   LET g_imaa_m.imaa105_desc = s_desc_get_unit_desc(g_imaa_m.imaa105)
   DISPLAY BY NAME g_imaa_m.imaa105_desc

   LET g_imaa_m.imaa104_desc = s_desc_get_unit_desc(g_imaa_m.imaa104)
   DISPLAY BY NAME g_imaa_m.imaa104_desc

   LET g_imaa_m.imaa107_desc = s_desc_get_unit_desc(g_imaa_m.imaa107)
   DISPLAY BY NAME g_imaa_m.imaa107_desc

   LET g_imaa_m.imaa106_desc = s_desc_get_unit_desc(g_imaa_m.imaa106)
   DISPLAY BY NAME g_imaa_m.imaa106_desc

   #end add-point
   
   #遮罩相關處理
   LET g_imaa_m_mask_o.* =  g_imaa_m.*
   CALL artm301_imaa_t_mask()
   LET g_imaa_m_mask_n.* =  g_imaa_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_imaa_m.imaa001,g_imaa_m.imaa002,g_imaa_m.imaal003,g_imaa_m.imaal004,g_imaa_m.imaa108, 
       g_imaa_m.imaa100,g_imaa_m.imaa109,g_imaa_m.imaa014,g_imaa_m.imaa005,g_imaa_m.imaa005_desc,g_imaa_m.imaa006, 
       g_imaa_m.imaa006_desc,g_imaa_m.imaa105,g_imaa_m.imaa105_desc,g_imaa_m.imaa104,g_imaa_m.imaa104_desc, 
       g_imaa_m.imaa107,g_imaa_m.imaa107_desc,g_imaa_m.imaa106,g_imaa_m.imaa106_desc,g_imaa_m.imaa145, 
       g_imaa_m.imaa145_desc,g_imaa_m.imaa146,g_imaa_m.imaa146_desc,g_imaa_m.imaa113,g_imaa_m.imaastus 
 
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_imaa_m.imaastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_imay_d.getLength()
      #add-point:show段單身reference name="show.body.reference"

      LET g_imay_d[l_ac].imay004_desc = s_desc_get_unit_desc(g_imay_d[l_ac].imay004)
      DISPLAY BY NAME g_imay_d[l_ac].imay004_desc
      
      #160801-00017#1 20160803 add by beckxie---S
      CALL s_feature_description(g_imaa_m.imaa001,g_imay_d[l_ac].imay019) 
                       RETURNING l_success,g_imay_d[l_ac].imay019_desc
      DISPLAY BY NAME g_imay_d[l_ac].imay019_desc
      #160801-00017#1 20160803 add by beckxie---E
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_imay2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
      LET g_imay2_d[l_ac].imayownid_desc = s_desc_get_person_desc(g_imay2_d[l_ac].imayownid)
      DISPLAY BY NAME g_imay2_d[l_ac].imayownid_desc

      LET g_imay2_d[l_ac].imayowndp_desc = s_desc_get_department_desc(g_imay2_d[l_ac].imayowndp)
      DISPLAY BY NAME g_imay2_d[l_ac].imayowndp_desc

      LET g_imay2_d[l_ac].imaycrtid_desc = s_desc_get_person_desc(g_imay2_d[l_ac].imaycrtid)
      DISPLAY BY NAME g_imay2_d[l_ac].imaycrtid_desc

      LET g_imay2_d[l_ac].imaycrtdp_desc = s_desc_get_department_desc(g_imay2_d[l_ac].imaycrtdp)
      DISPLAY BY NAME g_imay2_d[l_ac].imaycrtdp_desc

      LET g_imay2_d[l_ac].imaymodid_desc = s_desc_get_person_desc(g_imay2_d[l_ac].imaymodid)
      DISPLAY BY NAME g_imay2_d[l_ac].imaymodid_desc
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL artm301_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="artm301.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION artm301_detail_show()
   #add-point:detail_show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point  
   #add-point:detail_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="detail_show.before"
   
   #end add-point
   
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="artm301.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION artm301_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE imaa_t.imaa001 
   DEFINE l_oldno     LIKE imaa_t.imaa001 
 
   DEFINE l_master    RECORD LIKE imaa_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE imay_t.* #此變數樣板目前無使用
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   
   LET g_master_insert = FALSE
   
   IF g_imaa_m.imaa001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_imaa001_t = g_imaa_m.imaa001
 
    
   LET g_imaa_m.imaa001 = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_imaa_m.imaastus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_imaa_m.imaastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
   
   
   CALL artm301_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_imaa_m.* TO NULL
      INITIALIZE g_imay_d TO NULL
      INITIALIZE g_imay2_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL artm301_show()
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code = 9001 
      LET g_errparam.popup = FALSE 
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL artm301_set_act_visible()   
   CALL artm301_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_imaa001_t = g_imaa_m.imaa001
 
   
   #組合新增資料的條件
   LET g_add_browse = " imaaent = " ||g_enterprise|| " AND",
                      " imaa001 = '", g_imaa_m.imaa001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL artm301_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL artm301_idx_chk()
   
   
   #功能已完成,通報訊息中心
   CALL artm301_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="artm301.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION artm301_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE imay_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE artm301_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM imay_t
    WHERE imayent = g_enterprise AND imay001 = g_imaa001_t
 
    INTO TEMP artm301_detail
 
   #將key修正為調整後   
   UPDATE artm301_detail 
      #更新key欄位
      SET imay001 = g_imaa_m.imaa001
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
       , imayownid = g_user 
       , imayowndp = g_dept
       , imaycrtid = g_user
       , imaycrtdp = g_dept 
       , imaycrtdt = ld_date
       , imaymodid = g_user
       , imaymoddt = ld_date
      #, imaystus = "Y" 
 
 
 
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO imay_t SELECT * FROM artm301_detail
   
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單身複製中1 name="detail_reproduce.body.table1.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE artm301_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_imaa001_t = g_imaa_m.imaa001
 
   
END FUNCTION
 
{</section>}
 
{<section id="artm301.delete" >}
#+ 資料刪除
PRIVATE FUNCTION artm301_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_imaa_m.imaa001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN artm301_cl USING g_enterprise,g_imaa_m.imaa001
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN artm301_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE artm301_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE artm301_master_referesh USING g_imaa_m.imaa001 INTO g_imaa_m.imaa001,g_imaa_m.imaa002,g_imaa_m.imaa108, 
       g_imaa_m.imaa100,g_imaa_m.imaa109,g_imaa_m.imaa014,g_imaa_m.imaa005,g_imaa_m.imaa006,g_imaa_m.imaa105, 
       g_imaa_m.imaa104,g_imaa_m.imaa107,g_imaa_m.imaa106,g_imaa_m.imaa145,g_imaa_m.imaa146,g_imaa_m.imaa113, 
       g_imaa_m.imaastus,g_imaa_m.imaa005_desc,g_imaa_m.imaa006_desc,g_imaa_m.imaa105_desc,g_imaa_m.imaa104_desc, 
       g_imaa_m.imaa107_desc,g_imaa_m.imaa106_desc,g_imaa_m.imaa145_desc,g_imaa_m.imaa146_desc
   
   
   #檢查是否允許此動作
   IF NOT artm301_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_imaa_m_mask_o.* =  g_imaa_m.*
   CALL artm301_imaa_t_mask()
   LET g_imaa_m_mask_n.* =  g_imaa_m.*
   
   CALL artm301_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL artm301_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_imaa001_t = g_imaa_m.imaa001
 
 
      DELETE FROM imaa_t
       WHERE imaaent = g_enterprise AND imaa001 = g_imaa_m.imaa001
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_imaa_m.imaa001,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM imay_t
       WHERE imayent = g_enterprise AND imay001 = g_imaa_m.imaa001
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imay_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_imaa_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE artm301_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_imay_d.clear() 
      CALL g_imay2_d.clear()       
 
     
      CALL artm301_ui_browser_refresh()  
      #CALL artm301_ui_headershow()  
      #CALL artm301_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL artm301_browser_fill("")
         CALL artm301_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE artm301_cl
 
   #功能已完成,通報訊息中心
   CALL artm301_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="artm301.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION artm301_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_imay_d.clear()
   CALL g_imay2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF artm301_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT imaystus,imay002,imay019,imay003,imay004,imay005,imay006,imay018, 
             imay007,imay008,imay009,imay015,imay010,imay016,imay011,imay017,imay012,imay013,imay014, 
             imay003,imayownid,imayowndp,imaycrtid,imaycrtdp,imaycrtdt,imaymodid,imaymoddt ,t1.oocal003 , 
             t2.oocal003 ,t3.oocal003 ,t4.oocal003 ,t5.ooag011 ,t6.ooefl003 ,t7.ooag011 ,t8.ooefl003 , 
             t9.ooag011 FROM imay_t",   
                     " INNER JOIN imaa_t ON imaaent = " ||g_enterprise|| " AND imaa001 = imay001 ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN oocal_t t1 ON t1.oocalent="||g_enterprise||" AND t1.oocal001=imay004 AND t1.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t2 ON t2.oocalent="||g_enterprise||" AND t2.oocal001=imay015 AND t2.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t3 ON t3.oocalent="||g_enterprise||" AND t3.oocal001=imay016 AND t3.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t4 ON t4.oocalent="||g_enterprise||" AND t4.oocal001=imay017 AND t4.oocal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=imayownid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=imayowndp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=imaycrtid  ",
               " LEFT JOIN ooefl_t t8 ON t8.ooeflent="||g_enterprise||" AND t8.ooefl001=imaycrtdp AND t8.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=imaymodid  ",
 
                     " WHERE imayent=? AND imay001=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY imay_t.imay003"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE artm301_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR artm301_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_imaa_m.imaa001   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_imaa_m.imaa001 INTO g_imay_d[l_ac].imaystus,g_imay_d[l_ac].imay002, 
          g_imay_d[l_ac].imay019,g_imay_d[l_ac].imay003,g_imay_d[l_ac].imay004,g_imay_d[l_ac].imay005, 
          g_imay_d[l_ac].imay006,g_imay_d[l_ac].imay018,g_imay_d[l_ac].imay007,g_imay_d[l_ac].imay008, 
          g_imay_d[l_ac].imay009,g_imay_d[l_ac].imay015,g_imay_d[l_ac].imay010,g_imay_d[l_ac].imay016, 
          g_imay_d[l_ac].imay011,g_imay_d[l_ac].imay017,g_imay_d[l_ac].imay012,g_imay_d[l_ac].imay013, 
          g_imay_d[l_ac].imay014,g_imay2_d[l_ac].imay003,g_imay2_d[l_ac].imayownid,g_imay2_d[l_ac].imayowndp, 
          g_imay2_d[l_ac].imaycrtid,g_imay2_d[l_ac].imaycrtdp,g_imay2_d[l_ac].imaycrtdt,g_imay2_d[l_ac].imaymodid, 
          g_imay2_d[l_ac].imaymoddt,g_imay_d[l_ac].imay004_desc,g_imay_d[l_ac].imay015_desc,g_imay_d[l_ac].imay016_desc, 
          g_imay_d[l_ac].imay017_desc,g_imay2_d[l_ac].imayownid_desc,g_imay2_d[l_ac].imayowndp_desc, 
          g_imay2_d[l_ac].imaycrtid_desc,g_imay2_d[l_ac].imaycrtdp_desc,g_imay2_d[l_ac].imaymodid_desc  
            #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         
         #end add-point
      
         IF l_ac > g_max_rec THEN
            IF g_error_show = 1 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = l_ac
               LET g_errparam.code = 9035 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
            END IF
            EXIT FOREACH
         END IF
         
         LET l_ac = l_ac + 1
      END FOREACH
      LET g_error_show = 0
   
   END IF
    
 
   
   #add-point:browser_fill段其他table處理 name="browser_fill.other_fill"
   
   #end add-point
   
   CALL g_imay_d.deleteElement(g_imay_d.getLength())
   CALL g_imay2_d.deleteElement(g_imay2_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE artm301_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_imay_d.getLength()
      LET g_imay_d_mask_o[l_ac].* =  g_imay_d[l_ac].*
      CALL artm301_imay_t_mask()
      LET g_imay_d_mask_n[l_ac].* =  g_imay_d[l_ac].*
   END FOR
   
   LET g_imay2_d_mask_o.* =  g_imay2_d.*
   FOR l_ac = 1 TO g_imay2_d.getLength()
      LET g_imay2_d_mask_o[l_ac].* =  g_imay2_d[l_ac].*
      CALL artm301_imay_t_mask()
      LET g_imay2_d_mask_n[l_ac].* =  g_imay2_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="artm301.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION artm301_delete_b(ps_table,ps_keys_bak,ps_page)
   #add-point:delete_b段define(客製用) name="delete_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:delete_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="delete_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1','2',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete"
      
      #end add-point    
      DELETE FROM imay_t
       WHERE imayent = g_enterprise AND
         imay001 = ps_keys_bak[1] AND imay003 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = ":",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_imay_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_imay2_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="artm301.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION artm301_insert_b(ps_table,ps_keys,ps_page)
   #add-point:insert_b段define(客製用) name="insert_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:insert_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="insert_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1','2',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert"
      
      #end add-point 
      INSERT INTO imay_t
                  (imayent,
                   imay001,
                   imay003
                   ,imaystus,imay002,imay019,imay004,imay005,imay006,imay018,imay007,imay008,imay009,imay015,imay010,imay016,imay011,imay017,imay012,imay013,imay014,imayownid,imayowndp,imaycrtid,imaycrtdp,imaycrtdt,imaymodid,imaymoddt) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_imay_d[g_detail_idx].imaystus,g_imay_d[g_detail_idx].imay002,g_imay_d[g_detail_idx].imay019, 
                       g_imay_d[g_detail_idx].imay004,g_imay_d[g_detail_idx].imay005,g_imay_d[g_detail_idx].imay006, 
                       g_imay_d[g_detail_idx].imay018,g_imay_d[g_detail_idx].imay007,g_imay_d[g_detail_idx].imay008, 
                       g_imay_d[g_detail_idx].imay009,g_imay_d[g_detail_idx].imay015,g_imay_d[g_detail_idx].imay010, 
                       g_imay_d[g_detail_idx].imay016,g_imay_d[g_detail_idx].imay011,g_imay_d[g_detail_idx].imay017, 
                       g_imay_d[g_detail_idx].imay012,g_imay_d[g_detail_idx].imay013,g_imay_d[g_detail_idx].imay014, 
                       g_imay2_d[g_detail_idx].imayownid,g_imay2_d[g_detail_idx].imayowndp,g_imay2_d[g_detail_idx].imaycrtid, 
                       g_imay2_d[g_detail_idx].imaycrtdp,g_imay2_d[g_detail_idx].imaycrtdt,g_imay2_d[g_detail_idx].imaymodid, 
                       g_imay2_d[g_detail_idx].imaymoddt)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imay_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_imay_d.insertElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_imay2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="artm301.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION artm301_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   #add-point:update_b段define(客製用) name="update_b.define_customerization"
   
   #end add-point   
   DEFINE ps_table         STRING
   DEFINE ps_page          STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num10 
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   #add-point:update_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="update_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="update_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE   
   
   #判斷key是否有改變
   LET lb_chk = TRUE
   FOR li_idx = 1 TO ps_keys.getLength()
      IF ps_keys[li_idx] <> ps_keys_bak[li_idx] THEN
         LET lb_chk = FALSE
         EXIT FOR
      END IF
   END FOR
   
   #不需要做處理
   IF lb_chk THEN
      RETURN
   END IF
   
   #判斷是否是同一群組的table
   LET ls_group = "'1','2',"
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "imay_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL artm301_imay_t_mask_restore('restore_mask_o')
               
      UPDATE imay_t 
         SET (imay001,
              imay003
              ,imaystus,imay002,imay019,imay004,imay005,imay006,imay018,imay007,imay008,imay009,imay015,imay010,imay016,imay011,imay017,imay012,imay013,imay014,imayownid,imayowndp,imaycrtid,imaycrtdp,imaycrtdt,imaymodid,imaymoddt) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_imay_d[g_detail_idx].imaystus,g_imay_d[g_detail_idx].imay002,g_imay_d[g_detail_idx].imay019, 
                  g_imay_d[g_detail_idx].imay004,g_imay_d[g_detail_idx].imay005,g_imay_d[g_detail_idx].imay006, 
                  g_imay_d[g_detail_idx].imay018,g_imay_d[g_detail_idx].imay007,g_imay_d[g_detail_idx].imay008, 
                  g_imay_d[g_detail_idx].imay009,g_imay_d[g_detail_idx].imay015,g_imay_d[g_detail_idx].imay010, 
                  g_imay_d[g_detail_idx].imay016,g_imay_d[g_detail_idx].imay011,g_imay_d[g_detail_idx].imay017, 
                  g_imay_d[g_detail_idx].imay012,g_imay_d[g_detail_idx].imay013,g_imay_d[g_detail_idx].imay014, 
                  g_imay2_d[g_detail_idx].imayownid,g_imay2_d[g_detail_idx].imayowndp,g_imay2_d[g_detail_idx].imaycrtid, 
                  g_imay2_d[g_detail_idx].imaycrtdp,g_imay2_d[g_detail_idx].imaycrtdt,g_imay2_d[g_detail_idx].imaymodid, 
                  g_imay2_d[g_detail_idx].imaymoddt) 
         WHERE imayent = g_enterprise AND imay001 = ps_keys_bak[1] AND imay003 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "imay_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "imay_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL artm301_imay_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
 
   
 
   
   #add-point:update_b段other name="update_b.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="artm301.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION artm301_key_update_b(ps_keys_bak,ps_table)
   #add-point:update_b段define(客製用) name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak       DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_table          STRING
   DEFINE l_field_key       DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak    DYNAMIC ARRAY OF STRING
   DEFINE l_new_key         DYNAMIC ARRAY OF STRING
   DEFINE l_old_key         DYNAMIC ARRAY OF STRING
   #add-point:update_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="artm301.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION artm301_key_delete_b(ps_keys_bak,ps_table)
   #add-point:delete_b段define(客製用) name="key_delete_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak       DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_table          STRING
   DEFINE l_field_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak    DYNAMIC ARRAY OF STRING
   DEFINE l_new_key         DYNAMIC ARRAY OF STRING
   DEFINE l_old_key         DYNAMIC ARRAY OF STRING
   #add-point:delete_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_delete_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_delete_b.pre_function"
   
   #end add-point
   
 
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="artm301.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION artm301_lock_b(ps_table,ps_page)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point   
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:lock_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
    
   #先刷新資料
   #CALL artm301_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1','2',"
   #僅鎖定自身table
   LET ls_group = "imay_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN artm301_bcl USING g_enterprise,
                                       g_imaa_m.imaa001,g_imay_d[g_detail_idx].imay003     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "artm301_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
 
   
 
   
   #add-point:lock_b段other name="lock_b.other"
   
   #end add-point  
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="artm301.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION artm301_unlock_b(ps_table,ps_page)
   #add-point:unlock_b段define(客製用) name="unlock_b.define_customerization"
   
   #end add-point  
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
    
   LET ls_group = "'1','2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE artm301_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="artm301.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION artm301_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("imaa001",TRUE)
      CALL cl_set_comp_entry("",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="artm301.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION artm301_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("imaa001",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="artm301.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION artm301_set_entry_b(p_cmd)
   #add-point:set_entry_b段define(客製用) name="set_entry_b.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_entry_b.pre_function"
   
   #end add-point
    
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("",TRUE)
      #add-point:set_entry段欄位控制 name="set_entry_b.field_control"
      
      #end add-point  
   END IF
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   CALL cl_set_comp_entry("imay003,imay005",TRUE)
   CALL cl_set_comp_entry("imay019",TRUE)   #160801-00017#1 20160803 add by beckxie
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="artm301.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION artm301_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point    
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="set_no_entry_b.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #add-point:set_no_entry_b段欄位控制 name="set_no_entry_b.field_control"
      
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b"
   IF p_cmd = 'u' THEN
      IF g_imay_d[l_ac].imay002 = '2' AND NOT cl_null(g_imay_d[l_ac].imay003) THEN
         CALL cl_set_comp_entry("imay005",FALSE)
      END IF
   END IF
   IF g_imay_d[l_ac].imay002 = '2' THEN
      CALL cl_set_comp_entry("imay003",FALSE)
   END IF
   IF p_cmd = 'u' THEN
      CALL cl_set_comp_entry("imay003",FALSE)
   END IF
   IF g_imay_d[l_ac].imay004 = g_imaa_m.imaa104 THEN
      CALL cl_set_comp_entry("imay005",FALSE)
   END IF
   #160801-00017#1 20160803 add by beckxie---S
   #料件不使用產品特徵時，產品特徵欄位不可錄入
   IF cl_null(g_imaa_m.imaa005) THEN
      CALL cl_set_comp_entry("imay019",FALSE)
   END IF
   #160801-00017#1 20160803 add by beckxie---E
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="artm301.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION artm301_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="artm301.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION artm301_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="artm301.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION artm301_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="artm301.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION artm301_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="artm301.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION artm301_default_search()
   #add-point:default_search段define(客製用) name="default_search.define_customerization"
   
   #end add-point  
   DEFINE li_idx     LIKE type_t.num10
   DEFINE li_cnt     LIKE type_t.num10
   DEFINE ls_wc      STRING
   DEFINE la_wc      DYNAMIC ARRAY OF RECORD
          tableid    STRING,
          wc         STRING
          END RECORD
   DEFINE ls_where   STRING
   #add-point:default_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="default_search.before"
   
   #end add-point  
   
   LET g_pagestart = 1
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " imaa001 = '", g_argv[01], "' AND "
   END IF
   
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
      #若無外部參數則預設為1=2
      LET g_default = FALSE
      
      #預設查詢條件
      CALL cl_qbe_get_default_qryplan() RETURNING ls_where
      IF NOT cl_null(ls_where) THEN
         CALL util.JSON.parse(ls_where, la_wc)
         INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "imaa_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "imay_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "EXTENDWC"
                  LET g_wc2_extend = la_wc[li_idx].wc
            END CASE
         END FOR
         IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
 
            OR NOT cl_null(g_wc2_extend)
            THEN
            #組合g_wc2
            IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
               LET g_wc2 = g_wc2_table1
            END IF
 
            IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
            END IF
         
            IF g_wc2.subString(1,5) = " AND " THEN
               LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
            END IF
         END IF
      END IF
    
      IF cl_null(g_wc) AND cl_null(g_wc2) THEN
         LET g_wc = " 1=2"
      END IF
   END IF
   
   #add-point:default_search段結束前 name="default_search.after"
   
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="artm301.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION artm301_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   RETURN
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_imaa_m.imaa001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN artm301_cl USING g_enterprise,g_imaa_m.imaa001
   IF STATUS THEN
      CLOSE artm301_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN artm301_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE artm301_master_referesh USING g_imaa_m.imaa001 INTO g_imaa_m.imaa001,g_imaa_m.imaa002,g_imaa_m.imaa108, 
       g_imaa_m.imaa100,g_imaa_m.imaa109,g_imaa_m.imaa014,g_imaa_m.imaa005,g_imaa_m.imaa006,g_imaa_m.imaa105, 
       g_imaa_m.imaa104,g_imaa_m.imaa107,g_imaa_m.imaa106,g_imaa_m.imaa145,g_imaa_m.imaa146,g_imaa_m.imaa113, 
       g_imaa_m.imaastus,g_imaa_m.imaa005_desc,g_imaa_m.imaa006_desc,g_imaa_m.imaa105_desc,g_imaa_m.imaa104_desc, 
       g_imaa_m.imaa107_desc,g_imaa_m.imaa106_desc,g_imaa_m.imaa145_desc,g_imaa_m.imaa146_desc
   
 
   #檢查是否允許此動作
   IF NOT artm301_action_chk() THEN
      CLOSE artm301_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_imaa_m.imaa001,g_imaa_m.imaa002,g_imaa_m.imaal003,g_imaa_m.imaal004,g_imaa_m.imaa108, 
       g_imaa_m.imaa100,g_imaa_m.imaa109,g_imaa_m.imaa014,g_imaa_m.imaa005,g_imaa_m.imaa005_desc,g_imaa_m.imaa006, 
       g_imaa_m.imaa006_desc,g_imaa_m.imaa105,g_imaa_m.imaa105_desc,g_imaa_m.imaa104,g_imaa_m.imaa104_desc, 
       g_imaa_m.imaa107,g_imaa_m.imaa107_desc,g_imaa_m.imaa106,g_imaa_m.imaa106_desc,g_imaa_m.imaa145, 
       g_imaa_m.imaa145_desc,g_imaa_m.imaa146,g_imaa_m.imaa146_desc,g_imaa_m.imaa113,g_imaa_m.imaastus 
 
 
   CASE g_imaa_m.imaastus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_imaa_m.imaastus
            
            WHEN "N"
               HIDE OPTION "open"
            WHEN "Y"
               HIDE OPTION "valid"
            WHEN "X"
               HIDE OPTION "void"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      
      #end add-point
      
      
	  
      ON ACTION open
         IF cl_auth_chk_act("open") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.open"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION valid
         IF cl_auth_chk_act("valid") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.valid"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION void
         IF cl_auth_chk_act("void") THEN
            LET lc_state = "X"
            #add-point:action控制 name="statechange.void"
            
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
      
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      AND lc_state <> "X"
      ) OR 
      g_imaa_m.imaastus = lc_state OR cl_null(lc_state) THEN
      CLOSE artm301_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   
   #end add-point
   
   LET g_imaa_m.imaastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE imaa_t 
      SET (imaastus) 
        = (g_imaa_m.imaastus)     
    WHERE imaaent = g_enterprise AND imaa001 = g_imaa_m.imaa001
 
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE artm301_master_referesh USING g_imaa_m.imaa001 INTO g_imaa_m.imaa001,g_imaa_m.imaa002, 
          g_imaa_m.imaa108,g_imaa_m.imaa100,g_imaa_m.imaa109,g_imaa_m.imaa014,g_imaa_m.imaa005,g_imaa_m.imaa006, 
          g_imaa_m.imaa105,g_imaa_m.imaa104,g_imaa_m.imaa107,g_imaa_m.imaa106,g_imaa_m.imaa145,g_imaa_m.imaa146, 
          g_imaa_m.imaa113,g_imaa_m.imaastus,g_imaa_m.imaa005_desc,g_imaa_m.imaa006_desc,g_imaa_m.imaa105_desc, 
          g_imaa_m.imaa104_desc,g_imaa_m.imaa107_desc,g_imaa_m.imaa106_desc,g_imaa_m.imaa145_desc,g_imaa_m.imaa146_desc 
 
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_imaa_m.imaa001,g_imaa_m.imaa002,g_imaa_m.imaal003,g_imaa_m.imaal004,g_imaa_m.imaa108, 
          g_imaa_m.imaa100,g_imaa_m.imaa109,g_imaa_m.imaa014,g_imaa_m.imaa005,g_imaa_m.imaa005_desc, 
          g_imaa_m.imaa006,g_imaa_m.imaa006_desc,g_imaa_m.imaa105,g_imaa_m.imaa105_desc,g_imaa_m.imaa104, 
          g_imaa_m.imaa104_desc,g_imaa_m.imaa107,g_imaa_m.imaa107_desc,g_imaa_m.imaa106,g_imaa_m.imaa106_desc, 
          g_imaa_m.imaa145,g_imaa_m.imaa145_desc,g_imaa_m.imaa146,g_imaa_m.imaa146_desc,g_imaa_m.imaa113, 
          g_imaa_m.imaastus
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE artm301_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL artm301_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="artm301.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION artm301_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_imay_d.getLength() THEN
         LET g_detail_idx = g_imay_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_imay_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_imay_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_imay2_d.getLength() THEN
         LET g_detail_idx = g_imay2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_imay2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_imay2_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="artm301.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION artm301_b_fill2(pi_idx)
   #add-point:b_fill2段define(客製用) name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx                 LIKE type_t.num10
   DEFINE li_ac                  LIKE type_t.num10
   DEFINE li_detail_idx_tmp      LIKE type_t.num10
   DEFINE ls_chk                 LIKE type_t.chr1
   #add-point:b_fill2段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_detail_idx <= 0 THEN
      RETURN
   END IF
   
   LET li_detail_idx_tmp = g_detail_idx
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
   CALL artm301_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="artm301.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION artm301_fill_chk(ps_idx)
   #add-point:fill_chk段define(客製用) name="fill_chk.define_customerization"
   
   #end add-point
   DEFINE ps_idx        LIKE type_t.chr10
   #add-point:fill_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fill_chk.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="fill_chk.before_chk"
   
   #end add-point
   
   #此funtion功能暫時停用(2015/1/12)
   #無論傳入值為何皆回傳true(代表要填充該單身)
 
   #全部為1=1 or null時回傳true
   IF (cl_null(g_wc2_table1) OR g_wc2_table1.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk name="fill_chk.other_chk"
      
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk name="fill_chk.after_chk"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="artm301.status_show" >}
PRIVATE FUNCTION artm301_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="artm301.mask_functions" >}
&include "erp/art/artm301_mask.4gl"
 
{</section>}
 
{<section id="artm301.signature" >}
   
 
{</section>}
 
{<section id="artm301.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION artm301_set_pk_array()
   #add-point:set_pk_array段define name="set_pk_array.define_customerization"
   
   #end add-point
   #add-point:set_pk_array段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_pk_array.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="set_pk_array.before"
   
   #end add-point  
   
   #若l_ac<=0代表沒有資料
   IF l_ac <= 0 THEN
      RETURN
   END IF
   
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_imaa_m.imaa001
   LET g_pk_array[1].column = 'imaa001'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="artm301.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="artm301.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION artm301_msgcentre_notify(lc_state)
   #add-point:msgcentre_notify段define name="msgcentre_notify.define_customerization"
   
   #end add-point   
   DEFINE lc_state LIKE type_t.chr80
   #add-point:msgcentre_notify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="msgcentre_notify.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="msgcentre_notify.pre_function"
   
   #end add-point
   
   INITIALIZE g_msgparam TO NULL
 
   #action-id與狀態填寫
   LET g_msgparam.state = lc_state
 
   #PK資料填寫
   CALL artm301_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_imaa_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="artm301.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION artm301_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="artm301.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 條碼重複檢查
# Memo...........:
# Usage..........: CALL artm301_chk_barcode(p_barcode)
# Input parameter: p_barcode   條碼
# Date & Author..: 2014/06/18 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION artm301_chk_barcode(p_barcode)
   DEFINE p_barcode  LIKE imaa_t.imaa014
   DEFINE l_cnt      LIKE type_t.num5

   LET g_errno = ''
   LET l_cnt = 0
   
   SELECT COUNT(*) INTO l_cnt FROM imay_t
    WHERE imayent = g_enterprise
      AND imay001 != g_imaa_m.imaa001
      AND imay003 = p_barcode
   
   IF l_cnt > 0 THEN
      LET g_errno = 'art-00032'
   END IF
END FUNCTION

################################################################################
# Descriptions...: 依包裝單位帶值
# Usage..........: CALL artm301_imay005_default()
# Date & Author..: 2014/06/18 By Lori
################################################################################
PRIVATE FUNCTION artm301_imay005_default()
   DEFINE l_unit_o   LIKE imay_t.imay003
   DEFINE l_num_o    LIKE imay_t.imay004
   DEFINE l_unit_t   LIKE imay_t.imay003
   DEFINE l_num_t    LIKE imay_t.imay004
   
   IF g_imay_d[l_ac].imay004 = g_imaa_m.imaa105 THEN
      LET g_imay_d[l_ac].imay005 = 1
      RETURN
   END IF
   
   LET g_imay_d[l_ac].imay014 = g_imaa_m.imaa104

   LET l_unit_o = ''   LET l_num_o = ''
   LET l_unit_t = ''   LET l_num_t = ''
   
   SELECT imad002,imad003,imad004,imad005
     INTO l_unit_o,l_num_o,l_unit_t,l_num_t
     FROM imad_t
    WHERE imadent = g_enterprise
      AND imad001 = g_imaa_m.imaa001
      AND imad002 = g_imaa_m.imaa104
      AND imad004 = g_imay_d[l_ac].imay004
      AND imadstus = 'Y'
   IF SQLCA.sqlcode = 100 THEN
      LET l_unit_o = ''   LET l_num_o = ''
      LET l_unit_t = ''   LET l_num_t = ''
      SELECT imad002,imad003,imad004,imad005
        INTO l_unit_t,l_num_t,l_unit_o,l_num_o
        FROM imad_t
       WHERE imadent = g_enterprise
         AND imad001 = g_imaa_m.imaa001
         AND imad002 = g_imay_d[l_ac].imay004
         AND imad004 = g_imaa_m.imaa104
         AND imadstus = 'Y'
   END IF
   
   IF NOT cl_null(l_unit_o) AND NOT cl_null(l_num_o) AND
      NOT cl_null(l_unit_t) AND NOT cl_null(l_num_t) THEN
      LET l_num_o = l_num_o / l_num_t
      LET g_imay_d[l_ac].imay005 = l_num_o
   END IF   
END FUNCTION

################################################################################
# Descriptions...: 主要條碼校驗
# Memo...........:
# Usage..........: CALL artm301_imay006_chk()
#                  RETURNING r_success,r_upd_imaa014
# Return code....: r_success      校驗結果
#                  r_upd_imaa014  是否更新料件主檔的產品條碼  
# Date & Author..: 2014 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION artm301_imay006_chk()
   DEFINE r_success      LIKE type_t.num5
   DEFINE r_upd_imaa014  LIKE type_t.chr1
   DEFINE l_m_barcode    LIKE imay_t.imay003
   DEFINE l_i            LIKE type_t.num5
   
   LET r_success = TRUE
   LET r_upd_imaa014 = 'N'
   LET l_m_barcode = NULL
   
   IF g_imay_d[l_ac].imay006 = 'Y' THEN
       IF g_imay_d[l_ac].imaystus = 'N' THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'art-00033'
         LET g_errparam.extend = g_imay_d[l_ac].imay006
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET g_imay_d[l_ac].imay006 = 'N'
         LET r_success = FALSE
         RETURN r_success,r_upd_imaa014 
      END IF

      IF g_imay_d[l_ac].imay004 <> g_imaa_m.imaa104 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.columns[1] = "lbl_imay004"
         LET g_errparam.values[1] = g_imay_d[l_ac].imay004
         LET g_errparam.columns[2] = "lbl_imaa104"
         LET g_errparam.values[2] = g_imaa_m.imaa104
         LET g_errparam.code   = "art-00401" 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         
         LET g_imay_d[l_ac].imay006 = 'N'
         LET r_success = FALSE
         RETURN r_success,r_upd_imaa014          
      END IF

      SELECT imay003 INTO l_m_barcode
        FROM imay_t
       WHERE imayent = g_enterprise
         AND imay001 = g_imaa_m.imaa001
         AND imay006 = 'Y'
         AND imaystus = 'Y'
      
      IF cl_null(l_m_barcode) 
         OR (NOT cl_null(l_m_barcode) AND g_imay_d[l_ac].imay003 <> l_m_barcode) THEN
         IF cl_ask_confirm('art-00026') THEN
            UPDATE imay_t SET imay006 = 'N'
             WHERE imay001 = g_imaa_m.imaa001
               AND imay003 != g_imay_d[l_ac].imay003
               AND imay006 = 'Y'
               AND imayent = g_enterprise
            FOR l_i = 1 TO g_imay_d.getLength()
               IF l_i != l_ac THEN
                  LET g_imay_d[l_i].imay006 = 'N'
               END IF
            END FOR
                     
            LET g_imaa_m.imaa014 = g_imay_d[l_ac].imay003
            DISPLAY BY NAME g_imaa_m.imaa014
            LET r_upd_imaa014 = 'Y'
         ELSE
            LET g_imay_d[l_ac].imay006 = 'N'
         END IF         
      END IF
   #ELSE
   #   IF g_imay_d.getLength() = 1 AND g_imay_d_t.imay006 = 'Y' THEN
   #      INITIALIZE g_errparam TO NULL
   #      LET g_errparam.code = 'art-00396'
   #      LET g_errparam.extend = ''
   #      LET g_errparam.popup = TRUE
   #      CALL cl_err()
   #
   #      LET g_imay_d[l_ac].imay006 = 'Y'
   #   END IF
   END IF
   
   RETURN r_success,r_upd_imaa014 
END FUNCTION

################################################################################
# Descriptions...: 依包裝單位和銷售計價單位取換算率
# Memo...........:
# Usage..........: CALL artm301_imay013_default()
#                     RETURNING r_success
# Return Code....: r_success
# Date & Author..: 2014/06/18 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION artm301_imay013_default()
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_rate        LIKE inaj_t.inaj014
   DEFINE l_success     LIKE type_t.num5

   LET r_success = TRUE
   LET l_rate = ''

   LET l_success = TRUE
   IF g_imay_d[l_ac].imay004 = g_imaa_m.imaa106 THEN
      LET g_imay_d[l_ac].imay013 = 1
      RETURN r_success
   END IF

   CALL s_aimi190_get_convert(g_imaa_m.imaa001,g_imay_d[l_ac].imay004,g_imaa_m.imaa106)
      RETURNING l_success,l_rate

   IF l_success THEN
      LET g_imay_d[l_ac].imay013 = l_rate
   ELSE
      LET r_success = FALSE
      LET g_imay_d[l_ac].imay013 = g_imay_d_t.imay013
   END IF

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 更新料件主檔的產品條碼
# Memo...........:
# Usage..........: CALL artm301_upd_imaa014(p_upd_imaa014)
#                  RETURNING r_success
# Input parameter: p_upd_imaa014   是否更新料件主檔的產品條碼
# Return code....: r_success       更新狀態
# Date & Author..: 2014/06/18 By Lori
# Modify.........: 2015/01/27 By Ken 新增更新傳秤因子imaa113
################################################################################
PRIVATE FUNCTION artm301_upd_imaa014(p_upd_imaa014)
   DEFINE p_upd_imaa014   LIKE type_t.chr1
   DEFINE r_success       LIKE type_t.num5
   
   LET r_success = TRUE
   
   IF p_upd_imaa014 = 'Y' THEN
      UPDATE imaa_t
         SET imaa014 = g_imaa_m.imaa014,                 #主條碼
             imaa019 = g_imay_d[g_detail_idx].imay007,   #深
             imaa020 = g_imay_d[g_detail_idx].imay008,   #寬
             imaa021 = g_imay_d[g_detail_idx].imay009,   #高
             imaa022 = g_imay_d[g_detail_idx].imay015,   #長度單位
             imaa025 = g_imay_d[g_detail_idx].imay010,   #體積
             imaa026 = g_imay_d[g_detail_idx].imay016,   #體積單位
             imaa016 = g_imay_d[g_detail_idx].imay011,   #毛重
             imaa018 = g_imay_d[g_detail_idx].imay017,    #重量單位
             imaa113 = g_imay_d[g_detail_idx].imay018    #傳秤因子  #ken---add 141224-00014#3 
       WHERE imaaent = g_enterprise
         AND imaa001 = g_imaa_m.imaa001
      IF SQLCA.sqlcode THEN
         LET r_success = FALSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'Update imaa_t:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF      
      LET g_imaa_m.imaa113 = g_imay_d[g_detail_idx].imay018
      DISPLAY BY NAME g_imaa_m.imaa113
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 檢查是否有多條碼的包裝單位已相同
# Memo...........:
# Usage..........: CALL artm301_imay005_chk()
#                  RETURNING r_success,l_imay005
# Input parameter: 
# Return code....: r_success       TRUE/FALSE
#                  l_imay005       件裝數
# Date & Author..: 2015/06/02 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION artm301_imay005_chk()
DEFINE l_cnt        LIKE type_t.num5 
DEFINE l_imay005    LIKE imay_t.imay005
DEFINE r_success    LIKE type_t.num5

   LET l_imay005 = 0
   LET l_cnt = 0
   LET r_success = FALSE
   SELECT COUNT(*) INTO l_cnt 
     FROM imay_t
    WHERE imayent = g_enterprise
      AND imay001 = g_imaa_m.imaa001
      AND imay004 = g_imay_d[l_ac].imay004      
      
   IF l_cnt != 0 THEN
      SELECT DISTINCT imay005 INTO l_imay005
        FROM imay_t
       WHERE imayent = g_enterprise
         AND imay001 = g_imaa_m.imaa001
         AND imay004 = g_imay_d[l_ac].imay004       
      LET r_success = TRUE
   END IF
   
   RETURN r_success,l_imay005 
END FUNCTION

################################################################################
# Descriptions...: 檢查多條碼中的包裝單位是否已存在，且輸入的件裝數不等於已存在的件裝數
# Memo...........:
# Usage..........: CALL artm301_imay005_chk_1()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2015/06/03 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION artm301_imay005_chk_1()
DEFINE l_cnt        LIKE type_t.num5 
DEFINE r_success    LIKE type_t.num5

   LET l_cnt = 0
   LET r_success = TRUE
   SELECT COUNT(*) INTO l_cnt 
     FROM imay_t
    WHERE imayent = g_enterprise
      AND imay001 = g_imaa_m.imaa001
      AND imay004 = g_imay_d[l_ac].imay004 
      AND imay005!= g_imay_d[l_ac].imay005      
      AND COALESCE(imay003,'-1') != COALESCE(g_imay_d[l_ac].imay003,'-1')   ##150703 pomelo add      
   IF l_cnt != 0 THEN     
      LET r_success = FALSE
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 欄位顯示
# Memo...........: #160801-00017#1 20160803 add by beckxie
# Usage..........: CALL artm301_set_comp_visible_b()
# Date & Author..: 20160803 add by beckxie
# Modify.........:   
################################################################################
PRIVATE FUNCTION artm301_set_comp_visible_b()
   CALL cl_set_comp_visible("imay019,imay019_desc",TRUE)   #160801-00017#1 20160803 add by beckxie
END FUNCTION

################################################################################
# Descriptions...: 欄位顯示
# Memo...........: #160801-00017#1 20160803 add by beckxie
# Usage..........: CALL artm301_set_comp_no_visible_b()
# Date & Author..: 20160803 add by beckxie
# Modify.........:   
################################################################################
PRIVATE FUNCTION artm301_set_comp_no_visible_b()
   #160801-00017#1 20160803 add by beckxie---S
   #判斷據點參數若不使用產品特徵時，則產品特徵需隱藏不可以維護(據點參數:S-BAS-0036)
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'N' THEN
      CALL cl_set_comp_visible("imay019,imay019_desc",FALSE)
   END IF
   #160801-00017#1 20160803 add by beckxie---E
END FUNCTION

################################################################################
# Descriptions...: 設定欄位為必填
# Memo...........: #160801-00017#1 20160803 add by beckxie
# Usage..........: CALL artm301_set_required_b(p_cmd)
# Date & Author..: 20160803 add by beckxie
# Modify.........:
################################################################################
PRIVATE FUNCTION artm301_set_required_b(p_cmd)
   #160801-00017#1 20160803 add by beckxie---S
   DEFINE p_cmd   LIKE type_t.chr1
   IF l_ac > 0 THEN
      #IF (NOT cl_null(g_imaa_m.imaa005)) AND g_imay_d[l_ac].imay002 = '3' THEN   #160822-00036#4 20160824 mark by beckxie
      IF (NOT cl_null(g_imaa_m.imaa005)) AND g_imay_d[l_ac].imay002 = '3'   #160822-00036#4 20160824 add by beckxie
          AND cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'Y' THEN      #160822-00036#4 20160824 add by beckxie
         CALL cl_set_comp_required("imay019",TRUE)
      END IF
   END IF
   #160801-00017#1 20160803 add by beckxie---E
END FUNCTION

################################################################################
# Descriptions...: 設定欄位不為必填
# Memo...........: #160801-00017#1 20160803 add by beckxie
# Usage..........: CALL artm301_set_no_required_b(p_cmd)
# Date & Author..: 20160803 add by beckxie
# Modify.........:
################################################################################
PRIVATE FUNCTION artm301_set_no_required_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1
   CALL cl_set_comp_required("imay019",FALSE)   #160801-00017#1 20160803 add by beckxie
END FUNCTION

 
{</section>}
 
