#該程式未解開Section, 採用最新樣板產出!
{<section id="ammt450_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0010(2016-10-04 10:35:56), PR版次:0010(2016-11-11 17:13:32)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000597
#+ Filename...: ammt450_01
#+ Description: 兌換商品選擇維護作業
#+ Creator....: 04226(2014-03-17 19:53:46)
#+ Modifier...: 02749 -SD/PR- 02481
 
{</section>}
 
{<section id="ammt450_01.global" >}
#應用 c02b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160318-00005#25  2016/03/30 by 07675   將重複內容的錯誤訊息置換為公用錯誤訊息
#160318-00025#20  2016/04/19 BY 07900   校验代码重复错误讯息的修改
#160705-00042#11  2016/07/14 By sakura  程式中寫死g_prog部分改寫MATCHES方式
#160819-00054#14  2016/10/03 By lori    1.ammt451:基本資料/兌換規則資訊：新增資訊：來源單號(rtia007)、兌換業態(rtia066),及相關處理
#                                       2.如兌換規則有依業態,則需依業態過慮顯示可兌換的組別
#161111-00028#1   2016/11/11 BY 02481    标准程式定义采用宣告模式,弃用.*写法
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
PRIVATE TYPE type_g_mmfe_d        RECORD
       sel LIKE type_t.chr1, 
   mmfeseq LIKE mmfe_t.mmfeseq, 
   mmfe011 LIKE mmfe_t.mmfe011, 
   mmfe001 LIKE mmfe_t.mmfe001, 
   mmfe001_desc LIKE type_t.chr500, 
   mmfe003 LIKE mmfe_t.mmfe003, 
   mmfe003_desc LIKE type_t.chr500, 
   mmfe006 LIKE mmfe_t.mmfe006, 
   mmfe004 LIKE mmfe_t.mmfe004, 
   mmfe005 LIKE mmfe_t.mmfe005, 
   mmfe007 LIKE mmfe_t.mmfe007, 
   mmfe010 LIKE mmfe_t.mmfe010, 
   mmfe010_desc LIKE type_t.chr500, 
   mmfe012 LIKE mmfe_t.mmfe012, 
   mmfe013 LIKE mmfe_t.mmfe013, 
   mmfe013_desc LIKE type_t.chr500, 
   mmcj011 LIKE type_t.chr500, 
   mmcj012 LIKE type_t.chr500, 
   mmcj007 LIKE type_t.chr500
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_sql                STRING
DEFINE l_ac_t               LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_detail_cnt         LIKE type_t.num5              #單身 總筆數(所有資料) 
DEFINE g_mmfe_d_o           type_g_mmfe_d
DEFINE g_rtia               RECORD
       rtiasite             LIKE rtia_t.rtiasite,  #兌換組織
       rtiadocdt            LIKE rtia_t.rtiadocdt, #單據日期
       rtia001              LIKE rtia_t.rtia001,   #卡號
       rtia026              LIKE rtia_t.rtia026,   #交易幣別
       rtia027              LIKE rtia_t.rtia027,   #交易匯率
       rtia042              LIKE rtia_t.rtia042,   #卡種編號
       rtia043              LIKE rtia_t.rtia043,   #卡積點餘額
       rtia044              LIKE rtia_t.rtia044,   #規則編號
       rtia045              LIKE rtia_t.rtia045,   #版本
       rtia046              LIKE rtia_t.rtia046,   #該規則計算總積點
       rtia047              LIKE rtia_t.rtia047,   #此次兌換積點
       rtia0461             LIKE type_t.chr80,     #該規則已兌換份數
       rtia0471             LIKE type_t.chr80      #兌換後剩餘積點
                            END RECORD
DEFINE g_rtiadocno          LIKE rtia_t.rtiadocno  #單據編號

DEFINE g_mmci_d             DYNAMIC ARRAY OF RECORD
       mmci003              LIKE mmci_t.mmci003,   #組別
       mmci004              LIKE mmci_t.mmci004,   #累計積點\累計消費額達
       mmci005              LIKE mmci_t.mmci005    #可兌換份數
                            END RECORD
DEFINE g_mmci004            LIKE mmci_t.mmci004
DEFINE g_mmci005            LIKE mmci_t.mmci005
DEFINE g_mmby009            LIKE mmby_t.mmby009
DEFINE g_mmby010            LIKE mmby_t.mmby010
DEFINE g_mmby011            LIKE mmby_t.mmby011
DEFINE g_mmby012            LIKE mmby_t.mmby012
DEFINE g_mmby024            LIKE mmby_t.mmby024   #160819-00054#14 161003 by lori add
DEFINE g_gcaf010            LIKE gcaf_t.gcaf010
DEFINE g_gcaf011            LIKE gcaf_t.gcaf011
DEFINE g_err_str            STRING
DEFINE g_sum_mmci004        LIKE mmci_t.mmci004
DEFINE g_mmci003            LIKE mmci_t.mmci003     #分段兌換比例 紀錄可以兌換到最大的組別
DEFINE g_mmfe007            LIKE mmfe_t.mmfe007
DEFINE g_rtia066            LIKE rtia_t.rtia066   #160819-00054#14 161003 by lori add
#end add-point
 
DEFINE g_mmfe_d          DYNAMIC ARRAY OF type_g_mmfe_d
DEFINE g_mmfe_d_t        type_g_mmfe_d
 
 
DEFINE g_mmfedocno_t   LIKE mmfe_t.mmfedocno    #Key值備份
DEFINE g_mmfeseq_t      LIKE mmfe_t.mmfeseq    #Key值備份
 
 
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
 
{<section id="ammt450_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION ammt450_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_rtiadocno
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
   DEFINE p_rtiadocno     LIKE rtia_t.rtiadocno  
   DEFINE l_sel           LIKE type_t.chr1
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_sum_mmci004   LIKE mmci_t.mmci004
   
   #傳入的單據編號為空！
   IF cl_null(p_rtiadocno) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00228' #160318-00005#25 mod'ade-00003'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
   
   LET g_rtiadocno = p_rtiadocno
   
   #检查是否在事务中
   IF NOT s_transaction_chk('Y',1) THEN
      RETURN
   END IF
   
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_ammt450_01 WITH FORM cl_ap_formpath("amm","ammt450_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單身前置處理 name="input.pre_input"
   LET g_mmci003 = 0   
   CALL ammt450_01_init()
   CALL ammt450_01_tovalue()
   CALL ammt450_01_chk_exchange()
   CALL ammt450_01_btovalue()
   CALL ammt450_01_b_fill()
   
   #先準備新增、修改、刪除temp table的SQL
   LET g_sql = "INSERT INTO ammt450_tmp1 (mmfeseq, mmfe011, mmfe001, mmfe003, mmfe006,",
               "                          mmfe004, mmfe005, mmfe007, mmfe010, mmfe012,",
               "                          mmfe013, mmcj011, mmcj012, mmcj007, mmci004)",
               "VALUES (?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?)"
   PREPARE ammt450_01_instmp1 FROM g_sql
   DECLARE ammt450_01_instmp1_curs CURSOR FOR ammt450_01_instmp1
   
   #計算已勾選的總點數
   LET g_sql = "SELECT SUM(mmci004) FROM ammt450_tmp1"
   PREPARE ammt450_01_mmci004 FROM g_sql
   DECLARE ammt450_01_mmci004_curs CURSOR FOR ammt450_01_mmci004
   
   #單一兌換比率 是否已有選擇一項兌換商品
   LET g_sql = "SELECT COUNT(*) FROM mmfe_t WHERE mmfeent = '",g_enterprise,"' AND mmfedocno = '",g_rtiadocno,"' AND mmfe011 != ?"
   PREPARE ammt450_01_count1 FROM g_sql
   DECLARE ammt450_01_count1_curs CURSOR FOR ammt450_01_count1
   
   LET g_sql = "SELECT COUNT(*) FROM ammt450_tmp1 WHERE mmfe011 != ?"
   PREPARE ammt450_01_count FROM g_sql
   DECLARE ammt450_01_count_curs CURSOR FOR ammt450_01_count
   
   LET g_sum_mmci004 = 0
   SELECT SUM(mmci004*mmfe007) INTO g_sum_mmci004
     FROM rtia_t,mmfe_t,mmbo_t,mmci_t
    WHERE rtiaent = g_enterprise
      AND rtiadocno = g_rtiadocno
      AND rtiaent = mmfeent
      AND rtiadocno = mmfedocno
      AND rtiaent = mmboent
      AND mmbo001 = rtia044
      AND mmbo002 = rtia045
      AND mmbostus = 'Y'
      AND mmboent = mmcient
      AND mmbodocno = mmcidocno
      AND mmfe011 = mmci003
      AND mmciacti = 'Y'
      AND (g_mmby024 = 'N'                              #160819-00054#14 161003 by lori add
        OR (g_mmby024 = 'Y' AND mmci006 = g_rtia066))   #160819-00054#14 161003 by lori add      
   IF cl_null(g_sum_mmci004) THEN
      LET g_sum_mmci004 = 0
   END IF

   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT ARRAY g_mmfe_d FROM s_detail1.*
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
            LET l_ac_t = 0
            
         BEFORE ROW
            LET l_ac = DIALOG.getCurrentRow("s_detail1")
            LET l_sel = ''
            LET g_mmfe007 = ''
            LET g_mmfe_d_o.* = g_mmfe_d[l_ac].*
            #ammt450_tmp1裡是否有此項次存在
            LET l_cnt = 0
            SELECT COUNT(*) INTO l_cnt
              FROM ammt450_tmp1
             WHERE mmfeseq = g_mmfe_d[l_ac].mmfeseq
            IF l_cnt = 0 THEN
               LET g_mmfe_d_t.sel = 'N'
            ELSE
               LET g_mmfe_d_t.sel = 'Y'
            END IF
            CALL ammt450_01_set_entry_b()
            CALL ammt450_01_set_no_entry_b()
            
         ON ROW CHANGE
            #ammt450_tmp1裡是否有此項次存在
            LET l_cnt = 0
            SELECT COUNT(*) INTO l_cnt
              FROM ammt450_tmp1
             WHERE mmfeseq = g_mmfe_d[l_ac].mmfeseq
            
            LET l_sum_mmci004 = g_mmci004 * g_mmfe_d[l_ac].mmfe007
            IF cl_null(l_sum_mmci004) THEN
               LET l_sum_mmci004 = 0
            END IF
            
            #(1)勾選(Y)且ammt450_tmp1裡沒資料　新增
            IF g_mmfe_d[l_ac].sel = 'Y' AND l_cnt = 0 THEN
               EXECUTE ammt450_01_instmp1_curs USING 
                  g_mmfe_d[l_ac].mmfeseq, g_mmfe_d[l_ac].mmfe011, g_mmfe_d[l_ac].mmfe001,
                  g_mmfe_d[l_ac].mmfe003, g_mmfe_d[l_ac].mmfe006, g_mmfe_d[l_ac].mmfe004,
                  g_mmfe_d[l_ac].mmfe005, g_mmfe_d[l_ac].mmfe007, g_mmfe_d[l_ac].mmfe010,
                  g_mmfe_d[l_ac].mmfe012, g_mmfe_d[l_ac].mmfe013, g_mmfe_d[l_ac].mmcj011,
                  g_mmfe_d[l_ac].mmcj012, g_mmfe_d[l_ac].mmcj007, l_sum_mmci004
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "Ins tmp1"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

               END IF
            END IF
            
            #(2)未勾選(N)且ammt450_tmp1裡有資料　刪除
            IF g_mmfe_d[l_ac].sel = 'N' AND l_cnt = 1 THEN
               DELETE FROM ammt450_tmp1
                WHERE mmfeseq = g_mmfe_d[l_ac].mmfeseq
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "Del tmp1"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

               END IF
            END IF
               
            #(3)勾選(Y)且ammt450_tmp1裡有資料，表示欄位輸入值有異動　修改
            IF l_sel = 'Y' AND g_mmfe_d[l_ac].sel = 'Y' AND l_cnt = 1 THEN
               UPDATE ammt450_tmp1
                  SET mmfe004 = g_mmfe_d[l_ac].mmfe004,
                      mmfe005 = g_mmfe_d[l_ac].mmfe005,
                      mmfe007 = g_mmfe_d[l_ac].mmfe007,
                      mmfe010 = g_mmfe_d[l_ac].mmfe010,
                      mmci004 = l_sum_mmci004
                WHERE mmfeseq = g_mmfe_d[l_ac].mmfeseq
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "Upd tmp1"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

               END IF
            END IF
            LET g_mmfe_d_t.* = g_mmfe_d[l_ac].*
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sel
            #add-point:BEFORE FIELD sel name="input.b.page1.sel"
            #紀錄原本sel的狀態
            LET l_sel = g_mmfe_d[l_ac].sel
            #先抓取規則編號+版本+兌換組別的兌換品種數(mmci005)
            CALL ammt450_01_mmci()
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sel
            
            #add-point:AFTER FIELD sel name="input.a.page1.sel"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sel
            #add-point:ON CHANGE sel name="input.g.page1.sel"
            #由已勾選變更為未勾選(Y->N)
            #把可以自行輸入的欄位都清空
            IF l_sel = 'Y' AND g_mmfe_d[l_ac].sel = 'N' THEN
               LET g_mmfe007 = g_mmfe_d[l_ac].mmfe007
               LET g_mmfe_d[l_ac].mmfe004 = ''
               LET g_mmfe_d[l_ac].mmfe005 = ''
               LET g_mmfe_d[l_ac].mmfe007 = ''
               LET g_mmfe_d[l_ac].mmfe010 = ''
               LET g_mmfe_d[l_ac].mmfe010_desc = ''
            END IF
            
            #由未勾選變更為已勾選(N->Y)
            #預設兌換品種數 = 1
            IF l_sel = 'N' AND g_mmfe_d[l_ac].sel = 'Y' THEN
               LET g_mmfe_d[l_ac].mmfe007 = 1
            
            
               #單一兌換比率 分段兌換比率控卡
               CALL ammt450_01_mmby010()
               IF NOT cl_null(g_errno) THEN
                  #換贈方式為分段兌換比例，兌換的累積金額不足，只可兌換等於小於%1的組別！
                  IF g_errno = 'amm-00282' THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'amm-00282'
                     LET g_errparam.extend = NULL
                     LET g_errparam.popup = TRUE
                     LET g_errparam.replace[1] = g_mmci003
                     CALL cl_err()

                  ELSE
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                  END IF
                  LET g_mmfe_d[l_ac].sel = 'N'
                  LET g_mmfe_d[l_ac].mmfe007 = ''
                  NEXT FIELD sel
               END IF
            END IF
            
            #檢查剩餘點數是否可以兌換此組別商品
            CALL ammt450_01_chk_count()
            IF NOT cl_null(g_errno) THEN
               INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

               LET g_mmfe_d[l_ac].sel = 'N'
               LET g_mmfe_d[l_ac].mmfe007 = ''
               NEXT FIELD sel
            END IF
            
            #檢查組別的兌換品種數
            IF g_mmfe_d_t.sel = 'N' AND g_mmfe_d[l_ac].sel = 'Y' THEN
               CALL ammt450_01_chk_groups_copies()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                  LET g_mmfe_d[l_ac].sel = 'N'
                  LET g_mmfe_d[l_ac].mmfe007 = ''
                  NEXT FIELD sel
               END IF
            END IF

            #檢查總兌換份數是否大於設定限制
            CALL ammt450_01_chk_copies()
            IF NOT cl_null(g_errno) THEN
               #已超出上限名額,是否確認兌換(Y/N)?
               IF cl_ask_confirm(g_errno) THEN
                  LET g_mmfe_d[l_ac].mmfe007 = 1
               ELSE
                  LET g_mmfe_d[l_ac].sel = 'N'
                  LET g_mmfe_d[l_ac].mmfe007 = ''
                  NEXT FIELD sel
               END IF
            END IF
            CALL ammt450_01_recount()
            CALL ammt450_01_set_entry_b()
            CALL ammt450_01_set_no_entry_b()
            LET g_mmfe_d_o.mmfe007 = g_mmfe_d[l_ac].mmfe007
            LET l_sel = g_mmfe_d[l_ac].sel
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmfe004
            #add-point:BEFORE FIELD mmfe004 name="input.b.page1.mmfe004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmfe004
            
            #add-point:AFTER FIELD mmfe004 name="input.a.page1.mmfe004"
            IF NOT cl_null(g_mmfe_d[l_ac].mmfe004) THEN
               IF g_mmfe_d[l_ac].mmfe004 != g_mmfe_d_o.mmfe004 OR cl_null(g_mmfe_d_o.mmfe004) THEN
                  IF g_mmfe_d[l_ac].mmfe012 = 'M' THEN
                     CALL ammt450_01_chk_mman(g_mmfe_d[l_ac].mmfe004,g_mmfe_d[l_ac].mmfe005)
                     IF NOT cl_null(g_errno) THEN
                        CASE g_errno
                           #輸入的券號與券種編號：％１的固定代碼不相同！
                           WHEN 'amm-00284'
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = g_errno
                              LET g_errparam.extend = NULL
                              LET g_errparam.popup = TRUE
                              CALL cl_err()

                           #輸入的卡號與卡種編號：%１的固定代碼不相同！
                           WHEN 'amm-00285'
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = g_errno
                              LET g_errparam.extend = NULL
                              LET g_errparam.popup = TRUE
                              CALL cl_err()

                           #卡號的長度不符合卡種：%1的設定長度！
                           WHEN 'amm-00286'
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = g_errno
                              LET g_errparam.extend = NULL
                              LET g_errparam.popup = TRUE
                              CALL cl_err()

                           #此會員卡號：%1不存在 會員卡資料檔 中
                           WHEN 'amm-00291'
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = g_errno
                              LET g_errparam.extend = NULL
                              LET g_errparam.popup = TRUE
                              CALL cl_err()

                           #此會員卡號：%1的狀態不屬於發卡！
                           WHEN 'amm-00292'
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = g_errno
                              LET g_errparam.extend = NULL
                              LET g_errparam.popup = TRUE
                              CALL cl_err()

                           OTHERWISE
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = g_errno
                              LET g_errparam.extend = ''
                              LET g_errparam.popup = TRUE
                              CALL cl_err()

                        END CASE
                        LET g_mmfe_d[l_ac].mmfe004 = g_mmfe_d_o.mmfe004
                        NEXT FIELD mmfe004
                     END IF
                  END IF
                  IF g_mmfe_d[l_ac].mmfe012 = 'N' THEN
                     CALL ammt450_01_chk_gcaf(g_mmfe_d[l_ac].mmfe004,g_mmfe_d[l_ac].mmfe005)
                     IF NOT cl_null(g_errno) THEN
                        CASE g_errno
                           #輸入的券號與券種編號：％１的固定代碼不相同！
                           WHEN 'amm-00284'
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = g_errno
                              LET g_errparam.extend = NULL
                              LET g_errparam.popup = TRUE
                              CALL cl_err()

                           #輸入的券號不介於起始券號：%1~結束券號：%2！
                           WHEN 'amm-00283'
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = g_errno
                              LET g_errparam.extend = NULL
                              LET g_errparam.popup = TRUE
                              CALL cl_err()

                           #此券號：%1不存在 券種基本資料 中！
                           WHEN 'amm-00293'
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = g_errno
                              LET g_errparam.extend = NULL
                              LET g_errparam.popup = TRUE
                              CALL cl_err()

                           #此券號：%1的狀態不屬於發行！
                           WHEN 'amm-00294'
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = g_errno
                              LET g_errparam.extend = NULL
                              LET g_errparam.popup = TRUE
                              CALL cl_err()

                           OTHERWISE
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = g_errno
                              LET g_errparam.extend = ''
                              LET g_errparam.popup = TRUE
                              CALL cl_err()

                        END CASE
                        LET g_mmfe_d[l_ac].mmfe004 = g_mmfe_d_o.mmfe004
                        NEXT FIELD mmfe004
                     END IF
                  END IF
                  IF cl_null(g_mmfe_d[l_ac].mmfe005) THEN
                     LET g_mmfe_d[l_ac].mmfe005 = g_mmfe_d[l_ac].mmfe004
                  END IF
                  
                  #檢查剩餘點數是否可以兌換此組別商品
                  CALL ammt450_01_chk_count()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = g_errno
                              LET g_errparam.extend = ''
                              LET g_errparam.popup = TRUE
                              CALL cl_err()

                     LET g_mmfe_d[l_ac].mmfe004 = g_mmfe_d_o.mmfe004
                     LET g_mmfe_d[l_ac].mmfe007 = g_mmfe_d_o.mmfe007
                     NEXT FIELD mmfe004
                  END IF
                  
                  #檢查組別的兌換品種數
                  CALL ammt450_01_chk_groups_copies()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = g_errno
                              LET g_errparam.extend = ''
                              LET g_errparam.popup = TRUE
                              CALL cl_err()

                     LET g_mmfe_d[l_ac].mmfe004 = g_mmfe_d_o.mmfe004
                     LET g_mmfe_d[l_ac].mmfe007 = g_mmfe_d_o.mmfe007
                     NEXT FIELD mmfe004
                  END IF
			      
                  #檢查總兌換份數是否大於設定限制
                  CALL ammt450_01_chk_copies()
                  IF NOT cl_null(g_errno) THEN
                     #已超出上限名額,是否確認兌換(Y/N)?
                     IF NOT cl_ask_confirm(g_errno) THEN
                        LET g_mmfe_d[l_ac].mmfe004 = g_mmfe_d_o.mmfe004
                        LET g_mmfe_d[l_ac].mmfe007 = g_mmfe_d_o.mmfe007
                        NEXT FIELD mmfe004
                     END IF
                  END IF
                  
               END IF
            END IF
            CALL ammt450_01_recount()
            LET g_mmfe_d_o.mmfe004 = g_mmfe_d[l_ac].mmfe004
            LET g_mmfe_d_o.mmfe005 = g_mmfe_d[l_ac].mmfe005
            LET g_mmfe_d_o.mmfe007 = g_mmfe_d[l_ac].mmfe007
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmfe004
            #add-point:ON CHANGE mmfe004 name="input.g.page1.mmfe004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmfe005
            #add-point:BEFORE FIELD mmfe005 name="input.b.page1.mmfe005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmfe005
            
            #add-point:AFTER FIELD mmfe005 name="input.a.page1.mmfe005"
            IF NOT cl_null(g_mmfe_d[l_ac].mmfe005) THEN
               IF g_mmfe_d[l_ac].mmfe005 != g_mmfe_d_o.mmfe005 OR cl_null(g_mmfe_d_o.mmfe005) THEN
                  IF g_mmfe_d[l_ac].mmfe012 = 'M' THEN
                     CALL ammt450_01_chk_mman(g_mmfe_d[l_ac].mmfe004,g_mmfe_d[l_ac].mmfe005)
                     IF NOT cl_null(g_errno) THEN
                        CASE g_errno
                           #輸入的券號與券種編號：%１的固定代碼不相同！
                           WHEN 'amm-00284'
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = g_errno
                              LET g_errparam.extend = NULL
                              LET g_errparam.popup = TRUE
                              CALL cl_err()

                           #輸入的卡號與卡種編號：%１的固定代碼不相同！
                           WHEN 'amm-00285'
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = g_errno
                              LET g_errparam.extend = NULL
                              LET g_errparam.popup = TRUE
                              CALL cl_err()

                           #卡號的長度不符合卡種：%1的設定長度！
                           WHEN 'amm-00286'
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = g_errno
                              LET g_errparam.extend = NULL
                              LET g_errparam.popup = TRUE
                              CALL cl_err()

                           WHEN 'amm-00291'
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = g_errno
                              LET g_errparam.extend = NULL
                              LET g_errparam.popup = TRUE
                              CALL cl_err()

                           #此會員卡號：%1的狀態不屬於發卡！
                           WHEN 'amm-00292'
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = g_errno
                              LET g_errparam.extend = NULL
                              LET g_errparam.popup = TRUE
                              CALL cl_err()

                           OTHERWISE
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = g_errno
                              LET g_errparam.extend = ''
                              LET g_errparam.popup = TRUE
                              CALL cl_err()

                        END CASE
                        LET g_mmfe_d[l_ac].mmfe005 = g_mmfe_d_o.mmfe005
                        NEXT FIELD mmfe005
                     END IF
                  END IF
                  IF g_mmfe_d[l_ac].mmfe012 = 'N' THEN
                     CALL ammt450_01_chk_gcaf(g_mmfe_d[l_ac].mmfe004,g_mmfe_d[l_ac].mmfe005)
                     IF NOT cl_null(g_errno) THEN
                         CASE g_errno
                           #輸入的券號與券種編號：％１的固定代碼不相同！
                           WHEN 'amm-00284'
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = g_errno
                              LET g_errparam.extend = NULL
                              LET g_errparam.popup = TRUE
                              CALL cl_err()

                           #輸入的券號不介於起始券號：%1~結束券號：%2！
                           WHEN 'amm-00283'
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = g_errno
                              LET g_errparam.extend = NULL
                              LET g_errparam.popup = TRUE
                              CALL cl_err()
                           
                           #160518-00071#1 20160520 add by beckxie---S
                           WHEN 'amm-00294'
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = g_errno
                              LET g_errparam.extend = NULL
                              LET g_errparam.popup = TRUE
                              LET g_errparam.replace[1] = g_err_str
                              CALL cl_err()
                           #160518-00071#1 20160520 add by beckxie---E
                           OTHERWISE
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = g_errno
                              LET g_errparam.extend = ''
                              LET g_errparam.popup = TRUE
                              CALL cl_err()

                        END CASE
                        LET g_mmfe_d[l_ac].mmfe005 = g_mmfe_d_o.mmfe005
                        NEXT FIELD mmfe005
                     END IF
                  END IF
                  
                  #檢查剩餘點數是否可以兌換此組別商品
                  CALL ammt450_01_chk_count()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = g_errno
                              LET g_errparam.extend = ''
                              LET g_errparam.popup = TRUE
                              CALL cl_err()

                     LET g_mmfe_d[l_ac].mmfe005 = g_mmfe_d_o.mmfe005
                     LET g_mmfe_d[l_ac].mmfe007 = g_mmfe_d_o.mmfe007
                     NEXT FIELD mmfe005
                  END IF
                  
                  #檢查組別的兌換品種數
                  CALL ammt450_01_chk_groups_copies()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = g_errno
                              LET g_errparam.extend = ''
                              LET g_errparam.popup = TRUE
                              CALL cl_err()

                     LET g_mmfe_d[l_ac].mmfe005 = g_mmfe_d_o.mmfe005
                     LET g_mmfe_d[l_ac].mmfe007 = g_mmfe_d_o.mmfe007
                     NEXT FIELD mmfe005
                  END IF
			      
                  #檢查總兌換份數是否大於設定限制
                  CALL ammt450_01_chk_copies()
                  IF NOT cl_null(g_errno) THEN
                     #已超出上限名額,是否確認兌換(Y/N)?
                     IF NOT cl_ask_confirm(g_errno) THEN
                        LET g_mmfe_d[l_ac].mmfe005 = g_mmfe_d_o.mmfe005
                        LET g_mmfe_d[l_ac].mmfe007 = g_mmfe_d_o.mmfe007
                        NEXT FIELD mmfe005
                     END IF
                  END IF
                  
               END IF
            END IF
            CALL ammt450_01_recount()
            LET g_mmfe_d_o.mmfe005 = g_mmfe_d[l_ac].mmfe005
            LET g_mmfe_d_o.mmfe007 = g_mmfe_d[l_ac].mmfe007
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmfe005
            #add-point:ON CHANGE mmfe005 name="input.g.page1.mmfe005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmfe007
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mmfe_d[l_ac].mmfe007,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD mmfe007
            END IF 
 
 
 
            #add-point:AFTER FIELD mmfe007 name="input.a.page1.mmfe007"
            IF NOT cl_null(g_mmfe_d[l_ac].mmfe007) THEN
               IF g_mmfe_d[l_ac].mmfe007 != g_mmfe_d_o.mmfe007 OR cl_null(g_mmfe_d_o.mmfe007) THEN
                  #檢查剩餘點數是否可以兌換此組別商品
                  CALL ammt450_01_chk_count()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_mmfe_d[l_ac].mmfe007 = g_mmfe_d_o.mmfe007
                     NEXT FIELD mmfe007
                  END IF
                  
                  #檢查組別的兌換品種數
                  CALL ammt450_01_chk_groups_copies()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_mmfe_d[l_ac].mmfe007 = g_mmfe_d_o.mmfe007
                     NEXT FIELD mmfe007
                  END IF
			      
                  #檢查總兌換份數是否大於設定限制
                  CALL ammt450_01_chk_copies()
                  IF NOT cl_null(g_errno) THEN
                     #已超出上限名額,是否確認兌換(Y/N)?
                     IF NOT cl_ask_confirm(g_errno) THEN
                        #LET g_mmfe_d[l_ac].mmfe007 = 1
                     END IF
                     LET g_mmfe_d[l_ac].mmfe007 = g_mmfe_d_o.mmfe007
                     NEXT FIELD mmfe007
                  END IF
                  
               END IF
            END IF 
            CALL ammt450_01_recount()
            LET g_mmfe_d_o.mmfe007 = g_mmfe_d[l_ac].mmfe007

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmfe007
            #add-point:BEFORE FIELD mmfe007 name="input.b.page1.mmfe007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmfe007
            #add-point:ON CHANGE mmfe007 name="input.g.page1.mmfe007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmfe010
            
            #add-point:AFTER FIELD mmfe010 name="input.a.page1.mmfe010"
            LET g_mmfe_d[l_ac].mmfe010_desc = ' '
            DISPLAY BY NAME g_mmfe_d[l_ac].mmfe010_desc
            IF NOT cl_null(g_mmfe_d[l_ac].mmfe010) THEN
               IF g_mmfe_d[l_ac].mmfe010 != g_mmfe_d_o.mmfe010 OR cl_null(g_mmfe_d_o.mmfe010) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_rtia.rtiasite
                  LET g_chkparam.arg2 = g_mmfe_d[l_ac].mmfe010
                  #160318-00025#20  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
                  #160318-00025#20  by 07900 --add-end
                  IF NOT cl_chk_exist("v_inaa001") THEN
                     LET g_mmfe_d[l_ac].mmfe010 = g_mmfe_d_o.mmfe010
                     CALL ammt450_01_mmfe010_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL ammt450_01_mmfe010_ref()
            LET g_mmfe_d_o.mmfe010 = g_mmfe_d[l_ac].mmfe010

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmfe010
            #add-point:BEFORE FIELD mmfe010 name="input.b.page1.mmfe010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmfe010
            #add-point:ON CHANGE mmfe010 name="input.g.page1.mmfe010"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.sel
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sel
            #add-point:ON ACTION controlp INFIELD sel name="input.c.page1.sel"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmfe004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmfe004
            #add-point:ON ACTION controlp INFIELD mmfe004 name="input.c.page1.mmfe004"
            #160518-00071#1 20160520 add by beckxie---S
            CASE g_mmfe_d[l_ac].mmfe012
               WHEN 'M' #1.起始卡號開窗
                  #此段落由子樣板a07產生            
                  #開窗i段
			         INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
			         LET g_qryparam.reqry = FALSE
                  LET g_qryparam.default1 = g_mmfe_d[l_ac].mmfe004  #給予default值
                  
                  #給予arg
                  LET g_qryparam.arg1 = '1'
                  LET g_qryparam.where = " '",g_today,"' <= COALESCE(mmaq005,TO_DATE('",g_today,"','YY/MM/DD')) "
                  
                  CALL q_mmaq001_8()                                #呼叫開窗
                  LET g_mmfe_d[l_ac].mmfe004 = g_qryparam.return1        #將開窗取得的值回傳到變數
                  
                  DISPLAY g_mmfe_d[l_ac].mmfe004 TO mmfe004               #顯示到畫面上
                  NEXT FIELD mmfe004                          #返回原欄位
               WHEN 'N' #2.起始券號開窗
                  #此段落由子樣板a07產生            
                  #開窗i段
			         INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
			         LET g_qryparam.reqry = FALSE
                  LET g_qryparam.default1 = g_mmfe_d[l_ac].mmfe004  #給予default值
                  
                  #給予arg
                  LET g_qryparam.arg1 = g_rtia.rtiasite
                  LET g_qryparam.where = " '",g_today,"' BETWEEN COALESCE(gcao008,TO_DATE('",g_today,"','YY/MM/DD')) ",
                                         "                   AND COALESCE(gcao009,TO_DATE('",g_today,"','YY/MM/DD')) "
                  CALL q_gcao001_1()                                #呼叫開窗
                  LET g_mmfe_d[l_ac].mmfe004 = g_qryparam.return1        #將開窗取得的值回傳到變數
                  
                  DISPLAY g_mmfe_d[l_ac].mmfe004 TO mmfe004               #顯示到畫面上
                  NEXT FIELD mmfe004                          #返回原欄位
            END CASE
            #160518-00071#1 20160520 add by beckxie---E
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmfe005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmfe005
            #add-point:ON ACTION controlp INFIELD mmfe005 name="input.c.page1.mmfe005"
            #160518-00071#1 20160520 add by beckxie---S
            CASE g_mmfe_d[l_ac].mmfe012
               WHEN 'M' #1.截止卡號開窗
                  #此段落由子樣板a07產生            
                  #開窗i段
			         INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
			         LET g_qryparam.reqry = FALSE
                  LET g_qryparam.default1 = g_mmfe_d[l_ac].mmfe005  #給予default值
                  
                  #給予arg
                  LET g_qryparam.arg1 = '1'
                  LET g_qryparam.where = " '",g_today,"' <= COALESCE(mmaq005,TO_DATE('",g_today,"','YY/MM/DD')) "
                  CALL q_mmaq001_8()                                #呼叫開窗
                  LET g_mmfe_d[l_ac].mmfe005 = g_qryparam.return1        #將開窗取得的值回傳到變數
                  
                  DISPLAY g_mmfe_d[l_ac].mmfe005 TO mmfe005               #顯示到畫面上
                  NEXT FIELD mmfe005                          #返回原欄位
               WHEN 'N' #2.截止券號開窗
                  #此段落由子樣板a07產生            
                  #開窗i段
			         INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
			         LET g_qryparam.reqry = FALSE
                  LET g_qryparam.default1 = g_mmfe_d[l_ac].mmfe005  #給予default值
                  
                  #給予arg
                  LET g_qryparam.arg1 = g_rtia.rtiasite
                  LET g_qryparam.where = " '",g_today,"' BETWEEN COALESCE(gcao008,TO_DATE('",g_today,"','YY/MM/DD')) ",
                                         "                   AND COALESCE(gcao009,TO_DATE('",g_today,"','YY/MM/DD')) "
                  CALL q_gcao001_1()                                #呼叫開窗
                  LET g_mmfe_d[l_ac].mmfe005 = g_qryparam.return1        #將開窗取得的值回傳到變數
                  
                  DISPLAY g_mmfe_d[l_ac].mmfe005 TO mmfe005               #顯示到畫面上
                  NEXT FIELD mmfe005                          #返回原欄位
            END CASE
            #160518-00071#1 20160520 add by beckxie---E
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmfe007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmfe007
            #add-point:ON ACTION controlp INFIELD mmfe007 name="input.c.page1.mmfe007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmfe010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmfe010
            #add-point:ON ACTION controlp INFIELD mmfe010 name="input.c.page1.mmfe010"
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mmfe_d[l_ac].mmfe010  #給予default值
            
            #給予arg
            LET g_qryparam.arg1 = g_rtia.rtiasite
            CALL q_inaa001_6()                                #呼叫開窗
            LET g_mmfe_d[l_ac].mmfe010 = g_qryparam.return1        #將開窗取得的值回傳到變數
            
            DISPLAY g_mmfe_d[l_ac].mmfe010 TO mmfe010               #顯示到畫面上
            CALL ammt450_01_mmfe010_ref()
            NEXT FIELD mmfe010                          #返回原欄位
            #END add-point
 
 
 
 
         #自訂ACTION
         #add-point:單身其他段落處理(EX:on row change, etc...) name="input.other"
         
         #end add-point
 
         AFTER INPUT
            #add-point:單身輸入後處理 name="input.after_input"
            IF g_mmby010 = '2' THEN
               CALL ammt450_01_chk_sel()
               IF NOT cl_null(g_errno) THEN
                  NEXT FIELD sel
               END IF
            END IF
            #end add-point
            
      END INPUT
      
 
      
      #add-point:自定義input name="input.more_input"
      #顯示符合換贈組別單身的資料
      DISPLAY ARRAY g_mmci_d TO s_detail2.* 
      END DISPLAY
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
   CLOSE WINDOW w_ammt450_01 
   
   #add-point:input段after input name="input.post_input"
   #按下確認後
   IF NOT INT_FLAG THEN
      CALL ammt450_01_ins_mmfe()
      
      UPDATE rtia_t SET rtia031 = (SELECT SUM(rtib021)
                                    FROM rtib_t
                                   WHERE rtibent = g_enterprise
                                     AND rtibdocno = g_rtiadocno)
      WHERE rtiaent = g_enterprise
        AND rtiadocno = g_rtiadocno
   END IF
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="ammt450_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="ammt450_01.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 由規則編號+版本帶出mmby table的欄位
# Memo...........:
# Usage..........: CALL ammt450_01_carry_mmby()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/19 By pomelo
# Modify.........: 2016/10/03 By lori      新增mmby024
################################################################################
PUBLIC FUNCTION ammt450_01_carry_mmby()
   LET g_mmby009 = ''
   LET g_mmby010 = ''
   LET g_mmby011 = ''
   LET g_mmby012 = ''
   LET g_mmby024 = ''   #160819-00054#14 161003 by lori add
   
   SELECT mmby009,mmby010,mmby011,mmby012,mmby024             #160819-00054#14 161003 by lori add:mmby024
     INTO g_mmby009,g_mmby010,g_mmby011,g_mmby012,g_mmby024   #160819-00054#14 161003 by lori add:mmby024
     FROM mmby_t
    WHERE mmby001 = g_rtia.rtia044
      AND mmby002 = g_rtia.rtia045
      AND mmbyent = g_enterprise
      AND mmbysite = g_rtia.rtiasite
      AND mmbystus = 'Y'

   DISPLAY g_mmby009,g_mmby010,g_mmby011,g_mmby012
        TO mmby009,mmby010,mmby011,mmby012
END FUNCTION
################################################################################
# Descriptions...: 畫面給值
# Memo...........:
# Usage..........: CALL ammt450_01_tovalue()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/19 By pomelo
# Modify.........: 2016/10/03 By lori     新增rtia066
################################################################################
PUBLIC FUNCTION ammt450_01_tovalue()
   DEFINE l_mmfe007        LIKE mmfe_t.mmfe007

   INITIALIZE g_rtia.* TO NULL
   LET g_rtia066 = ''   #160819-00054#14 161003 by lori add
   
   SELECT rtiasite,rtiadocdt,rtia001,rtia026,rtia027,rtia042,
          rtia043, rtia044,  rtia045,rtia046,rtia047,rtia066        #160819-00054#14 161003 by lori add:rtia066
     INTO g_rtia.rtiasite,g_rtia.rtiadocdt,g_rtia.rtia001,g_rtia.rtia026,g_rtia.rtia027,g_rtia.rtia042,
          g_rtia.rtia043, g_rtia.rtia044,  g_rtia.rtia045,g_rtia.rtia046,g_rtia.rtia047,g_rtia066         #160819-00054#14 161003 by lori add:rtia066
     FROM rtia_t
    WHERE rtiaent = g_enterprise
      AND rtiadocno = g_rtiadocno

   IF cl_null(g_rtia.rtia047) THEN
      LET g_rtia.rtia047 = 0   
   END IF
   #160705-00042#11 160714 by sakura mark(S)   
   #CASE g_prog
   #   WHEN 'ammt450'
   #160705-00042#11 160714 by sakura mark(E)
   #160705-00042#11 160714 by sakura add(S)
   CASE 
      WHEN g_prog MATCHES 'ammt450'
   #160705-00042#11 160714 by sakura add(E)      
         LET g_rtia.rtia0471 = g_rtia.rtia043 - g_rtia.rtia047
      OTHERWISE
         LET g_rtia.rtia0471 = g_rtia.rtia046 - g_rtia.rtia047
   END CASE
   #LET g_rtia.rtia0471 = g_rtia.rtia043 - g_rtia.rtia047

   LET l_mmfe007 = 0
   SELECT SUM(mmfe007) INTO l_mmfe007
     FROM mmfe_t,rtia_t
    WHERE rtiaent = mmfeent
      AND rtiadocno = mmfedocno
      AND rtia044 = g_rtia.rtia044
      AND rtiastus != 'X'
   IF cl_null(l_mmfe007) THEN
      LET l_mmfe007 = 0
   END IF
   LET g_rtia.rtia0461 = l_mmfe007
   
   DISPLAY BY NAME g_rtia.rtia046,g_rtia.rtia047,g_rtia.rtia0461,g_rtia.rtia0471
   CALL ammt450_01_carry_mmby()
END FUNCTION
################################################################################
# Descriptions...: 資料編號帶出說明
# Memo...........:
# Usage..........: CALL ammt450_01_mmfe013_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/19 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt450_01_mmfe013_ref()
DEFINE l_oocq001   LIKE oocq_t.oocq001

   IF cl_null(g_mmfe_d[l_ac].mmfe012) THEN
      RETURN
   END IF
   LET l_oocq001 = ''
   CASE g_mmfe_d[l_ac].mmfe012
      WHEN '6'
         LET l_oocq001 = '2000'
      WHEN '7'
         LET l_oocq001 = '2001'
      WHEN '8'
         LET l_oocq001 = '2002'
      WHEN '9'
         LET l_oocq001 = '2003'
      WHEN 'A'
         LET l_oocq001 = '2004'
      WHEN 'B'
         LET l_oocq001 = '2005'
      WHEN 'C'
         LET l_oocq001 = '2006'
      WHEN 'D'
         LET l_oocq001 = '2007'
      WHEN 'E'
         LET l_oocq001 = '2008'
      WHEN 'F'
         LET l_oocq001 = '2009'
      WHEN 'G'
         LET l_oocq001 = '2010'
      WHEN 'H'
         LET l_oocq001 = '2011'
      WHEN 'I'
         LET l_oocq001 = '2012'
      WHEN 'J'
         LET l_oocq001 = '2013'
      WHEN 'K'
         LET l_oocq001 = '2014'
      WHEN 'L'
         LET l_oocq001 = '2015'
   END CASE
   LET g_mmfe_d[l_ac].mmfe013_desc = ''
   CASE g_mmfe_d[l_ac].mmfe012
      WHEN '4'
         SELECT imaal003 INTO g_mmfe_d[l_ac].mmfe013_desc
           FROM imaal_t
          WHERE imaalent = g_enterprise AND imaal001 = g_mmfe_d[l_ac].mmfe013 AND imaal002 = g_dlang
      WHEN '5'
         SELECT rtaxl003 INTO g_mmfe_d[l_ac].mmfe013_desc
           FROM rtaxl_t
          WHERE rtaxlent = g_enterprise AND rtaxl001 = g_mmfe_d[l_ac].mmfe013 AND rtaxl002 = g_dlang
      WHEN 'M'
         SELECT mmanl003 INTO g_mmfe_d[l_ac].mmfe013_desc
           FROM mmanl_t
          WHERE mmanlent = g_enterprise AND mmanl001 = g_mmfe_d[l_ac].mmfe013 AND mmanl002 = g_dlang
      WHEN 'N'
         SELECT gcafl003 INTO g_mmfe_d[l_ac].mmfe013_desc
           FROM gcafl_t
          WHERE gcaflent = g_enterprise AND gcafl001 = g_mmfe_d[l_ac].mmfe013 AND gcafl002 = g_dlang
      WHEN 'O'
         LET g_mmfe_d[l_ac].mmfe013_desc = ''
      WHEN 'P'
         SELECT imaal003 INTO g_mmfe_d[l_ac].mmfe013_desc
           FROM imaal_t
          WHERE imaalent = g_enterprise AND imaal001 = g_mmfe_d[l_ac].mmfe013 AND imaal002 = g_dlang
      OTHERWISE
         SELECT oocql004 INTO g_mmfe_d[l_ac].mmfe013_desc
           FROM oocql_t
          WHERE oocqlent = g_enterprise AND oocql001 = l_oocq001
            AND oocql002 = g_mmfe_d[l_ac].mmfe013 AND oocql003 = g_dlang
   END CASE
END FUNCTION
################################################################################
# Descriptions...: 先準備各資料類型的SQL
# Memo...........:
# Usage..........: CALL ammt450_01_mmfe012_pre()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/19 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt450_01_mmfe012_pre()
   #資料類型 = 5.商品分類(imaa009)
   LET g_sql = "SELECT imaa001 FROM imaa_t WHERE imaaent = ",g_enterprise," AND imaa009 = ? AND imaastus = 'Y'"
   PREPARE ammt450_01_imaa009 FROM g_sql
   DECLARE ammt450_01_imaa009_curs CURSOR FOR ammt450_01_imaa009
   
   #資料類型 = 6.產地分類(imaa122)
   LET g_sql = "SELECT imaa001 FROM imaa_t WHERE imaaent = ",g_enterprise," AND imaa122 = ? AND imaastus = 'Y'"
   PREPARE ammt450_01_imaa122 FROM g_sql
   DECLARE ammt450_01_imaa122_curs CURSOR FOR ammt450_01_imaa122
   
   #資料類型 = 7.價格帶(imaa131)
   LET g_sql = "SELECT imaa001 FROM imaa_t WHERE imaaent = ",g_enterprise," AND imaa131 = ? AND imaastus = 'Y'"
   PREPARE ammt450_01_imaa131 FROM g_sql
   DECLARE ammt450_01_imaa131_curs CURSOR FOR ammt450_01_imaa131
   
   #資料類型 = 8.品牌(imaa126)
   LET g_sql = "SELECT imaa001 FROM imaa_t WHERE imaaent = ",g_enterprise," AND imaa126 = ? AND imaastus = 'Y'"
   PREPARE ammt450_01_imaa126 FROM g_sql
   DECLARE ammt450_01_imaa126_curs CURSOR FOR ammt450_01_imaa126
   
   #資料類型 = 9.系列(imaa127)
   LET g_sql = "SELECT imaa001 FROM imaa_t WHERE imaaent = ",g_enterprise," AND imaa127 = ? AND imaastus = 'Y'"
   PREPARE ammt450_01_imaa127 FROM g_sql
   DECLARE ammt450_01_imaa127_curs CURSOR FOR ammt450_01_imaa127
   
   #資料類型 = A.型別(imaa128)
   LET g_sql = "SELECT imaa001 FROM imaa_t WHERE imaaent = ",g_enterprise," AND imaa128 = ? AND imaastus = 'Y'"
   PREPARE ammt450_01_imaa128 FROM g_sql
   DECLARE ammt450_01_imaa128_curs CURSOR FOR ammt450_01_imaa128
   
   #資料類型 = B.功能(imaa129)
   LET g_sql = "SELECT imaa001 FROM imaa_t WHERE imaaent = ",g_enterprise," AND imaa129 = ? AND imaastus = 'Y'"
   PREPARE ammt450_01_imaa129 FROM g_sql
   DECLARE ammt450_01_imaa129_curs CURSOR FOR ammt450_01_imaa129
   
   #資料類型 = C.其他屬性一(imaa132)
   LET g_sql = "SELECT imaa001 FROM imaa_t WHERE imaaent = ",g_enterprise," AND imaa132 = ? AND imaastus = 'Y'"
   PREPARE ammt450_01_imaa132 FROM g_sql
   DECLARE ammt450_01_imaa132_curs CURSOR FOR ammt450_01_imaa132
   
   #資料類型 = D.其他屬性二(imaa133)
   LET g_sql = "SELECT imaa001 FROM imaa_t WHERE imaaent = ",g_enterprise," AND imaa133 = ? AND imaastus = 'Y'"
   PREPARE ammt450_01_imaa133 FROM g_sql
   DECLARE ammt450_01_imaa133_curs CURSOR FOR ammt450_01_imaa133
   
   #資料類型 = E.其他屬性三(imaa134)
   LET g_sql = "SELECT imaa001 FROM imaa_t WHERE imaaent = '",g_enterprise,"' AND imaa134 = ? AND imaastus = 'Y'"
   PREPARE ammt450_01_imaa134 FROM g_sql
   DECLARE ammt450_01_imaa134_curs CURSOR FOR ammt450_01_imaa134
   
   #資料類型 = F.其他屬性四(imaa135)
   LET g_sql = "SELECT imaa001 FROM imaa_t WHERE imaaent = ",g_enterprise," AND imaa135 = ? AND imaastus = 'Y'"
   PREPARE ammt450_01_imaa135 FROM g_sql
   DECLARE ammt450_01_imaa135_curs CURSOR FOR ammt450_01_imaa135
   
   #資料類型 = G.其他屬性五(imaa136)
   LET g_sql = "SELECT imaa001 FROM imaa_t WHERE imaaent = ",g_enterprise," AND imaa136 = ? AND imaastus = 'Y'"
   PREPARE ammt450_01_imaa136 FROM g_sql
   DECLARE ammt450_01_imaa136_curs CURSOR FOR ammt450_01_imaa136
   
   #資料類型 = H.其他屬性六(imaa137)
   LET g_sql = "SELECT imaa001 FROM imaa_t WHERE imaaent = '",g_enterprise,"' AND imaa137 = ? AND imaastus = 'Y'"
   PREPARE ammt450_01_imaa137 FROM g_sql
   DECLARE ammt450_01_imaa137_curs CURSOR FOR ammt450_01_imaa131
   
   #資料類型 = I.其他屬性七(imaa138)
   LET g_sql = "SELECT imaa001 FROM imaa_t WHERE imaaent = ",g_enterprise," AND imaa138 = ? AND imaastus = 'Y'"
   PREPARE ammt450_01_imaa138 FROM g_sql
   DECLARE ammt450_01_imaa138_curs CURSOR FOR ammt450_01_imaa138
   
   #資料類型 = J.其他屬性八(imaa139)
   LET g_sql = "SELECT imaa001 FROM imaa_t WHERE imaaent = ",g_enterprise," AND imaa139 = ? AND imaastus = 'Y'"
   PREPARE ammt450_01_imaa139 FROM g_sql
   DECLARE ammt450_01_imaa139_curs CURSOR FOR ammt450_01_imaa139
   
   #資料類型 = K.其他屬性九(imaa140)
   LET g_sql = "SELECT imaa001 FROM imaa_t WHERE imaaent = ",g_enterprise," AND imaa140 = ? AND imaastus = 'Y'"
   PREPARE ammt450_01_imaa140 FROM g_sql
   DECLARE ammt450_01_imaa140_curs CURSOR FOR ammt450_01_imaa140
   
   #資料類型 = L.其他屬性十(imaa141)
   LET g_sql = "SELECT imaa001 FROM imaa_t WHERE imaaent = ",g_enterprise," AND imaa141 = ? AND imaastus = 'Y'"
   PREPARE ammt450_01_imaa141 FROM g_sql
   DECLARE ammt450_01_imaa141_curs CURSOR FOR ammt450_01_imaa141

   #資料類型 = M.卡(mman001)抓卡種對應 卡種對應商品編號(mman053)
   LET g_sql = "SELECT mman053 FROM mman_t WHERE mmanent = ",g_enterprise," AND mman001 = ? AND mmanstus = 'Y'"
   PREPARE ammt450_01_mman053 FROM g_sql
   DECLARE ammt450_01_mman053_curs CURSOR FOR ammt450_01_mman053

   #資料類型 = N.券(gcaf001) 抓券對應 券對應商品編號(gcaf013)、券面額編號(gcaf012)
   LET g_sql = "SELECT gcaf013,gcaf012 FROM gcaf_t WHERE gcafent = ",g_enterprise," AND gcaf001 = ? AND gcafstus = 'Y'"
   PREPARE ammt450_01_gcaf013 FROM g_sql
   DECLARE ammt450_01_gcaf013_curs CURSOR FOR ammt450_01_gcaf013
   
   #資料類型 = O.積點(mman001) 抓積點對應商品編號(mman060)
   LET g_sql = "SELECT mman060 FROM mman_t WHERE mmanent = ",g_enterprise," AND mman001 = ? AND mmanstus = 'Y'"
   PREPARE ammt450_01_mman060 FROM g_sql
   DECLARE ammt450_01_mman060_curs CURSOR FOR ammt450_01_mman060
   
   #資料類型 = P.送抵現值(mman001) 抓儲值金額對應商品編號(mman054)
   LET g_sql = "SELECT mman054 FROM mman_t WHERE mmanent = ",g_enterprise," AND mman001 = ? AND mmanstus = 'Y'"
   PREPARE ammt450_01_mman054 FROM g_sql
   DECLARE ammt450_01_mman054_curs CURSOR FOR ammt450_01_mman054

   #判斷是否存在門店商品清單中
   LET g_sql = "SELECT COUNT(*) FROM rtdx_t WHERE rtdxent = ",g_enterprise," AND rtdxsite = '",g_rtia.rtiasite,"' AND rtdx001 = ? AND rtdxstus = 'Y'"
   PREPARE ammt450_01_rtdx FROM g_sql
   DECLARE ammt450_01_rtdx_curs CURSOR FOR ammt450_01_rtdx
   
   #160604-00009#47 Add By Ken 160615(S)
   #取商品在門店清單的庫位
   LET g_sql = "SELECT rtdx044 FROM rtdx_t ",
               " WHERE rtdxent = ",g_enterprise,
               "   AND rtdxsite = '",g_rtia.rtiasite,"' ",
               "   AND rtdx001 = ? AND rtdxstus = 'Y'"
   PREPARE ammt450_01_rtdx044 FROM g_sql 
   #160604-00009#47 Add By Ken 160615(E)   
END FUNCTION
################################################################################
# Descriptions...: 單身給值
# Memo...........:
# Usage..........: CALL ammt450_01_btovalue()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/19 By pomelo
# Modify.........: 2016/10/03 By lori      160819-00054#14 
################################################################################
PUBLIC FUNCTION ammt450_01_btovalue()
DEFINE l_ooef124      LIKE ooef_t.ooef124
DEFINE l_cnt          LIKE type_t.num5
DEFINE l_n            LIKE type_t.num5
DEFINE l_imaa001      LIKE imaa_t.imaa001
DEFINE l_gcaf012      LIKE gcaf_t.gcaf012
DEFINE l_gcaf013      LIKE gcaf_t.gcaf013
DEFINE l_mman053      LIKE mman_t.mman053
DEFINE l_mmfe         RECORD
       mmfeseq        LIKE mmfe_t.mmfeseq, 
       mmfe011        LIKE mmfe_t.mmfe011, 
       mmfe001        LIKE mmfe_t.mmfe001, 
       mmfe003        LIKE mmfe_t.mmfe003, 
       mmfe006        LIKE mmfe_t.mmfe006, 
       mmfe004        LIKE mmfe_t.mmfe004, 
       mmfe005        LIKE mmfe_t.mmfe005, 
       mmfe007        LIKE mmfe_t.mmfe007, 
       mmfe010        LIKE mmfe_t.mmfe010, 
       mmfe012        LIKE mmfe_t.mmfe012, 
       mmfe013        LIKE mmfe_t.mmfe013, 
       mmcj011        LIKE mmcj_t.mmcj011, 
       mmcj012        LIKE mmcj_t.mmcj012, 
       mmcj007        LIKE mmcj_t.mmcj007
                      END RECORD
DEFINE l_mmcj009      LIKE mmcj_t.mmcj009
DEFINE l_mmcj010      LIKE mmcj_t.mmcj010
DEFINE l_count        LIKE type_t.num5
DEFINE l_member       LIKE type_t.chr1     #是否為會員
   
   CALL g_mmfe_d.clear()
   CALL ammt450_01_mmfe012_pre()
   LET l_ooef124 = ''
   #庫位
   SELECT ooef124 INTO l_ooef124
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_rtia.rtiasite

   DELETE FROM ammt450_tmp;
   DELETE FROM ammt450_tmp1;
   LET g_sql = "SELECT UNIQUE '',mmcj003,'','','','','','','',",
               "              mmcj004,mmcj005,mmcj011,mmcj012,mmcj007,mmcj009,mmcj010",
               "  FROM mmci_t,mmcj_t,mmbo_t",
               " WHERE mmcjent = ?",
               "   AND mmcjent = mmboent",
               "   AND mmcjdocno = mmbodocno",
               "   AND mmcj003 <= ",g_mmci003,
               "   AND mmcient = mmcjent",
               "   AND mmcidocno = mmcjdocno",
               "   AND mmci003 = mmcj003",
               "   AND mmbo001 = '",g_rtia.rtia044,"'",
               "   AND mmbo002 = '",g_rtia.rtia045,"'",
               "   AND mmcjacti = 'Y'",
               "   AND mmciacti = 'Y'"   #,                #160819-00054$14 161003 by lori mark,
              #" ORDER BY mmcj_t.mmcj003,mmcj_t.mmcj012"   #160819-00054$14 161003 by lori mark
      #160819-00054#14 161003 By lori add---(S)
      IF g_mmby009 = '2' THEN
        IF g_mmby024 = 'Y' THEN
           LET g_sql = g_sql," AND mmci006 = '",g_rtia066,"' "
        END IF
      END IF
      
      LET g_sql = g_sql," ORDER BY mmcj_t.mmcj003,mmcj_t.mmcj012"
      #160819-00054#14 161003 By lori add---(E)                  
               
               
  
   PREPARE ammt450_01_btovalues FROM g_sql
   DECLARE ammt450_01_btovalues_curs CURSOR FOR ammt450_01_btovalues
   
   #先準備新增到temp的SQL
   OPEN ammt450_01_btovalues_curs USING g_enterprise
   LET g_sql = "INSERT INTO ammt450_tmp (mmfeseq, mmfe011, mmfe001, mmfe003,",
               "                         mmfe006, mmfe004, mmfe005, mmfe007, mmfe010,",
               "                         mmfe012, mmfe013, mmcj011, mmcj012, mmcj007)",
               "VALUES (?,?,?,?,?, ?,?,?,?,?, ?,?,?,?)"
   PREPARE ammt450_01_instmp FROM g_sql
   DECLARE ammt450_01_instmp_curs CURSOR FOR ammt450_01_instmp
   
   #判斷卡號是否有輸入，卡種編號是否為外社卡
   LET l_member = 'N'
   IF NOT cl_null(g_rtia.rtia001) AND NOT cl_null(g_rtia.rtia042) THEN
      LET l_n = 0
      SELECT COUNT(*) INTO l_n
        FROM mman_t
       WHERE mmanent = g_enterprise
         AND mman001 = g_rtia.rtia042
         AND mman003 = 'Y'
      IF l_n = 1 THEN
         LET l_member = 'Y'
      END IF
   END IF
   
   LET l_ac = 1
 
   FOREACH ammt450_01_btovalues_curs INTO g_mmfe_d[l_ac].mmfeseq,
       g_mmfe_d[l_ac].mmfe011, g_mmfe_d[l_ac].mmfe001, g_mmfe_d[l_ac].mmfe003,
       g_mmfe_d[l_ac].mmfe006, g_mmfe_d[l_ac].mmfe004, g_mmfe_d[l_ac].mmfe005,
       g_mmfe_d[l_ac].mmfe007, g_mmfe_d[l_ac].mmfe010, g_mmfe_d[l_ac].mmfe012,
       g_mmfe_d[l_ac].mmfe013, g_mmfe_d[l_ac].mmcj011, g_mmfe_d[l_ac].mmcj012,
       g_mmfe_d[l_ac].mmcj007,l_mmcj009,l_mmcj010
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      LET g_mmfe_d[l_ac].mmfeseq = l_ac
      
      IF l_member = 'Y' THEN
         LET g_mmfe_d[l_ac].mmfe006 = l_mmcj010
      ELSE
         LET g_mmfe_d[l_ac].mmfe006 = l_mmcj009
      END IF
      #LET g_mmfe_d[l_ac].mmfe010 = l_ooef124   #160604-00009#47 Mark By Ken 160615
            
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
      
   END FOREACH
   CALL g_mmfe_d.deleteElement(g_mmfe_d.getLength())
   
   LET l_n = 1
   #依不同資料類型的資料找出符合資料類型的商品編號
   FOR l_cnt = 1 TO g_mmfe_d.getLength()  
      INITIALIZE l_mmfe.* TO NULL
      LET l_mmfe.mmfeseq   = g_mmfe_d[l_cnt].mmfeseq
      LET l_mmfe.mmfe011   = g_mmfe_d[l_cnt].mmfe011    #組別
      LET l_mmfe.mmfe001   = g_mmfe_d[l_cnt].mmfe001    #商品編號
      LET l_mmfe.mmfe003   = g_mmfe_d[l_cnt].mmfe003    #券面額編號
      LET l_mmfe.mmfe006   = g_mmfe_d[l_cnt].mmfe006    #加價/加積點
      LET l_mmfe.mmfe004   = g_mmfe_d[l_cnt].mmfe004    #起始券號
      LET l_mmfe.mmfe005   = g_mmfe_d[l_cnt].mmfe005    #截止券號
      LET l_mmfe.mmfe007   = g_mmfe_d[l_cnt].mmfe007    #兌換品種數
      LET l_mmfe.mmfe010   = g_mmfe_d[l_cnt].mmfe010    #換贈庫位
      LET l_mmfe.mmfe012   = g_mmfe_d[l_cnt].mmfe012    #資料類型
      LET l_mmfe.mmfe013   = g_mmfe_d[l_cnt].mmfe013    #資料編號
      LET l_mmfe.mmcj011   = g_mmfe_d[l_cnt].mmcj011    #上限名額
      LET l_mmfe.mmcj012   = g_mmfe_d[l_cnt].mmcj012    #上線時間範圍
      LET l_mmfe.mmcj007   = g_mmfe_d[l_cnt].mmcj007    #贈送數量
      
      CASE l_mmfe.mmfe012
         #資料類型 = 4.商品編號
         WHEN '4'
            LET l_mmfe.mmfeseq = l_n
            LET l_mmfe.mmfe001 = l_mmfe.mmfe013
            LET l_count = 0
            EXECUTE ammt450_01_rtdx_curs USING l_mmfe.mmfe001 INTO l_count
            IF cl_null(l_count) OR l_count = 0 THEN
               CONTINUE FOR
            END IF
            #把資料新增至temp裡
            EXECUTE ammt450_01_instmp_curs USING
               l_mmfe.mmfeseq, l_mmfe.mmfe011, l_mmfe.mmfe001, l_mmfe.mmfe003,
               l_mmfe.mmfe006, l_mmfe.mmfe004, l_mmfe.mmfe005, l_mmfe.mmfe007,
               l_mmfe.mmfe010, l_mmfe.mmfe012, l_mmfe.mmfe013, l_mmfe.mmcj011,
               l_mmfe.mmcj012, l_mmfe.mmcj007
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "Ins tmp"
               LET g_errparam.popup = TRUE
               CALL cl_err()

            END IF
            LET l_n = l_n + 1
               
         #資料類型 = 5.商品分類(imaa009)
         WHEN '5'
            LET l_imaa001 = ''
            FOREACH ammt450_01_imaa009_curs USING  l_mmfe.mmfe013 INTO l_imaa001
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

                  EXIT FOREACH
               END IF
               LET l_mmfe.mmfeseq = l_n
               LET l_mmfe.mmfe001 = l_imaa001
               #商品編號需存在門店清單中
               LET l_count = 0
               EXECUTE ammt450_01_rtdx_curs USING l_mmfe.mmfe001 INTO l_count
               IF cl_null(l_count) OR l_count = 0 THEN
                  CONTINUE FOREACH
               END IF
               #把資料新增至temp裡
               EXECUTE ammt450_01_instmp_curs USING
                  l_mmfe.mmfeseq, l_mmfe.mmfe011, l_mmfe.mmfe001, l_mmfe.mmfe003,
                  l_mmfe.mmfe006, l_mmfe.mmfe004, l_mmfe.mmfe005, l_mmfe.mmfe007,
                  l_mmfe.mmfe010, l_mmfe.mmfe012, l_mmfe.mmfe013, l_mmfe.mmcj011,
                  l_mmfe.mmcj012, l_mmfe.mmcj007
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "Ins tmp"
               LET g_errparam.popup = TRUE
               CALL cl_err()

                  END IF
               LET l_n = l_n + 1
               LET l_imaa001 = ''
            END FOREACH
   
         #資料類型 = 6.產地分類(imaa122)
         WHEN '6'
            LET l_imaa001 = ''
            FOREACH ammt450_01_imaa122_curs USING  l_mmfe.mmfe013 INTO l_imaa001
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

                  EXIT FOREACH
               END IF
               LET l_mmfe.mmfeseq = l_n
               LET l_mmfe.mmfe001 = l_imaa001
              #商品編號需存在門店清單中
               LET l_count = 0
               EXECUTE ammt450_01_rtdx_curs USING l_mmfe.mmfe001 INTO l_count
               IF cl_null(l_count) OR l_count = 0 THEN
                  CONTINUE FOREACH
               END IF
               #把資料新增至temp裡
               EXECUTE ammt450_01_instmp_curs USING
                  l_mmfe.mmfeseq, l_mmfe.mmfe011, l_mmfe.mmfe001, l_mmfe.mmfe003,
                  l_mmfe.mmfe006, l_mmfe.mmfe004, l_mmfe.mmfe005, l_mmfe.mmfe007,
                  l_mmfe.mmfe010, l_mmfe.mmfe012, l_mmfe.mmfe013, l_mmfe.mmcj011,
                  l_mmfe.mmcj012, l_mmfe.mmcj007
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "Ins tmp"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               END IF
               LET l_n = l_n + 1
               LET l_imaa001 = ''
            END FOREACH
         
         #資料類型 = 7.價格帶(imaa131)
         WHEN '7'
            LET l_imaa001 = ''
            FOREACH ammt450_01_imaa131_curs USING  l_mmfe.mmfe013 INTO l_imaa001
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

                  EXIT FOREACH
               END IF
               LET l_mmfe.mmfeseq = l_n
               LET l_mmfe.mmfe001 = l_imaa001
               #商品編號需存在門店清單中
               LET l_count = 0
               EXECUTE ammt450_01_rtdx_curs USING l_mmfe.mmfe001 INTO l_count
               IF cl_null(l_count) OR l_count = 0 THEN
                  CONTINUE FOREACH
               END IF
               #把資料新增至temp裡
               EXECUTE ammt450_01_instmp_curs USING
                  l_mmfe.mmfeseq, l_mmfe.mmfe011, l_mmfe.mmfe001, l_mmfe.mmfe003,
                  l_mmfe.mmfe006, l_mmfe.mmfe004, l_mmfe.mmfe005, l_mmfe.mmfe007,
                  l_mmfe.mmfe010, l_mmfe.mmfe012, l_mmfe.mmfe013, l_mmfe.mmcj011,
                  l_mmfe.mmcj012, l_mmfe.mmcj007
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "Ins tmp"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               END IF
               LET l_n = l_n + 1
               LET l_imaa001 = ''
            END FOREACH
         
         #資料類型 = 8.品牌(imaa126)
         WHEN '8'
            LET l_imaa001 = ''
            FOREACH ammt450_01_imaa126_curs USING  l_mmfe.mmfe013 INTO l_imaa001
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

                  EXIT FOREACH
               END IF
               LET l_mmfe.mmfeseq = l_n
               LET l_mmfe.mmfe001 = l_imaa001
               #商品編號需存在門店清單中
               LET l_count = 0
               EXECUTE ammt450_01_rtdx_curs USING l_mmfe.mmfe001 INTO l_count
               IF cl_null(l_count) OR l_count = 0 THEN
                  CONTINUE FOREACH
               END IF
               #把資料新增至temp裡
               EXECUTE ammt450_01_instmp_curs USING
                  l_mmfe.mmfeseq, l_mmfe.mmfe011, l_mmfe.mmfe001, l_mmfe.mmfe003,
                  l_mmfe.mmfe006, l_mmfe.mmfe004, l_mmfe.mmfe005, l_mmfe.mmfe007,
                  l_mmfe.mmfe010, l_mmfe.mmfe012, l_mmfe.mmfe013, l_mmfe.mmcj011,
                  l_mmfe.mmcj012, l_mmfe.mmcj007
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "Ins tmp"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               END IF
               LET l_n = l_n + 1
               LET l_imaa001 = ''
            END FOREACH
         
         #資料類型 = 9.系列(imaa127)
         WHEN '9'
            LET l_imaa001 = ''
            FOREACH ammt450_01_imaa127_curs USING  l_mmfe.mmfe013 INTO l_imaa001
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

                  EXIT FOREACH
               END IF
               LET l_mmfe.mmfeseq = l_n
               LET l_mmfe.mmfe001 = l_imaa001
               #商品編號需存在門店清單中
               LET l_count = 0
               EXECUTE ammt450_01_rtdx_curs USING l_mmfe.mmfe001 INTO l_count
               IF cl_null(l_count) OR l_count = 0 THEN
                  CONTINUE FOREACH
               END IF
               #把資料新增至temp裡
               EXECUTE ammt450_01_instmp_curs USING
                  l_mmfe.mmfeseq, l_mmfe.mmfe011, l_mmfe.mmfe001, l_mmfe.mmfe003,
                  l_mmfe.mmfe006, l_mmfe.mmfe004, l_mmfe.mmfe005, l_mmfe.mmfe007,
                  l_mmfe.mmfe010, l_mmfe.mmfe012, l_mmfe.mmfe013, l_mmfe.mmcj011,
                  l_mmfe.mmcj012, l_mmfe.mmcj007
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "Ins tmp"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               END IF
               LET l_n = l_n + 1
               LET l_imaa001 = ''
            END FOREACH
         
         #資料類型 = A.型別(imaa128)
         WHEN 'A'
            LET l_imaa001 = ''
            FOREACH ammt450_01_imaa128_curs USING  l_mmfe.mmfe013 INTO l_imaa001
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

                  EXIT FOREACH
               END IF
               LET l_mmfe.mmfeseq = l_n
               LET l_mmfe.mmfe001 = l_imaa001
               #商品編號需存在門店清單中
               LET l_count = 0
               EXECUTE ammt450_01_rtdx_curs USING l_mmfe.mmfe001 INTO l_count
               IF cl_null(l_count) OR l_count = 0 THEN
                  CONTINUE FOREACH
               END IF
               #把資料新增至temp裡
               EXECUTE ammt450_01_instmp_curs USING
                  l_mmfe.mmfeseq, l_mmfe.mmfe011, l_mmfe.mmfe001, l_mmfe.mmfe003,
                  l_mmfe.mmfe006, l_mmfe.mmfe004, l_mmfe.mmfe005, l_mmfe.mmfe007,
                  l_mmfe.mmfe010, l_mmfe.mmfe012, l_mmfe.mmfe013, l_mmfe.mmcj011,
                  l_mmfe.mmcj012, l_mmfe.mmcj007
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "Ins tmp"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               END IF
               LET l_n = l_n + 1
               LET l_imaa001 = ''
            END FOREACH
         
         #資料類型 = B.功能(imaa129)
         WHEN 'B'
            LET l_imaa001 = ''
            FOREACH ammt450_01_imaa129_curs USING  l_mmfe.mmfe013 INTO l_imaa001
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

                  EXIT FOREACH
               END IF
               LET l_mmfe.mmfeseq = l_n
               LET l_mmfe.mmfe001 = l_imaa001
               #商品編號需存在門店清單中
               LET l_count = 0
               EXECUTE ammt450_01_rtdx_curs USING l_mmfe.mmfe001 INTO l_count
               IF cl_null(l_count) OR l_count = 0 THEN
                  CONTINUE FOREACH
               END IF
               #把資料新增至temp裡
               EXECUTE ammt450_01_instmp_curs USING
                  l_mmfe.mmfeseq, l_mmfe.mmfe011, l_mmfe.mmfe001, l_mmfe.mmfe003,
                  l_mmfe.mmfe006, l_mmfe.mmfe004, l_mmfe.mmfe005, l_mmfe.mmfe007,
                  l_mmfe.mmfe010, l_mmfe.mmfe012, l_mmfe.mmfe013, l_mmfe.mmcj011,
                  l_mmfe.mmcj012, l_mmfe.mmcj007
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "Ins tmp"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               END IF
               LET l_n = l_n + 1
               LET l_imaa001 = ''
            END FOREACH
         
         #資料類型 = C.其他屬性一(imaa132)
         WHEN 'C'
            LET l_imaa001 = ''
            FOREACH ammt450_01_imaa132_curs USING  l_mmfe.mmfe013 INTO l_imaa001
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

                  EXIT FOREACH
               END IF
               LET l_mmfe.mmfeseq = l_n
               LET l_mmfe.mmfe001 = l_imaa001
               #商品編號需存在門店清單中
               LET l_count = 0
               EXECUTE ammt450_01_rtdx_curs USING l_mmfe.mmfe001 INTO l_count
               IF cl_null(l_count) OR l_count = 0 THEN
                  CONTINUE FOREACH
               END IF
               #把資料新增至temp裡
               EXECUTE ammt450_01_instmp_curs USING
                  l_mmfe.mmfeseq, l_mmfe.mmfe011, l_mmfe.mmfe001, l_mmfe.mmfe003,
                  l_mmfe.mmfe006, l_mmfe.mmfe004, l_mmfe.mmfe005, l_mmfe.mmfe007,
                  l_mmfe.mmfe010, l_mmfe.mmfe012, l_mmfe.mmfe013, l_mmfe.mmcj011,
                  l_mmfe.mmcj012, l_mmfe.mmcj007
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "Ins tmp"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               END IF
               LET l_n = l_n + 1
               LET l_imaa001 = ''
            END FOREACH
         
         #資料類型 = D.其他屬性二(imaa133)
         WHEN 'D'
            LET l_imaa001 = ''
            FOREACH ammt450_01_imaa133_curs USING  l_mmfe.mmfe013 INTO l_imaa001
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

                  EXIT FOREACH
               END IF
               LET l_mmfe.mmfeseq = l_n
               LET l_mmfe.mmfe001 = l_imaa001
               #商品編號需存在門店清單中
               LET l_count = 0
               EXECUTE ammt450_01_rtdx_curs USING l_mmfe.mmfe001 INTO l_count
               IF cl_null(l_count) OR l_count = 0 THEN
                  CONTINUE FOREACH
               END IF
               #把資料新增至temp裡
               EXECUTE ammt450_01_instmp_curs USING
                  l_mmfe.mmfeseq, l_mmfe.mmfe011, l_mmfe.mmfe001, l_mmfe.mmfe003,
                  l_mmfe.mmfe006, l_mmfe.mmfe004, l_mmfe.mmfe005, l_mmfe.mmfe007,
                  l_mmfe.mmfe010, l_mmfe.mmfe012, l_mmfe.mmfe013, l_mmfe.mmcj011,
                  l_mmfe.mmcj012, l_mmfe.mmcj007
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "Ins tmp"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               END IF
               LET l_n = l_n + 1
               LET l_imaa001 = ''
            END FOREACH
         
         #資料類型 = E.其他屬性三(imaa134)
         WHEN 'E'
            LET l_imaa001 = ''
            FOREACH ammt450_01_imaa134_curs USING  l_mmfe.mmfe013 INTO l_imaa001
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

                  EXIT FOREACH
               END IF
               LET l_mmfe.mmfeseq = l_n
               LET l_mmfe.mmfe001 = l_imaa001
               #商品編號需存在門店清單中
               LET l_count = 0
               EXECUTE ammt450_01_rtdx_curs USING l_mmfe.mmfe001 INTO l_count
               IF cl_null(l_count) OR l_count = 0 THEN
                  CONTINUE FOREACH
               END IF
               #把資料新增至temp裡
               EXECUTE ammt450_01_instmp_curs USING
                  l_mmfe.mmfeseq, l_mmfe.mmfe011, l_mmfe.mmfe001, l_mmfe.mmfe003,
                  l_mmfe.mmfe006, l_mmfe.mmfe004, l_mmfe.mmfe005, l_mmfe.mmfe007,
                  l_mmfe.mmfe010, l_mmfe.mmfe012, l_mmfe.mmfe013, l_mmfe.mmcj011,
                  l_mmfe.mmcj012, l_mmfe.mmcj007
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "Ins tmp"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               END IF
               LET l_n = l_n + 1
               LET l_imaa001 = ''
            END FOREACH
         
         #資料類型 = F.其他屬性四(imaa135)
         WHEN 'F'
            LET l_imaa001 = ''
            FOREACH ammt450_01_imaa135_curs USING  l_mmfe.mmfe013 INTO l_imaa001
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

                  EXIT FOREACH
               END IF
               LET l_mmfe.mmfeseq = l_n
               LET l_mmfe.mmfe001 = l_imaa001
               #商品編號需存在門店清單中
               LET l_count = 0
               EXECUTE ammt450_01_rtdx_curs USING l_mmfe.mmfe001 INTO l_count
               IF cl_null(l_count) OR l_count = 0 THEN
                  CONTINUE FOREACH
               END IF
               #把資料新增至temp裡
               EXECUTE ammt450_01_instmp_curs USING
                  l_mmfe.mmfeseq, l_mmfe.mmfe011, l_mmfe.mmfe001, l_mmfe.mmfe003,
                  l_mmfe.mmfe006, l_mmfe.mmfe004, l_mmfe.mmfe005, l_mmfe.mmfe007,
                  l_mmfe.mmfe010, l_mmfe.mmfe012, l_mmfe.mmfe013, l_mmfe.mmcj011,
                  l_mmfe.mmcj012, l_mmfe.mmcj007
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "Ins tmp"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               END IF
               LET l_n = l_n + 1
               LET l_imaa001 = ''
            END FOREACH
         
         #資料類型 = G.其他屬性五(imaa136)
         WHEN 'G'
            LET l_imaa001 = ''
            FOREACH ammt450_01_imaa136_curs USING  l_mmfe.mmfe013 INTO l_imaa001
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

                  EXIT FOREACH
               END IF
               LET l_mmfe.mmfeseq = l_n
               LET l_mmfe.mmfe001 = l_imaa001
               #商品編號需存在門店清單中
               LET l_count = 0
               EXECUTE ammt450_01_rtdx_curs USING l_mmfe.mmfe001 INTO l_count
               IF cl_null(l_count) OR l_count = 0 THEN
                  CONTINUE FOREACH
               END IF
               #把資料新增至temp裡
               EXECUTE ammt450_01_instmp_curs USING
                  l_mmfe.mmfeseq, l_mmfe.mmfe011, l_mmfe.mmfe001, l_mmfe.mmfe003,
                  l_mmfe.mmfe006, l_mmfe.mmfe004, l_mmfe.mmfe005, l_mmfe.mmfe007,
                  l_mmfe.mmfe010, l_mmfe.mmfe012, l_mmfe.mmfe013, l_mmfe.mmcj011,
                  l_mmfe.mmcj012, l_mmfe.mmcj007
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "Ins tmp"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               END IF
               LET l_n = l_n + 1
               LET l_imaa001 = ''
            END FOREACH
         
         #資料類型 = H.其他屬性六(imaa137)
         WHEN 'H'
            LET l_imaa001 = ''
            FOREACH ammt450_01_imaa137_curs USING  l_mmfe.mmfe013 INTO l_imaa001
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

                  EXIT FOREACH
               END IF
               LET l_mmfe.mmfeseq = l_n
               LET l_mmfe.mmfe001 = l_imaa001
               #商品編號需存在門店清單中
               LET l_count = 0
               EXECUTE ammt450_01_rtdx_curs USING l_mmfe.mmfe001 INTO l_count
               IF cl_null(l_count) OR l_count = 0 THEN
                  CONTINUE FOREACH
               END IF
               #把資料新增至temp裡
               EXECUTE ammt450_01_instmp_curs USING 
                  l_mmfe.mmfeseq, l_mmfe.mmfe011, l_mmfe.mmfe001, l_mmfe.mmfe003,
                  l_mmfe.mmfe006, l_mmfe.mmfe004, l_mmfe.mmfe005, l_mmfe.mmfe007,
                  l_mmfe.mmfe010, l_mmfe.mmfe012, l_mmfe.mmfe013, l_mmfe.mmcj011,
                  l_mmfe.mmcj012, l_mmfe.mmcj007
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "Ins tmp"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               END IF
               LET l_n = l_n + 1
               LET l_imaa001 = ''
            END FOREACH
         
         #資料類型 = I.其他屬性七(imaa138)
         WHEN 'I'
            LET l_imaa001 = ''
            FOREACH ammt450_01_imaa138_curs USING  l_mmfe.mmfe013 INTO l_imaa001
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

                  EXIT FOREACH
               END IF
               LET l_mmfe.mmfeseq = l_n
               LET l_mmfe.mmfe001 = l_imaa001
               #商品編號需存在門店清單中
               LET l_count = 0
               EXECUTE ammt450_01_rtdx_curs USING l_mmfe.mmfe001 INTO l_count
               IF cl_null(l_count) OR l_count = 0 THEN
                  CONTINUE FOREACH
               END IF
               #把資料新增至temp裡
               EXECUTE ammt450_01_instmp_curs USING
                  l_mmfe.mmfeseq, l_mmfe.mmfe011, l_mmfe.mmfe001, l_mmfe.mmfe003,
                  l_mmfe.mmfe006, l_mmfe.mmfe004, l_mmfe.mmfe005, l_mmfe.mmfe007,
                  l_mmfe.mmfe010, l_mmfe.mmfe012, l_mmfe.mmfe013, l_mmfe.mmcj011,
                  l_mmfe.mmcj012, l_mmfe.mmcj007
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "Ins tmp"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               END IF
               LET l_n = l_n + 1
               LET l_imaa001 = ''
            END FOREACH
         
         #資料類型 = J.其他屬性八(imaa139)
         WHEN 'J'
            LET l_imaa001 = ''
            FOREACH ammt450_01_imaa139_curs USING  l_mmfe.mmfe013 INTO l_imaa001
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

                  EXIT FOREACH
               END IF
               LET l_mmfe.mmfeseq = l_n
               LET l_mmfe.mmfe001 = l_imaa001
               #商品編號需存在門店清單中
               LET l_count = 0
               EXECUTE ammt450_01_rtdx_curs USING l_mmfe.mmfe001 INTO l_count
               IF cl_null(l_count) OR l_count = 0 THEN
                  CONTINUE FOREACH
               END IF
               #把資料新增至temp裡
               EXECUTE ammt450_01_instmp_curs USING
                  l_mmfe.mmfeseq, l_mmfe.mmfe011, l_mmfe.mmfe001, l_mmfe.mmfe003,
                  l_mmfe.mmfe006, l_mmfe.mmfe004, l_mmfe.mmfe005, l_mmfe.mmfe007,
                  l_mmfe.mmfe010, l_mmfe.mmfe012, l_mmfe.mmfe013, l_mmfe.mmcj011,
                  l_mmfe.mmcj012, l_mmfe.mmcj007
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "Ins tmp"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               END IF
               LET l_n = l_n + 1
               LET l_imaa001 = ''
            END FOREACH
         
         #資料類型 = K.其他屬性九(imaa140)
         WHEN 'K'
            LET l_imaa001 = ''
            FOREACH ammt450_01_imaa140_curs USING  l_mmfe.mmfe013 INTO l_imaa001
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

                  EXIT FOREACH
               END IF
               LET l_mmfe.mmfeseq = l_n
               LET l_mmfe.mmfe001 = l_imaa001
               #商品編號需存在門店清單中
               LET l_count = 0
               EXECUTE ammt450_01_rtdx_curs USING l_mmfe.mmfe001 INTO l_count
               IF cl_null(l_count) OR l_count = 0 THEN
                  CONTINUE FOREACH
               END IF
               #把資料新增至temp裡
               EXECUTE ammt450_01_instmp_curs USING
                  l_mmfe.mmfeseq, l_mmfe.mmfe011, l_mmfe.mmfe001, l_mmfe.mmfe003,
                  l_mmfe.mmfe006, l_mmfe.mmfe004, l_mmfe.mmfe005, l_mmfe.mmfe007,
                  l_mmfe.mmfe010, l_mmfe.mmfe012, l_mmfe.mmfe013, l_mmfe.mmcj011,
                  l_mmfe.mmcj012, l_mmfe.mmcj007
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "Ins tmp"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               END IF
               LET l_n = l_n + 1
               LET l_imaa001 = ''
            END FOREACH
         
         #資料類型 = L.其他屬性十(imaa141)
         WHEN 'L'
            LET l_imaa001 = ''
            FOREACH ammt450_01_imaa141_curs USING  l_mmfe.mmfe013 INTO l_imaa001
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

                  EXIT FOREACH
               END IF
               LET l_mmfe.mmfeseq = l_n
               LET l_mmfe.mmfe001 = l_imaa001
               #商品編號需存在門店清單中
               LET l_count = 0
               EXECUTE ammt450_01_rtdx_curs USING l_mmfe.mmfe001 INTO l_count
               IF cl_null(l_count) OR l_count = 0 THEN
                  CONTINUE FOREACH
               END IF
               #把資料新增至temp裡
               EXECUTE ammt450_01_instmp_curs USING
                  l_mmfe.mmfeseq, l_mmfe.mmfe011, l_mmfe.mmfe001, l_mmfe.mmfe003,
                  l_mmfe.mmfe006, l_mmfe.mmfe004, l_mmfe.mmfe005, l_mmfe.mmfe007,
                  l_mmfe.mmfe010, l_mmfe.mmfe012, l_mmfe.mmfe013, l_mmfe.mmcj011,
                  l_mmfe.mmcj012, l_mmfe.mmcj007
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "Ins tmp"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               END IF
               LET l_n = l_n + 1
               LET l_imaa001 = ''
            END FOREACH
         
         #資料類型 = M.卡(mman053)
         WHEN 'M'
            LET l_mman053 = ''
            EXECUTE ammt450_01_mman053_curs USING l_mmfe.mmfe013 INTO l_mman053
            LET l_mmfe.mmfeseq = l_n
            LET l_mmfe.mmfe001 = l_mmfe.mmfe013
            #商品編號需存在門店清單中
            LET l_count = 0
            EXECUTE ammt450_01_rtdx_curs USING l_mman053 INTO l_count
            IF cl_null(l_count) OR l_count = 0 THEN
               CONTINUE FOR
            END IF
            #把資料新增至temp裡
            EXECUTE ammt450_01_instmp_curs USING
               l_mmfe.mmfeseq, l_mmfe.mmfe011, l_mmfe.mmfe001, l_mmfe.mmfe003,
               l_mmfe.mmfe006, l_mmfe.mmfe004, l_mmfe.mmfe005, l_mmfe.mmfe007,
               l_mmfe.mmfe010, l_mmfe.mmfe012, l_mmfe.mmfe013, l_mmfe.mmcj011,
               l_mmfe.mmcj012, l_mmfe.mmcj007
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "Ins tmp"
               LET g_errparam.popup = TRUE
               CALL cl_err()

            END IF
            LET l_n = l_n + 1
         
         #資料類型 = N.券(gcaf013)
         WHEN 'N'
            LET l_gcaf013 = ''
            LET l_gcaf012 = ''
            EXECUTE ammt450_01_gcaf013_curs USING l_mmfe.mmfe013 INTO l_gcaf013,l_gcaf012
            LET l_mmfe.mmfeseq = l_n
            #LET l_mmfe.mmfe001 = l_mmfe.mmfe013  #160518-00070#1 20160520 mark by beckxie
            LET l_mmfe.mmfe001 = l_gcaf013        #160518-00070#1 20160520 add by beckxie
            LET l_mmfe.mmfe003 = l_gcaf012
            #商品編號需存在門店清單中
            LET l_count = 0
            EXECUTE ammt450_01_rtdx_curs USING l_gcaf013 INTO l_count
            IF cl_null(l_count) OR l_count = 0 THEN
               CONTINUE FOR
            END IF
            #把資料新增至temp裡
            EXECUTE ammt450_01_instmp_curs USING
               l_mmfe.mmfeseq, l_mmfe.mmfe011, l_mmfe.mmfe001, l_mmfe.mmfe003,
               l_mmfe.mmfe006, l_mmfe.mmfe004, l_mmfe.mmfe005, l_mmfe.mmfe007,
               l_mmfe.mmfe010, l_mmfe.mmfe012, l_mmfe.mmfe013, l_mmfe.mmcj011,
               l_mmfe.mmcj012, l_mmfe.mmcj007
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "Ins tmp"
               LET g_errparam.popup = TRUE
               CALL cl_err()

            END IF
            LET l_n = l_n + 1
         
         #資料類型 = O.積點(mman060)
         WHEN 'O'
            IF NOT cl_null(g_rtia.rtia001) THEN
               LET l_imaa001 = ''
               EXECUTE ammt450_01_mman060_curs USING g_rtia.rtia042 INTO l_imaa001
               LET l_mmfe.mmfeseq = l_n
               LET l_mmfe.mmfe001 = l_imaa001
               #商品編號需存在門店清單中
               LET l_count = 0
               EXECUTE ammt450_01_rtdx_curs USING l_mmfe.mmfe001 INTO l_count
               IF cl_null(l_count) OR l_count = 0 THEN
                  CONTINUE FOR
               END IF
               #把資料新增至temp裡
               EXECUTE ammt450_01_instmp_curs USING
                  l_mmfe.mmfeseq, l_mmfe.mmfe011, l_mmfe.mmfe001, l_mmfe.mmfe003,
                  l_mmfe.mmfe006, l_mmfe.mmfe004, l_mmfe.mmfe005, l_mmfe.mmfe007,
                  l_mmfe.mmfe010, l_mmfe.mmfe012, l_mmfe.mmfe013, l_mmfe.mmcj011,
                  l_mmfe.mmcj012, l_mmfe.mmcj007
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "Ins tmp"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               END IF
               LET l_n = l_n + 1
            END IF
            
         #資料類型 = P.送抵現值(mman054)
         WHEN 'P'
            IF NOT cl_null(g_rtia.rtia001) THEN
               LET l_imaa001 = ''
               EXECUTE ammt450_01_mman054_curs USING g_rtia.rtia042 INTO l_imaa001
               LET l_mmfe.mmfeseq = l_n
               LET l_mmfe.mmfe001 = l_imaa001
               #商品編號需存在門店清單中
               LET l_count = 0
               EXECUTE ammt450_01_rtdx_curs USING l_mmfe.mmfe001 INTO l_count
               IF cl_null(l_count) OR l_count = 0 THEN
                  CONTINUE FOR
               END IF
               #把資料新增至temp裡
               EXECUTE ammt450_01_instmp_curs USING
                  l_mmfe.mmfeseq, l_mmfe.mmfe011, l_mmfe.mmfe001, l_mmfe.mmfe003,
                  l_mmfe.mmfe006, l_mmfe.mmfe004, l_mmfe.mmfe005, l_mmfe.mmfe007,
                  l_mmfe.mmfe010, l_mmfe.mmfe012, l_mmfe.mmfe013, l_mmfe.mmcj011,
                  l_mmfe.mmcj012, l_mmfe.mmcj007
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "Ins tmp"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               END IF
               LET l_n = l_n + 1
            END IF
      END CASE
      
   END FOR
END FUNCTION
################################################################################
# Descriptions...: 商品編號帶出說明
# Memo...........:
# Usage..........: CALL ammt450_01_mmfe001_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/20 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt450_01_mmfe001_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mmfe_d[l_ac].mmfe001
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mmfe_d[l_ac].mmfe001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mmfe_d[l_ac].mmfe001_desc
END FUNCTION
################################################################################
# Descriptions...: 庫位帶出說明
# Memo...........:
# Usage..........: CALL ammt450_01_mmfe010_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/20 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt450_01_mmfe010_ref()
   #150907-00033#2 20150914 mark by beckxie---S
   #INITIALIZE g_ref_fields TO NULL
   #LET g_ref_fields[1] = g_mmfe_d[l_ac].mmfe010
   #CALL ap_ref_array2(g_ref_fields,"SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaa001=? ","") RETURNING g_rtn_fields
   #LET g_mmfe_d[l_ac].mmfe010_desc = '', g_rtn_fields[1] , ''
   #DISPLAY BY NAME g_mmfe_d[l_ac].mmfe010_desc
   #150907-00033#2 20150914 mark by beckxie---E
   #150907-00033#2 20150914  add by beckxie---S
   CALL s_desc_get_stock_desc(g_site,g_mmfe_d[l_ac].mmfe010) RETURNING g_mmfe_d[l_ac].mmfe010_desc
   DISPLAY BY NAME g_mmfe_d[l_ac].mmfe010_desc
   #150907-00033#2 20150914  add by beckxie---E
END FUNCTION
################################################################################
# Descriptions...: 畫面初始化
# Memo...........:
# Usage..........: CALL ammt450_01_init()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/20 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt450_01_init()
DEFINE l_gzze003  LIKE gzze_t.gzze003

CALL cl_set_combo_scc('mmby009','6534') 
   CALL cl_set_combo_scc('mmby010','6535') 
   CALL cl_set_combo_scc('mmby011','6536') 
   CALL cl_set_combo_scc('mmfe012','6517')
   CALL cl_set_combo_scc('mmcj012','6538')

   #IF g_prog = 'ammt451' OR g_prog = 'ammt452' THEN              #160705-00042#11 160714 by sakura mark
   IF g_prog MATCHES 'ammt451' OR g_prog MATCHES 'ammt452' THEN   #160705-00042#11 160714 by sakura add
      #該規則計算總累消
      LET l_gzze003 = cl_getmsg('amm-00314',g_dlang)
      CALL cl_set_comp_att_text('rtia046',l_gzze003)
      
      #此次兌換金額
      LET l_gzze003 = cl_getmsg('amm-00315',g_dlang)
      CALL cl_set_comp_att_text('rtia047',l_gzze003)
      
      #兌換後剩餘金額
      LET l_gzze003 = cl_getmsg('amm-00316',g_dlang)
      CALL cl_set_comp_att_text('rtia0471',l_gzze003)
   END IF
END FUNCTION
################################################################################
# Descriptions...: 把temp table的資料放到陣列裡
# Memo...........:
# Usage..........: CALL ammt450_01_b_fill()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/20 By pomelo
# Modify.........: 2016/10/03 By lori      160819-00054#14 
################################################################################
PUBLIC FUNCTION ammt450_01_b_fill()
DEFINE l_ac1           LIKE type_t.num5
DEFINE l_mmci004       LIKE mmci_t.mmci004
   
   LET g_sql = "SELECT '' ,mmfeseq, mmfe011, mmfe001, '', mmfe003, mmfe006, ",
               "       mmfe004, mmfe005, mmfe007, mmfe010, '', mmfe012, mmfe013, '',",
               "       mmcj011, mmcj012, mmcj007",
               "  FROM ammt450_tmp",
               " ORDER BY mmfeseq"
   PREPARE ammt450_01_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR ammt450_01_pb
   CALL g_mmfe_d.clear()
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_mmfe_d[l_ac].sel,g_mmfe_d[l_ac].mmfeseq,g_mmfe_d[l_ac].mmfe011, 
       g_mmfe_d[l_ac].mmfe001,g_mmfe_d[l_ac].mmfe001_desc,g_mmfe_d[l_ac].mmfe003,g_mmfe_d[l_ac].mmfe006, 
       g_mmfe_d[l_ac].mmfe004,g_mmfe_d[l_ac].mmfe005,g_mmfe_d[l_ac].mmfe007,g_mmfe_d[l_ac].mmfe010,g_mmfe_d[l_ac].mmfe010_desc, 
       g_mmfe_d[l_ac].mmfe012,g_mmfe_d[l_ac].mmfe013,g_mmfe_d[l_ac].mmfe013_desc,g_mmfe_d[l_ac].mmcj011, 
       g_mmfe_d[l_ac].mmcj012,g_mmfe_d[l_ac].mmcj007
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
  
      #依不同資料類型的資料找出符合資料類型的商品編號
      CALL ammt450_01_mmfe001_ref()
      CALL ammt450_01_mmfe003_ref()
      CALL ammt450_01_mmfe013_ref()
      LET g_mmfe_d[l_ac].sel = 'N' 
      
      #160604-00009#47 Add By Ken 160615(S) 資料類型非卡、劵、積點、送抵現值時 依商品編號到rtdx_t取庫位rtdx044
      IF (g_mmfe_d[l_ac].mmfe012 !='M') AND (g_mmfe_d[l_ac].mmfe012 !='N')
        AND (g_mmfe_d[l_ac].mmfe012 !='O') AND (g_mmfe_d[l_ac].mmfe012 !='P') THEN
         EXECUTE ammt450_01_rtdx044 USING g_mmfe_d[l_ac].mmfe001 INTO g_mmfe_d[l_ac].mmfe010
      END IF           
      #160604-00009#47 Add By Ken 160615(E)
      
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
      
   END FOREACH
   
   IF l_ac > g_max_rec AND g_error_show = 1 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 9035
      LET g_errparam.extend = "mmfe_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF 
   LET g_error_show = 0
   CALL g_mmfe_d.deleteElement(g_mmfe_d.getLength())
   
   LET l_mmci004 = 0
   #規則編號+版次抓符合換贈組別的資料
   LET g_sql = "SELECT UNIQUE mmci003,mmci004,mmci005",
               "  FROM mmci_t,mmbo_t",
               " WHERE mmcient = mmboent",
               "   AND mmcidocno = mmbodocno",
               "   AND mmcient= ?",
               "   AND mmbo001 = ?",
               "   AND mmbo002 = ?",
               "   AND mmciacti = 'Y'"   #,    #160819-00054$14 161003 by lori mark,
              #" ORDER BY mmci003"             #160819-00054$14 161003 by lori mark
              
   #160819-00054$14 161003 by lori add---(S)
   IF g_mmby009 = '2' THEN
     IF g_mmby024 = 'Y' THEN
        LET g_sql = g_sql," AND mmci006 = '",g_rtia066,"' "
     END IF
   END IF
   
   LET g_sql = g_sql," ORDER BY mmci003 "
   #160819-00054$14 161003 by lori add---(E)
   
   PREPARE ammt450_01_mmci FROM g_sql
   DECLARE ammt450_01_mmci_curs CURSOR FOR ammt450_01_mmci
   
   OPEN ammt450_01_mmci_curs USING g_enterprise,g_rtia.rtia044,g_rtia.rtia045
 
   CALL g_mmci_d.clear()
   LET l_ac1 = 1
   FOREACH ammt450_01_mmci_curs INTO g_mmci_d[l_ac1].mmci003,g_mmci_d[l_ac1].mmci004,g_mmci_d[l_ac1].mmci005
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      #分段兌換比率　可以換到的最大組別
      LET l_mmci004 = l_mmci004 + g_mmci_d[l_ac1].mmci004
      IF g_rtia.rtia043 >= l_mmci004 THEN
         LET g_mmci003 = g_mmci_d[l_ac1].mmci003
      END IF
      
      LET l_ac1 = l_ac1 + 1
      IF l_ac1 > g_max_rec THEN
         EXIT FOREACH
      END IF
      
   END FOREACH
   CALL g_mmci_d.deleteElement(g_mmci_d.getLength())
   
   LET g_detail_cnt = l_ac - 1
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE ammt450_01_pb
   
   #顯示符合換贈組別單身的資料
   DISPLAY ARRAY g_mmci_d TO s_detail2.* ATTRIBUTE(COUNT=g_detail_cnt) 
      BEFORE DISPLAY
         EXIT DISPLAY
   END DISPLAY
   IF g_detail_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amm-00407'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF
END FUNCTION
################################################################################
# Descriptions...: 檢查總兌換份數是否大於設定限制
# Memo...........:
# Usage..........: CALL ammt450_01_chk_copies()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/20 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt450_01_chk_copies()
DEFINE l_cnt       LIKE type_t.num5
DEFINE l_mmbo014   LIKE mmbo_t.mmbo014
DEFINE l_mmbo015   LIKE mmbo_t.mmbo015

   LET g_errno = ''
   LET l_cnt = 0
   CASE g_mmfe_d[l_ac].mmcj012
      WHEN '1'  #每天
         SELECT COUNT(*) INTO l_cnt
           FROM rtia_t,mmfe_t
          WHERE rtiaent = mmfeent
            AND rtiadocno = mmfedocno
            AND rtiaent = g_enterprise
            AND rtiadocdt = g_rtia.rtiadocdt
            AND rtia044 = g_rtia.rtia044
            AND rtia045 = g_rtia.rtia045
            AND (rtiastus = 'Y' OR rtiastus = 'N')
            AND mmfe011 = g_mmfe_d[l_ac].mmfe011
            AND mmfe013 = g_mmfe_d[l_ac].mmfe013
            
      WHEN '2'  #活動生失效日期
         LET l_mmbo014 = ''
         LET l_mmbo015 = ''
         SELECT mmbo014,mmbo015 INTO l_mmbo014,l_mmbo015
           FROM mmbo_t
          WHERE mmboent = g_enterprise
            AND mmbo001 = g_rtia.rtia044
            AND mmbo002 = g_rtia.rtia045
         SELECT COUNT(*) INTO l_cnt
           FROM rtia_t,mmfe_t
          WHERE rtiaent = mmfeent
            AND rtiadocno = mmfedocno
            AND rtiaent = g_enterprise
            AND rtiadocdt BETWEEN l_mmbo014 AND l_mmbo015
            AND rtia044 = g_rtia.rtia044
            AND rtia045 = g_rtia.rtia045
            AND (rtiastus = 'Y' OR rtiastus = 'N')
            AND mmfe011 = g_mmfe_d[l_ac].mmfe011
            AND mmfe013 = g_mmfe_d[l_ac].mmfe013
   END CASE
   #已兌換數(l_cnt)+此資料編號要兌換的份數(mmfe007)
   #不可以大於可兌換的上限數量(mcj011)
   IF l_cnt + g_mmfe_d[l_ac].mmfe007 > g_mmfe_d[l_ac].mmcj011 THEN
      #已超出上限名額,是否確認兌換(Y/N)?
      LET g_errno = 'amm-00277'
   END IF
END FUNCTION
################################################################################
# Descriptions...: 欄位可輸入
# Memo...........:
# Usage..........: CALL ammt450_01_set_entry_b()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/20 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt450_01_set_entry_b()
   CALL cl_set_comp_entry("mmfe004",TRUE)    #起始券號
   CALL cl_set_comp_entry("mmfe005",TRUE)    #截止券號
   CALL cl_set_comp_entry("mmfe007",TRUE)    #兌換品種數
   CALL cl_set_comp_entry("mmfe010",TRUE)    #換贈庫位
END FUNCTION
################################################################################
# Descriptions...: 先抓取規則編號+版本+兌換組別的
#                  累計積點\累計消費額達(mmci004)和兌換品種數(mmci005)
# Memo...........:
# Usage..........: CALL ammt450_01_mmci()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/21 By pomelo
# Modify.........: 2016/10/03 By lori     新增mmci006判斷
################################################################################
PUBLIC FUNCTION ammt450_01_mmci()
   #先抓出規則編號+版本+兌換組別的 累計積點\累計消費額達(mmci004) 兌換品種數(mmci005)
   LET g_mmci004 = ''
   LET g_mmci005 = ''
   
   SELECT mmci004,mmci005 INTO g_mmci004,g_mmci005
     FROM mmci_t,mmbo_t
    WHERE mmcient = mmboent
      AND mmcidocno = mmbodocno
      AND mmcient = g_enterprise
      AND mmbo001 = g_rtia.rtia044
      AND mmbo002 = g_rtia.rtia045
      AND mmci003 = g_mmfe_d[l_ac].mmfe011
      AND mmciacti = 'Y'
      AND (g_mmby024 = 'N'                              #160819-00054#14 161003 by lori add
        OR (g_mmby024 = 'Y' AND mmci006 = g_rtia066))   #160819-00054#14 161003 by lori add
      
   IF cl_null(g_mmci005) THEN
      LET g_mmci005 = 0
   END IF
END FUNCTION
################################################################################
# Descriptions...: 欄位不可輸入
# Memo...........:
# Usage..........: CALL ammt450_01_set_no_entry_b()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/20 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt450_01_set_no_entry_b()
   #當有勾選時
   IF g_mmfe_d[l_ac].sel = 'Y' THEN
      #資料型態 = N.券
      IF g_mmfe_d[l_ac].mmfe012 = 'M' OR g_mmfe_d[l_ac].mmfe012 = 'N' THEN
         CALL cl_set_comp_entry("mmfe007",FALSE)   #兌換品種數
      ELSE
         CALL cl_set_comp_entry("mmfe004",FALSE)   #起始券號
         CALL cl_set_comp_entry("mmfe005",FALSE)   #截止券號
      END IF
      
   END IF
   
   #當沒有勾選時
   IF g_mmfe_d[l_ac].sel = 'N' THEN
      CALL cl_set_comp_entry("mmfe004",FALSE)      #起始券號
      CALL cl_set_comp_entry("mmfe005",FALSE)      #起始券號
      CALL cl_set_comp_entry("mmfe007",FALSE)      #兌換品種數
      CALL cl_set_comp_entry("mmfe010",FALSE)      #換贈庫位
   END IF
   
END FUNCTION
################################################################################
# Descriptions...: 檢查組別的兌換品種數
# Memo...........:
# Usage..........: CALL ammt450_01_chk_groups_copies()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/21 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt450_01_chk_groups_copies()
DEFINE l_mmfe007    LIKE mmfe_t.mmfe007
DEFINE l_mmfe007_1  LIKE mmfe_t.mmfe007

   LET g_errno = ''
   #先計算存在mmfe_t裡以勾選相同組別的兌換品種數量(mmfe007)加總
   LET l_mmfe007 = ''
   LET l_mmfe007_1 = ''
   SELECT SUM(mmfe007) INTO l_mmfe007_1
     FROM mmfe_t
    WHERE mmfeent = g_enterprise
      AND mmfedocno = g_rtiadocno
      AND mmfe011 = g_mmfe_d[l_ac].mmfe011
   
   IF cl_null(l_mmfe007_1) THEN
       LET l_mmfe007_1 = 0
    END IF
   
   #先計算存在temp table裡以勾選相同組別的兌換品種數量(mmfe007)加總
   LET l_mmfe007 = ''
   SELECT SUM(mmfe007) INTO l_mmfe007
     FROM ammt450_tmp1
    WHERE mmfe011 = g_mmfe_d[l_ac].mmfe011
    
   IF cl_null(l_mmfe007) THEN
      LET l_mmfe007 = 0
   END IF
    
   IF l_mmfe007 + l_mmfe007_1 + g_mmfe_d[l_ac].mmfe007 > g_mmci005 THEN
      #此組別已勾選的兌換品種數加總的總量，不可以大於此組別兌換的兌換品種數量！
      LET g_errno = 'amm-00278'
   END IF
END FUNCTION
################################################################################
# Descriptions...: 確認輸入的券號是否符合
# Memo...........:
# Usage..........: CALL ammt450_01_chk_gcaf(p_gcaf010,p_gcaf011)
# Input parameter: p_gcaf010 起始券號
#                  p_gcaf011 截止券號
# Return code....: 無
# Date & Author..: 2014/03/25 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt450_01_chk_gcaf(p_gcaf010,p_gcaf011)
DEFINE p_gcaf010               LIKE gcaf_t.gcaf010
DEFINE p_gcaf011               LIKE gcaf_t.gcaf011
DEFINE l_gcafstus              LIKE gcaf_t.gcafstus
DEFINE l_gcaf007               LIKE gcaf_t.gcaf007
DEFINE l_gcaf008               LIKE gcaf_t.gcaf008
DEFINE l_gcaf009               LIKE gcaf_t.gcaf009
DEFINE l_gcaf010               LIKE gcaf_t.gcaf010
DEFINE l_gcaf011               LIKE gcaf_t.gcaf011
DEFINE l_gcaf008_str           STRING
DEFINE l_gcaf010_str           STRING
DEFINE l_gcaf011_str           STRING
DEFINE l_str                   STRING
DEFINE l_i                     LIKE type_t.num5
DEFINE l_gcao001               LIKE gcao_t.gcao001
DEFINE l_gcao005               LIKE gcao_t.gcao005
DEFINE l_gcao001_str           STRING

   LET g_errno = ''
   IF NOT cl_null(p_gcaf010) AND NOT cl_null(p_gcaf011) THEN
      IF p_gcaf010 > p_gcaf011 THEN
         #開始券號不可大於結束券號
         LET g_errno = 'agc-00010'
         RETURN
      END IF
   END IF
   
   LET l_gcafstus = ''
   LET l_gcaf007 = ''
   LET l_gcaf008 = ''
   LET l_gcaf009 = ''
   LET g_gcaf010 = ''
   LET g_gcaf011 = ''
   SELECT gcaf007,gcaf008,gcaf009,gcaf010,gcaf011,gcafstus
     INTO l_gcaf007,l_gcaf008,l_gcaf009,g_gcaf010,g_gcaf011,l_gcafstus
     FROM gcaf_t
    WHERE gcafent = g_enterprise
      AND gcaf001 = g_mmfe_d[l_ac].mmfe013
   CASE
      WHEN SQLCA.sqlcode = 100
         #券種編號不存在 券種基本資料 中！
         LET g_errno = 'agc-00001'
         RETURN
      
      WHEN l_gcafstus != 'Y'
         #該券種編號未確認或已無效
         LET g_errno = 'amm-00194'
         RETURN
   END CASE
   
   LET l_gcaf010_str = p_gcaf010
   LET l_gcaf011_str = p_gcaf011
   IF l_gcaf007 != 0 THEN   #160615-00028#4 160623 by sakura add
      LET l_gcaf008_str = l_gcaf010_str.subString(1,l_gcaf007)
   #160615-00028#4 160623 by sakura add(S)
   ELSE
      LET l_gcaf008_str = null
   END IF
   #160615-00028#4 160623 by sakura add(E)
   IF l_gcaf008 != l_gcaf008_str THEN
      #輸入的券號與券種編號：％１的固定代碼不相同！
      LET g_errno = 'amm-00284'
      RETURN
   END IF
   IF l_gcaf007 != 0 THEN   #160615-00028#4 160623 by sakura add
      LET l_gcaf008_str = l_gcaf011_str.subString(1,l_gcaf007)
   #160615-00028#4 160623 by sakura add(S)
   ELSE
      LET l_gcaf008_str = null
   END IF
   #160615-00028#4 160623 by sakura add(E)
   IF l_gcaf008 != l_gcaf008_str THEN
      #輸入的券號與券種編號：％１的固定代碼不相同！
      LET g_errno = 'amm-00284'
      RETURN
   END IF
   
   CASE
      WHEN p_gcaf010 < g_gcaf010 AND p_gcaf010 > g_gcaf011
         #輸入的券號不介於起始券號：%1~結束券號：%2！
         LET g_errno = 'amm-00283'
         
      WHEN p_gcaf011 < g_gcaf010 AND p_gcaf011 > g_gcaf011
         #輸入的券號不介於起始券號：%1~結束券號：%2！
         LET g_errno = 'amm-00283'
         
   END CASE
   
   #檢查券號是否已存在，券狀態
   LET g_sql = "SELECT gcao005 FROM gcao_t WHERE gcaoent = '",g_enterprise,"' AND gcao001 = ? AND gcao002 = ? "
   PREPARE ammt450_01_gcao005 FROM g_sql
   DECLARE ammt450_01_gcao005_curs CURSOR FOR ammt450_01_gcao005
   
   #券號
   IF cl_null(p_gcaf011) THEN
      LET p_gcaf011 = p_gcaf010
   END IF
   IF NOT cl_null(p_gcaf010) AND NOT cl_null(p_gcaf011) THEN
      LET l_str = ''
      FOR l_i = 1 TO l_gcaf009
          LET l_str = l_str , "&"
      END FOR
      LET l_gcaf010_str = p_gcaf010
      LET l_gcaf011_str = p_gcaf011
      LET l_gcaf010 = l_gcaf010_str.subString(l_gcaf007+1,l_gcaf010_str.getLength())
      LET l_gcaf011 = l_gcaf011_str.subString(l_gcaf007+1,l_gcaf011_str.getLength()) 
      LET g_err_str = ''
      FOR l_i = l_gcaf010 TO l_gcaf011
         LET l_gcao001_str = ''
         LET l_gcao001_str = l_i USING l_str
         IF NOT cl_null(l_gcaf008) THEN   #160615-00028#4 160623 by sakura add
            LET l_gcao001 = l_gcaf008,l_gcao001_str
         #160615-00028#4 160623 by sakura add(S)
         ELSE
            LET l_gcao001 = l_gcao001_str
         END IF
         #160615-00028#4 160623 by sakura add(E)
         
         LET l_gcao005 = ''
         EXECUTE ammt450_01_gcao005_curs USING l_gcao001,g_mmfe_d[l_ac].mmfe013 INTO l_gcao005
         CASE
            WHEN SQLCA.sqlcode = 100
               #此券號：%1不存在 券種基本資料 中！
               LET g_errno = 'amm-00293'
               LET g_err_str = l_gcao001
               RETURN
            WHEN l_gcao005 != '1'
               #此券號：%1的狀態不屬於發行！
               LET g_errno = 'amm-00294'
               LET g_err_str = l_gcao001
               RETURN
         END CASE
      END FOR
   END IF
   
   IF cl_null(g_errno) AND NOT cl_null(p_gcaf010) AND NOT cl_null(p_gcaf011) THEN
      LET l_gcaf010_str = p_gcaf010
      LET l_gcaf011_str = p_gcaf011
      LET l_gcaf010 = l_gcaf010_str.subString(l_gcaf007+1,l_gcaf010_str.getLength())
      LET l_gcaf011 = l_gcaf011_str.subString(l_gcaf007+1,l_gcaf011_str.getLength())
      LET g_mmfe_d[l_ac].mmfe007 = l_gcaf011 - l_gcaf010 +1
      IF cl_null(g_mmfe_d[l_ac].mmfe007) THEN
         LET g_mmfe_d[l_ac].mmfe007 = 1
      END IF
   END IF
END FUNCTION
################################################################################
# Descriptions...: 新增到贈品兌換單身檔(mmfe_t)
# Memo...........:
# Usage..........: CALL ammt450_01_ins_mmfe()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/21 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt450_01_ins_mmfe()
DEFINE l_tmp1       RECORD
       mmfeseq      LIKE mmfe_t.mmfeseq, 
       mmfe011      LIKE mmfe_t.mmfe011, 
       mmfe001      LIKE mmfe_t.mmfe001, 
       mmfe003      LIKE mmfe_t.mmfe003, 
       mmfe006      LIKE mmfe_t.mmfe006, 
       mmfe004      LIKE mmfe_t.mmfe004, 
       mmfe005      LIKE mmfe_t.mmfe005, 
       mmfe007      LIKE mmfe_t.mmfe007, 
       mmfe010      LIKE mmfe_t.mmfe010, 
       mmfe012      LIKE mmfe_t.mmfe012, 
       mmfe013      LIKE mmfe_t.mmfe013,
       mmcj007      LIKE mmcj_t.mmcj007
                    END RECORD
#DEFINE l_mmfe       RECORD LIKE mmfe_t.*  #161111-00028#1--mark
#161111-00028#1--add--begin----------------
DEFINE l_mmfe RECORD  #贈品兌換單身檔
       mmfeent LIKE mmfe_t.mmfeent, #企業編號
       mmfesite LIKE mmfe_t.mmfesite, #營運據點
       mmfeunit LIKE mmfe_t.mmfeunit, #應用組織
       mmfedocno LIKE mmfe_t.mmfedocno, #單據編號
       mmfeseq LIKE mmfe_t.mmfeseq, #項次
       mmfe001 LIKE mmfe_t.mmfe001, #商品編號
       mmfe002 LIKE mmfe_t.mmfe002, #特徵碼
       mmfe003 LIKE mmfe_t.mmfe003, #面額編號
       mmfe004 LIKE mmfe_t.mmfe004, #起始券號
       mmfe005 LIKE mmfe_t.mmfe005, #截止券號
       mmfe006 LIKE mmfe_t.mmfe006, #加價金額
       mmfe007 LIKE mmfe_t.mmfe007, #兌換份數
       mmfe008 LIKE mmfe_t.mmfe008, #總兌換數量
       mmfe009 LIKE mmfe_t.mmfe009, #加價總金額
       mmfe010 LIKE mmfe_t.mmfe010, #換贈庫位
       mmfe011 LIKE mmfe_t.mmfe011, #兌換方案組別
       mmfe012 LIKE mmfe_t.mmfe012, #資料類型
       mmfe013 LIKE mmfe_t.mmfe013 #資料編號
       END RECORD
#161111-00028#1--add--end----------------       
DEFINE l_mmfeseq    LIKE mmfe_t.mmfeseq
DEFINE l_imaa005    LIKE imaa_t.imaa005
DEFINE l_mmcj008    LIKE mmcj_t.mmcj008

   LET g_sql = "INSERT INTO mmfe_t(mmfeent ,mmfesite ,mmfeunit ,mmfedocno,",
               "                   mmfeseq ,mmfe001  ,mmfe002  ,mmfe003,",
               "                   mmfe004 ,mmfe005  ,mmfe006  ,mmfe007,",
               "                   mmfe008 ,mmfe009  ,mmfe010  ,mmfe011,",
               "                   mmfe012 ,mmfe013)",
               " VALUES(?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?)"
   PREPARE ammt450_01_insmmfe FROM g_sql
   DECLARE ammt450_01_insmmfe_curs CURSOR FOR ammt450_01_insmmfe

   LET g_sql = "SELECT mmfeseq,mmfe011,mmfe001,mmfe003,mmfe006,mmfe004,",
               "       mmfe005,mmfe007,mmfe010,mmfe012,mmfe013,mmcj007",
               "  FROM ammt450_tmp1",
               " ORDER BY mmfeseq"
   PREPARE ammt450_01_tmp1 FROM g_sql
   DECLARE ammt450_01_tmp1_curs CURSOR FOR ammt450_01_tmp1
   
   LET g_sql = "SELECT imaa005 FROM imaa_t",
               " WHERE imaaent = '",g_enterprise,"'",
               "   AND imaa001 = ?"
   PREPARE ammt450_01_imaa005 FROM g_sql
   DECLARE ammt450_01_imaa005_curs CURSOR FOR ammt450_01_imaa005
   
   LET g_sql = "SELECT mmcj008",
            "  FROM mmcj_t,mmbo_t",
            " WHERE mmcjent = ",g_enterprise,
            "   AND mmcjent = mmboent",
            "   AND mmcjdocno = mmbodocno",
            "   AND mmcj003 =?",
            "   AND mmcj004 =?",
            "   AND mmcj005 =?",
            "   AND mmbo001 = '",g_rtia.rtia044,"'",
            "   AND mmbo002 = '",g_rtia.rtia045,"'"
   PREPARE ammt450_01_mmcj008 FROM g_sql
   DECLARE ammt450_01_mmcj008_curs CURSOR FOR ammt450_01_mmcj008
   
   LET l_mmfeseq = 0
   SELECT MAX(mmfeseq)+1 INTO l_mmfeseq
     FROM mmfe_t
    WHERE mmfeent = g_enterprise
      AND mmfedocno = g_rtiadocno
   IF cl_null(l_mmfeseq) OR l_mmfeseq = 0 THEN
      LET l_mmfeseq = 1
   END IF
   INITIALIZE l_tmp1.* TO NULL
   INITIALIZE l_mmfe.* TO NULL
   FOREACH ammt450_01_tmp1_curs INTO
      l_tmp1.mmfeseq ,l_tmp1.mmfe011 ,l_tmp1.mmfe001 ,l_tmp1.mmfe003,
      l_tmp1.mmfe006 ,l_tmp1.mmfe004 ,l_tmp1.mmfe005 ,l_tmp1.mmfe007,
      l_tmp1.mmfe010 ,l_tmp1.mmfe012 ,l_tmp1.mmfe013 ,l_tmp1.mmcj007
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      #加價
      IF cl_null(l_tmp1.mmfe006) THEN
         LET l_tmp1.mmfe006 = 0
      END IF
      
      LET l_mmcj008 = ''
      EXECUTE ammt450_01_mmcj008_curs
        USING l_tmp1.mmfe011,l_tmp1.mmfe012,l_tmp1.mmfe001
         INTO l_mmcj008
      IF l_mmcj008 = '0' OR l_mmcj008 = '2' THEN
         LET l_tmp1.mmfe006 = 0
      END IF
      
      LET l_imaa005 = ''
      EXECUTE ammt450_01_imaa005_curs USING l_tmp1.mmfe001 INTO l_imaa005
      
      LET l_mmfe.mmfeent   = g_enterprise                    #企業編號
      LET l_mmfe.mmfesite  = g_rtia.rtiasite                 #營運據點
      LET l_mmfe.mmfeunit  = g_rtia.rtiasite                 #應用組織
      LET l_mmfe.mmfedocno = g_rtiadocno                     #單據編號
      LET l_mmfe.mmfeseq   = l_mmfeseq                       #項次
      LET l_mmfe.mmfe001   = l_tmp1.mmfe001                  #商品編號
      LET l_mmfe.mmfe002   = l_imaa005                       #特徵碼
      LET l_mmfe.mmfe003   = l_tmp1.mmfe003                  #券面額編號
      LET l_mmfe.mmfe004   = l_tmp1.mmfe004                  #起始券號
      LET l_mmfe.mmfe005   = l_tmp1.mmfe005                  #截止券號
      LET l_mmfe.mmfe006   = l_tmp1.mmfe006                  #加價/加積點
      LET l_mmfe.mmfe007   = l_tmp1.mmfe007                  #兌換品種數
      LET l_mmfe.mmfe008   = l_tmp1.mmfe007 * l_tmp1.mmcj007 #總兌換數量
      LET l_mmfe.mmfe009   = l_tmp1.mmfe007 * l_tmp1.mmfe006 #加價總金額
      LET l_mmfe.mmfe010   = l_tmp1.mmfe010                  #換贈庫位
      LET l_mmfe.mmfe011   = l_tmp1.mmfe011                  #組別
      LET l_mmfe.mmfe012   = l_tmp1.mmfe012                  #資料型態
      LET l_mmfe.mmfe013   = l_tmp1.mmfe013                  #資料編號
      
      EXECUTE ammt450_01_insmmfe_curs USING
         l_mmfe.mmfeent ,l_mmfe.mmfesite ,l_mmfe.mmfeunit ,l_mmfe.mmfedocno,
         l_mmfe.mmfeseq ,l_mmfe.mmfe001  ,l_mmfe.mmfe002  ,l_mmfe.mmfe003,
         l_mmfe.mmfe004 ,l_mmfe.mmfe005  ,l_mmfe.mmfe006  ,l_mmfe.mmfe007,
         l_mmfe.mmfe008 ,l_mmfe.mmfe009  ,l_mmfe.mmfe010  ,l_mmfe.mmfe011,
         l_mmfe.mmfe012 ,l_mmfe.mmfe013
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "Ins mmfe_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CONTINUE FOREACH
      END IF
      CALL ammt450_01_ins_details(l_mmfe.*)
      INITIALIZE l_tmp1.* TO NULL
      INITIALIZE l_mmfe.* TO NULL
      LET l_mmfeseq = l_mmfeseq + 1
   END FOREACH
END FUNCTION
################################################################################
# Descriptions...: 新增到銷售交易商品明細檔(rtib_t)和交易稅明細檔(xrcd_t)
# Memo...........:
# Usage..........: CALL ammt450_01_ins_details(p_mmfe)
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/24 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt450_01_ins_details(p_mmfe)
#DEFINE l_rtib          RECORD LIKE rtib_t.* #161111-00028#1--mark 
#DEFINE p_mmfe       RECORD LIKE mmfe_t.*    #161111-00028#1--mark
#161111-00028#1--add--begin----------------
DEFINE p_mmfe RECORD  #贈品兌換單身檔
       mmfeent LIKE mmfe_t.mmfeent, #企業編號
       mmfesite LIKE mmfe_t.mmfesite, #營運據點
       mmfeunit LIKE mmfe_t.mmfeunit, #應用組織
       mmfedocno LIKE mmfe_t.mmfedocno, #單據編號
       mmfeseq LIKE mmfe_t.mmfeseq, #項次
       mmfe001 LIKE mmfe_t.mmfe001, #商品編號
       mmfe002 LIKE mmfe_t.mmfe002, #特徵碼
       mmfe003 LIKE mmfe_t.mmfe003, #面額編號
       mmfe004 LIKE mmfe_t.mmfe004, #起始券號
       mmfe005 LIKE mmfe_t.mmfe005, #截止券號
       mmfe006 LIKE mmfe_t.mmfe006, #加價金額
       mmfe007 LIKE mmfe_t.mmfe007, #兌換份數
       mmfe008 LIKE mmfe_t.mmfe008, #總兌換數量
       mmfe009 LIKE mmfe_t.mmfe009, #加價總金額
       mmfe010 LIKE mmfe_t.mmfe010, #換贈庫位
       mmfe011 LIKE mmfe_t.mmfe011, #兌換方案組別
       mmfe012 LIKE mmfe_t.mmfe012, #資料類型
       mmfe013 LIKE mmfe_t.mmfe013 #資料編號
       END RECORD
DEFINE l_rtib RECORD  #銷售交易商品明細檔
       rtibent LIKE rtib_t.rtibent, #企業編號
       rtibsite LIKE rtib_t.rtibsite, #營運據點
       rtibunit LIKE rtib_t.rtibunit, #應用組織
       rtiborga LIKE rtib_t.rtiborga, #帳務組織
       rtibdocno LIKE rtib_t.rtibdocno, #單據編號
       rtibseq LIKE rtib_t.rtibseq, #項次
       rtib001 LIKE rtib_t.rtib001, #來源單號
       rtib002 LIKE rtib_t.rtib002, #來源單號項次
       rtib003 LIKE rtib_t.rtib003, #商品條碼
       rtib004 LIKE rtib_t.rtib004, #商品編號
       rtib005 LIKE rtib_t.rtib005, #特徵碼
       rtib006 LIKE rtib_t.rtib006, #稅別編號
       rtib007 LIKE rtib_t.rtib007, #銷售開立發票
       rtib008 LIKE rtib_t.rtib008, #標準售價
       rtib009 LIKE rtib_t.rtib009, #促銷售價
       rtib010 LIKE rtib_t.rtib010, #交易售價
       rtib011 LIKE rtib_t.rtib011, #成本售價
       rtib012 LIKE rtib_t.rtib012, #銷售數量
       rtib013 LIKE rtib_t.rtib013, #銷售單位
       rtib014 LIKE rtib_t.rtib014, #庫存數量
       rtib015 LIKE rtib_t.rtib015, #庫存單位
       rtib016 LIKE rtib_t.rtib016, #銷售庫存單位換算率
       rtib017 LIKE rtib_t.rtib017, #計價數量
       rtib018 LIKE rtib_t.rtib018, #計價單位
       rtib019 LIKE rtib_t.rtib019, #銷售計價單位換算率
       rtib020 LIKE rtib_t.rtib020, #折價金額
       rtib021 LIKE rtib_t.rtib021, #應收金額
       rtib022 LIKE rtib_t.rtib022, #未稅金額
       rtib023 LIKE rtib_t.rtib023, #成本金額
       rtib024 LIKE rtib_t.rtib024, #理由碼
       rtib025 LIKE rtib_t.rtib025, #庫區
       rtib026 LIKE rtib_t.rtib026, #儲位
       rtib027 LIKE rtib_t.rtib027, #批號
       rtib028 LIKE rtib_t.rtib028, #專櫃編號
       rtib029 LIKE rtib_t.rtib029, #分攤積點
       rtib030 LIKE rtib_t.rtib030, #卡券銷售明細對應項次
       rtib031 LIKE rtib_t.rtib031, #本幣應收金額
       rtib032 LIKE rtib_t.rtib032, #庫存管理特徵
       rtib033 LIKE rtib_t.rtib033, #營業員
       rtib034 LIKE rtib_t.rtib034, #掃描碼
       rtib035 LIKE rtib_t.rtib035, #交易類型
       rtib036 LIKE rtib_t.rtib036, #商品屬性
       rtib037 LIKE rtib_t.rtib037, #捆綁條碼項次
       rtib038 LIKE rtib_t.rtib038, #結算扣率
       rtib039 LIKE rtib_t.rtib039, #贈品否
       rtib040 LIKE rtib_t.rtib040, #卡種/券種編號
       rtib041 LIKE rtib_t.rtib041, #卡號/券號
       rtib101 LIKE rtib_t.rtib101, #退貨退回商品(租賃)
       rtib102 LIKE rtib_t.rtib102, #產品品類(租賃)
       rtib103 LIKE rtib_t.rtib103, #品牌(租賃)
       rtib104 LIKE rtib_t.rtib104, #商戶編號(租賃)
       rtib105 LIKE rtib_t.rtib105, #合約編號(租賃)
       rtib106 LIKE rtib_t.rtib106, #單位兌換積分
       rtib107 LIKE rtib_t.rtib107, #促銷單位兌換積分
       rtib108 LIKE rtib_t.rtib108, #總兌換積分
       rtib042 LIKE rtib_t.rtib042, #退貨方式
       rtib043 LIKE rtib_t.rtib043, #發票編號
       rtib044 LIKE rtib_t.rtib044, #發票號碼
       rtib109 LIKE rtib_t.rtib109  #返現金額
       END RECORD
#161111-00028#1--add--end----------------  

DEFINE l_rtibseq       LIKE rtib_t.rtibseq
DEFINE r_success       LIKE type_t.num5
DEFINE r_rate          LIKE inaj_t.inaj014
DEFINE l_xrcd103       LIKE xrcd_t.xrcd103
DEFINE l_xrcd104       LIKE xrcd_t.xrcd104
DEFINE l_xrcd105       LIKE xrcd_t.xrcd105
DEFINE l_xrcd113       LIKE xrcd_t.xrcd113
DEFINE l_xrcd114       LIKE xrcd_t.xrcd114
DEFINE l_xrcd115       LIKE xrcd_t.xrcd115
DEFINE l_xrcd123       LIKE xrcd_t.xrcd113 
DEFINE l_xrcd124       LIKE xrcd_t.xrcd114 
DEFINE l_xrcd125       LIKE xrcd_t.xrcd115 
DEFINE l_xrcd133       LIKE xrcd_t.xrcd113 
DEFINE l_xrcd134       LIKE xrcd_t.xrcd114 
DEFINE l_xrcd135       LIKE xrcd_t.xrcd115 
DEFINE l_cnt           LIKE type_t.num5
DEFINE l_imaa001       LIKE imaa_t.imaa001
DEFINE l_gcaf012       LIKE gcaf_t.gcaf012

   LET g_sql = "INSERT INTO rtib_t(rtibent ,rtibsite ,rtibunit ,rtibdocno,",
               "                   rtibseq ,rtib001  ,rtib002  ,rtib003,",
               "                   rtib004 ,rtib005  ,rtib006  ,rtib007,",
               "                   rtib008 ,rtib009  ,rtib010  ,rtib011,",
               "                   rtib012 ,rtib013  ,rtib014  ,rtib015,",
               "                   rtib016 ,rtib017  ,rtib018  ,rtib019,",
               "                   rtib020 ,rtib021  ,rtib022  ,rtib023,",
               "                   rtib024 ,rtib025  ,rtib026  ,rtib027,",
               "                   rtib028 ,rtib029  ,rtib030)",
               " VALUES(?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?)"
   PREPARE ammt450_01_insrtib FROM g_sql
   DECLARE ammt450_01_insrtib_curs CURSOR FOR ammt450_01_insrtib

   LET g_sql = "SELECT mmfeseq,mmfe001,mmfe002,mmfe008,",
               "       mmfe009,mmfe010,mmfe012,mmfe013",
               "  FROM mmfe_t",
               " WHERE mmfeent = '",g_enterprise,"'",
               "   AND mmfedocno = '",g_rtiadocno,"'",
               " ORDER BY mmfeseq"
   PREPARE ammt450_01_mmfe FROM g_sql
   DECLARE ammt450_01_mmfe_curs CURSOR FOR ammt450_01_mmfe
   
   LET g_sql = "SELECT COUNT(*) FROM ammt450_tmp1 WHERE mmfeseq = ?"
   PREPARE ammt450_01_tmp1_chk FROM g_sql
   DECLARE ammt450_01_tmp1_chk_curs CURSOR FOR ammt450_01_tmp1_chk
   #sakura---modify---S 銷售計價單位由原本 rtdx033 改抓 imaa106 單號：150312-00002#3
   #商品條碼(rtdx002)、銷項稅目(rtdx014)、計價單位(imaa106)
   #LET g_sql = "SELECT rtdx002,rtdx014,rtdx033",
   #            "  FROM rtdx_t",
   LET g_sql = "SELECT rtdx002,rtdx014,imaa106",
               "  FROM rtdx_t",
			      "   LEFT OUTER JOIN imaa_t ON rtdxent = imaaent AND rtdx001 = imaa001 ",               
               " WHERE rtdxent = '",g_enterprise,"'",
               "   AND rtdxsite = '",g_rtia.rtiasite,"'",
               "   AND rtdx001 = ?"
   #sakura---modify---E 銷售計價單位由原本 rtdx033 改抓 imaa106 單號：150312-00002#3               
   PREPARE ammt450_01_rtdx1 FROM g_sql
   DECLARE ammt450_01_rtdx1_curs CURSOR FOR ammt450_01_rtdx1
 
   #庫存單位(imaa104)、銷售單位(imaa105)
   LET g_sql = "SELECT imaa104,imaa105",
               "  FROM imaa_t",
               " WHERE imaaent = '",g_enterprise,"'",
               "   AND imaa001 = ?"
   PREPARE ammt450_01_imaa FROM g_sql
   DECLARE ammt450_01_imaa_curs CURSOR FOR ammt450_01_imaa
   
   LET l_rtibseq = 0
   SELECT MAX(rtibseq)+1 INTO l_rtibseq
     FROM rtib_t
    WHERE rtibent = g_enterprise
      AND rtibdocno = g_rtiadocno
   IF cl_null(l_rtibseq) OR l_rtibseq = 0 THEN
      LET l_rtibseq = 1
   END IF
      
   LET l_rtib.rtibent  = g_enterprise                     #企業編號
   LET l_rtib.rtibsite = g_rtia.rtiasite                  #營運據點
   LET l_rtib.rtibunit = g_rtia.rtiasite                  #應用組織
   LET l_rtib.rtibdocno = g_rtiadocno                     #單據編號
   LET l_rtib.rtibseq  = l_rtibseq                        #項次
   LET l_rtib.rtib004  = p_mmfe.mmfe001                   #商品編號
   CASE
      #卡
      WHEN p_mmfe.mmfe012 = 'M'
         LET l_imaa001 = ''
         EXECUTE ammt450_01_mman053_curs USING p_mmfe.mmfe013 INTO l_imaa001
         LET l_rtib.rtib004  = l_imaa001
      #券
      WHEN p_mmfe.mmfe012 = 'N'
         LET l_imaa001 = ''
         LET l_gcaf012 = ''
         EXECUTE ammt450_01_gcaf013_curs USING p_mmfe.mmfe013 INTO l_imaa001,l_gcaf012
         LET l_rtib.rtib004  = l_imaa001
      #積點
      WHEN p_mmfe.mmfe012 = 'O'
         LET l_imaa001 = ''
         EXECUTE ammt450_01_mman060_curs USING  p_mmfe.mmfe013 INTO l_imaa001
         LET l_rtib.rtib004  = l_imaa001
      
      #送抵現值
      WHEN p_mmfe.mmfe012 = 'P'
         LET l_imaa001 = ''
         EXECUTE ammt450_01_mman054_curs USING  p_mmfe.mmfe013 INTO l_imaa001
         LET l_rtib.rtib004  = l_imaa001
   END CASE
   
   #商品條碼(rtib003)、稅別(rtib006)、計價單位(rtib018)
   EXECUTE ammt450_01_rtdx1_curs USING l_rtib.rtib004
      INTO l_rtib.rtib003,l_rtib.rtib006,l_rtib.rtib018
      
   LET l_rtib.rtib005 = p_mmfe.mmfe002                    #特徵碼
   LET l_rtib.rtib008 = p_mmfe.mmfe009 / p_mmfe.mmfe008   #標準售價
   LET l_rtib.rtib009 = p_mmfe.mmfe009 / p_mmfe.mmfe008   #促銷價
   LET l_rtib.rtib010 = p_mmfe.mmfe009 / p_mmfe.mmfe008   #交易價
   LET l_rtib.rtib012 = p_mmfe.mmfe008                    #數量
   
   #庫存單位(rtib013)、銷售單位(rtib015)
   EXECUTE ammt450_01_imaa_curs USING l_rtib.rtib004
      INTO l_rtib.rtib013,l_rtib.rtib015
      
   #銷售庫存單位換算率(rtib016)
   CALL s_aimi190_get_convert(l_rtib.rtib004,l_rtib.rtib015,l_rtib.rtib013)
      RETURNING r_success,r_rate
   IF r_success THEN
      LET l_rtib.rtib016 = r_rate
   END IF
   
   #銷售計價單位換算率(rtib019)
   CALL s_aimi190_get_convert(l_rtib.rtib004,l_rtib.rtib018,l_rtib.rtib013)
      RETURNING r_success,r_rate
   IF r_success THEN
      LET l_rtib.rtib019 = r_rate
   END IF
   
   #折扣金額(rtib020) = ([C:標準售價]rtib008-[C:交易價]rtib010)* 數量rtib012
   LET l_rtib.rtib020 = (l_rtib.rtib008 - l_rtib.rtib010) * l_rtib.rtib012
   
   #應收金額(rtib021) = [C:數量]rtib012*[C:交易價]rtib010
   LET l_rtib.rtib021 = l_rtib.rtib012 * l_rtib.rtib010
   
   LET l_xrcd103 = ''
   LET l_xrcd104 = ''
   LET l_xrcd105 = ''
   LET l_xrcd113 = ''
   LET l_xrcd114 = ''
   LET l_xrcd115 = ''
   LET l_xrcd123 = '' 
   LET l_xrcd124 = '' 
   LET l_xrcd125 = '' 
   LET l_xrcd133 = '' 
   LET l_xrcd134 = '' 
   LET l_xrcd135 = '' 
                   #單號      項次           項次2 營運據點         應收金額
   CALL s_tax_ins(g_rtiadocno,p_mmfe.mmfeseq,"0", g_rtia.rtiasite,l_rtib.rtib021,
                  #稅別           數量           幣別             匯率          帳套 匯率2(AR/AP使用) 匯率3(AR/AP使用)
                  l_rtib.rtib006,l_rtib.rtib012,g_rtia.rtia026,g_rtia.rtia027,' ', '',             '')
             #原幣未稅金額  原幣稅額   原幣含稅金額 本幣未稅金額(AR/AP使用) 本幣稅額(AR/AP使用) 本幣含稅金額(AR/AP使用)
   RETURNING l_xrcd103,    l_xrcd104, l_xrcd105,   l_xrcd113,              l_xrcd114,          l_xrcd115,
             #本幣2未稅金額(AR/AP使用) 本幣2稅額(AR/AP使用)  本幣2含稅金額(AR/AP使用)  本幣3未稅金額(AR/AP使用)
             l_xrcd123,               l_xrcd124,           l_xrcd125,              l_xrcd133,
             #本幣3稅額(AR/AP使用)  本幣3含稅金額(AR/AP使用)
             l_xrcd134,            l_xrcd135
   
   #未稅金額(rtib022) = 應收金額(rtib021) - 同項次 sum([T:交易稅明細檔][C:稅額],若無資料則 Default 0 ,不允許空白
   
   IF cl_null(l_xrcd104) THEN
      LET l_xrcd104 = 0
   END IF
   LET l_rtib.rtib022 = l_rtib.rtib021 - l_xrcd104
   
   #庫區(rtib025)
   LET l_rtib.rtib025 = p_mmfe.mmfe010
   
   #對應卡券換贈項次(rtib030)
   LET l_rtib.rtib030 = p_mmfe.mmfeseq
   
   EXECUTE ammt450_01_insrtib_curs USING
      l_rtib.rtibent ,l_rtib.rtibsite ,l_rtib.rtibunit ,l_rtib.rtibdocno,
      l_rtib.rtibseq ,l_rtib.rtib001  ,l_rtib.rtib002  ,l_rtib.rtib003,
      l_rtib.rtib004 ,l_rtib.rtib005  ,l_rtib.rtib006  ,l_rtib.rtib007,
      l_rtib.rtib008 ,l_rtib.rtib009  ,l_rtib.rtib010  ,l_rtib.rtib011,
      l_rtib.rtib012 ,l_rtib.rtib013  ,l_rtib.rtib014  ,l_rtib.rtib015,
      l_rtib.rtib016 ,l_rtib.rtib017  ,l_rtib.rtib018  ,l_rtib.rtib019,
      l_rtib.rtib020 ,l_rtib.rtib021  ,l_rtib.rtib022  ,l_rtib.rtib023,
      l_rtib.rtib024 ,l_rtib.rtib025  ,l_rtib.rtib026  ,l_rtib.rtib027,
      l_rtib.rtib028 ,l_rtib.rtib029  ,l_rtib.rtib030
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "Ins rtib_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF
   
END FUNCTION
################################################################################
# Descriptions...: 檢查剩餘點數是否可以兌換此組別商品
# Memo...........:
# Usage..........: CALL ammt450_01_chk_count()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/21 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt450_01_chk_count()
DEFINE l_sum_mmci004       LIKE mmci_t.mmci004
DEFINE l_rtia0471          LIKE rtia_t.rtia047

   LET g_errno = ''
   IF cl_null(g_mmfe_d_o.mmfe007) THEN
      LET g_mmfe_d_o.mmfe007 = 0
   END IF
   LET l_sum_mmci004 = g_mmci004 * (g_mmfe_d[l_ac].mmfe007 - g_mmfe_d_o.mmfe007)
   IF cl_null(l_sum_mmci004) THEN
      LET l_sum_mmci004 = 0
   END IF
   #160705-00042#11 160714 by sakura mark(S)   
   #CASE g_prog
   #   WHEN 'ammt450'
   #160705-00042#11 160714 by sakura mark(E)
   #160705-00042#11 160714 by sakura add(S)      
   CASE 
      WHEN g_prog MATCHES 'ammt450'
   #160705-00042#11 160714 by sakura add(E)      
         LET l_rtia0471 = g_rtia.rtia043 - g_rtia.rtia047
         IF l_sum_mmci004 > l_rtia0471 THEN
            #此組別的累計積點>剩餘點數，不可以兌換！
            LET g_errno = 'amm-00279'
            RETURN
         END IF
      OTHERWISE
         LET l_rtia0471 = g_rtia.rtia046 - g_rtia.rtia047
         IF l_sum_mmci004 > l_rtia0471 THEN
            #此組別的累計消費額>該規則計算總累消，不可以兌換！
            LET g_errno = 'amm-00313'
            RETURN
         END IF
   END CASE

END FUNCTION
################################################################################
# Descriptions...: 單一兌換比率 分段兌換比率
# Memo...........:
# Usage..........: CALL ammt450_01_mmby010()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/24 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt450_01_mmby010()
DEFINE l_count     LIKE type_t.num5

   LET g_errno = ''
   LET l_count = 0
   CASE g_mmby010
      #單一兌換比率
      WHEN '1'
         EXECUTE ammt450_01_count1_curs USING g_mmfe_d[l_ac].mmfe011 INTO l_count
          IF l_count >= 1 THEN
            #換贈方式為單一兌換比例，只可以選擇兌換一項組別商品！
            LET g_errno = 'amm-00281'
            RETURN
         END IF
         
         LET l_count = 0
         EXECUTE ammt450_01_count_curs USING g_mmfe_d[l_ac].mmfe011 INTO l_count
         IF l_count >= 1 THEN
            #換贈方式為單一兌換比例，只可以選擇兌換一項組別商品！
            LET g_errno = 'amm-00281'
            RETURN
         END IF
         
      #分段兌換比率
      WHEN '2'
         IF g_mmfe_d[l_ac].mmfe011 > g_mmci003 THEN
            #換贈方式為分段兌換比例，兌換的累積金額不足，只可兌換等於小於%1的組別！
            LET g_errno = 'amm-00282'
         END IF
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 確認輸入的卡號是否符合
# Memo...........:
# Usage..........: CALL ammt450_01_chk_mman(p_mmfe004,p_mmfe005)
# Input parameter: p_mmfe004 起始卡號
#                  p_mmfe005 截止卡號
# Return code....: 無
# Date & Author..: 2014/03/25 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt450_01_chk_mman(p_mmfe004,p_mmfe005)
DEFINE p_mmfe004               LIKE mmfe_t.mmfe004
DEFINE p_mmfe005               LIKE mmfe_t.mmfe005
DEFINE l_mmfe004               LIKE type_t.num5
DEFINE l_mmfe005               LIKE type_t.num5
DEFINE l_mmanstus              LIKE mman_t.mmanstus
DEFINE l_mman005               LIKE mman_t.mman005
DEFINE l_mman006               LIKE mman_t.mman006
DEFINE l_mman007               LIKE mman_t.mman007
DEFINE l_mman008               LIKE mman_t.mman008
DEFINE l_mman016               LIKE mman_t.mman016
DEFINE l_mman007_str           STRING
DEFINE l_mmfe004_str           STRING
DEFINE l_mmfe005_str           STRING
DEFINE r_success               LIKE type_t.chr1
DEFINE l_mmaq001               LIKE mmaq_t.mmaq001
DEFINE l_mmaq006               LIKE mmaq_t.mmaq006
DEFINE l_mmaq001_str           STRING
DEFINE l_str                   STRING
DEFINE l_i                     LIKE type_t.num5

   LET g_errno = ''
   IF NOT cl_null(p_mmfe004) AND NOT cl_null(p_mmfe005) THEN
      IF p_mmfe004 > p_mmfe005 THEN
         #開始卡號不可大於結束卡號
         LET g_errno = 'amm-00287'
         RETURN
      END IF
   END IF
   
   LET l_mmanstus = ''
   LET l_mman005 = ''
   LET l_mman006 = ''
   LET l_mman007 = ''
   LET l_mman008 = ''
   LET l_mman016 = ''
   SELECT mman005,mman006,mman007,mman008,mman016,mmanstus
     INTO l_mman005,l_mman006,l_mman007,l_mman008,l_mman016,l_mmanstus
     FROM mman_t
    WHERE mmanent = g_enterprise
      AND mman001 = g_mmfe_d[l_ac].mmfe013
   CASE
      WHEN SQLCA.sqlcode = 100
         #會員卡種編號不在 會員卡種資料檔 中
         LET g_errno = 'amm-00003'
         RETURN
      
      WHEN l_mmanstus != 'Y'
         #會員卡種編號未確認或無效！
         LET g_errno = 'amm-00004'
         RETURN
   END CASE
   
   LET l_mmfe004_str = p_mmfe004
   LET l_mmfe005_str = p_mmfe005
   LET l_mmfe004 = l_mmfe004_str.getLength()
   LET l_mmfe005 = l_mmfe005_str.getLength()
   IF l_mmfe004 != l_mman005 AND NOT cl_null(p_mmfe004) THEN
      #卡號的長度不符合卡種：%1的設定長度！
      LET g_errno = 'amm-00286'
      RETURN
   END IF
   IF l_mmfe005 != l_mman005 AND NOT cl_null(p_mmfe005) THEN
      #卡號的長度不符合卡種：%1的設定長度！
      LET g_errno = 'amm-00286'
      RETURN
   END IF
   
   LET l_mmfe004_str = p_mmfe004
   LET l_mmfe005_str = p_mmfe005
   LET l_mman007_str = l_mmfe004_str.subString(1,l_mman006)
   IF l_mman007 != l_mman007_str THEN
      #輸入的卡號與卡種編號：％１的固定代碼不相同！
      LET g_errno = 'amm-00285'
      RETURN
   END IF
   LET l_mman007_str = l_mmfe005_str.subString(1,l_mman006)
   IF l_mman007 != l_mman007_str THEN
      #輸入的卡號與卡種編號：％１的固定代碼不相同！
      LET g_errno = 'amm-00285'
      RETURN
   END IF
   LET l_mmfe004_str = p_mmfe004
   LET l_mmfe005_str = p_mmfe005
   LET l_mman007_str = l_mmfe004_str.subString(l_mman006+1,l_mmfe004_str.getLength())
   IF NOT cl_null(l_mman007_str) THEN
      CALL cl_chk_num(l_mman007_str,'N') RETURNING r_success
      IF NOT r_success THEN
         #流水號中含有非數字字符,請檢查！
         LET g_errno  = 'anm-00098'
         RETURN
      END IF
   END IF
   
   LET l_mman007_str = l_mmfe005_str.subString(l_mman006+1,l_mmfe005_str.getLength())
   IF NOT cl_null(l_mman007_str) THEN
      CALL cl_chk_num(l_mman007_str,'N') RETURNING r_success
      IF NOT r_success THEN
         #流水號中含有非數字字符,請檢查！
         LET g_errno  = 'anm-00098'
         RETURN
      END IF
   END IF
   
   #檢查卡號是否已存在，開卡狀態
   LET g_sql = "SELECT mmaq006 FROM mmaq_t WHERE mmaqent = '",g_enterprise,"' AND mmaq001 = ? AND mmaq002 = ? "
   PREPARE ammt450_01_mmaq006 FROM g_sql
   DECLARE ammt450_01_mmaq006_curs CURSOR FOR ammt450_01_mmaq006
   
   #卡號
   IF cl_null(p_mmfe005) THEN
      LET p_mmfe005 = p_mmfe004
   END IF
   IF NOT cl_null(p_mmfe004) AND NOT cl_null(p_mmfe005) THEN
      LET l_str = ''
      FOR l_i = 1 TO l_mman008
          LET l_str = l_str , "&"
      END FOR
      LET l_mmfe004_str = p_mmfe004
      LET l_mmfe005_str = p_mmfe005
      LET l_mmfe004 = l_mmfe004_str.subString(l_mman006+1,l_mmfe004_str.getLength())
      LET l_mmfe005 = l_mmfe005_str.subString(l_mman006+1,l_mmfe005_str.getLength()) 
      LET g_err_str = ''
      FOR l_i = l_mmfe004 TO l_mmfe005
         LET l_mmaq001_str = ''
         LET l_mmaq001_str = l_i USING l_str
         LET l_mmaq001 = l_mman007,l_mmaq001_str
         LET l_mmaq006 = ''
         EXECUTE ammt450_01_mmaq006_curs USING l_mmaq001,g_mmfe_d[l_ac].mmfe013 INTO l_mmaq006
         CASE
            WHEN SQLCA.sqlcode = 100
               #此會員卡號：%1不存在 會員卡資料檔 中
               LET g_errno = 'amm-00291'
               LET g_err_str = l_mmaq001
               RETURN
            WHEN l_mmaq006 != '1'
               #此會員卡號：%1的狀態不屬於發卡！
               LET g_errno = 'amm-00292'
               LET g_err_str = l_mmaq001
               RETURN
         END CASE
      END FOR
   END IF
   
   #計算張數
   IF cl_null(g_errno) AND NOT cl_null(p_mmfe004) AND NOT cl_null(p_mmfe005) THEN
      LET l_mmfe004_str = p_mmfe004
      LET l_mmfe005_str = p_mmfe005
      LET l_mmfe004 = l_mmfe004_str.subString(l_mman006+1,l_mmfe004_str.getLength())
      LET l_mmfe005 = l_mmfe005_str.subString(l_mman006+1,l_mmfe005_str.getLength())
      LET g_mmfe_d[l_ac].mmfe007 = l_mmfe005 - l_mmfe004 +1
      IF cl_null(g_mmfe_d[l_ac].mmfe007) THEN
         LET g_mmfe_d[l_ac].mmfe007 = 1
      END IF
   END IF
END FUNCTION
################################################################################
# Descriptions...: 券面額編號說明
# Memo...........:
# Usage..........: CALL ammt450_01_mmfe003_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/25 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt450_01_mmfe003_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mmfe_d[l_ac].mmfe003
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2071' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mmfe_d[l_ac].mmfe003_desc = '', g_rtn_fields[1] , ''
END FUNCTION

################################################################################
# Descriptions...: 計算剩餘點數
# Memo...........:
# Usage..........: CALL ammt450_01_recount()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/02 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt450_01_recount()
DEFINE l_mmci004       LIKE mmci_t.mmci004
DEFINE l_mmfe007       LIKE mmfe_t.mmfe007
DEFINE l_cnt           LIKE type_t.num5

   LET l_mmci004 = ''
   #IF g_mmfe_d[l_ac].sel = 'Y' AND g_mmfe_d_t.sel = 'N' THEN
      EXECUTE ammt450_01_mmci004_curs INTO l_mmci004
   #END IF
   IF cl_null(l_mmci004) THEN
      LET l_mmci004 = 0
   END IF
   LET l_mmfe007 = g_mmfe_d[l_ac].mmfe007
   IF cl_null(l_mmfe007) THEN
      LET l_mmfe007 = 0
   END IF
   
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM ammt450_tmp1
    WHERE mmfeseq = g_mmfe_d[l_ac].mmfeseq
   IF g_mmfe_d[l_ac].sel = 'N' AND l_cnt>=1 THEN
      LET g_rtia.rtia047 = l_mmci004 + g_sum_mmci004 - g_mmci004 * g_mmfe007
   ELSE
      IF g_mmfe_d[l_ac].sel = 'Y' AND g_mmfe_d_t.sel = 'Y' THEN
         LET g_rtia.rtia047 = l_mmci004 + g_sum_mmci004
      ELSE
         LET g_rtia.rtia047 = l_mmci004 + g_sum_mmci004 + g_mmci004 * l_mmfe007
      END IF
   END IF
   #LET g_rtia.rtia047 = l_mmci004 + g_sum_mmci004 + g_mmci004 * l_mmfe007
   #160705-00042#11 160714 by sakura mark(S)   
   #CASE g_prog
   #   WHEN 'ammt450'
   #160705-00042#11 160714 by sakura mark(E)
   #160705-00042#11 160714 by sakura add(S)
   CASE 
      WHEN g_prog MATCHES 'ammt450'
   #160705-00042#11 160714 by sakura add(E)      
         LET g_rtia.rtia0471 = g_rtia.rtia043 - g_rtia.rtia047
      OTHERWISE
         LET g_rtia.rtia0471 = g_rtia.rtia046 - g_rtia.rtia047
   END CASE
   DISPLAY BY NAME g_rtia.rtia047,g_rtia.rtia0471
END FUNCTION

################################################################################
# Descriptions...: 確認剩餘積點/金額是否有可兌換的商品
# Memo...........:
# Usage..........: CALL ammt450_01_chk_exchange()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/09 By pomelo
# Modify.........: 2016/10/03 by lori     新增mmci006處理
################################################################################
PUBLIC FUNCTION ammt450_01_chk_exchange()
DEFINE l_cnt             LIKE type_t.num5
DEFINE l_mmci003         LIKE mmci_t.mmci003
DEFINE l_mmci004         LIKE mmci_t.mmci004
DEFINE l_sum_mmci004     LIKE mmci_t.mmci004
DEFINE l_rtia043         LIKE rtia_t.rtia043

   LET g_mmci003 = 0
   LET g_sql = "SELECT mmci003,mmci004",
               "  FROM mmbo_t,mmby_t,mmci_t",
               " WHERE mmboent = mmcient",
               "   AND mmbo001 = mmci001",
               "   AND mmbodocno = mmcidocno",
               "   AND mmboent = mmbyent",
               "   AND mmbo001 = mmby001",
               "   AND mmbo002 = mmby002",
               "   AND mmboent = ",g_enterprise,
               "   AND mmbostus = 'Y'",
               "   AND mmbo001 = '",g_rtia.rtia044,"'",
               "   AND mmbo002 = '",g_rtia.rtia045,"'",
               "   AND mmbysite = '",g_rtia.rtiasite,"'",
               "   AND mmciacti = 'Y'",
               "   AND mmbystus = 'Y'",
               "   AND ('",g_mmby024,"' = 'N' ",                                    #160819-00054#14 161003 by lori add
               "     OR ('",g_mmby024,"' = 'Y' AND mmci006 = '",g_rtia066,"')) ",   #160819-00054#14 161003 by lori add               
               " ORDER BY mmci003"
   PREPARE ammt450_01_chk_exchange FROM g_sql
   DECLARE ammt450_01_chk_exchange_curs CURSOR FOR ammt450_01_chk_exchange
   
   #160705-00042#11 160714 by sakura mark(S)   
   #CASE g_prog
   #   WHEN 'ammt450'
   #160705-00042#11 160714 by sakura mark(E)
   #160705-00042#11 160714 by sakura add(S)
   CASE 
      WHEN g_prog MATCHES 'ammt450'
   #160705-00042#11 160714 by sakura add(E)      
         LET l_rtia043 = g_rtia.rtia043
      OTHERWISE
         LET l_rtia043 = g_rtia.rtia046
   END CASE
   
   LET l_cnt = 0
   CASE g_mmby010
      #單一兌換比例
      WHEN '1'
         LET l_mmci003 = ''
         LET l_mmci004 = ''
         FOREACH ammt450_01_chk_exchange_curs INTO l_mmci003,l_mmci004
            IF SQLCA.sqlcode THEN
               RETURN
            END IF
            
            IF l_rtia043 >= l_mmci004 THEN
               LET g_mmci003 = l_mmci003
            END IF
            
            LET l_mmci003 = ''
            LET l_mmci004 = ''
         END FOREACH
      #分段兌換比例
      WHEN '2'
         LET l_mmci003 = ''
         LET l_mmci004 = ''
         LET l_sum_mmci004 = 0
         FOREACH ammt450_01_chk_exchange_curs INTO l_mmci003,l_mmci004
            IF SQLCA.sqlcode THEN
               RETURN
            END IF
            
            LET l_sum_mmci004 = l_sum_mmci004 + l_mmci004
            IF l_rtia043 >= l_sum_mmci004 THEN
               LET g_mmci003 = l_mmci003
            END IF
            
            LET l_mmci003 = ''
            LET l_mmci004 = ''
         END FOREACH
         
      OTHERWISE
         RETURN
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 當分段兌換比例時 確認選擇的組別是否正確
# Memo...........:
# Usage..........: CALL ammt450_01_chk_sel()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/05/08 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt450_01_chk_sel()
DEFINE l_max         LIKE type_t.num5
DEFINE l_sql         STRING
DEFINE l_mmfe011     LIKE type_t.num5
DEFINE l_n           LIKE type_t.num5

   LET l_max = 0
   SELECT MAX(mmfe011) INTO l_max
     FROM ammt450_tmp1
   IF cl_null(l_max) THEN
      LET l_max = 0
   END IF
   LET l_sql = "SELECT mmfe011",
               "  FROM ammt450_tmp1",
               " WHERE mmfe011 <=",l_max," ORDER BY mmfe011"
   PREPARE ammt450_01_sel FROM l_sql
   DECLARE ammt450_01_sel_curs CURSOR FOR ammt450_01_sel
   
   LET l_n = 1
   FOREACH ammt450_01_sel_curs INTO l_mmfe011
      IF l_n = l_mmfe011 THEN
         LET l_n = l_n + 1
      ELSE
         LET g_errno = 'amm-00408'
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = g_errno
         LET g_errparam.extend = NULL
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN
      END IF
   END FOREACH
END FUNCTION

 
{</section>}
 
