#該程式未解開Section, 採用最新樣板產出!
{<section id="agcp403.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0012(2015-10-13 10:40:43), PR版次:0012(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000232
#+ Filename...: agcp403
#+ Description: 券領用申請批次產生作業
#+ Creator....: 02482(2014-04-02 16:49:47)
#+ Modifier...: 06814 -SD/PR- 00000
 
{</section>}
 
{<section id="agcp403.global" >}
#應用 t02 樣板自動產生(Version:46)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#19  16/04/14   BY 07900     校验代码重复错误讯息的修改
#160604-00009#50 2016/07/22 by 08172    库区预设值
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
 
#單身 type 宣告
PRIVATE TYPE type_g_mmay_d RECORD
       sel LIKE type_t.chr500, 
   mmaydocno LIKE mmay_t.mmaydocno, 
   mmay001 LIKE mmay_t.mmay001, 
   mmay001_desc LIKE type_t.chr500, 
   mmaysite LIKE mmay_t.mmaysite, 
   mmaysite_desc LIKE type_t.chr500, 
   mmaystus LIKE mmay_t.mmaystus
       END RECORD
PRIVATE TYPE type_g_mmay2_d RECORD
       mmaydocno LIKE mmay_t.mmaydocno, 
   mmaymodid LIKE mmay_t.mmaymodid, 
   mmaymodid_desc LIKE type_t.chr500, 
   mmaymoddt DATETIME YEAR TO SECOND, 
   mmayownid LIKE mmay_t.mmayownid, 
   mmayownid_desc LIKE type_t.chr500, 
   mmayowndp LIKE mmay_t.mmayowndp, 
   mmayowndp_desc LIKE type_t.chr500, 
   mmaycrtid LIKE mmay_t.mmaycrtid, 
   mmaycrtid_desc LIKE type_t.chr500, 
   mmaycrtdp LIKE mmay_t.mmaycrtdp, 
   mmaycrtdp_desc LIKE type_t.chr500, 
   mmaycrtdt DATETIME YEAR TO SECOND, 
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
 
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_flag               LIKE type_t.chr1
DEFINE g_type               LIKE type_t.chr1
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_mmay_d
DEFINE g_master_t                   type_g_mmay_d
DEFINE g_mmay_d          DYNAMIC ARRAY OF type_g_mmay_d
DEFINE g_mmay_d_t        type_g_mmay_d
DEFINE g_mmay_d_o        type_g_mmay_d
DEFINE g_mmay_d_mask_o   DYNAMIC ARRAY OF type_g_mmay_d #轉換遮罩前資料
DEFINE g_mmay_d_mask_n   DYNAMIC ARRAY OF type_g_mmay_d #轉換遮罩後資料
DEFINE g_mmay2_d          DYNAMIC ARRAY OF type_g_mmay2_d
DEFINE g_mmay2_d_t        type_g_mmay2_d
DEFINE g_mmay2_d_o        type_g_mmay2_d
DEFINE g_mmay2_d_mask_o   DYNAMIC ARRAY OF type_g_mmay2_d #轉換遮罩前資料
DEFINE g_mmay2_d_mask_n   DYNAMIC ARRAY OF type_g_mmay2_d #轉換遮罩後資料
DEFINE g_mmay3_d          DYNAMIC ARRAY OF type_g_mmay3_d
DEFINE g_mmay3_d_t        type_g_mmay3_d
DEFINE g_mmay3_d_o        type_g_mmay3_d
DEFINE g_mmay3_d_mask_o   DYNAMIC ARRAY OF type_g_mmay3_d #轉換遮罩前資料
DEFINE g_mmay3_d_mask_n   DYNAMIC ARRAY OF type_g_mmay3_d #轉換遮罩後資料
 
      
DEFINE g_wc                 STRING
DEFINE g_wc2                STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                        #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10    
DEFINE l_ac                 LIKE type_t.num10             
DEFINE g_ac_last            LIKE type_t.num10             
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_detail_idx         LIKE type_t.num10             #單身所在筆數(第一階單身)
DEFINE g_detail_idx2        LIKE type_t.num10             #單身所在筆數(第二階單身)
DEFINE g_detail_cnt         LIKE type_t.num10             #單身總筆數 (第一階單身)
DEFINE g_detail_cnt2        LIKE type_t.num10             #單身總筆數 (第二階單身)
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_aw                 STRING                        #確定當下點擊的單身
DEFINE g_current_page       LIKE type_t.num10             #判斷單身筆數用
DEFINE g_loc                LIKE type_t.chr5              #判斷游標所在位置
DEFINE g_log1               STRING                        #log用
DEFINE g_log2               STRING                        #log用
 
#多table用wc
DEFINE g_wc_table           STRING
 
DEFINE g_wc2_table2   STRING
 
 
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="agcp403.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5      #150308-00001#2  By sakura 150309
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("agc","")
 
   #add-point:作業初始化 name="main.init"
   IF NOT cl_null(g_argv[1]) THEN
      LET g_type = g_argv[1]
   ELSE
      LET g_type = '2'
   END IF
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
 
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_agcp403 WITH FORM cl_ap_formpath("agc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL agcp403_init()   
 
      #進入選單 Menu (="N")
      CALL agcp403_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_agcp403
      
   END IF 
   
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success      #150308-00001#2  By sakura 150309
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="agcp403.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION agcp403_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_msg      STRING
   DEFINE l_success LIKE type_t.num5      #150308-00001#2  By sakura 150309   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_error_show  = 1
      CALL cl_set_combo_scc_part('mmaystus','13','N,Y,A,D,R,W,X')
 
   
   LET l_ac = 1
   
 
 
   
 
 
   
 
 
   #避免USER直接進入第二單身時無資料
   IF g_mmay_d.getLength() > 0 THEN
      LET g_master_t.* = g_mmay_d[1].*
      LET g_master.* = g_mmay_d[1].*
   END IF
 
   #add-point:畫面資料初始化 name="init.init"
   CREATE TEMP TABLE agcp403_tmp(
                          tmp_sel       varchar(1),
                          tmp_mmaydocno varchar(20));
                          
   CREATE TEMP TABLE agcp403_tmp1(
                          mmazent       LIKE mmaz_t.mmazent,
                          mmazsite      LIKE mmaz_t.mmazsite,
                          mmazunit      LIKE mmaz_t.mmazunit,
                          mmazdocno     LIKE mmaz_t.mmazdocno,
                          mmazseq       LIKE mmaz_t.mmazseq,
                          mmaz000       LIKE mmaz_t.mmaz000,
                          mmaz001       LIKE mmaz_t.mmaz001,
                          mmaz002       LIKE mmaz_t.mmaz002,
                          mmaz003       LIKE mmaz_t.mmaz003,
                          mmaz004       LIKE mmaz_t.mmaz004,
                          mmaz005       LIKE mmaz_t.mmaz005,
                          mmaz006       LIKE mmaz_t.mmaz006,
                          mmaz007       LIKE mmaz_t.mmaz007,
                          mmaz008       LIKE mmaz_t.mmaz008,
                          mmaz009       LIKE mmaz_t.mmaz009);
                          
   DELETE FROM agcp403_tmp
   INSERT INTO agcp403_tmp
   SELECT 'N',mmaydocno
     FROM mmay_t
    WHERE mmayent = g_enterprise
      AND mmay001 = g_site
      AND mmay000 = g_type
      AND mmaystus = 'Y'
      
   DELETE FROM agcp403_tmp1   
   INSERT INTO agcp403_tmp1(mmazent,mmazdocno,mmazseq,mmaz000,mmaz002,mmaz003,mmaz004,mmaz005,mmaz001,mmaz006,mmaz007,mmaz008,mmaz009)
   SELECT mmazent,mmazdocno,mmazseq,mmaz000,mmaz002,mmaz003,mmaz004,mmaz005,mmaz001,mmaz006,mmaz007,mmaz008,mmaz009
     FROM mmaz_t
    WHERE mmazent = g_enterprise
   LET g_flag = 'N'
   
   IF g_type = '1' THEN
      CALL cl_getmsg('agc-00091',g_lang) RETURNING l_msg
      CALL cl_set_comp_att_text("mmaz001",l_msg)
      CALL cl_getmsg('agc-00092',g_lang) RETURNING l_msg
      CALL cl_set_comp_att_text("mmaz001_desc",l_msg)
   END IF
   IF g_type = '1' THEN
      CALL cl_set_act_visible_toolbaritem("receive", TRUE)
      CALL cl_set_act_visible_toolbaritem("receive1", FALSE)
   ELSE
      CALL cl_set_act_visible_toolbaritem("receive1", TRUE)
      CALL cl_set_act_visible_toolbaritem("receive", FALSE)
   END IF 
   CALL s_aooi500_create_temp() RETURNING l_success    #150308-00001#2  By sakura 150309   
   #end add-point
   
   CALL agcp403_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="agcp403.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION agcp403_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE la_param  RECORD
          prog       STRING,
          actionid   STRING,
          background LIKE type_t.chr1,
          param      DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   DEFINE li_idx   LIKE type_t.num10
   DEFINE l_cmd_token           base.StringTokenizer   #報表作業cmdrun使用 
   DEFINE l_cmd_next            STRING                 #報表作業cmdrun使用
   DEFINE l_cmd_cnt             LIKE type_t.num5       #報表作業cmdrun使用
   DEFINE l_cmd_prog_arg        STRING                 #報表作業cmdrun使用
   DEFINE l_cmd_arg             STRING                 #報表作業cmdrun使用
   #add-point:ui_dialog段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   DEFINE l_n       LIKE type_t.num5
   #end add-point 
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   LET g_action_choice = " "  
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm() 
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_mmay_d.clear()
         CALL g_mmay2_d.clear()
         CALL g_mmay3_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL agcp403_init()
      END IF
   
      #add-point:ui_dialog段before while name="ui_dialog.before_while"
      
      #end add-point
   
      CALL agcp403_b_fill(g_wc)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_mmay_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'
               LET g_current_page = 1
      
            BEFORE ROW
               LET g_curr_diag = ui.DIALOG.getCurrent()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               LET g_master.* = g_mmay_d[g_detail_idx].*
               CALL cl_show_fld_cont()
               LET g_action_choice = "fetch"
               CALL agcp403_fetch()
               CALL agcp403_idx_chk('m')
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL agcp403_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               
            #自訂ACTION(detail_show,page_1)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION receive
            LET g_action_choice="receive"
            IF cl_auth_chk_act("receive") THEN
               
               #add-point:ON ACTION receive name="menu.detail_show.page1.receive"
               IF l_ac > 0 THEN
                  IF NOT cl_null(g_mmay_d[l_ac].mmaydocno) THEN
                     CALL cl_cmdrun(" ammt402 ")
                  END IF
               END IF
                  EXIT DIALOG
            END IF
            
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_mmay_d.getLength()
               LET g_mmay_d[li_idx].sel = "Y"
               UPDATE agcp403_tmp 
                 SET tmp_sel = g_mmay_d[li_idx].sel
                WHERE tmp_mmaydocno = g_mmay_d[li_idx].mmaydocno
            END FOR
 
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_mmay_d.getLength()
               LET g_mmay_d[li_idx].sel = "N"
               UPDATE agcp403_tmp 
                  SET tmp_sel = g_mmay_d[li_idx].sel
                WHERE tmp_mmaydocno = g_mmay_d[li_idx].mmaydocno
            END FOR
 

 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_mmay_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_mmay_d[li_idx].sel = "Y"
                  UPDATE agcp403_tmp 
                     SET tmp_sel = g_mmay_d[li_idx].sel
                   WHERE tmp_mmaydocno = g_mmay_d[li_idx].mmaydocno
               END IF
            END FOR

         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_mmay_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_mmay_d[li_idx].sel = "N"
                  UPDATE agcp403_tmp 
                     SET tmp_sel = g_mmay_d[li_idx].sel
                   WHERE tmp_mmaydocno = g_mmay_d[li_idx].mmaydocno
               END IF
            END FOR
            IF TRUE THEN
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION receive1
            LET g_action_choice="receive1"
            IF cl_auth_chk_act("receive1") THEN
               
               #add-point:ON ACTION receive1 name="menu.detail_show.page1.receive1"
               IF l_ac > 0 THEN
                  IF NOT cl_null(g_mmay_d[l_ac].mmaydocno) THEN
                     CALL cl_cmdrun(" agct402 ")
                  END IF
               END IF
               #END add-point
               
            END IF
 
 
 
 
               
         END DISPLAY
      
         DISPLAY ARRAY g_mmay2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'
               LET g_current_page = 2
               
            BEFORE ROW
               LET g_curr_diag = ui.DIALOG.getCurrent()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx
               LET g_master.* = g_mmay_d[g_detail_idx].*
               CALL cl_show_fld_cont() 
               LET g_action_choice = "fetch"
               CALL agcp403_fetch()
               CALL agcp403_idx_chk('m')
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL agcp403_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               
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
               LET g_current_page = 3
         
            BEFORE ROW
               LET g_curr_diag = ui.DIALOG.getCurrent()
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx2
               CALL agcp403_idx_chk('d')
               LET g_master.* = g_mmay_d[g_detail_idx].*
               CALL cl_show_fld_cont() 
               
            #自訂ACTION(detail_show,page_3)
            
               
         END DISPLAY
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
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
            #add-point:ui_dialog段before name="ui_dialog.b_dialog"
            
            #end add-point  
            NEXT FIELD CURRENT
        
         AFTER DIALOG
            #add-point:ui_dialog段after dialog name="ui_dialog.after_dialog"
            
            #end add-point
         
      ON ACTION exporttoexcel
         LET g_action_choice="exporttoexcel"
         IF cl_auth_chk_act("exporttoexcel") THEN
            CALL g_export_node.clear()
            LET g_export_node[1] = base.typeInfo.create(g_mmay_d)
            LET g_export_id[1]   = "s_detail1"
            LET g_export_node[2] = base.typeInfo.create(g_mmay2_d)
            LET g_export_id[2]   = "s_detail2"
            LET g_export_node[3] = base.typeInfo.create(g_mmay3_d)
            LET g_export_id[3]   = "s_detail3"
 
            #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
            
            #END add-point
            CALL cl_export_to_excel_getpage()
            CALL cl_export_to_excel()
         END IF
         
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL agcp403_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL agcp403_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
             
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
             
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL agcp403_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION produce
            LET g_action_choice="produce"
            IF cl_auth_chk_act("produce") THEN
               
               #add-point:ON ACTION produce name="menu.produce"
               LET l_n = 0
               SELECT COUNT(*) INTO l_n
                 FROM agcp403_tmp 
                WHERE tmp_sel = 'Y'
               IF l_n = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00063'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

               ELSE
                  IF cl_ask_confirm('agc-00100') THEN
                     CALL agcp403_produce()
                  END IF
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION detailm
            LET g_action_choice="detailm"
            IF cl_auth_chk_act("detailm") THEN
               
               #add-point:ON ACTION detailm name="menu.detailm"
               IF g_mmay3_d.getLength() > 0 THEN
                  LET g_flag = 'Y'
                  CALL agcp403_input('u')
               END IF
               #END add-point
               
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
            CALL agcp403_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL agcp403_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL agcp403_set_pk_array()
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
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="agcp403.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION agcp403_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="query.pre_function"
   
   #end add-point
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_mmay_d.clear()
   CALL g_mmay2_d.clear()
   CALL g_mmay3_d.clear()
 
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc
   LET g_detail_idx = l_ac
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單身根據table分拆construct
      CONSTRUCT g_wc_table ON mmaydocno,mmay001,mmaysite,mmaymodid,mmaymoddt,mmayownid,mmayowndp,mmaycrtid, 
          mmaycrtdp,mmaycrtdt,mmaycnfid,mmaycnfdt
           FROM s_detail1[1].mmaydocno,s_detail1[1].mmay001,s_detail1[1].mmaysite,s_detail2[1].mmaymodid, 
               s_detail2[1].mmaymoddt,s_detail2[1].mmayownid,s_detail2[1].mmayowndp,s_detail2[1].mmaycrtid, 
               s_detail2[1].mmaycrtdp,s_detail2[1].mmaycrtdt,s_detail2[1].mmaycnfid,s_detail2[1].mmaycnfdt 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
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
 
 
 
         
       #單身一般欄位開窗相關處理
                #Ctrlp:construct.c.page1.mmaydocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaydocno
            #add-point:ON ACTION controlp INFIELD mmaydocno name="construct.c.page1.mmaydocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where =  " mmay001 = '",g_site,"' AND mmay000 = '",g_type,"' AND mmaystus = 'Y' AND mmaydocno IN (SELECT mmazdocno FROM mmaz_t WHERE mmazent = '",g_enterprise,"' AND mmaz000 = '",g_type,"' AND mmaz008 IS NULL)"
            CALL q_mmaydocno()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaydocno  #顯示到畫面上
            NEXT FIELD mmaydocno                     #返回原欄位

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaydocno
            #add-point:BEFORE FIELD mmaydocno name="construct.b.page1.mmaydocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaydocno
            
            #add-point:AFTER FIELD mmaydocno name="construct.a.page1.mmaydocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmay001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmay001
            #add-point:ON ACTION controlp INFIELD mmay001 name="construct.c.page1.mmay001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where =  " ooef001 = '",g_site,"'"
            CALL q_ooef001()                       #呼叫開窗
#            IF s_aooi500_setpoint(g_prog,'mmay001') THEN
#               LET g_qryparam.where = s_aooi500_q_where(g_prog,'mmay001',g_site)
#               CALL q_ooef001_24()
#            ELSE
#               LET g_qryparam.where =  " ooef001 = '",g_site,"'"
#               CALL q_ooef001() 
#            END IF
            DISPLAY g_qryparam.return1 TO mmay001  #顯示到畫面上
            NEXT FIELD mmay001                    #返回原欄位

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmay001
            #add-point:BEFORE FIELD mmay001 name="construct.b.page1.mmay001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmay001
            
            #add-point:AFTER FIELD mmay001 name="construct.a.page1.mmay001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmaysite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaysite
            #add-point:ON ACTION controlp INFIELD mmaysite name="construct.c.page1.mmaysite"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#            CALL q_ooef001()                        #呼叫開窗
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'mmaysite',g_site,'c') #150308-00001#2  By sakura add 'c'
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO mmaysite  #顯示到畫面上
            NEXT FIELD mmaysite                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaysite
            #add-point:BEFORE FIELD mmaysite name="construct.b.page1.mmaysite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaysite
            
            #add-point:AFTER FIELD mmaysite name="construct.a.page1.mmaysite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mmaymodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaymodid
            #add-point:ON ACTION controlp INFIELD mmaymodid name="construct.c.page2.mmaymodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaymodid  #顯示到畫面上
            NEXT FIELD mmaymodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaymodid
            #add-point:BEFORE FIELD mmaymodid name="construct.b.page2.mmaymodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaymodid
            
            #add-point:AFTER FIELD mmaymodid name="construct.a.page2.mmaymodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaymoddt
            #add-point:BEFORE FIELD mmaymoddt name="construct.b.page2.mmaymoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.mmayownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmayownid
            #add-point:ON ACTION controlp INFIELD mmayownid name="construct.c.page2.mmayownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmayownid  #顯示到畫面上
            NEXT FIELD mmayownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmayownid
            #add-point:BEFORE FIELD mmayownid name="construct.b.page2.mmayownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmayownid
            
            #add-point:AFTER FIELD mmayownid name="construct.a.page2.mmayownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mmayowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmayowndp
            #add-point:ON ACTION controlp INFIELD mmayowndp name="construct.c.page2.mmayowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmayowndp  #顯示到畫面上
            NEXT FIELD mmayowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmayowndp
            #add-point:BEFORE FIELD mmayowndp name="construct.b.page2.mmayowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmayowndp
            
            #add-point:AFTER FIELD mmayowndp name="construct.a.page2.mmayowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mmaycrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaycrtid
            #add-point:ON ACTION controlp INFIELD mmaycrtid name="construct.c.page2.mmaycrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaycrtid  #顯示到畫面上
            NEXT FIELD mmaycrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaycrtid
            #add-point:BEFORE FIELD mmaycrtid name="construct.b.page2.mmaycrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaycrtid
            
            #add-point:AFTER FIELD mmaycrtid name="construct.a.page2.mmaycrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mmaycrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaycrtdp
            #add-point:ON ACTION controlp INFIELD mmaycrtdp name="construct.c.page2.mmaycrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaycrtdp  #顯示到畫面上
            NEXT FIELD mmaycrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaycrtdp
            #add-point:BEFORE FIELD mmaycrtdp name="construct.b.page2.mmaycrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaycrtdp
            
            #add-point:AFTER FIELD mmaycrtdp name="construct.a.page2.mmaycrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaycrtdt
            #add-point:BEFORE FIELD mmaycrtdt name="construct.b.page2.mmaycrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.mmaycnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaycnfid
            #add-point:ON ACTION controlp INFIELD mmaycnfid name="construct.c.page2.mmaycnfid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaycnfid  #顯示到畫面上
            NEXT FIELD mmaycnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaycnfid
            #add-point:BEFORE FIELD mmaycnfid name="construct.b.page2.mmaycnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaycnfid
            
            #add-point:AFTER FIELD mmaycnfid name="construct.a.page2.mmaycnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaycnfdt
            #add-point:BEFORE FIELD mmaycnfdt name="construct.b.page2.mmaycnfdt"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
      CONSTRUCT g_wc2_table2 ON mmazseq,mmaz002,mmaz003,mmaz004,mmaz005,mmaz001,mmaz006,mmaz007
           FROM s_detail3[1].mmazseq,s_detail3[1].mmaz002,s_detail3[1].mmaz003,s_detail3[1].mmaz004, 
               s_detail3[1].mmaz005,s_detail3[1].mmaz001,s_detail3[1].mmaz006,s_detail3[1].mmaz007
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmazseq
            #add-point:BEFORE FIELD mmazseq name="construct.b.page3.mmazseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmazseq
            
            #add-point:AFTER FIELD mmazseq name="construct.a.page3.mmazseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.mmazseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmazseq
            #add-point:ON ACTION controlp INFIELD mmazseq name="construct.c.page3.mmazseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.mmaz002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaz002
            #add-point:ON ACTION controlp INFIELD mmaz002 name="construct.c.page3.mmaz002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#            LET g_qryparam.arg1 = g_site
#            LET g_qryparam.arg2 = '8'
#            CALL q_ooed004()                       #呼叫開窗
            IF s_aooi500_setpoint(g_prog,'mmaz002') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'mmaz002',g_site,'c') #150308-00001#2  By sakura add 'c'
               CALL q_ooef001_24()
            ELSE
               LET g_qryparam.arg1 = g_site
               LET g_qryparam.arg2 = '8'
               CALL q_ooed004() 
            END IF
            DISPLAY g_qryparam.return1 TO mmaz002  #顯示到畫面上
            NEXT FIELD mmaz002                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaz002
            #add-point:BEFORE FIELD mmaz002 name="construct.b.page3.mmaz002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaz002
            
            #add-point:AFTER FIELD mmaz002 name="construct.a.page3.mmaz002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.mmaz003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaz003
            #add-point:ON ACTION controlp INFIELD mmaz003 name="construct.c.page3.mmaz003"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_5()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaz003    #顯示到畫面上
            NEXT FIELD mmaz003                       #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaz003
            #add-point:BEFORE FIELD mmaz003 name="construct.b.page3.mmaz003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaz003
            
            #add-point:AFTER FIELD mmaz003 name="construct.a.page3.mmaz003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.mmaz004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaz004
            #add-point:ON ACTION controlp INFIELD mmaz004 name="construct.c.page3.mmaz004"

            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#            CALL q_ooef001()                         #呼叫開窗
            IF s_aooi500_setpoint(g_prog,'mmaz004') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'mmaz004',g_site,'c') #150308-00001#2  By sakura add 'c'
               CALL q_ooef001_24()
            ELSE
               CALL q_ooef001() 
            END IF
            DISPLAY g_qryparam.return1 TO mmaz004    #顯示到畫面上
            NEXT FIELD mmaz004                       #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaz004
            #add-point:BEFORE FIELD mmaz004 name="construct.b.page3.mmaz004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaz004
            
            #add-point:AFTER FIELD mmaz004 name="construct.a.page3.mmaz004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.mmaz005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaz005
            #add-point:ON ACTION controlp INFIELD mmaz005 name="construct.c.page3.mmaz005"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_5()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaz005    #顯示到畫面上
            NEXT FIELD mmaz005                       #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaz005
            #add-point:BEFORE FIELD mmaz005 name="construct.b.page3.mmaz005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaz005
            
            #add-point:AFTER FIELD mmaz005 name="construct.a.page3.mmaz005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.mmaz001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaz001
            #add-point:ON ACTION controlp INFIELD mmaz001 name="construct.c.page3.mmaz001"
            
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            IF g_type = '2'THEN
               CALL q_gcaf001()                       #呼叫開窗
            ELSE
               CALL q_mman001()                       #呼叫開窗
            END IF
            DISPLAY g_qryparam.return1 TO mmaz001     #顯示到畫面上
            NEXT FIELD mmaz001                        #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaz001
            #add-point:BEFORE FIELD mmaz001 name="construct.b.page3.mmaz001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaz001
            
            #add-point:AFTER FIELD mmaz001 name="construct.a.page3.mmaz001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaz006
            #add-point:BEFORE FIELD mmaz006 name="construct.b.page3.mmaz006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaz006
            
            #add-point:AFTER FIELD mmaz006 name="construct.a.page3.mmaz006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.mmaz006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaz006
            #add-point:ON ACTION controlp INFIELD mmaz006 name="construct.c.page3.mmaz006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaz007
            #add-point:BEFORE FIELD mmaz007 name="construct.b.page3.mmaz007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaz007
            
            #add-point:AFTER FIELD mmaz007 name="construct.a.page3.mmaz007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.mmaz007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaz007
            #add-point:ON ACTION controlp INFIELD mmaz007 name="construct.c.page3.mmaz007"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
 
  
      #add-point:query段more_construct name="query.more_construct"
      
      #end add-point 
      
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="query.b_dialog"
         
         #end add-point  
 
      ON ACTION qbe_select     #條件查詢
         CALL cl_qbe_list('m') RETURNING ls_wc
 
      ON ACTION qbe_save       #條件儲存
         CALL cl_qbe_save()
      
      ON ACTION accept
         ACCEPT DIALOG
         
      ON ACTION cancel
         LET INT_FLAG = 1
         CANCEL DIALOG
      
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG 
   END DIALOG
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      LET g_wc2 = " 1=2"
      RETURN
   ELSE
      #資料導回第一筆
      LET g_detail_idx  = 1
      LET g_detail_idx2 = 1
   END IF
   
   LET g_wc = g_wc_table 
 
              , " AND ", g_wc2_table2
 
 
        
   LET g_wc2 = " 1=1"
               , " AND ", g_wc2_table2
 
 
        
   #add-point:cs段after_construct name="cs.after_construct"
   IF NOT INT_FLAG THEN
      DELETE FROM agcp403_tmp
      INSERT INTO agcp403_tmp
      SELECT 'N',mmaydocno
        FROM mmay_t
       WHERE mmayent = g_enterprise
         AND mmay001 = g_site
         AND mmay000 = g_type
         AND mmaystus = 'Y'
         
      DELETE FROM agcp403_tmp1   
      INSERT INTO agcp403_tmp1(mmazent,mmazdocno,mmazseq,mmaz000,mmaz002,mmaz003,mmaz004,mmaz005,mmaz001,mmaz006,mmaz007,mmaz008,mmaz009)
      SELECT mmazent,mmazdocno,mmazseq,mmaz000,mmaz002,mmaz003,mmaz004,mmaz005,mmaz001,mmaz006,mmaz007,mmaz008,mmaz009
        FROM mmaz_t
       WHERE mmazent = g_enterprise
   END IF
   #end add-point
   
   LET g_error_show = 1
   CALL agcp403_b_fill(g_wc)
   LET l_ac = g_detail_idx
   
   CALL agcp403_fetch()
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = -100 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   END IF
 
   #資料導回第一筆(假設有資料)
   IF g_mmay_d.getLength() > 0 THEN
      DISPLAY g_detail_idx  TO FORMONLY.h_index
   ELSE
      DISPLAY ' ' TO FORMONLY.h_index
   END IF
   IF g_mmay3_d.getLength() > 0 THEN
      DISPLAY g_detail_idx2 TO FORMONLY.idx
   ELSE
      DISPLAY ' ' TO FORMONLY.idx
   END IF
   
END FUNCTION
 
{</section>}
 
{<section id="agcp403.insert" >}
#+ 資料修改
PRIVATE FUNCTION agcp403_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point 
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="insert.before_insert"
   LET g_flag = 'N'
   #end add-point 
   
   LET g_insert = 'Y'
   CALL agcp403_input('a')
   
   #add-point:insert段新增後 name="insert.after_insert"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="agcp403.modify" >}
#+ 資料新增
PRIVATE FUNCTION agcp403_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point 
   DEFINE l_ac_t LIKE type_t.num10
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point 
  
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   LET l_ac_t = g_detail_idx
 
   #add-point:modify段新增前 name="modify.before_modify"
   LET g_flag = 'N'
   #end add-point 
   
   #進入資料輸入段落
   CALL agcp403_input('u')
    
   IF INT_FLAG AND g_mmay_d.getLength() > 0 THEN
      LET g_detail_idx = l_ac_t
      LET l_ac = l_ac_t
      CALL agcp403_b_fill(g_wc)
      CALL agcp403_detail_show() 
   END IF
   
   #add-point:modify段新增後 name="modify.after_modify"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="agcp403.delete" >}
#+ 資料刪除
PRIVATE FUNCTION agcp403_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point 
   DEFINE li_ac LIKE type_t.num10
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF NOT cl_ask_delete() THEN
      #不刪除
      RETURN
   END IF
   
   LET li_ac = ARR_CURR()
   LET g_mmay_d_t.* = g_mmay_d[li_ac].*
   LET g_mmay_d_o.* = g_mmay_d[li_ac].*
   
   CALL s_transaction_begin()  
   
   #add-point:delete段刪除前 name="delete.before_delete"
   
   #end add-point 
   
   #刪除單頭
   DELETE FROM mmay_t 
         WHERE mmayent = g_enterprise AND
           mmaydocno = g_mmay_d_t.mmaydocno
 
           
   #add-point:delete段刪除中 name="delete.m_delete"
   
   #end add-point 
           
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "mmay_t:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.popup = TRUE 
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
   
   #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL agcp403_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove.func"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
    
   
   #add-point:delete段刪除後 name="delete.after_delete"
   
   #end add-point 
   
   #刪除單頭
   #add-point:delete段刪除前 name="delete.before_delete2"
   
   #end add-point 
   DELETE FROM mmaz_t 
         WHERE mmazent = g_enterprise AND
           mmazdocno = g_mmay_d_t.mmaydocno
 
   #add-point:delete段刪除中 name="delete.m_delete2"
   
   #end add-point 
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "mmaz_t:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.popup = TRUE 
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   ELSE
      CALL s_transaction_end('Y','0')
   END IF
   #add-point:delete段刪除後 name="delete.after_delete2"
   
   #end add-point 
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="agcp403.input" >}
#+ 資料輸入
PRIVATE FUNCTION agcp403_input(p_cmd)
   #add-point:input段define(客製用) name="input.define_customerization"
   
   #end add-point 
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_ac_t                LIKE type_t.num10               #未取消的ARRAY CNT 
   DEFINE  l_n                   LIKE type_t.num10               #檢查重複用  
   DEFINE  l_cnt                 LIKE type_t.num10               #檢查重複用  
   DEFINE  l_lock_sw             LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert        LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete        LIKE type_t.num5                #可刪除否  
   DEFINE  l_count               LIKE type_t.num10
   DEFINE  l_i                   LIKE type_t.num10
   DEFINE  ls_return             STRING
   DEFINE  l_var_keys            DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys          DYNAMIC ARRAY OF STRING
   DEFINE  l_vars                DYNAMIC ARRAY OF STRING
   DEFINE  l_fields              DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak        DYNAMIC ARRAY OF STRING
   DEFINE  lb_reproduce          BOOLEAN
   DEFINE  li_reproduce          LIKE type_t.num10
   DEFINE  li_reproduce_target   LIKE type_t.num10
   DEFINE  l_insert              BOOLEAN
   #add-point:input段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_errno               LIKE type_t.chr10
   #end add-point 
   
   #add-point:Function前置處理  name="input.pre_function"
   
   #end add-point
   
   LET g_action_choice = ""
   
   LET g_qryparam.state = "i"
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
 
   #add-point:input段define_sql name="input.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT mmaydocno,mmay001,mmaysite,mmaystus,mmaydocno,mmaymodid,mmaymoddt,mmayownid, 
       mmayowndp,mmaycrtid,mmaycrtdp,mmaycrtdt,mmaycnfid,mmaycnfdt FROM mmay_t WHERE mmayent=? AND mmaydocno=?  
       FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE agcp403_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
   
 
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point 
   LET g_forupd_sql = "SELECT mmazseq,mmaz002,mmaz003,mmaz004,mmaz005,mmaz001,mmaz006,mmaz007 FROM mmaz_t  
       WHERE mmazent=? AND mmazdocno=? AND mmazseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   LET g_forupd_sql = "SELECT mmazseq,mmaz002,mmaz003,mmaz004,mmaz005,mmaz001,mmaz006, 
       mmaz007 FROM agcp403_tmp1 WHERE mmazent=? AND mmazdocno=? AND mmazseq=? FOR UPDATE"
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE agcp403_bcl2 CURSOR FROM g_forupd_sql
 
 
 
   LET lb_reproduce = FALSE
   LET l_insert = FALSE
      
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:input段修改前 name="input.before_input"
   LET g_errshow = 1
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
 
            LET g_current_page = 1
            IF p_cmd = 'u' THEN
               CALL agcp403_b_fill(g_wc)
            END IF
            LET g_loc = 'm'
            LET g_detail_cnt = g_mmay_d.getLength()
            #add-point:資料輸入前 name="input.body.before_input"
            
            #end add-point
            
         BEFORE ROW
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = ARR_CURR()
            LET g_ac_last = l_ac
            LET l_insert = FALSE
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
               LET g_mmay_d_o.* = g_mmay_d[l_ac].*  #BACKUP
               IF NOT agcp403_lock_b("mmay_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH agcp403_bcl INTO g_mmay_d[l_ac].mmaydocno,g_mmay_d[l_ac].mmay001,g_mmay_d[l_ac].mmaysite, 
                      g_mmay_d[l_ac].mmaystus,g_mmay2_d[l_ac].mmaydocno,g_mmay2_d[l_ac].mmaymodid,g_mmay2_d[l_ac].mmaymoddt, 
                      g_mmay2_d[l_ac].mmayownid,g_mmay2_d[l_ac].mmayowndp,g_mmay2_d[l_ac].mmaycrtid, 
                      g_mmay2_d[l_ac].mmaycrtdp,g_mmay2_d[l_ac].mmaycrtdt,g_mmay2_d[l_ac].mmaycnfid, 
                      g_mmay2_d[l_ac].mmaycnfdt
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_mmay_d_t.mmaydocno,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
 
                  #遮罩相關處理
                  LET g_mmay_d_mask_o[l_ac].* =  g_mmay_d[l_ac].*
                  CALL agcp403_mmay_t_mask()
                  LET g_mmay_d_mask_n[l_ac].* =  g_mmay_d[l_ac].*
                  
                  CALL cl_show_fld_cont()
                  #CALL agcp403_detail_show()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL agcp403_set_entry_b(l_cmd)
            CALL agcp403_set_no_entry_b(l_cmd)
            #add-point:input段before row name="input.body.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
 
            #其他table進行lock
            
 
 
            #讀取對應的單身資料
            LET g_action_choice = "fetch"
            CALL agcp403_fetch()
            CALL agcp403_idx_chk('m')
 
         BEFORE INSERT
            
 
 
            #判斷能否在此頁面進行資料新增
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            #清空下層單身
                        CALL g_mmay3_d.clear()
 
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_mmay_d[l_ac].* TO NULL 
            INITIALIZE g_mmay_d_t.* TO NULL 
            INITIALIZE g_mmay_d_o.* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_mmay2_d[l_ac].mmayownid = g_user
      LET g_mmay2_d[l_ac].mmayowndp = g_dept
      LET g_mmay2_d[l_ac].mmaycrtid = g_user
      LET g_mmay2_d[l_ac].mmaycrtdp = g_dept 
      LET g_mmay2_d[l_ac].mmaycrtdt = cl_get_current()
      LET g_mmay2_d[l_ac].mmaymodid = g_user
      LET g_mmay2_d[l_ac].mmaymoddt = cl_get_current()
      LET g_mmay_d[l_ac].mmaystus = ''
 
 
 
                  LET g_mmay_d[l_ac].sel = "N"
 
            #add-point:modify段before備份 name="input.body.before_bak"
            
            #end add-point
            LET g_mmay_d_t.* = g_mmay_d[l_ac].*     #新輸入資料
            LET g_mmay_d_o.* = g_mmay_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL agcp403_set_entry_b(l_cmd)
            CALL agcp403_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mmay_d[li_reproduce_target].* = g_mmay_d[li_reproduce].*
               LET g_mmay2_d[li_reproduce_target].* = g_mmay2_d[li_reproduce].*
 
               LET g_mmay_d[g_mmay_d.getLength()].mmaydocno = NULL
 
            END IF
            #add-point:input段before insert name="input.body.before_insert"
            
            #end add-point  
  
         AFTER INSERT
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
            LET l_insert = FALSE
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM mmay_t 
             WHERE mmayent = g_enterprise AND mmaydocno = g_mmay_d[l_ac].mmaydocno 
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmay_d[g_detail_idx].mmaydocno
               CALL agcp403_insert_b('mmay_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_mmay_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mmay_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL agcp403_b_fill(g_wc)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               LET g_master.* = g_mmay_d[l_ac].*
            END IF
              
         BEFORE DELETE  #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身刪除後(=d) name="input.body.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body.b_delete_ask"
               
               #end add-point 
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code =  -263 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身刪除前 name="input.body.b_delete"
               
               #end add-point
               
               DELETE FROM mmay_t
                WHERE mmayent = g_enterprise AND 
                      mmaydocno = g_mmay_d_t.mmaydocno
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "mmay_t:",SQLERRMESSAGE  
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
 
 
                  #add-point:單身刪除後 name="input.body.a_delete"
                  
                  #end add-point
                  #修改歷程記錄(刪除)
                  LET g_log1 = util.JSON.stringify(g_mmay_d[l_ac])   #(ver:45)
                  IF NOT cl_log_modified_record(g_log1,'') THEN   #(ver:45)
                     CALL s_transaction_end('N','0')
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF 
               CLOSE agcp403_bcl
               LET l_count = g_mmay_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmay_d_t.mmaydocno
    
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL agcp403_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
        
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL agcp403_delete_b('mmay_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_mmay_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sel
            #add-point:BEFORE FIELD sel name="input.b.page1.sel"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sel
            
            #add-point:AFTER FIELD sel name="input.a.page1.sel"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sel
            #add-point:ON CHANGE sel name="input.g.page1.sel"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaydocno
            #add-point:BEFORE FIELD mmaydocno name="input.b.page1.mmaydocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaydocno
            
            #add-point:AFTER FIELD mmaydocno name="input.a.page1.mmaydocno"
            #此段落由子樣板a05產生
            IF  g_mmay_d[g_detail_idx].mmaydocno IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mmay_d[g_detail_idx].mmaydocno != g_mmay_d_t.mmaydocno)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmay_t WHERE "||"mmayent = '" ||g_enterprise|| "' AND "||"mmaydocno = '"||g_mmay_d[g_detail_idx].mmaydocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaydocno
            #add-point:ON CHANGE mmaydocno name="input.g.page1.mmaydocno"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmay001
            
            #add-point:AFTER FIELD mmay001 name="input.a.page1.mmay001"

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmay_d[l_ac].mmay001
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mmay_d[l_ac].mmay001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mmay_d[l_ac].mmay001_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmay001
            #add-point:BEFORE FIELD mmay001 name="input.b.page1.mmay001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmay001
            #add-point:ON CHANGE mmay001 name="input.g.page1.mmay001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaysite
            
            #add-point:AFTER FIELD mmaysite name="input.a.page1.mmaysite"

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmay_d[l_ac].mmaysite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl002 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mmay_d[l_ac].mmaysite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mmay_d[l_ac].mmaysite_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaysite
            #add-point:BEFORE FIELD mmaysite name="input.b.page1.mmaysite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaysite
            #add-point:ON CHANGE mmaysite name="input.g.page1.mmaysite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaystus
            #add-point:BEFORE FIELD mmaystus name="input.b.page1.mmaystus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaystus
            
            #add-point:AFTER FIELD mmaystus name="input.a.page1.mmaystus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaystus
            #add-point:ON CHANGE mmaystus name="input.g.page1.mmaystus"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.sel
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sel
            #add-point:ON ACTION controlp INFIELD sel name="input.c.page1.sel"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmaydocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaydocno
            #add-point:ON ACTION controlp INFIELD mmaydocno name="input.c.page1.mmaydocno"
 
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmay001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmay001
            #add-point:ON ACTION controlp INFIELD mmay001 name="input.c.page1.mmay001"


            #END add-point
 
 
         #Ctrlp:input.c.page1.mmaysite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaysite
            #add-point:ON ACTION controlp INFIELD mmaysite name="input.c.page1.mmaysite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmaystus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaystus
            #add-point:ON ACTION controlp INFIELD mmaystus name="input.c.page1.mmaystus"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_mmay_d[l_ac].* = g_mmay_d_t.*
               CLOSE agcp403_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               CANCEL DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_mmay_d[l_ac].mmaydocno 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_mmay_d[l_ac].* = g_mmay_d_t.*
            ELSE
               
               #寫入修改者/修改日期資訊(單身)
               LET g_mmay2_d[l_ac].mmaymodid = g_user 
LET g_mmay2_d[l_ac].mmaymoddt = cl_get_current()
LET g_mmay2_d[l_ac].mmaymodid_desc = cl_get_username(g_mmay2_d[l_ac].mmaymodid)
               
               #add-point:單身修改前 name="input.body.b_update"
               LET g_mmay2_d[l_ac].mmaymodid = g_mmay2_d_t.mmaymodid
               LET g_mmay2_d[l_ac].mmaymoddt = g_mmay2_d_t.mmaymoddt
               #end add-point
               
               #將遮罩欄位還原
               CALL agcp403_mmay_t_mask_restore('restore_mask_o')
      
               UPDATE mmay_t SET (mmaydocno,mmay001,mmaysite,mmaystus,mmaymodid,mmaymoddt,mmayownid, 
                   mmayowndp,mmaycrtid,mmaycrtdp,mmaycrtdt,mmaycnfid,mmaycnfdt) = (g_mmay_d[l_ac].mmaydocno, 
                   g_mmay_d[l_ac].mmay001,g_mmay_d[l_ac].mmaysite,g_mmay_d[l_ac].mmaystus,g_mmay2_d[l_ac].mmaymodid, 
                   g_mmay2_d[l_ac].mmaymoddt,g_mmay2_d[l_ac].mmayownid,g_mmay2_d[l_ac].mmayowndp,g_mmay2_d[l_ac].mmaycrtid, 
                   g_mmay2_d[l_ac].mmaycrtdp,g_mmay2_d[l_ac].mmaycrtdt,g_mmay2_d[l_ac].mmaycnfid,g_mmay2_d[l_ac].mmaycnfdt) 
 
                WHERE mmayent = g_enterprise AND
                  mmaydocno = g_mmay_d_t.mmaydocno #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     LET g_mmay_d[l_ac].* = g_mmay_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mmay_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_mmay_d[l_ac].* = g_mmay_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mmay_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmay_d[g_detail_idx].mmaydocno
               LET gs_keys_bak[1] = g_mmay_d_t.mmaydocno
               CALL agcp403_update_b('mmay_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     
                     #將遮罩欄位進行遮蔽
                     CALL agcp403_mmay_t_mask_restore('restore_mask_n')
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_mmay_d_t)
                     LET g_log2 = util.JSON.stringify(g_mmay_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #若Key欄位有變動
               LET g_master.* = g_mmay_d[l_ac].*
               CALL agcp403_key_update_b()
               
               #add-point:單身修改後 name="input.body.a_update"
               UPDATE agcp403_tmp 
                 SET tmp_sel = g_mmay_d[l_ac].sel
                WHERE tmp_mmaydocno = g_mmay_d[l_ac].mmaydocno
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL agcp403_unlock_b("mmay_t")
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_mmay_d[l_ac].* = g_mmay_d_t.*
               END IF
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               CANCEL DIALOG 
            END IF
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            
            IF l_cmd = 'u' AND INT_FLAG THEN
               LET g_mmay_d[l_ac].* = g_mmay_d_t.*
            END IF
            LET l_cmd = ''
              
         AFTER INPUT
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point
            #錯誤訊息統整顯示
            #CALL cl_err_collect_show()      
            #CALL cl_showmsg()            
    
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_mmay_d[li_reproduce_target].* = g_mmay_d[li_reproduce].*
               LET g_mmay2_d[li_reproduce_target].* = g_mmay2_d[li_reproduce].*
 
               LET g_mmay_d[li_reproduce_target].mmaydocno = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_mmay_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_mmay_d.getLength()+1
            END IF
            
      END INPUT
      
 
      
      #實際單身段落
      INPUT ARRAY g_mmay3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = FALSE,
                 APPEND ROW = FALSE)
                 
         #自訂ACTION(detail_input,page_3)
         
         
         BEFORE INPUT
            #檢查上層單身是否有資料
            IF cl_null(g_mmay_d[g_detail_idx].mmaydocno) THEN
               NEXT FIELD sel
            END IF
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mmay3_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            LET g_loc = 'd'
            LET g_detail_cnt = g_mmay3_d.getLength()
            LET g_current_page = 3
            #add-point:資料輸入前 name="input.body3.before_input"
            CALL agcp403_fetch()
            #end add-point
 
         BEFORE INSERT
            IF g_mmay_d.getLength() = 0 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 'std-00013' 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               NEXT FIELD mmaydocno
            END IF 
            #判斷能否在此頁面進行資料新增
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_mmay3_d[l_ac].* TO NULL 
            INITIALIZE g_mmay3_d_t.* TO NULL 
            INITIALIZE g_mmay3_d_o.* TO NULL 
                  LET g_mmay3_d[l_ac].mmaz007 = "0"
 
            #add-point:modify段before備份 name="input.body3.before_bak"
            
            #end add-point
            LET g_mmay3_d_t.* = g_mmay3_d[l_ac].*     #新輸入資料
            LET g_mmay3_d_o.* = g_mmay3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL agcp403_set_entry_b(l_cmd)
            CALL agcp403_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mmay3_d[li_reproduce_target].* = g_mmay3_d[li_reproduce].*
 
               LET g_mmay3_d[li_reproduce_target].mmazseq = NULL
            END IF
            #add-point:input段before insert name="input.body3.before_insert"
            
            #end add-point  
            
         BEFORE ROW 
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = ARR_CURR()
            LET l_insert = FALSE
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
               LET g_mmay3_d_o.* = g_mmay3_d[l_ac].*  #BACKUP
               IF NOT agcp403_lock_b("mmaz_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH agcp403_bcl2 INTO g_mmay3_d[l_ac].mmazseq,g_mmay3_d[l_ac].mmaz002,g_mmay3_d[l_ac].mmaz003, 
                      g_mmay3_d[l_ac].mmaz004,g_mmay3_d[l_ac].mmaz005,g_mmay3_d[l_ac].mmaz001,g_mmay3_d[l_ac].mmaz006, 
                      g_mmay3_d[l_ac].mmaz007
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_mmay3_d_mask_o[l_ac].* =  g_mmay3_d[l_ac].*
                  CALL agcp403_mmaz_t_mask()
                  LET g_mmay3_d_mask_n[l_ac].* =  g_mmay3_d[l_ac].*
                  
                  CALL cl_show_fld_cont()
                  #CALL agcp403_detail_show()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL agcp403_set_entry_b(l_cmd)
            CALL agcp403_set_no_entry_b(l_cmd)
            #add-point:input段before row name="input.body3.before_row"
            CALL agcp403_fetch()
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            CALL agcp403_idx_chk('d')
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body3.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body3.b_delete_ask"
               
               #end add-point 
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code =  -263 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身3刪除前 name="input.body3.b_delete"
               
               #end add-point  
               
               DELETE FROM mmaz_t
                WHERE mmazent = g_enterprise AND
                   mmazdocno = g_master.mmaydocno
                   AND mmazseq = g_mmay3_d_t.mmazseq
                   
               #add-point:單身3刪除中 name="input.body3.m_delete"
               
               #end add-point  
                   
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "mmaz_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
 
                  #add-point:單身3刪除後 name="input.body3.a_delete"
                  
                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE agcp403_bcl
               LET l_count = g_mmay_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmay_d[g_detail_idx].mmaydocno
               LET gs_keys[2] = g_mmay3_d_t.mmazseq
 
            END IF 
            
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body3.after_delete"
               
               #end add-point
                              CALL agcp403_delete_b('mmaz_t',gs_keys,"'3'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_mmay3_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
    
         AFTER INSERT    
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
            LET l_insert = FALSE   
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM mmaz_t 
             WHERE mmazent = g_enterprise AND
                   mmazdocno = g_master.mmaydocno
                   AND mmazseq = g_mmay3_d[g_detail_idx2].mmazseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前 name="input.body3.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmay_d[g_detail_idx].mmaydocno
               LET gs_keys[2] = g_mmay3_d[g_detail_idx2].mmazseq
               CALL agcp403_insert_b('mmaz_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3 name="input.body3.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_mmay_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mmaz_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL agcp403_b_fill(g_wc)
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body3.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_mmay3_d[l_ac].* = g_mmay3_d_t.*
               CLOSE agcp403_bcl2
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               CANCEL DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_mmay3_d[l_ac].* = g_mmay3_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身3)
               
               
               #add-point:單身page3修改前 name="input.body3.b_update"
               UPDATE agcp403_tmp1 SET (mmazseq,mmaz002,mmaz003,mmaz004,mmaz005,mmaz001,mmaz006,mmaz007) = (g_mmay3_d[l_ac].mmazseq, 
                   g_mmay3_d[l_ac].mmaz002,g_mmay3_d[l_ac].mmaz003,g_mmay3_d[l_ac].mmaz004,g_mmay3_d[l_ac].mmaz005, 
                   g_mmay3_d[l_ac].mmaz001,g_mmay3_d[l_ac].mmaz006,g_mmay3_d[l_ac].mmaz007) #自訂欄位頁簽 

                WHERE mmazent = g_enterprise AND
                   mmazdocno = g_master.mmaydocno
                   AND mmazseq = g_mmay3_d_t.mmazseq
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "agcp403_tmp"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                     LET g_mmay3_d[l_ac].* = g_mmay3_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "agcp403_tmp"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
  
                     CALL s_transaction_end('N','0')
                     LET g_mmay3_d[l_ac].* = g_mmay3_d_t.*
                  OTHERWISE
               END CASE               
               CONTINUE DIALOG        
               #end add-point
               
               #將遮罩欄位還原
               CALL agcp403_mmaz_t_mask_restore('restore_mask_o')
               
               UPDATE mmaz_t SET (mmazseq,mmaz002,mmaz003,mmaz004,mmaz005,mmaz001,mmaz006,mmaz007) = (g_mmay3_d[l_ac].mmazseq, 
                   g_mmay3_d[l_ac].mmaz002,g_mmay3_d[l_ac].mmaz003,g_mmay3_d[l_ac].mmaz004,g_mmay3_d[l_ac].mmaz005, 
                   g_mmay3_d[l_ac].mmaz001,g_mmay3_d[l_ac].mmaz006,g_mmay3_d[l_ac].mmaz007) #自訂欄位頁簽 
 
                WHERE mmazent = g_enterprise AND
                   mmazdocno = g_master.mmaydocno
                   AND mmazseq = g_mmay3_d_t.mmazseq
                   
               #add-point:單身修改中 name="input.body3.m_update"
               
               #end add-point
                   
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     LET g_mmay3_d[l_ac].* = g_mmay3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mmaz_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_mmay3_d[l_ac].* = g_mmay3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mmaz_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmay_d[g_detail_idx].mmaydocno
               LET gs_keys_bak[1] = g_mmay_d[g_detail_idx].mmaydocno
               LET gs_keys[2] = g_mmay3_d[g_detail_idx2].mmazseq
               LET gs_keys_bak[2] = g_mmay3_d_t.mmazseq
               CALL agcp403_update_b('mmaz_t',gs_keys,gs_keys_bak,"'3'")
                     #資料多語言用-增/改
                     
                     
                     #將遮罩欄位進行遮蔽
                     CALL agcp403_mmaz_t_mask_restore('restore_mask_n')
                     #修改歷程記錄(下層修改)
                     LET g_log1 = util.JSON.stringify(g_mmay3_d_t)
                     LET g_log2 = util.JSON.stringify(g_mmay3_d[l_ac])
                     IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               #add-point:單身page3修改後 name="input.body3.a_update"
               
               #end add-point
            END IF
         
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmazseq
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mmay3_d[l_ac].mmazseq,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD mmazseq
            END IF 
 
 
 
            #add-point:AFTER FIELD mmazseq name="input.a.page3.mmazseq"

            IF NOT cl_null(g_mmay3_d[l_ac].mmazseq) THEN 
            END IF 

            #此段落由子樣板a05產生
            IF  g_mmay_d[g_detail_idx].mmaydocno IS NOT NULL AND g_mmay3_d[g_detail_idx2].mmazseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mmay_d[g_detail_idx].mmaydocno != g_mmay_d[g_detail_idx].mmaydocno OR g_mmay3_d[g_detail_idx2].mmazseq != g_mmay3_d_t.mmazseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmaz_t WHERE "||"mmazent = '" ||g_enterprise|| "' AND "||"mmazdocno = '"||g_mmay_d[g_detail_idx].mmaydocno ||"' AND "|| "mmazseq = '"||g_mmay3_d[g_detail_idx2].mmazseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmazseq
            #add-point:BEFORE FIELD mmazseq name="input.b.page3.mmazseq"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmazseq
            #add-point:ON CHANGE mmazseq name="input.g.page3.mmazseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaz002
            
            #add-point:AFTER FIELD mmaz002 name="input.a.page3.mmaz002"
            CALL agcp403_mmaz_desc()
            IF NOT cl_null(g_mmay3_d[l_ac].mmaz002) THEN
#               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#               INITIALIZE g_chkparam.* TO NULL
#
#               #設定g_chkparam.*的參數
#               LET g_chkparam.arg1 = g_mmay3_d[l_ac].mmaz002
#               LET g_chkparam.arg2 = '8'
#               LET g_chkparam.arg3 = g_site
#
#               #呼叫檢查存在並帶值的library
#               IF NOT cl_chk_exist("v_ooed004") THEN
#                  LET g_mmay3_d[l_ac].mmaz002 = g_mmay3_d_t.mmaz002
#                  CALL agcp403_mmaz_desc()
#                  NEXT FIELD CURRENT
#               END IF
               IF s_aooi500_setpoint(g_prog,'mmaz002') THEN
                  CALL s_aooi500_chk(g_prog,'mmaz002',g_mmay3_d[l_ac].mmaz002,g_site) RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()

                     LET g_mmay3_d[l_ac].mmaz002 = g_mmay3_d_t.mmaz002
                     CALL agcp403_mmaz_desc()
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_mmay3_d[l_ac].mmaz002
                  LET g_chkparam.arg2 = '8'
                  LET g_chkparam.arg3 = g_site
                  
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_ooed004") THEN
                     LET g_mmay3_d[l_ac].mmaz002 = g_mmay3_d_t.mmaz002
                     CALL agcp403_mmaz_desc()
                     NEXT FIELD CURRENT
                  END IF
               END IF
               IF NOT cl_null(g_mmay3_d[l_ac].mmaz003) THEN
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_mmay3_d[l_ac].mmaz002
                  LET g_chkparam.arg2 = g_mmay3_d[l_ac].mmaz003
                  #160318-00025#18  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
                  #160318-00025#18  by 07900 --add-end
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_inaa001") THEN
                     LET g_mmay3_d[l_ac].mmaz002 = g_mmay3_d_t.mmaz002
                     CALL agcp403_mmaz_desc()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #160604-00009#50 -s by 08172
            CALL s_artt220_default(g_mmay3_d[l_ac].mmaz002,'6')   RETURNING l_success,g_mmay3_d[l_ac].mmaz003
            CALL agcp403_mmaz_desc()
            #160604-00009#50 -e by 08172
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaz002
            #add-point:BEFORE FIELD mmaz002 name="input.b.page3.mmaz002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaz002
            #add-point:ON CHANGE mmaz002 name="input.g.page3.mmaz002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaz003
            
            #add-point:AFTER FIELD mmaz003 name="input.a.page3.mmaz003"
            CALL agcp403_mmaz_desc()
            IF NOT cl_null(g_mmay3_d[l_ac].mmaz003) THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_mmay3_d[l_ac].mmaz002
               LET g_chkparam.arg2 = g_mmay3_d[l_ac].mmaz003
               #160318-00025#18  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
               #160318-00025#18  by 07900 --add-end
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_inaa001") THEN
                  LET g_mmay3_d[l_ac].mmaz003 = g_mmay3_d_t.mmaz003
                  CALL agcp403_mmaz_desc()
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaz003
            #add-point:BEFORE FIELD mmaz003 name="input.b.page3.mmaz003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaz003
            #add-point:ON CHANGE mmaz003 name="input.g.page3.mmaz003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaz004
            
            #add-point:AFTER FIELD mmaz004 name="input.a.page3.mmaz004"
            #160604-00009#50 -s by 08172
            CALL s_artt220_default(g_mmay3_d[l_ac].mmaz004,'6')   RETURNING l_success,g_mmay3_d[l_ac].mmaz005
            CALL agcp403_mmaz_desc()
            #160604-00009#50 -e by 08172
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaz004
            #add-point:BEFORE FIELD mmaz004 name="input.b.page3.mmaz004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaz004
            #add-point:ON CHANGE mmaz004 name="input.g.page3.mmaz004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaz005
            
            #add-point:AFTER FIELD mmaz005 name="input.a.page3.mmaz005"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaz005
            #add-point:BEFORE FIELD mmaz005 name="input.b.page3.mmaz005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaz005
            #add-point:ON CHANGE mmaz005 name="input.g.page3.mmaz005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaz001
            
            #add-point:AFTER FIELD mmaz001 name="input.a.page3.mmaz001"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaz001
            #add-point:BEFORE FIELD mmaz001 name="input.b.page3.mmaz001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaz001
            #add-point:ON CHANGE mmaz001 name="input.g.page3.mmaz001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaz006
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mmay3_d[l_ac].mmaz006,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD mmaz006
            END IF 
 
 
 
            #add-point:AFTER FIELD mmaz006 name="input.a.page3.mmaz006"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaz006
            #add-point:BEFORE FIELD mmaz006 name="input.b.page3.mmaz006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaz006
            #add-point:ON CHANGE mmaz006 name="input.g.page3.mmaz006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaz007
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mmay3_d[l_ac].mmaz007,"0","1","","","azz-00079",1) THEN
               NEXT FIELD mmaz007
            END IF 
 
 
 
            #add-point:AFTER FIELD mmaz007 name="input.a.page3.mmaz007"
            IF NOT cl_null(g_mmay3_d[l_ac].mmaz007) THEN
               IF g_mmay3_d[l_ac].mmaz007 <> g_mmay3_d[l_ac].mmaz006 THEN
                  IF NOT cl_ask_confirm('agc-00090') THEN
                     LET g_mmay3_d[l_ac].mmaz007 = g_mmay3_d_t.mmaz007
                     NEXT FIELD mmaz007
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaz007
            #add-point:BEFORE FIELD mmaz007 name="input.b.page3.mmaz007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaz007
            #add-point:ON CHANGE mmaz007 name="input.g.page3.mmaz007"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.mmazseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmazseq
            #add-point:ON ACTION controlp INFIELD mmazseq name="input.c.page3.mmazseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.mmaz002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaz002
            #add-point:ON ACTION controlp INFIELD mmaz002 name="input.c.page3.mmaz002"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mmay3_d[l_ac].mmaz002             #給予default值

            #給予arg
#            LET g_qryparam.arg1 = g_site
#            LET g_qryparam.arg2 = '8'
#            CALL q_ooed004()                                #呼叫開窗
            IF s_aooi500_setpoint(g_prog,'mmaz002') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'mmaz002',g_site,'i') #150308-00001#2  By sakura add 'i'
               CALL q_ooef001_24()
            ELSE
               LET g_qryparam.arg1 = g_site
               LET g_qryparam.arg2 = '8'
               CALL q_ooed004()
            END IF

            LET g_mmay3_d[l_ac].mmaz002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_mmay3_d[l_ac].mmaz002 TO mmaz002              #顯示到畫面上
            CALL agcp403_mmaz_desc()
            NEXT FIELD mmaz002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page3.mmaz003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaz003
            #add-point:ON ACTION controlp INFIELD mmaz003 name="input.c.page3.mmaz003"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mmay3_d[l_ac].mmaz003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_mmay3_d[l_ac].mmaz002
            CALL q_inaa001_6()                                #呼叫開窗

            LET g_mmay3_d[l_ac].mmaz003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_mmay3_d[l_ac].mmaz003 TO mmaz003              #顯示到畫面上
            CALL agcp403_mmaz_desc()
            NEXT FIELD mmaz003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page3.mmaz004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaz004
            #add-point:ON ACTION controlp INFIELD mmaz004 name="input.c.page3.mmaz004"
 
            #END add-point
 
 
         #Ctrlp:input.c.page3.mmaz005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaz005
            #add-point:ON ACTION controlp INFIELD mmaz005 name="input.c.page3.mmaz005"
      
          
            #END add-point
 
 
         #Ctrlp:input.c.page3.mmaz001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaz001
            #add-point:ON ACTION controlp INFIELD mmaz001 name="input.c.page3.mmaz001"
 
            #END add-point
 
 
         #Ctrlp:input.c.page3.mmaz006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaz006
            #add-point:ON ACTION controlp INFIELD mmaz006 name="input.c.page3.mmaz006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.mmaz007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaz007
            #add-point:ON ACTION controlp INFIELD mmaz007 name="input.c.page3.mmaz007"
            
            #END add-point
 
 
 
 
         AFTER ROW
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_mmay3_d[l_ac].* = g_mmay3_d_t.*
               END IF
               CLOSE agcp403_bcl2
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               CANCEL DIALOG 
            END IF
            
            #其他table進行unlock
            
 
            CALL agcp403_unlock_b("mmaz_t")
            CALL s_transaction_end('Y','0')
            LET l_cmd = ''
 
         AFTER INPUT
            #add-point:input段after input  name="input.body3.after_input"
            
            #end add-point   
 
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_mmay3_d[li_reproduce_target].* = g_mmay3_d[li_reproduce].*
 
               LET g_mmay3_d[li_reproduce_target].mmazseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_mmay3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_mmay3_d.getLength()+1
            END IF
 
      END INPUT
 
      
      DISPLAY ARRAY g_mmay2_d TO s_detail2.*
         ATTRIBUTES(COUNT=g_detail_cnt)  
      
         BEFORE DISPLAY 
            CALL FGL_SET_ARR_CURR(g_detail_idx)
            CALL agcp403_b_fill(g_wc)
            LET g_current_page = 2
        
         BEFORE ROW
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            CALL cl_show_fld_cont() 
            LET g_action_choice = "fetch"
            CALL agcp403_fetch()
            CALL agcp403_idx_chk('m')
            
         #add-point:page2自定義行為 name="input.body2.action"
         
         #end add-point
            
      END DISPLAY
 
    
 
      
      #add-point:input段input_array" name="input.more_inputarray"
      
      #end add-point
      
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         LET g_curr_diag = ui.DIALOG.getCurrent()
         IF g_detail_idx > 0 THEN
            IF g_detail_idx > g_mmay_d.getLength() THEN
               LET g_detail_idx = g_mmay_d.getLength()
            END IF
            CALL DIALOG.setCurrentRow("s_detail1", g_detail_idx)
            LET l_ac = g_detail_idx
         END IF 
         LET g_detail_idx = l_ac
         #add-point:input段input_array" name="input.before_dialog"
         IF g_flag = 'Y' THEN
            NEXT FIELD mmaz002
         END IF
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
         CANCEL DIALOG
 
      ON ACTION close
         LET INT_FLAG = TRUE 
         CANCEL DIALOG
 
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
   
   CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
 
   CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx2)
 
   
   #add-point:input段修改後 name="input.after_input"
   
   #end add-point
 
   CLOSE agcp403_bcl
   CALL s_transaction_end('Y','0')
   
END FUNCTION
 
{</section>}
 
{<section id="agcp403.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION agcp403_b_fill(p_wc2)
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2           STRING
   DEFINE l_ac_t          LIKE type_t.num10
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_where         STRING
   #end add-point
   
   #add-point:Function前置處理  name="b_fill.sql_before"
   LET l_where = s_aooi500_sql_where(g_prog,'mmaysite')
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT t0.mmaydocno,t0.mmay001,t0.mmaysite,t0.mmaystus,t0.mmaydocno,t0.mmaymodid, 
       t0.mmaymoddt,t0.mmayownid,t0.mmayowndp,t0.mmaycrtid,t0.mmaycrtdp,t0.mmaycrtdt,t0.mmaycnfid,t0.mmaycnfdt , 
       t1.ooefl003 ,t2.ooefl003 ,t3.ooag011 ,t4.ooag011 ,t5.ooefl003 ,t6.ooag011 ,t7.ooefl003 ,t8.ooag011 FROM mmay_t t0", 
 
 
               " LEFT JOIN mmaz_t ON mmazent = mmayent AND mmaydocno = mmazdocno",
 
 
               "",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.mmay001 AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.mmaysite AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.mmaymodid  ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.mmayownid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.mmayowndp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.mmaycrtid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.mmaycrtdp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.mmaycnfid  ",
 
               " WHERE t0.mmayent= ?  AND  1=1 AND (", p_wc2, ") "
   #add-point:b_fill段sql_wc name="b_fill.sql_wc"
   
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("mmay_t"),
                      " ORDER BY t0.mmaydocno"
  
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = "SELECT  UNIQUE t0.mmaydocno,t0.mmay001,t0.mmaysite,t0.mmaystus,t0.mmaydocno,t0.mmaymodid, 
       t0.mmaymoddt,t0.mmayownid,t0.mmayowndp,t0.mmaycrtid,t0.mmaycrtdp,t0.mmaycrtdt,t0.mmaycnfid,t0.mmaycnfdt , 
       t1.ooefl003 ,t2.ooefl003 ,t3.ooag011 ,t4.ooag011 ,t5.ooefl003 ,t6.ooag011 ,t7.ooefl003 ,t8.ooag011 FROM mmay_t t0", 

 
               " LEFT JOIN mmaz_t ON mmazent = mmayent AND mmaydocno = mmazdocno",
 
 
               "",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent='"||g_enterprise||"' AND t1.ooefl001=t0.mmay001 AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent='"||g_enterprise||"' AND t2.ooefl001=t0.mmaysite AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent='"||g_enterprise||"' AND t3.ooag001=t0.mmaymodid  ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent='"||g_enterprise||"' AND t4.ooag001=t0.mmayownid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent='"||g_enterprise||"' AND t5.ooefl001=t0.mmayowndp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent='"||g_enterprise||"' AND t6.ooag001=t0.mmaycrtid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent='"||g_enterprise||"' AND t7.ooefl001=t0.mmaycrtdp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent='"||g_enterprise||"' AND t8.ooag001=t0.mmaycnfid  ",
               " WHERE t0.mmayent= ? AND t0.mmay001 = '",g_site,"' AND t0.mmay000 = '",g_type,"' AND t0.mmaystus = 'Y' ",
               "   AND mmaz008 IS NULL AND (", p_wc2, ") "
   LET g_sql = g_sql CLIPPED," AND ",l_where
   LET g_sql = g_sql, cl_sql_add_filter("mmay_t")," ORDER BY t0.mmaydocno"
   #end add-point
  
   #LET g_sql = cl_sql_add_tabid(g_sql,"mmay_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料  
   PREPARE agcp403_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR agcp403_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_mmay_d.clear()
   CALL g_mmay2_d.clear()   
   CALL g_mmay3_d.clear()   
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_mmay_d[l_ac].mmaydocno,g_mmay_d[l_ac].mmay001,g_mmay_d[l_ac].mmaysite, 
       g_mmay_d[l_ac].mmaystus,g_mmay2_d[l_ac].mmaydocno,g_mmay2_d[l_ac].mmaymodid,g_mmay2_d[l_ac].mmaymoddt, 
       g_mmay2_d[l_ac].mmayownid,g_mmay2_d[l_ac].mmayowndp,g_mmay2_d[l_ac].mmaycrtid,g_mmay2_d[l_ac].mmaycrtdp, 
       g_mmay2_d[l_ac].mmaycrtdt,g_mmay2_d[l_ac].mmaycnfid,g_mmay2_d[l_ac].mmaycnfdt,g_mmay_d[l_ac].mmay001_desc, 
       g_mmay_d[l_ac].mmaysite_desc,g_mmay2_d[l_ac].mmaymodid_desc,g_mmay2_d[l_ac].mmayownid_desc,g_mmay2_d[l_ac].mmayowndp_desc, 
       g_mmay2_d[l_ac].mmaycrtid_desc,g_mmay2_d[l_ac].mmaycrtdp_desc,g_mmay2_d[l_ac].mmaycnfid_desc
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充 name="b_fill.fill"
 
      #end add-point
 
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "" 
            LET g_errparam.code = 9035 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF
      
      LET l_ac = l_ac + 1
      
   END FOREACH
   LET g_error_show = 0
   
 
   CALL g_mmay_d.deleteElement(g_mmay_d.getLength())   
   CALL g_mmay2_d.deleteElement(g_mmay2_d.getLength())
   CALL g_mmay3_d.deleteElement(g_mmay3_d.getLength())
 
   
   #確定指標無超過上限, 超過則指到最後一筆
   IF g_detail_idx > g_mmay_d.getLength() THEN
       IF g_mmay_d.getLength() > 0 THEN
          LET g_detail_idx = g_mmay_d.getLength()
       ELSE
          LET g_detail_idx = 1
      END IF
   END IF
   
   #將key欄位填到每個page
   LET l_ac_t = g_detail_idx
   FOR g_detail_idx = 1 TO g_mmay_d.getLength()
      LET g_mmay2_d[g_detail_idx].mmaydocno = g_mmay_d[g_detail_idx].mmaydocno 
      #LET g_mmay3_d[g_detail_idx2].mmazseq = g_mmay_d[g_detail_idx].mmaydocno 
 
   END FOR
   LET g_detail_idx = l_ac_t
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
    
   LET g_detail_cnt = l_ac - 1
   IF g_detail_cnt > 0 THEN
      DISPLAY g_detail_cnt TO FORMONLY.h_count
   END IF
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE agcp403_pb
   
   LET g_loc = 'm'
   CALL agcp403_detail_show() 
   
   LET l_ac = 1
   IF g_mmay_d.getLength() > 0 THEN
      CALL agcp403_fetch()
   END IF
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_mmay_d.getLength()
      LET g_mmay_d_mask_o[l_ac].* =  g_mmay_d[l_ac].*
      CALL agcp403_mmay_t_mask()
      LET g_mmay_d_mask_n[l_ac].* =  g_mmay_d[l_ac].*
   END FOR
   
   LET g_mmay2_d_mask_o.* =  g_mmay2_d.*
   FOR l_ac = 1 TO g_mmay2_d.getLength()
      LET g_mmay2_d_mask_o[l_ac].* =  g_mmay2_d[l_ac].*
      CALL agcp403_mmay_t_mask()
      LET g_mmay2_d_mask_n[l_ac].* =  g_mmay2_d[l_ac].*
   END FOR
   LET g_mmay3_d_mask_o.* =  g_mmay3_d.*
   FOR l_ac = 1 TO g_mmay3_d.getLength()
      LET g_mmay3_d_mask_o[l_ac].* =  g_mmay3_d[l_ac].*
      CALL agcp403_mmaz_t_mask()
      LET g_mmay3_d_mask_n[l_ac].* =  g_mmay3_d[l_ac].*
   END FOR
 
   
   ERROR "" 
   
END FUNCTION
 
{</section>}
 
{<section id="agcp403.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION agcp403_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   IF g_detail_idx = 0 OR cl_null(g_detail_idx) THEN
      LET g_detail_idx = 1
   END IF
   #end add-point
   
   #add-point:Function前置處理  name="fetch.pre_function"
   
   #end add-point
   
   #判定單頭是否有資料
   IF g_detail_idx <= 0 OR g_mmay_d.getLength() = 0 THEN
      RETURN
   END IF
   
   #CALL g_mmay2_d.clear()
   CALL g_mmay3_d.clear()
 
   
   LET li_ac = l_ac 
    
   IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
      
      #end add-point
   THEN
      LET g_sql = "SELECT  DISTINCT t0.mmazseq,t0.mmaz002,t0.mmaz003,t0.mmaz004,t0.mmaz005,t0.mmaz001, 
          t0.mmaz006,t0.mmaz007 ,t9.ooefl003 ,t10.inayl003 ,t11.ooefl003 ,t12.inayl003 ,t13.gcafl003 FROM mmaz_t t0", 
              
                  "",
                                 " LEFT JOIN ooefl_t t9 ON t9.ooeflent="||g_enterprise||" AND t9.ooefl001=t0.mmaz002 AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t10 ON t10.inaylent="||g_enterprise||" AND t10.inayl001=t0.mmaz003 AND t10.inayl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t11 ON t11.ooeflent="||g_enterprise||" AND t11.ooefl001=t0.mmaz004 AND t11.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t12 ON t12.inaylent="||g_enterprise||" AND t12.inayl001=t0.mmaz005 AND t12.inayl002='"||g_dlang||"' ",
               " LEFT JOIN gcafl_t t13 ON t13.gcaflent="||g_enterprise||" AND t13.gcafl001=t0.mmaz001 AND t13.gcafl002='"||g_dlang||"' ",
 
                  " WHERE t0.mmazent=?  AND t0. mmazdocno=?"
      #add-point:單身sql wc name="fetch.sql_wc2"
      
      #end add-point
      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      END IF
      
      LET g_sql = g_sql, " ORDER BY t0.mmazseq" 
                         
      #add-point:單身填充前 name="fetch.before_fill2"
      
      #end add-point
      
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料    
      PREPARE agcp403_pb2 FROM g_sql
      DECLARE b_fill_curs2 CURSOR FOR agcp403_pb2
   END IF
   
#  LET l_ac = g_detail_idx   #(ver:45)
#  OPEN b_fill_curs2 USING g_enterprise,g_mmay_d[l_ac].mmaydocno   #(ver:45)
   
   LET l_ac = 1
#  FOREACH b_fill_curs2 USING g_enterprise,g_mmay_d[l_ac].mmaydocno INTO g_mmay3_d[l_ac].mmazseq,g_mmay3_d[l_ac].mmaz002, 
#    g_mmay3_d[l_ac].mmaz003,g_mmay3_d[l_ac].mmaz004,g_mmay3_d[l_ac].mmaz005,g_mmay3_d[l_ac].mmaz001, 
#    g_mmay3_d[l_ac].mmaz006,g_mmay3_d[l_ac].mmaz007,g_mmay3_d[l_ac].mmaz002_desc,g_mmay3_d[l_ac].mmaz003_desc, 
#    g_mmay3_d[l_ac].mmaz004_desc,g_mmay3_d[l_ac].mmaz005_desc,g_mmay3_d[l_ac].mmaz001_desc   #(ver:45)  
#    #(ver:46)mark
   FOREACH b_fill_curs2 USING g_enterprise,g_mmay_d[g_detail_idx].mmaydocno INTO g_mmay3_d[l_ac].mmazseq, 
       g_mmay3_d[l_ac].mmaz002,g_mmay3_d[l_ac].mmaz003,g_mmay3_d[l_ac].mmaz004,g_mmay3_d[l_ac].mmaz005, 
       g_mmay3_d[l_ac].mmaz001,g_mmay3_d[l_ac].mmaz006,g_mmay3_d[l_ac].mmaz007,g_mmay3_d[l_ac].mmaz002_desc, 
       g_mmay3_d[l_ac].mmaz003_desc,g_mmay3_d[l_ac].mmaz004_desc,g_mmay3_d[l_ac].mmaz005_desc,g_mmay3_d[l_ac].mmaz001_desc  
         #(ver:45) #(ver:46)
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      #add-point:b_fill段資料填充 name="fetch.fill2"
      #CALL agcp403_mmaz_desc()   #150907-00033#2 20150923 mark by beckxie
      #end add-point
      
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
      
      LET l_ac = l_ac + 1
      
   END FOREACH
 
 
 
   #add-point:單身填充後 name="fetch.after_fill"
   
   #end add-point
   
   #CALL g_mmay2_d.deleteElement(g_mmay2_d.getLength())   
   CALL g_mmay3_d.deleteElement(g_mmay3_d.getLength())   
 
   
   LET g_mmay3_d_mask_o.* =  g_mmay3_d.*
   FOR l_ac = 1 TO g_mmay3_d.getLength()
      LET g_mmay3_d_mask_o[l_ac].* =  g_mmay3_d[l_ac].*
      CALL agcp403_mmaz_t_mask()
      LET g_mmay3_d_mask_n[l_ac].* =  g_mmay3_d[l_ac].*
   END FOR
 
   
   DISPLAY g_mmay3_d.getLength() TO FORMONLY.cnt
   #LET g_loc = 'd'
   CALL agcp403_detail_show()
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="agcp403.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION agcp403_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   DEFINE l_ac_t LIKE type_t.num10
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   DEFINE l_n    LIKE type_t.num5
   #end add-point
   
   #add-point:Function前置處理  name="detail_show.pre_function"
   
   #end add-point
   
   LET l_ac_t = l_ac
 
   #add-point:detail_show段之前 name="detail_show.before"
   
   #end add-point
   
   
   
   #帶出公用欄位reference值page1
   
    
   #帶出公用欄位reference值page2
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   #帶出公用欄位reference值page3
   
 
   
   IF g_loc = 'm' THEN
      #讀入ref值
      FOR l_ac = 1 TO g_mmay_d.getLength()
         #add-point:show段單頭reference name="detail_show.body.reference"
         #150907-00033#2 20150925 mark by beckxie---S
         #INITIALIZE g_ref_fields TO NULL
         #LET g_ref_fields[1] = g_mmay2_d[l_ac].mmayownid
         #CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
         #LET g_mmay2_d[l_ac].mmayownid_desc = '', g_rtn_fields[1] , ''
         #DISPLAY BY NAME g_mmay2_d[l_ac].mmayownid_desc
         #
         #INITIALIZE g_ref_fields TO NULL
         #LET g_ref_fields[1] = g_mmay2_d[l_ac].mmayowndp
         #CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         #LET g_mmay2_d[l_ac].mmayowndp_desc = '', g_rtn_fields[1] , ''
         #DISPLAY BY NAME g_mmay2_d[l_ac].mmayowndp_desc
         #
         #INITIALIZE g_ref_fields TO NULL
         #LET g_ref_fields[1] = g_mmay2_d[l_ac].mmaycrtid
         #CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
         #LET g_mmay2_d[l_ac].mmaycrtid_desc = '', g_rtn_fields[1] , ''
         #DISPLAY BY NAME g_mmay2_d[l_ac].mmaycrtid_desc
         #
         #INITIALIZE g_ref_fields TO NULL
         #LET g_ref_fields[1] = g_mmay2_d[l_ac].mmaycrtdp
         #CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         #LET g_mmay2_d[l_ac].mmaycrtdp_desc = '', g_rtn_fields[1] , ''
         #DISPLAY BY NAME g_mmay2_d[l_ac].mmaycrtdp_desc
         #
         #INITIALIZE g_ref_fields TO NULL
         #LET g_ref_fields[1] = g_mmay2_d[l_ac].mmaymodid
         #CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
         #LET g_mmay2_d[l_ac].mmaymodid_desc = '', g_rtn_fields[1] , ''
         #DISPLAY BY NAME g_mmay2_d[l_ac].mmaymodid_desc
         #
         #INITIALIZE g_ref_fields TO NULL
         #LET g_ref_fields[1] = g_mmay2_d[l_ac].mmaycnfid
         #CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
         #LET g_mmay2_d[l_ac].mmaycnfid_desc = '', g_rtn_fields[1] , ''
         #DISPLAY BY NAME g_mmay2_d[l_ac].mmaycnfid_desc
         
         #INITIALIZE g_ref_fields TO NULL
         #LET g_ref_fields[1] = g_mmay_d[l_ac].mmay001
         #CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         #LET g_mmay_d[l_ac].mmay001_desc = '', g_rtn_fields[1] , ''
         #DISPLAY BY NAME g_mmay_d[l_ac].mmay001_desc
         #
         #INITIALIZE g_ref_fields TO NULL
         #LET g_ref_fields[1] = g_mmay_d[l_ac].mmaysite
         #CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         #LET g_mmay_d[l_ac].mmaysite_desc = '', g_rtn_fields[1] , ''
         #DISPLAY BY NAME g_mmay_d[l_ac].mmaysite_desc
         #150907-00033#2 20150925 mark by beckxie---E
         LET l_n = 0   
         SELECT COUNT(*) INTO l_n    
           FROM agcp403_tmp 
          WHERE tmp_mmaydocno = g_mmay_d[l_ac].mmaydocno
         IF l_n = 0 THEN
            INSERT INTO agcp403_tmp(tmp_sel,tmp_mmaydocno) 
                             VALUES('N',g_mmay_d[l_ac].mmaydocno)
         END IF
         
         SELECT tmp_sel INTO g_mmay_d[l_ac].sel
           FROM agcp403_tmp 
          WHERE tmp_mmaydocno = g_mmay_d[l_ac].mmaydocno
         #end add-point
         #add-point:show段單頭reference name="detail_show.body2.reference"
 
         #end add-point
 
      END FOR
   END IF
   
   IF g_loc = 'd' THEN
      FOR l_ac = 1 TO g_mmay3_d.getLength()
        #add-point:show段單身reference name="detail_show.body3.reference"
            #150907-00033#2 20150925 mark by beckxie---S
            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_mmay3_d[l_ac].mmaz002
            #CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            #LET g_mmay3_d[l_ac].mmaz002_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_mmay3_d[l_ac].mmaz002_desc
            #150907-00033#2 20150925 mark by beckxie---E
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mmay3_d[l_ac].mmaz003
#            CALL ap_ref_array2(g_ref_fields,"SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaa001=? ","") RETURNING g_rtn_fields
#            LET g_mmay3_d[l_ac].mmaz003_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_mmay3_d[l_ac].mmaz003_desc

            #150907-00033#2 20150925 mark by beckxie---S
            #CALL s_desc_get_stock_desc(g_mmay3_d[l_ac].mmaz002,g_mmay3_d[l_ac].mmaz003) RETURNING g_mmay3_d[l_ac].mmaz003_desc
            #DISPLAY BY NAME g_mmay3_d[l_ac].mmaz003_desc
            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_mmay3_d[l_ac].mmaz004
            #CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            #LET g_mmay3_d[l_ac].mmaz004_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_mmay3_d[l_ac].mmaz004_desc
            #150907-00033#2 20150925 mark by beckxie---E
            
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mmay3_d[l_ac].mmaz005
#            CALL ap_ref_array2(g_ref_fields,"SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaa001=? ","") RETURNING g_rtn_fields
#            LET g_mmay3_d[l_ac].mmaz005_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_mmay3_d[l_ac].mmaz005_desc

            #150907-00033#2 20150925 mark by beckxie---S
            #CALL s_desc_get_stock_desc(g_mmay3_d[l_ac].mmaz004,g_mmay3_d[l_ac].mmaz005) RETURNING g_mmay3_d[l_ac].mmaz005_desc
            #DISPLAY BY NAME g_mmay3_d[l_ac].mmaz005_desc
            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_mmay3_d[l_ac].mmaz001
            #CALL ap_ref_array2(g_ref_fields,"SELECT gcafl003 FROM gcafl_t WHERE gcaflent='"||g_enterprise||"' AND gcafl001=? AND gcafl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            #LET g_mmay3_d[l_ac].mmaz001_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_mmay3_d[l_ac].mmaz001_desc
            #150907-00033#2 20150925 mark by beckxie---E
        #end add-point
      END FOR
 
      
      #add-point:detail_show段之後 name="detail_show.after"
      
      #end add-point
   END IF
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="agcp403.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION agcp403_set_entry_b(p_cmd)                                                  
   #add-point:set_entry_b段define(客製用) name="set_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1         
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="set_entry_b.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry_b段欄位控制 name="set_entry_b.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_entry_b段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("mmaz002",TRUE)
   #end add-point 
                                                                     
END FUNCTION                                                                    
 
{</section>}
 
{<section id="agcp403.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION agcp403_set_no_entry_b(p_cmd)                                               
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1           
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   DEFINE l_mmay002    LIKE mmay_t.mmay002
   #end add-point
   
   #add-point:Function前置處理  name="set_no_entry_b.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry_b段欄位控制 name="set_no_entry_b.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   LET l_mmay002 = ''
   SELECT mmay002 INTO l_mmay002
     FROM mmay_t
    WHERE mmayent = g_enterprise
      AND mmaydocno = g_mmay_d[g_detail_idx].mmaydocno
   IF NOT cl_null(l_mmay002) THEN
      CALL cl_set_comp_entry("mmaz002",FALSE)
   END IF 
   #end add-point 
                                                                          
END FUNCTION  
 
{</section>}
 
{<section id="agcp403.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION agcp403_default_search()
   #add-point:default_search段define(客製用) name="default_search.define_customerization"
   
   #end add-point  
   DEFINE li_idx  LIKE type_t.num10
   DEFINE li_cnt  LIKE type_t.num10
   DEFINE ls_wc   STRING
   #add-point:default_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   LET g_wc = " 1=1"
   RETURN
   #end add-point  
  
   #add-point:Function前置處理  name="default_search.before"
   
   #end add-point  
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " mmaydocno = '", g_argv[01], "' AND "
   END IF
   
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      LET ls_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_wc = ls_wc
   ELSE
      LET g_wc = " 1=2"
   END IF
   
   #add-point:default_search段結束前 name="default_search.after"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="agcp403.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION agcp403_delete_b(ps_table,ps_keys_bak,ps_page)
   #add-point:delete_b段define(客製用) name="delete_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:delete_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete_b.define"
   
   #end add-point     
  
   #add-point:Function前置處理  name="delete_b.pre_function"
   
   #end add-point
   
   #判斷是否是同一群組的table
   LET ls_group = "mmay_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.before_delete"
      
      #end add-point  
      DELETE FROM mmay_t
       WHERE mmayent = g_enterprise AND
         mmaydocno = ps_keys_bak[1]
      #add-point:delete_b段刪除中 name="delete_b.m_delete"
      
      #end add-point  
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = ":",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:delete_b段刪除後 name="delete_b.after_delete"
      
      #end add-point  
   END IF
   
 
   
   LET ls_group = "mmaz_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.before_delete2"
      
      #end add-point  
      DELETE FROM mmaz_t
       WHERE mmazent = g_enterprise AND
         mmazdocno = ps_keys_bak[1] AND mmazseq = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point  
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mmaz_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:delete_b段刪除後 name="delete_b.after_delete2"
      
      #end add-point  
      RETURN
   END IF
 
 
   
   #單頭刪除, 連帶刪除單身
   LET ls_group = "mmay_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.before_body_delete2"
      
      #end add-point  
      DELETE FROM mmaz_t
       WHERE mmazent = g_enterprise AND
         mmazdocno = ps_keys_bak[1]
      #add-point:delete_b段刪除中 name="delete_b.m_body_delete2"
      
      #end add-point  
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mmaz_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:delete_b段刪除後 name="delete_b.after_body_delete2"
      
      #end add-point  
      RETURN
   END IF
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="agcp403.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION agcp403_insert_b(ps_table,ps_keys,ps_page)
   #add-point:insert_b段define(客製用) name="insert_b.define_customerization"
   
   #end add-point
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:insert_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert_b.define"
   
   #end add-point
  
   #add-point:Function前置處理  name="insert_b.pre_function"
   
   #end add-point
   
   #判斷是否是同一群組的table
   LET ls_group = "mmay_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:insert_b段新增前 name="insert_b.before_insert"
      
      #end add-point
      INSERT INTO mmay_t
                  (mmayent,
                   mmaydocno
                   ,mmay001,mmaysite,mmaystus,mmaymodid,mmaymoddt,mmayownid,mmayowndp,mmaycrtid,mmaycrtdp,mmaycrtdt,mmaycnfid,mmaycnfdt) 
            VALUES(g_enterprise,
                   ps_keys[1]
                   ,g_mmay_d[g_detail_idx].mmay001,g_mmay_d[g_detail_idx].mmaysite,g_mmay_d[g_detail_idx].mmaystus, 
                       g_mmay2_d[g_detail_idx].mmaymodid,g_mmay2_d[g_detail_idx].mmaymoddt,g_mmay2_d[g_detail_idx].mmayownid, 
                       g_mmay2_d[g_detail_idx].mmayowndp,g_mmay2_d[g_detail_idx].mmaycrtid,g_mmay2_d[g_detail_idx].mmaycrtdp, 
                       g_mmay2_d[g_detail_idx].mmaycrtdt,g_mmay2_d[g_detail_idx].mmaycnfid,g_mmay2_d[g_detail_idx].mmaycnfdt) 
 
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mmay_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.after_insert"
      
      #end add-point
   END IF
   
 
   
   LET ls_group = "mmaz_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:insert_b段新增前 name="insert_b.before_insert2"
      
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
      #add-point:insert_b段新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         RETURN
      END IF
      #add-point:insert_b段新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="agcp403.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION agcp403_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   #add-point:update_b段define(客製用) name="update_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table         STRING
   DEFINE ps_page          STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num10 
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="update_b.define"
   
   #end add-point     
  
   #add-point:Function前置處理  name="update_b.pre_function"
   
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
   
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point     
   
      #將遮罩欄位還原
      CALL agcp403_mmay_t_mask_restore('restore_mask_o')
               
      UPDATE mmay_t 
         SET (mmaydocno
              ,mmay001,mmaysite,mmaystus,mmaymodid,mmaymoddt,mmayownid,mmayowndp,mmaycrtid,mmaycrtdp,mmaycrtdt,mmaycnfid,mmaycnfdt) 
              = 
             (ps_keys[1]
              ,g_mmay_d[g_detail_idx].mmay001,g_mmay_d[g_detail_idx].mmaysite,g_mmay_d[g_detail_idx].mmaystus, 
                  g_mmay2_d[g_detail_idx].mmaymodid,g_mmay2_d[g_detail_idx].mmaymoddt,g_mmay2_d[g_detail_idx].mmayownid, 
                  g_mmay2_d[g_detail_idx].mmayowndp,g_mmay2_d[g_detail_idx].mmaycrtid,g_mmay2_d[g_detail_idx].mmaycrtdp, 
                  g_mmay2_d[g_detail_idx].mmaycrtdt,g_mmay2_d[g_detail_idx].mmaycnfid,g_mmay2_d[g_detail_idx].mmaycnfdt)  
 
         WHERE mmayent = g_enterprise AND
               mmaydocno = ps_keys_bak[1]
 
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
         
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mmay_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mmay_t:",SQLERRMESSAGE  
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
            
      END CASE
 
      #將遮罩欄位進行遮蔽
      CALL agcp403_mmay_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
   LET ls_group = "mmaz_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "mmaz_t" THEN
   
      #add-point:update_b段修改前 name="update_b.before_update2"
      UPDATE agcp403_tmp1
         SET (mmazdocno,mmazseq
              ,mmaz002,mmaz003,mmaz004,mmaz005,mmaz001,mmaz006,mmaz007) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_mmay3_d[g_detail_idx2].mmaz002,g_mmay3_d[g_detail_idx2].mmaz003,g_mmay3_d[g_detail_idx2].mmaz004, 
                  g_mmay3_d[g_detail_idx2].mmaz005,g_mmay3_d[g_detail_idx2].mmaz001,g_mmay3_d[g_detail_idx2].mmaz006, 
                  g_mmay3_d[g_detail_idx2].mmaz007) 
         WHERE mmazdocno = ps_keys_bak[1] AND mmazseq = ps_keys_bak[2]
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "std-00009"
            LET g_errparam.extend = "agcp403_tmp1"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "agcp403_tmp1"
            LET g_errparam.popup = TRUE
            CALL cl_err()
  
            CALL s_transaction_end('N','0')
         OTHERWISE
            
      END CASE
      RETURN      
      #end add-point    
      
      #將遮罩欄位還原
      CALL agcp403_mmaz_t_mask_restore('restore_mask_o')
      
      UPDATE mmaz_t 
         SET (mmazdocno,mmazseq
              ,mmaz002,mmaz003,mmaz004,mmaz005,mmaz001,mmaz006,mmaz007) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_mmay3_d[g_detail_idx2].mmaz002,g_mmay3_d[g_detail_idx2].mmaz003,g_mmay3_d[g_detail_idx2].mmaz004, 
                  g_mmay3_d[g_detail_idx2].mmaz005,g_mmay3_d[g_detail_idx2].mmaz001,g_mmay3_d[g_detail_idx2].mmaz006, 
                  g_mmay3_d[g_detail_idx2].mmaz007) 
         WHERE mmazent = g_enterprise AND
               mmazdocno = ps_keys_bak[1] AND mmazseq = ps_keys_bak[2]
 
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point 
         
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mmaz_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mmaz_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
            
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL agcp403_mmaz_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update2"
      
      #end add-point 
      
      RETURN
   END IF
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="agcp403.key_update_b" >}
#+ 單頭key欄位變動後, 連帶修正其他單身table
PRIVATE FUNCTION agcp403_key_update_b()
   #add-point:update_b段define(客製用) name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE li_idx           LIKE type_t.num10 
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)   #(ver:44)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
  
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
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
    
   #add-point:update_b段修改前 name="key_update_b.before_update2"
   
   #end add-point
   
   UPDATE mmaz_t 
      SET (mmazdocno) 
           = 
          (g_master.mmaydocno) 
      WHERE mmazent = g_enterprise AND
           mmazdocno = g_master_t.mmaydocno
 
           
   #add-point:update_b段修改中 name="key_update_b.m_update2"
   
   #end add-point
           
   CASE
      WHEN SQLCA.SQLCODE #其他錯誤
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mmaz_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         
      OTHERWISE
         #若有多語言table資料一同更新
         
   END CASE
   
   #add-point:update_b段修改後 name="key_update_b.after_update2"
   
   #end add-point
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="agcp403.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION agcp403_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point   
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL agcp403_b_fill(g_wc)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "mmay_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN agcp403_bcl USING g_enterprise,
                                       g_mmay_d[g_detail_idx].mmaydocno
                                       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "agcp403_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   #鎖定整組table
   #LET ls_group = "mmaz_t,"
   #僅鎖定自身table
   LET ls_group = "mmaz_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN agcp403_bcl2 USING g_enterprise,
                                             g_master.mmaydocno,
                                             g_mmay3_d[g_detail_idx2].mmazseq
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "agcp403_bcl2:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="agcp403.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION agcp403_unlock_b(ps_table)
   #add-point:unlock_b段define(客製用) name="unlock_b.define_customerization"
   
   #end add-point  
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:unlock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
   
   LET ls_group = ""
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      CLOSE agcp403_bcl
   END IF
   
 
    
   LET ls_group = "mmaz_t,"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      CLOSE agcp403_bcl2
   END IF
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="agcp403.idx_chk" >}
#+ 單身筆數變更
PRIVATE FUNCTION agcp403_idx_chk(ps_loc)
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   DEFINE ps_loc   LIKE type_t.chr10
   DEFINE li_idx   LIKE type_t.num10
   DEFINE li_cnt   LIKE type_t.num10
   #add-point:idx_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
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
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="agcp403.mask_functions" >}
&include "erp/agc/agcp403_mask.4gl"
 
{</section>}
 
{<section id="agcp403.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION agcp403_set_pk_array()
   #add-point:set_pk_array段define name="set_pk_array.define_customerization"
   
   #end add-point
   #add-point:set_pk_array段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_pk_array.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="set_pk_array.before"
   
   #end add-point  
   
   #若l_ac<=0代表沒有資料
   IF l_ac <= 0 THEN
      RETURN
   END IF
   
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_mmay_d[g_detail_idx].mmaydocno
   LET g_pk_array[1].column = 'mmaydocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="agcp403.state_change" >}
    
 
{</section>}
 
{<section id="agcp403.func_signature" >}
   
 
{</section>}
 
{<section id="agcp403.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="agcp403.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 明细资料参考栏位显示
# Memo...........:
# Usage..........: CALL agcp403_mmaz_desc()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/03 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION agcp403_mmaz_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mmay3_d[l_ac].mmaz002
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mmay3_d[l_ac].mmaz002_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mmay3_d[l_ac].mmaz002_desc
   
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = g_mmay3_d[l_ac].mmaz003
#   CALL ap_ref_array2(g_ref_fields,"SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaa001 = ? AND inaasite='"||g_mmay3_d[l_ac].mmaz002||"'","") RETURNING g_rtn_fields
#   LET g_mmay3_d[l_ac].mmaz003_desc = '', g_rtn_fields[1] , ''
#   DISPLAY BY NAME g_mmay3_d[l_ac].mmaz003_desc
   CALL s_desc_get_stock_desc(g_mmay3_d[l_ac].mmaz002,g_mmay3_d[l_ac].mmaz003) RETURNING g_mmay3_d[l_ac].mmaz003_desc
   DISPLAY BY NAME g_mmay3_d[l_ac].mmaz003_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mmay3_d[l_ac].mmaz004
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mmay3_d[l_ac].mmaz004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mmay3_d[l_ac].mmaz004_desc
   
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = g_mmay3_d[l_ac].mmaz005
#   CALL ap_ref_array2(g_ref_fields,"SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaa001 = ? AND inaasite='"||g_mmay3_d[l_ac].mmaz004||"'","") RETURNING g_rtn_fields
#   LET g_mmay3_d[l_ac].mmaz005_desc = '', g_rtn_fields[1] , ''
#   DISPLAY BY NAME g_mmay3_d[l_ac].mmaz005_desc
   CALL s_desc_get_stock_desc(g_mmay3_d[l_ac].mmaz004,g_mmay3_d[l_ac].mmaz005) RETURNING g_mmay3_d[l_ac].mmaz005_desc
   DISPLAY BY NAME g_mmay3_d[l_ac].mmaz005_desc
   
   IF g_type = '2' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_mmay3_d[l_ac].mmaz001
      CALL ap_ref_array2(g_ref_fields,"SELECT gcafl003 FROM gcafl_t WHERE gcaflent='"||g_enterprise||"' AND gcafl001=? AND gcafl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_mmay3_d[l_ac].mmaz001_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_mmay3_d[l_ac].mmaz001_desc
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_mmay3_d[l_ac].mmaz001
      CALL ap_ref_array2(g_ref_fields,"SELECT mmanl003 FROM mmanl_t WHERE mmanlent='"||g_enterprise||"' AND mmanl001=? AND mmanl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_mmay3_d[l_ac].mmaz001_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_mmay3_d[l_ac].mmaz001_desc
   END IF
END FUNCTION

################################################################################
# Descriptions...: 批量產生調撥單
# Memo...........:
# Usage..........: CALL agcp403_produce()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/03 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION agcp403_produce()
DEFINE l_time            DATETIME YEAR TO SECOND
DEFINE l_sql             STRING
DEFINE l_ooef004         LIKE ooef_t.ooef004
DEFINE l_success         LIKE type_t.num5
DEFINE l_docno           LIKE ooba_t.ooba002
DEFINE l_mmbadocno       LIKE mmba_t.mmbadocno
DEFINE l_mmaz002         LIKE mmaz_t.mmaz002
DEFINE l_prog            LIKE type_t.chr20
DEFINE l_n               LIKE type_t.num5

   IF g_type = '1' THEN
      LET l_prog = 'ammt404'
   ELSE
      LET l_prog = 'agct404'
   END IF
   LET l_n = 0
   SELECT COUNT(*) INTO l_n
     FROM agcp403_tmp1
    WHERE mmazent = g_enterprise
      AND mmazdocno IN (SELECT tmp_mmaydocno FROM agcp403_tmp WHERE tmp_sel = 'Y')
      AND mmaz008 IS NULL
      AND mmaz007 IS NOT NULL
      AND mmaz007 <> 0    #150521-00017#1
   IF l_n = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00491'
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
   LET l_n = 0
   SELECT COUNT(*) INTO l_n
     FROM agcp403_tmp1
    WHERE mmazent = g_enterprise
      AND mmazdocno IN (SELECT tmp_mmaydocno FROM agcp403_tmp WHERE tmp_sel = 'Y')
      AND (mmaz002 IS NULL OR mmaz003 IS NULL)
      AND mmaz008 IS NULL
      AND mmaz007 IS NOT NULL
   IF l_n > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agc-00101'
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
   CALL s_transaction_begin()
   LET l_time = cl_get_current()
   LET l_sql = " SELECT UNIQUE mmaz002 ",
               "   FROM agcp403_tmp1 ",
               "  WHERE mmazent = '",g_enterprise,"'",
               "    AND mmazdocno IN (SELECT tmp_mmaydocno FROM agcp403_tmp WHERE tmp_sel = 'Y') ",
               "    AND mmaz008 IS NULL ",
               "    AND mmaz007 IS NOT NULL"
               ############################150521-00017#1
               ,"   AND mmaz007 <> 0 "
               ############################
   PREPARE agcp403_sel_mmay_pb FROM l_sql
   DECLARE agcp403_sel_mmay_curs CURSOR FOR agcp403_sel_mmay_pb
   FOREACH agcp403_sel_mmay_curs INTO l_mmaz002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins_mmba"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      END IF
      CALL s_arti200_get_def_doc_type(g_site,l_prog,'2') RETURNING l_success,l_docno
      IF NOT l_success THEN
         CALL s_transaction_end('N','0')
         RETURN   
      END IF
      #自動編號
      CALL s_aooi200_gen_docno(g_site,l_docno,g_today,l_prog) RETURNING l_success,l_mmbadocno
      IF NOT l_success THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apm-00003'
         LET g_errparam.extend = l_mmbadocno
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN   
      END IF
      #INS 會員卡券調撥單頭檔
      INSERT INTO mmba_t(mmbaent,mmbasite,mmbaunit,mmbadocno,mmbadocdt,mmba000,mmbaownid,mmbaowndp,mmbacrtid,mmbacrtdp,mmbacrtdt,mmbamodid,mmbamoddt,mmbacnfid,mmbacnfdt,mmbapstid,mmbapstdt,mmbastus)
                  VALUES(g_enterprise,l_mmaz002,l_mmaz002,l_mmbadocno,g_today,g_type,g_user,g_dept,g_user,g_dept,l_time,'','','','','','','N')
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins_mmba"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #INS 會員卡券調撥單身檔
      INSERT INTO mmbb_t(mmbbent,mmbbsite,mmbbunit,mmbbdocno,mmbb000,mmbbseq,mmbb001,mmbb002,mmbb003,mmbb004,mmbb005,mmbb006,mmbb007,mmbb008)
      SELECT mmazent,mmaz002,mmaz002,l_mmbadocno,mmaz000,ROWNUM,mmaz001,mmaz003,mmaz004,mmaz005,mmaz007,0,mmazdocno,mmazseq
        FROM agcp403_tmp1
       WHERE mmazent = g_enterprise
         AND mmaz002 = l_mmaz002
         AND mmazdocno IN (SELECT tmp_mmaydocno FROM agcp403_tmp WHERE tmp_sel = 'Y')
         AND mmaz000 = g_type
         AND mmaz008 IS NULL
         AND mmaz007 IS NOT NULL
         ############################150521-00017#1
         AND mmaz007 <> 0 
         ############################
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins_mmbb"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      END IF
      UPDATE mmaz_t SET mmaz007 = (SELECT mmbb005 FROM mmbb_t WHERE mmbbent = g_enterprise AND mmbbdocno = l_mmbadocno AND mmbb007 = mmazdocno AND mmbb008 = mmazseq ),
                        mmaz008 = (SELECT mmbbdocno FROM mmbb_t WHERE mmbbent = g_enterprise AND mmbbdocno = l_mmbadocno AND mmbb007 = mmazdocno AND mmbb008 = mmazseq ),
                        mmaz009 = (SELECT mmbbseq FROM mmbb_t WHERE mmbbent = g_enterprise AND mmbbdocno = l_mmbadocno AND mmbb007 = mmazdocno AND mmbb008 = mmazseq )
       WHERE mmazent = g_enterprise
         AND mmazdocno IN (SELECT tmp_mmaydocno FROM agcp403_tmp WHERE tmp_sel = 'Y')
         AND mmaz000 = g_type
         AND mmaz008 IS NULL          
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd_mmaz"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      END IF
   END FOREACH
   DELETE FROM agcp403_tmp
   INSERT INTO agcp403_tmp
   SELECT 'N',mmaydocno
     FROM mmay_t
    WHERE mmayent = g_enterprise
      AND mmay001 = g_site
      AND mmay000 = g_type
      AND mmaystus = 'Y'
      
   DELETE FROM agcp403_tmp1   
   INSERT INTO agcp403_tmp1(mmazent,mmazdocno,mmazseq,mmaz000,mmaz002,mmaz003,mmaz004,mmaz005,mmaz001,mmaz006,mmaz007,mmaz008,mmaz009)
   SELECT mmazent,mmazdocno,mmazseq,mmaz000,mmaz002,mmaz003,mmaz004,mmaz005,mmaz001,mmaz006,mmaz007,mmaz008,mmaz009
     FROM mmaz_t
    WHERE mmazent = g_enterprise   
   INITIALIZE g_errparam TO NULL
   LET g_errparam.code = 'agc-00095'
   LET g_errparam.extend = ''
   LET g_errparam.popup = TRUE
   CALL cl_err()

   CALL s_transaction_end('Y','0')
   CALL agcp403_b_fill(g_wc)
   
END FUNCTION

 
{</section>}
 
