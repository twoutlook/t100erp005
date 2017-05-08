#該程式未解開Section, 採用最新樣板產出!
{<section id="abmr617.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2015-10-28 15:43:32), PR版次:0002(2016-10-12 13:15:33)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000041
#+ Filename...: abmr617
#+ Description: 集團產品結構插件位置分析表
#+ Creator....: 05423(2015-10-28 13:50:21)
#+ Modifier...: 05423 -SD/PR- 06978
 
{</section>}
 
{<section id="abmr617.global" >}
#應用 r01 樣板自動產生(Version:21)
#add-point:填寫註解說明 name="global.memo"
#Memos
#161011-00040#1  2016/10/12 By ywtsai  修正報表執行後將l_wc陣列資料清空，避免後續執行受舊值影響
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
       bmbc003 LIKE bmbc_t.bmbc003, 
   bmbc010 LIKE bmbc_t.bmbc010, 
   l_level LIKE type_t.chr500, 
   l_pr LIKE type_t.chr500,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
 TYPE type_g_bmbc_d        RECORD
   bmbc001  LIKE bmbc_t.bmbc001,          #主件料號
   imaal003 LIKE imaal_t.imaal003,        #品名
   imaal004 LIKE imaal_t.imaal004,        #規格
   bmbc002  LIKE bmbc_t.bmbc002,          #特性
   bmbc005  LIKE bmbc_t.bmbc005           #有效日期
END RECORD

TYPE type_wc RECORD
   wc    STRING
END RECORD

DEFINE l_wc              DYNAMIC ARRAY OF type_wc
DEFINE g_rec_b               LIKE type_t.num5
DEFINE l_ac                  LIKE type_t.num5
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_insert              LIKE type_t.chr5              #是否導到其他page
DEFINE l_n                   LIKE type_t.num5
DEFINE l_count               LIKE type_t.num5
 
DEFINE g_bmbc_d          DYNAMIC ARRAY OF type_g_bmbc_d
DEFINE g_bmbc_d_t        type_g_bmbc_d

DEFINE g_detail_cnt          LIKE type_t.num5              #單身總筆數
DEFINE g_detail_idx          LIKE type_t.num5              #單身目前所在筆數
DEFINE g_current_row         LIKE type_t.num5              #Browser所在筆數
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="abmr617.main" >}
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
   CALL cl_ap_init("abm","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point   
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
      CALL util.JSON.parse(ls_js,g_master)      #r類背景參數解析入口
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL abmr617_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_abmr617 WITH FORM cl_ap_formpath("abm",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL abmr617_init()
 
      #進入選單 Menu (="N")
      CALL abmr617_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_abmr617
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="abmr617.init" >}
#+ 初始化作業
PRIVATE FUNCTION abmr617_init()
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
   LET g_master.l_level = '1'
   LET g_master.l_pr = 'N'
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="abmr617.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION abmr617_ui_dialog()
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE ls_result  STRING
   DEFINE l_str      STRING      #用来区分开窗回传值 zhujing 20150906 add
   DEFINE l_start    LIKE type_t.num5  #zhujing 20150906 add
   DEFINE l_end      LIKE type_t.num5  #zhujing 20150906 add
   DEFINE l_cnt      LIKE type_t.num5  #zhujing 20150906 add
   #end add-point
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
#   CALL abmr617_create_tmp()
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.l_level,g_master.l_pr 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_level
            #add-point:BEFORE FIELD l_level name="input.b.l_level"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_level
            
            #add-point:AFTER FIELD l_level name="input.a.l_level"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_level
            #add-point:ON CHANGE l_level name="input.g.l_level"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_pr
            #add-point:BEFORE FIELD l_pr name="input.b.l_pr"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_pr
            
            #add-point:AFTER FIELD l_pr name="input.a.l_pr"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_pr
            #add-point:ON CHANGE l_pr name="input.g.l_pr"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.l_level
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_level
            #add-point:ON ACTION controlp INFIELD l_level name="input.c.l_level"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_pr
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_pr
            #add-point:ON ACTION controlp INFIELD l_pr name="input.c.l_pr"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON bmbc003,bmbc010
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.bmbc003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmbc003
            #add-point:ON ACTION controlp INFIELD bmbc003 name="construct.c.bmbc003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_bmba003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bmbc003  #顯示到畫面上
            NEXT FIELD bmbc003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmbc003
            #add-point:BEFORE FIELD bmbc003 name="construct.b.bmbc003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmbc003
            
            #add-point:AFTER FIELD bmbc003 name="construct.a.bmbc003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmbc010
            #add-point:BEFORE FIELD bmbc010 name="construct.b.bmbc010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmbc010
            
            #add-point:AFTER FIELD bmbc010 name="construct.a.bmbc010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bmbc010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmbc010
            #add-point:ON ACTION controlp INFIELD bmbc010 name="construct.c.bmbc010"
            
            #END add-point
 
 
 
            
            #add-point:其他管控 name="cs.other"
            
            #end add-point
            
         END CONSTRUCT
 
 
 
      
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT ARRAY g_bmbc_d FROM s_detail1.*
            ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, 
                  INSERT ROW = TRUE,
                  DELETE ROW = TRUE,
                  APPEND ROW = TRUE)
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_bmbc_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
           LET g_rec_b = g_bmbc_d.getLength()



         BEFORE ROW
#            LET l_insert = FALSE
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
                        
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
#            CALL s_transaction_begin()
 
            LET g_rec_b = g_bmbc_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_bmbc_d[l_ac].bmbc001 IS NOT NULL
 
            THEN
               
               LET g_bmbc_d_t.* = g_bmbc_d[l_ac].*  #BACKUP
 
               CALL cl_set_comp_entry("bmbc001,bmbc002,bmbc005",TRUE)
               #add-point:modify段after_set_entry_b

               #end add-point  

            END IF
         
         BEFORE INSERT
#            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            INITIALIZE g_bmbc_d[l_ac].* TO NULL 
            INITIALIZE g_bmbc_d_t.* TO NULL 
            LET g_bmbc_d_t.* = g_bmbc_d[l_ac].*     #新輸入資料
            LET g_bmbc_d[l_ac].bmbc002 = NULL
         
         AFTER INSERT
#            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
 
               LET INT_FLAG = 0
               CANCEL INSERT
           END IF
           IF cl_null(g_bmbc_d[l_ac].bmbc001) THEN
               CANCEL INSERT
           END IF
           IF cl_null(g_bmbc_d[l_ac].bmbc005) AND NOT cl_null(g_bmbc_d[l_ac].bmbc001) THEN
               LET g_bmbc_d[l_ac].bmbc005 = cl_get_current()
               DISPLAY g_bmbc_d[l_ac].bmbc005 TO bmbc005
           END IF



#               CALL s_transaction_end('Y','0')
               
               LET g_rec_b = g_rec_b + 1
             

         
         AFTER FIELD bmbc001
            IF NOT cl_null(g_bmbc_d[g_detail_idx].bmbc001)  THEN 
               SELECT COUNT(imaa001) INTO l_count FROM imaa_t WHERE imaa001 = g_bmbc_d[g_detail_idx].bmbc001 AND imaaent = g_enterprise   
               IF l_count = 0 THEN
#                  CALL s_transaction_end('N','0')
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code   = "aim-00001"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_bmbc_d[g_detail_idx].bmbc001=g_bmbc_d_t.bmbc001
                  DISPLAY g_bmbc_d[g_detail_idx].bmbc001 TO bmbc001
                  NEXT FIELD bmbc001
               ELSE
#                  SELECT COUNT(bmbc001) INTO l_count FROM bmbc_t WHERE bmbc001 = g_bmbc_d[g_detail_idx].bmbc001 AND bmbcent = g_enterprise    #2015-11-30 zhujing marked
                  SELECT COUNT(bmaa001) INTO l_count FROM bmaa_t WHERE bmaa001 = g_bmbc_d[g_detail_idx].bmbc001 AND bmaaent = g_enterprise     #2015-11-30 zhujing mod
                  IF l_count = 0 THEN
#                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code   = "abm-00264"   #2015-11-30 zhujing marked        
                     LET g_errparam.code   = "abm-00247"    #2015-11-30 zhujing mod
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     LET g_bmbc_d[g_detail_idx].bmbc001=g_bmbc_d_t.bmbc001
                     DISPLAY g_bmbc_d[g_detail_idx].bmbc001 TO bmbc001
                     NEXT FIELD bmbc001
                  ELSE
                     SELECT imaal003,imaal004 INTO g_bmbc_d[g_detail_idx].imaal003,g_bmbc_d[g_detail_idx].imaal004
#                     FROM bmbc_t LEFT OUTER JOIN imaal_t ON bmbc001 = imaal001 AND bmbcent = imaalent AND imaal002 = g_dlang #2015-11-30 zhujing marked        
#                     WHERE bmbc001 = g_bmbc_d[g_detail_idx].bmbc001 AND bmbcent = g_enterprise                               #2015-11-30 zhujing marked        
                     FROM bmaa_t LEFT OUTER JOIN imaal_t ON bmaa001 = imaal001 AND bmaaent = imaalent AND imaal002 = g_dlang  #2015-11-30 zhujing mod
                     WHERE bmaa001 = g_bmbc_d[g_detail_idx].bmbc001 AND bmaaent = g_enterprise                                #2015-11-30 zhujing mod
                     LET g_bmbc_d_t.bmbc001 = g_bmbc_d[g_detail_idx].bmbc001
                     DISPLAY g_bmbc_d[g_detail_idx].imaal003 TO bmbc001_desc
                     DISPLAY g_bmbc_d[g_detail_idx].imaal004 TO bmbc001_desc_1   
                  END IF
               END IF
               IF NOT cl_null(g_bmbc_d[g_detail_idx].bmbc002) THEN
#                  SELECT COUNT(bmbc002) INTO l_count FROM bmbc_t WHERE bmbc001 = g_bmbc_d[g_detail_idx].bmbc001 AND bmbc002 = g_bmbc_d[g_detail_idx].bmbc002 AND bmbcent = g_enterprise     #2015-11-30 zhujing marked
                  SELECT COUNT(bmaa002) INTO l_count FROM bmaa_t WHERE bmaa001 = g_bmbc_d[g_detail_idx].bmbc001 AND bmaa002 = g_bmbc_d[g_detail_idx].bmbc002 AND bmaaent = g_enterprise      #2015-11-30 zhujing mod
                  IF l_count = 0 THEN
#                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code   = "abm-00263"    #主件料号(bmbc001)+特性(bmbc002)不存在于[产品结构插件位置档(bmbc_t)]    #2015-11-30 zhujing marked
                     LET g_errparam.code   = "abm-00085"     #2015-11-30 zhujing mod
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     LET g_bmbc_d[g_detail_idx].bmbc002=g_bmbc_d_t.bmbc002
                     DISPLAY g_bmbc_d[g_detail_idx].bmbc002 TO bmbc002
                     NEXT FIELD bmbc002
                  ELSE
                     LET g_bmbc_d_t.bmbc002 = g_bmbc_d[g_detail_idx].bmbc002
                  END IF   
                  
               END IF

               DISPLAY g_bmbc_d[g_detail_idx].imaal003 TO bmbc001_desc
               DISPLAY g_bmbc_d[g_detail_idx].imaal004 TO bmbc001_desc_1
               DISPLAY g_bmbc_d[g_detail_idx].bmbc002 TO bmbc002
            ELSE 
               INITIALIZE g_bmbc_d[g_detail_idx].imaal003 TO NULL
               INITIALIZE g_bmbc_d[g_detail_idx].imaal004 TO NULL
               INITIALIZE g_bmbc_d[g_detail_idx].bmbc002 TO NULL
               DISPLAY g_bmbc_d[g_detail_idx].imaal003 TO bmbc001_desc
               DISPLAY g_bmbc_d[g_detail_idx].imaal004 TO bmbc001_desc_1
               DISPLAY g_bmbc_d[g_detail_idx].bmbc002 TO bmbc002
            END IF    
            IF cl_null(g_bmbc_d[g_detail_idx].bmbc005) AND NOT cl_null(g_bmbc_d[g_detail_idx].bmbc001) THEN
               LET g_bmbc_d[g_detail_idx].bmbc005 = cl_get_current()
               DISPLAY g_bmbc_d[g_detail_idx].bmbc005 TO bmbc005
            END IF       
            IF cl_null(g_bmbc_d[g_detail_idx].bmbc001) AND cl_null(g_bmbc_d[g_detail_idx].bmbc002) THEN
               CALL cl_set_comp_required("bmbc001,bmbc002,bmbc005",FALSE)
               INITIALIZE g_bmbc_d[g_detail_idx].bmbc005 TO NULL
            ELSE
               CALL cl_set_comp_required("bmbc001,bmbc002,bmbc005",TRUE)
            END IF
         
         BEFORE FIELD bmbc001
         
         ON CHANGE bmbc001
            IF NOT cl_null(g_bmbc_d[g_detail_idx].bmbc001)  THEN 
               SELECT COUNT(imaa001) INTO l_count FROM imaa_t WHERE imaa001 = g_bmbc_d[g_detail_idx].bmbc001 AND imaaent = g_enterprise   
               IF l_count = 0 THEN
#                  CALL s_transaction_end('N','0')
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code   = "aim-00001"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_bmbc_d[g_detail_idx].bmbc001=g_bmbc_d_t.bmbc001
                  DISPLAY g_bmbc_d[g_detail_idx].bmbc001 TO bmbc001
                  NEXT FIELD bmbc001
               ELSE
#                  SELECT COUNT(bmbc001) INTO l_count FROM bmbc_t WHERE bmbc001 = g_bmbc_d[g_detail_idx].bmbc001 AND bmbcent = g_enterprise    #2015-11-30 zhujing marked
                  SELECT COUNT(bmaa001) INTO l_count FROM bmaa_t WHERE bmaa001 = g_bmbc_d[g_detail_idx].bmbc001 AND bmaaent = g_enterprise     #2015-11-30 zhujing mod
                  IF l_count = 0 THEN
#                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code   = "abm-00264"   #2015-11-30 zhujing marked        
                     LET g_errparam.code   = "abm-00247"    #2015-11-30 zhujing mod
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     LET g_bmbc_d[g_detail_idx].bmbc001=g_bmbc_d_t.bmbc001
                     DISPLAY g_bmbc_d[g_detail_idx].bmbc001 TO bmbc001
                     NEXT FIELD bmbc001
                  ELSE
                     SELECT imaal003,imaal004 INTO g_bmbc_d[g_detail_idx].imaal003,g_bmbc_d[g_detail_idx].imaal004
#                     FROM bmbc_t LEFT OUTER JOIN imaal_t ON bmbc001 = imaal001 AND bmbcent = imaalent AND imaal002 = g_dlang #2015-11-30 zhujing marked        
#                     WHERE bmbc001 = g_bmbc_d[g_detail_idx].bmbc001 AND bmbcent = g_enterprise                               #2015-11-30 zhujing marked        
                     FROM bmaa_t LEFT OUTER JOIN imaal_t ON bmaa001 = imaal001 AND bmaaent = imaalent AND imaal002 = g_dlang  #2015-11-30 zhujing mod
                     WHERE bmaa001 = g_bmbc_d[g_detail_idx].bmbc001 AND bmaaent = g_enterprise                                #2015-11-30 zhujing mod
                     LET g_bmbc_d_t.bmbc001 = g_bmbc_d[g_detail_idx].bmbc001
                     DISPLAY g_bmbc_d[g_detail_idx].imaal003 TO bmbc001_desc
                     DISPLAY g_bmbc_d[g_detail_idx].imaal004 TO bmbc001_desc_1   
                  END IF
               END IF
               IF NOT cl_null(g_bmbc_d[g_detail_idx].bmbc002) THEN
#                  SELECT COUNT(bmbc002) INTO l_count FROM bmbc_t WHERE bmbc001 = g_bmbc_d[g_detail_idx].bmbc001 AND bmbc002 = g_bmbc_d[g_detail_idx].bmbc002 AND bmbcent = g_enterprise     #2015-11-30 zhujing marked
                  SELECT COUNT(bmaa002) INTO l_count FROM bmaa_t WHERE bmaa001 = g_bmbc_d[g_detail_idx].bmbc001 AND bmaa002 = g_bmbc_d[g_detail_idx].bmbc002 AND bmaaent = g_enterprise      #2015-11-30 zhujing mod
                  IF l_count = 0 THEN
#                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code   = "abm-00263"    #主件料号(bmbc001)+特性(bmbc002)不存在于[产品结构插件位置档(bmbc_t)]    #2015-11-30 zhujing marked
                     LET g_errparam.code   = "abm-00085"     #2015-11-30 zhujing mod
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     LET g_bmbc_d[g_detail_idx].bmbc002=g_bmbc_d_t.bmbc002
                     DISPLAY g_bmbc_d[g_detail_idx].bmbc002 TO bmbc002
                     NEXT FIELD bmbc002
                  ELSE
                     LET g_bmbc_d_t.bmbc002 = g_bmbc_d[g_detail_idx].bmbc002
                  END IF   
                  
               END IF

               DISPLAY g_bmbc_d[g_detail_idx].imaal003 TO bmbc001_desc
               DISPLAY g_bmbc_d[g_detail_idx].imaal004 TO bmbc001_desc_1
               DISPLAY g_bmbc_d[g_detail_idx].bmbc002 TO bmbc002
            ELSE 
               INITIALIZE g_bmbc_d[g_detail_idx].imaal003 TO NULL
               INITIALIZE g_bmbc_d[g_detail_idx].imaal004 TO NULL
               INITIALIZE g_bmbc_d[g_detail_idx].bmbc002 TO NULL
               DISPLAY g_bmbc_d[g_detail_idx].imaal003 TO bmbc001_desc
               DISPLAY g_bmbc_d[g_detail_idx].imaal004 TO bmbc001_desc_1
               DISPLAY g_bmbc_d[g_detail_idx].bmbc002 TO bmbc002
            END IF  
       
         AFTER FIELD bmbc002
            IF NOT cl_null(g_bmbc_d[g_detail_idx].bmbc002) THEN
 
               SELECT COUNT(imaa001) INTO l_count FROM imaa_t WHERE imaa001 = g_bmbc_d[g_detail_idx].bmbc001 AND imaaent = g_enterprise   
               IF l_count = 0 THEN
#                  CALL s_transaction_end('N','0')
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code   = "aim-00001"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_bmbc_d[g_detail_idx].bmbc001=g_bmbc_d_t.bmbc001
                  DISPLAY g_bmbc_d[g_detail_idx].bmbc001 TO bmbc001
                  NEXT FIELD bmbc001
               ELSE
#                  SELECT COUNT(bmbc001) INTO l_count FROM bmbc_t WHERE bmbc001 = g_bmbc_d[g_detail_idx].bmbc001 AND bmbcent = g_enterprise    #2015-11-30 zhujing marked
                  SELECT COUNT(bmaa001) INTO l_count FROM bmaa_t WHERE bmaa001 = g_bmbc_d[g_detail_idx].bmbc001 AND bmaaent = g_enterprise     #2015-11-30 zhujing mod
                  IF l_count = 0 THEN
#                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code   = "abm-00264"   #2015-11-30 zhujing marked        
                     LET g_errparam.code   = "abm-00247"    #2015-11-30 zhujing mod
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     LET g_bmbc_d[g_detail_idx].bmbc001=g_bmbc_d_t.bmbc001
                     DISPLAY g_bmbc_d[g_detail_idx].bmbc001 TO bmbc001
                     NEXT FIELD bmbc001
                  ELSE
#                  SELECT COUNT(bmbc002) INTO l_count FROM bmbc_t WHERE bmbc001 = g_bmbc_d[g_detail_idx].bmbc001 AND bmbc002 = g_bmbc_d[g_detail_idx].bmbc002 AND bmbcent = g_enterprise     #2015-11-30 zhujing marked
                  SELECT COUNT(bmaa002) INTO l_count FROM bmaa_t WHERE bmaa001 = g_bmbc_d[g_detail_idx].bmbc001 AND bmaa002 = g_bmbc_d[g_detail_idx].bmbc002 AND bmaaent = g_enterprise      #2015-11-30 zhujing mod
                  IF l_count = 0 THEN
#                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code   = "abm-00263"    #主件料号(bmbc001)+特性(bmbc002)不存在于[产品结构插件位置档(bmbc_t)]    #2015-11-30 zhujing marked
                     LET g_errparam.code   = "abm-00085"     #2015-11-30 zhujing mod
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        LET g_bmbc_d[g_detail_idx].bmbc002=g_bmbc_d_t.bmbc002
                        DISPLAY g_bmbc_d[g_detail_idx].bmbc002 TO bmbc002
                        NEXT FIELD bmbc002
                     ELSE
                        LET g_bmbc_d_t.bmbc002 = g_bmbc_d[g_detail_idx].bmbc002
                     END IF
                  END IF
               END IF
            ELSE LET g_bmbc_d[g_detail_idx].bmbc002 = ' '
            END IF               
            
         BEFORE FIELD bmbc002
            IF cl_null(g_bmbc_d[g_detail_idx].bmbc002) THEN
               LET g_bmbc_d[g_detail_idx].bmbc002 = ' '
            END IF
            
         ON CHANGE bmbc002
            IF NOT cl_null(g_bmbc_d[g_detail_idx].bmbc002) THEN
 
               SELECT COUNT(imaa001) INTO l_count FROM imaa_t WHERE imaa001 = g_bmbc_d[g_detail_idx].bmbc001 AND imaaent = g_enterprise   
               IF l_count = 0 THEN
#                  CALL s_transaction_end('N','0')
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code   = "aim-00001"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_bmbc_d[g_detail_idx].bmbc001=g_bmbc_d_t.bmbc001
                  DISPLAY g_bmbc_d[g_detail_idx].bmbc001 TO bmbc001
                  NEXT FIELD bmbc001
               ELSE
#                  SELECT COUNT(bmbc001) INTO l_count FROM bmbc_t WHERE bmbc001 = g_bmbc_d[g_detail_idx].bmbc001 AND bmbcent = g_enterprise    #2015-11-30 zhujing marked
                  SELECT COUNT(bmaa001) INTO l_count FROM bmaa_t WHERE bmaa001 = g_bmbc_d[g_detail_idx].bmbc001 AND bmaaent = g_enterprise     #2015-11-30 zhujing mod
                  IF l_count = 0 THEN
#                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code   = "abm-00264"   #2015-11-30 zhujing marked        
                     LET g_errparam.code   = "abm-00247"    #2015-11-30 zhujing mod
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     LET g_bmbc_d[g_detail_idx].bmbc001=g_bmbc_d_t.bmbc001
                     DISPLAY g_bmbc_d[g_detail_idx].bmbc001 TO bmbc001
                     NEXT FIELD bmbc001
                  ELSE
#                  SELECT COUNT(bmbc002) INTO l_count FROM bmbc_t WHERE bmbc001 = g_bmbc_d[g_detail_idx].bmbc001 AND bmbc002 = g_bmbc_d[g_detail_idx].bmbc002 AND bmbcent = g_enterprise     #2015-11-30 zhujing marked
                  SELECT COUNT(bmaa002) INTO l_count FROM bmaa_t WHERE bmaa001 = g_bmbc_d[g_detail_idx].bmbc001 AND bmaa002 = g_bmbc_d[g_detail_idx].bmbc002 AND bmaaent = g_enterprise      #2015-11-30 zhujing mod
                  IF l_count = 0 THEN
#                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code   = "abm-00263"    #主件料号(bmbc001)+特性(bmbc002)不存在于[产品结构插件位置档(bmbc_t)]    #2015-11-30 zhujing marked
                     LET g_errparam.code   = "abm-00085"     #2015-11-30 zhujing mod
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        LET g_bmbc_d[g_detail_idx].bmbc002=g_bmbc_d_t.bmbc002
                        DISPLAY g_bmbc_d[g_detail_idx].bmbc002 TO bmbc002
                        NEXT FIELD bmbc002
                     END IF
                  END IF
               END IF
            ELSE LET g_bmbc_d[g_detail_idx].bmbc002 = ' '

            END IF               
          
         AFTER FIELD bmbc005
       
         BEFORE FIELD bmbc005
            IF cl_null(g_bmbc_d[g_detail_idx].bmbc005) THEN
               LET g_bmbc_d[g_detail_idx].bmbc005 = cl_get_current()
               DISPLAY g_bmbc_d[g_detail_idx].bmbc005 TO bmbc005
            END IF  
            
         ON CHANGE bmbc005
         
         ON ACTION controlp INFIELD bmbc001
            #zhujing-20150906-add----(S)
            LET l_str = NULL
            LET l_start = 0
            LET l_end = 0
            LET l_cnt = 0
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'm'
            #zhujing-20150906-add----(E)
            LET g_qryparam.reqry = FALSE
#            LET g_qryparam.where = " ((bmaa001,bmaa002) IN (SELECT bmbc001,bmbc002 FROM bmbc_t WHERE bmbcent = ",g_enterprise," )) "  #2015-11-30 zhujing marked
#            CALL q_bmaa001_4()              #呼叫開窗          #2015-11-30 zhujing marked (只要存在bmaa_t即可)
            CALL q_bmaa001_5()              #呼叫開窗     #151014 polly add(未確認也需查詢到)
            #zhujing-20150906-modify----(S)
            IF g_qryparam.str_array.getLength() > 0 THEN
               IF g_qryparam.str_array.getLength() = 1 THEN
                  LET l_str = g_qryparam.str_array[1]           #將開窗取得的值回傳到變數 
                  LET l_start = 1
                  LET l_end = l_str.getIndexOf('|',1)
                  LET g_bmbc_d[l_ac].bmbc001 = l_str.subString(l_start,l_end-1) 
                  LET l_start = l_end + 1
                  LET l_end = l_str.getIndexOf('|',l_start)
                  LET g_bmbc_d[l_ac].imaal003 = l_str.subString(l_start,l_end-1) 
                  LET l_start = l_end + 1
                  LET l_end = l_str.getIndexOf('|',l_start)
                  LET g_bmbc_d[l_ac].imaal004 = l_str.subString(l_start,l_end-1) 
                  LET l_start = l_end + 1
                  LET l_end = l_str.getLength()
                  LET g_bmbc_d[l_ac].bmbc002 = l_str.subString(l_start,l_end) 

               ELSE
                  FOR l_cnt = 0 TO g_qryparam.str_array.getLength()-1
                     LET l_str = g_qryparam.str_array[l_cnt+1]           #將開窗取得的值回傳到變數 
                     LET l_start = 1
                     LET l_end = l_str.getIndexOf('|',1)
                     LET g_bmbc_d[l_ac+l_cnt].bmbc001 = l_str.subString(l_start,l_end-1) 
                     LET l_start = l_end + 1
                     LET l_end = l_str.getIndexOf('|',l_start)
                     LET g_bmbc_d[l_ac+l_cnt].imaal003 = l_str.subString(l_start,l_end-1) 
                     LET l_start = l_end + 1
                     LET l_end = l_str.getIndexOf('|',l_start)
                     LET g_bmbc_d[l_ac+l_cnt].imaal004 = l_str.subString(l_start,l_end-1) 
                     LET l_start = l_end + 1
                     LET l_end = l_str.getLength()
                     LET g_bmbc_d[l_ac+l_cnt].bmbc002 = l_str.subString(l_start,l_end) 
                     LET g_bmbc_d[l_ac+l_cnt].bmbc005 = cl_get_current()
                  END FOR
                  CALL g_bmbc_d.deleteElement(l_ac+l_cnt)
               END IF
               DISPLAY g_bmbc_d[l_ac].bmbc001 TO bmbc001          #顯示到畫面上
               DISPLAY g_bmbc_d[l_ac].imaal003 TO bmbc001_desc    #顯示到畫面上
               DISPLAY g_bmbc_d[l_ac].imaal004 TO bmbc001_desc_1  #顯示到畫面上
               DISPLAY g_bmbc_d[l_ac].bmbc002 TO bmbc002          #顯示到畫面上
                           
            END IF
            #zhujing-20150906-modify----(E)
            
            NEXT FIELD bmbc001                     #返回原欄位

         ON ACTION controlp INFIELD bmbc002
         ON ACTION controlp INFIELD bmbc005
         
         AFTER ROW
#         CALL s_transaction_end('Y','0')
         AFTER INPUT
            IF cl_null(g_bmbc_d[l_ac].bmbc001) THEN 
               INITIALIZE g_bmbc_d[l_ac].* TO NULL
            END IF
    
            ON ACTION l_delete
               LET g_action_choice="l_delete"
               IF cl_ask_del_detail() THEN
                  INITIALIZE g_bmbc_d[g_detail_idx].*  TO NULL
                  CALL g_bmbc_d.deleteElement(g_detail_idx)
               END IF
               
               
            ON ACTION controlo    
               CALL FGL_SET_ARR_CURR(g_bmbc_d.getLength()+1)


 
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
            CALL cl_qbe_display_condition(FGL_GETENV("QUERYPLANID"), g_user)
            CALL abmr617_get_buffer(l_dialog)
 
         ON ACTION qbe_select
            LET ls_wc = ""
            #需要用ITM類程式查詢方案在CONSTRUCT的功能，將值set到畫面上
            CALL cl_qbe_list("c") RETURNING ls_wc
            CALL abmr617_get_buffer(l_dialog)
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
         CALL abmr617_init()
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
                 CALL abmr617_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = abmr617_transfer_argv(ls_js)
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
 
{<section id="abmr617.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION abmr617_transfer_argv(ls_js)
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
 
{<section id="abmr617.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION abmr617_process(ls_js)
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
   DEFINE l_ac       LIKE type_t.num5
   DEFINE l_chk      LIKE type_t.chr10
   DEFINE l_where    STRING
   #end add-point
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
 
   INITIALIZE lc_param TO NULL
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_r01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   LET g_rep_wcchp = cl_wcchp(g_master.wc,"bmbc003,bmbc010")  #取得列印條件
  
   #add-point:process段前處理 name="process.pre_process"
   FOR l_ac = 1 TO g_bmbc_d.getLength()
      IF cl_null(g_bmbc_d[l_ac].bmbc002) THEN
         LET g_bmbc_d[l_ac].bmbc002 = ' '
      END IF
      IF NOT cl_null(g_bmbc_d[l_ac].bmbc001) THEN
#         LET l_wc[l_ac].wc = " bmbc001 = '",g_bmbc_d[l_ac].bmbc001 CLIPPED,"' AND bmbc002 = '",g_bmbc_d[l_ac].bmbc002 ,"' "     #2015-11-30 zhujing marked
         LET l_wc[l_ac].wc = " bmaa001 = '",g_bmbc_d[l_ac].bmbc001 CLIPPED,"' AND bmaa002 = '",g_bmbc_d[l_ac].bmbc002 ,"' "      #2015-11-30 zhujing mod
         IF NOT cl_null(g_bmbc_d[l_ac].bmbc005) THEN
#            LET l_wc[l_ac].wc = l_wc[l_ac].wc," AND (to_char(bmbc005,'yyyy-mm-dd hh24:mi:ss') <= '",g_bmbc_d[l_ac].bmbc005 CLIPPED,"' ) "   #2015-11-30 zhujing marked
            LET l_wc[l_ac].wc = l_wc[l_ac].wc," AND (to_char(bmba005,'yyyy-mm-dd hh24:mi:ss') <= '",g_bmbc_d[l_ac].bmbc005 CLIPPED,"' ) "    #2015-11-30 zhujing mod
            LET l_wc[l_ac].wc = l_wc[l_ac].wc," AND (bmba006 IS NULL OR to_char(bmba006,'yyyy-mm-dd hh24:mi:ss') >= '",g_bmbc_d[l_ac].bmbc005 CLIPPED,"' ) "    #2016-2-1 zhujing mod 失效时间
         END IF
      END IF   
   END FOR
   IF NOT cl_null(l_where) THEN
      LET l_where = NULL
   END IF
   IF cl_null(g_master.wc) THEN
      LET g_master.wc = " 1=1 "
   END IF
   FOR l_count = 1 TO l_wc.getLength()
      IF NOT cl_null(l_wc[l_count].wc) THEN
         IF l_count = 1 THEN
            LET l_where = " ( ",l_wc[l_count].wc CLIPPED,") "
         ELSE
            LET l_where = l_where , " OR ( ",l_wc[l_count].wc CLIPPED,") "
         END IF
      END IF
   END FOR
   LET l_chk = g_argv[01]
   CASE l_chk
      WHEN '1'
#         LET g_master.wc = g_master.wc CLIPPED," AND bmbcsite = 'ALL' AND bmbcent = ",g_enterprise CLIPPED," AND ( ",l_where CLIPPED," ) "  #2015-11-30 zhujing marked
         LET g_master.wc = g_master.wc CLIPPED," AND bmaasite = 'ALL' AND bmaaent = ",g_enterprise CLIPPED," AND ( ",l_where CLIPPED," ) "   #2015-11-30 zhujing mod
      WHEN '2'
#         LET g_master.wc = g_master.wc CLIPPED," AND bmbcsite = '",g_site CLIPPED,"' AND bmbcent = ",g_enterprise CLIPPED," AND ( ",l_where CLIPPED," ) "  #2015-11-30 zhujing marked
         LET g_master.wc = g_master.wc CLIPPED," AND bmaasite = '",g_site CLIPPED,"' AND bmaaent = ",g_enterprise CLIPPED," AND ( ",l_where CLIPPED," ) "   #2015-11-30 zhujing mod
   END CASE
   CALL abmr617_x01(g_master.wc,g_master.l_level,g_master.l_pr,l_chk)
   #161011-00040#1 add---start---
   FOR l_ac = 1 TO l_wc.getLength()
       INITIALIZE l_wc[l_ac].* TO NULL
   END FOR
   #161011-00040#1 add---end---
   #end add-point
 
   #預先計算progressbar迴圈次數   #r類不用計算進度條
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE abmr617_process_cs CURSOR FROM ls_sql
#  FOREACH abmr617_process_cs INTO
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
 
{<section id="abmr617.get_buffer" >}
PRIVATE FUNCTION abmr617_get_buffer(p_dialog)
   DEFINE p_dialog   ui.DIALOG
   
   LET g_master.l_level = p_dialog.getFieldBuffer('l_level')
   LET g_master.l_pr = p_dialog.getFieldBuffer('l_pr')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abmr617.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

#end add-point
 
{</section>}
 
