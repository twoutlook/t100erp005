#該程式未解開Section, 採用最新樣板產出!
{<section id="abgi070_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2016-07-27 10:56:12), PR版次:0004(2016-12-27 14:34:30)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000021
#+ Filename...: abgi070_02
#+ Description: 複製財報結構
#+ Creator....: 01267(2016-07-12 11:55:13)
#+ Modifier...: 03080 -SD/PR- 05016
 
{</section>}
 
{<section id="abgi070_02.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#Memos
#161104-00024#7  161108 By 08171   程式中DEFINE RECORD LIKE時不可以用*的寫法，要一個一個欄位定義
#161108-00017#5  161110 By 08732   程式中INSERT INTO時不可以用*的寫法，要一個一個欄位定義
#161222-00005#4  161223 By Hans    1.批次產生的時候不控卡公式來源。 2.無法轉換科目的時候直接給值
#                                  3.取值方式給來源值              4.執行結束的時候應給提示 5.模板開窗不開ABG的
#161226-00002#5  161227 By 05016   批次產生的時候，glfcl_t說明應該也一併產生過去。
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"
IMPORT util    #為了JSON
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc" name="global.inc"

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_glfa_m        RECORD
       glfa001 LIKE glfa_t.glfa001, 
   glfa001_desc LIKE type_t.chr80, 
   glfa004 LIKE glfa_t.glfa004, 
   glfa002 LIKE glfa_t.glfa002, 
   l_dummy LIKE type_t.chr80, 
   l_glfa001_1 LIKE type_t.chr10, 
   l_glfa001_1_desc LIKE type_t.chr100, 
   l_glfa004_1 LIKE type_t.chr10, 
   l_glfa002_1 LIKE type_t.chr1
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_glfa_m_o      type_g_glfa_m     #儲存舊值方便比較
#end add-point
 
DEFINE g_glfa_m        type_g_glfa_m
 
   DEFINE g_glfa001_t LIKE glfa_t.glfa001
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="abgi070_02.input" >}
#+ 資料輸入
PUBLIC FUNCTION abgi070_02(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_lsjs
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
   DEFINE p_lsjs          STRING              #動態JSON使用的字串
   DEFINE r_success       LIKE type_t.num5    #成功與否
   DEFINE r_abgi070       LIKE glfa_t.glfa001 #產生的abgi070報表版號
   
   WHENEVER ERROR CONTINUE
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_abgi070_02 WITH FORM cl_ap_formpath("abg","abgi070_02")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   LET r_success = TRUE
   CALL cl_set_combo_scc('glfa002','9930')
   CALL cl_set_combo_scc('l_glfa002_1','9930')
   INITIALIZE g_glfa_m.* TO NULL
   INITIALIZE g_glfa_m_o.* TO NULL
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_glfa_m.glfa001,g_glfa_m.glfa004,g_glfa_m.glfa002,g_glfa_m.l_glfa001_1,g_glfa_m.l_glfa001_1_desc, 
          g_glfa_m.l_glfa004_1,g_glfa_m.l_glfa002_1 ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glfa001
            
            #add-point:AFTER FIELD glfa001 name="input.a.glfa001"

            #應用 a05 樣板自動產生(Version:3)
           ##確認資料無重複
           #IF  NOT cl_null(g_glfa_m.glfa001) THEN 
           #   IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_glfa_m.glfa001 != g_glfa001_t )) THEN 
           #      IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM glfa_t WHERE "||"glfaent = '" ||g_enterprise|| "' AND "||"glfa001 = '"||g_glfa_m.glfa001 ||"'",'std-00004',0) THEN 
           #         NEXT FIELD CURRENT
           #      END IF
           #   END IF
           #END IF

            #報表模板
            IF NOT cl_null(g_glfa_m.glfa001)THEN
               IF cl_null(g_glfa_m_o.glfa001) OR (g_glfa_m.glfa001 <> g_glfa_m_o.glfa001)THEN
                  CALL abgi070_02_glfa001_chk(g_glfa_m.glfa001,'1')RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam.* TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_glfa_m.glfa001 = g_glfa_m_o.glfa001
                     NEXT FIELD glfa001
                  END IF
                  
                  CALL abgi070_02_glfa001004_chk(g_glfa_m.glfa001,g_glfa_m.l_glfa004_1)RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam.* TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_glfa_m.glfa001 = g_glfa_m_o.glfa001
                     NEXT FIELD glfa001
                  END IF                  
                  CALL abgi070_02_glfa001_carry()
               END IF
            END IF   
            CALL abgi070_02_to_o_h()            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glfa001
            #add-point:BEFORE FIELD glfa001 name="input.b.glfa001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glfa001
            #add-point:ON CHANGE glfa001 name="input.g.glfa001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glfa004
            
            #add-point:AFTER FIELD glfa004 name="input.a.glfa004"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glfa004
            #add-point:BEFORE FIELD glfa004 name="input.b.glfa004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glfa004
            #add-point:ON CHANGE glfa004 name="input.g.glfa004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glfa002
            #add-point:BEFORE FIELD glfa002 name="input.b.glfa002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glfa002
            
            #add-point:AFTER FIELD glfa002 name="input.a.glfa002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glfa002
            #add-point:ON CHANGE glfa002 name="input.g.glfa002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glfa001_1
            
            #add-point:AFTER FIELD l_glfa001_1 name="input.a.l_glfa001_1"
            #報表模板
            IF NOT cl_null(g_glfa_m.l_glfa001_1)THEN
               IF cl_null(g_glfa_m_o.l_glfa001_1) OR (g_glfa_m.l_glfa001_1 <> g_glfa_m_o.l_glfa001_1)THEN
                  CALL abgi070_02_glfa001_chk(g_glfa_m.l_glfa001_1,'2')RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam.* TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_glfa_m.l_glfa001_1 = g_glfa_m_o.l_glfa001_1
                     NEXT FIELD l_glfa001_1
                  END IF
               END IF
            END IF   
            CALL abgi070_02_to_o_h()  
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glfa001_1
            #add-point:BEFORE FIELD l_glfa001_1 name="input.b.l_glfa001_1"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glfa001_1
            #add-point:ON CHANGE l_glfa001_1 name="input.g.l_glfa001_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glfa001_1_desc
            #add-point:BEFORE FIELD l_glfa001_1_desc name="input.b.l_glfa001_1_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glfa001_1_desc
            
            #add-point:AFTER FIELD l_glfa001_1_desc name="input.a.l_glfa001_1_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glfa001_1_desc
            #add-point:ON CHANGE l_glfa001_1_desc name="input.g.l_glfa001_1_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glfa004_1
            
            #add-point:AFTER FIELD l_glfa004_1 name="input.a.l_glfa004_1"
            #預算細項參照表
            IF NOT cl_null(g_glfa_m.l_glfa004_1)THEN
               IF cl_null(g_glfa_m_o.l_glfa004_1) OR (g_glfa_m.l_glfa004_1 <> g_glfa_m_o.l_glfa004_1)THEN
                  CALL abgi070_02_glfa004_chk(g_glfa_m.l_glfa004_1)RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam.* TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_glfa_m.l_glfa004_1 = g_glfa_m_o.l_glfa004_1
                     NEXT FIELD l_glfa004_1
                  END IF
                  CALL abgi070_02_glfa001004_chk(g_glfa_m.glfa001,g_glfa_m.l_glfa004_1)RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam.* TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_glfa_m.l_glfa004_1 = g_glfa_m_o.l_glfa004_1
                     NEXT FIELD l_glfa004_1
                  END IF 
               END IF
            END IF   
            CALL abgi070_02_to_o_h() 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glfa004_1
            #add-point:BEFORE FIELD l_glfa004_1 name="input.b.l_glfa004_1"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glfa004_1
            #add-point:ON CHANGE l_glfa004_1 name="input.g.l_glfa004_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glfa002_1
            #add-point:BEFORE FIELD l_glfa002_1 name="input.b.l_glfa002_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glfa002_1
            
            #add-point:AFTER FIELD l_glfa002_1 name="input.a.l_glfa002_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glfa002_1
            #add-point:ON CHANGE l_glfa002_1 name="input.g.l_glfa002_1"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.glfa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glfa001
            #add-point:ON ACTION controlp INFIELD glfa001 name="input.c.glfa001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_glfa_m.glfa001
            LET g_qryparam.where = " glfa016 <> '3' " #161222-00005#4 
            CALL q_glfa001()
            LET g_glfa_m.glfa001 = g_qryparam.return1
            DISPLAY BY NAME g_glfa_m.glfa001
            CALL abgi070_02_glfa001_carry()
            NEXT FIELD glfa001
            #END add-point
 
 
         #Ctrlp:input.c.glfa004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glfa004
            #add-point:ON ACTION controlp INFIELD glfa004 name="input.c.glfa004"
 
            #END add-point
 
 
         #Ctrlp:input.c.glfa002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glfa002
            #add-point:ON ACTION controlp INFIELD glfa002 name="input.c.glfa002"
 
            #END add-point
 
 
         #Ctrlp:input.c.l_glfa001_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glfa001_1
            #add-point:ON ACTION controlp INFIELD l_glfa001_1 name="input.c.l_glfa001_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_glfa001_1_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glfa001_1_desc
            #add-point:ON ACTION controlp INFIELD l_glfa001_1_desc name="input.c.l_glfa001_1_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_glfa004_1
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glfa004_1
            #add-point:ON ACTION controlp INFIELD l_glfa004_1 name="input.c.l_glfa004_1"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_glfa_m.l_glfa004_1             #給予default值
            LET g_qryparam.where = "ooal001 = '11' " #預算細項參照表
            CALL q_ooal002()                                #呼叫開窗
            LET g_glfa_m.l_glfa004_1 = g_qryparam.return1              
            DISPLAY g_glfa_m.l_glfa004_1 TO l_glfa004_1              #
            NEXT FIELD l_glfa004_1                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.l_glfa002_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glfa002_1
            #add-point:ON ACTION controlp INFIELD l_glfa002_1 name="input.c.l_glfa002_1"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            
            #end add-point
            
      END INPUT
    
      #add-point:自定義input name="input.more_input"
      
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
   CLOSE WINDOW w_abgi070_02 
   
   #add-point:input段after input name="input.post_input"
   IF INT_FLAG THEN
      LET r_success= FALSE
      LET r_abgi070  = NULL
      LET INT_FLAG = 0
   ELSE
      CALL cl_err_collect_init()
      CALL s_transaction_begin()
      CALL abgi070_02_process() RETURNING g_sub_success,r_abgi070
      #IF NOT g_sub_success THEN LET r_success = FALSE END IF #161222-00005#4  mark
      #CALL s_transaction_end('Y',0) #161222-00005#4  mark
      #161222-00005#4 ---s---
      IF NOT g_sub_success THEN 
         LET r_success = FALSE 
         CALL s_transaction_end('N',0)
      ELSE
         CALL s_transaction_end('Y',0)
      END IF
      #161222-00005#4 ---e---
   END IF
   CALL cl_err_collect_show()
   RETURN r_success,r_abgi070
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="abgi070_02.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="abgi070_02.other_function" readonly="Y" >}

PRIVATE FUNCTION abgi070_02_glfa001_chk(p_glfa001,p_type)
   DEFINE p_glfa001   LIKE glfa_t.glfa001
   DEFINE p_type      LIKE type_t.chr1
   DEFINE r_success   LIKE type_t.num5
   DEFINE r_errno     LIKE gzze_t.gzze001
   DEFINE l_glfa001   LIKE glfa_t.glfa001
   WHENEVER ERROR CONTINUE
   
   LET r_success = TRUE LET r_errno = NULL
   
   CASE
      WHEN p_type = '1'
         #來源報表模板
         LET l_glfa001 = NULL
         SELECT glfa001 INTO l_glfa001 FROM glfa_t
          WHERE glfa001 = p_glfa001
            AND glfaent = g_enterprise
            AND glfa016 <> '3'        #161222-00005#4 
            
         CASE
            WHEN SQLCA.SQLCODE = 100
               LET r_success = FALSE
               LET r_errno   = 'agl-00249'
         END CASE
      WHEN p_type = '2'
         #目的報表模板
         LET l_glfa001 = NULL
         SELECT glfa001 INTO l_glfa001 FROM glfa_t
          WHERE glfa001 = p_glfa001
            AND glfaent = g_enterprise
            
         CASE
            WHEN NOT cl_null(l_glfa001)
               LET r_success = FALSE
               LET r_errno = 'aoo-00051'
         END CASE         
   END CASE
   
   RETURN r_success,r_errno
END FUNCTION

PRIVATE FUNCTION abgi070_02_to_o_h()
   WHENEVER ERROR CONTINUE
   LET g_glfa_m_o.* = g_glfa_m.*
END FUNCTION

PRIVATE FUNCTION abgi070_02_glfa004_chk(p_glfa004)
   DEFINE p_glfa004   LIKE glfa_t.glfa004
   DEFINE r_success   LIKE type_t.num5
   DEFINE r_errno     LIKE gzze_t.gzze001
   DEFINE l_ooalstus  LIKE ooal_t.ooalstus
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE   LET r_errno = NULL
   
   LET l_ooalstus = NULL
   SELECT ooalstus INTO l_ooalstus FROM ooal_t
    WHERE ooalent = g_enterprise
      AND ooal001 = '11'
      AND ooal002 = p_glfa004
   CASE
      WHEN SQLCA.SQLCODE = 100
         LET r_success = FALSE
         LET r_errno   = 'abg-00141'
      WHEN l_ooalstus <> 'Y' 
         LET r_success = FALSE
         LET r_errno   = 'abg-00142'
   END CASE
   
   RETURN r_success,r_errno
END FUNCTION

PRIVATE FUNCTION abgi070_02_glfa001004_chk(p_glfa001,p_glfa004)
   DEFINE p_glfa001   LIKE glfa_t.glfa001
   DEFINE p_glfa004   LIKE glfa_t.glfa004
   DEFINE r_success   LIKE type_t.num5
   DEFINE r_errno     LIKE gzze_t.gzze001
   DEFINE l_glfa004   LIKE glfa_t.glfa004
   DEFINE l_count     LIKE type_t.num10
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE   LET r_errno = NULL
   IF NOT cl_null(p_glfa001) AND NOT cl_null(p_glfa004)THEN
   ELSE
      RETURN r_success,r_errno
   END IF
   
   LET l_glfa004 = NULL
   SELECT glfa004 INTO l_glfa004 FROM glfa_t
    WHERE glfaent = g_enterprise
      AND glfa001 = p_glfa001
   
   LET l_count = NULL
   SELECT COUNT(*) INTO l_count FROM bgao_t
    WHERE bgaoent = g_enterprise
      AND bgao001 = p_glfa004
      AND bgao002 = l_glfa004
      AND bgaostus = 'Y'
   IF cl_null(l_count)THEN LET l_count = 0 END IF
   
   IF l_count = 0 THEN
      LET r_success = FALSE
      LET r_errno = 'abg-00140'
   END IF
   
   RETURN r_success,r_errno
END FUNCTION

PRIVATE FUNCTION abgi070_02_glfa001_carry()
   LET g_glfa_m.glfa001_desc = ''
   LET g_glfa_m.glfa004 = ''
   LET g_glfa_m.glfa002 = ''
   SELECT glfa004,glfa002 INTO g_glfa_m.glfa004,g_glfa_m.glfa002
     FROM glfa_t
    WHERE glfaent = g_enterprise
      AND glfa001 = g_glfa_m.glfa001
      
   LET g_glfa_m.glfa001_desc = NULL
   SELECT glfal003 INTO g_glfa_m.glfa001_desc
     FROM glfal_t
    WHERE glfalent = g_enterprise
      AND glfal001 = g_glfa_m.glfa001
      AND glfal002 = g_dlang
   LET g_glfa_m.l_glfa002_1 = g_glfa_m.glfa002
   DISPLAY BY NAME g_glfa_m.glfa001_desc,g_glfa_m.glfa002,g_glfa_m.glfa004,g_glfa_m.l_glfa002_1
END FUNCTION

PRIVATE FUNCTION abgi070_02_process()
  #DEFINE l_glfa RECORD LIKE glfa_t.*    #161104-00024#7 mark
  #DEFINE l_glfb RECORD LIKE glfb_t.*    #161104-00024#7 mark
  #DEFINE l_glfbl RECORD LIKE glfbl_t.*  #161104-00024#7 mark
   #161104-00024#7 --s add
   DEFINE l_glfa RECORD  #報表設定單頭檔
          glfaent LIKE glfa_t.glfaent, #企業編號
          glfa001 LIKE glfa_t.glfa001, #報表模板編號
          glfa002 LIKE glfa_t.glfa002, #報表類型
          glfa003 LIKE glfa_t.glfa003, #排列方式
          glfa004 LIKE glfa_t.glfa004, #科目參照表
          glfa005 LIKE glfa_t.glfa005, #測試帳套
          glfa006 LIKE glfa_t.glfa006, #測試年度
          glfa007 LIKE glfa_t.glfa007, #測試期別
          glfa008 LIKE glfa_t.glfa008, #測試金額單位
          glfa009 LIKE glfa_t.glfa009, #測試小數位數
          glfa010 LIKE glfa_t.glfa010, #本期年度
          glfa011 LIKE glfa_t.glfa011, #本期起始期別
          glfa012 LIKE glfa_t.glfa012, #本期截止期別
          glfa013 LIKE glfa_t.glfa013, #上期年度
          glfa014 LIKE glfa_t.glfa014, #上期起始期別
          glfa015 LIKE glfa_t.glfa015, #上期截止期別
          glfaownid LIKE glfa_t.glfaownid, #資料所有者
          glfaowndp LIKE glfa_t.glfaowndp, #資料所屬部門
          glfacrtid LIKE glfa_t.glfacrtid, #資料建立者
          glfacrtdp LIKE glfa_t.glfacrtdp, #資料建立部門
          glfacrtdt LIKE glfa_t.glfacrtdt, #資料創建日
          glfamodid LIKE glfa_t.glfamodid, #資料修改者
          glfamoddt LIKE glfa_t.glfamoddt, #最近修改日
          glfaud001 LIKE glfa_t.glfaud001, #自定義欄位(文字)001
          glfaud002 LIKE glfa_t.glfaud002, #自定義欄位(文字)002
          glfaud003 LIKE glfa_t.glfaud003, #自定義欄位(文字)003
          glfaud004 LIKE glfa_t.glfaud004, #自定義欄位(文字)004
          glfaud005 LIKE glfa_t.glfaud005, #自定義欄位(文字)005
          glfaud006 LIKE glfa_t.glfaud006, #自定義欄位(文字)006
          glfaud007 LIKE glfa_t.glfaud007, #自定義欄位(文字)007
          glfaud008 LIKE glfa_t.glfaud008, #自定義欄位(文字)008
          glfaud009 LIKE glfa_t.glfaud009, #自定義欄位(文字)009
          glfaud010 LIKE glfa_t.glfaud010, #自定義欄位(文字)010
          glfaud011 LIKE glfa_t.glfaud011, #自定義欄位(數字)011
          glfaud012 LIKE glfa_t.glfaud012, #自定義欄位(數字)012
          glfaud013 LIKE glfa_t.glfaud013, #自定義欄位(數字)013
          glfaud014 LIKE glfa_t.glfaud014, #自定義欄位(數字)014
          glfaud015 LIKE glfa_t.glfaud015, #自定義欄位(數字)015
          glfaud016 LIKE glfa_t.glfaud016, #自定義欄位(數字)016
          glfaud017 LIKE glfa_t.glfaud017, #自定義欄位(數字)017
          glfaud018 LIKE glfa_t.glfaud018, #自定義欄位(數字)018
          glfaud019 LIKE glfa_t.glfaud019, #自定義欄位(數字)019
          glfaud020 LIKE glfa_t.glfaud020, #自定義欄位(數字)020
          glfaud021 LIKE glfa_t.glfaud021, #自定義欄位(日期時間)021
          glfaud022 LIKE glfa_t.glfaud022, #自定義欄位(日期時間)022
          glfaud023 LIKE glfa_t.glfaud023, #自定義欄位(日期時間)023
          glfaud024 LIKE glfa_t.glfaud024, #自定義欄位(日期時間)024
          glfaud025 LIKE glfa_t.glfaud025, #自定義欄位(日期時間)025
          glfaud026 LIKE glfa_t.glfaud026, #自定義欄位(日期時間)026
          glfaud027 LIKE glfa_t.glfaud027, #自定義欄位(日期時間)027
          glfaud028 LIKE glfa_t.glfaud028, #自定義欄位(日期時間)028
          glfaud029 LIKE glfa_t.glfaud029, #自定義欄位(日期時間)029
          glfaud030 LIKE glfa_t.glfaud030,  #自定義欄位(日期時間)030
          glfa016 LIKE glfa_t.glfa016  #財報類型
   END RECORD
   
   DEFINE l_glfb RECORD  #表報設定單身檔
          glfbent LIKE glfb_t.glfbent, #企業編號
          glfb001 LIKE glfb_t.glfb001, #報表模板編號
          glfbseq LIKE glfb_t.glfbseq, #行次
          glfbseq1 LIKE glfb_t.glfbseq1, #列次
          glfb002 LIKE glfb_t.glfb002, #報表項目編號
          glfb003 LIKE glfb_t.glfb003, #報表行序
          glfb004 LIKE glfb_t.glfb004, #取數公式來源
          glfb005 LIKE glfb_t.glfb005, #數值取數公式
          glfb006 LIKE glfb_t.glfb006, #畫面上面的行
          glfb007 LIKE glfb_t.glfb007, #畫面上面的列
          glfbud001 LIKE glfb_t.glfbud001, #自定義欄位(文字)001
          glfbud002 LIKE glfb_t.glfbud002, #自定義欄位(文字)002
          glfbud003 LIKE glfb_t.glfbud003, #自定義欄位(文字)003
          glfbud004 LIKE glfb_t.glfbud004, #自定義欄位(文字)004
          glfbud005 LIKE glfb_t.glfbud005, #自定義欄位(文字)005
          glfbud006 LIKE glfb_t.glfbud006, #自定義欄位(文字)006
          glfbud007 LIKE glfb_t.glfbud007, #自定義欄位(文字)007
          glfbud008 LIKE glfb_t.glfbud008, #自定義欄位(文字)008
          glfbud009 LIKE glfb_t.glfbud009, #自定義欄位(文字)009
          glfbud010 LIKE glfb_t.glfbud010, #自定義欄位(文字)010
          glfbud011 LIKE glfb_t.glfbud011, #自定義欄位(數字)011
          glfbud012 LIKE glfb_t.glfbud012, #自定義欄位(數字)012
          glfbud013 LIKE glfb_t.glfbud013, #自定義欄位(數字)013
          glfbud014 LIKE glfb_t.glfbud014, #自定義欄位(數字)014
          glfbud015 LIKE glfb_t.glfbud015, #自定義欄位(數字)015
          glfbud016 LIKE glfb_t.glfbud016, #自定義欄位(數字)016
          glfbud017 LIKE glfb_t.glfbud017, #自定義欄位(數字)017
          glfbud018 LIKE glfb_t.glfbud018, #自定義欄位(數字)018
          glfbud019 LIKE glfb_t.glfbud019, #自定義欄位(數字)019
          glfbud020 LIKE glfb_t.glfbud020, #自定義欄位(數字)020
          glfbud021 LIKE glfb_t.glfbud021, #自定義欄位(日期時間)021
          glfbud022 LIKE glfb_t.glfbud022, #自定義欄位(日期時間)022
          glfbud023 LIKE glfb_t.glfbud023, #自定義欄位(日期時間)023
          glfbud024 LIKE glfb_t.glfbud024, #自定義欄位(日期時間)024
          glfbud025 LIKE glfb_t.glfbud025, #自定義欄位(日期時間)025
          glfbud026 LIKE glfb_t.glfbud026, #自定義欄位(日期時間)026
          glfbud027 LIKE glfb_t.glfbud027, #自定義欄位(日期時間)027
          glfbud028 LIKE glfb_t.glfbud028, #自定義欄位(日期時間)028
          glfbud029 LIKE glfb_t.glfbud029, #自定義欄位(日期時間)029
          glfbud030 LIKE glfb_t.glfbud030, #自定義欄位(日期時間)030
          glfb008 LIKE glfb_t.glfb008, #XBRL科目
          glfb009 LIKE glfb_t.glfb009, #百分比基準
          glfb010 LIKE glfb_t.glfb010, #呈現格式
          glfb011 LIKE glfb_t.glfb011, #公式屬性
          glfb012 LIKE glfb_t.glfb012  #計算年度
   END RECORD
   
   DEFINE l_glfbl RECORD  #表報設定單身檔多語言檔
          glfblent LIKE glfbl_t.glfblent, #企業編號
          glfbl001 LIKE glfbl_t.glfbl001, #報表模板編號
          glfblseq LIKE glfbl_t.glfblseq, #行次
          glfbl002 LIKE glfbl_t.glfbl002, #報表項目編號
          glfbl003 LIKE glfbl_t.glfbl003, #語言別
          glfbl004 LIKE glfbl_t.glfbl004, #說明
          glfbl005 LIKE glfbl_t.glfbl005  #助記碼
   END RECORD
   #161104-00024#7 --e add
   
   DEFINE l_sql  STRING
   DEFINE r_success LIKE type_t.num5
   DEFINE r_glfa001 LIKE glfa_t.glfa001
   DEFINE l_glfcar  DYNAMIC ARRAY OF RECORD
                       glfc001_o   LIKE glfc_t.glfc001,
                       glfc001_n   LIKE glfc_t.glfc001
                    END RECORD
  #DEFINE l_glfc RECORD LIKE glfc_t.*    #161104-00024#7 mark
   #161104-00024#7 --s add
   DEFINE l_glfc RECORD  #公式設定檔
          glfcent LIKE glfc_t.glfcent, #企業編號
          glfcownid LIKE glfc_t.glfcownid, #資料所有者
          glfcowndp LIKE glfc_t.glfcowndp, #資料所屬部門
          glfccrtid LIKE glfc_t.glfccrtid, #資料建立者
          glfccrtdp LIKE glfc_t.glfccrtdp, #資料建立部門
          glfccrtdt LIKE glfc_t.glfccrtdt, #資料創建日
          glfcmodid LIKE glfc_t.glfcmodid, #資料修改者
          glfcmoddt LIKE glfc_t.glfcmoddt, #最近修改日
          glfc001 LIKE glfc_t.glfc001, #公式編號
          glfcseq LIKE glfc_t.glfcseq, #項次
          glfc002 LIKE glfc_t.glfc002, #科目參照表
          glfc003 LIKE glfc_t.glfc003, #起始科目
          glfc004 LIKE glfc_t.glfc004, #截止科目
          glfc005 LIKE glfc_t.glfc005, #選用核算項
          glfc006 LIKE glfc_t.glfc006, #起始核算項值
          glfc007 LIKE glfc_t.glfc007, #截止核算項值
          glfc008 LIKE glfc_t.glfc008, #取值方式
          glfc009 LIKE glfc_t.glfc009, #運算方式
          glfc010 LIKE glfc_t.glfc010, #額外條件
          glfc011 LIKE glfc_t.glfc011, #左括號
          glfc012 LIKE glfc_t.glfc012, #右括號
          glfcud001 LIKE glfc_t.glfcud001, #自定義欄位(文字)001
          glfcud002 LIKE glfc_t.glfcud002, #自定義欄位(文字)002
          glfcud003 LIKE glfc_t.glfcud003, #自定義欄位(文字)003
          glfcud004 LIKE glfc_t.glfcud004, #自定義欄位(文字)004
          glfcud005 LIKE glfc_t.glfcud005, #自定義欄位(文字)005
          glfcud006 LIKE glfc_t.glfcud006, #自定義欄位(文字)006
          glfcud007 LIKE glfc_t.glfcud007, #自定義欄位(文字)007
          glfcud008 LIKE glfc_t.glfcud008, #自定義欄位(文字)008
          glfcud009 LIKE glfc_t.glfcud009, #自定義欄位(文字)009
          glfcud010 LIKE glfc_t.glfcud010, #自定義欄位(文字)010
          glfcud011 LIKE glfc_t.glfcud011, #自定義欄位(數字)011
          glfcud012 LIKE glfc_t.glfcud012, #自定義欄位(數字)012
          glfcud013 LIKE glfc_t.glfcud013, #自定義欄位(數字)013
          glfcud014 LIKE glfc_t.glfcud014, #自定義欄位(數字)014
          glfcud015 LIKE glfc_t.glfcud015, #自定義欄位(數字)015
          glfcud016 LIKE glfc_t.glfcud016, #自定義欄位(數字)016
          glfcud017 LIKE glfc_t.glfcud017, #自定義欄位(數字)017
          glfcud018 LIKE glfc_t.glfcud018, #自定義欄位(數字)018
          glfcud019 LIKE glfc_t.glfcud019, #自定義欄位(數字)019
          glfcud020 LIKE glfc_t.glfcud020, #自定義欄位(數字)020
          glfcud021 LIKE glfc_t.glfcud021, #自定義欄位(日期時間)021
          glfcud022 LIKE glfc_t.glfcud022, #自定義欄位(日期時間)022
          glfcud023 LIKE glfc_t.glfcud023, #自定義欄位(日期時間)023
          glfcud024 LIKE glfc_t.glfcud024, #自定義欄位(日期時間)024
          glfcud025 LIKE glfc_t.glfcud025, #自定義欄位(日期時間)025
          glfcud026 LIKE glfc_t.glfcud026, #自定義欄位(日期時間)026
          glfcud027 LIKE glfc_t.glfcud027, #自定義欄位(日期時間)027
          glfcud028 LIKE glfc_t.glfcud028, #自定義欄位(日期時間)028
          glfcud029 LIKE glfc_t.glfcud029, #自定義欄位(日期時間)029
          glfcud030 LIKE glfc_t.glfcud030, #自定義欄位(日期時間)030
          glfc013 LIKE glfc_t.glfc013  #數據來源
   END RECORD
   #161104-00024#7 --e add
   DEFINE l_glfc001_n   LIKE glfc_t.glfc001 #新號碼
   DEFINE l_glfc001_nn  LIKE type_t.num10   #數字部分
   DEFINE l_i           LIKE type_t.num10
   DEFINE l_glfc001_o   LIKE glfc_t.glfc001
   DEFINE l_bggo003     LIKE bggo_t.bggo003 #161222-00005#4
   #161226-00002#5 ---s---
   DEFINE l_glfcl002    LIKE glfcl_t.glfcl002
   DEFINE l_glfcl003    LIKE glfcl_t.glfcl003
   DEFINE l_glfcl004    LIKE glfcl_t.glfcl004
   #161226-00002#5 ---e---
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   LET r_glfa001 = NULL
   #160713----------------------------s
   #1 複製glfa  glfb 僅變更KEY及畫面欄位
   #160713----------------------------e
   
   INITIALIZE l_glfa.* TO NULL
   SELECT * INTO l_glfa.* 
     FROM glfa_t
    WHERE glfaent = g_enterprise
      AND glfa001 = g_glfa_m.glfa001
      
   LET l_glfa.glfa001 = g_glfa_m.l_glfa001_1   #目的報表模板編號
   LET l_glfa.glfa016 = '3'                    #目的樣表類型(預算)
   LET l_glfa.glfa002 = g_glfa_m.l_glfa002_1
   LET l_glfa.glfa004 = g_glfa_m.l_glfa004_1
   #INSERT INTO glfa_t VALUES(l_glfa.*)   #161108-00017#5   mark
   #161108-00017#5   add---s
   INSERT INTO glfa_t (glfaent,glfa001,glfa002,glfa003,glfa004,
                       glfa005,glfa006,glfa007,glfa008,glfa009,
                       glfa010,glfa011,glfa012,glfa013,glfa014,
                       glfa015,glfaownid,glfaowndp,glfacrtid,glfacrtdp,
                       glfacrtdt,glfamodid,glfamoddt,glfaud001,glfaud002,
                       glfaud003,glfaud004,glfaud005,glfaud006,glfaud007,
                       glfaud008,glfaud009,glfaud010,glfaud011,glfaud012,
                       glfaud013,glfaud014,glfaud015,glfaud016,glfaud017,
                       glfaud018,glfaud019,glfaud020,glfaud021,glfaud022,
                       glfaud023,glfaud024,glfaud025,glfaud026,glfaud027,
                       glfaud028,glfaud029,glfaud030,glfa016)
               VALUES (l_glfa.glfaent,l_glfa.glfa001,l_glfa.glfa002,l_glfa.glfa003,l_glfa.glfa004,
                       l_glfa.glfa005,l_glfa.glfa006,l_glfa.glfa007,l_glfa.glfa008,l_glfa.glfa009,
                       l_glfa.glfa010,l_glfa.glfa011,l_glfa.glfa012,l_glfa.glfa013,l_glfa.glfa014,
                       l_glfa.glfa015,l_glfa.glfaownid,l_glfa.glfaowndp,l_glfa.glfacrtid,l_glfa.glfacrtdp,
                       l_glfa.glfacrtdt,l_glfa.glfamodid,l_glfa.glfamoddt,l_glfa.glfaud001,l_glfa.glfaud002,
                       l_glfa.glfaud003,l_glfa.glfaud004,l_glfa.glfaud005,l_glfa.glfaud006,l_glfa.glfaud007,
                       l_glfa.glfaud008,l_glfa.glfaud009,l_glfa.glfaud010,l_glfa.glfaud011,l_glfa.glfaud012,
                       l_glfa.glfaud013,l_glfa.glfaud014,l_glfa.glfaud015,l_glfa.glfaud016,l_glfa.glfaud017,
                       l_glfa.glfaud018,l_glfa.glfaud019,l_glfa.glfaud020,l_glfa.glfaud021,l_glfa.glfaud022,
                       l_glfa.glfaud023,l_glfa.glfaud024,l_glfa.glfaud025,l_glfa.glfaud026,l_glfa.glfaud027,
                       l_glfa.glfaud028,l_glfa.glfaud029,l_glfa.glfaud030,l_glfa.glfa016)
   #161108-00017#5   add---e
   IF SQLCA.SQLCODE THEN 
      INITIALIZE g_errparam.* TO NULL
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.extend = 'abgi070_02_process:INSERT glfa'
      CALL cl_err()
      LET r_success = FALSE
   END IF
   
   LET l_sql = "SELECT * FROM glfb_t ",
               " WHERE glfbent = ",g_enterprise," ",
               "   AND glfb001 = '",g_glfa_m.glfa001,"' "
   PREPARE sel_glfbop1 FROM l_sql
   DECLARE sel_glfboc1 CURSOR FOR sel_glfbop1
   
   FOREACH sel_glfboc1 INTO l_glfb.*
      IF SQLCA.SQLCODE THEN EXIT FOREACH END IF
      
      LET l_glfb.glfb001 = g_glfa_m.l_glfa001_1
      #INSERT INTO glfb_t VALUES(l_glfb.*)   #161108-00017#   mark
      #161108-00017#   add---s
      INSERT INTO glfb_t (glfbent,glfb001,glfbseq,glfbseq1,glfb002,
                          glfb003,glfb004,glfb005,glfb006,glfb007,
                          glfbud001,glfbud002,glfbud003,glfbud004,glfbud005,
                          glfbud006,glfbud007,glfbud008,glfbud009,glfbud010,
                          glfbud011,glfbud012,glfbud013,glfbud014,glfbud015,
                          glfbud016,glfbud017,glfbud018,glfbud019,glfbud020,
                          glfbud021,glfbud022,glfbud023,glfbud024,glfbud025,
                          glfbud026,glfbud027,glfbud028,glfbud029,glfbud030,
                          glfb008,glfb009,glfb010,glfb011,glfb012)
                  VALUES (l_glfb.glfbent,l_glfb.glfb001,l_glfb.glfbseq,l_glfb.glfbseq1,l_glfb.glfb002,
                          l_glfb.glfb003,l_glfb.glfb004,l_glfb.glfb005,l_glfb.glfb006,l_glfb.glfb007,
                          l_glfb.glfbud001,l_glfb.glfbud002,l_glfb.glfbud003,l_glfb.glfbud004,l_glfb.glfbud005,
                          l_glfb.glfbud006,l_glfb.glfbud007,l_glfb.glfbud008,l_glfb.glfbud009,l_glfb.glfbud010,
                          l_glfb.glfbud011,l_glfb.glfbud012,l_glfb.glfbud013,l_glfb.glfbud014,l_glfb.glfbud015,
                          l_glfb.glfbud016,l_glfb.glfbud017,l_glfb.glfbud018,l_glfb.glfbud019,l_glfb.glfbud020,
                          l_glfb.glfbud021,l_glfb.glfbud022,l_glfb.glfbud023,l_glfb.glfbud024,l_glfb.glfbud025,
                          l_glfb.glfbud026,l_glfb.glfbud027,l_glfb.glfbud028,l_glfb.glfbud029,l_glfb.glfbud030,
                          l_glfb.glfb008,l_glfb.glfb009,l_glfb.glfb010,l_glfb.glfb011,l_glfb.glfb012)
      #161108-00017#   add---e
      IF SQLCA.SQLCODE THEN 
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = 'abgi070_02_process:INSERT glfb'
         CALL cl_err()
         LET r_success = FALSE
      END IF
   END FOREACH
   
   LET l_sql = "SELECT * FROM glfbl_t ",
               " WHERE glfblent = ",g_enterprise," ",
               "   AND glfbl001 = '",g_glfa_m.glfa001,"' "
   PREPARE sel_glfblop1 FROM l_sql
   DECLARE sel_glfbloc1 CURSOR FOR sel_glfblop1
   
   FOREACH sel_glfbloc1 INTO l_glfbl.*
      IF SQLCA.SQLCODE THEN EXIT FOREACH END IF
      
      LET l_glfbl.glfbl001 = g_glfa_m.l_glfa001_1
      #INSERT INTO glfbl_t VALUES(l_glfbl.*)   #161108-00017#5   mark
      #161108-00017#5   add---s
      INSERT INTO glfbl_t (glfblent,glfbl001,glfblseq,glfbl002,glfbl003,
                           glfbl004,glfbl005)
                   VALUES (l_glfbl.glfblent,l_glfbl.glfbl001,l_glfbl.glfblseq,l_glfbl.glfbl002,l_glfbl.glfbl003,
                           l_glfbl.glfbl004,l_glfbl.glfbl005)
      #161108-00017#5   add---s
      IF SQLCA.SQLCODE THEN 
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = 'abgi070_02_process:INSERT glfbl'
         CALL cl_err()
         LET r_success = FALSE
      END IF
   END FOREACH
   
   #kris:多語言僅以目前語言別新增         
   INSERT INTO glfal_t(glfalent,glfal001,glfal002,glfal003)
    VALUES(g_enterprise,g_glfa_m.l_glfa001_1,g_dlang,g_glfa_m.l_glfa001_1_desc)
   IF SQLCA.SQLCODE THEN 
      INITIALIZE g_errparam.* TO NULL
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.extend = 'abgi070_02_process:INSERT glfal_t'
      CALL cl_err()
      LET r_success = FALSE
   END IF   
   
   #161226-00002#5---s---
   LET l_sql = " SELECT glfcl002,glfcl003,glfcl004     ",
               "   FROM glfcl_t                        ",
               "   WHERE glfclent = ",g_enterprise," AND glfcl001 =  ?  "
   PREPARE abgi070_glfcl003_p FROM l_sql
   DECLARE abgi070_glfcl003_c CURSOR FOR abgi070_glfcl003_p
   #161226-00002#5 ---e---      
   
   #160713----------------------------s
   #2 把單身屬於取數公式來源2類的distinct取出後存放到array中
   #先處理好glfc
   #160713----------------------------e
   LET l_sql = "SELECT DISTINCT glfb005 FROM glfb_t ",
               " WHERE glfbent = ",g_enterprise, " ",
               "   AND glfb001 = '",g_glfa_m.glfa001,"' " 
  #             "   AND glfb004 = '2' "                    #161222-00005#4  ---mark
   PREPARE sel_glfbnp1 FROM l_sql
   DECLARE sel_glfbnc1 CURSOR FOR sel_glfbnp1
   
   LET l_sql = "SELECT * FROM glfc_t ",
               " WHERE glfcent = ",g_enterprise," ",
               "   AND glfc001 = ? "
   PREPARE sel_glfcop1 FROM l_sql
   DECLARE sel_glfcoc1 CURSOR FOR sel_glfcop1
   
   LET l_i = 1
   CALL l_glfcar.clear()
   FOREACH sel_glfbnc1 INTO l_glfcar[l_i].glfc001_o
      IF SQLCA.SQLCODE THEN EXIT FOREACH END IF
      LET l_sql = l_glfcar[l_i].glfc001_o
      LET l_sql = l_sql.trim()
      LET l_glfc001_o = l_sql CLIPPED
      
      #重新取號SYS'7碼流水'
      LET l_glfc001_n = NULL
      SELECT MAX(glfc001) INTO l_glfc001_n FROM glfc_t
       WHERE glfcent = g_enterprise
         AND glfc001 LIKE 'SYS%%%%%%%'
       
      #取號邏輯+1
      IF NOT cl_null(l_glfc001_n)THEN
         LET l_glfc001_nn = l_glfc001_n[4,10]
         LET l_glfc001_nn = l_glfc001_nn + 1
         LET l_glfc001_n = 'SYS',l_glfc001_nn USING '&&&&&&&'
      END IF
      IF cl_null(l_glfc001_n)THEN LET l_glfc001_n = 'SYS0000001' END IF
      LET l_glfcar[l_i].glfc001_n = l_glfc001_n
      
      FOREACH sel_glfcoc1 USING l_glfc001_o
         INTO l_glfc.*
         IF SQLCA.SQLCODE THEN EXIT FOREACH END IF
         LET l_glfc.glfc001 = l_glfc001_n
         #LET l_glfc.glfc008 = '7' #161222-00005#4  mark
         LET l_glfc.glfc013 = '4'
         LET l_glfc.glfc002 = g_glfa_m.l_glfa004_1
         
         #需做起訖科目置換成起訖項目
         LET l_bggo003 = l_glfc.glfc003 #161222-00005#4 add
         CALL s_abgq053_get_bgao004(g_glfa_m.l_glfa004_1,g_glfa_m.glfa004,l_glfc.glfc003)RETURNING g_sub_success,l_glfc.glfc003
         #161222-00005#4 ---s---
         #IF NOT g_sub_success THEN
         #   INITIALIZE g_errparam.* TO NULL
         #   LET g_errparam.code = ''
         #   LET g_errparam.extend = 'abgi070_02_process:get glfc003'
         #   CALL cl_err()
         #   LET r_success = FALSE            
         #END IF
         IF cl_null(l_glfc.glfc003) THEN LET l_glfc.glfc003 = l_bggo003 END IF
         #161222-00005#4 ---e---
         LET l_bggo003 = l_glfc.glfc004 #161222-00005#4 add
         CALL s_abgq053_get_bgao004(g_glfa_m.l_glfa004_1,g_glfa_m.glfa004,l_glfc.glfc004)RETURNING g_sub_success,l_glfc.glfc004
          #161222-00005#4 ---s---
         #IF NOT g_sub_success THEN
         #   INITIALIZE g_errparam.* TO NULL
         #   LET g_errparam.code = ''
         #   LET g_errparam.extend = 'abgi070_02_process:get glfc004'
         #   CALL cl_err()
         #   LET r_success = FALSE            
         #END IF
         IF cl_null(l_glfc.glfc004) THEN LET l_glfc.glfc004 = l_bggo003 END IF
         #161222-00005#4 ---e---
         #INSERT INTO glfc_t VALUES(l_glfc.*)   #161108-00017#5   mark
         #161108-00017#5   add---s
         INSERT INTO glfc_t (glfcent,glfcownid,glfcowndp,glfccrtid,glfccrtdp,
                             glfccrtdt,glfcmodid,glfcmoddt,glfc001,glfcseq,
                             glfc002,glfc003,glfc004,glfc005,glfc006,
                             glfc007,glfc008,glfc009,glfc010,glfc011,
                             glfc012,glfcud001,glfcud002,glfcud003,glfcud004,
                             glfcud005,glfcud006,glfcud007,glfcud008,glfcud009,
                             glfcud010,glfcud011,glfcud012,glfcud013,glfcud014,
                             glfcud015,glfcud016,glfcud017,glfcud018,glfcud019,
                             glfcud020,glfcud021,glfcud022,glfcud023,glfcud024,
                             glfcud025,glfcud026,glfcud027,glfcud028,glfcud029,
                             glfcud030,glfc013)
                     VALUES (l_glfc.glfcent,l_glfc.glfcownid,l_glfc.glfcowndp,l_glfc.glfccrtid,l_glfc.glfccrtdp,
                             l_glfc.glfccrtdt,l_glfc.glfcmodid,l_glfc.glfcmoddt,l_glfc.glfc001,l_glfc.glfcseq,
                             l_glfc.glfc002,l_glfc.glfc003,l_glfc.glfc004,l_glfc.glfc005,l_glfc.glfc006,
                             l_glfc.glfc007,l_glfc.glfc008,l_glfc.glfc009,l_glfc.glfc010,l_glfc.glfc011,
                             l_glfc.glfc012,l_glfc.glfcud001,l_glfc.glfcud002,l_glfc.glfcud003,l_glfc.glfcud004,
                             l_glfc.glfcud005,l_glfc.glfcud006,l_glfc.glfcud007,l_glfc.glfcud008,l_glfc.glfcud009,
                             l_glfc.glfcud010,l_glfc.glfcud011,l_glfc.glfcud012,l_glfc.glfcud013,l_glfc.glfcud014,
                             l_glfc.glfcud015,l_glfc.glfcud016,l_glfc.glfcud017,l_glfc.glfcud018,l_glfc.glfcud019,
                             l_glfc.glfcud020,l_glfc.glfcud021,l_glfc.glfcud022,l_glfc.glfcud023,l_glfc.glfcud024,
                             l_glfc.glfcud025,l_glfc.glfcud026,l_glfc.glfcud027,l_glfc.glfcud028,l_glfc.glfcud029,
                             l_glfc.glfcud030,l_glfc.glfc013)
         #161108-00017#5   add---e
         IF SQLCA.SQLCODE THEN 
            INITIALIZE g_errparam.* TO NULL
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.extend = 'abgi070_02_process:INSERT glfc_t'
            CALL cl_err()
            LET r_success = FALSE
         END IF          
         #161226-00002#5---s---
         FOREACH abgi070_glfcl003_c USING l_glfc001_o INTO l_glfcl002,l_glfcl003,l_glfcl004
            INSERT INTO glfcl_t
                        (glfclent,glfcl001,glfcl002,glfcl003,glfcl004)
                 VALUES (g_enterprise,l_glfc.glfc001,l_glfcl002,l_glfcl003,l_glfcl004)
         END FOREACH
         #161226-00002#5 ---e---        
      END FOREACH
      
      LET l_i = l_i + 1
   END FOREACH
   
   #回寫新單abgi070中單身的舊換新
   FOR l_i = 1 TO l_glfcar.getLength()
      UPDATE glfb_t SET glfb005 =  l_glfcar[l_i].glfc001_n
       WHERE glfbent = g_enterprise
         AND glfb001 = l_glfa.glfa001
         AND glfb005 =  l_glfcar[l_i].glfc001_o
         AND glfb004 <> '1' #161222-00005#4 
      IF SQLCA.SQLCODE THEN 
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = 'abgi070_02_process:INSERT glfb_t'
         CALL cl_err()
         LET r_success = FALSE
      END IF   
   END FOR
  
   
   IF r_success THEN
      LET r_glfa001 = l_glfa.glfa001
   END IF
   RETURN r_success,r_glfa001
END FUNCTION

 
{</section>}
 
