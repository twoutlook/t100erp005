#+ Version..: T100-ERP-1.00.00(版次:1) Build-000720
#+ 
#+ Filename...: adzp168_stus
#+ Description: 顯示狀態碼設定
#+ Creator....: tsai_yen(12/11/20)
#+ Modifier...: 
#+ Buildtype..: 
 

{<point name="global.memo" />}
 
IMPORT os
#add-point:增加匯入項目
{<point name="global.import" />}
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../4gl/adzp168_global.inc"
 
#單身 type 宣告
PRIVATE TYPE type_g_gzcc_d RECORD
   gzccstus  LIKE gzcc_t.gzccstus,
   gzcc005   LIKE gzcc_t.gzcc005,     #使用標示
   gzcc001   LIKE gzcc_t.gzcc001,     #Table編號
   gzcc002   LIKE gzcc_t.gzcc002,     #狀態碼欄位
   gzcc003   LIKE gzcc_t.gzcc003,     #系統分類碼
   gzcc006   LIKE gzcc_t.gzcc006,     #顯示順序
   gzcc004   LIKE gzcc_t.gzcc004,     #系統分類值
   gzcbl004  LIKE gzcbl_t.gzcbl004,   #狀態碼名稱
   gzcb004   LIKE gzcb_t.gzcb004      #狀態碼圖檔
   END RECORD
 
 
#無單身append欄位定義
 
#模組變數(Module Variables)
DEFINE g_gzcc_d          DYNAMIC ARRAY OF type_g_gzcc_d
DEFINE g_gzcc_d_t        type_g_gzcc_d
 
      
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
DEFINE g_tbtree_idx_bystus  LIKE type_t.num10 
DEFINE g_imgpath_stus    STRING                #狀態碼圖片路徑

#多table用wc
DEFINE g_wc_table           STRING
 
 
PUBLIC FUNCTION adzp168_stus(p_tbtree_idx_bystus)
   DEFINE p_tbtree_idx_bystus      LIKE type_t.num10 
   DEFINE lwin_curr      ui.Window
   DEFINE lfrm_curr      ui.Form
   DEFINE ls_path        STRING

   LET g_tbtree_idx_bystus = p_tbtree_idx_bystus
   
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call
      {<point name="main.servicecall" />}
      #end add-point
 
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adzp168_stus WITH FORM cl_ap_formpath("adz","adzp168_stus")
      #ATTRIBUTE(STYLE="openwin")

      CALL adzp168_stus_init()   

      CALL adzp168_stus_ui_dialog()

      #畫面關閉
      CLOSE WINDOW w_adzp168_stus
   END IF
END FUNCTION 

 
#+ 畫面資料初始化
PRIVATE FUNCTION adzp168_stus_init()
   LET g_imgpath_stus = "stus/16/"   #狀態碼圖片路徑
END FUNCTION
 

#+ 功能選單 
PRIVATE FUNCTION adzp168_stus_ui_dialog()
   LET g_action_choice = " "  
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()      
 
   CALL cl_set_act_visible("accept,cancel", FALSE)

      CALL adzp168_stus_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_gzcc_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
      
      
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice="exit"
            EXIT DIALOG
      
         ON ACTION exit
            LET g_action_choice="exit"
            EXIT DIALOG
      END DIALOG
      

 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 

#+ 單身陣列填充
PRIVATE FUNCTION adzp168_stus_b_fill(p_wc2)              #BODY FILL UP
   {<Local define>}
   DEFINE p_wc2           STRING
   DEFINE l_gzcc001       LIKE gzcc_t.gzcc001
   DEFINE l_gzcbl003      LIKE gzcbl_t.gzcbl003
 
   LET g_sql = " SELECT gzccstus,gzcc005,gzcc001,gzcc002,gzcc003,gzcc006,gzcc004,gzcbl004,gzcb004",
                 " FROM gzcc_t",
                 " LEFT JOIN gzcbl_t",
                 " ON gzcbl001 = gzcc003 AND gzcbl002 = gzcc004",
                 " LEFT JOIN gzcb_t",
                 " ON gzcb001 = gzcc003 AND gzcb002 = gzcc004",
                 " WHERE gzcc001 = ? AND gzcbl003 = ? AND gzccstus = 'Y'",
                 " ORDER BY gzcc006"
   PREPARE adzp168_stus_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR adzp168_stus_pb

   CALL g_gzcc_d.clear()
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   

   LET l_gzcc001 = g_tbtree[g_tbtree_idx_bystus].b_tableid CLIPPED
   LET l_gzcbl003 = g_lang
 
   FOREACH b_fill_curs USING l_gzcc001,l_gzcbl003 INTO g_gzcc_d[l_ac].gzccstus,g_gzcc_d[l_ac].gzcc005,g_gzcc_d[l_ac].gzcc001,g_gzcc_d[l_ac].gzcc002,g_gzcc_d[l_ac].gzcc003,g_gzcc_d[l_ac].gzcc006,g_gzcc_d[l_ac].gzcc004,g_gzcc_d[l_ac].gzcbl004,g_gzcc_d[l_ac].gzcb004
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      LET g_gzcc_d[l_ac].gzcb004 = g_imgpath_stus CLIPPED,g_gzcc_d[l_ac].gzcb004 CLIPPED
 
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

   CALL g_gzcc_d.deleteElement(g_gzcc_d.getLength())   
 
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_gzcc_d.getLength()
 
   END FOR
   
   #add-point:b_fill段資料填充(其他單身)
   {<point name="b_fill.others.fill"/>}
   #end add-point
 
   LET g_detail_cnt = l_ac - 1
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE adzp168_stus_pb
   
END FUNCTION



