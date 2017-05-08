#+ 程式版本......: T6 Version 1.00.00 Build-0009 at 13/03/18
#
#+ 程式代碼......: adzp290
#+ 設計人員......: cch
#+ 功能名稱說明...: 測試校驗帶值程式並產生其程式碼
# Modify.........: 2014/10/07 by madey 增加PK:客製否欄位dzcd002,dzce003,dzch005
#                : 2014/11/11 by madey 連資料庫由CONNECT TO改用cl_db_connect
#                : 2015/04/14 by Hiko : 調整畫面
#                : 2015/07/29 by madey:g_v_type_desc由scc取得
#                : 2015/08/17 by madey:可設定g_errshow
 

IMPORT os
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#DEFINE  g_v_id LIKE dzca_t.dzca001,   
#        g_v_name LIKE dzca_t.dzca002,
DEFINE   g_v_id LIKE dzcd_t.dzcd001,       #20141007:bug fix
         g_v_name LIKE dzcdl_t.dzcdl003,   #20141007:bug fix
         g_v_cust_flag LIKE dzcd_t.dzcd002,#20141007
         g_v_sql  LIKE dzca_t.dzca003,
         g_return1 STRING,
         g_return2 STRING,
         g_return3 STRING,
         g_return4 STRING,
         g_return5 STRING,
         g_return6 STRING,
         g_return7 STRING,
         g_return8 STRING,
         g_return9 STRING,
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
         gs_today_t DATE,

         g_v_code STRING,
         g_v_type LIKE dzcd_t.dzcd005,
         g_v_type_desc STRING,

         g_v_return_num   LIKE type_t.num5, #回傳值數目
         g_v_arg1_exist   LIKE type_t.num5, #外部參數1是否存在
         g_v_arg2_exist   LIKE type_t.num5, #外部參數2是否存在
         g_v_arg3_exist   LIKE type_t.num5, #外部參數3是否存在
         g_v_arg4_exist   LIKE type_t.num5, #外部參數4是否存在
         g_v_arg5_exist   LIKE type_t.num5, #外部參數5是否存在
         g_v_arg6_exist   LIKE type_t.num5, #外部參數6是否存在
         g_v_arg7_exist   LIKE type_t.num5, #外部參數7是否存在
         g_v_arg8_exist   LIKE type_t.num5, #外部參數8是否存在
         g_v_arg9_exist   LIKE type_t.num5, #外部參數9是否存在
        
         
         g_v_dlang_exist  LIKE type_t.num5, #資料多語言是否存在
         g_v_lang_exist   LIKE type_t.num5, #UI畫面語言是否存在
         g_v_legal_exist  LIKE type_t.num5, #法人編號是否存在
         g_v_site_exist   LIKE type_t.num5, #營運據點是否存在
         g_v_user_exist   LIKE type_t.num5, #使用者代號是否存在
         g_v_dept_exist   LIKE type_t.num5, #部門代號是否存在
         g_v_ent_exist    LIKE type_t.num5, #企業編號是否存在
         g_v_today_exist  LIKE type_t.num5  #系統日期是否存在
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

   #畫面開啟 (identifier)
   OPEN WINDOW w_adzp290 WITH FORM cl_ap_formpath("adz",g_prog)

   CLOSE WINDOW screen

   CALL adzp290_init()

   CALL cl_ui_wintitle(1) #工具抬頭名稱

   CALL cl_load_4ad_interface(NULL)

   LET lw_window = ui.Window.getCurrent()
   LET ls_img_path = os.Path.join(os.Path.join(FGL_GETENV("RES"), "img"), "ui")
   CALL lw_window.setImage(os.Path.join(os.Path.join(ls_img_path, "logo"), "dsc_logo.ico"))

   LET ls_cfg_path = os.Path.join(FGL_GETENV("ERP"), "cfg")
   LET ls_4st_path = os.Path.join(os.Path.join(os.Path.join(ls_cfg_path, "4st"), g_lang), "designer.4st")
   CALL ui.Interface.loadStyles(ls_4st_path)

   CALL adzp290_input()
 
   #畫面關閉
   CLOSE WINDOW w_adzp290
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN

#初始化
PRIVATE FUNCTION adzp290_init()
   DEFINE l_cnt LIKE type_t.num5
   DEFINE ls_cnt STRING
   DEFINE l_str STRING
   DEFINE l_str2  STRING
   DEFINE tok     base.StringTokenizer
   DEFINE l_dzca001 LIKE dzca_t.dzca001
   DEFINE lb_have_cust   BOOLEAN,
          li_cnt         LIKE type_t.num5   
   DEFINE l_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列 #20150729                                 
   DEFINE l_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列 #20150729


   
   LET g_erp = FGL_GETENV("ERP")
   
   LET g_v_id = ARG_VAL(2)
   LET g_v_id = g_v_id CLIPPED
   
   CALL cl_set_combo_lang("s_lang")
   CALL cl_set_combo_lang("s_dlang")

   #20141007:確認是否有被客製 -Begin-
   CALL cl_chk_validate_chk_have_cust(g_v_id) RETURNING li_cnt,lb_have_cust
   IF li_cnt > 0 THEN
       IF lb_have_cust THEN
          LET g_v_cust_flag = 'c'
       ELSE
          LET g_v_cust_flag = 's'
       END IF
   ELSE
      #沒資料, 離開
      DISPLAY "no data in dzcd_t"
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "azz-00027"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN 
   END IF
   #20141007:確認是否有被客製 -End-

   #撈出說明和sql指令
   SELECT dzcdl003 INTO g_v_name
      FROM dzcdl_t WHERE dzcdl001 = g_v_id AND dzcdl002 = g_lang
   
   SELECT dzcd003,dzcd005 INTO g_v_sql,g_v_type
      FROM dzcd_t WHERE dzcd001 = g_v_id
                    AND dzcd002 = g_v_cust_flag #20141007

   #20150729
  #SELECT dzej004 INTO g_v_type_desc 
  #   FROM dzej_t where dzej001='chk_type' and dzej003=g_lang and dzej002=g_v_type
   LET l_ref_fields[1] = "220" #scc                                                                   
   LET l_ref_fields[2] = g_v_type
   CALL ap_ref_array2(l_ref_fields,"SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001=? AND gzcbl002=? AND gzcbl003='"||g_lang||"'","") RETURNING l_rtn_fields
   LET g_v_type_desc = g_v_type ,":",l_rtn_fields[1]
   LET g_errshow = 1 #讓錯誤訊息跳出,顯示較清楚
   LET gs_dlang_t = g_dlang
   LET gs_lang_t = g_lang
   LET gs_legal_t = g_legal
   LET gs_site_t = g_site
   LET gs_user_t = g_user
   LET gs_dept_t = g_dept
   LET gs_ent_t = g_enterprise
   LET gs_today_t = g_today
   LET g_where = " 1=1"
  #LET l_dzca001 = g_v_id #20141007:bug fix
   
   LET g_v_return_num = 0
  
  #20141007:buf fix
  #SELECT COUNT(*) INTO g_v_return_num FROM dzcc_t 
  #   WHERE dzcc001=l_dzca001 AND dzcc005='Y'

   LET g_v_arg1_exist = adzp290_chk_arg_exist(g_v_id,"1")
   LET g_v_arg2_exist = adzp290_chk_arg_exist(g_v_id,"2")
   LET g_v_arg3_exist = adzp290_chk_arg_exist(g_v_id,"3")
   LET g_v_arg4_exist = adzp290_chk_arg_exist(g_v_id,"4")
   LET g_v_arg5_exist = adzp290_chk_arg_exist(g_v_id,"5")
   LET g_v_arg6_exist = adzp290_chk_arg_exist(g_v_id,"6")
   LET g_v_arg7_exist = adzp290_chk_arg_exist(g_v_id,"7")
   LET g_v_arg8_exist = adzp290_chk_arg_exist(g_v_id,"8")
   LET g_v_arg9_exist = adzp290_chk_arg_exist(g_v_id,"9")

   LET g_v_dlang_exist = adzp290_chk_common_arg_exist(g_v_sql,":DLANG")
   LET g_v_lang_exist = adzp290_chk_common_arg_exist(g_v_sql,":LANG")
   LET g_v_legal_exist = adzp290_chk_common_arg_exist(g_v_sql,":LEGAL")
   LET g_v_site_exist = adzp290_chk_common_arg_exist(g_v_sql,":SITE")
   LET g_v_user_exist = adzp290_chk_common_arg_exist(g_v_sql,":USER")
   LET g_v_dept_exist = adzp290_chk_common_arg_exist(g_v_sql,":DEPT")
   LET g_v_ent_exist = adzp290_chk_common_arg_exist(g_v_sql,":ENT")
   LET g_v_today_exist = adzp290_chk_common_arg_exist(g_v_sql,":TODAY")


   CALL cl_set_comp_visible("lbl_arg1,s_arg1",g_v_arg1_exist)
   CALL cl_set_comp_visible("lbl_arg2,s_arg2",g_v_arg2_exist)
   CALL cl_set_comp_visible("lbl_arg3,s_arg3",g_v_arg3_exist)
   CALL cl_set_comp_visible("lbl_arg4,s_arg4",g_v_arg4_exist)
   CALL cl_set_comp_visible("lbl_arg5,s_arg5",g_v_arg5_exist)
   CALL cl_set_comp_visible("lbl_arg6,s_arg6",g_v_arg6_exist)
   CALL cl_set_comp_visible("lbl_arg7,s_arg7",g_v_arg7_exist)
   CALL cl_set_comp_visible("lbl_arg8,s_arg8",g_v_arg8_exist)
   CALL cl_set_comp_visible("lbl_arg9,s_arg9",g_v_arg9_exist)

   CALL cl_set_comp_visible("lbl_dlang,s_dlang",g_v_dlang_exist)
   CALL cl_set_comp_visible("lbl_lang,s_lang",g_v_lang_exist)
   CALL cl_set_comp_visible("lbl_legal,s_legal",g_v_legal_exist)
   CALL cl_set_comp_visible("lbl_site,s_site",g_v_site_exist)
   CALL cl_set_comp_visible("lbl_user,s_user",g_v_user_exist)
   CALL cl_set_comp_visible("lbl_dept,s_dept",g_v_dept_exist)
   CALL cl_set_comp_visible("lbl_ent,s_ent",g_v_ent_exist)
   CALL cl_set_comp_visible("lbl_today,s_today",g_v_today_exist)

   FOR l_cnt = 1 TO 9
      LET ls_cnt = l_cnt
      LET l_str = "lbl_return",ls_cnt,",s_return",ls_cnt,",lbl_default",ls_cnt,",s_default",ls_cnt
      #DISPLAY "l_str = ",l_str
      CALL cl_set_comp_visible(l_str,FALSE)
   END FOR


   LET g_return1=""
   LET g_return2=""
   LET g_return3=""
   LET g_return4=""
   LET g_return5=""
   LET g_return6=""
   LET g_return7=""
   LET g_return8=""
   LET g_return9=""

   LET g_default1="error"
   LET g_default2="error"
   LET g_default3="error"
   LET g_default4="error"
   LET g_default5="error"
   LET g_default6="error"
   LET g_default7="error"
   LET g_default8="error"
   LET g_default9="error"
   

   LET g_v_code = ""

   DISPLAY 
           g_return1,g_return2,g_return3,g_return4,g_return5,g_return6,g_return7,g_return8,g_return9,
           g_errshow, #20150817
           g_default1,g_default2,g_default3,g_default4,g_default5,g_default6,g_default7,g_default8,g_default9  
        TO 
           s_return1,s_return2,s_return3,s_return4,s_return5,s_return6,s_return7,s_return8,s_return9,
           s_errshow, #20150817
           s_default1,s_default2,s_default3,s_default4,s_default5,s_default6,s_default7,s_default8,s_default9

   LET g_v_return_num = 0

   #顯示需要的回傳值和預設值欄位
   IF g_v_type = "2" OR "3" THEN
      LET l_str2 = g_v_sql
      LET l_str2 = l_str2.subString(l_str2.getIndexOf("<field>",1)+7,l_str2.getIndexOf("</field>",1)-1)

      LET tok = base.StringTokenizer.create(l_str2,",")
      WHILE tok.hasMoreTokens()
         LET g_v_return_num = g_v_return_num+1
         DISPLAY tok.nextToken()
      END WHILE

      FOR l_cnt = 1 TO g_v_return_num
         LET ls_cnt = l_cnt
         LET l_str = "lbl_return",ls_cnt,",s_return",ls_cnt,",lbl_default",ls_cnt,",s_default",ls_cnt
         CALL cl_set_comp_visible(l_str,TRUE)
      END FOR
   END IF
   
END FUNCTION

PRIVATE FUNCTION adzp290_chk_common_arg_exist(p_sql,p_str)
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

PRIVATE FUNCTION adzp290_chk_arg_exist(p_dzce001,p_dzce004)
   DEFINE p_dzce001 LIKE dzce_t.dzce001
   DEFINE p_dzce004 LIKE dzce_t.dzce004
   DEFINE l_cnt     LIKE type_t.num5
   DEFINE r_value   LIKE type_t.num5

   LET l_cnt = 0
   LET r_value = FALSE
   
   SELECT COUNT(*) INTO l_cnt FROM dzce_t 
      WHERE dzce001 = p_dzce001 AND dzce004 = p_dzce004
        AND dzce003 = g_v_cust_flag #20141007

   IF l_cnt >0 THEN
      LET r_value = TRUE
   END IF

   RETURN r_value
END FUNCTION

#+ 資料輸入
PRIVATE FUNCTION adzp290_input()
   DEFINE l_cnt LIKE type_t.num5

   DISPLAY g_v_id,g_v_name,g_v_type_desc,g_v_sql,g_v_cust_flag TO s_v_id,s_v_name,s_v_type,s_v_sql,s_v_cust
   
   LET g_v_code = adzp290_gen_code_str()

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      INPUT g_where,
            g_errshow, #20150817
            g_default1,g_default2,g_default3,g_default4,g_default5,g_default6,g_default7,g_default8,g_default9,
            g_arg1,g_arg2,g_arg3,g_arg4,g_arg5,g_arg6,g_arg7,g_arg8,g_arg9,
            gs_dlang,gs_legal,gs_site,gs_user,gs_dept,gs_ent,gs_lang,gs_today
            FROM 
            s_where,
            s_errshow, #20150817
            s_default1,s_default2,s_default3,s_default4,s_default5,s_default6,s_default7,s_default8,s_default9,
            s_arg1,s_arg2,s_arg3,s_arg4,s_arg5,s_arg6,s_arg7,s_arg8,s_arg9,
            s_dlang,s_legal,s_site,s_user,s_dept,s_ent,s_lang,s_today   ATTRIBUTE(WITHOUT DEFAULTS)
          
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

      ON ACTION btm_trigger_chk
         
         LET g_dlang = gs_dlang
         LET g_lang = gs_lang
         LET g_legal = gs_legal
         LET g_site = gs_site
         LET g_user = gs_user
         LET g_dept = gs_dept
         LET g_enterprise = gs_ent
         LET g_today = gs_today
         INITIALIZE g_chkparam.* TO NULL

         LET g_chkparam.where = g_where

         LET g_chkparam.default1 = g_default1
         LET g_chkparam.default2 = g_default2
         LET g_chkparam.default3 = g_default3
         LET g_chkparam.default4 = g_default4
         LET g_chkparam.default5 = g_default5
         LET g_chkparam.default6 = g_default6
         LET g_chkparam.default7 = g_default7
         LET g_chkparam.default8 = g_default8
         LET g_chkparam.default9 = g_default9

         LET g_chkparam.arg1 = g_arg1
         LET g_chkparam.arg2 = g_arg2
         LET g_chkparam.arg3 = g_arg3
         LET g_chkparam.arg4 = g_arg4
         LET g_chkparam.arg5 = g_arg5
         LET g_chkparam.arg6 = g_arg6
         LET g_chkparam.arg7 = g_arg7
         LET g_chkparam.arg8 = g_arg8
         LET g_chkparam.arg9 = g_arg9

         #呼叫校驗帶值程式
         &include "chk_and_ref_prog.4gl"

         #檢查是否有值回傳
         IF g_v_type = "2" OR "3" THEN
            CASE g_v_return_num
               WHEN 1 
                  LET g_return1 = g_chkparam.return1
                  DISPLAY g_return1 
                       TO s_return1
               WHEN 2
                  LET g_return1 = g_chkparam.return1
                  LET g_return2 = g_chkparam.return2
                  DISPLAY g_return1,g_return2 
                       TO s_return1,s_return2
               WHEN 3
                  LET g_return1 = g_chkparam.return1
                  LET g_return2 = g_chkparam.return2
                  LET g_return3 = g_chkparam.return3
                  DISPLAY g_return1,g_return2,g_return3 
                       TO s_return1,s_return2,s_return3
               WHEN 4
                  LET g_return1 = g_chkparam.return1
                  LET g_return2 = g_chkparam.return2
                  LET g_return3 = g_chkparam.return3
                  LET g_return4 = g_chkparam.return4
                  DISPLAY g_return1,g_return2,g_return3,g_return4 
                     TO s_return1,s_return2,s_return3,s_return4
               WHEN 5
                  LET g_return1 = g_chkparam.return1
                  LET g_return2 = g_chkparam.return2
                  LET g_return3 = g_chkparam.return3
                  LET g_return4 = g_chkparam.return4
                  LET g_return5 = g_chkparam.return5
                  DISPLAY g_return1,g_return2,g_return3,g_return4,g_return5 
                       TO s_return1,s_return2,s_return3,s_return4,s_return5
               WHEN 6
                  LET g_return1 = g_chkparam.return1
                  LET g_return2 = g_chkparam.return2
                  LET g_return3 = g_chkparam.return3
                  LET g_return4 = g_chkparam.return4
                  LET g_return5 = g_chkparam.return5
                  LET g_return6 = g_chkparam.return6
                  DISPLAY g_return1,g_return2,g_return3,g_return4,g_return5,g_return6 
                       TO s_return1,s_return2,s_return3,s_return4,s_return5,s_return6
             WHEN 7
                  LET g_return1 = g_chkparam.return1
                  LET g_return2 = g_chkparam.return2
                  LET g_return3 = g_chkparam.return3
                  LET g_return4 = g_chkparam.return4
                  LET g_return5 = g_chkparam.return5
                  LET g_return6 = g_chkparam.return6
                  LET g_return7 = g_chkparam.return7
                  DISPLAY g_return1,g_return2,g_return3,g_return4,g_return5,g_return6,g_return7 
                       TO s_return1,s_return2,s_return3,s_return4,s_return5,s_return6,s_return7
             WHEN 8
                  LET g_return1 = g_chkparam.return1
                  LET g_return2 = g_chkparam.return2
                  LET g_return3 = g_chkparam.return3
                  LET g_return4 = g_chkparam.return4
                  LET g_return5 = g_chkparam.return5
                  LET g_return6 = g_chkparam.return6
                  LET g_return7 = g_chkparam.return7
                  LET g_return8 = g_chkparam.return8
                  DISPLAY g_return1,g_return2,g_return3,g_return4,g_return5,g_return6,g_return7,g_return8 
                       TO s_return1,s_return2,s_return3,s_return4,s_return5,s_return6,s_return7,s_return8
             WHEN 9
                  LET g_return1 = g_chkparam.return1
                  LET g_return2 = g_chkparam.return2
                  LET g_return3 = g_chkparam.return3
                  LET g_return4 = g_chkparam.return4
                  LET g_return5 = g_chkparam.return5
                  LET g_return6 = g_chkparam.return6
                  LET g_return7 = g_chkparam.return7
                  LET g_return8 = g_chkparam.return8
                  LET g_return9 = g_chkparam.return9
                  DISPLAY g_return1,g_return2,g_return3,g_return4,g_return5,g_return6,g_return7,g_return8,g_return9 
                       TO s_return1,s_return2,s_return3,s_return4,s_return5,s_return6,s_return7,s_return8,s_return9

            END CASE

         END IF
                
         LET g_v_code = adzp290_gen_code_str()

         LET g_dlang = gs_dlang_t
         LET g_lang = gs_lang_t
         LET g_legal = gs_legal_t
         LET g_site = gs_site_t
         LET g_user = gs_user_t
         LET g_dept = gs_dept_t
         LET g_enterprise = gs_ent_t
         LET g_today = gs_today_t


      ON ACTION close       #在dialog 右上角 (X)
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         EXIT DIALOG
 
      #交談指令共用ACTION
       &include "common_action.4gl" 
      #CONTINUE DIALOG 
         
   END DIALOG
    
END FUNCTION

PRIVATE FUNCTION adzp290_gen_code_str()
   DEFINE l_cnt LIKE type_t.num5
   DEFINE ls_cnt STRING
   DEFINE l_str STRING
   DEFINE ls_return STRING

   LET ls_return = ls_return,"### ",g_v_name,"### start ###", ASCII 10

   #LET ls_return = ls_return,"IF NOT cl_null([field var]) THEN ", ASCII 10
   
   LET ls_return = ls_return,"INITIALIZE g_chkparam.* TO NULL ", ASCII 10

   IF g_v_type = "2" OR "3" THEN
   
      CASE g_v_return_num

         WHEN 1 
            LET ls_return = ls_return,"LET g_chkparam.default1 = \"",g_default1,"\"", ASCII 10
         WHEN 2
            LET ls_return = ls_return,"LET g_chkparam.default1 = \"",g_default1,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_chkparam.default2 = \"",g_default2,"\"", ASCII 10
         WHEN 3
            LET ls_return = ls_return,"LET g_chkparam.default1 = \"",g_default1,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_chkparam.default2 = \"",g_default2,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_chkparam.default3 = \"",g_default3,"\"", ASCII 10
         WHEN 4
            LET ls_return = ls_return,"LET g_chkparam.default1 = \"",g_default1,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_chkparam.default2 = \"",g_default2,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_chkparam.default3 = \"",g_default3,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_chkparam.default4 = \"",g_default4,"\"", ASCII 10
         WHEN 5
            LET ls_return = ls_return,"LET g_chkparam.default1 = \"",g_default1,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_chkparam.default2 = \"",g_default2,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_chkparam.default3 = \"",g_default3,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_chkparam.default4 = \"",g_default4,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_chkparam.default5 = \"",g_default5,"\"", ASCII 10
         WHEN 6
            LET ls_return = ls_return,"LET g_chkparam.default1 = \"",g_default1,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_chkparam.default2 = \"",g_default2,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_chkparam.default3 = \"",g_default3,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_chkparam.default4 = \"",g_default4,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_chkparam.default5 = \"",g_default5,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_chkparam.default6 = \"",g_default6,"\"", ASCII 10
         WHEN 7
            LET ls_return = ls_return,"LET g_chkparam.default1 = \"",g_default1,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_chkparam.default2 = \"",g_default2,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_chkparam.default3 = \"",g_default3,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_chkparam.default4 = \"",g_default4,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_chkparam.default5 = \"",g_default5,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_chkparam.default6 = \"",g_default6,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_chkparam.default7 = \"",g_default7,"\"", ASCII 10
         WHEN 8
            LET ls_return = ls_return,"LET g_chkparam.default1 = \"",g_default1,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_chkparam.default2 = \"",g_default2,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_chkparam.default3 = \"",g_default3,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_chkparam.default4 = \"",g_default4,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_chkparam.default5 = \"",g_default5,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_chkparam.default6 = \"",g_default6,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_chkparam.default7 = \"",g_default7,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_chkparam.default8 = \"",g_default8,"\"", ASCII 10
         WHEN 9
            LET ls_return = ls_return,"LET g_chkparam.default1 = \"",g_default1,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_chkparam.default2 = \"",g_default2,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_chkparam.default3 = \"",g_default3,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_chkparam.default4 = \"",g_default4,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_chkparam.default5 = \"",g_default5,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_chkparam.default6 = \"",g_default6,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_chkparam.default7 = \"",g_default7,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_chkparam.default8 = \"",g_default8,"\"", ASCII 10
            LET ls_return = ls_return,"LET g_chkparam.default9 = \"",g_default9,"\"", ASCII 10
      END CASE

   END IF


   IF NOT cl_null(g_where) THEN
      LET ls_return = ls_return,"LET g_chkparam.where = \"",g_where,"\"", ASCII 10
   END IF

   IF g_v_arg1_exist THEN
      LET ls_return = ls_return,"LET g_chkparam.arg1 = \"",g_arg1,"\"", ASCII 10
   END IF

   IF g_v_arg2_exist THEN
      LET ls_return = ls_return,"LET g_chkparam.arg2 = \"",g_arg2,"\"", ASCII 10
   END IF

   IF g_v_arg3_exist THEN
      LET ls_return = ls_return,"LET g_chkparam.arg3 = \"",g_arg3,"\"", ASCII 10
   END IF

   IF g_v_arg4_exist THEN
      LET ls_return = ls_return,"LET g_chkparam.arg4 = \"",g_arg4,"\"", ASCII 10
   END IF

   IF g_v_arg5_exist THEN
      LET ls_return = ls_return,"LET g_chkparam.arg5 = \"",g_arg5,"\"", ASCII 10
   END IF

   IF g_v_arg6_exist THEN
      LET ls_return = ls_return,"LET g_chkparam.arg6 = \"",g_arg6,"\"", ASCII 10
   END IF

   IF g_v_arg7_exist THEN
      LET ls_return = ls_return,"LET g_chkparam.arg7 = \"",g_arg7,"\"", ASCII 10
   END IF

   IF g_v_arg8_exist THEN
      LET ls_return = ls_return,"LET g_chkparam.arg8 = \"",g_arg8,"\"", ASCII 10
   END IF

   IF g_v_arg9_exist THEN
      LET ls_return = ls_return,"LET g_chkparam.arg9 = \"",g_arg9,"\"", ASCII 10
   END IF

   LET ls_return = ls_return,"LET g_chkparam.ls_title = [VAR]", ASCII 10

   LET ls_return = ls_return,"LET g_chkparam.err_str[x] = \"old_errID:new_errID|%1|%2\"", ASCII 10


   #組合呼叫校驗帶值識別碼的字串
   CASE g_v_type
      WHEN 1 #檢查存在
          LET  ls_return = ls_return,
            "IF NOT cl_chk_exist(\"",g_v_id,"\") THEN",ASCII 10,
            "   #Not exist OR SQL error!",ASCII 10,
            "END IF",ASCII 10
   
      WHEN 2 #帶值
         LET  ls_return = ls_return,
            "CALL cl_ref_val(\"",g_v_id,"\")",ASCII 10

      WHEN 3 #檢查存在與帶值
         LET  ls_return = ls_return,
            "IF NOT cl_chk_exist_and_ref_val(\"",g_v_id,"\") THEN",ASCII 10,
            "   #Not exist or Not unique or SQL error!",ASCII 10,
            "END IF",ASCII 10
   END CASE

  
   IF g_v_type = "2" OR g_v_type = "3" THEN
      FOR l_cnt = 1 TO g_v_return_num
         LET ls_cnt = l_cnt
         LET ls_return = ls_return,"LET [var",ls_cnt,"] = ","g_chkparam.return",ls_cnt, ASCII 10
      END FOR
      LET ls_return = ls_return,"DISPLAY [var*] TO [s_var*]",ASCII 10
   END IF
   
   #LET ls_return = ls_return,"END IF", ASCII 10
   
   LET ls_return = ls_return,"### ",g_v_name,"### end ###", ASCII 10

   RETURN ls_return

END FUNCTION
 




