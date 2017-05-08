#+ Version..: T6-ERP-1.00.00 Build-000005
#+ 
#+ Filename...: adzi450
#+ Buildtype..: 應用 i02 樣板自動產生
#+ Memo.......: 
#+ 以上段落由子樣板a00產生
# Modify.........: 20160331 160331-00017 by Hiko : 清除呼叫q_common的段落
 
 
{<point name="global.memo" />}
 
IMPORT os
#add-point:增加匯入項目
{<point name="global.import" />}
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
{<Module define>}
 
#單身 type 宣告
PRIVATE TYPE type_g_dzde_d RECORD
       dzdestus LIKE dzde_t.dzdestus, 
   dzde001 LIKE dzde_t.dzde001, 
   dzde002 LIKE dzde_t.dzde002, 
   dzde003 LIKE dzde_t.dzde003, 
   dzde004 LIKE dzde_t.dzde004, 
   dzde005 LIKE dzde_t.dzde005, 
   dzdemodid LIKE dzde_t.dzdemodid, 
   dzdemodid_desc LIKE type_t.chr80, 
   dzdemoddt DATETIME YEAR TO SECOND, 
   dzdeownid LIKE dzde_t.dzdeownid, 
   dzdeownid_desc LIKE type_t.chr80, 
   dzdeowndp LIKE dzde_t.dzdeowndp, 
   dzdeowndp_desc LIKE type_t.chr80, 
   dzdecrtid LIKE dzde_t.dzdecrtid, 
   dzdecrtid_desc LIKE type_t.chr80, 
   dzdecrtdp LIKE dzde_t.dzdecrtdp, 
   dzdecrtdp_desc LIKE type_t.chr80, 
   dzdecrtdt DATETIME YEAR TO SECOND
       END RECORD
 
 
#無單身append欄位定義
 
#模組變數(Module Variables)
DEFINE g_dzde_d          DYNAMIC ARRAY OF type_g_dzde_d
DEFINE g_dzde_d_t        type_g_dzde_d
 
      
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


DEFINE g_date_chr           LIKE type_t.chr100 
 
{</Module define>}
 
#add-point:自定義模組變數(Module Variable)
{<point name="global.variable"/>}
#end add-point
 
#+ 作業開始
MAIN
   #add-point:main段define
   {<point name="main.define"/>}
   #end add-point
 
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("adz","N")
   
   #add-point:作業初始化
   {<point name="main.init"/>}
   #end add-point

#wujie --test
    LET g_date_chr = g_today -1
    DISPLAY 'g_date_chr  : ',g_date_chr
    UPDATE dzde_t SET dzdemoddt = g_date_chr
     WHERE dzde001 = 'abmt300_01'
       AND dzde002 = 'zh_TW'
    IF SQLCA.sqlcode THEN 
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = SQLCA.sqlcode
       LET g_errparam.extend = ''
       LET g_errparam.popup = TRUE
       CALL cl_err()
       RETURN 
    END IF 
#end    
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call
      {<point name="main.servicecall" />}
      #end add-point
 
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adzi450 WITH FORM cl_ap_formpath("adz",g_prog)
 
      CALL adzi450_init()   
         
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      CALL adzi450_default_search()
   
      #進入選單 Menu (="N")
      CALL adzi450_ui_dialog() 
 
      #畫面關閉
      CLOSE WINDOW w_adzi450
   END IF
 
   #add-point:作業離開前
   {<point name="main.exit" />}
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")     
   
END MAIN
 
 
#+ 畫面資料初始化
PRIVATE FUNCTION adzi450_init()
   #add-point:init段define
   {<point name="init.define"/>}
   #end add-point   
 
   #add-point:畫面資料初始化
   {<point name="init.init" />}
CALL cl_set_combo_lang("dzde002")
CALL cl_set_combo_module("dzde004",1)
   #end add-point
   
END FUNCTION
 
 
PRIVATE FUNCTION adzi450_init_dzde005()
    IF cl_null(g_dzde_d[l_ac].dzde005) THEN
       IF g_dzde_d[l_ac].dzde004 = 'SUB' OR g_dzde_d[l_ac].dzde004 = 'LIB' THEN
          LET g_dzde_d[l_ac].dzde005 = 'N'
       ELSE
          LET g_dzde_d[l_ac].dzde005 = 'Y'
       END IF
    END IF
END FUNCTION

#+ 功能選單 
PRIVATE FUNCTION adzi450_ui_dialog()
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
   
   WHILE TRUE
   
      CALL adzi450_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_dzde_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
            IF cl_chk_act_auth() THEN 
               CALL adzi450_modify()
               #add-point:ON ACTION modify
               {<point name="menu.modify" />}
               #END add-point
                EXIT DIALOG
            END IF
 
 
         ON ACTION output
 
            LET g_action_choice="output"
            IF cl_chk_act_auth() THEN 
               #add-point:ON ACTION output
               {<point name="menu.output" />}
               #END add-point
                EXIT DIALOG
            END IF
 
 
         ON ACTION query
 
            LET g_action_choice="query"
            IF cl_chk_act_auth() THEN 
               CALL adzi450_query()
               #add-point:ON ACTION query
               {<point name="menu.query" />}
               #END add-point
            END IF
 
      
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice="exit"
            EXIT WHILE
      
         ON ACTION exit
            LET g_action_choice="exit"
            EXIT WHILE
      
         #主選單用ACTION
         &include "main_menu.4gl"
         
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
 
#+ QBE資料查詢
PRIVATE FUNCTION adzi450_query()
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
   CALL g_dzde_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON dzdestus,dzde001,dzde002,dzde003,dzde004,dzde005,dzdemodid,dzdemoddt,dzdeownid,dzdeowndp,dzdecrtid,dzdecrtdp,dzdecrtdt 
 
         FROM s_detail1[1].dzdestus,s_detail1[1].dzde001,s_detail1[1].dzde002,s_detail1[1].dzde003,s_detail1[1].dzde004,s_detail1[1].dzde005,s_detail1[1].dzdemodid,s_detail1[1].dzdemoddt,s_detail1[1].dzdeownid,s_detail1[1].dzdeowndp,s_detail1[1].dzdecrtid,s_detail1[1].dzdecrtdp,s_detail1[1].dzdecrtdt 
      
         #此段落由子樣板a11產生
         #Begin:160331-00017
         ##----<<dzdemodid>>----
         #ON ACTION controlp INFIELD dzdemodid
         #   CALL q_common('dzde_t','dzdemodid',TRUE,FALSE,g_dzde_d[1].dzdemodid) RETURNING ls_return
         #   DISPLAY ls_return TO dzdemodid
         #   NEXT FIELD dzdemodid
         
         ##----<<dzdeownid>>----
         #ON ACTION controlp INFIELD dzdeownid
         #   CALL q_common('dzde_t','dzdeownid',TRUE,FALSE,g_dzde_d[1].dzdeownid) RETURNING ls_return
         #   DISPLAY ls_return TO dzdeownid
         #   NEXT FIELD dzdeownid  
         
         ##----<<dzdecrtid>>----
         #ON ACTION controlp INFIELD dzdecrtid
         #   CALL q_common('dzde_t','dzdecrtid',TRUE,FALSE,g_dzde_d[1].dzdecrtid) RETURNING ls_return
         #   DISPLAY ls_return TO dzdecrtid
         #   NEXT FIELD dzdecrtid
         
         ##----<<dzdeowndp>>----
         #ON ACTION controlp INFIELD dzdeowndp
         #   CALL q_common('dzde_t','dzdeowndp',TRUE,FALSE,g_dzde_d[1].dzdeowndp) RETURNING ls_return
         #   DISPLAY ls_return TO dzdeowndp
         #   NEXT FIELD dzdeowndp
         
         ##----<<dzdecrtdp>>----
         #ON ACTION controlp INFIELD dzdecrtdp
         #   CALL q_common('dzde_t','dzdecrtdp',TRUE,FALSE,g_dzde_d[1].dzdecrtdp) RETURNING ls_return
         #   DISPLAY ls_return TO dzdecrtdp
         #   NEXT FIELD dzdecrtdp
         #End:160331-00017
 
         #----<<dzdecrtdt>>----
         AFTER FIELD dzdecrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<dzdemoddt>>----
         AFTER FIELD dzdemoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
      
         #---------------------<  Detail: page1  >---------------------
         #----<<dzdestus>>----
         #Ctrlp:query.c.dzdestus
##此段落由子樣板a03產生
         ON ACTION controlp INFIELD dzdestus
            #add-point:ON ACTION controlp INFIELD dzdestus
            {<point name="query.c.page1.dzdestus" />}
            #END add-point
 
         #----<<dzde001>>----
         #Ctrlp:query.c.dzde001
##此段落由子樣板a03產生
         ON ACTION controlp INFIELD dzde001
            #add-point:ON ACTION controlp INFIELD dzde001
            {<point name="query.c.page1.dzde001" />}
            #END add-point
 
         #----<<dzde002>>----
         #Ctrlp:query.c.dzde002
##此段落由子樣板a03產生
         ON ACTION controlp INFIELD dzde002
            #add-point:ON ACTION controlp INFIELD dzde002
            {<point name="query.c.page1.dzde002" />}
            #END add-point
 
         #----<<dzde003>>----
         #Ctrlp:query.c.dzde003
##此段落由子樣板a03產生
         ON ACTION controlp INFIELD dzde003
            #add-point:ON ACTION controlp INFIELD dzde003
            {<point name="query.c.page1.dzde003" />}
            #END add-point
 
         #----<<dzde004>>----
         #Ctrlp:query.c.dzde004
##此段落由子樣板a03產生
         ON ACTION controlp INFIELD dzde004
            #add-point:ON ACTION controlp INFIELD dzde004
            {<point name="query.c.page1.dzde004" />}
            #END add-point
 
         #----<<dzde005>>----
         #Ctrlp:query.c.dzde005
##此段落由子樣板a03產生
         ON ACTION controlp INFIELD dzde005
            #add-point:ON ACTION controlp INFIELD dzde005
            {<point name="query.c.page1.dzde005" />}
            #END add-point
 
         #----<<dzdemodid>>----
         #----<<dzdemoddt>>----
         #----<<dzdeownid>>----
         #----<<dzdeowndp>>----
         #----<<dzdecrtid>>----
         #----<<dzdecrtdp>>----
         #----<<dzdecrtdt>>----
  
      
         BEFORE CONSTRUCT
            CALL cl_qbe_init()
      
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
 
   #LET g_wc2 = g_wc2 CLIPPED, cl_get_extra_cond("g_dzde_d[l_ac].dzdecrtid", "")
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      #LET g_wc2 = ls_wc
      LET g_wc2 = " 1=1"
   END IF
  
   CALL adzi450_b_fill(g_wc2)
   
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
PRIVATE FUNCTION adzi450_insert()
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
   CALL adzi450_set_entry_b("a")                                             
   CALL adzi450_set_no_entry_b("a")                                          
   LET g_before_input_done = TRUE                                            
   
   #一般欄位預設直         
    
   #append欄位         
      
 
 
   
   #add-point:modify段before insert
   {<point name="insert.before_insert"/>}
   #end add-point  
 
   #資料輸入
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM) 
      INPUT g_dzde_d[1].* FROM s_detail1[1].*
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
   
   BEGIN WORK                    
   
   #add-point:單身新增前
   {<point name="insert.b_insert"/>}
   #end add-point
   
   
   #add-point:單身新增後
   {<point name="insert.a_insert"/>}
   #end add-point
 
END FUNCTION
 
#+ 資料刪除
PRIVATE FUNCTION adzi450_delete()
   DEFINE li_ac LIKE type_t.num5
   
   IF NOT cl_ask_delete() THEN
      LET INT_FLAG = 1 #不刪除
   ELSE
      LET INT_FLAG = 0 #要刪除
   END IF
   
   LET li_ac = ARR_CURR()
   
   BEGIN WORK  
   
   DELETE FROM dzde_t 
         WHERE dzde001 = g_dzde_d[li_ac].dzde001
           AND dzde002 = g_dzde_d[li_ac].dzde002
 
 
           
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "dzde_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      ROLLBACK WORK
   ELSE
      COMMIT WORK
   END IF
           
END FUNCTION
 
#+ 資料修改
PRIVATE FUNCTION adzi450_modify()
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
   DEFINE  l_insert        BOOLEAN
   DEFINE  ls_return       STRING
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   {</Local define>}
   #add-point:modify段define
   {<point name="modify.define"/>}
   DEFINE  l_chr           LIKE type_t.chr10
   #end add-point 
   
   LET l_insert = FALSE
   LET g_action_choice = ""
   
   LET g_qryparam.state = "i"
 
   LET l_allow_insert = cl_detail_input_auth("insert")
   LET l_allow_delete = cl_detail_input_auth("delete")
 
   LET g_forupd_sql = "SELECT dzdestus,dzde001,dzde002,dzde003,dzde004,dzde005,dzdemodid,'',dzdemoddt,dzdeownid,'',dzdeowndp,'',dzdecrtid,'',dzdecrtdp,'',dzdecrtdt FROM dzde_t WHERE dzde001=? AND dzde002=? FOR UPDATE"
   LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
   DECLARE adzi450_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
   
 
 
   #add-point:modify段修改前
   {<point name="modify.before_input"/>}
   #end add-point
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #Page1 預設值產生於此處
      INPUT ARRAY g_dzde_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            CALL adzi450_b_fill(g_wc2)
            LET g_detail_cnt = g_dzde_d.getLength()
         
         BEFORE ROW
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_n TO FORMONLY.idx
         
            BEGIN WORK
            LET g_detail_cnt = g_dzde_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND NOT cl_null(g_dzde_d[l_ac].dzde001) 
               AND NOT cl_null(g_dzde_d[l_ac].dzde002) 
 
 
            THEN
               LET l_cmd='u'
               LET g_dzde_d_t.* = g_dzde_d[l_ac].*  #BACKUP
               IF NOT adzi450_lock_b("dzde_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH adzi450_bcl INTO g_dzde_d[l_ac].dzdestus,g_dzde_d[l_ac].dzde001,g_dzde_d[l_ac].dzde002,g_dzde_d[l_ac].dzde003,g_dzde_d[l_ac].dzde004,g_dzde_d[l_ac].dzde005,g_dzde_d[l_ac].dzdemodid,g_dzde_d[l_ac].dzdemodid_desc,g_dzde_d[l_ac].dzdemoddt,g_dzde_d[l_ac].dzdeownid,g_dzde_d[l_ac].dzdeownid_desc,g_dzde_d[l_ac].dzdeowndp,g_dzde_d[l_ac].dzdeowndp_desc,g_dzde_d[l_ac].dzdecrtid,g_dzde_d[l_ac].dzdecrtid_desc,g_dzde_d[l_ac].dzdecrtdp,g_dzde_d[l_ac].dzdecrtdp_desc,g_dzde_d[l_ac].dzdecrtdt
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = g_dzde_d_t.dzde001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  CALL adzi450_detail_show()
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
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_dzde_d[l_ac].* TO NULL 
            
            LET g_dzde_d_t.* = g_dzde_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL adzi450_set_entry_b("a")
            CALL adzi450_set_no_entry_b("a")
            #公用欄位給值(單身)
            #此段落由子樣板a14產生    
      LET g_dzde_d[l_ac].dzdecrtid = g_user
      LET g_dzde_d[l_ac].dzdecrtdp = g_dept
      LET g_dzde_d[l_ac].dzdecrtdt = cl_get_current()
      LET g_dzde_d[l_ac].dzdeownid = g_user 
      LET g_dzde_d[l_ac].dzdeowndp = g_dept 
      LET g_dzde_d[l_ac].dzdemodid = g_user
      LET g_dzde_d[l_ac].dzdemoddt = cl_get_current()
      LET g_dzde_d[l_ac].dzdestus = "Y"
 
 
            #add-point:modify段before insert
            {<point name="input.body.before_insert"/>}
      LET g_dzde_d[l_ac].dzde002 = g_lang
            #end add-point  
  
         AFTER INSERT
            LET l_insert = FALSE
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
            SELECT COUNT(*) INTO l_count FROM dzde_t 
             WHERE  g_dzde_d[l_ac].dzde001 = dzde001
                                       AND g_dzde_d[l_ac].dzde002 = dzde002
 
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前
               {<point name="input.body.b_insert"/>}
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_dzde_d[l_ac].dzde001
               LET gs_keys[2] = g_dzde_d[l_ac].dzde002
               CALL adzi450_insert_b('dzde_t',gs_keys)
                           
               #add-point:單身新增後
               {<point name="input.body.a_insert"/>}
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               INITIALIZE g_dzde_d[l_ac].* TO NULL
               ROLLBACK WORK
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "dzde_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               ROLLBACK WORK                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL adzi450_b_fill(g_wc2)
               #資料多語言用-增/改
               
               COMMIT WORK
               #add-point:input段-after_insert
               {<point name="input.body.a_insert2"/>}
               #end add-point
               ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
            END IF
              
         BEFORE DELETE                            #是否取消單身
            IF NOT cl_null(g_dzde_d[l_ac].dzde001) 
               AND NOT cl_null(g_dzde_d_t.dzde002) 
 
 
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
               DELETE FROM dzde_t
                WHERE  
                      dzde001 = g_dzde_d_t.dzde001
                      AND dzde002 = g_dzde_d_t.dzde002
 
 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "dzde_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  ROLLBACK WORK
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
                  COMMIT WORK
               END IF 
               CLOSE adzi450_bcl
               LET l_count = g_dzde_d.getLength()
            END IF 
            #add-point:單身刪除後
            {<point name="input.body.a_delete"/>}
            #end add-point
            
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_dzde_d[l_ac].dzde001
               LET gs_keys[2] = g_dzde_d[l_ac].dzde002
 
              
         AFTER DELETE 
            #add-point:單身刪除後2
            {<point name="input.body.after_delete"/>}
            #end add-point
                           CALL adzi450_delete_b('dzde_t',gs_keys)
 
         #---------------------<  Detail: page1  >---------------------
         #----<<dzdestus>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdestus
            #add-point:BEFORE FIELD dzdestus
            {<point name="input.b.page1.dzdestus" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdestus
            
            #add-point:AFTER FIELD dzdestus
            {<point name="input.a.page1.dzdestus" />}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dzdestus
            #add-point:ON CHANGE dzdestus
            {<point name="input.g.page1.dzdestus" />}
            #END add-point
 
         #----<<dzde001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzde001
            #add-point:BEFORE FIELD dzde001
            {<point name="input.b.page1.dzde001" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzde001
            
            #add-point:AFTER FIELD dzde001
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_dzde_d[l_ac].dzde001) AND NOT cl_null(g_dzde_d[l_ac].dzde002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_dzde_d[l_ac].dzde001 != g_dzde_d_t.dzde001 OR g_dzde_d[l_ac].dzde002 != g_dzde_d_t.dzde002))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM dzde_t WHERE "||"dzde001 = '"||g_dzde_d[l_ac].dzde001 ||"' AND "|| "dzde002 = '"||g_dzde_d[l_ac].dzde002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF NOT cl_null(g_dzde_d[l_ac].dzde001) AND cl_null(g_dzde_d[l_ac].dzde004) THEN
               LET l_chr = g_dzde_d[l_ac].dzde001[1,2]
               CASE l_chr
                  WHEN 's_' LET g_dzde_d[l_ac].dzde004 = 'SUB'
                  WHEN 'cl' LET g_dzde_d[l_ac].dzde004 = 'LIB'
               END CASE
            END IF
            CALL adzi450_init_dzde005()


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dzde001
            #add-point:ON CHANGE dzde001
            {<point name="input.g.page1.dzde001" />}
            #END add-point
 
         #----<<dzde002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzde002
            #add-point:BEFORE FIELD dzde002
            {<point name="input.b.page1.dzde002" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzde002
            
            #add-point:AFTER FIELD dzde002
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_dzde_d[l_ac].dzde001) AND NOT cl_null(g_dzde_d[l_ac].dzde002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_dzde_d[l_ac].dzde001 != g_dzde_d_t.dzde001 OR g_dzde_d[l_ac].dzde002 != g_dzde_d_t.dzde002))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM dzde_t WHERE "||"dzde001 = '"||g_dzde_d[l_ac].dzde001 ||"' AND "|| "dzde002 = '"||g_dzde_d[l_ac].dzde002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dzde002
            #add-point:ON CHANGE dzde002
            {<point name="input.g.page1.dzde002" />}
            #END add-point
 
         #----<<dzde003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzde003
            #add-point:BEFORE FIELD dzde003
            {<point name="input.b.page1.dzde003" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzde003
            
            #add-point:AFTER FIELD dzde003
            {<point name="input.a.page1.dzde003" />}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dzde003
            #add-point:ON CHANGE dzde003
            {<point name="input.g.page1.dzde003" />}
            #END add-point
 
         #----<<dzde004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzde004
            #add-point:BEFORE FIELD dzde004
            {<point name="input.b.page1.dzde004" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzde004
            
            #add-point:AFTER FIELD dzde004
            {<point name="input.a.page1.dzde004" />}
            #画面否栏位赋初值
            CALL adzi450_init_dzde005()
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dzde004
            #add-point:ON CHANGE dzde004
            {<point name="input.g.page1.dzde004" />}
            #END add-point
 
         #----<<dzde005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzde005
            #add-point:BEFORE FIELD dzde005
            {<point name="input.b.page1.dzde005" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzde005
            
            #add-point:AFTER FIELD dzde005
            {<point name="input.a.page1.dzde005" />}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dzde005
            #add-point:ON CHANGE dzde005
            {<point name="input.g.page1.dzde005" />}
            #END add-point
 
         #----<<dzdemodid>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdemodid
            #add-point:BEFORE FIELD dzdemodid
            {<point name="input.b.page1.dzdemodid" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdemodid
            
            #add-point:AFTER FIELD dzdemodid
            {<point name="input.a.page1.dzdemodid" />}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dzdemodid
            #add-point:ON CHANGE dzdemodid
            {<point name="input.g.page1.dzdemodid" />}
            #END add-point
 
         #----<<dzdemoddt>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdemoddt
            #add-point:BEFORE FIELD dzdemoddt
            {<point name="input.b.page1.dzdemoddt" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdemoddt
            
            #add-point:AFTER FIELD dzdemoddt
            {<point name="input.a.page1.dzdemoddt" />}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dzdemoddt
            #add-point:ON CHANGE dzdemoddt
            {<point name="input.g.page1.dzdemoddt" />}
            #END add-point
 
         #----<<dzdeownid>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdeownid
            #add-point:BEFORE FIELD dzdeownid
            {<point name="input.b.page1.dzdeownid" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdeownid
            
            #add-point:AFTER FIELD dzdeownid
            {<point name="input.a.page1.dzdeownid" />}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dzdeownid
            #add-point:ON CHANGE dzdeownid
            {<point name="input.g.page1.dzdeownid" />}
            #END add-point
 
         #----<<dzdeowndp>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdeowndp
            #add-point:BEFORE FIELD dzdeowndp
            {<point name="input.b.page1.dzdeowndp" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdeowndp
            
            #add-point:AFTER FIELD dzdeowndp
            {<point name="input.a.page1.dzdeowndp" />}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dzdeowndp
            #add-point:ON CHANGE dzdeowndp
            {<point name="input.g.page1.dzdeowndp" />}
            #END add-point
 
         #----<<dzdecrtid>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdecrtid
            #add-point:BEFORE FIELD dzdecrtid
            {<point name="input.b.page1.dzdecrtid" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdecrtid
            
            #add-point:AFTER FIELD dzdecrtid
            {<point name="input.a.page1.dzdecrtid" />}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dzdecrtid
            #add-point:ON CHANGE dzdecrtid
            {<point name="input.g.page1.dzdecrtid" />}
            #END add-point
 
         #----<<dzdecrtdp>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdecrtdp
            #add-point:BEFORE FIELD dzdecrtdp
            {<point name="input.b.page1.dzdecrtdp" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdecrtdp
            
            #add-point:AFTER FIELD dzdecrtdp
            {<point name="input.a.page1.dzdecrtdp" />}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dzdecrtdp
            #add-point:ON CHANGE dzdecrtdp
            {<point name="input.g.page1.dzdecrtdp" />}
            #END add-point
 
         #----<<dzdecrtdt>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdecrtdt
            #add-point:BEFORE FIELD dzdecrtdt
            {<point name="input.b.page1.dzdecrtdt" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdecrtdt
            
            #add-point:AFTER FIELD dzdecrtdt
            {<point name="input.a.page1.dzdecrtdt" />}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dzdecrtdt
            #add-point:ON CHANGE dzdecrtdt
            {<point name="input.g.page1.dzdecrtdt" />}
            #END add-point
 
 
         #---------------------<  Detail: page1  >---------------------
         #----<<dzdestus>>----
         #Ctrlp:input.c.dzdestus
##此段落由子樣板a03產生
         ON ACTION controlp INFIELD dzdestus
            #add-point:ON ACTION controlp INFIELD dzdestus
            {<point name="input.c.page1.dzdestus" />}
            #END add-point
 
         #----<<dzde001>>----
         #Ctrlp:input.c.dzde001
##此段落由子樣板a03產生
         ON ACTION controlp INFIELD dzde001
            #add-point:ON ACTION controlp INFIELD dzde001
            {<point name="input.c.page1.dzde001" />}
            #END add-point
 
         #----<<dzde002>>----
         #Ctrlp:input.c.dzde002
##此段落由子樣板a03產生
         ON ACTION controlp INFIELD dzde002
            #add-point:ON ACTION controlp INFIELD dzde002
            {<point name="input.c.page1.dzde002" />}
            #END add-point
 
         #----<<dzde003>>----
         #Ctrlp:input.c.dzde003
##此段落由子樣板a03產生
         ON ACTION controlp INFIELD dzde003
            #add-point:ON ACTION controlp INFIELD dzde003
            {<point name="input.c.page1.dzde003" />}
            #END add-point
 
         #----<<dzde004>>----
         #Ctrlp:input.c.dzde004
##此段落由子樣板a03產生
         ON ACTION controlp INFIELD dzde004
            #add-point:ON ACTION controlp INFIELD dzde004
            {<point name="input.c.page1.dzde004" />}
            #END add-point
 
         #----<<dzde005>>----
         #Ctrlp:input.c.dzde005
##此段落由子樣板a03產生
         ON ACTION controlp INFIELD dzde005
            #add-point:ON ACTION controlp INFIELD dzde005
            {<point name="input.c.page1.dzde005" />}
            #END add-point
 
         #----<<dzdemodid>>----
         #Ctrlp:input.c.dzdemodid
##此段落由子樣板a03產生
         ON ACTION controlp INFIELD dzdemodid
            #add-point:ON ACTION controlp INFIELD dzdemodid
            {<point name="input.c.page1.dzdemodid" />}
            #END add-point
 
         #----<<dzdemoddt>>----
         #Ctrlp:input.c.dzdemoddt
##此段落由子樣板a03產生
         ON ACTION controlp INFIELD dzdemoddt
            #add-point:ON ACTION controlp INFIELD dzdemoddt
            {<point name="input.c.page1.dzdemoddt" />}
            #END add-point
 
         #----<<dzdeownid>>----
         #Ctrlp:input.c.dzdeownid
##此段落由子樣板a03產生
         ON ACTION controlp INFIELD dzdeownid
            #add-point:ON ACTION controlp INFIELD dzdeownid
            {<point name="input.c.page1.dzdeownid" />}
            #END add-point
 
         #----<<dzdeowndp>>----
         #Ctrlp:input.c.dzdeowndp
##此段落由子樣板a03產生
         ON ACTION controlp INFIELD dzdeowndp
            #add-point:ON ACTION controlp INFIELD dzdeowndp
            {<point name="input.c.page1.dzdeowndp" />}
            #END add-point
 
         #----<<dzdecrtid>>----
         #Ctrlp:input.c.dzdecrtid
##此段落由子樣板a03產生
         ON ACTION controlp INFIELD dzdecrtid
            #add-point:ON ACTION controlp INFIELD dzdecrtid
            {<point name="input.c.page1.dzdecrtid" />}
            #END add-point
 
         #----<<dzdecrtdp>>----
         #Ctrlp:input.c.dzdecrtdp
##此段落由子樣板a03產生
         ON ACTION controlp INFIELD dzdecrtdp
            #add-point:ON ACTION controlp INFIELD dzdecrtdp
            {<point name="input.c.page1.dzdecrtdp" />}
            #END add-point
 
         #----<<dzdecrtdt>>----
         #Ctrlp:input.c.dzdecrtdt
##此段落由子樣板a03產生
         ON ACTION controlp INFIELD dzdecrtdt
            #add-point:ON ACTION controlp INFIELD dzdecrtdt
            {<point name="input.c.page1.dzdecrtdt" />}
            #END add-point
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_dzde_d[l_ac].* = g_dzde_d_t.*
               CLOSE adzi450_bcl
               ROLLBACK WORK
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_dzde_d[l_ac].dzde001
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_dzde_d[l_ac].* = g_dzde_d_t.*
            ELSE
            
               #add-point:單身修改前
               {<point name="input.body.b_update"/>}
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               LET g_dzde_d[l_ac].dzdemodid = g_user 
LET g_dzde_d[l_ac].dzdemoddt = cl_get_current()
 
      
               UPDATE dzde_t SET (dzdestus,dzde001,dzde002,dzde003,dzde004,dzde005,dzdemodid,dzdemoddt,dzdeownid,dzdeowndp,dzdecrtid,dzdecrtdp,dzdecrtdt) = (g_dzde_d[l_ac].dzdestus,g_dzde_d[l_ac].dzde001,g_dzde_d[l_ac].dzde002,g_dzde_d[l_ac].dzde003,g_dzde_d[l_ac].dzde004,g_dzde_d[l_ac].dzde005,g_dzde_d[l_ac].dzdemodid,g_dzde_d[l_ac].dzdemoddt,g_dzde_d[l_ac].dzdeownid,g_dzde_d[l_ac].dzdeowndp,g_dzde_d[l_ac].dzdecrtid,g_dzde_d[l_ac].dzdecrtdp,g_dzde_d[l_ac].dzdecrtdt)
                WHERE 
                  dzde001 = g_dzde_d_t.dzde001 #項次   
                  AND dzde002 = g_dzde_d_t.dzde002  
 
 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "dzde_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_dzde_d[l_ac].* = g_dzde_d_t.*
               ELSE
                                 INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_dzde_d[l_ac].dzde001
               LET gs_keys_bak[1] = g_dzde_d_t.dzde001
               LET gs_keys[2] = g_dzde_d[l_ac].dzde002
               LET gs_keys_bak[2] = g_dzde_d_t.dzde002
               CALL adzi450_update_b('dzde_t',gs_keys,gs_keys_bak)
                  #資料多語言用-增/改
                  
               END IF
               
               #add-point:單身修改後
               {<point name="input.body.a_update"/>}
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL adzi450_unlock_b("dzde_t")
            COMMIT WORK
            #其他table進行unlock
            
              
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
 
   CLOSE adzi450_bcl
   COMMIT WORK
   
END FUNCTION
 
 
#+ 單身陣列填充
PRIVATE FUNCTION adzi450_b_fill(p_wc2)              #BODY FILL UP
   {<Local define>}
   DEFINE p_wc2           STRING
   {</Local define>}
   #add-point:b_fill段define
   {<point name="b_fill.define"/>}
   #end add-point
 
   LET g_sql = "SELECT dzdestus,dzde001,dzde002,dzde003,dzde004,dzde005,dzdemodid,'',dzdemoddt,dzdeownid,'',dzdeowndp,'',dzdecrtid,'',dzdecrtdp,'',dzdecrtdt FROM dzde_t",
               "",
               " WHERE 1=1 AND ", p_wc2
    
   LET g_sql = g_sql, " ORDER BY dzde_t.dzde001"
  
   PREPARE adzi450_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR adzi450_pb
   
   
 
   CALL g_dzde_d.clear()
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_dzde_d[l_ac].dzdestus,g_dzde_d[l_ac].dzde001,g_dzde_d[l_ac].dzde002,g_dzde_d[l_ac].dzde003,g_dzde_d[l_ac].dzde004,g_dzde_d[l_ac].dzde005,g_dzde_d[l_ac].dzdemodid,g_dzde_d[l_ac].dzdemodid_desc,g_dzde_d[l_ac].dzdemoddt,g_dzde_d[l_ac].dzdeownid,g_dzde_d[l_ac].dzdeownid_desc,g_dzde_d[l_ac].dzdeowndp,g_dzde_d[l_ac].dzdeowndp_desc,g_dzde_d[l_ac].dzdecrtid,g_dzde_d[l_ac].dzdecrtid_desc,g_dzde_d[l_ac].dzdecrtdp,g_dzde_d[l_ac].dzdecrtdp_desc,g_dzde_d[l_ac].dzdecrtdt
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
      
      CALL adzi450_detail_show()      
 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ""
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
   END FOREACH
   
 
   
   CALL g_dzde_d.deleteElement(g_dzde_d.getLength())   
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_dzde_d.getLength()
 
   END FOR
   
   #add-point:b_fill段資料填充(其他單身)
   {<point name="b_fill.others.fill"/>}
   #end add-point
 
   LET g_detail_cnt = l_ac - 1
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE adzi450_pb
   
END FUNCTION
 
#+ 顯示相關資料
PRIVATE FUNCTION adzi450_detail_show()
   #add-point:show段define
   {<point name="detail_show.define"/>}
   #end add-point
 
   #add-point:detail_show段之前
   {<point name="detail_show.before"/>}
   #end add-point
   
   #帶出公用欄位reference值page1
   #此段落由子樣板a12產生
      #帶出預設欄位之值
      LET g_dzde_d[l_ac].dzdemodid_desc = cl_get_username(g_dzde_d[l_ac].dzdemodid)
      LET g_dzde_d[l_ac].dzdeownid_desc = cl_get_username(g_dzde_d[l_ac].dzdeownid)
      LET g_dzde_d[l_ac].dzdecrtid_desc = cl_get_username(g_dzde_d[l_ac].dzdecrtid)
      LET g_dzde_d[l_ac].dzdecrtdp_desc = cl_get_deptname(g_dzde_d[l_ac].dzdecrtdp)
      LET g_dzde_d[l_ac].dzdeowndp_desc = cl_get_deptname(g_dzde_d[l_ac].dzdeowndp)
 
 
    
 
   
   #讀入ref值
   #add-point:show段單身reference
 
   #end add-point
   
   #add-point:detail_show段之後
   {<point name="detail_show.after"/>}
   #end add-point
 
END FUNCTION
 
 
#+ 單身欄位開啟設定
PRIVATE FUNCTION adzi450_set_entry_b(p_cmd)                                                  
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1         
   {</Local define>}
   #add-point:set_entry_b段define
   {<point name="set_entry_b.define"/>}
   #end add-point                                                                   
                                                                                
END FUNCTION                                                                    
                                                                                
 
#+ 單身欄位關閉設定
PRIVATE FUNCTION adzi450_set_no_entry_b(p_cmd)                                               
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1           
   {</Local define>}
   #add-point:set_no_entry_b段define
   {<point name="set_no_entry_b.define"/>}
   #end add-point                                                                  
                                                                                
END FUNCTION  
 
#+ 外部參數搜尋, 施工中
PRIVATE FUNCTION adzi450_default_search()
   {<Local define>}
   DEFINE li_idx  LIKE type_t.num5
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE ls_wc   STRING
   {</Local define>}
   #add-point:default_search段define
   {<point name="default_search.define"/>}
   #end add-point  
   
   IF NOT cl_null(g_argv[1]) THEN
      LET ls_wc = ls_wc, " dzde001 = '", g_argv[1], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " dzde002 = ", g_argv[02], " AND "
   END IF
 
 
   
   IF NOT cl_null(ls_wc) THEN
      LET ls_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_wc2 = ls_wc
   ELSE
      LET g_wc2 = " 1=1"
   END IF
 
END FUNCTION
 
#+ 刪除單身後其他table連動
PRIVATE FUNCTION adzi450_delete_b(ps_table,ps_keys_bak)
   {<Local define>}
   DEFINE ps_table    STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   {</Local define>}
   #add-point:delete_b段define
   {<point name="delete_b.define"/>}
   #end add-point     
 
   #判斷是否是同一群組的table
   LET ls_group = "dzde_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND
      ps_table <> "dzde_t" THEN
      DELETE FROM dzde_t
       WHERE 
         dzde001 = ps_keys_bak[1] AND dzde002 = ps_keys_bak[2]
 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ""
         LET g_errparam.popup = FALSE
         CALL cl_err()
      END IF
   END IF
   
 
   
END FUNCTION
 
#+ 新增單身後其他table連動
PRIVATE FUNCTION adzi450_insert_b(ps_table,ps_keys)
   {<Local define>}
   DEFINE ps_table    STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   {</Local define>}
   #add-point:insert_b段define
   {<point name="insert_b.define"/>}
   #end add-point     
 
   #給予預設值
    
   #此段落由子樣板a14產生    
      LET g_dzde_d[l_ac].dzdecrtid = g_user
      LET g_dzde_d[l_ac].dzdecrtdp = g_dept
      LET g_dzde_d[l_ac].dzdecrtdt = cl_get_current()
      LET g_dzde_d[l_ac].dzdeownid = g_user 
      LET g_dzde_d[l_ac].dzdeowndp = g_dept 
      LET g_dzde_d[l_ac].dzdemodid = g_user
      LET g_dzde_d[l_ac].dzdemoddt = cl_get_current()
      LET g_dzde_d[l_ac].dzdestus = "Y"
 
 
 
   #判斷是否是同一群組的table
   LET ls_group = "dzde_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      INSERT INTO dzde_t
                  (
                   dzde001,dzde002
                   ,dzdestus,dzde003,dzde004,dzde005,dzdemodid,dzdemoddt,dzdeownid,dzdeowndp,dzdecrtid,dzdecrtdp,dzdecrtdt) 
            VALUES(
                   ps_keys[1],ps_keys[2]
                   ,g_dzde_d[l_ac].dzdestus,g_dzde_d[l_ac].dzde003,g_dzde_d[l_ac].dzde004,g_dzde_d[l_ac].dzde005,g_dzde_d[l_ac].dzdemodid,g_dzde_d[l_ac].dzdemoddt,g_dzde_d[l_ac].dzdeownid,g_dzde_d[l_ac].dzdeowndp,g_dzde_d[l_ac].dzdecrtid,g_dzde_d[l_ac].dzdecrtdp,g_dzde_d[l_ac].dzdecrtdt)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "dzde_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
      END IF
   END IF
   
 
   
END FUNCTION
 
    
#+ 修改單身後其他table連動
PRIVATE FUNCTION adzi450_update_b(ps_table,ps_keys,ps_keys_bak)
   {<Local define>}
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
   LET ls_group = "dzde_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND
      ps_table <> "dzde_t" THEN
      UPDATE dzde_t 
         SET (dzde001,dzde002
              ,dzdestus,dzde003,dzde004,dzde005,dzdemodid,dzdemoddt,dzdeownid,dzdeowndp,dzdecrtid,dzdecrtdp,dzdecrtdt) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_dzde_d[l_ac].dzdestus,g_dzde_d[l_ac].dzde003,g_dzde_d[l_ac].dzde004,g_dzde_d[l_ac].dzde005,g_dzde_d[l_ac].dzdemodid,g_dzde_d[l_ac].dzdemoddt,g_dzde_d[l_ac].dzdeownid,g_dzde_d[l_ac].dzdeowndp,g_dzde_d[l_ac].dzdecrtid,g_dzde_d[l_ac].dzdecrtdp,g_dzde_d[l_ac].dzdecrtdt) 
         WHERE dzde001 = ps_keys_bak[1] AND dzde002 = ps_keys_bak[2]
 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ""
         LET g_errparam.popup = FALSE
         CALL cl_err()
      ELSE
         
      END IF
      
   END IF
   
 
   
END FUNCTION
 
#+ 連動lock其他單身table資料
PRIVATE FUNCTION adzi450_lock_b(ps_table)
 
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define
   {<point name="lock_b.define"/>}
   #end add-point   
   
   #先刷新資料
   #CALL adzi450_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "dzde_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN adzi450_bcl USING 
                                       g_dzde_d[l_ac].dzde001,g_dzde_d[l_ac].dzde002
                                       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "adzi450_bcl"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION adzi450_unlock_b(ps_table)
 
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:unlock_b段define
   {<point name="unlock_b.define"/>}
   #end add-point  
   
   LET ls_group = ""
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      CLOSE adzi450_bcl
   END IF
   
 
 
END FUNCTION
 
 
 
 
{<point name="other.function"/>}
 




