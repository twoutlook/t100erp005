#該程式未解開Section, 採用最新樣板產出!
{<section id="axcr520.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2015-04-28 11:20:47), PR版次:0002(2016-10-20 09:40:42)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000043
#+ Filename...: axcr520
#+ Description: 庫存調整表
#+ Creator....: 05947(2015-04-03 17:05:21)
#+ Modifier...: 05947 -SD/PR- 08734
 
{</section>}
 
{<section id="axcr520.global" >}
#應用 r01 樣板自動產生(Version:21)
#add-point:填寫註解說明 name="global.memo"
#Memos
#161019-00017#11   2016/10/20   By 08734   调整法人组织开窗由q_ooef001为q_ooef001_2
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
   DEFINE gi_hiden_rep_temp    LIKE type_t.num5             
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
       xccocomp LIKE xcco_t.xccocomp, 
   xccocomp_desc LIKE type_t.chr80, 
   xcco004 LIKE xcco_t.xcco004, 
   xccold LIKE xcco_t.xccold, 
   xccold_desc LIKE type_t.chr80, 
   xcco005 LIKE xcco_t.xcco005, 
   xcco001 LIKE xcco_t.xcco001, 
   xcco001_desc LIKE type_t.chr80, 
   xcco003 LIKE xcco_t.xcco003, 
   xcco003_desc LIKE type_t.chr80, 
   xcco006 LIKE xcco_t.xcco006, 
   imag011 LIKE imag_t.imag011, 
   xcbb006 LIKE xcbb_t.xcbb006, 
   imaa003 LIKE imaa_t.imaa003, 
   lbl_chk LIKE type_t.chr500,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axcr520.main" >}
MAIN
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter  
   #add-point:main段define name="main.define"
   
   #end add-point 
   #add-point:main段define (客製用) name="main.define_customerization"
   
   #end add-point 
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("axc","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point   
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
      CALL util.JSON.parse(ls_js,g_master)      #r類背景參數解析入口
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL axcr520_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcr520 WITH FORM cl_ap_formpath("axc",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL axcr520_init()
 
      #進入選單 Menu (="N")
      CALL axcr520_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_axcr520
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="axcr520.init" >}
#+ 初始化作業
PRIVATE FUNCTION axcr520_init()
   #add-point:init段define name="init.define"
   
   #end add-point
   #add-point:init段define (客製用) name="init.define_customerization"
   
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
   CALL cl_set_combo_scc('xcco001','8914')
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axcr520.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axcr520_ui_dialog()
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_glaa001 LIKE glaa_t.glaa001
   #end add-point
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.xccocomp,g_master.xcco004,g_master.xccold,g_master.xcco005,g_master.xcco001, 
             g_master.xcco003,g_master.lbl_chk 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
     　　      IF cl_null(g_master.xccocomp) AND cl_null(g_master.xccold) AND cl_null(g_master.xcco004) AND cl_null(g_master.xcco005) AND cl_null(g_master.xcco003) THEN
                  CALL s_axc_set_site_default() RETURNING g_master.xccocomp,g_master.xccold,g_master.xcco004,g_master.xcco005,g_master.xcco003
               END IF
               LET g_master.xcco001 = '1'
               LET g_master.lbl_chk = 'Y'
               
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_master.xccocomp
               CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_master.xccocomp_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_master.xccocomp_desc
               
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_master.xccold
               CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_master.xccold_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_master.xccold_desc
               
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_master.xcco003
               CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_master.xcco003_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_master.xcco003_desc
            
               LET l_glaa001 = ' '
               CASE g_master.xcco001
                  WHEN '1'
                     SELECT glaa001 INTO l_glaa001
                      FROM glaa_t
                     WHERE glaaent = g_enterprise
                       AND glaald  = g_master.xccold
                  WHEN '2'
                     SELECT glaa016 INTO l_glaa001
                      FROM glaa_t
                     WHERE glaaent = g_enterprise
                       AND glaald  = g_master.xccold
                  WHEN '3'
                     SELECT glaa020 INTO l_glaa001
                      FROM glaa_t
                     WHERE glaaent = g_enterprise
                       AND glaald  = g_master.xccold
               END CASE
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = l_glaa001
               CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_master.xcco001_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_master.xcco001_desc
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccocomp
            
            #add-point:AFTER FIELD xccocomp name="input.a.xccocomp"

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_master.xccocomp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_master.xccocomp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_master.xccocomp_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccocomp
            #add-point:BEFORE FIELD xccocomp name="input.b.xccocomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccocomp
            #add-point:ON CHANGE xccocomp name="input.g.xccocomp"
 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcco004
            #add-point:BEFORE FIELD xcco004 name="input.b.xcco004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcco004
            
            #add-point:AFTER FIELD xcco004 name="input.a.xcco004"
            IF cl_null(g_master.xcco004) THEN LET g_master.xcco004 ='' END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcco004
            #add-point:ON CHANGE xcco004 name="input.g.xcco004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccold
            
            #add-point:AFTER FIELD xccold name="input.a.xccold"

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_master.xccold
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_master.xccold_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_master.xccold_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccold
            #add-point:BEFORE FIELD xccold name="input.b.xccold"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccold
            #add-point:ON CHANGE xccold name="input.g.xccold"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcco005
            #add-point:BEFORE FIELD xcco005 name="input.b.xcco005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcco005
            
            #add-point:AFTER FIELD xcco005 name="input.a.xcco005"
            IF cl_null(g_master.xcco005) THEN LET g_master.xcco005 ='' END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcco005
            #add-point:ON CHANGE xcco005 name="input.g.xcco005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcco001
            
            #add-point:AFTER FIELD xcco001 name="input.a.xcco001"
             IF cl_null(g_master.xcco001) THEN LET g_master.xcco001 ='' END IF 
             LET l_glaa001 = ' '
               CASE g_master.xcco001
                  WHEN '1'
                     SELECT glaa001 INTO l_glaa001
                      FROM glaa_t
                     WHERE glaaent = g_enterprise
                       AND glaald  = g_master.xccold
                  WHEN '2'
                     SELECT glaa016 INTO l_glaa001
                      FROM glaa_t
                     WHERE glaaent = g_enterprise
                       AND glaald  = g_master.xccold
                  WHEN '3'
                     SELECT glaa020 INTO l_glaa001
                      FROM glaa_t
                     WHERE glaaent = g_enterprise
                       AND glaald  = g_master.xccold
               END CASE
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = l_glaa001
               CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_master.xcco001_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_master.xcco001_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcco001
            #add-point:BEFORE FIELD xcco001 name="input.b.xcco001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcco001
            #add-point:ON CHANGE xcco001 name="input.g.xcco001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcco003
            
            #add-point:AFTER FIELD xcco003 name="input.a.xcco003"

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_master.xcco003
            CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_master.xcco003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_master.xcco003_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcco003
            #add-point:BEFORE FIELD xcco003 name="input.b.xcco003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcco003
            #add-point:ON CHANGE xcco003 name="input.g.xcco003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD lbl_chk
            #add-point:BEFORE FIELD lbl_chk name="input.b.lbl_chk"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD lbl_chk
            
            #add-point:AFTER FIELD lbl_chk name="input.a.lbl_chk"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE lbl_chk
            #add-point:ON CHANGE lbl_chk name="input.g.lbl_chk"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.xccocomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccocomp
            #add-point:ON ACTION controlp INFIELD xccocomp name="input.c.xccocomp"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.xccocomp             #給予default值
            LET g_qryparam.default2 = "" #g_master.ooefl003 #說明(簡稱)
            #給予arg
            LET g_qryparam.arg1 = "" #


            CALL q_ooef001_2()                                #呼叫開窗   #161019-00017#11   2016/10/20   By 08734

            LET g_master.xccocomp = g_qryparam.return1              
            #LET g_master.ooefl003 = g_qryparam.return2 
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_master.xccocomp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_master.xccocomp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_master.xccocomp_desc
            
            DISPLAY g_master.xccocomp TO xccocomp              #
            #DISPLAY g_master.ooefl003 TO ooefl003 #說明(簡稱)
            NEXT FIELD xccocomp                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xcco004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcco004
            #add-point:ON ACTION controlp INFIELD xcco004 name="input.c.xcco004"
            
            #END add-point
 
 
         #Ctrlp:input.c.xccold
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccold
            #add-point:ON ACTION controlp INFIELD xccold name="input.c.xccold"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.xccold             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            LET g_qryparam.arg2 = "" #s

            CALL q_authorised_ld()                                #呼叫開窗

            LET g_master.xccold = g_qryparam.return1              

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_master.xccold
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_master.xccold_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_master.xccold_desc
            
            DISPLAY g_master.xccold TO xccold              #

            NEXT FIELD xccold                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xcco005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcco005
            #add-point:ON ACTION controlp INFIELD xcco005 name="input.c.xcco005"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcco001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcco001
            #add-point:ON ACTION controlp INFIELD xcco001 name="input.c.xcco001"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcco003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcco003
            #add-point:ON ACTION controlp INFIELD xcco003 name="input.c.xcco003"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.xcco003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_xcat001()                                #呼叫開窗

            LET g_master.xcco003 = g_qryparam.return1       
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_master.xcco003
            CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_master.xcco003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_master.xcco003_desc
            
            DISPLAY g_master.xcco003 TO xcco003              #

            NEXT FIELD xcco003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.lbl_chk
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD lbl_chk
            #add-point:ON ACTION controlp INFIELD lbl_chk name="input.c.lbl_chk"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON xcco006,imag011,xcbb006,imaa003
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.xcco006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcco006
            #add-point:ON ACTION controlp INFIELD xcco006 name="construct.c.xcco006"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imag001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcco006  #顯示到畫面上
            NEXT FIELD xcco006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcco006
            #add-point:BEFORE FIELD xcco006 name="construct.b.xcco006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcco006
            
            #add-point:AFTER FIELD xcco006 name="construct.a.xcco006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imag011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imag011
            #add-point:ON ACTION controlp INFIELD imag011 name="construct.c.imag011"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imag011()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imag011  #顯示到畫面上
            NEXT FIELD imag011                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imag011
            #add-point:BEFORE FIELD imag011 name="construct.b.imag011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imag011
            
            #add-point:AFTER FIELD imag011 name="construct.a.imag011"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbb006
            #add-point:BEFORE FIELD xcbb006 name="construct.b.xcbb006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbb006
            
            #add-point:AFTER FIELD xcbb006 name="construct.a.xcbb006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcbb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbb006
            #add-point:ON ACTION controlp INFIELD xcbb006 name="construct.c.xcbb006"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imaa003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa003
            #add-point:ON ACTION controlp INFIELD imaa003 name="construct.c.imaa003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa003  #顯示到畫面上
            NEXT FIELD imaa003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa003
            #add-point:BEFORE FIELD imaa003 name="construct.b.imaa003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa003
            
            #add-point:AFTER FIELD imaa003 name="construct.a.imaa003"
            
            #END add-point
            
 
 
 
            
            #add-point:其他管控 name="cs.other"
            
            #end add-point
            
         END CONSTRUCT
 
 
 
      
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
 
         SUBDIALOG lib_cl_schedule.cl_schedule_setting
         SUBDIALOG lib_cl_schedule.cl_schedule_setting_exec_call
         SUBDIALOG lib_cl_schedule.cl_schedule_select_show_history
         SUBDIALOG lib_cl_schedule.cl_schedule_show_history
 
         BEFORE DIALOG
            LET l_dialog = ui.DIALOG.getCurrent()
            CALL cl_qbe_display_condition(FGL_GETENV("QUERYPLANID"), g_user)
            CALL axcr520_get_buffer(l_dialog)
 
         ON ACTION qbe_select
            LET ls_wc = ""
            #需要用ITM類程式查詢方案在CONSTRUCT的功能，將值set到畫面上
            CALL cl_qbe_list("c") RETURNING ls_wc
            CALL axcr520_get_buffer(l_dialog)
            IF NOT cl_null(ls_wc) THEN
               LET g_master.wc = ls_wc
               #取得條件後需要執行項目,應新增於下方adp
               #add-point:ui_dialog段qbe_select後 name="ui_dialog.qbe_select"
               
               #end add-point
            END IF
 
         ON ACTION qbe_save
            CALL cl_qbe_save()
 
         ON ACTION output
            LET g_action_choice = "output"
            ACCEPT DIALOG
 
         ON ACTION quickprint
            LET g_action_choice = "quickprint"
            ACCEPT DIALOG
 
         ON ACTION qbeclear         
            CLEAR FORM
            INITIALIZE g_master.* TO NULL   #畫面變數清空
            INITIALIZE lc_param.* TO NULL   #傳遞參數變數清空
            #add-point:ui_dialog段qbeclear name="ui_dialog.qbeclear"
　　　　　　　INITIALIZE g_master.* TO NULL
            #end add-point
 
         ON ACTION history_fill
            CALL cl_schedule_history_fill()
 
         ON ACTION close
            LET INT_FLAG = TRUE
            EXIT DIALOG
         
         ON ACTION exit
            LET INT_FLAG = TRUE
            EXIT DIALOG
 
         ON ACTION rpt_replang
            CALL cl_gr_set_dlang()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         
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
         CALL axcr520_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
 
     #LET lc_param.wc = g_master.wc    #r類主程式不在意lc_param,不使用轉換
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      
      #end add-point
 
      LET ls_js = util.JSON.stringify(g_master)  #r類使用g_master/p類使用lc_param
 
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
                 CALL axcr520_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = axcr520_transfer_argv(ls_js)
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
         LET gi_hiden_rep_temp = FALSE   #報表樣板設定
         CALL cl_schedule_hidden()
      END IF
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="axcr520.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION axcr520_transfer_argv(ls_js)
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
   #add-point:transfer_agrv段define (客製用) name="transfer_agrv.define_customerization"
   
   #end add-point
 
   LET la_cmdrun.prog = g_prog
   LET la_cmdrun.background = "Y"
   LET la_cmdrun.param[1] = ls_js
 
   #add-point:transfer.argv段程式內容 name="transfer.argv.define"
   
   #end add-point
 
   RETURN util.JSON.stringify( la_cmdrun )
END FUNCTION
 
{</section>}
 
{<section id="axcr520.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION axcr520_process(ls_js)
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_r01_status LIKE type_t.num5
   DEFINE l_token       base.StringTokenizer      #cmdrun使用
   DEFINE ls_next       STRING                    #cmdrun使用
   DEFINE l_cnt         LIKE type_t.num5          #cmdrun使用   
   DEFINE l_arg         DYNAMIC ARRAY OF STRING   ##cmdrun使用的陣列 
   #add-point:process段define name="process.define"
   
   #end add-point
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
 
   INITIALIZE lc_param TO NULL
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_r01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   LET g_rep_wcchp = cl_wcchp(g_master.wc,"xcco006,imag011,xcbb006,imaa003")  #取得列印條件
  
   #add-point:process段前處理 name="process.pre_process"
  
     IF cl_null(g_master.wc) THEN
      LET g_master.wc = " 1=1"
     END IF
      CALL axcr520_x01(g_master.wc,g_master.xccocomp,g_master.xccold,g_master.xcco004,g_master.xcco005,g_master.xcco001,g_master.xcco003,g_master.lbl_chk)

   #end add-point
 
   #預先計算progressbar迴圈次數   #r類不用計算進度條
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE axcr520_process_cs CURSOR FROM ls_sql
#  FOREACH axcr520_process_cs INTO
   #add-point:process段process name="process.process"
   
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" OR g_bgjob = "T" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
      
      #end add-point
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      
      #end add-point
      CALL cl_schedule_exec_call(li_r01_status)
   END IF
END FUNCTION
 
{</section>}
 
{<section id="axcr520.get_buffer" >}
PRIVATE FUNCTION axcr520_get_buffer(p_dialog)
   DEFINE p_dialog   ui.DIALOG
   
   LET g_master.xccocomp = p_dialog.getFieldBuffer('xccocomp')
   LET g_master.xcco004 = p_dialog.getFieldBuffer('xcco004')
   LET g_master.xccold = p_dialog.getFieldBuffer('xccold')
   LET g_master.xcco005 = p_dialog.getFieldBuffer('xcco005')
   LET g_master.xcco001 = p_dialog.getFieldBuffer('xcco001')
   LET g_master.xcco003 = p_dialog.getFieldBuffer('xcco003')
   LET g_master.lbl_chk = p_dialog.getFieldBuffer('lbl_chk')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcr520.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

#end add-point
 
{</section>}
 
