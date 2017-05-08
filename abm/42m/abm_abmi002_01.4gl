#該程式未解開Section, 採用最新樣板產出!
{<section id="abmi002_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2016-07-26 17:46:25), PR版次:0004(2016-11-11 16:41:49)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000218
#+ Filename...: abmi002_01
#+ Description: BOM公式驗證
#+ Creator....: 02294(2013-08-27 12:40:16)
#+ Modifier...: 02295 -SD/PR- 02295
 
{</section>}
 
{<section id="abmi002_01.global" >}
#應用 c02b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#150902-00006#1 2016/02/25 by xujing 公式测试时，要能够解析出文字类型的变数
#150624-00013#1 2016/07/21 By xianghui 公式验证，需要解析出嵌套公式的值
#160901-00032#1 2016/11/11 By 02295  解析公式写法优化
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
PRIVATE TYPE type_g_bmzf_d        RECORD
       bmzf001 LIKE bmzf_t.bmzf001, 
   bmzf002 LIKE bmzf_t.bmzf002, 
   bmzf003 LIKE bmzf_t.bmzf003, 
   bmzf008 LIKE type_t.chr500
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 
#end add-point
 
DEFINE g_bmzf_d          DYNAMIC ARRAY OF type_g_bmzf_d
DEFINE g_bmzf_d_t        type_g_bmzf_d
 
 
DEFINE g_bmzf001_t   LIKE bmzf_t.bmzf001    #Key值備份
DEFINE g_bmzf002_t      LIKE bmzf_t.bmzf002    #Key值備份
 
 
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
 
{<section id="abmi002_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION abmi002_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_bmze001
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
   DEFINE p_bmze001       LIKE bmze_t.bmze001
   DEFINE l_forupd_sql    STRING
   DEFINE l_sql           STRING
   DEFINE l_bmze003_desc1 LIKE type_t.chr80
   DEFINE l_bmze003       LIKE bmze_t.bmze003
   DEFINE l_result        LIKE type_t.chr80
   DEFINE l_n             LIKE type_t.num5
   DEFINE l_bmze003_desc  STRING  #150624-00013#1
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_abmi002_01 WITH FORM cl_ap_formpath("abm","abmi002_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單身前置處理 name="input.pre_input"
  
   WHENEVER ERROR CONTINUE
   
   CREATE TEMP TABLE abmi002_01_tmp
   (
     bmzf001     VARCHAR(10),
     bmzf002    DECIMAL(10,0),
     bmzf003    VARCHAR(80),
     bmzf008    VARCHAR(80)
   );
   
   #150624-00013#1---mark---s
   #LET l_sql = " INSERT INTO abmi002_01_tmp (SELECT bmzf002,bmzf003,'' FROM bmzf_t WHERE bmzfent = '",g_enterprise,"' AND bmzf001 = '",p_bmze001,"' )"
   #PREPARE abmi002_01_tmp FROM l_sql
   #EXECUTE abmi002_01_tmp
   #150624-00013#1---mark---e
   
   CALL abmi002_01_get_bmze003_desc(p_bmze001,'Y') RETURNING l_bmze003_desc    #150624-00013#1
   DISPLAY l_bmze003_desc TO bmze003_desc                                  #150624-00013#1
   
   CALL abmi002_01_show(p_bmze001)   
   
   LET l_ac = 1
   LET l_allow_insert = FALSE
   LET l_allow_delete = FALSE
   
   LET l_forupd_sql = "SELECT bmzf001,bmzf002,bmzf003,'' FROM bmzf_t WHERE bmzfent = ? AND bmzf001 = ? FOR UPDATE"
   LET l_forupd_sql = cl_sql_forupd(l_forupd_sql)
   DECLARE abmi002_01_bcl CURSOR FROM l_forupd_sql
   
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT ARRAY g_bmzf_d FROM s_detail1.*
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
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            DISPLAY g_detail_idx TO FORMONLY.idx
            
            CALL s_transaction_begin()
            OPEN abmi002_01_bcl USING g_enterprise,p_bmze001
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "abmi002_01_bcl"
               LET g_errparam.popup = TRUE
               CALL cl_err()

            ELSE
               FETCH abmi002_01_bcl INTO g_bmzf_d[l_ac].*
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = p_bmze001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

               END IF
               
               CALL abmi002_01_show(p_bmze001)
               LET g_bmzf_d_t.* = g_bmzf_d[l_ac].*
               
               DISPLAY BY NAME g_bmzf_d[l_ac].bmzf001,g_bmzf_d[l_ac].bmzf002,g_bmzf_d[l_ac].bmzf003,g_bmzf_d[l_ac].bmzf008
            END IF
            
          ON ROW CHANGE
             CALL s_transaction_begin()
             UPDATE abmi002_01_tmp SET bmzf008 = g_bmzf_d[l_ac].bmzf008
               WHERE bmzf002 = g_bmzf_d[l_ac].bmzf002
                 AND bmzf001 = g_bmzf_d[l_ac].bmzf001  #150624-00013#1
             IF SQLCA.SQLcode  THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = SQLCA.sqlcode
                LET g_errparam.extend = "abmi002_01_tmp"
                LET g_errparam.popup = TRUE
                CALL cl_err()

                CALL s_transaction_end('N','0')
             ELSE
                CALL s_transaction_end('Y','0')
             END IF
             #SELECT bmze003 INTO l_bmze003 FROM bmze_t WHERE bmzeent = g_enterprise AND bmze001 = p_bmze001
             #CALL abmi002_01_bmze003_ref1(p_bmze001,l_bmze003) RETURNING l_bmze003_desc1
             #DISPLAY l_bmze003_desc1 TO bmze003_desc1
             
          ON ACTION compute
             #150902-00006#1 mark start
#             IF NOT abmi002_01_bmzf008_chk(g_bmzf_d[l_ac].bmzf008) THEN
#                LET g_bmzf_d[l_ac].bmzf008 = g_bmzf_d_t.bmzf008
#                NEXT FIELD CURRENT
#             END IF
             #150902-00006#1 mark end
             CALL s_transaction_begin()
             UPDATE abmi002_01_tmp SET bmzf008 = g_bmzf_d[l_ac].bmzf008
               WHERE bmzf002 = g_bmzf_d[l_ac].bmzf002
                 AND bmzf001 = g_bmzf_d[l_ac].bmzf001  #150624-00013#1
             IF SQLCA.SQLcode  THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = SQLCA.sqlcode
                LET g_errparam.extend = "abmi002_01_tmp"
                LET g_errparam.popup = TRUE
                CALL cl_err()

                CALL s_transaction_end('N','0')
             ELSE
                CALL s_transaction_end('Y','0')
             END IF
             
             #單身值欄位必須全部輸入數值
             LET l_n = 0
             SELECT COUNT(*) INTO l_n FROM abmi002_01_tmp WHERE bmzf008 IS NULL
             IF l_n > 0 THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'abm-00005'
                LET g_errparam.extend = ''
                LET g_errparam.popup = FALSE
                CALL cl_err()

                NEXT FIELD CURRENT
             END IF
             #150624-00013#1---mark---s
             #SELECT bmze003 INTO l_bmze003 FROM bmze_t WHERE bmzeent = g_enterprise AND bmze001 = p_bmze001
             #CALL abmi002_01_bmze003_ref1(p_bmze001,l_bmze003) RETURNING l_bmze003_desc1
             #150624-00013#1---mark---s
             CALL abmi002_01_get_bmze003(p_bmze001) RETURNING l_bmze003_desc1    #150624-00013#1
             DISPLAY l_bmze003_desc1 TO bmze003_desc1
             
             LET l_sql = "SELECT ROUND(",l_bmze003_desc1,",6) FROM dual"
             PREPARE bmze003_pre FROM l_sql
             EXECUTE bmze003_pre INTO l_result
             IF SQLCA.sqlcode THEN 
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'abm-00004'
                LET g_errparam.extend = l_bmze003_desc1
                LET g_errparam.popup = FALSE
                CALL cl_err()

                LET l_result = ''
              
             END IF
             DISPLAY l_result TO result  

            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmzf001
            #add-point:BEFORE FIELD bmzf001 name="input.b.page1.bmzf001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmzf001
            
            #add-point:AFTER FIELD bmzf001 name="input.a.page1.bmzf001"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_bmzf_d[l_ac].bmzf001) AND NOT cl_null(g_bmzf_d[l_ac].bmzf002) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_bmzf_d[l_ac].bmzf001 != g_bmzf_d_t.bmzf001 OR g_bmzf_d[l_ac].bmzf002 != g_bmzf_d_t.bmzf002))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bmzf_t WHERE "||"bmzfent = '" ||g_enterprise|| "' AND "||"bmzf001 = '"||g_bmzf_d[l_ac].bmzf001 ||"' AND "|| "bmzf002 = '"||g_bmzf_d[l_ac].bmzf002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmzf001
            #add-point:ON CHANGE bmzf001 name="input.g.page1.bmzf001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmzf002
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_bmzf_d[l_ac].bmzf002,"1.000","1","","","azz-00079",1) THEN
               NEXT FIELD bmzf002
            END IF 
 
 
 
            #add-point:AFTER FIELD bmzf002 name="input.a.page1.bmzf002"
            IF NOT cl_null(g_bmzf_d[l_ac].bmzf002) THEN 
            END IF 

            #此段落由子樣板a05產生
            IF  NOT cl_null(g_bmzf_d[l_ac].bmzf001) AND NOT cl_null(g_bmzf_d[l_ac].bmzf002) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_bmzf_d[l_ac].bmzf001 != g_bmzf_d_t.bmzf001 OR g_bmzf_d[l_ac].bmzf002 != g_bmzf_d_t.bmzf002))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bmzf_t WHERE "||"bmzfent = '" ||g_enterprise|| "' AND "||"bmzf001 = '"||g_bmzf_d[l_ac].bmzf001 ||"' AND "|| "bmzf002 = '"||g_bmzf_d[l_ac].bmzf002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmzf002
            #add-point:BEFORE FIELD bmzf002 name="input.b.page1.bmzf002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmzf002
            #add-point:ON CHANGE bmzf002 name="input.g.page1.bmzf002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmzf003
            #add-point:BEFORE FIELD bmzf003 name="input.b.page1.bmzf003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmzf003
            
            #add-point:AFTER FIELD bmzf003 name="input.a.page1.bmzf003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmzf003
            #add-point:ON CHANGE bmzf003 name="input.g.page1.bmzf003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmzf008
            #add-point:BEFORE FIELD bmzf008 name="input.b.page1.bmzf008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmzf008
            
            #add-point:AFTER FIELD bmzf008 name="input.a.page1.bmzf008"
            #IF NOT cl_null(g_bmzf_d[l_ac].bmzf008) THEN
            #   CALL abmi002_01_set_format(g_bmzf_d[l_ac].bmzf008) RETURNING g_bmzf_d[l_ac].bmzf008
            #   DISPLAY BY NAME g_bmzf_d[l_ac].bmzf008               
            #END IF 
            #150902-00006#1 mark start
#            IF NOT abmi002_01_bmzf008_chk(g_bmzf_d[l_ac].bmzf008) THEN
#               LET g_bmzf_d[l_ac].bmzf008 = g_bmzf_d_t.bmzf008
#               NEXT FIELD CURRENT
#            END IF
            #150902-00006#1 mark end
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmzf008
            #add-point:ON CHANGE bmzf008 name="input.g.page1.bmzf008"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.bmzf001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmzf001
            #add-point:ON ACTION controlp INFIELD bmzf001 name="input.c.page1.bmzf001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bmzf002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmzf002
            #add-point:ON ACTION controlp INFIELD bmzf002 name="input.c.page1.bmzf002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bmzf003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmzf003
            #add-point:ON ACTION controlp INFIELD bmzf003 name="input.c.page1.bmzf003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bmzf008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmzf008
            #add-point:ON ACTION controlp INFIELD bmzf008 name="input.c.page1.bmzf008"
            
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
   LET INT_FLAG = FALSE
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_abmi002_01 
   
   #add-point:input段after input name="input.post_input"
   DROP TABLE abmi002_01_tmp

   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="abmi002_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="abmi002_01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 取得公式说明，并将每个公式的资料insert到临时表
# Memo...........:
# Usage..........: CALL abmi002_01_get_bmze003_desc(p_bmze001)
#                  RETURNING r_bmze003
# Input parameter: p_bmze001   公式编号
#                : p_type      Y/N 是否给临时表插入数据
# Return code....: r_bmze003_desc 公式说明
# Date & Author..: 2016/07/26 By xianghui
# Modify.........: #150624-00013#1
################################################################################
PUBLIC FUNCTION abmi002_01_get_bmze003_desc(p_bmze001,p_type)
DEFINE p_bmze001       LIKE bmze_t.bmze001
DEFINE p_type          LIKE type_t.chr1
DEFINE bst             base.StringTokenizer
DEFINE l_index         LIKE type_t.num5
DEFINE l_index2        LIKE type_t.num5
DEFINE l_bmze003_desc  STRING
DEFINE l_bmze003_str   STRING
DEFINE l_bmzf003       LIKE bmzf_t.bmzf003
DEFINE l_bmzf002       LIKE bmzf_t.bmzf002
DEFINE l_bmze001       LIKE bmze_t.bmze001
DEFINE l_bmze003_1     LIKE bmze_t.bmze003
DEFINE l_bmze003       STRING
DEFINE l_sql           STRING
DEFINE r_bmze003_desc  STRING


   LET r_bmze003_desc = ''
   
   IF p_type = 'Y' THEN 
      #抓取所有的参数项次Insert到临时表中供输入值
      LET l_sql = " INSERT INTO abmi002_01_tmp (SELECT bmzf001,bmzf002,bmzf003,'' FROM bmzf_t WHERE bmzfent = '",g_enterprise,"' AND bmzf001 = '",p_bmze001,"' )"
      PREPARE abmi002_01_tmp FROM l_sql
      EXECUTE abmi002_01_tmp
      FREE abmi002_01_tmp 
   END IF
   #抓取公式编号对应的公式
   SELECT bmze003 INTO l_bmze003_1
     FROM bmze_t
    WHERE bmzeent = g_enterprise
      AND bmze001 = p_bmze001
   IF SQLCA.sqlcode THEN 
      RETURN r_bmze003_desc
   END IF
   LET l_bmze003 = l_bmze003_1
   CALL abmi002_01_replace_desc(p_bmze001,l_bmze003_1,p_type) RETURNING r_bmze003_desc   #160901-00032#1 add
#160901-00032#1---mark---s
#   #将$$参数全部替换成说明文字
#   LET l_index = 1
#   LET l_bmze003_desc = ''
#   LET l_index2 = l_bmze003.getIndexOf('$',1)
#   LET bst= base.StringTokenizer.create(l_bmze003,'$')
#   IF l_index2 = 1 THEN
#      WHILE bst.hasMoreTokens()
#         IF l_index = 2 THEN
#            LET l_bmze003_str = bst.nextToken()
#            LET l_bmze003_desc = l_bmze003_desc,l_bmze003_str
#            LET l_index = 1
#         ELSE 
#            LET l_bmzf002 = bst.nextToken()
#            SELECT bmzf003 INTO l_bmzf003 FROM bmzf_t WHERE bmzfent = g_enterprise AND bmzf001 = p_bmze001 AND bmzf002 = l_bmzf002
#            LET l_bmze003_desc = l_bmze003_desc,l_bmzf003
#            LET l_index = l_index + 1
#         END IF
#      END WHILE     
#   ELSE
#      WHILE bst.hasMoreTokens()
#         IF l_index = 2 THEN
#            LET l_bmzf002 = bst.nextToken()
#            SELECT bmzf003 INTO l_bmzf003 FROM bmzf_t WHERE bmzfent = g_enterprise AND bmzf001 = p_bmze001 AND bmzf002 = l_bmzf002
#            LET l_bmze003_desc = l_bmze003_desc,l_bmzf003
#            LET l_index = 1
#         ELSE 
#            LET l_bmze003_str = bst.nextToken()
#            LET l_bmze003_desc = l_bmze003_desc,l_bmze003_str
#            LET l_index = l_index + 1
#         END IF
#      END WHILE
#   END IF
#   
#   #以后处理后得出的公式说明只剩##的没有处理，下面将对##的做处理
#   #将##参数全部替换成其对应的公式，并调用当前Function将其参数换成文字说明
#   LET l_bmze003 = l_bmze003_desc
#   LET l_index = 1
#   LET l_index2 = l_bmze003.getIndexOf('#',1)
#   LET l_bmze003_desc = ''
#   LET bst= base.StringTokenizer.create(l_bmze003,'#')
#   IF l_index2 = 1 THEN
#      WHILE bst.hasMoreTokens()
#         IF l_index = 2 THEN
#            LET l_bmze003_str = bst.nextToken()
#            LET l_bmze003_desc = l_bmze003_desc,l_bmze003_str
#            LET l_index = 1
#         ELSE 
#            LET l_bmze001 = bst.nextToken()
#            CALL abmi002_01_get_bmze003_desc(l_bmze001,'Y') RETURNING l_bmze003_str  
#            IF NOT cl_null(l_bmze003_str) THEN
#               LET l_bmze003_desc = l_bmze003_desc,l_bmze003_str
#               LET l_index = l_index + 1
#            END IF 
#         END IF
#      END WHILE     
#   ELSE
#      WHILE bst.hasMoreTokens()
#         IF l_index = 2 THEN
#            LET l_bmze001 = bst.nextToken()
#            CALL abmi002_01_get_bmze003_desc(l_bmze001,'Y') RETURNING l_bmze003_str   
#            IF NOT cl_null(l_bmze003_str) THEN
#               LET l_bmze003_desc = l_bmze003_desc,l_bmze003_str
#               LET l_index = 1
#            END IF
#         ELSE 
#            LET l_bmze003_str = bst.nextToken()
#            LET l_bmze003_desc = l_bmze003_desc,l_bmze003_str
#            LET l_index = l_index + 1
#         END IF
#      END WHILE
#   END IF
#   LET r_bmze003_desc = l_bmze003_desc
#160901-00032#1---mark---e
   RETURN r_bmze003_desc
END FUNCTION

################################################################################
# Descriptions...: 取得公式说明
# Memo...........:
# Usage..........: CALL abmi002_01_replace_desc(p_bmze001,p_str,p_type)
#                  RETURNING r_bmze003
# Input parameter: p_str       公式
#                : p_type      Y/N 是否给临时表插入数据
# Return code....: r_bmze003_desc 公式说明
# Date & Author..: 2016/11/11 By xianghui
# Modify.........: #160901-00032#1
################################################################################
PUBLIC FUNCTION abmi002_01_replace_desc(p_bmze001,p_str,p_type)
DEFINE p_bmze001       LIKE bmze_t.bmze001
DEFINE p_str           STRING
DEFINE p_type          LIKE type_t.chr1
DEFINE bst             base.StringTokenizer
DEFINE l_index         LIKE type_t.num5
DEFINE l_index2        LIKE type_t.num5
DEFINE l_bmzf003       LIKE bmzf_t.bmzf003
DEFINE l_bmzf002       LIKE bmzf_t.bmzf002
DEFINE l_bmze001       LIKE bmze_t.bmze001
DEFINE l_bmze003_1     LIKE bmze_t.bmze003
DEFINE l_bmze003       STRING
DEFINE l_sql           STRING
DEFINE l_str_old       STRING
DEFINE r_bmze003_desc  STRING

   LET r_bmze003_desc = p_str 
   LET l_bmze003 = r_bmze003_desc
   #将$$参数全部替换成说明文字
   LET l_index = 1
   LET l_index2 = l_bmze003.getIndexOf('$',1)
   LET bst= base.StringTokenizer.create(l_bmze003,'$')
   IF l_index2 = 1 THEN
      WHILE bst.hasMoreTokens()
         IF l_index = 2 THEN
            LET l_bmzf002 = bst.nextToken()
            LET l_index = 1
         ELSE 
            LET l_bmzf002 = bst.nextToken()
            SELECT bmzf003 INTO l_bmzf003 FROM bmzf_t WHERE bmzfent = g_enterprise AND bmzf001 = p_bmze001 AND bmzf002 = l_bmzf002
            LET l_str_old = l_bmzf002
            LET l_str_old = '$' CLIPPED,l_str_old.trim(),'$'
            LET r_bmze003_desc = cl_replace_str(r_bmze003_desc,l_str_old,l_bmzf003)
            CALL abmi002_01_replace_desc(p_bmze001,r_bmze003_desc,p_type) RETURNING r_bmze003_desc
            RETURN r_bmze003_desc
         END IF
      END WHILE     
   ELSE
      WHILE bst.hasMoreTokens()
         IF l_index = 2 THEN
            LET l_bmzf002 = bst.nextToken()
            SELECT bmzf003 INTO l_bmzf003 FROM bmzf_t WHERE bmzfent = g_enterprise AND bmzf001 = p_bmze001 AND bmzf002 = l_bmzf002
            LET l_str_old = l_bmzf002
            LET l_str_old = '$' CLIPPED,l_str_old.trim(),'$'
            LET r_bmze003_desc = cl_replace_str(r_bmze003_desc,l_str_old,l_bmzf003)
            CALL abmi002_01_replace_desc(p_bmze001,r_bmze003_desc,p_type) RETURNING r_bmze003_desc
            RETURN r_bmze003_desc
         ELSE 
            LET l_bmzf002 = bst.nextToken()
            LET l_index = l_index + 1
         END IF
      END WHILE
   END IF
   
   #以后处理后得出的公式说明只剩##的没有处理，下面将对##的做处理
   #将##参数全部替换成其对应的公式，并调用当前Function将其参数换成文字说明
   LET l_bmze003 = r_bmze003_desc
   LET l_index = 1
   LET l_index2 = l_bmze003.getIndexOf('#',1)
   LET bst= base.StringTokenizer.create(l_bmze003,'#')
   IF l_index2 = 1 THEN
      WHILE bst.hasMoreTokens()
         IF l_index = 2 THEN
            LET l_bmze001 = bst.nextToken()
            LET l_index = 1
         ELSE
            #截取签入公式编号         
            LET l_bmze001 = bst.nextToken()
            IF p_type = 'Y' THEN 
               #抓取所有的参数项次Insert到临时表中供输入值
               LET l_sql = " INSERT INTO abmi002_01_tmp (SELECT bmzf001,bmzf002,bmzf003,'' FROM bmzf_t WHERE bmzfent = '",g_enterprise,"' AND bmzf001 = '",l_bmze001,"' )"
               PREPARE abmi002_01_tmp1 FROM l_sql
               EXECUTE abmi002_01_tmp1
               FREE abmi002_01_tmp1 
            END IF            
            #抓取公式
            SELECT bmze003 INTO l_bmze003_1 
              FROM bmze_t
             WHERE bmzeent = g_enterprise
               AND bmze001 = l_bmze001
            #将最终公式中的公式编号替换成公式
            IF NOT cl_null(l_bmze003_1) THEN  
               LET l_str_old = l_bmze001
               LET l_str_old = '#' CLIPPED,l_str_old.trim(),'#'
               LET r_bmze003_desc = cl_replace_str(r_bmze003_desc,l_str_old,l_bmze003_1)
               CALL abmi002_01_replace_desc(l_bmze001,r_bmze003_desc,p_type) RETURNING r_bmze003_desc
               RETURN r_bmze003_desc
            END IF
         END IF
      END WHILE     
   ELSE
      WHILE bst.hasMoreTokens()
         IF l_index = 2 THEN
            #截取签入公式编号         
            LET l_bmze001 = bst.nextToken()
            IF p_type = 'Y' THEN 
               #抓取所有的参数项次Insert到临时表中供输入值
               LET l_sql = " INSERT INTO abmi002_01_tmp (SELECT bmzf001,bmzf002,bmzf003,'' FROM bmzf_t WHERE bmzfent = '",g_enterprise,"' AND bmzf001 = '",l_bmze001,"' )"
               PREPARE abmi002_01_tmp2 FROM l_sql
               EXECUTE abmi002_01_tmp2
               FREE abmi002_01_tmp2 
            END IF            
            #抓取公式
            SELECT bmze003 INTO l_bmze003_1 
              FROM bmze_t
             WHERE bmzeent = g_enterprise
               AND bmze001 = l_bmze001
            #将最终公式中的公式编号替换成公式
            IF NOT cl_null(l_bmze003_1) THEN
               LET l_str_old = l_bmze001
               LET l_str_old = '#' CLIPPED,l_str_old.trim(),'#'           
               LET r_bmze003_desc = cl_replace_str(r_bmze003_desc,l_str_old,l_bmze003_1)
               CALL abmi002_01_replace_desc(l_bmze001,r_bmze003_desc,p_type) RETURNING r_bmze003_desc
               RETURN r_bmze003_desc
            END IF
         ELSE 
            LET l_bmze001 = bst.nextToken()
            LET l_index = l_index + 1
         END IF
      END WHILE
   END IF
   RETURN r_bmze003_desc
END FUNCTION

################################################################################
# Descriptions...: 逐步替换公式的参数与嵌套公式，得出sql可执行出的公式
# Memo...........:
# Usage..........: CALL abmi002_01_get_bmze003(p_bmze001)
#                  RETURNING r_bmze003
# Input parameter: p_bmze001   公式编号
# Return code....: r_bmze003   公式
# Date & Author..: 2016/07/26 By xianghui
# Modify.........: #150624-00013#1
################################################################################
PRIVATE FUNCTION abmi002_01_get_bmze003(p_bmze001)
DEFINE p_bmze001          LIKE bmze_t.bmze001
DEFINE bst                base.StringTokenizer
DEFINE l_index            LIKE type_t.num5
DEFINE l_index2           LIKE type_t.num5
DEFINE l_num              LIKE type_t.num5
DEFINE l_bmze003_compute  STRING
DEFINE l_bmze003_str      STRING
DEFINE l_bmzf002          LIKE bmzf_t.bmzf002
DEFINE l_bmzf008          LIKE type_t.chr80
DEFINE l_bmze001          LIKE bmze_t.bmze001
DEFINE l_bmze003_1        LIKE bmze_t.bmze003
DEFINE l_bmze003          STRING
DEFINE r_bmze003          STRING


   LET r_bmze003 = ''
   
   #抓取公式编号对应的公式
   SELECT bmze003 INTO l_bmze003_1
     FROM bmze_t
    WHERE bmzeent = g_enterprise
      AND bmze001 = p_bmze001
   IF SQLCA.sqlcode THEN 
      RETURN r_bmze003
   END IF
   LET l_bmze003 = l_bmze003_1
   CALL abmi002_01_replace(p_bmze001,l_bmze003) RETURNING r_bmze003   #160901-00032#1
   
#160901-00032#1---mark---e
#   #将$$参数全部替换成临时表中的值
#   LET l_index = 1
#   LET l_bmze003_compute = ''
#   LET l_index2 = l_bmze003.getIndexOf('$',1)
#   LET bst= base.StringTokenizer.create(l_bmze003,'$')
#   IF l_index2 = 1 THEN
#      WHILE bst.hasMoreTokens()
#         IF l_index = 2 THEN
#            LET l_bmze003_str = bst.nextToken()
#            LET l_bmze003_compute = l_bmze003_compute,l_bmze003_str
#            LET l_index = 1
#         ELSE 
#            LET l_bmzf002 = bst.nextToken()
#            SELECT bmzf008 INTO l_bmzf008 FROM abmi002_01_tmp WHERE bmzf001 = p_bmze001 AND bmzf002 = l_bmzf002
#            IF l_bmzf002 = 1 THEN
#               LET l_num = l_bmze003.getIndexOf("'",1)
#               IF l_num > 0 THEN
#                  LET l_bmzf008 = "'",l_bmzf008,"'"
#               END IF
#            END IF
#            IF l_bmzf008 < 0 THEN
#               LET l_bmze003_compute = l_bmze003_compute,'(',l_bmzf008,')'
#            ELSE
#               LET l_bmze003_compute = l_bmze003_compute,l_bmzf008
#            END IF
#            LET l_index = l_index + 1
#         END IF
#      END WHILE     
#   ELSE
#      WHILE bst.hasMoreTokens()
#         IF l_index = 2 THEN
#            LET l_bmzf002 = bst.nextToken()
#            SELECT bmzf008 INTO l_bmzf008 FROM abmi002_01_tmp WHERE bmzf001 = p_bmze001 AND bmzf002 = l_bmzf002
#            IF l_bmzf002 = 1 THEN
#               LET l_num = l_bmze003.getIndexOf("'",1)
#               IF l_num > 0 THEN
#                  LET l_bmzf008 = "'",l_bmzf008,"'"
#               END IF
#            END IF
#            IF l_bmzf008 < 0 THEN
#               LET l_bmze003_compute = l_bmze003_compute,'(',l_bmzf008,')'
#            ELSE
#               LET l_bmze003_compute = l_bmze003_compute,l_bmzf008
#            END IF
#    
#            LET l_index = 1
#         ELSE 
#            LET l_bmze003_str = bst.nextToken()
#            LET l_bmze003_compute = l_bmze003_compute,l_bmze003_str
#            LET l_index = l_index + 1
#         END IF
#      END WHILE
#   END IF
#   
#   #将##参数全部替换成其对应的公式，并调用当前Function将其参数换成对应的值
#   LET l_bmze003 = l_bmze003_compute
#   LET l_index = 1
#   LET l_index2 = l_bmze003.getIndexOf('#',1)
#   LET l_bmze003_compute = ''
#   LET bst= base.StringTokenizer.create(l_bmze003,'#')
#   IF l_index2 = 1 THEN
#      WHILE bst.hasMoreTokens()
#         IF l_index = 2 THEN
#            LET l_bmze003_str = bst.nextToken()
#            LET l_bmze003_compute = l_bmze003_compute,l_bmze003_str
#            LET l_index = 1
#         ELSE 
#            LET l_bmze001 = bst.nextToken()
#            CALL abmi002_01_get_bmze003(l_bmze001) RETURNING l_bmze003_str  
#            IF NOT cl_null(l_bmze003_str) THEN
#               LET l_bmze003_compute = l_bmze003_compute,'(',l_bmze003_str,')'
#               LET l_index = l_index + 1
#            END IF 
#         END IF
#      END WHILE     
#   ELSE
#      WHILE bst.hasMoreTokens()
#         IF l_index = 2 THEN
#            LET l_bmze001 = bst.nextToken()
#            CALL abmi002_01_get_bmze003(l_bmze001) RETURNING l_bmze003_str   
#            IF NOT cl_null(l_bmze003_str) THEN
#               LET l_bmze003_compute = l_bmze003_compute,'(',l_bmze003_str,')'
#               LET l_index = 1
#            END IF
#         ELSE 
#            LET l_bmze003_str = bst.nextToken()
#            LET l_bmze003_compute = l_bmze003_compute,l_bmze003_str
#            LET l_index = l_index + 1
#         END IF
#      END WHILE
#   END IF   
#   LET r_bmze003 = l_bmze003_compute
#160901-00032#1---mark---e
   RETURN r_bmze003
END FUNCTION

################################################################################
# Descriptions...: 逐步替换公式的参数与嵌套公式，得出sql可执行出的公式
# Memo...........:
# Usage..........: CALL abmi002_01_replace(p_bmze001,p_str)
#                  RETURNING r_bmze003
# Input parameter: p_str       替换前公式
# Return code....: r_bmze003   替换后公式
# Date & Author..: 2016/11/11 By xianghui
# Modify.........: #160901-00032#1
################################################################################
PRIVATE FUNCTION abmi002_01_replace(p_bmze001,p_str)
DEFINE p_bmze001          LIKE bmze_t.bmze001
DEFINE p_str              STRING
DEFINE bst                base.StringTokenizer
DEFINE l_index            LIKE type_t.num5
DEFINE l_index2           LIKE type_t.num5
DEFINE l_num              LIKE type_t.num5
DEFINE l_bmzf002          LIKE bmzf_t.bmzf002
DEFINE l_bmzf008          LIKE type_t.chr80
DEFINE l_bmze001          LIKE bmze_t.bmze001
DEFINE l_bmze003_1        LIKE bmze_t.bmze003
DEFINE l_bmze003          STRING
DEFINE l_str_old          STRING
DEFINE r_bmze003          STRING

   LET r_bmze003 = p_str
   LET l_bmze003 = r_bmze003
   #将$$参数全部替换成临时表中的值
   LET l_index = 1
   LET l_index2 = l_bmze003.getIndexOf('$',1)
   LET bst= base.StringTokenizer.create(l_bmze003,'$')
   IF l_index2 = 1 THEN
      WHILE bst.hasMoreTokens()
         IF l_index = 2 THEN
            LET l_bmzf002 = bst.nextToken()
            LET l_index = 1
         ELSE 
            LET l_bmzf002 = bst.nextToken()
            SELECT bmzf008 INTO l_bmzf008 FROM abmi002_01_tmp WHERE bmzf001 = p_bmze001 AND bmzf002 = l_bmzf002
            IF l_bmzf002 = 1 THEN
               LET l_num = l_bmze003.getIndexOf("'",1)
               IF l_num > 0 THEN
                  LET l_bmzf008 = "'",l_bmzf008,"'"
               END IF
            END IF
            IF l_bmzf008 < 0 THEN
               LET l_bmzf008 = '(',l_bmzf008,')'
            END IF
            LET l_str_old = l_bmzf002
            LET l_str_old = '$' CLIPPED,l_str_old.trim(),'$'
            LET r_bmze003 = cl_replace_str(r_bmze003,l_str_old,l_bmzf008)
            CALL abmi002_01_replace(p_bmze001,r_bmze003) RETURNING r_bmze003
            RETURN r_bmze003
         END IF
      END WHILE     
   ELSE
      WHILE bst.hasMoreTokens()
         IF l_index = 2 THEN
            LET l_bmzf002 = bst.nextToken()
            SELECT bmzf008 INTO l_bmzf008 FROM abmi002_01_tmp WHERE bmzf001 = p_bmze001 AND bmzf002 = l_bmzf002
            IF l_bmzf002 = 1 THEN
               LET l_num = l_bmze003.getIndexOf("'",1)
               IF l_num > 0 THEN
                  LET l_bmzf008 = "'",l_bmzf008,"'"
               END IF
            END IF
            IF l_bmzf008 < 0 THEN
               LET l_bmzf008 = '(',l_bmzf008,')'
            END IF
            LET l_str_old = l_bmzf002
            LET l_str_old = '$' CLIPPED,l_str_old.trim(),'$'
            LET r_bmze003 = cl_replace_str(r_bmze003,l_str_old,l_bmzf008)
            CALL abmi002_01_replace(p_bmze001,r_bmze003) RETURNING r_bmze003
            RETURN r_bmze003
         ELSE 
            LET l_bmzf002 = bst.nextToken()
            LET l_index = l_index + 1
         END IF
      END WHILE
   END IF
   
   #将##参数全部替换成其对应的公式，并调用当前Function将其参数换成对应的值
   LET l_bmze003 = r_bmze003
   LET l_index = 1
   LET l_index2 = l_bmze003.getIndexOf('#',1)
   LET bst= base.StringTokenizer.create(l_bmze003,'#')
   IF l_index2 = 1 THEN
      WHILE bst.hasMoreTokens()
         IF l_index = 2 THEN
            LET l_bmze001 = bst.nextToken()
            LET l_index = 1
         ELSE 
            LET l_bmze001 = bst.nextToken()
            #抓取公式编号对应的公式
            SELECT bmze003 INTO l_bmze003_1
              FROM bmze_t
             WHERE bmzeent = g_enterprise
               AND bmze001 = l_bmze001
            LET l_bmze003_1 = '(',l_bmze003_1,')'
            LET l_str_old = l_bmze001 
            LET l_str_old = '#' CLIPPED,l_str_old.trim(),'#'
            LET r_bmze003 = cl_replace_str(r_bmze003,l_str_old,l_bmze003_1)
            CALL abmi002_01_replace(l_bmze001,r_bmze003) RETURNING r_bmze003
            RETURN r_bmze003
         END IF
      END WHILE     
   ELSE
      WHILE bst.hasMoreTokens()
         IF l_index = 2 THEN
            LET l_bmze001 = bst.nextToken()
            #抓取公式编号对应的公式
            SELECT bmze003 INTO l_bmze003_1
              FROM bmze_t
             WHERE bmzeent = g_enterprise
               AND bmze001 = l_bmze001
            LET l_bmze003_1 = '(',l_bmze003_1,')'
            LET l_str_old = l_bmze001 
            LET l_str_old = '#' CLIPPED,l_str_old.trim(),'#'
            LET r_bmze003 = cl_replace_str(r_bmze003,l_str_old,l_bmze003_1)
            CALL abmi002_01_replace(l_bmze001,r_bmze003) RETURNING r_bmze003
            RETURN r_bmze003
         ELSE 
            LET l_bmze001 = bst.nextToken()
            LET l_index = l_index + 1
         END IF
      END WHILE
   END IF   
   RETURN r_bmze003
END FUNCTION
#+根據輸入的值，組出計算公式
PRIVATE FUNCTION abmi002_01_bmze003_ref1(p_bmze001,p_bmze003)
DEFINE  p_bmze001       LIKE bmze_t.bmze001
DEFINE  p_bmze003       STRING
DEFINE  l_bmze003_str1  LIKE bmze_t.bmze003
DEFINE  bst             base.StringTokenizer
DEFINE  l_index         LIKE type_t.num5
DEFINE  l_index2        LIKE type_t.num5
DEFINE  l_bmze003_desc  STRING
DEFINE  l_bmzf008       LIKE type_t.chr80
DEFINE  l_bmzf002       LIKE bmzf_t.bmzf002
DEFINE  l_num           LIKE type_t.num5

      LET l_index = 1
      LET l_bmze003_desc = ''
      LET l_index2 = p_bmze003.getIndexOf('$',1)
      LET bst= base.StringTokenizer.create(p_bmze003,'$')
      IF l_index2 = 1 THEN
         WHILE bst.hasMoreTokens()
            IF l_index = 2 THEN
               LET l_bmze003_str1 = bst.nextToken()
               LET l_bmze003_desc = l_bmze003_desc,l_bmze003_str1
               LET l_index = 1
            ELSE 
               LET l_bmzf002 = bst.nextToken()
               SELECT bmzf008 INTO l_bmzf008 FROM abmi002_01_tmp WHERE bmzf002 = l_bmzf002
               #150902-00006#1 add start
               IF l_bmzf002 = 1 THEN
                  LET l_num = p_bmze003.getIndexOf("'",1)
                  IF l_num > 0 THEN
                     LET l_bmzf008 = "'",l_bmzf008,"'"
                  END IF
               END IF
               #150902-00006#1 add end
                IF l_bmzf008 < 0 THEN
                   LET l_bmze003_desc = l_bmze003_desc,'(',l_bmzf008,')'
                ELSE
                   LET l_bmze003_desc = l_bmze003_desc,l_bmzf008
                END IF
               LET l_index = l_index + 1
            END IF
         END WHILE     
      ELSE
         WHILE bst.hasMoreTokens()
            IF l_index = 2 THEN
               LET l_bmzf002 = bst.nextToken()
               SELECT bmzf008 INTO l_bmzf008 FROM abmi002_01_tmp WHERE bmzf002 = l_bmzf002
               #150902-00006#1 add start
               IF l_bmzf002 = 1 THEN
                  LET l_num = p_bmze003.getIndexOf("'",1)
                  IF l_num > 0 THEN
                     LET l_bmzf008 = "'",l_bmzf008,"'"
                  END IF
               END IF
               #150902-00006#1 add end
               IF l_bmzf008 < 0 THEN
                  LET l_bmze003_desc = l_bmze003_desc,'(',l_bmzf008,')'
               ELSE
                  LET l_bmze003_desc = l_bmze003_desc,l_bmzf008
               END IF

               LET l_index = 1
            ELSE 
               LET l_bmze003_str1 = bst.nextToken()
               LET l_bmze003_desc = l_bmze003_desc,l_bmze003_str1
               LET l_index = l_index + 1
            END IF
         END WHILE
      END IF
      RETURN l_bmze003_desc
      
END FUNCTION
#+根據參數項次，組出相應的公式說明
PRIVATE FUNCTION abmi002_01_bmze003_ref(p_bmze001,p_bmze003)
DEFINE  p_bmze001       LIKE bmze_t.bmze001
DEFINE  p_bmze003       STRING
DEFINE  l_bmze003_str1  LIKE bmze_t.bmze003
DEFINE  bst             base.StringTokenizer
DEFINE  l_index         LIKE type_t.num5
DEFINE  l_index2        LIKE type_t.num5
DEFINE  l_bmze003_desc  STRING
DEFINE  l_bmzf003       LIKE bmzf_t.bmzf003
DEFINE  l_bmzf002       LIKE bmzf_t.bmzf002

      LET l_index = 1
      LET l_bmze003_desc = ''
      LET l_index2 = p_bmze003.getIndexOf('$',1)
      LET bst= base.StringTokenizer.create(p_bmze003,'$')
      IF l_index2 = 1 THEN
         WHILE bst.hasMoreTokens()
            IF l_index = 2 THEN
               LET l_bmze003_str1 = bst.nextToken()
               LET l_bmze003_desc = l_bmze003_desc,l_bmze003_str1
               LET l_index = 1
            ELSE 
               LET l_bmzf002 = bst.nextToken()
               SELECT bmzf003 INTO l_bmzf003 FROM bmzf_t WHERE bmzfent = g_enterprise AND bmzf001 = p_bmze001 AND bmzf002 = l_bmzf002
               LET l_bmze003_desc = l_bmze003_desc,l_bmzf003
               LET l_index = l_index + 1
            END IF
         END WHILE     
      ELSE
         WHILE bst.hasMoreTokens()
            IF l_index = 2 THEN
               LET l_bmzf002 = bst.nextToken()
               SELECT bmzf003 INTO l_bmzf003 FROM bmzf_t WHERE bmzfent = g_enterprise AND bmzf001 = p_bmze001 AND bmzf002 = l_bmzf002
               LET l_bmze003_desc = l_bmze003_desc,l_bmzf003
               LET l_index = 1
            ELSE 
               LET l_bmze003_str1 = bst.nextToken()
               LET l_bmze003_desc = l_bmze003_desc,l_bmze003_str1
               LET l_index = l_index + 1
            END IF
         END WHILE
      END IF
      RETURN l_bmze003_desc
END FUNCTION
#+
PRIVATE FUNCTION abmi002_01_b_fill(p_bmze001)
   DEFINE l_sql       STRING
   DEFINE p_bmze001   LIKE bmze_t.bmze001
   DEFINE l_ac1       LIKE type_t.num5
   
   #LET l_sql = "SELECT bmzf001,bmzf002,bmzf003,'' FROM bmzf_t WHERE bmzfent = '",g_enterprise,"' AND bmzf001 = '",p_bmze001,"' "   #150624-00013#1 mark
   LET l_sql = "SELECT bmzf001,bmzf002,bmzf003,bmzf008 FROM abmi002_01_tmp "   #150624-00013#1
   PREPARE abmi002_01_pb FROM l_sql
   DECLARE b_fill_curs CURSOR FOR abmi002_01_pb

   CALL g_bmzf_d.clear()
   LET l_ac1 = 1
   FOREACH b_fill_curs INTO g_bmzf_d[l_ac1].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      #SELECT bmzf008 INTO g_bmzf_d[l_ac1].bmzf008 FROM abmi002_01_tmp WHERE bmzf002 = g_bmzf_d[l_ac1].bmzf002  #150624-00013#1 mark
      
      LET l_ac1 = l_ac1 + 1
      IF l_ac1 > g_max_rec THEN
         #CALL cl_err( "", 9035, 0 )
         EXIT FOREACH
      END IF

   END FOREACH
   CALL g_bmzf_d.deleteElement(g_bmzf_d.getLength())
   LET g_rec_b = l_ac1 - 1
   DISPLAY g_rec_b TO FORMONLY.cnt
   CLOSE b_fill_curs
   FREE abmi002_01_pb
END FUNCTION
#+
PRIVATE FUNCTION abmi002_01_bmzf008_chk(p_bmzf008)
DEFINE   p_bmzf008       STRING
DEFINE   l_index         LIKE type_t.num5
DEFINE   l_index2        LIKE type_t.num5
DEFINE   li_i            LIKE type_t.num10
DEFINE   l_value         LIKE type_t.chr5
DEFINE   l_len           LIKE type_t.num10
DEFINE   l_n             LIKE type_t.num5
DEFINE   r_success       LIKE type_t.num5

      LET r_success = TRUE
      
      IF cl_null(p_bmzf008) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'abm-00005'
         LET g_errparam.extend = p_bmzf008
         LET g_errparam.popup = FALSE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF
      #判斷是否有負號'-'，如果有，判斷是否在第一位，若不在第一位，則報錯，若在第一位，則從第二位開始判斷是否存在非數字
      #如果沒有'-'，則從第一位開始判斷是否存在非數字
      LET l_n = 0
      
      LET l_index = p_bmzf008.getIndexOf("-",1)
      IF l_index = 0 THEN         
         LET l_index2 = 1
      ELSE
         IF l_index = 1 THEN
            LET l_index2 = 2
         ELSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'agl-00036'
            LET g_errparam.extend = p_bmzf008
            LET g_errparam.popup = FALSE
            CALL cl_err()

            LET r_success = FALSE
            RETURN r_success
         END IF
      END IF
      
      LET l_len = p_bmzf008.getLength()
      FOR li_i = l_index2 TO l_len
          LET l_value = p_bmzf008.subString(li_i,li_i)
          IF l_value MATCHES '[.0123456789]' THEN
             IF l_value = '.' THEN
                IF l_n > 0 THEN   #不止一個小數點
                   INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'agl-00036'
            LET g_errparam.extend = p_bmzf008
            LET g_errparam.popup = FALSE
            CALL cl_err()

                   LET r_success = FALSE
                   RETURN r_success
                END IF
                LET l_n = l_n + 1
             END IF
          ELSE
             INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'agl-00036'
            LET g_errparam.extend = p_bmzf008
            LET g_errparam.popup = FALSE
            CALL cl_err()

             LET r_success = FALSE
             RETURN r_success
          END IF
      END FOR

      RETURN r_success
   
END FUNCTION
#+
PRIVATE FUNCTION abmi002_01_show(p_bmze001)
DEFINE p_bmze001       LIKE bmze_t.bmze001
DEFINE l_bmze003       LIKE bmze_t.bmze003
DEFINE l_bmze003_desc  STRING
DEFINE l_bmze003_desc1 STRING
   #150624-00013#1---mark---s
   #SELECT bmze003 INTO l_bmze003 FROM bmze_t WHERE bmzeent = g_enterprise AND bmze001 = p_bmze001
   #CALL abmi002_01_bmze003_ref(p_bmze001,l_bmze003) RETURNING l_bmze003_desc
   #DISPLAY l_bmze003_desc TO bmze003_desc
   #150624-00013#1---mark---s
   CALL abmi002_01_b_fill(p_bmze001)
       
       
END FUNCTION
#+
PRIVATE FUNCTION abmi002_01_set_format(p_bmzf008)
DEFINE   p_bmzf008       STRING
DEFINE   ls_value        STRING
DEFINE   li_digcut       LIKE type_t.num10
DEFINE   ls_head_str     STRING
DEFINE   ls_tail_str     STRING
DEFINE   li_i            LIKE type_t.num10 
DEFINE   li_tmp          LIKE type_t.num10 
DEFINE   li_tail_value   LIKE type_t.num10

   LET li_digcut = p_bmzf008.getIndexOf(".",1)
   IF li_digcut = 0 THEN
      LET ls_value = p_bmzf008
      RETURN ls_value
   END IF

   LET ls_head_str = p_bmzf008.subString(1,li_digcut - 1)
   LET ls_tail_str = p_bmzf008.subString(li_digcut + 1,p_bmzf008.getLength())
   
   IF ls_tail_str > 0 THEN
      FOR li_i = ls_tail_str.getLength() TO 1
          LET li_tail_value = ls_tail_str.subString(ls_tail_str.getLength()-1,ls_tail_str.getLength())
          IF li_tail_value = 0 THEN
             LET ls_tail_str = ls_tail_str.subString(1,ls_tail_str.getLength()-1)
          ELSE
             EXIT FOR 
          END IF
      END FOR
      LET ls_value = ls_head_str || "." || ls_tail_str
   ELSE
      LET ls_value = ls_head_str 
   END IF

   RETURN ls_value
   
END FUNCTION

 
{</section>}
 
