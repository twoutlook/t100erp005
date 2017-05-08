#該程式未解開Section, 採用最新樣板產出!
{<section id="artp409.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2016-07-02 18:07:11), PR版次:0004(2016-09-18 10:21:08)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000025
#+ Filename...: artp409
#+ Description: 商戶商品屬性批量更新作業
#+ Creator....: 02439(2016-07-02 18:07:11)
#+ Modifier...: 02439 -SD/PR- 08742
 
{</section>}
 
{<section id="artp409.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#Memos
#160902-00020#1    2016/09/09   by 08742   解决资料已经成功抛转，下方整体完成进度还是0%
#160913-00034#5    2016/09/14   by 08742   q_pmaa001開窗改成 q_pmaa001_1 抓类型= 3，同时修改栏位控管
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc" 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
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
   #add-point:自定背景執行須傳遞的參數(Module Variable) name="global.parameter"
   
   #end add-point
        wc               STRING
                     END RECORD
 
TYPE type_g_detail_d RECORD
#add-point:自定義模組變數(Module Variable)  #注意要在add-point內寫入END RECORD name="global.variable"
   sel            LIKE type_t.chr1,
   rtemsite       LIKE rtem_t.rtemsite,
   rtem001        LIKE rtem_t.rtem001,
   rtem002        LIKE rtem_t.rtem002,
   imaa014        LIKE imaa_t.imaa014,
   rtem003        LIKE rtem_t.rtem003,
   rtem003_desc   LIKE imaal_t.imaal003,
   rtem003_desc1  LIKE imaal_t.imaal004,
   imaa009        LIKE imaa_t.imaa009,
   rtem004        LIKE rtem_t.rtem004,
   rtem005        LIKE rtem_t.rtem005,
   rtem006        LIKE rtem_t.rtem006,
   rtem007        LIKE rtem_t.rtem007,
   rtem008        LIKE rtem_t.rtem008,
   rtem009        LIKE rtem_t.rtem009,
   rtem010        LIKE rtem_t.rtem010,
   rtem011        LIKE rtem_t.rtem011,
   rtem012        LIKE rtem_t.rtem012,
   rtem013        LIKE rtem_t.rtem013
   END RECORD
   
DEFINE g_clearmode      LIKE type_t.chr1,
       g_importmode     LIKE type_t.chr1
DEFINE g_rtem004        LIKE rtem_t.rtem004,
       g_rtem005        LIKE rtem_t.rtem005,
       g_rtem006        LIKE rtem_t.rtem006,
       g_rtem007        LIKE rtem_t.rtem007,
       g_rtem008        LIKE rtem_t.rtem008,
       g_rtem009        LIKE rtem_t.rtem009,
       g_rtem010        LIKE rtem_t.rtem010,
       g_rtem011        LIKE rtem_t.rtem011,
       g_rtem012        LIKE rtem_t.rtem012,
       g_rtem013        LIKE rtem_t.rtem013
DEFINE g_detail_idx          LIKE type_t.num10
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="artp409.main" >}
#+ 作業開始 
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   DEFINE ls_js  STRING
   #add-point:main段define name="main.define"
   DEFINE l_success     LIKE type_t.num5
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("art","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_artp409 WITH FORM cl_ap_formpath("art",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL artp409_init()   
 
      #進入選單 Menu (="N")
      CALL artp409_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_artp409
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   DROP TABLE artp409_temp
   CALL s_aooi500_drop_temp() RETURNING l_success
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="artp409.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION artp409_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   DEFINE l_success     LIKE type_t.num5
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('clearmode','6949')
   CALL cl_set_combo_scc('importmode','6950')
   
   CALL artp409_create_temp()
   CALL s_aooi500_create_temp() RETURNING l_success
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="artp409.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION artp409_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
 
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL artp409_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT BY NAME g_wc ON rtemsite,rtem002,mhbe003,mhbe001,mhbe004,imaa009,mhbe005,imaa126,mhbe010,rtem003,
                                   rtem004,rtem005,rtem006,rtem007,rtem008,rtem009,rtem010,rtem011,rtem012,rtem013
            
               
            ON ACTION controlp INFIELD rtemsite       #门店编号
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtemsite',g_site,'c')
               CALL q_ooef001_24()                    #呼叫開窗
               DISPLAY g_qryparam.return1 TO rtemsite    #顯示到畫面上
               NEXT FIELD rtemsite
               
            ON ACTION controlp INFIELD rtem002        #商户编号
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               #160913-00034#5 -S
               #CALL q_pmaa001()                           #呼叫開窗            
               LET g_qryparam.arg1 = "('3')"            
               CALL q_pmaa001_1()                          #呼叫開窗
               #160913-00034#5 -E
               DISPLAY g_qryparam.return1 TO rtem002    #顯示到畫面上
               NEXT FIELD rtem002
               
            ON ACTION controlp INFIELD mhbe003        #楼栋编号
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_mhaa001()                    #呼叫開窗
               DISPLAY g_qryparam.return1 TO mhbe003    #顯示到畫面上
               NEXT FIELD mhbe003
               
            ON ACTION controlp INFIELD mhbe001        #铺位编号
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_mhbc001_1()                    #呼叫開窗
               DISPLAY g_qryparam.return1 TO mhbe001    #顯示到畫面上
               NEXT FIELD mhbe001
               
            ON ACTION controlp INFIELD mhbe004        #楼层编号
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_mhab002()                    #呼叫開窗
               DISPLAY g_qryparam.return1 TO mhbe004    #顯示到畫面上
               NEXT FIELD mhbe004
               
            ON ACTION controlp INFIELD imaa009        #品类编号
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_rtax001()                    #呼叫開窗
               DISPLAY g_qryparam.return1 TO imaa009    #顯示到畫面上
               NEXT FIELD imaa009
               
            ON ACTION controlp INFIELD mhbe005        #区域编号
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_mhac003()                    #呼叫開窗
               DISPLAY g_qryparam.return1 TO mhbe005    #顯示到畫面上
               NEXT FIELD mhbe005
               
            ON ACTION controlp INFIELD imaa126        #品牌编号
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_oocq002_2002()                    #呼叫開窗
               DISPLAY g_qryparam.return1 TO imaa126    #顯示到畫面上
               NEXT FIELD imaa126
               
            ON ACTION controlp INFIELD mhbe010        #铺位用途
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '2144'
               CALL q_oocq002()                    #呼叫開窗
               DISPLAY g_qryparam.return1 TO mhbe010    #顯示到畫面上
               NEXT FIELD mhbe010
               
            ON ACTION controlp INFIELD rtem003        #商品编号
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imaa001()                    #呼叫開窗
               DISPLAY g_qryparam.return1 TO rtem003    #顯示到畫面上
               NEXT FIELD rtem003
               
            ON ACTION controlp INFIELD rtem004        #商品属性一
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '2006'
               CALL q_oocq002()                    #呼叫開窗
               DISPLAY g_qryparam.return1 TO rtem004    #顯示到畫面上
               NEXT FIELD rtem004
               
            ON ACTION controlp INFIELD rtem005        #商品属性二
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '2007'
               CALL q_oocq002()                    #呼叫開窗
               DISPLAY g_qryparam.return1 TO rtem005    #顯示到畫面上
               NEXT FIELD rtem005
               
            ON ACTION controlp INFIELD rtem006        #商品属性三
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '2008'
               CALL q_oocq002()                    #呼叫開窗
               DISPLAY g_qryparam.return1 TO rtem006    #顯示到畫面上
               NEXT FIELD rtem006
               
            ON ACTION controlp INFIELD rtem007        #商品属性四
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '2009'
               CALL q_oocq002()                    #呼叫開窗
               DISPLAY g_qryparam.return1 TO rtem007    #顯示到畫面上
               NEXT FIELD rtem007
               
            ON ACTION controlp INFIELD rtem008        #商品属性五
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '2010'
               CALL q_oocq002()                    #呼叫開窗
               DISPLAY g_qryparam.return1 TO rtem008    #顯示到畫面上
               NEXT FIELD rtem008
               
            ON ACTION controlp INFIELD rtem009        #商品属性六
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '2011'
               CALL q_oocq002()                    #呼叫開窗
               DISPLAY g_qryparam.return1 TO rtem009    #顯示到畫面上
               NEXT FIELD rtem009
               
            ON ACTION controlp INFIELD rtem010        #商品属性七
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '2012'
               CALL q_oocq002()                    #呼叫開窗
               DISPLAY g_qryparam.return1 TO rtem010    #顯示到畫面上
               NEXT FIELD rtem010
               
            ON ACTION controlp INFIELD rtem011        #商品属性八
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '2013'
               CALL q_oocq002()                    #呼叫開窗
               DISPLAY g_qryparam.return1 TO rtem011    #顯示到畫面上
               NEXT FIELD rtem011
               
            ON ACTION controlp INFIELD rtem012        #商品属性九
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '2014'
               CALL q_oocq002()                    #呼叫開窗
               DISPLAY g_qryparam.return1 TO rtem012    #顯示到畫面上
               NEXT FIELD rtem012
               
            ON ACTION controlp INFIELD rtem013        #商品属性十
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '2015'
               CALL q_oocq002()                    #呼叫開窗
               DISPLAY g_qryparam.return1 TO rtem013    #顯示到畫面上
               NEXT FIELD rtem013
         END CONSTRUCT
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT g_clearmode,g_importmode FROM clearmode,importmode
            ON CHANGE importmode
               IF g_importmode='1' THEN
                  CALL cl_set_comp_visible('b_imaa014,b_rtem003,b_rtem003_desc,b_rtem003_desc_1',TRUE)
               ELSE
                  CALL cl_set_comp_visible('b_imaa014,b_rtem003,b_rtem003_desc,b_rtem003_desc_1',FALSE)
               END IF
         END INPUT
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_detail_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               DISPLAY g_detail_idx TO h_index
         END DISPLAY
         #end add-point
 
         BEFORE DIALOG
            IF g_detail_d.getLength() > 0 THEN
               CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
            ELSE
               CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
            END IF
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            CALL cl_set_comp_visible('sel',FALSE)
            CALL cl_set_act_visible("selall,selnone,sel,unsel", FALSE)
            
            IF cl_null(g_clearmode) THEN LET g_clearmode = '1' END IF
            IF cl_null(g_importmode) THEN LET g_importmode = '1' END IF
            DISPLAY g_clearmode TO clearmode
            DISPLAY g_importmode TO importmode
            #end add-point
 
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            #add-point:ui_dialog段on action selall name="ui_dialog.selall.befroe"
            
            #end add-point            
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
               #add-point:ui_dialog段on action selall name="ui_dialog.for.onaction_selall"
               
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "N"
               #add-point:ui_dialog段on action selnone name="ui_dialog.for.onaction_selnone"
               
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "Y"
               END IF
            END FOR
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
            END FOR
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL artp409_filter()
            #add-point:ON ACTION filter name="menu.filter"
            
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
            #add-point:ui_dialog段accept之前 name="menu.filter"
            
            #end add-point
            CALL artp409_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL artp409_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         
           
            
            
         ON ACTION importfromexcel
            LET g_action_choice="importfromexcel"
            CALL artp409_importfromexcel()
            
         ON ACTION execupdate
            LET g_action_choice="execupdate"
            CALL artp409_execupdate()
            
         ON ACTION preview
            LET g_action_choice="preview"
            LET g_rtem004 = GET_FLDBUF(rtem004)
            LET g_rtem005 = GET_FLDBUF(rtem005)
            LET g_rtem006 = GET_FLDBUF(rtem006)
            LET g_rtem007 = GET_FLDBUF(rtem007)
            LET g_rtem008 = GET_FLDBUF(rtem008)
            LET g_rtem009 = GET_FLDBUF(rtem009)
            LET g_rtem010 = GET_FLDBUF(rtem010)
            LET g_rtem011 = GET_FLDBUF(rtem011)
            LET g_rtem012 = GET_FLDBUF(rtem012)
            LET g_rtem013 = GET_FLDBUF(rtem013)
            
            CASE artp409_oocq_chk()
               WHEN 'rtem004'
                  NEXT FIELD rtem004
               WHEN 'rtem005'
                  NEXT FIELD rtem005
               WHEN 'rtem006'
                  NEXT FIELD rtem006
               WHEN 'rtem007'
                  NEXT FIELD rtem007
               WHEN 'rtem008'
                  NEXT FIELD rtem008
               WHEN 'rtem009'
                  NEXT FIELD rtem009
               WHEN 'rtem010'
                  NEXT FIELD rtem010
               WHEN 'rtem011'
                  NEXT FIELD rtem011
               WHEN 'rtem012'
                  NEXT FIELD rtem012
               WHEN 'rtem013'
                  NEXT FIELD rtem013
            END CASE
            CALL artp409_preview()
            
         ON ACTION dl_templet
            LET g_action_choice="dl_templet"
            CALL artp409_dl_templet()
         #end add-point
 
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
 
      #(ver:22) ---start---
      #add-point:ui_dialog段 after dialog name="ui_dialog.exit_dialog"
      
      #end add-point
      #(ver:22) --- end ---
 
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         #(ver:22) ---start---
         #add-point:ui_dialog段離開dialog前 name="ui_dialog.b_exit"
         
         #end add-point
         #(ver:22) --- end ---
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="artp409.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION artp409_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   DEFINE l_wc       STRING
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   DELETE FROM artp409_temp
   
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   
   LET l_wc = s_aooi500_sql_where(g_prog,'rtemsite')
   
   LET g_wc = g_wc,' AND ',l_wc
   
   IF g_importmode='1' THEN
      LET g_sql = "INSERT INTO artp409_temp(rtement,rtemsite,rtem001,rtem002,imaa014,rtem003,imaal003,imaal004,imaa009,rtem004, ",
                  "                         rtem005,rtem006,rtem007,rtem008,rtem009,rtem010,rtem011,rtem012,rtem013) ",
                  " SELECT rtement,rtemsite,rtem001,rtem002,imaa014,rtem003,imaal003,imaal004,imaa009,rtem004, ",
                  "        rtem005,rtem006,rtem007,rtem008,rtem009,rtem010,rtem011,rtem012,rtem013 ",
                  "  FROM rtem_t,mhbe_t,imaa_t ",
                  "  LEFT JOIN imaal_t ON (imaalent = imaaent AND imaal001 = imaa001 AND imaal002='",g_dlang,"') ",
                  " WHERE rtement = ",g_enterprise,
                  "   AND rtement = mhbeent ",
                  "   AND rtem001 = mhbe001 ",
                  "   AND rtement = imaaent ",
                  "   AND rtem003 = imaa001 ",
                  "   AND ",g_wc
   ELSE
      LET g_sql = "INSERT INTO artp409_temp(rtement,rtemsite,rtem001,rtem002,imaa014,rtem003,imaal003,imaal004,imaa009,rtem004, ",
                  "                         rtem005,rtem006,rtem007,rtem008,rtem009,rtem010,rtem011,rtem012,rtem013) ",
                  " SELECT DISTINCT rtement,rtemsite,rtem001,rtem002,'','','','',imaa009,'', ",
                  "        '','','','','','','','','' ",
                  "  FROM rtem_t,mhbe_t,imaa_t ",
                  " WHERE rtement = ",g_enterprise,
                  "   AND rtement = mhbeent ",
                  "   AND rtem001 = mhbe001 ",
                  "   AND rtement = imaaent ",
                  "   AND rtem003 = imaa001 ",
                  "   AND ",g_wc
   END IF
               
   TRY
      EXECUTE IMMEDIATE g_sql
   CATCH
      IF STATUS THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = STATUS 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         RETURN
      END IF
   END TRY
   #end add-point
        
   LET g_error_show = 1
   CALL artp409_b_fill()
   LET l_ac = g_master_idx
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = -100 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
   END IF
   
   #add-point:cs段after_query name="query.cs_after_query"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="artp409.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION artp409_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   
   LET g_sql = "SELECT 'N',rtemsite,rtem001,rtem002,imaa014,rtem003,imaal003,imaal004,imaa009,rtem004, ",
               "        rtem005,rtem006,rtem007,rtem008,rtem009,rtem010,rtem011,rtem012,rtem013 ",
               "  FROM artp409_temp ",
               " WHERE rtement = ? ",
               " ORDER BY rtemsite,rtem001,rtem002,rtem003 "
   #end add-point
 
   PREPARE artp409_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR artp409_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
      g_detail_d[l_ac].sel,g_detail_d[l_ac].rtemsite,g_detail_d[l_ac].rtem001,g_detail_d[l_ac].rtem002,g_detail_d[l_ac].imaa014,
      g_detail_d[l_ac].rtem003,g_detail_d[l_ac].rtem003_desc,g_detail_d[l_ac].rtem003_desc1,g_detail_d[l_ac].imaa009,
      g_detail_d[l_ac].rtem004,g_detail_d[l_ac].rtem005,g_detail_d[l_ac].rtem006,g_detail_d[l_ac].rtem007,g_detail_d[l_ac].rtem008,
      g_detail_d[l_ac].rtem009,g_detail_d[l_ac].rtem010,g_detail_d[l_ac].rtem011,g_detail_d[l_ac].rtem012,g_detail_d[l_ac].rtem013
   #end add-point
   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #add-point:b_fill段資料填充 name="b_fill.foreach_iside"
      
      #end add-point
      
      CALL artp409_detail_show()      
 
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
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.other_table"
   CALL g_detail_d.deleteElement(g_detail_d.getLength())
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE artp409_sel
   
   LET l_ac = 1
   CALL artp409_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="artp409.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION artp409_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define name="fetch.define"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後 name="fetch.after_fill"
   
   #end add-point 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="artp409.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION artp409_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="artp409.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION artp409_filter()
   #add-point:filter段define(客製用) name="filter.define_customerization"
   
   #end add-point    
   #add-point:filter段define name="filter.define"
   
   #end add-point
   
   DISPLAY ARRAY g_detail_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
      ON UPDATE
 
   END DISPLAY
 
   LET l_ac = 1
   LET g_detail_cnt = 1
   #add-point:filter段define name="filter.detail_cnt"
   
   #end add-point    
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   
   CALL artp409_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="artp409.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION artp409_filter_parser(ps_field)
   #add-point:filter段define(客製用) name="filter_parser.define_customerization"
   
   #end add-point    
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num10
   DEFINE li_tmp2    LIKE type_t.num10
   DEFINE ls_var     STRING
   #add-point:filter段define name="filter_parser.define"
   
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
 
{<section id="artp409.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION artp409_filter_show(ps_field,ps_object)
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
   LET ls_condition = artp409_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="artp409.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 创建临时表
# Memo...........:
# Usage..........: CALL artp409_create_temp()
#                  RETURNING 
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/07/03 by lvjh
# Modify.........:
################################################################################
PRIVATE FUNCTION artp409_create_temp()
   DROP TABLE artp409_temp
   
   CREATE TEMP TABLE artp409_temp(
      rtement     LIKE rtem_t.rtement,
      rtemsite       LIKE rtem_t.rtemsite,
      rtem001        LIKE rtem_t.rtem001,
      rtem002        LIKE rtem_t.rtem002,
      imaa014        LIKE imaa_t.imaa014,
      rtem003        LIKE rtem_t.rtem003,
      imaal003       LIKE imaal_t.imaal003,
      imaal004       LIKE imaal_t.imaal004,
      imaa009        LIKE imaa_t.imaa009,
      rtem004        LIKE rtem_t.rtem004,
      rtem005        LIKE rtem_t.rtem005,
      rtem006        LIKE rtem_t.rtem006,
      rtem007        LIKE rtem_t.rtem007,
      rtem008        LIKE rtem_t.rtem008,
      rtem009        LIKE rtem_t.rtem009,
      rtem010        LIKE rtem_t.rtem010,
      rtem011        LIKE rtem_t.rtem011,
      rtem012        LIKE rtem_t.rtem012,
      rtem013        LIKE rtem_t.rtem013
   )
END FUNCTION

################################################################################
# Descriptions...: 导入EXCEL
# Memo...........:
# Usage..........: CALL artp409_importfromexcel()
#                  RETURNING 
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/07/03 by lvjh
# Modify.........:
################################################################################
PRIVATE FUNCTION artp409_importfromexcel()
   DEFINE ls_str                 STRING,
          ls_file                STRING,
          ls_location            STRING
   DEFINE l_success              LIKE type_t.chr1
   DEFINE xlapp,iRes,iRow,i,j    INTEGER
   DEFINE sValue                 STRING
   DEFINE gs_location            STRING
   DEFINE g_fileloc              STRING
   DEFINE p_row,p_col,l_n        LIKE type_t.num10
   DEFINE l_msg                  STRING
   DEFINE l_cnt                  LIKE type_t.num10
   DEFINE l_detail               type_g_detail_d
   DEFINE l_sql                  STRING
   DEFINE l_msg1                 LIKE type_t.chr100  #160902-00020#1 add
   
   WHENEVER ERROR CALL cl_err_msg_log
   
   LET l_success = 'Y'
   CALL cl_err_collect_init()
   DELETE FROM artp409_temp
   
   #获取EXCEL文档所在位置
   CALL ui.Interface.frontCall("standard","openfile",["C:", "All Files", "*.*", "File Browser"],[gs_location])
   #160902-00020#1 -S
   CALL cl_progress_bar_no_window(2)
   LET l_msg1 = cl_getmsg('ade-00114',g_lang)
   CALL cl_progress_no_window_ing(l_msg1) 
   #160902-00020#1 -E
   LET g_fileloc=gs_location
   
   IF cl_null(g_fileloc) THEN RETURN END IF
   
   IF l_success='Y' THEN
   #创建EXCEL实例进程
      #MS OFFICE EXCEL
      CALL ui.interface.frontCall('WinCOM','CreateInstance',['Excel.Application'],[xlApp])
      IF xlApp = -1 THEN
         #KS WPS 9.0 KET
         CALL ui.interface.frontCall('WinCOM','CreateInstance',['Ket.Application'],[xlApp])
      END IF
      IF xlApp = -1 THEN
         #KS WPS 8.0及以下 ET
         CALL ui.interface.frontCall('WinCOM','CreateInstance',['ET.Application'],[xlApp])
      END IF
      IF xlApp <> -1 THEN
         #打开EXCEL文件
         CALL ui.interface.frontCall('WinCOM','CallMethod',[xlApp,'Workbooks.Open',g_fileloc],[iRes])
         IF iRes <> -1 THEN
            #获取EXCEL中的行数
            CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.UsedRange.Rows.Count'],[iRow])
            
            IF iRow > 1 THEN
               #显示进度条，EXCEL中有多少行不算正式数据就减多少
               CALL cl_progress_bar(iRow-1)
               
               FOR i = 2 TO iRow
                  CALL cl_progress_ing('正在导入第'||i||'行数据')
                 
                  INITIALIZE l_detail.* TO NULL
                 
                  CALL ui.interface.frontcall('WinCOM','GetProperty',
                                              [xlApp,'ActiveSheet.Range("A'||i||':O'||i||'").value'],
                                              [l_detail.rtem013,l_detail.rtem012,l_detail.rtem011,l_detail.rtem010,l_detail.rtem009,
                                               l_detail.rtem008,l_detail.rtem007,l_detail.rtem006,l_detail.rtem005,l_detail.rtem004,
                                               l_detail.imaa009,l_detail.rtem003,l_detail.rtem002,l_detail.rtem001,l_detail.rtemsite])
                 
                  LET l_msg = "导入excel中第",i,"行数据失败"
                 
                  #------------------------EXCEL数据检核 . st---------------------------
                  IF cl_null(l_detail.rtem001) AND cl_null(l_detail.rtem002) AND cl_null(l_detail.rtem003) AND cl_null(l_detail.imaa009) THEN
                     CONTINUE FOR
                  END IF
                  
                  IF cl_null(l_detail.rtem001) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = '-1100'
                     LET g_errparam.extend = l_msg,',铺位编号为空'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET l_success = 'N'
                     EXIT FOR
                  END IF
                  
                  IF cl_null(l_detail.rtem002) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = '-1100'
                     LET g_errparam.extend = l_msg,',商户编号为空'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET l_success = 'N'
                     EXIT FOR
                  END IF
                  
                  IF g_importmode='1' AND cl_null(l_detail.rtem003) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = '-1100'
                     LET g_errparam.extend = l_msg,',商品编号为空'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET l_success = 'N'
                     EXIT FOR
                  END IF
                  
                  IF g_importmode='2' AND cl_null(l_detail.imaa009) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = '-1100'
                     LET g_errparam.extend = l_msg,',品类编号为空'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET l_success = 'N'
                     EXIT FOR
                  END IF
                  #------------------------EXCEL数据检核 . ed---------------------------
                  
                
                  INSERT INTO artp409_temp(rtement,rtemsite,rtem001,rtem002,imaa014,rtem003,imaal003,imaal004,imaa009,rtem004,
                                           rtem005,rtem006,rtem007,rtem008,rtem009,rtem010,rtem011,rtem012,rtem013)
                                   VALUES(g_enterprise,l_detail.rtemsite,l_detail.rtem001,l_detail.rtem002,l_detail.imaa014,l_detail.rtem003,
                                          l_detail.rtem003_desc,l_detail.rtem003_desc1,l_detail.imaa009,l_detail.rtem004,l_detail.rtem005,l_detail.rtem006,
                                          l_detail.rtem007,l_detail.rtem008,l_detail.rtem009,l_detail.rtem010,l_detail.rtem011,l_detail.rtem012,
                                          l_detail.rtem013)
               
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = l_msg
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET l_success = 'N'
                     EXIT FOR
                  END IF
               END FOR
            END IF
         ELSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = '-21407'
            LET g_errparam.extend = '打开文件失败，NO FILE'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_success = 'N'
            DISPLAY 'NO FILE'
         END IF
      ELSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = '-21407'
         LET g_errparam.extend = '打开文件失败，NO EXCEL'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET l_success = 'N'
   	   DISPLAY 'NO EXCEL'
      END IF 
   
      CALL ui.interface.frontCall('WinCOM','CallMethod',[xlApp,'Quit'],[iRes])
      CALL ui.interface.frontCall('WinCOM','ReleaseInstance',[xlApp],[iRes])
      
      IF i<iRow THEN
         CALL cl_progress_bar_close()
      END IF
      
      IF l_success='Y' THEN
         LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt FROM artp409_temp
         IF l_cnt>0 THEN
            LET l_sql = " MERGE INTO (SELECT * FROM artp409_temp WHERE TRIM(rtemsite) IS NULL) a ",
                        " USING mhbe_t b ",
                        "    ON (a.rtement = b.mhbeent AND a.rtem001 = b.mhbe001) ",
                        "  WHEN MATCHED THEN ",
                        "       UPDATE SET a.rtemsite = b.mhbesite "
            TRY
               EXECUTE IMMEDIATE l_sql
            CATCH
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = STATUS
                  LET g_errparam.extend = 'upd rtemsite'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET l_success = 'N'
               END IF
            END TRY
            
            IF g_importmode='1' THEN
               LET l_sql = " MERGE INTO artp409_temp a ",
                           " USING imaa_t b ",
                           "    ON (a.rtement = b.imaaent AND a.rtem003 = b.imaa001) ",
                           "  WHEN MATCHED THEN ",
                           "       UPDATE SET a.imaa009 = b.imaa009,",
                           "                  a.imaa014 = b.imaa014 "
               TRY
                  EXECUTE IMMEDIATE l_sql
               CATCH
                  IF STATUS THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = STATUS
                     LET g_errparam.extend = 'upd imaa009,imaa014'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET l_success = 'N'
                  END IF
               END TRY
               
               LET l_sql = " MERGE INTO artp409_temp a ",
                           " USING imaal_t b ",
                           "    ON (a.rtement = b.imaalent AND a.rtem003 = b.imaal001 AND b.imaal002='",g_dlang,"') ",
                           "  WHEN MATCHED THEN ",
                           "       UPDATE SET a.imaal003 = b.imaal003,",
                           "                  a.imaal004 = b.imaal004 "
               TRY
                  EXECUTE IMMEDIATE l_sql
               CATCH
                  IF STATUS THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = STATUS
                     LET g_errparam.extend = 'upd imaal003,imaal004'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET l_success = 'N'
                  END IF
               END TRY
            END IF
         END IF
      END IF
      CALL cl_err_collect_show()
      
      IF l_success='N' THEN
         DELETE FROM artp409_temp
      END IF
   END IF
   #160902-00020#1 -S
   LET l_msg1 = cl_getmsg('ade-00114',g_lang)
   CALL cl_progress_no_window_ing(l_msg1) 
   #160902-00020#1 -E
   CALL artp409_b_fill()
END FUNCTION

################################################################################
# Descriptions...: 执行更新
# Memo...........:
# Usage..........: CALL artp409_execupdate()
#                  RETURNING
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/07/03 by lvjh
# Modify.........:
################################################################################
PRIVATE FUNCTION artp409_execupdate()
   DEFINE l_sql      STRING
   DEFINE l_cnt      LIKE type_t.num10
   DEFINE l_sql1      STRING
   DEFINE l_msg                 LIKE type_t.chr100  #160902-00020#1 add
   
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM artp409_temp
   IF l_cnt=0 THEN
      RETURN
   END IF
   
   #160902-00020#1 -S
   CALL cl_progress_bar_no_window(2)
   LET l_msg = cl_getmsg('ade-00114',g_lang)
   CALL cl_progress_no_window_ing(l_msg) 
   #160902-00020#1 -E
   
   IF g_importmode='1' THEN
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt FROM artp409_temp WHERE rtem003 IS NOT NULL
      IF l_cnt=0 THEN
         RETURN
      END IF
   ELSE
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt FROM artp409_temp WHERE imaa009 IS NOT NULL
      IF l_cnt=0 THEN
         RETURN
      END IF
   END IF
   
   CALL s_transaction_begin()
   
   IF g_importmode='1' THEN
      LET l_sql = " MERGE INTO rtem_t a ",
                  " USING artp409_temp b ",
                  "    ON (a.rtement = b.rtement AND a.rtemsite = b.rtemsite AND a.rtem001 = b.rtem001 AND a.rtem002 = b.rtem002 AND a.rtem003 = b.rtem003) ",
                  "  WHEN MATCHED THEN ",
                  "       UPDATE SET a.rtem004 = b.rtem004, ",
                  "                  a.rtem005 = b.rtem005, ",
                  "                  a.rtem006 = b.rtem006, ",
                  "                  a.rtem007 = b.rtem007, ",
                  "                  a.rtem008 = b.rtem008, ",
                  "                  a.rtem009 = b.rtem009, ",
                  "                  a.rtem010 = b.rtem010, ",
                  "                  a.rtem011 = b.rtem011, ",
                  "                  a.rtem012 = b.rtem012, ",
                  "                  a.rtem013 = b.rtem013 "
      
      TRY
         EXECUTE IMMEDIATE l_sql
      CATCH
         IF STATUS THEN
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = STATUS
            LET g_errparam.extend = 'upd rtem_t 1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN
         END IF
      END TRY
      LET l_sql1 = " MERGE INTO imaa_t a ",
                  " USING artp409_temp b ",
                  "    ON (a.imaaent = b.rtement  AND a.imaa001 = b.rtem003) ",
                  "  WHEN MATCHED THEN ",
                  "       UPDATE SET a.imaa132 = b.rtem004, ",
                  "                  a.imaa133 = b.rtem005, ",
                  "                  a.imaa134 = b.rtem006, ",
                  "                  a.imaa135 = b.rtem007, ",
                  "                  a.imaa136 = b.rtem008, ",
                  "                  a.imaa137 = b.rtem009, ",
                  "                  a.imaa138 = b.rtem010, ",
                  "                  a.imaa139 = b.rtem011, ",
                  "                  a.imaa140 = b.rtem012, ",
                  "                  a.imaa141 = b.rtem013 "
      
      TRY
         EXECUTE IMMEDIATE l_sql1
      CATCH
         IF STATUS THEN
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = STATUS
            LET g_errparam.extend = 'upd imaa_t 1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN
         END IF
      END TRY
      IF g_clearmode='2' THEN
         LET l_sql = "UPDATE rtem_t a SET a.rtem004 = '', ",
                     "                    a.rtem005 = '', ",
                     "                    a.rtem006 = '', ",
                     "                    a.rtem007 = '', ",
                     "                    a.rtem008 = '', ",
                     "                    a.rtem009 = '', ",
                     "                    a.rtem010 = '', ",
                     "                    a.rtem011 = '', ",
                     "                    a.rtem012 = '', ",
                     "                    a.rtem013 = '' ",
                     "        WHERE NOT EXISTS(SELECT 1 FROM artp409_temp b ",
                     "                          WHERE a.rtement = b.rtement  ",
                     "                            AND a.rtemsite = b.rtemsite  ",
                     "                            AND a.rtem001 = b.rtem001  ",
                     "                            AND a.rtem002 = b.rtem002  ",
                     "                            AND a.rtem003 = b.rtem003) ",
                     "          AND rtement = ",g_enterprise
         
         EXECUTE IMMEDIATE l_sql
         IF STATUS THEN
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = STATUS
            LET g_errparam.extend = 'upd rtem_t to null 1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN
         END IF
         ##add by zhangnan 同时更新imaa_t的商品属性
         LET l_sql1 = "UPDATE imaa_t a SET a.imaa132 = '', ",
                     "                     a.imaa133 = '', ",
                     "                     a.imaa134 = '', ",
                     "                     a.imaa135 = '', ",
                     "                     a.imaa136 = '', ",
                     "                     a.imaa137 = '', ",
                     "                     a.imaa138 = '', ",
                     "                     a.imaa139 = '', ",
                     "                     a.imaa140 = '', ",
                     "                     a.imaa141 = '' ",
                     "        WHERE NOT EXISTS(SELECT 1 FROM artp409_temp b ",
                     "                          WHERE a.imaaent = b.rtement  ",
                     "                            AND a.imaa001 = b.rtem003) ",
                     "          AND imaaent = ",g_enterprise
         
         EXECUTE IMMEDIATE l_sql1
         IF STATUS THEN
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = STATUS
            LET g_errparam.extend = 'upd imaa_t to null 1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN
         END IF
         ##add by zhangnan 
      END IF
   ELSE
      LET l_sql = " MERGE INTO rtem_t a ",
                  " USING (SELECT DISTINCT rtement,rtemsite,rtem001,rtem002,imaa001, ",
                  "               rtem004,rtem005,rtem006,rtem007,rtem008, ",
                  "               rtem009,rtem010,rtem011,rtem012,rtem013 ",
                  "          FROM artp409_temp c,imaa_t d",
                  "         WHERE c.rtement = d.imaaent ",
                  "           AND c.imaa009 = d.imaa009 ) b ",
                  "    ON (a.rtement = b.rtement AND a.rtemsite = b.rtemsite AND a.rtem001 = b.rtem001 AND a.rtem002 = b.rtem002 AND a.rtem003 = b.imaa001) ",
                  "  WHEN MATCHED THEN ",
                  "       UPDATE SET a.rtem004 = b.rtem004, ",
                  "                  a.rtem005 = b.rtem005, ",
                  "                  a.rtem006 = b.rtem006, ",
                  "                  a.rtem007 = b.rtem007, ",
                  "                  a.rtem008 = b.rtem008, ",
                  "                  a.rtem009 = b.rtem009, ",
                  "                  a.rtem010 = b.rtem010, ",
                  "                  a.rtem011 = b.rtem011, ",
                  "                  a.rtem012 = b.rtem012, ",
                  "                  a.rtem013 = b.rtem013 "
      
      TRY
         EXECUTE IMMEDIATE l_sql
      CATCH
         IF STATUS THEN
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = STATUS
            LET g_errparam.extend = 'upd rtem_t 2'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN
         END IF
      END TRY
       LET l_sql1 = " MERGE INTO imaa_t a ",
                  " USING artp409_temp b ",
                  "    ON (a.imaaent = b.rtement  AND a.imaa009 = b.imaa009) ",
                  "  WHEN MATCHED THEN ",
                  "       UPDATE SET a.imaa132 = b.rtem004, ",
                  "                  a.imaa133 = b.rtem005, ",
                  "                  a.imaa134 = b.rtem006, ",
                  "                  a.imaa135 = b.rtem007, ",
                  "                  a.imaa136 = b.rtem008, ",
                  "                  a.imaa137 = b.rtem009, ",
                  "                  a.imaa138 = b.rtem010, ",
                  "                  a.imaa139 = b.rtem011, ",
                  "                  a.imaa140 = b.rtem012, ",
                  "                  a.imaa141 = b.rtem013 "
      
      TRY
         EXECUTE IMMEDIATE l_sql1
      CATCH
         IF STATUS THEN
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = STATUS
            LET g_errparam.extend = 'upd imaa_t 2'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN
         END IF
      END TRY
      IF g_clearmode='2' THEN
         LET l_sql = "UPDATE rtem_t a SET a.rtem004 = '', ",
                     "                    a.rtem005 = '', ",
                     "                    a.rtem006 = '', ",
                     "                    a.rtem007 = '', ",
                     "                    a.rtem008 = '', ",
                     "                    a.rtem009 = '', ",
                     "                    a.rtem010 = '', ",
                     "                    a.rtem011 = '', ",
                     "                    a.rtem012 = '', ",
                     "                    a.rtem013 = '' ",
                     "        WHERE NOT EXISTS(SELECT 1 FROM artp409_temp b,imaa_t c ",
                     "                          WHERE b.rtement = c.imaaent ",
                     "                            AND b.imaa009 = c.imaa009 ",
                     "                            AND a.rtement = b.rtement  ",
                     "                            AND a.rtemsite = b.rtemsite  ",
                     "                            AND a.rtem001 = b.rtem001  ",
                     "                            AND a.rtem002 = b.rtem002  ",
                     "                            AND a.rtem003 = c.imaa001) "
                     
         EXECUTE IMMEDIATE l_sql
         
         IF STATUS THEN
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = STATUS
            LET g_errparam.extend = 'upd rtem_t to null 2'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN
         END IF
                  ##add by zhangnan 同时更新imaa_t的商品属性
         LET l_sql1 = "UPDATE imaa_t a SET a.imaa132 = '', ",
                     "                     a.imaa133 = '', ",
                     "                     a.imaa134 = '', ",
                     "                     a.imaa135 = '', ",
                     "                     a.imaa136 = '', ",
                     "                     a.imaa137 = '', ",
                     "                     a.imaa138 = '', ",
                     "                     a.imaa139 = '', ",
                     "                     a.imaa140 = '', ",
                     "                     a.imaa141 = '' ",
                     "        WHERE NOT EXISTS(SELECT 1 FROM artp409_temp b ",
                     "                          WHERE a.imaaent = b.rtement  ",
                     "                            AND a.imaa009 = b.imaa009) ",
                     "          AND imaaent = ",g_enterprise
         
         EXECUTE IMMEDIATE l_sql1
         IF STATUS THEN
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = STATUS
            LET g_errparam.extend = 'upd imaa_t to null 2'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN
         END IF
         ##add by zhangnan 
      END IF
   END IF
   
   #160902-00020#1 -S
   LET l_msg = cl_getmsg('ade-00114',g_lang)
   CALL cl_progress_no_window_ing(l_msg) 
   #160902-00020#1 -E
   
   CALL s_transaction_end('Y','0')
   CALL cl_ask_end1()
END FUNCTION

################################################################################
# Descriptions...: 下载EXCEL模板
# Memo...........:
# Usage..........: CALL artp409_dl_templet()
#                  RETURNING 
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/07/03 by lvjh
# Modify.........:
################################################################################
PRIVATE FUNCTION artp409_dl_templet()

   CALL g_detail_d.clear()
   
   LET g_detail_d[1].sel = 'N'
   
   CALL cl_set_comp_visible('b_imaa014,b_rtem003_desc,b_rtem003_desc_1',FALSE)
   
   LET g_export_node[1] = base.typeInfo.create(g_detail_d)
   LET g_export_id[1]   = "s_detail1"
   CALL cl_export_to_excel()
   
   CALL cl_set_comp_visible('b_imaa014,b_rtem003_desc,b_rtem003_desc_1',TRUE)
   
   CALL artp409_b_fill()
   
END FUNCTION

################################################################################
# Descriptions...: 预览
# Memo...........:
# Usage..........: CALL artp409_preview()
#                  RETURNING 
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/07/03 by lvjh
# Modify.........:
################################################################################
PRIVATE FUNCTION artp409_preview()

               
   UPDATE artp409_temp SET rtem004 = g_rtem004,
                           rtem005 = g_rtem005,
                           rtem006 = g_rtem006,
                           rtem007 = g_rtem007,
                           rtem008 = g_rtem008,
                           rtem009 = g_rtem009,
                           rtem010 = g_rtem010,
                           rtem011 = g_rtem011,
                           rtem012 = g_rtem012,
                           rtem013 = g_rtem013
                           
   CALL artp409_b_fill()
END FUNCTION

################################################################################
# Descriptions...: 商品属性校验
# Memo...........:
# Usage..........: CALL artp409_oocq_chk()
#                  RETURNING r_field
# Input parameter: 
# Return code....: r_field        值校验错误的栏位
# Date & Author..: 2016/07/06 by lvjh
# Modify.........:
################################################################################
PRIVATE FUNCTION artp409_oocq_chk()
   
   IF NOT cl_null(g_rtem004) THEN
      INITIALIZE g_chkparam.* TO NULL
      LET g_chkparam.arg1 = '2006'
      LET g_chkparam.arg2 = g_rtem004
      LET g_errshow = TRUE 
      IF NOT cl_chk_exist("v_oocq002_01") THEN
         MESSAGE '商品属性一未通过校验'
         RETURN 'rtem004'
      END IF
   END IF
   
   IF NOT cl_null(g_rtem005) THEN
      INITIALIZE g_chkparam.* TO NULL
      LET g_chkparam.arg1 = '2007'
      LET g_chkparam.arg2 = g_rtem005
      LET g_errshow = TRUE 
      IF NOT cl_chk_exist("v_oocq002_01") THEN
         MESSAGE '商品属性二未通过校验'
         RETURN 'rtem005'
      END IF
   END IF
   
   IF NOT cl_null(g_rtem006) THEN
      INITIALIZE g_chkparam.* TO NULL
      LET g_chkparam.arg1 = '2008'
      LET g_chkparam.arg2 = g_rtem006
      LET g_errshow = TRUE 
      IF NOT cl_chk_exist("v_oocq002_01") THEN
         MESSAGE '商品属性三未通过校验'
         RETURN 'rtem006'
      END IF
   END IF
   
   IF NOT cl_null(g_rtem007) THEN
      INITIALIZE g_chkparam.* TO NULL
      LET g_chkparam.arg1 = '2009'
      LET g_chkparam.arg2 = g_rtem006
      LET g_errshow = TRUE 
      IF NOT cl_chk_exist("v_oocq002_01") THEN
         MESSAGE '商品属性四未通过校验'
         RETURN 'rtem007'
      END IF
   END IF
   
   IF NOT cl_null(g_rtem008) THEN
      INITIALIZE g_chkparam.* TO NULL
      LET g_chkparam.arg1 = '2010'
      LET g_chkparam.arg2 = g_rtem008
      LET g_errshow = TRUE 
      IF NOT cl_chk_exist("v_oocq002_01") THEN
         MESSAGE '商品属性五未通过校验'
         RETURN 'rtem008'
      END IF
   END IF
   
   IF NOT cl_null(g_rtem009) THEN
      INITIALIZE g_chkparam.* TO NULL
      LET g_chkparam.arg1 = '2011'
      LET g_chkparam.arg2 = g_rtem009
      LET g_errshow = TRUE 
      IF NOT cl_chk_exist("v_oocq002_01") THEN
         MESSAGE '商品属性六未通过校验'
         RETURN 'rtem009'
      END IF
   END IF
   
   IF NOT cl_null(g_rtem010) THEN
      INITIALIZE g_chkparam.* TO NULL
      LET g_chkparam.arg1 = '2012'
      LET g_chkparam.arg2 = g_rtem010
      LET g_errshow = TRUE 
      IF NOT cl_chk_exist("v_oocq002_01") THEN
         MESSAGE '商品属性七未通过校验'
         RETURN 'rtem010'
      END IF
   END IF
   
   IF NOT cl_null(g_rtem011) THEN
      INITIALIZE g_chkparam.* TO NULL
      LET g_chkparam.arg1 = '2013'
      LET g_chkparam.arg2 = g_rtem011
      LET g_errshow = TRUE 
      IF NOT cl_chk_exist("v_oocq002_01") THEN
         MESSAGE '商品属性八未通过校验'
         RETURN 'rtem011'
      END IF
   END IF
   
   IF NOT cl_null(g_rtem012) THEN
      INITIALIZE g_chkparam.* TO NULL
      LET g_chkparam.arg1 = '2014'
      LET g_chkparam.arg2 = g_rtem012
      LET g_errshow = TRUE 
      IF NOT cl_chk_exist("v_oocq002_01") THEN
         MESSAGE '商品属性九未通过校验'
         RETURN 'rtem012'
      END IF
   END IF
   
   IF NOT cl_null(g_rtem013) THEN
      INITIALIZE g_chkparam.* TO NULL
      LET g_chkparam.arg1 = '2015'
      LET g_chkparam.arg2 = g_rtem013
      LET g_errshow = TRUE 
      IF NOT cl_chk_exist("v_oocq002_01") THEN
         MESSAGE '商品属性十未通过校验'
         RETURN 'rtem013'
      END IF
   END IF
   
   RETURN ''
END FUNCTION

#end add-point
 
{</section>}
 
