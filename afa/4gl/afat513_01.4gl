#該程式已解開Section, 不再透過樣板產出!
{<section id="afat513_01.description" >}
#+ Version..: T100-ERP-1.00.00(SD版次:1,PR版次:1) Build-000007
#+ 
#+ Filename...: afat513_01
#+ Description: 資產標籤
#+ Creator....: 02481(2014/09/09)
#+ Modifier...: 02481(2014/09/09) -SD/PR- 00000
#+ Buildtype..: 應用 i02 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="afat513_01.global" >}

 
IMPORT os
IMPORT util
#add-point:增加匯入項目
#160905-00007#2  2016/09/06  by 08742    调整系统中无ENT的SQL条件增加ent
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_fabi_d RECORD
       fabi000 LIKE fabi_t.fabi000, 
   fabidocno LIKE fabi_t.fabidocno, 
   fabiseq LIKE fabi_t.fabiseq, 
   fabiseq1 LIKE fabi_t.fabiseq1, 
   fabi001 LIKE fabi_t.fabi001, 
   fabi002 LIKE fabi_t.fabi002, 
   fabi003 LIKE fabi_t.fabi003, 
   fabi004 LIKE fabi_t.fabi004, 
   fabi005 LIKE fabi_t.fabi005, 
   fabi006 LIKE fabi_t.fabi006, 
   fabi007 LIKE fabi_t.fabi007, 
   fabi009 LIKE fabi_t.fabi009, 
   fabi010 LIKE fabi_t.fabi010, 
   fabi015 LIKE fabi_t.fabi015, 
   fabi016 LIKE fabi_t.fabi016, 
   fabi018 LIKE fabi_t.fabi018, 
   fabi022 LIKE fabi_t.fabi022
       END RECORD
 
 
 
#模組變數(Module Variables)
DEFINE g_fabi_d          DYNAMIC ARRAY OF type_g_fabi_d #單身變數
DEFINE g_fabi_d_t        type_g_fabi_d                  #單身備份
DEFINE g_fabi_d_o        type_g_fabi_d                  #單身備份
 
      
DEFINE g_wc2                STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                        #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10    
DEFINE l_ac                 LIKE type_t.num5              #目前處理的ARRAY CNT 
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_temp_idx           LIKE type_t.num5              #單身 所在筆數(暫存用)
DEFINE g_detail_idx         LIKE type_t.num5              #單身 所在筆數(所有資料)
DEFINE g_detail_cnt         LIKE type_t.num5              #單身 總筆數(所有資料)
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_chk                BOOLEAN
DEFINE g_aw                 STRING                        #確定當下點擊的單身
DEFINE g_log1               STRING                        #log用
DEFINE g_log2               STRING                        #log用
 
#多table用wc
DEFINE g_wc_table           STRING
 
 
#add-point:自定義模組變數(Module Variable)
DEFINE g_cmd1            LIKE type_t.chr1      #判斷是查詢還是修改新增狀態
DEFINE g_fabhseq         LIKE fabh_t.fabhseq   #項次
DEFINE g_fabh039         LIKE fabh_t.fabh039   #盤點編號
DEFINE g_fabh040         LIKE fabh_t.fabh040   #盤點序號
DEFINE g_fabhdocno       LIKE fabh_t.fabhdocno #單據編號
DEFINE g_fabg005         LIKE fabg_t.fabg005   #性質
DEFINE g_fabh000         LIKE fabh_t.fabh000   #卡片編號
DEFINE g_fabh001         LIKE fabh_t.fabh001   #財產編號
DEFINE g_fabh002         LIKE fabh_t.fabh002   #附號

DEFINE g_fabk001         LIKE fabk_t.fabk001   #
DEFINE g_fabk002         LIKE fabk_t.fabk002
DEFINE g_fabk000         LIKE fabk_t.fabk000
DEFINE g_faba003         LIKE faba_t.faba003
DEFINE g_fabadocno       LIKE faba_t.fabadocno
DEFINE g_fabk006         LIKE fabk_t.fabk006
DEFINE g_faai008         LIKE faai_t.faai008
DEFINE g_faai007         LIKE faai_t.faai007
DEFINE g_faai008_sum     LIKE faai_t.faai008
#end add-point
 
#add-point:傳入參數說明(global.argv)

#end add-point
 
{</section>}
 
{<section id="afat513_01.main" >}
#+ 此段落由子樣板a27產生
#+ 資料輸入
PUBLIC FUNCTION afat513_01(--)
   #add-point:main段變數傳入
   p_cmd1,p_fabhdocno,p_fabhseq,p_fabh039,p_fabh040
   #end add-point
   )
   #add-point:main段define
   DEFINE p_cmd1            LIKE type_t.chr1  
   DEFINE p_fabhseq         LIKE fabh_t.fabhseq   #項次
   DEFINE p_fabh039         LIKE fabh_t.fabh039   #盤點編號
   DEFINE p_fabh040         LIKE fabh_t.fabh040   #盤點序號
   DEFINE p_fabhdocno       LIKE fabh_t.fabhdocno #單據編號
 
   #end add-point   
 
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:作業初始化
   LET g_cmd1 = p_cmd1          #記錄主作業狀態，若為查詢狀態修改或者新增資料
   LET g_fabhdocno = p_fabhdocno #單據編號
   LET g_fabhseq = p_fabhseq    #項次
   LET g_fabh039 = p_fabh039    #盤點編號
   LET g_fabh040 = p_fabh040    #盤點序號
   LET g_fabg005 = '23'
   SELECT fabh000,fabh001,fabh002 INTO g_fabh000,g_fabh001,g_fabh002 FROM fabh_t
    WHERE fabhent = g_enterprise AND fabhdocno = p_fabhdocno AND fabhseq = p_fabhseq
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
 
   
   #add-point:main段define_sql
   
   #end add-point 
   LET g_forupd_sql = "SELECT fabi000,fabidocno,fabiseq,fabiseq1,fabi001,fabi002,fabi003,fabi004,fabi005, 
       fabi006,fabi007,fabi009,fabi010,fabi015,fabi016,fabi018,fabi022 FROM fabi_t WHERE fabient=? AND  
       fabidocno=? AND fabiseq=? AND fabiseq1=? AND fabi000=? FOR UPDATE"
   #add-point:main段define_sql
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afat513_01_bcl CURSOR FROM g_forupd_sql
 
 
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_afat513_01 WITH FORM cl_ap_formpath("afa","afat513_01")
   
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   #程式初始化
   CALL afat513_01_init()   
 
   #進入選單 Menu (="N")
   CALL afat513_01_ui_dialog() 
 
   #畫面關閉
   CLOSE WINDOW w_afat513_01
 
   
   
 
   #add-point:離開前
   LET INT_FLAG = FALSE
   LET g_action_choice = NULL
   #end add-point
 
END FUNCTION
 
 
 
{</section>}
 
{<section id="afat513_01.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION afat513_01_init()
   #add-point:init段define
   DEFINE l_gzze003       LIKE gzze_t.gzze003
   #end add-point   
   
   
   
   LET g_error_show = 1
   
   #add-point:畫面資料初始化
 
   #end add-point
   
   CALL afat513_01_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="afat513_01.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION afat513_01_ui_dialog()
   DEFINE li_idx   LIKE type_t.num5
   DEFINE la_param  RECORD #串查用
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   #add-point:ui_dialog段define
   DEFINE l_fabi007_sum   LIKE fabi_t.fabi007
   #end add-point 
 
   LET g_action_choice = " "  
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()      
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   LET g_detail_idx = 1
   
   #add-point:ui_dialog段before dialog 
  #IF NOT cl_null(g_wc2) THEN LET g_wc2 = cl_replace_str(g_wc2,"OR","AND") END IF  #cy
   #end add-point
   
   WHILE TRUE
   
      CALL afat513_01_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_fabi_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               #add-point:ui_dialog段before display 
               
               #end add-point
               #讓各頁籤能夠同步指到特定資料
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               #add-point:ui_dialog段before display2
            
               #end add-point
               
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               LET g_temp_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #+ 此段落由子樣板a48產生
   CALL afat513_01_set_pk_array()
   #add-point:ON ACTION agendum
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
 
 
               #add-point:display array-before row
               
               #end add-point
         
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
 
      
         #add-point:ui_dialog段自定義display array
         
         #end add-point
    
         BEFORE DIALOG
            IF g_temp_idx > 0 THEN
               LET l_ac = g_temp_idx
               CALL DIALOG.setCurrentRow("s_detail1",l_ac)
               LET g_temp_idx = 1
            END IF
            LET g_curr_diag = ui.DIALOG.getCurrent()         
            CALL DIALOG.setSelectionMode("s_detail1", 1)
 
            #add-point:ui_dialog段before
            CALL cl_set_act_visible("insert,reproduce", FALSE)
            IF g_cmd1 = 'a' OR g_cmd1 = 'u' THEN
               CALL cl_set_act_visible("modify,modify_detail,delete", TRUE)
            ELSE
               CALL cl_set_act_visible("modify,modify_detail,delete", FALSE)
            END IF   
            #end add-point
            NEXT FIELD CURRENT
      
         
         #+ 此段落由子樣板a43產生
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL afat513_01_modify()
               #add-point:ON ACTION modify
 
               #END add-point
               EXIT DIALOG
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL afat513_01_modify()
               #add-point:ON ACTION modify_detail
 
               #END add-point
               EXIT DIALOG
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL afat513_01_delete()
               #add-point:ON ACTION delete
               
               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL afat513_01_insert()
               #add-point:ON ACTION insert
               
               #END add-point
               EXIT DIALOG
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output
               
               #END add-point
               EXIT DIALOG
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               
               #add-point:ON ACTION reproduce
               
               #END add-point
               EXIT DIALOG
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL afat513_01_query()
               #add-point:ON ACTION query
               
               #END add-point
               #此段落由子樣板a59產生  
               CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
 
 
            END IF
 
 
      
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice="exit"
            EXIT DIALOG
      
         ON ACTION exit
            LET g_action_choice="exit"
            EXIT DIALOG
            
         
         
         #+ 此段落由子樣板a46產生
         #新增相關文件
         ON ACTION related_document
            CALL afat513_01_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL afat513_01_set_pk_array()
            #add-point:ON ACTION agendum
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL afat513_01_set_pk_array()
            #add-point:ON ACTION followup
            
            #END add-point
            CALL cl_user_overview_follow('')
 
 
         
         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
      
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         #add-point:ui_dialog段離開dialog前
         #財編中，fabi_t的外送數量不能大于fabk_t的外送數量
         SELECT SUM(fabi007) INTO l_fabi007_sum    
           FROM fabi_t
          WHERE fabient = g_enterprise AND fabi001 = g_fabk000
            AND fabi002 = g_fabk001 AND fabi003 = g_fabk002
            AND fabidocno = g_fabadocno AND fabiseq = g_fabkseq 
         IF g_faba003 = '10' THEN
              IF l_fabi007_sum > g_fabk006 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = "afa-00144"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
               END IF
            END IF
            IF g_faba003 = '11' THEN
               IF l_fabi007_sum > g_fabk006 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = "afa-00145"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
               END IF
            END IF
         #end add-point
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="afat513_01.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION afat513_01_query()
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define

   #end add-point 
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_fabi_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
      
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON fabi000,fabidocno,fabiseq,fabiseq1,fabi001,fabi002,fabi003,fabi004,fabi005, 
          fabi006,fabi007,fabi009,fabi010,fabi015,fabi016,fabi018,fabi022 
 
         FROM s_detail1[1].fabi000,s_detail1[1].fabidocno,s_detail1[1].fabiseq,s_detail1[1].fabiseq1, 
             s_detail1[1].fabi001,s_detail1[1].fabi002,s_detail1[1].fabi003,s_detail1[1].fabi004,s_detail1[1].fabi005, 
             s_detail1[1].fabi006,s_detail1[1].fabi007,s_detail1[1].fabi009,s_detail1[1].fabi010,s_detail1[1].fabi015, 
             s_detail1[1].fabi016,s_detail1[1].fabi018,s_detail1[1].fabi022 
      
         
      
                  #此段落由子樣板a01產生
         BEFORE FIELD fabi000
            #add-point:BEFORE FIELD fabi000

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabi000
            
            #add-point:AFTER FIELD fabi000

            #END add-point
            
 
         #Ctrlp:query.c.page1.fabi000
         ON ACTION controlp INFIELD fabi000
            #add-point:ON ACTION controlp INFIELD fabi000

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabidocno
            #add-point:BEFORE FIELD fabidocno

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabidocno
            
            #add-point:AFTER FIELD fabidocno

            #END add-point
            
 
         #Ctrlp:query.c.page1.fabidocno
         ON ACTION controlp INFIELD fabidocno
            #add-point:ON ACTION controlp INFIELD fabidocno

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabiseq
            #add-point:BEFORE FIELD fabiseq

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabiseq
            
            #add-point:AFTER FIELD fabiseq

            #END add-point
            
 
         #Ctrlp:query.c.page1.fabiseq
         ON ACTION controlp INFIELD fabiseq
            #add-point:ON ACTION controlp INFIELD fabiseq

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabiseq1
            #add-point:BEFORE FIELD fabiseq1

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabiseq1
            
            #add-point:AFTER FIELD fabiseq1

            #END add-point
            
 
         #Ctrlp:query.c.page1.fabiseq1
         ON ACTION controlp INFIELD fabiseq1
            #add-point:ON ACTION controlp INFIELD fabiseq1

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabi001
            #add-point:BEFORE FIELD fabi001

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabi001
            
            #add-point:AFTER FIELD fabi001

            #END add-point
            
 
         #Ctrlp:query.c.page1.fabi001
         ON ACTION controlp INFIELD fabi001
            #add-point:ON ACTION controlp INFIELD fabi001

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabi002
            #add-point:BEFORE FIELD fabi002

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabi002
            
            #add-point:AFTER FIELD fabi002

            #END add-point
            
 
         #Ctrlp:query.c.page1.fabi002
         ON ACTION controlp INFIELD fabi002
            #add-point:ON ACTION controlp INFIELD fabi002

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabi003
            #add-point:BEFORE FIELD fabi003

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabi003
            
            #add-point:AFTER FIELD fabi003

            #END add-point
            
 
         #Ctrlp:query.c.page1.fabi003
         ON ACTION controlp INFIELD fabi003
            #add-point:ON ACTION controlp INFIELD fabi003

            #END add-point
 
         #Ctrlp:construct.c.page1.fabi004
         ON ACTION controlp INFIELD fabi004
            #add-point:ON ACTION controlp INFIELD fabi004
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_faai004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabi004  #顯示到畫面上
            NEXT FIELD fabi004                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabi004
            #add-point:BEFORE FIELD fabi004

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabi004
            
            #add-point:AFTER FIELD fabi004

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabi005
            #add-point:BEFORE FIELD fabi005

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabi005
            
            #add-point:AFTER FIELD fabi005

            #END add-point
            
 
         #Ctrlp:query.c.page1.fabi005
         ON ACTION controlp INFIELD fabi005
            #add-point:ON ACTION controlp INFIELD fabi005

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabi006
            #add-point:BEFORE FIELD fabi006

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabi006
            
            #add-point:AFTER FIELD fabi006

            #END add-point
            
 
         #Ctrlp:query.c.page1.fabi006
         ON ACTION controlp INFIELD fabi006
            #add-point:ON ACTION controlp INFIELD fabi006

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabi007
            #add-point:BEFORE FIELD fabi007

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabi007
            
            #add-point:AFTER FIELD fabi007

            #END add-point
            
 
         #Ctrlp:query.c.page1.fabi007
         ON ACTION controlp INFIELD fabi007
            #add-point:ON ACTION controlp INFIELD fabi007

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabi009
            #add-point:BEFORE FIELD fabi009

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabi009
            
            #add-point:AFTER FIELD fabi009

            #END add-point
            
 
         #Ctrlp:query.c.page1.fabi009
         ON ACTION controlp INFIELD fabi009
            #add-point:ON ACTION controlp INFIELD fabi009

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabi010
            #add-point:BEFORE FIELD fabi010

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabi010
            
            #add-point:AFTER FIELD fabi010

            #END add-point
            
 
         #Ctrlp:query.c.page1.fabi010
         ON ACTION controlp INFIELD fabi010
            #add-point:ON ACTION controlp INFIELD fabi010

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabi015
            #add-point:BEFORE FIELD fabi015

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabi015
            
            #add-point:AFTER FIELD fabi015

            #END add-point
            
 
         #Ctrlp:query.c.page1.fabi015
         ON ACTION controlp INFIELD fabi015
            #add-point:ON ACTION controlp INFIELD fabi015

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabi016
            #add-point:BEFORE FIELD fabi016

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabi016
            
            #add-point:AFTER FIELD fabi016

            #END add-point
            
 
         #Ctrlp:query.c.page1.fabi016
         ON ACTION controlp INFIELD fabi016
            #add-point:ON ACTION controlp INFIELD fabi016

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabi018
            #add-point:BEFORE FIELD fabi018

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabi018
            
            #add-point:AFTER FIELD fabi018

            #END add-point
            
 
         #Ctrlp:query.c.page1.fabi018
         ON ACTION controlp INFIELD fabi018
            #add-point:ON ACTION controlp INFIELD fabi018

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabi022
            #add-point:BEFORE FIELD fabi022

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabi022
            
            #add-point:AFTER FIELD fabi022

            #END add-point
            
 
         #Ctrlp:query.c.page1.fabi022
         ON ACTION controlp INFIELD fabi022
            #add-point:ON ACTION controlp INFIELD fabi022

            #END add-point
 
  
         
 
      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct

            #end add-point 
      
      END CONSTRUCT
  
      #add-point:query段more_construct

      #end add-point 
  
      BEFORE DIALOG 
         CALL cl_qbe_init()
         #add-point:query段before_dialog

         #end add-point 
      
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
      
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
 
   #add-point:query段after_construct

   #end add-point
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      LET g_wc2 = ls_wc
   ELSE
      LET g_error_show = 1
      LET g_detail_idx = 1
   END IF
    
   CALL afat513_01_b_fill(g_wc2)
   
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = -100 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   END IF
   
   LET INT_FLAG = FALSE
   
END FUNCTION
 
{</section>}
 
{<section id="afat513_01.insert" >}
#+ 資料新增
PRIVATE FUNCTION afat513_01_insert()
   #add-point:delete段define
   
   #end add-point                
    
   #add-point:單身新增前
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL afat513_01_modify()
            
   #add-point:單身新增後
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afat513_01.modify" >}
#+ 資料修改
PRIVATE FUNCTION afat513_01_modify()
   DEFINE  l_cmd                  LIKE type_t.chr1
   DEFINE  l_ac_t                 LIKE type_t.num5                #未取消的ARRAY CNT 
   DEFINE  l_n                    LIKE type_t.num5                #檢查重複用  
   DEFINE  l_cnt                  LIKE type_t.num5                #檢查重複用  
   DEFINE  l_lock_sw              LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert         LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete         LIKE type_t.num5                #可刪除否  
   DEFINE  l_count                LIKE type_t.num5
   DEFINE  l_i                    LIKE type_t.num5
   DEFINE  ls_return              STRING
   DEFINE  l_var_keys             DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys           DYNAMIC ARRAY OF STRING
   DEFINE  l_vars                 DYNAMIC ARRAY OF STRING
   DEFINE  l_fields               DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak         DYNAMIC ARRAY OF STRING
   DEFINE  li_reproduce           LIKE type_t.num5
   DEFINE  li_reproduce_target    LIKE type_t.num5
   DEFINE  lb_reproduce           BOOLEAN
   #add-point:modify段define
   DEFINE  l_faah019              LIKE faah_t.faah019
   DEFINE  l_fabi007              LIKE fabi_t.fabi007
   #end add-point 
   
   LET g_action_choice = ""
   
   LET g_qryparam.state = "i"
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #add-point:modify開始前
 
   #end add-point
   
   LET INT_FLAG = FALSE
   LET lb_reproduce = FALSE
 
   #add-point:modify段修改前
      CALL afat513_01_b_fill( "1=1")
      IF g_fabi_d.getLength() > 0 THEN
          LET g_insert = 'N'
      ELSE
        LET g_insert = 'Y'
      END IF
         
   #end add-point
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #Page1 預設值產生於此處
      INPUT ARRAY g_fabi_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_fabi_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL afat513_01_b_fill(g_wc2)
            LET g_detail_cnt = g_fabi_d.getLength()
         
         BEFORE ROW
            #add-point:modify段before row
            
            #end add-point  
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_cmd = ''
            LET l_ac = g_detail_idx
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            DISPLAY g_fabi_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_fabi_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_fabi_d[l_ac].fabidocno IS NOT NULL
               AND g_fabi_d[l_ac].fabiseq IS NOT NULL
               AND g_fabi_d[l_ac].fabiseq1 IS NOT NULL
               AND g_fabi_d[l_ac].fabi000 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_fabi_d_t.* = g_fabi_d[l_ac].*  #BACKUP
               LET g_fabi_d_o.* = g_fabi_d[l_ac].*  #BACKUP
               IF NOT afat513_01_lock_b("fabi_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afat513_01_bcl INTO g_fabi_d[l_ac].fabi000,g_fabi_d[l_ac].fabidocno,g_fabi_d[l_ac].fabiseq, 
                      g_fabi_d[l_ac].fabiseq1,g_fabi_d[l_ac].fabi001,g_fabi_d[l_ac].fabi002,g_fabi_d[l_ac].fabi003, 
                      g_fabi_d[l_ac].fabi004,g_fabi_d[l_ac].fabi005,g_fabi_d[l_ac].fabi006,g_fabi_d[l_ac].fabi007, 
                      g_fabi_d[l_ac].fabi009,g_fabi_d[l_ac].fabi010,g_fabi_d[l_ac].fabi015,g_fabi_d[l_ac].fabi016, 
                      g_fabi_d[l_ac].fabi018,g_fabi_d[l_ac].fabi022
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_fabi_d_t.fabidocno 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     LET l_lock_sw = "Y"
                  END IF
                  
                  CALL afat513_01_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            
        
         BEFORE INSERT
            
            CALL s_transaction_begin()
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_fabi_d_t.* TO NULL
            INITIALIZE g_fabi_d_o.* TO NULL
            INITIALIZE g_fabi_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值(單身1)
            
            #add-point:modify段before備份
            
            #end add-point
            LET g_fabi_d_t.* = g_fabi_d[l_ac].*     #新輸入資料
            LET g_fabi_d_o.* = g_fabi_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL afat513_01_set_entry_b("a")
            CALL afat513_01_set_no_entry_b("a")
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_fabi_d[li_reproduce_target].* = g_fabi_d[li_reproduce].*
 
               LET g_fabi_d[g_fabi_d.getLength()].fabidocno = NULL
               LET g_fabi_d[g_fabi_d.getLength()].fabiseq = NULL
               LET g_fabi_d[g_fabi_d.getLength()].fabiseq1 = NULL
               LET g_fabi_d[g_fabi_d.getLength()].fabi000 = NULL
 
            END IF
            
            #add-point:modify段before insert
            IF l_cmd = 'a' THEN
               LET g_fabi_d[l_ac].fabidocno = g_fabhdocno  #單據編號
               LET g_fabi_d[l_ac].fabiseq = g_fabhseq      #項次
               LET g_fabi_d[l_ac].fabi000 = g_fabg005      #性質
               LET g_fabi_d[l_ac].fabi001 = g_fabh000      #卡片編號
               LET g_fabi_d[l_ac].fabi002 = g_fabh001      #財產編號
               LET g_fabi_d[l_ac].fabi003 = g_fabh002      #附號
            END IF
            #end add-point  
  
         AFTER INSERT
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
 
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM fabi_t 
             WHERE fabient = g_enterprise AND fabidocno = g_fabi_d[l_ac].fabidocno
                                       AND fabiseq = g_fabi_d[l_ac].fabiseq
                                       AND fabiseq1 = g_fabi_d[l_ac].fabiseq1
                                       AND fabi000 = g_fabi_d[l_ac].fabi000
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fabi_d[g_detail_idx].fabidocno
               LET gs_keys[2] = g_fabi_d[g_detail_idx].fabiseq
               LET gs_keys[3] = g_fabi_d[g_detail_idx].fabiseq1
               LET gs_keys[4] = g_fabi_d[g_detail_idx].fabi000
               CALL afat513_01_insert_b('fabi_t',gs_keys,"'1'")
                           
               #add-point:單身新增後
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               INITIALIZE g_fabi_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "fabi_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL afat513_01_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert
 
               #end add-point
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (fabidocno = '", g_fabi_d[l_ac].fabidocno, "' "
                                  ," AND fabiseq = '", g_fabi_d[l_ac].fabiseq, "' "
                                  ," AND fabiseq1 = '", g_fabi_d[l_ac].fabiseq1, "' "
                                  ," AND fabi000 = '", g_fabi_d[l_ac].fabi000, "' "
 
                                  ,")"
            END IF                
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               #add-point:單身刪除ask前
               
               #end add-point   
               
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = -263 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  CANCEL DELETE
               END IF
               
               #add-point:單身刪除前
               
               #end add-point   
               
               DELETE FROM fabi_t
                WHERE fabient = g_enterprise AND 
                      fabidocno = g_fabi_d_t.fabidocno
                      AND fabiseq = g_fabi_d_t.fabiseq
                      AND fabiseq1 = g_fabi_d_t.fabiseq1
                      AND fabi000 = g_fabi_d_t.fabi000
 
                      
               #add-point:單身刪除中
               
               #end add-point  
                      
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "fabi_t" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
                  #add-point:單身刪除後
                  
                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE afat513_01_bcl
               LET l_count = g_fabi_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fabi_d[g_detail_idx].fabidocno
               LET gs_keys[2] = g_fabi_d[g_detail_idx].fabiseq
               LET gs_keys[3] = g_fabi_d[g_detail_idx].fabiseq1
               LET gs_keys[4] = g_fabi_d[g_detail_idx].fabi000
 
               #+ 此段落由子樣板a47產生
      #刪除相關文件
      CALL afat513_01_set_pk_array()
      #add-point:相關文件刪除前
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2
               
               #end add-point
                              CALL afat513_01_delete_b('fabi_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_fabi_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #此段落由子樣板a01產生
         BEFORE FIELD fabi000
            #add-point:BEFORE FIELD fabi000
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabi000
            
            #add-point:AFTER FIELD fabi000
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_fabi_d[g_detail_idx].fabidocno IS NOT NULL AND g_fabi_d[g_detail_idx].fabiseq IS NOT NULL AND g_fabi_d[g_detail_idx].fabi000 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_fabi_d[g_detail_idx].fabidocno != g_fabi_d_t.fabidocno OR g_fabi_d[g_detail_idx].fabiseq != g_fabi_d_t.fabiseq OR g_fabi_d[g_detail_idx].fabi000 != g_fabi_d_t.fabi000)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fabi_t WHERE "||"fabient = '" ||g_enterprise|| "' AND "||"fabidocno = '"||g_fabi_d[g_detail_idx].fabidocno ||"' AND "|| "fabiseq = '"||g_fabi_d[g_detail_idx].fabiseq ||"' AND "|| "fabi000 = '"||g_fabi_d[g_detail_idx].fabi000 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE fabi000
            #add-point:ON CHANGE fabi000
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabidocno
            #add-point:BEFORE FIELD fabidocno
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabidocno
            
            #add-point:AFTER FIELD fabidocno
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_fabi_d[g_detail_idx].fabidocno IS NOT NULL AND g_fabi_d[g_detail_idx].fabiseq IS NOT NULL AND g_fabi_d[g_detail_idx].fabi000 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_fabi_d[g_detail_idx].fabidocno != g_fabi_d_t.fabidocno OR g_fabi_d[g_detail_idx].fabiseq != g_fabi_d_t.fabiseq OR g_fabi_d[g_detail_idx].fabi000 != g_fabi_d_t.fabi000)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fabi_t WHERE "||"fabient = '" ||g_enterprise|| "' AND "||"fabidocno = '"||g_fabi_d[g_detail_idx].fabidocno ||"' AND "|| "fabiseq = '"||g_fabi_d[g_detail_idx].fabiseq ||"' AND "|| "fabi000 = '"||g_fabi_d[g_detail_idx].fabi000 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE fabidocno
            #add-point:ON CHANGE fabidocno
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabiseq
            #add-point:BEFORE FIELD fabiseq
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabiseq
            
            #add-point:AFTER FIELD fabiseq
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_fabi_d[g_detail_idx].fabidocno IS NOT NULL AND g_fabi_d[g_detail_idx].fabiseq IS NOT NULL AND g_fabi_d[g_detail_idx].fabi000 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_fabi_d[g_detail_idx].fabidocno != g_fabi_d_t.fabidocno OR g_fabi_d[g_detail_idx].fabiseq != g_fabi_d_t.fabiseq OR g_fabi_d[g_detail_idx].fabi000 != g_fabi_d_t.fabi000)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fabi_t WHERE "||"fabient = '" ||g_enterprise|| "' AND "||"fabidocno = '"||g_fabi_d[g_detail_idx].fabidocno ||"' AND "|| "fabiseq = '"||g_fabi_d[g_detail_idx].fabiseq ||"' AND "|| "fabi000 = '"||g_fabi_d[g_detail_idx].fabi000 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE fabiseq
            #add-point:ON CHANGE fabiseq
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabiseq1
            #add-point:BEFORE FIELD fabiseq1
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabiseq1
            
            #add-point:AFTER FIELD fabiseq1
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_fabi_d[g_detail_idx].fabidocno IS NOT NULL AND g_fabi_d[g_detail_idx].fabiseq IS NOT NULL AND g_fabi_d[g_detail_idx].fabiseq1 IS NOT NULL AND g_fabi_d[g_detail_idx].fabi000 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_fabi_d[g_detail_idx].fabidocno != g_fabi_d_t.fabidocno OR g_fabi_d[g_detail_idx].fabiseq != g_fabi_d_t.fabiseq OR g_fabi_d[g_detail_idx].fabiseq1 != g_fabi_d_t.fabiseq1 OR g_fabi_d[g_detail_idx].fabi000 != g_fabi_d_t.fabi000)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fabi_t WHERE "||"fabient = '" ||g_enterprise|| "' AND "||"fabidocno = '"||g_fabi_d[g_detail_idx].fabidocno ||"' AND "|| "fabiseq = '"||g_fabi_d[g_detail_idx].fabiseq ||"' AND "|| "fabiseq1 = '"||g_fabi_d[g_detail_idx].fabiseq1 ||"' AND "|| "fabi000 = '"||g_fabi_d[g_detail_idx].fabi000 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE fabiseq1
            #add-point:ON CHANGE fabiseq1
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabi001
            #add-point:BEFORE FIELD fabi001
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabi001
            
            #add-point:AFTER FIELD fabi001
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE fabi001
            #add-point:ON CHANGE fabi001
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabi002
            #add-point:BEFORE FIELD fabi002
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabi002
            
            #add-point:AFTER FIELD fabi002
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE fabi002
            #add-point:ON CHANGE fabi002
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabi003
            #add-point:BEFORE FIELD fabi003
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabi003
            
            #add-point:AFTER FIELD fabi003
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE fabi003
            #add-point:ON CHANGE fabi003
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabi004
            #add-point:BEFORE FIELD fabi004
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabi004
            
            #add-point:AFTER FIELD fabi004
            IF NOT cl_null(g_fabi_d[l_ac].fabi004) THEN
               LET l_n = 0 
               SELECT COUNT(*) INTO l_n FROM faai_t
                WHERE faaient = g_enterprise AND faai001 = g_fabk000
                  AND faai002 = g_fabk001 AND faai003 = g_fabk002
               IF l_n = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = "afa-00130"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  NEXT FIELD fabi004
               END IF
               IF g_fabi_d[l_ac].fabi004 <> g_fabi_d_t.fabi004 THEN
                  CALL afat513_01_faai004_ref()
               END IF
            END IF
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE fabi004
            #add-point:ON CHANGE fabi004
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabi005
            #add-point:BEFORE FIELD fabi005
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabi005
            
            #add-point:AFTER FIELD fabi005
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE fabi005
            #add-point:ON CHANGE fabi005
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabi006
            #add-point:BEFORE FIELD fabi006
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabi006
            
            #add-point:AFTER FIELD fabi006
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE fabi006
            #add-point:ON CHANGE fabi006
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabi007
            #add-point:BEFORE FIELD fabi007
            IF NOT cl_null(g_fabi_d[l_ac].fabi004) THEN
               LET l_n = 0 
               SELECT COUNT(*) INTO l_n FROM faai_t
                WHERE faaient = g_enterprise AND faai001 = g_fabk000
                  AND faai002 = g_fabk001 AND faai003 = g_fabk002
               IF l_n = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = "afa-00130"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  NEXT FIELD fabi004
               END IF
               IF g_fabi_d[l_ac].fabi004 <> g_fabi_d_t.fabi004 THEN
                  CALL afat513_01_faai004_ref()
               END IF
            END IF
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabi007
            
            #add-point:AFTER FIELD fabi007
           IF NOT cl_null(g_fabi_d[l_ac].fabi007) AND g_fabi_d[l_ac].fabi007 <= 0 THEN 
              INITIALIZE g_errparam TO NULL
              LET g_errparam.extend = ""
              LET g_errparam.code   = "aqc-00004"
              LET g_errparam.popup  = TRUE
              CALL cl_err()
              NEXT FIELD fabi007              
           END IF           
           
           #停用
           IF g_faba003 = '7' THEN
              LET l_fabi007 = 0 
              SELECT fabi007 INTO l_fabi007 FROM fabi_t
               WHERE fabient = g_enterprise AND fabi001 = g_fabk000
                 AND fabi002 = g_fabk001 AND fabi003 = g_fabk002
                 AND fabidocno = g_fabadocno AND fabi000 = g_faba003
                 AND fabiseq = g_fabkseq
                 
              IF l_fabi007 < g_fabi_d[l_ac].fabi007 THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = ""
                 LET g_errparam.code   = "afa-00156"
                 LET g_errparam.popup  = TRUE
                 CALL cl_err()
                 LET g_fabi_d[l_ac].fabi007 = g_fabi_d_t.fabi007
                 NEXT FIELD fabi007
              END IF              
           END IF
           
           #銷賬
           IF g_faba003 = '6' THEN
              LET l_fabi007 = 0 
              SELECT fabi007 INTO l_fabi007 FROM fabi_t
               WHERE fabient = g_enterprise AND fabi001 = g_fabk000
                 AND fabi002 = g_fabk001 AND fabi003 = g_fabk002
                 AND fabidocno = g_fabadocno AND fabi000 = g_faba003
                 AND fabiseq = g_fabkseq
                 
              IF l_fabi007 < g_fabi_d[l_ac].fabi007 THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = ""
                 LET g_errparam.code   = "afa-00157"
                 LET g_errparam.popup  = TRUE
                 CALL cl_err()
                 LET g_fabi_d[l_ac].fabi007 = g_fabi_d_t.fabi007
                 NEXT FIELD fabi007
              END IF              
           END IF           
           
           IF g_faba003 = '10' THEN
              #符合條件可以錄入
              SELECT faah019 INTO l_faah019 FROM faai_t
               WHERE faahent = g_enterprise AND faai001 = g_fabk000
                 AND fabi003 = g_fabk001 AND faai004 = g_fabk002
              SELECT fabi007 INTO l_fabi007 FROM fabi_t
               WHERE fabient = g_enterprise AND fabi001 = g_fabk000
                 AND fabi002 = g_fabk001 AND fabi003 = g_fabk002
                 AND fabidocno = g_fabadocno AND fabi000 = g_faba003
                 AND fabiseq = g_fabkseq
               IF cl_null(l_fabi007) THEN LET l_fabi007 = 0 END IF
               IF cl_null(l_faah019) THEN LET l_faah019 = 0 END IF
              #IF g_fabi_d[l_ac].fabi007 <= g_faai007- g_faai008 AND g_faai007 - g_faai008 >= 1 AND g_fabi_d[l_ac].fabi007 <= g_faai007 THEN
               IF g_fabi_d[l_ac].fabi007 > g_faai007- g_faai008 OR g_faai007 - g_faai008 < 1 OR g_fabi_d[l_ac].fabi007 > g_faai007 THEN
#                  OR (l_cmd = 'a' AND g_fabi_d[l_ac].fabi007 + g_faai008_sum > g_fabk006 ) 
#                  OR (l_cmd = 'u' AND g_fabi_d[l_ac].fabi007 + g_faai008_sum - l_fabi007 > g_fabk006  ) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = "afa-00131"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  NEXT FIELD fabi007
               END IF
            END IF
            IF g_faba003 = '11' THEN
               IF g_fabi_d[l_ac].fabi007 > g_faai008 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = "afa-00092"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  NEXT FIELD fabi007
               END IF
            END IF
            #財編中，fabi_t的外送數量不能大于fabk_t的外送數量
            IF g_faba003 = '10' THEN
               SELECT fabi007 INTO l_fabi007 FROM fabi_t
               WHERE fabient = g_enterprise AND fabi001 = g_fabk000
                 AND fabi002 = g_fabk001 AND fabi003 = g_fabk002
                 AND fabidocno = g_fabadocno AND fabi000 = g_faba003
                 AND fabiseq = g_fabkseq
               IF (l_cmd = 'a' AND g_fabi_d[l_ac].fabi007 +  l_fabi007 > g_fabk006) 
                  OR (l_cmd = 'u' AND g_fabi_d[l_ac].fabi007 + l_fabi007 - g_fabi_d_t.fabi007 > g_fabk006) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = "afa-00144"
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     NEXT FIELD fabi007
               END IF
            END IF
            IF g_faba003 = '11' THEN
               SELECT fabi007 INTO l_fabi007 FROM fabi_t
               WHERE fabient = g_enterprise AND fabi001 = g_fabk000
                 AND fabi002 = g_fabk001 AND fabi003 = g_fabk002
                 AND fabidocno = g_fabadocno AND fabi000 = g_faba003
                 AND fabiseq = g_fabkseq
               IF (l_cmd = 'a' AND g_fabi_d[l_ac].fabi007 +  l_fabi007 > g_fabk006) 
               OR (l_cmd = 'u' AND g_fabi_d[l_ac].fabi007 + l_fabi007 - g_fabi_d_t.fabi007 > g_fabk006) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = "afa-00145"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  NEXT FIELD fabi007
               END IF
            END IF
            
           #報廢
           IF g_faba003 = '21' THEN
              LET l_fabi007 = 0 
              SELECT fabi007 INTO l_fabi007 FROM fabi_t
               WHERE fabient = g_enterprise AND fabi001 = g_fabk000
                 AND fabi002 = g_fabk001 AND fabi003 = g_fabk002
                 AND fabidocno = g_fabadocno AND fabi000 = g_faba003
                 AND fabiseq = g_fabkseq
                 
              IF l_fabi007 < g_fabi_d[l_ac].fabi007 THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = ""
                 LET g_errparam.code   = "afa-00197"
                 LET g_errparam.popup  = TRUE
                 CALL cl_err()
                 LET g_fabi_d[l_ac].fabi007 = g_fabi_d_t.fabi007
                 NEXT FIELD fabi007
              END IF              
           END IF            
           
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE fabi007
            #add-point:ON CHANGE fabi007
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabi009
            #add-point:BEFORE FIELD fabi009
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabi009
            
            #add-point:AFTER FIELD fabi009
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE fabi009
            #add-point:ON CHANGE fabi009
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabi010
            #add-point:BEFORE FIELD fabi010
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabi010
            
            #add-point:AFTER FIELD fabi010
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE fabi010
            #add-point:ON CHANGE fabi010
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabi015
            #add-point:BEFORE FIELD fabi015
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabi015
            
            #add-point:AFTER FIELD fabi015
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE fabi015
            #add-point:ON CHANGE fabi015
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabi016
            #add-point:BEFORE FIELD fabi016
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabi016
            
            #add-point:AFTER FIELD fabi016
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE fabi016
            #add-point:ON CHANGE fabi016
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabi018
            #add-point:BEFORE FIELD fabi018
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabi018
            
            #add-point:AFTER FIELD fabi018
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE fabi018
            #add-point:ON CHANGE fabi018
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabi022
            #add-point:BEFORE FIELD fabi022
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabi022
            
            #add-point:AFTER FIELD fabi022
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE fabi022
            #add-point:ON CHANGE fabi022
            
            #END add-point
 
 
                  #Ctrlp:input.c.page1.fabi000
         ON ACTION controlp INFIELD fabi000
            #add-point:ON ACTION controlp INFIELD fabi000
            
            #END add-point
 
         #Ctrlp:input.c.page1.fabidocno
         ON ACTION controlp INFIELD fabidocno
            #add-point:ON ACTION controlp INFIELD fabidocno
            
            #END add-point
 
         #Ctrlp:input.c.page1.fabiseq
         ON ACTION controlp INFIELD fabiseq
            #add-point:ON ACTION controlp INFIELD fabiseq
            
            #END add-point
 
         #Ctrlp:input.c.page1.fabiseq1
         ON ACTION controlp INFIELD fabiseq1
            #add-point:ON ACTION controlp INFIELD fabiseq1
            
            #END add-point
 
         #Ctrlp:input.c.page1.fabi001
         ON ACTION controlp INFIELD fabi001
            #add-point:ON ACTION controlp INFIELD fabi001
            
            #END add-point
 
         #Ctrlp:input.c.page1.fabi002
         ON ACTION controlp INFIELD fabi002
            #add-point:ON ACTION controlp INFIELD fabi002
            
            #END add-point
 
         #Ctrlp:input.c.page1.fabi003
         ON ACTION controlp INFIELD fabi003
            #add-point:ON ACTION controlp INFIELD fabi003
            
            #END add-point
 
         #Ctrlp:input.c.page1.fabi004
         ON ACTION controlp INFIELD fabi004
            #add-point:ON ACTION controlp INFIELD fabi004
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabi_d[l_ac].fabi004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            
            LET g_qryparam.where = " faai001 = '",g_fabk000,"' AND faai002 = '",g_fabk001,"'",
                                   " AND faai003 = '",g_fabk002,"'"

            
            CALL q_faai004()                                #呼叫開窗

            LET g_fabi_d[l_ac].fabiseq1 = g_qryparam.return1
            LET g_fabi_d[l_ac].fabi004 = g_qryparam.return2            
            LET g_qryparam.where = NULL            

            DISPLAY g_fabi_d[l_ac].fabi004 TO fabi004              #
           #IF g_fabi_d[l_ac].fabi004 <> g_fabi_d_t.fabi004 THEN
               CALL afat513_01_faai004_ref()
           #END IF

            NEXT FIELD fabi007                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.fabi005
         ON ACTION controlp INFIELD fabi005
            #add-point:ON ACTION controlp INFIELD fabi005
            
            #END add-point
 
         #Ctrlp:input.c.page1.fabi006
         ON ACTION controlp INFIELD fabi006
            #add-point:ON ACTION controlp INFIELD fabi006
            
            #END add-point
 
         #Ctrlp:input.c.page1.fabi007
         ON ACTION controlp INFIELD fabi007
            #add-point:ON ACTION controlp INFIELD fabi007
            
            #END add-point
 
         #Ctrlp:input.c.page1.fabi009
         ON ACTION controlp INFIELD fabi009
            #add-point:ON ACTION controlp INFIELD fabi009
            
            #END add-point
 
         #Ctrlp:input.c.page1.fabi010
         ON ACTION controlp INFIELD fabi010
            #add-point:ON ACTION controlp INFIELD fabi010
            
            #END add-point
 
         #Ctrlp:input.c.page1.fabi015
         ON ACTION controlp INFIELD fabi015
            #add-point:ON ACTION controlp INFIELD fabi015
            
            #END add-point
 
         #Ctrlp:input.c.page1.fabi016
         ON ACTION controlp INFIELD fabi016
            #add-point:ON ACTION controlp INFIELD fabi016
            
            #END add-point
 
         #Ctrlp:input.c.page1.fabi018
         ON ACTION controlp INFIELD fabi018
            #add-point:ON ACTION controlp INFIELD fabi018
            
            #END add-point
 
         #Ctrlp:input.c.page1.fabi022
         ON ACTION controlp INFIELD fabi022
            #add-point:ON ACTION controlp INFIELD fabi022
            
            #END add-point
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
 
               LET INT_FLAG = 0
               LET g_fabi_d[l_ac].* = g_fabi_d_t.*
               CLOSE afat513_01_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_fabi_d[l_ac].fabidocno 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               LET g_fabi_d[l_ac].* = g_fabi_d_t.*
            ELSE
               
               #寫入修改者/修改日期資訊(單身)
               
            
               #add-point:單身修改前
               
               #end add-point
               
               UPDATE fabi_t SET (fabi000,fabidocno,fabiseq,fabiseq1,fabi001,fabi002,fabi003,fabi004, 
                   fabi005,fabi006,fabi007,fabi009,fabi010,fabi015,fabi016,fabi018,fabi022) = (g_fabi_d[l_ac].fabi000, 
                   g_fabi_d[l_ac].fabidocno,g_fabi_d[l_ac].fabiseq,g_fabi_d[l_ac].fabiseq1,g_fabi_d[l_ac].fabi001, 
                   g_fabi_d[l_ac].fabi002,g_fabi_d[l_ac].fabi003,g_fabi_d[l_ac].fabi004,g_fabi_d[l_ac].fabi005, 
                   g_fabi_d[l_ac].fabi006,g_fabi_d[l_ac].fabi007,g_fabi_d[l_ac].fabi009,g_fabi_d[l_ac].fabi010, 
                   g_fabi_d[l_ac].fabi015,g_fabi_d[l_ac].fabi016,g_fabi_d[l_ac].fabi018,g_fabi_d[l_ac].fabi022) 
 
                WHERE fabient = g_enterprise AND
                  fabidocno = g_fabi_d_t.fabidocno #項次   
                  AND fabiseq = g_fabi_d_t.fabiseq  
                  AND fabiseq1 = g_fabi_d_t.fabiseq1  
                  AND fabi000 = g_fabi_d_t.fabi000  
 
                  
               #add-point:單身修改中
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fabi_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                    WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fabi_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fabi_d[g_detail_idx].fabidocno
               LET gs_keys_bak[1] = g_fabi_d_t.fabidocno
               LET gs_keys[2] = g_fabi_d[g_detail_idx].fabiseq
               LET gs_keys_bak[2] = g_fabi_d_t.fabiseq
               LET gs_keys[3] = g_fabi_d[g_detail_idx].fabiseq1
               LET gs_keys_bak[3] = g_fabi_d_t.fabiseq1
               LET gs_keys[4] = g_fabi_d[g_detail_idx].fabi000
               LET gs_keys_bak[4] = g_fabi_d_t.fabi000
               CALL afat513_01_update_b('fabi_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     LET g_log1 = util.JSON.stringify(g_fabi_d_t)
                     LET g_log2 = util.JSON.stringify(g_fabi_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #add-point:單身修改後
               
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL afat513_01_unlock_b("fabi_t")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            
             #add-point:單身after row
            
            #end add-point
            
         AFTER INPUT
            #add-point:單身input後
            
            #end add-point
            #錯誤訊息統整顯示
            #CALL cl_err_collect_show()
            #CALL cl_showmsg()
            
         ON ACTION controlo   
            CALL FGL_SET_ARR_CURR(g_fabi_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_fabi_d.getLength()+1
            
      END INPUT
      
 
      
 
      
      #add-point:before_more_input
      
      #end add-point
      
      BEFORE DIALOG
         #CALL cl_err_collect_init()      
         IF g_temp_idx > 0 THEN
            LET l_ac = g_temp_idx
            CALL DIALOG.setCurrentRow("s_detail1",l_ac)
            LET g_temp_idx = 1
         END IF
         LET g_curr_diag = ui.DIALOG.getCurrent()
         #add-point:before_dialog
         
         #end add-point
         CASE g_aw
            WHEN "s_detail1"
               NEXT FIELD fabi000
 
         END CASE
   
      ON ACTION accept
         ACCEPT DIALOG
      
      ON ACTION cancel
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION controlr
         CALL cl_show_req_fields()
 
      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) 
              RETURNING g_fld_name,g_frm_name 
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang) 
           
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   
   END DIALOG 
   
   #add-point:modify段修改後
   
   #end add-point
 
   CLOSE afat513_01_bcl
   CALL s_transaction_end('Y','0')
   
END FUNCTION
 
{</section>}
 
{<section id="afat513_01.delete" >}
#+ 資料刪除
PRIVATE FUNCTION afat513_01_delete()
   DEFINE li_idx          LIKE type_t.num5
   DEFINE li_ac_t         LIKE type_t.num5
   DEFINE li_detail_tmp   LIKE type_t.num5
   DEFINE l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE l_vars          DYNAMIC ARRAY OF STRING
   DEFINE l_fields        DYNAMIC ARRAY OF STRING
   #add-point:delete段define
   
   #end add-point 
   
   #add-point:單身刪除前
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET li_ac_t = l_ac
   
   LET li_detail_tmp = g_detail_idx
    
   #lock所有所選資料
   FOR li_idx = 1 TO g_fabi_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT afat513_01_lock_b("fabi_t") THEN
            #已被他人鎖定
            CALL s_transaction_end('N','0')
            RETURN
         END IF
      END IF
   END FOR
   
   #add-point:單身刪除詢問前
   
   #end add-point  
   
   #詢問是否確定刪除所選資料
   IF NOT cl_ask_del_detail() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   FOR li_idx = 1 TO g_fabi_d.getLength()
      IF g_fabi_d[li_idx].fabidocno IS NOT NULL
         AND g_fabi_d[li_idx].fabiseq IS NOT NULL
         AND g_fabi_d[li_idx].fabiseq1 IS NOT NULL
         AND g_fabi_d[li_idx].fabi000 IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前
         
         #end add-point   
         
         DELETE FROM fabi_t
          WHERE fabient = g_enterprise AND 
                fabidocno = g_fabi_d[li_idx].fabidocno
                AND fabiseq = g_fabi_d[li_idx].fabiseq
                AND fabiseq1 = g_fabi_d[li_idx].fabiseq1
                AND fabi000 = g_fabi_d[li_idx].fabi000
 
         #add-point:單身刪除中
         
         #end add-point  
                
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fabi_t" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
            CALL s_transaction_end('N','0')
            RETURN
         ELSE
            LET g_detail_cnt = g_detail_cnt-1
            LET l_ac = li_idx
            
 
            
 
            #add-point:單身同步刪除前(同層table)
            
            #end add-point
            LET g_detail_idx = li_idx
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fabi_d[g_detail_idx].fabidocno
               LET gs_keys[2] = g_fabi_d[g_detail_idx].fabiseq
               LET gs_keys[3] = g_fabi_d[g_detail_idx].fabiseq1
               LET gs_keys[4] = g_fabi_d[g_detail_idx].fabi000
 
            #add-point:單身同步刪除中(同層table)
            
            #end add-point
                           CALL afat513_01_delete_b('fabi_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table)
            
            #end add-point
         END IF 
      END IF 
    
   END FOR
   CALL s_transaction_end('Y','0')
   
   LET g_detail_idx = li_detail_tmp
            
   #add-point:單身刪除後
   
   #end add-point  
   
   LET l_ac = li_ac_t
   
   #刷新資料
   CALL afat513_01_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="afat513_01.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION afat513_01_b_fill(p_wc2)              #BODY FILL UP
   DEFINE p_wc2    STRING
   #add-point:b_fill段define
   
   #end add-point
   
   IF cl_null(p_wc2) THEN
      LET p_wc2 = " 1=1"
   END IF
   
   #add-point:b_fill段sql之前
  #IF NOT cl_null(p_wc2) THEN LET p_wc2 = cl_replace_str(p_wc2,"OR","AND") END IF  #cy
   #end add-point
 
   LET g_sql = "SELECT  UNIQUE t0.fabi000,t0.fabidocno,t0.fabiseq,t0.fabiseq1,t0.fabi001,t0.fabi002, 
       t0.fabi003,t0.fabi004,t0.fabi005,t0.fabi006,t0.fabi007,t0.fabi009,t0.fabi010,t0.fabi015,t0.fabi016, 
       t0.fabi018,t0.fabi022  FROM fabi_t t0",
               "",
               
               " WHERE t0.fabient= ?  AND  1=1 AND (", p_wc2, ") " 
   #add-point:b_fill段sql wc
   
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("fabi_t"),
                      " ORDER BY t0.fabidocno,t0.fabiseq,t0.fabiseq1,t0.fabi000"
   
   #add-point:b_fill段sql之後
   LET g_sql = "SELECT  UNIQUE t0.fabi000,t0.fabidocno,t0.fabiseq,t0.fabiseq1,t0.fabi001,t0.fabi002, 
       t0.fabi003,t0.fabi004,t0.fabi005,t0.fabi006,t0.fabi007,t0.fabi009,t0.fabi010,t0.fabi015,t0.fabi016, 
       t0.fabi018,t0.fabi022  FROM fabi_t t0",
               "",
               
               " WHERE t0.fabient= ?  AND  1=1 ", 
               "   AND t0.fabidocno = '",g_fabhdocno,"' AND t0.fabiseq = ",g_fabhseq,"",
               "   AND t0.fabi000 = '",g_fabg005,"' AND t0.fabi001 = '",g_fabh000,"'",
               "   AND t0.fabi002 = '",g_fabh001,"' AND (t0.fabi003 = '",g_fabh002,"' OR t0.fabi003 IS NULL)",
               "   AND ",p_wc2               
               
    
   LET g_sql = g_sql, cl_sql_add_filter("fabi_t"),
                      " ORDER BY t0.fabidocno,t0.fabiseq,t0.fabiseq1,t0.fabi000"
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"fabi_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE afat513_01_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR afat513_01_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_fabi_d.clear()
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_fabi_d[l_ac].fabi000,g_fabi_d[l_ac].fabidocno,g_fabi_d[l_ac].fabiseq,g_fabi_d[l_ac].fabiseq1, 
       g_fabi_d[l_ac].fabi001,g_fabi_d[l_ac].fabi002,g_fabi_d[l_ac].fabi003,g_fabi_d[l_ac].fabi004,g_fabi_d[l_ac].fabi005, 
       g_fabi_d[l_ac].fabi006,g_fabi_d[l_ac].fabi007,g_fabi_d[l_ac].fabi009,g_fabi_d[l_ac].fabi010,g_fabi_d[l_ac].fabi015, 
       g_fabi_d[l_ac].fabi016,g_fabi_d[l_ac].fabi018,g_fabi_d[l_ac].fabi022
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充
      
      #end add-point
      
      CALL afat513_01_detail_show()      
 
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code   = 9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF
 
      LET l_ac = l_ac + 1
      
   END FOREACH
 
   LET g_error_show = 0
   
 
   
   CALL g_fabi_d.deleteElement(g_fabi_d.getLength())   
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_fabi_d.getLength()
 
   END FOR
   
   IF g_cnt > g_fabi_d.getLength() THEN
      LET l_ac = g_fabi_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #add-point:b_fill段資料填充(其他單身)
 
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_fabi_d.getLength()
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE afat513_01_pb
   
END FUNCTION
 
{</section>}
 
{<section id="afat513_01.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION afat513_01_detail_show()
   #add-point:show段define
   
   #end add-point
 
   #add-point:detail_show段之前
   
   #end add-point
   
   
   
   #帶出公用欄位reference值page1
   
    
 
   
   #讀入ref值
   #add-point:show段單身reference
   
   #end add-point
   
 
   #add-point:detail_show段之後
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afat513_01.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION afat513_01_set_entry_b(p_cmd)                                                  
   DEFINE p_cmd   LIKE type_t.chr1         
   #add-point:set_entry_b段define
   
   #end add-point     
   
   #add-point:set_entry_b段control
   
   #end add-point                                                                   
                                                                                
END FUNCTION                                                                    
 
{</section>}
 
{<section id="afat513_01.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION afat513_01_set_no_entry_b(p_cmd)                                               
   DEFINE p_cmd   LIKE type_t.chr1           
   #add-point:set_no_entry_b段define
   
   #end add-point  
 
   #add-point:set_no_entry_b段control
   
   #end add-point       
                                                                                
END FUNCTION  
 
{</section>}
 
{<section id="afat513_01.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION afat513_01_default_search()
   DEFINE li_idx  LIKE type_t.num5
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE ls_wc   STRING
   #add-point:default_search段define
   IF NOT cl_null(ls_wc) THEN
      LET ls_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_wc2 = ls_wc
   ELSE
      LET g_wc2 = " 1=1"
   END IF
   RETURN
   #end add-point  
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " fabidocno = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " fabiseq = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " fabiseq1 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " fabi000 = '", g_argv[04], "' AND "
   END IF
 
   
   #add-point:default_search段after sql
   
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      LET ls_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_wc2 = ls_wc
   ELSE
      LET g_wc2 = " 1=1"
      #預設查詢條件
      LET g_wc2 = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc2) THEN
         LET g_wc2 = " 1=1"
      END IF
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="afat513_01.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION afat513_01_delete_b(ps_table,ps_keys_bak,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:delete_b段define
   
   #end add-point     
 
   #判斷是否是同一群組的table
   LET ls_group = "fabi_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> 'fabi_t' THEN
   
      #add-point:delete_b段刪除前
      
      #end add-point     
   
      DELETE FROM fabi_t
       WHERE fabient = g_enterprise AND
         fabidocno = ps_keys_bak[1] AND fabiseq = ps_keys_bak[2] AND fabiseq1 = ps_keys_bak[3] AND fabi000 = ps_keys_bak[4]
 
      #add-point:delete_b段刪除中
      
      #end add-point  
         
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
      END IF
      
      #add-point:delete_b段刪除後
      
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="afat513_01.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION afat513_01_insert_b(ps_table,ps_keys,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:insert_b段define
   
   #end add-point     
 
   #判斷是否是同一群組的table
   LET ls_group = "fabi_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前
      
      #end add-point    
      INSERT INTO fabi_t
                  (fabient,
                   fabidocno,fabiseq,fabiseq1,fabi000
                   ,fabi001,fabi002,fabi003,fabi004,fabi005,fabi006,fabi007,fabi009,fabi010,fabi015,fabi016,fabi018,fabi022) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
                   ,g_fabi_d[l_ac].fabi001,g_fabi_d[l_ac].fabi002,g_fabi_d[l_ac].fabi003,g_fabi_d[l_ac].fabi004, 
                       g_fabi_d[l_ac].fabi005,g_fabi_d[l_ac].fabi006,g_fabi_d[l_ac].fabi007,g_fabi_d[l_ac].fabi009, 
                       g_fabi_d[l_ac].fabi010,g_fabi_d[l_ac].fabi015,g_fabi_d[l_ac].fabi016,g_fabi_d[l_ac].fabi018, 
                       g_fabi_d[l_ac].fabi022)
      #add-point:insert_b段新增中
      
      #end add-point    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fabi_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
      END IF
      #add-point:insert_b段新增後
      UPDATE fabi_t SET fabistus = 'Y' 
       WHERE fabient = g_enterprise AND fabidocno = ps_keys[1] AND fabi000 = ps_keys[4]
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "upd fabi_t " 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
      END IF       
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="afat513_01.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION afat513_01_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   DEFINE ps_page          STRING
   DEFINE ps_table         STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num5 
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   #add-point:update_b段define

   #end add-point     
   
   #比對新舊值, 判斷key是否有改變
   LET lb_chk = TRUE
   FOR li_idx = 1 TO ps_keys.getLength()
      IF ps_keys[li_idx] <> ps_keys_bak[li_idx] THEN
         LET lb_chk = FALSE
         EXIT FOR
      END IF
   END FOR
   
   #若key無變動, 不需要做處理
   IF lb_chk THEN
      RETURN
   END IF
    
   #若key有變動, 則連動其他table的資料   
   #判斷是否是同一群組的table
   LET ls_group = "fabi_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "fabi_t" THEN
      #add-point:update_b段修改前

      #end add-point     
      UPDATE fabi_t 
         SET (fabidocno,fabiseq,fabiseq1,fabi000
              ,fabi001,fabi002,fabi003,fabi004,fabi005,fabi006,fabi007,fabi009,fabi010,fabi015,fabi016,fabi018,fabi022) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
              ,g_fabi_d[l_ac].fabi001,g_fabi_d[l_ac].fabi002,g_fabi_d[l_ac].fabi003,g_fabi_d[l_ac].fabi004, 
                  g_fabi_d[l_ac].fabi005,g_fabi_d[l_ac].fabi006,g_fabi_d[l_ac].fabi007,g_fabi_d[l_ac].fabi009, 
                  g_fabi_d[l_ac].fabi010,g_fabi_d[l_ac].fabi015,g_fabi_d[l_ac].fabi016,g_fabi_d[l_ac].fabi018, 
                  g_fabi_d[l_ac].fabi022) 
         #WHERE fabidocno = ps_keys_bak[1] AND fabiseq = ps_keys_bak[2] AND fabiseq1 = ps_keys_bak[3] AND fabi000 = ps_keys_bak[4]  #160905-00007#2 mark
         WHERE fabient = g_enterprise AND fabidocno = ps_keys_bak[1] AND fabiseq = ps_keys_bak[2] AND fabiseq1 = ps_keys_bak[3] AND fabi000 = ps_keys_bak[4] #160905-00007#12 add
      #add-point:update_b段修改中

      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fabi_t" 
            LET g_errparam.code   = "std-00009" 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fabi_t" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
            CALL s_transaction_end('N','0')
         OTHERWISE
            
      END CASE
      #add-point:update_b段修改後

      #end add-point 
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="afat513_01.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION afat513_01_lock_b(ps_table)
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define
   
   #end add-point   
   
   #先刷新資料
   #CALL afat513_01_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "fabi_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN afat513_01_bcl USING g_enterprise,
                                       g_fabi_d[g_detail_idx].fabidocno,g_fabi_d[g_detail_idx].fabiseq, 
                                           g_fabi_d[g_detail_idx].fabiseq1,g_fabi_d[g_detail_idx].fabi000 
 
                                       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "afat513_01_bcl" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="afat513_01.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION afat513_01_unlock_b(ps_table)
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:unlock_b段define
   
   #end add-point  
   
   LET ls_group = ""
   
   #IF ls_group.getIndexOf(ps_table,1) THEN
      CLOSE afat513_01_bcl
   #END IF
   
 
 
END FUNCTION
 
{</section>}
 
{<section id="afat513_01.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION afat513_01_modify_detail_chk(ps_record)
   DEFINE ps_record STRING
   DEFINE ls_return STRING
   #add-point:modify_detail_chk段define
   
   #end add-point
   
   #add-point:modify_detail_chk段開始前
   
   #end add-point
   
   #根據sr名稱確定該page第一個欄位的名稱
   CASE ps_record
      WHEN "s_detail1" 
         LET ls_return = "fabi000"
 
      #add-point:modify_detail_chk段自訂page控制
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="afat513_01.set_pk_array" >}
   #+ 此段落由子樣板a51產生
#+ 給予pk_array內容
PRIVATE FUNCTION afat513_01_set_pk_array()
   #add-point:set_pk_array段define
   
   #end add-point
   
   #add-point:set_pk_array段之前
   
   #end add-point  
   
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_fabi_d[l_ac].fabidocno
   LET g_pk_array[1].column = 'fabidocno'
   LET g_pk_array[2].values = g_fabi_d[l_ac].fabiseq
   LET g_pk_array[2].column = 'fabiseq'
   LET g_pk_array[3].values = g_fabi_d[l_ac].fabiseq1
   LET g_pk_array[3].column = 'fabiseq1'
   LET g_pk_array[4].values = g_fabi_d[l_ac].fabi000
   LET g_pk_array[4].column = 'fabi000'
   
   #add-point:set_pk_array段之後
   
   #end add-point  
   
END FUNCTION
 
 
 
{</section>}
 
{<section id="afat513_01.state_change" >}
   
 
{</section>}
 
{<section id="afat513_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="afat513_01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 根據財編，批號，卡片編號帶出相應欄位值
# Memo...........:
# Usage..........: afat513_01_faai004_ref()
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION afat513_01_faai004_ref()

   CASE 
      WHEN g_faba003  = 10
         #若为外送，此时数量栏位预设可外送数量，即为数量-在外数量
         SELECT faai005,faai006,faai007-faai008,faai007,faai008,faai009,faai010,faai015,faai016,faai018,faai022,SUM(faai008)
           INTO g_fabi_d[l_ac].fabi005,g_fabi_d[l_ac].fabi006,g_fabi_d[l_ac].fabi007,g_faai007,g_faai008,
                g_fabi_d[l_ac].fabi009,g_fabi_d[l_ac].fabi010,g_fabi_d[l_ac].fabi015,
                g_fabi_d[l_ac].fabi016,g_fabi_d[l_ac].fabi018,g_fabi_d[l_ac].fabi022,g_faai008_sum
           FROM faai_t
          WHERE faaient = g_enterprise AND faai001 = g_fabk000
             AND faai002 = g_fabk001 AND faai003 = g_fabk002
             AND faai004 = g_fabi_d[l_ac].fabi004 
             AND faaiseq = g_fabi_d[l_ac].fabiseq1
          GROUP BY faai005,faai006,faai007,faai008,faai009,faai010,faai015,faai016,faai018,faai022 
          ORDER BY faai005,faai006,faai007,faai008,faai009,faai010,faai015,faai016,faai018,faai022 
       WHEN g_faba003  = 11
          #若为外送收回，此时数量栏位预设在外数量
          SELECT faai005,faai006,faai008,faai007,faai009,faai010,faai015,faai016,faai018,faai022,SUM(faai008)
           INTO g_fabi_d[l_ac].fabi005,g_fabi_d[l_ac].fabi006,g_fabi_d[l_ac].fabi007,g_faai007,
                g_fabi_d[l_ac].fabi009,g_fabi_d[l_ac].fabi010,g_fabi_d[l_ac].fabi015,
                g_fabi_d[l_ac].fabi016,g_fabi_d[l_ac].fabi018,g_fabi_d[l_ac].fabi022,g_faai008_sum
           FROM faai_t
          WHERE faaient = g_enterprise AND faai001 = g_fabk000
             AND faai002 = g_fabk001 AND faai003 = g_fabk002
             AND faai004 = g_fabi_d[l_ac].fabi004
             AND faaiseq = g_fabi_d[l_ac].fabiseq1
          GROUP BY faai005,faai006,faai007,faai008,faai009,faai010,faai015,faai016,faai018,faai022 
          ORDER BY faai005,faai006,faai007,faai008,faai009,faai010,faai015,faai016,faai018,faai022
          LET g_faai008 = g_fabi_d[l_ac].fabi007          
       OTHERWISE
          #若为其他，此时数量栏位直接预设数量faai007
         SELECT faai005,faai006,faai007,faai007,faai008,faai009,faai010,faai015,faai016,faai018,faai022
           INTO g_fabi_d[l_ac].fabi005,g_fabi_d[l_ac].fabi006,g_fabi_d[l_ac].fabi007,g_faai007,g_faai008,
                g_fabi_d[l_ac].fabi009,g_fabi_d[l_ac].fabi010,g_fabi_d[l_ac].fabi015,
                g_fabi_d[l_ac].fabi016,g_fabi_d[l_ac].fabi018,g_fabi_d[l_ac].fabi022
           FROM faai_t
          WHERE faaient = g_enterprise AND faai001 = g_fabk000
             AND faai002 = g_fabk001 AND faai003 = g_fabk002
             AND faai004 = g_fabi_d[l_ac].fabi004
             AND faaiseq = g_fabi_d[l_ac].fabiseq1
    END CASE

END FUNCTION

 
{</section>}
 
