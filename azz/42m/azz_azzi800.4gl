#該程式已解開Section, 不再透過樣板產出!
{<section id="azzi800.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0046(2016-09-20 15:40:05), PR版次:0046(2017-03-08 18:24:49)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000853
#+ Filename...: azzi800
#+ Description: 使用者資料設定作業
#+ Creator....: 01856(2013-10-28 09:24:00)
#+ Modifier...: 01856 -SD/PR- 01856
 
{</section>}
 
{<section id="azzi800.global" >}
#應用 i00 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160314-00004#1  2016/03/14 By jrg542   azzi800 add_fileter bug 修正
#160318-00025#35 2016/04/15 By 07959    azzi800 將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160526-00010#1  2016/05/26 By jrg542   azzi800 的複製功能，複製時gzxh_t(使用者定義執行作業功能明細) 漏掉
#160429-00013#7  2016/07/18 By Jessica  若啟用BPM組織同步，azzi800維護後應同步更新ooap_t(BPM主帳號資料)
#160802-00042#1  2016/08/02 By jrg542   3.當 azzi800 配置可拜訪據點允許下展時 ，登入畫面的營運據點沒有可挑選到下展後的所有據點
#160815-00018#1  2016/08/15 By dorislai 修正azzi800的頁籤-角色據點設定，刪除資料時，不會更新最近修改者、最近修改日期的問題
#160919-00061#1  2016/09/21 By jrg542   預設營運據點編號 設定為 必要欄位 一併處理#160908-00046 #1 
#161107-00022#1  2016/11/07 By jrg542   修正修改員工編號，會跳出預設登入據點不存在據點列表內
#161107-00022#1  2016/11/17 By jrg542   帳號全大寫/全小寫的參數功能 管控
#161130-00040#1  2016/12/1  By Gucci Gu 增加OS層帳號控卡功能
#161206-00028#1  2016/12/6  By Gucci Gu 確認帳號建立成功再進入OS層控卡功能
#161005-00006#1  2016/12/9  By jrg542   新增帳號時，偵測到此使用者已存在其他編號，角色據點與權限部門可免設定直接存檔
#161214-00012#4  2016/12/19 By jrg542   驗證gzxa005 只能有一筆
#161220-00012#1  2016/12/20 By hjwang   判斷參數確定是否額外複寫gzxd
#161225-00003#3  2016/12/26 By jrg542   azzi800點選資料權限的設定時，必須回去原始程式查看是否存在 g_data_owner，沒有就不給設定 (只能為 0.不管制)
#161228-00003#1  2016/12/28 By hjwang   gzxs參數抓取相反
#170308-00055#1  2017/03/08 By jrg542   修正 gzxa005 檢核有誤
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"
IMPORT FGL azz_azzi800_01
IMPORT FGL azz_azzi800_02
IMPORT util
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
{<Module define>}

#單頭 type 宣告
 TYPE type_g_gzxa_m RECORD
       gzxa001 LIKE gzxa_t.gzxa001,
   gzxa002 LIKE gzxa_t.gzxa002,
   gzxa003 LIKE gzxa_t.gzxa003,
   gzxa003_desc LIKE type_t.chr80,
   gzxastus LIKE gzxa_t.gzxastus,
   gzxa010 LIKE gzxa_t.gzxa010,
   gzxa007 LIKE gzxa_t.gzxa007,
   gzxa007_desc LIKE type_t.chr80, 
   gzxa011 LIKE gzxa_t.gzxa011,
   gzxa011_desc LIKE type_t.chr80,
   #gzxa012 LIKE gzxa_t.gzxa012,
   gzxa013 LIKE gzxa_t.gzxa013, #15/04/22 拿掉 gzxa013 #15/05/11再拿回來...(連同azzi800_01, azzi800_02也要一起改......)
   gzxa013_desc LIKE type_t.chr80, 
   #gzxa004 LIKE gzxa_t.gzxa004,
   gzxa005 LIKE gzxa_t.gzxa005,
   #gzxa006 LIKE gzxa_t.gzxa006,
   gzxa008 LIKE gzxa_t.gzxa008,
   gzxa009 LIKE gzxa_t.gzxa009,
   gzxa016 LIKE gzxa_t.gzxa016,
   gzxa017 LIKE gzxa_t.gzxa017,
   gzxz002 LIKE gzxz_t.gzxz002,
   gzxz003 LIKE gzxz_t.gzxz003,
   gzxd004 LIKE gzxd_t.gzxd004,
   gzxz005 LIKE gzxz_t.gzxz005,
   gzxz006 LIKE gzxz_t.gzxz006,
   gzxz007 LIKE gzxz_t.gzxz007, 
   gzxz008 LIKE gzxz_t.gzxz008, 
   gzxz009 LIKE gzxz_t.gzxz009, 
   gzxz010 LIKE gzxz_t.gzxz010, 
   gzxaownid LIKE gzxa_t.gzxaownid,
   gzxaownid_desc LIKE type_t.chr80,
   gzxaowndp LIKE gzxa_t.gzxaowndp,
   gzxaowndp_desc LIKE type_t.chr80,
   gzxacrtid LIKE gzxa_t.gzxacrtid,
   gzxacrtid_desc LIKE type_t.chr80,
   gzxacrtdp LIKE gzxa_t.gzxacrtdp,
   gzxacrtdp_desc LIKE type_t.chr80,
   gzxacrtdt DATETIME YEAR TO SECOND,
   gzxamodid LIKE gzxa_t.gzxamodid,
   gzxamodid_desc LIKE type_t.chr80,
   gzxamoddt DATETIME YEAR TO SECOND
       END RECORD

#模組變數(Module Variables)
#DEFINE g_gzxa_m        type_g_gzxa_m
DEFINE g_gzxa_m_t      type_g_gzxa_m                #備份舊值
DEFINE g_gzxa_m_o      type_g_gzxa_m                #備份舊值
DEFINE g_gzxa001_t   LIKE gzxa_t.gzxa001    #Key值備份


DEFINE g_browser    DYNAMIC ARRAY OF RECORD                   #資料瀏覽之欄位
         b_statepic     LIKE type_t.chr50,
            b_gzxa001 LIKE gzxa_t.gzxa001,
      b_gzxa002 LIKE gzxa_t.gzxa002,
      b_gzxa003 LIKE gzxa_t.gzxa003,
      b_gzxa003_desc LIKE type_t.chr80,
      b_gzxa007 LIKE gzxa_t.gzxa007,
      b_gzxa007_desc LIKE type_t.chr80,
      b_gzxa010 LIKE gzxa_t.gzxa010
         #,rank           LIKE type_t.num10
      END RECORD

#無單頭append欄位定義

DEFINE g_wc                  STRING                        #儲存 user 的查詢條件
DEFINE g_wc_t                STRING                        #儲存 user 的查詢條件
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING

DEFINE g_sql                 STRING                        #組 sql 用
DEFINE g_forupd_sql          STRING                        #SELECT ... FOR UPDATE  SQL
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_jump                LIKE type_t.num10             #查詢指定的筆數
DEFINE g_no_ask              LIKE type_t.num5              #是否開啟指定筆視窗
DEFINE g_rec_b               LIKE type_t.num5              #單身筆數
DEFINE l_ac                  LIKE type_t.num5              #目前處理的ARRAY CNT
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_pagestart           LIKE type_t.num5              #page起始筆數
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

#快速搜尋用
DEFINE g_searchcol           STRING             #查詢欄位代碼
DEFINE g_searchstr           STRING             #查詢欄位字串
DEFINE g_order               STRING             #查詢排序模式

#Browser用
DEFINE g_current_idx         LIKE type_t.num5   #Browser 所在筆數(當下page)
DEFINE g_current_row         LIKE type_t.num5   #Browser 所在筆數(暫存用)
DEFINE g_current_cnt         LIKE type_t.num10  #Browser 總筆數(當下page)
DEFINE g_browser_idx         LIKE type_t.num5   #Browser 所在筆數(所有資料)
DEFINE g_browser_cnt         LIKE type_t.num5   #Browser 總筆數(所有資料)
DEFINE g_tmp_page            LIKE type_t.num5
DEFINE g_row_index           LIKE type_t.num5
DEFINE g_log1                STRING                        #log用
DEFINE g_log2                STRING                        #log用

GLOBALS
   DEFINE g_gzxa_m        type_g_gzxa_m
   DEFINE g_detail_cmd      STRING             # 進入單身的功能狀態
   DEFINE g_detail_insert   LIKE type_t.num5   # 單身的新增權限
   DEFINE g_detail_delete   LIKE type_t.num5   # 單身的刪除權限
   DEFINE g_wc2_01          STRING             # 單身一QBE條件
   DEFINE g_wc2_02          STRING             # 單身二QBE條件
   DEFINE g_wc3_01          STRING             # 單身三QBE條件
   DEFINE g_detail_idx_01   LIKE type_t.num5   # 單身一 所在筆數(所有資料)
   DEFINE g_detail_cnt_01   LIKE type_t.num5   # 單身一 總筆數(所有資料)
   DEFINE g_detail_idx_02   LIKE type_t.num5   # 單身二 所在筆數(所有資料)
   DEFINE g_detail_cnt_02   LIKE type_t.num5   # 單身二 總筆數(所有資料)
   DEFINE g_gzxa003_d       LIKE gzxa_t.gzxa003 # 新增功能傳遞到子程式Key值
   DEFINE g_appoint_idx     LIKE type_t.num5   # 指定進入單身行數
   DEFINE g_appoint_detail  STRING             # 指定進入的單身區塊
   DEFINE l_ac_01           LIKE type_t.num5        #目前處理的ARRAY CNT
   DEFINE l_ac_03           LIKE type_t.num5        #目前處理的ARRAY CNT
   DEFINE g_update          BOOLEAN                       #確定單頭/身是否異動過
   
    TYPE type_g_gzxb_d RECORD
   gzxbstus LIKE gzxb_t.gzxbstus,
   gzxb001 LIKE gzxb_t.gzxb001,
   gzxb002 LIKE gzxb_t.gzxb002,
   gzxb003 LIKE gzxb_t.gzxb003,
   gzxb003_desc LIKE type_t.chr80,
   gzxb004 LIKE gzxb_t.gzxb004,
   gzxb005 LIKE gzxb_t.gzxb005,
   gzxh004 LIKE type_t.chr500,
   gzxb006 LIKE gzxb_t.gzxb006,
   gzxb007 LIKE gzxb_t.gzxb007,
   gzxb008 LIKE gzxb_t.gzxb008
       END RECORD
   
   TYPE type_g_gzxc_d RECORD
   gzxcstus LIKE gzxc_t.gzxcstus,
   gzxc001 LIKE gzxc_t.gzxc001,
   gzxc002 LIKE gzxc_t.gzxc002,
   gzxc003 LIKE gzxc_t.gzxc003,
   gzxc004 LIKE gzxc_t.gzxc004,
   gzxc004_desc LIKE type_t.chr80,
   gzxc005 LIKE gzxc_t.gzxc005,
   gzxc006 LIKE gzxc_t.gzxc006,
   gzxc007 LIKE gzxc_t.gzxc007
       END RECORD
   
   TYPE type_g_gzxe_d RECORD
       gzxestus LIKE gzxe_t.gzxestus,
   gzxe001 LIKE gzxe_t.gzxe001,
   gzxe002 LIKE gzxe_t.gzxe002,
   gzxe002_desc LIKE type_t.chr80,
   gzxe003 LIKE gzxe_t.gzxe003,
   gzxe004 LIKE gzxe_t.gzxe004,
   gzxe005 LIKE gzxe_t.gzxe005
       END RECORD
   
   DEFINE g_gzxb_d          DYNAMIC ARRAY OF type_g_gzxb_d
   DEFINE g_gzxc_d          DYNAMIC ARRAY OF type_g_gzxc_d
   DEFINE g_gzxe_d          DYNAMIC ARRAY OF type_g_gzxe_d
END GLOBALS




{</Module define>}
#end add-point
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_detail_id       STRING             # 目前停留在哪一個單身畫面 
#161107-00022 start
DEFINE gi_gzxa003_flag   LIKE type_t.num5   #確認單獨異動 gzxa003
DEFINE g_wc_gzxa003      STRING
#161107-00022 end
#DEFINE gi_sub_dialog LIKE type_t.num5
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
{</section>}
 
{<section id="azzi800.main" >}
#+ 作業開始
MAIN
   #add-point:main段define

   #end add-point    
 
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log
 
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("azz","")
 
   #add-point:作業初始化

   #end add-point
 
   #add-point:SQL_define
   #gzxa012 拿掉
   #LET g_forupd_sql = "SELECT gzxa001,gzxa002,gzxa003,'',gzxastus,gzxa010,gzxa007,gzxa011,gzxa012,gzxa013,gzxa004,gzxa005,gzxa006,gzxa008,gzxa009,'','','','','','',gzxaownid,'',gzxaowndp,'',gzxacrtid,'',gzxacrtdp,'',gzxacrtdt,gzxamodid,'',gzxamoddt FROM gzxa_t WHERE gzxaent= ? AND gzxa001=? FOR UPDATE"
   #15/04/22 gzxa013 拿掉  #15/05/11再拿回來...
   LET g_forupd_sql = "SELECT gzxa001,gzxa002,gzxa003,'',gzxastus,gzxa010,gzxa007,gzxa011,gzxa013,gzxa005,gzxa008,gzxa009,'','','','','','',gzxaownid,'',gzxaowndp,'',gzxacrtid,'',gzxacrtdp,'',gzxacrtdt,gzxamodid,'',gzxamoddt FROM gzxa_t WHERE gzxaent= ? AND gzxa001=? FOR UPDATE"

   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE azzi800_cl CURSOR FROM g_forupd_sql 
  #15/04/22 拿掉gzza013
  #15/06/09 拿掉gzxa004
  #15/06/13 拿掉gzxa013
   LET g_sql = " SELECT DISTINCT gzxa001,gzxa002,gzxa003,gzxastus,gzxa010,gzxa007,t7.ooefl003,gzxa011,gzwel003,gzxa013,t9.gzbal003,",
              " gzxa005,gzxa008,gzxa009,gzxa016,gzxa017,gzxaownid,gzxaowndp,gzxacrtid,gzxacrtdp,gzxacrtdt,gzxamodid,gzxamoddt,", 
               " t1.ooag011 ,t2.ooag011 ,t3.ooefl003 ,t4.ooag011 ,t5.ooefl003 ,t6.ooag011",
               " FROM gzxa_t",
               " LEFT JOIN ooag_t t1 ON gzxaent = ooagent AND gzxa003 = ooag001  ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent='"||g_enterprise||"' AND  t2.ooag001 = gzxaownid  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent='"||g_enterprise||"' AND t3.ooefl001 = gzxaowndp AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent='"||g_enterprise||"' AND t4.ooag001 = gzxacrtid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent='"||g_enterprise||"' AND t5.ooefl001 = gzxacrtdp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent='"||g_enterprise||"' AND t6.ooag001 = gzxamodid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent='"||g_enterprise||"' AND t7.ooefl001 = gzxa007 AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN gzwel_t t8 ON t8.gzwelent='"||g_enterprise||"' AND t8.gzwel001 = gzxa011 AND t8.gzwel002='"||g_dlang||"' ",
               " LEFT JOIN gzbal_t t9 ON t9.gzbalent='"||g_enterprise||"' AND t9.gzbal001 = gzxa013 AND t9.gzbal002='"||g_dlang||"' ",
               " WHERE gzxaent = ? AND gzxa001 = ? "
 
             
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料
   PREPARE azzi800_master_referesh FROM g_sql 
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call

      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_azzi800 WITH FORM cl_ap_formpath("azz",g_code)
   
      #程式初始化
      CALL azzi800_init()
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #進入選單 Menu (='N')
      CALL azzi800_ui_dialog()
   
      #畫面關閉
      CLOSE WINDOW w_azzi800
   END IF
 
   #add-point:作業離開前

   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
 
END MAIN
 
{</section>}
 
{<section id="azzi800.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION azzi800_init()
   #add-point:init段define
   {<point name="init.define"/>}

   #end add-point

   #該樣板不需此段落LET g_main_hidden = 0
   CALL cl_set_combo_scc_part('gzxastus','17','Y,N')
   CALL cl_set_combo_lang("gzxa010") 
   #CALL cl_set_combo_scc('gzxa002','1') 2.員工與4.交易對象聯絡人
   CALL cl_set_combo_scc_part('gzxa002','1','2,4')
   CALL cl_set_combo_scc_part('b_gzxa002','1','2,4')
   #CALL cl_set_combo_scc('b_gzxa002','1')
   CALL cl_set_combo_lang("b_gzxa010")
   CALL cl_set_combo_scc("gzxa008", "132")
   CALL cl_set_combo_scc("gzxa009", "108")
   
   LET g_error_show = 1

   #add-point:畫面資料初始化
   {<point name="init.init" />}
     #取得主程式視窗節點
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()

   #子程式畫面取代主程式元件
   CALL azzi800_replace_sub_window(cl_ap_formpath("azz", "azzi800_01"), "grid_contact", "s_detail1_01")
   CALL azzi800_replace_sub_window(cl_ap_formpath("azz", "azzi800_01"), "grid_contact_2", "s_detail1_03")
   CALL azzi800_replace_sub_window(cl_ap_formpath("azz", "azzi800_02"), "grid_communication", "s_detail1_02")
   CALL cl_set_combo_scc('gzxb002','86')
   #end add-point

   CALL azzi800_default_search()

END FUNCTION

PRIVATE FUNCTION azzi800_ui_dialog()
   {<Local define>}
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_wc    LIKE type_t.chr200
   DEFINE li_idx   LIKE type_t.num5
   DEFINE ls_cmd   STRING              #串接程式執行指令
   DEFINE la_param  RECORD
             prog   STRING,  #要執行的程式
             actionid STRING,
             param  DYNAMIC ARRAY OF STRING  #額外傳的參數
                    END RECORD
   DEFINE  ls_js  STRING
   {</Local define>}
   #add-point:ui_dialog段define
   {<point name="ui_dialog.define"/>}
   #end add-point

   LET li_exit = FALSE
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()
   LET g_current_row = 0
   LET g_current_idx = 1

   CALL gfrm_curr.setElementImage("logo","logo/applogo.png")
   CALL gfrm_curr.setElementHidden("mainlayout",1)
   CALL gfrm_curr.setElementHidden("worksheet",0)
   LET g_main_hidden = 1
   #LET gi_sub_dialog = FALSE

   #add-point:ui_dialog段before dialog
   {<point name="ui_dialog.before_dialog"/>}
   #end add-point

   WHILE li_exit = FALSE
      #CALL azzi800_browser_fill(g_wc,"")
      CALL azzi800_browser_fill("")
      
      CALL lib_cl_dlg.cl_dlg_before_display()
      CALL cl_notice()

      #判斷前一個動作是否為新增, 若是的話切換到新增的筆數
      IF g_state = "Y" THEN
         FOR li_idx = 1 TO g_browser.getLength()
            IF g_browser[li_idx].b_gzxa001 = g_gzxa001_t

               THEN
               LET g_current_row = li_idx
               LET g_current_idx = li_idx
               EXIT FOR
            END IF
         END FOR
         LET g_state = ""
      END IF

      #該樣板不需此段落IF g_main_hidden = 2 THEN
      IF g_main_hidden = 0 THEN
      
#T100  13/11/04  start
# 加入 DIALOG 
         DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
            
            
            DISPLAY ARRAY g_browser TO s_browse.* ATTRIBUTE(COUNT=g_rec_b)
               BEFORE ROW
                 
                  #回歸舊筆數位置 (回到當時異動的筆數)
                  LET g_current_idx = DIALOG.getCurrentRow("s_browse")
                  IF g_current_idx = 0 THEN
                     LET g_current_idx = 1
                  END IF
                  LET g_current_row = g_current_idx  #目前指標
                  LET g_current_sw = TRUE
                  CALL cl_show_fld_cont()     

                  #當每次點任一筆資料都會需要用到   
                                    
                  CALL azzi800_fetch("")      
                  
               ON COLLAPSE (g_row_index)
                  #樹關閉

            END DISPLAY

            SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
            SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
         
            #add-point:ui_dialog段define
            {<point name="ui_dialog.more_displayarray"/>}
            
            #end add-point
            SUBDIALOG azz_azzi800_01.azzi800_01_display
            SUBDIALOG azz_azzi800_01.azzi800_01_1_display
            SUBDIALOG azz_azzi800_02.azzi800_02_display
            
            ON ACTION cont_page
               LET g_detail_id = "cont_page"
               NEXT FIELD gzxbstus
            ON ACTION comm_page  
               LET g_detail_id = "comm_page"
               NEXT FIELD gzxestus
         
            BEFORE DIALOG
               CALL cl_navigator_setting(g_current_idx, g_current_cnt)
               LET g_curr_diag = ui.DIALOG.getCurrent()
               LET g_page = "first" 
               #還原為原本指定筆數
               IF g_current_row > 1 THEN
                  #當刪除最後一筆資料時可能產生錯誤, 進行額外判斷
                  IF g_current_row > g_browser.getLength() THEN
                    LET g_current_row = g_browser.getLength()
                  END IF 
                  LET g_current_idx = g_current_row
                  CALL DIALOG.setCurrentRow("s_browse",g_current_idx)
               END IF
              
               #當每次在browser點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                     
                  #LET gi_sub_dialog = TRUE  
                  CALL azzi800_fetch("")                                  
                                 
               END IF               
               
            AFTER DIALOG
               #add-point:ui_dialog段 after dialog
               {<point name="ui_dialog.after_dialog"/>}
               #end add-point
            
            ON ACTION statechange
               CALL azzi800_statechange()
               LET g_action_choice="statechange"
               EXIT DIALOG
         
            ON ACTION filter
               CALL azzi800_filter()
               EXIT DIALOG
 
            ON ACTION first
               CALL azzi800_fetch("F") 
               LET g_current_row = g_current_idx
            
            ON ACTION next
               CALL azzi800_fetch("N")
               LET g_current_row = g_current_idx
         
            ON ACTION jump
               CALL azzi800_fetch("/")
               LET g_current_row = g_current_idx
         
            ON ACTION previous
               CALL azzi800_fetch("P")
               LET g_current_row = g_current_idx
         
            ON ACTION last 
               CALL azzi800_fetch("L")  
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
                  CALL gfrm_curr.setElementHidden("mainlayout",1) #不隱藏
                  CALL gfrm_curr.setElementHidden("worksheet",0)
                  LET g_main_hidden = 1

               END IF
               #EXIT DIALOG
            #   
            ON ACTION worksheethidden   #瀏覽頁折疊 
               IF g_main_hidden THEN
                  CALL gfrm_curr.setElementHidden("mainlayout",0)
                  CALL gfrm_curr.setElementHidden("worksheet",1)
                  LET g_main_hidden = 0
               ELSE
                  CALL gfrm_curr.setElementHidden("mainlayout",1)
                  CALL gfrm_curr.setElementHidden("worksheet",0)
                  LET g_main_hidden = 1
               END IF
               #EXIT DIALOG
         
            #單頭摺疊，可利用hot key "Ctrl-s"開啟/關閉單頭
            ON ACTION controls   
               IF g_header_hidden THEN
                  CALL gfrm_curr.setElementHidden("worksheet_detail",0)
                  CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
                  LET g_header_hidden = 0     #visible
               ELSE
                  CALL gfrm_curr.setElementHidden("worksheet_detail",1)
                  CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
                  LET g_header_hidden = 1     #hidden     
               END IF
 

         ON ACTION modify
 
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN 
               #CALL azzi800_modify()
               #add-point:ON ACTION modify
               #得到doubleClick在哪一個單身再給值
               LET g_appoint_detail = DIALOG.getCurrentItem()
               LET g_appoint_idx = DIALOG.getCurrentRow(g_appoint_detail)
               
               CALL azzi800_modify()
               CALL s_aooi723_set_bpmid(g_gzxa_m.gzxa001,g_gzxa_m.gzxa003)   #160429-00013#7 add
               #add-point:ON ACTION modify
               {<point name="menu.modify" />}
               INITIALIZE g_appoint_detail, g_appoint_idx TO NULL
               #END add-point
                EXIT DIALOG
            END IF
            
          ON ACTION modify_detail
             LET g_action_choice="modify_detail"
             IF cl_auth_chk_act("modify") THEN
               LET g_appoint_detail = DIALOG.getCurrentItem()
               LET g_appoint_idx = DIALOG.getCurrentRow(g_appoint_detail)
               CALL azzi800_modify()
               CALL azzi800_show()    #160815-00018#1-add
               INITIALIZE g_appoint_detail, g_appoint_idx TO NULL
             END IF
    
         ON ACTION insert
 
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN 
               CALL azzi800_insert()
               CALL s_aooi723_set_bpmid(g_gzxa_m.gzxa001,g_gzxa_m.gzxa003)   #160429-00013#7 add
               #add-point:ON ACTION insert
               {<point name="menu.insert" />}
               #END add-point
                EXIT DIALOG
            END IF
 
 
         ON ACTION output
 
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN 
               #add-point:ON ACTION output
#               CALL azzi800_g01(g_wc)    #160318-00025#35 mark 暂时mark为过单
               #END add-point
                EXIT DIALOG
            END IF
 
 
         ON ACTION reproduce
 
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN 
               CALL azzi800_reproduce()
               CALL s_aooi723_set_bpmid(g_gzxa_m.gzxa001,g_gzxa_m.gzxa003)   #160429-00013#7 add
               #add-point:ON ACTION reproduce
               {<point name="menu.reproduce" />}
               #END add-point
                EXIT DIALOG
            END IF
 
 
         ON ACTION query
 
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN 
               CALL azzi800_query()
               EXIT DIALOG
               #add-point:ON ACTION query
               {<point name="menu.query" />}
               #END add-point
            END IF
 
 
         ON ACTION delete
 
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN 
               CALL azzi800_delete()
               #add-point:ON ACTION delete
               {<point name="menu.delete" />}
               #END add-point
            END IF

                  #新增相關文件
         ON ACTION related_document
            CALL g_pk_array.clear()
            LET g_pk_array[1].values = g_gzxa_m.gzxa001
            LET g_pk_array[1].column = 'gzxa001'

            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document

               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               #browser
               IF g_main_hidden = 1 THEN
                  LET g_export_node[1] = base.typeInfo.create(g_browser)
                  LET g_export_id[1]   = "s_browse"
                  CALL cl_export_to_excel()
               #非browser
               ELSE
                  LET g_export_node[1] = base.typeInfo.create(g_gzxb_d)
                  LET g_export_id[1]   = "s_detail1_01"
                  LET g_export_node[2] = base.typeInfo.create(g_gzxc_d)
                  LET g_export_id[2]   = "s_detail1_03"
                  LET g_export_node[3] = base.typeInfo.create(g_gzxe_d)
                  LET g_export_id[3]   = "s_detail1_02"

                  #add-point:ON ACTION exporttoexcel

                  #END add-point
                  CALL cl_export_to_excel_getpage()
                  CALL cl_export_to_excel()
               END IF
            END IF

         ON ACTION passwd
            LET la_param.prog = "azzi801"
            LET la_param.param[1] = g_gzxa_m.gzxa001
            LET ls_js = util.JSON.stringify(la_param)
            #CALL cl_cmdrun(ls_js)
            CALL cl_cmdrun_wait(ls_js)
            EXIT DIALOG
            
            #主選單用ACTION
            &include "main_menu.4gl"
            &include "relating_action.4gl"
            #交談指令共用ACTION
            &include "common_action.4gl"
            
         END DIALOG 

      ELSE

         DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

            #左側瀏覽頁簽
            DISPLAY ARRAY g_browser TO s_browse.* ATTRIBUTE(COUNT=g_rec_b)

               BEFORE ROW
                  #回歸舊筆數位置 (回到當時異動的筆數)
                  LET g_current_idx = DIALOG.getCurrentRow("s_browse")
                  IF g_current_idx = 0 THEN
                     LET g_current_idx = 1
                  END IF
                  LET g_current_row = g_current_idx  #目前指標
                  LET g_current_sw = TRUE
                  CALL cl_show_fld_cont()

                  #當每次點任一筆資料都會需要用到
                  CALL azzi800_fetch("")
                  
               
               ON COLLAPSE (g_row_index)
                  #樹關閉
            
            END DISPLAY
 
            SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
            SUBDIALOG lib_cl_dlg.cl_dlg_relateapps

            #add-point:ui_dialog段define
            {<point name="ui_dialog.more_displayarray"/>}

            #end add-point
            SUBDIALOG azz_azzi800_01.azzi800_01_display
            SUBDIALOG azz_azzi800_01.azzi800_01_1_display
            SUBDIALOG azz_azzi800_02.azzi800_02_display
            
            ON ACTION cont_page
               LET g_detail_id = "cont_page"
               NEXT FIELD gzxbstus
            ON ACTION comm_page
               LET g_detail_id = "comm_page"
               NEXT FIELD gzxestus

            BEFORE DIALOG
               CALL cl_navigator_setting(g_current_idx, g_current_cnt)
               LET g_curr_diag = ui.DIALOG.getCurrent()
               LET g_page = "first"
               #還原為原本指定筆數
               IF g_current_row > 1 THEN
                  #當刪除最後一筆資料時可能產生錯誤, 進行額外判斷
                  IF g_current_row > g_browser.getLength() THEN
                    LET g_current_row = g_browser.getLength()
                  END IF
                  LET g_current_idx = g_current_row
                  CALL DIALOG.setCurrentRow("s_browse",g_current_idx)
               END IF

               #當每次點任一筆資料都會需要用到
               IF g_browser_cnt > 0 THEN              
                  CALL azzi800_fetch("")                
               END IF

            AFTER DIALOG
               #add-point:ui_dialog段 after dialog
               {<point name="ui_dialog.after_dialog"/>}
               #end add-point

            ON ACTION statechange
               CALL azzi800_statechange()
               LET g_action_choice="statechange"
               EXIT DIALOG

            ON ACTION filter
               CALL azzi800_filter()
               EXIT DIALOG

            ON ACTION first
               CALL azzi800_fetch("F")
               LET g_current_row = g_current_idx

            ON ACTION next
               CALL azzi800_fetch("N")
               LET g_current_row = g_current_idx

            ON ACTION jump
               CALL azzi800_fetch("/")
               LET g_current_row = g_current_idx

            ON ACTION previous
               CALL azzi800_fetch("P")
               LET g_current_row = g_current_idx

            ON ACTION last
               CALL azzi800_fetch("L")
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
            #當在browser double click
            ON ACTION worksheethidden   #瀏覽頁折疊
               
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
                  CALL gfrm_curr.setElementHidden("worksheet_detail",0)
                  CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
                  LET g_header_hidden = 0     #visible
               ELSE
                  CALL gfrm_curr.setElementHidden("worksheet_detail",1)
                  CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
                  LET g_header_hidden = 1     #hidden
               END IF


         ON ACTION modify

            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               CALL azzi800_modify()
               CALL s_aooi723_set_bpmid(g_gzxa_m.gzxa001,g_gzxa_m.gzxa003)   #160429-00013#7 add
               #add-point:ON ACTION modify
               {<point name="menu.modify" />}
               #END add-point
                EXIT DIALOG
            END IF


         ON ACTION insert

            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL azzi800_insert()
               CALL s_aooi723_set_bpmid(g_gzxa_m.gzxa001,g_gzxa_m.gzxa003)   #160429-00013#7 add
               #add-point:ON ACTION insert
               {<point name="menu.insert" />}
               #END add-point
                EXIT DIALOG
            END IF


         ON ACTION output

            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               #add-point:ON ACTION output
               {<point name="menu.output" />}
               #END add-point
                EXIT DIALOG
            END IF


         ON ACTION reproduce

            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL azzi800_reproduce()
               CALL s_aooi723_set_bpmid(g_gzxa_m.gzxa001,g_gzxa_m.gzxa003)   #160429-00013#7 add
               #add-point:ON ACTION reproduce
               {<point name="menu.reproduce" />}
               #END add-point
                EXIT DIALOG
            END IF


         ON ACTION query

            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL azzi800_query()
               EXIT DIALOG
               #add-point:ON ACTION query
               {<point name="menu.query" />}
               #END add-point
            END IF


         ON ACTION delete

            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL azzi800_delete()
               #add-point:ON ACTION delete
               {<point name="menu.delete" />}
               #END add-point
            END IF

         #+ 此段落由子樣板a46產生
         #新增相關文件
         ON ACTION related_document
            CALL g_pk_array.clear()
            LET g_pk_array[1].values = g_gzxa_m.gzxa001
            LET g_pk_array[1].column = 'gzxa001'

            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document

               #END add-point
               CALL cl_doc()
            END IF
         
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_gzxb_d)
               LET g_export_id[1]   = "s_detail1_01"
               LET g_export_node[2] = base.typeInfo.create(g_gzxc_d)
               LET g_export_id[2]   = "s_detail1_03"
               LET g_export_node[3] = base.typeInfo.create(g_gzxe_d)
               LET g_export_id[3]   = "s_detail1_02"

               #add-point:ON ACTION exporttoexcel

               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF


            #主選單用ACTION
            &include "main_menu.4gl"
            &include "relating_action.4gl"
            #交談指令共用ACTION
            &include "common_action.4gl"

         END DIALOG

      END IF

   END WHILE

END FUNCTION

PRIVATE FUNCTION azzi800_browser_fill(ps_page_action)
   {<Local define>}
   DEFINE p_wc              STRING
   DEFINE ps_page_action    STRING
   DEFINE l_searchcol       STRING
   DEFINE l_sql             STRING
   DEFINE l_sql_rank        STRING
   {</Local define>}
   #add-point:browser_fill段define
   {<point name="browser_fill.define"/>}
   DEFINE l_sub_sql         STRING
   #end add-point

   CLEAR FORM
   INITIALIZE g_gzxa_m.* TO NULL
   #INITIALIZE g_wc TO NULL
   CALL g_browser.clear()

   #搜尋用
   IF cl_null(g_searchcol) OR g_searchcol = "0" THEN
      LET l_searchcol = "gzxa001"
   ELSE
      LET l_searchcol = g_searchcol
   END IF

   #LET p_wc = p_wc.trim() #當查詢按下Q時 按下放棄 g_wc = "  " 所以要清掉空白
   #IF cl_null(p_wc) THEN  #p_wc 查詢條件
   #   LET p_wc = " 1=1 "
   #END IF

   #add-point:browser_fill段wc控制
   {<point name="browser_fill.wc"/>}
   #end add-point

   LET l_sub_sql = "SELECT DISTINCT gzxa001 FROM gzxa_t"
   #子程式 sql  azzi800_01  gzxb_t
   IF g_wc2_01 <> " 1=1" AND NOT cl_null(g_wc2_01) THEN
      LET l_sub_sql = l_sub_sql,
                      " LEFT JOIN gzxb_t ON gzxaent = gzxbent AND gzxa003 = gzxb001 "
   END IF
   #子程式 sql  azzi800_01  gzxc_t
   IF g_wc3_01 <> " 1=1" AND NOT cl_null(g_wc3_01) THEN
      LET l_sub_sql = l_sub_sql,
                      " LEFT JOIN gzxc_t ON gzxaent = gzxcent AND gzxa003 = gzxc001 "                      
   END IF
              
   
   #子程式 sql  azzi800_02  gzxe_t
   IF g_wc2_02 <> " 1=1" AND NOT cl_null(g_wc2_02) THEN
      LET l_sub_sql = l_sub_sql,
                      " LEFT JOIN gzxe_t ON gzxaent = gzxeent AND gzxa003 = gzxe001 "
   END IF   

   LET l_sub_sql = l_sub_sql,
               " LEFT JOIN ooag_t ON gzxaent = ooagent AND gzxa003 = ooag001" ,
               " LEFT JOIN ooefl_t ON gzxaent = ooeflent AND gzxa007 = ooefl001  AND ooefl002 = '",g_lang,"' ",
               " WHERE gzxaent = '" ||g_enterprise|| "' AND ", g_wc CLIPPED
               
   IF g_wc2_01 <> " 1=1" AND NOT cl_null(g_wc2_01) THEN
      LET l_sub_sql = l_sub_sql, " AND ", g_wc2_01
   END IF

   IF g_wc2_02 <> " 1=1" AND NOT cl_null(g_wc2_02) THEN
      LET l_sub_sql = l_sub_sql, " AND ", g_wc2_02
   END IF

   IF g_wc3_01 <> " 1=1" AND NOT cl_null(g_wc3_01) THEN
      LET l_sub_sql = l_sub_sql, " AND ", g_wc3_01
   END IF

   LET l_sub_sql = l_sub_sql,cl_sql_add_filter("gzxa_t")

   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"   

   
   PREPARE header_cnt_pre FROM g_sql
   EXECUTE header_cnt_pre INTO g_browser_cnt   #總筆數
   FREE header_cnt_pre
 
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
 
   LET g_sql = "SELECT gzxastus,gzxa001,gzxa002,gzxa003,ooag011,gzxa007,ooefl003,gzxa010 ",
                    " FROM gzxa_t "                 
   IF g_wc2_01 <> " 1=1" AND NOT cl_null(g_wc2_01) THEN
      LET g_sql = g_sql,
                    " LEFT JOIN gzxb_t ON gzxaent = gzxbent AND gzxa003 = gzxb001 "
   END IF

   IF g_wc3_01 <> " 1=1" AND NOT cl_null(g_wc3_01) THEN
       LET g_sql = g_sql,
                    " LEFT JOIN gzxc_t ON gzxaent = gzxcent AND gzxa003 = gzxc001 "                   
   END IF
   
   IF g_wc2_02 <> " 1=1" AND NOT cl_null(g_wc2_02) THEN
      LET g_sql = g_sql,
                       " LEFT JOIN gzxe_t ON gzxaent = gzxeent AND gzxa003 = gzxe001 "
   END IF

   LET g_sql = g_sql,
               " LEFT JOIN ooag_t ON gzxaent = ooagent AND gzxa003 = ooag001" ,
               " LEFT JOIN ooefl_t ON gzxaent = ooeflent AND gzxa007 = ooefl001  AND ooefl002 = '",g_lang,"' ",
               " WHERE gzxaent = '" ||g_enterprise|| "' AND ", g_wc CLIPPED
  
   IF g_wc2_01 <> " 1=1" AND NOT cl_null(g_wc2_01) THEN
      LET g_sql = g_sql,
                       " AND ", g_wc2_01
   END IF

   IF g_wc3_01 <> " 1=1" AND NOT cl_null(g_wc3_01) THEN
      LET g_sql = g_sql,
                       " AND ", g_wc3_01
   END IF
   
   IF g_wc2_02 <> " 1=1" AND NOT cl_null(g_wc2_02) THEN
      LET g_sql = g_sql,
                       " AND ", g_wc2_02
   END IF

   LET g_sql = g_sql,cl_sql_add_filter("gzxa_t") ,
               " ORDER BY ",l_searchcol," ",g_order
   
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre
 
   CALL g_browser.clear()
   LET g_cnt = 1
   
   FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_gzxa001,g_browser[g_cnt].b_gzxa002,g_browser[g_cnt].b_gzxa003,
                           g_browser[g_cnt].b_gzxa003_desc,g_browser[g_cnt].b_gzxa007,g_browser[g_cnt].b_gzxa007_desc,g_browser[g_cnt].b_gzxa010   #單身 ARRAY 填充
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "foreach:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      #add-point:browser_fill段reference
      {<point name="browser_fill.reference"/>}
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
   LET g_header_cnt = g_browser.getLength()
   #該樣板不需此段落LET g_header_cnt = g_browser_cnt
   LET g_rec_b = g_cnt - 1
   LET g_current_cnt = g_rec_b
   #該樣板不需此段落LET g_current_cnt = g_browser_cnt
   LET g_cnt = 0

   #CALL azzi800_fetch("") 
   FREE browse_pre

END FUNCTION

PRIVATE FUNCTION azzi800_construct()
   {<Local define>}
   DEFINE ls_return      STRING
   DEFINE ls_result      STRING
   {</Local define>}
   #add-point:cs段define
   {<point name="cs.define"/>}
   #end add-point

   CLEAR FORM
   INITIALIZE g_gzxa_m.* TO NULL
   INITIALIZE g_wc TO NULL
   LET g_current_row = 1
   #當按下q時 預設第一筆查詢
   LET l_ac_01 = 1 
   LET l_ac_03 = 1  #160919-00061#1 一併處理 #160908-00046 #1 azzi800點擊查詢時，在單身的據點欄位點擊開窗，程式閃退

   LET g_qryparam.state = "c"

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #螢幕上取條件
      CONSTRUCT BY NAME g_wc ON gzxa001,gzxa002,gzxa003,gzxastus,gzxa010,gzxa007,gzxa011,gzxa005,gzxa008,gzxa009,gzxa016,gzxa017,gzxaownid,gzxaowndp,gzxacrtid,gzxacrtdp,gzxacrtdt,gzxamodid,gzxamoddt

         AFTER FIELD gzxacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)

         AFTER FIELD gzxamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)

         ON ACTION controlp INFIELD gzxa001
            #add-point:ON ACTION controlp INFIELD gzxa001
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.default1 = g_gzxa_m.gzxa001   #給予default值
            #給予arg
            CALL q_gzxa001_2()                            #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzxa001         #顯示到畫面上
            NEXT FIELD gzxa001                            #返回原欄位
            #END add-point

         #Ctrlp:construct.c.gzxa003
         ON ACTION controlp INFIELD gzxa003
            #add-point:ON ACTION controlp INFIELD gzxa003
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.default1 = g_gzxa_m.gzxa003   #給予default值
            #給予arg
            CALL q_gzxa003_3()                            #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzxa003  #顯示到畫面上
            NEXT FIELD gzxa003                            #返回原欄位
            #END add-point

         ON ACTION controlp INFIELD gzxa007
            #add-point:ON ACTION controlp INFIELD gzxa007
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_gzxa007_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzxa007        #顯示到畫面上
            NEXT FIELD gzxa007                           #返回原欄位

         ON ACTION controlp INFIELD gzxa011
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_gzwe001()                             #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzxa011        #顯示到畫面上
            NEXT FIELD gzxa011                           #返回原欄位 

      END CONSTRUCT

      SUBDIALOG azz_azzi800_01.azzi800_01_construct
      #關閉角色據點配置頁籤第二單身 先不提供查詢
      SUBDIALOG azz_azzi800_01.azzi800_01_1_construct
      SUBDIALOG azz_azzi800_02.azzi800_02_construct

      BEFORE DIALOG
         NEXT FIELD gzxa001

      ON ACTION accept
         EXIT DIALOG

      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG

      #查詢CONSTRUCT共用ACTION
      &include "construct_action.4gl"

      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   END DIALOG

END FUNCTION

PRIVATE FUNCTION azzi800_filter()

   LET INT_FLAG = 0

   LET g_qryparam.state = 'c'

   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc

   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')

   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #單頭
      CONSTRUCT g_wc_filter ON gzxa001,gzxa002,gzxa003
                          FROM s_browse[1].b_gzxa001,s_browse[1].b_gzxa002,s_browse[1].b_gzxa003

         BEFORE CONSTRUCT
            CALL cl_qbe_init()
               DISPLAY azzi800_filter_parser('gzxa001') TO s_browse[1].b_gzxa001
            DISPLAY azzi800_filter_parser('gzxa002') TO s_browse[1].b_gzxa002
            DISPLAY azzi800_filter_parser('gzxa003') TO s_browse[1].b_gzxa003

      END CONSTRUCT

      #add-point:filter段add_cs
      {<point name="filter.add_cs"/>}
      #end add-point

      BEFORE DIALOG
         #add-point:filter段b_dialog
         {<point name="filter.b_dialog"/>}
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

END FUNCTION

PRIVATE FUNCTION azzi800_filter_parser(ps_field)
   {<Local define>}
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
   {</Local define>}
   #add-point:filter段define
   {<point name="filter_parser.define"/>}
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

PRIVATE FUNCTION azzi800_query()
   {<Local define>}
   DEFINE ls_wc STRING
   {</Local define>}
   #add-point:query段define
   {<point name="query.define"/>}
   #end add-point

   LET INT_FLAG = 0
   LET ls_wc = g_wc

   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF

   CALL g_browser.clear()

   IF g_worksheet_hidden THEN  #browser panel 單身折疊
      CALL gfrm_curr.setElementHidden("worksheet_vbox",0)
      CALL gfrm_curr.setElementImage("worksheethidden","worksheethidden-24.png")
      LET g_worksheet_hidden = 0
   END IF
   IF g_header_hidden THEN    #單頭折疊
      CALL gfrm_curr.setElementHidden("worksheet_detail",0)
      CALL gfrm_curr.setElementImage("controls","headerhidden-24")
      LET g_header_hidden = 0
   END IF

   INITIALIZE g_gzxa_m.* TO NULL
   CALL azzi800_01_clear_detail()
   CALL azzi800_02_clear_detail()
   ERROR ""

   DISPLAY " " TO FORMONLY.b_count
   DISPLAY " " TO FORMONLY.h_count
   CALL azzi800_construct()

   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      CALL azzi800_browser_fill("F")
      CALL azzi800_fetch("")
      RETURN
   ELSE
      LET g_current_row = 1
      LET g_current_cnt = 0
   END IF

   LET g_error_show = 1
   CALL azzi800_browser_fill("F")   # 移到第一頁

   #備份搜尋條件
   LET ls_wc = g_wc

   #第一層模糊搜尋
   IF g_browser.getLength() = 0 THEN
      LET g_wc = cl_wc_parser(ls_wc)
      LET g_error_show = 1
      CALL azzi800_browser_fill("F")
   END IF

   #第二層助記碼搜尋
   IF g_browser.getLength() = 0 THEN
      IF NOT cl_null(g_wc) THEN
         LET g_error_show = 1
         CALL azzi800_browser_fill("F")
      END IF
   END IF

   IF g_browser.getLength() = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "-100"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()

   ELSE
      CALL azzi800_fetch("F")
   END IF

   LET g_wc_filter = ""

END FUNCTION

PRIVATE FUNCTION azzi800_fetch(p_fl)
   {<Local define>}
   DEFINE p_fl       LIKE type_t.chr1
   DEFINE ls_msg     STRING
   {</Local define>}

   #add-point:fetch段define
   {<point name="fetch.define"/>}
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

   IF g_current_idx > g_browser.getLength() THEN
      LET g_current_idx = g_browser.getLength()
   END IF

   # 設定browse索引
   CALL g_curr_diag.setCurrentRow("s_browse", g_current_idx)

   CALL cl_navigator_setting(g_browser_idx, g_current_cnt)

   #代表沒有資料, 無需做後續資料撈取之動作
   IF g_current_idx = 0 THEN
      RETURN
   END IF

   LET g_gzxa_m.gzxa001 = g_browser[g_current_idx].b_gzxa001

   #重讀DB,因TEMP有不被更新特性
    EXECUTE azzi800_master_referesh USING g_enterprise,g_gzxa_m.gzxa001 
      INTO g_gzxa_m.gzxa001,g_gzxa_m.gzxa002,g_gzxa_m.gzxa003,g_gzxa_m.gzxastus,
           g_gzxa_m.gzxa010,g_gzxa_m.gzxa007,g_gzxa_m.gzxa007_desc,g_gzxa_m.gzxa011,g_gzxa_m.gzxa011_desc,
           g_gzxa_m.gzxa013,g_gzxa_m.gzxa013_desc,
           g_gzxa_m.gzxa005,
           g_gzxa_m.gzxa008,g_gzxa_m.gzxa009,g_gzxa_m.gzxa016,g_gzxa_m.gzxa017,g_gzxa_m.gzxaownid,
           g_gzxa_m.gzxaowndp,g_gzxa_m.gzxacrtid,g_gzxa_m.gzxacrtdp,g_gzxa_m.gzxacrtdt,
           g_gzxa_m.gzxamodid,g_gzxa_m.gzxamoddt,
           g_gzxa_m.gzxa003_desc, 
           g_gzxa_m.gzxaownid_desc,g_gzxa_m.gzxaowndp_desc,g_gzxa_m.gzxacrtid_desc,g_gzxa_m.gzxacrtdp_desc, 
           g_gzxa_m.gzxamodid_desc
     
           
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "gzxa_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      INITIALIZE g_gzxa_m.* TO NULL

      RETURN
   END IF

   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,delete,reproduce", FALSE)
   ELSE
      CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   END IF

   CALL azzi800_gzxz_t('s')

   LET g_data_owner = g_gzxa_m.gzxaownid      #161225-00003#3 add
   LET g_data_dept  = g_gzxa_m.gzxaowndp      #161225-00003#3 add

   #重新顯示
   CALL azzi800_show()

END FUNCTION

PRIVATE FUNCTION azzi800_insert()

   CLEAR FORM                    #清畫面欄位內容
   CALL azzi800_01_clear_detail()
   CALL azzi800_02_clear_detail()
   INITIALIZE g_gzxa_m.* LIKE gzxa_t.*             #DEFAULT 設定
   LET g_gzxa001_t = NULL

   CALL s_transaction_begin()

   WHILE TRUE

      #公用欄位給值
      #此段落由子樣板a14產生
      LET g_gzxa_m.gzxaownid = g_user
      LET g_gzxa_m.gzxaowndp = g_dept
      LET g_gzxa_m.gzxacrtid = g_user
      LET g_gzxa_m.gzxacrtdp = g_dept
      LET g_gzxa_m.gzxacrtdt = cl_get_current()

      #append欄位給值

      #一般欄位給值
      LET g_gzxa_m.gzxastus = "Y"
      LET g_gzxa_m.gzxd004 = "N" 
      #先給預設語言別 繁體 
      LET g_gzxa_m.gzxa010 = "zh_TW"   

      #add-point:單頭預設值
      {<point name="insert.default"/>}
      LET g_gzxa_m.gzxa008 = "0"
      LET g_gzxa_m.gzxa009 = "0"
      LET g_gzxa_m.gzxa016 = "Y"
      
      #end add-point

      CALL azzi800_input("a")

      #add-point:單頭輸入後
      {<point name="insert.after_insert"/>}
      #end add-point

      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_gzxa_m.* = g_gzxa_m_t.*
         CALL azzi800_show()
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

   LET g_state = "Y"
   LET g_current_idx = 1
   LET g_gzxa001_t = g_gzxa_m.gzxa001

   LET g_wc = g_wc,
              " OR ( gzxaent = '" ||g_enterprise|| "' AND",
              " gzxa001 = '", g_gzxa_m.gzxa001 CLIPPED, "' "

              , ") "

END FUNCTION

PRIVATE FUNCTION azzi800_modify()
   #add-point:modify段define
   {<point name="modify.define"/>}
   #end add-point

   LET g_gzxa_m_t.* = g_gzxa_m.*
   LET g_gzxa_m_o.* = g_gzxa_m.*

   IF g_gzxa_m.gzxa001 IS NULL

   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF

   ERROR ""

   LET g_gzxa001_t = g_gzxa_m.gzxa001


   CALL s_transaction_begin()

   OPEN azzi800_cl USING g_enterprise,g_gzxa_m.gzxa001
   #IF STATUS THEN
   IF SQLCA.sqlcode THEN #因STATUS無法進入lock的訊息提示，把STATUS改成SQLCA.sqlcode (azzi800是簽入功能)
      CLOSE azzi800_cl
      CALL s_transaction_end('N','0')    #161220-00012#1
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  SQLCA.sqlcode
      LET g_errparam.extend = "OPEN azzi800_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF

   EXECUTE azzi800_master_referesh USING g_enterprise,g_gzxa_m.gzxa001 
      INTO g_gzxa_m.gzxa001,g_gzxa_m.gzxa002,g_gzxa_m.gzxa003,g_gzxa_m.gzxastus,
           g_gzxa_m.gzxa010,g_gzxa_m.gzxa007,g_gzxa_m.gzxa007_desc,g_gzxa_m.gzxa011,g_gzxa_m.gzxa011_desc,           
           g_gzxa_m.gzxa013,g_gzxa_m.gzxa013_desc,
           g_gzxa_m.gzxa005,
           g_gzxa_m.gzxa008,g_gzxa_m.gzxa009,g_gzxa_m.gzxa016,g_gzxa_m.gzxa017,g_gzxa_m.gzxaownid,
           g_gzxa_m.gzxaowndp,g_gzxa_m.gzxacrtid,g_gzxa_m.gzxacrtdp,g_gzxa_m.gzxacrtdt,
           g_gzxa_m.gzxamodid,g_gzxa_m.gzxamoddt,
           g_gzxa_m.gzxa003_desc, 
           g_gzxa_m.gzxaownid_desc,g_gzxa_m.gzxaowndp_desc,g_gzxa_m.gzxacrtid_desc,g_gzxa_m.gzxacrtdp_desc, 
           g_gzxa_m.gzxamodid_desc
           
   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      CLOSE azzi800_cl
      CALL s_transaction_end('N','0')   #161220-00012#1
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "gzxa_t"
      LET g_errparam.popup = FALSE
      CALL cl_err()
      RETURN
   END IF

   CALL azzi800_gzxz_t('s')

   CALL azzi800_show()

   WHILE TRUE
      LET g_gzxa_m.gzxa001 = g_gzxa001_t


      #寫入修改者/修改日期資訊
      LET g_gzxa_m.gzxamodid = g_user
LET g_gzxa_m.gzxamoddt = cl_get_current()


      #add-point:modify段修改前
      {<point name="modify.before_input"/>}
      #end add-point
      LET g_gzxa003_d = g_gzxa_m.gzxa003
      CALL azzi800_input("u")     #欄位更改

      #add-point:modify段修改後
      {<point name="modify.after_input"/>}
      LET g_gzxa_m.gzxamodid_desc = s_desc_get_person_desc(g_gzxa_m.gzxamodid)  #160815-00018#1-add
      #end add-point

      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_gzxa_m.* = g_gzxa_m_t.*
         CALL azzi800_show()
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
   #IF NOT cl_log_modified_record(g_gzxa_m.gzxa001,g_site) THEN
   #   CALL s_transaction_end('N','0')
   #END IF

   CLOSE azzi800_cl
   CALL s_transaction_end('Y','0')

   #流程通知預埋點-U
   CALL cl_flow_notify(g_gzxa_m.gzxa001,"U")

   LET g_worksheet_hidden = 0

END FUNCTION

PRIVATE FUNCTION azzi800_input(p_cmd)
   {<Local define>}
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
   DEFINE lc_gzxd002      LIKE gzxd_t.gzxd002     #密碼
   DEFINE ls_str          STRING                  #161107-00022 #1
   DEFINE li_chk_dup      LIKE type_t.num5        #161005-00006 #1  add
   {</Local define>}
   #add-point:input段define
   {<point name="input.define"/>}
   #end add-point

   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
  
   CALL cl_set_head_visible("","YES")

   LET l_insert = FALSE
   LET g_action_choice = ""

   LET g_qryparam.state = "i"

   #控制key欄位可否輸入
   CALL azzi800_set_entry(p_cmd)
   #add-point:set_entry後
   {<point name="input.after_set_entry"/>}
   #end add-point
   CALL azzi800_set_no_entry(p_cmd)
   #add-point:資料輸入前
   {<point name="input.before_input"/>}
   #end add-point
   #單身新增刪除權限
   LET g_detail_insert = cl_auth_detail_input("insert")
   LET g_detail_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   DISPLAY BY NAME g_gzxa_m.gzxa001,g_gzxa_m.gzxa002,g_gzxa_m.gzxa003,g_gzxa_m.gzxastus,g_gzxa_m.gzxa010,
                   g_gzxa_m.gzxa007,g_gzxa_m.gzxa011,
                   g_gzxa_m.gzxa005,
                   g_gzxa_m.gzxa008,g_gzxa_m.gzxa009,g_gzxa_m.gzxa016,g_gzxa_m.gzxa017,g_gzxa_m.gzxz002,g_gzxa_m.gzxz003,
                   g_gzxa_m.gzxd004,g_gzxa_m.gzxz005,g_gzxa_m.gzxz006,g_gzxa_m.gzxz007

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #單頭段
     INPUT BY NAME g_gzxa_m.gzxa001,g_gzxa_m.gzxa002,g_gzxa_m.gzxa003,g_gzxa_m.gzxastus,g_gzxa_m.gzxa010,
                    g_gzxa_m.gzxa007,g_gzxa_m.gzxa011,g_gzxa_m.gzxa013,
                    g_gzxa_m.gzxa005,
                    g_gzxa_m.gzxa008,g_gzxa_m.gzxa009,g_gzxa_m.gzxa016,g_gzxa_m.gzxa017,g_gzxa_m.gzxz002,g_gzxa_m.gzxz003,
                    g_gzxa_m.gzxd004,g_gzxa_m.gzxz005,g_gzxa_m.gzxz006,g_gzxa_m.gzxz007
         ATTRIBUTE(WITHOUT DEFAULTS)

         #自訂ACTION(master_input)


         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            #其他table資料備份(確定是否更改用)


         #---------------------------<  Master  >---------------------------
         #----<<gzxa001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzxa001
            #add-point:BEFORE FIELD gzxa001
            {<point name="input.b.gzxa001" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD gzxa001

            #add-point:AFTER FIELD gzxa001
            #此段落由子樣板a05產生
            #161117-00008 start
            IF cl_get_para(g_enterprise,g_site,"A-SYS-0058") = "Y" THEN 
               LET g_gzxa_m.gzxa001 = UPSHIFT(g_gzxa_m.gzxa001)
            ELSE 
               LET g_gzxa_m.gzxa001 = DOWNSHIFT(g_gzxa_m.gzxa001)
            END IF
            DISPLAY BY NAME g_gzxa_m.gzxa001            
            #161117-00008 end
            
            IF  NOT cl_null(g_gzxa_m.gzxa001) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_gzxa_m.gzxa001 != g_gzxa001_t )) THEN
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM gzxa_t WHERE "||"gzxaent = '" ||g_enterprise|| "' AND "||"gzxa001 = '"||g_gzxa_m.gzxa001 ||"'",'std-00004',0) THEN
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE gzxa001
            #add-point:ON CHANGE gzxa001
            {<point name="input.g.gzxa001" />}
            #END add-point

         #----<<gzxa002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzxa002
            #add-point:BEFORE FIELD gzxa002
            {<point name="input.b.gzxa002" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD gzxa002

            #add-point:AFTER FIELD gzxa002
            {<point name="input.a.gzxa002" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE gzxa002
            #add-point:ON CHANGE gzxa002
            {<point name="input.g.gzxa002" />}
            #END add-point

         #----<<gzxa003>>----
         #此段落由子樣板a02產生
         AFTER FIELD gzxa003

            #add-point:AFTER FIELD gzxa003
            IF NOT cl_null(g_gzxa_m.gzxa003) THEN 
                IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_gzxa_m.gzxa003 != g_gzxa_m_t.gzxa003 )) THEN
                  #IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM gzxa_t WHERE "||"gzxaent = '" ||g_enterprise|| "' AND "||"gzxa003 = '"||g_gzxa_m.gzxa003 ||"'",'std-00004',0) THEN
                  #   NEXT FIELD CURRENT
                  #END IF
                  IF NOT s_azzi800_chk_gzxa003(g_gzxa_m.gzxa002,g_gzxa_m.gzxa003) THEN 
                     NEXT FIELD CURRENT
                  END IF
                  #161005-00006 start
                  IF p_cmd = 'a' THEN 
                     #檢核一次重複就不進去
                     IF NOT li_chk_dup THEN 
                        SELECT COUNT(1) INTO l_cnt FROM gzxa_t 
                         WHERE gzxaent = g_enterprise 
                          AND gzxa002 = g_gzxa_m.gzxa002
                          AND gzxa003 = g_gzxa_m.gzxa003
                          
                        IF l_cnt > 0 THEN 
                           CALL azzi800_get_gzxa_exist_info()
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = "azz-00426"
                           LET g_errparam.extend = ""
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET li_chk_dup = TRUE 
                           NEXT FIELD CURRENT                         
                         END IF 
                     END IF 
                  END IF
                  #161005-00006 end
                  IF p_cmd = 'u' AND (g_gzxa_m.gzxa003 != g_gzxa_m_t.gzxa003 ) THEN 
                     #假如更改員工編號，要去檢核預設據點編號是否存在，授權清單內(gzxc_t) 避免程式執行不起來                  
                     #161107-00022 start 
                     IF azzi800_chk_gzxa007(g_gzxa_m_t.gzxa003,g_gzxa_m.gzxa007) THEN 
                        LET l_count = azzi800_cnt_gzxb001(g_gzxa_m.gzxa003)
                        IF l_count > 0 THEN 
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = "std-00004"
                           LET g_errparam.extend = ""
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           NEXT FIELD CURRENT 
                        END IF 
                        LET gi_gzxa003_flag = TRUE  
                        LET g_wc_gzxa003 = "gzxa003='",g_gzxa_m.gzxa003,"'"   #ex:gzxa003='ty001'"
                     ELSE
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = "lib-00065"
                        LET g_errparam.extend = ""
                        LET g_errparam.replace[1] = g_gzxa_m.gzxa003
                        LET g_errparam.replace[2] = g_gzxa_m.gzxa001
                        LET g_errparam.replace[3] = g_gzxa_m.gzxa007
                        LET g_errparam.popup = TRUE
                        DISPLAY "WARNING ",cl_getmsg(g_errparam.code,g_lang)
                        CALL cl_err()
                        NEXT FIELD CURRENT 
                     END IF 
                     #161107-00022 end
                  END IF                   
#                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#                  INITIALIZE g_chkparam.* TO NULL
#                  #設定g_chkparam.*的參數
#                  LET g_chkparam.arg1 = g_gzxa_m.gzxa003
#                  #呼叫檢查存在並帶值的library
#                  IF cl_chk_exist("v_ooag001") THEN
#                  #檢查成功時後續處理
#                  #LET  = g_chkparam.return1
#                  #DISPLAY BY NAME
#                  ELSE
#                  #檢查失敗時後續處理          
#                     NEXT FIELD CURRENT
#                  END IF               
               END IF 
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[2] = g_gzxa_m.gzxa003
               CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
               LET g_gzxa_m.gzxa003_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_gzxa_m.gzxa003_desc
             END IF 
            #END add-point
         #此段落由子樣板a01產生
         BEFORE FIELD gzxa003
            #add-point:BEFORE FIELD gzxa003
            {<point name="input.b.gzxa003" />}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE gzxa003
            #add-point:ON CHANGE gzxa003
            {<point name="input.g.gzxa003" />}
            #END add-point
         
         #161214-00012 #4 start
         AFTER FIELD gzxa005
            
            IF g_gzxa_m.gzxa005 IS NOT NULL THEN
              #170308-00055 start
              IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_gzxa_m.gzxa005 != g_gzxa_m_t.gzxa005 )) THEN  
            
                 SELECT COUNT(1) INTO l_cnt FROM gzxa_t
                  WHERE gzxaent = g_enterprise
                   AND gzxa001 = g_gzxa_m.gzxa001
                   AND gzxa005 = g_gzxa_m.gzxa005
                 IF l_cnt > 0 THEN 
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = "std-00004"
                    LET g_errparam.extend = ""
                    LET g_errparam.popup = TRUE
                    CALL cl_err()
                    NEXT FIELD CURRENT
                 END IF               
              END IF
              #170308-00055 end              
            END IF
         #161214-00012 #4 end
         
         BEFORE FIELD gzxastus
            #add-point:BEFORE FIELD gzxastus
            {<point name="input.b.gzxastus" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD gzxastus

            #add-point:AFTER FIELD gzxastus
            {<point name="input.a.gzxastus" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE gzxastus
            #add-point:ON CHANGE gzxastus
            {<point name="input.g.gzxastus" />}
            #END add-point

         #----<<gzxa010>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzxa010
            #add-point:BEFORE FIELD gzxa010
            {<point name="input.b.gzxa010" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD gzxa010

            #add-point:AFTER FIELD gzxa010
            {<point name="input.a.gzxa010" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE gzxa010
            #add-point:ON CHANGE gzxa010
            {<point name="input.g.gzxa010" />}
            #END add-point

         #----<<gzxa007>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzxa007
            #add-point:BEFORE FIELD gzxa007
            {<point name="input.b.gzxa007" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD gzxa007

            #add-point:AFTER FIELD gzxa007
            IF NOT cl_null(g_gzxa_m.gzxa007) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_gzxa_m.gzxa007 != g_gzxa_m_t.gzxa007 )) THEN

                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_gzxa_m.gzxa007
                  #160318-00025#35  2016/04/15  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  #160318-00025#35  2016/04/15  by pengxin  add(E)
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooef001") THEN
                  #檢查成功時後續處理
                  ELSE
                  #檢查失敗時後續處理
                     NEXT FIELD CURRENT
                  END IF
                  
               END IF
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_gzxa_m.gzxa007
               CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_gzxa_m.gzxa007_desc = g_rtn_fields[1]
               DISPLAY g_gzxa_m.gzxa007_desc TO gzxa007_desc               
             END IF 
             
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE gzxa007
            #add-point:ON CHANGE gzxa007
            {<point name="input.g.gzxa007" />}
            #END add-point

         #----<<gzxa011>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzxa011
            #add-point:BEFORE FIELD gzxa011
            {<point name="input.b.gzxa011" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD gzxa011

            #add-point:AFTER FIELD gzxa011
             IF NOT cl_null(g_gzxa_m.gzxa011) THEN 
                IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_gzxa_m.gzxa011 != g_gzxa_m_t.gzxa011 )) THEN

                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_gzxa_m.gzxa011
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_gzxa011") THEN
                  #檢查成功時後續處理
                  ELSE
                  #檢查失敗時後續處理
                     NEXT FIELD CURRENT
                  END IF
                  
               END IF 
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_gzxa_m.gzxa011
               CALL ap_ref_array2(g_ref_fields,"SELECT gzwel003 FROM gzwel_t WHERE gzwelent='"||g_enterprise||"' AND gzwel001=? AND gzwel002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_gzxa_m.gzxa011_desc = g_rtn_fields[1]
               DISPLAY g_gzxa_m.gzxa011_desc TO gzxa011_desc
             END IF 
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE gzxa011
            #add-point:ON CHANGE gzxa011
            {<point name="input.g.gzxa011" />}
            #END add-point

         BEFORE FIELD gzxa017

         AFTER FIELD gzxa017
         
            IF NOT cl_null(g_gzxa_m.gzxa017) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_gzxa_m.gzxa017 != g_gzxa_m_t.gzxa017 ))  OR  g_gzxa_m_t.gzxa017 IS NULL THEN

               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_gzxa_m.gzxa017
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_gzxa017") THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "azz-00282" #電話號碼不可重複
                     LET g_errparam.extend = ""
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD CURRENT                     
                  END IF 
               END IF                  
             END IF 
             
         ON CHANGE gzxa017
         

         #----<<gzxz002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzxz002
            #add-point:BEFORE FIELD gzxz002
            {<point name="input.b.gzxz002" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD gzxz002

            #add-point:AFTER FIELD gzxz002
            {<point name="input.a.gzxz002" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE gzxz002
            #add-point:ON CHANGE gzxz002
            {<point name="input.g.gzxz002" />}
            #END add-point

         #----<<gzxz003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzxz003
            #add-point:BEFORE FIELD gzxz003
            {<point name="input.b.gzxz003" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD gzxz003

            #add-point:AFTER FIELD gzxz003
            {<point name="input.a.gzxz003" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE gzxz003
            #add-point:ON CHANGE gzxz003
            {<point name="input.g.gzxz003" />}
            #END add-point

         #----<<gzxd004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzxd004
            #add-point:BEFORE FIELD gzxd004
            {<point name="input.b.gzxd004" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD gzxd004

            #add-point:AFTER FIELD gzxd004
            {<point name="input.a.gzxd004" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE gzxd004
            #add-point:ON CHANGE gzxd004
            {<point name="input.g.gzxd004" />}
            #END add-point

         #----<<gzxz005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzxz005
            #add-point:BEFORE FIELD gzxz005
            {<point name="input.b.gzxz005" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD gzxz005

            #add-point:AFTER FIELD gzxz005
            {<point name="input.a.gzxz005" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE gzxz005
            #add-point:ON CHANGE gzxz005
            {<point name="input.g.gzxz005" />}
            #END add-point

         #----<<gzxz006>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzxz006
            #add-point:BEFORE FIELD gzxz006
            {<point name="input.b.gzxz006" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD gzxz006

            #add-point:AFTER FIELD gzxz006
            {<point name="input.a.gzxz006" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE gzxz006
            #add-point:ON CHANGE gzxz006
            {<point name="input.g.gzxz006" />}
            #END add-point

         #----<<gzxz007>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzxz007
            #add-point:BEFORE FIELD gzxz007
            {<point name="input.b.gzxz007" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD gzxz007

            #add-point:AFTER FIELD gzxz007
            {<point name="input.a.gzxz007" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE gzxz007
            #add-point:ON CHANGE gzxz007
            {<point name="input.g.gzxz007" />}
            #END add-point
            
         #----<<gzxa001>>----
         #Ctrlp:input.c.gzxa001
#         ON ACTION controlp INFIELD gzxa001
            #add-point:ON ACTION controlp INFIELD gzxa001
            {<point name="input.c.gzxa001" />}
            #END add-point

         #----<<gzxa002>>----
         #Ctrlp:input.c.gzxa002
#         ON ACTION controlp INFIELD gzxa002
            #add-point:ON ACTION controlp INFIELD gzxa002
            {<point name="input.c.gzxa002" />}
            #END add-point

         #----<<gzxa003>>----
         #Ctrlp:input.c.gzxa003
         ON ACTION controlp INFIELD gzxa003
    
         #開窗i段
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'i'
         LET g_qryparam.reqry = FALSE
         #LET g_qryparam.default1 = g_gzxa_m.gzxa003      #給予default值
         #給予arg
         CALL q_ooag001_3()                               #呼叫開窗
         LET g_gzxa_m.gzxa003 = g_qryparam.return1        #將開窗取得的值回傳到變數
         DISPLAY g_gzxa_m.gzxa003 TO gzxa003              #顯示到畫面上
         NEXT FIELD gzxa003                               #返回原欄位

         #----<<gzxastus>>----
         #Ctrlp:input.c.gzxastus
#         ON ACTION controlp INFIELD gzxastus
            #add-point:ON ACTION controlp INFIELD gzxastus
            {<point name="input.c.gzxastus" />}
            #END add-point

         #----<<gzxa010>>----
         #Ctrlp:input.c.gzxa010
#         ON ACTION controlp INFIELD gzxa010
            #add-point:ON ACTION controlp INFIELD gzxa010
            {<point name="input.c.gzxa010" />}
            #END add-point

         #----<<gzxa007>>----
         #Ctrlp:input.c.gzxa007
         ON ACTION controlp INFIELD gzxa007
            #add-point:ON ACTION controlp INFIELD gzxa007
            {<point name="input.c.gzxa007" />}
                        #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_gzxa_m.gzxa007     #給予default值

            #給予arg

            CALL q_ooef001_5()                               #呼叫開窗

            LET g_gzxa_m.gzxa007 = g_qryparam.return1      #將開窗取得的值回傳到變數
            DISPLAY g_gzxa_m.gzxa007 TO gzxa007            #顯示到畫面上

            NEXT FIELD gzxa007                             #返回原欄位
            #END add-point

         #----<<gzxa011>>----
         #Ctrlp:input.c.gzxa011
         ON ACTION controlp INFIELD gzxa011
            #add-point:ON ACTION controlp INFIELD gzxa011
            {<point name="input.c.gzxa011" />}
            #開窗i段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_gzxa_m.gzxa011       #給予default值
            #給予arg
            CALL q_gzwe001_1()                               #呼叫開窗
            LET g_gzxa_m.gzxa011 = g_qryparam.return1        #將開窗取得的值回傳到變數
            LET g_gzxa_m.gzxa011_desc = g_qryparam.return2   #將開窗取得的值回傳到變數
            DISPLAY g_gzxa_m.gzxa011 TO gzxa011              #顯示到畫面上
            DISPLAY g_gzxa_m.gzxa011_desc TO gzxa011_desc         #顯示到畫面上
            NEXT FIELD gzxa011                               #返回原欄位
            #END add-point
         
          ON ACTION controlp INFIELD gzxa013
            LET g_gzxa_m.gzxa013 = azzi800_05(g_gzxa_m.gzxa013)
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_gzxa_m.gzxa013
            CALL ap_ref_array2(g_ref_fields,"SELECT gzbal003 FROM gzbal_t WHERE gzbalent='"||g_enterprise||"' AND gzbal001=? AND gzbal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_gzxa_m.gzxa013_desc = g_rtn_fields[1]
            DISPLAY g_gzxa_m.gzxa013 TO gzxa013
            DISPLAY g_gzxa_m.gzxa013_desc TO gzxa013_desc
           

         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF

            IF p_cmd <> "u" THEN
               LET l_count = 1

               SELECT COUNT(1) INTO l_count FROM gzxa_t
                WHERE gzxaent = g_enterprise AND gzxa001 = g_gzxa_m.gzxa001
               
               IF l_count = 0 THEN

                  #add-point:單頭新增前
                  {<point name="input.head.b_insert" mark="Y"/>}
                  #end add-point

                INSERT INTO gzxa_t (gzxaent,gzxa001,gzxa002,gzxa003,gzxastus,
                                      gzxa010,gzxa007,gzxa011,gzxa013,
                                      gzxa005,gzxa008,gzxa009,gzxa016,gzxa017,
                                      gzxaownid,gzxaowndp,gzxacrtid,gzxacrtdp,gzxacrtdt,
                                      gzxamodid,gzxamoddt)
                              VALUES (g_enterprise,g_gzxa_m.gzxa001,g_gzxa_m.gzxa002,g_gzxa_m.gzxa003,g_gzxa_m.gzxastus,
                                      g_gzxa_m.gzxa010,g_gzxa_m.gzxa007,g_gzxa_m.gzxa011,g_gzxa_m.gzxa013,
                                      g_gzxa_m.gzxa005,g_gzxa_m.gzxa008,g_gzxa_m.gzxa009,g_gzxa_m.gzxa016,g_gzxa_m.gzxa017,
                                      g_gzxa_m.gzxaownid,g_gzxa_m.gzxaowndp,g_gzxa_m.gzxacrtid,g_gzxa_m.gzxacrtdp,g_gzxa_m.gzxacrtdt,
                                      g_gzxa_m.gzxamodid,g_gzxa_m.gzxamoddt) # DISK WRITE

                  #add-point:單頭新增中
                  {<point name="input.head.m_insert"/>}
                  #end add-point
                  


                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "gzxa_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CONTINUE DIALOG
                  END IF
                  
                  CALL azzi800_gzxz_t('u')
                  #密碼加密
                  #161220-00012#1 -start   #161228-00003#1
                  IF cl_get_para(g_enterprise,"","E-SYS-2010") IS NOT NULL AND cl_get_para(g_enterprise,"","E-SYS-2010") = "Y" THEN
                     INSERT INTO gzxs_t(gzxsent,gzxs001,gzxs002)
                     VALUES(g_enterprise,g_gzxa_m.gzxa001,g_gzxa_m.gzxa001)
                     IF SQLCA.SQLCODE THEN
                        DISPLAY "ins gzxs:",SQLCA.SQLCODE,":",SQLERRMESSAGE
                     END IF
                  END IF
                  #161220-00012#1 -end
                  LET lc_gzxd002 = cl_hashkey_user_encode(g_gzxa_m.gzxa001)
                  INSERT INTO gzxd_t(gzxdent,gzxd001,gzxd002,gzxd003,gzxd004,gzxdstus)
                     VALUES(g_enterprise,g_gzxa_m.gzxa001,lc_gzxd002,g_today,'Y','Y') # DISK WRITE
                  
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "gzxa_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CONTINUE DIALOG
                  END IF 
                  #161206-00028
                  CALL s_azzi800_01_insert_os_user(g_gzxa_m.gzxa001,g_gzxa_m.gzxa001)
                  #資料多語言用-增/改


                  #add-point:單頭新增後
                  {<point name="input.head.a_insert"/>}
                  LET g_gzxa003_d = g_gzxa_m.gzxa003
                  
                  #end add-point

                  CALL s_transaction_end('Y','0')
               ELSE
                  CALL s_transaction_end('N','0')  #161220-00012#1
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  "std-00006"
                  LET g_errparam.extend =  "g_gzxa_m.gzxa001"
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
               END IF
            ELSE
               #add-point:單頭修改前
               {<point name="input.head.b_update" mark="Y"/>}
               #end add-point
                UPDATE gzxa_t SET (
                        gzxa001,gzxa002,gzxa003,gzxastus,gzxa010,gzxa007,gzxa011,gzxa013,
                        gzxa005,gzxa008,gzxa009,gzxa016,gzxa017,
                        gzxaownid,gzxaowndp,gzxacrtid,gzxacrtdp,gzxacrtdt,gzxamodid,gzxamoddt) = (
                        g_gzxa_m.gzxa001,g_gzxa_m.gzxa002,g_gzxa_m.gzxa003,g_gzxa_m.gzxastus,g_gzxa_m.gzxa010,g_gzxa_m.gzxa007,g_gzxa_m.gzxa011,g_gzxa_m.gzxa013,
                        g_gzxa_m.gzxa005,g_gzxa_m.gzxa008,g_gzxa_m.gzxa009,g_gzxa_m.gzxa016,g_gzxa_m.gzxa017,g_gzxa_m.gzxaownid,g_gzxa_m.gzxaowndp,g_gzxa_m.gzxacrtid,g_gzxa_m.gzxacrtdp,g_gzxa_m.gzxacrtdt,g_gzxa_m.gzxamodid,g_gzxa_m.gzxamoddt)
                WHERE gzxaent = g_enterprise AND gzxa001 = g_gzxa001_t #

               #add-point:單頭修改中
               {<point name="input.head.m_update"/>}
               #end add-point
               IF SQLCA.sqlcode THEN
                  CALL s_transaction_end('N','0')   #161220-00012#1
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "gzxa_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               ELSE
                  CALL azzi800_gzxz_t('u')

                  #資料多語言用-增/改
                  CALL azzi800_01_gzxb001_batch_upate(g_gzxa_m.gzxa003,g_gzxa_m_t.gzxa003)   #161107-00022

                  #add-point:單頭修改後
                  {<point name="input.head.a_update"/>}
                  LET g_gzxa003_d = g_gzxa_m.gzxa003
                  #end add-point

                  CALL s_transaction_end('Y','0')
               END IF
            END IF
           #controlp
      END INPUT

      SUBDIALOG azz_azzi800_01.azzi800_01_input
      SUBDIALOG azz_azzi800_01.azzi800_01_1_input
      SUBDIALOG azz_azzi800_02.azzi800_02_input    
      
      # 為了doubleClick 進入modify可以順利跳入第二頁單身, 所以需要加工提醒DIALOG
      BEFORE DIALOG
         IF g_action_choice = "modify" THEN
            CASE g_appoint_detail
               WHEN "s_detail1_01"
                  NEXT FIELD gzxb002
               WHEN "s_detail1_02"
                  NEXT FIELD gzxe002
            END CASE
        END IF
      LET g_action_choice = ""

      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name, g_fld_name, g_lang)

      ON ACTION controlr
         CALL cl_show_req_fields()

      ON ACTION controls
         CALL cl_set_head_visible("","AUTO")

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
   #161107-00022 start
   IF NOT INT_FLAG THEN
      #單獨異動gzxa003 要把 g_wc = gzxa003='' 改成新的值，這樣重新刷新資料單頭才不會抓到舊值
      IF gi_gzxa003_flag THEN 
         LET gi_gzxa003_flag =  FALSE
         LET ls_str = "gzxa003='",g_gzxa_m_t.gzxa003,"'"  
         IF g_wc.getIndexOf(ls_str,1) THEN 
            LET g_wc = g_wc.subString(1,g_wc.getIndexOf(ls_str,1)-1),g_wc_gzxa003
         END IF 
      END IF
   END IF  
   #161107-00022 end
   #add-point:input段after input
   {<point name="input.after_input"/>}
   #end add-point

END FUNCTION

PRIVATE FUNCTION azzi800_reproduce()
   {<Local define>}
   DEFINE l_newno         LIKE gzxa_t.gzxa001
   DEFINE l_oldno         LIKE gzxa_t.gzxa001
   DEFINE l_new_gzxa003   LIKE gzxa_t.gzxa003
   DEFINE l_old_gzxa003   LIKE gzxa_t.gzxa003
   DEFINE l_master        type_g_gzxa_m         #RECORD LIKE gzxa_t.*
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE lc_gzxd002 LIKE gzxd_t.gzxd002  #密碼
 
   {</Local define>}

   #add-point:reproduce段define
   {<point name="reproduce.define"/>}
   #end add-point

   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF

  IF g_gzxa_m.gzxa001 IS NULL OR g_gzxa_m.gzxa003 IS NULL 

   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF

   LET g_gzxa001_t = g_gzxa_m.gzxa001


   CALL azzi800_set_entry("a")
   CALL azzi800_set_no_entry("a")

   INPUT l_newno,l_new_gzxa003    # FROM

   FROM gzxa001,gzxa003

        ATTRIBUTE(FIELD ORDER FORM)

      #add-point:複製段落開窗/欄位控管/自定義action
      {<point name="reproduce.action" />}
      #end add-point

      BEFORE INPUT
         #add-point:複製段落Before input
         {<point name="reproduce.before_input" />}
         #end add-point
         LET g_gzxa_m.gzxa003_desc = ""
         DISPLAY BY NAME g_gzxa_m.gzxa003_desc 
         LET g_gzxa_m.gzxa005 = ""                 #161214-00012 #4 add
         DISPLAY BY NAME g_gzxa_m.gzxa005          #161214-00012 #4 add
      AFTER FIELD gzxa001
         IF l_newno IS NULL THEN
            NEXT FIELD CURRENT
         END IF
         #add-point:AFTER FIELD gzxa001
         {<point name="reproduce.a.gzxa001" />}
         #end add-point

       AFTER FIELD gzxa003
         IF l_new_gzxa003 IS NULL THEN
            NEXT FIELD CURRENT
         END IF

      #add-point:More_input
      {<point name="reproduce.more_input" />}
      #end add-point
      
      ON ACTION controlp INFIELD gzxa003
    
         #開窗i段
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'i'
         LET g_qryparam.reqry = FALSE
         #LET g_qryparam.default1 = g_gzxa_m.gzxa003      #給予default值
         #給予arg
         CALL q_ooag001_3()                               #呼叫開窗
         LET l_new_gzxa003 = g_qryparam.return1        #將開窗取得的值回傳到變數
         DISPLAY l_new_gzxa003 TO gzxa003              #顯示到畫面上
         NEXT FIELD gzxa003 
         
      AFTER INPUT
         #若取消則直接結束
         IF INT_FLAG = 1 THEN
            LET INT_FLAG = 0
            RETURN
         END IF

         #確定該key值是否有重複定義
         IF l_newno IS NULL THEN
            NEXT FIELD gzxa001
         END IF

         IF l_new_gzxa003 IS NULL THEN 
            NEXT FIELD gzxa003 
         END IF  
         LET l_cnt = 0
         SELECT COUNT(1) INTO l_cnt FROM gzxa_t
          WHERE gzxaent = g_enterprise AND gzxa001 = l_newno

         IF l_cnt > 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "std-00006"
            LET g_errparam.extend = "Reproduce"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            NEXT FIELD gzxa001
         END IF
              
         LET l_cnt = 0
         SELECT COUNT(1) INTO l_cnt FROM ooag_t
          WHERE ooagent = g_enterprise
            AND ooag001 = l_new_gzxa003
         IF l_cnt = 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "aim-00069"
            LET g_errparam.extend = "Reproduce"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            NEXT FIELD gzxa003
         END IF            
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE INPUT
   END INPUT

   IF INT_FLAG OR l_newno IS NULL THEN
      LET INT_FLAG = 0
      RETURN
   END IF

   CALL s_transaction_begin()

   SELECT gzxastus,gzxa001,gzxa002,gzxa003,
          gzxa005,gzxa007,gzxa008,gzxa009,gzxa010,
          gzxa011,gzxa013,gzxa016,gzxa017,gzxaownid,
          gzxaowndp,gzxacrtid,gzxacrtdp,gzxacrtdt,gzxamodid,
          gzxamoddt 
     INTO l_master.gzxastus,l_master.gzxa001,l_master.gzxa002,l_master.gzxa003,
          l_master.gzxa005,l_master.gzxa007,l_master.gzxa008,l_master.gzxa009,l_master.gzxa010,
           l_master.gzxa011,l_master.gzxa013,l_master.gzxa016,l_master.gzxa017,l_master.gzxaownid,
           l_master.gzxaowndp,l_master.gzxacrtid,l_master.gzxacrtdp,l_master.gzxacrtdt,l_master.gzxamodid,
           l_master.gzxamoddt
     FROM gzxa_t     
      WHERE gzxaent = g_enterprise AND gzxa001 = g_gzxa_m.gzxa001


   LET l_master.gzxa001 = l_newno
   LET l_master.gzxa003 = l_new_gzxa003

   #公用欄位給予預設值
   #此段落由子樣板a13產生
      LET l_master.gzxaownid = g_user
      LET l_master.gzxaowndp = g_dept
      LET l_master.gzxacrtid = g_user
      LET l_master.gzxacrtdp = g_dept
      LET l_master.gzxacrtdt = cl_get_current()
      LET l_master.gzxamodid = "" 
      LET l_master.gzxamoddt = "" 

   #add-point:單頭複製前
   {<point name="reproduce.head.b_insert" mark="Y"/>}
   
   #end add-point

   INSERT INTO gzxa_t(gzxastus,gzxa001,gzxa002,gzxa003,
                      gzxa005,gzxa007,gzxa008,gzxa009,gzxa010,
                      gzxa011,gzxa013,gzxa016,gzxa017,gzxaownid,
                      gzxaowndp,gzxacrtid,gzxacrtdp,gzxacrtdt,gzxamodid,
                      gzxamoddt,gzxaent)
              VALUES(l_master.gzxastus,l_master.gzxa001,l_master.gzxa002,l_master.gzxa003,
                     l_master.gzxa005,l_master.gzxa007,l_master.gzxa008,l_master.gzxa009, l_master.gzxa010,
                     l_master.gzxa011,l_master.gzxa013,l_master.gzxa016,l_master.gzxa017,l_master.gzxaownid,
                     l_master.gzxaowndp,l_master.gzxacrtid,l_master.gzxacrtdp,l_master.gzxacrtdt,l_master.gzxamodid,
                     l_master.gzxamoddt,g_enterprise)     
   

   #add-point:單頭複製中
   {<point name="reproduce.head.m_insert"/>}
   #end add-point

   IF SQLCA.sqlcode THEN
      CALL s_transaction_end('N','0')   #161220-00012#1
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "gzxa_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF
   

   #add-point:單頭複製後
   {<point name="reproduce.head.a_insert"/>}
   #複製單身
   LET g_gzxa_m.gzxa001 = l_newno
   LET g_gzxa001_t = g_gzxa_m.gzxa001
   LET g_gzxa_m.gzxa003 = l_new_gzxa003
   LET l_cnt = azzi800_cnt_gzxb001(l_new_gzxa003)
   #gzxb001 沒有資料 要insert gzxb_t
   IF l_cnt = 0 THEN
      IF NOT azzi800_detail_reproduce() THEN 
         CALL s_transaction_end('N','0')
         RETURN 
      END IF
   END IF   
   #end add-point

   CALL azzi800_gzxz_t('u')
   #密碼加密
   #161220-00012#1 -start   #161228-00003#1
   IF cl_get_para(g_enterprise,"","E-SYS-2010") IS NOT NULL AND cl_get_para(g_enterprise,"","E-SYS-2010") = "Y" THEN
      INSERT INTO gzxs_t(gzxsent,gzxs001,gzxs002)
      VALUES(g_enterprise,l_master.gzxa001,l_master.gzxa001)
      IF SQLCA.SQLCODE THEN
         DISPLAY "ins gzxs:",SQLCA.SQLCODE,":",SQLERRMESSAGE
      END IF
   END IF
   #161220-00012#1 -end
   LET lc_gzxd002 = cl_hashkey_user_encode(l_master.gzxa001)
   INSERT INTO gzxd_t(gzxdent,gzxd001,gzxd002,gzxd003,gzxd004,gzxdstus)
      VALUES(g_enterprise,l_master.gzxa001,lc_gzxd002,g_today,'Y','Y') # DISK WRITE
   
   IF SQLCA.sqlcode THEN
      CALL s_transaction_end('N','0')      #161220-00012#1
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "gzxd_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF
   #161206-00028
   CALL s_azzi800_01_insert_os_user(l_master.gzxa001,l_master.gzxa001)

   CALL s_transaction_end('Y','0')
   ERROR 'INSERT O.K'

   LET g_state = "Y"
   LET g_current_idx = 1 
   LET g_gzxa001_t = g_gzxa_m.gzxa001

   LET g_wc = g_wc,
              " OR (",
              " gzxa001 = '", l_newno CLIPPED, "' "

              , ") "

   #add-point:完成複製段落後
   {<point name="reproduce.after_reproduce" />}
   #end add-point

END FUNCTION

PRIVATE FUNCTION azzi800_show()
   #add-point:show段define
   {<point name="show.define"/>}
   DEFINE ls_wc   STRING
   #end add-point

   #add-point:show段之前
   {<point name="show.before"/>}
   #end add-point


   LET g_gzxa_m_t.* = g_gzxa_m.*      #保存單頭舊值

   #讀入ref值(單頭)
   #add-point:show段reference
            
   #end add-point

   #將資料輸出到畫面上
    DISPLAY BY NAME g_gzxa_m.gzxa001,g_gzxa_m.gzxa002,g_gzxa_m.gzxa003,g_gzxa_m.gzxa003_desc,
                   g_gzxa_m.gzxastus,g_gzxa_m.gzxa010,g_gzxa_m.gzxa007,g_gzxa_m.gzxa007_desc,
                   g_gzxa_m.gzxa011,g_gzxa_m.gzxa011_desc,g_gzxa_m.gzxa013,g_gzxa_m.gzxa013_desc,
                   g_gzxa_m.gzxa005,g_gzxa_m.gzxz002,g_gzxa_m.gzxz003,g_gzxa_m.gzxd004,g_gzxa_m.gzxz005,
                   g_gzxa_m.gzxz006,g_gzxa_m.gzxz007,g_gzxa_m.gzxa008,g_gzxa_m.gzxa009,g_gzxa_m.gzxa016,
                   g_gzxa_m.gzxa017,g_gzxa_m.gzxaownid,g_gzxa_m.gzxaownid_desc,g_gzxa_m.gzxaowndp,g_gzxa_m.gzxaowndp_desc,
                   g_gzxa_m.gzxacrtid,g_gzxa_m.gzxacrtid_desc,g_gzxa_m.gzxacrtdp,g_gzxa_m.gzxacrtdp_desc,
                   g_gzxa_m.gzxacrtdt,g_gzxa_m.gzxamodid,g_gzxa_m.gzxamodid_desc,g_gzxa_m.gzxamoddt

   #顯示狀態(stus)圖片
         #此段落由子樣板a21產生
      CASE g_gzxa_m.gzxastus
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")


      END CASE

   #在browser 移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()
   
   #add-point:show段之後
   {<point name="show.after"/>}


#T00 start 

   #嵌入
   #+ 角色配置配置可拜訪據點 第一單身
      IF cl_null(g_wc2_01) THEN
         LET g_wc2_01 = " 1=1"
      END IF
      LET g_gzxa003_d = g_gzxa_m.gzxa003
      LET ls_wc = g_wc2_01," AND gzxb001 = '", g_gzxa003_d CLIPPED,"'"
      CALL azzi800_01_b_fill(ls_wc)
      #+ 配置可拜訪據點 第二單身
      IF cl_null(g_wc3_01) THEN
         LET g_wc3_01 = " 1=1"
      END IF

      IF cl_null(g_wc2_02) THEN
         LET g_wc2_02 = " 1=1"
      END IF
      LET ls_wc = g_wc2_02," AND gzxe001 = '", g_gzxa003_d CLIPPED,"'"
      CALL azzi800_02_b_fill(ls_wc)
      
      CASE g_detail_id
         WHEN "cont_page"
            DISPLAY g_detail_idx_01, g_detail_cnt_01 TO FORMONLY.idx, FORMONLY.cnt
         WHEN "comm_page"
            DISPLAY g_detail_idx_02, g_detail_cnt_02 TO FORMONLY.idx, FORMONLY.cnt
      END CASE

#T00 end   

   #end add-point

END FUNCTION

PRIVATE FUNCTION azzi800_delete()
   {<Local define>}
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   {</Local define>}
   #add-point:delete段define
   {<point name="delete.define"/>}
   DEFINE  l_cnt           LIKE type_t.num5
   #end add-point

   IF g_gzxa_m.gzxa001 IS NULL

   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF
   IF g_gzxa_m.gzxa001 = "tiptop" OR g_gzxa_m.gzxa001 = "topstd" THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "azz-00320"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF 

   CALL s_transaction_begin()

   LET g_gzxa001_t = g_gzxa_m.gzxa001

   OPEN azzi800_cl USING g_enterprise,g_gzxa_m.gzxa001
   IF SQLCA.SQLCODE THEN
      CLOSE azzi800_cl
      CALL s_transaction_end('N','0')   #161220-00012#1
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN azzi800_cl:"
      LET g_errparam.popup = FALSE
      CALL cl_err()
      RETURN
   END IF

    EXECUTE azzi800_master_referesh USING g_enterprise,g_gzxa_m.gzxa001 
      INTO g_gzxa_m.gzxa001,g_gzxa_m.gzxa002,g_gzxa_m.gzxa003,g_gzxa_m.gzxastus,
           g_gzxa_m.gzxa010,g_gzxa_m.gzxa007,g_gzxa_m.gzxa007_desc,g_gzxa_m.gzxa011,g_gzxa_m.gzxa011_desc,
           g_gzxa_m.gzxa013,g_gzxa_m.gzxa013_desc,
           g_gzxa_m.gzxa005,
           g_gzxa_m.gzxa008,g_gzxa_m.gzxa009,g_gzxa_m.gzxa016,g_gzxa_m.gzxa017,g_gzxa_m.gzxaownid,
           g_gzxa_m.gzxaowndp,g_gzxa_m.gzxacrtid,g_gzxa_m.gzxacrtdp,g_gzxa_m.gzxacrtdt,
           g_gzxa_m.gzxamodid,g_gzxa_m.gzxamoddt,
           g_gzxa_m.gzxa003_desc, 
           g_gzxa_m.gzxaownid_desc,g_gzxa_m.gzxaowndp_desc,g_gzxa_m.gzxacrtid_desc,g_gzxa_m.gzxacrtdp_desc, 
           g_gzxa_m.gzxamodid_desc
           
   IF SQLCA.sqlcode THEN
      CALL s_transaction_end('N','0')    #161220-00012#1
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_gzxa_m.gzxa001
      LET g_errparam.popup = FALSE
      CALL cl_err()
      RETURN
   END IF
   
   CALL azzi800_show()

   IF cl_ask_del_master() THEN

      #重要的帳號不可以隨便亂刪除 tiptop/topstd
      IF g_gzxa_m.gzxa001 = "tiptop" OR g_gzxa_m.gzxa001 = "topstd" THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "azz-00166"
         LET g_errparam.replace[1] = g_gzxa_m.gzxa001
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN
      END IF 
   
      INITIALIZE g_doc.* TO NULL
      LET g_doc.column1 = "gzxa001"
      LET g_doc.value1 = g_gzxa_m.gzxa001
      CALL cl_doc_remove()
      
      DELETE FROM gzxa_t
       WHERE gzxaent = g_enterprise AND gzxa001 = g_gzxa_m.gzxa001

      IF SQLCA.sqlcode THEN
         CALL s_transaction_end('N','0')   #161220-00012#1
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "gzxa_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
      END IF

      CALL s_azzi000_gzxq_maintain("d", g_gzxa_m.gzxa001)

      CALL azzi800_gzxz_t('d') 

      #計算gzxa003 員工編號筆數  單頭對單身可能是多對一個關係 多個員工帳號可能對一個員工編號 
      LET l_cnt = azzi800_cnt_gzxa003(g_gzxa_m.gzxa003)
      #員工編號 = 0 要把單身一併刪除
      IF l_cnt = 0 THEN 
         CALL azzi800_01_gzxb001_batch_delete(g_gzxa_m.gzxa003)
         CALL azzi800_01_gzxe001_batch_delete(g_gzxa_m.gzxa003)
      END IF      
      #刪除使用者密碼設定檔
      DELETE FROM gzxd_t
        WHERE gzxdent = g_enterprise AND gzxd001 = g_gzxa_m.gzxa001
      #161220-00012#1 -start
      DELETE FROM gzxs_t
        WHERE gzxsent = g_enterprise AND gzxs001 = g_gzxa_m.gzxa001
      #161220-00012#1 -end

      CALL s_aooi723_set_bpmid(g_gzxa_m.gzxa001,'')   #160429-00013#7 add
   
      CLEAR FORM
      CALL azzi800_ui_browser_refresh()
      IF g_browser_cnt > 0 THEN
         CALL azzi800_fetch("P")
      ELSE
         LET g_wc = " 1=1 "
         CALL azzi800_browser_fill("F")
         CALL azzi800_fetch("F")
      END IF

   END IF

   CLOSE azzi800_cl
   CALL s_transaction_end('Y','0')

   #流程通知預埋點-D
   CALL cl_flow_notify(g_gzxa_m.gzxa001,"D")

END FUNCTION

PRIVATE FUNCTION azzi800_ui_browser_refresh()
   {<Local define>}
   DEFINE l_i  LIKE type_t.num10
   {</Local define>}

   #add-point:ui_browser_refresh段define
   {<point name="ui_browser_refresh.define"/>}
   #end add-point

   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_gzxa001 = g_gzxa_m.gzxa001 THEN
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

PRIVATE FUNCTION azzi800_set_entry(p_cmd)
   {<Local define>}
   DEFINE p_cmd LIKE type_t.chr1
   {</Local define>}

   #add-point:set_entry段define
   {<point name="set_entry.define"/>}
   #end add-point

   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("gzxa001",TRUE)
      #add-point:set_entry段欄位控制
      {<point name="set_entry.field_control"/>}
      #end add-point
   END IF

   #add-point:set_entry段欄位控制後
   {<point name="set_entry.after_control"/>}
   #end add-point

END FUNCTION

PRIVATE FUNCTION azzi800_set_no_entry(p_cmd)
   {<Local define>}
   DEFINE p_cmd LIKE type_t.chr1
   {</Local define>}

   #add-point:set_no_entry段define
   {<point name="set_no_entry.define"/>}
   #end add-point

   IF p_cmd = "u" THEN
      CALL cl_set_comp_entry("gzxa001",FALSE)
      #add-point:set_no_entry段欄位控制
      {<point name="set_no_entry.field_control"/>}
      #end add-point
   END IF

   #add-point:set_no_entry段欄位控制後
   {<point name="set_no_entry.after_control"/>}
   #end add-point

END FUNCTION

PRIVATE FUNCTION azzi800_default_search()
   {<Local define>}
   DEFINE li_idx  LIKE type_t.num5
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE ls_wc   STRING
   {</Local define>}
   #add-point:default_search段define
   {<point name="default_search.define"/>}
   #end add-point

   #add-point:default_search段開始前
   {<point name="default_search.before"/>}
   #end add-point

   LET g_pagestart = 1
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   IF NOT cl_null(g_argv[1]) THEN
      LET ls_wc = ls_wc, " gzxa001 = '", g_argv[1], "' AND "
   END IF

   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
   ELSE
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=1"
      END IF
   END IF

   #add-point:default_search段結束前
   {<point name="default_search.after"/>}
   #end add-point

END FUNCTION

PRIVATE FUNCTION azzi800_statechange()
   {<Local define>}
   DEFINE lc_state LIKE type_t.chr5
   {</Local define>}
   #add-point:statechange段define
   {<point name="statechange.define"/>}
   #end add-point

   #add-point:statechange段開始前
   {<point name="statechange.before"/>}
   #end add-point

   ERROR ""     #清空畫面右下側ERROR區塊

   IF g_gzxa_m.gzxa001 IS NULL

   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF

   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         CASE g_gzxa_m.gzxastus
            WHEN "Y"
               HIDE OPTION "active"
            WHEN "N"
               HIDE OPTION "inactive"

         END CASE

      #add-point:menu前
      {<point name="statechange.before_menu"/>}
      #end add-point
	
      ON ACTION active
         LET lc_state = "Y"
         #add-point:action控制
         {<point name="statechange.active"/>}
         #end add-point
         EXIT MENU
      ON ACTION inactive
         LET lc_state = "N"
         #add-point:action控制
         {<point name="statechange.inactive"/>}
         #end add-point
         EXIT MENU


	
      #add-point:stus控制
      {<point name="statechange.more_control"/>}
      #end add-point
	
   END MENU

   IF (lc_state <> "Y"
      AND lc_state <> "N"


      ) OR
      cl_null(lc_state) THEN
      RETURN
   END IF

   #add-point:stus修改前
   {<point name="statechange.b_update"/>}
   #end add-point

   UPDATE gzxa_t SET gzxastus = lc_state
    WHERE gzxaent = g_enterprise AND gzxa001 = g_gzxa_m.gzxa001


   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

   ELSE
      CASE lc_state
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")


      END CASE
   END IF

   #add-point:stus修改後
   {<point name="statechange.a_update"/>}
   #end add-point

   #add-point:statechange段結束前
   {<point name="statechange.after"/>}
   #end add-point

END FUNCTION

PUBLIC FUNCTION azzi800_replace_sub_window(ps_file,ps_rpd_comp,ps_rep_comp)
   DEFINE ps_file STRING
   DEFINE ps_rpd_comp STRING
   DEFINE ps_rep_comp STRING
   DEFINE lwin_curr ui.Window
   DEFINE lfrm_curr ui.Form
   DEFINE lnode_rep om.DomNode
   DEFINE lnode_rpd om.DomNode
   DEFINE lnode_parent om.DomNode

   # 必須先開啟畫面檔才能夠拿到AUI節點
   OPEN WINDOW subwin WITH FORM ps_file
   LET lwin_curr = ui.Window.getCurrent()
   LET lfrm_curr = lwin_curr.getForm()
   LET lnode_rep = lfrm_curr.findNode("Table", ps_rep_comp)
   IF lnode_rep IS NULL THEN
      RETURN
   END IF

   LET lnode_rpd = gfrm_curr.findNode("Grid", ps_rpd_comp)
   IF lnode_rpd IS NOT NULL THEN
      LET lnode_parent = lnode_rpd.getParent()
      CALL lnode_parent.replaceChild(lnode_rep, lnode_rpd)
   END IF

   CLOSE WINDOW subwin

END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: azzi800_gzxz_t(ps_type)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi800_gzxz_t(ps_type)
   DEFINE li_cnt    LIKE type_t.num10
   DEFINE ps_type   STRING  
   DEFINE ls_sql    STRING  

   IF ps_type = "s" THEN 
      LET ls_sql = "SELECT gzxz002,gzxz003,gzxz005,gzxz006,gzxz007,gzxz008,gzxz009,gzxz010 ",
                    " FROM gzxz_t WHERE gzxzent= ? AND gzxz001=? "
      DECLARE gzxz_t_cl CURSOR FROM ls_sql 
      OPEN gzxz_t_cl USING g_enterprise,g_gzxa_m.gzxa001
      FETCH gzxz_t_cl INTO g_gzxa_m.gzxz002,g_gzxa_m.gzxz003,g_gzxa_m.gzxz005,g_gzxa_m.gzxz006,
                           g_gzxa_m.gzxz007,g_gzxa_m.gzxz008,g_gzxa_m.gzxz009,g_gzxa_m.gzxz010
      IF SQLCA.sqlcode THEN
         LET g_gzxa_m.gzxz002 = NULL 
         LET g_gzxa_m.gzxz003 = NULL
         LET g_gzxa_m.gzxz005 = NULL 
         LET g_gzxa_m.gzxz006 = NULL 
         LET g_gzxa_m.gzxz007 = NULL 
         LET g_gzxa_m.gzxz008 = NULL 
         LET g_gzxa_m.gzxz009 = NULL 
         LET g_gzxa_m.gzxz010  = NULL
      END IF

      LET ls_sql = "SELECT gzxd004 FROM gzxd_t WHERE gzxdent= ? AND gzxd001=? "
      DECLARE gzxd_t_cl CURSOR FROM ls_sql 
      OPEN gzxd_t_cl USING g_enterprise,g_gzxa_m.gzxa001
      FETCH gzxd_t_cl INTO g_gzxa_m.gzxd004
      IF SQLCA.sqlcode THEN
         #LET g_gzxa_m.gzxd004 = NULL
         LET g_gzxa_m.gzxd004 = "N"           
      END IF

      RETURN 
   END IF 

   SELECT COUNT(1) INTO li_cnt FROM gzxz_t WHERE gzxzent = g_enterprise AND gzxz001 = g_gzxa001_t
   IF li_cnt = 0 AND ps_type = "u" THEN 
      INSERT INTO gzxz_t 
      (gzxzent,gzxz001,gzxz002,gzxz003,gzxz005,gzxz006,gzxz007,gzxz008,gzxz009,gzxz010 )
      VALUES (g_enterprise,g_gzxa_m.gzxa001,g_gzxa_m.gzxz002,g_gzxa_m.gzxz003,g_gzxa_m.gzxz005,
              g_gzxa_m.gzxz006,g_gzxa_m.gzxz007,g_gzxa_m.gzxz008,g_gzxa_m.gzxz009,g_gzxa_m.gzxz010 )
   END IF 

   IF li_cnt > 0 AND ps_type = "u" THEN 
      UPDATE gzxz_t SET 
      (gzxz001,gzxz002,gzxz003,gzxz005,gzxz006,gzxz007,gzxz008,gzxz009,gzxz010 ) = 
      (g_gzxa_m.gzxa001,g_gzxa_m.gzxz002,g_gzxa_m.gzxz003,g_gzxa_m.gzxz005,g_gzxa_m.gzxz006,g_gzxa_m.gzxz007,
       g_gzxa_m.gzxz008,g_gzxa_m.gzxz009,g_gzxa_m.gzxz010 ) 
      WHERE gzxzent = g_enterprise AND gzxz001 = g_gzxa001_t
   END IF 

   IF li_cnt > 0 AND ps_type = "d" THEN 
      DELETE FROM gzxz_t
       WHERE gzxzent = g_enterprise AND gzxz001 = g_gzxa001_t
   END IF 

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
   END IF
 
END FUNCTION

################################################################################
# Descriptions...: 複製單身
# Memo...........:
# Usage..........: CALL azzi800_detail_reproduce()
#                  RETURNING 
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 日期 By jrg542
# Modify.........: 160526-00010 #1  2016/05/26 By jrg542 azzi800 的複製功能，複製時gzxh_t(使用者定義執行作業功能明細) 漏掉
################################################################################
PRIVATE FUNCTION azzi800_detail_reproduce()
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE li_ok       LIKE type_t.num5
   DEFINE l_detail    RECORD LIKE gzxb_t.*
   DEFINE l_detail2   RECORD LIKE gzxc_t.*
   DEFINE l_detail3   RECORD LIKE gzxe_t.*
 
   LET li_ok = FALSE 

   LET ld_date = cl_get_current()
   
   DROP TABLE azzi800_detail
   
   #CREATE TEMP TABLE
   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE azzi800_detail AS ",
                "SELECT * FROM gzxb_t "
   PREPARE repro_tbl FROM ls_sql
   EXECUTE repro_tbl
   FREE repro_tbl
                
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO azzi800_detail SELECT * FROM gzxb_t 
                               WHERE gzxb001 = g_gzxa003_d AND gzxbent = g_enterprise
 
   #將key修正為調整後   
   UPDATE azzi800_detail 
      #更新key欄位
      SET gzxb001 = g_gzxa_m.gzxa003
      
      #更新共用欄位
      
   #將資料塞回原table   
   INSERT INTO gzxb_t SELECT * FROM azzi800_detail
   
   IF SQLCA.sqlcode THEN
      CALL s_transaction_end('N','0')    #161220-00012#1
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce:gzxb_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN li_ok
   END IF
   
   #刪除TEMP TABLE
   DROP TABLE azzi800_detail
   
   #CREATE TEMP TABLE
   LET ls_sql = 
      "CREATE GLOBAL TEMPORARY TABLE azzi800_detail AS ",
      "SELECT * FROM gzxc_t "
   PREPARE repro_tbl2 FROM ls_sql
   EXECUTE repro_tbl2
   FREE repro_tbl2
      
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO azzi800_detail SELECT * FROM gzxc_t
                               WHERE gzxc001 = g_gzxa003_d AND gzxcent = g_enterprise
 
   #將key修正為調整後   
   UPDATE azzi800_detail SET gzxc001 = g_gzxa_m.gzxa003
 
   #將資料塞回原table   
   INSERT INTO gzxc_t SELECT * FROM azzi800_detail

   IF SQLCA.sqlcode THEN
      CALL s_transaction_end('N','0')   #161220-00012#1
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce:gzxc_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN li_ok
   END IF
   
   #刪除TEMP TABLE
   DROP TABLE azzi800_detail
   
   #CREATE TEMP TABLE
   LET ls_sql = 
      "CREATE GLOBAL TEMPORARY TABLE azzi800_detail AS ",
      "SELECT * FROM gzxe_t "
   PREPARE repro_tbl3 FROM ls_sql
   EXECUTE repro_tbl3
   FREE repro_tbl3
      
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO azzi800_detail SELECT * FROM gzxe_t
                               WHERE gzxe001 = g_gzxa003_d AND gzxeent = g_enterprise
 
   #將key修正為調整後   
   UPDATE azzi800_detail SET gzxe001 = g_gzxa_m.gzxa003
 
   #將資料塞回原table   
   INSERT INTO gzxe_t SELECT * FROM azzi800_detail

   IF SQLCA.sqlcode THEN
      CALL s_transaction_end('N','0')    #161220-00012#1
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce:gzxe_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN li_ok
   END IF
   
   #刪除TEMP TABLE
   DROP TABLE azzi800_detail


   #CREATE TEMP TABLE
   LET ls_sql = 
      "CREATE GLOBAL TEMPORARY TABLE azzi800_detail AS ",
      "SELECT * FROM gzxh_t "
   PREPARE repro_tbl4 FROM ls_sql
   EXECUTE repro_tbl4
   FREE repro_tbl4

   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO azzi800_detail SELECT * FROM gzxh_t 
                               WHERE gzxh001 = g_gzxa003_d AND gzxhent = g_enterprise
 
   #將key修正為調整後   
   UPDATE azzi800_detail 
      #更新key欄位
      SET gzxh001 = g_gzxa_m.gzxa003
      
      #更新共用欄位
      
   #將資料塞回原table   
   INSERT INTO gzxh_t SELECT * FROM azzi800_detail
   
   IF SQLCA.sqlcode THEN
      CALL s_transaction_end('N','0')   #161220-00012#1
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce:gzxh_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN li_ok
   END IF

   LET li_ok = TRUE 
   RETURN li_ok
   #已新增完, 調整資料內容(修改時使用)
   #LET g_gzza001_t = g_gzza_m.gzza001
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzi800_cnt_gzxb001(pc_gzxa003)
#                  RETURNING l_cnt
# Input parameter: pc_gzxa003 員工編號
# Return code....: l_cnt
################################################################################
PRIVATE FUNCTION azzi800_cnt_gzxb001(pc_gzxa003)
   DEFINE pc_gzxa003 LIKE gzxa_t.gzxa003
   DEFINE l_cnt      LIKE type_t.num5
   
   SELECT COUNT(1) INTO l_cnt FROM gzxb_t
    WHERE gzxbent = g_enterprise 
      AND gzxb001 = pc_gzxa003

   RETURN l_cnt   
END FUNCTION

################################################################################
# Descriptions...: count員工編號
# Memo...........:
# Usage..........: CALL azzi800_cnt_gzxa003(pc_gzxa002,pc_gzxa003)
#                  RETURNING l_cnt
# Input parameter: pc_gzxa003 員工帳號 
# Return code....: l_cnt
################################################################################
PRIVATE FUNCTION azzi800_cnt_gzxa003(pc_gzxa003)
   DEFINE pc_gzxa002 LIKE gzxa_t.gzxa002
   DEFINE pc_gzxa003 LIKE gzxa_t.gzxa003
   DEFINE l_cnt      LIKE type_t.num5
   
   SELECT COUNT(1) INTO l_cnt FROM gzxa_t
    WHERE gzxaent = g_enterprise
      #AND gzxa002 = pc_gzxa002 
      AND gzxa003 = pc_gzxa003

   RETURN l_cnt
END FUNCTION

################################################################################
# Descriptions...: #假如更改員工編號，要去檢核預設據點編號是否存在，
#                   授權清單內(gzxc_t) 避免程式執行不起來
# Memo...........:
# Usage..........: CALL azzi800_chk_gzxa007(pc_gzxa003,pc_gzxa007)
#                  RETURNING 回传参数
# Input parameter: pc_gzxa003
#                : pc_gzxa007
# Return code....: 
# Date & Author..: 日期 By jrg542
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi800_chk_gzxa007(pc_gzxa003,pc_gzxa007)
   DEFINE pc_gzxa003 LIKE gzxa_t.gzxa003  #員工編號
   DEFINE pc_gzxa007 LIKE gzxa_t.gzxa007  #據點編號
   DEFINE li_cnt     LIKE type_t.num5

   SELECT COUNT(1) INTO li_cnt FROM gzxb_t
    INNER JOIN gzxc_t ON gzxbent = gzxcent
     AND gzxb001 = gzxc001 
     AND gzxb002 = gzxc002
     AND gzxb003 = gzxc003
    WHERE gzxc001 = pc_gzxa003 
     AND  gzxcent = g_enterprise 
     AND  gzxc004 = pc_gzxa007

   IF li_cnt > 0 THEN 
      RETURN TRUE 
   END IF 

   RETURN FALSE 
END FUNCTION

################################################################################
# Descriptions...: 取得gzxa 使用者帳號已存在的資訊
# Memo...........:
# Usage..........: CALL azzi800_get_gzxa_exist_info()
#                  RETURNING 
# Input parameter: 传入参数变量1   传入参数变量说明1
# Return code....: 回传参数变量1   回传参数变量说明1
# Date & Author..: 2016/12/09 By jrg542
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi800_get_gzxa_exist_info()
   DEFINE ls_sql STRING 

   #LET ls_sql = "SELECT gzxa007,gzxa011,gzxa013,gzxa005,gzxa017",        #161214-00012 #4 mark
   LET ls_sql = "SELECT gzxa007,gzxa011,gzxa013,gzxa017",                 #161214-00012 #4 add
                " FROM gzxa_t ",
                " WHERE gzxaent =",g_enterprise ,
                "  AND gzxa002 = '",g_gzxa_m.gzxa002 ,"'",
                "  AND gzxa003 = '",g_gzxa_m.gzxa003 ,"'"

   DECLARE azzi800_get_gzxa_cs CURSOR FROM ls_sql

   #FOREACH azzi800_get_gzxa_cs INTO g_gzxa_m.gzxa007,g_gzxa_m.gzxa011,g_gzxa_m.gzxa013,g_gzxa_m.gzxa005,g_gzxa_m.gzxa017    #161214-00012 #4 mark
   FOREACH azzi800_get_gzxa_cs INTO g_gzxa_m.gzxa007,g_gzxa_m.gzxa011,g_gzxa_m.gzxa013,g_gzxa_m.gzxa017                      #161214-00012 #4 add
      EXIT FOREACH 
   END FOREACH 
   
   CLOSE azzi800_get_gzxa_cs
END FUNCTION

#end add-point
 
{</section>}
 
