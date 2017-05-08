#+ 程式版本......: T6 Version 1.00.00 Build-0009 at 13/03/18
#
#+ 程式代碼......: adzp260
#+ 設計人員......: cch
#+ 功能名稱說明...: 測試開窗程式並產生其程式碼
# Modify.........: 2014/10/07 by madey 增加PK:客製否欄位dzcd002,dzce003,dzch005
#                : 2014/11/11 by madey 連資料庫由CONNECT TO改用cl_db_connect
#                : 2015/04/14 by Hiko  調整畫面
#                : 2015/07/01 by madey 增加顯示hard code欄位
#                : 2015/10/05 by madey construct模式的回傳值個數與state=input模式相同
 

IMPORT os
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
DEFINE   g_q_id LIKE dzca_t.dzca001,
         g_q_cust_flag LIKE dzca_t.dzca002, #20141007
        #g_q_name LIKE dzca_t.dzca002,     #20141007:bug fix
         g_q_name LIKE dzcal_t.dzcal003, 
         g_q_sql  LIKE dzca_t.dzca003,
         g_q_hardcode  LIKE dzca_t.dzca006, #20150701
         g_test_wedget STRING,

         g_return1 STRING,
         g_return2 STRING,
         g_return3 STRING,
         g_return4 STRING,
         g_return5 STRING,
         g_return6 STRING,
         g_return7 STRING,
         g_return8 STRING,
         g_return9 STRING,
         g_return10 STRING,
         g_m_mode_return STRING,

         g_state LIKE type_t.chr1,
         g_reqry LIKE type_t.chr1,
         g_where STRING,

         g_default1 STRING,
         g_default2 STRING,
         g_default3 STRING,
         g_default4 STRING,
         g_default5 STRING,
         g_default6 STRING,
         g_default7 STRING,
         g_default8 STRING,
         g_default9 STRING,
         g_default10 STRING,


         g_arg1 STRING,
         g_arg2 STRING,
         g_arg3 STRING,
         g_arg4 STRING,
         g_arg5 STRING,
         g_arg6 STRING,
         g_arg7 STRING,
         g_arg8 STRING,
         g_arg9 STRING,

         gs_dlang STRING,
         gs_lang STRING,
         gs_legal STRING,
         gs_site STRING,
         gs_user STRING,
         gs_dept STRING,
         gs_ent STRING,
         gs_today DATE,

         gs_dlang_t STRING,
         gs_lang_t STRING,
         gs_legal_t STRING,
         gs_site_t STRING,
         gs_user_t STRING,
         gs_dept_t STRING,
         gs_ent_t STRING,
         gs_today_t STRING,

         g_q_code STRING,

         g_q_return_num   LIKE type_t.num5, #回傳值數目
         g_q_arg1_exist   LIKE type_t.num5, #外部參數1是否存在
         g_q_arg2_exist   LIKE type_t.num5, #外部參數2是否存在
         g_q_arg3_exist   LIKE type_t.num5, #外部參數3是否存在
         g_q_arg4_exist   LIKE type_t.num5, #外部參數4是否存在
         g_q_arg5_exist   LIKE type_t.num5, #外部參數5是否存在
         g_q_arg6_exist   LIKE type_t.num5, #外部參數6是否存在
         g_q_arg7_exist   LIKE type_t.num5, #外部參數7是否存在
         g_q_arg8_exist   LIKE type_t.num5, #外部參數8是否存在
         g_q_arg9_exist   LIKE type_t.num5, #外部參數9是否存在
        
         
         g_q_dlang_exist  LIKE type_t.num5, #資料多語言是否存在
         g_q_lang_exist   LIKE type_t.num5, #UI畫面語言是否存在
         g_q_legal_exist  LIKE type_t.num5, #法人編號是否存在
         g_q_site_exist   LIKE type_t.num5, #營運據點是否存在
         g_q_user_exist   LIKE type_t.num5, #使用者代號是否存在
         g_q_dept_exist   LIKE type_t.num5, #部門代號是否存在
         g_q_ent_exist    LIKE type_t.num5, #企業編號是否存在
         g_q_today_exist  LIKE type_t.num5  #系統日期是否存在
DEFINE   g_erp            STRING #TIPTOP起始目錄


#+ 作業開始
MAIN
   DEFINE lw_window   ui.Window,
          lf_form     ui.Form,
          ls_cfg_path STRING,
          ls_4st_path STRING,
          ls_img_path STRING

   OPTIONS
     INPUT WRAP

   CALL cl_tool_init()   
   
   OPEN WINDOW w_adzp260 WITH FORM cl_ap_formpath("adz",g_prog)

   CLOSE WINDOW screen

   LET g_state = "i"

   CALL  adzp260_init()
   
   CALL cl_ui_wintitle(1) #工具抬頭名稱

   CALL cl_load_4ad_interface(NULL)

   LET lw_window = ui.Window.getCurrent()
   LET ls_img_path = os.Path.join(os.Path.join(FGL_GETENV("RES"), "img"), "ui")
   CALL lw_window.setImage(os.Path.join(os.Path.join(ls_img_path, "logo"), "dsc_logo.ico"))

   LET ls_cfg_path = os.Path.join(FGL_GETENV("ERP"), "cfg")
   LET ls_4st_path = os.Path.join(os.Path.join(os.Path.join(ls_cfg_path, "4st"), g_lang), "designer.4st")
   CALL ui.Interface.loadStyles(ls_4st_path)

   CALL adzp260_input()
 
   CLOSE WINDOW w_adzp260
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN

#初始化
PRIVATE FUNCTION adzp260_init()
   DEFINE l_cnt LIKE type_t.num5
   DEFINE ls_cnt STRING
   DEFINE l_str STRING
   DEFINE l_dzca001 LIKE dzca_t.dzca001
   #20141007 -Begin-                                                                                                 
   DEFINE lb_have_cust   BOOLEAN,
          li_cnt         LIKE type_t.num5
   #20141007 -End-

   LET g_erp = FGL_GETENV("ERP")
   
   LET g_q_id = ARG_VAL(2)
   LET g_q_id = g_q_id CLIPPED

   CALL cl_set_combo_lang("s_lang")
   CALL cl_set_combo_lang("s_dlang")

   #20141007:確認是否有被客製 -Begin-
   CALL sadzp210_check_qry_have_cust(g_q_id) RETURNING li_cnt,lb_have_cust
   IF li_cnt > 0 THEN
      IF lb_have_cust THEN
         LET g_q_cust_flag = "c"
       ELSE
         LET g_q_cust_flag = "s"
       END IF
   ELSE
      #沒資料, 離開
      DISPLAY  "no data in dzca_t"
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "azz-00025"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN 
   END IF
   #20141007:確認是否有被客製 -End-

   #撈出說明和sql指令

   SELECT dzcal003 INTO g_q_name
      FROM dzcal_t WHERE dzcal001 = g_q_id AND dzcal002 = g_lang
   
   SELECT dzca003,dzca006 INTO g_q_sql,g_q_hardcode
      FROM dzca_t WHERE dzca001 = g_q_id   
                    AND dzca002 = g_q_cust_flag #20141007
   
   LET gs_dlang_t = g_dlang
   LET gs_lang_t = g_lang
   LET gs_legal_t = g_legal
   LET gs_site_t = g_site
   LET gs_user_t = g_user
   LET gs_dept_t = g_dept
   LET gs_ent_t = g_enterprise
   LET gs_today_t = g_today
   LET g_where = "1=1"

   LET l_dzca001 = g_q_id
   
   LET g_q_return_num = 0
   SELECT COUNT(*) INTO g_q_return_num FROM dzcc_t 
      WHERE dzcc001=g_q_id AND dzcc005='Y'
        AND dzcc009=g_q_cust_flag #20141007

   LET g_q_arg1_exist = adzp260_chk_arg_exist(g_q_id,"1")
   LET g_q_arg2_exist = adzp260_chk_arg_exist(g_q_id,"2")
   LET g_q_arg3_exist = adzp260_chk_arg_exist(g_q_id,"3")
   LET g_q_arg4_exist = adzp260_chk_arg_exist(g_q_id,"4")
   LET g_q_arg5_exist = adzp260_chk_arg_exist(g_q_id,"5")
   LET g_q_arg6_exist = adzp260_chk_arg_exist(g_q_id,"6")
   LET g_q_arg7_exist = adzp260_chk_arg_exist(g_q_id,"7")
   LET g_q_arg8_exist = adzp260_chk_arg_exist(g_q_id,"8")
   LET g_q_arg9_exist = adzp260_chk_arg_exist(g_q_id,"9")

   LET g_q_dlang_exist = adzp260_chk_common_arg_exist(g_q_sql,":DLANG")
   LET g_q_lang_exist = adzp260_chk_common_arg_exist(g_q_sql,":LANG")
   LET g_q_legal_exist = adzp260_chk_common_arg_exist(g_q_sql,":LEGAL")
   LET g_q_site_exist = adzp260_chk_common_arg_exist(g_q_sql,":SITE")
   LET g_q_today_exist = adzp260_chk_common_arg_exist(g_q_sql,":TODAY")
   LET g_q_user_exist = adzp260_chk_common_arg_exist(g_q_sql,":USER")
   LET g_q_dept_exist = adzp260_chk_common_arg_exist(g_q_sql,":DEPT")
   LET g_q_ent_exist = adzp260_chk_common_arg_exist(g_q_sql,":ENT")

   CALL cl_set_comp_visible("lbl_arg1,s_arg1",g_q_arg1_exist)
   CALL cl_set_comp_visible("lbl_arg2,s_arg2",g_q_arg2_exist)
   CALL cl_set_comp_visible("lbl_arg3,s_arg3",g_q_arg3_exist)
   CALL cl_set_comp_visible("lbl_arg4,s_arg4",g_q_arg4_exist)
   CALL cl_set_comp_visible("lbl_arg5,s_arg5",g_q_arg5_exist)
   CALL cl_set_comp_visible("lbl_arg6,s_arg6",g_q_arg6_exist)
   CALL cl_set_comp_visible("lbl_arg7,s_arg7",g_q_arg7_exist)
   CALL cl_set_comp_visible("lbl_arg8,s_arg8",g_q_arg8_exist)
   CALL cl_set_comp_visible("lbl_arg9,s_arg9",g_q_arg9_exist)

   CALL cl_set_comp_visible("lbl_dlang,s_dlang",g_q_dlang_exist)
   CALL cl_set_comp_visible("lbl_lang,s_lang",g_q_lang_exist)
   CALL cl_set_comp_visible("lbl_legal,s_legal",g_q_legal_exist)
   CALL cl_set_comp_visible("lbl_site,s_site",g_q_site_exist)
   CALL cl_set_comp_visible("lbl_today,s_today",g_q_today_exist)
   CALL cl_set_comp_visible("lbl_user,s_user",g_q_user_exist)
   CALL cl_set_comp_visible("lbl_dept,s_dept",g_q_dept_exist)
   CALL cl_set_comp_visible("lbl_ent,s_ent",g_q_ent_exist)

   FOR l_cnt = 1 TO 10
      LET ls_cnt = l_cnt
      LET l_str = "lbl_return",ls_cnt,",s_return",ls_cnt,",lbl_default",ls_cnt,",s_default",ls_cnt
      CALL cl_set_comp_visible(l_str,FALSE)
   END FOR

   CALL cl_set_comp_visible("s_m_mode_return,s_m_mode_return",FALSE)


   LET g_return1=""
   LET g_return2=""
   LET g_return3=""
   LET g_return4=""
   LET g_return5=""
   LET g_return6=""
   LET g_return7=""
   LET g_return8=""
   LET g_return9=""
   LET g_return10=""
   LET g_m_mode_return=""
   LET g_test_wedget = ""
   LET g_q_code = ""

   DISPLAY g_test_wedget,g_m_mode_return,g_return1,g_return2,g_return3,g_return4,g_return5,g_return6,g_return7,g_return8,g_return9,g_return10
        TO s_test_wedget,s_m_mode_return,s_return1,s_return2,s_return3,s_return4,s_return5,s_return6,s_return7,s_return8,s_return9,s_return10


   
  #IF g_state = "i" THEN
   IF g_state = "i" OR g_state = "c" THEN #madey:qoo
      FOR l_cnt = 1 TO g_q_return_num
         LET ls_cnt = l_cnt
         LET l_str = "lbl_return",ls_cnt,",s_return",ls_cnt,",lbl_default",ls_cnt,",s_default",ls_cnt
         CALL cl_set_comp_visible(l_str,TRUE)
      END FOR
   END IF

  #IF g_state = "c" THEN #mark by madey:qoo 
  #   FOR l_cnt = 1 TO 1
  #      LET ls_cnt = l_cnt
  #      LET l_str = "lbl_return",ls_cnt,",s_return",ls_cnt
  #      CALL cl_set_comp_visible(l_str,TRUE)
  #   END FOR
  #END IF

   IF g_state = "m" THEN
      CALL cl_set_comp_visible("LET g_return1="",s_m_mode_return",TRUE)
   END IF

END FUNCTION

PRIVATE FUNCTION adzp260_chk_common_arg_exist(p_sql,p_str)
   DEFINE p_sql STRING
   DEFINE p_str STRING
   DEFINE r_value LIKE type_t.num5

   LET p_str = "*",p_str,"*"
   LET r_value = FALSE

      
   IF p_sql MATCHES p_str THEN
      LET r_value = TRUE
   END IF

   RETURN r_value
   
END FUNCTION

PRIVATE FUNCTION adzp260_chk_arg_exist(p_dzcb001,p_dzcb003)
   DEFINE p_dzcb001 LIKE dzcb_t.dzcb001
   DEFINE p_dzcb003 LIKE dzcb_t.dzcb003
   DEFINE l_cnt     LIKE type_t.num5
   DEFINE r_value   LIKE type_t.num5

   LET l_cnt = 0
   LET r_value = FALSE
   
   SELECT COUNT(*) INTO l_cnt FROM dzcb_t 
      WHERE dzcb001 = p_dzcb001 AND dzcb003 = p_dzcb003
        AND dzcb004 = g_q_cust_flag #20141007

   IF l_cnt >0 THEN
      LET r_value = TRUE
   END IF

   RETURN r_value
END FUNCTION

#+ 資料輸入
PRIVATE FUNCTION adzp260_input()
   DEFINE l_cnt LIKE type_t.num5
   DEFINE l_str STRING

   DISPLAY g_q_id,g_q_name,g_q_sql,g_q_cust_flag,g_q_hardcode
        TO s_q_id,s_q_name,s_q_sql,s_q_cust     ,s_q_hardcode
   
   LET g_reqry = 0
   LET g_q_code = adzp260_gen_code_str()

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      INPUT g_test_wedget,
            g_state,g_reqry,g_where,
            g_default1,g_default2,g_default3,g_default4,g_default5,g_default6,g_default7,g_default8,g_default9,g_default10,
            g_arg1,g_arg2,g_arg3,g_arg4,g_arg5,g_arg6,g_arg7,g_arg8,g_arg9,
            gs_dlang,gs_legal,gs_site,gs_user,gs_dept,gs_ent,gs_lang,gs_today
            FROM 
            s_test_wedget,
            s_state,s_reqry,s_where,
            s_default1,s_default2,s_default3,s_default4,s_default5,s_default6,s_default7,s_default8,s_default9,s_default10,
            s_arg1,s_arg2,s_arg3,s_arg4,s_arg5,s_arg6,s_arg7,s_arg8,s_arg9,
            s_dlang,s_legal,s_site,s_user,s_dept,s_ent,s_lang,s_today   ATTRIBUTE(WITHOUT DEFAULTS)

      ON CHANGE s_state
         CALL adzp260_init()

      END INPUT
      
         BEFORE DIALOG
            LET gs_dlang = g_dlang
            LET gs_lang = g_lang
            LET gs_legal = g_legal
            LET gs_site = g_site
            LET gs_user = g_user
            LET gs_dept = g_dept
            LET gs_ent = g_enterprise
            LET gs_today = g_today

         ON ACTION controlp
            #CALL ui.Interface.loadStyles(os.Path.join(g_erp,os.Path.join("cfg",os.Path.join("4st","style_q.4st")))) #20150414 by Hiko
            LET g_dlang = gs_dlang
            LET g_lang = gs_lang
            LET g_legal = gs_legal
            LET g_site = gs_site
            LET g_user = gs_user
            LET g_dept = gs_dept
            LET g_enterprise = gs_ent
            LET g_today = gs_today

            INITIALIZE g_qryparam.* TO NULL

            LET g_qryparam.state = g_state
            LET g_qryparam.reqry = g_reqry
            LET g_qryparam.where = g_where

            LET g_qryparam.default1 = g_default1
            LET g_qryparam.default2 = g_default2
            LET g_qryparam.default3 = g_default3
            LET g_qryparam.default4 = g_default4
            LET g_qryparam.default5 = g_default5
            LET g_qryparam.default6 = g_default6
            LET g_qryparam.default7 = g_default7
            LET g_qryparam.default8 = g_default8
            LET g_qryparam.default9 = g_default9
            LET g_qryparam.default10 = g_default10

            LET g_qryparam.arg1 = g_arg1
            LET g_qryparam.arg2 = g_arg2
            LET g_qryparam.arg3 = g_arg3
            LET g_qryparam.arg4 = g_arg4
            LET g_qryparam.arg5 = g_arg5
            LET g_qryparam.arg6 = g_arg6
            LET g_qryparam.arg7 = g_arg7
            LET g_qryparam.arg8 = g_arg8
            LET g_qryparam.arg9 = g_arg9

            #呼叫開窗
            &include "query_prog.4gl"
			
            #將開窗取得的值回傳到變數
           #IF g_state = "i" THEN
            IF g_state = "i" OR g_state = "c" THEN #madey:qoo
               LET g_test_wedget = g_qryparam.return1
               LET g_return1 = g_qryparam.return1
               LET g_return2 = g_qryparam.return2
               LET g_return3 = g_qryparam.return3
               LET g_return4 = g_qryparam.return4
               LET g_return5 = g_qryparam.return5
               LET g_return6 = g_qryparam.return6
               LET g_return7 = g_qryparam.return7
               LET g_return8 = g_qryparam.return8
               LET g_return9 = g_qryparam.return9
               LET g_return10 = g_qryparam.return10
               DISPLAY g_test_wedget,g_return1,g_return2,g_return3,g_return4,g_return5,g_return6,g_return7,g_return8,g_return9,g_return10
                    TO s_test_wedget,s_return1,s_return2,s_return3,s_return4,s_return5,s_return6,s_return7,s_return8,s_return9,s_return10
            END IF

           #IF g_state = "c" THEN #mark by madey:qoo
           #   LET g_test_wedget = g_qryparam.return1
           #   LET g_return1 = g_qryparam.return1
           #   DISPLAY g_test_wedget,g_return1 TO s_test_wedget,s_return1
           #END IF
            
            IF g_state = "m" THEN
               LET g_m_mode_return = ""
               FOR l_cnt = 1 TO g_qryparam.str_array.getLength()
                  LET l_str = l_cnt
                  LET l_str = l_str.trim()
                  IF l_cnt = g_qryparam.str_array.getLength() THEN
                     LET g_m_mode_return = g_m_mode_return," g_qryparam.str_array[",l_str,"]=",g_qryparam.str_array[l_cnt]
                  ELSE
                     LET g_m_mode_return = g_m_mode_return," g_qryparam.str_array[",l_str,"]=",g_qryparam.str_array[l_cnt],ASCII 10
                  END IF
               END FOR
               DISPLAY g_m_mode_return TO s_m_mode_return
            END IF
            
            LET g_q_code = adzp260_gen_code_str()

            LET g_dlang = gs_dlang_t
            LET g_lang = gs_lang_t
            LET g_legal = gs_legal_t
            LET g_site = gs_site_t
            LET g_user = gs_user_t
            LET g_dept = gs_dept_t
            LET g_enterprise = gs_ent_t
            LET g_today = gs_today_t

      ON ACTION lbl_gen_code
            LET g_q_code = adzp260_gen_code_str()

      ON ACTION close       #在dialog 右上角 (X)
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         EXIT DIALOG
 
      #交談指令共用ACTION
       &include "common_action.4gl" 
      #CONTINUE DIALOG 
         
   END DIALOG
    
END FUNCTION

PRIVATE FUNCTION adzp260_gen_code_str()
   DEFINE l_cnt LIKE type_t.num5
   DEFINE ls_cnt STRING
   DEFINE l_str STRING
   DEFINE ls_return STRING

   LET ls_return = ls_return,"### ",g_q_name,"### start ###", ASCII 10

   LET ls_return = ls_return,"INITIALIZE g_qryparam.* TO NULL ", ASCII 10

   IF NOT cl_null(g_state) THEN
      LET ls_return = ls_return,"LET g_qryparam.state = \"",g_state,"\"", ASCII 10
   END IF

   IF NOT cl_null(g_reqry) THEN
   
      IF g_reqry = 0 THEN
         LET ls_return = ls_return,"LET g_qryparam.reqry = FALSE", ASCII 10
      ELSE
         LET ls_return = ls_return,"LET g_qryparam.reqry = TRUE", ASCII 10
      END IF
      
   END IF

   IF g_state = "i" THEN
   
      LET ls_cnt = g_q_return_num
      
      CASE ls_cnt

         WHEN 1 
            LET ls_return = ls_return,"LET g_qryparam.default1 = \"",g_default1,"\"", ASCII 10
         WHEN 2
            LET ls_return = ls_return,"LET g_qryparam.default1 = \"",g_default1,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_qryparam.default2 = \"",g_default2,"\"", ASCII 10
         WHEN 3
            LET ls_return = ls_return,"LET g_qryparam.default1 = \"",g_default1,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_qryparam.default2 = \"",g_default2,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_qryparam.default3 = \"",g_default3,"\"", ASCII 10
         WHEN 4
            LET ls_return = ls_return,"LET g_qryparam.default1 = \"",g_default1,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_qryparam.default2 = \"",g_default2,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_qryparam.default3 = \"",g_default3,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_qryparam.default4 = \"",g_default4,"\"", ASCII 10
         WHEN 5
            LET ls_return = ls_return,"LET g_qryparam.default1 = \"",g_default1,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_qryparam.default2 = \"",g_default2,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_qryparam.default3 = \"",g_default3,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_qryparam.default4 = \"",g_default4,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_qryparam.default5 = \"",g_default5,"\"", ASCII 10
         WHEN 6
            LET ls_return = ls_return,"LET g_qryparam.default1 = \"",g_default1,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_qryparam.default2 = \"",g_default2,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_qryparam.default3 = \"",g_default3,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_qryparam.default4 = \"",g_default4,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_qryparam.default5 = \"",g_default5,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_qryparam.default6 = \"",g_default6,"\"", ASCII 10
         WHEN 7
            LET ls_return = ls_return,"LET g_qryparam.default1 = \"",g_default1,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_qryparam.default2 = \"",g_default2,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_qryparam.default3 = \"",g_default3,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_qryparam.default4 = \"",g_default4,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_qryparam.default5 = \"",g_default5,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_qryparam.default6 = \"",g_default6,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_qryparam.default7 = \"",g_default7,"\"", ASCII 10
         WHEN 8
            LET ls_return = ls_return,"LET g_qryparam.default1 = \"",g_default1,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_qryparam.default2 = \"",g_default2,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_qryparam.default3 = \"",g_default3,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_qryparam.default4 = \"",g_default4,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_qryparam.default5 = \"",g_default5,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_qryparam.default6 = \"",g_default6,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_qryparam.default7 = \"",g_default7,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_qryparam.default8 = \"",g_default8,"\"", ASCII 10
         WHEN 9
            LET ls_return = ls_return,"LET g_qryparam.default1 = \"",g_default1,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_qryparam.default2 = \"",g_default2,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_qryparam.default3 = \"",g_default3,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_qryparam.default4 = \"",g_default4,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_qryparam.default5 = \"",g_default5,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_qryparam.default6 = \"",g_default6,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_qryparam.default7 = \"",g_default7,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_qryparam.default8 = \"",g_default8,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_qryparam.default9 = \"",g_default9,"\"", ASCII 10
         WHEN 10
            LET ls_return = ls_return,"LET g_qryparam.default1 = \"",g_default1,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_qryparam.default2 = \"",g_default2,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_qryparam.default3 = \"",g_default3,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_qryparam.default4 = \"",g_default4,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_qryparam.default5 = \"",g_default5,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_qryparam.default6 = \"",g_default6,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_qryparam.default7 = \"",g_default7,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_qryparam.default8 = \"",g_default8,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_qryparam.default9 = \"",g_default9,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_qryparam.default10= \"",g_default10,"\"", ASCII 10

    END CASE

   END IF


   IF NOT cl_null(g_where) THEN
      LET ls_return = ls_return,"LET g_qryparam.where = \"",g_where,"\"", ASCII 10
   END IF
   

   IF g_q_arg1_exist THEN
      LET ls_return = ls_return,"LET g_qryparam.arg1 = \"",g_arg1,"\"", ASCII 10
   END IF

   IF g_q_arg2_exist THEN
      LET ls_return = ls_return,"LET g_qryparam.arg2 = \"",g_arg2,"\"", ASCII 10
   END IF

   IF g_q_arg3_exist THEN
      LET ls_return = ls_return,"LET g_qryparam.arg3 = \"",g_arg3,"\"", ASCII 10
   END IF

   IF g_q_arg4_exist THEN
      LET ls_return = ls_return,"LET g_qryparam.arg4 = \"",g_arg4,"\"", ASCII 10
   END IF

   IF g_q_arg5_exist THEN
      LET ls_return = ls_return,"LET g_qryparam.arg5 = \"",g_arg5,"\"", ASCII 10
   END IF

   IF g_q_arg6_exist THEN
      LET ls_return = ls_return,"LET g_qryparam.arg6 = \"",g_arg6,"\"", ASCII 10
   END IF

   IF g_q_arg7_exist THEN
      LET ls_return = ls_return,"LET g_qryparam.arg7 = \"",g_arg7,"\"", ASCII 10
   END IF

   IF g_q_arg8_exist THEN
      LET ls_return = ls_return,"LET g_qryparam.arg8 = \"",g_arg8,"\"", ASCII 10
   END IF

   IF g_q_arg9_exist THEN
      LET ls_return = ls_return,"LET g_qryparam.arg9 = \"",g_arg9,"\"", ASCII 10
   END IF

   LET ls_return = ls_return,"CALL ",g_q_id,"()", ASCII 10

   IF g_state = "i" THEN
      FOR l_cnt = 1 TO g_q_return_num
         LET ls_cnt = l_cnt
         LET ls_return = ls_return,"LET [var",ls_cnt,"] = ","g_qryparam.return",ls_cnt, ASCII 10
      END FOR
   END IF

   IF g_state = "c" THEN
      FOR l_cnt = 1 TO 1
         LET ls_cnt = l_cnt
         LET ls_return = ls_return,"LET [var",ls_cnt,"] = ","g_qryparam.return",ls_cnt, ASCII 10
      END FOR
   END IF

   IF g_state = "m" THEN
      LET ls_return = ls_return,"LET [array var of str] = ","g_qryparam.str_array[*]", ASCII 10
   END IF


   IF g_state = "i" THEN
      LET ls_return = ls_return,"DISPLAY [var*] TO [s_var*]",ASCII 10
   END IF

   IF g_state = "c" THEN
      LET ls_return = ls_return,"DISPLAY [var1] TO [s_var1]",ASCII 10
   END IF
   
   LET ls_return = ls_return,"### ",g_q_name,"### end ###", ASCII 10

   RETURN ls_return

END FUNCTION
 




