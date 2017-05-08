#該程式未解開Section, 採用最新樣板產出!
{<section id="abgi080_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2015-10-21 10:07:15), PR版次:0003(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000159
#+ Filename...: abgi080_01
#+ Description: 公式產生器
#+ Creator....: 02416(2014-02-12 15:43:50)
#+ Modifier...: 03080 -SD/PR- 00000
 
{</section>}
 
{<section id="abgi080_01.global" >}
#應用 c01c 樣板自動產生(Version:10)
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
 
DEFINE g_rec_b               LIKE type_t.num10
DEFINE g_wc                  STRING
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 type type_g_bgae_m        RECORD
       bgae006 LIKE bgae_t.bgae006,
   bgae006_desc LIKE type_t.chr80,
   bgae001 LIKE bgae_t.bgae001,
   bgae001_desc LIKE type_t.chr80
   END RECORD
DEFINE g_bgae_m          type_g_bgae_m
DEFINE g_bgae_m_t        type_g_bgae_m
DEFINE g_bgae_m_o        type_g_bgae_m
DEFINE l_ac                  LIKE type_t.num5
DEFINE g_detail_idx          LIKE type_t.num5  
DEFINE g_bgae013    LIKE bgae_t.bgae013
 TYPE type_g_chr_d RECORD
       chr01   LIKE type_t.chr1,
       chr02   LIKE type_t.chr1,
       chr03   LIKE type_t.chr1,
       chr04   LIKE bgae_t.bgae001,
       chr05   LIKE type_t.chr1
       END RECORD
DEFINE g_chr_d          DYNAMIC ARRAY OF  type_g_chr_d
DEFINE g_chr_d_t        type_g_chr_d
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point  
 
{</section>}
 
{<section id="abgi080_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION abgi080_01(--)
   #add-point:construct段變數傳入 name="construct.get_var"
   p_bgae001,
   p_bgae006,
   p_bgae013
   #end add-point
   )
   #add-point:construct段define name="construct.define_customerization"
   
   #end add-point
   DEFINE l_ac_t          LIKE type_t.num10       #未取消的ARRAY CNT 
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num10
   DEFINE l_insert        LIKE type_t.num5
   #add-point:construct段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="construct.define"
   DEFINE p_bgae001       LIKE bgae_t.bgae001
   DEFINE p_bgae006       LIKE bgae_t.bgae006
   DEFINE p_bgae013       LIKE bgae_t.bgae013
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_abgi080_01 WITH FORM cl_ap_formpath("abg","abgi080_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   #輸入前處理
   #add-point:單頭前置處理 name="construct.pre_construct"
   LET g_bgae_m.bgae001=p_bgae001
   LET g_bgae_m.bgae006=p_bgae006
   LET g_bgae013=p_bgae013

   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      CONSTRUCT BY NAME g_wc ON bgae006,bgae001 
      
            #add-point:自定義action name="construct.action"
            
            #end add-point
      
         BEFORE CONSTRUCT
            #add-point:單頭輸入前處理 name="construct.before_construct"
            EXIT DIALOG
            #end add-point
            
         AFTER CONSTRUCT
            #add-point:單頭輸入後處理 name="construct.after_construct"
            
            #end add-point
            
         
 
         
       
      END CONSTRUCT
 
      #add-point:自定義construct name="construct.more_construct"
      
      #end add-point
      
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
 
   #add-point:畫面關閉前 name="construct.before_close"
   DISPLAY BY NAME g_bgae_m.bgae001,g_bgae_m.bgae006  
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_bgae_m.bgae006
   CALL ap_ref_array2(g_ref_fields,"SELECT ooall004 FROM ooall_t WHERE ooallent='"||g_enterprise||"' AND ooall001='11' AND ooall002=? AND ooall003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_bgae_m.bgae006_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_bgae_m.bgae006_desc
   INITIALIZE g_ref_fields TO NULL 
   LET g_ref_fields[1] = g_bgae_m.bgae006
   LET g_ref_fields[2] = g_bgae_m.bgae001
   CALL ap_ref_array2(g_ref_fields," SELECT bgael003 FROM bgael_t WHERE bgaelent = '"||g_enterprise||"' AND bgael006 = ? AND bgael001 = ? AND bgael002 =  '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_bgae_m.bgae001_desc = g_rtn_fields[1] 
   DISPLAY BY NAME g_bgae_m.bgae001_desc   
   IF NOT cl_null(p_bgae013) THEN
      CALL abgi080_01_b_fill(p_bgae013)
   END IF
   CALL abgi080_01_input()
   CALL abgi080_01_create()
   #end add-point 
   
   #畫面關閉
   CLOSE WINDOW w_abgi080_01 
   
   #add-point:construct段after construct name="construct.post_construct"
   RETURN g_bgae013
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="abgi080_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="abgi080_01.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 填寫公式內容
# Memo...........:
# Usage..........: CALLabgi080_01_input()
#                  RETURNING 回传参数
# Input parameter: null
# Return code....: null
# Date & Author..: 14/02/12 By yuhuabao
# Modify.........:
################################################################################
PRIVATE FUNCTION abgi080_01_input()
DEFINE l_cnt  LIKE type_t.num5 
DEFINE l_cmd  LIKE type_t.chr1
      IF cl_null(g_bgae013) THEN CALL g_chr_d.clear() END IF
      INPUT ARRAY g_chr_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,UNBUFFERED,
                  INSERT ROW = FALSE,
                  DELETE ROW = TRUE,
                  APPEND ROW = TRUE )
         
         #自訂ACTION
         #add-point:單身前置處理


 
         
         BEFORE INPUT
            #add-point:單身輸入前處理
            CALL FGL_SET_ARR_CURR(1) 

            #end add-point
            
         BEFORE ROW
            #add-point:單身輸入前處理
            LET l_ac = ARR_CURR()
            IF l_ac <= g_rec_b THEN
               LET l_cmd = 'u'
            ELSE
               LET l_cmd = 'a'
            END IF

         BEFORE INSERT 
            LET l_cmd = 'a'
            IF l_ac = 1 THEN
               LET g_chr_d[l_ac].chr01 = '='
            END IF
            LET g_chr_d[l_ac].chr03 = 'N'

            
         AFTER FIELD chr01
            IF l_ac = 1 AND g_chr_d[l_ac].chr01 <> '=' THEN
               LET g_chr_d[l_ac].chr01 = '='
               DISPLAY BY NAME g_chr_d[l_ac].chr01
               NEXT FIELD chr02               
            END IF
            IF  g_chr_d[l_ac].chr01 <> '+' 
               AND g_chr_d[l_ac].chr01 <> '-' 
               AND g_chr_d[l_ac].chr01 <> '*' 
               AND g_chr_d[l_ac].chr01 <> '/' 
               AND g_chr_d[l_ac].chr01 <> '=' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'abg-00053'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET g_chr_d[l_ac].chr01 = ''
               NEXT FIELD chr01
            END IF
            
         ON CHANGE chr03
            LET g_chr_d[l_ac].chr04 = NULL
            
         AFTER FIELD chr04
            IF g_chr_d[l_ac].chr03 = 'N' THEN
               SELECT COUNT(bgae001) INTO l_cnt FROM bgae_t
                WHERE bgaeent = g_enterprise
                  AND bgae006 = g_bgae_m.bgae006
                  AND bgae001 = g_chr_d[l_ac].chr04
                  AND bgaestus = 'Y'
               IF l_cnt <= 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'abg-00052'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET g_chr_d[l_ac].chr04 = g_chr_d_t.chr04
                  NEXT FIELD chr04
               END IF
            END IF
 
        BEFORE DELETE               
            IF l_cmd = 'a' THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_chr_d.deleteElement(l_ac)
               NEXT FIELD chr01
            END IF
            IF g_chr_d_t.chr01 IS NOT NULL AND l_ac <> '1' THEN
                             
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF

            END IF       
      AFTER INPUT
            #add-point:單身輸入後處理

            #end add-point
         ON ACTION controlp INFIELD chr04
            #add-point:ON ACTION controlp INFIELD bgae001
            #此段落由子樣板a08產生
            #開窗c段
            IF g_chr_d[l_ac].chr03 = 'N' THEN
			   INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
		   	   LET g_qryparam.default1 = g_chr_d[l_ac].chr04
		   	   LET g_qryparam.where = " bgae006='",g_bgae_m.bgae006,"'"
               CALL q_bgae001()                           #呼叫開窗
               LET g_chr_d[l_ac].chr04 = g_qryparam.return1
               DISPLAY BY NAME g_chr_d[l_ac].chr04
             END IF
             NEXT FIELD chr04                     #返回原欄位

      ON ACTION accept
         ACCEPT INPUT
        
      ON ACTION cancel
         LET INT_FLAG = TRUE 
         EXIT INPUT
 
      ON ACTION close
         LET INT_FLAG = TRUE 
         EXIT INPUT
 
      ON ACTION exit
         LET INT_FLAG = TRUE 
         EXIT INPUT           
   END INPUT

END FUNCTION
################################################################################
# Descriptions...: 公式產生
# Memo...........:
# Usage..........: CALL abgi080_01_create()
#                  RETURNING 回传参数
# Input parameter: 無
# Return code....: 無
# Date & Author..: 14/02/12 By yuhuabao 
# Modify.........:
################################################################################
PRIVATE FUNCTION abgi080_01_create()
DEFINE  l_i   LIKE type_t.num5
   LET g_bgae013 = NULL
   FOR l_i = 1 TO g_chr_d.getLength()
       LET g_bgae013 = g_bgae013 CLIPPED,g_chr_d[l_i].chr01 CLIPPED
                                        ,g_chr_d[l_i].chr02 CLIPPED
                                        ,g_chr_d[l_i].chr03 CLIPPED
                                        ,g_chr_d[l_i].chr04 CLIPPED
                                        ,g_chr_d[l_i].chr05 CLIPPED
   END FOR
END FUNCTION
################################################################################
# Descriptions...: 如果當前行公式不為空則暫開填充
# Memo...........:
# Usage..........: CALL abgi080_01_b_fill(p_bgae014)
#                  RETURNING 回传参数
# Input parameter: p_bgae014
# Return code....: 無
# Date & Author..: 14/02/12 By yuhuabao
# Modify.........:
################################################################################
PRIVATE FUNCTION abgi080_01_b_fill(p_bgae013)
DEFINE p_bgae013 LIKE bgae_t.bgae013
DEFINE l_str  STRING
DEFINE l_cnt  LIKE type_t.num5
DEFINE l_len  LIKE type_t.num5
DEFINE l_i,l_start,l_end    LIKE type_t.num5
   LET l_str = p_bgae013
   LET l_cnt = 1
   LET l_len = l_str.getLength()
   CALL g_chr_d.clear()
   FOR l_i = 1 TO l_len
    IF p_bgae013[l_i,l_i] = '+' 
       OR p_bgae013[l_i,l_i] = '-' 
       OR p_bgae013[l_i,l_i] = '*' 
       OR p_bgae013[l_i,l_i] = '/' 
       OR p_bgae013[l_i,l_i] = '=' THEN
       LET g_chr_d[l_cnt].chr01 =  p_bgae013[l_i,l_i]          
       #如果運算符下一位是(
       IF l_cnt > 1 THEN
          IF p_bgae013[l_i-1,l_i-1] = ')' THEN
             LET g_chr_d[l_cnt-1].chr05 = ')'
             LET l_end = l_i - 2

          ELSE
             LET g_chr_d[l_cnt-1].chr05 = ''
             LET l_end = l_i - 1
          END IF          
          IF l_start <=l_end THEN
             LET g_chr_d[l_cnt-1].chr04 = p_bgae013[l_start,l_end]
          ELSE
             LET g_chr_d[l_cnt-1].chr04 = ''
          END IF
       END IF
       IF p_bgae013[l_i+1,l_i+1] = '(' THEN
          LET g_chr_d[l_cnt].chr02 = '('
          LET g_chr_d[l_cnt].chr03 = p_bgae013[l_i+2,l_i+2] 
          LET l_start = l_i+3          
       ELSE
          LET g_chr_d[l_cnt].chr02 = ''
          LET g_chr_d[l_cnt].chr03 = p_bgae013[l_i+1,l_i+1]
          LET l_start = l_i+2
       END IF       
       LET l_cnt = l_cnt + 1
    END IF
    IF l_i = l_len THEN
       IF p_bgae013[l_i,l_i] = ')' THEN
          LET g_chr_d[l_cnt-1].chr05 = ')'
          LET l_end = l_i - 1
       ELSE
          LET g_chr_d[l_cnt-1].chr05 = ''
          LET l_end = l_i
       END IF  
       IF l_start <=l_end THEN
           LET g_chr_d[l_cnt-1].chr04 = p_bgae013[l_start,l_end]
       ELSE
          LET g_chr_d[l_cnt-1].chr04 = ''
       END IF        
    END IF
   END FOR
   LET g_rec_b=g_chr_d.getLength()
END FUNCTION

 
{</section>}
 
