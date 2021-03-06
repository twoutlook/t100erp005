#該程式未解開Section, 採用最新樣板產出!
{<section id="anmp810.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0012(2014-08-15 15:40:42), PR版次:0012(2017-01-18 12:26:38)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000128
#+ Filename...: anmp810
#+ Description: 銀行自動調匯作業
#+ Creator....: 02114(2014-08-13 00:00:00)
#+ Modifier...: 02114 -SD/PR- 01531
 
{</section>}
 
{<section id="anmp810.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#150817-00025#1   2015/08/18 By Reanna   Bug調整
#151002           2015/10/02 By albireo  kris:僅用本期月結檔當作抓取帳戶資料條件有漏資料,改以同法人的anmi120帳戶範為當作條件改寫
#151222-00010#11  2015/12/24 By yangtt   在插入到nmde表之前，所有的金额字段要截位
#150813-00015#38  2016/01/19 By 02599    增加账务中心、年度、期别栏位检查，年度+期别不可小于关帐日期年度+期别
#160318-00025#39  2016/04/22 By pengxin  將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160513-00008#2   2016/05/13 By 02599    根據agli171中銀行存款(NM)的外幣重評價設定的重評方式：
#                                        2.迴轉：產生二筆銀存異動明細(nmbc)；期末調匯數、下一期的迴轉數
#                                        3.不迴轉：產生一筆銀存異動明細(nmbc)；期末調匯數
#160531-00014#1   2016/05/31 By Dido     改用 nmde106/nmde116/nmde126 給予 nmbc113/nmbc123/nmbc133
#160125-00005#8   2016/08/08 By 02599    帳套增加人員權限條件過濾
#161013-00052#1   2016/10/19 By 02599    調匯金額nmbc時, 應統一取nmde105,非nmde106
#161021-00050#1   2016/10/24 By 08729    處理組織開窗
#161027-00004#1   2016/10/27 By 01531   【累计提列金额】计算错误
#161027-00052#1   2016/10/28 By 01531    累计提列数,取上期数，应该取nmde106,nmde116,nmde126 
#161128-00061#2   2016/11/29 by 02481    标准程式定义采用宣告模式,弃用.*写法
#170118-00019#1   2017/01/18 By 01531    anmp810 銀存調匯作業, 若取不到設定的存提碼, 就報錯不處理
#                                        期初回轉，金額反向處理
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
     nmde017         LIKE nmde_t.nmde017
     END RECORD
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"
DEFINE g_input type_parameter
DEFINE g_glaa001             LIKE glaa_t.glaa001
DEFINE g_glaa002             LIKE glaa_t.glaa002    
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
DEFINE g_glaa026             LIKE glaa_t.glaa026
DEFINE g_rec_b               LIKE type_t.num5
#end add-point
 
{</section>}
 
{<section id="anmp810.main" >}
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
      OPEN WINDOW w_anmp810 WITH FORM cl_ap_formpath("anm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL anmp810_init()   
 
      #進入選單 Menu (="N")
      CALL anmp810_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_anmp810
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   DROP TABLE anmp810_tmp;
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="anmp810.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION anmp810_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   CALL anmp810_set_combo_scc("yy","43")
   CALL anmp810_set_combo_scc("mm","39")
   CALL cl_set_combo_scc("glca002","8317")
   CALL cl_set_combo_scc("glca003","40")     #150817-00025#1 mark
   CALL cl_set_combo_scc("glca003","8724")   #150817-00025#1
   CALL s_fin_create_account_center_tmp()    #160125-00005#8 
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="anmp810.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION anmp810_ui_dialog()
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
   DEFINE l_clo_date      LIKE type_t.dat        #150813-00015#38 add
   DEFINE l_success       LIKE type_t.num5       #150813-00015#38 add
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
         CALL anmp810_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT BY NAME g_input.ooef001,g_input.ooef001_desc,
                       g_input.yy,g_input.mm
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
            
            AFTER FIELD ooef001
               #150813-00015#38--add--str--
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
               #150813-00015#38--add--end
            #2015/01/23---add---by---qiull(s)
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_input.ooef001
               CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_input.ooef001_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_input.ooef001_desc
               
            #150813-00015#38--add--str--
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
            #150813-00015#38--add--end
            
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
               CALL anmp810_fetch()              
               
            ON CHANGE sel
               #已拋總帳的不可勾選執行重評價
               IF NOT cl_null(g_detail_d[l_ac].nmde017) THEN 
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
               
               UPDATE anmp810_tmp 
                  SET sel = g_detail_d[l_ac].sel 
                WHERE glaald = g_detail_d[l_ac].glaald 
                
               SELECT sel INTO l_sel 
                 FROM anmp810_tmp
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
               IF NOT cl_null(g_detail_d[li_idx].nmde017) THEN 
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
                  IF NOT cl_null(g_detail_d[li_idx].nmde017) THEN 
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
            CALL anmp810_filter()
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
            CALL anmp810_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL anmp810_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            SELECT COUNT(*) INTO l_n
              FROM anmp810_tmp
             WHERE sel = 'Y'
            IF l_n = 0 THEN 
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "" 
               LET g_errparam.code   = 'axr-00159' 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               
               EXIT DIALOG
            END IF
            
            CALL anmp810_nm()

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
 
{<section id="anmp810.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION anmp810_query()
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
   CALL anmp810_b_fill()
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
 
{<section id="anmp810.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION anmp810_b_fill()
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
   CALL anmp810_create_tmp() RETURNING l_success
   DELETE FROM anmp810_tmp
   LET g_sql = "SELECT DISTINCT 'N',glaald,'',glaacomp,'','','','','',glaa001,'','',nmde017 FROM glaa_t ",
               "  LEFT OUTER JOIN nmde_t ON nmdeent = glaaent ",
               "   AND nmdeld = glaald ",
               "   AND nmde001 = '",g_input.yy,"'",
               "   AND nmde002 = '",g_input.mm,"'",
               "   AND nmde003 = 'NM' ",
               " WHERE glaaent = ? "
#160125-00005#8--add--str--
   #取得帳務組織下所屬成員
   CALL s_fin_account_center_sons_query('3',g_input.ooef001,g_today,'1')
   #取得帳務組織下所屬成員之帳別
   CALL s_fin_account_center_comp_str() RETURNING ls_wc
   #將取回的字串轉換為SQL條件
   CALL anmp810_get_ooef001_wc(ls_wc) RETURNING ls_wc 
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
#   CALL anmp810_get_ooef001_wc(ls_wc) RETURNING ls_wc  
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
#     #查出有權限的帳套   
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
 
   PREPARE anmp810_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR anmp810_sel
   
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
      CALL anmp810_glaald_desc()
      
      SELECT glaa003 INTO l_glaa003
        FROM glaa_t
       WHERE glaaent = g_enterprise
         AND glaald = g_detail_d[l_ac].glaald
      
      CALL cl_get_para(g_enterprise,g_detail_d[l_ac].glaacomp,'S-FIN-4007') RETURNING l_ooab002
      
      #150825 mark ------
      #LET l_yy = YEAR(l_ooab002)
      #LET l_mm = MONTH(l_ooab002)
      #IF l_mm = '12' THEN 
      #   LET g_detail_d[l_ac].b_yy = l_yy + 1
      #   LET g_detail_d[l_ac].b_mm = 1
      #ELSE
      #   LET g_detail_d[l_ac].b_yy = l_yy
      #   LET g_detail_d[l_ac].b_mm = l_mm + 1
      #END IF
      #150825 mark end---
      #150825 add ------
      LET g_detail_d[l_ac].b_yy = g_input.yy
      LET g_detail_d[l_ac].b_mm = g_input.mm
      #150825 add ------
      
      #獲取當前年度期別的第一天和最後一天
      CALL s_get_accdate(l_glaa003,'',g_detail_d[l_ac].b_yy,g_detail_d[l_ac].b_mm)
      RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e    

      LET g_detail_d[l_ac].b_date = l_pdate_s
      LET g_detail_d[l_ac].e_date = l_pdate_e

      SELECT glca002,glca003 INTO g_detail_d[l_ac].glca002,g_detail_d[l_ac].glca003 
        FROM glca_t
       WHERE glcaent = g_enterprise
         AND glcald = g_detail_d[l_ac].glaald
         AND glca001 = 'NM'
 
      INSERT INTO anmp810_tmp VALUES(g_detail_d[l_ac].*)
      #end add-point
      
      CALL anmp810_detail_show()      
 
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
   FREE anmp810_sel
   
   LET l_ac = 1
   CALL anmp810_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="anmp810.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION anmp810_fetch()
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
 
{<section id="anmp810.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION anmp810_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="anmp810.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION anmp810_filter()
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
   
   CALL anmp810_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="anmp810.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION anmp810_filter_parser(ps_field)
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
 
{<section id="anmp810.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION anmp810_filter_show(ps_field,ps_object)
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
   LET ls_condition = anmp810_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="anmp810.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"
# 年度,月份
PRIVATE FUNCTION anmp810_set_combo_scc(p_field,p_scc)
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
PRIVATE FUNCTION anmp810_glaald_desc()
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
PRIVATE FUNCTION anmp810_get_date()
   
END FUNCTION
# 創建臨時表
PRIVATE FUNCTION anmp810_create_tmp()
   DEFINE r_success       LIKE type_t.num5
   
   WHENEVER ERROR CONTINUE
   LET r_success = FALSE
   
   DROP TABLE anmp810_tmp;
   CREATE TEMP TABLE anmp810_tmp(
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
#     glaa002         LIKE glaa_t.glaa002,  #160513-00008#2 mark
     glca002          VARCHAR(10),        #160513-00008#2 add
     glca003          VARCHAR(10),
     nmde017          VARCHAR(20)
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
PRIVATE FUNCTION anmp810_nm()
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
   DEFINE l_amt1          LIKE nmbb_t.nmbb008    #上期原幣結存
   DEFINE l_amt2          LIKE nmbb_t.nmbb008    #上期本幣結存
   DEFINE l_amt3          LIKE nmbb_t.nmbb008    #上期本位幣二結存
   DEFINE l_amt4          LIKE nmbb_t.nmbb008    #上期本位幣三結存
   DEFINE l_ooao011       LIKE ooao_t.ooao011    #重評價匯率
   DEFINE l_ooao011_2     LIKE ooao_t.ooao011    #本位幣二重評價匯率
   DEFINE l_ooao011_3     LIKE ooao_t.ooao011    #本位幣三重評價匯率
   DEFINE l_ooef015       LIKE ooef_t.ooef015    #法人所使用匯率參照表
   DEFINE l_nmde105       LIKE nmde_t.nmde105    #上期匯差金額
   DEFINE l_nmde115       LIKE nmde_t.nmde115    #本位幣二上期匯差金額
   DEFINE l_nmde125       LIKE nmde_t.nmde125    #本位幣三上期匯差金額
   DEFINE l_glab005       LIKE glab_t.glab005    #会计科目
   DEFINE l_ooam003       LIKE ooam_t.ooam003    #基礎幣別
   DEFINE l_date          LIKE type_t.chr10      #年月 值如201405,前面4碼是西元年,後面2碼是月份
   DEFINE l_nmaa002       LIKE nmaa_t.nmaa002    #開戶組織
   DEFINE l_nmas001       LIKE nmas_t.nmas001    #帳戶編碼
   #161128-00061#2----modify------begin-----------
   #DEFINE l_nmde          RECORD LIKE nmde_t.*
   #DEFINE l_nmbx          RECORD LIKE nmbx_t.*  
    DEFINE l_nmde RECORD  #銀行重評價檔
       nmdeent LIKE nmde_t.nmdeent, #企業編號
       nmdecomp LIKE nmde_t.nmdecomp, #法人
       nmdeld LIKE nmde_t.nmdeld, #帳套
       nmdesite LIKE nmde_t.nmdesite, #帳務中心
       nmde001 LIKE nmde_t.nmde001, #年度
       nmde002 LIKE nmde_t.nmde002, #期別
       nmde003 LIKE nmde_t.nmde003, #來源模組
       nmde004 LIKE nmde_t.nmde004, #銀行帳戶
       nmde005 LIKE nmde_t.nmde005, #開戶組織
       nmde006 LIKE nmde_t.nmde006, #部門
       nmde007 LIKE nmde_t.nmde007, #責任中心
       nmde008 LIKE nmde_t.nmde008, #區域
       nmde009 LIKE nmde_t.nmde009, #客群
       nmde010 LIKE nmde_t.nmde010, #產品類別
       nmde011 LIKE nmde_t.nmde011, #人員
       nmde012 LIKE nmde_t.nmde012, #預算編號
       nmde013 LIKE nmde_t.nmde013, #專案編號
       nmde014 LIKE nmde_t.nmde014, #WBS編號
       nmde015 LIKE nmde_t.nmde015, #會計科目
       nmde017 LIKE nmde_t.nmde017, #傳票號碼
       nmde100 LIKE nmde_t.nmde100, #幣別
       nmde101 LIKE nmde_t.nmde101, #重評價匯率
       nmde102 LIKE nmde_t.nmde102, #本期原幣未沖金額
       nmde103 LIKE nmde_t.nmde103, #本期本幣未沖金額
       nmde104 LIKE nmde_t.nmde104, #本期重評價後本幣金額
       nmde105 LIKE nmde_t.nmde105, #本期匯差金額
       nmde106 LIKE nmde_t.nmde106, #本期匯差傳票提列金額
       nmde111 LIKE nmde_t.nmde111, #本位幣二重評價匯率
       nmde113 LIKE nmde_t.nmde113, #本期本位幣二未沖金額
       nmde114 LIKE nmde_t.nmde114, #本期本位幣二重評價後金額
       nmde115 LIKE nmde_t.nmde115, #本期本位幣二匯差金額
       nmde116 LIKE nmde_t.nmde116, #本期本位幣二匯差傳票提列提列金額
       nmde121 LIKE nmde_t.nmde121, #本位幣三重評價匯率
       nmde123 LIKE nmde_t.nmde123, #本期本位幣三未沖金額
       nmde124 LIKE nmde_t.nmde124, #本期本位幣三重評價後金額
       nmde125 LIKE nmde_t.nmde125, #本期本位幣三匯差金額
       nmde126 LIKE nmde_t.nmde126, #本期本位幣三匯差傳票提列提列金額
       nmdedocno LIKE nmde_t.nmdedocno, #單據編號
       nmdedocdt LIKE nmde_t.nmdedocdt, #單據日期 
       nmde018 LIKE nmde_t.nmde018, #收付款客商
       nmde019 LIKE nmde_t.nmde019, #帳款客商
       nmde020 LIKE nmde_t.nmde020, #經營方式
       nmde021 LIKE nmde_t.nmde021, #通路
       nmde022 LIKE nmde_t.nmde022, #品牌
       nmde023 LIKE nmde_t.nmde023, #自由核算項一
       nmde024 LIKE nmde_t.nmde024, #自由核算項二
       nmde025 LIKE nmde_t.nmde025, #自由核算項三
       nmde026 LIKE nmde_t.nmde026, #自由核算項四
       nmde027 LIKE nmde_t.nmde027, #自由核算項五
       nmde028 LIKE nmde_t.nmde028, #自由核算項六
       nmde029 LIKE nmde_t.nmde029, #自由核算項七
       nmde030 LIKE nmde_t.nmde030, #自由核算項八
       nmde031 LIKE nmde_t.nmde031, #自由核算項九
       nmde032 LIKE nmde_t.nmde032, #自由核算項十
       nmde033 LIKE nmde_t.nmde033  #摘要
       END RECORD
   
   DEFINE l_nmbx RECORD  #企業帳戶月結統計資料檔
       nmbxent LIKE nmbx_t.nmbxent, #企業編碼
       nmbxcomp LIKE nmbx_t.nmbxcomp, #法人
       nmbx001 LIKE nmbx_t.nmbx001, #年度
       nmbx002 LIKE nmbx_t.nmbx002, #月份
       nmbx003 LIKE nmbx_t.nmbx003, #交易帳戶編碼
       nmbx100 LIKE nmbx_t.nmbx100, #交易帳戶幣別
       nmbx103 LIKE nmbx_t.nmbx103, #原幣存入金額
       nmbx104 LIKE nmbx_t.nmbx104, #原幣提出金額
       nmbx113 LIKE nmbx_t.nmbx113, #本幣存入金額
       nmbx114 LIKE nmbx_t.nmbx114, #本幣提出金額
       nmbx123 LIKE nmbx_t.nmbx123, #本位幣二存入金額
       nmbx124 LIKE nmbx_t.nmbx124, #本位幣二提出金額
       nmbx133 LIKE nmbx_t.nmbx133, #本位幣三存入金額
       nmbx134 LIKE nmbx_t.nmbx134, #本位幣三提出金額
       nmbxownid LIKE nmbx_t.nmbxownid, #資料所有者
       nmbxowndp LIKE nmbx_t.nmbxowndp, #資料所屬部門
       nmbxcrtid LIKE nmbx_t.nmbxcrtid, #資料建立者
       nmbxcrtdp LIKE nmbx_t.nmbxcrtdp, #資料建立部門
       nmbxcrtdt LIKE nmbx_t.nmbxcrtdt, #資料創建日
       nmbxmodid LIKE nmbx_t.nmbxmodid, #資料修改者
       nmbxmoddt LIKE nmbx_t.nmbxmoddt, #最近修改日
       nmbxcnfid LIKE nmbx_t.nmbxcnfid, #資料確認者
       nmbxcnfdt LIKE nmbx_t.nmbxcnfdt, #資料確認日
       nmbxpstid LIKE nmbx_t.nmbxpstid, #資料過帳者
       nmbxpstdt LIKE nmbx_t.nmbxpstdt, #資料過帳日
       nmbxstus LIKE nmbx_t.nmbxstus, #狀態碼
       nmbxorga LIKE nmbx_t.nmbxorga  #來源組織
       END RECORD

   #161128-00061#2----modify------end-----------   
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
                          nmde017         LIKE nmde_t.nmde017 
                          END RECORD
   DEFINE l_ooef005       LIKE ooef_t.ooef005
   DEFINE l_nmdeld        STRING
   DEFINE l_nmde001       STRING
   DEFINE l_nmde002       STRING   
   DEFINE l_ooaj004       LIKE ooaj_t.ooaj004
   DEFINE l_ooaj0042      LIKE ooaj_t.ooaj004
   DEFINE l_ooaj0043      LIKE ooaj_t.ooaj004  

   #albireo 151002-----s
   DEFINE l_nmas002       LIKE nmas_t.nmas002   
   DEFINE l_nmas003       LIKE nmas_t.nmas003   
   #albireo 151002-----e
   #160513-00008#2--add--str--
  #161128-00061#2----modify------begin----------- 
  #DEFINE l_nmbc          RECORD LIKE nmbc_t.*
  #DEFINE l_nmbc_n        RECORD LIKE nmbc_t.*
   DEFINE l_nmbc RECORD  #銀存收支異動檔
       nmbcent LIKE nmbc_t.nmbcent, #企業編號
       nmbcownid LIKE nmbc_t.nmbcownid, #資料所有者
       nmbcowndp LIKE nmbc_t.nmbcowndp, #資料所屬部門
       nmbccrtid LIKE nmbc_t.nmbccrtid, #資料建立者
       nmbccrtdp LIKE nmbc_t.nmbccrtdp, #資料建立部門
       nmbccrtdt LIKE nmbc_t.nmbccrtdt, #資料創建日
       nmbcmodid LIKE nmbc_t.nmbcmodid, #資料修改者
       nmbcmoddt LIKE nmbc_t.nmbcmoddt, #最近修改日
       nmbccnfid LIKE nmbc_t.nmbccnfid, #資料確認者
       nmbccnfdt LIKE nmbc_t.nmbccnfdt, #資料確認日
       nmbcpstid LIKE nmbc_t.nmbcpstid, #資料過帳者
       nmbcpstdt LIKE nmbc_t.nmbcpstdt, #資料過帳日
       nmbcstus LIKE nmbc_t.nmbcstus, #狀態碼
       nmbccomp LIKE nmbc_t.nmbccomp, #法人
       nmbcsite LIKE nmbc_t.nmbcsite, #資金中心
       nmbcdocno LIKE nmbc_t.nmbcdocno, #來源單號
       nmbcseq LIKE nmbc_t.nmbcseq, #項次
       nmbc001 LIKE nmbc_t.nmbc001, #單據來源
       nmbc002 LIKE nmbc_t.nmbc002, #交易帳戶編碼
       nmbc003 LIKE nmbc_t.nmbc003, #交易對象
       nmbc004 LIKE nmbc_t.nmbc004, #交易對象識別碼
       nmbc005 LIKE nmbc_t.nmbc005, #銀行日期
       nmbc006 LIKE nmbc_t.nmbc006, #異動別
       nmbc007 LIKE nmbc_t.nmbc007, #存提碼
       nmbc008 LIKE nmbc_t.nmbc008, #調節碼
       nmbc009 LIKE nmbc_t.nmbc009, #對帳碼
       nmbc010 LIKE nmbc_t.nmbc010, #網銀媒體檔轉出日期
       nmbc011 LIKE nmbc_t.nmbc011, #網銀媒體檔轉出批號
       nmbc100 LIKE nmbc_t.nmbc100, #交易帳戶幣別
       nmbc101 LIKE nmbc_t.nmbc101, #主帳套匯率
       nmbc103 LIKE nmbc_t.nmbc103, #主帳套原幣金額
       nmbc113 LIKE nmbc_t.nmbc113, #主帳套本幣金額
       nmbc121 LIKE nmbc_t.nmbc121, #主帳套本位幣二匯率
       nmbc123 LIKE nmbc_t.nmbc123, #主帳套本位幣二金額
       nmbc131 LIKE nmbc_t.nmbc131, #主帳套本位幣三匯率
       nmbc133 LIKE nmbc_t.nmbc133, #主帳套本位幣三金額
       nmbc012 LIKE nmbc_t.nmbc012, #票據號碼
       nmbc013 LIKE nmbc_t.nmbc013, #款別
       nmbc014 LIKE nmbc_t.nmbc014, #到期日
       nmbc015 LIKE nmbc_t.nmbc015, #匯入銀行編號
       nmbc016 LIKE nmbc_t.nmbc016, #匯入帳號
       nmbc017 LIKE nmbc_t.nmbc017, #受款人全名
       nmbcorga LIKE nmbc_t.nmbcorga  #來源組織
       END RECORD
   DEFINE l_nmbc_n RECORD  #銀存收支異動檔
       nmbcent LIKE nmbc_t.nmbcent, #企業編號
       nmbcownid LIKE nmbc_t.nmbcownid, #資料所有者
       nmbcowndp LIKE nmbc_t.nmbcowndp, #資料所屬部門
       nmbccrtid LIKE nmbc_t.nmbccrtid, #資料建立者
       nmbccrtdp LIKE nmbc_t.nmbccrtdp, #資料建立部門
       nmbccrtdt LIKE nmbc_t.nmbccrtdt, #資料創建日
       nmbcmodid LIKE nmbc_t.nmbcmodid, #資料修改者
       nmbcmoddt LIKE nmbc_t.nmbcmoddt, #最近修改日
       nmbccnfid LIKE nmbc_t.nmbccnfid, #資料確認者
       nmbccnfdt LIKE nmbc_t.nmbccnfdt, #資料確認日
       nmbcpstid LIKE nmbc_t.nmbcpstid, #資料過帳者
       nmbcpstdt LIKE nmbc_t.nmbcpstdt, #資料過帳日
       nmbcstus LIKE nmbc_t.nmbcstus, #狀態碼
       nmbccomp LIKE nmbc_t.nmbccomp, #法人
       nmbcsite LIKE nmbc_t.nmbcsite, #資金中心
       nmbcdocno LIKE nmbc_t.nmbcdocno, #來源單號
       nmbcseq LIKE nmbc_t.nmbcseq, #項次
       nmbc001 LIKE nmbc_t.nmbc001, #單據來源
       nmbc002 LIKE nmbc_t.nmbc002, #交易帳戶編碼
       nmbc003 LIKE nmbc_t.nmbc003, #交易對象
       nmbc004 LIKE nmbc_t.nmbc004, #交易對象識別碼
       nmbc005 LIKE nmbc_t.nmbc005, #銀行日期
       nmbc006 LIKE nmbc_t.nmbc006, #異動別
       nmbc007 LIKE nmbc_t.nmbc007, #存提碼
       nmbc008 LIKE nmbc_t.nmbc008, #調節碼
       nmbc009 LIKE nmbc_t.nmbc009, #對帳碼
       nmbc010 LIKE nmbc_t.nmbc010, #網銀媒體檔轉出日期
       nmbc011 LIKE nmbc_t.nmbc011, #網銀媒體檔轉出批號
       nmbc100 LIKE nmbc_t.nmbc100, #交易帳戶幣別
       nmbc101 LIKE nmbc_t.nmbc101, #主帳套匯率
       nmbc103 LIKE nmbc_t.nmbc103, #主帳套原幣金額
       nmbc113 LIKE nmbc_t.nmbc113, #主帳套本幣金額
       nmbc121 LIKE nmbc_t.nmbc121, #主帳套本位幣二匯率
       nmbc123 LIKE nmbc_t.nmbc123, #主帳套本位幣二金額
       nmbc131 LIKE nmbc_t.nmbc131, #主帳套本位幣三匯率
       nmbc133 LIKE nmbc_t.nmbc133, #主帳套本位幣三金額
       nmbc012 LIKE nmbc_t.nmbc012, #票據號碼
       nmbc013 LIKE nmbc_t.nmbc013, #款別
       nmbc014 LIKE nmbc_t.nmbc014, #到期日
       nmbc015 LIKE nmbc_t.nmbc015, #匯入銀行編號
       nmbc016 LIKE nmbc_t.nmbc016, #匯入帳號
       nmbc017 LIKE nmbc_t.nmbc017, #受款人全名
       nmbcorga LIKE nmbc_t.nmbcorga  #來源組織
       END RECORD
       
  #161128-00061#2----modify------begin-----------
   DEFINE l_nmbcdocno_n   LIKE nmbc_t.nmbcdocno
   DEFINE l_nmbc005_n     LIKE nmbc_t.nmbc005
   DEFINE l_max_period    LIKE glav_t.glav006
   DEFINE l_nmbcseq       LIKE nmbc_t.nmbcseq
   #160513-00008#2--add--end
   
   CALL s_transaction_begin()
   #CALL cl_showmsg_init()
   LET g_success = 'Y'
   
   #檢查是否已拋轉總帳
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM nmde_t
    WHERE nmdeent = g_enterprise
      AND nmdeld IN (SELECT glaald FROM anmp810_tmp WHERE sel = 'Y')
      AND nmde001 = g_input.yy
      AND nmde002 = g_input.mm
      AND nmde003 = 'NM' 
      AND nmde017 IS NOT NULL
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
     FROM nmde_t
    WHERE nmdeent = g_enterprise
      AND nmdeld IN (SELECT glaald FROM anmp810_tmp WHERE sel = 'Y')
      AND nmde003 = 'NM' 
      AND (nmde001 > g_input.yy OR (nmde001 = g_input.yy AND nmde002 > g_input.mm))
   IF l_cnt > 0 THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'anm-00218'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN 
   END IF
   
   CALL cl_err_collect_init()
   #還原月底重評價年度月份
   UPDATE glca_t SET glca006 = '',
                     glca007 = ''
    WHERE glcaent = g_enterprise
      AND glcald IN (SELECT glaald FROM anmp810_tmp WHERE sel = 'Y')
      AND glca001 = 'NM'
      
   IF SQLCA.sqlcode THEN
      #CALL cl_errmsg("upd glca",'','',SQLCA.SQLCODE,1)
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.extend = "upd glca"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = 'N'       
   END IF
   
   #還原
   DELETE FROM nmde_t WHERE nmdeent = g_enterprise
                        AND nmdeld IN (SELECT glaald FROM anmp810_tmp WHERE sel = 'Y') 
                        AND nmde001 = g_input.yy
                        AND nmde002 = g_input.mm
                        AND nmde003 = 'NM' 
   IF SQLCA.sqlcode THEN
      #CALL cl_errmsg("del xreb",'','',SQLCA.SQLCODE,1)
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.extend = "del xreb"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = 'N'       
   END IF
   
   #160513-00008#2--add--str--
   INITIALIZE l_nmbc.* TO NULL
   LET l_nmbc.nmbcent=g_enterprise
   LET l_nmbc.nmbcownid=g_user
   LET l_nmbc.nmbcowndp=g_dept
   LET l_nmbc.nmbccrtid=g_user
   LET l_nmbc.nmbccrtdp=g_dept
   LET l_nmbc.nmbccrtdt=g_today
   LET l_nmbc.nmbccnfid=g_user
   LET l_nmbc.nmbccnfdt=g_today
   LET l_nmbc.nmbcpstid=g_today
   LET l_nmbc.nmbcpstdt=g_today
   LET l_nmbc.nmbcstus='Y'
   LET l_nmbc.nmbc001='anmt820'  #單據來源
   LET l_nmbc.nmbc006='1'        #異動別1.存入
   LET l_nmbc.nmbc009='N'        #對帳碼
   #160513-00008#2--add--end
   
   LET g_sql = "SELECT * FROM anmp810_tmp ",
               " WHERE sel = 'Y' "
   PREPARE anmp810_tmp_pre FROM g_sql 
   DECLARE anmp810_tmp_cur CURSOR FOR anmp810_tmp_pre
   FOREACH anmp810_tmp_cur INTO l_tmp.*   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
      
         EXIT FOREACH
      END IF
      
      SELECT glaa001,glaa002,glaa003,glaa005,glaa004,glaa008,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa026 
        INTO g_glaa001,g_glaa002,g_glaa003,g_glaa005,g_glaa004,g_glaa008,g_glaa014,g_glaa015,
             g_glaa016,g_glaa017,g_glaa018,g_glaa019,g_glaa020,g_glaa021,g_glaa022,g_glaa026 
        FROM glaa_t
       WHERE glaaent = g_enterprise
         AND glaald = l_tmp.glaald
         
      #獲取當前年度期別的第一天和最後一天
      CALL s_get_accdate(g_glaa003,'',g_input.yy,g_input.mm)
      RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e    
 
      #160513-00008#2--add--str--
      #回轉或不回轉：刪除期末調匯數
      IF g_glaa014='Y' AND (l_tmp.glca002 = '2' OR l_tmp.glca002 ='3') THEN
         LET l_nmbc.nmbcdocno="NM",g_input.yy USING "&&&&",g_input.mm USING "&&","%" 
         DELETE FROM nmbc_t 
          WHERE nmbcent=g_enterprise AND nmbccomp=l_tmp.glaacomp
            AND nmbcdocno LIKE l_nmbc.nmbcdocno
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.extend = "delete nmbc_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N'       
         END IF
            
         LET l_nmbc.nmbccomp=l_tmp.glaacomp #法人
         #单号
         LET l_nmbc.nmbcdocno="NM",g_input.yy USING "&&&&",g_input.mm USING "&&","E"
         #銀行日:期末最後一天
         SELECT MAX(glav004) INTO l_nmbc.nmbc005 FROM glav_t
          WHERE glavent=g_enterprise AND glav001=g_glaa003 
            AND glav002=g_input.yy AND glav006=g_input.mm
         #存提碼
         SELECT glab005 INTO l_nmbc.nmbc007 FROM glab_t
          WHERE glabent=g_enterprise AND glab001='25'
            AND glab002='8318' AND glab003='8318_13'
            AND glabld=l_tmp.glaald #170118-00019#1 add
         #170118-00019#1 add s---
         IF cl_null(l_nmbc.nmbc007) THEN 
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'anm-03045'
            LET g_errparam.extend = l_tmp.glaald
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N'            
         END IF
         #170118-00019#1 add e---         
         #項次
         LET l_nmbcseq = 0 
         SELECT MAX(nmbcseq) INTO l_nmbcseq FROM nmbc_t 
          WHERE nmbcent=g_enterprise AND nmbccomp=l_tmp.glaacomp 
            AND nmbcdocno LIKE l_nmbc.nmbcdocno
         IF cl_null(l_nmbcseq) THEN
            LET l_nmbcseq = 0 
         END IF
      END IF
      #回轉：刪除下一期的迴轉數
      IF g_glaa014='Y' AND l_tmp.glca002 = '2' THEN
         #单号
         LET l_nmbcdocno_n="NM",g_input.yy USING "&&&&",g_input.mm USING "&&","S"
         #銀行日：下一期第一天
         SELECT MAX(glav006) INTO l_max_period FROM glav_t
          WHERE glavent=g_enterprise AND glav001=g_glaa003 AND glav002=g_input.yy
         IF g_input.mm = l_max_period THEN #下一年的第一天
            SELECT MIN(glav004) INTO l_nmbc005_n FROM glav_t
             WHERE glavent=g_enterprise AND glav001=g_glaa003 
               AND glav002=g_input.yy+1 AND glav006=1
         ELSE
            #下一期的第一天
            SELECT MIN(glav004) INTO l_nmbc005_n FROM glav_t
             WHERE glavent=g_enterprise AND glav001=g_glaa003 
               AND glav002=g_input.yy AND glav006=g_input.mm+1
         END IF
      END IF
      
      
      #160513-00008#2--add--end
 
      LET l_cnt = 0
#      #albireo 151002 mark-----s
#      LET g_sql = "SELECT * FROM nmbx_t ",
#                  " WHERE nmbxent  = '",g_enterprise,"'",
#                  "   AND nmbxcomp = '",l_tmp.glaacomp,"'",
#                  "   AND nmbx001  = '",g_input.yy,"'",
#                  "   AND nmbx002  = '",g_input.mm,"'"       
#               
#      PREPARE p811_pre1 FROM g_sql  
#      DECLARE p811_curs1 CURSOR FOR p811_pre1
#      
#      FOREACH p811_curs1 INTO l_nmbx.*
#         IF SQLCA.sqlcode THEN
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.code = SQLCA.sqlcode
#            LET g_errparam.extend = "FOREACH:"
#            LET g_errparam.popup = TRUE
#            CALL cl_err()
#      
#            EXIT FOREACH
#         END IF
#         
#         #150825 add ------
#         #幣別一樣不用重評價
#         IF g_glaa001 = l_nmbx.nmbx100 THEN
#            CONTINUE FOREACH
#         END IF
#         #150825 add end---
#         
#         #抓取上期結存
#         SELECT SUM(nmbx103-nmbx104),SUM(nmbx113-nmbx114),SUM(nmbx123-nmbx124),SUM(nmbx133-nmbx134)
#           INTO l_amt1,l_amt2,l_amt3,l_amt4
#           FROM nmbx_t
#          WHERE nmbxent  = g_enterprise
#            AND nmbxcomp = l_tmp.glaacomp
#            AND nmbx001  = g_input.yy
#            AND nmbx002  < g_input.mm
#            AND nmbx003  = l_nmbx.nmbx003       
#         
#         IF cl_null(l_amt1) THEN LET l_amt1 = 0 END IF
#         IF cl_null(l_amt2) THEN LET l_amt2 = 0 END IF  
#         IF cl_null(l_amt3) THEN LET l_amt3 = 0 END IF
#         IF cl_null(l_amt4) THEN LET l_amt4 = 0 END IF
#        
#         #会计科目        
#         SELECT glab005 INTO l_glab005 
#           FROM glab_t
#          WHERE glabent = g_enterprise 
#            AND glabld  = l_tmp.glaald
#            AND glab001 = '40'
#            AND glab002 = '40'     
#            AND glab003 = l_nmbx.nmbx003  #交易帳戶編號
#         
#        
#         #上期會差金額
#         IF g_input.mm = 1 THEN 
#            SELECT nmde105,nmde115,nmde125 INTO l_nmde105,l_nmde115,l_nmde125
#              FROM nmde_t
#             WHERE nmdeent = g_enterprise
#               AND nmdeld = l_tmp.glaald
#               AND nmde001 = g_input.yy - 1
#               AND nmde002 = 12 
#               AND nmde003 = 'NM'
#         ELSE
#            SELECT nmde105,nmde115,nmde125 INTO l_nmde105,l_nmde115,l_nmde125
#              FROM nmde_t
#             WHERE nmdeent = g_enterprise
#               AND nmdeld = l_tmp.glaald
#               AND nmde001 = g_input.yy
#               AND nmde002 = g_input.mm - 1
#               AND nmde003 = 'NM'
#         END IF
#         
#         IF cl_null(l_nmde105) THEN LET l_nmde105 = 0 END IF
#         IF cl_null(l_nmde115) THEN LET l_nmde115 = 0 END IF
#         IF cl_null(l_nmde125) THEN LET l_nmde125 = 0 END IF
#          
#         
#         IF g_input.mm < 10 THEN         
#            LET l_date = g_input.yy CLIPPED,'0' CLIPPED,g_input.mm 
#         ELSE
#            LET l_date = g_input.yy CLIPPED,g_input.mm 
#         END IF
#         
#         #重評價匯率
#         #yangtt---2015/08/19---mod---str-
##         LET l_ooao011 = ""  #150817-00025#1
##         SELECT ooao011 INTO l_ooao011 
##           FROM ooao_t 
##          WHERE ooaoent = g_enterprise
##            AND ooao001 = g_glaa002
##            AND ooao002 = l_nmbx.nmbx100
##            AND ooao003 = g_glaa001
##            AND ooao004 = l_date
##          
##         IF cl_null(l_ooao011) THEN    
##            LET l_ooao011 = 1
##         END IF
##         
##         #本位幣二重評價匯率
##         IF g_glaa017 = '1' THEN 
##            LET l_ooam003 = l_nmbx.nmbx100
##         ELSE
##            LET l_ooam003 = g_glaa001
##         END IF
##         LET l_ooao011_2 = ""  #150817-00025#1
##         SELECT ooao011 INTO l_ooao011_2 
##           FROM ooao_t 
##          WHERE ooaoent = g_enterprise
##            AND ooao001 = g_glaa002
##            AND ooao002 = l_ooam003
##            AND ooao003 = g_glaa016
##            AND ooao004 = l_date
##            
##         IF cl_null(l_ooao011_2) THEN 
##            LET l_ooao011_2 = 1
##         END IF
##         
##         #本位幣三重評價匯率
##         IF g_glaa021 = '1' THEN 
##            LET l_ooam003 = l_nmbx.nmbx100
##         ELSE
##            LET l_ooam003 = g_glaa001
##         END IF
##         LET l_ooao011_3 = ""  #150817-00025#1
##         SELECT ooao011 INTO l_ooao011_3 
##           FROM ooao_t 
##          WHERE ooaoent = g_enterprise
##            AND ooao001 = g_glaa002
##            AND ooao002 = l_ooam003
##            AND ooao003 = g_glaa020
##            AND ooao004 = l_date
##         
##         IF cl_null(l_ooao011_3) THEN 
##            LET l_ooao011_3 = 1
##         END IF
#         CALL s_fin_get_exchange_rate(l_tmp.glaald,g_input.yy,g_input.mm,l_nmbx.nmbx100,l_tmp.glca003) 
#              RETURNING l_ooao011,l_ooao011_2,l_ooao011_3
#         IF cl_null(l_ooao011) THEN LET l_ooao011 = 0 END IF
#         IF cl_null(l_ooao011_2) THEN LET l_ooao011_2 = 0 END IF
#         IF cl_null(l_ooao011_3) THEN LET l_ooao011_3 = 0 END IF
#         #yangtt---2015/08/19---mod---end-
#         
#         #開戶組織
#         SELECT nmas001 INTO l_nmas001 
#           FROM nmas_t
#          WHERE nmasent = g_enterprise
#            AND nmas002 = l_nmbx.nmbx003
#         
#         SELECT nmaa002 INTO l_nmaa002
#           FROM nmaa_t
#          WHERE nmaaent = g_enterprise
#            AND nmaa001 = l_nmas001
#         
#         
#         LET l_nmde.nmdeent  = g_enterprise
#         LET l_nmde.nmdecomp = l_tmp.glaacomp
#         LET l_nmde.nmdeld   = l_tmp.glaald
#         LET l_nmde.nmdesite = g_input.ooef001
#         LET l_nmde.nmde001  = g_input.yy
#         LET l_nmde.nmde002  = g_input.mm
#         LET l_nmde.nmde003  = 'NM'
#         LET l_nmde.nmde004  = l_nmbx.nmbx003
#         LET l_nmde.nmde005  = l_nmaa002
#         LET l_nmde.nmde006  = ''
#         LET l_nmde.nmde007  = ''
#         LET l_nmde.nmde008  = ''
#         LET l_nmde.nmde009  = ''
#         LET l_nmde.nmde010  = ''
#         LET l_nmde.nmde011  = ''
#         LET l_nmde.nmde012  = ''
#         LET l_nmde.nmde013  = ''
#         LET l_nmde.nmde014  = ''
#         LET l_nmde.nmde015  = l_glab005
#         LET l_nmde.nmde017  = ''
#         LET l_nmde.nmde100  = l_nmbx.nmbx100
#         #重評價匯率
#         LET l_nmde.nmde101  = l_ooao011
#         #本期原幣未沖金額
#         LET l_nmde.nmde102  = l_nmbx.nmbx103 - l_nmbx.nmbx104 + l_amt1
#         IF cl_null(l_nmde.nmde102) THEN LET l_nmde.nmde102 = 0 END IF #150825
#         #本期本幣未沖金額
#         LET l_nmde.nmde103  = l_nmbx.nmbx113 - l_nmbx.nmbx114 + l_amt2
#         IF cl_null(l_nmde.nmde103) THEN LET l_nmde.nmde103 = 0 END IF #150825
#         #本期重評價後本幣金額
#         LET l_nmde.nmde104  = l_nmde.nmde102 * l_nmde.nmde101
#         IF cl_null(l_nmde.nmde104) THEN LET l_nmde.nmde104 = 0 END IF #150825
#         CALL s_curr_round_ld('1',l_tmp.glaald,g_glaa001,l_nmde.nmde104,2) RETURNING g_sub_success,g_errno,l_nmde.nmde104 #150825
#         #本期匯差金額
#         LET l_nmde.nmde105  = l_nmde.nmde104 - l_nmde.nmde103
#         IF cl_null(l_nmde.nmde105) THEN LET l_nmde.nmde105 = 0 END IF #150825
#         #本期匯差傳票提列金額
#         IF l_tmp.glca002 = '2' THEN   #2:期末暫估傳票，次月迴轉。
#            LET l_nmde.nmde106 = l_nmde.nmde105 
#         END IF
#         IF l_tmp.glca002 = '3' THEN   #3:重評價傳票，次月不迴轉。
#            LET l_nmde.nmde106 = l_nmde.nmde105 - l_nmde105
#         END IF
#         IF cl_null(l_nmde.nmde106) THEN LET l_nmde.nmde106 = 0 END IF #150825
#         
#         
#         #本位幣二
#         #重評價匯率
#         LET l_nmde.nmde111  = l_ooao011_2
#         #本期未沖金額
#         LET l_nmde.nmde113  = l_nmbx.nmbx123 - l_nmbx.nmbx124 + l_amt3
#         IF cl_null(l_nmde.nmde113) THEN LET l_nmde.nmde113 = 0 END IF  #150825
#         #本期重評價後本幣金額
#         IF g_glaa017 = '1' THEN
#            LET l_nmde.nmde114  = l_nmde.nmde102 * l_nmde.nmde111
#         ELSE
#            LET l_nmde.nmde114  = l_nmde.nmde104 * l_nmde.nmde111
#         END IF
#         IF cl_null(l_nmde.nmde114) THEN LET l_nmde.nmde114 = 0 END IF  #150825
#         CALL s_curr_round_ld('1',l_tmp.glaald,g_glaa016,l_nmde.nmde114,2) RETURNING g_sub_success,g_errno,l_nmde.nmde114  #150825
#         #本期匯差金額
#         LET l_nmde.nmde115  = l_nmde.nmde114 - l_nmde.nmde113
#         IF cl_null(l_nmde.nmde115) THEN LET l_nmde.nmde115 = 0 END IF  #150825
#         #本期匯差傳票提列金額
#         IF l_tmp.glca002 = '2' THEN   #2:期末暫估傳票，次月迴轉。
#            LET l_nmde.nmde116 = l_nmde.nmde115 
#         END IF
#         IF l_tmp.glca002 = '3' THEN   #3:重評價傳票，次月不迴轉。
#            LET l_nmde.nmde116 = l_nmde.nmde115 - l_nmde115
#         END IF
#         IF cl_null(l_nmde.nmde116) THEN LET l_nmde.nmde116 = 0 END IF  #150825
#         
#         #本位幣三
#         #重評價匯率
#         LET l_nmde.nmde121  = l_ooao011_3
#         LET l_nmde.nmde123  = l_nmbx.nmbx133 - l_nmbx.nmbx134 + l_amt4
#         IF cl_null(l_nmde.nmde123) THEN LET l_nmde.nmde123 = 0 END IF  #150825
#         #本期重評價後本幣金額
#         IF g_glaa021 = '1' THEN
#            LET l_nmde.nmde124  = l_nmde.nmde102 * l_nmde.nmde121
#         ELSE
#            LET l_nmde.nmde124  = l_nmde.nmde104 * l_nmde.nmde121
#         END IF
#         IF cl_null(l_nmde.nmde124) THEN LET l_nmde.nmde124 = 0 END IF  #150825
#         CALL s_curr_round_ld('1',l_tmp.glaald,g_glaa020,l_nmde.nmde124,2) RETURNING g_sub_success,g_errno,l_nmde.nmde124
#         #本期匯差金額
#         LET l_nmde.nmde125  = l_nmde.nmde124 - l_nmde.nmde123
#         IF cl_null(l_nmde.nmde125) THEN LET l_nmde.nmde125 = 0 END IF  #150825
#         #本期匯差傳票提列金額
#         IF l_tmp.glca002 = '2' THEN   #2:期末暫估傳票，次月迴轉。
#            LET l_nmde.nmde126 = l_nmde.nmde125 
#         END IF
#         IF l_tmp.glca002 = '3' THEN   #3:重評價傳票，次月不迴轉。
#            LET l_nmde.nmde126 = l_nmde.nmde125 - l_nmde125
#         END IF
#         IF cl_null(l_nmde.nmde126) THEN LET l_nmde.nmde126 = 0 END IF  #150825
#         
#         SELECT ooef005 INTO l_ooef005 FROM ooef_t
#          WHERE ooefent = g_enterprise
#            AND ooef001 = l_nmde.nmdecomp
#          
#         LET  l_nmdeld = l_nmde.nmdeld
#         LET  l_nmde001 = l_nmde.nmde001
#         LET  l_nmde002 = l_nmde.nmde002
#         LET l_nmde.nmdedocno = l_ooef005 CLIPPED,l_nmdeld.trim(),l_nmde001.trim(),l_nmde002.trim()
#         
#         #150825 mark ------
#         ##2015/01/16 add by qiull(s)
#         ##小数位数
#         #SELECT ooaj004 INTO l_ooaj004 FROM ooaj_t WHERE ooajent = g_enterprise
#         #   AND ooaj001 = g_glaa026 AND ooaj002 = l_nmde.nmde100
#         #SELECT ooaj004 INTO l_ooaj0042 FROM ooaj_t WHERE ooajent = g_enterprise
#         #   AND ooaj001 = g_glaa026 AND ooaj002 = g_glaa016
#         #SELECT ooaj004 INTO l_ooaj0043 FROM ooaj_t WHERE ooajent = g_enterprise
#         #   AND ooaj001 = g_glaa026 AND ooaj002 = g_glaa020
#         ##本位幣
#         #LET l_nmde.nmde102 = s_num_round('1',l_nmde.nmde102,l_ooaj004)
#         #LET l_nmde.nmde103 = s_num_round('1',l_nmde.nmde103,l_ooaj004)
#         #LET l_nmde.nmde104 = s_num_round('1',l_nmde.nmde104,l_ooaj004)
#         #LET l_nmde.nmde105 = s_num_round('1',l_nmde.nmde105,l_ooaj004)
#         #LET l_nmde.nmde106 = s_num_round('1',l_nmde.nmde106,l_ooaj004)
#         ##本位幣二
#         #LET l_nmde.nmde113 = s_num_round('1',l_nmde.nmde113,l_ooaj0042)
#         #LET l_nmde.nmde114 = s_num_round('1',l_nmde.nmde114,l_ooaj0042)
#         #LET l_nmde.nmde115 = s_num_round('1',l_nmde.nmde115,l_ooaj0042)
#         #LET l_nmde.nmde116 = s_num_round('1',l_nmde.nmde116,l_ooaj0042)
#         ##本位幣三
#         #LET l_nmde.nmde123 = s_num_round('1',l_nmde.nmde123,l_ooaj0043)
#         #LET l_nmde.nmde124 = s_num_round('1',l_nmde.nmde124,l_ooaj0043)
#         #LET l_nmde.nmde125 = s_num_round('1',l_nmde.nmde125,l_ooaj0043)
#         #LET l_nmde.nmde126 = s_num_round('1',l_nmde.nmde126,l_ooaj0043)
#         #2015/01/16 add by qiull(e)
#         #150825 mark end---
#         
#         #LET l_nmde.nmdedocdt = g_today #150825 mark
#         #150825 add ------
#         #獲取當前年度期別的第一天和最後一天
#         CALL s_get_accdate(g_glaa003,'',g_detail_d[l_ac].b_yy,g_detail_d[l_ac].b_mm)
#         RETURNING l_flag,l_errno,l_glav002,l_glav005,l_date,l_date,l_glav006,l_date,l_nmde.nmdedocdt,l_glav007,l_date,l_date    
#         #150825 add end---
#         
#         INSERT INTO nmde_t VALUES(l_nmde.*)
#         
#         IF SQLCA.sqlcode THEN
#            #CALL cl_errmsg("ins nmde",'','',SQLCA.SQLCODE,1)
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.code = SQLCA.SQLCODE
#            LET g_errparam.extend = "ins nmde"
#            LET g_errparam.popup = TRUE
#            CALL cl_err()
#            LET g_success = 'N'       
#         END IF
#         LET l_cnt = l_cnt +1
#      END FOREACH 
#      #albireo 151002 mark-----e

      #albireo 151002 add-----s
      LET g_sql = "SELECT nmas002,nmas003 ",
                  "  FROM nmas_t,nmaa_t ",
                  " WHERE nmaaent = ",g_enterprise," ",
                  "   AND nmaaent = nmasent ",
                  "   AND nmaa001 = nmas001 ",
                  "   AND nmaastus = 'Y' ",
                  "   AND nmaa002 IN (SELECT ooef001 FROM ooef_t WHERE ooefent = ",g_enterprise," ",
                  "                     AND ooef017 = '",l_tmp.glaacomp,"') "
      PREPARE sel_nmasp1 FROM g_sql
      DECLARE sel_nmasc1 CURSOR FOR sel_nmasp1

      FOREACH sel_nmasc1 INTO l_nmas002,l_nmas003
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
      
            EXIT FOREACH
         END IF
         
         #幣別一樣不用重評價
         IF g_glaa001 = l_nmas003 THEN
            CONTINUE FOREACH
         END IF
         
         #抓取數值  前期含本期
         SELECT SUM(nmbx103-nmbx104),SUM(nmbx113-nmbx114),SUM(nmbx123-nmbx124),SUM(nmbx133-nmbx134)
           INTO l_amt1,l_amt2,l_amt3,l_amt4
           FROM nmbx_t
          WHERE nmbxent  = g_enterprise
            AND nmbxcomp = l_tmp.glaacomp
            AND nmbx001  = g_input.yy
            AND nmbx002  <= g_input.mm
            AND nmbx003  = l_nmas002       
         
         IF cl_null(l_amt1) THEN LET l_amt1 = 0 END IF
         IF cl_null(l_amt2) THEN LET l_amt2 = 0 END IF  
         IF cl_null(l_amt3) THEN LET l_amt3 = 0 END IF
         IF cl_null(l_amt4) THEN LET l_amt4 = 0 END IF
        
         #無重評金額
         IF l_amt1 <= 0 THEN
            CONTINUE FOREACH
         END IF

         #会计科目        
         SELECT glab005 INTO l_glab005 
           FROM glab_t
          WHERE glabent = g_enterprise 
            AND glabld  = l_tmp.glaald
            AND glab001 = '40'
            AND glab002 = '40'     
            AND glab003 = l_nmas002      #交易帳戶編號
         
        
         #上期會差金額
         IF g_input.mm = 1 THEN 
            #SELECT nmde105,nmde115,nmde125 INTO l_nmde105,l_nmde115,l_nmde125 #161027-00052#1 mark
            SELECT nmde106,nmde116,nmde126 INTO l_nmde105,l_nmde115,l_nmde125  #161027-00052#1 add
              FROM nmde_t
             WHERE nmdeent = g_enterprise
               AND nmdeld = l_tmp.glaald
               AND nmde001 = g_input.yy - 1
               AND nmde002 = 12 
               AND nmde003 = 'NM'
               AND nmde004 =  l_nmas002    
         ELSE
            #SELECT nmde105,nmde115,nmde125 INTO l_nmde105,l_nmde115,l_nmde125 #161027-00052#1 mark
            SELECT nmde106,nmde116,nmde126 INTO l_nmde105,l_nmde115,l_nmde125  #161027-00052#1 add
              FROM nmde_t
             WHERE nmdeent = g_enterprise
               AND nmdeld = l_tmp.glaald
               AND nmde001 = g_input.yy
               AND nmde002 = g_input.mm - 1
               AND nmde003 = 'NM'
               AND nmde004 =  l_nmas002   
         END IF
         
         IF cl_null(l_nmde105) THEN LET l_nmde105 = 0 END IF
         IF cl_null(l_nmde115) THEN LET l_nmde115 = 0 END IF
         IF cl_null(l_nmde125) THEN LET l_nmde125 = 0 END IF
          
         
         IF g_input.mm < 10 THEN         
            LET l_date = g_input.yy CLIPPED,'0' CLIPPED,g_input.mm 
         ELSE
            LET l_date = g_input.yy CLIPPED,g_input.mm 
         END IF
         
         #重評價匯率
         CALL s_fin_get_exchange_rate(l_tmp.glaald,g_input.yy,g_input.mm,l_nmas003,l_tmp.glca003) 
              RETURNING l_ooao011,l_ooao011_2,l_ooao011_3
         IF cl_null(l_ooao011) THEN LET l_ooao011 = 0 END IF
         IF cl_null(l_ooao011_2) THEN LET l_ooao011_2 = 0 END IF
         IF cl_null(l_ooao011_3) THEN LET l_ooao011_3 = 0 END IF
         
         #開戶組織
         SELECT nmas001 INTO l_nmas001 
           FROM nmas_t
          WHERE nmasent = g_enterprise
            AND nmas002 = l_nmas002
         
         SELECT nmaa002 INTO l_nmaa002
           FROM nmaa_t
          WHERE nmaaent = g_enterprise
            AND nmaa001 = l_nmas001
         
         
         LET l_nmde.nmdeent  = g_enterprise
         LET l_nmde.nmdecomp = l_tmp.glaacomp
         LET l_nmde.nmdeld   = l_tmp.glaald
         LET l_nmde.nmdesite = g_input.ooef001
         LET l_nmde.nmde001  = g_input.yy
         LET l_nmde.nmde002  = g_input.mm
         LET l_nmde.nmde003  = 'NM'
         LET l_nmde.nmde004  = l_nmas002
         LET l_nmde.nmde005  = l_nmaa002
         LET l_nmde.nmde006  = ''
         LET l_nmde.nmde007  = ''
         LET l_nmde.nmde008  = ''
         LET l_nmde.nmde009  = ''
         LET l_nmde.nmde010  = ''
         LET l_nmde.nmde011  = ''
         LET l_nmde.nmde012  = ''
         LET l_nmde.nmde013  = ''
         LET l_nmde.nmde014  = ''
         LET l_nmde.nmde015  = l_glab005
         LET l_nmde.nmde017  = ''
         LET l_nmde.nmde100  = l_nmas003
         #重評價匯率
         LET l_nmde.nmde101  = l_ooao011
         #本期原幣未沖金額
         LET l_nmde.nmde102  = l_amt1
         IF cl_null(l_nmde.nmde102) THEN LET l_nmde.nmde102 = 0 END IF 
         #本期本幣未沖金額
         LET l_nmde.nmde103  = l_amt2
         IF cl_null(l_nmde.nmde103) THEN LET l_nmde.nmde103 = 0 END IF 
         #本期重評價後本幣金額
         LET l_nmde.nmde104  = l_nmde.nmde102 * l_nmde.nmde101
         IF cl_null(l_nmde.nmde104) THEN LET l_nmde.nmde104 = 0 END IF 
         CALL s_curr_round_ld('1',l_tmp.glaald,g_glaa001,l_nmde.nmde104,2) RETURNING g_sub_success,g_errno,l_nmde.nmde104 
         #本期匯差金額
         LET l_nmde.nmde105  = l_nmde.nmde104 - l_nmde.nmde103
         IF cl_null(l_nmde.nmde105) THEN LET l_nmde.nmde105 = 0 END IF #150825
         #本期匯差傳票提列金額
         IF l_tmp.glca002 = '2' THEN   #2:期末暫估傳票，次月迴轉。
            LET l_nmde.nmde106 = l_nmde.nmde105 
         END IF
         IF l_tmp.glca002 = '3' THEN   #3:重評價傳票，次月不迴轉。
            #LET l_nmde.nmde106 = l_nmde.nmde105 - l_nmde105 #161027-00004#1 mark
            LET l_nmde.nmde106 = l_nmde.nmde105 + l_nmde105  #161027-00004#1 add
         END IF
         IF cl_null(l_nmde.nmde106) THEN LET l_nmde.nmde106 = 0 END IF #150825
         
         
         #本位幣二
         #重評價匯率
         LET l_nmde.nmde111  = l_ooao011_2
         #本期未沖金額
         LET l_nmde.nmde113  = l_amt3
         IF cl_null(l_nmde.nmde113) THEN LET l_nmde.nmde113 = 0 END IF  #150825
         #本期重評價後本幣金額
         IF g_glaa017 = '1' THEN
            LET l_nmde.nmde114  = l_nmde.nmde102 * l_nmde.nmde111
         ELSE
            LET l_nmde.nmde114  = l_nmde.nmde104 * l_nmde.nmde111
         END IF
         IF cl_null(l_nmde.nmde114) THEN LET l_nmde.nmde114 = 0 END IF  #150825
         CALL s_curr_round_ld('1',l_tmp.glaald,g_glaa016,l_nmde.nmde114,2) RETURNING g_sub_success,g_errno,l_nmde.nmde114  #150825
         #本期匯差金額
         LET l_nmde.nmde115  = l_nmde.nmde114 - l_nmde.nmde113
         IF cl_null(l_nmde.nmde115) THEN LET l_nmde.nmde115 = 0 END IF  #150825
         #本期匯差傳票提列金額
         IF l_tmp.glca002 = '2' THEN   #2:期末暫估傳票，次月迴轉。
            LET l_nmde.nmde116 = l_nmde.nmde115 
         END IF
         IF l_tmp.glca002 = '3' THEN   #3:重評價傳票，次月不迴轉。
            #LET l_nmde.nmde116 = l_nmde.nmde115 - l_nmde115 #161027-00004#1 mark
            LET l_nmde.nmde116 = l_nmde.nmde115 + l_nmde115  #161027-00004#1 add
         END IF
         IF cl_null(l_nmde.nmde116) THEN LET l_nmde.nmde116 = 0 END IF  #150825
         
         #本位幣三
         #重評價匯率
         LET l_nmde.nmde121  = l_ooao011_3
         LET l_nmde.nmde123  = l_amt4
         IF cl_null(l_nmde.nmde123) THEN LET l_nmde.nmde123 = 0 END IF  #150825
         #本期重評價後本幣金額
         IF g_glaa021 = '1' THEN
            LET l_nmde.nmde124  = l_nmde.nmde102 * l_nmde.nmde121
         ELSE
            LET l_nmde.nmde124  = l_nmde.nmde104 * l_nmde.nmde121
         END IF
         IF cl_null(l_nmde.nmde124) THEN LET l_nmde.nmde124 = 0 END IF  #150825
         CALL s_curr_round_ld('1',l_tmp.glaald,g_glaa020,l_nmde.nmde124,2) RETURNING g_sub_success,g_errno,l_nmde.nmde124
         #本期匯差金額
         LET l_nmde.nmde125  = l_nmde.nmde124 - l_nmde.nmde123
         IF cl_null(l_nmde.nmde125) THEN LET l_nmde.nmde125 = 0 END IF  #150825
         #本期匯差傳票提列金額
         IF l_tmp.glca002 = '2' THEN   #2:期末暫估傳票，次月迴轉。
            LET l_nmde.nmde126 = l_nmde.nmde125 
         END IF
         IF l_tmp.glca002 = '3' THEN   #3:重評價傳票，次月不迴轉。
            #LET l_nmde.nmde126 = l_nmde.nmde125 - l_nmde125 #161027-00004#1 mark
            LET l_nmde.nmde126 = l_nmde.nmde125 + l_nmde125 #161027-00004#1 add
         END IF
         IF cl_null(l_nmde.nmde126) THEN LET l_nmde.nmde126 = 0 END IF  #150825
         
         SELECT ooef005 INTO l_ooef005 FROM ooef_t
          WHERE ooefent = g_enterprise
            AND ooef001 = l_nmde.nmdecomp
          
         LET  l_nmdeld = l_nmde.nmdeld
         LET  l_nmde001 = l_nmde.nmde001
         LET  l_nmde002 = l_nmde.nmde002
         LET l_nmde.nmdedocno = l_ooef005 CLIPPED,l_nmdeld.trim(),l_nmde001.trim(),l_nmde002.trim()
         
         #獲取當前年度期別的第一天和最後一天
         CALL s_get_accdate(g_glaa003,'',g_detail_d[l_ac].b_yy,g_detail_d[l_ac].b_mm)
         RETURNING l_flag,l_errno,l_glav002,l_glav005,l_date,l_date,l_glav006,l_date,l_nmde.nmdedocdt,l_glav007,l_date,l_date    
         
         #151222-00010#11---add--str
         CALL s_curr_round_ld('1',l_tmp.glaald,g_glaa001,l_nmde.nmde104,2) RETURNING g_sub_success,g_errno,l_nmde.nmde104 
         CALL s_curr_round_ld('1',l_tmp.glaald,g_glaa016,l_nmde.nmde114,2) RETURNING g_sub_success,g_errno,l_nmde.nmde114
         CALL s_curr_round_ld('1',l_tmp.glaald,g_glaa020,l_nmde.nmde124,2) RETURNING g_sub_success,g_errno,l_nmde.nmde124
         
         CALL s_curr_round_ld('1',l_tmp.glaald,g_glaa001,l_nmde.nmde105,2) RETURNING g_sub_success,g_errno,l_nmde.nmde105 
         CALL s_curr_round_ld('1',l_tmp.glaald,g_glaa016,l_nmde.nmde115,2) RETURNING g_sub_success,g_errno,l_nmde.nmde115
         CALL s_curr_round_ld('1',l_tmp.glaald,g_glaa020,l_nmde.nmde125,2) RETURNING g_sub_success,g_errno,l_nmde.nmde125
         
         CALL s_curr_round_ld('1',l_tmp.glaald,g_glaa001,l_nmde.nmde106,2) RETURNING g_sub_success,g_errno,l_nmde.nmde106 
         CALL s_curr_round_ld('1',l_tmp.glaald,g_glaa016,l_nmde.nmde116,2) RETURNING g_sub_success,g_errno,l_nmde.nmde116
         CALL s_curr_round_ld('1',l_tmp.glaald,g_glaa020,l_nmde.nmde126,2) RETURNING g_sub_success,g_errno,l_nmde.nmde126
         #151222-00010#11---add--end
         #161128-00061#2----modify------begin-----------
         #INSERT INTO nmde_t VALUES(l_nmde.*)
         INSERT INTO nmde_t (nmdeent,nmdecomp,nmdeld,nmdesite,nmde001,nmde002,nmde003,nmde004,nmde005,nmde006,nmde007,
                             nmde008,nmde009,nmde010,nmde011,nmde012,nmde013,nmde014,nmde015,nmde017,nmde100,nmde101,nmde102,
                             nmde103,nmde104,nmde105,nmde106,nmde111,nmde113,nmde114,nmde115,nmde116,nmde121,nmde123,nmde124,
                             nmde125,nmde126,nmdedocno,nmdedocdt,nmde018,nmde019,nmde020,nmde021,nmde022,nmde023,nmde024,
                             nmde025,nmde026,nmde027,nmde028,nmde029,nmde030,nmde031,nmde032,nmde033)
          VALUES(l_nmde.nmdeent,l_nmde.nmdecomp,l_nmde.nmdeld,l_nmde.nmdesite,l_nmde.nmde001,l_nmde.nmde002,l_nmde.nmde003,l_nmde.nmde004,l_nmde.nmde005,l_nmde.nmde006,l_nmde.nmde007,
                 l_nmde.nmde008,l_nmde.nmde009,l_nmde.nmde010,l_nmde.nmde011,l_nmde.nmde012,l_nmde.nmde013,l_nmde.nmde014,l_nmde.nmde015,l_nmde.nmde017,l_nmde.nmde100,l_nmde.nmde101,l_nmde.nmde102,
                 l_nmde.nmde103,l_nmde.nmde104,l_nmde.nmde105,l_nmde.nmde106,l_nmde.nmde111,l_nmde.nmde113,l_nmde.nmde114,l_nmde.nmde115,l_nmde.nmde116,l_nmde.nmde121,l_nmde.nmde123,l_nmde.nmde124,
                 l_nmde.nmde125,l_nmde.nmde126,l_nmde.nmdedocno,l_nmde.nmdedocdt,l_nmde.nmde018,l_nmde.nmde019,l_nmde.nmde020,l_nmde.nmde021,l_nmde.nmde022,l_nmde.nmde023,l_nmde.nmde024,
                 l_nmde.nmde025,l_nmde.nmde026,l_nmde.nmde027,l_nmde.nmde028,l_nmde.nmde029,l_nmde.nmde030,l_nmde.nmde031,l_nmde.nmde032,l_nmde.nmde033)
         #161128-00061#2----modify------end-----------
         
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.extend = "ins nmde"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N'       
         END IF
         LET l_cnt = l_cnt +1
         
         #160513-00008#2--add--str--
         #回轉或不回轉：插入期末調匯數
         IF g_glaa014='Y' AND (l_tmp.glca002 = '2' OR l_tmp.glca002 ='3') THEN
            #插入對應的現金變動碼nmbc_t資料
            LET l_nmbc.nmbcsite=l_nmde.nmdesite #資金中心
            LET l_nmbc.nmbcseq=l_nmbcseq +1     #項次
            LET l_nmbc.nmbc002=l_nmde.nmde004   #交易帳戶編碼
            LET l_nmbc.nmbc100=l_nmde.nmde100   #交易帳戶幣別
            LET l_nmbc.nmbc101=l_nmde.nmde101   #主帳套匯率
            LET l_nmbc.nmbc103=0                #主帳套原幣金額
            LET l_nmbc.nmbc113=l_nmde.nmde105   #主帳套本幣金額       #160531-00014#1 mark #161013-00052#1 unmark
#            LET l_nmbc.nmbc113=l_nmde.nmde106   #本期匯差傳票提列金額 #160531-00014#1 #161013-00052#1 mark 
            LET l_nmbc.nmbc121=l_nmde.nmde111   #主帳套本位幣二匯率
            LET l_nmbc.nmbc123=l_nmde.nmde115   #主帳套本位幣二金額               #160531-00014#1 mark #161013-00052#1 unmark
#            LET l_nmbc.nmbc123=l_nmde.nmde116   #本期本位幣二匯差傳票提列提列金額 #160531-00014#1 #161013-00052#1 mark
            LET l_nmbc.nmbc131=l_nmde.nmde121   #主帳套本位幣三匯率
            LET l_nmbc.nmbc133=l_nmde.nmde125   #主帳套本位幣三金額               #160531-00014#1 mark #161013-00052#1 unmark
#            LET l_nmbc.nmbc133=l_nmde.nmde126   #本期本位幣三匯差傳票提列提列金額 #160531-00014#1 #161013-00052#1 mark
            LET l_nmbc.nmbcorga=l_nmde.nmde005  #來源組織
            
            #161128-00061#2----modify------begin-----------
            #INSERT INTO nmbc_t VALUES(l_nmbc.*)
             INSERT INTO nmbc_t (nmbcent,nmbcownid,nmbcowndp,nmbccrtid,nmbccrtdp,nmbccrtdt,nmbcmodid,nmbcmoddt,
                                 nmbccnfid,nmbccnfdt,nmbcpstid,nmbcpstdt,nmbcstus,nmbccomp,nmbcsite,nmbcdocno,
                                 nmbcseq,nmbc001,nmbc002,nmbc003,nmbc004,nmbc005,nmbc006,nmbc007,nmbc008,nmbc009,
                                 nmbc010,nmbc011,nmbc100,nmbc101,nmbc103,nmbc113,nmbc121,nmbc123,nmbc131,nmbc133,
                                 nmbc012,nmbc013,nmbc014,nmbc015,nmbc016,nmbc017,nmbcorga)
              VALUES(l_nmbc.nmbcent,l_nmbc.nmbcownid,l_nmbc.nmbcowndp,l_nmbc.nmbccrtid,l_nmbc.nmbccrtdp,l_nmbc.nmbccrtdt,l_nmbc.nmbcmodid,l_nmbc.nmbcmoddt,
                     l_nmbc.nmbccnfid,l_nmbc.nmbccnfdt,l_nmbc.nmbcpstid,l_nmbc.nmbcpstdt,l_nmbc.nmbcstus,l_nmbc.nmbccomp,l_nmbc.nmbcsite,l_nmbc.nmbcdocno,
                     l_nmbc.nmbcseq,l_nmbc.nmbc001,l_nmbc.nmbc002,l_nmbc.nmbc003,l_nmbc.nmbc004,l_nmbc.nmbc005,l_nmbc.nmbc006,l_nmbc.nmbc007,l_nmbc.nmbc008,l_nmbc.nmbc009,
                     l_nmbc.nmbc010,l_nmbc.nmbc011,l_nmbc.nmbc100,l_nmbc.nmbc101,l_nmbc.nmbc103,l_nmbc.nmbc113,l_nmbc.nmbc121,l_nmbc.nmbc123,l_nmbc.nmbc131,l_nmbc.nmbc133,
                     l_nmbc.nmbc012,l_nmbc.nmbc013,l_nmbc.nmbc014,l_nmbc.nmbc015,l_nmbc.nmbc016,l_nmbc.nmbc017,l_nmbc.nmbcorga)
            #161128-00061#2----modify------end-----------
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.extend = "insert nmbc_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_success = 'N'       
            END IF
            LET l_nmbcseq = l_nmbcseq + 1
         END IF
         #回轉:插入下一期的迴轉數
         IF g_glaa014='Y' AND l_tmp.glca002 = '2' THEN
            LET l_nmbc_n.* = l_nmbc.*
            LET l_nmbc_n.nmbcdocno=l_nmbcdocno_n
            LET l_nmbc_n.nmbc005=l_nmbc005_n
            #170118-00019#1 add s---
            LET l_nmbc_n.nmbc103 = l_nmbc_n.nmbc103 * -1 
            LET l_nmbc_n.nmbc113 = l_nmbc_n.nmbc113 * -1
            LET l_nmbc_n.nmbc123 = l_nmbc_n.nmbc123 * -1
            LET l_nmbc_n.nmbc133 = l_nmbc_n.nmbc133 * -1
            #170118-00019#1 add e---
            
           #161128-00061#2----modify------begin-----------
           #INSERT INTO nmbc_t VALUES(l_nmbc_n.*)
            INSERT INTO nmbc_t (nmbcent,nmbcownid,nmbcowndp,nmbccrtid,nmbccrtdp,nmbccrtdt,nmbcmodid,nmbcmoddt,
                                nmbccnfid,nmbccnfdt,nmbcpstid,nmbcpstdt,nmbcstus,nmbccomp,nmbcsite,nmbcdocno,
                                nmbcseq,nmbc001,nmbc002,nmbc003,nmbc004,nmbc005,nmbc006,nmbc007,nmbc008,nmbc009,
                                nmbc010,nmbc011,nmbc100,nmbc101,nmbc103,nmbc113,nmbc121,nmbc123,nmbc131,nmbc133,
                                nmbc012,nmbc013,nmbc014,nmbc015,nmbc016,nmbc017,nmbcorga)
             VALUES(l_nmbc_n.nmbcent,l_nmbc_n.nmbcownid,l_nmbc_n.nmbcowndp,l_nmbc_n.nmbccrtid,l_nmbc_n.nmbccrtdp,l_nmbc_n.nmbccrtdt,l_nmbc_n.nmbcmodid,l_nmbc_n.nmbcmoddt,
                    l_nmbc_n.nmbccnfid,l_nmbc_n.nmbccnfdt,l_nmbc_n.nmbcpstid,l_nmbc_n.nmbcpstdt,l_nmbc_n.nmbcstus,l_nmbc_n.nmbccomp,l_nmbc_n.nmbcsite,l_nmbc_n.nmbcdocno,
                    l_nmbc_n.nmbcseq,l_nmbc_n.nmbc001,l_nmbc_n.nmbc002,l_nmbc_n.nmbc003,l_nmbc_n.nmbc004,l_nmbc_n.nmbc005,l_nmbc_n.nmbc006,l_nmbc_n.nmbc007,l_nmbc_n.nmbc008,l_nmbc_n.nmbc009,
                    l_nmbc_n.nmbc010,l_nmbc_n.nmbc011,l_nmbc_n.nmbc100,l_nmbc_n.nmbc101,l_nmbc_n.nmbc103,l_nmbc_n.nmbc113,l_nmbc_n.nmbc121,l_nmbc_n.nmbc123,l_nmbc_n.nmbc131,l_nmbc_n.nmbc133,
                    l_nmbc_n.nmbc012,l_nmbc_n.nmbc013,l_nmbc_n.nmbc014,l_nmbc_n.nmbc015,l_nmbc_n.nmbc016,l_nmbc_n.nmbc017,l_nmbc_n.nmbcorga)
           #161128-00061#2----modify------end-----------
            
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.extend = "insert nmbc_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_success = 'N'       
            END IF
         END IF
         #160513-00008#2--add--end
      END FOREACH      
      #albireo 151002 add-----e
      
      #更新月底重評價年度月份
      UPDATE glca_t SET glca006 = g_input.yy,
                        glca007 = g_input.mm
       WHERE glcaent = g_enterprise
         AND glcald = l_tmp.glaald
         AND glca001 = 'NM'
         
      IF SQLCA.sqlcode THEN
         #CALL cl_errmsg("upd glca",'','',SQLCA.SQLCODE,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = "upd glca"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N'       
      END IF
   END FOREACH   
   
   #CALL anmp810__immediately_gen(l_nmde.nmdeld,l_nmde.nmde001,l_nmde.nmde002,l_nmde.nmdecomp,l_nmde.nmdedocno)   #07166
   
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
PRIVATE FUNCTION anmp810_get_ooef001_wc(p_wc)
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
PRIVATE FUNCTION anmp810__immediately_gen(p_nmdeld,p_nmde001,p_nmde002,p_nmdecomp,p_nmdedocno)
   DEFINE l_success         LIKE type_t.num5
   DEFINE l_doc_success     LIKE type_t.num5
   DEFINE l_slip            LIKE ooba_t.ooba002
   DEFINE l_dfin0032        LIKE type_t.chr1
   DEFINE l_count           LIKE type_t.num5
   DEFINE l_glap001         LIKE glap_t.glap001
   DEFINE la_param          RECORD
          prog              STRING,
          param             DYNAMIC ARRAY OF STRING
                            END RECORD
   DEFINE ls_js             STRING
   DEFINE l_glaa024         LIKE glaa_t.glaa024
   DEFINE l_ooac004         LIKE ooac_t.ooac004
   #161128-00061#2----modify------begin-----------
   #DEFINE l_nmde            RECORD LIKE nmde_t.*
   DEFINE l_nmde RECORD  #銀行重評價檔
       nmdeent LIKE nmde_t.nmdeent, #企業編號
       nmdecomp LIKE nmde_t.nmdecomp, #法人
       nmdeld LIKE nmde_t.nmdeld, #帳套
       nmdesite LIKE nmde_t.nmdesite, #帳務中心
       nmde001 LIKE nmde_t.nmde001, #年度
       nmde002 LIKE nmde_t.nmde002, #期別
       nmde003 LIKE nmde_t.nmde003, #來源模組
       nmde004 LIKE nmde_t.nmde004, #銀行帳戶
       nmde005 LIKE nmde_t.nmde005, #開戶組織
       nmde006 LIKE nmde_t.nmde006, #部門
       nmde007 LIKE nmde_t.nmde007, #責任中心
       nmde008 LIKE nmde_t.nmde008, #區域
       nmde009 LIKE nmde_t.nmde009, #客群
       nmde010 LIKE nmde_t.nmde010, #產品類別
       nmde011 LIKE nmde_t.nmde011, #人員
       nmde012 LIKE nmde_t.nmde012, #預算編號
       nmde013 LIKE nmde_t.nmde013, #專案編號
       nmde014 LIKE nmde_t.nmde014, #WBS編號
       nmde015 LIKE nmde_t.nmde015, #會計科目
       nmde017 LIKE nmde_t.nmde017, #傳票號碼
       nmde100 LIKE nmde_t.nmde100, #幣別
       nmde101 LIKE nmde_t.nmde101, #重評價匯率
       nmde102 LIKE nmde_t.nmde102, #本期原幣未沖金額
       nmde103 LIKE nmde_t.nmde103, #本期本幣未沖金額
       nmde104 LIKE nmde_t.nmde104, #本期重評價後本幣金額
       nmde105 LIKE nmde_t.nmde105, #本期匯差金額
       nmde106 LIKE nmde_t.nmde106, #本期匯差傳票提列金額
       nmde111 LIKE nmde_t.nmde111, #本位幣二重評價匯率
       nmde113 LIKE nmde_t.nmde113, #本期本位幣二未沖金額
       nmde114 LIKE nmde_t.nmde114, #本期本位幣二重評價後金額
       nmde115 LIKE nmde_t.nmde115, #本期本位幣二匯差金額
       nmde116 LIKE nmde_t.nmde116, #本期本位幣二匯差傳票提列提列金額
       nmde121 LIKE nmde_t.nmde121, #本位幣三重評價匯率
       nmde123 LIKE nmde_t.nmde123, #本期本位幣三未沖金額
       nmde124 LIKE nmde_t.nmde124, #本期本位幣三重評價後金額
       nmde125 LIKE nmde_t.nmde125, #本期本位幣三匯差金額
       nmde126 LIKE nmde_t.nmde126, #本期本位幣三匯差傳票提列提列金額
       nmdedocno LIKE nmde_t.nmdedocno, #單據編號
       nmdedocdt LIKE nmde_t.nmdedocdt, #單據日期
       nmde018 LIKE nmde_t.nmde018, #收付款客商
       nmde019 LIKE nmde_t.nmde019, #帳款客商
       nmde020 LIKE nmde_t.nmde020, #經營方式
       nmde021 LIKE nmde_t.nmde021, #通路
       nmde022 LIKE nmde_t.nmde022, #品牌
       nmde023 LIKE nmde_t.nmde023, #自由核算項一
       nmde024 LIKE nmde_t.nmde024, #自由核算項二
       nmde025 LIKE nmde_t.nmde025, #自由核算項三
       nmde026 LIKE nmde_t.nmde026, #自由核算項四
       nmde027 LIKE nmde_t.nmde027, #自由核算項五
       nmde028 LIKE nmde_t.nmde028, #自由核算項六
       nmde029 LIKE nmde_t.nmde029, #自由核算項七
       nmde030 LIKE nmde_t.nmde030, #自由核算項八
       nmde031 LIKE nmde_t.nmde031, #自由核算項九
       nmde032 LIKE nmde_t.nmde032, #自由核算項十
       nmde033 LIKE nmde_t.nmde033  #摘要
       END RECORD
   #161128-00061#2----modify------end-----------
   DEFINE l_glaa015   LIKE glaa_t.glaa015
   DEFINE l_glaa019   LIKE glaa_t.glaa019
   DEFINE l_glbc009   LIKE glbc_t.glbc009
   DEFINE l_glbc012   LIKE glbc_t.glbc012
   DEFINE l_glbc014   LIKE glbc_t.glbc014
   DEFINE l_nmck113   LIKE nmck_t.nmck113
   DEFINE l_nmck123   LIKE nmck_t.nmck123
   DEFINE l_nmck133   LIKE nmck_t.nmck133
   DEFINE l_cnt       LIKE type_t.num5 
   DEFINE l_dfin0030        LIKE type_t.chr1 
   DEFINE l_gl_slip         LIKE ooba_t.ooba002      #總帳單別 
   DEFINE p_nmdeld          LIKE nmde_t.nmdeld
   DEFINE p_nmde001         LIKE nmde_t.nmde001
   DEFINE p_nmde002         LIKE nmde_t.nmde002
   DEFINE p_nmdecomp        LIKE nmde_t.nmdecomp
   DEFINE p_nmdedocno       LIKE nmde_t.nmdedocno

   IF cl_null(p_nmdeld)    THEN RETURN END IF   #無資料直接返回不做處理
   IF cl_null(p_nmde001)   THEN RETURN END IF   #無資料直接返回不做處理
   IF cl_null(p_nmde002)   THEN RETURN END IF   #無資料直接返回不做處理
  
   #161128-00061#2----modify------begin-----------
   #SELECT * INTO l_nmde.* 
   SELECT nmdeent,nmdecomp,nmdeld,nmdesite,nmde001,nmde002,nmde003,nmde004,nmde005,nmde006,nmde007,
          nmde008,nmde009,nmde010,nmde011,nmde012,nmde013,nmde014,nmde015,nmde017,nmde100,nmde101,nmde102,
          nmde103,nmde104,nmde105,nmde106,nmde111,nmde113,nmde114,nmde115,nmde116,nmde121,nmde123,nmde124,
          nmde125,nmde126,nmdedocno,nmdedocdt,nmde018,nmde019,nmde020,nmde021,nmde022,nmde023,nmde024,
          nmde025,nmde026,nmde027,nmde028,nmde029,nmde030,nmde031,nmde032,nmde033 INTO l_nmde.* 
   #161128-00061#2----modify------end----------
     FROM nmde_t 
    WHERE nmdeent = g_enterprise 
      AND nmdedocno = p_nmdedocno 
      AND nmdeld = p_nmdeld 
      AND nmdecomp = p_nmdecomp

   IF NOT cl_null(l_nmde.nmde017)  THEN RETURN END IF #传票号码已经存在返回不做处理

   IF NOT cl_ask_confirm('aap-00404') THEN RETURN END IF  #询问是否直接抛转凭证

  #取得單別
   CALL s_aooi200_fin_get_slip(p_nmdedocno) RETURNING l_success,l_slip
  #取得單別設置的"是否直接抛转凭证"參數
   CALL s_fin_get_doc_para(p_nmdeld,p_nmdecomp,l_slip,'D-FIN-0032') RETURNING l_dfin0032

   IF cl_null(l_dfin0032) OR l_dfin0032 MATCHES '[Nn]' THEN #參數值為空或為N則不做直接抛转凭证邏輯
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aap-00406' #未设置直接抛转凭证
      LET g_errparam.extend = l_slip
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN 
   END IF 

   #是否产生分录传票
   CALL s_fin_get_doc_para(p_nmdeld,p_nmdecomp,l_slip,'D-FIN-0030') RETURNING l_dfin0030
   IF l_dfin0030 <> 'Y'  THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aap-00054' #此账款单设置为不需产生凭证!!
      LET g_errparam.extend = l_slip
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN 
   END IF
   
   
   SELECT glaa015,glaa019 INTO l_glaa015,l_glaa019 
     FROM glaa_t 
    WHERE glaaent = g_enterprise AND glaald = p_nmdeld AND glaa014 = 'Y'
   LET l_cnt = 0 
   SELECT COUNT(*) INTO l_cnt FROM glbc_t
    WHERE glbcent=g_enterprise AND glbcld=p_nmdeld
      AND glbcdocno=p_nmdedocno AND glbc001=p_nmde001
      AND glbc002=p_nmde002
      
   SELECT SUM(glbc009),SUM(glbc012),SUM(glbc014)
     INTO l_glbc009,l_glbc012,l_glbc014
     FROM glbc_t
    WHERE glbcent=g_enterprise AND glbcld=p_nmdeld
      AND glbcdocno= p_nmdedocno AND glbc001=p_nmde001
      AND glbc002=p_nmde002
  
   SELECT SUM(nmde106),SUM(nmde116),SUM(nmde126)
     INTO l_nmck113,l_nmck123,l_nmck133
     FROM nmde_t
    WHERE nmdeent = g_enterprise
      AND nmdeld = p_nmdeld
      AND nmde001 = p_nmde001
      AND nmde002 = p_nmde002
   IF l_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00221'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF 
   IF l_glbc009 <> l_nmck113 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'anm-00146'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF 
   
   IF l_glaa015='Y' AND l_glbc012 <> l_nmck123 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'anm-00147'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   
   IF l_glaa019='Y' AND l_glbc014 <> l_nmck133 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'anm-00148'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF 
   
   #取得傳票單別(D-FIN-2002:產生之總帳傳票單別)
   LET l_gl_slip = ''
   CALL s_fin_get_doc_para(p_nmdeld,p_nmdecomp,l_slip,'D-FIN-2002') RETURNING l_gl_slip
   
   CALL anmp810_for_gen(p_nmdeld,p_nmde001,p_nmde002)
   
   IF l_gl_slip = '' THEN
      CALL anmp810_go_gen(p_nmdeld,p_nmde001,p_nmde002,p_nmdedocno)
     ELSE 
      CALL anmp810_go_gen2(l_gl_slip,p_nmdeld,p_nmde001,p_nmde002,p_nmdedocno)
   END IF
   
#   SELECT nmde017 INTO l_nmde017 FROM nmde_t
#    WHERE nmdeent = g_enterprise AND nmdeld = p_nmdeld
#      AND nmde001 = p_nmde001 AND nmde002 = p_nmde002

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
PRIVATE FUNCTION anmp810_for_gen(p_nmdeld,p_nmde001,p_nmde002)
   DEFINE l_sql         STRING
   DEFINE l_wc          STRING
   DEFINE l_nmde004     LIKE nmde_t.nmde004
   DEFINE l_success     LIKE type_t.chr1
   DEFINE p_nmdeld          LIKE nmde_t.nmdeld
   DEFINE p_nmde001         LIKE nmde_t.nmde001
   DEFINE p_nmde002         LIKE nmde_t.nmde002
   DEFINE p_nmdecomp        LIKE nmde_t.nmdecomp
   DEFINE p_nmdedocno       LIKE nmde_t.nmdedocno

   #IF g_chk_gen = 'Y' THEN RETURN END IF
   CALL s_transaction_begin()   
   IF cl_null(g_wc) THEN LET g_wc = " 1=1" END IF

   LET l_sql = "SELECT DISTINCT nmde004 FROM nmde_t WHERE nmdeent = '",g_enterprise,"'",
               "   AND nmdeld  = '",p_nmdeld,"'",
               "   AND nmde001 = '",p_nmde001,"'",
               "   AND nmde002 = '",p_nmde002,"'",
               "   AND ",g_wc
   PREPARE anmt820_03_prep FROM l_sql
   DECLARE anmt820_03_curs CURSOR FOR anmt820_03_prep

   LET g_wc = ""
   LET l_nmde004 = ""

   FOREACH anmt820_03_curs INTO l_nmde004
      IF cl_null(l_wc) THEN
         LET l_wc = "nmde004 IN ('",l_nmde004,"'"
      ELSE
         LET l_wc = l_wc,",'",l_nmde004,"'"
      END IF
   END FOREACH
   LET l_wc = l_wc,")"

   CALL s_anmt820_gen_nm(p_nmdeld,'',p_nmde001,p_nmde002,'',1,l_wc,'Y') RETURNING l_success

   #LET g_chk_gen = 'Y'
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
PRIVATE FUNCTION anmp810_go_gen(p_nmdeld,p_nmde001,p_nmde002,p_nmdedocno)
   DEFINE sr         RECORD
             glapdocno     LIKE glap_t.glapdocno,
             glapdocdt     LIKE glap_t.glapdocdt
                     END RECORD
   DEFINE l_s        LIKE type_t.chr1
   DEFINE l_glaa024  LIKE glaa_t.glaa024
   DEFINE r_success  LIKE type_t.chr1
   DEFINE r_start_no LIKE glap_t.glapdocno
   DEFINE r_end_no   LIKE glap_t.glapdocno
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_glaa121  LIKE glaa_t.glaa121
   DEFINE l_wc       STRING 
   DEFINE l_chr      LIKE type_t.chr1           #151013-00016#4
   DEFINE l_prog     LIKE gzza_t.gzza001        #151013-00016#4
   DEFINE p_nmdeld          LIKE nmde_t.nmdeld
   DEFINE p_nmde001         LIKE nmde_t.nmde001
   DEFINE p_nmde002         LIKE nmde_t.nmde002
   DEFINE p_nmdecomp        LIKE nmde_t.nmdecomp
   DEFINE p_nmdedocno       LIKE nmde_t.nmdedocno

   SELECT glaa024 INTO l_glaa024 FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = p_mdeld
      
   OPEN WINDOW w_anmt820_03_s01 WITH FORM cl_ap_formpath("anm",'anmt820_03_s01')

      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
     
         INPUT BY NAME sr.glapdocno,sr.glapdocdt ATTRIBUTE(WITHOUT DEFAULTS)

            BEFORE INPUT
               LET sr.glapdocdt = g_today
               DISPLAY BY NAME sr.glapdocdt
               
            AFTER FIELD glapdocno
               IF NOT cl_null(sr.glapdocno) THEN 
                  #151013-00016#4 mark str---
                  #INITIALIZE g_chkparam.* TO NULL
                  #LET g_chkparam.arg1 = l_glaa024
                  #LET g_chkparam.arg2 = sr.glapdocno
                  ##160318-00025#39  2016/04/22  by pengxin  add(S)
                  #LET g_errshow = TRUE #是否開窗 
                  #LET g_chkparam.err_str[1] = "agl-00189:sub-01302|aooi200|",cl_get_progname("aooi200",g_lang,"2"),"|:EXEPROGaooi200"
                  ##160318-00025#39  2016/04/22  by pengxin  add(E)
                  #IF NOT cl_chk_exist("v_ooba002_07") THEN
                  #151013-00016#4 mark end---
                  #151013-00016#4 add str---
                  LET l_chr = 'N'  #不迴轉
                  #重評價
                  SELECT (CASE WHEN glca002 = '2' THEN 'Y' ELSE 'N' END) INTO l_chr
                    FROM glca_t
                   WHERE glcaent = g_enterprise
                     AND glcald  = p_nmdeld AND glca001 = 'NM'
                  IF l_chr = 'Y' THEN
                     LET l_prog = 'aglt350'
                  ELSE
                     LET l_prog = 'aglt310'
                  END IF
                  IF NOT s_aooi200_fin_chk_docno(p_nmdeld,'','',sr.glapdocno,sr.glapdocdt,l_prog) THEN
                  #151013-00016#4 add end---
                    #檢查失敗時後續處理
                    LET sr.glapdocno = ''
                    NEXT FIELD CURRENT
                  END IF
               END IF 

            AFTER FIELD glapdocdt

            ON ACTION controlp INFIELD glapdocno
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = sr.glapdocno
               LET g_qryparam.arg1 = l_glaa024
               #LET g_qryparam.arg2 = 'aglt310'        #151013-00016#4 mark
               #CALL q_ooba002_3()          #呼叫開窗   #151013-00016#4 mark
               #151013-00016#4 add str---
               #重評價
               SELECT (CASE WHEN glca002 = '2' THEN 'Y' ELSE 'N' END) INTO l_chr
                 FROM glca_t
                WHERE glcaent = g_enterprise
                  AND glcald  = p_nmdeld AND glca001 = 'NM'
               IF l_chr = 'Y' THEN
                  LET g_qryparam.arg2 = 'aglt350'
               ELSE
                  LET g_qryparam.arg2 = 'aglt310'
               END IF
               CALL q_ooba002_1()
               #151013-00016#4 add end---
               LET sr.glapdocno = g_qryparam.return1
               DISPLAY sr.glapdocno TO glapdocno
               NEXT FIELD glapdocno

         END INPUT

         ON ACTION accept
            ACCEPT DIALOG

         ON ACTION cancel
            LET INT_FLAG = TRUE
            EXIT DIALOG

         ON ACTION close
            LET INT_FLAG = TRUE
            EXIT DIALOG

         ON ACTION exit
            LET INT_FLAG = TRUE
            EXIT DIALOG

      END DIALOG

      IF INT_FLAG = 0 THEN
         #151013-00019#13 mark ------
         #CALL s_anmt820_gen_nm_1_ins_glap(sr.glapdocno,sr.glapdocdt,g_nmde_m.nmdeld,'1')
         #     RETURNING r_success,r_start_no,r_end_no
         #151013-00019#13 mark end---
         #151013-00019#13 add ------
         LET l_wc =" glgbdocno = '",p_nmdedocno,"' "
         CALL s_pre_voucher_ins_glap('NM','N40',p_nmdeld,sr.glapdocdt,sr.glapdocno,'1',l_wc) 
              RETURNING r_success,r_start_no,r_end_no
         #151013-00019#13 add end---
         IF r_success = TRUE AND NOT cl_null(r_start_no) THEN
            UPDATE nmde_t SET nmde017=r_start_no
             WHERE nmdeent = g_enterprise AND nmdeld = p_nmdeld
               AND nmde001 = p_nmde001 AND nmde002 = p_nmde002
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "update nmde_t"
               LET g_errparam.code   = SQLCA.SQLCODE
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               LET r_success = FALSE
            END IF
            SELECT glaa121 INTO l_glaa121 FROM glaa_t WHERE glaaent = g_enterprise
               AND glaald = p_nmdeld
            IF l_glaa121 = 'Y' THEN
               LET l_wc = "glgadocno = '",p_nmdedocno,"'"
              #CALL s_pre_voucher_upd('NM','N40',g_nmde_m.nmdeld,'',r_start_no,g_today,l_wc) RETURNING l_success  #150707-00001#8 mark
               CALL s_pre_voucher_upd('NM','N40',p_nmdeld,'',r_start_no,sr.glapdocdt,l_wc) RETURNING l_success  #150707-00001#8
          
               IF l_success = FALSE THEN
                  LET r_success = FALSE
               END IF
            END IF
         END IF
         IF NOT r_success THEN
            CALL s_transaction_end('N','1')
            CALL cl_ask_confirm('axr-00120') RETURNING l_s
         ELSE
            DISPLAY r_start_no,r_end_no TO b_xrca038,e_xrca038
            CALL s_transaction_end('Y','1')
            CALL cl_ask_confirm('axr-00119') RETURNING l_s
         END IF
         
      ELSE
         LET INT_FLAG = FALSE
      END IF

   CLOSE WINDOW w_anmt820_03_s01
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
PRIVATE FUNCTION anmp810_go_gen2(p_lip,p_nmdeld,p_nmde001,p_nmde002,p_nmdedocno)
   DEFINE sr         RECORD
             glapdocno     LIKE glap_t.glapdocno,
             glapdocdt     LIKE glap_t.glapdocdt
                     END RECORD
   DEFINE l_s        LIKE type_t.chr1
   DEFINE l_glaa024  LIKE glaa_t.glaa024
   DEFINE r_success  LIKE type_t.chr1
   DEFINE r_start_no LIKE glap_t.glapdocno
   DEFINE r_end_no   LIKE glap_t.glapdocno
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_glaa121  LIKE glaa_t.glaa121
   DEFINE l_wc       STRING 
   DEFINE l_chr      LIKE type_t.chr1           
   DEFINE l_prog     LIKE gzza_t.gzza001        
   DEFINE p_lip      LIKE ooba_t.ooba002
   DEFINE p_nmdeld          LIKE nmde_t.nmdeld
   DEFINE p_nmde001         LIKE nmde_t.nmde001
   DEFINE p_nmde002         LIKE nmde_t.nmde002
   DEFINE p_nmdecomp        LIKE nmde_t.nmdecomp
   DEFINE p_nmdedocno       LIKE nmde_t.nmdedocno

   SELECT glaa024 INTO l_glaa024 FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = p_nmdeld
      
      LET sr.glapdocno = p_lip 
      LET sr.glapdocdt = g_today
      DISPLAY BY NAME sr.glapdocdt
      DISPLAY BY NAME sr.glapdocno
      
      LET l_wc =" glgbdocno = '",p_nmdedocno,"' "
         CALL s_pre_voucher_ins_glap('NM','N40',p_nmdeld,sr.glapdocdt,sr.glapdocno,'1',l_wc) 
              RETURNING r_success,r_start_no,r_end_no
         #151013-00019#13 add end---
         IF r_success = TRUE AND NOT cl_null(r_start_no) THEN
            UPDATE nmde_t SET nmde017=r_start_no
             WHERE nmdeent = g_enterprise AND nmdeld = p_nmdeld
               AND nmde001 = p_nmde001 AND nmde002 = p_nmde002
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "update nmde_t"
               LET g_errparam.code   = SQLCA.SQLCODE
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               LET r_success = FALSE
            END IF
            SELECT glaa121 INTO l_glaa121 FROM glaa_t WHERE glaaent = g_enterprise
               AND glaald = p_nmdeld
            IF l_glaa121 = 'Y' THEN
               LET l_wc = "glgadocno = '",p_nmdedocno,"'"
              #CALL s_pre_voucher_upd('NM','N40',g_nmde_m.nmdeld,'',r_start_no,g_today,l_wc) RETURNING l_success  #150707-00001#8 mark
               CALL s_pre_voucher_upd('NM','N40',p_nmdeld,'',r_start_no,sr.glapdocdt,l_wc) RETURNING l_success  #150707-00001#8
          
               IF l_success = FALSE THEN
                  LET r_success = FALSE
               END IF
            END IF
         END IF
         IF NOT r_success THEN
            CALL s_transaction_end('N','1')
            CALL cl_ask_confirm('axr-00120') RETURNING l_s
         ELSE
            DISPLAY r_start_no,r_end_no TO b_xrca038,e_xrca038
            CALL s_transaction_end('Y','1')
            CALL cl_ask_confirm('axr-00119') RETURNING l_s
         END IF
END FUNCTION

#end add-point
 
{</section>}
 
