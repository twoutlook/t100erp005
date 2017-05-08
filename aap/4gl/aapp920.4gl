#該程式未解開Section, 採用最新樣板產出!
{<section id="aapp920.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0022(2014-10-27 11:43:22), PR版次:0022(2017-01-16 15:44:32)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000164
#+ Filename...: aapp920
#+ Description: 應付帳款重評價計算作業
#+ Creator....: ()
#+ Modifier...: 04152 -SD/PR- 01531
 
{</section>}
 
{<section id="aapp920.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#150128-00003#1  15/01/28 By Reanna  未沖金額回推取範圍時加上日期
#150127-00007#1  15/02/24 By Reanna  掃把清空&給預設值&筆數顯示異常處理
#150226          15/02/26 By Reanna  重評價之後本幣要取位
#150313          15/03/13 By Reanna  取上期匯差前的變數要清空
#150318          15/03/18 By Reanna  如果是待抵項目，未沖金額要先作負數處理
#150320          15/03/20 By Reanna  若匯差金額=0則歸屬在借方，預帶借方科目
#150413          15/04/13 By Reanna  應取上期累積匯差而不是上期匯差故改取xreb116
#150513          15/05/13 By Reanna  增加還原前檢核是否已有拋傳票，若有產生傳票
#150812-00010#3  15/08/28 By apo     檢核年月不可執行時,則應RETURN
#151022          15/10/22 By albireo 立帳來源是員工(12,15)時核算項人員應給apca057,避免後續傳票核算項核對不合理
#151020-00003#4  15/10/26 By Jessy   只能執行關帳年月對應之年度月份之資料
#151013-00019#8  15/10/30 By Reanna  aapp920抓取未沖金額SQL需依aoos020沖帳參數不同拆分
#                                    重評價調匯，若是aapt330/aapt331 者，核算項的人員應取受款對象(331待抵單未納入)
#151202          15/12/02 By Jessy   kris:期別一改變就帶出單身的日期
#151204          15/12/04 By 03538   超過月結日期之沖銷額回溯,也必須抓到aapt3*被直接沖銷的部分
#160802-00001#1  16/08/02 By Reanna  處理金額未取位問題
#160812-00027#3  16/08/16 By 06821   全面盤點應付程式帳套權限控管
#160829-00004#1  16/08/29 By 08729   處理取匯率但幣別取錯
#160905-00002#1  16/09/05 By Reanna  SQL條件少ENT補上
#161006-00005#3  16/10/12 By 08732   組織類型與職能開窗調整
#161104-00019#1  161108   By albireo 帳務中心跨法人所以不應限制資料只能帳務中心條件
#161104-00024#1  16/11/11 By 08729   處理DEFINE有星號
#170116-00037#1  17/01/16 By 01531   ａｘｒｐ９２０，　ａａｐｐ９２０　調匯生時，如果沖銷參數＝３，　摘要給空值
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
   sel           LIKE type_t.chr1,
   xrebld        LIKE xreb_t.xrebld,
   glaal002      LIKE glaal_t.glaal002,
   glaacomp      LIKE glaa_t.glaacomp,
   ooefl003      LIKE ooefl_t.ooefl003,
   glaa001       LIKE glaa_t.glaa001,
   glav004_1     LIKE glav_t.glav004,
   glav004_2     LIKE glav_t.glav004,
   glca002       LIKE glca_t.glca002,
   glca003       LIKE glca_t.glca003,
   xreb023       LIKE xreb_t.xreb023
END RECORD   
TYPE type_master RECORD
  xrebsite      LIKE xreb_t.xrebsite, 
  xrebsite_desc LIKE type_t.chr80,
  xreb001       LIKE xreb_t.xreb001, 
  xreb002       LIKE xreb_t.xreb002
      END RECORD
DEFINE g_master    type_master  
DEFINE l_sfin3007  LIKE type_t.chr80
DEFINE l_xreb001   LIKE xreb_t.xreb001
DEFINE l_xreb002   LIKE xreb_t.xreb002
DEFINE g_flag      LIKE type_t.chr1    #條件範圍是否有資料
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aapp920.main" >}
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
   CALL cl_ap_init("aap","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aapp920 WITH FORM cl_ap_formpath("aap",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aapp920_init()   
 
      #進入選單 Menu (="N")
      CALL aapp920_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aapp920
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aapp920.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aapp920_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   DEFINE l_array DYNAMIC ARRAY OF RECORD
                  value       STRING,
                  label_tag   STRING,
                  label       STRING
              END RECORD
   DEFINE i       LIKE type_t.num5
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('b_glca002','8317')
   CALL cl_set_combo_scc('b_glca003','8724')   
   CALL s_fin_set_comp_scc('xreb001','43')   #年度
   CALL s_fin_set_comp_scc('xreb002','111')  #期別
   #(單頭以帳務中心角度抓其下帳別範圍,因此會對應到多個帳別,故無法依照個別會計週期設定為12或13期,因此預設下拉到13期)
   
   #150127-00007#1 mark---
   #為了掃把清空時給預設所以移至 aapp920_qbe_clear()裡面
   #LET g_master.xrebsite = g_site
   ##預設年度/期別
   #CALL cl_get_para(g_enterprise,g_master.xrebsite,'S-FIN-3007') RETURNING l_sfin3007
   #LET g_master.xreb001 = YEAR(l_sfin3007)
   #LET g_master.xreb002 = MONTH(l_sfin3007)   
   #150127-00007#1 mark end---
   
   #展組織下階成員所需之暫存檔
   CALL s_fin_create_account_center_tmp()
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aapp920.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aapp920_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_sfin30072 LIKE type_t.chr80
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   #150127-00007#1
   CALL aapp920_qbe_clear()
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aapp920_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT BY NAME g_master.xrebsite,g_master.xreb001,g_master.xreb002
            ATTRIBUTE(WITHOUT DEFAULTS) 


            AFTER FIELD xrebsite

               LET g_master.xrebsite_desc = ' '
               DISPLAY BY NAME g_master.xrebsite_desc
               IF NOT cl_null(g_master.xrebsite) THEN
                  CALL s_fin_account_center_with_ld_chk(g_master.xrebsite,'','','3','N','',g_today) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD xrebsite
                  END IF               
                  CALL cl_get_para(g_enterprise,g_master.xrebsite,'S-FIN-3007') RETURNING l_sfin3007
                  LET g_master.xreb001 = YEAR(l_sfin3007)
                  LET g_master.xreb002 = MONTH(l_sfin3007)
                  #預設關帳之年月
                  LET l_xreb001 = g_master.xreb001                  
                  LET l_xreb002 = g_master.xreb002
               END IF           
               LET g_master.xrebsite_desc = s_desc_get_department_desc(g_master.xrebsite)
               DISPLAY BY NAME g_master.xrebsite_desc
               
            AFTER FIELD xreb001
               IF g_master.xreb001 < l_xreb001 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'anm-00248'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  LET g_master.xreb001 = l_xreb001
                  NEXT FIELD CURRENT  
               END IF      
               
            AFTER FIELD xreb002
               IF g_master.xreb001 = l_xreb001 AND g_master.xreb002 < l_xreb002 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'anm-00249'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  LET g_master.xreb002 = l_xreb002
                  NEXT FIELD CURRENT               
               END IF  
            
            #151202 ---s   
            #kris: 期別一改變就帶出單身的日期            
            ON CHANGE xreb001
               IF NOT cl_null(g_master.xreb001) THEN
                  CALL aapp920_b_fill()                           
               END IF
               
            ON CHANGE xreb002
               IF NOT cl_null(g_master.xreb002) THEN
                  CALL aapp920_b_fill()                         
               END IF
            #151202 ---e
               
            ON ACTION controlp INFIELD xrebsite

               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.xrebsite       #給予default值
               #LET g_qryparam.where = " ooef201 = 'Y' "       #160812-00027#3 mark
               #CALL q_ooef001()     #161006-00005#3  mark
               CALL q_ooef001_46()   #161006-00005#3  add         #呼叫開窗
               LET g_master.xrebsite = g_qryparam.return1        #將開窗取得的值回傳到變數
               CALL s_desc_get_department_desc(g_master.xrebsite) RETURNING g_master.xrebsite_desc
               DISPLAY BY NAME g_master.xrebsite,g_master.xrebsite_desc
               NEXT FIELD xrebsite                 

         END INPUT
         
         
         INPUT ARRAY g_detail_d FROM s_detail1.*
            ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                      INSERT ROW = FALSE,
                      DELETE ROW = FALSE,
                      APPEND ROW = FALSE)

            #150127-00007#1
            BEFORE ROW
               LET l_ac = ARR_CURR()
               DISPLAY l_ac TO FORMONLY.h_index

            ON CHANGE b_sel
               LET l_ac = ARR_CURR()               
               IF g_detail_d[l_ac].sel = 'Y' THEN
                  #已有重評傳票不可重計算
                  IF NOT cl_null(g_detail_d[l_ac].xreb023) THEN
                     LET g_detail_d[l_ac].sel = 'N'   
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axr-00118'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = FALSE
                     CALL cl_err()  
                  END IF   
                  #02097--(S)
                  CALL s_aap_evaluation_chk('1','AP',g_detail_d[l_ac].xrebld,g_detail_d[l_ac].glaacomp,g_master.xreb001,g_master.xreb002) 
                       RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     LET g_detail_d[l_ac].sel = 'N'
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = FALSE
                     CALL cl_err()               
                  END IF
                  #02097--(E)
                  ##取所屬法人關帳日
                  #CALL cl_get_para(g_enterprise,g_detail_d[l_ac].glaacomp,'S-FIN-3007') RETURNING l_sfin30072
                  ##所屬法人關帳日期單頭年度期別不同
                  #IF g_master.xreb001 <> YEAR(l_sfin30072) OR g_master.xreb002 <> MONTH(l_sfin30072) THEN
                  #   LET g_detail_d[l_ac].sel = 'N'   
                  #   INITIALIZE g_errparam TO NULL
                  #   LET g_errparam.code = 'aap-00138'
                  #   LET g_errparam.extend = ''
                  #   LET g_errparam.popup = FALSE
                  #   CALL cl_err()                 
                  #END IF
               END IF
                         
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
            #已有重評傳票不可勾選
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF NOT cl_null(g_detail_d[li_idx].xreb023) THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
               #151020-00003#4---s
               #一樣要針對關帳日期作檢核
               CALL s_aap_evaluation_chk('1','AP',g_detail_d[li_idx].xrebld,g_detail_d[li_idx].glaacomp,g_master.xreb001,g_master.xreb002) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN LET g_detail_d[li_idx].sel = 'N' END IF
               #151020-00003#4---e
            END FOR
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
            #151020-00003#4---s
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "Y"
               END IF
               IF NOT cl_null(g_detail_d[li_idx].xreb023) THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
               CALL s_aap_evaluation_chk('1','AP',g_detail_d[li_idx].xrebld,g_detail_d[li_idx].glaacomp,g_master.xreb001,g_master.xreb002) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN LET g_detail_d[li_idx].sel = 'N' END IF
            END FOR
            #151020-00003#4---e
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
            CALL aapp920_filter()
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
            CALL aapp920_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            #150127-00007#1
            CALL aapp920_qbe_clear()
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL aapp920_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            CALL aapp920_process()
            IF g_success ='N' THEN
               CONTINUE DIALOG
            END IF
            #執行成功
            IF g_success = "Y" THEN            
               CALL cl_ask_confirm3("std-00012","")
            END IF
            NEXT FIELD xrebsite         
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
 
{<section id="aapp920.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aapp920_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   IF g_master.xreb001 < l_xreb001 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'anm-00248'
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()
      LET g_master.xreb001 = l_xreb001
      RETURN  
   END IF 

   IF g_master.xreb001 = l_xreb001 AND g_master.xreb002 < l_xreb002 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'anm-00249'
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()
      LET g_master.xreb002 = l_xreb002
      RETURN
   END IF    
   #end add-point
        
   LET g_error_show = 1
   CALL aapp920_b_fill()
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
 
{<section id="aapp920.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aapp920_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_glaa003       LIKE glaa_t.glaa003
   DEFINE l_flag           LIKE type_t.chr1
   DEFINE l_errno          LIKE type_t.chr100
   DEFINE l_glav002        LIKE glav_t.glav002
   DEFINE l_glav005        LIKE glav_t.glav005
   DEFINE l_sdate_s        LIKE glav_t.glav004
   DEFINE l_sdate_e        LIKE glav_t.glav004
   DEFINE l_glav006        LIKE glav_t.glav006
   DEFINE l_pdate_s        LIKE glav_t.glav004
   DEFINE l_pdate_e        LIKE glav_t.glav004
   DEFINE l_glav007        LIKE glav_t.glav007
   DEFINE l_wdate_s        LIKE glav_t.glav004
   DEFINE l_wdate_e        LIKE glav_t.glav004   
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"

   #取得帳務組織下所屬成員
   CALL s_fin_account_center_sons_query('3',g_master.xrebsite,g_today,'1')
   #取得帳務組織下所屬成員之帳別   
   CALL s_fin_account_center_ld_str() RETURNING ls_wc
   #將取回的字串轉換為SQL條件
   CALL s_fin_get_wc_str(ls_wc) RETURNING ls_wc
   

   LET g_sql =" SELECT 'N',glaald,'',glaacomp,'','','','',glca002,glca003,'' ",
              "   FROM glaa_t,glca_t ",
              "  WHERE glaaent = ? ",
              "    AND glaaent = glcaent ",
              "    AND glaald = glcald ",
              "    AND glca001 = 'AP' ",
              "    AND glca002 <> '1' ",    #無重評不撈出           
              "    AND glaald IN ",ls_wc,    
              "  ORDER BY glaald,glaacomp "       

   #end add-point
 
   PREPARE aapp920_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aapp920_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
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
      
      #add-point:b_fill段資料填充 name="b_fill.foreach_iside"

      LET l_glaa003 = ''   
      #取得會計週期參照表
      CALL s_ld_sel_glaa(g_detail_d[l_ac].xrebld,'glaa001|glaa003')
      RETURNING  g_sub_success,g_detail_d[l_ac].glaa001,l_glaa003

      #依年度+期別取得會計週期起迄日
      CALL s_get_accdate(l_glaa003,'',g_master.xreb001,g_master.xreb002)
      RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e    
      LET g_detail_d[l_ac].glav004_1 = l_pdate_s
      LET g_detail_d[l_ac].glav004_2 = l_pdate_e
      #帳套名稱
      LET g_detail_d[l_ac].glaal002 = s_desc_get_ld_desc(g_detail_d[l_ac].xrebld)
      #法人名稱
      LET g_detail_d[l_ac].ooefl003 = s_desc_get_department_desc(g_detail_d[l_ac].glaacomp)      

      SELECT UNIQUE xreb023 INTO g_detail_d[l_ac].xreb023
        FROM xreb_t 
       WHERE xrebld  = g_detail_d[l_ac].xrebld
         AND xreb001 = g_master.xreb001 
         AND xreb002 = g_master.xreb002
         AND xrebent = g_enterprise  #160905-00002#1

      #end add-point
      
      CALL aapp920_detail_show()      
 
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
   IF g_detail_d.getLength() > 0 THEN
      CALL g_detail_d.deleteElement(g_detail_d.getLength())
   END IF
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aapp920_sel
   
   LET l_ac = 1
   CALL aapp920_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   DISPLAY l_ac TO FORMONLY.h_index #150127-00007#1
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aapp920.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aapp920_fetch()
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
 
{<section id="aapp920.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aapp920_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aapp920.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aapp920_filter()
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
   
   CALL aapp920_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="aapp920.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aapp920_filter_parser(ps_field)
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
 
{<section id="aapp920.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aapp920_filter_show(ps_field,ps_object)
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
   LET ls_condition = aapp920_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aapp920.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION aapp920_process()
   DEFINE l_i         LIKE type_t.num5
   DEFINE l_wc        STRING
   DEFINE l_sql       STRING
   DEFINE l_cnt       LIKE type_t.num5
   DEFINE l_cnt2      LIKE type_t.num5    #150831 by 03538
   DEFINE l_flag      LIKE type_t.chr1    #條件範圍是否有資料
   
   LET g_success = 'Y'
   #取得有勾選的帳套條件
   FOR l_i = 1 TO g_detail_cnt
      IF g_detail_d[l_i].sel = 'N' THEN
         CONTINUE FOR
      ELSE
         IF cl_null(l_wc) THEN
            LET l_wc = g_detail_d[l_i].xrebld
         ELSE
            LET l_wc = l_wc,"','",g_detail_d[l_i].xrebld
         END IF
      END IF
   END FOR
   #未勾選任何一筆資料
   IF cl_null(l_wc) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axr-00159'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = "N"
      RETURN
   ELSE
      LET l_wc = "('",l_wc,"')"
   END IF
   
   #先檢查月結檔是否已有當月資料
   LET l_cnt = 0
   LET l_sql = " SELECT COUNT(*) FROM xreb_t ",
               "  WHERE xrebent = ",g_enterprise,
               "    AND xrebsite= '",g_master.xrebsite,"' ",
               "    AND xreb001 = ",g_master.xreb001,
               "    AND xreb002 = ",g_master.xreb002,
               "    AND xreb003 = 'AP' ",
               "    AND xrebld IN ",l_wc
   PREPARE aapp920_chk_p FROM l_sql
   EXECUTE aapp920_chk_p INTO l_cnt
   IF l_cnt > 0 THEN
#     #月結檔有資料，不允許重覆執行
#     IF NOT cl_ask_confirm("aap-00230") THEN
#        RETURN
#     ELSE
        #重覆執行時，要先啟動aapp960還原在執行
        IF NOT cl_ask_confirm("aap-00231") THEN
           LET g_success = "N"
           RETURN
        #150513 add ------
        ELSE
           #若月結已拋傳票則不能還原
           LET l_cnt2 = 0   #150831 by 03538 mod -->cnt2
           LET l_sql = " SELECT COUNT(*) FROM xreg_t ",
                       "  WHERE xregent = ",g_enterprise,
                       "    AND xregsite= '",g_master.xrebsite,"' ",
                       "    AND xreg001 = ",g_master.xreb001,
                       "    AND xreg002 = ",g_master.xreb002,
                       "    AND xreg003 = 'AP' ",
                       "    AND xreg005 IS NOT NULL",
                       "    AND xregld IN ",l_wc,
                       "    AND xregstus <> 'X'"
           PREPARE aapp920_chk_p2 FROM l_sql
           EXECUTE aapp920_chk_p2 INTO l_cnt2   #150831 by 03538 mod -->cnt2
           IF l_cnt2 > 0 THEN                   #150831 by 03538 mod -->cnt2
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'axr-00129'
              LET g_errparam.extend = ''
              LET g_errparam.popup = TRUE
              CALL cl_err()
              LET g_success = "N"
              RETURN
           END IF
        #150513 add end---
        END IF
#     END IF
   END IF

   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   
#   #先刪除舊資料
#   LET l_sql = " DELETE FROM xreb_t ",
#               "  WHERE xrebent = '",g_enterprise,"' ",
#               "    AND xrebsite= '",g_master.xrebsite,"' ",
#               "    AND xreb001 = '",g_master.xreb001,"' ",
#               "    AND xreb002 = '",g_master.xreb002,"' ",
#               "    AND xreb003 = 'AP' ", 
#               "    AND xrebld IN ",l_wc
#   PREPARE aapp920_xreb_del FROM l_sql
#   EXECUTE aapp920_xreb_del  
   #已存在資料,先呼叫還原作業刪除舊資料
   IF l_cnt > 0 THEN
      FOR l_i = 1 TO g_detail_cnt
         IF g_detail_d[l_i].sel = 'Y' THEN
            #02097--(S)
            CALL s_aap_evaluation_chk('2','AP',g_detail_d[l_i].xrebld,g_detail_d[l_i].glaacomp,g_master.xreb001,g_master.xreb002)    #albireo 161121 l_ac>l_i
                 RETURNING g_sub_success,g_errno
            IF NOT g_sub_success THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = g_errno
               LET g_errparam.extend = g_detail_d[l_i].xrebld   #albireo 161121 l_ac>l_i
               LET g_errparam.popup = FALSE
               CALL cl_err()        
               CALL cl_err_collect_show()    #150812-00010#3
               RETURN                        #150812-00010#3               
            ELSE
            #02097--(E)
               #開始update資訊
               CALL s_aapp960_upd(g_master.xrebsite,g_detail_d[l_i].xrebld,g_master.xreb001,g_master.xreb002) RETURNING g_sub_success
               IF g_sub_success THEN
                  #刪除月結資料
                  CALL s_aapp960_del(g_master.xrebsite,g_detail_d[l_i].xrebld,g_master.xreb001,g_master.xreb002) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_success = "N"
                  END IF
               ELSE
                  LET g_success = "N"
                  CONTINUE FOR
               END IF
            END IF         #02097 add
         END IF
      END FOR
   END IF


   #有勾選的帳套資料才寫入xreb
   FOR l_i = 1 TO g_detail_cnt
      IF g_detail_d[l_i].sel = 'N' THEN
         CONTINUE FOR
      ELSE
         CALL aapp920_ins_xreb(g_detail_d[l_i].xrebld,g_detail_d[l_i].glca002,g_detail_d[l_i].glca003)
      END IF
   END FOR

   IF g_flag = 'N' THEN    #條件範圍沒有資料
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00491'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = 'N'
   END IF
   
   CALL cl_err_collect_show()
   IF g_success = 'Y' THEN
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 寫入往來帳科目月結檔xreb_t
# Memo...........:
# Usage..........: CALL aapp920_ins_xreb(p_xrebld,p_glca002,p_glca003)
# Input parameter: p_xrebld      帳套條件
#                : p_glca002     重評價處理模式
#                : p_glca003     帳套對應重評價匯率類型
# Date & Author..: 14/09/10 By apo
# Modify.........:
################################################################################
PRIVATE FUNCTION aapp920_ins_xreb(p_xrebld,p_glca002,p_glca003)
DEFINE p_wc             STRING
DEFINE p_xrebld         LIKE xreb_t.xrebld
DEFINE p_glca002        LIKE glca_t.glca002
DEFINE p_glca003        LIKE glca_t.glca003
DEFINE l_glaa001        LIKE glaa_t.glaa001
DEFINE l_glaa003        LIKE glaa_t.glaa003
DEFINE l_glaa016        LIKE glaa_t.glaa016
#DEFINE l_glaa017        LIKE glaa_t.glaa017   #160802-00001#1 mark
DEFINE l_glaa020        LIKE glaa_t.glaa020    #160802-00001#1
DEFINE l_glaacomp       LIKE glaa_t.glaacomp   #151013-00019#8
DEFINE l_flag           LIKE type_t.chr1
DEFINE l_errno          LIKE type_t.chr100
DEFINE l_glav002        LIKE glav_t.glav002
DEFINE l_glav005        LIKE glav_t.glav005
DEFINE l_sdate_s        LIKE glav_t.glav004
DEFINE l_sdate_e        LIKE glav_t.glav004
DEFINE l_glav006        LIKE glav_t.glav006
DEFINE l_pdate_s        LIKE glav_t.glav004   #當期起始日
DEFINE l_pdate_e        LIKE glav_t.glav004   #當期截止日
DEFINE l_glav007        LIKE glav_t.glav007
DEFINE l_wdate_s        LIKE glav_t.glav004
DEFINE l_wdate_e        LIKE glav_t.glav004
DEFINE l_tmp            RECORD
          apccent    LIKE apcc_t.apccent,
          apcccomp   LIKE apcc_t.apcccomp,
          apcasite   LIKE apca_t.apcasite,
          apccld     LIKE apcc_t.apccld,
          apca001    LIKE apca_t.apca001,
          apccdocno  LIKE apcc_t.apccdocno,
          apccseq    LIKE apcc_t.apccseq,
          apcc001    LIKE apcc_t.apcc001,
          apcadocdt  LIKE apca_t.apcadocdt,
          apca004    LIKE apca_t.apca004,
          apca005    LIKE apca_t.apca005,
          apca006    LIKE apca_t.apca006,
          apca014    LIKE apca_t.apca014,
          apca015    LIKE apca_t.apca015,
          apca035    LIKE apca_t.apca035,
          apcacomp   LIKE apca_t.apcacomp,
          apca100    LIKE apca_t.apca100,
          apcb010    LIKE apcb_t.apcb010,
          apcb011    LIKE apcb_t.apcb011,
          apcb012    LIKE apcb_t.apcb012,
          apcb014    LIKE apcb_t.apcb014,
          apcb015    LIKE apcb_t.apcb015,
          apcb016    LIKE apcb_t.apcb016,
          apcb024    LIKE apcb_t.apcb024,
          apcb029    LIKE apcb_t.apcb029,
          apcborga   LIKE apcb_t.apcborga,
          apcb034    LIKE apcb_t.apcb034,
          apcb035    LIKE apcb_t.apcb035,
          apcb036    LIKE apcb_t.apcb036,
          apcb037    LIKE apcb_t.apcb037,
          apcb038    LIKE apcb_t.apcb038,
          apcb039    LIKE apcb_t.apcb039,
          apcb040    LIKE apcb_t.apcb040,
          apcb041    LIKE apcb_t.apcb041,
          apcb042    LIKE apcb_t.apcb042,
          apcb043    LIKE apcb_t.apcb043,
          apcb044    LIKE apcb_t.apcb044,
          apcb045    LIKE apcb_t.apcb045,
          apcb046    LIKE apcb_t.apcb046,
          apcb047    LIKE apcb_t.apcb047,
          apcc100    LIKE apcc_t.apcc100,
          apcc102    LIKE apcc_t.apcc102,
          apcc122    LIKE apcc_t.apcc122,
          apcc132    LIKE apcc_t.apcc132,
          apca057    LIKE apca_t.apca057    #albireo 151022 add
                        END RECORD
#DEFINE l_xreb           RECORD LIKE xreb_t.* #161104-00024#1 mark
#161104-00024#1-add(s)
DEFINE l_xreb           RECORD  #重評價月結檔
          xrebent    LIKE xreb_t.xrebent, #企業編號
          xrebcomp   LIKE xreb_t.xrebcomp, #法人
          xrebsite   LIKE xreb_t.xrebsite, #帳務中心
          xrebld     LIKE xreb_t.xrebld, #帳套
          xreb001    LIKE xreb_t.xreb001, #年度
          xreb002    LIKE xreb_t.xreb002, #期別
          xreb003    LIKE xreb_t.xreb003, #來源模組
          xreb004    LIKE xreb_t.xreb004, #帳款單性質
          xreb005    LIKE xreb_t.xreb005, #單據號碼
          xreb006    LIKE xreb_t.xreb006, #項次
          xreb007    LIKE xreb_t.xreb007, #分期帳款序
          xreb008    LIKE xreb_t.xreb008, #立帳日期
          xreb009    LIKE xreb_t.xreb009, #帳款對象
          xreb010    LIKE xreb_t.xreb010, #收款對象
          xreb011    LIKE xreb_t.xreb011, #部門
          xreb012    LIKE xreb_t.xreb012, #責任中心
          xreb013    LIKE xreb_t.xreb013, #區域
          xreb014    LIKE xreb_t.xreb014, #客群
          xreb015    LIKE xreb_t.xreb015, #產品類別
          xreb016    LIKE xreb_t.xreb016, #人員
          xreb017    LIKE xreb_t.xreb017, #專案編號
          xreb018    LIKE xreb_t.xreb018, #WBS編號
          xreb019    LIKE xreb_t.xreb019, #應收科目
          xreborga   LIKE xreb_t.xreborga, #來源組織
          xreb020    LIKE xreb_t.xreb020, #經營方式
          xreb021    LIKE xreb_t.xreb021, #通路
          xreb022    LIKE xreb_t.xreb022, #品牌
          xreb023    LIKE xreb_t.xreb023, #自由核算項一
          xreb024    LIKE xreb_t.xreb024, #自由核算項二
          xreb025    LIKE xreb_t.xreb025, #自由核算項三
          xreb026    LIKE xreb_t.xreb026, #自由核算項四
          xreb027    LIKE xreb_t.xreb027, #自由核算項五
          xreb028    LIKE xreb_t.xreb028, #自由核算項六
          xreb029    LIKE xreb_t.xreb029, #自由核算項七
          xreb030    LIKE xreb_t.xreb030, #自由核算項八
          xreb031    LIKE xreb_t.xreb031, #自由核算項九
          xreb032    LIKE xreb_t.xreb032, #自由核算項十
          xreb033    LIKE xreb_t.xreb033, #摘要
          xreb034    LIKE xreb_t.xreb034, #重評價會計科目
          xreb100    LIKE xreb_t.xreb100, #幣別
          xreb101    LIKE xreb_t.xreb101, #重評價匯率
          xreb102    LIKE xreb_t.xreb102, #上月重評匯率
          xreb103    LIKE xreb_t.xreb103, #本期原幣未沖金額
          xreb113    LIKE xreb_t.xreb113, #本期本幣未沖金額
          xreb114    LIKE xreb_t.xreb114, #本期重評價後本幣金額
          xreb115    LIKE xreb_t.xreb115, #本期匯差金額
          xreb116    LIKE xreb_t.xreb116, #本幣累計匯差
          xreb121    LIKE xreb_t.xreb121, #本位幣二重評價匯率
          xreb122    LIKE xreb_t.xreb122, #本位幣二上月重估匯率
          xreb123    LIKE xreb_t.xreb123, #本期本位幣二未沖金額
          xreb124    LIKE xreb_t.xreb124, #本期本位幣二重評價後金額
          xreb125    LIKE xreb_t.xreb125, #本期本位幣二匯差金額
          xreb126    LIKE xreb_t.xreb126, #本位幣二累計匯差
          xreb131    LIKE xreb_t.xreb131, #本位幣三重評價匯率
          xreb132    LIKE xreb_t.xreb132, #本位幣三上月重估匯率
          xreb133    LIKE xreb_t.xreb133, #本期本位幣三未沖金額
          xreb134    LIKE xreb_t.xreb134, #本期本位幣三重評價後金額
          xreb135    LIKE xreb_t.xreb135, #本期本位幣三匯差金額
          xreb136    LIKE xreb_t.xreb136, #本位幣三累計匯差
          xrebud001  LIKE xreb_t.xrebud001, #自定義欄位(文字)001
          xrebud002  LIKE xreb_t.xrebud002, #自定義欄位(文字)002
          xrebud003  LIKE xreb_t.xrebud003, #自定義欄位(文字)003
          xrebud004  LIKE xreb_t.xrebud004, #自定義欄位(文字)004
          xrebud005  LIKE xreb_t.xrebud005, #自定義欄位(文字)005
          xrebud006  LIKE xreb_t.xrebud006, #自定義欄位(文字)006
          xrebud007  LIKE xreb_t.xrebud007, #自定義欄位(文字)007
          xrebud008  LIKE xreb_t.xrebud008, #自定義欄位(文字)008
          xrebud009  LIKE xreb_t.xrebud009, #自定義欄位(文字)009
          xrebud010  LIKE xreb_t.xrebud010, #自定義欄位(文字)010
          xrebud011  LIKE xreb_t.xrebud011, #自定義欄位(數字)011
          xrebud012  LIKE xreb_t.xrebud012, #自定義欄位(數字)012
          xrebud013  LIKE xreb_t.xrebud013, #自定義欄位(數字)013
          xrebud014  LIKE xreb_t.xrebud014, #自定義欄位(數字)014
          xrebud015  LIKE xreb_t.xrebud015, #自定義欄位(數字)015
          xrebud016  LIKE xreb_t.xrebud016, #自定義欄位(數字)016
          xrebud017  LIKE xreb_t.xrebud017, #自定義欄位(數字)017
          xrebud018  LIKE xreb_t.xrebud018, #自定義欄位(數字)018
          xrebud019  LIKE xreb_t.xrebud019, #自定義欄位(數字)019
          xrebud020  LIKE xreb_t.xrebud020, #自定義欄位(數字)020
          xrebud021  LIKE xreb_t.xrebud021, #自定義欄位(日期時間)021
          xrebud022  LIKE xreb_t.xrebud022, #自定義欄位(日期時間)022
          xrebud023  LIKE xreb_t.xrebud023, #自定義欄位(日期時間)023
          xrebud024  LIKE xreb_t.xrebud024, #自定義欄位(日期時間)024
          xrebud025  LIKE xreb_t.xrebud025, #自定義欄位(日期時間)025
          xrebud026  LIKE xreb_t.xrebud026, #自定義欄位(日期時間)026
          xrebud027  LIKE xreb_t.xrebud027, #自定義欄位(日期時間)027
          xrebud028  LIKE xreb_t.xrebud028, #自定義欄位(日期時間)028
          xrebud029  LIKE xreb_t.xrebud029, #自定義欄位(日期時間)029
          xrebud030  LIKE xreb_t.xrebud030  #自定義欄位(日期時間)030
                        END RECORD
#161104-00024#1-add(e)
DEFINE l_sql            STRING
DEFINE l_glca004        LIKE glca_t.glca004
DEFINE l_glca005        LIKE glca_t.glca005
DEFINE l_last_y         LIKE type_t.num5
DEFINE l_last_m         LIKE type_t.num5
DEFINE l_xreb115_t      LIKE xreb_t.xreb115
DEFINE l_xreb125_t      LIKE xreb_t.xreb125
DEFINE l_xreb135_t      LIKE xreb_t.xreb135
DEFINE l_sfin2002       LIKE type_t.chr1
DEFINE l_exrate         LIKE xreb_t.xreb101
#160829-00004#1 add-(s)
DEFINE l_glaa015        LIKE glaa_t.glaa015
DEFINE l_glaa017        LIKE glaa_t.glaa017
DEFINE l_glaa019        LIKE glaa_t.glaa019
DEFINE l_glaa021        LIKE glaa_t.glaa021
#160829-00004#1 add-(e)
   
   LET g_flag = 'N'
   
   LET l_glaa003 = ''
   
   #取得會計週期參照表+本位幣二&三的幣別
   #151013-00019#8 add glaacomp
   #160802-00001#1 mark ------
   #CALL s_ld_sel_glaa(p_xrebld,'glaa001|glaa003|glaa016|glaa017|glaacomp')
   #     RETURNING g_sub_success,l_glaa001,l_glaa003,l_glaa016,l_glaa017,l_glaacomp
   #160802-00001#1 mark end---
   #160829-00004#1 mark-(s)
   ##160802-00001#1-s
   #CALL s_ld_sel_glaa(p_xrebld,'glaa001|glaa003|glaa016|glaa020|glaacomp')
   #     RETURNING g_sub_success,l_glaa001,l_glaa003,l_glaa016,l_glaa020,l_glaacomp
   ##160802-00001#1-e
   #160829-00004#1 mark-(e)
   #160829-00004#1
   CALL s_ld_sel_glaa(p_xrebld,'glaa001|glaa003|glaa016|glaa020|glaacomp|glaa015|glaa017|glaa019|glaa021')
        RETURNING g_sub_success,l_glaa001,l_glaa003,l_glaa016,l_glaa020,
                  l_glaacomp,l_glaa015,l_glaa017,l_glaa019,l_glaa021
   #160829-00004#1
   #依年度+期別取得會計週期起迄日
   CALL s_get_accdate(l_glaa003,'',g_master.xreb001,g_master.xreb002)
   RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
             l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
             
   SELECT glca004,glca005 INTO l_glca004,l_glca005
     FROM glca_t
    WHERE glcaent = g_enterprise
      AND glca001 = 'AP'
      AND glcald = p_xrebld
   
   #151013-00019#8 add ------
   #取得沖銷參數
   CALL cl_get_para(g_enterprise,l_glaacomp,'S-FIN-2002') RETURNING l_sfin2002
   
   #---範圍1:尚餘未沖金額者---#
   IF l_sfin2002 MATCHES '[12]' THEN
      LET l_sql = " SELECT apccent,apcccomp,apcasite,apccld,apca001, ",
                  "        apccdocno,apccseq,apcc001,apcadocdt,apca004, ",
                  "        apca005,apca006,apca014,apca015,apca035,apcacomp, ",
                  "        apca100,'','','','', ",
                  "        '','','','','', ",
                  "        '','','','','', ",
                  "        '','','','','', ",
                  "        '','','','',apcc100, ",
                  "        apcc102,apcc122,apcc132,",
                  "        apca057 ",
                  "   FROM apca_t",
                  "   LEFT JOIN apcc_t ON apcaent = apccent AND apcald = apccld AND apcadocno = apccdocno",
                  "  WHERE apcaent = ",g_enterprise,
                  "    AND apcadocdt <= ? ",
                  #"    AND apcasite = '",g_master.xrebsite,"' ",     #161104-00019#1 mark
                  "    AND apcald = ? ",
                  "    AND apcastus = 'Y' ",
                  "    AND apcc108 - apcc109 <> 0 ",
                  "    AND apcc100 <> '",l_glaa001,"'"  #如果交易幣別=帳套幣別，就不作重評價(此暫不考慮本位幣二&三)
   ELSE
   #151013-00019#8 add end---
      LET l_sql = " SELECT apccent,apcccomp,apcasite,apccld,apca001, ",
                  "        apccdocno,apccseq,apcc001,apcadocdt,apca004, ",
                  "        apca005,apca006,apca014,apca015,apca035,apcacomp, ",
                  "        apca100,apcb010,apcb011,apcb012,apcb014, ",
                  "        apcb015,apcb016,apcb024,apcb029,apcborga, ",
                  "        apcb034,apcb035,apcb036,apcb037,apcb038, ",
                  "        apcb039,apcb040,apcb041,apcb042,apcb043, ",
                  "        apcb044,apcb045,apcb046,apcb047,apcc100, ",
                  "        apcc102,apcc122,apcc132,",
                  "        apca057 ",  #albireo 151022 add
                  "   FROM apca_t,apcb_t,apcc_t ",
                  "  WHERE apcaent = ",g_enterprise,
                  "    AND apcadocdt <= ? ",
                  #"    AND apcasite = '",g_master.xrebsite,"' ",     #161104-00019#1 mark
                  "    AND apcald = ? ",
                  "    AND apcastus = 'Y' ",
                  "    AND apcc108 - apcc109 <> 0 ",
                  "    AND apcc100 <> '",l_glaa001,"'", #如果交易幣別=帳套幣別，就不作重評價(此暫不考慮本位幣二&三)
                  "    AND apcaent = apccent ",
                  "    AND apcald = apccld ",
                  "    AND apcadocno = apccdocno ",
                  "    AND apcbent = apccent ",
                  "    AND apcbld = apccld ",
                  "    AND apcbdocno = apccdocno ",
                  "    AND apcbseq = apccseq "
   END IF #151013-00019#8 add
   
   #暫估款納入評價否
   IF l_glca005 <> 'Y' THEN 
      LET l_sql = l_sql," AND SUBSTR(apca001,1,1) <> '0' "
   END IF
   #扣抵項目減除否
   IF l_glca004 <> 'Y' THEN 
      LET l_sql = l_sql," AND SUBSTR(apca001,1,1) <> '2' "
   END IF
   
   #---範圍2:雖目前未沖金額為0,但在結算日之後仍有沖銷紀錄者,代表是結算日後才沖完的,也應納入計算---#
   #151013-00019#8 add ------
   IF l_sfin2002 MATCHES '[12]' THEN
      LET l_sql = l_sql,
                  "  UNION ",
                  " SELECT apccent,apcccomp,apcasite,apccld,apca001, ",
                  "        apccdocno,apccseq,apcc001,apcadocdt,apca004, ",
                  "        apca005,apca006,apca014,apca015,apca035,apcacomp, ",
                  "        apca100,'','','','', ",
                  "        '','','','','', ",
                  "        '','','','','', ",
                  "        '','','','','', ",
                  "        '','','','',apcc100, ",
                  "        apcc102,apcc122,apcc132,",
                  "        apca057 ",
                  "   FROM apca_t",
                  "   LEFT JOIN apcc_t ON apcaent = apccent AND apcald = apccld AND apcadocno = apccdocno",
                  "  WHERE apcaent = ",g_enterprise,
                  "    AND apcadocdt <= ? ",
                  #"    AND apcasite = '",g_master.xrebsite,"' ",      #161104-00019#1 mark
                  "    AND apcald = ? ",
                  "    AND apcastus = 'Y' ",
                  "    AND apcc108 - apcc109 = 0 ",
                  "    AND apcc100 <> '",l_glaa001,"'"  #如果交易幣別=帳套幣別，就不作重評價(此暫不考慮本位幣二&三)
   ELSE
   #151013-00019#8 add end---
      LET l_sql = l_sql,
                  "  UNION ",
                  " SELECT apccent,apcccomp,apcasite,apccld,apca001, ",
                  "        apccdocno,apccseq,apcc001,apcadocdt,apca004, ",
                  "        apca005,apca006,apca014,apca015,apca035,apcacomp, ",
                  "        apca100,apcb010,apcb011,apcb012,apcb014, ",
                  "        apcb015,apcb016,apcb024,apcb029,apcborga, ",
                  "        apcb034,apcb035,apcb036,apcb037,apcb038, ",
                  "        apcb039,apcb040,apcb041,apcb042,apcb043, ",
                  "        apcb044,apcb045,apcb046,apcb047,apcc100, ",
                  "        apcc102,apcc122,apcc132,",
                  "        apca057 ",  #albireo 151022 add
                  "   FROM apca_t,apcb_t,apcc_t ",
                  "  WHERE apcaent = ",g_enterprise,
                  "    AND apcadocdt <= ? ",
                  #"    AND apcasite = '",g_master.xrebsite,"' ",      #161104-00019#1 mark
                  "    AND apcald = ? ",
                  "    AND apcastus = 'Y' ",
                  "    AND apcc108 - apcc109 = 0 ",
                  "    AND apcc100 <> '",l_glaa001,"'", #如果交易幣別=帳套幣別，就不作重評價(此暫不考慮本位幣二&三)
                  "    AND apcaent = apccent ",
                  "    AND apcald = apccld ",
                  "    AND apcadocno = apccdocno ",
                  "    AND apcbent = apccent ",
                  "    AND apcbld = apccld ",
                  "    AND apcbdocno = apccdocno ",
                  "    AND apcbseq = apccseq "
   #151013-00019#8  add ------
   END IF
   LET l_sql = l_sql,
   #151013-00019#8  add end---
                  "    AND ( ",
                  "         EXISTS ( SELECT 1 FROM apda_t,apce_t WHERE apce003 = apccdocno ",
                  "                                                AND apce004 = apccseq ",
                  "                                                AND apce005 = apcc001 ", 
                  "                                                AND apdald  = apceld ",
                  "                                                AND apdaent =apceent ",
                  "                                                AND apdadocno =apcedocno ",
                  "                                                AND apdadocdt > '",l_pdate_e,"' ",  #150128-00003#1
                  "                                                AND apdastus= 'Y') ",     #AP沖銷
                  "     OR  EXISTS ( SELECT 1 FROM apca_t,apce_t WHERE apce003 = apccdocno ",
                  "                                                AND apce004 = apccseq ",
                  "                                                AND apce005 = apcc001 ", 
                  "                                                AND apcald  = apceld ",
                  "                                                AND apcaent =apceent ",
                  "                                                AND apcadocno =apcedocno ",
                  "                                                AND apcadocdt > '",l_pdate_e,"' ",  #150128-00003#1
                  "                                                AND apcastus= 'Y') ",    #AP直接沖帳      
                  "     OR  EXISTS ( SELECT 1 FROM apca_t,apcf_t WHERE apcf008 = apccdocno ",
                  #"                                                AND apcf009 = apccseq ", #150504 Reanna mark
                  "                                                AND apcf010 = apcc001 ", 
                  "                                                AND apcald  = apcfld ",
                  "                                                AND apcaent =apcfent ",
                  "                                                AND apcadocno =apcfdocno ",
                  "                                                AND apcadocdt > '",l_pdate_e,"' ",  #150128-00003#1
                  "                                                AND apcastus= 'Y') ",    #AP沖暫估                  
                  "     OR  EXISTS ( SELECT 1 FROM xrda_t,xrce_t WHERE xrce003 = apccdocno ",
                  "                                                AND xrce004 = apccseq ",
                  "                                                AND xrce005 = apcc001 ", 
                  "                                                AND xrdald  = xrceld ",
                  "                                                AND xrdaent =xrceent ",
                  "                                                AND xrdadocno =xrcedocno ",
                  "                                                AND xrdadocdt > '",l_pdate_e,"' ",  #150128-00003#1
                  "                                                AND xrdastus= 'Y') ",    #AR沖銷
                  "        ) "
   #暫估款納入評價否
   IF l_glca005 <> 'Y' THEN 
      LET l_sql = l_sql," AND SUBSTR(apca001,1,1) <> '0' "
   END IF
   #扣抵項目減除否
   IF l_glca004 <> 'Y' THEN 
      LET l_sql = l_sql," AND SUBSTR(apca001,1,1) <> '2' "
   END IF               
   LET l_sql = l_sql,"  ORDER BY apccdocno,apccseq,apcc001 "
 
   PREPARE aapp920_sel_apca_p FROM l_sql
   DECLARE aaapp920_sel_apca_c CURSOR FOR aapp920_sel_apca_p
   FOREACH aaapp920_sel_apca_c USING l_pdate_e,p_xrebld,l_pdate_e,p_xrebld INTO l_tmp.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF

      INITIALIZE l_xreb.* TO NULL

      #取得沖銷參數
      CALL cl_get_para(l_tmp.apccent,l_tmp.apcccomp,'S-FIN-2002') RETURNING l_sfin2002

      LET l_xreb.xrebent = l_tmp.apccent
      LET l_xreb.xrebcomp = l_tmp.apcccomp
      LET l_xreb.xrebsite = l_tmp.apcasite
      LET l_xreb.xrebld = l_tmp.apccld
      
      LET l_xreb.xreb001 = g_master.xreb001 #條件年度
      LET l_xreb.xreb002 = g_master.xreb002 #條件期別
      LET l_xreb.xreb003 = 'AP'
      LET l_xreb.xreb004 = l_tmp.apca001
      LET l_xreb.xreb005 = l_tmp.apccdocno
      
      LET l_xreb.xreb006 = l_tmp.apccseq
      LET l_xreb.xreb007 = l_tmp.apcc001
      LET l_xreb.xreb008 = l_tmp.apcadocdt
      LET l_xreb.xreb009 = l_tmp.apca004
      
      IF l_sfin2002 MATCHES '[12]' THEN
         LET l_xreb.xreb010 = l_tmp.apca005
         
         LET l_xreb.xreb011 = l_tmp.apca015
         LET l_xreb.xreb012 = ''
         LET l_xreb.xreb013 = ''
         LET l_xreb.xreb014 = ''
         LET l_xreb.xreb015 = ''
         
         #LET l_xreb.xreb016 = l_tmp.apca014   #albireo 151022 mark
         LET l_xreb.xreb017 = ''
         LET l_xreb.xreb018 = ''
         LET l_xreb.xreb019 = l_tmp.apca035
         LET l_xreb.xreborga= l_tmp.apcacomp
         LET l_xreb.xreb020 = ''
         
         LET l_xreb.xreb021 = ''
         LET l_xreb.xreb022 = ''
         LET l_xreb.xreb023 = ''
         LET l_xreb.xreb024 = ''
         LET l_xreb.xreb025 = ''
         
         LET l_xreb.xreb026 = ''
         LET l_xreb.xreb027 = ''
         LET l_xreb.xreb028 = ''
         LET l_xreb.xreb029 = ''
         LET l_xreb.xreb030 = ''
         
         LET l_xreb.xreb031 = ''
         LET l_xreb.xreb032 = ''
         LET l_xreb.xreb033 = ''
         
         LET l_xreb.xreb100 = l_tmp.apca100

      ELSE
         LET l_xreb.xreb010 = l_tmp.apca006
         LET l_xreb.xreb011 = l_tmp.apcb010
         LET l_xreb.xreb012 = l_tmp.apcb011
         LET l_xreb.xreb013 = l_tmp.apcb024
         LET l_xreb.xreb014 = l_tmp.apcb014
         LET l_xreb.xreb015 = l_tmp.apcb012
         
         #LET l_xreb.xreb016 = l_tmp.apca014   #albireo 151022 mark
         LET l_xreb.xreb017 = l_tmp.apcb015
         LET l_xreb.xreb018 = l_tmp.apcb016
         LET l_xreb.xreb019 = l_tmp.apcb029
         LET l_xreb.xreborga= l_tmp.apcborga
         LET l_xreb.xreb020 = l_tmp.apcb034
         
         LET l_xreb.xreb021 = l_tmp.apcb035
         LET l_xreb.xreb022 = l_tmp.apcb036
         LET l_xreb.xreb023 = l_tmp.apcb037
         LET l_xreb.xreb024 = l_tmp.apcb038
         LET l_xreb.xreb025 = l_tmp.apcb039
         
         LET l_xreb.xreb026 = l_tmp.apcb040
         LET l_xreb.xreb027 = l_tmp.apcb041
         LET l_xreb.xreb028 = l_tmp.apcb042
         LET l_xreb.xreb029 = l_tmp.apcb043
         LET l_xreb.xreb030 = l_tmp.apcb044
         
         LET l_xreb.xreb031 = l_tmp.apcb045
         LET l_xreb.xreb032 = l_tmp.apcb046
         #LET l_xreb.xreb033 = l_tmp.apcb047  #170116-00037#1 mark
         LET l_xreb.xreb033 = ''              #170116-00037#1 add          
         LET l_xreb.xreb100 = l_tmp.apcc100
      END IF
      #albireo 151022-----s
     #IF l_tmp.apca001 = '12' OR l_tmp.apca001 = '15' THEN  #151013-00019#8 mark
      #aapt330(15)/aapt331(12)/aapt331產生的待抵單(26)都要改抓受款對象
      IF l_tmp.apca001 = '12' OR l_tmp.apca001 = '15' OR l_tmp.apca001 = '26' THEN #151013-00019#8
         LET l_xreb.xreb016 = l_tmp.apca057
      ELSE
         LET l_xreb.xreb016 = l_tmp.apca014
      END IF
      #albireo 151022-----e

      #重評價匯率/本位幣二重評價匯率/本位幣三重評價匯率
      CALL s_fin_get_exchange_rate(p_xrebld,l_xreb.xreb001,l_xreb.xreb002,l_xreb.xreb100,p_glca003)
      RETURNING l_xreb.xreb101,l_xreb.xreb121,l_xreb.xreb131
      IF cl_null(l_xreb.xreb101) THEN LET l_xreb.xreb101 = 0 END IF
      IF cl_null(l_xreb.xreb121) THEN LET l_xreb.xreb121 = 0 END IF
      IF cl_null(l_xreb.xreb131) THEN LET l_xreb.xreb131 = 0 END IF
      #160829-00004#1 mark(s)
      ##160802-00001#1-s
      #CALL s_curr_round_ld('1',p_xrebld,l_glaa001,l_xreb.xreb101,3) RETURNING g_sub_success,g_errno,l_xreb.xreb101
      #CALL s_curr_round_ld('1',p_xrebld,l_glaa016,l_xreb.xreb121,3) RETURNING g_sub_success,g_errno,l_xreb.xreb121
      #CALL s_curr_round_ld('1',p_xrebld,l_glaa020,l_xreb.xreb131,3) RETURNING g_sub_success,g_errno,l_xreb.xreb131
      ##160802-00001#1-e
      #160829-00004#1 mark(e)
      
      #160829-00004#1-s
      CALL s_curr_round_ld('1',p_xrebld,l_xreb.xreb100,l_xreb.xreb101,3) RETURNING g_sub_success,g_errno,l_xreb.xreb101
      IF l_glaa015 = 'Y' THEN          
         #來源幣別
         IF l_glaa017 = '1' THEN
            CALL s_curr_round_ld('1',p_xrebld,l_xreb.xreb100,l_xreb.xreb121,3) RETURNING g_sub_success,g_errno,l_xreb.xreb121  
         ELSE   #表示帳簿幣別 
            CALL s_curr_round_ld('1',p_xrebld,l_glaa001,l_xreb.xreb121,3) RETURNING g_sub_success,g_errno,l_xreb.xreb121   #帳套使用幣別
         END IF
      END IF
      IF l_glaa019 = 'Y' THEN 
         #來源幣別
         IF l_glaa021 = '1' THEN 
            CALL s_curr_round_ld('1',p_xrebld,l_xreb.xreb100,l_xreb.xreb131,3) RETURNING g_sub_success,g_errno,l_xreb.xreb131              
         ELSE   #表示帳簿幣別 
            CALL s_curr_round_ld('1',p_xrebld,l_glaa001,l_xreb.xreb131,3) RETURNING g_sub_success,g_errno,l_xreb.xreb131   #帳套使用幣別
         END IF
      END IF
      #160829-00004#1-e
      
      #計算本期未沖金額(原幣/本幣/本幣二/本幣三)
      CALL aapp920_get_balance(p_xrebld,l_xreb.xreb005,l_xreb.xreb006,l_xreb.xreb007,l_pdate_e,l_xreb.xreb004) #20141223 add xreb004
      RETURNING l_xreb.xreb103,l_xreb.xreb113,l_xreb.xreb123,l_xreb.xreb133
      IF cl_null(l_xreb.xreb103) THEN LET l_xreb.xreb103 = 0 END IF
      IF cl_null(l_xreb.xreb113) THEN LET l_xreb.xreb113 = 0 END IF
      IF cl_null(l_xreb.xreb123) THEN LET l_xreb.xreb123 = 0 END IF
      IF cl_null(l_xreb.xreb133) THEN LET l_xreb.xreb133 = 0 END IF
      #如果是待抵項目，未沖金額要先作負數處理 #150318
      IF l_xreb.xreb004[1,1]='2' OR l_xreb.xreb004 MATCHES '0[24]' THEN
         LET l_xreb.xreb103 = l_xreb.xreb103 * -1
         LET l_xreb.xreb113 = l_xreb.xreb113 * -1
         LET l_xreb.xreb123 = l_xreb.xreb123 * -1
         LET l_xreb.xreb133 = l_xreb.xreb133 * -1
      END IF
      #160802-00001#1-s
      CALL s_curr_round_ld('1',p_xrebld,l_xreb.xreb100,l_xreb.xreb103,2) RETURNING g_sub_success,g_errno,l_xreb.xreb103
      CALL s_curr_round_ld('1',p_xrebld,l_glaa001,l_xreb.xreb113,2) RETURNING g_sub_success,g_errno,l_xreb.xreb113
      CALL s_curr_round_ld('1',p_xrebld,l_glaa016,l_xreb.xreb123,2) RETURNING g_sub_success,g_errno,l_xreb.xreb123
      CALL s_curr_round_ld('1',p_xrebld,l_glaa020,l_xreb.xreb133,2) RETURNING g_sub_success,g_errno,l_xreb.xreb133
      #160802-00001#1-e
      
      #上月重評匯率(本幣)
      LET l_xreb.xreb102 = l_tmp.apcc102
      IF cl_null(l_xreb.xreb102) THEN LET l_xreb.xreb102 = 0 END IF
      CALL s_curr_round_ld('1',p_xrebld,l_xreb.xreb100,l_xreb.xreb102,3) RETURNING g_sub_success,g_errno,l_xreb.xreb102 #160802-00001#1
      #重評價後金額(本幣)
      LET l_xreb.xreb114 = l_xreb.xreb103 * l_xreb.xreb101
      IF cl_null(l_xreb.xreb114) THEN LET l_xreb.xreb114 = 0 END IF
      CALL s_curr_round_ld('1',p_xrebld,l_glaa001,l_xreb.xreb114,2) RETURNING g_sub_success,g_errno,l_xreb.xreb114 #150226
      #匯差金額(本幣)=重評後金額-重評前金額
      LET l_xreb.xreb115 = l_xreb.xreb114 - l_xreb.xreb113
      IF cl_null(l_xreb.xreb115) THEN 
         LET l_xreb.xreb115 = 0
      END IF

      #取上期的年度期別
      CALL s_fin_date_get_last_period(l_glaa003,l_xreb.xrebld,l_xreb.xreb001,l_xreb.xreb002)
      RETURNING g_sub_success,l_last_y,l_last_m
      #取上期匯差
      LET l_xreb115_t = 0  #150313
      LET l_xreb125_t = 0  #150313
      LET l_xreb135_t = 0  #150313
      #SELECT xreb115,xreb125,xreb135 #150413 mark
      #150413 add 因為是要取累計匯差匯差不是上一期匯差，故改取xreb116
      SELECT xreb116,xreb126,xreb136
        INTO l_xreb115_t,l_xreb125_t,l_xreb135_t
        FROM xreb_t
       WHERE xrebent = g_enterprise
         AND xrebld = l_xreb.xrebld
         AND xreb001 = l_last_y   #上期年度
         AND xreb002 = l_last_m   #上期月份
         AND xreb003 = 'AP'       #150313
         AND xreb005 = l_xreb.xreb005
         AND xreb006 = l_xreb.xreb006
         AND xreb007 = l_xreb.xreb007
      IF cl_null(l_xreb115_t) THEN LET l_xreb115_t = 0 END IF
      IF cl_null(l_xreb125_t) THEN LET l_xreb125_t = 0 END IF
      IF cl_null(l_xreb135_t) THEN LET l_xreb135_t = 0 END IF
      LET l_xreb.xreb116 = l_xreb.xreb115 + l_xreb115_t  #本幣累計匯差

      
      #本位幣二
      IF NOT cl_null(l_glaa016) THEN
         #上月重估匯率
         LET l_xreb.xreb122 = l_tmp.apcc122
         IF cl_null(l_xreb.xreb122) THEN LET l_xreb.xreb122 = 0 END IF
         #CALL s_curr_round_ld('1',p_xrebld,l_glaa016,l_xreb.xreb122,3) RETURNING g_sub_success,g_errno,l_xreb.xreb122 #160802-00001#1 #160829-00004#1 mark
         #160829-00004#1-(s)
         IF l_glaa017 = '1' THEN
            CALL s_curr_round_ld('1',p_xrebld,l_xreb.xreb100,l_xreb.xreb122,3) RETURNING g_sub_success,g_errno,l_xreb.xreb122  
         ELSE
            CALL s_curr_round_ld('1',p_xrebld,l_glaa001,l_xreb.xreb122,3) RETURNING g_sub_success,g_errno,l_xreb.xreb122
         END IF
         #160829-00004#1-(e)
         #重評價後金額
         LET l_xreb.xreb124 = l_xreb.xreb123 * l_xreb.xreb121
         IF cl_null(l_xreb.xreb124) THEN LET l_xreb.xreb124 = 0 END IF
        #CALL s_curr_round_ld('1',p_xrebld,l_glaa001,l_xreb.xreb124,2) RETURNING g_sub_success,g_errno,l_xreb.xreb124 #150226 #160802-00001#1 mark
         CALL s_curr_round_ld('1',p_xrebld,l_glaa016,l_xreb.xreb124,2) RETURNING g_sub_success,g_errno,l_xreb.xreb124 #160802-00001#1
         #匯差金額
         IF l_xreb.xreb115 = 0 THEN
            LET l_xreb.xreb125 = 0
         ELSE
            #取月平均汇率
            CALL s_aooi160_get_exrate_avg('',p_xrebld,l_pdate_s,l_xreb.xreb100,l_glaa016,'',p_glca003) RETURNING g_sub_success,g_errno,l_exrate
            #本期匯差xreb115 *本位幣二對應本幣匯率
            LET l_xreb.xreb125 = l_xreb.xreb115 * l_exrate
           #CALL s_curr_round_ld('1',p_xrebld,l_glaa001,l_xreb.xreb125,2) RETURNING g_sub_success,g_errno,l_xreb.xreb125 #150226 #160802-00001#1 mark
            CALL s_curr_round_ld('1',p_xrebld,l_glaa016,l_xreb.xreb125,2) RETURNING g_sub_success,g_errno,l_xreb.xreb125 #160802-00001#1
         END IF
         IF cl_null(l_xreb.xreb125) THEN LET l_xreb.xreb125 = 0 END IF
         LET l_xreb.xreb126 = l_xreb.xreb125 + l_xreb125_t  #本位幣二累計匯差
         IF cl_null(l_xreb.xreb126) THEN LET l_xreb.xreb126 = 0 END IF
      END IF   
      
      #本位幣三
     #IF NOT cl_null(l_glaa017) THEN #160802-00001#1 mark
      IF NOT cl_null(l_glaa020) THEN #160802-00001#1
         #上月重估匯率
         LET l_xreb.xreb132 = l_tmp.apcc132
         IF cl_null(l_xreb.xreb132) THEN LET l_xreb.xreb132 = 0 END IF
         #CALL s_curr_round_ld('1',p_xrebld,l_glaa020,l_xreb.xreb122,3) RETURNING g_sub_success,g_errno,l_xreb.xreb122 #160802-00001#1  #160829-00004#1 mark
         #160829-00004#1-(s)
         IF l_glaa021 = '1' THEN
            CALL s_curr_round_ld('1',p_xrebld,l_xreb.xreb100,l_xreb.xreb132,3) RETURNING g_sub_success,g_errno,l_xreb.xreb132  
         ELSE
            CALL s_curr_round_ld('1',p_xrebld,l_glaa001,l_xreb.xreb132,3) RETURNING g_sub_success,g_errno,l_xreb.xreb132
         END IF
         #160829-00004#1-(e)
         #重評價後金額
         LET l_xreb.xreb134 = l_xreb.xreb133 * l_xreb.xreb131
         IF cl_null(l_xreb.xreb134) THEN LET l_xreb.xreb134 = 0 END IF
        #CALL s_curr_round_ld('1',p_xrebld,l_glaa001,l_xreb.xreb134,2) RETURNING g_sub_success,g_errno,l_xreb.xreb134 #150226 #160802-00001#1 mark
         CALL s_curr_round_ld('1',p_xrebld,l_glaa020,l_xreb.xreb134,2) RETURNING g_sub_success,g_errno,l_xreb.xreb134 #160802-00001#1
         #匯差金額
         IF l_xreb.xreb115 = 0 THEN
            LET l_xreb.xreb135 = 0
         ELSE
            #取月平均汇率
           #CALL s_aooi160_get_exrate_avg('',p_xrebld,l_pdate_s,l_xreb.xreb100,l_glaa017,'',p_glca003) RETURNING g_sub_success,g_errno,l_exrate #160802-00001#1 mark
            CALL s_aooi160_get_exrate_avg('',p_xrebld,l_pdate_s,l_xreb.xreb100,l_glaa020,'',p_glca003) RETURNING g_sub_success,g_errno,l_exrate #160802-00001#1
            #本期匯差xreb115 *本位幣二對應本幣匯率
            LET l_xreb.xreb135 = l_xreb.xreb115 * l_exrate
           #CALL s_curr_round_ld('1',p_xrebld,l_glaa001,l_xreb.xreb135,2) RETURNING g_sub_success,g_errno,l_xreb.xreb135 #150226 #160802-00001#1 mark
            CALL s_curr_round_ld('1',p_xrebld,l_glaa020,l_xreb.xreb135,2) RETURNING g_sub_success,g_errno,l_xreb.xreb135 #160802-00001#1
         END IF
         IF cl_null(l_xreb.xreb135) THEN LET l_xreb.xreb135 = 0 END IF
         LET l_xreb.xreb136 = l_xreb.xreb135 + l_xreb135_t  #本位幣三累計匯差
         IF cl_null(l_xreb.xreb136) THEN LET l_xreb.xreb136 = 0 END IF
      END IF
      
      #重評價會科
      CASE
         WHEN 0 <= l_xreb.xreb115 #若匯差金額=0則歸屬在借方 #150320
            #重評價匯兌損失
            CALL s_fin_get_account(l_xreb.xrebld,'25','8318','8318_12') RETURNING g_sub_success,l_xreb.xreb034,g_errno
         WHEN l_xreb.xreb115 < 0
            #重評價匯兌收益
            CALL s_fin_get_account(l_xreb.xrebld,'25','8318','8318_11') RETURNING g_sub_success,l_xreb.xreb034,g_errno
      END CASE
      
      INSERT INTO xreb_t
                 (xrebent,xrebcomp,xrebsite,xrebld
                 ,xreb001,xreb002,xreb003,xreb004,xreb005
                 ,xreb006,xreb007,xreb008,xreb009,xreb010
                 ,xreb011,xreb012,xreb013,xreb014,xreb015
                 ,xreb016,xreb017,xreb018,xreb019,xreborga
                 ,xreb020,xreb021,xreb022,xreb023,xreb024
                 ,xreb025,xreb026,xreb027,xreb028,xreb029
                 ,xreb030,xreb031,xreb032,xreb033,xreb034
                 ,xreb100,xreb101,xreb102,xreb103
                 ,xreb113,xreb114,xreb115,xreb116
                 ,xreb121,xreb122,xreb123,xreb124,xreb125
                 ,xreb126,xreb131,xreb132,xreb133,xreb134
                 ,xreb135,xreb136)
           VALUES(l_xreb.xrebent,l_xreb.xrebcomp,l_xreb.xrebsite,l_xreb.xrebld
                 ,l_xreb.xreb001,l_xreb.xreb002,l_xreb.xreb003,l_xreb.xreb004,l_xreb.xreb005
                 ,l_xreb.xreb006,l_xreb.xreb007,l_xreb.xreb008,l_xreb.xreb009,l_xreb.xreb010
                 ,l_xreb.xreb011,l_xreb.xreb012,l_xreb.xreb013,l_xreb.xreb014,l_xreb.xreb015
                 ,l_xreb.xreb016,l_xreb.xreb017,l_xreb.xreb018,l_xreb.xreb019,l_xreb.xreborga
                 ,l_xreb.xreb020,l_xreb.xreb021,l_xreb.xreb022,l_xreb.xreb023,l_xreb.xreb024
                 ,l_xreb.xreb025,l_xreb.xreb026,l_xreb.xreb027,l_xreb.xreb028,l_xreb.xreb029
                 ,l_xreb.xreb030,l_xreb.xreb031,l_xreb.xreb032,l_xreb.xreb033,l_xreb.xreb034
                 ,l_xreb.xreb100,l_xreb.xreb101,l_xreb.xreb102,l_xreb.xreb103
                 ,l_xreb.xreb113,l_xreb.xreb114,l_xreb.xreb115,l_xreb.xreb116
                 ,l_xreb.xreb121,l_xreb.xreb122,l_xreb.xreb123,l_xreb.xreb124,l_xreb.xreb125
                 ,l_xreb.xreb126,l_xreb.xreb131,l_xreb.xreb132,l_xreb.xreb133,l_xreb.xreb134
                 ,l_xreb.xreb135,l_xreb.xreb136)
      IF SQLCA.SQLcode OR SQLCA.SQLERRD[3]=0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins xreb_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N'
      END IF
      
      #重評價傳票，次月不迴轉才update
      IF p_glca002 = '3' AND l_xreb.xreb115 <> 0 THEN
         #如果是待抵項目，這裡要在正負反轉回來，T3*單據才會正確 #150318
         IF l_xreb.xreb004[1,1]='2' OR l_xreb.xreb004 MATCHES '0[24]' THEN
            LET l_xreb.xreb116 = l_xreb.xreb116 * -1
            LET l_xreb.xreb126 = l_xreb.xreb126 * -1
            LET l_xreb.xreb136 = l_xreb.xreb136 * -1
         END IF
         #回寫重評價調整數
         UPDATE apcc_t SET
                apcc102 = l_xreb.xreb101,
                apcc122 = l_xreb.xreb121,
                apcc132 = l_xreb.xreb131,
                apcc113 = l_xreb.xreb116,
                apcc123 = l_xreb.xreb126,
                apcc133 = l_xreb.xreb136
          WHERE apccent = g_enterprise
            AND apccld = l_xreb.xrebld
            AND apccdocno = l_xreb.xreb005
            AND apccseq = l_xreb.xreb006
            AND apcc001 = l_xreb.xreb007
         IF SQLCA.SQLcode OR SQLCA.SQLERRD[3]=0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "upd apcc_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N'
         END IF
   
         ##重計本幣應付金額
         #UPDATE apcc_t SET apcc118 = apcc115 - apcc116 - apcc117 + apcc114 + apcc113,
         #                  apcc128 = apcc125 - apcc126 - apcc127 + apcc124 + apcc123,
         #                  apcc138 = apcc135 - apcc136 - apcc137 + apcc134 + apcc133
         # WHERE apccent = g_enterprise
         #   AND apccld = l_xreb.xrebld
         #   AND apccdocno = l_xreb.xreb005
         #   AND apccseq = l_xreb.xreb006
         #   AND apcc001 = l_xreb.xreb007
         #IF SQLCA.SQLcode OR SQLCA.SQLERRD[3]=0 THEN
         #   INITIALIZE g_errparam TO NULL
         #   LET g_errparam.code = SQLCA.sqlcode
         #   LET g_errparam.extend = "upd apcc_t"
         #   LET g_errparam.popup = TRUE
         #   CALL cl_err()
         #   LET g_success = 'N'
         #END IF
      END IF
      LET g_flag = 'Y'
   END FOREACH
   IF g_flag = 'Y' THEN
      #回寫帳套重評價年月
      UPDATE glca_t SET glca006 = l_xreb.xreb001,
                        glca007 = l_xreb.xreb002
       WHERE glcaent = g_enterprise
         AND glcald = l_xreb.xrebld
         AND glca001 = 'AP'
      IF SQLCA.SQLcode OR SQLCA.SQLERRD[3]=0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd glca_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N'
      END IF   
   END IF

END FUNCTION

################################################################################
# Descriptions...: 計算本期未沖金額(原幣/本幣/本幣二/本幣三)
# Memo...........:
# Usage..........: CALL aapp920_get_balance(p_apccld,p_apccdocno,p_apccseq,p_apcc001,p_edate,p_xreb004)
#                  RETURNING 回传参数
# Input parameter: p_apccdocno    應付帳款單號碼
#                : p_apccseq      項次
#                : p_apcc001      分期帳款序
#                : p_xreb004      帳款單性質
# Return code....: r_xreb103      本期原幣未沖金額
#                : r_xreb113      本期本幣未沖金額
#                : r_xreb123      本期本位幣二未沖金額
#                : r_xreb133      本期本位幣三未沖金額
# Date & Author..: 14/09/15 By apo
# Modify.........:
################################################################################
PRIVATE FUNCTION aapp920_get_balance(p_apccld,p_apccdocno,p_apccseq,p_apcc001,p_edate,p_xreb004)
   #傳入值
   DEFINE p_apccld            LIKE apcc_t.apccld
   DEFINE p_apccdocno         LIKE apcc_t.apccdocno
   DEFINE p_apccseq           LIKE apcc_t.apccseq
   DEFINE p_apcc001           LIKE apcc_t.apcc001
   DEFINE p_edate             LIKE glav_t.glav004    #截止日
   DEFINE p_xreb004           LIKE xreb_t.xreb004    #帳款單性質
   #回傳值
   DEFINE r_xreb103           LIKE xreb_t.xreb103
   DEFINE r_xreb113           LIKE xreb_t.xreb113
   DEFINE r_xreb123           LIKE xreb_t.xreb123
   DEFINE r_xreb133           LIKE xreb_t.xreb133
   #其他
   DEFINE l_apcc              RECORD
             apccld           LIKE apcc_t.apccld, 
             apccdocno        LIKE apcc_t.apccdocno,
             apccseq          LIKE apcc_t.apccseq,
             apccsite         LIKE apcc_t.apccsite,
             apcc001          LIKE apcc_t.apcc001,
             apcc100          LIKE apcc_t.apcc100,
             apcc108          LIKE apcc_t.apcc108,
             apcc109          LIKE apcc_t.apcc109,
             apcc113          LIKE apcc_t.apcc113,
             apcc118          LIKE apcc_t.apcc118,
             apcc119          LIKE apcc_t.apcc119,
             apcc123          LIKE apcc_t.apcc123,
             apcc128          LIKE apcc_t.apcc129,
             apcc129          LIKE apcc_t.apcc129,
             apcc133          LIKE apcc_t.apcc133,
             apcc138          LIKE apcc_t.apcc138,
             apcc139          LIKE apcc_t.apcc139
                              END RECORD
   DEFINE l_apce109           LIKE apce_t.apce109
   DEFINE l_apce119           LIKE apce_t.apce119
   DEFINE l_apce129           LIKE apce_t.apce129
   DEFINE l_apce139           LIKE apce_t.apce139
   DEFINE l_apcc108           LIKE apcc_t.apcc108
   DEFINE l_sql               STRING
   DEFINE l_flag              LIKE type_t.chr1
   DEFINE l_glaa001           LIKE glaa_t.glaa001
   DEFINE l_glaa016           LIKE glaa_t.glaa016
   DEFINE l_glaa020           LIKE glaa_t.glaa020
   DEFINE l_xrce109           LIKE xrce_t.xrce109
   DEFINE l_xrce119           LIKE xrce_t.xrce119
   DEFINE l_xrce129           LIKE xrce_t.xrce129
   DEFINE l_xrce139           LIKE xrce_t.xrce139
   #151204--s
   DEFINE l_apce109_1         LIKE apce_t.apce109
   DEFINE l_apce119_1         LIKE apce_t.apce119
   DEFINE l_apce129_1         LIKE apce_t.apce129
   DEFINE l_apce139_1         LIKE apce_t.apce139
   #151204--e   

   SELECT apccld,apccdocno,apccseq,apccsite
         ,apcc001,apcc100,apcc108,apcc109
         ,apcc113,apcc118,apcc119
         ,apcc123,apcc128,apcc129
         ,apcc133,apcc138,apcc139
     INTO l_apcc.* 
     FROM apcc_t
    WHERE apccent = g_enterprise
      AND apccld = p_apccld
      AND apccdocno = p_apccdocno
      AND apccseq   = p_apccseq
      AND apcc001   = p_apcc001

   LET l_flag = cl_get_para(g_enterprise,g_site,'S-FIN-2002')  #應付請款依帳款項次沖帳否

   LET l_apce109 = 0   LET l_apce119 = 0
   LET l_apce129 = 0   LET l_apce139 = 0  #150313
   
   #14/12/23 mark---------------------------------------------------------------
   #LET l_sql = "SELECT SUM(apce109),SUM(apce119),SUM(apce129),SUM(apce139)",
   #            "  FROM apce_t, apda_t",
   #            " WHERE apceent = ",g_enterprise,
   #            "   AND apceld = '",l_apcc.apccld,"'",
   #            "   AND apdaent = apceent",
   #            "   AND apdadocno = apcedocno",
   #            "   AND apdald = apceld",
   #            "   AND apdadocdt > '",p_edate,"'",
   #            "   AND apce003 = '",l_apcc.apccdocno,"'",
   #            "   AND apce005 = '",l_apcc.apcc001,"'"
#  # #應付請款依帳款項次沖帳
#  # IF l_flag = 'Y' THEN
   #   LET l_sql = l_sql," AND apce004 = '",l_apcc.apccseq,"'"
#  # END IF
   #PREPARE aapp920_apce_prep FROM l_sql
   #EXECUTE aapp920_apce_prep INTO l_apce109,l_apce119,l_apce129,l_apce139
   #14/12/23 mark end-----------------------------------------------------------
   
   #14/12/23 add----------------------------------------------------------------
   #原幣未沖金額
   #apcc108-apcc109(扣除大於當期的沖帳金額,反推)
   IF p_xreb004[1,1] <> '0' THEN
      SELECT SUM(apce109),SUM(apce119),SUM(apce129),SUM(apce139)
        INTO l_apce109,l_apce119,l_apce129,l_apce139
        FROM apce_t,apda_t
       WHERE apceent = apdaent AND apcedocno = apdadocno AND apceld = apdald
         AND apceent = g_enterprise
         AND apceld = l_apcc.apccld
         AND apce003 = l_apcc.apccdocno
         AND apce004 = l_apcc.apccseq
         AND apce005 = l_apcc.apcc001
         AND apdadocdt > p_edate
         AND apdastus = 'Y'
         #151204--s
         LET l_apce109_1 = 0   LET l_apce119_1 = 0
         LET l_apce129_1 = 0   LET l_apce139_1 = 0 
         SELECT SUM(apce109),SUM(apce119),SUM(apce129),SUM(apce139)
           INTO l_apce109_1,l_apce119_1,l_apce129_1,l_apce139_1
           FROM apce_t,apca_t
          WHERE apceent = apcaent AND apcedocno = apcadocno AND apceld = apcald
            AND apceent = g_enterprise
            AND apceld = l_apcc.apccld
            AND apce003 = l_apcc.apccdocno
            AND apce004 = l_apcc.apccseq
            AND apce005 = l_apcc.apcc001
            AND apcadocdt > p_edate
            AND apcastus = 'Y'
         #151204--e         
   ELSE
      #沖暫估的回推
      #若為暫估單據則要取 apcf + apca 檔 回推
      #150504 Reanna mark ---
      #SELECT SUM(apcf105),SUM(apcf115),SUM(apcf125),SUM(apcf135)
      #  INTO l_apce109,l_apce119,l_apce129,l_apce139
      #  FROM apcf_t,apca_t
      # WHERE apcfent = apcaent AND apcfdocno = apcadocno AND apcfld = apcald
      #   AND apcfent = g_enterprise
      #   AND apcfld = l_apcc.apccld
      #   AND apcf008 = l_apcc.apccdocno
      #   AND apcf009 = l_apcc.apccseq
      #   AND apcadocdt > p_edate
      #   AND apcastus='Y'
      #150504 Reanna mark end ---
      #150504 Reanna add ---
      SELECT SUM(apcf105),SUM(apcf115),SUM(apcf125),SUM(apcf135)
        INTO l_apce109,l_apce119,l_apce129,l_apce139
        FROM apcf_t,apca_t
       WHERE apcfent = apcaent AND apcfdocno = apcadocno AND apcfld = apcald
         AND apcfent = g_enterprise
         AND apcfld = l_apcc.apccld
         AND apcf008 = l_apcc.apccdocno
         AND apcadocdt > p_edate
         AND apcastus='Y'
      #150504 Reanna add end---
   END IF
   #14/12/23 add end------------------------------------------------------------
   
   IF cl_null(l_apce109) THEN LET l_apce109 = 0 END IF
   IF cl_null(l_apce119) THEN LET l_apce119 = 0 END IF
   IF cl_null(l_apce129) THEN LET l_apce129 = 0 END IF
   IF cl_null(l_apce139) THEN LET l_apce139 = 0 END IF
   #151204--s
   IF cl_null(l_apce109_1) THEN LET l_apce109_1 = 0 END IF
   IF cl_null(l_apce119_1) THEN LET l_apce119_1 = 0 END IF
   IF cl_null(l_apce129_1) THEN LET l_apce129_1 = 0 END IF
   IF cl_null(l_apce139_1) THEN LET l_apce139_1 = 0 END IF
   LET l_apce109 = l_apce109 + l_apce109_1
   LET l_apce119 = l_apce119 + l_apce119_1
   LET l_apce129 = l_apce129 + l_apce129_1
   LET l_apce139 = l_apce139 + l_apce139_1
   #151204--e   
   
   LET r_xreb103 = l_apcc.apcc108 - l_apcc.apcc109 + l_apce109
   LET r_xreb113 = l_apcc.apcc118 - l_apcc.apcc119 + l_apce119 + l_apcc.apcc113
   LET r_xreb123 = l_apcc.apcc128 - l_apcc.apcc129 + l_apce129 + l_apcc.apcc123
   LET r_xreb133 = l_apcc.apcc138 - l_apcc.apcc139 + l_apce139 + l_apcc.apcc133

   #14/12/23 add----------------------------------------------------------------
   #應收回沖
   LET l_xrce109 = 0   LET l_xrce119 = 0  #150313
   LET l_xrce129 = 0   LET l_xrce139 = 0  #150313
   SELECT SUM(xrce109),SUM(xrce119),SUM(xrce129),SUM(xrce139)
     INTO l_xrce109,l_xrce119,l_xrce129,l_xrce139
     FROM xrda_t,xrce_t
    WHERE xrdaent = xrceent AND xrdald = xrceld AND xrdadocno = xrcedocno
      AND xrdaent = g_enterprise
      AND xrdadocdt > p_edate
      AND xrdasite = l_apcc.apccsite   #同一帳務中心
      AND xrdald   = l_apcc.apccld     #同一帳套
      AND xrce003 = l_apcc.apccdocno   #AP 單號
      AND xrce004 = l_apcc.apccseq     #AP 項次
      AND xrce005 = l_apcc.apcc001     #AP 期別
      AND xrdastus= 'Y'
   IF cl_null(l_xrce109) THEN LET l_xrce109=0 END IF
   IF cl_null(l_xrce119) THEN LET l_xrce119=0 END IF
   IF cl_null(l_xrce129) THEN LET l_xrce129=0 END IF
   IF cl_null(l_xrce139) THEN LET l_xrce139=0 END IF
   LET r_xreb103=r_xreb103 + l_xrce109
   LET r_xreb113=r_xreb113 + l_xrce119
   LET r_xreb123=r_xreb123 + l_xrce129
   LET r_xreb133=r_xreb133 + l_xrce139
   #14/12/23 add end------------------------------------------------------------

   IF cl_null(r_xreb103) THEN LET r_xreb103 = 0 END IF
   IF cl_null(r_xreb113) THEN LET r_xreb113 = 0 END IF
   IF cl_null(r_xreb123) THEN LET r_xreb123 = 0 END IF
   IF cl_null(r_xreb133) THEN LET r_xreb133 = 0 END IF

   RETURN r_xreb103,r_xreb113,r_xreb123,r_xreb133
   
END FUNCTION

################################################################################
# Descriptions...: 清空&給預設 #150127-00007#1
# Memo...........:
# Usage..........: CALL aapp920_qbe_clear()
# Date & Author..: 2015/02/24 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aapp920_qbe_clear()
   
   CLEAR FORM
   INITIALIZE g_master.* TO NULL
   CALL g_detail_d.clear()
   
   LET g_master.xrebsite = g_site
   LET g_master.xrebsite_desc = s_desc_get_department_desc(g_master.xrebsite)
   DISPLAY BY NAME g_master.xrebsite_desc
   #預設年度/期別
   CALL cl_get_para(g_enterprise,g_master.xrebsite,'S-FIN-3007') RETURNING l_sfin3007
   LET g_master.xreb001 = YEAR(l_sfin3007)
   LET g_master.xreb002 = MONTH(l_sfin3007)
   
END FUNCTION

#end add-point
 
{</section>}
 
