#該程式未解開Section, 採用最新樣板產出!
{<section id="axcp801.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-12-01 20:20:46), PR版次:0001(2017-01-13 11:28:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: axcp801
#+ Description: LCM料件評價單價計算作業
#+ Creator....: 02040(2016-11-22 14:56:15)
#+ Modifier...: 02040 -SD/PR- 02040
 
{</section>}
 
{<section id="axcp801.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#Memos
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
   
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       xccccomp LIKE xccc_t.xccccomp, 
   xcccld_desc LIKE type_t.chr80, 
   xcccld LIKE xccc_t.xcccld, 
   xccccomp_desc LIKE type_t.chr80, 
   xccc004 LIKE xccc_t.xccc004, 
   xccc005 LIKE xccc_t.xccc005, 
   xccc003 LIKE xccc_t.xccc003, 
   xccc003_desc LIKE type_t.chr80, 
   xccc001 LIKE xccc_t.xccc001, 
   xccc006 LIKE xccc_t.xccc006, 
   xccc002 LIKE xccc_t.xccc002, 
   xccc007 LIKE xccc_t.xccc007, 
   xccc008 LIKE xccc_t.xccc008, 
   imaf011 LIKE imaf_t.imaf011, 
   imaf111 LIKE imaf_t.imaf111, 
   imaf051 LIKE imaf_t.imaf051, 
   imag011 LIKE imag_t.imag011, 
   bdate LIKE type_t.dat, 
   edate LIKE type_t.dat, 
   bdate2 LIKE type_t.dat, 
   ware_nor LIKE type_t.chr500, 
   ware_muti LIKE type_t.chr500, 
   ware_oth LIKE type_t.chr500, 
   xcfa006 LIKE xcfa_t.xcfa006, 
   xcfa007 LIKE xcfa_t.xcfa007, 
   xcfa008 LIKE xcfa_t.xcfa008, 
   xcfa009 LIKE xcfa_t.xcfa009, 
   xcfa012 LIKE type_t.chr500, 
   xcfa005 LIKE xcfa_t.xcfa005, 
   xcfa011 LIKE xcfa_t.xcfa011, 
   xcfa013_1 LIKE type_t.chr500, 
   xcfa013_2 LIKE type_t.chr500, 
   xcfa013_3 LIKE type_t.chr500, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_ref_fields    DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars      DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields    DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_progress_msg  STRING
DEFINE g_round_type         LIKE ooaa_t.ooaa002                #金额舍入类型
DEFINE g_curr  RECORD
            curr     LIKE glaa_t.glaa001,      #本位币1
            digit1   LIKE type_t.num5,         #单价小数位数
            digit2   LIKE type_t.num5          #金额小数位数
   END RECORD
DEFINE g_xcfa013   LIKE xcfa_t.xcfa013
DEFINE g_glaa025   LIKE glaa_t.glaa025
DEFINE g_xcfi006   LIKE xcfi_t.xcfi006  #料件
DEFINE g_xcfi007   LIKE xcfi_t.xcfi007  #特性
DEFINE g_xcfi008   LIKE xcfi_t.xcfi008  #批號
DEFINE g_glaa003   LIKE glaa_t.glaa003   #會計週期參照表
DEFINE g_glaa001   LIKE glaa_t.glaa001
DEFINE g_glaa016   LIKE glaa_t.glaa016
DEFINE g_glaa020   LIKE glaa_t.glaa020
DEFINE g_glaa026   LIKE glaa_t.glaa026   #幣種 
DEFINE g_master_o  type_master
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axcp801.main" >}
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
   CALL cl_ap_init("axc","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL axcp801_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcp801 WITH FORM cl_ap_formpath("axc",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL axcp801_init()
 
      #進入選單 Menu (="N")
      CALL axcp801_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_axcp801
   END IF
 
   #add-point:作業離開前 name="main.exit"
   CALL axcp801_drop_tmp_table()
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="axcp801.init" >}
#+ 初始化作業
PRIVATE FUNCTION axcp801_init()
 
   #add-point:init段define (客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:ui_dialog段define name="init.define"
   DEFINE l_success LIKE type_t.num5
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
   CALL cl_set_combo_scc("xccc001","8914")
   CALL cl_set_combo_scc("xcfa006","8038")
   CALL cl_set_combo_scc("xcfa007","8039")
   CALL cl_set_combo_scc("xcfa008","8040")
   CALL cl_set_combo_scc("xcfa009","8038")
   CALL cl_set_combo_scc('xcfa013_1','8041')
   CALL cl_set_combo_scc('xcfa013_2','8041')
   CALL cl_set_combo_scc('xcfa013_3','8041') 
   #取企业参数设置-金额舍入类型
   LET g_round_type = cl_get_para(g_enterprise,'','E-COM-0006')
   CALL axcp801_create_tmp_table() RETURNING l_success   
   CALL axcp801_default_wc()
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axcp801.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axcp801_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
 
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.xccccomp,g_master.xcccld,g_master.xccc004,g_master.xccc005,g_master.xccc003, 
             g_master.xccc001,g_master.bdate,g_master.edate,g_master.bdate2,g_master.ware_nor,g_master.ware_muti, 
             g_master.ware_oth 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               LET g_master_o.* = g_master.*
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccccomp
            
            #add-point:AFTER FIELD xccccomp name="input.a.xccccomp"
            #法人
            IF NOT cl_null(g_master.xccccomp) THEN 
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_master.xccccomp
               IF cl_chk_exist("v_ooef001_1") THEN
               ELSE
                  LET g_master.xccccomp = g_master_o.xccccomp
                  NEXT FIELD CURRENT
               END IF

               LET g_master_o.xccccomp = g_master.xccccomp               
            END IF 
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
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcccld
            
            #add-point:AFTER FIELD xcccld name="input.a.xcccld"
            #賬套
            IF NOT cl_null(g_master.xcccld) THEN                
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_master.xcccld
               IF cl_chk_exist("v_glaald") THEN
               ELSE
                  LET g_master.xcccld = g_master_o.xcccld
                  NEXT FIELD CURRENT
               END IF
               LET g_master_o.xcccld = g_master.xcccld               
            END IF

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
         BEFORE FIELD xccc004
            #add-point:BEFORE FIELD xccc004 name="input.b.xccc004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc004
            
            #add-point:AFTER FIELD xccc004 name="input.a.xccc004"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc004
            #add-point:ON CHANGE xccc004 name="input.g.xccc004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc005
            #add-point:BEFORE FIELD xccc005 name="input.b.xccc005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc005
            
            #add-point:AFTER FIELD xccc005 name="input.a.xccc005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc005
            #add-point:ON CHANGE xccc005 name="input.g.xccc005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc003
            
            #add-point:AFTER FIELD xccc003 name="input.a.xccc003"
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
         BEFORE FIELD xccc001
            #add-point:BEFORE FIELD xccc001 name="input.b.xccc001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc001
            
            #add-point:AFTER FIELD xccc001 name="input.a.xccc001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc001
            #add-point:ON CHANGE xccc001 name="input.g.xccc001"
            SELECT glaa001,glaa016,glaa020,glaa026
              INTO g_glaa001,g_glaa016,g_glaa020,g_glaa026
              FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaald  = g_master.xcccld
            
            CASE g_master.xccc001    
              WHEN '1'
                LET g_curr.curr = g_glaa001
              WHEN '2'
                LET g_curr.curr = g_glaa016
              WHEN '3'
                LET g_curr.curr = g_glaa020
            END CASE
             
            SELECT ooaj006,ooaj007 
              INTO g_curr.digit1,g_curr.digit2 
              FROM ooaj_t
             WHERE ooajent = g_enterprise
               AND ooaj001 = g_glaa026
               AND ooaj002 = g_curr.curr 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bdate
            #add-point:BEFORE FIELD bdate name="input.b.bdate"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bdate
            
            #add-point:AFTER FIELD bdate name="input.a.bdate"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bdate
            #add-point:ON CHANGE bdate name="input.g.bdate"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD edate
            #add-point:BEFORE FIELD edate name="input.b.edate"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD edate
            
            #add-point:AFTER FIELD edate name="input.a.edate"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE edate
            #add-point:ON CHANGE edate name="input.g.edate"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bdate2
            #add-point:BEFORE FIELD bdate2 name="input.b.bdate2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bdate2
            
            #add-point:AFTER FIELD bdate2 name="input.a.bdate2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bdate2
            #add-point:ON CHANGE bdate2 name="input.g.bdate2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ware_nor
            #add-point:BEFORE FIELD ware_nor name="input.b.ware_nor"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ware_nor
            
            #add-point:AFTER FIELD ware_nor name="input.a.ware_nor"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ware_nor
            #add-point:ON CHANGE ware_nor name="input.g.ware_nor"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ware_muti
            #add-point:BEFORE FIELD ware_muti name="input.b.ware_muti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ware_muti
            
            #add-point:AFTER FIELD ware_muti name="input.a.ware_muti"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ware_muti
            #add-point:ON CHANGE ware_muti name="input.g.ware_muti"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ware_oth
            #add-point:BEFORE FIELD ware_oth name="input.b.ware_oth"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ware_oth
            
            #add-point:AFTER FIELD ware_oth name="input.a.ware_oth"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ware_oth
            #add-point:ON CHANGE ware_oth name="input.g.ware_oth"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.xccccomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccccomp
            #add-point:ON ACTION controlp INFIELD xccccomp name="input.c.xccccomp"
            #帳套
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.xccccomp
            IF NOT cl_null(g_master.xcccld) THEN
               LET g_qryparam.arg1 = g_master.xcccld
               CALL q_glaacomp()
            ELSE 
               CALL q_ooef001_2()
            END IF
            LET g_master.xccccomp = g_qryparam.return1              
            DISPLAY g_master.xccccomp TO xccccomp
            NEXT FIELD xccccomp
            #END add-point
 
 
         #Ctrlp:input.c.xcccld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcccld
            #add-point:ON ACTION controlp INFIELD xcccld name="input.c.xcccld"
            #法人
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.xcccld             #給予default值
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            CALL q_authorised_ld()
            LET g_master.xcccld = g_qryparam.return1
            DISPLAY g_master.xcccld TO xcccld
            NEXT FIELD xcccld
            #END add-point
 
 
         #Ctrlp:input.c.xccc004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc004
            #add-point:ON ACTION controlp INFIELD xccc004 name="input.c.xccc004"
            
            #END add-point
 
 
         #Ctrlp:input.c.xccc005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc005
            #add-point:ON ACTION controlp INFIELD xccc005 name="input.c.xccc005"
            
            #END add-point
 
 
         #Ctrlp:input.c.xccc003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc003
            #add-point:ON ACTION controlp INFIELD xccc003 name="input.c.xccc003"
            #成本計算類型
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.xccc003
            CALL q_xcat001()
            LET g_master.xccc003 = g_qryparam.return1
            DISPLAY g_master.xccc003 TO xccc003
            NEXT FIELD xccc003
            #END add-point
 
 
         #Ctrlp:input.c.xccc001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc001
            #add-point:ON ACTION controlp INFIELD xccc001 name="input.c.xccc001"
            
            #END add-point
 
 
         #Ctrlp:input.c.bdate
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bdate
            #add-point:ON ACTION controlp INFIELD bdate name="input.c.bdate"
            
            #END add-point
 
 
         #Ctrlp:input.c.edate
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD edate
            #add-point:ON ACTION controlp INFIELD edate name="input.c.edate"
            
            #END add-point
 
 
         #Ctrlp:input.c.bdate2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bdate2
            #add-point:ON ACTION controlp INFIELD bdate2 name="input.c.bdate2"
            
            #END add-point
 
 
         #Ctrlp:input.c.ware_nor
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ware_nor
            #add-point:ON ACTION controlp INFIELD ware_nor name="input.c.ware_nor"
            
            #END add-point
 
 
         #Ctrlp:input.c.ware_muti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ware_muti
            #add-point:ON ACTION controlp INFIELD ware_muti name="input.c.ware_muti"
            
            #END add-point
 
 
         #Ctrlp:input.c.ware_oth
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ware_oth
            #add-point:ON ACTION controlp INFIELD ware_oth name="input.c.ware_oth"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON xccc006,xccc002,xccc007,xccc008,imaf011,imaf111,imaf051,imag011 
 
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
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc006
            #add-point:ON ACTION controlp INFIELD xccc006 name="construct.c.xccc006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc002
            #add-point:BEFORE FIELD xccc002 name="construct.b.xccc002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc002
            
            #add-point:AFTER FIELD xccc002 name="construct.a.xccc002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xccc002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc002
            #add-point:ON ACTION controlp INFIELD xccc002 name="construct.c.xccc002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc007
            #add-point:BEFORE FIELD xccc007 name="construct.b.xccc007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc007
            
            #add-point:AFTER FIELD xccc007 name="construct.a.xccc007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xccc007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc007
            #add-point:ON ACTION controlp INFIELD xccc007 name="construct.c.xccc007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc008
            #add-point:BEFORE FIELD xccc008 name="construct.b.xccc008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc008
            
            #add-point:AFTER FIELD xccc008 name="construct.a.xccc008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xccc008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc008
            #add-point:ON ACTION controlp INFIELD xccc008 name="construct.c.xccc008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf011
            #add-point:BEFORE FIELD imaf011 name="construct.b.imaf011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf011
            
            #add-point:AFTER FIELD imaf011 name="construct.a.imaf011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaf011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf011
            #add-point:ON ACTION controlp INFIELD imaf011 name="construct.c.imaf011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf111
            #add-point:BEFORE FIELD imaf111 name="construct.b.imaf111"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf111
            
            #add-point:AFTER FIELD imaf111 name="construct.a.imaf111"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaf111
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf111
            #add-point:ON ACTION controlp INFIELD imaf111 name="construct.c.imaf111"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf051
            #add-point:BEFORE FIELD imaf051 name="construct.b.imaf051"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf051
            
            #add-point:AFTER FIELD imaf051 name="construct.a.imaf051"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaf051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf051
            #add-point:ON ACTION controlp INFIELD imaf051 name="construct.c.imaf051"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imag011
            #add-point:BEFORE FIELD imag011 name="construct.b.imag011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imag011
            
            #add-point:AFTER FIELD imag011 name="construct.a.imag011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imag011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imag011
            #add-point:ON ACTION controlp INFIELD imag011 name="construct.c.imag011"
            
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
            CALL axcp801_get_buffer(l_dialog)
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
         CALL axcp801_init()
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
                 CALL axcp801_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = axcp801_transfer_argv(ls_js)
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
 
{<section id="axcp801.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION axcp801_transfer_argv(ls_js)
 
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
 
{<section id="axcp801.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION axcp801_process(ls_js)
 
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
   SELECT glaa025  INTO g_glaa025
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = g_master.xcccld
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      #若是原料評價為'1'採購進價,只有16个步骤；'2'逆推成品價有19個步骤
      IF g_master.xcfa007 = '1' THEN
         LET li_count = 16
      ELSE
         LET li_count = 19
      END IF      
      CALL cl_progress_bar_no_window(li_count)
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE axcp801_process_cs CURSOR FROM ls_sql
#  FOREACH axcp801_process_cs INTO
   #add-point:process段process name="process.process"
   
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
      #抓取淨變現參數設定狀況
      IF NOT axcp801_get_xcfa() THEN
         RETURN
      END IF
      IF g_master.ware_nor = 'N' AND g_master.ware_muti = 'N' AND g_master.ware_oth = 'N' THEN
         #入庫範圍至少勾選一項！
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axc-00818'
         LET g_errparam.extend = ""
         LET g_errparam.popup = TRUE
         CALL cl_err()    
         RETURN
      END IF
      #错误收集
      CALL cl_err_collect_init()
      IF NOT axcp801_ins_tmp() THEN
         CALL cl_err_collect_show()
         RETURN
      END IF
      IF NOT axcp801_upd_xcfg() THEN
         CALL cl_err_collect_show()
         RETURN      
      END IF
      #LCM在制處理
      IF NOT axcp801_ins_xcfn() THEN
         CALL cl_err_collect_show()
         RETURN      
      END IF      
      #寫入實體TABLE
      CALL s_transaction_begin()
      IF axcp801_ins_table() THEN
         CALL s_transaction_end('Y',0)
      ELSE
         CALL s_transaction_end('N',0)      
      END IF
      LET g_progress_msg = ''      
      CALL cl_progress_no_window_ing(g_progress_msg)      
      CALL cl_err_collect_show()   
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
 
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL axcp801_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="axcp801.get_buffer" >}
PRIVATE FUNCTION axcp801_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.xccccomp = p_dialog.getFieldBuffer('xccccomp')
   LET g_master.xcccld = p_dialog.getFieldBuffer('xcccld')
   LET g_master.xccc004 = p_dialog.getFieldBuffer('xccc004')
   LET g_master.xccc005 = p_dialog.getFieldBuffer('xccc005')
   LET g_master.xccc003 = p_dialog.getFieldBuffer('xccc003')
   LET g_master.xccc001 = p_dialog.getFieldBuffer('xccc001')
   LET g_master.bdate = p_dialog.getFieldBuffer('bdate')
   LET g_master.edate = p_dialog.getFieldBuffer('edate')
   LET g_master.bdate2 = p_dialog.getFieldBuffer('bdate2')
   LET g_master.ware_nor = p_dialog.getFieldBuffer('ware_nor')
   LET g_master.ware_muti = p_dialog.getFieldBuffer('ware_muti')
   LET g_master.ware_oth = p_dialog.getFieldBuffer('ware_oth')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcp801.msgcentre_notify" >}
PRIVATE FUNCTION axcp801_msgcentre_notify()
 
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
 
{<section id="axcp801.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 條件預設
# Memo...........:
# Usage..........: CALL axcp801_default_wc()
#                  RETURNING 
# Input parameter: 
# Return code....: 
# Date & Author..: #161108-00037#1 By 02040
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp801_default_wc()
DEFINE l_xccc004   LIKE xccc_t.xccc004
DEFINE l_xccc005   LIKE xccc_t.xccc005
DEFINE l_success   LIKE type_t.num5
   
   CLEAR FORM
   CALL s_axc_set_site_default() 
     RETURNING g_master.xccccomp,g_master.xcccld,g_master.xccc004,g_master.xccc005,g_master.xccc003
   
   
   
   LET g_master.xccc001  = '1'                  #本位幣  

   CALL axcp801_get_xcfa() RETURNING l_success 

   #計算異動起始日期g_master.bdate
   #若淨變現單價 = 1.最高 or 2.最低 ==>預設 年度+期別 - 1年又6個月 的當月1號
   #若淨變現單價 = 3.平均值 ==>        預設 年度+期別 - 2個月 的當月1號 
   LET l_xccc004 = ''
   LET l_xccc005 = ''   
   IF g_master.xcfa008 MATCHES '[12]' THEN
      IF g_master.xccc005 > 6 THEN
         LET l_xccc004 = g_master.xccc004 - 1
         LET l_xccc005 = g_master.xccc005 - 6
      ELSE
         LET l_xccc004 = g_master.xccc004 - 2
         LET l_xccc005 = 12 - 6 + g_master.xccc005      
      END IF       
   ELSE
      IF g_master.xccc005 > 2 THEN
         LET l_xccc004 = g_master.xccc004 
         LET l_xccc005 = g_master.xccc005 - 2
      ELSE
         LET l_xccc004 = g_master.xccc004 - 1
         LET l_xccc005 = 12 - 2 + g_master.xccc005     
      END IF       
   END IF
   SELECT MIN(glav004) INTO g_master.bdate      
     FROM glav_t  
    WHERE glavent = g_enterprise     
      AND glav001 = g_glaa003
      AND glav002 = l_xccc004 
      AND glav006 = l_xccc005
   #成品異動起始日期g_master.bdate2
   LET l_xccc004 = ''
   LET l_xccc005 = ''   
   IF g_master.xccc005 > 2 THEN
      LET l_xccc004 = g_master.xccc004 
      LET l_xccc005 = g_master.xccc005 - 2
   ELSE
      LET l_xccc004 = g_master.xccc004 - 1
      LET l_xccc005 = 12 - 2 + g_master.xccc005     
   END IF  
   SELECT MIN(glav004) INTO g_master.bdate2      
     FROM glav_t  
    WHERE glavent = g_enterprise     
      AND glav001 = g_glaa003
      AND glav002 = l_xccc004 
      AND glav006 = l_xccc005

   LET g_master.ware_nor = 'Y'
   LET g_master.ware_muti= 'N'
   LET g_master.ware_oth = 'N'   
   
   CALL s_desc_get_ld_desc(g_master.xcccld) RETURNING g_master.xcccld_desc
   CALL s_desc_get_department_desc(g_master.xccccomp) RETURNING g_master.xccccomp_desc
   DISPLAY BY NAME g_master.xcfa005,g_master.xcfa006,g_master.xcfa007,g_master.xcfa008,g_master.xcfa009,
                   g_master.xcfa011,g_master.xcfa012,g_master.xcfa013_1,g_master.xcfa013_2,g_master.xcfa013_3
   DISPLAY BY NAME g_master.xcccld_desc,g_master.xccccomp_desc
   
END FUNCTION

################################################################################
# Descriptions...: 抓取淨變現參數設定狀況
# Memo...........:
# Usage..........: CALL axcp801_get_xcfa()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success      TRUE/FALSE
# Date & Author..: #161108-00037#1 By 02040
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp801_get_xcfa()
DEFINE l_xcfa013_1 STRING
DEFINE l_xccc004   LIKE xccc_t.xccc004
DEFINE l_xccc005   LIKE xccc_t.xccc005
DEFINE r_success LIKE type_t.num5
  
   LET r_success = TRUE
   
   SELECT glaa001,glaa016,glaa020,glaa026,glaa003
     INTO g_glaa001,g_glaa016,g_glaa020,g_glaa026,g_glaa003
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_master.xcccld
   CASE g_master.xccc001    
     WHEN '1'
       LET g_curr.curr = g_glaa001
     WHEN '2'
       LET g_curr.curr = g_glaa016
     WHEN '3'
       LET g_curr.curr = g_glaa020
   END CASE
   SELECT ooaj006,ooaj007 
     INTO g_curr.digit1,g_curr.digit2 
     FROM ooaj_t
    WHERE ooajent = g_enterprise
      AND ooaj001 = g_glaa026
      AND ooaj002 = g_curr.curr    

   SELECT xcfa005,xcfa006,xcfa007,xcfa008,xcfa009,
          xcfa011,xcfa012,xcfa013
     INTO g_master.xcfa005,g_master.xcfa006,g_master.xcfa007,g_master.xcfa008,g_master.xcfa009,
          g_master.xcfa011,g_master.xcfa012,g_xcfa013
     FROM xcfa_t
    WHERE xcfaent = g_enterprise
      AND xcfald = g_master.xcccld
      AND xcfa001 = g_master.xccc004
      AND xcfa002 = g_master.xccc005
   IF SQLCA.sqlcode = 100 THEN
      #無符合LCM淨變現參數基礎設定，請確認！請至[LCM計算基礎設定作業 AXCI801]查看!
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axc-00817'
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()    
      LET r_success = FALSE
      RETURN r_success
   END IF
   LET l_xcfa013_1 = g_xcfa013   
   LET g_master.xcfa013_1 = l_xcfa013_1.subString(1,1)  
   LET g_master.xcfa013_2 = l_xcfa013_1.subString(2,2)  
   LET g_master.xcfa013_3 = l_xcfa013_1.subString(3,3) 
   #計算異動截止日期g_master.edate
   SELECT MAX(glav004) INTO g_master.edate      
     FROM glav_t  
    WHERE glavent = g_enterprise     
      AND glav001 = g_glaa003
      AND glav002 = g_master.xccc004
      AND glav006 = g_master.xccc005  
   
   RETURN r_success   


END FUNCTION

################################################################################
# Descriptions...: INS TMP
# Memo...........:
# Usage..........: CALL axcp801_ins_tmp()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success  TRUE/FALSE
# Date & Author..: #161108-00037#1 By 02040
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp801_ins_tmp()
   DEFINE r_success LIKE type_t.num5
   DEFINE l_sql     STRING
   DEFINE l_where   STRING
   DEFINE l_inat001 LIKE inat_t.inat001
   DEFINE l_inat007 LIKE inat_t.inat007
   DEFINE l_imag014 LIKE imag_t.imag014 
   DEFINE l_rate    LIKE inaj_t.inaj014  #单位换算率
   DEFINE l_success LIKE type_t.num5   
   DEFINE l_cnt     LIKE type_t.num5
   
      LET r_success = TRUE

      DELETE FROM xcfg_tmp;
      DELETE FROM xcfh_tmp;
      DELETE FROM xcfi_tmp;
      DELETE FROM xcfn_tmp;
      DELETE FROM xccc_tmp;
      DELETE FROM inat_tmp;      

      LET l_sql =  " INSERT INTO xccc_tmp ",   
                   " SELECT xcccent,xccccomp,xcccld,xccc001,xccc002,xccc003,xccc004,xccc005,xccc006,xccc007,xccc008, ",
                   "        xccc010,xccc280,xccc901,(SELECT xcbb006 FROM xcbb_t WHERE xcbbent = xcccent AND xcbbcomp = xccccomp AND xcbb001 = xccc004 AND xcbb002 = xccc005 AND xcbb003 = xccc006) clevel ",
                   "   FROM xccc_t LEFT JOIN imaf_t ON xcccent = imafent AND xccccomp = imafsite  AND xccc006 = imaf001 ",
                   "               LEFT JOIN imag_t ON xcccent = imagent AND xccccomp = imagsite  AND xccc006 = imag001 ",
                   "  WHERE xcccent  = '",g_enterprise,"'",
                   "    AND xcccld   = '",g_master.xcccld,"'",
                   "    AND xccccomp = '",g_master.xccccomp,"'",
                   "    AND xccc001  = '",g_master.xccc001,"'",
                   "    AND xccc003  = '",g_master.xccc003,"'",
                   "    AND xccc004  = '",g_master.xccc004,"'",
                   "    AND xccc005  = '",g_master.xccc005,"'",
                   "    AND ",g_master.wc
   
      PREPARE axcp801_ins_xccc_tbl FROM l_sql
      EXECUTE axcp801_ins_xccc_tbl
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'INSERT xccc_tmp'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      FREE axcp801_ins_xccc_tbl  
      
      
      
      LET l_sql = " INSERT INTO inat_tmp  ",
                  " SELECT inat001,inat002,inat007,inat015,imag014, CASE WHEN inat007 = imag014 THEN 1 ELSE 0 END inaj013",
                  "   FROM (",
                  " SELECT inat001,inat002,inat007,SUM(inat015) inat015,(SELECT imaa006 FROM imaa_t WHERE inatent =imaaent AND inat001 = imaa001) imag014 ",
                  "   FROM xccc_tmp,inat_t,xcfd_t ",
                  "  WHERE xcccent = inatent AND xccc004 = inat008 AND xccc005 = inat009 AND xccc006 = inat001 AND xccc007 = inat002 ",
                  "    AND xcccent = xcfdent AND xccccomp = xcfdcomp AND xcccld = xcfdld AND xccc004 = xcfd001 AND xccc005 = xcfd002 ",
                  "    AND xcfd010 = inat004 AND inatsite IN (SELECT DISTINCT ooef001 FROM ooef_t WHERE ooefent=xcccent AND ooef017 = xccccomp AND ooef201 ='Y' AND ooefstus = 'Y') ",         
                  "  GROUP BY inatent,inat001,inat002,inat007 ",
                  "        )"               
      PREPARE axcp801_ins_inat_tbl FROM l_sql
      EXECUTE axcp801_ins_inat_tbl
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'INSERT inat_tmp'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      FREE axcp801_ins_inat_tbl
      
      #庫存單位和成本單位轉換率
      LET l_sql = "SELECT DISTINCT inat001,inat007,imag014 ",
                  "  FROM inat_tmp ",
                  " WHERE inaj013 = 0 "
      PREPARE axcp801_unit_p FROM l_sql
      DECLARE axcp801_unit_c CURSOR FOR axcp801_unit_p
      FOREACH axcp801_unit_c INTO l_inat001,l_inat007,l_imag014             
        CALL s_aimi190_get_convert(l_inat001,l_inat007,l_imag014)
          RETURNING l_success,l_rate
        UPDATE inat_tmp
           SET inaj013 = l_rate
         WHERE inat001 = l_inat001
           AND inat007 = l_inat007
           AND imag014 = l_imag014
           AND inaj013 = 0   
        IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.sqlcode
           LET g_errparam.extend = 'UPDATE inat_tmp'
           LET g_errparam.popup = TRUE
           CALL cl_err()
           LET r_success = FALSE
           RETURN r_success
        END IF        
      
      END FOREACH
      
      #把期未数量按庫存单位和成本单位换算
      UPDATE inat_tmp SET inat015 = inat015 * inaj013
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'upd inat015'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF    
      
      #排除LCM計算除外倉庫
      #期未結存數量(XCCC901) = LCM計算除外倉庫(xcfd_t)的該料庫存數量(inat015)合計
      DELETE FROM xccc_tmp
       WHERE EXISTS (SELECT 1 FROM (SELECT xcccent,xcccld,xccc001,xccc002,xccc003,xccc004,xccc005,xccc006,
                                     (SELECT SUM(inat015) inat015 FROM inat_tmp WHERE a.xccc006 = inat001 AND a.xccc007 = inat002) inat015
                                      FROM xccc_tmp a 
                                   ) c
                      WHERE xcccent = c.xcccent AND xcccld = c.xcccld
                        AND xccc001 = c.xccc001 AND xccc002 = c. xccc002 AND xccc003 = c.xccc003 
                        AND xccc004 = c.xccc004 AND xccc005 = c.xccc005 AND xccc006 = c.xccc006
                        AND xccc901 = c.inat015                        
                    )
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'del xccc'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF   
 
      LET l_cnt = 0
      SELECT COUNT(1) INTO l_cnt
        FROM xccc_tmp
      IF l_cnt = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axc-00530'  #無資料產生！
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()      
         LET r_success = FALSE
         RETURN r_success
      END IF
     

     #寫入xcfg_tmp
      LET l_sql = " INSERT INTO xcfg_tmp  ", 
                  #       企業編號 法人組織  帳套    
                  " SELECT xcccent,xccccomp,xcccld, ",
                  #  帳套本位幣順序   成本域 成本計算類型 年度 期別
                  "        xccc001,xccc002,xccc003,xccc004,xccc005, ",
                  #           料件   特性    批號     存貨類別
                  "        xccc006,xccc007,xccc008,CASE WHEN clevel = 0 THEN '1' WHEN clevel= 99 THEN '3' WHEN clevel= 98 THEN '3' WHEN clevel= 97 THEN '3' ELSE '2' END xcfg010, ",
                  #        材料分類         成本單位                                                                   幣別  庫存數量 進貨單價
                  "        '',(SELECT imaa006 FROM imaa_t WHERE imaaent =xcccent AND imaa001 = xccc006),xccc010,xccc901,0,",
                  #  銷售單價   單位成本   淨變現單價 淨變現市價
                  "        0,nvl(xccc280,0),'',0,0,",
                  #淨變現逆推順序 淨變現銷售費用率類別 淨變現銷售費用率 逆推成品平均QPA 淨變現逆推成品料號
                  "        '",g_xcfa013,"' ,'",g_master.xcfa006,"', 0,0,'', ",
                  #淨變現逆推成品平均單位成本 淨變現逆推成品平均淨變現單價 淨變現逆推參考單號 淨變現逆推參考項次 淨變現逆推單據日期 成本階                 
                  "       0,0,'','','',clevel  ",
                  "  FROM xccc_tmp "                  

      PREPARE axcp801_ins_xcfg_tbl FROM l_sql
      EXECUTE axcp801_ins_xcfg_tbl
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'INSERT xcfg_tmp'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      FREE axcp801_ins_xcfg_tbl 
   
      
      LET l_cnt = 0
      SELECT COUNT(1) INTO l_cnt
        FROM xcfg_t a
       WHERE EXISTS (SELECT 1 FROM xcfg_tmp b
                      WHERE a.xcfgent = b.xcfgent
                        AND a.xcfgcomp = b.xcfgcomp
                        AND a.xcfgld = b.xcfgld
                        AND a.xcfg001 = b.xcfg001
                        AND a.xcfg002 = b.xcfg002
                        AND a.xcfg003 = b.xcfg003
                        AND a.xcfg004 = b.xcfg004
                        AND a.xcfg005 = b.xcfg005
                        AND a.xcfg006 = b.xcfg006
                        AND a.xcfg007 = b.xcfg007
                        AND a.xcfg008 = b.xcfg008)
      IF l_cnt > 0 THEN
          #已存在對應的xcfg_t（LCM存貨成本和市價期資料檔），是否刪除後重新產生？
          IF NOT cl_ask_confirm('axc-00799') THEN
             LET r_success = FALSE
          END IF
      END IF  
      #xcfg011 材料分類axci801
      UPDATE xcfg_tmp
         SET xcfg011 = (SELECT xcfb010
                          FROM xcfb_t
                         WHERE xcfbent = xcfgent AND xcfbcomp = xcfgcomp 
                           AND xcfbld = xcfgld AND xcfb001 = xcfg004 
                           AND xcfb002 = xcfg005 AND xcfb011 = xcfg013
                           AND (xcfg017 >= xcfb012 AND xcfg017 <= xcfb014) )      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'UPD xcfg_tmp xcfg011'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF        
      #先判斷是否有BOM，如果有，先將xcfg028 UPDATE 'BOM'，後面統一處理  
      IF g_master.xcfa007 = '2' THEN   #逆推成品價
         UPDATE xcfg_tmp
            SET xcfg028 = 'BOM'
          WHERE xcfg010 IN ('2','3')   #半成品、原料
            AND xcfg006 IN (SELECT DISTINCT bmba003 FROM bmaa_t,bmba_t
                             WHERE bmaaent = bmbaent AND bmaasite = bmbasite 
                               AND bmaa001 = bmba001 AND bmaa002 = bmba002
                               AND bmaastus = 'Y' AND bmba005 <= g_today
                               AND (bmba006 >= g_today  OR bmba006 IS NULL)
                               AND bmbaent = xcfgent AND bmbasite =  'ALL')
         
      ELSE
         UPDATE xcfg_tmp
            SET xcfg028 = 'BOM'
          WHERE xcfg010 = '2'      #半成品
            AND xcfg006 IN (SELECT DISTINCT bmba003 FROM bmaa_t,bmba_t
                             WHERE bmaaent = bmbaent AND bmaasite = bmbasite 
                               AND bmaa001 = bmba001 AND bmaa002 = bmba002
                               AND bmaastus = 'Y' AND bmba005 <= g_today
                               AND (bmba006 >= g_today  OR bmba006 IS NULL)
                               AND bmbaent = xcfgent AND bmbasite =  'ALL')      
      END IF
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'UPD xcfg_tmp xcfg028'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF    
      
      RETURN r_success


END FUNCTION

################################################################################
# Descriptions...: DROP TABLE
# Memo...........:
# Usage..........: CALL axcp801_drop_tmp_table()
#                  RETURNING 
# Input parameter: 
# Return code....: 
# Date & Author..: #161108-00037#1 By 02040
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp801_drop_tmp_table()

  DROP TABLE xcfg_tmp  
  DROP TABLE xcfh_tmp 
  DROP TABLE xcfi_tmp
  DROP TABLE xccc_tmp
  DROP TABLE inat_tmp

END FUNCTION

################################################################################
# Descriptions...: 抓取人單價成本(人工市價)
# Memo...........:
# Usage..........: CALL axcp801_upd_xcfg()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success   TRUE/FALSE
# Date & Author..: 161108-00037#1 By 02040
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp801_upd_xcfg()
   DEFINE l_sql      STRING
   DEFINE ls_msg     STRING
   DEFINE l_xcfg006  LIKE xcfg_t.xcfg006
   DEFINE l_xcfg007  LIKE xcfg_t.xcfg007
   DEFINE l_xcfg008  LIKE xcfg_t.xcfg008
   DEFINE r_success LIKE type_t.num5
  
   LET r_success = TRUE
   
   #抓取xcfg_t資料，按存貨類別、成本階、料件做排序
   #1.成品單價：(1)人工市價=>(2)應收帳款=>(3)訂單(一般訂單、簽收訂單)=>(4)預先訂單=>(5)當淨變現取成本價否=Y時，取最近成本價
   #2.1(無BOM)半成品單價：(1)人工市價=>(2)應收帳款=>(3)訂單(一般訂單、簽收訂單)=>(4)預先訂單=>(5)當淨變現取成本價否=Y時，取最近成本價
   #2.2(有BOM)半成品單價：(1)人工市價=>(2)展BOM至最上階料號
   #3.1_1(原料評價為'2'逆推成品價)(無BOM)原料單價：(1)人工市價=>(2)應收帳款=>(3)訂單(一般訂單、簽收訂單)=>(4)預先訂單=>(5)當淨變現取成本價否=Y時，取最近成本價
   #3.1-2(原料評價為'2'逆推成品價)(有BOM)原料單價：(1)人工市價=>(2)展BOM至最上階料號
   #3.1-3(原料評價為'1'採購進價OR淨變現單價為0[(3.1_1、3.1_2取出都為0)])原料單價：(1)人工市價=>(2)應付帳款(3)採購單=>(4)成本單價

   IF g_bgjob <> "Y" THEN
      LET g_progress_msg = cl_getmsg('axc-00805',g_dlang)  #抓取人工市價
      CALL cl_progress_no_window_ing(g_progress_msg)
   END IF 
   
   CALL cl_getmsg('axc-00798',g_lang) RETURNING ls_msg  #人工市價
   IF cl_null(ls_msg) THEN
      LET ls_msg = 'axc-00798'
   END IF
   #update xcfg023(淨變現銷售費用率)
   CASE g_master.xcfa006  #淨變現料件分類來源
     WHEN '1' #主分群碼imaa003

       LET l_sql = " MERGE INTO xcfg_tmp a ",
                   "       USING (SELECT xcfgent,xcfgcomp,xcfg001,xcfg002,xcfg003,xcfg004,xcfg005,xcfg006,xcfg007,xcfg008,nvl(xcff006,0)xcff006 ",
                   "                 FROM xcfg_tmp,imaa_t,xcff_t ",
                   "               WHERE xcfgent = imaaent AND xcfg006 = imaa001 ",
                   "                 AND xcfgent = xcffent AND xcfgcomp = xcffcomp AND xcfg004 = xcff001 AND xcfg005 = xcff002 AND xcff003 = '1' ",
                   "                 AND imaa003 = xcff004) c ",
                   "           ON (a.xcfgent = c.xcfgent    AND a.xcfgcomp = c.xcfgcomp ",
                   "          AND a.xcfg001 = c.xcfg001  AND a.xcfg002 = c.xcfg002 ",
                   "          AND a.xcfg003 = c.xcfg003  AND a.xcfg004 = c.xcfg004 ",
                   "          AND a.xcfg005 = c.xcfg005  AND a.xcfg006 = c.xcfg006 ",
                   "          AND a.xcfg007 = c.xcfg007  AND a.xcfg008 = c.xcfg008)  ", 
                   "  WHEN MATCHED THEN  ",          
                   "    UPDATE SET a.xcfg023 = c.xcff006 "                                

         
     WHEN '2' #銷售分群 imaf111
       LET l_sql = " MERGE INTO xcfg_tmp a ",
                   "       USING (SELECT xcfgent,xcfgcomp,xcfg001,xcfg002,xcfg003,xcfg004,xcfg005,xcfg006,xcfg007,xcfg008,nvl(xcff006,0)xcff006 ",
                   "                 FROM xcfg_tmp,imaf_t,xcff_t ",
                   "               WHERE xcfgent = imafent AND xcfg006 = imaf001 ",
                   "                 AND xcfgent = xcffent AND xcfgcomp = xcffcomp AND xcfg004 = xcff001 AND xcfg005 = xcff002 AND xcff003 = '1' ",
                   "                 AND imafsite = '",g_site,"' AND imaf111 = xcff004) c ",
                   "           ON (a.xcfgent = c.xcfgent    AND a.xcfgcomp = c.xcfgcomp ",
                   "          AND a.xcfg001 = c.xcfg001  AND a.xcfg002 = c.xcfg002 ",
                   "          AND a.xcfg003 = c.xcfg003  AND a.xcfg004 = c.xcfg004 ",
                   "          AND a.xcfg005 = c.xcfg005  AND a.xcfg006 = c.xcfg006 ",
                   "          AND a.xcfg007 = c.xcfg007  AND a.xcfg008 = c.xcfg008)  ", 
                   "  WHEN MATCHED THEN  ",          
                   "    UPDATE SET a.xcfg023 = c.xcff006 " 
                      
     WHEN '3' #成本分群 imag011
        LET l_sql = " MERGE INTO xcfg_tmp a ",
                   "       USING (SELECT xcfgent,xcfgcomp,xcfg001,xcfg002,xcfg003,xcfg004,xcfg005,xcfg006,xcfg007,xcfg008,nvl(xcff006,0)xcff006 ",
                   "                 FROM xcfg_tmp,imag_t,xcff_t ",
                   "               WHERE xcfgent = imagent AND xcfg006 = imag001 ",
                   "                 AND xcfgent = xcffent AND xcfgcomp = xcffcomp AND xcfg004 = xcff001 AND xcfg005 = xcff002 AND xcff003 = '1' ",
                   "                 AND imagsite = '",g_site,"' AND imag011 = xcff004) c ",
                   "           ON (a.xcfgent = c.xcfgent    AND a.xcfgcomp = c.xcfgcomp ",
                   "          AND a.xcfg001 = c.xcfg001  AND a.xcfg002 = c.xcfg002 ",
                   "          AND a.xcfg003 = c.xcfg003  AND a.xcfg004 = c.xcfg004 ",
                   "          AND a.xcfg005 = c.xcfg005  AND a.xcfg006 = c.xcfg006 ",
                   "          AND a.xcfg007 = c.xcfg007  AND a.xcfg008 = c.xcfg008)  ", 
                   "  WHEN MATCHED THEN  ",          
                   "    UPDATE SET a.xcfg023 = c.xcff006 " 
                   
     WHEN '4' #庫存分群 imaf051
       LET l_sql = " MERGE INTO xcfg_tmp a ",
                   "       USING (SELECT xcfgent,xcfgcomp,xcfg001,xcfg002,xcfg003,xcfg004,xcfg005,xcfg006,xcfg007,xcfg008,nvl(xcff006,0)xcff006 ",
                   "                 FROM xcfg_tmp,imaf_t,xcff_t ",
                   "               WHERE xcfgent = imafent AND xcfg006 = imaf001 ",
                   "                 AND xcfgent = xcffent AND xcfgcomp = xcffcomp AND xcfg004 = xcff001 AND xcfg005 = xcff002 AND xcff003 = '1' ",
                   "                 AND imafsite = '",g_site,"' AND imaf051 = xcff004) c ",
                   "           ON (a.xcfgent = c.xcfgent    AND a.xcfgcomp = c.xcfgcomp ",
                   "          AND a.xcfg001 = c.xcfg001  AND a.xcfg002 = c.xcfg002 ",
                   "          AND a.xcfg003 = c.xcfg003  AND a.xcfg004 = c.xcfg004 ",
                   "          AND a.xcfg005 = c.xcfg005  AND a.xcfg006 = c.xcfg006 ",
                   "          AND a.xcfg007 = c.xcfg007  AND a.xcfg008 = c.xcfg008)  ", 
                   "  WHEN MATCHED THEN  ",          
                   "    UPDATE SET a.xcfg023 = c.xcff006 " 
                        
     WHEN '5' #料號
       LET l_sql = " MERGE INTO xcfg_tmp ",
                   "       USING (SELECT xcffent,xcffcomp,xcff001,xcff002,xcff004,nvl(xcff006,0)xcff006 ",
                   "                FROM xcff_t WHERE xcff003 = '5' )",
                   "          ON (xcfgent = xcffent ",
                   "          AND xcfgcomp = xcffcomp ",
                   "          AND xcfg004 = xcff001 ",
                   "          AND xcfg005 = xcff002 ",
                   "          AND xcfg006 = xcff004) ", 
                   "  WHEN MATCHED THEN  ",          
                   "    UPDATE SET xcfg023 = xcff006 "        
       
                                                      
     WHEN '6' #其他分群一 imaa132
       LET l_sql = " MERGE INTO xcfg_tmp a ",
                   "       USING (SELECT xcfgent,xcfgcomp,xcfg001,xcfg002,xcfg003,xcfg004,xcfg005,xcfg006,xcfg007,xcfg008,nvl(xcff006,0)xcff006 ",
                   "                 FROM xcfg_tmp,imaa_t,xcff_t ",
                   "               WHERE xcfgent = imaaent AND xcfg006 = imaa001 ",
                   "                 AND xcfgent = xcffent AND xcfgcomp = xcffcomp AND xcfg004 = xcff001 AND xcfg005 = xcff002 AND xcff003 = '1' ",
                   "                 AND imaa132 = xcff004) c ",
                   "           ON (a.xcfgent = c.xcfgent    AND a.xcfgcomp = c.xcfgcomp ",
                   "          AND a.xcfg001 = c.xcfg001  AND a.xcfg002 = c.xcfg002 ",
                   "          AND a.xcfg003 = c.xcfg003  AND a.xcfg004 = c.xcfg004 ",
                   "          AND a.xcfg005 = c.xcfg005  AND a.xcfg006 = c.xcfg006 ",
                   "          AND a.xcfg007 = c.xcfg007  AND a.xcfg008 = c.xcfg008)  ", 
                   "  WHEN MATCHED THEN  ",          
                   "    UPDATE SET a.xcfg023 = c.xcff006 " 
                       
   END CASE
   #抓取銷售費用率axci803
   PREPARE axcp801_upd_xcfg_tb1 FROM l_sql
   EXECUTE axcp801_upd_xcfg_tb1
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'UPDATE xcfg016'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   FREE axcp801_upd_xcfg_tb1  


   #抓取人工市價update xcfg019
   CASE g_master.xcfa009  #淨變現人工維護市價來源
     WHEN '1' #主分群碼imaa003                   
       LET l_sql = " MERGE INTO xcfg_tmp a ",
                    "       USING (SELECT xcfgent,xcfgcomp,xcfg001,xcfg002,xcfg003,xcfg004,xcfg005,xcfg006,xcfg007,xcfg008,nvl(xcfe006,0)xcfe006 ",
                    "                FROM xcfg_tmp,imaa_t,xcfe_t ",
                    "               WHERE xcfgent = imaaent AND xcfg006 = imaa001 ",
                    "                 AND xcfgent = xcfeent AND xcfgcomp = xcfecomp AND xcfg004 = xcfe001 AND xcfg005 = xcfe002 AND xcfg013 = xcfe005 AND xcfe003 = '1' ",
                    "                 AND imaa003 = xcfe004 ) c ",
                    "          ON (a.xcfgent = c.xcfgent    AND a.xcfgcomp = c.xcfgcomp ",
                    "         AND a.xcfg001 = c.xcfg001  AND a.xcfg002 = c.xcfg002 ",
                    "         AND a.xcfg003 = c.xcfg003  AND a.xcfg004 = c.xcfg004 ",
                    "         AND a.xcfg005 = c.xcfg005  AND a.xcfg006 = c.xcfg006 ",
                    "         AND a.xcfg007 = c.xcfg007  AND a.xcfg008 = c.xcfg008)  ", 
                    "  WHEN MATCHED THEN  ",         
                    "    UPDATE SET a.xcfg016 = c.xcfe006, ",
                    "               a.xcfg019 = c.xcfe006, ",
                    "               a.xcfg020 = c.xcfe006, ",
                    "               a.xcfg028 = '",ls_msg,"' "                

         
     WHEN '2' #銷售分群 imaf111
       LET l_sql = " MERGE INTO xcfg_tmp a ",
                    "       USING (SELECT xcfgent,xcfgcomp,xcfg001,xcfg002,xcfg003,xcfg004,xcfg005,xcfg006,xcfg007,xcfg008,nvl(xcfe006,0)xcfe006 ",
                    "                FROM xcfg_tmp,imaf_t,xcfe_t ",
                    "               WHERE xcfgent = imafent AND xcfg006 = imaf001 ",
                    "                 AND xcfgent = xcfeent AND xcfgcomp = xcfecomp AND xcfg004 = xcfe001 AND xcfg005 = xcfe002 AND xcfg013 = xcfe005 AND xcfe003 = '1' ",
                    "                 AND imafsite = '",g_site,"' AND imaf111 = xcfe004 ) c ",
                    "           ON (a.xcfgent = c.xcfgent    AND a.xcfgcomp = c.xcfgcomp ",
                    "          AND a.xcfg001 = c.xcfg001  AND a.xcfg002 = c.xcfg002 ",
                    "          AND a.xcfg003 = c.xcfg003  AND a.xcfg004 = c.xcfg004 ",
                    "          AND a.xcfg005 = c.xcfg005  AND a.xcfg006 = c.xcfg006 ",
                    "          AND a.xcfg007 = c.xcfg007  AND a.xcfg008 = c.xcfg008)  ", 
                    "  WHEN MATCHED THEN  ",         
                    "    UPDATE SET a.xcfg016 = c.xcfe006, ",
                    "               a.xcfg019 = c.xcfe006, ",
                    "               a.xcfg020 = c.xcfe006, ",
                    "               a.xcfg028 = '",ls_msg,"' "       
     WHEN '3' #成本分群 imag011                  
       LET l_sql = " MERGE INTO xcfg_tmp a ",
                    "       USING (SELECT xcfgent,xcfgcomp,xcfg001,xcfg002,xcfg003,xcfg004,xcfg005,xcfg006,xcfg007,xcfg008,nvl(xcfe006,0)xcfe006 ",
                    "                FROM xcfg_tmp,imag_t,xcfe_t ",
                    "               WHERE xcfgent = imagent AND xcfg006 = imag001 ",
                    "                 AND xcfgent = xcfeent AND xcfgcomp = xcfecomp AND xcfg004 = xcfe001 AND xcfg005 = xcfe002 AND xcfg013 = xcfe005 AND xcfe003 = '1' ",
                    "                 AND imagsite = '",g_site,"' AND imag011 = xcfe004 ) c ",
                    "           ON (a.xcfgent = c.xcfgent    AND a.xcfgcomp = c.xcfgcomp ",
                    "          AND a.xcfg001 = c.xcfg001  AND a.xcfg002 = c.xcfg002 ",
                    "          AND a.xcfg003 = c.xcfg003  AND a.xcfg004 = c.xcfg004 ",
                    "          AND a.xcfg005 = c.xcfg005  AND a.xcfg006 = c.xcfg006 ",
                    "          AND a.xcfg007 = c.xcfg007  AND a.xcfg008 = c.xcfg008)  ", 
                    "  WHEN MATCHED THEN  ",         
                    "    UPDATE SET a.xcfg016 = c.xcfe006, ",
                    "               a.xcfg019 = c.xcfe006, ",
                    "               a.xcfg020 = c.xcfe006, ",
                    "               a.xcfg028 = '",ls_msg,"' "      
     WHEN '4' #庫存分群 imaf051
       LET l_sql = " MERGE INTO xcfg_tmp a ",
                    "       USING (SELECT xcfgent,xcfgcomp,xcfg001,xcfg002,xcfg003,xcfg004,xcfg005,xcfg006,xcfg007,xcfg008,nvl(xcfe006,0)xcfe006 ",
                    "                FROM xcfg_tmp,imaf_t,xcfe_t ",
                    "               WHERE xcfgent = imafent AND xcfg006 = imaf001 ",
                    "                 AND xcfgent = xcfeent AND xcfgcomp = xcfecomp AND xcfg004 = xcfe001 AND xcfg005 = xcfe002 AND xcfg013 = xcfe005 AND xcfe003 = '1' ",
                    "                 AND imafsite = '",g_site,"' AND imaf051 = xcfe004 ) c ",
                    "           ON (a.xcfgent = c.xcfgent    AND a.xcfgcomp = c.xcfgcomp ",
                    "          AND a.xcfg001 = c.xcfg001  AND a.xcfg002 = c.xcfg002 ",
                    "          AND a.xcfg003 = c.xcfg003  AND a.xcfg004 = c.xcfg004 ",
                    "          AND a.xcfg005 = c.xcfg005  AND a.xcfg006 = c.xcfg006 ",
                    "          AND a.xcfg007 = c.xcfg007  AND a.xcfg008 = c.xcfg008)  ", 
                    "  WHEN MATCHED THEN  ",         
                    "    UPDATE SET a.xcfg016 = c.xcfe006, ",
                    "               a.xcfg019 = c.xcfe006, ",
                    "               a.xcfg020 = c.xcfe006, ",
                    "               a.xcfg028 = '",ls_msg,"' "         
     WHEN '5' #料號 
       LET l_sql = " MERGE INTO xcfg_tmp ",
                    "       USING xcfe_t ",
                    "          ON (xcfgent = xcfeent ",
                    "          AND xcfgcomp = xcfecomp ",
                    "          AND xcfg004 = xcfe001 ",
                    "          AND xcfg005 = xcfe002 ",
                    "          AND xcfg006 = xcfe004 ", #料號
                    "          AND xcfg013 = xcfe005 ", #幣別
                    "          AND xcfe003 = '5' ) ",
                    "  WHEN MATCHED THEN  ",          
                    "    UPDATE SET xcfg016 = xcfe006, ",
                    "               xcfg019 = xcfe006, ",
                    "               xcfg020 = xcfe006, ",
                    "               xcfg028 = '",ls_msg,"' "
                       
                                                      
     WHEN '6' #其他分群一 imaa132             
       LET l_sql = " MERGE INTO xcfg_tmp a ",
                    "       USING (SELECT xcfgent,xcfgcomp,xcfg001,xcfg002,xcfg003,xcfg004,xcfg005,xcfg006,xcfg007,xcfg008,nvl(xcfe006,0)xcfe006 ",
                    "                FROM xcfg_tmp,imaa_t,xcfe_t ",
                    "               WHERE xcfgent = imaaent AND xcfg006 = imaa001 ",
                    "                 AND xcfgent = xcfeent AND xcfgcomp = xcfecomp AND xcfg004 = xcfe001 AND xcfg005 = xcfe002 AND xcfg013 = xcfe005 AND xcfe003 = '1' ",
                    "                 AND imaa132 = xcfe004 ) c ",
                   "           ON (a.xcfgent = c.xcfgent    AND a.xcfgcomp = c.xcfgcomp ",
                   "          AND a.xcfg001 = c.xcfg001  AND a.xcfg002 = c.xcfg002 ",
                   "          AND a.xcfg003 = c.xcfg003  AND a.xcfg004 = c.xcfg004 ",
                   "          AND a.xcfg005 = c.xcfg005  AND a.xcfg006 = c.xcfg006 ",
                   "          AND a.xcfg007 = c.xcfg007  AND a.xcfg008 = c.xcfg008)  ", 
                   "  WHEN MATCHED THEN  ",         
                    "    UPDATE SET a.xcfg016 = c.xcfe006, ",
                    "               a.xcfg019 = c.xcfe006, ",
                    "               a.xcfg020 = c.xcfe006, ",
                    "               a.xcfg028 = '",ls_msg,"' "           
   END CASE   
   

   #抓取人工市價axci802
   PREPARE axcp801_upd_xcfg_tb2 FROM l_sql
   EXECUTE axcp801_upd_xcfg_tb2
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'UPDATE xcfg016'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   FREE axcp801_upd_xcfg_tb2    
  
   #成品
   IF NOT axcp801_upd_xcfg_1() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #半成品
   IF NOT axcp801_upd_xcfg_2() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF   
   
   #原料
   IF NOT axcp801_upd_xcfg_3() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF   
   
     
   #取價來源：BOM
   UPDATE xcfg_tmp
      SET xcfg028 = ''
    WHERE xcfg028 = 'BOM'   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'UPDATE BOM'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF   

   #單價取位
   CASE g_round_type
     WHEN '1'   #四捨五入
       LET l_sql = " UPDATE xcfg_tmp SET xcfg015 = round(xcfg015 ,?),xcfg016 = round(xcfg016 ,?),",
                   "                     xcfg019 = round(xcfg019 ,?),xcfg020 = round(xcfg020 ,?),",
                   "                     xcfg026 = round(xcfg026 ,?),xcfg027 = round(xcfg027 ,?) "
     WHEN '3'   #無條件截位
       LET l_sql = " UPDATE xcfg_tmp SET xcfg015 = trunc(xcfg015 ,?),xcfg016 = trunc(xcfg016 ,?),",
                   "                     xcfg019 = trunc(xcfg019 ,?),xcfg020 = trunc(xcfg020 ,?),",
                   "                     xcfg026 = trunc(xcfg026 ,?),xcfg027 = trunc(xcfg027 ,?)"     
   END CASE  
   PREPARE axcp801_upd_xcfg_p FROM l_sql
   EXECUTE axcp801_upd_xcfg_p USING g_curr.digit1,g_curr.digit1,g_curr.digit1,g_curr.digit1,
                                    g_curr.digit1,g_curr.digit1   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'axcp801_upd_xcfg_p'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF 

   CASE g_round_type
     WHEN '1'   #四捨五入
       LET l_sql = " UPDATE xcfi_tmp SET xcfi011 = round(xcfi011 ,?)"

     WHEN '3'   #無條件截位
       LET l_sql = " UPDATE xcfi_tmp SET xcfi011 = trunc(xcfi011 ,?)"                  
                   
   END CASE  
   PREPARE axcp801_upd_xcfi_p FROM l_sql
   EXECUTE axcp801_upd_xcfi_p USING g_curr.digit1
                                    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'axcp801_upd_xcfi_p'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF 

   
   RETURN r_success

END FUNCTION

################################################################################
# Descriptions...: 抓取1.成品單價成本
# Memo...........:
# Usage..........: CALL axcp801_upd_xcfg_1()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success    TRUE/FALSE
# Date & Author..: 161108-00037#1 By 02040
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp801_upd_xcfg_1()
DEFINE r_success    LIKE type_t.num5
DEFINE l_success    LIKE type_t.num5
DEFINE l_sql        STRING

   LET r_success = TRUE
   
   #存貨類別-1.成品-應收帳款抓取
   IF g_bgjob <> "Y" THEN      
      LET g_progress_msg = cl_getmsg('axc-00814',g_dlang),cl_getmsg('axc-00806',g_dlang)
      CALL cl_progress_no_window_ing(g_progress_msg)
   END IF    
   IF NOT axcp801_get_xrca('1') THEN
      LET r_success = FALSE
      RETURN r_success
   END IF   
   #存貨類別-1.成品-訂單/簽收訂單抓取
   IF g_bgjob <> "Y" THEN      
      LET g_progress_msg = cl_getmsg('axc-00814',g_dlang),cl_getmsg('axc-00807',g_dlang)
      CALL cl_progress_no_window_ing(g_progress_msg)
   END IF    
   IF NOT axcp801_get_xmda('1') THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   #存貨類別-1.成品-訂單/預先訂單抓取
   IF g_bgjob <> "Y" THEN      
      LET g_progress_msg = cl_getmsg('axc-00814',g_dlang),cl_getmsg('axc-00808',g_dlang)
      CALL cl_progress_no_window_ing(g_progress_msg)
   END IF   
   IF NOT axcp801_get_order_xmda('1') THEN
      LET r_success = FALSE
      RETURN r_success
   END IF   
   #存貨類別-1.成品-成本價抓取
   IF g_bgjob <> "Y" THEN      
      LET g_progress_msg = cl_getmsg('axc-00814',g_dlang),cl_getmsg('axc-00809',g_dlang)
      CALL cl_progress_no_window_ing(g_progress_msg)
   END IF   
   IF NOT axcp801_get_cost('1') THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   RETURN r_success 
END FUNCTION
################################################################################
# Descriptions...: 抓取2.半成品單價成本
# Memo...........:
# Usage..........: CALL axcp801_upd_xcfg_2()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success    TRUE/FALSE
# Date & Author..: 161108-00037#1 By 02040
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp801_upd_xcfg_2()
DEFINE r_success    LIKE type_t.num5
DEFINE l_success    LIKE type_t.num5
DEFINE l_sql        STRING

   LET r_success = TRUE
   
   #有BOM，就逆推(先將有BOM的xcfg028 update ='BOM，等算完半成品和原料時，再來算有BOM的計算)
   #無BOM，就和成品一樣
   
   #存貨類別-2.半成品-應收帳款抓取
   IF g_bgjob <> "Y" THEN      
      LET g_progress_msg = cl_getmsg('axc-00815',g_dlang),cl_getmsg('axc-00806',g_dlang)
      CALL cl_progress_no_window_ing(g_progress_msg)
   END IF    
   IF NOT axcp801_get_xrca('2') THEN
      LET r_success = FALSE
      RETURN r_success
   END IF   
   #存貨類別-2.半成品-訂單/簽收訂單抓取
   IF g_bgjob <> "Y" THEN      
      LET g_progress_msg = cl_getmsg('axc-00815',g_dlang),cl_getmsg('axc-00807',g_dlang)
      CALL cl_progress_no_window_ing(g_progress_msg)
   END IF  
   IF NOT axcp801_get_xmda('2') THEN
      LET r_success = FALSE
   END IF
   #存貨類別-2.半成品-預先訂單抓取
   IF g_bgjob <> "Y" THEN      
      LET g_progress_msg = cl_getmsg('axc-00815',g_dlang),cl_getmsg('axc-00808',g_dlang)
      CALL cl_progress_no_window_ing(g_progress_msg)
   END IF   
   IF NOT axcp801_get_order_xmda('2') THEN
      LET r_success = FALSE
   END IF    
   #存貨類別-2.半成品-成本價抓取
   IF g_bgjob <> "Y" THEN      
      LET g_progress_msg = cl_getmsg('axc-00815',g_dlang),cl_getmsg('axc-00809',g_dlang)
      CALL cl_progress_no_window_ing(g_progress_msg)
   END IF       
   IF NOT axcp801_get_cost('2') THEN
      LET r_success = FALSE
      RETURN r_success
   END IF   
   
   RETURN r_success
   
END FUNCTION
################################################################################
# Descriptions...: 抓取3.原料單價成本
# Memo...........:
# Usage..........: CALL axcp801_upd_xcfg_3()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success    TRUE/FALSE
# Date & Author..: 161108-00037#1 By 02040
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp801_upd_xcfg_3()
DEFINE r_success LIKE type_t.num5
DEFINE l_sql     STRING

   LET r_success = TRUE

   CASE g_master.xcfa007
     WHEN '1' #採購進價
     
       #存貨類別-3.原料-應付帳款抓取
       IF g_bgjob <> "Y" THEN          
          LET g_progress_msg = cl_getmsg('axc-00816',g_dlang),cl_getmsg('axc-00810',g_dlang)
          CALL cl_progress_no_window_ing(g_progress_msg)
       END IF      
       IF NOT axcp801_get_apca('3') THEN
          LET r_success = FALSE
          RETURN r_success
       END IF
       #存貨類別-3.原料-採購單抓取       
       IF g_bgjob <> "Y" THEN          
          LET g_progress_msg = cl_getmsg('axc-00816',g_dlang),cl_getmsg('axc-00811',g_dlang)
          CALL cl_progress_no_window_ing(g_progress_msg)
       END IF         
       IF NOT axcp801_get_pmdl('3') THEN
          LET r_success = FALSE
          RETURN r_success
       END IF 
       #存貨類別-3.原料-成本價抓取
       IF g_bgjob <> "Y" THEN          
          LET g_progress_msg = cl_getmsg('axc-00816',g_dlang),cl_getmsg('axc-00809',g_dlang)
          CALL cl_progress_no_window_ing(g_progress_msg)
       END IF              
       IF NOT axcp801_get_cost('3') THEN
          LET r_success = FALSE
          RETURN r_success
       END IF      
     
     WHEN '2' #逆推成品價
       
       #存貨類別-3.原料-應收帳款抓取
       IF g_bgjob <> "Y" THEN          
          LET g_progress_msg = cl_getmsg('axc-00816',g_dlang),cl_getmsg('axc-00806',g_dlang)
          CALL cl_progress_no_window_ing(g_progress_msg)
       END IF      
       IF NOT axcp801_get_xrca('3') THEN
          LET r_success = FALSE
          RETURN r_success
       END IF 
       #存貨類別-3.原料-訂單/簽收訂單抓取
       IF g_bgjob <> "Y" THEN          
          LET g_progress_msg = cl_getmsg('axc-00816',g_dlang),cl_getmsg('axc-00807',g_dlang)
          CALL cl_progress_no_window_ing(g_progress_msg)
       END IF       
       IF NOT axcp801_get_xmda('3') THEN
          LET r_success = FALSE
          RETURN r_success
       END IF
       #存貨類別-3.原料-預先訂單抓取
       IF g_bgjob <> "Y" THEN          
          LET g_progress_msg = cl_getmsg('axc-00816',g_dlang),cl_getmsg('axc-00808',g_dlang)
          CALL cl_progress_no_window_ing(g_progress_msg)
       END IF      
       IF NOT axcp801_get_order_xmda('3') THEN
          LET r_success = FALSE
          RETURN r_success
       END IF        
        
   END CASE
   #處理BOM逆推(半成品、原料)
   IF g_bgjob <> "Y" THEN      
      LET g_progress_msg = cl_getmsg('axc-00812',g_dlang)
      CALL cl_progress_no_window_ing(g_progress_msg)
   END IF     
   IF NOT axcp801_ins_xcfi() THEN
      LET r_success = FALSE
      RETURN r_success 
   END IF   
   
   IF g_master.xcfa007 = '2' THEN #淨變現單價為0，再做一次取價          
       #存貨類別-3.原料-應付帳款抓取
       IF g_bgjob <> "Y" THEN          
          LET g_progress_msg = cl_getmsg('axc-00816',g_dlang),cl_getmsg('axc-00810',g_dlang)
          CALL cl_progress_no_window_ing(g_progress_msg)
       END IF       
       IF NOT axcp801_get_apca('3') THEN
          LET r_success = FALSE
          RETURN r_success
       END IF   
       
       #存貨類別-3.原料-採購單抓取
       IF g_bgjob <> "Y" THEN          
          LET g_progress_msg = cl_getmsg('axc-00816',g_dlang),cl_getmsg('axc-00811',g_dlang)
          CALL cl_progress_no_window_ing(g_progress_msg)
       END IF        
       IF NOT axcp801_get_pmdl('3') THEN
          LET r_success = FALSE
          RETURN r_success
       END IF 
       
       #存貨類別-3.原料-成本價抓取
       IF g_bgjob <> "Y" THEN          
          LET g_progress_msg = cl_getmsg('axc-00816',g_dlang),cl_getmsg('axc-00809',g_dlang)
          CALL cl_progress_no_window_ing(g_progress_msg)
       END IF              
       IF NOT axcp801_get_cost('3') THEN
          LET r_success = FALSE
          RETURN r_success
       END IF       
   END IF
   
   RETURN r_success 
   
END FUNCTION
################################################################################
# Descriptions...: CREAT TABLE
# Memo...........:
# Usage..........: CALL axcp801_create_tmp_table()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success TRUE/FALSE
# Date & Author..: #161108-00037#1 By 02040
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp801_create_tmp_table()
   DEFINE r_success LIKE type_t.num5
   
   
      LET r_success = TRUE
      
      IF g_bgjob <> "Y" THEN
         #建立临时表
         LET g_progress_msg = cl_getmsg('axc-00656',g_dlang)
         CALL cl_progress_no_window_ing(g_progress_msg)
      END IF      
      
      CREATE TEMP TABLE xcfg_tmp(
          xcfgent  LIKE xcfg_t.xcfgent,
          xcfgcomp LIKE xcfg_t.xcfgcomp,
          xcfgld   LIKE xcfg_t.xcfgld,
          xcfg001  LIKE xcfg_t.xcfg001,
          xcfg002  LIKE xcfg_t.xcfg002,
          xcfg003  LIKE xcfg_t.xcfg003,
          xcfg004  LIKE xcfg_t.xcfg004,
          xcfg005  LIKE xcfg_t.xcfg005,
          xcfg006  LIKE xcfg_t.xcfg006,
          xcfg007  LIKE xcfg_t.xcfg007,
          xcfg008  LIKE xcfg_t.xcfg008,
          xcfg010  LIKE xcfg_t.xcfg010,
          xcfg011  LIKE xcfg_t.xcfg011,
          xcfg012  LIKE xcfg_t.xcfg012,
          xcfg013  LIKE xcfg_t.xcfg013,
          xcfg014  LIKE xcfg_t.xcfg014,
          xcfg015  LIKE xcfg_t.xcfg015,
          xcfg016  LIKE xcfg_t.xcfg016,
          xcfg017  LIKE xcfg_t.xcfg017,
          xcfg018  LIKE xcfg_t.xcfg018,          
          xcfg019  LIKE xcfg_t.xcfg019,
          xcfg020  LIKE xcfg_t.xcfg020,
          xcfg021  LIKE xcfg_t.xcfg021,
          xcfg022  LIKE xcfg_t.xcfg022,
          xcfg023  LIKE xcfg_t.xcfg023,
          xcfg024  LIKE xcfg_t.xcfg024,
          xcfg025  LIKE xcfg_t.xcfg025,
          xcfg026  LIKE xcfg_t.xcfg026,
          xcfg027  LIKE xcfg_t.xcfg027,
          xcfg028  LIKE xcfg_t.xcfg028,
          xcfg029  LIKE xcfg_t.xcfg029,
          xcfg030  LIKE xcfg_t.xcfg030,
          clevel   LIKE xcbb_t.xcbb006)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'create xcfg_tmp'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF


      CREATE TEMP TABLE xcfh_tmp(
          xcfhent  LIKE xcfh_t.xcfhent ,
          xcfhcomp LIKE xcfh_t.xcfhcomp,
          xcfhld   LIKE xcfh_t.xcfhld  ,
          xcfh001  LIKE xcfh_t.xcfh001 ,
          xcfh002  LIKE xcfh_t.xcfh002 ,
          xcfh003  LIKE xcfh_t.xcfh003 ,
          xcfh004  LIKE xcfh_t.xcfh004 ,
          xcfh005  LIKE xcfh_t.xcfh005 ,
          xcfh006  LIKE xcfh_t.xcfh006 ,
          xcfh007  LIKE xcfh_t.xcfh007 ,
          xcfh008  LIKE xcfh_t.xcfh008 ,
          xcfh009  LIKE xcfh_t.xcfh009 ,
          xcfhseq  LIKE xcfh_t.xcfhseq ,          
          xcfh010  LIKE xcfh_t.xcfh010 ,
          xcfh011  LIKE xcfh_t.xcfh011 ,
          xcfh012  LIKE xcfh_t.xcfh012 ,
          xcfh013  LIKE xcfh_t.xcfh013 ,
          xcfh014  LIKE xcfh_t.xcfh014 ,
          xcfh015  LIKE xcfh_t.xcfh015 ,
          xcfh016  LIKE xcfh_t.xcfh016 ,
          xcfh017  LIKE xcfh_t.xcfh017 ,
          xcfh018  LIKE xcfh_t.xcfh018 ,
          xcfh019  LIKE xcfh_t.xcfh019 ,
          xcfh020  LIKE xcfh_t.xcfh020 ,
          xcfh021  LIKE xcfh_t.xcfh021 ,
          xcfh022  LIKE xcfh_t.xcfh022 ,
          xcfh023  LIKE xcfh_t.xcfh023 )
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'create xcfh_tmp'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF


      CREATE TEMP TABLE xcfi_tmp(
         xcfient  LIKE xcfi_t.xcfient ,
         xcficomp LIKE xcfi_t.xcficomp,
         xcfild   LIKE xcfi_t.xcfild  ,
         xcfi001  LIKE xcfi_t.xcfi001 ,
         xcfi002  LIKE xcfi_t.xcfi002 ,
         xcfi003  LIKE xcfi_t.xcfi003 ,
         xcfi004  LIKE xcfi_t.xcfi004 ,
         xcfi005  LIKE xcfi_t.xcfi005 ,
         xcfi006  LIKE xcfi_t.xcfi006 ,
         xcfi007  LIKE xcfi_t.xcfi007 ,
         xcfi008  LIKE xcfi_t.xcfi008 ,
         xcfi009  LIKE xcfi_t.xcfi009 ,
         xcfi010  LIKE xcfi_t.xcfi010 ,
         xcfi011  LIKE xcfi_t.xcfi011 ,
         xcfi012  LIKE xcfi_t.xcfi012 ,
         xcfi013  LIKE xcfi_t.xcfi013 ,
         xcfi014  LIKE xcfi_t.xcfi014 ,
         xcfi015  LIKE xcfi_t.xcfi015) 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'create xcfi_tmp'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      CREATE TEMP TABLE xcfn_tmp(
          xcfnent  LIKE xcfn_t.xcfnent,
          xcfncomp LIKE xcfn_t.xcfncomp,
          xcfnld   LIKE xcfn_t.xcfnld,
          xcfn001  LIKE xcfn_t.xcfn001,
          xcfn002  LIKE xcfn_t.xcfn002,
          xcfn003  LIKE xcfn_t.xcfn003,
          xcfn004  LIKE xcfn_t.xcfn004,
          xcfn005  LIKE xcfn_t.xcfn005,
          xcfn006  LIKE xcfn_t.xcfn006,
          xcfn007  LIKE xcfn_t.xcfn007,
          xcfn008  LIKE xcfn_t.xcfn008,
          xcfn009  LIKE xcfn_t.xcfn009,          
          xcfn010  LIKE xcfn_t.xcfn010,
          xcfn011  LIKE xcfn_t.xcfn011,
          xcfn012  LIKE xcfn_t.xcfn012,
          xcfn013  LIKE xcfn_t.xcfn013,
          xcfn014  LIKE xcfn_t.xcfn014,
          xcfn015  LIKE xcfn_t.xcfn015,
          xcfn016  LIKE xcfn_t.xcfn016,
          xcfn017  LIKE xcfn_t.xcfn017,
          xcfn018  LIKE xcfn_t.xcfn018,          
          xcfn019  LIKE xcfn_t.xcfn019,
          xcfn020  LIKE xcfn_t.xcfn020,
          xcfn021  LIKE xcfn_t.xcfn021,
          xcfn022  LIKE xcfn_t.xcfn022,
          xcfn023  LIKE xcfn_t.xcfn023)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'create xcfn_tmp'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      CREATE TEMP TABLE xccc_tmp(      
          xcccent  LIKE xccc_t.xcccent ,
          xccccomp LIKE xccc_t.xccccomp,
          xcccld   LIKE xccc_t.xcccld  ,
          xccc001  LIKE xccc_t.xccc001 ,
          xccc002  LIKE xccc_t.xccc002 ,
          xccc003  LIKE xccc_t.xccc003 ,
          xccc004  LIKE xccc_t.xccc004 ,
          xccc005  LIKE xccc_t.xccc005 ,
          xccc006  LIKE xccc_t.xccc006 ,
          xccc007  LIKE xccc_t.xccc007 ,
          xccc008  LIKE xccc_t.xccc008 ,
          xccc010  LIKE xccc_t.xccc010 ,
          xccc280  LIKE xccc_t.xccc280 ,
          xccc901  LIKE xccc_t.xccc901 ,
          clevel   LIKE xcbb_t.xcbb006 )    #成本階   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'create xccc_tmp'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      #LCM除外倉庫(需做單位轉換)
      CREATE TEMP TABLE inat_tmp(
         inat001 LIKE inat_t.inat001, #料件編號
         inat002 LIKE inat_t.inat002, #產品特徵
         inat007 LIKE inat_t.inat007, #庫存單位
         inat015 LIKE inat_t.inat015, #期末數量
         imag014 LIKE imag_t.imag014, #成本單位
         inaj013 LIKE inaj_t.inaj013) #庫存單位和成本單位換算率
     
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'create inat_tmp'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF   
      
      #應收/訂單/預先訂單/應付/採購單(需做成本單位和交易單位轉換；需做幣別轉換)
      CREATE TEMP TABLE docno_tmp(
        xmdaent    LIKE xmda_t.xmdaent,
        xmdadocdt  LIKE xmda_t.xmdadocdt, #單據日期
        xmdcsite   LIKE xmdc_t.xmdcsite,  
        xmdcdocno  LIKE xmdc_t.xmdcdocno, #單號
        xmdcseq    LIKE xmdc_t.xmdcseq,   #項次
        xmdc001    LIKE xmdc_t.xmdc001,   #料號
        xmdc002    LIKE xmdc_t.xmdc002,   #產品特微
        xmda015    LIKE xmda_t.xmda015,   #交易幣別
        xmdc010    LIKE xmdc_t.xmdc010,   #交易單位
        xmdc011    LIKE xmdc_t.xmdc011,   #交易數量
        xmdc015    LIKE xmdc_t.xmdc015,   #交易單價
        xmdc046    LIKE xmdc_t.xmdc046,   #未稅金額
        xcfg013    LIKE xcfg_t.xcfg013,   #成本幣別
        xcfg012    LIKE xcfg_t.xcfg012,   #成本單位
        rate       LIKE inaj_t.inaj013,   #單位轉換率
        price      LIKE xmdc_t.xmdc015,   #單價
        xcfh002    LIKE xcfh_t.xcfh002,   #成本域
        xcfh008    LIKE xcfh_t.xcfh008,   #批號        
        xcfh009    LIKE xcfh_t.xcfh009)   #取價類別1：應收帳款2.訂單/簽收單3.預先訂單4.應付帳款5.採購單       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'create docno_tmp'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF      
      
      RETURN r_success   
      
END FUNCTION

################################################################################
# Descriptions...: 抓取訂單/簽收訂單
# Memo...........:
# Usage..........: CALL axcp801_get_xmda(p_xcfg010)
#                  RETURNING r_success
# Input parameter: p_xcfg010      存貨類別
# Return code....: r_success      TRUE/FALSE
# Date & Author..: #161108-00037#1 By 02040
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp801_get_xmda(p_xcfg010)
DEFINE p_xcfg010    LIKE xcfg_t.xcfg010
DEFINE r_success    LIKE type_t.num5
DEFINE l_sql        STRING


   LET r_success = TRUE
   
   IF cl_null(p_xcfg010) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'axc-00804'   #傳入存貨類別參數為空
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE   
      LET r_success  = FALSE
      RETURN r_success
   END IF  
   
   DELETE FROM docno_tmp;
   
   #2.一般訂單/簽收訂單        
   LET l_sql = "INSERT INTO docno_tmp ",
   #                     ent,  訂單日期,   site,  單號,    項次,   料號 ，產品特微，交易幣別,  交易單位,交易數量,交易單價 ,未稅金額,
               "SELECT xmdcent,xmdadocdt,xmdcsite,xmdcdocno,xmdcseq,xmdc001,xmdc002,xmda015,xmdc010,xmdc011,xmdc015,xmdc046,",
               #       成本幣別,成本單位,單位換算率,                                       單價,成本域,批號,  取價類別：2訂單/簽收單
               "       xcfg013,xcfg012,CASE WHEN xmdc010 = xcfg012 THEN 1 ELSE 0 END rate,0,xcfg002,xcfg008,'2' ",
               "  FROM xcfg_tmp,xmda_t,xmdc_t ",
               " WHERE xcfgent = xmdcent AND xcfg006 = xmdc001 AND xcfg007 = xmdc002 ",
               "   AND xmdaent = xmdcent AND xmdadocno = xmdcdocno ",
               "   AND xmdaent = ",g_enterprise,
               "   AND xmdasite IN (SELECT DISTINCT ooef001 FROM ooef_t WHERE ooefent = xcfgent AND ooef017 = xcfgcomp AND ooef201 ='Y' AND ooefstus = 'Y') ",
               "   AND xmdadocdt BETWEEN '",g_master.bdate,"' AND '",g_master.edate,"'",
               "   AND xmda005 IN ('1','3') AND xmdastus IN ('Y','C') ",   #一般訂單、簽收單            
               "   AND xmdc015 > 0 AND xmdc011 > 0 AND xmdc046 > 0 ",      #單價、數量>0
               "   AND xcfg010 = ? AND xcfg028 IS NULL  "
               
      PREPARE axcp801_ins_xmda_tbl FROM l_sql
      EXECUTE axcp801_ins_xmda_tbl USING p_xcfg010
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'INSERT xmda_tmp'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      IF SQLCA.sqlerrd[3] > 0 THEN
         IF NOT axcp801_ins_xcfh('2') THEN #訂單
            LET r_success = FALSE
            RETURN r_success
         END IF
      END IF   
      FREE axcp801_ins_xmda_tbl  
      RETURN r_success  

END FUNCTION

################################################################################
# Descriptions...: INS_xcfh
# Memo...........:
# Usage..........: CALL axcp801_ins_xcfh(p_type)
#                  RETURNING r_success
# Input parameter: p_type 1：應收帳款2：訂單3：預先訂單4：應付帳款5：採購單
# Return code....: r_success  TRUE/FALSE
# Date & Author..: 161108-00037#1 By 02040
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp801_ins_xcfh(p_type)
DEFINE p_type       LIKE type_t.num5
DEFINE l_xmdadocdt  LIKE xmda_t.xmdadocdt
DEFINE l_xmda015    LIKE xmda_t.xmda015
DEFINE l_xmdc001    LIKE xmdc_t.xmdc001
DEFINE l_xmdc010    LIKE xmdc_t.xmdc010
DEFINE l_xmdc046    LIKE xmdc_t.xmdc046
DEFINE l_xcfg012    LIKE xcfg_t.xcfg012
DEFINE l_xcfg013    LIKE xcfg_t.xcfg013
DEFINE l_rate       LIKE inaj_t.inaj013   #單位轉換率
DEFINE l_amt        LIKE xmdc_t.xmdc046 
DEFINE l_success    LIKE type_t.num5
DEFINE l_sql        STRING
DEFINE l_xcfh    RECORD
          xcfhent  LIKE xcfh_t.xcfhent ,
          xcfhcomp LIKE xcfh_t.xcfhcomp,
          xcfhld   LIKE xcfh_t.xcfhld  ,
          xcfhseq  LIKE xcfh_t.xcfhseq ,
          xcfh001  LIKE xcfh_t.xcfh001 ,
          xcfh002  LIKE xcfh_t.xcfh002 ,
          xcfh003  LIKE xcfh_t.xcfh003 ,
          xcfh004  LIKE xcfh_t.xcfh004 ,
          xcfh005  LIKE xcfh_t.xcfh005 ,
          xcfh006  LIKE xcfh_t.xcfh006 ,
          xcfh007  LIKE xcfh_t.xcfh007 ,
          xcfh008  LIKE xcfh_t.xcfh008 ,
          xcfh009  LIKE xcfh_t.xcfh009 ,
          xcfh010  LIKE xcfh_t.xcfh010 ,
          xcfh011  LIKE xcfh_t.xcfh011 ,
          xcfh012  LIKE xcfh_t.xcfh012 ,
          xcfh013  LIKE xcfh_t.xcfh013 ,
          xcfh014  LIKE xcfh_t.xcfh014 ,
          xcfh015  LIKE xcfh_t.xcfh015 ,
          xcfh016  LIKE xcfh_t.xcfh016 ,
          xcfh017  LIKE xcfh_t.xcfh017 ,
          xcfh018  LIKE xcfh_t.xcfh018 ,
          xcfh019  LIKE xcfh_t.xcfh019 ,
          xcfh020  LIKE xcfh_t.xcfh020 ,
          xcfh021  LIKE xcfh_t.xcfh021 ,
          xcfh022  LIKE xcfh_t.xcfh022 ,
          xcfh023  LIKE xcfh_t.xcfh023
                 END RECORD
DEFINE r_success    LIKE type_t.num5
DEFINE ls_msg     STRING
      
   LET r_success = TRUE  

    
   LET l_sql = "SELECT DISTINCT xmdc001,xmdc010,xcfg012 ",
               "  FROM docno_tmp ",
               " WHERE rate = 0 "
   PREPARE axcp801_rate_p1 FROM l_sql
   DECLARE axcp801_rate_c1 CURSOR FOR axcp801_rate_p1
   
   #單位轉換
   FOREACH axcp801_rate_c1 INTO l_xmdc001,l_xmdc010,l_xcfg012             
     CALL s_aimi190_get_convert(l_xmdc001,l_xmdc010,l_xcfg012)
       RETURNING l_success,l_rate 
     IF cl_null(l_rate) THEN LET l_rate = 1 END IF  
     
     UPDATE docno_tmp
        SET rate = l_rate        
      WHERE xmdc001 = l_xmdc001
        AND xmdc010 = l_xmdc010
        AND xcfg012 = l_xcfg012 
        AND rate = 0
        
     IF SQLCA.sqlcode THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = SQLCA.sqlcode
        LET g_errparam.extend = 'UPDATE docno_tmp xmdc011'
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET r_success = FALSE
        RETURN r_success
     END IF          
   END FOREACH 
   
   #幣別轉換
   LET l_sql = "SELECT DISTINCT xmdadocdt,xmda015,xmdc046,xcfg013 ",
               "  FROM docno_tmp ",
               " WHERE xmda015 <> xcfg013 "
   PREPARE axcp801_rate_p2 FROM l_sql
   DECLARE axcp801_rate_c2 CURSOR FOR axcp801_rate_p2
   
   
   #匯率
   FOREACH axcp801_rate_c2 INTO l_xmdadocdt,l_xmda015,l_xmdc046,l_xcfg013           
     CALL s_aooi160_get_exrate('2',g_master.xcccld,l_xmdadocdt,l_xmda015,l_xcfg013,l_xmdc046,g_glaa025) RETURNING l_amt
     UPDATE docno_tmp
        SET xmdc046 = l_amt
      WHERE xmdadocdt = l_xmdadocdt
        AND xmdc001 = l_xmdc001
        AND xmdc010 = l_xmdc010
        AND xcfg012 = l_xcfg012 
        
     IF SQLCA.sqlcode THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = SQLCA.sqlcode
        LET g_errparam.extend = 'UPDATE docno_tmp xmdc046'
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET r_success = FALSE
        RETURN r_success
     END IF        
     
   END FOREACH 
   #未稅金額/數量 = 單價
   UPDATE docno_tmp
      SET price = xmdc046 /(xmdc011 * rate)
    WHERE rate > 0 

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'UPDATE docno_tmp price'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF 
   
   CASE g_master.xcfa008
     WHEN '1'  #最高
       LET l_sql = "MERGE INTO xcfg_tmp ",
                   "USING (SELECT DISTINCT  xmdaent,xmdadocdt,xmdcdocno,xmdcseq,xmdc001,xmdc002,price,xcfh002,xcfh008 ",
                   "        FROM( ",
                   "              SELECT xmdaent,xmdadocdt,xmdcdocno,xmdcseq,xmdc001,xmdc002,price,xcfh002,xcfh008,",
                   #                                                    成本域  料號   產品特微   批號
                   "                     ROW_NUMBER() OVER(PARTITION BY xcfh002,xmdc001,xmdc002,xcfh008 order by price DESC) as rank ",
                   "                FROM docno_tmp ",
                   "             )",
                   "        WHERE rank = 1 )",
                   "   ON (xcfgent = xmdaent AND xcfg002 = xcfh002 AND xcfg006 = xmdc001 AND xcfg007 = xmdc002 AND xcfg008 = xcfh008)",
                   " WHEN MATCHED THEN   ",
                   " UPDATE SET xcfg016 = price, ",
                   "            xcfg019 = price, ",
                   "            xcfg020 = price, ",
                   "            xcfg028 = xmdcdocno ,",
                   "            xcfg029 = xmdcseq ,",
                   "            xcfg030 = xmdadocdt ",
                   "  WHERE xcfg028 IS NULL "     
     WHEN '2'  #最低
       LET l_sql = "MERGE INTO xcfg_tmp ",
                   "USING (SELECT DISTINCT  xmdaent,xmdadocdt,xmdcdocno,xmdcseq,xmdc001,xmdc002,price,xcfh002,xcfh008 ",
                   "        FROM( ",
                   "              SELECT xmdaent,xmdadocdt,xmdcdocno,xmdcseq,xmdc001,xmdc002,price,xcfh002,xcfh008,",
                   #                                                    成本域  料號   產品特微   批號
                   "                     ROW_NUMBER() OVER(PARTITION BY xcfh002,xmdc001,xmdc002,xcfh008 order by price) as rank ",
                   "                FROM docno_tmp ",
                   "             )",
                   "        WHERE rank = 1 )",
                   "   ON (xcfgent = xmdaent AND xcfg002 = xcfh002 AND xcfg006 = xmdc001 AND xcfg007 = xmdc002 AND xcfg008 = xcfh008)",
                   " WHEN MATCHED THEN   ",
                   " UPDATE SET xcfg016 = price, ",
                   "            xcfg019 = price, ",
                   "            xcfg020 = price, ",
                   "            xcfg028 = xmdcdocno ,",
                   "            xcfg029 = xmdcseq ,",
                   "            xcfg030 = xmdadocdt ",
                   "  WHERE xcfg028 IS NULL "
     WHEN '3'  #平均
       CALL cl_getmsg('agl-00491',g_lang) RETURNING ls_msg  #人工市價
       IF cl_null(ls_msg) THEN
          LET ls_msg = 'agl-00491'
       END IF          
       LET l_sql = "MERGE INTO xcfg_tmp ",
                   #                                                                                            
                   "USING (SELECT DISTINCT xmdaent,xcfh002,xmdc001,xmdc002,xcfh008, ",
                   #                  金額/數量                   成本域  料號   產品特微   批號
                   "              SUM(xmdc046) OVER(PARTITION BY xcfh002,xmdc001,xmdc002,xcfh008)/SUM(xmdc011) OVER(PARTITION BY xcfh002,xmdc001,xmdc002,xcfh008) price ",                   
                   "         FROM docno_tmp )",
                   "   ON (xcfgent = xmdaent AND xcfg002 = xcfh002 AND xcfg006 = xmdc001 AND xcfg007 = xmdc002 AND xcfg008 = xcfh008)",
                   " WHEN MATCHED THEN   ",
                   " UPDATE SET xcfg016 = price, ",
                   "            xcfg019 = price, ",
                   "            xcfg020 = price, ",
                   "            xcfg028 = '",ls_msg,"' ,",   #平均值
                   "            xcfg029 = '', ",
                   "            xcfg030 = '' ",
                   "  WHERE xcfg028 IS NULL "             
   END CASE
   PREPARE axcp801_rate_p3 FROM l_sql
   EXECUTE axcp801_rate_p3
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'UPDATE xcfg_tmp xcfg016'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   FREE axcp801_rate_p3     

   #採平均值，需寫入xcfh_t
   IF g_master.xcfa008 = '3' THEN
      LET l_sql = "INSERT INTO xcfh_tmp",
                  #              xcfhent ,xcfhcomp,xcfhld
                  "       SELECT ",g_enterprise,",'",g_master.xccccomp,"','",g_master.xcccld,"',",
                  #              xcfh001,xcfh002,xcfh003,xcfh004,xcfh005
                  "              '",g_master.xccc001,"',xcfh002,'",g_master.xccc003,"','",g_master.xccc004,"','",g_master.xccc005,"',",
                  #              xcfh006,xcfh007,xcfh008,xcfh009 
                  "              xmdc001 ,xmdc002 ,xcfh008,xcfh009, ",
                  #              xcfhseq
                  "              ROW_NUMBER() OVER(PARTITION BY xcfh002,xmdc001,xmdc002,xcfh008,xcfh009 order by xmdcdocno,xmdcseq) as xcfhseq, ",
                  #              xcfh010,xcfh011,xcfh012,xcfh013,xcfh014,xcfh015
                  "              xmdcdocno ,xmdcseq ,xmdcsite ,xmdadocdt ,xmdc011 ,xcfg012 , ",
                  #              xcfh016,xcfh017,xcfh018,xcfh019,xcfh020,xcfh21,xcfh022,xcfh023
                  "              rate ,xmda015 ,xmdc011 ,xmdc015 ,xmdc046,'', '",g_master.bdate,"','",g_master.edate,"'",
                  "         FROM docno_tmp "
       PREPARE axcp801_ins_xcfh_p FROM l_sql
       EXECUTE axcp801_ins_xcfh_p
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'INSERT INTO xmfh_tmp'
          LET g_errparam.popup = TRUE
          CALL cl_err()
          LET r_success = FALSE
          RETURN r_success
       END IF  
   END IF

   RETURN r_success
   
END FUNCTION
################################################################################
# Descriptions...: 抓取預先訂單
# Memo...........:
# Usage..........: CALL axcp801_get_order_xmda(p_xcfg010)
#                  RETURNING r_success
# Input parameter: p_xcfg010      存貨類別
# Return code....: r_success      TRUE/FALSE
# Date & Author..: #161108-00037#1 By 02040
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp801_get_order_xmda(p_xcfg010)
DEFINE p_xcfg010    LIKE xcfg_t.xcfg010
DEFINE r_success    LIKE type_t.num5
DEFINE l_sql        STRING


   LET r_success = TRUE
   
   IF cl_null(p_xcfg010) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'axc-00804'   #傳入存貨類別參數為空
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE   
      LET r_success  = FALSE
      RETURN r_success
   END IF 
   
   DELETE FROM docno_tmp;
   
   #3.預先訂單        
   LET l_sql = "INSERT INTO docno_tmp ",
   #                     ent,  訂單日期,   site,  單號,    項次,   料號 ，產品特微，交易幣別,  交易單位,交易數量,交易單價 ,未稅金額,
               "SELECT xmdcent,xmdadocdt,xmdcsite,xmdcdocno,xmdcseq,xmdc001,xmdc002,xmda015,xmdc010,xmdc011,xmdc015,xmdc046,",
               #       成本幣別,成本單位,單位換算率,                                      單價 成本域,   批號,  取價類別：3預先訂單
               "       xcfg013,xcfg012,CASE WHEN xmdc010 = xcfg012 THEN 1 ELSE 0 END rate,0,xcfg002,xcfg008,'3' ",
               "  FROM xcfg_tmp,xmda_t,xmdc_t ",
               " WHERE xcfgent = xmdcent AND xcfg006 = xmdc001 AND xcfg007 = xmdc002 ",
               "   AND xmdaent = xmdcent AND xmdadocno = xmdcdocno ",
               "   AND xmdaent = ",g_enterprise,
               "   AND xmdasite IN (SELECT DISTINCT ooef001 FROM ooef_t WHERE ooefent = xcfgent AND ooef017 = xcfgcomp AND ooef201 ='Y' AND ooefstus = 'Y') ",
               "   AND xmdadocdt BETWEEN '",g_master.bdate,"' AND '",g_master.edate,"'",
               "   AND xmda005 ='2' AND xmdastus IN ('Y','C') ",        #2.預先訂單               
               "   AND xmdc015 > 0 AND xmdc011 > 0 AND xmdc046 > 0 ",   #單價、數量>0
               "   AND xcfg010 = ? AND xcfg028 IS NULL  "
               
      PREPARE axcp801_ins_order_xmda_tb1 FROM l_sql
      EXECUTE axcp801_ins_order_xmda_tb1 USING p_xcfg010
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'INSERT xmda_tmp'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      IF SQLCA.sqlerrd[3] > 0 THEN
         IF NOT axcp801_ins_xcfh('3') THEN #預先訂單
            LET r_success = FALSE
            RETURN r_success
         END IF
      END IF   
      FREE axcp801_ins_order_xmda_tb1  
      RETURN r_success  

END FUNCTION
################################################################################
# Descriptions...: 抓取應收帳款
# Memo...........:
# Usage..........: CALL axcp801_get_xrca(p_xcfg010)
#                  RETURNING r_success
# Input parameter: p_xcfg010      存貨類別
# Return code....: r_success      TRUE/FALSE
# Date & Author..: #161108-00037#1 By 02040
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp801_get_xrca(p_xcfg010)
DEFINE p_xcfg010    LIKE xcfg_t.xcfg010
DEFINE r_success    LIKE type_t.num5
DEFINE l_sql        STRING

   LET r_success = TRUE
   
   IF cl_null(p_xcfg010) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'axc-00804'   #傳入存貨類別參數為空
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE   
      LET r_success  = FALSE
      RETURN r_success
   END IF 
   
   DELETE FROM docno_tmp;
   
   #1.應收帳款
   LET l_sql = "INSERT INTO docno_tmp ",
   #                     ent,  訂單日期,   site,  單號,    項次,   料號 ，產品特微，交易幣別,  交易單位,交易數量,交易單價 ,未稅金額,
               "SELECT xrcbent,xrcadocdt,xrcasite,xrcbdocno,xrcbseq,xrcb004,xrcb005,xrcb100,xrcb006,xrcb007,xrcb101,xrcb103,",
               #       成本幣別,成本單位, 單位換算率,                                     單價, 成本域, 批號,  取價類別：1應收帳款
               "       xcfg013,xcfg012,CASE WHEN xrcb006 = xcfg012 THEN 1 ELSE 0 END rate,0,xcfg002,xcfg008,'1' ",
               "  FROM xcfg_tmp,xrca_t,xrcb_t ",
               " WHERE xcfgent = xrcbent AND xcfg006 = xrcb004 AND xcfg007 = xrcb005 ",
               "   AND xrcaent = xrcbent AND xrcald = xrcbld AND xrcadocno = xrcbdocno ",
               "   AND xrcaent = ",g_enterprise,
               "   AND xrcacomp = '",g_master.xccccomp,"' AND xrcald = '",g_master.xcccld,"'",
               "   AND xrcadocdt BETWEEN '",g_master.bdate,"' AND '",g_master.edate,"'",
               "   AND xrcastus = 'Y' ",               
               "   AND xrcb101 > 0 AND xrcb103 > 0 ",   #單價、金額 >0
               "   AND xcfg010 = ? AND xcfg028 IS NULL  "
               
      PREPARE axcp801_ins_xrca_tbl FROM l_sql
      EXECUTE axcp801_ins_xrca_tbl USING p_xcfg010
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'INSERT xrca_tmp'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      IF SQLCA.sqlerrd[3] > 0 THEN
         IF NOT axcp801_ins_xcfh('1') THEN #應收
            LET r_success = FALSE
            RETURN r_success
         END IF
      END IF   
      FREE axcp801_ins_xrca_tbl  
      RETURN r_success  
END FUNCTION
################################################################################
# Descriptions...: 抓取應付帳款
# Memo...........:
# Usage..........: CALL axcp801_get_apca(p_xcfg010)
#                  RETURNING r_success
# Input parameter: p_xcfg010      存貨類別
# Return code....: r_success      TRUE/FALSE
# Date & Author..: #161108-00037#1 By 02040
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp801_get_apca(p_xcfg010)
DEFINE p_xcfg010    LIKE xcfg_t.xcfg010
DEFINE r_success    LIKE type_t.num5
DEFINE l_sql        STRING

   LET r_success = TRUE
   
   IF cl_null(p_xcfg010) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'axc-00804'   #傳入存貨類別參數為空
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE   
      LET r_success  = FALSE
      RETURN r_success
   END IF 
   
   DELETE FROM docno_tmp;
   
   #4應付帳款
   LET l_sql = "INSERT INTO docno_tmp ",
   #                     ent,  訂單日期,   site,  單號,    項次,   料號 ，產品特微，交易幣別,  交易單位,交易數量,交易單價 ,未稅金額,
               "SELECT apcbent,apcadocdt,apcasite,apcbdocno,apcbseq,apcb004,apcb005,apcb100,apcb006,apcb007,apcb101,apcb103,",
               #       成本幣別,成本單位, 單位換算率,                                     單價,成本域, 批號,    取價類別：4應付帳款
               "       xcfg013,xcfg012,CASE WHEN apcb006 = xcfg012 THEN 1 ELSE 0 END rate,0,xcfg002,xcfg008,'4' ",
               "  FROM xcfg_tmp,apca_t,apcb_t ",
               " WHERE xcfgent = apcbent AND xcfg006 = apcb004 AND xcfg007 = apcb005 ",
               "   AND apcaent = apcbent AND apcald = apcbld AND apcadocno = apcbdocno ",
               "   AND apcaent = ",g_enterprise,
               "   AND apcacomp = '",g_master.xccccomp,"' AND apcald = '",g_master.xcccld,"'",
               "   AND apcadocdt BETWEEN '",g_master.bdate,"' AND '",g_master.edate,"'",
               "   AND apcastus = 'Y' ",               
               "   AND apcb101 > 0 AND apcb103 > 0 ",   #單價、金額 >0
               "   AND xcfg010 = ? AND xcfg028 IS NULL  ",
               #排除委外收貨單
               "   AND NOT EXISTS (SELECT 1 FROM pmds_t ",
               "                    WHERE pmdsent = apcbent AND apcb002 = pmdsdocno ",
               "                      AND pmds011 = '2')"
               
      PREPARE axcp801_ins_apca_tbl FROM l_sql
      EXECUTE axcp801_ins_apca_tbl USING p_xcfg010
      
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'INSERT apca_tmp'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      IF SQLCA.sqlerrd[3] > 0 THEN
         IF NOT axcp801_ins_xcfh('4') THEN #應付
            LET r_success = FALSE
            RETURN r_success
         END IF
      END IF   
      FREE axcp801_ins_apca_tbl  
      RETURN r_success  
END FUNCTION
################################################################################
# Descriptions...: 抓取採購單
# Memo...........:
# Usage..........: CALL axcp801_get_pmdl(p_xcfg010)
#                  RETURNING r_success
# Input parameter: p_xcfg010      存貨類別
# Return code....: r_success      TRUE/FALSE
# Date & Author..: #161108-00037#1 By 02040
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp801_get_pmdl(p_xcfg010)
DEFINE p_xcfg010    LIKE xcfg_t.xcfg010
DEFINE r_success    LIKE type_t.num5
DEFINE l_sql        STRING


   LET r_success = TRUE
   
   IF cl_null(p_xcfg010) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'axc-00804'   #傳入存貨類別參數為空
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE   
      LET r_success  = FALSE
      RETURN r_success
   END IF  
   
   DELETE FROM docno_tmp;
   
   #5.採購單        
   LET l_sql = "INSERT INTO docno_tmp ",
   #                     ent,  訂單日期,   site,  單號,    項次,   料號 ，產品特微，交易幣別,  交易單位,交易數量,交易單價 ,未稅金額,
               "SELECT pmdnent,pmdldocdt,pmdnsite,pmdndocno,pmdnseq,pmdn001,pmdn002,pmdl015,pmdn010,pmdn011,pmdn015,pmdn046,",
               #       成本幣別,成本單位, 單位換算率,                                     單價,成本域, 批號,    取價類別：5採購單
               "       xcfg013,xcfg012,CASE WHEN pmdn010 = xcfg012 THEN 1 ELSE 0 END rate,0,xcfg002,xcfg008,'5' ",
               "  FROM xcfg_tmp,pmdl_t,pmdn_t ",
               " WHERE xcfgent = pmdnent AND xcfg006 = pmdn001 AND xcfg007 = pmdn002 ",
               "   AND pmdlent = pmdnent AND pmdldocno = pmdndocno ",
               "   AND pmdlent = ",g_enterprise,
               "   AND pmdlsite IN (SELECT DISTINCT ooef001 FROM ooef_t WHERE ooefent = xcfgent AND ooef017 = xcfgcomp AND ooef201 ='Y' AND ooefstus = 'Y') ",
               "   AND pmdldocdt BETWEEN '",g_master.bdate,"' AND '",g_master.edate,"'",
               "   AND pmdl005 = '1' AND pmdlstus IN ('Y','C') ",               
               "   AND pmdn015 > 0 AND pmdn046 > 0 ",   #單價、金額>0
               "   AND xcfg010 = ? AND xcfg028 IS NULL  "
               
      PREPARE axcp801_ins_pmdl_tbl FROM l_sql
      EXECUTE axcp801_ins_pmdl_tbl USING p_xcfg010
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'INSERT pmdl_tmp'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      IF SQLCA.sqlerrd[3] > 0 THEN
         IF NOT axcp801_ins_xcfh('5') THEN  #採購單
            LET r_success = FALSE
            RETURN r_success
         END IF
      END IF   
      FREE axcp801_ins_pmdl_tbl  
      RETURN r_success  
END FUNCTION

################################################################################
# Descriptions...: INS xcfn_t
# Memo...........:
# Usage..........: CALL axcp801_ins_xcfn()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success  TRUE/FALSE
# Date & Author..: 161108-00037#1 By 02040
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp801_ins_xcfn()
DEFINE r_success  LIKE type_t.num5
DEFINE l_xcfn RECORD
          xcfnent  LIKE xcfn_t.xcfnent,
          xcfncomp LIKE xcfn_t.xcfncomp,
          xcfnld   LIKE xcfn_t.xcfnld ,
          xcfn001  LIKE xcfn_t.xcfn001,
          xcfn002  LIKE xcfn_t.xcfn002,
          xcfn003  LIKE xcfn_t.xcfn003,
          xcfn004  LIKE xcfn_t.xcfn004,
          xcfn005  LIKE xcfn_t.xcfn005,
          xcfn006  LIKE xcfn_t.xcfn006,
          xcfn007  LIKE xcfn_t.xcfn007,
          xcfn008  LIKE xcfn_t.xcfn008,
          xcfn009  LIKE xcfn_t.xcfn009,
          xcfn010  LIKE xcfn_t.xcfn010,
          xcfn011  LIKE xcfn_t.xcfn011,
          xcfn012  LIKE xcfn_t.xcfn012,
          xcfn013  LIKE xcfn_t.xcfn013,
          xcfn014  LIKE xcfn_t.xcfn014,
          xcfn015  LIKE xcfn_t.xcfn015,
          xcfn016  LIKE xcfn_t.xcfn016,
          xcfn017  LIKE xcfn_t.xcfn017,
          xcfn018  LIKE xcfn_t.xcfn018,
          xcfn019  LIKE xcfn_t.xcfn019,
          xcfn020  LIKE xcfn_t.xcfn020,
          xcfn021  LIKE xcfn_t.xcfn021,
          xcfn022  LIKE xcfn_t.xcfn022,
          xcfn023  LIKE xcfn_t.xcfn023  
    END RECORD
DEFINE l_xcfg010   LIKE xcfg_t.xcfg010 
DEFINE l_xcfg017   LIKE xcfg_t.xcfg017
DEFINE l_xcfg019   LIKE xcfg_t.xcfg019
DEFINE l_xcfg023   LIKE xcfg_t.xcfg023
DEFINE l_xcfg024   LIKE xcfg_t.xcfg024
DEFINE l_xcfg025   LIKE xcfg_t.xcfg025
DEFINE l_xcfg026   LIKE xcfg_t.xcfg026
DEFINE l_xcfg027   LIKE xcfg_t.xcfg027
DEFINE l_xcfg028   LIKE xcfg_t.xcfg028
DEFINE l_xcfg029   LIKE xcfg_t.xcfg029
DEFINE l_xcfi010   LIKE xcfi_t.xcfi010
DEFINE l_xcfi011   LIKE xcfi_t.xcfi011    
DEFINE l_sql STRING
DEFINE l_wc  STRING

   

   LET r_success = TRUE
   
   IF g_bgjob <> "Y" THEN     
      #LCM在制成本处理   
      LET g_progress_msg = cl_getmsg('axc-00813',g_dlang) 
      CALL cl_progress_no_window_ing(g_progress_msg)
   END IF   
   
   LET l_wc = cl_replace_str(g_master.wc,"xccc","xccd")
   
   LET l_sql = "SELECT xccdent,xccdcomp,xccdld,xccd001,xccd002,xccd003,xccd004,xccd005, ",
               "       xccd006,xccd007,xccd008,xccd009,(SELECT imaa006 FROM imaa_t WHERE imaaent =xccdent AND imaa001 = xccd007), ",
               "       xccd901,COALESCE(xccd902,0)/COALESCE(xccd901,1),xccd902 ",
               "  FROM xccd_t LEFT JOIN imaf_t ON xccdent = imafent AND xccdcomp = imafsite  AND xccd006 = imaf001 ",
               "              LEFT JOIN imag_t ON xccdent = imagent AND xccdcomp = imagsite  AND xccd006 = imag001 ",              
               "  WHERE xccdent  = ",g_enterprise,
               "    AND xccdld   = '",g_master.xcccld,"'",
               "    AND xccdcomp = '",g_master.xccccomp,"'",
               "    AND xccd001  = '",g_master.xccc001,"'",
               "    AND xccd003  = '",g_master.xccc003,"'",
               "    AND xccd004  = '",g_master.xccc004,"'",
               "    AND xccd005  = '",g_master.xccc005,"'",
               "    AND xccd901 > 0 ",
               "    AND ",l_wc               
   
   PREPARE axcp801_xccd_p1 FROM l_sql
   DECLARE axcp801_xccd_c1 CURSOR FOR axcp801_xccd_p1    
   
   LET l_sql = "SELECT xcfg010,xcfg017,xcfg019,xcfg023,xcfg024,xcfg025,xcfg026,xcfg027,xcfg028,xcfg029 ",
               "  FROM xcfg_tmp ",
               " WHERE xcfg006 = ? AND xcfg007 = ? AND xcfg008 = ? "
   PREPARE axcp801_get_xcfg_p1 FROM l_sql
   
   LET l_sql = "SELECT xcfi010,xcfi011 FROM xcfi_tmp ",
               " WHERE xcfi006 = ? AND xcfi007 = ? AND xcfi008 = ? "
   PREPARE axcp801_get_xcfi_p1 FROM l_sql
   
   
   LET l_sql = " INSERT INTO xcfn_tmp (xcfnent,xcfncomp,xcfnld ,xcfn001,xcfn002,xcfn003,xcfn004,xcfn005, ",
               "                       xcfn006,xcfn007,xcfn008,xcfn009,xcfn010,xcfn011,xcfn012,xcfn013,xcfn014,xcfn015, ",
               "                       xcfn016,xcfn017,xcfn018,xcfn019,xcfn020,xcfn021,xcfn022,xcfn023) ",
               "         VALUES (?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?) "
   PREPARE axcp801_ins_xcfn_p1 FROM l_sql
   
      
   FOREACH axcp801_xccd_c1 INTO l_xcfn.xcfnent,l_xcfn.xcfncomp,l_xcfn.xcfnld,l_xcfn.xcfn001,l_xcfn.xcfn002,l_xcfn.xcfn003,l_xcfn.xcfn004,l_xcfn.xcfn005,
                                l_xcfn.xcfn006,l_xcfn.xcfn007,l_xcfn.xcfn008,l_xcfn.xcfn009,l_xcfn.xcfn010,
                                l_xcfn.xcfn011,l_xcfn.xcfn012,l_xcfn.xcfn013

       
       EXECUTE axcp801_get_xcfg_p1 USING l_xcfn.xcfn007,l_xcfn.xcfn008,l_xcfn.xcfn009 
          INTO l_xcfg010,l_xcfg017,l_xcfg019,l_xcfg023,l_xcfg024,l_xcfg025,l_xcfg026,l_xcfg027,l_xcfg028,l_xcfg029
       
       LET l_xcfn.xcfn019 = l_xcfg023
       LET l_xcfn.xcfn022 = l_xcfg028
       LET l_xcfn.xcfn023 = l_xcfg029
       IF l_xcfg010 = '2' THEN  #半成品
          LET l_xcfn.xcfn020 = l_xcfn.xcfn007
          IF l_xcfg025 ='AVG' THEN   #平均值
             LET l_xcfn.xcfn021 = l_xcfg027
             
          ELSE                  #成品、原料
             EXECUTE axcp801_get_xcfi_p1 USING l_xcfn.xcfn007,l_xcfn.xcfn008,l_xcfn.xcfn009
                INTO l_xcfi010,l_xcfi011
             LET l_xcfn.xcfn021 = l_xcfi011
             LET l_xcfg024 = l_xcfg017
             LET l_xcfg026 = l_xcfi010
          END IF
          IF l_xcfg026 - (l_xcfn.xcfn012 * l_xcfg024) > 0 THEN 
             LET l_xcfn.xcfn014 = (l_xcfn.xcfn021 - (l_xcfg026 - (l_xcfn.xcfn012 * l_xcfg024))) / l_xcfg024   
          ELSE
             LET l_xcfn.xcfn014 = l_xcfn.xcfn021
          END IF
       ELSE 
          LET l_xcfn.xcfn020 = l_xcfg025
          LET l_xcfn.xcfn021 = l_xcfg019
          IF l_xcfg017 - l_xcfn.xcfn012 > 0 THEN
             LET l_xcfn.xcfn014 = l_xcfn.xcfn021 - (l_xcfg017 - l_xcfn.xcfn012)
          ELSE
             LET l_xcfn.xcfn014 = l_xcfn.xcfn021
          END IF          
       END IF       
       IF cl_null(l_xcfn.xcfn021) OR l_xcfn.xcfn021 = 0 THEN
          LET l_xcfn.xcfn021 = l_xcfg019 
       END IF     
       IF cl_null(l_xcfn.xcfn021) OR l_xcfn.xcfn021 = 0 THEN
          LET l_xcfn.xcfn021 = l_xcfg017 
       END IF 

       LET l_xcfn.xcfn015 = l_xcfn.xcfn014 * l_xcfn.xcfn011
       IF l_xcfn.xcfn013 > l_xcfn.xcfn015 THEN
          LET l_xcfn.xcfn016 = l_xcfn.xcfn015
       ELSE          
          LET l_xcfn.xcfn016 = l_xcfn.xcfn013
       END IF
       IF l_xcfn.xcfn015 > l_xcfn.xcfn013 THEN
          LET l_xcfn.xcfn017 = 0
          LET l_xcfn.xcfn018 = l_xcfn.xcfn015 - l_xcfn.xcfn013
       ELSE
          LET l_xcfn.xcfn017 = l_xcfn.xcfn013 - l_xcfn.xcfn015
          LET l_xcfn.xcfn018 = 0
       END IF
       
       CALL s_num_round(g_round_type,l_xcfn.xcfn012,g_curr.digit1) RETURNING l_xcfn.xcfn012                                          
       CALL s_num_round(g_round_type,l_xcfn.xcfn014,g_curr.digit1) RETURNING l_xcfn.xcfn014 
       CALL s_num_round(g_round_type,l_xcfn.xcfn021,g_curr.digit1) RETURNING l_xcfn.xcfn021        
       CALL s_num_round(g_round_type,l_xcfn.xcfn013,g_curr.digit2) RETURNING l_xcfn.xcfn013  
       CALL s_num_round(g_round_type,l_xcfn.xcfn015,g_curr.digit2) RETURNING l_xcfn.xcfn015  
       CALL s_num_round(g_round_type,l_xcfn.xcfn016,g_curr.digit2) RETURNING l_xcfn.xcfn016
       CALL s_num_round(g_round_type,l_xcfn.xcfn017,g_curr.digit2) RETURNING l_xcfn.xcfn017
       CALL s_num_round(g_round_type,l_xcfn.xcfn018,g_curr.digit2) RETURNING l_xcfn.xcfn018           
       
       EXECUTE axcp801_ins_xcfn_p1 USING l_xcfn.xcfnent,l_xcfn.xcfncomp,l_xcfn.xcfnld,l_xcfn.xcfn001,l_xcfn.xcfn002,l_xcfn.xcfn003,l_xcfn.xcfn004,l_xcfn.xcfn005,
                                         l_xcfn.xcfn006,l_xcfn.xcfn007,l_xcfn.xcfn008,l_xcfn.xcfn009,l_xcfn.xcfn010,l_xcfn.xcfn011,l_xcfn.xcfn012,l_xcfn.xcfn013,l_xcfn.xcfn014,l_xcfn.xcfn015,
                                         l_xcfn.xcfn016,l_xcfn.xcfn017,l_xcfn.xcfn018,l_xcfn.xcfn019,l_xcfn.xcfn020,l_xcfn.xcfn021,l_xcfn.xcfn022,l_xcfn.xcfn023 

       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'INSERT INTO xcfn_t'
          LET g_errparam.popup = TRUE
          CALL cl_err()
          LET r_success = FALSE
          RETURN r_success
       END IF


   END FOREACH
   
   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: 抓取成本價
# Memo...........:
# Usage..........: CALL axcp801_get_cost(p_xcfg010)
#                  RETURNING r_success
# Input parameter: p_xcfg010      存貨類別
# Return code....: r_success      TRUE/FALSE
# Date & Author..: #161108-00037#1 By 02040
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp801_get_cost(p_xcfg010)
DEFINE p_xcfg010    LIKE xcfg_t.xcfg010
DEFINE r_success    LIKE type_t.num5
DEFINE l_sql        STRING

   LET r_success = TRUE
   IF cl_null(p_xcfg010) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'axc-00804'   #傳入存貨類別參數為空
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE   
      LET r_success  = FALSE
      RETURN r_success
   END IF    
   
   #xcfg019淨變現單價：若取到的單價非成本價，需將取到的單價 xcfg019 * (1-xcfg023/100)
   UPDATE xcfg_tmp
      SET xcfg019 = xcfg019 * (1-xcfg023/100)
    WHERE xcfg010 = p_xcfg010
      AND xcfg028 IS NOT NULL 
      AND xcfg028 <> 'BOM'      
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'UPDATE xcfg019'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   IF g_master.xcfa005 = 'Y' THEN
      #取成本價xccc280
      UPDATE xcfg_tmp
         SET xcfg019 = xcfg017   
       WHERE xcfg010 = p_xcfg010
         AND xcfg028 IS NULL
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'UPDATE xcfg019'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF         
   END IF
   
   RETURN r_success  

END FUNCTION
################################################################################
# Descriptions...: INS_xcfi
# Memo...........:
# Usage..........: CALL axcp801_ins_xcfi()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success  TRUE/FALSE
# Date & Author..: 161108-00037#1 By 02040
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp801_ins_xcfi()
DEFINE r_success LIKE type_t.num5          
DEFINE l_sql   STRING
DEFINE l_sql2  STRING
DEFINE l_where STRING
DEFINE sr   RECORD                        
       bmba001   LIKE bmba_t.bmba001, #主件料號
       bmba002   LIKE bmba_t.bmba002, #特性
       bmba003   LIKE bmba_t.bmba003, #元件料號
       xcfi010   LIKE xcfi_t.xcfi010  #QPA
            END RECORD


DEFINE l_xcfi RECORD
         xcfient  LIKE xcfi_t.xcfient ,
         xcficomp LIKE xcfi_t.xcficomp,
         xcfild   LIKE xcfi_t.xcfild  ,
         xcfi001  LIKE xcfi_t.xcfi001 ,
         xcfi002  LIKE xcfi_t.xcfi002 ,
         xcfi003  LIKE xcfi_t.xcfi003 ,
         xcfi004  LIKE xcfi_t.xcfi004 ,
         xcfi005  LIKE xcfi_t.xcfi005 ,
         xcfi006  LIKE xcfi_t.xcfi006 ,
         xcfi007  LIKE xcfi_t.xcfi007 ,
         xcfi008  LIKE xcfi_t.xcfi008 ,
         xcfi009  LIKE xcfi_t.xcfi009 ,
         xcfi010  LIKE xcfi_t.xcfi010 ,
         xcfi011  LIKE xcfi_t.xcfi011 ,
         xcfi012  LIKE xcfi_t.xcfi012 ,
         xcfi013  LIKE xcfi_t.xcfi013 ,
         xcfi014  LIKE xcfi_t.xcfi014 ,
         xcfi015  LIKE xcfi_t.xcfi015
       END RECORD  
DEFINE l_xcfi009  LIKE xcfi_t.xcfi009
DEFINE l_xcfi010  LIKE xcfi_t.xcfi010
DEFINE l_xcfi011  LIKE xcfi_t.xcfi011
DEFINE l_bmba011  LIKE bmba_t.bmba011
DEFINE l_bmba012  LIKE bmba_t.bmba012
DEFINE l_xcfg017  LIKE xcfg_t.xcfg017
DEFINE l_xcfg019  LIKE xcfg_t.xcfg019
DEFINE l_xcfg017_1  LIKE xcfg_t.xcfg017
DEFINE l_xcfg019_1  LIKE xcfg_t.xcfg019
DEFINE l_xcfg024  LIKE xcfg_t.xcfg024
DEFINE l_xcfg026  LIKE xcfg_t.xcfg026
DEFINE l_xcfg027  LIKE xcfg_t.xcfg027
DEFINE l_xcfg024_avg  LIKE xcfg_t.xcfg024
DEFINE l_xcfg026_avg  LIKE xcfg_t.xcfg026
DEFINE l_xcfg027_avg  LIKE xcfg_t.xcfg027
DEFINE l_xcfi012_sum  LIKE xcfi_t.xcfi012
DEFINE l_xcfi013_sum  LIKE xcfi_t.xcfi013
DEFINE l_qpa_sum_in   LIKE xcfi_t.xcfi012   
DEFINE l_qpa_sum_out  LIKE xcfi_t.xcfi013   
DEFINE l_cnt  LIKE type_t.num5

   LET r_success = TRUE
   
   
   LET l_sql = "SELECT DISTINCT bmba001,bmba002,bmba003,COALESCE(bmba011,0)/COALESCE(bmba012,1) ",
               "  FROM bmaa_t,bmba_t ",
               " WHERE bmaaent = bmbaent AND bmaasite = bmbasite ",
               "   AND bmaa001 = bmba001 AND bmaa002 = bmba002 ",
               "   AND bmaastus = 'Y' AND (to_char(bmba005,'yy-mm-dd') <= '",g_today,"') ",
               "   AND ((to_char(bmba006,'yy-mm-dd') >= '",g_today,"')  OR (to_char(bmba006,'yy-mm-dd')) IS NULL) ",
               "   AND bmbaent = ",g_enterprise," AND bmbasite =  'ALL' ",
               "   AND bmba003 = ? " 
 

   PREPARE axcp801_bom_p1 FROM l_sql
   DECLARE axcp801_bom_c1 CURSOR FOR axcp801_bom_p1    
   
   LET l_sql = "  FROM bmaa_t,bmba_t ",
               " WHERE bmaaent = bmbaent AND bmaasite = bmbasite ",
               "   AND bmaa001 = bmba001 AND bmaa002 = bmba002 ",
               "   AND bmaastus = 'Y' AND (to_char(bmba005,'yy-mm-dd') <= '",g_today,"') ",
               "   AND ((to_char(bmba006,'yy-mm-dd') >= '",g_today,"')  OR (to_char(bmba006,'yy-mm-dd')) IS NULL) ",
               "   AND bmbaent = ",g_enterprise," AND bmbasite =  'ALL' ",
               "   AND bmba003 = ? AND bmba002 = ?" 
 
   LET l_sql2 = "SELECT DISTINCT bmba001,bmba002,bmba003,COALESCE(bmba011,0)/COALESCE(bmba012,1) ",l_sql
   PREPARE axcp801_bom_p2 FROM l_sql2
   DECLARE axcp801_bom_c2 CURSOR FOR axcp801_bom_p2  


   LET l_sql2 = "SELECT COUNT(1) ",l_sql
   PREPARE axcp801_bom_p3 FROM l_sql2   


   LET l_sql = "SELECT COUNT(1) FROM xcfi_tmp ",
               " WHERE xcfi006 = ? AND xcfi007 = ?",
               "   AND xcfi008 = ? AND xcfi009 = ? ",
               "   AND xcfi002 = ? "
   PREPARE axcp801_xcfi_p FROM l_sql

   
   LET l_sql = "SELECT xcfg002,xcfg006,xcfg007,xcfg008 ",
               "  FROM xcfg_tmp ",
               " WHERE xcfg028 = 'BOM' ",
               " ORDER BY clevel "               
   PREPARE axcp801_xcfi_p1 FROM l_sql
   DECLARE axcp801_xcfi_c1 CURSOR FOR axcp801_xcfi_p1
   
   LET l_sql = "INSERT INTO xcfi_tmp (xcfient,xcficomp,xcfild, ",
               "                      xcfi001,xcfi002,xcfi003,xcfi004,xcfi005, ",
               "                      xcfi006,xcfi007,xcfi008,xcfi009,xcfi010, ",
               "                       xcfi011,xcfi012,xcfi013,xcfi014,xcfi015) ", 
               "     VALUES (?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?) "
   PREPARE axcp801_ins_xcfi_p FROM l_sql                            
                              

   #找主件料號INS xcfi_tmp
   FOREACH axcp801_xcfi_c1 INTO g_master.xccc002,g_xcfi006,g_xcfi007,g_xcfi008
       FOREACH axcp801_bom_c1 USING g_xcfi006 INTO sr.bmba001,sr.bmba002,sr.bmba003,l_xcfi010
          LET l_cnt = 0
          EXECUTE axcp801_bom_p3 USING sr.bmba001,sr.bmba002 INTO l_cnt
          IF l_cnt <= 0 THEN
             #表示無上階料號
             EXECUTE axcp801_xcfi_p USING g_xcfi006,g_xcfi007,g_xcfi008,sr.bmba001,g_master.xccc002 INTO l_cnt
             IF l_cnt <= 0 THEN
                #新增
                LET l_xcfi011 = 0
                EXECUTE axcp801_ins_xcfi_p USING g_enterprise,g_master.xccccomp,g_master.xcccld,
                                                 g_master.xccc001,g_master.xccc002,g_master.xccc003,g_master.xccc004,g_master.xccc005,
                                                 g_xcfi006,g_xcfi007,g_xcfi008,sr.bmba001,l_xcfi010,
                                                 l_xcfi011,l_xcfi011,l_xcfi011,g_master.edate,g_master.bdate
                IF SQLCA.sqlcode THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = SQLCA.sqlcode
                   LET g_errparam.extend = 'INSERT xcfi_tmp'
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   LET r_success = FALSE
                   RETURN r_success
                END IF                                              
                                                 
             ELSE
                #UPD
                UPDATE xcfi_tmp
                   SET xcfi010 = xcfi010 + l_xcfi010
                 WHERE xcfi006= g_xcfi006 AND xcfi007= g_xcfi007 AND xcfi008 = g_xcfi008
                   AND xcfi009= sr.bmba001
                IF SQLCA.sqlcode THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = SQLCA.sqlcode
                   LET g_errparam.extend = 'UPDATE xcfi_tmp'
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   LET r_success = FALSE
                   RETURN r_success
                END IF                
             END IF        
       
          ELSE
             IF NOT axcp801_bom_xcfi(sr.bmba001,sr.bmba002,l_xcfi010) THEN
                LET r_success = FALSE
                RETURN r_success
             END IF
          END IF   
       END FOREACH       
   END FOREACH

   
   #xcfi011、xcfi012、xcfi013 用上階料號去抓xcfg019淨變現單價、入庫數、出庫數量 
   LET l_sql = " MERGE INTO xcfi_tmp ",
               " USING (SELECT DISTINCT xcfg006,avg(xcfg019) OVER(PARTITION BY xcfg006) xcfg019 ",
               "          FROM xcfg_tmp ) ",
               "     ON (xcfi009 = xcfg006) ",
               "  WHEN MATCHED THEN  ",          
               "    UPDATE SET xcfi011 = xcfg019 " 
   PREPARE axcp801_xcfg019_p FROM l_sql 
   EXECUTE axcp801_xcfg019_p      
   
   
   LET l_sql2 = " SELECT inaj005,SUM(inaj011 * inaj014) inaj011 ",   
                "     FROM inaj_t ",
                "  WHERE inajent = '",g_enterprise,"'",
                "    AND inaj209 = '",g_master.xccccomp,"'",
                "    AND inaj022 BETWEEN '",g_master.bdate2,"' AND '",g_master.edate,"'",
                "    AND inaj005 IN (SELECT DISTINCT xcfi009 FROM xcfi_tmp )",
                "    AND inaj008 IN (SELECT inaa001 FROM inaa_t WHERE inajent  = inaaent ",
                "                       AND inajsite = inaasite AND inaa010 = 'Y') ",
                "    AND inaj008 NOT IN (SELECT xcfd010 FROM xcfd_t WHERE xcfdent = inajent ",
                "                           AND xcfdcomp = '",g_master.xccccomp,"' AND xcfdld = '",g_master.xcccld,"'",
                "                           AND xcfd001 = '",g_master.xccc004,"' AND xcfd002 = '",g_master.xccc005,"' )"
   
   LET l_where = NULL
   IF g_master.ware_nor = 'Y' THEN 
      IF l_where IS NULL THEN
         LET l_where = " AND inaj036 IN ('110','111','112','102','103','104','105'"    #正常入库（工单，採購，委外入库） 
      ELSE
         LET l_where = l_where,",'110','111','112','102','103','104','105'"           
      END IF
   END IF
   IF g_master.ware_muti = 'Y' THEN 
      IF l_where IS NULL THEN
         LET l_where = " AND (inaj036 IN ('101','501'"                #雜項入庫（雜收、盤盈） 
      ELSE
         LET l_where = l_where,",'101','501'"
      END IF
   END IF 
   IF g_master.ware_oth = 'Y' THEN 
      IF l_where IS NULL THEN
         LET l_where = " AND （inaj036 IN ('106','107','113','114','115','202','303'"          #其他入库（拆件入庫、回收入庫、銷退，退料）  
      ELSE
         LET l_where = l_where,",'106','107','113','114','115','202','303'"
      END IF          
   END IF
   IF l_where IS NOT NULL THEN
      LET l_where = l_where,")"
   END IF
   
   IF g_master.ware_muti = 'Y' THEN
      LET l_where = l_where," AND inaj004 = '1' "
   END IF

   #入庫數
   LET l_sql = " MERGE INTO xcfi_tmp a ",
               " USING (",l_sql2,l_where,"GROUP BY inaj005) c",
               "     ON (a.xcfi009 = c.inaj005) ",
               "  WHEN MATCHED THEN  ",          
               "    UPDATE SET a.xcfi012 = c.inaj011 " 
   PREPARE axcp801_xcfi012_p FROM l_sql 
   EXECUTE axcp801_xcfi012_p  
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'UPDATE xcfi012'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #出庫數
   LET l_sql = " MERGE INTO xcfi_tmp a ",
               " USING (",l_sql2," AND inaj036 = '201' ",
               "         GROUP BY inaj005) c",
               "     ON (a.xcfi009 = c.inaj005) ",
               "  WHEN MATCHED THEN  ",          
               "    UPDATE SET a.xcfi013 = c.inaj011 " 
   PREPARE axcp801_xcfi013_p FROM l_sql 
   EXECUTE axcp801_xcfi013_p  
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'UPDATE xcfi013'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #取主件的淨變現單價和成本單價
   LET l_sql = "SELECT DISTINCT avg(xcfg017) OVER(PARTITION BY xcfg006) xcfg017,avg(xcfg019) OVER(PARTITION BY xcfg006) xcfg019 ",
               "  FROM xcfg_tmp ",
               " WHERE xcfg006 = ? "
   PREPARE axcp801_xcfi009_avg_p FROM l_sql  

   #取主件的淨變現單價和成本單價(取實體table)
   LET l_sql = "SELECT DISTINCT avg(xcfg017) OVER(PARTITION BY xcfg006) xcfg017,avg(xcfg019) OVER(PARTITION BY xcfg006) xcfg019 ",
               "  FROM xcfg_t ",
               " WHERE xcfgent = ",g_enterprise,
               "   AND  xcfgld = '",g_master.xcccld,"'  AND xcfg001 = '",g_master.xccc001,"' AND xcfg002 = '",g_master.xccc002,"'",
               "   AND xcfg003 = '",g_master.xccc003,"' AND xcfg004 = '",g_master.xccc004,"' AND xcfg005 = '",g_master.xccc005,"'",               
               "   AND xcfg006 = ? "
   PREPARE axcp801_xcfi009_avg_p2 FROM l_sql 
   
   #取此料件的單位成本
   LET l_sql = "SELECT xcfg017 FROM xcfg_tmp ",
               " WHERE xcfg006 = ? AND xcfg007 = ? AND xcfg008 = ? "          
               
   PREPARE axcp801_xcfi006_p FROM l_sql


   IF g_master.xcfa012 = '1' THEN
      #取成品代表料號之淨變現值
      #抓取xcfi_t資料，依逆推成品排序xcfg013做排序，抓取第一筆資料更新，並刪除其它筆資料
      LET l_where = ''
      CASE g_master.xcfa013_1
        WHEN '1' #依入庫量xcfi012
          IF g_master.xcfa013_2 = '2' THEN
             LET l_where = " ORDER BY xcfi012,xcfi013,xcfi009"
          ELSE
             LET l_where = " ORDER BY xcfi012,xcfi009,xcfi013"
          END IF 
        WHEN '2' #依進貨量xcfi013
          IF g_master.xcfa013_2 = '1' THEN
             LET l_where = " ORDER BY xcfi013,xcfi012,xcfi009"
          ELSE
             LET l_where = " ORDER BY xcfi013,xcfi009,xcfi012"
          END IF         
        WHEN '3' #依料號xcfi009
          IF g_master.xcfa013_2 = '1' THEN
             LET l_where = " ORDER BY xcfi009,xcfi012,xcfi013"
          ELSE
             LET l_where = " ORDER BY xcfi009,xcfi013,xcfi012"
          END IF         
      END CASE
      LET l_where = "ROW_NUMBER() OVER(PARTITION BY xcfi006,xcfi007,xcfi008 ",l_where,") as rank"
      
      
      
      LET l_sql = "SELECT xcfient,xcficomp,xcfild,xcfi001,xcfi002,xcfi003,xcfi004,xcfi005, ",
                  "       xcfi006,xcfi007,xcfi008,xcfi009,xcfi010 ",
                  "  FROM ( ",             
                  "         SELECT xcfient,xcficomp,xcfild,xcfi001,xcfi002,xcfi003,xcfi004,xcfi005, ",
                  "                xcfi006,xcfi007,xcfi008,xcfi009,xcfi010, ",l_where,
                  "           FROM xcfi_tmp ",
                  "        ) ",
                  " WHERE rank = 1 "        
      PREPARE axcp801_first_xcfi_p FROM l_sql
      DECLARE axcp801_first_xcfi_c CURSOR FOR axcp801_first_xcfi_p
      
      LET l_sql = " UPDATE xcfg_tmp ",
                  "    SET xcfg019 = ? ,",
                  "        xcfg025 = ?  ",
                  "  WHERE xcfg006 = ?  ",
                  "    AND xcfg007 = ?  ",
                  "    AND xcfg008 = ?  "
      PREPARE axcp801_first_upd_p FROM l_sql
      
      LET l_sql = " DELETE FROM xcfi_tmp ",
                  "  WHERE xcfi006 = ?  ",
                  "    AND xcfi007 = ?  ",
                  "    AND xcfi008 = ?  ",
                  "    AND xcfi009 <> ? "
      PREPARE axcp801_first_del_p FROM l_sql
      INITIALIZE l_xcfi.* TO NULL
      FOREACH axcp801_first_xcfi_c INTO l_xcfi.xcfient,l_xcfi.xcficomp,l_xcfi.xcfild,l_xcfi.xcfi001,l_xcfi.xcfi002,l_xcfi.xcfi003,l_xcfi.xcfi004,l_xcfi.xcfi005,
                                        l_xcfi.xcfi006,l_xcfi.xcfi007,l_xcfi.xcfi008,l_xcfi.xcfi009,l_xcfi.xcfi010
           
         #取主件的淨變現單價和成本單價
         LET l_xcfg017 = 0
         LET l_xcfg019 = 0
         EXECUTE axcp801_xcfi009_avg_p USING l_xcfi.xcfi009 INTO l_xcfg017,l_xcfg019
         IF SQLCA.sqlcode = 100 THEN
            #取實體table
            EXECUTE axcp801_xcfi009_avg_p2 USING l_xcfi.xcfi009 INTO l_xcfg017,l_xcfg019
         END IF
         IF cl_null(l_xcfg017) THEN LET l_xcfg017 = 0 END IF
         IF cl_null(l_xcfg019) THEN LET l_xcfg019 = 0 END IF
         
         #取此料件的單位成本
         LET l_xcfg017_1 = 0         
         EXECUTE axcp801_xcfi006_p USING l_xcfi.xcfi006,l_xcfi.xcfi007,l_xcfi.xcfi008 INTO l_xcfg017_1
         IF cl_null(l_xcfg017_1) THEN LET l_xcfg017_1 = 0 END IF
         
         LET l_xcfg019_1 = 0
         IF l_xcfg017 - (l_xcfg017_1 * l_xcfi.xcfi010 ) > 0 THEN
            LET l_xcfg019_1 = (l_xcfg019 - (l_xcfg017 - (l_xcfg017_1 * l_xcfi.xcfi010 ))) / l_xcfi.xcfi010
         ELSE
            LET l_xcfg019_1 = l_xcfg017_1
         END IF
         IF cl_null(l_xcfg019_1) THEN LET l_xcfg019_1 = 0 END IF
         #更新xcfg019/xcfg025
         EXECUTE axcp801_first_upd_p USING l_xcfg019_1,l_xcfi.xcfi009,l_xcfi.xcfi006,l_xcfi.xcfi007,l_xcfi.xcfi008
         #刪除其它筆xcfi_t，只留第一筆資料
         EXECUTE axcp801_first_del_p USING l_xcfi.xcfi006,l_xcfi.xcfi007,l_xcfi.xcfi008,l_xcfi.xcfi009
      END FOREACH                                  
      
   ELSE
      #取各成品料號之淨變現平均
      LET l_sql = "SELECT DISTINCT xcfi006,xcfi007,xcfi008 FROM xcfi_tmp "
      PREPARE axcp801_avg_xcfi_p FROM l_sql
      DECLARE axcp801_avg_xcfi_c CURSOR FOR axcp801_avg_xcfi_p   
      
      LET l_sql = "SELECT xcfi009,xcfi010,xcfi012,xcfi013 FROM xcfi_tmp ",
                  " WHERE xcfi006 = ? AND xcfi007 = ? AND xcfi008 = ? "
      PREPARE axcp801_avg_xcfi_p2 FROM l_sql
      DECLARE axcp801_avg_xcfi_c2 CURSOR FOR axcp801_avg_xcfi_p2
      #總出貨量/總入庫量      
      LET l_sql = "SELECT SUM(xcfi012),SUM(xcfi013),SUM(xcfi010*xcfi012),SUM(xcfi010*xcfi013) ", 
                  " FROM xcfi_tmp",
                  " WHERE xcfi006 = ? AND xcfi007 = ? AND xcfi008 = ? "
      PREPARE axcp801_avg_xcfi_p3 FROM l_sql            
      
      LET l_sql = " UPDATE xcfg_tmp ",
                  "    SET xcfg019 = ? ,",
                  "        xcfg025 = 'AVG', ",
                  "        xcfg026 = ? ,",
                  "        xcfg027 = ? ,",
                  "        xcfg024 = ? ",
                  "  WHERE xcfg006 = ? ",
                  "    AND xcfg007 = ? ",
                  "    AND xcfg008 = ?  "
      PREPARE axcp801_avg_upd_p FROM l_sql

      INITIALIZE l_xcfi.* TO NULL
      FOREACH axcp801_avg_xcfi_c INTO l_xcfi.xcfi006,l_xcfi.xcfi007,l_xcfi.xcfi008
         LET l_xcfi012_sum = 0
         LET l_xcfi013_sum = 0
         LET l_xcfg024_avg = 0
         LET l_xcfg026_avg = 0
         LET l_xcfg027_avg = 0
         LET l_xcfg024 = 0
         LET l_xcfg026 = 0
         LET l_xcfg027 = 0
         #總出貨量/總入庫量
         EXECUTE axcp801_avg_xcfi_p3 USING l_xcfi.xcfi006,l_xcfi.xcfi007,l_xcfi.xcfi008 INTO l_xcfi012_sum,l_xcfi013_sum,l_qpa_sum_in,l_qpa_sum_out   
         #取此料件的單位成本
         LET l_xcfg017_1 = 0         
         EXECUTE axcp801_xcfi006_p USING l_xcfi.xcfi006,l_xcfi.xcfi007,l_xcfi.xcfi008 INTO l_xcfg017_1  

         FOREACH axcp801_avg_xcfi_c2 USING l_xcfi.xcfi006,l_xcfi.xcfi007,l_xcfi.xcfi008 INTO l_xcfi.xcfi009,l_xcfi.xcfi010,l_xcfi.xcfi012,l_xcfi.xcfi013

            #取最終成品料號的淨變現單價和成本單價
            LET l_xcfg017 = 0
            LET l_xcfg019 = 0
            EXECUTE axcp801_xcfi009_avg_p USING l_xcfi.xcfi009 INTO l_xcfg017,l_xcfg019
            
            IF g_master.xcfa013_1 = '1' THEN #入庫量
               LET l_xcfg026 = (l_xcfg017 * l_xcfi.xcfi010 * l_xcfi.xcfi012)/l_qpa_sum_in
               LET l_xcfg026_avg = l_xcfg026_avg + l_xcfg026
               LET l_xcfg027 = (l_xcfg019 * l_xcfi.xcfi010 * l_xcfi.xcfi012)/l_qpa_sum_in
               LET l_xcfg027_avg = l_xcfg027_avg + l_xcfg027
               LET l_xcfg024 = (l_xcfi.xcfi010 * l_xcfi.xcfi012) / l_xcfi012_sum
               LET l_xcfg024_avg = l_xcfg024_avg + l_xcfg024
            ELSE
               LET l_xcfg026 = (l_xcfg017 * l_xcfi.xcfi010 * l_xcfi.xcfi013)/l_qpa_sum_out
               LET l_xcfg026_avg = l_xcfg026_avg + l_xcfg026
               LET l_xcfg027 = (l_xcfg019 * l_xcfi.xcfi010 * l_xcfi.xcfi013)/l_qpa_sum_out
               LET l_xcfg027_avg = l_xcfg027_avg + l_xcfg027
               LET l_xcfg024 = (l_xcfi.xcfi010 * l_xcfi.xcfi013) / l_xcfi013_sum
               LET l_xcfg024_avg = l_xcfg024_avg + l_xcfg024            
            END IF        
         END FOREACH
         LET l_xcfg019 = (l_xcfg027_avg - (l_xcfg026_avg - l_xcfg017_1*l_xcfg024_avg))/l_xcfg024_avg
         EXECUTE axcp801_avg_upd_p USING l_xcfg019,l_xcfg026_avg,l_xcfg027_avg,l_xcfg024_avg,l_xcfi.xcfi006,l_xcfi.xcfi007,l_xcfi.xcfi008            
      END FOREACH      
   END IF 
   
   RETURN r_success   
END FUNCTION

################################################################################
# Descriptions...: 展BOM取主件料號
# Memo...........:
# Usage..........: CALL axcp801_bom_xcfi(p_bmba003,p_bmba002,p_qpa)
#                  RETURNING 
# Input parameter: p_bmba003    料號
#                : p_bmba002    特性
#                : p_qpa        QPA
# Return code....: 
# Date & Author..: #161108-00037#1 By 02040
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp801_bom_xcfi(p_bmba003,p_bmba002,p_qpa)
DEFINE p_bmba003 LIKE bmba_t.bmba003
DEFINE p_bmba002 LIKE bmba_t.bmba002
DEFINE p_qpa     LIKE xcfi_t.xcfi010
DEFINE sr   DYNAMIC ARRAY OF RECORD #每階存放資料
       bmba001   LIKE bmba_t.bmba001,    #主件料號
       bmba002   LIKE bmba_t.bmba002,    #特性
       bmba003   LIKE bmba_t.bmba003,    #元件料號
       xcfi010   LIKE xcfi_t.xcfi010     #QPA
            END RECORD
DEFINE l_bmba011 LIKE bmba_t.bmba011 #組成用量
DEFINE l_bmba012 LIKE bmba_t.bmba012 #主件底數
DEFINE l_ac      LIKE type_t.num10
DEFINE l_i       LIKE type_t.num10
DEFINE l_cnt     LIKE type_t.num5
DEFINE r_success LIKE type_t.num5
DEFINE l_xcfi011 LIKE xcfi_t.xcfi011

  LET r_success = TRUE  
  
  LET l_ac = 1
  FOREACH axcp801_bom_c2 USING p_bmba003,p_bmba002 INTO sr[l_ac].bmba001,sr[l_ac].bmba002,sr[l_ac].bmba003,sr[l_ac].xcfi010
     LET l_ac = l_ac + 1
  END FOREACH
  FOR l_i = 1 TO l_ac - 1
      LET sr[l_i].xcfi010 = sr[l_i].xcfi010 * p_qpa
      LET l_cnt = 0
      EXECUTE axcp801_bom_p3 USING sr[l_i].bmba001,sr[l_i].bmba002 INTO l_cnt      
      IF l_cnt <= 0 THEN
         #表示無上階料號
         EXECUTE axcp801_xcfi_p USING g_xcfi006,g_xcfi007,g_xcfi008,sr[l_i].bmba001,g_master.xccc002 INTO l_cnt
         IF l_cnt <= 0 THEN
            #新增
            LET l_xcfi011 = 0
            EXECUTE axcp801_ins_xcfi_p USING g_enterprise,g_master.xccccomp,g_master.xcccld,
                                             g_master.xccc001,g_master.xccc002,g_master.xccc003,g_master.xccc004,g_master.xccc005,
                                             g_xcfi006,g_xcfi007,g_xcfi008,sr[l_i].bmba001,sr[l_i].xcfi010,
                                             l_xcfi011,l_xcfi011,l_xcfi011,g_master.edate,g_master.bdate
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'INSERT xcfi_tmp'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET r_success = FALSE
               RETURN r_success
            END IF                                             
                                             
         ELSE
            #UPD
            UPDATE xcfi_tmp
               SET xcfi010 = xcfi010 + sr[l_i].xcfi010
             WHERE xcfi006= g_xcfi006 AND xcfi007= g_xcfi007 AND xcfi008 = g_xcfi008
               AND xcfi009= sr[l_i].bmba001
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'UPDATE xcfi_tmp'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET r_success = FALSE
               RETURN r_success
            END IF                
         END IF         
      ELSE
        IF NOT axcp801_bom_xcfi(sr[l_i].bmba001,sr[l_i].bmba002,sr[l_i].xcfi010) THEN
           LET r_success = FALSE
           RETURN r_success
        END IF            
      END IF
  
  END FOR  
  
  RETURN r_success

END FUNCTION

################################################################################
# Descriptions...: 寫入實體table
# Memo...........:
# Usage..........: CALL axcp801_ins_table()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success TRUE/FALSE
# Date & Author..: #161108-00037#1 By 02040
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp801_ins_table()
DEFINE r_success LIKE type_t.num5
DEFINE l_sql     STRING 
  
   LET r_success = TRUE
   
   IF g_bgjob <> "Y" THEN
      #寫正式表
      LET g_progress_msg = cl_getmsg('axc-00655',g_dlang)  
      CALL cl_progress_no_window_ing(g_progress_msg)
   END IF    
   
   LET l_sql = "DELETE FROM xcfg_t a ",
               " WHERE EXISTS (SELECT 1 FROM xcfg_tmp b       ",
               "                WHERE a.xcfgent = b.xcfgent   ",
               "                  AND a.xcfgcomp = b.xcfgcomp ",
               "                  AND a.xcfgld = b.xcfgld     ",
               "                  AND a.xcfg001 = b.xcfg001   ",
               "                  AND a.xcfg002 = b.xcfg002   ",
               "                  AND a.xcfg003 = b.xcfg003   ",
               "                  AND a.xcfg004 = b.xcfg004   ",
               "                  AND a.xcfg005 = b.xcfg005   ",
               "                  AND a.xcfg006 = b.xcfg006   ",
               "                  AND a.xcfg007 = b.xcfg007   ",
               "                  AND a.xcfg008 = b.xcfg008)  "           
   PREPARE axcp801_del_xcfg_tbl FROM l_sql
   EXECUTE axcp801_del_xcfg_tbl
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'DELETE xcfg_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   LET l_sql = "DELETE FROM xcfh_t  ",
               " WHERE EXISTS (SELECT 1 FROM xcfg_tmp     ",
               "                WHERE xcfhent = xcfgent   ",
               "                  AND xcfhcomp = xcfgcomp ",
               "                  AND xcfhld = xcfgld     ",
               "                  AND xcfh001 = xcfg001   ",
               "                  AND xcfh002 = xcfg002   ",
               "                  AND xcfh003 = xcfg003   ",
               "                  AND xcfh004 = xcfg004   ",
               "                  AND xcfh005 = xcfg005   ",
               "                  AND xcfh006 = xcfg006   ",
               "                  AND xcfh007 = xcfg007   ",
               "                  AND xcfh008 = xcfg008)  "           
   PREPARE axcp801_del_xcfh_tbl FROM l_sql
   EXECUTE axcp801_del_xcfh_tbl
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'DELETE xcfh_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF        
   LET l_sql = "DELETE FROM xcfi_t  ",
               " WHERE EXISTS (SELECT 1 FROM xcfg_tmp     ",
               "                WHERE xcfient = xcfgent   ",
               "                  AND xcficomp = xcfgcomp ",
               "                  AND xcfild = xcfgld     ",
               "                  AND xcfi001 = xcfg001   ",
               "                  AND xcfi002 = xcfg002   ",
               "                  AND xcfi003 = xcfg003   ",
               "                  AND xcfi004 = xcfg004   ",
               "                  AND xcfi005 = xcfg005   ",
               "                  AND xcfi006 = xcfg006   ",
               "                  AND xcfi007 = xcfg007   ",
               "                  AND xcfi008 = xcfg008)  "           
   PREPARE axcp801_del_xcfi_tbl FROM l_sql
   EXECUTE axcp801_del_xcfi_tbl
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'DELETE xcfi_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF                  
   LET l_sql = "DELETE FROM xcfn_t a ",
               " WHERE EXISTS (SELECT 1 FROM xcfn_tmp b       ",
               "                WHERE a.xcfnent = b.xcfnent   ",
               "                  AND a.xcfncomp = b.xcfncomp ",
               "                  AND a.xcfnld = b.xcfnld     ",
               "                  AND a.xcfn001 = b.xcfn001   ",
               "                  AND a.xcfn002 = b.xcfn002   ",
               "                  AND a.xcfn003 = b.xcfn003   ",
               "                  AND a.xcfn004 = b.xcfn004   ",
               "                  AND a.xcfn005 = b.xcfn005   ",
               "                  AND a.xcfn006 = b.xcfn006   ",
               "                  AND a.xcfn007 = b.xcfn007   ",
               "                  AND a.xcfn008 = b.xcfn008   ",
               "                  AND a.xcfn009 = b.xcfn009)  "          
   PREPARE axcp801_del_xcfn_tbl FROM l_sql
   EXECUTE axcp801_del_xcfn_tbl
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'DELETE xcfn_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF   

   INSERT INTO xcfg_t SELECT xcfgent,xcfgcomp,xcfgld,
                             xcfg001,xcfg002,xcfg003,xcfg004,xcfg005,xcfg006,xcfg007,xcfg008,xcfg010,
                             xcfg011,xcfg012,xcfg013,xcfg014,xcfg015,xcfg016,xcfg017,xcfg018,xcfg019,xcfg020,
                             xcfg021,xcfg022,xcfg023,xcfg024,xcfg025,xcfg026,xcfg027,xcfg028,xcfg029,xcfg030                             
                        FROM xcfg_tmp

                        
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'INSERT INTO xcfg_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF 
   
   INSERT INTO xcfh_t SELECT xcfhent,xcfhcomp,xcfhld ,
                             xcfh001,xcfh002,xcfh003,xcfh004,xcfh005,xcfh006,xcfh007,xcfh008,xcfh009,xcfhseq,xcfh010,
                             xcfh011,xcfh012,xcfh013,xcfh014,xcfh015,xcfh016,xcfh017,xcfh018,xcfh019,xcfh020,
                             xcfh021,xcfh022,xcfh023 
                        FROM xcfh_tmp
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'INSERT INTO xcfh_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF    
 
   INSERT INTO xcfi_t SELECT xcfient,xcficomp,xcfild ,
                             xcfi001,xcfi002,xcfi003,xcfi004,xcfi005,xcfi006,xcfi007,xcfi008,xcfi009,xcfi010,
                             xcfi011,xcfi012,xcfi013,xcfi014,xcfi015 
                        FROM xcfi_tmp
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'INSERT INTO xcfi_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF 

   INSERT INTO xcfn_t SELECT xcfnent,xcfncomp,xcfnld,
                             xcfn001,xcfn002,xcfn003,xcfn004,xcfn005,xcfn006,xcfn007,xcfn008,xcfn009,xcfn010,
                             xcfn011,xcfn012,xcfn013,xcfn014,xcfn015,xcfn016,xcfn017,xcfn018,xcfn019,xcfn020,
                             xcfn021,xcfn022,xcfn023,
                            #自定義欄位
                             '','','','','','','','','','',
                             '','','','','','','','','','',
                             '','','','','','','','','',''
                            #自定義欄位 
                        FROM xcfn_tmp

                        
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'INSERT INTO xcfn_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF 
   RETURN r_success

END FUNCTION

#end add-point
 
{</section>}
 
