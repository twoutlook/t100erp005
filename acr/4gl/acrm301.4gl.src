#該程式已解開Section, 不再透過樣板產出!
{<section id="acrm301.description" >}
#+ Version..: T100-ERP-1.00.00(版次:1) Build-000048
#+ 
#+ Filename...: acrm301
#+ Description: 競爭廠商資料維護作業
#+ Creator....: 02748(2014/04/18)
#+ Modifier...: 02748(2014/04/18)
#+ Buildtype..: 應用 i01 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="acrm301.global" >}
#應用 t01 樣板自動產生(Version:56)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#36   2016/04/18   BY pengxin     將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160818-00017#5    2016/08/22   by 08172       修改删除时重新检查状态
#161108-00016#1    2016/11/09   by 08742       修改 g_browser_cnt 定义大小
#161214-00032#1    2016/12/15   by 07900       石狮通达权限设置.freestyle或者是改过section者,需检核规格【资料表关联设定】主表要跟现在程序主表一致;主sql部分要补上cl_sql_add_filter
#end add-point
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目
IMPORT FGL aoo_aooi350_01
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔

#end add-point
 
#單頭 type 宣告
PRIVATE TYPE type_g_crab_m RECORD
       crabunit LIKE crab_t.crabunit, 
   crabunit_desc LIKE type_t.chr80, 
   crab001 LIKE crab_t.crab001, 
   crabl004 LIKE crabl_t.crabl004, 
   crabl003 LIKE crabl_t.crabl003, 
   crab002 LIKE crab_t.crab002, 
   crabl005 LIKE crabl_t.crabl005, 
   crabstus LIKE crab_t.crabstus, 
   crab003 LIKE crab_t.crab003, 
   crab004 LIKE crab_t.crab004, 
   crab005 LIKE crab_t.crab005, 
   crab006 LIKE crab_t.crab006, 
   crab007 LIKE crab_t.crab007, 
   crab007_desc LIKE type_t.chr80,
   crab008 LIKE crab_t.crab008, 
   crab009 LIKE crab_t.crab009, 
   crab009_desc LIKE type_t.chr80,
   crab010 LIKE crab_t.crab010, 
   crab011 LIKE crab_t.crab011, 
   crab012 LIKE crab_t.crab012, 
   crabacti LIKE crab_t.crabacti, 
   crabownid LIKE crab_t.crabownid, 
   crabownid_desc LIKE type_t.chr80, 
   crabowndp LIKE crab_t.crabowndp, 
   crabowndp_desc LIKE type_t.chr80, 
   crabcrtid LIKE crab_t.crabcrtid, 
   crabcrtid_desc LIKE type_t.chr80, 
   crabcrtdp LIKE crab_t.crabcrtdp, 
   crabcrtdp_desc LIKE type_t.chr80, 
   crabcrtdt DATETIME YEAR TO SECOND, 
   crabmodid LIKE crab_t.crabmodid, 
   crabmodid_desc LIKE type_t.chr80, 
   crabmoddt DATETIME YEAR TO SECOND, 
   crabcnfid LIKE crab_t.crabcnfid, 
   crabcnfid_desc LIKE type_t.chr80, 
   crabcnfdt DATETIME YEAR TO SECOND
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_crab_m        type_g_crab_m
DEFINE g_crab_m_t      type_g_crab_m                #備份舊值
   DEFINE g_crab001_t LIKE crab_t.crab001
 
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD                   #資料瀏覽之欄位  
         b_statepic     LIKE type_t.chr50,
            b_crab001 LIKE crab_t.crab001
         #,rank           LIKE type_t.num10
      END RECORD 
          
DEFINE g_master_multi_table_t    RECORD
      crabl001 LIKE crabl_t.crabl001,
      crabl004 LIKE crabl_t.crabl004,
      crabl003 LIKE crabl_t.crabl003,
      crabl005 LIKE crabl_t.crabl005
      END RECORD
 
DEFINE g_wc                  STRING                        #儲存 user 的查詢條件
DEFINE g_wc_t                STRING                        #儲存 user 的查詢條件
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
  
DEFINE g_sql                 STRING                        #組 sql 用 
DEFINE g_forupd_sql          STRING                        #SELECT ... FOR UPDATE  SQL    
DEFINE g_cnt                 LIKE type_t.num10              
DEFINE g_jump                LIKE type_t.num10             #查詢指定的筆數 
DEFINE g_no_ask              LIKE type_t.num5              #是否開啟指定筆視窗 
#DEFINE g_rec_b               LIKE type_t.num5             #單身筆數   #161108-00016#1   2016/11/09  by 08742 mark                      
DEFINE g_rec_b               LIKE type_t.num10             #單身筆數    #161108-00016#1   2016/11/09  by 08742 add                   
#DEFINE l_ac                  LIKE type_t.num5             #161108-00016#1   2016/11/09  by 08742 mark       
DEFINE l_ac                  LIKE type_t.num10             #161108-00016#1   2016/11/09  by 08742 add  #目前處理的ARRAY CNT 
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog     
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
#DEFINE g_pagestart           LIKE type_t.num5             #page起始筆數#161108-00016#1   2016/11/09  by 08742 mark 
DEFINE g_pagestart           LIKE type_t.num10             #page起始筆數#161108-00016#1   2016/11/09  by 08742 add 
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
DEFINE g_ch                  base.Channel                  #外串程式用
DEFINE g_state               STRING
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_error_show          LIKE type_t.num5
DEFINE g_aw                  STRING             #確定當下點擊的單身
 
#快速搜尋用
DEFINE g_searchcol           STRING             #查詢欄位代碼
DEFINE g_searchstr           STRING             #查詢欄位字串
DEFINE g_order               STRING             #查詢排序模式
 
#Browser用
DEFINE g_current_idx         LIKE type_t.num5   #Browser 所在筆數(當下page)
DEFINE g_current_cnt         LIKE type_t.num10  #Browser 總筆數(當下page)
 
#161108-00016#1   2016/11/09  by 08742 -S
#DEFINE g_current_row        LIKE type_t.num5   #Browser 所在筆數(暫存用) 
#DEFINE g_browser_idx        LIKE type_t.num5   #Browser 所在筆數(所有資料)
#DEFINE g_browser_cnt        LIKE type_t.num5   #Browser 總筆數
DEFINE g_browser_idx         LIKE type_t.num10  #Browser 所在筆數(所有資料)
DEFINE g_current_row         LIKE type_t.num10  #Browser 所在筆數(暫存用) 
DEFINE g_browser_cnt         LIKE type_t.num10  
#161108-00016#1   2016/11/09  by 08742 -E
 
DEFINE g_tmp_page            LIKE type_t.num5   
DEFINE g_row_index           LIKE type_t.num5
DEFINE g_chk                 BOOLEAN
DEFINE g_default             BOOLEAN            #是否有外部參數查詢
 
#add-point:自定義模組變數(Module Variable)
GLOBALS
   DEFINE g_detail_insert   LIKE type_t.num5   #單身的新增權限
   DEFINE g_detail_delete   LIKE type_t.num5   #單身的刪除權限
   DEFINE g_wc2_i35001      STRING             #聯絡地址QBE條件
   DEFINE g_d_idx_i35001    LIKE type_t.num5   #聯絡地址所在筆數
   DEFINE g_d_cnt_i35001    LIKE type_t.num5   #聯絡地址總筆數
   DEFINE g_pmaa027_d       LIKE pmaa_t.pmaa027
   DEFINE g_appoint_idx     LIKE type_t.num5   #指定進入單身行數
   TYPE type_g_oofb_d        RECORD
       oofbstus LIKE oofb_t.oofbstus, 
   oofb001 LIKE oofb_t.oofb001, 
   oofb019 LIKE oofb_t.oofb019, 
   oofb011 LIKE oofb_t.oofb011, 
   oofb008 LIKE oofb_t.oofb008, 
   oofb009 LIKE oofb_t.oofb009, 
   oofb009_desc LIKE type_t.chr500, 
   oofb010 LIKE oofb_t.oofb010, 
   oofb012 LIKE oofb_t.oofb012, 
   oofb012_desc LIKE type_t.chr500, 
   oofb013 LIKE oofb_t.oofb013, 
   oofb014 LIKE oofb_t.oofb014, 
   oofb014_desc LIKE type_t.chr500, 
   oofb015 LIKE oofb_t.oofb015, 
   oofb015_desc LIKE type_t.chr500, 
   oofb016 LIKE oofb_t.oofb016, 
   oofb016_desc LIKE type_t.chr500, 
   oofb017 LIKE oofb_t.oofb017, 
   oofb022 LIKE oofb_t.oofb022, 
   oofb022_desc LIKE type_t.chr500, 
   oofb020 LIKE oofb_t.oofb020, 
   oofb021 LIKE oofb_t.oofb021, 
   oofb018 LIKE oofb_t.oofb018
       END RECORD   
   DEFINE g_oofb_d2         DYNAMIC ARRAY OF type_g_oofb_d
END GLOBALS
#end add-point
 
#add-point:傳入參數說明(global.argv)

#end add-point
 
{</section>}
 
{<section id="acrm301.main" >}
#+ 此段落由子樣板a26產生
#OPTIONS SHORT CIRCUIT
#+ 作業開始 
MAIN
   #add-point:main段define
   DEFINE l_success LIKE type_t.num5 #150308-00001#1  By Ken 150309
   #end add-point   
 
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("acr","")
 
   #add-point:作業初始化

   #end add-point
   
   
 
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define

   #end add-point
   LET g_forupd_sql = "SELECT crabunit,'',crab001,'','',crab002,'',crabstus,crab003,crab004,crab005, 
       crab006,crab007,'',crab008,crab009,'',crab010,crab011,crab012,crabacti,crabownid,'',crabowndp,'',crabcrtid, 
       '',crabcrtdp,'',crabcrtdt,crabmodid,'',crabmoddt,crabcnfid,'',crabcnfdt FROM crab_t WHERE crabent=  
       ? AND crab001=? FOR UPDATE"
   #add-point:SQL_define

   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   DECLARE acrm301_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call

      #end add-point
 
   ELSE
      
      #畫面開啟 (identifier)
      OPEN WINDOW w_acrm301 WITH FORM cl_ap_formpath("acr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL acrm301_init()   
 
      #進入選單 Menu (="N")
      CALL acrm301_ui_dialog() 
	  
      #add-point:畫面關閉前

      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_acrm301
      
   END IF 
   
   CLOSE acrm301_cl
   
   
 
   #add-point:作業離開前
   CALL s_aooi500_drop_temp() RETURNING l_success #150308-00001#1  By Ken 150309
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN
 
 
 
{</section>}
 
{<section id="acrm301.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION acrm301_init()
   #add-point:init段define
   DEFINE l_success LIKE type_t.num5 #150308-00001#1  By Ken 150309
   #end add-point
 
      CALL cl_set_combo_scc_part('crabstus','50','N,X,Y')
 
   
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   #add-point:畫面資料初始化
   CALL s_aooi500_create_temp() RETURNING l_success #150308-00001#1  By Ken 150309   
   CALL cl_ui_replace_sub_window(cl_ap_formpath("aoo", "aooi350_01"), "grid_detail", "Table", "s_detail1_aooi350_01")
   CALL cl_set_combo_scc('oofb008','9')   #地址類型
   #end add-point
   
   CALL acrm301_default_search()
 
END FUNCTION
 
{</section>}
 
{<section id="acrm301.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION acrm301_ui_dialog() 
   DEFINE li_exit   LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx    LIKE type_t.num5
   DEFINE ls_wc     STRING
   DEFINE la_param  RECORD
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   #add-point:ui_dialog段define

   #end add-point
   
   LET li_exit = FALSE
   LET g_current_row = 0
   LET g_current_idx = 1
   
   
   #action default動作
   #+ 此段落由子樣板a42產生
   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL acrm301_insert()
            #add-point:ON ACTION insert

            #END add-point
         END IF
 
      #add-point:action default自訂

      #end add-point
      OTHERWISE
         
   END CASE
 
 
   
   #add-point:ui_dialog段before dialog 
 
   #end add-point
 
   WHILE li_exit = FALSE
      
      CALL acrm301_browser_fill(g_wc,"")
      
      #判斷前一個動作是否為新增, 若是的話切換到新增的筆數
      IF g_state = "Y" THEN
         FOR li_idx = 1 TO g_browser.getLength()
            IF g_browser[li_idx].b_crab001 = g_crab001_t
 
               THEN
               LET g_current_row = li_idx
               LET g_current_idx = li_idx
               EXIT FOR
            END IF
         END FOR
         LET g_state = ""
      END IF
    
 

 

 

 

 

 

 

 

 

 
      
         DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
           
 
            #add-point:ui_dialog段自定義display array
            SUBDIALOG aoo_aooi350_01.aooi350_01_display
            #end add-point
 
         
            BEFORE DIALOG
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL acrm301_fetch("")   
               END IF               
               
            AFTER DIALOG
               #add-point:ui_dialog段 after dialog
            ON ACTION exporttoexcel
               LET g_action_choice="exporttoexcel"
               IF cl_auth_chk_act("exporttoexcel") THEN
                  CALL g_export_node.clear()      
                  LET g_export_node[1] = base.typeInfo.create(g_oofb_d2)
                  LET g_export_id[1]   = "s_detail1_aooi350_01"
                  CALL cl_export_to_excel_getpage()
                  CALL cl_export_to_excel()
               END IF
               #end add-point
            
            ON ACTION statechange
               CALL acrm301_statechange()
               LET g_action_choice="statechange"
               EXIT DIALOG
         
 
            ON ACTION first
               CALL acrm301_fetch("F") 
               LET g_current_row = g_current_idx
            
            ON ACTION next
               CALL acrm301_fetch("N")
               LET g_current_row = g_current_idx
         
            ON ACTION jump
               CALL acrm301_fetch("/")
               LET g_current_row = g_current_idx
         
            ON ACTION previous
               CALL acrm301_fetch("P")
               LET g_current_row = g_current_idx
         
            ON ACTION last 
               CALL acrm301_fetch("L")  
               LET g_current_row = g_current_idx
         
            ON ACTION exit
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT DIALOG 
         
            ON ACTION close
               LET li_exit = TRUE
               EXIT DIALOG
         
            ON ACTION mainhidden       #主頁摺疊
               IF g_main_hidden THEN
                  CALL gfrm_curr.setElementHidden("mainlayout",0)
                  CALL gfrm_curr.setElementHidden("worksheet",1)
                  LET g_main_hidden = 0
               ELSE
                  CALL gfrm_curr.setElementHidden("mainlayout",1)
                  CALL gfrm_curr.setElementHidden("worksheet",0)
                  LET g_main_hidden = 1
               END IF
               EXIT DIALOG
               
         
            #單頭摺疊，可利用hot key "Ctrl-s"開啟/關閉單頭
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
 
            #快速搜尋
               
            ON ACTION queryplansel
               CALL cl_dlg_qryplan_select() RETURNING ls_wc
               #不是空條件才寫入g_wc跟重新找資料
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  CALL acrm301_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL acrm301_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "-100"
                     LET g_errparam.extend = ""
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     CLEAR FORM
                  ELSE
                     CALL acrm301_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
               
            
 
         ON ACTION insert
 
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN 
               CALL acrm301_insert()
               #add-point:ON ACTION insert

               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION output
 
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN 
               #add-point:ON ACTION output

               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION reproduce
 
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN 
               CALL acrm301_reproduce()
               #add-point:ON ACTION reproduce

               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION delete
 
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN 
               CALL acrm301_delete()
               #add-point:ON ACTION delete
               #160818-00017#5 -s by 08172
               IF g_crab_m.crabstus = 'N' THEN
                  CALL cl_set_act_visible("modify,delete,modify_detail",TRUE)
               ELSE
                  CALL cl_set_act_visible("modify,delete,modify_detail",FALSE)
               END IF 
               #160818-00017#5 -s by 08172
               #END add-point
            END IF
 
 
         ON ACTION modify
 
            LET g_aw = ''
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN 
               CALL acrm301_modify()
               #add-point:ON ACTION modify
               #160818-00017#5 -s by 08172
               IF g_crab_m.crabstus = 'N' THEN
                  CALL cl_set_act_visible("modify,delete,modify_detail",TRUE)
               ELSE
                  CALL cl_set_act_visible("modify,delete,modify_detail",FALSE)
               END IF 
               #160818-00017#5 -s by 08172
               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION query
 
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN 
               CALL acrm301_query()
               #add-point:ON ACTION query

               #END add-point
            END IF
 
            
            
 
            #+ 此段落由子樣板a46產生
         #新增相關文件
         ON ACTION related_document
            CALL g_pk_array.clear()
            LET g_pk_array[1].values = g_crab_m.crab001
            LET g_pk_array[1].column = 'crab001'
 
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document

               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
		    CALL g_pk_array.clear()
            LET g_pk_array[1].values = g_crab_m.crab001
            LET g_pk_array[1].column = 'crab001'
 
            #add-point:ON ACTION agendum

            #END add-point
			CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL g_pk_array.clear()
            LET g_pk_array[1].values = g_crab_m.crab001
            LET g_pk_array[1].column = 'crab001'
 
            #add-point:ON ACTION followup

            #END add-point
            CALL cl_user_overview_follow('')
 
 
 
            #主選單用ACTION
            &include "main_menu.4gl"
            &include "relating_action.4gl"
            #交談指令共用ACTION
            &include "common_action.4gl"
            
         END DIALOG 
      
      
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="acrm301.browser_fill" >}
#+ 瀏覽頁簽資料填充(一般單檔)
PRIVATE FUNCTION acrm301_browser_fill(p_wc,ps_page_action) 
   DEFINE p_wc              STRING
   DEFINE ps_page_action    STRING
   DEFINE l_searchcol       STRING
   DEFINE l_sql             STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define
   
   #end add-point
   
   CLEAR FORM
   INITIALIZE g_crab_m.* TO NULL
   INITIALIZE g_wc TO NULL
   CALL g_browser.clear()
   
   #搜尋用
   IF cl_null(g_searchcol) OR g_searchcol = "0" THEN
      LET l_searchcol = "crab001"
   ELSE
      LET l_searchcol = g_searchcol
   END IF
 
   LET p_wc = p_wc.trim() #當查詢按下Q時 按下放棄 g_wc = "  " 所以要清掉空白
   IF cl_null(p_wc) THEN  #p_wc 查詢條件
      LET p_wc = " 1=1 " 
   END IF
   
   #add-point:browser_fill段wc控制
   CALL aooi350_01_clear_detail()
   #end add-point
 
   LET g_sql = " SELECT COUNT(*) FROM crab_t ",
               "  ",
               "  LEFT JOIN crabl_t ON crab001 = crabl001 AND crabl002 = '",g_lang,"' ",
               " WHERE crabent = '" ||g_enterprise|| "' AND ", 
               p_wc CLIPPED
                
   #add-point:browser_fill段cnt_sql
   LET g_sql = g_sql,cl_sql_add_filter("crab_t")  #161214-00032#1 ADD
   #end add-point
				
   PREPARE header_cnt_pre FROM g_sql
   EXECUTE header_cnt_pre INTO g_browser_cnt
   FREE header_cnt_pre 
   
   #若超過最大顯示筆數
   
   
   DISPLAY g_browser_cnt TO FORMONLY.b_count
   DISPLAY g_browser_cnt TO FORMONLY.h_count
   
   LET g_wc = p_wc
   #LET g_page_action = ps_page_action          # Keep Action
   
   IF ps_page_action = "F" OR
      ps_page_action = "P"  OR
      ps_page_action = "N"  OR
      ps_page_action = "L"  THEN
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
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'azz-998'
            LET g_errparam.extend = g_jump
            LET g_errparam.popup = FALSE
            CALL cl_err()
 
         END IF
         
      OTHERWISE
         
   END CASE
   
   LET l_sql_rank = "SELECT crabstus,crab001,RANK() OVER(ORDER BY crab001 ",
 
                    g_order,
                    ") AS RANK ",
                    " FROM crab_t ",
                    "  ",
                    "  LEFT JOIN crabl_t ON crab001 = crabl001 AND crabl002 = '",g_lang,"' ",
                    " WHERE crabent = '" ||g_enterprise|| "' AND ", g_wc
 
   #add-point:browser_fill段before_pre
   LET l_sql_rank = l_sql_rank," ",cl_sql_add_filter("crab_t")  #161214-00032#1 ADD
   #end add-point					
					
   #定義翻頁CURSOR
   LET g_sql= " SELECT crabstus,crab001 FROM (",l_sql_rank,") ",
              "  WHERE RANK >= ", g_pagestart,
              "    AND RANK <  ", (g_pagestart + g_max_browse) , 
              "  ORDER BY ",l_searchcol," ",g_order
 
   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre
 
   CALL g_browser.clear()
   LET g_cnt = 1
   FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_crab001
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "foreach:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      
      
      #add-point:browser_fill段reference
      
      #end add-point
      
      LET g_browser[g_cnt].b_statepic = cl_get_actipic(g_browser[g_cnt].b_statepic)
      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "std-00002"
         LET g_errparam.extend = "Max_Row:"||g_max_rec USING "<<<<<"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         EXIT FOREACH
      END IF
   END FOREACH
 
   CALL g_browser.deleteElement(g_cnt)
   LET g_header_cnt = g_browser_cnt
   LET g_rec_b = g_cnt - 1
   LET g_current_cnt = g_browser_cnt
   LET g_cnt = 0
   
   
   FREE browse_pre
   
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,delete,reproduce", FALSE)
   ELSE
      CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   END IF
   
END FUNCTION
 
 
 
{</section>}
 
{<section id="acrm301.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION acrm301_construct()
   DEFINE ls_return      STRING
   DEFINE ls_result      STRING 
   DEFINE ls_wc          STRING 
   #add-point:cs段define
   
   #end add-point
   
   CLEAR FORM
   INITIALIZE g_crab_m.* TO NULL
   INITIALIZE g_wc TO NULL
   LET g_current_row = 1
 
   LET g_qryparam.state = "c"
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #螢幕上取條件
      CONSTRUCT BY NAME g_wc ON crabunit,crab001,crabl004,crabl003,crab002,crabl005,crabstus,crab003, 
          crab004,crab005,crab006,crab007,crab008,crab009,crab010,crab011,crab012,crabacti,crabownid, 
          crabowndp,crabcrtid,crabcrtdp,crabcrtdt,crabmodid,crabmoddt,crabcnfid,crabcnfdt
      
         BEFORE CONSTRUCT                                    
            #add-point:cs段more_construct
            
            #end add-point             
      
         #公用欄位開窗相關處理
         #此段落由子樣板a11產生
         ##----<<crabownid>>----
         #ON ACTION controlp INFIELD crabownid
         #   CALL q_common('crab_t','crabownid',TRUE,FALSE,g_crab_m.crabownid) RETURNING ls_return
         #   DISPLAY ls_return TO crabownid
         #   NEXT FIELD crabownid  
         #
         ##----<<crabowndp>>----
         #ON ACTION controlp INFIELD crabowndp
         #   CALL q_common('crab_t','crabowndp',TRUE,FALSE,g_crab_m.crabowndp) RETURNING ls_return
         #   DISPLAY ls_return TO crabowndp
         #   NEXT FIELD crabowndp
         #
         ##----<<crabcrtid>>----
         #ON ACTION controlp INFIELD crabcrtid
         #   CALL q_common('crab_t','crabcrtid',TRUE,FALSE,g_crab_m.crabcrtid) RETURNING ls_return
         #   DISPLAY ls_return TO crabcrtid
         #   NEXT FIELD crabcrtid
         #
         ##----<<crabcrtdp>>----
         #ON ACTION controlp INFIELD crabcrtdp
         #   CALL q_common('crab_t','crabcrtdp',TRUE,FALSE,g_crab_m.crabcrtdp) RETURNING ls_return
         #   DISPLAY ls_return TO crabcrtdp
         #   NEXT FIELD crabcrtdp
         #
         ##----<<crabmodid>>----
         #ON ACTION controlp INFIELD crabmodid
         #   CALL q_common('crab_t','crabmodid',TRUE,FALSE,g_crab_m.crabmodid) RETURNING ls_return
         #   DISPLAY ls_return TO crabmodid
         #   NEXT FIELD crabmodid
         #
         ##----<<crabcnfid>>----
         #ON ACTION controlp INFIELD crabcnfid
         #   CALL q_common('crab_t','crabcnfid',TRUE,FALSE,g_crab_m.crabcnfid) RETURNING ls_return
         #   DISPLAY ls_return TO crabcnfid
         #   NEXT FIELD crabcnfid
         #
         ##----<<crabpstid>>----
         ##ON ACTION controlp INFIELD crabpstid
         ##   CALL q_common('crab_t','crabpstid',TRUE,FALSE,g_crab_m.crabpstid) RETURNING ls_return
         ##   DISPLAY ls_return TO crabpstid
         ##   NEXT FIELD crabpstid
         
         ##----<<crabcrtdt>>----
         AFTER FIELD crabcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<crabmoddt>>----
         AFTER FIELD crabmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<crabcnfdt>>----
         AFTER FIELD crabcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<crabpstdt>>----
         #AFTER FIELD crabpstdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
      
         #一般欄位
         #---------------------------<  Master  >---------------------------
         #----<<crabunit>>----
         #Ctrlp:construct.c.crabunit
         ON ACTION controlp INFIELD crabunit
            #add-point:ON ACTION controlp INFIELD crabunit
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'crabunit',g_site,'c') #150308-00001#1  By Ken add 'c' 150309
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO crabunit          #顯示到畫面上
            NEXT FIELD crabunit                             #返回原欄位
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD crabunit
            #add-point:BEFORE FIELD crabunit
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD crabunit
            
            #add-point:AFTER FIELD crabunit
            
            #END add-point
            
 
         #----<<crabunit_desc>>----
         #----<<crab001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD crab001
            #add-point:BEFORE FIELD crab001
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD crab001
            
            #add-point:AFTER FIELD crab001
            
            #END add-point
            
 
         #Ctrlp:construct.c.crab001
         ON ACTION controlp INFIELD crab001
            #add-point:ON ACTION controlp INFIELD crab001
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_crab001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO crab001  #顯示到畫面上
            NEXT FIELD crab001                    #返回原欄位
            #END add-point
 
         #----<<crabl004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD crabl004
            #add-point:BEFORE FIELD crabl004
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD crabl004
            
            #add-point:AFTER FIELD crabl004
            
            #END add-point
            
 
         #Ctrlp:construct.c.crabl004
         ON ACTION controlp INFIELD crabl004
            #add-point:ON ACTION controlp INFIELD crabl004
            
            #END add-point
 
         #----<<crabl003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD crabl003
            #add-point:BEFORE FIELD crabl003
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD crabl003
            
            #add-point:AFTER FIELD crabl003
            
            #END add-point
            
 
         #Ctrlp:construct.c.crabl003
         ON ACTION controlp INFIELD crabl003
            #add-point:ON ACTION controlp INFIELD crabl003
            
            #END add-point
 
         #----<<crab002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD crab002
            #add-point:BEFORE FIELD crab002
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD crab002
            
            #add-point:AFTER FIELD crab002
            
            #END add-point
            
 
         #Ctrlp:construct.c.crab002
         ON ACTION controlp INFIELD crab002
            #add-point:ON ACTION controlp INFIELD crab002
            
            #END add-point
 
         #----<<crabl005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD crabl005
            #add-point:BEFORE FIELD crabl005
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD crabl005
            
            #add-point:AFTER FIELD crabl005
            
            #END add-point
            
 
         #Ctrlp:construct.c.crabl005
         ON ACTION controlp INFIELD crabl005
            #add-point:ON ACTION controlp INFIELD crabl005
            
            #END add-point
 
         #----<<crabstus>>----
         #此段落由子樣板a01產生
         BEFORE FIELD crabstus
            #add-point:BEFORE FIELD crabstus
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD crabstus
            
            #add-point:AFTER FIELD crabstus
            
            #END add-point
            
 
         #Ctrlp:construct.c.crabstus
         ON ACTION controlp INFIELD crabstus
            #add-point:ON ACTION controlp INFIELD crabstus
            
            #END add-point
 
         #----<<crab003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD crab003
            #add-point:BEFORE FIELD crab003
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD crab003
            
            #add-point:AFTER FIELD crab003
            
            #END add-point
            
 
         #Ctrlp:construct.c.crab003
         ON ACTION controlp INFIELD crab003
            #add-point:ON ACTION controlp INFIELD crab003
            
            #END add-point
 
         #----<<crab004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD crab004
            #add-point:BEFORE FIELD crab004
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD crab004
            
            #add-point:AFTER FIELD crab004
            
            #END add-point
            
 
         #Ctrlp:construct.c.crab004
         ON ACTION controlp INFIELD crab004
            #add-point:ON ACTION controlp INFIELD crab004
            
            #END add-point
 
         #----<<crab005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD crab005
            #add-point:BEFORE FIELD crab005
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD crab005
            
            #add-point:AFTER FIELD crab005
            
            #END add-point
            
 
         #Ctrlp:construct.c.crab005
         ON ACTION controlp INFIELD crab005
            #add-point:ON ACTION controlp INFIELD crab005
            
            #END add-point
 
         #----<<crab006>>----
         #此段落由子樣板a01產生
         BEFORE FIELD crab006
            #add-point:BEFORE FIELD crab006
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD crab006
            
            #add-point:AFTER FIELD crab006
            
            #END add-point
            
 
         #Ctrlp:construct.c.crab006
         ON ACTION controlp INFIELD crab006
            #add-point:ON ACTION controlp INFIELD crab006
            
            #END add-point
 
         #----<<crab007>>----
         #Ctrlp:construct.c.crab007
         ON ACTION controlp INFIELD crab007
            #add-point:ON ACTION controlp INFIELD crab007
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site
            CALL q_ooaj002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO crab007  #顯示到畫面上
            NEXT FIELD crab007                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD crab007
            #add-point:BEFORE FIELD crab007
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD crab007
            
            #add-point:AFTER FIELD crab007
            
            #END add-point
            
 
         #----<<crab008>>----
         #此段落由子樣板a01產生
         BEFORE FIELD crab008
            #add-point:BEFORE FIELD crab008
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD crab008
            
            #add-point:AFTER FIELD crab008
            
            #END add-point
            
 
         #Ctrlp:construct.c.crab008
         ON ACTION controlp INFIELD crab008
            #add-point:ON ACTION controlp INFIELD crab008
            
            #END add-point
 
         #----<<crab009>>----
         #Ctrlp:construct.c.crab009
         ON ACTION controlp INFIELD crab009
            #add-point:ON ACTION controlp INFIELD crab009
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site
            CALL q_ooaj002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO crab009  #顯示到畫面上
            NEXT FIELD crab009                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD crab009
            #add-point:BEFORE FIELD crab009
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD crab009
            
            #add-point:AFTER FIELD crab009
            
            #END add-point
            
 
         #----<<crab010>>----
         #此段落由子樣板a01產生
         BEFORE FIELD crab010
            #add-point:BEFORE FIELD crab010
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD crab010
            
            #add-point:AFTER FIELD crab010
            
            #END add-point
            
 
         #Ctrlp:construct.c.crab010
         ON ACTION controlp INFIELD crab010
            #add-point:ON ACTION controlp INFIELD crab010
            
            #END add-point
 
         #----<<crab011>>----
         #此段落由子樣板a01產生
         BEFORE FIELD crab011
            #add-point:BEFORE FIELD crab011
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD crab011
            
            #add-point:AFTER FIELD crab011
            NEXT FIELD oofb008
            #END add-point
            
 
         #Ctrlp:construct.c.crab011
         ON ACTION controlp INFIELD crab011
            #add-point:ON ACTION controlp INFIELD crab011
            
            #END add-point
 
         #----<<crab012>>----
         #此段落由子樣板a01產生
         BEFORE FIELD crab012
            #add-point:BEFORE FIELD crab012
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD crab012
            
            #add-point:AFTER FIELD crab012
            
            #END add-point
            
 
         #Ctrlp:construct.c.crab012
         ON ACTION controlp INFIELD crab012
            #add-point:ON ACTION controlp INFIELD crab012
            
            #END add-point
 
         #----<<crabacti>>----
         #此段落由子樣板a01產生
         BEFORE FIELD crabacti
            #add-point:BEFORE FIELD crabacti
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD crabacti
            
            #add-point:AFTER FIELD crabacti
            
            #END add-point
            
 
         #Ctrlp:construct.c.crabacti
         ON ACTION controlp INFIELD crabacti
            #add-point:ON ACTION controlp INFIELD crabacti
            
            #END add-point
 
         #----<<crabownid>>----
         #Ctrlp:construct.c.crabownid
         ON ACTION controlp INFIELD crabownid
            #add-point:ON ACTION controlp INFIELD crabownid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO crabownid  #顯示到畫面上
            NEXT FIELD crabownid                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD crabownid
            #add-point:BEFORE FIELD crabownid
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD crabownid
            
            #add-point:AFTER FIELD crabownid
            
            #END add-point
            
 
         #----<<crabownid_desc>>----
         #----<<crabowndp>>----
         #Ctrlp:construct.c.crabowndp
         ON ACTION controlp INFIELD crabowndp
            #add-point:ON ACTION controlp INFIELD crabowndp
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO crabowndp  #顯示到畫面上
            NEXT FIELD crabowndp                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD crabowndp
            #add-point:BEFORE FIELD crabowndp
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD crabowndp
            
            #add-point:AFTER FIELD crabowndp
            
            #END add-point
            
 
         #----<<crabowndp_desc>>----
         #----<<crabcrtid>>----
         #Ctrlp:construct.c.crabcrtid
         ON ACTION controlp INFIELD crabcrtid
            #add-point:ON ACTION controlp INFIELD crabcrtid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO crabcrtid  #顯示到畫面上
            NEXT FIELD crabcrtid                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD crabcrtid
            #add-point:BEFORE FIELD crabcrtid
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD crabcrtid
            
            #add-point:AFTER FIELD crabcrtid
            
            #END add-point
            
 
         #----<<crabcrtid_desc>>----
         #----<<crabcrtdp>>----
         #Ctrlp:construct.c.crabcrtdp
         ON ACTION controlp INFIELD crabcrtdp
            #add-point:ON ACTION controlp INFIELD crabcrtdp
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO crabcrtdp  #顯示到畫面上
            NEXT FIELD crabcrtdp                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD crabcrtdp
            #add-point:BEFORE FIELD crabcrtdp
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD crabcrtdp
            
            #add-point:AFTER FIELD crabcrtdp
            
            #END add-point
            
 
         #----<<crabcrtdp_desc>>----
         #----<<crabcrtdt>>----
         #此段落由子樣板a01產生
         BEFORE FIELD crabcrtdt
            #add-point:BEFORE FIELD crabcrtdt
            
            #END add-point
 
         #----<<crabmodid>>----
         #Ctrlp:construct.c.crabmodid
         ON ACTION controlp INFIELD crabmodid
            #add-point:ON ACTION controlp INFIELD crabmodid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO crabmodid  #顯示到畫面上
            NEXT FIELD crabmodid                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD crabmodid
            #add-point:BEFORE FIELD crabmodid
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD crabmodid
            
            #add-point:AFTER FIELD crabmodid
            
            #END add-point
            
 
         #----<<crabmodid_desc>>----
         #----<<crabmoddt>>----
         #此段落由子樣板a01產生
         BEFORE FIELD crabmoddt
            #add-point:BEFORE FIELD crabmoddt
            
            #END add-point
 
         #----<<crabcnfid>>----
         #Ctrlp:construct.c.crabcnfid
         ON ACTION controlp INFIELD crabcnfid
            #add-point:ON ACTION controlp INFIELD crabcnfid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO crabcnfid  #顯示到畫面上
            NEXT FIELD crabcnfid                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD crabcnfid
            #add-point:BEFORE FIELD crabcnfid
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD crabcnfid
            
            #add-point:AFTER FIELD crabcnfid
            
            #END add-point
            
 
         #----<<crabcnfid_desc>>----
         #----<<crabcnfdt>>----
         #此段落由子樣板a01產生
         BEFORE FIELD crabcnfdt
            #add-point:BEFORE FIELD crabcnfdt
            
            #END add-point
 
 
           
      END CONSTRUCT
      
      #add-point:cs段more_construct
      SUBDIALOG aoo_aooi350_01.aooi350_01_construct
      #end add-point   
      
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog
         
         #end add-point  
      
      ON ACTION accept
         ACCEPT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
 
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
    
      #條件儲存為方案
      ON ACTION qbe_save
         CALL cl_qbe_save()
 
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   END DIALOG
  
   #add-point:cs段after_construct
   
   #end add-point
  
   #LET g_wc = g_wc CLIPPED,cl_get_extra_cond("", "")
 
END FUNCTION
 
{</section>}
 
{<section id="acrm301.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION acrm301_query()
   DEFINE ls_wc STRING
   #add-point:query段define
   
   #end add-point
   
   LET INT_FLAG = 0
   LET ls_wc = g_wc
   
   #切換畫面
 
   CALL g_browser.clear() 
 
   IF g_worksheet_hidden THEN  #browser panel折疊
      CALL gfrm_curr.setElementHidden("worksheet_vbox",0)
      CALL gfrm_curr.setElementImage("worksheethidden","worksheethidden-24.png")
      LET g_worksheet_hidden = 0
   END IF
   IF g_header_hidden THEN    #單頭折疊
      CALL gfrm_curr.setElementHidden("vb_master",0)
      CALL gfrm_curr.setElementImage("controls","headerhidden-24")
      LET g_header_hidden = 0
   END IF
 
   INITIALIZE g_crab_m.* TO NULL
   ERROR ""
 
   DISPLAY " " TO FORMONLY.b_count
   DISPLAY " " TO FORMONLY.h_count
   CALL acrm301_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      CALL acrm301_browser_fill(g_wc,"F")
      CALL acrm301_fetch("")
      RETURN
   ELSE
      LET g_current_row = 1
      LET g_current_cnt = 0
   END IF
   
   LET g_error_show = 1
   CALL acrm301_browser_fill(g_wc,"F")   # 移到第一頁
   
   #儲存WC資訊
   CALL cl_dlg_save_user_latestqry("("||g_wc||")")
   
   #備份搜尋條件
   LET ls_wc = g_wc
   
   IF g_browser.getLength() = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "-100"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
 
   ELSE
      CALL acrm301_fetch("F") 
   END IF
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="acrm301.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION acrm301_fetch(p_fl)
   DEFINE p_fl       LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define
   
   #end add-point  
   
   CASE p_fl
      WHEN "F" LET g_current_idx = 1
      WHEN "P"
         IF g_current_idx > 1 THEN               
            LET g_current_idx = g_current_idx - 1
         END IF 
      WHEN "N"
         IF g_current_idx < g_header_cnt THEN
            LET g_current_idx =  g_current_idx + 1
         END IF        
      WHEN "L" 
         LET g_current_idx = g_header_cnt        
      WHEN "/"
         IF (NOT g_no_ask) THEN      
            CALL cl_getmsg("fetch", g_lang) RETURNING ls_msg
            LET INT_FLAG = 0
 
            PROMPT ls_msg CLIPPED,": " FOR g_jump
               #交談指令共用ACTION
               &include "common_action.4gl"
            END PROMPT
            
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               EXIT CASE  
            END IF           
         END IF
         IF g_jump > 0 THEN
            LET g_current_idx = g_jump
         END IF
         LET g_no_ask = FALSE     
   END CASE
   
   LET g_browser_cnt = g_browser.getLength()
 
   #瀏覽頁筆數顯示
   LET g_browser_idx = g_pagestart+g_current_idx-1
   DISPLAY g_browser_idx TO FORMONLY.b_index        #當下筆數
   DISPLAY g_browser_cnt TO FORMONLY.b_count        #總筆數
   DISPLAY g_browser_idx TO FORMONLY.h_index        #當下筆數
   DISPLAY g_browser_cnt TO FORMONLY.h_count        #總筆數
   CALL ui.Interface.refresh()
   
   #單頭筆數顯示
   #DISPLAY g_browser_idx TO FORMONLY.idx            #當下筆數
   #DISPLAY g_browser_cnt TO FORMONLY.cnt            #總筆數
   
   
   
   IF g_current_idx > g_browser.getLength() THEN
      LET g_current_idx = g_browser.getLength()
   END IF
   
   # 設定browse索引
 
   CALL cl_navigator_setting(g_browser_idx, g_browser_cnt )
 
   #代表沒有資料, 無需做後續資料撈取之動作
   IF g_current_idx = 0 THEN
      RETURN
   END IF
 
   LET g_crab_m.crab001 = g_browser[g_current_idx].b_crab001
 
                       
   #重讀DB,因TEMP有不被更新特性
    SELECT UNIQUE crabunit,crab001,crab002,crabstus,crab003,crab004,crab005,crab006,crab007,crab008, 
        crab009,crab010,crab011,crab012,crabacti,crabownid,crabowndp,crabcrtid,crabcrtdp,crabcrtdt,crabmodid, 
        crabmoddt,crabcnfid,crabcnfdt
 INTO g_crab_m.crabunit,g_crab_m.crab001,g_crab_m.crab002,g_crab_m.crabstus,g_crab_m.crab003,g_crab_m.crab004, 
     g_crab_m.crab005,g_crab_m.crab006,g_crab_m.crab007,g_crab_m.crab008,g_crab_m.crab009,g_crab_m.crab010, 
     g_crab_m.crab011,g_crab_m.crab012,g_crab_m.crabacti,g_crab_m.crabownid,g_crab_m.crabowndp,g_crab_m.crabcrtid, 
     g_crab_m.crabcrtdp,g_crab_m.crabcrtdt,g_crab_m.crabmodid,g_crab_m.crabmoddt,g_crab_m.crabcnfid, 
     g_crab_m.crabcnfdt
 FROM crab_t
 WHERE crabent = g_enterprise AND crab001 = g_crab_m.crab001
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "crab_t"
      LET g_errparam.popup = FALSE
      CALL cl_err()
 
      INITIALIZE g_crab_m.* TO NULL
      RETURN
   END IF
   
   #add-point:fetch段action控制
   IF g_crab_m.crabstus = 'N' THEN
      CALL cl_set_act_visible("modify,delete,modify_detail",TRUE)
   ELSE
      CALL cl_set_act_visible("modify,delete,modify_detail",FALSE)
   END IF 
   #end add-point  
   
   
   
   #重新顯示
   CALL acrm301_show()
 
END FUNCTION
 
{</section>}
 
{<section id="acrm301.insert" >}
#+ 資料新增
PRIVATE FUNCTION acrm301_insert()
   #add-point:insert段define
   DEFINE l_insert      LIKE type_t.num5
   #end add-point    
   
   CLEAR FORM #清畫面欄位內容
 
   INITIALIZE g_crab_m.* LIKE crab_t.*             #DEFAULT 設定
   LET g_crab001_t = NULL
 
   
   CALL s_transaction_begin()
   
   WHILE TRUE
      #六階樹狀給值
 
      
      #公用欄位給值
      #此段落由子樣板a14產生    
      LET g_crab_m.crabownid = g_user
      LET g_crab_m.crabowndp = g_dept
      LET g_crab_m.crabcrtid = g_user
      LET g_crab_m.crabcrtdp = g_dept 
      LET g_crab_m.crabcrtdt = cl_get_current()
      LET g_crab_m.crabmodid = ""
      LET g_crab_m.crabmoddt = ""
      #LET g_crab_m.crabstus = ""
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
      
 
      #add-point:單頭預設值
      LET g_crab_m.crabstus = "N"
      LET g_crab_m.crabacti = "Y"
      
      CALL s_aooi500_default(g_prog,'crabunit',g_site)
       RETURNING l_insert,g_crab_m.crabunit
      IF NOT l_insert THEN
        RETURN
      END IF
      CALL acrm301_crabunit_ref()
      
      CALL aooi350_01_clear_detail()
      INITIALIZE g_pmaa027_d TO NULL
      #end add-point   
     
      CALL acrm301_input("a")
      
      #add-point:單頭輸入後
      LET g_crab001_t = g_crab_m.crab001
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_crab_m.* = g_crab_m_t.*
         CALL acrm301_show()
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9001
         LET g_errparam.extend = ""
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         EXIT WHILE
      END IF
 
      LET g_rec_b = 0
      EXIT WHILE
   END WHILE
   
   LET g_crab001_t = g_crab_m.crab001
 
   
   LET g_state = "Y"
 
   LET g_wc = g_wc,  
              " OR ( crabent = '" ||g_enterprise|| "' AND",
              " crab001 = '", g_crab_m.crab001 CLIPPED, "' "
 
              , ") "
 
END FUNCTION
 
{</section>}
 
{<section id="acrm301.modify" >}
#+ 資料修改
PRIVATE FUNCTION acrm301_modify()
   #add-point:modify段define

   #end add-point
   
   IF g_crab_m.crab001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
 
      RETURN
   END IF 
   
    SELECT UNIQUE crabunit,crab001,crab002,crabstus,crab003,crab004,crab005,crab006,crab007,crab008, 
        crab009,crab010,crab011,crab012,crabacti,crabownid,crabowndp,crabcrtid,crabcrtdp,crabcrtdt,crabmodid, 
        crabmoddt,crabcnfid,crabcnfdt
 INTO g_crab_m.crabunit,g_crab_m.crab001,g_crab_m.crab002,g_crab_m.crabstus,g_crab_m.crab003,g_crab_m.crab004, 
     g_crab_m.crab005,g_crab_m.crab006,g_crab_m.crab007,g_crab_m.crab008,g_crab_m.crab009,g_crab_m.crab010, 
     g_crab_m.crab011,g_crab_m.crab012,g_crab_m.crabacti,g_crab_m.crabownid,g_crab_m.crabowndp,g_crab_m.crabcrtid, 
     g_crab_m.crabcrtdp,g_crab_m.crabcrtdt,g_crab_m.crabmodid,g_crab_m.crabmoddt,g_crab_m.crabcnfid, 
     g_crab_m.crabcnfdt
 FROM crab_t
 WHERE crabent = g_enterprise AND crab001 = g_crab_m.crab001
 
   ERROR ""
  
   LET g_crab001_t = g_crab_m.crab001
 
   
   CALL s_transaction_begin()
   
   OPEN acrm301_cl USING g_enterprise,g_crab_m.crab001
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN acrm301_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
 
      CLOSE acrm301_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #鎖住將被更改或取消的資料
   FETCH acrm301_cl INTO g_crab_m.crabunit,g_crab_m.crabunit_desc,g_crab_m.crab001,g_crab_m.crabl004, 
       g_crab_m.crabl003,g_crab_m.crab002,g_crab_m.crabl005,g_crab_m.crabstus,g_crab_m.crab003,g_crab_m.crab004, 
       g_crab_m.crab005,g_crab_m.crab006,g_crab_m.crab007,g_crab_m.crab007_desc,g_crab_m.crab008,g_crab_m.crab009,g_crab_m.crab009_desc,g_crab_m.crab010, 
       g_crab_m.crab011,g_crab_m.crab012,g_crab_m.crabacti,g_crab_m.crabownid,g_crab_m.crabownid_desc, 
       g_crab_m.crabowndp,g_crab_m.crabowndp_desc,g_crab_m.crabcrtid,g_crab_m.crabcrtid_desc,g_crab_m.crabcrtdp, 
       g_crab_m.crabcrtdp_desc,g_crab_m.crabcrtdt,g_crab_m.crabmodid,g_crab_m.crabmodid_desc,g_crab_m.crabmoddt, 
       g_crab_m.crabcnfid,g_crab_m.crabcnfid_desc,g_crab_m.crabcnfdt
 
   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "crab_t"
      LET g_errparam.popup = FALSE
      CALL cl_err()
 
      CLOSE acrm301_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   #160818-00017#5 -s by 08172
   #檢查是否允許此動作
   IF NOT acrm301_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   #160818-00017#5 -e by 08172
   
 
   CALL acrm301_show()
   
   WHILE TRUE
      LET g_crab_m.crab001 = g_crab001_t
 
      
      #寫入修改者/修改日期資訊
      LET g_crab_m.crabmodid = g_user 
LET g_crab_m.crabmoddt = cl_get_current()
 
      
      #add-point:modify段修改前

      #end add-point
 
      CALL acrm301_input("u")     #欄位更改
 
      #add-point:modify段修改後

      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_crab_m.* = g_crab_m_t.*
         CALL acrm301_show()
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9001
         LET g_errparam.extend = ""
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         EXIT WHILE
      END IF
 
      EXIT WHILE
      
   END WHILE
 
   #修改歷程記錄
   IF NOT cl_log_modified_record(g_crab_m.crab001,g_site) THEN 
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE acrm301_cl
   CALL s_transaction_end('Y','0')
 
   #流程通知預埋點-U
   CALL cl_flow_notify(g_crab_m.crab001,"U")
   
   LET g_worksheet_hidden = 0
   
END FUNCTION   
 
{</section>}
 
{<section id="acrm301.input" >}
#+ 資料輸入
PRIVATE FUNCTION acrm301_input(p_cmd)
   DEFINE p_cmd           LIKE type_t.chr1
   DEFINE l_ac_t          LIKE type_t.num5        #未取消的ARRAY CNT 
   DEFINE l_n             LIKE type_t.num5        #檢查重複用  
   DEFINE l_cnt           LIKE type_t.num5        #檢查重複用  
   DEFINE l_lock_sw       LIKE type_t.chr1        #單身鎖住否  
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num5
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_insert        LIKE type_t.num5
   DEFINE ls_return       STRING
   DEFINE l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE l_vars          DYNAMIC ARRAY OF STRING
   DEFINE l_fields        DYNAMIC ARRAY OF STRING
   #add-point:input段define
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_errno               LIKE type_t.chr10
   #end add-point
 
   #切換畫面
   
   CALL cl_set_head_visible("","YES")  
   
   IF p_cmd = 'r' THEN
      #此段落的r動作等同於a
      LET p_cmd = 'a'
   END IF
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   LET g_qryparam.state = "i"
   
   #控制key欄位可否輸入
   CALL acrm301_set_entry(p_cmd)
   #add-point:set_entry後
   
   #end add-point
   CALL acrm301_set_no_entry(p_cmd)
   #add-point:資料輸入前
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_detail_insert = l_allow_insert
   LET g_detail_delete = l_allow_delete
   #end add-point
   
   DISPLAY BY NAME g_crab_m.crabunit,g_crab_m.crab001,g_crab_m.crabl004,g_crab_m.crabl003,g_crab_m.crab002, 
       g_crab_m.crabl005,g_crab_m.crabstus,g_crab_m.crab003,g_crab_m.crab004,g_crab_m.crab005,g_crab_m.crab006, 
       g_crab_m.crab007,g_crab_m.crab008,g_crab_m.crab009,g_crab_m.crab010,g_crab_m.crab011,g_crab_m.crab012, 
       g_crab_m.crabacti
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_crab_m.crabunit,g_crab_m.crab001,g_crab_m.crabl004,g_crab_m.crabl003,g_crab_m.crab002, 
          g_crab_m.crabl005,g_crab_m.crabstus,g_crab_m.crab003,g_crab_m.crab004,g_crab_m.crab005,g_crab_m.crab006, 
          g_crab_m.crab007,g_crab_m.crab008,g_crab_m.crab009,g_crab_m.crab010,g_crab_m.crab011,g_crab_m.crab012, 
          g_crab_m.crabacti 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
 
         ON ACTION update_item
            #add-point:ON ACTION update_item
            IF NOT cl_null(g_crab_m.crab001) THEN
               CALL n_crabl(g_crab_m.crab001)
               CALL acrm301_crab001_ref()
            END IF 
            #END add-point
 
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            #其他table資料備份(確定是否更改用)
            LET g_master_multi_table_t.crabl001 = g_crab_m.crab001
LET g_master_multi_table_t.crabl004 = g_crab_m.crabl004
LET g_master_multi_table_t.crabl003 = g_crab_m.crabl003
LET g_master_multi_table_t.crabl005 = g_crab_m.crabl005
 
            #add-point:input開始前
            
            #end add-point
   
         #---------------------------<  Master  >---------------------------
         #----<<crabunit>>----
         #此段落由子樣板a02產生
         AFTER FIELD crabunit
            
            #add-point:AFTER FIELD crabunit
            LET g_crab_m.crabunit_desc = NULL
            DISPLAY BY NAME g_crab_m.crabunit_desc
            IF NOT cl_null(g_crab_m.crabunit) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_crab_m.crabunit != g_crab_m_t.crabunit OR g_crab_m_t.crabunit IS null)) THEN
                  CALL s_aooi500_chk(g_prog,'crabunit',g_crab_m.crabunit,g_site)
                   RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = g_crab_m.crabunit
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     LET g_crab_m.crabunit = g_crab_m_t.crabunit
                     CALL acrm301_crabunit_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL acrm301_crabunit_ref()
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD crabunit
            #add-point:BEFORE FIELD crabunit
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE crabunit
            #add-point:ON CHANGE crabunit
            
            #END add-point
 
         #----<<crabunit_desc>>----
         #----<<crab001>>----
         #此段落由子樣板a02產生
         AFTER FIELD crab001
            
            #add-point:AFTER FIELD crab001
 
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_crab_m.crab001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_crab_m.crab001 != g_crab001_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM crab_t WHERE "||"crabent = '" ||g_enterprise|| "' AND "||"crab001 = '"||g_crab_m.crab001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD crab001
            #add-point:BEFORE FIELD crab001
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE crab001
            #add-point:ON CHANGE crab001
            
            #END add-point
 
         #----<<crabl004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD crabl004
            #add-point:BEFORE FIELD crabl004
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD crabl004
            
            #add-point:AFTER FIELD crabl004
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE crabl004
            #add-point:ON CHANGE crabl004
            
            #END add-point
 
         #----<<crabl003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD crabl003
            #add-point:BEFORE FIELD crabl003
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD crabl003
            
            #add-point:AFTER FIELD crabl003
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE crabl003
            #add-point:ON CHANGE crabl003
            
            #END add-point
 
         #----<<crab002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD crab002
            #add-point:BEFORE FIELD crab002
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD crab002
            
            #add-point:AFTER FIELD crab002
            IF NOT cl_null(g_crab_m.crab002) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_crab_m.crab002 != g_crab_m_t.crab002 OR cl_null(g_crab_m_t.crab002))) THEN
                  LET l_n = 0
                  IF cl_null(g_crab_m.crab001) THEN
                     SELECT COUNT(*) INTO l_n
                       FROM crab_t
                      WHERE crabent = g_enterprise
                        AND crab002 = g_crab_m.crab002
                  ELSE
                     SELECT COUNT(*) INTO l_n
                       FROM crab_t
                      WHERE crabent = g_enterprise
                        AND crab001 <> g_crab_m.crab001
                        AND crab002 = g_crab_m.crab002
                  END IF
                  IF l_n > 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'acr-00069'
                     LET g_errparam.extend = g_crab_m.crab002
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_crab_m.crab002 = g_crab_m_t.crab002
                     DISPLAY BY NAME g_crab_m.crab002
                     NEXT FIELD crab002
                  END IF
               END IF
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE crab002
            #add-point:ON CHANGE crab002
            
            #END add-point
 
         #----<<crabl005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD crabl005
            #add-point:BEFORE FIELD crabl005
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD crabl005
            
            #add-point:AFTER FIELD crabl005
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE crabl005
            #add-point:ON CHANGE crabl005
            
            #END add-point
 
         #----<<crabstus>>----
         #此段落由子樣板a01產生
         BEFORE FIELD crabstus
            #add-point:BEFORE FIELD crabstus
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD crabstus
            
            #add-point:AFTER FIELD crabstus
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE crabstus
            #add-point:ON CHANGE crabstus
            
            #END add-point
 
         #----<<crab003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD crab003
            #add-point:BEFORE FIELD crab003
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD crab003
            
            #add-point:AFTER FIELD crab003
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE crab003
            #add-point:ON CHANGE crab003
            
            #END add-point
 
         #----<<crab004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD crab004
            #add-point:BEFORE FIELD crab004
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD crab004
            
            #add-point:AFTER FIELD crab004
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE crab004
            #add-point:ON CHANGE crab004
            
            #END add-point
 
         #----<<crab005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD crab005
            #add-point:BEFORE FIELD crab005
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD crab005
            
            #add-point:AFTER FIELD crab005
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE crab005
            #add-point:ON CHANGE crab005
            
            #END add-point
 
         #----<<crab006>>----
         #此段落由子樣板a02產生
         AFTER FIELD crab006
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_crab_m.crab006,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD crab006
            END IF
 
 
            #add-point:AFTER FIELD crab006
            IF NOT cl_ap_chk_Range(g_crab_m.crab006,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD crab006
            END IF
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD crab006
            #add-point:BEFORE FIELD crab006
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE crab006
            #add-point:ON CHANGE crab006
            
            #END add-point
 
         #----<<crab007>>----
         #此段落由子樣板a02產生
         AFTER FIELD crab007
            
            #add-point:AFTER FIELD crab007
            IF NOT cl_null(g_crab_m.crab007) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_crab_m.crabunit
               LET g_chkparam.arg2 = g_crab_m.crab007
               #160318-00025#36  2016/04/18  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "aoo-00176:sub-01302|aooi150|",cl_get_progname("aooi150",g_lang,"2"),"|:EXEPROGaooi150"
               #160318-00025#36  2016/04/18  by pengxin  add(E)
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooaj002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            CALL acrm301_crab007_ref()

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD crab007
            #add-point:BEFORE FIELD crab007
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE crab007
            #add-point:ON CHANGE crab007
            
            #END add-point
 
         #----<<crab008>>----
         #此段落由子樣板a02產生
         AFTER FIELD crab008
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_crab_m.crab008,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD crab008
            END IF
 
 
            #add-point:AFTER FIELD crab008
            IF NOT cl_ap_chk_Range(g_crab_m.crab008,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD crab008
            END IF
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD crab008
            #add-point:BEFORE FIELD crab008
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE crab008
            #add-point:ON CHANGE crab008
            
            #END add-point
 
         #----<<crab009>>----
         #此段落由子樣板a02產生
         AFTER FIELD crab009
            
            #add-point:AFTER FIELD crab009
            IF NOT cl_null(g_crab_m.crab009) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_crab_m.crabunit
               LET g_chkparam.arg2 = g_crab_m.crab009
               #160318-00025#36  2016/04/18  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "aoo-00176:sub-01302|aooi150|",cl_get_progname("aooi150",g_lang,"2"),"|:EXEPROGaooi150"
               #160318-00025#36  2016/04/18  by pengxin  add(E)
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooaj002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            CALL acrm301_crab009_ref()

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD crab009
            #add-point:BEFORE FIELD crab009
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE crab009
            #add-point:ON CHANGE crab009
            
            #END add-point
 
         #----<<crab010>>----
         #此段落由子樣板a02產生
         AFTER FIELD crab010
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_crab_m.crab010,"0","1","","","azz-00079",1) THEN
               NEXT FIELD crab010
            END IF
 
 
            #add-point:AFTER FIELD crab010
 
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD crab010
            #add-point:BEFORE FIELD crab010
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE crab010
            #add-point:ON CHANGE crab010
            
            #END add-point
 
         #----<<crab011>>----
         #此段落由子樣板a01產生
         BEFORE FIELD crab011
            #add-point:BEFORE FIELD crab011
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD crab011
            
            #add-point:AFTER FIELD crab011
            NEXT FIELD oofb008
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE crab011
            #add-point:ON CHANGE crab011
            
            #END add-point
 
         #----<<crab012>>----
         #此段落由子樣板a01產生
         BEFORE FIELD crab012
            #add-point:BEFORE FIELD crab012
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD crab012
            
            #add-point:AFTER FIELD crab012
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE crab012
            #add-point:ON CHANGE crab012
            
            #END add-point
 
         #----<<crabacti>>----
         #此段落由子樣板a01產生
         BEFORE FIELD crabacti
            #add-point:BEFORE FIELD crabacti
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD crabacti
            
            #add-point:AFTER FIELD crabacti
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE crabacti
            #add-point:ON CHANGE crabacti
            
            #END add-point
 
         #----<<crabownid>>----
         #----<<crabownid_desc>>----
         #----<<crabowndp>>----
         #----<<crabowndp_desc>>----
         #----<<crabcrtid>>----
         #----<<crabcrtid_desc>>----
         #----<<crabcrtdp>>----
         #----<<crabcrtdp_desc>>----
         #----<<crabcrtdt>>----
         #----<<crabmodid>>----
         #----<<crabmodid_desc>>----
         #----<<crabmoddt>>----
         #----<<crabcnfid>>----
         #----<<crabcnfid_desc>>----
         #----<<crabcnfdt>>----
 #欄位檢查
         #---------------------------<  Master  >---------------------------
         #----<<crabunit>>----
         #Ctrlp:input.c.crabunit
         ON ACTION controlp INFIELD crabunit
            #add-point:ON ACTION controlp INFIELD crabunit
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_crab_m.crabunit
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'crabunit',g_site,'i') #150308-00001#1  By Ken add 'i' 150309
            CALL q_ooef001_24()
            LET g_crab_m.crabunit = g_qryparam.return1           #將開窗取得的值回傳到變數
            DISPLAY g_crab_m.crabunit TO crabunit                 #顯示到畫面上
            CALL acrm301_crabunit_ref()
            NEXT FIELD crabunit                                  #返回原欄位  
            #END add-point
 
         #----<<crabunit_desc>>----
         #----<<crab001>>----
         #Ctrlp:input.c.crab001
         ON ACTION controlp INFIELD crab001
            #add-point:ON ACTION controlp INFIELD crab001
            
            #END add-point
 
         #----<<crabl004>>----
         #Ctrlp:input.c.crabl004
         ON ACTION controlp INFIELD crabl004
            #add-point:ON ACTION controlp INFIELD crabl004
            
            #END add-point
 
         #----<<crabl003>>----
         #Ctrlp:input.c.crabl003
         ON ACTION controlp INFIELD crabl003
            #add-point:ON ACTION controlp INFIELD crabl003
            
            #END add-point
 
         #----<<crab002>>----
         #Ctrlp:input.c.crab002
         ON ACTION controlp INFIELD crab002
            #add-point:ON ACTION controlp INFIELD crab002
            
            #END add-point
 
         #----<<crabl005>>----
         #Ctrlp:input.c.crabl005
         ON ACTION controlp INFIELD crabl005
            #add-point:ON ACTION controlp INFIELD crabl005
            
            #END add-point
 
         #----<<crabstus>>----
         #Ctrlp:input.c.crabstus
         ON ACTION controlp INFIELD crabstus
            #add-point:ON ACTION controlp INFIELD crabstus
            
            #END add-point
 
         #----<<crab003>>----
         #Ctrlp:input.c.crab003
         ON ACTION controlp INFIELD crab003
            #add-point:ON ACTION controlp INFIELD crab003
            
            #END add-point
 
         #----<<crab004>>----
         #Ctrlp:input.c.crab004
         ON ACTION controlp INFIELD crab004
            #add-point:ON ACTION controlp INFIELD crab004
            
            #END add-point
 
         #----<<crab005>>----
         #Ctrlp:input.c.crab005
         ON ACTION controlp INFIELD crab005
            #add-point:ON ACTION controlp INFIELD crab005
            
            #END add-point
 
         #----<<crab006>>----
         #Ctrlp:input.c.crab006
         ON ACTION controlp INFIELD crab006
            #add-point:ON ACTION controlp INFIELD crab006
            
            #END add-point
 
         #----<<crab007>>----
         #Ctrlp:input.c.crab007
         ON ACTION controlp INFIELD crab007
            #add-point:ON ACTION controlp INFIELD crab007
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_crab_m.crab007             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_crab_m.crabunit

            
            CALL q_ooaj002_1()                                #呼叫開窗

            LET g_crab_m.crab007 = g_qryparam.return1              

            DISPLAY g_crab_m.crab007 TO crab007              #
            CALL acrm301_crab007_ref()
            NEXT FIELD crab007                          #返回原欄位


            #END add-point
 
         #----<<crab008>>----
         #Ctrlp:input.c.crab008
         ON ACTION controlp INFIELD crab008
            #add-point:ON ACTION controlp INFIELD crab008
            
            #END add-point
 
         #----<<crab009>>----
         #Ctrlp:input.c.crab009
         ON ACTION controlp INFIELD crab009
            #add-point:ON ACTION controlp INFIELD crab009
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_crab_m.crab009             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_crab_m.crabunit

            
            CALL q_ooaj002_1()                                #呼叫開窗

            LET g_crab_m.crab009 = g_qryparam.return1              

            DISPLAY g_crab_m.crab009 TO crab009              #
            CALL acrm301_crab009_ref()
            NEXT FIELD crab009                          #返回原欄位


            #END add-point
 
         #----<<crab010>>----
         #Ctrlp:input.c.crab010
         ON ACTION controlp INFIELD crab010
            #add-point:ON ACTION controlp INFIELD crab010
            
            #END add-point
 
         #----<<crab011>>----
         #Ctrlp:input.c.crab011
         ON ACTION controlp INFIELD crab011
            #add-point:ON ACTION controlp INFIELD crab011
            
            #END add-point
 
         #----<<crab012>>----
         #Ctrlp:input.c.crab012
         ON ACTION controlp INFIELD crab012
            #add-point:ON ACTION controlp INFIELD crab012
            
            #END add-point
 
         #----<<crabacti>>----
         #Ctrlp:input.c.crabacti
         ON ACTION controlp INFIELD crabacti
            #add-point:ON ACTION controlp INFIELD crabacti
            
            #END add-point
 
         #----<<crabownid>>----
         #----<<crabownid_desc>>----
         #----<<crabowndp>>----
         #----<<crabowndp_desc>>----
         #----<<crabcrtid>>----
         #----<<crabcrtid_desc>>----
         #----<<crabcrtdp>>----
         #----<<crabcrtdp_desc>>----
         #----<<crabcrtdt>>----
         #----<<crabmodid>>----
         #----<<crabmodid_desc>>----
         #----<<crabmoddt>>----
         #----<<crabcnfid>>----
         #----<<crabcnfid_desc>>----
         #----<<crabcnfdt>>----
 #欄位開窗
 
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
                
            CALL cl_showmsg()   #錯誤訊息統整顯示
 
            IF p_cmd <> "u" THEN
               LET l_count = 1  
 
               SELECT COUNT(*) INTO l_count FROM crab_t
                WHERE crabent = g_enterprise AND crab001 = g_crab_m.crab001
 
               IF l_count = 0 THEN
               
                  #add-point:單頭新增前
                  IF cl_null(g_crab_m.crab012) THEN
                     LET l_success = ''
                     CALL s_aooi350_ins_oofa('3',g_crab_m.crab001,'') RETURNING l_success,g_crab_m.crab012
                     IF NOT l_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "oofa_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        CONTINUE DIALOG
                     END IF
                  END IF
                  #end add-point
               
                  INSERT INTO crab_t (crabent,crabunit,crab001,crab002,crabstus,crab003,crab004,crab005, 
                      crab006,crab007,crab008,crab009,crab010,crab011,crab012,crabacti,crabownid,crabowndp, 
                      crabcrtid,crabcrtdp,crabcrtdt,crabmodid,crabmoddt,crabcnfid,crabcnfdt)
                  VALUES (g_enterprise,g_crab_m.crabunit,g_crab_m.crab001,g_crab_m.crab002,g_crab_m.crabstus, 
                      g_crab_m.crab003,g_crab_m.crab004,g_crab_m.crab005,g_crab_m.crab006,g_crab_m.crab007, 
                      g_crab_m.crab008,g_crab_m.crab009,g_crab_m.crab010,g_crab_m.crab011,g_crab_m.crab012, 
                      g_crab_m.crabacti,g_crab_m.crabownid,g_crab_m.crabowndp,g_crab_m.crabcrtid,g_crab_m.crabcrtdp, 
                      g_crab_m.crabcrtdt,g_crab_m.crabmodid,g_crab_m.crabmoddt,g_crab_m.crabcnfid,g_crab_m.crabcnfdt)  
 
                  
                  #add-point:單頭新增中
                  
                  #end add-point
                  
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "crab_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
  
                     CONTINUE DIALOG
                  END IF
                  
                  
                  
                  #資料多語言用-增/改
                           INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         IF g_crab_m.crab001 = g_master_multi_table_t.crabl001 AND
         g_crab_m.crabl004 = g_master_multi_table_t.crabl004 AND 
         g_crab_m.crabl003 = g_master_multi_table_t.crabl003 AND 
         g_crab_m.crabl005 = g_master_multi_table_t.crabl005  THEN
         ELSE 
            LET l_var_keys[01] = g_crab_m.crab001
            LET l_field_keys[01] = 'crabl001'
            LET l_var_keys_bak[01] = g_master_multi_table_t.crabl001
            LET l_var_keys[02] = g_dlang
            LET l_field_keys[02] = 'crabl002'
            LET l_var_keys_bak[02] = g_dlang
            LET l_vars[01] = g_crab_m.crabl004
            LET l_fields[01] = 'crabl004'
            LET l_vars[02] = g_crab_m.crabl003
            LET l_fields[02] = 'crabl003'
            LET l_vars[03] = g_crab_m.crabl005
            LET l_fields[03] = 'crabl005'
            LET l_vars[04] = g_enterprise 
            LET l_fields[04] = 'crablent'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'crabl_t')
         END IF 
 
                  
                  #add-point:單頭新增後
                  LET g_pmaa027_d = g_crab_m.crab012
                  CALL aooi350_01_b_fill(g_pmaa027_d)
                  #end add-point
                  
                  CALL s_transaction_end('Y','0')
               ELSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  "std-00006"
                  LET g_errparam.extend =  "g_crab_m.crab001"
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
 
                  CALL s_transaction_end('N','0')
               END IF 
            ELSE
               #add-point:單頭修改前
               
               #end add-point
               UPDATE crab_t SET (crabunit,crab001,crab002,crabstus,crab003,crab004,crab005,crab006, 
                   crab007,crab008,crab009,crab010,crab011,crab012,crabacti,crabownid,crabowndp,crabcrtid, 
                   crabcrtdp,crabcrtdt,crabmodid,crabmoddt,crabcnfid,crabcnfdt) = (g_crab_m.crabunit, 
                   g_crab_m.crab001,g_crab_m.crab002,g_crab_m.crabstus,g_crab_m.crab003,g_crab_m.crab004, 
                   g_crab_m.crab005,g_crab_m.crab006,g_crab_m.crab007,g_crab_m.crab008,g_crab_m.crab009, 
                   g_crab_m.crab010,g_crab_m.crab011,g_crab_m.crab012,g_crab_m.crabacti,g_crab_m.crabownid, 
                   g_crab_m.crabowndp,g_crab_m.crabcrtid,g_crab_m.crabcrtdp,g_crab_m.crabcrtdt,g_crab_m.crabmodid, 
                   g_crab_m.crabmoddt,g_crab_m.crabcnfid,g_crab_m.crabcnfdt)
                WHERE crabent = g_enterprise AND crab001 = g_crab001_t #
 
               #add-point:單頭修改中
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "crab_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "crab_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
  
                     CALL s_transaction_end('N','0')
                  OTHERWISE
                     
                     #資料多語言用-增/改
                              INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         IF g_crab_m.crab001 = g_master_multi_table_t.crabl001 AND
         g_crab_m.crabl004 = g_master_multi_table_t.crabl004 AND 
         g_crab_m.crabl003 = g_master_multi_table_t.crabl003 AND 
         g_crab_m.crabl005 = g_master_multi_table_t.crabl005  THEN
         ELSE 
            LET l_var_keys[01] = g_crab_m.crab001
            LET l_field_keys[01] = 'crabl001'
            LET l_var_keys_bak[01] = g_master_multi_table_t.crabl001
            LET l_var_keys[02] = g_dlang
            LET l_field_keys[02] = 'crabl002'
            LET l_var_keys_bak[02] = g_dlang
            LET l_vars[01] = g_crab_m.crabl004
            LET l_fields[01] = 'crabl004'
            LET l_vars[02] = g_crab_m.crabl003
            LET l_fields[02] = 'crabl003'
            LET l_vars[03] = g_crab_m.crabl005
            LET l_fields[03] = 'crabl005'
            LET l_vars[04] = g_enterprise 
            LET l_fields[04] = 'crablent'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'crabl_t')
         END IF 
 
                     #add-point:單頭修改後
                     LET g_pmaa027_d = g_crab_m.crab012
                     CALL aooi350_01_b_fill(g_pmaa027_d)
                     #end add-point
                     CALL s_transaction_end('Y','0')
               END CASE
            END IF
           #controlp
      END INPUT
          
      #add-point:input段more input 
      SUBDIALOG aoo_aooi350_01.aooi350_01_input
      
      #end add-point
          
      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name, g_fld_name, g_lang)
 
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
         ACCEPT DIALOG
        
      ON ACTION cancel      #在dialog button (放棄)
         LET g_action_choice=""
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION close       #在dialog 右上角 (X)
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         LET INT_FLAG = TRUE 
         EXIT DIALOG
   
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input 
   
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="acrm301.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION acrm301_reproduce()
   DEFINE l_newno     LIKE crab_t.crab001 
   DEFINE l_oldno     LIKE crab_t.crab001 
 
   DEFINE l_master    RECORD LIKE crab_t.*
   DEFINE l_cnt       LIKE type_t.num5
   #add-point:reproduce段define
   DEFINE l_success   LIKE type_t.num5
   #end add-point   
   
   #切換畫面
   
   IF g_crab_m.crab001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
 
      RETURN
   END IF
   
   LET g_crab001_t = g_crab_m.crab001
 
   
   LET g_crab_m.crab001 = ""
 
    
   CALL acrm301_set_entry("a")
   CALL acrm301_set_no_entry("a")
   
   #公用欄位給予預設值
   #此段落由子樣板a14產生    
      LET g_crab_m.crabownid = g_user
      LET g_crab_m.crabowndp = g_dept
      LET g_crab_m.crabcrtid = g_user
      LET g_crab_m.crabcrtdp = g_dept 
      LET g_crab_m.crabcrtdt = cl_get_current()
      LET g_crab_m.crabmodid = ""
      LET g_crab_m.crabmoddt = ""
      #LET g_crab_m.crabstus = ""
 
 
   
   #add-point:複製輸入前
   LET g_crab_m.crab012 = NULL
   LET g_crab_m.crabcnfid = ""
   LET g_crab_m.crabcnfdt = ""
   LET g_crab_m.crabstus = "N"
   LET g_crab_m.crabacti = "Y"
   #end add-point
   
   CALL acrm301_input("r")
 
   
   
   IF INT_FLAG  THEN
      LET INT_FLAG = 0
      RETURN
   END IF
   
   CALL s_transaction_begin()
   
   #add-point:單頭複製前
   IF cl_null(g_crab_m.crab012) THEN
      LET l_success = ''
      CALL s_aooi350_ins_oofa('3',g_crab_m.crab001,'') RETURNING l_success,g_crab_m.crab012
      IF NOT l_success THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "oofa_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN
      END IF
   END IF
   #end add-point
   
   #add-point:單頭複製中
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "crab_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
 
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:單頭複製後
   
   #end add-point
   
   CALL s_transaction_end('Y','0')
   
   LET g_state = "Y"
   
   LET g_wc = g_wc,  
              " OR (",
              " crab001 = '", g_crab_m.crab001 CLIPPED, "' "
 
              , ") "
   
   LET g_crab001_t = g_crab_m.crab001
 
   
   #add-point:完成複製段落後
   
   #end add-point
                   
END FUNCTION
 
{</section>}
 
{<section id="acrm301.show" >}
#+ 單頭資料重新顯示 
PRIVATE FUNCTION acrm301_show()
   #add-point:show段define
   
   #end add-point  
   
   #add-point:show段之前
   
   #end add-point
   
   
   
   LET g_crab_m_t.* = g_crab_m.*      #保存單頭舊值
   
   #在browser 移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()
   
   #帶出公用欄位reference值
   #此段落由子樣板a12產生
      #LET g_crab_m.crabownid_desc = cl_get_username(g_crab_m.crabownid)
      #LET g_crab_m.crabowndp_desc = cl_get_deptname(g_crab_m.crabowndp)
      #LET g_crab_m.crabcrtid_desc = cl_get_username(g_crab_m.crabcrtid)
      #LET g_crab_m.crabcrtdp_desc = cl_get_deptname(g_crab_m.crabcrtdp)
      #LET g_crab_m.crabmodid_desc = cl_get_username(g_crab_m.crabmodid)
      #LET g_crab_m.crabcnfid_desc = cl_get_deptname(g_crab_m.crabcnfid)
      ##LET g_crab_m.crabpstid_desc = cl_get_deptname(g_crab_m.crabpstid)
      
 
 
    
   #顯示followup圖示
   #+ 此段落由子樣板a48產生
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_crab_m.crab001
   LET g_pk_array[1].column = 'crab001'
 
   #add-point:ON ACTION agendum
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
 
 
   
   #讀入ref值(單頭)
   #add-point:show段reference

   CALL acrm301_crab001_ref()
   CALL acrm301_crabunit_ref()
   CALL acrm301_crab007_ref()
   CALL acrm301_crab009_ref()

   #end add-point
 
   #將資料輸出到畫面上
   DISPLAY BY NAME g_crab_m.crabunit,g_crab_m.crabunit_desc,g_crab_m.crab001,g_crab_m.crabl004,g_crab_m.crabl003, 
       g_crab_m.crab002,g_crab_m.crabl005,g_crab_m.crabstus,g_crab_m.crab003,g_crab_m.crab004,g_crab_m.crab005, 
       g_crab_m.crab006,g_crab_m.crab007,g_crab_m.crab008,g_crab_m.crab009,g_crab_m.crab010,g_crab_m.crab011, 
       g_crab_m.crab012,g_crab_m.crabacti,g_crab_m.crabownid,g_crab_m.crabownid_desc,g_crab_m.crabowndp, 
       g_crab_m.crabowndp_desc,g_crab_m.crabcrtid,g_crab_m.crabcrtid_desc,g_crab_m.crabcrtdp,g_crab_m.crabcrtdp_desc, 
       g_crab_m.crabcrtdt,g_crab_m.crabmodid,g_crab_m.crabmodid_desc,g_crab_m.crabmoddt,g_crab_m.crabcnfid, 
       g_crab_m.crabcnfid_desc,g_crab_m.crabcnfdt
   
   #顯示狀態(stus)圖片
         #此段落由子樣板a21產生
      CASE g_crab_m.crabstus
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
         
      END CASE
 
 
 
   #add-point:show段之後
   LET g_pmaa027_d = g_crab_m.crab012
   CALL aooi350_01_b_fill(g_pmaa027_d)
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="acrm301.delete" >}
#+ 資料刪除 
PRIVATE FUNCTION acrm301_delete()
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define

   #end add-point  
   
   IF g_crab_m.crab001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
 
      RETURN
   END IF
 
   CALL acrm301_show()
   
   CALL s_transaction_begin()
    
   LET g_crab001_t = g_crab_m.crab001
 
   
   LET g_master_multi_table_t.crabl001 = g_crab_m.crab001
LET g_master_multi_table_t.crabl004 = g_crab_m.crabl004
LET g_master_multi_table_t.crabl003 = g_crab_m.crabl003
LET g_master_multi_table_t.crabl005 = g_crab_m.crabl005
 
 
   OPEN acrm301_cl USING g_enterprise,
                           g_crab_m.crab001
 
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN acrm301_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
 
      CLOSE acrm301_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   FETCH acrm301_cl INTO g_crab_m.crabunit,g_crab_m.crabunit_desc,g_crab_m.crab001,g_crab_m.crabl004, 
       g_crab_m.crabl003,g_crab_m.crab002,g_crab_m.crabl005,g_crab_m.crabstus,g_crab_m.crab003,g_crab_m.crab004, 
       g_crab_m.crab005,g_crab_m.crab006,g_crab_m.crab007,g_crab_m.crab007_desc,g_crab_m.crab008,g_crab_m.crab009,g_crab_m.crab009_desc,g_crab_m.crab010, 
       g_crab_m.crab011,g_crab_m.crab012,g_crab_m.crabacti,g_crab_m.crabownid,g_crab_m.crabownid_desc, 
       g_crab_m.crabowndp,g_crab_m.crabowndp_desc,g_crab_m.crabcrtid,g_crab_m.crabcrtid_desc,g_crab_m.crabcrtdp, 
       g_crab_m.crabcrtdp_desc,g_crab_m.crabcrtdt,g_crab_m.crabmodid,g_crab_m.crabmodid_desc,g_crab_m.crabmoddt, 
       g_crab_m.crabcnfid,g_crab_m.crabcnfid_desc,g_crab_m.crabcnfdt
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_crab_m.crab001
      LET g_errparam.popup = FALSE
      CALL cl_err()
 
      RETURN
   END IF
   
   #160818-00017#5 -s by 08172
   #檢查是否允許此動作
   IF NOT acrm301_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   #160818-00017#5 -e by 08172
   
   IF cl_ask_delete() THEN
 
      #add-point:單頭刪除前

      #end add-point
 
      #+ 此段落由子樣板a47產生
      #刪除相關文件
      CALL g_pk_array.clear()
      LET g_pk_array[1].values = g_crab_m.crab001
      LET g_pk_array[1].column = 'crab001'
 
      #add-point:相關文件刪除前

      #end add-point   
      CALL cl_doc_remove()  
 
 
 
      DELETE FROM crab_t 
       WHERE crabent = g_enterprise AND crab001 = g_crab_m.crab001 
 
 
      #add-point:單頭刪除中

      #end add-point
         
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "crab_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
      END IF
  
      INITIALIZE l_var_keys_bak TO NULL 
   INITIALIZE l_field_keys   TO NULL 
   LET l_var_keys_bak[01] = g_master_multi_table_t.crabl001
   LET l_field_keys[01] = 'crabl001'
   LET l_var_keys_bak[02] = g_dlang
   LET l_field_keys[02] = 'crabl002'
   CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'crabl_t')
 
      
      #add-point:單頭刪除後
      IF NOT cl_null(g_crab_m.crab012) THEN
         IF NOT s_aooi350_del(g_crab_m.crab012) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "oofa_t"
            LET g_errparam.popup = FALSE
            CALL cl_err()

            CALL s_transaction_end('N','0')
            RETURN
         END IF
      END IF
      #end add-point
      
          
      
      CLEAR FORM
      CALL acrm301_ui_browser_refresh()
      IF g_browser_cnt > 0 THEN
         CALL acrm301_fetch("P")
      ELSE
         CALL acrm301_browser_fill(" 1=1 ","F")
      END IF
      
   END IF
 
   CLOSE acrm301_cl
   CALL s_transaction_end('Y','0')
 
   #流程通知預埋點-D
   CALL cl_flow_notify(g_crab_m.crab001,"D")
 
END FUNCTION
 
{</section>}
 
{<section id="acrm301.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION acrm301_ui_browser_refresh()
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define
   
   #end add-point     
 
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_crab001 = g_crab_m.crab001 THEN  
         CALL g_browser.deleteElement(l_i)
         LET g_header_cnt = g_header_cnt - 1
       END IF
   END FOR
   
   DISPLAY g_header_cnt TO FORMONLY.b_count     #page count
   DISPLAY g_header_cnt TO FORMONLY.h_count     #page count
   LET g_browser_cnt = g_browser_cnt-1
   IF g_current_idx > g_browser_cnt THEN        #確定browse 筆數指在同一筆
      LET g_current_idx = g_browser_cnt
   END IF
  
END FUNCTION
 
{</section>}
 
{<section id="acrm301.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION acrm301_set_entry(p_cmd)
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_entry段define
   
   #end add-point     
 
   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("crab001",TRUE)
      #add-point:set_entry段欄位控制
      
      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後
   CALL cl_set_comp_entry("crabunit",TRUE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="acrm301.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION acrm301_set_no_entry(p_cmd)
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_no_entry段define
   
   #end add-point     
 
   IF p_cmd = "u" THEN
      CALL cl_set_comp_entry("crab001",FALSE)
      #add-point:set_no_entry段欄位控制
      
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後
   IF NOT s_aooi500_comp_entry(g_prog,'crabunit') THEN
      CALL cl_set_comp_entry("crabunit",FALSE)
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="acrm301.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION acrm301_default_search()
   DEFINE li_idx  LIKE type_t.num5
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE ls_wc   STRING
   #add-point:default_search段define
   
   #end add-point  
   
   #add-point:default_search段開始前
   
   #end add-point  
   
   LET g_pagestart = 1
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   IF NOT cl_null(g_argv[1]) THEN
      LET ls_wc = ls_wc, " crab001 = '", g_argv[1], "' AND "
   END IF
   
 
   
   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
      LET g_default = FALSE
      #預設查詢條件
      LET g_wc = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=1"
      END IF
   END IF
   
   #add-point:default_search段結束前
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="acrm301.state_change" >}
   #+ 此段落由子樣板a09產生
#+ 確認碼變更
PRIVATE FUNCTION acrm301_statechange()
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define
   DEFINE l_success LIKE type_t.num5  
   #end add-point  
   
   #add-point:statechange段開始前
#   IF g_crab_m.crabstus = "X" THEN
#      RETURN
#   END IF
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_crab_m.crab001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
 
      RETURN
   END IF
   #160818-00017#5 -s by 08172
   #檢查是否允許此動作
   IF NOT acrm301_action_chk() THEN
      CLOSE acrm301_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   #160818-00017#5 -e by 08172
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_crab_m.crabstus
            WHEN "N"
               HIDE OPTION "open"
            WHEN "X"
               HIDE OPTION "void"
            WHEN "Y"
               HIDE OPTION "valid"
            
         END CASE
     
      #add-point:menu前
#         CASE g_crab_m.crabstus
#            WHEN "Y"
#               HIDE OPTION "void"
#               HIDE OPTION "invalid"
#         END CASE  
      CALL cl_set_act_visible("open,void,valid",TRUE)
      CASE g_crab_m.crabstus
         WHEN "N"
            CALL cl_set_act_visible("open",FALSE)

         WHEN "X"
            CALL cl_set_act_visible("void,valid",FALSE)

         WHEN "Y"
            CALL cl_set_act_visible("void,valid",FALSE)

      END CASE
      #end add-point
      
      ON ACTION open
         LET lc_state = "N"
         #add-point:action控制

         #end add-point
         EXIT MENU
      ON ACTION void
         LET lc_state = "X"
         #add-point:action控制

         #end add-point
         EXIT MENU
      ON ACTION valid
         LET lc_state = "Y"
         #add-point:action控制

         #end add-point
         EXIT MENU
      
      
      
      #add-point:stus控制

      #end add-point
      
   END MENU
   
   IF (lc_state <> "N" 
      AND lc_state <> "X"
      AND lc_state <> "Y"
      ) OR 
      cl_null(lc_state) THEN
      RETURN
   END IF
   
   #add-point:stus修改前
   LET l_success = TRUE          
   CASE 
      WHEN lc_state = 'Y' AND g_crab_m.crabstus = 'N'  
         CALL s_acrm301_conf_chk(g_crab_m.crab001,g_crab_m.crabstus) RETURNING l_success,g_errno
         IF l_success THEN
            IF cl_ask_confirm('aim-00108') THEN
               CALL s_transaction_begin()
               CALL s_acrm301_conf_upd(g_crab_m.crab001) RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_crab_m.crab001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                 
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               RETURN            
            END IF
         ELSE
            IF NOT cl_null(g_errno) THEN
               INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_crab_m.crab001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

            END IF
            RETURN            
         END IF         
      WHEN lc_state = 'X' AND g_crab_m.crabstus = 'N'  
         CALL s_acrm301_void_chk(g_crab_m.crab001,g_crab_m.crabstus) RETURNING l_success,g_errno
         IF l_success THEN
            IF cl_ask_confirm('art-00039') THEN
               CALL s_transaction_begin()
               CALL s_acrm301_void_upd(g_crab_m.crab001) RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_crab_m.crab001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

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
                  LET g_errparam.extend = g_crab_m.crab001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

            RETURN    
         END IF
      WHEN lc_state = 'N' AND g_crab_m.crabstus = 'Y'  
         CALL s_acrm301_unconf_chk(g_crab_m.crab001,g_crab_m.crabstus) RETURNING l_success,g_errno
         IF l_success THEN
            IF cl_ask_confirm('aim-00110') THEN
               CALL s_transaction_begin()
               CALL s_acrm301_unconf_upd(g_crab_m.crab001) RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_crab_m.crab001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

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
                  LET g_errparam.extend = g_crab_m.crab001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

            RETURN    
         END IF
     
      #dongsz--add--str---     
      WHEN lc_state = 'N' AND g_crab_m.crabstus = 'X'  
         CALL s_acrm301_valid_chk(g_crab_m.crab001,g_crab_m.crabstus) RETURNING l_success,g_errno
         IF l_success THEN
            IF cl_ask_confirm('art-00038') THEN
               CALL s_transaction_begin()
               CALL s_acrm301_valid_upd(g_crab_m.crab001) RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_crab_m.crab001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

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
                  LET g_errparam.extend = g_crab_m.crab001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

            RETURN    
         END IF
      #dongsz--add--end---

      OTHERWISE
         RETURN
   END CASE   
   #end add-point
      
   UPDATE crab_t SET crabstus = lc_state 
    WHERE crabent = g_enterprise AND crab001 = g_crab_m.crab001
 
  
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
 
   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
         
      END CASE
      LET g_crab_m.crabstus = lc_state
      DISPLAY BY NAME g_crab_m.crabstus
   END IF
 
   #add-point:stus修改後

   #end add-point
 
   #add-point:statechange段結束前

   #end add-point  
 
END FUNCTION
 
 
 
{</section>}
 
{<section id="acrm301.set_pk_array" >}
 
 
{</section>}
 
{<section id="acrm301.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="acrm301.other_function" readonly="Y" >}

PRIVATE FUNCTION acrm301_crab001_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_crab_m.crab001
   CALL ap_ref_array2(g_ref_fields," SELECT crabl004,crabl003,crabl005 FROM crabl_t WHERE crablent = '"||g_enterprise||"' AND crabl001 = ? AND crabl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_crab_m.crabl004 = g_rtn_fields[1] 
   LET g_crab_m.crabl003 = g_rtn_fields[2] 
   LET g_crab_m.crabl005 = g_rtn_fields[3] 
   DISPLAY g_crab_m.crabl004,g_crab_m.crabl003,g_crab_m.crabl005 TO crabl004,crabl003,crabl005
END FUNCTION

PRIVATE FUNCTION acrm301_crabunit_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_crab_m.crabunit
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_crab_m.crabunit_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_crab_m.crabunit_desc
END FUNCTION

PRIVATE FUNCTION acrm301_crab007_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_crab_m.crab007
   CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_crab_m.crab007_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_crab_m.crab007_desc
END FUNCTION

PRIVATE FUNCTION acrm301_crab009_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_crab_m.crab009
   CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_crab_m.crab009_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_crab_m.crab009_desc
END FUNCTION

################################################################################
# Descriptions...: 修改，删除时重新检查状态
# Date & Author..: #160818-00017#5 2016/08/22 By 08172
# Modify.........:
################################################################################
PRIVATE FUNCTION acrm301_action_chk()
   SELECT crabstus  INTO g_crab_m.crabstus
     FROM crab_t
    WHERE crabent = g_enterprise
      AND crab001 = g_crab_m.crab001
   LET g_errno = NULL
   IF (g_action_choice="modify" OR g_action_choice="modify_detail" OR g_action_choice="delete")  THEN
     CASE g_crab_m.crabstus
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
        LET g_errparam.extend = g_crab_m.crab001
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL acrm301_show()
        RETURN FALSE
     END IF
   END IF
  
      
   RETURN TRUE
END FUNCTION

 
{</section>}
 
