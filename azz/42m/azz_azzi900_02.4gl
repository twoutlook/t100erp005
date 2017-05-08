#該程式未解開Section, 採用最新樣板產出!
{<section id="azzi900_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2013-12-16 00:00:00), PR版次:0001(2014-04-02 13:37:12)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000137
#+ Filename...: azzi900_02
#+ Description: 參數輸入子作業
#+ Creator....: 00845(2013-12-16 11:24:37)
#+ Modifier...: 00845 -SD/PR- 01856
 
{</section>}
 
{<section id="azzi900_02.global" >}
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
 
{<section id="azzi900_02.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
{<Module define>}
#單身 type 宣告
 TYPE type_g_gzzc_d        RECORD
   gzzc002   LIKE gzzc_t.gzzc002,  #序號
   gzzc003   LIKE gzzc_t.gzzc003,  #變數意義 
   var_value LIKE type_t.chr20,    #
   gzzc004   LIKE gzzc_t.gzzc004,  #建議變數型態
   gzzc005   LIKE gzzc_t.gzzc005,  #建議變數長度
   entry   LIKE type_t.num5,       #T/F 可輸入/不可輸入
   return  LIKE type_t.num5        #T/F 回傳/不回傳
       END RECORD

DEFINE g_gzzc_temp_d          DYNAMIC ARRAY OF    RECORD
   gzzc002   string,  #序號
   gzzc003   string,  #變數意義 
   var_value STRING   #
   
       END RECORD
   
DEFINE g_gzzc_d          DYNAMIC ARRAY OF type_g_gzzc_d
DEFINE g_gzzc_d_t        type_g_gzzc_d


DEFINE g_gzzc001_t   LIKE gzzc_t.gzzc001    #Key值備份
DEFINE g_gzzc002_t      LIKE gzzc_t.gzzc002    #Key值備份



DEFINE l_ac                  LIKE type_t.num5
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rec_b               LIKE type_t.num5
DEFINE g_detail_idx          LIKE type_t.num5
DEFINE g_gzzz001  LIKE gzzz_t.gzzz001
{</Module define>}
#end add-point
 
{</section>}
 
{<section id="azzi900_02.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="azzi900_02.other_dialog" >}

 
{</section>}
 
{<section id="azzi900_02.other_function" readonly="Y" >}

PUBLIC FUNCTION azzi900_02(--)
      pc_gzzz001,pd_arr
   )
   {<Local define>}
   DEFINE l_ac_t          LIKE type_t.num5        #未取消的ARRAY CNT
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否
   DEFINE l_count         LIKE type_t.num5
   DEFINE l_insert        LIKE type_t.num5
   DEFINE l_cmd           LIKE type_t.chr5
   {</Local define>}
   DEFINE ls_str STRING 
   DEFINE pc_gzzz001 LIKE gzzz_t.gzzz001
   DEFINE pd_arr DYNAMIC ARRAY OF RECORD 
       lc_gzzc002  LIKE gzzc_t.gzzc002,     #參數序號
       lc_value    LIKE type_t.chr20,       #參數數值
       li_entry    LIKE type_t.num5,        #是否可以輸入
       li_return   LIKE type_t.num5         #是否需要回傳
    END RECORD
   DEFINE li_rtn   LIKE type_t.num5 
   DEFINE li       LIKE type_t.num5
   LET g_gzzz001 = pc_gzzz001

   #畫面開啟 (identifier)
   OPEN WINDOW w_azzi900_02 WITH FORM cl_ap_formpath("azz","azzi900_02")

   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   #程式起始資料初始化
   CALL azzi900_02_init()
   #pd_arr 跟g_gzzc_d array 合併
   CALL azzi900_02_merge_param(pd_arr)
   LET g_qryparam.state = "i"

   #輸入前處理
   CALL azzi900_02_set_no_entry()
   
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #輸入開始
      INPUT ARRAY g_gzzc_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)

         #自訂ACTION
         #add-point:單身前置處理
         {<point name="input.action"/>}
         #end add-point

         #自訂ACTION(detail_input)


         BEFORE INPUT
            #add-point:單身輸入前處理
            {<point name="input.before_input"/>}
            #end add-point

         #---------------------<  Detail: page1  >---------------------
                  #新增
         BEFORE ROW
            LET l_ac = ARR_CURR() 
            LET g_gzzc_d_t.* = g_gzzc_d[l_ac].*  #BACKUP
            #end add-point


         AFTER FIELD var_value
             IF g_gzzc_d[l_ac].entry THEN 
               LET g_gzzc_d[l_ac].var_value = g_gzzc_d[l_ac].var_value CLIPPED
            ELSE    
               LET g_gzzc_d[l_ac].* = g_gzzc_d_t.*  
            END IF 



         #----<<gzzc002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzzc002
            #add-point:BEFORE FIELD gzzc002
            {<point name="input.b.page1.gzzc002" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD gzzc002

            #add-point:AFTER FIELD gzzc002

            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE gzzc002
            #add-point:ON CHANGE gzzc002
            {<point name="input.g.page1.gzzc002" />}
            #END add-point

         #----<<gzzc003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzzc003
            #add-point:BEFORE FIELD gzzc003
            {<point name="input.b.page1.gzzc003" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD gzzc003

            #add-point:AFTER FIELD gzzc003
            {<point name="input.a.page1.gzzc003" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE gzzc003
            #add-point:ON CHANGE gzzc003
            {<point name="input.g.page1.gzzc003" />}
            #END add-point

         #----<<gzzc004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzzc004
            #add-point:BEFORE FIELD gzzc004
            {<point name="input.b.page1.gzzc004" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD gzzc004

            #add-point:AFTER FIELD gzzc004
            {<point name="input.a.page1.gzzc004" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE gzzc004
            #add-point:ON CHANGE gzzc004
            {<point name="input.g.page1.gzzc004" />}
            #END add-point

         #----<<gzzc005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzzc005
            #add-point:BEFORE FIELD gzzc005
            {<point name="input.b.page1.gzzc005" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD gzzc005

            #add-point:AFTER FIELD gzzc005
            {<point name="input.a.page1.gzzc005" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE gzzc005
            #add-point:ON CHANGE gzzc005
            {<point name="input.g.page1.gzzc005" />}
            #END add-point


         #---------------------<  Detail: page1  >---------------------
         #----<<gzzc001>>----
         #Ctrlp:input.c.page1.gzzc001
#         ON ACTION controlp INFIELD gzzc001
            #add-point:ON ACTION controlp INFIELD gzzc001
            {<point name="input.c.page1.gzzc001" />}
            #END add-point

         #----<<gzzc002>>----
         #Ctrlp:input.c.page1.gzzc002
#         ON ACTION controlp INFIELD gzzc002
            #add-point:ON ACTION controlp INFIELD gzzc002
            {<point name="input.c.page1.gzzc002" />}
            #END add-point

         #----<<gzzc003>>----
         #Ctrlp:input.c.page1.gzzc003
#         ON ACTION controlp INFIELD gzzc003
            #add-point:ON ACTION controlp INFIELD gzzc003
            {<point name="input.c.page1.gzzc003" />}
            #END add-point

         #----<<gzzc004>>----
         #Ctrlp:input.c.page1.gzzc004
#         ON ACTION controlp INFIELD gzzc004
            #add-point:ON ACTION controlp INFIELD gzzc004
            {<point name="input.c.page1.gzzc004" />}
            #END add-point

         #----<<gzzc005>>----
         #Ctrlp:input.c.page1.gzzc005
#         ON ACTION controlp INFIELD gzzc005
            #add-point:ON ACTION controlp INFIELD gzzc005
            {<point name="input.c.page1.gzzc005" />}
            #END add-point



         AFTER INPUT
            #add-point:單身輸入後處理
            {<point name="input.after_input"/>}
            #end add-point

      END INPUT

      BEFORE DIALOG 
         #設定背景顏色屬性 沒有資料顯示空白 有資料顯示反紅
         CALL DIALOG.setArrayAttributes( "s_detail1", g_gzzc_temp_d )
         FOR li = 1 TO g_gzzc_d.getLength()
              IF g_gzzc_d[li].entry THEN 
                 LET g_gzzc_temp_d[li].gzzc002 = NULL 
                 LET g_gzzc_temp_d[li].gzzc003 = NULL
                 LET g_gzzc_temp_d[li].var_value = NULL
              ELSE  
                 LET g_gzzc_temp_d[li].gzzc002 = "red reverse" 
                 LET g_gzzc_temp_d[li].gzzc003 = "red reverse"
                 LET g_gzzc_temp_d[li].var_value = "red reverse"
              END IF 
         END FOR  

      #add-point:自定義input
      {<point name="input.more_input"/>}
      #end add-point

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

      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   END DIALOG

   IF INT_FLAG THEN 
      LET li_rtn = FALSE
      LET INT_FLAG = FALSE   
   ELSE  
      #把參數組合起來每個參數個" " ex:"A"
      CALL azzi900_02_compose_param() RETURNING ls_str
      LET li_rtn = TRUE  
   END IF
   #add-point:畫面關閉前
   #end add-point

   #畫面關閉
   CLOSE WINDOW w_azzi900_02

   RETURN ls_str,li_rtn 

END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: azzi900_02_init()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi900_02_init()
   DEFINE li LIKE type_t.num5 
   CALL g_gzzc_d.clear()
   LET li = 1
   DECLARE azzi900_02_init_cs CURSOR FOR  
      SELECT  gzzc002,gzzc003,gzzc004,gzzc005 FROM gzzc_t 
         WHERE  gzzc001 = g_gzzz001 

   FOREACH azzi900_02_init_cs INTO g_gzzc_d[li].gzzc002,g_gzzc_d[li].gzzc003,g_gzzc_d[li].gzzc004,g_gzzc_d[li].gzzc005 

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      LET g_gzzc_d[li].entry = TRUE 
      LET g_gzzc_d[li].return = TRUE
      LET li = li + 1
   END FOREACH
   CALL g_gzzc_d.deleteElement(li)
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
PRIVATE FUNCTION azzi900_02_merge_param(pd_arr)
   DEFINE li LIKE type_t.num5
   DEFINE pd_arr DYNAMIC ARRAY OF RECORD 
       lc_gzzc002  LIKE gzzc_t.gzzc002,     #參數序號
       lc_value    LIKE type_t.chr20,       #參數數值
       li_entry    LIKE type_t.num5,        #是否可以輸入
       li_return   LIKE type_t.num5         #是否需要回傳
    END RECORD
    
    #進行合併 以gzzc_t 為主
    FOR li = 1 TO g_gzzc_d.getLength()
       IF li <= pd_arr.getLength() THEN 
          LET g_gzzc_d[li].var_value = pd_arr[li].lc_value
          LET g_gzzc_d[li].entry = pd_arr[li].li_entry
          LET g_gzzc_d[li].return = pd_arr[li].li_return  
       END IF 
    END FOR  
END FUNCTION
################################################################################
# Descriptions...: 檢查 g_gzzc_d array 從後面數過來 是否有設定參數值明
# Memo...........:
# Usage..........: CALL azzi900_02_chk_arr()
#                  RETURNING 回传参数
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi900_02_chk_arr()
   DEFINE li  LIKE type_t.num5 

   FOR li = g_gzzc_d.getLength() TO 1 STEP -1
       IF cl_null(g_gzzc_d[li].var_value) THEN 
          CALL g_gzzc_d.deleteElement(li)
       ELSE 
          EXIT FOR    
       END IF  
   END FOR
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
PRIVATE FUNCTION azzi900_02_set_no_entry()
   DEFINE p_cmd   LIKE type_t.chr1
   CALL cl_set_comp_entry("gzzc002,gzzc003",FALSE)
END FUNCTION
################################################################################
# Descriptions...: 把參數組合起來每個參數個加" " ex:"A"
# Memo...........:
# Usage..........: CALL azzi900_02_compose_param()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi900_02_compose_param()
   DEFINE li  LIKE type_t.num5 
   DEFINE ls_temp STRING 
   #判斷最後陣列是否有設定值
   CALL azzi900_02_chk_arr()
   FOR li =  1 TO g_gzzc_d.getLength()
      IF cl_null(g_gzzc_d[li].var_value) THEN  
         LET ls_temp = ls_temp,"\"\" "   
      ELSE 
         LET ls_temp = ls_temp,"\"",azzi900_02_chk_var_value(g_gzzc_d[li].var_value),"\" "
      END IF   
   END FOR 
   #display "ls_temp:",ls_temp
   RETURN ls_temp.trim()
END FUNCTION
################################################################################
# Descriptions...: 檢核雙引號發現有雙引號後前面補一個\"
# Memo...........:
# Usage..........: CALL azzi900_02_chk_var_value(ps_value)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi900_02_chk_var_value(ps_value)
   DEFINE ps_value STRING 
   
   LET ps_value = ps_value.trim()
   
   IF ps_value.getIndexOf("\"",1) THEN 
      #找到在引號"前面就補一個\
      LET ps_value = azzi900_02_quote_value_fill_recurs(ps_value,ps_value.getIndexOf("\"",1))
   END IF 
   #DISPLAY "chk_var_value ps_value:",ps_value
   RETURN ps_value
END FUNCTION
################################################################################
# Descriptions...: 遞回搜尋" 找到在引號"前面就補一個\
# Memo...........:
# Usage..........: CALL azzi900_02_quote_value_fill_recurs(ps_value,pi_index)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi900_02_quote_value_fill_recurs(ps_value,pi_index)
   DEFINE ps_value STRING  
   DEFINE pi_index LIKE type_t.num5
   DEFINE ls_tmp STRING 

   LET ls_tmp = ps_value
   IF ls_tmp.getIndexOf("\"",pi_index) THEN
      IF pi_index = 1 AND pi_index = ls_tmp.getLength() THEN 
         LET ps_value = "\\",ls_tmp.subString(1,pi_index)
         RETURN ps_value
      END IF 
      IF pi_index = ls_tmp.getLength() THEN 
         LET ps_value = ls_tmp.subString(1,pi_index-1),"\\",ls_tmp.subString(pi_index,ls_tmp.getLength())
         RETURN ps_value
      END IF 
      LET ps_value = ls_tmp.subString(1,pi_index-1),"\\",ls_tmp.subString(pi_index,ls_tmp.getLength())
      CALL azzi900_02_quote_value_fill_recurs(ps_value,ps_value.getIndexOf("\"",(pi_index + 2)))RETURNING ps_value
   END IF 
   
   #DISPLAY "1111 ps_value:",ps_value
   RETURN ps_value
END FUNCTION

 
{</section>}
 
