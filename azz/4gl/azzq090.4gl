#+ Version..: T6-ERP-1.00.00 Build-000166
#+ 
#+ Filename...: azzq090
#+ Buildtype..: 
#+ Memo.......:
 
IMPORT os
 
SCHEMA ds 
 
GLOBALS "../../cfg/top_global.inc"
 
DEFINE g_tree       DYNAMIC ARRAY OF RECORD
         gztd001    LIKE gztd_t.gztd001,
         gztd002    LIKE gztd_t.gztd002,
         gztd004    LIKE gztd_t.gztd004,
         gztd003    LIKE gztd_t.gztd003,
         gztd008    LIKE gztd_t.gztd008, 
         pid        LIKE gztd_t.gztd001,
         id         LIKE gztd_t.gztd001,
         exp        LIKE type_t.chr100,
         isnode     LIKE type_t.num5
                    END RECORD

DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_rec_b               LIKE type_t.num5           
DEFINE l_ac                  LIKE type_t.num5    
 
MAIN
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log
 
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("azz","") 
   
   IF g_bgjob = "Y" THEN
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_azzq090 WITH FORM cl_ap_formpath("azz",g_prog)
         
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #進入選單 Menu (='N')
      CALL azzq090_ui_dialog() 
 
      #畫面關閉
      CLOSE WINDOW w_azzq090
   END IF
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN
 
#+ 選單功能實際執行處
PRIVATE FUNCTION azzq090_ui_dialog() 
   DEFINE li_exit      LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_wc        LIKE type_t.chr200
   
   CALL azzq090_tree()
      
   CALL cl_set_act_visible("accept,cancel", FALSE)
   DISPLAY ARRAY g_tree TO s_tree.* ATTRIBUTE(COUNT=g_rec_b)
      BEFORE ROW

      ON ACTION exit 
         EXIT DISPLAY

      ON ACTION close
         EXIT DISPLAY

      ON ACTION cancel
         EXIT DISPLAY
   END DISPLAY 
      
   CALL cl_set_act_visible("accept,cancel", TRUE)
END FUNCTION 
 
PRIVATE FUNCTION azzq090_tree()

   CALL g_tree.clear()
   CLEAR FORM

   LET l_ac = 1

   CALL azzq090_tree_fill("N","數字(Number)")
   CALL azzq090_tree_fill("C","字元(Varchar)")
   CALL azzq090_tree_fill("B","Blob/Clob")
   CALL azzq090_tree_fill("D","Date")
END FUNCTION

PRIVATE FUNCTION azzq090_tree_fill(p_type,p_name)
DEFINE l_pid    LIKE gztd_t.gztd001,
       l_id     LIKE gztd_t.gztd001,
       i        LIKE type_t.num10,
       l_sql    STRING
DEFINE p_type   LIKE type_t.chr1
DEFINE p_name   LIKE type_t.chr100
DEFINE l_name   LIKE type_t.chr100
 
   LET g_tree[l_ac].gztd001 = p_type
   LET g_tree[l_ac].gztd002 = p_name
   LET g_tree[l_ac].gztd004 = NULL
   LET g_tree[l_ac].gztd003 = NULL
   LET g_tree[l_ac].gztd008 = NULL
   LET g_tree[l_ac].pid = '0'
   LET g_tree[l_ac].id = p_type
   LET g_tree[l_ac].exp = FALSE
   LET g_tree[l_ac].isnode = TRUE

   LET l_pid = g_tree[l_ac].id
   LET l_ac = l_ac + 1

   IF p_type = 'N' OR p_type = 'C' THEN
      FOR i = 0 TO 9
         IF p_type = 'N' AND (i = 5 OR i = 7) THEN
            CONTINUE FOR
         END IF
  
         IF p_type = 'N' THEN
            CASE i
                WHEN 0 LET l_name = "數值"
                WHEN 1 LET l_name = "數量"
                WHEN 2 LET l_name = "金額"
                WHEN 3 LET l_name = "百分比"
                WHEN 4 LET l_name = "時間"
                WHEN 6 LET l_name = "流通"
                WHEN 8 LET l_name = "系統"
                WHEN 9 LET l_name = "工具"
            END CASE
         ELSE
            CASE i
                WHEN 0 LET l_name = "編號"
                WHEN 1 LET l_name = "說明"
                WHEN 2 LET l_name = "單據"
                WHEN 3 LET l_name = "料倉儲批相關"
                WHEN 4 LET l_name = "製造/成本/配銷"
                WHEN 5 LET l_name = "總帳/財務/發票"
                WHEN 6 LET l_name = "流通相關"
                WHEN 7 LET l_name = "行業別相關"
                WHEN 8 LET l_name = "系統"
                WHEN 9 LET l_name = "工具"
            END CASE
         END IF
        
         LET l_id = l_pid,i USING '&'
         LET g_tree[l_ac].gztd001 = l_id
         LET g_tree[l_ac].gztd002 = l_name
         LET g_tree[l_ac].gztd004 = NULL
         LET g_tree[l_ac].gztd003 = NULL
         LET g_tree[l_ac].gztd008 = NULL
         LET g_tree[l_ac].pid = l_pid
         LET g_tree[l_ac].id = l_id
         LET g_tree[l_ac].exp = FALSE
         LET g_tree[l_ac].isnode = TRUE
     
         LET l_ac = l_ac + 1
 
         LET l_sql = "SELECT gztd001,gztd002,gztd004,gztd003,gztd008 ",
                     "  FROM gztd_t ",
                     " WHERE gztd001 LIKE '",l_id,"%' ",
                     " ORDER BY gztd001 "
         PREPARE azzq090_pre FROM l_sql
         DECLARE azzq090_cs CURSOR FOR azzq090_pre
 
         FOREACH azzq090_cs INTO g_tree[l_ac].gztd001,g_tree[l_ac].gztd002,g_tree[l_ac].gztd004,
                                 g_tree[l_ac].gztd003,g_tree[l_ac].gztd008
            LET g_tree[l_ac].pid = l_id
            LET g_tree[l_ac].id = g_tree[l_ac].gztd001
            LET g_tree[l_ac].exp = FALSE
            LET g_tree[l_ac].isnode = FALSE
 
            LET l_ac = l_ac + 1
         END FOREACH
         LET l_ac = g_tree.getLength()
      END FOR
   ELSE
      LET l_sql = "SELECT gztd001,gztd002,gztd004,gztd003,gztd008 ",
                  "  FROM gztd_t ",
                  " WHERE gztd001 LIKE '",l_pid,"%' ",
                  " ORDER BY gztd001 "
      PREPARE azzq090_pre1 FROM l_sql
      DECLARE azzq090_cs1 CURSOR FOR azzq090_pre1
 
      FOREACH azzq090_cs1 INTO g_tree[l_ac].gztd001,g_tree[l_ac].gztd002,g_tree[l_ac].gztd004,
                              g_tree[l_ac].gztd003,g_tree[l_ac].gztd008
         LET g_tree[l_ac].pid = l_pid
         LET g_tree[l_ac].id = g_tree[l_ac].gztd001
         LET g_tree[l_ac].exp = FALSE
         LET g_tree[l_ac].isnode = FALSE
 
         LET l_ac = l_ac + 1
      END FOREACH
      LET l_ac = g_tree.getLength()
   END IF     

   CALL g_tree.deleteElement(l_ac)
END FUNCTION
 
