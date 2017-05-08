#該程式已解開Section, 不再透過樣板產出!
{<section id="ammq301.description" >}
#+ Version..: T100-ERP-1.00.00(版次:1) Build-000201
#+ 
#+ Filename...: ammq301
#+ Description: 會員資料快速查詢
#+ Creator....: 02296(2014/04/14)
#+ Modifier...: 02296(2014/04/14)
#+ Buildtype..: 應用 i02 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="ammq301.global" >}

 
IMPORT os
IMPORT util
#add-point:增加匯入項目
#160615-00046#3   2016/06/20   by 08172   增加生效日期
#160905-00007#6   2016/09/05   By 02599   SQL条件增加ent
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_mmaf_d RECORD
       #statepic       LIKE type_t.chr1,
       sel            LIKE type_t.chr1,
       mmaf008 LIKE mmaf_t.mmaf008, 
   mmaf009 LIKE mmaf_t.mmaf009, 
   mmaf001 LIKE mmaf_t.mmaf001, 
   mmaf015 LIKE mmaf_t.mmaf015, 
   mmaf013 LIKE mmaf_t.mmaf013, 
   mmaf014 LIKE mmaf_t.mmaf014, 
   mmaf003 LIKE mmaf_t.mmaf003,
   mmaf004 LIKE mmaf_t.mmaf004,
   mmaf012 LIKE mmaf_t.mmaf012, 
   mmaf021 LIKE mmaf_t.mmaf021,
   mmaf021_desc LIKE oocql_t.oocql004,   
   mmafunit LIKE mmaf_t.mmafunit,
   mmafunit_desc LIKE ooefl_t.ooefl003,   
   mmaf019 LIKE mmaf_t.mmaf019,
   mmaf019_desc LIKE ooag_t.ooag011,   
   mmafcrtdt LIKE mmaf_t.mmafcrtdt, 
   mmaf024 LIKE mmaf_t.mmaf024,
   mmaf025 LIKE mmaf_t.mmaf025,
   mmaf026 LIKE mmaf_t.mmaf026, 
   mmaf027 LIKE mmaf_t.mmaf027, 
   mmaf028 LIKE mmaf_t.mmaf028,
   mmaf011 LIKE mmaf_t.mmaf011  
       END RECORD
 
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_mmaf_d
DEFINE g_master_t                   type_g_mmaf_d
DEFINE g_mmaf_d          DYNAMIC ARRAY OF type_g_mmaf_d
DEFINE g_mmaf_d_t        type_g_mmaf_d
 
      
DEFINE g_wc                 STRING
DEFINE g_wc_t               STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                STRING
DEFINE g_wc_filter          STRING
DEFINE g_wc_filter_t        STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                        #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10    
DEFINE l_ac                 LIKE type_t.num5              
DEFINE l_ac_d               LIKE type_t.num5              #單身idx 
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_current_page       LIKE type_t.num5              #目前所在頁數
DEFINE g_detail_cnt         LIKE type_t.num5              #單身 總筆數(所有資料)
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_master_idx         LIKE type_t.num5
DEFINE g_detail_idx         LIKE type_t.num5
DEFINE g_detail_idx2        LIKE type_t.num5
DEFINE g_hyper_url          STRING                        #hyperlink的主要網址
 
 
#多table用wc
DEFINE g_wc_table           STRING
 
 
 
DEFINE g_wc_filter_table           STRING
 
 
 
 
#add-point:自定義模組變數(Module Variable)
DEFINE g_wc3    STRING
DEFINE g_wc4    STRING
DEFINE g_wc5    STRING
DEFINE l_mmaf0001  like type_t.chr10
DEFINE l_mmaf0002  like type_t.chr10
DEFINE l_mmaf0003  like type_t.chr10 
DEFINE l_mmaf0004  like type_t.chr10
 TYPE type_g_mmaq_d        RECORD
       mmaq001       LIKE  mmaq_t.mmaq001,
       mmaq002       LIKE  mmaq_t.mmaq002,
       mmaq002_desc  LIKE type_t.chr80,
       mmaq044       LIKE mmaq_t.mmaq044,       #160615-00046#3  by 08172
       mmaq005       LIKE  mmaq_t.mmaq005,
       mmaq006       LIKE  mmaq_t.mmaq006
       
       END RECORD
DEFINE g_mmaq_d          DYNAMIC ARRAY OF type_g_mmaq_d
DEFINE l_ac2         LIKE type_t.num5
DEFINE g_rec_b       LIKE type_t.num5
DEFINE l_cmd         STRING
DEFINE i             LIKE type_t.num5
DEFINE g_temp_idx    LIKE type_t.num5
DEFINE g_aw          LIKE type_t.num5
DEFINE l_cnt         LIKE type_t.num5
DEFINE li_idx        LIKE type_t.num5
DEFINE l_mmaf015     LIKE mmaf_t.mmaf015
DEFINE l_mmaf013     LIKE type_t.chr50
DEFINE g_type1       LIKE type_t.chr10
DEFINE g_type2       LIKE type_t.chr10
DEFINE g_type3       LIKE type_t.chr10
DEFINE g_type4       LIKE type_t.chr10
#end add-point
 
#add-point:傳入參數說明

#end add-point
 
{</section>}
 
{<section id="ammq301.main" >}
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
 
 
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call
      
      #end add-point
 
   ELSE
      
      #畫面開啟 (identifier)
      OPEN WINDOW w_ammq301 WITH FORM cl_ap_formpath("amm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL ammq301_init()   
 
      #進入選單 Menu (="N")
      CALL ammq301_ui_dialog() 
      
      #add-point:畫面關閉前
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_ammq301
      
   END IF 
   
   
   
 
   #add-point:作業離開前
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN
 
 
 
{</section>}
 
{<section id="ammq301.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION ammq301_init()
   #add-point:init段define

   #end add-point   
   
   
   
   LET g_error_show = 1
   
   #add-point:畫面資料初始化
   CALL cl_set_combo_scc('mmaf020','6502')
   CALL cl_set_combo_scc('mmaf021','6502')
   CALL cl_set_combo_scc('mmaf022','6502')
   #CALL cl_set_combo_scc_part('mmaf023','6502','10,11,12,13,14')
   #
   #CALL cl_set_combo_scc_part('mmaf020','6502','1,2,3,4,5,6,7,8,9')
   #CALL cl_set_combo_scc_part('mmaf021','6502','1,2,3,4,5,6,7,8,9')
   #CALL cl_set_combo_scc_part('mmaf022','6502','1,2,3,4,5,6,7,8,9')
   #CALL cl_set_combo_scc_part('mmaf023','6502','10,11,12,13,14')
   CALL cl_set_combo_scc('mmaq006','6515')
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()

   #end add-point
   CALL cl_set_combo_scc('mmaf003','6501') 
   CALL ammq301_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="ammq301.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION ammq301_ui_dialog()
   DEFINE li_idx   LIKE type_t.num5
   DEFINE la_param  RECORD
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   #add-point:ui_dialog段define
   
   #end add-point 
 
   LET g_action_choice = " "  
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()      
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   LET g_detail_idx = 1
   
   #add-point:ui_dialog段before dialog 
   CALL ammq301_mmaf024_scc()
   CALL ammq301_mmaf025_scc()
   CALL ammq301_mmaf026_scc()
   CALL ammq301_mmaf027_scc()
   CALL ammq301_mmaf028_scc() 
   #end add-point
   
   WHILE TRUE
   
      #CALL ammq301_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_mmaf_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               CALL FGL_SET_ARR_CURR(g_detail_idx)
      
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               LET g_temp_idx = l_ac
               IF l_ac>0 THEN
                  CALL ammq301_b_fill2()
               END IF
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL cl_show_fld_cont() 
               
            #自訂ACTION(detail_show,page_1)
            ON ACTION selall
               CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
               FOR li_idx = 1 TO g_mmaf_d.getLength()
                  LET g_mmaf_d[li_idx].sel = "Y"
               END FOR
 
 
            #取消全部
            ON ACTION selnone
               CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
               FOR li_idx = 1 TO g_mmaf_d.getLength()
                  LET g_mmaf_d[li_idx].sel = "N"
               END FOR
 
 
 
            #勾選所選資料
            ON ACTION sel
               FOR li_idx = 1 TO g_mmaf_d.getLength()
                  IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                     LET g_mmaf_d[li_idx].sel = "Y"
                  END IF
               END FOR
 
         #取消所選資料
            ON ACTION unsel
               FOR li_idx = 1 TO g_mmaf_d.getLength()
                  IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                     LET g_mmaf_d[li_idx].sel = "N"
                  END IF
               END FOR
               
         END DISPLAY
      
 
      
         #add-point:ui_dialog段自定義display array
            DISPLAY ARRAY g_mmaq_d TO s_detail2.* ATTRIBUTE(COUNT=g_rec_b)
            
               BEFORE ROW
                  #回歸舊筆數位置 (回到當時異動的筆數)
                  LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
                  LET l_ac = g_detail_idx
                  LET g_temp_idx = l_ac
               
                  DISPLAY g_detail_idx TO FORMONLY.idx2
                  CALL cl_show_fld_cont()      
                       
                  
               
            
            END DISPLAY
                                                 
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

            #end add-point
            NEXT FIELD CURRENT
      
         
 
         ON ACTION query
 
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN 
               CALL ammq301_query()
               #add-point:ON ACTION query
               EXIT DIALOG 
            END IF    
        ON ACTION modify_detail
 
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify_detail") THEN 
               CALL ammq301_modify_input()
               #add-point:ON ACTION query
               
               #END add-point
            END IF   
        ON ACTION query_c
 
            LET g_action_choice="query_c"
            IF cl_auth_chk_act("query_c") THEN 
               LET l_cnt=1
               FOR i = 1 TO g_mmaf_d.getLength()
                  
                  IF g_mmaf_d[i].sel='Y' THEN
                     IF l_cnt=1 THEN
                        LET g_wc = g_wc,"'",g_mmaf_d[i].mmaf001,"'"
                     ELSE
                        LET g_wc = g_wc,",'",g_mmaf_d[i].mmaf001,"'"
                     END IF
                     LET l_cnt=l_cnt+1                     
                  END IF
               END FOR
               LET l_cmd = "ammq300 ",g_wc  
               CALL cl_cmdrun(l_cmd)               
            END IF   
        ON ACTION query_insert
 
            LET g_action_choice="query_insert"
            IF cl_auth_chk_act("query_insert") THEN 
               
               #add-point:ON ACTION query
               LET l_cmd = "ammt300 '",g_mmaf_d[l_ac].mmaf001,"' 'insert'"
#               let l_cmd = "artt406 '301-J07-140328000001'"               
               CALL cl_cmdrun(l_cmd) 
           end if  
         ON ACTION exporttoexcel
             LET g_action_choice="exporttoexcel"
             IF cl_auth_chk_act("exporttoexcel") THEN
                CALL g_export_node.clear()
                LET g_export_node[1] = base.typeInfo.create(g_mmaf_d)
                LET g_export_id[1]   = "s_detail1"
                LET g_export_node[2] = base.typeInfo.create(g_mmaq_d)
                LET g_export_id[2]   = "s_detail2"
             
             
                #add-point:ON ACTION exporttoexcel
             
                #END add-point
                CALL cl_export_to_excel_getpage()
                CALL cl_export_to_excel()
            END IF   
        
            
         ON ACTION modify
 
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN 
               CALL ammq301_modify_input()
               #add-point:ON ACTION query
                 
               #END add-point
            END IF
 
 
         ON ACTION datainfo
 
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN 
               #add-point:ON ACTION datainfo

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
 
{<section id="ammq301.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION ammq301_query()
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define
   LET g_wc2=" 1=1"
   
   #end add-point 
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_mmaf_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
       
 
         
      
         
      
         #---------------------<  Detail: page1  >---------------------
         #----<<sel>>----
         #----<<mmaf008>>----
         #----<<mmaf009>>----
         #----<<mmaf001>>----
         #----<<mmaf015>>----
         #----<<mmaf013>>----
         #----<<mmaf014>>----
         #----<<mmaf004>>----
  
         
 
      
         
            #add-point:cs段more_construct
            
            #end add-point 
      
      
  
      #add-point:query段more_construct

      INPUT l_mmaf0001 FROM mmaf020
         AFTER FIELD mmaf020
            LET g_type1 = FGL_DIALOG_GETBUFFER()
      END INPUT
      CONSTRUCT g_wc3 ON mmaf013
           FROM mmaf013
         
#         AFTER FIELD mmaf013
#            IF l_mmaf0001='4' THEN
#               CASE FGL_DIALOG_GETFIELDNAME()  #取得目前所在的欄位名稱
#                  WHEN "mmaf013"      #
#                     LET l_mmaf013 = FGL_DIALOG_GETBUFFER()  #取得目前欄位的內容
#                     SELECT to_date(l_mmaf013,"YYYY/MM/DD") INTO l_mmaf015 FROM dual
#                     IF sqlca.sqlcode THEN
#                        CALL cl_err(l_mmaf013,"acr-00025",1)
#                        NEXT FIELD mmaf013
#                     END IF
#               END CASE      
#            END IF
#         ON ACTION controlp INFIELD mmaf013
#            INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'c'
#			   LET g_qryparam.reqry = FALSE
#            IF l_mmaf0001='3' THEN
#               CALL q_mmaf004()
#            END IF
#            IF l_mmaf0001='5' THEN
#               CALL q_mmaq001_2()
#            END IF
#            IF l_mmaf0001='6' THEN
#               CALL q_mmaf001()
#            END IF
#            DISPLAY g_qryparam.return1 TO mmaf013  #顯示到畫面上
#
#            NEXT FIELD mmaf013
                    
      END CONSTRUCT 
      INPUT l_mmaf0002 FROM mmaf021
         AFTER FIELD mmaf021
            LET g_type2 = FGL_DIALOG_GETBUFFER()
      END INPUT
      CONSTRUCT g_wc4 ON mmaf013
           FROM mmaf0132
           
#         AFTER FIELD mmaf0132
#            IF l_mmaf0002='4' THEN
#               CASE FGL_DIALOG_GETFIELDNAME()  #取得目前所在的欄位名稱
#                  WHEN "mmaf0132"      #
#                     LET l_mmaf013 = FGL_DIALOG_GETBUFFER()  #取得目前欄位的內容
#                     SELECT to_date(l_mmaf013,"YYYY/MM/DD") INTO l_mmaf015 FROM dual
#                     IF sqlca.sqlcode THEN
#                        CALL cl_err(l_mmaf013,"acr-00025",1)
#                        NEXT FIELD mmaf0132
#                     END IF
#               END CASE      
#            END IF  
#         ON ACTION controlp INFIELD mmaf0132
#            INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'c'
#			   LET g_qryparam.reqry = FALSE
#            IF l_mmaf0002='3' THEN
#               CALL q_mmaf004()
#            END IF
#            IF l_mmaf0002='5' THEN
#               CALL q_mmaq001_2()
#            END IF
#            IF l_mmaf0002='6' THEN
#               CALL q_mmaf001()
#            END IF
#            DISPLAY g_qryparam.return1 TO mmaf0132  #顯示到畫面上
#
#            NEXT FIELD mmaf0132  
      END CONSTRUCT 
      INPUT l_mmaf0003 FROM mmaf022
         AFTER FIELD mmaf022
            LET g_type3 = FGL_DIALOG_GETBUFFER()  
      END INPUT
      CONSTRUCT g_wc5 ON mmaf013
           FROM mmaf0133
         
#         AFTER FIELD mmaf0133
#            IF l_mmaf0003='4' THEN
#               CASE FGL_DIALOG_GETFIELDNAME()  #取得目前所在的欄位名稱
#                  WHEN "mmaf0133"      #
#                     LET l_mmaf013 = FGL_DIALOG_GETBUFFER()  #取得目前欄位的內容
#                     SELECT to_date(l_mmaf013,"YYYY/MM/DD") INTO l_mmaf015 FROM dual
#                     IF sqlca.sqlcode THEN
#                        CALL cl_err(l_mmaf013,"acr-00025",1)
#                        NEXT FIELD mmaf0133
#                     END IF
#               END CASE      
#            END IF         
#         ON ACTION controlp INFIELD mmaf0133
#            INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'c'
#			   LET g_qryparam.reqry = FALSE
#            IF l_mmaf0003='3' THEN
#               CALL q_mmaf004()
#            END IF
#            IF l_mmaf0003='5' THEN
#               CALL q_mmaq001_2()
#            END IF
#            IF l_mmaf0003='6' THEN
#               CALL q_mmaf001()
#            END IF
#            DISPLAY g_qryparam.return1 TO mmaf0133  #顯示到畫面上
#
#            NEXT FIELD mmaf0133  
      END CONSTRUCT 

#       INPUT l_mmaf0004 FROM mmaf023
#         AFTER FIELD mmaf023
#            LET g_type4 = FGL_DIALOG_GETBUFFER()  
#      END INPUT
#      CONSTRUCT g_wc6 ON mmaf013
#           FROM mmaf0134
#      END CONSTRUCT
      #end add-point 
  
      BEFORE DIALOG 
         CALL cl_qbe_init()
         #add-point:query段before_dialog
         LET l_mmaf0001 = g_type1
         LET l_mmaf0002 = g_type2
         LET l_mmaf0003 = g_type3
         DISPLAY g_type1,g_type2,g_type3 TO mmaf020,mmaf021,mmaf022
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
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
   IF cl_null(g_wc3) THEN
      LET g_wc3 = " 1=1"
   END IF
   IF cl_null(g_wc4) THEN
      LET g_wc4 = " 1=1"
   END IF
   IF cl_null(g_wc5) THEN
      LET g_wc5 = " 1=1"
   END IF
   IF l_mmaf0001='2' THEN
      LET g_wc3 = cl_replace_str(g_wc3,"mmaf013","mmaf014")
   END IF
   IF l_mmaf0001='3' THEN
      LET g_wc3 = cl_replace_str(g_wc3,"mmaf013","mmaf004")
   END IF
   IF l_mmaf0001='4' THEN
      LET g_wc3 = cl_replace_str(g_wc3,"mmaf013","mmaf015")
   END IF
   IF l_mmaf0001='5' THEN
      LET g_wc3 = cl_replace_str(g_wc3,"mmaf013","mmaq001")
   END IF
   IF l_mmaf0001='6' THEN
      LET g_wc3 = cl_replace_str(g_wc3,"mmaf013","mmaf001")
   END IF
   IF l_mmaf0001='7' THEN
      LET g_wc3 = cl_replace_str(g_wc3,"mmaf013","mmaf008")
   END IF
   ##add by zn --str
   IF l_mmaf0001='8' THEN
      LET g_wc3 = cl_replace_str(g_wc3,"mmaf013","mmaf019")
   END IF
   IF l_mmaf0001='9' THEN
      LET g_wc3 = cl_replace_str(g_wc3,"mmaf013","mmafcrtdt")
   END IF
   IF l_mmaf0001='10' THEN
      LET g_wc3 = cl_replace_str(g_wc3,"mmaf013","mmaf024")
   END IF
   IF l_mmaf0001='11' THEN
      LET g_wc3 = cl_replace_str(g_wc3,"mmaf013","mmaf025")
   END IF
   IF l_mmaf0001='12' THEN
      LET g_wc3 = cl_replace_str(g_wc3,"mmaf013","mmaf026")
   END IF
   IF l_mmaf0001='13' THEN
      LET g_wc3 = cl_replace_str(g_wc3,"mmaf013","mmaf027")
   END IF
   IF l_mmaf0001='14' THEN
      LET g_wc3 = cl_replace_str(g_wc3,"mmaf013","mmaf028")
   END IF
   ##add by zn --end--
   IF l_mmaf0002='2' THEN
      LET g_wc4 = cl_replace_str(g_wc4,"mmaf013","mmaf014")
   END IF
   IF l_mmaf0002='3' THEN
      LET g_wc4 = cl_replace_str(g_wc4,"mmaf013","mmaf004")
   END IF
   IF l_mmaf0002='4' THEN
      LET g_wc4 = cl_replace_str(g_wc4,"mmaf013","mmaf015")
   END IF
   IF l_mmaf0002='5' THEN
      LET g_wc4 = cl_replace_str(g_wc4,"mmaf013","mmaq001")
   END IF
   IF l_mmaf0002='6' THEN
      LET g_wc4 = cl_replace_str(g_wc4,"mmaf013","mmaf001")
   END IF
   IF l_mmaf0002='7' THEN
      LET g_wc4 = cl_replace_str(g_wc4,"mmaf013","mmaf008")
   END IF
      ##add by zn --str
   IF l_mmaf0002='8' THEN
      LET g_wc4 = cl_replace_str(g_wc4,"mmaf013","mmaf019")
   END IF
   IF l_mmaf0002='9' THEN
      LET g_wc4 = cl_replace_str(g_wc4,"mmaf013","mmafcrtdt")
   END IF
   IF l_mmaf0002='10' THEN
      LET g_wc4 = cl_replace_str(g_wc4,"mmaf013","mmaf024")
   END IF
   IF l_mmaf0002='11' THEN
      LET g_wc4 = cl_replace_str(g_wc4,"mmaf013","mmaf025")
   END IF
   IF l_mmaf0002='12' THEN
      LET g_wc4 = cl_replace_str(g_wc4,"mmaf013","mmaf026")
   END IF
   IF l_mmaf0002='13' THEN
      LET g_wc4 = cl_replace_str(g_wc4,"mmaf013","mmaf027")
   END IF
   IF l_mmaf0002='14' THEN
      LET g_wc4 = cl_replace_str(g_wc4,"mmaf013","mmaf028")
   END IF
   ##add by zn --end--
   IF l_mmaf0003='2' THEN
      LET g_wc5 = cl_replace_str(g_wc5,"mmaf013","mmaf014")
   END IF
   IF l_mmaf0003='3' THEN
      LET g_wc5 = cl_replace_str(g_wc5,"mmaf013","mmaf004")
   END IF
   IF l_mmaf0003='4' THEN
      LET g_wc5 = cl_replace_str(g_wc5,"mmaf013","mmaf015")
   END IF
   IF l_mmaf0003='5' THEN
      LET g_wc5 = cl_replace_str(g_wc5,"mmaf013","mmaq001")
   END IF
   IF l_mmaf0003='6' THEN
      LET g_wc5 = cl_replace_str(g_wc5,"mmaf013","mmaf001")
   END IF
   IF l_mmaf0003='7' THEN
      LET g_wc5 = cl_replace_str(g_wc5,"mmaf013","mmaf008")
   END IF
      ##add by zn --str
   IF l_mmaf0003='8' THEN
      LET g_wc5 = cl_replace_str(g_wc5,"mmaf013","mmaf019")
   END IF
   IF l_mmaf0003='9' THEN
      LET g_wc5 = cl_replace_str(g_wc5,"mmaf013","mmafcrtdt")
   END IF
   IF l_mmaf0003='10' THEN
      LET g_wc5 = cl_replace_str(g_wc5,"mmaf013","mmaf024")
   END IF
   IF l_mmaf0003='11' THEN
      LET g_wc5 = cl_replace_str(g_wc5,"mmaf013","mmaf025")
   END IF
   IF l_mmaf0003='12' THEN
      LET g_wc5 = cl_replace_str(g_wc5,"mmaf013","mmaf026")
   END IF
   IF l_mmaf0003='13' THEN
      LET g_wc5 = cl_replace_str(g_wc5,"mmaf013","mmaf027")
   END IF
   IF l_mmaf0003='14' THEN
      LET g_wc5 = cl_replace_str(g_wc5,"mmaf013","mmaf028")
   END IF
   ##add by zn --end--
   LET g_wc2 = g_wc2," AND ",g_wc3," AND ",g_wc4," AND ",g_wc5
   #end add-point
   
   #LET g_wc2 = g_wc2 CLIPPED, cl_get_extra_cond("", "")
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      LET g_wc2 = ls_wc
   END IF
 
   LET g_error_show = 1
   CALL ammq301_b_fill(g_wc2)
   
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = -100
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
 
   END IF
   
   LET INT_FLAG = FALSE
   
END FUNCTION
 
{</section>}
 
{<section id="ammq301.insert" >}
#+ 資料新增
PRIVATE FUNCTION ammq301_insert()
   DEFINE li_ac LIKE type_t.num5
   DEFINE l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE l_vars          DYNAMIC ARRAY OF STRING
   DEFINE l_fields        DYNAMIC ARRAY OF STRING
   #add-point:delete段define
   
   #end add-point 
   
   #輸入前動作  
   LET li_ac = l_ac 
   LET l_ac = 1   
   LET g_before_input_done = FALSE                                        
   CALL ammq301_set_entry_b("a")  
   
   CALL ammq301_set_no_entry_b("a")                                          
   LET g_before_input_done = TRUE                                            
   
   #append欄位         
      
 
 
   
   #add-point:insert段before insert
   
   #end add-point  
 
   #資料輸入
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM) 
      INPUT g_mmaf_d[1].* FROM s_detail1[1].*
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
   
   #end add-point
   
   
   #add-point:單身新增後
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="ammq301.modify" >}
#+ 資料修改
PRIVATE FUNCTION ammq301_modify()
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
   
   #end add-point 
   
   LET g_action_choice = ""
   
   LET g_qryparam.state = "i"
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
 
   #add-point:modify段define_sql
   
   #end add-point 
   LET g_forupd_sql = "SELECT '',mmaf008,mmaf009,mmaf001,mmaf015,mmaf013,mmaf014,mmaf004 FROM mmaf_t  
       WHERE mmafent=? AND mmaf001=? FOR UPDATE"
   #add-point:modify段define_sql
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE ammq301_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
   
 
   
   LET INT_FLAG = FALSE
   LET lb_reproduce = FALSE
 
   #add-point:modify段修改前
   
   #end add-point
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #Page1 預設值產生於此處
      INPUT ARRAY g_mmaf_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mmaf_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL ammq301_b_fill(g_wc2)
            LET g_detail_cnt = g_mmaf_d.getLength()
         
         BEFORE ROW
            #add-point:modify段before row
            
            #end add-point  
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            DISPLAY g_mmaf_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_mmaf_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_mmaf_d[l_ac].mmaf001 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_mmaf_d_t.* = g_mmaf_d[l_ac].*  #BACKUP
               IF NOT ammq301_lock_b("mmaf_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH ammq301_bcl INTO g_mmaf_d[l_ac].sel,g_mmaf_d[l_ac].mmaf008,g_mmaf_d[l_ac].mmaf009, 
                      g_mmaf_d[l_ac].mmaf001,g_mmaf_d[l_ac].mmaf015,g_mmaf_d[l_ac].mmaf013,g_mmaf_d[l_ac].mmaf014, 
                      g_mmaf_d[l_ac].mmaf004
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = g_mmaf_d_t.mmaf001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     LET l_lock_sw = "Y"
                  END IF
                  
                  CALL ammq301_detail_show()
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
            INITIALIZE g_mmaf_d_t.* TO NULL
            INITIALIZE g_mmaf_d[l_ac].* TO NULL 
                  LET g_mmaf_d[l_ac].sel = "N"
 
 
            LET g_mmaf_d_t.* = g_mmaf_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL ammq301_set_entry_b("a")
            CALL ammq301_set_no_entry_b("a")
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mmaf_d[li_reproduce_target].* = g_mmaf_d[li_reproduce].*
 
               LET g_mmaf_d[g_mmaf_d.getLength()].mmaf001 = NULL
 
            END IF
            #公用欄位給值(單身)
            
            
            #add-point:modify段before insert
            
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
            SELECT COUNT(*) INTO l_count FROM mmaf_t 
             WHERE mmafent = g_enterprise AND mmaf001 = g_mmaf_d[l_ac].mmaf001
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmaf_d[g_detail_idx].mmaf001
               CALL ammq301_insert_b('mmaf_t',gs_keys,"'1'")
                           
               #add-point:單身新增後
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               INITIALIZE g_mmaf_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "mmaf_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL ammq301_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert
               
               #end add-point
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (mmaf001 = '", g_mmaf_d[l_ac].mmaf001, "' "
 
                                  ,")"
            END IF                
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' AND g_mmaf_d.getLength() < l_ac THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_mmaf_d.deleteElement(l_ac)
               NEXT FIELD mmaf001
            END IF
            IF g_mmaf_d[l_ac].mmaf001 IS NOT NULL
 
               THEN     
            
               #add-point:單身刪除ask前
               
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
               
               #add-point:單身刪除前
               
               #end add-point   
               
               DELETE FROM mmaf_t
                WHERE mmafent = g_enterprise AND 
                      mmaf001 = g_mmaf_d_t.mmaf001
 
                      
               #add-point:單身刪除中
               
               #end add-point  
                      
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "mmaf_t"
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
               CLOSE ammq301_bcl
               LET l_count = g_mmaf_d.getLength()
            END IF 
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmaf_d[g_detail_idx].mmaf001
 
              
         AFTER DELETE 
            #add-point:單身刪除後2
            
            #end add-point
                           CALL ammq301_delete_b('mmaf_t',gs_keys,"'1'")
 
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
 
         #----<<mmaf008>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmaf008
            #add-point:BEFORE FIELD mmaf008
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmaf008
            
            #add-point:AFTER FIELD mmaf008
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmaf008
            #add-point:ON CHANGE mmaf008
            
            #END add-point
 
         #----<<mmaf009>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmaf009
            #add-point:BEFORE FIELD mmaf009
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmaf009
            
            #add-point:AFTER FIELD mmaf009
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmaf009
            #add-point:ON CHANGE mmaf009
            
            #END add-point
 
         #----<<mmaf001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmaf001
            #add-point:BEFORE FIELD mmaf001
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmaf001
            
            #add-point:AFTER FIELD mmaf001
            #此段落由子樣板a05產生
            IF  g_mmaf_d[g_detail_idx].mmaf001 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mmaf_d[g_detail_idx].mmaf001 != g_mmaf_d_t.mmaf001)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmaf_t WHERE "||"mmafent = '" ||g_enterprise|| "' AND "||"mmaf001 = '"||g_mmaf_d[g_detail_idx].mmaf001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmaf001
            #add-point:ON CHANGE mmaf001
            
            #END add-point
 
         #----<<mmaf015>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmaf015
            #add-point:BEFORE FIELD mmaf015
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmaf015
            
            #add-point:AFTER FIELD mmaf015
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmaf015
            #add-point:ON CHANGE mmaf015
            
            #END add-point
 
         #----<<mmaf013>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmaf013
            #add-point:BEFORE FIELD mmaf013
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmaf013
            
            #add-point:AFTER FIELD mmaf013
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmaf013
            #add-point:ON CHANGE mmaf013
            
            #END add-point
 
         #----<<mmaf014>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmaf014
            #add-point:BEFORE FIELD mmaf014
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmaf014
            
            #add-point:AFTER FIELD mmaf014
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmaf014
            #add-point:ON CHANGE mmaf014
            
            #END add-point
 
         #----<<mmaf004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmaf004
            #add-point:BEFORE FIELD mmaf004
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmaf004
            
            #add-point:AFTER FIELD mmaf004
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmaf004
            #add-point:ON CHANGE mmaf004
            
            #END add-point
 
 
         #---------------------<  Detail: page1  >---------------------
         #----<<sel>>----
         #Ctrlp:input.c.page1.sel
         ON ACTION controlp INFIELD sel
            #add-point:ON ACTION controlp INFIELD sel
            
            #END add-point
 
         #----<<mmaf008>>----
         #Ctrlp:input.c.page1.mmaf008
         ON ACTION controlp INFIELD mmaf008
            #add-point:ON ACTION controlp INFIELD mmaf008
            
            #END add-point
 
         #----<<mmaf009>>----
         #Ctrlp:input.c.page1.mmaf009
         ON ACTION controlp INFIELD mmaf009
            #add-point:ON ACTION controlp INFIELD mmaf009
            
            #END add-point
 
         #----<<mmaf001>>----
         #Ctrlp:input.c.page1.mmaf001
         ON ACTION controlp INFIELD mmaf001
            #add-point:ON ACTION controlp INFIELD mmaf001
            
            #END add-point
 
         #----<<mmaf015>>----
         #Ctrlp:input.c.page1.mmaf015
         ON ACTION controlp INFIELD mmaf015
            #add-point:ON ACTION controlp INFIELD mmaf015
            
            #END add-point
 
         #----<<mmaf013>>----
         #Ctrlp:input.c.page1.mmaf013
         ON ACTION controlp INFIELD mmaf013
            #add-point:ON ACTION controlp INFIELD mmaf013
            
            #END add-point
 
         #----<<mmaf014>>----
         #Ctrlp:input.c.page1.mmaf014
         ON ACTION controlp INFIELD mmaf014
            #add-point:ON ACTION controlp INFIELD mmaf014
            
            #END add-point
 
         #----<<mmaf004>>----
         #Ctrlp:input.c.page1.mmaf004
         ON ACTION controlp INFIELD mmaf004
            #add-point:ON ACTION controlp INFIELD mmaf004
            
            #END add-point
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
 
               LET INT_FLAG = 0
               LET g_mmaf_d[l_ac].* = g_mmaf_d_t.*
               CLOSE ammq301_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_mmaf_d[l_ac].mmaf001
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               LET g_mmaf_d[l_ac].* = g_mmaf_d_t.*
            ELSE
               
               #寫入修改者/修改日期資訊(單身)
               
            
               #add-point:單身修改前
               
               #end add-point
               
               UPDATE mmaf_t SET (mmaf008,mmaf009,mmaf001,mmaf015,mmaf013,mmaf014,mmaf004) = (g_mmaf_d[l_ac].mmaf008, 
                   g_mmaf_d[l_ac].mmaf009,g_mmaf_d[l_ac].mmaf001,g_mmaf_d[l_ac].mmaf015,g_mmaf_d[l_ac].mmaf013, 
                   g_mmaf_d[l_ac].mmaf014,g_mmaf_d[l_ac].mmaf004)
                WHERE mmafent = g_enterprise AND
                  mmaf001 = g_mmaf_d_t.mmaf001 #項次   
 
                  
               #add-point:單身修改中
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "mmaf_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                    WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "mmaf_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
                     CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmaf_d[g_detail_idx].mmaf001
               LET gs_keys_bak[1] = g_mmaf_d_t.mmaf001
               CALL ammq301_update_b('mmaf_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
               END CASE
               
               #add-point:單身修改後
               
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL ammq301_unlock_b("mmaf_t")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            
             #add-point:單身after row
            
            #end add-point
            
         AFTER INPUT
            #add-point:單身input後
            
            #end add-point
            
         ON ACTION controlo   
            CALL FGL_SET_ARR_CURR(g_mmaf_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_mmaf_d.getLength()+1
            
      END INPUT
      
 
      
 
      
      #add-point:before_more_input
      
      #end add-point
      
      BEFORE DIALOG 
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
               NEXT FIELD sel
 
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
 
   CLOSE ammq301_bcl
   CALL s_transaction_end('Y','0')
   
END FUNCTION
 
{</section>}
 
{<section id="ammq301.delete" >}
#+ 資料刪除
PRIVATE FUNCTION ammq301_delete()
   DEFINE li_ac LIKE type_t.num5
   #add-point:delete段define
   
   #end add-point 
   
   IF NOT cl_ask_delete() THEN
      LET INT_FLAG = 1 #不刪除
   ELSE
      LET INT_FLAG = 0 #要刪除
   END IF
   
   LET li_ac = ARR_CURR()
   
   CALL s_transaction_begin()  
 
   #add-point:delete段刪除前
   
   #end add-point 
   DELETE FROM mmaf_t 
         WHERE mmaf001 = g_mmaf_d[li_ac].mmaf001
 
   #add-point:delete段刪除中
   AND mmafent = g_enterprise #160905-00007#6 add
   #end add-point 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "mmaf_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
 
      CALL s_transaction_end('N','0')
   ELSE
      CALL s_transaction_end('Y','0')
   END IF
   #add-point:delete段刪除後
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="ammq301.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION ammq301_b_fill(p_wc2)              #BODY FILL UP
   DEFINE p_wc2           STRING
   #add-point:b_fill段define
   CALL g_mmaq_d.clear()
   #end add-point
   
   IF cl_null(p_wc2) THEN
      LET p_wc2 = " 1=1"
   END IF
   
   #add-point:b_fill段sql之前

   #end add-point
 
   LET g_sql = "SELECT  UNIQUE '',mmaf008,mmaf009,mmaf001,mmaf015,mmaf013,mmaf014,mmaf004 FROM mmaf_t", 
 
               "",
               " WHERE mmafent= ? AND 1=1 AND ", p_wc2 
    
   LET g_sql = g_sql, #,cl_get_extra_cond('zzuser', 'zzgrup') 
                      " ORDER BY mmaf_t.mmaf001"
  
   #add-point:b_fill段sql之後
   LET g_sql = "SELECT  UNIQUE '',mmaf008,mmaf009,mmaf001,mmaf015,mmaf013,mmaf014,mmaf003,mmaf004, ",
               " mmaf012,mmaf021,t3.oocql004,mmafunit,t1.ooefl003,mmaf019,t2.ooag011,mmafcrtdt,mmaf024,mmaf025,mmaf026,mmaf027,mmaf028,mmaf011",   
               " FROM mmaf_t", 
               " LEFT JOIN mmaq_t ON mmaq003=mmaf001 AND mmaqent=mmafent ",
               " LEFT JOIN ooefl_t t1 ON t1.ooeflent='"||g_enterprise||"' AND t1.ooefl001=mmafunit AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent='"||g_enterprise||"' AND t2.ooag001=mmaf019  ",
                " LEFT JOIN oocql_t t3 ON t3.oocqlent='"||g_enterprise||"' AND t3.oocql001='2112' AND t3.oocql002=mmaf021 AND t3.oocql003='"||g_dlang||"' ",
               " WHERE mmafent= ? AND 1=1 AND ", p_wc2
    
   LET g_sql = g_sql, " ORDER BY mmaf_t.mmaf001"
   #end add-point
  
   PREPARE ammq301_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR ammq301_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_mmaf_d.clear()
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_mmaf_d[l_ac].sel,g_mmaf_d[l_ac].mmaf008,g_mmaf_d[l_ac].mmaf009,g_mmaf_d[l_ac].mmaf001, 
       g_mmaf_d[l_ac].mmaf015,g_mmaf_d[l_ac].mmaf013,g_mmaf_d[l_ac].mmaf014,g_mmaf_d[l_ac].mmaf003,g_mmaf_d[l_ac].mmaf004,
       g_mmaf_d[l_ac].mmaf012,g_mmaf_d[l_ac].mmaf021,g_mmaf_d[l_ac].mmaf021_desc,g_mmaf_d[l_ac].mmafunit,g_mmaf_d[l_ac].mmafunit_desc,
       g_mmaf_d[l_ac].mmaf019,g_mmaf_d[l_ac].mmaf019_desc,g_mmaf_d[l_ac].mmafcrtdt, 
       g_mmaf_d[l_ac].mmaf024,g_mmaf_d[l_ac].mmaf025,g_mmaf_d[l_ac].mmaf026,g_mmaf_d[l_ac].mmaf027,g_mmaf_d[l_ac].mmaf028,
       g_mmaf_d[l_ac].mmaf011
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充
      LET g_mmaf_d[l_ac].sel='N'
      #end add-point
      
      CALL ammq301_detail_show()      
 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
      
   END FOREACH
   
   IF l_ac > g_max_rec THEN
      IF g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9035
         LET g_errparam.extend = "mmaf_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
      END IF
   END IF 
   LET g_error_show = 0
   
 
  
   
   CALL g_mmaf_d.deleteElement(g_mmaf_d.getLength())   
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_mmaf_d.getLength()
 
   END FOR
   
   #add-point:b_fill段資料填充(其他單身)
 
   #end add-point
 
   LET g_detail_cnt = l_ac - 1
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE ammq301_pb
   
END FUNCTION
 
{</section>}
 
{<section id="ammq301.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION ammq301_detail_show()
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
 
{<section id="ammq301.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION ammq301_set_entry_b(p_cmd)                                                  
   DEFINE p_cmd   LIKE type_t.chr1         
   #add-point:set_entry_b段define
   
   #end add-point     
   
   #add-point:set_entry_b段control
   
   #end add-point                                                                   
                                                                                
END FUNCTION                                                                    
 
{</section>}
 
{<section id="ammq301.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION ammq301_set_no_entry_b(p_cmd)                                               
   DEFINE p_cmd   LIKE type_t.chr1           
   #add-point:set_no_entry_b段define
   
   #end add-point  
 
   #add-point:set_no_entry_b段control
   
   #end add-point       
                                                                                
END FUNCTION  
 
{</section>}
 
{<section id="ammq301.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION ammq301_default_search()
   DEFINE li_idx  LIKE type_t.num5
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE ls_wc   STRING
   #add-point:default_search段define
   
   #end add-point  
   
   IF NOT cl_null(g_argv[1]) THEN
      LET ls_wc = ls_wc, " mmaf001 = '", g_argv[1], "' AND "
   END IF
   
 
   
   IF NOT cl_null(ls_wc) THEN
      LET ls_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_wc2 = ls_wc
   ELSE
      LET g_wc2 = " 1=1"
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="ammq301.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION ammq301_delete_b(ps_table,ps_keys_bak,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:delete_b段define
   
   #end add-point     
 
   #判斷是否是同一群組的table
   LET ls_group = "mmaf_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
   
      #add-point:delete_b段刪除前
      
      #end add-point     
   
      DELETE FROM mmaf_t
       WHERE mmafent = g_enterprise AND
         mmaf001 = ps_keys_bak[1]
 
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
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="ammq301.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION ammq301_insert_b(ps_table,ps_keys,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:insert_b段define
   
   #end add-point     
 
   #判斷是否是同一群組的table
   LET ls_group = "mmaf_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前
      
      #end add-point    
      INSERT INTO mmaf_t
                  (mmafent,
                   mmaf001
                   ,mmaf008,mmaf009,mmaf015,mmaf013,mmaf014,mmaf004) 
            VALUES(g_enterprise,
                   ps_keys[1]
                   ,g_mmaf_d[l_ac].mmaf008,g_mmaf_d[l_ac].mmaf009,g_mmaf_d[l_ac].mmaf015,g_mmaf_d[l_ac].mmaf013, 
                       g_mmaf_d[l_ac].mmaf014,g_mmaf_d[l_ac].mmaf004)
      #add-point:insert_b段新增中
      
      #end add-point    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "mmaf_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
      END IF
      #add-point:insert_b段新增後
      
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="ammq301.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION ammq301_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "mmaf_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "mmaf_t" THEN
      #add-point:update_b段修改前
      
      #end add-point     
      UPDATE mmaf_t 
         SET (mmaf001
              ,mmaf008,mmaf009,mmaf015,mmaf013,mmaf014,mmaf004) 
              = 
             (ps_keys[1]
              ,g_mmaf_d[l_ac].mmaf008,g_mmaf_d[l_ac].mmaf009,g_mmaf_d[l_ac].mmaf015,g_mmaf_d[l_ac].mmaf013, 
                  g_mmaf_d[l_ac].mmaf014,g_mmaf_d[l_ac].mmaf004) 
         WHERE mmaf001 = ps_keys_bak[1]
      #add-point:update_b段修改中
      AND mmafent = g_enterprise #160905-00007#6 add
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "std-00009"
            LET g_errparam.extend = "mmaf_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
 
            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "mmaf_t"
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
 
{<section id="ammq301.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION ammq301_lock_b(ps_table)
 
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define
   
   #end add-point   
   
   #先刷新資料
   #CALL ammq301_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "mmaf_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN ammq301_bcl USING g_enterprise,
                                       g_mmaf_d[g_detail_idx].mmaf001
                                       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ammq301_bcl"
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="ammq301.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION ammq301_unlock_b(ps_table)
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:unlock_b段define
   
   #end add-point  
   
   LET ls_group = ""
   
   #IF ls_group.getIndexOf(ps_table,1) THEN
      CLOSE ammq301_bcl
   #END IF
   
 
 
END FUNCTION
 
{</section>}
 
{<section id="ammq301.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION ammq301_modify_detail_chk(ps_record)
   DEFINE ps_record STRING
   DEFINE ls_return STRING
   #add-point:modify_detail_chk段define
   
   #end add-point
   
   #add-point:modify_detail_chk段開始前
   
   #end add-point
   
   CASE ps_record
      WHEN "s_detail1" 
         LET ls_return = "sel"
 
      #add-point:modify_detail_chk段自訂page控制
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="ammq301.state_change" >}
   
 
{</section>}
 
{<section id="ammq301.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="ammq301.other_function" readonly="Y" >}

#chk mmaf020
PRIVATE FUNCTION ammq301_chk_mmaf020(p_mmaf0001)
   define p_mmaf0001   like type_t.chr1
   IF p_mmaf0001='1' THEN
      CALL cl_set_comp_visible("mmaf014,mmaf015,mmaf004,mmaq001,mmaf001,mmaf008",FALSE)
      CALL cl_set_comp_visible("mmaf013",true)
   END IF
   IF p_mmaf0001='2' THEN
      CALL cl_set_comp_visible("mmaf013,mmaf015,mmaf004,mmaq001,mmaf001,mmaf008",FALSE)
      CALL cl_set_comp_visible("mmaf014",true)
   END IF
   IF p_mmaf0001='4' THEN
      CALL cl_set_comp_visible("mmaf013,mmaf014,mmaf004,mmaq001,mmaf001,mmaf008",FALSE)
      CALL cl_set_comp_visible("mmaf015",true)
   END IF
   IF p_mmaf0001='3' THEN
      CALL cl_set_comp_visible("mmaf013,mmaf014,mmaf015,mmaq001,mmaf001,mmaf008",FALSE)
      CALL cl_set_comp_visible("mmaf004",true)
   END IF
   IF p_mmaf0001='5' THEN
      CALL cl_set_comp_visible("mmaf013,mmaf014,mmaf015,mmaf004,mmaf001,mmaf008",FALSE)
      CALL cl_set_comp_visible("mmaq001",true)
   END IF
   IF p_mmaf0001='6' THEN
      CALL cl_set_comp_visible("mmaf013,mmaf014,mmaf015,,mmaf004,mmaq001,mmaf008",FALSE)
      CALL cl_set_comp_visible("mmaf001",true)
   END IF
   IF p_mmaf0001='7' THEN
      CALL cl_set_comp_visible("mmaf013,mmaf015,mmaf014,mmaf004,mmaq001,mmaf001",FALSE)
      CALL cl_set_comp_visible("mmaf008",true)
   END IF
END FUNCTION

#chk mmaf021
PRIVATE FUNCTION ammq301_chk_mmaf021(p_mmaf0001)
   DEFINE p_mmaf0001   LIKE type_t.chr1
   IF p_mmaf0001='1' THEN
      CALL cl_set_comp_visible("mmaf0152,mmaf0142,mmaf0042,mmaq0012,mmaf0012,mmaf0082",FALSE)
      CALL cl_set_comp_visible("mmaf0132",true)
   END IF
   IF p_mmaf0001='2' THEN
      CALL cl_set_comp_visible("mmaf0132,mmaf0152,mmaf0042,mmaq0012,mmaf0012,mmaf0082",FALSE)
      CALL cl_set_comp_visible("mmaf0142",true)
   END IF
   IF p_mmaf0001='4' THEN
      CALL cl_set_comp_visible("mmaf0132,mmaf0142,mmaf0042,mmaq0012,mmaf0012,mmaf0082",FALSE)
      CALL cl_set_comp_visible("mmaf0152",true)
   END IF
   IF p_mmaf0001='3' THEN
      CALL cl_set_comp_visible("mmaf0132,mmaf0152,mmaf0142,mmaq0012,mmaf0012,mmaf0082",FALSE)
      CALL cl_set_comp_visible("mmaf0042",true)
   END IF
   IF p_mmaf0001='5' THEN
      CALL cl_set_comp_visible("mmaf0132,mmaf0152,mmaf0142,mmaf0042,mmaf0012,mmaf0082",FALSE)
      CALL cl_set_comp_visible("mmaq0012",true)
   END IF
   IF p_mmaf0001='6' THEN
      CALL cl_set_comp_visible("mmaf0132,mmaf0152,mmaf0142,mmaf0042,mmaq0012,mmaf0082",FALSE)
      CALL cl_set_comp_visible("mmaf0012",true)
   END IF
   IF p_mmaf0001='7' THEN
      CALL cl_set_comp_visible("mmaf0132,mmaf0152,mmaf0142,mmaf0042,mmaq0012,mmaf0012",FALSE)
      CALL cl_set_comp_visible("mmaf0082",true)
   END IF
END FUNCTION

#chk mmaf022
PRIVATE FUNCTION ammq301_chk_mmaf022(p_mmaf0001)
   define p_mmaf0001   like type_t.chr1
   IF p_mmaf0001='1' THEN
      CALL cl_set_comp_visible("mmaf0153,mmaf0143,mmaf0043,mmaq0013,mmaf0013,mmaf0083",FALSE)
      CALL cl_set_comp_visible("mmaf0133",true)
   END IF
   IF p_mmaf0001='2' THEN
      CALL cl_set_comp_visible("mmaf0133,mmaf0153,mmaf0043,mmaq0013,mmaf0013,mmaf0083",FALSE)
      CALL cl_set_comp_visible("mmaf0143",true)
   END IF
   IF p_mmaf0001='4' THEN
      CALL cl_set_comp_visible("mmaf0133,mmaf0143,mmaf0043,mmaq0013,mmaf0013,mmaf0083",FALSE)
      CALL cl_set_comp_visible("mmaf0153",true)
   END IF
   IF p_mmaf0001='3' THEN
      CALL cl_set_comp_visible("mmaf0133,mmaf0153,mmaf0143,mmaq0013,mmaf0013,mmaf0083",FALSE)
      CALL cl_set_comp_visible("mmaf0043",true)
   END IF
   IF p_mmaf0001='5' THEN
      CALL cl_set_comp_visible("mmaf0133,mmaf0153,mmaf0143,mmaf0043,mmaf0013,mmaf0083",FALSE)
      CALL cl_set_comp_visible("mmaq0013",true)
   END IF
   IF p_mmaf0001='6' THEN
      CALL cl_set_comp_visible("mmaf0133,mmaf0153,mmaf0143,mmaf0043,mmaq0013,mmaf0083",FALSE)
      CALL cl_set_comp_visible("mmaf0013",true)
   END IF
   IF p_mmaf0001='7' THEN
      CALL cl_set_comp_visible("mmaf0133,mmaf0153,mmaf0143,mmaf0043,mmaq0013,mmaf0013",FALSE)
      CALL cl_set_comp_visible("mmaf0083",true)
   END IF
END FUNCTION

#fill mmaq_t
PRIVATE FUNCTION ammq301_b_fill2()
 
   IF cl_null(l_ac) OR l_ac=0 THEN
      LET l_ac=1
   END IF
   CALL g_mmaq_d.clear()
 
   
   LET g_sql = "SELECT mmaq001,mmaq002,'',mmaq044,mmaq005,mmaq006 ",
               "  FROM mmaq_t ",
               " WHERE mmaqent=? AND mmaq003=?"               
                  
   
   LET g_sql = g_sql CLIPPED," ORDER BY mmaq001 "
      
   PREPARE ammq301_pb1 FROM g_sql
   DECLARE b_fill_cs1 CURSOR FOR ammq301_pb1
      
   LET g_cnt = l_ac
   LET l_ac = 1
   
   OPEN b_fill_cs1 USING g_enterprise,g_mmaf_d[g_cnt].mmaf001
   
   FOREACH b_fill_cs1 INTO g_mmaq_d[l_ac].mmaq001,g_mmaq_d[l_ac].mmaq002,g_mmaq_d[l_ac].mmaq002_desc,g_mmaq_d[l_ac].mmaq044,
      g_mmaq_d[l_ac].mmaq005,g_mmaq_d[l_ac].mmaq006   

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
        
      SELECT mmanl003 INTO  g_mmaq_d[l_ac].mmaq002_desc FROM mmanl_t
       WHERE mmanl001 =  g_mmaq_d[l_ac].mmaq002 AND mmanl002=g_dlang
         AND mmanlent = g_enterprise
         
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
         
   END FOREACH
      
   CALL g_mmaq_d.deleteElement(g_mmaq_d.getLength())
 
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt2
   DISPLAY 0 TO FORMONLY.idx2     
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   FREE ammq301_pb1
END FUNCTION

#input sel
PRIVATE FUNCTION ammq301_modify_input()
   INPUT ARRAY g_mmaf_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
      BEFORE ROW
         LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
         LET l_ac = ARR_CURR()
         IF l_ac>0 THEN
            CALL ammq301_b_fill2()
         END IF
         DISPLAY ARRAY g_mmaq_d TO s_detail2.* ATTRIBUTE(COUNT=g_rec_b)
            BEFORE DISPLAY 
               EXIT DISPLAY
         END DISPLAY
      ON CHANGE sel
               
   END INPUT               
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION ammq301_mmaf024_scc()
DEFINE l_sql       STRING
DEFINE l_oocg001   LIKE oocg_t.oocg001
DEFINE l_oocgl003  LIKE oocgl_t.oocgl003
DEFINE l_str1      STRING
DEFINE l_str2      STRING

   LET l_sql = "SELECT DISTINCT oocg001,oocgl003 ",
               "  FROM oocg_t ",
               "  LEFT JOIN oocgl_t ON oocgent = oocglent ",
               "                   AND oocg001 = oocgl001 ",
               "                   AND oocgl002 = '",g_dlang,"' ",
               " WHERE oocgstus = 'Y' ",
               "   AND oocgent = ",g_enterprise,
               " ORDER BY oocg001"

   PREPARE ammq300_mmaf024_prep FROM l_sql
   DECLARE ammq300_mmaf024_curs CURSOR FOR ammq300_mmaf024_prep
   LET l_str1 = NULL
   LET l_str2 = NULL
   FOREACH ammq300_mmaf024_curs INTO l_oocg001,l_oocgl003
      LET l_oocgl003 = l_oocg001,":",l_oocgl003
      LET l_str1 = l_str1,",",l_oocg001
      LET l_str2 = l_str2,",",l_oocgl003
   END FOREACH

   CALL cl_set_combo_items('mmaf024',l_str1,l_str2)
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION ammq301_mmaf025_scc()
DEFINE l_sql       STRING
DEFINE l_ooci002   LIKE ooci_t.ooci001
DEFINE l_oocil004  LIKE oocil_t.oocil003
DEFINE l_str1      STRING
DEFINE l_str2      STRING

   LET l_sql = " SELECT DISTINCT ooci002,oocil004 ",
               "   FROM ooci_t  ",
			      "   LEFT JOIN oocil_t ON oocient = oocilent ",
			      "                    AND ooci001 = oocil001 ",
			      "                    AND ooci002 = oocil002 ",
               "                    AND oocil003 = '",g_dlang,"' ",
               "  WHERE oocistus = 'Y' ",
               "    AND oocient = ",g_enterprise

#   IF NOT cl_null(g_mmaf_m.mmaf024) THEN          
#      LET l_sql = l_sql clipped,"AND ooci001 = '",g_mmaf_m.mmaf024,"'"
#   END IF		   
			   
   PREPARE ammq300_mmaf025_prep FROM l_sql
   DECLARE ammq300_mmaf025_curs CURSOR FOR ammq300_mmaf025_prep
   LET l_str1 = NULL
   LET l_str2 = NULL
   FOREACH ammq300_mmaf025_curs INTO l_ooci002,l_oocil004
      #LET l_oocil004 = l_ooci002,":",l_oocil004
      LET l_str1 = l_str1,",",l_ooci002
      LET l_str2 = l_str2,",",l_oocil004
   END FOREACH

   CALL cl_set_combo_items('mmaf025',l_str1,l_str2)
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION ammq301_mmaf026_scc()
DEFINE l_sql       STRING
DEFINE l_oock003   LIKE oock_t.oock001
DEFINE l_oockl005  LIKE oockl_t.oockl003
DEFINE l_str1      STRING
DEFINE l_str2      STRING

   LET l_sql = " SELECT DISTINCT oock003,oockl005 ",
               "   FROM oock_t ",
			      "   LEFT JOIN oockl_t ON oockent = oocklent ",
			      "                    AND oock001 = oockl001 ",
			      "                    AND oock002 = oockl002 ",
			      "                    AND oock003 = oockl003 ",
               "                    AND oockl004 = '",g_dlang,"' ",
               "  WHERE oockstus = 'Y' ",
			      "    AND oockent = ",g_enterprise
               
#   IF NOT cl_null(g_mmaf_m.mmaf024) THEN
#      LET l_sql = l_sql clipped," AND oock001 = '",g_mmaf_m.mmaf024,"' "
#   END IF
#   IF NOT cl_null(g_mmaf_m.mmaf025) THEN
#      LET l_sql = l_sql clipped," AND oock002 = '",g_mmaf_m.mmaf025,"' "
#   END IF	   
			   
   PREPARE ammq300_mmaf026_prep FROM l_sql
   DECLARE ammq300_mmaf026_curs CURSOR FOR ammq300_mmaf026_prep
   LET l_str1 = NULL
   LET l_str2 = NULL
   FOREACH ammq300_mmaf026_curs INTO l_oock003,l_oockl005
      #LET l_oockl005 = l_oock003,":",l_oockl005
      LET l_str1 = l_str1,",",l_oock003
      LET l_str2 = l_str2,",",l_oockl005
   END FOREACH

   CALL cl_set_combo_items('mmaf026',l_str1,l_str2)
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION ammq301_mmaf027_scc()
DEFINE l_sql       STRING
DEFINE l_oocm004   LIKE oocm_t.oocm001
DEFINE l_oocml006  LIKE oocml_t.oocml003
DEFINE l_str1      STRING
DEFINE l_str2      STRING

   LET l_sql = " SELECT DISTINCT oocm004,oocml006 ",
               "   FROM oocm_t ",
               "   LEFT JOIN oocml_t ON oocment = oocmlent ",
               "                    AND oocm001 = oocml001 ",
               "                    AND oocm002 = oocml002 ",
               "                    AND oocm003 = oocml003 ",
               "                    AND oocm004 = oocml004 ",
               "                    AND oocml005 = '",g_dlang,"' ",
               "  WHERE oocmstus = 'Y' ",
               "    AND oocment = ",g_enterprise
               
#   IF NOT cl_null(g_mmaf_m.mmaf024) THEN
#      LET l_sql = l_sql clipped," AND oocm001 = '",g_mmaf_m.mmaf024,"' "
#   END IF                                       
#   IF NOT cl_null(g_mmaf_m.mmaf025) THEN        
#      LET l_sql = l_sql clipped," AND oocm002 = '",g_mmaf_m.mmaf025,"' "
#   END IF                                       
#   IF NOT cl_null(g_mmaf_m.mmaf026) THEN        
#      LET l_sql = l_sql clipped," AND oocm003 = '",g_mmaf_m.mmaf026,"' "
#   END IF   
			   
   PREPARE ammq300_mmaf027_prep FROM l_sql
   DECLARE ammq300_mmaf027_curs CURSOR FOR ammq300_mmaf027_prep
   LET l_str1 = NULL
   LET l_str2 = NULL
   FOREACH ammq300_mmaf027_curs INTO l_oocm004,l_oocml006
      #LET l_oocml006 = l_oocm004,":",l_oocml006
      LET l_str1 = l_str1,",",l_oocm004
      LET l_str2 = l_str2,",",l_oocml006
   END FOREACH

   CALL cl_set_combo_items('mmaf027',l_str1,l_str2)
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION ammq301_mmaf028_scc()
DEFINE l_sql       STRING
DEFINE l_ooco005   LIKE ooco_t.ooco005
DEFINE l_oocol007  LIKE oocol_t.oocol007
DEFINE l_str1      STRING
DEFINE l_str2      STRING

   LET l_sql = "SELECT DISTINCT ooco005,oocol007 ",
               "  FROM ooco_t ",
               "  LEFT JOIN oocol_t ON oocoent = oocolent ",
               "                   AND ooco001 = oocol001 ",
               "                   AND ooco002 = oocol002 ",
               "                   AND ooco003 = oocol003 ",
               "                   AND ooco004 = oocol004 ",
               "                   AND ooco005 = oocol005 ",
               "                   AND oocol006 = '",g_dlang,"' ",
               "  WHERE oocostus = 'Y' ",
               "    AND oocoent = ",g_enterprise
               
#   IF NOT cl_null(g_mmaf_m.mmaf024) THEN
#      LET l_sql = l_sql clipped," AND ooco001 = '",g_mmaf_m.mmaf024,"' "
#   END IF
#   IF NOT cl_null(g_mmaf_m.mmaf025) THEN
#      LET l_sql = l_sql clipped," AND ooco002 = '",g_mmaf_m.mmaf025,"' "
#   END IF
#   IF NOT cl_null(g_mmaf_m.mmaf026) THEN
#      LET l_sql = l_sql clipped," AND ooco003 = '",g_mmaf_m.mmaf026,"' "
#   END IF
#   IF NOT cl_null(g_mmaf_m.mmaf027) THEN
#      LET l_sql = l_sql clipped," AND ooco004 = '",g_mmaf_m.mmaf027,"' "
#   END IF    
			   
   PREPARE ammq300_mmaf028_prep FROM l_sql
   DECLARE ammq300_mmaf028_curs CURSOR FOR ammq300_mmaf028_prep
   LET l_str1 = NULL
   LET l_str2 = NULL
   FOREACH ammq300_mmaf028_curs INTO l_ooco005,l_oocol007
      #LET l_oocol007 = l_ooco005,":",l_oocol007
      LET l_str1 = l_str1,",",l_ooco005
      LET l_str2 = l_str2,",",l_oocol007
   END FOREACH

   CALL cl_set_combo_items('mmaf028',l_str1,l_str2)
END FUNCTION

 
{</section>}
 
