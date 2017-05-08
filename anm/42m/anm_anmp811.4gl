#該程式未解開Section, 採用最新樣板產出!
{<section id="anmp811.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0009(2014-08-15 15:43:24), PR版次:0009(2017-01-04 13:43:09)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000089
#+ Filename...: anmp811
#+ Description: 票據自動調匯作業
#+ Creator....: 02114(2014-08-11 11:21:52)
#+ Modifier...: 02114 -SD/PR- 01531
 
{</section>}
 
{<section id="anmp811.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#150817-00025#1   2015/08/18 By Reanna   Bug調整
#150813-00015#37  2016/01/19 By 02599    增加账务中心、年度、期别栏位检查，年度+期别不可小于关帐日期年度+期别
#160628-00010#2   2016/07/04 By 01531    新增isbb本位币二、本位币三相关栏位；增加处理isbb114/isbb124/isbb134
#160728-00023#1   2016/07/28 By 01531    anmt440审核成功后，执行anmp811报错：ins xreb 违反唯一的限制
#160708-00016#2   2016/08/01 By 02599    修正插入xreb报 违反唯一的限制错误
#160125-00005#8   2016/08/08 By 02599    帳套增加人員權限條件過濾
#161021-00050#1   2016/10/24 By 08729    處理組織開窗
#161128-00061#2   2016/11/29 by 02481    标准程式定义采用宣告模式,弃用.*写法
#161026-00010#2   2017/01/04 By 01531    改狀態條件抓取已复核狀態的资料
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
        ooef001      LIKE type_t.chr10, 
        ooef001_desc LIKE type_t.chr80, 
        yy           LIKE type_t.chr80, 
        mm           LIKE type_t.chr80, 
        source       LIKE type_t.chr1,
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
     ym              LIKE type_t.chr10,
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
 
{<section id="anmp811.main" >}
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
      OPEN WINDOW w_anmp811 WITH FORM cl_ap_formpath("anm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL anmp811_init()   
 
      #進入選單 Menu (="N")
      CALL anmp811_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_anmp811
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   DROP TABLE anmp811_tmp;
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="anmp811.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION anmp811_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   CALL anmp811_set_combo_scc("yy","43")
   CALL anmp811_set_combo_scc("mm","39")
   CALL cl_set_combo_scc("glca002","8317")
   CALL cl_set_combo_scc("glca003","40")     #150817-00025#1 mark
   CALL cl_set_combo_scc("glca003","8724")   #150817-00025#1
   CALL s_fin_create_account_center_tmp()    #160125-00005#8
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="anmp811.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION anmp811_ui_dialog()
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
   DEFINE l_glaa003       LIKE glaa_t.glaa003
   DEFINE l_glaa013       LIKE glaa_t.glaa013
   DEFINE l_yy            LIKE type_t.num5
   DEFINE l_mm            LIKE type_t.num5
   DEFINE l_clo_date      LIKE type_t.dat        #150813-00015#37 add
   DEFINE l_success       LIKE type_t.num5       #150813-00015#37 add
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
         CALL anmp811_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT BY NAME g_input.ooef001,g_input.ooef001_desc,
                       g_input.yy,g_input.mm,
                       g_input.source
               ATTRIBUTE(WITHOUT DEFAULTS)
               
            BEFORE INPUT 
               CALL s_fin_get_account_center('',g_user,'3',g_today) RETURNING g_sub_success,g_input.ooef001,g_errno
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_input.ooef001
               CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_input.ooef001_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_input.ooef001_desc
               LET g_input.yy = YEAR(g_today)
               LET g_input.mm = MONTH(g_today)
               #CALL cl_get_para(g_enterprise,g_nmbs_m.nmbscomp,'S-FIN-4004') RETURNING g_para_data
               
               #獲取當前年度期別的第一天和最後一天
               CALL s_get_accdate(g_glaa003,'',g_input.yy,g_input.mm)
               RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e 
               LET g_input.source = '1'
               DISPLAY g_input.source TO source
            
            AFTER FIELD ooef001
               #150813-00015#37--add--str--
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
               #150813-00015#37--add--end
            #2015/01/23---add---by---qiull(s)
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_input.ooef001
               CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_input.ooef001_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_input.ooef001_desc
            
            #150813-00015#37--add--str--
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
            #150813-00015#37--add--end
            
            #2015/04/14--by--02599--add--str--
            ON CHANGE source
               IF NOT cl_null(g_input.source) THEN
                  CALL anmp811_query()
               END IF
            #2015/04/14--by--02599--add--end
            
            ON ACTION controlp INFIELD ooef001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_input.ooef001
               #LET g_qryparam.where = " ooef201 = 'Y'"   #161021-00050#1 mark
               #CALL q_ooef001()                          #161021-00050#1 mark
               LET g_qryparam.where = " ooefstus = 'Y'"   #161021-00050#1 add
               CALL q_ooef001_46()                        #161021-00050#1 add
               LET g_input.ooef001 = g_qryparam.return1
               DISPLAY BY NAME g_input.ooef001
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_input.ooef001
               CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_input.ooef001_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_input.ooef001_desc
               NEXT FIELD ooef001
            #2015/01/23---add---by---qiull(e)  
               
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
               CALL anmp811_fetch()              
               
            ON CHANGE sel
               #已拋總帳的不可勾選執行重評價
               IF NOT cl_null(g_detail_d[l_ac].xreb023) THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_detail_d[l_ac].glaald
                  LET g_errparam.code   = 'anm-00221'
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  
                  LET g_detail_d[l_ac].sel = 'N'
                  EXIT DIALOG
               END IF
               
               #設置1:無重評價處理。或沒有設置的不可勾選執行重評價
               IF g_detail_d[l_ac].glca002 = '1' OR cl_null(g_detail_d[l_ac].glca002) THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_detail_d[l_ac].glaald
                  LET g_errparam.code   = 'anm-00227'
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  
                  LET g_detail_d[l_ac].sel = 'N'
                  EXIT DIALOG
               END IF
               
               #單身年度月份與單頭不一樣的不可勾選執行重評價
               IF g_detail_d[l_ac].b_yy <> g_input.yy OR g_detail_d[l_ac].b_mm <> g_input.mm THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_detail_d[l_ac].glaald
                  LET g_errparam.code   = 'anm-00229'
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  
                  LET g_detail_d[l_ac].sel = 'N'
                  EXIT DIALOG
               END IF
               
               #2015/04/14--by--02599--add--str--
               #当选取的帐套的关账年度+期别大于要做重评价的年度+期别，提示不可执行重评价
               SELECT glaa003,glaa013 INTO l_glaa003,l_glaa013 FROM glaa_t 
               WHERE glaaent = g_enterprise AND glaald = g_detail_d[l_ac].glaald
               #获取该帐套的关账年度+期别
               SELECT glav002,glav006 INTO l_yy,l_mm FROM glav_t
               WHERE glavent = g_enterprise AND glav001 = l_glaa003 AND glav004 = l_glaa013
               IF g_detail_d[l_ac].b_yy < l_yy OR 
                  (g_detail_d[l_ac].b_yy = l_yy AND g_detail_d[l_ac].b_mm < l_mm) THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_detail_d[l_ac].glaald
                  LET g_errparam.code   = 'agl-00163'
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  
                  LET g_detail_d[l_ac].sel = 'N'
                  EXIT DIALOG
               END IF
               #2015/04/14--by--02599--add--end
               
               UPDATE anmp811_tmp 
                  SET sel = g_detail_d[l_ac].sel 
                WHERE glaald = g_detail_d[l_ac].glaald 
                
               SELECT sel INTO l_sel 
                 FROM anmp811_tmp
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
               #已拋總帳的不可勾選執行重評價
               IF NOT cl_null(g_detail_d[li_idx].xreb023) THEN 
                  LET g_detail_d[li_idx].sel = "N"
               END IF
               #設置1:無重評價處理。或沒有設置的不可勾選執行重評價
               IF g_detail_d[li_idx].glca002 = '1' OR cl_null(g_detail_d[li_idx].glca002) THEN 
                  LET g_detail_d[li_idx].sel = 'N'
               END IF
               #單身年度月份與單頭不一樣的不可勾選執行重評價
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
                  #已拋總帳的不可勾選執行重評價
                  IF NOT cl_null(g_detail_d[li_idx].xreb023) THEN 
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_detail_d[l_ac].glaald
                     LET g_errparam.code   = 'anm-00221'
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                     LET g_detail_d[li_idx].sel = 'N'
                     EXIT DIALOG
                  END IF
                  
                  #設置1:無重評價處理。或沒有設置的不可勾選執行重評價
                  IF g_detail_d[li_idx].glca002 = '1' OR cl_null(g_detail_d[li_idx].glca002) THEN 
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_detail_d[li_idx].glaald
                     LET g_errparam.code   = 'anm-00227'
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                     LET g_detail_d[li_idx].sel = 'N'
                     EXIT DIALOG
                  END IF
                  
                  #單身年度月份與單頭不一樣的不可勾選執行重評價
                  IF g_detail_d[li_idx].b_yy <> g_input.yy OR g_detail_d[li_idx].b_mm <> g_input.mm THEN 
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_detail_d[li_idx].glaald
                     LET g_errparam.code   = 'anm-00229'
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
            CALL anmp811_filter()
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
            CALL anmp811_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL anmp811_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            SELECT COUNT(*) INTO l_n
              FROM anmp811_tmp
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
               CALL anmp811_nr()
            ELSE                             
               CALL anmp811_np()
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
 
{<section id="anmp811.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION anmp811_query()
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
   CALL anmp811_b_fill()
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
 
{<section id="anmp811.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION anmp811_b_fill()
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
   CALL anmp811_create_tmp() RETURNING l_success
   DELETE FROM anmp811_tmp
   
   IF g_input.source = '1' THEN 
      LET g_sql = "SELECT DISTINCT 'N',glaald,'',glaacomp,'','','','','',glaa001,'','',xreb023 FROM glaa_t ",
                  "  LEFT OUTER JOIN xreb_t ON xrebent = glaaent ",
                  "   AND xrebld = glaald ",
                  "   AND xreb001 = '",g_input.yy,"'",
                  "   AND xreb002 = '",g_input.mm,"'",
                  "   AND xreb003 = 'NM' ",
                  "   AND xreb004 = 'NR' ",
                  " WHERE glaaent = ? "
   ELSE
      LET g_sql = "SELECT DISTINCT 'N',glaald,'',glaacomp,'','','','','',glaa001,'','',xreb023 FROM glaa_t ",
                  "  LEFT OUTER JOIN xreb_t ON xrebent = glaaent ",
                  "   AND xrebld = glaald ",
                  "   AND xreb001 = '",g_input.yy,"'",
                  "   AND xreb002 = '",g_input.mm,"'",
                  "   AND xreb003 = 'NM' ",
                  "   AND xreb004 = 'NP' ",             
                  " WHERE glaaent = ? " 
   END IF                                      
   
#160125-00005#8--add--str--
   #取得帳務組織下所屬成員
   CALL s_fin_account_center_sons_query('3',g_input.ooef001,g_today,'1')
   #取得帳務組織下所屬成員之帳別
   CALL s_fin_account_center_comp_str() RETURNING ls_wc
   #將取回的字串轉換為SQL條件
   CALL anmp811_get_ooef001_wc(ls_wc) RETURNING ls_wc 
   LET ls_wc=ls_wc.substring(3,ls_wc.getLength()-2)
   #账套范围
   CALL s_axrt300_get_site(g_user,ls_wc,'2')  RETURNING l_ld_str 
   IF NOT cl_null(l_ld_str) THEN   
      LET g_sql = g_sql, " AND ",l_ld_str
   END IF
#160125-00005#8--add--end
#160125-00005#8--mark--str-- 
#   #2015/01/23---add---by---qiull(S)
#   CALL s_fin_create_account_center_tmp()
#   #取得帳務組織下所屬成員
#   CALL s_fin_account_center_sons_query('3',g_input.ooef001,g_today,'1')
#   #取得帳務組織下所屬成員之帳別
#   CALL s_fin_account_center_comp_str() RETURNING ls_wc
#   #將取回的字串轉換為SQL條件
#   CALL anmp811_get_ooef001_wc(ls_wc) RETURNING ls_wc  
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
#   #2015/01/23---add---by---qiull(E)  
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
#   END IF                       #2015/01/23---add---by---qiull    
#160125-00005#8--mark--end
   #end add-point
 
   PREPARE anmp811_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR anmp811_sel
   
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
      CALL anmp811_glaald_desc()
      #会计周期参照表
      SELECT glaa003 INTO l_glaa003
        FROM glaa_t
       WHERE glaaent = g_enterprise
         AND glaald = g_detail_d[l_ac].glaald
#2015/04/14--by--02599--mod--str--      
#      CALL cl_get_para(g_enterprise,g_detail_d[l_ac].glaacomp,'S-FIN-4007') RETURNING l_ooab002
#      
#      LET l_yy = YEAR(l_ooab002)
#      LET l_mm = MONTH(l_ooab002)
#      
#      IF l_mm = '12' THEN 
#         LET g_detail_d[l_ac].b_yy = l_yy + 1
#         LET g_detail_d[l_ac].b_mm = 1
#      ELSE
#         LET g_detail_d[l_ac].b_yy = l_yy
#         LET g_detail_d[l_ac].b_mm = l_mm + 1
#      END IF
#单身年度、期别等于单头年度、期别，同样起始截止日期抓取单头年度+期别的起始截止日期
      LET g_detail_d[l_ac].b_yy = g_input.yy
      LET g_detail_d[l_ac].b_mm = g_input.mm
#2015/04/14--by--02599--mod--end

      #獲取當前年度期別的第一天和最後一天
      CALL s_get_accdate(l_glaa003,'',g_detail_d[l_ac].b_yy,g_detail_d[l_ac].b_mm)
      RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e    

      LET g_detail_d[l_ac].b_date = l_pdate_s
      LET g_detail_d[l_ac].e_date = l_pdate_e
      LET l_yy = ''
      LET l_mm = ''
      IF g_input.source = '1' THEN 
         SELECT glca002,glca003,glca006,glca007
           INTO g_detail_d[l_ac].glca002,g_detail_d[l_ac].glca003,l_yy,l_mm
           FROM glca_t
          WHERE glcaent = g_enterprise
            AND glcald = g_detail_d[l_ac].glaald
            AND glca001 = 'NR'
      ELSE
         SELECT glca002,glca003,glca006,glca007
          INTO g_detail_d[l_ac].glca002,g_detail_d[l_ac].glca003,l_yy,l_mm 
           FROM glca_t
          WHERE glcaent = g_enterprise
            AND glcald = g_detail_d[l_ac].glaald
            AND glca001 = 'NP'
      END IF
      IF NOT cl_null(l_yy) AND NOT cl_null(l_mm) THEN    
         LET g_detail_d[l_ac].ym=l_yy,"/",l_mm USING "<<"
      ELSE
         LET g_detail_d[l_ac].ym=''
      END IF
      INSERT INTO anmp811_tmp VALUES(g_detail_d[l_ac].*)
      #end add-point
      
      CALL anmp811_detail_show()      
 
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
   FREE anmp811_sel
   
   LET l_ac = 1
   CALL anmp811_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="anmp811.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION anmp811_fetch()
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
 
{<section id="anmp811.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION anmp811_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="anmp811.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION anmp811_filter()
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
   
   CALL anmp811_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="anmp811.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION anmp811_filter_parser(ps_field)
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
 
{<section id="anmp811.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION anmp811_filter_show(ps_field,ps_object)
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
   LET ls_condition = anmp811_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="anmp811.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"
# 年度,月份
PRIVATE FUNCTION anmp811_set_combo_scc(p_field,p_scc)
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
PRIVATE FUNCTION anmp811_glaald_desc()
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
PRIVATE FUNCTION anmp811_get_date()
   
END FUNCTION
# 創建臨時表
PRIVATE FUNCTION anmp811_create_tmp()
   DEFINE r_success       LIKE type_t.num5
   
   WHENEVER ERROR CONTINUE
   LET r_success = FALSE
   
   DROP TABLE anmp811_tmp;
   CREATE TEMP TABLE anmp811_tmp(
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
     ym               VARCHAR(10),
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
# 應收票據月底重評價
PRIVATE FUNCTION anmp811_nr()
   DEFINE l_cnt           LIKE type_t.num5
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
   DEFINE l_amt1          LIKE nmbb_t.nmbb008    #沖賬原幣
   DEFINE l_amt2          LIKE nmbb_t.nmbb008    #沖賬本幣
   DEFINE l_amt3          LIKE nmbb_t.nmbb008    #本位幣二沖賬金額
   DEFINE l_amt4          LIKE nmbb_t.nmbb008    #本位幣三沖賬金額
   DEFINE l_ooao011       LIKE ooao_t.ooao011    #重評價匯率
   DEFINE l_ooao011_2     LIKE ooao_t.ooao011    #本位幣二重評價匯率
   DEFINE l_ooao011_3     LIKE ooao_t.ooao011    #本位幣三重評價匯率
   DEFINE l_ooef015       LIKE ooef_t.ooef015    #法人所使用匯率參照表
   DEFINE l_xreb115       LIKE xreb_t.xreb115    #上期匯差金額
   DEFINE l_xreb125       LIKE xreb_t.xreb125    #本位幣二上期匯差金額
   DEFINE l_xreb135       LIKE xreb_t.xreb135    #本位幣三上期匯差金額
   DEFINE l_ooam003       LIKE ooam_t.ooam003    #基礎幣別
   DEFINE l_date          LIKE type_t.chr10      #年月 值如201405,前面4碼是西元年,後面2碼是月份
   DEFINE l_xrebcomp      LIKE xreb_t.xrebcomp   #法人
   DEFINE l_xrebld        LIKE xreb_t.xrebld     #帳別
   DEFINE l_xreb005       LIKE xreb_t.xreb005    #單據號碼
   DEFINE l_xreb006       LIKE xreb_t.xreb006    #项次 #160628-00010#2
   #161128-00061#2----modify------begin-----------
   #DEFINE l_xreb          RECORD LIKE xreb_t.*
   DEFINE l_xreb RECORD  #重評價月結檔
       xrebent LIKE xreb_t.xrebent, #企業編號
       xrebcomp LIKE xreb_t.xrebcomp, #法人
       xrebsite LIKE xreb_t.xrebsite, #帳務中心
       xrebld LIKE xreb_t.xrebld, #帳套
       xreb001 LIKE xreb_t.xreb001, #年度
       xreb002 LIKE xreb_t.xreb002, #期別
       xreb003 LIKE xreb_t.xreb003, #來源模組
       xreb004 LIKE xreb_t.xreb004, #帳款單性質
       xreb005 LIKE xreb_t.xreb005, #單據號碼
       xreb006 LIKE xreb_t.xreb006, #項次
       xreb007 LIKE xreb_t.xreb007, #分期帳款序
       xreb008 LIKE xreb_t.xreb008, #立帳日期
       xreb009 LIKE xreb_t.xreb009, #帳款對象
       xreb010 LIKE xreb_t.xreb010, #收款對象
       xreb011 LIKE xreb_t.xreb011, #部門
       xreb012 LIKE xreb_t.xreb012, #責任中心
       xreb013 LIKE xreb_t.xreb013, #區域
       xreb014 LIKE xreb_t.xreb014, #客群
       xreb015 LIKE xreb_t.xreb015, #產品類別
       xreb016 LIKE xreb_t.xreb016, #人員
       xreb017 LIKE xreb_t.xreb017, #專案編號
       xreb018 LIKE xreb_t.xreb018, #WBS編號
       xreb019 LIKE xreb_t.xreb019, #應收科目
       xreborga LIKE xreb_t.xreborga, #來源組織
       xreb020 LIKE xreb_t.xreb020, #經營方式
       xreb021 LIKE xreb_t.xreb021, #渠道
       xreb022 LIKE xreb_t.xreb022, #品牌
       xreb023 LIKE xreb_t.xreb023, #自由核算項一
       xreb024 LIKE xreb_t.xreb024, #自由核算項二
       xreb025 LIKE xreb_t.xreb025, #自由核算項三
       xreb026 LIKE xreb_t.xreb026, #自由核算項四
       xreb027 LIKE xreb_t.xreb027, #自由核算項五
       xreb028 LIKE xreb_t.xreb028, #自由核算項六
       xreb029 LIKE xreb_t.xreb029, #自由核算項七
       xreb030 LIKE xreb_t.xreb030, #自由核算項八
       xreb031 LIKE xreb_t.xreb031, #自由核算項九
       xreb032 LIKE xreb_t.xreb032, #自由核算項十
       xreb033 LIKE xreb_t.xreb033, #摘要
       xreb034 LIKE xreb_t.xreb034, #重評價會計科目
       xreb100 LIKE xreb_t.xreb100, #幣別
       xreb101 LIKE xreb_t.xreb101, #重評價匯率
       xreb102 LIKE xreb_t.xreb102, #上月重評匯率
       xreb103 LIKE xreb_t.xreb103, #本期原幣未沖金額
       xreb113 LIKE xreb_t.xreb113, #本期本幣未沖金額
       xreb114 LIKE xreb_t.xreb114, #本期重評價後本幣金額
       xreb115 LIKE xreb_t.xreb115, #本期匯差金額
       xreb116 LIKE xreb_t.xreb116, #本幣累計匯差
       xreb121 LIKE xreb_t.xreb121, #本位幣二重評價匯率
       xreb122 LIKE xreb_t.xreb122, #本位幣二上月重估匯率
       xreb123 LIKE xreb_t.xreb123, #本期本位幣二未沖金額
       xreb124 LIKE xreb_t.xreb124, #本期本位幣二重評價後金額
       xreb125 LIKE xreb_t.xreb125, #本期本位幣二匯差金額
       xreb126 LIKE xreb_t.xreb126, #本位幣二累計匯差
       xreb131 LIKE xreb_t.xreb131, #本位幣三重評價匯率
       xreb132 LIKE xreb_t.xreb132, #本位幣三上月重估匯率
       xreb133 LIKE xreb_t.xreb133, #本期本位幣三未沖金額
       xreb134 LIKE xreb_t.xreb134, #本期本位幣三重評價後金額
       xreb135 LIKE xreb_t.xreb135, #本期本位幣三匯差金額
       xreb136 LIKE xreb_t.xreb136  #本位幣三累計匯差
       END RECORD
   #161128-00061#2----modify------end-----------
   DEFINE sr              RECORD
                          nmbadocno          LIKE nmba_t.nmbadocno,
                          nmbadocdt          LIKE nmba_t.nmbadocno,
                          nmbbseq            LIKE nmbb_t.nmbbseq, #160628-00010#2
                          nmbb004            LIKE nmbb_t.nmbb004,
                          nmbb005            LIKE nmbb_t.nmbb005,
                          nmbb006            LIKE nmbb_t.nmbb006,
                          nmbb007            LIKE nmbb_t.nmbb007,
                          nmbb008            LIKE nmbb_t.nmbb008,
                          nmbb009            LIKE nmbb_t.nmbb009,
                          amt1               LIKE nmbb_t.nmbb008,
                          amt2               LIKE nmbb_t.nmbb009,
                          amt3               LIKE nmbb_t.nmbb013,
                          amt4               LIKE nmbb_t.nmbb014,
                          nmbb042            LIKE nmbb_t.nmbb042,
                          nmba004            LIKE nmba_t.nmba004,
                          nmbblegl           LIKE nmbb_t.nmbblegl,
                          nmbt018            LIKE nmbt_t.nmbt018,
                          nmbt019            LIKE nmbt_t.nmbt019,
                          nmbt020            LIKE nmbt_t.nmbt020,
                          nmbt023            LIKE nmbt_t.nmbt023,
                          nmbt024            LIKE nmbt_t.nmbt024,
                          nmbt025            LIKE nmbt_t.nmbt025,
                          nmbt026            LIKE nmbt_t.nmbt026,
                          nmbt027            LIKE nmbt_t.nmbt027,
                          nmbt028            LIKE nmbt_t.nmbt028,
                          nmba005            LIKE nmba_t.nmba005,
                          #nmbv001            LIKE nmbv_t.nmbv001,      #2015/01/22 mark by qiull
                          nmbborga           LIKE nmbb_t.nmbborga,
                          #2015/01/21 add by qiull(s)
                          nmbt029            LIKE nmbt_t.nmbt029,
                          nmbt031            LIKE nmbt_t.nmbt031,
                          nmbt032            LIKE nmbt_t.nmbt032,
                          nmbt033            LIKE nmbt_t.nmbt033,
                          nmbt034            LIKE nmbt_t.nmbt034,
                          nmbt035            LIKE nmbt_t.nmbt035,
                          nmbt036            LIKE nmbt_t.nmbt036,
                          nmbt037            LIKE nmbt_t.nmbt037,
                          nmbt038            LIKE nmbt_t.nmbt038,
                          nmbt039            LIKE nmbt_t.nmbt039,
                          nmbt040            LIKE nmbt_t.nmbt040,
                          nmbt041            LIKE nmbt_t.nmbt041,
                          nmbt042            LIKE nmbt_t.nmbt042,
                          nmbt043            LIKE nmbt_t.nmbt043
                          #2015/01/21 add by qiull(e)
                          END RECORD
                          
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
                          ym              LIKE type_t.chr10,
                          xreb023         LIKE xreb_t.xreb023 
                          END RECORD
   DEFINE l_ld            LIKE glaa_t.glaald
   DEFINE l_glaacomp      LIKE glaa_t.glaacomp  #160708-00016#2 add
                                              
#   CALL s_transaction_begin()  #160708-00016#2 mark
   #CALL cl_showmsg_init()
   LET g_success = 'Y'            
   
   #檢查是否已拋轉總帳
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM xreg_t,xreh_t
    WHERE xregent = xrehent
      AND xregdocno = xrehdocno
      AND xregent = g_enterprise
      AND xregld IN (SELECT glaald FROM anmp811_tmp WHERE sel = 'Y')
      AND xreg001 = g_input.yy
      AND xreg002 = g_input.mm
      AND xreg003 = 'NM'
      AND xreh004 = 'NR'
      AND xreg005 IS NOT NULL
   #SELECT COUNT(*) INTO l_cnt
   #  FROM xreb_t
   # WHERE xrebent = g_enterprise
   #   AND xrebld IN (SELECT glaald FROM anmp811_tmp WHERE sel = 'Y')
   #   AND xreb001 = g_input.yy
   #   AND xreb002 = g_input.mm
   #   AND xreb003 = 'NM' 
   #   AND xreb004 = 'NR' 
   #   AND xreb023 IS NOT NULL
   IF l_cnt > 0 THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'anm-00221'
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
      AND xrebld IN (SELECT glaald FROM anmp811_tmp WHERE sel = 'Y')
      #AND xreb003 = 'NR'                                                 #2015/01/16 mark by qiull
      AND xreb003 = 'NM' AND xreb004 = 'NR'                               #2015/01/16 add by qiull
      AND (xreb001 > g_input.yy OR (xreb001 = g_input.yy AND xreb002 > g_input.mm))
   IF l_cnt > 0 THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'anm-00218'
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
      AND nmbaent = g_enterprise #160708-00016#2 add
      AND nmbb004 != g_glaa001
      AND (nmbb042 IN('1','2') OR nmbb069 = 'Y')
      #AND (nmbastus = 'Y' OR nmbastus = 'V') #161026-00010#2 mark
      AND nmbastus = 'V'                      #161026-00010#2 add 
      AND nmbadocdt <= l_pdate_e 
      AND nmbadocno IN (SELECT xrce003 FROM xrda_t,xrce_t 
                         WHERE xrdaent = xrceent
                           AND xrdald = xrceld
                           AND xrdadocno = xrcedocno
                           AND xrdaent = g_enterprise #160708-00016#2 add
                           AND xrdald IN (SELECT glaald FROM anmp811_tmp WHERE sel = 'Y')
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
   
   #2015/04/14--by--02599--add--str--
   #判斷是否已存在重評資料，如果存在詢問是否還原重評
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM xreb_t
    WHERE xrebent = g_enterprise 
      AND xrebld IN (SELECT glaald FROM anmp811_tmp WHERE sel = 'Y')
      AND xreb001 = g_input.yy AND xreb002 = g_input.mm
      AND xreb003 = 'NM' AND xreb004 = 'NR'
   IF l_cnt >0 THEN
      IF NOT cl_ask_confirm("anm-00343") THEN
         RETURN
      END IF
   END IF
   #2015/04/14--by--02599--add--end 
   
   CALL s_transaction_begin()  #160708-00016#2
   CALL cl_err_collect_init()
   #還原
   #LET g_sql = "SELECT xrebcomp,xrebld,xreb005 FROM xreb_t ",       #160628-00010#2
   LET g_sql = "SELECT xrebcomp,xrebld,xreb005,xreb006 FROM xreb_t ",#160628-00010#2 add xreb006
               " WHERE xrebent = '",g_enterprise,"'",
               "   AND xrebld IN (SELECT glaald FROM anmp811_tmp WHERE sel = 'Y') ",
               "   AND xreb001 = '",g_input.yy,"'",
               "   AND xreb002 = '",g_input.mm,"'",
               "   AND xreb003 = 'NM' ",
               "   AND xreb004 = 'NR' "
   PREPARE anmp811_del_pre FROM g_sql
   DECLARE anmp811_del_cur CURSOR FOR anmp811_del_pre
   
   LET l_ld = ''
   FOREACH anmp811_del_cur INTO l_xrebcomp,l_xrebld,l_xreb005,l_xreb006 #160628-00010#2 add l_xreb006
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
      
         EXIT FOREACH
      END IF
      
      #還原重評價金額 
      UPDATE nmbb_t SET nmbb066 = 0,
                        nmbb067 = 0,
                        nmbb068 = 0
       WHERE nmbbent = g_enterprise
         AND nmbbcomp = l_xrebcomp
         AND nmbbdocno = l_xreb005
         AND nmbbseq = l_xreb006 #160628-00010#2 add
         
      IF SQLCA.sqlcode THEN
         #CALL cl_errmsg("upd nmbb",'','',SQLCA.SQLCODE,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd nmbb"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N'       
      END IF

         #160628-00010#2 add s---
         #還原重評后金額 
         UPDATE isbb_t SET isbb114 = 0,
                           isbb124 = 0,
                           isbb134 = 0
          WHERE isbbbent = g_enterprise
            AND isbbbcomp = l_xrebcomp
            AND isbbb002 = l_xreb005
            AND isbb003 = l_xreb006 #160628-00010#2 add
            
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "upd isbb"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N'       
         END IF        
         #160628-00010#2 add s---

      IF cl_null(l_ld) OR (l_ld <> l_xrebld) THEN
         #還原月底重評價年度月份
         UPDATE glca_t SET glca006 = '',
                           glca007 = ''
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
         LET l_ld = l_xrebld
      END IF
   END FOREACH 
   DELETE FROM xreb_t WHERE xrebent = g_enterprise
                        AND xrebld IN (SELECT glaald FROM anmp811_tmp WHERE sel = 'Y') 
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
   
   DELETE FROM xreg_t WHERE xregent = g_enterprise
                        AND xregdocno IN(SELECT DISTINCT xregdocno FROM xreg_t,xreh_t
                                        WHERE xregent = xrehent
                                          AND xregdocno = xrehdocno
                                          AND xreh004 = 'NR'
                                          AND xregent = g_enterprise
                                          AND xregld IN(SELECT glaald FROM anmp811_tmp WHERE sel = 'Y') 
                                          AND xreg001 = g_input.yy
                                          AND xreg002 = g_input.mm
                                          AND xreg003 = 'NM')
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "del xreg"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = 'N'       
   END IF
   
   DELETE FROM xreh_t WHERE xrehent = g_enterprise
                        AND xrehdocno IN(SELECT DISTINCT xregdocno FROM xreg_t,xreh_t
                                        WHERE xregent = xrehent
                                          AND xregdocno = xrehdocno
                                          AND xreh004 = 'NR'
                                          AND xregent = g_enterprise
                                          AND xregld IN(SELECT glaald FROM anmp811_tmp WHERE sel = 'Y') 
                                          AND xreg001 = g_input.yy
                                          AND xreg002 = g_input.mm
                                          AND xreg003 = 'NM')
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "del xreh"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = 'N'       
   END IF

   LET g_sql = "SELECT * FROM anmp811_tmp ",
               " WHERE sel = 'Y' "
   PREPARE anmp811_tmp_pre FROM g_sql 
   DECLARE anmp811_tmp_cur CURSOR FOR anmp811_tmp_pre
   FOREACH anmp811_tmp_cur INTO l_tmp.*   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
      
         EXIT FOREACH
      END IF
      
      SELECT glaa001,glaa003,glaa005,glaa004,glaa008,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022 
            ,glaacomp  #160708-00016#2 add
        INTO g_glaa001,g_glaa003,g_glaa005,g_glaa004,g_glaa008,g_glaa014,g_glaa015,
             g_glaa016,g_glaa017,g_glaa018,g_glaa019,g_glaa020,g_glaa021,g_glaa022 
            ,l_glaacomp  #160708-00016#2 add
        FROM glaa_t
       WHERE glaaent = g_enterprise
         AND glaald = l_tmp.glaald
         
      #獲取當前年度期別的第一天和最後一天
      CALL s_get_accdate(g_glaa003,'',g_input.yy,g_input.mm)
      RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e    

      #LET g_sql = "SELECT nmbadocno,nmbadocdt,nmbb004,nmbb005,nmbb006,nmbb007,",         #160628-00010#2 mark
      LET g_sql = "SELECT nmbadocno,nmbadocdt,nmbbseq,nmbb004,nmbb005,nmbb006,nmbb007,",  #160628-00010#2 add nmbbseq
                  #"       nmbb008,nmbb009,nmbb006-nmbb008,nmbb007-nmbb009,",          #2015/01/21 mark by qiull
                  "       nmbb008,nmbb009,nmbb006,nmbb007,",                           #2015/01/21 add by qiull
                  #"       nmbb013-nmbb014,nmbb017-nmbb018,nmbb042,nmba004,",          #2015/01/21 mark by qiull
                  "       nmbb013,nmbb017,nmbb042,nmba004,",                           #2015/01/21 add by qiull
                  "       nmbblegl,nmbt018,nmbt019,nmbt020,nmbt023,nmbt024,",
                  #"       nmbt025,nmbt026,nmbt027,nmbt028,nmba005,nmbv001,nmbborga",          #2015/01/22 mark by qiull
                  "       nmbt025,nmbt026,nmbt027,nmbt028,nmba005,nmbborga",                   #2015/01/22 add by qiull
                  "       ,nmbt029,nmbt031,nmbt032,nmbt033,nmbt034,nmbt035,nmbt036,nmbt037,",  #2015/01/21 add by qiull
                  "       nmbt038,nmbt039,nmbt040,nmbt041,nmbt042,nmbt043 ",                   #2015/01/21 add by qiull
                  #"  FROM nmba_t,nmbb_t,nmbt_t,nmbv_t ",                              #2015/01/21 mark by qiull
                  "  FROM nmba_t,nmbb_t,nmbt_t ",                                      #2015/01/21 add by qiull
                  " WHERE nmbaent   = '",g_enterprise,"'",
                  "   AND nmbaent   = nmbbent ",
                  "   AND nmbacomp  = nmbbcomp ",
                  "   AND nmbadocno = nmbbdocno ",
                  "   AND nmbtent   = nmbaent ",    #160708-00016#2 add
                  "   AND nmbt002   = nmbadocno ",
                  "   AND nmbt003   = nmbbseq ",    #160708-00016#2 add
                  "   AND nmbacomp  = '",l_glaacomp,"'", #160708-00016#2 add
                  "   AND nmbtld    = '",l_tmp.glaald,"'",
                 #"   AND nmbt001 = '1' ",                     #2015/01/27 add by qiull
                  "   AND (nmbt001 = '1' OR nmbt001 ='4') ",   #2015/08/24 add by kris
                  #2015/01/22 mark by qiull(s)
                  #"   AND nmbtld    = nmbvld ",
                  #"   AND nmbtdocno = nmbvdocno ",
                  #"   AND nmbtseq   = nmbvseq ",
                  #"   AND nmbvseq2  = '1'",
                  #2015/01/22 mark by qiull(e)
                  "   AND (nmbb042 IN('1','2') OR nmbb069 = 'Y')",
                  #"   AND (nmbastus = 'Y' OR nmbastus = 'V')",  #161026-00010#2 mark
                  "   AND nmbastus = 'V' ",                      #161026-00010#2 add                
                  "   AND nmbb004   != '",g_glaa001,"'",
                  "   AND nmbadocdt <= '",l_pdate_e,"'",
                  #2015/01/21 modify by qiull(s)
                  "   AND nmbb029 = '30' ",
                  #"   AND (nmbb006  > nmbb008 OR ",
                  #"        nmbadocno IN (SELECT xrce003 FROM xrda_t,xrce_t ",
                  #"                       WHERE xrdaent = '",g_enterprise,"'",
                  #"                         AND xrdaent = xrceent ",
                  #"                         AND xrdald = xrceld ",
                  #"                         AND xrdadocno = xrcedocno ",
                  #"                         AND xrdald = '",l_tmp.glaald,"'",
                  #"                         AND xrdastus = 'Y' ",
                  #"                         AND xrdadocdt > '",l_pdate_s,"'))",
                  #2015/01/21 modify by qiull(e)
                  "  ORDER BY nmbadocno"
               
      PREPARE p811_pre1 FROM g_sql  
      DECLARE p811_curs1 CURSOR FOR p811_pre1
      
      FOREACH p811_curs1 INTO sr.*
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         #未沖金額需將大於此月已沖金額加回
         SELECT SUM(xrce109),SUM(xrce119),SUM(xrce129),SUM(xrce139) INTO l_amt1,l_amt2,l_amt3,l_amt4
           FROM xrda_t,xrce_t
          WHERE xrdaent = g_enterprise
            AND xrdaent = xrceent
            AND xrdald = xrceld
            AND xrdadocno = xrcedocno
            AND xrce015 = 'D'
            AND xrce006 = '30'
            AND xrdastus = 'Y'
            AND xrdadocdt > l_pdate_e
            AND xrce003 = sr.nmbadocno
            
         IF cl_null(l_amt1) THEN LET l_amt1 = 0 END IF
         IF cl_null(l_amt2) THEN LET l_amt2 = 0 END IF
         IF cl_null(l_amt3) THEN LET l_amt3 = 0 END IF
         IF cl_null(l_amt4) THEN LET l_amt4 = 0 END IF
         LET sr.amt1 = sr.amt1 + l_amt1
         LET sr.amt2 = sr.amt2 + l_amt2
         LET sr.amt3 = sr.amt3 + l_amt3
         LET sr.amt4 = sr.amt4 + l_amt4
         
        
         #上期會差金額
         IF g_input.mm = 1 THEN 
            SELECT xreb115,xreb125,xreb135 INTO l_xreb115,l_xreb125,l_xreb135
              FROM xreb_t
             WHERE xrebent = g_enterprise
               AND xrebld = l_tmp.glaald
               AND xreb001 = g_input.yy - 1
               AND xreb002 = 12 
               AND xreb003 = 'NM'
               AND xreb004 = 'NR'
               AND xreb005 = sr.nmbadocno
               #AND xreb006 = 1         #160628-00010#2
               AND xreb006 = sr.nmbbseq #160628-00010#2
               AND xreb007 = 1
         ELSE
            SELECT xreb115,xreb125,xreb135 INTO l_xreb115,l_xreb125,l_xreb135
              FROM xreb_t
             WHERE xrebent = g_enterprise
               AND xrebld = l_tmp.glaald
               AND xreb001 = g_input.yy
               AND xreb002 = g_input.mm - 1
               AND xreb003 = 'NM'
               AND xreb004 = 'NR'
               AND xreb005 = sr.nmbadocno
               #AND xreb006 = 1         #160628-00010#2
               AND xreb006 = sr.nmbbseq #160628-00010#2
               AND xreb007 = 1
         END IF
        
         IF cl_null(l_xreb115) THEN LET l_xreb115 = 0 END IF
         IF cl_null(l_xreb125) THEN LET l_xreb125 = 0 END IF
         IF cl_null(l_xreb135) THEN LET l_xreb135 = 0 END IF
         
         SELECT ooef015 INTO l_ooef015
           FROM ooef_t
          WHERE ooefent = g_enterprise
            AND ooef001 = l_tmp.glaacomp 
         
         IF g_input.mm < 10 THEN         
            LET l_date = g_input.yy CLIPPED,'0' CLIPPED,g_input.mm 
         ELSE
            LET l_date = g_input.yy CLIPPED,g_input.mm 
         END IF
         
         #150824 mark ------
         ##重評價匯率
         #SELECT ooao011 INTO l_ooao011 
         #  FROM ooao_t 
         # WHERE ooaoent = g_enterprise
         #   AND ooao001 = l_ooef015
         #   AND ooao002 = sr.nmbb004
         #   AND ooao003 = g_glaa001
         #   AND ooao004 = l_date
         #IF cl_null(l_ooao011) OR l_ooao011 = 0  THEN    
         #   LET l_ooao011 = 1
         #END IF
         #
         ##本位幣二重評價匯率
         #IF g_glaa017 = '1' THEN 
         #   LET l_ooam003 = sr.nmbb004
         #ELSE
         #   LET l_ooam003 = g_glaa001
         #END IF
         #SELECT ooao011 INTO l_ooao011_2 
         #  FROM ooao_t 
         # WHERE ooaoent = g_enterprise
         #   AND ooao001 = l_ooef015
         #   AND ooao002 = l_ooam003
         #   AND ooao003 = g_glaa016
         #   AND ooao004 = l_date
         #IF cl_null(l_ooao011_2) THEN 
         #   LET l_ooao011_2 = 1
         #END IF
         #
         ##本位幣三重評價匯率
         #IF g_glaa021 = '1' THEN 
         #   LET l_ooam003 = sr.nmbb004
         #ELSE
         #   LET l_ooam003 = g_glaa001
         #END IF
         #SELECT ooao011 INTO l_ooao011_3 
         #  FROM ooao_t 
         # WHERE ooaoent = g_enterprise
         #   AND ooao001 = l_ooef015
         #   AND ooao002 = l_ooam003
         #   AND ooao003 = g_glaa020
         #   AND ooao004 = l_date
         #IF cl_null(l_ooao011_3) THEN 
         #   LET l_ooao011_3 = 1
         #END IF
         #150824 mark end---
         #150824 add ------
         CALL s_fin_get_exchange_rate(l_tmp.glaald,g_input.yy,g_input.mm,sr.nmbb004,l_tmp.glca003) 
              RETURNING l_ooao011,l_ooao011_2,l_ooao011_3
         IF cl_null(l_ooao011) THEN LET l_ooao011 = 0 END IF
         IF cl_null(l_ooao011_2) THEN LET l_ooao011_2 = 0 END IF
         IF cl_null(l_ooao011_3) THEN LET l_ooao011_3 = 0 END IF
         #150824 add end---
            
         LET l_xreb.xrebent  = g_enterprise
         LET l_xreb.xrebcomp = l_tmp.glaacomp
         LET l_xreb.xrebsite = g_input.ooef001
         LET l_xreb.xrebld   = l_tmp.glaald
         LET l_xreb.xreb001  = g_input.yy
         LET l_xreb.xreb002  = g_input.mm
         LET l_xreb.xreb003  = 'NM'
         LET l_xreb.xreb004  = 'NR'
         LET l_xreb.xreb005  = sr.nmbadocno
         #LET l_xreb.xreb006  = 1             #160628-00010#2
         LET l_xreb.xreb006  = sr.nmbbseq     #160628-00010#2
         LET l_xreb.xreb007  = 1
         LET l_xreb.xreb008  = sr.nmbadocdt
         LET l_xreb.xreb009  = sr.nmba004
         LET l_xreb.xreb010  = sr.nmbblegl
         LET l_xreb.xreb011  = sr.nmbt018
         LET l_xreb.xreb012  = sr.nmbt019
         LET l_xreb.xreb013  = sr.nmbt020
         LET l_xreb.xreb014  = sr.nmbt023
         LET l_xreb.xreb015  = sr.nmbt024
         LET l_xreb.xreb016  = sr.nmbt025
         #2015/01/21---modify---by---qiull---str---
         #LET l_xreb.xreb017  = sr.nmbt026
         #LET l_xreb.xreb018  = sr.nmbt027
         #LET l_xreb.xreb019  = sr.nmbt028
         #LET l_xreb.xreb020  = sr.nmba005
         #LET l_xreb.xreb021  = ''
         #LET l_xreb.xreb022  = sr.nmbv001
         #LET l_xreb.xreb023  = ''
         #LET l_xreb.xreb024  = sr.nmbborga  
         LET l_xreb.xreb017  = sr.nmbt027
         LET l_xreb.xreb018  = sr.nmbt028
         LET l_xreb.xreb019  = sr.nmbt029
         LET l_xreb.xreborga = sr.nmbborga
         LET l_xreb.xreb020  = sr.nmbt031
         LET l_xreb.xreb021  = sr.nmbt032
         LET l_xreb.xreb022  = sr.nmbt033
         LET l_xreb.xreb023  = sr.nmbt034
         LET l_xreb.xreb024  = sr.nmbt035
         LET l_xreb.xreb025  = sr.nmbt036
         LET l_xreb.xreb026  = sr.nmbt037
         LET l_xreb.xreb027  = sr.nmbt038
         LET l_xreb.xreb028  = sr.nmbt039
         LET l_xreb.xreb029  = sr.nmbt040
         LET l_xreb.xreb030  = sr.nmbt041
         LET l_xreb.xreb031  = sr.nmbt042
         LET l_xreb.xreb032  = sr.nmbt043
         #2015/01/21---modify---by---qiull---end---
         LET l_xreb.xreb100  = sr.nmbb004
         
         LET l_xreb.xreb101  = l_ooao011
         #計算本期未沖金額(原幣)
         LET l_xreb.xreb103  = sr.amt1
         IF cl_null(l_xreb.xreb103) THEN LET l_xreb.xreb103 = 0 END IF  #150824
         #計算本期未沖金額(本幣)
         LET l_xreb.xreb113  = sr.amt2
         IF cl_null(l_xreb.xreb113) THEN LET l_xreb.xreb113 = 0 END IF  #150824
         #LET l_xreb.xreb114  = l_xreb.xreb113 * l_xreb.xreb101   #2015/01/16 mark by qiull
         #LET l_xreb.xreb115  = l_xreb.xreb113 - l_xreb.xreb114   #2015/01/16 mark by qiull
         #重評價後金額(本幣)
         LET l_xreb.xreb114  = l_xreb.xreb103 * l_xreb.xreb101    #2015/01/16 add by qiull
         IF cl_null(l_xreb.xreb114) THEN LET l_xreb.xreb114 = 0 END IF  #150824
         CALL s_curr_round_ld('1',l_tmp.glaald,g_glaa001,l_xreb.xreb114,2) RETURNING g_sub_success,g_errno,l_xreb.xreb114 #150824
         LET l_xreb.xreb115  = l_xreb.xreb114 - l_xreb.xreb113    #2015/01/16 add by qiull
         IF cl_null(l_xreb.xreb115) THEN LET l_xreb.xreb115 = 0 END IF  #150824
         IF l_tmp.glca002 = '2' THEN
           LET l_xreb.xreb116 = l_xreb.xreb115 
         END IF
         IF l_tmp.glca002 = '3' THEN   #期末暫估傳次月不回轉, 則以跟上月之差額形成傳票
            LET l_xreb.xreb116  = l_xreb.xreb115 - l_xreb115
         END IF
         IF cl_null(l_xreb.xreb116) THEN LET l_xreb.xreb116 = 0 END IF #150824
         
         #本幣二
         LET l_xreb.xreb121  = l_ooao011_2
         LET l_xreb.xreb123  = sr.amt3
         IF cl_null(l_xreb.xreb123) THEN LET l_xreb.xreb123 = 0 END IF  #150824
         LET l_xreb.xreb124  = l_xreb.xreb123 * l_xreb.xreb121
         IF cl_null(l_xreb.xreb124) THEN LET l_xreb.xreb124 = 0 END IF  #150824
         CALL s_curr_round_ld('1',l_tmp.glaald,g_glaa016,l_xreb.xreb124,2) RETURNING g_sub_success,g_errno,l_xreb.xreb124  #150824
         LET l_xreb.xreb125  = l_xreb.xreb124 - l_xreb.xreb123
         IF cl_null(l_xreb.xreb125) THEN LET l_xreb.xreb125 = 0 END IF  #150824
         IF l_tmp.glca002 = '2' THEN   #2:期末暫估傳票，次月迴轉。
           LET l_xreb.xreb126 = l_xreb.xreb125
         END IF         
         IF l_tmp.glca002 = '3' THEN   #3:重評價傳票，次月不迴轉。
           LET l_xreb.xreb126 = l_xreb.xreb125 - l_xreb125
         END IF
         IF cl_null(l_xreb.xreb126) THEN LET l_xreb.xreb126 = 0 END IF  #150824

         #本幣三
         LET l_xreb.xreb131  = l_ooao011_3
         LET l_xreb.xreb133  = sr.amt4
         IF cl_null(l_xreb.xreb133) THEN LET l_xreb.xreb133 = 0 END IF  #150824
         LET l_xreb.xreb134  = l_xreb.xreb133 * l_xreb.xreb131
         IF cl_null(l_xreb.xreb134) THEN LET l_xreb.xreb134 = 0 END IF  #150824
         CALL s_curr_round_ld('1',l_tmp.glaald,g_glaa020,l_xreb.xreb134,2) RETURNING g_sub_success,g_errno,l_xreb.xreb134  #150824
         LET l_xreb.xreb135  = l_xreb.xreb134 - l_xreb.xreb133
         IF cl_null(l_xreb.xreb135) THEN LET l_xreb.xreb135 = 0 END IF  #150824
         IF l_tmp.glca002 = '2' THEN   #2:期末暫估傳票，次月迴轉。
           LET l_xreb.xreb136 = l_xreb.xreb135 
         END IF
         IF l_tmp.glca002 = '3' THEN   #3:重評價傳票，次月不迴轉。
           LET l_xreb.xreb136 = l_xreb.xreb135 - l_xreb135
         END IF
         IF cl_null(l_xreb.xreb136) THEN LET l_xreb.xreb136 = 0 END IF  #150824
         #2015/02/11---add---by---qiull(s)
         CASE
            WHEN l_xreb.xreb115 < 0 
                 #重評價匯兌損失
                 CALL s_fin_get_account(l_xreb.xrebld,'25','8318','8318_12') RETURNING g_sub_success,l_xreb.xreb034,g_errno
            WHEN l_xreb.xreb115 > 0
                 #重評價匯兌收益
                 CALL s_fin_get_account(l_xreb.xrebld,'25','8318','8318_11') RETURNING g_sub_success,l_xreb.xreb034,g_errno 
         END CASE
         #2015/02/11---add---by---qiull(e)
         
         #161128-00061#2----modify------begin-----------
         #INSERT INTO xreb_t VALUES(l_xreb.*)
         INSERT INTO xreb_t (xrebent,xrebcomp,xrebsite,xrebld,xreb001,xreb002,xreb003,xreb004,xreb005,xreb006,
                             xreb007,xreb008,xreb009,xreb010,xreb011,xreb012,xreb013,xreb014,xreb015,xreb016,
                             xreb017,xreb018,xreb019,xreborga,xreb020,xreb021,xreb022,xreb023,xreb024,xreb025,
                             xreb026,xreb027,xreb028,xreb029,xreb030,xreb031,xreb032,xreb033,xreb034,xreb100,
                             xreb101,xreb102,xreb103,xreb113,xreb114,xreb115,xreb116,xreb121,xreb122,xreb123,
                             xreb124,xreb125,xreb126,xreb131,xreb132,xreb133,xreb134,xreb135,xreb136)
           VALUES(l_xreb.xrebent,l_xreb.xrebcomp,l_xreb.xrebsite,l_xreb.xrebld,l_xreb.xreb001,l_xreb.xreb002,l_xreb.xreb003,l_xreb.xreb004,l_xreb.xreb005,l_xreb.xreb006,
                  l_xreb.xreb007,l_xreb.xreb008,l_xreb.xreb009,l_xreb.xreb010,l_xreb.xreb011,l_xreb.xreb012,l_xreb.xreb013,l_xreb.xreb014,l_xreb.xreb015,l_xreb.xreb016,
                  l_xreb.xreb017,l_xreb.xreb018,l_xreb.xreb019,l_xreb.xreborga,l_xreb.xreb020,l_xreb.xreb021,l_xreb.xreb022,l_xreb.xreb023,l_xreb.xreb024,l_xreb.xreb025,
                  l_xreb.xreb026,l_xreb.xreb027,l_xreb.xreb028,l_xreb.xreb029,l_xreb.xreb030,l_xreb.xreb031,l_xreb.xreb032,l_xreb.xreb033,l_xreb.xreb034,l_xreb.xreb100,
                  l_xreb.xreb101,l_xreb.xreb102,l_xreb.xreb103,l_xreb.xreb113,l_xreb.xreb114,l_xreb.xreb115,l_xreb.xreb116,l_xreb.xreb121,l_xreb.xreb122,l_xreb.xreb123,
                  l_xreb.xreb124,l_xreb.xreb125,l_xreb.xreb126,l_xreb.xreb131,l_xreb.xreb132,l_xreb.xreb133,l_xreb.xreb134,l_xreb.xreb135,l_xreb.xreb136)
         #161128-00061#2----modify------end-----------
         
         IF SQLCA.sqlcode THEN
            #CALL cl_errmsg("ins xreb",'','',SQLCA.SQLCODE,1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "ins xreb"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N'       
         END IF
         
         #更新重評價金額  
         UPDATE nmbb_t SET nmbb066 = l_xreb.xreb114,
                           nmbb067 = l_xreb.xreb124,
                           nmbb068 = l_xreb.xreb134
          WHERE nmbbent = g_enterprise
            AND nmbbcomp = l_tmp.glaacomp
            AND nmbbdocno = sr.nmbadocno
            AND nmbbseq = sr.nmbbseq   #160628-00010#2
            
         IF SQLCA.sqlcode THEN
            #CALL cl_errmsg("upd nmbb",'','',SQLCA.SQLCODE,1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "upd nmbb"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N'       
         END IF
         
         #160628-00010#2 add s---
         #更新重評后金額  
         UPDATE isbb_t SET isbb114 = l_xreb.xreb114,
                           isbb124 = l_xreb.xreb124,
                           isbb134 = l_xreb.xreb134
          WHERE isbbent = g_enterprise
            AND isbbcomp = l_tmp.glaacomp
            AND isbb002 = sr.nmbadocno
            AND isbb003 = sr.nmbbseq   #160628-00010#2
            
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "upd isbb"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N'       
         END IF         
         #160628-00010#2 add s---
      END FOREACH 
      
      #更新月底重評價年度月份
      UPDATE glca_t SET glca006 = g_input.yy,
                        glca007 = g_input.mm
       WHERE glcaent = g_enterprise
         AND glcald = l_tmp.glaald
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
 
   CALL cl_err_collect_show()
   IF g_success = 'Y' THEN
      CALL s_transaction_end('Y',1)
   ELSE 
      CALL s_transaction_end('N',1)
   END IF
END FUNCTION
# 應付票據月底重評價
PRIVATE FUNCTION anmp811_np()
   DEFINE l_cnt           LIKE type_t.num5
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
   DEFINE l_amt1          LIKE nmbb_t.nmbb008    #沖賬原幣
   DEFINE l_amt2          LIKE nmbb_t.nmbb008    #沖賬本幣
   DEFINE l_amt3          LIKE nmbb_t.nmbb008    #本位幣二沖賬金額
   DEFINE l_amt4          LIKE nmbb_t.nmbb008    #本位幣三沖賬金額
   DEFINE l_ooao011       LIKE ooao_t.ooao011    #重評價匯率
   DEFINE l_ooao011_2     LIKE ooao_t.ooao011    #本位幣二重評價匯率
   DEFINE l_ooao011_3     LIKE ooao_t.ooao011    #本位幣三重評價匯率
   DEFINE l_ooao011_p     LIKE ooao_t.ooao011    #上月重評價匯率
   DEFINE l_ooao011_p_2   LIKE ooao_t.ooao011    #上月本位幣二重評價匯率
   DEFINE l_ooao011_p_3   LIKE ooao_t.ooao011    #上月本位幣三重評價匯率
   DEFINE l_ooef015       LIKE ooef_t.ooef015    #法人所使用匯率參照表
   DEFINE l_xreb115       LIKE xreb_t.xreb115    #上期匯差金額
   DEFINE l_xreb125       LIKE xreb_t.xreb125    #本位幣二上期匯差金額
   DEFINE l_xreb135       LIKE xreb_t.xreb135    #本位幣三上期匯差金額
   DEFINE l_ooam003       LIKE ooam_t.ooam003    #基礎幣別
   DEFINE l_date          LIKE type_t.chr10      #年月 值如201405,前面4碼是西元年,後面2碼是月份
   DEFINE l_date1         LIKE type_t.chr10      #年月 值如201405,前面4碼是西元年,後面2碼是月份
   DEFINE l_xrebcomp      LIKE xreb_t.xrebcomp   #法人
   DEFINE l_xrebld        LIKE xreb_t.xrebld     #帳別
   DEFINE l_xreb005       LIKE xreb_t.xreb005    #單據號碼
   DEFINE l_yy            LIKE type_t.num5       #年
   DEFINE l_mm            LIKE type_t.num5       #月
   #161128-00061#2----modify------begin-----------
   #DEFINE l_xreb          RECORD LIKE xreb_t.*
   DEFINE l_xreb RECORD  #重評價月結檔
       xrebent LIKE xreb_t.xrebent, #企業編號
       xrebcomp LIKE xreb_t.xrebcomp, #法人
       xrebsite LIKE xreb_t.xrebsite, #帳務中心
       xrebld LIKE xreb_t.xrebld, #帳套
       xreb001 LIKE xreb_t.xreb001, #年度
       xreb002 LIKE xreb_t.xreb002, #期別
       xreb003 LIKE xreb_t.xreb003, #來源模組
       xreb004 LIKE xreb_t.xreb004, #帳款單性質
       xreb005 LIKE xreb_t.xreb005, #單據號碼
       xreb006 LIKE xreb_t.xreb006, #項次
       xreb007 LIKE xreb_t.xreb007, #分期帳款序
       xreb008 LIKE xreb_t.xreb008, #立帳日期
       xreb009 LIKE xreb_t.xreb009, #帳款對象
       xreb010 LIKE xreb_t.xreb010, #收款對象
       xreb011 LIKE xreb_t.xreb011, #部門
       xreb012 LIKE xreb_t.xreb012, #責任中心
       xreb013 LIKE xreb_t.xreb013, #區域
       xreb014 LIKE xreb_t.xreb014, #客群
       xreb015 LIKE xreb_t.xreb015, #產品類別
       xreb016 LIKE xreb_t.xreb016, #人員
       xreb017 LIKE xreb_t.xreb017, #專案編號
       xreb018 LIKE xreb_t.xreb018, #WBS編號
       xreb019 LIKE xreb_t.xreb019, #應收科目
       xreborga LIKE xreb_t.xreborga, #來源組織
       xreb020 LIKE xreb_t.xreb020, #經營方式
       xreb021 LIKE xreb_t.xreb021, #渠道
       xreb022 LIKE xreb_t.xreb022, #品牌
       xreb023 LIKE xreb_t.xreb023, #自由核算項一
       xreb024 LIKE xreb_t.xreb024, #自由核算項二
       xreb025 LIKE xreb_t.xreb025, #自由核算項三
       xreb026 LIKE xreb_t.xreb026, #自由核算項四
       xreb027 LIKE xreb_t.xreb027, #自由核算項五
       xreb028 LIKE xreb_t.xreb028, #自由核算項六
       xreb029 LIKE xreb_t.xreb029, #自由核算項七
       xreb030 LIKE xreb_t.xreb030, #自由核算項八
       xreb031 LIKE xreb_t.xreb031, #自由核算項九
       xreb032 LIKE xreb_t.xreb032, #自由核算項十
       xreb033 LIKE xreb_t.xreb033, #摘要
       xreb034 LIKE xreb_t.xreb034, #重評價會計科目
       xreb100 LIKE xreb_t.xreb100, #幣別
       xreb101 LIKE xreb_t.xreb101, #重評價匯率
       xreb102 LIKE xreb_t.xreb102, #上月重評匯率
       xreb103 LIKE xreb_t.xreb103, #本期原幣未沖金額
       xreb113 LIKE xreb_t.xreb113, #本期本幣未沖金額
       xreb114 LIKE xreb_t.xreb114, #本期重評價後本幣金額
       xreb115 LIKE xreb_t.xreb115, #本期匯差金額
       xreb116 LIKE xreb_t.xreb116, #本幣累計匯差
       xreb121 LIKE xreb_t.xreb121, #本位幣二重評價匯率
       xreb122 LIKE xreb_t.xreb122, #本位幣二上月重估匯率
       xreb123 LIKE xreb_t.xreb123, #本期本位幣二未沖金額
       xreb124 LIKE xreb_t.xreb124, #本期本位幣二重評價後金額
       xreb125 LIKE xreb_t.xreb125, #本期本位幣二匯差金額
       xreb126 LIKE xreb_t.xreb126, #本位幣二累計匯差
       xreb131 LIKE xreb_t.xreb131, #本位幣三重評價匯率
       xreb132 LIKE xreb_t.xreb132, #本位幣三上月重估匯率
       xreb133 LIKE xreb_t.xreb133, #本期本位幣三未沖金額
       xreb134 LIKE xreb_t.xreb134, #本期本位幣三重評價後金額
       xreb135 LIKE xreb_t.xreb135, #本期本位幣三匯差金額
       xreb136 LIKE xreb_t.xreb136  #本位幣三累計匯差
       END RECORD
   #161128-00061#2----modify------end-----------
   DEFINE sr              RECORD
                          nmckdocno          LIKE nmck_t.nmckdocno,
                          nmckdocdt          LIKE nmck_t.nmckdocdt,
                          nmck100            LIKE nmck_t.nmck100,
                          nmck101            LIKE nmck_t.nmck101,
                          nmck123            LIKE nmck_t.nmck123,
                          nmck133            LIKE nmck_t.nmck133,
                          nmck103            LIKE nmck_t.nmck103,
                          nmck113            LIKE nmck_t.nmck113,
                          nmck005            LIKE nmck_t.nmck005,
                          nmck006            LIKE nmck_t.nmck006,
                          nmbt018            LIKE nmbt_t.nmbt018,
                          nmbt019            LIKE nmbt_t.nmbt019,
                          nmbt020            LIKE nmbt_t.nmbt020,
                          nmbt023            LIKE nmbt_t.nmbt023,
                          nmbt024            LIKE nmbt_t.nmbt024,
                          nmbt025            LIKE nmbt_t.nmbt025,
                          nmbt026            LIKE nmbt_t.nmbt026,
                          nmbt027            LIKE nmbt_t.nmbt027,
                          nmbt028            LIKE nmbt_t.nmbt028,
                          #nmbv001            LIKE nmbv_t.nmbv001   #2015/02/05 mark by qiull    
                          #2015/02/05 add by qiull(s)
                          nmbt029            LIKE nmbt_t.nmbt029,
                          nmbt031            LIKE nmbt_t.nmbt031,
                          nmbt032            LIKE nmbt_t.nmbt032,
                          nmbt033            LIKE nmbt_t.nmbt033,
                          nmbt034            LIKE nmbt_t.nmbt034,
                          nmbt035            LIKE nmbt_t.nmbt035,
                          nmbt036            LIKE nmbt_t.nmbt036,
                          nmbt037            LIKE nmbt_t.nmbt037,
                          nmbt038            LIKE nmbt_t.nmbt038,
                          nmbt039            LIKE nmbt_t.nmbt039,
                          nmbt040            LIKE nmbt_t.nmbt040,
                          nmbt041            LIKE nmbt_t.nmbt041,
                          nmbt042            LIKE nmbt_t.nmbt042,
                          nmbt043            LIKE nmbt_t.nmbt043,
                          nmck002            LIKE nmck_t.nmck002  #150824
                          #2015/02/05 add by qiull(e)
                          END RECORD
                          
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
                          ym              LIKE type_t.chr10,
                          xreb023         LIKE xreb_t.xreb023 
                          END RECORD
   DEFINE l_ld            LIKE glaa_t.glaald
                                                 
#   CALL s_transaction_begin() #160708-00016#2 mark
   #CALL cl_showmsg_init()
#   CALL cl_err_collect_init() #160708-00016#2 mark
   LET g_success = 'Y'
   
   #檢查是否已拋轉總帳
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM xreg_t,xreh_t
    WHERE xregent = xrehent
      AND xregdocno = xrehdocno
      AND xregent = g_enterprise
      AND xregld IN (SELECT glaald FROM anmp811_tmp WHERE sel = 'Y')
      AND xreg001 = g_input.yy
      AND xreg002 = g_input.mm
      AND xreg003 = 'NM'
      AND xreh004 = 'NP'
      AND xreg005 IS NOT NULL
   #SELECT COUNT(*) INTO l_cnt
   #  FROM xreb_t
   # WHERE xrebent = g_enterprise
   #   AND xrebld IN (SELECT glaald FROM anmp811_tmp WHERE sel = 'Y')
   #   AND xreb001 = g_input.yy
   #   AND xreb002 = g_input.mm
   #   AND xreb003 = 'NM' 
   #   AND xreb004 = 'NP' 
   #   AND xreb023 IS NOT NULL
   IF l_cnt > 0 THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'anm-00221'
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
      AND xrebld IN (SELECT glaald FROM anmp811_tmp WHERE sel = 'Y')
      #AND xreb003 = 'NR'                                                 #2015/01/16 mark by qiull
      AND xreb003 = 'NM' AND xreb004 = 'NP'                               #2015/01/16 add by qiull
      AND (xreb001 > g_input.yy OR (xreb001 = g_input.yy AND xreb002 > g_input.mm))
   IF l_cnt > 0 THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'anm-00218'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN 
   END IF

   #2015/04/14--by--02599--add--str--
   #判斷是否已存在重評資料，如果存在詢問是否還原重評
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM xreb_t
    WHERE xrebent = g_enterprise 
      AND xrebld IN (SELECT glaald FROM anmp811_tmp WHERE sel = 'Y')
      AND xreb001 = g_input.yy AND xreb002 = g_input.mm
      AND xreb003 = 'NM' AND xreb004 = 'NP'
   IF l_cnt >0 THEN
      IF NOT cl_ask_confirm("anm-00343") THEN
         RETURN
      END IF
   END IF
   #2015/04/14--by--02599--add--end 

   CALL s_transaction_begin() #160708-00016#2 add
   CALL cl_err_collect_init() #160708-00016#2 add
   #還原
   LET g_sql = "SELECT xrebcomp,xrebld,xreb005 FROM xreb_t ",
               " WHERE xrebent = '",g_enterprise,"'",
               "   AND xrebld IN (SELECT glaald FROM anmp811_tmp WHERE sel = 'Y') ",
               "   AND xreb001 = '",g_input.yy,"'",
               "   AND xreb002 = '",g_input.mm,"'",
               "   AND xreb003 = 'NM' ",
               "   AND xreb004 = 'NP' "
   PREPARE anmp811_del_pre2 FROM g_sql
   DECLARE anmp811_del_cur2 CURSOR FOR anmp811_del_pre2
   
   FOREACH anmp811_del_cur2 INTO l_xrebcomp,l_xrebld,l_xreb005
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
      
         EXIT FOREACH
      END IF
      
      #還原重評價金額  
      UPDATE nmck_t SET nmck114 = 0,
                        nmck124 = 0,
                        nmck134 = 0
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
      
      IF cl_null(l_ld) OR l_ld <> l_xrebld THEN
         #還原月底重評價年度月份
         UPDATE glca_t SET glca006 = '',
                           glca007 = ''
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
         LET l_ld = l_xrebld
      END IF
   END FOREACH 
   DELETE FROM xreb_t WHERE xrebent = g_enterprise
                        AND xrebld IN (SELECT glaald FROM anmp811_tmp WHERE sel = 'Y') 
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
   
   DELETE FROM xreg_t WHERE xregent = g_enterprise
                        AND xregdocno IN(SELECT DISTINCT xregdocno FROM xreg_t,xreh_t
                                        WHERE xregent = xrehent
                                          AND xregdocno = xrehdocno
                                          AND xreh004 = 'NP'
                                          AND xregent = g_enterprise
                                          AND xregld IN(SELECT glaald FROM anmp811_tmp WHERE sel = 'Y') 
                                          AND xreg001 = g_input.yy
                                          AND xreg002 = g_input.mm
                                          AND xreg003 = 'NM')
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "del xreg"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = 'N'       
   END IF
   
   DELETE FROM xreh_t WHERE xrehent = g_enterprise
                        AND xrehdocno IN(SELECT DISTINCT xregdocno FROM xreg_t,xreh_t
                                        WHERE xregent = xrehent
                                          AND xregdocno = xrehdocno
                                          AND xreh004 = 'NP'
                                          AND xregent = g_enterprise
                                          AND xregld IN(SELECT glaald FROM anmp811_tmp WHERE sel = 'Y') 
                                          AND xreg001 = g_input.yy
                                          AND xreg002 = g_input.mm
                                          AND xreg003 = 'NM')
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "del xreh"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = 'N'       
   END IF
   
   LET g_sql = "SELECT * FROM anmp811_tmp ",
               " WHERE sel = 'Y' "
   PREPARE anmp811_tmp_pre2 FROM g_sql 
   DECLARE anmp811_tmp_cur2 CURSOR FOR anmp811_tmp_pre2
   FOREACH anmp811_tmp_cur2 INTO l_tmp.*   
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
         AND glaald = l_tmp.glaald
         
      #獲取當前年度期別的第一天和最後一天
      CALL s_get_accdate(g_glaa003,'',g_input.yy,g_input.mm)
      RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e    
      
      #150824 add nmck002
      LET g_sql = "SELECT nmckdocno,nmckdocdt,nmck100,nmck101,nmck123,nmck133,",
                  "       nmck103,nmck113,nmck005,nmck006,nmbt018,nmbt019,",
                  "       nmbt020,nmbt023,nmbt024,nmbt025,nmbt026,nmbt027,",
                  "       nmbt028,nmbt029,nmbt031,nmbt032,nmbt033,nmbt034,nmbt035,nmbt036,",
                  "       nmbt037,nmbt038,nmbt039,nmbt040,nmbt041,nmbt042,nmbt043,nmck002",
                  #"  FROM nmck_t,nmbt_t ", #150824 mark
                  "  FROM nmck_t",  #150824
                  "  LEFT JOIN nmbt_t ON nmckent = nmbtent AND nmckdocno = nmbt002 ",  #150824
                  " WHERE nmckent   = '",g_enterprise,"'",
                  #"   AND nmbt002   = nmckdocno ",           #150824 mark
                  #"   AND nmbtld    = '",l_tmp.glaald,"'",   #150824 mark
                  #"   AND nmbtld    = nmbvld ",
                  #"   AND nmbtdocno = nmbvdocno ",
                  #"   AND nmbtseq   = nmbvseq ",
                  #"   AND nmbvseq2  = '2'",
                  #"   AND nmck026 IN ('1','0')",     #150824 mark
                  "   AND nmck026 IN ('1','0','10')", #150824 票況=10的也要納進來
                  "   AND nmckstus = 'Y' ",
                  "   AND nmck100  != '",g_glaa001,"'",
                  "   AND nmckdocdt <= '",l_pdate_e,"'",
                  "   AND nmbtld = '",l_tmp.glaald,"'",      #160728-00023#1
                  "   AND nmbt002 = nmckdocno ",             #160728-00023#1
                  "   AND nmbtcomp = '",l_tmp.glaacomp,"'",  #160728-00023#1 
                  "  ORDER BY nmckdocno"
      PREPARE p811_pre2 FROM g_sql  
      DECLARE p811_curs2 CURSOR FOR p811_pre2
      FOREACH p811_curs2 INTO sr.*
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
      
            EXIT FOREACH
         END IF
         
             
        #上期會差金額
        IF g_input.mm = 1 THEN 
           SELECT xreb115,xreb125,xreb135 INTO l_xreb115,l_xreb125,l_xreb135
             FROM xreb_t
            WHERE xrebent = g_enterprise
              AND xrebld = l_tmp.glaald
              AND xreb001 = g_input.yy - 1
              AND xreb002 = 12 
              AND xreb003 = 'NM'
              AND xreb004 = 'NP'
              AND xreb005 = sr.nmckdocno
              AND xreb006 = 1
              AND xreb007 = 1
        ELSE
           SELECT xreb115,xreb125,xreb135 INTO l_xreb115,l_xreb125,l_xreb135
             FROM xreb_t
            WHERE xrebent = g_enterprise
              AND xrebld = l_tmp.glaald
              AND xreb001 = g_input.yy
              AND xreb002 = g_input.mm - 1
              AND xreb003 = 'NM'
              AND xreb004 = 'NP'
              AND xreb005 = sr.nmckdocno
              AND xreb006 = 1
              AND xreb007 = 1
        END IF
        
        IF cl_null(l_xreb115) THEN LET l_xreb115 = 0 END IF
        IF cl_null(l_xreb125) THEN LET l_xreb125 = 0 END IF
        IF cl_null(l_xreb135) THEN LET l_xreb135 = 0 END IF
        
        SELECT ooef015 INTO l_ooef015
          FROM ooef_t
         WHERE ooefent = g_enterprise
           AND ooef001 = l_tmp.glaacomp 
        
        IF g_input.mm < 10 THEN         
           LET l_date = g_input.yy CLIPPED,'0' CLIPPED,g_input.mm 
        ELSE
           LET l_date = g_input.yy CLIPPED,g_input.mm 
        END IF
        
        #150824 add ------
        ##重評價匯率
        #SELECT ooao011 INTO l_ooao011 
        #  FROM ooao_t 
        # WHERE ooaoent = g_enterprise
        #   AND ooao001 = l_ooef015
        #   AND ooao002 = sr.nmck100
        #   AND ooao003 = g_glaa001
        #   AND ooao004 = l_date
        #IF cl_null(l_ooao011) OR l_ooao011 = 0  THEN    
        #   LET l_ooao011 = 1
        #END IF
        #
        ##本位幣二重評價匯率
        #IF g_glaa017 = '1' THEN 
        #   LET l_ooam003 = sr.nmck100
        #ELSE
        #   LET l_ooam003 = g_glaa001
        #END IF
        #SELECT ooao011 INTO l_ooao011_2 
        #  FROM ooao_t 
        # WHERE ooaoent = g_enterprise
        #   AND ooao001 = l_ooef015
        #   AND ooao002 = l_ooam003
        #   AND ooao003 = g_glaa016
        #   AND ooao004 = l_date
        #IF cl_null(l_ooao011_2) THEN 
        #   LET l_ooao011_2 = 1
        #END IF
        #
        ##本位幣三重評價匯率
        #IF g_glaa021 = '1' THEN 
        #   LET l_ooam003 = sr.nmck100
        #ELSE
        #   LET l_ooam003 = g_glaa001
        #END IF
        #SELECT ooao011 INTO l_ooao011_3 
        #  FROM ooao_t 
        # WHERE ooaoent = g_enterprise
        #   AND ooao001 = l_ooef015
        #   AND ooao002 = l_ooam003
        #   AND ooao003 = g_glaa020
        #   AND ooao004 = l_date
        #IF cl_null(l_ooao011_3) THEN 
        #   LET l_ooao011_3 = 1
        #END IF
        #150824 mark end---
        #150824 add ------
        CALL s_fin_get_exchange_rate(l_tmp.glaald,g_input.yy,g_input.mm,sr.nmck100,l_tmp.glca003) 
             RETURNING l_ooao011,l_ooao011_2,l_ooao011_3
        IF cl_null(l_ooao011) THEN LET l_ooao011 = 0 END IF
        IF cl_null(l_ooao011_2) THEN LET l_ooao011_2 = 0 END IF
        IF cl_null(l_ooao011_3) THEN LET l_ooao011_3 = 0 END IF
        #150824 add end---
        
        
        IF g_input.mm = 1 THEN
           LET l_mm = 12
           LET l_yy = g_input.yy - 1
        ELSE
           LET l_mm = g_input.mm - 1
           LET l_yy = g_input.yy
        END IF
        IF l_mm < 10 THEN
           LET l_date1 = l_yy CLIPPED,'0' CLIPPED,l_mm
        ELSE
           LET l_date1 = l_yy CLIPPED,l_mm 
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
           LET l_ooam003 = sr.nmck100
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
           LET l_ooam003 = sr.nmck100
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
        
        #判斷上期是否有做重評價
        LET l_cnt = 0
        IF g_input.mm = 1 THEN 
           SELECT COUNT(*) INTO l_cnt
             FROM xreb_t
            WHERE xrebent = g_enterprise
              AND xrebld = l_tmp.glaald
              AND xreb001 = g_input.yy - 1
              AND xreb002 = 12 
              AND xreb003 = 'NM'
              AND xreb004 = 'NP'
              AND xreb005 = sr.nmckdocno
              AND xreb006 = 1
              AND xreb007 = 1
        ELSE
           SELECT COUNT(*) INTO l_cnt
             FROM xreb_t
            WHERE xrebent = g_enterprise
              AND xrebld = l_tmp.glaald
              AND xreb001 = g_input.yy
              AND xreb002 = g_input.mm - 1
              AND xreb003 = 'NM'
              AND xreb004 = 'NP'
              AND xreb005 = sr.nmckdocno
              AND xreb006 = 1
              AND xreb007 = 1
        END IF
        
        LET l_flag = ''
        IF l_cnt = 0 THEN 
           LET l_flag = 'N'
        ELSE
           LET l_flag = 'Y'
        END IF
           
        LET l_xreb.xrebent  = g_enterprise
        LET l_xreb.xrebcomp = l_tmp.glaacomp
        LET l_xreb.xrebsite = g_input.ooef001
        LET l_xreb.xrebld   = l_tmp.glaald
        LET l_xreb.xreb001  = g_input.yy
        LET l_xreb.xreb002  = g_input.mm
        LET l_xreb.xreb003  = 'NM'
        LET l_xreb.xreb004  = 'NP'
        LET l_xreb.xreb005  = sr.nmckdocno
        LET l_xreb.xreb006  = 1
        LET l_xreb.xreb007  = 1
        LET l_xreb.xreb008  = sr.nmckdocdt
        LET l_xreb.xreb009  = sr.nmck005
        LET l_xreb.xreb010  = ''
        LET l_xreb.xreb011  = sr.nmbt018
        LET l_xreb.xreb012  = sr.nmbt019
        LET l_xreb.xreb013  = sr.nmbt020
        LET l_xreb.xreb014  = sr.nmbt023
        LET l_xreb.xreb015  = sr.nmbt024
        LET l_xreb.xreb016  = sr.nmbt025
        #2015/02/05---modify---by---qiull---str---
        #LET l_xreb.xreb017  = sr.nmbt026
        #LET l_xreb.xreb018  = sr.nmbt027
        #LET l_xreb.xreb019  = sr.nmbt028
        #LET l_xreb.xreb020  = sr.nmck006
        #LET l_xreb.xreb021  = sr.nmbv001
        #LET l_xreb.xreb022  = ''
        #LET l_xreb.xreb023  = ''
        #LET l_xreb.xreb024  = ''
        LET l_xreb.xreb017  = sr.nmbt027
        LET l_xreb.xreb018  = sr.nmbt028
        #LET l_xreb.xreb019  = sr.nmbt029 #150824 mark
        #150824 add ------
        #依票據單頭票據類別取agli190的票據科目
        SELECT DISTINCT glab006 INTO l_xreb.xreb019
          FROM glab_t
         WHERE glabent = g_enterprise
           AND glabld  = l_tmp.glaald
           AND glab001 = '21'
           AND glab002 = '30'
           AND glab003 = sr.nmck002
        #150824 add end---
        LET l_xreb.xreb020  = sr.nmbt031
        LET l_xreb.xreb021  = sr.nmbt032
        LET l_xreb.xreb022  = sr.nmbt033
        LET l_xreb.xreb023  = sr.nmbt034
        LET l_xreb.xreb024  = sr.nmbt035
        LET l_xreb.xreb025  = sr.nmbt036
        LET l_xreb.xreb026  = sr.nmbt037
        LET l_xreb.xreb027  = sr.nmbt038
        LET l_xreb.xreb028  = sr.nmbt039
        LET l_xreb.xreb029  = sr.nmbt040
        LET l_xreb.xreb030  = sr.nmbt041
        LET l_xreb.xreb031  = sr.nmbt042
        LET l_xreb.xreb032  = sr.nmbt043
        #2015/02/05---modify---by---qiull---end---
        LET l_xreb.xreb100  = sr.nmck100
        LET l_xreb.xreb101  = l_ooao011
        LET l_xreb.xreb103  = sr.nmck103
        IF cl_null(l_xreb.xreb103) THEN LET l_xreb.xreb103 = 0 END IF #150824
        IF l_tmp.glca002 = '2' THEN   #2:期末暫估傳票，次月迴轉。
           LET l_xreb.xreb113 = sr.nmck113
        END IF
        IF l_tmp.glca002 = '3' THEN   #3:重評價傳票，次月不迴轉。
           IF l_flag = 'Y' THEN 
              LET l_xreb.xreb113  = l_xreb.xreb113 * l_ooao011_p
              IF cl_null(l_xreb.xreb113) THEN LET l_xreb.xreb113 = 0 END IF
              CALL s_curr_round_ld('1',l_tmp.glaald,g_glaa001,l_xreb.xreb113,2) RETURNING g_sub_success,g_errno,l_xreb.xreb113 #150824
           ELSE
              LET l_xreb.xreb113  = sr.nmck113
           END IF
        END IF
        IF cl_null(l_xreb.xreb113) THEN LET l_xreb.xreb113 = 0 END IF

        #LET l_xreb.xreb114  = l_xreb.xreb113 * l_xreb.xreb101   #2015/01/16 mark by qiull
        #LET l_xreb.xreb115  = l_xreb.xreb113 - l_xreb.xreb114   #2015/01/16 mark by qiull
        LET l_xreb.xreb114  = l_xreb.xreb103 * l_xreb.xreb101    #2015/01/16 add by qiull
        IF cl_null(l_xreb.xreb114) THEN LET l_xreb.xreb114 = 0 END IF  #150824
        CALL s_curr_round_ld('1',l_tmp.glaald,g_glaa001,l_xreb.xreb114,2) RETURNING g_sub_success,g_errno,l_xreb.xreb114 #150824
        LET l_xreb.xreb115  = l_xreb.xreb114 - l_xreb.xreb113    #2015/01/16 add by qiull
        IF cl_null(l_xreb.xreb115) THEN LET l_xreb.xreb115 = 0 END IF  #150824
        IF l_tmp.glca002 = '2' THEN
           LET l_xreb.xreb116 = l_xreb.xreb115 
        END IF
        IF l_tmp.glca002 = '3' THEN   #3:重評價傳票，次月不迴轉。
           LET l_xreb.xreb116  = l_xreb.xreb115 - l_xreb115
        END IF
        IF cl_null(l_xreb.xreb116) THEN LET l_xreb.xreb116 = 0 END IF  #150824
         
        LET l_xreb.xreb121  = l_ooao011_2
        IF l_tmp.glca002 = '2' THEN   #2:期末暫估傳票，次月迴轉。
           LET l_xreb.xreb123 = sr.nmck123
        END IF
        IF l_tmp.glca002 = '3' THEN   #3:重評價傳票，次月不迴轉。
           IF l_flag = 'Y' THEN 
              LET l_xreb.xreb123  = l_xreb.xreb123 * l_ooao011_p_2
              IF cl_null(l_xreb.xreb123) THEN LET l_xreb.xreb123 = 0 END IF  #150824
              CALL s_curr_round_ld('1',l_tmp.glaald,g_glaa016,l_xreb.xreb123,2) RETURNING g_sub_success,g_errno,l_xreb.xreb123 #150824
           ELSE
              LET l_xreb.xreb123  = sr.nmck123
           END IF
        END IF
        IF cl_null(l_xreb.xreb123) THEN LET l_xreb.xreb123 = 0 END IF  #150824
        LET l_xreb.xreb124  = l_xreb.xreb123 * l_xreb.xreb121
        IF cl_null(l_xreb.xreb124) THEN LET l_xreb.xreb124 = 0 END IF  #150824
        CALL s_curr_round_ld('1',l_tmp.glaald,g_glaa016,l_xreb.xreb124,2) RETURNING g_sub_success,g_errno,l_xreb.xreb124 #150824
        LET l_xreb.xreb125  = l_xreb.xreb124 - l_xreb.xreb123
        IF cl_null(l_xreb.xreb125) THEN LET l_xreb.xreb125 = 0 END IF  #150824
        IF l_tmp.glca002 = '2' THEN   #2:期末暫估傳票，次月迴轉。
           LET l_xreb.xreb126 = l_xreb.xreb125
        END IF
        IF l_tmp.glca002 = '3' THEN   #3:重評價傳票，次月不迴轉。
           LET l_xreb.xreb126 = l_xreb.xreb125 - l_xreb125
        END IF
        IF cl_null(l_xreb.xreb126) THEN LET l_xreb.xreb126 = 0 END IF  #150824
        
        
        LET l_xreb.xreb131  = l_ooao011_3
        IF l_tmp.glca002 = '2' THEN   #2:期末暫估傳票，次月迴轉。
           LET l_xreb.xreb133 = sr.nmck133
        END IF
        
        IF l_tmp.glca002 = '3' THEN   #3:重評價傳票，次月不迴轉。
           IF l_flag = 'Y' THEN 
              LET l_xreb.xreb133  = l_xreb.xreb133 * l_ooao011_p_3
              IF cl_null(l_xreb.xreb133) THEN LET l_xreb.xreb133 = 0 END IF  #150824
              CALL s_curr_round_ld('1',l_tmp.glaald,g_glaa020,l_xreb.xreb133,2) RETURNING g_sub_success,g_errno,l_xreb.xreb133 #150824
           ELSE
              LET l_xreb.xreb133  = sr.nmck133
           END IF
        END IF
        IF cl_null(l_xreb.xreb133) THEN LET l_xreb.xreb133 = 0 END IF  #150824
        LET l_xreb.xreb134  = l_xreb.xreb133 * l_xreb.xreb131
        IF cl_null(l_xreb.xreb134) THEN LET l_xreb.xreb134 = 0 END IF  #150824
        CALL s_curr_round_ld('1',l_tmp.glaald,g_glaa020,l_xreb.xreb134,2) RETURNING g_sub_success,g_errno,l_xreb.xreb134 #150824
        LET l_xreb.xreb135  = l_xreb.xreb134 - l_xreb.xreb133
        IF cl_null(l_xreb.xreb135) THEN LET l_xreb.xreb135 = 0 END IF  #150824
        IF l_tmp.glca002 = '2' THEN
           LET l_xreb.xreb136 = l_xreb.xreb135 
        END IF
        IF l_tmp.glca002 = '3' THEN   #期末暫估傳次月不回轉, 則以跟上月之差額形成傳票
           LET l_xreb.xreb136 = l_xreb.xreb135 - l_xreb135
        END IF
        IF cl_null(l_xreb.xreb136) THEN LET l_xreb.xreb136 = 0 END IF  #150824
        #2015/02/11---add---by---qiull(s)
        CASE
           WHEN l_xreb.xreb115 > 0
                #重評價匯兌損失
                CALL s_fin_get_account(l_xreb.xrebld,'25','8318','8318_12') RETURNING g_sub_success,l_xreb.xreb034,g_errno
           WHEN l_xreb.xreb115 < 0
                #重評價匯兌收益
                CALL s_fin_get_account(l_xreb.xrebld,'25','8318','8318_11') RETURNING g_sub_success,l_xreb.xreb034,g_errno 
        END CASE
        #2015/02/11---add---by---qiull(e)

        #161128-00061#2----modify------begin-----------
        #INSERT INTO xreb_t VALUES(l_xreb.*)
        INSERT INTO xreb_t (xrebent,xrebcomp,xrebsite,xrebld,xreb001,xreb002,xreb003,xreb004,xreb005,xreb006,
                            xreb007,xreb008,xreb009,xreb010,xreb011,xreb012,xreb013,xreb014,xreb015,xreb016,
                            xreb017,xreb018,xreb019,xreborga,xreb020,xreb021,xreb022,xreb023,xreb024,xreb025,
                            xreb026,xreb027,xreb028,xreb029,xreb030,xreb031,xreb032,xreb033,xreb034,xreb100,
                            xreb101,xreb102,xreb103,xreb113,xreb114,xreb115,xreb116,xreb121,xreb122,xreb123,
                            xreb124,xreb125,xreb126,xreb131,xreb132,xreb133,xreb134,xreb135,xreb136)
          VALUES(l_xreb.xrebent,l_xreb.xrebcomp,l_xreb.xrebsite,l_xreb.xrebld,l_xreb.xreb001,l_xreb.xreb002,l_xreb.xreb003,l_xreb.xreb004,l_xreb.xreb005,l_xreb.xreb006,
                 l_xreb.xreb007,l_xreb.xreb008,l_xreb.xreb009,l_xreb.xreb010,l_xreb.xreb011,l_xreb.xreb012,l_xreb.xreb013,l_xreb.xreb014,l_xreb.xreb015,l_xreb.xreb016,
                 l_xreb.xreb017,l_xreb.xreb018,l_xreb.xreb019,l_xreb.xreborga,l_xreb.xreb020,l_xreb.xreb021,l_xreb.xreb022,l_xreb.xreb023,l_xreb.xreb024,l_xreb.xreb025,
                 l_xreb.xreb026,l_xreb.xreb027,l_xreb.xreb028,l_xreb.xreb029,l_xreb.xreb030,l_xreb.xreb031,l_xreb.xreb032,l_xreb.xreb033,l_xreb.xreb034,l_xreb.xreb100,
                 l_xreb.xreb101,l_xreb.xreb102,l_xreb.xreb103,l_xreb.xreb113,l_xreb.xreb114,l_xreb.xreb115,l_xreb.xreb116,l_xreb.xreb121,l_xreb.xreb122,l_xreb.xreb123,
                 l_xreb.xreb124,l_xreb.xreb125,l_xreb.xreb126,l_xreb.xreb131,l_xreb.xreb132,l_xreb.xreb133,l_xreb.xreb134,l_xreb.xreb135,l_xreb.xreb136)
        #161128-00061#2----modify------end-----------
        IF SQLCA.sqlcode THEN
           #CALL cl_errmsg("ins xreb",'','',SQLCA.SQLCODE,1)
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.sqlcode
           LET g_errparam.extend = "ins xreb"
           LET g_errparam.popup = TRUE
           CALL cl_err()
           LET g_success = 'N'       
        END IF
        
        #更新重評價金額  
        UPDATE nmck_t SET nmck114 = l_xreb.xreb114,
                          nmck124 = l_xreb.xreb124,
                          nmck134 = l_xreb.xreb134
         WHERE nmckent = g_enterprise
           AND nmckcomp = l_tmp.glaacomp
           AND nmckdocno = sr.nmckdocno
           
        IF SQLCA.sqlcode THEN
           #CALL cl_errmsg("upd nmbb",'','',SQLCA.SQLCODE,1)
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.sqlcode
           LET g_errparam.extend = "upd nmbb"
           LET g_errparam.popup = TRUE
           CALL cl_err()
           LET g_success = 'N'       
        END IF
      END FOREACH 
      
      #更新月底重評價年度月份
      UPDATE glca_t SET glca006 = g_input.yy,
                        glca007 = g_input.mm
       WHERE glcaent = g_enterprise
         AND glcald = l_tmp.glaald
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
PRIVATE FUNCTION anmp811_get_ooef001_wc(p_wc)
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
 
