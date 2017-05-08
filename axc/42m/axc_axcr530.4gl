#該程式未解開Section, 採用最新樣板產出!
{<section id="axcr530.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2015-03-11 14:57:08), PR版次:0002(2016-10-20 09:44:28)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000046
#+ Filename...: axcr530
#+ Description: 庫存進出明細成本列印作業
#+ Creator....: 03297(2015-03-10 17:39:30)
#+ Modifier...: 03297 -SD/PR- 08734
 
{</section>}
 
{<section id="axcr530.global" >}
#應用 r01 樣板自動產生(Version:21)
#add-point:填寫註解說明 name="global.memo"
#Memos
#161019-00017#11   2016/10/20   By 08734   调整法人组织开窗由q_ooef001_8为q_ooef001_2
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
       xccccomp LIKE type_t.chr10, 
   xccccomp_desc LIKE type_t.chr80, 
   xccc004 LIKE type_t.num5, 
   xcccld LIKE type_t.chr5, 
   xcccld_desc LIKE type_t.chr80, 
   xccc005 LIKE type_t.num5, 
   xccc001 LIKE type_t.chr1, 
   xccc001_desc LIKE type_t.chr80, 
   xccc003 LIKE type_t.chr10, 
   xccc003_desc LIKE type_t.chr80, 
   xccc006 LIKE type_t.chr500, 
   xccc006_desc LIKE type_t.chr80, 
   imaa003 LIKE type_t.chr10, 
   imaa003_desc LIKE type_t.chr80, 
   xcccc006_desc_desc LIKE type_t.chr80, 
   imag011 LIKE type_t.chr10, 
   imag011_desc LIKE type_t.chr80, 
   xcbb006 LIKE type_t.num5, 
   a LIKE type_t.chr500, 
   b LIKE type_t.chr500,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axcr530.main" >}
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
      CALL axcr530_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcr530 WITH FORM cl_ap_formpath("axc",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL axcr530_init()
 
      #進入選單 Menu (="N")
      CALL axcr530_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_axcr530
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="axcr530.init" >}
#+ 初始化作業
PRIVATE FUNCTION axcr530_init()
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
   CALL cl_set_combo_scc("xccc001",'8914')
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axcr530.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axcr530_ui_dialog()
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_glaa001  LIKE glaa_t.glaa001
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
         INPUT BY NAME g_master.xccccomp,g_master.xccc004,g_master.xcccld,g_master.xccc005,g_master.xccc001, 
             g_master.xccc003,g_master.a,g_master.b 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               #预设当前site的法人，主账套，年度期别，成本计算类型
               CALL s_axc_set_site_default() RETURNING g_master.xccccomp,g_master.xcccld,g_master.xccc004,g_master.xccc005,g_master.xccc003
               LET g_master.xccc001 = '1'
               LET g_master.a = 'Y'
               LET g_master.b = 'N'
               
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_master.xccccomp
               CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_master.xccccomp_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_master.xccccomp_desc
               
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_master.xcccld
               CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_master.xcccld_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_master.xcccld_desc
               
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_master.xccc003
               CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_master.xccc003_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_master.xccc003_desc
            
               LET l_glaa001 = ' '
               CASE g_master.xccc001
                  WHEN '1'
                     SELECT glaa001 INTO l_glaa001
                      FROM glaa_t
                     WHERE glaaent = g_enterprise
                       AND glaald  = g_master.xcccld
                  WHEN '2'
                     SELECT glaa016 INTO l_glaa001
                      FROM glaa_t
                     WHERE glaaent = g_enterprise
                       AND glaald  = g_master.xcccld
                  WHEN '3'
                     SELECT glaa020 INTO l_glaa001
                      FROM glaa_t
                     WHERE glaaent = g_enterprise
                       AND glaald  = g_master.xcccld
               END CASE
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = l_glaa001
               CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_master.xccc001_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_master.xccc001_desc
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccccomp
            
            #add-point:AFTER FIELD xccccomp name="input.a.xccccomp"
            IF cl_null(g_master.xccccomp) THEN LET g_master.xccccomp ='' END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_master.xccccomp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_master.xccccomp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_master.xccccomp_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccccomp
            #add-point:BEFORE FIELD xccccomp name="input.b.xccccomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccccomp
            #add-point:ON CHANGE xccccomp name="input.g.xccccomp"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc004
            #add-point:BEFORE FIELD xccc004 name="input.b.xccc004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc004
            
            #add-point:AFTER FIELD xccc004 name="input.a.xccc004"
            IF cl_null(g_master.xccc004) THEN LET g_master.xccc004 ='' END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc004
            #add-point:ON CHANGE xccc004 name="input.g.xccc004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcccld
            
            #add-point:AFTER FIELD xcccld name="input.a.xcccld"
            IF cl_null(g_master.xcccld) THEN LET g_master.xcccld ='' END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_master.xcccld
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_master.xcccld_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_master.xcccld_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcccld
            #add-point:BEFORE FIELD xcccld name="input.b.xcccld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcccld
            #add-point:ON CHANGE xcccld name="input.g.xcccld"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc005
            #add-point:BEFORE FIELD xccc005 name="input.b.xccc005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc005
            
            #add-point:AFTER FIELD xccc005 name="input.a.xccc005"
            IF cl_null(g_master.xccc005) THEN LET g_master.xccc005 ='' END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc005
            #add-point:ON CHANGE xccc005 name="input.g.xccc005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc001
            
            #add-point:AFTER FIELD xccc001 name="input.a.xccc001"
            IF cl_null(g_master.xccc001) THEN LET g_master.xccc001 ='' END IF 
            LET l_glaa001 = ' '
            CASE g_master.xccc001
               WHEN '1'
                  SELECT glaa001 INTO l_glaa001
                   FROM glaa_t
                  WHERE glaaent = g_enterprise
                    AND glaald  = g_master.xcccld
               WHEN '2'
                  SELECT glaa016 INTO l_glaa001
                   FROM glaa_t
                  WHERE glaaent = g_enterprise
                    AND glaald  = g_master.xcccld
               WHEN '3'
                  SELECT glaa020 INTO l_glaa001
                   FROM glaa_t
                  WHERE glaaent = g_enterprise
                    AND glaald  = g_master.xcccld
            END CASE
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = l_glaa001
            CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_master.xccc001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_master.xccc001_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc001
            #add-point:BEFORE FIELD xccc001 name="input.b.xccc001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc001
            #add-point:ON CHANGE xccc001 name="input.g.xccc001"
 
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc003
            
            #add-point:AFTER FIELD xccc003 name="input.a.xccc003"
            IF cl_null(g_master.xccc003) THEN LET g_master.xccc003 ='' END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_master.xccc003
            CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_master.xccc003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_master.xccc003_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc003
            #add-point:BEFORE FIELD xccc003 name="input.b.xccc003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc003
            #add-point:ON CHANGE xccc003 name="input.g.xccc003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD a
            #add-point:BEFORE FIELD a name="input.b.a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD a
            
            #add-point:AFTER FIELD a name="input.a.a"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE a
            #add-point:ON CHANGE a name="input.g.a"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b
            #add-point:BEFORE FIELD b name="input.b.b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b
            
            #add-point:AFTER FIELD b name="input.a.b"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE b
            #add-point:ON CHANGE b name="input.g.b"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.xccccomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccccomp
            #add-point:ON ACTION controlp INFIELD xccccomp name="input.c.xccccomp"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.xccccomp             #給予default值

#            #給予arg
#            IF NOT cl_null(g_master.xcccld) THEN
#               LET g_qryparam.where = " ooef017 = (SELECT glaacomp FROM glaa_t ",
#                                      "  WHERE glaaent = '",g_enterprise,"' AND glaald = '",g_master.xcccld,"' )"
#            END IF



            CALL q_ooef001_2()                                #呼叫開窗   #161019-00017#11   2016/10/20   By 08734

            LET g_master.xccccomp = g_qryparam.return1  

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_master.xccccomp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_master.xccccomp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_master.xccccomp_desc

            DISPLAY g_master.xccccomp TO xccccomp              #

            NEXT FIELD xccccomp                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xccc004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc004
            #add-point:ON ACTION controlp INFIELD xccc004 name="input.c.xccc004"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcccld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcccld
            #add-point:ON ACTION controlp INFIELD xcccld name="input.c.xcccld"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.xcccld             #給予default值

#            #給予arg
#            LET g_qryparam.arg1 = g_user
#            LET g_qryparam.arg2 = g_dept
#            
#            #法人不為空時，帳套開窗開此法人的下屬帳套
#            IF NOT cl_null(g_master.xccccomp) THEN
#               LET g_qryparam.where = " glaacomp = '",g_master.xccccomp,"'"
#            END IF

            CALL q_authorised_ld()                                #呼叫開窗

            LET g_master.xcccld = g_qryparam.return1  
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_master.xcccld
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_master.xcccld_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_master.xcccld_desc            

            DISPLAY g_master.xcccld TO xcccld              #

            NEXT FIELD xcccld                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xccc005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc005
            #add-point:ON ACTION controlp INFIELD xccc005 name="input.c.xccc005"
            
            #END add-point
 
 
         #Ctrlp:input.c.xccc001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc001
            #add-point:ON ACTION controlp INFIELD xccc001 name="input.c.xccc001"
            
            #END add-point
 
 
         #Ctrlp:input.c.xccc003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc003
            #add-point:ON ACTION controlp INFIELD xccc003 name="input.c.xccc003"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.xccc003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_xcat001()                                #呼叫開窗

            LET g_master.xccc003 = g_qryparam.return1              

            DISPLAY g_master.xccc003 TO xccc003              #
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_master.xccc003
            CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_master.xccc003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_master.xccc003_desc


            NEXT FIELD xccc003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD a
            #add-point:ON ACTION controlp INFIELD a name="input.c.a"
            
            #END add-point
 
 
         #Ctrlp:input.c.b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b
            #add-point:ON ACTION controlp INFIELD b name="input.c.b"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               IF cl_null(g_master.xcccld) THEN LET g_master.xcccld ='' END IF
               IF cl_null(g_master.xccccomp) THEN LET g_master.xccccomp ='' END IF   
               IF cl_null(g_master.xccc001) THEN LET g_master.xccc001 ='' END IF   
               IF cl_null(g_master.xccc003) THEN LET g_master.xccc003 ='' END IF   
               IF cl_null(g_master.xccc004) THEN LET g_master.xccc004 ='' END IF   
               IF cl_null(g_master.xccc005) THEN LET g_master.xccc005 ='' END IF
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON xccc006,imaa003,imag011,xcbb006
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc006
            #add-point:BEFORE FIELD xccc006 name="construct.b.xccc006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc006
            
            #add-point:AFTER FIELD xccc006 name="construct.a.xccc006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xccc006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc006
            #add-point:ON ACTION controlp INFIELD xccc006 name="construct.c.xccc006"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccc006  #顯示到畫面上
            

         
            NEXT FIELD xccc006

            
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
            CALL q_imca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa003  #顯示到畫面上
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_master.imaa003
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='200' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_master.imaa003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_master.imaa003_desc
            
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
            
 
 
         #Ctrlp:construct.c.imag011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imag011
            #add-point:ON ACTION controlp INFIELD imag011 name="construct.c.imag011"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imag011_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imag011  #顯示到畫面上
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_master.imag011
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='200' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_master.imag011_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_master.imag011_desc
            
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
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD a
            #add-point:BEFORE FIELD a name="construct.b.a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD a
            
            #add-point:AFTER FIELD a name="construct.a.a"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD a
            #add-point:ON ACTION controlp INFIELD a name="construct.c.a"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b
            #add-point:BEFORE FIELD b name="construct.b.b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b
            
            #add-point:AFTER FIELD b name="construct.a.b"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b
            #add-point:ON ACTION controlp INFIELD b name="construct.c.b"
            
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
            CALL axcr530_get_buffer(l_dialog)
 
         ON ACTION qbe_select
            LET ls_wc = ""
            #需要用ITM類程式查詢方案在CONSTRUCT的功能，將值set到畫面上
            CALL cl_qbe_list("c") RETURNING ls_wc
            CALL axcr530_get_buffer(l_dialog)
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
         CALL axcr530_init()
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
                 CALL axcr530_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = axcr530_transfer_argv(ls_js)
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
 
{<section id="axcr530.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION axcr530_transfer_argv(ls_js)
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
 
{<section id="axcr530.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION axcr530_process(ls_js)
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
 
   LET g_rep_wcchp = cl_wcchp(g_master.wc,"xccc006,imaa003,imag011,xcbb006")  #取得列印條件
  
   #add-point:process段前處理 name="process.pre_process"
  IF cl_null(g_master.wc) THEN
      LET g_master.wc = " 1=1"
   END IF

   LET g_master.wc = g_master.wc CLIPPED,
                    " AND xcccent  = ",g_enterprise


   CALL axcr530_x01(g_master.wc,g_master.xccccomp,g_master.xcccld,g_master.xccc004,g_master.xccc005,g_master.xccc001,g_master.xccc003,g_master.a,g_master.b)
   #end add-point
 
   #預先計算progressbar迴圈次數   #r類不用計算進度條
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE axcr530_process_cs CURSOR FROM ls_sql
#  FOREACH axcr530_process_cs INTO
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
 
{<section id="axcr530.get_buffer" >}
PRIVATE FUNCTION axcr530_get_buffer(p_dialog)
   DEFINE p_dialog   ui.DIALOG
   
   LET g_master.xccccomp = p_dialog.getFieldBuffer('xccccomp')
   LET g_master.xccc004 = p_dialog.getFieldBuffer('xccc004')
   LET g_master.xcccld = p_dialog.getFieldBuffer('xcccld')
   LET g_master.xccc005 = p_dialog.getFieldBuffer('xccc005')
   LET g_master.xccc001 = p_dialog.getFieldBuffer('xccc001')
   LET g_master.xccc003 = p_dialog.getFieldBuffer('xccc003')
   LET g_master.a = p_dialog.getFieldBuffer('a')
   LET g_master.b = p_dialog.getFieldBuffer('b')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
 
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcr530.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

#end add-point
 
{</section>}
 
