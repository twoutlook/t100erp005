#該程式已解開Section, 不再透過樣板產出!
{<section id="adbi201.description" >}
#+ Version..: T100-ERP-1.00.00(SD版次:1,PD版次:1) Build-000191
#+ 
#+ Filename...: adbi201
#+ Description: pomelo 程式練習
#+ Creator....: 04226(2014/06/16)
#+ Modifier...: 04226(2014/06/16)
#+ Buildtype..: 應用 t02 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="adbi201.global" >}
#160318-00025#18 2016/04/13 BY 07900    校验代码重复错误讯息的修改
#161215-00045#3  2016/12/15 By Rainy      browser_fill()增加呼叫權限過濾器lib
#160905-00003#1 2016/09/05 By Rainy 修正WHERE 條件沒下ent 
IMPORT os
IMPORT util
#add-point:增加匯入項目

#end add-point
    
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_dbag_d RECORD
   dbag001      LIKE dbag_t.dbag001, 
   dbag002      LIKE dbag_t.dbag002, 
   dbag002_desc LIKE type_t.chr500, 
   dbag003      LIKE dbag_t.dbag003, 
   dbag003_desc LIKE type_t.chr500, 
   dbagsite     LIKE dbag_t.dbagsite
       END RECORD
PRIVATE TYPE type_g_dbag2_d RECORD
   dbagstus      LIKE dbag_t.dbagstus, 
   dbagsite      LIKE dbag_t.dbagsite, 
   dbagsite_desc LIKE type_t.chr500, 
   dbag004       LIKE dbag_t.dbag004, 
   dbag004_desc  LIKE type_t.chr500, 
   dbag005       LIKE dbag_t.dbag005, 
   dbag005_desc  LIKE type_t.chr500, 
   dbag006       LIKE dbag_t.dbag006, 
   dbag006_desc  LIKE type_t.chr500, 
   dbag007       LIKE dbag_t.dbag007, 
   dbag007_desc  LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_dbag3_d RECORD
       dbagsite LIKE dbag_t.dbagsite,
   dbagownid LIKE dbag_t.dbagownid, 
   dbagownid_desc LIKE type_t.chr500, 
   dbagowndp LIKE dbag_t.dbagowndp, 
   dbagowndp_desc LIKE type_t.chr500, 
   dbagcrtid LIKE dbag_t.dbagcrtid, 
   dbagcrtid_desc LIKE type_t.chr500, 
   dbagcrtdp LIKE dbag_t.dbagcrtdp, 
   dbagcrtdp_desc LIKE type_t.chr500, 
   dbagcrtdt DATETIME YEAR TO SECOND, 
   dbagmodid LIKE dbag_t.dbagmodid, 
   dbagmodid_desc LIKE type_t.chr500, 
   dbagmoddt DATETIME YEAR TO SECOND
       END RECORD
 
 
#無單身append欄位定義
 
#模組變數(Module Variables)
DEFINE g_master          type_g_dbag_d
DEFINE g_master_t        type_g_dbag_d
DEFINE g_dbag_d          DYNAMIC ARRAY OF type_g_dbag_d
DEFINE g_dbag_d_t        type_g_dbag_d
DEFINE g_dbag2_d         DYNAMIC ARRAY OF type_g_dbag2_d
DEFINE g_dbag2_d_t       type_g_dbag2_d
DEFINE g_dbag3_d         DYNAMIC ARRAY OF type_g_dbag3_d
DEFINE g_dbag3_d_t       type_g_dbag3_d
 
      
DEFINE g_wc                 STRING
DEFINE g_wc2                STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                        #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10    
DEFINE l_ac                 LIKE type_t.num5              
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_detail_idx         LIKE type_t.num5              #單身所在筆數(第一階單身)
DEFINE g_detail_idx2        LIKE type_t.num5              #單身所在筆數(第二階單身)
DEFINE g_detail_cnt         LIKE type_t.num5              #單身總筆數 (第一階單身)
DEFINE g_detail_cnt2        LIKE type_t.num5              #單身總筆數 (第二階單身)
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_aw                 STRING                        #確定當下點擊的單身
DEFINE g_current_page       LIKE type_t.num5              #判斷單身筆數用
DEFINE g_loc                LIKE type_t.chr5              #判斷游標所在位置
 
#多table用wc
DEFINE g_wc_table           STRING
 
DEFINE g_wc2_table2   STRING
 
 
 
 
#add-point:自定義模組變數(Module Variable)
DEFINE g_dbag_d_o        type_g_dbag_d
DEFINE g_dbag2_d_o       type_g_dbag2_d
DEFINE g_dbag3_d_o       type_g_dbag3_d
#end add-point
 
#add-point:傳入參數說明(global.argv)

#end add-point
 
{</section>}
 
{<section id="adbi201.main" >}
#+ 此段落由子樣板a26產生
#OPTIONS SHORT CIRCUIT
#+ 作業開始 
MAIN
   #add-point:main段define
   DEFINE l_success LIKE type_t.num5 #150308-00001#1  By Ken 150309
   #end add-point   
 
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("adb","")
 
   #add-point:作業初始化
   LET g_argv[1] = cl_replace_str(g_argv[1], '\"', '')
   LET g_argv[1] = cl_replace_str(g_argv[1], "\'", '') #ken---modify 需求單號：141224-00013 項次：23  '\''改為"\'"
   #LET g_argv[1] = "'",g_argv[1],"'" #ken---mark 需求單號：141224-00013 項次：23
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
 
 
 
 
 
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call

      #end add-point
 
   ELSE
      
      #畫面開啟 (identifier)
      OPEN WINDOW w_adbi201 WITH FORM cl_ap_formpath("adb",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL adbi201_init()   
 
      #進入選單 Menu (="N")
      CALL adbi201_ui_dialog() 
      
      #add-point:畫面關閉前

      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_adbi201
      
   END IF 
   
   
   
 
   #add-point:作業離開前
   CALL s_aooi500_drop_temp() RETURNING l_success #150308-00001#1  By Ken 150309
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN
 
 
 
{</section>}
 
{<section id="adbi201.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION adbi201_init()
   #add-point:init段define
   DEFINE l_gzze003  LIKE gzze_t.gzze003
   DEFINE l_success LIKE type_t.num5 #150308-00001#1  By Ken 150309   
   #end add-point   
 
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1   
   LET g_error_show = 1
   
   
   LET l_ac = 1
   
   
   
 
   #避免USER直接進入第二單身時無資料
   IF g_dbag_d.getLength() > 0 THEN
      LET g_master_t.* = g_dbag_d[1].*
      LET g_master.* = g_dbag_d[1].*
   END IF
 
   #add-point:畫面資料初始化
   CALL s_aooi500_create_temp() RETURNING l_success #150308-00001#1  By Ken 150309   
   IF g_argv[1] = '1' THEN
      #代送商編號
      LET l_gzze003 = cl_getmsg('adb-00193',g_dlang)
      CALL cl_set_comp_att_text('dbag002',l_gzze003)
      #代送商簡稱
      LET l_gzze003 = cl_getmsg('adb-00194',g_dlang)
      CALL cl_set_comp_att_text('dbag002_desc',l_gzze003)
      CALL cl_set_comp_visible('dbag003,dbag003_desc',FALSE)
   END IF
   LET g_errshow = 1
   #end add-point
   
   CALL adbi201_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="adbi201.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION adbi201_ui_dialog()
   DEFINE la_param  RECORD
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   DEFINE li_idx   LIKE type_t.num5
   #add-point:ui_dialog段define

   #end add-point 
 
   LET g_action_choice = " "  
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm() 
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   #add-point:ui_dialog段before dialog 

   #end add-point
   
   WHILE TRUE
   
      #add-point:ui_dialog段before while
      LET g_current_page = 0
      #end add-point
   
      CALL adbi201_b_fill(g_wc)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_dbag_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'
               LET g_current_page = 1
	  
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               LET g_master.* = g_dbag_d[g_detail_idx].*
               CALL cl_show_fld_cont()
               CALL adbi201_fetch()
               CALL adbi201_idx_chk('m')
               
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
 
         
         DISPLAY ARRAY g_dbag2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'd' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx2)
               END IF
               LET g_loc = 'd'
               LET g_current_page = 2
         
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               CALL adbi201_idx_chk('d')
               LET g_master.* = g_dbag_d[g_detail_idx].*
               CALL cl_show_fld_cont() 
               
            #自訂ACTION(detail_show,page_2)
            
               
         END DISPLAY
         DISPLAY ARRAY g_dbag3_d TO s_detail3.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'd' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx2)
               END IF
               LET g_loc = 'd'
               LET g_current_page = 3
         
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx2
               CALL adbi201_idx_chk('d')
               LET g_master.* = g_dbag_d[g_detail_idx].*
               CALL cl_show_fld_cont() 
               
            #自訂ACTION(detail_show,page_3)
            
               
         END DISPLAY
 
      
         #add-point:ui_dialog段自定義display array

         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()         
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            IF g_detail_idx > 0 THEN
               IF g_detail_idx > g_dbag_d.getLength() THEN
                  LET g_detail_idx = g_dbag_d.getLength()
               END IF
               CALL DIALOG.setCurrentRow("s_detail1", g_detail_idx)
               LET l_ac = g_detail_idx
            END IF 
            LET g_detail_idx = l_ac
            NEXT FIELD CURRENT
         
         AFTER DIALOG
            #add-point:ui_dialog段after dialog

            #end add-point

 

         #+ 此段落由子樣板a43產生
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL adbi201_query()
               #add-point:ON ACTION query

               #END add-point
               
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
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL adbi201_modify()
               #add-point:ON ACTION modify

               #END add-point
               EXIT DIALOG
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL adbi201_modify()
               #add-point:ON ACTION modify_detail

               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION exporttoexcel 
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_dbag_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_dbag2_d)
               LET g_export_id[2]   = "s_detail2"
               LET g_export_node[3] = base.typeInfo.create(g_dbag3_d)
               LET g_export_id[3]   = "s_detail3"
 
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
      
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice="exit"
            EXIT DIALOG
      
         ON ACTION exit
            LET g_action_choice="exit"
            EXIT DIALOG
           
         
      
         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
      
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="adbi201.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION adbi201_query()
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define

   #end add-point 
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_dbag_d.clear()
   
   LET g_qryparam.state = "c"
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
   #wc備份
   LET ls_wc = g_wc
   LET g_detail_idx = l_ac
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單身根據table分拆construct
      CONSTRUCT g_wc_table ON dbag001,dbag002,dbag003,dbagsite
           FROM s_detail1[1].dbag001,s_detail1[1].dbag002,s_detail1[1].dbag003,s_detail1[1].dbagsite1
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
       #---------------------<  Detail: page1  >---------------------
         #----<<dbag001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dbag001
            #add-point:BEFORE FIELD dbag001

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbag001
            
            #add-point:AFTER FIELD dbag001

            #END add-point
            
 
         #Ctrlp:construct.c.page1.dbag001
         ON ACTION controlp INFIELD dbag001
            #add-point:ON ACTION controlp INFIELD dbag001

            #END add-point
 
         #----<<dbag002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dbag002
            #add-point:BEFORE FIELD dbag002

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbag002
            
            #add-point:AFTER FIELD dbag002

            #END add-point
            
 
         #Ctrlp:construct.c.page1.dbag002
         ON ACTION controlp INFIELD dbag002
            #add-point:ON ACTION controlp INFIELD dbag002
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #代送商倉庫
            IF g_argv[1] = '1' THEN
               CALL q_pmaa001_10()                 #呼叫開窗
            ELSE
               LET g_qryparam.arg1 = 'ALL'
               #寄銷倉庫
               CALL q_pmaa001_6()                  #呼叫開窗
            END IF
            DISPLAY g_qryparam.return1 TO dbag002  #顯示到畫面上
            NEXT FIELD dbag002                     #返回原欄位
            #END add-point
 
         #----<<dbag003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dbag003
            #add-point:BEFORE FIELD dbag003

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbag003
            
            #add-point:AFTER FIELD dbag003

            #END add-point
            
 
         #Ctrlp:construct.c.page1.dbag003
         ON ACTION controlp INFIELD dbag003
            #add-point:ON ACTION controlp INFIELD dbag003
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg2 = 'ALL'
            CALL q_pmac002_6()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbag003  #顯示到畫面上
            NEXT FIELD dbag003                     #返回原欄位
            #END add-point
 
         #----<<dbagsite>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dbagsite
            #add-point:BEFORE FIELD dbagsite

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbagsite
            
            #add-point:AFTER FIELD dbagsite

            #END add-point
            
 
         #Ctrlp:construct.c.page1.dbagsite
         ON ACTION controlp INFIELD dbagsite
            #add-point:ON ACTION controlp INFIELD dbagsite

            #END add-point
 
   
       
      END CONSTRUCT
      
 
      
      CONSTRUCT g_wc2_table2 ON dbagstus,dbagsite,dbag004,dbag005,dbag006,dbag007,dbagownid,dbagowndp, 
          dbagcrtid,dbagcrtdp,dbagcrtdt,dbagmodid,dbagmoddt
           FROM s_detail2[1].dbagstus,s_detail2[1].dbagsite,s_detail2[1].dbag004,s_detail2[1].dbag005, 
               s_detail2[1].dbag006,s_detail2[1].dbag007,s_detail3[1].dbagownid,s_detail3[1].dbagowndp, 
               s_detail3[1].dbagcrtid,s_detail3[1].dbagcrtdp,s_detail3[1].dbagcrtdt,s_detail3[1].dbagmodid, 
               s_detail3[1].dbagmoddt
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct

            #end add-point 
            
     
         AFTER FIELD dbagcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<dbagmoddt>>----
         AFTER FIELD dbagmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<dbagcnfdt>>----
         #AFTER FIELD dbagcnfdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<dbagpstdt>>----
         #AFTER FIELD dbagpstdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
       
       #單身一般欄位開窗相關處理       
       #---------------------<  Detail: page2  >---------------------
         #----<<dbagstus>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dbagstus
            #add-point:BEFORE FIELD dbagstus

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbagstus
            
            #add-point:AFTER FIELD dbagstus

            #END add-point
            
 
         #Ctrlp:construct.c.page2.dbagstus
         ON ACTION controlp INFIELD dbagstus
            #add-point:ON ACTION controlp INFIELD dbagstus

            #END add-point
 
         #----<<dbagsite>>----
         #Ctrlp:construct.c.page2.dbagsite
         ON ACTION controlp INFIELD dbagsite
            #add-point:ON ACTION controlp INFIELD dbagsite
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'dbagsite',g_site,'c') #150308-00001#1  By Ken add 'c' 150309
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbagsite  #顯示到畫面上
            NEXT FIELD dbagsite                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dbagsite
            #add-point:BEFORE FIELD dbagsite

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbagsite
            
            #add-point:AFTER FIELD dbagsite

            #END add-point
            
 
         #----<<dbagsite_desc>>----
         #----<<dbag004>>----
         #Ctrlp:construct.c.page2.dbag004
         ON ACTION controlp INFIELD dbag004
            #add-point:ON ACTION controlp INFIELD dbag004
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_7()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbag004  #顯示到畫面上
            NEXT FIELD dbag004                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dbag004
            #add-point:BEFORE FIELD dbag004

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbag004
            
            #add-point:AFTER FIELD dbag004

            #END add-point
            
 
         #----<<dbag004_desc>>----
         #----<<dbag005>>----
         #Ctrlp:construct.c.page2.dbag005
         ON ACTION controlp INFIELD dbag005
            #add-point:ON ACTION controlp INFIELD dbag005
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag005_10()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbag005  #顯示到畫面上
            NEXT FIELD dbag005                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dbag005
            #add-point:BEFORE FIELD dbag005

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbag005
            
            #add-point:AFTER FIELD dbag005

            #END add-point
            
 
         #----<<dbag005_desc>>----
         #----<<dbag006>>----
         #Ctrlp:construct.c.page2.dbag006
         ON ACTION controlp INFIELD dbag006
            #add-point:ON ACTION controlp INFIELD dbag006
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_7()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbag006  #顯示到畫面上
            NEXT FIELD dbag006                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dbag006
            #add-point:BEFORE FIELD dbag006

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbag006
            
            #add-point:AFTER FIELD dbag006

            #END add-point
            
 
         #----<<dbag006_desc>>----
         #----<<dbag007>>----
         #Ctrlp:construct.c.page2.dbag007
         ON ACTION controlp INFIELD dbag007
            #add-point:ON ACTION controlp INFIELD dbag007
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag005_10()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbag007  #顯示到畫面上
            NEXT FIELD dbag007                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dbag007
            #add-point:BEFORE FIELD dbag007

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbag007
            
            #add-point:AFTER FIELD dbag007

            #END add-point
            
 
         #----<<dbag007_desc>>----
#---------------------<  Detail: page3  >---------------------
         #----<<dbagownid>>----
         #Ctrlp:construct.c.page3.dbagownid
         ON ACTION controlp INFIELD dbagownid
            #add-point:ON ACTION controlp INFIELD dbagownid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbagownid  #顯示到畫面上
            NEXT FIELD dbagownid                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dbagownid
            #add-point:BEFORE FIELD dbagownid

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbagownid
            
            #add-point:AFTER FIELD dbagownid

            #END add-point
            
 
         #----<<dbagownid_desc>>----
         #----<<dbagowndp>>----
         #Ctrlp:construct.c.page3.dbagowndp
         ON ACTION controlp INFIELD dbagowndp
            #add-point:ON ACTION controlp INFIELD dbagowndp
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbagowndp  #顯示到畫面上
            NEXT FIELD dbagowndp                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dbagowndp
            #add-point:BEFORE FIELD dbagowndp

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbagowndp
            
            #add-point:AFTER FIELD dbagowndp

            #END add-point
            
 
         #----<<dbagowndp_desc>>----
         #----<<dbagcrtid>>----
         #Ctrlp:construct.c.page3.dbagcrtid
         ON ACTION controlp INFIELD dbagcrtid
            #add-point:ON ACTION controlp INFIELD dbagcrtid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbagcrtid  #顯示到畫面上
            NEXT FIELD dbagcrtid                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dbagcrtid
            #add-point:BEFORE FIELD dbagcrtid

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbagcrtid
            
            #add-point:AFTER FIELD dbagcrtid

            #END add-point
            
 
         #----<<dbagcrtid_desc>>----
         #----<<dbagcrtdp>>----
         #Ctrlp:construct.c.page3.dbagcrtdp
         ON ACTION controlp INFIELD dbagcrtdp
            #add-point:ON ACTION controlp INFIELD dbagcrtdp
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbagcrtdp  #顯示到畫面上
            NEXT FIELD dbagcrtdp                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dbagcrtdp
            #add-point:BEFORE FIELD dbagcrtdp

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbagcrtdp
            
            #add-point:AFTER FIELD dbagcrtdp

            #END add-point
            
 
         #----<<dbagcrtdp_desc>>----
         #----<<dbagcrtdt>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dbagcrtdt
            #add-point:BEFORE FIELD dbagcrtdt

            #END add-point
 
         #----<<dbagmodid>>----
         #Ctrlp:construct.c.page3.dbagmodid
         ON ACTION controlp INFIELD dbagmodid
            #add-point:ON ACTION controlp INFIELD dbagmodid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbagmodid  #顯示到畫面上
            NEXT FIELD dbagmodid                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dbagmodid
            #add-point:BEFORE FIELD dbagmodid

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbagmodid
            
            #add-point:AFTER FIELD dbagmodid

            #END add-point
            
 
         #----<<dbagmodid_desc>>----
         #----<<dbagmoddt>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dbagmoddt
            #add-point:BEFORE FIELD dbagmoddt

            #END add-point
 
   
       
      END CONSTRUCT
 
 
  
      #add-point:query段more_construct

      #end add-point 
      
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog

         #end add-point  
 
      ON ACTION qbe_select     #條件查詢
         CALL cl_qbe_list('m') RETURNING ls_wc
 
      ON ACTION qbe_save       #條件儲存
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
      LET INT_FLAG = 0
      #還原
      LET g_wc = ls_wc
   ELSE
      LET g_detail_idx = 1
   END IF
   
   LET g_wc = g_wc_table 
 
              , " AND ", g_wc2_table2
 
 
        
   LET g_wc2 = " 1=1"
               , " AND ", g_wc2_table2
 
 
        
   #add-point:cs段after_construct

   #end add-point
        
   LET g_error_show = 1
   CALL adbi201_b_fill(g_wc)
   LET l_ac = g_detail_idx
   CALL adbi201_fetch()
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = -100
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
 
   END IF
   
END FUNCTION
 
{</section>}
 
{<section id="adbi201.insert" >}
#+ 資料修改
PRIVATE FUNCTION adbi201_insert()
   #add-point:insert段define

   #end add-point 
 
   #add-point:insert段新增前

   #end add-point 
   
   #進入資料輸入段落
   CALL g_dbag_d.clear() 
   CALL g_dbag2_d.clear() 
   CALL g_dbag3_d.clear() 
 
   CALL adbi201_input('a')
   
   CALL adbi201_b_fill(g_wc)
   
   #add-point:insert段新增後

   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="adbi201.modify" >}
#+ 資料新增
PRIVATE FUNCTION adbi201_modify()
   #add-point:modify段define
   
   #end add-point 
 
   #add-point:modify段新增前
   
   #end add-point 
   
   #進入資料輸入段落
   CALL adbi201_input('u')
   
   #add-point:modify段新增後
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="adbi201.delete" >}
#+ 資料刪除
PRIVATE FUNCTION adbi201_delete()
   DEFINE li_ac LIKE type_t.num5
   #add-point:delete段define

   #end add-point 
   IF NOT cl_ask_delete() THEN
      #不刪除
      RETURN
   END IF
   
   LET li_ac = ARR_CURR()
   LET g_dbag_d_t.* = g_dbag_d[li_ac].*
   
   CALL s_transaction_begin()  
   
   #add-point:delete段刪除前

   #end add-point 
   
   #刪除單頭
   DELETE FROM dbag_t 
         WHERE dbagent = g_enterprise         #160905-00003#1 modify by rainy 加上ent條件
           AND dbag001 = g_dbag_d_t.dbag001
           AND dbag002 = g_dbag_d_t.dbag002
           AND dbag003 = g_dbag_d_t.dbag003
 
           
   #add-point:delete段刪除中

   #end add-point 
           
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "dbag_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
 
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:delete段刪除後

   #end add-point 
   
   #刪除單頭
   #add-point:delete段刪除前

   #end add-point 
   DELETE FROM dbag_t 
         WHERE dbagent = g_enterprise         #160905-00003#1 modify by rainy 加上ent條件
           AND dbag001 = g_dbag_d_t.dbag001
           AND dbag002 = g_dbag_d_t.dbag002
           AND dbag003 = g_dbag_d_t.dbag003
 
   #add-point:delete段刪除中

   #end add-point 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "dbag_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
 
      CALL s_transaction_end('N','0')
      RETURN
   ELSE
      CALL s_transaction_end('Y','0')
   END IF
   #add-point:delete段刪除後

   #end add-point 
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="adbi201.input" >}
#+ 資料輸入
PRIVATE FUNCTION adbi201_input(p_cmd)
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_ac_t                LIKE type_t.num5                #未取消的ARRAY CNT 
   DEFINE  l_n                   LIKE type_t.num5                #檢查重複用  
   DEFINE  l_cnt                 LIKE type_t.num5                #檢查重複用  
   DEFINE  l_lock_sw             LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert        LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete        LIKE type_t.num5                #可刪除否  
   DEFINE  l_count               LIKE type_t.num5
   DEFINE  l_i                   LIKE type_t.num5
   DEFINE  ls_return             STRING
   DEFINE  l_var_keys            DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys          DYNAMIC ARRAY OF STRING
   DEFINE  l_vars                DYNAMIC ARRAY OF STRING
   DEFINE  l_fields              DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak        DYNAMIC ARRAY OF STRING
   DEFINE  lb_reproduce          BOOLEAN
   DEFINE  li_reproduce          LIKE type_t.num5
   DEFINE  li_reproduce_target   LIKE type_t.num5
   #add-point:input段define
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_errno               LIKE type_t.chr10
   DEFINE  l_where               STRING
   DEFINE  l_insert              LIKE type_t.num5
   #end add-point 
   
   LET g_action_choice = ""
   
   LET g_qryparam.state = "i"
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
 
   #add-point:input段define_sql

   #end add-point 
   LET g_forupd_sql = "SELECT dbag001,dbag002,dbag003,dbagsite FROM dbag_t WHERE dbagent=? AND dbag001=?  
       AND dbag002=? AND dbag003=? FOR UPDATE"
   #add-point:input段define_sql

   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE adbi201_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
   
 
   
   #add-point:input段define_sql

   #end add-point 
   LET g_forupd_sql = "SELECT dbagstus,dbagsite,'',dbag004,'',dbag005,'',dbag006,'',dbag007,'','',
       dbagownid,'',dbagowndp,'',dbagcrtid,'',dbagcrtdp,'',dbagcrtdt,dbagmodid,'',dbagmoddt FROM dbag_t  
       WHERE dbagent=? AND dbag001=? AND dbag002=? AND dbag003=? AND dbagsite=? FOR UPDATE"
   #add-point:input段define_sql

   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE adbi201_bcl2 CURSOR FROM g_forupd_sql
 
 
 
   LET lb_reproduce = FALSE
   
   #add-point:input段修改前

   #end add-point
 
   LET INT_FLAG = 0
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #Page1 預設值產生於此處
      INPUT ARRAY g_dbag_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_dbag_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            LET g_current_page = 1
            IF p_cmd = 'u' THEN
               CALL adbi201_b_fill(g_wc)
            END IF
            LET g_detail_cnt = g_dbag_d.getLength()
            #add-point:資料輸入前

            #end add-point
            
         BEFORE ROW
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_master_t.* = g_dbag_d[l_ac].*
            LET g_master.* = g_dbag_d[l_ac].*
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            LET g_detail_idx = l_ac
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_dbag_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_dbag_d[l_ac].dbag001 IS NOT NULL
               AND g_dbag_d[l_ac].dbag002 IS NOT NULL
               AND g_dbag_d[l_ac].dbag003 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_dbag_d_t.* = g_dbag_d[l_ac].*  #BACKUP
               IF NOT adbi201_lock_b("dbag_1") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH adbi201_bcl INTO g_dbag_d[l_ac].dbag001,g_dbag_d[l_ac].dbag002,g_dbag_d[l_ac].dbag003, 
                      g_dbag_d[l_ac].dbagsite
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = g_dbag_d_t.dbag001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     LET l_lock_sw = "Y"
                  END IF
                  
                  CALL adbi201_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL adbi201_set_entry_b(l_cmd)
            CALL adbi201_set_no_entry_b(l_cmd)
            #add-point:input段before row
            #160825-00048#1 160829 by lori add---(S)
            IF l_cmd = 'u' THEN
               LET g_dbag_d_o.* = g_dbag_d[l_ac].*
            END IF
            #160825-00048#1 160829 by lori add---(E)
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            
            #讀取對應的單身資料
            CALL adbi201_fetch()
            CALL adbi201_idx_chk('m')
        
         BEFORE INSERT
            
            #判斷能否在此頁面進行資料新增
            
            #清空下層單身
            CALL g_dbag2_d.clear()
            CALL g_dbag3_d.clear()
 
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_dbag_d[l_ac].* TO NULL 
            LET g_dbag_d_t.* = g_dbag_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL adbi201_set_entry_b("a")
            CALL adbi201_set_no_entry_b("a")
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_dbag_d[li_reproduce_target].* = g_dbag_d[li_reproduce].*
 
               LET g_dbag_d[g_dbag_d.getLength()].dbag001 = NULL
               LET g_dbag_d[g_dbag_d.getLength()].dbag002 = NULL
               LET g_dbag_d[g_dbag_d.getLength()].dbag003 = NULL
 
            END IF
            #add-point:input段before insert
            INITIALIZE g_dbag_d_o.* TO NULL    #160824-00007#1 Add By Ken 160824
            IF g_argv[1] = '1' THEN
               LET g_dbag_d[l_ac].dbag001 = '1'
            ELSE
               LET g_dbag_d[l_ac].dbag001 = '2'
            END IF
            #代送商倉庫
            IF g_argv[1] = '1' THEN
               LET g_dbag_d[l_ac].dbag003 = ' '
            END IF
            LET g_dbag_d[l_ac].dbagsite = ' '
            LET g_dbag_d_t.* = g_dbag_d[l_ac].*     #新輸入資料
            #end add-point  
  
         AFTER INSERT
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
 
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
            
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM dbag_t 
             WHERE dbagent = g_enterprise AND dbag001 = g_dbag_d[l_ac].dbag001 
                                          AND dbag002 = g_dbag_d[l_ac].dbag002 
                                          AND dbag003 = g_dbag_d[l_ac].dbag003 
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前

               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_dbag_d[g_detail_idx].dbag001
               LET gs_keys[2] = g_dbag_d[g_detail_idx].dbag002
               LET gs_keys[3] = g_dbag_d[g_detail_idx].dbag003
               CALL adbi201_insert_b('dbag_1',gs_keys,"'1'")
                           
               #add-point:單身新增後

               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               INITIALIZE g_dbag_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "dbag_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL adbi201_b_fill(g_wc)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert

               #end add-point
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               LET g_master.* = g_dbag_d[l_ac].*
            END IF
              
         BEFORE DELETE  #是否取消單身
            IF l_cmd = 'a' AND g_dbag_d.getLength() < l_ac THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_dbag_d.deleteElement(l_ac)
               NEXT FIELD dbag001
            END IF
            IF g_dbag_d[l_ac].dbag001 IS NOT NULL
               AND g_dbag_d_t.dbag002 IS NOT NULL
               AND g_dbag_d_t.dbag003 IS NOT NULL
 
               THEN
               
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  -263
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
 
                  CANCEL DELETE
               END IF
               
               #add-point:單身刪除前

               #end add-point
               
               DELETE FROM dbag_t
                WHERE dbagent = g_enterprise
                  AND dbag001 = g_dbag_d_t.dbag001
                  AND dbag002 = g_dbag_d_t.dbag002
                  AND dbag003 = g_dbag_d_t.dbag003
 
                      
               #add-point:單身刪除中

               #end add-point
                      
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "dbag"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
                  #add-point:單身刪除後

                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE adbi201_bcl
               LET l_count = g_dbag_d.getLength()
            END IF 
            
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_dbag_d[g_detail_idx].dbag001
               LET gs_keys[2] = g_dbag_d[g_detail_idx].dbag002
               LET gs_keys[3] = g_dbag_d[g_detail_idx].dbag003
 
              
         AFTER DELETE 
            #add-point:單身刪除後2

            #end add-point
                           CALL adbi201_delete_b('dbag_1',gs_keys,"'1'")
 
         #---------------------<  Detail: page1  >---------------------
         #----<<dbag001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dbag001
            #add-point:BEFORE FIELD dbag001

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbag001
            
            #add-point:AFTER FIELD dbag001
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dbag001
            #add-point:ON CHANGE dbag001

            #END add-point
 
         #----<<dbag002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dbag002
            #add-point:BEFORE FIELD dbag002

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbag002
            
            #add-point:AFTER FIELD dbag002
            LET g_dbag_d[l_ac].dbag002_desc = ' '
            DISPLAY BY NAME g_dbag_d[l_ac].dbag002_desc
            IF NOT cl_null(g_dbag_d[l_ac].dbag002) THEN
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_dbag_d[l_ac].dbag002 != g_dbag_d_t.dbag002 OR g_dbag_d_t.dbag002 IS NULL )) THEN  #160824-00007#1 Mark By Ken 160824
               IF (g_dbag_d[l_ac].dbag002 != g_dbag_d_o.dbag002 OR cl_null(g_dbag_d_o.dbag002)) THEN   #160824-00007#1 Add By Ken 160824
                  CALL adbi201_chk_dbag002()
                     RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     IF NOT cl_null(l_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = l_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                     END IF
                     #LET g_dbag_d[l_ac].dbag002 = g_dbag_d_t.dbag002   #160824-00007#1 Mark By Ken 160824
                     #160824-00007#1 Add By Ken 160824(S)
                     LET g_dbag_d[l_ac].dbag002 = g_dbag_d_o.dbag002
                     LET g_dbag_d[l_ac].dbag003 = g_dbag_d_o.dbag003
                     #160824-00007#1 Add By Ken 160824(E)
                     CALL s_desc_get_trading_partner_abbr_desc(g_dbag_d[l_ac].dbag002)
                        RETURNING g_dbag_d[l_ac].dbag002_desc
                     DISPLAY BY NAME g_dbag_d[l_ac].dbag002_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_trading_partner_abbr_desc(g_dbag_d[l_ac].dbag002)
               RETURNING g_dbag_d[l_ac].dbag002_desc
            DISPLAY BY NAME g_dbag_d[l_ac].dbag002_desc
            LET g_dbag_d_o.* = g_dbag_d[l_ac].*  #160824-00007#1 Add By Ken 160824
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dbag002
            #add-point:ON CHANGE dbag002

            #END add-point
 
         #----<<dbag003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dbag003
            #add-point:BEFORE FIELD dbag003

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbag003
            
            #add-point:AFTER FIELD dbag003
            LET g_dbag_d[l_ac].dbag003_desc = ' '
            DISPLAY BY NAME g_dbag_d[l_ac].dbag003_desc
            IF NOT cl_null(g_dbag_d[l_ac].dbag003) THEN
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_dbag_d[l_ac].dbag003 != g_dbag_d_t.dbag003 OR g_dbag_d_t.dbag003 IS NULL )) THEN   #160824-00007#1 Mark By Ken 160824
               IF (g_dbag_d[l_ac].dbag003 != g_dbag_d_o.dbag003 OR cl_null(g_dbag_d_t.dbag003)) THEN   #160824-00007#1 Add By Ken 160824
                  #檢查單頭值是否重複輸入
                  CALL adbi201_chk_head_key(g_dbag_d[l_ac].dbag001,g_dbag_d[l_ac].dbag002,g_dbag_d[l_ac].dbag003)
                     RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = l_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_dbag_d[l_ac].dbag003 = g_dbag_d_t.dbag003  #160824-00007#1 Mark By Ken 160824
                     LET g_dbag_d[l_ac].dbag003 = g_dbag_d_o.dbag003   #160824-00007#1 Add By Ken 160824
                     CALL s_desc_get_trading_partner_abbr_desc(g_dbag_d[l_ac].dbag003)
                        RETURNING g_dbag_d[l_ac].dbag003_desc
                     DISPLAY BY NAME g_dbag_d[l_ac].dbag003_desc
                     NEXT FIELD CURRENT
                  END IF
                  IF g_dbag_d[l_ac].dbag002 = g_dbag_d[l_ac].dbag003 THEN
                  
                  ELSE
                     #檢查輸入值是否正確
                     #lori522612  150121  add ----------------------(S)
                     #INITIALIZE g_chkparam.* TO NULL
                     #LET g_chkparam.arg1 = g_dbag_d[l_ac].dbag002
                     #LET g_chkparam.arg2 = g_dbag_d[l_ac].dbag003
                     #LET g_chkparam.arg3 = 'ALL'
                     #IF NOT cl_chk_exist("v_pmac002_2") THEN
                     #調整校驗方式
                     IF NOT s_adb_chk_pmac002(1,g_dbag_d[l_ac].dbag002,g_dbag_d[l_ac].dbag003,'2') THEN
                     #lori522612  150121  add ----------------------(E)
                        #LET g_dbag_d[l_ac].dbag003 = g_dbag_d_t.dbag003  #160824-00007#1 Mark By Ken 160824
                        LET g_dbag_d[l_ac].dbag003 = g_dbag_d_o.dbag003   #160824-00007#1 Add By Ken 160824                        
                        CALL s_desc_get_trading_partner_abbr_desc(g_dbag_d[l_ac].dbag003)
                           RETURNING g_dbag_d[l_ac].dbag003_desc
                        DISPLAY BY NAME g_dbag_d[l_ac].dbag003_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            CALL s_desc_get_trading_partner_abbr_desc(g_dbag_d[l_ac].dbag003)
               RETURNING g_dbag_d[l_ac].dbag003_desc
            DISPLAY BY NAME g_dbag_d[l_ac].dbag003_desc
            LET g_dbag_d_o.* = g_dbag_d[l_ac].*  #160824-00007#1 Add By Ken 160824
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dbag003
            #add-point:ON CHANGE dbag003

            #END add-point
 
         #----<<dbagsite>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dbagsite
            #add-point:BEFORE FIELD dbagsite

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbagsite
            
            #add-point:AFTER FIELD dbagsite
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dbagsite
            #add-point:ON CHANGE dbagsite

            #END add-point
 
 
         #---------------------<  Detail: page1  >---------------------
         #----<<dbag001>>----
         #Ctrlp:input.c.page1.dbag001
         ON ACTION controlp INFIELD dbag001
            #add-point:ON ACTION controlp INFIELD dbag001

            #END add-point
 
         #----<<dbag002>>----
         #Ctrlp:input.c.page1.dbag002
         ON ACTION controlp INFIELD dbag002
            #add-point:ON ACTION controlp INFIELD dbag002
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_dbag_d[l_ac].dbag002             #給予default值

            #代送商倉庫
            IF g_argv[1] = '1' THEN
               CALL q_pmaa001_10()                      #呼叫開窗
            ELSE
               LET g_qryparam.arg1 = 'ALL'
               #寄銷倉庫
               CALL q_pmaa001_6()                       #呼叫開窗
            END IF
            LET g_dbag_d[l_ac].dbag002 = g_qryparam.return1
            DISPLAY g_dbag_d[l_ac].dbag002 TO dbag002
            CALL s_desc_get_trading_partner_abbr_desc(g_dbag_d[l_ac].dbag002)
               RETURNING g_dbag_d[l_ac].dbag002_desc
            DISPLAY BY NAME g_dbag_d[l_ac].dbag002_desc
            NEXT FIELD dbag002                          #返回原欄位
            #END add-point
 
         #----<<dbag003>>----
         #Ctrlp:input.c.page1.dbag003
         ON ACTION controlp INFIELD dbag003
            #add-point:ON ACTION controlp INFIELD dbag003
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_dbag_d[l_ac].dbag003             #給予default值
            
            #給予arg
            LET g_qryparam.arg1 = g_dbag_d[l_ac].dbag002 
            LET g_qryparam.arg2 = 'ALL'
            CALL q_pmac002_6()                             #呼叫開窗
            LET g_dbag_d[l_ac].dbag003 = g_qryparam.return1
            DISPLAY g_dbag_d[l_ac].dbag003 TO dbag003
            CALL s_desc_get_trading_partner_abbr_desc(g_dbag_d[l_ac].dbag003)
               RETURNING g_dbag_d[l_ac].dbag003_desc
            DISPLAY BY NAME g_dbag_d[l_ac].dbag003_desc
            NEXT FIELD dbag003                          #返回原欄位
            #END add-point
 
         #----<<dbagsite>>----
         #Ctrlp:input.c.page1.dbagsite
         ON ACTION controlp INFIELD dbagsite1
            #add-point:ON ACTION controlp INFIELD dbagsite

            #END add-point
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
 
               LET INT_FLAG = 0
               LET g_dbag_d[l_ac].* = g_dbag_d_t.*
               CLOSE adbi201_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_dbag_d[l_ac].dbag001
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               LET g_dbag_d[l_ac].* = g_dbag_d_t.*
            ELSE
               
               #寫入修改者/修改日期資訊(單身)
               
               
               #add-point:單身修改前

               #end add-point
               
               #UPDATE dbag_t SET (dbag001,dbag002,dbag003,dbagsite) = (g_dbag_d[l_ac].dbag001,g_dbag_d[l_ac].dbag002, 
               #    g_dbag_d[l_ac].dbag003,g_dbag_d[l_ac].dbagsite)
               UPDATE dbag_t SET (dbag001,dbag002,dbag003) = (g_dbag_d[l_ac].dbag001,g_dbag_d[l_ac].dbag002, 
                   g_dbag_d[l_ac].dbag003)
                WHERE dbagent = g_enterprise
                  AND dbag001 = g_dbag_d_t.dbag001 #項次   
                  AND dbag002 = g_dbag_d_t.dbag002  
                  AND dbag003 = g_dbag_d_t.dbag003  
 
                  
               #add-point:單身修改中

               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "dbag_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                     LET g_dbag_d[l_ac].* = g_dbag_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "dbag_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
                     CALL s_transaction_end('N','0')
                     LET g_dbag_d[l_ac].* = g_dbag_d_t.*
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_dbag_d[g_detail_idx].dbag001
               LET gs_keys_bak[1] = g_dbag_d_t.dbag001
               LET gs_keys[2] = g_dbag_d[g_detail_idx].dbag002
               LET gs_keys_bak[2] = g_dbag_d_t.dbag002
               LET gs_keys[3] = g_dbag_d[g_detail_idx].dbag003
               LET gs_keys_bak[3] = g_dbag_d_t.dbag003
               CALL adbi201_update_b('dbag_1',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
               END CASE
               
               #若Key欄位有變動
               LET g_master.* = g_dbag_d[l_ac].*
               CALL adbi201_key_update_b()
               
               #add-point:單身修改後

               #end add-point
 
            END IF
            
         AFTER ROW
            CALL adbi201_unlock_b("dbag_1")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            
              
         AFTER INPUT
            #add-point:input段after input 

            #end add-point   
              
         ON ACTION controlo   
            CALL FGL_SET_ARR_CURR(g_dbag_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_dbag_d.getLength()+1
              
      END INPUT
      
 
      
      #實際單身段落
      INPUT ARRAY g_dbag2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_dbag2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            LET g_detail_cnt = g_dbag2_d.getLength()
            LET g_current_page = 2
            #add-point:資料輸入前
            IF cl_null(g_dbag_d[l_ac].dbag002) THEN
               LET p_cmd = 'u'
               INITIALIZE g_errparam TO NULL
               IF g_argv[1] = '1' THEN
                  #尚未選擇代送商編號！
                  LET g_errparam.code = 'adb-00287'
               ELSE
                  #尚未選擇客戶編號+送貨客戶編號！
                  LET g_errparam.code = 'adb-00286'
               END IF
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CALL g_dbag_d.deleteElement(l_ac)
               IF g_detail_idx >= 1 THEN
                  LET g_detail_idx = g_detail_idx - 1
               END IF
               NEXT FIELD dbag002
            END IF
            #end add-point
 
         BEFORE INSERT
            IF g_dbag_d.getLength() = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'std-00013'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               NEXT FIELD dbag001
            END IF 
            #判斷能否在此頁面進行資料新增
            
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_dbag2_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            #此段落由子樣板a14產生    
            LET g_dbag3_d[l_ac].dbagownid = g_user
            LET g_dbag3_d[l_ac].dbagowndp = g_dept
            LET g_dbag3_d[l_ac].dbagcrtid = g_user
            LET g_dbag3_d[l_ac].dbagcrtdp = g_dept
            LET g_dbag3_d[l_ac].dbagcrtdt = cl_get_current()
            LET g_dbag3_d[l_ac].dbagmodid = ""
            LET g_dbag3_d[l_ac].dbagmoddt = ""
            LET g_dbag2_d[l_ac].dbagstus = ""
            LET g_dbag2_d[l_ac].dbagstus = "Y"
 
 
            LET g_dbag2_d_t.* = g_dbag2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL adbi201_set_entry_b("a")
            CALL adbi201_set_no_entry_b("a")
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_dbag2_d[li_reproduce_target].* = g_dbag2_d[li_reproduce].*
               LET g_dbag3_d[li_reproduce_target].* = g_dbag3_d[li_reproduce].*
 
               LET g_dbag2_d[li_reproduce_target].dbagsite = NULL
            END IF
            #add-point:input段before insert
            LET l_cnt = 0
            CALL s_aooi500_default(g_prog,'dbagsite',g_dbag2_d[l_ac].dbagsite)
               RETURNING l_insert,g_dbag2_d[l_ac].dbagsite
            IF l_insert = FALSE THEN
               #因[作業組織應用設定維護作業aooi500]設定可輸入的值，已存在！
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'adb-00321'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
               CANCEL INSERT
            END IF
            SELECT COUNT(dbagsite) INTO l_cnt
              FROM dbag_t
             WHERE dbagent = g_enterprise
               AND dbag001 = g_master.dbag001
               AND dbag002 = g_master.dbag002
               AND dbag003 = g_master.dbag003
               AND dbagsite = g_dbag2_d[l_ac].dbagsite
            IF l_cnt = 0 THEN
               CALL s_desc_get_department_desc(g_dbag2_d[l_ac].dbagsite)
                  RETURNING g_dbag2_d[l_ac].dbagsite_desc
            ELSE
               LET g_dbag2_d[l_ac].dbagsite = ''
               CALL s_aooi500_comp_entry(g_prog,'dbagsite')
                  RETURNING l_success
               IF l_success = FALSE THEN
                  #因[作業組織應用設定維護作業aooi500]設定可輸入的值，已存在！
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'adb-00321'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  CANCEL INSERT
               END IF
            END IF
            #end add-point  
            
         BEFORE ROW 
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx2 = l_ac
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            CALL s_transaction_begin()
            LET g_detail_cnt = g_dbag2_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_dbag2_d[l_ac].dbagsite IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_dbag2_d_t.* = g_dbag2_d[l_ac].*  #BACKUP
               IF NOT adbi201_lock_b("dbag_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH adbi201_bcl2 INTO g_dbag2_d[l_ac].dbagstus,g_dbag2_d[l_ac].dbagsite,g_dbag2_d[l_ac].dbagsite_desc, 
                      g_dbag2_d[l_ac].dbag004,g_dbag2_d[l_ac].dbag004_desc,g_dbag2_d[l_ac].dbag005,g_dbag2_d[l_ac].dbag005_desc, 
                      g_dbag2_d[l_ac].dbag006,g_dbag2_d[l_ac].dbag006_desc,g_dbag2_d[l_ac].dbag007,g_dbag2_d[l_ac].dbag007_desc, 
                      g_dbag3_d[l_ac].dbagsite,g_dbag3_d[l_ac].dbagownid, 
                      g_dbag3_d[l_ac].dbagownid_desc,g_dbag3_d[l_ac].dbagowndp,g_dbag3_d[l_ac].dbagowndp_desc, 
                      g_dbag3_d[l_ac].dbagcrtid,g_dbag3_d[l_ac].dbagcrtid_desc,g_dbag3_d[l_ac].dbagcrtdp, 
                      g_dbag3_d[l_ac].dbagcrtdp_desc,g_dbag3_d[l_ac].dbagcrtdt,g_dbag3_d[l_ac].dbagmodid, 
                      g_dbag3_d[l_ac].dbagmodid_desc,g_dbag3_d[l_ac].dbagmoddt
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     LET l_lock_sw = "Y"
                  END IF
                  CALL cl_show_fld_cont()
                  CALL adbi201_detail_show()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL adbi201_set_entry_b(l_cmd)
            CALL adbi201_set_no_entry_b(l_cmd)
            #add-point:input段before row
            IF cl_null(g_dbag2_d[l_ac].dbagsite) THEN
               LET g_dbag3_d[l_ac].dbagownid = g_user
               LET g_dbag3_d[l_ac].dbagowndp = g_dept
               LET g_dbag3_d[l_ac].dbagcrtid = g_user
               LET g_dbag3_d[l_ac].dbagcrtdp = g_dept
               LET g_dbag3_d[l_ac].dbagcrtdt = cl_get_current()
            END IF
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            
            CALL adbi201_idx_chk('d')
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' AND g_dbag2_d.getLength() < l_ac THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_dbag2_d.deleteElement(l_ac)
               NEXT FIELD dbagsite
            END IF
            IF NOT cl_null(g_dbag2_d_t.dbagsite) THEN
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  -263
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
 
                  CANCEL DELETE
               END IF
               
               #add-point:單身2刪除前
               LET l_cnt = 0
               SELECT COUNT(dbagsite) INTO l_cnt
                 FROM dbag_t
                WHERE dbagent = g_enterprise
                  AND dbag001 = g_master.dbag001
                  AND dbag002 = g_master.dbag002
                  AND dbag003 = g_master.dbag003
               IF l_cnt = 1 THEN
                  UPDATE dbag_t SET(dbagstus,dbagsite,dbag004,dbag005,
                                 dbag006,dbag007,dbagownid,dbagowndp, 
                                 dbagcrtid,dbagcrtdp,dbagcrtdt,
                                 dbagmodid,dbagmoddt) = 
                                ('Y',' ', '','',
                                 '','','','',
                                 '','', '',
                                 '','')
                   WHERE dbagent = g_enterprise
                      AND dbag001 = g_master.dbag001
                      AND dbag002 = g_master.dbag002
                      AND dbag003 = g_master.dbag003
                      AND dbagsite = g_dbag2_d_t.dbagsite
               ELSE
                  DELETE FROM dbag_t
                   WHERE dbagent = g_enterprise
                     AND dbag001 = g_master.dbag001
                     AND dbag002 = g_master.dbag002
                     AND dbag003 = g_master.dbag003
                     AND dbagsite = g_dbag2_d_t.dbagsite
               END IF
               #end add-point  
               
               #DELETE FROM dbag_t
               # WHERE dbagent = g_enterprise AND
               #    dbag001 = g_master.dbag001
               #    AND dbag002 = g_master.dbag002
               #    AND dbag003 = g_master.dbag003
               #    AND dbagsite = g_dbag2_d_t.dbagsite
               #    
               #add-point:單身2刪除中
 
               #end add-point  
                   
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "dbag_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
                  #add-point:單身2刪除後

                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE adbi201_bcl
               LET l_count = g_dbag_d.getLength()
            END IF
 
            
         AFTER DELETE 
            #add-point:單身AFTER DELETE 
            
            #end add-point
            #CALL adbi201_delete_b('dbag_t',gs_keys,"'2'")
 
         AFTER INSERT    
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
 
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM dbag_t 
             WHERE dbagent = g_enterprise AND
                   dbag001 = g_master.dbag001
                   AND dbag002 = g_master.dbag002
                   AND dbag003 = g_master.dbag003
                   AND dbagsite = g_dbag2_d[g_detail_idx2].dbagsite
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前
               LET l_cnt = 0
               SELECT COUNT(dbagsite) INTO l_cnt
                 FROM dbag_t
                WHERE dbagent = g_enterprise
                  AND dbag001 = g_master.dbag001
                  AND dbag002 = g_master.dbag002
                  AND dbag003 = g_master.dbag003
                  AND dbagsite = ' '
               #發貨組織沒有等於空白的　新增動作
               IF l_cnt = 0 THEN
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_dbag_d[g_detail_idx].dbag001
               LET gs_keys[2] = g_dbag_d[g_detail_idx].dbag002
               LET gs_keys[3] = g_dbag_d[g_detail_idx].dbag003
               LET gs_keys[4] = g_dbag2_d[g_detail_idx2].dbagsite
               CALL adbi201_insert_b('dbag_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2
               ELSE
                  LET g_dbag3_d[l_ac].dbagownid = g_user
                  LET g_dbag3_d[l_ac].dbagowndp = g_dept
                  LET g_dbag3_d[l_ac].dbagcrtid = g_user
                  LET g_dbag3_d[l_ac].dbagcrtdp = g_dept
                  LET g_dbag3_d[l_ac].dbagcrtdt = cl_get_current()
                  LET g_dbag3_d[l_ac].dbagmodid = ""
                  LET g_dbag3_d[l_ac].dbagmoddt = ""
               
                  UPDATE dbag_t SET (dbagstus,dbagsite,dbag004,dbag005,dbag006,dbag007,
                                     dbagownid,dbagowndp,dbagcrtid,dbagcrtdp,dbagcrtdt,
                                     dbagmodid,dbagmoddt) = 
                                    (g_dbag2_d[l_ac].dbagstus,g_dbag2_d[l_ac].dbagsite,
                                     g_dbag2_d[l_ac].dbag004,g_dbag2_d[l_ac].dbag005,
                                     g_dbag2_d[l_ac].dbag006,g_dbag2_d[l_ac].dbag007,
                                     g_dbag3_d[l_ac].dbagownid,g_dbag3_d[l_ac].dbagowndp,
                                     g_dbag3_d[l_ac].dbagcrtid,g_dbag3_d[l_ac].dbagcrtdp,
                                     g_dbag3_d[l_ac].dbagcrtdt,g_dbag3_d[l_ac].dbagmodid,
                                     g_dbag3_d[l_ac].dbagmoddt) 
                   WHERE dbagent = g_enterprise AND
                      dbag001 = g_master.dbag001
                      AND dbag002 = g_master.dbag002
                      AND dbag003 = g_master.dbag003
                      AND dbagsite = ' '
                  
                  CASE
                     WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = "std-00009"
                        LET g_errparam.extend = "dbag_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        CALL s_transaction_end('N','0')
                        LET g_dbag2_d[l_ac].* = g_dbag2_d_t.*
                     WHEN SQLCA.sqlcode #其他錯誤
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "dbag_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        CALL s_transaction_end('N','0')
                        LET g_dbag2_d[l_ac].* = g_dbag2_d_t.*
                     OTHERWISE
                        INITIALIZE gs_keys TO NULL
                        LET gs_keys[1] = g_dbag_d[g_detail_idx].dbag001
                        LET gs_keys_bak[1] = g_dbag_d[g_detail_idx].dbag001
                        LET gs_keys[2] = g_dbag_d[g_detail_idx].dbag002
                        LET gs_keys_bak[2] = g_dbag_d[g_detail_idx].dbag002
                        LET gs_keys[3] = g_dbag_d[g_detail_idx].dbag003
                        LET gs_keys_bak[3] = g_dbag_d[g_detail_idx].dbag003
                        LET gs_keys[4] = g_dbag2_d[g_detail_idx2].dbagsite
                        LET gs_keys_bak[4] = ' '
                        CALL adbi201_update_b('dbag_t',gs_keys,gs_keys_bak,"'2'")
                  END CASE
               END IF
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               INITIALIZE g_dbag_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "dbag_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL adbi201_b_fill(g_wc)
               #資料多語言用-增/改
               
               #add-point:單身新增後

               #end add-point
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
 
               LET INT_FLAG = 0
               LET g_dbag2_d[l_ac].* = g_dbag2_d_t.*
               CLOSE adbi201_bcl2
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               LET g_dbag2_d[l_ac].* = g_dbag2_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身2)
               LET g_dbag3_d[l_ac].dbagmodid = g_user 
               LET g_dbag3_d[l_ac].dbagmoddt = cl_get_current()
 
               
               #add-point:單身page2修改前
               IF g_dbag2_d_t.dbagsite = ' ' THEN
                  LET g_dbag3_d[l_ac].dbagownid = g_user
                  LET g_dbag3_d[l_ac].dbagowndp = g_dept
                  LET g_dbag3_d[l_ac].dbagcrtid = g_user
                  LET g_dbag3_d[l_ac].dbagcrtdp = g_dept
                  LET g_dbag3_d[l_ac].dbagcrtdt = cl_get_current()
                  LET g_dbag3_d[l_ac].dbagmodid = ""
                  LET g_dbag3_d[l_ac].dbagmoddt = ""
               END IF
               #end add-point
               
               UPDATE dbag_t SET (dbagstus,dbagsite,dbag004,dbag005,dbag006,dbag007,dbagownid,dbagowndp, 
                   dbagcrtid,dbagcrtdp,dbagcrtdt,dbagmodid,dbagmoddt) = (g_dbag2_d[l_ac].dbagstus,g_dbag2_d[l_ac].dbagsite, 
                   g_dbag2_d[l_ac].dbag004,g_dbag2_d[l_ac].dbag005,g_dbag2_d[l_ac].dbag006,g_dbag2_d[l_ac].dbag007, 
                   g_dbag3_d[l_ac].dbagownid,g_dbag3_d[l_ac].dbagowndp,g_dbag3_d[l_ac].dbagcrtid,g_dbag3_d[l_ac].dbagcrtdp, 
                   g_dbag3_d[l_ac].dbagcrtdt,g_dbag3_d[l_ac].dbagmodid,g_dbag3_d[l_ac].dbagmoddt) #自訂欄位頁簽 
 
                WHERE dbagent = g_enterprise AND
                   dbag001 = g_master.dbag001
                   AND dbag002 = g_master.dbag002
                   AND dbag003 = g_master.dbag003
                   AND dbagsite = g_dbag2_d_t.dbagsite
                   
               #add-point:單身修改中

               #end add-point
                   
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "dbag_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                     LET g_dbag2_d[l_ac].* = g_dbag2_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "dbag_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
                     CALL s_transaction_end('N','0')
                     LET g_dbag2_d[l_ac].* = g_dbag2_d_t.*
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_dbag_d[g_detail_idx].dbag001
               LET gs_keys_bak[1] = g_dbag_d[g_detail_idx].dbag001
               LET gs_keys[2] = g_dbag_d[g_detail_idx].dbag002
               LET gs_keys_bak[2] = g_dbag_d[g_detail_idx].dbag002
               LET gs_keys[3] = g_dbag_d[g_detail_idx].dbag003
               LET gs_keys_bak[3] = g_dbag_d[g_detail_idx].dbag003
               LET gs_keys[4] = g_dbag2_d[g_detail_idx2].dbagsite
               LET gs_keys_bak[4] = g_dbag2_d_t.dbagsite
               CALL adbi201_update_b('dbag_t',gs_keys,gs_keys_bak,"'2'")
                     #資料多語言用-增/改
                     
               END CASE
               #add-point:單身page2修改後

               #end add-point
            END IF
         
         #---------------------<  Detail: page2  >---------------------
         #----<<dbagstus>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dbagstus
            #add-point:BEFORE FIELD dbagstus

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbagstus
            
            #add-point:AFTER FIELD dbagstus

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dbagstus
            #add-point:ON CHANGE dbagstus

            #END add-point
 
         #----<<dbagsite>>----
         #此段落由子樣板a02產生
         AFTER FIELD dbagsite
            
            #add-point:AFTER FIELD dbagsite
            LET g_dbag2_d[l_ac].dbagsite_desc = ''
            DISPLAY BY NAME g_dbag2_d[l_ac].dbagsite_desc
            IF NOT cl_null(g_dbag2_d[l_ac].dbagsite) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_dbag2_d[l_ac].dbagsite != g_dbag2_d_t.dbagsite OR g_dbag2_d_t.dbagsite IS NULL )) THEN
                  CALL adbi201_chk_key(g_dbag2_d[l_ac].dbagsite,g_master.dbag001,g_master.dbag002,g_master.dbag003)
                     RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = l_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_dbag2_d[l_ac].dbagsite = g_dbag2_d_t.dbagsite
                     CALL s_desc_get_department_desc(g_dbag2_d[l_ac].dbagsite)
                        RETURNING g_dbag2_d[l_ac].dbagsite_desc
                     DISPLAY BY NAME g_dbag2_d[l_ac].dbagsite_desc
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_aooi500_chk(g_prog,'dbagsite',g_dbag2_d[l_ac].dbagsite,g_dbag2_d[l_ac].dbagsite)
                     RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     LET g_dbag2_d[l_ac].dbagsite = g_dbag2_d_t.dbagsite
                     CALL s_desc_get_department_desc(g_dbag2_d[l_ac].dbagsite)
                        RETURNING g_dbag2_d[l_ac].dbagsite_desc
                     DISPLAY BY NAME g_dbag2_d[l_ac].dbagsite_desc
                     NEXT FIELD CURRENT
                  END IF
                  #INITIALIZE g_chkparam.* TO NULL
                  #LET g_chkparam.arg1 = g_dbag2_d[l_ac].dbagsite
                  #LET g_chkparam.arg2 = '2'
                  #LET g_chkparam.arg3 = g_site
                  #IF NOT cl_chk_exist("v_ooed004") THEN
                  #   LET g_dbag2_d[l_ac].dbagsite = g_dbag2_d_t.dbagsite
                  #   CALL s_desc_get_department_desc(g_dbag2_d[l_ac].dbagsite)
                  #      RETURNING g_dbag2_d[l_ac].dbagsite_desc
                  #   DISPLAY BY NAME g_dbag2_d[l_ac].dbagsite_desc
                  #   NEXT FIELD CURRENT
                  #END IF
               END IF
            END IF
            CALL s_desc_get_department_desc(g_dbag2_d[l_ac].dbagsite)
               RETURNING g_dbag2_d[l_ac].dbagsite_desc
            DISPLAY BY NAME g_dbag2_d[l_ac].dbagsite_desc
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD dbagsite
            #add-point:BEFORE FIELD dbagsite

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE dbagsite
            #add-point:ON CHANGE dbagsite

            #END add-point
 
         #----<<dbagsite_desc>>----
         #----<<dbag004>>----
         #此段落由子樣板a02產生
         AFTER FIELD dbag004
            
            #add-point:AFTER FIELD dbag004
            LET g_dbag2_d[l_ac].dbag004_desc = ' '
            DISPLAY BY NAME g_dbag2_d[l_ac].dbag004_desc
            IF NOT cl_null(g_dbag2_d[l_ac].dbag004) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_dbag2_d[l_ac].dbag004 != g_dbag2_d_o.dbag004 OR g_dbag2_d_o.dbag004 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_dbag2_d[l_ac].dbagsite
                  LET g_chkparam.arg2 = g_dbag2_d[l_ac].dbag004
                  #160318-00025#18  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
                  #160318-00025#18  by 07900 --add-end
                  IF NOT cl_chk_exist("v_inaa001_14") THEN
                     LET g_dbag2_d[l_ac].dbag004 = g_dbag2_d_o.dbag004
                     CALL s_desc_get_stock_desc(g_dbag2_d[l_ac].dbagsite,g_dbag2_d[l_ac].dbag004)
                        RETURNING g_dbag2_d[l_ac].dbag004_desc
                     DISPLAY BY NAME g_dbag2_d[l_ac].dbag004_desc
                     NEXT FIELD CURRENT
                  END IF
                  LET g_dbag2_d[l_ac].dbag005 = ''
                  LET g_dbag2_d[l_ac].dbag005_desc = ''
                  DISPLAY BY NAME g_dbag2_d[l_ac].dbag005,g_dbag2_d[l_ac].dbag005_desc
               END IF
            END IF
            LET g_dbag2_d_o.dbag004 = g_dbag2_d[l_ac].dbag004
            LET g_dbag2_d_o.dbag005 = g_dbag2_d[l_ac].dbag005
            CALL s_desc_get_stock_desc(g_dbag2_d[l_ac].dbagsite,g_dbag2_d[l_ac].dbag004)
               RETURNING g_dbag2_d[l_ac].dbag004_desc
            DISPLAY BY NAME g_dbag2_d[l_ac].dbag004_desc
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD dbag004
            #add-point:BEFORE FIELD dbag004

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE dbag004
            #add-point:ON CHANGE dbag004

            #END add-point
 
         #----<<dbag004_desc>>----
         #----<<dbag005>>----
         #此段落由子樣板a02產生
         AFTER FIELD dbag005
            
            #add-point:AFTER FIELD dbag005
            LET g_dbag2_d[l_ac].dbag005_desc = ' '
            DISPLAY BY NAME g_dbag2_d[l_ac].dbag005_desc
            IF NOT cl_null(g_dbag2_d[l_ac].dbag005) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_dbag2_d[l_ac].dbag005 != g_dbag2_d_o.dbag005 OR g_dbag2_d_o.dbag005 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_dbag2_d[l_ac].dbagsite
                  LET g_chkparam.arg2 = g_dbag2_d[l_ac].dbag004
                  LET g_chkparam.arg3 = g_dbag2_d[l_ac].dbag005
                  #160318-00025#18  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
                  #160318-00025#18  by 07900 --add-end
                  IF NOT cl_chk_exist("v_inab002") THEN
                     LET g_dbag2_d[l_ac].dbag005 = g_dbag2_d_o.dbag005
                     CALL s_desc_get_locator_desc(g_dbag2_d[l_ac].dbagsite,g_dbag2_d[l_ac].dbag004,g_dbag2_d[l_ac].dbag005)
                        RETURNING g_dbag2_d[l_ac].dbag005_desc
                     DISPLAY BY NAME g_dbag2_d[l_ac].dbag005_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_dbag2_d_o.dbag005 = g_dbag2_d[l_ac].dbag005
            CALL s_desc_get_locator_desc(g_dbag2_d[l_ac].dbagsite,g_dbag2_d[l_ac].dbag004,g_dbag2_d[l_ac].dbag005)
               RETURNING g_dbag2_d[l_ac].dbag005_desc
            DISPLAY BY NAME g_dbag2_d[l_ac].dbag005_desc
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD dbag005
            #add-point:BEFORE FIELD dbag005

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE dbag005
            #add-point:ON CHANGE dbag005

            #END add-point
 
         #----<<dbag005_desc>>----
         #----<<dbag006>>----
         #此段落由子樣板a02產生
         AFTER FIELD dbag006
            
            #add-point:AFTER FIELD dbag006
            LET g_dbag2_d[l_ac].dbag006_desc = ' '
            DISPLAY BY NAME g_dbag2_d[l_ac].dbag006_desc
            IF NOT cl_null(g_dbag2_d[l_ac].dbag006) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_dbag2_d[l_ac].dbag006 != g_dbag2_d_o.dbag006 OR g_dbag2_d_o.dbag006 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_dbag2_d[l_ac].dbagsite
                  LET g_chkparam.arg2 = g_dbag2_d[l_ac].dbag006
                  #160318-00025#18  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
                  #160318-00025#18  by 07900 --add-end
                  IF NOT cl_chk_exist("v_inaa001_15") THEN
                     LET g_dbag2_d[l_ac].dbag006 = g_dbag2_d_o.dbag006
                     CALL s_desc_get_stock_desc(g_dbag2_d[l_ac].dbagsite,g_dbag2_d[l_ac].dbag006)
                        RETURNING g_dbag2_d[l_ac].dbag006_desc
                     DISPLAY BY NAME g_dbag2_d[l_ac].dbag006_desc
                     NEXT FIELD CURRENT
                  END IF
                  LET g_dbag2_d[l_ac].dbag007 = ''
                  LET g_dbag2_d[l_ac].dbag007_desc = ''
                  DISPLAY BY NAME g_dbag2_d[l_ac].dbag007,g_dbag2_d[l_ac].dbag007_desc
               END IF
            END IF
            LET g_dbag2_d_o.dbag006 = g_dbag2_d[l_ac].dbag006
            LET g_dbag2_d_o.dbag007 = g_dbag2_d[l_ac].dbag007
            CALL s_desc_get_stock_desc(g_dbag2_d[l_ac].dbagsite,g_dbag2_d[l_ac].dbag006)
               RETURNING g_dbag2_d[l_ac].dbag006_desc
            DISPLAY BY NAME g_dbag2_d[l_ac].dbag006_desc
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD dbag006
            #add-point:BEFORE FIELD dbag006

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE dbag006
            #add-point:ON CHANGE dbag006

            #END add-point
 
         #----<<dbag006_desc>>----
         #----<<dbag007>>----
         #此段落由子樣板a02產生
         AFTER FIELD dbag007
            
            #add-point:AFTER FIELD dbag007
            LET g_dbag2_d[l_ac].dbag007_desc = ' '
            DISPLAY BY NAME g_dbag2_d[l_ac].dbag007_desc
            IF NOT cl_null(g_dbag2_d[l_ac].dbag007) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_dbag2_d[l_ac].dbag007 != g_dbag2_d_o.dbag007 OR g_dbag2_d_o.dbag007 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_dbag2_d[l_ac].dbagsite
                  LET g_chkparam.arg2 = g_dbag2_d[l_ac].dbag006
                  LET g_chkparam.arg3 = g_dbag2_d[l_ac].dbag007
                  #160318-00025#18  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
                  #160318-00025#18  by 07900 --add-end
                  IF NOT cl_chk_exist("v_inab002") THEN
                     LET g_dbag2_d[l_ac].dbag007 = g_dbag2_d_o.dbag007
                     CALL s_desc_get_locator_desc(g_dbag2_d[l_ac].dbagsite,g_dbag2_d[l_ac].dbag006,g_dbag2_d[l_ac].dbag007)
                        RETURNING g_dbag2_d[l_ac].dbag007_desc
                     DISPLAY BY NAME g_dbag2_d[l_ac].dbag007_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_dbag2_d_o.dbag007 = g_dbag2_d[l_ac].dbag007
            CALL s_desc_get_locator_desc(g_dbag2_d[l_ac].dbagsite,g_dbag2_d[l_ac].dbag006,g_dbag2_d[l_ac].dbag007)
               RETURNING g_dbag2_d[l_ac].dbag007_desc
            DISPLAY BY NAME g_dbag2_d[l_ac].dbag007_desc
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD dbag007
            #add-point:BEFORE FIELD dbag007

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE dbag007
            #add-point:ON CHANGE dbag007

            #END add-point
 
         #----<<dbag007_desc>>----
 
         #---------------------<  Detail: page2  >---------------------
         #----<<dbagstus>>----
         #Ctrlp:input.c.page2.dbagstus
         ON ACTION controlp INFIELD dbagstus
            #add-point:ON ACTION controlp INFIELD dbagstus

            #END add-point
 
         #----<<dbagsite>>----
         #Ctrlp:input.c.page2.dbagsite
         ON ACTION controlp INFIELD dbagsite
            #add-point:ON ACTION controlp INFIELD dbagsite
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_dbag2_d[l_ac].dbagsite             #給予default值
            #給予arg
            CALL s_aooi500_q_where(g_prog,'dbagsite','','i') RETURNING l_where #150308-00001#1  By Ken add 'i' 150309
            LET g_qryparam.where = l_where
            CALL q_ooef001_24()
            LET g_dbag2_d[l_ac].dbagsite = g_qryparam.return1    
            DISPLAY g_dbag2_d[l_ac].dbagsite TO dbagsite 
            CALL s_desc_get_department_desc(g_dbag2_d[l_ac].dbagsite)
               RETURNING g_dbag2_d[l_ac].dbagsite_desc
            DISPLAY BY NAME g_dbag2_d[l_ac].dbagsite_desc
            NEXT FIELD dbagsite                          #返回原欄位
            #END add-point
 
         #----<<dbagsite_desc>>----
         #----<<dbag004>>----
         #Ctrlp:input.c.page2.dbag004
         ON ACTION controlp INFIELD dbag004
            #add-point:ON ACTION controlp INFIELD dbag004
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_dbag2_d[l_ac].dbag004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_dbag2_d[l_ac].dbagsite
            CALL q_inaa001_18()   
            LET g_dbag2_d[l_ac].dbag004 = g_qryparam.return1  
            DISPLAY g_dbag2_d[l_ac].dbag004 TO dbag004              #
            CALL s_desc_get_stock_desc(g_dbag2_d[l_ac].dbagsite,g_dbag2_d[l_ac].dbag004)
               RETURNING g_dbag2_d[l_ac].dbag004_desc
            DISPLAY BY NAME g_dbag2_d[l_ac].dbag004_desc
            NEXT FIELD dbag004                          #返回原欄位
            #END add-point
 
         #----<<dbag004_desc>>----
         #----<<dbag005>>----
         #Ctrlp:input.c.page2.dbag005
         ON ACTION controlp INFIELD dbag005
            #add-point:ON ACTION controlp INFIELD dbag005
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_dbag2_d[l_ac].dbag005             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_dbag2_d[l_ac].dbagsite
            LET g_qryparam.arg2 = g_dbag2_d[l_ac].dbag004
            
            CALL q_inab002_6()                                #呼叫開窗
            LET g_dbag2_d[l_ac].dbag005 = g_qryparam.return1  
            DISPLAY g_dbag2_d[l_ac].dbag005 TO dbag005
            CALL s_desc_get_locator_desc(g_dbag2_d[l_ac].dbagsite,g_dbag2_d[l_ac].dbag004,g_dbag2_d[l_ac].dbag005)
               RETURNING g_dbag2_d[l_ac].dbag005_desc
            DISPLAY BY NAME g_dbag2_d[l_ac].dbag005_desc
            NEXT FIELD dbag005                          #返回原欄位
            #END add-point
 
         #----<<dbag005_desc>>----
         #----<<dbag006>>----
         #Ctrlp:input.c.page2.dbag006
         ON ACTION controlp INFIELD dbag006
            #add-point:ON ACTION controlp INFIELD dbag006
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_dbag2_d[l_ac].dbag006             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_dbag2_d[l_ac].dbagsite
            CALL q_inaa001_19()                                #呼叫開窗
            LET g_dbag2_d[l_ac].dbag006 = g_qryparam.return1    
            DISPLAY g_dbag2_d[l_ac].dbag006 TO dbag006
            CALL s_desc_get_stock_desc(g_dbag2_d[l_ac].dbagsite,g_dbag2_d[l_ac].dbag006)
               RETURNING g_dbag2_d[l_ac].dbag006_desc
            DISPLAY BY NAME g_dbag2_d[l_ac].dbag006_desc
            NEXT FIELD dbag006                          #返回原欄位
            #END add-point
 
         #----<<dbag006_desc>>----
         #----<<dbag007>>----
         #Ctrlp:input.c.page2.dbag007
         ON ACTION controlp INFIELD dbag007
            #add-point:ON ACTION controlp INFIELD dbag007
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_dbag2_d[l_ac].dbag007             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_dbag2_d[l_ac].dbagsite
            LET g_qryparam.arg2 = g_dbag2_d[l_ac].dbag006
            
            CALL q_inab002_6()                                #呼叫開窗
            LET g_dbag2_d[l_ac].dbag007 = g_qryparam.return1              
            DISPLAY g_dbag2_d[l_ac].dbag007 TO dbag007
            CALL s_desc_get_locator_desc(g_dbag2_d[l_ac].dbagsite,g_dbag2_d[l_ac].dbag006,g_dbag2_d[l_ac].dbag007)
               RETURNING g_dbag2_d[l_ac].dbag007_desc
            DISPLAY BY NAME g_dbag2_d[l_ac].dbag007_desc
            NEXT FIELD dbag007                          #返回原欄位
            #END add-point
 
         #----<<dbag007_desc>>----
 
 
         AFTER ROW
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
 
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_dbag2_d[l_ac].* = g_dbag2_d_t.*
               END IF
               CLOSE adbi201_bcl2
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
 
            CALL adbi201_unlock_b("dbag_t")
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #add-point:input段after input 

            #end add-point   
 
         ON ACTION controlo   
            CALL FGL_SET_ARR_CURR(g_dbag2_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_dbag2_d.getLength()+1
 
      END INPUT
 
      
 
    
      DISPLAY ARRAY g_dbag3_d TO s_detail3.*
         ATTRIBUTES(COUNT=g_detail_cnt)  
      
         BEFORE DISPLAY 
            CALL FGL_SET_ARR_CURR(g_detail_idx2)
            CALL adbi201_fetch()
            LET g_current_page = 3
            
         BEFORE ROW
            LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail3")
            LET l_ac = g_detail_idx
            CALL cl_show_fld_cont() 
            CALL adbi201_idx_chk('d')
            
         #add-point:page3自定義行為

         #end add-point
            
      END DISPLAY
 
      
      #add-point:input段input_array"

      #end add-point
      
      BEFORE DIALOG 
         LET g_curr_diag = ui.DIALOG.getCurrent()
         IF g_detail_idx > 0 THEN
            IF g_detail_idx > g_dbag_d.getLength() THEN
               LET g_detail_idx = g_dbag_d.getLength()
            END IF
            CALL DIALOG.setCurrentRow("s_detail1", g_detail_idx)
            LET l_ac = g_detail_idx
         END IF 
         LET g_detail_idx = l_ac
         #add-point:input段input_array"

         #end add-point
         #先確定單頭(第一單身)是否有資料
         IF g_dbag_d.getLength() > 0 THEN
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD dbag001
               WHEN "s_detail2"
                  NEXT FIELD dbagstus
               WHEN "s_detail3"
                  NEXT FIELD dbagsite_3
 
            END CASE
         ELSE
            NEXT FIELD dbag001
         END IF
   
      ON ACTION accept
         ACCEPT DIALOG
      
      ON ACTION cancel
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION close
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
   
   #add-point:input段修改後

   #end add-point
 
   CLOSE adbi201_bcl
   CALL s_transaction_end('Y','0')
   
END FUNCTION
 
{</section>}
 
{<section id="adbi201.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION adbi201_b_fill(p_wc2)
   DEFINE p_wc2           STRING
   DEFINE l_ac_t          LIKE type_t.num5
   #add-point:b_fill段define
 
   #end add-point
 
   #add-point:b_fill段sql_before
   IF cl_null(p_wc2) THEN
      LET p_wc2 = p_wc2," dbag001 = '",g_argv[1],"'"
   ELSE
      LET p_wc2 = p_wc2," AND dbag001 = '",g_argv[1],"'"
   END IF
   LET p_wc2 = p_wc2, cl_sql_add_filter("dbag_t")   #161215-00045#3 add by rainy
   #end add-point
   
   LET g_sql = "SELECT UNIQUE dbag001,dbag002,'',dbag003,'',' ' FROM dbag_t",
               " WHERE dbagent= ? AND 1=1 AND ", p_wc2,
               " ORDER BY dbag_t.dbag001,dbag_t.dbag002,dbag_t.dbag003"
  
   #add-point:b_fill段sql_after
   DISPLAY 'b_fill sql = ',g_sql
   #end add-point
  
   PREPARE adbi201_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR adbi201_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_dbag_d.clear()
   CALL g_dbag2_d.clear()   
   CALL g_dbag3_d.clear()   
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_dbag_d[l_ac].dbag001, g_dbag_d[l_ac].dbag002,
                            g_dbag_d[l_ac].dbag002_desc, g_dbag_d[l_ac].dbag003,
                            g_dbag_d[l_ac].dbag003_desc, g_dbag_d[l_ac].dbagsite 
 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充

      #end add-point
      
      CALL adbi201_detail_show()      
 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ""
            LET g_errparam.popup = TRUE
            CALL cl_err()
 
         END IF
         EXIT FOREACH
      END IF
      
   END FOREACH
   LET g_error_show = 0
   
 
   CALL g_dbag_d.deleteElement(g_dbag_d.getLength())   
   CALL g_dbag2_d.deleteElement(g_dbag2_d.getLength())
   CALL g_dbag3_d.deleteElement(g_dbag3_d.getLength())
 
 
   #確定指標無超過上限, 超過則指到最後一筆
   IF g_detail_idx > g_dbag_d.getLength() THEN
      LET g_detail_idx = g_dbag_d.getLength()
   END IF
 
   #將key欄位填到每個page
   LET l_ac_t = g_detail_idx
   FOR g_detail_idx = 1 TO g_dbag_d.getLength()
 
   END FOR
   LET g_detail_idx = l_ac_t
   
   #add-point:b_fill段資料填充(其他單身)

   #end add-point
    
   LET g_detail_cnt = l_ac - 1
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE adbi201_pb
   
   LET l_ac = 1
   IF g_dbag_d.getLength() > 0 THEN
      CALL adbi201_fetch()
   END IF
   
END FUNCTION
 
{</section>}
 
{<section id="adbi201.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION adbi201_fetch()
   DEFINE li_ac           LIKE type_t.num5
   #add-point:fetch段define
   DEFINE l_where         STRING
   
   CALL s_aooi500_sql_where(g_prog,'dbagsite') RETURNING l_where
   IF cl_null(g_wc2_table2) THEN
      LET g_wc2_table2 = l_where
   ELSE
      LET g_wc2_table2 = g_wc2_table2, " AND ", l_where
   END IF
   #end add-point
 
   IF g_detail_idx <= 0 OR g_dbag_d.getLength() = 0 THEN
      RETURN
   END IF
   
   CALL g_dbag2_d.clear()
   CALL g_dbag3_d.clear()
 
   
   LET li_ac = l_ac 
   
   LET g_sql = "SELECT  UNIQUE dbagstus,dbagsite,'',dbag004,'',dbag005,'',",
               "               dbag006,'',dbag007,'',dbagsite, ",
               "               dbagownid,'',dbagowndp,'',dbagcrtid,'',dbagcrtdp,'',",
               "               dbagcrtdt,dbagmodid,'',dbagmoddt FROM dbag_t", 
               " WHERE dbagent=? AND dbag001=? AND dbag002=? AND dbag003=?"
 
   IF NOT cl_null(g_wc2_table2) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
   END IF
 
   LET g_sql = g_sql, " ORDER BY dbag_t.dbagsite" 
                      
   #add-point:單身填充前
   DISPlAY "fetch g_sql = ",g_sql
   #end add-point
   
   PREPARE adbi201_pb2 FROM g_sql
   DECLARE b_fill_curs2 CURSOR FOR adbi201_pb2
   
   OPEN b_fill_curs2 USING g_enterprise,g_dbag_d[g_detail_idx].dbag001
                                  ,g_dbag_d[g_detail_idx].dbag002
                                  ,g_dbag_d[g_detail_idx].dbag003
 
   LET l_ac = 1
   FOREACH b_fill_curs2 INTO g_dbag2_d[l_ac].dbagstus,g_dbag2_d[l_ac].dbagsite,g_dbag2_d[l_ac].dbagsite_desc, 
       g_dbag2_d[l_ac].dbag004,g_dbag2_d[l_ac].dbag004_desc,g_dbag2_d[l_ac].dbag005,g_dbag2_d[l_ac].dbag005_desc, 
       g_dbag2_d[l_ac].dbag006,g_dbag2_d[l_ac].dbag006_desc,g_dbag2_d[l_ac].dbag007,g_dbag2_d[l_ac].dbag007_desc, 
       g_dbag3_d[l_ac].dbagsite,g_dbag3_d[l_ac].dbagownid,g_dbag3_d[l_ac].dbagownid_desc, 
       g_dbag3_d[l_ac].dbagowndp,g_dbag3_d[l_ac].dbagowndp_desc,g_dbag3_d[l_ac].dbagcrtid,g_dbag3_d[l_ac].dbagcrtid_desc, 
       g_dbag3_d[l_ac].dbagcrtdp,g_dbag3_d[l_ac].dbagcrtdp_desc,g_dbag3_d[l_ac].dbagcrtdt,g_dbag3_d[l_ac].dbagmodid, 
       g_dbag3_d[l_ac].dbagmodid_desc,g_dbag3_d[l_ac].dbagmoddt
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #add-point:b_fill段資料填充
      IF cl_null(g_dbag2_d[l_ac].dbagsite) THEN
         CONTINUE FOREACH
      END IF
      IF g_dbag2_d[l_ac].dbagstus IS NULL THEN
         LET g_dbag2_d[l_ac].dbagstus = 'Y'
      END IF
      CALL adbi201_detail_show()
      #end add-point
      
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
      
   END FOREACH
 
 
 
   #add-point:單身填充後

   #end add-point
   
   CALL g_dbag2_d.deleteElement(g_dbag2_d.getLength())   
   CALL g_dbag3_d.deleteElement(g_dbag3_d.getLength())   
 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="adbi201.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION adbi201_detail_show()
   #add-point:show段define

   #end add-point
 
   #add-point:detail_show段之前

   #end add-point
   
   
   
   #帶出公用欄位reference值page1
   
    
   #帶出公用欄位reference值page2
   
   #帶出公用欄位reference值page3
   #此段落由子樣板a12產生
      
   
   #讀入ref值
   #add-point:show段單身reference
 
   #end add-point
   
   #add-point:show段單身reference
   IF g_current_page = '0' OR g_current_page = '1' THEN
      CALL s_desc_get_trading_partner_abbr_desc(g_dbag_d[l_ac].dbag002)
         RETURNING g_dbag_d[l_ac].dbag002_desc
      DISPLAY BY NAME g_dbag_d[l_ac].dbag002_desc
      CALL s_desc_get_trading_partner_abbr_desc(g_dbag_d[l_ac].dbag003)
         RETURNING g_dbag_d[l_ac].dbag003_desc
      DISPLAY BY NAME g_dbag_d[l_ac].dbag003_desc
   END IF
   
   CALL s_desc_get_department_desc(g_dbag2_d[l_ac].dbagsite)
      RETURNING g_dbag2_d[l_ac].dbagsite_desc
   DISPLAY BY NAME g_dbag2_d[l_ac].dbagsite_desc

   CALL s_desc_get_stock_desc(g_dbag2_d[l_ac].dbagsite,g_dbag2_d[l_ac].dbag004)
      RETURNING g_dbag2_d[l_ac].dbag004_desc
   DISPLAY BY NAME g_dbag2_d[l_ac].dbag004_desc
   
   CALL s_desc_get_locator_desc(g_dbag2_d[l_ac].dbagsite,g_dbag2_d[l_ac].dbag004,g_dbag2_d[l_ac].dbag005)
      RETURNING g_dbag2_d[l_ac].dbag005_desc
   DISPLAY BY NAME g_dbag2_d[l_ac].dbag005_desc

   CALL s_desc_get_stock_desc(g_dbag2_d[l_ac].dbagsite,g_dbag2_d[l_ac].dbag006)
      RETURNING g_dbag2_d[l_ac].dbag006_desc
   DISPLAY BY NAME g_dbag2_d[l_ac].dbag006_desc

   CALL s_desc_get_locator_desc(g_dbag2_d[l_ac].dbagsite,g_dbag2_d[l_ac].dbag006,g_dbag2_d[l_ac].dbag007)
      RETURNING g_dbag2_d[l_ac].dbag007_desc
   DISPLAY BY NAME g_dbag2_d[l_ac].dbag007_desc

   #end add-point
   #add-point:show段單身reference
      
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_dbag3_d[l_ac].dbagownid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_dbag3_d[l_ac].dbagownid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_dbag3_d[l_ac].dbagownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_dbag3_d[l_ac].dbagowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_dbag3_d[l_ac].dbagowndp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_dbag3_d[l_ac].dbagowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_dbag3_d[l_ac].dbagcrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_dbag3_d[l_ac].dbagcrtid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_dbag3_d[l_ac].dbagcrtid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_dbag3_d[l_ac].dbagcrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_dbag3_d[l_ac].dbagcrtdp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_dbag3_d[l_ac].dbagcrtdp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_dbag3_d[l_ac].dbagmodid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_dbag3_d[l_ac].dbagmodid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_dbag3_d[l_ac].dbagmodid_desc

   #end add-point
 
   
   #add-point:detail_show段之後

   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="adbi201.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION adbi201_set_entry_b(p_cmd)                                                  
   DEFINE p_cmd   LIKE type_t.chr1         
   #add-point:set_entry_b段define
   
   #end add-point
   
   #add-point:set_entry段欄位控制後
   CALL cl_set_comp_entry('dbagsite',TRUE)
   #end add-point 
                                                                     
END FUNCTION                                                                    
 
{</section>}
 
{<section id="adbi201.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION adbi201_set_no_entry_b(p_cmd)                                               
   DEFINE p_cmd   LIKE type_t.chr1           
   #add-point:set_no_entry_b段define
   
   #end add-point
   
   #add-point:set_no_entry段欄位控制後
   #aooi500設定的欄位控卡
   IF NOT s_aooi500_comp_entry(g_prog,'dbagsite') THEN
      CALL cl_set_comp_entry("dbagsite",FALSE)
   END IF
   #end add-point 
                                                                          
END FUNCTION  
 
{</section>}
 
{<section id="adbi201.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION adbi201_default_search()
   DEFINE li_idx  LIKE type_t.num5
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE ls_wc   STRING
   #add-point:default_search段define

   #end add-point  
   
   IF NOT cl_null(g_argv[1]) THEN
      LET ls_wc = ls_wc, " dbag001 = ", g_argv[1], " AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " dbag002 = ", g_argv[02], " AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " dbag003 = ", g_argv[03], " AND "
   END IF
 
   
   IF NOT cl_null(ls_wc) THEN
      LET ls_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_wc = ls_wc
   ELSE
      LET g_wc = " 1=1"
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="adbi201.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION adbi201_delete_b(ps_table,ps_keys_bak,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:delete_b段define

   #end add-point     
 
   #判斷是否是同一群組的table
   LET ls_group = "dbag_1,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:delete_b段刪除前

      #end add-point  
      DELETE FROM dbag_t
       WHERE dbagent = g_enterprise
         AND dbag001 = ps_keys_bak[1]
         AND dbag002 = ps_keys_bak[2]
         AND dbag003 = ps_keys_bak[3]
      #add-point:delete_b段刪除中

      #end add-point  
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ""
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
      END IF
      #add-point:delete_b段刪除後

      #end add-point  
   END IF
   
 
   
   LET ls_group = "dbag_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:delete_b段刪除前

      #end add-point  
      DELETE FROM dbag_t
       WHERE dbagent = g_enterprise AND
         dbag001 = ps_keys_bak[1] AND dbag002 = ps_keys_bak[2] AND dbag003 = ps_keys_bak[3] AND dbagsite = ps_keys_bak[4]
      #add-point:delete_b段刪除中

      #end add-point  
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "dbag_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
      END IF
      #add-point:delete_b段刪除後

      #end add-point  
      RETURN
   END IF
 
 
   
   #單頭刪除, 連帶刪除單身
   LET ls_group = "dbag_1,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:delete_b段刪除前

      #end add-point  
      DELETE FROM dbag_t
       WHERE dbagent = g_enterprise
         AND dbag001 = ps_keys_bak[1]
         AND dbag002 = ps_keys_bak[2]
         AND dbag003 = ps_keys_bak[3]
      #add-point:delete_b段刪除中

      #end add-point  
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "dbag_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
      END IF
      #add-point:delete_b段刪除後

      #end add-point  
      RETURN
   END IF
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="adbi201.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION adbi201_insert_b(ps_table,ps_keys,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:insert_b段define
   DEFINE l_dbagcrtdt DATETIME YEAR TO SECOND
   #end add-point
 
   #判斷是否是同一群組的table
   LET ls_group = "dbag_1,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:insert_b段新增前
      LET l_dbagcrtdt = cl_get_current()
      #end add-point
      INSERT INTO dbag_t
                  (dbagent,  dbag001,  dbag002,  dbag003,
                   dbagsite, dbagstus, dbagownid,dbagowndp,
                   dbagcrtid,dbagcrtdp,dbagcrtdt) 
            VALUES(g_enterprise,ps_keys[1],ps_keys[2],ps_keys[3],
                   g_dbag_d[g_detail_idx].dbagsite,'Y',g_user,g_dept,
                   g_user,g_dept,l_dbagcrtdt)
      #add-point:insert_b段新增中

      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "dbag_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
      END IF
      #add-point:insert_b段新增後

      #end add-point
   END IF
   
 
   
   LET ls_group = "dbag_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:insert_b段新增前

      #end add-point
      INSERT INTO dbag_t
                  (dbagent,
                   dbag001,dbag002,dbag003,dbagsite
                   ,dbagstus,dbag004,dbag005,dbag006,dbag007,dbagownid,dbagowndp,dbagcrtid,dbagcrtdp,dbagcrtdt,dbagmodid,dbagmoddt) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
                   ,g_dbag2_d[g_detail_idx2].dbagstus,g_dbag2_d[g_detail_idx2].dbag004,g_dbag2_d[g_detail_idx2].dbag005, 
                       g_dbag2_d[g_detail_idx2].dbag006,g_dbag2_d[g_detail_idx2].dbag007,g_dbag3_d[g_detail_idx2].dbagownid, 
                       g_dbag3_d[g_detail_idx2].dbagowndp,g_dbag3_d[g_detail_idx2].dbagcrtid,g_dbag3_d[g_detail_idx2].dbagcrtdp, 
                       g_dbag3_d[g_detail_idx2].dbagcrtdt,g_dbag3_d[g_detail_idx2].dbagmodid,g_dbag3_d[g_detail_idx2].dbagmoddt) 
 
      #add-point:insert_b段新增中

      #end add-point
      IF SQLCA.sqlcode THEN
         RETURN
      END IF
      #add-point:insert_b段新增後

      #end add-point
   END IF
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="adbi201.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION adbi201_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   DEFINE ps_table         STRING
   DEFINE ps_page          STRING
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
   
   #判斷key是否有改變
   LET lb_chk = TRUE
   FOR li_idx = 1 TO ps_keys.getLength()
      IF ps_keys[li_idx] <> ps_keys_bak[li_idx] THEN
         LET lb_chk = FALSE
         EXIT FOR
      END IF
   END FOR
   
   #不需要做處理
   IF lb_chk THEN
      RETURN
   END IF
   
   #判斷是否是同一群組的table
   LET ls_group = "dbag_1,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "dbag_1" THEN
   
      #add-point:update_b段修改前

      #end add-point     
   
      UPDATE dbag_t 
         SET (dbag001,dbag002,dbag003
              ,dbagsite) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_dbag_d[g_detail_idx].dbagsite) 
         WHERE dbagent = g_enterprise         #160905-00003#1 modify by rainy 加上ent條件
           AND dbag001 = ps_keys_bak[1] AND dbag002 = ps_keys_bak[2] AND dbag003 = ps_keys_bak[3]
 
      #add-point:update_b段修改中

      #end add-point 
         
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "std-00009"
            LET g_errparam.extend = "dbag_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
 
            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "dbag_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
  
            CALL s_transaction_end('N','0')
         OTHERWISE
            
      END CASE
 
      #add-point:update_b段修改後

      #end add-point
      
      RETURN
   END IF
   
 
   
   LET ls_group = "dbag_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "dbag_t" THEN
   
      #add-point:update_b段修改前

      #end add-point    
      
      UPDATE dbag_t 
         SET (dbag001,dbag002,dbag003,dbagsite
              ,dbagstus,dbag004,dbag005,dbag006,dbag007,dbagownid,dbagowndp,dbagcrtid,dbagcrtdp,dbagcrtdt,dbagmodid,dbagmoddt) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
              ,g_dbag2_d[g_detail_idx2].dbagstus,g_dbag2_d[g_detail_idx2].dbag004,g_dbag2_d[g_detail_idx2].dbag005, 
                  g_dbag2_d[g_detail_idx2].dbag006,g_dbag2_d[g_detail_idx2].dbag007,g_dbag3_d[g_detail_idx2].dbagownid, 
                  g_dbag3_d[g_detail_idx2].dbagowndp,g_dbag3_d[g_detail_idx2].dbagcrtid,g_dbag3_d[g_detail_idx2].dbagcrtdp, 
                  g_dbag3_d[g_detail_idx2].dbagcrtdt,g_dbag3_d[g_detail_idx2].dbagmodid,g_dbag3_d[g_detail_idx2].dbagmoddt)  
 
         WHERE dbagent = g_enterprise         #160905-00003#1 modify by rainy 加上ent條件
           AND dbag001 = ps_keys_bak[1] AND dbag002 = ps_keys_bak[2] AND dbag003 = ps_keys_bak[3] AND dbagsite = ps_keys_bak[4]
 
      #add-point:update_b段修改中

      #end add-point 
         
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "std-00009"
            LET g_errparam.extend = "dbag_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
 
            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "dbag_t"
            LET g_errparam.popup = TRUE
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
 
{<section id="adbi201.key_update_b" >}
#+ 單頭key欄位變動後, 連帶修正其他單身table
PRIVATE FUNCTION adbi201_key_update_b()
   DEFINE li_idx           LIKE type_t.num5 
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   #add-point:update_b段define

   #end add-point
 
   #判斷key是否有改變
   LET lb_chk = TRUE
   
   IF g_master.dbag001 <> g_master_t.dbag001 THEN
      LET lb_chk = FALSE
   END IF
   IF g_master.dbag002 <> g_master_t.dbag002 THEN
      LET lb_chk = FALSE
   END IF
   IF g_master.dbag003 <> g_master_t.dbag003 THEN
      LET lb_chk = FALSE
   END IF
 
   #不需要做處理
   IF lb_chk THEN
      RETURN
   END IF
    
   #add-point:update_b段修改前

   #end add-point
   
   UPDATE dbag_t 
      SET (dbag001,dbag002,dbag003) 
           = 
          (g_master.dbag001,g_master.dbag002,g_master.dbag003) 
      WHERE    dbagent = g_enterprise         #160905-00003#1 modify by rainy 加上ent條件
           AND dbag001 = g_master_t.dbag001
           AND dbag002 = g_master_t.dbag002
           AND dbag003 = g_master_t.dbag003
 
           
   #add-point:update_b段修改中

   #end add-point
           
   CASE
      #WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
      #   CALL cl_err("dbag_t","std-00009",1)
      #   CALL s_transaction_end('N','0')
      WHEN SQLCA.sqlcode #其他錯誤
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "dbag_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
  
         CALL s_transaction_end('N','0')
      OTHERWISE
         #若有多語言table資料一同更新
         
   END CASE
   
   #add-point:update_b段修改後

   #end add-point
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="adbi201.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION adbi201_lock_b(ps_table)
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define

   #end add-point   
   
   #先刷新資料
   #CALL adbi201_b_fill(g_wc)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "dbag_1"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN adbi201_bcl USING g_enterprise,
                                       g_dbag_d[g_detail_idx].dbag001,g_dbag_d[g_detail_idx].dbag002, 
                                           g_dbag_d[g_detail_idx].dbag003
                                       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "adbi201_bcl"
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   #鎖定整組table
   #LET ls_group = "dbag_t,"
   #僅鎖定自身table
   LET ls_group = "dbag_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN adbi201_bcl2 USING g_enterprise,
                                             g_master.dbag001,g_master.dbag002,g_master.dbag003,
                                             g_dbag2_d[g_detail_idx2].dbagsite 
 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "adbi201_bcl2"
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         RETURN FALSE
      END IF
   END IF
 
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="adbi201.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION adbi201_unlock_b(ps_table)
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:unlock_b段define

   #end add-point  
   
   LET ls_group = "dbag_1"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      CLOSE adbi201_bcl
   END IF
   
 
    
   LET ls_group = "dbag_t,"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      CLOSE adbi201_bcl2
   END IF
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="adbi201.idx_chk" >}
#+ 單身筆數變更
PRIVATE FUNCTION adbi201_idx_chk(ps_loc)
   DEFINE ps_loc   LIKE type_t.chr10
   DEFINE li_idx   LIKE type_t.num5
   DEFINE li_cnt   LIKE type_t.num5
   #add-point:idx_chk段define

   #end add-point  
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_dbag_d.getLength() THEN
         LET g_detail_idx = g_dbag_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_dbag_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      LET li_idx = g_detail_idx
      LET li_cnt = g_dbag_d.getLength()
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx2 = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx2 > g_dbag2_d.getLength() THEN
         LET g_detail_idx2 = g_dbag2_d.getLength()
      END IF
      IF g_detail_idx2 = 0 AND g_dbag2_d.getLength() <> 0 THEN
         LET g_detail_idx2 = 1
      END IF
      LET li_idx = g_detail_idx2
      LET li_cnt = g_dbag2_d.getLength()
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx2 = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx2 > g_dbag3_d.getLength() THEN
         LET g_detail_idx2 = g_dbag3_d.getLength()
      END IF
      IF g_detail_idx2 = 0 AND g_dbag3_d.getLength() <> 0 THEN
         LET g_detail_idx2 = 1
      END IF
      LET li_idx = g_detail_idx2
      LET li_cnt = g_dbag3_d.getLength()
   END IF
 
    
   IF ps_loc = 'm' THEN
      DISPLAY li_idx TO FORMONLY.h_index
      DISPLAY li_cnt TO FORMONLY.h_count
      IF g_dbag2_d.getLength() = 0 THEN
         DISPLAY '' TO FORMONLY.idx
         DISPLAY '' TO FORMONLY.cnt
      ELSE
         DISPLAY 1 TO FORMONLY.idx
         DISPLAY g_dbag2_d.getLength() TO FORMONLY.cnt
      END IF
      IF g_dbag3_d.getLength() = 0 THEN
         DISPLAY '' TO FORMONLY.idx
         DISPLAY '' TO FORMONLY.cnt
      ELSE
         DISPLAY 1 TO FORMONLY.idx
         DISPLAY g_dbag3_d.getLength() TO FORMONLY.cnt
      END IF
 
   ELSE
      DISPLAY li_idx TO FORMONLY.idx
      DISPLAY li_cnt TO FORMONLY.cnt
   END IF
   
   #add-point:idx_chk段other

   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="adbi201.set_pk_array" >}
 
 
{</section>}
 
{<section id="adbi201.state_change" >}
    
 
{</section>}
 
{<section id="adbi201.func_signature" >}
   
 
{</section>}
 
{<section id="adbi201.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="adbi201.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 檢查單頭key值是否重複
# Memo...........:
# Usage..........: CALL adbi201_chk_head_key(p_dbag001,p_dbag002,p_dbag003)
#                  RETURNING r_success,r_errno
# Input parameter: p_dbag001      倉庫類別
#                : p_dbag002      客戶編號/代送商編號
#                : p_dbag003      送貨客戶編號
# Return code....: r_success      True/False
#                : r_errno        錯誤訊息代碼
# Date & Author..: 2014/06/13 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION adbi201_chk_head_key(p_dbag001,p_dbag002,p_dbag003)
DEFINE p_dbag001           LIKE dbag_t.dbag001
DEFINE p_dbag002           LIKE dbag_t.dbag002
DEFINE p_dbag003           LIKE dbag_t.dbag003
DEFINE p_dbag004           LIKE dbag_t.dbag004
DEFINE r_success           LIKE type_t.num5
DEFINE r_errno             LIKE type_t.chr10
DEFINE l_cnt               LIKE type_t.num5

   LET r_success = TRUE
   LET r_errno = ''

   IF cl_null(p_dbag002) THEN LET p_dbag002 = ' ' END IF
   IF cl_null(p_dbag003) THEN LET p_dbag003 = ' ' END IF
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM dbag_t
    WHERE dbagent = g_enterprise
      AND dbag001 = p_dbag001
      AND dbag002 = p_dbag002
      AND dbag003 = p_dbag003
      
   IF l_cnt >= 1 THEN
      LET r_success = FALSE
      #代送商倉庫
      IF g_argv[1] = '1' THEN
         #不能存在相同 供應商編號！
         LET r_errno = 'adb-00195'
      ELSE
         #代送商倉庫
         #不能存在相同 客戶編號+送貨客戶！
         LET r_errno = 'adb-00183'
      END IF
   END IF
   RETURN r_success,r_errno
END FUNCTION

################################################################################
# Descriptions...: 檢查key值是否重複
# Memo...........:
# Usage..........: CALL adbi201_chk_key(p_dbagsite,p_dbag001,p_dbag002,p_dbag003)
#                  RETURNING r_success,r_errno
# Input parameter: p_dbagsite     發貨組織
#                : p_dbag001      倉庫類別
#                : p_dbag002      客戶編號/代送商編號
#                : p_dbag003      送貨客戶編號
# Return code....: r_success      True/False
#                : r_errno        錯誤訊息代碼
# Date & Author..: 2014/06/13 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION adbi201_chk_key(p_dbagsite,p_dbag001,p_dbag002,p_dbag003)
DEFINE p_dbagsite          LIKE dbag_t.dbagsite
DEFINE p_dbag001           LIKE dbag_t.dbag001
DEFINE p_dbag002           LIKE dbag_t.dbag002
DEFINE p_dbag003           LIKE dbag_t.dbag003
DEFINE p_dbag004           LIKE dbag_t.dbag004
DEFINE r_success           LIKE type_t.num5
DEFINE r_errno             LIKE type_t.chr10
DEFINE l_cnt               LIKE type_t.num5

   LET r_success = TRUE
   LET r_errno = ''

   IF cl_null(p_dbag002) THEN LET p_dbag002 = ' ' END IF
   IF cl_null(p_dbag003) THEN LET p_dbag003 = ' ' END IF
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM dbag_t
    WHERE dbagent = g_enterprise
      AND dbagsite = p_dbagsite
      AND dbag001 = p_dbag001
      AND dbag002 = p_dbag002
      AND dbag003 = p_dbag003

   IF l_cnt >= 1 THEN
      LET r_success = FALSE
      #代送商倉庫
      IF g_argv[1] = '1' THEN
         #不能存在相同 供應商編號+發貨組織！
         LET r_errno = 'adb-00196'
      ELSE
         #寄銷倉庫
         #不能存在相同 客戶編號+送貨客戶+發貨組織！
         LET r_errno = 'adb-00186'
      END IF
   END IF
   RETURN r_success,r_errno
END FUNCTION

################################################################################
# Descriptions...: 預設客戶編號的送貨客戶
# Memo...........:
# Usage..........: CALL adbi201_dbag002_default()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/06/17 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION adbi201_dbag002_default()
DEFINE r_success           LIKE type_t.num5
DEFINE r_errno             LIKE type_t.chr10

   LET g_dbag_d[l_ac].dbag003 = ''
   SELECT pmac002 INTO g_dbag_d[l_ac].dbag003
     FROM pmac_t,dbag_t
    WHERE pmacent = g_enterprise
      AND pmac001 = g_dbag_d[l_ac].dbag002
      AND pmac003 = '2'
      AND pmacstus = 'Y'
      AND pmac004 = 'Y'
      AND NOT EXISTS (SELECT DISTINCT dbag003
                        FROM dbag_t
                       WHERE dbagent = g_enterprise
                         AND dbag001 = g_dbag_d[l_ac].dbag001
                         AND dbag002 = g_dbag_d[l_ac].dbag002
                         AND dbag003 = pmac_t.pmac002)
   
   IF cl_null(g_dbag_d[l_ac].dbag003) THEN
      LET g_sql = "SELECT pmac002",
                  "  FROM pmac_t",
                  " WHERE pmacent = ",g_enterprise,
                  "   AND pmac001 = '",g_dbag_d[l_ac].dbag002,"'",
                  "   AND pmac003 = '2'",
                  "   AND pmacstus = 'Y'",
                  "   AND NOT EXISTS (SELECT DISTINCT dbag003",
                  "                     FROM dbag_t",
                  "                    WHERE dbagent = ",g_enterprise,
                  "                      AND dbag001 = '",g_dbag_d[l_ac].dbag001,"'",
                  "                      AND dbag002 = '",g_dbag_d[l_ac].dbag002,"'",
                  "                      AND dbag003 = pmac_t.pmac002)"
      PREPARE adbi201_pmac002 FROM g_sql
      DECLARE adbi201_pmac002_curs SCROLL CURSOR FOR adbi201_pmac002
      OPEN adbi201_pmac002_curs
      FETCH FIRST adbi201_pmac002_curs INTO g_dbag_d[l_ac].dbag003
      
      IF cl_null(g_dbag_d[l_ac].dbag003) THEN
         LET g_dbag_d[l_ac].dbag003 = g_dbag_d[l_ac].dbag002
         #檢查預設值是否已經有輸入
         CALL adbi201_chk_head_key(g_dbag_d[l_ac].dbag001,g_dbag_d[l_ac].dbag002,g_dbag_d[l_ac].dbag003)
            RETURNING r_success,r_errno
         IF NOT r_success THEN
            LET g_dbag_d[l_ac].dbag003 = ''
         END IF
      END IF
   END IF
   CALL s_desc_get_trading_partner_abbr_desc(g_dbag_d[l_ac].dbag003)
      RETURNING g_dbag_d[l_ac].dbag003_desc
   DISPLAY BY NAME g_dbag_d[l_ac].dbag003_desc
END FUNCTION

################################################################################
# Descriptions...: 客戶編號代送商編號
# Memo...........:
# Usage..........: CALL adbi201_chk_dbag002()
#                  RETURNING r_success,r_errno
# Input parameter: 無
# Return code....: r_success      True/False
#                : r_errno        錯誤訊息代碼
# Date & Author..: 2014/06/17 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION adbi201_chk_dbag002()
DEFINE l_success           LIKE type_t.num5
DEFINE l_errno             LIKE type_t.chr10
DEFINE r_success           LIKE type_t.num5
DEFINE r_errno             LIKE type_t.chr10

    LET l_success = ''
    LET l_errno   = ''
    LET r_success = TRUE
    LET r_errno   = ''
    
    #檢查單頭值是否重複輸入
    CALL adbi201_chk_head_key(g_dbag_d[l_ac].dbag001,g_dbag_d[l_ac].dbag002,g_dbag_d[l_ac].dbag003)
       RETURNING l_success,l_errno
    IF NOT l_success THEN
       LET r_success = FALSE
       LET r_errno = l_errno
       RETURN r_success,r_errno
    END IF
    
    #檢查輸入值是否正確
    INITIALIZE g_chkparam.* TO NULL
    LET g_chkparam.arg1 = g_dbag_d[l_ac].dbag002
    #代送商倉庫
    IF g_argv[1] = '1' THEN
       IF NOT cl_chk_exist("v_pmaa001_1") THEN
          LET r_success = FALSE
          RETURN r_success,r_errno
       END IF
    ELSE
       LET g_chkparam.arg2 = 'ALL'
       #160318-00025#18  by 07900 --add-str
       LET g_errshow = TRUE #是否開窗                   
       LET g_chkparam.err_str[1] ="apm-00201:sub-01302|axmm200|",cl_get_progname("axmm200",g_lang,"2"),"|:EXEPROGaxmm200"
       #160318-00025#18  by 07900 --add-end
       #寄銷倉庫
       IF NOT cl_chk_exist("v_pmaa001_3") THEN
          LET r_success = FALSE
          RETURN r_success,r_errno
       END IF
       CALL adbi201_dbag002_default()
    END IF
    
    RETURN r_success,r_errno
END FUNCTION

 
{</section>}
 
