#+ Version..: T100-ERP-1.00.00(版次:1) Build-000720
#+ 
#+ Filename...: sadzp168_1
#+ Description: adzp168提供的共用函式
#+ Creator....: tsai_yen(12/11/20)
#+ Modifier...: 程式類別    gzde005   VARCHAR2(1)    gzza002   VARCHAR2(10)   
#               多語言檔說明 gzdel003  VARCHAR2(500)  gzza004   VARCHAR2(255)  
#+ Modifier...:                2014/05/13 Hiko: ADZ模組不可使用畫面設計器
#+ Modifier...: No.FUN-140704 2014/07/04 標準程式從設計器轉客製後基本資料的模組是AXM,但實際目錄模組會是CXM
#+ Modifier...: No.FUN-140923 2014/09/23 規格版次dzaa002,識別碼版次dzaa004 欄位型態改數值,相關欄位與變數都要改型態
#+ Modifier...: No.FUN-141006 2014/10/06 AZZ客製碼內容改變: 客製Y->c; 標準N->s
#+ Modifier...: No.FUN-141007 2014/10/07 啟動ALM時不使用ALM的開窗,由AFTER FIELD再檢查資料合理性,因ALM規則改變導致開窗條件查不到資料dzlm008='W' --> I/O, dzlm011='R' --> I/O
#+ Modifier...: No.FUN-141105 2014/11/05 配合Hiko改函式
#+ Modifier...: No.FUN-160520 2016/05/20 客製環境下，子畫面附屬於AXM，實際模組應為CXM 
#+ Buildtype..: 


IMPORT os

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"
GLOBALS "../4gl/adzp168_global.inc"

##識別標示DGENV(s/c)轉(Y/N)
#FUNCTION sadzp168_1_dgenv_flag()
#   DEFINE l_dgenv_flag          LIKE type_t.chr1      #客製碼   N:非客製 / Y:客製  標準為s;客製為c
#   
#   LET ms_dgenv = FGL_GETENV("DGENV") CLIPPED   #環境變數DGENV (s:標準/ c:客製)
#   #IF ms_dgenv = "s" THEN    
#   #   LET l_dgenv_flag = "N"
#   #ELSE
#   #   LET l_dgenv_flag = "Y"
#   #END IF
#
#   LET l_dgenv_flag = ms_dgenv CLIPPED   #FUN-141006
#   RETURN l_dgenv_flag
#END FUNCTION

#是否串接ALM Y/N
FUNCTION sadzp168_1_is_alm()
   LET g_erpalm = FGL_GETENV("TOPALM")

   IF cl_null(g_erpalm) THEN
      LET g_erpalm = "N"
   END IF 
END FUNCTION 

#ALM建構類型
#FUNCTION sadzp168_1_dzlm001(p_dzfq005)
#   DEFINE p_dzfq005       LIKE dzfq_t.dzfq005   #主/子程式
#   DEFINE l_dzlm001       LIKE dzlm_t.dzlm001   #ALM建構類型
#
#   #dzlm001   與r.a相關     基本資料
#   #------------------------------
#   #SUBPROG   子程式與畫面   azzi901
#   #PROGRAM   主程式與畫面   azzi900
#   #SUBFORM   子畫面        azzi901
#
#   CASE p_dzfq005
#      WHEN "M"   #主程式與畫面azzi900
#         LET l_dzlm001 = "PROGRAM"
#      WHEN "S"   #子程式與畫面azzi901
#         LET l_dzlm001 = "SUBPROG"
#      WHEN "F"   #子畫面azzi901
#         LET l_dzlm001 = "SUBFORM"
#   END CASE
#
#   RETURN l_dzlm001
#END FUNCTION

#程式代碼基本資料檢查
FUNCTION sadzp168_1_prog_chk(p_dzfq004,p_dzfq005)
   DEFINE p_dzfq004       LIKE dzfq_t.dzfq004   #畫面代號
   DEFINE p_dzfq005       LIKE dzfq_t.dzfq005   #主/子程式
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_chk           BOOLEAN
   DEFINE l_sql           STRING
   DEFINE l_dzlm001       LIKE dzlm_t.dzlm001   #ALM建構類型
   DEFINE l_msg           STRING
   DEFINE l_str           STRING

   IF NOT cl_null(p_dzfq004) THEN
      LET l_chk = TRUE

      #ADZ模組不可使用畫面設計器
      LET l_str = p_dzfq004
      LET l_str = l_str.toUpperCase()
      IF l_str.getIndexOf("ADZ",1) > 0 THEN
         LET l_chk = FALSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  "adz-00052"
         LET g_errparam.extend = NULL
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF

      IF l_chk AND cl_null(g_erpalm) THEN
         CALL sadzp168_1_is_alm()   #是否啟動ALM
      END IF

      #程式基本資料chk
      LET l_sql = "SELECT COUNT(*) FROM gzza_t WHERE gzza001=?"
      PREPARE adzp168_gzza001_chk FROM l_sql
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'prepare:'
         LET g_errparam.popup = FALSE
         CALL cl_err()
      END IF

      #子程式基本資料chk
      LET l_sql = "SELECT COUNT(*) FROM gzde_t WHERE gzde001=? AND gzde003='S' AND gzdestus='Y'"
      PREPARE adzp168_gzde001_chk FROM l_sql
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'prepare:'
         LET g_errparam.popup = FALSE
         CALL cl_err()
      END IF

      #子畫面基本資料chk
      LET l_sql = "SELECT COUNT(*) FROM gzdf_t WHERE gzdf002=?"
      PREPARE adzp168_gzdf002_chk FROM l_sql
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'prepare:'
         LET g_errparam.popup = FALSE
         CALL cl_err()
      END IF

      CASE p_dzfq005
         WHEN "M"   #主程式與畫面azzi900
            EXECUTE adzp168_gzza001_chk USING p_dzfq004 INTO l_cnt
         WHEN "S"   #子程式與畫面azzi901
            EXECUTE adzp168_gzde001_chk USING p_dzfq004 INTO l_cnt
         WHEN "F"   #子畫面azzi901
            EXECUTE adzp168_gzdf002_chk USING p_dzfq004 INTO l_cnt
         OTHERWISE
            LET l_cnt = 0
      END CASE

      IF l_cnt = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  "adz-00050"
         LET g_errparam.extend = NULL
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] =  p_dzfq004
         CALL cl_err()
         LET l_chk = FALSE
         #NEXT FIELD CURRENT
      #ELSE
      #   IF g_erpalm = "Y" THEN   #2014/05/15 Hiko mark
      #      #程式基本資料chk for ALM
      #      CALL cl_chk_competence_check_alm(p_dzfq004, "1", "SPEC", g_user) RETURNING l_chk,l_msg
      #      IF NOT l_chk THEN
      #         CALL cl_err_msg(NULL, "adz-00022", l_msg, 1)   #%1   請再確認
      #      END IF 
      #   
      #      CALL sadzp168_1_gzza002(g_dzfq_m.dzfq004,g_dzfq_m.dzfq005) RETURNING g_gzza002,g_gzza003,g_dzfq_m.gzzal003,g_dzfq_m.use_tpl      #程式類別,模組代碼,程式名稱,是否使用樣板
      #      
      #      CALL sadzp168_1_dzlm001(p_dzfq005) RETURNING l_dzlm001
      #      LET l_sql = "SELECT COUNT(dzlm001) FROM dzlm_t",
      #                 " WHERE dzlm001=? AND dzlm002 = ? AND dzlm005='1' AND dzlm007 = ?",
      #                   " AND dzlm008='W' AND dzlm011='R'",
      #                   " AND dzlm016='",FGL_GETENV("TENANT") CLIPPED,"'"
      #      PREPARE adzp168_gzza001_alm_chk FROM l_sql
      #      IF SQLCA.sqlcode THEN
      #         CALL cl_err('prepare prog chk for ALM:',SQLCA.sqlcode,0)
      #      END IF
      #      EXECUTE adzp168_gzza001_alm_chk USING l_dzlm001,p_dzfq004,g_user INTO l_cnt
      #      
      #      IF l_cnt = 0 THEN
      #         LET l_chk = FALSE
      #         CALL cl_err_msg(NULL, "adz-00045", p_dzfq004 CLIPPED, 1)   #您沒有更新%1規格版本的權限   請查看ALM
      #         #NEXT FIELD CURRENT
      #      END IF
      #   END IF
      END IF
   END IF
         
   RETURN l_chk
END FUNCTION


#+ 畫面設計資料是否已存在
FUNCTION sadzp168_1_dzaa_exist(p_dzfq004,p_dzfq005,p_ask)
   DEFINE p_dzfq004       LIKE dzfq_t.dzfq004       #畫面代號
   DEFINE p_dzfq005       LIKE dzfq_t.dzfq005       #主/子程式
   DEFINE p_ask           BOOLEAN                   #詢問是否覆蓋
   DEFINE l_chk           BOOLEAN
   DEFINE l_cnt           LIKE type_t.num5          #檢查重複用
   DEFINE l_dzaa_cnt      LIKE type_t.num5          #規格設計資料
   DEFINE l_dzba_cnt      LIKE type_t.num5          #程式設計資料
   DEFINE l_dzaa_not1_cnt LIKE type_t.num5          #大於第一版次的規格設計資料
   DEFINE l_dzba_not1_cnt LIKE type_t.num5          #大於第一版次的程式設計資料
   DEFINE l_gzzd005       LIKE gzzd_t.gzzd005       #畫面多語言名稱
   DEFINE l_sql           STRING
   DEFINE l_cmd           STRING
   DEFINE l_chk_cmd       BOOLEAN
   DEFINE l_str           STRING
   DEFINE lb_result       BOOLEAN
   DEFINE l_msg           STRING
   #DEFINE ls_ver_dzaa002  STRING

   #LET ls_ver_dzaa002 = g_ver_dzaa002 CLIPPED
   
   #有大於第一版次的設計資料,不可使用r.a
   LET l_sql = "SELECT COUNT(dzaa002) FROM dzaa_t WHERE dzaa001 = ? AND dzaa002 <> ?" # AND dzaa009=?"
   PREPARE adzp168_dzaa_not1_cnt_pre FROM l_sql
   #EXECUTE adzp168_dzaa_not1_cnt_pre USING p_dzfq004,g_ver_dzaa002,ms_dgenv INTO l_dzaa_not1_cnt
   EXECUTE adzp168_dzaa_not1_cnt_pre USING p_dzfq004,g_ver_dzaa002 INTO l_dzaa_not1_cnt

   IF l_dzaa_not1_cnt = 0 THEN 
      LET l_sql = "SELECT COUNT(dzba002) FROM dzba_t WHERE dzba001 = ? AND dzba002 <> ?" # AND dzba010=?"
      PREPARE adzp168_dzba_not1_cnt_pre FROM l_sql
      #EXECUTE adzp168_dzba_not1_cnt_pre USING p_dzfq004,g_ver_dzaa002,ms_dgenv INTO l_dzba_not1_cnt
      EXECUTE adzp168_dzba_not1_cnt_pre USING p_dzfq004,g_ver_dzaa002 INTO l_dzba_not1_cnt
   END IF

   IF l_dzaa_not1_cnt > 0 OR l_dzba_not1_cnt > 0 THEN
      LET l_chk = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00007"   #規格設計資料/程式切片資料：已不是第一版次。請由設計器設計。
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      CALL cl_err()
   ELSE
      LET l_chk = TRUE
      
      #規格設計資料
      LET l_sql = "SELECT COUNT(dzaa002) FROM dzaa_t WHERE dzaa001 = ?" # AND dzaa009=?
      PREPARE adzp168_dzaa_cnt_pre FROM l_sql
      EXECUTE adzp168_dzaa_cnt_pre USING p_dzfq004 INTO l_dzaa_cnt
      #程式設計資料
      LET l_sql = "SELECT COUNT(dzba002) FROM dzba_t WHERE dzba001 = ?" # AND dzba010=?
      PREPARE adzp168_dzba_cnt_pre FROM l_sql
      EXECUTE adzp168_dzba_cnt_pre USING p_dzfq004 INTO l_dzba_cnt

      IF NOT p_ask THEN
         INITIALIZE g_errparam TO NULL
         CASE
            WHEN l_dzaa_cnt > 0 AND l_dzba_cnt > 0
               LET g_errparam.code =  "adz-00006"   #規格和程式資料已存在
            WHEN l_dzaa_cnt > 0 AND (NOT p_ask)
               LET g_errparam.code =  "adz-00004"   #規格設計資料已存在
            WHEN l_dzba_cnt > 0
               LET g_errparam.code =  "adz-00005"   #程式切片資料已存在。   ##若要刪除資料請至設計器"刪除程式切片"
         END CASE
         IF NOT cl_null(g_errparam.code) THEN
            LET g_errparam.extend = NULL
            LET g_errparam.popup = TRUE
            CALL cl_err()
         END IF
      ELSE
         IF l_dzaa_cnt > 0 THEN
            IF cl_ask_confirm_parm("adz-00068",l_gzzd005) THEN   #規格或程式資料已存在，請問是否覆蓋？
               #FUN-141105 mark
               #adzp062 'aiti993' '1' 'SPEC' 'M'
               #參數1 : 程式代號
               #參數2 : 規格版次 : 這裡固定傳遞"1"即可
               #參數3 : 種類 : 因為此程式是和[刪除程式資料]合用, 所以固定傳遞"SPEC", 這也是為了判斷權限
               #參數4 : 類型 : dzfq005
               #參數4 : 識別標示DGENV
               #CALL sadzp062_1_del_spec_data(p_dzfq004, g_ver_dzaa002, 'SPEC',p_dzfq005,ms_dgenv) RETURNING l_chk
               CALL sadzp063_1_del_all_design_data(p_dzfq004) RETURNING lb_result,l_msg   #FUN-141105
               IF NOT lb_result THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "std-00008"
                  LET g_errparam.extend = NULL
                  LET g_errparam.popup = TRUE
                  LET g_errparam.replace[1] =  l_msg CLIPPED
                  CALL cl_err()
               END IF
            ELSE
               LET l_chk = FALSE
            END IF
         END IF
      END IF 
   END IF
      
   RETURN l_chk
END FUNCTION


#+ 畫面設計資料底稿是否已存在
FUNCTION sadzp168_1_draft_exist(p_dzfv001,p_dzfv002,p_dzfv004)
   DEFINE p_dzfv001       LIKE dzfv_t.dzfv001   #設計工具版號
   DEFINE p_dzfv002       LIKE dzfv_t.dzfv002   #資料所有者
   DEFINE p_dzfv004       LIKE dzfv_t.dzfv004   #畫面代號
   DEFINE l_chk           BOOLEAN
   DEFINE l_cnt           LIKE type_t.num5      #檢查重複用
   DEFINE l_sql           STRING

   LET l_chk = FALSE
   LET l_sql = "SELECT COUNT(*) FROM dzfv_t WHERE dzfv001 = ? AND dzfv002 = ?  AND dzfv004 = ?"
   PREPARE adzp168_dzfv_cnt_pre FROM l_sql
   EXECUTE adzp168_dzfv_cnt_pre USING p_dzfv001,p_dzfv002,p_dzfv004 INTO l_cnt

   IF l_cnt > 0 THEN
      IF cl_ask_confirm_parm("adz-00154",p_dzfv004) THEN   #%1資料已存在，請問是否覆蓋?
         LET l_chk = TRUE
      END IF
   ELSE
      LET l_chk = TRUE
   END IF

   RETURN l_chk
END FUNCTION


#+ 開窗-程式代號
FUNCTION sadzp168_1_prog_qry(p_qrystate,p_dgenv,p_dzfq005,p_module,p_progcode,p_progname,p_prog_class)
   DEFINE p_qrystate      STRING                  #i:單選/ c:多選
   DEFINE p_dgenv         LIKE dzaa_t.dzaa009     #環境變數DGENV客製標示(s:標準/ c:客製),若NULL表示不限制
   DEFINE p_dzfq005       LIKE dzfq_t.dzfq005     #主/子程式/子畫面
   DEFINE p_module        LIKE gzza_t.gzza003     #模組
   DEFINE p_progcode      LIKE dzfq_t.dzfq004     #程式代號
   DEFINE p_progname      LIKE gzzal_t.gzzal003   #程式名稱
   DEFINE p_prog_class    LIKE gzza_t.gzza002     #程式類別
   #DEFINE l_dgenv_flag    LIKE type_t.chr1        #客製碼(s:標準/ c:客製)

   #CALL sadzp168_1_dgenv_flag() RETURNING l_dgenv_flag
   
   INITIALIZE g_qryparam.* TO NULL
   LET g_qryparam.state = p_qrystate
   LET g_qryparam.reqry = TRUE

   #IF cl_null(g_erpalm) THEN
   #   CALL sadzp168_1_is_alm()   #是否啟動ALM
   #END IF
   #
   #IF g_erpalm = "Y" THEN   #FUN-141007 mark
   #   CASE p_dzfq005   #M:主/S:子程式
   #      WHEN "M"   #主程式與畫面azzi900
   #         LET g_qryparam.default1 = p_module CLIPPED      #模組
   #         LET g_qryparam.default2 = p_progcode CLIPPED    #程式代號
   #         LET g_qryparam.default3 = p_progname CLIPPED    #程式名稱
   #         LET g_qryparam.default4 = p_prog_class CLIPPED  #程式類別
   #         CALL q_dzlm002_1()
   #
   #      WHEN "S"   #子程式與畫面azzi901
   #         LET g_qryparam.default1 = p_module CLIPPED    #模組
   #         LET g_qryparam.default2 = p_progcode CLIPPED  #程式代號
   #         LET g_qryparam.default3 = p_progname CLIPPED  #程式名稱
   #         CALL q_dzlm002_2()
   #         LET p_module = g_qryparam.return1 CLIPPED
   #         LET p_progcode = g_qryparam.return2 CLIPPED
   #         LET p_progname = g_qryparam.return3 CLIPPED
   #
   #      WHEN "F"   #子畫面azzi901
   #         LET g_qryparam.default1 = p_module CLIPPED    #模組
   #         LET g_qryparam.default2 = p_progcode CLIPPED  #子畫面規格編號
   #         LET g_qryparam.default3 = p_progname CLIPPED  #程式名稱
   #         CALL q_dzlm002_3()
   #         LET p_module = g_qryparam.return1 CLIPPED
   #         LET p_progcode = g_qryparam.return2 CLIPPED
   #         LET p_progname = g_qryparam.return3 CLIPPED
   #   END CASE
   #ELSE
      CASE p_dzfq005   #M:主/S:子程式
         WHEN "M"   #主程式與畫面azzi900
            LET g_qryparam.default1 = p_module CLIPPED         #模組
            LET g_qryparam.default2 = p_progcode CLIPPED       #程式代號
            LET g_qryparam.default3 = p_progname CLIPPED       #程式名稱
            LET g_qryparam.default4 = p_prog_class CLIPPED     #程式類別
            LET g_qryparam.where = "gzzastus = 'Y'"
            IF NOT cl_null(p_dgenv) THEN
               LET g_qryparam.where = g_qryparam.where CLIPPED," AND gzza011='",ms_dgenv CLIPPED,"'"
            END IF
            CALL q_gzza001()
            LET p_module = g_qryparam.return1 CLIPPED
            LET p_progcode = g_qryparam.return2 CLIPPED
            LET p_progname = g_qryparam.return3 CLIPPED
            LET p_prog_class = g_qryparam.return4 CLIPPED
            INITIALIZE g_qryparam.where TO NULL

         WHEN "S"   #子程式與畫面azzi901
            LET g_qryparam.default1 = p_module CLIPPED    #模組
            LET g_qryparam.default2 = p_progcode CLIPPED  #程式代號
            LET g_qryparam.default3 = p_progname CLIPPED  #程式名稱
            LET g_qryparam.where = "gzdestus = 'Y'"
            IF NOT cl_null(p_dgenv) THEN
               LET g_qryparam.where = g_qryparam.where CLIPPED," AND gzde008='",ms_dgenv CLIPPED,"'"
            END IF
            CALL q_gzde001()
            LET p_module = g_qryparam.return1 CLIPPED
            LET p_progcode = g_qryparam.return2 CLIPPED
            LET p_progname = g_qryparam.return3 CLIPPED
            INITIALIZE g_qryparam.where TO NULL

         WHEN "F"   #子畫面azzi901
            LET g_qryparam.default1 = p_module CLIPPED    #模組
            LET g_qryparam.default2 = p_progcode CLIPPED  #子畫面規格編號
            LET g_qryparam.default3 = p_progname  #畫面名稱
            #LET g_qryparam.arg1 = ms_dgenv CLIPPED
            IF NOT cl_null(p_dgenv) THEN
               LET g_qryparam.where = "gzdf003 = '",ms_dgenv CLIPPED,"'"
            END IF
            CALL q_gzdf002()
            LET p_module = g_qryparam.return1 CLIPPED
            LET p_progcode = g_qryparam.return2 CLIPPED
            LET p_progname = g_qryparam.return3
      END CASE
   #END IF   #FUN-141007 mark

   LET INT_FLAG = 0   #避免開窗按取消後誤判
   INITIALIZE g_qryparam.* TO NULL

   #RETURN p_module,p_progcode,p_progname,p_prog_class
   RETURN p_progcode,p_progname,p_prog_class
END FUNCTION


#+ 開窗-底稿程式代號
FUNCTION sadzp168_1_prog_draft_qry(p_qrystate,p_module,p_progcode,p_progname,p_where)
   DEFINE p_qrystate      STRING
   #DEFINE p_dzfq005       LIKE dzfq_t.dzfq005     #主/子程式
   DEFINE p_module        LIKE gzza_t.gzza003     #模組
   DEFINE p_progcode      LIKE dzfq_t.dzfq004     #程式代號
   DEFINE p_progname      LIKE gzzal_t.gzzal003   #程式名稱
   #DEFINE p_prog_class    LIKE gzza_t.gzza002     #程式類別
   DEFINE p_where         STRING

   INITIALIZE g_qryparam.* TO NULL
   LET g_qryparam.state = p_qrystate CLIPPED
   LET g_qryparam.reqry = FALSE

   LET g_qryparam.default1 = p_module CLIPPED         #模組
   LET g_qryparam.default2 = p_progcode CLIPPED       #程式代號
   LET g_qryparam.default3 = p_progname CLIPPED       #程式名稱
   LET g_qryparam.where = p_where CLIPPED             #限定r.a設計工具版號
   CALL q_dzfv004()

   LET p_module = g_qryparam.return1
   LET p_progcode = g_qryparam.return2
   LET p_progname = g_qryparam.return3

   LET INT_FLAG = 0   #避免開窗按取消後誤判
   LET g_qryparam.default1 = NULL
   LET g_qryparam.default2 = NULL
   LET g_qryparam.default3 = NULL
   INITIALIZE g_qryparam.where TO NULL

   RETURN p_module,p_progcode,p_progname
END FUNCTION

#+ 設定下拉式選單內容-主/子程式(M:主/S:子程式)
FUNCTION sadzp168_1_cb_dzfq005(p_comboname,p_type)
   DEFINE p_comboname     STRING                #ComboBox name
   DEFINE p_type          STRING                #adzp168用完整的M:主/S:子程式/F:子畫面, adzp169用M:主/S:子程式
   DEFINE l_sql           STRING
   DEFINE ls_values       STRING                #ComboBox values
   DEFINE ls_items        STRING                #ComboBox items
   DEFINE ls_items_pre    STRING                #多語言代碼前置名稱
   DEFINE l_gzzd003       LIKE gzzd_t.gzzd003   #多語言代碼
   DEFINE l_gzzd005       LIKE gzzd_t.gzzd005   #多語言名稱
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_str           STRING
   DEFINE l_default       LIKE dzfq_t.dzfq005   #ComboBox default value
   DEFINE l_itemarr       DYNAMIC ARRAY OF STRING

   LET l_default = NULL
   LET ls_items_pre = "cbo_dzfq005."

   CALL l_itemarr.clear()

   LET l_i = 1
   LET l_itemarr[l_i] = "M"
   LET l_i = l_i + 1
   LET l_itemarr[l_i] = "S"
   IF p_type = "adzp168" THEN 
      LET l_i = l_i + 1
      LET l_itemarr[l_i] = "F"
   END IF

   LET l_sql = "SELECT gzzd005 FROM gzzd_t WHERE gzzdstus = 'Y' AND gzzd001 = ? AND gzzd002 = ? AND gzzd003 = ? AND gzzd004 = ?"
   PREPARE sadzp168_1_cb_dzfq005_formlang_pre01 FROM l_sql

   FOR l_i = 1 TO l_itemarr.getLength()
      IF l_i = 1 THEN
         LET ls_values = l_itemarr[l_i] CLIPPED
         LET l_gzzd003 = ls_items_pre CLIPPED,l_itemarr[l_i] CLIPPED

         LET l_gzzd005 = NULL
         EXECUTE sadzp168_1_cb_dzfq005_formlang_pre01 INTO l_gzzd005 USING 'adzp168',g_lang,l_gzzd003,"c"
         IF cl_null(l_gzzd005) THEN
            EXECUTE sadzp168_1_cb_dzfq005_formlang_pre01 INTO l_gzzd005 USING 'adzp168',g_lang,l_gzzd003,"s"
            IF cl_null(l_gzzd005) THEN
               LET l_gzzd005 = l_itemarr[l_i] CLIPPED
            END IF
         END IF
         LET ls_items = l_itemarr[l_i] CLIPPED,".",l_gzzd005 CLIPPED

         LET l_default = l_itemarr[l_i] CLIPPED
      ELSE
         LET ls_values = ls_values CLIPPED, ",", l_itemarr[l_i] CLIPPED
         LET l_gzzd003 = ls_items_pre CLIPPED,l_itemarr[l_i] CLIPPED

         LET l_gzzd005 = NULL
         EXECUTE sadzp168_1_cb_dzfq005_formlang_pre01 INTO l_gzzd005 USING 'adzp168',g_lang,l_gzzd003,"c"
         IF cl_null(l_gzzd005) THEN
            EXECUTE sadzp168_1_cb_dzfq005_formlang_pre01 INTO l_gzzd005 USING 'adzp168',g_lang,l_gzzd003,"s"
            IF cl_null(l_gzzd005) THEN
               LET l_gzzd005 = l_itemarr[l_i] CLIPPED
            END IF
         END IF
         LET ls_items = ls_items CLIPPED, ",", l_itemarr[l_i] CLIPPED,".",l_gzzd005 CLIPPED
      END IF
   END FOR

   CALL cl_set_combo_items(p_comboname, ls_values, ls_items)

   RETURN l_default
END FUNCTION

#+ 程式類別,模組代碼,程式名稱
#模組代碼目前不需要回傳了,但會影響其他程式以後再修改 #todo
FUNCTION sadzp168_1_gzza002(p_dzfq004,p_dzfq005)
   DEFINE p_dzfq004         LIKE dzfq_t.dzfq004   #畫面代號
   DEFINE p_dzfq005         LIKE dzfq_t.dzfq005   #主/子程式
   DEFINE l_sql             STRING
   DEFINE l_gzza002         LIKE gzza_t.gzza002   #程式類別
   DEFINE l_gzza003         LIKE gzza_t.gzza003   #模組代碼
   DEFINE l_gzza003_module  LIKE gzza_t.gzza003   #實際模組
   DEFINE l_gzza011         LIKE gzza_t.gzza011   #是否客製
   DEFINE l_gzzal003        LIKE gzzal_t.gzzal003 #程式名稱
   DEFINE l_gzde005         LIKE gzde_t.gzde005   #程式類別
   DEFINE l_gzdel003        LIKE gzdel_t.gzdel003 #多語言檔說明

   CASE  #M:主/S:子程式
      WHEN p_dzfq005 = "M"   #主程式與畫面
         #資料來源作業azzi900
         #程式類別,模組代碼,是否客製
         LET l_sql = "SELECT gzza002,gzza003,gzza011 FROM gzza_t WHERE gzza001 = ?"
         PREPARE sadzp168_1_gzza002_pre01 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'PREPARE:'
            LET g_errparam.popup = FALSE
            CALL cl_err()
         END IF
         EXECUTE sadzp168_1_gzza002_pre01 USING p_dzfq004 INTO l_gzza002,l_gzza003,l_gzza011
         LET l_gzza002 = DOWNSHIFT(l_gzza002)

         #程式名稱
         LET l_sql = "SELECT gzzal003 FROM gzzal_t WHERE gzzal001 = ? AND gzzal002 = ?"
         PREPARE adzp168_gzzal003 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'PREPARE:'
            LET g_errparam.popup = FALSE
            CALL cl_err()
         END IF
         EXECUTE adzp168_gzzal003 USING p_dzfq004,g_lang INTO l_gzzal003

      WHEN p_dzfq005 MATCHES "[SBGXW]"   #子程式與畫面:r.a只會有"S"，但Jay處理畫面需要其他類別的
         #資料來源作業azzi901
         #程式類別,模組代碼,是否客製,程式名稱
         LET l_sql = "SELECT DISTINCT gzde005,gzde002,gzde008,gzdel003 FROM gzde_t",
                     " LEFT JOIN gzdel_t",
                     " ON gzde001 = gzdel001 AND gzdel002 = ?",
                     " WHERE gzdestus = 'Y' AND gzde001 = ?"
         PREPARE sadzp168_1_gzdel003_pre01 FROM l_sql
         IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = 'PREPARE:'
             LET g_errparam.popup = FALSE
             CALL cl_err()
         END IF

         EXECUTE sadzp168_1_gzdel003_pre01 USING g_lang,p_dzfq004 INTO l_gzde005,l_gzza003,l_gzza011,l_gzdel003
         LET l_gzza002 = l_gzde005
         LET l_gzzal003 = l_gzdel003
         LET l_gzza002 = DOWNSHIFT(l_gzza002)   #程式類別

      WHEN p_dzfq005 = "F"   #子畫面
         #資料來源作業azzi901
         #模組代碼,程式名稱,是否客製
         #客製環境下，子畫面附屬於AXM，實際模組應為CXM   # No.FUN-160520
         LET l_sql = "SELECT DISTINCT gzde002,gzdfl003,gzdf003 FROM gzde_t",
                     " LEFT JOIN gzdf_t",
                     " ON gzde001 = gzdf001",
                     " LEFT JOIN gzdfl_t",
                     " ON gzdf002 = gzdfl001 AND gzdfl002 = ?",
                     " WHERE gzdestus = 'Y' AND gzdf002 = ? AND gzde008 = ?"

         PREPARE sadzp168_1_gzdf002_pre01 FROM l_sql
         IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = 'PREPARE:'
             LET g_errparam.popup = FALSE
             CALL cl_err()
         END IF

         EXECUTE sadzp168_1_gzdf002_pre01 USING g_lang,p_dzfq004,ms_dgenv INTO l_gzza003,l_gzdel003,l_gzza011
         # 當客製標準畫面時：
         IF cl_null(l_gzza003) AND ms_dgenv = "c" THEN
            EXECUTE sadzp168_1_gzdf002_pre01 USING g_lang,p_dzfq004,"s" INTO l_gzza003,l_gzdel003,l_gzza011
         END IF
         LET l_gzzal003 = l_gzdel003

         #資料來源作業azzi900
         #改找主程式
         IF cl_null(l_gzza003) THEN
            #程式類別,模組代碼,是否客製,程式名稱
            #客製環境下，子畫面附屬於AXM，實際模組應為CXM   # No.FUN-160520 
            LET l_sql = "SELECT DISTINCT gzza002,gzza003,gzdf003,gzdfl003",
                        " FROM",
                        " (SELECT gzza002,gzza003,gzza011,gzza001,gzzastus,'M' AS gzde003  FROM gzza_t WHERE gzza011=?)",
                        " LEFT JOIN gzdf_t",
                        " ON gzza001 = gzdf001",
                        " LEFT JOIN gzdfl_t",
                        " ON gzdf002 = gzdfl001 AND gzdfl002 = ?",
                        " WHERE gzzastus = 'Y' AND gzdf002 IS NOT NULL AND gzdf002 = ?"
            PREPARE sadzp168_1_gzdf002_pre02 FROM l_sql
            IF SQLCA.sqlcode THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = SQLCA.sqlcode
                LET g_errparam.extend = 'PREPARE:'
                LET g_errparam.popup = FALSE
                CALL cl_err()
            END IF

            EXECUTE sadzp168_1_gzdf002_pre02 USING ms_dgenv,g_lang,p_dzfq004 INTO l_gzza002,l_gzza003,l_gzza011,l_gzdel003
            # 當客製標準畫面時：
            IF cl_null(l_gzza003) AND ms_dgenv = "c" THEN
               EXECUTE sadzp168_1_gzdf002_pre02 USING "s",g_lang,p_dzfq004 INTO l_gzza002,l_gzza003,l_gzza011,l_gzdel003
            END IF

            LET l_gzzal003 = l_gzdel003
            LET l_gzza002 = DOWNSHIFT(l_gzza002)   #程式類別
         END IF

         LET l_gzza002 = NULL    #子畫面不提供ToolBar,所以程式類別清空
   END CASE

   #若註冊資訊為客製,需透過gzzj_t找到實際的模組別,以AZZ為例:
   #若歸屬模組(gzzj003)相等， 但!= 實際模組(gzzj001), 表示是AZZ-->CZZ ,否則用原本模組就好(CZZ)
   IF l_gzza011 = "c" THEN   #標準為s;客製為c   #FUN-141006
      LET l_gzza003_module = sadzp062_1_translate_cust_module(l_gzza003)
   ELSE
      LET l_gzza003_module = l_gzza003 CLIPPED
   END IF
   
   #程式類別,模組代碼,實際模組,程式名稱
   RETURN l_gzza002,l_gzza003,l_gzza003_module,l_gzzal003
END FUNCTION

#+ 取得設計工具版號
#    因工具的功能改變或畫面公版改變，皆可能導致舊的底稿無法使用，所以用此判斷。
FUNCTION sadzp168_1_ver_ra()
   DEFINE l_ver_ra        LIKE dzfv_t.dzfv001   #設計工具版號

   LET l_ver_ra = "201308281420"   #年月日時分
   RETURN l_ver_ra
END FUNCTION

############################################################
#+ @code
#+ 函式目的  動態設定有選擇SCC資料的ComboBox選項,不顯示value
#+ @param    ps_field_name  STRING
############################################################
FUNCTION sadzp168_1_set_combo_scc(ps_field_name,pc_gzca001)
  DEFINE ps_values           STRING
  DEFINE ps_items            STRING
  DEFINE ps_field_name       STRING
  DEFINE pc_gzca001          LIKE gzca_t.gzca001      #系統分類碼
  DEFINE pc_gzcbl002         LIKE gzcbl_t.gzcbl002    #系統分類值
  DEFINE pc_gzcbl004         LIKE gzcbl_t.gzcbl004    #說明
  DEFINE ps_gzcb002          STRING

  WHENEVER ERROR CALL cl_err_msg_log

  SELECT gzca001 INTO pc_gzca001 FROM gzca_t
     WHERE  gzca001 = pc_gzca001 AND gzcastus='Y'
     IF cl_null(pc_gzca001) THEN
     ELSE
        DECLARE p_scc_item_cs CURSOR FOR
        SELECT gzcb002, gzcbl004
         FROM gzcb_t
           LEFT JOIN gzcbl_t ON gzcb002 = gzcbl002
             AND gzcb001 = gzcbl001
             AND gzcb001 = pc_gzca001
             AND gzcbl003 = g_dlang
         WHERE gzcb001 IN (SELECT gzcb001
                            FROM gzcb_t
                             WHERE gzcb001 = pc_gzca001)
         ORDER BY gzcbl002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  "lib-045"
         LET g_errparam.extend = "gzcb_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN
      END IF

      LET ps_values = ''
      LET ps_items = ''

      #在gzcb001和gzcb002原本空白處加入冒號(:)
      FOREACH p_scc_item_cs INTO pc_gzcbl002, pc_gzcbl004
         LET ps_gzcb002 = pc_gzcbl002 #項目
         LET ps_values = ps_values, pc_gzcbl002, ',' #值
         LET ps_items = ps_items, pc_gzcbl004 CLIPPED, ',' #items
      END FOREACH
      LET ps_values = ps_values.subString(1, ps_values.getLength() - 1)
      LET ps_items = ps_items.subString(1, ps_items.getLength() - 1)
      CALL cl_set_combo_items(ps_field_name, ps_values, ps_items)
   END IF
END FUNCTION

############################################################
#+ @code
#+ 函式目的  樹狀結構類別動態設定有選擇SCC資料的ComboBox選項,不顯示value,依條件設定內容
#+ @param    ps_field_name  STRING
############################################################
FUNCTION sadzp168_1_set_combo_scc_dzfq016(ps_field_name,pc_gzca001)
  DEFINE ps_values           STRING
  DEFINE ps_items            STRING
  DEFINE ps_field_name       STRING
  DEFINE pc_gzca001          LIKE gzca_t.gzca001      #系統分類碼
  DEFINE pc_gzcbl002         LIKE gzcbl_t.gzcbl002    #系統分類值
  DEFINE pc_gzcbl004         LIKE gzcbl_t.gzcbl004    #說明
  DEFINE ps_gzcb002          STRING

  WHENEVER ERROR CALL cl_err_msg_log

  SELECT gzca001 INTO pc_gzca001 FROM gzca_t
     WHERE  gzca001 = pc_gzca001 AND gzcastus='Y'
     IF cl_null(pc_gzca001) THEN
     ELSE
        DECLARE p_scc_item_dzfq016_cs CURSOR FOR
        SELECT gzcb002, gzcbl004
         FROM gzcb_t
           LEFT JOIN gzcbl_t ON gzcb002 = gzcbl002
             AND gzcb001 = gzcbl001
             AND gzcb001 = pc_gzca001
             AND gzcbl003 = g_dlang
         WHERE gzcb001 IN (SELECT gzcb001
                            FROM gzcb_t
                             WHERE gzcb001 = pc_gzca001)
         ORDER BY gzcbl002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  "lib-045"
         LET g_errparam.extend = "gzcb_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN
      END IF

      LET ps_values = ''
      LET ps_items = ''

      #在gzcb001和gzcb002原本空白處加入冒號(:)
      FOREACH p_scc_item_dzfq016_cs INTO pc_gzcbl002, pc_gzcbl004
         LET ps_gzcb002 = pc_gzcbl002 CLIPPED   #項目

         IF sadzp168_1_dzfq016_chk(pc_gzcbl002,FALSE) THEN
            LET ps_values = ps_values, pc_gzcbl002, ',' #值
            LET ps_items = ps_items, pc_gzcbl004 CLIPPED, ',' #items
         END IF
      END FOREACH
      LET ps_values = ps_values.subString(1, ps_values.getLength() - 1)
      LET ps_items = ps_items.subString(1, ps_items.getLength() - 1)
      CALL cl_set_combo_items(ps_field_name, ps_values, ps_items)
   END IF
END FUNCTION

#刪除r.a的畫面設計資料-包含底稿
FUNCTION sadzp168_1_del(p_formcode)
   DEFINE p_formcode      LIKE dzfq_t.dzfq004
   DEFINE l_sql           STRING
   DEFINE l_chk           BOOLEAN

   LET l_chk = TRUE 

   #刪除r.a的畫面設計資料
   CALL sadzp168_1_del01(p_formcode) RETURNING l_chk
   #刪除r.a的畫面設計資料-底稿
   IF l_chk THEN
      CALL sadzp168_1_del02(p_formcode) RETURNING l_chk
   END IF

   RETURN l_chk
END FUNCTION 

#刪除r.a的畫面設計資料
FUNCTION sadzp168_1_del01(p_formcode)
   DEFINE p_formcode      LIKE dzfq_t.dzfq004
   DEFINE l_sql           STRING
   DEFINE l_chk           BOOLEAN

   LET l_chk = TRUE 
   
   #dzfq_t 畫面結構設計主檔
   LET l_sql = "DELETE FROM dzfq_t WHERE dzfq004 = ?"
   PREPARE sadzp168_1_del_dzfq_pre FROM l_sql
   EXECUTE sadzp168_1_del_dzfq_pre USING p_formcode
   IF SQLCA.sqlcode THEN
      LET l_chk = FALSE
   END IF
   #dzfr_t 畫面結構設計內容檔
   IF l_chk THEN 
      LET l_sql = "DELETE FROM dzfr_t WHERE dzfr002 = ?"
      PREPARE sadzp168_1_del_dzfr_pre FROM l_sql
      EXECUTE sadzp168_1_del_dzfr_pre USING p_formcode
      IF SQLCA.sqlcode THEN
         LET l_chk = FALSE
      END IF
   END IF 

   RETURN l_chk
END FUNCTION 

#刪除r.a的畫面設計資料-底稿
FUNCTION sadzp168_1_del02(p_formcode)
   DEFINE p_formcode      LIKE dzfq_t.dzfq004
   DEFINE l_sql           STRING
   DEFINE l_chk           BOOLEAN

   LET l_chk = TRUE 
      
   #dzfv_t 畫面結構設計主檔底稿
   IF l_chk THEN 
      LET l_sql = "DELETE FROM dzfv_t WHERE dzfv004 = ?"
      PREPARE sadzp168_1_del_dzfv_pre FROM l_sql
      EXECUTE sadzp168_1_del_dzfv_pre USING p_formcode
      IF SQLCA.sqlcode THEN
         LET l_chk = FALSE
      END IF
   END IF 
   #dzfw_t 樹狀結構屬性設定檔底稿
   IF l_chk THEN 
      LET l_sql = "DELETE FROM dzfw_t WHERE dzfw003 = ?"
      PREPARE sadzp168_1_del_dzfw_pre FROM l_sql
      EXECUTE sadzp168_1_del_dzfw_pre USING p_formcode
      IF SQLCA.sqlcode THEN
         LET l_chk = FALSE
      END IF
   END IF 
   #dzfx_t 規格Table設定表底稿
   IF l_chk THEN 
      LET l_sql = "DELETE FROM dzfx_t WHERE dzfx003 = ?"
      PREPARE sadzp168_1_del_dzfx_pre FROM l_sql
      EXECUTE sadzp168_1_del_dzfx_pre USING p_formcode
      IF SQLCA.sqlcode THEN
         LET l_chk = FALSE
      END IF
   END IF 
   #dzfy_t 畫面樣版ToolBar功能鍵設定檔底稿(只記錄已勾選)
   IF l_chk THEN 
      LET l_sql = "DELETE FROM dzfy_t WHERE dzfy003 = ?"
      PREPARE sadzp168_1_del_dzfy_pre FROM l_sql
      EXECUTE sadzp168_1_del_dzfy_pre USING p_formcode
      IF SQLCA.sqlcode THEN
         LET l_chk = FALSE
      END IF
   END IF 
   #dzfz_t 畫面結構設計內容檔底稿
   IF l_chk THEN 
      LET l_sql = "DELETE FROM dzfz_t WHERE dzfz003 = ?"
      PREPARE sadzp168_1_del_dzfz_pre FROM l_sql
      EXECUTE sadzp168_1_del_dzfz_pre USING p_formcode
      IF SQLCA.sqlcode THEN
         LET l_chk = FALSE
      END IF
   END IF 

   RETURN l_chk
END FUNCTION 

#Tree設定 ---------------------------------- START
#+ 樹狀結構類別預設可設定的屬性字串組
FUNCTION sadzp168_1_dzff_default_str(p_dzff003,p_dzfq016)
   DEFINE p_dzff003       LIKE dzff_t.dzff003     #4fd tag name (s_browse,s_detail1)
   DEFINE p_dzfq016       LIKE dzfq_t.dzfq016     #樹狀結構類別
   DEFINE l_dzff_att      STRING                  #樹狀結構可以設定的屬性

   LET l_dzff_att = ""
   CASE p_dzfq016
      WHEN "ALL"
         LET l_dzff_att = "type,type2,type3,type4,type5,type6,id,pid,desc,speed,stype,sid,spid"
      WHEN "recu_01"
         LET l_dzff_att = "type,id,pid,desc,speed,stype,sid,spid"
      WHEN "recu_02"
         LET l_dzff_att = "type,id,pid,desc"   #2013/09/23 柏榕:支援type
      WHEN "type_01"
         LET l_dzff_att = "type,type2,type3,type4,type5,type6,id,desc"
   END CASE

   RETURN l_dzff_att
END FUNCTION

#+ 樹狀結構類別預設可設定的屬性
FUNCTION sadzp168_1_dzff_default(p_dzff003,p_dzfq016)
   DEFINE p_dzff003       LIKE dzff_t.dzff003     #4fd tag name (s_browse,s_detail1)
   DEFINE p_dzfq016       LIKE dzfq_t.dzfq016     #樹狀結構類別
   DEFINE l_dzff_att      STRING                  #樹狀結構可以設定的屬性
   DEFINE l_dzff005_sql   STRING                  #樹狀結構可以設定的屬性SQL條件
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_tok           base.StringTokenizer
   DEFINE l_str           STRING

   #樹狀結構類別(recu_01:遞迴單檔樹狀/ recu_02:遞迴主從表樹狀/ type_01:階層分類樹狀)
   CALL g_dzff_default.clear()

   CALL sadzp168_1_dzff_default_str(p_dzff003,p_dzfq016) RETURNING l_dzff_att

   LET l_i = 0
   LET l_dzff005_sql = ""  #樹狀結構可以設定的屬性SQL條件
   LET l_tok = base.StringTokenizer.createExt(l_dzff_att CLIPPED,",","",TRUE)	#指定分隔符號
   WHILE l_tok.hasMoreTokens()	#依序取得子字串
      LET l_str = l_tok.nextToken()
      LET l_i = l_i + 1
      LET g_dzff_default[l_i].dzff005 = l_str CLIPPED

      IF cl_null(l_dzff005_sql) THEN
         LET l_dzff005_sql = "'",l_str CLIPPED,"'"
      ELSE
         LET l_dzff005_sql = l_dzff005_sql CLIPPED,",'",l_str CLIPPED,"'"
      END IF
   END WHILE

   LET l_cnt = g_dzff_default.getLength()
   FOR l_i = 1 TO l_cnt
      LET g_dzff_default[l_i].dzff001 = g_dzfq_m.dzfq004 CLIPPED
      LET g_dzff_default[l_i].dzff002 = g_ver_dzag003 CLIPPED
      LET g_dzff_default[l_i].dzff003 = p_dzff003 CLIPPED
      LET g_dzff_default[l_i].dzff004 = l_i

      #IF g_dzff_default[l_i].dzff005 = "id" OR g_dzff_default[l_i].dzff005 = "pid" THEN
      #   LET g_dzff_default[l_i].dzff006 = g_tableid CLIPPED
      #END IF

      IF cl_null(g_dzff_default[l_i].dzff006) THEN
         LET g_dzff_default[l_i].dzff006 = ""   #資料表代碼
      END IF
      IF cl_null(g_dzff_default[l_i].dzff007) THEN
         LET g_dzff_default[l_i].dzff007 = ""   #欄位代號
      END IF

      LET g_dzff_default[l_i].dzff008 = ms_dgenv CLIPPED
      #LET g_dzff_default[l_i].dzff009 = p_dzfq016
   END FOR

END FUNCTION

#+ 檢查樹狀結構類別
FUNCTION sadzp168_1_dzfq016_chk(p_dzfq016,p_showmsg)
   DEFINE p_dzfq016       LIKE dzfq_t.dzfq016     #樹狀結構類別
   DEFINE p_showmsg       BOOLEAN                 #是否顯示訊息
   DEFINE l_chk           BOOLEAN
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_max_level     LIKE type_t.num5
   DEFINE l_scc_name      LIKE gzcbl_t.gzcbl004

   LET l_chk = TRUE

   #table max level
   LET l_cnt = g_tbtree.getLength()
   LET l_max_level = 0
   FOR l_i = 1 TO l_cnt
      IF l_i = 1 OR l_max_level < g_tbtree[l_i].b_level THEN
         LET l_max_level = g_tbtree[l_i].b_level
      END IF
   END FOR

   #recu_01:遞迴單檔樹狀/ recu_02:遞迴主從表樹狀/ type_01:階層分類樹狀
   SELECT gzcbl004 INTO l_scc_name FROM gzcbl_t WHERE gzcbl001 = 115 AND gzcbl002 = p_dzfq016 AND gzcbl003 = g_lang
   IF l_max_level < 2 THEN   #沒有子資料表
      IF p_dzfq016 = "recu_02" THEN   #遞迴主從表樹狀
         LET l_chk = FALSE
         IF p_showmsg THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00054"
            LET g_errparam.extend = NULL
            LET g_errparam.popup = TRUE
            CALL cl_err()
         END IF
      END IF
   ELSE
      IF p_dzfq016 = "type_01" THEN   #遞迴主從表樹狀
         LET l_chk = FALSE
         IF p_showmsg THEN
            #CALL cl_err_msg(NULL, "adz-00054", l_scc_name CLIPPED, 0)   #需要有單身資料表 請選擇單頭資料表,並加入單身資料表
         END IF
      END IF
   END IF

   RETURN l_chk
END FUNCTION

#+ 檢查樹狀結構設定
FUNCTION sadzp168_1_dzff_chk(p_init,p_dzff003,p_dzfq016)
   DEFINE p_init          BOOLEAN                 #預設值是否初始化
   DEFINE p_dzff003       LIKE dzff_t.dzff003     #4fd tag name (s_browse,s_detail1)
   DEFINE p_dzfq016       LIKE dzfq_t.dzfq016     #樹狀結構類別
   DEFINE l_chk           BOOLEAN
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_j             LIKE type_t.num5
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_cnt_def       LIKE type_t.num5   #for g_dzff_default
   DEFINE l_cnt_arr       LIKE type_t.num5   #for g_dzff_d
   DEFINE l_cnt_tb        LIKE type_t.num5   #for g_tbtree
   DEFINE l_exist         BOOLEAN
   DEFINE l_str           STRING
   DEFINE l_msg           STRING
   DEFINE l_sql           STRING
   DEFINE l_scc_name      LIKE gzcbl_t.gzcbl004
   DEFINE l_table01       LIKE dzff_t.dzff006
   DEFINE l_table02       LIKE dzff_t.dzff006
   DEFINE l_gzzd005       LIKE gzzd_t.gzzd005   #畫面元件多語言
   DEFINE l_type_arr      DYNAMIC ARRAY OF RECORD
             dzff005   LIKE dzff_t.dzff005,
             dzff007   LIKE dzff_t.dzff007
             END RECORD

   IF p_init THEN #預設值是否初始化
      CALL sadzp168_1_dzff_default(p_dzff003,p_dzfq016)
   END IF

   LET l_cnt_def = g_dzff_default.getLength()
   LET l_cnt_arr = g_dzff_d.getLength()
   LET l_cnt_tb = g_tbtree.getLength()
   LET l_str = ""
   SELECT gzcbl004 INTO l_scc_name FROM gzcbl_t WHERE gzcbl001 = 115 AND gzcbl002 = p_dzfq016 AND gzcbl003 = g_lang

   LET l_sql = "SELECT gzzd005 FROM gzzd_t WHERE gzzdstus = 'Y' AND gzzd001 = ? AND gzzd002 = ? AND gzzd003 = ? AND gzzd004 = ?"
   PREPARE sadzp168_1_dzff_chk_formlang_pre FROM l_sql

   #檢查屬性設定是否有缺
   IF l_cnt_def >= l_cnt_arr THEN
      FOR l_i = 1 TO l_cnt_def
         LET l_exist = FALSE
         FOR l_j = 1 TO l_cnt_arr
            IF g_dzff_default[l_i].dzff001 = g_dzff_d[l_j].dzff001 AND
               g_dzff_default[l_i].dzff002 = g_dzff_d[l_j].dzff002 AND
               g_dzff_default[l_i].dzff003 = g_dzff_d[l_j].dzff003 AND
               g_dzff_default[l_i].dzff005 = g_dzff_d[l_j].dzff005 THEN

               LET l_exist = TRUE
               EXIT FOR
            END IF
         END FOR

         IF NOT l_exist THEN
            IF cl_null(l_str) THEN
               LET l_str = g_dzff_default[l_i].dzff005 CLIPPED
            ELSE
               LET l_str = l_str CLIPPED,",",g_dzff_default[l_i].dzff005 CLIPPED
            END IF
         END IF
      END FOR

      IF NOT cl_null(l_str) THEN
         LET l_chk = FALSE
         #LET l_msg = l_scc_name CLIPPED,"|",l_str CLIPPED
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  "adz-00178"
         LET g_errparam.extend = NULL
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = l_scc_name
         LET g_errparam.replace[2] = l_str
         CALL cl_err()
      ELSE
         LET l_chk = TRUE
      END IF

   #檢查屬性設定是否有多
   ELSE
      FOR l_i = 1 TO l_cnt_arr
         LET l_exist = FALSE
         FOR l_j = 1 TO l_cnt_def
            IF g_dzff_d[l_i].dzff001 = g_dzff_default[l_j].dzff001 AND
               g_dzff_d[l_i].dzff002 = g_dzff_default[l_j].dzff002 AND
               g_dzff_d[l_i].dzff003 = g_dzff_default[l_j].dzff003 AND
               g_dzff_d[l_i].dzff005 = g_dzff_default[l_j].dzff005 AND
               ( NOT cl_null(g_dzff_d[l_j].dzff006) ) THEN

               LET l_exist = TRUE
               EXIT FOR
            END IF
         END FOR

         IF NOT l_exist THEN
            IF cl_null(l_str) THEN
               LET l_str = g_dzff_d[l_i].dzff005 CLIPPED
            ELSE
               LET l_str = l_str CLIPPED,",",g_dzff_d[l_i].dzff005 CLIPPED
            END IF
         END IF
      END FOR

      IF NOT cl_null(l_str) THEN
         LET l_chk = FALSE
         #LET l_msg = l_scc_name CLIPPED,"|",l_str CLIPPED
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  "adz-00179"
         LET g_errparam.extend = NULL
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = l_scc_name
         LET g_errparam.replace[1] = l_str
         CALL cl_err()
      ELSE
         LET l_chk = TRUE
      END IF
   END IF


   #依樹狀結構類別檢查必填欄位
   IF l_chk THEN
      LET l_msg = ""
      FOR l_i = 1 TO l_cnt_arr
         IF g_dzff_d[l_i].dzff005 = "desc" THEN   #非必填
            CONTINUE FOR
         END IF

         CASE p_dzfq016   #樹狀結構類別(recu_01:遞迴單檔樹狀/ recu_02:遞迴主從表樹狀/ type_01:階層分類樹狀)
            WHEN "recu_01"
               LET l_str = g_dzff_d[l_i].dzff005
               IF l_str.getIndexOf("type" ,1) THEN    #非必填type,stype
                  CONTINUE FOR
               END IF

            WHEN "recu_02"
               LET l_str = g_dzff_d[l_i].dzff005
               IF l_str.getIndexOf("type" ,1) THEN    #非必填type
                  CONTINUE FOR
               END IF

            WHEN "type_01"
               LET l_str = g_dzff_d[l_i].dzff005
               #非必填type2 ~ type6
               IF g_dzff_d[l_i].dzff005 <> "type" AND l_str.getIndexOf("type" ,1) THEN
                  CONTINUE FOR
               END IF
         END CASE

         IF cl_null(g_dzff_d[l_i].dzff006) THEN
            IF cl_null(l_msg) THEN
               LET l_msg = g_dzff_d[l_i].dzff005 CLIPPED
            ELSE
               LET l_msg = l_msg CLIPPED,",",g_dzff_d[l_i].dzff005 CLIPPED
            END IF
         END IF
      END FOR

      IF NOT cl_null(l_msg) THEN
         LET l_chk = FALSE
         LET l_msg = l_scc_name CLIPPED,"|",l_msg CLIPPED
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  "adz-00178"
         LET g_errparam.extend = NULL
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = l_scc_name
         LET g_errparam.replace[2] = l_msg
         CALL cl_err()
      ELSE
         LET l_chk = TRUE
      END IF
   END IF

   #畫面中是否使用此資料表,檢查基本資料
   IF l_chk THEN
      #資料表主檔cnt
      LET l_sql = "SELECT COUNT(dzea001) FROM dzea_t WHERE dzea001 = ?"
      PREPARE sadzp168_1_dzea_cnt_pre FROM l_sql

      LET l_str = ""
      LET l_msg = ""
      FOR l_i = 1 TO l_cnt_arr
         IF NOT cl_null(g_dzff_d[l_i].dzff006) THEN
            EXECUTE sadzp168_1_dzea_cnt_pre USING g_dzff_d[l_i].dzff006 INTO l_cnt
            IF l_cnt = 0 THEN
               LET l_chk = FALSE

               LET l_gzzd005 = NULL
               EXECUTE sadzp168_1_dzff_chk_formlang_pre INTO l_gzzd005 USING 'adzp168_01',g_lang,'lbl_dzff006',"c"
               IF cl_null(l_gzzd005) THEN
                  EXECUTE sadzp168_1_dzff_chk_formlang_pre INTO l_gzzd005 USING 'adzp168_01',g_lang,'lbl_dzff006',"s"
               END IF
               LET l_msg = l_gzzd005 CLIPPED,":",g_dzff_d[l_i].dzff006 CLIPPED
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  "adz-00050"
               LET g_errparam.extend = NULL
               LET g_errparam.popup = TRUE
               LET g_errparam.replace[1] =  l_msg
               CALL cl_err()
               LET l_msg = ""   #後面的訊息不顯示

               EXIT FOR
            ELSE
               LET l_exist = FALSE
               LET l_str = g_dzff_d[l_i].dzff005
               IF l_str.getIndexOf("s",1) <> 1 THEN
                  FOR l_j = 1 TO l_cnt_tb
                     IF g_dzff_d[l_i].dzff006 = g_tbtree[l_j].b_tableid THEN
                        LET l_exist = TRUE
                        EXIT FOR
                     END IF
                  END FOR

                  IF NOT l_exist THEN
                     LET l_msg = g_dzff_d[l_i].dzff006 CLIPPED
                     EXIT FOR
                  END IF
               END IF
            END IF
         END IF
      END FOR

      IF NOT cl_null(l_msg) THEN
         LET l_chk = FALSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  "adz-00083"
         LET g_errparam.extend = NULL
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] =  l_msg CLIPPED
         CALL cl_err()
      END IF
   END IF

   #遞迴主從表樹狀的id和pid不可設相同資料表
   IF l_chk THEN
      IF p_dzfq016 = "recu_02" THEN   #遞迴主從表樹狀
         LET l_table01 = ""
         LET l_table02 = ""
         FOR l_i = 1 TO l_cnt_arr
            CASE g_dzff_d[l_i].dzff005
               WHEN "id"
                  LET l_table01 = g_dzff_d[l_i].dzff006
               WHEN "pid"
                  LET l_table02 = g_dzff_d[l_i].dzff006
            END CASE
         END FOR
         IF l_table01 = l_table02 THEN
            LET l_chk = FALSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00180"
            LET g_errparam.extend = NULL
            LET g_errparam.popup = TRUE
            CALL cl_err()
         END IF
      END IF
   END IF

   #提速檔各屬性的資料表須和speed一致
   IF l_chk THEN
      LET l_str = ""
      LET l_msg = ""
      LET l_table01 = ""
      LET l_table02 = ""

      FOR l_i = 1 TO l_cnt_arr
         IF NOT cl_null(g_dzff_d[l_i].dzff006) AND g_dzff_d[l_i].dzff005 = "speed" THEN
            LET l_table01 = g_dzff_d[l_i].dzff006
            EXIT FOR
         END IF
      END FOR

      IF NOT cl_null(l_table01) THEN
         FOR l_i = 1 TO l_cnt_arr
            LET l_str = g_dzff_d[l_i].dzff005
            IF l_str.getIndexOf("s" ,1) = 1 AND (NOT cl_null(g_dzff_d[l_i].dzff006)) THEN
               IF g_dzff_d[l_i].dzff006 <> l_table01 THEN
                  IF cl_null(l_msg) THEN
                     LET l_msg = g_dzff_d[l_i].dzff005 CLIPPED
                  ELSE
                     LET l_msg = l_msg CLIPPED,",",g_dzff_d[l_i].dzff005 CLIPPED
                  END IF
               END IF
            END IF
         END FOR
      END IF

      IF NOT cl_null(l_msg) THEN
         LET l_chk = FALSE
         #LET l_msg = l_msg CLIPPED,"|",l_table01 CLIPPED
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  "adz-00181"
         LET g_errparam.extend = NULL
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = l_msg
         LET g_errparam.replace[2] = l_table01
         CALL cl_err()
      END IF
   END IF

   #有設資料表就要設欄位,speed除外
   IF l_chk THEN
      LET l_msg = ""

      FOR l_i = 1 TO l_cnt_arr
         IF NOT cl_null(g_dzff_d[l_i].dzff006) AND cl_null(g_dzff_d[l_i].dzff007) AND g_dzff_d[l_i].dzff005 <> "speed" THEN
            IF cl_null(l_msg) THEN
               LET l_msg = g_dzff_d[l_i].dzff005 CLIPPED
            ELSE
               LET l_msg = l_msg CLIPPED,",",g_dzff_d[l_i].dzff005 CLIPPED
            END IF
         END IF
      END FOR

      IF NOT cl_null(l_msg) THEN
         LET l_chk = FALSE

         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  "adz-00015"
         LET g_errparam.extend = NULL
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] =  l_msg CLIPPED
         CALL cl_err()
      END IF
   END IF

   #檢查欄位基本資料
   IF l_chk THEN
      LET l_str = ""
      LET l_msg = ""

      #欄位主檔cnt
      LET l_sql = "SELECT COUNT(dzeb001) FROM dzeb_t WHERE dzeb001 = ? AND dzeb002 = ?"
      PREPARE sadzp168_1_dzeb_cnt_pre01 FROM l_sql

      FOR l_i = 1 TO l_cnt_arr
         IF NOT cl_null(g_dzff_d[l_i].dzff007) THEN
            EXECUTE sadzp168_1_dzeb_cnt_pre01 USING g_dzff_d[l_i].dzff006,g_dzff_d[l_i].dzff007 INTO l_cnt
            IF l_cnt = 0 THEN
               IF cl_null(l_msg) THEN
                  LET l_msg = g_dzff_d[l_i].dzff007 CLIPPED
               ELSE
                  LET l_msg = l_msg CLIPPED,",",g_dzff_d[l_i].dzff007 CLIPPED
               END IF
            END IF
         END IF
      END FOR

      IF NOT cl_null(l_msg) THEN
         LET l_chk = FALSE

         LET l_gzzd005 = NULL
         EXECUTE sadzp168_1_dzff_chk_formlang_pre INTO l_gzzd005 USING 'adzp168_01',g_lang,'lbl_dzff007',"c"
         IF cl_null(l_gzzd005) THEN
            EXECUTE sadzp168_1_dzff_chk_formlang_pre INTO l_gzzd005 USING 'adzp168_01',g_lang,'lbl_dzff007',"s"
         END IF
         LET l_msg = l_gzzd005 CLIPPED,":",l_msg
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  "adz-00050"
         LET g_errparam.extend = NULL
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] =  l_msg CLIPPED
         CALL cl_err()
      END IF
   END IF

   #不可設定重複的欄位 (ex.pid,id,type的欄位都不可相同,desc除外)
   IF l_chk THEN
      LET l_msg = ""

      FOR l_i = 1 TO l_cnt_arr
         IF g_dzff_d[l_i].dzff005 <> "desc" THEN
            FOR l_j = 1 TO l_cnt_arr
               IF l_j <> l_i AND
                  g_dzff_d[l_j].dzff005 <> "desc" AND
                  g_dzff_d[l_j].dzff005 <> g_dzff_d[l_i].dzff005 AND
                  g_dzff_d[l_j].dzff006 = g_dzff_d[l_i].dzff006 AND g_dzff_d[l_j].dzff007 = g_dzff_d[l_i].dzff007 THEN

                  LET l_msg = g_dzff_d[l_i].dzff005 CLIPPED,",",g_dzff_d[l_j].dzff005
                  EXIT FOR
               END IF
            END FOR
         END IF
      END FOR

      IF NOT cl_null(l_msg) THEN
         LET l_chk = FALSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  "adz-00182"
         LET g_errparam.extend = NULL
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] =  l_msg
         CALL cl_err()
      END IF
   END IF

   #有設定type則必須設stype
   IF l_chk THEN
      LET l_str = ""
      LET l_msg = ""
      LET l_table01 = ""
      LET l_table02 = ""
      LET l_exist = FALSE

      FOR l_i = 1 TO l_cnt_arr
         IF NOT cl_null(g_dzff_d[l_i].dzff006) AND g_dzff_d[l_i].dzff005 = "type" THEN
            LET l_table01 = g_dzff_d[l_i].dzff006
            EXIT FOR
         END IF
      END FOR

      FOR l_i = 1 TO l_cnt_arr
         IF g_dzff_d[l_i].dzff005 = "stype" THEN
            LET l_exist = TRUE   #有stype

            IF NOT cl_null(g_dzff_d[l_i].dzff006) THEN
               LET l_table02 = g_dzff_d[l_i].dzff006
               EXIT FOR
            END IF
         END IF
      END FOR

      IF l_exist THEN
         IF ( cl_null(l_table01) AND (NOT cl_null(l_table02)) ) OR
            ( (NOT cl_null(l_table01)) AND cl_null(l_table02) ) THEN

            LET l_chk = FALSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00183"
            LET g_errparam.extend = NULL
            LET g_errparam.popup = TRUE
            CALL cl_err()
         END IF
      END IF
   END IF

   #type ~ type6不可跳號設定
   IF l_chk THEN
      LET l_str = ""
      LET l_msg = ""
      CALL l_type_arr.clear()

      LET l_cnt = 0
      FOR l_i = 1 TO l_cnt_arr
         LET l_str = g_dzff_d[l_i].dzff005
         IF l_str.getIndexOf("type" ,1) THEN
            LET l_cnt = l_cnt + 1
            LET l_type_arr[l_cnt].dzff005 = g_dzff_d[l_i].dzff005   #屬性
            LET l_type_arr[l_cnt].dzff007 = g_dzff_d[l_i].dzff007   #欄位代號
         END IF
      END FOR

      IF l_cnt > 0 THEN
         FOR l_i = l_cnt TO 1 STEP -1
            IF NOT cl_null(l_type_arr[l_i].dzff007) THEN
               #檢查前一個type的欄位是否為空值
               LET l_j = l_i - 1
               IF l_j > 0 THEN
                  IF cl_null(l_type_arr[l_j].dzff007) THEN
                     LET l_chk = FALSE
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code =  "adz-00184"
                     LET g_errparam.extend = NULL
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     EXIT FOR
                  END IF
               END IF
            END IF
         END FOR
      END IF
   END IF

   RETURN l_chk
END FUNCTION
#Tree設定 ---------------------------------- END



