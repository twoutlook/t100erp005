{<section id="ammp403.description" >}
#+ Version..: T100-ERP-1.00.00(版次:1) Build-000124
#+ 
#+ Filename...: ammp403
#+ Description: 會員卡領用申請批次作業
#+ Creator....: 02296(2014/01/22)
#+ Modifier...: 02296(2014/02/18)
#+ Buildtype..: 應用 t02 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="ammp403.global" >}

 
IMPORT os
IMPORT util
#add-point:增加匯入項目

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_mmay_d RECORD
       sel LIKE type_t.chr80, 
   mmaydocno LIKE mmay_t.mmaydocno, 
   mmay002 LIKE mmay_t.mmay002, 
   mmay002_desc LIKE type_t.chr500, 
   mmay001 LIKE mmay_t.mmay001, 
   mmay001_desc LIKE type_t.chr500, 
   mmaysite LIKE mmay_t.mmaysite, 
   mmaysite_desc LIKE type_t.chr500, 
   mmaystus LIKE mmay_t.mmaystus
       END RECORD
PRIVATE TYPE type_g_mmay2_d RECORD
       mmaydocno LIKE mmay_t.mmaydocno, 
   mmayownid LIKE mmay_t.mmayownid, 
   mmayownid_desc LIKE type_t.chr500, 
   mmayowndp LIKE mmay_t.mmayowndp, 
   mmayowndp_desc LIKE type_t.chr500, 
   mmaycrtid LIKE mmay_t.mmaycrtid, 
   mmaycrtid_desc LIKE type_t.chr500, 
   mmaycrtdp LIKE mmay_t.mmaycrtdp, 
   mmaycrtdp_desc LIKE type_t.chr500, 
   mmaycrtdt DATETIME YEAR TO SECOND, 
   mmaymodid LIKE mmay_t.mmaymodid, 
   mmaymodid_desc LIKE type_t.chr500, 
   mmaymoddt DATETIME YEAR TO SECOND, 
   mmaycnfid LIKE mmay_t.mmaycnfid, 
   mmaycnfid_desc LIKE type_t.chr500, 
   mmaycnfdt DATETIME YEAR TO SECOND
       END RECORD
 
PRIVATE TYPE type_g_mmay3_d RECORD
       mmazseq LIKE mmaz_t.mmazseq, 
   mmaz002 LIKE mmaz_t.mmaz002, 
   mmaz002_desc LIKE type_t.chr500, 
   mmaz003 LIKE mmaz_t.mmaz003, 
   mmaz003_desc LIKE type_t.chr500, 
   mmaz004 LIKE mmaz_t.mmaz004, 
   mmaz004_desc LIKE type_t.chr500, 
   mmaz005 LIKE mmaz_t.mmaz005, 
   mmaz005_desc LIKE type_t.chr500, 
   mmaz001 LIKE mmaz_t.mmaz001, 
   mmaz001_desc LIKE type_t.chr500, 
   mmaz006 LIKE mmaz_t.mmaz006, 
   mmaz007 LIKE mmaz_t.mmaz007
       END RECORD
 
 
 
#無單身append欄位定義
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_mmay_d
DEFINE g_master_t                   type_g_mmay_d
DEFINE g_mmay_d          DYNAMIC ARRAY OF type_g_mmay_d
DEFINE g_mmay_d_t        type_g_mmay_d
DEFINE g_mmay2_d   DYNAMIC ARRAY OF type_g_mmay2_d
DEFINE g_mmay2_d_t type_g_mmay2_d
 
DEFINE g_mmay3_d   DYNAMIC ARRAY OF type_g_mmay3_d
DEFINE g_mmay3_d_t type_g_mmay3_d
 
 
      
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
DEFINE   l_cmd  STRING
#end add-point
 
#add-point:傳入參數說明(global.argv)

#end add-point
 
{</section>}
 
{<section id="ammp403.main" >}
#+ 此段落由子樣板a26產生
#OPTIONS SHORT CIRCUIT
#+ 作業開始 
MAIN
   #add-point:main段define
   
   #end add-point   
 
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("amm","")
 
   #add-point:作業初始化
   
   #end add-point
   
   
 
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = ""
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   DECLARE ammp403_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call
      
      #end add-point
 
   ELSE
      
      #畫面開啟 (identifier)
      OPEN WINDOW w_ammp403 WITH FORM cl_ap_formpath("amm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL ammp403_init()   
 
      #進入選單 Menu (="N")
      CALL ammp403_ui_dialog() 
	  
      #add-point:畫面關閉前
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_ammp403
      
   END IF 
   
   CLOSE ammp403_cl
   
   
 
   #add-point:作業離開前
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN
 
 
 
{</section>}
 
{<section id="ammp403.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION ammp403_init()
   #add-point:init段define
   
   #end add-point   
   
   LET g_error_show = 1
   
   
   LET l_ac = 1
   
   
 
   
 
 
   #避免USER直接進入第二單身時無資料
   IF g_mmay_d.getLength() > 0 THEN
      LET g_master_t.* = g_mmay_d[1].*
      LET g_master.* = g_mmay_d[1].*
   END IF
 
   #add-point:畫面資料初始化
   CALL cl_set_combo_scc_part('mmaystus','13','N,Y,X')
   #end add-point
   
   CALL ammp403_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="ammp403.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION ammp403_ui_dialog()
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
   
      CALL ammp403_b_fill(g_wc)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_mmay_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'
      
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               LET g_master.* = g_mmay_d[g_detail_idx].*
               CALL cl_show_fld_cont()
               CALL ammp403_fetch()
               LET g_current_page = 1
               CALL ammp403_idx_chk('m')
               
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
         DISPLAY ARRAY g_mmay2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'
               
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx
               LET g_master.* = g_mmay_d[g_detail_idx].*
               CALL cl_show_fld_cont() 
               CALL ammp403_fetch()
               LET g_current_page = 2
               CALL ammp403_idx_chk('m')
               
            #自訂ACTION(detail_show,page_2)
            
               
         END DISPLAY
 
 
         
         DISPLAY ARRAY g_mmay3_d TO s_detail3.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'd' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx2)
               END IF
               LET g_loc = 'd'
         
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx2
               LET g_current_page = 3
               CALL ammp403_idx_chk('d')
               LET g_master.* = g_mmay_d[g_detail_idx].*
               CALL cl_show_fld_cont() 
               
            #自訂ACTION(detail_show,page_3)
            
               
         END DISPLAY
 
 
      
         #add-point:ui_dialog段define
#         INPUT ARRAY g_mmay3_d TO s_detail3.*
#            ATTRIBUTES(COUNT=g_detail_cnt)  
#         
#            BEFORE DISPLAY 
#               CALL FGL_SET_ARR_CURR(g_detail_idx2)
#         
#            BEFORE ROW
#               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail3")
#               LET l_ac = g_detail_idx
#               DISPLAY g_detail_idx TO FORMONLY.idx
#               CALL cl_show_fld_cont() 
# 
#               #LET g_master_idx = l_ac
#               #CALL ammp403_fetch()
#               
#            #自訂ACTION(detail_show,page_3)
#            
#               
#         END INPUT
         
         
         ON ACTION insert
 
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN 
               CALL ammp403_insert()
               #add-point:ON ACTION insert

               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION modify
 
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN 
               CALL ammp403_modify()
               #add-point:ON ACTION modify

               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION modify_detail
 
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN 
               CALL ammp403_detail_input('u')
               #add-point:ON ACTION modify_detail

               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION output
 
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN 
               #add-point:ON ACTION output

               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION query
 
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN 
               CALL ammp403_query()
               #add-point:ON ACTION query

               #END add-point
            END IF
            
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_mmay_d.getLength()
               LET g_mmay_d[li_idx].sel = "Y"
            END FOR
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_mmay_d.getLength()
               LET g_mmay_d[li_idx].sel = "N"
            END FOR
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_mmay_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_mmay_d[li_idx].sel = "Y"
               END IF
            END FOR
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_mmay_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_mmay_d[li_idx].sel = "N"
               END IF
            END FOR
      
  
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()         
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            IF g_detail_idx > 0 THEN
               IF g_detail_idx > g_mmay_d.getLength() THEN
                  LET g_detail_idx = g_mmay_d.getLength()
               END IF
               CALL DIALOG.setCurrentRow("s_detail1", g_detail_idx)
               LET l_ac = g_detail_idx
            END IF 
            LET g_detail_idx = l_ac
            NEXT FIELD CURRENT
         
         AFTER DIALOG
            #add-point:ui_dialog段after dialog
            
            #end add-point
         
         
 
         ON ACTION open_ammt402
 
            LET g_action_choice="open_ammt402"
            IF cl_auth_chk_act("open_ammt402") THEN 
               #add-point:ON ACTION open_ammt402
               LET l_cmd = "ammt402 '",g_mmay_d[l_ac].mmaydocno,"' "
               CALL cl_cmdrun_wait(l_cmd)
               #END add-point
               EXIT DIALOG
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
 
{<section id="ammp403.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION ammp403_query()
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define
   
   #end add-point 
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_mmay_d.clear()
   
   LET g_qryparam.state = "c"
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
   #wc備份
   LET ls_wc = g_wc
   LET g_detail_idx = l_ac
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單身根據table分拆construct
      CONSTRUCT g_wc_table ON mmaydocno,mmay002,mmay001,mmaysite,mmaystus,mmayownid,mmayowndp,mmaycrtid, 
          mmaycrtdp,mmaycrtdt,mmaymodid,mmaymoddt,mmaycnfid,mmaycnfdt
           FROM s_detail1[1].mmaydocno,s_detail1[1].mmay002,s_detail1[1].mmay001,s_detail1[1].mmaysite, 
               s_detail1[1].mmaystus,s_detail2[1].mmayownid,s_detail2[1].mmayowndp,s_detail2[1].mmaycrtid, 
               s_detail2[1].mmaycrtdp,s_detail2[1].mmaycrtdt,s_detail2[1].mmaymodid,s_detail2[1].mmaymoddt, 
               s_detail2[1].mmaycnfid,s_detail2[1].mmaycnfdt
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       #此段落由子樣板a11產生
         ##----<<mmayownid>>----
         #ON ACTION controlp INFIELD mmayownid
         #   CALL q_common('','mmayownid',TRUE,FALSE,g_mmay2_d[1].mmayownid) RETURNING ls_return
         #   DISPLAY ls_return TO mmayownid
         #   NEXT FIELD mmayownid  
         #
         ##----<<mmayowndp>>----
         #ON ACTION controlp INFIELD mmayowndp
         #   CALL q_common('','mmayowndp',TRUE,FALSE,g_mmay2_d[1].mmayowndp) RETURNING ls_return
         #   DISPLAY ls_return TO mmayowndp
         #   NEXT FIELD mmayowndp
         #
         ##----<<mmaycrtid>>----
         #ON ACTION controlp INFIELD mmaycrtid
         #   CALL q_common('','mmaycrtid',TRUE,FALSE,g_mmay2_d[1].mmaycrtid) RETURNING ls_return
         #   DISPLAY ls_return TO mmaycrtid
         #   NEXT FIELD mmaycrtid
         #
         ##----<<mmaycrtdp>>----
         #ON ACTION controlp INFIELD mmaycrtdp
         #   CALL q_common('','mmaycrtdp',TRUE,FALSE,g_mmay2_d[1].mmaycrtdp) RETURNING ls_return
         #   DISPLAY ls_return TO mmaycrtdp
         #   NEXT FIELD mmaycrtdp
         #
         ##----<<mmaymodid>>----
         #ON ACTION controlp INFIELD mmaymodid
         #   CALL q_common('','mmaymodid',TRUE,FALSE,g_mmay2_d[1].mmaymodid) RETURNING ls_return
         #   DISPLAY ls_return TO mmaymodid
         #   NEXT FIELD mmaymodid
         #
         ##----<<mmaycnfid>>----
         #ON ACTION controlp INFIELD mmaycnfid
         #   CALL q_common('','mmaycnfid',TRUE,FALSE,g_mmay2_d[1].mmaycnfid) RETURNING ls_return
         #   DISPLAY ls_return TO mmaycnfid
         #   NEXT FIELD mmaycnfid
         #
         ##----<<mmaypstid>>----
         ##ON ACTION controlp INFIELD mmaypstid
         ##   CALL q_common('','mmaypstid',TRUE,FALSE,.mmaypstid) RETURNING ls_return
         ##   DISPLAY ls_return TO mmaypstid
         ##   NEXT FIELD mmaypstid
         
         ##----<<mmaycrtdt>>----
         AFTER FIELD mmaycrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<mmaymoddt>>----
         AFTER FIELD mmaymoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<mmaycnfdt>>----
         AFTER FIELD mmaycnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<mmaypstdt>>----
         #AFTER FIELD mmaypstdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
         
       #單身一般欄位開窗相關處理
       #---------------------<  Detail: page1  >---------------------
         #----<<sel>>----
         #----<<mmaydocno>>----
         #Ctrlp:construct.c.page1.mmaydocno
         ON ACTION controlp INFIELD mmaydocno
            #add-point:ON ACTION controlp INFIELD mmaydocno
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_mmaydocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaydocno  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO mmaydocdt #單據日期 

            NEXT FIELD mmaydocno                     #返回原欄位
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD mmaydocno
            #add-point:BEFORE FIELD mmaydocno
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmaydocno
            
            #add-point:AFTER FIELD mmaydocno
            
            #END add-point
            
 
         #----<<mmay001>>----
         #Ctrlp:construct.c.page1.mmay001
         ON ACTION controlp INFIELD mmay001
            #add-point:ON ACTION controlp INFIELD mmay001
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2'
            CALL q_ooed004_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmay001  #顯示到畫面上

            NEXT FIELD mmay001                     #返回原欄位
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD mmay001
            #add-point:BEFORE FIELD mmay001
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmay001
            
            #add-point:AFTER FIELD mmay001
            
            #END add-point
            
 
         #----<<mmaysite>>----
         #Ctrlp:construct.c.page1.mmaysite
         ON ACTION controlp INFIELD mmaysite
            #add-point:ON ACTION controlp INFIELD mmaysite
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = '2'
            CALL q_ooed004_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaysite  #顯示到畫面上

            NEXT FIELD mmaysite                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD mmaysite
            #add-point:BEFORE FIELD mmaysite
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmaysite
            
            #add-point:AFTER FIELD mmaysite
            
            #END add-point
            
 
#---------------------<  Detail: page2  >---------------------
   
       
      END CONSTRUCT
      
 
      
      CONSTRUCT g_wc2_table2 ON NULL
           FROM NULL
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct
            IF cl_null(g_wc2_table2) THEN
               LET g_wc2_table2 = " 1=1"
            END IF
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
       #---------------------<  Detail: page3  >---------------------
         #----<<mmazseq>>----
         #----<<mmaz002>>----
         #----<<mmaz003>>----
         #----<<mmaz004>>----
         #----<<mmaz005>>----
         #----<<mmaz001>>----
         #----<<mmaz006>>----
         #----<<mmaz007>>----
   
       
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
   CALL ammp403_b_fill(g_wc)
   LET l_ac = g_detail_idx
   CALL ammp403_fetch()
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      CALL cl_err("",-100,1)
   END IF
   
END FUNCTION
 
{</section>}
 
{<section id="ammp403.insert" >}
#+ 資料修改
PRIVATE FUNCTION ammp403_insert()
   #add-point:insert段define
   
   #end add-point 
 
   #add-point:insert段新增前
   
   #end add-point 
   
   #進入資料輸入段落
   CALL g_mmay_d.clear() 
   CALL g_mmay2_d.clear() 
 
   CALL g_mmay3_d.clear() 
 
 
   CALL ammp403_input('a')
   
   CALL ammp403_b_fill(g_wc)
   
   #add-point:insert段新增後
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="ammp403.modify" >}
#+ 資料新增
PRIVATE FUNCTION ammp403_modify()
   #add-point:modify段define
   
   #end add-point 
 
   #add-point:modify段新增前
   
   #end add-point 
   
   #進入資料輸入段落
   CALL ammp403_input('u')
   
   #add-point:modify段新增後
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="ammp403.delete" >}
#+ 資料刪除
PRIVATE FUNCTION ammp403_delete()
   DEFINE li_ac LIKE type_t.num5
   #add-point:delete段define
   
   #end add-point 
   IF NOT cl_ask_delete() THEN
      #不刪除
      RETURN
   END IF
   
   LET li_ac = ARR_CURR()
   LET g_mmay_d_t.* = g_mmay_d[li_ac].*
   
   CALL s_transaction_begin()  
   
   #add-point:delete段刪除前
   
   #end add-point 
   
   #刪除單頭
   DELETE FROM mmay_t 
         WHERE mmaydocno = g_mmay_d_t.mmaydocno
 
           
   #add-point:delete段刪除中
   
   #end add-point 
           
   IF SQLCA.sqlcode THEN
      CALL cl_err("mmay_t",SQLCA.sqlcode,1) 
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:delete段刪除後
   
   #end add-point 
   
   #刪除單頭
   #add-point:delete段刪除前
   
   #end add-point 
   DELETE FROM mmay_t 
         WHERE mmazdocno = g_mmay_d_t.mmaydocno
 
   #add-point:delete段刪除中
   
   #end add-point 
   IF SQLCA.sqlcode THEN
      CALL cl_err("mmay_t",SQLCA.sqlcode,1) 
      CALL s_transaction_end('N','0')
      RETURN
   ELSE
      CALL s_transaction_end('Y','0')
   END IF
   #add-point:delete段刪除後
   
   #end add-point 
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="ammp403.input" >}
#+ 資料輸入
PRIVATE FUNCTION ammp403_input(p_cmd)
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
   
   #end add-point 
   
   LET g_action_choice = ""
   
   LET g_qryparam.state = "i"
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
 
   #add-point:input段define_sql
   
   #end add-point 
   LET g_forupd_sql = "SELECT '',mmaydocno,mmay002,'',mmay001,'',mmaysite,'',mmaystus,'',mmayownid,'', 
       mmayowndp,'',mmaycrtid,'',mmaycrtdp,'',mmaycrtdt,mmaymodid,'',mmaymoddt,mmaycnfid,'',mmaycnfdt  
       FROM mmay_t WHERE mmayent=? AND mmaydocno=? FOR UPDATE"
   #add-point:input段define_sql
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE ammp403_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
   
 
   
   #add-point:input段define_sql
   
   #end add-point 
   LET g_forupd_sql = "SELECT mmazseq,mmaz002,'',mmaz003,'',mmaz004,'',mmaz005,'',mmaz001,'',mmaz006, 
       mmaz007 FROM mmaz_t WHERE mmazent=? AND mmazdocno=? AND mmazseq=? FOR UPDATE"
   #add-point:input段define_sql
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE ammp403_bcl2 CURSOR FROM g_forupd_sql
 
 
 
   LET lb_reproduce = FALSE
   
   #add-point:input段修改前
   
   #end add-point
 
   LET INT_FLAG = 0
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #Page1 預設值產生於此處
      INPUT ARRAY g_mmay_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mmay_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            IF p_cmd = 'u' THEN
               CALL ammp403_b_fill(g_wc)
            END IF
            LET g_detail_cnt = g_mmay_d.getLength()
            #add-point:資料輸入前
            
            #end add-point
            
         BEFORE ROW
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_master_t.* = g_mmay_d[l_ac].*
            LET g_master.* = g_mmay_d[l_ac].*
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            LET g_detail_idx = l_ac
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_mmay_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_mmay_d[l_ac].mmaydocno IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_mmay_d_t.* = g_mmay_d[l_ac].*  #BACKUP
               IF NOT ammp403_lock_b("mmay_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH ammp403_bcl INTO g_mmay_d[l_ac].sel,g_mmay_d[l_ac].mmaydocno,g_mmay_d[l_ac].mmay002, 
                      g_mmay_d[l_ac].mmay002_desc,g_mmay_d[l_ac].mmay001,g_mmay_d[l_ac].mmay001_desc, 
                      g_mmay_d[l_ac].mmaysite,g_mmay_d[l_ac].mmaysite_desc,g_mmay_d[l_ac].mmaystus,g_mmay2_d[l_ac].mmaydocno, 
                      g_mmay2_d[l_ac].mmayownid,g_mmay2_d[l_ac].mmayownid_desc,g_mmay2_d[l_ac].mmayowndp, 
                      g_mmay2_d[l_ac].mmayowndp_desc,g_mmay2_d[l_ac].mmaycrtid,g_mmay2_d[l_ac].mmaycrtid_desc, 
                      g_mmay2_d[l_ac].mmaycrtdp,g_mmay2_d[l_ac].mmaycrtdp_desc,g_mmay2_d[l_ac].mmaycrtdt, 
                      g_mmay2_d[l_ac].mmaymodid,g_mmay2_d[l_ac].mmaymodid_desc,g_mmay2_d[l_ac].mmaymoddt, 
                      g_mmay2_d[l_ac].mmaycnfid,g_mmay2_d[l_ac].mmaycnfid_desc,g_mmay2_d[l_ac].mmaycnfdt 
 
                  IF SQLCA.sqlcode THEN
                     CALL cl_err(g_mmay_d_t.mmaydocno,SQLCA.sqlcode,1)
                     LET l_lock_sw = "Y"
                  END IF
                  
                  CALL ammp403_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL ammp403_set_entry_b(l_cmd)
            CALL ammp403_set_no_entry_b(l_cmd)
            #add-point:input段before row
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            
            #讀取對應的單身資料
            CALL ammp403_fetch()
            LET g_current_page = 1
            CALL ammp403_idx_chk('m')
        
         BEFORE INSERT
            
            #判斷能否在此頁面進行資料新增
            
            #清空下層單身
                        CALL g_mmay3_d.clear()
 
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_mmay_d[l_ac].* TO NULL 
                  LET g_mmay_d[l_ac].sel = "N"
 
 
            LET g_mmay_d_t.* = g_mmay_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL ammp403_set_entry_b("a")
            CALL ammp403_set_no_entry_b("a")
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mmay_d[li_reproduce_target].* = g_mmay_d[li_reproduce].*
               LET g_mmay2_d[li_reproduce_target].* = g_mmay2_d[li_reproduce].*
 
               LET g_mmay_d[g_mmay_d.getLength()].mmaydocno = NULL
 
            END IF
            #公用欄位給值(單身)
            #此段落由子樣板a14產生    
      LET g_mmay2_d[l_ac].mmayownid = g_user
      LET g_mmay2_d[l_ac].mmayowndp = g_dept
      LET g_mmay2_d[l_ac].mmaycrtid = g_user
      LET g_mmay2_d[l_ac].mmaycrtdp = g_dept 
      LET g_mmay2_d[l_ac].mmaycrtdt = cl_get_current()
      LET g_mmay2_d[l_ac].mmaymodid = ""
      LET g_mmay2_d[l_ac].mmaymoddt = ""
      #LET g_mmay_d[l_ac].mmaystus = ""
 
 
            #add-point:input段before insert
            
            #end add-point  
  
         AFTER INSERT
            IF INT_FLAG THEN
               CALL cl_err('',9001,0)
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
            
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM mmay_t 
             WHERE mmayent = g_enterprise AND mmaydocno = g_mmay_d[l_ac].mmaydocno 
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmay_d[g_detail_idx].mmaydocno
               CALL ammp403_insert_b('mmay_t',gs_keys,"'1'")
                           
               #add-point:單身新增後
               
               #end add-point
            ELSE    
               CALL cl_err('INSERT',"std-00006",1)
               INITIALIZE g_mmay_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               CALL cl_err("mmay_t",SQLCA.sqlcode,1)  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL ammp403_b_fill(g_wc)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert
               
               #end add-point
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               LET g_master.* = g_mmay_d[l_ac].*
            END IF
              
         BEFORE DELETE  #是否取消單身
            IF l_cmd = 'a' AND g_mmay_d.getLength() < l_ac THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_mmay_d.deleteElement(l_ac)
               NEXT FIELD mmaydocno
            END IF
            IF g_mmay_d[l_ac].mmaydocno IS NOT NULL
 
               THEN
               
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  CALL cl_err("", -263, 1)
                  CANCEL DELETE
               END IF
               
               #add-point:單身刪除前
               
               #end add-point
               
               DELETE FROM mmay_t
                WHERE mmayent = g_enterprise AND 
                      mmaydocno = g_mmay_d_t.mmaydocno
 
                      
               #add-point:單身刪除中
               
               #end add-point
                      
               IF SQLCA.sqlcode THEN
                  CALL cl_err("mmay_t",SQLCA.sqlcode,1)
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
                  #add-point:單身刪除後
                  
                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE ammp403_bcl
               LET l_count = g_mmay_d.getLength()
            END IF 
            
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmay_d[g_detail_idx].mmaydocno
 
              
         AFTER DELETE 
            #add-point:單身刪除後2
            
            #end add-point
                           CALL ammp403_delete_b('mmay_t',gs_keys,"'1'")
 
         #---------------------<  Detail: page1  >---------------------
         #----<<sel>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sel
            #add-point:BEFORE FIELD sel
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD sel
            
            #add-point:AFTER FIELD sel
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE sel
            #add-point:ON CHANGE sel
            
            #END add-point
 
         #----<<mmaydocno>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmaydocno
            #add-point:BEFORE FIELD mmaydocno
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmaydocno
            
            #add-point:AFTER FIELD mmaydocno
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmaydocno
            #add-point:ON CHANGE mmaydocno
            
            #END add-point
 
         #----<<mmay001>>----
         #此段落由子樣板a02產生
         AFTER FIELD mmay001
            
            #add-point:AFTER FIELD mmay001
            
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD mmay001
            #add-point:BEFORE FIELD mmay001
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE mmay001
            #add-point:ON CHANGE mmay001
            
            #END add-point
 
         #----<<mmaysite>>----
         #此段落由子樣板a02產生
         AFTER FIELD mmaysite
            
            #add-point:AFTER FIELD mmaysite
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmay_d[l_ac].mmaysite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mmay_d[l_ac].mmaysite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mmay_d[l_ac].mmaysite_desc

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD mmaysite
            #add-point:BEFORE FIELD mmaysite
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE mmaysite
            #add-point:ON CHANGE mmaysite
            
            #END add-point
 
 
         #---------------------<  Detail: page1  >---------------------
         #----<<sel>>----
         #Ctrlp:input.c.page1.sel
#         ON ACTION controlp INFIELD sel
            #add-point:ON ACTION controlp INFIELD sel
            
            #END add-point
 
         #----<<mmaydocno>>----
         #Ctrlp:input.c.page1.mmaydocno
#         ON ACTION controlp INFIELD mmaydocno
            #add-point:ON ACTION controlp INFIELD mmaydocno
            
            #END add-point
 
         #----<<mmay001>>----
         #Ctrlp:input.c.page1.mmay001
#         ON ACTION controlp INFIELD mmay001
            #add-point:ON ACTION controlp INFIELD mmay001
            
            #END add-point
 
         #----<<mmaysite>>----
         #Ctrlp:input.c.page1.mmaysite
#         ON ACTION controlp INFIELD mmaysite
            #add-point:ON ACTION controlp INFIELD mmaysite
            
            #END add-point
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CALL cl_err('',9001,0)
               LET INT_FLAG = 0
               LET g_mmay_d[l_ac].* = g_mmay_d_t.*
               CLOSE ammp403_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               CALL cl_err(g_mmay_d[l_ac].mmaydocno,-263,1)
               LET g_mmay_d[l_ac].* = g_mmay_d_t.*
            ELSE
               
               #寫入修改者/修改日期資訊(單身)
               LET g_mmay2_d[l_ac].mmaymodid = g_user 
LET g_mmay2_d[l_ac].mmaymoddt = cl_get_current()
 
               
               #add-point:單身修改前
               
               #end add-point
               
               UPDATE mmay_t SET (mmaydocno,mmay002,mmay001,mmaysite,mmaystus,mmayownid,mmayowndp,mmaycrtid, 
                   mmaycrtdp,mmaycrtdt,mmaymodid,mmaymoddt,mmaycnfid,mmaycnfdt) = (g_mmay_d[l_ac].mmaydocno, 
                   g_mmay_d[l_ac].mmay002,g_mmay_d[l_ac].mmay001,g_mmay_d[l_ac].mmaysite,g_mmay_d[l_ac].mmaystus, 
                   g_mmay2_d[l_ac].mmayownid,g_mmay2_d[l_ac].mmayowndp,g_mmay2_d[l_ac].mmaycrtid,g_mmay2_d[l_ac].mmaycrtdp, 
                   g_mmay2_d[l_ac].mmaycrtdt,g_mmay2_d[l_ac].mmaymodid,g_mmay2_d[l_ac].mmaymoddt,g_mmay2_d[l_ac].mmaycnfid, 
                   g_mmay2_d[l_ac].mmaycnfdt)
                WHERE mmayent = g_enterprise AND
                  mmaydocno = g_mmay_d_t.mmaydocno #項次   
 
                  
               #add-point:單身修改中
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL cl_err("mmay_t","std-00009",1)
                     CALL s_transaction_end('N','0')
                     LET g_mmay_d[l_ac].* = g_mmay_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     CALL cl_err("mmay_t",SQLCA.sqlcode,1)  
                     CALL s_transaction_end('N','0')
                     LET g_mmay_d[l_ac].* = g_mmay_d_t.*
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmay_d[g_detail_idx].mmaydocno
               LET gs_keys_bak[1] = g_mmay_d_t.mmaydocno
               CALL ammp403_update_b('mmay_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
               END CASE
               
               #若Key欄位有變動
               LET g_master.* = g_mmay_d[l_ac].*
               CALL ammp403_key_update_b()
               
               #add-point:單身修改後
               
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL ammp403_unlock_b("mmay_t")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            
              
         AFTER INPUT
            #add-point:input段after input 
            
            #end add-point   
              
         ON ACTION controlo   
            CALL FGL_SET_ARR_CURR(g_mmay_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_mmay_d.getLength()+1
              
      END INPUT
      
 
      
      #實際單身段落
      INPUT ARRAY g_mmay3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_3)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mmay3_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            LET g_detail_cnt = g_mmay3_d.getLength()
            #add-point:資料輸入前
            
            #end add-point
 
         BEFORE INSERT
            IF g_mmay_d.getLength() = 0 THEN
               CALL cl_err('','std-00013',1)
               NEXT FIELD mmaydocno
            END IF 
            #判斷能否在此頁面進行資料新增
            
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_mmay3_d[l_ac].* TO NULL 
                  LET g_mmay3_d[l_ac].mmaz007 = "0"
 
 
            LET g_mmay3_d_t.* = g_mmay3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL ammp403_set_entry_b("a")
            CALL ammp403_set_no_entry_b("a")
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mmay3_d[li_reproduce_target].* = g_mmay3_d[li_reproduce].*
 
               LET g_mmay3_d[li_reproduce_target].mmazseq = NULL
            END IF
            #公用欄位給值(單身3)
            
            #add-point:input段before insert
            
            #end add-point  
            
         BEFORE ROW 
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx2 = l_ac
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            CALL s_transaction_begin()
            LET g_detail_cnt = g_mmay3_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_mmay3_d[l_ac].mmazseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_mmay3_d_t.* = g_mmay3_d[l_ac].*  #BACKUP
               IF NOT ammp403_lock_b("mmaz_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH ammp403_bcl2 INTO g_mmay3_d[l_ac].mmazseq,g_mmay3_d[l_ac].mmaz002,g_mmay3_d[l_ac].mmaz002_desc, 
                      g_mmay3_d[l_ac].mmaz003,g_mmay3_d[l_ac].mmaz003_desc,g_mmay3_d[l_ac].mmaz004,g_mmay3_d[l_ac].mmaz004_desc, 
                      g_mmay3_d[l_ac].mmaz005,g_mmay3_d[l_ac].mmaz005_desc,g_mmay3_d[l_ac].mmaz001,g_mmay3_d[l_ac].mmaz001_desc, 
                      g_mmay3_d[l_ac].mmaz006,g_mmay3_d[l_ac].mmaz007
                  IF SQLCA.sqlcode THEN
                     CALL cl_err('',SQLCA.sqlcode,1)
                     LET l_lock_sw = "Y"
                  END IF
                  CALL cl_show_fld_cont()
                  CALL ammp403_detail_show()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL ammp403_set_entry_b(l_cmd)
            CALL ammp403_set_no_entry_b(l_cmd)
            #add-point:input段before row
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            
            LET g_current_page = 3
            CALL ammp403_idx_chk('d')
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' AND g_mmay3_d.getLength() < l_ac THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_mmay3_d.deleteElement(l_ac)
               NEXT FIELD mmazseq
            END IF
            IF g_mmay3_d[l_ac].mmazseq IS NOT NULL
            THEN
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  CALL cl_err("", -263, 1)
                  CANCEL DELETE
               END IF
               
               #add-point:單身3刪除前
               
               #end add-point  
               
               DELETE FROM mmaz_t
                WHERE mmazent = g_enterprise AND
                   mmazdocno = g_master.mmaydocno
                   AND mmazseq = g_mmay3_d_t.mmazseq
                   
               #add-point:單身3刪除中
               
               #end add-point  
                   
               IF SQLCA.sqlcode THEN
                  CALL cl_err("mmay_t",SQLCA.sqlcode,1)
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
                  #add-point:單身3刪除後
                  
                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE ammp403_bcl
               LET l_count = g_mmay_d.getLength()
            END IF 
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmay_d[g_detail_idx].mmaydocno
               LET gs_keys[2] = g_mmay3_d[g_detail_idx2].mmazseq
 
            
         AFTER DELETE 
            #add-point:單身AFTER DELETE 
            
            #end add-point
                           CALL ammp403_delete_b('mmaz_t',gs_keys,"'3'")
 
         AFTER INSERT    
            IF INT_FLAG THEN
               CALL cl_err('',9001,0)
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM mmaz_t 
             WHERE mmazent = g_enterprise AND
                   mmazdocno = g_master.mmaydocno
                   AND mmazseq = g_mmay3_d[g_detail_idx2].mmazseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmay_d[g_detail_idx].mmaydocno
               LET gs_keys[2] = g_mmay3_d[g_detail_idx2].mmazseq
               CALL ammp403_insert_b('mmaz_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3
               
               #end add-point
            ELSE    
               CALL cl_err('INSERT',"std-00006",1)
               INITIALIZE g_mmay_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               CALL cl_err("mmaz_t",SQLCA.sqlcode,1)  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL ammp403_b_fill(g_wc)
               #資料多語言用-增/改
               
               #add-point:單身新增後
               
               #end add-point
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               CALL cl_err('',9001,0)
               LET INT_FLAG = 0
               LET g_mmay3_d[l_ac].* = g_mmay3_d_t.*
               CLOSE ammp403_bcl2
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               CALL cl_err('',-263,1)
               LET g_mmay3_d[l_ac].* = g_mmay3_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身3)
               
               
               #add-point:單身page3修改前
               let g_master.mmaydocno=g_mmay_d[g_master_idx].mmaydocno
               #end add-point
               
               UPDATE mmaz_t SET (mmazseq,mmaz002,mmaz003,mmaz004,mmaz005,mmaz001,mmaz006,mmaz007) = (g_mmay3_d[l_ac].mmazseq, 
                   g_mmay3_d[l_ac].mmaz002,g_mmay3_d[l_ac].mmaz003,g_mmay3_d[l_ac].mmaz004,g_mmay3_d[l_ac].mmaz005, 
                   g_mmay3_d[l_ac].mmaz001,g_mmay3_d[l_ac].mmaz006,g_mmay3_d[l_ac].mmaz007) #自訂欄位頁簽 
 
                WHERE mmazent = g_enterprise AND
                   mmazdocno = g_master.mmaydocno
                   AND mmazseq = g_mmay3_d_t.mmazseq
                   
               #add-point:單身修改中
               
               #end add-point
                   
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL cl_err("mmaz_t","std-00009",1)
                     CALL s_transaction_end('N','0')
                     LET g_mmay3_d[l_ac].* = g_mmay3_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     CALL cl_err("mmaz_t",SQLCA.sqlcode,1)  
                     CALL s_transaction_end('N','0')
                     LET g_mmay3_d[l_ac].* = g_mmay3_d_t.*
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmay_d[g_detail_idx].mmaydocno
               LET gs_keys_bak[1] = g_mmay_d[g_detail_idx].mmaydocno
               LET gs_keys[2] = g_mmay3_d[g_detail_idx2].mmazseq
               LET gs_keys_bak[2] = g_mmay3_d_t.mmazseq
               CALL ammp403_update_b('mmaz_t',gs_keys,gs_keys_bak,"'3'")
                     #資料多語言用-增/改
                     
               END CASE
               #add-point:單身page3修改後
               
               #end add-point
            END IF
         
         #---------------------<  Detail: page3  >---------------------
         #----<<mmazseq>>----
         #此段落由子樣板a02產生
         AFTER FIELD mmazseq
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_mmay3_d[l_ac].mmazseq,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD mmazseq
            END IF
 
 
            #add-point:AFTER FIELD mmazseq
            
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD mmazseq
            #add-point:BEFORE FIELD mmazseq
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE mmazseq
            #add-point:ON CHANGE mmazseq
            
            #END add-point
 
         #----<<mmaz002>>----
         #此段落由子樣板a02產生
         AFTER FIELD mmaz002
            
            #add-point:AFTER FIELD mmaz002
            LET g_mmay3_d[l_ac].mmaz002_desc = NULL
            DISPLAY BY NAME g_mmay3_d[l_ac].mmaz002_desc
            
            IF NOT cl_null(g_mmay3_d[l_ac].mmaz002) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_mmay3_d[l_ac].mmaz002!= g_mmay3_d_t.mmaz002 OR g_mmay3_d_t.mmaz002 IS NULL  ))) THEN 
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
 
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_mmay3_d[l_ac].mmaz002
                  LET g_chkparam.arg2 = '2'
                  LET g_chkparam.arg3 = g_site


                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooed004") THEN

                  ELSE
                     #檢查失敗時後續處理
                     LET g_mmay3_d[l_ac].mmaz002 = g_mmay3_d_t.mmaz002
                     CALL ammp403_mmaz002_ref()
                     NEXT FIELD mmaz002
                  END IF
               END IF
            END IF
            CALL ammp403_mmaz002_ref()

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD mmaz002
            #add-point:BEFORE FIELD mmaz002
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE mmaz002
            #add-point:ON CHANGE mmaz002
            
            #END add-point
 
         #----<<mmaz003>>----
         #此段落由子樣板a02產生
         AFTER FIELD mmaz003
            
            #add-point:AFTER FIELD mmaz003
            LET g_mmay3_d[l_ac].mmaz003_desc = NULL
            DISPLAY BY NAME g_mmay3_d[l_ac].mmaz003_desc
            
            IF NOT cl_null(g_mmay3_d[l_ac].mmaz003) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_mmay3_d[l_ac].mmaz003!= g_mmay3_d_t.mmaz003 OR g_mmay3_d_t.mmaz003 IS NULL  ))) THEN 
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
 
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_mmay3_d[l_ac].mmaz002
                  LET g_chkparam.arg2 = g_mmay3_d[l_ac].mmaz003


                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_inaa001") THEN

                  ELSE
                     #檢查失敗時後續處理
                     LET g_mmay3_d[l_ac].mmaz003 = g_mmay3_d_t.mmaz003
                     CALL ammp403_mmaz003_ref()
                     NEXT FIELD mmaz003
                  END IF
               END IF
            END IF
            CALL ammp403_mmaz003_ref()
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmay3_d[l_ac].mmaz003
            CALL ap_ref_array2(g_ref_fields,"SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaa001=? ","") RETURNING g_rtn_fields
            LET g_mmay3_d[l_ac].mmaz003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mmay3_d[l_ac].mmaz003_desc

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD mmaz003
            #add-point:BEFORE FIELD mmaz003
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE mmaz003
            #add-point:ON CHANGE mmaz003
            
            #END add-point
 
         #----<<mmaz004>>----
         #此段落由子樣板a02產生
         AFTER FIELD mmaz004
            
            #add-point:AFTER FIELD mmaz004
            
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD mmaz004
            #add-point:BEFORE FIELD mmaz004
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE mmaz004
            #add-point:ON CHANGE mmaz004
            
            #END add-point
 
         #----<<mmaz005>>----
         #此段落由子樣板a02產生
         AFTER FIELD mmaz005
            
            #add-point:AFTER FIELD mmaz005
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmay3_d[l_ac].mmaz005
            CALL ap_ref_array2(g_ref_fields,"SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaa001=? ","") RETURNING g_rtn_fields
            LET g_mmay3_d[l_ac].mmaz005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mmay3_d[l_ac].mmaz005_desc

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD mmaz005
            #add-point:BEFORE FIELD mmaz005
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE mmaz005
            #add-point:ON CHANGE mmaz005
            
            #END add-point
 
         #----<<mmaz001>>----
         #此段落由子樣板a02產生
         AFTER FIELD mmaz001
            
            #add-point:AFTER FIELD mmaz001
            
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD mmaz001
            #add-point:BEFORE FIELD mmaz001
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE mmaz001
            #add-point:ON CHANGE mmaz001
            
            #END add-point
 
         #----<<mmaz006>>----
         #此段落由子樣板a02產生
         AFTER FIELD mmaz006
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_mmay3_d[l_ac].mmaz006,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD mmaz006
            END IF
 
 
            #add-point:AFTER FIELD mmaz006
            
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD mmaz006
            #add-point:BEFORE FIELD mmaz006
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE mmaz006
            #add-point:ON CHANGE mmaz006
            
            #END add-point
 
         #----<<mmaz007>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmaz007
            #add-point:BEFORE FIELD mmaz007
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmaz007
            
            #add-point:AFTER FIELD mmaz007
            IF NOT cl_ap_chk_Range(g_mmay3_d[l_ac].mmaz007,"0","1","","","azz-00079",1) THEN
               let g_mmay3_d[l_ac].mmaz007 = g_mmay3_d_t.mmaz007
               NEXT FIELD mmaz007
            END IF
            IF NOT cl_null(g_mmay3_d[l_ac].mmaz007) THEN
               IF g_mmay3_d[l_ac].mmaz007<> g_mmay3_d[l_ac].mmaz006 THEN
                  IF cl_ask_confirm('art-00220') THEN
                  ELSE
                     NEXT FIELD mmaz007
                  END IF
               END IF
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmaz007
            #add-point:ON CHANGE mmaz007
            
            #END add-point
 
 
         #---------------------<  Detail: page3  >---------------------
         #----<<mmazseq>>----
         #Ctrlp:input.c.page3.mmazseq
#         ON ACTION controlp INFIELD mmazseq
            #add-point:ON ACTION controlp INFIELD mmazseq
            
            #END add-point
 
         #----<<mmaz002>>----
         #Ctrlp:input.c.page3.mmaz002
         ON ACTION controlp INFIELD mmaz002
            #add-point:ON ACTION controlp INFIELD mmaz002
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mmay3_d[l_ac].mmaz002            #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_site #
            LET g_qryparam.arg2 = "2" #

            CALL q_ooed004()                                #呼叫開窗

            LET g_mmay3_d[l_ac].mmaz002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_mmay3_d[l_ac].mmaz002 TO mmaz002              #顯示到畫面上
            CALL ammp403_mmaz002_ref()
            NEXT FIELD mmaz002                          #返回原欄位
            #END add-point
 
         #----<<mmaz003>>----
         #Ctrlp:input.c.page3.mmaz003
         ON ACTION controlp INFIELD mmaz003
            #add-point:ON ACTION controlp INFIELD mmaz003
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mmay3_d[l_ac].mmaz003             #給予default值
            LET g_qryparam.where = "inaasite = '",g_mmay3_d[l_ac].mmaz002,"'"
            #給予arg

            CALL q_inaa001_3()                                #呼叫開窗

            LET g_mmay3_d[l_ac].mmaz003 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_qryparam.where = NULL 
            DISPLAY g_mmay3_d[l_ac].mmaz003 TO mmaz003              #顯示到畫面上
            call ammp403_mmaz003_ref()
            #END add-point
 
         #----<<mmaz004>>----
         #Ctrlp:input.c.page3.mmaz004
#         ON ACTION controlp INFIELD mmaz004
            #add-point:ON ACTION controlp INFIELD mmaz004
            
            #END add-point
 
         #----<<mmaz005>>----
         #Ctrlp:input.c.page3.mmaz005
#         ON ACTION controlp INFIELD mmaz005
            #add-point:ON ACTION controlp INFIELD mmaz005
            
            #END add-point
 
         #----<<mmaz001>>----
         #Ctrlp:input.c.page3.mmaz001
#         ON ACTION controlp INFIELD mmaz001
            #add-point:ON ACTION controlp INFIELD mmaz001
            
            #END add-point
 
         #----<<mmaz006>>----
         #Ctrlp:input.c.page3.mmaz006
#         ON ACTION controlp INFIELD mmaz006
            #add-point:ON ACTION controlp INFIELD mmaz006
            
            #END add-point
 
         #----<<mmaz007>>----
         #Ctrlp:input.c.page3.mmaz007
#         ON ACTION controlp INFIELD mmaz007
            #add-point:ON ACTION controlp INFIELD mmaz007
            
            #END add-point
 
 
 
         AFTER ROW
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CALL cl_err('',9001,0)
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_mmay3_d[l_ac].* = g_mmay3_d_t.*
               END IF
               CLOSE ammp403_bcl2
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
 
            CALL ammp403_unlock_b("mmaz_t")
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #add-point:input段after input 
            
            #end add-point   
 
         ON ACTION controlo   
            CALL FGL_SET_ARR_CURR(g_mmay3_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_mmay3_d.getLength()+1
 
      END INPUT
 
 
      
      DISPLAY ARRAY g_mmay2_d TO s_detail2.*
         ATTRIBUTES(COUNT=g_detail_cnt)  
      
         BEFORE DISPLAY 
            CALL FGL_SET_ARR_CURR(g_detail_idx)
            CALL ammp403_b_fill(g_wc)
        
         BEFORE ROW
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            CALL cl_show_fld_cont() 
            CALL ammp403_fetch()
            LET g_current_page = 2
            CALL ammp403_idx_chk('m')
            
         #add-point:page2自定義行為
         
         #end add-point
            
      END DISPLAY
 
 
    
 
      
      #add-point:input段input_array"
      
      #end add-point
      
      BEFORE DIALOG 
         LET g_curr_diag = ui.DIALOG.getCurrent()
         IF g_detail_idx > 0 THEN
            IF g_detail_idx > g_mmay_d.getLength() THEN
               LET g_detail_idx = g_mmay_d.getLength()
            END IF
            CALL DIALOG.setCurrentRow("s_detail1", g_detail_idx)
            LET l_ac = g_detail_idx
         END IF 
         LET g_detail_idx = l_ac
         #add-point:input段input_array"
         
         #end add-point
         #先確定單頭(第一單身)是否有資料
         IF g_mmay_d.getLength() > 0 THEN
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD sel
               WHEN "s_detail2"
                  NEXT FIELD mmaydocno_2
 
               WHEN "s_detail3"
                  NEXT FIELD mmazseq
 
 
            END CASE
         ELSE
            NEXT FIELD sel
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
 
   CLOSE ammp403_bcl
   CALL s_transaction_end('Y','0')
   
END FUNCTION
 
{</section>}
 
{<section id="ammp403.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION ammp403_b_fill(p_wc2)
   DEFINE p_wc2           STRING
   #add-point:b_fill段define
   
   #end add-point
 
   #add-point:b_fill段sql_before
   
   #end add-point
   
   LET g_sql = "SELECT  UNIQUE '',mmaydocno,mmay002,'',mmay001,'',mmaysite,'',mmaystus,mmaydocno,mmayownid, 
       '',mmayowndp,'',mmaycrtid,'',mmaycrtdp,'',mmaycrtdt,mmaymodid,'',mmaymoddt,mmaycnfid,'',mmaycnfdt FROM mmay_t", 
 
 
               " LEFT JOIN mmaz_t ON mmazent = mmayent AND mmaydocno = mmazdocno",
 
 
               "",
               " WHERE mmayent= ? AND 1=1 AND ", p_wc2
    
   LET g_sql = g_sql, " ORDER BY mmay_t.mmaydocno"
  
   #add-point:b_fill段sql_after
   LET g_sql = "SELECT  UNIQUE 'N',mmaydocno,mmay002,'',mmay001,'',mmaysite,'',mmaystus,'',mmayownid, 
               '',mmayowndp,'',mmaycrtid,'',mmaycrtdp,'',mmaycrtdt,mmaymodid,'',mmaymoddt,mmaycnfid,'',mmaycnfdt FROM mmay_t",  
               " LEFT JOIN mmaz_t ON mmazent = mmayent AND mmaydocno = mmazdocno",
 
 
               "",
               " WHERE mmayent= ? AND 1=1 AND ", p_wc2
   let g_sql = g_sql, " AND mmay001 = '",g_site,"' AND mmaystus='Y' "
   LET g_sql = g_sql, " ORDER BY mmay_t.mmaydocno"
   #end add-point
  
   PREPARE ammp403_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR ammp403_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_mmay_d.clear()
   CALL g_mmay2_d.clear()   
 
   CALL g_mmay3_d.clear()   
 
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_mmay_d[l_ac].sel,g_mmay_d[l_ac].mmaydocno,g_mmay_d[l_ac].mmay002,g_mmay_d[l_ac].mmay002_desc, 
       g_mmay_d[l_ac].mmay001,g_mmay_d[l_ac].mmay001_desc,g_mmay_d[l_ac].mmaysite,g_mmay_d[l_ac].mmaysite_desc, 
       g_mmay_d[l_ac].mmaystus,g_mmay2_d[l_ac].mmaydocno,g_mmay2_d[l_ac].mmayownid,g_mmay2_d[l_ac].mmayownid_desc, 
       g_mmay2_d[l_ac].mmayowndp,g_mmay2_d[l_ac].mmayowndp_desc,g_mmay2_d[l_ac].mmaycrtid,g_mmay2_d[l_ac].mmaycrtid_desc, 
       g_mmay2_d[l_ac].mmaycrtdp,g_mmay2_d[l_ac].mmaycrtdp_desc,g_mmay2_d[l_ac].mmaycrtdt,g_mmay2_d[l_ac].mmaymodid, 
       g_mmay2_d[l_ac].mmaymodid_desc,g_mmay2_d[l_ac].mmaymoddt,g_mmay2_d[l_ac].mmaycnfid,g_mmay2_d[l_ac].mmaycnfid_desc, 
       g_mmay2_d[l_ac].mmaycnfdt
      IF SQLCA.sqlcode THEN
         CALL cl_err("FOREACH:",SQLCA.sqlcode,1)
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充
      
      #end add-point
      
      CALL ammp403_detail_show()      
 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec AND g_error_show = 1 THEN
         CALL cl_err( "", 9035, 1 )
         EXIT FOREACH
      END IF
      
   END FOREACH
   LET g_error_show = 0
   
 
   CALL g_mmay_d.deleteElement(g_mmay_d.getLength())   
   CALL g_mmay2_d.deleteElement(g_mmay2_d.getLength())
 
   CALL g_mmay3_d.deleteElement(g_mmay3_d.getLength())
 
 
   #將key欄位填到每個page
   FOR g_detail_idx = 1 TO g_mmay_d.getLength()
      LET g_mmay2_d[g_detail_idx].mmaydocno = g_mmay_d[g_detail_idx].mmaydocno 
 
      #LET g_mmay3_d[g_detail_idx2].mmazseq = g_mmay_d[g_detail_idx].mmaydocno 
 
 
   END FOR
   LET g_detail_idx = 1
   
   #add-point:b_fill段資料填充(其他單身)
   
   #end add-point
    
   LET g_detail_cnt = l_ac - 1
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE ammp403_pb
   
   LET l_ac = 1
   IF g_mmay_d.getLength() > 0 THEN
      CALL ammp403_fetch()
   END IF
   
END FUNCTION
 
{</section>}
 
{<section id="ammp403.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION ammp403_fetch()
   DEFINE li_ac           LIKE type_t.num5
   #add-point:fetch段define
   
   #end add-point
   
   #判定單頭是否有資料
   IF cl_null(g_mmay_d[g_detail_idx].mmaydocno) THEN
      RETURN
   END IF
   
   #CALL g_mmay2_d.clear()
 
   CALL g_mmay3_d.clear()
 
 
   
   LET li_ac = l_ac 
   
   LET g_sql = "SELECT  UNIQUE mmazseq,mmaz002,'',mmaz003,'',mmaz004,'',mmaz005,'',mmaz001,'',mmaz006, 
       mmaz007 FROM mmaz_t",    
               "",
               " WHERE mmazent=? AND mmazdocno=?"
 
   IF NOT cl_null(g_wc2_table2) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
   END IF
 
   LET g_sql = g_sql, " ORDER BY mmaz_t.mmazseq" 
                      
   #add-point:單身填充前
   
   #end add-point
   
   PREPARE ammp403_pb2 FROM g_sql
   DECLARE b_fill_curs2 CURSOR FOR ammp403_pb2
   
   OPEN b_fill_curs2 USING g_enterprise,g_mmay_d[g_detail_idx].mmaydocno
 
   LET l_ac = 1
   FOREACH b_fill_curs2 INTO g_mmay3_d[l_ac].mmazseq,g_mmay3_d[l_ac].mmaz002,g_mmay3_d[l_ac].mmaz002_desc, 
       g_mmay3_d[l_ac].mmaz003,g_mmay3_d[l_ac].mmaz003_desc,g_mmay3_d[l_ac].mmaz004,g_mmay3_d[l_ac].mmaz004_desc, 
       g_mmay3_d[l_ac].mmaz005,g_mmay3_d[l_ac].mmaz005_desc,g_mmay3_d[l_ac].mmaz001,g_mmay3_d[l_ac].mmaz001_desc, 
       g_mmay3_d[l_ac].mmaz006,g_mmay3_d[l_ac].mmaz007
      IF SQLCA.sqlcode THEN
         CALL cl_err("FOREACH:",SQLCA.sqlcode,1)
         EXIT FOREACH
      END IF
      
      #add-point:b_fill段資料填充
      call ammp403_mmaz001_ref()
      call ammp403_mmaz002_ref()
      call ammp403_mmaz003_ref()
      call ammp403_mmaz004_ref()
      call ammp403_mmaz005_ref()
      #end add-point
      
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
      
   END FOREACH
 
 
 
   #add-point:單身填充後
   
   #end add-point
   
   #CALL g_mmay2_d.deleteElement(g_mmay2_d.getLength())   
 
   CALL g_mmay3_d.deleteElement(g_mmay3_d.getLength())   
 
 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="ammp403.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION ammp403_detail_show()
   #add-point:show段define
   DEFINE l_ac_t LIKE type_t.num10 #l_ac暫存用
   #end add-point
 
   #add-point:detail_show段之前
   LET l_ac_t = l_ac
   #end add-point
   
   
   
   #帶出公用欄位reference值page1
   
    
   #帶出公用欄位reference值page2
   #此段落由子樣板a12產生
      #LET g_mmay2_d[l_ac].mmayownid_desc = cl_get_username(g_mmay2_d[l_ac].mmayownid)
      #LET g_mmay2_d[l_ac].mmayowndp_desc = cl_get_deptname(g_mmay2_d[l_ac].mmayowndp)
      #LET g_mmay2_d[l_ac].mmaycrtid_desc = cl_get_username(g_mmay2_d[l_ac].mmaycrtid)
      #LET g_mmay2_d[l_ac].mmaycrtdp_desc = cl_get_deptname(g_mmay2_d[l_ac].mmaycrtdp)
      #LET g_mmay2_d[l_ac].mmaymodid_desc = cl_get_username(g_mmay2_d[l_ac].mmaymodid)
      #LET g_mmay2_d[l_ac].mmaycnfid_desc = cl_get_deptname(g_mmay2_d[l_ac].mmaycnfid)
      ##LET .mmaypstid_desc = cl_get_deptname(.mmaypstid)
      
 
 
 
   #帶出公用欄位reference值page3
   
 
 
   
   #讀入ref值
   #add-point:show段單身reference
   FOR l_ac = 1 TO g_mmay_d.getLength()
      #add-point:ref_show段d_reference
       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = g_mmay_d[l_ac].mmaysite
       CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET g_mmay_d[l_ac].mmaysite_desc = '', g_rtn_fields[1] , ''
       DISPLAY BY NAME g_mmay_d[l_ac].mmaysite_desc
       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = g_mmay_d[l_ac].mmay001
       CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET g_mmay_d[l_ac].mmay001_desc = '', g_rtn_fields[1] , ''
       DISPLAY BY NAME g_mmay_d[l_ac].mmay001_desc
       
       

      #end add-point
   END FOR
   for l_ac = 1 to g_mmay2_d.getLength()
       INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmay2_d[l_ac].mmayownid
            CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM oofa_t WHERE oofaent='"||g_enterprise||"' AND oofa002='2' AND oofa003=? ","") RETURNING g_rtn_fields
            LET g_mmay2_d[l_ac].mmayownid_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_mmay2_d[l_ac].mmayownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmay2_d[l_ac].mmayowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mmay2_d[l_ac].mmayowndp_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_mmay2_d[l_ac].mmayowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmay2_d[l_ac].mmaycrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM oofa_t WHERE oofaent='"||g_enterprise||"' AND oofa002='2' AND oofa003=? ","") RETURNING g_rtn_fields
            LET g_mmay2_d[l_ac].mmaycrtid_desc =  g_rtn_fields[1]
            DISPLAY BY NAME g_mmay2_d[l_ac].mmaycrtid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmay2_d[l_ac].mmaycrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mmay2_d[l_ac].mmaycrtdp_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_mmay2_d[l_ac].mmaycrtdp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmay2_d[l_ac].mmaymodid
            CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM oofa_t WHERE oofaent='"||g_enterprise||"' AND oofa002='2' AND oofa003=? ","") RETURNING g_rtn_fields
            LET g_mmay2_d[l_ac].mmaymodid_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_mmay2_d[l_ac].mmaymodid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmay2_d[l_ac].mmaycnfid
            CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM oofa_t WHERE oofaent='"||g_enterprise||"' AND oofa002='2' AND oofa003=? ","") RETURNING g_rtn_fields
            LET g_mmay2_d[l_ac].mmaycnfid_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_mmay2_d[l_ac].mmaycnfid_desc
   end for
   FOR l_ac = 1 TO g_mmay3_d.getLength()
      #add-point:ref_show段d_reference
       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = g_mmay3_d[l_ac].mmaz002
       CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET g_mmay3_d[l_ac].mmaz002_desc = '', g_rtn_fields[1] , ''
       DISPLAY BY NAME g_mmay3_d[l_ac].mmaz002_desc
       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = g_mmay3_d[l_ac].mmaz004
       CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET g_mmay3_d[l_ac].mmaz004_desc = '', g_rtn_fields[1] , ''
       DISPLAY BY NAME g_mmay3_d[l_ac].mmaz004_desc
       SELECT inaa002 INTO g_mmay3_d[l_ac].mmaz003_desc FROM inaa_t
        WHERE inaa001 = g_mmay3_d[l_ac].mmaz003 AND inaaent=g_enterprise
       SELECT inaa002 INTO g_mmay3_d[l_ac].mmaz005_desc FROM inaa_t
        WHERE inaa001 = g_mmay3_d[l_ac].mmaz005 AND inaaent=g_enterprise
       DISPLAY BY NAME g_mmay3_d[l_ac].mmaz003_desc
       DISPLAY BY NAME g_mmay3_d[l_ac].mmaz005_desc 
       SELECT mmanl003 INTO g_mmay3_d[l_ac].mmaz001_desc FROM mmaz_t
        WHERE mmanl001 =  g_mmay3_d[l_ac].mmaz001 AND mmanl002 = g_dlang
          AND mmanlent =  g_enterprise
       DISPLAY BY NAME g_mmay3_d[l_ac].mmaz001_desc          
       

      #end add-point
   END FOR
   #end add-point
   
   #add-point:show段單身reference
   
   #end add-point
 
   #add-point:show段單身reference
   
   #end add-point
 
 
   
   #add-point:detail_show段之後
   LET l_ac = l_ac_t 
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="ammp403.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION ammp403_set_entry_b(p_cmd)                                                  
   DEFINE p_cmd   LIKE type_t.chr1         
   #add-point:set_entry_b段define
   
   #end add-point
   
   #add-point:set_entry段欄位控制後
   
   #end add-point 
                                                                     
END FUNCTION                                                                    
 
{</section>}
 
{<section id="ammp403.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION ammp403_set_no_entry_b(p_cmd)                                               
   DEFINE p_cmd   LIKE type_t.chr1           
   #add-point:set_no_entry_b段define
   
   #end add-point
   
   #add-point:set_no_entry段欄位控制後
   
   #end add-point 
                                                                          
END FUNCTION  
 
{</section>}
 
{<section id="ammp403.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION ammp403_default_search()
   DEFINE li_idx  LIKE type_t.num5
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE ls_wc   STRING
   #add-point:default_search段define
   
   #end add-point  
   
   IF NOT cl_null(g_argv[1]) THEN
      LET ls_wc = ls_wc, " mmaydocno = '", g_argv[1], "' AND "
   END IF
   
 
   
   IF NOT cl_null(ls_wc) THEN
      LET ls_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_wc = ls_wc
   ELSE
      LET g_wc = " 1=1"
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="ammp403.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION ammp403_delete_b(ps_table,ps_keys_bak,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:delete_b段define
   
   #end add-point     
 
   #判斷是否是同一群組的table
   LET ls_group = "mmay_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:delete_b段刪除前
      
      #end add-point  
      DELETE FROM mmay_t
       WHERE mmayent = g_enterprise AND
         mmaydocno = ps_keys_bak[1]
      #add-point:delete_b段刪除中
      
      #end add-point  
      IF SQLCA.sqlcode THEN
         CALL cl_err("",SQLCA.sqlcode,0)
      END IF
      #add-point:delete_b段刪除後
      
      #end add-point  
   END IF
   
 
   
   LET ls_group = "mmaz_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:delete_b段刪除前
      
      #end add-point  
      DELETE FROM mmaz_t
       WHERE mmazent = g_enterprise AND
         mmazdocno = ps_keys_bak[1] AND mmazseq = ps_keys_bak[2]
      #add-point:delete_b段刪除中
      
      #end add-point  
      IF SQLCA.sqlcode THEN
         CALL cl_err("mmaz_t",SQLCA.sqlcode,0)
      END IF
      #add-point:delete_b段刪除後
      
      #end add-point  
      RETURN
   END IF
 
 
   
   #單頭刪除, 連帶刪除單身
   LET ls_group = "mmay_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:delete_b段刪除前
      
      #end add-point  
      DELETE FROM mmaz_t
       WHERE mmazent = g_enterprise AND
         mmazdocno = ps_keys_bak[1]
      #add-point:delete_b段刪除中
      
      #end add-point  
      IF SQLCA.sqlcode THEN
         CALL cl_err("mmaz_t",SQLCA.sqlcode,0)
      END IF
      #add-point:delete_b段刪除後
      
      #end add-point  
      RETURN
   END IF
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="ammp403.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION ammp403_insert_b(ps_table,ps_keys,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:insert_b段define
   
   #end add-point
 
   #判斷是否是同一群組的table
   LET ls_group = "mmay_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:insert_b段新增前
      
      #end add-point
      INSERT INTO mmay_t
                  (mmayent,
                   mmaydocno
                   ,mmay002,mmay001,mmaysite,mmaystus,mmayownid,mmayowndp,mmaycrtid,mmaycrtdp,mmaycrtdt,mmaymodid,mmaymoddt,mmaycnfid,mmaycnfdt) 
            VALUES(g_enterprise,
                   ps_keys[1]
                   ,g_mmay_d[g_detail_idx].mmay002,g_mmay_d[g_detail_idx].mmay001,g_mmay_d[g_detail_idx].mmaysite, 
                       g_mmay_d[g_detail_idx].mmaystus,g_mmay2_d[g_detail_idx].mmayownid,g_mmay2_d[g_detail_idx].mmayowndp, 
                       g_mmay2_d[g_detail_idx].mmaycrtid,g_mmay2_d[g_detail_idx].mmaycrtdp,g_mmay2_d[g_detail_idx].mmaycrtdt, 
                       g_mmay2_d[g_detail_idx].mmaymodid,g_mmay2_d[g_detail_idx].mmaymoddt,g_mmay2_d[g_detail_idx].mmaycnfid, 
                       g_mmay2_d[g_detail_idx].mmaycnfdt)
      #add-point:insert_b段新增中
      
      #end add-point
      IF SQLCA.sqlcode THEN
         CALL cl_err("mmay_t",SQLCA.sqlcode,0)
      END IF
      #add-point:insert_b段新增後
      
      #end add-point
   END IF
   
 
   
   LET ls_group = "mmaz_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:insert_b段新增前
      
      #end add-point
      INSERT INTO mmaz_t
                  (mmazent,
                   mmazdocno,mmazseq
                   ,mmaz002,mmaz003,mmaz004,mmaz005,mmaz001,mmaz006,mmaz007) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_mmay3_d[g_detail_idx2].mmaz002,g_mmay3_d[g_detail_idx2].mmaz003,g_mmay3_d[g_detail_idx2].mmaz004, 
                       g_mmay3_d[g_detail_idx2].mmaz005,g_mmay3_d[g_detail_idx2].mmaz001,g_mmay3_d[g_detail_idx2].mmaz006, 
                       g_mmay3_d[g_detail_idx2].mmaz007)
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
 
{<section id="ammp403.update_b" >} 
#+ 修改單身後其他table連動
PRIVATE FUNCTION ammp403_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "mmay_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "mmay_t" THEN
   
      #add-point:update_b段修改前
      
      #end add-point     
   
      UPDATE mmay_t 
         SET (mmaydocno
              ,mmay002,mmay001,mmaysite,mmaystus,mmayownid,mmayowndp,mmaycrtid,mmaycrtdp,mmaycrtdt,mmaymodid,mmaymoddt,mmaycnfid,mmaycnfdt) 
              = 
             (ps_keys[1]
              ,g_mmay_d[g_detail_idx].mmay002,g_mmay_d[g_detail_idx].mmay001,g_mmay_d[g_detail_idx].mmaysite, 
                  g_mmay_d[g_detail_idx].mmaystus,g_mmay2_d[g_detail_idx].mmayownid,g_mmay2_d[g_detail_idx].mmayowndp, 
                  g_mmay2_d[g_detail_idx].mmaycrtid,g_mmay2_d[g_detail_idx].mmaycrtdp,g_mmay2_d[g_detail_idx].mmaycrtdt, 
                  g_mmay2_d[g_detail_idx].mmaymodid,g_mmay2_d[g_detail_idx].mmaymoddt,g_mmay2_d[g_detail_idx].mmaycnfid, 
                  g_mmay2_d[g_detail_idx].mmaycnfdt) 
         WHERE mmaydocno = ps_keys_bak[1]
 
      #add-point:update_b段修改中
      
      #end add-point 
         
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            CALL cl_err("mmay_t","std-00009",1)
            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            CALL cl_err("mmay_t",SQLCA.sqlcode,1)  
            CALL s_transaction_end('N','0')
         OTHERWISE
            
      END CASE
 
      #add-point:update_b段修改後
      
      #end add-point
      
      RETURN
   END IF
   
 
   
   LET ls_group = "mmaz_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "mmaz_t" THEN
   
      #add-point:update_b段修改前
      
      #end add-point    
      
      UPDATE mmaz_t 
         SET (mmazdocno,mmazseq
              ,mmaz002,mmaz003,mmaz004,mmaz005,mmaz001,mmaz006,mmaz007) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_mmay3_d[g_detail_idx2].mmaz002,g_mmay3_d[g_detail_idx2].mmaz003,g_mmay3_d[g_detail_idx2].mmaz004, 
                  g_mmay3_d[g_detail_idx2].mmaz005,g_mmay3_d[g_detail_idx2].mmaz001,g_mmay3_d[g_detail_idx2].mmaz006, 
                  g_mmay3_d[g_detail_idx2].mmaz007) 
         WHERE mmazdocno = ps_keys_bak[1] AND mmazseq = ps_keys_bak[2]
 
      #add-point:update_b段修改中
      
      #end add-point 
         
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            CALL cl_err("mmaz_t","std-00009",1)
            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            CALL cl_err("mmaz_t",SQLCA.sqlcode,1)  
            CALL s_transaction_end('N','0')
         OTHERWISE
            
      END CASE
      
      #add-point:update_b段修改後
      
      #end add-point 
      
      RETURN
   END IF
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="ammp403.key_update_b" >}
#+ 單頭key欄位變動後, 連帶修正其他單身table
PRIVATE FUNCTION ammp403_key_update_b()
   DEFINE li_idx           LIKE type_t.num5 
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   #add-point:update_b段define
   
   #end add-point
 
   #判斷key是否有改變
   LET lb_chk = TRUE
   
   IF g_master.mmaydocno <> g_master_t.mmaydocno THEN
      LET lb_chk = FALSE
   END IF
 
   #不需要做處理
   IF lb_chk THEN
      RETURN
   END IF
    
   #add-point:update_b段修改前
   
   #end add-point
   
   UPDATE mmaz_t 
      SET (mmazdocno) 
           = 
          (g_master.mmaydocno) 
      WHERE 
           mmazdocno = g_master_t.mmaydocno
 
           
   #add-point:update_b段修改中
   
   #end add-point
           
   CASE
      #WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
      #   CALL cl_err("mmaz_t","std-00009",1)
      #   CALL s_transaction_end('N','0')
      WHEN SQLCA.sqlcode #其他錯誤
         CALL cl_err("mmaz_t",SQLCA.sqlcode,1)  
         CALL s_transaction_end('N','0')
      OTHERWISE
         #若有多語言table資料一同更新
         
   END CASE
   
   #add-point:update_b段修改後
   
   #end add-point
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="ammp403.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION ammp403_lock_b(ps_table)
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define
   
   #end add-point   
   
   #先刷新資料
   #CALL ammp403_b_fill(g_wc)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "mmay_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN ammp403_bcl USING g_enterprise,
                                       g_mmay_d[g_detail_idx].mmaydocno
                                       
      IF SQLCA.sqlcode THEN
         CALL cl_err("ammp403_bcl",SQLCA.sqlcode,1)
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   #鎖定整組table
   #LET ls_group = "mmaz_t,"
   #僅鎖定自身table
   LET ls_group = "mmaz_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN ammp403_bcl2 USING g_enterprise,
                                             g_master.mmaydocno,
                                             g_mmay3_d[g_detail_idx2].mmazseq
      IF SQLCA.sqlcode THEN
         CALL cl_err("ammp403_bcl2",SQLCA.sqlcode,1)
         RETURN FALSE
      END IF
   END IF
 
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="ammp403.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION ammp403_unlock_b(ps_table)
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:unlock_b段define
   
   #end add-point  
   
   LET ls_group = ""
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      CLOSE ammp403_bcl
   END IF
   
 
    
   LET ls_group = "mmaz_t,"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      CLOSE ammp403_bcl2
   END IF
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="ammp403.idx_chk" >}
#+ 單身筆數變更
PRIVATE FUNCTION ammp403_idx_chk(ps_loc)
   DEFINE ps_loc   LIKE type_t.chr10
   DEFINE li_idx   LIKE type_t.num5
   DEFINE li_cnt   LIKE type_t.num5
   #add-point:idx_chk段define
   
   #end add-point  
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_mmay_d.getLength() THEN
         LET g_detail_idx = g_mmay_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_mmay_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      LET li_idx = g_detail_idx
      LET li_cnt = g_mmay_d.getLength()
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_mmay2_d.getLength() THEN
         LET g_detail_idx = g_mmay2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_mmay2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      LET li_idx = g_detail_idx
      LET li_cnt = g_mmay2_d.getLength()
   END IF
 
   IF g_current_page = 3 THEN
      LET g_detail_idx2 = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx2 > g_mmay3_d.getLength() THEN
         LET g_detail_idx2 = g_mmay3_d.getLength()
      END IF
      IF g_detail_idx2 = 0 AND g_mmay3_d.getLength() <> 0 THEN
         LET g_detail_idx2 = 1
      END IF
      LET li_idx = g_detail_idx2
      LET li_cnt = g_mmay3_d.getLength()
   END IF
 
 
    
   IF ps_loc = 'm' THEN
      DISPLAY li_idx TO FORMONLY.h_index
      DISPLAY li_cnt TO FORMONLY.h_count
      IF g_mmay3_d.getLength() = 0 THEN
         DISPLAY '' TO FORMONLY.idx
         DISPLAY '' TO FORMONLY.cnt
      ELSE
         DISPLAY 1 TO FORMONLY.idx
         DISPLAY g_mmay3_d.getLength() TO FORMONLY.cnt
      END IF
 
 
   ELSE
      DISPLAY li_idx TO FORMONLY.idx
      DISPLAY li_cnt TO FORMONLY.cnt
   END IF
   
   #add-point:idx_chk段other
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="ammp403.state_change" >}
    
 
{</section>}
 
{<section id="ammp403.func_signature" >}
   
 
{</section>}
 
{<section id="ammp403.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="ammp403.other_function" readonly="Y" >}
#disply mmaz002
PRIVATE FUNCTION ammp403_mmaz002_ref()
   INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = g_mmay3_d[l_ac].mmaz002
       CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET g_mmay3_d[l_ac].mmaz002_desc = '', g_rtn_fields[1] , ''
       DISPLAY  g_mmay3_d[l_ac].mmaz002_desc to s_detail3[l_ac].mmaz002_desc
             
END FUNCTION
#display mmaz003
PRIVATE FUNCTION ammp403_mmaz003_ref()
   SELECT inaa002 INTO g_mmay3_d[l_ac].mmaz003_desc FROM inaa_t
    WHERE inaa001 = g_mmay3_d[l_ac].mmaz003 AND inaaent=g_enterprise
   DISPLAY  g_mmay3_d[l_ac].mmaz003_desc to s_detail3[l_ac].mmaz003_desc    
END FUNCTION
#display mmaz005
PRIVATE FUNCTION ammp403_mmaz005_ref()
   SELECT inaa002 INTO g_mmay3_d[l_ac].mmaz005_desc FROM inaa_t
    WHERE inaa001 = g_mmay3_d[l_ac].mmaz005 AND inaaent=g_enterprise
   DISPLAY  g_mmay3_d[l_ac].mmaz005_desc to s_detail3[l_ac].mmaz005_desc
END FUNCTION
#display mmaz004
PRIVATE FUNCTION ammp403_mmaz004_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mmay3_d[l_ac].mmaz004
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mmay3_d[l_ac].mmaz004_desc = '', g_rtn_fields[1] , ''
   DISPLAY  g_mmay3_d[l_ac].mmaz004_desc to s_detail3[l_ac].mmaz004_desc
END FUNCTION
#display mmaz001
PRIVATE FUNCTION ammp403_mmaz001_ref()
   SELECT mmanl003 INTO g_mmay3_d[l_ac].mmaz001_desc FROM mmaz_t
    WHERE mmanl001 =  g_mmay3_d[l_ac].mmaz001 AND mmanl002 = g_dlang
      AND mmanlent =  g_enterprise
   DISPLAY  g_mmay3_d[l_ac].mmaz001_desc to s_detail3[l_ac].mmaz001_desc
END FUNCTION
#input s_detail3
PRIVATE FUNCTION ammp403_detail_input(p_cmd)
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
   {</Local define>}
   #add-point:input段define

   #end add-point 
   
   LET g_action_choice = ""
   
   LET g_qryparam.state = "i"
   LET g_forupd_sql = "SELECT mmazseq,mmaz002,'',mmaz003,'',mmaz004,'',mmaz005,'',mmaz001,'',mmaz006, 
       mmaz007 FROM mmaz_t WHERE mmazent=? AND mmazdocno=? AND mmazseq=? FOR UPDATE"
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE ammp403_bcl4 CURSOR FROM g_forupd_sql
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET INT_FLAG = 0
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   #實際單身段落
      INPUT ARRAY g_mmay3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 

                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_3)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mmay3_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            LET g_detail_cnt = g_mmay3_d.getLength()
            #add-point:資料輸入前

            #end add-point
 
         BEFORE INSERT
            
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_mmay3_d[l_ac].* TO NULL 
            
            LET g_mmay3_d_t.* = g_mmay3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL ammp403_set_entry_b("a")
            CALL ammp403_set_no_entry_b("a")
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mmay3_d[li_reproduce_target].* = g_mmay3_d[li_reproduce].*
 
               LET g_mmay3_d[li_reproduce_target].mmazseq = NULL
            END IF
            #公用欄位給值(單身3)
            
            #add-point:input段before insert

            #end add-point  
            
         BEFORE ROW 
            LET p_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx2 = l_ac
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_n TO FORMONLY.idx
         
            CALL s_transaction_begin()
            
            LET g_detail_cnt = g_mmay3_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_mmay3_d[l_ac].mmazseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_mmay3_d_t.* = g_mmay3_d[l_ac].*  #BACKUP
               IF NOT ammp403_lock_mmaz("mmaz_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH ammp403_bcl4 INTO g_mmay3_d[l_ac].mmazseq,g_mmay3_d[l_ac].mmaz002,g_mmay3_d[l_ac].mmaz002_desc, 
                      g_mmay3_d[l_ac].mmaz003,g_mmay3_d[l_ac].mmaz003_desc,g_mmay3_d[l_ac].mmaz004,g_mmay3_d[l_ac].mmaz004_desc, 
                      g_mmay3_d[l_ac].mmaz005,g_mmay3_d[l_ac].mmaz005_desc,g_mmay3_d[l_ac].mmaz001,g_mmay3_d[l_ac].mmaz001_desc, 
                      g_mmay3_d[l_ac].mmaz006,g_mmay3_d[l_ac].mmaz007
                  IF SQLCA.sqlcode THEN
                     CALL cl_err('',SQLCA.sqlcode,1)
                     LET l_lock_sw = "Y"
                  END IF
                  CALL cl_show_fld_cont()
                  CALL ammp403_detail_show()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL ammp403_set_entry_b(l_cmd)
            CALL ammp403_set_no_entry_b(l_cmd)
            #add-point:input段before row

            #end add-point  
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_mmay3_d.deleteElement(l_ac)
               NEXT FIELD mmazseq
            END IF
            IF g_mmay3_d[l_ac].mmazseq IS NOT NULL
            THEN
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  CALL cl_err("", -263, 1)
                  CANCEL DELETE
               END IF
               
               #add-point:單身3刪除前

               #end add-point  
               
               DELETE FROM mmaz_t
                WHERE mmazent = g_enterprise AND
                   mmazdocno = g_master.mmaydocno
                   AND mmazseq = g_mmay3_d_t.mmazseq
                   
               #add-point:單身3刪除中

               #end add-point  
                   
               IF SQLCA.sqlcode THEN
                  CALL cl_err("mmay_t",SQLCA.sqlcode,1)
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
                  #add-point:單身3刪除後

                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE ammp403_bcl
               LET l_count = g_mmay_d.getLength()
            END IF 
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmay_d[g_detail_idx].mmaydocno
               LET gs_keys[2] = g_mmay3_d[g_detail_idx2].mmazseq
 
            
         AFTER DELETE 
            #add-point:單身AFTER DELETE 

            #end add-point
                           CALL ammp403_delete_b('mmaz_t',gs_keys,"'3'")
 
         AFTER INSERT    
            IF INT_FLAG THEN
               CALL cl_err('',9001,0)
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM mmaz_t 
             WHERE mmazent = g_enterprise AND
                   mmazdocno = g_master.mmaydocno
                   AND mmazseq = g_mmay3_d[g_detail_idx2].mmazseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前

               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmay_d[g_detail_idx].mmaydocno
               LET gs_keys[2] = g_mmay3_d[g_detail_idx2].mmazseq
               CALL ammp403_insert_b('mmaz_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3

               #end add-point
            ELSE    
               CALL cl_err('INSERT',"std-00006",1)
               INITIALIZE g_mmay_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               CALL cl_err("mmaz_t",SQLCA.sqlcode,1)  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL ammp403_b_fill(g_wc)
               #資料多語言用-增/改
               
               #add-point:單身新增後

               #end add-point
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               CALL cl_err('',9001,0)
               LET INT_FLAG = 0
               LET g_mmay3_d[l_ac].* = g_mmay3_d_t.*
               CLOSE ammp403_bcl4
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               CALL cl_err('',-263,1)
               LET g_mmay3_d[l_ac].* = g_mmay3_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身3)
               
               
               #add-point:單身page3修改前
               let g_master.mmaydocno=g_mmay_d[g_master_idx].mmaydocno
               #end add-point
               
               UPDATE mmaz_t SET (mmazseq,mmaz002,mmaz003,mmaz004,mmaz005,mmaz001,mmaz006,mmaz007) = (g_mmay3_d[l_ac].mmazseq, 
                   g_mmay3_d[l_ac].mmaz002,g_mmay3_d[l_ac].mmaz003,g_mmay3_d[l_ac].mmaz004,g_mmay3_d[l_ac].mmaz005, 
                   g_mmay3_d[l_ac].mmaz001,g_mmay3_d[l_ac].mmaz006,g_mmay3_d[l_ac].mmaz007) #自訂欄位頁簽 

                WHERE mmazent = g_enterprise AND
                   mmazdocno = g_master.mmaydocno
                   AND mmazseq = g_mmay3_d_t.mmazseq
                   
               #add-point:單身修改中

               #end add-point
                   
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL cl_err("mmaz_t","std-00009",1)
                     CALL s_transaction_end('N','0')
                     LET g_mmay3_d[l_ac].* = g_mmay3_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     CALL cl_err("mmaz_t",SQLCA.sqlcode,1)  
                     CALL s_transaction_end('N','0')
                     LET g_mmay3_d[l_ac].* = g_mmay3_d_t.*
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmay_d[g_detail_idx].mmaydocno
               LET gs_keys_bak[1] = g_mmay_d[g_detail_idx].mmaydocno
               LET gs_keys[2] = g_mmay3_d[g_detail_idx2].mmazseq
               LET gs_keys_bak[2] = g_mmay3_d_t.mmazseq
               CALL ammp403_update_b('mmaz_t',gs_keys,gs_keys_bak,"'3'")
                     #資料多語言用-增/改
                     
               END CASE
               #add-point:單身page3修改後

               #end add-point
            END IF
         
         #---------------------<  Detail: page3  >---------------------
         #----<<mmazseq>>----
         #此段落由子樣板a02產生
         AFTER FIELD mmazseq
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_mmay3_d[l_ac].mmazseq,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD mmazseq
            END IF
 
 
            #add-point:AFTER FIELD mmazseq

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD mmazseq
            #add-point:BEFORE FIELD mmazseq

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE mmazseq
            #add-point:ON CHANGE mmazseq

            #END add-point
 
         #----<<mmaz002>>----
         #此段落由子樣板a02產生
         AFTER FIELD mmaz002
            
            #add-point:AFTER FIELD mmaz002
            LET g_mmay3_d[l_ac].mmaz002_desc = NULL
            DISPLAY BY NAME g_mmay3_d[l_ac].mmaz002_desc
            
            IF NOT cl_null(g_mmay3_d[l_ac].mmaz002) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_mmay3_d[l_ac].mmaz002!= g_mmay3_d_t.mmaz002 OR g_mmay3_d_t.mmaz002 IS NULL  ))) THEN 
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
 
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_mmay3_d[l_ac].mmaz002
                  LET g_chkparam.arg2 = '2'
                  LET g_chkparam.arg3 = g_site


                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooed004") THEN

                  ELSE
                     #檢查失敗時後續處理
                     LET g_mmay3_d[l_ac].mmaz002 = g_mmay3_d_t.mmaz002
                     CALL ammp403_mmaz002_ref()
                     NEXT FIELD mmaz002
                  END IF
               END IF
            END IF
            CALL ammp403_mmaz002_ref()

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD mmaz002
            #add-point:BEFORE FIELD mmaz002

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE mmaz002
            #add-point:ON CHANGE mmaz002

            #END add-point
 
         #----<<mmaz003>>----
         #此段落由子樣板a02產生
         AFTER FIELD mmaz003
            
            #add-point:AFTER FIELD mmaz003
            LET g_mmay3_d[l_ac].mmaz003_desc = NULL
            DISPLAY BY NAME g_mmay3_d[l_ac].mmaz003_desc
            
            IF NOT cl_null(g_mmay3_d[l_ac].mmaz003) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_mmay3_d[l_ac].mmaz003!= g_mmay3_d_t.mmaz003 OR g_mmay3_d_t.mmaz003 IS NULL  ))) THEN 
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
 
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_mmay3_d[l_ac].mmaz002
                  LET g_chkparam.arg2 = g_mmay3_d[l_ac].mmaz003


                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_inaa001") THEN

                  ELSE
                     #檢查失敗時後續處理
                     LET g_mmay3_d[l_ac].mmaz003 = g_mmay3_d_t.mmaz003
                     CALL ammp403_mmaz003_ref()
                     NEXT FIELD mmaz003
                  END IF
               END IF
            END IF
            CALL ammp403_mmaz003_ref()
            

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD mmaz003
            #add-point:BEFORE FIELD mmaz003

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE mmaz003
            #add-point:ON CHANGE mmaz003

            #END add-point
 
         #----<<mmaz004>>----
         #此段落由子樣板a02產生
         AFTER FIELD mmaz004
            
            #add-point:AFTER FIELD mmaz004

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD mmaz004
            #add-point:BEFORE FIELD mmaz004

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE mmaz004
            #add-point:ON CHANGE mmaz004

            #END add-point
 
         #----<<mmaz005>>----
         #此段落由子樣板a02產生
         AFTER FIELD mmaz005
            
            #add-point:AFTER FIELD mmaz005
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmay3_d[l_ac].mmaz005
            CALL ap_ref_array2(g_ref_fields,"SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaa001=? ","") RETURNING g_rtn_fields
            LET g_mmay3_d[l_ac].mmaz005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mmay3_d[l_ac].mmaz005_desc

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD mmaz005
            #add-point:BEFORE FIELD mmaz005

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE mmaz005
            #add-point:ON CHANGE mmaz005

            #END add-point
 
         #----<<mmaz001>>----
         #此段落由子樣板a02產生
         AFTER FIELD mmaz001
            
            #add-point:AFTER FIELD mmaz001

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD mmaz001
            #add-point:BEFORE FIELD mmaz001

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE mmaz001
            #add-point:ON CHANGE mmaz001

            #END add-point
 
         #----<<mmaz006>>----
         #此段落由子樣板a02產生
         AFTER FIELD mmaz006
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_mmay3_d[l_ac].mmaz006,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD mmaz006
            END IF
 
 
            #add-point:AFTER FIELD mmaz006

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD mmaz006
            #add-point:BEFORE FIELD mmaz006

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE mmaz006
            #add-point:ON CHANGE mmaz006

            #END add-point
 
         #----<<mmaz007>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmaz007
            #add-point:BEFORE FIELD mmaz007

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmaz007
            
            #add-point:AFTER FIELD mmaz007
            IF NOT cl_ap_chk_Range(g_mmay3_d[l_ac].mmaz007,"0.000","1","","","azz-00079",1) THEN
               let g_mmay3_d[l_ac].mmaz007 = g_mmay3_d_t.mmaz007
               NEXT FIELD mmaz007
            END IF
            IF NOT cl_null(g_mmay3_d[l_ac].mmaz007) THEN
               IF g_mmay3_d[l_ac].mmaz007<> g_mmay3_d[l_ac].mmaz006 THEN
                  IF cl_ask_confirm('art-00220') THEN
                  ELSE
                     NEXT FIELD mmaz007
                  END IF
               END IF
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmaz007
            #add-point:ON CHANGE mmaz007

            #END add-point
 
 
         #---------------------<  Detail: page3  >---------------------
         #----<<mmazseq>>----
         #Ctrlp:input.c.page3.mmazseq
         ON ACTION controlp INFIELD mmazseq
            #add-point:ON ACTION controlp INFIELD mmazseq

            #END add-point
 
         #----<<mmaz002>>----
         #Ctrlp:input.c.page3.mmaz002
         ON ACTION controlp INFIELD mmaz002
            #add-point:ON ACTION controlp INFIELD mmaz002
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mmay3_d[l_ac].mmaz002            #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_site #
            LET g_qryparam.arg2 = "2" #

            CALL q_ooed004()                                #呼叫開窗

            LET g_mmay3_d[l_ac].mmaz002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_mmay3_d[l_ac].mmaz002 TO mmaz002              #顯示到畫面上
            CALL ammp403_mmaz002_ref()
            NEXT FIELD mmaz002                          #返回原欄位
            #END add-point
 
         #----<<mmaz003>>----
         #Ctrlp:input.c.page3.mmaz003
         ON ACTION controlp INFIELD mmaz003
            #add-point:ON ACTION controlp INFIELD mmaz003
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mmay3_d[l_ac].mmaz003             #給予default值
            LET g_qryparam.where = "inaasite = '",g_mmay3_d[l_ac].mmaz002,"'"
            #給予arg

            CALL q_inaa001_3()                                #呼叫開窗

            LET g_mmay3_d[l_ac].mmaz003 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_qryparam.where = NULL 
            DISPLAY g_mmay3_d[l_ac].mmaz003 TO mmaz003              #顯示到畫面上
            call ammp403_mmaz003_ref()
            #END add-point
 
         #----<<mmaz004>>----
         #Ctrlp:input.c.page3.mmaz004
         ON ACTION controlp INFIELD mmaz004
            #add-point:ON ACTION controlp INFIELD mmaz004

            #END add-point
 
         #----<<mmaz005>>----
         #Ctrlp:input.c.page3.mmaz005
         ON ACTION controlp INFIELD mmaz005
            #add-point:ON ACTION controlp INFIELD mmaz005

            #END add-point
 
         #----<<mmaz001>>----
         #Ctrlp:input.c.page3.mmaz001
         ON ACTION controlp INFIELD mmaz001
            #add-point:ON ACTION controlp INFIELD mmaz001

            #END add-point
 
         #----<<mmaz006>>----
         #Ctrlp:input.c.page3.mmaz006
         ON ACTION controlp INFIELD mmaz006
            #add-point:ON ACTION controlp INFIELD mmaz006

            #END add-point
 
         #----<<mmaz007>>----
         #Ctrlp:input.c.page3.mmaz007
         ON ACTION controlp INFIELD mmaz007
            #add-point:ON ACTION controlp INFIELD mmaz007

            #END add-point
 
 
 
         AFTER ROW
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CALL cl_err('',9001,0)
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_mmay3_d[l_ac].* = g_mmay3_d_t.*
               END IF
               CLOSE ammp403_bcl4
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
 
            CALL ammp403_unlock_b("mmaz_t")
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #add-point:input段after input 

            #end add-point   
 
         ON ACTION controlo   
            CALL FGL_SET_ARR_CURR(g_mmay3_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_mmay3_d.getLength()+1
 
      END INPUT
      BEFORE DIALOG 
         LET g_curr_diag = ui.DIALOG.getCurrent()
         IF g_master_idx > 0 THEN
            IF g_master_idx > g_mmay_d.getLength() THEN
               LET g_master_idx = g_mmay_d.getLength()
            END IF
            CALL DIALOG.setCurrentRow("s_detail1", g_master_idx)
            LET l_ac = g_master_idx
         END IF 
         LET g_master_idx = l_ac
         #add-point:input段input_array"

         #end add-point
   
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
 
   CLOSE ammp403_bcl4
   CALL s_transaction_end('Y','0')  
END FUNCTION
#lock mmaz
PRIVATE FUNCTION ammp403_lock_mmaz(ps_table)
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   LET ls_group = "mmaz_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN ammp403_bcl4 USING g_enterprise,
                                             g_mmay_d[g_master_idx].mmaydocno,
                                             g_mmay3_d[l_ac].mmazseq
 
      IF SQLCA.sqlcode THEN
         CALL cl_err("ammp403_bcl4",SQLCA.sqlcode,1)
         RETURN FALSE
      END IF
   END IF
 
 
   
   RETURN TRUE
END FUNCTION

 
{</section>}
 
