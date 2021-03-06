#該程式未解開Section, 採用最新樣板產出!
{<section id="abgt340_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-11-04 10:43:23), PR版次:0001(2016-11-30 14:31:04)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: abgt340_01
#+ Description: 預算調整
#+ Creator....: 02599(2016-11-04 10:28:27)
#+ Modifier...: 02599 -SD/PR- 02599
 
{</section>}
 
{<section id="abgt340_01.global" >}
#應用 c02b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#Memos
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_bgcj_d        RECORD
       bgcj001 LIKE bgcj_t.bgcj001, 
   bgcj002 LIKE bgcj_t.bgcj002, 
   bgcj002_desc LIKE type_t.chr500, 
   bgcj003 LIKE bgcj_t.bgcj003, 
   bgcj004 LIKE bgcj_t.bgcj004, 
   bgcj004_desc LIKE type_t.chr500, 
   bgcj005 LIKE bgcj_t.bgcj005, 
   bgcj006 LIKE bgcj_t.bgcj006, 
   bgcj007 LIKE bgcj_t.bgcj007, 
   bgcj007_desc LIKE type_t.chr500, 
   bgcj009 LIKE bgcj_t.bgcj009, 
   bgcj010 LIKE bgcj_t.bgcj010, 
   bgcjseq LIKE bgcj_t.bgcjseq, 
   bgcj008 LIKE bgcj_t.bgcj008, 
   content LIKE type_t.chr500, 
   num1 LIKE type_t.num20_6, 
   price1 LIKE type_t.num20_6, 
   amt1 LIKE type_t.num20_6, 
   num2 LIKE type_t.num20_6, 
   price2 LIKE type_t.num20_6, 
   amt2 LIKE type_t.num20_6, 
   num3 LIKE type_t.num20_6, 
   price3 LIKE type_t.num20_6, 
   amt3 LIKE type_t.num20_6, 
   num4 LIKE type_t.num20_6, 
   price4 LIKE type_t.num20_6, 
   amt4 LIKE type_t.num20_6, 
   num5 LIKE type_t.num20_6, 
   price5 LIKE type_t.num20_6, 
   amt5 LIKE type_t.num20_6, 
   num6 LIKE type_t.num20_6, 
   price6 LIKE type_t.num20_6, 
   amt6 LIKE type_t.num20_6, 
   num7 LIKE type_t.num20_6, 
   price7 LIKE type_t.num20_6, 
   amt7 LIKE type_t.num20_6, 
   num8 LIKE type_t.num20_6, 
   price8 LIKE type_t.num20_6, 
   amt8 LIKE type_t.num20_6, 
   num9 LIKE type_t.num20_6, 
   price9 LIKE type_t.num20_6, 
   amt9 LIKE type_t.num20_6, 
   num10 LIKE type_t.num20_6, 
   price10 LIKE type_t.num20_6, 
   amt10 LIKE type_t.num20_6, 
   num11 LIKE type_t.num20_6, 
   price11 LIKE type_t.num20_6, 
   amt11 LIKE type_t.num20_6, 
   num12 LIKE type_t.num20_6, 
   price12 LIKE type_t.num20_6, 
   amt12 LIKE type_t.num20_6, 
   num13 LIKE type_t.num20_6, 
   price13 LIKE type_t.num20_6, 
   amt13 LIKE type_t.num20_6, 
   sum LIKE type_t.num20_6
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_max_period         LIKE type_t.num5
DEFINE g_type               LIKE type_t.num5    #1.本层调整，2.上层调整
DEFINE g_curr_diag          ui.Dialog 
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_temp_idx           LIKE type_t.num10             #單身 所在筆數(暫存用)
DEFINE g_detail_cnt         LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_aw                 STRING                        #確定當下點擊的單身
DEFINE g_bgcj100            LIKE bgcj_t.bgcj100
#end add-point
 
DEFINE g_bgcj_d          DYNAMIC ARRAY OF type_g_bgcj_d
DEFINE g_bgcj_d_t        type_g_bgcj_d
 
 
DEFINE g_bgcj001_t   LIKE bgcj_t.bgcj001    #Key值備份
DEFINE g_bgcj002_t      LIKE bgcj_t.bgcj002    #Key值備份
DEFINE g_bgcj003_t      LIKE bgcj_t.bgcj003    #Key值備份
DEFINE g_bgcj004_t      LIKE bgcj_t.bgcj004    #Key值備份
DEFINE g_bgcj005_t      LIKE bgcj_t.bgcj005    #Key值備份
DEFINE g_bgcj006_t      LIKE bgcj_t.bgcj006    #Key值備份
DEFINE g_bgcj007_t      LIKE bgcj_t.bgcj007    #Key值備份
DEFINE g_bgcj008_t      LIKE bgcj_t.bgcj008    #Key值備份
DEFINE g_bgcj009_t      LIKE bgcj_t.bgcj009    #Key值備份
DEFINE g_bgcj010_t      LIKE bgcj_t.bgcj010    #Key值備份
DEFINE g_bgcjseq_t      LIKE bgcj_t.bgcjseq    #Key值備份
 
 
DEFINE l_ac                  LIKE type_t.num10
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rec_b               LIKE type_t.num10 
DEFINE g_detail_idx          LIKE type_t.num10
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
    
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point    
 
{</section>}
 
{<section id="abgt340_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION abgt340_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_bgcj001,p_bgcj002,p_bgcj003,p_bgcj004,p_bgcj005,p_bgcj006,p_bgcj007,p_bgcj009,p_bgcj010,p_bgcjseq,p_type
   #end add-point
   )
   #add-point:input段define name="input.define_customerization"
   
   #end add-point
   DEFINE l_ac_t          LIKE type_t.num10       #未取消的ARRAY CNT 
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num10
   DEFINE l_insert        LIKE type_t.num5
   DEFINE l_cmd           LIKE type_t.chr5
   #add-point:input段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   DEFINE p_bgcj001               LIKE bgcj_t.bgcj001
   DEFINE p_bgcj002               LIKE bgcj_t.bgcj002
   DEFINE p_bgcj003               LIKE bgcj_t.bgcj003
   DEFINE p_bgcj004               LIKE bgcj_t.bgcj004
   DEFINE p_bgcj005               LIKE bgcj_t.bgcj005
   DEFINE p_bgcj006               LIKE bgcj_t.bgcj006
   DEFINE p_bgcj007               LIKE bgcj_t.bgcj007
   DEFINE p_bgcj009               LIKE bgcj_t.bgcj009
   DEFINE p_bgcj010               LIKE bgcj_t.bgcj010
   DEFINE p_bgcjseq               LIKE bgcj_t.bgcjseq
   DEFINE p_type                  LIKE type_t.num5    #1.本层调整，2.上层调整
   DEFINE l_bgaa002               LIKE bgaa_t.bgaa002
   DEFINE l_bgaa003               LIKE bgaa_t.bgaa003
   DEFINE l_bgcjstus              LIKE bgcj_t.bgcjstus
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_abgt340_01 WITH FORM cl_ap_formpath("abg","abgt340_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單身前置處理 name="input.pre_input"
   LET g_bgcj001_t = p_bgcj001 
   LET g_bgcj002_t = p_bgcj002 
   LET g_bgcj003_t = p_bgcj003 
   LET g_bgcj004_t = p_bgcj004 
   LET g_bgcj005_t = p_bgcj005 
   LET g_bgcj006_t = p_bgcj006 
   LET g_bgcj007_t = p_bgcj007 
   LET g_bgcj009_t = p_bgcj009 
   LET g_bgcj010_t = p_bgcj010 
   LET g_bgcjseq_t = p_bgcjseq 
   LET g_type = p_type
   #抓取預算週期和預算期別
   CALL s_abgt340_sel_bgaa(g_bgcj002_t) RETURNING l_bgaa002,l_bgaa003,g_max_period
   
   #填充单身
   CALL abgt340_01_b_fill()
   
   #状态码
   #期别销售预算
   IF g_prog = 'abgt340' OR g_prog = 'abgt350' THEN
      SELECT DISTINCT bgcjstus,bgcj100 
        INTO l_bgcjstus,g_bgcj100 
        FROM bgcj_t
       WHERE bgcjent=g_enterprise AND bgcj001=g_bgcj001_t
         AND bgcj002=g_bgcj002_t  AND bgcj003=g_bgcj003_t
         AND bgcj004=g_bgcj004_t  AND bgcj005=g_bgcj005_t
         AND bgcj006=g_bgcj006_t  AND bgcj007=g_bgcj007_t
         AND bgcj009=g_bgcj009_t  AND bgcj010=g_bgcj010_t
         AND bgcjseq=g_bgcjseq_t
   END IF
   #期别采购预算
   IF g_prog = 'abgt510' OR g_prog = 'abgt520' THEN
      SELECT DISTINCT bgegstus,bgeg100 
        INTO l_bgcjstus,g_bgcj100 
        FROM bgeg_t
       WHERE bgegent=g_enterprise AND bgeg001=g_bgcj001_t
         AND bgeg002=g_bgcj002_t  AND bgeg003=g_bgcj003_t
         AND bgeg004=g_bgcj004_t  AND bgeg005=g_bgcj005_t
         AND bgeg006=g_bgcj006_t  AND bgeg007=g_bgcj007_t
         AND bgeg009=g_bgcj009_t  AND bgeg010=g_bgcj010_t
         AND bgegseq=g_bgcjseq_t
   END IF
   #期别费用预算
   IF g_prog = 'abgt620' OR g_prog = 'abgt630' THEN
      SELECT DISTINCT bgfbstus,bgfb100 
        INTO l_bgcjstus,g_bgcj100 
        FROM bgfb_t
       WHERE bgfbent=g_enterprise AND bgfb001=g_bgcj001_t
         AND bgfb002=g_bgcj002_t  AND bgfb003=g_bgcj003_t
         AND bgfb004=g_bgcj004_t  AND bgfb005=g_bgcj005_t
         AND bgfb006=g_bgcj006_t  AND bgfb007=g_bgcj007_t
         AND bgfb009=g_bgcj009_t  AND bgfb010=g_bgcj010_t
         AND bgfbseq=g_bgcjseq_t
      #费用预算没有数量、单价，影藏
      CALL cl_set_comp_visible("num1,price1,num2,price2,num3,price3,num4,price4,num5,price5,num6,price6,num7,price7,num8,price8,num9,price9,num10,price10,num11,price11,num12,price12,num13,price13",FALSE)
      CALL cl_set_comp_entry("amt1,amt2,amt3,amt4,amt5,amt6,amt7,amt8,amt9,amt10,amt11,amt12,amt13",TRUE)
   END IF
      
   #當期別不為13期時，影藏13期的數量、單價、銷售金額欄位
   IF g_max_period < 13 THEN
      CALL cl_set_comp_visible("num13,price13,amt13",FALSE)
   ELSE
      CALL cl_set_comp_visible("num13,price13,amt13",TRUE)
   END IF
   
   #為了abgt350可以公共該子作業，重寫
   LET g_action_choice = " "  
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()      
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   LET g_detail_idx = 1
   
   WHILE TRUE
     
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_bgcj_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               #讓各頁籤能夠同步指到特定資料
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               
            BEFORE ROW
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL g_curr_diag.setSelectionMode("s_detail1",1)
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               LET g_temp_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL cl_show_fld_cont() 
               CALL cl_user_overview_set_follow_pic()               
         END DISPLAY
      
         BEFORE DIALOG
            IF g_temp_idx > 0 THEN
               LET l_ac = g_temp_idx
               CALL DIALOG.setCurrentRow("s_detail1",l_ac)
               LET g_temp_idx = 1
            END IF
            LET g_curr_diag = ui.DIALOG.getCurrent()         
            CALL DIALOG.setSelectionMode("s_detail1", 1)
 
            #当状态不为审核Y时，調整資訊,只顯示不可修改
            IF l_bgcjstus <> 'Y' THEN
               CALL cl_set_act_visible("modify,modify_detail",FALSE)
            ELSE
               CALL cl_set_act_visible("modify,modify_detail",TRUE)
            END IF   
            NEXT FIELD CURRENT
      
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL abgt340_01_modify()
               
            END IF
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL abgt340_01_modify()
               
            END IF
 
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_bgcj_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"

               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
            
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice="exit"
            CANCEL DIALOG
      
         ON ACTION exit
            LET g_action_choice="exit"
            CANCEL DIALOG
            
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL abgt340_01_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"

               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL abgt340_01_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"

            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL abgt340_01_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"

            #END add-point
            CALL cl_user_overview_follow('')
         
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
      
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         #add-point:ui_dialog段離開dialog前 name="ui_dialog.b_exit"

         #end add-point
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
   
   IF 1=2 THEN
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT ARRAY g_bgcj_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
         
         #自訂ACTION
         #add-point:單身前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(detail_input)
         
         
         BEFORE INPUT
            #add-point:單身輸入前處理 name="input.before_input"
                        
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj001
            #add-point:BEFORE FIELD bgcj001 name="input.b.page1.bgcj001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj001
            
            #add-point:AFTER FIELD bgcj001 name="input.a.page1.bgcj001"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_bgcj_d[g_detail_idx].bgcj001 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj002 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj003 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj004 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj005 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj006 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj007 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj008 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj009 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj010 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcjseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_bgcj_d[g_detail_idx].bgcj001 != g_bgcj_d_t.bgcj001 OR g_bgcj_d[g_detail_idx].bgcj002 != g_bgcj_d_t.bgcj002 OR g_bgcj_d[g_detail_idx].bgcj003 != g_bgcj_d_t.bgcj003 OR g_bgcj_d[g_detail_idx].bgcj004 != g_bgcj_d_t.bgcj004 OR g_bgcj_d[g_detail_idx].bgcj005 != g_bgcj_d_t.bgcj005 OR g_bgcj_d[g_detail_idx].bgcj006 != g_bgcj_d_t.bgcj006 OR g_bgcj_d[g_detail_idx].bgcj007 != g_bgcj_d_t.bgcj007 OR g_bgcj_d[g_detail_idx].bgcj008 != g_bgcj_d_t.bgcj008 OR g_bgcj_d[g_detail_idx].bgcj009 != g_bgcj_d_t.bgcj009 OR g_bgcj_d[g_detail_idx].bgcj010 != g_bgcj_d_t.bgcj010 OR g_bgcj_d[g_detail_idx].bgcjseq != g_bgcj_d_t.bgcjseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bgcj_t WHERE "||"bgcjent = " ||g_enterprise|| " AND "||"bgcj001 = '"||g_bgcj_d[g_detail_idx].bgcj001 ||"' AND "|| "bgcj002 = '"||g_bgcj_d[g_detail_idx].bgcj002 ||"' AND "|| "bgcj003 = '"||g_bgcj_d[g_detail_idx].bgcj003 ||"' AND "|| "bgcj004 = '"||g_bgcj_d[g_detail_idx].bgcj004 ||"' AND "|| "bgcj005 = '"||g_bgcj_d[g_detail_idx].bgcj005 ||"' AND "|| "bgcj006 = '"||g_bgcj_d[g_detail_idx].bgcj006 ||"' AND "|| "bgcj007 = '"||g_bgcj_d[g_detail_idx].bgcj007 ||"' AND "|| "bgcj008 = '"||g_bgcj_d[g_detail_idx].bgcj008 ||"' AND "|| "bgcj009 = '"||g_bgcj_d[g_detail_idx].bgcj009 ||"' AND "|| "bgcj010 = '"||g_bgcj_d[g_detail_idx].bgcj010 ||"' AND "|| "bgcjseq = '"||g_bgcj_d[g_detail_idx].bgcjseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj001
            #add-point:ON CHANGE bgcj001 name="input.g.page1.bgcj001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj002
            
            #add-point:AFTER FIELD bgcj002 name="input.a.page1.bgcj002"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_bgcj_d[g_detail_idx].bgcj001 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj002 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj003 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj004 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj005 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj006 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj007 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj008 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj009 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj010 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcjseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_bgcj_d[g_detail_idx].bgcj001 != g_bgcj_d_t.bgcj001 OR g_bgcj_d[g_detail_idx].bgcj002 != g_bgcj_d_t.bgcj002 OR g_bgcj_d[g_detail_idx].bgcj003 != g_bgcj_d_t.bgcj003 OR g_bgcj_d[g_detail_idx].bgcj004 != g_bgcj_d_t.bgcj004 OR g_bgcj_d[g_detail_idx].bgcj005 != g_bgcj_d_t.bgcj005 OR g_bgcj_d[g_detail_idx].bgcj006 != g_bgcj_d_t.bgcj006 OR g_bgcj_d[g_detail_idx].bgcj007 != g_bgcj_d_t.bgcj007 OR g_bgcj_d[g_detail_idx].bgcj008 != g_bgcj_d_t.bgcj008 OR g_bgcj_d[g_detail_idx].bgcj009 != g_bgcj_d_t.bgcj009 OR g_bgcj_d[g_detail_idx].bgcj010 != g_bgcj_d_t.bgcj010 OR g_bgcj_d[g_detail_idx].bgcjseq != g_bgcj_d_t.bgcjseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bgcj_t WHERE "||"bgcjent = " ||g_enterprise|| " AND "||"bgcj001 = '"||g_bgcj_d[g_detail_idx].bgcj001 ||"' AND "|| "bgcj002 = '"||g_bgcj_d[g_detail_idx].bgcj002 ||"' AND "|| "bgcj003 = '"||g_bgcj_d[g_detail_idx].bgcj003 ||"' AND "|| "bgcj004 = '"||g_bgcj_d[g_detail_idx].bgcj004 ||"' AND "|| "bgcj005 = '"||g_bgcj_d[g_detail_idx].bgcj005 ||"' AND "|| "bgcj006 = '"||g_bgcj_d[g_detail_idx].bgcj006 ||"' AND "|| "bgcj007 = '"||g_bgcj_d[g_detail_idx].bgcj007 ||"' AND "|| "bgcj008 = '"||g_bgcj_d[g_detail_idx].bgcj008 ||"' AND "|| "bgcj009 = '"||g_bgcj_d[g_detail_idx].bgcj009 ||"' AND "|| "bgcj010 = '"||g_bgcj_d[g_detail_idx].bgcj010 ||"' AND "|| "bgcjseq = '"||g_bgcj_d[g_detail_idx].bgcjseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            IF NOT cl_null(g_bgcj_d[l_ac].bgcj002) THEN 
#應用 a17 樣板自動產生(Version:3)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
 
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_bgcj_d[l_ac].bgcj002

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_bgaa001") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
 


            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bgcj_d[l_ac].bgcj002
            CALL ap_ref_array2(g_ref_fields,"SELECT bgaal003 FROM bgaal_t WHERE bgaalent="||g_enterprise||" AND bgaal001=? AND bgaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bgcj_d[l_ac].bgcj002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bgcj_d[l_ac].bgcj002_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj002
            #add-point:BEFORE FIELD bgcj002 name="input.b.page1.bgcj002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj002
            #add-point:ON CHANGE bgcj002 name="input.g.page1.bgcj002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj003
            #add-point:BEFORE FIELD bgcj003 name="input.b.page1.bgcj003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj003
            
            #add-point:AFTER FIELD bgcj003 name="input.a.page1.bgcj003"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_bgcj_d[g_detail_idx].bgcj001 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj002 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj003 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj004 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj005 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj006 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj007 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj008 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj009 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj010 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcjseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_bgcj_d[g_detail_idx].bgcj001 != g_bgcj_d_t.bgcj001 OR g_bgcj_d[g_detail_idx].bgcj002 != g_bgcj_d_t.bgcj002 OR g_bgcj_d[g_detail_idx].bgcj003 != g_bgcj_d_t.bgcj003 OR g_bgcj_d[g_detail_idx].bgcj004 != g_bgcj_d_t.bgcj004 OR g_bgcj_d[g_detail_idx].bgcj005 != g_bgcj_d_t.bgcj005 OR g_bgcj_d[g_detail_idx].bgcj006 != g_bgcj_d_t.bgcj006 OR g_bgcj_d[g_detail_idx].bgcj007 != g_bgcj_d_t.bgcj007 OR g_bgcj_d[g_detail_idx].bgcj008 != g_bgcj_d_t.bgcj008 OR g_bgcj_d[g_detail_idx].bgcj009 != g_bgcj_d_t.bgcj009 OR g_bgcj_d[g_detail_idx].bgcj010 != g_bgcj_d_t.bgcj010 OR g_bgcj_d[g_detail_idx].bgcjseq != g_bgcj_d_t.bgcjseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bgcj_t WHERE "||"bgcjent = " ||g_enterprise|| " AND "||"bgcj001 = '"||g_bgcj_d[g_detail_idx].bgcj001 ||"' AND "|| "bgcj002 = '"||g_bgcj_d[g_detail_idx].bgcj002 ||"' AND "|| "bgcj003 = '"||g_bgcj_d[g_detail_idx].bgcj003 ||"' AND "|| "bgcj004 = '"||g_bgcj_d[g_detail_idx].bgcj004 ||"' AND "|| "bgcj005 = '"||g_bgcj_d[g_detail_idx].bgcj005 ||"' AND "|| "bgcj006 = '"||g_bgcj_d[g_detail_idx].bgcj006 ||"' AND "|| "bgcj007 = '"||g_bgcj_d[g_detail_idx].bgcj007 ||"' AND "|| "bgcj008 = '"||g_bgcj_d[g_detail_idx].bgcj008 ||"' AND "|| "bgcj009 = '"||g_bgcj_d[g_detail_idx].bgcj009 ||"' AND "|| "bgcj010 = '"||g_bgcj_d[g_detail_idx].bgcj010 ||"' AND "|| "bgcjseq = '"||g_bgcj_d[g_detail_idx].bgcjseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj003
            #add-point:ON CHANGE bgcj003 name="input.g.page1.bgcj003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj004
            
            #add-point:AFTER FIELD bgcj004 name="input.a.page1.bgcj004"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_bgcj_d[g_detail_idx].bgcj001 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj002 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj003 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj004 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj005 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj006 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj007 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj008 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj009 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj010 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcjseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_bgcj_d[g_detail_idx].bgcj001 != g_bgcj_d_t.bgcj001 OR g_bgcj_d[g_detail_idx].bgcj002 != g_bgcj_d_t.bgcj002 OR g_bgcj_d[g_detail_idx].bgcj003 != g_bgcj_d_t.bgcj003 OR g_bgcj_d[g_detail_idx].bgcj004 != g_bgcj_d_t.bgcj004 OR g_bgcj_d[g_detail_idx].bgcj005 != g_bgcj_d_t.bgcj005 OR g_bgcj_d[g_detail_idx].bgcj006 != g_bgcj_d_t.bgcj006 OR g_bgcj_d[g_detail_idx].bgcj007 != g_bgcj_d_t.bgcj007 OR g_bgcj_d[g_detail_idx].bgcj008 != g_bgcj_d_t.bgcj008 OR g_bgcj_d[g_detail_idx].bgcj009 != g_bgcj_d_t.bgcj009 OR g_bgcj_d[g_detail_idx].bgcj010 != g_bgcj_d_t.bgcj010 OR g_bgcj_d[g_detail_idx].bgcjseq != g_bgcj_d_t.bgcjseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bgcj_t WHERE "||"bgcjent = " ||g_enterprise|| " AND "||"bgcj001 = '"||g_bgcj_d[g_detail_idx].bgcj001 ||"' AND "|| "bgcj002 = '"||g_bgcj_d[g_detail_idx].bgcj002 ||"' AND "|| "bgcj003 = '"||g_bgcj_d[g_detail_idx].bgcj003 ||"' AND "|| "bgcj004 = '"||g_bgcj_d[g_detail_idx].bgcj004 ||"' AND "|| "bgcj005 = '"||g_bgcj_d[g_detail_idx].bgcj005 ||"' AND "|| "bgcj006 = '"||g_bgcj_d[g_detail_idx].bgcj006 ||"' AND "|| "bgcj007 = '"||g_bgcj_d[g_detail_idx].bgcj007 ||"' AND "|| "bgcj008 = '"||g_bgcj_d[g_detail_idx].bgcj008 ||"' AND "|| "bgcj009 = '"||g_bgcj_d[g_detail_idx].bgcj009 ||"' AND "|| "bgcj010 = '"||g_bgcj_d[g_detail_idx].bgcj010 ||"' AND "|| "bgcjseq = '"||g_bgcj_d[g_detail_idx].bgcjseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bgcj_d[l_ac].bgcj002
            LET g_ref_fields[2] = g_bgcj_d[l_ac].bgcj004
            CALL ap_ref_array2(g_ref_fields,"SELECT bgail004 FROM bgail_t WHERE bgailent="||g_enterprise||" AND bgail001=? AND bgail002=? AND bgail003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bgcj_d[l_ac].bgcj004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bgcj_d[l_ac].bgcj004_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj004
            #add-point:BEFORE FIELD bgcj004 name="input.b.page1.bgcj004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj004
            #add-point:ON CHANGE bgcj004 name="input.g.page1.bgcj004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj005
            #add-point:BEFORE FIELD bgcj005 name="input.b.page1.bgcj005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj005
            
            #add-point:AFTER FIELD bgcj005 name="input.a.page1.bgcj005"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_bgcj_d[g_detail_idx].bgcj001 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj002 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj003 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj004 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj005 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj006 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj007 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj008 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj009 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj010 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcjseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_bgcj_d[g_detail_idx].bgcj001 != g_bgcj_d_t.bgcj001 OR g_bgcj_d[g_detail_idx].bgcj002 != g_bgcj_d_t.bgcj002 OR g_bgcj_d[g_detail_idx].bgcj003 != g_bgcj_d_t.bgcj003 OR g_bgcj_d[g_detail_idx].bgcj004 != g_bgcj_d_t.bgcj004 OR g_bgcj_d[g_detail_idx].bgcj005 != g_bgcj_d_t.bgcj005 OR g_bgcj_d[g_detail_idx].bgcj006 != g_bgcj_d_t.bgcj006 OR g_bgcj_d[g_detail_idx].bgcj007 != g_bgcj_d_t.bgcj007 OR g_bgcj_d[g_detail_idx].bgcj008 != g_bgcj_d_t.bgcj008 OR g_bgcj_d[g_detail_idx].bgcj009 != g_bgcj_d_t.bgcj009 OR g_bgcj_d[g_detail_idx].bgcj010 != g_bgcj_d_t.bgcj010 OR g_bgcj_d[g_detail_idx].bgcjseq != g_bgcj_d_t.bgcjseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bgcj_t WHERE "||"bgcjent = " ||g_enterprise|| " AND "||"bgcj001 = '"||g_bgcj_d[g_detail_idx].bgcj001 ||"' AND "|| "bgcj002 = '"||g_bgcj_d[g_detail_idx].bgcj002 ||"' AND "|| "bgcj003 = '"||g_bgcj_d[g_detail_idx].bgcj003 ||"' AND "|| "bgcj004 = '"||g_bgcj_d[g_detail_idx].bgcj004 ||"' AND "|| "bgcj005 = '"||g_bgcj_d[g_detail_idx].bgcj005 ||"' AND "|| "bgcj006 = '"||g_bgcj_d[g_detail_idx].bgcj006 ||"' AND "|| "bgcj007 = '"||g_bgcj_d[g_detail_idx].bgcj007 ||"' AND "|| "bgcj008 = '"||g_bgcj_d[g_detail_idx].bgcj008 ||"' AND "|| "bgcj009 = '"||g_bgcj_d[g_detail_idx].bgcj009 ||"' AND "|| "bgcj010 = '"||g_bgcj_d[g_detail_idx].bgcj010 ||"' AND "|| "bgcjseq = '"||g_bgcj_d[g_detail_idx].bgcjseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj005
            #add-point:ON CHANGE bgcj005 name="input.g.page1.bgcj005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj006
            #add-point:BEFORE FIELD bgcj006 name="input.b.page1.bgcj006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj006
            
            #add-point:AFTER FIELD bgcj006 name="input.a.page1.bgcj006"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_bgcj_d[g_detail_idx].bgcj001 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj002 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj003 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj004 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj005 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj006 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj007 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj008 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj009 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj010 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcjseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_bgcj_d[g_detail_idx].bgcj001 != g_bgcj_d_t.bgcj001 OR g_bgcj_d[g_detail_idx].bgcj002 != g_bgcj_d_t.bgcj002 OR g_bgcj_d[g_detail_idx].bgcj003 != g_bgcj_d_t.bgcj003 OR g_bgcj_d[g_detail_idx].bgcj004 != g_bgcj_d_t.bgcj004 OR g_bgcj_d[g_detail_idx].bgcj005 != g_bgcj_d_t.bgcj005 OR g_bgcj_d[g_detail_idx].bgcj006 != g_bgcj_d_t.bgcj006 OR g_bgcj_d[g_detail_idx].bgcj007 != g_bgcj_d_t.bgcj007 OR g_bgcj_d[g_detail_idx].bgcj008 != g_bgcj_d_t.bgcj008 OR g_bgcj_d[g_detail_idx].bgcj009 != g_bgcj_d_t.bgcj009 OR g_bgcj_d[g_detail_idx].bgcj010 != g_bgcj_d_t.bgcj010 OR g_bgcj_d[g_detail_idx].bgcjseq != g_bgcj_d_t.bgcjseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bgcj_t WHERE "||"bgcjent = " ||g_enterprise|| " AND "||"bgcj001 = '"||g_bgcj_d[g_detail_idx].bgcj001 ||"' AND "|| "bgcj002 = '"||g_bgcj_d[g_detail_idx].bgcj002 ||"' AND "|| "bgcj003 = '"||g_bgcj_d[g_detail_idx].bgcj003 ||"' AND "|| "bgcj004 = '"||g_bgcj_d[g_detail_idx].bgcj004 ||"' AND "|| "bgcj005 = '"||g_bgcj_d[g_detail_idx].bgcj005 ||"' AND "|| "bgcj006 = '"||g_bgcj_d[g_detail_idx].bgcj006 ||"' AND "|| "bgcj007 = '"||g_bgcj_d[g_detail_idx].bgcj007 ||"' AND "|| "bgcj008 = '"||g_bgcj_d[g_detail_idx].bgcj008 ||"' AND "|| "bgcj009 = '"||g_bgcj_d[g_detail_idx].bgcj009 ||"' AND "|| "bgcj010 = '"||g_bgcj_d[g_detail_idx].bgcj010 ||"' AND "|| "bgcjseq = '"||g_bgcj_d[g_detail_idx].bgcjseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj006
            #add-point:ON CHANGE bgcj006 name="input.g.page1.bgcj006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj007
            
            #add-point:AFTER FIELD bgcj007 name="input.a.page1.bgcj007"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_bgcj_d[g_detail_idx].bgcj001 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj002 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj003 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj004 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj005 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj006 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj007 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj008 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj009 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj010 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcjseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_bgcj_d[g_detail_idx].bgcj001 != g_bgcj_d_t.bgcj001 OR g_bgcj_d[g_detail_idx].bgcj002 != g_bgcj_d_t.bgcj002 OR g_bgcj_d[g_detail_idx].bgcj003 != g_bgcj_d_t.bgcj003 OR g_bgcj_d[g_detail_idx].bgcj004 != g_bgcj_d_t.bgcj004 OR g_bgcj_d[g_detail_idx].bgcj005 != g_bgcj_d_t.bgcj005 OR g_bgcj_d[g_detail_idx].bgcj006 != g_bgcj_d_t.bgcj006 OR g_bgcj_d[g_detail_idx].bgcj007 != g_bgcj_d_t.bgcj007 OR g_bgcj_d[g_detail_idx].bgcj008 != g_bgcj_d_t.bgcj008 OR g_bgcj_d[g_detail_idx].bgcj009 != g_bgcj_d_t.bgcj009 OR g_bgcj_d[g_detail_idx].bgcj010 != g_bgcj_d_t.bgcj010 OR g_bgcj_d[g_detail_idx].bgcjseq != g_bgcj_d_t.bgcjseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bgcj_t WHERE "||"bgcjent = " ||g_enterprise|| " AND "||"bgcj001 = '"||g_bgcj_d[g_detail_idx].bgcj001 ||"' AND "|| "bgcj002 = '"||g_bgcj_d[g_detail_idx].bgcj002 ||"' AND "|| "bgcj003 = '"||g_bgcj_d[g_detail_idx].bgcj003 ||"' AND "|| "bgcj004 = '"||g_bgcj_d[g_detail_idx].bgcj004 ||"' AND "|| "bgcj005 = '"||g_bgcj_d[g_detail_idx].bgcj005 ||"' AND "|| "bgcj006 = '"||g_bgcj_d[g_detail_idx].bgcj006 ||"' AND "|| "bgcj007 = '"||g_bgcj_d[g_detail_idx].bgcj007 ||"' AND "|| "bgcj008 = '"||g_bgcj_d[g_detail_idx].bgcj008 ||"' AND "|| "bgcj009 = '"||g_bgcj_d[g_detail_idx].bgcj009 ||"' AND "|| "bgcj010 = '"||g_bgcj_d[g_detail_idx].bgcj010 ||"' AND "|| "bgcjseq = '"||g_bgcj_d[g_detail_idx].bgcjseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bgcj_d[l_ac].bgcj007
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent="||g_enterprise||" AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bgcj_d[l_ac].bgcj007_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bgcj_d[l_ac].bgcj007_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj007
            #add-point:BEFORE FIELD bgcj007 name="input.b.page1.bgcj007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj007
            #add-point:ON CHANGE bgcj007 name="input.g.page1.bgcj007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj009
            #add-point:BEFORE FIELD bgcj009 name="input.b.page1.bgcj009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj009
            
            #add-point:AFTER FIELD bgcj009 name="input.a.page1.bgcj009"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_bgcj_d[g_detail_idx].bgcj001 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj002 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj003 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj004 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj005 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj006 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj007 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj008 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj009 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj010 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcjseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_bgcj_d[g_detail_idx].bgcj001 != g_bgcj_d_t.bgcj001 OR g_bgcj_d[g_detail_idx].bgcj002 != g_bgcj_d_t.bgcj002 OR g_bgcj_d[g_detail_idx].bgcj003 != g_bgcj_d_t.bgcj003 OR g_bgcj_d[g_detail_idx].bgcj004 != g_bgcj_d_t.bgcj004 OR g_bgcj_d[g_detail_idx].bgcj005 != g_bgcj_d_t.bgcj005 OR g_bgcj_d[g_detail_idx].bgcj006 != g_bgcj_d_t.bgcj006 OR g_bgcj_d[g_detail_idx].bgcj007 != g_bgcj_d_t.bgcj007 OR g_bgcj_d[g_detail_idx].bgcj008 != g_bgcj_d_t.bgcj008 OR g_bgcj_d[g_detail_idx].bgcj009 != g_bgcj_d_t.bgcj009 OR g_bgcj_d[g_detail_idx].bgcj010 != g_bgcj_d_t.bgcj010 OR g_bgcj_d[g_detail_idx].bgcjseq != g_bgcj_d_t.bgcjseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bgcj_t WHERE "||"bgcjent = " ||g_enterprise|| " AND "||"bgcj001 = '"||g_bgcj_d[g_detail_idx].bgcj001 ||"' AND "|| "bgcj002 = '"||g_bgcj_d[g_detail_idx].bgcj002 ||"' AND "|| "bgcj003 = '"||g_bgcj_d[g_detail_idx].bgcj003 ||"' AND "|| "bgcj004 = '"||g_bgcj_d[g_detail_idx].bgcj004 ||"' AND "|| "bgcj005 = '"||g_bgcj_d[g_detail_idx].bgcj005 ||"' AND "|| "bgcj006 = '"||g_bgcj_d[g_detail_idx].bgcj006 ||"' AND "|| "bgcj007 = '"||g_bgcj_d[g_detail_idx].bgcj007 ||"' AND "|| "bgcj008 = '"||g_bgcj_d[g_detail_idx].bgcj008 ||"' AND "|| "bgcj009 = '"||g_bgcj_d[g_detail_idx].bgcj009 ||"' AND "|| "bgcj010 = '"||g_bgcj_d[g_detail_idx].bgcj010 ||"' AND "|| "bgcjseq = '"||g_bgcj_d[g_detail_idx].bgcjseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj009
            #add-point:ON CHANGE bgcj009 name="input.g.page1.bgcj009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj010
            #add-point:BEFORE FIELD bgcj010 name="input.b.page1.bgcj010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj010
            
            #add-point:AFTER FIELD bgcj010 name="input.a.page1.bgcj010"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_bgcj_d[g_detail_idx].bgcj001 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj002 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj003 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj004 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj005 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj006 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj007 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj008 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj009 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj010 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcjseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_bgcj_d[g_detail_idx].bgcj001 != g_bgcj_d_t.bgcj001 OR g_bgcj_d[g_detail_idx].bgcj002 != g_bgcj_d_t.bgcj002 OR g_bgcj_d[g_detail_idx].bgcj003 != g_bgcj_d_t.bgcj003 OR g_bgcj_d[g_detail_idx].bgcj004 != g_bgcj_d_t.bgcj004 OR g_bgcj_d[g_detail_idx].bgcj005 != g_bgcj_d_t.bgcj005 OR g_bgcj_d[g_detail_idx].bgcj006 != g_bgcj_d_t.bgcj006 OR g_bgcj_d[g_detail_idx].bgcj007 != g_bgcj_d_t.bgcj007 OR g_bgcj_d[g_detail_idx].bgcj008 != g_bgcj_d_t.bgcj008 OR g_bgcj_d[g_detail_idx].bgcj009 != g_bgcj_d_t.bgcj009 OR g_bgcj_d[g_detail_idx].bgcj010 != g_bgcj_d_t.bgcj010 OR g_bgcj_d[g_detail_idx].bgcjseq != g_bgcj_d_t.bgcjseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bgcj_t WHERE "||"bgcjent = " ||g_enterprise|| " AND "||"bgcj001 = '"||g_bgcj_d[g_detail_idx].bgcj001 ||"' AND "|| "bgcj002 = '"||g_bgcj_d[g_detail_idx].bgcj002 ||"' AND "|| "bgcj003 = '"||g_bgcj_d[g_detail_idx].bgcj003 ||"' AND "|| "bgcj004 = '"||g_bgcj_d[g_detail_idx].bgcj004 ||"' AND "|| "bgcj005 = '"||g_bgcj_d[g_detail_idx].bgcj005 ||"' AND "|| "bgcj006 = '"||g_bgcj_d[g_detail_idx].bgcj006 ||"' AND "|| "bgcj007 = '"||g_bgcj_d[g_detail_idx].bgcj007 ||"' AND "|| "bgcj008 = '"||g_bgcj_d[g_detail_idx].bgcj008 ||"' AND "|| "bgcj009 = '"||g_bgcj_d[g_detail_idx].bgcj009 ||"' AND "|| "bgcj010 = '"||g_bgcj_d[g_detail_idx].bgcj010 ||"' AND "|| "bgcjseq = '"||g_bgcj_d[g_detail_idx].bgcjseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj010
            #add-point:ON CHANGE bgcj010 name="input.g.page1.bgcj010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcjseq
            #add-point:BEFORE FIELD bgcjseq name="input.b.page1.bgcjseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcjseq
            
            #add-point:AFTER FIELD bgcjseq name="input.a.page1.bgcjseq"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_bgcj_d[g_detail_idx].bgcj001 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj002 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj003 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj004 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj005 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj006 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj007 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj008 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj009 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj010 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcjseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_bgcj_d[g_detail_idx].bgcj001 != g_bgcj_d_t.bgcj001 OR g_bgcj_d[g_detail_idx].bgcj002 != g_bgcj_d_t.bgcj002 OR g_bgcj_d[g_detail_idx].bgcj003 != g_bgcj_d_t.bgcj003 OR g_bgcj_d[g_detail_idx].bgcj004 != g_bgcj_d_t.bgcj004 OR g_bgcj_d[g_detail_idx].bgcj005 != g_bgcj_d_t.bgcj005 OR g_bgcj_d[g_detail_idx].bgcj006 != g_bgcj_d_t.bgcj006 OR g_bgcj_d[g_detail_idx].bgcj007 != g_bgcj_d_t.bgcj007 OR g_bgcj_d[g_detail_idx].bgcj008 != g_bgcj_d_t.bgcj008 OR g_bgcj_d[g_detail_idx].bgcj009 != g_bgcj_d_t.bgcj009 OR g_bgcj_d[g_detail_idx].bgcj010 != g_bgcj_d_t.bgcj010 OR g_bgcj_d[g_detail_idx].bgcjseq != g_bgcj_d_t.bgcjseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bgcj_t WHERE "||"bgcjent = " ||g_enterprise|| " AND "||"bgcj001 = '"||g_bgcj_d[g_detail_idx].bgcj001 ||"' AND "|| "bgcj002 = '"||g_bgcj_d[g_detail_idx].bgcj002 ||"' AND "|| "bgcj003 = '"||g_bgcj_d[g_detail_idx].bgcj003 ||"' AND "|| "bgcj004 = '"||g_bgcj_d[g_detail_idx].bgcj004 ||"' AND "|| "bgcj005 = '"||g_bgcj_d[g_detail_idx].bgcj005 ||"' AND "|| "bgcj006 = '"||g_bgcj_d[g_detail_idx].bgcj006 ||"' AND "|| "bgcj007 = '"||g_bgcj_d[g_detail_idx].bgcj007 ||"' AND "|| "bgcj008 = '"||g_bgcj_d[g_detail_idx].bgcj008 ||"' AND "|| "bgcj009 = '"||g_bgcj_d[g_detail_idx].bgcj009 ||"' AND "|| "bgcj010 = '"||g_bgcj_d[g_detail_idx].bgcj010 ||"' AND "|| "bgcjseq = '"||g_bgcj_d[g_detail_idx].bgcjseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcjseq
            #add-point:ON CHANGE bgcjseq name="input.g.page1.bgcjseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj008
            #add-point:BEFORE FIELD bgcj008 name="input.b.page1.bgcj008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj008
            
            #add-point:AFTER FIELD bgcj008 name="input.a.page1.bgcj008"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_bgcj_d[g_detail_idx].bgcj001 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj002 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj003 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj004 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj005 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj006 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj007 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj008 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj009 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj010 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcjseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_bgcj_d[g_detail_idx].bgcj001 != g_bgcj_d_t.bgcj001 OR g_bgcj_d[g_detail_idx].bgcj002 != g_bgcj_d_t.bgcj002 OR g_bgcj_d[g_detail_idx].bgcj003 != g_bgcj_d_t.bgcj003 OR g_bgcj_d[g_detail_idx].bgcj004 != g_bgcj_d_t.bgcj004 OR g_bgcj_d[g_detail_idx].bgcj005 != g_bgcj_d_t.bgcj005 OR g_bgcj_d[g_detail_idx].bgcj006 != g_bgcj_d_t.bgcj006 OR g_bgcj_d[g_detail_idx].bgcj007 != g_bgcj_d_t.bgcj007 OR g_bgcj_d[g_detail_idx].bgcj008 != g_bgcj_d_t.bgcj008 OR g_bgcj_d[g_detail_idx].bgcj009 != g_bgcj_d_t.bgcj009 OR g_bgcj_d[g_detail_idx].bgcj010 != g_bgcj_d_t.bgcj010 OR g_bgcj_d[g_detail_idx].bgcjseq != g_bgcj_d_t.bgcjseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bgcj_t WHERE "||"bgcjent = " ||g_enterprise|| " AND "||"bgcj001 = '"||g_bgcj_d[g_detail_idx].bgcj001 ||"' AND "|| "bgcj002 = '"||g_bgcj_d[g_detail_idx].bgcj002 ||"' AND "|| "bgcj003 = '"||g_bgcj_d[g_detail_idx].bgcj003 ||"' AND "|| "bgcj004 = '"||g_bgcj_d[g_detail_idx].bgcj004 ||"' AND "|| "bgcj005 = '"||g_bgcj_d[g_detail_idx].bgcj005 ||"' AND "|| "bgcj006 = '"||g_bgcj_d[g_detail_idx].bgcj006 ||"' AND "|| "bgcj007 = '"||g_bgcj_d[g_detail_idx].bgcj007 ||"' AND "|| "bgcj008 = '"||g_bgcj_d[g_detail_idx].bgcj008 ||"' AND "|| "bgcj009 = '"||g_bgcj_d[g_detail_idx].bgcj009 ||"' AND "|| "bgcj010 = '"||g_bgcj_d[g_detail_idx].bgcj010 ||"' AND "|| "bgcjseq = '"||g_bgcj_d[g_detail_idx].bgcjseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj008
            #add-point:ON CHANGE bgcj008 name="input.g.page1.bgcj008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD num1
            #add-point:BEFORE FIELD num1 name="input.b.page1.num1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD num1
            
            #add-point:AFTER FIELD num1 name="input.a.page1.num1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE num1
            #add-point:ON CHANGE num1 name="input.g.page1.num1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD price1
            #add-point:BEFORE FIELD price1 name="input.b.page1.price1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD price1
            
            #add-point:AFTER FIELD price1 name="input.a.page1.price1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE price1
            #add-point:ON CHANGE price1 name="input.g.page1.price1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt1
            #add-point:BEFORE FIELD amt1 name="input.b.page1.amt1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt1
            
            #add-point:AFTER FIELD amt1 name="input.a.page1.amt1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt1
            #add-point:ON CHANGE amt1 name="input.g.page1.amt1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD num2
            #add-point:BEFORE FIELD num2 name="input.b.page1.num2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD num2
            
            #add-point:AFTER FIELD num2 name="input.a.page1.num2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE num2
            #add-point:ON CHANGE num2 name="input.g.page1.num2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD price2
            #add-point:BEFORE FIELD price2 name="input.b.page1.price2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD price2
            
            #add-point:AFTER FIELD price2 name="input.a.page1.price2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE price2
            #add-point:ON CHANGE price2 name="input.g.page1.price2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt2
            #add-point:BEFORE FIELD amt2 name="input.b.page1.amt2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt2
            
            #add-point:AFTER FIELD amt2 name="input.a.page1.amt2"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt2
            #add-point:ON CHANGE amt2 name="input.g.page1.amt2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD num3
            #add-point:BEFORE FIELD num3 name="input.b.page1.num3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD num3
            
            #add-point:AFTER FIELD num3 name="input.a.page1.num3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE num3
            #add-point:ON CHANGE num3 name="input.g.page1.num3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD price3
            #add-point:BEFORE FIELD price3 name="input.b.page1.price3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD price3
            
            #add-point:AFTER FIELD price3 name="input.a.page1.price3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE price3
            #add-point:ON CHANGE price3 name="input.g.page1.price3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt3
            #add-point:BEFORE FIELD amt3 name="input.b.page1.amt3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt3
            
            #add-point:AFTER FIELD amt3 name="input.a.page1.amt3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt3
            #add-point:ON CHANGE amt3 name="input.g.page1.amt3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD num4
            #add-point:BEFORE FIELD num4 name="input.b.page1.num4"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD num4
            
            #add-point:AFTER FIELD num4 name="input.a.page1.num4"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE num4
            #add-point:ON CHANGE num4 name="input.g.page1.num4"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD price4
            #add-point:BEFORE FIELD price4 name="input.b.page1.price4"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD price4
            
            #add-point:AFTER FIELD price4 name="input.a.page1.price4"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE price4
            #add-point:ON CHANGE price4 name="input.g.page1.price4"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt4
            #add-point:BEFORE FIELD amt4 name="input.b.page1.amt4"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt4
            
            #add-point:AFTER FIELD amt4 name="input.a.page1.amt4"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt4
            #add-point:ON CHANGE amt4 name="input.g.page1.amt4"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD num5
            #add-point:BEFORE FIELD num5 name="input.b.page1.num5"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD num5
            
            #add-point:AFTER FIELD num5 name="input.a.page1.num5"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE num5
            #add-point:ON CHANGE num5 name="input.g.page1.num5"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD price5
            #add-point:BEFORE FIELD price5 name="input.b.page1.price5"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD price5
            
            #add-point:AFTER FIELD price5 name="input.a.page1.price5"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE price5
            #add-point:ON CHANGE price5 name="input.g.page1.price5"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt5
            #add-point:BEFORE FIELD amt5 name="input.b.page1.amt5"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt5
            
            #add-point:AFTER FIELD amt5 name="input.a.page1.amt5"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt5
            #add-point:ON CHANGE amt5 name="input.g.page1.amt5"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD num6
            #add-point:BEFORE FIELD num6 name="input.b.page1.num6"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD num6
            
            #add-point:AFTER FIELD num6 name="input.a.page1.num6"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE num6
            #add-point:ON CHANGE num6 name="input.g.page1.num6"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD price6
            #add-point:BEFORE FIELD price6 name="input.b.page1.price6"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD price6
            
            #add-point:AFTER FIELD price6 name="input.a.page1.price6"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE price6
            #add-point:ON CHANGE price6 name="input.g.page1.price6"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt6
            #add-point:BEFORE FIELD amt6 name="input.b.page1.amt6"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt6
            
            #add-point:AFTER FIELD amt6 name="input.a.page1.amt6"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt6
            #add-point:ON CHANGE amt6 name="input.g.page1.amt6"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD num7
            #add-point:BEFORE FIELD num7 name="input.b.page1.num7"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD num7
            
            #add-point:AFTER FIELD num7 name="input.a.page1.num7"
          
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE num7
            #add-point:ON CHANGE num7 name="input.g.page1.num7"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD price7
            #add-point:BEFORE FIELD price7 name="input.b.page1.price7"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD price7
            
            #add-point:AFTER FIELD price7 name="input.a.page1.price7"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE price7
            #add-point:ON CHANGE price7 name="input.g.page1.price7"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt7
            #add-point:BEFORE FIELD amt7 name="input.b.page1.amt7"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt7
            
            #add-point:AFTER FIELD amt7 name="input.a.page1.amt7"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt7
            #add-point:ON CHANGE amt7 name="input.g.page1.amt7"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD num8
            #add-point:BEFORE FIELD num8 name="input.b.page1.num8"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD num8
            
            #add-point:AFTER FIELD num8 name="input.a.page1.num8"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE num8
            #add-point:ON CHANGE num8 name="input.g.page1.num8"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD price8
            #add-point:BEFORE FIELD price8 name="input.b.page1.price8"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD price8
            
            #add-point:AFTER FIELD price8 name="input.a.page1.price8"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE price8
            #add-point:ON CHANGE price8 name="input.g.page1.price8"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt8
            #add-point:BEFORE FIELD amt8 name="input.b.page1.amt8"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt8
            
            #add-point:AFTER FIELD amt8 name="input.a.page1.amt8"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt8
            #add-point:ON CHANGE amt8 name="input.g.page1.amt8"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD num9
            #add-point:BEFORE FIELD num9 name="input.b.page1.num9"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD num9
            
            #add-point:AFTER FIELD num9 name="input.a.page1.num9"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE num9
            #add-point:ON CHANGE num9 name="input.g.page1.num9"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD price9
            #add-point:BEFORE FIELD price9 name="input.b.page1.price9"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD price9
            
            #add-point:AFTER FIELD price9 name="input.a.page1.price9"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE price9
            #add-point:ON CHANGE price9 name="input.g.page1.price9"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt9
            #add-point:BEFORE FIELD amt9 name="input.b.page1.amt9"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt9
            
            #add-point:AFTER FIELD amt9 name="input.a.page1.amt9"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt9
            #add-point:ON CHANGE amt9 name="input.g.page1.amt9"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD num10
            #add-point:BEFORE FIELD num10 name="input.b.page1.num10"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD num10
            
            #add-point:AFTER FIELD num10 name="input.a.page1.num10"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE num10
            #add-point:ON CHANGE num10 name="input.g.page1.num10"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD price10
            #add-point:BEFORE FIELD price10 name="input.b.page1.price10"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD price10
            
            #add-point:AFTER FIELD price10 name="input.a.page1.price10"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE price10
            #add-point:ON CHANGE price10 name="input.g.page1.price10"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt10
            #add-point:BEFORE FIELD amt10 name="input.b.page1.amt10"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt10
            
            #add-point:AFTER FIELD amt10 name="input.a.page1.amt10"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt10
            #add-point:ON CHANGE amt10 name="input.g.page1.amt10"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD num11
            #add-point:BEFORE FIELD num11 name="input.b.page1.num11"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD num11
            
            #add-point:AFTER FIELD num11 name="input.a.page1.num11"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE num11
            #add-point:ON CHANGE num11 name="input.g.page1.num11"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD price11
            #add-point:BEFORE FIELD price11 name="input.b.page1.price11"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD price11
            
            #add-point:AFTER FIELD price11 name="input.a.page1.price11"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE price11
            #add-point:ON CHANGE price11 name="input.g.page1.price11"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt11
            #add-point:BEFORE FIELD amt11 name="input.b.page1.amt11"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt11
            
            #add-point:AFTER FIELD amt11 name="input.a.page1.amt11"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt11
            #add-point:ON CHANGE amt11 name="input.g.page1.amt11"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD num12
            #add-point:BEFORE FIELD num12 name="input.b.page1.num12"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD num12
            
            #add-point:AFTER FIELD num12 name="input.a.page1.num12"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE num12
            #add-point:ON CHANGE num12 name="input.g.page1.num12"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD price12
            #add-point:BEFORE FIELD price12 name="input.b.page1.price12"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD price12
            
            #add-point:AFTER FIELD price12 name="input.a.page1.price12"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE price12
            #add-point:ON CHANGE price12 name="input.g.page1.price12"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt12
            #add-point:BEFORE FIELD amt12 name="input.b.page1.amt12"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt12
            
            #add-point:AFTER FIELD amt12 name="input.a.page1.amt12"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt12
            #add-point:ON CHANGE amt12 name="input.g.page1.amt12"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD num13
            #add-point:BEFORE FIELD num13 name="input.b.page1.num13"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD num13
            
            #add-point:AFTER FIELD num13 name="input.a.page1.num13"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE num13
            #add-point:ON CHANGE num13 name="input.g.page1.num13"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD price13
            #add-point:BEFORE FIELD price13 name="input.b.page1.price13"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD price13
            
            #add-point:AFTER FIELD price13 name="input.a.page1.price13"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE price13
            #add-point:ON CHANGE price13 name="input.g.page1.price13"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt13
            #add-point:BEFORE FIELD amt13 name="input.b.page1.amt13"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt13
            
            #add-point:AFTER FIELD amt13 name="input.a.page1.amt13"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt13
            #add-point:ON CHANGE amt13 name="input.g.page1.amt13"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sum
            #add-point:BEFORE FIELD sum name="input.b.page1.sum"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sum
            
            #add-point:AFTER FIELD sum name="input.a.page1.sum"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sum
            #add-point:ON CHANGE sum name="input.g.page1.sum"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.bgcj001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj001
            #add-point:ON ACTION controlp INFIELD bgcj001 name="input.c.page1.bgcj001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj002
            #add-point:ON ACTION controlp INFIELD bgcj002 name="input.c.page1.bgcj002"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgcj_d[l_ac].bgcj002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

 
            CALL q_bgaa001()                                #呼叫開窗
 
            LET g_bgcj_d[l_ac].bgcj002 = g_qryparam.return1              

            DISPLAY g_bgcj_d[l_ac].bgcj002 TO bgcj002              #

            NEXT FIELD bgcj002                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj003
            #add-point:ON ACTION controlp INFIELD bgcj003 name="input.c.page1.bgcj003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj004
            #add-point:ON ACTION controlp INFIELD bgcj004 name="input.c.page1.bgcj004"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgcj_d[l_ac].bgcj004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

 
            CALL q_bgai002()                                #呼叫開窗
 
            LET g_bgcj_d[l_ac].bgcj004 = g_qryparam.return1              

            DISPLAY g_bgcj_d[l_ac].bgcj004 TO bgcj004              #

            NEXT FIELD bgcj004                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj005
            #add-point:ON ACTION controlp INFIELD bgcj005 name="input.c.page1.bgcj005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj006
            #add-point:ON ACTION controlp INFIELD bgcj006 name="input.c.page1.bgcj006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj007
            #add-point:ON ACTION controlp INFIELD bgcj007 name="input.c.page1.bgcj007"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgcj_d[l_ac].bgcj007             #給予default值
            LET g_qryparam.default2 = "" #g_bgcj_d[l_ac].ooef001 #组织编号
            #給予arg
            LET g_qryparam.arg1 = "" #

 
            CALL q_ooef001()                                #呼叫開窗
 
            LET g_bgcj_d[l_ac].bgcj007 = g_qryparam.return1              
            #LET g_bgcj_d[l_ac].ooef001 = g_qryparam.return2 
            DISPLAY g_bgcj_d[l_ac].bgcj007 TO bgcj007              #
            #DISPLAY g_bgcj_d[l_ac].ooef001 TO ooef001 #组织编号
            NEXT FIELD bgcj007                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj009
            #add-point:ON ACTION controlp INFIELD bgcj009 name="input.c.page1.bgcj009"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgcj_d[l_ac].bgcj009             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

 
            CALL q_bgas001()                                #呼叫開窗
 
            LET g_bgcj_d[l_ac].bgcj009 = g_qryparam.return1              

            DISPLAY g_bgcj_d[l_ac].bgcj009 TO bgcj009              #

            NEXT FIELD bgcj009                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj010
            #add-point:ON ACTION controlp INFIELD bgcj010 name="input.c.page1.bgcj010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcjseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcjseq
            #add-point:ON ACTION controlp INFIELD bgcjseq name="input.c.page1.bgcjseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj008
            #add-point:ON ACTION controlp INFIELD bgcj008 name="input.c.page1.bgcj008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.num1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD num1
            #add-point:ON ACTION controlp INFIELD num1 name="input.c.page1.num1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.price1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD price1
            #add-point:ON ACTION controlp INFIELD price1 name="input.c.page1.price1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.amt1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt1
            #add-point:ON ACTION controlp INFIELD amt1 name="input.c.page1.amt1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.num2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD num2
            #add-point:ON ACTION controlp INFIELD num2 name="input.c.page1.num2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.price2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD price2
            #add-point:ON ACTION controlp INFIELD price2 name="input.c.page1.price2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.amt2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt2
            #add-point:ON ACTION controlp INFIELD amt2 name="input.c.page1.amt2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.num3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD num3
            #add-point:ON ACTION controlp INFIELD num3 name="input.c.page1.num3"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.price3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD price3
            #add-point:ON ACTION controlp INFIELD price3 name="input.c.page1.price3"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.amt3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt3
            #add-point:ON ACTION controlp INFIELD amt3 name="input.c.page1.amt3"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.num4
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD num4
            #add-point:ON ACTION controlp INFIELD num4 name="input.c.page1.num4"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.price4
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD price4
            #add-point:ON ACTION controlp INFIELD price4 name="input.c.page1.price4"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.amt4
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt4
            #add-point:ON ACTION controlp INFIELD amt4 name="input.c.page1.amt4"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.num5
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD num5
            #add-point:ON ACTION controlp INFIELD num5 name="input.c.page1.num5"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.price5
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD price5
            #add-point:ON ACTION controlp INFIELD price5 name="input.c.page1.price5"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.amt5
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt5
            #add-point:ON ACTION controlp INFIELD amt5 name="input.c.page1.amt5"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.num6
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD num6
            #add-point:ON ACTION controlp INFIELD num6 name="input.c.page1.num6"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.price6
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD price6
            #add-point:ON ACTION controlp INFIELD price6 name="input.c.page1.price6"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.amt6
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt6
            #add-point:ON ACTION controlp INFIELD amt6 name="input.c.page1.amt6"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.num7
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD num7
            #add-point:ON ACTION controlp INFIELD num7 name="input.c.page1.num7"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.price7
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD price7
            #add-point:ON ACTION controlp INFIELD price7 name="input.c.page1.price7"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.amt7
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt7
            #add-point:ON ACTION controlp INFIELD amt7 name="input.c.page1.amt7"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.num8
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD num8
            #add-point:ON ACTION controlp INFIELD num8 name="input.c.page1.num8"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.price8
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD price8
            #add-point:ON ACTION controlp INFIELD price8 name="input.c.page1.price8"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.amt8
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt8
            #add-point:ON ACTION controlp INFIELD amt8 name="input.c.page1.amt8"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.num9
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD num9
            #add-point:ON ACTION controlp INFIELD num9 name="input.c.page1.num9"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.price9
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD price9
            #add-point:ON ACTION controlp INFIELD price9 name="input.c.page1.price9"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.amt9
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt9
            #add-point:ON ACTION controlp INFIELD amt9 name="input.c.page1.amt9"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.num10
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD num10
            #add-point:ON ACTION controlp INFIELD num10 name="input.c.page1.num10"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.price10
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD price10
            #add-point:ON ACTION controlp INFIELD price10 name="input.c.page1.price10"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.amt10
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt10
            #add-point:ON ACTION controlp INFIELD amt10 name="input.c.page1.amt10"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.num11
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD num11
            #add-point:ON ACTION controlp INFIELD num11 name="input.c.page1.num11"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.price11
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD price11
            #add-point:ON ACTION controlp INFIELD price11 name="input.c.page1.price11"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.amt11
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt11
            #add-point:ON ACTION controlp INFIELD amt11 name="input.c.page1.amt11"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.num12
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD num12
            #add-point:ON ACTION controlp INFIELD num12 name="input.c.page1.num12"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.price12
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD price12
            #add-point:ON ACTION controlp INFIELD price12 name="input.c.page1.price12"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.amt12
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt12
            #add-point:ON ACTION controlp INFIELD amt12 name="input.c.page1.amt12"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.num13
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD num13
            #add-point:ON ACTION controlp INFIELD num13 name="input.c.page1.num13"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.price13
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD price13
            #add-point:ON ACTION controlp INFIELD price13 name="input.c.page1.price13"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.amt13
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt13
            #add-point:ON ACTION controlp INFIELD amt13 name="input.c.page1.amt13"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sum
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sum
            #add-point:ON ACTION controlp INFIELD sum name="input.c.page1.sum"
            
            #END add-point
 
 
 
 
         #自訂ACTION
         #add-point:單身其他段落處理(EX:on row change, etc...) name="input.other"
         
         #end add-point
 
         AFTER INPUT
            #add-point:單身輸入後處理 name="input.after_input"
            
            #end add-point
            
      END INPUT
      
 
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      #公用action
      ON ACTION accept
         ACCEPT DIALOG
        
      ON ACTION cancel
         #add-point:cancel name="input.cancel"
         
         #end add-point
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION close
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit
         LET INT_FLAG = TRUE 
         EXIT DIALOG
   
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
 
   #add-point:畫面關閉前 name="input.before_close"
   END IF 
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_abgt340_01 
   
   #add-point:input段after input name="input.post_input"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="abgt340_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="abgt340_01.other_function" readonly="Y" >}

################################################################################
# Descriptions...:填充单身
# Memo...........:
# Usage..........: CALL abgt340_01_b_fill()
#                  RETURNING 回传参数
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/11/04 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt340_01_b_fill()
   DEFINE l_sql           STRING
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_bgcj038       LIKE bgcj_t.bgcj038
   DEFINE l_bgcj039       LIKE bgcj_t.bgcj039
   DEFINE l_bgcj040       LIKE bgcj_t.bgcj040
   DEFINE l_bgcj041       LIKE bgcj_t.bgcj041
   DEFINE l_bgcj042       LIKE bgcj_t.bgcj042
   DEFINE l_bgcj043       LIKE bgcj_t.bgcj043
   DEFINE l_bgcj044       LIKE bgcj_t.bgcj044
   DEFINE l_bgcj045       LIKE bgcj_t.bgcj045
   DEFINE l_bgcj046       LIKE bgcj_t.bgcj046
   DEFINE l_bgcj102       LIKE bgcj_t.bgcj102
   DEFINE l_amt1          LIKE bgcj_t.bgcj040
   DEFINE l_amt2          LIKE bgcj_t.bgcj040
   
   CALL g_bgcj_d.clear()
   #期别销售预算
   IF g_prog = 'abgt340' OR g_prog = 'abgt350' THEN
      LET l_sql="SELECT bgcj038,bgcj039,bgcj040,bgcj041,bgcj042,bgcj043,bgcj044,bgcj045,bgcj046,bgcj102",
                "  FROM bgcj_t ",
                " WHERE bgcjent =  ",g_enterprise,
                "   AND bgcj001 = '",g_bgcj001_t,"'",
                "   AND bgcj002 = '",g_bgcj002_t,"'",
                "   AND bgcj003 = '",g_bgcj003_t,"'",
                "   AND bgcj004 = '",g_bgcj004_t,"'",
                "   AND bgcj005 = '",g_bgcj005_t,"'",
                "   AND bgcj006 = '",g_bgcj006_t,"'",
                "   AND bgcj007 = '",g_bgcj007_t,"'",
                "   AND bgcj009 = '",g_bgcj009_t,"'",
                "   AND bgcj010 = '",g_bgcj010_t,"'",
                "   AND bgcjseq =  ",g_bgcjseq_t,
                "   AND bgcj008 = ? "
   END IF
   #期别采购预算
   IF g_prog = 'abgt510' OR g_prog = 'abgt520' THEN
      LET l_sql="SELECT bgeg038,bgeg039,bgeg040,bgeg041,bgeg042,bgeg043,bgeg044,bgeg045,bgeg046,bgeg102",
                "  FROM bgeg_t ",
                " WHERE bgegent =  ",g_enterprise,
                "   AND bgeg001 = '",g_bgcj001_t,"'",
                "   AND bgeg002 = '",g_bgcj002_t,"'",
                "   AND bgeg003 = '",g_bgcj003_t,"'",
                "   AND bgeg004 = '",g_bgcj004_t,"'",
                "   AND bgeg005 = '",g_bgcj005_t,"'",
                "   AND bgeg006 = '",g_bgcj006_t,"'",
                "   AND bgeg007 = '",g_bgcj007_t,"'",
                "   AND bgeg009 = '",g_bgcj009_t,"'",
                "   AND bgeg010 = '",g_bgcj010_t,"'",
                "   AND bgegseq =  ",g_bgcjseq_t,
                "   AND bgeg008 = ? "
   END IF
   
   #期别费用预算
   IF g_prog = 'abgt620' OR g_prog = 'abgt630' THEN
      LET l_sql="SELECT bgfb037,bgfb038,bgfb039,bgfb102",
                "  FROM bgfb_t ",
                " WHERE bgfbent =  ",g_enterprise,
                "   AND bgfb001 = '",g_bgcj001_t,"'",
                "   AND bgfb002 = '",g_bgcj002_t,"'",
                "   AND bgfb003 = '",g_bgcj003_t,"'",
                "   AND bgfb004 = '",g_bgcj004_t,"'",
                "   AND bgfb005 = '",g_bgcj005_t,"'",
                "   AND bgfb006 = '",g_bgcj006_t,"'",
                "   AND bgfb007 = '",g_bgcj007_t,"'",
                "   AND bgfb009 = '",g_bgcj009_t,"'",
                "   AND bgfb010 = '",g_bgcj010_t,"'",
                "   AND bgfbseq =  ",g_bgcjseq_t,
                "   AND bgfb008 = ? "
   END IF
   
   PREPARE abgt340_01_b_fill_pr FROM l_sql
   
   LET g_bgcj_d[1].bgcj001 = g_bgcj001_t
   LET g_bgcj_d[1].bgcj002 = g_bgcj002_t
   LET g_bgcj_d[1].bgcj003 = g_bgcj003_t
   LET g_bgcj_d[1].bgcj004 = g_bgcj004_t
   LET g_bgcj_d[1].bgcj005 = g_bgcj005_t
   LET g_bgcj_d[1].bgcj006 = g_bgcj006_t
   LET g_bgcj_d[1].bgcj007 = g_bgcj007_t
   LET g_bgcj_d[1].bgcj009 = g_bgcj009_t
   LET g_bgcj_d[1].bgcj010 = g_bgcj010_t
   LET g_bgcj_d[1].bgcjseq = g_bgcjseq_t
   LET g_bgcj_d[2].* = g_bgcj_d[1].*
   LET g_bgcj_d[3].* = g_bgcj_d[1].*
   LET g_bgcj_d[4].* = g_bgcj_d[1].*
   #第一行：基准金额
   LET g_bgcj_d[1].content = '1'
   #第二行：本层调整
   LET g_bgcj_d[2].content = '2'
   #第三行：上层调整
   LET g_bgcj_d[3].content = '3'
   #第四行：核准金额  
   LET g_bgcj_d[4].content = '4'
   
   FOR l_i = 1 TO g_max_period
      #期别费用预算
      IF g_prog = 'abgt620' OR g_prog = 'abgt630' THEN
         EXECUTE abgt340_01_b_fill_pr USING l_i
         INTO l_bgcj040,l_amt1,l_amt2,l_bgcj102
      ELSE
         EXECUTE abgt340_01_b_fill_pr USING l_i
         INTO l_bgcj038,l_bgcj039,l_bgcj040,l_bgcj041,l_bgcj042,l_bgcj043,
              l_bgcj044,l_bgcj045,l_bgcj046,l_bgcj102 
            
         #调整金额=调整数量*（基准单价+调整单价）+基准数量*调整单价
         #本层调整金额
         LET l_amt1 = l_bgcj041 * (l_bgcj039 + l_bgcj042) + l_bgcj038 * l_bgcj042
         #上层调整
         LET l_amt2 = l_bgcj043 * (l_bgcj039 + l_bgcj044) + l_bgcj038 * l_bgcj044
      END IF
      CASE l_i
         WHEN 1 
            LET g_bgcj_d[1].num1 = l_bgcj038
            LET g_bgcj_d[1].price1 = l_bgcj039
            LET g_bgcj_d[1].amt1 = l_bgcj040
            LET g_bgcj_d[2].num1 = l_bgcj041
            LET g_bgcj_d[2].price1 = l_bgcj042
            LET g_bgcj_d[2].amt1 = l_amt1
            LET g_bgcj_d[3].num1 = l_bgcj043
            LET g_bgcj_d[3].price1 = l_bgcj044
            LET g_bgcj_d[3].amt1 = l_amt2
            LET g_bgcj_d[4].num1 = l_bgcj045
            LET g_bgcj_d[4].price1 = l_bgcj046
            LET g_bgcj_d[4].amt1 = l_bgcj102
         WHEN 2 
            LET g_bgcj_d[1].num2 = l_bgcj038
            LET g_bgcj_d[1].price2 = l_bgcj039
            LET g_bgcj_d[1].amt2 = l_bgcj040
            LET g_bgcj_d[2].num2 = l_bgcj041
            LET g_bgcj_d[2].price2 = l_bgcj042
            LET g_bgcj_d[2].amt2 = l_amt1
            LET g_bgcj_d[3].num2 = l_bgcj043
            LET g_bgcj_d[3].price2 = l_bgcj044
            LET g_bgcj_d[3].amt2 = l_amt2
            LET g_bgcj_d[4].num2 = l_bgcj045
            LET g_bgcj_d[4].price2 = l_bgcj046
            LET g_bgcj_d[4].amt2 = l_bgcj102
         WHEN 3 
            LET g_bgcj_d[1].num3 = l_bgcj038
            LET g_bgcj_d[1].price3 = l_bgcj039
            LET g_bgcj_d[1].amt3 = l_bgcj040
            LET g_bgcj_d[2].num3 = l_bgcj041
            LET g_bgcj_d[2].price3 = l_bgcj042
            LET g_bgcj_d[2].amt3 = l_amt1
            LET g_bgcj_d[3].num3 = l_bgcj043
            LET g_bgcj_d[3].price3 = l_bgcj044
            LET g_bgcj_d[3].amt3 = l_amt2
            LET g_bgcj_d[4].num3 = l_bgcj045
            LET g_bgcj_d[4].price3 = l_bgcj046
            LET g_bgcj_d[4].amt3 = l_bgcj102
         WHEN 4 
            LET g_bgcj_d[1].num4 = l_bgcj038
            LET g_bgcj_d[1].price4 = l_bgcj039
            LET g_bgcj_d[1].amt4 = l_bgcj040
            LET g_bgcj_d[2].num4 = l_bgcj041
            LET g_bgcj_d[2].price4 = l_bgcj042
            LET g_bgcj_d[2].amt4 = l_amt1
            LET g_bgcj_d[3].num4 = l_bgcj043
            LET g_bgcj_d[3].price4 = l_bgcj044
            LET g_bgcj_d[3].amt4 = l_amt2
            LET g_bgcj_d[4].num4 = l_bgcj045
            LET g_bgcj_d[4].price4 = l_bgcj046
            LET g_bgcj_d[4].amt4 = l_bgcj102
         WHEN 5              
            LET g_bgcj_d[1].num5 = l_bgcj038
            LET g_bgcj_d[1].price5 = l_bgcj039
            LET g_bgcj_d[1].amt5 = l_bgcj040
            LET g_bgcj_d[2].num5 = l_bgcj041
            LET g_bgcj_d[2].price5 = l_bgcj042
            LET g_bgcj_d[2].amt5 = l_amt1
            LET g_bgcj_d[3].num5 = l_bgcj043
            LET g_bgcj_d[3].price5 = l_bgcj044
            LET g_bgcj_d[3].amt5 = l_amt2
            LET g_bgcj_d[4].num5 = l_bgcj045
            LET g_bgcj_d[4].price5 = l_bgcj046
            LET g_bgcj_d[4].amt5 = l_bgcj102
         WHEN 6 
            LET g_bgcj_d[1].num6 = l_bgcj038
            LET g_bgcj_d[1].price6 = l_bgcj039
            LET g_bgcj_d[1].amt6 = l_bgcj040
            LET g_bgcj_d[2].num6 = l_bgcj041
            LET g_bgcj_d[2].price6 = l_bgcj042
            LET g_bgcj_d[2].amt6 = l_amt1
            LET g_bgcj_d[3].num6 = l_bgcj043
            LET g_bgcj_d[3].price6 = l_bgcj044
            LET g_bgcj_d[3].amt6 = l_amt2
            LET g_bgcj_d[4].num6 = l_bgcj045
            LET g_bgcj_d[4].price6 = l_bgcj046
            LET g_bgcj_d[4].amt6 = l_bgcj102
         WHEN 7              
            LET g_bgcj_d[1].num7 = l_bgcj038
            LET g_bgcj_d[1].price7 = l_bgcj039
            LET g_bgcj_d[1].amt7 = l_bgcj040
            LET g_bgcj_d[2].num7 = l_bgcj041
            LET g_bgcj_d[2].price7 = l_bgcj042
            LET g_bgcj_d[2].amt7 = l_amt1
            LET g_bgcj_d[3].num7 = l_bgcj043
            LET g_bgcj_d[3].price7 = l_bgcj044
            LET g_bgcj_d[3].amt7 = l_amt2
            LET g_bgcj_d[4].num7 = l_bgcj045
            LET g_bgcj_d[4].price7 = l_bgcj046
            LET g_bgcj_d[4].amt7 = l_bgcj102
         WHEN 8              
            LET g_bgcj_d[1].num8 = l_bgcj038
            LET g_bgcj_d[1].price8 = l_bgcj039
            LET g_bgcj_d[1].amt8 = l_bgcj040
            LET g_bgcj_d[2].num8 = l_bgcj041
            LET g_bgcj_d[2].price8 = l_bgcj042
            LET g_bgcj_d[2].amt8 = l_amt1
            LET g_bgcj_d[3].num8 = l_bgcj043
            LET g_bgcj_d[3].price8 = l_bgcj044
            LET g_bgcj_d[3].amt8 = l_amt2
            LET g_bgcj_d[4].num8 = l_bgcj045
            LET g_bgcj_d[4].price8 = l_bgcj046
            LET g_bgcj_d[4].amt8 = l_bgcj102
         WHEN 9              
            LET g_bgcj_d[1].num9 = l_bgcj038
            LET g_bgcj_d[1].price9 = l_bgcj039
            LET g_bgcj_d[1].amt9 = l_bgcj040
            LET g_bgcj_d[2].num9 = l_bgcj041
            LET g_bgcj_d[2].price9 = l_bgcj042
            LET g_bgcj_d[2].amt9 = l_amt1
            LET g_bgcj_d[3].num9 = l_bgcj043
            LET g_bgcj_d[3].price9 = l_bgcj044
            LET g_bgcj_d[3].amt9 = l_amt2
            LET g_bgcj_d[4].num9 = l_bgcj045
            LET g_bgcj_d[4].price9 = l_bgcj046
            LET g_bgcj_d[4].amt9 = l_bgcj102
         WHEN 10             
            LET g_bgcj_d[1].num10 = l_bgcj038
            LET g_bgcj_d[1].price10 = l_bgcj039
            LET g_bgcj_d[1].amt10 = l_bgcj040
            LET g_bgcj_d[2].num10 = l_bgcj041
            LET g_bgcj_d[2].price10 = l_bgcj042
            LET g_bgcj_d[2].amt10 = l_amt1
            LET g_bgcj_d[3].num10 = l_bgcj043
            LET g_bgcj_d[3].price10 = l_bgcj044
            LET g_bgcj_d[3].amt10 = l_amt2
            LET g_bgcj_d[4].num10 = l_bgcj045
            LET g_bgcj_d[4].price10 = l_bgcj046
            LET g_bgcj_d[4].amt10 = l_bgcj102
         WHEN 11 
            LET g_bgcj_d[1].num11 = l_bgcj038
            LET g_bgcj_d[1].price11 = l_bgcj039
            LET g_bgcj_d[1].amt11 = l_bgcj040
            LET g_bgcj_d[2].num11 = l_bgcj041
            LET g_bgcj_d[2].price11 = l_bgcj042
            LET g_bgcj_d[2].amt11 = l_amt1
            LET g_bgcj_d[3].num11 = l_bgcj043
            LET g_bgcj_d[3].price11 = l_bgcj044
            LET g_bgcj_d[3].amt11 = l_amt2
            LET g_bgcj_d[4].num11 = l_bgcj045
            LET g_bgcj_d[4].price11 = l_bgcj046
            LET g_bgcj_d[4].amt11 = l_bgcj102
         WHEN 12 
            LET g_bgcj_d[1].num12 = l_bgcj038
            LET g_bgcj_d[1].price12 = l_bgcj039
            LET g_bgcj_d[1].amt12 = l_bgcj040
            LET g_bgcj_d[2].num12 = l_bgcj041
            LET g_bgcj_d[2].price12 = l_bgcj042
            LET g_bgcj_d[2].amt12 = l_amt1
            LET g_bgcj_d[3].num12 = l_bgcj043
            LET g_bgcj_d[3].price12 = l_bgcj044
            LET g_bgcj_d[3].amt12 = l_amt2
            LET g_bgcj_d[4].num12 = l_bgcj045
            LET g_bgcj_d[4].price12 = l_bgcj046
            LET g_bgcj_d[4].amt12 = l_bgcj102
         WHEN 13             
            LET g_bgcj_d[1].num13 = l_bgcj038
            LET g_bgcj_d[1].price13 = l_bgcj039
            LET g_bgcj_d[1].amt13 = l_bgcj040
            LET g_bgcj_d[2].num13 = l_bgcj041
            LET g_bgcj_d[2].price13 = l_bgcj042
            LET g_bgcj_d[2].amt13 = l_amt1
            LET g_bgcj_d[3].num13 = l_bgcj043
            LET g_bgcj_d[3].price13 = l_bgcj044
            LET g_bgcj_d[3].amt13 = l_amt2
            LET g_bgcj_d[4].num13 = l_bgcj045
            LET g_bgcj_d[4].price13 = l_bgcj046
            LET g_bgcj_d[4].amt13 = l_bgcj102
      END CASE
   END FOR
   
   #合计
   #期别销售预算
   IF g_prog = 'abgt340' OR g_prog = 'abgt350' THEN
      LET l_sql="SELECT SUM(bgcj040),",
                "       SUM(bgcj041 * (bgcj039 + bgcj042) + bgcj038 * bgcj042),",
                "       SUM(bgcj043 * (bgcj039 + bgcj044) + bgcj038 * bgcj044),",
                "       SUM(bgcj102)",
                "  FROM bgcj_t ",
                " WHERE bgcjent =  ",g_enterprise,
                "   AND bgcj001 = '",g_bgcj001_t,"'",
                "   AND bgcj002 = '",g_bgcj002_t,"'",
                "   AND bgcj003 = '",g_bgcj003_t,"'",
                "   AND bgcj004 = '",g_bgcj004_t,"'",
                "   AND bgcj005 = '",g_bgcj005_t,"'",
                "   AND bgcj006 = '",g_bgcj006_t,"'",
                "   AND bgcj007 = '",g_bgcj007_t,"'",
                "   AND bgcj009 = '",g_bgcj009_t,"'",
                "   AND bgcj010 = '",g_bgcj010_t,"'",
                "   AND bgcjseq =  ",g_bgcjseq_t
   END IF
   #期别采购预算
   IF g_prog = 'abgt510' OR g_prog = 'abgt520' THEN
      LET l_sql="SELECT SUM(bgeg040),",
                "       SUM(bgeg041 * (bgeg039 + bgeg042) + bgeg038 * bgeg042),",
                "       SUM(bgeg043 * (bgeg039 + bgeg044) + bgeg038 * bgeg044),",
                "       SUM(bgeg102)",
                "  FROM bgeg_t ",
                " WHERE bgegent =  ",g_enterprise,
                "   AND bgeg001 = '",g_bgcj001_t,"'",
                "   AND bgeg002 = '",g_bgcj002_t,"'",
                "   AND bgeg003 = '",g_bgcj003_t,"'",
                "   AND bgeg004 = '",g_bgcj004_t,"'",
                "   AND bgeg005 = '",g_bgcj005_t,"'",
                "   AND bgeg006 = '",g_bgcj006_t,"'",
                "   AND bgeg007 = '",g_bgcj007_t,"'",
                "   AND bgeg009 = '",g_bgcj009_t,"'",
                "   AND bgeg010 = '",g_bgcj010_t,"'",
                "   AND bgegseq =  ",g_bgcjseq_t
   END IF   
   #期别费用预算
   IF g_prog = 'abgt620' OR g_prog = 'abgt630' THEN
      LET l_sql="SELECT SUM(bgfb037),",
                "       SUM(bgfb038),",
                "       SUM(bgfb039),",
                "       SUM(bgfb102)",
                "  FROM bgfb_t ",
                " WHERE bgfbent =  ",g_enterprise,
                "   AND bgfb001 = '",g_bgcj001_t,"'",
                "   AND bgfb002 = '",g_bgcj002_t,"'",
                "   AND bgfb003 = '",g_bgcj003_t,"'",
                "   AND bgfb004 = '",g_bgcj004_t,"'",
                "   AND bgfb005 = '",g_bgcj005_t,"'",
                "   AND bgfb006 = '",g_bgcj006_t,"'",
                "   AND bgfb007 = '",g_bgcj007_t,"'",
                "   AND bgfb009 = '",g_bgcj009_t,"'",
                "   AND bgfb010 = '",g_bgcj010_t,"'",
                "   AND bgfbseq =  ",g_bgcjseq_t
   END IF   
   PREPARE abgt340_01_b_fill_sum_pr FROM l_sql
   EXECUTE abgt340_01_b_fill_sum_pr INTO g_bgcj_d[1].sum,g_bgcj_d[2].sum,g_bgcj_d[3].sum,g_bgcj_d[4].sum 
END FUNCTION

################################################################################
# Descriptions...: 更新
# Memo...........:
# Usage..........: CALL abgt340_01_update()
#                  RETURNING r_success
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/11/04 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt340_01_update()
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_bgcj         RECORD LIKE bgcj_t.*
   DEFINE l_i            LIKE type_t.num5
   DEFINE l_bgcj103      LIKE bgcj_t.bgcj103
   DEFINE l_bgcj104      LIKE bgcj_t.bgcj104
   DEFINE l_bgcj105      LIKE bgcj_t.bgcj105
   
   LET r_success = TRUE
   FOR l_i = 1 TO g_max_period
      LET l_bgcj.bgcj008 = l_i
      CASE l_i 
         WHEN 1
            LET l_bgcj.bgcj041 = g_bgcj_d[2].num1
            LET l_bgcj.bgcj042 = g_bgcj_d[2].price1
            LET l_bgcj.bgcj043 = g_bgcj_d[3].num1
            LET l_bgcj.bgcj044 = g_bgcj_d[3].price1
            LET l_bgcj.bgcj045 = g_bgcj_d[4].num1
            LET l_bgcj.bgcj046 = g_bgcj_d[4].price1
            LET l_bgcj.bgcj102 = g_bgcj_d[4].amt1
         WHEN 2
            LET l_bgcj.bgcj041 = g_bgcj_d[2].num2
            LET l_bgcj.bgcj042 = g_bgcj_d[2].price2
            LET l_bgcj.bgcj043 = g_bgcj_d[3].num2
            LET l_bgcj.bgcj044 = g_bgcj_d[3].price2
            LET l_bgcj.bgcj045 = g_bgcj_d[4].num2
            LET l_bgcj.bgcj046 = g_bgcj_d[4].price2
            LET l_bgcj.bgcj102 = g_bgcj_d[4].amt2
         WHEN 3
            LET l_bgcj.bgcj041 = g_bgcj_d[2].num3
            LET l_bgcj.bgcj042 = g_bgcj_d[2].price3
            LET l_bgcj.bgcj043 = g_bgcj_d[3].num3
            LET l_bgcj.bgcj044 = g_bgcj_d[3].price3
            LET l_bgcj.bgcj045 = g_bgcj_d[4].num3
            LET l_bgcj.bgcj046 = g_bgcj_d[4].price3
            LET l_bgcj.bgcj102 = g_bgcj_d[4].amt3
         WHEN 4
            LET l_bgcj.bgcj041 = g_bgcj_d[2].num4
            LET l_bgcj.bgcj042 = g_bgcj_d[2].price4
            LET l_bgcj.bgcj043 = g_bgcj_d[3].num4
            LET l_bgcj.bgcj044 = g_bgcj_d[3].price4
            LET l_bgcj.bgcj045 = g_bgcj_d[4].num4
            LET l_bgcj.bgcj046 = g_bgcj_d[4].price4
            LET l_bgcj.bgcj102 = g_bgcj_d[4].amt4
         WHEN 5
            LET l_bgcj.bgcj041 = g_bgcj_d[2].num5
            LET l_bgcj.bgcj042 = g_bgcj_d[2].price5
            LET l_bgcj.bgcj043 = g_bgcj_d[3].num1
            LET l_bgcj.bgcj044 = g_bgcj_d[3].price5
            LET l_bgcj.bgcj045 = g_bgcj_d[4].num5
            LET l_bgcj.bgcj046 = g_bgcj_d[4].price5
            LET l_bgcj.bgcj102 = g_bgcj_d[4].amt5
         WHEN 6
            LET l_bgcj.bgcj041 = g_bgcj_d[2].num6
            LET l_bgcj.bgcj042 = g_bgcj_d[2].price6
            LET l_bgcj.bgcj043 = g_bgcj_d[3].num6
            LET l_bgcj.bgcj044 = g_bgcj_d[3].price6
            LET l_bgcj.bgcj045 = g_bgcj_d[4].num6
            LET l_bgcj.bgcj046 = g_bgcj_d[4].price6
            LET l_bgcj.bgcj102 = g_bgcj_d[4].amt6
         WHEN 7
            LET l_bgcj.bgcj041 = g_bgcj_d[2].num7
            LET l_bgcj.bgcj042 = g_bgcj_d[2].price7
            LET l_bgcj.bgcj043 = g_bgcj_d[3].num7
            LET l_bgcj.bgcj044 = g_bgcj_d[3].price7
            LET l_bgcj.bgcj045 = g_bgcj_d[4].num7
            LET l_bgcj.bgcj046 = g_bgcj_d[4].price7
            LET l_bgcj.bgcj102 = g_bgcj_d[4].amt7
         WHEN 8
            LET l_bgcj.bgcj041 = g_bgcj_d[2].num8
            LET l_bgcj.bgcj042 = g_bgcj_d[2].price8
            LET l_bgcj.bgcj043 = g_bgcj_d[3].num8
            LET l_bgcj.bgcj044 = g_bgcj_d[3].price8
            LET l_bgcj.bgcj045 = g_bgcj_d[4].num8
            LET l_bgcj.bgcj046 = g_bgcj_d[4].price8
            LET l_bgcj.bgcj102 = g_bgcj_d[4].amt8
         WHEN 9
            LET l_bgcj.bgcj041 = g_bgcj_d[2].num9
            LET l_bgcj.bgcj042 = g_bgcj_d[2].price9
            LET l_bgcj.bgcj043 = g_bgcj_d[3].num9
            LET l_bgcj.bgcj044 = g_bgcj_d[3].price9
            LET l_bgcj.bgcj045 = g_bgcj_d[4].num9
            LET l_bgcj.bgcj046 = g_bgcj_d[4].price9
            LET l_bgcj.bgcj102 = g_bgcj_d[4].amt9
         WHEN 10
            LET l_bgcj.bgcj041 = g_bgcj_d[2].num10
            LET l_bgcj.bgcj042 = g_bgcj_d[2].price10
            LET l_bgcj.bgcj043 = g_bgcj_d[3].num10
            LET l_bgcj.bgcj044 = g_bgcj_d[3].price10
            LET l_bgcj.bgcj045 = g_bgcj_d[4].num10
            LET l_bgcj.bgcj046 = g_bgcj_d[4].price10
            LET l_bgcj.bgcj102 = g_bgcj_d[4].amt10
         WHEN 11
            LET l_bgcj.bgcj041 = g_bgcj_d[2].num11
            LET l_bgcj.bgcj042 = g_bgcj_d[2].price11
            LET l_bgcj.bgcj043 = g_bgcj_d[3].num11
            LET l_bgcj.bgcj044 = g_bgcj_d[3].price11
            LET l_bgcj.bgcj045 = g_bgcj_d[4].num11
            LET l_bgcj.bgcj046 = g_bgcj_d[4].price11
            LET l_bgcj.bgcj102 = g_bgcj_d[4].amt11
         WHEN 12
            LET l_bgcj.bgcj041 = g_bgcj_d[2].num12
            LET l_bgcj.bgcj042 = g_bgcj_d[2].price12
            LET l_bgcj.bgcj043 = g_bgcj_d[3].num12
            LET l_bgcj.bgcj044 = g_bgcj_d[3].price12
            LET l_bgcj.bgcj045 = g_bgcj_d[4].num12
            LET l_bgcj.bgcj046 = g_bgcj_d[4].price12
            LET l_bgcj.bgcj102 = g_bgcj_d[4].amt12
         WHEN 13
            LET l_bgcj.bgcj041 = g_bgcj_d[2].num13
            LET l_bgcj.bgcj042 = g_bgcj_d[2].price13
            LET l_bgcj.bgcj043 = g_bgcj_d[3].num13
            LET l_bgcj.bgcj044 = g_bgcj_d[3].price13
            LET l_bgcj.bgcj045 = g_bgcj_d[4].num13
            LET l_bgcj.bgcj046 = g_bgcj_d[4].price13
            LET l_bgcj.bgcj102 = g_bgcj_d[4].amt13
      END CASE
      #期别销售预算
      IF g_prog = 'abgt340' OR g_prog = 'abgt350' THEN 
         #以稅別計算出來含税金额、未税金额、税额
         SELECT DISTINCT bgcj035,bgcj100,bgcj101 
           INTO l_bgcj.bgcj035,l_bgcj.bgcj100,l_bgcj.bgcj101 
           FROM bgcj_t
          WHERE bgcjent = g_enterprise 
            AND bgcj001 = g_bgcj001_t 
            AND bgcj002 = g_bgcj002_t 
            AND bgcj003 = g_bgcj003_t 
            AND bgcj004 = g_bgcj004_t 
            AND bgcj005 = g_bgcj005_t 
            AND bgcj006 = g_bgcj006_t 
            AND bgcj007 = g_bgcj007_t 
            AND bgcj009 = g_bgcj009_t
            AND bgcj010 = g_bgcj010_t 
            AND bgcjseq = g_bgcjseq_t 
         CALL s_tax_count(g_bgcj007_t,l_bgcj.bgcj035,l_bgcj.bgcj102,l_bgcj.bgcj045,l_bgcj.bgcj100,l_bgcj.bgcj101)
         RETURNING l_bgcj.bgcj103,l_bgcj.bgcj104,l_bgcj.bgcj105,l_bgcj103,l_bgcj104,l_bgcj105
         
         
         UPDATE bgcj_t SET (bgcj041,bgcj042,bgcj043,bgcj044,bgcj045,bgcj046,bgcj102,bgcj103,bgcj104,bgcj105) 
          = (l_bgcj.bgcj041,l_bgcj.bgcj042,l_bgcj.bgcj043,l_bgcj.bgcj044,l_bgcj.bgcj045,
             l_bgcj.bgcj046,l_bgcj.bgcj102,l_bgcj.bgcj103,l_bgcj.bgcj104,l_bgcj.bgcj105)
          WHERE bgcjent = g_enterprise 
            AND bgcj001 = g_bgcj001_t 
            AND bgcj002 = g_bgcj002_t 
            AND bgcj003 = g_bgcj003_t 
            AND bgcj004 = g_bgcj004_t 
            AND bgcj005 = g_bgcj005_t 
            AND bgcj006 = g_bgcj006_t 
            AND bgcj007 = g_bgcj007_t 
            AND bgcj009 = g_bgcj009_t 
            AND bgcj008 = l_bgcj.bgcj008 #期别  
            AND bgcj010 = g_bgcj010_t 
            AND bgcjseq = g_bgcjseq_t 
         IF SQLCA.SQLcode  THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "bgcj_t:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE                  
            CALL cl_err()
            LET r_success = FALSE
            EXIT FOR
         END IF
      END IF
      #期别采购预算
      IF g_prog = 'abgt510' OR g_prog = 'abgt520' THEN
         #以稅別計算出來含税金额、未税金额、税额
         SELECT DISTINCT bgeg035,bgeg100,bgeg101 
           INTO l_bgcj.bgcj035,l_bgcj.bgcj100,l_bgcj.bgcj101 
           FROM bgeg_t
          WHERE bgegent = g_enterprise 
            AND bgeg001 = g_bgcj001_t 
            AND bgeg002 = g_bgcj002_t 
            AND bgeg003 = g_bgcj003_t 
            AND bgeg004 = g_bgcj004_t 
            AND bgeg005 = g_bgcj005_t 
            AND bgeg006 = g_bgcj006_t 
            AND bgeg007 = g_bgcj007_t 
            AND bgeg009 = g_bgcj009_t
            AND bgeg010 = g_bgcj010_t 
            AND bgegseq = g_bgcjseq_t 
         CALL s_tax_count(g_bgcj007_t,l_bgcj.bgcj035,l_bgcj.bgcj102,l_bgcj.bgcj045,l_bgcj.bgcj100,l_bgcj.bgcj101)
         RETURNING l_bgcj.bgcj103,l_bgcj.bgcj104,l_bgcj.bgcj105,l_bgcj103,l_bgcj104,l_bgcj105
         
         
         UPDATE bgeg_t SET (bgeg041,bgeg042,bgeg043,bgeg044,bgeg045,bgeg046,bgeg102,bgeg103,bgeg104,bgeg105) 
          = (l_bgcj.bgcj041,l_bgcj.bgcj042,l_bgcj.bgcj043,l_bgcj.bgcj044,l_bgcj.bgcj045,
             l_bgcj.bgcj046,l_bgcj.bgcj102,l_bgcj.bgcj103,l_bgcj.bgcj104,l_bgcj.bgcj105)
          WHERE bgegent = g_enterprise 
            AND bgeg001 = g_bgcj001_t 
            AND bgeg002 = g_bgcj002_t 
            AND bgeg003 = g_bgcj003_t 
            AND bgeg004 = g_bgcj004_t 
            AND bgeg005 = g_bgcj005_t 
            AND bgeg006 = g_bgcj006_t 
            AND bgeg007 = g_bgcj007_t 
            AND bgeg009 = g_bgcj009_t 
            AND bgeg008 = l_bgcj.bgcj008 #期别  
            AND bgeg010 = g_bgcj010_t 
            AND bgegseq = g_bgcjseq_t 
         IF SQLCA.SQLcode  THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "bgeg_t:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE                  
            CALL cl_err()
            LET r_success = FALSE
            EXIT FOR
         END IF
      END IF
      
   END FOR
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: pk_array内容
# Memo...........:
# Usage..........: CALL abgt340_01_set_pk_array()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/11/10 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt340_01_set_pk_array()
   #若l_ac<=0代表沒有資料
   IF l_ac <= 0 THEN
      RETURN
   END IF
   
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_bgcj_d[l_ac].bgcj001
   LET g_pk_array[1].column = 'bgcj001'
   LET g_pk_array[2].values = g_bgcj_d[l_ac].bgcj002
   LET g_pk_array[2].column = 'bgcj002'
   LET g_pk_array[3].values = g_bgcj_d[l_ac].bgcj003
   LET g_pk_array[3].column = 'bgcj003'
   LET g_pk_array[4].values = g_bgcj_d[l_ac].bgcj004
   LET g_pk_array[4].column = 'bgcj004'
   LET g_pk_array[5].values = g_bgcj_d[l_ac].bgcj005
   LET g_pk_array[5].column = 'bgcj005'
   LET g_pk_array[6].values = g_bgcj_d[l_ac].bgcj006
   LET g_pk_array[6].column = 'bgcj006'
   LET g_pk_array[7].values = g_bgcj_d[l_ac].bgcj007
   LET g_pk_array[7].column = 'bgcj007'
   LET g_pk_array[8].values = g_bgcj_d[l_ac].bgcj009
   LET g_pk_array[8].column = 'bgcj009'
   LET g_pk_array[9].values = g_bgcj_d[l_ac].bgcj010
   LET g_pk_array[9].column = 'bgcj010'
   LET g_pk_array[10].values = g_bgcj_d[l_ac].bgcjseq
   LET g_pk_array[10].column = 'bgcjseq'
END FUNCTION

################################################################################
# Descriptions...: 调整修改
# Memo...........:
# Usage..........: CALL abgt340_01_modify()
# Input parameter: 
# Return code....:
# Date & Author..: 2016/11/10 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt340_01_modify()
   DEFINE l_ac_t                  LIKE type_t.num10       #未取消的ARRAY CNT 
   DEFINE l_allow_insert          LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete          LIKE type_t.num5        #可刪除否  
   DEFINE l_count                 LIKE type_t.num10
   DEFINE l_insert                LIKE type_t.num5
   DEFINE l_cmd                   LIKE type_t.chr5
   DEFINE l_row                   LIKE type_t.num5
   DEFINE l_num                   LIKE bgcj_t.bgcj038
   DEFINE l_price                 LIKE bgcj_t.bgcj039
   DEFINE l_amt                   LIKE bgcj_t.bgcj040
   DEFINE l_amt_t                 LIKE bgcj_t.bgcj040
   DEFINE l_success               LIKE type_t.num5
   
   
   #本层调整
   IF g_type = 1 THEN 
      LET l_row = 2
   ELSE
   #上层调整
      LET l_row = 3
   END IF
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT ARRAY g_bgcj_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
         
         #自訂ACTION
         #add-point:單身前置處理

         #end add-point
         
         #自訂ACTION(detail_input)
         
         
         BEFORE INPUT
            #add-point:單身輸入前處理
            CALL DIALOG.setCurrentRow("s_detail1",l_row)
            
         BEFORE ROW 
            CALL DIALOG.setCurrentRow("s_detail1",l_row)
            LET l_ac = l_row
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            
            CALL s_transaction_begin()
            LET l_cmd = 'u'
            LET g_bgcj_d_t.* = g_bgcj_d[l_ac].*
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj001
            #add-point:BEFORE FIELD bgcj001 name="input.b.page1.bgcj001"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj001
            
            #add-point:AFTER FIELD bgcj001 name="input.a.page1.bgcj001"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_bgcj_d[g_detail_idx].bgcj001 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj002 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj003 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj004 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj005 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj006 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj007 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj008 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj009 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj010 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcjseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_bgcj_d[g_detail_idx].bgcj001 != g_bgcj_d_t.bgcj001 OR g_bgcj_d[g_detail_idx].bgcj002 != g_bgcj_d_t.bgcj002 OR g_bgcj_d[g_detail_idx].bgcj003 != g_bgcj_d_t.bgcj003 OR g_bgcj_d[g_detail_idx].bgcj004 != g_bgcj_d_t.bgcj004 OR g_bgcj_d[g_detail_idx].bgcj005 != g_bgcj_d_t.bgcj005 OR g_bgcj_d[g_detail_idx].bgcj006 != g_bgcj_d_t.bgcj006 OR g_bgcj_d[g_detail_idx].bgcj007 != g_bgcj_d_t.bgcj007 OR g_bgcj_d[g_detail_idx].bgcj008 != g_bgcj_d_t.bgcj008 OR g_bgcj_d[g_detail_idx].bgcj009 != g_bgcj_d_t.bgcj009 OR g_bgcj_d[g_detail_idx].bgcj010 != g_bgcj_d_t.bgcj010 OR g_bgcj_d[g_detail_idx].bgcjseq != g_bgcj_d_t.bgcjseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bgcj_t WHERE "||"bgcjent = " ||g_enterprise|| " AND "||"bgcj001 = '"||g_bgcj_d[g_detail_idx].bgcj001 ||"' AND "|| "bgcj002 = '"||g_bgcj_d[g_detail_idx].bgcj002 ||"' AND "|| "bgcj003 = '"||g_bgcj_d[g_detail_idx].bgcj003 ||"' AND "|| "bgcj004 = '"||g_bgcj_d[g_detail_idx].bgcj004 ||"' AND "|| "bgcj005 = '"||g_bgcj_d[g_detail_idx].bgcj005 ||"' AND "|| "bgcj006 = '"||g_bgcj_d[g_detail_idx].bgcj006 ||"' AND "|| "bgcj007 = '"||g_bgcj_d[g_detail_idx].bgcj007 ||"' AND "|| "bgcj008 = '"||g_bgcj_d[g_detail_idx].bgcj008 ||"' AND "|| "bgcj009 = '"||g_bgcj_d[g_detail_idx].bgcj009 ||"' AND "|| "bgcj010 = '"||g_bgcj_d[g_detail_idx].bgcj010 ||"' AND "|| "bgcjseq = '"||g_bgcj_d[g_detail_idx].bgcjseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj001
            #add-point:ON CHANGE bgcj001 name="input.g.page1.bgcj001"

            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj002
            
            #add-point:AFTER FIELD bgcj002 name="input.a.page1.bgcj002"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_bgcj_d[g_detail_idx].bgcj001 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj002 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj003 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj004 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj005 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj006 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj007 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj008 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj009 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj010 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcjseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_bgcj_d[g_detail_idx].bgcj001 != g_bgcj_d_t.bgcj001 OR g_bgcj_d[g_detail_idx].bgcj002 != g_bgcj_d_t.bgcj002 OR g_bgcj_d[g_detail_idx].bgcj003 != g_bgcj_d_t.bgcj003 OR g_bgcj_d[g_detail_idx].bgcj004 != g_bgcj_d_t.bgcj004 OR g_bgcj_d[g_detail_idx].bgcj005 != g_bgcj_d_t.bgcj005 OR g_bgcj_d[g_detail_idx].bgcj006 != g_bgcj_d_t.bgcj006 OR g_bgcj_d[g_detail_idx].bgcj007 != g_bgcj_d_t.bgcj007 OR g_bgcj_d[g_detail_idx].bgcj008 != g_bgcj_d_t.bgcj008 OR g_bgcj_d[g_detail_idx].bgcj009 != g_bgcj_d_t.bgcj009 OR g_bgcj_d[g_detail_idx].bgcj010 != g_bgcj_d_t.bgcj010 OR g_bgcj_d[g_detail_idx].bgcjseq != g_bgcj_d_t.bgcjseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bgcj_t WHERE "||"bgcjent = " ||g_enterprise|| " AND "||"bgcj001 = '"||g_bgcj_d[g_detail_idx].bgcj001 ||"' AND "|| "bgcj002 = '"||g_bgcj_d[g_detail_idx].bgcj002 ||"' AND "|| "bgcj003 = '"||g_bgcj_d[g_detail_idx].bgcj003 ||"' AND "|| "bgcj004 = '"||g_bgcj_d[g_detail_idx].bgcj004 ||"' AND "|| "bgcj005 = '"||g_bgcj_d[g_detail_idx].bgcj005 ||"' AND "|| "bgcj006 = '"||g_bgcj_d[g_detail_idx].bgcj006 ||"' AND "|| "bgcj007 = '"||g_bgcj_d[g_detail_idx].bgcj007 ||"' AND "|| "bgcj008 = '"||g_bgcj_d[g_detail_idx].bgcj008 ||"' AND "|| "bgcj009 = '"||g_bgcj_d[g_detail_idx].bgcj009 ||"' AND "|| "bgcj010 = '"||g_bgcj_d[g_detail_idx].bgcj010 ||"' AND "|| "bgcjseq = '"||g_bgcj_d[g_detail_idx].bgcjseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            IF NOT cl_null(g_bgcj_d[l_ac].bgcj002) THEN 
#應用 a17 樣板自動產生(Version:3)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
 
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_bgcj_d[l_ac].bgcj002

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_bgaa001") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
 


            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bgcj_d[l_ac].bgcj002
            CALL ap_ref_array2(g_ref_fields,"SELECT bgaal003 FROM bgaal_t WHERE bgaalent="||g_enterprise||" AND bgaal001=? AND bgaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bgcj_d[l_ac].bgcj002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bgcj_d[l_ac].bgcj002_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj002
            #add-point:BEFORE FIELD bgcj002 name="input.b.page1.bgcj002"

            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj002
            #add-point:ON CHANGE bgcj002 name="input.g.page1.bgcj002"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj003
            #add-point:BEFORE FIELD bgcj003 name="input.b.page1.bgcj003"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj003
            
            #add-point:AFTER FIELD bgcj003 name="input.a.page1.bgcj003"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_bgcj_d[g_detail_idx].bgcj001 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj002 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj003 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj004 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj005 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj006 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj007 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj008 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj009 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj010 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcjseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_bgcj_d[g_detail_idx].bgcj001 != g_bgcj_d_t.bgcj001 OR g_bgcj_d[g_detail_idx].bgcj002 != g_bgcj_d_t.bgcj002 OR g_bgcj_d[g_detail_idx].bgcj003 != g_bgcj_d_t.bgcj003 OR g_bgcj_d[g_detail_idx].bgcj004 != g_bgcj_d_t.bgcj004 OR g_bgcj_d[g_detail_idx].bgcj005 != g_bgcj_d_t.bgcj005 OR g_bgcj_d[g_detail_idx].bgcj006 != g_bgcj_d_t.bgcj006 OR g_bgcj_d[g_detail_idx].bgcj007 != g_bgcj_d_t.bgcj007 OR g_bgcj_d[g_detail_idx].bgcj008 != g_bgcj_d_t.bgcj008 OR g_bgcj_d[g_detail_idx].bgcj009 != g_bgcj_d_t.bgcj009 OR g_bgcj_d[g_detail_idx].bgcj010 != g_bgcj_d_t.bgcj010 OR g_bgcj_d[g_detail_idx].bgcjseq != g_bgcj_d_t.bgcjseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bgcj_t WHERE "||"bgcjent = " ||g_enterprise|| " AND "||"bgcj001 = '"||g_bgcj_d[g_detail_idx].bgcj001 ||"' AND "|| "bgcj002 = '"||g_bgcj_d[g_detail_idx].bgcj002 ||"' AND "|| "bgcj003 = '"||g_bgcj_d[g_detail_idx].bgcj003 ||"' AND "|| "bgcj004 = '"||g_bgcj_d[g_detail_idx].bgcj004 ||"' AND "|| "bgcj005 = '"||g_bgcj_d[g_detail_idx].bgcj005 ||"' AND "|| "bgcj006 = '"||g_bgcj_d[g_detail_idx].bgcj006 ||"' AND "|| "bgcj007 = '"||g_bgcj_d[g_detail_idx].bgcj007 ||"' AND "|| "bgcj008 = '"||g_bgcj_d[g_detail_idx].bgcj008 ||"' AND "|| "bgcj009 = '"||g_bgcj_d[g_detail_idx].bgcj009 ||"' AND "|| "bgcj010 = '"||g_bgcj_d[g_detail_idx].bgcj010 ||"' AND "|| "bgcjseq = '"||g_bgcj_d[g_detail_idx].bgcjseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj003
            #add-point:ON CHANGE bgcj003 name="input.g.page1.bgcj003"

            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj004
            
            #add-point:AFTER FIELD bgcj004 name="input.a.page1.bgcj004"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_bgcj_d[g_detail_idx].bgcj001 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj002 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj003 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj004 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj005 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj006 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj007 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj008 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj009 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj010 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcjseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_bgcj_d[g_detail_idx].bgcj001 != g_bgcj_d_t.bgcj001 OR g_bgcj_d[g_detail_idx].bgcj002 != g_bgcj_d_t.bgcj002 OR g_bgcj_d[g_detail_idx].bgcj003 != g_bgcj_d_t.bgcj003 OR g_bgcj_d[g_detail_idx].bgcj004 != g_bgcj_d_t.bgcj004 OR g_bgcj_d[g_detail_idx].bgcj005 != g_bgcj_d_t.bgcj005 OR g_bgcj_d[g_detail_idx].bgcj006 != g_bgcj_d_t.bgcj006 OR g_bgcj_d[g_detail_idx].bgcj007 != g_bgcj_d_t.bgcj007 OR g_bgcj_d[g_detail_idx].bgcj008 != g_bgcj_d_t.bgcj008 OR g_bgcj_d[g_detail_idx].bgcj009 != g_bgcj_d_t.bgcj009 OR g_bgcj_d[g_detail_idx].bgcj010 != g_bgcj_d_t.bgcj010 OR g_bgcj_d[g_detail_idx].bgcjseq != g_bgcj_d_t.bgcjseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bgcj_t WHERE "||"bgcjent = " ||g_enterprise|| " AND "||"bgcj001 = '"||g_bgcj_d[g_detail_idx].bgcj001 ||"' AND "|| "bgcj002 = '"||g_bgcj_d[g_detail_idx].bgcj002 ||"' AND "|| "bgcj003 = '"||g_bgcj_d[g_detail_idx].bgcj003 ||"' AND "|| "bgcj004 = '"||g_bgcj_d[g_detail_idx].bgcj004 ||"' AND "|| "bgcj005 = '"||g_bgcj_d[g_detail_idx].bgcj005 ||"' AND "|| "bgcj006 = '"||g_bgcj_d[g_detail_idx].bgcj006 ||"' AND "|| "bgcj007 = '"||g_bgcj_d[g_detail_idx].bgcj007 ||"' AND "|| "bgcj008 = '"||g_bgcj_d[g_detail_idx].bgcj008 ||"' AND "|| "bgcj009 = '"||g_bgcj_d[g_detail_idx].bgcj009 ||"' AND "|| "bgcj010 = '"||g_bgcj_d[g_detail_idx].bgcj010 ||"' AND "|| "bgcjseq = '"||g_bgcj_d[g_detail_idx].bgcjseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bgcj_d[l_ac].bgcj002
            LET g_ref_fields[2] = g_bgcj_d[l_ac].bgcj004
            CALL ap_ref_array2(g_ref_fields,"SELECT bgail004 FROM bgail_t WHERE bgailent="||g_enterprise||" AND bgail001=? AND bgail002=? AND bgail003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bgcj_d[l_ac].bgcj004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bgcj_d[l_ac].bgcj004_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj004
            #add-point:BEFORE FIELD bgcj004 name="input.b.page1.bgcj004"

            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj004
            #add-point:ON CHANGE bgcj004 name="input.g.page1.bgcj004"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj005
            #add-point:BEFORE FIELD bgcj005 name="input.b.page1.bgcj005"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj005
            
            #add-point:AFTER FIELD bgcj005 name="input.a.page1.bgcj005"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_bgcj_d[g_detail_idx].bgcj001 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj002 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj003 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj004 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj005 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj006 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj007 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj008 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj009 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj010 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcjseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_bgcj_d[g_detail_idx].bgcj001 != g_bgcj_d_t.bgcj001 OR g_bgcj_d[g_detail_idx].bgcj002 != g_bgcj_d_t.bgcj002 OR g_bgcj_d[g_detail_idx].bgcj003 != g_bgcj_d_t.bgcj003 OR g_bgcj_d[g_detail_idx].bgcj004 != g_bgcj_d_t.bgcj004 OR g_bgcj_d[g_detail_idx].bgcj005 != g_bgcj_d_t.bgcj005 OR g_bgcj_d[g_detail_idx].bgcj006 != g_bgcj_d_t.bgcj006 OR g_bgcj_d[g_detail_idx].bgcj007 != g_bgcj_d_t.bgcj007 OR g_bgcj_d[g_detail_idx].bgcj008 != g_bgcj_d_t.bgcj008 OR g_bgcj_d[g_detail_idx].bgcj009 != g_bgcj_d_t.bgcj009 OR g_bgcj_d[g_detail_idx].bgcj010 != g_bgcj_d_t.bgcj010 OR g_bgcj_d[g_detail_idx].bgcjseq != g_bgcj_d_t.bgcjseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bgcj_t WHERE "||"bgcjent = " ||g_enterprise|| " AND "||"bgcj001 = '"||g_bgcj_d[g_detail_idx].bgcj001 ||"' AND "|| "bgcj002 = '"||g_bgcj_d[g_detail_idx].bgcj002 ||"' AND "|| "bgcj003 = '"||g_bgcj_d[g_detail_idx].bgcj003 ||"' AND "|| "bgcj004 = '"||g_bgcj_d[g_detail_idx].bgcj004 ||"' AND "|| "bgcj005 = '"||g_bgcj_d[g_detail_idx].bgcj005 ||"' AND "|| "bgcj006 = '"||g_bgcj_d[g_detail_idx].bgcj006 ||"' AND "|| "bgcj007 = '"||g_bgcj_d[g_detail_idx].bgcj007 ||"' AND "|| "bgcj008 = '"||g_bgcj_d[g_detail_idx].bgcj008 ||"' AND "|| "bgcj009 = '"||g_bgcj_d[g_detail_idx].bgcj009 ||"' AND "|| "bgcj010 = '"||g_bgcj_d[g_detail_idx].bgcj010 ||"' AND "|| "bgcjseq = '"||g_bgcj_d[g_detail_idx].bgcjseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj005
            #add-point:ON CHANGE bgcj005 name="input.g.page1.bgcj005"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj006
            #add-point:BEFORE FIELD bgcj006 name="input.b.page1.bgcj006"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj006
            
            #add-point:AFTER FIELD bgcj006 name="input.a.page1.bgcj006"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_bgcj_d[g_detail_idx].bgcj001 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj002 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj003 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj004 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj005 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj006 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj007 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj008 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj009 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj010 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcjseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_bgcj_d[g_detail_idx].bgcj001 != g_bgcj_d_t.bgcj001 OR g_bgcj_d[g_detail_idx].bgcj002 != g_bgcj_d_t.bgcj002 OR g_bgcj_d[g_detail_idx].bgcj003 != g_bgcj_d_t.bgcj003 OR g_bgcj_d[g_detail_idx].bgcj004 != g_bgcj_d_t.bgcj004 OR g_bgcj_d[g_detail_idx].bgcj005 != g_bgcj_d_t.bgcj005 OR g_bgcj_d[g_detail_idx].bgcj006 != g_bgcj_d_t.bgcj006 OR g_bgcj_d[g_detail_idx].bgcj007 != g_bgcj_d_t.bgcj007 OR g_bgcj_d[g_detail_idx].bgcj008 != g_bgcj_d_t.bgcj008 OR g_bgcj_d[g_detail_idx].bgcj009 != g_bgcj_d_t.bgcj009 OR g_bgcj_d[g_detail_idx].bgcj010 != g_bgcj_d_t.bgcj010 OR g_bgcj_d[g_detail_idx].bgcjseq != g_bgcj_d_t.bgcjseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bgcj_t WHERE "||"bgcjent = " ||g_enterprise|| " AND "||"bgcj001 = '"||g_bgcj_d[g_detail_idx].bgcj001 ||"' AND "|| "bgcj002 = '"||g_bgcj_d[g_detail_idx].bgcj002 ||"' AND "|| "bgcj003 = '"||g_bgcj_d[g_detail_idx].bgcj003 ||"' AND "|| "bgcj004 = '"||g_bgcj_d[g_detail_idx].bgcj004 ||"' AND "|| "bgcj005 = '"||g_bgcj_d[g_detail_idx].bgcj005 ||"' AND "|| "bgcj006 = '"||g_bgcj_d[g_detail_idx].bgcj006 ||"' AND "|| "bgcj007 = '"||g_bgcj_d[g_detail_idx].bgcj007 ||"' AND "|| "bgcj008 = '"||g_bgcj_d[g_detail_idx].bgcj008 ||"' AND "|| "bgcj009 = '"||g_bgcj_d[g_detail_idx].bgcj009 ||"' AND "|| "bgcj010 = '"||g_bgcj_d[g_detail_idx].bgcj010 ||"' AND "|| "bgcjseq = '"||g_bgcj_d[g_detail_idx].bgcjseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj006
            #add-point:ON CHANGE bgcj006 name="input.g.page1.bgcj006"

            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj007
            
            #add-point:AFTER FIELD bgcj007 name="input.a.page1.bgcj007"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_bgcj_d[g_detail_idx].bgcj001 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj002 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj003 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj004 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj005 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj006 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj007 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj008 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj009 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj010 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcjseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_bgcj_d[g_detail_idx].bgcj001 != g_bgcj_d_t.bgcj001 OR g_bgcj_d[g_detail_idx].bgcj002 != g_bgcj_d_t.bgcj002 OR g_bgcj_d[g_detail_idx].bgcj003 != g_bgcj_d_t.bgcj003 OR g_bgcj_d[g_detail_idx].bgcj004 != g_bgcj_d_t.bgcj004 OR g_bgcj_d[g_detail_idx].bgcj005 != g_bgcj_d_t.bgcj005 OR g_bgcj_d[g_detail_idx].bgcj006 != g_bgcj_d_t.bgcj006 OR g_bgcj_d[g_detail_idx].bgcj007 != g_bgcj_d_t.bgcj007 OR g_bgcj_d[g_detail_idx].bgcj008 != g_bgcj_d_t.bgcj008 OR g_bgcj_d[g_detail_idx].bgcj009 != g_bgcj_d_t.bgcj009 OR g_bgcj_d[g_detail_idx].bgcj010 != g_bgcj_d_t.bgcj010 OR g_bgcj_d[g_detail_idx].bgcjseq != g_bgcj_d_t.bgcjseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bgcj_t WHERE "||"bgcjent = " ||g_enterprise|| " AND "||"bgcj001 = '"||g_bgcj_d[g_detail_idx].bgcj001 ||"' AND "|| "bgcj002 = '"||g_bgcj_d[g_detail_idx].bgcj002 ||"' AND "|| "bgcj003 = '"||g_bgcj_d[g_detail_idx].bgcj003 ||"' AND "|| "bgcj004 = '"||g_bgcj_d[g_detail_idx].bgcj004 ||"' AND "|| "bgcj005 = '"||g_bgcj_d[g_detail_idx].bgcj005 ||"' AND "|| "bgcj006 = '"||g_bgcj_d[g_detail_idx].bgcj006 ||"' AND "|| "bgcj007 = '"||g_bgcj_d[g_detail_idx].bgcj007 ||"' AND "|| "bgcj008 = '"||g_bgcj_d[g_detail_idx].bgcj008 ||"' AND "|| "bgcj009 = '"||g_bgcj_d[g_detail_idx].bgcj009 ||"' AND "|| "bgcj010 = '"||g_bgcj_d[g_detail_idx].bgcj010 ||"' AND "|| "bgcjseq = '"||g_bgcj_d[g_detail_idx].bgcjseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bgcj_d[l_ac].bgcj007
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent="||g_enterprise||" AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bgcj_d[l_ac].bgcj007_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bgcj_d[l_ac].bgcj007_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj007
            #add-point:BEFORE FIELD bgcj007 name="input.b.page1.bgcj007"

            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj007
            #add-point:ON CHANGE bgcj007 name="input.g.page1.bgcj007"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj009
            #add-point:BEFORE FIELD bgcj009 name="input.b.page1.bgcj009"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj009
            
            #add-point:AFTER FIELD bgcj009 name="input.a.page1.bgcj009"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_bgcj_d[g_detail_idx].bgcj001 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj002 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj003 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj004 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj005 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj006 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj007 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj008 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj009 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj010 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcjseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_bgcj_d[g_detail_idx].bgcj001 != g_bgcj_d_t.bgcj001 OR g_bgcj_d[g_detail_idx].bgcj002 != g_bgcj_d_t.bgcj002 OR g_bgcj_d[g_detail_idx].bgcj003 != g_bgcj_d_t.bgcj003 OR g_bgcj_d[g_detail_idx].bgcj004 != g_bgcj_d_t.bgcj004 OR g_bgcj_d[g_detail_idx].bgcj005 != g_bgcj_d_t.bgcj005 OR g_bgcj_d[g_detail_idx].bgcj006 != g_bgcj_d_t.bgcj006 OR g_bgcj_d[g_detail_idx].bgcj007 != g_bgcj_d_t.bgcj007 OR g_bgcj_d[g_detail_idx].bgcj008 != g_bgcj_d_t.bgcj008 OR g_bgcj_d[g_detail_idx].bgcj009 != g_bgcj_d_t.bgcj009 OR g_bgcj_d[g_detail_idx].bgcj010 != g_bgcj_d_t.bgcj010 OR g_bgcj_d[g_detail_idx].bgcjseq != g_bgcj_d_t.bgcjseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bgcj_t WHERE "||"bgcjent = " ||g_enterprise|| " AND "||"bgcj001 = '"||g_bgcj_d[g_detail_idx].bgcj001 ||"' AND "|| "bgcj002 = '"||g_bgcj_d[g_detail_idx].bgcj002 ||"' AND "|| "bgcj003 = '"||g_bgcj_d[g_detail_idx].bgcj003 ||"' AND "|| "bgcj004 = '"||g_bgcj_d[g_detail_idx].bgcj004 ||"' AND "|| "bgcj005 = '"||g_bgcj_d[g_detail_idx].bgcj005 ||"' AND "|| "bgcj006 = '"||g_bgcj_d[g_detail_idx].bgcj006 ||"' AND "|| "bgcj007 = '"||g_bgcj_d[g_detail_idx].bgcj007 ||"' AND "|| "bgcj008 = '"||g_bgcj_d[g_detail_idx].bgcj008 ||"' AND "|| "bgcj009 = '"||g_bgcj_d[g_detail_idx].bgcj009 ||"' AND "|| "bgcj010 = '"||g_bgcj_d[g_detail_idx].bgcj010 ||"' AND "|| "bgcjseq = '"||g_bgcj_d[g_detail_idx].bgcjseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj009
            #add-point:ON CHANGE bgcj009 name="input.g.page1.bgcj009"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj010
            #add-point:BEFORE FIELD bgcj010 name="input.b.page1.bgcj010"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj010
            
            #add-point:AFTER FIELD bgcj010 name="input.a.page1.bgcj010"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_bgcj_d[g_detail_idx].bgcj001 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj002 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj003 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj004 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj005 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj006 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj007 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj008 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj009 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj010 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcjseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_bgcj_d[g_detail_idx].bgcj001 != g_bgcj_d_t.bgcj001 OR g_bgcj_d[g_detail_idx].bgcj002 != g_bgcj_d_t.bgcj002 OR g_bgcj_d[g_detail_idx].bgcj003 != g_bgcj_d_t.bgcj003 OR g_bgcj_d[g_detail_idx].bgcj004 != g_bgcj_d_t.bgcj004 OR g_bgcj_d[g_detail_idx].bgcj005 != g_bgcj_d_t.bgcj005 OR g_bgcj_d[g_detail_idx].bgcj006 != g_bgcj_d_t.bgcj006 OR g_bgcj_d[g_detail_idx].bgcj007 != g_bgcj_d_t.bgcj007 OR g_bgcj_d[g_detail_idx].bgcj008 != g_bgcj_d_t.bgcj008 OR g_bgcj_d[g_detail_idx].bgcj009 != g_bgcj_d_t.bgcj009 OR g_bgcj_d[g_detail_idx].bgcj010 != g_bgcj_d_t.bgcj010 OR g_bgcj_d[g_detail_idx].bgcjseq != g_bgcj_d_t.bgcjseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bgcj_t WHERE "||"bgcjent = " ||g_enterprise|| " AND "||"bgcj001 = '"||g_bgcj_d[g_detail_idx].bgcj001 ||"' AND "|| "bgcj002 = '"||g_bgcj_d[g_detail_idx].bgcj002 ||"' AND "|| "bgcj003 = '"||g_bgcj_d[g_detail_idx].bgcj003 ||"' AND "|| "bgcj004 = '"||g_bgcj_d[g_detail_idx].bgcj004 ||"' AND "|| "bgcj005 = '"||g_bgcj_d[g_detail_idx].bgcj005 ||"' AND "|| "bgcj006 = '"||g_bgcj_d[g_detail_idx].bgcj006 ||"' AND "|| "bgcj007 = '"||g_bgcj_d[g_detail_idx].bgcj007 ||"' AND "|| "bgcj008 = '"||g_bgcj_d[g_detail_idx].bgcj008 ||"' AND "|| "bgcj009 = '"||g_bgcj_d[g_detail_idx].bgcj009 ||"' AND "|| "bgcj010 = '"||g_bgcj_d[g_detail_idx].bgcj010 ||"' AND "|| "bgcjseq = '"||g_bgcj_d[g_detail_idx].bgcjseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj010
            #add-point:ON CHANGE bgcj010 name="input.g.page1.bgcj010"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcjseq
            #add-point:BEFORE FIELD bgcjseq name="input.b.page1.bgcjseq"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcjseq
            
            #add-point:AFTER FIELD bgcjseq name="input.a.page1.bgcjseq"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_bgcj_d[g_detail_idx].bgcj001 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj002 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj003 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj004 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj005 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj006 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj007 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj008 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj009 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj010 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcjseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_bgcj_d[g_detail_idx].bgcj001 != g_bgcj_d_t.bgcj001 OR g_bgcj_d[g_detail_idx].bgcj002 != g_bgcj_d_t.bgcj002 OR g_bgcj_d[g_detail_idx].bgcj003 != g_bgcj_d_t.bgcj003 OR g_bgcj_d[g_detail_idx].bgcj004 != g_bgcj_d_t.bgcj004 OR g_bgcj_d[g_detail_idx].bgcj005 != g_bgcj_d_t.bgcj005 OR g_bgcj_d[g_detail_idx].bgcj006 != g_bgcj_d_t.bgcj006 OR g_bgcj_d[g_detail_idx].bgcj007 != g_bgcj_d_t.bgcj007 OR g_bgcj_d[g_detail_idx].bgcj008 != g_bgcj_d_t.bgcj008 OR g_bgcj_d[g_detail_idx].bgcj009 != g_bgcj_d_t.bgcj009 OR g_bgcj_d[g_detail_idx].bgcj010 != g_bgcj_d_t.bgcj010 OR g_bgcj_d[g_detail_idx].bgcjseq != g_bgcj_d_t.bgcjseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bgcj_t WHERE "||"bgcjent = " ||g_enterprise|| " AND "||"bgcj001 = '"||g_bgcj_d[g_detail_idx].bgcj001 ||"' AND "|| "bgcj002 = '"||g_bgcj_d[g_detail_idx].bgcj002 ||"' AND "|| "bgcj003 = '"||g_bgcj_d[g_detail_idx].bgcj003 ||"' AND "|| "bgcj004 = '"||g_bgcj_d[g_detail_idx].bgcj004 ||"' AND "|| "bgcj005 = '"||g_bgcj_d[g_detail_idx].bgcj005 ||"' AND "|| "bgcj006 = '"||g_bgcj_d[g_detail_idx].bgcj006 ||"' AND "|| "bgcj007 = '"||g_bgcj_d[g_detail_idx].bgcj007 ||"' AND "|| "bgcj008 = '"||g_bgcj_d[g_detail_idx].bgcj008 ||"' AND "|| "bgcj009 = '"||g_bgcj_d[g_detail_idx].bgcj009 ||"' AND "|| "bgcj010 = '"||g_bgcj_d[g_detail_idx].bgcj010 ||"' AND "|| "bgcjseq = '"||g_bgcj_d[g_detail_idx].bgcjseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcjseq
            #add-point:ON CHANGE bgcjseq name="input.g.page1.bgcjseq"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj008
            #add-point:BEFORE FIELD bgcj008 name="input.b.page1.bgcj008"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj008
            
            #add-point:AFTER FIELD bgcj008 name="input.a.page1.bgcj008"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_bgcj_d[g_detail_idx].bgcj001 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj002 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj003 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj004 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj005 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj006 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj007 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj008 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj009 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcj010 IS NOT NULL AND g_bgcj_d[g_detail_idx].bgcjseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_bgcj_d[g_detail_idx].bgcj001 != g_bgcj_d_t.bgcj001 OR g_bgcj_d[g_detail_idx].bgcj002 != g_bgcj_d_t.bgcj002 OR g_bgcj_d[g_detail_idx].bgcj003 != g_bgcj_d_t.bgcj003 OR g_bgcj_d[g_detail_idx].bgcj004 != g_bgcj_d_t.bgcj004 OR g_bgcj_d[g_detail_idx].bgcj005 != g_bgcj_d_t.bgcj005 OR g_bgcj_d[g_detail_idx].bgcj006 != g_bgcj_d_t.bgcj006 OR g_bgcj_d[g_detail_idx].bgcj007 != g_bgcj_d_t.bgcj007 OR g_bgcj_d[g_detail_idx].bgcj008 != g_bgcj_d_t.bgcj008 OR g_bgcj_d[g_detail_idx].bgcj009 != g_bgcj_d_t.bgcj009 OR g_bgcj_d[g_detail_idx].bgcj010 != g_bgcj_d_t.bgcj010 OR g_bgcj_d[g_detail_idx].bgcjseq != g_bgcj_d_t.bgcjseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bgcj_t WHERE "||"bgcjent = " ||g_enterprise|| " AND "||"bgcj001 = '"||g_bgcj_d[g_detail_idx].bgcj001 ||"' AND "|| "bgcj002 = '"||g_bgcj_d[g_detail_idx].bgcj002 ||"' AND "|| "bgcj003 = '"||g_bgcj_d[g_detail_idx].bgcj003 ||"' AND "|| "bgcj004 = '"||g_bgcj_d[g_detail_idx].bgcj004 ||"' AND "|| "bgcj005 = '"||g_bgcj_d[g_detail_idx].bgcj005 ||"' AND "|| "bgcj006 = '"||g_bgcj_d[g_detail_idx].bgcj006 ||"' AND "|| "bgcj007 = '"||g_bgcj_d[g_detail_idx].bgcj007 ||"' AND "|| "bgcj008 = '"||g_bgcj_d[g_detail_idx].bgcj008 ||"' AND "|| "bgcj009 = '"||g_bgcj_d[g_detail_idx].bgcj009 ||"' AND "|| "bgcj010 = '"||g_bgcj_d[g_detail_idx].bgcj010 ||"' AND "|| "bgcjseq = '"||g_bgcj_d[g_detail_idx].bgcjseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj008
            #add-point:ON CHANGE bgcj008 name="input.g.page1.bgcj008"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD num1
            #add-point:BEFORE FIELD num1 name="input.b.page1.num1"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD num1
            
            #add-point:AFTER FIELD num1 name="input.a.page1.num1"
            IF cl_null(g_bgcj_d[l_ac].num1) THEN
               LET g_bgcj_d[l_ac].num1 =0 
            END IF
            
            LET l_num = g_bgcj_d[1].num1 + g_bgcj_d[2].num1 + g_bgcj_d[3].num1
            IF l_num < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'abg-00213'
               LET g_errparam.extend = g_bgcj_d[l_ac].num1
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_bgcj_d[l_ac].num1 = g_bgcj_d_t.num1
               #重新计算调整金额
               LET g_bgcj_d[l_ac].amt1 = g_bgcj_d[l_ac].num1*(g_bgcj_d[1].price1+g_bgcj_d[l_ac].price1)+g_bgcj_d[1].num1*g_bgcj_d[l_ac].price1
               CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt1,2) 
                  RETURNING g_bgcj_d[l_ac].amt1
               NEXT FIELD CURRENT
            END IF
            LET l_amt_t = g_bgcj_d[l_ac].amt1   
            IF NOT cl_null(g_bgcj_d[l_ac].price1) THEN
               #调整金额=调整数量*（基准单价+调整单价） + 基准数量*调整单价
               LET g_bgcj_d[l_ac].amt1 = g_bgcj_d[l_ac].num1*(g_bgcj_d[1].price1+g_bgcj_d[l_ac].price1)+g_bgcj_d[1].num1*g_bgcj_d[l_ac].price1
               CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt1,2) 
                  RETURNING g_bgcj_d[l_ac].amt1
               LET l_amt = g_bgcj_d[1].amt1 + g_bgcj_d[2].amt1 + g_bgcj_d[3].amt1
               IF l_amt < 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'abg-00215'
                  LET g_errparam.extend = g_bgcj_d[l_ac].num1
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_bgcj_d[l_ac].num1 = g_bgcj_d_t.num1
                  #重新计算调整金额
                  LET g_bgcj_d[l_ac].amt1 = g_bgcj_d[l_ac].num1*(g_bgcj_d[1].price1+g_bgcj_d[l_ac].price1)+g_bgcj_d[1].num1*g_bgcj_d[l_ac].price1
                  CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt1,2) 
                     RETURNING g_bgcj_d[l_ac].amt1
                  NEXT FIELD CURRENT
               END IF
            END IF
               
            LET g_bgcj_d[l_ac].sum = g_bgcj_d[l_ac].sum - l_amt_t + g_bgcj_d[l_ac].amt1
            LET g_bgcj_d[4].num1 = l_num
            LET l_amt_t = g_bgcj_d[4].amt1
            LET g_bgcj_d[4].amt1 = l_amt
            LET g_bgcj_d[4].sum = g_bgcj_d[4].sum - l_amt_t + g_bgcj_d[4].amt1
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE num1
            #add-point:ON CHANGE num1 name="input.g.page1.num1"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD price1
            #add-point:BEFORE FIELD price1 name="input.b.page1.price1"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD price1
            
            #add-point:AFTER FIELD price1 name="input.a.page1.price1"
            IF cl_null(g_bgcj_d[l_ac].price1) THEN
               LET g_bgcj_d[l_ac].price1 = 0
            END IF
            
            LET l_price = g_bgcj_d[1].price1 + g_bgcj_d[2].price1 + g_bgcj_d[3].price1
            IF l_price < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'abg-00214'
               LET g_errparam.extend = g_bgcj_d[l_ac].price1
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_bgcj_d[l_ac].price1 = g_bgcj_d_t.price1
               #重新计算调整金额
               LET g_bgcj_d[l_ac].amt1 = g_bgcj_d[l_ac].num1*(g_bgcj_d[1].price1+g_bgcj_d[l_ac].price1)+g_bgcj_d[1].num1*g_bgcj_d[l_ac].price1
               CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt1,2) 
                  RETURNING g_bgcj_d[l_ac].amt1
               NEXT FIELD CURRENT
            END IF
            CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].price1,1) 
               RETURNING g_bgcj_d[l_ac].price1
            LET l_amt_t = g_bgcj_d[l_ac].amt1
            IF NOT cl_null(g_bgcj_d[l_ac].num1) THEN
               #调整金额=调整数量*（基准单价+调整单价） + 基准数量*调整单价
               LET g_bgcj_d[l_ac].amt1 = g_bgcj_d[l_ac].num1*(g_bgcj_d[1].price1+g_bgcj_d[l_ac].price1)+g_bgcj_d[1].num1*g_bgcj_d[l_ac].price1
               CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt1,2) 
                  RETURNING g_bgcj_d[l_ac].amt1
               LET l_amt = g_bgcj_d[1].amt1 + g_bgcj_d[2].amt1 + g_bgcj_d[3].amt1
               IF l_amt < 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'abg-00215'
                  LET g_errparam.extend = g_bgcj_d[l_ac].price1
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_bgcj_d[l_ac].price1 = g_bgcj_d_t.price1
                  #重新计算调整金额
                  LET g_bgcj_d[l_ac].amt1 = g_bgcj_d[l_ac].num1*(g_bgcj_d[1].price1+g_bgcj_d[l_ac].price1)+g_bgcj_d[1].num1*g_bgcj_d[l_ac].price1
                  CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt1,2) 
                     RETURNING g_bgcj_d[l_ac].amt1
                  NEXT FIELD CURRENT
               END IF
            END IF
            LET g_bgcj_d[l_ac].sum = g_bgcj_d[l_ac].sum - l_amt_t + g_bgcj_d[l_ac].amt1
            LET g_bgcj_d[4].price1 = l_price
            LET l_amt_t = g_bgcj_d[4].amt1
            LET g_bgcj_d[4].amt1 = l_amt
            LET g_bgcj_d[4].sum = g_bgcj_d[4].sum - l_amt_t + g_bgcj_d[4].amt1
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE price1
            #add-point:ON CHANGE price1 name="input.g.page1.price1"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt1
            #add-point:BEFORE FIELD amt1 name="input.b.page1.amt1"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt1
            
            #add-point:AFTER FIELD amt1 name="input.a.page1.amt1"
            IF cl_null(g_bgcj_d[l_ac].amt1) THEN
               LET g_bgcj_d[l_ac].amt1 =0 
            END IF
            LET l_amt = g_bgcj_d[1].amt1 + g_bgcj_d[2].amt1 + g_bgcj_d[3].amt1
            IF l_amt < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'abg-00215'
               LET g_errparam.extend = g_bgcj_d[l_ac].amt1
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_bgcj_d[l_ac].amt1 = g_bgcj_d_t.amt1
               NEXT FIELD CURRENT
            END IF
               
            LET g_bgcj_d[l_ac].sum = g_bgcj_d[l_ac].sum - g_bgcj_d_t.amt1 + g_bgcj_d[l_ac].amt1
            LET l_amt_t = g_bgcj_d[4].amt1
            LET g_bgcj_d[4].amt1 = l_amt
            LET g_bgcj_d[4].sum = g_bgcj_d[4].sum - l_amt_t + g_bgcj_d[4].amt1
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt1
            #add-point:ON CHANGE amt1 name="input.g.page1.amt1"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD num2
            #add-point:BEFORE FIELD num2 name="input.b.page1.num2"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD num2
            
            #add-point:AFTER FIELD num2 name="input.a.page1.num2"
            IF cl_null(g_bgcj_d[l_ac].num2) THEN
               LET g_bgcj_d[l_ac].num2 =0 
            END IF
            
            LET l_num = g_bgcj_d[1].num2 + g_bgcj_d[2].num2 + g_bgcj_d[3].num2
            IF l_num < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'abg-00213'
               LET g_errparam.extend = g_bgcj_d[l_ac].num2
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_bgcj_d[l_ac].num2 = g_bgcj_d_t.num2
               LET g_bgcj_d[l_ac].amt2 = g_bgcj_d[l_ac].num2*(g_bgcj_d[1].price2+g_bgcj_d[l_ac].price2)+g_bgcj_d[1].num2*g_bgcj_d[l_ac].price2
               CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt2,2) 
                  RETURNING g_bgcj_d[l_ac].amt2
               NEXT FIELD CURRENT
            END IF
            LET l_amt_t = g_bgcj_d[l_ac].amt2   
            IF NOT cl_null(g_bgcj_d[l_ac].price2) THEN
               #调整金额=调整数量*（基准单价+调整单价） + 基准数量*调整单价
               LET g_bgcj_d[l_ac].amt2 = g_bgcj_d[l_ac].num2*(g_bgcj_d[1].price2+g_bgcj_d[l_ac].price2)+g_bgcj_d[1].num2*g_bgcj_d[l_ac].price2
               CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt2,2) 
                  RETURNING g_bgcj_d[l_ac].amt2
               LET l_amt = g_bgcj_d[1].amt2 + g_bgcj_d[2].amt2 + g_bgcj_d[3].amt2
               IF l_amt < 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'abg-00215'
                  LET g_errparam.extend = g_bgcj_d[l_ac].num2
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_bgcj_d[l_ac].num2 = g_bgcj_d_t.num2
                  LET g_bgcj_d[l_ac].amt2 = g_bgcj_d[l_ac].num2*(g_bgcj_d[1].price2+g_bgcj_d[l_ac].price2)+g_bgcj_d[1].num2*g_bgcj_d[l_ac].price2
                  CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt2,2) 
                     RETURNING g_bgcj_d[l_ac].amt2
                  NEXT FIELD CURRENT
               END IF
            END IF
               
            LET g_bgcj_d[l_ac].sum = g_bgcj_d[l_ac].sum - l_amt_t + g_bgcj_d[l_ac].amt2
            LET g_bgcj_d[4].num2 = l_num
            LET l_amt_t = g_bgcj_d[4].amt2
            LET g_bgcj_d[4].amt2 = l_amt
            LET g_bgcj_d[4].sum = g_bgcj_d[4].sum - l_amt_t + g_bgcj_d[4].amt2
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE num2
            #add-point:ON CHANGE num2 name="input.g.page1.num2"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD price2
            #add-point:BEFORE FIELD price2 name="input.b.page1.price2"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD price2
            
            #add-point:AFTER FIELD price2 name="input.a.page1.price2"
            IF cl_null(g_bgcj_d[l_ac].price2) THEN
               LET g_bgcj_d[l_ac].price2 = 0
            END IF
            
            LET l_price = g_bgcj_d[1].price2 + g_bgcj_d[2].price2 + g_bgcj_d[3].price2
            IF l_price < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'abg-00214'
               LET g_errparam.extend = g_bgcj_d[l_ac].price2
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_bgcj_d[l_ac].price2 = g_bgcj_d_t.price2
               LET g_bgcj_d[l_ac].amt2 = g_bgcj_d[l_ac].num2*(g_bgcj_d[1].price2+g_bgcj_d[l_ac].price2)+g_bgcj_d[1].num2*g_bgcj_d[l_ac].price2
               CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt2,2) 
                  RETURNING g_bgcj_d[l_ac].amt2
               NEXT FIELD CURRENT
            END IF
            CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].price2,1) 
               RETURNING g_bgcj_d[l_ac].price2
            LET l_amt_t = g_bgcj_d[l_ac].amt2
            IF NOT cl_null(g_bgcj_d[l_ac].num2) THEN               
               #调整金额=调整数量*（基准单价+调整单价） + 基准数量*调整单价
               LET g_bgcj_d[l_ac].amt2 = g_bgcj_d[l_ac].num2*(g_bgcj_d[1].price2+g_bgcj_d[l_ac].price2)+g_bgcj_d[1].num2*g_bgcj_d[l_ac].price2
               CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt2,2) 
                  RETURNING g_bgcj_d[l_ac].amt2
               LET l_amt = g_bgcj_d[1].amt2 + g_bgcj_d[2].amt2 + g_bgcj_d[3].amt2
               IF l_amt < 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'abg-00215'
                  LET g_errparam.extend = g_bgcj_d[l_ac].price2
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_bgcj_d[l_ac].price2 = g_bgcj_d_t.price2
                  LET g_bgcj_d[l_ac].amt2 = g_bgcj_d[l_ac].num2*(g_bgcj_d[1].price2+g_bgcj_d[l_ac].price2)+g_bgcj_d[1].num2*g_bgcj_d[l_ac].price2
                  CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt2,2) 
                     RETURNING g_bgcj_d[l_ac].amt2
                  NEXT FIELD CURRENT
               END IF
            END IF
            LET g_bgcj_d[l_ac].sum = g_bgcj_d[l_ac].sum - l_amt_t + g_bgcj_d[l_ac].amt2
            LET g_bgcj_d[4].price2 = l_price
            LET l_amt_t = g_bgcj_d[4].amt2
            LET g_bgcj_d[4].amt2 = l_amt
            LET g_bgcj_d[4].sum = g_bgcj_d[4].sum - l_amt_t + g_bgcj_d[4].amt2
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE price2
            #add-point:ON CHANGE price2 name="input.g.page1.price2"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt2
            #add-point:BEFORE FIELD amt2 name="input.b.page1.amt2"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt2
            
            #add-point:AFTER FIELD amt2 name="input.a.page1.amt2"
            IF cl_null(g_bgcj_d[l_ac].amt2) THEN
               LET g_bgcj_d[l_ac].amt2 =0 
            END IF
            LET l_amt = g_bgcj_d[1].amt2 + g_bgcj_d[2].amt2 + g_bgcj_d[3].amt2
            IF l_amt < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'abg-00215'
               LET g_errparam.extend = g_bgcj_d[l_ac].amt2
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_bgcj_d[l_ac].amt2 = g_bgcj_d_t.amt2
               NEXT FIELD CURRENT
            END IF
               
            LET g_bgcj_d[l_ac].sum = g_bgcj_d[l_ac].sum - g_bgcj_d_t.amt2 + g_bgcj_d[l_ac].amt2
            LET l_amt_t = g_bgcj_d[4].amt2
            LET g_bgcj_d[4].amt2 = l_amt
            LET g_bgcj_d[4].sum = g_bgcj_d[4].sum - l_amt_t + g_bgcj_d[4].amt2
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt2
            #add-point:ON CHANGE amt2 name="input.g.page1.amt2"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD num3
            #add-point:BEFORE FIELD num3 name="input.b.page1.num3"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD num3
            
            #add-point:AFTER FIELD num3 name="input.a.page1.num3"
            IF cl_null(g_bgcj_d[l_ac].num3) THEN
               LET g_bgcj_d[l_ac].num3 =0 
            END IF
            
            LET l_num = g_bgcj_d[1].num3 + g_bgcj_d[2].num3 + g_bgcj_d[3].num3
            IF l_num < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'abg-00213'
               LET g_errparam.extend = g_bgcj_d[l_ac].num3
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_bgcj_d[l_ac].num3 = g_bgcj_d_t.num3
               LET g_bgcj_d[l_ac].amt3 = g_bgcj_d[l_ac].num3*(g_bgcj_d[1].price3+g_bgcj_d[l_ac].price3)+g_bgcj_d[1].num3*g_bgcj_d[l_ac].price3
               CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt3,2) 
                  RETURNING g_bgcj_d[l_ac].amt3
               NEXT FIELD CURRENT
            END IF
            LET l_amt_t = g_bgcj_d[l_ac].amt3
            IF NOT cl_null(g_bgcj_d[l_ac].price3) THEN
               #调整金额=调整数量*（基准单价+调整单价） + 基准数量*调整单价
               LET g_bgcj_d[l_ac].amt3 = g_bgcj_d[l_ac].num3*(g_bgcj_d[1].price3+g_bgcj_d[l_ac].price3)+g_bgcj_d[1].num3*g_bgcj_d[l_ac].price3
               CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt3,2) 
                  RETURNING g_bgcj_d[l_ac].amt3
               LET l_amt = g_bgcj_d[1].amt3 + g_bgcj_d[2].amt3 + g_bgcj_d[3].amt3
               IF l_amt < 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'abg-00215'
                  LET g_errparam.extend = g_bgcj_d[l_ac].num3
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_bgcj_d[l_ac].num3 = g_bgcj_d_t.num3
                  LET g_bgcj_d[l_ac].amt3 = g_bgcj_d[l_ac].num3*(g_bgcj_d[1].price3+g_bgcj_d[l_ac].price3)+g_bgcj_d[1].num3*g_bgcj_d[l_ac].price3
                  CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt3,2) 
                  RETURNING g_bgcj_d[l_ac].amt3
                  NEXT FIELD CURRENT
               END IF
            END IF
               
            LET g_bgcj_d[l_ac].sum = g_bgcj_d[l_ac].sum - l_amt_t + g_bgcj_d[l_ac].amt3
            LET g_bgcj_d[4].num3 = l_num
            LET l_amt_t = g_bgcj_d[4].amt3
            LET g_bgcj_d[4].amt3 = l_amt
            LET g_bgcj_d[4].sum = g_bgcj_d[4].sum - l_amt_t + g_bgcj_d[4].amt3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE num3
            #add-point:ON CHANGE num3 name="input.g.page1.num3"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD price3
            #add-point:BEFORE FIELD price3 name="input.b.page1.price3"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD price3
            
            #add-point:AFTER FIELD price3 name="input.a.page1.price3"
            IF cl_null(g_bgcj_d[l_ac].price3) THEN
               LET g_bgcj_d[l_ac].price3 = 0
            END IF
            
            LET l_price = g_bgcj_d[1].price3 + g_bgcj_d[2].price3 + g_bgcj_d[3].price3
            IF l_price < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'abg-00214'
               LET g_errparam.extend = g_bgcj_d[l_ac].price3
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_bgcj_d[l_ac].price3 = g_bgcj_d_t.price3
               LET g_bgcj_d[l_ac].amt3 = g_bgcj_d[l_ac].num3*(g_bgcj_d[1].price3+g_bgcj_d[l_ac].price3)+g_bgcj_d[1].num3*g_bgcj_d[l_ac].price3
               CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt3,2) 
                  RETURNING g_bgcj_d[l_ac].amt3
               NEXT FIELD CURRENT
            END IF
            CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].price3,1) 
               RETURNING g_bgcj_d[l_ac].price3
            LET l_amt_t = g_bgcj_d[l_ac].amt3
            IF NOT cl_null(g_bgcj_d[l_ac].num3) THEN
               #调整金额=调整数量*（基准单价+调整单价） + 基准数量*调整单价
               LET g_bgcj_d[l_ac].amt3 = g_bgcj_d[l_ac].num3*(g_bgcj_d[1].price3+g_bgcj_d[l_ac].price3)+g_bgcj_d[1].num3*g_bgcj_d[l_ac].price3
               CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt3,2) 
                  RETURNING g_bgcj_d[l_ac].amt3
               LET l_amt = g_bgcj_d[1].amt3 + g_bgcj_d[2].amt3 + g_bgcj_d[3].amt3
               IF l_amt < 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'abg-00215'
                  LET g_errparam.extend = g_bgcj_d[l_ac].price3
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_bgcj_d[l_ac].price3 = g_bgcj_d_t.price3
                  LET g_bgcj_d[l_ac].amt3 = g_bgcj_d[l_ac].num3*(g_bgcj_d[1].price3+g_bgcj_d[l_ac].price3)+g_bgcj_d[1].num3*g_bgcj_d[l_ac].price3
                  CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt3,2) 
                     RETURNING g_bgcj_d[l_ac].amt3
                  NEXT FIELD CURRENT
               END IF
            END IF
            LET g_bgcj_d[l_ac].sum = g_bgcj_d[l_ac].sum - l_amt_t + g_bgcj_d[l_ac].amt3
            LET g_bgcj_d[4].price3 = l_price
            LET l_amt_t = g_bgcj_d[4].amt3
            LET g_bgcj_d[4].amt3 = l_amt
            LET g_bgcj_d[4].sum = g_bgcj_d[4].sum - l_amt_t + g_bgcj_d[4].amt3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE price3
            #add-point:ON CHANGE price3 name="input.g.page1.price3"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt3
            #add-point:BEFORE FIELD amt3 name="input.b.page1.amt3"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt3
            
            #add-point:AFTER FIELD amt3 name="input.a.page1.amt3"
            IF cl_null(g_bgcj_d[l_ac].amt3) THEN
               LET g_bgcj_d[l_ac].amt3 =0 
            END IF
            LET l_amt = g_bgcj_d[1].amt3 + g_bgcj_d[2].amt3 + g_bgcj_d[3].amt3
            IF l_amt < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'abg-00215'
               LET g_errparam.extend = g_bgcj_d[l_ac].amt3
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_bgcj_d[l_ac].amt3 = g_bgcj_d_t.amt3
               NEXT FIELD CURRENT
            END IF
               
            LET g_bgcj_d[l_ac].sum = g_bgcj_d[l_ac].sum - g_bgcj_d_t.amt3 + g_bgcj_d[l_ac].amt3
            LET l_amt_t = g_bgcj_d[4].amt3
            LET g_bgcj_d[4].amt3 = l_amt
            LET g_bgcj_d[4].sum = g_bgcj_d[4].sum - l_amt_t + g_bgcj_d[4].amt3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt3
            #add-point:ON CHANGE amt3 name="input.g.page1.amt3"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD num4
            #add-point:BEFORE FIELD num4 name="input.b.page1.num4"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD num4
            
            #add-point:AFTER FIELD num4 name="input.a.page1.num4"
            IF cl_null(g_bgcj_d[l_ac].num4) THEN
               LET g_bgcj_d[l_ac].num4 =0 
            END IF
            
            LET l_num = g_bgcj_d[1].num4 + g_bgcj_d[2].num4 + g_bgcj_d[3].num4
            IF l_num < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'abg-00213'
               LET g_errparam.extend = g_bgcj_d[l_ac].num4
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_bgcj_d[l_ac].num4 = g_bgcj_d_t.num4
               LET g_bgcj_d[l_ac].amt4 = g_bgcj_d[l_ac].num4*(g_bgcj_d[1].price4+g_bgcj_d[l_ac].price4)+g_bgcj_d[1].num4*g_bgcj_d[l_ac].price4
               CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt4,2) 
                  RETURNING g_bgcj_d[l_ac].amt4
               NEXT FIELD CURRENT
            END IF
            LET l_amt_t = g_bgcj_d[l_ac].amt4   
            IF NOT cl_null(g_bgcj_d[l_ac].price4) THEN
               #调整金额=调整数量*（基准单价+调整单价） + 基准数量*调整单价
               LET g_bgcj_d[l_ac].amt4 = g_bgcj_d[l_ac].num4*(g_bgcj_d[1].price4+g_bgcj_d[l_ac].price4)+g_bgcj_d[1].num4*g_bgcj_d[l_ac].price4
               CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt4,2) 
                  RETURNING g_bgcj_d[l_ac].amt4
               LET l_amt = g_bgcj_d[1].amt4 + g_bgcj_d[2].amt4 + g_bgcj_d[3].amt4
               IF l_amt < 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'abg-00215'
                  LET g_errparam.extend = g_bgcj_d[l_ac].num4
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_bgcj_d[l_ac].num4 = g_bgcj_d_t.num4
                  LET g_bgcj_d[l_ac].amt4 = g_bgcj_d[l_ac].num4*(g_bgcj_d[1].price4+g_bgcj_d[l_ac].price4)+g_bgcj_d[1].num4*g_bgcj_d[l_ac].price4
                  CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt4,2) 
                     RETURNING g_bgcj_d[l_ac].amt4
                  NEXT FIELD CURRENT
               END IF
            END IF
               
            LET g_bgcj_d[l_ac].sum = g_bgcj_d[l_ac].sum - l_amt_t + g_bgcj_d[l_ac].amt4
            LET g_bgcj_d[4].num4 = l_num
            LET l_amt_t = g_bgcj_d[4].amt4
            LET g_bgcj_d[4].amt4 = l_amt
            LET g_bgcj_d[4].sum = g_bgcj_d[4].sum - l_amt_t + g_bgcj_d[4].amt4
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE num4
            #add-point:ON CHANGE num4 name="input.g.page1.num4"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD price4
            #add-point:BEFORE FIELD price4 name="input.b.page1.price4"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD price4
            
            #add-point:AFTER FIELD price4 name="input.a.page1.price4"
            IF cl_null(g_bgcj_d[l_ac].price4) THEN
               LET g_bgcj_d[l_ac].price4 = 0
            END IF
            
            LET l_price = g_bgcj_d[1].price4 + g_bgcj_d[2].price4 + g_bgcj_d[3].price4
            IF l_price < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'abg-00214'
               LET g_errparam.extend = g_bgcj_d[l_ac].price4
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_bgcj_d[l_ac].price4 = g_bgcj_d_t.price4
               LET g_bgcj_d[l_ac].amt4 = g_bgcj_d[l_ac].num4*(g_bgcj_d[1].price4+g_bgcj_d[l_ac].price4)+g_bgcj_d[1].num4*g_bgcj_d[l_ac].price4
               CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt4,2) 
                  RETURNING g_bgcj_d[l_ac].amt4
               NEXT FIELD CURRENT
            END IF
            CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].price4,1) 
               RETURNING g_bgcj_d[l_ac].price4
            LET l_amt_t = g_bgcj_d[l_ac].amt4
            IF NOT cl_null(g_bgcj_d[l_ac].num4) THEN
               #调整金额=调整数量*（基准单价+调整单价） + 基准数量*调整单价
               LET g_bgcj_d[l_ac].amt4 = g_bgcj_d[l_ac].num4*(g_bgcj_d[1].price4+g_bgcj_d[l_ac].price4)+g_bgcj_d[1].num4*g_bgcj_d[l_ac].price4
               CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt4,2) 
                  RETURNING g_bgcj_d[l_ac].amt4
               LET l_amt = g_bgcj_d[1].amt4 + g_bgcj_d[2].amt4 + g_bgcj_d[3].amt4
               IF l_amt < 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'abg-00215'
                  LET g_errparam.extend = g_bgcj_d[l_ac].price4
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_bgcj_d[l_ac].price4 = g_bgcj_d_t.price4
                  LET g_bgcj_d[l_ac].amt4 = g_bgcj_d[l_ac].num4*(g_bgcj_d[1].price4+g_bgcj_d[l_ac].price4)+g_bgcj_d[1].num4*g_bgcj_d[l_ac].price4
                  CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt4,2) 
                  RETURNING g_bgcj_d[l_ac].amt4
                  NEXT FIELD CURRENT
               END IF
            END IF
            LET g_bgcj_d[l_ac].sum = g_bgcj_d[l_ac].sum - l_amt_t + g_bgcj_d[l_ac].amt4
            LET g_bgcj_d[4].price4 = l_price
            LET l_amt_t = g_bgcj_d[4].amt4
            LET g_bgcj_d[4].amt4 = l_amt
            LET g_bgcj_d[4].sum = g_bgcj_d[4].sum - l_amt_t + g_bgcj_d[4].amt4
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE price4
            #add-point:ON CHANGE price4 name="input.g.page1.price4"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt4
            #add-point:BEFORE FIELD amt4 name="input.b.page1.amt4"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt4
            
            #add-point:AFTER FIELD amt4 name="input.a.page1.amt4"
            IF cl_null(g_bgcj_d[l_ac].amt4) THEN
               LET g_bgcj_d[l_ac].amt4 =0 
            END IF
            LET l_amt = g_bgcj_d[1].amt4 + g_bgcj_d[2].amt4 + g_bgcj_d[3].amt4
            IF l_amt < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'abg-00215'
               LET g_errparam.extend = g_bgcj_d[l_ac].amt4
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_bgcj_d[l_ac].amt4 = g_bgcj_d_t.amt4
               NEXT FIELD CURRENT
            END IF
               
            LET g_bgcj_d[l_ac].sum = g_bgcj_d[l_ac].sum - g_bgcj_d_t.amt4 + g_bgcj_d[l_ac].amt4
            LET l_amt_t = g_bgcj_d[4].amt4
            LET g_bgcj_d[4].amt4 = l_amt
            LET g_bgcj_d[4].sum = g_bgcj_d[4].sum - l_amt_t + g_bgcj_d[4].amt4
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt4
            #add-point:ON CHANGE amt4 name="input.g.page1.amt4"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD num5
            #add-point:BEFORE FIELD num5 name="input.b.page1.num5"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD num5
            
            #add-point:AFTER FIELD num5 name="input.a.page1.num5"
            IF cl_null(g_bgcj_d[l_ac].num5) THEN
               LET g_bgcj_d[l_ac].num5 =0 
            END IF
            
            LET l_num = g_bgcj_d[1].num5 + g_bgcj_d[2].num5 + g_bgcj_d[3].num5
            IF l_num < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'abg-00213'
               LET g_errparam.extend = g_bgcj_d[l_ac].num5
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_bgcj_d[l_ac].num5 = g_bgcj_d_t.num5
               LET g_bgcj_d[l_ac].amt5 = g_bgcj_d[l_ac].num5*(g_bgcj_d[1].price5+g_bgcj_d[l_ac].price5)+g_bgcj_d[1].num5*g_bgcj_d[l_ac].price5
               CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt5,2) 
                  RETURNING g_bgcj_d[l_ac].amt5
               NEXT FIELD CURRENT
            END IF
            LET l_amt_t = g_bgcj_d[l_ac].amt5   
            IF NOT cl_null(g_bgcj_d[l_ac].price5) THEN
               #调整金额=调整数量*（基准单价+调整单价） + 基准数量*调整单价
               LET g_bgcj_d[l_ac].amt5 = g_bgcj_d[l_ac].num5*(g_bgcj_d[1].price5+g_bgcj_d[l_ac].price5)+g_bgcj_d[1].num5*g_bgcj_d[l_ac].price5
               CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt5,2) 
                  RETURNING g_bgcj_d[l_ac].amt5
               LET l_amt = g_bgcj_d[1].amt5 + g_bgcj_d[2].amt5 + g_bgcj_d[3].amt5
               IF l_amt < 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'abg-00215'
                  LET g_errparam.extend = g_bgcj_d[l_ac].num5
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_bgcj_d[l_ac].num5 = g_bgcj_d_t.num5
                  LET g_bgcj_d[l_ac].amt5 = g_bgcj_d[l_ac].num5*(g_bgcj_d[1].price5+g_bgcj_d[l_ac].price5)+g_bgcj_d[1].num5*g_bgcj_d[l_ac].price5
                  CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt5,2) 
                     RETURNING g_bgcj_d[l_ac].amt5
                  NEXT FIELD CURRENT
               END IF
            END IF
               
            LET g_bgcj_d[l_ac].sum = g_bgcj_d[l_ac].sum - l_amt_t + g_bgcj_d[l_ac].amt5
            LET g_bgcj_d[4].num5 = l_num
            LET l_amt_t = g_bgcj_d[4].amt5
            LET g_bgcj_d[4].amt5 = l_amt
            LET g_bgcj_d[4].sum = g_bgcj_d[4].sum - l_amt_t + g_bgcj_d[4].amt5
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE num5
            #add-point:ON CHANGE num5 name="input.g.page1.num5"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD price5
            #add-point:BEFORE FIELD price5 name="input.b.page1.price5"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD price5
            
            #add-point:AFTER FIELD price5 name="input.a.page1.price5"
            IF cl_null(g_bgcj_d[l_ac].price5) THEN
               LET g_bgcj_d[l_ac].price5 = 0
            END IF
            
            LET l_price = g_bgcj_d[1].price5 + g_bgcj_d[2].price5 + g_bgcj_d[3].price5
            IF l_price < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'abg-00214'
               LET g_errparam.extend = g_bgcj_d[l_ac].price5
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_bgcj_d[l_ac].price5 = g_bgcj_d_t.price5
               LET g_bgcj_d[l_ac].amt5 = g_bgcj_d[l_ac].num5*(g_bgcj_d[1].price5+g_bgcj_d[l_ac].price5)+g_bgcj_d[1].num5*g_bgcj_d[l_ac].price5
               CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt5,2) 
                  RETURNING g_bgcj_d[l_ac].amt5
               NEXT FIELD CURRENT
            END IF
            CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].price5,1) 
               RETURNING g_bgcj_d[l_ac].price5
            LET l_amt_t = g_bgcj_d[l_ac].amt5
            IF NOT cl_null(g_bgcj_d[l_ac].num5) THEN
               #调整金额=调整数量*（基准单价+调整单价） + 基准数量*调整单价
               LET g_bgcj_d[l_ac].amt5 = g_bgcj_d[l_ac].num5*(g_bgcj_d[1].price5+g_bgcj_d[l_ac].price5)+g_bgcj_d[1].num5*g_bgcj_d[l_ac].price5
               CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt5,2) 
                  RETURNING g_bgcj_d[l_ac].amt5
               LET l_amt = g_bgcj_d[1].amt5 + g_bgcj_d[2].amt5 + g_bgcj_d[3].amt5
               IF l_amt < 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'abg-00215'
                  LET g_errparam.extend = g_bgcj_d[l_ac].price5
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_bgcj_d[l_ac].price5 = g_bgcj_d_t.price5
                  LET g_bgcj_d[l_ac].amt5 = g_bgcj_d[l_ac].num5*(g_bgcj_d[1].price5+g_bgcj_d[l_ac].price5)+g_bgcj_d[1].num5*g_bgcj_d[l_ac].price5
                  CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt5,2) 
                     RETURNING g_bgcj_d[l_ac].amt5
                  NEXT FIELD CURRENT
               END IF
            END IF
            LET g_bgcj_d[l_ac].sum = g_bgcj_d[l_ac].sum - l_amt_t + g_bgcj_d[l_ac].amt5
            LET g_bgcj_d[4].price5 = l_price
            LET l_amt_t = g_bgcj_d[4].amt5
            LET g_bgcj_d[4].amt5 = l_amt
            LET g_bgcj_d[4].sum = g_bgcj_d[4].sum - l_amt_t + g_bgcj_d[4].amt5
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE price5
            #add-point:ON CHANGE price5 name="input.g.page1.price5"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt5
            #add-point:BEFORE FIELD amt5 name="input.b.page1.amt5"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt5
            
            #add-point:AFTER FIELD amt5 name="input.a.page1.amt5"
            IF cl_null(g_bgcj_d[l_ac].amt5) THEN
               LET g_bgcj_d[l_ac].amt5 =0 
            END IF
            LET l_amt = g_bgcj_d[1].amt5 + g_bgcj_d[2].amt5 + g_bgcj_d[3].amt5
            IF l_amt < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'abg-00215'
               LET g_errparam.extend = g_bgcj_d[l_ac].amt5
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_bgcj_d[l_ac].amt5 = g_bgcj_d_t.amt5
               NEXT FIELD CURRENT
            END IF
               
            LET g_bgcj_d[l_ac].sum = g_bgcj_d[l_ac].sum - g_bgcj_d_t.amt5 + g_bgcj_d[l_ac].amt5
            LET l_amt_t = g_bgcj_d[4].amt5
            LET g_bgcj_d[4].amt5 = l_amt
            LET g_bgcj_d[4].sum = g_bgcj_d[4].sum - l_amt_t + g_bgcj_d[4].amt5
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt5
            #add-point:ON CHANGE amt5 name="input.g.page1.amt5"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD num6
            #add-point:BEFORE FIELD num6 name="input.b.page1.num6"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD num6
            
            #add-point:AFTER FIELD num6 name="input.a.page1.num6"
            IF cl_null(g_bgcj_d[l_ac].num6) THEN
               LET g_bgcj_d[l_ac].num6 =0 
            END IF
            
            LET l_num = g_bgcj_d[1].num6 + g_bgcj_d[2].num6 + g_bgcj_d[3].num6
            IF l_num < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'abg-00213'
               LET g_errparam.extend = g_bgcj_d[l_ac].num6
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_bgcj_d[l_ac].num6 = g_bgcj_d_t.num6
               LET g_bgcj_d[l_ac].amt6 = g_bgcj_d[l_ac].num6*(g_bgcj_d[1].price6+g_bgcj_d[l_ac].price6)+g_bgcj_d[1].num6*g_bgcj_d[l_ac].price6
               CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt6,2) 
                  RETURNING g_bgcj_d[l_ac].amt6
               NEXT FIELD CURRENT
            END IF
            LET l_amt_t = g_bgcj_d[l_ac].amt6   
            IF NOT cl_null(g_bgcj_d[l_ac].price6) THEN
               #调整金额=调整数量*（基准单价+调整单价） + 基准数量*调整单价
               LET g_bgcj_d[l_ac].amt6 = g_bgcj_d[l_ac].num6*(g_bgcj_d[1].price6+g_bgcj_d[l_ac].price6)+g_bgcj_d[1].num6*g_bgcj_d[l_ac].price6
               CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt6,2) 
                  RETURNING g_bgcj_d[l_ac].amt6
               LET l_amt = g_bgcj_d[1].amt6 + g_bgcj_d[2].amt6 + g_bgcj_d[3].amt6
               IF l_amt < 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'abg-00215'
                  LET g_errparam.extend = g_bgcj_d[l_ac].num6
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_bgcj_d[l_ac].num6 = g_bgcj_d_t.num6
                  LET g_bgcj_d[l_ac].amt6 = g_bgcj_d[l_ac].num6*(g_bgcj_d[1].price6+g_bgcj_d[l_ac].price6)+g_bgcj_d[1].num6*g_bgcj_d[l_ac].price6
                  CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt6,2) 
                     RETURNING g_bgcj_d[l_ac].amt6
                  NEXT FIELD CURRENT
               END IF
            END IF
               
            LET g_bgcj_d[l_ac].sum = g_bgcj_d[l_ac].sum - l_amt_t + g_bgcj_d[l_ac].amt6
            LET g_bgcj_d[4].num6 = l_num
            LET l_amt_t = g_bgcj_d[4].amt6
            LET g_bgcj_d[4].amt6 = l_amt
            LET g_bgcj_d[4].sum = g_bgcj_d[4].sum - l_amt_t + g_bgcj_d[4].amt6
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE num6
            #add-point:ON CHANGE num6 name="input.g.page1.num6"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD price6
            #add-point:BEFORE FIELD price6 name="input.b.page1.price6"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD price6
            
            #add-point:AFTER FIELD price6 name="input.a.page1.price6"
            IF cl_null(g_bgcj_d[l_ac].price6) THEN
               LET g_bgcj_d[l_ac].price6 = 0
            END IF
            
            LET l_price = g_bgcj_d[1].price6 + g_bgcj_d[2].price6 + g_bgcj_d[3].price6
            IF l_price < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'abg-00214'
               LET g_errparam.extend = g_bgcj_d[l_ac].price6
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_bgcj_d[l_ac].price6 = g_bgcj_d_t.price6
               LET g_bgcj_d[l_ac].amt6 = g_bgcj_d[l_ac].num6*(g_bgcj_d[1].price6+g_bgcj_d[l_ac].price6)+g_bgcj_d[1].num6*g_bgcj_d[l_ac].price6
               CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt6,2) 
                  RETURNING g_bgcj_d[l_ac].amt6
               NEXT FIELD CURRENT
            END IF
            CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].price6,1) 
                  RETURNING g_bgcj_d[l_ac].price6
            LET l_amt_t = g_bgcj_d[l_ac].amt6
            IF NOT cl_null(g_bgcj_d[l_ac].num6) THEN
               #调整金额=调整数量*（基准单价+调整单价） + 基准数量*调整单价
               LET g_bgcj_d[l_ac].amt6 = g_bgcj_d[l_ac].num6*(g_bgcj_d[1].price6+g_bgcj_d[l_ac].price6)+g_bgcj_d[1].num6*g_bgcj_d[l_ac].price6
               CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt6,2) 
                  RETURNING g_bgcj_d[l_ac].amt6
               LET l_amt = g_bgcj_d[1].amt6 + g_bgcj_d[2].amt6 + g_bgcj_d[3].amt6
               IF l_amt < 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'abg-00215'
                  LET g_errparam.extend = g_bgcj_d[l_ac].price6
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_bgcj_d[l_ac].price6 = g_bgcj_d_t.price6
                  LET g_bgcj_d[l_ac].amt6 = g_bgcj_d[l_ac].num6*(g_bgcj_d[1].price6+g_bgcj_d[l_ac].price6)+g_bgcj_d[1].num6*g_bgcj_d[l_ac].price6
                  CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt6,2) 
                     RETURNING g_bgcj_d[l_ac].amt6
                  NEXT FIELD CURRENT
               END IF
            END IF
            LET g_bgcj_d[l_ac].sum = g_bgcj_d[l_ac].sum - l_amt_t + g_bgcj_d[l_ac].amt6
            LET g_bgcj_d[4].price6 = l_price
            LET l_amt_t = g_bgcj_d[4].amt6
            LET g_bgcj_d[4].amt6 = l_amt
            LET g_bgcj_d[4].sum = g_bgcj_d[4].sum - l_amt_t + g_bgcj_d[4].amt6
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE price6
            #add-point:ON CHANGE price6 name="input.g.page1.price6"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt6
            #add-point:BEFORE FIELD amt6 name="input.b.page1.amt6"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt6
            
            #add-point:AFTER FIELD amt6 name="input.a.page1.amt6"
            IF cl_null(g_bgcj_d[l_ac].amt6) THEN
               LET g_bgcj_d[l_ac].amt6 =0 
            END IF
            LET l_amt = g_bgcj_d[1].amt6 + g_bgcj_d[2].amt6 + g_bgcj_d[3].amt6
            IF l_amt < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'abg-00215'
               LET g_errparam.extend = g_bgcj_d[l_ac].amt6
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_bgcj_d[l_ac].amt6 = g_bgcj_d_t.amt6
               NEXT FIELD CURRENT
            END IF
               
            LET g_bgcj_d[l_ac].sum = g_bgcj_d[l_ac].sum - g_bgcj_d_t.amt6 + g_bgcj_d[l_ac].amt6
            LET l_amt_t = g_bgcj_d[4].amt6
            LET g_bgcj_d[4].amt6 = l_amt
            LET g_bgcj_d[4].sum = g_bgcj_d[4].sum - l_amt_t + g_bgcj_d[4].amt6
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt6
            #add-point:ON CHANGE amt6 name="input.g.page1.amt6"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD num7
            #add-point:BEFORE FIELD num7 name="input.b.page1.num7"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD num7
            
            #add-point:AFTER FIELD num7 name="input.a.page1.num7"
            IF cl_null(g_bgcj_d[l_ac].num7) THEN
               LET g_bgcj_d[l_ac].num7 =0 
            END IF
            
            LET l_num = g_bgcj_d[1].num7 + g_bgcj_d[2].num7 + g_bgcj_d[3].num7
            IF l_num < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'abg-00213'
               LET g_errparam.extend = g_bgcj_d[l_ac].num7
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_bgcj_d[l_ac].num7 = g_bgcj_d_t.num7
               LET g_bgcj_d[l_ac].amt7 = g_bgcj_d[l_ac].num7*(g_bgcj_d[1].price7+g_bgcj_d[l_ac].price7)+g_bgcj_d[1].num7*g_bgcj_d[l_ac].price7
               CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt7,2) 
                  RETURNING g_bgcj_d[l_ac].amt7
               NEXT FIELD CURRENT
            END IF
            LET l_amt_t = g_bgcj_d[l_ac].amt7   
            IF NOT cl_null(g_bgcj_d[l_ac].price7) THEN
               #调整金额=调整数量*（基准单价+调整单价） + 基准数量*调整单价
               LET g_bgcj_d[l_ac].amt7 = g_bgcj_d[l_ac].num7*(g_bgcj_d[1].price7+g_bgcj_d[l_ac].price7)+g_bgcj_d[1].num7*g_bgcj_d[l_ac].price7
               CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt7,2) 
                  RETURNING g_bgcj_d[l_ac].amt7
               LET l_amt = g_bgcj_d[1].amt7 + g_bgcj_d[2].amt7 + g_bgcj_d[3].amt7
               IF l_amt < 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'abg-00215'
                  LET g_errparam.extend = g_bgcj_d[l_ac].num7
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_bgcj_d[l_ac].num7 = g_bgcj_d_t.num7
                  LET g_bgcj_d[l_ac].amt7 = g_bgcj_d[l_ac].num7*(g_bgcj_d[1].price7+g_bgcj_d[l_ac].price7)+g_bgcj_d[1].num7*g_bgcj_d[l_ac].price7
                  CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt7,2) 
                     RETURNING g_bgcj_d[l_ac].amt7
                  NEXT FIELD CURRENT
               END IF
            END IF
               
            LET g_bgcj_d[l_ac].sum = g_bgcj_d[l_ac].sum - l_amt_t + g_bgcj_d[l_ac].amt7
            LET g_bgcj_d[4].num7 = l_num
            LET l_amt_t = g_bgcj_d[4].amt7
            LET g_bgcj_d[4].amt7 = l_amt
            LET g_bgcj_d[4].sum = g_bgcj_d[4].sum - l_amt_t + g_bgcj_d[4].amt7
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE num7
            #add-point:ON CHANGE num7 name="input.g.page1.num7"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD price7
            #add-point:BEFORE FIELD price7 name="input.b.page1.price7"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD price7
            
            #add-point:AFTER FIELD price7 name="input.a.page1.price7"
            IF cl_null(g_bgcj_d[l_ac].price7) THEN
               LET g_bgcj_d[l_ac].price7 = 0
            END IF
            
            LET l_price = g_bgcj_d[1].price7 + g_bgcj_d[2].price7 + g_bgcj_d[3].price7
            IF l_price < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'abg-00214'
               LET g_errparam.extend = g_bgcj_d[l_ac].price7
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_bgcj_d[l_ac].price7 = g_bgcj_d_t.price7
               LET g_bgcj_d[l_ac].amt7 = g_bgcj_d[l_ac].num7*(g_bgcj_d[1].price7+g_bgcj_d[l_ac].price7)+g_bgcj_d[1].num7*g_bgcj_d[l_ac].price7
               CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt7,2) 
                  RETURNING g_bgcj_d[l_ac].amt7
               NEXT FIELD CURRENT
            END IF
            CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].price7,1) 
                  RETURNING g_bgcj_d[l_ac].price7
            LET l_amt_t = g_bgcj_d[l_ac].amt7
            IF NOT cl_null(g_bgcj_d[l_ac].num7) THEN
               #调整金额=调整数量*（基准单价+调整单价） + 基准数量*调整单价
               LET g_bgcj_d[l_ac].amt7 = g_bgcj_d[l_ac].num7*(g_bgcj_d[1].price7+g_bgcj_d[l_ac].price7)+g_bgcj_d[1].num7*g_bgcj_d[l_ac].price7
               CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt7,2) 
                  RETURNING g_bgcj_d[l_ac].amt7
               LET l_amt = g_bgcj_d[1].amt7 + g_bgcj_d[2].amt7 + g_bgcj_d[3].amt7
               IF l_amt < 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'abg-00215'
                  LET g_errparam.extend = g_bgcj_d[l_ac].price7
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_bgcj_d[l_ac].price7 = g_bgcj_d_t.price7
                  LET g_bgcj_d[l_ac].amt7 = g_bgcj_d[l_ac].num7*(g_bgcj_d[1].price7+g_bgcj_d[l_ac].price7)+g_bgcj_d[1].num7*g_bgcj_d[l_ac].price7
                  CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt7,2) 
                     RETURNING g_bgcj_d[l_ac].amt7
                  NEXT FIELD CURRENT
               END IF
            END IF
            LET g_bgcj_d[l_ac].sum = g_bgcj_d[l_ac].sum - l_amt_t + g_bgcj_d[l_ac].amt7
            LET g_bgcj_d[4].price7 = l_price
            LET l_amt_t = g_bgcj_d[4].amt7
            LET g_bgcj_d[4].amt7 = l_amt
            LET g_bgcj_d[4].sum = g_bgcj_d[4].sum - l_amt_t + g_bgcj_d[4].amt7
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE price7
            #add-point:ON CHANGE price7 name="input.g.page1.price7"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt7
            #add-point:BEFORE FIELD amt7 name="input.b.page1.amt7"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt7
            
            #add-point:AFTER FIELD amt7 name="input.a.page1.amt7"
            IF cl_null(g_bgcj_d[l_ac].amt7) THEN
               LET g_bgcj_d[l_ac].amt7 =0 
            END IF
            LET l_amt = g_bgcj_d[1].amt7 + g_bgcj_d[2].amt7 + g_bgcj_d[3].amt7
            IF l_amt < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'abg-00215'
               LET g_errparam.extend = g_bgcj_d[l_ac].amt7
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_bgcj_d[l_ac].amt7 = g_bgcj_d_t.amt7
               NEXT FIELD CURRENT
            END IF
               
            LET g_bgcj_d[l_ac].sum = g_bgcj_d[l_ac].sum - g_bgcj_d_t.amt7 + g_bgcj_d[l_ac].amt7
            LET l_amt_t = g_bgcj_d[4].amt7
            LET g_bgcj_d[4].amt7 = l_amt
            LET g_bgcj_d[4].sum = g_bgcj_d[4].sum - l_amt_t + g_bgcj_d[4].amt7
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt7
            #add-point:ON CHANGE amt7 name="input.g.page1.amt7"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD num8
            #add-point:BEFORE FIELD num8 name="input.b.page1.num8"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD num8
            
            #add-point:AFTER FIELD num8 name="input.a.page1.num8"
            IF cl_null(g_bgcj_d[l_ac].num8) THEN
               LET g_bgcj_d[l_ac].num8 =0 
            END IF
            
            LET l_num = g_bgcj_d[1].num8 + g_bgcj_d[2].num8 + g_bgcj_d[3].num8
            IF l_num < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'abg-00213'
               LET g_errparam.extend = g_bgcj_d[l_ac].num8
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_bgcj_d[l_ac].num8 = g_bgcj_d_t.num8
               LET g_bgcj_d[l_ac].amt8 = g_bgcj_d[l_ac].num8*(g_bgcj_d[1].price8+g_bgcj_d[l_ac].price8)+g_bgcj_d[1].num8*g_bgcj_d[l_ac].price8
               CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt8,2) 
                  RETURNING g_bgcj_d[l_ac].amt8
               NEXT FIELD CURRENT
            END IF
            LET l_amt_t = g_bgcj_d[l_ac].amt8
            IF NOT cl_null(g_bgcj_d[l_ac].price8) THEN
               #调整金额=调整数量*（基准单价+调整单价） + 基准数量*调整单价
               LET g_bgcj_d[l_ac].amt8 = g_bgcj_d[l_ac].num8*(g_bgcj_d[1].price8+g_bgcj_d[l_ac].price8)+g_bgcj_d[1].num8*g_bgcj_d[l_ac].price8
               CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt8,2) 
                  RETURNING g_bgcj_d[l_ac].amt8
               LET l_amt = g_bgcj_d[1].amt8 + g_bgcj_d[2].amt8 + g_bgcj_d[3].amt8
               IF l_amt < 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'abg-00215'
                  LET g_errparam.extend = g_bgcj_d[l_ac].num8
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_bgcj_d[l_ac].num8 = g_bgcj_d_t.num8
                  LET g_bgcj_d[l_ac].amt8 = g_bgcj_d[l_ac].num8*(g_bgcj_d[1].price8+g_bgcj_d[l_ac].price8)+g_bgcj_d[1].num8*g_bgcj_d[l_ac].price8
                  CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt8,2) 
                     RETURNING g_bgcj_d[l_ac].amt8
                  NEXT FIELD CURRENT
               END IF
            END IF
               
            LET g_bgcj_d[l_ac].sum = g_bgcj_d[l_ac].sum - l_amt_t + g_bgcj_d[l_ac].amt8
            LET g_bgcj_d[4].num8 = l_num
            LET l_amt_t = g_bgcj_d[4].amt8
            LET g_bgcj_d[4].amt8 = l_amt
            LET g_bgcj_d[4].sum = g_bgcj_d[4].sum - l_amt_t + g_bgcj_d[4].amt8
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE num8
            #add-point:ON CHANGE num8 name="input.g.page1.num8"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD price8
            #add-point:BEFORE FIELD price8 name="input.b.page1.price8"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD price8
            
            #add-point:AFTER FIELD price8 name="input.a.page1.price8"
            IF cl_null(g_bgcj_d[l_ac].price8) THEN
               LET g_bgcj_d[l_ac].price8 = 0
            END IF
            
            LET l_price = g_bgcj_d[1].price8 + g_bgcj_d[2].price8 + g_bgcj_d[3].price8
            IF l_price < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'abg-00214'
               LET g_errparam.extend = g_bgcj_d[l_ac].price8
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_bgcj_d[l_ac].price8 = g_bgcj_d_t.price8
               LET g_bgcj_d[l_ac].amt8 = g_bgcj_d[l_ac].num8*(g_bgcj_d[1].price8+g_bgcj_d[l_ac].price8)+g_bgcj_d[1].num8*g_bgcj_d[l_ac].price8
               CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt8,2) 
                  RETURNING g_bgcj_d[l_ac].amt8
               NEXT FIELD CURRENT
            END IF
            CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].price8,1) 
               RETURNING g_bgcj_d[l_ac].price8
            LET l_amt_t = g_bgcj_d[l_ac].amt8
            IF NOT cl_null(g_bgcj_d[l_ac].num8) THEN
               #调整金额=调整数量*（基准单价+调整单价） + 基准数量*调整单价
               LET g_bgcj_d[l_ac].amt8 = g_bgcj_d[l_ac].num8*(g_bgcj_d[1].price8+g_bgcj_d[l_ac].price8)+g_bgcj_d[1].num8*g_bgcj_d[l_ac].price8
               CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt8,2) 
                  RETURNING g_bgcj_d[l_ac].amt8
               LET l_amt = g_bgcj_d[1].amt8 + g_bgcj_d[2].amt8 + g_bgcj_d[3].amt8
               IF l_amt < 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'abg-00215'
                  LET g_errparam.extend = g_bgcj_d[l_ac].price8
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_bgcj_d[l_ac].price8 = g_bgcj_d_t.price8
                  LET g_bgcj_d[l_ac].amt8 = g_bgcj_d[l_ac].num8*(g_bgcj_d[1].price8+g_bgcj_d[l_ac].price8)+g_bgcj_d[1].num8*g_bgcj_d[l_ac].price8
                  CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt8,2) 
                     RETURNING g_bgcj_d[l_ac].amt8
                  NEXT FIELD CURRENT
               END IF
            END IF
            LET g_bgcj_d[l_ac].sum = g_bgcj_d[l_ac].sum - l_amt_t + g_bgcj_d[l_ac].amt8
            LET g_bgcj_d[4].price8 = l_price
            LET l_amt_t = g_bgcj_d[4].amt8
            LET g_bgcj_d[4].amt8 = l_amt
            LET g_bgcj_d[4].sum = g_bgcj_d[4].sum - l_amt_t + g_bgcj_d[4].amt8
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE price8
            #add-point:ON CHANGE price8 name="input.g.page1.price8"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt8
            #add-point:BEFORE FIELD amt8 name="input.b.page1.amt8"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt8
            
            #add-point:AFTER FIELD amt8 name="input.a.page1.amt8"
            IF cl_null(g_bgcj_d[l_ac].amt8) THEN
               LET g_bgcj_d[l_ac].amt8 =0 
            END IF
            LET l_amt = g_bgcj_d[1].amt8 + g_bgcj_d[2].amt8 + g_bgcj_d[3].amt8
            IF l_amt < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'abg-00215'
               LET g_errparam.extend = g_bgcj_d[l_ac].amt8
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_bgcj_d[l_ac].amt8 = g_bgcj_d_t.amt8
               NEXT FIELD CURRENT
            END IF
               
            LET g_bgcj_d[l_ac].sum = g_bgcj_d[l_ac].sum - g_bgcj_d_t.amt8 + g_bgcj_d[l_ac].amt8
            LET l_amt_t = g_bgcj_d[4].amt8
            LET g_bgcj_d[4].amt8 = l_amt
            LET g_bgcj_d[4].sum = g_bgcj_d[4].sum - l_amt_t + g_bgcj_d[4].amt8
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt8
            #add-point:ON CHANGE amt8 name="input.g.page1.amt8"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD num9
            #add-point:BEFORE FIELD num9 name="input.b.page1.num9"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD num9
            
            #add-point:AFTER FIELD num9 name="input.a.page1.num9"
            IF cl_null(g_bgcj_d[l_ac].num9) THEN
               LET g_bgcj_d[l_ac].num9 =0 
            END IF
            
            LET l_num = g_bgcj_d[1].num9 + g_bgcj_d[2].num9 + g_bgcj_d[3].num9
            IF l_num < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'abg-00213'
               LET g_errparam.extend = g_bgcj_d[l_ac].num9
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_bgcj_d[l_ac].num9 = g_bgcj_d_t.num9
               LET g_bgcj_d[l_ac].amt9 = g_bgcj_d[l_ac].num9*(g_bgcj_d[1].price9+g_bgcj_d[l_ac].price9)+g_bgcj_d[1].num9*g_bgcj_d[l_ac].price9
               CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt9,2) 
                  RETURNING g_bgcj_d[l_ac].amt9
               NEXT FIELD CURRENT
            END IF
            LET l_amt_t = g_bgcj_d[l_ac].amt9      
            IF NOT cl_null(g_bgcj_d[l_ac].price9) THEN
               #调整金额=调整数量*（基准单价+调整单价） + 基准数量*调整单价
               LET g_bgcj_d[l_ac].amt9 = g_bgcj_d[l_ac].num9*(g_bgcj_d[1].price9+g_bgcj_d[l_ac].price9)+g_bgcj_d[1].num9*g_bgcj_d[l_ac].price9
               CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt9,2) 
                  RETURNING g_bgcj_d[l_ac].amt9
               LET l_amt = g_bgcj_d[1].amt9 + g_bgcj_d[2].amt9 + g_bgcj_d[3].amt9
               IF l_amt < 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'abg-00215'
                  LET g_errparam.extend = g_bgcj_d[l_ac].num9
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_bgcj_d[l_ac].num9 = g_bgcj_d_t.num9
                  LET g_bgcj_d[l_ac].amt9 = g_bgcj_d[l_ac].num9*(g_bgcj_d[1].price9+g_bgcj_d[l_ac].price9)+g_bgcj_d[1].num9*g_bgcj_d[l_ac].price9
                  CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt9,2) 
                     RETURNING g_bgcj_d[l_ac].amt9
                  NEXT FIELD CURRENT
               END IF
            END IF
               
            LET g_bgcj_d[l_ac].sum = g_bgcj_d[l_ac].sum - l_amt_t + g_bgcj_d[l_ac].amt9
            LET g_bgcj_d[4].num9 = l_num
            LET l_amt_t = g_bgcj_d[4].amt9
            LET g_bgcj_d[4].amt9 = l_amt
            LET g_bgcj_d[4].sum = g_bgcj_d[4].sum - l_amt_t + g_bgcj_d[4].amt9
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE num9
            #add-point:ON CHANGE num9 name="input.g.page1.num9"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD price9
            #add-point:BEFORE FIELD price9 name="input.b.page1.price9"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD price9
            
            #add-point:AFTER FIELD price9 name="input.a.page1.price9"
            IF cl_null(g_bgcj_d[l_ac].price9) THEN
               LET g_bgcj_d[l_ac].price9 = 0
            END IF
            
            LET l_price = g_bgcj_d[1].price9 + g_bgcj_d[2].price9 + g_bgcj_d[3].price9
            IF l_price < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'abg-00214'
               LET g_errparam.extend = g_bgcj_d[l_ac].price9
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_bgcj_d[l_ac].price9 = g_bgcj_d_t.price9
               LET g_bgcj_d[l_ac].amt9 = g_bgcj_d[l_ac].num9*(g_bgcj_d[1].price9+g_bgcj_d[l_ac].price9)+g_bgcj_d[1].num9*g_bgcj_d[l_ac].price9
               CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt9,2) 
                  RETURNING g_bgcj_d[l_ac].amt9
               NEXT FIELD CURRENT
            END IF
            CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].price9,1) 
               RETURNING g_bgcj_d[l_ac].price9
            LET l_amt_t = g_bgcj_d[l_ac].amt9         
            IF NOT cl_null(g_bgcj_d[l_ac].num9) THEN
               #调整金额=调整数量*（基准单价+调整单价） + 基准数量*调整单价
               LET g_bgcj_d[l_ac].amt9 = g_bgcj_d[l_ac].num9*(g_bgcj_d[1].price9+g_bgcj_d[l_ac].price9)+g_bgcj_d[1].num9*g_bgcj_d[l_ac].price9
               CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt9,2) 
                  RETURNING g_bgcj_d[l_ac].amt9
               LET l_amt = g_bgcj_d[1].amt9 + g_bgcj_d[2].amt9 + g_bgcj_d[3].amt9
               IF l_amt < 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'abg-00215'
                  LET g_errparam.extend = g_bgcj_d[l_ac].price9
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_bgcj_d[l_ac].price9 = g_bgcj_d_t.price9
                  LET g_bgcj_d[l_ac].amt9 = g_bgcj_d[l_ac].num9*(g_bgcj_d[1].price9+g_bgcj_d[l_ac].price9)+g_bgcj_d[1].num9*g_bgcj_d[l_ac].price9
                  CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt9,2) 
                     RETURNING g_bgcj_d[l_ac].amt9
                  NEXT FIELD CURRENT
               END IF
            END IF
            LET g_bgcj_d[l_ac].sum = g_bgcj_d[l_ac].sum - l_amt_t + g_bgcj_d[l_ac].amt9
            LET g_bgcj_d[4].price9 = l_price
            LET l_amt_t = g_bgcj_d[4].amt9
            LET g_bgcj_d[4].amt9 = l_amt
            LET g_bgcj_d[4].sum = g_bgcj_d[4].sum - l_amt_t + g_bgcj_d[4].amt9
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE price9
            #add-point:ON CHANGE price9 name="input.g.page1.price9"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt9
            #add-point:BEFORE FIELD amt9 name="input.b.page1.amt9"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt9
            
            #add-point:AFTER FIELD amt9 name="input.a.page1.amt9"
            IF cl_null(g_bgcj_d[l_ac].amt9) THEN
               LET g_bgcj_d[l_ac].amt9 =0 
            END IF
            LET l_amt = g_bgcj_d[1].amt9 + g_bgcj_d[2].amt9 + g_bgcj_d[3].amt9
            IF l_amt < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'abg-00215'
               LET g_errparam.extend = g_bgcj_d[l_ac].amt9
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_bgcj_d[l_ac].amt9 = g_bgcj_d_t.amt9
               NEXT FIELD CURRENT
            END IF
               
            LET g_bgcj_d[l_ac].sum = g_bgcj_d[l_ac].sum - g_bgcj_d_t.amt9 + g_bgcj_d[l_ac].amt9
            LET l_amt_t = g_bgcj_d[4].amt9
            LET g_bgcj_d[4].amt9 = l_amt
            LET g_bgcj_d[4].sum = g_bgcj_d[4].sum - l_amt_t + g_bgcj_d[4].amt9
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt9
            #add-point:ON CHANGE amt9 name="input.g.page1.amt9"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD num10
            #add-point:BEFORE FIELD num10 name="input.b.page1.num10"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD num10
            
            #add-point:AFTER FIELD num10 name="input.a.page1.num10"
            IF cl_null(g_bgcj_d[l_ac].num10) THEN
               LET g_bgcj_d[l_ac].num10 =0 
            END IF
            
            LET l_num = g_bgcj_d[1].num10 + g_bgcj_d[2].num10 + g_bgcj_d[3].num10
            IF l_num < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'abg-00213'
               LET g_errparam.extend = g_bgcj_d[l_ac].num10
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_bgcj_d[l_ac].num10 = g_bgcj_d_t.num10
               LET g_bgcj_d[l_ac].amt10 = g_bgcj_d[l_ac].num10*(g_bgcj_d[1].price10+g_bgcj_d[l_ac].price10)+g_bgcj_d[1].num10*g_bgcj_d[l_ac].price10
               CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt10,2) 
                  RETURNING g_bgcj_d[l_ac].amt10
               NEXT FIELD CURRENT
            END IF
            LET l_amt_t = g_bgcj_d[l_ac].amt10               
            IF NOT cl_null(g_bgcj_d[l_ac].price10) THEN
               #调整金额=调整数量*（基准单价+调整单价） + 基准数量*调整单价
               LET g_bgcj_d[l_ac].amt10 = g_bgcj_d[l_ac].num10*(g_bgcj_d[1].price10+g_bgcj_d[l_ac].price10)+g_bgcj_d[1].num10*g_bgcj_d[l_ac].price10
               CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt10,2) 
                  RETURNING g_bgcj_d[l_ac].amt10
               LET l_amt = g_bgcj_d[1].amt10 + g_bgcj_d[2].amt10 + g_bgcj_d[3].amt10
               IF l_amt < 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'abg-00215'
                  LET g_errparam.extend = g_bgcj_d[l_ac].num10
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_bgcj_d[l_ac].num10 = g_bgcj_d_t.num10
                  LET g_bgcj_d[l_ac].amt10 = g_bgcj_d[l_ac].num10*(g_bgcj_d[1].price10+g_bgcj_d[l_ac].price10)+g_bgcj_d[1].num10*g_bgcj_d[l_ac].price10
                  CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt10,2) 
                     RETURNING g_bgcj_d[l_ac].amt10
                  NEXT FIELD CURRENT
               END IF
            END IF
               
            LET g_bgcj_d[l_ac].sum = g_bgcj_d[l_ac].sum - l_amt_t + g_bgcj_d[l_ac].amt10
            LET g_bgcj_d[4].num10 = l_num
            LET l_amt_t = g_bgcj_d[4].amt10
            LET g_bgcj_d[4].amt10 = l_amt
            LET g_bgcj_d[4].sum = g_bgcj_d[4].sum - l_amt_t + g_bgcj_d[4].amt10
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE num10
            #add-point:ON CHANGE num10 name="input.g.page1.num10"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD price10
            #add-point:BEFORE FIELD price10 name="input.b.page1.price10"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD price10
            
            #add-point:AFTER FIELD price10 name="input.a.page1.price10"
            IF cl_null(g_bgcj_d[l_ac].price10) THEN
               LET g_bgcj_d[l_ac].price10 = 0
            END IF
            
            LET l_price = g_bgcj_d[1].price10 + g_bgcj_d[2].price10 + g_bgcj_d[3].price10
            IF l_price < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'abg-00214'
               LET g_errparam.extend = g_bgcj_d[l_ac].price10
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_bgcj_d[l_ac].price10 = g_bgcj_d_t.price10
               LET g_bgcj_d[l_ac].amt10 = g_bgcj_d[l_ac].num10*(g_bgcj_d[1].price10+g_bgcj_d[l_ac].price10)+g_bgcj_d[1].num10*g_bgcj_d[l_ac].price10
               CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt10,2) 
                  RETURNING g_bgcj_d[l_ac].amt10
               NEXT FIELD CURRENT
            END IF
            CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].price10,1) 
               RETURNING g_bgcj_d[l_ac].price10
            LET l_amt_t = g_bgcj_d[l_ac].amt10
            IF NOT cl_null(g_bgcj_d[l_ac].num10) THEN
               #调整金额=调整数量*（基准单价+调整单价） + 基准数量*调整单价
               LET g_bgcj_d[l_ac].amt10 = g_bgcj_d[l_ac].num10*(g_bgcj_d[1].price10+g_bgcj_d[l_ac].price10)+g_bgcj_d[1].num10*g_bgcj_d[l_ac].price10
               CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt10,2) 
                  RETURNING g_bgcj_d[l_ac].amt10
               LET l_amt = g_bgcj_d[1].amt10 + g_bgcj_d[2].amt10 + g_bgcj_d[3].amt10
               IF l_amt < 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'abg-00215'
                  LET g_errparam.extend = g_bgcj_d[l_ac].price10
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_bgcj_d[l_ac].price10 = g_bgcj_d_t.price10
                  LET g_bgcj_d[l_ac].amt10 = g_bgcj_d[l_ac].num10*(g_bgcj_d[1].price10+g_bgcj_d[l_ac].price10)+g_bgcj_d[1].num10*g_bgcj_d[l_ac].price10
                  CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt10,2) 
                     RETURNING g_bgcj_d[l_ac].amt10
                  NEXT FIELD CURRENT
               END IF
            END IF
            LET g_bgcj_d[l_ac].sum = g_bgcj_d[l_ac].sum - l_amt_t + g_bgcj_d[l_ac].amt10
            LET g_bgcj_d[4].price10 = l_price
            LET l_amt_t = g_bgcj_d[4].amt10
            LET g_bgcj_d[4].amt10 = l_amt
            LET g_bgcj_d[4].sum = g_bgcj_d[4].sum - l_amt_t + g_bgcj_d[4].amt10
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE price10
            #add-point:ON CHANGE price10 name="input.g.page1.price10"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt10
            #add-point:BEFORE FIELD amt10 name="input.b.page1.amt10"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt10
            
            #add-point:AFTER FIELD amt10 name="input.a.page1.amt10"
            IF cl_null(g_bgcj_d[l_ac].amt10) THEN
               LET g_bgcj_d[l_ac].amt10 =0 
            END IF
            LET l_amt = g_bgcj_d[1].amt10 + g_bgcj_d[2].amt10 + g_bgcj_d[3].amt10
            IF l_amt < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'abg-00215'
               LET g_errparam.extend = g_bgcj_d[l_ac].amt10
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_bgcj_d[l_ac].amt10 = g_bgcj_d_t.amt10
               NEXT FIELD CURRENT
            END IF
               
            LET g_bgcj_d[l_ac].sum = g_bgcj_d[l_ac].sum - g_bgcj_d_t.amt10 + g_bgcj_d[l_ac].amt10
            LET l_amt_t = g_bgcj_d[4].amt10
            LET g_bgcj_d[4].amt10 = l_amt
            LET g_bgcj_d[4].sum = g_bgcj_d[4].sum - l_amt_t + g_bgcj_d[4].amt10
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt10
            #add-point:ON CHANGE amt10 name="input.g.page1.amt10"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD num11
            #add-point:BEFORE FIELD num11 name="input.b.page1.num11"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD num11
            
            #add-point:AFTER FIELD num11 name="input.a.page1.num11"
            IF cl_null(g_bgcj_d[l_ac].num11) THEN
               LET g_bgcj_d[l_ac].num11 =0 
            END IF
            
            LET l_num = g_bgcj_d[1].num11 + g_bgcj_d[2].num11 + g_bgcj_d[3].num11
            IF l_num < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'abg-00213'
               LET g_errparam.extend = g_bgcj_d[l_ac].num11
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_bgcj_d[l_ac].num11 = g_bgcj_d_t.num11
               LET g_bgcj_d[l_ac].amt11 = g_bgcj_d[l_ac].num11*(g_bgcj_d[1].price11+g_bgcj_d[l_ac].price11)+g_bgcj_d[1].num11*g_bgcj_d[l_ac].price11
               CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt11,2) 
                  RETURNING g_bgcj_d[l_ac].amt11
               NEXT FIELD CURRENT
            END IF
            LET l_amt_t = g_bgcj_d[l_ac].amt11
            IF NOT cl_null(g_bgcj_d[l_ac].price11) THEN
               #调整金额=调整数量*（基准单价+调整单价） + 基准数量*调整单价
               LET g_bgcj_d[l_ac].amt11 = g_bgcj_d[l_ac].num11*(g_bgcj_d[1].price11+g_bgcj_d[l_ac].price11)+g_bgcj_d[1].num11*g_bgcj_d[l_ac].price11
               CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt11,2) 
                  RETURNING g_bgcj_d[l_ac].amt11
               LET l_amt = g_bgcj_d[1].amt11 + g_bgcj_d[2].amt11 + g_bgcj_d[3].amt11
               IF l_amt < 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'abg-00215'
                  LET g_errparam.extend = g_bgcj_d[l_ac].num11
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_bgcj_d[l_ac].num11 = g_bgcj_d_t.num11
                  LET g_bgcj_d[l_ac].amt11 = g_bgcj_d[l_ac].num11*(g_bgcj_d[1].price11+g_bgcj_d[l_ac].price11)+g_bgcj_d[1].num11*g_bgcj_d[l_ac].price11
                  CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt11,2) 
                     RETURNING g_bgcj_d[l_ac].amt11
                  NEXT FIELD CURRENT
               END IF
            END IF
               
            LET g_bgcj_d[l_ac].sum = g_bgcj_d[l_ac].sum - l_amt_t + g_bgcj_d[l_ac].amt11
            LET g_bgcj_d[4].num11 = l_num
            LET l_amt_t = g_bgcj_d[4].amt11
            LET g_bgcj_d[4].amt11 = l_amt
            LET g_bgcj_d[4].sum = g_bgcj_d[4].sum - l_amt_t + g_bgcj_d[4].amt11
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE num11
            #add-point:ON CHANGE num11 name="input.g.page1.num11"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD price11
            #add-point:BEFORE FIELD price11 name="input.b.page1.price11"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD price11
            
            #add-point:AFTER FIELD price11 name="input.a.page1.price11"
            IF cl_null(g_bgcj_d[l_ac].price11) THEN
               LET g_bgcj_d[l_ac].price11 = 0
            END IF
            
            LET l_price = g_bgcj_d[1].price11 + g_bgcj_d[2].price11 + g_bgcj_d[3].price11
            IF l_price < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'abg-00214'
               LET g_errparam.extend = g_bgcj_d[l_ac].price11
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_bgcj_d[l_ac].price11 = g_bgcj_d_t.price11
               LET g_bgcj_d[l_ac].amt11 = g_bgcj_d[l_ac].num11*(g_bgcj_d[1].price11+g_bgcj_d[l_ac].price11)+g_bgcj_d[1].num11*g_bgcj_d[l_ac].price11
               CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt11,2) 
                  RETURNING g_bgcj_d[l_ac].amt11
               NEXT FIELD CURRENT
            END IF
            CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].price11,1) 
               RETURNING g_bgcj_d[l_ac].price11
            LET l_amt_t = g_bgcj_d[l_ac].amt11
            IF NOT cl_null(g_bgcj_d[l_ac].num11) THEN
               #调整金额=调整数量*（基准单价+调整单价） + 基准数量*调整单价
               LET g_bgcj_d[l_ac].amt11 = g_bgcj_d[l_ac].num11*(g_bgcj_d[1].price11+g_bgcj_d[l_ac].price11)+g_bgcj_d[1].num11*g_bgcj_d[l_ac].price11
               CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt11,2) 
                  RETURNING g_bgcj_d[l_ac].amt11
               LET l_amt = g_bgcj_d[1].amt11 + g_bgcj_d[2].amt11 + g_bgcj_d[3].amt11
               IF l_amt < 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'abg-00215'
                  LET g_errparam.extend = g_bgcj_d[l_ac].price11
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_bgcj_d[l_ac].price11 = g_bgcj_d_t.price11
                  LET g_bgcj_d[l_ac].amt11 = g_bgcj_d[l_ac].num11*(g_bgcj_d[1].price11+g_bgcj_d[l_ac].price11)+g_bgcj_d[1].num11*g_bgcj_d[l_ac].price11
                  CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt11,2) 
                     RETURNING g_bgcj_d[l_ac].amt11
                  NEXT FIELD CURRENT
               END IF
            END IF
            LET g_bgcj_d[l_ac].sum = g_bgcj_d[l_ac].sum - l_amt_t + g_bgcj_d[l_ac].amt11
            LET g_bgcj_d[4].price11 = l_price
            LET l_amt_t = g_bgcj_d[4].amt11
            LET g_bgcj_d[4].amt11 = l_amt
            LET g_bgcj_d[4].sum = g_bgcj_d[4].sum - l_amt_t + g_bgcj_d[4].amt11
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE price11
            #add-point:ON CHANGE price11 name="input.g.page1.price11"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt11
            #add-point:BEFORE FIELD amt11 name="input.b.page1.amt11"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt11
            
            #add-point:AFTER FIELD amt11 name="input.a.page1.amt11"
            IF cl_null(g_bgcj_d[l_ac].amt11) THEN
               LET g_bgcj_d[l_ac].amt11 =0 
            END IF
            LET l_amt = g_bgcj_d[1].amt11 + g_bgcj_d[2].amt11 + g_bgcj_d[3].amt11
            IF l_amt < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'abg-00215'
               LET g_errparam.extend = g_bgcj_d[l_ac].amt11
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_bgcj_d[l_ac].amt11 = g_bgcj_d_t.amt11
               NEXT FIELD CURRENT
            END IF
               
            LET g_bgcj_d[l_ac].sum = g_bgcj_d[l_ac].sum - g_bgcj_d_t.amt11 + g_bgcj_d[l_ac].amt11
            LET l_amt_t = g_bgcj_d[4].amt11
            LET g_bgcj_d[4].amt11 = l_amt
            LET g_bgcj_d[4].sum = g_bgcj_d[4].sum - l_amt_t + g_bgcj_d[4].amt11
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt11
            #add-point:ON CHANGE amt11 name="input.g.page1.amt11"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD num12
            #add-point:BEFORE FIELD num12 name="input.b.page1.num12"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD num12
            
            #add-point:AFTER FIELD num12 name="input.a.page1.num12"
            IF cl_null(g_bgcj_d[l_ac].num12) THEN
               LET g_bgcj_d[l_ac].num12 =0 
            END IF
            
            LET l_num = g_bgcj_d[1].num12 + g_bgcj_d[2].num12 + g_bgcj_d[3].num12
            IF l_num < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'abg-00213'
               LET g_errparam.extend = g_bgcj_d[l_ac].num12
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_bgcj_d[l_ac].num12 = g_bgcj_d_t.num12
               LET g_bgcj_d[l_ac].amt12 = g_bgcj_d[l_ac].num12*(g_bgcj_d[1].price12+g_bgcj_d[l_ac].price12)+g_bgcj_d[1].num12*g_bgcj_d[l_ac].price12
               CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt12,2) 
                  RETURNING g_bgcj_d[l_ac].amt12
               NEXT FIELD CURRENT
            END IF
            LET l_amt_t = g_bgcj_d[l_ac].amt12
            IF NOT cl_null(g_bgcj_d[l_ac].price12) THEN
               #调整金额=调整数量*（基准单价+调整单价） + 基准数量*调整单价
               LET g_bgcj_d[l_ac].amt12 = g_bgcj_d[l_ac].num12*(g_bgcj_d[1].price12+g_bgcj_d[l_ac].price12)+g_bgcj_d[1].num12*g_bgcj_d[l_ac].price12
               CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt12,2) 
                  RETURNING g_bgcj_d[l_ac].amt12
               LET l_amt = g_bgcj_d[1].amt12 + g_bgcj_d[2].amt12 + g_bgcj_d[3].amt12
               IF l_amt < 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'abg-00215'
                  LET g_errparam.extend = g_bgcj_d[l_ac].num12
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_bgcj_d[l_ac].num12 = g_bgcj_d_t.num12
                  LET g_bgcj_d[l_ac].amt12 = g_bgcj_d[l_ac].num12*(g_bgcj_d[1].price12+g_bgcj_d[l_ac].price12)+g_bgcj_d[1].num12*g_bgcj_d[l_ac].price12
                  CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt12,2) 
                     RETURNING g_bgcj_d[l_ac].amt12
                  NEXT FIELD CURRENT
               END IF
            END IF
               
            LET g_bgcj_d[l_ac].sum = g_bgcj_d[l_ac].sum - l_amt_t + g_bgcj_d[l_ac].amt12
            LET g_bgcj_d[4].num12 = l_num
            LET l_amt_t = g_bgcj_d[4].amt12
            LET g_bgcj_d[4].amt12 = l_amt
            LET g_bgcj_d[4].sum = g_bgcj_d[4].sum - l_amt_t + g_bgcj_d[4].amt12
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE num12
            #add-point:ON CHANGE num12 name="input.g.page1.num12"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD price12
            #add-point:BEFORE FIELD price12 name="input.b.page1.price12"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD price12
            
            #add-point:AFTER FIELD price12 name="input.a.page1.price12"
            IF cl_null(g_bgcj_d[l_ac].price12) THEN
               LET g_bgcj_d[l_ac].price12 = 0
            END IF
            
            LET l_price = g_bgcj_d[1].price12 + g_bgcj_d[2].price12 + g_bgcj_d[3].price12
            IF l_price < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'abg-00214'
               LET g_errparam.extend = g_bgcj_d[l_ac].price12
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_bgcj_d[l_ac].price12 = g_bgcj_d_t.price12
               LET g_bgcj_d[l_ac].amt12 = g_bgcj_d[l_ac].num12*(g_bgcj_d[1].price12+g_bgcj_d[l_ac].price12)+g_bgcj_d[1].num12*g_bgcj_d[l_ac].price12
               CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt12,2) 
                  RETURNING g_bgcj_d[l_ac].amt12
               NEXT FIELD CURRENT
            END IF
            CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].price12,1) 
               RETURNING g_bgcj_d[l_ac].price12
            LET l_amt_t = g_bgcj_d[l_ac].amt12
            IF NOT cl_null(g_bgcj_d[l_ac].num12) THEN
               #调整金额=调整数量*（基准单价+调整单价） + 基准数量*调整单价
               LET g_bgcj_d[l_ac].amt12 = g_bgcj_d[l_ac].num12*(g_bgcj_d[1].price12+g_bgcj_d[l_ac].price12)+g_bgcj_d[1].num12*g_bgcj_d[l_ac].price12
               CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt12,2) 
                  RETURNING g_bgcj_d[l_ac].amt12
               LET l_amt = g_bgcj_d[1].amt12 + g_bgcj_d[2].amt12 + g_bgcj_d[3].amt12
               IF l_amt < 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'abg-00215'
                  LET g_errparam.extend = g_bgcj_d[l_ac].price12
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_bgcj_d[l_ac].price12 = g_bgcj_d_t.price12
                  LET g_bgcj_d[l_ac].amt12 = g_bgcj_d[l_ac].num12*(g_bgcj_d[1].price12+g_bgcj_d[l_ac].price12)+g_bgcj_d[1].num12*g_bgcj_d[l_ac].price12
                  CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt12,2) 
                     RETURNING g_bgcj_d[l_ac].amt12
                  NEXT FIELD CURRENT
               END IF
            END IF
            LET g_bgcj_d[l_ac].sum = g_bgcj_d[l_ac].sum - l_amt_t + g_bgcj_d[l_ac].amt12
            LET g_bgcj_d[4].price12 = l_price
            LET l_amt_t = g_bgcj_d[4].amt12
            LET g_bgcj_d[4].amt12 = l_amt
            LET g_bgcj_d[4].sum = g_bgcj_d[4].sum - l_amt_t + g_bgcj_d[4].amt12
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE price12
            #add-point:ON CHANGE price12 name="input.g.page1.price12"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt12
            #add-point:BEFORE FIELD amt12 name="input.b.page1.amt12"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt12
            
            #add-point:AFTER FIELD amt12 name="input.a.page1.amt12"
            IF cl_null(g_bgcj_d[l_ac].amt12) THEN
               LET g_bgcj_d[l_ac].amt12 =0 
            END IF
            LET l_amt = g_bgcj_d[1].amt12 + g_bgcj_d[2].amt12 + g_bgcj_d[3].amt12
            IF l_amt < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'abg-00215'
               LET g_errparam.extend = g_bgcj_d[l_ac].amt12
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_bgcj_d[l_ac].amt12 = g_bgcj_d_t.amt12
               NEXT FIELD CURRENT
            END IF
               
            LET g_bgcj_d[l_ac].sum = g_bgcj_d[l_ac].sum - g_bgcj_d_t.amt12 + g_bgcj_d[l_ac].amt12
            LET l_amt_t = g_bgcj_d[4].amt12
            LET g_bgcj_d[4].amt12 = l_amt
            LET g_bgcj_d[4].sum = g_bgcj_d[4].sum - l_amt_t + g_bgcj_d[4].amt12
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt12
            #add-point:ON CHANGE amt12 name="input.g.page1.amt12"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD num13
            #add-point:BEFORE FIELD num13 name="input.b.page1.num13"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD num13
            
            #add-point:AFTER FIELD num13 name="input.a.page1.num13"
            IF cl_null(g_bgcj_d[l_ac].num13) THEN
               LET g_bgcj_d[l_ac].num13 =0 
            END IF
            
            LET l_num = g_bgcj_d[1].num13 + g_bgcj_d[2].num13 + g_bgcj_d[3].num13
            IF l_num < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'abg-00213'
               LET g_errparam.extend = g_bgcj_d[l_ac].num13
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_bgcj_d[l_ac].num13 = g_bgcj_d_t.num13
               LET g_bgcj_d[l_ac].amt13 = g_bgcj_d[l_ac].num13*(g_bgcj_d[1].price13+g_bgcj_d[l_ac].price13)+g_bgcj_d[1].num13*g_bgcj_d[l_ac].price13
               CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt13,2) 
                  RETURNING g_bgcj_d[l_ac].amt13
               NEXT FIELD CURRENT
            END IF
            LET l_amt_t = g_bgcj_d[l_ac].amt13
            IF NOT cl_null(g_bgcj_d[l_ac].price13) THEN
               #调整金额=调整数量*（基准单价+调整单价） + 基准数量*调整单价
               LET g_bgcj_d[l_ac].amt13 = g_bgcj_d[l_ac].num13*(g_bgcj_d[1].price13+g_bgcj_d[l_ac].price13)+g_bgcj_d[1].num13*g_bgcj_d[l_ac].price13
               CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt13,2) 
                  RETURNING g_bgcj_d[l_ac].amt13
               LET l_amt = g_bgcj_d[1].amt13 + g_bgcj_d[2].amt13 + g_bgcj_d[3].amt13
               IF l_amt < 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'abg-00215'
                  LET g_errparam.extend = g_bgcj_d[l_ac].num13
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_bgcj_d[l_ac].num13 = g_bgcj_d_t.num13
                  LET g_bgcj_d[l_ac].amt13 = g_bgcj_d[l_ac].num13*(g_bgcj_d[1].price13+g_bgcj_d[l_ac].price13)+g_bgcj_d[1].num13*g_bgcj_d[l_ac].price13
                  CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt13,2) 
                     RETURNING g_bgcj_d[l_ac].amt13
                  NEXT FIELD CURRENT
               END IF
            END IF
               
            LET g_bgcj_d[l_ac].sum = g_bgcj_d[l_ac].sum - l_amt_t + g_bgcj_d[l_ac].amt13
            LET g_bgcj_d[4].num13 = l_num
            LET l_amt_t = g_bgcj_d[4].amt13
            LET g_bgcj_d[4].amt13 = l_amt
            LET g_bgcj_d[4].sum = g_bgcj_d[4].sum - l_amt_t + g_bgcj_d[4].amt13
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE num13
            #add-point:ON CHANGE num13 name="input.g.page1.num13"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD price13
            #add-point:BEFORE FIELD price13 name="input.b.page1.price13"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD price13
            
            #add-point:AFTER FIELD price13 name="input.a.page1.price13"
            IF cl_null(g_bgcj_d[l_ac].price13) THEN
               LET g_bgcj_d[l_ac].price13 = 0
            END IF
            
            LET l_price = g_bgcj_d[1].price13 + g_bgcj_d[2].price13 + g_bgcj_d[3].price13
            IF l_price < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'abg-00214'
               LET g_errparam.extend = g_bgcj_d[l_ac].price13
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_bgcj_d[l_ac].price13 = g_bgcj_d_t.price13
               LET g_bgcj_d[l_ac].amt13 = g_bgcj_d[l_ac].num13*(g_bgcj_d[1].price13+g_bgcj_d[l_ac].price13)+g_bgcj_d[1].num13*g_bgcj_d[l_ac].price13
               CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt13,2) 
                  RETURNING g_bgcj_d[l_ac].amt13
               NEXT FIELD CURRENT
            END IF
            CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].price13,1) 
               RETURNING g_bgcj_d[l_ac].price13
            LET l_amt_t = g_bgcj_d[l_ac].amt13
            IF NOT cl_null(g_bgcj_d[l_ac].num13) THEN
               #调整金额=调整数量*（基准单价+调整单价） + 基准数量*调整单价
               LET g_bgcj_d[l_ac].amt13 = g_bgcj_d[l_ac].num13*(g_bgcj_d[1].price13+g_bgcj_d[l_ac].price13)+g_bgcj_d[1].num13*g_bgcj_d[l_ac].price13
               CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt13,2) 
                  RETURNING g_bgcj_d[l_ac].amt13
               LET l_amt = g_bgcj_d[1].amt13 + g_bgcj_d[2].amt13 + g_bgcj_d[3].amt13
               IF l_amt < 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'abg-00215'
                  LET g_errparam.extend = g_bgcj_d[l_ac].price13
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_bgcj_d[l_ac].price13 = g_bgcj_d_t.price13
                  LET g_bgcj_d[l_ac].amt13 = g_bgcj_d[l_ac].num13*(g_bgcj_d[1].price13+g_bgcj_d[l_ac].price13)+g_bgcj_d[1].num13*g_bgcj_d[l_ac].price13
                  CALL s_curr_round(g_bgcj_d[l_ac].bgcj007,g_bgcj100,g_bgcj_d[l_ac].amt13,2) 
                     RETURNING g_bgcj_d[l_ac].amt13
                  NEXT FIELD CURRENT
               END IF
            END IF
            LET g_bgcj_d[l_ac].sum = g_bgcj_d[l_ac].sum - l_amt_t + g_bgcj_d[l_ac].amt13
            LET g_bgcj_d[4].price13 = l_price
            LET l_amt_t = g_bgcj_d[4].amt13
            LET g_bgcj_d[4].amt13 = l_amt
            LET g_bgcj_d[4].sum = g_bgcj_d[4].sum - l_amt_t + g_bgcj_d[4].amt13
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE price13
            #add-point:ON CHANGE price13 name="input.g.page1.price13"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt13
            #add-point:BEFORE FIELD amt13 name="input.b.page1.amt13"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt13
            
            #add-point:AFTER FIELD amt13 name="input.a.page1.amt13"
            IF cl_null(g_bgcj_d[l_ac].amt13) THEN
               LET g_bgcj_d[l_ac].amt13 =0 
            END IF
            LET l_amt = g_bgcj_d[1].amt13 + g_bgcj_d[2].amt13 + g_bgcj_d[3].amt13
            IF l_amt < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'abg-00215'
               LET g_errparam.extend = g_bgcj_d[l_ac].amt13
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_bgcj_d[l_ac].amt13 = g_bgcj_d_t.amt13
               NEXT FIELD CURRENT
            END IF
               
            LET g_bgcj_d[l_ac].sum = g_bgcj_d[l_ac].sum - g_bgcj_d_t.amt13 + g_bgcj_d[l_ac].amt13
            LET l_amt_t = g_bgcj_d[4].amt13
            LET g_bgcj_d[4].amt13 = l_amt
            LET g_bgcj_d[4].sum = g_bgcj_d[4].sum - l_amt_t + g_bgcj_d[4].amt13
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt13
            #add-point:ON CHANGE amt13 name="input.g.page1.amt13"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sum
            #add-point:BEFORE FIELD sum name="input.b.page1.sum"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sum
            
            #add-point:AFTER FIELD sum name="input.a.page1.sum"

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sum
            #add-point:ON CHANGE sum name="input.g.page1.sum"

            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.bgcj001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj001
            #add-point:ON ACTION controlp INFIELD bgcj001 name="input.c.page1.bgcj001"

            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj002
            #add-point:ON ACTION controlp INFIELD bgcj002 name="input.c.page1.bgcj002"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgcj_d[l_ac].bgcj002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

 
            CALL q_bgaa001()                                #呼叫開窗
 
            LET g_bgcj_d[l_ac].bgcj002 = g_qryparam.return1              

            DISPLAY g_bgcj_d[l_ac].bgcj002 TO bgcj002              #

            NEXT FIELD bgcj002                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj003
            #add-point:ON ACTION controlp INFIELD bgcj003 name="input.c.page1.bgcj003"

            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj004
            #add-point:ON ACTION controlp INFIELD bgcj004 name="input.c.page1.bgcj004"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgcj_d[l_ac].bgcj004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

 
            CALL q_bgai002()                                #呼叫開窗
 
            LET g_bgcj_d[l_ac].bgcj004 = g_qryparam.return1              

            DISPLAY g_bgcj_d[l_ac].bgcj004 TO bgcj004              #

            NEXT FIELD bgcj004                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj005
            #add-point:ON ACTION controlp INFIELD bgcj005 name="input.c.page1.bgcj005"

            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj006
            #add-point:ON ACTION controlp INFIELD bgcj006 name="input.c.page1.bgcj006"

            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj007
            #add-point:ON ACTION controlp INFIELD bgcj007 name="input.c.page1.bgcj007"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgcj_d[l_ac].bgcj007             #給予default值
            LET g_qryparam.default2 = "" #g_bgcj_d[l_ac].ooef001 #组织编号
            #給予arg
            LET g_qryparam.arg1 = "" #

 
            CALL q_ooef001()                                #呼叫開窗
 
            LET g_bgcj_d[l_ac].bgcj007 = g_qryparam.return1              
            #LET g_bgcj_d[l_ac].ooef001 = g_qryparam.return2 
            DISPLAY g_bgcj_d[l_ac].bgcj007 TO bgcj007              #
            #DISPLAY g_bgcj_d[l_ac].ooef001 TO ooef001 #组织编号
            NEXT FIELD bgcj007                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj009
            #add-point:ON ACTION controlp INFIELD bgcj009 name="input.c.page1.bgcj009"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgcj_d[l_ac].bgcj009             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

 
            CALL q_bgas001()                                #呼叫開窗
 
            LET g_bgcj_d[l_ac].bgcj009 = g_qryparam.return1              

            DISPLAY g_bgcj_d[l_ac].bgcj009 TO bgcj009              #

            NEXT FIELD bgcj009                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj010
            #add-point:ON ACTION controlp INFIELD bgcj010 name="input.c.page1.bgcj010"

            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcjseq
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcjseq
            #add-point:ON ACTION controlp INFIELD bgcjseq name="input.c.page1.bgcjseq"

            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcj008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj008
            #add-point:ON ACTION controlp INFIELD bgcj008 name="input.c.page1.bgcj008"

            #END add-point
 
 
         #Ctrlp:input.c.page1.num1
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD num1
            #add-point:ON ACTION controlp INFIELD num1 name="input.c.page1.num1"

            #END add-point
 
 
         #Ctrlp:input.c.page1.price1
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD price1
            #add-point:ON ACTION controlp INFIELD price1 name="input.c.page1.price1"

            #END add-point
 
 
         #Ctrlp:input.c.page1.amt1
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt1
            #add-point:ON ACTION controlp INFIELD amt1 name="input.c.page1.amt1"

            #END add-point
 
 
         #Ctrlp:input.c.page1.num2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD num2
            #add-point:ON ACTION controlp INFIELD num2 name="input.c.page1.num2"

            #END add-point
 
 
         #Ctrlp:input.c.page1.price2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD price2
            #add-point:ON ACTION controlp INFIELD price2 name="input.c.page1.price2"

            #END add-point
 
 
         #Ctrlp:input.c.page1.amt2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt2
            #add-point:ON ACTION controlp INFIELD amt2 name="input.c.page1.amt2"

            #END add-point
 
 
         #Ctrlp:input.c.page1.num3
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD num3
            #add-point:ON ACTION controlp INFIELD num3 name="input.c.page1.num3"

            #END add-point
 
 
         #Ctrlp:input.c.page1.price3
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD price3
            #add-point:ON ACTION controlp INFIELD price3 name="input.c.page1.price3"

            #END add-point
 
 
         #Ctrlp:input.c.page1.amt3
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt3
            #add-point:ON ACTION controlp INFIELD amt3 name="input.c.page1.amt3"

            #END add-point
 
 
         #Ctrlp:input.c.page1.num4
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD num4
            #add-point:ON ACTION controlp INFIELD num4 name="input.c.page1.num4"

            #END add-point
 
 
         #Ctrlp:input.c.page1.price4
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD price4
            #add-point:ON ACTION controlp INFIELD price4 name="input.c.page1.price4"

            #END add-point
 
 
         #Ctrlp:input.c.page1.amt4
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt4
            #add-point:ON ACTION controlp INFIELD amt4 name="input.c.page1.amt4"

            #END add-point
 
 
         #Ctrlp:input.c.page1.num5
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD num5
            #add-point:ON ACTION controlp INFIELD num5 name="input.c.page1.num5"

            #END add-point
 
 
         #Ctrlp:input.c.page1.price5
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD price5
            #add-point:ON ACTION controlp INFIELD price5 name="input.c.page1.price5"

            #END add-point
 
 
         #Ctrlp:input.c.page1.amt5
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt5
            #add-point:ON ACTION controlp INFIELD amt5 name="input.c.page1.amt5"

            #END add-point
 
 
         #Ctrlp:input.c.page1.num6
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD num6
            #add-point:ON ACTION controlp INFIELD num6 name="input.c.page1.num6"

            #END add-point
 
 
         #Ctrlp:input.c.page1.price6
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD price6
            #add-point:ON ACTION controlp INFIELD price6 name="input.c.page1.price6"

            #END add-point
 
 
         #Ctrlp:input.c.page1.amt6
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt6
            #add-point:ON ACTION controlp INFIELD amt6 name="input.c.page1.amt6"

            #END add-point
 
 
         #Ctrlp:input.c.page1.num7
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD num7
            #add-point:ON ACTION controlp INFIELD num7 name="input.c.page1.num7"

            #END add-point
 
 
         #Ctrlp:input.c.page1.price7
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD price7
            #add-point:ON ACTION controlp INFIELD price7 name="input.c.page1.price7"

            #END add-point
 
 
         #Ctrlp:input.c.page1.amt7
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt7
            #add-point:ON ACTION controlp INFIELD amt7 name="input.c.page1.amt7"

            #END add-point
 
 
         #Ctrlp:input.c.page1.num8
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD num8
            #add-point:ON ACTION controlp INFIELD num8 name="input.c.page1.num8"

            #END add-point
 
 
         #Ctrlp:input.c.page1.price8
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD price8
            #add-point:ON ACTION controlp INFIELD price8 name="input.c.page1.price8"

            #END add-point
 
 
         #Ctrlp:input.c.page1.amt8
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt8
            #add-point:ON ACTION controlp INFIELD amt8 name="input.c.page1.amt8"

            #END add-point
 
 
         #Ctrlp:input.c.page1.num9
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD num9
            #add-point:ON ACTION controlp INFIELD num9 name="input.c.page1.num9"

            #END add-point
 
 
         #Ctrlp:input.c.page1.price9
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD price9
            #add-point:ON ACTION controlp INFIELD price9 name="input.c.page1.price9"

            #END add-point
 
 
         #Ctrlp:input.c.page1.amt9
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt9
            #add-point:ON ACTION controlp INFIELD amt9 name="input.c.page1.amt9"

            #END add-point
 
 
         #Ctrlp:input.c.page1.num10
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD num10
            #add-point:ON ACTION controlp INFIELD num10 name="input.c.page1.num10"

            #END add-point
 
 
         #Ctrlp:input.c.page1.price10
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD price10
            #add-point:ON ACTION controlp INFIELD price10 name="input.c.page1.price10"

            #END add-point
 
 
         #Ctrlp:input.c.page1.amt10
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt10
            #add-point:ON ACTION controlp INFIELD amt10 name="input.c.page1.amt10"

            #END add-point
 
 
         #Ctrlp:input.c.page1.num11
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD num11
            #add-point:ON ACTION controlp INFIELD num11 name="input.c.page1.num11"

            #END add-point
 
 
         #Ctrlp:input.c.page1.price11
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD price11
            #add-point:ON ACTION controlp INFIELD price11 name="input.c.page1.price11"

            #END add-point
 
 
         #Ctrlp:input.c.page1.amt11
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt11
            #add-point:ON ACTION controlp INFIELD amt11 name="input.c.page1.amt11"

            #END add-point
 
 
         #Ctrlp:input.c.page1.num12
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD num12
            #add-point:ON ACTION controlp INFIELD num12 name="input.c.page1.num12"

            #END add-point
 
 
         #Ctrlp:input.c.page1.price12
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD price12
            #add-point:ON ACTION controlp INFIELD price12 name="input.c.page1.price12"

            #END add-point
 
 
         #Ctrlp:input.c.page1.amt12
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt12
            #add-point:ON ACTION controlp INFIELD amt12 name="input.c.page1.amt12"

            #END add-point
 
 
         #Ctrlp:input.c.page1.num13
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD num13
            #add-point:ON ACTION controlp INFIELD num13 name="input.c.page1.num13"

            #END add-point
 
 
         #Ctrlp:input.c.page1.price13
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD price13
            #add-point:ON ACTION controlp INFIELD price13 name="input.c.page1.price13"

            #END add-point
 
 
         #Ctrlp:input.c.page1.amt13
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt13
            #add-point:ON ACTION controlp INFIELD amt13 name="input.c.page1.amt13"

            #END add-point
 
 
         #Ctrlp:input.c.page1.sum
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sum
            #add-point:ON ACTION controlp INFIELD sum name="input.c.page1.sum"

            #END add-point
 
 
 
 
         #自訂ACTION
         #add-point:單身其他段落處理(EX:on row change, etc...)
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_bgcj_d[l_ac].* = g_bgcj_d_t.*
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               EXIT DIALOG 
            END IF
            #单身更新
            CALL abgt340_01_update() RETURNING l_success
            IF l_success = FALSE THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            
         AFTER ROW
            CALL DIALOG.setCurrentRow("s_detail1",l_row)
   
         #end add-point
 
         AFTER INPUT
            #add-point:單身輸入後處理

            #end add-point
            
      END INPUT
      
 
      
      #add-point:自定義input

      #end add-point
    
      #公用action
      ON ACTION accept
         ACCEPT DIALOG
        
      ON ACTION cancel
         #add-point:cancel

         #end add-point
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION close
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit
         LET INT_FLAG = TRUE 
         EXIT DIALOG
   
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
   #当程序是abgt350调用是，将调整金额进行下展一直调整到最底层
   IF NOT INT_FLAG AND g_bgcj001_t='30' THEN
      CALL abgt340_01_adjust() 
   END IF
END FUNCTION

################################################################################
# Descriptions...: 当程序abgt350调用时，将组织下展，金额逐层下放，调至最底层组织
# Memo...........:
# Usage..........: CALL abgt340_01_adjust()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/11/10 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt340_01_adjust()

END FUNCTION

 
{</section>}
 
