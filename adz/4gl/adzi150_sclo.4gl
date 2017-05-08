#+ 程式版本......: T6 Version 1.00.00 Build-0009 at 13/03/18
#
#+ 程式代碼......: adzi150_sclo
#+ 設計人員......: cch
#+ 功能名稱說明...: 設定校驗帶值邏輯順序用
 

IMPORT os
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
 
#單身 type 宣告
PRIVATE TYPE type_g_chkid_logic_order        RECORD
   logic_order LIKE type_t.num5, 
   dzcd001 LIKE dzcd_t.dzcd001,
   dzejl004 LIKE dzejl_t.dzejl004,
   dzcdl003 LIKE dzcdl_t.dzcdl003
       END RECORD
 
 
#模組變數(Module Variables)
DEFINE g_chkid_d      DYNAMIC ARRAY OF type_g_chkid_logic_order
DEFINE g_chkid_d_t    type_g_chkid_logic_order
DEFINE g_rec_b       LIKE type_t.num5           
DEFINE l_ac          LIKE type_t.num5
DEFINE g_input_str  STRING             #輸入的字串
DEFINE g_output_str  STRING             #輸出的字串
DEFINE gwin_curr      ui.Window   
DEFINE gfrm_curr      ui.Form   


#+ 作業開始
PUBLIC FUNCTION adzi150_sclo_set_logic_order(p_chk_id_str)
   DEFINE p_chk_id_str STRING
   #Begin:modify by Hiko
   DEFINE lw_window   ui.Window,
          lf_form     ui.Form,
          ls_cfg_path STRING,
          ls_4st_path STRING,
          ls_4tb_path STRING,
          ls_img_path STRING
   #End

   ###初始化顯示的record 陣列
   CALL g_chkid_d.clear()

   LET g_input_str = p_chk_id_str
   
   DISPLAY "g_input_str = ",g_input_str
   IF p_chk_id_str.getLength() ! = 0 THEN
      CALL adzi150_sclo_parse_p_chk_id_str()
   END IF
   
   #避免cl_ap_init中CALL cl_user時,重新CONNECT TO "ds" 後造成問題
   #DISCONNECT CURRENT #20150422 by Hiko
 
   #依模組進行系統初始化設定(系統設定)
   #CALL cl_ap_init("adz","")
   
   #CALL cl_tool_init() #20150422 by Hiko

   #畫面開啟 (identifier)
   OPEN WINDOW w_adzi150_sclo WITH FORM cl_ap_formpath("adz","adzi150_sclo") 
   
   #Begin:20150422 by Hiko
   #ATTRIBUTE(STYLE="openwin2")

   #ui畫面初始化
   #CALL cl_ui_init()
   #LET gwin_curr = ui.Window.getCurrent()
   #LET gfrm_curr = gwin_curr.getForm()
   #CALL gfrm_curr.loadToolBar(os.Path.join(FGL_GETENV("ERP"),os.Path.join("cfg",os.Path.join("4tb","toolbar_adzi150_sub.4tb"))))

   CALL cl_ui_wintitle(1) #工具抬頭名稱

   #讓ON ACITON controlg的Button從畫面上消失, 改成用Ctrl-G來觸發
   CALL cl_load_4ad_interface(NULL) 

   LET lw_window = ui.Window.getCurrent()
   LET ls_img_path = os.Path.join(os.Path.join(FGL_GETENV("RES"), "img"), "ui")
   CALL lw_window.setImage(os.Path.join(os.Path.join(ls_img_path, "logo"), "dsc_logo.ico"))

   LET ls_cfg_path = os.Path.join(FGL_GETENV("ERP"), "cfg")
   LET ls_4st_path = os.Path.join(os.Path.join(os.Path.join(ls_cfg_path, "4st"), g_lang), "designer.4st")
   CALL ui.Interface.loadStyles(ls_4st_path)

   LET lf_form = lw_window.getForm()
   LET ls_4tb_path = os.Path.join(os.Path.join(ls_cfg_path, "4tb"), "toolbar_designer.4tb")
   CALL lf_form.loadToolBar(ls_4tb_path)
   #End:20150422 by Hiko

   #設定
   CALL adzi150_sclo_input()

   #畫面關閉
   CLOSE WINDOW w_adzi150_sclo
 
   RETURN g_output_str
END FUNCTION

#+ 解析傳入的校驗帶值識別碼的字串並其相關資料顯示出來
PRIVATE FUNCTION adzi150_sclo_parse_p_chk_id_str()
   DEFINE l_tok        base.StringTokenizer
   DEFINE ls_str       STRING
   DEFINE lc_dzcd001   LIKE dzcd_t.dzcd001
   DEFINE l_cnt        LIKE type_t.num5

   LET l_tok = base.StringTokenizer.create(g_input_str,",")

   WHILE l_tok.hasMoreTokens()
      LET ls_str = l_tok.nextToken()
      LET lc_dzcd001 = ls_str.trim()

      #cch:檢查輸入校驗帶值字串中的識別碼是否在資料庫中存在
      SELECT COUNT(*) INTO l_cnt FROM dzcd_t WHERE dzcd001 = lc_dzcd001
   
      IF l_cnt >0  THEN
         #DISPLAY "lc_dzcd001 = ",lc_dzcd001 CLIPPED
         CALL g_chkid_d.appendElement()
         LET g_chkid_d[g_chkid_d.getLength()].dzcd001 = lc_dzcd001
         LET g_chkid_d[g_chkid_d.getLength()].logic_order = g_chkid_d.getLength()

         #cch:開窗後載入校驗帶值識別碼的說明
         SELECT dzejl004,dzcdl003 INTO g_chkid_d[g_chkid_d.getLength()].dzejl004,g_chkid_d[g_chkid_d.getLength()].dzcdl003
            FROM dzcd_t 
            LEFT JOIN dzejl_t ON dzcd005 = dzejl002 
            LEFT JOIN dzcdl_t ON dzcd001=dzcdl001 AND dzcdl002=g_lang
            WHERE dzejl001 = 'chk_type' AND dzejl003 = g_lang  and dzcd001 = lc_dzcd001
      END IF
      
   END WHILE
   
END FUNCTION

PRIVATE FUNCTION adzi150_sclo_set_output_str()
   DEFINE lc_return STRING
   DEFINE l_cnt     LIKE type_t.num5

   FOR l_cnt = 1 TO g_chkid_d.getLength()
      LET lc_return = lc_return,g_chkid_d[l_cnt].dzcd001,","  
   END FOR

   LET lc_return = lc_return.subString(1,lc_return.getLength()-1)

   RETURN lc_return
   
END FUNCTION

#+ 資料輸入
PRIVATE FUNCTION adzi150_sclo_input()
   DEFINE  l_n             LIKE type_t.num5                #檢查重複用  
   DEFINE  l_cnt           LIKE type_t.num5                #檢查重複用  

   DEFINE  l_count         LIKE type_t.num5
   DEFINE  l_i             LIKE type_t.num5
   DEFINE  ls_chk           STRING
   DEFINE l_msg     STRING
   DEFINE l_chk     LIKE type_t.num5

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      INPUT ARRAY g_chkid_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = TRUE,
                  DELETE ROW = TRUE,
                  APPEND ROW = TRUE)
 
         BEFORE INPUT
            CALL adzi150_sclo_set_no_entry_b()
            
         BEFORE ROW
            LET l_ac = ARR_CURR()
        
         BEFORE INSERT
            LET l_n = ARR_COUNT()
            #cch:新增時，遞增設定部分筆數邏輯順序
            CALL adzi150_sclo_increase_adjust_logic_order(l_ac+1)

            INITIALIZE g_chkid_d[l_ac].* TO NULL 
            LET g_chkid_d_t.* = g_chkid_d[l_ac].*     #新輸入資料


            #cch:新增資料時，設定單筆資料邏輯順序
            IF l_ac = l_n THEN
               LET g_chkid_d[l_ac].logic_order = adzi150_sclo_logic_order()
            ELSE   
                LET g_chkid_d[l_ac].logic_order = l_ac
            END IF
            
            NEXT FIELD dzcd001
            
  
         AFTER INSERT
            #cch:新增時，遞增設定部分筆數邏輯順序
            #CALL adzi150_sclo_increase_adjust_logic_order(l_ac+1)

             
         BEFORE DELETE
            IF NOT cl_ask_delete() THEN # 詢問〝是否刪除此筆資料？〞
               CANCEL DELETE
            END IF
              
         AFTER DELETE 
            #cch:刪除時，遞減設定部分筆數邏輯順序
            IF g_chkid_d.getLength() > 0 THEN 
               CALL adzi150_sclo_decrease_adjust_logic_order(l_ac)
            END IF

         AFTER FIELD dzcd001
         
            #cch:檢查輸入校驗帶值字串中的識別碼是否在資料庫中存在
            SELECT COUNT(*) INTO l_cnt FROM dzcd_t WHERE dzcd001 = g_chkid_d[l_ac].dzcd001

            IF l_cnt > 0 OR g_chkid_d[l_ac].dzcd001 IS NULL THEN

               #cch:開窗後載入校驗帶值識別碼的說明
               SELECT dzejl004,dzcdl003 INTO g_chkid_d[l_ac].dzejl004,g_chkid_d[l_ac].dzcdl003
                  FROM dzcd_t 
                  LEFT JOIN dzejl_t ON dzcd005 = dzejl002
                  LEFT JOIN dzcdl_t ON dzcd001=dzcdl001 AND dzcdl002=g_lang 
                  WHERE dzejl001 = 'chk_type' AND dzejl003 = g_lang AND dzcd001 = g_chkid_d[l_ac].dzcd001
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "lib-00002"
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD dzcd001
            END IF
 
		 #---------------------<  Detail: page1  >---------------------
 
         #----<<.dzcd001>>----
         ON ACTION controlp INFIELD dzcd001
            #add-point:ON ACTION controlp INFIELD .dzcd001
            INITIALIZE g_qryparam.* TO NULL 
			   #開窗i段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = "i"
			
            #給予default值
            LET g_qryparam.default1 = g_chkid_d[l_ac].dzcd001 
            LET g_qryparam.default2 = "" #g_chkid_d[l_ac].dzcd001 #校驗帶值識別碼

			
            #呼叫開窗
            CALL q_dzcd001()
			
            #將開窗取得的值回傳到變數
            LET g_chkid_d[l_ac].dzcd001 = g_qryparam.return1 
            #LET g_chkid_d[l_ac].dzcd001 = g_qryparam.return2 #校驗帶值識別碼

			
            #顯示到畫面上
            DISPLAY g_chkid_d[l_ac].dzcd001 TO dzcd001 
            #DISPLAY g_chkid_d[l_ac].dzcd001 TO dzcd001 #校驗帶值識別碼

            #cch:開窗後載入校驗帶值識別碼的說明
            SELECT dzejl004,dzcdl003 INTO g_chkid_d[l_ac].dzejl004,g_chkid_d[l_ac].dzcdl003
               FROM dzcd_t 
               LEFT JOIN dzejl_t ON dzcd005 = dzejl002
               LEFT JOIN dzcdl_t ON dzcd001=dzcdl001 AND dzcdl002=g_lang 
               WHERE dzejl001 = 'chk_type' AND dzejl003 = g_lang  and dzcd001 = g_chkid_d[l_ac].dzcd001

         
            CALL DIALOG.setFieldTouched("s_detail1.dzcd001", TRUE)

         ON ACTION q_adzi220 #cch:開啟校驗帶值設計器串查


            LET ls_chk =  adzi150_sclo_process_para_for_adzi220()
            
            IF NOT ls_chk.getIndexOf("v_",1) THEN
               #RUN "r.r adzi220"
               CALL cl_cmdrun_openpipe('r.r','r.r adzi220',FALSE) RETURNING l_chk,l_msg
            ELSE
               #cch:組合要查詢的的校驗代值識別碼字串
               #RUN "r.r adzi220 "||ls_chk
               CALL cl_cmdrun_openpipe('r.r','r.r adzi220 '||ls_chk,FALSE) RETURNING l_chk,l_msg
            END IF

            
         ON ACTION move_up #cch:邏輯順序上移
         
            LET l_ac = DIALOG.getCurrentRow("s_detail1")
            
            IF l_ac > 1 THEN
               LET g_chkid_d_t.* = g_chkid_d[l_ac].*   #備份本筆資料

               #調換本筆資料和上一筆資料的內容,邏輯順序除外
               LET g_chkid_d[l_ac].dzcd001 = g_chkid_d[l_ac - 1].dzcd001
               LET g_chkid_d[l_ac].dzcdl003 = g_chkid_d[l_ac - 1].dzcdl003
               LET g_chkid_d[l_ac].dzejl004 = g_chkid_d[l_ac - 1].dzejl004
               LET g_chkid_d[l_ac - 1].dzcd001 = g_chkid_d_t.dzcd001
               LET g_chkid_d[l_ac - 1].dzcdl003 = g_chkid_d_t.dzcdl003
               LET g_chkid_d[l_ac - 1].dzejl004 = g_chkid_d_t.dzejl004

               #設定focus移到上一筆
               CALL DIALOG.setCurrentRow("s_detail1",l_ac - 1)
            END IF

         ON ACTION move_down #cch:邏輯順序下移
            LET l_ac = DIALOG.getCurrentRow("s_detail1")

            IF l_ac < g_chkid_d.getLength() THEN
               LET g_chkid_d_t.* = g_chkid_d[l_ac].*   #備份本筆資料

               #調換本筆資料和下一筆資料的內容,邏輯順序除外
               LET g_chkid_d[l_ac].dzcd001 = g_chkid_d[l_ac + 1].dzcd001
               LET g_chkid_d[l_ac].dzcdl003 = g_chkid_d[l_ac + 1].dzcdl003
               LET g_chkid_d[l_ac].dzejl004 = g_chkid_d[l_ac + 1].dzejl004
               LET g_chkid_d[l_ac + 1].dzcd001 = g_chkid_d_t.dzcd001
               LET g_chkid_d[l_ac + 1].dzcdl003 = g_chkid_d_t.dzcdl003
               LET g_chkid_d[l_ac + 1].dzejl004 = g_chkid_d_t.dzejl004
               
               #設定focus移到下一筆
               CALL DIALOG.setCurrentRow("s_detail1",l_ac+1)
            END IF

         ON ROW CHANGE
            
         AFTER ROW
            
      END INPUT

      
      ON ACTION ACCEPT
         LET g_output_str = adzi150_sclo_set_output_str()
         ACCEPT DIALOG
        
      ON ACTION cancel      #在dialog button (放棄)
         LET g_output_str = g_input_str
         EXIT DIALOG
 
      ON ACTION close       #在dialog 右上角 (X)
         LET g_output_str = g_input_str
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         LET g_output_str = g_input_str
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
      CONTINUE DIALOG 
         
   END DIALOG
    
END FUNCTION
 
 
#cch:新增資料時，設定單筆資料邏輯順序
PRIVATE FUNCTION adzi150_sclo_logic_order()
   DEFINE l_cnt LIKE type_t.num5
   DEFINE l_order LIKE type_t.num5

   IF g_chkid_d.getLength() = 1 THEN
      LET l_order = 1
   ELSE
      LET l_order = g_chkid_d[1].logic_order
      FOR l_cnt = 1 TO g_chkid_d.getLength()
         IF g_chkid_d[l_cnt].logic_order > l_order THEN
            LET l_order = g_chkid_d[l_cnt].logic_order
         END IF
      END FOR
      LET l_order = l_order + 1
   END IF

   RETURN l_order
END FUNCTION

#cch:刪除時，遞減設定部分筆數邏輯順序
PRIVATE FUNCTION adzi150_sclo_decrease_adjust_logic_order(p_logic_order)
   DEFINE p_logic_order       LIKE type_t.num5
   DEFINE l_cnt               LIKE type_t.num5
   DEFINE l_logic_order_tmp   LIKE type_t.num5

   FOR l_cnt = p_logic_order TO g_chkid_d.getLength()
      LET g_chkid_d[l_cnt].logic_order = l_cnt
   END FOR
END FUNCTION

#cch:新增時，遞增設定部分筆數邏輯順序
PRIVATE FUNCTION adzi150_sclo_increase_adjust_logic_order(p_logic_order)
   DEFINE p_logic_order       LIKE type_t.num5
   DEFINE l_cnt               LIKE type_t.num5
   DEFINE l_logic_order_tmp   LIKE type_t.num5

   FOR l_cnt = g_chkid_d.getLength() TO  p_logic_order STEP-1
      LET g_chkid_d[l_cnt].logic_order = l_cnt
   END FOR

END FUNCTION

#cch:組合要查詢的的校驗代值識別碼字串
PRIVATE FUNCTION adzi150_sclo_process_para_for_adzi220()
   DEFINE l_para         STRING
   DEFINE l_cnt          LIKE type_t.num5

   FOR l_cnt = 1 TO  g_chkid_d.getLength()
      LET l_para = l_para ,"\"",g_chkid_d[l_cnt].dzcd001,"\","  
   END FOR

   LET l_para = l_para.subString(1,l_para.getLength()-1)

   LET l_para = "'",l_para,"'"

   RETURN l_para

END FUNCTION


#+ 單身欄位關閉設定
PRIVATE FUNCTION adzi150_sclo_set_no_entry_b()
   CALL cl_set_comp_entry("type_t.num5,dzcdl003,dzejl004",FALSE)
END FUNCTION




