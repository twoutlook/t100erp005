#該程式未解開Section, 採用最新樣板產出!
{<section id="asft300_04.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2014-01-08 00:00:00), PR版次:0002(2014-11-26 16:14:50)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000113
#+ Filename...: asft300_04
#+ Description: 批次產生產品序號
#+ Creator....: 01258(2014-01-08 14:52:51)
#+ Modifier...: 01258 -SD/PR- 01258
 
{</section>}
 
{<section id="asft300_04.global" >}
#應用 c01b 樣板自動產生(Version:10)
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
 
#add-point:增加匯入變數檔 name="global.inc" name="global.inc"

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_sfaf_m        RECORD
       sfaf001 LIKE sfaf_t.sfaf001, 
   number LIKE type_t.num10
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_sfafdocno           LIKE sfaf_t.sfafdocno
DEFINE g_start_no            LIKE sfaf_t.sfaf001
DEFINE g_sfafdocno_t   LIKE sfaf_t.sfafdocno    #Key值備份
DEFINE g_sfaf001_t      LIKE sfaf_t.sfaf001    #Key值備份
#end add-point
 
DEFINE g_sfaf_m        type_g_sfaf_m
 
   
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="asft300_04.input" >}
#+ 資料輸入
PUBLIC FUNCTION asft300_04(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_sfaadocno
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
   DEFINE p_sfaadocno     LIKE sfaa_t.sfaadocno
   DEFINE l_sfaa012       LIKE type_t.num10
   DEFINE l_n             LIKE type_t.num10
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_asft300_04 WITH FORM cl_ap_formpath("asf","asft300_04")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   LET g_sfafdocno = p_sfaadocno
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_sfaf_m.sfaf001,g_sfaf_m.number ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfaf001
            #add-point:BEFORE FIELD sfaf001 name="input.b.sfaf001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfaf001
            
            #add-point:AFTER FIELD sfaf001 name="input.a.sfaf001"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_sfaf_m.sfaf001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_sfaf_m.sfaf001 != g_sfaf001_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM sfaf_t WHERE "||"sfafent = '" ||g_enterprise|| "' AND "||"sfafsite = '"||g_site ||"' AND "|| "sfafdocno = '"||g_sfafdocno ||"' AND "|| "sfaf001 = '"||g_sfaf_m.sfaf001 ||"'",'std-00004',0) THEN 
                     LET g_sfaf_m.sfaf001 = g_sfaf001_t
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT asft300_04_sfaf_check() THEN
                     LET g_sfaf_m.sfaf001 = g_sfaf001_t
                     NEXT FIELD CURRENT
                  END IF                 
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfaf001
            #add-point:ON CHANGE sfaf001 name="input.g.sfaf001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD number
            #add-point:BEFORE FIELD number name="input.b.number"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD number
            
            #add-point:AFTER FIELD number name="input.a.number"
            IF NOT asft300_04_sfaf_check() THEN
               NEXT FIELD CURRENT
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE number
            #add-point:ON CHANGE number name="input.g.number"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.sfaf001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfaf001
            #add-point:ON ACTION controlp INFIELD sfaf001 name="input.c.sfaf001"
            
            #END add-point
 
 
         #Ctrlp:input.c.number
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD number
            #add-point:ON ACTION controlp INFIELD number name="input.c.number"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            
            #end add-point
            
      END INPUT
    
      #add-point:自定義input name="input.more_input"
      BEFORE DIALOG
         LET g_sfaf_m.sfaf001 = ''
         SELECT sfaa012 INTO l_sfaa012 FROM sfaa_t
          WHERE sfaaent = g_enterprise AND sfaasite = g_site
            AND sfaadocno = g_sfafdocno
         SELECT COUNT(*) INTO l_n FROM sfaf_t
          WHERE sfafent = g_enterprise AND sfafsite = g_site
            AND sfafdocno = g_sfafdocno
         LET g_sfaf_m.number = l_sfaa012 - l_n
         IF cl_null(g_sfaf_m.number) OR g_sfaf_m.number < 0 THEN
            LET g_sfaf_m.number = 0
         END IF
         DISPLAY BY NAME g_sfaf_m.sfaf001,g_sfaf_m.number
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
   IF INT_FLAG THEN
      LET INT_FLAG = 0 
   ELSE
      CALL asft300_04_ins_sfaf() 
   END IF

   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_asft300_04 
   
   #add-point:input段after input name="input.post_input"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="asft300_04.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="asft300_04.other_function" readonly="Y" >}
#批次新增产品序号
PRIVATE FUNCTION asft300_04_ins_sfaf()
DEFINE l_no1     LIKE type_t.num20
DEFINE l_no2     LIKE type_t.num20
DEFINE l_a       LIKE type_t.chr80
DEFINE l_i       LIKE type_t.num10
DEFINE l_n       LIKE type_t.num5
DEFINE l_sfaf001 LIKE sfaf_t.sfaf001
DEFINE l_sfafseq LIKE sfaf_t.sfafseq
   
   IF cl_null(g_start_no) THEN
      RETURN
   END IF 
   LET l_no1 = g_start_no
   FOR l_i = 1 TO LENGTH(g_start_no)
      IF cl_null(l_a) THEN
         LET l_a = '&'
      ELSE
         LET l_a = l_a,'&'
      END IF 
   END FOR
 
   FOR l_i = 1 TO g_sfaf_m.number
      LET l_no2 = l_no1 + l_i - 1
      LET l_sfaf001 = l_no2 USING l_a
      LET l_sfaf001 = g_sfaf_m.sfaf001[1,LENGTH(g_sfaf_m.sfaf001)-LENGTH(g_start_no)],l_sfaf001
      SELECT COUNT(*) INTO l_n FROM sfaf_t WHERE sfafent=g_enterprise AND sfafsite=g_site
         AND sfafdocno=g_sfafdocno AND sfaf001=l_sfaf001
      IF l_n = 0 THEN
         SELECT MAX(sfafseq)+1 INTO l_sfafseq FROM sfaf_t WHERE sfafent=g_enterprise AND sfafsite=g_site
            AND sfafdocno=g_sfafdocno
         IF cl_null(l_sfafseq) THEN
            LET l_sfafseq = 1 
         END IF
         INSERT INTO sfaf_t(sfafent,sfafsite,sfafdocno,sfafseq,sfaf001) VALUES(g_enterprise,g_site,g_sfafdocno,l_sfafseq,l_sfaf001)
      END IF
   END FOR
END FUNCTION
#栏位检查
PRIVATE FUNCTION asft300_04_sfaf_check()
   DEFINE l_length        LIKE type_t.num5
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_start_no      LIKE sfaf_t.sfaf001
   DEFINE l_end_no        LIKE sfaf_t.sfaf001
   DEFINE l_no1           LIKE type_t.num20
   DEFINE l_no2           LIKE type_t.num20
   
   IF cl_null(g_sfaf_m.sfaf001) THEN
      RETURN TRUE
   END IF
   
   LET l_length  = LENGTH(g_sfaf_m.sfaf001)
   LET l_start_no = ''
   FOR l_i = l_length TO 1 STEP -1
      IF g_sfaf_m.sfaf001[l_i,l_i] MATCHES '[0-9]' THEN
         IF cl_null(l_start_no) THEN
            LET l_start_no = g_sfaf_m.sfaf001[l_i,l_i]
         ELSE
            LET l_start_no = g_sfaf_m.sfaf001[l_i,l_i],l_start_no
         END IF
      ELSE
         EXIT FOR
      END IF
   END FOR
   IF cl_null(l_start_no) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00063'
      LET g_errparam.extend = g_sfaf_m.sfaf001
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF 
   IF NOT cl_null(g_sfaf_m.number) AND g_sfaf_m.number > 0 THEN
      LET l_no1 = l_start_no
      LET l_no2 = l_no1 + g_sfaf_m.number-1
      LET l_end_no = l_no2
      IF LENGTH(l_start_no) < LENGTH(l_end_no) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'asf-00064'
         LET g_errparam.extend = g_sfaf_m.sfaf001
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
      LET g_start_no = l_start_no
   END IF    
   RETURN TRUE
END FUNCTION

 
{</section>}
 
