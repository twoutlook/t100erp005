#該程式未解開Section, 採用最新樣板產出!
{<section id="aqct300_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2014-09-02 14:59:05), PR版次:0002(2014-09-17 16:36:01)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000162
#+ Filename...: aqct300_01
#+ Description: 檢驗測量值輸入-依檢驗專案
#+ Creator....: 01996(2013-12-16 10:44:08)
#+ Modifier...: 01996 -SD/PR- 01996
 
{</section>}
 
{<section id="aqct300_01.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"

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
 
{<section id="aqct300_01.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"

{<Module define>}

#單身 type 宣告
 TYPE type_g_qcbd_d RECORD
   qcbdseq LIKE qcbd_t.qcbdseq,
   qcbd001 LIKE qcbd_t.qcbd001,
   qcbd001_desc LIKE type_t.chr80,
   qcbd002 LIKE qcbd_t.qcbd002,
   qcbd009 LIKE qcbd_t.qcbd009,
   qcbd014 LIKE qcbd_t.qcbd014,
   qcbd013 LIKE qcbd_t.qcbd013,
   qcbd015 LIKE qcbd_t.qcbd015,
   num1    LIKE qcbg_t.qcbg002,
   num2    LIKE qcbg_t.qcbg002,
   num3    LIKE qcbg_t.qcbg002,
   num4    LIKE qcbg_t.qcbg002,
   num5    LIKE qcbg_t.qcbg002,
   num6    LIKE qcbg_t.qcbg002,
   num7    LIKE qcbg_t.qcbg002,
   num8    LIKE qcbg_t.qcbg002,
   num9    LIKE qcbg_t.qcbg002,
   num10    LIKE qcbg_t.qcbg002,
   num11    LIKE qcbg_t.qcbg002,
   num12    LIKE qcbg_t.qcbg002,
   num13    LIKE qcbg_t.qcbg002,
   num14    LIKE qcbg_t.qcbg002,
   num15    LIKE qcbg_t.qcbg002,
   num16    LIKE qcbg_t.qcbg002,
   num17    LIKE qcbg_t.qcbg002,
   num18    LIKE qcbg_t.qcbg002,
   num19    LIKE qcbg_t.qcbg002,
   num20    LIKE qcbg_t.qcbg002,
   num21    LIKE qcbg_t.qcbg002,
   num22    LIKE qcbg_t.qcbg002,
   num23    LIKE qcbg_t.qcbg002,
   num24    LIKE qcbg_t.qcbg002,
   num25    LIKE qcbg_t.qcbg002,
   num26    LIKE qcbg_t.qcbg002,
   num27    LIKE qcbg_t.qcbg002,
   num28    LIKE qcbg_t.qcbg002,
   num29    LIKE qcbg_t.qcbg002,
   num30    LIKE qcbg_t.qcbg002,
   num31    LIKE qcbg_t.qcbg002,
   num32    LIKE qcbg_t.qcbg002,
   num33    LIKE qcbg_t.qcbg002,
   num34    LIKE qcbg_t.qcbg002,
   num35    LIKE qcbg_t.qcbg002,
   num36    LIKE qcbg_t.qcbg002,
   num37    LIKE qcbg_t.qcbg002,
   num38    LIKE qcbg_t.qcbg002,
   num39    LIKE qcbg_t.qcbg002,
   num40    LIKE qcbg_t.qcbg002,
   num41    LIKE qcbg_t.qcbg002,
   num42    LIKE qcbg_t.qcbg002,
   num43    LIKE qcbg_t.qcbg002,
   num44    LIKE qcbg_t.qcbg002,
   num45    LIKE qcbg_t.qcbg002,
   num46    LIKE qcbg_t.qcbg002,
   num47    LIKE qcbg_t.qcbg002,
   num48    LIKE qcbg_t.qcbg002,
   num49    LIKE qcbg_t.qcbg002,
   num50    LIKE qcbg_t.qcbg002
       END RECORD


#無單身append欄位定義

#模組變數(Module Variables)
DEFINE g_qcbd_d          DYNAMIC ARRAY OF type_g_qcbd_d
DEFINE g_qcbd_d_t        type_g_qcbd_d


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
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_chk                BOOLEAN
DEFINE g_qcaz001            LIKE qcaz_t.qcaz001
DEFINE g_qcba          RECORD LIKE qcba_t.*
#多table用wc
DEFINE g_wc_table           STRING


{</Module define>}          {#ADP版次:1#}
#end add-point
 
{</section>}
 
{<section id="aqct300_01.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_qcbddocno          LIKE qcbd_t.qcbddocno
#end add-point
 
{</section>}
 
{<section id="aqct300_01.other_dialog" >}

 
{</section>}
 
{<section id="aqct300_01.other_function" readonly="Y" >}

PUBLIC FUNCTION aqct300_01(--)
   #add-point:main段變數傳入
   {<point name="main.get_var"/>}
   p_qcbddocno
   #end add-point
   )
   #add-point:main段define
DEFINE p_qcbddocno LIKE qcbd_t.qcbddocno
   #end add-point

   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log

   #add-point:作業初始化
   {<point name="main.init" />}
   #end add-point


   LET g_qcbddocno = p_qcbddocno
   LET g_qcaz001 = cl_get_para(g_enterprise,g_site,'S-MFG-0046')
   SELECT * INTO g_qcba.* FROM qcba_t WHERE qcbaent = g_enterprise AND qcbadocno = g_qcbddocno
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aqct300_01 WITH FORM cl_ap_formpath("aqc","aqct300_01")

   #瀏覽頁簽資料初始化
   CALL cl_ui_init()

   #程式初始化
   CALL aqct300_01_modify()

   #畫面關閉
   CLOSE WINDOW w_aqct300_01

   #add-point:離開前
   {<point name="main.exit" />}
   #end add-point

END FUNCTION

PRIVATE FUNCTION aqct300_01_modify()
   {<Local define>}
   DEFINE  l_cmd           LIKE type_t.chr1
   DEFINE  l_ac_t          LIKE type_t.num5                #未取消的ARRAY CNT
   DEFINE  l_n             LIKE type_t.num5                #檢查重複用
   DEFINE  l_cnt           LIKE type_t.num5                #檢查重複用
   DEFINE  l_lock_sw       LIKE type_t.chr1                #單身鎖住否
   DEFINE  l_allow_insert  LIKE type_t.num5                #可新增否
   DEFINE  l_allow_delete  LIKE type_t.num5                #可刪除否
   DEFINE  l_count         LIKE type_t.num5
   DEFINE  l_i             LIKE type_t.num5
   DEFINE  ls_return       STRING
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE  l_qcan015       LIKE qcan_t.qcan015
   {</Local define>}
   #add-point:modify段define
   {<point name="modify.define"/>}
   #end add-point

   LET g_action_choice = ""

   LET g_qryparam.state = "i"

   #add-point:modify段define_sql
   {<point name="modify.define_sql" mark="Y"/>}
   #end add-point
   LET g_forupd_sql = "SELECT qcbdsite,qcbddocno,qcbdseq,qcbd001,'',qcbd002,qcbd009,qcbd014,qcbd013,qcbd015,'','','','' FROM qcbd_t WHERE qcbdent=? AND qcbddocno=? AND qcbdseq=? FOR UPDATE"
   #add-point:modify段define_sql
   {<point name="modify.after_define_sql"/>}
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE aqct300_01_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR



   LET INT_FLAG = FALSE

   #add-point:modify段修改前
   {<point name="modify.before_input"/>}
   #end add-point
   CALL aqct300_01_b_fill()
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #Page1 預設值產生於此處
      INPUT ARRAY g_qcbd_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)

         #自訂ACTION(detail_input,page_1)


         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN
              CALL FGL_SET_ARR_CURR(g_qcbd_d.getLength()+1)
              LET g_insert = 'N'
           END IF

         BEFORE ROW
            #add-point:modify段before row
            {<point name="input.body.before_row2"/>}
            #end add-point
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
			
            {<point name="input.body.before_row"/>}
            #end add-point
            #其他table資料備份(確定是否更改用)
            CALL aqct300_01_set_entry_b()
            CALL aqct300_01_set_no_entry_b()
            CALL aqct300_01_get_qcan015(g_qcbd_d[l_ac].qcbdseq) RETURNING l_qcan015
            #其他table進行lock
         AFTER FIELD num1
            IF NOT cl_null(g_qcbd_d[l_ac].num1) THEN
               IF l_qcan015 = '3' AND g_qcbd_d[l_ac].num1 <> 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aqc-00070'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
         AFTER FIELD num2
            IF NOT cl_null(g_qcbd_d[l_ac].num2) THEN
               IF l_qcan015 = '3' AND g_qcbd_d[l_ac].num2 <> 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aqc-00070'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
         AFTER FIELD num3
            IF NOT cl_null(g_qcbd_d[l_ac].num3) THEN
               IF l_qcan015 = '3' AND g_qcbd_d[l_ac].num3 <> 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aqc-00070'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
         AFTER FIELD num4
            IF NOT cl_null(g_qcbd_d[l_ac].num4) THEN
               IF l_qcan015 = '3' AND g_qcbd_d[l_ac].num4 <> 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aqc-00070'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
         AFTER FIELD num5
            IF NOT cl_null(g_qcbd_d[l_ac].num5) THEN
               IF l_qcan015 = '3' AND g_qcbd_d[l_ac].num5 <> 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aqc-00070'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
         AFTER FIELD num6
            IF NOT cl_null(g_qcbd_d[l_ac].num6) THEN
               IF l_qcan015 = '3' AND g_qcbd_d[l_ac].num6 <> 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aqc-00070'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
         AFTER FIELD num7
            IF NOT cl_null(g_qcbd_d[l_ac].num7) THEN
               IF l_qcan015 = '3' AND g_qcbd_d[l_ac].num7 <> 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aqc-00070'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
         AFTER FIELD num8
            IF NOT cl_null(g_qcbd_d[l_ac].num8) THEN
               IF l_qcan015 = '3' AND g_qcbd_d[l_ac].num8 <> 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aqc-00070'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
         AFTER FIELD num9
            IF NOT cl_null(g_qcbd_d[l_ac].num9) THEN
               IF l_qcan015 = '3' AND g_qcbd_d[l_ac].num9 <> 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aqc-00070'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
         AFTER FIELD num10
            IF NOT cl_null(g_qcbd_d[l_ac].num10) THEN
               IF l_qcan015 = '3' AND g_qcbd_d[l_ac].num10 <> 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aqc-00070'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
         AFTER FIELD num11
            IF NOT cl_null(g_qcbd_d[l_ac].num11) THEN
               IF l_qcan015 = '3' AND g_qcbd_d[l_ac].num11 <> 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aqc-00070'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
         AFTER FIELD num12
            IF NOT cl_null(g_qcbd_d[l_ac].num12) THEN
               IF l_qcan015 = '3' AND g_qcbd_d[l_ac].num12 <> 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aqc-00070'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
         AFTER FIELD num13
            IF NOT cl_null(g_qcbd_d[l_ac].num13) THEN
               IF l_qcan015 = '3' AND g_qcbd_d[l_ac].num13 <> 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aqc-00070'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
         AFTER FIELD num14
            IF NOT cl_null(g_qcbd_d[l_ac].num14) THEN
               IF l_qcan015 = '3' AND g_qcbd_d[l_ac].num14 <> 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aqc-00070'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
         AFTER FIELD num15
            IF NOT cl_null(g_qcbd_d[l_ac].num15) THEN
               IF l_qcan015 = '3' AND g_qcbd_d[l_ac].num15 <> 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aqc-00070'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
         AFTER FIELD num16
            IF NOT cl_null(g_qcbd_d[l_ac].num16) THEN
               IF l_qcan015 = '3' AND g_qcbd_d[l_ac].num16 <> 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aqc-00070'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
         AFTER FIELD num17
            IF NOT cl_null(g_qcbd_d[l_ac].num17) THEN
               IF l_qcan015 = '3' AND g_qcbd_d[l_ac].num17 <> 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aqc-00070'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
         AFTER FIELD num18
            IF NOT cl_null(g_qcbd_d[l_ac].num18) THEN
               IF l_qcan015 = '3' AND g_qcbd_d[l_ac].num18 <> 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aqc-00070'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
         AFTER FIELD num19
            IF NOT cl_null(g_qcbd_d[l_ac].num19) THEN
               IF l_qcan015 = '3' AND g_qcbd_d[l_ac].num19 <> 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aqc-00070'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
         AFTER FIELD num20
            IF NOT cl_null(g_qcbd_d[l_ac].num20) THEN
               IF l_qcan015 = '3' AND g_qcbd_d[l_ac].num20 <> 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aqc-00070'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
         AFTER FIELD num21
            IF NOT cl_null(g_qcbd_d[l_ac].num21) THEN
               IF l_qcan015 = '3' AND g_qcbd_d[l_ac].num21 <> 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aqc-00070'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
         AFTER FIELD num22
            IF NOT cl_null(g_qcbd_d[l_ac].num22) THEN
               IF l_qcan015 = '3' AND g_qcbd_d[l_ac].num22 <> 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aqc-00070'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
         AFTER FIELD num23
            IF NOT cl_null(g_qcbd_d[l_ac].num23) THEN
               IF l_qcan015 = '3' AND g_qcbd_d[l_ac].num23 <> 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aqc-00070'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
         AFTER FIELD num24
            IF NOT cl_null(g_qcbd_d[l_ac].num24) THEN
               IF l_qcan015 = '3' AND g_qcbd_d[l_ac].num24 <> 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aqc-00070'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
         AFTER FIELD num25
            IF NOT cl_null(g_qcbd_d[l_ac].num25) THEN
               IF l_qcan015 = '3' AND g_qcbd_d[l_ac].num25 <> 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aqc-00070'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
         AFTER FIELD num26
            IF NOT cl_null(g_qcbd_d[l_ac].num26) THEN
               IF l_qcan015 = '3' AND g_qcbd_d[l_ac].num26 <> 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aqc-00070'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
         AFTER FIELD num27
            IF NOT cl_null(g_qcbd_d[l_ac].num27) THEN
               IF l_qcan015 = '3' AND g_qcbd_d[l_ac].num27 <> 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aqc-00070'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
         AFTER FIELD num28
            IF NOT cl_null(g_qcbd_d[l_ac].num28) THEN
               IF l_qcan015 = '3' AND g_qcbd_d[l_ac].num28 <> 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aqc-00070'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
         AFTER FIELD num29
            IF NOT cl_null(g_qcbd_d[l_ac].num29) THEN
               IF l_qcan015 = '3' AND g_qcbd_d[l_ac].num29 <> 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aqc-00070'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
         AFTER FIELD num30
            IF NOT cl_null(g_qcbd_d[l_ac].num30) THEN
               IF l_qcan015 = '3' AND g_qcbd_d[l_ac].num30 <> 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aqc-00070'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
         AFTER FIELD num31
            IF NOT cl_null(g_qcbd_d[l_ac].num31) THEN
               IF l_qcan015 = '3' AND g_qcbd_d[l_ac].num31 <> 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aqc-00070'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
         AFTER FIELD num32
            IF NOT cl_null(g_qcbd_d[l_ac].num32) THEN
               IF l_qcan015 = '3' AND g_qcbd_d[l_ac].num32 <> 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aqc-00070'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
         AFTER FIELD num33
            IF NOT cl_null(g_qcbd_d[l_ac].num33) THEN
               IF l_qcan015 = '3' AND g_qcbd_d[l_ac].num33 <> 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aqc-00070'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
         AFTER FIELD num34
            IF NOT cl_null(g_qcbd_d[l_ac].num34) THEN
               IF l_qcan015 = '3' AND g_qcbd_d[l_ac].num34 <> 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aqc-00070'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
         AFTER FIELD num35
            IF NOT cl_null(g_qcbd_d[l_ac].num35) THEN
               IF l_qcan015 = '3' AND g_qcbd_d[l_ac].num35 <> 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aqc-00070'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
         AFTER FIELD num36
            IF NOT cl_null(g_qcbd_d[l_ac].num36) THEN
               IF l_qcan015 = '3' AND g_qcbd_d[l_ac].num36 <> 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aqc-00070'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
         AFTER FIELD num37
            IF NOT cl_null(g_qcbd_d[l_ac].num37) THEN
               IF l_qcan015 = '3' AND g_qcbd_d[l_ac].num37 <> 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aqc-00070'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
         AFTER FIELD num38
            IF NOT cl_null(g_qcbd_d[l_ac].num38) THEN
               IF l_qcan015 = '3' AND g_qcbd_d[l_ac].num38 <> 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aqc-00070'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
         AFTER FIELD num39
            IF NOT cl_null(g_qcbd_d[l_ac].num39) THEN
               IF l_qcan015 = '3' AND g_qcbd_d[l_ac].num39 <> 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aqc-00070'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
         AFTER FIELD num40
            IF NOT cl_null(g_qcbd_d[l_ac].num40) THEN
               IF l_qcan015 = '3' AND g_qcbd_d[l_ac].num40 <> 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aqc-00070'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
         AFTER FIELD num41
            IF NOT cl_null(g_qcbd_d[l_ac].num41) THEN
               IF l_qcan015 = '3' AND g_qcbd_d[l_ac].num41 <> 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aqc-00070'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
         AFTER FIELD num42
            IF NOT cl_null(g_qcbd_d[l_ac].num42) THEN
               IF l_qcan015 = '3' AND g_qcbd_d[l_ac].num42 <> 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aqc-00070'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
         AFTER FIELD num43
            IF NOT cl_null(g_qcbd_d[l_ac].num43) THEN
               IF l_qcan015 = '3' AND g_qcbd_d[l_ac].num43 <> 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aqc-00070'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
         AFTER FIELD num44
            IF NOT cl_null(g_qcbd_d[l_ac].num44) THEN
               IF l_qcan015 = '3' AND g_qcbd_d[l_ac].num44 <> 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aqc-00070'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
         AFTER FIELD num45
            IF NOT cl_null(g_qcbd_d[l_ac].num45) THEN
               IF l_qcan015 = '3' AND g_qcbd_d[l_ac].num45 <> 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aqc-00070'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
         AFTER FIELD num46
            IF NOT cl_null(g_qcbd_d[l_ac].num46) THEN
               IF l_qcan015 = '3' AND g_qcbd_d[l_ac].num46 <> 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aqc-00070'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
         AFTER FIELD num47
            IF NOT cl_null(g_qcbd_d[l_ac].num47) THEN
               IF l_qcan015 = '3' AND g_qcbd_d[l_ac].num47 <> 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aqc-00070'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
         AFTER FIELD num48
            IF NOT cl_null(g_qcbd_d[l_ac].num48) THEN
               IF l_qcan015 = '3' AND g_qcbd_d[l_ac].num48 <> 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aqc-00070'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
         AFTER FIELD num49
            IF NOT cl_null(g_qcbd_d[l_ac].num49) THEN
               IF l_qcan015 = '3' AND g_qcbd_d[l_ac].num49 <> 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aqc-00070'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
         AFTER FIELD num50
            IF NOT cl_null(g_qcbd_d[l_ac].num50) THEN
               IF l_qcan015 = '3' AND g_qcbd_d[l_ac].num50 <> 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aqc-00070'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF

         ON ROW CHANGE
            DELETE FROM qcbg_t WHERE qcbgent = g_enterprise
               AND qcbgdocno = g_qcba.qcbadocno AND qcbgseq = g_qcbd_d[l_ac].qcbdseq
            IF l_qcan015 = '3' THEN
               FOR l_i = 1 TO g_qcbd_d[l_ac].qcbd009
                  INSERT INTO qcbg_t(qcbgent,qcbgsite,qcbgdocno,qcbgseq,qcbg001,qcbg002)
                              VALUES(g_enterprise,g_qcba.qcbasite,g_qcba.qcbadocno,g_qcbd_d[l_ac].qcbdseq,l_i,1)
                  IF SQLCA.SQLCODE THEN
                     RETURN 
                  END IF
               END FOR
            END IF

         AFTER ROW
          
            #其他table進行unlock


         AFTER INPUT
            #add-point:單身input後
            {<point name="input.body.a_input"/>}
            #end add-point

      END INPUT





      BEFORE DIALOG
         IF g_temp_idx > 0 THEN
            LET l_ac = g_temp_idx
            CALL DIALOG.setCurrentRow("s_detail1",l_ac)
            LET g_temp_idx = 1
         END IF
         LET g_curr_diag = ui.DIALOG.getCurrent()
         #add-point:before_dialog
         {<point name="input.before_dialog"/>}
         #end add-point

      ON ACTION accept
         IF cl_null(g_qcbd_d[l_ac].num1) THEN
            NEXT FIELD num1
         END IF
         ACCEPT DIALOG

      ON ACTION cancel
         LET INT_FLAG = TRUE
         EXIT DIALOG

      ON ACTION controlo
         DISPLAY "Controlo"

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
   {<point name="modify.after_input"/>}
   #end add-point

   CLOSE aqct300_01_bcl
   CALL s_transaction_end('Y','0')

END FUNCTION

PRIVATE FUNCTION aqct300_01_b_fill()
              #BODY FILL UP
DEFINE l_qcba030 LIKE qcba_t.qcba030
DEFINE l_qcan015 LIKE qcan_t.qcan015


   LET g_sql = "SELECT UNIQUE qcbdseq,qcbd001,oocql004,qcbd002,qcbd009,qcbd014,qcbd013,qcbd015",
#               "               '','','','','','','','','','','','','','','','','','','','',",
#               " '','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''", 
               " FROM qcbd_t LEFT OUTER JOIN oocql_t ON oocqlent = qcbdent AND oocql001 = '1051' AND oocql002 = qcbd001 AND oocql003 = '",g_dlang,"'",
               " WHERE qcbdent= ? AND qcbddocno = ?"

   LET g_sql = g_sql, " ORDER BY qcbdseq"

   #add-point:b_fill段sql之後
   {<point name="b_fill.sql_after"/>}
   #end add-point

   PREPARE aqct300_01_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aqct300_01_pb

   OPEN b_fill_curs USING g_enterprise,g_qcbddocno

   CALL g_qcbd_d.clear()


   LET g_cnt = l_ac
   LET l_ac = 1

   FOREACH b_fill_curs INTO g_qcbd_d[l_ac].qcbdseq,g_qcbd_d[l_ac].qcbd001,g_qcbd_d[l_ac].qcbd001_desc,g_qcbd_d[l_ac].qcbd002,g_qcbd_d[l_ac].qcbd009,g_qcbd_d[l_ac].qcbd014,g_qcbd_d[l_ac].qcbd013,g_qcbd_d[l_ac].qcbd015
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      CALL aqct300_01_get_qcan015(g_qcbd_d[l_ac].qcbdseq) RETURNING l_qcan015
      IF l_qcan015 = '1' THEN
         CONTINUE FOREACH
      END IF
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF

   END FOREACH

   LET g_error_show = 0

   CALL g_qcbd_d.deleteElement(g_qcbd_d.getLength())

   #add-point:b_fill段資料填充(其他單身)
   {<point name="b_fill.others.fill"/>}
   #end add-point

   LET g_detail_cnt = l_ac - 1
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   LET l_ac = g_cnt
   LET g_cnt = 0

   CLOSE b_fill_curs
   FREE aqct300_01_pb

END FUNCTION

PRIVATE FUNCTION aqct300_01_set_entry_b()

DEFINE l_field  STRING
DEFINE l_i  LIKE type_t.num5
DEFINE l_seq LIKE type_t.chr10
DEFINE l_qcan015 LIKE qcan_t.qcan015   
   LET l_field = "num"
   FOR l_i = 1 TO 50
      LET l_seq = l_i
      IF l_i = 50 THEN
         LET l_field = l_field,l_seq CLIPPED
      ELSE
         LET l_field = l_field,l_seq CLIPPED,",num"
      END IF
   END FOR
   CALL cl_set_comp_entry(l_field,TRUE)
   CALL cl_set_comp_required(l_field,FALSE)
   CALL aqct300_01_get_qcan015(g_qcbd_d[l_ac].qcbdseq) RETURNING l_qcan015
   IF l_qcan015 = '3' THEN
      CALL cl_set_comp_required(l_field,TRUE) 
   END IF
END FUNCTION

PRIVATE FUNCTION aqct300_01_set_no_entry_b()


DEFINE l_field  STRING
DEFINE l_i  LIKE type_t.num5
DEFINE l_seq LIKE type_t.chr10

LET l_field = "num"
   FOR l_i = g_qcbd_d[l_ac].qcbd009 + 1 TO 50
      LET l_seq = l_i
      IF l_i = 50 THEN
         LET l_field = l_field,l_seq CLIPPED
      ELSE
         LET l_field = l_field,l_seq CLIPPED,",num"
      END IF
   END FOR
   CALL cl_set_comp_entry(l_field,FALSE)
   
   CALL cl_set_comp_required(l_field,FALSE) 

END FUNCTION

PRIVATE FUNCTION aqct300_01_get_qcan015(p_seq)
DEFINE p_seq   LIKE type_t.num5
DEFINE r_qcan015  LIKE qcan_t.qcan015
   SELECT qcan015 INTO r_qcan015 FROM qcan_t,qcam_t WHERE qcan001 = qcam001
      AND qcanent = qcament  AND qcam001 = qcan001 
      AND qcan002 = qcam002  AND qcan003 = qcam003 
      AND qcan004 = qcam004  AND qcan005 = qcam005 
      AND qcan006 = qcam006  AND qcan007 = qcam008 
      AND qcan008 = qcam009  AND qcan009 = p_seq
      AND qcam010 = g_qcba.qcba030
   RETURN r_qcan015
END FUNCTION

 
{</section>}
 
