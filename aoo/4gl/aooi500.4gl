#該程式已解開Section, 不再透過樣板產出!
{<section id="aooi500.description" >}
#+ Ve rsion. .: T100-ERP-1.00.00(SD版次:1,PR版次:1) Build-000036
#+ 
#+ Filename...: aooi500
#+ Description: 作業組織應用設定維護作業
#+ Creator....: 04226(2014/07/21)
#+ Modifier...: 04226(2014/07/21) -SD/PR- 06814
#+ Buildtype..: 應用 t02 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="aooi500.global" >}
#160318-00025#14 2016/04/18 By 07673   將重複內容的錯誤訊息置換為公用錯誤訊息
#160615-00028#1  2016/06/20 By 06814   aooi500單身 當設定類型為'1.組織類型'時,應該也要可選擇營運據點
#                                      當aooi500設定成營運據點後,
#                                      所有的操作 都應該像選擇其他組織類型一樣的功能 ex:使用要貨單輸入資料後,流程都要正常
#161003-00011#1  2016/10/03 By jrg542  補修正因為退版的關係 漏掉 160905-00007#9 及160921-00002#1 這兩張單 的內容
#161008-00003#1  2016/10/08 By 01531   UPDATE ooez_t需补ENT条件
#161228-00054#1  2016/12/28 By 06814   補上160615-00028#1修改內容(退版造成程式碼遺失)
 
IMPORT os
IMPORT util
#add-point:增加匯入項目

#end add-point
    
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_ooez_d RECORD
   ooez001      LIKE ooez_t.ooez001, 
   ooez001_desc LIKE type_t.chr500, 
   ooez002      LIKE ooez_t.ooez002, 
   ooez004      LIKE ooez_t.ooez004
       END RECORD
PRIVATE TYPE type_g_ooez2_d RECORD
   ooezacti LIKE ooez_t.ooezacti, 
   ooez002 LIKE ooez_t.ooez002, 
   ooez003 LIKE ooez_t.ooez003, 
   ooez003_desc LIKE type_t.chr500, 
   ooez004 LIKE ooez_t.ooez004, 
   ooez004_desc LIKE type_t.chr500,
   ooez008 LIKE ooez_t.ooez008,
   ooez005 LIKE ooez_t.ooez005, 
   ooez006 LIKE ooez_t.ooez006, 
   ooez007 LIKE ooez_t.ooez007
       END RECORD
PRIVATE TYPE type_g_ooez3_d RECORD
   ooez002 LIKE ooez_t.ooez002, 
   ooez004 LIKE ooez_t.ooez004, 
   ooezownid LIKE ooez_t.ooezownid, 
   ooezownid_desc LIKE type_t.chr500, 
   ooezowndp LIKE ooez_t.ooezowndp, 
   ooezowndp_desc LIKE type_t.chr500, 
   ooezcrtid LIKE ooez_t.ooezcrtid, 
   ooezcrtid_desc LIKE type_t.chr500, 
   ooezcrtdp LIKE ooez_t.ooezcrtdp, 
   ooezcrtdp_desc LIKE type_t.chr500, 
   ooezcrtdt DATETIME YEAR TO SECOND, 
   ooezmodid LIKE ooez_t.ooezmodid, 
   ooezmodid_desc LIKE type_t.chr500, 
   ooezmoddt DATETIME YEAR TO SECOND
       END RECORD
 
 
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_ooez_d
DEFINE g_master_t                   type_g_ooez_d
DEFINE g_ooez_d    DYNAMIC ARRAY OF type_g_ooez_d
DEFINE g_ooez_d_t  type_g_ooez_d
DEFINE g_ooez_d_o  type_g_ooez_d
DEFINE g_ooez2_d   DYNAMIC ARRAY OF type_g_ooez2_d
DEFINE g_ooez2_d_t type_g_ooez2_d
DEFINE g_ooez2_d_o type_g_ooez2_d
DEFINE g_ooez3_d   DYNAMIC ARRAY OF type_g_ooez3_d
DEFINE g_ooez3_d_t type_g_ooez3_d
DEFINE g_ooez3_d_o type_g_ooez3_d
 
      
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
DEFINE g_log1               STRING                        #log用
DEFINE g_log2               STRING                        #log用
 
#多table用wc
DEFINE g_wc_table           STRING
 
DEFINE g_wc2_table2   STRING
 
 
 
#add-point:自定義模組變數(Module Variable)

#end add-point
 
#add-point:傳入參數說明(global.argv)

#end add-point
 
{</section>}
 
{<section id="aooi500.main" >}
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
   CALL cl_ap_init("aoo","")
 
   #add-point:作業初始化
   CALL aooi500_create_tmp()
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define
   
   #end add-point
 
 
 
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aooi500 WITH FORM cl_ap_formpath("aoo",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aooi500_init()   
 
      #進入選單 Menu (="N")
      CALL aooi500_ui_dialog() 
      
      #add-point:畫面關閉前
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aooi500
      
   END IF 
   
   
   
 
   #add-point:作業離開前
   DROP TABLE aooi500_combo_t
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN
 
 
 
{</section>}
 
{<section id="aooi500.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aooi500_init()
   #add-point:init段define

   #end add-point   
   
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_error_show = 1
   
   CALL cl_set_combo_scc('ooez002','6080') 
   CALL cl_set_combo_scc('ooez005','6081') 
   CALL cl_set_combo_scc('ooez007','6752') 
   LET l_ac = 1
   
   
   
 
   #避免USER直接進入第二單身時無資料
   IF g_ooez_d.getLength() > 0 THEN
      LET g_master_t.* = g_ooez_d[1].*
      LET g_master.* = g_ooez_d[1].*
   END IF
 
   #add-point:畫面資料初始化
   CALL cl_set_combo_scc('ooez002_3','6080') 
   #設定 ooez006 的下拉式選項
   CALL aooi500_set_ooez006_combo()
   #end add-point
   
   CALL aooi500_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="aooi500.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aooi500_ui_dialog()
   DEFINE la_param  RECORD
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   DEFINE li_idx   LIKE type_t.num5
   #add-point:ui_dialog段define
  DEFINE l_success  LIKE type_t.num5
  DEFINE l_errno    LIKE type_t.chr10
   #end add-point 
 
   LET g_action_choice = " "  
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm() 
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   #add-point:ui_dialog段before dialog 
   LET g_errshow = 1
   #end add-point
   
   WHILE TRUE
   
      #add-point:ui_dialog段before while
      LET g_current_page = 0
      #end add-point
   
      CALL aooi500_b_fill(g_wc)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_ooez_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
               LET g_master.* = g_ooez_d[g_detail_idx].*
               CALL cl_show_fld_cont()
               CALL aooi500_fetch()
               CALL aooi500_idx_chk('m')
               #顯示followup圖示
               #+ 此段落由子樣板a48產生
   CALL aooi500_set_pk_array()
   #add-point:ON ACTION agendum

   #END add-point
   CALL cl_user_overview_set_follow_pic()
 
 
               
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
 
         
         DISPLAY ARRAY g_ooez2_d TO s_detail2.*
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
               CALL aooi500_idx_chk('d')
               LET g_master.* = g_ooez_d[g_detail_idx].*
               CALL cl_show_fld_cont() 
               
            #自訂ACTION(detail_show,page_2)
            
               
         END DISPLAY
         DISPLAY ARRAY g_ooez3_d TO s_detail3.*
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
               CALL aooi500_idx_chk('d')
               LET g_master.* = g_ooez_d[g_detail_idx].*
               CALL cl_show_fld_cont() 
               
            #自訂ACTION(detail_show,page_3)
            
               
         END DISPLAY
 
      
         #add-point:ui_dialog段自定義display array

         #end add-point
    
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()         
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            IF g_detail_idx > 0 THEN
               IF g_detail_idx > g_ooez_d.getLength() THEN
                  LET g_detail_idx = g_ooez_d.getLength()
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
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL aooi500_modify()
               #add-point:ON ACTION modify
               
               #END add-point
               EXIT DIALOG
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aooi500_modify()
               #add-point:ON ACTION modify_detail

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
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aooi500_query()
               #add-point:ON ACTION query

               #END add-point
               
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
            CALL aooi500_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document

               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aooi500_set_pk_array()
            #add-point:ON ACTION agendum

            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aooi500_set_pk_array()
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
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="aooi500.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aooi500_query()
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define

   #end add-point 
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_ooez_d.clear()
   
   LET g_qryparam.state = "c"
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
   #wc備份
   LET ls_wc = g_wc
   LET g_detail_idx = l_ac
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單身根據table分拆construct
      CONSTRUCT g_wc_table ON ooez001,ooez002,ooez004
           FROM s_detail1[1].ooez001,s_detail1[1].ooez0021,s_detail1[1].ooez0041
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #Ctrlp:construct.c.page1.ooez001
         ON ACTION controlp INFIELD ooez001
            #add-point:ON ACTION controlp INFIELD ooez001
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_gzzz001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooez001  #顯示到畫面上
            NEXT FIELD ooez001                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ooez001
            #add-point:BEFORE FIELD ooez001

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ooez001
            
            #add-point:AFTER FIELD ooez001

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD ooez002
            #add-point:BEFORE FIELD ooez002

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ooez002
            
            #add-point:AFTER FIELD ooez002

            #END add-point
            
 
         #Ctrlp:construct.c.page1.ooez002
         ON ACTION controlp INFIELD ooez002
            #add-point:ON ACTION controlp INFIELD ooez002

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ooez004
            #add-point:BEFORE FIELD ooez004

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ooez004
            
            #add-point:AFTER FIELD ooez004

            #END add-point
            
 
         #Ctrlp:construct.c.page1.ooez004
         ON ACTION controlp INFIELD ooez004
            #add-point:ON ACTION controlp INFIELD ooez004

            #END add-point
 
   
       
      END CONSTRUCT
      
 
      
      CONSTRUCT g_wc2_table2 ON ooezacti,ooez002,ooez003,ooez004,ooez008,ooez005,ooez006,ooez007,ooezownid,ooezowndp, 
          ooezcrtid,ooezcrtdp,ooezcrtdt,ooezmodid,ooezmoddt
           FROM s_detail2[1].ooezacti, s_detail2[1].ooez002,  s_detail2[1].ooez003,  s_detail2[1].ooez004,
                s_detail2[1].ooez008,  s_detail2[1].ooez005,  s_detail2[1].ooez006,  s_detail2[1].ooez007,
                s_detail3[1].ooezownid,s_detail3[1].ooezowndp,s_detail3[1].ooezcrtid,s_detail3[1].ooezcrtdp,
                s_detail3[1].ooezcrtdt,s_detail3[1].ooezmodid,s_detail3[1].ooezmoddt
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       #此段落由子樣板a11產生
         #共用欄位查詢處理
         ##----<<ooezcrtdt>>----
         AFTER FIELD ooezcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<ooezmoddt>>----
         AFTER FIELD ooezmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<ooezcnfdt>>----
         
         #----<<ooezpstdt>>----
 
 
       
       #單身一般欄位開窗相關處理       
                #此段落由子樣板a01產生
         BEFORE FIELD ooezacti
            #add-point:BEFORE FIELD ooezacti

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ooezacti
            
            #add-point:AFTER FIELD ooezacti

            #END add-point
            
 
         #Ctrlp:construct.c.page2.ooezacti
         ON ACTION controlp INFIELD ooezacti
            #add-point:ON ACTION controlp INFIELD ooezacti

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ooez002
            #add-point:BEFORE FIELD ooez002

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ooez002
            
            #add-point:AFTER FIELD ooez002

            #END add-point
            
 
         #Ctrlp:construct.c.page2.ooez002
         ON ACTION controlp INFIELD ooez002
            #add-point:ON ACTION controlp INFIELD ooez002

            #END add-point
 
         #Ctrlp:construct.c.page2.ooez003
         ON ACTION controlp INFIELD ooez003
            #add-point:ON ACTION controlp INFIELD ooez003
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_dzea002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooez003  #顯示到畫面上
            NEXT FIELD ooez003                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ooez003
            #add-point:BEFORE FIELD ooez003

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ooez003
            
            #add-point:AFTER FIELD ooez003

            #END add-point
            
 
         #Ctrlp:construct.c.page2.ooez004
         ON ACTION controlp INFIELD ooez004
            #add-point:ON ACTION controlp INFIELD ooez004
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_dzeb002_9()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooez004  #顯示到畫面上
            NEXT FIELD ooez004                     #返回原欄位
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ooez004
            #add-point:BEFORE FIELD ooez004

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ooez004
            
            #add-point:AFTER FIELD ooez004

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD ooez005
            #add-point:BEFORE FIELD ooez005

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ooez005
            
            #add-point:AFTER FIELD ooez005

            #END add-point
            
 
         #Ctrlp:construct.c.page2.ooez005
         ON ACTION controlp INFIELD ooez005
            #add-point:ON ACTION controlp INFIELD ooez005

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ooez006
            #add-point:BEFORE FIELD ooez006

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ooez006
            
            #add-point:AFTER FIELD ooez006

            #END add-point
            
 
         #Ctrlp:construct.c.page2.ooez006
         ON ACTION controlp INFIELD ooez006
            #add-point:ON ACTION controlp INFIELD ooez006

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ooez007
            #add-point:BEFORE FIELD ooez007

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ooez007
            
            #add-point:AFTER FIELD ooez007

            #END add-point
            
 
         #Ctrlp:construct.c.page2.ooez007
         ON ACTION controlp INFIELD ooez007
            #add-point:ON ACTION controlp INFIELD ooez007

            #END add-point
 
         #Ctrlp:construct.c.page3.ooezownid
         ON ACTION controlp INFIELD ooezownid
            #add-point:ON ACTION controlp INFIELD ooezownid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooezownid  #顯示到畫面上
            NEXT FIELD ooezownid                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ooezownid
            #add-point:BEFORE FIELD ooezownid

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ooezownid
            
            #add-point:AFTER FIELD ooezownid

            #END add-point
            
 
         #Ctrlp:construct.c.page3.ooezowndp
         ON ACTION controlp INFIELD ooezowndp
            #add-point:ON ACTION controlp INFIELD ooezowndp
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooezowndp  #顯示到畫面上
            NEXT FIELD ooezowndp                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ooezowndp
            #add-point:BEFORE FIELD ooezowndp

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ooezowndp
            
            #add-point:AFTER FIELD ooezowndp

            #END add-point
            
 
         #Ctrlp:construct.c.page3.ooezcrtid
         ON ACTION controlp INFIELD ooezcrtid
            #add-point:ON ACTION controlp INFIELD ooezcrtid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooezcrtid  #顯示到畫面上
            NEXT FIELD ooezcrtid                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ooezcrtid
            #add-point:BEFORE FIELD ooezcrtid

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ooezcrtid
            
            #add-point:AFTER FIELD ooezcrtid

            #END add-point
            
 
         #Ctrlp:construct.c.page3.ooezcrtdp
         ON ACTION controlp INFIELD ooezcrtdp
            #add-point:ON ACTION controlp INFIELD ooezcrtdp
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooezcrtdp  #顯示到畫面上
            NEXT FIELD ooezcrtdp                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ooezcrtdp
            #add-point:BEFORE FIELD ooezcrtdp

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ooezcrtdp
            
            #add-point:AFTER FIELD ooezcrtdp

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD ooezcrtdt
            #add-point:BEFORE FIELD ooezcrtdt

            #END add-point
 
         #Ctrlp:construct.c.page3.ooezmodid
         ON ACTION controlp INFIELD ooezmodid
            #add-point:ON ACTION controlp INFIELD ooezmodid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooezmodid  #顯示到畫面上
            NEXT FIELD ooezmodid                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ooezmodid
            #add-point:BEFORE FIELD ooezmodid

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ooezmodid
            
            #add-point:AFTER FIELD ooezmodid

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD ooezmoddt
            #add-point:BEFORE FIELD ooezmoddt

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
   CALL aooi500_b_fill(g_wc)
   LET l_ac = g_detail_idx
   CALL aooi500_fetch()
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = -100 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
   END IF
   
END FUNCTION
 
{</section>}
 
{<section id="aooi500.insert" >}
#+ 資料修改
PRIVATE FUNCTION aooi500_insert()
   #add-point:insert段define

   #end add-point 
 
   #add-point:insert段新增前

   #end add-point 
   
   #進入資料輸入段落
   CALL g_ooez_d.clear() 
   CALL g_ooez2_d.clear() 
   CALL g_ooez3_d.clear() 
 
   CALL aooi500_input('a')
   
   CALL aooi500_b_fill(g_wc)
   
   #add-point:insert段新增後

   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aooi500.modify" >}
#+ 資料新增
PRIVATE FUNCTION aooi500_modify()
   #add-point:modify段define
   
   #end add-point 
 
   #add-point:modify段新增前
   
   #end add-point 
   
   #進入資料輸入段落
   CALL aooi500_input('u')
   
   #add-point:modify段新增後
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aooi500.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aooi500_delete()
   DEFINE li_ac LIKE type_t.num5
   #add-point:delete段define

   #end add-point 
   IF NOT cl_ask_delete() THEN
      #不刪除
      RETURN
   END IF
   
   LET li_ac = ARR_CURR()
   LET g_ooez_d_t.* = g_ooez_d[li_ac].*
   LET g_ooez_d_o.* = g_ooez_d[li_ac].*
   
   CALL s_transaction_begin()  
   
   #add-point:delete段刪除前

   #end add-point 
   
   #刪除單頭
   DELETE FROM ooez_t 
         WHERE ooez001 = g_ooez_d_t.ooez001
 
           
   #add-point:delete段刪除中
          AND ooezent = g_enterprise  #161003-00011 #1(#160905-00007#9)
   #end add-point 
           
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "ooez_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:delete段刪除後

   #end add-point 
   
   #刪除單頭
   #add-point:delete段刪除前

   #end add-point 
   DELETE FROM ooez_t 
         WHERE ooez001 = g_ooez_d_t.ooez001
 
   #add-point:delete段刪除中
          AND ooezent = g_enterprise  #161003-00011 #1(#160905-00007#9)
   #end add-point 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "ooez_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
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
 
{<section id="aooi500.input" >}
#+ 資料輸入
PRIVATE FUNCTION aooi500_input(p_cmd)
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
   DEFINE  l_gzzz002             LIKE gzzz_t.gzzz002
   #end add-point 
   
   LET g_action_choice = ""
   
   LET g_qryparam.state = "i"
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
 
   #add-point:input段define_sql

   #end add-point 
   LET g_forupd_sql = "SELECT ooez001,' ',' '",
                      "  FROM ooez_t WHERE ooezent=? AND ooez001=? FOR UPDATE"
   #add-point:input段define_sql

   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE aooi500_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
   
 
   
   #add-point:input段define_sql

   #end add-point 
   LET g_forupd_sql = "SELECT ooezacti,ooez002,ooez003,ooez004,ooez008,ooez005,ooez006,ooez007,ooez002,ooez004, 
       ooezownid,ooezowndp,ooezcrtid,ooezcrtdp,ooezcrtdt,ooezmodid,ooezmoddt FROM ooez_t WHERE ooezent=?  
       AND ooez001=? AND ooez002=? AND ooez004=? FOR UPDATE"
   #add-point:input段define_sql

   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE aooi500_bcl2 CURSOR FROM g_forupd_sql
 
 
 
   LET lb_reproduce = FALSE
   
   #add-point:input段修改前
   #檢查ooez006選取的combo是否屬於ooez005所選取的
   LET g_sql = "SELECT COUNT(ooez005)",
               "  FROM aooi500_combo_t",
               " WHERE ooez005 = ?",
               "   AND ooez006 = ?"
   PREPARE aooi500_ooez005 FROM g_sql
   #end add-point
 
   LET INT_FLAG = 0
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #Page1 預設值產生於此處
      INPUT ARRAY g_ooez_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_ooez_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            LET g_current_page = 1
            IF p_cmd = 'u' THEN
               CALL aooi500_b_fill(g_wc)
            END IF
            LET g_loc = 'm'
            LET g_detail_cnt = g_ooez_d.getLength()
            #add-point:資料輸入前

            #end add-point
            
         BEFORE ROW
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_master_t.* = g_ooez_d[l_ac].*
            LET g_master.* = g_ooez_d[l_ac].*
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            LET g_detail_idx = l_ac
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_ooez_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_ooez_d[l_ac].ooez001 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_ooez_d_t.* = g_ooez_d[l_ac].*  #BACKUP
               LET g_ooez_d_o.* = g_ooez_d[l_ac].*  #BACKUP
               IF NOT aooi500_lock_b("ooez_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aooi500_bcl INTO g_ooez_d[l_ac].ooez001,g_ooez_d[l_ac].ooez002,g_ooez_d[l_ac].ooez004 
 
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_ooez_d_t.ooez001 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     LET l_lock_sw = "Y"
                  END IF
                  CALL cl_show_fld_cont()
                  #CALL aooi500_detail_show()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL aooi500_set_entry_b(l_cmd)
            CALL aooi500_set_no_entry_b(l_cmd)
            #add-point:input段before row

            #end add-point  
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            
            #讀取對應的單身資料
            CALL aooi500_fetch()
            CALL aooi500_idx_chk('m')
        
         BEFORE INSERT
            
            #判斷能否在此頁面進行資料新增
            
            #清空下層單身
            CALL g_ooez2_d.clear()
            CALL g_ooez3_d.clear()
 
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_ooez_d[l_ac].* TO NULL 
            INITIALIZE g_ooez_d_t.* TO NULL 
            INITIALIZE g_ooez_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            
            #add-point:modify段before備份
            LET g_ooez_d[l_ac].ooez002 = ' '
            LET g_ooez_d[l_ac].ooez004 = ' '
            #end add-point
            LET g_ooez_d_t.* = g_ooez_d[l_ac].*     #新輸入資料
            LET g_ooez_d_o.* = g_ooez_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aooi500_set_entry_b("a")
            CALL aooi500_set_no_entry_b("a")
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_ooez_d[li_reproduce_target].* = g_ooez_d[li_reproduce].*
 
               LET g_ooez_d[g_ooez_d.getLength()].ooez001 = NULL
 
            END IF
            #add-point:input段before insert

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
            SELECT COUNT(*) INTO l_count FROM ooez_t 
             WHERE ooezent = g_enterprise AND ooez001 = g_ooez_d[l_ac].ooez001 
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前

               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_ooez_d[g_detail_idx].ooez001
               CALL aooi500_insert_b('ooez_1',gs_keys,"'1'")
                           
               #add-point:單身新增後
               NEXT FIELD ooez002    #160422-00020#1 160422 by lori add
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               INITIALIZE g_ooez_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "ooez_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aooi500_b_fill(g_wc)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert

               #end add-point
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               LET g_master.* = g_ooez_d[l_ac].*
            END IF
              
         BEFORE DELETE  #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   =  -263 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  CANCEL DELETE
               END IF
               
               #add-point:單身刪除前

               #end add-point
               
               DELETE FROM ooez_t
                WHERE ooezent = g_enterprise AND 
                      ooez001 = g_ooez_d_t.ooez001
 
                      
               #add-point:單身刪除中

               #end add-point
                      
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "ooez_t" 
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
               CLOSE aooi500_bcl
               LET l_count = g_ooez_d.getLength()
               INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_ooez_d[g_detail_idx].ooez001
    
               #+ 此段落由子樣板a47產生
      #刪除相關文件
      CALL aooi500_set_pk_array()
      #add-point:相關文件刪除前

      #end add-point   
      CALL cl_doc_remove()  
 
        
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2

               #end add-point
                              CALL aooi500_delete_b('ooez_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_ooez_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #此段落由子樣板a02產生
         AFTER FIELD ooez001
            
            #add-point:AFTER FIELD ooez001
            LET g_ooez_d[l_ac].ooez001_desc = ' '
            DISPLAY BY NAME g_ooez_d[l_ac].ooez001_desc
            IF NOT cl_null(g_ooez_d[l_ac].ooez001) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_ooez_d[l_ac].ooez001 != g_ooez_d_t.ooez001 OR g_ooez_d_t.ooez001 IS NULL )) THEN
                  CALL aooi500_ooez001_chk()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_ooez_d[l_ac].ooez001
                     LET g_errparam.code   = g_errno
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET g_ooez_d[l_ac].ooez001 = g_ooez_d_t.ooez001
                     CALL s_desc_get_prog_desc(g_ooez_d[l_ac].ooez001)
                        RETURNING g_ooez_d[l_ac].ooez001_desc
                     DISPLAY BY NAME g_ooez_d[l_ac].ooez001_desc
                     NEXT FIELD CURRENT
                  END IF
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_ooez_d[l_ac].ooez001
                  LET g_errshow = TRUE   #160318-00025#14
                  LET g_chkparam.err_str[1] = "aoo-00120:sub-01302|azzi910|",cl_get_progname("azzi910",g_lang,"2"),"|:EXEPROGazzi910"    #160318-00025#14
                  IF NOT cl_chk_exist("v_gzzz001_4") THEN
                     LET g_ooez_d[l_ac].ooez001 = g_ooez_d_t.ooez001
                     CALL s_desc_get_prog_desc(g_ooez_d[l_ac].ooez001)
                        RETURNING g_ooez_d[l_ac].ooez001_desc
                     DISPLAY BY NAME g_ooez_d[l_ac].ooez001_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF            
            END IF
            CALL s_desc_get_prog_desc(g_ooez_d[l_ac].ooez001)
               RETURNING g_ooez_d[l_ac].ooez001_desc
            DISPLAY BY NAME g_ooez_d[l_ac].ooez001_desc
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD ooez001
            #add-point:BEFORE FIELD ooez001

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE ooez001
            #add-point:ON CHANGE ooez001

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ooez002
            #add-point:BEFORE FIELD ooez002

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ooez002
            
            #add-point:AFTER FIELD ooez002
 
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE ooez002
            #add-point:ON CHANGE ooez002

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ooez004
            #add-point:BEFORE FIELD ooez004

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ooez004
            
            #add-point:AFTER FIELD ooez004
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE ooez004
            #add-point:ON CHANGE ooez004

            #END add-point
 
                  #Ctrlp:input.c.page1.ooez001
         ON ACTION controlp INFIELD ooez001
            #add-point:ON ACTION controlp INFIELD ooez001
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_ooez_d[l_ac].ooez001             #給予default值

            CALL q_gzzz001_1()                                #呼叫開窗
            LET g_ooez_d[l_ac].ooez001 = g_qryparam.return1
            DISPLAY g_ooez_d[l_ac].ooez001 TO ooez001
            NEXT FIELD ooez001                          #返回原欄位
            #END add-point
 
         #Ctrlp:input.c.page1.ooez002
         ON ACTION controlp INFIELD ooez002
            #add-point:ON ACTION controlp INFIELD ooez002

            #END add-point
 
         #Ctrlp:input.c.page1.ooez004
         ON ACTION controlp INFIELD ooez004
            #add-point:ON ACTION controlp INFIELD ooez004

            #END add-point
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
 
               LET INT_FLAG = 0
               LET g_ooez_d[l_ac].* = g_ooez_d_t.*
               CLOSE aooi500_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_ooez_d[l_ac].ooez001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               LET g_ooez_d[l_ac].* = g_ooez_d_t.*
            ELSE
               
               #寫入修改者/修改日期資訊(單身)
               
               
               #add-point:單身修改前

               #end add-point
               
               UPDATE ooez_t SET (ooez001,ooez002,ooez004) =
                  (g_ooez_d[l_ac].ooez001,g_ooez_d[l_ac].ooez002, 
                   g_ooez_d[l_ac].ooez004)
                WHERE ooezent = g_enterprise
                  AND ooez001 = g_ooez_d_t.ooez001 #項次   
 
                  
               #add-point:單身修改中

               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "ooez_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                     LET g_ooez_d[l_ac].* = g_ooez_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "ooez_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                     LET g_ooez_d[l_ac].* = g_ooez_d_t.*
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_ooez_d[g_detail_idx].ooez001
               LET gs_keys_bak[1] = g_ooez_d_t.ooez001
               CALL aooi500_update_b('ooez_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     
                     LET g_log1 = util.JSON.stringify(g_ooez_d_t)
                     LET g_log2 = util.JSON.stringify(g_ooez_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #若Key欄位有變動
               LET g_master.* = g_ooez_d[l_ac].*
               CALL aooi500_key_update_b()
               
               #add-point:單身修改後

               #end add-point
 
            END IF
            
         AFTER ROW
            CALL aooi500_unlock_b("ooez_t")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            
              
         AFTER INPUT
            #add-point:input段after input 
 
            #end add-point   
              
         ON ACTION controlo   
            CALL FGL_SET_ARR_CURR(g_ooez_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_ooez_d.getLength()+1
              
      END INPUT
      
 
      
      #實際單身段落
      INPUT ARRAY g_ooez2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_ooez2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            LET g_loc = 'd'
            LET g_detail_cnt = g_ooez2_d.getLength()
            LET g_current_page = 2
            #add-point:資料輸入前
            IF cl_null(g_ooez_d[l_ac].ooez001) THEN
               LET p_cmd = 'u'
               #尚未選擇作業編號!
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'adb-00288'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CALL g_ooez_d.deleteElement(l_ac)
               IF g_detail_idx >= 1 THEN
                  LET g_detail_idx = g_detail_idx - 1
               END IF
               NEXT FIELD ooez001
            ELSE
               IF g_ooez_d.getLength() > 0 THEN
                  LET g_master_t.* = g_ooez_d[l_ac].*
                  LET g_master.* = g_ooez_d[l_ac].*
               END IF
            END IF
            #end add-point
 
         BEFORE INSERT
            IF g_ooez_d.getLength() = 0 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 'std-00013' 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               NEXT FIELD ooez001
            END IF 
            #判斷能否在此頁面進行資料新增
            
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_ooez2_d[l_ac].* TO NULL 
            INITIALIZE g_ooez2_d_t.* TO NULL 
            INITIALIZE g_ooez2_d_o.* TO NULL 
            LET g_ooez2_d[l_ac].ooezacti = "Y"
            LET g_ooez2_d[l_ac].ooez008 = "N"
 
            #add-point:modify段before備份

            #end add-point
            LET g_ooez2_d_t.* = g_ooez2_d[l_ac].*     #新輸入資料
            LET g_ooez2_d_o.* = g_ooez2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aooi500_set_entry_b("a")
            CALL aooi500_set_no_entry_b("a")
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_ooez2_d[li_reproduce_target].* = g_ooez2_d[li_reproduce].*
               LET g_ooez3_d[li_reproduce_target].* = g_ooez3_d[li_reproduce].*
 
               LET g_ooez2_d[li_reproduce_target].ooez002 = NULL
               LET g_ooez2_d[li_reproduce_target].ooez004 = NULL
            END IF
            #add-point:input段before insert

            #end add-point  
            
         BEFORE ROW 
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx2 = l_ac
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            CALL s_transaction_begin()
            LET g_detail_cnt = g_ooez2_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_ooez2_d[l_ac].ooez002 IS NOT NULL
               AND g_ooez2_d[l_ac].ooez004 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_ooez2_d_t.* = g_ooez2_d[l_ac].*  #BACKUP
               LET g_ooez2_d_o.* = g_ooez2_d[l_ac].*  #BACKUP
               IF NOT aooi500_lock_b("ooez_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aooi500_bcl2 INTO g_ooez2_d[l_ac].ooezacti,g_ooez2_d[l_ac].ooez002,g_ooez2_d[l_ac].ooez003, 
                      g_ooez2_d[l_ac].ooez004,g_ooez2_d[l_ac].ooez008,g_ooez2_d[l_ac].ooez005,g_ooez2_d[l_ac].ooez006,
                      g_ooez2_d[l_ac].ooez007,g_ooez3_d[l_ac].ooez002,g_ooez3_d[l_ac].ooez004,g_ooez3_d[l_ac].ooezownid,
                      g_ooez3_d[l_ac].ooezowndp,g_ooez3_d[l_ac].ooezcrtid,g_ooez3_d[l_ac].ooezcrtdp,
                      g_ooez3_d[l_ac].ooezcrtdt, g_ooez3_d[l_ac].ooezmodid,g_ooez3_d[l_ac].ooezmoddt
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = '' 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  CALL cl_show_fld_cont()
                  #CALL aooi500_detail_show()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL aooi500_set_entry_b(l_cmd)
            CALL aooi500_set_no_entry_b(l_cmd)
            #add-point:input段before row
            IF cl_null(g_ooez2_d[l_ac].ooez002)THEN
               LET g_ooez3_d[l_ac].ooezownid = g_user
               LET g_ooez3_d[l_ac].ooezowndp = g_dept
               LET g_ooez3_d[l_ac].ooezcrtid = g_user
               LET g_ooez3_d[l_ac].ooezcrtdp = g_dept
               LET g_ooez3_d[l_ac].ooezcrtdt = cl_get_current()
            END IF
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            
            CALL aooi500_idx_chk('d')
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   =  -263 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身2刪除前
               LET l_cnt = 0
               SELECT COUNT(ooez002) INTO l_cnt
                 FROM ooez_t
                WHERE ooezent = g_enterprise
                  AND ooez001 = g_master.ooez001
               IF l_cnt = 1 THEN
                  UPDATE ooez_t SET(ooezacti,ooez002,ooez003,
                                    ooez004, ooez008,ooez005,
                                    ooez006, ooez007, ooezownid,
                                    ooezowndp, ooezcrtid, ooezcrtdp,
                                    ooezcrtdt, ooezmodid, ooezmoddt) = 
                                   ('Y',' ', '',
                                    ' ','','',
                                    '','','',
                                    '','', '',
                                    '','','')
                    WHERE ooezent = g_enterprise
                      AND ooez001 = g_master.ooez001
               ELSE
               #end add-point  
               
               DELETE FROM ooez_t
                WHERE ooezent = g_enterprise AND
                   ooez001 = g_master.ooez001
                   AND ooez002 = g_ooez2_d_t.ooez002
                   AND ooez004 = g_ooez2_d_t.ooez004
                   
               #add-point:單身2刪除中
               END IF
               #end add-point  
                   
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "ooez_t" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
                  #add-point:單身2刪除後

                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE aooi500_bcl
               LET l_count = g_ooez_d.getLength()
               INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_ooez_d[g_detail_idx].ooez001
               LET gs_keys[2] = g_ooez2_d[g_detail_idx2].ooez002
               LET gs_keys[3] = g_ooez2_d[g_detail_idx2].ooez004
 
            END IF 
            
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE 

               #end add-point
               #CALL aooi500_delete_b('ooez_t',gs_keys,"'2'")
            END IF
            ##如果是最後一筆
            #IF l_ac = (g_ooez2_d.getLength() + 1) THEN
            #   CALL FGL_SET_ARR_CURR(l_ac-1)
            #END IF
 
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
            SELECT COUNT(*) INTO l_count FROM ooez_t 
             WHERE ooezent = g_enterprise AND
                   ooez001 = g_master.ooez001
                   AND ooez002 = g_ooez2_d[g_detail_idx2].ooez002
                   AND ooez004 = g_ooez2_d[g_detail_idx2].ooez004
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前
               LET l_cnt = 0
               SELECT COUNT(ooez002) INTO l_cnt
                 FROM ooez_t
                WHERE ooezent = g_enterprise
                  AND ooez001 = g_master.ooez001
                  AND ooez002 = ' '
                  AND ooez004 = ' '
               #發貨組織沒有等於空白的　新增動作
               IF l_cnt = 0 THEN
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_ooez_d[g_detail_idx].ooez001
               LET gs_keys[2] = g_ooez2_d[g_detail_idx2].ooez002
               LET gs_keys[3] = g_ooez2_d[g_detail_idx2].ooez004
               CALL aooi500_insert_b('ooez_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2
               ELSE
                  LET g_ooez3_d[l_ac].ooezownid = g_user
                  LET g_ooez3_d[l_ac].ooezowndp = g_dept
                  LET g_ooez3_d[l_ac].ooezcrtid = g_user
                  LET g_ooez3_d[l_ac].ooezcrtdp = g_dept
                  LET g_ooez3_d[l_ac].ooezcrtdt = cl_get_current()
                  LET g_ooez3_d[l_ac].ooezmodid = ""
                  LET g_ooez3_d[l_ac].ooezmoddt = ""
                  
                  UPDATE ooez_t SET (ooezacti,ooez002,ooez003,ooez004,ooez005,
                                     ooez006,ooez007,ooez008,ooezownid,ooezowndp,ooezcrtid,
                                     ooezcrtdp,ooezcrtdt,ooezmodid,ooezmoddt) =
                                    (g_ooez2_d[l_ac].ooezacti, g_ooez2_d[l_ac].ooez002,
                                     g_ooez2_d[l_ac].ooez003,  g_ooez2_d[l_ac].ooez004,
                                     g_ooez2_d[l_ac].ooez005,  g_ooez2_d[l_ac].ooez006,
                                     g_ooez2_d[l_ac].ooez007,  g_ooez2_d[l_ac].ooez008,
                                     g_ooez3_d[l_ac].ooezownid,g_ooez3_d[l_ac].ooezowndp,
                                     g_ooez3_d[l_ac].ooezcrtid,g_ooez3_d[l_ac].ooezcrtdp,
                                     g_ooez3_d[l_ac].ooezcrtdt,g_ooez3_d[l_ac].ooezmodid,
                                     g_ooez3_d[l_ac].ooezmoddt) 
                   WHERE ooezent = g_enterprise
                     AND ooez001 = g_master.ooez001
                     AND ooez002 = ' '
                     AND ooez004 = ' '
                  
                  CASE
                     WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = "std-00009"
                        LET g_errparam.extend = "ooez_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        CALL s_transaction_end('N','0')
                        LET g_ooez2_d[l_ac].* = g_ooez2_d_t.*
                     WHEN SQLCA.sqlcode #其他錯誤
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "ooez_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        CALL s_transaction_end('N','0')
                        LET g_ooez2_d[l_ac].* = g_ooez2_d_t.*
                     OTHERWISE
                        INITIALIZE gs_keys TO NULL 
                        LET gs_keys[1] = g_ooez_d[g_detail_idx].ooez001
                        LET gs_keys_bak[1] = g_ooez_d[g_detail_idx].ooez001
                        LET gs_keys[2] = g_ooez2_d[g_detail_idx2].ooez002
                        LET gs_keys_bak[2] = g_ooez2_d_t.ooez002
                        LET gs_keys[3] = g_ooez2_d[g_detail_idx2].ooez004
                        LET gs_keys_bak[3] = g_ooez2_d_t.ooez004
                        CALL aooi500_update_b('ooez_t',gs_keys,gs_keys_bak,"'2'")
                  END CASE
               END IF
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               INITIALIZE g_ooez_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "ooez_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aooi500_b_fill(g_wc)
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
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_ooez2_d[l_ac].* = g_ooez2_d_t.*
               CLOSE aooi500_bcl2
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_ooez2_d[l_ac].* = g_ooez2_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身2)
               LET g_ooez3_d[l_ac].ooezmodid = g_user 
               LET g_ooez3_d[l_ac].ooezmoddt = cl_get_current()
 
               
               #add-point:單身page2修改前
               IF cl_null(g_ooez2_d[l_ac].ooez004) THEN
                  LET g_ooez2_d[l_ac].ooez004 = ' '
               END IF
               #end add-point
               
               UPDATE ooez_t SET (ooezacti, ooez002,  ooez003,  ooez004,
                                  ooez005,  ooez006,  ooez007,  ooez008,
                                  ooezownid,ooezowndp,ooezcrtid,ooezcrtdp,
                                  ooezcrtdt,ooezmodid,ooezmoddt)
                               = (g_ooez2_d[l_ac].ooezacti,g_ooez2_d[l_ac].ooez002,g_ooez2_d[l_ac].ooez003,g_ooez2_d[l_ac].ooez004,
                                  g_ooez2_d[l_ac].ooez005, g_ooez2_d[l_ac].ooez006,g_ooez2_d[l_ac].ooez007,g_ooez2_d[l_ac].ooez008,
                                  g_ooez3_d[l_ac].ooezownid,g_ooez3_d[l_ac].ooezowndp,g_ooez3_d[l_ac].ooezcrtid,g_ooez3_d[l_ac].ooezcrtdp,
                                  g_ooez3_d[l_ac].ooezcrtdt,g_ooez3_d[l_ac].ooezmodid, g_ooez3_d[l_ac].ooezmoddt) #自訂欄位頁簽
                WHERE ooezent = g_enterprise
                   AND ooez001 = g_master.ooez001
                   AND ooez002 = g_ooez2_d_t.ooez002
                   AND ooez004 = g_ooez2_d_t.ooez004
                   
               #add-point:單身修改中

               #end add-point
                   
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "ooez_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_ooez2_d[l_ac].* = g_ooez2_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "ooez_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_ooez2_d[l_ac].* = g_ooez2_d_t.*
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_ooez_d[g_detail_idx].ooez001
               LET gs_keys_bak[1] = g_ooez_d[g_detail_idx].ooez001
               LET gs_keys[2] = g_ooez2_d[g_detail_idx2].ooez002
               LET gs_keys_bak[2] = g_ooez2_d_t.ooez002
               LET gs_keys[3] = g_ooez2_d[g_detail_idx2].ooez004
               LET gs_keys_bak[3] = g_ooez2_d_t.ooez004
               CALL aooi500_update_b('ooez_t',gs_keys,gs_keys_bak,"'2'")
                     #資料多語言用-增/改
                     
                     LET g_log1 = util.JSON.stringify(g_ooez2_d_t)
                     LET g_log2 = util.JSON.stringify(g_ooez2_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               #add-point:單身page2修改後

               #end add-point
            END IF
         
                  #此段落由子樣板a01產生
         BEFORE FIELD ooezacti
            #add-point:BEFORE FIELD ooezacti

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ooezacti
            
            #add-point:AFTER FIELD ooezacti

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE ooezacti
            #add-point:ON CHANGE ooezacti

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ooez002
            #add-point:BEFORE FIELD ooez002

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ooez002
            
            #add-point:AFTER FIELD ooez002
            IF NOT cl_null(g_ooez2_d[l_ac].ooez002) THEN
               IF g_ooez2_d[l_ac].ooez002 != g_ooez2_d_o.ooez002 OR cl_null(g_ooez2_d_o.ooez002) THEN
                  IF NOT aooi500_ooez002_chk() THEN
                     LET g_ooez2_d[l_ac].ooez002 = g_ooez2_d_o.ooez002
                     NEXT FIELD CURRENT
                  END IF
                  IF g_ooez2_d[l_ac].ooez002 = '1' OR g_ooez2_d[l_ac].ooez002 = '2' THEN
                     LET g_ooez2_d[l_ac].ooez003 = ''
                     LET g_ooez2_d[l_ac].ooez004 = ' '
                     LET g_ooez2_d[l_ac].ooez003_desc = ''
                     LET g_ooez2_d[l_ac].ooez004_desc = ''
                  END IF
                  IF g_ooez2_d[l_ac].ooez002 MATCHES '[23]' THEN
                     LET g_ooez2_d[l_ac].ooez007 = '2'
                  END IF
               END IF
            END IF
            LET g_ooez2_d_o.ooez002 = g_ooez2_d[l_ac].ooez002
            LET g_ooez2_d_o.ooez003 = g_ooez2_d[l_ac].ooez003
            LET g_ooez2_d_o.ooez004 = g_ooez2_d[l_ac].ooez004
            CALL aooi500_set_entry_b(l_cmd)
            CALL aooi500_set_no_entry_b(l_cmd)
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE ooez002
            #add-point:ON CHANGE ooez002

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ooez003
            
            #add-point:AFTER FIELD ooez003
            LET g_ooez2_d[l_ac].ooez003_desc = ' '
            DISPLAY BY NAME g_ooez2_d[l_ac].ooez003_desc
            IF NOT cl_null(g_ooez2_d[l_ac].ooez003) THEN
               IF g_ooez2_d[l_ac].ooez003 != g_ooez2_d_o.ooez003 OR cl_null(g_ooez2_d_o.ooez003) THEN
                  CALL s_aooi500_get_gzzz002(g_master.ooez001) RETURNING l_gzzz002
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_ooez2_d[l_ac].ooez003
                  LET g_chkparam.arg2 = l_gzzz002
                  IF NOT cl_chk_exist("v_dzea001_2") THEN
                     LET g_ooez2_d[l_ac].ooez003 = g_ooez2_d_o.ooez003
                     CALL aooi500_ooez003_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_ooez2_d_o.ooez003 = g_ooez2_d[l_ac].ooez003
            CALL aooi500_ooez003_ref()
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD ooez003
            #add-point:BEFORE FIELD ooez003

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE ooez003
            #add-point:ON CHANGE ooez003

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ooez004
            
            #add-point:AFTER FIELD ooez004
            LET g_ooez2_d[l_ac].ooez004_desc = ' '
            DISPLAY BY NAME g_ooez2_d[l_ac].ooez004_desc
            IF NOT cl_null(g_ooez2_d[l_ac].ooez004) THEN
               IF g_ooez2_d[l_ac].ooez004 != g_ooez2_d_o.ooez004 OR cl_null(g_ooez2_d_o.ooez004) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_ooez2_d[l_ac].ooez003
                  LET g_chkparam.arg2 = g_ooez2_d[l_ac].ooez004
                  IF NOT cl_chk_exist("v_dzeb002_1") THEN
                     LET g_ooez2_d[l_ac].ooez004 = g_ooez2_d_o.ooez004
                     CALL aooi500_ooez004_ref()
                     NEXT FIELD CURRENT
                  END IF
                  CALL aooi500_key_chk()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = g_errno
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET g_ooez2_d[l_ac].ooez004 = g_ooez2_d_o.ooez004
                     CALL aooi500_ooez004_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_ooez2_d_o.ooez004 = g_ooez2_d[l_ac].ooez004
            CALL aooi500_ooez004_ref()
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD ooez004
            #add-point:BEFORE FIELD ooez004

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE ooez004
            #add-point:ON CHANGE ooez004

            #END add-point
         
         
         #此段落由子樣板a01產生
         BEFORE FIELD ooez008
            #add-point:BEFORE FIELD ooez004
 
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ooez008
            
            #add-point:AFTER FIELD ooez008
            IF NOT cl_null(g_ooez2_d[l_ac].ooez008) THEN
               IF g_ooez2_d[l_ac].ooez008 != g_ooez2_d_o.ooez008 OR cl_null(g_ooez2_d_o.ooez008) THEN
                  IF g_ooez2_d[l_ac].ooez008 = 'N' THEN
                     LET g_ooez2_d[l_ac].ooez005 = ''
                     LET g_ooez2_d[l_ac].ooez006 = ''
                     LET g_ooez2_d[l_ac].ooez007 = ''
                  END IF
                  IF g_ooez2_d[l_ac].ooez008 = 'Y' THEN
                     IF g_ooez2_d[l_ac].ooez002 = '1' THEN
                        LET g_ooez2_d[l_ac].ooez005 = '1'
                        LET g_ooez2_d[l_ac].ooez007 = '3'
                     END IF
                     IF NOT (g_ooez2_d[l_ac].ooez002 = '1' AND(
                             g_ooez2_d[l_ac].ooez006 = '9' OR
                             g_ooez2_d[l_ac].ooez006 = '10' OR
                             g_ooez2_d[l_ac].ooez006 = '11' OR
                             g_ooez2_d[l_ac].ooez006 = '12' )) THEN
                        LET g_ooez2_d[l_ac].ooez007 = '2'
                     END IF
                  END IF
               END IF
               DISPLAY BY NAME g_ooez2_d[l_ac].ooez008
            END IF
            LET g_ooez2_d_o.ooez005 = g_ooez2_d[l_ac].ooez005
            LET g_ooez2_d_o.ooez006 = g_ooez2_d[l_ac].ooez006
            LET g_ooez2_d_o.ooez007 = g_ooez2_d[l_ac].ooez007
            LET g_ooez2_d_o.ooez008 = g_ooez2_d[l_ac].ooez008
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE ooez008
            #add-point:ON CHANGE ooez008
            CALL aooi500_set_entry_b(l_cmd)
            CALL aooi500_set_no_entry_b(l_cmd)
            #END add-point
            
         #此段落由子樣板a01產生
         BEFORE FIELD ooez005
            #add-point:BEFORE FIELD ooez005

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ooez005
            
            #add-point:AFTER FIELD ooez005
            CALL aooi500_set_entry_b(l_cmd)
            CALL aooi500_set_no_entry_b(l_cmd)
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE ooez005
            #add-point:ON CHANGE ooez005
            IF NOT cl_null(g_ooez2_d[l_ac].ooez005) THEN
               LET g_ooez2_d[l_ac].ooez006 = ''
               LET g_ooez2_d[l_ac].ooez007 = '2'
            END IF
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ooez006
            #add-point:BEFORE FIELD ooez006
 
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ooez006
            
            #add-point:AFTER FIELD ooez006
            IF NOT cl_null(g_ooez2_d[l_ac].ooez006) THEN
               IF g_ooez2_d[l_ac].ooez006 != g_ooez2_d_o.ooez006 OR cl_null(g_ooez2_d_o.ooez006) THEN
                  IF NOT (g_ooez2_d[l_ac].ooez006 = '10' OR
                          g_ooez2_d[l_ac].ooez006 = '11' OR
                          g_ooez2_d[l_ac].ooez006 = '12' OR
                          g_ooez2_d[l_ac].ooez006 = '13' ) THEN
                     LET g_ooez2_d[l_ac].ooez007 = '2'
                  END IF
               END IF
            END IF
            LET g_ooez2_d_o.ooez006 = g_ooez2_d[l_ac].ooez006
            LET g_ooez2_d_o.ooez007 = g_ooez2_d[l_ac].ooez007
            CALL aooi500_set_entry_b(l_cmd)
            CALL aooi500_set_no_entry_b(l_cmd)
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE ooez006
            #add-point:ON CHANGE ooez006
            IF NOT cl_null(g_ooez2_d[l_ac].ooez006) THEN
               CALL aooi500_ooez006_chk()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = g_errno
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET g_ooez2_d[l_ac].ooez006 = g_ooez2_d_t.ooez006
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ooez007
            #add-point:BEFORE FIELD ooez007

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ooez007
            
            #add-point:AFTER FIELD ooez007

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE ooez007
            #add-point:ON CHANGE ooez007

            #END add-point
 
 
                  #Ctrlp:input.c.page2.ooezacti
         ON ACTION controlp INFIELD ooezacti
            #add-point:ON ACTION controlp INFIELD ooezacti

            #END add-point
 
         #Ctrlp:input.c.page2.ooez002
         ON ACTION controlp INFIELD ooez002
            #add-point:ON ACTION controlp INFIELD ooez002

            #END add-point
 
         #Ctrlp:input.c.page2.ooez003
         ON ACTION controlp INFIELD ooez003
            #add-point:ON ACTION controlp INFIELD ooez003
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_ooez2_d[l_ac].ooez003 #給予default值
            
            LET l_gzzz002 = ''
            CALL s_aooi500_get_gzzz002(g_master.ooez001) RETURNING l_gzzz002
            LET g_qryparam.arg1 = l_gzzz002
            CALL q_dzea002_2()                                #呼叫開窗
            LET g_ooez2_d[l_ac].ooez003 = g_qryparam.return1
            DISPLAY g_ooez2_d[l_ac].ooez003 TO ooez003
            CALL aooi500_ooez003_ref()
            NEXT FIELD ooez003                          #返回原欄位
            #END add-point
 
         #Ctrlp:input.c.page2.ooez004
         ON ACTION controlp INFIELD ooez004
            #add-point:ON ACTION controlp INFIELD ooez004
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_ooez2_d[l_ac].ooez004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_ooez2_d[l_ac].ooez003
            CALL q_dzeb002_9()                                #呼叫開窗
            LET g_ooez2_d[l_ac].ooez004 = g_qryparam.return1
            DISPLAY g_ooez2_d[l_ac].ooez004 TO ooez004
            CALL aooi500_ooez004_ref()
            NEXT FIELD ooez004                          #返回原欄位
            #END add-point
 
         #Ctrlp:input.c.page2.ooez005
         ON ACTION controlp INFIELD ooez005
            #add-point:ON ACTION controlp INFIELD ooez005

            #END add-point
 
         #Ctrlp:input.c.page2.ooez006
         ON ACTION controlp INFIELD ooez006
            #add-point:ON ACTION controlp INFIELD ooez006

            #END add-point
 
         #Ctrlp:input.c.page2.ooez007
         ON ACTION controlp INFIELD ooez007
            #add-point:ON ACTION controlp INFIELD ooez007

            #END add-point
 
 
 
         AFTER ROW
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_ooez2_d[l_ac].* = g_ooez2_d_t.*
               END IF
               CLOSE aooi500_bcl2
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
 
            CALL aooi500_unlock_b("ooez_t")
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #add-point:input段after input 

            #end add-point   
 
         ON ACTION controlo   
            CALL FGL_SET_ARR_CURR(g_ooez2_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_ooez2_d.getLength()+1
 
      END INPUT
 
      
 
    
      DISPLAY ARRAY g_ooez3_d TO s_detail3.*
         ATTRIBUTES(COUNT=g_detail_cnt)  
      
         BEFORE DISPLAY 
            CALL FGL_SET_ARR_CURR(g_detail_idx2)
            CALL aooi500_fetch()
            LET g_current_page = 3
            
         BEFORE ROW
            LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail3")
            LET l_ac = g_detail_idx
            CALL cl_show_fld_cont() 
            CALL aooi500_idx_chk('d')
            
         #add-point:page3自定義行為

         #end add-point
            
      END DISPLAY
 
      
      #add-point:input段input_array"

      #end add-point
      
      BEFORE DIALOG 
         LET g_curr_diag = ui.DIALOG.getCurrent()
         IF g_detail_idx > 0 THEN
            IF g_detail_idx > g_ooez_d.getLength() THEN
               LET g_detail_idx = g_ooez_d.getLength()
            END IF
            CALL DIALOG.setCurrentRow("s_detail1", g_detail_idx)
            LET l_ac = g_detail_idx
         END IF 
         LET g_detail_idx = l_ac
         #add-point:input段input_array"

         #end add-point
         #先確定單頭(第一單身)是否有資料
         IF g_ooez_d.getLength() > 0 THEN
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD ooez001
               WHEN "s_detail2"
                  NEXT FIELD ooezacti
               WHEN "s_detail3"
                  NEXT FIELD ooez002_3
 
            END CASE
         ELSE
            NEXT FIELD ooez001
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
 
   CLOSE aooi500_bcl
   CALL s_transaction_end('Y','0')
   
END FUNCTION
 
{</section>}
 
{<section id="aooi500.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aooi500_b_fill(p_wc2)
   DEFINE p_wc2           STRING
   DEFINE l_ac_t          LIKE type_t.num5
   #add-point:b_fill段define
 
   #end add-point
 
   #add-point:b_fill段sql_before

   #end add-point
   
   LET g_sql = "SELECT UNIQUE t0.ooez001,' ',' ',t1.gzzal003 FROM ooez_t t0",
               "  LEFT JOIN gzzal_t t1 ON t1.gzzal001=t0.ooez001 AND gzzal002='"||g_lang||"' ",
               " WHERE t0.ooezent= ?  AND  1=1 AND ", p_wc2
    
   LET g_sql = g_sql, cl_sql_add_filter("ooez_t"),
                      " ORDER BY t0.ooez001"
  
   #add-point:b_fill段sql_after

   #end add-point
  
   #LET g_sql = cl_sql_add_tabid(g_sql,"ooez_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料  
   PREPARE aooi500_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aooi500_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_ooez_d.clear()
   CALL g_ooez2_d.clear()   
   CALL g_ooez3_d.clear()   
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_ooez_d[l_ac].ooez001,g_ooez_d[l_ac].ooez002,
                            g_ooez_d[l_ac].ooez004,g_ooez_d[l_ac].ooez001_desc 
 
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
   
 
   CALL g_ooez_d.deleteElement(g_ooez_d.getLength())   
   CALL g_ooez2_d.deleteElement(g_ooez2_d.getLength())
   CALL g_ooez3_d.deleteElement(g_ooez3_d.getLength())
 
   
   #確定指標無超過上限, 超過則指到最後一筆
   IF g_detail_idx > g_ooez_d.getLength() THEN
      LET g_detail_idx = g_ooez_d.getLength()
   END IF
   
   #將key欄位填到每個page
   LET l_ac_t = g_detail_idx
   FOR g_detail_idx = 1 TO g_ooez_d.getLength()
      #LET g_ooez2_d[g_detail_idx2].ooez002 = g_ooez_d[g_detail_idx].ooez001 
      #LET g_ooez2_d[g_detail_idx2].ooez004 =  
      #LET g_ooez3_d[g_detail_idx2].ooez002 = g_ooez_d[g_detail_idx].ooez001 
      #LET g_ooez3_d[g_detail_idx2].ooez004 =  
 
   END FOR
   LET g_detail_idx = l_ac_t
   
   #add-point:b_fill段資料填充(其他單身)

   #end add-point
    
   LET g_detail_cnt = l_ac - 1
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aooi500_pb
   
   LET g_loc = 'm'
   CALL aooi500_detail_show() 
   
   LET l_ac = 1
   IF g_ooez_d.getLength() > 0 THEN
      CALL aooi500_fetch()
   END IF
   
   ERROR "" 
   
END FUNCTION
 
{</section>}
 
{<section id="aooi500.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aooi500_fetch()
   DEFINE li_ac           LIKE type_t.num5
   #add-point:fetch段define
 
   #end add-point
   
   #判定單頭是否有資料
   IF g_detail_idx <= 0 OR g_ooez_d.getLength() = 0 THEN
      RETURN
   END IF
   
   CALL g_ooez2_d.clear()
   CALL g_ooez3_d.clear()
 
   
   LET li_ac = l_ac 
   
   LET g_sql = "SELECT t0.ooezacti, t0.ooez002,  t0.ooez003,  t0.ooez004,
                       t0.ooez008,  t0.ooez005,  t0.ooez006,  t0.ooez007,
                       t0.ooez002,  t0.ooez004,  t0.ooezownid,t0.ooezowndp,
                       t0.ooezcrtid,t0.ooezcrtdp,t0.ooezcrtdt,t0.ooezmodid,
                       t0.ooezmoddt,t2.dzeal003, t3.dzebl003, t4.ooag011,
                       t5.ooefl003, t6.ooag011,  t7.ooefl003, t8.ooag011
                  FROM ooez_t t0", 
               " LEFT JOIN dzeal_t t2 ON t2.dzeal001=t0.ooez003 AND t2.dzeal002='"||g_dlang||"' ",
               " LEFT JOIN dzebl_t t3 ON t3.dzebl001=t0.ooez004 AND t3.dzebl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent='"||g_enterprise||"' AND t4.ooag001=t0.ooezownid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent='"||g_enterprise||"' AND t5.ooefl001=t0.ooezowndp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent='"||g_enterprise||"' AND t6.ooag001=t0.ooezcrtid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent='"||g_enterprise||"' AND t7.ooefl001=t0.ooezcrtdp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent='"||g_enterprise||"' AND t8.ooag001=t0.ooezmodid  ",
 
               " WHERE t0.ooezent=?  AND t0. ooez001=?"
 
   IF NOT cl_null(g_wc2_table2) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
   END IF
 
   LET g_sql = g_sql, " ORDER BY t0.ooez002,t0.ooez004" 
                      
   #add-point:單身填充前

   #end add-point
   
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料    
   PREPARE aooi500_pb2 FROM g_sql
   DECLARE b_fill_curs2 CURSOR FOR aooi500_pb2
   
   LET l_ac = g_detail_idx
   OPEN b_fill_curs2 USING g_enterprise,g_ooez_d[l_ac].ooez001
   
   LET l_ac = 1
   FOREACH b_fill_curs2
      INTO g_ooez2_d[l_ac].ooezacti, g_ooez2_d[l_ac].ooez002,  g_ooez2_d[l_ac].ooez003,   g_ooez2_d[l_ac].ooez004,
           g_ooez2_d[l_ac].ooez008,  g_ooez2_d[l_ac].ooez005,  g_ooez2_d[l_ac].ooez006,   g_ooez2_d[l_ac].ooez007,
           g_ooez3_d[l_ac].ooez002,  g_ooez3_d[l_ac].ooez004,  g_ooez3_d[l_ac].ooezownid, g_ooez3_d[l_ac].ooezowndp,
           g_ooez3_d[l_ac].ooezcrtid,      g_ooez3_d[l_ac].ooezcrtdp,      g_ooez3_d[l_ac].ooezcrtdt,      g_ooez3_d[l_ac].ooezmodid,
           g_ooez3_d[l_ac].ooezmoddt,      g_ooez2_d[l_ac].ooez003_desc,   g_ooez2_d[l_ac].ooez004_desc,   g_ooez3_d[l_ac].ooezownid_desc,
           g_ooez3_d[l_ac].ooezowndp_desc, g_ooez3_d[l_ac].ooezcrtid_desc, g_ooez3_d[l_ac].ooezcrtdp_desc, g_ooez3_d[l_ac].ooezmodid_desc
 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #add-point:b_fill段資料填充
      IF cl_null(g_ooez2_d[l_ac].ooez002) THEN
         CONTINUE FOREACH
      END IF
      IF g_ooez2_d[l_ac].ooezacti IS NULL THEN
         LET g_ooez2_d[l_ac].ooezacti = 'Y'
      END IF
      CALL aooi500_detail_show()
      #end add-point
      
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
      
   END FOREACH
 
 
 
   #add-point:單身填充後

   #end add-point
   
   CALL g_ooez2_d.deleteElement(g_ooez2_d.getLength())   
   CALL g_ooez3_d.deleteElement(g_ooez3_d.getLength())   
 
   
   LET g_loc = 'd'
   CALL aooi500_detail_show()
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="aooi500.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aooi500_set_entry_b(p_cmd)                                                  
   DEFINE p_cmd   LIKE type_t.chr1         
   #add-point:set_entry_b段define
   
   #end add-point
   
   #add-point:set_entry段欄位控制後
   CALL cl_set_comp_entry('ooez003',TRUE)   #表格代號
   CALL cl_set_comp_entry('ooez004',TRUE)   #欄位編號
   CALL cl_set_comp_entry('ooez005',TRUE)   #設定類型
   CALL cl_set_comp_entry('ooez006',TRUE)   #對應設定值
   CALL cl_set_comp_entry('ooez007',TRUE)   #組織結構
   #end add-point 
                                                                     
END FUNCTION                                                                    
 
{</section>}
 
{<section id="aooi500.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aooi500_set_no_entry_b(p_cmd)                                               
   DEFINE p_cmd   LIKE type_t.chr1           
   #add-point:set_no_entry_b段define
   
   #end add-point
   
   #add-point:set_no_entry段欄位控制後
   IF g_current_page = '2' THEN
      IF g_ooez2_d[l_ac].ooez008 = 'N' THEN
         CALL cl_set_comp_entry('ooez005',FALSE)     #設定類型
         CALL cl_set_comp_entry('ooez006',FALSE)     #對應設定值
         CALL cl_set_comp_entry('ooez007',FALSE)     #組織結構
      END IF
      IF g_ooez2_d[l_ac].ooez002 = '1' OR g_ooez2_d[l_ac].ooez002 = '2' THEN
         CALL cl_set_comp_entry('ooez003',FALSE)     #表格代號
         CALL cl_set_comp_entry('ooez004',FALSE)     #欄位編號
      END IF
      IF g_ooez2_d[l_ac].ooez002 = '1' THEN
         CALL cl_set_comp_entry('ooez005',FALSE)     #設定類型
      END IF
      IF g_ooez2_d[l_ac].ooez005 = '2' THEN
         CALL cl_set_comp_entry('ooez007',FALSE)     #組織結構
      END IF
      IF NOT (g_ooez2_d[l_ac].ooez002 = '1' AND(
              #161228-00054#1 20161228 add by beckxie(補上160615-00028#1修改內容)---S
              g_ooez2_d[l_ac].ooez006 = '8' OR  #160615-00028#1 20160620 add by beckxie
              #161228-00054#1 20161228 add by beckxie(補上160615-00028#1修改內容)---E
              g_ooez2_d[l_ac].ooez006 = '9' OR
              g_ooez2_d[l_ac].ooez006 = '10' OR
              g_ooez2_d[l_ac].ooez006 = '11' OR
              g_ooez2_d[l_ac].ooez006 = '12' )) THEN
         CALL cl_set_comp_entry('ooez007',FALSE)     #組織結構
      END IF
   END IF
   #end add-point 
                                                                          
END FUNCTION  
 
{</section>}
 
{<section id="aooi500.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aooi500_detail_show()
   DEFINE l_ac_t LIKE type_t.num5
   #add-point:show段define

   #end add-point
   
   LET l_ac_t = l_ac
 
   #add-point:detail_show段之前

   #end add-point
   
   
   
   #帶出公用欄位reference值page1
   
    
   #帶出公用欄位reference值page2
   
   #帶出公用欄位reference值page3
   
 
 
   
   IF g_loc = 'm' THEN
      #讀入ref值
      FOR l_ac = 1 TO g_ooez_d.getLength()
         #add-point:show段單頭reference
 
         #end add-point
 
      END FOR
   END IF
   
   IF g_loc = 'd' THEN
      FOR l_ac = 1 TO g_ooez2_d.getLength()
        #add-point:show段單身reference

        #end add-point
      END FOR
      FOR l_ac = 1 TO g_ooez3_d.getLength()
        #add-point:show段單身reference

        #end add-point
      END FOR
 
      
      #add-point:detail_show段之後

      #end add-point
   END IF
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="aooi500.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aooi500_default_search()
   DEFINE li_idx  LIKE type_t.num5
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE ls_wc   STRING
   #add-point:default_search段define

   #end add-point  
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " ooez001 = '", g_argv[01], "' AND "
   END IF
   
 
   
   IF NOT cl_null(ls_wc) THEN
      LET ls_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_wc = ls_wc
   ELSE
      LET g_wc = " 1=1"
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aooi500.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aooi500_delete_b(ps_table,ps_keys_bak,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:delete_b段define

   #end add-point     
 
   #判斷是否是同一群組的table
   LET ls_group = "ooez_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:delete_b段刪除前

      #end add-point  
      DELETE FROM ooez_t
       WHERE ooezent = g_enterprise
         AND ooez001 = ps_keys_bak[1]
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
   END IF
   
 
   
   LET ls_group = "ooez_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:delete_b段刪除前

      #end add-point  
      DELETE FROM ooez_t
       WHERE ooezent = g_enterprise AND
         ooez001 = ps_keys_bak[1] AND ooez002 = ps_keys_bak[2] AND ooez004 = ps_keys_bak[3]
      #add-point:delete_b段刪除中

      #end add-point  
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ooez_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
      END IF
      #add-point:delete_b段刪除後

      #end add-point  
      RETURN
   END IF
 
 
   
   #單頭刪除, 連帶刪除單身
   LET ls_group = "ooez_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:delete_b段刪除前

      #end add-point  
      DELETE FROM ooez_t
       WHERE ooezent = g_enterprise AND
         ooez001 = ps_keys_bak[1]
      #add-point:delete_b段刪除中

      #end add-point  
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ooez_t" 
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
 
{<section id="aooi500.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aooi500_insert_b(ps_table,ps_keys,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:insert_b段define
 
   #end add-point
 
   #判斷是否是同一群組的table
   LET ls_group = "ooez_1,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:insert_b段新增前

      #end add-point
      INSERT INTO ooez_t
                  (ooezent,ooez001,ooez002,ooez004) 
            VALUES(g_enterprise,ps_keys[1],
                   g_ooez_d[g_detail_idx].ooez002,
                   g_ooez_d[g_detail_idx].ooez004)
      #add-point:insert_b段新增中

      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ooez_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
      END IF
      #add-point:insert_b段新增後

      #end add-point
   END IF
   
 
   
   LET ls_group = "ooez_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:insert_b段新增前
 
      #end add-point
      INSERT INTO ooez_t
                  (ooezent,ooez001,ooez002,ooez004,
                   ooezacti,ooez003,ooez005,ooez006,
                   ooez007,ooez008,ooezownid,ooezowndp,
                   ooezcrtid,ooezcrtdp,ooezcrtdt,ooezmodid,
                   ooezmoddt) 
            VALUES(g_enterprise,ps_keys[1],ps_keys[2],ps_keys[3],
                   g_ooez2_d[g_detail_idx2].ooezacti,g_ooez2_d[g_detail_idx2].ooez003,g_ooez2_d[g_detail_idx2].ooez005, 
                   g_ooez2_d[g_detail_idx2].ooez006,g_ooez2_d[g_detail_idx2].ooez007,g_ooez2_d[g_detail_idx2].ooez008,
                   g_ooez3_d[g_detail_idx2].ooezownid,g_ooez3_d[g_detail_idx2].ooezowndp,g_ooez3_d[g_detail_idx2].ooezcrtid,
                   g_ooez3_d[g_detail_idx2].ooezcrtdp,g_ooez3_d[g_detail_idx2].ooezcrtdt,g_ooez3_d[g_detail_idx2].ooezmodid,
                   g_ooez3_d[g_detail_idx2].ooezmoddt) 
 
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
 
{<section id="aooi500.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aooi500_unlock_b(ps_table)
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:unlock_b段define
   
   #end add-point  
   
   LET ls_group = ""
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      CLOSE aooi500_bcl
   END IF
   
 
    
   LET ls_group = "ooez_t,"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      CLOSE aooi500_bcl2
   END IF
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="aooi500.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aooi500_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "ooez_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "ooez_t" THEN
   
      #add-point:update_b段修改前

      #end add-point     
   
      UPDATE ooez_t 
         SET (ooez001,ooez002,ooez004) = 
             (ps_keys[1],
             g_ooez_d[g_detail_idx].ooez002,
             g_ooez_d[g_detail_idx].ooez004) 
         WHERE ooez001 = ps_keys_bak[1]
 
      #add-point:update_b段修改中
           AND ooezent = g_enterprise #161008-00003#1 add  
      #end add-point 
         
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "ooez_t" 
            LET g_errparam.code   = "std-00009" 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "ooez_t" 
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
   
 
   
   LET ls_group = "ooez_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "ooez_t" THEN
   
      #add-point:update_b段修改前
 
      #end add-point    
      
      UPDATE ooez_t 
         SET (ooez001,ooez002,ooez004,
              ooezacti,ooez003,ooez005,
              ooez006,ooez007,ooez008,
              ooezownid,ooezowndp,ooezcrtid,
              ooezcrtdp,ooezcrtdt,ooezmodid,
              ooezmoddt) 
           = (ps_keys[1],ps_keys[2],ps_keys[3],
              g_ooez2_d[g_detail_idx2].ooezacti,g_ooez2_d[g_detail_idx2].ooez003,g_ooez2_d[g_detail_idx2].ooez005, 
              g_ooez2_d[g_detail_idx2].ooez006, g_ooez2_d[g_detail_idx2].ooez007,g_ooez2_d[g_detail_idx2].ooez008,
              g_ooez3_d[g_detail_idx2].ooezownid,g_ooez3_d[g_detail_idx2].ooezowndp,g_ooez3_d[g_detail_idx2].ooezcrtid,
              g_ooez3_d[g_detail_idx2].ooezcrtdp,g_ooez3_d[g_detail_idx2].ooezcrtdt,g_ooez3_d[g_detail_idx2].ooezmodid,
              g_ooez3_d[g_detail_idx2].ooezmoddt)  
 
         WHERE ooez001 = ps_keys_bak[1] AND ooez002 = ps_keys_bak[2] AND ooez004 = ps_keys_bak[3]
 
      #add-point:update_b段修改中
           AND ooezent = g_enterprise #161008-00003#1 add
      #end add-point 
         
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "ooez_t" 
            LET g_errparam.code   = "std-00009" 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "ooez_t" 
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
 
{<section id="aooi500.key_update_b" >}
#+ 單頭key欄位變動後, 連帶修正其他單身table
PRIVATE FUNCTION aooi500_key_update_b()
   DEFINE li_idx           LIKE type_t.num5 
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   #add-point:update_b段define

   #end add-point
 
   #判斷key是否有改變
   LET lb_chk = TRUE
   
   IF g_master.ooez001 <> g_master_t.ooez001 THEN
      LET lb_chk = FALSE
   END IF
 
   #不需要做處理
   IF lb_chk THEN
      RETURN
   END IF
    
   #add-point:update_b段修改前

   #end add-point
   
   UPDATE ooez_t 
      SET (ooez001) = (g_master.ooez001) 
    WHERE ooez001 = g_master_t.ooez001
 
           
   #add-point:update_b段修改中
      AND ooezent = g_enterprise #161008-00003#1 add
   #end add-point
           
   CASE
      #WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
      #   INITIALIZE g_errparam TO NULL 
      #   LET g_errparam.extend = "ooez_t" 
      #   LET g_errparam.code   = "std-00009" 
      #   LET g_errparam.popup  = TRUE 
      #   CALL cl_err()
 
      #   CALL s_transaction_end('N','0')
      WHEN SQLCA.sqlcode #其他錯誤
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ooez_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
      OTHERWISE
         #若有多語言table資料一同更新
         
   END CASE
   
   #add-point:update_b段修改後

   #end add-point
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="aooi500.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aooi500_lock_b(ps_table)
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define

   #end add-point   
   
   #先刷新資料
   #CALL aooi500_b_fill(g_wc)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "ooez_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aooi500_bcl USING g_enterprise,
                             g_ooez_d[g_detail_idx].ooez001
                                       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aooi500_bcl" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   #鎖定整組table
   #LET ls_group = "ooez_t,"
   #僅鎖定自身table
   LET ls_group = "ooez_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN aooi500_bcl2 USING g_enterprise,
                              g_master.ooez001,
                              g_ooez2_d[g_detail_idx2].ooez002,
                              g_ooez2_d[g_detail_idx2].ooez004 
 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aooi500_bcl2" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         RETURN FALSE
      END IF
   END IF
 
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aooi500.state_change" >}
    
 
{</section>}
 
{<section id="aooi500.idx_chk" >}
#+ 單身筆數變更
PRIVATE FUNCTION aooi500_idx_chk(ps_loc)
   DEFINE ps_loc   LIKE type_t.chr10
   DEFINE li_idx   LIKE type_t.num5
   DEFINE li_cnt   LIKE type_t.num5
   #add-point:idx_chk段define

   #end add-point  
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_ooez_d.getLength() THEN
         LET g_detail_idx = g_ooez_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_ooez_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      LET li_idx = g_detail_idx
      LET li_cnt = g_ooez_d.getLength()
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx2 = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx2 > g_ooez2_d.getLength() THEN
         LET g_detail_idx2 = g_ooez2_d.getLength()
      END IF
      IF g_detail_idx2 = 0 AND g_ooez2_d.getLength() <> 0 THEN
         LET g_detail_idx2 = 1
      END IF
      LET li_idx = g_detail_idx2
      LET li_cnt = g_ooez2_d.getLength()
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx2 = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx2 > g_ooez3_d.getLength() THEN
         LET g_detail_idx2 = g_ooez3_d.getLength()
      END IF
      IF g_detail_idx2 = 0 AND g_ooez3_d.getLength() <> 0 THEN
         LET g_detail_idx2 = 1
      END IF
      LET li_idx = g_detail_idx2
      LET li_cnt = g_ooez3_d.getLength()
   END IF
 
    
   IF ps_loc = 'm' THEN
      DISPLAY li_idx TO FORMONLY.h_index
      DISPLAY li_cnt TO FORMONLY.h_count
      IF g_ooez2_d.getLength() = 0 THEN
         DISPLAY '' TO FORMONLY.idx
         DISPLAY '' TO FORMONLY.cnt
      ELSE
         DISPLAY 1 TO FORMONLY.idx
         DISPLAY g_ooez2_d.getLength() TO FORMONLY.cnt
      END IF
      IF g_ooez3_d.getLength() = 0 THEN
         DISPLAY '' TO FORMONLY.idx
         DISPLAY '' TO FORMONLY.cnt
      ELSE
         DISPLAY 1 TO FORMONLY.idx
         DISPLAY g_ooez3_d.getLength() TO FORMONLY.cnt
      END IF
 
   ELSE
      DISPLAY li_idx TO FORMONLY.idx
      DISPLAY li_cnt TO FORMONLY.cnt
   END IF
   
   #add-point:idx_chk段other

   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aooi500.set_pk_array" >}
   #+ 此段落由子樣板a51產生
#+ 給予pk_array內容
PRIVATE FUNCTION aooi500_set_pk_array()
   #add-point:set_pk_array段define

   #end add-point
   
   #add-point:set_pk_array段之前

   #end add-point  
   
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_ooez_d[l_ac].ooez001
   LET g_pk_array[1].column = 'ooez001'
 
   
   #add-point:set_pk_array段之後

   #end add-point  
   
END FUNCTION
 
 
 
{</section>}
 
{<section id="aooi500.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="aooi500.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 表格代號帶出說明
# Memo...........:
# Usage..........: CALL aooi500_ooez003_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/07/21 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION aooi500_ooez003_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_ooez2_d[l_ac].ooez003
   CALL ap_ref_array2(g_ref_fields,"SELECT dzeal003 FROM dzeal_t WHERE dzeal001=? AND dzeal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_ooez2_d[l_ac].ooez003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_ooez2_d[l_ac].ooez003_desc
END FUNCTION

################################################################################
# Descriptions...: 欄位代號帶出說明
# Memo...........:
# Usage..........: CALL aooi500_ooez004_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/07/21 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION aooi500_ooez004_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_ooez2_d[l_ac].ooez004
   CALL ap_ref_array2(g_ref_fields,"SELECT dzebl003 FROM dzebl_t WHERE dzebl001=? AND dzebl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_ooez2_d[l_ac].ooez004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_ooez2_d[l_ac].ooez004_desc
END FUNCTION

################################################################################
# Descriptions...: 欄位類型檢查
# Memo...........:
# Usage..........: CALL aooi500_ooez002_chk()
#                     RETURNING r_success
# Input parameter: 無
# Return code....: r_success     True/False
# Date & Author..: 2014/07/21 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION aooi500_ooez002_chk()
DEFINE r_success      LIKE type_t.num5
DEFINE l_cnt          LIKE type_t.num5
#150209-00003#1 150324 By pomelo add(S)
DEFINE l_gzcb002      LIKE gzcb_t.gzcb002
DEFINE l_sql          STRING

#150209-00003#1 150324 By pomelo add(E)

   LET r_success = TRUE
   
   #150209-00003#1 150324 By pomelo add(S)
   IF g_ooez2_d[l_ac].ooez002 = '1' THEN
      LET l_sql = "SELECT gzcb002",
                  "  FROM gzcb_t",
                  " WHERE gzcb001 = '6770'",
                  " ORDER BY gzcb002"
      PREPARE aooi500_ooez002_pre FROM l_sql
      DECLARE aooi500_ooez002_curs CURSOR FOR aooi500_ooez002_pre
      
      FOREACH aooi500_ooez002_curs INTO l_gzcb002
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'Foreach aooi500_ooez002_curs'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success
         END IF
         
         IF l_gzcb002 = g_master.ooez001 THEN
            #此作業已經設定在SCC=6770裡，不可以設定欄位類型 = 1.營運組織！
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'aoo-00636'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success
         END IF
      END FOREACH
   END IF
   #150209-00003#1 150324 By pomelo add(E)
   
   CALL aooi500_key_chk()
   IF cl_null(g_errno) THEN
      LET l_cnt = 0
      
      #檢查營運組織與應用組織都只能存在作業編號各一
      LET g_sql = "SELECT COUNT(ooez002)",
                  "  FROM ooez_t",
                  " WHERE ooezent = ",g_enterprise,
                  "   AND ooez001 = '",g_master.ooez001,"'",
                  "   AND ooez002 = '",g_ooez2_d[l_ac].ooez002,"'"
      PREPARE aooi500_pre FROM g_sql
      
      CASE g_ooez2_d[l_ac].ooez002
         WHEN '1'
            EXECUTE aooi500_pre INTO l_cnt
            IF l_cnt >= 1 THEN
               #同一個作業編號只能存在一個營運組織！
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "" 
               LET g_errparam.code   = 'aoo-00339'
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET r_success = FALSE
               RETURN r_success
            ELSE
               LET g_ooez2_d[l_ac].ooez005 = '1'
            END IF
         WHEN '2'
            EXECUTE aooi500_pre INTO l_cnt
            IF l_cnt >= 1 THEN
               #同一個作業編號只能存在一個應用組織！
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "" 
               LET g_errparam.code   = 'aoo-00340'
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET r_success = FALSE
               RETURN r_success
            END IF
      END CASE
   END IF

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 作業編號檢查
# Memo...........:
# Usage..........: CALL aooi500_ooez001_chk()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/07/21 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION aooi500_ooez001_chk()
DEFINE l_cnt          LIKE type_t.num5

   LET g_errno = ''
   LET l_cnt = 0
   SELECT COUNT(ooez001) INTO l_cnt
     FROM ooez_t
    WHERE ooezent = g_enterprise
      AND ooez001 = g_ooez_d[l_ac].ooez001
      
   IF l_cnt >= 1 THEN
      #此作業編號 已存在 作業組織應用設定檔 中！
      LET g_errno = 'aoo-00341'
   END IF
END FUNCTION

################################################################################
# Descriptions...: Key值檢查
# Memo...........:
# Usage..........: CALL aooi500_key_chk()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/07/21 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION aooi500_key_chk()
DEFINE l_cnt               LIKE type_t.num5

   LET g_errno = ''

   IF cl_null(g_ooez2_d[l_ac].ooez002) THEN LET g_ooez2_d[l_ac].ooez002 = ' ' END IF
   IF cl_null(g_ooez2_d[l_ac].ooez004) THEN LET g_ooez2_d[l_ac].ooez004 = ' ' END IF
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM ooez_t
    WHERE ooezent = g_enterprise
      AND ooez001 = g_master.ooez001
      AND ooez002 = g_ooez2_d[l_ac].ooez002
      AND ooez004 = g_ooez2_d[l_ac].ooez004

   IF l_cnt >= 1 THEN
      #此 作業編號+欄位類型+欄位代號 已存在 作業組織應用設定檔 中！
      LET g_errno = 'aoo-00342'
      RETURN
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 設定ooez006的下拉式選項
# Memo...........:
# Usage..........: CALL aooi500_set_ooez006_combo()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/07/25 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION aooi500_set_ooez006_combo()
DEFINE l_sql      STRING
DEFINE l_gzcb001  LIKE gzcb_t.gzcb001
DEFINE l_gzcb002  LIKE gzcb_t.gzcb002
DEFINE l_gzcbl004 LIKE gzcbl_t.gzcbl004
DEFINE l_ooez005  LIKE ooez_t.ooez005
DEFINE l_str1     STRING
DEFINE l_str2     STRING

   DELETE FROM aooi500_combo_t;

   LET l_sql = "SELECT gzcb001,gzcb002,gzcbl004",
               "  FROM gzcb_t LEFT JOIN gzcbl_t ON gzcb002 = gzcbl002",
               "                AND gzcb001 = gzcbl001",
               "                AND gzcb001 = gzcb001",
               "                AND gzcbl003 = '",g_dlang,"'",
               " WHERE gzcb001  IN ('6093','104')",
               " ORDER BY gzcb002"
   PREPARE aooi500_combo_pre FROM l_sql
   DECLARE aooi500_combo_curs CURSOR FOR aooi500_combo_pre
   
   LET l_str1 = ''
   LET l_str2 = ''
   FOREACH aooi500_combo_curs INTO l_gzcb001,l_gzcb002,l_gzcbl004
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'Foreach aooi500_combo_curs'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      IF l_gzcb001 = '6093' THEN
         LET l_ooez005 = '1'
         #161228-00054#1 20161228 add by beckxie(補上160615-00028#1修改內容)---S
         #IF l_gzcb002 = '9' OR l_gzcb002 = '10' OR                   #160615-00028#1 20160620 mark by beckxie   
         IF l_gzcb002 = '8' OR l_gzcb002 = '9' OR l_gzcb002 = '10' OR #160615-00028#1 20160620  add by beckxie
         #161228-00054#1 20161228 add by beckxie(補上160615-00028#1修改內容)---E
            l_gzcb002 = '11' OR l_gzcb002 = '12' OR
            l_gzcb002 = '13' THEN
            INSERT INTO aooi500_combo_t(ooez005,ooez006,gzcb002)
               VALUES(l_ooez005,l_gzcb002,l_gzcb002 )
         ELSE
            CONTINUE FOREACH
         END IF
      ELSE
         LET l_ooez005 = '2'
         IF l_gzcb002 MATCHES '[CDEFG]' THEN
            INSERT INTO aooi500_combo_t(ooez005,ooez006,gzcb002)
               VALUES(l_ooez005,l_gzcb002,l_gzcb002 )
         ELSE
            CONTINUE FOREACH
         END IF
      END IF

      LET l_str2 = l_str2,l_gzcbl004,","
      LET l_str1 = l_str1,l_gzcb002,","
   END FOREACH

   LET l_str1 = l_str1.subString(1,l_str1.getLength()-1)
   LET l_str2 = l_str2.subString(1,l_str2.getLength()-1)

   CALL cl_set_combo_items("ooez006",l_str1,l_str2)
END FUNCTION

################################################################################
# Descriptions...: 建立temp table
# Memo...........:
# Usage..........: CALL aooi500_create_tmp()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/07/25 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION aooi500_create_tmp()
   CREATE TEMP TABLE aooi500_combo_t(
      ooez005     LIKE ooez_t.ooez005,
      ooez006     LIKE ooez_t.ooez006,
      gzcb002     LIKE gzcb_t.gzcb002
   )
END FUNCTION

################################################################################
# Descriptions...: 檢查ooez006的值是否符合ooez005所選取的
# Memo...........:
# Usage..........: CALL aooi500_ooez006_chk()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/07/28 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION aooi500_ooez006_chk()
DEFINE l_cnt       LIKE type_t.num5
DEFINE l_ooez005   LIKE ooez_t.ooez005
DEFINE l_ooez006   LIKE ooez_t.ooez006

   LET g_errno = ''

   LET l_cnt = ''
   EXECUTE aooi500_ooez005
     USING g_ooez2_d[l_ac].ooez005,g_ooez2_d[l_ac].ooez006
      INTO l_cnt

   IF l_cnt = 0 THEN
      CASE g_ooez2_d[l_ac].ooez005
         WHEN '1' #組織類型
            LET g_errno = 'aoo-00352'
            RETURN
         WHEN '2' #組織職能
            LET g_errno = 'aoo-00353'
            RETURN
      END CASE
   END IF
   
   #當欄位類型=1營運組織
   #對應設定值不可以輸入銷售範圍
   IF g_ooez2_d[l_ac].ooez002 = '1' AND
      g_ooez2_d[l_ac].ooez006 = '13' THEN
      LET g_errno = 'aoo-00376'
   END IF
END FUNCTION

 
{</section>}
 
