#該程式未解開Section, 採用最新樣板產出!
{<section id="azzi060_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2017-01-05 13:42:01), PR版次:0001(2017-01-11 15:08:21)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: azzi060_01
#+ Description: 自定義語系
#+ Creator....: 01856(2017-01-05 11:35:43)
#+ Modifier...: 01856 -SD/PR- 01856
 
{</section>}
 
{<section id="azzi060_01.global" >}
#應用 c02b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#Memos
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
PRIVATE TYPE type_g_gzor_d        RECORD
       gzorstus LIKE gzor_t.gzorstus, 
   gzor001 LIKE gzor_t.gzor001, 
   gzor004 LIKE gzor_t.gzor004
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_gzor_d_o        DYNAMIC ARRAY OF type_g_gzor_d
#end add-point
 
DEFINE g_gzor_d          DYNAMIC ARRAY OF type_g_gzor_d
DEFINE g_gzor_d_t        type_g_gzor_d
 
 
DEFINE g_gzor001_t   LIKE gzor_t.gzor001    #Key值備份
 
 
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
 
{<section id="azzi060_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION azzi060_01(--)
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
   OPEN WINDOW w_azzi060_01 WITH FORM cl_ap_formpath("azz","azzi060_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單身前置處理 name="input.pre_input"
   CALL azzi060_01_bill()
   LET l_allow_delete = FALSE
   LET l_allow_insert = FALSE
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT ARRAY g_gzor_d FROM s_detail1.*
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
        
         BEFORE ROW

            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            DISPLAY g_detail_idx TO FORMONLY.idx
            DISPLAY g_gzor_d.getLength() TO FORMONLY.cnt
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzorstus
            #add-point:BEFORE FIELD gzorstus name="input.b.page1.gzorstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzorstus
            
            #add-point:AFTER FIELD gzorstus name="input.a.page1.gzorstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzorstus
            #add-point:ON CHANGE gzorstus name="input.g.page1.gzorstus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzor001
            #add-point:BEFORE FIELD gzor001 name="input.b.page1.gzor001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzor001
            
            #add-point:AFTER FIELD gzor001 name="input.a.page1.gzor001"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_gzor_d[g_detail_idx].gzor001 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gzor_d[g_detail_idx].gzor001 != g_gzor_d_t.gzor001)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gzor_t WHERE "||"gzor001 = '"||g_gzor_d[g_detail_idx].gzor001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzor001
            #add-point:ON CHANGE gzor001 name="input.g.page1.gzor001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzor004
            #add-point:BEFORE FIELD gzor004 name="input.b.page1.gzor004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzor004
            
            #add-point:AFTER FIELD gzor004 name="input.a.page1.gzor004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzor004
            #add-point:ON CHANGE gzor004 name="input.g.page1.gzor004"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.gzorstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzorstus
            #add-point:ON ACTION controlp INFIELD gzorstus name="input.c.page1.gzorstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzor001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzor001
            #add-point:ON ACTION controlp INFIELD gzor001 name="input.c.page1.gzor001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzor004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzor004
            #add-point:ON ACTION controlp INFIELD gzor004 name="input.c.page1.gzor004"
            
            #END add-point
 
 
 
 
         #自訂ACTION
         #add-point:單身其他段落處理(EX:on row change, etc...) name="input.other"
         
         #end add-point
 
         AFTER INPUT
            #add-point:單身輸入後處理 name="input.after_input"
            
            #end add-point
            
      END INPUT
      
 
      
      #add-point:自定義input name="input.more_input"
      BEFORE DIALOG      
         #鎖住delete 不可刪除
         CALL cl_set_act_visible("insert,delete", FALSE)
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

   CALL azzi060_01_update()
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_azzi060_01 
   
   #add-point:input段after input name="input.post_input"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="azzi060_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="azzi060_01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 資料更新
# Memo...........:
# Usage..........: CALL azzi060_01_update()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
# Return code....: 回传参数变量1   回传参数变量说明1
# Date & Author..: 2017/01/05 By jrg542
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi060_01_update()
   DEFINE li_cnt LIKE type_t.num5

   FOR li_cnt = 1 TO g_gzor_d.getLength()
       IF g_gzor_d_o[li_cnt].gzorstus <> g_gzor_d[li_cnt].gzorstus THEN 
          UPDATE gzor_t SET gzorstus = g_gzor_d[li_cnt].gzorstus
           WHERE gzor001 = g_gzor_d[li_cnt].gzor001
       END IF 
   END FOR 
END FUNCTION

################################################################################
# Descriptions...: 撈取單身資料
# Memo...........:
# Usage..........: CALL azzi060_01_bill()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
# Return code....: 回传参数变量1   回传参数变量说明1
# Date & Author..: 2017/01/05 By jrg542
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi060_01_bill()
   DEFINE ls_sql      STRING 
   DEFINE li_cnt      LIKE type_t.num5
   DEFINE ls_lang     STRING 
   DEFINE l_token     base.StringTokenizer
   DEFINE ls_token    STRING

   #取得註冊語系
   LET ls_lang = cl_ap_avaliable_lang()    #zh_TW,zh_CN,ja_JP,vi_VN,en_US,ko_KR,th_TH   
   LET l_token = base.StringTokenizer.create(ls_lang,",")
   WHILE l_token.hasMoreTokens()
      LET ls_token = l_token.nextToken()
      LET ls_sql = ls_sql,"'",ls_token,"',"
   END WHILE

   LET ls_sql = ls_sql.subString(1,ls_sql.getLength()-1)  #('zh_TW','zh_CN')
   
   LET ls_sql = "SELECT gzorstus,gzor001,gzor004 FROM gzor_t WHERE gzor003 NOT IN (",ls_sql,")"

   CALL g_gzor_d.clear()
   LET li_cnt = 1
   DECLARE azzi060_01_bill_cs CURSOR FROM ls_sql

   FOREACH azzi060_01_bill_cs INTO g_gzor_d[li_cnt].gzorstus,g_gzor_d[li_cnt].gzor001,g_gzor_d[li_cnt].gzor004

      LET li_cnt = li_cnt + 1
   END FOREACH 

   CALL g_gzor_d.deleteElement(li_cnt)

   FOR li_cnt = 1 TO g_gzor_d.getLength()
       LET g_gzor_d_o[li_cnt].gzorstus = g_gzor_d[li_cnt].gzorstus
       LET g_gzor_d_o[li_cnt].gzor001 = g_gzor_d[li_cnt].gzor001
       LET g_gzor_d_o[li_cnt].gzor004 = g_gzor_d[li_cnt].gzor004
   END FOR  
   CLOSE azzi060_01_bill_cs   
END FUNCTION

 
{</section>}
 
