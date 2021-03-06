#該程式未解開Section, 採用最新樣板產出!
{<section id="aimm200_05.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2016-07-19 15:53:17), PR版次:0002(2016-12-07 14:05:54)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000021
#+ Filename...: aimm200_05
#+ Description: 產品庫存特徵值
#+ Creator....: 01534(2016-07-19 15:50:11)
#+ Modifier...: 01534 -SD/PR- 08734
 
{</section>}
 
{<section id="aimm200_05.global" >}
#應用 c02b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#Memos
#161124-00048#2   2016/12/07  By 08734    星号整批调整
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_imas_d        RECORD
       imas001 LIKE imas_t.imas001, 
   l_imas003_01 LIKE type_t.chr30, 
   l_imas003_01_desc LIKE type_t.chr500, 
   l_imas004_01 LIKE type_t.chr30, 
   l_imas003_02 LIKE type_t.chr30, 
   l_imas003_02_desc LIKE type_t.chr500, 
   l_imas004_02 LIKE type_t.chr500, 
   l_imas003_03 LIKE type_t.chr30, 
   l_imas003_03_desc LIKE type_t.chr500, 
   l_imas004_03 LIKE type_t.chr500, 
   l_imas003_04 LIKE type_t.chr30, 
   l_imas003_04_desc LIKE type_t.chr500, 
   l_imas004_04 LIKE type_t.chr500, 
   l_imas003_05 LIKE type_t.chr30, 
   l_imas003_05_desc LIKE type_t.chr500, 
   l_imas004_05 LIKE type_t.chr500, 
   l_imas003_06 LIKE type_t.chr30, 
   l_imas003_06_desc LIKE type_t.chr500, 
   l_imas004_06 LIKE type_t.chr500, 
   l_imas003_07 LIKE type_t.chr30, 
   l_imas003_07_desc LIKE type_t.chr500, 
   l_imas004_07 LIKE type_t.chr500, 
   l_imas003_08 LIKE type_t.chr30, 
   l_imas003_08_desc LIKE type_t.chr500, 
   l_imas004_08 LIKE type_t.chr500, 
   l_imas003_09 LIKE type_t.chr30, 
   l_imas003_09_desc LIKE type_t.chr500, 
   l_imas004_09 LIKE type_t.chr500, 
   l_imas003_10 LIKE type_t.chr30, 
   l_imas003_10_desc LIKE type_t.chr500, 
   l_imas004_10 LIKE type_t.chr500
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_wc2_m20005      STRING            
DEFINE g_d_idx_m20005    LIKE type_t.num5   
DEFINE g_d_cnt_m20005    LIKE type_t.num5  
GLOBALS
   DEFINE global_g_imas_d      DYNAMIC ARRAY OF type_g_imas_d
   DEFINE g_detail_insert      LIKE type_t.num5   #單身的新增權限
   DEFINE g_detail_delete      LIKE type_t.num5   #單身的刪除權限 
   DEFINE g_appoint_idx        LIKE type_t.num5   #指定進入單身行數   
   DEFINE g_imas001            LIKE imas_t.imas001
   DEFINE g_imaa005            LIKE imaa_t.imaa005   
DEFINE g_imastext DYNAMIC ARRAY OF RECORD
           detail    DYNAMIC ARRAY OF RECORD
          imas002    LIKE imas_t.imas002
             END RECORD
       END RECORD   
END GLOBALS

#end add-point
 
DEFINE g_imas_d          DYNAMIC ARRAY OF type_g_imas_d
DEFINE g_imas_d_t        type_g_imas_d
 
 
DEFINE g_imas001_t   LIKE imas_t.imas001    #Key值備份
DEFINE g_imas002_t      LIKE imas_t.imas002    #Key值備份
DEFINE g_imas003_t      LIKE imas_t.imas003    #Key值備份
 
 
DEFINE l_ac                  LIKE type_t.num10
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rec_b               LIKE type_t.num10 
DEFINE g_detail_idx          LIKE type_t.num10
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
    
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point    
 
{</section>}
 
{<section id="aimm200_05.input" >}
#+ 資料輸入
PUBLIC FUNCTION aimm200_05(--)
   #add-point:input段變數傳入 name="input.get_var"
   
   #end add-point
   )
   #add-point:input段define name="input.define_customerization"
   
   #end add-point
   DEFINE l_ac_t          LIKE type_t.num10       #未取消的ARRAY CNT 
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num10
   DEFINE l_insert        LIKE type_t.num5
   DEFINE l_cmd           LIKE type_t.chr5
   #add-point:input段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
 
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_aimm200_05 WITH FORM cl_ap_formpath("aim","aimm200_05")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單身前置處理 name="input.pre_input"
   
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT ARRAY g_imas_d FROM s_detail1_aimm200_05.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
         
         #自訂ACTION
         #add-point:單身前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(detail_input)
         
         
         BEFORE INPUT
            #add-point:單身輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imas001
            #add-point:BEFORE FIELD imas001 name="input.b.page1_aimm200_05.imas001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imas001
            
            #add-point:AFTER FIELD imas001 name="input.a.page1_aimm200_05.imas001"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
#            IF  g_imas_d[g_detail_idx].imas001 IS NOT NULL AND g_imas_d[g_detail_idx].imas002 IS NOT NULL AND g_imas_d[g_detail_idx].imas003 IS NOT NULL THEN 
#               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_imas_d[g_detail_idx].imas001 != g_imas_d_t.imas001 OR g_imas_d[g_detail_idx].imas002 != g_imas_d_t.imas002 OR g_imas_d[g_detail_idx].imas003 != g_imas_d_t.imas003)) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM imas_t WHERE "||"imasent = '" ||g_enterprise|| "' AND "||"imas001 = '"||g_imas_d[g_detail_idx].imas001 ||"' AND "|| "imas002 = '"||g_imas_d[g_detail_idx].imas002 ||"' AND "|| "imas003 = '"||g_imas_d[g_detail_idx].imas003 ||"'",'std-00004',0) THEN 
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imas001
            #add-point:ON CHANGE imas001 name="input.g.page1_aimm200_05.imas001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_imas003_01
            
            #add-point:AFTER FIELD l_imas003_01 name="input.a.page1_aimm200_05.l_imas003_01"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_imas003_01
            #add-point:BEFORE FIELD l_imas003_01 name="input.b.page1_aimm200_05.l_imas003_01"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_imas003_01
            #add-point:ON CHANGE l_imas003_01 name="input.g.page1_aimm200_05.l_imas003_01"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_imas004_01
            #add-point:BEFORE FIELD l_imas004_01 name="input.b.page1_aimm200_05.l_imas004_01"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_imas004_01
            
            #add-point:AFTER FIELD l_imas004_01 name="input.a.page1_aimm200_05.l_imas004_01"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_imas004_01
            #add-point:ON CHANGE l_imas004_01 name="input.g.page1_aimm200_05.l_imas004_01"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_imas003_02
            
            #add-point:AFTER FIELD l_imas003_02 name="input.a.page1_aimm200_05.l_imas003_02"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_imas003_02
            #add-point:BEFORE FIELD l_imas003_02 name="input.b.page1_aimm200_05.l_imas003_02"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_imas003_02
            #add-point:ON CHANGE l_imas003_02 name="input.g.page1_aimm200_05.l_imas003_02"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_imas003_03
            
            #add-point:AFTER FIELD l_imas003_03 name="input.a.page1_aimm200_05.l_imas003_03"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_imas003_03
            #add-point:BEFORE FIELD l_imas003_03 name="input.b.page1_aimm200_05.l_imas003_03"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_imas003_03
            #add-point:ON CHANGE l_imas003_03 name="input.g.page1_aimm200_05.l_imas003_03"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_imas003_04
            
            #add-point:AFTER FIELD l_imas003_04 name="input.a.page1_aimm200_05.l_imas003_04"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_imas003_04
            #add-point:BEFORE FIELD l_imas003_04 name="input.b.page1_aimm200_05.l_imas003_04"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_imas003_04
            #add-point:ON CHANGE l_imas003_04 name="input.g.page1_aimm200_05.l_imas003_04"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_imas003_05
            
            #add-point:AFTER FIELD l_imas003_05 name="input.a.page1_aimm200_05.l_imas003_05"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_imas003_05
            #add-point:BEFORE FIELD l_imas003_05 name="input.b.page1_aimm200_05.l_imas003_05"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_imas003_05
            #add-point:ON CHANGE l_imas003_05 name="input.g.page1_aimm200_05.l_imas003_05"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_imas003_06
            
            #add-point:AFTER FIELD l_imas003_06 name="input.a.page1_aimm200_05.l_imas003_06"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_imas003_06
            #add-point:BEFORE FIELD l_imas003_06 name="input.b.page1_aimm200_05.l_imas003_06"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_imas003_06
            #add-point:ON CHANGE l_imas003_06 name="input.g.page1_aimm200_05.l_imas003_06"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_imas003_07
            
            #add-point:AFTER FIELD l_imas003_07 name="input.a.page1_aimm200_05.l_imas003_07"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_imas003_07
            #add-point:BEFORE FIELD l_imas003_07 name="input.b.page1_aimm200_05.l_imas003_07"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_imas003_07
            #add-point:ON CHANGE l_imas003_07 name="input.g.page1_aimm200_05.l_imas003_07"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_imas003_08
            
            #add-point:AFTER FIELD l_imas003_08 name="input.a.page1_aimm200_05.l_imas003_08"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_imas003_08
            #add-point:BEFORE FIELD l_imas003_08 name="input.b.page1_aimm200_05.l_imas003_08"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_imas003_08
            #add-point:ON CHANGE l_imas003_08 name="input.g.page1_aimm200_05.l_imas003_08"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_imas003_09
            
            #add-point:AFTER FIELD l_imas003_09 name="input.a.page1_aimm200_05.l_imas003_09"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_imas003_09
            #add-point:BEFORE FIELD l_imas003_09 name="input.b.page1_aimm200_05.l_imas003_09"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_imas003_09
            #add-point:ON CHANGE l_imas003_09 name="input.g.page1_aimm200_05.l_imas003_09"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_imas003_10
            
            #add-point:AFTER FIELD l_imas003_10 name="input.a.page1_aimm200_05.l_imas003_10"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_imas003_10
            #add-point:BEFORE FIELD l_imas003_10 name="input.b.page1_aimm200_05.l_imas003_10"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_imas003_10
            #add-point:ON CHANGE l_imas003_10 name="input.g.page1_aimm200_05.l_imas003_10"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1_aimm200_05.imas001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imas001
            #add-point:ON ACTION controlp INFIELD imas001 name="input.c.page1_aimm200_05.imas001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aimm200_05.l_imas003_01
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_imas003_01
            #add-point:ON ACTION controlp INFIELD l_imas003_01 name="input.c.page1_aimm200_05.l_imas003_01"
 
            #END add-point
 
 
         #Ctrlp:input.c.page1_aimm200_05.l_imas004_01
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_imas004_01
            #add-point:ON ACTION controlp INFIELD l_imas004_01 name="input.c.page1_aimm200_05.l_imas004_01"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aimm200_05.l_imas003_02
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_imas003_02
            #add-point:ON ACTION controlp INFIELD l_imas003_02 name="input.c.page1_aimm200_05.l_imas003_02"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aimm200_05.l_imas003_03
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_imas003_03
            #add-point:ON ACTION controlp INFIELD l_imas003_03 name="input.c.page1_aimm200_05.l_imas003_03"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aimm200_05.l_imas003_04
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_imas003_04
            #add-point:ON ACTION controlp INFIELD l_imas003_04 name="input.c.page1_aimm200_05.l_imas003_04"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aimm200_05.l_imas003_05
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_imas003_05
            #add-point:ON ACTION controlp INFIELD l_imas003_05 name="input.c.page1_aimm200_05.l_imas003_05"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aimm200_05.l_imas003_06
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_imas003_06
            #add-point:ON ACTION controlp INFIELD l_imas003_06 name="input.c.page1_aimm200_05.l_imas003_06"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aimm200_05.l_imas003_07
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_imas003_07
            #add-point:ON ACTION controlp INFIELD l_imas003_07 name="input.c.page1_aimm200_05.l_imas003_07"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aimm200_05.l_imas003_08
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_imas003_08
            #add-point:ON ACTION controlp INFIELD l_imas003_08 name="input.c.page1_aimm200_05.l_imas003_08"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aimm200_05.l_imas003_09
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_imas003_09
            #add-point:ON ACTION controlp INFIELD l_imas003_09 name="input.c.page1_aimm200_05.l_imas003_09"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aimm200_05.l_imas003_10
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_imas003_10
            #add-point:ON ACTION controlp INFIELD l_imas003_10 name="input.c.page1_aimm200_05.l_imas003_10"
            
            #END add-point
 
 
 
 
         #自訂ACTION
         #add-point:單身其他段落處理(EX:on row change, etc...) name="input.other"
         
         #end add-point
 
         AFTER INPUT
            #add-point:單身輸入後處理 name="input.after_input"
            
            #end add-point
            
      END INPUT
      
 
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      #公用action
      ON ACTION accept
         ACCEPT DIALOG
        
      ON ACTION cancel
         #add-point:cancel name="input.cancel"
         
         #end add-point
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
 
   #add-point:畫面關閉前 name="input.before_close"
   
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_aimm200_05 
   
   #add-point:input段after input name="input.post_input"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aimm200_05.other_dialog" readonly="Y" >}

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aimm200_05_display()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
DIALOG aimm200_05_display()
   DISPLAY ARRAY g_imas_d TO s_detail1_aimm200_05.* ATTRIBUTE(COUNT=g_d_cnt_m20005)
   
      BEFORE DISPLAY
         CALL aimm200_05_default_hide()
         CALL aimm200_05_show(g_imas001,g_imaa005)
         #CALL FGL_SET_ARR_CURR(g_d_idx_m20005)
         #單身不連動, 所以進入單身時, 要重新顯示單身筆數
         DISPLAY g_d_idx_m20005, g_d_cnt_m20005 TO FORMONLY.idx, FORMONLY.cnt

      BEFORE ROW
         LET g_d_idx_m20005 = DIALOG.getCurrentRow("s_detail1_aimm200_05")
         DISPLAY g_d_idx_m20005 TO FORMONLY.idx
         # 點的當筆放入g_appoint_idx中, 可讓雙擊直接進入指定筆
         #LET g_detail_idx = g_d_idx_m20005
         LET g_appoint_idx = g_d_idx_m20005
      AFTER DISPLAY 
      
   END DISPLAY
   
END DIALOG

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aimm200_05_input()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
DIALOG aimm200_05_input()
   DEFINE l_ac_t          LIKE type_t.num5        #未取消的ARRAY CNT   
   DEFINE l_count         LIKE type_t.num5
   DEFINE l_insert        LIKE type_t.num5
   DEFINE l_cmd           LIKE type_t.chr5
   DEFINE l_lock_sw       LIKE type_t.chr1
   DEFINE l_forupd_sql    STRING
   DEFINE l_n             LIKE type_t.num5                #檢查重複用  
   DEFINE l_cnt           LIKE type_t.num5
   #DEFINE l_imak          RECORD LIKE imak_t.*  #161124-00048#2   2016/12/07 By 08734 mark
   #161124-00048#2   2016/12/07 By 08734 add(S)
   DEFINE l_imak RECORD  #料件特徵檔
       imakent LIKE imak_t.imakent, #企业编号
       imak001 LIKE imak_t.imak001, #料件编号
       imak002 LIKE imak_t.imak002, #特征类型
       imak003 LIKE imak_t.imak003 #特征值
END RECORD
#161124-00048#2   2016/12/07 By 08734 add(E)
   DEFINE l_imeb005       LIKE imeb_t.imeb005
   DEFINE l_errno         LIKE gzze_t.gzze001
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_cn            LIKE type_t.num5
   
#   INPUT ARRAY g_imas_d FROM s_detail1_aimm200_05.*
#          ATTRIBUTE(COUNT = g_d_cnt_m20005,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
#                  INSERT ROW = g_detail_insert, 
#                  DELETE ROW = g_detail_delete,
#                  APPEND ROW = g_detail_insert)

      INPUT ARRAY g_imas_d FROM s_detail1_aimm200_05.*
          ATTRIBUTE(COUNT = g_d_cnt_m20005,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = g_detail_insert, 
                  DELETE ROW = g_detail_delete,
                  APPEND ROW = g_detail_insert)
         
         #自訂ACTION
         #add-point:單身前置處理

         #end add-point
         
         #自訂ACTION(detail_input)
         
         
         BEFORE INPUT
            #add-point:單身輸入前處理
            WHENEVER ERROR CALL cl_err_msg_log
            CALL aimm200_05_default_hide()
            CALL aimm200_05_show(g_imas001,g_imaa005)
            CALL aimm200_05_get_imas002(g_imaa005)  #获取特征类型            

#            LET l_forupd_sql = " SELECT imak001,imak002,'',imak003 ",
#                               "   FROM imak_t ",
#                               "  WHERE imakent = '",g_enterprise,"' ",
#                               "    AND imak001 = ? AND imak002 = ? FOR UPDATE"
#            LET l_forupd_sql = cl_sql_forupd(l_forupd_sql)
#            
#            PREPARE aimm200_01_dialog_b FROM l_forupd_sql
#            DECLARE aimm200_01_dialog_bcl CURSOR FOR aimm200_01_dialog_b
            
            IF g_appoint_idx > 0 THEN
               CALL DIALOG.setCurrentRow("s_detail1_aimm200_05",g_appoint_idx)
            END IF   
            NEXT FIELD l_imas003_01            
            #end add-point
         
         BEFORE ROW
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
           
            LET g_rec_b = g_imas_d.getLength()
            
            IF g_rec_b >= l_ac THEN
               LET l_cmd='u'
			      LET g_imas_d_t.* = g_imas_d[l_ac].*  #BACKUP
			      
			      #判斷是否可以進入產品特徵欄位
               CALL fgl_set_arr_curr(l_ac)
               
            ELSE
               LET l_cmd='a'
            END IF       


         BEFORE INSERT
            CALL s_transaction_begin()
            LET l_cmd = 'a'
            INITIALIZE g_imas_d_t.* TO NULL
            INITIALIZE g_imas_d[l_ac].* TO NULL 
            
            LET g_imas_d_t.* = g_imas_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()           
             
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imas001
            #add-point:BEFORE FIELD imas001 name="input.b.page1_aimm200_05.imas001"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imas001
            
            #add-point:AFTER FIELD imas001 name="input.a.page1_aimm200_05.imas001"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複




            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imas001
            #add-point:ON CHANGE imas001 name="input.g.page1_aimm200_05.imas001"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_imas003_01
            #add-point:BEFORE FIELD l_imas003_01 name="input.b.page1_aimm200_05.l_imas003_01"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_imas003_01
            
            #add-point:AFTER FIELD l_imas003_01 name="input.a.page1_aimm200_05.l_imas003_01"
            IF NOT cl_null(g_imas_d[l_ac].l_imas003_01) THEN
               IF g_imas_d[l_ac].l_imas003_01 <> g_imas_d_t.l_imas003_01 OR cl_null(g_imas_d_t.l_imas003_01)  THEN
                  IF NOT aimm200_05_imas003_chk(g_imastext[1].detail[1].imas002,g_imas_d[l_ac].l_imas003_01) THEN
                     LET g_imas_d[l_ac].l_imas003_01 = g_imas_d_t.l_imas003_01
                     CALL aimm200_05_get_imas_desc(g_imastext[1].detail[1].imas002,g_imas_d[l_ac].l_imas003_01) 
                          RETURNING g_imas_d[l_ac].l_imas003_01_desc
                     NEXT FIELD l_imas003_01
                  END IF
               
                  CALL s_aimi092_chk_eigenvalue(g_imaa005,g_imastext[1].detail[1].imas002,g_imas_d[l_ac].l_imas003_01,g_imas001,'1') 
                       RETURNING  l_success,l_errno,g_imas_d[l_ac].l_imas003_01 
                  IF NOT cl_null(l_errno) THEN    
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = l_errno
                     LET g_errparam.extend = g_imas_d[l_ac].l_imas003_01
                     LET g_errparam.popup = TRUE
                     CALL cl_err()                  
                     NEXT FIELD l_imas003_01
                  END IF
                
                  #若賦值方式=3.限定範圍
                  #1.檢查起須<迄
                  #2.檢查起、迄不可在同特徵類型的其他起迄區間內
                  IF NOT aimm200_05_imas003_imas004_compare(g_imastext[1].detail[1].imas002,g_imas_d[l_ac].l_imas003_01,g_imas_d[l_ac].l_imas004_01,g_imas_d_t.l_imas003_01,g_imas_d_t.l_imas004_01) THEN
                     LET g_imas_d[l_ac].l_imas003_01 = g_imas_d_t.l_imas003_01
                     CALL aimm200_05_get_imas_desc(g_imastext[1].detail[1].imas002,g_imas_d[l_ac].l_imas003_01) 
                          RETURNING g_imas_d[l_ac].l_imas003_01_desc                  
                     NEXT FIELD l_imas003_01
                  END IF               
                  #INSERT INTO imas_t
                  IF NOT aimm200_05_ins_imas('1',g_imas_d[l_ac].l_imas003_01,g_imas_d[l_ac].l_imas004_01,g_imas_d_t.l_imas003_01) THEN
                     LET g_imas_d[l_ac].l_imas003_01 = g_imas_d_t.l_imas003_01
                     CALL aimm200_05_get_imas_desc(g_imastext[1].detail[1].imas002,g_imas_d[l_ac].l_imas003_01) 
                          RETURNING g_imas_d[l_ac].l_imas003_01_desc                  
                     NEXT FIELD l_imas003_01
                  END IF
               END IF
            ELSE
               IF NOT aimm200_05_ins_imas('1',g_imas_d[l_ac].l_imas003_01,g_imas_d[l_ac].l_imas004_01,g_imas_d_t.l_imas003_01) THEN
                  LET g_imas_d[l_ac].l_imas003_01 = g_imas_d_t.l_imas003_01 
                  CALL aimm200_05_get_imas_desc(g_imastext[1].detail[1].imas002,g_imas_d[l_ac].l_imas003_01) 
                       RETURNING g_imas_d[l_ac].l_imas003_01_desc               
                  NEXT FIELD l_imas003_01
               END IF  
               LET g_imas_d[l_ac].l_imas004_01 = ''               
            END IF
            CALL aimm200_05_get_imas_desc(g_imastext[1].detail[1].imas002,g_imas_d[l_ac].l_imas003_01) 
                 RETURNING g_imas_d[l_ac].l_imas003_01_desc
                 
            LET g_imas_d_t.l_imas003_01 = g_imas_d[l_ac].l_imas003_01
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_imas003_01
            #add-point:ON CHANGE l_imas003_01 name="input.g.page1_aimm200_05.l_imas003_01"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_imas004_01
            #add-point:BEFORE FIELD l_imas004_01 name="input.b.page1_aimm200_05.l_imas004_01"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_imas004_01
            
            #add-point:AFTER FIELD l_imas004_01 name="input.a.page1_aimm200_05.l_imas004_01"
            IF NOT cl_null(g_imas_d[l_ac].l_imas004_01) THEN
               IF g_imas_d[l_ac].l_imas004_01 <> g_imas_d_t.l_imas004_01 OR cl_null(g_imas_d_t.l_imas004_01)  THEN
 
                  CALL s_aimi092_chk_eigenvalue(g_imaa005,g_imastext[1].detail[1].imas002,g_imas_d[l_ac].l_imas004_01,g_imas001,'1') 
                          RETURNING  l_success,l_errno,g_imas_d[l_ac].l_imas004_01 
                  IF NOT cl_null(l_errno) THEN  
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = l_errno
                     LET g_errparam.extend = g_imas_d[l_ac].l_imas004_01
                     LET g_errparam.popup = TRUE
                     CALL cl_err()                  
                     LET g_imas_d[l_ac].l_imas004_01 = g_imas_d_t.l_imas004_01                 
                     NEXT FIELD l_imas004_01
                  END IF

               #若賦值方式=3.限定範圍
               #1.檢查起須<迄
               #2.檢查起、迄不可在同特徵類型的其他起迄區間內
                  IF NOT aimm200_05_imas003_imas004_compare(g_imastext[1].detail[1].imas002,g_imas_d[l_ac].l_imas003_01,g_imas_d[l_ac].l_imas004_01,g_imas_d_t.l_imas003_01,g_imas_d_t.l_imas004_01) THEN
                     LET g_imas_d[l_ac].l_imas004_01 = g_imas_d_t.l_imas004_01    
                     NEXT FIELD l_imas004_01
                  END IF               
                  #INSERT INTO imas_t
                  IF NOT aimm200_05_upd_imas('1',g_imas_d[l_ac].l_imas003_01,g_imas_d[l_ac].l_imas004_01) THEN
                     LET g_imas_d[l_ac].l_imas004_01 = g_imas_d_t.l_imas004_01   
                     NEXT FIELD l_imas004_01
                  END IF
               END IF
            
            END IF
            LET g_imas_d_t.l_imas004_01 = g_imas_d[l_ac].l_imas004_01
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_imas004_01
            #add-point:ON CHANGE l_imas004_01 name="input.g.page1_aimm200_05.l_imas004_01"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_imas003_02
            #add-point:BEFORE FIELD l_imas003_02 name="input.b.page1_aimm200_05.l_imas003_02"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_imas003_02
            
            #add-point:AFTER FIELD l_imas003_02 name="input.a.page1_aimm200_05.l_imas003_02"
            IF NOT cl_null(g_imas_d[l_ac].l_imas003_02) THEN
               IF g_imas_d[l_ac].l_imas003_02 <> g_imas_d_t.l_imas003_02 OR cl_null(g_imas_d_t.l_imas003_02)  THEN
                  IF NOT aimm200_05_imas003_chk(g_imastext[1].detail[2].imas002,g_imas_d[l_ac].l_imas003_02) THEN
                     LET g_imas_d[l_ac].l_imas003_02 = g_imas_d_t.l_imas003_02
                     CALL aimm200_05_get_imas_desc(g_imastext[1].detail[2].imas002,g_imas_d[l_ac].l_imas003_02) 
                          RETURNING g_imas_d[l_ac].l_imas003_02_desc                         
                     NEXT FIELD l_imas003_02
                  END IF
               
                  CALL s_aimi092_chk_eigenvalue(g_imaa005,g_imastext[1].detail[2].imas002,g_imas_d[l_ac].l_imas003_02,g_imas001,'1') 
                       RETURNING  l_success,l_errno,g_imas_d[l_ac].l_imas003_02 
                  IF NOT cl_null(l_errno) THEN     
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = l_errno
                     LET g_errparam.extend = g_imas_d[l_ac].l_imas003_02 
                     LET g_errparam.popup = TRUE
                     CALL cl_err()                  
                     LET g_imas_d[l_ac].l_imas003_02 = g_imas_d_t.l_imas003_02
                     CALL aimm200_05_get_imas_desc(g_imastext[1].detail[2].imas002,g_imas_d[l_ac].l_imas003_02) 
                          RETURNING g_imas_d[l_ac].l_imas003_02_desc                          
                     NEXT FIELD l_imas003_02
                  END IF
                 
                  #若賦值方式=3.限定範圍
                  #1.檢查起須<迄
                  #2.檢查起、迄不可在同特徵類型的其他起迄區間內
                  IF NOT aimm200_05_imas003_imas004_compare(g_imastext[1].detail[2].imas002,g_imas_d[l_ac].l_imas003_02,g_imas_d[l_ac].l_imas004_02,g_imas_d_t.l_imas003_02,g_imas_d_t.l_imas004_02) THEN
                     LET g_imas_d[l_ac].l_imas003_02 = g_imas_d_t.l_imas003_02
                     CALL aimm200_05_get_imas_desc(g_imastext[1].detail[2].imas002,g_imas_d[l_ac].l_imas003_02) 
                          RETURNING g_imas_d[l_ac].l_imas003_02_desc                          
                     NEXT FIELD l_imas003_02
                  END IF               
                  #INSERT INTO imas_t
                  IF NOT aimm200_05_ins_imas('2',g_imas_d[l_ac].l_imas003_02,g_imas_d[l_ac].l_imas004_02,g_imas_d_t.l_imas003_02) THEN
                     LET g_imas_d[l_ac].l_imas003_02 = g_imas_d_t.l_imas003_02
                     CALL aimm200_05_get_imas_desc(g_imastext[1].detail[2].imas002,g_imas_d[l_ac].l_imas003_02) 
                          RETURNING g_imas_d[l_ac].l_imas003_02_desc                          
                     NEXT FIELD l_imas003_02
                  END IF
               END IF
            ELSE
               IF NOT aimm200_05_ins_imas('2',g_imas_d[l_ac].l_imas003_02,g_imas_d[l_ac].l_imas004_02,g_imas_d_t.l_imas003_02) THEN
                  LET g_imas_d[l_ac].l_imas003_02 = g_imas_d_t.l_imas003_02
                  CALL aimm200_05_get_imas_desc(g_imastext[1].detail[2].imas002,g_imas_d[l_ac].l_imas003_02) 
                       RETURNING g_imas_d[l_ac].l_imas003_02_desc                       
                  NEXT FIELD l_imas003_02
               END IF    
               LET g_imas_d[l_ac].l_imas004_02 = ''                
            END IF
            CALL aimm200_05_get_imas_desc(g_imastext[1].detail[2].imas002,g_imas_d[l_ac].l_imas003_02) 
                 RETURNING g_imas_d[l_ac].l_imas003_02_desc            
            LET g_imas_d_t.l_imas003_02 = g_imas_d[l_ac].l_imas003_02
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_imas003_02
            #add-point:ON CHANGE l_imas003_02 name="input.g.page1_aimm200_05.l_imas003_02"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_imas004_02
            #add-point:BEFORE FIELD l_imas004_02 name="input.b.page1_aimm200_05.l_imas004_02"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_imas004_02
            
            #add-point:AFTER FIELD l_imas004_02 name="input.a.page1_aimm200_05.l_imas004_02"
            IF NOT cl_null(g_imas_d[l_ac].l_imas004_02) THEN
               IF g_imas_d[l_ac].l_imas004_02 <> g_imas_d_t.l_imas004_02 OR cl_null(g_imas_d_t.l_imas004_02)  THEN

 
               CALL s_aimi092_chk_eigenvalue(g_imaa005,g_imastext[1].detail[2].imas002,g_imas_d[l_ac].l_imas004_02,g_imas001,'1')
                       RETURNING  l_success,l_errno,g_imas_d[l_ac].l_imas004_02
               IF NOT cl_null(l_errno) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_imas_d[l_ac].l_imas004_02
                  LET g_errparam.popup = TRUE
                  CALL cl_err()            
                  LET g_imas_d[l_ac].l_imas004_02 = g_imas_d_t.l_imas004_02              
                  NEXT FIELD l_imas004_02
               END IF

               #若賦值方式=3.限定範圍
               #1.檢查起須<迄
               #2.檢查起、迄不可在同特徵類型的其他起迄區間內
                  IF NOT aimm200_05_imas003_imas004_compare(g_imastext[1].detail[2].imas002,g_imas_d[l_ac].l_imas003_02,g_imas_d[l_ac].l_imas004_02,g_imas_d_t.l_imas003_02,g_imas_d_t.l_imas004_02) THEN
                     LET g_imas_d[l_ac].l_imas004_02 = g_imas_d_t.l_imas004_02 
                     NEXT FIELD l_imas004_02
                  END IF               
                  #INSERT INTO imas_t
                  IF NOT aimm200_05_upd_imas('2',g_imas_d[l_ac].l_imas003_02,g_imas_d[l_ac].l_imas004_02) THEN
                     LET g_imas_d[l_ac].l_imas004_02 = g_imas_d_t.l_imas004_02 
                     NEXT FIELD l_imas004_02
                  END IF
               END IF
            END IF
            LET g_imas_d_t.l_imas004_02 = g_imas_d[l_ac].l_imas004_02
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_imas004_02
            #add-point:ON CHANGE l_imas004_02 name="input.g.page1_aimm200_05.l_imas004_02"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_imas003_03
            #add-point:BEFORE FIELD l_imas003_03 name="input.b.page1_aimm200_05.l_imas003_03"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_imas003_03
            
            #add-point:AFTER FIELD l_imas003_03 name="input.a.page1_aimm200_05.l_imas003_03"
            IF NOT cl_null(g_imas_d[l_ac].l_imas003_03) THEN
               IF g_imas_d[l_ac].l_imas003_03 <> g_imas_d_t.l_imas003_03 OR cl_null(g_imas_d_t.l_imas003_03)  THEN
                  IF NOT aimm200_05_imas003_chk(g_imastext[1].detail[3].imas002,g_imas_d[l_ac].l_imas003_03) THEN
                  LET g_imas_d[l_ac].l_imas003_03 = g_imas_d_t.l_imas003_03
                  CALL aimm200_05_get_imas_desc(g_imastext[1].detail[3].imas002,g_imas_d[l_ac].l_imas003_03) 
                       RETURNING g_imas_d[l_ac].l_imas003_03_desc                     
                     NEXT FIELD l_imas003_03
                  END IF
               
                  CALL s_aimi092_chk_eigenvalue(g_imaa005,g_imastext[1].detail[3].imas002,g_imas_d[l_ac].l_imas003_03,g_imas001,'1') 
                       RETURNING  l_success,l_errno,g_imas_d[l_ac].l_imas003_03 
                  IF NOT cl_null(l_errno) THEN    
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = l_errno
                     LET g_errparam.extend = g_imas_d[l_ac].l_imas003_03
                     LET g_errparam.popup = TRUE
                     CALL cl_err()                   
                     LET g_imas_d[l_ac].l_imas003_03 = g_imas_d_t.l_imas003_03
                     CALL aimm200_05_get_imas_desc(g_imastext[1].detail[3].imas002,g_imas_d[l_ac].l_imas003_03) 
                          RETURNING g_imas_d[l_ac].l_imas003_03_desc                        
                     NEXT FIELD l_imas003_03
                  END IF
                
                  #若賦值方式=3.限定範圍
                  #1.檢查起須<迄
                  #2.檢查起、迄不可在同特徵類型的其他起迄區間內
                  IF NOT aimm200_05_imas003_imas004_compare(g_imastext[1].detail[3].imas002,g_imas_d[l_ac].l_imas003_03,g_imas_d[l_ac].l_imas004_03,g_imas_d_t.l_imas003_03,g_imas_d_t.l_imas004_03) THEN
                     LET g_imas_d[l_ac].l_imas003_03 = g_imas_d_t.l_imas003_03
                     CALL aimm200_05_get_imas_desc(g_imastext[1].detail[3].imas002,g_imas_d[l_ac].l_imas003_03) 
                          RETURNING g_imas_d[l_ac].l_imas003_03_desc                        
                     NEXT FIELD l_imas003_03
                  END IF               
                  #INSERT INTO imas_t
                  IF NOT aimm200_05_ins_imas('3',g_imas_d[l_ac].l_imas003_03,g_imas_d[l_ac].l_imas004_03,g_imas_d_t.l_imas003_03) THEN
                     LET g_imas_d[l_ac].l_imas003_03 = g_imas_d_t.l_imas003_03
                     CALL aimm200_05_get_imas_desc(g_imastext[1].detail[3].imas002,g_imas_d[l_ac].l_imas003_03) 
                          RETURNING g_imas_d[l_ac].l_imas003_03_desc                        
                     NEXT FIELD l_imas003_03
                  END IF
               END IF
            ELSE
               IF NOT aimm200_05_ins_imas('3',g_imas_d[l_ac].l_imas003_03,g_imas_d[l_ac].l_imas004_03,g_imas_d_t.l_imas003_03) THEN
                  LET g_imas_d[l_ac].l_imas003_03 = g_imas_d_t.l_imas003_03
                  CALL aimm200_05_get_imas_desc(g_imastext[1].detail[3].imas002,g_imas_d[l_ac].l_imas003_03) 
                       RETURNING g_imas_d[l_ac].l_imas003_03_desc                     
                  NEXT FIELD l_imas003_03
               END IF  
               LET g_imas_d[l_ac].l_imas004_03 = ''                
            END IF
            CALL aimm200_05_get_imas_desc(g_imastext[1].detail[3].imas002,g_imas_d[l_ac].l_imas003_03) 
                 RETURNING g_imas_d[l_ac].l_imas003_03_desc             
            LET g_imas_d_t.l_imas003_03 = g_imas_d[l_ac].l_imas003_03
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_imas003_03
            #add-point:ON CHANGE l_imas003_03 name="input.g.page1_aimm200_05.l_imas003_03"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_imas004_03
            #add-point:BEFORE FIELD l_imas004_03 name="input.b.page1_aimm200_05.l_imas004_03"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_imas004_03
            
            #add-point:AFTER FIELD l_imas004_03 name="input.a.page1_aimm200_05.l_imas004_03"
            IF NOT cl_null(g_imas_d[l_ac].l_imas004_03) THEN
               IF g_imas_d[l_ac].l_imas004_03 <> g_imas_d_t.l_imas004_03 OR cl_null(g_imas_d_t.l_imas004_03)  THEN
 
               CALL s_aimi092_chk_eigenvalue(g_imaa005,g_imastext[1].detail[3].imas002,g_imas_d[l_ac].l_imas004_03,g_imas001,'1') 
                       RETURNING  l_success,l_errno,g_imas_d[l_ac].l_imas004_03
               IF NOT cl_null(l_errno) THEN  
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_imas_d[l_ac].l_imas004_03
                  LET g_errparam.popup = TRUE
                  CALL cl_err()                 
                  LET g_imas_d[l_ac].l_imas004_03 = g_imas_d_t.l_imas004_03    
                  NEXT FIELD l_imas004_03
               END IF

               #若賦值方式=3.限定範圍
               #1.檢查起須<迄
               #2.檢查起、迄不可在同特徵類型的其他起迄區間內
                  IF NOT aimm200_05_imas003_imas004_compare(g_imastext[1].detail[3].imas002,g_imas_d[l_ac].l_imas003_03,g_imas_d[l_ac].l_imas004_03,g_imas_d_t.l_imas003_03,g_imas_d_t.l_imas004_03) THEN
                     LET g_imas_d[l_ac].l_imas004_03 = g_imas_d_t.l_imas004_03
                     NEXT FIELD l_imas004_03
                  END IF               
                  #INSERT INTO imas_t
                  IF NOT aimm200_05_upd_imas('3',g_imas_d[l_ac].l_imas003_03,g_imas_d[l_ac].l_imas004_03) THEN
                     LET g_imas_d[l_ac].l_imas004_03 = g_imas_d_t.l_imas004_03
                     NEXT FIELD l_imas004_03
                  END IF
               END IF
            END IF
            LET g_imas_d_t.l_imas004_03 = g_imas_d[l_ac].l_imas004_03
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_imas004_03
            #add-point:ON CHANGE l_imas004_03 name="input.g.page1_aimm200_05.l_imas004_03"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_imas003_04
            #add-point:BEFORE FIELD l_imas003_04 name="input.b.page1_aimm200_05.l_imas003_04"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_imas003_04
            
            #add-point:AFTER FIELD l_imas003_04 name="input.a.page1_aimm200_05.l_imas003_04"
            IF NOT cl_null(g_imas_d[l_ac].l_imas003_04) THEN
               IF g_imas_d[l_ac].l_imas003_04 <> g_imas_d_t.l_imas003_04 OR cl_null(g_imas_d_t.l_imas003_04)  THEN
                  IF NOT aimm200_05_imas003_chk(g_imastext[1].detail[4].imas002,g_imas_d[l_ac].l_imas003_04) THEN
                     LET g_imas_d[l_ac].l_imas003_04 = g_imas_d_t.l_imas003_04
                     CALL aimm200_05_get_imas_desc(g_imastext[1].detail[4].imas002,g_imas_d[l_ac].l_imas003_04) 
                          RETURNING g_imas_d[l_ac].l_imas003_04_desc                      
                     NEXT FIELD l_imas003_04
                  END IF
               
                  CALL s_aimi092_chk_eigenvalue(g_imaa005,g_imastext[1].detail[4].imas002,g_imas_d[l_ac].l_imas003_04,g_imas001,'1') 
                     RETURNING  l_success,l_errno,g_imas_d[l_ac].l_imas003_04
                  IF NOT cl_null(l_errno) THEN   
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = l_errno
                     LET g_errparam.extend = g_imas_d[l_ac].l_imas003_04
                     LET g_errparam.popup = TRUE
                     CALL cl_err()                     
                     LET g_imas_d[l_ac].l_imas003_04 = g_imas_d_t.l_imas003_04
                     CALL aimm200_05_get_imas_desc(g_imastext[1].detail[4].imas002,g_imas_d[l_ac].l_imas003_04) 
                          RETURNING g_imas_d[l_ac].l_imas003_04_desc                    
                     NEXT FIELD l_imas003_04
                  END IF
                
                  #若賦值方式=3.限定範圍
                  #1.檢查起須<迄
                  #2.檢查起、迄不可在同特徵類型的其他起迄區間內
                  IF NOT aimm200_05_imas003_imas004_compare(g_imastext[1].detail[4].imas002,g_imas_d[l_ac].l_imas003_04,g_imas_d[l_ac].l_imas004_04,g_imas_d_t.l_imas003_04,g_imas_d_t.l_imas004_04) THEN
                     LET g_imas_d[l_ac].l_imas003_04 = g_imas_d_t.l_imas003_04
                     CALL aimm200_05_get_imas_desc(g_imastext[1].detail[4].imas002,g_imas_d[l_ac].l_imas003_04) 
                          RETURNING g_imas_d[l_ac].l_imas003_04_desc                       
                     NEXT FIELD l_imas003_04
                  END IF               
                  #INSERT INTO imas_t
                  IF NOT aimm200_05_ins_imas('4',g_imas_d[l_ac].l_imas003_04,g_imas_d[l_ac].l_imas004_04,g_imas_d_t.l_imas003_04) THEN
                     LET g_imas_d[l_ac].l_imas003_04 = g_imas_d_t.l_imas003_04
                     CALL aimm200_05_get_imas_desc(g_imastext[1].detail[4].imas002,g_imas_d[l_ac].l_imas003_04) 
                          RETURNING g_imas_d[l_ac].l_imas003_04_desc                       
                     NEXT FIELD l_imas003_04
                  END IF
               END IF
            ELSE
               IF NOT aimm200_05_ins_imas('4',g_imas_d[l_ac].l_imas003_04,g_imas_d[l_ac].l_imas004_04,g_imas_d_t.l_imas003_04) THEN
                  LET g_imas_d[l_ac].l_imas003_04 = g_imas_d_t.l_imas003_04
                  CALL aimm200_05_get_imas_desc(g_imastext[1].detail[4].imas002,g_imas_d[l_ac].l_imas003_04) 
                       RETURNING g_imas_d[l_ac].l_imas003_04_desc                    
                  NEXT FIELD l_imas003_04
               END IF
               LET g_imas_d[l_ac].l_imas004_04 = ''                
            END IF
            CALL aimm200_05_get_imas_desc(g_imastext[1].detail[4].imas002,g_imas_d[l_ac].l_imas003_04) 
                 RETURNING g_imas_d[l_ac].l_imas003_04_desc             
            LET g_imas_d_t.l_imas003_04 = g_imas_d[l_ac].l_imas003_04
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_imas003_04
            #add-point:ON CHANGE l_imas003_04 name="input.g.page1_aimm200_05.l_imas003_04"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_imas004_04
            #add-point:BEFORE FIELD l_imas004_04 name="input.b.page1_aimm200_05.l_imas004_04"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_imas004_04
            
            #add-point:AFTER FIELD l_imas004_04 name="input.a.page1_aimm200_05.l_imas004_04"
            IF NOT cl_null(g_imas_d[l_ac].l_imas004_04) THEN
               IF g_imas_d[l_ac].l_imas004_04 <> g_imas_d_t.l_imas004_04 OR cl_null(g_imas_d_t.l_imas004_04)  THEN

 
               CALL s_aimi092_chk_eigenvalue(g_imaa005,g_imastext[1].detail[4].imas002,g_imas_d[l_ac].l_imas004_04,g_imas001,'1') 
                       RETURNING  l_success,l_errno,g_imas_d[l_ac].l_imas004_04
               IF NOT cl_null(l_errno) THEN    
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_imas_d[l_ac].l_imas004_04
                  LET g_errparam.popup = TRUE
                  CALL cl_err()               
                  LET g_imas_d[l_ac].l_imas004_04 = g_imas_d_t.l_imas004_04
                  NEXT FIELD l_imas004_04
               END IF

               #若賦值方式=3.限定範圍
               #1.檢查起須<迄
               #2.檢查起、迄不可在同特徵類型的其他起迄區間內
                  IF NOT aimm200_05_imas003_imas004_compare(g_imastext[1].detail[4].imas002,g_imas_d[l_ac].l_imas003_04,g_imas_d[l_ac].l_imas004_04,g_imas_d_t.l_imas003_04,g_imas_d_t.l_imas004_04) THEN
                     LET g_imas_d[l_ac].l_imas004_04 = g_imas_d_t.l_imas004_04
                     NEXT FIELD l_imas004_04
                  END IF               
                  #INSERT INTO imas_t
                  IF NOT aimm200_05_upd_imas('4',g_imas_d[l_ac].l_imas003_04,g_imas_d[l_ac].l_imas004_04) THEN
                     LET g_imas_d[l_ac].l_imas004_04 = g_imas_d_t.l_imas004_04
                     NEXT FIELD l_imas004_04
                  END IF
               END IF
            END IF
            LET g_imas_d_t.l_imas004_04 = g_imas_d[l_ac].l_imas004_04
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_imas004_04
            #add-point:ON CHANGE l_imas004_04 name="input.g.page1_aimm200_05.l_imas004_04"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_imas003_05
            #add-point:BEFORE FIELD l_imas003_05 name="input.b.page1_aimm200_05.l_imas003_05"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_imas003_05
            
            #add-point:AFTER FIELD l_imas003_05 name="input.a.page1_aimm200_05.l_imas003_05"
            IF NOT cl_null(g_imas_d[l_ac].l_imas003_05) THEN
               IF g_imas_d[l_ac].l_imas003_05 <> g_imas_d_t.l_imas003_05 OR cl_null(g_imas_d_t.l_imas003_05)  THEN
                  IF NOT aimm200_05_imas003_chk(g_imastext[1].detail[5].imas002,g_imas_d[l_ac].l_imas003_05) THEN
                     LET g_imas_d[l_ac].l_imas003_05 = g_imas_d_t.l_imas003_05
                     CALL aimm200_05_get_imas_desc(g_imastext[1].detail[5].imas002,g_imas_d[l_ac].l_imas003_05) 
                          RETURNING g_imas_d[l_ac].l_imas003_05_desc                      
                     NEXT FIELD l_imas003_05
                  END IF
               END IF
               CALL s_aimi092_chk_eigenvalue(g_imaa005,g_imastext[1].detail[5].imas002,g_imas_d[l_ac].l_imas003_05,g_imas001,'1') 
                       RETURNING  l_success,l_errno,g_imas_d[l_ac].l_imas003_05
               IF NOT cl_null(l_errno) THEN     
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_imas_d[l_ac].l_imas003_05
                  LET g_errparam.popup = TRUE
                  CALL cl_err()                
                  LET g_imas_d[l_ac].l_imas003_05 = g_imas_d_t.l_imas003_05
                  CALL aimm200_05_get_imas_desc(g_imastext[1].detail[5].imas002,g_imas_d[l_ac].l_imas003_05) 
                       RETURNING g_imas_d[l_ac].l_imas003_05_desc                   
                  NEXT FIELD l_imas003_05
               END IF

               #若賦值方式=3.限定範圍
               #1.檢查起須<迄
               #2.檢查起、迄不可在同特徵類型的其他起迄區間內
               IF NOT aimm200_05_imas003_imas004_compare(g_imastext[1].detail[5].imas002,g_imas_d[l_ac].l_imas003_05,g_imas_d[l_ac].l_imas004_05,g_imas_d_t.l_imas003_05,g_imas_d_t.l_imas004_05) THEN
                  LET g_imas_d[l_ac].l_imas003_05 = g_imas_d_t.l_imas003_05
                  CALL aimm200_05_get_imas_desc(g_imastext[1].detail[5].imas002,g_imas_d[l_ac].l_imas003_05) 
                       RETURNING g_imas_d[l_ac].l_imas003_05_desc                   
                  NEXT FIELD l_imas003_05
               END IF               
               #INSERT INTO imas_t
               IF NOT aimm200_05_ins_imas('5',g_imas_d[l_ac].l_imas003_05,g_imas_d[l_ac].l_imas004_05,g_imas_d_t.l_imas003_05) THEN
                  LET g_imas_d[l_ac].l_imas003_05 = g_imas_d_t.l_imas003_05
                  CALL aimm200_05_get_imas_desc(g_imastext[1].detail[5].imas002,g_imas_d[l_ac].l_imas003_05) 
                       RETURNING g_imas_d[l_ac].l_imas003_05_desc                   
                  NEXT FIELD l_imas003_05
               END IF
            ELSE
               IF NOT aimm200_05_ins_imas('5',g_imas_d[l_ac].l_imas003_05,g_imas_d[l_ac].l_imas004_05,g_imas_d_t.l_imas003_05) THEN
                  LET g_imas_d[l_ac].l_imas003_05 = g_imas_d_t.l_imas003_05
                  CALL aimm200_05_get_imas_desc(g_imastext[1].detail[5].imas002,g_imas_d[l_ac].l_imas003_05) 
                       RETURNING g_imas_d[l_ac].l_imas003_05_desc                   
                  NEXT FIELD l_imas003_05
               END IF 
               LET g_imas_d[l_ac].l_imas004_05 = ''                
            END IF
            CALL aimm200_05_get_imas_desc(g_imastext[1].detail[5].imas002,g_imas_d[l_ac].l_imas003_05) 
                 RETURNING g_imas_d[l_ac].l_imas003_05_desc            
            LET g_imas_d_t.l_imas003_05 = g_imas_d[l_ac].l_imas003_05
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_imas003_05
            #add-point:ON CHANGE l_imas003_05 name="input.g.page1_aimm200_05.l_imas003_05"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_imas004_05
            #add-point:BEFORE FIELD l_imas004_05 name="input.b.page1_aimm200_05.l_imas004_05"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_imas004_05
            
            #add-point:AFTER FIELD l_imas004_05 name="input.a.page1_aimm200_05.l_imas004_05"
            IF NOT cl_null(g_imas_d[l_ac].l_imas004_05) THEN
               IF g_imas_d[l_ac].l_imas004_05 <> g_imas_d_t.l_imas004_05 OR cl_null(g_imas_d_t.l_imas004_05)  THEN

 
               CALL s_aimi092_chk_eigenvalue(g_imaa005,g_imastext[1].detail[5].imas002,g_imas_d[l_ac].l_imas004_05,g_imas001,'1') 
                    RETURNING  l_success,l_errno,g_imas_d[l_ac].l_imas004_05
               IF NOT cl_null(l_errno) THEN  
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_imas_d[l_ac].l_imas004_05
                  LET g_errparam.popup = TRUE
                  CALL cl_err()                
                  LET g_imas_d[l_ac].l_imas004_05 = g_imas_d_t.l_imas004_05
                  NEXT FIELD l_imas004_05
               END IF

               #若賦值方式=3.限定範圍
               #1.檢查起須<迄
               #2.檢查起、迄不可在同特徵類型的其他起迄區間內
                  IF NOT aimm200_05_imas003_imas004_compare(g_imastext[1].detail[5].imas002,g_imas_d[l_ac].l_imas003_05,g_imas_d[l_ac].l_imas004_05,g_imas_d_t.l_imas003_05,g_imas_d_t.l_imas004_05) THEN
                     LET g_imas_d[l_ac].l_imas004_05 = g_imas_d_t.l_imas004_05
                     NEXT FIELD l_imas004_05
                  END IF               
                  #INSERT INTO imas_t
                  IF NOT aimm200_05_upd_imas('5',g_imas_d[l_ac].l_imas003_05,g_imas_d[l_ac].l_imas004_05) THEN
                     LET g_imas_d[l_ac].l_imas004_05 = g_imas_d_t.l_imas004_05
                     NEXT FIELD l_imas004_05
                  END IF
               END IF
            END IF
            LET g_imas_d_t.l_imas004_05 = g_imas_d[l_ac].l_imas004_05
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_imas004_05
            #add-point:ON CHANGE l_imas004_05 name="input.g.page1_aimm200_05.l_imas004_05"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_imas003_06
            #add-point:BEFORE FIELD l_imas003_06 name="input.b.page1_aimm200_05.l_imas003_06"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_imas003_06
            
            #add-point:AFTER FIELD l_imas003_06 name="input.a.page1_aimm200_05.l_imas003_06"
            IF NOT cl_null(g_imas_d[l_ac].l_imas003_06) THEN
               IF g_imas_d[l_ac].l_imas003_06 <> g_imas_d_t.l_imas003_06 OR cl_null(g_imas_d_t.l_imas003_06)  THEN
                  IF NOT aimm200_05_imas003_chk(g_imastext[1].detail[6].imas002,g_imas_d[l_ac].l_imas003_06) THEN
                     LET g_imas_d[l_ac].l_imas003_06 = g_imas_d_t.l_imas003_06
                     CALL aimm200_05_get_imas_desc(g_imastext[1].detail[6].imas002,g_imas_d[l_ac].l_imas003_06) 
                          RETURNING g_imas_d[l_ac].l_imas003_06_desc                      
                     NEXT FIELD l_imas003_06
                  END IF
               END IF
               CALL s_aimi092_chk_eigenvalue(g_imaa005,g_imastext[1].detail[6].imas002,g_imas_d[l_ac].l_imas003_06,g_imas001,'1') 
                       RETURNING  l_success,l_errno,g_imas_d[l_ac].l_imas003_06
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_imas_d[l_ac].l_imas003_06
                  LET g_errparam.popup = TRUE
                  CALL cl_err()                
                  LET g_imas_d[l_ac].l_imas003_06 = g_imas_d_t.l_imas003_06
                  CALL aimm200_05_get_imas_desc(g_imastext[1].detail[6].imas002,g_imas_d[l_ac].l_imas003_06) 
                       RETURNING g_imas_d[l_ac].l_imas003_06_desc                
                  NEXT FIELD l_imas003_06
               END IF

               #若賦值方式=3.限定範圍
               #1.檢查起須<迄
               #2.檢查起、迄不可在同特徵類型的其他起迄區間內
               IF NOT aimm200_05_imas003_imas004_compare(g_imastext[1].detail[6].imas002,g_imas_d[l_ac].l_imas003_06,g_imas_d[l_ac].l_imas004_06,g_imas_d_t.l_imas003_06,g_imas_d_t.l_imas004_06) THEN
                  LET g_imas_d[l_ac].l_imas003_06 = g_imas_d_t.l_imas003_06
                  CALL aimm200_05_get_imas_desc(g_imastext[1].detail[6].imas002,g_imas_d[l_ac].l_imas003_06) 
                       RETURNING g_imas_d[l_ac].l_imas003_06_desc                   
                  NEXT FIELD l_imas003_06
               END IF               
               #INSERT INTO imas_t
               IF NOT aimm200_05_ins_imas('6',g_imas_d[l_ac].l_imas003_06,g_imas_d[l_ac].l_imas004_06,g_imas_d_t.l_imas003_06) THEN
                  LET g_imas_d[l_ac].l_imas003_06 = g_imas_d_t.l_imas003_06
                  CALL aimm200_05_get_imas_desc(g_imastext[1].detail[6].imas002,g_imas_d[l_ac].l_imas003_06) 
                       RETURNING g_imas_d[l_ac].l_imas003_06_desc                   
                  NEXT FIELD l_imas003_06
               END IF
            ELSE
               IF NOT aimm200_05_ins_imas('6',g_imas_d[l_ac].l_imas003_06,g_imas_d[l_ac].l_imas004_06,g_imas_d_t.l_imas003_06) THEN
                  LET g_imas_d[l_ac].l_imas003_06 = g_imas_d_t.l_imas003_06
                  CALL aimm200_05_get_imas_desc(g_imastext[1].detail[6].imas002,g_imas_d[l_ac].l_imas003_06) 
                       RETURNING g_imas_d[l_ac].l_imas003_06_desc                   
                  NEXT FIELD l_imas003_06
               END IF 
               LET g_imas_d[l_ac].l_imas004_06 = ''                
            END IF
            CALL aimm200_05_get_imas_desc(g_imastext[1].detail[6].imas002,g_imas_d[l_ac].l_imas003_06) 
                 RETURNING g_imas_d[l_ac].l_imas003_06_desc 
            LET g_imas_d_t.l_imas003_06 = g_imas_d[l_ac].l_imas003_06
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_imas003_06
            #add-point:ON CHANGE l_imas003_06 name="input.g.page1_aimm200_05.l_imas003_06"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_imas004_06
            #add-point:BEFORE FIELD l_imas004_06 name="input.b.page1_aimm200_05.l_imas004_06"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_imas004_06
            
            #add-point:AFTER FIELD l_imas004_06 name="input.a.page1_aimm200_05.l_imas004_06"
            IF NOT cl_null(g_imas_d[l_ac].l_imas004_06) THEN
               IF g_imas_d[l_ac].l_imas004_06 <> g_imas_d_t.l_imas004_06 OR cl_null(g_imas_d_t.l_imas004_06)  THEN

 
               CALL s_aimi092_chk_eigenvalue(g_imaa005,g_imastext[1].detail[6].imas002,g_imas_d[l_ac].l_imas004_06,g_imas001,'1') 
                       RETURNING  l_success,l_errno,g_imas_d[l_ac].l_imas004_06
               IF NOT cl_null(l_errno) THEN     
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_imas_d[l_ac].l_imas004_06
                  LET g_errparam.popup = TRUE
                  CALL cl_err()                
                  LET g_imas_d[l_ac].l_imas004_06 = g_imas_d_t.l_imas004_06
                  NEXT FIELD l_imas004_06
               END IF

               #若賦值方式=3.限定範圍
               #1.檢查起須<迄
               #2.檢查起、迄不可在同特徵類型的其他起迄區間內
                  IF NOT aimm200_05_imas003_imas004_compare(g_imastext[1].detail[6].imas002,g_imas_d[l_ac].l_imas003_06,g_imas_d[l_ac].l_imas004_06,g_imas_d_t.l_imas003_06,g_imas_d_t.l_imas004_06) THEN
                     LET g_imas_d[l_ac].l_imas004_06 = g_imas_d_t.l_imas004_06
                     NEXT FIELD l_imas004_06
                  END IF               
                  #INSERT INTO imas_t
                  IF NOT aimm200_05_upd_imas('6',g_imas_d[l_ac].l_imas003_06,g_imas_d[l_ac].l_imas004_06) THEN
                     LET g_imas_d[l_ac].l_imas004_06 = g_imas_d_t.l_imas004_06
                     NEXT FIELD l_imas004_06
                  END IF
               END IF
            END IF
            LET g_imas_d_t.l_imas004_06 = g_imas_d[l_ac].l_imas004_06
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_imas004_06
            #add-point:ON CHANGE l_imas004_06 name="input.g.page1_aimm200_05.l_imas004_06"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_imas003_07
            #add-point:BEFORE FIELD l_imas003_07 name="input.b.page1_aimm200_05.l_imas003_07"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_imas003_07
            
            #add-point:AFTER FIELD l_imas003_07 name="input.a.page1_aimm200_05.l_imas003_07"
            IF NOT cl_null(g_imas_d[l_ac].l_imas003_07) THEN
               IF g_imas_d[l_ac].l_imas003_07 <> g_imas_d_t.l_imas003_07 OR cl_null(g_imas_d_t.l_imas003_07)  THEN
                  IF NOT aimm200_05_imas003_chk(g_imastext[1].detail[7].imas002,g_imas_d[l_ac].l_imas003_07) THEN
                     LET g_imas_d[l_ac].l_imas003_07 = g_imas_d_t.l_imas003_07
                     CALL aimm200_05_get_imas_desc(g_imastext[1].detail[7].imas002,g_imas_d[l_ac].l_imas003_07) 
                          RETURNING g_imas_d[l_ac].l_imas003_07_desc                      
                     NEXT FIELD l_imas003_07
                  END IF
               END IF
               CALL s_aimi092_chk_eigenvalue(g_imaa005,g_imastext[1].detail[7].imas002,g_imas_d[l_ac].l_imas003_07,g_imas001,'1') 
                       RETURNING  l_success,l_errno,g_imas_d[l_ac].l_imas003_07
               IF NOT cl_null(l_errno) THEN      
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_imas_d[l_ac].l_imas003_07
                  LET g_errparam.popup = TRUE
                  CALL cl_err()                
                  LET g_imas_d[l_ac].l_imas003_07 = g_imas_d_t.l_imas003_07
                  CALL aimm200_05_get_imas_desc(g_imastext[1].detail[7].imas002,g_imas_d[l_ac].l_imas003_07) 
                       RETURNING g_imas_d[l_ac].l_imas003_07_desc                   
                  NEXT FIELD l_imas003_07
               END IF

               #若賦值方式=3.限定範圍
               #1.檢查起須<迄
               #2.檢查起、迄不可在同特徵類型的其他起迄區間內
               IF NOT aimm200_05_imas003_imas004_compare(g_imastext[1].detail[7].imas002,g_imas_d[l_ac].l_imas003_07,g_imas_d[l_ac].l_imas004_07,g_imas_d_t.l_imas003_07,g_imas_d_t.l_imas004_07) THEN
                  LET g_imas_d[l_ac].l_imas003_07 = g_imas_d_t.l_imas003_07
                  CALL aimm200_05_get_imas_desc(g_imastext[1].detail[7].imas002,g_imas_d[l_ac].l_imas003_07) 
                       RETURNING g_imas_d[l_ac].l_imas003_07_desc                   
                  NEXT FIELD l_imas003_07
               END IF               
               #INSERT INTO imas_t
               IF NOT aimm200_05_ins_imas('7',g_imas_d[l_ac].l_imas003_07,g_imas_d[l_ac].l_imas004_07,g_imas_d_t.l_imas003_07) THEN
                  LET g_imas_d[l_ac].l_imas003_07 = g_imas_d_t.l_imas003_07
                  CALL aimm200_05_get_imas_desc(g_imastext[1].detail[7].imas002,g_imas_d[l_ac].l_imas003_07) 
                       RETURNING g_imas_d[l_ac].l_imas003_07_desc                   
                  NEXT FIELD l_imas003_07
               END IF
            ELSE
               IF NOT aimm200_05_ins_imas('7',g_imas_d[l_ac].l_imas003_07,g_imas_d[l_ac].l_imas004_07,g_imas_d_t.l_imas003_07) THEN
                  LET g_imas_d[l_ac].l_imas003_07 = g_imas_d_t.l_imas003_07
                  CALL aimm200_05_get_imas_desc(g_imastext[1].detail[7].imas002,g_imas_d[l_ac].l_imas003_07) 
                       RETURNING g_imas_d[l_ac].l_imas003_07_desc                   
                  NEXT FIELD l_imas003_07
               END IF  
               LET g_imas_d[l_ac].l_imas004_07 = ''                
            END IF
            CALL aimm200_05_get_imas_desc(g_imastext[1].detail[7].imas002,g_imas_d[l_ac].l_imas003_07) 
                 RETURNING g_imas_d[l_ac].l_imas003_07_desc             
            LET g_imas_d_t.l_imas003_07 = g_imas_d[l_ac].l_imas003_07
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_imas003_07
            #add-point:ON CHANGE l_imas003_07 name="input.g.page1_aimm200_05.l_imas003_07"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_imas004_07
            #add-point:BEFORE FIELD l_imas004_07 name="input.b.page1_aimm200_05.l_imas004_07"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_imas004_07
            
            #add-point:AFTER FIELD l_imas004_07 name="input.a.page1_aimm200_05.l_imas004_07"
            IF NOT cl_null(g_imas_d[l_ac].l_imas004_07) THEN
               IF g_imas_d[l_ac].l_imas004_07 <> g_imas_d_t.l_imas004_07 OR cl_null(g_imas_d_t.l_imas004_07)  THEN

 
               CALL s_aimi092_chk_eigenvalue(g_imaa005,g_imastext[1].detail[7].imas002,g_imas_d[l_ac].l_imas004_07,g_imas001,'1') 
                       RETURNING  l_success,l_errno,g_imas_d[l_ac].l_imas004_07
               IF NOT cl_null(l_errno) THEN    
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_imas_d[l_ac].l_imas004_07
                  LET g_errparam.popup = TRUE
                  CALL cl_err()                
                  LET g_imas_d[l_ac].l_imas004_07 = g_imas_d_t.l_imas004_07
                  NEXT FIELD l_imas004_07
               END IF

               #若賦值方式=3.限定範圍
               #1.檢查起須<迄
               #2.檢查起、迄不可在同特徵類型的其他起迄區間內
                  IF NOT aimm200_05_imas003_imas004_compare(g_imastext[1].detail[7].imas002,g_imas_d[l_ac].l_imas003_07,g_imas_d[l_ac].l_imas004_07,g_imas_d_t.l_imas003_07,g_imas_d_t.l_imas004_07) THEN
                     LET g_imas_d[l_ac].l_imas004_07 = g_imas_d_t.l_imas004_07
                     NEXT FIELD l_imas004_07
                  END IF               
                  #INSERT INTO imas_t
                  IF NOT aimm200_05_upd_imas('7',g_imas_d[l_ac].l_imas003_07,g_imas_d[l_ac].l_imas004_07) THEN
                     LET g_imas_d[l_ac].l_imas004_07 = g_imas_d_t.l_imas004_07
                     NEXT FIELD l_imas004_07
                  END IF
               END IF
            END IF
            LET g_imas_d_t.l_imas004_07 = g_imas_d[l_ac].l_imas004_07
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_imas004_07
            #add-point:ON CHANGE l_imas004_07 name="input.g.page1_aimm200_05.l_imas004_07"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_imas003_08
            #add-point:BEFORE FIELD l_imas003_08 name="input.b.page1_aimm200_05.l_imas003_08"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_imas003_08
            
            #add-point:AFTER FIELD l_imas003_08 name="input.a.page1_aimm200_05.l_imas003_08"
            IF NOT cl_null(g_imas_d[l_ac].l_imas003_08) THEN
               IF g_imas_d[l_ac].l_imas003_08 <> g_imas_d_t.l_imas003_08 OR cl_null(g_imas_d_t.l_imas003_08)  THEN
                  IF NOT aimm200_05_imas003_chk(g_imastext[1].detail[8].imas002,g_imas_d[l_ac].l_imas003_08) THEN
                     LET g_imas_d[l_ac].l_imas003_08 = g_imas_d_t.l_imas003_08
                     CALL aimm200_05_get_imas_desc(g_imastext[1].detail[8].imas002,g_imas_d[l_ac].l_imas003_08) 
                          RETURNING g_imas_d[l_ac].l_imas003_08_desc                        
                     NEXT FIELD l_imas003_08
                  END IF
               END IF
               CALL s_aimi092_chk_eigenvalue(g_imaa005,g_imastext[1].detail[8].imas002,g_imas_d[l_ac].l_imas003_08,g_imas001,'1') 
                       RETURNING  l_success,l_errno,g_imas_d[l_ac].l_imas003_08
               IF NOT cl_null(l_errno) THEN     
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_imas_d[l_ac].l_imas003_08
                  LET g_errparam.popup = TRUE
                  CALL cl_err()                
                  LET g_imas_d[l_ac].l_imas003_08 = g_imas_d_t.l_imas003_08
                  CALL aimm200_05_get_imas_desc(g_imastext[1].detail[8].imas002,g_imas_d[l_ac].l_imas003_08) 
                       RETURNING g_imas_d[l_ac].l_imas003_08_desc                   
                  NEXT FIELD l_imas003_08
               END IF

               #若賦值方式=3.限定範圍
               #1.檢查起須<迄
               #2.檢查起、迄不可在同特徵類型的其他起迄區間內
               IF NOT aimm200_05_imas003_imas004_compare(g_imastext[1].detail[8].imas002,g_imas_d[l_ac].l_imas003_08,g_imas_d[l_ac].l_imas004_08,g_imas_d_t.l_imas003_08,g_imas_d_t.l_imas004_08) THEN
                  LET g_imas_d[l_ac].l_imas003_08 = g_imas_d_t.l_imas003_08
                  CALL aimm200_05_get_imas_desc(g_imastext[1].detail[8].imas002,g_imas_d[l_ac].l_imas003_08) 
                       RETURNING g_imas_d[l_ac].l_imas003_08_desc                   
                  NEXT FIELD l_imas003_08
               END IF               
               #INSERT INTO imas_t
               IF NOT aimm200_05_ins_imas('8',g_imas_d[l_ac].l_imas003_08,g_imas_d[l_ac].l_imas004_08,g_imas_d_t.l_imas003_08) THEN
                  LET g_imas_d[l_ac].l_imas003_08 = g_imas_d_t.l_imas003_08
                  CALL aimm200_05_get_imas_desc(g_imastext[1].detail[8].imas002,g_imas_d[l_ac].l_imas003_08) 
                       RETURNING g_imas_d[l_ac].l_imas003_08_desc                   
                  NEXT FIELD l_imas003_08
               END IF
            ELSE
               IF NOT aimm200_05_ins_imas('8',g_imas_d[l_ac].l_imas003_08,g_imas_d[l_ac].l_imas004_08,g_imas_d_t.l_imas003_08) THEN
                  LET g_imas_d[l_ac].l_imas003_08 = g_imas_d_t.l_imas003_08
                  CALL aimm200_05_get_imas_desc(g_imastext[1].detail[8].imas002,g_imas_d[l_ac].l_imas003_08) 
                       RETURNING g_imas_d[l_ac].l_imas003_08_desc                   
                  NEXT FIELD l_imas003_08
               END IF  
               LET g_imas_d[l_ac].l_imas004_08 = ''                
            END IF
            CALL aimm200_05_get_imas_desc(g_imastext[1].detail[8].imas002,g_imas_d[l_ac].l_imas003_08) 
                 RETURNING g_imas_d[l_ac].l_imas003_08_desc            
            LET g_imas_d_t.l_imas003_08 = g_imas_d[l_ac].l_imas003_08
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_imas003_08
            #add-point:ON CHANGE l_imas003_08 name="input.g.page1_aimm200_05.l_imas003_08"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_imas004_08
            #add-point:BEFORE FIELD l_imas004_08 name="input.b.page1_aimm200_05.l_imas004_08"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_imas004_08
            
            #add-point:AFTER FIELD l_imas004_08 name="input.a.page1_aimm200_05.l_imas004_08"
            IF NOT cl_null(g_imas_d[l_ac].l_imas004_08) THEN
               IF g_imas_d[l_ac].l_imas004_08 <> g_imas_d_t.l_imas004_08 OR cl_null(g_imas_d_t.l_imas004_08)  THEN

 
               CALL s_aimi092_chk_eigenvalue(g_imaa005,g_imastext[1].detail[8].imas002,g_imas_d[l_ac].l_imas004_08,g_imas001,'1') 
                       RETURNING  l_success,l_errno,g_imas_d[l_ac].l_imas004_08
               IF NOT cl_null(l_errno) THEN         
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_imas_d[l_ac].l_imas004_08
                  LET g_errparam.popup = TRUE
                  CALL cl_err()                
                   LET g_imas_d[l_ac].l_imas004_08 = g_imas_d_t.l_imas004_08
                   NEXT FIELD l_imas004_08
               END IF

               #若賦值方式=3.限定範圍
               #1.檢查起須<迄
               #2.檢查起、迄不可在同特徵類型的其他起迄區間內
                  IF NOT aimm200_05_imas003_imas004_compare(g_imastext[1].detail[8].imas002,g_imas_d[l_ac].l_imas003_08,g_imas_d[l_ac].l_imas004_08,g_imas_d_t.l_imas003_08,g_imas_d_t.l_imas004_08) THEN
                     LET g_imas_d[l_ac].l_imas004_08 = g_imas_d_t.l_imas004_08
                     NEXT FIELD l_imas004_08
                  END IF               
                  #INSERT INTO imas_t
                  IF NOT aimm200_05_upd_imas('8',g_imas_d[l_ac].l_imas003_08,g_imas_d[l_ac].l_imas004_08) THEN
                     LET g_imas_d[l_ac].l_imas004_08 = g_imas_d_t.l_imas004_08
                     NEXT FIELD l_imas004_08
                  END IF
               END IF
            END IF
            LET g_imas_d_t.l_imas004_08 = g_imas_d[l_ac].l_imas004_08
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_imas004_08
            #add-point:ON CHANGE l_imas004_08 name="input.g.page1_aimm200_05.l_imas004_08"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_imas003_09
            #add-point:BEFORE FIELD l_imas003_09 name="input.b.page1_aimm200_05.l_imas003_09"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_imas003_09
            
            #add-point:AFTER FIELD l_imas003_09 name="input.a.page1_aimm200_05.l_imas003_09"
            IF NOT cl_null(g_imas_d[l_ac].l_imas003_09) THEN
               IF g_imas_d[l_ac].l_imas003_09 <> g_imas_d_t.l_imas003_09 OR cl_null(g_imas_d_t.l_imas003_09)  THEN
                  IF NOT aimm200_05_imas003_chk(g_imastext[1].detail[9].imas002,g_imas_d[l_ac].l_imas003_09) THEN
                  LET g_imas_d[l_ac].l_imas003_09 = g_imas_d_t.l_imas003_09
                  CALL aimm200_05_get_imas_desc(g_imastext[1].detail[9].imas002,g_imas_d[l_ac].l_imas003_09) 
                       RETURNING g_imas_d[l_ac].l_imas003_09_desc                       
                     NEXT FIELD l_imas003_09
                  END IF
               END IF
               CALL s_aimi092_chk_eigenvalue(g_imaa005,g_imastext[1].detail[9].imas002,g_imas_d[l_ac].l_imas003_09,g_imas001,'1')
                       RETURNING  l_success,l_errno,g_imas_d[l_ac].l_imas003_09
               IF NOT cl_null(l_errno) THEN    
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_imas_d[l_ac].l_imas003_09
                  LET g_errparam.popup = TRUE
                  CALL cl_err()                
                  LET g_imas_d[l_ac].l_imas003_09 = g_imas_d_t.l_imas003_09
                  CALL aimm200_05_get_imas_desc(g_imastext[1].detail[9].imas002,g_imas_d[l_ac].l_imas003_09) 
                       RETURNING g_imas_d[l_ac].l_imas003_09_desc                   
                  NEXT FIELD l_imas003_09
               END IF

               #若賦值方式=3.限定範圍
               #1.檢查起須<迄
               #2.檢查起、迄不可在同特徵類型的其他起迄區間內
               IF NOT aimm200_05_imas003_imas004_compare(g_imastext[1].detail[9].imas002,g_imas_d[l_ac].l_imas003_09,g_imas_d[l_ac].l_imas004_09,g_imas_d_t.l_imas003_09,g_imas_d_t.l_imas004_09) THEN
                  LET g_imas_d[l_ac].l_imas003_09 = g_imas_d_t.l_imas003_09
                  CALL aimm200_05_get_imas_desc(g_imastext[1].detail[9].imas002,g_imas_d[l_ac].l_imas003_09) 
                       RETURNING g_imas_d[l_ac].l_imas003_09_desc                   
                  NEXT FIELD l_imas003_09
               END IF               
               #INSERT INTO imas_t
               IF NOT aimm200_05_ins_imas('9',g_imas_d[l_ac].l_imas003_09,g_imas_d[l_ac].l_imas004_09,g_imas_d_t.l_imas003_09) THEN
                  LET g_imas_d[l_ac].l_imas003_09 = g_imas_d_t.l_imas003_09
                  CALL aimm200_05_get_imas_desc(g_imastext[1].detail[9].imas002,g_imas_d[l_ac].l_imas003_09) 
                       RETURNING g_imas_d[l_ac].l_imas003_09_desc                   
                  NEXT FIELD l_imas003_09
               END IF
            ELSE
               IF NOT aimm200_05_ins_imas('9',g_imas_d[l_ac].l_imas003_09,g_imas_d[l_ac].l_imas004_09,g_imas_d_t.l_imas003_09) THEN
                  LET g_imas_d[l_ac].l_imas003_09 = g_imas_d_t.l_imas003_09
                  CALL aimm200_05_get_imas_desc(g_imastext[1].detail[9].imas002,g_imas_d[l_ac].l_imas003_09) 
                       RETURNING g_imas_d[l_ac].l_imas003_09_desc                   
                  NEXT FIELD l_imas003_09
               END IF  
               LET g_imas_d[l_ac].l_imas004_09 = ''                
            END IF
            CALL aimm200_05_get_imas_desc(g_imastext[1].detail[9].imas002,g_imas_d[l_ac].l_imas003_09) 
                 RETURNING g_imas_d[l_ac].l_imas003_09_desc              
            LET g_imas_d_t.l_imas003_09 = g_imas_d[l_ac].l_imas003_09
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_imas003_09
            #add-point:ON CHANGE l_imas003_09 name="input.g.page1_aimm200_05.l_imas003_09"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_imas004_09
            #add-point:BEFORE FIELD l_imas004_09 name="input.b.page1_aimm200_05.l_imas004_09"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_imas004_09
            
            #add-point:AFTER FIELD l_imas004_09 name="input.a.page1_aimm200_05.l_imas004_09"
            IF NOT cl_null(g_imas_d[l_ac].l_imas004_09) THEN
               IF g_imas_d[l_ac].l_imas004_09 <> g_imas_d_t.l_imas004_09 OR cl_null(g_imas_d_t.l_imas004_09)  THEN

 
               CALL s_aimi092_chk_eigenvalue(g_imaa005,g_imastext[1].detail[9].imas002,g_imas_d[l_ac].l_imas004_09,g_imas001,'1') 
                       RETURNING  l_success,l_errno,g_imas_d[l_ac].l_imas004_09
               IF NOT cl_null(l_errno) THEN    
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_imas_d[l_ac].l_imas004_09
                  LET g_errparam.popup = TRUE
                  CALL cl_err()                   
                  LET g_imas_d[l_ac].l_imas004_09 = g_imas_d_t.l_imas004_09
                  NEXT FIELD l_imas004_09
               END IF

               #若賦值方式=3.限定範圍
               #1.檢查起須<迄
               #2.檢查起、迄不可在同特徵類型的其他起迄區間內
                  IF NOT aimm200_05_imas003_imas004_compare(g_imastext[1].detail[9].imas002,g_imas_d[l_ac].l_imas003_09,g_imas_d[l_ac].l_imas004_09,g_imas_d_t.l_imas003_09,g_imas_d_t.l_imas004_09) THEN
                     LET g_imas_d[l_ac].l_imas004_09 = g_imas_d_t.l_imas004_09
                     NEXT FIELD l_imas004_09
                  END IF               
                  #INSERT INTO imas_t
                  IF NOT aimm200_05_upd_imas('9',g_imas_d[l_ac].l_imas003_09,g_imas_d[l_ac].l_imas004_09) THEN
                     LET g_imas_d[l_ac].l_imas004_09 = g_imas_d_t.l_imas004_09
                     NEXT FIELD l_imas004_09
                  END IF
               END IF
            END IF
            LET g_imas_d_t.l_imas004_09 = g_imas_d[l_ac].l_imas004_09
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_imas004_09
            #add-point:ON CHANGE l_imas004_09 name="input.g.page1_aimm200_05.l_imas004_09"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_imas003_10
            #add-point:BEFORE FIELD l_imas003_10 name="input.b.page1_aimm200_05.l_imas003_10"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_imas003_10
            
            #add-point:AFTER FIELD l_imas003_10 name="input.a.page1_aimm200_05.l_imas003_10"
            IF NOT cl_null(g_imas_d[l_ac].l_imas003_10) THEN
               IF g_imas_d[l_ac].l_imas003_10 <> g_imas_d_t.l_imas003_10 OR cl_null(g_imas_d_t.l_imas003_10)  THEN
                  IF NOT aimm200_05_imas003_chk(g_imastext[1].detail[10].imas002,g_imas_d[l_ac].l_imas003_10) THEN
                     LET g_imas_d[l_ac].l_imas003_10 = g_imas_d_t.l_imas003_10
                     CALL aimm200_05_get_imas_desc(g_imastext[1].detail[10].imas002,g_imas_d[l_ac].l_imas003_10) 
                          RETURNING g_imas_d[l_ac].l_imas003_10_desc                       
                     NEXT FIELD l_imas003_10
                  END IF
 
                 CALL s_aimi092_chk_eigenvalue(g_imaa005,g_imastext[1].detail[10].imas002,g_imas_d[l_ac].l_imas003_10,g_imas001,'1') 
                       RETURNING  l_success,l_errno,g_imas_d[l_ac].l_imas003_10
                 IF NOT cl_null(l_errno) THEN    
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = l_errno
                     LET g_errparam.extend = g_imas_d[l_ac].l_imas003_10
                     LET g_errparam.popup = TRUE
                     CALL cl_err()                  
                     LET g_imas_d[l_ac].l_imas003_10 = g_imas_d_t.l_imas003_10
                     CALL aimm200_05_get_imas_desc(g_imastext[1].detail[10].imas002,g_imas_d[l_ac].l_imas003_10) 
                          RETURNING g_imas_d[l_ac].l_imas003_10_desc                    
                     NEXT FIELD l_imas003_10
                 END IF

                  #若賦值方式=3.限定範圍
                  #1.檢查起須<迄
                  #2.檢查起、迄不可在同特徵類型的其他起迄區間內
                  IF NOT aimm200_05_imas003_imas004_compare(g_imastext[1].detail[10].imas002,g_imas_d[l_ac].l_imas003_10,g_imas_d[l_ac].l_imas004_10,g_imas_d_t.l_imas003_10,g_imas_d_t.l_imas004_10) THEN
                     LET g_imas_d[l_ac].l_imas003_10 = g_imas_d_t.l_imas003_10
                     CALL aimm200_05_get_imas_desc(g_imastext[1].detail[10].imas002,g_imas_d[l_ac].l_imas003_10) 
                          RETURNING g_imas_d[l_ac].l_imas003_10_desc                     
                     NEXT FIELD l_imas003_10
                  END IF               
                  #INSERT INTO imas_t
                  IF NOT aimm200_05_ins_imas('10',g_imas_d[l_ac].l_imas003_10,g_imas_d[l_ac].l_imas004_10,g_imas_d_t.l_imas003_10) THEN
                     LET g_imas_d[l_ac].l_imas003_10 = g_imas_d_t.l_imas003_10
                     CALL aimm200_05_get_imas_desc(g_imastext[1].detail[10].imas002,g_imas_d[l_ac].l_imas003_10) 
                          RETURNING g_imas_d[l_ac].l_imas003_10_desc                     
                     NEXT FIELD l_imas003_10
                  END IF
               END IF
            ELSE
               IF NOT aimm200_05_ins_imas('10',g_imas_d[l_ac].l_imas003_10,g_imas_d[l_ac].l_imas004_10,g_imas_d_t.l_imas003_10) THEN
                  LET g_imas_d[l_ac].l_imas003_10 = g_imas_d_t.l_imas003_10
                  CALL aimm200_05_get_imas_desc(g_imastext[1].detail[10].imas002,g_imas_d[l_ac].l_imas003_10) 
                       RETURNING g_imas_d[l_ac].l_imas003_10_desc                  
                  NEXT FIELD l_imas003_10
               END IF  
               LET g_imas_d[l_ac].l_imas004_10 = ''                
            END IF
            CALL aimm200_05_get_imas_desc(g_imastext[1].detail[10].imas002,g_imas_d[l_ac].l_imas003_10) 
                 RETURNING g_imas_d[l_ac].l_imas003_10_desc             
            LET g_imas_d_t.l_imas003_10 = g_imas_d[l_ac].l_imas003_10
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_imas003_10
            #add-point:ON CHANGE l_imas003_10 name="input.g.page1_aimm200_05.l_imas003_10"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_imas004_10
            #add-point:BEFORE FIELD l_imas004_10 name="input.b.page1_aimm200_05.l_imas004_10"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_imas004_10
            
            #add-point:AFTER FIELD l_imas004_10 name="input.a.page1_aimm200_05.l_imas004_10"
            IF NOT cl_null(g_imas_d[l_ac].l_imas004_10) THEN
               IF g_imas_d[l_ac].l_imas004_10 <> g_imas_d_t.l_imas004_10 OR cl_null(g_imas_d_t.l_imas004_10)  THEN

 
               CALL s_aimi092_chk_eigenvalue(g_imaa005,g_imastext[1].detail[10].imas002,g_imas_d[l_ac].l_imas004_10,g_imas001,'1')
                       RETURNING  l_success,l_errno,g_imas_d[l_ac].l_imas004_10
               IF NOT cl_null(l_errno) THEN    
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_imas_d[l_ac].l_imas004_10
                  LET g_errparam.popup = TRUE
                  CALL cl_err()                
                  LET g_imas_d[l_ac].l_imas004_10 = g_imas_d_t.l_imas004_10
                  NEXT FIELD l_imas004_10
               END IF

               #若賦值方式=3.限定範圍
               #1.檢查起須<迄
               #2.檢查起、迄不可在同特徵類型的其他起迄區間內
                  IF NOT aimm200_05_imas003_imas004_compare(g_imastext[1].detail[10].imas002,g_imas_d[l_ac].l_imas003_10,g_imas_d[l_ac].l_imas004_10,g_imas_d_t.l_imas003_10,g_imas_d_t.l_imas004_10) THEN
                     LET g_imas_d[l_ac].l_imas004_10 = g_imas_d_t.l_imas004_10
                     NEXT FIELD l_imas004_10
                  END IF               
                  #INSERT INTO imas_t
                  IF NOT aimm200_05_upd_imas('10',g_imas_d[l_ac].l_imas003_10,g_imas_d[l_ac].l_imas004_10) THEN
                     LET g_imas_d[l_ac].l_imas004_10 = g_imas_d_t.l_imas004_10
                     NEXT FIELD l_imas004_10
                  END IF
               END IF
            END IF
            LET g_imas_d_t.l_imas004_10 = g_imas_d[l_ac].l_imas004_10
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_imas004_10
            #add-point:ON CHANGE l_imas004_10 name="input.g.page1_aimm200_05.l_imas004_10"

            #END add-point 
 

         AFTER INSERT
         
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CALL s_transaction_end('N',0)      
               #CANCEL INSERT
            END IF
            IF cl_null(g_imas_d[l_ac].l_imas003_01) AND cl_null(g_imas_d[l_ac].l_imas003_02) AND 
               cl_null(g_imas_d[l_ac].l_imas003_03) AND cl_null(g_imas_d[l_ac].l_imas003_04) AND
               cl_null(g_imas_d[l_ac].l_imas003_05) AND cl_null(g_imas_d[l_ac].l_imas003_06) AND    
               cl_null(g_imas_d[l_ac].l_imas003_07) AND cl_null(g_imas_d[l_ac].l_imas003_08) AND
               cl_null(g_imas_d[l_ac].l_imas003_09) AND cl_null(g_imas_d[l_ac].l_imas003_10) THEN
               CALL s_transaction_end('N',0)      
               #CANCEL INSERT
            ELSE
               CALL s_transaction_end('Y',0)
               LET g_rec_b = g_rec_b + 1            
            END IF   
                        
                        
        BEFORE DELETE                            #是否取消單身
            IF NOT cl_null(g_imas_d[l_ac].imas001)THEN

               IF NOT cl_ask_del_detail() THEN
                  #CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  -263
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  #CANCEL DELETE
               END IF

               IF NOT aimm200_05_del_imas()  THEN
                  CALL s_transaction_end('N',0)
                  #CANCEL DELETE   
               ELSE
                  LET g_rec_b = g_rec_b-1                  
                  CALL s_transaction_end('Y',0)
               END IF 

            END IF 
            
         ON ROW CHANGE 
         
         
         AFTER ROW
         
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_imas_d[l_ac].* = g_imas_d_t.*
               END IF
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL s_transaction_end('Y','0') 
                  #Ctrlp:input.c.page1_aimm200_05.imas001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imas001
            #add-point:ON ACTION controlp INFIELD imas001 name="input.c.page1_aimm200_05.imas001"

            #END add-point
 
 
         #Ctrlp:input.c.page1_aimm200_05.l_imas003_01
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_imas003_01
            #add-point:ON ACTION controlp INFIELD l_imas003_01 name="input.c.page1_aimm200_05.l_imas003_01"
            IF aimm200_05_get_controlp(g_imastext[1].detail[1].imas002) THEN  #開窗否            
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
                
               LET g_qryparam.default1 = g_imas_d[l_ac].l_imas003_01             #給予default值
                
               #給予arg
               LET g_qryparam.where = "imeastus = 'Y' "
               LET g_qryparam.arg1 = g_imaa005 #特徵群組代碼
               LET g_qryparam.arg2 = g_imastext[1].detail[1].imas002
               CALL q_imec003()                                #呼叫開窗
                
               LET g_imas_d[l_ac].l_imas003_01 = g_qryparam.return1              #將開窗取得的值回傳到變數
                
               DISPLAY g_imas_d[l_ac].l_imas003_01 TO l_imas003_01             #顯示到畫面上
               #CALL aimm200_01_imak_desc()  #150317-00006#1 add
                
               NEXT FIELD l_imas003_01                          #返回原欄位            
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1_aimm200_05.l_imas004_01
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_imas004_01
            #add-point:ON ACTION controlp INFIELD l_imas004_01 name="input.c.page1_aimm200_05.l_imas004_01"

            #END add-point
 
 
         #Ctrlp:input.c.page1_aimm200_05.l_imas003_02
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_imas003_02
            #add-point:ON ACTION controlp INFIELD l_imas003_02 name="input.c.page1_aimm200_05.l_imas003_02"
            IF aimm200_05_get_controlp(g_imastext[1].detail[2].imas002) THEN  #開窗否            
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
                
               LET g_qryparam.default1 = g_imas_d[l_ac].l_imas003_02             #給予default值
                
               #給予arg
               LET g_qryparam.where = "imeastus = 'Y' "
               LET g_qryparam.arg1 = g_imaa005 #特徵群組代碼
               LET g_qryparam.arg2 = g_imastext[1].detail[2].imas002
               CALL q_imec003()                                #呼叫開窗
                
               LET g_imas_d[l_ac].l_imas003_02 = g_qryparam.return1              #將開窗取得的值回傳到變數
                
               DISPLAY g_imas_d[l_ac].l_imas003_02 TO l_imas003_02             #顯示到畫面上
                
               NEXT FIELD l_imas003_02                          #返回原欄位            
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1_aimm200_05.l_imas004_02
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_imas004_02
            #add-point:ON ACTION controlp INFIELD l_imas004_02 name="input.c.page1_aimm200_05.l_imas004_02"

            #END add-point
 
 
         #Ctrlp:input.c.page1_aimm200_05.l_imas003_03
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_imas003_03
            #add-point:ON ACTION controlp INFIELD l_imas003_03 name="input.c.page1_aimm200_05.l_imas003_03"
            IF aimm200_05_get_controlp(g_imastext[1].detail[3].imas002) THEN  #開窗否            
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
                
               LET g_qryparam.default1 = g_imas_d[l_ac].l_imas003_03             #給予default值
                
               #給予arg
               LET g_qryparam.where = "imeastus = 'Y' "
               LET g_qryparam.arg1 = g_imaa005 #特徵群組代碼
               LET g_qryparam.arg2 = g_imastext[1].detail[3].imas002
               CALL q_imec003()                                #呼叫開窗
                
               LET g_imas_d[l_ac].l_imas003_03 = g_qryparam.return1              #將開窗取得的值回傳到變數
                
               DISPLAY g_imas_d[l_ac].l_imas003_03 TO l_imas003_03            #顯示到畫面上
                
               NEXT FIELD l_imas003_03                          #返回原欄位            
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1_aimm200_05.l_imas004_03
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_imas004_03
            #add-point:ON ACTION controlp INFIELD l_imas004_03 name="input.c.page1_aimm200_05.l_imas004_03"

            #END add-point
 
 
         #Ctrlp:input.c.page1_aimm200_05.l_imas003_04
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_imas003_04
            #add-point:ON ACTION controlp INFIELD l_imas003_04 name="input.c.page1_aimm200_05.l_imas003_04"
            IF aimm200_05_get_controlp(g_imastext[1].detail[4].imas002) THEN  #開窗否            
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
                
               LET g_qryparam.default1 = g_imas_d[l_ac].l_imas003_04             #給予default值
                
               #給予arg
               LET g_qryparam.where = "imeastus = 'Y' "
               LET g_qryparam.arg1 = g_imaa005 #特徵群組代碼
               LET g_qryparam.arg2 = g_imastext[1].detail[4].imas002
               CALL q_imec003()                                #呼叫開窗
                
               LET g_imas_d[l_ac].l_imas003_04 = g_qryparam.return1              #將開窗取得的值回傳到變數
                
               DISPLAY g_imas_d[l_ac].l_imas003_04 TO l_imas003_04            #顯示到畫面上
                
               NEXT FIELD l_imas003_04                          #返回原欄位            
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1_aimm200_05.l_imas004_04
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_imas004_04
            #add-point:ON ACTION controlp INFIELD l_imas004_04 name="input.c.page1_aimm200_05.l_imas004_04"

            #END add-point
 
 
         #Ctrlp:input.c.page1_aimm200_05.l_imas003_05
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_imas003_05
            #add-point:ON ACTION controlp INFIELD l_imas003_05 name="input.c.page1_aimm200_05.l_imas003_05"
            IF aimm200_05_get_controlp(g_imastext[1].detail[5].imas002) THEN  #開窗否            
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
                
               LET g_qryparam.default1 = g_imas_d[l_ac].l_imas003_05             #給予default值
                
               #給予arg
               LET g_qryparam.where = "imeastus = 'Y' "
               LET g_qryparam.arg1 = g_imaa005 #特徵群組代碼
               LET g_qryparam.arg2 = g_imastext[1].detail[5].imas002
               CALL q_imec003()                                #呼叫開窗
                
               LET g_imas_d[l_ac].l_imas003_05 = g_qryparam.return1              #將開窗取得的值回傳到變數
                
               DISPLAY g_imas_d[l_ac].l_imas003_05 TO l_imas003_05            #顯示到畫面上
                
               NEXT FIELD l_imas003_05                          #返回原欄位            
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1_aimm200_05.l_imas004_05
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_imas004_05
            #add-point:ON ACTION controlp INFIELD l_imas004_05 name="input.c.page1_aimm200_05.l_imas004_05"

            #END add-point
 
 
         #Ctrlp:input.c.page1_aimm200_05.l_imas003_06
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_imas003_06
            #add-point:ON ACTION controlp INFIELD l_imas003_06 name="input.c.page1_aimm200_05.l_imas003_06"
            IF aimm200_05_get_controlp(g_imastext[1].detail[6].imas002) THEN  #開窗否            
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
                
               LET g_qryparam.default1 = g_imas_d[l_ac].l_imas003_06             #給予default值
                
               #給予arg
               LET g_qryparam.where = "imeastus = 'Y' "
               LET g_qryparam.arg1 = g_imaa005 #特徵群組代碼
               LET g_qryparam.arg2 = g_imastext[1].detail[6].imas002
               CALL q_imec003()                                #呼叫開窗
                
               LET g_imas_d[l_ac].l_imas003_06 = g_qryparam.return1              #將開窗取得的值回傳到變數
                
               DISPLAY g_imas_d[l_ac].l_imas003_06 TO l_imas003_06            #顯示到畫面上
                
               NEXT FIELD l_imas003_06                          #返回原欄位            
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1_aimm200_05.l_imas004_06
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_imas004_06
            #add-point:ON ACTION controlp INFIELD l_imas004_06 name="input.c.page1_aimm200_05.l_imas004_06"

            #END add-point
 
 
         #Ctrlp:input.c.page1_aimm200_05.l_imas003_07
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_imas003_07
            #add-point:ON ACTION controlp INFIELD l_imas003_07 name="input.c.page1_aimm200_05.l_imas003_07"
            IF aimm200_05_get_controlp(g_imastext[1].detail[7].imas002) THEN  #開窗否            
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
                
               LET g_qryparam.default1 = g_imas_d[l_ac].l_imas003_07             #給予default值
                
               #給予arg
               LET g_qryparam.where = "imeastus = 'Y' "
               LET g_qryparam.arg1 = g_imaa005 #特徵群組代碼
               LET g_qryparam.arg2 = g_imastext[1].detail[7].imas002
               CALL q_imec003()                                #呼叫開窗
                
               LET g_imas_d[l_ac].l_imas003_07 = g_qryparam.return1              #將開窗取得的值回傳到變數
                
               DISPLAY g_imas_d[l_ac].l_imas003_07 TO l_imas003_07            #顯示到畫面上
                
               NEXT FIELD l_imas003_07                          #返回原欄位            
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1_aimm200_05.l_imas004_07
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_imas004_07
            #add-point:ON ACTION controlp INFIELD l_imas004_07 name="input.c.page1_aimm200_05.l_imas004_07"

            #END add-point
 
 
         #Ctrlp:input.c.page1_aimm200_05.l_imas003_08
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_imas003_08
            #add-point:ON ACTION controlp INFIELD l_imas003_08 name="input.c.page1_aimm200_05.l_imas003_08"
            IF aimm200_05_get_controlp(g_imastext[1].detail[8].imas002) THEN  #開窗否            
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
                
               LET g_qryparam.default1 = g_imas_d[l_ac].l_imas003_08             #給予default值
                
               #給予arg
               LET g_qryparam.where = "imeastus = 'Y' "
               LET g_qryparam.arg1 = g_imaa005 #特徵群組代碼
               LET g_qryparam.arg2 = g_imastext[1].detail[8].imas002
               CALL q_imec003()                                #呼叫開窗
                
               LET g_imas_d[l_ac].l_imas003_08 = g_qryparam.return1              #將開窗取得的值回傳到變數
                
               DISPLAY g_imas_d[l_ac].l_imas003_08 TO l_imas003_08            #顯示到畫面上
                
               NEXT FIELD l_imas003_08                          #返回原欄位            
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1_aimm200_05.l_imas004_08
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_imas004_08
            #add-point:ON ACTION controlp INFIELD l_imas004_08 name="input.c.page1_aimm200_05.l_imas004_08"

            #END add-point
 
 
         #Ctrlp:input.c.page1_aimm200_05.l_imas003_09
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_imas003_09
            #add-point:ON ACTION controlp INFIELD l_imas003_09 name="input.c.page1_aimm200_05.l_imas003_09"
            IF aimm200_05_get_controlp(g_imastext[1].detail[9].imas002) THEN  #開窗否            
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
                
               LET g_qryparam.default1 = g_imas_d[l_ac].l_imas003_09             #給予default值
                
               #給予arg
               LET g_qryparam.where = "imeastus = 'Y' "
               LET g_qryparam.arg1 = g_imaa005 #特徵群組代碼
               LET g_qryparam.arg2 = g_imastext[1].detail[9].imas002
               CALL q_imec003()                                #呼叫開窗
                
               LET g_imas_d[l_ac].l_imas003_09 = g_qryparam.return1              #將開窗取得的值回傳到變數
                
               DISPLAY g_imas_d[l_ac].l_imas003_09 TO l_imas003_09            #顯示到畫面上
                
               NEXT FIELD l_imas003_09                          #返回原欄位            
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1_aimm200_05.l_imas004_09
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_imas004_09
            #add-point:ON ACTION controlp INFIELD l_imas004_09 name="input.c.page1_aimm200_05.l_imas004_09"

            #END add-point
 
 
         #Ctrlp:input.c.page1_aimm200_05.l_imas003_10
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_imas003_10
            #add-point:ON ACTION controlp INFIELD l_imas003_10 name="input.c.page1_aimm200_05.l_imas003_10"
            IF aimm200_05_get_controlp(g_imastext[1].detail[10].imas002) THEN  #開窗否            
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
                
               LET g_qryparam.default1 = g_imas_d[l_ac].l_imas003_10             #給予default值
                
               #給予arg
               LET g_qryparam.where = "imeastus = 'Y' "
               LET g_qryparam.arg1 = g_imaa005 #特徵群組代碼
               LET g_qryparam.arg2 = g_imastext[1].detail[10].imas002
               CALL q_imec003()                                #呼叫開窗
                
               LET g_imas_d[l_ac].l_imas003_10 = g_qryparam.return1              #將開窗取得的值回傳到變數
                
               DISPLAY g_imas_d[l_ac].l_imas003_10 TO l_imas003_10            #顯示到畫面上
                
               NEXT FIELD l_imas003_10                          #返回原欄位            
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1_aimm200_05.l_imas004_10
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_imas004_10
            #add-point:ON ACTION controlp INFIELD l_imas004_10 name="input.c.page1_aimm200_05.l_imas004_10"

            #END add-point
 
 
 
 
         #自訂ACTION
         #add-point:單身其他段落處理(EX:on row change, etc...)

         #end add-point
 
         AFTER INPUT
            #add-point:單身輸入後處理

            #end add-point
            
      END INPUT
END DIALOG

 
{</section>}
 
{<section id="aimm200_05.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 栏位隐藏
# Memo...........:
# Usage..........: CALL aimm200_05_default_hide()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PUBLIC FUNCTION aimm200_05_default_hide()
   CALL cl_set_comp_visible("l_imas004_01,l_imas004_02,l_imas004_03,l_imas004_04,l_imas004_05,l_imas004_06,l_imas004_07,l_imas004_08,l_imas004_09,l_imas004_10,
                             l_imas003_01,l_imas003_02,l_imas003_03,l_imas003_04,l_imas003_05,l_imas003_06,l_imas003_07,l_imas003_08,l_imas003_09,l_imas003_10",FALSE)
   CALL cl_set_comp_visible("l_imas003_01_desc,l_imas003_02_desc,l_imas003_03_desc,l_imas003_04_desc,l_imas003_05_desc,l_imas003_06_desc,
                             l_imas003_07_desc,l_imas003_08_desc,l_imas003_09_desc,l_imas003_10_desc",FALSE)                          
END FUNCTION

################################################################################
# Descriptions...: 栏位显示
# Memo...........:
# Usage..........: CALL aimm200_05_show(p_imas001,p_imaa005)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PUBLIC FUNCTION aimm200_05_show(p_imas001,p_imaa005)
DEFINE   p_imas001         LIKE imas_t.imas001
DEFINE   p_imaa005         LIKE imaa_t.imaa005
DEFINE   l_imeb004_desc    LIKE imeb_t.imeb004
DEFINE   l_imeb004_desc1   LIKE type_t.chr1000
DEFINE   l_imeb004_desc2   LIKE type_t.chr1000
DEFINE   l_imeb002         LIKE imeb_t.imeb002
DEFINE   l_imeb009         LIKE imeb_t.imeb009 
DEFINE   l_imeb004         LIKE imeb_t.imeb004
DEFINE   l_imeb005         LIKE imeb_t.imeb005 
DEFINE   l_sql             STRING
DEFINE   l_str             STRING
DEFINE   l_str2            STRING
DEFINE   l_index           STRING
DEFINE   l_msg1            LIKE gzze_t.gzze003
DEFINE   l_msg2            LIKE gzze_t.gzze003
DEFINE   l_i               LIKE type_t.num5
DEFINE   l_a               STRING
DEFINE   l_a2              STRING
DEFINE   l_b               STRING
DEFINE   l_b2              STRING

   LET l_sql = "SELECT imeb002,imeb004,imeb005,imeb009 FROM imeb_t WHERE imebent=",g_enterprise," AND imeb001='",p_imaa005,"'",
               "   AND imeb003='2' AND imeb005!='4'  ORDER BY imeb002"
   PREPARE aimm200_05_pre1 FROM l_sql
   DECLARE aimm200_05_cs1 CURSOR FOR aimm200_05_pre1
   
   LET l_i = 1
   LET l_str = ''
   LET l_str2 = ''
   LET l_a = ''
   LET l_a2 = ''
   LET l_b = ''
   LET l_b2 = ''
   FOREACH aimm200_05_cs1 INTO l_imeb002,l_imeb004,l_imeb005,l_imeb009
   
      IF SQLCA.sqlcode THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = SQLCA.sqlcode
        LET g_errparam.extend = "FOREACH:"
        LET g_errparam.popup = TRUE
        CALL cl_err()
        EXIT FOREACH
      END IF
      SELECT oocql004 INTO l_imeb004_desc FROM oocql_t 
       WHERE oocqlent=g_enterprise 
         AND oocql001='273' 
         AND oocql002=l_imeb004 
         AND oocql003=g_dlang
         

      LET l_index = l_i USING '&&'
      LET l_a = "l_imas003_",l_index 
      IF cl_null(l_str) THEN 
         LET l_str = l_a 
      ELSE   
         LET l_str = l_str,",",l_a
      END IF 
      
      IF l_imeb005 = '2' THEN #预定义表值
         LET l_a2 = "l_imas003_",l_index,"_desc"    #说明栏位
         LET l_str = l_str,",",l_a2
      END IF
      
      IF l_imeb005 = '3' THEN  #限制范围

         LET l_index = l_i USING '&&'
         LET l_b = "l_imas004_",l_index 
         LET l_str = l_str,",",l_b    
         LET l_b2 = "l_imas003_",l_index,"_desc"          
         LET l_msg1 = ''
         SELECT gzze003 INTO l_msg1 FROM gzze_t WHERE gzze001 = 'aim-00260' AND gzze002 = g_dlang
         LET l_msg2 = ''
         SELECT gzze003 INTO l_msg2 FROM gzze_t WHERE gzze001 = 'aim-00261' AND gzze002 = g_dlang   
         LET l_imeb004_desc1 = l_imeb004_desc,l_msg1 
         LET l_imeb004_desc2 = l_imeb004_desc,l_msg2 
         IF cl_null(l_str2) THEN
            LET l_str2 = l_b2
         ELSE
            LET l_str2 = l_str2,l_b2
         END IF         
      END IF  
      CALL cl_set_comp_att_text(l_b,l_imeb004_desc2) 
      IF l_imeb005 = '3' THEN  #限制范围
         CALL cl_set_comp_att_text(l_a,l_imeb004_desc1)   
      ELSE
         CALL cl_set_comp_att_text(l_a,l_imeb004_desc)   
      END IF      
      LET l_i = l_i + 1    
   END FOREACH
   CALL cl_set_comp_visible(l_str,TRUE)
   CALL cl_set_comp_visible(l_str2,FALSE)
END FUNCTION

################################################################################
# Descriptions...: 获取料件属性栏位
# Memo...........:
# Usage..........: CALL aimm200_05_get_imas002(p_imaa005)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PUBLIC FUNCTION aimm200_05_get_imas002(p_imaa005)
DEFINE p_imaa005     LIKE imaa_t.imaa005
DEFINE l_imeb002     LIKE imeb_t.imeb002
DEFINE l_imeb004     LIKE imeb_t.imeb004
DEFINE l_imeb005     LIKE imeb_t.imeb005
DEFINE l_sql  STRING
   
   LET l_sql = " SELECT imeb002,imeb004,imeb005 FROM imeb_t ",
               "  WHERE imebent = ",g_enterprise,
               "    AND imeb001 = '",p_imaa005,"'",
               "    AND imeb003 = '2' ",
               "  ORDER BY imeb002"
   PREPARE aimm200_05_pre FROM l_sql
   DECLARE aimm200_05_cs CURSOR FOR aimm200_05_pre               
   CALL g_imastext.clear()
   FOREACH aimm200_05_cs INTO l_imeb002,l_imeb004,l_imeb005
      IF SQLCA.sqlcode THEN
         
         EXIT FOREACH
      END IF
      #LET g_imastext.detail[g_imastext.detail.getLength()+1].imas002=l_imeb004 CLIPPED
      LET g_imastext[1].detail[g_imastext[1].detail.getLength()+1].imas002=l_imeb004 CLIPPED
      #1.動態指定,2.預定表值,3.限制範圍,4.固定值
#      IF l_imeb005 = '3' THEN   #
#         LET g_imastext[1].detail[g_imastext[1].detail.getLength()+1].imas002_2=l_imeb004 CLIPPED
#      END IF
   END FOREACH
   
END FUNCTION

################################################################################
# Descriptions...: 写入imas_t
# Memo...........:
# Usage..........: CALL aimm200_05_ins_imas(p_i,p_imas003,p_imas004,p_imas003_t)
#                  RETURNING 回传参数
# Input parameter: p_i            特征类型（第N列）
#                : p_imas003      特征值（起）
#                : p_imas004      特征值（迄）
#                : p_imas003_t    特征值（起）旧值
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION aimm200_05_ins_imas(p_i,p_imas003,p_imas004,p_imas003_t)
DEFINE  p_i          LIKE type_t.num5
DEFINE  p_imas003    LIKE imas_t.imas003
DEFINE  p_imas004    LIKE imas_t.imas004
DEFINE  p_imas003_t  LIKE imas_t.imas003
DEFINE  l_cnt        LIKE type_t.num5
DEFINE  r_success    LIKE type_t.num5

   LET r_success = TRUE
   IF cl_null(p_imas003) AND NOT cl_null(p_imas003_t) THEN
      #资料删除
      DELETE FROM imas_t WHERE imasent = g_enterprise
                           AND imas001 = g_imas001
                           AND imas002 = g_imastext[1].detail[p_i].imas002 
                           AND imas003 = p_imas003_t                  
   END IF
   IF cl_null(p_imas003_t) THEN
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt FROM imas_t
       WHERE imasent = g_enterprise
         AND imas001 = g_imas001 
         AND imas002 = g_imastext[1].detail[p_i].imas002 
         AND imas003 = p_imas003       
      IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
      #LET l_imas002 = g_imastext[1].detail[p_i].imas002 
      IF l_cnt = 0 THEN
         INSERT INTO imas_t (imasent,imas001,imas002,imas003,imas004)
                     VALUES (g_enterprise,g_imas001,g_imastext[1].detail[p_i].imas002,p_imas003,p_imas004)   
      END IF                     
   ELSE
      UPDATE imas_t SET imas003 = p_imas003,
                        imas004 = p_imas004
       WHERE imasent = g_enterprise
         AND imas001 = g_imas001
         AND imas002 = g_imastext[1].detail[p_i].imas002
         AND imas003 = p_imas003_t         
   END IF
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 单身特征(库存)显示
# Memo...........:
# Usage..........: CALL aimm200_05_b_fill()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PUBLIC FUNCTION aimm200_05_b_fill()
DEFINE l_num    LIKE type_t.num5
DEFINE l_sql    STRING 
DEFINE l_i      LIKE type_t.num5
DEFINE l_j      LIKE type_t.num5
DEFINE l_n      LIKE type_t.num5

   LET l_num = 0
   SELECT MAX(COUNT(imas002)) INTO l_num FROM imas_t 
    WHERE imasent = g_enterprise
      AND imas001 = g_imas001
    GROUP BY imas002
   
   CALL aimm200_05_get_imas002(g_imaa005)  
   CALL aimm200_05_default_hide()
   CALL aimm200_05_show(g_imas001,g_imaa005)   
   IF cl_null(l_num) THEN LET l_num = 0 END IF
   LET l_sql = " SELECT imas003,imas004 FROM imas_t ",
               "  WHERE imasent = ",g_enterprise,
               "    AND imas001 = '",g_imas001,"'",
               "    AND imas002 = ? ",
               "  ORDER BY imas003 "
               
   PREPARE aimm200_05_pre2 FROM l_sql
   DECLARE aimm200_05_cs2 CURSOR FOR aimm200_05_pre2       
   CALL g_imas_d.clear()
   CALL global_g_imas_d.clear()   
   FOR l_j = 1 TO g_imastext[1].detail.getLength()   #特徵值的数量
       IF l_j = 1 THEN
          LET l_i = 1
          FOREACH aimm200_05_cs2 USING g_imastext[1].detail[l_j].imas002 INTO g_imas_d[l_i].l_imas003_01,g_imas_d[l_i].l_imas004_01
             CALL aimm200_05_get_imas_desc(g_imastext[1].detail[l_j].imas002,g_imas_d[l_i].l_imas003_01) RETURNING g_imas_d[l_i].l_imas003_01_desc
             LET global_g_imas_d[l_i].* = g_imas_d[l_i].*   
             LET l_i = l_i + 1
          END FOREACH 
       END IF 
       IF l_j = 2 THEN
          LET l_i = 1
          FOREACH aimm200_05_cs2 USING g_imastext[1].detail[l_j].imas002 INTO g_imas_d[l_i].l_imas003_02,g_imas_d[l_i].l_imas004_02
             CALL aimm200_05_get_imas_desc(g_imastext[1].detail[l_j].imas002,g_imas_d[l_i].l_imas003_02) RETURNING g_imas_d[l_i].l_imas003_02_desc
             LET global_g_imas_d[l_i].* = g_imas_d[l_i].*  
             LET l_i = l_i + 1
          END FOREACH 
       END IF     
       IF l_j = 3 THEN
          LET l_i = 1
          FOREACH aimm200_05_cs2 USING g_imastext[1].detail[l_j].imas002 INTO g_imas_d[l_i].l_imas003_03,g_imas_d[l_i].l_imas004_03
             CALL aimm200_05_get_imas_desc(g_imastext[1].detail[l_j].imas002,g_imas_d[l_i].l_imas003_03) RETURNING g_imas_d[l_i].l_imas003_03_desc
             LET global_g_imas_d[l_i].* = g_imas_d[l_i].*  
             LET l_i = l_i + 1
          END FOREACH 
       END IF  
       IF l_j = 4 THEN
          LET l_i = 1
          FOREACH aimm200_05_cs2 USING g_imastext[1].detail[l_j].imas002 INTO g_imas_d[l_i].l_imas003_04,g_imas_d[l_i].l_imas004_04
             CALL aimm200_05_get_imas_desc(g_imastext[1].detail[l_j].imas002,g_imas_d[l_i].l_imas003_04) RETURNING g_imas_d[l_i].l_imas003_04_desc
             LET global_g_imas_d[l_i].* = g_imas_d[l_i].*  
             LET l_i = l_i + 1
          END FOREACH 
       END IF    
       IF l_j = 5 THEN
          LET l_i = 1
          FOREACH aimm200_05_cs2 USING g_imastext[1].detail[l_j].imas002 INTO g_imas_d[l_i].l_imas003_05,g_imas_d[l_i].l_imas004_05
             CALL aimm200_05_get_imas_desc(g_imastext[1].detail[l_j].imas002,g_imas_d[l_i].l_imas003_05) RETURNING g_imas_d[l_i].l_imas003_05_desc
             LET global_g_imas_d[l_i].* = g_imas_d[l_i].*  
             LET l_i = l_i + 1
          END FOREACH 
       END IF 
       IF l_j = 6 THEN
          LET l_i = 1
          FOREACH aimm200_05_cs2 USING g_imastext[1].detail[l_j].imas002 INTO g_imas_d[l_i].l_imas003_06,g_imas_d[l_i].l_imas004_06
             CALL aimm200_05_get_imas_desc(g_imastext[1].detail[l_j].imas002,g_imas_d[l_i].l_imas003_06) RETURNING g_imas_d[l_i].l_imas003_06_desc
             LET global_g_imas_d[l_i].* = g_imas_d[l_i].*  
             LET l_i = l_i + 1
          END FOREACH 
       END IF   
       IF l_j = 7 THEN
          LET l_i = 1
          FOREACH aimm200_05_cs2 USING g_imastext[1].detail[l_j].imas002 INTO g_imas_d[l_i].l_imas003_07,g_imas_d[l_i].l_imas004_07
             CALL aimm200_05_get_imas_desc(g_imastext[1].detail[l_j].imas002,g_imas_d[l_i].l_imas003_07) RETURNING g_imas_d[l_i].l_imas003_07_desc
             LET global_g_imas_d[l_i].* = g_imas_d[l_i].*  
             LET l_i = l_i + 1
          END FOREACH 
       END IF  
       IF l_j = 8 THEN
          LET l_i = 1
          FOREACH aimm200_05_cs2 USING g_imastext[1].detail[l_j].imas002 INTO g_imas_d[l_i].l_imas003_08,g_imas_d[l_i].l_imas004_08
             CALL aimm200_05_get_imas_desc(g_imastext[1].detail[l_j].imas002,g_imas_d[l_i].l_imas003_08) RETURNING g_imas_d[l_i].l_imas003_08_desc
             LET global_g_imas_d[l_i].* = g_imas_d[l_i].*  
             LET l_i = l_i + 1
          END FOREACH 
       END IF    
       IF l_j = 9 THEN
          LET l_i = 1
          FOREACH aimm200_05_cs2 USING g_imastext[1].detail[l_j].imas002 INTO g_imas_d[l_i].l_imas003_09,g_imas_d[l_i].l_imas004_09
             CALL aimm200_05_get_imas_desc(g_imastext[1].detail[l_j].imas002,g_imas_d[l_i].l_imas003_09) RETURNING g_imas_d[l_i].l_imas003_09_desc
             LET global_g_imas_d[l_i].* = g_imas_d[l_i].*  
             LET l_i = l_i + 1
          END FOREACH 
       END IF  
       IF l_j = 10 THEN
          LET l_i = 1
          FOREACH aimm200_05_cs2 USING g_imastext[1].detail[l_j].imas002 INTO g_imas_d[l_i].l_imas003_10,g_imas_d[l_i].l_imas004_10
             CALL aimm200_05_get_imas_desc(g_imastext[1].detail[l_j].imas002,g_imas_d[l_i].l_imas003_10) RETURNING g_imas_d[l_i].l_imas003_10_desc
             LET global_g_imas_d[l_i].* = g_imas_d[l_i].*  
             LET l_i = l_i + 1
          END FOREACH 
       END IF         
   END FOR
   
   CALL g_imas_d.deleteElement(g_imas_d.getLength()) 
   CALL global_g_imas_d.deleteElement(g_imas_d.getLength()) 
   LET g_rec_b = g_imas_d.getLength()
   DISPLAY g_rec_b TO FORMONLY.cnt
   
   #將總筆數, 目前筆數指定到共用變數中
   IF g_rec_b > 0 THEN
      LET g_d_idx_m20005 = 1
   ELSE
      LET g_d_idx_m20005 = 0
   END IF
   LET g_d_cnt_m20005 = g_rec_b
   
   CLOSE aimm200_05_cs2
   FREE aimm200_05_pre2   
END FUNCTION

################################################################################
# Descriptions...: 是否开窗
# Memo...........:
# Usage..........: CALL aimm200_05_get_controlp(p_imeb004)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION aimm200_05_get_controlp(p_imeb004)
DEFINE  p_imeb004     LIKE imeb_t.imeb004
DEFINE  r_success     LIKE type_t.num5
DEFINE  l_imeb005     LIKE imeb_t.imeb005

   LET r_success = FALSE
   IF cl_null(p_imeb004) THEN 
      RETURN r_success
   END IF
   SELECT imeb005 INTO l_imeb005 FROM imeb_t
    WHERE imebent = g_enterprise
      AND imeb001 = g_imaa005
      AND imeb004 = p_imeb004
   IF l_imeb005 = '2' THEN    #預定值
      LET r_success = TRUE            
   END IF
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 资料重复性检查
# Memo...........:
# Usage..........: CALL aimm200_05_imas003_chk(p_imas002,p_imas003)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION aimm200_05_imas003_chk(p_imas002,p_imas003)
DEFINE p_imas002   LIKE imas_t.imas002
DEFINE p_imas003   LIKE imas_t.imas003
DEFINE r_success   LIKE type_t.num5
DEFINE l_cnt       LIKE type_t.num5 
 
   LET r_success = TRUE
   IF cl_null(g_imas001) OR cl_null(p_imas002) OR cl_null(p_imas003) THEN
      RETURN r_success
   END IF
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM imas_t 
    WHERE imasent = g_enterprise
      AND imas001 = g_imas001
      AND imas002 = p_imas002
      AND imas003 = p_imas003
      
   IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
   IF l_cnt > 0 THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'std-00004'
      LET g_errparam.extend = p_imas003
      LET g_errparam.popup = TRUE
      CALL cl_err()         
   END IF   
   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: 资料删除（多笔）
# Memo...........:
# Usage..........: CALL aimm200_05_del_imas()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION aimm200_05_del_imas()
DEFINE  l_sql     STRING
DEFINE  r_success LIKE type_t.num5

   LET r_success = TRUE
   LET l_sql = " DELETE FROM imas_t ",
               "  WHERE imasent = ",g_enterprise,
               "    AND imas001 = '",g_imas001,"'",
               "    AND imas002 = ? ",
               "    AND imas003 = ? "
   PREPARE aimm200_05_del_pre  FROM l_sql   #刪除資料   

   IF NOT cl_null(g_imas_d[l_ac].l_imas003_01) THEN
      EXECUTE aimm200_05_del_pre USING g_imastext[1].detail[1].imas002,g_imas_d[l_ac].l_imas003_01
      IF SQLCA.sqlcode THEN 
         LET r_success = FALSE
      END IF      
   END IF
   IF NOT cl_null(g_imas_d[l_ac].l_imas003_02) THEN
      EXECUTE aimm200_05_del_pre USING g_imastext[1].detail[2].imas002,g_imas_d[l_ac].l_imas003_02   
      IF SQLCA.sqlcode THEN 
         LET r_success = FALSE
      END IF         
   END IF   
   IF NOT cl_null(g_imas_d[l_ac].l_imas003_03) THEN
      EXECUTE aimm200_05_del_pre USING g_imastext[1].detail[3].imas002,g_imas_d[l_ac].l_imas003_03 
      IF SQLCA.sqlcode THEN 
         LET r_success = FALSE
      END IF   
   END IF 
   IF NOT cl_null(g_imas_d[l_ac].l_imas003_04) THEN
      EXECUTE aimm200_05_del_pre USING g_imastext[1].detail[4].imas002,g_imas_d[l_ac].l_imas003_04  
      IF SQLCA.sqlcode THEN 
         LET r_success = FALSE
      END IF         
   END IF  
   IF NOT cl_null(g_imas_d[l_ac].l_imas003_05) THEN
      EXECUTE aimm200_05_del_pre USING g_imastext[1].detail[5].imas002,g_imas_d[l_ac].l_imas003_05  
      IF SQLCA.sqlcode THEN 
         LET r_success = FALSE
      END IF         
   END IF  
   IF NOT cl_null(g_imas_d[l_ac].l_imas003_06) THEN
      EXECUTE aimm200_05_del_pre USING g_imastext[1].detail[6].imas002,g_imas_d[l_ac].l_imas003_06 
      IF SQLCA.sqlcode THEN 
         LET r_success = FALSE
      END IF   
   END IF   
   IF NOT cl_null(g_imas_d[l_ac].l_imas003_07) THEN
      EXECUTE aimm200_05_del_pre USING g_imastext[1].detail[7].imas002,g_imas_d[l_ac].l_imas003_07 
      IF SQLCA.sqlcode THEN 
         LET r_success = FALSE
      END IF         
   END IF   
   IF NOT cl_null(g_imas_d[l_ac].l_imas003_08) THEN
      EXECUTE aimm200_05_del_pre USING g_imastext[1].detail[8].imas002,g_imas_d[l_ac].l_imas003_08 
      IF SQLCA.sqlcode THEN 
         LET r_success = FALSE
      END IF         
   END IF   
   IF NOT cl_null(g_imas_d[l_ac].l_imas003_09) THEN
      EXECUTE aimm200_05_del_pre USING g_imastext[1].detail[9].imas002,g_imas_d[l_ac].l_imas003_09 
      IF SQLCA.sqlcode THEN 
         LET r_success = FALSE
      END IF         
   END IF   
   IF NOT cl_null(g_imas_d[l_ac].l_imas003_10) THEN
      EXECUTE aimm200_05_del_pre USING g_imastext[1].detail[10].imas002,g_imas_d[l_ac].l_imas003_10
      IF SQLCA.sqlcode THEN 
         LET r_success = FALSE
      END IF         
   END IF    
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 若賦值方式=3.限定範圍,起讫检查
# Memo...........:
# Usage..........: CALL aimm200_05_imas003_imas004_compare(p_imas002,p_imas003,p_imas004,p_imas003_t,p_imas004_t)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION aimm200_05_imas003_imas004_compare(p_imas002,p_imas003,p_imas004,p_imas003_t,p_imas004_t)
DEFINE p_imas002     LIKE imas_t.imas002
DEFINE p_imas003     LIKE imas_t.imas003
DEFINE p_imas004     LIKE imas_t.imas004
DEFINE p_imas003_t   LIKE imas_t.imas003
DEFINE p_imas004_t   LIKE imas_t.imas004
DEFINE r_success     LIKE type_t.num5
DEFINE l_cnt         LIKE type_t.num5

   #若賦值方式=3.限定範圍
   LET r_success = TRUE
   IF NOT cl_null(p_imas003) AND NOT cl_null(p_imas004) THEN
      #檢查起須<迄
      IF p_imas003 > p_imas004 THEN
         LET r_success = FALSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'aim-00264'
         LET g_errparam.extend = p_imas003
         LET g_errparam.popup = TRUE
         CALL cl_err()           
      END IF   
      #檢查起、迄不可在同特徵類型的其他起迄區間內
#      IF p_imas003_t IS NULL OR
#         ( NOT cl_null(p_imas003) AND
#         p_imas003_t >= p_imas003) THEN
         LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt FROM imas_t
          WHERE ((imas003 BETWEEN p_imas003 AND p_imas004) OR (imas004 BETWEEN p_imas003 AND p_imas004))
            AND imasent = g_enterprise
            AND imas001 = g_imas001
            AND imas002 = p_imas002
            AND (imas003 != p_imas003_t OR imas004 != p_imas004_t) 
         IF l_cnt > 0 THEN
            LET r_success = FALSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'aim-00263'
            LET g_errparam.extend = p_imas003
            LET g_errparam.popup = TRUE
            CALL cl_err()            
         END IF
#      END IF  
     
#      IF p_imas004_t IS NULL OR
#         ( NOT cl_null(p_imas004) AND
#         p_imas004_t >= p_imas004) THEN
         LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt FROM imas_t
          WHERE ((imas003 BETWEEN p_imas003 AND p_imas004) OR (imas004 BETWEEN p_imas003 AND p_imas004))
            AND imasent = g_enterprise
            AND imas001 = g_imas001
            AND imas002 = p_imas002
            AND (imas003 != p_imas003_t OR imas004 != p_imas004_t) 
         IF l_cnt > 0 THEN
            LET r_success = FALSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'aim-00263'
            LET g_errparam.extend = p_imas004
            LET g_errparam.popup = TRUE
            CALL cl_err()              
         END IF
      #END IF 
         LET l_cnt = 0      
         SELECT COUNT(*) INTO l_cnt FROM imas_t
          WHERE imas003 < p_imas003 AND imas004 > p_imas004
            AND imasent = g_enterprise
            AND imas001 = g_imas001
            AND imas002 = p_imas002
            AND (imas003 != p_imas003_t OR imas004 != p_imas004_t)      
         IF l_cnt > 0 THEN
            LET r_success = FALSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'aim-00263'
            LET g_errparam.extend = p_imas004
            LET g_errparam.popup = TRUE
            CALL cl_err()              
         END IF        
   END IF
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 更新imas_t
# Memo...........:
# Usage..........: CALL aimm200_05_upd_imas(p_i,p_imas003,p_imas004)
#                  RETURNING 回传参数
# Input parameter: p_i            特征类型（第N列）
#                : p_imas003      特征值（起）
#                : p_imas004      特征值（迄）
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION aimm200_05_upd_imas(p_i,p_imas003,p_imas004)
DEFINE  p_i          LIKE type_t.num5
DEFINE  p_imas003    LIKE imas_t.imas003
DEFINE  p_imas004    LIKE imas_t.imas004
DEFINE  l_cnt        LIKE type_t.num5
DEFINE  r_success    LIKE type_t.num5

   LET r_success = TRUE
   IF cl_null(p_imas003) THEN
      RETURN r_success
   END IF
   UPDATE imas_t SET imas004 = p_imas004                     
    WHERE imasent = g_enterprise
      AND imas001 = g_imas001
      AND imas002 = g_imastext[1].detail[p_i].imas002
      AND imas003 = p_imas003  
   IF SQLCA.sqlcode THEN 
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'upd imas_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()        
   END IF    
   RETURN r_success   
END FUNCTION

################################################################################
# Descriptions...: 带出特征值说明
# Memo...........:
# Usage..........: CALL aimm200_05_get_imas_desc(p_imeb004,p_imas003)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION aimm200_05_get_imas_desc(p_imeb004,p_imas003)
DEFINE  p_imeb004    LIKE imeb_t.imeb004
DEFINE  p_imas003    LIKE imas_t.imas003
DEFINE  l_imecl005   LIKE imecl_t.imecl005
DEFINE  l_imeb002    LIKE imeb_t.imeb002
DEFINE  l_imeb005    LIKE imeb_t.imeb005

   LET l_imecl005 = ''
   SELECT DISTINCT imeb002,imeb005 INTO l_imeb002,l_imeb005 FROM imeb_t
    WHERE imebent = g_enterprise
      AND imeb001 = g_imaa005
      AND imeb004 = p_imeb004
   IF l_imeb005 = '2' THEN   
      LET l_imecl005 = ''
      SELECT imecl005 INTO l_imecl005 FROM imecl_t
       WHERE imeclent = g_enterprise
         AND imecl001 = g_imaa005
         AND imecl002 = l_imeb002
         AND imecl003 = p_imas003
         AND imecl004 = g_dlang  
   END IF
   RETURN l_imecl005
END FUNCTION

 
{</section>}
 
