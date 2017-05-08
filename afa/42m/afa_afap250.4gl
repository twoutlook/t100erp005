#該程式未解開Section, 採用最新樣板產出!
{<section id="afap250.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0010(2014-09-15 11:23:30), PR版次:0010(2017-01-06 10:19:17)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000314
#+ Filename...: afap250
#+ Description: 折舊底稿產生傳票作業
#+ Creator....: 02299(2014-02-27 14:40:19)
#+ Modifier...: 02114 -SD/PR- 02599
 
{</section>}
 
{<section id="afap250.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#160318-00005#9   2016/03/23 by 07675  將重複內容的錯誤訊息置換為公用錯誤訊息
#160318-00005#28  2016/04/05 by 07959  修正azzi920重复定义之错误讯息
#160125-00005#7   2016/08/09 By 01531  查詢時加上帳套人員權限條件過濾
#161111-00028#6   2016/11/21 by 06189  标准程式定义采用宣告模式,弃用.*写法
#170103-00019#12  2017/01/06 By 02599  产生凭证时，同步产生相应的细项立账资料    
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_schedule
#add-point:增加匯入項目 name="global.import"
#150916-00015#1  2015/12/7 By Xiaozg   1.快捷带出类似科目编号 2.当有账套时，科目检查改为检查是否存在于glad_t中
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_schedule.inc"
GLOBALS
   DEFINE gwin_curr2  ui.Window
   DEFINE gfrm_curr2  ui.Form
   DEFINE gi_hiden_asign       LIKE type_t.num5
   DEFINE gi_hiden_exec        LIKE type_t.num5
   DEFINE gi_hiden_spec        LIKE type_t.num5
   DEFINE gi_hiden_exec_end    LIKE type_t.num5
   DEFINE g_chk_jobid          LIKE type_t.num5
END GLOBALS
 
PRIVATE TYPE type_parameter RECORD
   #add-point:自定背景執行須傳遞的參數(Module Variable) name="global.parameter"
   
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       l_glaald LIKE type_t.chr500, 
   l_ld_desc LIKE type_t.chr80, 
   l_comp LIKE type_t.chr500, 
   l_comp_desc LIKE type_t.chr80, 
   l_acc LIKE type_t.chr500, 
   l_acc_desc LIKE type_t.chr80, 
   l_year LIKE type_t.chr500, 
   l_month LIKE type_t.chr500,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_detail_idx         LIKE type_t.num5              #單身 所在筆數(所有資料)
DEFINE g_detail_cnt         LIKE type_t.num5              #單身 總筆數(所有資料)
DEFINE l_ac      LIKE type_t.num5
TYPE type_g_glaq_d    RECORD
   l_number LIKE type_t.num10,
   glaqld   LIKE glaq_t.glaqld,
   glaq002  LIKE glaq_t.glaq002,
   glaq002_desc LIKE type_t.chr500,
   glaq018  LIKE glaq_t.glaq018,
   glaq018_desc LIKE type_t.chr500,
   glaq003  LIKE glaq_t.glaq003,
   glaq004  LIKE glaq_t.glaq004,
   glaq040  LIKE glaq_t.glaq040,
   glaq041  LIKE glaq_t.glaq041,
   glaq043  LIKE glaq_t.glaq043,
   glaq044  LIKE glaq_t.glaq044,
   type001  LIKE type_t.chr1
   END RECORD
DEFINE g_glaq_d DYNAMIC ARRAY OF type_g_glaq_d
DEFINE g_detail_idx1         LIKE type_t.num5
DEFINE l_ac1                LIKE type_t.num5
DEFINE g_rec_b1              LIKE type_t.num5
TYPE type_g_faam_d    RECORD
   l_number2 LIKE type_t.num10,
   faam001 LIKE faam_t.faam001,
   faam002 LIKE faam_t.faam002,
   faam007 LIKE faam_t.faam007,
   faam009 LIKE faam_t.faam009,
   faam011 LIKE faam_t.faam011,
   faam015 LIKE faam_t.faam015,
   faam014 LIKE faam_t.faam014,
   faam101 LIKE faam_t.faam101,
   faam105 LIKE faam_t.faam105,
   faam103 LIKE faam_t.faam103,
   faam151 LIKE faam_t.faam151,
   faam155 LIKE faam_t.faam155,
   faam153 LIKE faam_t.faam153,
   faam021 LIKE faam_t.faam021,
   faam022 LIKE faam_t.faam022
   END RECORD
TYPE type_g_faam2_d    RECORD
   faamld  LIKE faam_t.faamld,
   faam001 LIKE faam_t.faam001,
   faam002 LIKE faam_t.faam002,
   faam004 LIKE faam_t.faam004,
   faam005 LIKE faam_t.faam005,
   faam007 LIKE faam_t.faam007,
   faam011 LIKE faam_t.faam011,
   faam015 LIKE faam_t.faam015,
   faam014 LIKE faam_t.faam014,
   faam101 LIKE faam_t.faam101,
   faam105 LIKE faam_t.faam105,
   faam103 LIKE faam_t.faam103,
   faam151 LIKE faam_t.faam151,
   faam155 LIKE faam_t.faam155,
   faam153 LIKE faam_t.faam153,
   faam021 LIKE faam_t.faam021,
   faam022 LIKE faam_t.faam022,
   faam027 LIKE faam_t.faam027,
   faam009 LIKE faam_t.faam009,
   faam028 LIKE faam_t.faam028,
   faam029 LIKE faam_t.faam029,
   faam030 LIKE faam_t.faam030,
   faam031 LIKE faam_t.faam031,
   faam032 LIKE faam_t.faam032,
   faam033 LIKE faam_t.faam033,
   faam034 LIKE faam_t.faam034,
   faam035 LIKE faam_t.faam035,
   faam036 LIKE faam_t.faam036
   END RECORD
DEFINE g_faam2_d DYNAMIC ARRAY OF type_g_faam2_d
DEFINE g_faam2_d_t  type_g_faam2_d
DEFINE g_faam_d DYNAMIC ARRAY OF type_g_faam_d
DEFINE g_detail_idx2         LIKE type_t.num5
DEFINE l_ac2                 LIKE type_t.num5
DEFINE g_rec_b2              LIKE type_t.num5
DEFINE g_faamld    LIKE faam_t.faamld,
       g_faamld_desc LIKE type_t.chr500,
       g_faamcomp  LIKE glaa_t.glaacomp,
       g_faamcomp_desc LIKE type_t.chr500,
       g_faamacc   LIKE glaa_t.glaa004,
       g_faamacc_desc LIKE type_t.chr500,
       g_faamyear  LIKE faam_t.faam004,
       g_faammonth LIKE faam_t.faam005
DEFINE g_update_faam      LIKE type_t.chr1
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="afap250.main" >}
MAIN
   #add-point:main段define (客製用) name="main.define_customerization"
   
   #end add-point 
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter  
   #add-point:main段define name="main.define"
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   #end add-point 
  
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("afa","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL afap250_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_afap250 WITH FORM cl_ap_formpath("afa",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL afap250_init()
 
      #進入選單 Menu (="N")
      CALL afap250_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_afap250
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="afap250.init" >}
#+ 初始化作業
PRIVATE FUNCTION afap250_init()
 
   #add-point:init段define (客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:ui_dialog段define name="init.define"
   
   #end add-point
 
   LET g_error_show = 1
   LET gwin_curr2 = ui.Window.getCurrent()
   LET gfrm_curr2 = gwin_curr2.getForm()
   CALL cl_schedule_import_4fd()
   CALL cl_set_combo_scc("gzpa003","75")
   IF cl_get_para(g_enterprise,"","E-SYS-0005") = "N" THEN
       CALL cl_set_comp_visible("scheduling_page,history_page",FALSE)
   END IF 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('faam007','9912')
   LET g_update_faam = 'Y'
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="afap250.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION afap250_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_glav006 LIKE glav_t.glav006
   DEFINE ls_faamld    LIKE faam_t.faamld,
       ls_faamyear  LIKE faam_t.faam004,
       ls_faammonth LIKE faam_t.faam005
   DEFINE l_ld_str    STRING                #160125-00005#7       
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   CALL afap250_ui_dialog_1()
   RETURN
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.l_glaald,g_master.l_year,g_master.l_month 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glaald
            #add-point:BEFORE FIELD l_glaald name="input.b.l_glaald"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glaald
            
            #add-point:AFTER FIELD l_glaald name="input.a.l_glaald"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glaald
            #add-point:ON CHANGE l_glaald name="input.g.l_glaald"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_year
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_master.l_year,"0","0","","","azz-00079",1) THEN
               NEXT FIELD l_year
            END IF 
 
 
 
            #add-point:AFTER FIELD l_year name="input.a.l_year"
            IF NOT cl_null(g_master.l_year) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_year
            #add-point:BEFORE FIELD l_year name="input.b.l_year"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_year
            #add-point:ON CHANGE l_year name="input.g.l_year"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_month
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_master.l_month,"0","0","","","azz-00079",1) THEN
               NEXT FIELD l_month
            END IF 
 
 
 
            #add-point:AFTER FIELD l_month name="input.a.l_month"
            IF NOT cl_null(g_master.l_month) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_month
            #add-point:BEFORE FIELD l_month name="input.b.l_month"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_month
            #add-point:ON CHANGE l_month name="input.g.l_month"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.l_glaald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glaald
            #add-point:ON ACTION controlp INFIELD l_glaald name="input.c.l_glaald"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.l_glaald             #給予default值
            
            #給予arg
            #LET g_qryparam.arg1 = "" #160125-00005#7
            #LET g_qryparam.arg2 = "" #160125-00005#7

            #160125-00005#7  add--str--
            #账套范围
            LET g_qryparam.arg1 = g_user                                 #人員權限
            LET g_qryparam.arg2 = g_dept             
            CALL s_axrt300_get_site(g_user,'','2')  RETURNING l_ld_str 
            IF NOT cl_null(l_ld_str) THEN   
               LET g_qryparam.where = l_ld_str
            END IF
            #160125-00005#7  add--end
            
            CALL q_authorised_ld()                                #呼叫開窗

            LET g_master.l_glaald = g_qryparam.return1              

            DISPLAY g_master.l_glaald TO l_glaald              #

            NEXT FIELD l_glaald                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.l_year
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_year
            #add-point:ON ACTION controlp INFIELD l_year name="input.c.l_year"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_month
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_month
            #add-point:ON ACTION controlp INFIELD l_month name="input.c.l_month"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON l_glaald,l_year,l_month
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glaald
            #add-point:BEFORE FIELD l_glaald name="construct.b.l_glaald"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glaald
            
            #add-point:AFTER FIELD l_glaald name="construct.a.l_glaald"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.l_glaald
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glaald
            #add-point:ON ACTION controlp INFIELD l_glaald name="construct.c.l_glaald"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_year
            #add-point:BEFORE FIELD l_year name="construct.b.l_year"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_year
            
            #add-point:AFTER FIELD l_year name="construct.a.l_year"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.l_year
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_year
            #add-point:ON ACTION controlp INFIELD l_year name="construct.c.l_year"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_month
            #add-point:BEFORE FIELD l_month name="construct.b.l_month"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_month
            
            #add-point:AFTER FIELD l_month name="construct.a.l_month"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.l_month
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_month
            #add-point:ON ACTION controlp INFIELD l_month name="construct.c.l_month"
            
            #END add-point
 
 
 
            
            #add-point:其他管控 name="cs.other"
            
            #end add-point
            
         END CONSTRUCT
 
 
 
      
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT g_faamld,g_faamyear,g_faammonth FROM l_glaald,l_year,l_month
            BEFORE INPUT
               SELECT glaald INTO g_faamld FROM glaa_t
                WHERE glaaent = g_enterprise AND glaacomp = g_site
                  AND glaa014 = 'Y'
               LET g_faamyear = YEAR(g_today)
               LET g_faammonth = MONTH(g_today)
               
            AFTER FIELD l_glaald
               DISPLAY '' TO l_ld_desc
               DISPLAY '' TO l_comp
               DISPLAY '' TO l_comp_desc
               DISPLAY '' TO l_acc
               DISPLAY '' TO l_acc_desc
               IF NOT cl_null(g_faamld) THEN 
                  IF NOT afap250_ld_chk(g_faamld) THEN 
                     LET g_faamld = ''
                     DISPLAY '' TO l_ld_desc
                     DISPLAY '' TO l_comp
                     DISPLAY '' TO l_comp_desc
                     DISPLAY '' TO l_acc
                     DISPLAY '' TO l_acc_desc
                     NEXT FIELD l_glaald
                  END IF 
               END IF 
               CALL afap250_ld_ref(g_faamld,g_faamyear,g_faammonth) 
                  RETURNING g_faamld_desc,g_faamcomp,g_faamcomp_desc,g_faamacc,g_faamacc_desc,g_faamyear,g_faammonth
               DISPLAY g_faamld_desc TO l_ld_desc
               DISPLAY g_faamcomp TO l_comp
               DISPLAY g_faamcomp_desc TO l_comp_desc
               DISPLAY g_faamacc TO l_acc
               DISPLAY g_faamacc_desc TO l_acc_desc
               CALL afap250_fisrt_body_fill()
               CALL afap250_second_body_fill()
               
            ON ACTION controlp INFIELD l_glaald
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_faamld             #給予default值
               #給予arg
               LET g_qryparam.arg1 = g_user
               LET g_qryparam.arg2 = g_dept
               LET g_qryparam.where = " (glaa014 = 'Y' OR glaa008 = 'Y') "
               #160125-00005#7  add--str--
               #账套范围
               LET g_qryparam.arg1 = g_user                                 #人員權限
               LET g_qryparam.arg2 = g_dept             
               CALL s_axrt300_get_site(g_user,'','2')  RETURNING l_ld_str 
               IF NOT cl_null(l_ld_str) THEN   
                  LET g_qryparam.where = g_qryparam.where," AND ",l_ld_str
               END IF
               #160125-00005#7  add--end               
               CALL q_authorised_ld()                                  #呼叫開窗
               LET g_faamld = g_qryparam.return1
               DISPLAY g_faamld TO l_glaald
               CALL afap250_ld_ref(g_faamld,g_faamyear,g_faammonth) 
                  RETURNING g_faamld_desc,g_faamcomp,g_faamcomp_desc,g_faamacc,g_faamacc_desc,g_faamyear,g_faammonth
               DISPLAY g_faamld_desc TO l_ld_desc
               DISPLAY g_faamcomp TO l_comp
               DISPLAY g_faamcomp_desc TO l_comp_desc
               DISPLAY g_faamacc TO l_acc
               DISPLAY g_faamacc_desc TO l_acc_desc
               CALL afap250_fisrt_body_fill()
               CALL afap250_second_body_fill()
               
            AFTER FIELD l_year
               IF NOT cl_null(g_faamyear) THEN 
                  IF g_faamyear <= 0 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = ''
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD l_year
                  END IF 
               END IF 
               CALL afap250_fisrt_body_fill()
               CALL afap250_second_body_fill()
               
            BEFORE FIELD l_month
               IF cl_null(g_faamyear) THEN 
                  NEXT FIELD l_year
               END IF 
            
            AFTER FIELD l_month
               IF NOT cl_null(g_faammonth) THEN 
                  IF g_faammonth <= 0 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = ''
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD l_month
                  END IF 
                  SELECT max(glav006) INTO l_glav006 FROM glav_t WHERE glavent = g_enterprise
                     AND glav001 = g_faamacc AND glav002 = g_faamyear
                  IF g_faammonth > l_glav006 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = ''
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD l_month
                  END IF 
               END IF
               CALL afap250_fisrt_body_fill()
               CALL afap250_second_body_fill()
               
            ON ACTION act_generate
               CALL afap250_fisrt_body_fill()
               CALL afap250_second_body_fill()
            ON ACTION act_throw
               CALL afap250_throw()
               CALL afap250_fisrt_body_fill()
               CALL afap250_second_body_fill()
         END INPUT
         
         DISPLAY ARRAY g_glaq_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b1) #page1

            BEFORE ROW
               LET l_ac1 = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx1 = l_ac1
               DISPLAY g_detail_idx1 TO h_index

            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx1)
               LET l_ac1 = DIALOG.getCurrentRow("s_detail1")
               DISPLAY g_rec_b1 TO h_count

#            ON ACTION afap250_s01
#               IF l_ac1 <= g_glaq_d.getLength() AND l_ac1 != 0 THEN
#                  CALL afap250_s01(g_faamld,g_faamyear,g_faammonth,g_glaq_d[l_ac1].glaq002,g_glaq_d[l_ac1].glaq018)
#                  CALL afap250_fisrt_body_fill()
#                  CALL afap250_second_body_fill()
#               END IF
         END DISPLAY
         DISPLAY ARRAY g_faam_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b2) #page1

            BEFORE ROW
               LET l_ac2 = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx2 = l_ac2
               DISPLAY g_detail_idx2 TO h_index

            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx1)
               LET l_ac2 = DIALOG.getCurrentRow("s_detail2")
               DISPLAY g_rec_b2 TO h_count
               
            ON ACTION afap250_s01
               IF l_ac1 <= g_glaq_d.getLength() AND l_ac1 != 0 THEN
#                  CALL afap250_s01(g_faamld,g_faamyear,g_faammonth,g_faam_d[l_ac2].faam021,g_faam_d[l_ac2].faam022)
                  CALL afap250_s01(g_faamld,g_faamyear,g_faammonth)
                  CALL afap250_fisrt_body_fill()
                  CALL afap250_second_body_fill()
               END IF
               
         END DISPLAY  
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         
         #end add-point
 
         SUBDIALOG lib_cl_schedule.cl_schedule_setting
         SUBDIALOG lib_cl_schedule.cl_schedule_setting_exec_call
         SUBDIALOG lib_cl_schedule.cl_schedule_select_show_history
         SUBDIALOG lib_cl_schedule.cl_schedule_show_history
 
         BEFORE DIALOG
            LET l_dialog = ui.DIALOG.getCurrent()
            CALL afap250_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            
            #end add-point
 
         ON ACTION batch_execute
            LET g_action_choice = "batch_execute"
            ACCEPT DIALOG
 
         #add-point:ui_dialog段before_qbeclear name="ui_dialog.before_qbeclear"
         
         #end add-point
 
         ON ACTION qbeclear         
            CLEAR FORM
            INITIALIZE g_master.* TO NULL   #畫面變數清空
            INITIALIZE lc_param.* TO NULL   #傳遞參數變數清空
            #add-point:ui_dialog段qbeclear name="ui_dialog.qbeclear"
            
            #end add-point
 
         ON ACTION history_fill
            CALL cl_schedule_history_fill()
 
         ON ACTION close
            LET INT_FLAG = TRUE
            EXIT DIALOG
         
         ON ACTION exit
            LET INT_FLAG = TRUE
            EXIT DIALOG
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION accept
            ACCEPT DIALOG
 
         ON ACTION cancel
            LET INT_FLAG = TRUE
            EXIT DIALOG 
         #end add-point
 
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM   
         INITIALIZE g_master.* TO NULL
         LET g_wc  = ' 1=2'
         LET g_action_choice = ""
         CALL afap250_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      LET ls_faamld = g_faamld
      LET ls_faamyear = g_faamyear
      LET ls_faammonth = g_faammonth
      #end add-point
 
      LET ls_js = util.JSON.stringify(lc_param)  #r類使用g_master/p類使用lc_param
 
      IF INT_FLAG THEN
         LET INT_FLAG = FALSE
         EXIT WHILE
      ELSE
         IF g_chk_jobid THEN 
            LET g_jobid = g_schedule.gzpa001
         ELSE 
            LET g_jobid = cl_schedule_get_jobid(g_prog)
         END IF 
 
         #依照指定模式執行報表列印
         CASE 
            WHEN g_schedule.gzpa003 = "0"
                 CALL afap250_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = afap250_transfer_argv(ls_js)
                 CALL cl_cmdrun(ls_js)
 
            WHEN g_schedule.gzpa003 = "2"
                 CALL cl_schedule_update_data(g_jobid,ls_js)
 
            WHEN g_schedule.gzpa003 = "3"
                 CALL cl_schedule_update_data(g_jobid,ls_js)
         END CASE  
 
         IF g_schedule.gzpa003 = "2" OR g_schedule.gzpa003 = "3" THEN 
            CALL cl_ask_confirm3("std-00014","") #設定完成
         END IF    
         LET g_schedule.gzpa003 = "0" #預設一開始 立即於前景執行
 
         #add-point:ui_dialog段after schedule name="process.after_schedule"
         
         #end add-point
 
         #欄位初始資訊 
         CALL cl_schedule_init_info("all",g_schedule.gzpa003) 
         LET gi_hiden_asign = FALSE 
         LET gi_hiden_exec = FALSE 
         LET gi_hiden_spec = FALSE 
         LET gi_hiden_exec_end = FALSE 
         CALL cl_schedule_hidden()
      END IF
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="afap250.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION afap250_transfer_argv(ls_js)
 
   #add-point:transfer_agrv段define (客製用) name="transfer_agrv.define_customerization"
   
   #end add-point
   DEFINE ls_js       STRING
   DEFINE la_cmdrun   RECORD
             prog       STRING,
             actionid   STRING,
             background LIKE type_t.chr1,
             param      DYNAMIC ARRAY OF STRING
                  END RECORD
   DEFINE la_param    type_parameter
   #add-point:transfer_agrv段define name="transfer_agrv.define"
   
   #end add-point
 
   LET la_cmdrun.prog = g_prog
   LET la_cmdrun.background = "Y"
   LET la_cmdrun.param[1] = ls_js
 
   #add-point:transfer.argv段程式內容 name="transfer.argv.define"
   
   #end add-point
 
   RETURN util.JSON.stringify( la_cmdrun )
END FUNCTION
 
{</section>}
 
{<section id="afap250.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION afap250_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
 
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE afap250_process_cs CURSOR FROM ls_sql
#  FOREACH afap250_process_cs INTO
   #add-point:process段process name="process.process"
 
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
      CALL afap250_throw()
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      CALL afap250_throw()
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL afap250_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="afap250.get_buffer" >}
PRIVATE FUNCTION afap250_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.l_glaald = p_dialog.getFieldBuffer('l_glaald')
   LET g_master.l_year = p_dialog.getFieldBuffer('l_year')
   LET g_master.l_month = p_dialog.getFieldBuffer('l_month')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="afap250.msgcentre_notify" >}
PRIVATE FUNCTION afap250_msgcentre_notify()
 
   #add-point:process段define (客製用) name="msgcentre_notify.define_customerization"
   
   #end add-point
   DEFINE lc_state LIKE type_t.chr5
   #add-point:process段define name="msgcentre_notify.define"
   
   #end add-point
 
   INITIALIZE g_msgparam TO NULL
 
   #action-id與狀態填寫
   LET g_msgparam.state = "process"
 
   #add-point:msgcentre其他通知 name="msg_centre.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="afap250.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"
################################################################################
# Descriptions...: 带值
# Memo...........:
# Usage..........: CALL afap250_ld_ref(p_faamld,p_glaa010,p_glaa011) 
#                  RETURNING r_faamld_desc,r_faamcomp,r_faamcomp_desc,r_faamacc,r_faamacc_desc
# Input parameter: p_faamld 帐套别,p_glaa010,p_glaa011
# Return code....: r_faamld_desc,r_faamcomp,r_faamcomp_desc,r_faamacc,r_faamacc_desc,r_glaa010,r_glaa011
################################################################################
PRIVATE FUNCTION afap250_ld_ref(p_faamld,p_glaa010,p_glaa011)
   DEFINE p_faamld LIKE glaa_t.glaald
   DEFINE p_glaa010 LIKE glaa_t.glaa010
   DEFINE p_glaa011 LIKE glaa_t.glaa011
   DEFINE l_glaa015 LIKE glaa_t.glaa015
   DEFINE l_glaa016 LIKE glaa_t.glaa016
   DEFINE l_glaa019 LIKE glaa_t.glaa019
   DEFINE l_glaa020 LIKE glaa_t.glaa020
   DEFINE l_dzeb003 LIKE dzeb_t.dzeb003
   DEFINE r_faamld_desc LIKE type_t.chr500,
          r_faamcomp  LIKE glaa_t.glaacomp,
          r_faamcomp_desc LIKE type_t.chr500,
          r_faamacc   LIKE glaa_t.glaa004,
          r_faamacc_desc LIKE type_t.chr500,
          r_glaa010 LIKE glaa_t.glaa010,
          r_glaa011 LIKE glaa_t.glaa011
   
   LET r_faamld_desc = ''
   LET r_faamcomp = ''
   LET r_faamcomp_desc = ''
   LET r_faamacc = ''
   LET r_faamacc_desc = ''
   
   SELECT glaal002,glaacomp,ooefl003,glaa004,ooall004,glaa010,glaa011
     INTO r_faamld_desc,r_faamcomp,r_faamcomp_desc,r_faamacc,r_faamacc_desc,r_glaa010,r_glaa011
     FROM glaa_t LEFT OUTER JOIN glaal_t ON glaaent = glaalent AND glaald = glaalld AND glaal001 = g_dlang 
     LEFT OUTER JOIN ooefl_t ON ooeflent = glaaent AND ooefl001 = glaacomp AND ooefl002 = g_dlang 
     LEFT OUTER JOIN ooall_t ON ooallent = glaaent AND ooall001 = '0' AND ooall002 = glaa004 AND ooall003 = g_dlang
#    WHERE glaaent = '99' AND glaald = p_faamld             #chenying mark
    WHERE glaaent = g_enterprise AND glaald = p_faamld      #chenying add
   IF (NOT cl_null(p_glaa010) AND p_glaa010 != 0) AND (NOT cl_null(p_glaa011) AND p_glaa011 != 0) THEN 
      LET r_glaa010 = p_glaa010
      LET r_glaa011 = p_glaa011
   END IF 
   
   CALL afap250_current_chk(p_faamld) RETURNING l_glaa015,l_glaa016,l_glaa019,l_glaa020
   IF l_glaa015 = 'Y' THEN
      CALL cl_set_comp_visible('glaq040,glaq041,faam101,faam105,faam103',TRUE)
      SELECT dzeb003 INTO l_dzeb003 FROM dzeb_t WHERE dzeb001 = 'glaq_t' AND dzeb002 = 'glaq003'
      CALL cl_set_comp_att_text('glaq040',l_dzeb003||"("||l_glaa016||")")
      SELECT dzeb003 INTO l_dzeb003 FROM dzeb_t WHERE dzeb001 = 'glaq_t' AND dzeb002 = 'glaq004'
      CALL cl_set_comp_att_text('glaq041',l_dzeb003||"("||l_glaa016||")")
   ELSE
      CALL cl_set_comp_visible('glaq040,glaq041,faam101,faam105,faam103',FALSE)
   END IF 
   IF l_glaa019 = 'Y' THEN
      CALL cl_set_comp_visible('glaq043,glaq044,faam151,faam155,faam153',TRUE)
      SELECT dzeb003 INTO l_dzeb003 FROM dzeb_t WHERE dzeb001 = 'glaq_t' AND dzeb002 = 'glaq003'
      CALL cl_set_comp_att_text('glaq043',l_dzeb003||"("||l_glaa020||")")
      SELECT dzeb003 INTO l_dzeb003 FROM dzeb_t WHERE dzeb001 = 'glaq_t' AND dzeb002 = 'glaq004'
      CALL cl_set_comp_att_text('glaq044',l_dzeb003||"("||l_glaa020||")")
   ELSE
      CALL cl_set_comp_visible('glaq043,glaq044,faam151,faam155,faam153',FALSE)
   END IF 
   RETURN r_faamld_desc,r_faamcomp,r_faamcomp_desc,r_faamacc,r_faamacc_desc,r_glaa010,r_glaa011
END FUNCTION
################################################################################
# Descriptions...: 帐别检查
# Memo...........:
# Usage..........: CALL afap250_ld_chk(p_ld)
#                  RETURNING r_success
# Input parameter: p_ld   账套别
# Return code....: r_success 成功否
################################################################################
PRIVATE FUNCTION afap250_ld_chk(p_ld)
   DEFINE p_ld LIKE glaa_t.glaald
   DEFINE r_success LIKE type_t.num5
   DEFINE l_glaald LIKE glaa_t.glaald
   DEFINE l_glaa014 LIKE glaa_t.glaa014
   DEFINE l_glaa008 LIKE glaa_t.glaa008
   DEFINE l_glaastus LIKE glaa_t.glaastus
   
   LET r_success = TRUE 
   
   SELECT glaald,glaa014,glaa008,glaastus INTO l_glaald,l_glaa014,l_glaa008,l_glaastus
     FROM glaa_t WHERE glaaent = g_enterprise AND glaald = p_ld
     
   IF cl_null(l_glaald) THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00016'
      LET g_errparam.extend = p_ld
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
   ELSE
      IF l_glaastus != 'Y' THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  'sub-01302' #'agl-00051' #160318-00005#9 mod
         LET g_errparam.extend = p_ld
         #160318-00005#9 --add--str
         LET g_errparam.replace[1] ='agli010'
         LET g_errparam.replace[2] = cl_get_progname('agli010',g_lang,"2")
         LET g_errparam.exeprog    ='agli010'
         #160318-00005#9 --add--end
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
      ELSE
         CALL s_ld_chk_authorization(g_user,p_ld) RETURNING r_success
         IF r_success = FALSE THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'axr-00022'
            LET g_errparam.extend = p_ld
            LET g_errparam.popup = TRUE
            CALL cl_err()

         ELSE
            IF l_glaa014 = 'Y' OR l_glaa008 = 'Y' THEN 
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axr-00021'
               LET g_errparam.extend = p_ld
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET r_success = FALSE
            END IF 
         END IF
      END IF 
   END IF 
    
   RETURN r_success
END FUNCTION
#填充第一个单身
PRIVATE FUNCTION afap250_fisrt_body_fill()
   DEFINE ls_cnt LIKE type_t.num10
   DEFINE ls_sql STRING
   
   CALL g_glaq_d.clear()
   LET ls_sql = "SELECT '',faamld,faam022,'',faam009,ooefl003,sum(faam013),0,sum(faam104),0,sum(faam154),0,'' FROM faam_t ",
                "  LEFT OUTER JOIN ooefl_t ON ooeflent = faament AND ooefl001 = faam009 AND ooefl002 = '",g_dlang,"'",
                " WHERE faament = '",g_enterprise,"' AND faamld = '",g_faamld,"' ",
                "   AND faam007 IN ('1','3') AND faam006 = '1' ",
                "   AND (faam024 IS NULL OR faam024 = '' ) ",
                "   AND faam004 = '",g_faamyear,"' AND faam005 = '",g_faammonth,"' ",
                " GROUP BY faamld,faam022,faam009,ooefl003 ",
                " UNION ",
                "SELECT '',faamld,faam021,'',faam009,ooefl003,0,sum(faam013),0,sum(faam104),0,sum(faam154),'' FROM faam_t ",
                "  LEFT OUTER JOIN ooefl_t ON ooeflent = faament AND ooefl001 = faam009 AND ooefl002 = '",g_dlang,"'",
                " WHERE faament = '",g_enterprise,"' AND faamld = '",g_faamld,"' ",
                "   AND faam007 IN ('1','3') AND faam006 = '1' ",
                "   AND (faam024 IS NULL OR faam024 = '' ) ",
                "   AND faam004 = '",g_faamyear,"' AND faam005 = '",g_faammonth,"' ",
                " GROUP BY faamld,faam021,faam009,ooefl003 "
   PREPARE afap250_first_body_pre FROM ls_sql
   DECLARE afap250_first_body_cs CURSOR FOR afap250_first_body_pre
   LET ls_cnt = 1
   FOREACH afap250_first_body_cs INTO g_glaq_d[ls_cnt].*
      LET g_glaq_d[ls_cnt].l_number = ls_cnt
      
      SELECT glacl004 INTO g_glaq_d[ls_cnt].glaq002_desc
        FROM glacl_t 
       WHERE glaclent =g_enterprise AND glacl001 = g_faamacc AND glacl003 = g_dlang 
         AND glacl002 = g_glaq_d[ls_cnt].glaq002
      LET g_glaq_d[ls_cnt].glaq002_desc = g_glaq_d[ls_cnt].glaq002,'\n',g_glaq_d[ls_cnt].glaq002_desc,'\n',g_glaq_d[ls_cnt].glaq018_desc
      LET ls_cnt = ls_cnt + 1
   END FOREACH
   CALL g_glaq_d.deleteElement(g_glaq_d.getLength())
   LET g_rec_b1 = g_glaq_d.getLength()
END FUNCTION
#填充第二个单身
PRIVATE FUNCTION afap250_second_body_fill()
   DEFINE ls_cnt LIKE type_t.num10
   DEFINE ls_sql STRING
   
   CALL g_faam_d.clear()
   LET ls_sql = "SELECT '',faam001,faam002,faam007,faam009,faam011,faam015,faam014, ",
                "       faam101,faam105,faam103,faam151,faam155,faam153,faam021,faam022 FROM faam_t ",
                " WHERE faament = '",g_enterprise,"' AND faamld = '",g_faamld,"' ",
                "   AND faam007 IN ('1','3') AND faam006 = '1' ",
                "   AND (faam024 IS NULL OR faam024 = '' ) ",
                "   AND faam004 = '",g_faamyear,"' AND faam005 = '",g_faammonth,"' ",
                " ORDER BY faam001,faam002 "
   PREPARE afap250_second_body_pre FROM ls_sql
   DECLARE afap250_second_body_cs CURSOR FOR afap250_second_body_pre
   LET ls_cnt = 1
   FOREACH afap250_second_body_cs INTO g_faam_d[ls_cnt].*
      LET g_faam_d[ls_cnt].l_number2 = ls_cnt
      LET ls_cnt = ls_cnt + 1
   END FOREACH
   CALL g_faam_d.deleteElement(g_faam_d.getLength())
   LET g_rec_b2 = g_faam_d.getLength()
END FUNCTION
#控制子画面
PRIVATE FUNCTION afap250_s01(p_faamld,p_faam004,p_faam005)
   DEFINE p_faamld LIKE faam_t.faamld
   DEFINE p_faam004 LIKE faam_t.faam004
   DEFINE p_faam005 LIKE faam_t.faam005
#   DEFINE p_glaq002 LIKE glaq_t.glaq002
#   DEFINE p_faam009 LIKE faam_t.faam009
   DEFINE l_allow_insert LIKE type_t.num5
   DEFINE l_allow_delete LIKE type_t.num5
   DEFINE l_success LIKE type_t.num5
   DEFINE l_str     STRING
   DEFINE l_date    LIKE ooed_t.ooed006   #接受s_get_orga返回值
   DEFINE l_errno   LIKE type_t.chr10
   DEFINE l_wc      STRING 
   DEFINE ls_sql    STRING
   DEFINE l_glaa015 LIKE glaa_t.glaa015
   DEFINE l_glaa016 LIKE glaa_t.glaa016
   DEFINE l_glaa019 LIKE glaa_t.glaa019
   DEFINE l_glaa020 LIKE glaa_t.glaa020
   #ADDBYXZG20151201
   DEFINE l_sql                  STRING
   DEFINE l_glaa004              LIKE  glaa_t.glaa004 
   #ADDBYXZG20151201
   DEFINE l_lock_sw              LIKE type_t.chr1                #單身鎖住否
   DEFINE l_cmd                  LIKE type_t.chr1
   
   OPEN WINDOW w_afap250_s01 WITH FORM cl_ap_formpath("afa","afap250_s01")
   CALL cl_ui_init()
   CALL cl_set_combo_scc('faam007','9912')
    CALL afap250_current_chk(p_faamld) RETURNING l_glaa015,l_glaa016,l_glaa019,l_glaa020
   IF l_glaa015 = 'Y' THEN
      CALL cl_set_comp_visible('faam101,faam105,faam103',TRUE)
   ELSE
      CALL cl_set_comp_visible('faam101,faam105,faam103',FALSE)
   END IF 
   IF l_glaa019 = 'Y' THEN
      CALL cl_set_comp_visible('faam151,faam155,faam153',TRUE)
   ELSE
      CALL cl_set_comp_visible('faam151,faam155,faam153',FALSE)
   END IF
   LET l_allow_insert = FALSE
   LET l_allow_delete = FALSE
   LET l_wc = " faamld = '",p_faamld,"' AND faam004 = '",p_faam004,"' AND faam005 = '",p_faam005,"' "
#   IF NOT cl_null(p_faam009) THEN
#      LET l_wc = l_wc CLIPPED," AND faam009 = '",p_faam009,"'"
#   END IF
#   IF NOT cl_null(p_glaq002) THEN
#      LET l_wc = l_wc CLIPPED," AND (faam021 = '",p_glaq002,"' OR faam022 = '",p_glaq002,"') "
#   END IF   
   LET ls_sql = "SELECT faamld,faam001,faam002,faam004,faam005,faam007,faam011,faam015,faam014,faam101,",
                "       faam105,faam103,faam151,faam155,faam153,faam021,faam022,faam027,faam009,faam028,faam029,",
                "       faam030,faam031,faam032,faam033,faam034,faam035,faam036 FROM afap250_faam_tmp ",
                " WHERE faament = '",g_enterprise,"' AND faam007 IN ('1','3') AND faam006 = '1' ",
                " AND faamld = '",p_faamld,"' AND faam004 = '",p_faam004,"' AND faam005 = '",p_faam005,"' ",
                "   AND faam001 = ? AND faam002 = ? "
                #"   AND ",l_wc
   PREPARE afap250_pre FROM ls_sql
   DECLARE afap250_bcl CURSOR FOR afap250_pre
   CALL afap250_s01_set_entry('')
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
       #Page1 預設值產生於此處
      INPUT ARRAY g_faam2_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
         BEFORE INPUT
            CALL afap250_s01_b_fill(l_wc)
         BEFORE ROW
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail3")
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT

#            CALL s_transaction_begin()
            LET g_update_faam = 'Y'
            LET g_detail_cnt = g_faam2_d.getLength()
#            IF g_detail_cnt >= l_ac AND g_faam2_d[l_ac].faam001 IS NOT NULL THEN
               LET l_cmd='u'
#               LET g_faam2_d_t.* = g_faam2_d[l_ac].*  #BACKUP
#               IF NOT afap250_lock_b("faam") THEN
#                  LET l_lock_sw='Y'
#               ELSE
#                  FETCH afap250_bcl INTO g_faam2_d[l_ac].*
#                  IF SQLCA.sqlcode THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = SQLCA.sqlcode
#                     LET g_errparam.extend = g_faam2_d_t.faam001||g_faam2_d_t.faam002
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#
#                     LET l_lock_sw = "Y"
#                  END IF
#                  CALL cl_show_fld_cont()
#               END IF
#            ELSE
#               LET l_cmd='a'
#            END IF
            CALL afap250_s01_set_entry(g_faam2_d_t.faam022)
         BEFORE INSERT
         
         #累折科目
         AFTER FIELD faam021
            IF NOT cl_null(g_faam2_d[l_ac].faam021) THEN
                #  150916-00015#1 BEGIN    快捷带出类似科目编号     ADD BY XZG201511201
              LET l_sql =""
              IF  s_aglt310_getlike_lc_subject(g_faamld,g_faam2_d[l_ac].faam021,l_sql) THEN
                 INITIALIZE g_qryparam.* TO NULL
                 SELECT glaa004 INTO l_glaa004
                  FROM glaa_t
                 WHERE glaaent = g_enterprise
                   AND glaald = g_faamld
                LET g_qryparam.state = 'i'
                LET g_qryparam.reqry = 'FALSE'
                LET g_qryparam.default1 = g_faam2_d[l_ac].faam021
                
                LET g_qryparam.arg1 = l_glaa004
                LET g_qryparam.arg2 = g_faam2_d[l_ac].faam021
                LET g_qryparam.arg3 = g_faamld
                LET g_qryparam.arg4 = "1 "
                CALL q_glac002_6()
                LET g_faam2_d[l_ac].faam021 = g_qryparam.return1
                DISPLAY g_faam2_d[l_ac].faam021 TO faam021             #顯示到畫面上
              END IF
              IF NOT s_aglt310_lc_subject(g_faamld,g_faam2_d[l_ac].faam021,'N') THEN
                 LET g_faam2_d[l_ac].faam021 = g_faam2_d_t.faam021
                  NEXT FIELD faam021
              END IF
              
              #  150916-00015#1 END
               CALL afap250_glap006_chk(g_faam2_d[l_ac].faam021)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_faam2_d[l_ac].faam021
                  #160318-00005#9 --add--str
                  LET g_errparam.replace[1] ='agli020'
                  LET g_errparam.replace[2] = cl_get_progname('agli020',g_lang,"2")
                  LET g_errparam.exeprog    ='agli020'
                  #160318-00005#9 --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_faam2_d[l_ac].faam021 = g_faam2_d_t.faam021
                  NEXT FIELD faam021
               END IF
            END IF
         ON ACTION controlp INFIELD faam021
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'
            LET g_qryparam.default1 = g_faam2_d[l_ac].faam021            #給予default值
            #給予arg
            LET g_qryparam.where = "glac001 = '",g_faamacc,"' AND  glac003 <>'1' AND glac006 = '1'",
                                    " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   "AND gladld='",g_faamld,"' AND gladent='",g_enterprise,"'",
                                   " AND gladstus = 'Y' )"
            CALL aglt310_04()                                #呼叫開窗
            LET g_faam2_d[l_ac].faam021 = g_qryparam.return1
            DISPLAY g_faam2_d[l_ac].faam021 TO faam021             #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD faam021
         #折旧科目
         AFTER FIELD faam022
            IF NOT cl_null(g_faam2_d[l_ac].faam022) THEN
                  #  150916-00015#1 BEGIN    快捷带出类似科目编号     ADD BY XZG201511201
              LET l_sql =""
              IF  s_aglt310_getlike_lc_subject(g_faamld,g_faam2_d[l_ac].faam022,l_sql) THEN
                 INITIALIZE g_qryparam.* TO NULL
                 SELECT glaa004 INTO l_glaa004
                  FROM glaa_t
                 WHERE glaaent = g_enterprise
                   AND glaald = g_faamld
                LET g_qryparam.state = 'i'
                LET g_qryparam.reqry = 'FALSE'
                LET g_qryparam.default1 = g_faam2_d[l_ac].faam022
                
                LET g_qryparam.arg1 = l_glaa004
                LET g_qryparam.arg2 = g_faam2_d[l_ac].faam022
                LET g_qryparam.arg3 = g_faamld
                LET g_qryparam.arg4 = "1 "
                CALL q_glac002_6()
               LET g_faam2_d[l_ac].faam022 = g_qryparam.return1
               DISPLAY g_faam2_d[l_ac].faam022 TO faam022             #顯示到畫面上
              END IF
               IF NOT s_aglt310_lc_subject(g_faamld,g_faam2_d[l_ac].faam022,'N') THEN
                  LET g_faam2_d[l_ac].faam022 = g_faam2_d_t.faam022
                  NEXT FIELD faam022
               END IF
              #  150916-00015#1 END
               CALL afap250_glap006_chk(g_faam2_d[l_ac].faam022)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_faam2_d[l_ac].faam022
                  #160318-00005#9 --add--str
                  LET g_errparam.replace[1] ='agli020'
                  LET g_errparam.replace[2] = cl_get_progname('agli020',g_lang,"2")
                  LET g_errparam.exeprog    ='agli020'
                  #160318-00005#9 --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_faam2_d[l_ac].faam022 = g_faam2_d_t.faam022
                  NEXT FIELD faam022
               END IF
               CALL afap250_s01_set_entry(g_faam2_d_t.faam022)
            END IF 
         ON ACTION controlp INFIELD faam022
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'
            LET g_qryparam.default1 = g_faam2_d[l_ac].faam022            #給予default值
            #給予arg
            LET g_qryparam.where = "glac001 = '",g_faamacc,"' AND  glac003 <>'1' AND glac006 = '1'",
                                    " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   "AND gladld='",g_faamld,"' AND gladent='",g_enterprise,"'",
                                   " AND gladstus = 'Y' )"
            CALL aglt310_04()                                #呼叫開窗
            LET g_faam2_d[l_ac].faam022 = g_qryparam.return1
            DISPLAY g_faam2_d[l_ac].faam022 TO faam022             #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD faam022 
         #营运据点
         AFTER FIELD faam027
            IF NOT cl_null(g_faam2_d[l_ac].faam027 ) THEN
              CALL s_get_orga('2',g_faam2_d[l_ac].faam027 ,'',g_today)
              RETURNING l_success,g_faam2_d[l_ac].faam027 ,l_str,l_str,l_date,l_date,l_errno
              IF l_success = FALSE THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = l_errno
                 LET g_errparam.extend = g_faam2_d[l_ac].faam027
                 LET g_errparam.popup = TRUE
                 CALL cl_err()

                 LET g_faam2_d[l_ac].faam027  = g_faam2_d_t.faam027 
                 NEXT FIELD faam027
              END IF
            END IF
            
         ON ACTION controlp INFIELD faam027
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'
            LET g_qryparam.default1 = g_faam2_d[l_ac].faam027            #給予default值

            #給予arg
            LET g_qryparam.where ="ooed001 = '2' AND ooed006<='",g_today,"' AND (ooed007 IS NULL OR ooed007 >='",g_today,"')"
            CALL q_ooed004_1()                                      #呼叫開窗

            LET g_faam2_d[l_ac].faam027 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_faam2_d[l_ac].faam027 TO faam027
            
         #部门
         AFTER FIELD faam009
             IF NOT cl_null(g_faam2_d[l_ac].faam009) THEN
               CALL s_get_orga('6',g_faam2_d[l_ac].faam009,'',g_today)
               RETURNING l_success,g_faam2_d[l_ac].faam009,l_str,l_str,l_date,l_date,l_errno
               IF l_success = FALSE THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_faam2_d[l_ac].faam009
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_faam2_d[l_ac].faam009 = g_faam2_d_t.faam009
                  NEXT FIELD faam009
               END IF
            END IF
         ON ACTION controlp INFIELD faam009
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'
            LET g_qryparam.default1 = g_faam2_d[l_ac].faam009             
            LET g_qryparam.where ="ooed001 = '6' AND ooed006<='",g_today,"' AND (ooed007 IS NULL OR ooed007 >='",g_today,"')"
            CALL q_ooed004_1()                                #呼叫開窗
            LET g_qryparam.where =''
            LET g_faam2_d[l_ac].faam009 = g_qryparam.return1
            DISPLAY g_faam2_d[l_ac].faam009 TO faam009
            NEXT FIELD faam009
            
#         #交易对象
#         AFTER FIELD faam031
#            IF NOT cl_null(g_faam2_d[l_ac].faam031) THEN
#               CALL afap250_businessman_chk(g_faam2_d[l_ac].faam031) 
#               IF NOT cl_null(g_errno) THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = g_errno
#                  LET g_errparam.extend = g_faam2_d[l_ac].faam031
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
#
#                  LET g_faam2_d[l_ac].faam031 = g_faam2_d_t.faam031
#                  NEXT FIELD faam031
#               END IF 
#            END IF
#         ON ACTION controlp INFIELD faam031
#            INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.reqry = FALSE
#            LET g_qryparam.state = 'i'
#            LET g_qryparam.default1 = g_faam2_d[l_ac].faam031             #給予default值
#            CALL q_pmaa001()                                #呼叫開窗
#            LET g_faam2_d[l_ac].faam031 = g_qryparam.return1              #將開窗取得的值回傳到變數
#            DISPLAY g_faam2_d[l_ac].faam031 TO faam031              #顯示到畫面上
#            NEXT FIELD faam026


        AFTER FIELD faam028
           IF NOT cl_null(g_faam2_d[l_ac].faam028) THEN 
              #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
              INITIALIZE g_chkparam.* TO NULL          
              LET g_errshow = TRUE #是否開窗 #160318-00025#28  add
              #設定g_chkparam.*的參數
              LET g_chkparam.arg1 = g_faam2_d[l_ac].faam028
              LET g_chkparam.arg2 = g_today               
              LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"#要執行的建議程式待補#160318-00025#28  add
              #呼叫檢查存在並帶值的library
              IF cl_chk_exist("v_ooeg001") THEN
                 #檢查成功時後續處理
                 #LET  = g_chkparam.return1
                 #DISPLAY BY NAME 
              ELSE
                 #檢查失敗時後續處理
                 LET g_faam2_d[l_ac].faam028 = g_faam2_d_t.faam028
                 NEXT FIELD CURRENT
              END IF          
           END IF 

        AFTER FIELD faam029
             IF NOT cl_null(g_faam2_d[l_ac].faam029) THEN 
                #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                INITIALIZE g_chkparam.* TO NULL              
                LET g_errshow = TRUE #是否開窗 #160318-00025#28  add
                #設定g_chkparam.*的參數
                LET g_chkparam.arg1 = g_faam2_d[l_ac].faam029
                LET g_chkparam.arg2 = g_today             
                LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"#要執行的建議程式待補#160318-00025#28  add
                #呼叫檢查存在並帶值的library
                IF cl_chk_exist("v_ooeg001") THEN
                   #檢查成功時後續處理
                   #LET  = g_chkparam.return1
                   #DISPLAY BY NAME 
                ELSE
                   #檢查失敗時後續處理
                   LET g_faam2_d[l_ac].faam029 = g_faam2_d_t.faam029
                   NEXT FIELD CURRENT
                END IF
             END IF 
             
       
        AFTER FIELD faam030
             IF NOT cl_null(g_faam2_d[l_ac].faam030) THEN 
                #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                INITIALIZE g_chkparam.* TO NULL            
                LET g_errshow = TRUE #是否開窗 #160318-00025#28  add
                #設定g_chkparam.*的參數
                LET g_chkparam.arg1 = g_faam2_d[l_ac].faam030    
                LET g_chkparam.err_str[1] = "axm-00004:sub-01302|axmi027|",cl_get_progname("axmi027",g_lang,"2"),"|:EXEPROGaxmi027"#要執行的建議程式待補#160318-00025#28  add                
                #呼叫檢查存在並帶值的library
                IF cl_chk_exist("v_oocq002_287") THEN
                   #檢查成功時後續處理
                   #LET  = g_chkparam.return1
                   #DISPLAY BY NAME 
                ELSE
                   #檢查失敗時後續處理
                   LET g_faam2_d[l_ac].faam030 = g_faam2_d_t.faam030
                   NEXT FIELD CURRENT
                END IF
             END IF 

        AFTER FIELD faam031
             IF NOT cl_null(g_faam2_d[l_ac].faam031) THEN 
                #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                INITIALIZE g_chkparam.* TO NULL
                LET g_errshow = TRUE #是否開窗 #160318-00025#28  add
                #設定g_chkparam.*的參數
                LET g_chkparam.arg1 = g_faam2_d[l_ac].faam031
                LET g_chkparam.err_str[1] = "apm-00044:sub-01302|apmm100|",cl_get_progname("apmm100",g_lang,"2"),"|:EXEPROGapmm100"#要執行的建議程式待補#160318-00025#28  add
                #呼叫檢查存在並帶值的library
                IF cl_chk_exist("v_pmaa001_2") THEN
        
                ELSE
                   #檢查失敗時後續處理
                   LET g_faam2_d[l_ac].faam031 = g_faam2_d_t.faam031
                   NEXT FIELD CURRENT
                END IF               
             END IF   
        
     
        AFTER FIELD faam032
             IF NOT cl_null(g_faam2_d[l_ac].faam032) THEN 
                #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                INITIALIZE g_chkparam.* TO NULL          
                LET g_errshow = TRUE #是否開窗 #160318-00025#28  add
                #設定g_chkparam.*的參數
                LET g_chkparam.arg1 = g_faam2_d[l_ac].faam032          
                LET g_chkparam.err_str[1] = "apm-00044:sub-01302|apmm100|",cl_get_progname("apmm100",g_lang,"2"),"|:EXEPROGapmm100"#要執行的建議程式待補#160318-00025#28  add
                #呼叫檢查存在並帶值的library
                IF cl_chk_exist("v_pmaa001_2") THEN
                   #檢查成功時後續處理
                   #LET  = g_chkparam.return1
                   #DISPLAY BY NAME 
                ELSE
                   #檢查失敗時後續處理
                   LET g_faam2_d[l_ac].faam032 = g_faam2_d_t.faam032
                   NEXT FIELD CURRENT
                END IF
             END IF 
             
        AFTER FIELD faam033
             IF NOT cl_null(g_faam2_d[l_ac].faam033) THEN 
                #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                INITIALIZE g_chkparam.* TO NULL        
                LET g_errshow = TRUE #是否開窗 #160318-00025#28  add
                #設定g_chkparam.*的參數
                LET g_chkparam.arg1 = g_faam2_d[l_ac].faam033       
                LET g_chkparam.err_str[1] = "apm-00093:sub-01302|axmi021|",cl_get_progname("axmi021",g_lang,"2"),"|:EXEPROGaxmi021"#要執行的建議程式待補#160318-00025#28  add
                LET g_chkparam.err_str[2] = "apm-00092:sub-01303|axmi021|",cl_get_progname("axmi021",g_lang,"2"),"|:EXEPROGaxmi021"#要執行的建議程式待補#160318-00025#28  add
                #呼叫檢查存在並帶值的library
                IF cl_chk_exist("v_oocq002_281") THEN
                   #檢查成功時後續處理
                   #LET  = g_chkparam.return1
                   #DISPLAY BY NAME 
                ELSE
                   #檢查失敗時後續處理
                   LET g_faam2_d[l_ac].faam033 = g_faam2_d_t.faam033
                   NEXT FIELD CURRENT
                END IF
             END IF 

        AFTER FIELD faam034
             IF NOT cl_null(g_faam2_d[l_ac].faam034) THEN 
                #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                INITIALIZE g_chkparam.* TO NULL
                LET g_errshow = TRUE #是否開窗 #160318-00025#28  add
                #設定g_chkparam.*的參數
                LET g_chkparam.arg1 = g_faam2_d[l_ac].faam034
                LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"#要執行的建議程式待補#160318-00025#28  add
                #呼叫檢查存在並帶值的library
                IF cl_chk_exist("v_ooag001") THEN
                   #檢查成功時後續處理
                   #LET  = g_chkparam.return1
                   #DISPLAY BY NAME 
                ELSE
                   #檢查失敗時後續處理
                   LET g_faam2_d[l_ac].faam034 = g_faam2_d_t.faam034
                   NEXT FIELD CURRENT
                END IF
             END IF   
             
        BEFORE FIELD faam035
        AFTER FIELD faam035
        
        BEFORE FIELD faam036
        AFTER FIELD faam036
        
        #--------------------開窗------------------------------      
       
         ON ACTION controlp INFIELD fam028
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_faam2_d[l_ac].faam028       #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001()                                         #呼叫開窗
            LET g_faam2_d[l_ac].faam028 = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY g_faam2_d[l_ac].faam028 TO faam028              #顯示到畫面上
            NEXT FIELD faam028                                      #返回原欄位
            

         ON ACTION controlp INFIELD faam029
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_faam2_d[l_ac].faam029               #給予default值
            LET g_qryparam.where = " (ooeg003 = '2' OR ooeg003 = '3')"
            #給予arg
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001()                                        #呼叫開窗
            LET g_faam2_d[l_ac].faam029 = g_qryparam.return1       #將開窗取得的值回傳到變數
            DISPLAY g_faam2_d[l_ac].faam029 TO faam029             #顯示到畫面上
            NEXT FIELD faam029                                     #返回原欄位

         ON ACTION controlp INFIELD faam030
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_faam2_d[l_ac].faam030             #給予default值
            #給予arg
            LET g_qryparam.arg1 = '287'
            CALL q_oocq002()                                       #呼叫開窗
            LET g_faam2_d[l_ac].faam030 = g_qryparam.return1      #將開窗取得的值回傳到變數
            DISPLAY g_faam2_d[l_ac].faam030 TO faam030           #顯示到畫面上
            NEXT FIELD faam030                                     #返回原欄位

         ON ACTION controlp INFIELD faam031
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_faam2_d[l_ac].faam031             #給予default值
            #給予arg
            CALL q_pmaa001()                                         #呼叫開窗
            LET g_faam2_d[l_ac].faam031 = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY g_faam2_d[l_ac].faam031 TO faam031              #顯示到畫面上
            NEXT FIELD faam031                                       #返回原欄位
 
         ON ACTION controlp INFIELD faam032
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_faam2_d[l_ac].faam032            #給予default值
            #給予arg
            CALL q_pmaa001()                                         #呼叫開窗
            LET g_faam2_d[l_ac].faam032  = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY g_faam2_d[l_ac].faam032  TO faam032              #顯示到畫面上
            NEXT FIELD faam032                                       #返回原欄位
 
         ON ACTION controlp INFIELD faam033
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_faam2_d[l_ac].faam033             #給予default值
            #給予arg
            LET g_qryparam.arg1 = '281'
            CALL q_oocq002()                                         #呼叫開窗
            LET g_faam2_d[l_ac].faam033 = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY g_faam2_d[l_ac].faam033 TO faam033              #顯示到畫面上
            NEXT FIELD faam033                                       #返回原欄位
            

         ON ACTION controlp INFIELD faam034
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_faam2_d[l_ac].faam034            #給予default值
            #給予arg
            CALL q_ooag001()                                         #呼叫開窗
            LET g_faam2_d[l_ac].faam034 = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY g_faam2_d[l_ac].faam034 TO faam034              #顯示到畫面上
            NEXT FIELD faam034                                       #返回原欄位

         ON ACTION controlp INFIELD faam035
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_faam2_d[l_ac].faam035       #給予default值
            #給予arg
            CALL q_pjba001()                                         #呼叫開窗
            LET g_faam2_d[l_ac].faam035 = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY g_faam2_d[l_ac].faam035 TO faam035              #顯示到畫面上
            NEXT FIELD faam035                                       #返回原欄位

         ON ACTION controlp INFIELD faam036

#         AFTER FIELD faam028
#         
#         ON ACTION controlp INFIELD faam028
#         
#         #WBS
#         AFTER FIELD faam029
#         
#         ON ACTION controlp INFIELD faam029
         
         
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_faam2_d[l_ac].* = g_faam2_d_t.*
               CLOSE afap250_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG
            END IF

            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_faam2_d[l_ac].faam001
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_faam2_d[l_ac].* = g_faam2_d_t.*
            ELSE

               #寫入修改者/修改日期資訊(單身)
               UPDATE afap250_faam_tmp SET faam021 = g_faam2_d[l_ac].faam021,faam022 = g_faam2_d[l_ac].faam022,
                                           faam027 = g_faam2_d[l_ac].faam027,faam009 = g_faam2_d[l_ac].faam009,
                                           faam028 = g_faam2_d[l_ac].faam028,faam029 = g_faam2_d[l_ac].faam029,  #核算項
                                           faam030 = g_faam2_d[l_ac].faam030,faam031 = g_faam2_d[l_ac].faam031,
                                           faam032 = g_faam2_d[l_ac].faam032,faam033 = g_faam2_d[l_ac].faam033,
                                           faam034 = g_faam2_d[l_ac].faam034,faam035 = g_faam2_d[l_ac].faam035,
                                           faam036 = g_faam2_d[l_ac].faam036
                WHERE faamld = g_faam2_d[l_ac].faamld 
                  AND faam001 = g_faam2_d[l_ac].faam001 AND faam002 = g_faam2_d[l_ac].faam002
                  AND faam004 = g_faam2_d[l_ac].faam004 AND faam005 = g_faam2_d[l_ac].faam005 AND faam006 = '1' 
               
               CALL s_transaction_begin()               
               UPDATE faam_t SET faam021 = g_faam2_d[l_ac].faam021,faam022 = g_faam2_d[l_ac].faam022,
                                 faam027 = g_faam2_d[l_ac].faam027,faam009 = g_faam2_d[l_ac].faam009,
                                 faam028 = g_faam2_d[l_ac].faam028,faam029 = g_faam2_d[l_ac].faam029,  #核算項
                                 faam030 = g_faam2_d[l_ac].faam030,faam031 = g_faam2_d[l_ac].faam031,
                                 faam032 = g_faam2_d[l_ac].faam032,faam033 = g_faam2_d[l_ac].faam033,
                                 faam034 = g_faam2_d[l_ac].faam034,faam035 = g_faam2_d[l_ac].faam035,
                                 faam036 = g_faam2_d[l_ac].faam036
                WHERE faament = g_enterprise AND faamld = g_faam2_d[l_ac].faamld AND faam001 = g_faam2_d[l_ac].faam001 
                  AND faam002 = g_faam2_d[l_ac].faam002
                  AND faam004 = g_faam2_d[l_ac].faam004 AND faam005 = g_faam2_d[l_ac].faam005 AND faam006 = '1' 
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "faam_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

#                     CALL s_transaction_end('N','0')
                     LET g_update_faam = 'N'
                    WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "faam_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

#                     CALL s_transaction_end('N','0')
                     LET g_update_faam = 'N'
                  OTHERWISE
                    LET g_update_faam = 'Y'
               END CASE
            END IF

         AFTER INSERT
         
#         AFTER ROW
#            CLOSE afap250_bcl
#            CALL s_transaction_end('Y','0')
#            #其他table進行unlock
#            CALL cl_multitable_unlock()
         AFTER INPUT
         
      END INPUT
      ON ACTION ACCEPT
         ACCEPT DIALOG
      ON ACTION CANCEL
         LET INT_FLAG = TRUE
         EXIT DIALOG
   END DIALOG
   #畫面關閉
#   IF INT_FLAG THEN
#      CALL s_transaction_end('N','0')
#      CLOSE WINDOW w_afap250_s01
#      LET INT_FLAG = FALSE 
#      RETURN
#   END IF 
#   
#   CLOSE afap250_bcl
#   CALL s_transaction_end('Y','0')
#   CLOSE WINDOW w_afap250_s01
   CLOSE afap250_bcl
   CLOSE WINDOW w_afap250_s01
   LET INT_FLAG = FALSE  
END FUNCTION
#子画面资料填充
PRIVATE FUNCTION afap250_s01_b_fill(p_wc)
   DEFINE p_wc STRING
   DEFINE ls_sql STRING
   DEFINE ls_cnt LIKE type_t.num10
   DEFINE l_n    LIKE type_t.num5
   
   CALL g_faam2_d.clear()
   #將資料插入臨時表
   CALL afap250_create_tmp()
   LET ls_sql = " INSERT INTO afap250_faam_tmp ",
                " SELECT faamld,faam001,faam002,faam004,faam005,faam007,faam011,faam015,faam014,faam101,",
                "       faam105,faam103,faam151,faam155,faam153,faam021,faam022,faam027,faam009,faam028,faam029,",
                "       faam030,faam031,faam032,faam033,faam034,faam035,faam036 ",
                "  FROM faam_t ",
                " WHERE faament = '",g_enterprise,"' AND faam007 IN ('1','3') AND faam006 = '1' ",
                "   AND faam024 is null ",
                "   AND ",p_wc CLIPPED
   PREPARE afap250_s01_b_fill_pre1 FROM ls_sql
   EXECUTE afap250_s01_b_fill_pre1
   FREE afap250_s01_b_fill_pre1
   
   LET ls_sql = "SELECT * FROM afap250_faam_tmp "
   PREPARE afap250_s01_b_fill_pre FROM ls_sql
   DECLARE afap250_s01_b_fill_cs CURSOR FOR afap250_s01_b_fill_pre
   
   LET ls_cnt = 1
   FOREACH afap250_s01_b_fill_cs INTO g_faam2_d[ls_cnt].*
      LET ls_cnt = ls_cnt +1
   END FOREACH
   CALL g_faam2_d.deleteElement(g_faam2_d.getLength())
   let g_detail_cnt = g_faam2_d.getLength()
END FUNCTION

PRIVATE FUNCTION afap250_lock_b(ps_table)
   DEFINE ps_table STRING
   DEFINE ls_group STRING

   LET ls_group = "faam_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN afap250_bcl USING g_faam2_d[l_ac].faam001,g_faam2_d[l_ac].faam002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "afap250_bcl"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF
   RETURN TRUE

END FUNCTION

PRIVATE FUNCTION afap250_businessman_chk(p_pmaa001)
   DEFINE p_pmaa002     LIKE pmaa_t.pmaa002
   DEFINE p_pmaa001     LIKE pmaa_t.pmaa001
   DEFINE l_pmaastus    LIKE pmaa_t.pmaastus

   LET g_errno = ''
   SELECT pmaastus INTO l_pmaastus FROM pmaa_t
    WHERE pmaaent = g_enterprise
      AND pmaa001 = p_pmaa001

   CASE
      WHEN SQLCA.SQLCODE = 100   LET g_errno = 'apm-00028'
      WHEN l_pmaastus = 'N'      LET g_errno =  'sub-01302'  #'apm-00029' #160318-00005#9 mod
   END CASE
END FUNCTION
#抛转总账
PRIVATE FUNCTION afap250_throw()
   DEFINE l_success LIKE type_t.chr1
   DEFINE ls_sql    STRING
   DEFINE l_glapdocno LIKE glap_t.glapdocno
   DEFINE l_glapdocdt LIKE glap_t.glapdocdt
   #mark by geza 20161121 #161111-00028#6(S) 
#   DEFINE l_glap      RECORD LIKE glap_t.*
#   DEFINE l_glaq      RECORD LIKE glaq_t.*
   #mark by geza 20161121 #161111-00028#6(S)
   #add by geza 20161121 #161111-00028#6(S) 
   DEFINE l_glap RECORD  #傳票憑證單頭檔
       glapent LIKE glap_t.glapent, #企业编号
       glapld LIKE glap_t.glapld, #账套
       glapcomp LIKE glap_t.glapcomp, #法人
       glapdocno LIKE glap_t.glapdocno, #单号
       glapdocdt LIKE glap_t.glapdocdt, #单据日期
       glap001 LIKE glap_t.glap001, #凭证性质
       glap002 LIKE glap_t.glap002, #会计年度
       glap003 LIKE glap_t.glap003, #会计季别
       glap004 LIKE glap_t.glap004, #会计期别
       glap005 LIKE glap_t.glap005, #会计周别
       glap006 LIKE glap_t.glap006, #收支科目
       glap007 LIKE glap_t.glap007, #来源码
       glap008 LIKE glap_t.glap008, #账款类型
       glap009 LIKE glap_t.glap009, #总号
       glap010 LIKE glap_t.glap010, #借方总金额
       glap011 LIKE glap_t.glap011, #贷方总金额
       glap012 LIKE glap_t.glap012, #打印次数
       glap013 LIKE glap_t.glap013, #附件张数
       glap014 LIKE glap_t.glap014, #外币凭证否
       glap015 LIKE glap_t.glap015, #原凭证编号
       glap016 LIKE glap_t.glap016, #来源账别编号
       glap017 LIKE glap_t.glap017, #来源凭证编号
       glapownid LIKE glap_t.glapownid, #资料所有者
       glapowndp LIKE glap_t.glapowndp, #资料所有部门
       glapcrtid LIKE glap_t.glapcrtid, #资料录入者
       glapcrtdp LIKE glap_t.glapcrtdp, #资料录入部门
       glapcrtdt LIKE glap_t.glapcrtdt, #资料创建日
       glapmodid LIKE glap_t.glapmodid, #资料更改者
       glapmoddt LIKE glap_t.glapmoddt, #最近更改日
       glapcnfid LIKE glap_t.glapcnfid, #资料审核者
       glapcnfdt LIKE glap_t.glapcnfdt, #数据审核日
       glappstid LIKE glap_t.glappstid, #资料过账者
       glappstdt LIKE glap_t.glappstdt, #资料过账日
       glapstus LIKE glap_t.glapstus    #状态码
   END RECORD
   DEFINE l_glaq RECORD  #傳票憑證單身檔
       glaqent LIKE glaq_t.glaqent, #企业编号
       glaqcomp LIKE glaq_t.glaqcomp, #法人
       glaqld LIKE glaq_t.glaqld, #账套
       glaqdocno LIKE glaq_t.glaqdocno, #单号
       glaqseq LIKE glaq_t.glaqseq, #项次
       glaq001 LIKE glaq_t.glaq001, #摘要
       glaq002 LIKE glaq_t.glaq002, #科目编号
       glaq003 LIKE glaq_t.glaq003, #借方金额
       glaq004 LIKE glaq_t.glaq004, #贷方金额
       glaq005 LIKE glaq_t.glaq005, #交易币种
       glaq006 LIKE glaq_t.glaq006, #汇率
       glaq007 LIKE glaq_t.glaq007, #计价单位
       glaq008 LIKE glaq_t.glaq008, #数量
       glaq009 LIKE glaq_t.glaq009, #单价
       glaq010 LIKE glaq_t.glaq010, #原币金额
       glaq011 LIKE glaq_t.glaq011, #票据编码
       glaq012 LIKE glaq_t.glaq012, #票据日期
       glaq013 LIKE glaq_t.glaq013, #申请人
       glaq014 LIKE glaq_t.glaq014, #银行帐号
       glaq015 LIKE glaq_t.glaq015, #款别编号
       glaq016 LIKE glaq_t.glaq016, #收支项目
       glaq017 LIKE glaq_t.glaq017, #营运据点
       glaq018 LIKE glaq_t.glaq018, #部门
       glaq019 LIKE glaq_t.glaq019, #利润/成本中心
       glaq020 LIKE glaq_t.glaq020, #区域
       glaq021 LIKE glaq_t.glaq021, #收付款客商
       glaq022 LIKE glaq_t.glaq022, #账款客户
       glaq023 LIKE glaq_t.glaq023, #客群
       glaq024 LIKE glaq_t.glaq024, #产品类别
       glaq025 LIKE glaq_t.glaq025, #人员
       glaq026 LIKE glaq_t.glaq026, #no use
       glaq027 LIKE glaq_t.glaq027, #项目编号
       glaq028 LIKE glaq_t.glaq028, #WBS
       glaq029 LIKE glaq_t.glaq029, #自由核算项一
       glaq030 LIKE glaq_t.glaq030, #自由核算项二
       glaq031 LIKE glaq_t.glaq031, #自由核算项三
       glaq032 LIKE glaq_t.glaq032, #自由核算项四
       glaq033 LIKE glaq_t.glaq033, #自由核算项五
       glaq034 LIKE glaq_t.glaq034, #自由核算项六
       glaq035 LIKE glaq_t.glaq035, #自由核算项七
       glaq036 LIKE glaq_t.glaq036, #自由核算项八
       glaq037 LIKE glaq_t.glaq037, #自由核算项九
       glaq038 LIKE glaq_t.glaq038, #自由核算项十
       glaq039 LIKE glaq_t.glaq039, #汇率(本位币二)
       glaq040 LIKE glaq_t.glaq040, #借方金额(本位币二)
       glaq041 LIKE glaq_t.glaq041, #贷方金额(本位币二)
       glaq042 LIKE glaq_t.glaq042, #汇率(本位币三)
       glaq043 LIKE glaq_t.glaq043, #借方金额(本位币三)
       glaq044 LIKE glaq_t.glaq044, #贷方金额(本位币三)
       glaq051 LIKE glaq_t.glaq051, #经营方式
       glaq052 LIKE glaq_t.glaq052, #渠道
       glaq053 LIKE glaq_t.glaq053  #品牌
#170103-00019#12--add--str--
      ,glaqud001 LIKE glaq_t.glaqud001, #自定義欄位(文字)001
       glaqud002 LIKE glaq_t.glaqud002, #自定義欄位(文字)002
       glaqud003 LIKE glaq_t.glaqud003, #自定義欄位(文字)003
       glaqud004 LIKE glaq_t.glaqud004, #自定義欄位(文字)004
       glaqud005 LIKE glaq_t.glaqud005, #自定義欄位(文字)005
       glaqud006 LIKE glaq_t.glaqud006, #自定義欄位(文字)006
       glaqud007 LIKE glaq_t.glaqud007, #自定義欄位(文字)007
       glaqud008 LIKE glaq_t.glaqud008, #自定義欄位(文字)008
       glaqud009 LIKE glaq_t.glaqud009, #自定義欄位(文字)009
       glaqud010 LIKE glaq_t.glaqud010, #自定義欄位(文字)010
       glaqud011 LIKE glaq_t.glaqud011, #自定義欄位(數字)011
       glaqud012 LIKE glaq_t.glaqud012, #自定義欄位(數字)012
       glaqud013 LIKE glaq_t.glaqud013, #自定義欄位(數字)013
       glaqud014 LIKE glaq_t.glaqud014, #自定義欄位(數字)014
       glaqud015 LIKE glaq_t.glaqud015, #自定義欄位(數字)015
       glaqud016 LIKE glaq_t.glaqud016, #自定義欄位(數字)016
       glaqud017 LIKE glaq_t.glaqud017, #自定義欄位(數字)017
       glaqud018 LIKE glaq_t.glaqud018, #自定義欄位(數字)018
       glaqud019 LIKE glaq_t.glaqud019, #自定義欄位(數字)019
       glaqud020 LIKE glaq_t.glaqud020, #自定義欄位(數字)020
       glaqud021 LIKE glaq_t.glaqud021, #自定義欄位(日期時間)021
       glaqud022 LIKE glaq_t.glaqud022, #自定義欄位(日期時間)022
       glaqud023 LIKE glaq_t.glaqud023, #自定義欄位(日期時間)023
       glaqud024 LIKE glaq_t.glaqud024, #自定義欄位(日期時間)024
       glaqud025 LIKE glaq_t.glaqud025, #自定義欄位(日期時間)025
       glaqud026 LIKE glaq_t.glaqud026, #自定義欄位(日期時間)026
       glaqud027 LIKE glaq_t.glaqud027, #自定義欄位(日期時間)027
       glaqud028 LIKE glaq_t.glaqud028, #自定義欄位(日期時間)028
       glaqud029 LIKE glaq_t.glaqud029, #自定義欄位(日期時間)029
       glaqud030 LIKE glaq_t.glaqud030  #自定義欄位(日期時間)030
#170103-00019#12--add--end
   END RECORD
   #add by geza 20161121 #161111-00028#6(E)
   DEFINE ls_sql_count STRING
   DEFINE ls_cnt      LIKE type_t.num10
   DEFINE l_oobastus       LIKE ooba_t.oobastus
   DEFINE l_glaa003   LIKE glaa_t.glaa003
   DEFINE l_ooef004   LIKE ooef_t.ooef004
   DEFINE l_success1  LIKE type_t.chr1
   DEFINE l_success2  LIKE type_t.chr1
   DEFINE l_success3  LIKE type_t.num5 #170103-00019#12 add
   
   INITIALIZE l_glap.* TO NULL
   #g_faamld,g_faamyear,g_faammonth
   OPEN WINDOW w_afap250_s02 WITH FORM cl_ap_formpath("afa","afap250_s02")
   CALL cl_ui_init()
   SELECT ooef004 INTO l_ooef004 FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_faamcomp
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      INPUT l_glapdocno,l_glapdocdt FROM glapdocno,glapdocdt
         BEFORE INPUT
            LET l_glapdocdt = g_today
            
         AFTER FIELD glapdocno
            IF NOT cl_null(l_glapdocno) THEN
               LET g_errno = ''
               SELECT oobastus INTO l_oobastus
#                 FROM ooba_t LEFT OUTER JOIN oobx_t ON (oobaent=oobxent AND ooba002=oobx001)
                 FROM ooba_t,oobx_t 
                WHERE oobaent=oobxent AND ooba002=oobx001 
                  AND oobaent = g_enterprise
                  AND ooba001 = l_ooef004      #单据别参照表号
                  AND ooba002 = l_glapdocno    #单据别
                  AND oobx002 = 'AGL'          #模组
                  AND oobx003 = 'aglt310'      #单据性质
               CASE
                  WHEN SQLCA.SQLCODE =100  LET g_errno = 'aim-00056'
                  WHEN l_oobastus = 'N'    LET g_errno = 'sub-01302' #'aim-00057' #160318-00005#9 mod
               END CASE
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = l_glapdocno
                  #160318-00005#9 --add--str
                  LET g_errparam.replace[1] ='aooi200'
                  LET g_errparam.replace[2] = cl_get_progname('aooi200',g_lang,"2")
                  LET g_errparam.exeprog    ='aooi200'
                  #160318-00005#9 --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET l_glapdocno = ''
                  NEXT FIELD glapdocno
               END IF 
            END IF 
         ON ACTION CONTROLP INFIELD glapdocno
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = l_glapdocno          #給予default值

            #給予arg
            LET g_qryparam.where = "ooba001 = '",l_ooef004,"' AND oobx002 = 'AGL' AND oobx003 = 'aglt310' "
            CALL q_ooba002_4()                                #呼叫開窗

            LET l_glapdocno = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY l_glapdocno TO glapdocno              #顯示到畫面上
            LET g_qryparam.where = ""
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
   CLOSE WINDOW w_afap250_s02
   IF INT_FLAG THEN
      LET INT_FLAG = FALSE
      RETURN
   END IF 
   LET INT_FLAG = FALSE 
  
   #开启事务
   CALL s_transaction_begin()
   CALL s_aooi200_gen_docno(g_faamcomp,l_glapdocno,l_glapdocdt,'aglt310')
      RETURNING l_success,l_glapdocno
   IF NOT l_success THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF    
   LET l_success = 'Y' 
   LET l_success1 = 'Y' 
   LET l_success2 = 'Y' 
   #glaq
   LET ls_sql = "SELECT '",g_enterprise,"','",g_faamcomp,"','",g_faamld,"','",l_glapdocno,"',",
                " '',faam022,sum(faam013),0,",  #8
                "faam011,faam012,'','',sum(faam013),sum(faam013),'','','",g_user,"','','','',",
                "faam027,faam009,faam028,faam029,faam030,faam031,faam032,faam033,'','",g_user,"','',faam035,faam036,",
                "'','','','','','','','','',faam102,sum(faam104),0,faam152,sum(faam154),0 FROM faam_t",
                " WHERE faament = '",g_enterprise,"' AND faamld = '",g_faamld,"' ",
                "   AND faam004 = '",g_faamyear,"' AND faam005 = '",g_faammonth,"' ",
                "   AND faam007 IN ('1','3') AND faam006 = '1' ", 
                "   AND (faam024 IS NULL OR faam024 = '' ) ",
                " GROUP BY faamld,faam022,faam011,faam012,faam027,faam009,faam028,",
                " faam029,faam030,faam031,faam032,faam033,faam034,faam035,faam036,faam102,faam152 "
   LET ls_sql_count = " SELECT COUNT(*) FROM (",ls_sql,")"
   PREPARE afap250_throw_glaq_count FROM ls_sql_count
   EXECUTE afap250_throw_glaq_count INTO ls_cnt 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "count"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CALL s_transaction_end('N','0')
      RETURN
   END IF
   IF ls_cnt <= 0 THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = '-400'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF 
   LET ls_sql = ls_sql ,
                " UNION ",
                "SELECT '",g_enterprise,"','",g_faamcomp,"','",g_faamld,"','",l_glapdocno,"',",
                " '',faam021,0,sum(faam013),",
                "faam011,faam012,'','',sum(faam013),sum(faam013),'','','",g_user,"','','','',",
                "faam027,faam009,faam028,faam029,faam030,faam031,faam032,faam033,'','",g_user,"','',faam035,faam036,",
                "'','','','','','','','','',faam102,0,sum(faam104),faam152,0,sum(faam154) FROM faam_t",
                " WHERE faament = '",g_enterprise,"' AND faamld = '",g_faamld,"' ",
                "   AND faam007 IN ('1','3') AND faam006 = '1' ",
                "   AND (faam024 IS NULL OR faam024 = '' ) ",
                "   AND faam004 = '",g_faamyear,"' AND faam005 = '",g_faammonth,"' ",
                " GROUP BY faamld,faam021,faam011,faam012,faam027,faam009,faam028,",
                " faam029,faam030,faam031,faam032,faam033,faam034,faam035,faam036,faam102,faam152 "
   PREPARE afap250_throw_faam_pre FROM ls_sql
   DECLARE afap250_throw_faam_cs CURSOR FOR afap250_throw_faam_pre

   LET ls_sql = "INSERT INTO glaq_t(glaqent,glaqcomp,glaqld,glaqdocno,glaqseq,glaq001,glaq002,glaq003,glaq004,",
                "glaq005,glaq006,glaq007,glaq008,glaq009,glaq010,glaq011,glaq012,glaq013,glaq014,glaq015,glaq016,",
                "glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,glaq023,glaq024,glaq025,",
                "glaq026,glaq027,glaq028,glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,glaq035,glaq036,glaq037,",
                "glaq038,glaq039,glaq040,glaq041,glaq042,glaq043,glaq044) ",
                " VALUES(?,?,?,?,?,?,?,?,?,  " ,
                "?,?,?,?,?,?,?,?,?,?,?,?,   ",
                "?,?,?,?,?,?,?,?,?,   ",
                "?,?,?,?,?,?,?,?,?,?,?,?, "  ,
                "?,?,?,?,?,?,?)"
   PREPARE afap250_throw_glaq_pre FROM ls_sql
   LET ls_cnt = 1
   FOREACH afap250_throw_faam_cs INTO l_glaq.glaqent,l_glaq.glaqcomp,l_glaq.glaqld,l_glaq.glaqdocno,l_glaq.glaq001,l_glaq.glaq002,l_glaq.glaq003,l_glaq.glaq004,
              l_glaq.glaq005,l_glaq.glaq006,l_glaq.glaq007,l_glaq.glaq008,l_glaq.glaq009,l_glaq.glaq010,l_glaq.glaq011,l_glaq.glaq012,l_glaq.glaq013,l_glaq.glaq014,l_glaq.glaq015,l_glaq.glaq016,
              l_glaq.glaq017,l_glaq.glaq018,l_glaq.glaq019,l_glaq.glaq020,l_glaq.glaq021,l_glaq.glaq022,l_glaq.glaq023,l_glaq.glaq024,l_glaq.glaq025,
              l_glaq.glaq026,l_glaq.glaq027,l_glaq.glaq028,l_glaq.glaq029,l_glaq.glaq030,l_glaq.glaq031,l_glaq.glaq032,l_glaq.glaq033,l_glaq.glaq034,l_glaq.glaq035,l_glaq.glaq036,l_glaq.glaq037,
              l_glaq.glaq038,l_glaq.glaq039,l_glaq.glaq040,l_glaq.glaq041,l_glaq.glaq042,l_glaq.glaq043,l_glaq.glaq044
      LET l_glaq.glaqseq = ls_cnt
      EXECUTE afap250_throw_glaq_pre USING l_glaq.glaqent,l_glaq.glaqcomp,l_glaq.glaqld,l_glaq.glaqdocno,l_glaq.glaqseq,l_glaq.glaq001,l_glaq.glaq002,l_glaq.glaq003,l_glaq.glaq004,
              l_glaq.glaq005,l_glaq.glaq006,l_glaq.glaq007,l_glaq.glaq008,l_glaq.glaq009,l_glaq.glaq010,l_glaq.glaq011,l_glaq.glaq012,l_glaq.glaq013,l_glaq.glaq014,l_glaq.glaq015,l_glaq.glaq016,
              l_glaq.glaq017,l_glaq.glaq018,l_glaq.glaq019,l_glaq.glaq020,l_glaq.glaq021,l_glaq.glaq022,l_glaq.glaq023,l_glaq.glaq024,l_glaq.glaq025,
              l_glaq.glaq026,l_glaq.glaq027,l_glaq.glaq028,l_glaq.glaq029,l_glaq.glaq030,l_glaq.glaq031,l_glaq.glaq032,l_glaq.glaq033,l_glaq.glaq034,l_glaq.glaq035,l_glaq.glaq036,l_glaq.glaq037,
              l_glaq.glaq038,l_glaq.glaq039,l_glaq.glaq040,l_glaq.glaq041,l_glaq.glaq042,l_glaq.glaq043,l_glaq.glaq044
      LET ls_cnt = ls_cnt +1
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "glaq_m"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET l_success = 'N' 
#         CALL s_transaction_end('N','0')
         RETURN
      ELSE
         LET l_success = 'Y' 
         #170103-00019#12--add--str--
         #插入细项立冲账资料
         LET l_success3 = TRUE
         CALL s_pre_voucher_insert_glax(l_glaq.*) RETURNING l_success3
         IF l_success3 = FALSE THEN
            LET l_success = 'N'
            RETURN
         END IF
         #170103-00019#12--add--end
      END IF
   END FOREACH
   
   #glap
   LET l_glap.glapent = g_enterprise
   LET l_glap.glapld = g_faamld
   LET l_glap.glapcomp = g_faamcomp
   LET l_glap.glapdocno = l_glapdocno
   LET l_glap.glapdocdt = l_glapdocdt
   LET l_glap.glap001 = '1'
   SELECT glaa003 INTO l_glaa003 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_faamld
   
   SELECT glav002,glav005,glav006,glav007 INTO l_glap.glap002,l_glap.glap003,l_glap.glap004,l_glap.glap005 FROM glav_t
    WHERE glavent = g_enterprise AND glav001 = l_glaa003 AND glav004 = l_glapdocdt
   LET l_glap.glap006 = ''
   LET l_glap.glap007 = 'FA'
   LET l_glap.glap008 = 'afap250'
   LET l_glap.glap009 = ''
   SELECT sum(glaq003),sum(glaq004) INTO l_glap.glap010,l_glap.glap011 FROM glaq_t
    WHERE glaqent = g_enterprise AND glaqld = g_faamld AND glaqdocno = l_glapdocno
   LET l_glap.glap012 = 0
   LET l_glap.glap013 = 0 
   LET l_glap.glap014 = 'N'
   LET l_glap.glap015 = ''
   LET l_glap.glap016 = ''
   LET l_glap.glap017 = ''
   LET l_glap.glapownid = g_user
   LET l_glap.glapowndp = g_dept
   LET l_glap.glapcrtid = g_user
   LET l_glap.glapcrtdp = g_dept
   LET l_glap.glapcrtdt = cl_get_current()
   LET l_glap.glapmodid = ''
   LET l_glap.glapmoddt = ''
   LET l_glap.glapcnfid = ''
   LET l_glap.glapcnfdt = ''
   LET l_glap.glappstid = ''
   LET l_glap.glappstdt = ''
   LET l_glap.glapstus = 'N'
   #INSERT INTO glap_t values(l_glap.*) #mark by geza 20161121 #161111-00028#6
   #add by geza 20161121 #161111-00028#6(S)
#   INSERT INTO glaq_t(glapent,glapld,glapcomp,glapdocno,glapdocdt, #170103-00019#12 mark
   INSERT INTO glap_t(glapent,glapld,glapcomp,glapdocno,glapdocdt,  #170103-00019#12 add
                      glap001,glap002,glap003,glap004,glap005,
                      glap006,glap007,glap008,glap009,glap010,
                      glap011,glap012,glap013,glap014,glap015,
                      glap016,glap017,glapownid,glapowndp,glapcrtid,
                      glapcrtdp,glapcrtdt,glapmodid,glapmoddt,glapcnfid,
                      glapcnfdt,glappstid,glappstdt,glapstus) 
              VALUES  (l_glap.glapent,l_glap.glapld,l_glap.glapcomp,l_glap.glapdocno,l_glap.glapdocdt,
                       l_glap.glap001,l_glap.glap002,l_glap.glap003,l_glap.glap004,l_glap.glap005,
                       l_glap.glap006,l_glap.glap007,l_glap.glap008,l_glap.glap009,l_glap.glap010,
                       l_glap.glap011,l_glap.glap012,l_glap.glap013,l_glap.glap014,l_glap.glap015,
                       l_glap.glap016,l_glap.glap017,l_glap.glapownid,l_glap.glapowndp,l_glap.glapcrtid,
                       l_glap.glapcrtdp,l_glap.glapcrtdt,l_glap.glapmodid,l_glap.glapmoddt,l_glap.glapcnfid,
                       l_glap.glapcnfdt,l_glap.glappstid,l_glap.glappstdt,l_glap.glapstus) 
   #add by geza 20161121 #161111-00028#6(E)                    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "glap_m"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET l_success1 = 'N' 
#      CALL s_transaction_end('N','0')
      RETURN
   ELSE
      LET l_success1 = 'Y' 
   END IF
   UPDATE faam_t SET faam024 = l_glap.glapdocno WHERE faament = g_enterprise AND faamld = g_faamld
      AND faam007 IN ('1','3') AND faam006 = '1' 
      AND faam004 = g_faamyear AND faam005 = g_faammonth
   #关闭事务
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "upd faam_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET l_success2 = 'N' 
#      CALL s_transaction_end('N','0')
   ELSE
      LET l_success = 'Y' 
#      CALL s_transaction_end('Y','1')
   END IF
   
   IF l_success = 'Y' AND l_success1 = 'Y' AND l_success2 = 'Y' AND g_update_faam = 'Y' THEN
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
   
END FUNCTION

PRIVATE FUNCTION afap250_glap006_chk(p_glap006)
   DEFINE p_glap006    LIKE glap_t.glap006
   DEFINE l_glacstus   LIKE glac_t.glacstus
   DEFINE l_glac003    LIKE glac_t.glac003
   DEFINE l_glac006    LIKE glac_t.glac006

   LET g_errno = ''
   SELECT glacstus,glac003,glac006 INTO l_glacstus,l_glac003,l_glac006 FROM glac_t
    WHERE glacent = g_enterprise
      AND glac001 = g_faamacc  #会计科目参照表号
      AND glac002 = p_glap006

   CASE
      WHEN SQLCA.SQLCODE = 100   LET g_errno = 'agl-00011'
      WHEN l_glacstus = 'N'      LET g_errno = 'sub-01302' #'agl-00012' #160318-00005#9 mod
      WHEN l_glac003 = '1'       LET g_errno = 'agl-00013'  #必须为非统治类科目
      WHEN l_glac006 <>'1'       LET g_errno = 'agl-00030'  #须为账户性质
   END CASE
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
PRIVATE FUNCTION afap250_s01_set_entry(p_glaq002)
   #科目核算项
   DEFINE l_glad005       LIKE glad_t.glad005
   DEFINE l_glad007       LIKE glad_t.glad007
   DEFINE l_glad008       LIKE glad_t.glad008
   DEFINE l_glad009       LIKE glad_t.glad009
   DEFINE l_glad010       LIKE glad_t.glad010
   DEFINE l_glad027       LIKE glad_t.glad027
   DEFINE l_glad011       LIKE glad_t.glad011
   DEFINE l_glad012       LIKE glad_t.glad012
   DEFINE l_glad013       LIKE glad_t.glad013
   DEFINE l_glad014       LIKE glad_t.glad014
   DEFINE l_glad015       LIKE glad_t.glad015
   DEFINE l_glad016       LIKE glad_t.glad016
   DEFINE l_glad031       LIKE glad_t.glad031
   DEFINE l_glad032       LIKE glad_t.glad032
   DEFINE l_glad033       LIKE glad_t.glad033
   DEFINE p_glaq002       LIKE glaq_t.glaq002
   
   CALL s_voucher_fix_acc_open_chk(g_faamld,p_glaq002)
   RETURNING l_glad007,l_glad008,l_glad009,l_glad010,l_glad027,l_glad011,l_glad012,l_glad013,l_glad015,l_glad016,
             l_glad031,l_glad032,l_glad033
   CALL cl_set_comp_entry('faam009,faam026,faam027,faam029',false)
   CALL cl_set_comp_entry('',FALSE)
   #部门
   IF l_glad007 = 'Y' THEN 
      CALL cl_set_comp_entry('faam009',TRUE)
      CALL cl_set_comp_required('faam009',TRUE)
   ELSE
      CALL cl_set_comp_entry('faam009',FALSE)
      CALL cl_set_comp_required('faam009',FALSE)
   END IF 
   #交易客商
   IF l_glad010 = 'Y' THEN
      CALL cl_set_comp_entry('faam026',TRUE)
      CALL cl_set_comp_required('faam026',TRUE)
   ELSE
      CALL cl_set_comp_entry('faam026',FALSE)
      CALL cl_set_comp_required('faam026',FALSE)
   END IF 
   IF l_glad015 = 'Y' THEN
      CALL cl_set_comp_entry('faam027',TRUE)
      CALL cl_set_comp_required('faam027',TRUE)
   ELSE
      CALL cl_set_comp_entry('faam027',FALSE)
      CALL cl_set_comp_required('faam027',FALSE)
   END IF 
   IF l_glad016 = 'Y' THEN
      CALL cl_set_comp_entry('faam029',TRUE)
      CALL cl_set_comp_required('faam029',TRUE)
   ELSE
      CALL cl_set_comp_entry('faam029',FALSE)
      CALL cl_set_comp_required('faam029',FALSE)
   END IF 
   
END FUNCTION

PRIVATE FUNCTION afap250_current_chk(p_glaald)
   DEFINE p_glaald LIKE glaa_t.glaald
   DEFINE r_glaa015 LIKE glaa_t.glaa015
   DEFINE r_glaa016 LIKE glaa_t.glaa016
   DEFINE r_glaa019 LIKE glaa_t.glaa019
   DEFINE r_glaa020 LIKE glaa_t.glaa020
   
   SELECT glaa015,glaa016,glaa019,glaa020 INTO r_glaa015,r_glaa016,r_glaa019,r_glaa020
     FROM glaa_t
    WHERE glaaent = g_enterprise AND glaald = p_glaald
   RETURN  r_glaa015,r_glaa016,r_glaa019,r_glaa020
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
PRIVATE FUNCTION afap250_construct()
   DEFINE l_glav006 LIKE glav_t.glav006
   DEFINE ls_faamld    LIKE faam_t.faamld,
       ls_faamyear  LIKE faam_t.faam004,
       ls_faammonth LIKE faam_t.faam005
   DEFINE l_ld_str    STRING                #160125-00005#7  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      INPUT g_faamld,g_faamyear,g_faammonth FROM l_glaald,l_year,l_month
            BEFORE INPUT
               SELECT glaald INTO g_faamld FROM glaa_t
                WHERE glaaent = g_enterprise AND glaacomp = g_site
                  AND glaa014 = 'Y'
               CALL afap250_ld_ref(g_faamld,g_faamyear,g_faammonth) 
                  RETURNING g_faamld_desc,g_faamcomp,g_faamcomp_desc,g_faamacc,g_faamacc_desc,g_faamyear,g_faammonth
               DISPLAY g_faamld_desc TO l_ld_desc
               DISPLAY g_faamcomp TO l_comp
               DISPLAY g_faamcomp_desc TO l_comp_desc
               DISPLAY g_faamacc TO l_acc
               DISPLAY g_faamacc_desc TO l_acc_desc
               IF cl_null(g_faamyear) THEN LET g_faamyear = YEAR(g_today) END IF
               IF cl_null(g_faammonth) THEN LET g_faammonth = MONTH(g_today) END IF

               
            AFTER FIELD l_glaald
               DISPLAY '' TO l_ld_desc
               DISPLAY '' TO l_comp
               DISPLAY '' TO l_comp_desc
               DISPLAY '' TO l_acc
               DISPLAY '' TO l_acc_desc
               IF NOT cl_null(g_faamld) THEN 
                  IF NOT afap250_ld_chk(g_faamld) THEN 
                     LET g_faamld = ''
                     DISPLAY '' TO l_ld_desc
                     DISPLAY '' TO l_comp
                     DISPLAY '' TO l_comp_desc
                     DISPLAY '' TO l_acc
                     DISPLAY '' TO l_acc_desc
                     NEXT FIELD l_glaald
                  END IF 
               END IF 
               CALL afap250_ld_ref(g_faamld,g_faamyear,g_faammonth) 
                  RETURNING g_faamld_desc,g_faamcomp,g_faamcomp_desc,g_faamacc,g_faamacc_desc,g_faamyear,g_faammonth
               DISPLAY g_faamld_desc TO l_ld_desc
               DISPLAY g_faamcomp TO l_comp
               DISPLAY g_faamcomp_desc TO l_comp_desc
               DISPLAY g_faamacc TO l_acc
               DISPLAY g_faamacc_desc TO l_acc_desc
#               CALL afap250_fisrt_body_fill()
#               CALL afap250_second_body_fill()
               
            ON ACTION controlp INFIELD l_glaald
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_faamld             #給予default值
               #給予arg
               LET g_qryparam.arg1 = g_user
               LET g_qryparam.arg2 = g_dept
               LET g_qryparam.where = " (glaa014 = 'Y' OR glaa008 = 'Y') "
               #160125-00005#7  add--str--
               #账套范围
               LET g_qryparam.arg1 = g_user                                 #人員權限
               LET g_qryparam.arg2 = g_dept             
               CALL s_axrt300_get_site(g_user,'','2')  RETURNING l_ld_str 
               IF NOT cl_null(l_ld_str) THEN   
                  LET g_qryparam.where = g_qryparam.where," AND ",l_ld_str
               END IF
               #160125-00005#7  add--end                 
               CALL q_authorised_ld()                                  #呼叫開窗
               LET g_faamld = g_qryparam.return1
               DISPLAY g_faamld TO l_glaald
               CALL afap250_ld_ref(g_faamld,g_faamyear,g_faammonth) 
                  RETURNING g_faamld_desc,g_faamcomp,g_faamcomp_desc,g_faamacc,g_faamacc_desc,g_faamyear,g_faammonth
               DISPLAY g_faamld_desc TO l_ld_desc
               DISPLAY g_faamcomp TO l_comp
               DISPLAY g_faamcomp_desc TO l_comp_desc
               DISPLAY g_faamacc TO l_acc
               DISPLAY g_faamacc_desc TO l_acc_desc
#               CALL afap250_fisrt_body_fill()
#               CALL afap250_second_body_fill()
               
            AFTER FIELD l_year
               IF NOT cl_null(g_faamyear) THEN 
                  IF g_faamyear <= 0 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = ''
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD l_year
                  END IF 
               END IF 
#               CALL afap250_fisrt_body_fill()
#               CALL afap250_second_body_fill()
               
            BEFORE FIELD l_month
               IF cl_null(g_faamyear) THEN 
                  NEXT FIELD l_year
               END IF 
            
            AFTER FIELD l_month
               IF NOT cl_null(g_faammonth) THEN 
                  IF g_faammonth <= 0 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = ''
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD l_month
                  END IF 
                  SELECT max(glav006) INTO l_glav006 FROM glav_t WHERE glavent = g_enterprise
                     AND glav001 = g_faamacc AND glav002 = g_faamyear
                  IF g_faammonth > l_glav006 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = ''
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD l_month
                  END IF 
               END IF
#               CALL afap250_fisrt_body_fill()
#               CALL afap250_second_body_fill()
               
            ON ACTION act_generate
               CALL afap250_fisrt_body_fill()
               CALL afap250_second_body_fill()
            ON ACTION act_throw
               CALL afap250_throw()
               CALL afap250_fisrt_body_fill()
               CALL afap250_second_body_fill()
         END INPUT
         BEFORE DIALOG
                  
            
      ON ACTION accept
         ACCEPT DIALOG

      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
         
      ON ACTION close
         LET INT_FLAG = 1
         EXIT DIALOG


      #查詢CONSTRUCT共用ACTION
      &include "construct_action.4gl"

      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   END DIALOG
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
PRIVATE FUNCTION afap250_ui_dialog_1()
DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num5
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define
   DEFINE l_glav006 LIKE glav_t.glav006
   DEFINE ls_faamld    LIKE faam_t.faamld,
       ls_faamyear  LIKE faam_t.faam004,
       ls_faammonth LIKE faam_t.faam005
   #end add-point
 
   #add-point:ui_dialog段before dialog
   CALL afap250_construct()
   CALL afap250_fisrt_body_fill()
   CALL afap250_second_body_fill()
   #end add-point
 
   WHILE TRUE
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         
         DISPLAY ARRAY g_glaq_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b1) #page1

            BEFORE ROW
               LET l_ac1 = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx1 = l_ac1
               DISPLAY g_detail_idx1 TO h_index

            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx1)
               LET l_ac1 = DIALOG.getCurrentRow("s_detail1")
               DISPLAY g_rec_b1 TO h_count

#            ON ACTION afap250_s01
#               IF l_ac1 <= g_glaq_d.getLength() AND l_ac1 != 0 THEN
#                  CALL afap250_s01(g_faamld,g_faamyear,g_faammonth,g_glaq_d[l_ac1].glaq002,g_glaq_d[l_ac1].glaq018)
#                  CALL afap250_fisrt_body_fill()
#                  CALL afap250_second_body_fill()
#               END IF
         END DISPLAY
         DISPLAY ARRAY g_faam_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b2) #page1

            BEFORE ROW
               LET l_ac2 = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx2 = l_ac2
               DISPLAY g_detail_idx2 TO h_index

            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx1)
               LET l_ac2 = DIALOG.getCurrentRow("s_detail2")
               DISPLAY g_rec_b2 TO h_count
               
            ON ACTION afap250_s01
               IF l_ac1 <= g_glaq_d.getLength() AND l_ac1 != 0 THEN
#                  CALL afap250_s01(g_faamld,g_faamyear,g_faammonth,g_faam_d[l_ac2].faam009,g_faam_d[l_ac2].faam022)
                  CALL afap250_s01(g_faamld,g_faamyear,g_faammonth)
                  CALL afap250_fisrt_body_fill()
                  CALL afap250_second_body_fill()
               END IF
               
         END DISPLAY  
         #end add-point
         #add-point:ui_dialog段自定義display array
         
         
         #end add-point
 
         SUBDIALOG lib_cl_schedule.cl_schedule_setting
         SUBDIALOG lib_cl_schedule.cl_schedule_setting_exec_call
         SUBDIALOG lib_cl_schedule.cl_schedule_select_show_history
         SUBDIALOG lib_cl_schedule.cl_schedule_show_history
 
         BEFORE DIALOG
            LET l_dialog = ui.DIALOG.getCurrent()
            CALL cl_qbe_display_condition(FGL_GETENV("QUERYPLANID"), g_user)
            CALL afap250_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog
            
            #end add-point
 
         ON ACTION qbe_select
            LET ls_wc = ""
            #需要用ITM類程式查詢方案在CONSTRUCT的功能，將值set到畫面上
            CALL cl_qbe_list("c") RETURNING ls_wc
            CALL afap250_get_buffer(l_dialog)
            IF NOT cl_null(ls_wc) THEN
               LET lc_param.wc = ls_wc
               #取得條件後需要執行項目,應新增於下方adp
               #add-point:ui_dialog段qbe_select後

               #end add-point
            END IF
 
         ON ACTION qbe_save
            CALL cl_qbe_save()
 
         ON ACTION batch_execute
            ACCEPT DIALOG
 
         ON ACTION qbeclear         
            CLEAR FORM
            INITIALIZE lc_param.* TO NULL
            #add-point:ui_dialog段qbeclear

            #end add-point
 
         ON ACTION history_fill
            CALL cl_schedule_history_fill()
 
         ON ACTION close
            LET INT_FLAG = TRUE
            EXIT DIALOG
         
         ON ACTION exit
            LET INT_FLAG = TRUE
            EXIT DIALOG
 
         #add-point:ui_dialog段action

         #end add-point
 
         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
 
      #add-point:ui_dialog段exit dialog
      LET ls_faamld = g_faamld
      LET ls_faamyear = g_faamyear
      LET ls_faammonth = g_faammonth
      #end add-point
 
      LET ls_js = util.JSON.stringify(lc_param)
 
      IF INT_FLAG THEN
         LET INT_FLAG = FALSE
         EXIT WHILE
      ELSE
         #LET g_jobid = cl_schedule_get_jobid(g_prog)
         IF g_chk_jobid THEN 
            LET g_jobid = g_schedule.gzpa001
         ELSE 
            LET g_jobid = cl_schedule_get_jobid(g_prog)
         END IF 
         CASE 
            WHEN g_schedule.gzpa003 = "0"
                 CALL afap250_process(ls_js)
            WHEN g_schedule.gzpa003 = "1"
            #    CALL cl_schedule_update_data(g_jobid,ls_js)
                 LET ls_js = afap250_transfer_argv(ls_js)
                 CALL cl_cmdrun(ls_js)
            WHEN g_schedule.gzpa003 = "2"
                 CALL cl_schedule_update_data(g_jobid,ls_js)
            WHEN g_schedule.gzpa003 = "3"
                 CALL cl_schedule_update_data(g_jobid,ls_js)
         END CASE  
         IF g_schedule.gzpa003 = "2" OR g_schedule.gzpa003 = "3" THEN 
            CALL cl_ask_confirm3("std-00014","") #設定完成
         END IF    
         LET g_schedule.gzpa003 = "0" #預設一開始 立即於前景執行
 
         #add-point:ui_dialog段after schedule

         #end add-point
 
         #欄位初始資訊 
         CALL cl_schedule_init_info("all",g_schedule.gzpa003) 
         LET gi_hiden_asign = FALSE 
         LET gi_hiden_exec = FALSE 
         LET gi_hiden_spec = FALSE 
         LET gi_hiden_exec_end = FALSE 
         CALL cl_schedule_hidden()
      END IF
   END WHILE
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
PRIVATE FUNCTION afap250_create_tmp()

   DROP TABLE afap250_faam_tmp;
   CREATE TEMP TABLE afap250_faam_tmp(
   faamld  VARCHAR(5),
   faam001 VARCHAR(10),
   faam002 VARCHAR(4),
   faam004 DECIMAL(5,0),
   faam005 DECIMAL(5,0),
   faam007 DECIMAL(10,0),
   faam011 VARCHAR(10),
   faam015  DECIMAL(20,6),
   faam014  DECIMAL(20,6),
   faam101 VARCHAR(10),
   faam103  DECIMAL(20,6),
   faam105  DECIMAL(20,6),
   faam151 VARCHAR(10), 
   faam153  DECIMAL(20,6),
   faam155 DECIMAL(20,6),
   faam021 VARCHAR(24),
   faam022 VARCHAR(24),
   faam027 VARCHAR(10),
   faam009 VARCHAR(10),
   faam028 VARCHAR(10),
   faam029 VARCHAR(10),
   faam030 VARCHAR(10),
   faam031 VARCHAR(10),
   faam032 VARCHAR(10),
   faam033 VARCHAR(10),
   faam034 VARCHAR(20),
   faam035 VARCHAR(10),
   faam036 VARCHAR(30)
   );
#   faamld  LIKE faam_t.faamld,
#   faam001 LIKE faam_t.faam001,
#   faam002 LIKE faam_t.faam002,
#   faam004 LIKE faam_t.faam004,
#   faam005 LIKE faam_t.faam005,
#   faam007 LIKE faam_t.faam007,
#   faam011 LIKE faam_t.faam011,
#   faam015 LIKE faam_t.faam015,
#   faam014 LIKE faam_t.faam014,
#   faam101 LIKE faam_t.faam101,
#   faam105 LIKE faam_t.faam105,
#   faam103 LIKE faam_t.faam103,
#   faam151 LIKE faam_t.faam151,
#   faam155 LIKE faam_t.faam155,
#   faam153 LIKE faam_t.faam153,
#   faam021 LIKE faam_t.faam021,
#   faam022 LIKE faam_t.faam022,
#   faam027 LIKE faam_t.faam027,
#   faam009 LIKE faam_t.faam009,
#   faam028 LIKE faam_t.faam028,
#   faam029 LIKE faam_t.faam029,
#   faam030 LIKE faam_t.faam030,
#   faam031 LIKE faam_t.faam031,
#   faam032 LIKE faam_t.faam032,
#   faam033 LIKE faam_t.faam033,
#   faam034 LIKE faam_t.faam034,
#   faam035 LIKE faam_t.faam035,
#   faam036 LIKE faam_t.faam036)

END FUNCTION

#end add-point
 
{</section>}
 
