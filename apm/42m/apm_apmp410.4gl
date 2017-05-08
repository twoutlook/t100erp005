#該程式未解開Section, 採用最新樣板產出!
{<section id="apmp410.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0008(2015-01-22 18:46:28), PR版次:0008(2016-12-31 13:07:36)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000387
#+ Filename...: apmp410
#+ Description: 請購單結案/留置作業
#+ Creator....: 02040(2014-04-22 10:13:21)
#+ Modifier...: 01588 -SD/PR- 04441
 
{</section>}
 
{<section id="apmp410.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#Memos
#160816-00001#7  16/08/17 By 08742     抓取理由碼改CALL sub
#161117-00028#1  16/11/17 By wuxja     按照SA说法，二次筛选等按钮P类先拿掉
#161231-00005#1  16/12/31 By Whitney   add ent
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
 
   #end add-point
        wc               STRING
                     END RECORD
 
TYPE type_g_detail_d RECORD
#add-point:自定義模組變數(Module Variable)  #注意要在add-point內寫入END RECORD name="global.variable"
          sel            LIKE   type_t.chr1,
          closed         LIKE   pmdb_t.pmdb051,
          closed_desc    LIKE   type_t.chr500,
          pmdadocno      LIKE   pmda_t.pmdadocno,
          pmdadocdt      LIKE   pmda_t.pmdadocdt,
          pmda002        LIKE   pmda_t.pmda002,
          pmda002_desc   LIKE   type_t.chr500,
          pmda003        LIKE   pmda_t.pmda003,
          pmda003_desc   LIKE   type_t.chr500
          END RECORD
          
TYPE type_g_pmdb_d RECORD
          sel2           LIKE   type_t.chr1,
          closed2        LIKE   pmdb_t.pmdb051,  
          closed2_desc   LIKE   type_t.chr500,          
          pmdbdocno      LIKE   pmdb_t.pmdbdocno,
          pmdbseq        LIKE   pmdb_t.pmdbseq,
          pmdb004        LIKE   pmdb_t.pmdb004,
          pmdb004_desc   LIKE   type_t.chr500,
          imaal004         LIKE   type_t.chr80,
          pmdb005        LIKE   pmdb_t.pmdb005,
          pmdb007        LIKE   pmdb_t.pmdb007,
          pmdb007_desc   LIKE   type_t.chr500,
          pmdb006        LIKE   pmdb_t.pmdb006,
          pmdb009        LIKE   pmdb_t.pmdb009,
          pmdb009_desc   LIKE   type_t.chr500, 
          pmdb008        LIKE   pmdb_t.pmdb008,  
          pmdb030        LIKE   pmdb_t.pmdb030,    
          pmdb031        LIKE   pmdb_t.pmdb031, 
          pmdb031_desc   LIKE   type_t.chr500, 
          pmdb032        LIKE   pmdb_t.pmdb032,    
          pmdb049        LIKE   pmdb_t.pmdb049,
          nopmdb049      LIKE   pmdb_t.pmdb049  
          END RECORD   
DEFINE g_acc               LIKE gzcb_t.gzcb007
DEFINE g_detail_idx        LIKE type_t.num5
DEFINE g_detail2_idx       LIKE type_t.num5
DEFINE g_pmdb_d  DYNAMIC ARRAY OF type_g_pmdb_d
DEFINE g_tmp_d   DYNAMIC ARRAY OF RECORD
            sel2           LIKE   type_t.chr1,
            closed2        LIKE   pmdb_t.pmdb051,
            pmdbdocno      LIKE   pmdb_t.pmdbdocno,
            pmdbseq        LIKE   pmdb_t.pmdbseq,
            pmdb006        LIKE   pmdb_t.pmdb006,              #需求數量
            pmdb049        LIKE   pmdb_t.pmdb049               #已轉採購量
           ,closed1        LIKE   pmda_t.pmda023               #2015/01/22 by stellar add
                 END RECORD
DEFINE g_detail2_cnt       LIKE type_t.num5  
DEFINE l_ac1               LIKE type_t.num5
DEFINE g_type              LIKE type_t.chr1           #1時為結案作業；2時為取消結案作業 
DEFINE g_detail_d_t        type_g_detail_d
DEFINE g_pmdb_d_t          type_g_pmdb_d

#2015/01/22 by stellar add ----- (S)
DEFINE g_mode              LIKE type_t.chr1   #異動類型
DEFINE g_mode_o            LIKE type_t.chr1
#2015/01/22 by stellar add ----- (E)
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="apmp410.main" >}
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
   CALL cl_ap_init("apm","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   LET g_argv[1] = cl_replace_str(g_argv[1], '\"', '')
   IF NOT cl_null(g_argv[1]) THEN
      LET g_type = g_argv[1]
   END IF
   CALL apmp410_create_preview_tmp()
   LET g_acc = ''
   #抓取[T:系統分類值檔].[C:系統分類碼]=24且[T:系統分類值檔].[C:系統分類碼]=g_prog 的[T:系統分類值檔].[C:參考欄位>
   #SELECT gzcb004 INTO g_acc FROM gzcb_t WHERE gzcb001 = '24' AND gzcb002 = g_prog   #160816-00001#7 mark
   LET g_acc = s_fin_get_scc_value('24',g_prog,'2')  #160816-00001#7  Add
   
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apmp410 WITH FORM cl_ap_formpath("apm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apmp410_init()   
 
      #進入選單 Menu (="N")
      CALL apmp410_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_apmp410
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="apmp410.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION apmp410_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   IF g_type = '2' THEN
      CALL cl_set_comp_visible("closed,closed_desc,closed2,closed2_desc",FALSE)
   END IF
   CALL cl_set_combo_scc('b_pmdb032','2035')
   
   #2015/01/22 by stellar add ----- (S)
   #預設結案功能
   LET g_mode = '1'
   LET g_mode_o = g_mode
   LET g_acc = '258'
   #2015/01/22 by stellar add ----- (E)
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="apmp410.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmp410_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_sql            STRING
   DEFINE l_success        LIKE type_t.num5   
   DEFINE l_cnt            LIKE type_t.num5
   
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   LET g_detail2_cnt = g_pmdb_d.getLength()
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL apmp410_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         #2015/01/22 by stellar add ----- (S)
         #原只有結案功能，現在加上留置功能
         INPUT g_mode FROM l_mode ATTRIBUTE(WITHOUT DEFAULTS)
           ON CHANGE l_mode
              LET l_cnt = 0
              SELECT COUNT(*) INTO l_cnt
                FROM apmp410_tmp
               WHERE sel2 = 'Y'
              IF l_cnt > 0 THEN
                 IF cl_ask_confirm('axm-00530') THEN 
                    IF g_mode = 1 THEN
                       LET g_acc = '258'
                    ELSE
                       LET g_acc = '317'
                    END IF
                 ELSE
                    LET g_mode = g_mode_o
                    DISPLAY BY NAME g_mode
                    NEXT FIELD l_mode
                 END IF
              ELSE
                 IF g_mode = 1 THEN
                    LET g_acc = '258'
                 ELSE
                    LET g_acc = '317'
                 END IF              
              END IF   
              CLEAR FORM
              CALL g_detail_d.clear()
              CALL g_pmdb_d.clear()
              DELETE FROM apmp410_tmp
              LET g_wc = " 1=1"
              LET g_mode_o = g_mode
         END INPUT
         #2015/01/22 by stellar add ----- (E)
         
         CONSTRUCT g_wc ON pmdadocno,pmdadocdt,pmda002,pmda003,pmdb004,pmdb030
              FROM pmdadocno,pmdadocdt,pmda002,pmda003,pmdb004,pmdb030            
        
            BEFORE CONSTRUCT
               CALL cl_qbe_init()
               
            ON ACTION controlp INFIELD pmdadocno
               #開窗c段
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c'
                LET g_qryparam.reqry = FALSE
                IF g_type = '1' THEN
                   LET g_qryparam.where = " pmdastus = 'Y' AND pmdb032 = '1' "
                ELSE
                   #2015/01/19 by stellar modify ----- (S)
#                   LET g_qryparam.where = " pmdastus = 'C' AND pmdb032 <> '1'"  
                   #2015/01/22 by stellar modify ----- (S)
#                   LET g_qryparam.where = " (pmdastus = 'C' OR (pmdastus = 'Y' AND pmdb032 <> '1')) "
                   CASE g_mode
                      WHEN '1'
                           LET g_qryparam.where = " pmdb032 IN ('2','3','4') "
                      WHEN '2'
                           LET g_qryparam.where = " pmdb032 = '5' "
                   END CASE
                   #2015/01/22 by stellar modify ----- (E)
                   #2015/01/19 by stellar modify ----- (E)
                END IF
                CALL q_pmdadocno_1()                             #呼叫開窗
                DISPLAY g_qryparam.return1 TO pmdadocno      #顯示到畫面上
                NEXT FIELD pmdadocno                         #返回原欄位
        
            ON ACTION controlp INFIELD pmda002
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                             #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmda002      #顯示到畫面上
               NEXT FIELD pmda002                         #返回原欄位 
        
            ON ACTION controlp INFIELD pmda003
               #開窗c段
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c'
                LET g_qryparam.reqry = FALSE
                CALL q_ooeg001()                           #呼叫開窗
                DISPLAY g_qryparam.return1 TO pmda003      #顯示到畫面上
                NEXT FIELD pmda003                         #返回原欄位 
                
            ON ACTION controlp INFIELD pmdb004
               #開窗c段
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c'
                LET g_qryparam.reqry = FALSE
                LET g_qryparam.where = "1=1 "
                LET l_sql = ''
                
                CALL s_control_get_item_sql('3',g_site,g_user,g_dept,'') RETURNING l_success,l_sql
                IF l_success THEN
                   LET g_qryparam.where = g_qryparam.where ," AND ",l_sql
                END IF
                CALL q_imaf001()                           #呼叫開窗
                DISPLAY g_qryparam.return1 TO pmdb004      #顯示到畫面上
                NEXT FIELD pmdb004                         #返回原欄位                
        
         END CONSTRUCT
             
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT ARRAY g_detail_d FROM s_detail1.*
            ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                      INSERT ROW = FALSE,
                      DELETE ROW = FALSE,
                      APPEND ROW = FALSE)
                      
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_detail_d.getLength() TO FORMONLY.h_count
               LET g_master_idx = l_ac
               LET g_detail_d_t.* = g_detail_d[l_ac].*                     #BACKUP
               IF NOT cl_null(g_detail_d[g_detail_idx].pmdadocno) THEN
                  CALL apmp410_fetch()
               END IF
               CALL apmp410_set_entry()
               CALL apmp410_set_no_entry()              

            ON CHANGE sel
               IF g_detail_d[l_ac].sel = 'N' THEN
                  LET g_detail_d[l_ac].closed = ''
                  LET g_detail_d[l_ac].closed_desc = ''
                  DISPLAY BY NAME g_detail_d[l_ac].closed,g_detail_d[l_ac].closed_desc
               END IF
               CALL apmp410_set_entry()
               CALL apmp410_set_no_entry()               
               
             AFTER FIELD closed
                IF NOT cl_null(g_detail_d[l_ac].closed) THEN
                   IF NOT apmp410_pmdb051_chk(g_detail_d[l_ac].pmdadocno,g_detail_d[l_ac].closed) THEN
                      LET g_detail_d[l_ac].closed = ''
                      NEXT FIELD sel
                   END IF
                ELSE
                   IF g_detail_d[l_ac].sel = 'Y' THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = 'axm-00266'
                      LET g_errparam.extend = ''
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                      NEXT FIELD sel
                   END IF                   
                END IF               
                CALL s_desc_get_acc_desc(g_acc,g_detail_d[l_ac].closed) RETURNING g_detail_d[l_ac].closed_desc
                DISPLAY BY NAME g_detail_d[l_ac].closed_desc 


             ON ROW CHANGE
                IF g_detail_d[l_ac].sel = 'Y' THEN
                   IF NOT apmp410_pmdb051_chk(g_detail_d[l_ac].pmdadocno,g_detail_d[l_ac].closed) THEN
                      NEXT FIELD sel
                   END IF                
                   CALL apmp410_upd_tmp('2','Y',g_detail_d[l_ac].pmdadocno,'',g_detail_d[l_ac].closed)
                ELSE
                   CALL apmp410_upd_tmp('2','N',g_detail_d[l_ac].pmdadocno,'','')
                END IF
                CALL apmp410_fetch()

                
             ON ACTION controlp INFIELD closed
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'i'
                LET g_qryparam.reqry = FALSE
                LET g_qryparam.default1 = g_detail_d[l_ac].closed             #給予default值
                #給予arg
                LET g_qryparam.arg1 = g_acc
                CALL q_oocq002()                                              #呼叫開窗
                LET g_detail_d[l_ac].closed = g_qryparam.return1              #將開窗取得的值回傳到變數
                DISPLAY g_detail_d[l_ac].closed TO closed                     #顯示到畫面上
                CALL s_desc_get_acc_desc(g_acc,g_detail_d[l_ac].closed) RETURNING g_detail_d[l_ac].closed_desc
                DISPLAY BY NAME g_detail_d[l_ac].closed_desc     
                NEXT FIELD closed                                              #返回原欄位              
               
         END INPUT


         INPUT ARRAY g_pmdb_d FROM s_detail2.*
            ATTRIBUTE(COUNT = g_detail2_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                      INSERT ROW = FALSE,
                      DELETE ROW = FALSE,
                      APPEND ROW = FALSE)
                      
            BEFORE ROW
              LET g_detail2_idx = DIALOG.getCurrentRow("s_detail2")
              LET l_ac1 = g_detail2_idx
              LET g_pmdb_d_t.* = g_pmdb_d[l_ac1].*                     #BACKUP
              CALL apmp410_set_entry_b()
              CALL apmp410_set_no_entry_b()
              
           ON CHANGE sel2
               IF g_pmdb_d[l_ac1].sel2 = 'N' THEN
                  LET g_pmdb_d[l_ac1].closed2 = ''
                  LET g_pmdb_d[l_ac1].closed2_desc = ''
                  DISPLAY BY NAME g_pmdb_d[l_ac1].closed2,g_pmdb_d[l_ac1].closed2_desc
               END IF
               CALL apmp410_set_entry_b()
               CALL apmp410_set_no_entry_b()               
               
           ON ACTION controlp INFIELD closed2
              INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'i'
              LET g_qryparam.reqry = FALSE
              LET g_qryparam.default1 = g_pmdb_d[l_ac1].closed2             #給予default值
              #給予arg
              LET g_qryparam.arg1 = g_acc
              CALL q_oocq002()                                #呼叫開窗
              LET g_pmdb_d[l_ac1].closed2 = g_qryparam.return1              #將開窗取得的值回傳到變數
              DISPLAY g_pmdb_d[l_ac1].closed2 TO closed2                   #顯示到畫面上
              CALL s_desc_get_acc_desc(g_acc,g_pmdb_d[l_ac1].closed2) RETURNING g_pmdb_d[l_ac1].closed2_desc
              DISPLAY BY NAME g_pmdb_d[l_ac1].closed2_desc     
              NEXT FIELD closed2     
          
           AFTER FIELD closed2
              IF NOT cl_null(g_pmdb_d[l_ac1].closed2) THEN
                  IF NOT apmp410_pmdb051_chk(g_pmdb_d[l_ac1].pmdbdocno,g_pmdb_d[l_ac1].closed2) THEN
                     LET g_pmdb_d[l_ac1].closed2 = ''
                     NEXT FIELD sel2
                  END IF
              ELSE
                IF g_pmdb_d[l_ac1].sel2 = 'Y' THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'axm-00266'
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   NEXT FIELD sel2
                END IF                  
              END IF
              CALL s_desc_get_acc_desc(g_acc,g_pmdb_d[l_ac1].closed2) RETURNING g_pmdb_d[l_ac1].closed2_desc
              DISPLAY BY NAME g_pmdb_d[l_ac1].closed2_desc         

          AFTER ROW
              IF g_pmdb_d[l_ac1].sel2 = 'Y' THEN             
                 CALL apmp410_upd_tmp('3','Y',g_pmdb_d[l_ac1].pmdbdocno,g_pmdb_d[l_ac1].pmdbseq,g_pmdb_d[l_ac1].closed2)
              ELSE
                 CALL apmp410_upd_tmp('3','N',g_pmdb_d[l_ac1].pmdbdocno,g_pmdb_d[l_ac1].pmdbseq,'')
              END IF


         END INPUT         
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
 
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
            CALL cl_set_act_visible("filter,qbeclear,datarefresh",FALSE)   #161117-00028#1 add
            #end add-point
 
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            #add-point:ui_dialog段on action selall name="ui_dialog.selall.befroe"
            
            #end add-point            
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
               #add-point:ui_dialog段on action selall name="ui_dialog.for.onaction_selall"
               CALL apmp410_upd_tmp('2','Y',g_detail_d[li_idx].pmdadocno,'',g_detail_d[li_idx].closed)
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            CALL apmp410_fetch() 
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "N"
               #add-point:ui_dialog段on action selnone name="ui_dialog.for.onaction_selnone"
               LET g_detail_d[li_idx].closed = ''
               LET g_detail_d[li_idx].closed_desc = ''
               CALL apmp410_upd_tmp('2','N',g_detail_d[li_idx].pmdadocno,'','') 
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            CALL apmp410_fetch()            
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
                  LET g_detail_d[li_idx].sel = "Y"
                  CALL apmp410_upd_tmp('2','Y',g_detail_d[li_idx].pmdadocno,'',g_detail_d[li_idx].closed)
               END IF
            END FOR
            CALL apmp410_fetch()            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
            END FOR
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "N"
                  LET g_detail_d[li_idx].closed = ''
                  LET g_detail_d[li_idx].closed_desc = ''                  
                  CALL apmp410_upd_tmp('2','N',g_detail_d[li_idx].pmdadocno,'','')
               END IF
            END FOR
            CALL apmp410_fetch()
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL apmp410_filter()
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
            CALL apmp410_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL apmp410_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute        #執行結案
            IF apmp410_execute_chk() THEN
               IF g_type = '1' THEN
                  #2015/01/22 by stellar modify ----- (S)
#                  CALL s_apmp410_closed_upd()
                  CASE g_mode
                     WHEN '1' CALL s_apmp410_closed_upd()
                     WHEN '2' CALL s_apmp410_hold_upd(g_type)
                  END CASE
                  #2015/01/22 by stellar modify ----- (E)
               ELSE
                  #2015/01/22 by stellar modify ----- (S)
#                  CALL s_apmp410_unclosed_upd()
                  CASE g_mode
                     WHEN '1' CALL s_apmp410_unclosed_upd()
                     WHEN '2' CALL s_apmp410_hold_upd(g_type)
                  END CASE
                  #2015/01/22 by stellar modify ----- (E)
               END IF
               IF cl_ask_confirm('asf-00182') THEN
                 CLEAR FORM
                 CALL g_detail_d.clear()                 
                 CALL g_pmdb_d.clear()
                 EXIT DIALOG
               ELSE 
                 LET g_action_choice = 'exit'
                 EXIT DIALOG
               END IF
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
 
{<section id="apmp410.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION apmp410_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   DEFINE l_sql      STRING
   DEFINE i          LIKE type_t.num5     
   DEFINE l_cnt      LIKE type_t.num5
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   IF cl_null(g_wc) THEN 
      LET g_wc = " 1=1"
   END IF
   
   LET g_wc2 = ''
   IF g_type = '1' THEN
      LET g_wc2 = " pmdastus = 'Y' AND pmdb032 = '1' "
   ELSE
      #2015/01/19 by stellar modify ----- (S)
#      LET g_wc2 = " pmdastus = 'C' AND pmdb032 <> '1'" 
      #2015/01/22 by stellar modify ----- (S)
#      LET g_wc2 = " (pmdastus = 'C' OR (pmdastus = 'Y' AND pmdb032 <> '1')) "
      CASE g_mode
         WHEN '1'
              LET g_wc2 = " pmdb032 IN ('2','3','4') "
         WHEN '2'
              LET g_wc2 = " pmdb032 = '5' "
      END CASE
      #2015/01/22 by stellar modify ----- (E)
      #2015/01/19 by stellar modify ----- (E)
   END IF  
   LET l_sql = "SELECT DISTINCT '','',pmdbdocno,pmdbseq,pmdb006,pmdb049,'' ",   #2015/01/22 by stellar add ''
               "  FROM pmda_t,pmdb_t ",  
               " WHERE pmdbdocno = pmdadocno ",
               "   AND pmdbent = pmdaent ",  #161231-00005#1
               "   AND pmdaent = ? ",
               "   AND pmdasite = '",g_site,"' " ,              
               "   AND ",g_wc ,    
               "   AND ",g_wc2
   PREPARE apmp410_sel_pr_tmp FROM l_sql
   DECLARE apmp410_sel_cs_tmp CURSOR FOR apmp410_sel_pr_tmp  
   #清空tmptable
   DELETE FROM apmp410_tmp
   LET i = 1
   FOREACH apmp410_sel_cs_tmp USING g_enterprise INTO g_tmp_d[i].*
       LET g_tmp_d[i].sel2 = 'N'
       INSERT INTO apmp410_tmp VALUES(g_tmp_d[i].*)
       LET i = i + 1
   END FOREACH   
   CALL g_tmp_d.deleteElement(g_tmp_d.getLength())
  
   #end add-point
        
   LET g_error_show = 1
   CALL apmp410_b_fill()
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
 
{<section id="apmp410.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apmp410_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   LET g_sql = "SELECT DISTINCT pmdadocno,pmdadocdt,pmda002,'',pmda003,'' ",
               "  FROM pmda_t,pmdb_t ",  
               " WHERE pmdbdocno = pmdadocno ",
               "   AND pmdbent = pmdaent ",  #161231-00005#1
               "   AND pmdaent = ? ",
               "   AND pmdasite = '",g_site,"' ",                     
               "   AND ",g_wc ,
               "   AND ",g_wc2               
 
   #end add-point
 
   PREPARE apmp410_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR apmp410_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   LET g_detail_idx = 1
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
   g_detail_d[l_ac].pmdadocno,g_detail_d[l_ac].pmdadocdt,g_detail_d[l_ac].pmda002,g_detail_d[l_ac].pmda002_desc,
   g_detail_d[l_ac].pmda003,g_detail_d[l_ac].pmda003_desc
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
      LET g_detail_d[l_ac].sel = 'N' 
      CALL apmp410_pmda002_ref(g_detail_d[l_ac].pmda002) RETURNING g_detail_d[l_ac].pmda002_desc
      CALL apmp410_pmda003_ref(g_detail_d[l_ac].pmda003) RETURNING g_detail_d[l_ac].pmda003_desc
      
      #end add-point
      
      CALL apmp410_detail_show()      
 
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
   FREE apmp410_sel
   
   LET l_ac = 1
   CALL apmp410_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apmp410.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION apmp410_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define name="fetch.define"
   DEFINE l_sql           STRING
   DEFINE i               LIKE type_t.num5
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後 name="fetch.after_fill"
   IF cl_null(g_detail_idx) OR g_detail_idx <=0 THEN
      RETURN
   END IF
   INITIALIZE g_pmdb_d TO NULL 
   LET l_sql = "SELECT a.sel2,a.closed2,'',a.pmdbdocno,a.pmdbseq,b.pmdb004, ",
              "                 '','',b.pmdb005,b.pmdb007,'', ",
              "                  b.pmdb006,b.pmdb009,'',b.pmdb008,b.pmdb030, ",
              "                  b.pmdb031,'',b.pmdb032,b.pmdb049,b.pmdb006-b.pmdb049 ",            
              "   FROM apmp410_tmp a ,pmdb_t b ",          
              " WHERE a.pmdbdocno = '",g_detail_d[g_detail_idx].pmdadocno,"'" ,
              "   AND a.pmdbdocno = b.pmdbdocno ",
              "   AND a.pmdbseq = b.pmdbseq ",
              "   AND b.pmdbent = ",g_enterprise,  #161231-00005#1
              " ORDER BY a.pmdbdocno,a.pmdbseq "
 
   PREPARE apmp410_sel_pr FROM l_sql
   DECLARE apmp410_sel_cs CURSOR FOR apmp410_sel_pr
   
   LET i = 1
   FOREACH apmp410_sel_cs INTO g_pmdb_d[i].*
           CALL apmp410_pmdb004_ref(g_pmdb_d[i].pmdb004) RETURNING g_pmdb_d[i].pmdb004_desc,g_pmdb_d[i].imaal004
           CALL apmp410_unit_ref(g_pmdb_d[i].pmdb007) RETURNING g_pmdb_d[i].pmdb007_desc
           CALL apmp410_unit_ref(g_pmdb_d[i].pmdb009) RETURNING g_pmdb_d[i].pmdb009_desc
           CALL s_desc_get_acc_desc(g_acc,g_pmdb_d[i].pmdb031) RETURNING g_pmdb_d[i].pmdb031_desc
           CALL s_desc_get_acc_desc(g_acc,g_pmdb_d[i].closed2) RETURNING g_pmdb_d[i].closed2_desc
           LET i = i + 1           
   END FOREACH
   CALL g_pmdb_d.deleteElement(g_pmdb_d.getLength())
   LET g_detail2_cnt = i - 1 
   #end add-point 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="apmp410.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION apmp410_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   #讀入ref值
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apmp410.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION apmp410_filter()
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
   
   CALL apmp410_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="apmp410.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION apmp410_filter_parser(ps_field)
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
 
{<section id="apmp410.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION apmp410_filter_show(ps_field,ps_object)
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
   LET ls_condition = apmp410_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="apmp410.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"
#請購人員顯示
PRIVATE FUNCTION apmp410_pmda002_ref(p_pmda002)
DEFINE p_pmda002      LIKE pmda_t.pmda002
DEFINE r_pmda002_desc LIKE oofa_t.oofa011

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmda002
       CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
       LET r_pmda002_desc = '', g_rtn_fields[1] , ''
       RETURN r_pmda002_desc
END FUNCTION
################################################################################
# Descriptions...: 更新tmp table 資料
# Memo...........: 畫面勾選/取消勾選，需更新tmptable資料
# Usage..........: CALL apmp410_upd_tmp()
# Input parameter:
# Date & Author..: 14/04/26 By polly
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp410_upd_tmp(p_type,p_flag,p_pmdbdocno,p_pmdbseq,p_closed)
DEFINE p_type        LIKE type_t.chr1
DEFINE p_flag        LIKE type_t.chr1
DEFINE p_pmdbdocno   LIKE pmdb_t.pmdbdocno
DEFINE p_pmdbseq     LIKE pmdb_t.pmdbseq
DEFINE p_closed      LIKE   pmdb_t.pmdb051
DEFINE i             LIKE type_t.num5

   CASE p_type
      
     WHEN '2'           #單頭全選
       UPDATE apmp410_tmp
          SET sel2 = p_flag,
              closed2 = p_closed    
             ,closed1 = p_closed   #2015/01/22 by stellar add
        WHERE pmdbdocno = p_pmdbdocno
     
     WHEN '3'           #單身一筆勾選
       UPDATE apmp410_tmp
          SET sel2 = p_flag,
              closed2 = p_closed 
        WHERE pmdbdocno = p_pmdbdocno
          AND pmdbseq = p_pmdbseq
    END CASE 
    

END FUNCTION
#請購人員顯示
PRIVATE FUNCTION apmp410_pmda003_ref(p_pmda003)
DEFINE p_pmda003      LIKE pmda_t.pmda003
DEFINE r_pmda003_desc LIKE oofa_t.oofa011

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmda003
       CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmda003_desc = '', g_rtn_fields[1] , ''
       RETURN r_pmda003_desc
       
END FUNCTION
#單位名稱顯示
PRIVATE FUNCTION apmp410_unit_ref(p_pmdb007)
DEFINE p_pmdb007      LIKE pmdb_t.pmdb007
DEFINE r_pmdb007_desc LIKE oocal_t.oocal003

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmdb007
       CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmdb007_desc = '', g_rtn_fields[1] , ''
       RETURN r_pmdb007_desc
END FUNCTION
#建立tmptable
PRIVATE FUNCTION apmp410_create_preview_tmp()
   DROP TABLE apmp410_tmp
   CREATE TEMP TABLE apmp410_tmp
   (
      sel2       VARCHAR(1),
      closed2    VARCHAR(10),
      pmdbdocno  VARCHAR(20),
      pmdbseq    DECIMAL(10,0),
      pmdb006    DECIMAL(20,6),
      pmdb049    DECIMAL(20,6)
     ,closed1    VARCHAR(10)     
    );   
END FUNCTION

PRIVATE FUNCTION apmp410_pmdb004_ref(p_pmdb004)
DEFINE p_pmdb004      LIKE pmdb_t.pmdb004
DEFINE r_imaal003     LIKE imaal_t.imaal003
DEFINE r_imaal004     LIKE imaal_t.imaal004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmdb004
       CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_imaal003 = '', g_rtn_fields[1] , ''
       LET r_imaal004 = '', g_rtn_fields[2] , ''
       RETURN r_imaal003,r_imaal004
END FUNCTION
#結案理由碼檢查
PRIVATE FUNCTION apmp410_pmdb051_chk(p_pmdbdocno,p_oocq002)
DEFINE p_pmdbdocno       LIKE pmdb_t.pmdbdocno
DEFINE p_oocq002         LIKE oocq_t.oocq002
DEFINE r_success         LIKE type_t.num5
DEFINE l_success         LIKE type_t.num5
DEFINE l_flag            LIKE type_t.num5

   LET r_success = TRUE

   IF cl_null(p_oocq002) THEN
      RETURN r_success
   END IF

   IF NOT s_azzi650_chk_exist(g_acc,p_oocq002) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   #檢核輸入的理由碼是否在單據別限制範圍內
   CALL s_control_chk_doc('8',p_pmdbdocno,p_oocq002,'','','','')
        RETURNING l_success,l_flag
   IF NOT l_success THEN
      LET r_success = FALSE
      RETURN r_success
   ELSE
      IF NOT l_flag THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF

   RETURN r_success
END FUNCTION

PRIVATE FUNCTION apmp410_set_entry()

CALL cl_set_comp_entry("closed",TRUE)

END FUNCTION

PRIVATE FUNCTION apmp410_set_no_entry()
    IF g_detail_d[l_ac].sel = 'N' THEN
       CALL cl_set_comp_entry("closed",FALSE)
    END IF
END FUNCTION

PRIVATE FUNCTION apmp410_set_entry_b()
    CALL cl_set_comp_entry("closed2",TRUE)
END FUNCTION

PRIVATE FUNCTION apmp410_set_no_entry_b()
    IF g_pmdb_d[l_ac1].sel2 = 'N' THEN
       CALL cl_set_comp_entry("closed2",FALSE)
    END IF
END FUNCTION
#執行前檢查
PRIVATE FUNCTION apmp410_execute_chk()
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_cnt       LIKE type_t.num5

       LET r_success = TRUE
       
       #因按執行時，不會走AFTR ROW 、ON ROW CHANGE 段無法即時寫入TEMP TABLE，所以在此段做處理
       #第一單身
       IF g_detail_idx > 0 THEN
          IF g_detail_d[g_detail_idx].sel <> g_detail_d_t.sel THEN 
             IF g_detail_d[g_detail_idx].sel = 'Y' THEN
               IF g_type = '1' THEN   #結案時才檢查有無輸入理由碼   #2015/01/19 by stellar add
                IF NOT cl_null(g_detail_d[g_detail_idx].closed) THEN
                   IF NOT apmp410_pmdb051_chk(g_detail_d[g_detail_idx].pmdadocno,g_detail_d[g_detail_idx].closed) THEN
                      LET r_success = FALSE
                      RETURN r_success 
                   END IF   
                ELSE
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'axm-00266'
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = TRUE
                   CALL cl_err()            
                   LET r_success = FALSE
                   RETURN r_success 
                END IF
               END IF      #結案時才檢查有無輸入理由碼   #2015/01/19 by stellar add
                CALL apmp410_upd_tmp('2','Y',g_detail_d[g_detail_idx].pmdadocno,'',g_detail_d[g_detail_idx].closed)
             ELSE
                LET g_detail_d[g_detail_idx].closed = ''
                LET g_detail_d[g_detail_idx].closed_desc = ''
                CALL apmp410_upd_tmp('2','N',g_detail_d[g_detail_idx].pmdadocno,'','')
             END IF                      
          END IF
       END IF
       #第二單身
       IF g_detail2_idx > 0 THEN
          IF g_pmdb_d[g_detail2_idx].sel2 <> g_pmdb_d_t.sel2 THEN
             IF g_pmdb_d[g_detail2_idx].sel2 = 'Y' THEN
               IF g_type = '1' THEN   #結案時才檢查有無輸入理由碼   #2015/01/19 by stellar add
                IF NOT cl_null(g_pmdb_d[g_detail2_idx].closed2) THEN
                   IF NOT apmp410_pmdb051_chk(g_pmdb_d[g_detail2_idx].pmdbdocno,g_pmdb_d[g_detail2_idx].closed2) THEN
                      LET r_success = FALSE
                      RETURN r_success 
                   END IF   
                ELSE
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'axm-00266'
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = TRUE
                   CALL cl_err()            
                   LET r_success = FALSE
                   RETURN r_success  
                END IF
               END IF      #結案時才檢查有無輸入理由碼   #2015/01/19 by stellar add
                CALL apmp410_upd_tmp('3','Y',g_pmdb_d[g_detail2_idx].pmdbdocno,g_pmdb_d[g_detail2_idx].pmdbseq,g_pmdb_d[g_detail2_idx].closed2)
             ELSE
                LET g_pmdb_d[g_detail2_idx].closed2 = ''
                LET g_pmdb_d[g_detail2_idx].closed2_desc = ''
                CALL apmp410_upd_tmp('3','N',g_pmdb_d[g_detail2_idx].pmdbdocno,g_pmdb_d[g_detail2_idx].pmdbseq,g_pmdb_d[g_detail2_idx].closed2)
             END IF            
          END IF          
       END IF            
       
       LET l_cnt = 0
       SELECT COUNT(*) INTO l_cnt
         FROM apmp410_tmp
        WHERE sel2 = 'Y'
       #未勾選任何資料 
       IF l_cnt = 0 THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = 'apm-00481'
          LET g_errparam.extend = ''
          LET g_errparam.popup = TRUE
          CALL cl_err()
          LET r_success = FALSE
          RETURN r_success
       END IF
       #結案理由碼不可空白       
       IF g_type = '1' THEN
          LET l_cnt = 0
          SELECT COUNT(*) INTO l_cnt
            FROM apmp410_tmp
           WHERE sel2 = 'Y'
             AND closed2 IS NULL
          IF l_cnt > 0 THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'axm-00266'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
       RETURN r_success             
END FUNCTION

#end add-point
 
{</section>}
 
