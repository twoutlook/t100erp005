#該程式未解開Section, 採用最新樣板產出!
{<section id="asft301_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2014-02-13 00:00:00), PR版次:0002(2017-01-06 16:06:41)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000115
#+ Filename...: asft301_02
#+ Description: Check in專案維護
#+ Creator....: 01258(2014-02-12 16:57:00)
#+ Modifier...: 01258 -SD/PR- 00700
 
{</section>}
 
{<section id="asft301_02.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"
#170104-00066#2   2017/01/06  By Rainy       筆數相關變數由num5放大至num10
#end add-point
#add-point:填寫註解說明(客製用) name="main.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="main.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
{</section>}
 
{<section id="asft301_02.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
{<Module define>}
{</Module define>}
#end add-point
 
{</section>}
 
{<section id="asft301_02.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_sfcddocno            LIKE sfcd_t.sfcddocno
DEFINE g_sfcd001              LIKE sfcd_t.sfcd001
DEFINE g_sfcd002              LIKE sfcd_t.sfcd002
DEFINE g_sfcb003              LIKE sfcb_t.sfcb003
DEFINE g_sfcb004              LIKE sfcb_t.sfcb004
DEFINE g_sfcb003_desc         LIKE oocql_t.oocql004
DEFINE g_type1                LIKE type_t.chr1
DEFINE g_sql                  STRING
DEFINE g_forupd_sql           STRING
DEFINE l_ac                   LIKE type_t.num10       #170104-00066#2 num5->num10  17/01/06 mod by rainy
DEFINE g_rec_b                LIKE type_t.num10       #170104-00066#2 num5->num10  17/01/06 mod by rainy
DEFINE g_sfcd                 DYNAMIC ARRAY OF RECORD
       sfcd003                LIKE sfcd_t.sfcd003,
       sfcd003_desc           LIKE oocql_t.oocql004,
       sfcd004                LIKE sfcd_t.sfcd004,
       sfcd005                LIKE sfcd_t.sfcd005,
       sfcd006                LIKE sfcd_t.sfcd006,
       sfcd007                LIKE sfcd_t.sfcd007,
       sfcd008                LIKE sfcd_t.sfcd008
                              END RECORD
DEFINE g_sfcd_t               RECORD
       sfcd003                LIKE sfcd_t.sfcd003,
       sfcd003_desc           LIKE oocql_t.oocql004,
       sfcd004                LIKE sfcd_t.sfcd004,
       sfcd005                LIKE sfcd_t.sfcd005,
       sfcd006                LIKE sfcd_t.sfcd006,
       sfcd007                LIKE sfcd_t.sfcd007,
       sfcd008                LIKE sfcd_t.sfcd008
                              END RECORD
DEFINE g_ref_fields           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
#end add-point
 
{</section>}
 
{<section id="asft301_02.other_dialog" >}

 
{</section>}
 
{<section id="asft301_02.other_function" readonly="Y" >}
################################################################################
# Descriptions...: Check in/Check out项目资料维护
# Memo...........:
# Usage..........: CALL asft301_02(p_sfcddocno,p_sfcd001,p_sfcd002,p_type1,p_type2)
# Input parameter: 1.p_sfcddocno               LIKE sfcd_t.sfcddocno
#                : 2.p_sfcd001                 LIKE sfcd_t.sfcd001
#                : 3.p_sfcd002                 LIKE sfcd_t.sfcd002
#                : 4.p_sfcb003                 LIKE sfcb_t.sfcb003
#                : 5.p_sfcb004                 LIKE sfcb_t.sfcb004
#                ：6.p_type1                   LIKE type_t.chr1      # 1.Check in    2.Check out
#                ：7.p_type2                   LIKE type_t.chr1      # Y.可维护       N.不可维护
# Date & Author..: 2014/2/13 By wuxja
# Modify.........:
################################################################################
PUBLIC FUNCTION asft301_02(p_sfcddocno,p_sfcd001,p_sfcd002,p_sfcb003,p_sfcb004,p_type1,p_type2)
DEFINE p_sfcddocno               LIKE sfcd_t.sfcddocno
DEFINE p_sfcd001                 LIKE sfcd_t.sfcd001
DEFINE p_sfcd002                 LIKE sfcd_t.sfcd002
DEFINE p_sfcb003                 LIKE sfcb_t.sfcb003
DEFINE p_sfcb004                 LIKE sfcb_t.sfcb004
DEFINE p_type1                   LIKE type_t.chr1      # 1.Check in    2.Check out
DEFINE p_type2                   LIKE type_t.chr1      # Y.可维护       N.不可维护
DEFINE l_count                   LIKE type_t.num10     #170104-00066#2 num5->num10  17/01/06 mod by rainy
DEFINE l_n                       LIKE type_t.num10     #170104-00066#2 num5->num10  17/01/06 mod by rainy
DEFINE l_cmd                     LIKE type_t.chr5
DEFINE l_lock_sw                 LIKE type_t.chr1
DEFINE l_allow_insert            LIKE type_t.num5        #可新增否 
DEFINE l_allow_delete            LIKE type_t.num5        #可刪除否
DEFINE l_sfcd007                 LIKE sfcd_t.sfcd005

   WHENEVER ERROR CONTINUE
   IF cl_null(p_sfcddocno) OR cl_null(p_sfcd001) OR cl_null(p_sfcd002) OR cl_null(p_type1) OR cl_null(p_type2) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00001'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_asft301_02 WITH FORM cl_ap_formpath("asf","asft301_02")

   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   CALL cl_set_combo_scc('sfcd004','1201') 
  
   LET g_qryparam.state = "i"

   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   CLEAR FORM
   CALL g_sfcd.clear()
   
   LET g_sfcddocno = p_sfcddocno
   LET g_sfcd001 = p_sfcd001
   LET g_sfcd002 = p_sfcd002
   LET g_sfcb003 = p_sfcb003
   LET g_sfcb004 = p_sfcb004
   LET g_type1 = p_type1
   
   #作业编号说明
   INITIALIZE g_chkparam.* TO NULL
   LET g_chkparam.arg1 = '221'
   LET g_chkparam.arg2 = g_sfcb003
   CALL cl_ref_val("v_oocql002")
   LET g_sfcb003_desc = g_chkparam.return1
   
   DISPLAY g_sfcd002,g_sfcb003,g_sfcb004 TO sfcd002,sfcb003,sfcb004
   DISPLAY g_sfcb003_desc TO sfcb003_desc
   DISPLAY g_type1 TO FORMONLY.ecbf004_1
   
   LET g_forupd_sql = " SELECT sfcd003,'',sfcd004,sfcd005,sfcd006,sfcd007,sfcd008 FROM sfcd_t ",
                   "  WHERE sfcdent = '",g_enterprise,"' AND sfcdsite = '",g_site,"'",
                   "    AND sfcddocno='",g_sfcddocno,"' AND sfcd001='",g_sfcd001,"' AND sfcd002='",g_sfcd002,"' AND sfcd009='",g_type1,"'",
                   "    AND sfcd003 = ? AND sfcd004 = ? FOR UPDATE"
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   PREPARE asft301_02_pre FROM g_forupd_sql
   DECLARE asft301_02_cs CURSOR FOR asft301_02_pre
   
   CALL asft301_02_b_fill()
   
   IF p_type2 = 'N' THEN
      DISPLAY ARRAY g_sfcd TO s_detail1.*
         ON ACTION accept
            LET INT_FLAG = TRUE
            EXIT DISPLAY

         ON ACTION cancel
            LET INT_FLAG = TRUE
            EXIT DISPLAY

         ON ACTION exit
           LET INT_FLAG = TRUE
           EXIT DISPLAY

         ON ACTION close
            LET INT_FLAG = TRUE
            EXIT DISPLAY
      END DISPLAY
      IF INT_FLAG THEN
         LET INT_FLAG = FALSE
         CLOSE WINDOW w_asft301_02
         RETURN
      END IF
   END IF
   
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      INPUT ARRAY g_sfcd FROM s_detail1.*
         ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                 INSERT ROW = l_allow_insert,
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
         
         BEFORE ROW 
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            DISPLAY l_ac TO FORMONLY.idx

            CALL s_transaction_begin()

            IF g_rec_b >= l_ac THEN
               LET l_cmd='u'
               LET g_sfcd_t.* = g_sfcd[l_ac].*  #BACKUP
               OPEN asft301_02_cs USING g_sfcd[l_ac].sfcd003,g_sfcd[l_ac].sfcd004

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "asft301_02_cs"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET l_lock_sw='Y'
               ELSE
                  FETCH asft301_02_cs INTO g_sfcd[l_ac].*
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_sfcd[l_ac].sfcd003
                  CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent = '"||g_enterprise||"' AND oocql001 = '223' AND oocql002 = ? AND oocql003 = '"||g_lang||"'","") RETURNING g_rtn_fields
                  LET g_sfcd[l_ac].sfcd003_desc = g_rtn_fields[1]
                  DISPLAY g_sfcd[l_ac].sfcd003_desc TO s_detail1[l_ac].sfcd003_desc
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            
         BEFORE INSERT
            CALL s_transaction_begin()
            LET l_cmd = 'a'
            INITIALIZE g_sfcd_t.* TO NULL
            INITIALIZE g_sfcd[l_ac].* TO NULL
            LET g_sfcd[l_ac].sfcd004 = '1'
            LET g_sfcd[l_ac].sfcd008 = 'Y'
            CALL cl_show_fld_cont()

         AFTER INSERT
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
            SELECT COUNT(*) INTO l_count FROM sfcd_t WHERE sfcdent=g_enterprise AND sfcdsite=g_site AND sfcddocno=g_sfcddocno
               AND sfcd001=g_sfcd001 AND sfcd002=g_sfcd002 AND sfcd003=g_sfcd[l_ac].sfcd003 AND sfcd004=g_sfcd[l_ac].sfcd004
            IF l_count = 0 THEN
               INSERT INTO sfcd_t(sfcdent,sfcdsite,sfcddocno,sfcd001,sfcd002,sfcd003,sfcd004,sfcd005,sfcd006,sfcd007,sfcd008,sfcd009)
               VALUES(g_enterprise,g_site,g_sfcddocno,g_sfcd001,g_sfcd002,g_sfcd[l_ac].sfcd003,g_sfcd[l_ac].sfcd004,g_sfcd[l_ac].sfcd005,g_sfcd[l_ac].sfcd006,g_sfcd[l_ac].sfcd007,g_sfcd[l_ac].sfcd008,g_type1)
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "INSERT sfcd_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N',0)
                  CANCEL INSERT
               ELSE
                  CALL s_transaction_end('Y',0)
                  ERROR 'INSERT O.K'
                  LET g_rec_b = g_rec_b + 1
               END IF
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_sfcd[l_ac].* TO NULL
               CALL s_transaction_end('N',0)
               CANCEL INSERT
            END IF
            
         BEFORE DELETE                            #是否取消單身
            IF NOT cl_null(g_sfcd[l_ac].sfcd003) AND NOT cl_null(g_sfcd[l_ac].sfcd004)THEN

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
               DELETE FROM sfcd_t WHERE sfcdent=g_enterprise AND sfcdsite=g_site AND sfcddocno=g_sfcddocno AND sfcd009=g_type1
                  AND sfcd001=g_sfcd001 AND sfcd002=g_sfcd002 AND sfcd003=g_sfcd[l_ac].sfcd003 AND sfcd004=g_sfcd[l_ac].sfcd004

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "DELETE sfcd_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N',0)
                  CANCEL DELETE
               ELSE
                  LET g_rec_b = g_rec_b-1
                  CALL s_transaction_end('Y',0)
               END IF
               CLOSE asft301_02_cs
            END IF
            
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_sfcd[l_ac].* = g_sfcd_t.*
               CLOSE asft301_02_cs
               CALL s_transaction_end('N',0)
               EXIT DIALOG
            END IF

            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_sfcd[l_ac].* = g_sfcd_t.*
            ELSE
               UPDATE sfcd_t SET (sfcd003,sfcd004,sfcd005,sfcd006,sfcd007,sfcd008)= (g_sfcd[l_ac].sfcd003,g_sfcd[l_ac].sfcd004,g_sfcd[l_ac].sfcd005,g_sfcd[l_ac].sfcd006,g_sfcd[l_ac].sfcd007,g_sfcd[l_ac].sfcd008)
                WHERE sfcdent=g_enterprise AND sfcdsite=g_site AND sfcddocno=g_sfcddocno AND sfcd009=g_type1
                  AND sfcd001=g_sfcd001 AND sfcd002=g_sfcd002 AND sfcd003=g_sfcd_t.sfcd003 AND sfcd004=g_sfcd_t.sfcd004
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "UPDATE sfcd_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_sfcd[l_ac].* = g_sfcd_t.*
                  CALL s_transaction_end('N',0)
               ELSE
                  CALL s_transaction_end('Y',0)
               END IF
            END IF
            
         AFTER ROW
            CLOSE asft301_02_cs          {#ADP版次:1#}
            
         AFTER FIELD sfcd003
            IF NOT cl_null(g_sfcd[l_ac].sfcd003)  THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_sfcd[l_ac].sfcd003 != g_sfcd_t.sfcd003)) THEN
                  #是否存在编号
                  IF NOT s_azzi650_chk_exist('223',g_sfcd[l_ac].sfcd003) THEN
                     LET g_sfcd[l_ac].sfcd003 = g_sfcd_t.sfcd003                    
                     NEXT FIELD sfcd003
                  END IF 

                  IF NOT cl_null(g_sfcd[l_ac].sfcd004) THEN
                     IF NOT ap_chk_notDup(g_sfcd[l_ac].sfcd003,"SELECT COUNT(*) FROM sfcd_t WHERE sfcdent = '" ||g_enterprise|| "' AND sfcdsite = '"||g_site ||"' AND sfcddocno ='"||g_sfcddocno||"' AND sfcd001='"||g_sfcd001||"' AND sfcd002='"||g_sfcd002||"' AND sfcd003 = '"||g_sfcd[l_ac].sfcd003 ||"' AND sfcd004 = '"||g_sfcd[l_ac].sfcd004||"' AND sfcd009='"||g_type1||"'",'std-00004',1) THEN
                        LET g_sfcd[l_ac].sfcd003 = g_sfcd_t.sfcd003
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
               
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = '223'
               LET g_chkparam.arg2 = g_sfcd[l_ac].sfcd003
               CALL cl_ref_val("v_oocql002")
               LET g_sfcd[l_ac].sfcd003_desc = g_chkparam.return1
               DISPLAY BY NAME g_sfcd[l_ac].sfcd003_desc 
            END IF
            
         AFTER FIELD sfcd004
            IF NOT cl_null(g_sfcd[l_ac].sfcd004)  THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_sfcd[l_ac].sfcd004 != g_sfcd_t.sfcd004)) THEN
                  IF NOT cl_null(g_sfcd[l_ac].sfcd003) THEN
                     IF NOT ap_chk_notDup(g_sfcd[l_ac].sfcd004,"SELECT COUNT(*) FROM sfcd_t WHERE sfcdent = '" ||g_enterprise|| "' AND sfcdsite = '"||g_site ||"' AND sfcddocno ='"||g_sfcddocno||"' AND sfcd001='"||g_sfcd001||"' AND sfcd002='"||g_sfcd002||"' AND sfcd003 = '"||g_sfcd[l_ac].sfcd003 ||"' AND sfcd004 = '"||g_sfcd[l_ac].sfcd004||"' AND sfcd009='"||g_type1||"'",'std-00004',1) THEN
                        LET g_sfcd[l_ac].sfcd004 = g_sfcd_t.sfcd004
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
               IF g_sfcd[l_ac].sfcd004 = '1' THEN
                  CALL cl_set_comp_entry('sfcd005,sfcd006',TRUE)
               ELSE
                  LET g_sfcd[l_ac].sfcd005 = ''
                  LET g_sfcd[l_ac].sfcd006 = ''
                  CALL cl_set_comp_entry('sfcd005,sfcd006',FALSE)
               END IF
            END IF

         AFTER FIELD sfcd005
            IF NOT cl_null(g_sfcd[l_ac].sfcd005) AND NOT cl_null(g_sfcd[l_ac].sfcd006) THEN
               IF g_sfcd[l_ac].sfcd005 > g_sfcd[l_ac].sfcd006 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00142'
                  LET g_errparam.extend = g_sfcd[l_ac].sfcd005
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_sfcd[l_ac].sfcd005 = g_sfcd_t.sfcd005
                  NEXT FIELD sfcd005
               END IF
            END IF 

         AFTER FIELD sfcd006
            IF NOT cl_null(g_sfcd[l_ac].sfcd005) AND NOT cl_null(g_sfcd[l_ac].sfcd006) THEN
               IF g_sfcd[l_ac].sfcd005 > g_sfcd[l_ac].sfcd006 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00142'
                  LET g_errparam.extend = g_sfcd[l_ac].sfcd006
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_sfcd[l_ac].sfcd006 = g_sfcd_t.sfcd006
                  NEXT FIELD sfcd006
               END IF
            END IF 
            
         AFTER FIELD sfcd007
            IF g_sfcd[l_ac].sfcd004 = '1' AND NOT cl_null(g_sfcd[l_ac].sfcd005) THEN
               IF NOT s_chr_alphanumeric(g_sfcd[l_ac].sfcd007,1) THEN
                  LET g_sfcd[l_ac].sfcd007 = g_sfcd_t.sfcd007
                  NEXT FIELD sfcd007
               END IF
               LET l_sfcd007 =  g_sfcd[l_ac].sfcd007
               IF NOT cl_null(g_sfcd[l_ac].sfcd005) THEN
                  IF l_sfcd007 < g_sfcd[l_ac].sfcd005 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'asf-00195'
                     LET g_errparam.extend = g_sfcd[l_ac].sfcd007
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_sfcd[l_ac].sfcd007 = g_sfcd_t.sfcd007
                     NEXT FIELD sfcd007
                  END IF
               END IF
               IF NOT cl_null(g_sfcd[l_ac].sfcd006) THEN
                  IF l_sfcd007 > g_sfcd[l_ac].sfcd006 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'asf-00195'
                     LET g_errparam.extend = g_sfcd[l_ac].sfcd007
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_sfcd[l_ac].sfcd007 = g_sfcd_t.sfcd007
                     NEXT FIELD sfcd007
                  END IF
               END IF
            END IF
            
         ON ACTION controlp INFIELD sfcd003
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_sfcd[l_ac].sfcd003
            LET g_qryparam.arg1 = "223"
            CALL q_oocq002()
            LET g_sfcd[l_ac].sfcd003 = g_qryparam.return1 
            DISPLAY g_sfcd[l_ac].sfcd003 TO sfcd003
            NEXT FIELD sfcd003 
      END INPUT
      
      BEFORE DIALOG
         CALL DIALOG.setCurrentRow("s_detail1",l_ac)                {#ADP版次:1#}

      #公用action
      ON ACTION accept
         ACCEPT DIALOG

      ON ACTION cancel
         LET INT_FLAG = TRUE
         EXIT DIALOG

      ON ACTION close
         LET INT_FLAG = TRUE
         EXIT DIALOG

      ON ACTION exit
         LET INT_FLAG = TRUE
         EXIT DIALOG

   END DIALOG
   
   IF INT_FLAG THEN
      LET INT_FLAG = 0
   END IF
   CLOSE asft301_02_cs
   CLOSE WINDOW w_asft301_02
END FUNCTION
################################################################################
# Descriptions...: 单身显示
# Memo...........:
# Usage..........: CALL asft301_02_b_fill()
# Date & Author..: 2014/2/13 By wuxja
# Modify.........:
################################################################################
PRIVATE FUNCTION asft301_02_b_fill()
   LET g_sql="SELECT sfcd003,'',sfcd004,sfcd005,sfcd006,sfcd007,sfcd008 FROM sfcd_t WHERE sfcdent='",g_enterprise,"' AND sfcdsite='",g_site,"'",
             "   AND sfcddocno='",g_sfcddocno,"' AND sfcd001='",g_sfcd001,"' AND sfcd002='",g_sfcd002,"' AND sfcd009='",g_type1,"'",
             " ORDER BY sfcd003,sfcd004"
   PREPARE asft301_02_pre1 FROM g_sql
   DECLARE asft301_02_cs1 CURSOR FOR asft301_02_pre1
   LET l_ac = 1
   FOREACH asft301_02_cs1 INTO g_sfcd[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      #项目说明
      INITIALIZE g_chkparam.* TO NULL
      LET g_chkparam.arg1 = '223'
      LET g_chkparam.arg2 = g_sfcd[l_ac].sfcd003
      CALL cl_ref_val("v_oocql002")
      LET g_sfcd[l_ac].sfcd003_desc = g_chkparam.return1
      LET l_ac = l_ac + 1
   END FOREACH
   CALL g_sfcd.deleteElement(g_sfcd.getLength())
   LET g_rec_b = l_ac - 1
END FUNCTION

 
{</section>}
 
