#該程式未解開Section, 採用最新樣板產出!
{<section id="anmp820.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0008(2014-08-15 15:44:36), PR版次:0008(2016-11-29 16:49:50)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000083
#+ Filename...: anmp820
#+ Description: 調匯還原會計帳務處理
#+ Creator....: 02114(2014-08-13 00:00:00)
#+ Modifier...: 02114 -SD/PR- 02481
 
{</section>}
 
{<section id="anmp820.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#150813-00015#39  2016/01/19 By 02599    增加账务中心、年度、期别栏位检查，年度+期别不可小于关帐日期年度+期别
#160513-00008#4   2016/05/13 By 02599    刪除已產生的同期調匯記錄
#160628-00010#3   2016/07/04 By 01531    新增isbb本位币二、本位币三相关栏位；增加处理isbb114/isbb124/isbb134
#160125-00005#8   2016/08/08 By 02599    帳套增加人員權限條件過濾
#161021-00050#1   2016/10/24 By 08729    處理組織開窗
#161128-00061#2   2016/11/29 by 02481    标准程式定义采用宣告模式,弃用.*写法
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
        source       LIKE type_t.chr1,
        ooef001      LIKE type_t.chr10, 
        ooef001_desc LIKE type_t.chr80, 
        yy           LIKE type_t.chr80, 
        mm           LIKE type_t.chr80, 
   #end add-point
        wc               STRING
                     END RECORD
 
TYPE type_g_detail_d RECORD
#add-point:自定義模組變數(Module Variable)  #注意要在add-point內寫入END RECORD name="global.variable"
     sel             LIKE type_t.chr1,
     glaald          LIKE glaa_t.glaald,
     glaald_desc     LIKE type_t.chr80, 
     glaacomp        LIKE type_t.chr10, 
     glaacomp_desc   LIKE type_t.chr80, 
     b_yy            LIKE type_t.chr80, 
     b_mm            LIKE type_t.chr80, 
     b_date          LIKE nmba_t.nmbadocdt,
     e_date          LIKE nmba_t.nmbadocdt,
     glaa001         LIKE glaa_t.glaa001,
     glca002         LIKE glca_t.glca002,
     glca003         LIKE glca_t.glca003,
     xreb023         LIKE xreb_t.xreb023
     END RECORD
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"
DEFINE g_input type_parameter
DEFINE g_glaa001             LIKE glaa_t.glaa001
DEFINE g_glaa003             LIKE glaa_t.glaa003
DEFINE g_glaa005             LIKE glaa_t.glaa005
DEFINE g_glaa004             LIKE glaa_t.glaa004
DEFINE g_glaa008             LIKE glaa_t.glaa008
DEFINE g_glaa014             LIKE glaa_t.glaa014
DEFINE g_glaa015             LIKE glaa_t.glaa015
DEFINE g_glaa016             LIKE glaa_t.glaa016
DEFINE g_glaa017             LIKE glaa_t.glaa017
DEFINE g_glaa018             LIKE glaa_t.glaa018
DEFINE g_glaa019             LIKE glaa_t.glaa019
DEFINE g_glaa020             LIKE glaa_t.glaa020
DEFINE g_glaa021             LIKE glaa_t.glaa021
DEFINE g_glaa022             LIKE glaa_t.glaa022
DEFINE g_rec_b               LIKE type_t.num5
#end add-point
 
{</section>}
 
{<section id="anmp820.main" >}
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
   CALL cl_ap_init("anm","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_anmp820 WITH FORM cl_ap_formpath("anm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL anmp820_init()   
 
      #進入選單 Menu (="N")
      CALL anmp820_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_anmp820
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   DROP TABLE anmp820_tmp;
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="anmp820.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION anmp820_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   CALL anmp820_set_combo_scc("yy","43")
   CALL anmp820_set_combo_scc("mm","39")
   CALL cl_set_combo_scc("glca002","8317")
   CALL cl_set_combo_scc("glca003","40")
   CALL s_fin_create_account_center_tmp()    #160125-00005#8
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="anmp820.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION anmp820_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_flag          LIKE type_t.chr1       #檢核狀態
   DEFINE l_errno         LIKE type_t.chr100     #錯誤訊息
   DEFINE l_glav002       LIKE glav_t.glav002    #會計年度
   DEFINE l_glav005       LIKE glav_t.glav005    #歸屬季別
   DEFINE l_sdate_s       LIKE glav_t.glav004    #當季起始日
   DEFINE l_sdate_e       LIKE glav_t.glav004    #當季截止日
   DEFINE l_glav006       LIKE glav_t.glav006    #歸屬期別
   DEFINE l_pdate_s       LIKE glav_t.glav004    #當期起始日
   DEFINE l_pdate_e       LIKE glav_t.glav004    #當期截止日
   DEFINE l_glav007       LIKE glav_t.glav007    #歸屬週別
   DEFINE l_wdate_s       LIKE glav_t.glav004    #當週起始日
   DEFINE l_wdate_e       LIKE glav_t.glav004    #當週截止日
   DEFINE l_n             LIKE type_t.num5
   DEFINE l_sel           LIKE type_t.chr1
   DEFINE l_clo_date      LIKE type_t.dat        #150813-00015#39 add
   DEFINE l_success       LIKE type_t.num5       #150813-00015#39 add
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
         CALL anmp820_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT BY NAME g_input.source,g_input.ooef001,g_input.ooef001_desc,
                       g_input.yy,g_input.mm     
               ATTRIBUTE(WITHOUT DEFAULTS)
               
            BEFORE INPUT 
               #2015/01/29---add---by---qiull(S)
               CALL s_fin_get_account_center('',g_user,'3',g_today) RETURNING g_sub_success,g_input.ooef001,g_errno
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_input.ooef001
               CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_input.ooef001_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_input.ooef001_desc
               #2015/01/29---add---by---qiull(E)
               LET g_input.yy = YEAR(g_today)
               LET g_input.mm = MONTH(g_today)
               #CALL cl_get_para(g_enterprise,g_nmbs_m.nmbscomp,'S-FIN-4004') RETURNING g_para_data
               
               #獲取當前年度期別的第一天和最後一天
               CALL s_get_accdate(g_glaa003,'',g_input.yy,g_input.mm)
               RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e 
               LET g_input.source = '1'
               DISPLAY g_input.source TO source
            
            AFTER FIELD ooef001
               #150813-00015#39--add--str--
               IF NOT cl_null(g_input.ooef001) THEN
                  CALL s_fin_account_center_chk(g_input.ooef001,'',3,g_today) RETURNING l_success,g_errno
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_input.ooef001
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
                     LET g_input.ooef001 = ''
                     LET g_input.ooef001_desc = ''
                     NEXT FIELD ooef001
                  END IF
               ELSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'acr-00015'
                  LET g_errparam.extend = g_input.ooef001
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  NEXT FIELD ooef001
               END IF
               #150813-00015#39--add--end
            #2015/01/29---add---by---qiull(S)
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_input.ooef001
               CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_input.ooef001_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_input.ooef001_desc
            
            #150813-00015#39--add--str--
            ON CHANGE yy
               IF NOT cl_null(g_input.yy) THEN
                  #关账日期
                  CALL cl_get_para(g_enterprise,g_input.ooef001,'S-FIN-4007') RETURNING l_clo_date
                  IF g_input.yy < YEAR(l_clo_date) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = g_input.yy
                     LET g_errparam.code   = 'anm-00387'
                     LET g_errparam.popup  = FALSE 
                     CALL cl_err()
                     LET g_input.yy = ''
                     NEXT FIELD yy
                  END IF
                  IF NOT cl_null(g_input.mm) THEN
                     IF g_input.yy = YEAR(l_clo_date) AND g_input.mm < MONTH(l_clo_date) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = g_input.mm
                        LET g_errparam.code   = 'anm-00387'
                        LET g_errparam.popup  = FALSE 
                        CALL cl_err()
                        LET g_input.mm = ''
                        NEXT FIELD mm
                     END IF
                  END IF
               END IF
               
            ON CHANGE mm
               IF NOT cl_null(g_input.mm) THEN
                  #关账日期
                  CALL cl_get_para(g_enterprise,g_input.ooef001,'S-FIN-4007') RETURNING l_clo_date
                  IF g_input.yy = YEAR(l_clo_date) AND g_input.mm < MONTH(l_clo_date) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = g_input.mm
                     LET g_errparam.code   = 'anm-00387'
                     LET g_errparam.popup  = FALSE 
                     CALL cl_err()
                     LET g_input.mm = ''
                     NEXT FIELD mm
                  END IF
               END IF
            #150813-00015#39--add--end
            
            ON ACTION controlp INFIELD ooef001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_input.ooef001
               #LET g_qryparam.where = " ooef206 = 'Y'"  #161021-00050#1 mark
               #CALL q_ooef001()                         #161021-00050#1 mark
               CALL q_ooef001_46()                       #161021-00050#1 add
               LET g_input.ooef001 = g_qryparam.return1  
               DISPLAY BY NAME g_input.ooef001
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_input.ooef001
               CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_input.ooef001_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_input.ooef001_desc
               NEXT FIELD ooef001
            #2015/01/29---add---by---qiull(E)
               
                                      #返回原欄位             
         END INPUT
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         INPUT ARRAY g_detail_d FROM s_detail1.* 
              ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                        INSERT ROW = FALSE,
                        DELETE ROW = FALSE,
                        APPEND ROW = FALSE)
            BEFORE INPUT
               IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
                 CALL FGL_SET_ARR_CURR(g_detail_d.getLength()+1) 
                 LET g_insert = 'N' 
               END IF 
             
            BEFORE ROW
               LET l_ac = ARR_CURR()
               LET g_master_idx = l_ac
               DISPLAY l_ac TO FORMONLY.h_index
               CALL anmp820_fetch()              
               
            ON CHANGE sel
               #已拋總帳的不可勾選執行重評價還原
               IF NOT cl_null(g_detail_d[l_ac].xreb023) THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_detail_d[l_ac].glaald
                  LET g_errparam.code   = 'anm-00231'
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  
                  LET g_detail_d[l_ac].sel = 'N'
                  EXIT DIALOG
               END IF
               
               #設置1:無重評價處理。或沒有設置的不可勾選執行重評價還原
               IF g_detail_d[l_ac].glca002 = '1' OR cl_null(g_detail_d[l_ac].glca002) THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_detail_d[l_ac].glaald
                  LET g_errparam.code   = 'anm-00230'
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  
                  LET g_detail_d[l_ac].sel = 'N'
                  EXIT DIALOG
               END IF
               
               #單身年度月份與單頭不一樣的不可勾選執行重評價還原
               IF g_detail_d[l_ac].b_yy <> g_input.yy OR g_detail_d[l_ac].b_mm <> g_input.mm THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_detail_d[l_ac].glaald
                  LET g_errparam.code   = 'anm-00232'
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  
                  LET g_detail_d[l_ac].sel = 'N'
                  EXIT DIALOG
               END IF
               
               UPDATE anmp820_tmp 
                  SET sel = g_detail_d[l_ac].sel 
                WHERE glaald = g_detail_d[l_ac].glaald 
                
               SELECT sel INTO l_sel 
                 FROM anmp820_tmp
                WHERE glaald = g_detail_d[l_ac].glaald 
            
         
         END INPUT
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
            FOR li_idx = 1 TO g_detail_d.getLength()
               #已拋總帳的不可勾選執行重評價還原
               IF NOT cl_null(g_detail_d[li_idx].xreb023) THEN 
                  LET g_detail_d[li_idx].sel = "N"
               END IF
               #設置1:無重評價處理。或沒有設置的不可勾選執行重評價還原
               IF g_detail_d[li_idx].glca002 = '1' OR cl_null(g_detail_d[li_idx].glca002) THEN 
                  LET g_detail_d[li_idx].sel = 'N'
               END IF
               #單身年度月份與單頭不一樣的不可勾選執行重評價還原
               IF g_detail_d[li_idx].b_yy <> g_input.yy OR g_detail_d[li_idx].b_mm <> g_input.mm THEN 
                  LET g_detail_d[li_idx].sel = 'N'
               END IF
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
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  #已拋總帳的不可勾選執行重評價還原
                  IF NOT cl_null(g_detail_d[li_idx].xreb023) THEN 
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_detail_d[l_ac].glaald
                     LET g_errparam.code   = 'anm-00231'
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                     LET g_detail_d[li_idx].sel = 'N'
                     EXIT DIALOG
                  END IF
                  
                  #設置1:無重評價處理。或沒有設置的不可勾選執行重評價還原
                  IF g_detail_d[li_idx].glca002 = '1' OR cl_null(g_detail_d[li_idx].glca002) THEN 
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_detail_d[li_idx].glaald
                     LET g_errparam.code   = 'anm-00230'
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                     LET g_detail_d[li_idx].sel = 'N'
                     EXIT DIALOG
                  END IF
                  
                  #單身年度月份與單頭不一樣的不可勾選執行重評價還原
                  IF g_detail_d[li_idx].b_yy <> g_input.yy OR g_detail_d[li_idx].b_mm <> g_input.mm THEN 
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_detail_d[li_idx].glaald
                     LET g_errparam.code   = 'anm-00232'
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                     LET g_detail_d[li_idx].sel = 'N'
                     EXIT DIALOG
                  END IF
               END IF
            END FOR
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
            CALL anmp820_filter()
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
            CALL anmp820_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL anmp820_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            SELECT COUNT(*) INTO l_n
              FROM anmp820_tmp
             WHERE sel = 'Y'
            IF l_n = 0 THEN 
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "" 
               LET g_errparam.code   = 'axr-00159' 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               
               EXIT DIALOG
            END IF
            
            IF g_input.source = '1' THEN 
               CALL anmp820_nm()
            END IF
            
            IF g_input.source = '2' THEN
               CALL anmp820_np()   
            END IF
            IF g_input.source = '3' THEN
               CALL anmp820_nr()
            END IF
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
 
{<section id="anmp820.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION anmp820_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   
   #end add-point
        
   LET g_error_show = 1
   CALL anmp820_b_fill()
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
 
{<section id="anmp820.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION anmp820_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_ooab002       LIKE ooab_t.ooab002
   DEFINE l_yy            LIKE type_t.num5
   DEFINE l_mm            LIKE type_t.num5
   DEFINE l_glaa003       LIKE glaa_t.glaa003
   DEFINE l_flag          LIKE type_t.chr1       #檢核狀態
   DEFINE l_errno         LIKE type_t.chr100     #錯誤訊息
   DEFINE l_glav002       LIKE glav_t.glav002    #會計年度
   DEFINE l_glav005       LIKE glav_t.glav005    #歸屬季別
   DEFINE l_sdate_s       LIKE glav_t.glav004    #當季起始日
   DEFINE l_sdate_e       LIKE glav_t.glav004    #當季截止日
   DEFINE l_glav006       LIKE glav_t.glav006    #歸屬期別
   DEFINE l_pdate_s       LIKE glav_t.glav004    #當期起始日
   DEFINE l_pdate_e       LIKE glav_t.glav004    #當期截止日
   DEFINE l_glav007       LIKE glav_t.glav007    #歸屬週別
   DEFINE l_wdate_s       LIKE glav_t.glav004    #當週起始日
   DEFINE l_wdate_e       LIKE glav_t.glav004    #當週截止日
   DEFINE l_ld_str        STRING                 #160125-00005#8
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL anmp820_create_tmp() RETURNING l_success
   DELETE FROM anmp820_tmp
    
   IF g_input.source = '1' THEN    #银行存款
      LET g_sql = "SELECT DISTINCT 'N',glaald,'',glaacomp,'','','','','',glaa001,'','',nmde017 FROM glaa_t ",
               "  LEFT OUTER JOIN nmde_t ON nmdeent = glaaent ",
               "   AND nmdeld = glaald ",
               "   AND nmde001 = '",g_input.yy,"'",
               "   AND nmde002 = '",g_input.mm,"'",
               "   AND nmde003 = 'NM' ",
               " WHERE glaaent = ? "
   END IF
   
   IF g_input.source = '2' THEN    #应付票据
      LET g_sql = "SELECT DISTINCT 'N',glaald,'',glaacomp,'','','','','',glaa001,'','',xreb023 FROM glaa_t ",
                  "  LEFT OUTER JOIN xreb_t ON xrebent = glaaent ",
                  "   AND xrebld = glaald ",
                  "   AND xreb001 = '",g_input.yy,"'",
                  "   AND xreb002 = '",g_input.mm,"'",
                  "   AND xreb003 = 'NM' ",
                  "   AND xreb004 = 'NP' ",    
                  " WHERE glaaent = ? "
   END IF
   IF g_input.source = '3' THEN    #应收票据
      LET g_sql = "SELECT DISTINCT 'N',glaald,'',glaacomp,'','','','','',glaa001,'','',xreb023 FROM glaa_t ",
                  "  LEFT OUTER JOIN xreb_t ON xrebent = glaaent ",
                  "   AND xrebld = glaald ",
                  "   AND xreb001 = '",g_input.yy,"'",
                  "   AND xreb002 = '",g_input.mm,"'",
                  "   AND xreb003 = 'NM' ",
                  "   AND xreb004 = 'NR' ",
                  " WHERE glaaent = ? "
   END IF
#160125-00005#8--add--str--
   #取得帳務組織下所屬成員
   CALL s_fin_account_center_sons_query('3',g_input.ooef001,g_today,'1')
   #取得帳務組織下所屬成員之帳別
   CALL s_fin_account_center_comp_str() RETURNING ls_wc
   #將取回的字串轉換為SQL條件
   CALL anmp820_get_ooef001_wc(ls_wc) RETURNING ls_wc
   LET ls_wc=ls_wc.substring(3,ls_wc.getLength()-2)
   #账套范围
   CALL s_axrt300_get_site(g_user,ls_wc,'2')  RETURNING l_ld_str 
   IF NOT cl_null(l_ld_str) THEN   
      LET g_sql = g_sql, " AND ",l_ld_str
   END IF
#160125-00005#8--add--end
#160125-00005#8--mark--str--      
#   #2015/01/29---add---by---qiull(S)
#   CALL s_fin_create_account_center_tmp()
#   #取得帳務組織下所屬成員
#   CALL s_fin_account_center_sons_query('3',g_input.ooef001,g_today,'1')
#   #取得帳務組織下所屬成員之帳別
#   CALL s_fin_account_center_comp_str() RETURNING ls_wc
#   #將取回的字串轉換為SQL條件
#   CALL anmp820_get_ooef001_wc(ls_wc) RETURNING ls_wc  
#   IF NOT cl_null(g_input.ooef001) THEN
#      #查出有權限的帳套 
#      LET g_sql = g_sql , " AND glaald IN (" ,
#                          " SELECT glaald FROM ",
#                          " ( ",
#                          " ( ",
#                          " SELECT glaald ",
#                          "   FROM glaa_t ",
#                          "  WHERE NOT EXISTS(SELECT 1 FROM glba_t WHERE glbaent = glaaent AND glbald = glaald ) ",
#                          "    AND NOT EXISTS(SELECT 1 FROM glbb_t WHERE glbbent = glaaent AND glbbld = glaald ) ",
#                          " ) ",
#                          " UNION ",
#                          " ( ",
#                          " SELECT glaald ",
#                          "   FROM glaa_t,glba_t ",
#                          "  WHERE glbaent = glaaent AND glbald = glaald AND glba001 = '",g_user,"'",
#                          " ) ",
#                          " UNION ",
#                          " ( ",
#                          " SELECT glaald ",
#                          "   FROM glaa_t,glbb_t ",
#                          "  WHERE glbbent = glaaent AND glbbld = glaald AND glbb001 = '",g_dept,"'",
#                          " ) ",
#                          " ) ",
#                          "  WHERE glaastus ='Y' ",
#                          "    AND glaacomp IN ",ls_wc," ",
#                          " )"
#   ELSE
#   #2015/01/29---add---by---qiull(E) 
#      #查出有權限的帳套 
#      LET g_sql = g_sql , " AND glaald IN (" ,
#                          " SELECT glaald FROM ",
#                          " ( ",
#                          " ( ",
#                          " SELECT glaald ",
#                          "   FROM glaa_t ",
#                          "  WHERE NOT EXISTS(SELECT 1 FROM glba_t WHERE glbaent = glaaent AND glbald = glaald ) ",
#                          "    AND NOT EXISTS(SELECT 1 FROM glbb_t WHERE glbbent = glaaent AND glbbld = glaald ) ",
#                          " ) ",
#                          " UNION ",
#                          " ( ",
#                          " SELECT glaald ",
#                          "   FROM glaa_t,glba_t ",
#                          "  WHERE glbaent = glaaent AND glbald = glaald AND glba001 = '",g_user,"'",
#                          " ) ",
#                          " UNION ",
#                          " ( ",
#                          " SELECT glaald ",
#                          "   FROM glaa_t,glbb_t ",
#                          "  WHERE glbbent = glaaent AND glbbld = glaald AND glbb001 = '",g_dept,"'",
#                          " ) ",
#                          " ) ",
#                          "  WHERE glaastus ='Y' ",
#                          " )"
#   END IF                        #2015/01/29---add---by---qiull                     
#160125-00005#8--mark--end
   #end add-point
 
   PREPARE anmp820_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR anmp820_sel
   
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
      CALL anmp820_glaald_desc()
      
      SELECT glaa003 INTO l_glaa003
        FROM glaa_t
       WHERE glaaent = g_enterprise
         AND glaald = g_detail_d[l_ac].glaald
      
      CALL cl_get_para(g_enterprise,g_detail_d[l_ac].glaacomp,'S-FIN-4007') RETURNING l_ooab002
      
      LET l_yy = YEAR(l_ooab002)
      LET l_mm = MONTH(l_ooab002)
      
      IF l_mm = '12' THEN 
         LET g_detail_d[l_ac].b_yy = l_yy + 1
         LET g_detail_d[l_ac].b_mm = 1
      ELSE
         LET g_detail_d[l_ac].b_yy = l_yy
         LET g_detail_d[l_ac].b_mm = l_mm + 1
      END IF
      
      #獲取當前年度期別的第一天和最後一天
      CALL s_get_accdate(l_glaa003,'',g_detail_d[l_ac].b_yy,g_detail_d[l_ac].b_mm)
      RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e    

      LET g_detail_d[l_ac].b_date = l_pdate_s
      LET g_detail_d[l_ac].e_date = l_pdate_e
      
      IF g_input.source = '1' THEN 
         SELECT glca002,glca003 INTO g_detail_d[l_ac].glca002,g_detail_d[l_ac].glca003 
           FROM glca_t
          WHERE glcaent = g_enterprise
            AND glcald = g_detail_d[l_ac].glaald
            AND glca001 = 'NM'
      END IF
      
      IF g_input.source = '2' THEN 
         SELECT glca002,glca003 INTO g_detail_d[l_ac].glca002,g_detail_d[l_ac].glca003 
           FROM glca_t
          WHERE glcaent = g_enterprise
            AND glcald = g_detail_d[l_ac].glaald
            AND glca001 = 'NP'
      END IF  
      IF g_input.source = '3' THEN 
         SELECT glca002,glca003 INTO g_detail_d[l_ac].glca002,g_detail_d[l_ac].glca003 
           FROM glca_t
          WHERE glcaent = g_enterprise
            AND glcald = g_detail_d[l_ac].glaald
            AND glca001 = 'NR'
      END IF  
         
      INSERT INTO anmp820_tmp VALUES(g_detail_d[l_ac].*)
      #end add-point
      
      CALL anmp820_detail_show()      
 
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
   FREE anmp820_sel
   
   LET l_ac = 1
   CALL anmp820_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="anmp820.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION anmp820_fetch()
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
 
{<section id="anmp820.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION anmp820_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="anmp820.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION anmp820_filter()
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
   
   CALL anmp820_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="anmp820.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION anmp820_filter_parser(ps_field)
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
 
{<section id="anmp820.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION anmp820_filter_show(ps_field,ps_object)
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
   LET ls_condition = anmp820_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="anmp820.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"
# 年度,月份
PRIVATE FUNCTION anmp820_set_combo_scc(p_field,p_scc)
   DEFINE p_field        LIKE type_t.chr80
   DEFINE p_scc          LIKE type_t.num5
   DEFINE l_gzcb002      LIKE gzcb_t.gzcb002
   DEFINE l_gzcbl004     LIKE gzcbl_t.gzcbl004
   DEFINE comb_value     STRING
   DEFINE comb_item      STRING
   DEFINE l_str          STRING 
   
   DECLARE gzcb_cs CURSOR FOR
    SELECT gzcb002,gzcbl004 FROM gzcb_t LEFT OUTER join gzcbl_t ON gzcbl001 = gzcb001
                                                               AND gzcbl002 = gzcb002
                                                               AND gzcbl003 = g_dlang
     WHERE gzcb001 = p_scc
   FOREACH gzcb_cs INTO l_gzcb002,l_gzcbl004
       LET l_str = l_gzcb002
       LET l_str = l_str.substring(1,1)
       IF l_str = '0' THEN 
          LET l_str = l_gzcb002
          LET l_gzcb002 = l_str.substring(2,2)
       END IF 
       LET comb_value = comb_value CLIPPED,',',l_gzcb002
       LET comb_item  = comb_item  CLIPPED,',',l_gzcb002
       
   END FOREACH
   CALL cl_set_combo_items(p_field,comb_value,comb_item)
END FUNCTION
# 帳套名稱
PRIVATE FUNCTION anmp820_glaald_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_detail_d[l_ac].glaald
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_detail_d[l_ac].glaald_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_detail_d[l_ac].glaald_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_detail_d[l_ac].glaald
   CALL ap_ref_array2(g_ref_fields,"SELECT glaacomp FROM glaa_t WHERE glaaent='"||g_enterprise||"' AND glaald=? ","") RETURNING g_rtn_fields
   LET g_detail_d[l_ac].glaacomp = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_detail_d[l_ac].glaacomp
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_detail_d[l_ac].glaacomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_detail_d[l_ac].glaacomp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_detail_d[l_ac].glaacomp_desc
END FUNCTION
# 抓取年度,月份,起始日,截止日
PRIVATE FUNCTION anmp820_get_date()
   
END FUNCTION
# 創建臨時表
PRIVATE FUNCTION anmp820_create_tmp()
   DEFINE r_success       LIKE type_t.num5
   
   WHENEVER ERROR CONTINUE
   LET r_success = FALSE
   
   DROP TABLE anmp820_tmp;
   CREATE TEMP TABLE anmp820_tmp(
     sel              VARCHAR(1),
     glaald           VARCHAR(5),
     glaald_desc      VARCHAR(80), 
     glaacomp         VARCHAR(10), 
     glaacomp_desc    VARCHAR(80), 
     b_yy             VARCHAR(80), 
     b_mm             VARCHAR(80), 
     b_date           DATE,
     e_date           DATE,
     glaa001          VARCHAR(10),
     glca002          VARCHAR(10),
     glca003          VARCHAR(10),
     xreb023          VARCHAR(30)
   );
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "create" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      
      RETURN r_success
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION
# 應收票據月底重評價還原
PRIVATE FUNCTION anmp820_nr()
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_ooao011_p     LIKE ooao_t.ooao011    #上月重評價匯率
   DEFINE l_ooao011_p_2   LIKE ooao_t.ooao011    #上月本位幣二重評價匯率
   DEFINE l_ooao011_p_3   LIKE ooao_t.ooao011    #上月本位幣三重評價匯率
   DEFINE l_ooef015       LIKE ooef_t.ooef015    #法人所使用匯率參照表
   DEFINE l_ooam003       LIKE ooam_t.ooam003    #基礎幣別
   DEFINE l_date          LIKE type_t.chr10      #年月 值如201405,前面4碼是西元年,後面2碼是月份
   DEFINE l_xrebcomp      LIKE xreb_t.xrebcomp   #法人
   DEFINE l_xrebld        LIKE xreb_t.xrebld     #帳別
   DEFINE l_xreb001       LIKE xreb_t.xreb001    #年度
   DEFINE l_xreb002       LIKE xreb_t.xreb002    #期別
   DEFINE l_xreb005       LIKE xreb_t.xreb005    #單據號碼
   DEFINE l_xreb100       LIKE xreb_t.xreb100    #幣別
   DEFINE l_yy            LIKE type_t.num5       #年
   DEFINE l_mm            LIKE type_t.num5       #月
   DEFINE l_xreb006       LIKE xreb_t.xreb006    #项次 #160628-00010#3  
   CALL s_transaction_begin()
   #CALL cl_showmsg_init()
   LET g_success = 'Y'
   
   #檢查是否已拋轉總帳
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM xreb_t
    WHERE xrebent = g_enterprise
      AND xrebld IN (SELECT glaald FROM anmp820_tmp WHERE sel = 'Y')
      AND xreb001 = g_input.yy
      AND xreb002 = g_input.mm
      AND xreb003 = 'NM' 
      AND xreb004 = 'NR' 
      AND xreb023 IS NOT NULL
   IF l_cnt > 0 THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'anm-00231'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN 
   END IF
   
   #檢查是否有大於本月的異動記錄
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt 
     FROM xreb_t
    WHERE xrebent = g_enterprise
      AND xrebld IN (SELECT glaald FROM anmp820_tmp WHERE sel = 'Y')
      AND xreb003 = 'NR' 
      AND (xreb001 > g_input.yy OR (xreb001 = g_input.yy AND xreb002 > g_input.mm))
   IF l_cnt > 0 THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'anm-00233'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN 
   END IF
  
   #檢查是否有沖帳資料
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM nmba_t,nmbb_t 
    WHERE nmbaent = nmbbent
      AND nmbacomp = nmbbcomp
      AND nmbadocno = nmbbdocno
      AND nmbb004 != g_glaa001
      AND (nmbb042 = '1' OR nmbb069 = 'Y')
      AND (nmbastus = 'Y' OR nmbastus = 'V')
      AND nmbadocdt <= l_pdate_e 
      AND nmbadocno IN (SELECT xrce003 FROM xrda_t,xrce_t 
                         WHERE xrdaent = xrceent
                           AND xrdald = xrceld
                           AND xrdadocno = xrcedocno
                           AND xrdald IN (SELECT glaald FROM anmp820_tmp WHERE sel = 'Y')
                           AND xrdastus <> 'X'
                           AND xrdadocdt > l_pdate_s )
   IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
   IF l_cnt > 0 THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'anm-00219'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = 'N' 
      RETURN 
   END IF
   
   CALL cl_err_collect_init()
   #還原
   LET g_sql = "SELECT xrebcomp,xrebld,xreb005,xreb100,xreb006 FROM xreb_t ",  ##160628-00010#3 add xreb006
               " WHERE xrebent = '",g_enterprise,"'",
               "   AND xrebld IN (SELECT glaald FROM anmp820_tmp WHERE sel = 'Y') ",
               "   AND xreb001 = '",g_input.yy,"'",
               "   AND xreb002 = '",g_input.mm,"'",
               "   AND xreb003 = 'NM' ",
               "   AND xreb004 = 'NR' "
   PREPARE anmp820_del_pre FROM g_sql
   DECLARE anmp820_del_cur CURSOR FOR anmp820_del_pre
   
   FOREACH anmp820_del_cur INTO l_xrebcomp,l_xrebld,l_xreb005,l_xreb100,l_xreb006 ##160628-00010#3 add xreb006
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
      
         EXIT FOREACH
      END IF
      
      SELECT glaa001,glaa003,glaa005,glaa004,glaa008,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022 
        INTO g_glaa001,g_glaa003,g_glaa005,g_glaa004,g_glaa008,g_glaa014,g_glaa015,
             g_glaa016,g_glaa017,g_glaa018,g_glaa019,g_glaa020,g_glaa021,g_glaa022 
        FROM glaa_t
       WHERE glaaent = g_enterprise
         AND glaald = l_xrebld
      
      IF g_input.mm = 1 THEN 
         LET l_mm = 12
         LET l_yy = g_input.yy - 1
      ELSE
         LET l_mm = g_input.mm - 1
         LET l_yy = g_input.yy
      END IF
      
      IF l_mm < 10 THEN         
         LET l_date = l_yy CLIPPED,'0' CLIPPED,l_mm
      ELSE
         LET l_date = l_yy CLIPPED,l_mm 
      END IF
      
      
      #抓取上月重評價匯率
      SELECT ooao011 INTO l_ooao011_p 
        FROM ooao_t 
       WHERE ooaoent = g_enterprise
         AND ooao001 = l_ooef015
         AND ooao002 = sr.nmck100
         AND ooao003 = g_glaa001
         AND ooao004 = l_date
         
      IF cl_null(l_ooao011_p) OR l_ooao011_p = 0  THEN    
         LET l_ooao011_p = 1
      END IF
      
      #上月本位幣二重評價匯率
      IF g_glaa017 = '1' THEN 
         LET l_ooam003 = l_xreb100
      ELSE
         LET l_ooam003 = g_glaa001
      END IF
      
      SELECT ooao011 INTO l_ooao011_p_2 
        FROM ooao_t 
       WHERE ooaoent = g_enterprise
         AND ooao001 = l_ooef015
         AND ooao002 = l_ooam003
         AND ooao003 = g_glaa016
         AND ooao004 = l_date1
         
      IF cl_null(l_ooao011_p_2) THEN 
         LET l_ooao011_p_2 = 1
      END IF
      
      #上月本位幣三重評價匯率
      IF g_glaa021 = '1' THEN 
         LET l_ooam003 = l_xreb100
      ELSE
         LET l_ooam003 = g_glaa001
      END IF
      
      SELECT ooao011 INTO l_ooao011_p_3 
        FROM ooao_t 
       WHERE ooaoent = g_enterprise
         AND ooao001 = l_ooef015
         AND ooao002 = l_ooam003
         AND ooao003 = g_glaa020
         AND ooao004 = l_date1
         
      IF cl_null(l_ooao011_p_3) THEN 
         LET l_ooao011_p_3 = 1
      END IF
      
      
      #還原重評價金額 
      UPDATE nmbb_t SET nmbb066 = nmbb006 * l_ooao011_p,
                        nmbb067 = nmbb013 * l_ooao011_p_2,
                        nmbb068 = nmbb017 * l_ooao011_p_3
       WHERE nmbbent = g_enterprise
         AND nmbbcomp = l_xrebcomp
         AND nmbbdocno = l_xreb005
         AND nmbbseq = l_xreb006  #160628-00010#3
         
      IF SQLCA.sqlcode THEN
         #CALL cl_errmsg("upd nmbb",'','',SQLCA.SQLCODE,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd nmbb"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N'       
      END IF
      
      #160628-00010#3 add s---
      #還原重評價金額 
      UPDATE isbb_t SET isbb114 = isbb103 * l_ooao011_p,
                        isbb124 = isbb123 * l_ooao011_p_2,
                        isbb134 = isbb133 * l_ooao011_p_3
       WHERE isbbent = g_enterprise
         AND isbbcomp = l_xrebcomp
         AND isbb002 = l_xreb005
         AND isbb003 = l_xreb006  #160628-00010#3
         
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd isbb"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N'       
      END IF      
      #160628-00010#3 add e---
      
      #還原月底重評價年度月份
      LET g_sql = "SELECT xreb001,xreb002 FROM xreb_t ",
                  " WHERE xrebent = '",g_enterprise,"'",
                  "   AND xrebld  = '",l_xrebld,"'",
                  "   AND (xreb001 < '",g_input.yy,"'",
                  "    OR (xreb001 = '",g_input.yy,"'", 
                  "   AND xreb002  < '",g_input.mm,"')",
                  "       )",
                  "   AND xreb003 = 'NM' ",
                  "   AND xreb004 = 'NR' ",
                  " ORDER BY xreb001 desc,xreb002 desc  "
      PREPARE anmp820_del_pre_1 FROM g_sql
      DECLARE anmp820_del_cur_1 CURSOR FOR anmp820_del_pre_1
      
      FOREACH anmp820_del_cur_1 INTO l_xreb001,l_xreb002
         EXIT FOREACH
      END FOREACH 
      
      UPDATE glca_t SET glca006 = l_xreb001,
                        glca007 = l_xreb002
       WHERE glcaent = g_enterprise
         AND glcald = l_xrebld
         AND glca001 = 'NR'
         
      IF SQLCA.sqlcode THEN
         #CALL cl_errmsg("upd glca",'','',SQLCA.SQLCODE,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd glca"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N'       
      END IF
   END FOREACH 
   DELETE FROM xreb_t WHERE xrebent = g_enterprise
                        AND xrebld IN (SELECT glaald FROM anmp820_tmp WHERE sel = 'Y') 
                        AND xreb001 = g_input.yy
                        AND xreb002 = g_input.mm
                        AND xreb003 = 'NM' 
                        AND xreb004 = 'NR' 
   IF SQLCA.sqlcode THEN
      #CALL cl_errmsg("del xreb",'','',SQLCA.SQLCODE,1)
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "del xreb"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = 'N'       
   END IF
   CALL cl_err_collect_show()
   IF g_success = 'Y' THEN
      CALL s_transaction_end('Y',1)
   ELSE 
      CALL s_transaction_end('N',1)
   END IF
END FUNCTION
# 應付票據月底重評價還原
PRIVATE FUNCTION anmp820_np()
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_ooao011_p     LIKE ooao_t.ooao011    #上月重評價匯率
   DEFINE l_ooao011_p_2   LIKE ooao_t.ooao011    #上月本位幣二重評價匯率
   DEFINE l_ooao011_p_3   LIKE ooao_t.ooao011    #上月本位幣三重評價匯率
   DEFINE l_ooef015       LIKE ooef_t.ooef015    #法人所使用匯率參照表
   DEFINE l_ooam003       LIKE ooam_t.ooam003    #基礎幣別
   DEFINE l_date          LIKE type_t.chr10      #年月 值如201405,前面4碼是西元年,後面2碼是月份
   DEFINE l_xrebcomp      LIKE xreb_t.xrebcomp   #法人
   DEFINE l_xrebld        LIKE xreb_t.xrebld     #帳別
   DEFINE l_xreb005       LIKE xreb_t.xreb005    #單據號碼
   DEFINE l_xreb001       LIKE xreb_t.xreb001    #年度
   DEFINE l_xreb002       LIKE xreb_t.xreb002    #期別
   DEFINE l_xreb100       LIKE xreb_t.xreb100    #幣別
   DEFINE l_yy            LIKE type_t.num5       #年
   DEFINE l_mm            LIKE type_t.num5       #月                      
  
   CALL s_transaction_begin()
   #CALL cl_showmsg_init()
   LET g_success = 'Y'
   
   #檢查是否已拋轉總帳
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM xreb_t
    WHERE xrebent = g_enterprise
      AND xrebld IN (SELECT glaald FROM anmp820_tmp WHERE sel = 'Y')
      AND xreb001 = g_input.yy
      AND xreb002 = g_input.mm
      AND xreb003 = 'NM' 
      AND xreb004 = 'NP' 
      AND xreb023 IS NOT NULL
   IF l_cnt > 0 THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'anm-00231'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN 
   END IF
   
   #檢查是否有大於本月的異動記錄
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt 
     FROM xreb_t
    WHERE xrebent = g_enterprise
      AND xrebld IN (SELECT glaald FROM anmp820_tmp WHERE sel = 'Y')
      AND xreb003 = 'NR' 
      AND (xreb001 > g_input.yy OR (xreb001 = g_input.yy AND xreb002 > g_input.mm))
   IF l_cnt > 0 THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'anm-00233'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN 
   END IF
   
   CALL cl_err_collect_init()

   #還原
   LET g_sql = "SELECT xrebcomp,xrebld,xreb005 FROM xreb_t ",
               " WHERE xrebent = '",g_enterprise,"'",
               "   AND xrebld IN (SELECT glaald FROM anmp820_tmp WHERE sel = 'Y') ",
               "   AND xreb001 = '",g_input.yy,"'",
               "   AND xreb002 = '",g_input.mm,"'",
               "   AND xreb003 = 'NM' ",
               "   AND xreb004 = 'NP' "
   PREPARE anmp820_del_pre2 FROM g_sql
   DECLARE anmp820_del_cur2 CURSOR FOR anmp820_del_pre2
   
   FOREACH anmp820_del_cur2 INTO l_xrebcomp,l_xrebld,l_xreb005
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
      
         EXIT FOREACH
      END IF
      
      SELECT glaa001,glaa003,glaa005,glaa004,glaa008,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022 
        INTO g_glaa001,g_glaa003,g_glaa005,g_glaa004,g_glaa008,g_glaa014,g_glaa015,
             g_glaa016,g_glaa017,g_glaa018,g_glaa019,g_glaa020,g_glaa021,g_glaa022 
        FROM glaa_t
       WHERE glaaent = g_enterprise
         AND glaald = l_xrebld
      
      IF g_input.mm = 1 THEN 
         LET l_mm = 12
         LET l_yy = g_input.yy - 1
      ELSE
         LET l_mm = g_input.mm - 1
         LET l_yy = g_input.yy
      END IF
      
      IF l_mm < 10 THEN         
         LET l_date = l_yy CLIPPED,'0' CLIPPED,l_mm
      ELSE
         LET l_date = l_yy CLIPPED,l_mm 
      END IF
      
      
      #抓取上月重評價匯率
      SELECT ooao011 INTO l_ooao011_p 
        FROM ooao_t 
       WHERE ooaoent = g_enterprise
         AND ooao001 = l_ooef015
         AND ooao002 = sr.nmck100
         AND ooao003 = g_glaa001
         AND ooao004 = l_date
         
      IF cl_null(l_ooao011_p) OR l_ooao011_p = 0  THEN    
         LET l_ooao011_p = 1
      END IF
      
      #上月本位幣二重評價匯率
      IF g_glaa017 = '1' THEN 
         LET l_ooam003 = l_xreb100
      ELSE
         LET l_ooam003 = g_glaa001
      END IF
      
      SELECT ooao011 INTO l_ooao011_p_2 
        FROM ooao_t 
       WHERE ooaoent = g_enterprise
         AND ooao001 = l_ooef015
         AND ooao002 = l_ooam003
         AND ooao003 = g_glaa016
         AND ooao004 = l_date1
         
      IF cl_null(l_ooao011_p_2) THEN 
         LET l_ooao011_p_2 = 1
      END IF
      
      #上月本位幣三重評價匯率
      IF g_glaa021 = '1' THEN 
         LET l_ooam003 = l_xreb100
      ELSE
         LET l_ooam003 = g_glaa001
      END IF
      
      SELECT ooao011 INTO l_ooao011_p_3 
        FROM ooao_t 
       WHERE ooaoent = g_enterprise
         AND ooao001 = l_ooef015
         AND ooao002 = l_ooam003
         AND ooao003 = g_glaa020
         AND ooao004 = l_date1
         
      IF cl_null(l_ooao011_p_3) THEN 
         LET l_ooao011_p_3 = 1
      END IF
      
      #還原重評價金額  
      UPDATE nmck_t SET nmck114 = nmck103 * l_ooao011_p,
                        nmck124 = nmck123 * l_ooao011_p_2,
                        nmck134 = nmck133 * l_ooao011_p_3
       WHERE nmckent = g_enterprise
         AND nmckcomp = l_xrebcomp
         AND nmckdocno = l_xreb005
         
      IF SQLCA.sqlcode THEN
         #CALL cl_errmsg("upd nmbb",'','',SQLCA.SQLCODE,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd nmbb"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N'       
      END IF
      
      #還原月底重評價年度月份
      LET g_sql = "SELECT xreb001,xreb002 FROM xreb_t ",
                  " WHERE xrebent = '",g_enterprise,"'",
                  "   AND xrebld  = '",l_xrebld,"'",
                  "   AND (xreb001 < '",g_input.yy,"'",
                  "    OR (xreb001 = '",g_input.yy,"'", 
                  "   AND xreb002  < '",g_input.mm,"')",
                  "       )",
                  "   AND xreb003 = 'NM' ",
                  "   AND xreb004 = 'NR' ",
                  " ORDER BY xreb001 desc,xreb002 desc  "
      PREPARE anmp820_del_pre2_1 FROM g_sql
      DECLARE anmp820_del_cur2_1 CURSOR FOR anmp820_del_pre2_1
      
      FOREACH anmp820_del_cur2_1 INTO l_xreb001,l_xreb002
         EXIT FOREACH
      END FOREACH 
      
      UPDATE glca_t SET glca006 = l_xreb001,
                        glca007 = l_xreb002
       WHERE glcaent = g_enterprise
         AND glcald = l_xrebld
         AND glca001 = 'NP'
         
      IF SQLCA.sqlcode THEN
         #CALL cl_errmsg("upd glca",'','',SQLCA.SQLCODE,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd glca"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N'       
      END IF
   END FOREACH 
   DELETE FROM xreb_t WHERE xrebent = g_enterprise
                        AND xrebld IN (SELECT glaald FROM anmp820_tmp WHERE sel = 'Y') 
                        AND xreb001 = g_input.yy
                        AND xreb002 = g_input.mm
                        AND xreb003 = 'NM' 
                        AND xreb004 = 'NP' 
   IF SQLCA.sqlcode THEN
      #CALL cl_errmsg("del xreb",'','',SQLCA.SQLCODE,1)
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "del xreb"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = 'N'       
   END IF

   CALL cl_err_collect_show()
   IF g_success = 'Y' THEN
      CALL s_transaction_end('Y',1)
   ELSE 
      CALL s_transaction_end('N',1)
   END IF
END FUNCTION
# 銀行存款重評價還原
PRIVATE FUNCTION anmp820_nm()
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_ooao011_p     LIKE ooao_t.ooao011    #上月重評價匯率
   DEFINE l_ooao011_p_2   LIKE ooao_t.ooao011    #上月本位幣二重評價匯率
   DEFINE l_ooao011_p_3   LIKE ooao_t.ooao011    #上月本位幣三重評價匯率
   DEFINE l_ooef015       LIKE ooef_t.ooef015    #法人所使用匯率參照表
   DEFINE l_nmde001       LIKE nmde_t.nmde001    #年度
   DEFINE l_nmde002       LIKE nmde_t.nmde002    #月份
   DEFINE l_ooam003       LIKE ooam_t.ooam003    #基礎幣別
   DEFINE l_date          LIKE type_t.chr10      #年月 值如201405,前面4碼是西元年,後面2碼是月份
   #161128-00061#2----mark------begin-----------
   #DEFINE l_nmde          RECORD LIKE nmde_t.*
   #DEFINE l_nmbx          RECORD LIKE nmbx_t.* 
   #161128-00061#2----mark------end-----------   
   DEFINE l_tmp           RECORD
                          sel             LIKE type_t.chr1,
                          glaald          LIKE glaa_t.glaald,
                          glaald_desc     LIKE type_t.chr80, 
                          glaacomp        LIKE type_t.chr10, 
                          glaacomp_desc   LIKE type_t.chr80, 
                          b_yy            LIKE type_t.chr80, 
                          b_mm            LIKE type_t.chr80, 
                          b_date          LIKE nmba_t.nmbadocdt,
                          e_date          LIKE nmba_t.nmbadocdt,
                          glaa001         LIKE glaa_t.glaa001,
                          glca002         LIKE glca_t.glca002,
                          glca003         LIKE glca_t.glca003,
                          xreb023         LIKE xreb_t.xreb023 
                          END RECORD   
   DEFINE l_nmbcdocno     LIKE nmbc_t.nmbcdocno #160513-00008#4                       
                          
   CALL s_transaction_begin()
   #CALL cl_showmsg_init()
   LET g_success = 'Y'
   
   #檢查是否已拋轉總帳
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM nmde_t
    WHERE nmdeent = g_enterprise
      AND nmdeld IN (SELECT glaald FROM anmp820_tmp WHERE sel = 'Y')
      AND nmde001 = g_input.yy
      AND nmde002 = g_input.mm
      AND nmde003 = 'NM' 
      AND nmde017 IS NOT NULL
   IF l_cnt > 0 THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'anm-00231'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN 
   END IF
   
   #檢查是否有大於本月的異動記錄
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt 
     FROM nmde_t
    WHERE nmdeent = g_enterprise
      AND nmdeld IN (SELECT glaald FROM anmp820_tmp WHERE sel = 'Y')
      AND nmde003 = 'NM' 
      AND (nmde001 > g_input.yy OR (nmde001 = g_input.yy AND nmde002 > g_input.mm))
   IF l_cnt > 0 THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'anm-00233'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN 
   END IF
   
   CALL cl_err_collect_init()
   
   LET g_sql = "SELECT * FROM anmp820_tmp ",
               " WHERE sel = 'Y' "
   PREPARE anmp820_tmp_pre FROM g_sql 
   DECLARE anmp820_tmp_cur CURSOR FOR anmp820_tmp_pre
   FOREACH anmp820_tmp_cur INTO l_tmp.*   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
      
         EXIT FOREACH
      END IF
      
      #還原月底重評價年度月份
      LET g_sql = "SELECT nmde001,nmde002 FROM nmde_t ",
                  " WHERE nmdeent = '",g_enterprise,"'",
                  "   AND nmdeld  = '",l_tmp.glaald,"'",
                  "   AND (nmde001 < '",g_input.yy,"'",
                  "    OR (nmde001 = '",g_input.yy,"'", 
                  "   AND nmde002  < '",g_input.mm,"')",
                  "       )",
                  "   AND nmde003 = 'NM' ",
                  " ORDER BY nmde001 desc,nmde002 desc  "
      PREPARE anmp820_tmp_pre_1 FROM g_sql
      DECLARE anmp820_tmp_cur_1 CURSOR FOR anmp820_tmp_pre_1
      
      FOREACH anmp820_tmp_cur_1 INTO l_nmde001,l_nmde002
         EXIT FOREACH
      END FOREACH 
   
      UPDATE glca_t SET glca006 = l_nmde001,
                        glca007 = l_nmde002
       WHERE glcaent = g_enterprise
         AND glcald IN (SELECT glaald FROM anmp820_tmp WHERE sel = 'Y')
         AND glca001 = 'NM'
         
      IF SQLCA.sqlcode THEN
         #CALL cl_errmsg("upd glca",'','',SQLCA.SQLCODE,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd glca"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N'       
      END IF
   END FOREACH 
   
   #還原
   DELETE FROM nmde_t WHERE nmdeent = g_enterprise
                        AND nmdeld IN (SELECT glaald FROM anmp820_tmp WHERE sel = 'Y') 
                        AND nmde001 = g_input.yy
                        AND nmde002 = g_input.mm
                        AND nmde003 = 'NM' 
   IF SQLCA.sqlcode THEN
      #CALL cl_errmsg("del xreb",'','',SQLCA.SQLCODE,1)
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "del nmde"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = 'N'       
   END IF
   
   #160513-00008#4--add--str--
   #同步删除nmbc_t
   LET l_nmbcdocno="NM",g_input.yy USING "&&&&",g_input.mm USING "&&","%"
   DELETE FROM nmbc_t WHERE nmbcent = g_enterprise
                        AND nmbccomp IN (SELECT glaacomp FROM anmp820_tmp WHERE sel = 'Y') 
                        AND nmbcdocno LIKE l_nmbcdocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "del nmbc_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = 'N'       
   END IF
   #160513-00008#4--add--end
   
   CALL cl_err_collect_show()
   IF g_success = 'Y' THEN
      CALL s_transaction_end('Y',1)
   ELSE 
      CALL s_transaction_end('N',1)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION anmp820_get_ooef001_wc(p_wc)
   DEFINE p_wc       STRING
   DEFINE r_wc       STRING
   DEFINE tok        base.StringTokenizer
   DEFINE l_str      STRING

   LET tok = base.StringTokenizer.create(p_wc,",")
   WHILE tok.hasMoreTokens()
      IF cl_null(l_str) THEN
         LET l_str = tok.nextToken()
      ELSE
         LET l_str = l_str,"','",tok.nextToken()
      END IF
   END WHILE
   LET r_wc = "('",l_str,"')"

   RETURN r_wc
END FUNCTION

#end add-point
 
{</section>}
 
