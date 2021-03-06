#該程式未解開Section, 採用最新樣板產出!
{<section id="aglr500.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2015-12-30 18:31:54), PR版次:0002(2016-04-07 10:46:57)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000028
#+ Filename...: aglr500
#+ Description: 合併報表沖銷調整傳票列印
#+ Creator....: 02159(2015-12-30 14:37:49)
#+ Modifier...: 02159 -SD/PR- 07959
 
{</section>}
 
{<section id="aglr500.global" >}
#應用 r01 樣板自動產生(Version:21)
#add-point:填寫註解說明 name="global.memo"
#Memos
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_schedule
#add-point:增加匯入項目 name="global.import"
#151113-00002#26 2016/01/14 By sakura 1.帳套編號：更名為 「帳套/合併帳套」,控卡及開窗方式同agli511
#                                     2.來源類型下拉選單需受到QBE條件控制隱顯
#160318-00025#28 2016/04/07 By 07959    修正azzi920重複定義之錯誤訊息
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
        v                LIKE type_t.chr1,
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       gldpld LIKE gldp_t.gldpld, 
   glaacomp LIKE glaa_t.glaacomp, 
   gldpld_desc LIKE type_t.chr80, 
   glaacomp_desc LIKE type_t.chr80, 
   gldpcrtid LIKE gldp_t.gldpcrtid, 
   gldpcrtid_e LIKE type_t.chr500, 
   stus LIKE type_t.chr500, 
   gldp005 LIKE gldp_t.gldp005, 
   gldpdocno LIKE gldp_t.gldpdocno, 
   gldpdocdt LIKE gldp_t.gldpdocdt, 
   gldpcrtdt LIKE gldp_t.gldpcrtdt, 
   gldp006 LIKE gldp_t.gldp006,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_param type_parameter
DEFINE g_gldpcrtid          LIKE gldp_t.gldpcrtid
DEFINE g_gldpstus           LIKE gldp_t.gldpstus
DEFINE g_gldp012            LIKE gldp_t.gldp012
DEFINE g_gldpld             LIKE gldp_t.gldpld
DEFINE g_glaacomp           LIKE glaa_t.glaacomp
DEFINE g_p_gldpld           LIKE gldp_t.gldpld   
                            
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_glaald             LIKE glaa_t.glaald
DEFINE g_gldpld_glaa131     LIKE glaa_t.glaa131
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aglr500.main" >}
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
   CALL cl_ap_init("agl","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
 
   #end add-point   
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
      CALL util.JSON.parse(ls_js,g_master)      #r類背景參數解析入口
      #add-point:Service Call name="main.servicecall"
 
      #end add-point
      CALL aglr500_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aglr500 WITH FORM cl_ap_formpath("agl",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL aglr500_init()
 
      #進入選單 Menu (="N")
      CALL aglr500_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aglr500
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aglr500.init" >}
#+ 初始化作業
PRIVATE FUNCTION aglr500_init()
   #add-point:init段define name="init.define"
   DEFINE l_success      LIKE type_t.num5
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
   CALL cl_set_combo_scc('gldp005','9974')
   CALL cl_set_combo_scc_part('gldp006','9973','1,2,4,7,8,9,M,U,V,W,X')   
   #抓取预设帐别
   CALL s_ld_bookno() RETURNING l_success,g_glaald
   IF l_success = FALSE THEN
      LET g_glaald = NULL
      RETURN
   END IF
   CALL s_ld_chk_authorization(g_user,g_glaald) RETURNING l_success
   IF l_success = FALSE THEN
      LET g_glaald = NULL
      RETURN
   END IF
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aglr500.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aglr500_ui_dialog()
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_string             STRING
   DEFINE tok                  base.stringtokenizer
   DEFINE g_wc_gldpld          STRING
   DEFINE l_num1               LIKE type_t.num5
   DEFINE l_num2               LIKE type_t.num5  
   DEFINE l_str                STRING
   DEFINE l_pass               LIKE type_t.num5
   DEFINE l_type               LIKE type_t.chr1
   #end add-point
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   LET g_master.stus = '1'
   LET g_master.gldp005 = '1'
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.gldpld,g_master.glaacomp,g_master.gldpcrtid,g_master.gldpcrtid_e,g_master.stus, 
             g_master.gldp005 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
 
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldpld
            
            #add-point:AFTER FIELD gldpld name="input.a.gldpld"
            IF NOT cl_null(g_master.gldpld) THEN
               CALL s_merge_ld_with_comp_chk(g_master.gldpld,'',g_user,5)RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CALL s_desc_get_ld_desc(g_master.gldpld) RETURNING g_master.gldpld_desc
                  DISPLAY BY NAME g_master.gldpld,g_master.gldpld_desc
                  NEXT FIELD CURRENT
               END IF
               CALL aglr500_gldpld_desc()
               CALL s_desc_get_ld_desc(g_master.gldpld) RETURNING g_master.gldpld_desc
               DISPLAY BY NAME g_master.gldpld,g_master.gldpld_desc               
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldpld
            #add-point:BEFORE FIELD gldpld name="input.b.gldpld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldpld
            #add-point:ON CHANGE gldpld name="input.g.gldpld"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaacomp
            
            #add-point:AFTER FIELD glaacomp name="input.a.glaacomp"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_master.glaacomp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_master.glaacomp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_master.glaacomp_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaacomp
            #add-point:BEFORE FIELD glaacomp name="input.b.glaacomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaacomp
            #add-point:ON CHANGE glaacomp name="input.g.glaacomp"

         AFTER FIELD gldpcrtid
            IF NOT cl_null(g_master.gldpcrtid) THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗  #160318-00025#29 add
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1=g_master.gldpcrtid
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"#要執行的建議程式待補 #160318-00025#29 add
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_master.gldpcrtid=''
                  NEXT FIELD CURRENT
               END IF
            END IF
            
         AFTER FIELD gldpcrtid_e
            IF NOT cl_null(g_master.gldpcrtid_e) THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗  #160318-00025#29 add
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1=g_master.gldpcrtid_e
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"#要執行的建議程式待補 #160318-00025#29 add
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_master.gldpcrtid_e=''
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stus
            #add-point:BEFORE FIELD stus name="input.b.stus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stus
            
            #add-point:AFTER FIELD stus name="input.a.stus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stus
            #add-point:ON CHANGE stus name="input.g.stus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldp005
            #add-point:BEFORE FIELD gldp005 name="input.b.gldp005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldp005
            
            #add-point:AFTER FIELD gldp005 name="input.a.gldp005"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldp005
            #add-point:ON CHANGE gldp005 name="input.g.gldp005"
            #151113-00002#26(S)
            LET g_master.gldp006 = ''
            DISPLAY g_master.gldp006 TO gldp006            
            CASE g_master.gldp005
              WHEN '1' #調整：M,8,9,U,V,W
                CALL cl_set_combo_scc_part('gldp006','9973','M,8,9,U,V,W')
              WHEN '2' #沖銷：1,2,4,3,5,7
                CALL cl_set_combo_scc_part('gldp006','9973','1,2,4,3,5,7')               
              WHEN '3' #會計師調整：來源類型設為NOENTRY，直接取aglt535資料
                LET g_master.gldp006 = ''
                DISPLAY g_master.gldp006 TO gldp006
              WHEN '4' #來源類型設為 NOENTRY，直接取aglt540
                LET g_master.gldp006 = ''
                DISPLAY g_master.gldp006 TO gldp006
              WHEN '5'
                CALL cl_set_combo_scc_part('gldp006','9973','1,2,4,7,8,9,M,U,V,W,X')                
            END CASE
            #151113-00002#26(E)
            #END add-point 
 
 
 
                     #Ctrlp:input.c.gldpld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldpld
            #add-point:ON ACTION controlp INFIELD gldpld name="input.c.gldpld"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段            
            #151113-00002#26(S)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.gldpld
            LET g_qryparam.where = " glaald IN (SELECT DISTINCT gldc003 FROM gldb_t,gldc_t ",
                                                "WHERE gldbent = gldcent AND gldbld = gldcld AND gldbstus = 'Y' ",
                                                "  AND gldb001 = gldc001 ",
                                                "  AND gldbent = ",g_enterprise,") " 
            LET g_qryparam.arg1 = g_user   #人員權限
            LET g_qryparam.arg2 = g_dept   #部門權限
            CALL q_gldc003()
            LET g_master.gldpld = g_qryparam.return1
            #151113-00002#26(E)
            CALL s_desc_get_ld_desc(g_master.gldpld) RETURNING g_master.gldpld_desc
            DISPLAY BY NAME g_master.gldpld,g_master.gldpld_desc
            CALL aglr500_gldpld_desc()
            NEXT FIELD gldpld            
            #END add-point
 
 
         #Ctrlp:input.c.glaacomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaacomp
            #add-point:ON ACTION controlp INFIELD glaacomp name="input.c.glaacomp"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.glaacomp             #給予default值
            LET g_qryparam.default2 = "" #g_master.ooefl003 #說明(簡稱)
            #給予arg
            LET g_qryparam.arg1 = "" #
            CALL q_ooef001()                                #呼叫開窗
            LET g_master.glaacomp = g_qryparam.return1              
            #LET g_master.ooefl003 = g_qryparam.return2 
            DISPLAY g_master.glaacomp TO glaacomp              #
            #DISPLAY g_master.ooefl003 TO ooefl003 #說明(簡稱)
            NEXT FIELD glaacomp                          #返回原欄位

         ON ACTION controlp INFIELD gldpcrtid
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.gldpcrtid            #給予default值
            #給予arg
            LET g_qryparam.arg1 = "" #
            CALL q_ooag001()                                #呼叫開窗
            LET g_master.gldpcrtid = g_qryparam.return1              
            DISPLAY g_master.gldpcrtid TO gldpcrtid              #   
            NEXT FIELD gldpcrtid

         ON ACTION controlp INFIELD gldpcrtid_e
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.gldpcrtid_e             #給予default值
            #給予arg
            LET g_qryparam.arg1 = "" #
            CALL q_ooag001()                                #呼叫開窗
            LET g_master.gldpcrtid_e = g_qryparam.return1              
            DISPLAY g_master.gldpcrtid_e TO gldpcrtid_e              #   
            NEXT FIELD gldpcrtid_e
            #END add-point
 
 
         #Ctrlp:input.c.stus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stus
            #add-point:ON ACTION controlp INFIELD stus name="input.c.stus"
            
            #END add-point
 
 
         #Ctrlp:input.c.gldp005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldp005
            #add-point:ON ACTION controlp INFIELD gldp005 name="input.c.gldp005"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON gldpdocno,gldpdocdt,gldpcrtdt,gldp006
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
  
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldpdocno
            #add-point:BEFORE FIELD gldpdocno name="construct.b.gldpdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldpdocno
            
            #add-point:AFTER FIELD gldpdocno name="construct.a.gldpdocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gldpdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldpdocno
            #add-point:ON ACTION controlp INFIELD gldpdocno name="construct.c.gldpdocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "1=1"            
            IF NOT cl_null(g_master.gldpld) THEN
               LET g_qryparam.where =g_qryparam.where , " AND gldpld ='",g_master.gldpld,"'"
            END IF
            IF NOT cl_null(g_master.gldpcrtid) THEN
               IF NOT cl_null(g_master.gldpcrtid_e) THEN
                  LET g_qryparam.where = g_qryparam.where , " AND gldpcrtid BETWEEN '",g_master.gldpcrtid,"' AND '",g_master.gldpcrtid_e,"'"
               ELSE 
                  LET g_qryparam.where = g_qryparam.where , " AND gldpcrtid ='",g_master.gldpcrtid,"'"
               END IF
            ELSE 
               IF NOT cl_null(g_master.gldpcrtid_e) THEN
                  LET g_qryparam.where = g_qryparam.where , " AND gldpcrtid ='",g_master.gldpcrtid_e,"'"
               END IF
            END IF
            CASE g_master.stus
               WHEN '1' #未審核
                  LET g_qryparam.where = g_qryparam.where , " AND gldpstus = 'N'"
               WHEN '2' #已確認未過帳
                  LET g_qryparam.where = g_qryparam.where , " AND gldpstus = 'Y'"
               WHEN '3' #已過帳
                  LET g_qryparam.where = g_qryparam.where , " AND gldpstus = 'S'"
            END CASE
            CALL q_gldpdocno()                           #呼叫開窗
            LET g_qryparam.where =""       
            DISPLAY g_qryparam.return1 TO gldpdocno  #顯示到畫面上
            LET g_qryparam.where =""              
            NEXT FIELD gldpdocno                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldpdocdt
            #add-point:BEFORE FIELD gldpdocdt name="construct.b.gldpdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldpdocdt
            
            #add-point:AFTER FIELD gldpdocdt name="construct.a.gldpdocdt"
 
            #END add-point
            
 
 
         #Ctrlp:construct.c.gldpdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldpdocdt
            #add-point:ON ACTION controlp INFIELD gldpdocdt name="construct.c.gldpdocdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldpcrtdt
            #add-point:BEFORE FIELD gldpcrtdt name="construct.b.gldpcrtdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldp006
            #add-point:BEFORE FIELD gldp006 name="construct.b.gldp006"
            #151113-00002#26(S)
            CASE g_master.gldp005
            WHEN '3' #會計師調整：來源類型設為NOENTRY，直接取aglt535資料
              NEXT FIELD gldpld
            WHEN '4' #來源類型設為 NOENTRY，直接取aglt540
              NEXT FIELD gldpld
            END CASE
            #151113-00002#26(E)
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldp006
            
            #add-point:AFTER FIELD gldp006 name="construct.a.gldp006"
            LET g_master.gldp006 = GET_FLDBUF(gldp006)
            #END add-point
            
 
 
         #Ctrlp:construct.c.gldp006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldp006
            #add-point:ON ACTION controlp INFIELD gldp006 name="construct.c.gldp006"
            
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
            CALL aglr500_get_buffer(l_dialog)
 
         ON ACTION qbe_select
            LET ls_wc = ""
            #需要用ITM類程式查詢方案在CONSTRUCT的功能，將值set到畫面上
            CALL cl_qbe_list("c") RETURNING ls_wc
            CALL aglr500_get_buffer(l_dialog)
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
         CALL aglr500_init()
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
                 CALL aglr500_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = aglr500_transfer_argv(ls_js)
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
 
{<section id="aglr500.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION aglr500_transfer_argv(ls_js)
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
 
{<section id="aglr500.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION aglr500_process(ls_js)
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
 
   LET g_rep_wcchp = cl_wcchp(g_master.wc,"gldpdocno,gldpdocdt,gldpcrtdt,gldp006")  #取得列印條件
  
   #add-point:process段前處理 name="process.pre_process"
   IF cl_null(g_master.wc) THEN ## 若是t類進來 會是傳字串參數的方式
      CALL l_arg.clear()
      LET l_token = base.StringTokenizer.create(ls_js,",")
      LET l_cnt = 1
      WHILE l_token.hasMoreTokens()
         LET ls_next = l_token.nextToken()
         LET l_arg[l_cnt] = ls_next
         LET l_cnt = l_cnt + 1
      END WHILE
      CALL l_arg.deleteElement(l_cnt)
      LET  g_master.wc = l_arg[01]  
      LET  g_param.wc = g_master.wc      
   ELSE  
      IF cl_null(ls_sql) THEN
         LET ls_sql=' 1=1'
      END IF
      
      #條件選項
      #账套
      IF NOT cl_null(g_master.gldpld) THEN
         IF g_master.gldp005 = '1' AND g_master.gldp006 = 'M' THEN
            LET ls_sql = ls_sql," AND gldp002='",g_master.gldpld,"' "
         ELSE
            LET ls_sql = ls_sql," AND gldpld='",g_master.gldpld,"' "
         END IF
      END IF
      #制表人员
      IF NOT cl_null(g_master.gldpcrtid) THEN
         IF NOT cl_null(g_master.gldpcrtid_e) THEN
            LET ls_sql = ls_sql, " AND gldpcrtid BETWEEN '",g_master.gldpcrtid,"' AND '",g_master.gldpcrtid_e,"'"
         ELSE 
            LET ls_sql = ls_sql, " AND gldpcrtid ='",g_master.gldpcrtid,"'"
         END IF
      ELSE 
         IF NOT cl_null(g_master.gldpcrtid_e) THEN
            LET ls_sql = ls_sql, " AND gldpcrtid ='",g_master.gldpcrtid_e,"'"
         END IF
      END IF
      #單據狀態
      CASE g_master.stus
         WHEN '1' #未確認
            LET ls_sql = ls_sql, " AND gldpstus = 'N'"
         WHEN '2' #已確認
            LET ls_sql = ls_sql, " AND gldpstus = 'Y'"
      END CASE
      #傳票類型
      CASE g_master.gldp005
         WHEN '1' #1.調整
            LET ls_sql = ls_sql, " AND gldp005 = '1'"
         WHEN '2' #2.沖銷
            LET ls_sql = ls_sql, " AND gldp005 = '2'"
         WHEN '3' #3.會計師調整
            LET ls_sql = ls_sql, " AND gldp005 = '3'"
         WHEN '4' #4.結轉
            LET ls_sql = ls_sql, " AND gldp005 = '4'"
      END CASE
      #打印條件
      LET g_param.wc = ls_sql," AND ",g_master.wc," AND gldpent = ",g_enterprise
   END IF
   #报表模板
   CALL aglr500_g01(g_param.wc)
   
   #end add-point
 
   #預先計算progressbar迴圈次數   #r類不用計算進度條
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE aglr500_process_cs CURSOR FROM ls_sql
#  FOREACH aglr500_process_cs INTO
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
 
{<section id="aglr500.get_buffer" >}
PRIVATE FUNCTION aglr500_get_buffer(p_dialog)
   DEFINE p_dialog   ui.DIALOG
   
   LET g_master.gldpld = p_dialog.getFieldBuffer('gldpld')
   LET g_master.glaacomp = p_dialog.getFieldBuffer('glaacomp')
   LET g_master.gldpcrtid = p_dialog.getFieldBuffer('gldpcrtid')
   LET g_master.gldpcrtid_e = p_dialog.getFieldBuffer('gldpcrtid_e')
   LET g_master.stus = p_dialog.getFieldBuffer('stus')
   LET g_master.gldp005 = p_dialog.getFieldBuffer('gldp005')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aglr500.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 抓取帳套說明和法人及法人說明
# Memo...........:
# Usage..........: CALL aglr500_gldpld_desc()
# Date & Author..: 2015/12/30 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION aglr500_gldpld_desc()
   
   SELECT glaacomp INTO g_master.glaacomp 
     FROM glaa_t 
    WHERE glaaent = g_enterprise 
      AND glaald= g_master.gldpld
   
   #CALL s_desc_get_ld_desc(g_master.gldpld) RETURNING g_master.gldpld_desc
   #DISPLAY BY NAME g_master.gldpld,g_master.gldpld_desc
   
   CALL s_desc_get_department_desc(g_master.glaacomp) RETURNING g_master.glaacomp_desc
   DISPLAY BY NAME g_master.glaacomp,g_master.glaacomp_desc
   
END FUNCTION

#end add-point
 
{</section>}
 
