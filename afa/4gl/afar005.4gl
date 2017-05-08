#該程式未解開Section, 採用最新樣板產出!
{<section id="afar005.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2015-03-20 17:27:37), PR版次:0006(2016-11-29 17:24:10)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000043
#+ Filename...: afar005
#+ Description: 附屬設備明細表
#+ Creator....: 01251(2015-03-20 16:27:55)
#+ Modifier...: 01251 -SD/PR- 07900
 
{</section>}
 
{<section id="afar005.global" >}
#應用 r01 樣板自動產生(Version:21)
#add-point:填寫註解說明 name="global.memo"
#160318-00005#9   2016/03/23  BY 07675    將重複內容的錯誤訊息置換為公用錯誤訊息
#160318-00025#43  2016/04/26  BY pengxin  將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160426-00014#33  2016/08/17  BY 02114    修改权限的问题
#161006-00005#35  2016/10/24  By 06814    1.资产中心开窗调整为q_ooef001_47 
#                                         2.法人组织调整为q_ooef001_2但要注意原本的权限控管要保留
#161111-00049#14  2016/11/23 By 07900     1.【卡片編號、財產編號、附號：基礎資料類查詢，增加USER據點權限與資產設備的【歸屬法人】，作交互限定可視範圍。
#                                         2.【主要類型】：採集團設置,因應誼山現況，增加依法人限定。
#                                         3.【次要類型】：採集團設置,因應誼山現況，增加參考主類型處理
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
       site LIKE type_t.chr500, 
   site_desc LIKE type_t.chr80, 
   faah032 LIKE faah_t.faah032, 
   faah032_desc LIKE type_t.chr80, 
   faah006 LIKE faah_t.faah006, 
   faah026 LIKE faah_t.faah026, 
   faah001 LIKE faah_t.faah001, 
   faah003 LIKE faah_t.faah003, 
   faah004 LIKE faah_t.faah004,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_bookno             LIKE faam_t.faamld
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="afar005.main" >}
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
   CALL cl_ap_init("afa","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point   
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
      CALL util.JSON.parse(ls_js,g_master)      #r類背景參數解析入口
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL afar005_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_afar005 WITH FORM cl_ap_formpath("afa",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL afar005_init()
 
      #進入選單 Menu (="N")
      CALL afar005_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_afar005
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="afar005.init" >}
#+ 初始化作業
PRIVATE FUNCTION afar005_init()
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
   CALL s_fin_create_account_center_tmp() 
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="afar005.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION afar005_ui_dialog()
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_origin_str  STRING
   DEFINE l_count       LIKE type_t.num5
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_ld          LIKE faam_t.faamld
   DEFINE l_ld_str      STRING
   DEFINE l_comp_str    STRING
   #end add-point
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
 
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      CALL s_afat503_default(g_bookno) RETURNING l_success,g_master.site,l_ld,g_master.faah032
                    
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_master.site
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_master.site_desc = '', g_rtn_fields[1] , ''
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_master.faah032
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_master.faah032_desc = '', g_rtn_fields[1] , ''    
      DISPLAY BY NAME g_master.site,g_master.site_desc,g_master.faah032,g_master.faah032_desc
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.site,g_master.faah032 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD site
            
            #add-point:AFTER FIELD site name="input.a.site"
#160426-00014#33--mark--str--lujh
#            IF NOT cl_null(g_master.site) THEN 
##應用 a19 樣板自動產生(Version:2)
#               #校驗代值
#               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#               INITIALIZE g_chkparam.* TO NULL
#               #設定g_chkparam.*的參數
#               LET g_chkparam.arg1 = g_master.site
#
#               #160318-00025#43  2016/04/26  by pengxin  add(S)
#               LET g_errshow = TRUE #是否開窗 
#               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
#               #160318-00025#43  2016/04/26  by pengxin  add(E)
#               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist("v_ooef001") THEN
#                  #檢查成功時後續處理
#                  #LET  = g_chkparam.return1
#                  #DISPLAY BY NAME 
#               ELSE
#                  #檢查失敗時後續處理
#                  NEXT FIELD CURRENT
#               END IF
#               #資產中心
#               LET l_count=0
#               SELECT COUNT(*) INTO l_count FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_master.site AND ooefstus = 'Y' AND ooef207 = 'Y'
#               IF cl_null(l_count) OR l_count=0 THEN   
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = 'afa-00004'
#                  LET g_errparam.extend = ''
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
#                  LET g_master.site = ''
#                  DISPLAY BY NAME g_master.site
#                  NEXT FIELD CURRENT  
#               END IF        
#               #資產中心和法人檢查
#               IF NOT cl_null(g_master.faah032) THEN
#                  IF NOT afar005_site_comp_chk() THEN
#                     LET g_master.site = ''
#                     DISPLAY BY NAME g_master.site
#                     NEXT FIELD CURRENT  
#                  END IF                                      
#               END IF
#
#            END IF 
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_master.site
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_master.site_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_master.site_desc
#160426-00014#33--mark--end--lujh

#160426-00014#33--add--str--lujh
            IF NOT cl_null(g_master.site) THEN
               CALL s_afa_site_chk(g_master.site,'',g_master.faah032,l_ld,g_today)
               RETURNING l_success,g_master.faah032,l_ld
               
               IF l_success = FALSE THEN 
                  LET g_master.site = ''
                  CALL s_desc_get_department_desc(g_master.site) RETURNING g_master.site_desc
                  DISPLAY BY NAME g_master.site_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL s_fin_account_center_sons_query('5',g_master.site,g_today,'1')
            CALL s_desc_get_department_desc(g_master.site) RETURNING g_master.site_desc
            CALL s_desc_get_department_desc(g_master.faah032) RETURNING g_master.faah032_desc
            DISPLAY BY NAME g_master.site_desc,g_master.faah032_desc
#160426-00014#33--add--end--lujh
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD site
            #add-point:BEFORE FIELD site name="input.b.site"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE site
            #add-point:ON CHANGE site name="input.g.site"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah032
            
            #add-point:AFTER FIELD faah032 name="input.a.faah032"
#160426-00014#33--mark--str--lujh
#            IF NOT cl_null(g_master.faah032) THEN 
##應用 a19 樣板自動產生(Version:2)
#               #校驗代值
#               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#               INITIALIZE g_chkparam.* TO NULL
#               #設定g_chkparam.*的參數
#               LET g_chkparam.arg1 = g_master.faah032
#
#               #160318-00025#43  2016/04/26  by pengxin  add(S)
#               LET g_errshow = TRUE #是否開窗 
#               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
#               #160318-00025#43  2016/04/26  by pengxin  add(E)
#               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist("v_ooef001") THEN
#                  #檢查成功時後續處理
#                  #LET  = g_chkparam.return1
#                  #DISPLAY BY NAME 
#               ELSE
#                  #檢查失敗時後續處理
#                  NEXT FIELD CURRENT
#               END IF
#               #法人檢查
#               IF NOT afar005_comp_chk() THEN
#                  LET g_master.faah032 = ''
#                  DISPLAY BY NAME g_master.faah032
#                  NEXT FIELD CURRENT
#               END IF               
#               #法人和資產中心檢查
#               IF NOT cl_null(g_master.site) THEN
#                  IF NOT afar005_site_comp_chk() THEN
#                     LET g_master.faah032 = ''
#                     DISPLAY BY NAME g_master.faah032
#                     NEXT FIELD CURRENT  
#                  END IF                                      
#               END IF            
#
#            END IF 
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_master.faah032
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_master.faah032_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_master.faah032_desc
#160426-00014#33--mark--end--lujh

#160426-00014#33--add--str--lujh
            IF NOT cl_null(g_master.faah032) THEN
               CALL s_afa_comp_chk(g_master.site,g_master.faah032)
               RETURNING l_success,l_ld
               
               IF l_success = FALSE THEN 
                  LET g_master.faah032 = ''
                  CALL s_desc_get_department_desc(g_master.faah032) RETURNING g_master.faah032_desc
                  DISPLAY BY NAME g_master.faah032_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL s_desc_get_department_desc(g_master.faah032) RETURNING g_master.faah032_desc
            DISPLAY BY NAME g_master.faah032_desc
#160426-00014#33--add--end--lujh
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah032
            #add-point:BEFORE FIELD faah032 name="input.b.faah032"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah032
            #add-point:ON CHANGE faah032 name="input.g.faah032"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.site
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD site
            #add-point:ON ACTION controlp INFIELD site name="input.c.site"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.site             #給予default值
            LET g_qryparam.default2 = "" #g_master.ooefl003 #說明(簡稱)
            #給予arg
            LET g_qryparam.arg1 = "" #
            #161006-00005#35 20161024 mark by beckxie---S
            #LET g_qryparam.where = " ooef207 = 'Y' "
            #CALL q_ooef001()                                #呼叫開窗
            #161006-00005#35 20161024 mark by beckxie---E
            CALL q_ooef001_47()   #161006-00005#35 20161024 add by beckxie
            LET g_master.site = g_qryparam.return1              
            #LET g_master.ooefl003 = g_qryparam.return2 
            DISPLAY g_master.site TO site              #
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_master.site
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_master.site_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_master.site_desc            
            #DISPLAY g_master.ooefl003 TO ooefl003 #說明(簡稱)
            NEXT FIELD site                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.faah032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah032
            #add-point:ON ACTION controlp INFIELD faah032 name="input.c.faah032"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.faah032             #給予default值
            LET g_qryparam.default2 = "" #g_master.ooefl003 #說明(簡稱)
            #給予arg
            LET g_qryparam.arg1 = "" #
            
            CALL s_fin_account_center_sons_query('5',g_master.site,g_today,'1')
            CALL s_fin_account_center_comp_str()RETURNING l_origin_str
            CALL afar005_change_to_sql(l_origin_str)RETURNING l_origin_str
            #161006-00005#35 20161024 mark by beckxie---S
            #LET g_qryparam.where = " ooef003 = 'Y' AND ooef001 IN(",l_origin_str CLIPPED,") "
            #CALL q_ooef001()                                #呼叫開窗
            #161006-00005#35 20161024 mark by beckxie---E
            #161006-00005#35 20161024 add by beckxie---S
            LET g_qryparam.where = " ooef001 IN(",l_origin_str CLIPPED,") "
            CALL q_ooef001_2()
            #161006-00005#35 20161024 add by beckxie---E
            LET g_master.faah032 = g_qryparam.return1              
            #LET g_master.ooefl003 = g_qryparam.return2 
            DISPLAY g_master.faah032 TO faah032              #
            #DISPLAY g_master.ooefl003 TO ooefl003 #說明(簡稱)
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_master.faah032
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_master.faah032_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_master.faah032_desc            
            NEXT FIELD faah032                          #返回原欄位


            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON faah006,faah026,faah001,faah003,faah004
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.faah006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah006
            #add-point:ON ACTION controlp INFIELD faah006 name="construct.c.faah006"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #161111-00049#14--ADD--S--
            CALL s_axrt300_get_site(g_user,g_master.faah032,'2') RETURNING l_ld_str 
            LET l_ld_str = cl_replace_str(l_ld_str,"glaald","faalld")			   
            LET g_qryparam.where = l_ld_str  
            CALL q_faal001_1() 
            #161111-00049#14--ADD--E--
            #CALL q_faac001()           #161111-00049#14--MARK--                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah006  #顯示到畫面上
            NEXT FIELD faah006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah006
            #add-point:BEFORE FIELD faah006 name="construct.b.faah006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah006
            
            #add-point:AFTER FIELD faah006 name="construct.a.faah006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faah026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah026
            #add-point:ON ACTION controlp INFIELD faah026 name="construct.c.faah026"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah026  #顯示到畫面上
            NEXT FIELD faah026                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah026
            #add-point:BEFORE FIELD faah026 name="construct.b.faah026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah026
            
            #add-point:AFTER FIELD faah026 name="construct.a.faah026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faah001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah001
            #add-point:ON ACTION controlp INFIELD faah001 name="construct.c.faah001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #161111-00049#14--ADD--S--			  
		      LET g_qryparam.where = " faah032 = '",g_master.faah032,"'" 
			   #161111-00049#14--ADD--E--
            CALL q_faah001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah001  #顯示到畫面上
            NEXT FIELD faah001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah001
            #add-point:BEFORE FIELD faah001 name="construct.b.faah001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah001
            
            #add-point:AFTER FIELD faah001 name="construct.a.faah001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faah003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah003
            #add-point:ON ACTION controlp INFIELD faah003 name="construct.c.faah003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #161111-00049#14--ADD--S--
			   LET g_qryparam.where = " faah032 = '",g_master.faah032,"'" 
			   #161111-00049#14--ADD--E--
            CALL q_faah003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah003  #顯示到畫面上
            NEXT FIELD faah003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah003
            #add-point:BEFORE FIELD faah003 name="construct.b.faah003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah003
            
            #add-point:AFTER FIELD faah003 name="construct.a.faah003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faah004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah004
            #add-point:ON ACTION controlp INFIELD faah004 name="construct.c.faah004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #161111-00049#14--ADD--S--
			   LET g_qryparam.where = " faah032 = '",g_master.faah032,"'" 
			   #161111-00049#14--ADD--E--
            CALL q_faah004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah004  #顯示到畫面上
            NEXT FIELD faah004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah004
            #add-point:BEFORE FIELD faah004 name="construct.b.faah004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah004
            
            #add-point:AFTER FIELD faah004 name="construct.a.faah004"
            
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
            CALL afar005_get_buffer(l_dialog)
 
         ON ACTION qbe_select
            LET ls_wc = ""
            #需要用ITM類程式查詢方案在CONSTRUCT的功能，將值set到畫面上
            CALL cl_qbe_list("c") RETURNING ls_wc
            CALL afar005_get_buffer(l_dialog)
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
         CALL afar005_init()
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
                 CALL afar005_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = afar005_transfer_argv(ls_js)
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
 
{<section id="afar005.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION afar005_transfer_argv(ls_js)
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
   LET la_cmdrun.param[1] = g_master.wc
   LET la_cmdrun.param[2] = g_master.site
   LET la_cmdrun.param[3] = g_master.faah032
   #end add-point
 
   RETURN util.JSON.stringify( la_cmdrun )
END FUNCTION
 
{</section>}
 
{<section id="afar005.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION afar005_process(ls_js)
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
 
   LET g_rep_wcchp = cl_wcchp(g_master.wc,"faah006,faah026,faah001,faah003,faah004")  #取得列印條件
  
   #add-point:process段前處理 name="process.pre_process"
   
   #end add-point
 
   #預先計算progressbar迴圈次數   #r類不用計算進度條
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE afar005_process_cs CURSOR FROM ls_sql
#  FOREACH afar005_process_cs INTO
   #add-point:process段process name="process.process"
   CALL afar005_x01(g_master.wc,g_master.site,g_master.faah032)
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
 
{<section id="afar005.get_buffer" >}
PRIVATE FUNCTION afar005_get_buffer(p_dialog)
   DEFINE p_dialog   ui.DIALOG
   
   LET g_master.site = p_dialog.getFieldBuffer('site')
   LET g_master.faah032 = p_dialog.getFieldBuffer('faah032')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="afar005.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 法人組織檢查
# Memo...........:
# Usage..........: CALL afar005_comp_chk()
# Input parameter: 
# Return code....: TRUE/FALSE
# Date & Author..: 20150320 By huangrh
# Modify.........:
################################################################################
PRIVATE FUNCTION afar005_comp_chk()
DEFINE l_ooefstus         LIKE ooef_t.ooefstus
DEFINE l_ooef003          LIKE ooef_t.ooef003
DEFINE l_errno            LIKE type_t.chr50
 
   LET l_errno = ''
   SELECT ooefstus,ooef003 INTO l_ooefstus,l_ooef003
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_master.faah032
   
   CASE
      WHEN SQLCA.SQLCODE = 100    LET l_errno = 'aoo-00090'
      WHEN l_ooefstus = 'N'       LET l_errno = 'sub-01302'   #'aoo-00091'#160318-00005#9 mod
      WHEN l_ooef003 = 'N'        LET l_errno = 'anm-00037'
   END CASE
   
   IF NOT cl_null(l_errno) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = l_errno    
      LET g_errparam.extend = ''
      #160318-00005#9 --add--str
      LET g_errparam.replace[1] ='aooi100'
      LET g_errparam.replace[2] = cl_get_progname('aooi100',g_lang,"2")
      LET g_errparam.exeprog    ='aooi100'
      #160318-00005#9 --add--end
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
   ELSE
      RETURN TRUE
   END IF
END FUNCTION

################################################################################
# Descriptions...: 法人和資產中心檢查
# Memo...........:
# Usage..........: CALL afar005_site_comp_chk()
# Input parameter: 
# Return code....: TRUE/FALSE
# Date & Author..: 20150320 By huangrh
# Modify.........:
################################################################################
PRIVATE FUNCTION afar005_site_comp_chk()
DEFINE l_sql       STRING
DEFINE l_count     LIKE type_t.num5
DEFINE l_origin_str  STRING

   #资产中心范围包含 这个法人组织。
  CALL s_fin_create_account_center_tmp() 
  CALL s_fin_account_center_sons_query('5',g_master.site,g_today,'1')
  CALL s_fin_account_center_comp_str() RETURNING l_origin_str
  
  
  CALL afar005_change_to_sql(l_origin_str)RETURNING l_origin_str
  LET l_origin_str = "(",l_origin_str,")"
  LET l_sql = " SELECT COUNT(*) FROM ooef_t ",
              "  WHERE ooefent = '",g_enterprise,"' AND ooef017='",g_master.faah032,"'",
              "    AND ooef001 IN ",l_origin_str


   PREPARE sel_fabacomp FROM l_sql
   EXECUTE sel_fabacomp INTO l_count
   IF cl_null(l_count)THEN LET l_count = 0 END IF
 
   IF l_count = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'afa-00294'      
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF
 
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 將取回的字串轉換為SQL條件
# Memo...........:
# Usage..........: CALL afar005_change_to_sql(p_wc)
#                  RETURNING r_wc
# Input parameter: p_wc
# Return code....: r_wc
# Date & Author..: 20150320 By huangrh
# Modify.........:
################################################################################
PRIVATE FUNCTION afar005_change_to_sql(p_wc)
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
   LET r_wc = "'",l_str,"'"

   RETURN r_wc
END FUNCTION

#end add-point
 
{</section>}
 
