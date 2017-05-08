#+ 程式版本......: T6 Version 1.00.00 Build-0001 at 12/12/21
#
#+ 程式代碼......: adzp990
#+ 設計人員......: tracy_lee
# Prog. Version..: 'T6-12.01.21(00000)'     #
#
# Program name   : adzp990.4gl 
# Description    : 設計資料匯出及匯入
# Modify.........: 2015/04/02 by madey:匯入前，增加提示警語(暫時)
#                  2015/06/11 by madey:暫時不允許使用
#                  2015/06/15 by madey:設計資料匯出入增加控卡規則
#                  2015/09/23 by madey:1.新增外部參數處理
#                                      2.匯入前，自動備份舊資料


IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"

&include "../4gl/sadzi888_06_type.inc"

PRIVATE TYPE type_list        RECORD
   #selected    BOOLEAN,
    gzza001     LIKE gzza_t.gzza001,
    gzzal003    LIKE gzzal_t.gzzal003
END RECORD

DEFINE g_selected           DYNAMIC ARRAY OF type_list  #儲存選取結果
DEFINE p_arr_curr           INTEGER                     #目前選取項目
DEFINE ls_msg               STRING   
DEFINE ms_topchkout         STRING   #TOPCHKOUT 是否允許簽出程式(是否開發環境)
DEFINE mb_import            BOOLEAN  #是否為匯入

DEFINE lw_window   ui.Window,
       lf_form     ui.Form,
       ls_cfg_path STRING,
       ls_4st_path STRING,
       ls_img_path STRING

DEFINE export_list          DYNAMIC ARRAY OF STRING    #要輸出的清單 #20150923 改成模組變數
DEFINE mb_bgexp_mode        BOOLEAN                    #透過帶參數方式匯出 #20150923

MAIN
    OPTIONS
    INPUT NO WRAP
    DEFER INTERRUPT

    CALL cl_tool_init()

    IF adzp990_init() THEN
       IF mb_import THEN
         #匯入
           #每支程式都應該有一個自己的主畫面，不然訊息彈窗可能會出不來(例如MENU等交談窗)
           CLOSE WINDOW screen
           OPEN WINDOW dummy_adzp990 WITH 1 ROWS, 1 COLUMNS 
           CALL sadzi888_02_upload_and_import_by_prog()
           CLOSE WINDOW dummy_adzp990 
       ELSE
          
          IF mb_bgexp_mode THEN #20150923 背景執行匯出
             CLOSE WINDOW screen
             OPEN WINDOW dummy_adzp990 WITH 1 ROWS, 1 COLUMNS 
             IF sadzi888_06_chk_dzaf_count(export_list[1]) THEN #有dzaf資料才匯出
                CALL sadzi888_02_export_by_prog(export_list)
             ELSE
                DISPLAY "Warning: ",export_list[1],"  no dzaf_t data,do nothing..."
             END IF
             CLOSE WINDOW dummy_adzp990 
          ELSE
             # 初始化 array
             CALL g_selected.CLEAR()
             
             #開啟畫面
             OPEN WINDOW w_adzp990 WITH FORM cl_ap_formpath("adz",g_code)    
             
             #adz專用style -Bebin-
             CLOSE WINDOW screen
             CALL cl_ui_wintitle(1) #工具抬頭名稱
             CALL cl_load_4ad_interface(NULL)
             LET lw_window = ui.Window.getCurrent()
             LET ls_img_path = os.Path.join(os.Path.join(FGL_GETENV("RES"), "img"), "ui")
             CALL lw_window.setImage(os.Path.join(os.Path.join(ls_img_path, "logo"), "dsc_logo.ico"))
             LET ls_cfg_path = os.Path.join(FGL_GETENV("ERP"), "cfg")
             LET ls_4st_path = os.Path.join(os.Path.join(os.Path.join(ls_cfg_path, "4st"), g_lang), "designer.4st")
             CALL ui.Interface.loadStyles(ls_4st_path)
             #adz專用style -End-
             
             CALL adzp990_ready_to_select()
             
             #畫面關閉
             CLOSE WINDOW w_adzp990
          END IF
       END IF
    END IF

    EXIT PROGRAM
END MAIN

################################################################################
# Descriptions...: 準備選擇輸出項目
# Memo...........:
# Usage..........: CALL adzp990_ready_to_select()
################################################################################
PRIVATE FUNCTION adzp990_ready_to_select()
    DEFINE li_exit   LIKE type_t.num5        #判別是否為離開作業

    LET li_exit = FALSE    
    WHILE li_exit = FALSE
        MENU
            #開窗搜尋
            ON ACTION btn_query
                CALL adzp990_query()
                
                IF g_action_choice = "exit" THEN
                    LET li_exit = TRUE
                    EXIT MENU
                END IF

            ON ACTION btn_cancel
                LET g_action_choice="exit"
                LET li_exit = TRUE
                EXIT MENU
            
            #離開程式
            ON ACTION CLOSE
                LET g_action_choice="exit"
                LET INT_FLAG = FALSE
                LET li_exit = TRUE
                EXIT MENU                
        END MENU
    END WHILE

    # 另：匯出後清空選項
    --DISPLAY ARRAY g_selected To s_detail1.*
--
        # 停用標準Action
        --BEFORE DISPLAY
            --CALL DIALOG.setActionActive("accept", FALSE)
            --CALL DIALOG.setActionActive("cancel", FALSE)     
			--
		#開窗搜尋
		--ON ACTION btn_query
			--CALL adzp990_query()
			--CALL g_selected.clear()            
			--
			--IF g_action_choice = "exit" THEN
				--LET li_exit = TRUE
				--EXIT DISPLAY
			--END IF
--
		#離開
		--ON ACTION btn_cancel
			--LET g_action_choice="exit"
			--LET li_exit = TRUE
			--EXIT DISPLAY
		--
		#離開程式
		--ON ACTION CLOSE
			--LET g_action_choice="exit"
			--LET INT_FLAG = FALSE
			--LET li_exit = TRUE
			--EXIT DISPLAY
--
    --END DISPLAY 
    
END FUNCTION 

##old:20150615 mark
###################################################################################
#### Descriptions...: 開窗選擇的主要邏輯
#### Memo...........:
#### Usage..........: CALL adzp990_query()
###################################################################################
###PRIVATE FUNCTION adzp990_query()
###DEFINE l_i          LIKE type_t.num5        #index
###        
###        INITIALIZE g_qryparam.* TO NULL     # 初始化
###        LET g_qryparam.state = 'm'          #開窗多選多回傳
###        #排除已經選擇過的
###        IF g_selected.getlength() > 0 THEN
###            LET g_qryparam.where = "gzza001 NOT IN ("
###            FOR l_i = 1 TO g_selected.getlength()
###                IF g_selected[l_i].selected = TRUE THEN
###                    IF l_i > 1 THEN
###                        LET g_qryparam.where = g_qryparam.where,",'", g_selected[l_i].gzza001,"'"
###                    ELSE
###                        LET g_qryparam.where = g_qryparam.where,"'", g_selected[l_i].gzza001,"'"
###                    END IF
###                END IF
###            END FOR
###            LET g_qryparam.where = g_qryparam.where,")"
###            DISPLAY g_qryparam.where
###        END IF
###        
###        CALL q_adzp990()    #呼叫開窗
###
###        CALL adzp990_display_selection(g_qryparam.str_array)
###        CALL adzp990_input_array()
###
###        IF g_action_choice = "export" THEN
###            CALL adzp990_export()
###        ELSE 
###            IF NOT (g_action_choice = "exit") THEN            
###                CALL adzp990_input_array()
###            END IF
###        END IF
###        
###END FUNCTION


################################################################################
# Descriptions...: 開窗選擇的主要邏輯
# Memo...........:
# Usage..........: CALL adzp990_query()
################################################################################
PRIVATE FUNCTION adzp990_query()
DEFINE l_i          LIKE type_t.num5        #index
        
        CALL g_selected.CLEAR()
  
        INITIALIZE g_qryparam.* TO NULL     # 初始化
        LET g_qryparam.state = 'i'          #開窗單選單回傳
        CALL q_adzp990()    #呼叫開窗
        IF NOT cl_null(g_qryparam.return1) THEN
           LET g_qryparam.str_array[1]=g_qryparam.return1,'|',g_qryparam.return2
           CALL adzp990_display_selection(g_qryparam.str_array)
           CALL adzp990_display_array()
           
           IF g_action_choice = "export" THEN
               CALL adzp990_export()
           ELSE 
               IF NOT (g_action_choice = "exit") THEN            
                   CALL adzp990_display_array()
               END IF
           END IF
        END IF
        
END FUNCTION


###old mark
###################################################################################
#### Descriptions...: 將開窗選擇顯示於畫面上
#### Memo...........:
#### Usage..........: CALL adzp990_display_selection(p_str_array)
#### Input parameter: p_str_array   DYNAMIC ARRAY OF STRING 
###################################################################################
###PRIVATE FUNCTION adzp990_display_selection(p_str_array)
###    DEFINE  p_str_array     DYNAMIC ARRAY OF STRING     # 查詢結果
###    DEFINE  l_return        STRING                      # 單筆資料
###    DEFINE  l_i             LIKE type_t.num5            # index
###    DEFINE  l_deli          INTEGER                     # 分隔符號位置
###    DEFINE  l_id            STRING                      # 程式代號
###    DEFINE  l_currLength    INTEGER                     # 目前所選的項目數量
###
###    LET l_currLength = g_selected.getLength()
###    FOR l_i = 1 TO p_str_array.getlength()
###        LET l_deli = 0 # 初始化
###        
###        LET l_return = p_str_array[l_i]
###        LET l_deli = l_return.getIndexOf("|", 1)
###        LET l_id = l_return.subString(1, l_deli-1)
###        IF l_deli > 0 THEN
###            LET g_selected[l_currLength + l_i].selected = TRUE
###            LET g_selected[l_currLength + l_i].gzza001 = l_id
###            #DISPLAY l_id
###            LET g_selected[l_currLength + l_i].gzzal003 =  l_return.subString(l_deli+1, l_return.getLength())
###        END IF
###    END FOR
###
###END FUNCTION


################################################################################
# Descriptions...: 將開窗選擇顯示於畫面上
# Memo...........:
# Usage..........: CALL adzp990_display_selection(p_str_array)
# Input parameter: p_str_array   DYNAMIC ARRAY OF STRING 
################################################################################
PRIVATE FUNCTION adzp990_display_selection(p_str_array)
    DEFINE  p_str_array     DYNAMIC ARRAY OF STRING     # 查詢結果
    DEFINE  l_return        STRING                      # 單筆資料
    DEFINE  l_i             LIKE type_t.num5            # index
    DEFINE  l_deli          INTEGER                     # 分隔符號位置
    DEFINE  l_id            STRING                      # 程式代號
    DEFINE  l_currLength    INTEGER                     # 目前所選的項目數量

    LET l_currLength = g_selected.getLength()
    FOR l_i = 1 TO p_str_array.getlength()
        LET l_deli = 0 # 初始化
        
        LET l_return = p_str_array[l_i]
        LET l_deli = l_return.getIndexOf("|", 1)
        LET l_id = l_return.subString(1, l_deli-1)
        IF l_deli > 0 THEN
            LET g_selected[l_currLength + l_i].gzza001 = l_id
            LET g_selected[l_currLength + l_i].gzzal003 =  l_return.subString(l_deli+1, l_return.getLength())
        END IF
    END FOR

END FUNCTION

###################################################################################
#### Descriptions...: Table 資料顯示與管理
#### Memo...........:
#### Usage..........: CALL adzp990_input_array()
###################################################################################
###PRIVATE FUNCTION adzp990_input_array()
###
###    INPUT ARRAY g_selected FROM s_detail1.* ATTRIBUTE(WITHOUT DEFAULTS, 
###                        INSERT ROW = FALSE, APPEND ROW = FALSE, DELETE ROW = TRUE)
###    
###        # 停用標準Action
###        BEFORE INPUT
###            CALL DIALOG.setActionActive("accept", FALSE)
###            CALL DIALOG.setActionActive("cancel", FALSE)        
###            
###        #開窗搜尋        
###        ON ACTION btn_query
###            CALL adzp990_query()             
###            
###        #匯出
###        ON ACTION btn_export
###            LET g_action_choice = "export"
###            ACCEPT INPUT
###            
###        #取消
###        ON ACTION btn_cancel
###            LET g_action_choice = "exit"
###            LET INT_FLAG = FALSE
###            EXIT INPUT
###    END INPUT
###
###END FUNCTION


################################################################################
# Descriptions...: Table 資料顯示與管理
# Memo...........:
# Usage..........: CALL adzp990_display_array() ,由input_array改名
################################################################################
PRIVATE FUNCTION adzp990_DISPLAY_array()

    DISPLAY ARRAY g_selected TO s_detail1.*
    
        # 停用標準Action
        BEFORE DISPLAY 
            CALL DIALOG.setActionActive("accept", FALSE)
            CALL DIALOG.setActionActive("cancel", FALSE)        
            
        #開窗搜尋        
        ON ACTION btn_query
            CALL adzp990_query()             
            
        #匯出
        ON ACTION btn_export
            LET g_action_choice = "export"
            EXIT DISPLAY
            
       ##取消
       #ON ACTION btn_cancel
       #    LET g_action_choice = "exit"
       #    LET INT_FLAG = FALSE
       #    EXIT DISPLAY

        #取消
        ON ACTION CLOSE
            LET g_action_choice = "exit"
            LET INT_FLAG = FALSE
            EXIT DISPLAY

    END DISPLAY

END FUNCTION

### old mark
###################################################################################
#### Descriptions...: 輸出資料; 呼叫另一處理程序
#### Memo...........:
#### Usage..........: CALL adzp990_export()
###################################################################################
###PRIVATE FUNCTION adzp990_export()
###DEFINE export_list  DYNAMIC ARRAY OF STRING     #要輸出的清單
###DEFINE l_i          LIKE type_t.num5            # 取資料的index
###DEFINE l_insert     LIKE type_t.num5            # 塞資料的index
###
###DEFINE l_res        STRING                      #測試用~顯示要輸出的項目
###
###    #DISPLAY "匯出START..."
###    CALL export_list.clear()
###    LET l_insert = 1
###    FOR l_i = 1 TO g_selected.getLength()
###        IF g_selected[l_i].selected == TRUE THEN
###            LET export_list[l_insert] = g_selected[l_i].gzza001
###
###            LET l_insert = l_insert + 1
###        END IF
###    END FOR
###
###    LET l_res = ""
###    FOR l_i = 1 TO export_list.getLength()
###        IF l_res.getLength() > 0 THEN
###            LET l_res = l_res,", ", export_list[l_i]
###        ELSE
###            LET l_res = export_list[l_i]
###        END IF
###    END FOR
###    
###    DISPLAY l_res
###    CALL sadzi888_02_export_by_prog(export_list)
###
###END FUNCTION


################################################################################
# Descriptions...: 輸出資料; 呼叫另一處理程序
# Memo...........:
# Usage..........: CALL adzp990_export()
################################################################################
PRIVATE FUNCTION adzp990_export()
DEFINE l_i          LIKE type_t.num5            # 取資料的index
DEFINE l_insert     LIKE type_t.num5            # 塞資料的index

DEFINE l_res        STRING                      #測試用~顯示要輸出的項目

    #DISPLAY "匯出START..."
    CALL export_list.clear()
    LET l_insert = 1
    FOR l_i = 1 TO g_selected.getLength()
        LET export_list[l_insert] = g_selected[l_i].gzza001
        LET l_insert = l_insert + 1
    END FOR

    LET l_res = ""
    FOR l_i = 1 TO export_list.getLength()
        IF l_res.getLength() > 0 THEN
            LET l_res = l_res,", ", export_list[l_i]
        ELSE
            LET l_res = export_list[l_i]
        END IF
    END FOR
    
    DISPLAY l_res
    CALL sadzi888_02_export_by_prog(export_list)

END FUNCTION

FUNCTION adzp990_init()
  DEFINE  l_parameter     STRING      #執行模式: imp(匯入)/null(匯出)


  LET mb_bgexp_mode = FALSE    #20150923
  LET gb_bak_mode = FALSE     #20150923
  CALL export_list.clear()    #20150923

  #帳號topsd無法使用(因為透過dgenv判斷為產中環境或客戶環境環要準)
  IF g_account ="topstd" THEN                                                   
     INITIALIZE g_errparam TO NULL
     LET g_errparam.EXTEND = ""
     LET g_errparam.code   = "adz-00602"
     LET g_errparam.popup  = TRUE
     CALL cl_err()
     RETURN FALSE
  END IF

  LET g_sys_dgenv=FGL_GETENV("DGENV")
  IF cl_null(g_sys_dgenv) THEN LET g_sys_dgenv="c" END IF

  #取環境變數TOPCHKOUT
  LET ms_topchkout=FGL_GETENV("TOPCHKOUT")
  IF cl_null(ms_topchkout) THEN LET ms_topchkout="N" END IF

  #20150923
  #外部參數 #使用範例:
  #匯出: r.r adzp990 [exp] [axmt500] [bak]
  #      不帶參數,由UI挑選程式id 
  #      參數1帶exp,必須要參數2帶程式id,參數3可有可無，有的話表示自動備份
  #匯入: r.r adzp990 imp [debug]  
  #      參數1帶imp,代表匯入
  #      參數2帶debug,可有可無,有的話可跳脫簽出及版本檢核

  LET l_parameter =NULL
  LET l_parameter = DOWNSHIFT(ARG_VAL(2)) CLIPPED
  IF NOT cl_null(l_parameter) THEN
     IF l_parameter="imp" THEN
        LET l_parameter =NULL
        LET l_parameter = DOWNSHIFT(ARG_VAL(3)) CLIPPED
        IF NOT cl_null(l_parameter) AND l_parameter="debug" THEN
           LET gb_god_mode = TRUE
        ELSE
           LET gb_god_mode = FALSE
        END IF

        LET mb_import = TRUE
        
        IF g_sys_dgenv = "s" THEN #標準環境
           IF ms_topchkout ="N"THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.EXTEND = ""
              LET g_errparam.code   = "adz-00640" #此環境並非開發環境(TOPCHKOUT=N)
              LET g_errparam.popup  = TRUE
              CALL cl_err()
              RETURN FALSE
           END IF
        END IF
     ELSE
        #20150923 -Begin-
        IF l_parameter="exp" THEN
           LET l_parameter = NULL
           LET l_parameter = DOWNSHIFT(ARG_VAL(3)) CLIPPED
           IF NOT cl_null(l_parameter) THEN
              LET mb_bgexp_mode = TRUE
              LET export_list[1] = l_parameter
        
              LET l_parameter = NULL
              LET l_parameter = DOWNSHIFT(ARG_VAL(4)) CLIPPED
              IF NOT cl_null(l_parameter) AND l_parameter= "bak" THEN
                 LET gb_bak_mode = TRUE
              END IF
           ELSE
             #do nothing
           END IF
        END IF
        #20150923 -End-
     END IF
  END IF

  
  RETURN TRUE
END FUNCTION


