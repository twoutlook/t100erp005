#該程式未解開Section, 採用最新樣板產出!
{<section id="ammt404.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0022(2016-03-14 19:06:52), PR版次:0022(2016-11-23 18:31:49)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000622
#+ Filename...: ammt404
#+ Description: 會員卡調撥維護作業
#+ Creator....: 02296(2013-08-27 10:23:30)
#+ Modifier...: 02003 -SD/PR- 02159
 
{</section>}
 
{<section id="ammt404.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160318-00005#24  2016/03/30 by 07675   將重複內容的錯誤訊息置換為公用錯誤訊息
#160517-00020#1   2016/05/23 by 08172   核准申请数量报错信息修改
#160524-00053#1   2016/05/25 by 07959   无领用申请单的调拨资料，核准申请数量手动输入，控管不可输入负数和0。
#160604-00009#52  2016/06/20 by 08172   过账位置修改
#160604-00009#50  2016/07/22 by 08172   库区预设值
#160816-00068#6   2016/08/16 By earl    調整transaction
#160818-00017#22  2016/08/24 By 08742   删除修改未重新判断状态码
#160728-00006#37  2016/08/29 by 08172   如果=0.不管库存，不检查卡/券库存是否足够
#160905-00007#6   2016/09/05 By 02599   SQL条件增加ent
#161024-00025#7   2016/10/24 by 08742   组织开窗调整
#161024-00025#11  2016/10/28 by 08742   组织开窗调整
#161115-00015#2   2016/11/15 by 08172   单身2录入卡号，检查卡号范围的sql，加上卡种/券种
#160824-00007#122 2016/11/23 By sakura  新舊值備份處理
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
PRIVATE type type_g_mmba_m        RECORD
       mmbasite LIKE mmba_t.mmbasite, 
   mmbasite_desc LIKE type_t.chr80, 
   mmbadocdt LIKE mmba_t.mmbadocdt, 
   mmbadocno LIKE mmba_t.mmbadocno, 
   mmbaunit LIKE mmba_t.mmbaunit, 
   mmba000 LIKE mmba_t.mmba000, 
   mmbastus LIKE mmba_t.mmbastus, 
   mmbaownid LIKE mmba_t.mmbaownid, 
   mmbaownid_desc LIKE type_t.chr80, 
   mmbaowndp LIKE mmba_t.mmbaowndp, 
   mmbaowndp_desc LIKE type_t.chr80, 
   mmbacrtid LIKE mmba_t.mmbacrtid, 
   mmbacrtid_desc LIKE type_t.chr80, 
   mmbacrtdp LIKE mmba_t.mmbacrtdp, 
   mmbacrtdp_desc LIKE type_t.chr80, 
   mmbacrtdt LIKE mmba_t.mmbacrtdt, 
   mmbamodid LIKE mmba_t.mmbamodid, 
   mmbamodid_desc LIKE type_t.chr80, 
   mmbamoddt LIKE mmba_t.mmbamoddt, 
   mmbacnfid LIKE mmba_t.mmbacnfid, 
   mmbacnfid_desc LIKE type_t.chr80, 
   mmbacnfdt LIKE mmba_t.mmbacnfdt, 
   mmbapstid LIKE mmba_t.mmbapstid, 
   mmbapstid_desc LIKE type_t.chr80, 
   mmbapstdt LIKE mmba_t.mmbapstdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_mmbb_d        RECORD
       mmbbseq LIKE mmbb_t.mmbbseq, 
   mmbbsite LIKE mmbb_t.mmbbsite, 
   mmbbsite_desc LIKE type_t.chr500, 
   mmbb002 LIKE mmbb_t.mmbb002, 
   mmbb002_desc LIKE type_t.chr500, 
   mmbb003 LIKE mmbb_t.mmbb003, 
   mmbb003_desc LIKE type_t.chr500, 
   mmbb004 LIKE mmbb_t.mmbb004, 
   mmbb004_desc LIKE type_t.chr500, 
   mmbb001 LIKE mmbb_t.mmbb001, 
   mmbb001_desc LIKE type_t.chr500, 
   mmbb005 LIKE mmbb_t.mmbb005, 
   mmbb006 LIKE mmbb_t.mmbb006, 
   mmbb007 LIKE mmbb_t.mmbb007, 
   mmbb008 LIKE mmbb_t.mmbb008, 
   mmbbunit LIKE mmbb_t.mmbbunit, 
   mmbb000 LIKE mmbb_t.mmbb000
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_mmbadocno LIKE mmba_t.mmbadocno,
      b_mmbadocdt LIKE mmba_t.mmbadocdt,
      b_mmbasite LIKE mmba_t.mmbasite,
   b_mmbasite_desc LIKE type_t.chr80
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_ooef004             LIKE ooef_t.ooef004
DEFINE g_wc_table2           STRING                        #第2個單身table所使用的g_wc2
PRIVATE TYPE type_g_mmbc_d        RECORD
       mmbcseq like mmbc_t.mmbcseq, 
       mmbcseq1 LIKE mmbc_t.mmbcseq1, 
       mmbc001 LIKE mmbc_t.mmbc001,  
       mmbc002 LIKE mmbc_t.mmbc002, 
       mmbc003 LIKE mmbc_t.mmbc003,
       mmbcsite like mmbc_t.mmbcsite,
       mmbcunit like mmbc_t.mmbcunit,
       mmbc000 like mmbc_t.mmbc000
       END RECORD
DEFINE g_mmbc_d          DYNAMIC ARRAY OF type_g_mmbc_d
DEFINE g_mmbc_d_t        type_g_mmbc_d       
DEFINE g_mmbc_d_o        type_g_mmbc_d   #160824-00007#122 by sakura add
DEFINE g_wc3             STRING
DEFINE g_rec_b2          LIKE type_t.num5           
DEFINE l_ac2             LIKE type_t.num5
DEFINE g_ac_t            like type_t.num5 
DEFINE g_type            LIKE type_t.chr1   #'1'時代表是 會員卡調撥維護作業  '2'時代表是 會員券調撥維護作業
DEFINE g_ins_site_flag   LIKE type_t.chr1   #161024-00025#7  2016/10/25  by 08742  add
#end add-point
       
#模組變數(Module Variables)
DEFINE g_mmba_m          type_g_mmba_m
DEFINE g_mmba_m_t        type_g_mmba_m
DEFINE g_mmba_m_o        type_g_mmba_m
DEFINE g_mmba_m_mask_o   type_g_mmba_m #轉換遮罩前資料
DEFINE g_mmba_m_mask_n   type_g_mmba_m #轉換遮罩後資料
 
   DEFINE g_mmbadocno_t LIKE mmba_t.mmbadocno
 
 
DEFINE g_mmbb_d          DYNAMIC ARRAY OF type_g_mmbb_d
DEFINE g_mmbb_d_t        type_g_mmbb_d
DEFINE g_mmbb_d_o        type_g_mmbb_d
DEFINE g_mmbb_d_mask_o   DYNAMIC ARRAY OF type_g_mmbb_d #轉換遮罩前資料
DEFINE g_mmbb_d_mask_n   DYNAMIC ARRAY OF type_g_mmbb_d #轉換遮罩後資料
 
 
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
 
{<section id="ammt404.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5      #150308-00001#4  By benson 150309      
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("amm","")
 
   #add-point:作業初始化 name="main.init"
            IF NOT cl_null(g_argv[1]) THEN
      LET g_type = g_argv[1]
   END IF
   SELECT ooef004 INTO g_ooef004 FROM ooef_t WHERE ooef001 = g_site AND ooefent = g_enterprise
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
         
   #end add-point
   LET g_forupd_sql = " SELECT mmbasite,'',mmbadocdt,mmbadocno,mmbaunit,mmba000,mmbastus,mmbaownid,'', 
       mmbaowndp,'',mmbacrtid,'',mmbacrtdp,'',mmbacrtdt,mmbamodid,'',mmbamoddt,mmbacnfid,'',mmbacnfdt, 
       mmbapstid,'',mmbapstdt", 
                      " FROM mmba_t",
                      " WHERE mmbaent= ? AND mmbadocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
         
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE ammt404_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.mmbasite,t0.mmbadocdt,t0.mmbadocno,t0.mmbaunit,t0.mmba000,t0.mmbastus, 
       t0.mmbaownid,t0.mmbaowndp,t0.mmbacrtid,t0.mmbacrtdp,t0.mmbacrtdt,t0.mmbamodid,t0.mmbamoddt,t0.mmbacnfid, 
       t0.mmbacnfdt,t0.mmbapstid,t0.mmbapstdt,t1.ooefl003 ,t2.ooag011 ,t3.ooefl003 ,t4.ooag011 ,t5.ooefl003 , 
       t6.ooag011 ,t7.ooag011 ,t8.ooag011",
               " FROM mmba_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.mmbasite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.mmbaownid  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.mmbaowndp AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.mmbacrtid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.mmbacrtdp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.mmbamodid  ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.mmbacnfid  ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.mmbapstid  ",
 
               " WHERE t0.mmbaent = " ||g_enterprise|| " AND t0.mmbadocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE ammt404_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
                  
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_ammt404 WITH FORM cl_ap_formpath("amm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL ammt404_init()   
 
      #進入選單 Menu (="N")
      CALL ammt404_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
                  
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_ammt404
      
   END IF 
   
   CLOSE ammt404_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success      #150308-00001#4  By benson 150309      
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="ammt404.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION ammt404_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   define l_msg     like gzze_t.gzze003
   DEFINE l_success LIKE type_t.num5      #150308-00001#4  By benson 150309
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill       = "Y"
   LET g_detail_idx  = 1 #第一層單身指標
   LET g_detail_idx2 = 1 #第二層單身指標
   
   #各個page指標
   LET g_detail_idx_list[1] = 1 
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('mmbastus','13','N,Y,S,A,D,R,W,X')
 
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
            IF g_type='2' THEN
      LET l_msg = null
      SELECT gzze003 INTO l_msg FROM gzze_t WHERE gzze001 = 'agc-00031'
        AND gzze002 = g_dlang AND gzzestus = 'Y'
      CALL cl_set_comp_att_text("mmbb001",l_msg)         
      LET l_msg = null
      SELECT gzze003 INTO l_msg FROM gzze_t WHERE gzze001 = 'agc-00032'
        AND gzze002 = g_dlang AND gzzestus = 'Y'
      CALL cl_set_comp_att_text("mmbb001_desc",l_msg)
      LET l_msg = null
      SELECT gzze003 INTO l_msg FROM gzze_t WHERE gzze001 = 'agc-00036'
        AND gzze002 = g_dlang AND gzzestus = 'Y'
      CALL cl_set_comp_att_text("mmbc001",l_msg)
      LET l_msg = null
      SELECT gzze003 INTO l_msg FROM gzze_t WHERE gzze001 = 'agc-00037'
        AND gzze002 = g_dlang AND gzzestus = 'Y'
      CALL cl_set_comp_att_text("mmbc002",l_msg)
      LET l_msg = null
      SELECT gzze003 INTO l_msg FROM gzze_t WHERE gzze001 = 'agc-00040'
        AND gzze002 = g_dlang AND gzzestus = 'Y'
      CALL cl_set_comp_att_text("bpage_1",l_msg)
      LET l_msg = null
      SELECT gzze003 INTO l_msg FROM gzze_t WHERE gzze001 = 'agc-00041'
        AND gzze002 = g_dlang AND gzzestus = 'Y'
      CALL cl_set_comp_att_text("bpage_2",l_msg)
   END IF
   CALL cl_set_comp_visible("mmbcseq",false) 
   CALL s_aooi500_create_temp() RETURNING l_success    #150308-00001#4  By benson 150309
   #end add-point
   
   #初始化搜尋條件
   CALL ammt404_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="ammt404.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION ammt404_ui_dialog()
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
 
   #因應查詢方案進行處理
   IF g_default THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   ELSE
      CALL gfrm_curr.setElementHidden("mainlayout",1)
      CALL gfrm_curr.setElementHidden("worksheet",0)
      LET g_main_hidden = 1
   END IF
   
   #action default動作
   #應用 a42 樣板自動產生(Version:3)
   #進入程式時預設執行的動作
   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL ammt404_insert()
            #add-point:ON ACTION insert name="menu.default.insert"
                                    
            #END add-point
         END IF
 
      #add-point:action default自訂 name="ui_dialog.action_default"
                  
      #end add-point
      OTHERWISE
   END CASE
 
 
 
   
   LET lb_first = TRUE
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
         
   #end add-point
   
   WHILE TRUE 
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_mmba_m.* TO NULL
         CALL g_mmbb_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL ammt404_init()
      END IF
   
      CALL lib_cl_dlg.cl_dlg_before_display()
            
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
         #左側瀏覽頁簽
         DISPLAY ARRAY g_browser TO s_browse.* ATTRIBUTES(COUNT=g_header_cnt)
            BEFORE ROW
               #回歸舊筆數位置 (回到當時異動的筆數)
               LET g_current_idx = DIALOG.getCurrentRow("s_browse")
               IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
                  CALL DIALOG.setCurrentRow("s_browse",g_current_row)
                  LET g_current_idx = g_current_row
               END IF
               LET g_current_row = g_current_idx #目前指標
               LET g_current_sw = TRUE
         
               IF g_current_idx > g_browser.getLength() THEN
                  LET g_current_idx = g_browser.getLength()
               END IF 
               
               CALL ammt404_fetch('') # reload data
               LET l_ac = 1
               CALL ammt404_ui_detailshow() #Setting the current row 
         
               CALL ammt404_idx_chk()
               #NEXT FIELD mmbbseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_mmbb_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL ammt404_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1',",l_ac)
               
               #add-point:page1, before row動作 name="ui_dialog.page1.before_row"
                                                            IF NOT cl_null(l_ac) OR l_ac=0 THEN
                  CALL ammt404_b_fill_2()
               END IF    
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
               #顯示單身筆數
               CALL ammt404_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
                                             
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
                                    
            #end add-point
               
         END DISPLAY
        
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
                                    DISPLAY ARRAY g_mmbc_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b2) #page2  
         
            BEFORE ROW
               CALL ammt404_idx_chk()
               #add-point:page1, before row動作
               
               #end add-point
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac2 = DIALOG.getCurrentRow("s_detail2")
               CALL ammt404_idx_chk()
               LET g_current_page = 2
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為

            #end add-point
               
         END DISPLAY 
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL ammt404_browser_fill("")
            CALL cl_notice()
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            LET g_current_idx = DIALOG.getCurrentRow("s_browse")
            IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
               CALL DIALOG.setCurrentRow("s_browse",g_current_row)
               LET g_current_idx = g_current_row
            END IF
            
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
               CALL ammt404_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL ammt404_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL ammt404_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
                                    
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL ammt404_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL ammt404_set_act_visible()   
            CALL ammt404_set_act_no_visible()
            IF NOT (g_mmba_m.mmbadocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " mmbaent = " ||g_enterprise|| " AND",
                                  " mmbadocno = '", g_mmba_m.mmbadocno, "' "
 
               #填到對應位置
               CALL ammt404_browser_fill("")
            END IF
         #應用 a32 樣板自動產生(Version:3)
         #簽核狀況
         ON ACTION bpm_status
            #查詢簽核狀況, 統一建立HyperLink
            CALL cl_bpm_status()
            #add-point:ON ACTION bpm_status name="menu.bpm_status"
            
            #END add-point
 
 
 
          
         #查詢方案選擇 
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "mmba_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "mmbb_t" 
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
               CALL ammt404_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "mmba_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "mmbb_t" 
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
                  CALL ammt404_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL ammt404_fetch("F")
                  END IF
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
          
         #應用 a49 樣板自動產生(Version:4)
            #過濾瀏覽頁資料
            ON ACTION filter
               LET g_action_choice = "fetch"
               #add-point:filter action name="ui_dialog.action.filter"
               
               #end add-point
               CALL ammt404_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL ammt404_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL ammt404_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL ammt404_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL ammt404_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL ammt404_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL ammt404_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL ammt404_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL ammt404_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL ammt404_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL ammt404_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_mmbb_d)
                  LET g_export_id[1]   = "s_detail1"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  LET g_export_node[2] = base.typeInfo.create(g_mmbc_d)
                  LET g_export_id[2]   = "s_detail2"
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
            
         #瀏覽頁折疊
         ON ACTION worksheethidden   
            IF g_main_hidden THEN
               CALL gfrm_curr.setElementHidden("mainlayout",0)
               CALL gfrm_curr.setElementHidden("worksheet",1)
               LET g_main_hidden = 0
            ELSE
               CALL gfrm_curr.setElementHidden("mainlayout",1)
               CALL gfrm_curr.setElementHidden("worksheet",0)
               LET g_main_hidden = 1
            END IF
            IF lb_first THEN
               LET lb_first = FALSE
               NEXT FIELD mmbbseq
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
         ON ACTION demo2
            LET g_action_choice="demo2"
            IF cl_auth_chk_act("demo2") THEN
               
               #add-point:ON ACTION demo2 name="menu.demo2"
               IF NOT cl_null(g_mmbb_d[l_ac].mmbbseq) THEN
                  IF g_type='1' THEN
                     CALL aooi360_02('7','ammt404',g_mmba_m.mmbadocno,g_mmbb_d[l_ac].mmbbseq,'','','','','','','','')
                  ELSE
                     CALL aooi360_02('7','agct404',g_mmba_m.mmbadocno,g_mmbb_d[l_ac].mmbbseq,'','','','','','','','')
                  END IF
               ELSE
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL ammt404_modify()
               #add-point:ON ACTION modify name="menu.modify"
                                             
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL ammt404_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
                                             
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION demo
            LET g_action_choice="demo"
            IF cl_auth_chk_act("demo") THEN
               
               #add-point:ON ACTION demo name="menu.demo"
               IF g_type='1' THEN
                  CALL aooi360_02('6','ammt404',g_mmba_m.mmbadocno,'','','','','','','','','')
               ELSE
                  CALL aooi360_02('6','agct404',g_mmba_m.mmbadocno,'','','','','','','','','')
               END IF               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL ammt404_delete()
               #add-point:ON ACTION delete name="menu.delete"
                                             
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL ammt404_insert()
               #add-point:ON ACTION insert name="menu.insert"
                                             
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
                                             
               #END add-point
               &include "erp/amm/ammt404_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
                                             
               #END add-point
               &include "erp/amm/ammt404_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL ammt404_query()
               #add-point:ON ACTION query name="menu.query"
                                             
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL ammt404_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL ammt404_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL ammt404_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_mmba_m.mmbadocdt)
 
 
 
         
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
 
{<section id="ammt404.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION ammt404_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE l_where           STRING  
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
   CALL s_aooi500_sql_where(g_prog,'mmbasite') RETURNING l_where
   LET g_wc = g_wc," AND ",l_where
   LET l_wc  = g_wc.trim()
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT UNIQUE mmbadocno ",


                        " FROM mmba_t ",
                              " ",
                              " LEFT JOIN mmbb_t ON mmbbent = mmbaent AND mmbadocno = mmbbdocno ",

                              " ",
                              " ",
                       " WHERE mmbaent = '" ||g_enterprise|| "' AND mmbbent = '" ||g_enterprise|| "' AND ",l_wc, " AND ", l_wc2
      IF g_wc3 <> " 1=1" THEN
         LET l_sub_sql = " SELECT UNIQUE mmbadocno ",
                         "   FROM mmba_t,mmbb_t,mmbc_t",
                         "  WHERE mmbbent=mmbaent AND mmbadocno = mmbbdocno  ",
                         "    AND mmbbent=mmbcent AND mmbbdocno = mmbcdocno  ",
                         "    AND mmbbseq = mmbcseq ",
                       "      AND mmbaent = '" ||g_enterprise|| "' AND mmbbent = '" ||g_enterprise|| "' AND ",l_wc, " AND ", l_wc2, " AND ", g_wc3
      END IF
 
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE mmbadocno ",


                        " FROM mmba_t ", 
                              " ",
                              " ",
                        "WHERE mmbaent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED
      IF g_wc3 <> " 1=1" THEN
         LET l_sub_sql = " SELECT UNIQUE mmbadocno ",
                         "   FROM mmba_t,mmbb_t,mmbc_t",
                         "  WHERE mmbbent=mmbaent AND mmbadocno = mmbbdocno  ",
                         "    AND mmbbent=mmbcent AND mmbbdocno = mmbcdocno  ",
                         "    AND mmbbseq = mmbcseq ",
                       "      AND mmbaent = '" ||g_enterprise|| "' AND mmbbent = '" ||g_enterprise|| "' AND ",l_wc, " AND ", g_wc3
      END IF
 
   END IF
   
   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"
   
   PREPARE header_cnt_pre1 FROM g_sql
   EXECUTE header_cnt_pre1 INTO g_browser_cnt   #總筆數
   FREE header_cnt_pre1
 
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
 
   #若超過最大顯示筆數
   IF g_browser_cnt > g_max_browse THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = '9035'
      LET g_errparam.extend = g_browser_cnt
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF
   
   #LET g_page_action = ps_page_action          # Keep Action
   
   IF ps_page_action = "F" OR
      ps_page_action = "P" OR
      ps_page_action = "N" OR
      ps_page_action = "L" THEN
      LET g_page_action = ps_page_action
   END IF
   
   CASE ps_page_action
      WHEN "F" 
         LET g_pagestart = 1
          
      WHEN "P"  
         LET g_pagestart = g_pagestart - g_max_browse
         IF g_pagestart < 1 THEN
            LET g_pagestart = 1
         END IF
          
      WHEN "N"  
         LET g_pagestart = g_pagestart + g_max_browse
         IF g_pagestart > g_browser_cnt THEN
            LET g_pagestart = g_browser_cnt - (g_browser_cnt mod g_max_browse) + 1
            WHILE g_pagestart > g_browser_cnt 
               LET g_pagestart = g_pagestart - g_max_browse
            END WHILE
         END IF
      
      WHEN "L"  
         LET g_pagestart = g_browser_cnt - (g_browser_cnt mod g_max_browse) + 1
         WHILE g_pagestart > g_browser_cnt 
            LET g_pagestart = g_pagestart - g_max_browse
         END WHILE
         
      WHEN '/'
         LET g_pagestart = g_jump
         IF g_pagestart > g_browser_cnt THEN
            LET g_pagestart = 1
         END IF
         
   END CASE
  
   #單身有輸入查詢條件且非null
   IF g_wc2 <> " 1=1" AND NOT cl_null(g_wc2) THEN 
      #依照mmbadocno,mmbadocdt,mmbasite,'' Browser欄位定義(取代原本bs_sql功能)
      LET l_sql_rank = "SELECT DISTINCT mmbastus,mmbadocno,mmbadocdt,mmbasite,'',DENSE_RANK() OVER(ORDER BY mmbadocno,mmbasite ",g_order,") AS RANK ",
                        " FROM mmba_t ",
                              " ",
                              " LEFT JOIN mmbb_t ON mmbbent = mmbaent AND mmbadocno = mmbbdocno ",

                              " ",
                              " ",
                       " ",
                       " WHERE mmbaent = '" ||g_enterprise|| "' AND ",g_wc," AND ",g_wc2
      IF g_wc3 <> " 1=1" THEN
         LET l_sub_sql = " SELECT DISTINCT mmbastus,mmbadocno,mmbadocdt,mmbasite,'',DENSE_RANK() OVER(ORDER BY mmbadocno,mmbasite ",g_order,") AS RANK ",
                         "   FROM mmba_t,mmbb_t,mmbc_t",
                         "  WHERE mmbbent=mmbaent AND mmbadocno = mmbbdocno ",
                         "    AND mmbbent=mmbcent AND mmbbdocno = mmbcdocno  ",
                         "    AND mmbbseq = mmbcseq ",
                       "      AND mmbaent = '" ||g_enterprise|| "' AND ",g_wc," AND ",g_wc2, " AND ", g_wc3
      END IF
   ELSE
      #單身無輸入資料
      LET l_sql_rank = "SELECT DISTINCT mmbastus,mmbadocno,mmbadocdt,mmbasite,'',DENSE_RANK() OVER(ORDER BY mmbadocno,mmbasite ",g_order,") AS RANK ",
                       " FROM mmba_t ",
                            "  ",
                            "  ",
                       " WHERE mmbaent = '" ||g_enterprise|| "' AND ", g_wc
      IF g_wc3 <> " 1=1" THEN
         LET l_sub_sql = " SELECT DISTINCT mmbastus,mmbadocno,mmbadocdt,mmbasite,'',DENSE_RANK() OVER(ORDER BY mmbadocno,mmbasite ",g_order,") AS RANK ",
                         "   FROM mmba_t,mmbb_t,mmbc_t",
                         "  WHERE mmbbent=mmbaent AND mmbadocno = mmbbdocno  ",
                         "    AND mmbbent=mmbcent AND mmbbdocno = mmbcdocno  ",
                         "    AND mmbbseq = mmbcseq ",
                       "      AND mmbaent = '" ||g_enterprise|| "' AND ",g_wc, " AND ", g_wc3
      END IF
   END IF
   
   #定義翻頁CURSOR
   LET g_sql= "SELECT mmbastus,mmbadocno,mmbadocdt,mmbasite,'' FROM (",l_sql_rank,") WHERE ",
              " RANK >= ",1," AND RANK<",1+g_max_browse,
              " ORDER BY mmbadocno,mmbasite ",g_order
                
   PREPARE browse_pre1 FROM g_sql
   DECLARE browse_cur1 CURSOR FOR browse_pre1
 
   CALL g_browser.clear()
   LET g_cnt = 1
   FOREACH browse_cur1 INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_mmbadocno,g_browser[g_cnt].b_mmbadocdt,g_browser[g_cnt].b_mmbasite,g_browser[g_cnt].b_mmbasite_desc#,g_browser[g_cnt].rank   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
  
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_browser[g_cnt].b_mmbasite
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_lang||"'","") RETURNING g_rtn_fields
      LET g_browser[g_cnt].b_mmbasite_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_browser[g_cnt].b_mmbasite_desc

  
      #add-point:browser_fill段reference

      #end add-point
  
            #此段落由子樣板a24產生
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/open.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"

         WHEN "X"
            LET g_browser[g_cnt].b_statepic = "stus/16/invalid.png"

         WHEN "S"
            LET g_browser[g_cnt].b_statepic = "stus/16/posted.png"


		 
      END CASE


      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9035
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
   END FOREACH
 
   CALL g_browser.deleteElement(g_cnt)
   LET g_header_cnt = g_browser.getLength()
 
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   FREE browse_pre1
   RETURN
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT mmbadocno ",
                      " FROM mmba_t ",
                      " ",
                      " LEFT JOIN mmbb_t ON mmbbent = mmbaent AND mmbadocno = mmbbdocno ", "  ",
                      #add-point:browser_fill段sql(mmbb_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE mmbaent = " ||g_enterprise|| " AND mmbbent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("mmba_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT mmbadocno ",
                      " FROM mmba_t ", 
                      "  ",
                      "  ",
                      " WHERE mmbaent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("mmba_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   
   #end add-point
   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
   
   #add-point:browser_fill,count前 name="browser_fill.before_count"
         
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
      INITIALIZE g_mmba_m.* TO NULL
      CALL g_mmbb_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.mmbadocno,t0.mmbadocdt,t0.mmbasite Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.mmbastus,t0.mmbadocno,t0.mmbadocdt,t0.mmbasite,t1.ooefl003 ",
                  " FROM mmba_t t0",
                  "  ",
                  "  LEFT JOIN mmbb_t ON mmbbent = mmbaent AND mmbadocno = mmbbdocno ", "  ", 
                  #add-point:browser_fill段sql(mmbb_t1) name="browser_fill.join.mmbb_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.mmbasite AND t1.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.mmbaent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("mmba_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.mmbastus,t0.mmbadocno,t0.mmbadocdt,t0.mmbasite,t1.ooefl003 ",
                  " FROM mmba_t t0",
                  "  ",
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.mmbasite AND t1.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.mmbaent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("mmba_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY mmbadocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
         
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"mmba_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
         
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_mmbadocno,g_browser[g_cnt].b_mmbadocdt, 
          g_browser[g_cnt].b_mmbasite,g_browser[g_cnt].b_mmbasite_desc
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
      
         #遮罩相關處理
         CALL ammt404_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         WHEN "S"
            LET g_browser[g_cnt].b_statepic = "stus/16/posted.png"
         WHEN "A"
            LET g_browser[g_cnt].b_statepic = "stus/16/approved.png"
         WHEN "D"
            LET g_browser[g_cnt].b_statepic = "stus/16/withdraw.png"
         WHEN "R"
            LET g_browser[g_cnt].b_statepic = "stus/16/rejection.png"
         WHEN "W"
            LET g_browser[g_cnt].b_statepic = "stus/16/signing.png"
         WHEN "X"
            LET g_browser[g_cnt].b_statepic = "stus/16/invalid.png"
         
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
   
   IF cl_null(g_browser[g_cnt].b_mmbadocno) THEN
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
 
{<section id="ammt404.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION ammt404_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
         
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_mmba_m.mmbadocno = g_browser[g_current_idx].b_mmbadocno   
 
   EXECUTE ammt404_master_referesh USING g_mmba_m.mmbadocno INTO g_mmba_m.mmbasite,g_mmba_m.mmbadocdt, 
       g_mmba_m.mmbadocno,g_mmba_m.mmbaunit,g_mmba_m.mmba000,g_mmba_m.mmbastus,g_mmba_m.mmbaownid,g_mmba_m.mmbaowndp, 
       g_mmba_m.mmbacrtid,g_mmba_m.mmbacrtdp,g_mmba_m.mmbacrtdt,g_mmba_m.mmbamodid,g_mmba_m.mmbamoddt, 
       g_mmba_m.mmbacnfid,g_mmba_m.mmbacnfdt,g_mmba_m.mmbapstid,g_mmba_m.mmbapstdt,g_mmba_m.mmbasite_desc, 
       g_mmba_m.mmbaownid_desc,g_mmba_m.mmbaowndp_desc,g_mmba_m.mmbacrtid_desc,g_mmba_m.mmbacrtdp_desc, 
       g_mmba_m.mmbamodid_desc,g_mmba_m.mmbacnfid_desc,g_mmba_m.mmbapstid_desc
   
   CALL ammt404_mmba_t_mask()
   CALL ammt404_show()
      
END FUNCTION
 
{</section>}
 
{<section id="ammt404.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION ammt404_ui_detailshow()
   #add-point:ui_detailshow段define(客製用) name="ui_detailshow.define_customerization"
   
   #end add-point    
   #add-point:ui_detailshow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
         
   #end add-point    
 
   #add-point:Function前置處理 name="ui_detailshow.before"
         
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
         
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="ammt404.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION ammt404_ui_browser_refresh()
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
      IF g_browser[l_i].b_mmbadocno = g_mmba_m.mmbadocno 
 
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
 
{<section id="ammt404.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION ammt404_construct()
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
   INITIALIZE g_mmba_m.* TO NULL
   CALL g_mmbb_d.clear()        
 
   
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
      CONSTRUCT BY NAME g_wc ON mmbasite,mmbadocdt,mmbadocno,mmbaunit,mmba000,mmbastus,mmbaownid,mmbaowndp, 
          mmbacrtid,mmbacrtdp,mmbacrtdt,mmbamodid,mmbamoddt,mmbacnfid,mmbacnfdt,mmbapstid,mmbapstdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
                                                display g_type to mmba000
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<mmbacrtdt>>----
         AFTER FIELD mmbacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<mmbamoddt>>----
         AFTER FIELD mmbamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<mmbacnfdt>>----
         AFTER FIELD mmbacnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<mmbapstdt>>----
         AFTER FIELD mmbapstdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.mmbasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbasite
            #add-point:ON ACTION controlp INFIELD mmbasite name="construct.c.mmbasite"
                                                #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#            LET g_qryparam.arg2 = '8'
#            CALL q_ooed004()                           #呼叫開窗
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'mmbasite',g_site,'c')    #150308-00001#4  By benson add 'c'
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO mmbasite  #顯示到畫面上
            LET g_qryparam.arg2 = null 
            NEXT FIELD mmbasite                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbasite
            #add-point:BEFORE FIELD mmbasite name="construct.b.mmbasite"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbasite
            
            #add-point:AFTER FIELD mmbasite name="construct.a.mmbasite"
                                    
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbadocdt
            #add-point:BEFORE FIELD mmbadocdt name="construct.b.mmbadocdt"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbadocdt
            
            #add-point:AFTER FIELD mmbadocdt name="construct.a.mmbadocdt"
                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmbadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbadocdt
            #add-point:ON ACTION controlp INFIELD mmbadocdt name="construct.c.mmbadocdt"
                                    
            #END add-point
 
 
         #Ctrlp:construct.c.mmbadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbadocno
            #add-point:ON ACTION controlp INFIELD mmbadocno name="construct.c.mmbadocno"
                                                #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " mmba000 = '",g_type,"' "
            CALL q_mmbadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbadocno  #顯示到畫面上

            NEXT FIELD mmbadocno                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbadocno
            #add-point:BEFORE FIELD mmbadocno name="construct.b.mmbadocno"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbadocno
            
            #add-point:AFTER FIELD mmbadocno name="construct.a.mmbadocno"
                                    
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbaunit
            #add-point:BEFORE FIELD mmbaunit name="construct.b.mmbaunit"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbaunit
            
            #add-point:AFTER FIELD mmbaunit name="construct.a.mmbaunit"
                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmbaunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbaunit
            #add-point:ON ACTION controlp INFIELD mmbaunit name="construct.c.mmbaunit"
                                    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmba000
            #add-point:BEFORE FIELD mmba000 name="construct.b.mmba000"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmba000
            
            #add-point:AFTER FIELD mmba000 name="construct.a.mmba000"
                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmba000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmba000
            #add-point:ON ACTION controlp INFIELD mmba000 name="construct.c.mmba000"
                                    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbastus
            #add-point:BEFORE FIELD mmbastus name="construct.b.mmbastus"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbastus
            
            #add-point:AFTER FIELD mmbastus name="construct.a.mmbastus"
                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmbastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbastus
            #add-point:ON ACTION controlp INFIELD mmbastus name="construct.c.mmbastus"
                                    
            #END add-point
 
 
         #Ctrlp:construct.c.mmbaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbaownid
            #add-point:ON ACTION controlp INFIELD mmbaownid name="construct.c.mmbaownid"
                                                #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbaownid  #顯示到畫面上

            NEXT FIELD mmbaownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbaownid
            #add-point:BEFORE FIELD mmbaownid name="construct.b.mmbaownid"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbaownid
            
            #add-point:AFTER FIELD mmbaownid name="construct.a.mmbaownid"
                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmbaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbaowndp
            #add-point:ON ACTION controlp INFIELD mmbaowndp name="construct.c.mmbaowndp"
                                                #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbaowndp  #顯示到畫面上

            NEXT FIELD mmbaowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbaowndp
            #add-point:BEFORE FIELD mmbaowndp name="construct.b.mmbaowndp"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbaowndp
            
            #add-point:AFTER FIELD mmbaowndp name="construct.a.mmbaowndp"
                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmbacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbacrtid
            #add-point:ON ACTION controlp INFIELD mmbacrtid name="construct.c.mmbacrtid"
                                                #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbacrtid  #顯示到畫面上

            NEXT FIELD mmbacrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbacrtid
            #add-point:BEFORE FIELD mmbacrtid name="construct.b.mmbacrtid"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbacrtid
            
            #add-point:AFTER FIELD mmbacrtid name="construct.a.mmbacrtid"
                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmbacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbacrtdp
            #add-point:ON ACTION controlp INFIELD mmbacrtdp name="construct.c.mmbacrtdp"
                                                #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbacrtdp  #顯示到畫面上

            NEXT FIELD mmbacrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbacrtdp
            #add-point:BEFORE FIELD mmbacrtdp name="construct.b.mmbacrtdp"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbacrtdp
            
            #add-point:AFTER FIELD mmbacrtdp name="construct.a.mmbacrtdp"
                                    
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbacrtdt
            #add-point:BEFORE FIELD mmbacrtdt name="construct.b.mmbacrtdt"
                                    
            #END add-point
 
 
         #Ctrlp:construct.c.mmbamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbamodid
            #add-point:ON ACTION controlp INFIELD mmbamodid name="construct.c.mmbamodid"
                                                #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbamodid  #顯示到畫面上

            NEXT FIELD mmbamodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbamodid
            #add-point:BEFORE FIELD mmbamodid name="construct.b.mmbamodid"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbamodid
            
            #add-point:AFTER FIELD mmbamodid name="construct.a.mmbamodid"
                                    
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbamoddt
            #add-point:BEFORE FIELD mmbamoddt name="construct.b.mmbamoddt"
                                    
            #END add-point
 
 
         #Ctrlp:construct.c.mmbacnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbacnfid
            #add-point:ON ACTION controlp INFIELD mmbacnfid name="construct.c.mmbacnfid"
                                                #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbacnfid  #顯示到畫面上

            NEXT FIELD mmbacnfid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbacnfid
            #add-point:BEFORE FIELD mmbacnfid name="construct.b.mmbacnfid"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbacnfid
            
            #add-point:AFTER FIELD mmbacnfid name="construct.a.mmbacnfid"
                                    
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbacnfdt
            #add-point:BEFORE FIELD mmbacnfdt name="construct.b.mmbacnfdt"
                                    
            #END add-point
 
 
         #Ctrlp:construct.c.mmbapstid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbapstid
            #add-point:ON ACTION controlp INFIELD mmbapstid name="construct.c.mmbapstid"
                                                #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbapstid  #顯示到畫面上

            NEXT FIELD mmbapstid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbapstid
            #add-point:BEFORE FIELD mmbapstid name="construct.b.mmbapstid"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbapstid
            
            #add-point:AFTER FIELD mmbapstid name="construct.a.mmbapstid"
                                    
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbapstdt
            #add-point:BEFORE FIELD mmbapstdt name="construct.b.mmbapstdt"
                                    
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON mmbbseq,mmbbsite,mmbb002,mmbb003,mmbb004,mmbb001,mmbb005,mmbb006,mmbb007, 
          mmbb008,mmbbunit,mmbb000
           FROM s_detail1[1].mmbbseq,s_detail1[1].mmbbsite,s_detail1[1].mmbb002,s_detail1[1].mmbb003, 
               s_detail1[1].mmbb004,s_detail1[1].mmbb001,s_detail1[1].mmbb005,s_detail1[1].mmbb006,s_detail1[1].mmbb007, 
               s_detail1[1].mmbb008,s_detail1[1].mmbbunit,s_detail1[1].mmbb000
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
                                    
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbbseq
            #add-point:BEFORE FIELD mmbbseq name="construct.b.page1.mmbbseq"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbbseq
            
            #add-point:AFTER FIELD mmbbseq name="construct.a.page1.mmbbseq"
                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmbbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbbseq
            #add-point:ON ACTION controlp INFIELD mmbbseq name="construct.c.page1.mmbbseq"
                                    
            #END add-point
 
 
         #Ctrlp:construct.c.page1.mmbbsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbbsite
            #add-point:ON ACTION controlp INFIELD mmbbsite name="construct.c.page1.mmbbsite"
                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
#            CALL q_ooef001()                           #呼叫開窗
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'mmbbsite',g_site,'c')   #150308-00001#4  By benson add 'c'
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO mmbbsite  #顯示到畫面上

            NEXT FIELD mmbbsite                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbbsite
            #add-point:BEFORE FIELD mmbbsite name="construct.b.page1.mmbbsite"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbbsite
            
            #add-point:AFTER FIELD mmbbsite name="construct.a.page1.mmbbsite"
                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmbb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbb002
            #add-point:ON ACTION controlp INFIELD mmbb002 name="construct.c.page1.mmbb002"
                                                #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbb002  #顯示到畫面上

            NEXT FIELD mmbb002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbb002
            #add-point:BEFORE FIELD mmbb002 name="construct.b.page1.mmbb002"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbb002
            
            #add-point:AFTER FIELD mmbb002 name="construct.a.page1.mmbb002"
                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmbb003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbb003
            #add-point:ON ACTION controlp INFIELD mmbb003 name="construct.c.page1.mmbb003"
                                                #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#            CALL q_ooef001()                           #呼叫開窗
            IF s_aooi500_setpoint(g_prog,'mmbb003') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'mmbb003',g_site,'c')    #150308-00001#4  By benson add 'c'
               CALL q_ooef001_24()
            ELSE
               LET g_qryparam.where = "ooef201 = 'Y'"     #161024-00025#11  2016/10/28  by 08742  add
               CALL q_ooef001()
            END IF
            DISPLAY g_qryparam.return1 TO mmbb003  #顯示到畫面上

            NEXT FIELD mmbb003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbb003
            #add-point:BEFORE FIELD mmbb003 name="construct.b.page1.mmbb003"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbb003
            
            #add-point:AFTER FIELD mmbb003 name="construct.a.page1.mmbb003"
                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmbb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbb004
            #add-point:ON ACTION controlp INFIELD mmbb004 name="construct.c.page1.mmbb004"
                                                #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbb004  #顯示到畫面上

            NEXT FIELD mmbb004                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbb004
            #add-point:BEFORE FIELD mmbb004 name="construct.b.page1.mmbb004"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbb004
            
            #add-point:AFTER FIELD mmbb004 name="construct.a.page1.mmbb004"
                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmbb001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbb001
            #add-point:ON ACTION controlp INFIELD mmbb001 name="construct.c.page1.mmbb001"
                                                #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_mman001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbb001  #顯示到畫面上

            NEXT FIELD mmbb001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbb001
            #add-point:BEFORE FIELD mmbb001 name="construct.b.page1.mmbb001"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbb001
            
            #add-point:AFTER FIELD mmbb001 name="construct.a.page1.mmbb001"
                                    
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbb005
            #add-point:BEFORE FIELD mmbb005 name="construct.b.page1.mmbb005"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbb005
            
            #add-point:AFTER FIELD mmbb005 name="construct.a.page1.mmbb005"
                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmbb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbb005
            #add-point:ON ACTION controlp INFIELD mmbb005 name="construct.c.page1.mmbb005"
                                    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbb006
            #add-point:BEFORE FIELD mmbb006 name="construct.b.page1.mmbb006"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbb006
            
            #add-point:AFTER FIELD mmbb006 name="construct.a.page1.mmbb006"
                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmbb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbb006
            #add-point:ON ACTION controlp INFIELD mmbb006 name="construct.c.page1.mmbb006"
                                    
            #END add-point
 
 
         #Ctrlp:construct.c.page1.mmbb007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbb007
            #add-point:ON ACTION controlp INFIELD mmbb007 name="construct.c.page1.mmbb007"
                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_mmbb007()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbb007  #顯示到畫面上

            NEXT FIELD mmbb007                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbb007
            #add-point:BEFORE FIELD mmbb007 name="construct.b.page1.mmbb007"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbb007
            
            #add-point:AFTER FIELD mmbb007 name="construct.a.page1.mmbb007"
                                    
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbb008
            #add-point:BEFORE FIELD mmbb008 name="construct.b.page1.mmbb008"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbb008
            
            #add-point:AFTER FIELD mmbb008 name="construct.a.page1.mmbb008"
                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmbb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbb008
            #add-point:ON ACTION controlp INFIELD mmbb008 name="construct.c.page1.mmbb008"
                                    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbbunit
            #add-point:BEFORE FIELD mmbbunit name="construct.b.page1.mmbbunit"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbbunit
            
            #add-point:AFTER FIELD mmbbunit name="construct.a.page1.mmbbunit"
                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmbbunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbbunit
            #add-point:ON ACTION controlp INFIELD mmbbunit name="construct.c.page1.mmbbunit"
                                    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbb000
            #add-point:BEFORE FIELD mmbb000 name="construct.b.page1.mmbb000"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbb000
            
            #add-point:AFTER FIELD mmbb000 name="construct.a.page1.mmbb000"
                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmbb000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbb000
            #add-point:ON ACTION controlp INFIELD mmbb000 name="construct.c.page1.mmbb000"
                                    
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
                        CONSTRUCT g_wc_table2 ON mmbcseq,mmbcseq1,mmbc001,mmbc002,mmbc003
           FROM s_detail2[1].mmbcseq,s_detail2[1].mmbcseq1,s_detail2[1].mmbc001,s_detail2[1].mmbc002,s_detail2[1].mmbc003
         BEFORE CONSTRUCT
      #      CALL cl_qbe_display_condition(lc_qbe_sn)  
      END CONSTRUCT     
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
                  WHEN la_wc[li_idx].tableid = "mmba_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "mmbb_t" 
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
            #組合g_wc3
   LET g_wc3 = g_wc_table2
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="ammt404.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION ammt404_filter()
   #add-point:filter段define name="filter.define_customerization"
   
   #end add-point   
   #add-point:filter段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
         
   #end add-point   
   
   #add-point:Function前置處理  name="filter.pre_function"
   
   #end add-point
   
   #切換畫面
   IF NOT g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",1)
      CALL gfrm_curr.setElementHidden("worksheet",0)
      LET g_main_hidden = 1
   END IF   
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter.trim()
   LET g_wc_t = g_wc
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter_t, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON mmbadocno,mmbadocdt,mmbasite
                          FROM s_browse[1].b_mmbadocno,s_browse[1].b_mmbadocdt,s_browse[1].b_mmbasite 
 
 
         BEFORE CONSTRUCT
               DISPLAY ammt404_filter_parser('mmbadocno') TO s_browse[1].b_mmbadocno
            DISPLAY ammt404_filter_parser('mmbadocdt') TO s_browse[1].b_mmbadocdt
            DISPLAY ammt404_filter_parser('mmbasite') TO s_browse[1].b_mmbasite
      
         #add-point:filter段cs_ctrl name="filter.cs_ctrl"
         
         #end add-point
      
      END CONSTRUCT
 
      #add-point:filter段add_cs name="filter.add_cs"
                  
      #end add-point
 
      BEFORE DIALOG
         #add-point:filter段b_dialog name="filter.b_dialog"
                           
         #end add-point  
      
      ON ACTION accept
         ACCEPT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG 
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG
   
   END DIALOG
 
   IF NOT INT_FLAG THEN
      LET g_wc_filter = "   AND   ", g_wc_filter, "   "
      LET g_wc = g_wc , g_wc_filter
   ELSE
      LET g_wc_filter = g_wc_filter_t
      LET g_wc = g_wc_t
   END IF
 
      CALL ammt404_filter_show('mmbadocno')
   CALL ammt404_filter_show('mmbadocdt')
   CALL ammt404_filter_show('mmbasite')
 
END FUNCTION
 
{</section>}
 
{<section id="ammt404.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION ammt404_filter_parser(ps_field)
   #add-point:filter段define name="filter_parser.define_customerization"
   
   #end add-point    
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num10
   DEFINE li_tmp2    LIKE type_t.num10
   DEFINE ls_var     STRING
   #add-point:filter段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter_parser.define"
         
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
 
{<section id="ammt404.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION ammt404_filter_show(ps_field)
   DEFINE ps_field         STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
 
   LET ls_name = "formonly.b_", ps_field
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = ammt404_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="ammt404.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION ammt404_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
         
   #end add-point   
   
   #add-point:Function前置處理  name="query.pre_function"
   
   #end add-point
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF   
   
   LET ls_wc = g_wc
   
   LET INT_FLAG = 0
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   ERROR ""
   
   #清除畫面及相關資料
   CLEAR FORM
   CALL g_browser.clear()       
   CALL g_mmbb_d.clear()
 
   
   #add-point:query段other name="query.other"
         
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL ammt404_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL ammt404_browser_fill("")
      CALL ammt404_fetch("")
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
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
      CALL ammt404_filter_show('mmbadocno')
   CALL ammt404_filter_show('mmbadocdt')
   CALL ammt404_filter_show('mmbasite')
   CALL ammt404_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL ammt404_fetch("F") 
      #顯示單身筆數
      CALL ammt404_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="ammt404.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION ammt404_fetch(p_flag)
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
 
   CALL g_curr_diag.setCurrentRow("s_browse", g_current_idx) #設定browse 索引
   
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
   LET g_browser_idx = g_pagestart+g_current_idx-1
   DISPLAY g_browser_idx TO FORMONLY.b_index   #當下筆數
   DISPLAY g_browser_idx TO FORMONLY.h_index   #當下筆數
   
   CALL cl_navigator_setting( g_current_idx, g_browser_cnt )
 
   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF
   
   #避免超出browser資料筆數上限
   IF g_current_idx > g_browser.getLength() THEN
      LET g_browser_idx = g_browser.getLength()
      LET g_current_idx = g_browser.getLength()
   END IF
   
   LET g_mmba_m.mmbadocno = g_browser[g_current_idx].b_mmbadocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE ammt404_master_referesh USING g_mmba_m.mmbadocno INTO g_mmba_m.mmbasite,g_mmba_m.mmbadocdt, 
       g_mmba_m.mmbadocno,g_mmba_m.mmbaunit,g_mmba_m.mmba000,g_mmba_m.mmbastus,g_mmba_m.mmbaownid,g_mmba_m.mmbaowndp, 
       g_mmba_m.mmbacrtid,g_mmba_m.mmbacrtdp,g_mmba_m.mmbacrtdt,g_mmba_m.mmbamodid,g_mmba_m.mmbamoddt, 
       g_mmba_m.mmbacnfid,g_mmba_m.mmbacnfdt,g_mmba_m.mmbapstid,g_mmba_m.mmbapstdt,g_mmba_m.mmbasite_desc, 
       g_mmba_m.mmbaownid_desc,g_mmba_m.mmbaowndp_desc,g_mmba_m.mmbacrtid_desc,g_mmba_m.mmbacrtdp_desc, 
       g_mmba_m.mmbamodid_desc,g_mmba_m.mmbacnfid_desc,g_mmba_m.mmbapstid_desc
   
   #遮罩相關處理
   LET g_mmba_m_mask_o.* =  g_mmba_m.*
   CALL ammt404_mmba_t_mask()
   LET g_mmba_m_mask_n.* =  g_mmba_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL ammt404_set_act_visible()   
   CALL ammt404_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
#            IF g_mmba_m.mmbastus <> 'N' THEN
#      CALL cl_set_act_visible("modify,delete", FALSE)
#   else
#      CALL cl_set_act_visible("modify,delete", TRUE)   
#   END IF
   IF g_mmba_m.mmbastus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   ELSE
      CALL cl_set_act_visible("modify,delete,modify_detail", TRUE)   
   END IF
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
         
   #end add-point
   
   #保存單頭舊值
   LET g_mmba_m_t.* = g_mmba_m.*
   LET g_mmba_m_o.* = g_mmba_m.*
   
   LET g_data_owner = g_mmba_m.mmbaownid      
   LET g_data_dept  = g_mmba_m.mmbaowndp
   
   #重新顯示   
   CALL ammt404_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="ammt404.insert" >}
#+ 資料新增
PRIVATE FUNCTION ammt404_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE l_insert      LIKE type_t.num5   
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_doctype     LIKE rtai_t.rtai004
   CALL g_mmbc_d.clear()
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_mmbb_d.clear()   
 
 
   INITIALIZE g_mmba_m.* TO NULL             #DEFAULT 設定
   
   LET g_mmbadocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_mmba_m.mmbaownid = g_user
      LET g_mmba_m.mmbaowndp = g_dept
      LET g_mmba_m.mmbacrtid = g_user
      LET g_mmba_m.mmbacrtdp = g_dept 
      LET g_mmba_m.mmbacrtdt = cl_get_current()
      LET g_mmba_m.mmbamodid = g_user
      LET g_mmba_m.mmbamoddt = cl_get_current()
      LET g_mmba_m.mmbastus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_mmba_m.mmbastus = "N"
 
  
      #add-point:單頭預設值 name="insert.default"
                        INITIALIZE g_mmba_m_t.* TO NULL
      LET g_mmba_m.mmbastus = "N"
      LET g_mmba_m.mmbadocdt = g_today
#      LET g_mmba_m.mmbasite = g_site
      LET g_ins_site_flag = FALSE   #161024-00025#7  2016/10/25  by 08742  add
      CALL s_aooi500_default(g_prog,'mmbasite',g_mmba_m.mmbasite)
         RETURNING l_insert,g_mmba_m.mmbasite
      IF NOT l_insert THEN
         RETURN
      END IF
      LET g_mmba_m.mmbaunit = g_mmba_m.mmbasite
      LET g_mmba_m.mmba000 = g_type
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_mmba_m.mmbasite
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_mmba_m.mmbasite_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_mmba_m.mmbasite_desc
      #預設單據的單別 
      LET l_success = ''
      LET l_doctype = ''
      CALL s_arti200_get_def_doc_type(g_mmba_m.mmbasite,g_prog,'1')
           RETURNING l_success, l_doctype
      LET g_mmba_m.mmbadocno = l_doctype
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_mmba_m_t.* = g_mmba_m.*
      LET g_mmba_m_o.* = g_mmba_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_mmba_m.mmbastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
    
      CALL ammt404_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
                        CALL ammt404_sum_mmbb006()
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
         INITIALIZE g_mmba_m.* TO NULL
         INITIALIZE g_mmbb_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL ammt404_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_mmbb_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL ammt404_set_act_visible()   
   CALL ammt404_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_mmbadocno_t = g_mmba_m.mmbadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " mmbaent = " ||g_enterprise|| " AND",
                      " mmbadocno = '", g_mmba_m.mmbadocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL ammt404_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE ammt404_cl
   
   CALL ammt404_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE ammt404_master_referesh USING g_mmba_m.mmbadocno INTO g_mmba_m.mmbasite,g_mmba_m.mmbadocdt, 
       g_mmba_m.mmbadocno,g_mmba_m.mmbaunit,g_mmba_m.mmba000,g_mmba_m.mmbastus,g_mmba_m.mmbaownid,g_mmba_m.mmbaowndp, 
       g_mmba_m.mmbacrtid,g_mmba_m.mmbacrtdp,g_mmba_m.mmbacrtdt,g_mmba_m.mmbamodid,g_mmba_m.mmbamoddt, 
       g_mmba_m.mmbacnfid,g_mmba_m.mmbacnfdt,g_mmba_m.mmbapstid,g_mmba_m.mmbapstdt,g_mmba_m.mmbasite_desc, 
       g_mmba_m.mmbaownid_desc,g_mmba_m.mmbaowndp_desc,g_mmba_m.mmbacrtid_desc,g_mmba_m.mmbacrtdp_desc, 
       g_mmba_m.mmbamodid_desc,g_mmba_m.mmbacnfid_desc,g_mmba_m.mmbapstid_desc
   
   
   #遮罩相關處理
   LET g_mmba_m_mask_o.* =  g_mmba_m.*
   CALL ammt404_mmba_t_mask()
   LET g_mmba_m_mask_n.* =  g_mmba_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_mmba_m.mmbasite,g_mmba_m.mmbasite_desc,g_mmba_m.mmbadocdt,g_mmba_m.mmbadocno,g_mmba_m.mmbaunit, 
       g_mmba_m.mmba000,g_mmba_m.mmbastus,g_mmba_m.mmbaownid,g_mmba_m.mmbaownid_desc,g_mmba_m.mmbaowndp, 
       g_mmba_m.mmbaowndp_desc,g_mmba_m.mmbacrtid,g_mmba_m.mmbacrtid_desc,g_mmba_m.mmbacrtdp,g_mmba_m.mmbacrtdp_desc, 
       g_mmba_m.mmbacrtdt,g_mmba_m.mmbamodid,g_mmba_m.mmbamodid_desc,g_mmba_m.mmbamoddt,g_mmba_m.mmbacnfid, 
       g_mmba_m.mmbacnfid_desc,g_mmba_m.mmbacnfdt,g_mmba_m.mmbapstid,g_mmba_m.mmbapstid_desc,g_mmba_m.mmbapstdt 
 
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_mmba_m.mmbaownid      
   LET g_data_dept  = g_mmba_m.mmbaowndp
   
   #功能已完成,通報訊息中心
   CALL ammt404_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="ammt404.modify" >}
#+ 資料修改
PRIVATE FUNCTION ammt404_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   IF g_mmba_m.mmbastus MATCHES "[DR]" THEN 
      LET g_mmba_m.mmbastus = "N"
   END IF
   IF g_mmba_m.mmbastus<>'N' THEN
      RETURN
   END IF         
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_mmba_m_t.* = g_mmba_m.*
   LET g_mmba_m_o.* = g_mmba_m.*
   
   IF g_mmba_m.mmbadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_mmbadocno_t = g_mmba_m.mmbadocno
 
   CALL s_transaction_begin()
   
   OPEN ammt404_cl USING g_enterprise,g_mmba_m.mmbadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN ammt404_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE ammt404_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE ammt404_master_referesh USING g_mmba_m.mmbadocno INTO g_mmba_m.mmbasite,g_mmba_m.mmbadocdt, 
       g_mmba_m.mmbadocno,g_mmba_m.mmbaunit,g_mmba_m.mmba000,g_mmba_m.mmbastus,g_mmba_m.mmbaownid,g_mmba_m.mmbaowndp, 
       g_mmba_m.mmbacrtid,g_mmba_m.mmbacrtdp,g_mmba_m.mmbacrtdt,g_mmba_m.mmbamodid,g_mmba_m.mmbamoddt, 
       g_mmba_m.mmbacnfid,g_mmba_m.mmbacnfdt,g_mmba_m.mmbapstid,g_mmba_m.mmbapstdt,g_mmba_m.mmbasite_desc, 
       g_mmba_m.mmbaownid_desc,g_mmba_m.mmbaowndp_desc,g_mmba_m.mmbacrtid_desc,g_mmba_m.mmbacrtdp_desc, 
       g_mmba_m.mmbamodid_desc,g_mmba_m.mmbacnfid_desc,g_mmba_m.mmbapstid_desc
   
   #檢查是否允許此動作
   IF NOT ammt404_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_mmba_m_mask_o.* =  g_mmba_m.*
   CALL ammt404_mmba_t_mask()
   LET g_mmba_m_mask_n.* =  g_mmba_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL ammt404_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_mmbadocno_t = g_mmba_m.mmbadocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_mmba_m.mmbamodid = g_user 
LET g_mmba_m.mmbamoddt = cl_get_current()
LET g_mmba_m.mmbamodid_desc = cl_get_username(g_mmba_m.mmbamodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      IF g_mmba_m.mmbastus MATCHES "[DR]" THEN 
         LET g_mmba_m.mmbastus = "N"
      END IF            
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL ammt404_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
                        CALL ammt404_sum_mmbb006()
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE mmba_t SET (mmbamodid,mmbamoddt) = (g_mmba_m.mmbamodid,g_mmba_m.mmbamoddt)
          WHERE mmbaent = g_enterprise AND mmbadocno = g_mmbadocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_mmba_m.* = g_mmba_m_t.*
            CALL ammt404_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_mmba_m.mmbadocno != g_mmba_m_t.mmbadocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
                           
         #end add-point
         
         #更新單身key值
         UPDATE mmbb_t SET mmbbdocno = g_mmba_m.mmbadocno
 
          WHERE mmbbent = g_enterprise AND mmbbdocno = g_mmba_m_t.mmbadocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
                           
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "mmbb_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mmbb_t:",SQLERRMESSAGE 
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
   CALL ammt404_set_act_visible()   
   CALL ammt404_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " mmbaent = " ||g_enterprise|| " AND",
                      " mmbadocno = '", g_mmba_m.mmbadocno, "' "
 
   #填到對應位置
   CALL ammt404_browser_fill("")
 
   CLOSE ammt404_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL ammt404_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="ammt404.input" >}
#+ 資料輸入
PRIVATE FUNCTION ammt404_input(p_cmd)
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
            DEFINE  l_mmbb006       LIKE mmbb_t.mmbb006
   DEFINE  l_cnt1          LIKE type_t.num5
   DEFINE  l_success       LIKE type_t.num5
   DEFINE  l_errno         LIKE type_t.chr10
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
   DISPLAY BY NAME g_mmba_m.mmbasite,g_mmba_m.mmbasite_desc,g_mmba_m.mmbadocdt,g_mmba_m.mmbadocno,g_mmba_m.mmbaunit, 
       g_mmba_m.mmba000,g_mmba_m.mmbastus,g_mmba_m.mmbaownid,g_mmba_m.mmbaownid_desc,g_mmba_m.mmbaowndp, 
       g_mmba_m.mmbaowndp_desc,g_mmba_m.mmbacrtid,g_mmba_m.mmbacrtid_desc,g_mmba_m.mmbacrtdp,g_mmba_m.mmbacrtdp_desc, 
       g_mmba_m.mmbacrtdt,g_mmba_m.mmbamodid,g_mmba_m.mmbamodid_desc,g_mmba_m.mmbamoddt,g_mmba_m.mmbacnfid, 
       g_mmba_m.mmbacnfid_desc,g_mmba_m.mmbacnfdt,g_mmba_m.mmbapstid,g_mmba_m.mmbapstid_desc,g_mmba_m.mmbapstdt 
 
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql name="input.define_sql"
            LET g_forupd_sql = "SELECT mmbcseq,mmbcseq1,mmbc001,mmbc002,mmbc003,mmbcsite,mmbcunit,mmbc000 FROM mmbc_t WHERE mmbcent=?  AND mmbcdocno=? AND mmbcseq=? AND mmbcseq1=?  FOR UPDATE"
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE ammt404_bcl_2 CURSOR FROM g_forupd_sql
   
   LET g_forupd_sql = "SELECT mmbbseq,mmbb002,'',mmbb003,mmbb004,'',mmbb005,mmbb001,'',mmbb006,mmbb007,mmbb008,mmbb009 FROM mmbb_t WHERE mmbbent=?  AND mmbbdocno=? AND mmbbsite=? AND mmbbseq=? FOR UPDATE"
   #end add-point 
   LET g_forupd_sql = "SELECT mmbbseq,mmbbsite,mmbb002,mmbb003,mmbb004,mmbb001,mmbb005,mmbb006,mmbb007, 
       mmbb008,mmbbunit,mmbb000 FROM mmbb_t WHERE mmbbent=? AND mmbbdocno=? AND mmbbseq=? FOR UPDATE" 
 
   #add-point:input段define_sql name="input.after_define_sql"
         
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE ammt404_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
         
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL ammt404_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
         
   #end add-point
   CALL ammt404_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_mmba_m.mmbasite,g_mmba_m.mmbadocdt,g_mmba_m.mmbadocno,g_mmba_m.mmbaunit,g_mmba_m.mmba000, 
       g_mmba_m.mmbastus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
            SELECT ooef004 INTO g_ooef004 FROM ooef_t WHERE ooef001 = g_site AND ooefent = g_enterprise
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="ammt404.input.head" >}
      #單頭段
      INPUT BY NAME g_mmba_m.mmbasite,g_mmba_m.mmbadocdt,g_mmba_m.mmbadocno,g_mmba_m.mmbaunit,g_mmba_m.mmba000, 
          g_mmba_m.mmbastus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN ammt404_cl USING g_enterprise,g_mmba_m.mmbadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN ammt404_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE ammt404_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL ammt404_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
                                                CALL ammt404_set_entry(p_cmd)
            CALL ammt404_set_no_entry(p_cmd)
            LET g_mmbadocno_t = g_mmba_m.mmbadocno            
            #end add-point
            CALL ammt404_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbasite
            
            #add-point:AFTER FIELD mmbasite name="input.a.mmbasite"
                                                #此段落由子樣板a05產生
            LET g_mmba_m.mmbasite_desc = NULL
            DISPLAY BY NAME g_mmba_m.mmbasite_desc
            IF NOT cl_null(g_mmba_m.mmbasite) THEN 
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND ( g_mmba_m.mmbasite != g_mmba_m_t.mmbasite OR g_mmba_m_t.mmbasite ))) THEN   #160824-00007#122 by sakura mark
               IF g_mmba_m.mmbasite != g_mmba_m_o.mmbasite OR cl_null(g_mmba_m_o.mmbasite) THEN   #160824-00007#122 by sakura add
                  
#                  CALL ammt404_chk_mmbasite(g_mmba_m.mmbasite)
#                  IF NOT cl_null(g_errno) THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = g_errno
#                     LET g_errparam.extend = g_mmba_m.mmbasite
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#
#                     LET g_mmba_m.mmbasite = g_mmba_m_t.mmbasite
#                     CALL ammt404_mmbasite_reference()
#                     NEXT FIELD mmbasite
#                  END IF
             #161024-00025#7  2016/10/25 by 08742 -S
#                  CALL s_aooi500_chk(g_prog,'mmbasite',g_mmba_m.mmbasite,g_mmba_m.mmbasite) RETURNING l_success,l_errno
#                  IF NOT l_success THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.extend = g_mmba_m.mmbasite
#                     LET g_errparam.code   = l_errno
#                     LET g_errparam.popup  = TRUE
#                     CALL cl_err()
#                  
#                     LET g_mmba_m.mmbasite = g_mmba_m_t.mmbasite
#                     CALL ammt404_mmbasite_reference()
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF
#            CALL ammt404_mmbasite_reference()
             CALL s_aooi500_chk(g_prog,'mmbasite',g_mmba_m.mmbasite,g_mmba_m.mmbasite) RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = g_mmba_m.mmbasite
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                  
                     #LET g_mmba_m.mmbasite = g_mmba_m_t.mmbasite   #160824-00007#122 by sakura mark
                     LET g_mmba_m.mmbasite = g_mmba_m_o.mmbasite    #160824-00007#122 by sakura add
                     CALL ammt404_mmbasite_reference()
                     NEXT FIELD CURRENT
                  ELSE
                     LET g_ins_site_flag = TRUE  
                  END IF
               END IF
            END IF
            LET g_mmba_m_o.* = g_mmba_m.*    #160824-00007#122 by sakura add            
            CALL ammt404_mmbasite_reference()
            CALL ammt404_set_entry(p_cmd)   #單身時記得須改用l_cmd
            CALL ammt404_set_no_entry(p_cmd)   #單身時記得須改用l_cmd
            #161024-00025#7  2016/10/25 by 08742 -E
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbasite
            #add-point:BEFORE FIELD mmbasite name="input.b.mmbasite"
                                    
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbasite
            #add-point:ON CHANGE mmbasite name="input.g.mmbasite"
                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbadocdt
            #add-point:BEFORE FIELD mmbadocdt name="input.b.mmbadocdt"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbadocdt
            
            #add-point:AFTER FIELD mmbadocdt name="input.a.mmbadocdt"
                                    
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbadocdt
            #add-point:ON CHANGE mmbadocdt name="input.g.mmbadocdt"
                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbadocno
            #add-point:BEFORE FIELD mmbadocno name="input.b.mmbadocno"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbadocno
            
            #add-point:AFTER FIELD mmbadocno name="input.a.mmbadocno"
                                                #此段落由子樣板a05產生
            IF  NOT cl_null(g_mmba_m.mmbadocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND ( g_mmba_m.mmbadocno != g_mmbadocno_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmba_t WHERE "||"mmbaent = '" ||g_enterprise|| "' AND "|| "mmbadocno = '"||g_mmba_m.mmbadocno ||"'",'std-00004',0) THEN 
                     LET g_mmba_m.mmbadocno = g_mmba_m_t.mmbadocno
                     NEXT FIELD CURRENT
                  END IF
#                  CALL ammt404_mmbadocno(g_mmba_m.mmbadocno)
#                  IF NOT cl_null(g_errno) THEN
#                     CALL cl_err(g_mmba_m.mmbadocno,g_errno,1)
#                     LET g_mmba_m.mmbadocno = g_mmba_m_t.mmbadocno
#                     NEXT FIELD mmbadocno
#                  END IF
                  CALL s_aooi200_chk_slip(g_site,g_ooef004,g_mmba_m.mmbadocno,g_prog) RETURNING l_success
                  IF NOT l_success THEN
                     LET g_mmba_m.mmbadocno = g_mmba_m_t.mmbadocno
                     NEXT FIELD mmbadocno
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbadocno
            #add-point:ON CHANGE mmbadocno name="input.g.mmbadocno"
                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbaunit
            #add-point:BEFORE FIELD mmbaunit name="input.b.mmbaunit"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbaunit
            
            #add-point:AFTER FIELD mmbaunit name="input.a.mmbaunit"
                                    
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbaunit
            #add-point:ON CHANGE mmbaunit name="input.g.mmbaunit"
                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmba000
            #add-point:BEFORE FIELD mmba000 name="input.b.mmba000"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmba000
            
            #add-point:AFTER FIELD mmba000 name="input.a.mmba000"
                                    
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmba000
            #add-point:ON CHANGE mmba000 name="input.g.mmba000"
                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbastus
            #add-point:BEFORE FIELD mmbastus name="input.b.mmbastus"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbastus
            
            #add-point:AFTER FIELD mmbastus name="input.a.mmbastus"
                                    
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbastus
            #add-point:ON CHANGE mmbastus name="input.g.mmbastus"
                                    
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.mmbasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbasite
            #add-point:ON ACTION controlp INFIELD mmbasite name="input.c.mmbasite"
                                    #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mmba_m.mmbasite             #給予default值

            #給予arg
#            LET g_qryparam.arg1 = g_site #
#            LET g_qryparam.arg2 = '8' 
#            CALL q_ooed004()                                #呼叫開窗
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'mmbasite',g_mmba_m.mmbasite,'i')   #150308-00001#4  By benson add 'i'
            CALL q_ooef001_24()

            LET g_mmba_m.mmbasite = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_mmba_m.mmbasite TO mmbasite              #顯示到畫面上
            CALL ammt404_mmbasite_reference()
            NEXT FIELD mmbasite                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.mmbadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbadocdt
            #add-point:ON ACTION controlp INFIELD mmbadocdt name="input.c.mmbadocdt"
                                    
            #END add-point
 
 
         #Ctrlp:input.c.mmbadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbadocno
            #add-point:ON ACTION controlp INFIELD mmbadocno name="input.c.mmbadocno"
                                    #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mmba_m.mmbadocno             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_ooef004 #參照表編號
            LET g_qryparam.arg2 = g_prog #對應程式代號

            CALL q_ooba002_1()                                #呼叫開窗
            LET g_qryparam.arg1 = null
            LET g_qryparam.arg2 = null 
            LET g_mmba_m.mmbadocno = g_qryparam.return1              #將開窗取得的值回傳到變數
            
            DISPLAY g_mmba_m.mmbadocno TO mmbadocno              #顯示到畫面上

            NEXT FIELD mmbadocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.mmbaunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbaunit
            #add-point:ON ACTION controlp INFIELD mmbaunit name="input.c.mmbaunit"
                                    
            #END add-point
 
 
         #Ctrlp:input.c.mmba000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmba000
            #add-point:ON ACTION controlp INFIELD mmba000 name="input.c.mmba000"
                                    
            #END add-point
 
 
         #Ctrlp:input.c.mmbastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbastus
            #add-point:ON ACTION controlp INFIELD mmbastus name="input.c.mmbastus"
                                    
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_mmba_m.mmbadocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
                                                               IF NOT cl_null(g_mmba_m.mmbadocno) THEN
                     CALL s_aooi200_gen_docno(g_mmba_m.mmbasite,g_mmba_m.mmbadocno,g_mmba_m.mmbadocdt,g_prog) 
                     RETURNING  g_success,g_mmba_m.mmbadocno
                     IF g_success<>'1' THEN
                        INITIALIZE g_errparam TO NULL
LET g_errparam.code = "amm-00001"
LET g_errparam.extend = g_mmba_m.mmbadocno
LET g_errparam.popup = TRUE
CALL cl_err()

                        LET g_mmba_m.mmbadocno = g_mmbadocno_t
                        NEXT FIELD mmbadocno
                     ELSE
                        IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmba_t WHERE "||"mmbaent = '" ||g_enterprise|| "' AND "||"mmbadocno = '"||g_mmba_m.mmbadocno ||"'",'std-00004',0) THEN 
                           LET g_mmba_m.mmbadocno = g_mmbadocno_t
                           NEXT FIELD CURRENT
                        END IF    
                                      
                     END IF
                  END IF
                  CALL cl_set_comp_entry("mmbadocno",FALSE)
               #end add-point
               
               INSERT INTO mmba_t (mmbaent,mmbasite,mmbadocdt,mmbadocno,mmbaunit,mmba000,mmbastus,mmbaownid, 
                   mmbaowndp,mmbacrtid,mmbacrtdp,mmbacrtdt,mmbamodid,mmbamoddt,mmbacnfid,mmbacnfdt,mmbapstid, 
                   mmbapstdt)
               VALUES (g_enterprise,g_mmba_m.mmbasite,g_mmba_m.mmbadocdt,g_mmba_m.mmbadocno,g_mmba_m.mmbaunit, 
                   g_mmba_m.mmba000,g_mmba_m.mmbastus,g_mmba_m.mmbaownid,g_mmba_m.mmbaowndp,g_mmba_m.mmbacrtid, 
                   g_mmba_m.mmbacrtdp,g_mmba_m.mmbacrtdt,g_mmba_m.mmbamodid,g_mmba_m.mmbamoddt,g_mmba_m.mmbacnfid, 
                   g_mmba_m.mmbacnfdt,g_mmba_m.mmbapstid,g_mmba_m.mmbapstdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_mmba_m:",SQLERRMESSAGE 
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
                  CALL ammt404_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL ammt404_b_fill()
                  CALL ammt404_b_fill2('0')
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
               CALL ammt404_mmba_t_mask_restore('restore_mask_o')
               
               UPDATE mmba_t SET (mmbasite,mmbadocdt,mmbadocno,mmbaunit,mmba000,mmbastus,mmbaownid,mmbaowndp, 
                   mmbacrtid,mmbacrtdp,mmbacrtdt,mmbamodid,mmbamoddt,mmbacnfid,mmbacnfdt,mmbapstid,mmbapstdt) = (g_mmba_m.mmbasite, 
                   g_mmba_m.mmbadocdt,g_mmba_m.mmbadocno,g_mmba_m.mmbaunit,g_mmba_m.mmba000,g_mmba_m.mmbastus, 
                   g_mmba_m.mmbaownid,g_mmba_m.mmbaowndp,g_mmba_m.mmbacrtid,g_mmba_m.mmbacrtdp,g_mmba_m.mmbacrtdt, 
                   g_mmba_m.mmbamodid,g_mmba_m.mmbamoddt,g_mmba_m.mmbacnfid,g_mmba_m.mmbacnfdt,g_mmba_m.mmbapstid, 
                   g_mmba_m.mmbapstdt)
                WHERE mmbaent = g_enterprise AND mmbadocno = g_mmbadocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "mmba_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
                                             
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL ammt404_mmba_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_mmba_m_t)
               LET g_log2 = util.JSON.stringify(g_mmba_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
                                             
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_mmbadocno_t = g_mmba_m.mmbadocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="ammt404.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_mmbb_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mmbb_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL ammt404_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_mmbb_d.getLength()
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
            OPEN ammt404_cl USING g_enterprise,g_mmba_m.mmbadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN ammt404_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE ammt404_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_mmbb_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_mmbb_d[l_ac].mmbbseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_mmbb_d_t.* = g_mmbb_d[l_ac].*  #BACKUP
               LET g_mmbb_d_o.* = g_mmbb_d[l_ac].*  #BACKUP
               CALL ammt404_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
                                             
               #end add-point  
               CALL ammt404_set_no_entry_b(l_cmd)
               IF NOT ammt404_lock_b("mmbb_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH ammt404_bcl INTO g_mmbb_d[l_ac].mmbbseq,g_mmbb_d[l_ac].mmbbsite,g_mmbb_d[l_ac].mmbb002, 
                      g_mmbb_d[l_ac].mmbb003,g_mmbb_d[l_ac].mmbb004,g_mmbb_d[l_ac].mmbb001,g_mmbb_d[l_ac].mmbb005, 
                      g_mmbb_d[l_ac].mmbb006,g_mmbb_d[l_ac].mmbb007,g_mmbb_d[l_ac].mmbb008,g_mmbb_d[l_ac].mmbbunit, 
                      g_mmbb_d[l_ac].mmbb000
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_mmbb_d_t.mmbbseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_mmbb_d_mask_o[l_ac].* =  g_mmbb_d[l_ac].*
                  CALL ammt404_mmbb_t_mask()
                  LET g_mmbb_d_mask_n[l_ac].* =  g_mmbb_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL ammt404_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
                                                CALL ammt404_set_entry_b(l_cmd)
            CALL ammt404_set_no_entry_b(l_cmd)             
            IF l_cmd = 'u' then
               SELECT SUM(mmbc003) INTO l_mmbb006 FROM mmbc_t
                WHERE mmbcdocno=g_mmba_m.mmbadocno AND mmbcseq =  g_mmbb_d[l_ac].mmbbseq
                  AND mmbcent = g_enterprise
               IF NOT cl_null( l_mmbb006) THEN
                  UPDATE mmbb_t SET mmbb006 = l_mmbb006
                   WHERE mmbbdocno=g_mmba_m.mmbadocno AND mmbbseq =  g_mmbb_d[l_ac].mmbbseq
                     AND mmbbent = g_enterprise AND mmbbsite = g_mmba_m.mmbasite
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "mmbc_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')   
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF                
               END IF
               DISPLAY g_mmbb_d[l_ac].mmbb006 TO s_detail1[l_ac].mmbb006
            END IF   
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
            INITIALIZE g_mmbb_d[l_ac].* TO NULL 
            INITIALIZE g_mmbb_d_t.* TO NULL 
            INITIALIZE g_mmbb_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
            
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            #160604-00009#50 -s by 08172
            CALL s_artt220_default(g_mmba_m.mmbasite,'6')  RETURNING  l_success,g_mmbb_d[l_ac].mmbb002
            CALL ammt404_display_mmbb002()
            #160604-00009#50 -e by 08172
            #end add-point
            LET g_mmbb_d_t.* = g_mmbb_d[l_ac].*     #新輸入資料
            LET g_mmbb_d_o.* = g_mmbb_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL ammt404_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
                                    
            #end add-point
            CALL ammt404_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mmbb_d[li_reproduce_target].* = g_mmbb_d[li_reproduce].*
 
               LET g_mmbb_d[li_reproduce_target].mmbbseq = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
                                                LET g_mmbb_d[l_ac].mmbbsite = g_mmba_m.mmbasite
            LET g_mmbb_d[l_ac].mmbbunit = g_mmba_m.mmbaunit
            LET g_mmbb_d[l_ac].mmbb000 = g_mmba_m.mmba000
            CALL ammt404_display_mmbbsite()
            CALL ammt404_mmbbseq()
            LET g_mmbb_d[l_ac].mmbb006 = 0
            CALL g_mmbc_d.clear()
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
            SELECT COUNT(1) INTO l_count FROM mmbb_t 
             WHERE mmbbent = g_enterprise AND mmbbdocno = g_mmba_m.mmbadocno
 
               AND mmbbseq = g_mmbb_d[l_ac].mmbbseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
                                             
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmba_m.mmbadocno
               LET gs_keys[2] = g_mmbb_d[g_detail_idx].mmbbseq
               CALL ammt404_insert_b('mmbb_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
                                             
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_mmbb_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mmbb_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL ammt404_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
                                             
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
                                             
               #end add-point 
               
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_mmba_m.mmbadocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_mmbb_d_t.mmbbseq
 
            
               #刪除同層單身
               IF NOT ammt404_delete_b('mmbb_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE ammt404_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT ammt404_key_delete_b(gs_keys,'mmbb_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE ammt404_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
                                             
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE ammt404_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
                  UPDATE mmaz_t SET mmaz008=null,
                                    mmaz009=null,
                                    mmaz007=null
                   WHERE mmazdocno = g_mmbb_d_t.mmbb007
                     AND mmazseq = g_mmbb_d_t.mmbb008
                     AND mmazent = g_enterprise
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "mmbb_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                     CANCEL DELETE 
                  END IF                     
               #end add-point
               LET l_count = g_mmbb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
                                    
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_mmbb_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbbseq
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mmbb_d[l_ac].mmbbseq,"0","0","","","azz-00079",1) THEN
               NEXT FIELD mmbbseq
            END IF 
 
 
 
            #add-point:AFTER FIELD mmbbseq name="input.a.page1.mmbbseq"
                                                IF NOT cl_null(g_mmbb_d[l_ac].mmbbseq) THEN 
            END IF 

            #此段落由子樣板a05產生
            IF NOT cl_null(g_mmba_m.mmbadocno) AND NOT cl_null(g_mmbb_d[l_ac].mmbbseq) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND ( g_mmba_m.mmbadocno != g_mmbadocno_t OR g_mmbb_d[l_ac].mmbbseq != g_mmbb_d_t.mmbbseq))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmbb_t WHERE "||"mmbbent = '" ||g_enterprise|| "' AND "|| "mmbbdocno = '"||g_mmba_m.mmbadocno ||"' AND "|| "mmbbseq = '"||g_mmbb_d[l_ac].mmbbseq ||"'",'std-00004',0) THEN 
                     LET g_mmbb_d[l_ac].mmbbseq = g_mmbb_d_t.mmbbseq
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbbseq
            #add-point:BEFORE FIELD mmbbseq name="input.b.page1.mmbbseq"
                                                
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbbseq
            #add-point:ON CHANGE mmbbseq name="input.g.page1.mmbbseq"
                                    
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbbsite
            
            #add-point:AFTER FIELD mmbbsite name="input.a.page1.mmbbsite"
                                                LET g_mmbb_d[l_ac].mmbbsite_desc = NULL
            DISPLAY  g_mmbb_d[l_ac].mmbbsite_desc TO s_detail1[l_ac].mmbbsite_desc
            IF  NOT cl_null(g_mmbb_d[l_ac].mmbbsite)  THEN 
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND ( g_mmbb_d[l_ac].mmbbsite != g_mmbb_d_t.mmbbsite OR g_mmbb_d_t.mmbbsite IS NULL))) THEN   #160824-00007#122 by sakura mark
               IF g_mmbb_d[l_ac].mmbbsite != g_mmbb_d_o.mmbbsite OR cl_null(g_mmbb_d_o.mmbbsite) THEN    #160824-00007#122 by sakura add
#                  CALL ammt404_mmbbsite(g_mmbb_d[l_ac].mmbbsite)
#                  IF NOT cl_null(g_errno) THEN
#                     INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_mmbb_d[l_ac].mmbbsite
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

#                     LET g_mmbb_d[l_ac].mmbbsite = g_mmbb_d_t.mmbbsite
#                     CALL ammt404_display_mmbbsite()
#                     NEXT FIELD mmbbsite
#                  END IF
#                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#                  INITIALIZE g_chkparam.* TO NULL
# 
#                  #設定g_chkparam.*的參數
#                  LET g_chkparam.arg1 = g_mmbb_d[l_ac].mmbbsite
#                  LET g_chkparam.arg2 = '8'
#                  LET g_chkparam.arg3 = g_mmba_m.mmbasite
#
#
#                  #呼叫檢查存在並帶值的library
#                  IF cl_chk_exist("v_ooed004") THEN
#
#                  ELSE
#                     #檢查失敗時後續處理
#                     LET g_mmbb_d[l_ac].mmbbsite = g_mmbb_d_t.mmbbsite
#                     CALL ammt404_display_mmbbsite()
#                     NEXT FIELD mmbbsite
#                  END IF
                  CALL s_aooi500_chk(g_prog,'mmbbsite',g_mmbb_d[l_ac].mmbbsite,g_mmba_m.mmbasite) RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = g_mmbb_d[l_ac].mmbbsite
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                  
                     #LET g_mmbb_d[l_ac].mmbbsite = g_mmbb_d_t.mmbbsite   #160824-00007#122 by sakura mark
                     LET g_mmbb_d[l_ac].mmbbsite = g_mmbb_d_o.mmbbsite    #160824-00007#122 by sakura add
                     CALL ammt404_display_mmbbsite()
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_mmbb_d[l_ac].mmbb002)  THEN 
                     CALL ammt404_mmbb002(g_mmbb_d[l_ac].mmbb002,g_mmbb_d[l_ac].mmbbsite)
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_mmbb_d[l_ac].mmbbsite
                        #160318-00005#24  --add--str
                        LET g_errparam.replace[1] ='aini001'
                        LET g_errparam.replace[2] = cl_get_progname('aini001',g_lang,"2")
                        LET g_errparam.exeprog    ='aini001'
                        #160318-00005#24 --add--end
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        #LET g_mmbb_d[l_ac].mmbbsite = g_mmbb_d_t.mmbbsite   #160824-00007#122 by sakura mark
                        LET g_mmbb_d[l_ac].mmbbsite = g_mmbb_d_o.mmbbsite    #160824-00007#122 by sakura add
                        CALL ammt404_display_mmbbsite()
                        NEXT FIELD mmbbsite
                     END IF
                  END IF
               END IF
            END IF
            LET g_mmbb_d_o.* = g_mmbb_d[l_ac].*    #160824-00007#122 by sakura add            
            CALL ammt404_display_mmbbsite()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbbsite
            #add-point:BEFORE FIELD mmbbsite name="input.b.page1.mmbbsite"
                                    
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbbsite
            #add-point:ON CHANGE mmbbsite name="input.g.page1.mmbbsite"
                                    
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbb002
            
            #add-point:AFTER FIELD mmbb002 name="input.a.page1.mmbb002"
            LET g_mmbb_d[l_ac].mmbb002_desc = NULL
            DISPLAY  g_mmbb_d[l_ac].mmbb002_desc TO s_detail1[l_ac].mmbb002_desc
            IF  NOT cl_null(g_mmbb_d[l_ac].mmbb002)  THEN 
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND ( g_mmbb_d[l_ac].mmbb002 != g_mmbb_d_t.mmbb002 OR g_mmbb_d_t.mmbb002 IS NULL))) THEN   #160824-00007#122 by sakura mark
               IF g_mmbb_d[l_ac].mmbb002 != g_mmbb_d_o.mmbb002 OR cl_null(g_mmbb_d_o.mmbb002) THEN   #160824-00007#122 by sakura add
                  CALL ammt404_mmbb002(g_mmbb_d[l_ac].mmbb002,g_mmbb_d[l_ac].mmbbsite)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_mmbb_d[l_ac].mmbb002
                      #160318-00005#24  --add--str
                     LET g_errparam.replace[1] ='aini001'
                     LET g_errparam.replace[2] = cl_get_progname('aini001',g_lang,"2")
                     LET g_errparam.exeprog    ='aini001'
                     #160318-00005#24 --add--end
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_mmbb_d[l_ac].mmbb002 = g_mmbb_d_t.mmbb002   #160824-00007#122 by sakura mark
                     LET g_mmbb_d[l_ac].mmbb002 = g_mmbb_d_o.mmbb002    #160824-00007#122 by sakura add
                     CALL ammt404_display_mmbb002()
                     NEXT FIELD mmbb002
                  END IF
                  #160303-00028#16 add by yangxf (S)
                  IF NOT cl_null(g_mmbb_d[l_ac].mmbb001) AND  NOT cl_null(g_mmbb_d[l_ac].mmbb005) THEN 
                     #检查库区库存是否大于申请数量
                     CALL ammt404_chk_count()
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_mmbb_d[l_ac].mmbb002
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                    
                        #LET g_mmbb_d[l_ac].mmbb002 = g_mmbb_d_t.mmbb002   #160824-00007#122 by sakura mark
                        LET g_mmbb_d[l_ac].mmbb002 = g_mmbb_d_o.mmbb002    #160824-00007#122 by sakura add
                        CALL ammt404_display_mmbb002()
                        NEXT FIELD mmbb001
                     END IF
                  END IF 
                  #160303-00028#16 add by yangxf (E)
               END IF
            END IF
            LET g_mmbb_d_o.* = g_mmbb_d[l_ac].*    #160824-00007#122 by sakura add
            CALL ammt404_display_mmbb002()
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbb002
            #add-point:BEFORE FIELD mmbb002 name="input.b.page1.mmbb002"
                                    
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbb002
            #add-point:ON CHANGE mmbb002 name="input.g.page1.mmbb002"
                                    
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbb003
            
            #add-point:AFTER FIELD mmbb003 name="input.a.page1.mmbb003"
            LET g_mmbb_d[l_ac].mmbb003_desc = NULL
            DISPLAY  g_mmbb_d[l_ac].mmbb003_desc TO s_detail1[l_ac].mmbb003_desc
            IF  NOT cl_null(g_mmbb_d[l_ac].mmbb003)  THEN 
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND ( g_mmbb_d[l_ac].mmbb003 != g_mmbb_d_t.mmbb003 OR g_mmbb_d_t.mmbb003 IS NULL))) THEN   #160824-00007#122 by sakura mark
               IF g_mmbb_d[l_ac].mmbb003 != g_mmbb_d_o.mmbb003 OR cl_null(g_mmbb_d_o.mmbb003) THEN   #160824-00007#122 by sakura add 
#                  CALL ammt404_mmbbsite(g_mmbb_d[l_ac].mmbb003)
#                  IF NOT cl_null(g_errno) THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = g_errno
#                     LET g_errparam.extend = g_mmbb_d[l_ac].mmbb003
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#
#                     LET g_mmbb_d[l_ac].mmbb003 = g_mmbb_d_t.mmbb003
#                     CALL ammt404_display_mmbb003()
#                     NEXT FIELD mmbb003
#                  END IF
                  
                  IF s_aooi500_setpoint(g_prog,'mmbb003') THEN
                     CALL s_aooi500_chk(g_prog,'mmbb003',g_mmbb_d[l_ac].mmbb003,g_mmba_m.mmbasite) RETURNING l_success,l_errno
                     IF NOT l_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = g_mmbb_d[l_ac].mmbb003
                        LET g_errparam.code   = l_errno
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                     
                        #LET g_mmbb_d[l_ac].mmbb003 = g_mmbb_d_t.mmbb003  #160824-00007#122 by sakura mark
                        LET g_mmbb_d[l_ac].mmbb003 = g_mmbb_d_o.mmbb003   #160824-00007#122 by sakura add
                        CALL ammt404_display_mmbb003()
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     CALL ammt404_mmbbsite(g_mmbb_d[l_ac].mmbb003)
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_mmbb_d[l_ac].mmbb003
                        #160318-00005#24  --add--str
                        LET g_errparam.replace[1] ='aooi100'
                        LET g_errparam.replace[2] = cl_get_progname('aooi100',g_lang,"2")
                        LET g_errparam.exeprog    ='aooi100'
                        #160318-00005#24 --add--end
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                     
                        #LET g_mmbb_d[l_ac].mmbb003 = g_mmbb_d_t.mmbb003  #160824-00007#122 by sakura mark
                        LET g_mmbb_d[l_ac].mmbb003 = g_mmbb_d_o.mmbb003   #160824-00007#122 by sakura add
                        CALL ammt404_display_mmbb003()
                        NEXT FIELD mmbb003
                     END IF
                  END IF
                  #160604-00009#50 -s by 08172
                  CALL s_artt220_default(g_mmbb_d[l_ac].mmbb003,'6')  RETURNING  l_success,g_mmbb_d[l_ac].mmbb004
                  CALL ammt404_display_mmbb004()
                  #160604-00009#50 -e by 08172
                  IF  NOT cl_null(g_mmbb_d[l_ac].mmbb004)  THEN
                      CALL ammt404_mmbb002(g_mmbb_d[l_ac].mmbb004,g_mmbb_d[l_ac].mmbb003)
                      IF NOT cl_null(g_errno) THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = g_errno
                      LET g_errparam.extend = g_mmbb_d[l_ac].mmbb003
                       #160318-00005#24  --add--str
                      LET g_errparam.replace[1] ='aini001'
                      LET g_errparam.replace[2] = cl_get_progname('aini001',g_lang,"2")
                      LET g_errparam.exeprog    ='aini001'
                      #160318-00005#24 --add--end
                      LET g_errparam.popup = TRUE
                      CALL cl_err()

                      #LET g_mmbb_d[l_ac].mmbb003 = g_mmbb_d_t.mmbb003  #160824-00007#122 by sakura mark
                      LET g_mmbb_d[l_ac].mmbb003 = g_mmbb_d_o.mmbb003   #160824-00007#122 by sakura add
                      CALL ammt404_display_mmbb003()
                      NEXT FIELD mmbb003
                     END IF
                  END IF
               END IF
            END IF
            LET g_mmbb_d_o.* = g_mmbb_d[l_ac].*   #160824-00007#122 by sakura add
            CALL ammt404_display_mmbb003()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbb003
            #add-point:BEFORE FIELD mmbb003 name="input.b.page1.mmbb003"
                                    
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbb003
            #add-point:ON CHANGE mmbb003 name="input.g.page1.mmbb003"
                                    
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbb004
            
            #add-point:AFTER FIELD mmbb004 name="input.a.page1.mmbb004"
                                                LET g_mmbb_d[l_ac].mmbb004_desc = NULL
            DISPLAY  g_mmbb_d[l_ac].mmbb004_desc TO s_detail1[l_ac].mmbb004_desc
            IF  NOT cl_null(g_mmbb_d[l_ac].mmbb004)  THEN 
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND ( g_mmbb_d[l_ac].mmbb004 != g_mmbb_d_t.mmbb004 OR g_mmbb_d_t.mmbb004 IS NULL))) THEN   #160824-00007#122 by sakura mark
               IF g_mmbb_d[l_ac].mmbb004 != g_mmbb_d_o.mmbb004 OR cl_null(g_mmbb_d_o.mmbb004) THEN   #160824-00007#122 by sakura add
                  CALL ammt404_mmbb002(g_mmbb_d[l_ac].mmbb004,g_mmbb_d[l_ac].mmbb003)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_mmbb_d[l_ac].mmbb004
                     #160318-00005#24  --add--str
                     LET g_errparam.replace[1] ='aini001'
                     LET g_errparam.replace[2] = cl_get_progname('aini001',g_lang,"2")
                     LET g_errparam.exeprog    ='aini001'
                     #160318-00005#24 --add--end
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_mmbb_d[l_ac].mmbb004 = g_mmbb_d_t.mmbb004  #160824-00007#122 by sakura mark
                     LET g_mmbb_d[l_ac].mmbb004 = g_mmbb_d_o.mmbb004   #160824-00007#122 by sakura add
                     CALL ammt404_display_mmbb004()
                     NEXT FIELD mmbb004
                  END IF
               END IF
            END IF
            LET g_mmbb_d_o.* = g_mmbb_d[l_ac].*   #160824-00007#122 by sakura add
            CALL ammt404_display_mmbb004()
            

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbb004
            #add-point:BEFORE FIELD mmbb004 name="input.b.page1.mmbb004"
                                    
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbb004
            #add-point:ON CHANGE mmbb004 name="input.g.page1.mmbb004"
                                    
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbb001
            
            #add-point:AFTER FIELD mmbb001 name="input.a.page1.mmbb001"
            LET g_mmbb_d[l_ac].mmbb001_desc = NULL
            DISPLAY  g_mmbb_d[l_ac].mmbb001_desc TO s_detail1[l_ac].mmbb001_desc
            IF  NOT cl_null(g_mmbb_d[l_ac].mmbb001)  THEN 
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND ( g_mmbb_d[l_ac].mmbb001 != g_mmbb_d_t.mmbb001 OR g_mmbb_d_t.mmbb001 IS NULL))) THEN   #160824-00007#122 by sakura mark
               IF g_mmbb_d[l_ac].mmbb001 != g_mmbb_d_o.mmbb001 OR cl_null(g_mmbb_d_o.mmbb001) THEN   #160824-00007#122 by sakura add
                  CALL ammt404_mmbb001()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_mmbb_d[l_ac].mmbb001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_mmbb_d[l_ac].mmbb001 = g_mmbb_d_t.mmbb001   #160824-00007#122 by sakura mark
                     LET g_mmbb_d[l_ac].mmbb001 = g_mmbb_d_o.mmbb001    #160824-00007#122 by sakura add
                     CALL ammt404_display_mmbb001()
                     NEXT FIELD mmbb001
                  END IF
                  call ammt404_chk_mmbb001(g_mmbb_d[l_ac].mmbbsite,g_mmbb_d[l_ac].mmbb003)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_mmbb_d[l_ac].mmbb001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_mmbb_d[l_ac].mmbb001 = g_mmbb_d_t.mmbb001   #160824-00007#122 by sakura mark
                     LET g_mmbb_d[l_ac].mmbb001 = g_mmbb_d_o.mmbb001    #160824-00007#122 by sakura add
                     CALL ammt404_display_mmbb001()
                     NEXT FIELD mmbb001
                  END IF
                  CALL ammt404_chk_count()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_mmbb_d[l_ac].mmbb001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_mmbb_d[l_ac].mmbb001 = g_mmbb_d_t.mmbb001   #160824-00007#122 by sakura mark
                     LET g_mmbb_d[l_ac].mmbb001 = g_mmbb_d_o.mmbb001    #160824-00007#122 by sakura add
                     CALL ammt404_display_mmbb001()
                     NEXT FIELD mmbb001
                  END IF
               END IF
            END IF
            LET g_mmbb_d_o.* = g_mmbb_d[l_ac].*   #160824-00007#122 by sakura add
            CALL ammt404_display_mmbb001()
            

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbb001
            #add-point:BEFORE FIELD mmbb001 name="input.b.page1.mmbb001"
                                                CALL ammt404_set_entry_b(l_cmd)
            CALL ammt404_set_no_entry_b(l_cmd)
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbb001
            #add-point:ON CHANGE mmbb001 name="input.g.page1.mmbb001"
                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbb005
            #add-point:BEFORE FIELD mmbb005 name="input.b.page1.mmbb005"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbb005
            
            #add-point:AFTER FIELD mmbb005 name="input.a.page1.mmbb005"
            IF  NOT cl_null(g_mmbb_d[l_ac].mmbb005)  THEN 
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND ( g_mmbb_d[l_ac].mmbb005 != g_mmbb_d_t.mmbb005 OR g_mmbb_d_t.mmbb005 IS NULL))) THEN   #160824-00007#122 by sakura mark
               IF g_mmbb_d[l_ac].mmbb005 != g_mmbb_d_o.mmbb005 OR cl_null(g_mmbb_d_o.mmbb005) THEN   #160824-00007#122 by sakura add
                  #160303-00028#16 add by yangxf 20160314 (S)
                  IF cl_null(g_mmbb_d[l_ac].mmbb002) THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'amm-00496'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_mmbb_d[l_ac].mmbb005 = ''
                     NEXT FIELD mmbb002
                  END IF 
                  #160303-00028#16 add by yangxf 20160314 (E)
                  CALL ammt404_chk_count()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_mmbb_d[l_ac].mmbb005
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_mmbb_d[l_ac].mmbb005 = g_mmbb_d_t.mmbb005   #160824-00007#122 by sakura mark
                     LET g_mmbb_d[l_ac].mmbb005 = g_mmbb_d_o.mmbb005    #160824-00007#122 by sakura add
                     NEXT FIELD mmbb005
                  END IF
                  #160524-00053#1   add by pengxin 2016/05/25(S)
                  IF cl_null(g_mmbb_d[l_ac].mmbb007) THEN
                     IF g_mmbb_d[l_ac].mmbb005 <= 0 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'aqc-00004'
                        LET g_errparam.extend = g_mmbb_d[l_ac].mmbb005
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
   
                        #LET g_mmbb_d[l_ac].mmbb005 = g_mmbb_d_t.mmbb005   #160824-00007#122 by sakura mark
                        LET g_mmbb_d[l_ac].mmbb005 = g_mmbb_d_o.mmbb005    #160824-00007#122 by sakura add
                        NEXT FIELD mmbb005
                     END IF
                  END IF
                  #160524-00053#1   add by pengxin 2016/05/25(E)
               END IF
            END IF
            LET g_mmbb_d_o.* = g_mmbb_d[l_ac].*    #160824-00007#122 by sakura add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbb005
            #add-point:ON CHANGE mmbb005 name="input.g.page1.mmbb005"
                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbb006
            #add-point:BEFORE FIELD mmbb006 name="input.b.page1.mmbb006"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbb006
            
            #add-point:AFTER FIELD mmbb006 name="input.a.page1.mmbb006"
                                    
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbb006
            #add-point:ON CHANGE mmbb006 name="input.g.page1.mmbb006"
                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbb007
            #add-point:BEFORE FIELD mmbb007 name="input.b.page1.mmbb007"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbb007
            
            #add-point:AFTER FIELD mmbb007 name="input.a.page1.mmbb007"
                                    
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbb007
            #add-point:ON CHANGE mmbb007 name="input.g.page1.mmbb007"
                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbb008
            #add-point:BEFORE FIELD mmbb008 name="input.b.page1.mmbb008"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbb008
            
            #add-point:AFTER FIELD mmbb008 name="input.a.page1.mmbb008"
                                    
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbb008
            #add-point:ON CHANGE mmbb008 name="input.g.page1.mmbb008"
                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbbunit
            #add-point:BEFORE FIELD mmbbunit name="input.b.page1.mmbbunit"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbbunit
            
            #add-point:AFTER FIELD mmbbunit name="input.a.page1.mmbbunit"
                                    
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbbunit
            #add-point:ON CHANGE mmbbunit name="input.g.page1.mmbbunit"
                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbb000
            #add-point:BEFORE FIELD mmbb000 name="input.b.page1.mmbb000"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbb000
            
            #add-point:AFTER FIELD mmbb000 name="input.a.page1.mmbb000"
                                    
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbb000
            #add-point:ON CHANGE mmbb000 name="input.g.page1.mmbb000"
                                    
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.mmbbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbbseq
            #add-point:ON ACTION controlp INFIELD mmbbseq name="input.c.page1.mmbbseq"
                                    
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmbbsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbbsite
            #add-point:ON ACTION controlp INFIELD mmbbsite name="input.c.page1.mmbbsite"
                                    #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mmbb_d[l_ac].mmbbsite             #給予default值
#            LET g_qryparam.arg1 = g_mmba_m.mmbasite
#            LET g_qryparam.arg2 = '8'
#            #給予arg
#
#            CALL q_ooed004()                                #呼叫開窗
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'mmbbsite',g_mmba_m.mmbasite,'i')   #150308-00001#4  By benson add 'i'
            CALL q_ooef001_24()

            LET g_mmbb_d[l_ac].mmbbsite = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_mmbb_d[l_ac].mmbbsite TO mmbbsite              #顯示到畫面上
            CALL ammt404_display_mmbbsite() 
            NEXT FIELD mmbbsite                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.mmbb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbb002
            #add-point:ON ACTION controlp INFIELD mmbb002 name="input.c.page1.mmbb002"
                                    #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mmbb_d[l_ac].mmbb002             #給予default值

            #給予arg
            IF NOT cl_null(g_mmbb_d[l_ac].mmbbsite) THEN
               LET g_qryparam.where = " inaasite = '",g_mmbb_d[l_ac].mmbbsite,"' "
            END IF   
            CALL q_inaa001_5()  
            LET g_mmbb_d[l_ac].mmbb002 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_qryparam.where = null
            DISPLAY g_mmbb_d[l_ac].mmbb002 TO mmbb002              #顯示到畫面上
            CALL ammt404_display_mmbb002()
            NEXT FIELD mmbb002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.mmbb003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbb003
            #add-point:ON ACTION controlp INFIELD mmbb003 name="input.c.page1.mmbb003"
                                    #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mmbb_d[l_ac].mmbb003             #給予default值

            #給予arg
#            CALL q_ooef001()                                #呼叫開窗
            IF s_aooi500_setpoint(g_prog,'mmbb003') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'mmbb003',g_mmba_m.mmbasite,'i')   #150308-00001#4  By benson add 'i'
               CALL q_ooef001_24()
            ELSE
               LET g_qryparam.where = "ooef201 = 'Y'"     #161024-00025#11  2016/10/28  by 08742  add
               CALL q_ooef001()
            END IF

            LET g_mmbb_d[l_ac].mmbb003 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_qryparam.where = null
            DISPLAY g_mmbb_d[l_ac].mmbb003 TO mmbb003              #顯示到畫面上
            CALL ammt404_display_mmbb003()
            NEXT FIELD mmbb003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.mmbb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbb004
            #add-point:ON ACTION controlp INFIELD mmbb004 name="input.c.page1.mmbb004"
                                    #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mmbb_d[l_ac].mmbb004             #給予default值

            #給予arg

           IF NOT cl_null(g_mmbb_d[l_ac].mmbb003) THEN
               LET g_qryparam.where = " inaasite = '",g_mmbb_d[l_ac].mmbb003,"' "
            END IF   
            CALL q_inaa001_5()                               #呼叫開窗
            LET g_qryparam.where = null
            LET g_mmbb_d[l_ac].mmbb004 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_mmbb_d[l_ac].mmbb004 TO mmbb004              #顯示到畫面上
            CALL ammt404_display_mmbb004()
            NEXT FIELD mmbb004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.mmbb001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbb001
            #add-point:ON ACTION controlp INFIELD mmbb001 name="input.c.page1.mmbb001"
                                    #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mmbb_d[l_ac].mmbb001             #給予default值

            #給予arg
            IF g_type='1' THEN
               CALL q_mman001()                                #呼叫開窗
            END IF
            IF g_type='2' THEN
               CALL q_gcaf001()
            END IF
            LET g_mmbb_d[l_ac].mmbb001 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_mmbb_d[l_ac].mmbb001 TO mmbb001              #顯示到畫面上

            NEXT FIELD mmbb001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.mmbb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbb005
            #add-point:ON ACTION controlp INFIELD mmbb005 name="input.c.page1.mmbb005"
                                    
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmbb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbb006
            #add-point:ON ACTION controlp INFIELD mmbb006 name="input.c.page1.mmbb006"
                                    
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmbb007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbb007
            #add-point:ON ACTION controlp INFIELD mmbb007 name="input.c.page1.mmbb007"
                                    
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmbb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbb008
            #add-point:ON ACTION controlp INFIELD mmbb008 name="input.c.page1.mmbb008"
                                    
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmbbunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbbunit
            #add-point:ON ACTION controlp INFIELD mmbbunit name="input.c.page1.mmbbunit"
                                    
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmbb000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbb000
            #add-point:ON ACTION controlp INFIELD mmbb000 name="input.c.page1.mmbb000"
                                    
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_mmbb_d[l_ac].* = g_mmbb_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE ammt404_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_mmbb_d[l_ac].mmbbseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_mmbb_d[l_ac].* = g_mmbb_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
                                             
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL ammt404_mmbb_t_mask_restore('restore_mask_o')
      
               UPDATE mmbb_t SET (mmbbdocno,mmbbseq,mmbbsite,mmbb002,mmbb003,mmbb004,mmbb001,mmbb005, 
                   mmbb006,mmbb007,mmbb008,mmbbunit,mmbb000) = (g_mmba_m.mmbadocno,g_mmbb_d[l_ac].mmbbseq, 
                   g_mmbb_d[l_ac].mmbbsite,g_mmbb_d[l_ac].mmbb002,g_mmbb_d[l_ac].mmbb003,g_mmbb_d[l_ac].mmbb004, 
                   g_mmbb_d[l_ac].mmbb001,g_mmbb_d[l_ac].mmbb005,g_mmbb_d[l_ac].mmbb006,g_mmbb_d[l_ac].mmbb007, 
                   g_mmbb_d[l_ac].mmbb008,g_mmbb_d[l_ac].mmbbunit,g_mmbb_d[l_ac].mmbb000)
                WHERE mmbbent = g_enterprise AND mmbbdocno = g_mmba_m.mmbadocno 
 
                  AND mmbbseq = g_mmbb_d_t.mmbbseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
                                             
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_mmbb_d[l_ac].* = g_mmbb_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mmbb_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_mmbb_d[l_ac].* = g_mmbb_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mmbb_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmba_m.mmbadocno
               LET gs_keys_bak[1] = g_mmbadocno_t
               LET gs_keys[2] = g_mmbb_d[g_detail_idx].mmbbseq
               LET gs_keys_bak[2] = g_mmbb_d_t.mmbbseq
               CALL ammt404_update_b('mmbb_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL ammt404_mmbb_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_mmbb_d[g_detail_idx].mmbbseq = g_mmbb_d_t.mmbbseq 
 
                  ) THEN
                  LET gs_keys[01] = g_mmba_m.mmbadocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_mmbb_d_t.mmbbseq
 
                  CALL ammt404_key_update_b(gs_keys,'mmbb_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_mmba_m),util.JSON.stringify(g_mmbb_d_t)
               LET g_log2 = util.JSON.stringify(g_mmba_m),util.JSON.stringify(g_mmbb_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
                                             
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
                                    
            #end add-point
            CALL ammt404_unlock_b("mmbb_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            #add-point:單身after_row2 name="input.body.after_row2"
            
            #end add-point
              
         AFTER INPUT
            #add-point:input段after input  name="input.body.after_input"
                                    
            #end add-point 
    
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_mmbb_d[li_reproduce_target].* = g_mmbb_d[li_reproduce].*
 
               LET g_mmbb_d[li_reproduce_target].mmbbseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_mmbb_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_mmbb_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="ammt404.input.other" >}
      
      #add-point:自定義input name="input.more_input"
                        INPUT ARRAY g_mmbc_d FROM s_detail2.*
          ATTRIBUTE(COUNT = g_rec_b2,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF cl_null(l_ac) OR l_ac=0 THEN
               LET l_ac=1
            END IF
            LET l_cnt1 = 0
            SELECT count(*) INTO l_cnt1 FROM mmbb_t
             WHERE mmbbdocno = g_mmba_m.mmbadocno AND mmbbent = g_enterprise
               AND mmbbsite = g_mmba_m.mmbasite AND mmbbseq = g_mmbb_d[l_ac].mmbbseq
            IF l_cnt1 = 0 THEN
               NEXT FIELD mmbbseq
            END IF
            CALL ammt404_b_fill_2()
            LET g_rec_b2 = g_mmbc_d.getLength()
         
         BEFORE ROW
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac2 = ARR_CURR()
            LET g_detail_idx = l_ac2
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac2 TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN ammt404_cl USING g_enterprise,g_mmba_m.mmbadocno
                                                                


            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN ammt404_cl:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CLOSE ammt404_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            
            LET g_rec_b2 = g_mmbc_d.getLength()
            
            IF g_rec_b2 >= l_ac2 
               AND NOT cl_null(g_mmbc_d[l_ac2].mmbcseq1) 

            THEN
               LET l_cmd='u'
	           LET g_mmbc_d_t.* = g_mmbc_d[l_ac2].*  #BACKUP
	           LET g_mmbc_d_o.* = g_mmbc_d[l_ac2].*  #BACKUP   #160824-00007#122 by sakura add
               CALL ammt404_set_entry_b(l_cmd)
               CALL ammt404_set_no_entry_b(l_cmd)
               OPEN ammt404_bcl_2 USING g_enterprise,
                                       g_mmba_m.mmbadocno,g_mmbb_d[l_ac].mmbbseq,g_mmbc_d[l_ac2].mmbcseq1
                                       
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "ammt404_bcl_2"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET l_lock_sw='Y'
               ELSE
                  FETCH ammt404_bcl_2 INTO g_mmbc_d[l_ac2].mmbcseq,g_mmbc_d[l_ac2].mmbcseq1,g_mmbc_d[l_ac2].mmbc001,g_mmbc_d[l_ac2].mmbc002,g_mmbc_d[l_ac2].mmbc003,
                                           g_mmbc_d[l_ac2].mmbcsite,g_mmbc_d[l_ac2].mmbcunit,g_mmbc_d[l_ac2].mmbc000
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = g_mmbc_d_t.mmbcseq
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                  END IF
                  LET g_bfill = "N"
                  CALL ammt404_show()
                  LET g_bfill = "Y"
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            
            
        
         BEFORE INSERT
            
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_mmbc_d[l_ac2].* TO NULL 
            
            LET g_mmbc_d_t.* = g_mmbc_d[l_ac2].*     #新輸入資料
            LET g_mmbc_d_o.* = g_mmbc_d[l_ac2].*     #新輸入資料   #160824-00007#122 by sakura add
            CALL cl_show_fld_cont()
            CALL ammt404_set_entry_b(l_cmd)
            CALL ammt404_set_no_entry_b(l_cmd)
            #公用欄位給值(單身)
             LET g_mmbc_d[l_ac2].mmbcseq=g_mmbb_d[l_ac].mmbbseq
             CALL ammt404_mmbcseq1()
             LET g_mmbc_d[l_ac2].mmbcunit = g_mmbb_d[l_ac].mmbbunit
             LET g_mmbc_d[l_ac2].mmbc000 = g_type
             LET g_mmbc_d[l_ac2].mmbcsite = g_mmbb_d[l_ac].mmbbsite
             
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM mmbc_t 
             WHERE mmbcent = g_enterprise AND mmbcdocno = g_mmba_m.mmbadocno
               AND mmbcseq = g_mmbc_d[l_ac2].mmbcseq
               AND mmbcseq1 = g_mmbc_d[l_ac2].mmbcseq1

                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               INSERT INTO mmbc_t
                  (mmbcent,mmbcdocno,mmbcsite,mmbcseq,mmbcseq1
                   ,mmbc001,mmbc002,mmbc003,mmbcunit,mmbc000) 
               VALUES(g_enterprise,
                   g_mmba_m.mmbadocno,g_mmbb_d[l_ac].mmbbsite,g_mmbb_d[l_ac].mmbbseq,g_mmbc_d[l_ac2].mmbcseq1
                   ,g_mmbc_d[l_ac2].mmbc001,g_mmbc_d[l_ac2].mmbc002,g_mmbc_d[l_ac2].mmbc003,g_mmbc_d[l_ac2].mmbcunit,g_mmbc_d[l_ac2].mmbc000)
      #add-point:insert_b段資料新增中
               
               
      #end add-point 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "mmbb_t"
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

               ELSE
                  SELECT SUM(mmbc003) INTO l_mmbb006 FROM mmbc_t
                   WHERE mmbcdocno=g_mmba_m.mmbadocno AND mmbcseq =  g_mmbb_d[l_ac].mmbbseq
                     AND mmbcent = g_enterprise
                  IF NOT cl_null( l_mmbb006) THEN
                     UPDATE mmbb_t SET mmbb006 = l_mmbb006
                      WHERE mmbbdocno=g_mmba_m.mmbadocno AND mmbbseq =  g_mmbb_d[l_ac].mmbbseq
                        AND mmbbent = g_enterprise
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "mmbc_t"
                        LET g_errparam.popup = FALSE
                        CALL cl_err()
                      
                     ELSE
                     END IF                              
                  END IF
               END IF  
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_mmbc_d[l_ac2].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "mmbc_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               
               #先刷新資料
               #CALL ammt404_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert

               #end add-point
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_rec_b2 = g_rec_b2 + 1
            END IF
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               CALL FGL_SET_ARR_CURR(l_ac2-1)
               CALL g_mmbc_d.deleteElement(l_ac2)
               NEXT FIELD mmbcseq1
            END IF
            IF NOT cl_null(g_mmbc_d[l_ac2].mmbcseq1) 

               THEN 
               
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  -263
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CANCEL DELETE
               END IF
               
               #add-point:單身刪除前

               #end add-point 
               
               DELETE FROM mmbc_t
                WHERE mmbcent = g_enterprise AND mmbcdocno = g_mmba_m.mmbadocno AND
                      mmbcseq = g_mmbb_d[l_ac].mmbbseq AND mmbcseq1 = g_mmbc_d_t.mmbcseq1

                  
               #add-point:單身刪除中

               #end add-point 
               
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "mmbc_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  SELECT SUM(mmbc003) INTO l_mmbb006 FROM mmbc_t
                   WHERE mmbcdocno=g_mmba_m.mmbadocno AND mmbcseq =  g_mmbb_d[l_ac].mmbbseq
                     AND mmbcent = g_enterprise 
                  IF NOT cl_null( l_mmbb006) THEN
                     UPDATE mmbb_t SET mmbb006 = l_mmbb006
                      WHERE mmbbdocno=g_mmba_m.mmbadocno AND mmbbseq =  g_mmbb_d[l_ac].mmbbseq
                        AND mmbbent = g_enterprise AND mmbbsite = g_mmba_m.mmbasite
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "mmbc_t"
                        LET g_errparam.popup = FALSE
                        CALL cl_err()
                      
                     ELSE
                     END IF                              
                  END IF
                  
                  LET g_rec_b2 = g_rec_b2-1
                  
                  #add-point:單身刪除後

                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE ammt404_bcl_2
               LET l_count = g_mmbc_d.getLength()
            END IF 
            
               INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmba_m.mmbadocno
               LET gs_keys[2] = g_mmbb_d[l_ac].mmbbseq

              
         AFTER DELETE 
            #add-point:單身刪除後2

            #end add-point
            DELETE FROM mmbc_t
                WHERE mmbcent = g_enterprise AND mmbcdocno = g_mmba_m.mmbadocno AND
                      mmbcseq = g_mmbb_d[l_ac].mmbbseq AND mmbcseq1 = g_mmbc_d_t.mmbcseq1
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = ""
               LET g_errparam.popup = FALSE
               CALL cl_err()

            END IF
            
 
         #---------------------<  Detail: page1  >---------------------
         #----<<mmbcseq>>----
         #此段落由子樣板a02產生
         AFTER FIELD mmbcseq
            #此段落由子樣板a15產生
            IF NOT ap_chk_Range(g_mmbc_d[l_ac2].mmbcseq,"0","1","","","test",1) THEN
               NEXT FIELD mmbcseq
            END IF
            

         #此段落由子樣板a01產生
         BEFORE FIELD mmbcseq
            #add-point:BEFORE FIELD mmbcseq
            
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE mmbcseq
            #add-point:ON CHANGE mmbcseq

            #END add-point

         #----<<mmbc002>>----
         #此段落由子樣板a02產生
         AFTER FIELD mmbcseq1
            
            #add-point:AFTER FIELD mmbcseq1
            IF g_mmbc_d[l_ac2].mmbcseq1<=0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "aim-00009"
               LET g_errparam.extend = g_mmbc_d[l_ac2].mmbcseq1
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_mmbc_d[l_ac2].mmbcseq1=g_mmbc_d_t.mmbcseq1
               NEXT FIELD mmbcseq1
            END IF
            #END add-point
            

         #此段落由子樣板a01產生
         BEFORE FIELD mmbcseq1
            #add-point:BEFORE FIELD mmbcseq1
            
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE mmbcseq1
            #add-point:ON CHANGE mmbcseq1

            #END add-point

         #----<<mmbc003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbc001
            #add-point:BEFORE FIELD mmbc001

            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD mmbc001
            
            #add-point:AFTER FIELD mmbc001
            IF  NOT cl_null(g_mmbc_d[l_ac2].mmbc001)  THEN 
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND ( g_mmbc_d[l_ac2].mmbc001 != g_mmbc_d_t.mmbc001 OR g_mmbc_d_t.mmbc001 IS NULL))) THEN   #160824-00007#122 by sakura mark
               IF g_mmbc_d[l_ac2].mmbc001 != g_mmbc_d_o.mmbc001 OR cl_null(g_mmbc_d_o.mmbc001) THEN   #160824-00007#122 by sakura add
                  CALL ammt404_mmbc001(g_mmbc_d[l_ac2].mmbc001)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_mmbc_d[l_ac2].mmbc001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_mmbc_d[l_ac2].mmbc001 = g_mmbc_d_t.mmbc001   #160824-00007#122 by sakura mark
                     LET g_mmbc_d[l_ac2].mmbc001 = g_mmbc_d_o.mmbc001    #160824-00007#122 by sakura add
                     NEXT FIELD mmbc001
                  END IF
                  CALL ammt404_mmbc002()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ""
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_mmbc_d[l_ac2].mmbc001 = g_mmbc_d_t.mmbc001   #160824-00007#122 by sakura mark
                     LET g_mmbc_d[l_ac2].mmbc001 = g_mmbc_d_o.mmbc001    #160824-00007#122 by sakura add
                     NEXT FIELD mmbc001
                  END IF
                  CALL ammt404_mmbc001_after(l_cmd)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_mmbc_d[l_ac2].mmbc001||'|'||g_mmbc_d[l_ac2].mmbc002
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_mmbc_d[l_ac2].mmbc001 = g_mmbc_d_t.mmbc001   #160824-00007#122 by sakura mark
                     LET g_mmbc_d[l_ac2].mmbc001 = g_mmbc_d_o.mmbc001    #160824-00007#122 by sakura add
                     NEXT FIELD mmbc001
                  END IF
                  CALL ammt404_chk_mmbc001()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_mmbc_d[l_ac2].mmbc001||'-'||g_mmbc_d[l_ac2].mmbc002
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_mmbc_d[l_ac2].mmbc001 = g_mmbc_d_t.mmbc001   #160824-00007#122 by sakura mark
                     LET g_mmbc_d[l_ac2].mmbc001 = g_mmbc_d_o.mmbc001    #160824-00007#122 by sakura add
                     NEXT FIELD mmbc001
                  END IF
               END IF
               IF g_type='1' THEN
                  SELECT count(*) INTO g_mmbc_d[l_ac2].mmbc003 FROM mmaq_t WHERE mmaq001 BETWEEN g_mmbc_d[l_ac2].mmbc001 AND g_mmbc_d[l_ac2].mmbc002
                     AND mmaq002 = g_mmbb_d[l_ac].mmbb001
                     AND mmaqent = g_enterprise #160905-00007#6 add
               END IF
               IF g_type='2' THEN
                  SELECT count(*) INTO g_mmbc_d[l_ac2].mmbc003 FROM gcao_t WHERE gcao001 BETWEEN g_mmbc_d[l_ac2].mmbc001 AND g_mmbc_d[l_ac2].mmbc002
                     AND gcao002 = g_mmbb_d[l_ac].mmbb001
                     AND gcaoent = g_enterprise #160905-00007#6 add
               END IF
               DISPLAY g_mmbc_d[l_ac2].mmbc003 to s_detail2[l_ac2].mmbc003
            END IF
            LET g_mmbc_d_o.* = g_mmbc_d[l_ac2].*    #160824-00007#122 by sakura add
            #END add-point
            

         #此段落由子樣板a04產生
         ON CHANGE mmbc001
            #add-point:ON CHANGE mmbc001

            #END add-point

         #----<<mmbc004>>----
         #此段落由子樣板a02產生
         AFTER FIELD mmbc002
            
            #add-point:AFTER FIELD mmbc004
            IF  NOT cl_null(g_mmbc_d[l_ac2].mmbc002)  THEN 
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND ( g_mmbc_d[l_ac2].mmbc002 != g_mmbc_d_t.mmbc002 OR g_mmbc_d_t.mmbc002 IS NULL))) THEN   #160824-00007#122 by sakura mark
               IF g_mmbc_d[l_ac2].mmbc002 != g_mmbc_d_o.mmbc002 OR cl_null(g_mmbc_d_o.mmbc002) THEN    #160824-00007#122 by sakura add
                  CALL ammt404_mmbc001(g_mmbc_d[l_ac2].mmbc002)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_mmbc_d[l_ac2].mmbc002
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_mmbc_d[l_ac2].mmbc002 = g_mmbc_d_t.mmbc002   #160824-00007#122 by sakura mark
                     LET g_mmbc_d[l_ac2].mmbc002 = g_mmbc_d_o.mmbc002    #160824-00007#122 by sakura add
                     NEXT FIELD mmbc002
                  END IF
                  CALL ammt404_mmbc002()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ""
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_mmbc_d[l_ac2].mmbc002 = g_mmbc_d_t.mmbc002   #160824-00007#122 by sakura mark
                     LET g_mmbc_d[l_ac2].mmbc002 = g_mmbc_d_o.mmbc002    #160824-00007#122 by sakura add
                     NEXT FIELD mmbc002
                  END IF
                  CALL ammt404_mmbc001_after(l_cmd)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_mmbc_d[l_ac2].mmbc001||'|'||g_mmbc_d[l_ac2].mmbc002
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_mmbc_d[l_ac2].mmbc002 = g_mmbc_d_t.mmbc002   #160824-00007#122 by sakura mark
                     LET g_mmbc_d[l_ac2].mmbc002 = g_mmbc_d_o.mmbc002    #160824-00007#122 by sakura add
                     NEXT FIELD mmbc002
                  END IF
                  CALL ammt404_chk_mmbc001()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_mmbc_d[l_ac2].mmbc001||'-'||g_mmbc_d[l_ac2].mmbc002
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_mmbc_d[l_ac2].mmbc002 = g_mmbc_d_t.mmbc002   #160824-00007#122 by sakura mark
                     LET g_mmbc_d[l_ac2].mmbc002 = g_mmbc_d_o.mmbc002    #160824-00007#122 by sakura add
                     NEXT FIELD mmbc002
                  END IF
               END IF
               IF g_type='1' THEN
                  SELECT count(*) INTO g_mmbc_d[l_ac2].mmbc003 FROM mmaq_t WHERE mmaq001 BETWEEN g_mmbc_d[l_ac2].mmbc001 AND g_mmbc_d[l_ac2].mmbc002
                     AND mmaq002 = g_mmbb_d[l_ac].mmbb001
                     AND mmaqent = g_enterprise #160905-00007#6 add
               END IF
               IF g_type='2' THEN
                  SELECT count(*) INTO g_mmbc_d[l_ac2].mmbc003 FROM gcao_t WHERE gcao001 BETWEEN g_mmbc_d[l_ac2].mmbc001 AND g_mmbc_d[l_ac2].mmbc002
                     AND gcao002 = g_mmbb_d[l_ac].mmbb001
                     AND gcaoent = g_enterprise #160905-00007#6 add
               END IF               
               DISPLAY g_mmbc_d[l_ac2].mmbc003 to s_detail2[l_ac2].mmbc003
            END IF
            LET g_mmbc_d_o.* = g_mmbc_d[l_ac2].*    #160824-00007#122 by sakura add
            #END add-point
            

         #此段落由子樣板a01產生
         BEFORE FIELD mmbc002
            #add-point:BEFORE FIELD mmbc002

            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE mmbc002
            #add-point:ON CHANGE mmbc002

            #END add-point

         #----<<mmbc005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbc003
            #add-point:BEFORE FIELD mmbc003

            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD mmbc003
            
            #add-point:AFTER FIELD mmbc003
            
            #END add-point
            

         #此段落由子樣板a04產生
         ON CHANGE mmbc003
            #add-point:ON CHANGE mmbc003

            #END add-point
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_mmbc_d[l_ac2].* = g_mmbc_d_t.*
               CLOSE ammt404_bcl_2
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_mmbc_d[l_ac2].mmbcseq1
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_mmbc_d[l_ac2].* = g_mmbc_d_t.*
            ELSE
            
               #add-point:單身修改前

               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               UPDATE mmbc_t SET (mmbcdocno,mmbcsite,mmbcseq,mmbcseq1,mmbc001,mmbc002,mmbc003) = (g_mmba_m.mmbadocno,g_mmba_m.mmbasite,g_mmbc_d[l_ac2].mmbcseq,g_mmbc_d[l_ac2].mmbcseq1,g_mmbc_d[l_ac2].mmbc001,g_mmbc_d[l_ac2].mmbc002,g_mmbc_d[l_ac2].mmbc003)
                WHERE mmbcent = g_enterprise AND mmbcdocno = g_mmba_m.mmbadocno 
                  AND mmbcseq = g_mmbb_d[l_ac].mmbbseq
                  AND mmbcseq1 = g_mmbc_d_t.mmbcseq1 #項次   

                  
               #add-point:單身修改中

               #end add-point
               
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "mmbc_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
   
                  LET g_mmbc_d[l_ac2].* = g_mmbc_d_t.*
               ELSE
                          
                  #資料多語言用-增/改
                  
               END IF
               
               #add-point:單身修改後
            
               SELECT SUM(mmbc003) INTO l_mmbb006 FROM mmbc_t
                WHERE mmbcdocno=g_mmba_m.mmbadocno AND mmbcseq =  g_mmbb_d[l_ac].mmbbseq
                  AND mmbcent = g_enterprise 
               IF NOT cl_null( l_mmbb006) THEN
                  UPDATE mmbb_t SET mmbb006 = l_mmbb006
                   WHERE mmbbdocno=g_mmba_m.mmbadocno AND mmbbseq =  g_mmbb_d[l_ac].mmbbseq
                  AND mmbbent = g_enterprise
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "mmbc_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
                  ELSE

                  END IF                
               END IF
               #end add-point
 
            END IF
            
         AFTER ROW
            CLOSE ammt404_bcl_2
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            
              
         AFTER INPUT
            #add-point:input段after input 
            CALL s_transaction_end('Y','0')
            
            SELECT SUM(mmbc003) INTO l_mmbb006 FROM mmbc_t
             WHERE mmbcdocno=g_mmba_m.mmbadocno AND mmbcseq =  g_mmbb_d[l_ac].mmbbseq
               AND mmbcent = g_enterprise
            IF NOT cl_null( l_mmbb006) THEN
               CALL s_transaction_begin()
               UPDATE mmbb_t SET mmbb006 = l_mmbb006
                WHERE mmbbdocno=g_mmba_m.mmbadocno AND mmbbseq =  g_mmbb_d[l_ac].mmbbseq
                  AND mmbbent = g_enterprise
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "mmbc_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

                  CALL s_transaction_end('N','0')   
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF                
            END IF    
            CALL ammt404_b_fill()        #150525-00013#1           
            #end add-point   
              
      END INPUT
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)      
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD mmbasite
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD mmbbseq
 
               #add-point:input段modify_detail 

               #end add-point  
            END CASE
         END IF                
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD mmbadocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD mmbbseq
 
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
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
 
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
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
         
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="ammt404.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION ammt404_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
         
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
         
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL ammt404_b_fill() #單身填充
      CALL ammt404_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL ammt404_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
             CALL ammt404_b_fill_2()        
            #150907-00033#2 20150925 mark by beckxie---S
            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_mmba_m.mmbasite
            #CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            #LET g_mmba_m.mmbasite_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_mmba_m.mmbasite_desc
            #
            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_mmba_m.mmbaownid
            #CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            #LET g_mmba_m.mmbaownid_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_mmba_m.mmbaownid_desc
            #
            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_mmba_m.mmbaowndp
            #CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            #LET g_mmba_m.mmbaowndp_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_mmba_m.mmbaowndp_desc
            #
            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_mmba_m.mmbacrtid
            #CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            #LET g_mmba_m.mmbacrtid_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_mmba_m.mmbacrtid_desc
            #
            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_mmba_m.mmbacrtdp
            #CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            #LET g_mmba_m.mmbacrtdp_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_mmba_m.mmbacrtdp_desc
            #
            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_mmba_m.mmbamodid
            #CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            #LET g_mmba_m.mmbamodid_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_mmba_m.mmbamodid_desc
            #
            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_mmba_m.mmbacnfid
            #CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            #LET g_mmba_m.mmbacnfid_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_mmba_m.mmbacnfid_desc
            #
            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_mmba_m.mmbapstid
            #CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            #LET g_mmba_m.mmbapstid_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_mmba_m.mmbapstid_desc
            #150907-00033#2 20150925 mark by beckxie---E
   #end add-point
   
   #遮罩相關處理
   LET g_mmba_m_mask_o.* =  g_mmba_m.*
   CALL ammt404_mmba_t_mask()
   LET g_mmba_m_mask_n.* =  g_mmba_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_mmba_m.mmbasite,g_mmba_m.mmbasite_desc,g_mmba_m.mmbadocdt,g_mmba_m.mmbadocno,g_mmba_m.mmbaunit, 
       g_mmba_m.mmba000,g_mmba_m.mmbastus,g_mmba_m.mmbaownid,g_mmba_m.mmbaownid_desc,g_mmba_m.mmbaowndp, 
       g_mmba_m.mmbaowndp_desc,g_mmba_m.mmbacrtid,g_mmba_m.mmbacrtid_desc,g_mmba_m.mmbacrtdp,g_mmba_m.mmbacrtdp_desc, 
       g_mmba_m.mmbacrtdt,g_mmba_m.mmbamodid,g_mmba_m.mmbamodid_desc,g_mmba_m.mmbamoddt,g_mmba_m.mmbacnfid, 
       g_mmba_m.mmbacnfid_desc,g_mmba_m.mmbacnfdt,g_mmba_m.mmbapstid,g_mmba_m.mmbapstid_desc,g_mmba_m.mmbapstdt 
 
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_mmba_m.mmbastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_mmbb_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
            #150907-00033#2 20150925 mark by beckxie---S
            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_mmbb_d[l_ac].mmbbsite
            #CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            #LET g_mmbb_d[l_ac].mmbbsite_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_mmbb_d[l_ac].mmbbsite_desc
            #150907-00033#2 20150925 mark by beckxie---E

#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mmbb_d[l_ac].mmbb002
#            CALL ap_ref_array2(g_ref_fields,"SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaa001=? ","") RETURNING g_rtn_fields
#            LET g_mmbb_d[l_ac].mmbb002_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_mmbb_d[l_ac].mmbb002_desc

            #150907-00033#2 20150925 mark by beckxie---S
            #CALL s_desc_get_stock_desc(g_mmbb_d[l_ac].mmbbsite,g_mmbb_d[l_ac].mmbb002) RETURNING g_mmbb_d[l_ac].mmbb002_desc
            #DISPLAY BY NAME g_mmbb_d[l_ac].mmbb002_desc
            #
            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_mmbb_d[l_ac].mmbb003
            #CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            #LET g_mmbb_d[l_ac].mmbb003_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_mmbb_d[l_ac].mmbb003_desc
            #150907-00033#2 20150925 mark by beckxie---E
            
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mmbb_d[l_ac].mmbb004
#            CALL ap_ref_array2(g_ref_fields,"SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaa001=? ","") RETURNING g_rtn_fields
#            LET g_mmbb_d[l_ac].mmbb004_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_mmbb_d[l_ac].mmbb004_desc

            #150907-00033#2 20150925 mark by beckxie---S
            #CALL s_desc_get_stock_desc(g_mmbb_d[l_ac].mmbbsite,g_mmbb_d[l_ac].mmbb004) RETURNING g_mmbb_d[l_ac].mmbb004_desc
            #DISPLAY BY NAME g_mmbb_d[l_ac].mmbb004_desc
            #
            #CALL ammt404_display_mmbb001()
            #150907-00033#2 20150925 mark by beckxie---E
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
         
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL ammt404_detail_show()
 
   #add-point:show段之後 name="show.after"
            LET g_ac_t = l_ac
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="ammt404.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION ammt404_detail_show()
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
 
{<section id="ammt404.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION ammt404_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE mmba_t.mmbadocno 
   DEFINE l_oldno     LIKE mmba_t.mmbadocno 
 
   DEFINE l_master    RECORD LIKE mmba_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE mmbb_t.* #此變數樣板目前無使用
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
            DEFINE l_detail1    RECORD LIKE mmbc_t.*
            DEFINE l_insert     LIKE type_t.num5   #161024-00025#7  2016/10/25  by 08742 add
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
   
   LET g_master_insert = FALSE
   
   IF g_mmba_m.mmbadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_mmbadocno_t = g_mmba_m.mmbadocno
 
    
   LET g_mmba_m.mmbadocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_mmba_m.mmbaownid = g_user
      LET g_mmba_m.mmbaowndp = g_dept
      LET g_mmba_m.mmbacrtid = g_user
      LET g_mmba_m.mmbacrtdp = g_dept 
      LET g_mmba_m.mmbacrtdt = cl_get_current()
      LET g_mmba_m.mmbamodid = g_user
      LET g_mmba_m.mmbamoddt = cl_get_current()
      LET g_mmba_m.mmbastus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   #161024-00025#7  2016/10/24  by 08742 add
   LET g_ins_site_flag = FALSE   
      CALL s_aooi500_default(g_prog,'mmbasite',g_mmba_m.mmbasite)
         RETURNING l_insert,g_mmba_m.mmbasite
      IF NOT l_insert THEN
         RETURN
      END IF
   #161024-00025#7  2016/10/24  by 08742 add   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_mmba_m.mmbastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
   
   
   CALL ammt404_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_mmba_m.* TO NULL
      INITIALIZE g_mmbb_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL ammt404_show()
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
   CALL ammt404_set_act_visible()   
   CALL ammt404_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_mmbadocno_t = g_mmba_m.mmbadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " mmbaent = " ||g_enterprise|| " AND",
                      " mmbadocno = '", g_mmba_m.mmbadocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL ammt404_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
         
   #end add-point
   
   CALL ammt404_idx_chk()
   
   LET g_data_owner = g_mmba_m.mmbaownid      
   LET g_data_dept  = g_mmba_m.mmbaowndp
   
   #功能已完成,通報訊息中心
   CALL ammt404_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="ammt404.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION ammt404_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE mmbb_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
         
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE ammt404_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
         
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM mmbb_t
    WHERE mmbbent = g_enterprise AND mmbbdocno = g_mmbadocno_t
 
    INTO TEMP ammt404_detail
 
   #將key修正為調整後   
   UPDATE ammt404_detail 
      #更新key欄位
      SET mmbbdocno = g_mmba_m.mmbadocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO mmbb_t SELECT * FROM ammt404_detail
   
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
   DROP TABLE ammt404_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
         
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_mmbadocno_t = g_mmba_m.mmbadocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="ammt404.delete" >}
#+ 資料刪除
PRIVATE FUNCTION ammt404_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE  l_mmbb007       LIKE mmbb_t.mmbb007
   DEFINE  l_mmbb008       LIKE mmbb_t.mmbb008
   DEFINE  l_sql           STRING    
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_mmba_m.mmbadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN ammt404_cl USING g_enterprise,g_mmba_m.mmbadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN ammt404_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE ammt404_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE ammt404_master_referesh USING g_mmba_m.mmbadocno INTO g_mmba_m.mmbasite,g_mmba_m.mmbadocdt, 
       g_mmba_m.mmbadocno,g_mmba_m.mmbaunit,g_mmba_m.mmba000,g_mmba_m.mmbastus,g_mmba_m.mmbaownid,g_mmba_m.mmbaowndp, 
       g_mmba_m.mmbacrtid,g_mmba_m.mmbacrtdp,g_mmba_m.mmbacrtdt,g_mmba_m.mmbamodid,g_mmba_m.mmbamoddt, 
       g_mmba_m.mmbacnfid,g_mmba_m.mmbacnfdt,g_mmba_m.mmbapstid,g_mmba_m.mmbapstdt,g_mmba_m.mmbasite_desc, 
       g_mmba_m.mmbaownid_desc,g_mmba_m.mmbaowndp_desc,g_mmba_m.mmbacrtid_desc,g_mmba_m.mmbacrtdp_desc, 
       g_mmba_m.mmbamodid_desc,g_mmba_m.mmbacnfid_desc,g_mmba_m.mmbapstid_desc
   
   
   #檢查是否允許此動作
   IF NOT ammt404_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_mmba_m_mask_o.* =  g_mmba_m.*
   CALL ammt404_mmba_t_mask()
   LET g_mmba_m_mask_n.* =  g_mmba_m.*
   
   CALL ammt404_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
                  
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL ammt404_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_mmbadocno_t = g_mmba_m.mmbadocno
 
 
      DELETE FROM mmba_t
       WHERE mmbaent = g_enterprise AND mmbadocno = g_mmba_m.mmbadocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
                  
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_mmba_m.mmbadocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
                  
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      LET g_errno=null
      LET l_sql=" SELECT mmbb007,mmbb008 FROM mmbb_t WHERE mmbbdocno='",g_mmba_m.mmbadocno,"' AND mmbbent=",g_enterprise
      PREPARE l_sql_mmbb FROM l_sql
      DECLARE l_sql_mmbb_cs CURSOR FOR l_sql_mmbb
      FOREACH l_sql_mmbb_cs INTO l_mmbb007,l_mmbb008
         IF SQLCA.sqlcode THEN
            LET g_errno=SQLCA.sqlcode
            EXIT FOREACH
         END IF      
         UPDATE mmaz_t SET mmaz008=null,
                           mmaz009=null,
                           #mmaz007=null
                           mmaz007 =mmaz006    #150525-00002#1
          WHERE mmazdocno=l_mmbb007
            AND mmazseq = l_mmbb008
            AND mmazent = g_enterprise
         IF SQLCA.sqlcode THEN
            LET g_errno=SQLCA.sqlcode 
            EXIT FOREACH
         END IF  
      END FOREACH
      IF NOT cl_null(g_errno) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = g_errno
         LET g_errparam.extend = "mmbb_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF      
      #end add-point
      
      DELETE FROM mmbb_t
       WHERE mmbbent = g_enterprise AND mmbbdocno = g_mmba_m.mmbadocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
                  
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mmbb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
                        DELETE FROM mmbc_t
       WHERE mmbcent = g_enterprise AND mmbcdocno = g_mmba_m.mmbadocno
         AND mmbcsite = g_mmba_m.mmbasite
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "mmbb_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF 
      CALL g_mmbc_d.clear()      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_mmba_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE ammt404_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_mmbb_d.clear() 
 
     
      CALL ammt404_ui_browser_refresh()  
      #CALL ammt404_ui_headershow()  
      #CALL ammt404_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL ammt404_browser_fill("")
         CALL ammt404_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE ammt404_cl
 
   #功能已完成,通報訊息中心
   CALL ammt404_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="ammt404.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION ammt404_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
         
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_mmbb_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
         
   #end add-point
   
   #判斷是否填充
   IF ammt404_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT mmbbseq,mmbbsite,mmbb002,mmbb003,mmbb004,mmbb001,mmbb005,mmbb006, 
             mmbb007,mmbb008,mmbbunit,mmbb000 ,t1.ooefl003 ,t2.inayl003 ,t3.ooefl003 ,t4.inayl003 ,t5.mmanl003 FROM mmbb_t", 
                
                     " INNER JOIN mmba_t ON mmbaent = " ||g_enterprise|| " AND mmbadocno = mmbbdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=mmbbsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t2 ON t2.inaylent="||g_enterprise||" AND t2.inayl001=mmbb002 AND t2.inayl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=mmbb003 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t4 ON t4.inaylent="||g_enterprise||" AND t4.inayl001=mmbb004 AND t4.inayl002='"||g_dlang||"' ",
               " LEFT JOIN mmanl_t t5 ON t5.mmanlent="||g_enterprise||" AND t5.mmanl001=mmbb001 AND t5.mmanl002='"||g_dlang||"' ",
 
                     " WHERE mmbbent=? AND mmbbdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
                  
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY mmbb_t.mmbbseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
                  
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE ammt404_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR ammt404_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_mmba_m.mmbadocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_mmba_m.mmbadocno INTO g_mmbb_d[l_ac].mmbbseq,g_mmbb_d[l_ac].mmbbsite, 
          g_mmbb_d[l_ac].mmbb002,g_mmbb_d[l_ac].mmbb003,g_mmbb_d[l_ac].mmbb004,g_mmbb_d[l_ac].mmbb001, 
          g_mmbb_d[l_ac].mmbb005,g_mmbb_d[l_ac].mmbb006,g_mmbb_d[l_ac].mmbb007,g_mmbb_d[l_ac].mmbb008, 
          g_mmbb_d[l_ac].mmbbunit,g_mmbb_d[l_ac].mmbb000,g_mmbb_d[l_ac].mmbbsite_desc,g_mmbb_d[l_ac].mmbb002_desc, 
          g_mmbb_d[l_ac].mmbb003_desc,g_mmbb_d[l_ac].mmbb004_desc,g_mmbb_d[l_ac].mmbb001_desc   #(ver:78) 
 
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         CALL ammt404_display_mmbb001()
         #150907-00033#2 20151013 mark by beckxie---S
         #CALL ammt404_display_mmbb002()
         #CALL ammt404_display_mmbb004()
         #call ammt404_display_mmbb003()
         #call ammt404_display_mmbbsite()
         #150907-00033#2 20151013 mark by beckxie---E
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
   
   CALL g_mmbb_d.deleteElement(g_mmbb_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE ammt404_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_mmbb_d.getLength()
      LET g_mmbb_d_mask_o[l_ac].* =  g_mmbb_d[l_ac].*
      CALL ammt404_mmbb_t_mask()
      LET g_mmbb_d_mask_n[l_ac].* =  g_mmbb_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="ammt404.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION ammt404_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete"
                  
      #end add-point    
      DELETE FROM mmbb_t
       WHERE mmbbent = g_enterprise AND
         mmbbdocno = ps_keys_bak[1] AND mmbbseq = ps_keys_bak[2]
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
         CALL g_mmbb_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
         
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="ammt404.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION ammt404_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert"
                  
      #end add-point 
      INSERT INTO mmbb_t
                  (mmbbent,
                   mmbbdocno,
                   mmbbseq
                   ,mmbbsite,mmbb002,mmbb003,mmbb004,mmbb001,mmbb005,mmbb006,mmbb007,mmbb008,mmbbunit,mmbb000) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_mmbb_d[g_detail_idx].mmbbsite,g_mmbb_d[g_detail_idx].mmbb002,g_mmbb_d[g_detail_idx].mmbb003, 
                       g_mmbb_d[g_detail_idx].mmbb004,g_mmbb_d[g_detail_idx].mmbb001,g_mmbb_d[g_detail_idx].mmbb005, 
                       g_mmbb_d[g_detail_idx].mmbb006,g_mmbb_d[g_detail_idx].mmbb007,g_mmbb_d[g_detail_idx].mmbb008, 
                       g_mmbb_d[g_detail_idx].mmbbunit,g_mmbb_d[g_detail_idx].mmbb000)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
                  
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mmbb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_mmbb_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
                  
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
         
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="ammt404.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION ammt404_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "mmbb_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
                  
      #end add-point 
      
      #將遮罩欄位還原
      CALL ammt404_mmbb_t_mask_restore('restore_mask_o')
               
      UPDATE mmbb_t 
         SET (mmbbdocno,
              mmbbseq
              ,mmbbsite,mmbb002,mmbb003,mmbb004,mmbb001,mmbb005,mmbb006,mmbb007,mmbb008,mmbbunit,mmbb000) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_mmbb_d[g_detail_idx].mmbbsite,g_mmbb_d[g_detail_idx].mmbb002,g_mmbb_d[g_detail_idx].mmbb003, 
                  g_mmbb_d[g_detail_idx].mmbb004,g_mmbb_d[g_detail_idx].mmbb001,g_mmbb_d[g_detail_idx].mmbb005, 
                  g_mmbb_d[g_detail_idx].mmbb006,g_mmbb_d[g_detail_idx].mmbb007,g_mmbb_d[g_detail_idx].mmbb008, 
                  g_mmbb_d[g_detail_idx].mmbbunit,g_mmbb_d[g_detail_idx].mmbb000) 
         WHERE mmbbent = g_enterprise AND mmbbdocno = ps_keys_bak[1] AND mmbbseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
                  
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mmbb_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mmbb_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL ammt404_mmbb_t_mask_restore('restore_mask_n')
               
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
 
{<section id="ammt404.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION ammt404_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="ammt404.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION ammt404_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="ammt404.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION ammt404_lock_b(ps_table,ps_page)
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
   #CALL ammt404_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "mmbb_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN ammt404_bcl USING g_enterprise,
                                       g_mmba_m.mmbadocno,g_mmbb_d[g_detail_idx].mmbbseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ammt404_bcl:",SQLERRMESSAGE 
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
 
{<section id="ammt404.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION ammt404_unlock_b(ps_table,ps_page)
   #add-point:unlock_b段define(客製用) name="unlock_b.define_customerization"
   
   #end add-point  
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
         
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
    
   LET ls_group = "'1',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE ammt404_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
         
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="ammt404.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION ammt404_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
         
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("mmbadocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("mmbadocno",TRUE)
      CALL cl_set_comp_entry("mmbadocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
                  
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
            CALL cl_set_comp_entry("mmbasite",TRUE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="ammt404.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION ammt404_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
            DEFINE l_count  like type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("mmbadocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
                  
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("mmbadocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("mmbadocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
            SELECT count(*) INTO l_count FROM mmbb_t WHERE mmbbent = g_enterprise
      AND mmbbdocno = g_mmba_m.mmbadocno
   IF l_count > 0 THEN
      CALL cl_set_comp_entry("mmbasite",FALSE)     
   END IF
   #161024-00025#7  2016/10/25  by 08742 add
#   IF NOT s_aooi500_comp_entry(g_prog,'mmbasite') THEN
#      CALL cl_set_comp_entry("mmbasite",FALSE)
#   END IF
   IF NOT s_aooi500_comp_entry(g_prog,'mmbasite') OR g_ins_site_flag THEN
      CALL cl_set_comp_entry("mmbasite",FALSE)
   END IF
   #161024-00025#7  2016/10/25  by 08742 add
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="ammt404.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION ammt404_set_entry_b(p_cmd)
   #add-point:set_entry_b段define(客製用) name="set_entry_b.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
            CALL cl_set_comp_entry("mmbb003,mmbb001,mmbb005",TRUE)

   #end add-point     
   
   #add-point:Function前置處理  name="set_entry_b.pre_function"
   
   #end add-point
    
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("",TRUE)
      #add-point:set_entry段欄位控制 name="set_entry_b.field_control"
      
      #end add-point  
   END IF
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
         
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="ammt404.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION ammt404_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point    
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
            IF NOT cl_null(g_mmbb_d[l_ac].mmbb007) THEN
      CALL cl_set_comp_entry("mmbb003,mmbb001,mmbb005",FALSE)
   END IF
   if g_mmbb_d[l_ac].mmbb006>0 then
      CALL cl_set_comp_entry("mmbb001",FALSE)
   end if
   #end add-point    
   
   #add-point:Function前置處理  name="set_no_entry_b.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #add-point:set_no_entry_b段欄位控制 name="set_no_entry_b.field_control"
      
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b"
         
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="ammt404.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION ammt404_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="ammt404.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION ammt404_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_mmba_m.mmbastus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF


   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="ammt404.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION ammt404_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="ammt404.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION ammt404_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="ammt404.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION ammt404_default_search()
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
      LET ls_wc = ls_wc, " mmbadocno = '", g_argv[01], "' AND "
   END IF
   
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   LET ls_wc = ''
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = " mmbadocno = '", g_argv[02], "' AND "
   END IF
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
               WHEN la_wc[li_idx].tableid = "mmba_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "mmbb_t" 
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
#            let ls_wc = null
#   IF NOT cl_null(g_argv[1]) THEN
#      LET ls_wc = ls_wc, " mmba000 = '", g_argv[1], "' AND "
#   END IF
#   
#   IF NOT cl_null(ls_wc) THEN
#      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
#   ELSE
#      IF cl_null(g_wc) THEN
#         LET g_wc = " 1=1"
#      END IF
#   END IF
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " AND mmba000 = '", g_argv[01], "' "
   END IF
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="ammt404.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION ammt404_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
            DEFINE l_success      LIKE type_t.num5
   DEFINE   l_mmbapstdt           DATETIME YEAR TO SECOND   
   DEFINE   l_ooac002      LIKE ooac_t.ooac002
   DEFINE   l_ooac004      LIKE ooac_t.ooac004
   DEFINE   l_flag1        LIKE type_t.num5   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"

   IF g_mmba_m.mmbastus = 'X' THEN
      RETURN
   END IF
   IF g_mmba_m.mmbastus = 'C' THEN  #結案狀態
      RETURN
   END IF
   LET l_mmbapstdt=cl_get_current()
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_mmba_m.mmbadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN ammt404_cl USING g_enterprise,g_mmba_m.mmbadocno
   IF STATUS THEN
      CLOSE ammt404_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN ammt404_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE ammt404_master_referesh USING g_mmba_m.mmbadocno INTO g_mmba_m.mmbasite,g_mmba_m.mmbadocdt, 
       g_mmba_m.mmbadocno,g_mmba_m.mmbaunit,g_mmba_m.mmba000,g_mmba_m.mmbastus,g_mmba_m.mmbaownid,g_mmba_m.mmbaowndp, 
       g_mmba_m.mmbacrtid,g_mmba_m.mmbacrtdp,g_mmba_m.mmbacrtdt,g_mmba_m.mmbamodid,g_mmba_m.mmbamoddt, 
       g_mmba_m.mmbacnfid,g_mmba_m.mmbacnfdt,g_mmba_m.mmbapstid,g_mmba_m.mmbapstdt,g_mmba_m.mmbasite_desc, 
       g_mmba_m.mmbaownid_desc,g_mmba_m.mmbaowndp_desc,g_mmba_m.mmbacrtid_desc,g_mmba_m.mmbacrtdp_desc, 
       g_mmba_m.mmbamodid_desc,g_mmba_m.mmbacnfid_desc,g_mmba_m.mmbapstid_desc
   
 
   #檢查是否允許此動作
   IF NOT ammt404_action_chk() THEN
      CLOSE ammt404_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_mmba_m.mmbasite,g_mmba_m.mmbasite_desc,g_mmba_m.mmbadocdt,g_mmba_m.mmbadocno,g_mmba_m.mmbaunit, 
       g_mmba_m.mmba000,g_mmba_m.mmbastus,g_mmba_m.mmbaownid,g_mmba_m.mmbaownid_desc,g_mmba_m.mmbaowndp, 
       g_mmba_m.mmbaowndp_desc,g_mmba_m.mmbacrtid,g_mmba_m.mmbacrtid_desc,g_mmba_m.mmbacrtdp,g_mmba_m.mmbacrtdp_desc, 
       g_mmba_m.mmbacrtdt,g_mmba_m.mmbamodid,g_mmba_m.mmbamodid_desc,g_mmba_m.mmbamoddt,g_mmba_m.mmbacnfid, 
       g_mmba_m.mmbacnfid_desc,g_mmba_m.mmbacnfdt,g_mmba_m.mmbapstid,g_mmba_m.mmbapstid_desc,g_mmba_m.mmbapstdt 
 
 
   CASE g_mmba_m.mmbastus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "S"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
      WHEN "A"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
      WHEN "D"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
      WHEN "R"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
      WHEN "W"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_mmba_m.mmbastus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "S"
               HIDE OPTION "posted"
            WHEN "A"
               HIDE OPTION "approved"
            WHEN "D"
               HIDE OPTION "withdraw"
            WHEN "R"
               HIDE OPTION "rejection"
            WHEN "W"
               HIDE OPTION "signing"
            WHEN "X"
               HIDE OPTION "invalid"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
                        CALL cl_set_act_visible("invalid,open,confirmed,posted", true)
   IF g_mmba_m.mmbastus <> 'N' THEN
      CALL cl_set_act_visible("invalid", FALSE)
   ELSE
      CALL cl_set_act_visible("invalid", TRUE)
      CALL cl_set_act_visible("posted,unconfirmed", FALSE)      
   END IF
   IF g_mmba_m.mmbastus = 'Y' THEN
      CALL cl_set_act_visible("posted,unconfirmed", TRUE)
      CALL cl_set_act_visible("confirmed", FALSE)      
   END IF
   IF g_mmba_m.mmbastus = 'S' THEN
      CALL cl_set_act_visible("confirmed", TRUE)
      CALL cl_set_act_visible("unconfirmed,posted", FALSE)      
   END IF
   IF g_mmba_m.mmbastus = 'X' THEN
      CALL cl_set_act_visible("invalid,unconfirmed,confirmed,posted", false)      
   END IF
   CALL cl_set_act_visible("signing,withdraw",FALSE)
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
      CALL cl_set_act_visible("closed",FALSE)

      CASE g_mmba_m.mmbastus
         WHEN "N"  
            CALL cl_set_act_visible("unconfirmed,hold,posted",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
                CALL cl_set_act_visible("signing",TRUE)
                CALL cl_set_act_visible("confirmed",FALSE)
            END IF
 
         WHEN "R"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed,hold,posted",FALSE)

         WHEN "D"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed,hold,posted",FALSE) 
          
         WHEN "X"
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold,posted",FALSE)

         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed,hold",FALSE)
         
         WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
             CALL cl_set_act_visible("withdraw",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold,posted",FALSE)
         
         WHEN "A"     #只能顯示確認; 其餘應用功能皆隱藏
             CALL cl_set_act_visible("confirmed ",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid,hold,posted",FALSE)
         when "S"
             CALL cl_set_act_visible("confirmed ",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid,hold,posted",FALSE)         
      END CASE
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT ammt404_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE ammt404_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT ammt404_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE ammt404_cl
            RETURN
         END IF
 
 
 
	  
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"
                           
            #end add-point
         END IF
         EXIT MENU
      ON ACTION posted
         IF cl_auth_chk_act("posted") THEN
            LET lc_state = "S"
            #add-point:action控制 name="statechange.posted"
                           
            #end add-point
         END IF
         EXIT MENU
      ON ACTION approved
         IF cl_auth_chk_act("approved") THEN
            LET lc_state = "A"
            #add-point:action控制 name="statechange.approved"
            
            #end add-point
         END IF
         EXIT MENU
      #ON ACTION withdraw
      #   IF cl_auth_chk_act("withdraw") THEN
      #      LET lc_state = "D"
      #      #add-point:action控制 name="statechange.withdraw"
      #      
      #      #end add-point
      #   END IF
      #   EXIT MENU
      ON ACTION rejection
         IF cl_auth_chk_act("rejection") THEN
            LET lc_state = "R"
            #add-point:action控制 name="statechange.rejection"
            
            #end add-point
         END IF
         EXIT MENU
      #ON ACTION signing
      #   IF cl_auth_chk_act("signing") THEN
      #      LET lc_state = "W"
      #      #add-point:action控制 name="statechange.signing"
      #      
      #      #end add-point
      #   END IF
      #   EXIT MENU
      ON ACTION invalid
         IF cl_auth_chk_act("invalid") THEN
            LET lc_state = "X"
            #add-point:action控制 name="statechange.invalid"
                           
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
                  
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      AND lc_state <> "S"
      AND lc_state <> "A"
      AND lc_state <> "D"
      AND lc_state <> "R"
      AND lc_state <> "W"
      AND lc_state <> "X"
      ) OR 
      g_mmba_m.mmbastus = lc_state OR cl_null(lc_state) THEN
      CLOSE ammt404_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
            LET l_success = TRUE
   SELECT mmbastus INTO  g_mmba_m.mmbastus FROM mmba_t WHERE mmbadocno = g_mmba_m.mmbadocno
      AND mmbaent = g_enterprise AND mmbasite = g_site
   CASE 
      WHEN lc_state = 'Y' AND g_mmba_m.mmbastus = 'N'            
         CALL s_ammt404_conf_chk(g_mmba_m.mmbadocno,g_mmba_m.mmbastus) RETURNING l_success,g_errno
         IF l_success THEN
            IF cl_ask_confirm('lib-014') THEN
               CALL s_transaction_begin()
               CALL s_ammt404_conf_upd(g_mmba_m.mmbadocno) RETURNING l_success
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  #160604-00009#92 -s by 08172               
                  CALL s_aooi200_get_slip(g_mmba_m.mmbadocno) RETURNING l_flag1,l_ooac002
                  CALL cl_get_doc_para(g_enterprise,g_site,l_ooac002,'D-BAS-0083') RETURNING l_ooac004
                  IF l_ooac004='Y' THEN
                     CALL ammt404_post_new() RETURNING l_success
                     IF l_success THEN
                        LET lc_state = 'S'
                        LET g_mmba_m.mmbastus='Y'
                        CALL s_transaction_end('Y','1')
                     ELSE 
                        CALL s_transaction_end('N','0')
                        RETURN                     
                     END IF
                  ELSE
                     CALL s_transaction_end('Y','1') 
                  END IF
                  #160604-00009#92 -e by 08172
               END IF               
            ELSE
               CALL s_transaction_end('N','0')   #160816-00068#6 add
               RETURN
            END IF            
         ELSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = g_errno
            LET g_errparam.extend = g_mmba_m.mmbadocno
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N','0')   #160816-00068#6 add
            RETURN            
         END IF
                
      WHEN lc_state = 'X' AND g_mmba_m.mmbastus = 'N' 
         CALL s_ammt404_void_chk(g_mmba_m.mmbadocno,g_mmba_m.mmbastus) RETURNING l_success,g_errno
         IF l_success THEN
            IF cl_ask_confirm('lib-016') THEN
               CALL s_transaction_begin()
               CALL s_ammt404_void_upd(g_mmba_m.mmbadocno) RETURNING l_success
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160816-00068#6 add
               RETURN
            END IF
         ELSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = g_errno
            LET g_errparam.extend = g_mmba_m.mmbadocno
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N','0')   #160816-00068#6 add
            RETURN    
         END IF
      WHEN lc_state = 'N' AND g_mmba_m.mmbastus = 'Y' 
         SELECT mmbastus INTO  g_mmba_m.mmbastus FROM mmba_t WHERE mmbadocno = g_mmba_m.mmbadocno
            AND mmbaent = g_enterprise AND mmbasite = g_mmba_m.mmbasite
         CALL s_ammt404_unconf_chk(g_mmba_m.mmbadocno,g_mmba_m.mmbastus) RETURNING l_success,g_errno
         IF l_success THEN
            IF cl_ask_confirm('lib-015') THEN
               CALL s_transaction_begin()
               CALL s_ammt404_unconf_upd(g_mmba_m.mmbadocno) RETURNING l_success
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160816-00068#6 add
               RETURN
            END IF
         ELSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = g_errno
            LET g_errparam.extend = g_mmba_m.mmbadocno
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N','0')   #160816-00068#6 add
            RETURN    
         END IF
      WHEN lc_state = 'S' AND g_mmba_m.mmbastus = 'Y' 
         SELECT mmbastus INTO  g_mmba_m.mmbastus FROM mmba_t WHERE mmbadocno = g_mmba_m.mmbadocno
            AND mmbaent = g_enterprise AND mmbasite = g_mmba_m.mmbasite     
         CALL s_ammt404_post_chk(g_mmba_m.mmbadocno,g_mmba_m.mmbastus) RETURNING l_success,g_errno
         IF l_success THEN
            IF cl_ask_confirm('lib-00018') THEN
               CALL s_transaction_begin()
#               CALL s_ammt404_post_upd(g_mmba_m.mmbadocno) RETURNING l_success
               CALL s_amm_inventory_post_upd(g_type,'mmbc001','mmbc002','mmbb001',g_prog,g_mmba_m.mmbadocno,g_mmba_m.mmbadocdt,g_mmba_m.mmbasite,'-1','mmbb002','mmbbdocno','mmbbent','mmbb_t','')
               RETURNING l_success
               IF l_success THEN
                  CALL s_amm_inventory_post_upd(g_type,'mmbc001','mmbc002','mmbb001',g_prog,g_mmba_m.mmbadocno,g_mmba_m.mmbadocdt,g_mmba_m.mmbasite,'1','mmbb004','mmbbdocno','mmbbent','mmbb_t','')
                  RETURNING l_success
               END IF   
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  UPDATE mmba_t SET mmbastus = 'S',
                                    mmbapstid = g_user,
                                    mmbapstdt = l_mmbapstdt
                   WHERE mmbadocno = g_mmba_m.mmbadocno
                     AND mmbaent = g_enterprise 
                  IF SQLCA.sqlcode THEN
                     LET l_success = FALSE       
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                     RETURN
                  END IF
                  CALL s_transaction_end('Y','1')   
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160816-00068#6 add
               RETURN
            END IF            
         ELSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = g_errno
            LET g_errparam.extend = g_mmba_m.mmbadocno
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N','0')   #160816-00068#6 add
            RETURN            
         END IF 
            
      WHEN lc_state = 'Y' AND g_mmba_m.mmbastus = 'S' 
         CALL s_ammt404_unpost_chk(g_mmba_m.mmbadocno,g_mmba_m.mmbastus) RETURNING l_success,g_errno
         IF l_success THEN
            IF cl_ask_confirm('lib-00019') THEN
               CALL s_transaction_begin()
#               CALL s_ammt404_unpost_upd(g_mmba_m.mmbadocno) RETURNING l_success
               CALL s_amm_inventory_unpost_upd(g_type,'mmbc001','mmbc002','mmbb001',g_prog,g_mmba_m.mmbadocno,g_mmba_m.mmbadocdt,g_mmba_m.mmbasite,'-1','mmbb002','mmbbdocno','mmbbent','mmbb_t','')
               RETURNING l_success
               IF l_success THEN
                  CALL s_amm_inventory_unpost_upd(g_type,'mmbc001','mmbc002','mmbb001',g_prog,g_mmba_m.mmbadocno,g_mmba_m.mmbadocdt,g_mmba_m.mmbasite,'1','mmbb004','mmbbdocno','mmbbent','mmbb_t','')
                  RETURNING l_success
               END IF   
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  UPDATE mmba_t SET mmbastus = 'Y',
                                    mmbapstid = NULL,
                                    mmbapstdt = NULL
                   WHERE mmbadocno = g_mmba_m.mmbadocno
                     AND mmbaent = g_enterprise 
                  IF SQLCA.sqlcode THEN
                     LET l_success = FALSE       
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                     RETURN
                  END IF
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160816-00068#6 add
               RETURN
            END IF            
         ELSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = g_errno
            LET g_errparam.extend = g_mmba_m.mmbadocno
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N','0')   #160816-00068#6 add
            RETURN            
         END IF
      OTHERWISE 
         CALL s_transaction_end('N','0')   #160816-00068#6 add
         RETURN     
   END CASE      
         
   
   #end add-point
   
   LET g_mmba_m.mmbamodid = g_user
   LET g_mmba_m.mmbamoddt = cl_get_current()
   LET g_mmba_m.mmbastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE mmba_t 
      SET (mmbastus,mmbamodid,mmbamoddt) 
        = (g_mmba_m.mmbastus,g_mmba_m.mmbamodid,g_mmba_m.mmbamoddt)     
    WHERE mmbaent = g_enterprise AND mmbadocno = g_mmba_m.mmbadocno
 
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE ammt404_master_referesh USING g_mmba_m.mmbadocno INTO g_mmba_m.mmbasite,g_mmba_m.mmbadocdt, 
          g_mmba_m.mmbadocno,g_mmba_m.mmbaunit,g_mmba_m.mmba000,g_mmba_m.mmbastus,g_mmba_m.mmbaownid, 
          g_mmba_m.mmbaowndp,g_mmba_m.mmbacrtid,g_mmba_m.mmbacrtdp,g_mmba_m.mmbacrtdt,g_mmba_m.mmbamodid, 
          g_mmba_m.mmbamoddt,g_mmba_m.mmbacnfid,g_mmba_m.mmbacnfdt,g_mmba_m.mmbapstid,g_mmba_m.mmbapstdt, 
          g_mmba_m.mmbasite_desc,g_mmba_m.mmbaownid_desc,g_mmba_m.mmbaowndp_desc,g_mmba_m.mmbacrtid_desc, 
          g_mmba_m.mmbacrtdp_desc,g_mmba_m.mmbamodid_desc,g_mmba_m.mmbacnfid_desc,g_mmba_m.mmbapstid_desc 
 
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_mmba_m.mmbasite,g_mmba_m.mmbasite_desc,g_mmba_m.mmbadocdt,g_mmba_m.mmbadocno, 
          g_mmba_m.mmbaunit,g_mmba_m.mmba000,g_mmba_m.mmbastus,g_mmba_m.mmbaownid,g_mmba_m.mmbaownid_desc, 
          g_mmba_m.mmbaowndp,g_mmba_m.mmbaowndp_desc,g_mmba_m.mmbacrtid,g_mmba_m.mmbacrtid_desc,g_mmba_m.mmbacrtdp, 
          g_mmba_m.mmbacrtdp_desc,g_mmba_m.mmbacrtdt,g_mmba_m.mmbamodid,g_mmba_m.mmbamodid_desc,g_mmba_m.mmbamoddt, 
          g_mmba_m.mmbacnfid,g_mmba_m.mmbacnfid_desc,g_mmba_m.mmbacnfdt,g_mmba_m.mmbapstid,g_mmba_m.mmbapstid_desc, 
          g_mmba_m.mmbapstdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
      SELECT mmbastus,mmbacnfid,mmbacnfdt,mmbapstid,mmbapstdt
     INTO g_mmba_m.mmbastus,g_mmba_m.mmbacnfid,g_mmba_m.mmbacnfdt,g_mmba_m.mmbapstid,g_mmba_m.mmbapstdt
     FROM mmba_t
    WHERE mmbaent = g_enterprise AND mmbadocno = g_mmba_m.mmbadocno
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mmba_m.mmbacnfid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_mmba_m.mmbacnfid_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_mmba_m.mmbacnfid_desc
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mmba_m.mmbapstid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_mmba_m.mmbapstid_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_mmba_m.mmbapstid_desc   
   IF g_mmba_m.mmbastus NOT MATCHES "[NDR]" THEN
      CALL cl_set_act_visible("modify,delete", FALSE)
   ELSE
      CALL cl_set_act_visible("modify,delete", TRUE)   
   END IF
   
   DISPLAY BY NAME g_mmba_m.mmbastus,g_mmba_m.mmbacnfid,g_mmba_m.mmbacnfdt,g_mmba_m.mmbapstid,g_mmba_m.mmbapstdt
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
         
   #end add-point  
 
   CLOSE ammt404_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL ammt404_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="ammt404.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION ammt404_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
      IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_mmbc_d.getLength() THEN
         LET g_detail_idx = g_mmbc_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_mmbc_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_mmbc_d.getLength() TO FORMONLY.cnt
   END IF
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_mmbb_d.getLength() THEN
         LET g_detail_idx = g_mmbb_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_mmbb_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_mmbb_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
         
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="ammt404.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION ammt404_b_fill2(pi_idx)
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
   
   CALL ammt404_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="ammt404.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION ammt404_fill_chk(ps_idx)
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
 
{<section id="ammt404.status_show" >}
PRIVATE FUNCTION ammt404_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="ammt404.mask_functions" >}
&include "erp/amm/ammt404_mask.4gl"
 
{</section>}
 
{<section id="ammt404.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION ammt404_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   DEFINE  l_success  LIKE type_t.num5
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL ammt404_show()
   CALL ammt404_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   CALL s_ammt404_conf_chk(g_mmba_m.mmbadocno,g_mmba_m.mmbastus) RETURNING l_success,g_errno
   IF l_success THEN
            
   ELSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = g_errno
      LET g_errparam.extend = g_mmba_m.mmbadocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CLOSE ammt404_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE           
   END IF
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_mmba_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_mmbb_d))
 
 
   # cl_bpm_cli() 裡有包含以前的aws_condition()=>送簽資料檢核和更新單據狀況碼為'W'
   # cl_bpm_cli() 傳入參數:無  ;  回傳值: 0 開單失敗; 1 開單成功
 
   #add-point: 提交前的ADP name="send.before_cli"
   
   #end add-point
 
   #開單失敗
   IF NOT cl_bpm_cli() THEN 
      RETURN FALSE
   END IF
 
   #add-point: 提交後的ADP name="send.after_send"
   
   #end add-point
 
   #此段落不需要刪除資料,但是否需要refresh圖片樣式???
   #CALL ammt404_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL ammt404_ui_headershow()
   CALL ammt404_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION ammt404_draw_out()
   #add-point:draw段define name="draw.define_customerization"
   
   #end add-point
   #add-point:draw段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="draw.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="draw.pre_function"
   
   #end add-point
   
   #抽單失敗
   IF NOT cl_bpm_draw_out() THEN 
      RETURN FALSE
   END IF    
          
   #重新指定此筆單據資料狀態圖片=>抽單
   LET g_browser[g_current_idx].b_statepic = "stus/16/draw_out.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL ammt404_ui_headershow()  
   CALL ammt404_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="ammt404.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION ammt404_set_pk_array()
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
   LET g_pk_array[1].values = g_mmba_m.mmbadocno
   LET g_pk_array[1].column = 'mmbadocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="ammt404.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="ammt404.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION ammt404_msgcentre_notify(lc_state)
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
   CALL ammt404_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_mmba_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="ammt404.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION ammt404_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#22 add-S
   SELECT mmbastus  INTO g_mmba_m.mmbastus
     FROM mmba_t
    WHERE mmbaent = g_enterprise
      AND mmbadocno = g_mmba_m.mmbadocno

  IF(g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_mmba_m.mmbastus
        WHEN 'W'
           LET g_errno = 'sub-00180'
        WHEN 'X'
           LET g_errno = 'sub-00229'
        WHEN 'Y'
           LET g_errno = 'sub-00178'
        WHEN 'S'
           LET g_errno = 'sub-00230'
     END CASE

     IF NOT cl_null(g_errno) THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = g_errno
        LET g_errparam.extend = g_mmba_m.mmbadocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL ammt404_set_act_visible()
        CALL ammt404_set_act_no_visible()
        CALL ammt404_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#22 add-E
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="ammt404.other_function" readonly="Y" >}
#+display mmbb001
PRIVATE FUNCTION ammt404_display_mmbb001()
   INITIALIZE g_ref_fields TO NULL  
   IF g_type='1' THEN
      LET g_ref_fields[1] = g_mmbb_d[l_ac].mmbb001
      CALL ap_ref_array2(g_ref_fields,"SELECT mmanl003 FROM mmanl_t WHERE mmanlent='"||g_enterprise||"' AND mmanl001=? AND mmanl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   END IF
   IF g_type='2' THEN
      LET g_ref_fields[1] = g_mmbb_d[l_ac].mmbb001
      CALL ap_ref_array2(g_ref_fields,"SELECT gcafl003 FROM gcafl_t WHERE gcaflent='"||g_enterprise||"' AND gcafl001=? AND gcafl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   END IF   
   LET g_mmbb_d[l_ac].mmbb001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mmbb_d[l_ac].mmbb001_desc
END FUNCTION
#+chk post
PRIVATE FUNCTION ammt404_post()
   DEFINE l_success   LIKE type_t.num5
   CALL s_ammt404_post_chk(g_mmba_m.mmbadocno,g_mmba_m.mmbastus) RETURNING l_success,g_errno
   IF l_success THEN
      IF cl_ask_confirm('lib-00018') THEN
         CALL s_transaction_begin()
         CALL s_ammt404_post_upd(g_mmba_m.mmbadocno) RETURNING l_success
         IF NOT l_success THEN
            CALL s_transaction_end('N','0')
            RETURN
         END IF
      ELSE
         RETURN
      END IF            
   ELSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = g_errno
      LET g_errparam.extend = g_mmba_m.mmbadocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN            
   END IF
END FUNCTION
#+ chk mmbadocno
PRIVATE FUNCTION ammt404_mmbadocno(p_mmbadocno)
   DEFINE   l_cnt   LIKE type_t.num5
   DEFINE   l_cnt1  LIKE type_t.num5
   define   p_mmbadocno  like mmba_t.mmbadocno
   SELECT ooef004 INTO g_ooef004 FROM ooef_t WHERE ooef001 = g_site AND ooefent = g_enterprise   
   LET g_errno = null
   LET l_cnt = 0
   LET l_cnt1 = 0
   SELECT COUNT(*) INTO l_cnt  FROM oobl_t WHERE oobl001 = g_ooef004 AND oobl002=p_mmbadocno
      AND oobl003 = g_prog
      AND ooblent = g_enterprise #160905-00007#6 add
   IF l_cnt <= 0 THEN
      LET g_errno = "aim-00056"
   ELSE
      SELECT COUNT(*) INTO l_cnt1  FROM ooba_t,oobl_t
       WHERE oobl001 = g_ooef004 AND oobl002=p_mmbadocno AND oobl001=ooba001 AND oobl002=ooba002 AND ooblent=oobaent
         AND oobl003 = g_prog AND oobastus='Y'
         AND ooblent = g_enterprise #160905-00007#6 add
      IF l_cnt1 <= 0 THEN
         LET g_errno = "aoo-00102"
      END IF         
   END IF
END FUNCTION
#+chk 卡種編號
PRIVATE FUNCTION ammt404_mmbb001()
   DEFINE  l_cnt    LIKE type_t.num5
   DEFINE  l_cnt1   LIKE type_t.num5
   LET  g_errno = null
   LET l_cnt = 0
   LET l_cnt1 = 0
   IF g_type='1' THEN
      SELECT COUNT(*) INTO l_cnt FROM mman_t WHERE mman001=g_mmbb_d[l_ac].mmbb001 AND mmanent = g_enterprise
      IF l_cnt<=0 THEN
         LET g_errno = "amm-00003"
      ELSE
         SELECT COUNT(*) INTO l_cnt1 FROM mman_t 
          WHERE mman001=g_mmbb_d[l_ac].mmbb001 
            AND mmanent = g_enterprise
            AND mmanstus = 'Y'
         IF l_cnt1<=0 THEN   
            LET g_errno = "amm-00004"
         END IF         
      END IF
      IF cl_null(g_errno) THEN
         SELECT COUNT(*) INTO l_cnt FROM mmap_t WHERE mmap002=g_mmbb_d[l_ac].mmbb001 AND mmapent = g_enterprise
            AND mmapstus = 'Y'
         IF l_cnt<=0 THEN
            LET g_errno = "amm-00023"
         END IF
      END IF
   END IF   
   IF g_type='2' THEN
      SELECT COUNT(*) INTO l_cnt FROM gcaf_t WHERE gcaf001=g_mmbb_d[l_ac].mmbb001 AND gcafent = g_enterprise
      IF l_cnt<=0 THEN
         LET g_errno = "amm-00124"
      ELSE
         SELECT COUNT(*) INTO l_cnt1 FROM gcaf_t WHERE gcaf001=g_mmbb_d[l_ac].mmbb001 AND gcafent = g_enterprise AND gcafstus="Y"
         IF l_cnt1<=0 THEN   
            LET g_errno = "amm-00125"
         END IF         
      END IF
      
   END IF
END FUNCTION
#+ display mmbbsite
PRIVATE FUNCTION ammt404_display_mmbbsite()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mmbb_d[l_ac].mmbbsite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mmbb_d[l_ac].mmbbsite_desc = '', g_rtn_fields[1] , ''
   DISPLAY  g_mmbb_d[l_ac].mmbbsite_desc TO s_detail1[l_ac].mmbbsite_desc

END FUNCTION
#+顯示
PRIVATE FUNCTION ammt404_display_mmbb003()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mmbb_d[l_ac].mmbb003
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mmbb_d[l_ac].mmbb003_desc = '', g_rtn_fields[1] , ''
   DISPLAY  g_mmbb_d[l_ac].mmbb003_desc TO s_detail1[l_ac].mmbb003_desc
END FUNCTION
#+ chk領用欄位
PRIVATE FUNCTION ammt404_mmbb002(p_mmbb002,p_site)
   DEFINE  l_cnt       LIKE type_t.num5
   DEFINE  l_cnt1      LIKE type_t.num5 
   DEFINE  p_mmbb002   LIKE mmbb_t.mmbb002
   DEFINE  p_site      LIKE mmba_t.mmbasite
   LET  g_errno = NULL
   LET l_cnt = 0
   LET l_cnt1 = 0
   SELECT COUNT(*) INTO l_cnt FROM inaa_t 
    WHERE inaa001 = p_mmbb002 AND inaasite = p_site
      AND inaaent = g_enterprise
   IF l_cnt <=0 THEN
      LET g_errno = "aim-00064"
   ELSE
      SELECT COUNT(*) INTO l_cnt1 FROM inaa_t 
       WHERE inaa001 = p_mmbb002 AND inaasite = p_site
         AND inaaent = g_enterprise AND inaastus = 'Y'
      IF l_cnt1 <=0 THEN
         LET g_errno = 'sub-01302'  #160318-00005#24 mod  "amm-00018"
      END IF 
   END IF   
END FUNCTION
#+create mmbbseq
PRIVATE FUNCTION ammt404_mmbbseq()
   IF (cl_null(g_mmbb_d[l_ac].mmbbseq) OR g_mmbb_d[l_ac].mmbbseq=0) THEN
      SELECT MAX(mmbbseq)+1 INTO g_mmbb_d[l_ac].mmbbseq FROM mmbb_t
       WHERE mmbbdocno = g_mmba_m.mmbadocno AND mmbbent = g_enterprise
   END IF
   IF (cl_null(g_mmbb_d[l_ac].mmbbseq) OR g_mmbb_d[l_ac].mmbbseq=0) THEN
      LET g_mmbb_d[l_ac].mmbbseq = 1
   END IF
END FUNCTION
#+ chk mmbbsite
PRIVATE FUNCTION ammt404_mmbbsite(p_mmbbsite)
   DEFINE   l_cnt       LIKE type_t.num5
   DEFINE   l_cnt1      LIKE type_t.num5 
   DEFINE   p_mmbbsite   LIKE mmbb_t.mmbbsite
   LET g_errno = NULL
   LET l_cnt = 0
   LET l_cnt1 = 0
   SELECT COUNT(*) INTO l_cnt  FROM ooef_t WHERE ooef001 = p_mmbbsite AND ooefent = g_enterprise
   IF l_cnt <= 0 THEN
      LET g_errno = "aoo-00090"
   ELSE
      SELECT COUNT(*) INTO l_cnt1  FROM ooef_t WHERE ooef001 = p_mmbbsite AND ooefent = g_enterprise
         AND ooefstus='Y'
      IF l_cnt1 <= 0 THEN
         LET g_errno =  'sub-01302'  #160318-00005#24 mod"amm-00007"
      END IF         
   END IF
END FUNCTION
#+b_fill
PRIVATE FUNCTION ammt404_b_fill_2()
   {<Local define>}
   DEFINE p_wc2      STRING
   DEFINE l_cnt      like type_t.num5
   {</Local define>}    
 
   CALL g_mmbc_d.clear()    #g_mmbc_d 單頭及單身 
   IF cl_null(l_ac) OR l_ac=0 THEN
      LET l_ac=1
   END IF
   LET l_cnt = 0
   SELECT count(*) INTO l_cnt FROM mmbb_t
    WHERE mmbbdocno = g_mmba_m.mmbadocno AND mmbbent = g_enterprise
      AND mmbbsite = g_mmba_m.mmbasite AND mmbbseq = g_mmbb_d[l_ac].mmbbseq
   IF l_cnt = 0 THEN
      RETURN
   END IF   
   
   LET g_sql = "SELECT  UNIQUE mmbcseq,mmbcseq1,mmbc001,mmbc002,mmbc003,mmbcsite,mmbcunit,mmbc000 FROM mmbc_t",    
               " WHERE mmbcent=? AND mmbcdocno=?  AND mmbcseq=?"
 
   IF NOT cl_null(g_wc_table2) THEN
      LET g_sql = g_sql CLIPPED, " AND ", g_wc_table2 CLIPPED
   END IF
 
   LET g_sql = g_sql, " ORDER BY mmbc_t.mmbcseq1"
   
   PREPARE ammt404_pb2 FROM g_sql
   DECLARE b_fill_cs2 CURSOR FOR ammt404_pb2
 
   LET g_cnt = l_ac2
   LET l_ac2 = 1
   
 
   OPEN b_fill_cs2 USING g_enterprise,g_mmba_m.mmbadocno
                                            ,g_mmbb_d[l_ac].mmbbseq


                                            
   FOREACH b_fill_cs2 INTO g_mmbc_d[l_ac2].mmbcseq,g_mmbc_d[l_ac2].mmbcseq1,g_mmbc_d[l_ac2].mmbc001,g_mmbc_d[l_ac2].mmbc002,g_mmbc_d[l_ac2].mmbc003,
                           g_mmbc_d[l_ac2].mmbcsite,g_mmbc_d[l_ac2].mmbcunit,g_mmbc_d[l_ac2].mmbc000
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
 
      LET l_ac2 = l_ac2 + 1
      IF l_ac2 > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = FALSE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
   END FOREACH
   

   
   CALL g_mmbc_d.deleteElement(g_mmbc_d.getLength())

   

   LET l_ac2 = g_cnt
   LET g_cnt = 0  
   
   FREE ammt404_pb2
END FUNCTION

#+ chk mmbcseq1
PRIVATE FUNCTION ammt404_mmbcseq1()
   IF (cl_null(g_mmbc_d[l_ac2].mmbcseq1) OR g_mmbc_d[l_ac2].mmbcseq1=0) THEN
      SELECT MAX(mmbcseq1)+1 INTO g_mmbc_d[l_ac2].mmbcseq1 FROM mmbc_t
       WHERE mmbcdocno = g_mmba_m.mmbadocno AND mmbcent = g_enterprise
         AND mmbcseq = g_mmbb_d[l_ac].mmbbseq 
   END IF
    IF (cl_null(g_mmbc_d[l_ac2].mmbcseq1) OR g_mmbc_d[l_ac2].mmbcseq1=0) THEN
      LET g_mmbc_d[l_ac2].mmbcseq1=1
   END IF
END FUNCTION
#+chk mmbc001
PRIVATE FUNCTION ammt404_mmbc001(p_mmbc001)
   DEFINE   l_cnt       LIKE type_t.num5
   DEFINE   l_cnt1      LIKE type_t.num5 
   define   p_mmbc001   like mmbc_t.mmbc001
   LET g_errno = NULL
   LET l_cnt = 0
   LET l_cnt1 = 0
   IF g_type='1' THEN
      SELECT COUNT(*) INTO l_cnt  FROM mmaq_t WHERE mmaq001 = p_mmbc001 AND mmaq002 = g_mmbb_d[l_ac].mmbb001
      AND mmaqent = g_enterprise #160905-00007#6 add
      IF l_cnt <= 0 THEN
         LET g_errno = "amm-00032"
      ELSE
         SELECT COUNT(*) INTO l_cnt1  FROM mmaq_t WHERE mmaq001 = p_mmbc001 AND mmaq006='1' AND mmaq002 = g_mmbb_d[l_ac].mmbb001
         AND mmaqent = g_enterprise #160905-00007#6 add
         IF l_cnt1 <= 0 THEN
            LET g_errno = "amm-00044"
         END IF         
      END IF
#      IF cl_null(g_errno) THEN
#         LET l_cnt1 = 0
#         SELECT count(*) INTO l_cnt1 FROM mmaq_t WHERE  mmaq001=p_mmbc001
#            AND mmaq039 = g_mmbb_d[l_ac].mmbb002
#         IF l_cnt1 <= 0 THEN
#            LET g_errno = "amm-00045"
#         END IF         
#      END IF
      
   END IF
   IF g_type='2' THEN
      SELECT COUNT(*) INTO l_cnt  FROM gcao_t WHERE gcao001 = p_mmbc001 AND gcao002 = g_mmbb_d[l_ac].mmbb001
      AND gcaoent = g_enterprise #160905-00007#6 add
      IF l_cnt <= 0 THEN
         LET g_errno = "amm-00126"
      ELSE
         SELECT COUNT(*) INTO l_cnt1  FROM gcao_t WHERE gcao001 = p_mmbc001 AND gcao005='1' AND gcao002 = g_mmbb_d[l_ac].mmbb001
         AND gcaoent = g_enterprise #160905-00007#6 add
         IF l_cnt1 <= 0 THEN
            LET g_errno = "amm-00127"
         END IF         
      END IF
#      IF cl_null(g_errno) THEN
#         LET l_cnt1 = 0
#         SELECT count(*) INTO l_cnt1 FROM gcao_t WHERE  gcao001=p_mmbc001
#            AND gcao032 = g_mmbb_d[l_ac].mmbb002
#         IF l_cnt1 <= 0 THEN
#            LET g_errno = "amm-00128"
#         END IF         
#      END IF
   END IF 
   IF cl_null(g_errno) THEN
      IF NOT cl_null( g_mmbc_d[l_ac2].mmbc001) AND NOT cl_null(g_mmbc_d[l_ac2].mmbc002) THEN 
         IF g_mmbc_d[l_ac2].mmbc001>g_mmbc_d[l_ac2].mmbc002 THEN
            LET g_errno = "amm-00062"
         END IF
      END IF
   END IF   
END FUNCTION
#+chk mmbc002
PRIVATE FUNCTION ammt404_mmbc002()
DEFINE    l_start_no        LIKE type_t.num20
DEFINE    l_end_no          LIKE type_t.num20
DEFINE    l_length          LIKE type_t.num5
DEFINE    l_nums            LIKE type_t.num20
DEFINE    l_mman006         LIKE mman_t.mman006
define    l_cnt             like type_t.num20
define    l_cnt1            like type_t.num20

   LET l_cnt = 0
   LET l_cnt1 = 0
   LET g_errno = NULL  
   IF NOT cl_null( g_mmbc_d[l_ac2].mmbc001) AND NOT cl_null(g_mmbc_d[l_ac2].mmbc002) THEN  
      IF g_type='1' THEN
         SELECT mman006 INTO l_mman006 FROM mman_t WHERE mman001=g_mmbb_d[l_ac].mmbb001
         AND mmanent = g_enterprise #160905-00007#6 add
         LET l_length  = LENGTH(g_mmbc_d[l_ac2].mmbc002)
         LET l_start_no = g_mmbc_d[l_ac2].mmbc001[l_mman006+1,l_length]
         LET l_end_no =   g_mmbc_d[l_ac2].mmbc002[l_mman006+1,l_length]
         LET l_nums = l_end_no - l_start_no + 1
         IF cl_null(l_nums) THEN LET l_nums = 0 END IF
         SELECT count(*) INTO l_cnt FROM mmaq_t WHERE mmaq001 BETWEEN g_mmbc_d[l_ac2].mmbc001 AND g_mmbc_d[l_ac2].mmbc002
            AND mmaq002 = g_mmbb_d[l_ac].mmbb001  #161115-00015#2 by 08172
            AND mmaqent = g_enterprise #160905-00007#6 add
         SELECT COUNT(*) INTO l_cnt1 FROM mmaq_t WHERE mmaq001 BETWEEN g_mmbc_d[l_ac2].mmbc001 AND g_mmbc_d[l_ac2].mmbc002
            AND mmaq002 = g_mmbb_d[l_ac].mmbb001  #161115-00015#2 by 08172
            AND mmaq006='1'
            AND mmaqent = g_enterprise #160905-00007#6 add
      END IF
      IF g_type='2' THEN
         SELECT gcaf007 INTO l_mman006 FROM gcaf_t WHERE gcaf001=g_mmbb_d[l_ac].mmbb001
         AND gcafent = g_enterprise #160905-00007#6 add
         LET l_length  = LENGTH(g_mmbc_d[l_ac2].mmbc002)
         LET l_start_no = g_mmbc_d[l_ac2].mmbc001[l_mman006+1,l_length]
         LET l_end_no =   g_mmbc_d[l_ac2].mmbc002[l_mman006+1,l_length]
         LET l_nums = l_end_no - l_start_no + 1
         IF cl_null(l_nums) THEN LET l_nums = 0 END IF
         SELECT count(*) INTO l_cnt FROM gcao_t WHERE gcao001 BETWEEN g_mmbc_d[l_ac2].mmbc001 AND g_mmbc_d[l_ac2].mmbc002
            AND gcao002 = g_mmbb_d[l_ac].mmbb001  #161115-00015#2 by 08172
            AND gcaoent = g_enterprise #160905-00007#6 add
         SELECT COUNT(*) INTO l_cnt1 FROM gcao_t WHERE gcao001 BETWEEN g_mmbc_d[l_ac2].mmbc001 AND g_mmbc_d[l_ac2].mmbc002
            AND gcao002 = g_mmbb_d[l_ac].mmbb001  #161115-00015#2 by 08172
            AND gcao005='1'
            AND gcaoent = g_enterprise #160905-00007#6 add
      END IF      
      IF l_cnt < l_nums THEN
         LET g_errno= "amm-00046"
      END IF
      IF cl_null(g_errno) THEN
         IF l_cnt1<l_cnt THEN
            LET g_errno= "amm-00047"
         END IF
      END IF
      IF cl_null(g_errno) THEN
         LET g_mmbc_d[l_ac2].mmbc003=l_cnt
         DISPLAY  g_mmbc_d[l_ac2].mmbc003 TO s_detail2[l_ac2].mmbc003
      END IF
   END IF   
END FUNCTION
#+chk unpost
PRIVATE FUNCTION ammt404_unpost()
   DEFINE l_success   LIKE type_t.num5
   CALL s_ammt404_unpost_chk(g_mmba_m.mmbadocno,g_mmba_m.mmbastus) RETURNING l_success,g_errno
   IF l_success THEN
      IF cl_ask_confirm('lib-00019') THEN
         CALL s_transaction_begin()
         CALL s_ammt404_unpost_upd(g_mmba_m.mmbadocno) RETURNING l_success
         IF NOT l_success THEN
            CALL s_transaction_end('N','0')
            RETURN
         ELSE
            CALL s_transaction_end('Y','1')
         END IF
      ELSE
         RETURN
      END IF            
   ELSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = g_errno
      LET g_errparam.extend = g_mmba_m.mmbadocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN            
   END IF
END FUNCTION
#+display mmbb004
PRIVATE FUNCTION ammt404_display_mmbb004()
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = g_mmbb_d[l_ac].mmbb004
#   CALL ap_ref_array2(g_ref_fields,"SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaa001=? ","") RETURNING g_rtn_fields
#   LET g_mmbb_d[l_ac].mmbb004_desc = '', g_rtn_fields[1] , ''
#   DISPLAY  g_mmbb_d[l_ac].mmbb004_desc to s_detail1[l_ac].mmbb004_desc
   CALL s_desc_get_stock_desc(g_mmbb_d[l_ac].mmbbsite,g_mmbb_d[l_ac].mmbb004) RETURNING g_mmbb_d[l_ac].mmbb004_desc
   DISPLAY BY NAME g_mmbb_d[l_ac].mmbb004_desc
END FUNCTION
#+ display mmbb002
PRIVATE FUNCTION ammt404_display_mmbb002()
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = g_mmbb_d[l_ac].mmbb002
#   CALL ap_ref_array2(g_ref_fields,"SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaa001=? ","") RETURNING g_rtn_fields
#   LET g_mmbb_d[l_ac].mmbb002_desc = '', g_rtn_fields[1] , ''
#   DISPLAY  g_mmbb_d[l_ac].mmbb002_desc to s_detail1[l_ac].mmbb002_desc
   CALL s_desc_get_stock_desc(g_mmbb_d[l_ac].mmbbsite,g_mmbb_d[l_ac].mmbb002) RETURNING g_mmbb_d[l_ac].mmbb002_desc
   DISPLAY BY NAME g_mmbb_d[l_ac].mmbb002_desc
END FUNCTION
#+
PRIVATE FUNCTION ammt404_mmbc001_after(p_cmd)
   DEFINE l_count  LIKE type_t.num5
   DEFINE p_cmd    LIKE type_t.chr1
   LET l_count = 0
   LET g_errno = NULL
   IF NOT cl_null( g_mmbc_d[l_ac2].mmbc001)  AND NOT cl_null( g_mmbc_d[l_ac2].mmbc002) THEN 
      IF p_cmd = 'u' THEN   
         SELECT count(*) INTO l_count FROM mmbc_t WHERE mmbcent = g_enterprise AND mmbcdocno = g_mmba_m.mmbadocno
            AND mmbcseq = g_mmbb_d[l_ac].mmbbseq AND ((mmbc001 BETWEEN g_mmbc_d[l_ac2].mmbc001 AND g_mmbc_d[l_ac2].mmbc002)
             OR (mmbc002 BETWEEN g_mmbc_d[l_ac2].mmbc001 AND g_mmbc_d[l_ac2].mmbc002)) AND ((mmbc001 != g_mmbc_d_t.mmbc001)
             OR mmbc002 != g_mmbc_d_t.mmbc002)
      ELSE
         SELECT count(*) INTO l_count FROM mmbc_t WHERE mmbcent = g_enterprise AND mmbcdocno = g_mmba_m.mmbadocno
         AND mmbcseq = g_mmbb_d[l_ac].mmbbseq AND ((mmbc001 BETWEEN g_mmbc_d[l_ac2].mmbc001 AND g_mmbc_d[l_ac2].mmbc002)
          OR (mmbc002 BETWEEN g_mmbc_d[l_ac2].mmbc001 AND g_mmbc_d[l_ac2].mmbc002)) 
      END IF      
   END IF
   IF l_count >0 THEN
      LET g_errno = "amm-00072"
   END IF
   
END FUNCTION
#+sum mmbb006
PRIVATE FUNCTION ammt404_sum_mmbb006()
   DEFINE l_sql   STRING
   DEFINE l_mmbbseq LIKE mmbb_t.mmbbseq
   DEFINE l_mmbb006 LIKE mmbb_t.mmbb006
   define l_cnt     like type_t.num5
   LET l_sql=" SELECT DISTINCT mmbbseq FROM mmbb_t WHERE mmbbdocno='",g_mmba_m.mmbadocno,"' ",
             "    AND mmbbent=",g_enterprise
   PREPARE l_sql_mmbbseq FROM l_sql
   DECLARE l_sql_mmbbseq_cs CURSOR WITH HOLD FOR l_sql_mmbbseq
   LET l_mmbbseq = NULL
   LET l_cnt = 1
   OPEN l_sql_mmbbseq_cs
   FOREACH l_sql_mmbbseq_cs INTO l_mmbbseq   
      LET l_mmbb006 = 0
      SELECT SUM(nvl(mmbc003,0)) INTO l_mmbb006 FROM mmbc_t
       WHERE mmbcdocno=g_mmba_m.mmbadocno AND mmbcseq =  l_mmbbseq
         AND mmbcent = g_enterprise
      IF cl_null(l_mmbb006) THEN
         LET l_mmbb006 = 0
      END IF      
      IF NOT cl_null( l_mmbb006) THEN
         CALL s_transaction_begin()
         UPDATE mmbb_t SET mmbb006 = l_mmbb006
          WHERE mmbbdocno=g_mmba_m.mmbadocno AND mmbbseq =  l_mmbbseq
            AND mmbbent = g_enterprise
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "mmbc_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            CALL s_transaction_end('N','0') 
            RETURN            
         ELSE
            CALL s_transaction_end('Y','0')
         END IF                
      END IF
      LET l_mmbbseq = NULL
      let l_cnt = l_cnt+1
   END FOREACH 
   FREE l_sql_mmbbseq_cs   
END FUNCTION
#
PRIVATE FUNCTION ammt404_chk_mmbc001()
   DEFINE l_count   LIKE type_t.num5
   DEFINE l_sql     STRING
   DEFINE l_mmaq001 LIKE mmaq_t.mmaq001
   LET l_count = 0
   LET g_errno = NULL
   IF NOT cl_null(g_mmbc_d[l_ac2].mmbc002) AND NOT cl_null(g_mmbc_d[l_ac2].mmbc001) THEN
#      if g_type = '1' then
#         LET l_sql = "SELECT DISTINCT mmaq001 FROM mmaq_t WHERE mmaqent='",g_enterprise,"'",
#                     "   AND mmaq001<='",g_mmbc_d[l_ac2].mmbc002,"' AND mmaq001>='",g_mmbc_d[l_ac2].mmbc001,"' "
#         PREPARE l_sql_mmaq_pre2 FROM l_sql
#         DECLARE l_sql_mmaq_cs2 CURSOR FOR l_sql_mmaq_pre2
#         FOREACH l_sql_mmaq_cs2 INTO l_mmaq001 
#            LET l_count = 0
#            SELECT count(*) INTO l_count FROM mmaq_t WHERE  mmaq001=l_mmaq001
#               AND mmaq039 = g_mmbb_d[l_ac].mmbb002
#            IF l_count <= 0 THEN
#               LET g_errno = "amm-00045"
#               RETURN
#            END IF 
#         END FOREACH  
#      end if
#      if g_type='2' then
#         LET l_sql = "SELECT DISTINCT gcao001 FROM gcao_t WHERE gcaoent='",g_enterprise,"'",
#                     "   AND gcao001<='",g_mmbc_d[l_ac2].mmbc002,"' AND gcao001>='",g_mmbc_d[l_ac2].mmbc001,"' "
#         PREPARE l_sql_gcao_pre2 FROM l_sql
#         DECLARE l_sql_gcao_cs2 CURSOR FOR l_sql_gcao_pre2
#         FOREACH l_sql_gcao_cs2 INTO l_mmaq001 
#            LET l_count = 0
#            SELECT count(*) INTO l_count FROM gcao_t WHERE  gcao001=l_mmaq001
#               AND gcao032 = g_mmbb_d[l_ac].mmbb002
#            IF l_count <= 0 THEN
#               LET g_errno = "amm-00128"
#               RETURN
#            END IF 
#         END FOREACH
#      end if      
   END IF   
END FUNCTION
#display mmbasite
PRIVATE FUNCTION ammt404_mmbasite_reference()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mmba_m.mmbasite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mmba_m.mmbasite_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mmba_m.mmbasite_desc
END FUNCTION
#chk mmbasite
PRIVATE FUNCTION ammt404_chk_mmbasite(p_mmbasite)
   DEFINE   l_cnt       LIKE type_t.num5
   DEFINE   l_cnt1      LIKE type_t.num5 
   DEFINE   p_mmbasite   LIKE mmba_t.mmbasite
   define   l_sql       string
   LET g_errno = NULL
   LET l_cnt = 0
   LET l_cnt1 = 0
   LET l_sql=" SELECT count(*) ",
             " FROM ooed_t ",
             " WHERE  ooedent=",g_enterprise," AND ooed001='8'  AND ooed004 = '",p_mmbasite,"' " ,
             "   AND TO_CHAR(ooed006,'YYYY/MM/DD')<='",g_today,"' AND (TO_CHAR(ooed007,'YYYY/MM/DD')>='",g_today,"' or ooed007 is null) ",
             "   AND ooed004 IN (select DISTINCT ooed004 FROM ooed_t",
             "                                  START WITH ooed005='",g_site,"' CONNECT BY NOCYCLE PRIOR ooed004=ooed005 AND ooed001='8' ",
             "   AND TO_CHAR(ooed006,'YYYY/MM/DD')<='",g_today,"' AND (TO_CHAR(ooed007,'YYYY/MM/DD')>='",g_today,"' or ooed007 is null)",
             "                                     UNION ",
#             "                                   SELECT ooed004 FROM ooed_t WHERE ooed004='",g_site,"' ) " #160905-00007#6 mark
             "                                   SELECT ooed004 FROM ooed_t WHERE ooedent=",g_enterprise," AND ooed004='",g_site,"' ) " #160905-00007#6 add
   PREPARE l_sql_ooed004_pre FROM l_sql
   EXECUTE l_sql_ooed004_pre INTO l_cnt   
   IF l_cnt<=0 THEN
      LET g_errno = "agc-00035"
   END IF 
   IF cl_null(g_errno) THEN
      LET l_cnt1 = 0   
      
      SELECT COUNT(*) INTO l_cnt1  FROM ooef_t WHERE ooef001 = p_mmbasite AND ooefent = g_enterprise
         AND ooefstus='Y'
      IF l_cnt1 <= 0 THEN
         LET g_errno =  'sub-01302'  #160318-00005#24 mod"amm-00007"
      END IF         
   END IF   
END FUNCTION
#chk mmbb001
PRIVATE FUNCTION ammt404_chk_mmbb001(p_mmbbsite,p_mmbb003)
   DEFINE p_mmbbsite LIKE mmbb_t.mmbbsite
   define p_mmbb003  like mmbb_t.mmbb003
   DEFINE l_mmap003  LIKE mmap_t.mmap003
   DEFINE l_mmap005  LIKE mmap_t.mmap005
   DEFINE l_ooed004  LIKE ooed_t.ooed004
   DEFINE l_count    LIKE type_t.num5
   DEFINE l_sql      STRING

   CREATE TEMP TABLE ammt402_tmp
   (
      mmap003 varchar(30)
   );
   DELETE from ammt402_tmp
   IF SQLCA.sqlcode THEN
      LET g_errno = SQLCA.sqlcode
      RETURN
   END IF
   LET l_count = 0
   LET g_errno = NULL
   SELECT count(*) INTO l_count
     FROM mmap_t WHERE mmap002=g_mmbb_d[l_ac].mmbb001 AND mmapent=g_enterprise
   IF l_count <= 0 THEN
      LET g_errno = "amm-00023"
      RETURN
   END IF
   LET l_count = 0
#   LET l_sql=" INSERT INTO ammt402_tmp  select ooed004 from (SELECT ooed004 FROM (SELECT ooed004 FROM ooed_t ",
#                   "   WHERE ooed001='8' AND  TO_CHAR(ooed006,'YYYY/MM/DD')<='",g_today,"' AND (TO_CHAR(ooed007,'YYYY/MM/DD')>='",g_today,"' or ooed007 is null)",
#                   "  START WITH ooed005 = ?  CONNECT BY  NOCYCLE PRIOR ooed004 = ooed005 AND ooed001='8' ",
#                   "   AND TO_CHAR(ooed006,'YYYY/MM/DD')<='",g_today,"' AND (TO_CHAR(ooed007,'YYYY/MM/DD')>='",g_today,"' or ooed007 is null)) ",
#                   "   UNION ",
#                   "  SELECT ooef001 from ooef_t where ooef001 = ? AND ooefent=",g_enterprise," )"     
   LET l_sql=" select ooed004 from (SELECT ooed004 FROM (SELECT ooed004 FROM ooed_t ",
                   "   WHERE ooed001='8' AND  TO_CHAR(ooed006,'YYYY/MM/DD')<='",g_today,"' AND (TO_CHAR(ooed007,'YYYY/MM/DD')>='",g_today,"' or ooed007 is null)",
                   "  START WITH ooed005 = ?  CONNECT BY  NOCYCLE PRIOR ooed004 = ooed005 AND ooed001='8' ",
                   "   AND TO_CHAR(ooed006,'YYYY/MM/DD')<='",g_today,"' AND (TO_CHAR(ooed007,'YYYY/MM/DD')>='",g_today,"' or ooed007 is null)) ",
                   "   UNION ",
                   "  SELECT ooef001 from ooef_t where ooef001 = ? AND ooefent=",g_enterprise," )"                                
   PREPARE l_sql_imaa_pre1 FROM l_sql
   declare  l_sql_imaa_cs1 cursor for l_sql_imaa_pre1     
   LET l_sql = "SELECT DISTINCT mmap003,mmap005 FROM mmap_t WHERE mmap002='",g_mmbb_d[l_ac].mmbb001,"' ",
               "  AND mmapstus='Y' AND mmapent=",g_enterprise
   PREPARE l_sql_mmap003 FROM l_sql
   DECLARE l_sql_mmap003_cs CURSOR FOR l_sql_mmap003
   FOREACH l_sql_mmap003_cs INTO l_mmap003,l_mmap005
      INSERT INTO ammt402_tmp VALUES (l_mmap003)
      IF SQLCA.sqlcode THEN
         LET g_errno = SQLCA.sqlcode
         RETURN
      END IF
      IF l_mmap005='Y' THEN
         
#         EXECUTE l_sql_imaa_pre1 USING l_mmap003,l_mmap003
         FOREACH l_sql_imaa_cs1 USING l_mmap003,l_mmap003 INTO l_ooed004
            INSERT INTO ammt402_tmp VALUES (l_ooed004)
            IF SQLCA.sqlcode THEN
               LET g_errno = SQLCA.sqlcode
               RETURN
            END IF
         END FOREACH   
      END IF

   END FOREACH
   let l_count = 0
   IF NOT cl_null(p_mmbbsite) THEN
      SELECT count(*) INTO l_count FROM ammt402_tmp
      WHERE mmap003 = p_mmbbsite
      IF l_count <= 0 THEN
         LET g_errno = "amm-00112"
      END IF
   END IF
   IF NOT cl_null(p_mmbb003) AND cl_null(g_errno) THEN   
      LET l_count=0
      SELECT count(*) INTO l_count FROM ammt402_tmp
       WHERE mmap003 = p_mmbb003
      IF l_count <= 0 THEN
         LET g_errno = "amm-00111"
      END IF
   END IF
END FUNCTION
#檢查卡種對應的數量是否夠用
PRIVATE FUNCTION ammt404_chk_count()
DEFINE l_count  LIKE mmbb_t.mmbb006
DEFINE l_sum    LIKE mmbb_t.mmbb006
DEFINE l_mman053   LIKE mman_t.mman053
DEFINE l_mman059   LIKE mman_t.mman059

   LET g_errno=null   
   IF NOT cl_null(g_mmbb_d_t.mmbbseq) THEN
      SELECT sum(mmbb005) INTO l_sum FROM mmbb_t
       WHERE mmbbdocno = g_mmba_m.mmbadocno AND mmbbent = g_enterprise
         AND mmbbseq<>g_mmbb_d_t.mmbbseq AND mmbb001=g_mmbb_d[l_ac].mmbb001
   ELSE
      SELECT sum(mmbb005) INTO l_sum FROM mmbb_t
       WHERE mmbbdocno = g_mmba_m.mmbadocno AND mmbbent = g_enterprise
         AND mmbb001=g_mmbb_d[l_ac].mmbb001
   END IF   
   IF cl_null(l_sum) THEN
      LET l_sum=0
   END IF
   LET l_sum=l_sum+g_mmbb_d[l_ac].mmbb005
   
   SELECT mmbk003 INTO l_count FROM mmbk_t WHERE mmbkent=g_enterprise AND mmbk000=g_mmba_m.mmba000
      AND mmbk001=g_mmbb_d[l_ac].mmbb001 AND  mmbk002=g_mmbb_d[l_ac].mmbb002 
   IF cl_null(l_count) THEN
      LET l_count=0
   END IF
   SELECT mman059 INTO l_mman059 FROM mman_t WHERE mmanent = g_enterprise AND mman001 = g_mmbb_d[l_ac].mmbb001  #160728-00006#37 BY 08172
   IF l_mman059 <> '0' THEN        #160728-00006#37 BY 08172
      IF l_sum>l_count THEN
         LET g_errno="amm-00250"
      END IF
   END IF       #160728-00006#37 BY 08172
END FUNCTION

################################################################################
# Descriptions...: 调用过账
# Date & Author..: 160604-00009#92 2016/06/23 By 08172
# Modify.........:
################################################################################
PRIVATE FUNCTION ammt404_post_new()
   DEFINE l_success      LIKE type_t.num5
   DEFINE r_success      LIKE type_t.num5
   DEFINE   l_mmbapstdt           DATETIME YEAR TO SECOND
   
   LET r_success=TRUE
   LET l_mmbapstdt=cl_get_current()
   SELECT mmbastus INTO  g_mmba_m.mmbastus FROM mmba_t WHERE mmbadocno = g_mmba_m.mmbadocno
            AND mmbaent = g_enterprise AND mmbasite = g_mmba_m.mmbasite     
   CALL s_ammt404_post_chk(g_mmba_m.mmbadocno,g_mmba_m.mmbastus) RETURNING l_success,g_errno
   IF l_success THEN
#      IF cl_ask_confirm('lib-00018') THEN
#         CALL s_transaction_begin()
         CALL s_amm_inventory_post_upd(g_type,'mmbc001','mmbc002','mmbb001',g_prog,g_mmba_m.mmbadocno,g_mmba_m.mmbadocdt,g_mmba_m.mmbasite,'-1','mmbb002','mmbbdocno','mmbbent','mmbb_t','')
         RETURNING l_success
         IF l_success THEN
            CALL s_amm_inventory_post_upd(g_type,'mmbc001','mmbc002','mmbb001',g_prog,g_mmba_m.mmbadocno,g_mmba_m.mmbadocdt,g_mmba_m.mmbasite,'1','mmbb004','mmbbdocno','mmbbent','mmbb_t','')
            RETURNING l_success
         END IF   
         IF NOT l_success THEN
            LET r_success=FALSE
            RETURN r_success
         ELSE
            UPDATE mmba_t SET mmbastus = 'S',
                              mmbapstid = g_user,
                              mmbapstdt = l_mmbapstdt
             WHERE mmbadocno = g_mmba_m.mmbadocno
               AND mmbaent = g_enterprise 
            IF SQLCA.sqlcode THEN
               LET l_success = FALSE       
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET r_success=FALSE
               RETURN r_success
            END IF
            LET r_success=TRUE
            RETURN r_success   
         END IF
#      ELSE
#         CALL s_transaction_end('N','0')
#         RETURN
#      END IF            
   ELSE
      LET r_success=FALSE
      RETURN r_success
   END IF 
   RETURN r_success
END FUNCTION

 
{</section>}
 
