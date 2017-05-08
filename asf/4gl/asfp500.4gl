#該程式未解開Section, 採用最新樣板產出!
{<section id="asfp500.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0018(2016-09-29 16:55:19), PR版次:0018(2017-02-23 15:39:47)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000254
#+ Filename...: asfp500
#+ Description: 工單生管結案批次作業
#+ Creator....: 00378(2014-03-16 16:11:39)
#+ Modifier...: 04441 -SD/PR- 07423
 
{</section>}
 
{<section id="asfp500.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#151229-00004#1 2015/12/29 By tsungyung 有對應的收貨單，但收貨數量與委外入庫的數量不同時，這類工單不能結案。
#160104-00009#1 2016/01/08 By tsungyung 自动结案需抓取aooi200的设定值
#160111-00024#1 2016/01/28 By Ann_Huang 呼叫s_asfp500_get_max_reference_date多回傳參數l_flag記錄單據來源,來決定顯示訊息 
#160330-00012#1 2016/04/01 By catmoon 將CALL cl_progress_no_window_ing(參數)參數有中文的情形改由變數帶入
#170111-00049#1 2017/01/16 By dujuan 委外工單單別設定工單自動生管結案，委外入庫過帳背景自動將委外工單結案，但未將委外採購單結案導致無法取消結案
#170124-00029#1 2017/01/24 By 06948     調整 asfp500_sel_po_p1 增加 ent 條件給值。
#170223-00033#1 2017/02/23 By fionchen  調整#151229-00004#1,有對應收貨單時,若收貨數量與委外驗退+委外入庫的數量不同時,這類工單不能結案
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_schedule
#add-point:增加匯入項目 name="global.import"

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
        close_dd         LIKE type_t.dat,
        auto             LIKE type_t.chr1,
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       a LIKE type_t.num26_10, 
   d LIKE type_t.chr1, 
   c LIKE type_t.chr1, 
   b LIKE type_t.chr1, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
 TYPE type_g_sfaa_d    RECORD
                       sel            LIKE type_t.chr1,
                       sfaadocno      LIKE sfaa_t.sfaadocno,
                       sfaa003        LIKE sfaa_t.sfaa003, 
                       sfaa057        LIKE sfaa_t.sfaa057, 
                       sfaa010        LIKE sfaa_t.sfaa010, 
                       sfaa010_desc1  LIKE type_t.chr500, 
                       sfaa010_desc2  LIKE type_t.chr500,   
                       sfaa020        LIKE sfaa_t.sfaa020, 
                       sfaastus       LIKE sfaa_t.sfaastus, 
                       sfaa012        LIKE sfaa_t.sfaa012, 
                       sfaa050        LIKE sfaa_t.sfaa050, 
                       sfaa051        LIKE sfaa_t.sfaa051, 
                       sfaa055        LIKE sfaa_t.sfaa055, 
                       sfaa056        LIKE sfaa_t.sfaa056, 
                       diff_qty       LIKE type_t.num20_6,
                       unfinish_rate  LIKE type_t.num26_10,
                       sfaa013        LIKE sfaa_t.sfaa013, 
                       sfaa009        LIKE sfaa_t.sfaa009, 
                       sfaa009_desc   LIKE type_t.chr500, 
                       sfaa017        LIKE sfaa_t.sfaa017, 
                       sfaa017_desc   LIKE type_t.chr500, 
                       sfaa002        LIKE sfaa_t.sfaa002,
                       sfaa002_desc   LIKE type_t.chr500,
                       unfinish_b     LIKE type_t.chr1,
                       unfinish_c     LIKE type_t.chr1,
                       unfinish_d     LIKE type_t.chr1,   
                       close_dd       LIKE type_t.dat,
                       sfaasite       LIKE sfaa_t.sfaasite
                       END RECORD
 TYPE type_g_sfba_d    RECORD
                       sfbaseq        LIKE sfba_t.sfbaseq, 
                       sfbaseq1       LIKE sfba_t.sfbaseq1, 
                       sfba006        LIKE sfba_t.sfba006, 
                       sfba006_desc1  LIKE type_t.chr500, 
                       sfba006_desc2  LIKE type_t.chr500, 
                       sfba002        LIKE sfba_t.sfba002, 
                       sfba002_desc   LIKE type_t.chr500, 
                       sfba003        LIKE sfba_t.sfba003, 
                       sfba003_desc   LIKE type_t.chr500, 
                       sfba004        LIKE sfba_t.sfba004, 
                       sfba014        LIKE sfba_t.sfba014, 
                       sfba014_desc   LIKE type_t.chr500, 
                       sfba023        LIKE sfba_t.sfba023, 
                       sfba024        LIKE sfba_t.sfba024, 
                       sfba013        LIKE sfba_t.sfba013, 
                       sfba015        LIKE sfba_t.sfba015, 
                       sfba016        LIKE sfba_t.sfba016, 
                       sfba025        LIKE sfba_t.sfba025, 
                       unissue_qty    LIKE sfba_t.sfba015, 
                       sfba017        LIKE sfba_t.sfba017, 
                       sfba018        LIKE sfba_t.sfba018, 
                       sfba012        LIKE sfba_t.sfba012
                       END RECORD
 
 TYPE type_g_sfcb_d    RECORD
                       sfcb001        LIKE sfcb_t.sfcb001, 
                       sfcb002        LIKE sfcb_t.sfcb002, 
                       sfcb003        LIKE sfcb_t.sfcb003, 
                       sfcb004        LIKE sfcb_t.sfcb004, 
                       sfcb046        LIKE sfcb_t.sfcb046, 
                       sfcb047        LIKE sfcb_t.sfcb047, 
                       sfcb050        LIKE sfcb_t.sfcb050, 
                       sfcb048        LIKE sfcb_t.sfcb048, 
                       sfcb049        LIKE sfcb_t.sfcb049, 
                       sfcb051        LIKE sfcb_t.sfcb051
                       END RECORD
 
 TYPE type_g_prog_d    RECORD
                       sdocno         LIKE sfaa_t.sfaadocno,
                       prog           LIKE gzza_t.gzza001, 
                       prog_desc      LIKE type_t.chr50, 
                       docno          LIKE sfaa_t.sfaadocno, 
                       stus           LIKE sfaa_t.sfaastus, 
                       crtid          LIKE sfaa_t.sfaacrtid, 
                       crtid_desc     LIKE type_t.chr50,  
                       crtdp          LIKE sfaa_t.sfaacrtdp, 
                       crtdp_desc     LIKE type_t.chr50,
                       opendd         LIKE type_t.dat,
                       postdd         LIKE type_t.dat,                              
                       errno          LIKE gzze_t.gzze001,
                       err_desc       LIKE type_t.chr200
                       END RECORD 

DEFINE g_sfaa_d        DYNAMIC ARRAY OF type_g_sfaa_d
DEFINE g_sfaa_d_t      type_g_sfaa_d
DEFINE g_sfba_d        DYNAMIC ARRAY OF type_g_sfba_d
DEFINE g_sfba_d_t      type_g_sfba_d
DEFINE g_sfcb_d        DYNAMIC ARRAY OF type_g_sfcb_d
DEFINE g_sfcb_d_t      type_g_sfcb_d
DEFINE g_prog_d        DYNAMIC ARRAY OF type_g_prog_d
DEFINE g_prog_d_t      type_g_prog_d
DEFINE g_err_arr       DYNAMIC ARRAY OF type_g_prog_d
DEFINE g_param         type_parameter
DEFINE g_close_dd      LIKE type_t.dat
DEFINE g_rec_b1        LIKE type_t.num5
DEFINE g_rec_b2        LIKE type_t.num5
DEFINE g_rec_b3        LIKE type_t.num5
DEFINE g_rec_b4        LIKE type_t.num5
DEFINE l_ac            LIKE type_t.num5
DEFINE g_press         LIKE type_t.num5
DEFINE g_prog_flag     LIKE type_t.chr10   #160104-00009#1 add
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="asfp500.main" >}
MAIN
   #add-point:main段define (客製用) name="main.define_customerization"
   
   #end add-point 
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter  
   #add-point:main段define name="main.define"
   
   #end add-point 
  
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("asf","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   LET g_param.close_dd = g_argv[1]
   LET g_param.auto     = g_argv[2]
   LET g_param.wc       = g_argv[3]
   LET g_bgjob          = g_argv[4]
   LET g_prog_flag      = g_argv[5]     #160104-00009#1 add   
   IF cl_null(g_bgjob) THEN LET g_bgjob = 'N' END IF
   LET g_press = FALSE
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL asfp500_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_asfp500 WITH FORM cl_ap_formpath("asf",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL asfp500_init()
 
      #進入選單 Menu (="N")
      CALL asfp500_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_asfp500
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="asfp500.init" >}
#+ 初始化作業
PRIVATE FUNCTION asfp500_init()
 
   #add-point:init段define (客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:ui_dialog段define name="init.define"
   DEFINE lwin_curr      ui.Window
   DEFINE lfrm_curr      ui.Form
   DEFINE ls_path        STRING

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

   LET lwin_curr = ui.Window.getCurrent()
   LET lfrm_curr = lwin_curr.getForm()
   LET ls_path = os.Path.join(os.Path.join(FGL_GETENV("ERP"),"cfg"),"4tb")
   LET ls_path = os.Path.join(ls_path,"toolbar_q.4tb")
   CALL lfrm_curr.loadToolBar(ls_path)

   #工单状态
   CALL cl_set_combo_scc('sfaa003','4007')
   #厂外/委外
   CALL cl_set_combo_scc('sfaa057','4010')
   #状态码
   CALL cl_set_combo_scc_part('sfaastus','13','C,D,E,F,H,M,N,R,W,X,Y')
   
   CALL cl_set_combo_scc('sfaa004','4008')
   CALL cl_set_combo_scc('sfaa005','4009')
   CALL cl_set_combo_scc('sfab001','4009')

   CALL cl_set_combo_scc_part('stus','13','A,C,D,E,F,G,I,M,N,O,P,R,S,W,X,Y,H,V')

   LET g_master.a = 0
   LET g_master.b = 'Y'
   LET g_master.c = 'Y'
   LET g_master.d = 'Y'

   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="asfp500.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION asfp500_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_date        LIKE type_t.dat
   DEFINE lc_master     type_master
   DEFINE l_yn          LIKE type_t.chr1    #結案否      #151229-00004#1 add
   DEFINE l_flag        LIKE type_t.chr1    #160111-00024#1 By Ann_Huang --- add
   
   LET g_bgjob = 'N'
   CALL asfp500_query()
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.a,g_master.d,g_master.c,g_master.b 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               LET lc_master.* = g_master.*
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD a
            #add-point:BEFORE FIELD a name="input.b.a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD a
            
            #add-point:AFTER FIELD a name="input.a.a"
               IF g_master.a < 0 OR g_master.a > 100 THEN
                  #輸入值不在0-100之間(包括臨界值)！
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00011'
                  LET g_errparam.extend = g_master.a
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET g_master.a = lc_master.a
                  DISPLAY BY NAME g_master.a
                  NEXT FIELD a
               END IF
               IF lc_master.a <> g_master.a THEN
                  CALL asfp500_b1_fill()
                  CALL asfp500_b2_fill()
                  CALL asfp500_b3_fill()
                  CALL asfp500_b4_fill()                     
               END IF
               LET lc_master.a = g_master.a
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE a
            #add-point:ON CHANGE a name="input.g.a"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD d
            #add-point:BEFORE FIELD d name="input.b.d"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD d
            
            #add-point:AFTER FIELD d name="input.a.d"
               IF g_master.d NOT MATCHES '[YN]' THEN
                  NEXT FIELD d
               END IF    
               IF lc_master.d <> g_master.d THEN
                  CALL asfp500_b1_fill()
                  CALL asfp500_b2_fill()
                  CALL asfp500_b3_fill()
                  CALL asfp500_b4_fill()                     
               END IF
               LET lc_master.d = g_master.d   
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE d
            #add-point:ON CHANGE d name="input.g.d"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD c
            #add-point:BEFORE FIELD c name="input.b.c"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD c
            
            #add-point:AFTER FIELD c name="input.a.c"
               IF g_master.c NOT MATCHES '[YN]' THEN
                  NEXT FIELD c
               END IF               
               IF lc_master.c <> g_master.c THEN
                  CALL asfp500_b1_fill()
                  CALL asfp500_b2_fill()
                  CALL asfp500_b3_fill()
                  CALL asfp500_b4_fill()                     
               END IF
               LET lc_master.c = g_master.c
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE c
            #add-point:ON CHANGE c name="input.g.c"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b
            #add-point:BEFORE FIELD b name="input.b.b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b
            
            #add-point:AFTER FIELD b name="input.a.b"
               IF g_master.b NOT MATCHES '[YN]' THEN
                  NEXT FIELD b
               END IF
               IF lc_master.b <> g_master.b THEN
                  CALL asfp500_b1_fill()
                  CALL asfp500_b2_fill()
                  CALL asfp500_b3_fill()
                  CALL asfp500_b4_fill()                     
               END IF
               LET lc_master.b = g_master.b
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE b
            #add-point:ON CHANGE b name="input.g.b"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD a
            #add-point:ON ACTION controlp INFIELD a name="input.c.a"
            
            #END add-point
 
 
         #Ctrlp:input.c.d
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD d
            #add-point:ON ACTION controlp INFIELD d name="input.c.d"
            
            #END add-point
 
 
         #Ctrlp:input.c.c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD c
            #add-point:ON ACTION controlp INFIELD c name="input.c.c"
            
            #END add-point
 
 
         #Ctrlp:input.c.b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b
            #add-point:ON ACTION controlp INFIELD b name="input.c.b"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         
      
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"

      
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         DISPLAY ARRAY g_sfba_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b2) 

            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")


            BEFORE DISPLAY
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
              #LET g_current_page = 2

         END DISPLAY

         DISPLAY ARRAY g_sfcb_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b3) 

            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail3")


            BEFORE DISPLAY
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
              #LET g_current_page = 2

         END DISPLAY

         DISPLAY ARRAY g_prog_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b4) 

            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail4")


            BEFORE DISPLAY
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
              #LET g_current_page = 2

         END DISPLAY     
         
         INPUT ARRAY g_sfaa_d FROM s_detail1.*
             ATTRIBUTE(COUNT = g_rec_b1,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                     INSERT ROW = FALSE, 
                     DELETE ROW = FALSE,
                     APPEND ROW = FALSE)
            
            BEFORE ROW
               LET l_ac = ARR_CURR()
               CALL asfp500_b2_fill()
               CALL asfp500_b3_fill()
               CALL asfp500_b4_fill()
               
            BEFORE FIELD sel
               CALL cl_set_comp_required('close_dd',FALSE)
 
            ON CHANGE sel
               IF g_sfaa_d[l_ac].sel = 'Y' THEN
                  CALL s_asfp500_get_max_reference_date(g_sfaa_d[l_ac].sfaadocno)
                       RETURNING l_date,l_flag     #160111-00024#1 --- add
                       #RETURNING l_date           #160111-00024#1 --- mark       
                  IF cl_null(g_sfaa_d[l_ac].close_dd) OR g_sfaa_d[l_ac].close_dd < l_date THEN
                     LET g_sfaa_d[l_ac].close_dd = l_date
                  END IF
               ELSE
                  LET g_sfaa_d[l_ac].close_dd = NULL
               END IF
               DISPLAY BY NAME g_sfaa_d[l_ac].close_dd
               
            AFTER FIELD sel
               IF g_sfaa_d[l_ac].sel NOT MATCHES '[YN]' THEN
                  NEXT FIELD sel
               END IF
               IF g_sfaa_d[l_ac].sel = 'Y' THEN
                  CALL cl_set_comp_required('close_dd',TRUE)
                  CALL s_asfp500_get_max_reference_date(g_sfaa_d[l_ac].sfaadocno)
                       RETURNING l_date,l_flag     #160111-00024#1 --- add
                       #RETURNING l_date           #160111-00024#1 --- mark       
                  IF cl_null(g_sfaa_d[l_ac].close_dd) OR g_sfaa_d[l_ac].close_dd < l_date THEN
                     LET g_sfaa_d[l_ac].close_dd = l_date
                     DISPLAY BY NAME g_sfaa_d[l_ac].close_dd
                  END IF
                  
                  #151229-00004#1 --- add start ---
                  CALL asfp500_close_yn(g_sfaa_d[l_ac].sfaadocno) RETURNING l_yn
                  IF l_yn = 'N' THEN   #收貨量不等於入庫量，不可結案
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'asf-00702'
                     LET g_errparam.extend = g_sfaa_d[l_ac].sfaadocno
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_sfaa_d[l_ac].sel = 'N' 
                     DISPLAY BY NAME g_sfaa_d[l_ac].sel
                     
                     NEXT FIELD sel
                  END IF
                  #151229-00004#1 --- add end   ---
                  
               END IF
               
#            BEFORE FIELD close_dd
#               IF g_sfaa_d[l_ac].sel = 'Y' THEN
#                  CALL s_asfp500_get_max_reference_date(g_sfaa_d[l_ac].sfaadocno)
#                       RETURNING l_date
#                  IF cl_null(g_sfaa_d[l_ac].close_dd) THEN
#                     LET g_sfaa_d[l_ac].close_dd = l_date
#                  END IF
#               END IF            
               
            AFTER FIELD close_dd
               IF NOT cl_null(g_sfaa_d[l_ac].close_dd) THEN
                  IF g_sfaa_d[l_ac].close_dd < g_close_dd THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'asf-00008'
                     LET g_errparam.extend = g_sfaa_d[l_ac].close_dd
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD close_dd
                  END IF
                  IF g_sfaa_d[l_ac].close_dd < l_date THEN
                     #其他作业有使用此工单单号，工单的结案日期不可小于这些单据中的单据日期或是过帐日期 或 工单本身的开立日期！
                     INITIALIZE g_errparam TO NULL
                     #LET g_errparam.code = 'asf-00206'        #160111-00024#1 --- add mark
                     #160111-00024#1  By Ann_Huang --- add Start ---
                     CASE l_flag
                          WHEN '1'  LET g_errparam.code = 'asf-00704'   #發料/退料單   
                          WHEN '2'  LET g_errparam.code = 'asf-00705'   #報工單   
                          WHEN '3'  LET g_errparam.code = 'asf-00706'   #當站報廢單
                          WHEN '4'  LET g_errparam.code = 'asf-00707'   #當站下線單
                          WHEN '5'  LET g_errparam.code = 'asf-00708'   #重工轉出單
                          WHEN '6'  LET g_errparam.code = 'asf-00709'   #下階料報廢單
                          WHEN '7'  LET g_errparam.code = 'asf-00710'   #完工入庫單
                          WHEN '8'  LET g_errparam.code = 'asf-00711'   #FQC單
                          WHEN '9'  LET g_errparam.code = 'asf-00712'   #委外採購單
                          WHEN '10'  LET g_errparam.code = 'asf-00713'  #委外收貨單、驗退單、委外入庫、倉退單
                          WHEN '11'  LET g_errparam.code = 'asf-00714'  #IQC單
                     END CASE
                     #160111-00024#1  By Ann_Huang --- add End ---
                     LET g_errparam.extend = g_sfaa_d[l_ac].close_dd
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD close_dd
                  END IF                  
               END IF
  

            ON ACTION accept
               ACCEPT DIALOG
 
            ON ACTION cancel
               LET INT_FLAG = 1
               EXIT DIALOG 

         END INPUT         


         
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
      
         #end add-point
 
         SUBDIALOG lib_cl_schedule.cl_schedule_setting
         SUBDIALOG lib_cl_schedule.cl_schedule_setting_exec_call
         SUBDIALOG lib_cl_schedule.cl_schedule_select_show_history
         SUBDIALOG lib_cl_schedule.cl_schedule_show_history
 
         BEFORE DIALOG
            LET l_dialog = ui.DIALOG.getCurrent()
            CALL asfp500_get_buffer(l_dialog)
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
            ON ACTION wo_close
               LET g_bgjob = 'N'
               LET g_press = TRUE
               CALL asfp500_process('')
               CALL asfp500_b1_fill()
               CALL asfp500_b2_fill()
               CALL asfp500_b3_fill()
               CALL asfp500_b4_fill()  
               CALL cl_set_comp_required('close_dd',FALSE)                              
               LET g_press = FALSE                
                     
               #end add-point 
            ON ACTION selall
               CALL asfp500_sel_all("Y")

            ON ACTION selnone
               CALL asfp500_sel_all("N")

            ON ACTION query
               LET g_action_choice="query"
               IF cl_auth_chk_act("query") THEN
                  CALL asfp500_query()
               END IF

            ON ACTION filter
#               LET g_action_choice="filter"
#               IF cl_auth_chk_act("filter") THEN
                  CALL asfp500_filter()
#               END IF

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
         CALL asfp500_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      
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
                 CALL asfp500_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = asfp500_transfer_argv(ls_js)
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
 
{<section id="asfp500.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION asfp500_transfer_argv(ls_js)
 
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
 
{<section id="asfp500.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION asfp500_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_i              LIKE type_t.num10
   DEFINE l_k              LIKE type_t.num10
   DEFINE l_x              LIKE type_t.num10
   DEFINE l_y              LIKE type_t.num10   
   DEFINE l_cnt            LIKE type_t.num10
   DEFINE l_success        LIKE type_t.chr1
   DEFINE l_err_tmp        DYNAMIC ARRAY OF type_g_prog_d     
   DEFINE l_sfaadocno      DYNAMIC ARRAY OF LIKE sfaa_t.sfaadocno
   DEFINE l_ok_cnt         LIKE type_t.num10
   DEFINE l_nook_cnt       LIKE type_t.num10
   DEFINE l_close_dd       LIKE type_t.dat
   DEFINE l_success1       LIKE type_t.num5
   DEFINE l_flag           LIKE type_t.chr1   #160111-00024#1 By Ann_Huang --- add
   DEFINE ls_info          STRING             #160330-00012#1 add
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   IF g_bgjob = 'N' THEN
      IF NOT g_press THEN
         RETURN
      END IF
   END IF
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      LET li_count = g_rec_b1
      CALL cl_progress_bar_no_window(li_count)
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE asfp500_process_cs CURSOR FROM ls_sql
#  FOREACH asfp500_process_cs INTO
   #add-point:process段process name="process.process"
   #定义一个取工单对应采购单的CURSOR
   LET ls_sql = " SELECT UNIQUE pmdldocno,pmdnseq,pmdl006,pmdl031,pmdl051,pmdlsite,",
                "               pmdlstus,pmdlcrtid,pmdlcrtdp,pmdldocdt",
                "   FROM pmdl_t,pmdn_t,pmdp_t ",
                "  WHERE pmdlent   = pmdpent   AND pmdlent   = pmdnent ",
                "    AND pmdldocno = pmdpdocno AND pmdldocno = pmdndocno",
                "    AND pmdnseq   = pmdpseq ",
                "    AND pmdl005   = '2' ",           #委外采购
                "    AND pmdl007   = '4' ",           #资料来源4.一般工单
                "    AND pmdp003   = ?   ",           #工单号
                "    AND pmdlstus <>'X' "            #剔除作废单据 liuym150810
               ,"    AND pmdlent = '",g_enterprise,"' "      #170124-00029#1 add
                
   PREPARE asfp500_sel_po_p1 FROM ls_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "prepare asfp500_sel_po_p1"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN 
   END IF

   DECLARE asfp500_sel_po_cs CURSOR FOR asfp500_sel_po_p1
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "declare asfp500_sel_po_cs"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN 
   END IF


   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
      LET l_ok_cnt = 0
      LET l_nook_cnt = 0
      LET l_cnt = 0
      CALL g_err_arr.clear()
      FOR l_i = 1 TO g_rec_b1
         #CALL cl_progress_no_window_ing("读取"||g_sfaa_d[l_i].sfaadocno||"基本资料")  #160330-00012#1 mark
          LET ls_info = cl_getmsg_parm("azz-01004",g_lang,g_sfaa_d[l_i].sfaadocno)    #160330-00012#1 add
          CALL cl_progress_no_window_ing(ls_info)                                     #160330-00012#1 add
          IF g_sfaa_d[l_i].sel = 'Y' THEN
             LET l_cnt = l_cnt + 1
          END IF
          IF g_sfaa_d[l_i].sel = 'Y' AND cl_null(g_sfaa_d[l_i].close_dd) THEN
             #结案日期不可为空
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'asf-00255'
             LET g_errparam.extend = g_sfaa_d[l_i].sfaadocno
             LET g_errparam.popup = TRUE
             CALL cl_err()

          END IF
          
          
          IF g_sfaa_d[l_i].sel = 'Y' AND NOT cl_null(g_sfaa_d[l_i].close_dd) THEN
             CALL s_transaction_begin()
             #CALL s_asfp500_close_wo(g_sfaa_d[l_i].sfaadocno,g_sfaa_d[l_i].close_dd,'N')              #160104-00009#1 mark
             CALL s_asfp500_close_wo(g_sfaa_d[l_i].sfaadocno,g_sfaa_d[l_i].close_dd,'N','asfp500')     #160104-00009#1 add
                  RETURNING l_success,l_err_tmp
             LET l_x = g_err_arr.getLength()
             LET l_y = l_err_tmp.getLength()
             FOR l_k = 1 TO l_y
                 LET g_err_arr[l_x + l_k].* = l_err_tmp[l_k].*
             END FOR
     
             #工单结案正确时,对应的委外PO也一并结案
             IF l_success = 'Y' THEN
                CALL asfp500_po_close(g_sfaa_d[l_i].sfaadocno)
                     RETURNING l_success1
                IF NOT l_success1 THEN
                   LET l_success = 'N'
                END IF
             END IF
             
             IF l_success = 'Y' THEN
                LET l_ok_cnt = l_ok_cnt + 1      
                CALL s_transaction_end('Y','0')
             ELSE
                CALL s_transaction_end('N','0')
             END IF
          END IF
      END FOR
      
      IF g_err_arr.getLength() > 0 THEN
         CALL asfp500_01(g_err_arr)
      END IF
      LET l_nook_cnt = l_cnt - l_ok_cnt
      #成功结案笔数：%1  失败结案笔数：%2
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00214'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = l_ok_cnt 
      LET g_errparam.replace[2] =  l_nook_cnt
      CALL cl_err()

      RETURN
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      LET g_sql = " SELECT UNIQUE sfaadocno FROM sfaa_t ",
                  " WHERE sfaaent = ",g_enterprise,
                  "   AND sfaastus IN ('F') ",
                  "   AND ",g_param.wc
      PREPARE asfp500_p1 FROM g_sql
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'prepare asfp500_p1'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN
      END IF
      DECLARE asfp500_cs1 CURSOR FOR asfp500_p1
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'prepare asfp500_cs1'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN
      END IF
      LET l_i = 1
      FOREACH asfp500_cs1 INTO l_sfaadocno[l_i]
          LET l_i = l_i + 1
      END FOREACH
      LET l_cnt = l_i - 1
      
      FOR l_i = 1 TO l_cnt
          
          CALL s_transaction_begin()
          #若传入的工单结案日期为空时,重新取一下工单合适的结案日期
          LET l_close_dd = g_param.close_dd
          IF cl_null(g_param.close_dd) THEN
             CALL s_asfp500_get_max_reference_date(l_sfaadocno[l_i])
                  RETURNING l_close_dd,l_flag     #160111-00024#1 --- add
                  #RETURNING l_close_dd           #160111-00024#1 --- mark
          END IF
          #CALL s_asfp500_close_wo(l_sfaadocno[l_i],l_close_dd,g_param.auto)             #160104-00009#1 mark
          CALL s_asfp500_close_wo(l_sfaadocno[l_i],l_close_dd,g_param.auto,g_prog_flag)  #160104-00009#1 add
               RETURNING l_success,l_err_tmp
          LET l_x = g_err_arr.getLength()
          LET l_y = l_err_tmp.getLength()
          FOR l_k = 1 TO l_y
              LET g_err_arr[l_x + l_k].* = l_err_tmp[l_k].*
          END FOR
          
          #工单结案正确时,对应的委外PO也一并结案
          IF l_success = 'Y' THEN
          #170111-00049#1-----dujuan------add------str---
             IF g_argv[5] = 'apmt571' THEN
               CALL asfp500_po_close(l_sfaadocno[l_i])
                     RETURNING l_success1
                IF NOT l_success1 THEN
                   LET l_success = 'N'
                END IF
             ELSE
           #170111-00049#1-----dujuan------add------end---
                CALL asfp500_po_close(g_sfaa_d[l_i].sfaadocno)
                     RETURNING l_success1
                IF NOT l_success1 THEN
                   LET l_success = 'N'
                END IF
             END IF #170111-00049#1-----dujuan------add
          END IF
             
          IF l_success = 'Y' THEN             
             CALL s_transaction_end('Y','0')
          ELSE             
             CALL s_transaction_end('N','0')
          END IF
      END FOR
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL asfp500_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="asfp500.get_buffer" >}
PRIVATE FUNCTION asfp500_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.a = p_dialog.getFieldBuffer('a')
   LET g_master.d = p_dialog.getFieldBuffer('d')
   LET g_master.c = p_dialog.getFieldBuffer('c')
   LET g_master.b = p_dialog.getFieldBuffer('b')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="asfp500.msgcentre_notify" >}
PRIVATE FUNCTION asfp500_msgcentre_notify()
 
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
 
{<section id="asfp500.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"
################################################################################
# Descriptions...: 查询功能
# Memo...........:
# Usage..........: CALL s_query()
#                       RETURNING NULL
# Input parameter: NULL
# Return code....: NULL
# Date & Author..: 2014-03-21 By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp500_query()
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   
   LET INT_FLAG = 0
   CLEAR FORM  
   CALL g_sfaa_d.clear()
   CALL g_sfba_d.clear()
   CALL g_sfcb_d.clear()
   CALL g_prog_d.clear()
   
   LET g_action_choice = 'c'
   LET ls_wc = g_param.wc   

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      CONSTRUCT g_param.wc ON sfaadocno,sfaa003,sfaa057,sfaa010,sfaa020,sfaastus,sfaa012,sfaa050, 
                               sfaa051,  sfaa055,sfaa056,sfaa013,sfaa009,sfaa017, sfaa002,sfaasite
           FROM s_detail1[1].sfaadocno,s_detail1[1].sfaa003, s_detail1[1].sfaa057,s_detail1[1].sfaa010,
                s_detail1[1].sfaa020,  s_detail1[1].sfaastus,s_detail1[1].sfaa012,s_detail1[1].sfaa050,
                s_detail1[1].sfaa051,  s_detail1[1].sfaa055, s_detail1[1].sfaa056,s_detail1[1].sfaa013,
                s_detail1[1].sfaa009,  s_detail1[1].sfaa017, s_detail1[1].sfaa002,s_detail1[1].sfaasite   

         #工单单号
         ON ACTION controlp INFIELD sfaadocno
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site            
            LET g_qryparam.where = " sfaasite = '",g_site,"' "
            CALL q_sfaadocno_2() 
            DISPLAY g_qryparam.return1 TO sfaadocno
            NEXT FIELD sfaadocno    

         #料件
         ON ACTION controlp INFIELD sfaa010
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaf001() 
            DISPLAY g_qryparam.return1 TO sfaa010
            NEXT FIELD sfaa010
            
         #单位
         ON ACTION controlp INFIELD sfaa013
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001() 
            DISPLAY g_qryparam.return1 TO sfaa013
            NEXT FIELD sfaa013

         #客户
         ON ACTION controlp INFIELD sfaa009
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_6() 
            DISPLAY g_qryparam.return1 TO sfaa009
            NEXT FIELD sfaa009

         #委外厂商
         ON ACTION controlp INFIELD sfaa017
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_3() 
            DISPLAY g_qryparam.return1 TO sfaa017
            NEXT FIELD sfaa017

         #生管人员
         ON ACTION controlp INFIELD sfaa002
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001() 
            DISPLAY g_qryparam.return1 TO sfaa002
            NEXT FIELD sfaa002

      END CONSTRUCT
      
      BEFORE DIALOG
         CALL cl_qbe_init() 
 
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
    
      #條件儲存為方案
      ON ACTION qbe_save
         CALL cl_qbe_save()
 
      ON ACTION accept
         ACCEPT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG 
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG      

   END DIALOG

   IF INT_FLAG THEN
      RETURN
      LET g_param.wc = ls_wc
   END IF
   
   LET g_error_show = 1
   CALL asfp500_b1_fill()
   CALL asfp500_b2_fill()
   CALL asfp500_b3_fill()
   CALL asfp500_b4_fill()   
   IF g_rec_b1 = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = -100
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF

   LET INT_FLAG = FALSE
   
END FUNCTION
################################################################################
# Descriptions...: 工单单身fill
# Memo...........:
# Usage..........: CALL asfp500_b1_fill()
#                  RETURNING NULL
# Input parameter: NULL
# Return code....: NULL
# Date & Author..: 2014-03-24 By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp500_b1_fill()
   DEFINE l_i            LIKE type_t.num5
   DEFINE l_unfinish_rt  LIKE type_t.num26_10
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_cnt          LIKE type_t.num10
   
   CALL g_sfaa_d.clear()
   
   IF cl_null(g_param.wc) THEN
      LET g_param.wc = ' 1 = 1'
   END IF
   
   LET g_sql = " SELECT 'N'    , sfaadocno, sfaa003, sfaa057, sfaa010, ''     , ''     , ",
               "        sfaa020, sfaastus , sfaa012, sfaa050, sfaa051, sfaa055, sfaa056, ",
               "        0      , 0        , sfaa013, sfaa009, ''     , sfaa017, ''     , ",
               "        sfaa002, ''       , 'N'    , 'N'    , 'N'    , ''     ,sfaasite  ",
               "   FROM sfaa_t a ",
               " WHERE sfaaent = ",g_enterprise,
               "   AND sfaastus IN ('F') ",
               "   AND sfaasite = '",g_site,"'",  
               "   AND ",g_param.wc

   #未完工量比率小于 a
   IF NOT cl_null(g_master.a) THEN
      #(生产数量-入库量)/生产数量* 100
      LET g_sql = g_sql CLIPPED,"  AND ((sfaa012 - sfaa050 ) / sfaa012 * 100 <= ",g_master.a,")"
   END IF  

   #发料未完成 -- 未完足套
   #实发数量 > 应发数量 * ( 1 - 允许差异率(发料) / 100)
   IF g_master.b = 'N' THEN
      LET g_sql = g_sql CLIPPED,"  AND NOT EXISTS(",
                                "  SELECT 1 FROM sfba_t b",
                                "   WHERE a.sfaaent = b.sfbaent AND a.sfaadocno = b.sfbadocno ",
                                "     AND b.sfba016 < b.sfba013 * ( 1 - sfba012 / 100 ) )"
   END IF

   #报工未完成
   IF g_master.c = 'N' THEN
      LET g_sql = g_sql CLIPPED,"  AND NOT EXISTS(",
                                "  SELECT 1 FROM sfcb_t c",
                                "   WHERE a.sfaaent = c.sfcbent AND a.sfaadocno = c.sfcbdocno ",
                                "     AND (sfcb046 > 0 OR sfcb047 > 0 OR sfcb048 > 0  OR ",
                                "          sfcb049 > 0 OR sfcb050 > 0 OR sfcb051 > 0 ))  "
   END IF

   LET g_sql = g_sql CLIPPED," ORDER BY sfaadocno"
   PREPARE asfp500_b1_fill_p1 FROM g_sql
   DECLARE asfp500_b1_fill_cs1 CURSOR FOR asfp500_b1_fill_p1
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'declare asfp500_b1_fill_cs1'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF

   LET l_i = 1
   FOREACH asfp500_b1_fill_cs1 INTO g_sfaa_d[l_i].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF   
      
      #完工差異數diff_qty:生產數量sfaa012-入庫合格量sfaa050-入庫不合格量sfaa051-
      #                  下線量sfaa055-報廢量sfaa056
      IF cl_null(g_sfaa_d[l_i].sfaa012) THEN LET g_sfaa_d[l_i].sfaa012 = 0 END IF
      IF cl_null(g_sfaa_d[l_i].sfaa050) THEN LET g_sfaa_d[l_i].sfaa050 = 0 END IF      
      IF cl_null(g_sfaa_d[l_i].sfaa051) THEN LET g_sfaa_d[l_i].sfaa051 = 0 END IF      
      IF cl_null(g_sfaa_d[l_i].sfaa055) THEN LET g_sfaa_d[l_i].sfaa055 = 0 END IF      
      IF cl_null(g_sfaa_d[l_i].sfaa056) THEN LET g_sfaa_d[l_i].sfaa056 = 0 END IF      
      LET g_sfaa_d[l_i].diff_qty = g_sfaa_d[l_i].sfaa012 -  g_sfaa_d[l_i].sfaa050 -  g_sfaa_d[l_i].sfaa051 - 
                                   g_sfaa_d[l_i].sfaa055 -  g_sfaa_d[l_i].sfaa056

      #未完工比率 unfinish_rate = 完工差异数 / 生产数量 * 100
      LET g_sfaa_d[l_i].unfinish_rate = g_sfaa_d[l_i].diff_qty / g_sfaa_d[l_i].sfaa012 * 100

      ##未完工量比率小于 a
      #IF NOT cl_null(g_input_h.a) THEN
      #   #(生产数量-入库量)/生产数量* 100
      #   LET l_unfinish_rt = (g_sfaa_d[l_i].sfaa012 - g_sfaa_d[l_i].sfaa050 ) / g_sfaa_d[l_i].sfaa012 * 100
      #   IF l_unfinish_rt > g_input_h.a THEN
      #      CONTINUE FOREACH
      #   END IF
      #END IF  

      ##发料未完成 -- 未完足套
      ##实发数量 > 应发数量 * ( 1 - 允许差异率(发料) / 100)
      IF g_master.b = 'N' THEN
         LET g_sfaa_d[l_i].unfinish_b = 'N'
      ELSE
         LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt FROM sfba_t
          WHERE sfbaent   = g_enterprise
            AND sfbadocno = g_sfaa_d[l_i].sfaadocno
            AND sfba016 < sfba013 * ( 1 - sfba012 / 100)
         IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
         IF l_cnt > 0 THEN
            LET g_sfaa_d[l_i].unfinish_b = 'Y'
         ELSE
            LET g_sfaa_d[l_i].unfinish_b = 'N'
         END IF
      END IF
      
      #报工未完成
      IF g_master.c = 'N' THEN
         LET g_sfaa_d[l_i].unfinish_c = 'N'
      ELSE      
         LET l_cnt = 0 
         SELECT COUNT(*) INTO l_cnt FROM sfcb_t
          WHERE sfcbent = g_enterprise
            AND sfcbdocno = g_sfaa_d[l_i].sfaadocno
            AND (sfcb046 > 0 OR sfcb047 > 0 OR sfcb048 > 0  OR
                 sfcb049 > 0 OR sfcb050 > 0 OR sfcb051 > 0 )
         IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
         IF l_cnt > 0 THEN
            LET g_sfaa_d[l_i].unfinish_c = 'Y'
         ELSE
            LET g_sfaa_d[l_i].unfinish_c = 'N'
         END IF
      END IF
      
      #未完成单据
      CALL s_asfp500_unfinished_chk(g_sfaa_d[l_i].sfaadocno)
           RETURNING l_success      
      IF g_master.d = 'N' THEN
         IF l_success THEN
            CONTINUE FOREACH
         END IF
      ELSE
         IF l_success THEN
            LET g_sfaa_d[l_i].unfinish_d = 'Y'         
         ELSE
            LET g_sfaa_d[l_i].unfinish_d = 'N'         
         END IF
      END IF
      
      CALL s_desc_get_item_desc(g_sfaa_d[l_i].sfaa010)
           RETURNING g_sfaa_d[l_i].sfaa010_desc1,g_sfaa_d[l_i].sfaa010_desc2
           
      CALL s_desc_get_trading_partner_abbr_desc(g_sfaa_d[l_i].sfaa009)
           RETURNING g_sfaa_d[l_i].sfaa009_desc

      CALL s_desc_get_department_desc(g_sfaa_d[l_i].sfaa017)
           RETURNING g_sfaa_d[l_i].sfaa017_desc

      CALL s_desc_get_person_desc(g_sfaa_d[l_i].sfaa002)
           RETURNING g_sfaa_d[l_i].sfaa002_desc     
           
      LET l_i = l_i + 1
   
   END FOREACH
   
   CALL g_sfaa_d.deleteElement(l_i)
   LET g_rec_b1 = l_i - 1
   
   IF g_rec_b1 > 0 THEN
      LET l_ac = 1
   END IF
           
END FUNCTION
################################################################################
# Descriptions...: 备料未发全单身fill
# Memo...........:
# Usage..........: CALL asfp500_b2_fill()
#                  RETURNING NULL
# Input parameter: NULL
# Return code....: NULL
# Date & Author..: 2014-03-24 By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp500_b2_fill()
   DEFINE l_i            LIKE type_t.num5
   
   CALL g_sfba_d.clear()
   
   IF l_ac <=0 THEN
      RETURN
   END IF
   
   LET g_sql = " SELECT sfbaseq, sfbaseq1, sfba006, '',      '', sfba002, '',     ",
               "        sfba003, '',       sfba004, sfba014, '', sfba023, sfba024, ",
               "        sfba013, sfba015,  sfba016, sfba025, 0,  sfba017, sfba018, ",
               "        sfba012   ",
               "   FROM sfba_t ",
               "  WHERE sfbaent   = ",g_enterprise,
               "    AND sfbadocno = '",g_sfaa_d[l_ac].sfaadocno,"'",
               "    AND sfba016   < sfba013 * ( 1 - sfba012 / 100 )",
               "    AND sfba008 IN ('1','2','3') ",
               "  ORDER BY sfbaseq,sfbaseq1 "

   PREPARE asfp500_b2_fill_p1 FROM g_sql
   DECLARE asfp500_b2_fill_cs1 CURSOR FOR asfp500_b2_fill_p1
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'declare asfp500_b2_fill_cs1'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF

   LET l_i = 1
   FOREACH asfp500_b2_fill_cs1 INTO g_sfba_d[l_i].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF   

      CALL s_desc_get_item_desc(g_sfba_d[l_i].sfba006)
           RETURNING g_sfba_d[l_i].sfba006_desc1,g_sfba_d[l_i].sfba006_desc2

      #部位说明
      CALL s_desc_get_acc_desc('215',g_sfba_d[l_i].sfba002)
           RETURNING g_sfba_d[l_i].sfba002_desc

      #作业说明
      CALL s_desc_get_acc_desc('221',g_sfba_d[l_i].sfba003)      
           RETURNING g_sfba_d[l_i].sfba003_desc

      #单位说明
      CALL s_desc_get_unit_desc(g_sfba_d[l_i].sfba014)
           RETURNING g_sfba_d[l_i].sfba014_desc
           
      #未发数量
      LET g_sfba_d[l_i].unissue_qty =  g_sfba_d[l_i].sfba013 - g_sfba_d[l_i].sfba016
      LET l_i = l_i + 1
   
   END FOREACH
   LET g_rec_b2 = l_i - 1   
   CALL g_sfba_d.deleteElement(l_i)
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
PRIVATE FUNCTION asfp500_b3_fill()
   DEFINE l_i            LIKE type_t.num5
   
   CALL g_sfcb_d.clear()
   
   IF l_ac <=0 THEN
      RETURN
   END IF

   LET g_sql = " SELECT sfcb001, sfcb002, sfcb003, sfcb004, sfcb046, sfcb047,",
               "        sfcb050, sfcb048, sfcb049, sfcb051",
               "   FROM sfcb_t ",
               "  WHERE sfcbent   = ",g_enterprise,
               "    AND sfcbdocno = '",g_sfaa_d[l_ac].sfaadocno,"'",
               "    AND (sfcb046 > 0 OR sfcb047 > 0 OR sfcb048 > 0 OR ",
               "         sfcb049 > 0 OR sfcb050 > 0 OR sfcb051 > 0 )  ",
               "  ORDER BY sfcb001, sfcb002 "

   PREPARE asfp500_b3_fill_p1 FROM g_sql
   DECLARE asfp500_b3_fill_cs1 CURSOR FOR asfp500_b3_fill_p1
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'declare asfp500_b3_fill_cs1'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF

   LET l_i = 1
   FOREACH asfp500_b3_fill_cs1 INTO g_sfcb_d[l_i].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF   
       
      LET l_i = l_i + 1
   
   END FOREACH
   LET g_rec_b3 = l_i - 1   
   CALL g_sfcb_d.deleteElement(l_i)
   
END FUNCTION
################################################################################
# Descriptions...: 未完成单据单身fill
# Memo...........:
# Usage..........: CALL asfp500_b4_fill()
#                  RETURNING NULL
# Input parameter: NULL
# Return code....: NULL
# Date & Author..: 2014-03-24 By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp500_b4_fill()
   DEFINE l_i            LIKE type_t.num5
   DEFINE l_success      LIKE type_t.chr1
   DEFINE l_cnt          LIKE type_t.num5
   
   CALL g_prog_d.clear()
   
   IF l_ac <=0 THEN
      RETURN
   END IF
   
   CALL s_asfp500_unfinished_reference(g_sfaa_d[l_ac].sfaadocno,'','1')
        RETURNING l_success,l_cnt,g_prog_d
   LET g_rec_b4 = l_cnt       
END FUNCTION
################################################################################
# Descriptions...: 全选
# Memo...........:
# Usage..........: CALL asfp500_sel_all(p_flag)
#                       RETURNING NULL
# Input parameter: p_flag         Y/N
# Return code....: NULL
# Date & Author..: 2014-03-24 By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp500_sel_all(p_flag)
   DEFINE p_flag         LIKE type_t.chr1
   DEFINE l_i            LIKE type_t.num5
   DEFINE l_date         LIKE type_t.dat
   DEFINE l_flag         LIKE type_t.chr1   #160111-00024#1 By Ann_Huang --- add
   
   FOR l_i = 1 TO g_sfaa_d.getLength()
       LET g_sfaa_d[l_i].sel = p_flag
       IF p_flag = 'Y' THEN
          CALL s_asfp500_get_max_reference_date(g_sfaa_d[l_i].sfaadocno)
               RETURNING l_date,l_flag      #160111-00024#1 --- add
               #RETURNING l_date            #160111-00024#1 --- mark
          IF cl_null(g_sfaa_d[l_i].close_dd) OR g_sfaa_d[l_i].close_dd < l_date THEN
             LET g_sfaa_d[l_i].close_dd = l_date
          END IF 
       ELSE
          LET g_sfaa_d[l_i].close_dd = NULL
       END IF
   END FOR
END FUNCTION

################################################################################
# Descriptions...: 批次错误显示
# Memo...........:
# Usage..........: CALL asfp500_show_err()
#                  RETURNING NULL
# Input parameter: NULL
# Return code....: NULL
# Date & Author..: 2014-04-08
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp500_show_err()

END FUNCTION

################################################################################
# Descriptions...: 二次过滤
# Memo...........:
# Usage..........: CALL asfp500_filter()
#                  RETURNING NULL
# Input parameter: NULL
# Return code....: NULL
# Date & Author..: 2014-04-10 By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp500_filter()
   DEFINE l_filter_wc    STRING

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      CONSTRUCT l_filter_wc ON sfaadocno,sfaa003,sfaa057,sfaa010,sfaa020,sfaastus,sfaa012,sfaa050, 
                              sfaa051,  sfaa055,sfaa056,sfaa013,sfaa009,sfaa017, sfaa002,sfaasite
           FROM s_detail1[1].sfaadocno,s_detail1[1].sfaa003, s_detail1[1].sfaa057,s_detail1[1].sfaa010,
                s_detail1[1].sfaa020,  s_detail1[1].sfaastus,s_detail1[1].sfaa012,s_detail1[1].sfaa050,
                s_detail1[1].sfaa051,  s_detail1[1].sfaa055, s_detail1[1].sfaa056,s_detail1[1].sfaa013,
                s_detail1[1].sfaa009,  s_detail1[1].sfaa017, s_detail1[1].sfaa002,s_detail1[1].sfaasite   

         #工单单号
         ON ACTION controlp INFIELD sfaadocno
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site
            LET g_qryparam.where = " sfaasite = '",g_site,"' "
            CALL q_sfaadocno_2() 
            DISPLAY g_qryparam.return1 TO sfaadocno
            NEXT FIELD sfaadocno    

         #料件
         ON ACTION controlp INFIELD sfaa010
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaf001() 
            DISPLAY g_qryparam.return1 TO sfaa010
            NEXT FIELD sfaa010
            
         #单位
         ON ACTION controlp INFIELD sfaa013
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001() 
            DISPLAY g_qryparam.return1 TO sfaa013
            NEXT FIELD sfaa013

         #客户
         ON ACTION controlp INFIELD sfaa009
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_6() 
            DISPLAY g_qryparam.return1 TO sfaa009
            NEXT FIELD sfaa009

         #委外厂商
         ON ACTION controlp INFIELD sfaa017
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_3() 
            DISPLAY g_qryparam.return1 TO sfaa017
            NEXT FIELD sfaa017

         #生管人员
         ON ACTION controlp INFIELD sfaa002
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001() 
            DISPLAY g_qryparam.return1 TO sfaa002
            NEXT FIELD sfaa002

      END CONSTRUCT
 
      ON ACTION accept
         ACCEPT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG 
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG      

   END DIALOG
   
   LET g_param.wc = g_param.wc CLIPPED,' AND ',l_filter_wc
   CALL asfp500_b1_fill()
   CALL asfp500_b2_fill()
   CALL asfp500_b3_fill()
   CALL asfp500_b4_fill()      
END FUNCTION

################################################################################
# Descriptions...: 請購單結案  -- 抄apmp510
# Memo...........: 請購單多角單據結案作業
# Usage..........: CALL asfp500_aic_closed(p_type,p_pmdnseq,p_pmdn051,p_pmdl031,p_pmdl051)
# Input parameter: p_type         狀態 1.結案 2取消結案
#                : p_pmdnseq      請購單項次
#                : p_pmdn051      結案理由碼
#                : p_pmdl031      多角來源單號
#                : p_pmdn050      多角流程式碼
# Return code....:
# Date & Author..: 2015-06-08  By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp500_aic_closed(p_type,p_pmdnseq,p_pmdn051,p_pmdl031,p_pmdl051)
   DEFINE p_type      LIKE type_t.num5          #型態1結案；2取消結案
   DEFINE p_pmdnseq   LIKE pmdn_t.pmdnseq       #請購單項次
   DEFINE p_pmdn051   LIKE pmdn_t.pmdn051       #結案理由碼
   DEFINE p_pmdl031   LIKE pmdl_t.pmdl031       #多角來源單號
   DEFINE p_pmdl051   LIKE pmdl_t.pmdl051       #多角流程代碼
   DEFINE l_icab003   LIKE icab_t.icab003       #多角營運據點
   DEFINE l_pmdldocno LIKE pmdl_t.pmdldocno     #採購單單號
   DEFINE l_sfaadocno LIKE sfaa_t.sfaadocno     #工單單號
   DEFINE l_xmdadocno LIKE xmda_t.xmdadocno     #訂單單號
   DEFINE l_sql       STRING
   DEFINE l_success   LIKE type_t.num5


   LET l_sql = "SELECT icab003 ",
               "  FROM icaa_t,icab_t ",
               " WHERE icaaent = '",g_enterprise,"' " ,
               "   AND icaasite = '",g_site,"' " ,
               "   AND icaa001 = '",p_pmdl051,"' " ,
               "   AND icaa001 = icab001 "

   PREPARE s_asfp500_sel_pr_aic FROM l_sql
   DECLARE s_asfp500_sel_cs_aic CURSOR FOR s_asfp500_sel_pr_aic

   #各站營運據點依多角流程序號取得各站 請購單/採購單/工單 單號做結案
   FOREACH s_asfp500_sel_cs_aic INTO l_icab003
      #訂單單號
      LET l_xmdadocno = ''
      SELECT xmdadocno INTO l_xmdadocno
        FROM xmda_t
       WHERE xmdaent = g_enterprise
         AND xmdasite = l_icab003
         AND xmda031 = p_xmda031
      IF NOT cl_null(l_xmdadocno) THEN
         IF p_type = 1 THEN
            #結案
            IF NOT p_pmdnseq > 0 THEN
               CALL s_axmp510_xmdc045_closed('2',l_xmdadocno,p_pmdnseq,p_pmdl051,l_icab003) RETURNING l_success
            ELSE
               CALL s_axmp510_xmda045_closed(l_xmdadocno,l_icab003) RETURNING l_success
               CALL s_axmp510_xmda046_closed(l_xmdadocno,l_icab003) RETURNING l_success
               CALL s_axmp510_xmda047_closed(l_xmdadocno,l_icab003) RETURNING l_success
               CALL s_axmp510_xmdastus_closed('2',l_xmdadocno,l_icab003) RETURNING l_success
            END IF
         ELSE
            #取消結案
            IF NOT p_pmdnseq > 0 THEN
               CALL s_axmp510_xmdc045_unclosed(l_xmdadocno,p_pmdnseq,l_icab003) RETURNING l_success
            ELSE
               CALL s_axmp510_xmda045_unclosed(l_xmdadocno,l_icab003) RETURNING l_success
            END IF
         END IF
      END IF

      #採購單單號
      LET l_pmdldocno = ''
      SELECT pmdldocno INTO l_pmdldocno
        FROM pmdl_t
       WHERE pmdlent = g_enterprise
         AND pmdlsite = l_icab003
         AND pmdl031 = p_pmdl031
      IF NOT cl_null(l_pmdldocno) THEN
         IF p_type = 1 THEN
            #結案
            IF NOT p_pmdnseq > 0 THEN
               CALL s_apmp510_pmdn045_closed('2',l_pmdldocno,p_pmdnseq,p_pmdn051,l_icab003) RETURNING l_success
            ELSE
               CALL s_apmp510_pmdl047_closed(l_pmdldocno,l_icab003) RETURNING l_success
               CALL s_apmp510_pmdl048_closed(l_pmdldocno,l_icab003) RETURNING l_success
               CALL s_apmp510_pmdl049_closed(l_pmdldocno,l_icab003) RETURNING l_success
               CALL s_apmp510_pmdlstus_closed('2',l_pmdldocno,l_icab003) RETURNING l_success
            END IF
         ELSE
            #取消結案
            IF NOT p_pmdnseq > 0 THEN
               CALL s_apmp510_pmdn045_unclosed(l_pmdldocno,p_pmdnseq,l_icab003) RETURNING l_success
            ELSE
               CALL s_apmp510_pmdl047_unclosed(l_pmdldocno,l_icab003) RETURNING l_success
            END IF
         END IF
      END IF


   END FOREACH
                  
END FUNCTION

################################################################################
# Descriptions...: 工单对应的委外采购单结案
# Memo...........:
# Usage..........: CALL asfp500_po_close(p_sfaadocno)
#                       RETURNING r_success
# Input parameter: p_sfaadocno    工单单号
# Return code....: r_success      成功否标识符
# Date & Author..: 2015-06-09 By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp500_po_close(p_sfaadocno)
   DEFINE p_sfaadocno      LIKE sfaa_t.sfaadocno
   DEFINE r_success        LIKE type_t.num5
   DEFINE l_pmdndocno      LIKE pmdn_t.pmdndocno
   DEFINE l_pmdnseq        LIKE pmdn_t.pmdnseq
   DEFINE l_pmdl006        LIKE pmdl_t.pmdl006
   DEFINE l_pmdl031        LIKE pmdl_t.pmdl031
   DEFINE l_pmdl051        LIKE pmdl_t.pmdl051
   DEFINE l_pmdlsite       LIKE pmdl_t.pmdlsite
   DEFINE l_pmdlstus       LIKE pmdl_t.pmdlstus
   DEFINE l_pmdlcrtid      LIKE pmdl_t.pmdlcrtid
   DEFINE l_pmdlcrtdp      LIKE pmdl_t.pmdlcrtdp
   DEFINE l_pmdldocdt      LIKE pmdl_t.pmdldocdt   
   DEFINE l_flag           LIKE type_t.chr1
   DEFINE l_x              LIKE type_t.num10
   
   WHENEVER ERROR CONTINUE
   
   LET r_success = FALSE
   
   LET l_flag = 'Y'
   FOREACH asfp500_sel_po_cs USING p_sfaadocno
                              INTO l_pmdndocno,l_pmdnseq,l_pmdl006,l_pmdl031,l_pmdl051,l_pmdlsite,
                                   l_pmdlstus,l_pmdlcrtid,l_pmdlcrtdp,l_pmdldocdt
       
       IF l_pmdlstus = 'C' THEN CONTINUE FOREACH END IF  #160128-00022 by whitney add
       
       #單身狀態結案
       IF NOT s_apmp510_pmdn045_closed('2',l_pmdndocno,l_pmdnseq,'',l_pmdlsite) THEN
          LET l_flag = 'N'
       #ELSE
       #   #多角結案(單身狀態)
       #   IF l_pmdl006 = '2' AND NOT cl_null(l_pmdl031) THEN                      #多角結案
       #      CALL asfp500_aic_closed('1',l_pmdnseq,'',l_pmdl031,l_pmdl051)
       #      LET l_flag = 'N'
       #   END IF
       END IF
       
       #物流結案
       IF NOT s_apmp510_pmdl047_closed(l_pmdndocno,l_pmdlsite) THEN
          LET l_flag = 'N'
       END IF
    
       #帳流結案
       IF NOT s_apmp510_pmdl048_closed(l_pmdndocno,g_site) THEN
          LET l_flag = 'N'
       END IF
       #金流結案
       IF NOT s_apmp510_pmdl049_closed(l_pmdndocno,g_site) THEN
          LET l_flag = 'N'
       END IF
       #狀態結案
       IF NOT s_apmp510_pmdlstus_closed('2',l_pmdndocno,g_site) THEN
          LET l_flag = 'N'
       END IF
       ##多角結案(物流、帳流、金流、狀態)
       #IF l_pmdl006 = '2' AND NOT cl_null(l_pmdl031) THEN
       #   CALL asfp500_aic_closed('1',0,'',l_pmdl031,l_pmdl051)
       #END IF                    
    
       IF l_flag = 'N' THEN
          LET l_x = g_err_arr.getLength()
          LET g_err_arr[l_x+1].sdocno = p_sfaadocno
          LET g_err_arr[l_x+1].prog  = 'apmt501'
          LET g_err_arr[l_x+1].docno = l_pmdndocno
          LET g_err_arr[l_x+1].stus  = l_pmdlstus
          LET g_err_arr[l_x+1].crtid = l_pmdlcrtid
          LET g_err_arr[l_x+1].crtdp = l_pmdlcrtdp
          LET g_err_arr[l_x+1].errno = 'asf-00690'
          LET g_err_arr[l_x+1].opendd= l_pmdldocdt
          LET g_err_arr[l_x+1].postdd= ''
          CALL s_desc_get_prog_desc(g_err_arr[l_x+1].prog)
               RETURNING g_err_arr[l_x+1].prog_desc
          CALL s_desc_get_person_desc(g_err_arr[l_x+1].crtid)
               RETURNING g_err_arr[l_x+1].crtid_desc
          CALL s_desc_get_department_desc(g_err_arr[l_x+1].crtdp)
               RETURNING g_err_arr[l_x+1].crtdp_desc                  
          CALL s_desc_get_error_desc(g_err_arr[l_x+1].errno)
               RETURNING g_err_arr[l_x+1].err_desc
       END IF
   END FOREACH   
   
   IF l_flag = 'N' THEN
      RETURN r_success
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 判斷工單是否可結案
# Memo...........: 151229-00004#1 add by tsungyung
# Usage..........: CALL asfp500_close_yn(p_docno)
#                  RETURNING l_yn
# Input parameter: p_docno   傳入工單單號
# Return code....: l_yn   回傳結案否 (Y/N)
# Date & Author..: 2015/12/29 By tsungyung
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp500_close_yn(p_docno)
DEFINE p_docno       LIKE sfaa_t.sfaadocno   #傳入工單單號
DEFINE l_pmdt020_rc  LIKE pmdt_t.pmdt020     #收貨單收貨量
DEFINE l_pmdt020_wh  LIKE pmdt_t.pmdt020     #入庫單入庫量
DEFINE l_pmdt020_re  LIKE pmdt_t.pmdt020     #驗退單驗退量  #170223-00033#1 add
DEFINE l_yn          LIKE type_t.chr1        #回傳結案否 (Y/N)
DEFINE l_pmdldocno   LIKE pmdl_t.pmdldocno   #採購單單號

   LET l_pmdt020_rc = 0
   LET l_pmdt020_wh = 0
   LET l_yn = 'Y' 
   
   SELECT pmdldocno INTO l_pmdldocno
     FROM pmdl_t
    WHERE pmdlent = g_enterprise
      AND pmdl008 = p_docno
      AND pmdl007 = '4'   #工單
    
   SELECT SUM(pmdt020) INTO l_pmdt020_rc 
     FROM pmdt_t,pmds_t
    WHERE pmdsent = pmdtent
      AND pmdsdocno = pmdtdocno
      AND pmds000 = '8'           #收貨單
      AND pmdt001 = l_pmdldocno   #採購單單號
      AND pmdsstus <> 'X' 
      AND pmdtent = g_enterprise
      
   SELECT SUM(pmdt020) INTO l_pmdt020_wh 
     FROM pmdt_t,pmds_t
    WHERE pmdsent = pmdtent
      AND pmdsdocno = pmdtdocno
      AND pmds000 = '12'          #入庫單
      AND pmdt001 = l_pmdldocno   #採購單單號
      AND pmdsstus <> 'X' 
      AND pmdtent = g_enterprise   

   #170223-00033#1 add --(S)--
   SELECT SUM(pmdt020) INTO l_pmdt020_re
     FROM pmdt_t,pmds_t
    WHERE pmdsent = pmdtent
      AND pmdsdocno = pmdtdocno
      AND pmds000 = '10'          #驗退單
      AND pmdt001 = l_pmdldocno   #採購單單號
      AND pmdsstus <> 'X' 
      AND pmdtent = g_enterprise  
   #170223-00033#1 add --(E)--   
   
   IF cl_null(l_pmdt020_rc) THEN LET l_pmdt020_rc = 0 END IF
   IF cl_null(l_pmdt020_wh) THEN LET l_pmdt020_wh = 0 END IF
   IF cl_null(l_pmdt020_re) THEN LET l_pmdt020_re = 0 END IF  #170223-00033#1 add
   
  #IF l_pmdt020_rc <> l_pmdt020_wh THEN                 #170223-00033#1 mark
   IF l_pmdt020_rc <> (l_pmdt020_wh+l_pmdt020_re) THEN  #170223-00033#1 add
      LET l_yn = 'N'
   END IF
   
   RETURN l_yn
   
END FUNCTION

#end add-point
 
{</section>}
 
