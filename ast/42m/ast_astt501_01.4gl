#該程式未解開Section, 採用最新樣板產出!
{<section id="astt501_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2015-06-25 13:42:01), PR版次:0003(2016-09-05 20:52:21)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000046
#+ Filename...: astt501_01
#+ Description: 專櫃成本調整單維護子程式
#+ Creator....: 06814(2015-06-12 16:17:41)
#+ Modifier...: 06814 -SD/PR- 02599
 
{</section>}
 
{<section id="astt501_01.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"
#add by geza 20160506 160506-00019#1 金额不为空的时候在截位
#160905-00007#16   2016/09/05 By 02599   SQL条件增加ent
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
 
{<section id="astt501_01.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
 TYPE type_g_stga_d        RECORD
       sel LIKE type_t.chr500, 
   stga002 LIKE stga_t.stga002, 
   stga002_desc LIKE type_t.chr500, 
   stga003 LIKE stga_t.stga003, 
   stga003_desc LIKE type_t.chr500, 
   stga004 LIKE stga_t.stga004, 
   stga004_desc LIKE type_t.chr500, 
   stgi015  LIKE stgi_t.stgi015,  #add by dengdd 151203
   stgi013  LIKE stgi_t.stgi013,  #add by dengdd 15/10/28
   stgi014  LIKE stgi_t.stgi014,  #add by dengdd 15/10/28
   stga001 LIKE stga_t.stga001, 
   stga013 LIKE stga_t.stga013,     
   stgadocno LIKE stga_t.stgadocno, 
   stgasite LIKE stga_t.stgasite
       END RECORD
 
 
DEFINE g_stga_d              DYNAMIC ARRAY OF type_g_stga_d
DEFINE g_stga_d_t            type_g_stga_d
 
 
DEFINE g_stgasite_t          LIKE stga_t.stgasite    #Key值備份
DEFINE g_stga001_t           LIKE stga_t.stga001    #Key值備份
DEFINE g_stga002_t           LIKE stga_t.stga002    #Key值備份
DEFINE g_stga003_t           LIKE stga_t.stga003    #Key值備份
DEFINE g_stga013_t           LIKE stga_t.stga013    #Key值備份
DEFINE g_stgadocno_t         LIKE stga_t.stgadocno    #Key值備份
 
 
DEFINE l_ac                  LIKE type_t.num10
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_temp_idx            LIKE type_t.num10             #單身 所在筆數(暫存用)
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rec_b               LIKE type_t.num10 
DEFINE g_detail_idx          LIKE type_t.num10
DEFINE g_wc2                 STRING
DEFINE g_detail_cnt          LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_error_show          LIKE type_t.num5 
#end add-point
 
{</section>}
 
{<section id="astt501_01.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_stghsite            LIKE stgh_t.stghsite    #營運組織
DEFINE g_stghdocno           LIKE stgh_t.stghdocno   #單據編號
DEFINE g_stgh000             LIKE stgh_t.stgh000     #調整類型
DEFINE g_stgh001             LIKE stgh_t.stgh001     #起始日期
DEFINE g_stgh002             LIKE stgh_t.stgh002     #截止日期
#end add-point
 
{</section>}
 
{<section id="astt501_01.other_dialog" >}

 
{</section>}
 
{<section id="astt501_01.other_function" readonly="Y" >}

PUBLIC FUNCTION astt501_01(--)
   #add-point:input段變數傳入
   p_stghsite,
   p_stghdocno,
   p_stgh000,
   p_stgh001,
   p_stgh002
   #end add-point
   )
   DEFINE l_ac_t          LIKE type_t.num10       #未取消的ARRAY CNT
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否
   DEFINE l_count         LIKE type_t.num10
   DEFINE l_insert        LIKE type_t.num5
   DEFINE l_cmd           LIKE type_t.chr5
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_success       LIKE type_t.num5
   #add-point:input段define
   DEFINE p_stghsite      LIKE stgh_t.stghsite    #營運組織
   DEFINE p_stghdocno     LIKE stgh_t.stghdocno   #單據編號
   DEFINE p_stgh000       LIKE stgh_t.stgh000     #調整類型
   DEFINE p_stgh001       LIKE stgh_t.stgh001     #起始日期
   DEFINE p_stgh002       LIKE stgh_t.stgh002     #截止日期
   #end add-point
   #add-point:input段define

   #end add-point

   #畫面開啟 (identifier)
   OPEN WINDOW w_astt501_01 WITH FORM cl_ap_formpath("ast","astt501_01")

   #瀏覽頁簽資料初始化
   CALL cl_ui_init()

   LET g_qryparam.state = "i"

   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")

   #輸入前處理
   #add-point:單身前置處理
   WHENEVER ERROR CONTINUE
   IF NOT astt501_01_create_tmp() THEN
      RETURN
   END IF
   LET g_stghsite = p_stghsite     #營運組織
   LET g_stghdocno= p_stghdocno    #單據編號
   LET g_stgh000  = p_stgh000      #調整類型
   LET g_stgh001  = p_stgh001      #起始日期
   LET g_stgh002  = p_stgh002      #截止日期
   #end add-point
   LET g_wc2 =NULL
   CALL astt501_01_ui_dialog() RETURNING l_success
   IF NOT l_success  THEN
      LET r_success = FALSE
   END IF

   #add-point:畫面關閉前
   
   #end add-point

   #畫面關閉
   CLOSE WINDOW w_astt501_01

   #add-point:input段after input
   IF INT_FLAG = FALSE THEN
      CALL astt501_01_ins()
   END IF
   LET INT_FLAG = FALSE
   #end add-point

END FUNCTION

PRIVATE FUNCTION astt501_01_init()
   LET g_error_show = 1
END FUNCTION

PRIVATE FUNCTION astt501_01_ui_dialog()
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否
   DEFINE l_cmd           LIKE type_t.chr5
   DEFINE r_success LIKE type_t.num5
   DEFINE li_idx    LIKE type_t.num10
   DEFINE la_param  RECORD #串查用
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   #add by dengdd 15/10/29(S)
   DEFINE l_flag    LIKE type_t.chr1
   DEFINE l_sql     STRING
   #add by dengdd 15/10/29(E)
   
   LET r_success = TRUE
   
   LET g_action_choice = " "
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()

   CALL cl_set_act_visible("accept,cancel", FALSE)
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_detail_idx = 1
   LET l_flag='N'  #add by dengdd 15/10/29
   WHILE TRUE

      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_stga_d.clear()

         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL astt501_01_init()
      END IF
      
#      CALL astt501_01_b_fill(g_wc2)

      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         INPUT ARRAY g_stga_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)

         #自訂ACTION
         #add-point:單身前置處理

         #end add-point

         #自訂ACTION(detail_input)


         BEFORE INPUT
            #add-point:單身輸入前處理
            CALL cl_set_act_visible("insert,delete", FALSE)
            #CALL astt501_01_b_fill(g_wc2)  #mod by dengdd 15/10/29
            CALL astt501_01_query()  #add by dengdd 15/10/29


         BEFORE ROW
            LET l_ac = DIALOG.getCurrentRow("s_detail1")
            #end add-point

                  #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD sel
            #add-point:BEFORE FIELD sel

            #END add-point

         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD sel

            #add-point:AFTER FIELD sel

            #END add-point


         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE sel
            #add-point:ON CHANGE sel
            LET l_flag='Y'  #add by dengdd 15/10/29(S)
            CALL astt501_01_upd_tmp()
            #END add-point

         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD stga001
            #add-point:BEFORE FIELD stga001

            #END add-point

         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD stga001

            #add-point:AFTER FIELD stga001
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_stga_d[g_detail_idx].stgasite IS NOT NULL AND g_stga_d[g_detail_idx].stga001 IS NOT NULL AND g_stga_d[g_detail_idx].stga002 IS NOT NULL AND g_stga_d[g_detail_idx].stga003 IS NOT NULL AND g_stga_d[g_detail_idx].stga013 IS NOT NULL AND g_stga_d[g_detail_idx].stgadocno IS NOT NULL THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_stga_d[g_detail_idx].stgasite != g_stga_d_t.stgasite OR g_stga_d[g_detail_idx].stga001 != g_stga_d_t.stga001 OR g_stga_d[g_detail_idx].stga002 != g_stga_d_t.stga002 OR g_stga_d[g_detail_idx].stga003 != g_stga_d_t.stga003 OR g_stga_d[g_detail_idx].stga013 != g_stga_d_t.stga013 OR g_stga_d[g_detail_idx].stgadocno != g_stga_d_t.stgadocno)) THEN
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM stga_t WHERE "||"stgaent = '" ||g_enterprise|| "' AND "||"stgasite = '"||g_stga_d[g_detail_idx].stgasite ||"' AND "|| "stga001 = '"||g_stga_d[g_detail_idx].stga001 ||"' AND "|| "stga002 = '"||g_stga_d[g_detail_idx].stga002 ||"' AND "|| "stga003 = '"||g_stga_d[g_detail_idx].stga003 ||"' AND "|| "stga013 = '"||g_stga_d[g_detail_idx].stga013 ||"' AND "|| "stgadocno = '"||g_stga_d[g_detail_idx].stgadocno ||"'",'std-00004',0) THEN
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point


         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE stga001
            #add-point:ON CHANGE stga001

            #END add-point

         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD stga013
            #add-point:BEFORE FIELD stga013

            #END add-point

         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD stga013

            #add-point:AFTER FIELD stga013
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_stga_d[g_detail_idx].stgasite IS NOT NULL AND g_stga_d[g_detail_idx].stga001 IS NOT NULL AND g_stga_d[g_detail_idx].stga002 IS NOT NULL AND g_stga_d[g_detail_idx].stga003 IS NOT NULL AND g_stga_d[g_detail_idx].stga013 IS NOT NULL AND g_stga_d[g_detail_idx].stgadocno IS NOT NULL THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_stga_d[g_detail_idx].stgasite != g_stga_d_t.stgasite OR g_stga_d[g_detail_idx].stga001 != g_stga_d_t.stga001 OR g_stga_d[g_detail_idx].stga002 != g_stga_d_t.stga002 OR g_stga_d[g_detail_idx].stga003 != g_stga_d_t.stga003 OR g_stga_d[g_detail_idx].stga013 != g_stga_d_t.stga013 OR g_stga_d[g_detail_idx].stgadocno != g_stga_d_t.stgadocno)) THEN
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM stga_t WHERE "||"stgaent = '" ||g_enterprise|| "' AND "||"stgasite = '"||g_stga_d[g_detail_idx].stgasite ||"' AND "|| "stga001 = '"||g_stga_d[g_detail_idx].stga001 ||"' AND "|| "stga002 = '"||g_stga_d[g_detail_idx].stga002 ||"' AND "|| "stga003 = '"||g_stga_d[g_detail_idx].stga003 ||"' AND "|| "stga013 = '"||g_stga_d[g_detail_idx].stga013 ||"' AND "|| "stgadocno = '"||g_stga_d[g_detail_idx].stgadocno ||"'",'std-00004',0) THEN
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point


         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE stga013
            #add-point:ON CHANGE stga013

            #END add-point

         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD stgadocno
            #add-point:BEFORE FIELD stgadocno

            #END add-point

         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD stgadocno

            #add-point:AFTER FIELD stgadocno
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_stga_d[g_detail_idx].stgasite IS NOT NULL AND g_stga_d[g_detail_idx].stga001 IS NOT NULL AND g_stga_d[g_detail_idx].stga002 IS NOT NULL AND g_stga_d[g_detail_idx].stga003 IS NOT NULL AND g_stga_d[g_detail_idx].stga013 IS NOT NULL AND g_stga_d[g_detail_idx].stgadocno IS NOT NULL THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_stga_d[g_detail_idx].stgasite != g_stga_d_t.stgasite OR g_stga_d[g_detail_idx].stga001 != g_stga_d_t.stga001 OR g_stga_d[g_detail_idx].stga002 != g_stga_d_t.stga002 OR g_stga_d[g_detail_idx].stga003 != g_stga_d_t.stga003 OR g_stga_d[g_detail_idx].stga013 != g_stga_d_t.stga013 OR g_stga_d[g_detail_idx].stgadocno != g_stga_d_t.stgadocno)) THEN
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM stga_t WHERE "||"stgaent = '" ||g_enterprise|| "' AND "||"stgasite = '"||g_stga_d[g_detail_idx].stgasite ||"' AND "|| "stga001 = '"||g_stga_d[g_detail_idx].stga001 ||"' AND "|| "stga002 = '"||g_stga_d[g_detail_idx].stga002 ||"' AND "|| "stga003 = '"||g_stga_d[g_detail_idx].stga003 ||"' AND "|| "stga013 = '"||g_stga_d[g_detail_idx].stga013 ||"' AND "|| "stgadocno = '"||g_stga_d[g_detail_idx].stgadocno ||"'",'std-00004',0) THEN
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point


         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE stgadocno
            #add-point:ON CHANGE stgadocno

            #END add-point

         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD stgasite
            #add-point:BEFORE FIELD stgasite

            #END add-point

         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD stgasite

            #add-point:AFTER FIELD stgasite
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_stga_d[g_detail_idx].stgasite IS NOT NULL AND g_stga_d[g_detail_idx].stga001 IS NOT NULL AND g_stga_d[g_detail_idx].stga002 IS NOT NULL AND g_stga_d[g_detail_idx].stga003 IS NOT NULL AND g_stga_d[g_detail_idx].stga013 IS NOT NULL AND g_stga_d[g_detail_idx].stgadocno IS NOT NULL THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_stga_d[g_detail_idx].stgasite != g_stga_d_t.stgasite OR g_stga_d[g_detail_idx].stga001 != g_stga_d_t.stga001 OR g_stga_d[g_detail_idx].stga002 != g_stga_d_t.stga002 OR g_stga_d[g_detail_idx].stga003 != g_stga_d_t.stga003 OR g_stga_d[g_detail_idx].stga013 != g_stga_d_t.stga013 OR g_stga_d[g_detail_idx].stgadocno != g_stga_d_t.stgadocno)) THEN
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM stga_t WHERE "||"stgaent = '" ||g_enterprise|| "' AND "||"stgasite = '"||g_stga_d[g_detail_idx].stgasite ||"' AND "|| "stga001 = '"||g_stga_d[g_detail_idx].stga001 ||"' AND "|| "stga002 = '"||g_stga_d[g_detail_idx].stga002 ||"' AND "|| "stga003 = '"||g_stga_d[g_detail_idx].stga003 ||"' AND "|| "stga013 = '"||g_stga_d[g_detail_idx].stga013 ||"' AND "|| "stgadocno = '"||g_stga_d[g_detail_idx].stgadocno ||"'",'std-00004',0) THEN
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point


         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE stgasite
            #add-point:ON CHANGE stgasite

            #END add-point


                  #Ctrlp:input.c.page1.sel
#         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD sel
            #add-point:ON ACTION controlp INFIELD sel

            #END add-point

         #Ctrlp:input.c.page1.stga001
#         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD stga001
            #add-point:ON ACTION controlp INFIELD stga001

            #END add-point

         #Ctrlp:input.c.page1.stga013
#         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD stga013
            #add-point:ON ACTION controlp INFIELD stga013

            #END add-point

         #Ctrlp:input.c.page1.stgadocno
#         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD stgadocno
            #add-point:ON ACTION controlp INFIELD stgadocno

            #END add-point

         #Ctrlp:input.c.page1.stgasite
#         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD stgasite
            #add-point:ON ACTION controlp INFIELD stgasite

            #END add-point



         #自訂ACTION
         #add-point:單身其他段落處理(EX:on row change, etc...)
     #add by dengdd 20151203(S)
     AFTER FIELD stgi015
       IF NOT cl_null(g_stga_d[l_ac].stgi015) AND l_flag='Y' THEN
         LET l_sql="update astt501_01_tmp set stgi015='",g_stga_d[l_ac].stgi015,"'",
                   "   where stga002='",g_stga_d[l_ac].stga002,"'",
                   "     and stga003='",g_stga_d[l_ac].stga003,"'"
         EXECUTE IMMEDIATE l_sql
         IF STATUS THEN
            INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "upd tmp:stgi015" 
               LET g_errparam.code   = STATUS
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET r_success=FALSE
               RETURN
         END IF       
      END IF
     #add by dengdd 20151203(E)
     
     #add by dengdd 15/10/29(S)
     AFTER FIELD stgi013
       IF NOT cl_null(g_stga_d[l_ac].stgi013) AND l_flag='Y' THEN
         LET l_sql="update astt501_01_tmp set stgi013='",g_stga_d[l_ac].stgi013,"'",
#                   "                          stgi014='",g_stga_d[l_ac].stgi014,"'",
                   "   where stga002='",g_stga_d[l_ac].stga002,"'",
                   "     and stga003='",g_stga_d[l_ac].stga003,"'"
         EXECUTE IMMEDIATE l_sql
         IF STATUS THEN
            INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "upd tmp:stgi013" 
               LET g_errparam.code   = STATUS
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET r_success=FALSE
               RETURN
         END IF       
      END IF
                
      AFTER FIELD stgi014
       IF NOT cl_null(g_stga_d[l_ac].stgi014) AND l_flag='Y' THEN
         LET l_sql="update astt501_01_tmp set stgi014='",g_stga_d[l_ac].stgi014,"'",
 #                  "                          stgi014='",g_stga_d[l_ac].stgi014,"'",
                   "   where stga002='",g_stga_d[l_ac].stga002,"'",
                   "     and stga003='",g_stga_d[l_ac].stga003,"'"
          EXECUTE IMMEDIATE l_sql
          IF STATUS THEN
             INITIALIZE g_errparam TO NULL 
                LET g_errparam.extend = "upd tmp:stgi014" 
                LET g_errparam.code   = STATUS
                LET g_errparam.popup  = TRUE 
                CALL cl_err()
                LET r_success=FALSE
                RETURN
          END IF      
       END IF
       #add by dengdd 15/10/29(E)
         #end add-point

         AFTER INPUT
            #add-point:單身輸入後處理

            #end add-point

      END INPUT



         BEFORE DIALOG
            IF g_temp_idx > 0 THEN
               LET l_ac = g_temp_idx
               CALL DIALOG.setCurrentRow("s_detail1",l_ac)
               LET g_temp_idx = 1
            END IF
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)

            NEXT FIELD CURRENT

         #應用 a43 樣板自動產生(Version:2)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL astt501_01_query()
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
#               CALL astt501_01_b_fill(g_wc2)
            END IF

         ON ACTION close
            LET INT_FLAG = 1
            LET g_action_choice="exit"
            CANCEL DIALOG

         ON ACTION exit
            LET INT_FLAG = 1
            LET g_action_choice="exit"
            CANCEL DIALOG

         ON ACTION accept
            ACCEPT DIALOG
        
         ON ACTION cancel
            LET INT_FLAG = 1
            CANCEL DIALOG
         &include "common_action.4gl"
          CONTINUE DIALOG
      END DIALOG
   
      EXIT WHILE

   END WHILE

   CALL cl_set_act_visible("accept,cancel", TRUE)

   RETURN r_success 
END FUNCTION

PRIVATE FUNCTION astt501_01_query()
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING

   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_stga_d.clear()
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      CONSTRUCT g_wc2 ON stga002, stga003, stga004
         FROM s_detail1[1].stga002 , s_detail1[1].stga003 , s_detail1[1].stga004

         BEFORE CONSTRUCT
            ON ACTION controlp INFIELD stga002
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imaa001()
               DISPLAY g_qryparam.return1 TO stga002  #顯示到畫面上
               NEXT FIELD stga002                     #返回原欄位
            ON ACTION controlp INFIELD stga003
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_inaa001()
               DISPLAY g_qryparam.return1 TO stga003  #顯示到畫面上
               NEXT FIELD stga002                     #返回原欄位
            ON ACTION controlp INFIELD stga004
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1=g_site
               CALL q_mhae001()
               DISPLAY g_qryparam.return1 TO stga004  #顯示到畫面上
               NEXT FIELD stga002                     #返回原欄位
         END CONSTRUCT


      BEFORE DIALOG
         CALL cl_qbe_init()


      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc

      ON ACTION qbe_save
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
      LET g_wc2 = ls_wc
   ELSE
      LET g_error_show = 1
      LET g_detail_idx = 1
   END IF
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      LET g_wc2 = ls_wc
   ELSE
      LET g_error_show = 1
      LET g_detail_idx = 1
   END IF
   
   CALL astt501_01_b_fill(g_wc2)

   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = -100
      LET g_errparam.popup  = TRUE
      CALL cl_err()
   END IF

   LET INT_FLAG = FALSE
END FUNCTION

PRIVATE FUNCTION astt501_01_b_fill(p_wc2)
   DEFINE l_sql    STRING
   DEFINE p_wc2    STRING
   DEFINE l_where  STRING
   
   DELETE FROM astt501_01_tmp
   
   IF cl_null(p_wc2) THEN
      LET p_wc2 = " 1=1"
   END IF
   LET l_sql = "SELECT DISTINCT 'N',stga002,imaal003,stga003,inayl003,stga004,mhael023 ",
               "  FROM stga_t                                                          ",
               "  LEFT OUTER JOIN imaal_t ON stgaent = imaalent                        ",
               "                            AND stga002 = imaal001                     ",
               "                            AND imaal002 = '",g_dlang,"'               ",
               "  LEFT OUTER JOIN inayl_t ON stgaent = inaylent                        ",
               "                            AND stga003 = inayl001                     ",
               "                            AND inayl002 = '",g_dlang,"'               ",
               "  LEFT OUTER JOIN mhael_t ON stgaent = mhaelent                        ",
               "                            AND stga004 = mhael001                     ",
               "                            AND mhael022 = '",g_dlang,"'               ",
               " WHERE stgaent = '"||g_enterprise||"'                                  ",
               "   AND stgasite ='"||g_stghsite||"'                                    ",
               "   AND stga001 BETWEEN '"||g_stgh001||"' AND '"||g_stgh002||"'         ",
               "   AND (", p_wc2, ") "
   IF g_stgh000 = '1' THEN
      LET l_sql= l_sql ," AND stga013 IN ('1','14')"
   END IF
   IF g_stgh000 = '2' THEN
      LET l_sql= l_sql ," AND stga013 IN ('7')"
   END IF
   LET l_sql= l_sql ," ORDER BY stga002,stga003,stga004"
   PREPARE astt501_01_b_fill_pre FROM l_sql
   DECLARE astt501_01_b_fill_cs CURSOR FOR astt501_01_b_fill_pre
   LET l_ac = 1
   FOREACH astt501_01_b_fill_cs
      INTO g_stga_d[l_ac].sel,
           g_stga_d[l_ac].stga002,g_stga_d[l_ac].stga002_desc,
           g_stga_d[l_ac].stga003,g_stga_d[l_ac].stga003_desc, 
           g_stga_d[l_ac].stga004,g_stga_d[l_ac].stga004_desc 
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "Foreach astt501_01_b_fill_cs"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
   END FOREACH
   
   CALL g_stga_d.deleteElement(g_stga_d.getLength())
   
   LET l_ac = 1
   LET g_detail_cnt = g_stga_d.getLength()
   DISPLAY g_rec_b TO FORMONLY.cnt
   
END FUNCTION

################################################################################
# Descriptions...: 建立temp table
# Memo...........:
# Usage..........: CALL astt501_01_create_tmp()
#                     RETURNING r_success
# Return code....: r_success TRUE/FALSE
# Date & Author..: 20150615 By beckxie
# Modify.........:
################################################################################
PRIVATE FUNCTION astt501_01_create_tmp()
DEFINE r_success        LIKE type_t.num5

   LET r_success = TRUE
   
   CALL astt501_01_drop_tmp()
   
   CREATE TEMP TABLE astt501_01_tmp(
      stgaent   SMALLINT,    
      stgasite  VARCHAR(10),
      stga001   DATE,
      stga002   VARCHAR(40),    
      stga003   VARCHAR(10),  
      stga004   VARCHAR(20),
      stgi015   DECIMAL(20,6),       #add by dengdd 151203
      stgi013   DECIMAL(20,6),       #add by dengdd 15/10/28
      stgi014   DECIMAL(20,6)     #add by dengdd 15/10/28        
   )
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Create Temp Table astt501_01_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 刪除temp table
# Memo...........:
# Usage..........: CALL astt501_01_drop_tmp()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 20150615 By beckxie
# Modify.........:
################################################################################
PRIVATE FUNCTION astt501_01_drop_tmp()
   DROP TABLE astt501_01_tmp
END FUNCTION

################################################################################
# Descriptions...: 更新temp table
# Memo...........:
# Usage..........: CALL astt501_01_upd_tmp()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 20150615 By beckxie
# Modify.........:
################################################################################
PRIVATE FUNCTION astt501_01_upd_tmp()
   IF g_stga_d[l_ac].sel = 'Y' THEN
      INSERT INTO astt501_01_tmp(stgaent, stgasite, stga001, stga002, 
                                 stga003,stga004,stgi015,stgi013,stgi014)   #add (stgi013,stgi014) by dengdd 15/10/28
                                                                            #add stgi015 by dengdd 151203
         VALUES(          g_enterprise, g_stga_d[l_ac].stgasite, g_stga_d[l_ac].stga001, g_stga_d[l_ac].stga002,
                g_stga_d[l_ac].stga003,g_stga_d[l_ac].stga004,g_stga_d[l_ac].stgi015,
                g_stga_d[l_ac].stgi013,g_stga_d[l_ac].stgi014)
   ELSE
      DELETE FROM astt501_01_tmp
       WHERE stgaent = g_enterprise
         AND stga002 = g_stga_d[l_ac].stga002
         AND stga003 = g_stga_d[l_ac].stga003
         AND stga004 = g_stga_d[l_ac].stga004
   END IF
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
PRIVATE FUNCTION astt501_01_ins_pre()
   DEFINE l_sql        STRING 
   #刪除與原本單身重複的選項
   CALL astt501_01_del_tmp()
   #將勾選的選項產生至單身
   LET l_sql = "SELECT a.stga001,a.stga002,a.stga003,a.stga004,a.stga005,a.stga006,",
               "       a.stga007,a.stga008,a.stga009,a.stga012,a.stga010",
               "  FROM stga_t a,astt501_01_tmp b",
               " WHERE a.stgaent=b.stgaent",
               "   AND a.stga001 BETWEEN '"||g_stgh001||"' AND '"||g_stgh002||"' ",
               "   AND a.stga002=b.stga002",
               "   AND a.stga003=b.stga003",
               "   AND a.stga004=b.stga004"
   IF g_stgh000 = '1' THEN
      LET l_sql= l_sql ," AND a.stga013 IN ('1','14')"
   END IF
   IF g_stgh000 = '2' THEN
      LET l_sql= l_sql ," AND a.stga013 IN ('7')"
   END IF
   LET l_sql= l_sql ," ORDER BY a.stga002,a.stga003,a.stga004,a.stga005,a.stga006,a.stga001"
   
   PREPARE astt501_01_sel_pre FROM l_sql
   DECLARE astt501_01_sel_cs CURSOR FOR astt501_01_sel_pre

   #項次
   LET l_sql = "SELECT COALESCE(MAX(stgiseq),0)+1",
               "  FROM stgi_t",
               " WHERE stgient = ",g_enterprise,
               "   AND stgidocno = '",g_stghdocno,"'"
   PREPARE astt501_01_stgiseq FROM l_sql
END FUNCTION

PRIVATE FUNCTION astt501_01_del_tmp()
   DEFINE l_sql_delete    STRING
   DEFINE l_stgi001       LIKE stgi_t.stgi001
   DEFINE l_stgi002       LIKE stgi_t.stgi002
   DEFINE l_stgi003       LIKE stgi_t.stgi003
   DEFINE l_success       LIKE type_t.num5
   
   LET l_sql_delete = "SELECT a.stgi001,a.stgi002,a.stgi003 ",
                      "  FROM stgi_t a,astt501_01_tmp b",
                      " WHERE a.stgient  = '"||g_enterprise||"' ",
                      "   AND a.stgidocno= '"||g_stghdocno||"'  ",
                      "   AND a.stgi001  =b.stga002",
                      "   AND a.stgi002  =b.stga003",
                      "   AND a.stgi003  =b.stga004"
   PREPARE astt501_01_del_pre FROM l_sql_delete
   DECLARE astt501_01_del_cs CURSOR FOR astt501_01_del_pre
   FOREACH astt501_01_del_cs INTO l_stgi001,l_stgi002,l_stgi003
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "Foreach astt501_01_del_cs"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET l_success = FALSE
         EXIT FOREACH
      END IF
      DELETE FROM astt501_01_tmp
       WHERE stgaent = g_enterprise
         AND stga002 = l_stgi001
         AND stga003 = l_stgi002
         AND stga004 = l_stgi003
         
         IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "del astt501_01_tmp"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET l_success = FALSE
         EXIT FOREACH
      END IF
      LET l_stgi001=NULL
      LET l_stgi002=NULL
      LET l_stgi003=NULL
   END FOREACH
END FUNCTION
################################################################################
# Descriptions...: ins 至 主檔單身
# Memo...........: 
# Usage..........: CALL astt501_01_ins() 
# Date & Author..: 20150612 By beckxie
# Modify.........:
################################################################################
PRIVATE FUNCTION astt501_01_ins()
   DEFINE l_sql       STRING
   DEFINE l_seq       LIKE type_t.num5
   DEFINE l_cnt_ins   LIKE type_t.num5
   DEFINE l_success   LIKE type_t.num5
   DEFINE r_success   LIKE type_t.num5 
   DEFINE l_stgi           RECORD
       stgient         LIKE stgi_t.stgient,    #企業編號
       stgisite        LIKE stgi_t.stgisite,   #營運組織
       stgidocno       LIKE stgi_t.stgidocno,  #單據編號
       stgiseq         LIKE stgi_t.stgiseq,    #項次
       stgi001         LIKE stgi_t.stgi001,    #商品編號
       stgi002         LIKE stgi_t.stgi002,    #庫區編號
       stgi003         LIKE stgi_t.stgi003,    #專櫃編號
       stgi004         LIKE stgi_t.stgi004,    #供應商編號
       stgi005         LIKE stgi_t.stgi005,    #調整日期
       stgi006         LIKE stgi_t.stgi006,    #費用編號
       stgi007         LIKE stgi_t.stgi007,    #銷售數量
       stgi008         LIKE stgi_t.stgi008,    #應收金額
       stgi009         LIKE stgi_t.stgi009,    #實收金額
       stgi010         LIKE stgi_t.stgi010,    #成本金額
       stgi012         LIKE stgi_t.stgi012,    #執行費率
       stgi013         LIKE stgi_t.stgi013,    #调整费率 add by dengdd 15/10/28
       stgi014         LIKE stgi_t.stgi014,     #调整金额 add by dengdd 15/10/28
       stgi015         LIKE stgi_t.stgi015
                       END RECORD
   DEFINE l_calcflag  LIKE type_t.chr1   #asti202中 應收實收flag(Y為實收,N為應收)                    
   DEFINE l_ooef016   LIKE ooef_t.ooef016
   
   
   LET l_success = TRUE
   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   
   CALL astt501_01_ins_pre()
   LET l_cnt_ins =0
   FOREACH astt501_01_sel_cs
      INTO l_stgi.stgi005,l_stgi.stgi001,l_stgi.stgi002,l_stgi.stgi003,l_stgi.stgi004,l_stgi.stgi006,
           l_stgi.stgi007,l_stgi.stgi008,l_stgi.stgi009,l_stgi.stgi010,l_stgi.stgi012
           
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "Foreach astt501_01_sel_cs"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET l_success = FALSE
         EXIT FOREACH
      END IF
      
      LET l_stgi.stgient   = g_enterprise       #企業編號
      LET l_stgi.stgidocno = g_stghdocno
      
      #add by dengdd 15/10/29(S)
      #抓临时表的调整费率，调整金额
      SELECT stgi013,stgi014 INTO l_stgi.stgi013,l_stgi.stgi014
        FROM astt501_01_tmp
       WHERE stgaent = g_enterprise
         AND stga002 = l_stgi.stgi001
         AND stga003 = l_stgi.stgi002
         AND stga004 = l_stgi.stgi003
         
     #add by dengdd 20151203(S)
     #计算调整费率
     IF NOT cl_null(l_stgi.stgi015) THEN
        LET l_stgi.stgi013=l_stgi.stgi015-l_stgi.stgi012
     END IF
     #add by dengdd 20151203(E)
     
     #计算实际执行费率
     IF NOT cl_null(l_stgi.stgi013) THEN      #add by dengdd 151203
       LET l_stgi.stgi015=l_stgi.stgi012+l_stgi.stgi013
     END IF
     
     #若调整金额为空，则按正常计算
     IF cl_null(l_stgi.stgi014) AND NOT cl_null(l_stgi.stgi013)  then     
           SELECT COALESCE(stab010,'N') INTO l_calcflag
             FROM stab_t
              LEFT JOIN(SELECT stfc016              #取stfc016計算基準
                          FROM stfa_t, stfc_t
                         WHERE stfaent = stfcent
                           AND stfaent = g_enterprise #160905-00007#16 add
                           AND stfa001 = stfc001
                           AND stfa005 = l_stgi.stgi003
                           AND stfc002 = l_stgi.stgi002)
             ON stabent=g_enterprise AND stab001 = stfc016
          WHERE stabent = g_enterprise AND stab001 = stfc016 
            AND EXISTS (SELECT 1 FROM stat_t WHERE stabent = statent AND stab001 = stat003 and stat001 = '4'
                        AND statent = g_enterprise #160905-00007#16 add
                        ) 
            AND stab008 = 'Y' AND stab009='Y' 

         #條件為應收金額,取應收金額*調整費率=調整金額
         IF l_calcflag='Y' THEN
#            LET l_stgi.stgi014= l_stgi.stgi008 * (l_stgi.stgi013/100)
            LET l_stgi.stgi014= (-1)*(l_stgi.stgi008 * (l_stgi.stgi013/100)) #mod by dengdd 151203
         END IF
         #條件為實收金額,取實收金額*調整費率=調整金額
         IF l_calcflag='N' THEN
#            LET l_stgi.stgi014= l_stgi.stgi009 * (l_stgi.stgi013/100)
            LET l_stgi.stgi014= (-1)*(l_stgi.stgi009 * (l_stgi.stgi013/100)) #mod by dengdd 151203
         END IF
    END IF 
   
   SELECT ooef016 INTO l_ooef016
      FROM ooef_t 
     WHERE ooefent = g_enterprise 
       AND ooef001 = g_site
   #CALL s_curr_round(g_site,l_ooef016,l_stgi.stgi014,'2') RETURNING l_stgi.stgi014   #mark by geza 20160506 160506-00019#1
   #金额不为空在截位
   #add by geza 20160506 160506-00019#1(S)
   IF l_stgi.stgi014 IS NOT NULL THEN
      CALL s_curr_round(g_site,l_ooef016,l_stgi.stgi014,'2') RETURNING l_stgi.stgi014   
   END IF
   #add by geza 20160506 160506-00019#1(E)
   #add by dengdd 15/10/29(E)
         
      EXECUTE astt501_01_stgiseq INTO l_stgi.stgiseq
 
         
      INSERT INTO stgi_t(stgient,stgidocno,stgiseq,stgi001,stgi002,
                         stgi003,  stgi004,stgi005,stgi006,stgi007,
                         stgi008,  stgi009,stgi010,stgi012,stgi013,
                         stgi014,  stgi015)
         VALUES(l_stgi.stgient,l_stgi.stgidocno,l_stgi.stgiseq,l_stgi.stgi001,l_stgi.stgi002,
                l_stgi.stgi003,  l_stgi.stgi004,l_stgi.stgi005,l_stgi.stgi006,l_stgi.stgi007,
                l_stgi.stgi008,  l_stgi.stgi009,l_stgi.stgi010,l_stgi.stgi012,l_stgi.stgi013,
                l_stgi.stgi014,  l_stgi.stgi015)     #add (stgi013,stgi014,stgi015) by dengdd 15/10/28
                
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "Ins stgi_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET l_success = FALSE
         EXIT FOREACH
      END IF
      INITIALIZE l_stgi.* TO NULL
      LET l_cnt_ins=l_cnt_ins+1
   END FOREACH
   
   ERROR "此次產生 ",l_cnt_ins," 筆資料！"
   DELETE FROM astt501_01_tmp     #add by dengdd 15/10/29
   
   IF l_success THEN
      CALL s_transaction_end('Y',0)
   ELSE
      CALL s_transaction_end('N',0)
   END IF
   CALL cl_err_collect_show()
END FUNCTION

 
{</section>}
 
