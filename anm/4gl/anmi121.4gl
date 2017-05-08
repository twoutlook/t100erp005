#該程式未解開Section, 採用最新樣板產出!
{<section id="anmi121.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0010(2015-07-15 18:20:47), PR版次:0010(2016-11-28 14:08:50)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000314
#+ Filename...: anmi121
#+ Description: 企業銀行帳戶會科維護
#+ Creator....: ()
#+ Modifier...: 01727 -SD/PR- 07900
 
{</section>}
 
{<section id="anmi121.global" >}
#應用 i00 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#150715-00014#1   2015/07/15 By Jessy   bug修復
#150916-00015#1   2015/11/30 By taozf   当有账套时，科目检查改为检查是否存在于glad_t中
#160122-00001#25  2016/01/27 By yangtt  添加交易帳戶編號用戶權限空管  
#160122-00001#25  2016/03/16 By 07673   添加交易帳戶編號用戶權限空管,增加部门权限
#160318-00005#25  2016/03/30 by 07675   將重複內容的錯誤訊息置換為公用錯誤訊息
#160905-00007#7   2016/09/05 By 01727   调整系统中无ENT的SQL条件增加ent
#161110-00001#1   2016/11/28 By 07900   ANM模組使用ooea_t/ooeaf_t的需替換ooef_t/ooefl_t
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
{<Module define>}

#單身 type 宣告
PRIVATE TYPE type_g_glab_d RECORD
       glab003 LIKE glab_t.glab003,
       nmas003 LIKE nmas_t.nmas003,
       glabld LIKE glab_t.glabld,
       glab005 LIKE glab_t.glab005,
       glab005_desc LIKE type_t.chr80
       END RECORD

#模組變數(Module Variables)
DEFINE g_glab_d          DYNAMIC ARRAY OF type_g_glab_d
DEFINE g_glab_d_t        type_g_glab_d


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

#多table用wc
DEFINE g_wc_table           STRING


{</Module define>}          {#ADP版次:1#}
#end add-point
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_rec_b               LIKE type_t.num5 
DEFINE g_wc                  STRING
DEFINE g_browser    DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       #外顯欄位
       b_show          LIKE type_t.chr100,
       #父節點id
       b_pid           LIKE type_t.chr100,
       #本身節點id
       b_id            LIKE type_t.chr100,
       #是否展開
       b_exp           LIKE type_t.chr100,
       #是否有子節點
       b_hasC          LIKE type_t.num5,
       #是否已展開
       b_isExp         LIKE type_t.num5,
       #展開值
       b_expcode       LIKE type_t.num5,
       b_nmaa001       LIKE nmaa_t.nmaa001,
       b_nmas002       LIKE nmas_t.nmas002,
       b_nmas003       LIKE nmas_t.nmas003,
       b_glabld        LIKE glab_t.glabld,
       b_glaal002      LIKE glaal_t.glaal002,
       b_glab005       LIKE glab_t.glab005,
       b_glacl004      LIKE glacl_t.glacl004
       END RECORD
DEFINE g_searchcol           LIKE type_t.chr200
DEFINE g_searchstr           LIKE type_t.chr200
DEFINE g_searchtype          LIKE type_t.chr200
DEFINE g_wc_def         STRING
DEFINE g_browser_root    DYNAMIC ARRAY OF INTEGER
DEFINE g_browser_cnt         LIKE type_t.num5
DEFINE g_current_idx         LIKE type_t.num10 
DEFINE g_current_row         LIKE type_t.num5       
DEFINE g_current_sw          LIKE type_t.num5     
DEFINE g_row_index           LIKE type_t.num5

DEFINE g_sql_bank            STRING     #160122-00001#25 by 07673 add
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
{</section>}
 
{<section id="anmi121.main" >}
#+ 作業開始
MAIN
   #add-point:main段define name="main.define"
   
   #end add-point    
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point
 
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("anm","")
 
   #add-point:作業初始化 name="main.init"
 
   #end add-point
 
   #add-point:SQL_define name="main.define_sql"
   #LET g_forupd_sql = ""          {#ADP版次:1#}
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)    #轉換不同資料庫語法
   DECLARE anmi121_cl CURSOR FROM g_forupd_sql 
   
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_anmi121 WITH FORM cl_ap_formpath("anm",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL anmi121_init()
 
      #進入選單 Menu (='N')
      CALL anmi121_ui_dialog()
   
      #畫面關閉
      CLOSE WINDOW w_anmi121
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
 
END MAIN
 
{</section>}
 
{<section id="anmi121.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"
#
PRIVATE FUNCTION anmi121_glaa004_get(p_glabld)
   DEFINE p_glabld LIKE glab_t.glabld
   DEFINE r_glaa004 LIKE glaa_t.glaa004
   
   LET r_glaa004 = ''
   SELECT glaa004 INTO r_glaa004 FROM glaa_t 
    WHERE glaaent = g_enterprise AND glaald = p_glabld
   RETURN r_glaa004
END FUNCTION
#+
PRIVATE FUNCTION anmi121_b_refresh()
   DEFINE l_sql STRING
   
   LET l_sql = ''
   IF NOT cl_null(g_current_idx) AND g_current_idx >0 THEN
      IF cl_null(g_browser[g_current_idx].b_nmas002) THEN
         LET l_sql = " glab003 IN (SELECT nmas002 FROM nmas_t WHERE nmasent = '",g_enterprise,"' ",
                     "  AND nmas001 = '",g_browser[g_current_idx].b_nmaa001,"')"
      ELSE
         IF cl_null(g_browser[g_current_idx].b_glabld) THEN
            LET l_sql = " glab003 = '",g_browser[g_current_idx].b_nmas002,"' "
         ELSE
            LET l_sql = " glab003 = '",g_browser[g_current_idx].b_nmas002,"' AND glabld = '",g_browser[g_current_idx].b_glabld,"' "
         END IF 
      END IF 
      #160122-00001#25 By 07673--add---str
      LET l_sql = l_sql CLIPPED," AND (glab003 IN(",g_sql_bank,")",
                                "  OR TRIM(glab003) IS NULL )"
      #160122-00001#25 By 07673--add---end
      #160122-00001#25 By 07673--mark---str
#      #160122-00001#25--add---str
#      LET l_sql = l_sql CLIPPED," AND (glab003 IN(SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise," AND nmll002='",g_user,"')
#                                   OR glab003 IS NULL)"
#      #160122-00001#25--add---end
      #160122-00001#25 By 07673--mark---end
   END IF 
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
   LET l_sql = l_sql," AND ",g_wc2
   CALL anmi121_b_fill(l_sql)
END FUNCTION
#
PRIVATE FUNCTION anmi121_browser_create(p_type)
   DEFINE p_type   LIKE type_t.chr50
   DEFINE l_pid    LIKE type_t.chr50   #用於樹的第一層
   DEFINE l_pid2   LIKE type_t.chr50   #用於樹的第一層
   DEFINE l_sql    STRING 
   DEFINE l_glac005_desc LIKE glacl_t.glacl004
   DEFINE l_nmaal003 LIKE nmaal_t.nmaal003
   #建立樹上面的內容
   CALL g_browser.clear()
   CLEAR FORM
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
   IF cl_null(g_wc_def ) THEN
      LET g_wc2 = " 1=1"
   END IF
   #第一層的資料
   LET l_sql = " SELECT UNIQUE nmaa001 FROM nmaa_t ",
               "  WHERE nmaaent = '",g_enterprise,"'",
               "    AND ",g_wc_def,
               "  ORDER BY nmaa001 "
   PREPARE master_type_0 FROM l_sql
   DECLARE master_typecur_0 CURSOR FOR master_type_0
   #第二層的資料
   LET l_sql = " SELECT UNIQUE nmas002 FROM nmas_t ",
               "  WHERE nmasent = '",g_enterprise,"' AND nmas001 = ? ",
               #160122-00001#25 By 07673--add--str
               " AND (nmas002 IN(",g_sql_bank,")",
               "    OR TRIM(nmas002) IS NULL)",
               #160122-00001#25 By 07673--add---end
               #160122-00001#25 By 07673--mark---str
#               #160122-00001#25--add---str
#               " AND (nmas002 IN(SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise," AND nmll002='",g_user,"')
#                  OR nmas002 IS NULL)",
#               #160122-00001#25--add---end
               #160122-00001#25 By 07673--mark---str
               "  ORDER BY nmas002"
   PREPARE master_type_1 FROM l_sql
   DECLARE master_typecur_1 CURSOR FOR master_type_1
   #第三層的資料
   LET l_sql = " SELECT UNIQUE glabld,glab005 FROM glab_t ",
               "  WHERE glabent = '",g_enterprise,"' AND glab001 = '40' AND glab002 = '40' AND glab003 = ?  ", 
               "    AND glabld IN (SELECT glabld FROM glab_t  ",
               "                     WHERE glabent = '",g_enterprise,"' AND glab001 = '40' AND glab002 = '40' ",
               "                       AND ",g_wc2,")",
               "  ORDER BY glabld "
   PREPARE master_type_2 FROM l_sql
   DECLARE master_typecur_2 CURSOR FOR master_type_2

   INITIALIZE g_browser_root TO NULL
   #初始化l_ac
   LET l_ac = 1

   FOREACH master_typecur_0 INTO g_browser[l_ac].b_nmaa001
      #確定第一层root節點所在
      LET g_browser_root[g_browser_root.getLength()+1] = l_ac
      #此處(LV-1)
      LET g_browser[l_ac].b_nmaa001 = g_browser[l_ac].b_nmaa001
      LET g_browser[l_ac].b_pid = '0' CLIPPED
      LET g_browser[l_ac].b_id = l_ac USING "<<<"
      LET g_browser[l_ac].b_exp = TRUE
      LET g_browser[l_ac].b_hasC = TRUE
      #第一層给与第二层的值
      LET l_pid = g_browser[l_ac].b_id CLIPPED
      LET g_cnt = l_ac
      LET l_ac = l_ac + 1 
      FOREACH master_typecur_1 USING g_browser[g_cnt].b_nmaa001 INTO g_browser[l_ac].b_nmas002
         LET g_browser_root[g_browser_root.getLength()+1] = l_ac
         #此處(LV-2)
         LET g_browser[l_ac].b_nmaa001 = g_browser[g_cnt].b_nmaa001
         LET g_browser[l_ac].b_nmas002 = g_browser[l_ac].b_nmas002
         LET g_browser[l_ac].b_pid = l_pid
         LET g_browser[l_ac].b_id = l_pid,".",l_ac USING "<<<"
         LET g_browser[l_ac].b_exp = TRUE
         LET g_browser[l_ac].b_hasC = TRUE
         #第二層给与第三层的值
         LET l_pid2 = g_browser[l_ac].b_id CLIPPED
         LET g_cnt = l_ac
         LET l_ac = l_ac + 1 
         FOREACH master_typecur_2 USING g_browser[g_cnt].b_nmas002 INTO g_browser[l_ac].b_glabld,g_browser[l_ac].b_glab005
	        LET g_browser[l_ac].b_nmaa001 = g_browser[g_cnt].b_nmaa001
            LET g_browser[l_ac].b_nmas002 = g_browser[g_cnt].b_nmas002
	        LET g_browser[l_ac].b_glabld = g_browser[l_ac].b_glabld
	        SELECT glaal002 INTO g_browser[l_ac].b_glaal002 FROM glaal_t
             WHERE glaalent = g_enterprise AND glaalld = g_browser[l_ac].b_glabld AND glaal001 = g_dlang
	        LET g_browser[l_ac].b_glab005 = g_browser[l_ac].b_glab005
	        CALL anmi121_glab005_ref(g_browser[l_ac].b_glabld,g_browser[l_ac].b_glab005) 
	           RETURNING g_browser[l_ac].b_glacl004
            LET g_browser[l_ac].b_pid = l_pid2
            LET g_browser[l_ac].b_id = l_pid2,".",l_ac USING "<<<"
            LET g_browser[l_ac].b_exp = TRUE
            LET g_browser[l_ac].b_hasC = FALSE
            LET l_ac = l_ac +1
	     END FOREACH
      END FOREACH
      LET l_ac = g_browser.getLength()
   END FOREACH 

   #組合描述欄位&刪除多於資料
   FOR l_ac = 1 TO g_browser.getLength()
      LET l_glac005_desc = ''
      IF cl_null(g_browser[l_ac].b_nmaa001) THEN
         CALL g_browser.deleteElement(l_ac)
         LET l_ac = l_ac - 1
      ELSE
         IF cl_null(g_browser[l_ac].b_nmas002) THEN
            SELECT nmaal003 INTO l_nmaal003 FROM nmaal_t
             WHERE nmaalent = g_enterprise AND nmaal001 = g_browser[l_ac].b_nmaa001 AND nmaal002 = g_dlang
            LET g_browser[l_ac].b_show = g_browser[l_ac].b_nmaa001," ",l_nmaal003
         ELSE
            IF cl_null(g_browser[l_ac].b_glabld) THEN
               CALL anmi121_glab003_ref(g_browser[l_ac].b_nmas002) RETURNING g_browser[l_ac].b_nmas003
               LET g_browser[l_ac].b_show = g_browser[l_ac].b_nmas002,"    ",g_browser[l_ac].b_nmas003           
            END IF 
         END IF 
      END IF
   END FOR
   CALL g_browser.deleteElement(l_ac)
   
   LET g_browser_cnt = g_browser.getLength() - g_browser_root.getLength()
END FUNCTION

PRIVATE FUNCTION anmi121_init()
   #160122-00001#5 --add--str--
   LET g_sql_bank=NULL
   CALL s_anmi120_get_bank_account_sql(g_user,g_dept) RETURNING g_sub_success,g_sql_bank
   #160122-00001#5 --add--end
   CALL anmi121_default_search()

END FUNCTION

PRIVATE FUNCTION anmi121_ui_dialog()
   DEFINE li_idx   LIKE type_t.num5

   LET g_action_choice = " "
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()

   CALL cl_set_act_visible("accept,cancel", FALSE)

   LET g_detail_idx = 1
   
   WHILE TRUE

      CALL anmi121_browser_fill(g_wc2,g_searchtype)
      
      #IF NOT cl_null(g_argv[1]) THEN 
      #   CALL anmi121_b_fill("1=1")
      #END IF
      
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
        
         INPUT g_searchstr,g_searchcol,g_searchtype FROM formonly.searchstr,formonly.cbo_searchcol,formonly.rdo_searchtype
               BEFORE INPUT
         END INPUT

         #左側瀏覽頁簽
         DISPLAY ARRAY g_browser TO s_browse.* ATTRIBUTE(COUNT=g_rec_b)

               BEFORE ROW
                  #回歸舊筆數位置 (回到當時異動的筆數)
                  LET g_current_idx = DIALOG.getCurrentRow("s_browse")
                  IF g_current_row > 1 AND g_current_sw = FALSE THEN
                     CALL DIALOG.setCurrentRow("s_browse",g_current_row)
                     LET g_current_idx = g_current_row
                  END IF
                  LET g_current_row = g_current_idx #目前指標
                  LET g_current_sw = TRUE
                  CALL cl_show_fld_cont()
                  CALL DIALOG.setCurrentRow("s_browse",g_current_row)
                  CALL anmi121_b_refresh()                
               ON EXPAND (g_row_index)
                  #樹展開
                 # CALL anmi931_browser_expand(g_row_index)
                  LET g_browser[g_row_index].b_isExp = 1

               ON COLLAPSE (g_row_index)
                  #樹關閉

         END DISPLAY         
         DISPLAY ARRAY g_glab_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)

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

         BEFORE DIALOG
            IF g_temp_idx > 0 THEN
               LET l_ac = g_temp_idx
               CALL DIALOG.setCurrentRow("s_detail1",l_ac)
               LET g_temp_idx = 1
            END IF
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            NEXT FIELD CURRENT



         #一般搜尋
         ON ACTION searchdata
            LET g_searchstr = GET_FLDBUF(searchstr)
            LET g_searchcol = GET_FLDBUF(cbo_searchcol)
            #若無輸入關鍵字則查找出所有資料
            IF g_searchcol='0' AND NOT cl_null(g_searchstr) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00001"
               LET g_errparam.extend = "searchcol:"
               LET g_errparam.popup = FALSE
               CALL cl_err()

               CONTINUE DIALOG
            END IF
            IF NOT cl_null(g_searchstr) THEN
               LET g_wc2 = " lower(", g_searchcol, ") LIKE '%", g_searchstr, "%'"
               LET g_wc2 = g_wc2.toLowerCase()
            ELSE
               LET g_wc2 = " 1=1 "
            END IF
            EXIT DIALOG
            
         ON ACTION modify

            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               CALL anmi121_modify()
               #add-point:ON ACTION modify
               {<point name="menu.modify" />}
               #END add-point
                EXIT DIALOG
            END IF
            
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               CALL anmi121_modify()
               EXIT DIALOG
            END IF
          
          #150715-00014#1 無列印功能，暫時mark
#         ON ACTION output
#
#            LET g_action_choice="output"
#            IF cl_auth_chk_act("output") THEN
#               #add-point:ON ACTION output
#               {<point name="menu.output" />}
#               #END add-point
#                EXIT DIALOG
#            END IF

         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_glab_d)
               LET g_export_id[1]   = "s_detail1"
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF

         ON ACTION query

            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL anmi121_query()
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

PRIVATE FUNCTION anmi121_query()
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING

   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_glab_d.clear()

   LET g_qryparam.state = "c"

   #wc備份
   LET ls_wc = g_wc2

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      CONSTRUCT g_wc2 ON glab003,glabld,glab005

         FROM s_detail1[1].glab003,s_detail1[1].glabld,s_detail1[1].glab005
         
         ON ACTION controlp INFIELD glabld
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            CALL q_authorised_ld()                        #呼叫開窗
            DISPLAY g_qryparam.return1 TO glabld  #顯示到畫面上
            NEXT FIELD glabld                    #返回原欄位
            
         ON ACTION controlp INFIELD glab005
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " glac003 <>'1' "
            CALL aglt310_04()
            LET g_qryparam.where = ""
            DISPLAY g_qryparam.return1 TO glab005  #顯示到畫面上
            NEXT FIELD glab005                    #返回原欄位
            
         BEFORE CONSTRUCT
            CALL cl_qbe_init()

         ON ACTION qbe_select
            #CALL cl_qbe_select()

         ON ACTION qbe_save
            CALL cl_qbe_save()

      END CONSTRUCT


      ON ACTION accept
         EXIT DIALOG

      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG

      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   END DIALOG
   LET g_wc_def = " 1=1"
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      LET g_wc2 = ls_wc
      LET g_wc_def = " nmaa001 = '", g_argv[1], "' "
   END IF
   CALL anmi121_browser_fill(g_wc2,g_searchtype)

   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
   #   CALL cl_err("",-100,1)
   END IF

   LET INT_FLAG = FALSE

END FUNCTION

PRIVATE FUNCTION anmi121_delete()
   DEFINE li_ac LIKE type_t.num5

   IF NOT cl_ask_delete() THEN
      LET INT_FLAG = 1 #不刪除
   ELSE
      LET INT_FLAG = 0 #要刪除
   END IF

   LET li_ac = ARR_CURR()

   CALL s_transaction_begin()

   DELETE FROM glab_t
         WHERE glabld = g_glab_d[li_ac].glabld
           AND glab001 = '40'
           AND glab002 = '40'
           AND glab003 = g_glab_d[li_ac].glab003
           AND glabent = g_enterprise   #160905-00007#7 Add ent
           #160122-00001#1--add---str
           AND glab003 IN (SELECT nmll001 FROM nmll_t WHERE nmllent = g_enterprise AND nmll002 = g_user)
           #160122-00001#1--add---end

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "glab_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CALL s_transaction_end('N','0')
   ELSE
      CALL s_transaction_end('Y','0')
   END IF

END FUNCTION

PRIVATE FUNCTION anmi121_modify()
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
   DEFINE  l_glaa004       LIKE glaa_t.glaa004
   DEFINE  l_success       LIKE type_t.num5
   DEFINE  l_nmas001       LIKE nmas_t.nmas001
   DEFINE  l_nmaa002       LIKE nmaa_t.nmaa002
   DEFINE  l_ooef017       LIKE ooef_t.ooef017

   LET g_action_choice = ""

   LET g_qryparam.state = "i"

   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")

   LET g_forupd_sql = "SELECT glab003,'',glabld,glab005,'' FROM glab_t ",
                      " WHERE glabent=? AND glabld=? AND glab001='40' AND glab002='40' AND glab003=? FOR UPDATE"
   LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
   DECLARE anmi121_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR

   LET INT_FLAG = FALSE
   
   LET g_errshow = 1

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #Page1 預設值產生於此處
      INPUT ARRAY g_glab_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)

         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN
              CALL FGL_SET_ARR_CURR(g_glab_d.getLength()+1)
              LET g_insert = 'N'
           END IF
            
            #IF NOT cl_null(g_argv[1]) THEN 
            #   CALL anmi121_b_fill("1=1")
            #ELSE
               CALL anmi121_b_refresh()
            #END IF
            LET g_detail_cnt = g_glab_d.getLength()

         BEFORE ROW
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx

            CALL s_transaction_begin()
            LET g_detail_cnt = g_glab_d.getLength()

            IF g_detail_cnt >= l_ac
               AND NOT cl_null(g_glab_d[l_ac].glabld)
            THEN
               LET l_cmd='u'
			   LET g_glab_d_t.* = g_glab_d[l_ac].*  #BACKUP
               IF NOT anmi121_lock_b("glab_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH anmi121_bcl INTO g_glab_d[l_ac].glab003,g_glab_d[l_ac].nmas003,g_glab_d[l_ac].glabld,g_glab_d[l_ac].glab005,g_glab_d[l_ac].glab005_desc
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = g_glab_d_t.glabld
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                  END IF
                  CALL anmi121_detail_show()
                  CALL cl_show_fld_cont()
                  CALL anmi121_glaa004_get(g_glab_d[l_ac].glabld)
                     RETURNING l_glaa004
               END IF
            ELSE
               LET l_cmd='a'
            END IF

         BEFORE INSERT

            CALL s_transaction_begin()
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_glab_d_t.* TO NULL
            INITIALIZE g_glab_d[l_ac].* TO NULL

            LET g_glab_d_t.* = g_glab_d[l_ac].*     #新輸入資料
            IF NOT cl_null(g_current_idx) AND g_current_idx >0 THEN
               LET g_glab_d[l_ac].glab003 = g_browser[g_current_idx].b_nmas002
               CALL anmi121_glab003_ref(g_glab_d[l_ac].glab003) 
                  RETURNING g_glab_d[l_ac].nmas003
            END IF
            CALL cl_show_fld_cont()
            CALL anmi121_set_entry_b("a")
            CALL anmi121_set_no_entry_b("a")

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
            SELECT COUNT(*) INTO l_count FROM glab_t
             WHERE glabent = g_enterprise AND glabld = g_glab_d[l_ac].glabld
                                       AND glab001 = '40'
                                       AND glab002 = '40'
                                       AND glab003 = g_glab_d[l_ac].glab003

            #資料未重複, 插入新增資料
            IF l_count = 0 THEN
               INITIALIZE gs_keys TO NULL
               LET gs_keys[1] = g_glab_d[l_ac].glabld
               LET gs_keys[2] = '40'
               LET gs_keys[3] = '40'
               LET gs_keys[4] = g_glab_d[l_ac].glab003
               CALL anmi121_insert_b('glab_t',gs_keys,"'1'")
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_glab_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF

            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "glab_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CALL s_transaction_end('N','0')
               CANCEL INSERT
            ELSE
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
            END IF

         BEFORE DELETE                            #是否取消單身
            IF NOT cl_null(g_glab_d[l_ac].glabld)
               AND NOT cl_null(g_glab_d_t.glab003)
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

               DELETE FROM glab_t
                WHERE glabent = g_enterprise AND
                      glabld = g_glab_d_t.glabld
                      AND glab001 ='40'
                      AND glab002 = '40'
                      AND glab003 = g_glab_d_t.glab003
                      #160122-00001#1--add---str
                      AND glab003 IN (SELECT nmll001 FROM nmll_t WHERE nmllent = g_enterprise AND nmll002 = g_user)
                      #160122-00001#1--add---end

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "glab_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

                  CALL s_transaction_end('N','0')
                  CANCEL DELETE
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               CLOSE anmi121_bcl
               LET l_count = g_glab_d.getLength()
            END IF

         AFTER DELETE
            CALL anmi121_delete_b('glab_t',gs_keys,"'1'")


         AFTER FIELD glab003
            DISPLAY '' TO s_detail[l_ac].nmas003
            IF NOT anmi121_key_chk(g_glab_d[l_ac].glab003,g_glab_d_t.glab003,g_glab_d[l_ac].glabld,g_glab_d_t.glabld,l_cmd) THEN
               LET g_glab_d[l_ac].glab003 = g_glab_d_t.glab003
               CALL anmi121_glab003_ref(g_glab_d[l_ac].glab003) 
                  RETURNING g_glab_d[l_ac].nmas003
               DISPLAY g_glab_d[l_ac].nmas003 TO nmas003
               NEXT FIELD glab003
            END IF 
            IF NOT anmi121_glab003_chk(g_glab_d[l_ac].glab003,g_glab_d_t.glab003,l_cmd) THEN
               LET g_glab_d[l_ac].glab003 = g_glab_d_t.glab003
               CALL anmi121_glab003_ref(g_glab_d[l_ac].glab003) 
                  RETURNING g_glab_d[l_ac].nmas003
               DISPLAY g_glab_d[l_ac].nmas003 TO nmas003
               NEXT FIELD glab003
            END IF 
            #160122-00001#25--add---str
            IF NOT cl_null(g_glab_d[l_ac].glab003) THEN
              IF NOT s_anmi120_nmll002_chk(g_glab_d[l_ac].glab003,g_user) THEN
                 INITIALIZE g_errparam TO NULL 
                 LET g_errparam.extend = g_glab_d[l_ac].glab003
                 LET g_errparam.code   = 'anm-00574' 
                 LET g_errparam.popup  = TRUE 
                 CALL cl_err()
                 LET g_glab_d[l_ac].glab003 = g_glab_d_t.glab003
                 CALL anmi121_glab003_ref(g_glab_d[l_ac].glab003) 
                    RETURNING g_glab_d[l_ac].nmas003
                 DISPLAY g_glab_d[l_ac].nmas003 TO nmas003
                 NEXT FIELD CURRENT
              END IF
            END IF
            #160122-00001#25--add---end
            CALL anmi121_glab003_ref(g_glab_d[l_ac].glab003) 
               RETURNING g_glab_d[l_ac].nmas003
            DISPLAY g_glab_d[l_ac].nmas003 TO nmas003
            
               
         AFTER FIELD glabld
            IF NOT anmi121_key_chk(g_glab_d[l_ac].glab003,g_glab_d_t.glab003,g_glab_d[l_ac].glabld,g_glab_d_t.glabld,l_cmd) THEN
               LET g_glab_d[l_ac].glabld = g_glab_d_t.glabld
               NEXT FIELD glabld
            END IF
            #IF NOT anmi121_glabld_chk(g_glab_d[l_ac].glabld) THEN
            #   LET g_glab_d[l_ac].glabld = g_glab_d_t.glabld
            #   NEXT FIELD glabld
            #END IF 
            
            IF NOT cl_null(g_glab_d[l_ac].glabld) THEN 
#此段落由子樣板a19產生
              #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
              INITIALIZE g_chkparam.* TO NULL
              
              #設定g_chkparam.*的參數
              LET g_chkparam.arg1 = g_glab_d[l_ac].glabld
              
                 
              #呼叫檢查存在並帶值的library
              IF cl_chk_exist("v_glaald") THEN
                 #檢查成功時後續處理
                 #LET  = g_chkparam.return1
                 #DISPLAY BY NAME 
                 CALL s_ld_chk_authorization(g_user,g_glab_d[l_ac].glabld) RETURNING l_success
                 IF l_success = FALSE THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = 'axr-00022'
                    LET g_errparam.extend = g_glab_d[l_ac].glabld
                    LET g_errparam.popup = TRUE
                    CALL cl_err()

                    LET g_glab_d[l_ac].glabld = ''
                    NEXT FIELD CURRENT
                 END IF 
                 
                 #是否為當前法人
                 
                 SELECT nmas001 INTO l_nmas001 
                   FROM nmas_t
                  WHERE nmasent = g_enterprise
                    AND nmas002 = g_glab_d[l_ac].glab003
                    
                 SELECT nmaa002 INTO l_nmaa002
                   FROM nmaa_t
                  WHERE nmaaent = g_enterprise
                    AND nmaa001 = l_nmas001  
                 
                 SELECT ooef017 INTO l_ooef017
                   FROM ooef_t
                  WHERE ooefent = g_enterprise
                    AND ooef001 = l_nmaa002
                 
                 #IF cl_null(g_legal) THEN
                 #   SELECT ooef017 INTO g_legal FROM ooef_t
                 #    WHERE ooefent = g_enterprise AND ooef001 = g_site
                 #END IF
                 
                 SELECT COUNT(*) INTO l_n
                   FROM glaa_t
                  WHERE glaaent = g_enterprise
                    AND glaald = g_glab_d[l_ac].glabld
                    #AND glaacomp = g_legal
                    AND glaacomp = l_ooef017
                    
                 IF l_n = 0 THEN 
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = 'agl-00090'
                    LET g_errparam.extend = g_glab_d[l_ac].glabld
                    LET g_errparam.popup = TRUE
                    CALL cl_err()

                    LET g_glab_d[l_ac].glabld = ''
                    NEXT FIELD CURRENT
                 END IF
                 
              ELSE
                 #檢查失敗時後續處理
                 LET g_glab_d[l_ac].glabld = g_glab_d_t.glabld
                 NEXT FIELD CURRENT
              END IF
        
           END IF 
            
            CALL anmi121_glaa004_get(g_glab_d[l_ac].glabld)
               RETURNING l_glaa004
            DISPLAY '' TO s_detail[l_ac].glab005_desc
            
            IF NOT cl_null(g_glab_d[l_ac].glabld) AND NOT cl_null(g_glab_d[l_ac].glab005) THEN 
               IF NOT anmi121_glab005_chk(g_glab_d[l_ac].glabld,g_glab_d[l_ac].glab005) THEN
                  LET g_glab_d[l_ac].glab005 = g_glab_d_t.glab005
                  CALL anmi121_glab005_ref(g_glab_d[l_ac].glabld,g_glab_d[l_ac].glab005)
                     RETURNING g_glab_d[l_ac].glab005_desc
                  DISPLAY g_glab_d[l_ac].glab005_desc TO glab005_desc
                  NEXT FIELD glab005
               END IF 
            END IF
            CALL anmi121_glab005_ref(g_glab_d[l_ac].glabld,g_glab_d[l_ac].glab005)
               RETURNING g_glab_d[l_ac].glab005_desc
            DISPLAY g_glab_d[l_ac].glab005_desc TO glab005_desc
         
         BEFORE FIELD glab005
            IF cl_null(g_glab_d[l_ac].glabld) THEN
               NEXT FIELD glabld
            END IF 
            
         AFTER FIELD glab005
            DISPLAY '' TO s_detail[l_ac].glab005_desc
            IF NOT cl_null(g_glab_d[l_ac].glabld) AND NOT cl_null(g_glab_d[l_ac].glab005) THEN 
            
               # 开窗模糊查询 150916-00015#1 --add                      
               IF s_aglt310_getlike_lc_subject(g_glab_d[l_ac].glabld,g_glab_d[l_ac].glab005,"")  THEN            
                  
                  SELECT glaa004 INTO l_glaa004
                    FROM glaa_t
                   WHERE glaaent = g_enterprise
                     AND glaald  = g_glab_d[l_ac].glabld
                  
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = 'FALSE'
                  LET g_qryparam.default1 = g_glab_d[l_ac].glab005
                                
                  LET g_qryparam.arg1 = l_glaa004
                  LET g_qryparam.arg2 = g_glab_d[l_ac].glab005
                  LET g_qryparam.arg3 = g_glab_d[l_ac].glabld
                  LET g_qryparam.arg4 = " 1"
                  CALL q_glac002_6()
                  LET  g_glab_d[l_ac].glab005 = g_qryparam.return1 
                  DISPLAY g_glab_d[l_ac].glab005 TO glab005
                  CALL anmi121_glab005_ref(g_glab_d[l_ac].glabld,g_glab_d[l_ac].glab005)
                      RETURNING g_glab_d[l_ac].glab005_desc
                  DISPLAY g_glab_d[l_ac].glab005_desc TO glab005_desc                  
               END IF
               #科目存在性，有效性，非统治科目，非子系统科目，账户科目属性检查
               IF NOT  s_aglt310_lc_subject(g_glab_d[l_ac].glabld,g_glab_d[l_ac].glab005,'N') THEN
                  LET g_glab_d[l_ac].glab005 = g_glab_d_t.glab005
                  CALL anmi121_glab005_ref(g_glab_d[l_ac].glabld,g_glab_d[l_ac].glab005)
                     RETURNING g_glab_d[l_ac].glab005_desc
                  DISPLAY g_glab_d[l_ac].glab005_desc TO glab005_desc
                  NEXT FIELD glab005
                  
               END IF
               # 150916-00015#1 --end
            
#               IF NOT anmi121_glab005_chk(g_glab_d[l_ac].glabld,g_glab_d[l_ac].glab005) THEN
#                  LET g_glab_d[l_ac].glab005 = g_glab_d_t.glab005
#                  CALL anmi121_glab005_ref(g_glab_d[l_ac].glabld,g_glab_d[l_ac].glab005)
#                     RETURNING g_glab_d[l_ac].glab005_desc
#                  DISPLAY g_glab_d[l_ac].glab005_desc TO glab005_desc
#                  NEXT FIELD glab005
#               END IF 
            END IF
            CALL anmi121_glab005_ref(g_glab_d[l_ac].glabld,g_glab_d[l_ac].glab005)
               RETURNING g_glab_d[l_ac].glab005_desc
            DISPLAY g_glab_d[l_ac].glab005_desc TO glab005_desc
            
         ON ACTION controlp INFIELD glabld
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glab_d[l_ac].glabld            #給予default值
            #IF cl_null(g_legal) THEN
            #   SELECT ooef017 INTO g_legal FROM ooef_t
            #    WHERE ooefent = g_enterprise AND ooef001 = g_site
            #END IF
            SELECT nmas001 INTO l_nmas001 
              FROM nmas_t
             WHERE nmasent = g_enterprise
               AND nmas002 = g_glab_d[l_ac].glab003
               
            SELECT nmaa002 INTO l_nmaa002
              FROM nmaa_t
             WHERE nmaaent = g_enterprise
               AND nmaa001 = l_nmas001  

            SELECT ooef017 INTO l_ooef017
              FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = l_nmaa002
              
            LET g_qryparam.where = " glaacomp = '",l_ooef017,"'"
            
            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            
            CALL q_authorised_ld()                                #呼叫開窗

            LET g_glab_d[l_ac].glabld = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_glab_d[l_ac].glabld TO glabld
            LET g_qryparam.where = ""
            NEXT FIELD glabld
            
         ON ACTION controlp INFIELD glab005
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glab_d[l_ac].glab005            #給予default值
            LET g_qryparam.where = "glac003 !='1' AND glac001 = '",l_glaa004,"' ",
                                   " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 AND gladld='",g_glab_d[l_ac].glabld,"' AND gladent=",g_enterprise,
                                   " AND gladstus = 'Y' )" #150916-00015#1 add
            CALL aglt310_04()                               #呼叫開窗

            LET g_glab_d[l_ac].glab005 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_qryparam.where = ""
            DISPLAY g_glab_d[l_ac].glab005 TO glab005
            CALL anmi121_glab005_ref(g_glab_d[l_ac].glabld,g_glab_d[l_ac].glab005)
               RETURNING g_glab_d[l_ac].glab005_desc
            DISPLAY g_glab_d[l_ac].glab005_desc TO glab005_desc
            NEXT FIELD glab005
            
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_glab_d[l_ac].* = g_glab_d_t.*
               CLOSE anmi121_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG
            END IF

            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_glab_d[l_ac].glabld
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_glab_d[l_ac].* = g_glab_d_t.*
            ELSE
               CALL anmi121_glaa004_get(g_glab_d[l_ac].glabld)
                  RETURNING l_glaa004
               UPDATE glab_t SET (glab003,glabld,glab004,glab005) = (g_glab_d[l_ac].glab003,g_glab_d[l_ac].glabld,l_glaa004,g_glab_d[l_ac].glab005)
                WHERE glabent = g_enterprise 
                  AND glabld = g_glab_d_t.glabld 
                  AND glab001 = '40'
                  AND glab002 = '40'
                  AND glab003 = g_glab_d_t.glab003
            END IF

         AFTER ROW
            CALL anmi121_unlock_b("glab_t")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            CALL cl_multitable_unlock()

         AFTER INPUT

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


   CLOSE anmi121_bcl
   CALL s_transaction_end('Y','0')
   CALL anmi121_b_refresh()
END FUNCTION

PRIVATE FUNCTION anmi121_b_fill(p_wc2)
   #BODY FILL UP
   DEFINE p_wc2           STRING

   IF cl_null(p_wc2) THEN
      LET p_wc2 = " 1=1"
   END IF

   LET g_sql = "SELECT  UNIQUE glab003,'',glabld,glab005,'' FROM glab_t",
               " WHERE glabent= ? AND glab001 = '40' AND glab002 = '40' ",
               "   AND ", p_wc2
               
   #IF NOT cl_null(g_argv[1]) THEN 
   #   LET g_sql = g_sql, " AND glab003 LIKE '",g_argv[1],"%'"
   #END IF

   LET g_sql = g_sql, " ORDER BY glab_t.glabld"

   PREPARE anmi121_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR anmi121_pb

      OPEN b_fill_curs USING g_enterprise

   CALL g_glab_d.clear()


   LET g_cnt = l_ac
   LET l_ac = 1
   ERROR "Searching!"

   FOREACH b_fill_curs INTO g_glab_d[l_ac].glab003,g_glab_d[l_ac].nmas003,g_glab_d[l_ac].glabld,g_glab_d[l_ac].glab005,g_glab_d[l_ac].glab005_desc
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      CALL anmi121_detail_show()

      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         #CALL cl_err( "", 9035, 0 )
         EXIT FOREACH
      END IF

   END FOREACH



   CALL g_glab_d.deleteElement(g_glab_d.getLength())


   #將key欄位填到每個page
   FOR l_ac = 1 TO g_glab_d.getLength()

   END FOR

   LET g_detail_cnt = l_ac - 1
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   LET l_ac = g_cnt
   LET g_cnt = 0

   CLOSE b_fill_curs
   FREE anmi121_pb

END FUNCTION

PRIVATE FUNCTION anmi121_detail_show()
   CALL anmi121_glab003_ref(g_glab_d[l_ac].glab003)
      RETURNING g_glab_d[l_ac].nmas003
   CALL anmi121_glab005_ref(g_glab_d[l_ac].glabld,g_glab_d[l_ac].glab005)
      RETURNING g_glab_d[l_ac].glab005_desc
END FUNCTION

PRIVATE FUNCTION anmi121_set_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1

END FUNCTION

PRIVATE FUNCTION anmi121_set_no_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1

END FUNCTION

PRIVATE FUNCTION anmi121_default_search()
   IF NOT cl_null(g_argv[1]) THEN
      LET g_wc_def = " nmaa001 = '", g_argv[1], "' "
   ELSE
      LET g_wc_def = " 1=1"
   END IF
   
   #IF NOT cl_null(g_argv[1]) THEN 
   #   CALL cl_set_comp_visible('s_browse,grid2',FALSE)
   #END IF
END FUNCTION

PRIVATE FUNCTION anmi121_delete_b(ps_table,ps_keys_bak,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING

   #判斷是否是同一群組的table
   LET ls_group = "glab_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN


      DELETE FROM glab_t
       WHERE glabent = g_enterprise AND
         glabld = ps_keys_bak[1] AND glab001 = '40' AND glab002 = '40' AND glab003 = ps_keys_bak[4]
         #160122-00001#1--add---str
         AND glab003 IN (SELECT nmll001 FROM nmll_t WHERE nmllent = g_enterprise AND nmll002 = g_user)
         #160122-00001#1--add---end



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

PRIVATE FUNCTION anmi121_insert_b(ps_table,ps_keys,ps_page)
   {<Local define>}
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE l_glaa004   LIKE glaa_t.glaa004

   #判斷是否是同一群組的table

   CALL anmi121_glaa004_get(g_glab_d[l_ac].glabld)
      RETURNING l_glaa004
   INSERT INTO glab_t
                  (glabent,
                   glabld,glab001,glab002,glab003,glab004
                   ,glab005)
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],l_glaa004
                   ,g_glab_d[l_ac].glab005)

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "glab_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF

END FUNCTION

PRIVATE FUNCTION anmi121_lock_b(ps_table)
   DEFINE ps_table STRING
   DEFINE ls_group STRING

   #鎖定整組table

   #僅鎖定自身table
   LET ls_group = "glab_t"

   IF ls_group.getIndexOf(ps_table,1) THEN

      OPEN anmi121_bcl USING g_enterprise,g_glab_d[l_ac].glabld,g_glab_d[l_ac].glab003

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "anmi121_bcl"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF

   END IF
   
   RETURN TRUE

END FUNCTION

PRIVATE FUNCTION anmi121_unlock_b(ps_table)
   DEFINE ps_table STRING

   CLOSE anmi121_bcl
   
END FUNCTION
#+
PRIVATE FUNCTION anmi121_glab005_ref(p_glabld,p_glab005)
   DEFINE p_glabld LIKE glab_t.glabld
   DEFINE p_glab005 LIKE glab_t.glab005
   DEFINE l_glaa004 LIKE glaa_t.glaa004
   DEFINE r_glacl004 LIKE glacl_t.glacl004

   LET r_glacl004  = ''
   LET l_glaa004 = ''
   SELECT glaa004 INTO l_glaa004 FROM glaa_t
    WHERE glaaent = g_enterprise AND glaald = p_glabld
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = l_glaa004
   LET g_ref_fields[2] = p_glab005
   CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"
      ||g_enterprise||"' AND glacl001=? AND glacl002 = ? AND glacl003 = '"||g_dlang||"' ","")
      RETURNING g_rtn_fields
   LET r_glacl004 = g_rtn_fields[1]
   RETURN r_glacl004
END FUNCTION
#+
PRIVATE FUNCTION anmi121_glab003_ref(p_glab003)
   DEFINE p_glab003 LIKE glab_t.glab003
   DEFINE r_nmas003 LIKE nmas_t.nmas003

   LET r_nmas003 = ''
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_glab003
   CALL ap_ref_array2(g_ref_fields,"SELECT nmas003 FROM nmas_t WHERE nmasent='"
      ||g_enterprise||"' AND nmas002=? ","")
      RETURNING g_rtn_fields
   LET r_nmas003 = g_rtn_fields[1]
   RETURN r_nmas003
END FUNCTION
##交易帳戶代碼檢查
PRIVATE FUNCTION anmi121_glab003_chk(p_glab003,p_glab003_t,p_cmd)
   DEFINE p_glab003 LIKE glab_t.glab003
   DEFINE p_glab003_t LIKE glab_t.glab003
   DEFINE p_cmd LIKE type_t.num5
   DEFINE r_success LIKE type_t.num5
   LET r_success = TRUE
   IF NOT cl_null(p_glab003) THEN
      
      #是否存在
      IF r_success THEN
         IF NOT ap_chk_isExist(p_glab003,"SELECT COUNT(*) FROM nmas_t WHERE "
            ||"nmasent = '" ||g_enterprise|| "' AND "||"nmas002 = ? ",'anm-00026',0) THEN
            LET r_success = FALSE
         END IF 
      END IF
      #是否有效
      IF r_success THEN
         IF NOT ap_chk_isExist(p_glab003,"SELECT COUNT(*) FROM nmas_t WHERE "
            ||"nmasent = '" ||g_enterprise|| "' AND "||"nmas002 = ? AND "
            ||"nmas001 IN (SELECT nmaa001 FROM nmaa_t WHERE nmaaent = '"
            ||g_enterprise||"' AND nmaastus = 'Y' )",'sub-01302','anmi120') THEN#160318-00005#25 mod#'anm-00027',0) THEN
            LET r_success = FALSE
         END IF
      END IF
   END IF 
   RETURN r_success
END FUNCTION
##會計科目檢查
PRIVATE FUNCTION anmi121_glab005_chk(p_glabld,p_glab005)
   DEFINE p_glabld LIKE glab_t.glabld
   DEFINE p_glab005 LIKE glab_t.glab005
   DEFINE l_glaa004 LIKE glaa_t.glaa004
   DEFINE r_success LIKE type_t.num5

   LET r_success = TRUE
   IF cl_null(p_glabld) THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = ''
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE 
   END IF 
   IF NOT cl_null(p_glabld) AND NOT cl_null(p_glab005) THEN
      #根據帳別得出會計科目參照表號
      LET l_glaa004 = ''
      SELECT glaa004 INTO l_glaa004 FROM glaa_t
       WHERE glaaent = g_enterprise AND glaald = p_glabld
      IF cl_null(l_glaa004) THEN
         INITIALIZE g_errparam TO NULL
      LET g_errparam.code = ''
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

         LET r_success = FALSE 
      END IF 
      #判斷是否存在
      IF r_success THEN 
         IF NOT ap_chk_isExist(p_glab005,"SELECT COUNT(*) FROM glac_t WHERE "
            ||"glacent = '" ||g_enterprise|| "' AND glac001= '"||l_glaa004||"' AND glac002 = ? ",'agl-00011',0) THEN
            LET r_success = FALSE
         END IF 
      END IF 
      #判斷是否有效
      IF r_success THEN 
         IF NOT ap_chk_isExist(p_glab005,"SELECT COUNT(*) FROM glac_t WHERE "
            ||"glacent = '" ||g_enterprise|| "' AND glac001= '"||l_glaa004||"' AND glac002 = ? AND glacstus = 'Y' ",'sub-01302','agli020') THEN#160318-00005#25 mod  #'agl-00012',0) THEN
            LET r_success = FALSE
         END IF
      END IF
      #判斷是否不為統制科目
      IF r_success THEN 
         IF NOT ap_chk_isExist(p_glab005,"SELECT COUNT(*) FROM glac_t WHERE "
            ||"glacent = '" ||g_enterprise|| "' AND glac001= '"||l_glaa004||"' AND glac002 = ? AND glacstus = 'Y' AND glac003 !='1' ",'agl-00013',0) THEN
            LET r_success = FALSE 
         END IF
      END IF
   END IF 
   RETURN r_success 
END FUNCTION
##帳別檢查
PRIVATE FUNCTION anmi121_glabld_chk(p_glabld)
   DEFINE p_glabld LIKE glab_t.glabld
   DEFINE r_success LIKE type_t.num5
#   DEFINE l_legal  LIKE ooea_t.ooea002                    #161110-00001#1 MARK 
   
#  LET l_legal = g_legal                                   #161110-00001#1 MARK 
   IF cl_null(g_legal) THEN
#      SELECT ooea002 INTO l_legal FROM ooea_t             #161110-00001#1 MARK 
#       WHERE ooeaent = g_enterprise AND ooea001 = g_site  #161110-00001#1 MARK 
   END IF
   LET r_success = TRUE
   IF NOT cl_null(p_glabld) THEN
       
      #是否存在
      IF r_success THEN
         IF NOT ap_chk_isExist(p_glabld,"SELECT COUNT(*) FROM glaa_t WHERE "
            ||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? ",'agl-00016',0) THEN
            LET r_success = FALSE
         END IF 
      END IF 
      #是否為當前法人
      IF r_success THEN
          #161110-00001#1 MARK--S-- 
#         IF NOT ap_chk_isExist(p_glabld,"SELECT COUNT(*) FROM glaa_t WHERE "
#            ||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? AND glaacomp ='"||l_legal||"' ",'agl-00090',0) THEN
#            LET r_success = FALSE 
#         END IF 
          #161110-00001#1 MARK--E--
      END IF
      #是否有效
      IF r_success THEN
         IF NOT ap_chk_isExist(p_glabld,"SELECT COUNT(*) FROM glaa_t WHERE "
            ||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? AND glaastus = 'Y' ",'sub-01302','agli010') THEN#160318-00005#25 mod #'agl-00089',0) THEN
            LET r_success = FALSE 
         END IF
      END IF
   END IF 
   RETURN r_success 
END FUNCTION
#+
PRIVATE FUNCTION anmi121_browser_fill(p_wc,p_type)
   DEFINE p_wc       STRING 
   DEFINE p_type     LIKE type_t.chr10
   
   CALL anmi121_browser_create(p_type)
END FUNCTION
#+
PRIVATE FUNCTION anmi121_key_chk(p_glab003,p_glab003_t,p_glabld,p_glabld_t,p_cmd)
   DEFINE p_glab003 LIKE glab_t.glab003
   DEFINE p_glab003_t LIKE glab_t.glab003
   DEFINE p_glabld LIKE glab_t.glabld
   DEFINE p_glabld_t LIKE glab_t.glabld
   DEFINE p_cmd LIKE type_t.chr5
   DEFINE r_success LIKE type_t.num5
   
   LET r_success = TRUE
   IF NOT cl_null(p_glab003) AND NOT cl_null(p_glabld) THEN
      IF p_cmd = 'a' OR (p_cmd='u' AND (p_cmd = 'u' AND (p_glab003 != p_glab003_t OR p_glabld ! = p_glabld_t))) THEN 
         IF NOT ap_chk_notDup(p_glab003,"SELECT COUNT(*) FROM glab_t WHERE glabent = '"
            ||g_enterprise||"' AND glab003 = '"||p_glab003||"' AND glab001 = '40' AND glab002 = '40' AND glabld ='"
            ||p_glabld||"'",'std-00004',0) THEN 
            LET r_success = FALSE
         END IF
      END IF 
   END IF 
   RETURN r_success 
END FUNCTION

#end add-point
 
{</section>}
 
