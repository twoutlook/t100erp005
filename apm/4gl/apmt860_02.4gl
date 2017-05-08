#該程式未解開Section, 採用最新樣板產出!
{<section id="apmt860_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2015-01-08 18:33:11), PR版次:0001(2015-01-08 19:33:39)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000072
#+ Filename...: apmt860_02
#+ Description: 重新產生原始需求分配
#+ Creator....: 04226(2015-01-08 16:55:12)
#+ Modifier...: 04226 -SD/PR- 04226
 
{</section>}
 
{<section id="apmt860_02.global" >}
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
PRIVATE TYPE type_g_pmdp_d        RECORD
       pmdpdocno LIKE pmdp_t.pmdpdocno, 
   pmdpseq LIKE pmdp_t.pmdpseq, 
   pmdpseq1 LIKE pmdp_t.pmdpseq1, 
   pmdp003 LIKE pmdp_t.pmdp003, 
   pmdp004 LIKE pmdp_t.pmdp004, 
   pmdp005 LIKE pmdp_t.pmdp005, 
   pmdp006 LIKE pmdp_t.pmdp006, 
   pmdp007 LIKE pmdp_t.pmdp007, 
   pmdp007_desc LIKE type_t.chr500, 
   pmdp007_desc_1 LIKE type_t.chr500, 
   pmdp008 LIKE pmdp_t.pmdp008, 
   pmdp008_desc LIKE type_t.chr500, 
   pmdp021 LIKE pmdp_t.pmdp021, 
   pmdp022 LIKE pmdp_t.pmdp022, 
   pmdp022_desc LIKE type_t.chr500, 
   pmdp023 LIKE pmdp_t.pmdp023, 
   pmdp024 LIKE pmdp_t.pmdp024
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_detail_cnt          LIKE type_t.num5              #單身 總筆數(所有資料)
DEFINE g_error_show          LIKE type_t.num5
DEFINE g_pmdp_d_o            type_g_pmdp_d

#單頭顯示欄位Record
DEFINE g_pmdt         RECORD
       pmdtdocno      LIKE pmdt_t.pmdtdocno,    #收貨單號
       pmdtseq        LIKE pmdt_t.pmdtseq,      #收貨項次
       pmdt001        LIKE pmdt_t.pmdt001,      #採購單號
       pmdt002        LIKE pmdt_t.pmdt002,      #採購項次
       pmdt006        LIKE pmdt_t.pmdt006,      #商品編號
       pmdt006_desc   LIKE imaal_t.imaal003,    #商品品名
       pmdt006_desc_1 LIKE imaal_t.imaal004,    #商品規格
       pmdt007        LIKE pmdt_t.pmdt007,      #產品特徵
       pmdt007_desc   LIKE type_t.chr300,       #產品特徵說明
       pmdt019        LIKE pmdt_t.pmdt019,      #出貨單位
       pmdt019_desc   LIKE oocal_t.oocal003,    #出貨單位名稱
       pmdt020        LIKE pmdt_t.pmdt020       #出貨數量
       END RECORD
       
DEFINE g_pmdtdocno   LIKE pmdt_t.pmdtdocno      #出貨單號
DEFINE g_pmdtseq     LIKE pmdt_t.pmdtseq        #出貨項次
#end add-point
 
DEFINE g_pmdp_d          DYNAMIC ARRAY OF type_g_pmdp_d
DEFINE g_pmdp_d_t        type_g_pmdp_d
 
 
DEFINE g_pmdpdocno_t   LIKE pmdp_t.pmdpdocno    #Key值備份
DEFINE g_pmdpseq_t      LIKE pmdp_t.pmdpseq    #Key值備份
DEFINE g_pmdpseq1_t      LIKE pmdp_t.pmdpseq1    #Key值備份
 
 
DEFINE l_ac                  LIKE type_t.num10
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rec_b               LIKE type_t.num10 
DEFINE g_detail_idx          LIKE type_t.num10
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
    
#add-point:傳入參數說明(global.argv) name="global.argv"
################################
# p_pmdtdocno  #出貨單號
# p_pmdtseq    #出貨項次
################################
#end add-point    
 
{</section>}
 
{<section id="apmt860_02.input" >}
#+ 資料輸入
PUBLIC FUNCTION apmt860_02(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_pmdtdocno,       #出貨單號
   p_pmdtseq          #出貨項次
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
   DEFINE p_pmdtdocno     LIKE pmdt_t.pmdtdocno        #出貨單號
   DEFINE p_pmdtseq       LIKE pmdt_t.pmdtseq          #出貨項次
   DEFINE l_lock_sw       LIKE type_t.chr1             #單身鎖住否
   DEFINE l_n             LIKE type_t.num5
   DEFINE l_choice        LIKE type_t.chr1
   DEFINE l_pmdpseq       LIKE pmdp_t.pmdpseq
   DEFINE l_pmdpseq1      LIKE pmdp_t.pmdpseq1
   DEFINE l_sql           STRING
   DEFINE l_msg           STRING
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_apmt860_02 WITH FORM cl_ap_formpath("apm","apmt860_02")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單身前置處理 name="input.pre_input"
   LET g_pmdtdocno = p_pmdtdocno  #出貨單號
   LET g_pmdtseq = p_pmdtseq      #出貨項次
   
   #顯示單頭欄位值
   CALL apmt860_02_show_head()
   
   #顯示採購單單身需求分配資料
   CALL apmt860_02_b_fill()
   
   LET l_sql = "SELECT pmdpdocno,pmdpseq,pmdpseq1,pmdp003,pmdp004,",
               "       pmdp005,  pmdp006,pmdp007,pmdp008, pmdp021,",
               "       pmdp022,  pmdp023,pmdp024",
               "  FROM pmdp_t",
               " WHERE pmdpent = ?",
               "   AND pmdpdocno = ?",
               "   AND pmdpseq = ?",
               "   AND pmdpseq1 = ? FOR UPDATE"
   LET l_sql = cl_sql_forupd(l_sql)
   LET l_sql = cl_sql_add_mask(l_sql)              #遮蔽特定資料
   DECLARE apmt860_02_bcl CURSOR FROM l_sql
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT ARRAY g_pmdp_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
         
         #自訂ACTION
         #add-point:單身前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(detail_input)
         
         
         BEFORE INPUT
            #add-point:單身輸入前處理 name="input.before_input"
            CALL apmt860_02_b_fill()
            LET g_detail_cnt = g_pmdp_d.getLength()
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdp021
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmdp_d[l_ac].pmdp021,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD pmdp021
            END IF 
 
 
 
            #add-point:AFTER FIELD pmdp021 name="input.a.page1.pmdp021"
            IF NOT cl_null(g_pmdp_d[l_ac].pmdp021) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdp021
            #add-point:BEFORE FIELD pmdp021 name="input.b.page1.pmdp021"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdp021
            #add-point:ON CHANGE pmdp021 name="input.g.page1.pmdp021"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.pmdp021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdp021
            #add-point:ON ACTION controlp INFIELD pmdp021 name="input.c.page1.pmdp021"
            
            #END add-point
 
 
 
 
         #自訂ACTION
         #add-point:單身其他段落處理(EX:on row change, etc...) name="input.other"
         BEFORE ROW
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_cmd = ''
            LET l_ac = g_detail_idx
            LET l_lock_sw = 'N'
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            DISPLAY g_pmdp_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_pmdp_d.getLength()
            
            IF g_detail_cnt >= l_ac AND
               g_pmdp_d[l_ac].pmdpdocno IS NOT NULL AND 
               g_pmdp_d[l_ac].pmdpseq IS NOT NULL AND 
               g_pmdp_d[l_ac].pmdpseq1 IS NOT NULL THEN
               
               LET l_cmd='u'
               LET g_pmdp_d_t.* = g_pmdp_d[l_ac].*  #BACKUP
               LET g_pmdp_d_o.* = g_pmdp_d[l_ac].*  #BACKUP
               IF NOT apmt860_02_lock_b("pmdp_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH apmt860_02_bcl
                   INTO g_pmdp_d[l_ac].pmdpdocno, g_pmdp_d[l_ac].pmdpseq, g_pmdp_d[l_ac].pmdpseq1,
                        g_pmdp_d[l_ac].pmdp003,   g_pmdp_d[l_ac].pmdp004, g_pmdp_d[l_ac].pmdp005,
                        g_pmdp_d[l_ac].pmdp006,   g_pmdp_d[l_ac].pmdp007, g_pmdp_d[l_ac].pmdp008,
                        g_pmdp_d[l_ac].pmdp021,   g_pmdp_d[l_ac].pmdp022, g_pmdp_d[l_ac].pmdp023,
                        g_pmdp_d[l_ac].pmdp024
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_pmdp_d_t.pmdpdocno 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_pmdp_d[l_ac].* = g_pmdp_d_t.*
               CLOSE apmt860_02_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_pmdp_d[l_ac].pmdpdocno 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_pmdp_d[l_ac].* = g_pmdp_d_t.*
            END IF
            
            IF NOT cl_null(g_pmdp_d[l_ac].pmdp021) THEN
               IF g_pmdp_d[l_ac].pmdp021 != g_pmdp_d_t.pmdp021 THEN
                  LET l_n = 0
                  #判斷輸入的沖銷順序是否和其他項次的順序重複
                  SELECT COUNT(pmdpdocno) INTO l_n
                    FROM pmdp_t
                   WHERE pmdpent = g_enterprise
                     AND pmdpdocno = g_pmdt.pmdt001
                     AND pmdp021 = g_pmdp_d[l_ac].pmdp021
                  #1.當有修改沖銷順序時，開窗詢問要做沖銷順序互換，還是要做沖銷順序重排，
                  #1-1.若選擇沖銷順序互換代表是將兩個沖銷順序對換，例如某一需求項次的沖銷順序為5，
                  #    若將沖銷順序改成2時則此需求項次的沖銷順序變成2，把而原本充銷順序為2的就變成成5
                  #1-2.若是選擇沖銷順序重排代表是將修改後的沖銷順序依序往下重排，例如某一需求項次
                  #    的沖銷順序為5，若將沖銷順序改成2時則此需求項次的沖銷順序變成2而原本沖銷順序為2的
                  #    變成3，所以依序的原本為3的則變成4，原本為4的變成5
                  IF l_n > 0 THEN
                     LET l_msg = cl_getmsg("apm-00416",g_lang)
                     LET l_choice = cl_ask_choice(l_msg)
                     IF l_choice NOT MATCHES '[12]' THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'apm-00417'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_pmdp_d[l_ac].pmdp021 = g_pmdp_d_t.pmdp021
                        NEXT FIELD pmdp021
                     END IF
                     
                     IF l_choice = '1' THEN  #順序互換
                        SELECT pmdpseq,pmdpseq1 INTO l_pmdpseq,l_pmdpseq1
                          FROM pmdp_t
                         WHERE pmdpent = g_enterprise
                           AND pmdpdocno = g_pmdt.pmdt001
                           AND pmdpseq = g_pmdt.pmdt002
                           AND pmdp021 = g_pmdp_d[l_ac].pmdp021
                           
                        UPDATE pmdp_t
                           SET pmdp021 = g_pmdp_d_t.pmdp021
                         WHERE pmdpent = g_enterprise
                           AND pmdpdocno = g_pmdt.pmdt001
                           AND pmdpseq = g_pmdt.pmdt002
                           AND pmdpseq1 = l_pmdpseq1
                     END IF
                     IF l_choice = '2' THEN  #順序重排
                        UPDATE pmdp_t
                           SET pmdp021 = pmdp021 + 1
                         WHERE pmdpent = g_enterprise
                           AND pmdpdocno = g_pmdt.pmdt001
                           AND pmdpseq = g_pmdt.pmdt002
                           AND pmdp021 >= g_pmdp_d[l_ac].pmdp021
                     END IF
                  END IF

                  UPDATE pmdp_t
                     SET pmdp021 = g_pmdp_d[l_ac].pmdp021
                   WHERE pmdpent = g_enterprise
                     AND pmdpdocno = g_pmdp_d_t.pmdpdocno
                     AND pmdpseq = g_pmdp_d_t.pmdpseq  
                     AND pmdpseq1 = g_pmdp_d_t.pmdpseq1  
                  
                  CASE
                     WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "pmdp_t" 
                        LET g_errparam.code   = "std-00009" 
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        CALL s_transaction_end('N','0')
                        
                     WHEN SQLCA.sqlcode #其他錯誤
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "pmdp_t" 
                        LET g_errparam.code   = SQLCA.sqlcode 
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        CALL s_transaction_end('N','0')
                     OTHERWISE
                     
                  END CASE
               END IF
            END IF
            
         AFTER ROW
            CALL apmt860_02_unlock_b("pmdp_t")
            CALL s_transaction_end('Y','0')
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
   CLOSE WINDOW w_apmt860_02 
   
   #add-point:input段after input name="input.post_input"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="apmt860_02.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="apmt860_02.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 顯示單頭所需的欄位值
# Memo...........:
# Usage..........: CALL apmt860_02_show_head()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/01/08 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION apmt860_02_show_head()
DEFINE l_success        LIKE type_t.num5

   INITIALIZE g_pmdt.* TO NULL

   SELECT pmdt001,     pmdt002,     pmdt006,
          t1.imaal004, t1.imaal003, pmdt007,
          pmdt019,     t2.oocal003, pmdt020
     INTO g_pmdt.pmdt001,      g_pmdt.pmdt002,        g_pmdt.pmdt006,
          g_pmdt.pmdt006_desc, g_pmdt.pmdt006_desc_1, g_pmdt.pmdt007,
          g_pmdt.pmdt019,      g_pmdt.pmdt019_desc,   g_pmdt.pmdt020
     FROM pmdt_t
     LEFT OUTER JOIN imaal_t t1 ON t1.imaalent = pmdtent
                               AND t1.imaal001 = pmdt006
                               AND t1.imaal002 = g_dlang
     LEFT OUTER JOIN oocal_t t2 ON t2.oocalent = pmdtent
                               AND t2.oocal001 = pmdt019
                               AND t2.oocal002 = g_dlang
    WHERE pmdtent = g_enterprise
      AND pmdtdocno = g_pmdtdocno
      AND pmdtseq = g_pmdtseq
   
   LET g_pmdt.pmdtdocno = g_pmdtdocno
   LET g_pmdt.pmdtseq = g_pmdtseq
   
   #產品特徵說明
   CALL s_feature_description(g_pmdt.pmdt006,g_pmdt.pmdt007)
      RETURNING l_success,g_pmdt.pmdt007_desc
      
   DISPLAY BY NAME g_pmdt.pmdtdocno, g_pmdt.pmdtseq, g_pmdt.pmdt001,
                   g_pmdt.pmdt002,   g_pmdt.pmdt006, g_pmdt.pmdt007,
                   g_pmdt.pmdt019,   g_pmdt.pmdt020,
                   g_pmdt.pmdt006_desc, g_pmdt.pmdt006_desc_1,
                   g_pmdt.pmdt007_desc, g_pmdt.pmdt019_desc
END FUNCTION

################################################################################
# Descriptions...: 顯示採購單單身需求分配資料
# Memo...........:
# Usage..........: CALL apmt860_02_b_fill()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/01/08 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION apmt860_02_b_fill()
DEFINE l_sql          STRING
DEFINE l_success      LIKE type_t.num5


   LET l_sql = "SELECT UNIQUE pmdpdocno, pmdpseq,     pmdpseq1,    pmdp003,",
               "              pmdp004,   pmdp005,     pmdp006,     pmdp007,",
               "              pmdp008,   pmdp021,     pmdp022,     pmdp023,",
               "              pmdp024,   t1.imaal003, t1.imaal004, t2.oocal003",
               "  FROM pmdp_t", 
               " LEFT JOIN imaal_t t1 ON t1.imaalent = ",g_enterprise,
               "                     AND t1.imaal001 = pmdp007",
               "                     AND t1.imaal002 = '"||g_dlang||"'",
               " LEFT JOIN oocal_t t2 ON t2.oocalent = ",g_enterprise,
               "                     AND t2.oocal001 = pmdp022",
               "                     AND t2.oocal002 = '"||g_dlang||"'",
               " WHERE pmdpent = ?",
               "   AND pmdpdocno = '",g_pmdt.pmdt001,"'",
               "   AND pmdpseq = ",g_pmdt.pmdt002
   LET l_sql = l_sql, cl_sql_add_filter("pmdp_t"),
               " ORDER BY pmdpdocno,pmdpseq,pmdpseq1"
   LET l_sql = cl_sql_add_mask(l_sql)              #遮蔽特定資料
   
   PREPARE apmt860_02_pb FROM l_sql
   DECLARE b_fill_curs CURSOR FOR apmt860_02_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_pmdp_d.clear()
 
   #LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs
      INTO g_pmdp_d[l_ac].pmdpdocno, g_pmdp_d[l_ac].pmdpseq, g_pmdp_d[l_ac].pmdpseq1, g_pmdp_d[l_ac].pmdp003,
           g_pmdp_d[l_ac].pmdp004, g_pmdp_d[l_ac].pmdp005, g_pmdp_d[l_ac].pmdp006, g_pmdp_d[l_ac].pmdp007, 
           g_pmdp_d[l_ac].pmdp008, g_pmdp_d[l_ac].pmdp021, g_pmdp_d[l_ac].pmdp022, g_pmdp_d[l_ac].pmdp023,
           g_pmdp_d[l_ac].pmdp024, g_pmdp_d[l_ac].pmdp007_desc, g_pmdp_d[l_ac].pmdp007_desc_1, g_pmdp_d[l_ac].pmdp022_desc
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      #產品特徵說明
      CALL s_feature_description(g_pmdp_d[l_ac].pmdp007,g_pmdp_d[l_ac].pmdp008)
         RETURNING l_success,g_pmdp_d[l_ac].pmdp008_desc
      
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code   = 9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF
 
      LET l_ac = l_ac + 1
      
   END FOREACH
 
   LET g_error_show = 0
   
   CALL g_pmdp_d.deleteElement(g_pmdp_d.getLength())   
   
#   #將key欄位填到每個page
#   FOR l_ac = 1 TO g_pmdp_d.getLength()
# 
#   END FOR
#   
#   IF g_cnt > g_pmdp_d.getLength() THEN
#      LET l_ac = g_pmdp_d.getLength()
#   ELSE
#      LET l_ac = g_cnt
#   END IF
#   LET g_cnt = l_ac
#   
   ERROR "" 
 
   LET g_detail_cnt = g_pmdp_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE apmt860_02_pb
END FUNCTION

################################################################################
# Descriptions...: lock單身table資料
# Memo...........:
# Usage..........: CALL apmt860_02_lock_b(ps_table)
#                :    RETURNING r_success
# Input parameter: ps_table       table名稱
# Return code....: r_success      True/False
# Date & Author..: 2015/01/08 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION apmt860_02_lock_b(ps_table)
DEFINE ps_table     STRING
DEFINE r_success    LIKE type_t.num5
DEFINE ls_group     STRING

   LET r_success = TRUE
   #僅鎖定自身table
   LET ls_group = "pmdp_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN apmt860_02_bcl
         USING g_enterprise, g_pmdp_d[g_detail_idx].pmdpdocno,
               g_pmdp_d[g_detail_idx].pmdpseq, g_pmdp_d[g_detail_idx].pmdpseq1
                                       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apmt860_02_bcl" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: unlock單身table資料
# Memo...........:
# Usage..........: CALL apmt860_02_unlock_b(ps_table)
# Input parameter: ps_table       table名稱
# Return code....: 無
# Date & Author..: 2015/01/08 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION apmt860_02_unlock_b(ps_table)
DEFINE ps_table     STRING
   
   CLOSE apmt860_02_bcl
END FUNCTION

 
{</section>}
 
