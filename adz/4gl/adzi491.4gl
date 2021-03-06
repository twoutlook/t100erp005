#+ Version..: T6-ERP-1.00.00 Build-000000
#+ 
#+ Filename...: adzi491
#+ Buildtype..: 應用 i02 樣板自動產生
#+ Memo.......: 
#+ 以上段落由子樣板a00產生
 
 
{<point name="global.memo" />}
 
IMPORT os
#add-point:增加匯入項目
{<point name="global.import" />}
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
{<Module define>}
 
#單身 type 宣告
PRIVATE TYPE type_g_dzdi_d RECORD
       dzdi001 LIKE dzdi_t.dzdi001, 
   dzdi002 LIKE dzdi_t.dzdi002, 
   dzdi003 LIKE dzdi_t.dzdi003, 
   dzdi004 LIKE dzdi_t.dzdi004, 
   dzdi005 LIKE dzdi_t.dzdi005
       END RECORD
 
 
#無單身append欄位定義
 
#模組變數(Module Variables)
DEFINE g_dzdi_d          DYNAMIC ARRAY OF type_g_dzdi_d
DEFINE g_dzdi_d_t        type_g_dzdi_d
 
      
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
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
 
 
#多table用wc
DEFINE g_wc_table           STRING
 
 
{</Module define>}
 
#add-point:自定義模組變數(Module Variable)
{<point name="global.variable"/>}
#end add-point
 
#+ 此段落由子樣板a26產生
#+ 作業開始 
MAIN
   #add-point:main段define
   {<point name="main.define"/>}
   #end add-point   
 
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("adz","")
 
   #add-point:作業初始化
   {<point name="main.init" />}
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #LET g_forupd_sql = ""
   #LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)                #轉換不同資料庫語法
   #DECLARE adzi491_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call
      {<point name="main.servicecall" />}
      #end add-point
 
   ELSE
   
      #畫面開啟 (identifier)
      OPEN WINDOW w_adzi491 WITH FORM cl_ap_formpath("adz",g_code)
 
      #程式初始化
      CALL adzi491_init()   
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #進入選單 Menu (="N")
      CALL adzi491_ui_dialog() 
 
      #畫面關閉
      CLOSE WINDOW w_adzi491
      
   END IF 
   
   #CLOSE adzi491_cl
   
   
 
   #add-point:作業離開前
   {<point name="main.exit" />}
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN
 
 
 
#+ 畫面資料初始化
PRIVATE FUNCTION adzi491_init()
   #add-point:init段define
   {<point name="init.define"/>}
   #end add-point   
 
   #add-point:畫面資料初始化
   {<point name="init.init" />}
   #end add-point
   
   
   
   CALL adzi491_default_search()
   
END FUNCTION
 
 
#+ 功能選單 
PRIVATE FUNCTION adzi491_ui_dialog()
   {<Local define>}
   DEFINE li_idx   LIKE type_t.num5
   {</Local define>}
   #add-point:ui_dialog段define
   {<point name="ui_dialog.define"/>}
   #end add-point 
 
   LET g_action_choice = " "  
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()      
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   LET g_detail_idx = 1
   
   #add-point:ui_dialog段before dialog 
   {<point name="ui_dialog.before_dialog"/>}
   #end add-point
   
   WHILE TRUE
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF
      CALL adzi491_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_dzdi_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               CALL FGL_SET_ARR_CURR(g_detail_idx)
      
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               LET g_temp_idx = l_ac
               
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL cl_show_fld_cont() 
               
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
 
      
         #add-point:ui_dialog段define
         {<point name="ui_dialog.more_displayarray"/>}
         #end add-point
         
         BEFORE DIALOG
            IF g_temp_idx > 0 THEN
               LET l_ac = g_temp_idx
               CALL DIALOG.setCurrentRow("s_detail1",l_ac)
               LET g_temp_idx = 1
            END IF
            LET g_curr_diag = ui.DIALOG.getCurrent()         
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            NEXT FIELD CURRENT
      
         
 
         ON ACTION modify
 
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN 
               CALL adzi491_modify()
               #add-point:ON ACTION modify
               {<point name="menu.modify" />}
               #END add-point
                EXIT DIALOG
            END IF
 
 
 
         ON ACTION output
 
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN 
               #add-point:ON ACTION output
               {<point name="menu.output" />}
               #END add-point
                EXIT DIALOG
            END IF
 
 
 
         ON ACTION query
 
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN 
               CALL adzi491_query()
               #add-point:ON ACTION query
               {<point name="menu.query" />}
               #END add-point
            END IF
 
      
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice="exit"
            EXIT DIALOG
      
         ON ACTION exit
            LET g_action_choice="exit"
            EXIT DIALOG

         #carrier 20130729  --begin
         ON ACTION gen1
            LET g_action_choice="gen1"
            CALL adzi491_gen1()
            EXIT DIALOG

         ON ACTION gen2
            LET g_action_choice="gen2"
            CALL adzi491_gen2()
            EXIT DIALOG

         ON ACTION gen3
            LET g_action_choice="gen3"
            CALL adzi491_gen3()
            EXIT DIALOG

         #carrier 20130729  --end  
      
         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
 
#+ QBE資料查詢
PRIVATE FUNCTION adzi491_query()
   {<Local define>}
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   {</Local define>}
   #add-point:query段define
   {<point name="query.define"/>}
   #end add-point 
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_dzdi_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON dzdi001,dzdi002,dzdi003,dzdi004,dzdi005 
 
         FROM s_detail1[1].dzdi001,s_detail1[1].dzdi002,s_detail1[1].dzdi003,s_detail1[1].dzdi004,s_detail1[1].dzdi005 
      
         
      
         #---------------------<  Detail: page1  >---------------------
         #----<<dzdi001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdi001
            #add-point:BEFORE FIELD dzdi001
            {<point name="query.b.page1.dzdi001" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdi001
            
            #add-point:AFTER FIELD dzdi001
            {<point name="query.a.page1.dzdi001" />}
            #END add-point
            
 
         #Ctrlp:query.c.page1.dzdi001
#         ON ACTION controlp INFIELD dzdi001
            #add-point:ON ACTION controlp INFIELD dzdi001
            {<point name="query.c.page1.dzdi001" />}
            #END add-point
 
         #----<<dzdi002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdi002
            #add-point:BEFORE FIELD dzdi002
            {<point name="query.b.page1.dzdi002" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdi002
            
            #add-point:AFTER FIELD dzdi002
            {<point name="query.a.page1.dzdi002" />}
            #END add-point
            
 
         #Ctrlp:query.c.page1.dzdi002
#         ON ACTION controlp INFIELD dzdi002
            #add-point:ON ACTION controlp INFIELD dzdi002
            {<point name="query.c.page1.dzdi002" />}
            #END add-point
 
         #----<<dzdi003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdi003
            #add-point:BEFORE FIELD dzdi003
            {<point name="query.b.page1.dzdi003" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdi003
            
            #add-point:AFTER FIELD dzdi003
            {<point name="query.a.page1.dzdi003" />}
            #END add-point
            
 
         #Ctrlp:query.c.page1.dzdi003
#         ON ACTION controlp INFIELD dzdi003
            #add-point:ON ACTION controlp INFIELD dzdi003
            {<point name="query.c.page1.dzdi003" />}
            #END add-point
 
         #----<<dzdi004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdi004
            #add-point:BEFORE FIELD dzdi004
            {<point name="query.b.page1.dzdi004" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdi004
            
            #add-point:AFTER FIELD dzdi004
            {<point name="query.a.page1.dzdi004" />}
            #END add-point
            
 
         #Ctrlp:query.c.page1.dzdi004
#         ON ACTION controlp INFIELD dzdi004
            #add-point:ON ACTION controlp INFIELD dzdi004
            {<point name="query.c.page1.dzdi004" />}
            #END add-point
 
         #----<<dzdi005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdi005
            #add-point:BEFORE FIELD dzdi005
            {<point name="query.b.page1.dzdi005" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdi005
            
            #add-point:AFTER FIELD dzdi005
            {<point name="query.a.page1.dzdi005" />}
            #END add-point
            
 
         #Ctrlp:query.c.page1.dzdi005
#         ON ACTION controlp INFIELD dzdi005
            #add-point:ON ACTION controlp INFIELD dzdi005
            {<point name="query.c.page1.dzdi005" />}
            #END add-point
 
  
         
 
      
         BEFORE CONSTRUCT
            CALL cl_qbe_init()
            #add-point:cs段more_construct
            {<point name="cs.before_construct"/>}
            #end add-point 
      
        #ON ACTION qbe_select
        #   CALL cl_qbe_select()
      
         ON ACTION qbe_save
            CALL cl_qbe_save()
      
      END CONSTRUCT
  
      #add-point:query段more_construct
      {<point name="query.more_construct"/>}
      #end add-point 
      
      ON ACTION accept
         EXIT DIALOG
         
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
      
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG 
   END DIALOG
 
   #LET g_wc2 = g_wc2 CLIPPED, cl_get_extra_cond("", "")
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      LET g_wc2 = ls_wc
   END IF
  
   CALL adzi491_b_fill(g_wc2)
   
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = -100
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   
   LET INT_FLAG = FALSE
   
END FUNCTION
 
#+ 資料新增
PRIVATE FUNCTION adzi491_insert()
   {<Local define>}
   DEFINE li_ac LIKE type_t.num5
   DEFINE l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE l_vars          DYNAMIC ARRAY OF STRING
   DEFINE l_fields        DYNAMIC ARRAY OF STRING
   {</Local define>}
   
   #輸入前動作  
   LET li_ac = l_ac 
   LET l_ac = 1   
   LET g_before_input_done = FALSE                                        
   CALL adzi491_set_entry_b("a")                                             
   CALL adzi491_set_no_entry_b("a")                                          
   LET g_before_input_done = TRUE                                            
   
   #append欄位         
      
 
 
   
   #add-point:insert段before insert
   {<point name="insert.before_insert"/>}
   #end add-point  
 
   #資料輸入
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM) 
      INPUT g_dzdi_d[1].* FROM s_detail1[1].*
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         BEFORE INPUT
         
      END INPUT
      
 
      
      BEFORE DIALOG 
   
   END DIALOG
   
   #輸入後動作
   IF INT_FLAG THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 9001
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
      LET INT_FLAG = 1
      RETURN
   END IF
   
   CALL s_transaction_begin()                    
   
   #add-point:單身新增前
   {<point name="insert.b_insert"/>}
   #end add-point
   
   
   #add-point:單身新增後
   {<point name="insert.a_insert"/>}
   #end add-point
 
END FUNCTION
 
#+ 資料刪除
PRIVATE FUNCTION adzi491_delete()
   DEFINE li_ac LIKE type_t.num5
   
   IF NOT cl_ask_delete() THEN
      LET INT_FLAG = 1 #不刪除
   ELSE
      LET INT_FLAG = 0 #要刪除
   END IF
   
   LET li_ac = ARR_CURR()
   
   CALL s_transaction_begin()  
   
   DELETE FROM dzdi_t 
         WHERE dzdi001 = g_dzdi_d[li_ac].dzdi001
           AND dzdi002 = g_dzdi_d[li_ac].dzdi002
 
           AND dzdi003 = g_dzdi_d[li_ac].dzdi003
 
           AND dzdi004 = g_dzdi_d[li_ac].dzdi004
 
 
           
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "dzdi_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL s_transaction_end('N','0')
   ELSE
      CALL s_transaction_end('Y','0')
   END IF
           
END FUNCTION
 
#+ 資料修改
PRIVATE FUNCTION adzi491_modify()
   {<Local define>}
   DEFINE  p_cmd           LIKE type_t.chr1
   DEFINE  l_cmd           LIKE type_t.chr1
   DEFINE  l_ac_t          LIKE type_t.num5                #未取消的ARRAY CNT 
   DEFINE  l_n             LIKE type_t.num5                #檢查重複用  
   DEFINE  l_cnt           LIKE type_t.num5                #檢查重複用  
   DEFINE  l_lock_sw       LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert  LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete  LIKE type_t.num5                #可刪除否  
   DEFINE  l_count         LIKE type_t.num5
   DEFINE  l_i             LIKE type_t.num5
   DEFINE  ls_return       STRING
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   {</Local define>}
   #add-point:modify段define
   {<point name="modify.define"/>}
   #end add-point 
   
   LET g_action_choice = ""
   
   LET g_qryparam.state = "i"
 
   LET l_allow_insert = cl_detail_input_auth("insert")
   LET l_allow_delete = cl_detail_input_auth("delete")
 
   LET g_forupd_sql = "SELECT dzdi001,dzdi002,dzdi003,dzdi004,dzdi005 FROM dzdi_t WHERE dzdi001=? AND dzdi002=? AND dzdi003=? AND dzdi004=? FOR UPDATE"
   LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
   DECLARE adzi491_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
   
 
   
   LET INT_FLAG = FALSE
 
   #add-point:modify段修改前
   {<point name="modify.before_input"/>}
   #end add-point
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #Page1 預設值產生於此處
      INPUT ARRAY g_dzdi_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            CALL adzi491_b_fill(g_wc2)
            LET g_detail_cnt = g_dzdi_d.getLength()
         
         BEFORE ROW
            #add-point:modify段before row
            {<point name="input.body.before_row2"/>}
            #end add-point  
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_dzdi_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND NOT cl_null(g_dzdi_d[l_ac].dzdi001) 
               AND NOT cl_null(g_dzdi_d[l_ac].dzdi002) 
 
               AND NOT cl_null(g_dzdi_d[l_ac].dzdi003) 
 
               AND NOT cl_null(g_dzdi_d[l_ac].dzdi004) 
 
 
            THEN
               LET l_cmd='u'
               LET g_dzdi_d_t.* = g_dzdi_d[l_ac].*  #BACKUP
               IF NOT adzi491_lock_b("dzdi_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH adzi491_bcl INTO g_dzdi_d[l_ac].dzdi001,g_dzdi_d[l_ac].dzdi002,g_dzdi_d[l_ac].dzdi003,g_dzdi_d[l_ac].dzdi004,g_dzdi_d[l_ac].dzdi005
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = g_dzdi_d_t.dzdi001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  CALL adzi491_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
            {<point name="input.body.before_row"/>}
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            
        
         BEFORE INSERT
            CALL s_transaction_begin()
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_dzdi_d_t.* TO NULL
            INITIALIZE g_dzdi_d[l_ac].* TO NULL 
            
            LET g_dzdi_d_t.* = g_dzdi_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL adzi491_set_entry_b("a")
            CALL adzi491_set_no_entry_b("a")
            #公用欄位給值(單身)
            
            
            #add-point:modify段before insert
            {<point name="input.body.before_insert"/>}
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
            SELECT COUNT(*) INTO l_count FROM dzdi_t 
             WHERE  dzdi001 = g_dzdi_d[l_ac].dzdi001
                                       AND dzdi002 = g_dzdi_d[l_ac].dzdi002
 
                                       AND dzdi003 = g_dzdi_d[l_ac].dzdi003
 
                                       AND dzdi004 = g_dzdi_d[l_ac].dzdi004
 
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前
               {<point name="input.body.b_insert"/>}
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_dzdi_d[l_ac].dzdi001
               LET gs_keys[2] = g_dzdi_d[l_ac].dzdi002
               LET gs_keys[3] = g_dzdi_d[l_ac].dzdi003
               LET gs_keys[4] = g_dzdi_d[l_ac].dzdi004
               CALL adzi491_insert_b('dzdi_t',gs_keys,"'1'")
                           
               #add-point:單身新增後
               {<point name="input.body.a_insert"/>}
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               INITIALIZE g_dzdi_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "dzdi_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL adzi491_b_fill(g_wc2)
               #資料多語言用-增/改
               
               CALL s_transaction_end('Y','0')
               #add-point:input段-after_insert
               {<point name="input.body.a_insert2"/>}
               #end add-point
               ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
            END IF
              
         BEFORE DELETE                            #是否取消單身
            IF NOT cl_null(g_dzdi_d[l_ac].dzdi001) 
               AND NOT cl_null(g_dzdi_d_t.dzdi002) 
 
               AND NOT cl_null(g_dzdi_d_t.dzdi003) 
 
               AND NOT cl_null(g_dzdi_d_t.dzdi004) 
 
 
               THEN
               
               #add-point:單身刪除前
               {<point name="input.body.b_delete"/>}
               #end add-point        
               
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
               DELETE FROM dzdi_t
                WHERE  
                      dzdi001 = g_dzdi_d_t.dzdi001
                      AND dzdi002 = g_dzdi_d_t.dzdi002
 
                      AND dzdi003 = g_dzdi_d_t.dzdi003
 
                      AND dzdi004 = g_dzdi_d_t.dzdi004
 
 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "dzdi_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE adzi491_bcl
               LET l_count = g_dzdi_d.getLength()
            END IF 
            #add-point:單身刪除後
            {<point name="input.body.a_delete"/>}
            #end add-point
            
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_dzdi_d[l_ac].dzdi001
               LET gs_keys[2] = g_dzdi_d[l_ac].dzdi002
               LET gs_keys[3] = g_dzdi_d[l_ac].dzdi003
               LET gs_keys[4] = g_dzdi_d[l_ac].dzdi004
 
              
         AFTER DELETE 
            #add-point:單身刪除後2
            {<point name="input.body.after_delete"/>}
            #end add-point
                           CALL adzi491_delete_b('dzdi_t',gs_keys,"'1'")
 
         #---------------------<  Detail: page1  >---------------------
         #----<<dzdi001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdi001
            #add-point:BEFORE FIELD dzdi001
            {<point name="input.b.page1.dzdi001" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdi001
            
            #add-point:AFTER FIELD dzdi001
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_dzdi_d[l_ac].dzdi001) AND NOT cl_null(g_dzdi_d[l_ac].dzdi002) AND NOT cl_null(g_dzdi_d[l_ac].dzdi003) AND NOT cl_null(g_dzdi_d[l_ac].dzdi004) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_dzdi_d[l_ac].dzdi001 != g_dzdi_d_t.dzdi001 OR g_dzdi_d[l_ac].dzdi002 != g_dzdi_d_t.dzdi002 OR g_dzdi_d[l_ac].dzdi003 != g_dzdi_d_t.dzdi003 OR g_dzdi_d[l_ac].dzdi004 != g_dzdi_d_t.dzdi004))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM dzdi_t WHERE "||"dzdi001 = '"||g_dzdi_d[l_ac].dzdi001 ||"' AND "|| "dzdi002 = '"||g_dzdi_d[l_ac].dzdi002 ||"' AND "|| "dzdi003 = '"||g_dzdi_d[l_ac].dzdi003 ||"' AND "|| "dzdi004 = '"||g_dzdi_d[l_ac].dzdi004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dzdi001
            #add-point:ON CHANGE dzdi001
            {<point name="input.g.page1.dzdi001" />}
            #END add-point
 
         #----<<dzdi002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdi002
            #add-point:BEFORE FIELD dzdi002
            {<point name="input.b.page1.dzdi002" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdi002
            
            #add-point:AFTER FIELD dzdi002
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_dzdi_d[l_ac].dzdi001) AND NOT cl_null(g_dzdi_d[l_ac].dzdi002) AND NOT cl_null(g_dzdi_d[l_ac].dzdi003) AND NOT cl_null(g_dzdi_d[l_ac].dzdi004) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_dzdi_d[l_ac].dzdi001 != g_dzdi_d_t.dzdi001 OR g_dzdi_d[l_ac].dzdi002 != g_dzdi_d_t.dzdi002 OR g_dzdi_d[l_ac].dzdi003 != g_dzdi_d_t.dzdi003 OR g_dzdi_d[l_ac].dzdi004 != g_dzdi_d_t.dzdi004))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM dzdi_t WHERE "||"dzdi001 = '"||g_dzdi_d[l_ac].dzdi001 ||"' AND "|| "dzdi002 = '"||g_dzdi_d[l_ac].dzdi002 ||"' AND "|| "dzdi003 = '"||g_dzdi_d[l_ac].dzdi003 ||"' AND "|| "dzdi004 = '"||g_dzdi_d[l_ac].dzdi004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dzdi002
            #add-point:ON CHANGE dzdi002
            {<point name="input.g.page1.dzdi002" />}
            #END add-point
 
         #----<<dzdi003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdi003
            #add-point:BEFORE FIELD dzdi003
            {<point name="input.b.page1.dzdi003" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdi003
            
            #add-point:AFTER FIELD dzdi003
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_dzdi_d[l_ac].dzdi001) AND NOT cl_null(g_dzdi_d[l_ac].dzdi002) AND NOT cl_null(g_dzdi_d[l_ac].dzdi003) AND NOT cl_null(g_dzdi_d[l_ac].dzdi004) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_dzdi_d[l_ac].dzdi001 != g_dzdi_d_t.dzdi001 OR g_dzdi_d[l_ac].dzdi002 != g_dzdi_d_t.dzdi002 OR g_dzdi_d[l_ac].dzdi003 != g_dzdi_d_t.dzdi003 OR g_dzdi_d[l_ac].dzdi004 != g_dzdi_d_t.dzdi004))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM dzdi_t WHERE "||"dzdi001 = '"||g_dzdi_d[l_ac].dzdi001 ||"' AND "|| "dzdi002 = '"||g_dzdi_d[l_ac].dzdi002 ||"' AND "|| "dzdi003 = '"||g_dzdi_d[l_ac].dzdi003 ||"' AND "|| "dzdi004 = '"||g_dzdi_d[l_ac].dzdi004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dzdi003
            #add-point:ON CHANGE dzdi003
            {<point name="input.g.page1.dzdi003" />}
            #END add-point
 
         #----<<dzdi004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdi004
            #add-point:BEFORE FIELD dzdi004
            {<point name="input.b.page1.dzdi004" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdi004
            
            #add-point:AFTER FIELD dzdi004
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_dzdi_d[l_ac].dzdi001) AND NOT cl_null(g_dzdi_d[l_ac].dzdi002) AND NOT cl_null(g_dzdi_d[l_ac].dzdi003) AND NOT cl_null(g_dzdi_d[l_ac].dzdi004) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_dzdi_d[l_ac].dzdi001 != g_dzdi_d_t.dzdi001 OR g_dzdi_d[l_ac].dzdi002 != g_dzdi_d_t.dzdi002 OR g_dzdi_d[l_ac].dzdi003 != g_dzdi_d_t.dzdi003 OR g_dzdi_d[l_ac].dzdi004 != g_dzdi_d_t.dzdi004))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM dzdi_t WHERE "||"dzdi001 = '"||g_dzdi_d[l_ac].dzdi001 ||"' AND "|| "dzdi002 = '"||g_dzdi_d[l_ac].dzdi002 ||"' AND "|| "dzdi003 = '"||g_dzdi_d[l_ac].dzdi003 ||"' AND "|| "dzdi004 = '"||g_dzdi_d[l_ac].dzdi004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dzdi004
            #add-point:ON CHANGE dzdi004
            {<point name="input.g.page1.dzdi004" />}
            #END add-point
 
         #----<<dzdi005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdi005
            #add-point:BEFORE FIELD dzdi005
            {<point name="input.b.page1.dzdi005" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdi005
            
            #add-point:AFTER FIELD dzdi005
            {<point name="input.a.page1.dzdi005" />}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dzdi005
            #add-point:ON CHANGE dzdi005
            {<point name="input.g.page1.dzdi005" />}
            #END add-point
 
 
         #---------------------<  Detail: page1  >---------------------
         #----<<dzdi001>>----
         #Ctrlp:input.c.page1.dzdi001
#         ON ACTION controlp INFIELD dzdi001
            #add-point:ON ACTION controlp INFIELD dzdi001
            {<point name="input.c.page1.dzdi001" />}
            #END add-point
 
         #----<<dzdi002>>----
         #Ctrlp:input.c.page1.dzdi002
#         ON ACTION controlp INFIELD dzdi002
            #add-point:ON ACTION controlp INFIELD dzdi002
            {<point name="input.c.page1.dzdi002" />}
            #END add-point
 
         #----<<dzdi003>>----
         #Ctrlp:input.c.page1.dzdi003
#         ON ACTION controlp INFIELD dzdi003
            #add-point:ON ACTION controlp INFIELD dzdi003
            {<point name="input.c.page1.dzdi003" />}
            #END add-point
 
         #----<<dzdi004>>----
         #Ctrlp:input.c.page1.dzdi004
#         ON ACTION controlp INFIELD dzdi004
            #add-point:ON ACTION controlp INFIELD dzdi004
            {<point name="input.c.page1.dzdi004" />}
            #END add-point
 
         #----<<dzdi005>>----
         #Ctrlp:input.c.page1.dzdi005
#         ON ACTION controlp INFIELD dzdi005
            #add-point:ON ACTION controlp INFIELD dzdi005
            {<point name="input.c.page1.dzdi005" />}
            #END add-point
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_dzdi_d[l_ac].* = g_dzdi_d_t.*
               CLOSE adzi491_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_dzdi_d[l_ac].dzdi001
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_dzdi_d[l_ac].* = g_dzdi_d_t.*
            ELSE
            
               #add-point:單身修改前
               {<point name="input.body.b_update"/>}
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               UPDATE dzdi_t SET (dzdi001,dzdi002,dzdi003,dzdi004,dzdi005) = (g_dzdi_d[l_ac].dzdi001,g_dzdi_d[l_ac].dzdi002,g_dzdi_d[l_ac].dzdi003,g_dzdi_d[l_ac].dzdi004,g_dzdi_d[l_ac].dzdi005)
                WHERE 
                  dzdi001 = g_dzdi_d_t.dzdi001 #項次   
                  AND dzdi002 = g_dzdi_d_t.dzdi002  
 
                  AND dzdi003 = g_dzdi_d_t.dzdi003  
 
                  AND dzdi004 = g_dzdi_d_t.dzdi004  
 
 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "dzdi_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_dzdi_d[l_ac].* = g_dzdi_d_t.*
               ELSE
                                 INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_dzdi_d[l_ac].dzdi001
               LET gs_keys_bak[1] = g_dzdi_d_t.dzdi001
               LET gs_keys[2] = g_dzdi_d[l_ac].dzdi002
               LET gs_keys_bak[2] = g_dzdi_d_t.dzdi002
               LET gs_keys[3] = g_dzdi_d[l_ac].dzdi003
               LET gs_keys_bak[3] = g_dzdi_d_t.dzdi003
               LET gs_keys[4] = g_dzdi_d[l_ac].dzdi004
               LET gs_keys_bak[4] = g_dzdi_d_t.dzdi004
               CALL adzi491_update_b('dzdi_t',gs_keys,gs_keys_bak,"'1'")
                  #資料多語言用-增/改
                  
               END IF
               
               #add-point:單身修改後
               {<point name="input.body.a_update"/>}
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL adzi491_unlock_b("dzdi_t")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            
            
         AFTER INPUT
            #add-point:單身input後
            {<point name="input.body.a_input"/>}
            #end add-point
              
      END INPUT
      
 
      
      BEFORE DIALOG 
         LET g_curr_diag = ui.DIALOG.getCurrent()
   
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
   {<point name="modify.after_input"/>}
   #end add-point
 
   CLOSE adzi491_bcl
   CALL s_transaction_end('Y','0')
   
END FUNCTION
 
 
#+ 單身陣列填充
PRIVATE FUNCTION adzi491_b_fill(p_wc2)              #BODY FILL UP
   {<Local define>}
   DEFINE p_wc2           STRING
   {</Local define>}
   #add-point:b_fill段define
   {<point name="b_fill.define"/>}
   #end add-point
   
   IF cl_null(p_wc2) THEN
      LET p_wc2 = " 1=1"
   END IF
   
   #add-point:b_fill段sql
   {<point name="b_fill.sql_before"/>}
   #end add-point
 
   LET g_sql = "SELECT  UNIQUE dzdi001,dzdi002,dzdi003,dzdi004,dzdi005 FROM dzdi_t",
               "",
               " WHERE 1=1 AND ", p_wc2
    
   LET g_sql = g_sql, " ORDER BY dzdi_t.dzdi001,dzdi_t.dzdi002,dzdi_t.dzdi003,dzdi_t.dzdi004"
  
   PREPARE adzi491_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR adzi491_pb
   
   
 
   CALL g_dzdi_d.clear()
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_dzdi_d[l_ac].dzdi001,g_dzdi_d[l_ac].dzdi002,g_dzdi_d[l_ac].dzdi003,g_dzdi_d[l_ac].dzdi004,g_dzdi_d[l_ac].dzdi005
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充
      {<point name="b_fill.fill"/>}
      #end add-point
      
      CALL adzi491_detail_show()      
 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         #CALL cl_err( "", 9035, 0 )
         EXIT FOREACH
      END IF
      
   END FOREACH
   
 
   
   CALL g_dzdi_d.deleteElement(g_dzdi_d.getLength())   
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_dzdi_d.getLength()
 
   END FOR
   
   #add-point:b_fill段資料填充(其他單身)
   {<point name="b_fill.others.fill"/>}
   #end add-point
 
   LET g_detail_cnt = l_ac - 1
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE adzi491_pb
   
END FUNCTION
 
#+ 顯示相關資料
PRIVATE FUNCTION adzi491_detail_show()
   #add-point:show段define
   {<point name="detail_show.define"/>}
   #end add-point
 
   #add-point:detail_show段之前
   {<point name="detail_show.before"/>}
   #end add-point
   
   
   
   #帶出公用欄位reference值page1
   
    
 
   
   #讀入ref值
   #add-point:show段單身reference
   {<point name="detail_show.reference"/>}
   #end add-point
   
 
   #add-point:detail_show段之後
   {<point name="detail_show.after"/>}
   #end add-point
 
END FUNCTION
 
 
#+ 單身欄位開啟設定
PRIVATE FUNCTION adzi491_set_entry_b(p_cmd)                                                  
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1         
   {</Local define>}
   #add-point:set_entry_b段define
   {<point name="set_entry_b.define"/>}
   #end add-point                                                                   
                                                                                
END FUNCTION                                                                    
                                                                                
 
#+ 單身欄位關閉設定
PRIVATE FUNCTION adzi491_set_no_entry_b(p_cmd)                                               
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1           
   {</Local define>}
   #add-point:set_no_entry_b段define
   {<point name="set_no_entry_b.define"/>}
   #end add-point                                                                  
                                                                                
END FUNCTION  
 
#+ 外部參數搜尋, 施工中
PRIVATE FUNCTION adzi491_default_search()
   {<Local define>}
   DEFINE li_idx  LIKE type_t.num5
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE ls_wc   STRING
   {</Local define>}
   #add-point:default_search段define
   {<point name="default_search.define"/>}
   #end add-point  
   
   IF NOT cl_null(g_argv[1]) THEN
      LET ls_wc = ls_wc, " dzdi001 = '", g_argv[1], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " dzdi002 = ", g_argv[02], " AND "
   END IF
 
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " dzdi003 = ", g_argv[03], " AND "
   END IF
 
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " dzdi004 = ", g_argv[04], " AND "
   END IF
 
 
   
   IF NOT cl_null(ls_wc) THEN
      LET ls_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_wc2 = ls_wc
   ELSE
      LET g_wc2 = " 1=1"
   END IF
 
END FUNCTION
 
#+ 刪除單身後其他table連動
PRIVATE FUNCTION adzi491_delete_b(ps_table,ps_keys_bak,ps_page)
   {<Local define>}
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   {</Local define>}
   #add-point:delete_b段define
   {<point name="delete_b.define"/>}
   #end add-point     
 
   #判斷是否是同一群組的table
   LET ls_group = "dzdi_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      DELETE FROM dzdi_t
       WHERE 
         dzdi001 = ps_keys_bak[1] AND dzdi002 = ps_keys_bak[2] AND dzdi003 = ps_keys_bak[3] AND dzdi004 = ps_keys_bak[4]
 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ""
         LET g_errparam.popup = FALSE
         CALL cl_err()
      END IF
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
#+ 新增單身後其他table連動
PRIVATE FUNCTION adzi491_insert_b(ps_table,ps_keys,ps_page)
   {<Local define>}
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   {</Local define>}
   #add-point:insert_b段define
   {<point name="insert_b.define"/>}
   #end add-point     
 
   #判斷是否是同一群組的table
   LET ls_group = "dzdi_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      INSERT INTO dzdi_t
                  (
                   dzdi001,dzdi002,dzdi003,dzdi004
                   ,dzdi005) 
            VALUES(
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
                   ,g_dzdi_d[l_ac].dzdi005)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "dzdi_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
      END IF
   #END IF
   
 
   
END FUNCTION
 
    
#+ 修改單身後其他table連動
PRIVATE FUNCTION adzi491_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   {<Local define>}
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
   {</Local define>}
   #add-point:update_b段define
   {<point name="update_b.define"/>}
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
   LET ls_group = "dzdi_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      UPDATE dzdi_t 
         SET (dzdi001,dzdi002,dzdi003,dzdi004
              ,dzdi005) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
              ,g_dzdi_d[l_ac].dzdi005) 
         WHERE dzdi001 = ps_keys_bak[1] AND dzdi002 = ps_keys_bak[2] AND dzdi003 = ps_keys_bak[3] AND dzdi004 = ps_keys_bak[4]
 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ""
         LET g_errparam.popup = FALSE
         CALL cl_err()
      ELSE
         
      END IF
      RETURN
   #END IF
   
 
   
END FUNCTION
 
#+ 連動lock其他單身table資料
PRIVATE FUNCTION adzi491_lock_b(ps_table)
 
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define
   {<point name="lock_b.define"/>}
   #end add-point   
   
   #先刷新資料
   #CALL adzi491_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "dzdi_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN adzi491_bcl USING 
                                       g_dzdi_d[l_ac].dzdi001,g_dzdi_d[l_ac].dzdi002,g_dzdi_d[l_ac].dzdi003,g_dzdi_d[l_ac].dzdi004
                                       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "adzi491_bcl"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION adzi491_unlock_b(ps_table)
 
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:unlock_b段define
   {<point name="unlock_b.define"/>}
   #end add-point  
   
   LET ls_group = ""
   
   #IF ls_group.getIndexOf(ps_table,1) THEN
      CLOSE adzi491_bcl
   #END IF
   
 
 
END FUNCTION
 
    
 
{<point name="other.function"/>}
 
FUNCTION adzi491_gen1()
   DEFINE l_dzda001     LIKE dzda_t.dzda001
   DEFINE l_cnt         LIKE type_t.num5

   DECLARE adzi491_gen1_cs CURSOR FOR
    SELECT dzda001 FROM dzda_t
     WHERE dzdastus <> '5'

   FOREACH adzi491_gen1_cs INTO l_dzda001
      SELECT COUNT(*) INTO l_cnt FROM dzdi_t
       WHERE dzdi001 = 'dzda_t'
         AND dzdi002 = 'dzda001'
         AND dzdi003 = l_dzda001
         AND dzdi004 = 'zh_TW'
      IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
      IF l_cnt = 0 THEN
         INSERT INTO  dzdi_t(dzdi001,dzdi002,dzdi003,dzdi004,dzdi005) 
          VALUES('dzda_t','dzda001',l_dzda001,'zh_TW','')
      END IF

      SELECT COUNT(*) INTO l_cnt FROM dzdi_t
       WHERE dzdi001 = 'dzda_t'
         AND dzdi002 = 'dzda001'
         AND dzdi003 = l_dzda001
         AND dzdi004 = 'zh_CN'
      IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
      IF l_cnt = 0 THEN
         INSERT INTO  dzdi_t(dzdi001,dzdi002,dzdi003,dzdi004,dzdi005) 
          VALUES('dzda_t','dzda001',l_dzda001,'zh_CN','')
      END IF
   END FOREACH

END FUNCTION

FUNCTION adzi491_gen2()
   DEFINE l_dzdb001     LIKE dzdb_t.dzdb001
   DEFINE l_dzdb002     LIKE dzdb_t.dzdb002
   DEFINE l_dzdb003     LIKE type_t.chr2
   DEFINE l_dzdb005     LIKE dzdb_t.dzdb005
   DEFINE l_dzdi003     LIKE dzdi_t.dzdi003
   DEFINE l_cnt         LIKE type_t.num5

   DECLARE adzi491_gen2_cs CURSOR FOR
    SELECT dzdb001,dzdb002,dzdb003,dzdb005 FROM dzdb_t,dzda_t
     WHERE dzdastus <> '5'
       AND dzda001 = dzdb001

   FOREACH adzi491_gen2_cs INTO l_dzdb001,l_dzdb002,l_dzdb003,l_dzdb005
      LET l_dzdi003 = l_dzdb001 CLIPPED,',',l_dzdb002,',',l_dzdb003 CLIPPED,',',l_dzdb005 CLIPPED
      SELECT COUNT(*) INTO l_cnt FROM dzdi_t
       WHERE dzdi001 = 'dzdb_t'
         AND dzdi002 = 'dzdb005'
         AND dzdi003 = l_dzdi003
         AND dzdi004 = 'zh_TW'
      IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
      IF l_cnt = 0 THEN
         INSERT INTO  dzdi_t(dzdi001,dzdi002,dzdi003,dzdi004,dzdi005) 
          VALUES('dzdb_t','dzdb005',l_dzdi003,'zh_TW','')
      END IF

      SELECT COUNT(*) INTO l_cnt FROM dzdi_t
       WHERE dzdi001 = 'dzdb_t'
         AND dzdi002 = 'dzdb005'
         AND dzdi003 = l_dzdi003
         AND dzdi004 = 'zh_CN'
      IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
      IF l_cnt = 0 THEN
         INSERT INTO  dzdi_t(dzdi001,dzdi002,dzdi003,dzdi004,dzdi005) 
          VALUES('dzdb_t','dzdb005',l_dzdi003,'zh_CN','')
      END IF
   END FOREACH

END FUNCTION

FUNCTION adzi491_gen3()

END FUNCTION




