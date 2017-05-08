#該程式未解開Section, 採用最新樣板產出!
{<section id="abmp001.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2015-01-05 10:13:31), PR版次:0005(2016-07-05 16:51:17)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000158
#+ Filename...: abmp001
#+ Description: 產品結構引入營運據點批次作業
#+ Creator....: 00768(2014-05-29 10:37:32)
#+ Modifier...: 00768 -SD/PR- 02295
 
{</section>}
 
{<section id="abmp001.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
# 141230 将据点放到下面单身中去
# 141231 By 00768 修改aimi150中手动自动的管理方式，abmm200中手动自动都能跳出框，区别在于自动的带出来直接勾选，手动的不勾，
#                 abmp001不限制aimi150中的条件，所有据点爱抛就抛
#                 修改已审核abmm200资料时，不需再根据aimi150设置判断同步更新哪些据点的资料，将所有据点的bom资料都更新
# 150105 抓取数据修改写法，提高效率
#160705-00004#1  2016/07/05 By xianghui BOM审核时检查BOM中有关的料件编号是否有抛转到各据点，抓取BOM有关料件时需加上据点为ALL，且特性需加上
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
                     bmaa001        LIKE bmaa_t.bmaa001,
                     bmaa001_desc1  LIKE type_t.chr80,
                     bmaa001_desc2  LIKE type_t.chr80,
                     bmaa002        LIKE bmaa_t.bmaa002,
                     imaa009        LIKE imaa_t.imaa009,
                     imaa009_desc   LIKE type_t.chr80
                     END RECORD
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"
DEFINE g_detail_idx         LIKE type_t.num5              #
DEFINE g_detail_d_t   type_g_detail_d
TYPE type_g_detail2_d RECORD
                     sel           LIKE type_t.chr1,
                     ooef001       LIKE ooef_t.ooef001,
                     ooef001_desc  LIKE type_t.chr80 
                     END RECORD
DEFINE g_detail2_cnt LIKE type_t.num5              #單身 總筆數(所有資料)
DEFINE g_detail2_d   DYNAMIC ARRAY OF type_g_detail2_d
DEFINE g_detail2_d_t  type_g_detail2_d

DEFINE g_wc_filter2         STRING
#end add-point
 
{</section>}
 
{<section id="abmp001.main" >}
#+ 作業開始 
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   DEFINE ls_js  STRING
   #add-point:main段define name="main.define"
   
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("abm","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_abmp001 WITH FORM cl_ap_formpath("abm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL abmp001_init()   
 
      #進入選單 Menu (="N")
      CALL abmp001_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_abmp001
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   CALL abmp001_drop_table()
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="abmp001.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION abmp001_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   DEFINE l_success    LIKE type_t.num5
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   LET g_wc_filter2  = " 1=1"
   CALL abmp001_create_table() RETURNING l_success
   CALL cl_set_toolbaritem_visible('filter',FALSE)
   CALL cl_set_toolbaritem_visible('qbeclear',FALSE)
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="abmp001.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION abmp001_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_bmaa001  STRING
   DEFINE l_bmaa002  STRING
   DEFINE l_imaa009  STRING
   DEFINE l_cnt      LIKE type_t.num5
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
         CALL abmp001_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT BY NAME g_wc ON bmaa001,bmaa002,imaa009
	   
            BEFORE CONSTRUCT
               LET g_wc_filter2  = " 1=1"

            ON ACTION controlp INFIELD bmaa001 #主件料号
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imaa001_2()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO bmaa001  #顯示到畫面上
               NEXT FIELD bmaa001                     #返回原欄位

            ON ACTION controlp INFIELD imaa009   #产品分类
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_rtax001()                          #呼叫開窗
               DISPLAY g_qryparam.return1 TO imaa009  #顯示到畫面上
               NEXT FIELD imaa009                    #返回原欄位

            #ON ACTION accept
               #ACCEPT DIALOG
            #   CALL abmp001_b_fill()

            #ON ACTION cancel
            #   LET INT_FLAG = 1
            #   EXIT DIALOG
         END CONSTRUCT
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT ARRAY g_detail_d FROM s_detail1.*
             ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
         
            BEFORE INPUT
               LET g_detail_cnt = g_detail_d.getLength()
         
            BEFORE ROW
               #LET l_cmd = ''
               LET l_ac = ARR_CURR()
               LET g_detail_idx = l_ac
               LET g_detail_cnt = g_detail_d.getLength()
               CALL abmp001_fetch()
               #LET l_cmd='u'
               LET g_detail_d_t.* = g_detail_d[l_ac].*  #BACKUP
         
            ON CHANGE sel
            #AFTER FIELD sel
               IF NOT cl_null(g_detail_d[l_ac].sel) THEN
                  IF g_detail_d[l_ac].sel NOT MATCHES '[YN]' THEN
                     NEXT FIELD CURRENT
                  END IF
               END IF
               UPDATE abmp001_bmaa SET sel = g_detail_d[l_ac].sel
                WHERE bmaa001 = g_detail_d[l_ac].bmaa001
                  AND bmaa002 = g_detail_d[l_ac].bmaa002
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "UPDATE abmp001_bmaa"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_detail_d[l_ac].sel = g_detail_d_t.sel
               ELSE
                  #更新据点
                  IF g_detail_d[l_ac].sel = 'N' THEN
                     UPDATE abmp001_ooef SET sel = 'N'
                      WHERE bmaa001 = g_detail_d[g_detail_idx].bmaa001
                        AND bmaa002 = g_detail_d[g_detail_idx].bmaa002
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "UPDATE abmp001_ooef"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                     ELSE
                        CALL abmp001_fetch()
                     END IF
                  END IF
               END IF

            ON ROW CHANGE
               IF INT_FLAG THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 9001
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET INT_FLAG = 0
                  #LET g_detail_d[l_ac].* = g_detail_d_t.*
                  NEXT FIELD sel
               END IF
         
            AFTER ROW
         
         
            AFTER INPUT
    
            #ON ACTION accept
            #   CALL abmp001_carry()
         END INPUT

         INPUT ARRAY g_detail2_d FROM s_detail2.*
             ATTRIBUTE(COUNT = g_detail2_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
         
            BEFORE INPUT
               CALL cl_set_comp_entry("sel2",TRUE)
               IF cl_null(g_detail_idx) OR g_detail_idx=0 THEN
                  CALL cl_set_comp_entry("sel2",FALSE)
                  NEXT FIELD sel
               END IF
               IF g_detail_d[g_detail_idx].sel = 'N' THEN
                  CALL cl_set_comp_entry("sel2",FALSE)
                  NEXT FIELD sel
               END IF
               LET g_detail2_cnt = g_detail2_d.getLength()
         
            BEFORE ROW
               LET l_ac = ARR_CURR()
               LET g_detail2_cnt = g_detail2_d.getLength()
               LET g_detail2_d_t.* = g_detail2_d[l_ac].*  #BACKUP

            ON CHANGE sel2
               IF NOT cl_null(g_detail2_d[l_ac].sel) THEN
                  IF g_detail2_d[l_ac].sel NOT MATCHES '[YN]' THEN
                     NEXT FIELD CURRENT
                  END IF
               END IF
               UPDATE abmp001_ooef SET sel = g_detail2_d[l_ac].sel
                WHERE bmaa001 = g_detail_d[g_detail_idx].bmaa001
                  AND bmaa002 = g_detail_d[g_detail_idx].bmaa002
                  AND ooef001 = g_detail2_d[l_ac].ooef001
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "UPDATE abmp001_ooef"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_detail2_d[l_ac].sel = g_detail2_d_t.sel
               END IF

            ON ROW CHANGE
               IF INT_FLAG THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 9001
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  LET INT_FLAG = 0
                  NEXT FIELD sel2
               END IF
               
            AFTER ROW
         
         
            AFTER INPUT
    
         END INPUT
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
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
            CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
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
            #上面这段可以不需要了
            CASE FGL_DIALOG_GETFIELDNAME()
               WHEN 'sel'
                    UPDATE abmp001_bmaa SET sel = 'Y'
               WHEN 'sel2'
                    IF NOT cl_null(g_detail_idx) AND g_detail_idx!=0 THEN
                       IF g_detail_d[g_detail_idx].sel = 'Y' THEN
                          UPDATE abmp001_ooef SET sel = 'Y'
                           WHERE bmaa001 = g_detail_d[g_detail_idx].bmaa001
                             AND bmaa002 = g_detail_d[g_detail_idx].bmaa002
                       END IF
                    END IF
            END CASE
            CALL abmp001_b_fill()
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
            #上面这段可以不需要了
            CASE FGL_DIALOG_GETFIELDNAME()
               WHEN 'sel'
                    UPDATE abmp001_bmaa SET sel = 'N'
                    UPDATE abmp001_ooef SET sel = 'N'
               WHEN 'sel2'
                    IF NOT cl_null(g_detail_idx) AND g_detail_idx!=0 THEN
                       UPDATE abmp001_ooef SET sel = 'N'
                        WHERE bmaa001 = g_detail_d[g_detail_idx].bmaa001
                          AND bmaa002 = g_detail_d[g_detail_idx].bmaa002
                    END IF
            END CASE
            CALL abmp001_b_fill()
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "Y"
               END IF
            END FOR
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            #上面这段可以不需要了
            CASE FGL_DIALOG_GETFIELDNAME()
               WHEN 'sel'
                    IF NOT cl_null(l_ac) AND l_ac!=0 THEN
                       UPDATE abmp001_bmaa SET sel = 'Y'
                        WHERE bmaa001 = g_detail_d[l_ac].bmaa001
                          AND bmaa002 = g_detail_d[l_ac].bmaa002
                    END IF
               WHEN 'sel2'
                    IF NOT cl_null(g_detail_idx) AND g_detail_idx!=0 AND NOT cl_null(l_ac) AND l_ac!=0 THEN
                       IF g_detail_d[g_detail_idx].sel = 'Y' THEN
                          UPDATE abmp001_ooef SET sel = 'Y'
                           WHERE bmaa001 = g_detail_d[g_detail_idx].bmaa001
                             AND bmaa002 = g_detail_d[g_detail_idx].bmaa002
                             AND ooef001 = g_detail2_d[l_ac].ooef001
                       END IF
                    END IF
            END CASE
            CALL abmp001_b_fill()
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
            END FOR
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            #上面这段可以不需要了
            CASE FGL_DIALOG_GETFIELDNAME()
               WHEN 'sel'
                    IF NOT cl_null(l_ac) AND l_ac!=0 THEN
                       UPDATE abmp001_bmaa SET sel = 'N'
                        WHERE bmaa001 = g_detail_d[l_ac].bmaa001
                          AND bmaa002 = g_detail_d[l_ac].bmaa002
                       UPDATE abmp001_ooef SET sel = 'N'
                        WHERE bmaa001 = g_detail_d[l_ac].bmaa001
                          AND bmaa002 = g_detail_d[l_ac].bmaa002
                    END IF
               WHEN 'sel2'
                    IF NOT cl_null(g_detail_idx) AND g_detail_idx!=0 AND NOT cl_null(l_ac) AND l_ac!=0 THEN
                       UPDATE abmp001_ooef SET sel = 'N'
                        WHERE bmaa001 = g_detail_d[g_detail_idx].bmaa001
                          AND bmaa002 = g_detail_d[g_detail_idx].bmaa002
                          AND ooef001 = g_detail2_d[l_ac].ooef001
                    END IF
            END CASE
            CALL abmp001_b_fill()
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL abmp001_filter()
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
            LET l_bmaa001 = GET_FLDBUF(bmaa001)
            LET l_bmaa002 = GET_FLDBUF(bmaa002)
            LET l_imaa009 = GET_FLDBUF(imaa009)
            IF cl_null(l_bmaa001) AND cl_null(l_bmaa002) AND cl_null(l_imaa009) THEN
               #请输入必要的条件！
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'anm-00328'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD bmaa001
            END IF
            #是否确定重新查询？
            SELECT COUNT(*) INTO l_cnt FROM abmp001_bmaa
            IF l_cnt > 0 THEN
               IF NOT cl_ask_confirm('asf-00234') THEN
                  NEXT FIELD bmaa001
               END IF
            END IF
            #end add-point
            CALL abmp001_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL abmp001_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"

         ON ACTION batch_execute
            CALL abmp001_carry()
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
 
{<section id="abmp001.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION abmp001_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   DEFINE l_cnt       LIKE type_t.num5
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_bmaa    RECORD
                     sel            LIKE type_t.chr1,
                     bmaa001        LIKE bmaa_t.bmaa001, #主件料号
                     bmaa002        LIKE bmaa_t.bmaa002, #特性
                     imaa009        LIKE imaa_t.imaa009  #产品分类
                    END RECORD
   DEFINE l_ooef001   LIKE ooef_t.ooef001   #营运据点
   DEFINE l_ooef    RECORD
                     sel            LIKE type_t.chr1,
                     bmaa001        LIKE bmaa_t.bmaa001,
                     bmaa002        LIKE bmaa_t.bmaa002,
                     ooef001        LIKE ooef_t.ooef001
                    END RECORD
   DEFINE l_count0  LIKE type_t.num5  #BOM笔数
   DEFINE l_count   LIKE type_t.num5  #据点笔数
   DEFINE l_count1  LIKE type_t.num5  #BOM+据点总笔数
   DEFINE l_cnt1    LIKE type_t.num5  #add 141231
   DEFINE l_cnt2    LIKE type_t.num5  #add 141231
   DEFINE l_choice  LIKE type_t.chr1
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   LET g_master_idx = l_ac
      
   CALL abmp001_delete_table() RETURNING l_success
   
   #mark 150105 旧写法 按141231修改的逻辑，原写法效能不满足需求，需调整写法
#   #--检查aimi150中的产品分类页签
#   #先抓出aimi150单头所有据点，及据点对应的产品分类设置信息
#   #如目的据点主件料号的产品分类，判断这个分类设置为bom打勾，而且引入方式为自动的，则在这个据点中拋转bom资料  #abmm200拋转是需要自动引入，abmp001都可以
#   #如不是，则这个据点不拋转，继续判断其他的据点是否需要抛转
#   #--检查aimi150中的料件页签
#   #先抓出aimi150单头所有据点，及据点对应的料件设置信息
#   #如目的据点的料件设置为bom引入，而且引入方式为自动的，则在这个据点中拋转bom资料  #abmm200拋转是需要自动引入，abmp001都可以
#   #如不是，则这个据点不拋转，继续判断其他的据点是否需要抛
#   #以上两者，只要一个满足就可以拋转
#   
#   #可拋转的营运据点
#   LET g_sql = " SELECT unique ooef001 ",
#               "   FROM ooef_t ",
#               "  WHERE ooefent = ",g_enterprise,
#               #mark 141231
#               #          #满足aimi150中的产品分类页签
#               #"    AND (ooef001 IN (select unique imda001 from imda_t ",
#               #"                      where imdaent = ",g_enterprise,
#               #"                        and imdastus= 'Y' ", #有效的
#               #"                        and imda005 = 'Y' ", #BOM引入
#               ##"                        and imda003 = '1' ", #自动引入  #abmm200拋转是需要自动引入，abmp001都可以
#               #"                        and imda002 = ? ) ", #产品分类
#               #"         OR ",
#               #          #满足aimi150中的料件页签
#               #"         ooef001 IN (select unique imdb001 from imdb_t ",
#               #"                      where imdbent = ",g_enterprise,
#               #"                        and imdbstus= 'Y' ", #有效的
#               #"                        and imdb005 = 'Y' ", #BOM引入
#               ##"                        and imdb003 = '1' ", #自动引入 #abmm200拋转是需要自动引入，abmp001都可以
#               #"                        and imdb002 = ? ) ",  #料件编号
#               #"         )"
#               #mark 141231 end
#               #add 141231
#               "    AND ooef201 = 'Y' ",  #据点
#               "    AND ooefstus= 'Y' ",
#               "    AND ooef001!= 'ALL' "
#               #add 141231 end
#   IF NOT cl_null(g_wc_filter2) THEN
#      LET g_sql = g_sql CLIPPED," AND ",g_wc_filter2 CLIPPED
#   END IF
#   PREPARE abmp001_query_p1 FROM g_sql
#   DECLARE abmp001_query_c1 CURSOR FOR abmp001_query_p1
#
#   #欲拋转的资料
#   LET g_sql = " SELECT unique 'Y',bmaa001,bmaa002,imaa009 ",
#               "   FROM bmaa_t,imaa_t ",
#               "  WHERE bmaa001 = imaa001 ",
#               "    AND bmaaent = imaaent ",
#               "    AND bmaaent = ? ",
#               "    AND bmaasite= 'ALL' ",
#               "    AND bmaastus= 'Y'  ",  #已审核
#               "    AND ",g_wc CLIPPED
#   PREPARE abmp001_query_p0 FROM g_sql
#   DECLARE abmp001_query_c0 CURSOR FOR abmp001_query_p0
#   #先抓取欲拋转的资料
#   LET l_count0 = 0
#   LET l_count1 = 0
#   FOREACH abmp001_query_c0 USING g_enterprise INTO l_bmaa.sel,l_bmaa.bmaa001,l_bmaa.bmaa002,l_bmaa.imaa009
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL 
#         LET g_errparam.extend = "FOREACH:" 
#         LET g_errparam.code   = SQLCA.sqlcode 
#         LET g_errparam.popup  = TRUE 
#         CALL cl_err()
#         EXIT FOREACH
#      END IF
#      
#      #再抓取可拋转的营运据点
#      OPEN abmp001_query_c1 #USING l_bmaa.imaa009,l_bmaa.bmaa001 #mark 141231
#      LET l_count = 0
#      FOREACH abmp001_query_c1 INTO l_ooef001
#         IF SQLCA.sqlcode THEN
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.code = SQLCA.sqlcode
#            LET g_errparam.extend = "FOREACH abmp001_query_c1:"
#            LET g_errparam.popup = TRUE
#            CALL cl_err()
#            EXIT FOREACH
#         END IF
#
#         #mark 141231 条件中已过滤
#         #IF l_ooef001 = 'ALL' THEN
#         #   CONTINUE FOREACH
#         #END IF
#         #mark 141231 end
#         
#         #检查目的营运中心是否已存在bom
#         LET l_cnt = 0
#         SELECT COUNT(*) INTO l_cnt FROM bmaa_t
#          WHERE bmaaent = g_enterprise
#            AND bmaasite= l_ooef001
#            AND bmaa001 = l_bmaa.bmaa001
#            AND bmaa002 = l_bmaa.bmaa002
#         IF l_cnt > 0 THEN
#            CONTINUE FOREACH
#         END IF
#         
#         IF l_count1 = 10000 THEN
#            #批次处理量比较多，若需继续等待请按（是）Y？若是需处理范围请按（否）N？
#            #数据处理量较多，若需继续等待请按1，若需返回请按2，默认为继续等待
#            LET l_choice = cl_ask_choice( cl_getmsg('abm-00244',g_lang))
#            IF l_choice = '2' THEN
#               RETURN
#            END IF
#         END IF
#      
#         LET l_ooef.sel     = 'Y' #mark 141231 mark还原直接Y，否则速度太慢
#         ##add 141231 获取自动手动
#         ##aimi150中的产品分类页签
#         #SELECT COUNT(*) INTO l_cnt1 FROM imda_t 
#         # WHERE imdaent = g_enterprise
#         #   AND imdastus= 'Y'  #有效的
#         #   AND imda005 = 'Y'  #BOM引入
#         #   AND imda001 = l_ooef001   #据点
#         #   AND (imda002 = 'ALL' OR imda002 = l_bmaa.imaa009)  #产品分类
#         #   AND imda003 = '1'  #自动引入
#         ##aimi150中的料件页签
#         #SELECT COUNT(*) INTO l_cnt2 FROM imdb_t 
#         # WHERE imdbent = g_enterprise
#         #   AND imdbstus= 'Y'  #有效的
#         #   AND imdb005 = 'Y'  #BOM引入
#         #   AND imdb001 = l_ooef001   #据点
#         #   AND l_bmaa.bmaa001 LIKE replace(replace(imdb002,'*','%'),'?','_')    #料件编号
#         #   AND imdb003 = '1'  #自动引入
#         #IF l_cnt1 > 0 OR l_cnt2 > 0 THEN
#         #   LET l_ooef.sel = 'Y'
#         #ELSE
#         #   LET l_ooef.sel = 'N'
#         #END IF
#         ##add 141231 end
#
#         LET l_ooef.bmaa001 = l_bmaa.bmaa001
#         LET l_ooef.bmaa002 = l_bmaa.bmaa002
#         LET l_ooef.ooef001 = l_ooef001
#         
#         INSERT INTO abmp001_ooef VALUES (l_ooef.*)
#         IF SQLCA.sqlcode THEN
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.code = SQLCA.sqlcode
#            LET g_errparam.extend = "insert abmp001_ooef"
#            LET g_errparam.popup = TRUE
#            CALL cl_err()
#            EXIT FOREACH
#         END IF
#         
#         LET l_count = l_count + 1
#         LET l_count1 = l_count1 + 1
#      END FOREACH
#      
#      #有据点资料，才产生料件资料
#      IF l_count > 0 THEN
#         INSERT INTO abmp001_bmaa VALUES (l_bmaa.*)
#         IF SQLCA.sqlcode THEN
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.code = SQLCA.sqlcode
#            LET g_errparam.extend = "insert abmp001_ooef"
#            LET g_errparam.popup = TRUE
#            CALL cl_err()
#            EXIT FOREACH
#         END IF
#         LET l_count0 = l_count0 + 1
#      END IF
#   END FOREACH
#   FREE abmp001_query_c0
#   FREE abmp001_query_c1
   #mark 150105 旧写法 end
   
   #add 150105 新写法
   #检查是否有可拋转的据点
   SELECT COUNT(ooef001) INTO l_cnt FROM ooef_t 
    WHERE ooefent = g_enterprise
      AND ooef201 = 'Y'   #据点
      AND ooefstus= 'Y' 
      AND ooef001!= 'ALL' 
   IF l_cnt = 0 THEN
      #无据点可抛
      RETURN
   END IF
   
   #取欲拋转的资料abmp001_bmaa
   LET g_sql = " INSERT INTO abmp001_bmaa(sel,bmaa001,bmaa002,imaa009) ",
               " SELECT unique 'Y',bmaa001,bmaa002,imaa009 ",
               "   FROM bmaa_t,imaa_t ",
               "  WHERE bmaa001 = imaa001 ",
               "    AND bmaaent = imaaent ",
               "    AND bmaaent = ",g_enterprise,
               "    AND bmaasite= 'ALL' ",
               "    AND bmaastus= 'Y'  ",  #已审核
               "    AND ",g_wc CLIPPED
   PREPARE abmp001_query_p0 FROM g_sql
   EXECUTE abmp001_query_p0
   DISPLAY g_sql
   IF SQLCA.sqlcode THEN
      IF SQLCA.sqlcode = -6372 AND SQLCA.sqlerrd[2]=-1654 THEN
         #数据量过大，请缩小查询范围！
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'abm-00245'
         LET g_errparam.extend = "EXECUTE abmp001_query_p0:"
         LET g_errparam.sqlerr = SQLCA.sqlerrd[2]
         LET g_errparam.popup = TRUE
         DELETE FROM abmp001_bmaa
         DELETE FROM abmp001_ooef
         CALL cl_err()
         RETURN
      ELSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "EXECUTE abmp001_query_p0:"
         LET g_errparam.sqlerr = SQLCA.sqlerrd[2]
         LET g_errparam.popup = TRUE
         CALL cl_err()
         DELETE FROM abmp001_bmaa
         DELETE FROM abmp001_ooef
         RETURN
      END IF
   END IF
   FREE abmp001_query_p0
   
   #可拋转的营运据点abmp001_ooef
   LET g_sql = " INSERT INTO abmp001_ooef(sel,bmaa001,bmaa002,ooef001) ",
               " SELECT unique 'Y',a.bmaa001,a.bmaa002,b.ooef001 ",
               "   FROM abmp001_bmaa a,ooef_t b ",
               #ooef条件
               "  WHERE ooefent = ",g_enterprise,
               "    AND ooef201 = 'Y' ",  #据点
               "    AND ooefstus= 'Y' ",
               "    AND ooef001!= 'ALL' ",
               #排除目的营运中心已存在bom的
               "    AND NOT EXISTS(SELECT 1 FROM bmaa_t c ",
               "                    WHERE c.bmaaent =",g_enterprise,
               "                      AND c.bmaasite=b.ooef001 ",
               "                      AND c.bmaa001 =a.bmaa001 ",
               "                      AND c.bmaa002 =a.bmaa002) "
   IF NOT cl_null(g_wc_filter2) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc_filter2 CLIPPED
   END IF
   PREPARE abmp001_query_p1 FROM g_sql
   EXECUTE abmp001_query_p1
   IF SQLCA.sqlcode THEN
      IF SQLCA.sqlcode = -6372 AND SQLCA.sqlerrd[2]=-1654 THEN
         #数据量过大，请缩小查询范围！
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'abm-00245'
         LET g_errparam.extend = "EXECUTE abmp001_query_p1:"
         LET g_errparam.sqlerr = SQLCA.sqlerrd[2]
         LET g_errparam.popup = TRUE
         CALL cl_err()
         DELETE FROM abmp001_bmaa
         DELETE FROM abmp001_ooef
         RETURN
      ELSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "EXECUTE abmp001_query_p1:"
         LET g_errparam.sqlerr = SQLCA.sqlerrd[2]
         LET g_errparam.popup = TRUE
         CALL cl_err()
         DELETE FROM abmp001_bmaa
         DELETE FROM abmp001_ooef
         RETURN
      END IF
   END IF    
   FREE abmp001_query_p1
   #add 150105 新写法 end
   #end add-point
        
   LET g_error_show = 1
   CALL abmp001_b_fill()
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
 
{<section id="abmp001.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION abmp001_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
 
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   LET g_sql = " SELECT unique sel,bmaa001,imaal003,imaal004,bmaa002,imaa009,rtaxl003 ",
               "   FROM abmp001_bmaa LEFT OUTER JOIN imaal_t ON imaalent=",g_enterprise," AND imaal001=bmaa001 AND imaal002='",g_lang,"' ",
               "                     LEFT OUTER JOIN rtaxl_t ON rtaxlent=",g_enterprise," AND imaa009=rtaxl001 AND rtaxl002='",g_lang,"' ",
               "  WHERE ",g_enterprise,"=? ",  #为下面USING g_enterprise的写法
               "  ORDER BY bmaa001,bmaa002 "
   #end add-point
 
   PREPARE abmp001_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR abmp001_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   CALL g_detail2_d.clear()
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
   g_detail_d[l_ac].sel,g_detail_d[l_ac].bmaa001,g_detail_d[l_ac].bmaa001_desc1,g_detail_d[l_ac].bmaa001_desc2,
   g_detail_d[l_ac].bmaa002,g_detail_d[l_ac].imaa009,g_detail_d[l_ac].imaa009_desc
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
      
      CALL abmp001_detail_show()      
 
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
   CALL g_detail_d.deleteElement(l_ac)
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE abmp001_sel
   
   LET l_ac = 1
   CALL abmp001_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="abmp001.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION abmp001_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define name="fetch.define"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後 name="fetch.after_fill"
   #显示据点单身
   IF l_ac > g_detail_cnt THEN LET l_ac = g_detail_cnt END IF
   LET g_detail_idx = l_ac
   IF cl_null(g_detail_idx) OR g_detail_idx=0 THEN LET g_detail_idx=1 END IF
   LET g_sql = " SELECT sel,ooef001,ooefl003 ",
               "   FROM abmp001_ooef LEFT OUTER JOIN ooefl_t ON ooeflent=",g_enterprise," and ooefl001=ooef001 and ooefl002='",g_lang,"' ",
               "  WHERE bmaa001 = '",g_detail_d[g_detail_idx].bmaa001,"' ",
               "    AND bmaa002 = '",g_detail_d[g_detail_idx].bmaa002,"' ",
               "  ORDER BY ooef001 "
   PREPARE abmp001_fetch_p FROM g_sql
   DECLARE abmp001_fetch_c CURSOR FOR abmp001_fetch_p
   CALL g_detail2_d.clear()
   LET l_ac = 1   
   FOREACH abmp001_fetch_c INTO g_detail2_d[l_ac].sel,g_detail2_d[l_ac].ooef001,g_detail2_d[l_ac].ooef001_desc
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
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
   CALL g_detail2_d.deleteElement(l_ac)
   LET g_detail2_cnt = l_ac - 1 
   CLOSE abmp001_fetch_c
   FREE abmp001_fetch_p
   #end add-point 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="abmp001.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION abmp001_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="abmp001.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION abmp001_filter()
   #add-point:filter段define(客製用) name="filter.define_customerization"
   
   #end add-point    
   #add-point:filter段define name="filter.define"
   CALL abmp001_filter2()  #二次筛选先临时用此FUNCTION
   RETURN #临时用abmp001_filter2()
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
   
   CALL abmp001_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="abmp001.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION abmp001_filter_parser(ps_field)
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
 
{<section id="abmp001.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION abmp001_filter_show(ps_field,ps_object)
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
   LET ls_condition = abmp001_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="abmp001.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 建立临时表
# Memo...........:
# Usage..........: CALL abmp001_create_table()
#                  RETURNING r_success
# Input parameter: 无
# Return code....: r_success   处理状态
# Date & Author..: 2014/12/30 By zhangllc
# Modify.........:
################################################################################
PRIVATE FUNCTION abmp001_create_table()
   DEFINE r_success   LIKE type_t.num5
   
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE

   #检查事务中
   IF NOT s_transaction_chk('N',1) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   #建立临时表
   DROP TABLE abmp001_bmaa;
   CREATE TEMP TABLE abmp001_bmaa(
                     sel             VARCHAR(1),
                     bmaa001         VARCHAR(40),
                     bmaa002         VARCHAR(30),
                     imaa009         VARCHAR(10)
   );
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create abmp001_bmaa'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   CREATE UNIQUE INDEX abmp001_bmaa_01 on abmp001_bmaa (bmaa001,bmaa002)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create abmp001_bmaa:index'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   DROP TABLE abmp001_ooef;
   CREATE TEMP TABLE abmp001_ooef(
                     sel             VARCHAR(1),
                     bmaa001         VARCHAR(40),
                     bmaa002         VARCHAR(30),
                     ooef001         VARCHAR(10)
   );
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create abmp001_ooef'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   CREATE UNIQUE INDEX abmp001_ooef_01 on abmp001_ooef (bmaa001,bmaa002,ooef001)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create abmp001_ooef:index'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 删除临时表
# Memo...........:
# Usage..........: CALL abmp001_drop_table()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/12/30 By zhangllc
# Modify.........:
################################################################################
PRIVATE FUNCTION abmp001_drop_table()
   DEFINE r_success   LIKE type_t.num5
   
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE

   #检查事务中
   IF NOT s_transaction_chk('N',1) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   DROP TABLE abmp001_bmaa
   DROP TABLE abmp001_ooef
   
   #RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 清除临时表资料
# Memo...........:
# Usage..........: CALL abmp001_delete_table()
#                  RETURNING r_success
# Input parameter: 无
# Return code....: r_success   处理状态
# Date & Author..: 2014/12/30 By zhangllc
# Modify.........:
################################################################################
PRIVATE FUNCTION abmp001_delete_table()
   DEFINE r_success   LIKE type_t.num5
   
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE

   DELETE FROM abmp001_bmaa
   DELETE FROM abmp001_ooef
   
   RETURN r_success
END FUNCTION
#二次筛选
PRIVATE FUNCTION abmp001_filter2()
   #DEFINE l_filter_wc    STRING
   #
   #DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   #
   #   CONSTRUCT l_filter_wc ON #bmaasite,
   #                            bmaa001,bmaa002,imaa009
   #        FROM #s_detail1[1].b_bmaasite,
   #             s_detail1[1].b_bmaa001, s_detail1[1].b_bmaa002,s_detail1[1].b_imaa009
   #        
   #      ##营运据点
   #      #ON ACTION controlp INFIELD b_bmaasite
   #      #   INITIALIZE g_qryparam.* TO NULL
   #      #   LET g_qryparam.state = 'c'
   #      #   LET g_qryparam.reqry = FALSE
   #      #   CALL q_bmaasite()
   #      #   DISPLAY g_qryparam.return1 TO b_bmaasite
   #      #   NEXT FIELD b_bmaasite
   #         
   #      #主件料号
   #      ON ACTION controlp INFIELD b_bmaa001
   #         INITIALIZE g_qryparam.* TO NULL
   #         LET g_qryparam.state = 'c'
   #         LET g_qryparam.reqry = FALSE
   #         CALL q_imaa001_9()
   #         DISPLAY g_qryparam.return1 TO b_bmaa001
   #         NEXT FIELD b_bmaa001
   #         
   #      #特性
   #      ON ACTION controlp INFIELD b_bmaa002
   #         INITIALIZE g_qryparam.* TO NULL
   #         LET g_qryparam.state = 'c'
   #         LET g_qryparam.reqry = FALSE
   #         CALL q_bmaa002_1()
   #         DISPLAY g_qryparam.return1 TO b_bmaa002
   #         NEXT FIELD b_bmaa002
   #      
   #      #产品分类
   #      ON ACTION controlp INFIELD b_imaa009
   #         INITIALIZE g_qryparam.* TO NULL
   #         LET g_qryparam.state = 'c'
   #         LET g_qryparam.reqry = FALSE
   #         CALL q_imaa009_1()
   #         DISPLAY g_qryparam.return1 TO b_imaa009
   #         NEXT FIELD b_imaa009
   #   END CONSTRUCT
   #
   #   CONSTRUCT g_wc_filter2 ON ooef001
   #        FROM s_detail1[1].ooef001
   #        
   #      #营运据点
   #      ON ACTION controlp INFIELD b_bmaasite
   #         INITIALIZE g_qryparam.* TO NULL
   #         LET g_qryparam.state = 'c'
   #         LET g_qryparam.reqry = FALSE
   #         CALL q_bmaasite()
   #         DISPLAY g_qryparam.return1 TO b_bmaasite
   #         NEXT FIELD b_bmaasite
   #         
   #   END CONSTRUCT
   #   
   #   ON ACTION accept
   #      ACCEPT DIALOG
   #   
   #   ON ACTION cancel
   #      LET INT_FLAG = 1
   #      EXIT DIALOG
   #
   #   #交談指令共用ACTION
   #   &include "common_action.4gl"
   #      CONTINUE DIALOG
   #
   #END DIALOG
   #
   #IF NOT cl_null(l_filter_wc) THEN
   #   LET g_wc = g_wc CLIPPED,' AND ',l_filter_wc
   #END IF
   #
   #CALL abmp001_b_fill()
END FUNCTION

PRIVATE FUNCTION abmp001_carry()
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_cnt      LIKE type_t.num5
   DEFINE l_count    LIKE type_t.num5   #执行笔数
   DEFINE l_idx      LIKE type_t.num5
   DEFINE l_bmaa001  LIKE bmaa_t.bmaa001
   DEFINE l_bmaa002  LIKE bmaa_t.bmaa002
   DEFINE l_ooef001  LIKE ooef_t.ooef001
   
   LET g_detail_cnt = g_detail_d.getLength()
   IF g_detail_cnt = 0 THEN
      #请先选取资料
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'abm-00098'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF
   
   IF NOT cl_ask_confirm('abm-00096') THEN
      RETURN
   END IF
   
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #CALL cl_progress_bar_no_window(g_detail_cnt)
      SELECT COUNT(abmp001_ooef.ooef001) INTO l_cnt
        FROM abmp001_bmaa,abmp001_ooef
       WHERE abmp001_bmaa.bmaa001 = abmp001_ooef.bmaa001
         AND abmp001_bmaa.bmaa002 = abmp001_ooef.bmaa002
         AND abmp001_bmaa.sel = 'Y'
         AND abmp001_ooef.sel = 'Y'
      CALL cl_progress_bar_no_window(l_cnt)
   END IF
   
   CALL s_transaction_begin()
   
   LET g_sql = " SELECT abmp001_ooef.bmaa001,abmp001_ooef.bmaa002,abmp001_ooef.ooef001 ",
               "   FROM abmp001_bmaa,abmp001_ooef ",
               "  WHERE abmp001_bmaa.bmaa001 = abmp001_ooef.bmaa001 ",
               "    AND abmp001_bmaa.bmaa002 = abmp001_ooef.bmaa002 ",
               "    AND abmp001_bmaa.sel = 'Y' ",
               "    AND abmp001_ooef.sel = 'Y' "
   PREPARE abmp001_carry_p FROM g_sql
   DECLARE abmp001_carry_c CURSOR FOR abmp001_carry_p
   LET l_count = 0
   FOREACH abmp001_carry_c INTO l_bmaa001,l_bmaa002,l_ooef001
      IF g_bgjob <> "Y" THEN
         CALL cl_progress_no_window_ing(l_ooef001||'/'||l_bmaa001||'/'||l_bmaa002)
      END IF
      
      #IF g_detail_d[l_idx].sel = 'N' THEN
      #   CONTINUE FOR
      #END IF
      
      #检查目的营运中心是否已存在bom
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt FROM bmaa_t
       WHERE bmaaent = g_enterprise
         AND bmaasite= l_ooef001
         AND bmaa001 = l_bmaa001
         AND bmaa002 = l_bmaa002
      IF l_cnt > 0 THEN
         CONTINUE FOREACH
      END IF
      
      #检查料号是否已拋转，未拋转的需先拋转料
      CALL s_abmm200_carry_chk_item(l_bmaa001,l_bmaa002,l_ooef001)   #160705-00004#1 add bmaa002
           RETURNING l_success
      IF NOT l_success THEN
         CALL s_transaction_end('N','0')
         #执行失败
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'adz-00218'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN
      END IF
      
      #复制资料到目的营运中心
      CALL s_abmm200_carry_copy(l_bmaa001,l_bmaa002,l_ooef001) RETURNING l_success
      IF NOT l_success THEN
         CALL s_transaction_end('N','0')
         #执行失败
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'adz-00218'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN
      END IF
      
      LET l_count = l_count + 1
      
   END FOREACH

   CALL s_transaction_end('Y','0') 
   #执行成功
   #CALL cl_err('','adz-00217',1)
   #资料拋转成功！（拋转笔数：%1笔）
   INITIALIZE g_errparam TO NULL
   LET g_errparam.code = 'abm-00097'
   LET g_errparam.extend = ''
   LET g_errparam.popup = TRUE
   LET g_errparam.replace[1] = l_count
   CALL cl_err()


END FUNCTION

#end add-point
 
{</section>}
 
