#該程式未解開Section, 採用最新樣板產出!
{<section id="aint701_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2016-09-14 11:02:04), PR版次:0002(2016-10-27 19:16:10)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000009
#+ Filename...: aint701_01
#+ Description: 揀貨裝箱單列印作業
#+ Creator....: 06137(2016-09-14 11:00:48)
#+ Modifier...: 06137 -SD/PR- 08172
 
{</section>}
 
{<section id="aint701_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#Memos
#160909-00069#8 2016/09/22  by 08172    新增装箱汇总单
#161024-00023#9 2016/10/27  by 08172    入库单据增加装箱功能
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc" name="global.inc"

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_inbn_m        RECORD
       l_type LIKE type_t.chr500, 
   inbn001 LIKE inbn_t.inbn001, 
   inbndocno LIKE inbn_t.inbndocno
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_wc                 STRING
DEFINE l_type               LIKE type_t.chr1
DEFINE g_inbndocno          LIKE inbn_t.inbndocno
DEFINE g_inbn001            LIKE inbn_t.inbn001
#end add-point
 
DEFINE g_inbn_m        type_g_inbn_m
 
   DEFINE g_inbn001_t LIKE inbn_t.inbn001
DEFINE g_inbndocno_t LIKE inbn_t.inbndocno
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aint701_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION aint701_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_inbndocno,
   p_inbn001
   #end add-point
   )
   #add-point:input段define name="input.define_customerization"
   
   #end add-point
   DEFINE l_ac_t          LIKE type_t.num10       #未取消的ARRAY CNT 
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num10
   DEFINE l_insert        LIKE type_t.num5
   DEFINE p_cmd           LIKE type_t.chr5
   #add-point:input段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   DEFINE p_inbndocno    LIKE inbn_t.inbndocno
   DEFINE p_inbn001      LIKE inbn_t.inbn001
   DEFINE l_wc           STRING
   DEFINE l_inbm008      LIKE inbm_t.inbm008
   DEFINE l_inbm003      LIKE inbm_t.inbm003    #161024-00023#9 by 08172
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aint701_01 WITH FORM cl_ap_formpath("ain","aint701_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   LET g_inbndocno = p_inbndocno
   LET g_inbn001   = p_inbn001
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_inbn_m.l_type,g_inbn_m.inbndocno ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_type
            #add-point:BEFORE FIELD l_type name="input.b.l_type"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_type
            
            #add-point:AFTER FIELD l_type name="input.a.l_type"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_type
            #add-point:ON CHANGE l_type name="input.g.l_type"
            IF g_inbn_m.l_type = '2' THEN
               #LET g_inbn_m.inbn001 = g_inbn001
               LET g_inbn_m.inbn001 = ''
               DISPLAY g_inbn_m.inbn001 TO inbn001 
            ELSE
               LET g_inbn_m.inbn001 = ''
               DISPLAY g_inbn_m.inbn001 TO inbn001            
            END IF
            LET g_wc = " 1=1"
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbndocno
            #add-point:BEFORE FIELD inbndocno name="input.b.inbndocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbndocno
            
            #add-point:AFTER FIELD inbndocno name="input.a.inbndocno"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            #IF  NOT cl_null(g_inbn_m.inbndocno) AND NOT cl_null(g_inbn_m.inbn001) THEN 
            #   IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_inbn_m.inbndocno != g_inbndocno_t  OR g_inbn_m.inbn001 != g_inbn001_t )) THEN 
            #      IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM inbn_t WHERE "||"inbnent = " ||g_enterprise|| " AND "||"inbndocno = '"||g_inbn_m.inbndocno ||"' AND "|| "inbn001 = '"||g_inbn_m.inbn001 ||"'",'std-00004',0) THEN 
            #         NEXT FIELD CURRENT
            #      END IF
            #   END IF
            #END IF




            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbndocno
            #add-point:ON CHANGE inbndocno name="input.g.inbndocno"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.l_type
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_type
            #add-point:ON ACTION controlp INFIELD l_type name="input.c.l_type"
            
            #END add-point
 
 
         #Ctrlp:input.c.inbndocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbndocno
            #add-point:ON ACTION controlp INFIELD inbndocno name="input.c.inbndocno"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            
            #end add-point
            
      END INPUT
    
      #add-point:自定義input name="input.more_input"
      CONSTRUCT BY NAME g_wc ON inbn001
         BEFORE FIELD inbn001
           IF g_inbn_m.l_type = '2' THEN
              NEXT FIELD l_type 
           END IF 
         
         #一般欄位開窗相關處理
         ON ACTION controlp INFIELD inbn001
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " inbndocno = '",g_inbndocno,"'"
            CALL q_inbn001()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbn001  #顯示到畫面上
            NEXT FIELD inbn001                     #返回原欄位      
      END CONSTRUCT

      BEFORE DIALOG
         CALL cl_set_act_visible("accept",FALSE)
         CALL cl_set_act_visible("cancel",FALSE)         
         LET g_inbn_m.l_type = '1'   #列印格式
         DISPLAY BY NAME l_type
         DISPLAY g_inbn_m.inbn001 TO inbn001
         
         NEXT FIELD l_type
         
      ON ACTION confirm
         IF g_inbn_m.l_type = '1' THEN
            DISPLAY "g_wc:",g_wc
            DISPLAY "g_inbndocno:",g_inbndocno
            LET g_wc = g_wc , " AND inbndocno = '",g_inbndocno,"'"
            CALL aint701_g01(g_wc)
         END IF
         #160909-00069#8 -s by 08172
         IF g_inbn_m.l_type = '2' THEN
#            IF g_wc = " 1=1" THEN
#               LET l_wc = g_wc," AND inbo001 = '",g_inbn001,"'"
#            ELSE
#               LET l_wc = cl_replace_str(g_wc,'inbn001','inbo001')
#            END IF
            SELECT inbm008,inbm003 INTO l_inbm008,l_inbm003   #161024-00023#9 add inbm003 by 08172
              FROM inbm_t
             WHERE inbment =  g_enterprise
               AND inbmdocno = g_inbndocno
            DISPLAY "g_wc:",l_wc
            DISPLAY "g_inbmdocno:",g_inbndocno
            LET l_wc = l_wc , " inbmdocno = '",g_inbndocno,"'"
#            CALL aint701_g02(l_wc,l_inbm008,l_inbm003)   #161024-00023#9 add inbm003 by 08172
         END IF
         #160909-00069#8 -e by 08172
         
      ON ACTION cancel1
         LET INT_FLAG = TRUE 
         EXIT DIALOG 
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
 
   #add-point:畫面關閉前 name="input.before_close"
   
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_aint701_01 
   
   #add-point:input段after input name="input.post_input"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aint701_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aint701_01.other_function" readonly="Y" >}

 
{</section>}
 
