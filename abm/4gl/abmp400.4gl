#該程式已解開Section, 不再透過樣板產出!
{<section id="abmp400.description" >}
#+ V  ersion..: T100-ERP-1.00.00(SD版次:1,PR版次:1) Build-000039
#+ 
#+ Filename...: abmp400
#+ Description: 料件承認狀態整批更新作業
#+ Creator....: 02295(2014-09-15 16:41:02)
#+ Modifier...: 02295(2014-09-16 19:04:15) -SD/PR- 02294
#+ Buildtype..: 應用 p02 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="abmp400.global" >}
#160318-00025#27   2016/04/29  BY 07900    校验代码重复错误讯息的修改
#160913-00055#1    2016/09/18  By lixiang  交易对象栏位开窗调整为q_pmaa001_25
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc" 
 
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
DEFINE l_ac                 LIKE type_t.num5              
DEFINE l_ac_d               LIKE type_t.num5              #單身idx 
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_current_page       LIKE type_t.num5              #目前所在頁數
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_master_idx         LIKE type_t.num5
 
TYPE type_parameter RECORD
   #add-point:自定背景執行須傳遞的參數(Module Variable)
   
   #end add-point
        wc               STRING
                     END RECORD
 
TYPE type_g_detail_d RECORD
#add-point:自定義模組變數(Module Variable)
       sel LIKE type_t.chr1,
       bmif001 LIKE bmif_t.bmif001,
       bmif001_desc LIKE type_t.chr500,
       bmif001_desc_1 LIKE type_t.chr500,
       bmif002 LIKE bmif_t.bmif002,
       bmif002_desc LIKE type_t.chr500,
       bmif003 LIKE bmif_t.bmif003,
       bmif004 LIKE bmif_t.bmif004,
       bmif005 LIKE bmif_t.bmif005,
       bmif006 LIKE bmif_t.bmif006,
       bmif007 LIKE bmif_t.bmif007,
       bmif007_desc LIKE type_t.chr500,
       bmif008 LIKE bmif_t.bmif008,
       bmif009 LIKE bmif_t.bmif009,
       bmif009_desc LIKE type_t.chr500,
       bmif011 LIKE bmif_t.bmif011,
       bmif012 LIKE bmif_t.bmif012,
       bmif013 LIKE bmif_t.bmif013,
       bmif013_desc LIKE type_t.chr500,
       bmif015 LIKE bmif_t.bmif015,
       bmif016 LIKE bmif_t.bmif016,
       bmif017 LIKE bmif_t.bmif017,
       bmif018 LIKE bmif_t.bmif018
     END RECORD
#end add-point
DEFINE g_detail_cnt         LIKE type_t.num5              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明
DEFINE g_master  RECORD
          l_bmif009 LIKE bmif_t.bmif009,
          l_bmif009_desc LIKE type_t.chr500,
          l_bmif011 LIKE bmif_t.bmif011,
          l_bmif011c LIKE type_t.chr1,
          l_bmif012 LIKE bmif_t.bmif012,
          l_bmif012c LIKE type_t.chr1,
          l_bmif017 LIKE bmif_t.bmif017,
          l_bmif018 LIKE bmif_t.bmif018,
          l_bmif017c LIKE type_t.chr1,
          l_bmif015 LIKE bmif_t.bmif015,
          l_bmif015c LIKE type_t.chr1,
          l_bmif016 LIKE bmif_t.bmif016,
          l_bmif016c LIKE type_t.chr1,
          l_bmif013 LIKE bmif_t.bmif013,
          l_bmif013_desc LIKE type_t.chr500,
          l_bmif019 LIKE bmif_t.bmif019,
          l_bmif019_desc LIKE type_t.chr500,
          l_bmif020 LIKE bmif_t.bmif020,
          l_bmif020_desc LIKE type_t.chr500
       END RECORD   
DEFINE g_chk_cnt   LIKE type_t.num5
DEFINE g_stage     LIKE type_t.num10
#end add-point
 
{</section>}
 
{<section id="abmp400.main" >}
#+ 作業開始 
MAIN
   DEFINE ls_js  STRING
   #add-point:main段define
   
   #end add-point   
 
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("abm","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js
   
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_abmp400 WITH FORM cl_ap_formpath("abm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL abmp400_init()   
 
      #進入選單 Menu (="N")
      CALL abmp400_ui_dialog() 
 
      #add-point:畫面關閉前
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_abmp400
   END IF 
   
   #add-point:作業離開前
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="abmp400.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION abmp400_init()
   #add-point:init段define
   
   #end add-point   
 
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化
   CALL cl_set_combo_scc_part('bmif006','2014','1,2')
   CALL cl_set_combo_scc_part('b_bmif006','2014','1,2')
   
   LET g_master.l_bmif011 = ''
   LET g_master.l_bmif016 = ''
   LET g_master.l_bmif017 = ''
   LET g_master.l_bmif018 = ''
   LET g_master.l_bmif011c = 'N'
   LET g_master.l_bmif012c = 'N'
   LET g_master.l_bmif017c = 'N'
   LET g_master.l_bmif015c = 'N'
   LET g_master.l_bmif016c = 'N'  
   LET g_chk_cnt = 0
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="abmp400.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION abmp400_ui_dialog()
   DEFINE li_idx   LIKE type_t.num5
   #add-point:ui_dialog段define
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_flag     LIKE type_t.chr1
   #end add-point 
 
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog 
   
   #end add-point
   
   WHILE TRUE
 
      CALL cl_dlg_query_bef_disp()  #相關查詢
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct
         CONSTRUCT g_wc ON bmif001,bmif002,bmif003,bmif004,bmif005,bmif006,bmif007,
                           bmif008,bmif009,bmif011,bmif012,bmif013,bmif017,bmif018
                      FROM bmif001,bmif002,bmif003,bmif004,bmif005,bmif006,bmif007,
                           bmif008,bmif009,bmif011,bmif012,bmif013,bmif017,bmif018
   
            BEFORE CONSTRUCT
               CALL cl_qbe_init()
   
            ON ACTION controlp INFIELD bmif001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imaa001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO bmif001  #顯示到畫面上
               NEXT FIELD bmif001                    #返回原欄位
   
            ON ACTION controlp INFIELD bmif002
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '221'
               CALL q_oocq002()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO bmif002      #顯示到畫面上
               NEXT FIELD bmif002                         #返回原欄位

            ON ACTION controlp INFIELD bmif004
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imaa001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO bmif004      #顯示到畫面上
               NEXT FIELD bmif004                         #返回原欄位
               
            ON ACTION controlp INFIELD bmif007
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               #CALL q_pmaa001()                           #呼叫開窗 #160913-00055#1 
               CALL q_pmaa001_25()        #160913-00055#1 
               DISPLAY g_qryparam.return1 TO bmif007      #顯示到畫面上
               NEXT FIELD bmif007                         #返回原欄位               
               
            ON ACTION controlp INFIELD bmif008
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_pmao004_1()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO bmif008      #顯示到畫面上
               NEXT FIELD bmif008                         #返回原欄位      
               
            ON ACTION controlp INFIELD bmif009
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '1116'
               CALL q_oocq002()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO bmif009      #顯示到畫面上
               NEXT FIELD bmif009                         #返回原欄位   
               
            ON ACTION controlp INFIELD bmif012
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_bmia015()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO bmif012      #顯示到畫面上
               NEXT FIELD bmif012                         #返回原欄位 
               
            ON ACTION controlp INFIELD bmif013
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '210'
               CALL q_oocq002()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO bmif013      #顯示到畫面上
               NEXT FIELD bmif013                        #返回原欄位  
               
         END CONSTRUCT
         #end add-point
         #add-point:ui_dialog段input
         INPUT ARRAY g_detail_d FROM s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)

            BEFORE INPUT
               LET g_current_page = 1
               DISPLAY g_detail_cnt TO FORMONLY.h_count
            BEFORE ROW
               LET g_master_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_master_idx
               DISPLAY g_master_idx TO FORMONLY.h_index
               DISPLAY g_detail_d.getLength() TO FORMONLY.h_count
               LET g_master_idx = l_ac
             
           ON CHANGE b_sel
              IF g_detail_d[l_ac].sel = 'Y' THEN 
                 LET g_chk_cnt = g_chk_cnt + 1
              ELSE
                 LET g_chk_cnt = g_chk_cnt - 1              
              END IF

         END INPUT 
         
         INPUT BY NAME g_master.l_bmif009,g_master.l_bmif011,g_master.l_bmif011c,g_master.l_bmif012,
                       g_master.l_bmif012c,g_master.l_bmif017,g_master.l_bmif018,g_master.l_bmif017c,
                       g_master.l_bmif015,g_master.l_bmif015c,g_master.l_bmif016,g_master.l_bmif016c,
                       g_master.l_bmif013,g_master.l_bmif019,g_master.l_bmif020                     
                       ATTRIBUTE(WITHOUT DEFAULTS)
            BEFORE INPUT
               LET g_errshow = 1
            BEFORE FIELD l_bmif009
               CALL abmp400_oocql004_desc('1116',g_master.l_bmif009) RETURNING g_master.l_bmif009_desc
               DISPLAY BY NAME g_master.l_bmif009_desc
               
            AFTER FIELD l_bmif009
               CALL abmp400_oocql004_desc('1116',g_master.l_bmif009) RETURNING g_master.l_bmif009_desc
               DISPLAY BY NAME g_master.l_bmif009_desc
               IF NOT cl_null(g_master.l_bmif009) THEN
                  IF NOT s_azzi650_chk_exist('1116',g_master.l_bmif009) THEN
                     LET g_master.l_bmif009 = ''
                     NEXT FIELD CURRENT
                  END IF
               END IF  
               CALL abmp400_set_comp_entry()
               CALL abmp400_set_comp_noentry()

            AFTER FIELD l_bmif015
               IF NOT cl_ap_chk_range(g_master.l_bmif015,"0.000","0","","","azz-00079",1) THEN
                  LET g_master.l_bmif015 = ''
                  NEXT FIELD CURRENT
               END IF
               IF NOT cl_null(g_master.l_bmif009) THEN 
                  CALL abmp400_set_comp_entry()
                  CALL abmp400_set_comp_noentry()               
               END IF

            BEFORE FIELD l_bmif013
               CALL abmp400_oocql004_desc('210',g_master.l_bmif013) RETURNING g_master.l_bmif013_desc
               DISPLAY BY NAME g_master.l_bmif013_desc
               
            AFTER FIELD l_bmif013
               CALL abmp400_oocql004_desc('210',g_master.l_bmif013) RETURNING g_master.l_bmif013_desc
               DISPLAY BY NAME g_master.l_bmif013_desc            
               IF NOT cl_null(g_master.l_bmif013) THEN
                  IF NOT s_azzi650_chk_exist('210',g_master.l_bmif013) THEN
                     LET g_master.l_bmif013 = ''
                     NEXT FIELD CURRENT
                  END IF
               END IF

            BEFORE FIELD l_bmif019
               CALL abmp400_bmif019_desc()
               CALL abmp400_bmif020_desc()
               
            AFTER FIELD l_bmif019
               CALL abmp400_bmif019_desc()
               IF NOT cl_null(g_master.l_bmif019) THEN
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
        
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_master.l_bmif019
                  #160318-00025#27  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
                  #160318-00025#27  by 07900 --add-end
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooag001") THEN
                     SELECT ooag003 INTO g_master.l_bmif020
                       FROM ooag_t
                      WHERE ooagent = g_enterprise
                        AND ooag001 = g_master.l_bmif019
                     CALL abmp400_bmif020_desc()
                  ELSE
                     #檢查失敗時後續處理
                     LET g_master.l_bmif019 = ''
                     LET g_master.l_bmif020 = ''
                     NEXT FIELD CURRENT
                  END IF
               END IF
               
            BEFORE FIELD l_bmif020
               CALL abmp400_bmif020_desc()
               
            AFTER FIELD l_bmif020
               CALL abmp400_bmif020_desc()
               IF NOT cl_null(g_master.l_bmif020) THEN
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
   
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_master.l_bmif020
                  LET g_chkparam.arg2 = g_today
                  #160318-00025#27  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  #160318-00025#27  by 07900 --add-end
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooeg001") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME
                  ELSE
                     #檢查失敗時後續處理
                     LET g_master.l_bmif020 = ''
                     NEXT FIELD CURRENT
                  END IF
               END IF

            ON ACTION controlp INFIELD l_bmif009
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '1116'
               CALL q_oocq002()                           
               LET g_master.l_bmif009 =  g_qryparam.return1
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = '1116'
               LET g_ref_fields[2] = g_master.l_bmif009
               CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002 = ? AND oocql003 ='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_master.l_bmif009_desc = '', g_rtn_fields[1] , ''
               DISPLAY g_master.l_bmif009_desc TO bmif009_desc               
               NEXT FIELD l_bmif009                          
               
            ON ACTION controlp INFIELD l_bmif012
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               CALL q_bmia015()                           #呼叫開窗
               LET g_master.l_bmif012 =  g_qryparam.return1
               NEXT FIELD l_bmif012                         #返回原欄位 
               
            ON ACTION controlp INFIELD l_bmif013
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '210'
               CALL q_oocq002()                           #呼叫開窗
               LET g_master.l_bmif013 =  g_qryparam.return1        
               NEXT FIELD l_bmif013                        #返回原欄位  

            ON ACTION controlp INFIELD l_bmif019
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                           #呼叫開窗
               LET g_master.l_bmif019 =  g_qryparam.return1
               NEXT FIELD l_bmif019                        #返回原欄位  

            ON ACTION controlp INFIELD l_bmif020
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = g_today
               CALL q_ooeg001()                           #呼叫開窗
               LET g_master.l_bmif020 =  g_qryparam.return1
               NEXT FIELD l_bmif020                        #返回原欄位  
           
           AFTER INPUT
               LET g_errshow = 0
               
         END INPUT            
         #end add-point
         #add-point:ui_dialog段自定義display array
 
         #end add-point
 
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
 
         BEFORE DIALOG
            IF g_detail_d.getLength() > 0 THEN
               CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
            ELSE
               CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
            END IF
            #add-point:ui_dialog段before_dialog2
            
            #end add-point
 
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
               #add-point:ui_dialog段on action selall
               
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selall
            LET g_chk_cnt = g_detail_d.getLength()
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "N"
               #add-point:ui_dialog段on action selnone
               
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selnone
            LET g_chk_cnt = 0
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "Y"
               END IF
            END FOR
            #add-point:ui_dialog段on action sel
            LET g_chk_cnt = g_chk_cnt + 1
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
            END FOR
            #add-point:ui_dialog段on action unsel
            LET g_chk_cnt = g_chk_cnt - 1
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL abmp400_filter()
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
            CALL abmp400_query()
             
         # 條件清除
         ON ACTION qbeclear
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            CALL abmp400_b_fill()
            CALL abmp400_fetch()
 
         #add-point:ui_dialog段action
         ON ACTION batch_execute
            CALL abmp400_chk() RETURNING l_success,l_flag
            IF NOT l_success THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "" 
               LET g_errparam.code   = "acr-00015" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()            
               CASE l_flag
                  WHEN 1  NEXT FIELD l_bmif011
                  WHEN 2  NEXT FIELD l_bmif012
                  WHEN 3  NEXT FIELD l_bmif016
               END CASE
            END IF
            
            CALL abmp400_execute()
            CALL abmp400_query()         
         #end add-point
 
         #主選單用ACTION
         &include "main_menu.4gl"
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
 
{<section id="abmp400.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION abmp400_query()
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define
   
   #end add-point 
   
   #add-point:cs段after_construct
   
   #end add-point
        
   LET g_error_show = 1
   CALL abmp400_b_fill()
   LET l_ac = g_master_idx
   CALL abmp400_fetch()
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = -100 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
   END IF
   
END FUNCTION
 
{</section>}
 
{<section id="abmp400.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION abmp400_b_fill()
 
   DEFINE ls_wc           STRING
   #add-point:b_fill段define
   
   #end add-point
 
   #add-point:b_fill段sql_before
   IF cl_null(g_wc_filter) THEN
      LET g_wc_filter = " 1=1"
   END IF
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF

   LET ls_wc = g_wc," AND ", g_wc_filter
   
   LET g_sql = " SELECT 'N',bmif001,imaal003,imaal004,bmif002,a.oocql004,bmif003,bmif004,bmif005,bmif006,bmif007,pmaal003,",
               "        bmif008,bmif009,b.oocql004,bmif011,bmif012,bmif013,c.oocql004,bmif015,bmif016,bmif017,bmif018 ",
               "   FROM bmif_t ",
               "        LEFT OUTER JOIN imaal_t ON imaalent = bmifent AND imaal001 = bmif001 AND imaal002 = '",g_dlang,"'",
               "        LEFT OUTER JOIN oocql_t a ON a.oocqlent = bmifent AND a.oocql001 ='221' AND a.oocql002 = bmif002 AND a.oocql003 = '",g_dlang,"'",
               "        LEFT OUTER JOIN oocql_t b ON b.oocqlent = bmifent AND b.oocql001 ='1116' AND b.oocql002 = bmif009 AND b.oocql003 = '",g_dlang,"'",
               "        LEFT OUTER JOIN oocql_t c ON c.oocqlent = bmifent AND c.oocql001 ='210' AND c.oocql002 = bmif013 AND c.oocql003 = '",g_dlang,"'",
               "        LEFT OUTER JOIN pmaal_t ON pmaalent = bmifent AND pmaal001 = bmif007 AND pmaal002 = '",g_dlang,"'",
               "  WHERE bmifent = ? AND ",ls_wc,
               "  ORDER BY bmif001"
   #end add-point
 
   PREPARE abmp400_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR abmp400_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空
   
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into
      g_detail_d[l_ac].*
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
      
      #end add-point
      
      CALL abmp400_detail_show()      
 
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
   FREE abmp400_sel
   
   LET l_ac = 1
   CALL abmp400_fetch()
   #add-point:b_fill段資料填充(其他單身)
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="abmp400.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION abmp400_fetch()
 
   DEFINE li_ac           LIKE type_t.num5
   #add-point:fetch段define
   
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後
   
   #end add-point 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="abmp400.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION abmp400_detail_show()
   #add-point:show段define
   
   #end add-point
 
   #add-point:detail_show段
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="abmp400.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION abmp400_filter()
   #add-point:filter段define

   #end add-point    
 
   LET l_ac = 1
   LET g_detail_cnt = 1
   #add-point:filter段define
 
   #end add-point    
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
         CONSTRUCT g_wc_filter ON bmif001,bmif002,bmif003,bmif004,bmif005,bmif006,bmif007,
                                  bmif008,bmif009,bmif011,bmif012,bmif013,bmif017,bmif018
                      FROM s_detail1[1].b_bmif001,s_detail1[1].b_bmif002,s_detail1[1].b_bmif003,
                           s_detail1[1].b_bmif004,s_detail1[1].b_bmif005,s_detail1[1].b_bmif006,
                           s_detail1[1].b_bmif007,s_detail1[1].b_bmif008,s_detail1[1].b_bmif009,
                           s_detail1[1].b_bmif011,s_detail1[1].b_bmif012,s_detail1[1].b_bmif013,
                           s_detail1[1].b_bmif017,s_detail1[1].b_bmif018
   
            BEFORE CONSTRUCT
               CALL cl_qbe_init()
   
            ON ACTION controlp INFIELD b_bmif001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imaa001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO b_bmif001  #顯示到畫面上
               NEXT FIELD b_bmif001                    #返回原欄位
   
            ON ACTION controlp INFIELD b_bmif002
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '221'
               CALL q_oocq002()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO b_bmif002      #顯示到畫面上
               NEXT FIELD b_bmif002                         #返回原欄位
 
            ON ACTION controlp INFIELD b_bmif004
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imaa001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO b_bmif004      #顯示到畫面上
               NEXT FIELD b_bmif004                         #返回原欄位
               
            ON ACTION controlp INFIELD b_bmif007
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_pmaa001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO b_bmif007      #顯示到畫面上
               NEXT FIELD b_bmif007                         #返回原欄位               
               
            ON ACTION controlp INFIELD b_bmif008
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_pmao004_1()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO b_bmif008      #顯示到畫面上
               NEXT FIELD b_bmif008                         #返回原欄位      
               
            ON ACTION controlp INFIELD b_bmif009
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '1116'
               CALL q_oocq002()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO b_bmif009      #顯示到畫面上
               NEXT FIELD b_bmif009                         #返回原欄位   
               
            ON ACTION controlp INFIELD b_bmif012
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_bmia015()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO b_bmif012      #顯示到畫面上
               NEXT FIELD b_bmif012                         #返回原欄位 
               
            ON ACTION controlp INFIELD b_bmif013
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '210'
               CALL q_oocq002()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO b_bmif013      #顯示到畫面上
               NEXT FIELD b_bmif013                        #返回原欄位  
               
         END CONSTRUCT
 
      BEFORE DIALOG
 
 
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
      LET g_wc_filter = g_wc_filter, " "
   ELSE
      LET g_wc_filter = g_wc_filter_t
   END IF
 
   CALL abmp400_filter_show('bmif001','b_bmif001')
   CALL abmp400_filter_show('bmif002','b_bmif002')
   CALL abmp400_filter_show('bmif003','b_bmif003')
   CALL abmp400_filter_show('bmif004','b_bmif004')
   CALL abmp400_filter_show('bmif005','b_bmif005')
   CALL abmp400_filter_show('bmif006','b_bmif006')
   CALL abmp400_filter_show('bmif007','b_bmif007')
   CALL abmp400_filter_show('bmif008','b_bmif008')
   CALL abmp400_filter_show('bmif009','b_bmif009')
   CALL abmp400_filter_show('bmif011','b_bmif011')
   CALL abmp400_filter_show('bmif012','b_bmif012')
   CALL abmp400_filter_show('bmif013','b_bmif013')
   CALL abmp400_filter_show('bmif017','b_bmif017')
   CALL abmp400_filter_show('bmif018','b_bmif018')   
   CALL abmp400_b_fill()
   CALL abmp400_fetch()
   
END FUNCTION
 
{</section>}
 
{<section id="abmp400.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION abmp400_filter_parser(ps_field)
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
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
 
{<section id="abmp400.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION abmp400_filter_show(ps_field,ps_object)
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
   LET ls_condition = abmp400_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="abmp400.other_function" >}
#add-point:自定義元件(Function)

PRIVATE FUNCTION abmp400_execute()
DEFINE l_i    LIKE type_t.num5
DEFINE l_sql  STRING
DEFINE l_oocq015_old  LIKE oocq_t.oocq015
DEFINE l_oocq015_new  LIKE oocq_t.oocq015
DEFINE l_cnt  LIKE type_t.num5
DEFINE l_oocq016  LIKE oocq_t.oocq016

   CALL s_transaction_begin()
   LET g_success = TRUE
   LET l_cnt = 1
   
   IF NOT cl_null(g_master.l_bmif009) THEN 
      SELECT oocq016 INTO l_oocq016
        FROM oocq_t
       WHERE oocqent = g_enterprise
         AND oocq001 = '1116'
         AND oocq002 = g_master.l_bmif009 
   END IF
   
   FOR l_i = 1 TO g_detail_d.getLength()
      IF g_detail_d[l_i].sel = 'N' THEN
         CONTINUE FOR
      END IF
      
      LET g_stage = l_cnt/g_chk_cnt
      DISPLAY g_stage TO stagecomplete
      DISPLAY g_detail_d[l_i].bmif001 TO stagenow
      
      LET g_sql = "UPDATE bmif_t ",
                  "   SET bmifmodid = '",g_user,"'," 
      IF NOT cl_null(g_master.l_bmif009) THEN 
         LET g_sql = g_sql," bmif009 = '",g_master.l_bmif009,"',"
         SELECT oocq015 INTO l_oocq015_old FROM oocq_t WHERE oocqent = g_enterprise AND oocq001 = '1116' AND oocq002 = g_detail_d[l_i].bmif009
         SELECT oocq015 INTO l_oocq015_new FROM oocq_t WHERE oocqent = g_enterprise AND oocq001 = '1116' AND oocq002 = g_master.l_bmif009
         IF l_oocq015_old = 'N' AND l_oocq015_new = 'Y' THEN
            LET g_sql = g_sql," bmif010 = bmif010 + 1 ,"
         END IF
      END IF
      IF NOT cl_null(g_master.l_bmif011) THEN 
        IF g_master.l_bmif011c = 'N' OR cl_null(g_detail_d[l_i].bmif011) THEN 
           LET g_sql = g_sql," bmif011 = '",g_master.l_bmif011,"',"
        END IF
      END IF  
      IF NOT cl_null(g_master.l_bmif012) THEN 
        IF g_master.l_bmif012c = 'N' OR cl_null(g_detail_d[l_i].bmif012) THEN 
           LET g_sql = g_sql," bmif012 = '",g_master.l_bmif012,"',"
        END IF
      END IF 
      IF NOT cl_null(g_master.l_bmif017) THEN 
        IF g_master.l_bmif017c = 'N' OR cl_null(g_detail_d[l_i].bmif017) THEN 
           LET g_sql = g_sql," bmif017 = '",g_master.l_bmif017,"',"
        END IF
      END IF
      IF NOT cl_null(g_master.l_bmif018) THEN 
        IF g_master.l_bmif017c = 'N' OR cl_null(g_detail_d[l_i].bmif018) THEN 
           LET g_sql = g_sql," bmif018 = '",g_master.l_bmif018,"',"
        END IF
      END IF      
      IF NOT cl_null(g_master.l_bmif015) OR l_oocq016 = 'N' THEN 
        IF g_master.l_bmif015c = 'N' OR cl_null(g_detail_d[l_i].bmif015) THEN 
           IF cl_null(g_master.l_bmif015) THEN 
              LET g_sql = g_sql," bmif015 = NULL ,"
           ELSE   
              LET g_sql = g_sql," bmif015 = '",g_master.l_bmif015,"',"
           END IF   
        END IF
      END IF  
      IF NOT cl_null(g_master.l_bmif016) OR l_oocq016 = 'N' THEN 
        IF g_master.l_bmif016c = 'N' OR cl_null(g_detail_d[l_i].bmif016) THEN 
           IF cl_null(g_master.l_bmif016) THEN 
              LET g_sql = g_sql," bmif016 = NULL ,"
           ELSE   
              LET g_sql = g_sql," bmif016 = '",g_master.l_bmif016,"',"
           END IF
        END IF
      END IF 
      IF NOT cl_null(g_master.l_bmif013) THEN 
         LET g_sql = g_sql," bmif013 = '",g_master.l_bmif013,"',"
      END IF 
      IF NOT cl_null(g_master.l_bmif019) THEN 
         LET g_sql = g_sql," bmif019 = '",g_master.l_bmif019,"',"
      END IF  
      IF NOT cl_null(g_master.l_bmif020) THEN 
         LET g_sql = g_sql," bmif020 = '",g_master.l_bmif020,"',"
      END IF  
      LET g_sql = g_sql," bmifmoddt = to_date('",cl_get_current(),"','yyyy-mm-dd hh24:mi:ss')",
                  " WHERE bmifent = '",g_enterprise,"'",
                  "   AND bmif001 = '",g_detail_d[l_i].bmif001,"'",
                  "   AND bmif002 = '",g_detail_d[l_i].bmif002,"'",
                  "   AND bmif003 = '",g_detail_d[l_i].bmif003,"'",
                  "   AND bmif004 = '",g_detail_d[l_i].bmif004,"'",
                  "   AND bmif005 = '",g_detail_d[l_i].bmif005,"'",
                  "   AND bmif006 = '",g_detail_d[l_i].bmif006,"'",
                  "   AND bmif007 = '",g_detail_d[l_i].bmif007,"'",
                  "   AND bmif008 = '",g_detail_d[l_i].bmif008,"'" 
      PREPARE upd_bmif FROM g_sql
      EXECUTE upd_bmif 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "UPD bmif_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET g_success = FALSE 
         EXIT FOR            
      END IF
      
      LET g_sql = " SELECT bmifent,bmif001,bmif002,bmif003,bmif004,bmif005,bmif006,bmif007,",
                  "        bmif008,bmif009,bmifmoddt,bmif011,bmif012,bmif015,bmif016,'',",
                  "        bmif017,bmif018,bmifmodid,'",g_dept,"'",
                  "   FROM bmif_t",
                  " WHERE bmifent = '",g_enterprise,"'",
                  "   AND bmif001 = '",g_detail_d[l_i].bmif001,"'",
                  "   AND bmif002 = '",g_detail_d[l_i].bmif002,"'",
                  "   AND bmif003 = '",g_detail_d[l_i].bmif003,"'",
                  "   AND bmif004 = '",g_detail_d[l_i].bmif004,"'",
                  "   AND bmif005 = '",g_detail_d[l_i].bmif005,"'",
                  "   AND bmif006 = '",g_detail_d[l_i].bmif006,"'",
                  "   AND bmif007 = '",g_detail_d[l_i].bmif007,"'",
                  "   AND bmif008 = '",g_detail_d[l_i].bmif008,"'" 
      LET g_sql = "INSERT INTO bmig_t ",g_sql 
      PREPARE ins_bmig FROM g_sql
      EXECUTE ins_bmig   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "INS bmig_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET g_success = FALSE 
         EXIT FOR            
      END IF 
      LET l_cnt = l_cnt + 1
   END FOR
  
   IF g_success = TRUE THEN 
      LET g_stage = 100
      DISPLAY g_stage TO stagecomplete    
      CALL s_transaction_end('Y','0')
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      CALL s_transaction_end('N','0')
      CALL cl_ask_confirm3("adz-00218","")      
   END IF   
END FUNCTION

PRIVATE FUNCTION abmp400_bmif019_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.l_bmif019
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_master.l_bmif019_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_master.l_bmif019_desc
END FUNCTION

PRIVATE FUNCTION abmp400_bmif020_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.l_bmif020
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master.l_bmif020_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_master.l_bmif020_desc
END FUNCTION

PRIVATE FUNCTION abmp400_oocql004_desc(p_oocql001,p_oocql002)
DEFINE p_oocql001    LIKE oocql_t.oocql001,
       p_oocql002    LIKE oocql_t.oocql002
DEFINE r_oocql004    LIKE oocql_t.oocql004

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_oocql001
   LET g_ref_fields[2] = p_oocql002
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_oocql004 = '', g_rtn_fields[1] , ''
   RETURN r_oocql004
END FUNCTION

PRIVATE FUNCTION abmp400_set_comp_entry()
   CALL cl_set_comp_required("l_bmif011,l_bmif012,l_bmif016",FALSE)
   CALL cl_set_comp_entry("l_bmif015,l_bmif016,l_bmif015c,l_bmif016c",TRUE)
END FUNCTION

PRIVATE FUNCTION abmp400_set_comp_noentry()
DEFINE l_oocq014  LIKE oocq_t.oocq014,
       l_oocq016  LIKE oocq_t.oocq016,
       pnode_target   om.DomNode
       
   IF NOT cl_null(g_master.l_bmif009) THEN     
      SELECT oocq014,oocq016 INTO l_oocq014,l_oocq016
        FROM oocq_t
       WHERE oocqent = g_enterprise
         AND oocq001 = '1116'
         AND oocq002 = g_master.l_bmif009      
      IF l_oocq014 = 'Y' THEN 
         CALL cl_set_comp_required("l_bmif011,l_bmif012",TRUE)
         LET g_master.l_bmif011 = g_today
         DISPLAY BY NAME g_master.l_bmif011
      END IF
      IF l_oocq016 = 'N' THEN 
         CALL cl_set_comp_entry("l_bmif015,l_bmif016,l_bmif015c,l_bmif016c",FALSE)
         LET g_master.l_bmif015 = ''
         LET g_master.l_bmif016 = ''
         DISPLAY BY NAME g_master.l_bmif015,g_master.l_bmif016
      ELSE
         IF cl_null(g_master.l_bmif015) THEN 
            CALL cl_set_comp_required("l_bmif016",TRUE)
         END IF
      END IF   
   END IF
   
END FUNCTION

PRIVATE FUNCTION abmp400_chk()
DEFINE l_oocq014  LIKE oocq_t.oocq014,
       l_oocq016  LIKE oocq_t.oocq016
DEFINE r_success  LIKE type_t.num5
DEFINE r_flag     LIKE type_t.chr1

   LET r_success = TRUE
   LET r_flag = 0
   IF NOT cl_null(g_master.l_bmif009) THEN     
      SELECT oocq014,oocq016 INTO l_oocq014,l_oocq016
        FROM oocq_t
       WHERE oocqent = g_enterprise
         AND oocq001 = '1116'
         AND oocq002 = g_master.l_bmif009      
      IF l_oocq014 = 'Y' THEN 
         IF cl_null(g_master.l_bmif011) THEN 
            LET r_success = FALSE
            LET r_flag = 1
         END IF
         IF cl_null(g_master.l_bmif012) THEN 
            LET r_success = FALSE
            LET r_flag = 2
         END IF         
      END IF
      IF l_oocq016 = 'Y' AND cl_null(g_master.l_bmif015) AND cl_null(g_master.l_bmif015) THEN 
         LET r_success = FALSE
         LET r_flag = 3
      END IF
   END IF
   RETURN r_success,r_flag
END FUNCTION

#end add-point
 
{</section>}
 
