#該程式未解開Section, 採用最新樣板產出!
{<section id="apmt840_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2014-12-02 14:37:17), PR版次:0003(2016-04-25 15:10:50)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000072
#+ Filename...: apmt840_01
#+ Description: 維護多交期明細子作業
#+ Creator....: 04226(2014-11-30 16:57:37)
#+ Modifier...: 04226 -SD/PR- 07959
 
{</section>}
 
{<section id="apmt840_01.global" >}
#應用 c02b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#42  2016/04/25  By pengxin  將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
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
PRIVATE TYPE type_g_pmdq_d        RECORD
       pmdqsite LIKE pmdq_t.pmdqsite, 
   pmdqdocno LIKE pmdq_t.pmdqdocno, 
   pmdqseq LIKE pmdq_t.pmdqseq, 
   pmdqseq2 LIKE pmdq_t.pmdqseq2, 
   pmdq008 LIKE pmdq_t.pmdq008, 
   pmdq201 LIKE pmdq_t.pmdq201, 
   pmdq201_desc LIKE type_t.chr500, 
   pmdq202 LIKE pmdq_t.pmdq202, 
   l_pmdn006 LIKE type_t.chr10, 
   l_pmdn006_desc LIKE type_t.chr500, 
   pmdq002 LIKE pmdq_t.pmdq002, 
   pmdq003 LIKE pmdq_t.pmdq003, 
   pmdq004 LIKE pmdq_t.pmdq004, 
   pmdq005 LIKE pmdq_t.pmdq005, 
   pmdq006 LIKE pmdq_t.pmdq006, 
   pmdq006_desc LIKE type_t.chr500, 
   pmdq007 LIKE pmdq_t.pmdq007
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_pmdq_d_o            type_g_pmdq_d
DEFINE g_pmdn                RECORD
       pmdqdocno             LIKE pmdq_t.pmdqdocno,   #單據編號
       pmdqseq               LIKE pmdq_t.pmdqseq,     #項次
       pmdnsite              LIKE pmdn_t.pmdnsite,    #營運據點
       pmdnunit              LIKE pmdn_t.pmdnunit,    #出貨組織
       pmdn001               LIKE pmdn_t.pmdn001,     #商品編號
       pmdn006               LIKE pmdn_t.pmdn006,     #採購單位
       pmdn007               LIKE pmdn_t.pmdn007,     #採購數量
       pmdn024               LIKE pmdn_t.pmdn024,     #多交期
       pmdn201               LIKE pmdn_t.pmdn201,     #包裝單位
       pmdn202               LIKE pmdn_t.pmdn202,     #包裝數量
       pmdn020               LIKE pmdn_t.pmdn020      #緊急度
                             END RECORD
DEFINE g_total               RECORD
       pmdn007               LIKE pmdn_t.pmdn007,    #收貨數量
       pmdn202               LIKE pmdn_t.pmdn202     #包裝收貨數量
                             END RECORD
#end add-point
 
DEFINE g_pmdq_d          DYNAMIC ARRAY OF type_g_pmdq_d
DEFINE g_pmdq_d_t        type_g_pmdq_d
 
 
DEFINE g_pmdqdocno_t   LIKE pmdq_t.pmdqdocno    #Key值備份
DEFINE g_pmdqseq_t      LIKE pmdq_t.pmdqseq    #Key值備份
DEFINE g_pmdqseq2_t      LIKE pmdq_t.pmdqseq2    #Key值備份
 
 
DEFINE l_ac                  LIKE type_t.num10
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rec_b               LIKE type_t.num10 
DEFINE g_detail_idx          LIKE type_t.num10
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
    
#add-point:傳入參數說明(global.argv) name="global.argv"
#請依照順序呼叫此Function
#1.CALL apmt840_01_create_temp_table()
#2.CALL s_transaction_begin()
#3.CALL apmt840_01()
#4.CALL s_transaxtion_end('Y',0)
#5.CALL apmt840_01_drop_temp_table()
#end add-point    
 
{</section>}
 
{<section id="apmt840_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION apmt840_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_pmdqdocno,    #單據編號
   p_pmdqseq,      #項次
   p_pmdnsite,     #營運據點
   p_pmdnunit,     #出貨組織
   p_pmdn001,      #商品編號
   p_pmdn006,      #採購單位
   p_pmdn007,      #採購數量
   p_pmdn024,      #多交期
   p_pmdn201,      #包裝單位
   p_pmdn202       #包裝數量
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
   DEFINE p_pmdqdocno     LIKE pmdq_t.pmdqdocno   #單據編號
   DEFINE p_pmdqseq       LIKE pmdq_t.pmdqseq     #項次
   DEFINE p_pmdnsite      LIKE pmdn_t.pmdnsite    #營運據點
   DEFINE p_pmdnunit      LIKE pmdn_t.pmdnunit    #出貨組織
   DEFINE p_pmdn001       LIKE pmdn_t.pmdn001     #商品編號
   DEFINE p_pmdn006       LIKE pmdn_t.pmdn006     #採購單位
   DEFINE p_pmdn007       LIKE pmdn_t.pmdn007     #採購數量
   DEFINE p_pmdn024       LIKE pmdn_t.pmdn024     #多交期
   DEFINE p_pmdn201       LIKE pmdn_t.pmdn201     #包裝單位
   DEFINE p_pmdn202       LIKE pmdn_t.pmdn202     #包裝數量
   DEFINE r_success       LIKE type_t.num5
   DEFINE r_pmdq002       LIKE pmdq_t.pmdq002     #分批採購數量
   DEFINE r_pmdq005       LIKE pmdq_t.pmdq005     #到庫日期
   DEFINE r_pmdq202       LIKE pmdq_t.pmdq202     #分批包裝數量
   DEFINE r_pmdn020       LIKE pmdn_t.pmdn020     #緊急度
   DEFINE r_pmdn024       LIKE pmdn_t.pmdn024     #多交期
   DEFINE l_lock_sw       LIKE type_t.chr1
   DEFINE l_forupd_sql    STRING
   DEFINE l_n             LIKE type_t.num5                #檢查重複用  
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_pmdnsite      LIKE pmdn_t.pmdnsite    #營運據點
   DEFINE l_pmdnunit      LIKE pmdn_t.pmdnunit    #出貨組織
   DEFINE l_pmdn001       LIKE pmdn_t.pmdn001     #商品編號
   DEFINE l_pmdn006       LIKE pmdn_t.pmdn006     #採購單位
   DEFINE l_pmdn007       LIKE pmdn_t.pmdn007     #採購數量
   DEFINE l_pmdn024       LIKE pmdn_t.pmdn024     #多交期
   DEFINE l_pmdn201       LIKE pmdn_t.pmdn201     #包裝單位
   DEFINE l_pmdn202       LIKE pmdn_t.pmdn202     #包裝數量
   DEFINE l_pmdldocdt     LIKE pmdl_t.pmdldocdt   #採購單日期
   DEFINE l_pmdl004       LIKE pmdl_t.pmdl004     #供應商
   DEFINE l_rtka010       LIKE rtka_t.rtka010     #送貨天數
   DEFINE l_pmdq002       LIKE pmdq_t.pmdq002     #採購數量
   DEFINE l_pmdq005       LIKE pmdq_t.pmdq005     #推算的到庫日期
   DEFINE l_pmdq202       LIKE pmdq_t.pmdq202     #包裝數量
   DEFINE l_pmaa274       LIKE pmaa_t.pmaa274     #供應商的送貨時段預設
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_sql           STRING
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_type          LIKE type_t.num5        #檢查多交期總數量與單身數量是否相同 flag
   DEFINE l_field_name    LIKE type_t.chr100      #欄位名稱
   DEFINE l_field_no      LIKE type_t.chr100      #欄位代碼
   #150407-00020#1 Add By Ken 150413
   DEFINE l_pmdl205       LIKE pmdl_t.pmdl205     #採購單頭失效日
   DEFINE l_replace       STRING  
   DEFINE l_msg           STRING   
   #150407-00020#1
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_apmt840_01 WITH FORM cl_ap_formpath("apm","apmt840_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單身前置處理 name="input.pre_input"
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   LET r_pmdn024 = p_pmdn024
   LET g_pmdn.pmdn020 = '1'
   
   CALL cl_set_combo_scc('pmdq008','2057')
   
   LET g_pmdn.pmdqdocno = p_pmdqdocno   #單據編號
   LET g_pmdn.pmdqseq   = p_pmdqseq     #項次
   LET g_pmdn.pmdnsite  = p_pmdnsite    #營運據點
   LET g_pmdn.pmdnunit  = p_pmdnunit    #出貨組織
   LET g_pmdn.pmdn001   = p_pmdn001     #商品編號
   LET g_pmdn.pmdn006   = p_pmdn006     #採購單位
   LET g_pmdn.pmdn007   = p_pmdn007     #採購數量
   LET g_pmdn.pmdn024   = p_pmdn024     #多交期
   LET g_pmdn.pmdn201   = p_pmdn201     #包裝單位
   LET g_pmdn.pmdn202   = p_pmdn202     #包裝數量
   
   LET r_pmdq002 = g_pmdn.pmdn007     #採購數量
   LET r_pmdq202 = g_pmdn.pmdn202     #包裝數量
   LET r_pmdn020 = g_pmdn.pmdn020     #緊急度
   LET r_pmdn024 = g_pmdn.pmdn024     #多交期
   
   IF cl_null(g_pmdn.pmdn007) THEN
      LET g_pmdn.pmdn007 = 0
   END IF
   
   #採購日期 供應商
   LET l_pmdldocdt = ''
   LET l_pmdl004 = ''
   SELECT pmdldocdt,pmdl004
     INTO l_pmdldocdt,l_pmdl004
     FROM pmdl_t
    WHERE pmdlent = g_enterprise
      AND pmdldocno = g_pmdn.pmdqdocno
      
   #送貨時段
   LET l_pmaa274 = s_apmt840_get_pmaa274(l_pmdl004)
   
   LET l_pmdnsite  = ''    #營運據點
   LET l_pmdnunit  = ''    #出貨組織
   LET l_pmdn001   = ''    #商品編號
   LET l_pmdn006   = ''    #採購單位
   LET l_pmdn007   = ''    #採購數量
   LET l_pmdn024   = ''    #多交期
   LET l_pmdn201   = ''    #包裝單位
   LET l_pmdn202   = ''    #包裝數量
   SELECT pmdnsite,pmdnunit,pmdn001,pmdn006,
          pmdn007, pmdn024, pmdn201,pmdn202
     INTO l_pmdnsite,l_pmdnunit,l_pmdn001,l_pmdn006,
          l_pmdn007, l_pmdn024, l_pmdn201,l_pmdn202
     FROM pmdn_t
    WHERE pmdnent = g_enterprise
      AND pmdndocno = p_pmdqdocno
      AND pmdnseq = p_pmdqseq
   IF cl_null(p_pmdnsite) THEN   #營運據點
      LET p_pmdnsite = l_pmdnsite
   END IF
   IF cl_null(p_pmdnunit) THEN   #出貨組織
      LET p_pmdnunit = l_pmdnunit
   END IF
   IF cl_null(p_pmdn001) THEN    #商品編號
      LET p_pmdn001 = l_pmdn001
   END IF
   IF cl_null(p_pmdn006) THEN    #採購單位
      LET p_pmdn006 = l_pmdn006
   END IF
   IF cl_null(p_pmdn007) THEN    #採購數量
      LET p_pmdn007 = l_pmdn007
   END IF
   IF cl_null(p_pmdn024) THEN    #多交期
      LET p_pmdn024 = l_pmdn024
   END IF
   IF cl_null(p_pmdn201) THEN    #包裝單位
      LET p_pmdn201 = l_pmdn201
   END IF
   IF cl_null(p_pmdn202) THEN    #包裝數量
      LET p_pmdn202 = l_pmdn202
   END IF
   
   LET l_forupd_sql = "SELECT pmdqsite, pmdqdocno, pmdqseq, pmdqseq2,",
                      "       pmdq008,  pmdq201,   pmdq202, pmdq002,",
                      "       pmdq003,  pmdq004,   pmdq005, pmdq006,",
                      "       pmdq007",
                      "  FROM pmdq_t",
                      " WHERE pmdqent = ?",
                      "   AND pmdqdocno = ?",
                      "   AND pmdqseq = ?",
                      "   AND pmdqseq2 = ? FOR UPDATE"
   LET l_forupd_sql = cl_sql_forupd(l_forupd_sql)
   DECLARE apmt840_01_bcl CURSOR FROM l_forupd_sql

   #WHILE TRUE 
      CALL apmt840_01_b_fill()
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT ARRAY g_pmdq_d FROM s_detail1.*
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
            LET g_rec_b = g_pmdq_d.getLength()
            IF p_pmdn024 = 'N' THEN
               CALL cl_set_act_visible("insert,delete", FALSE)
               CALL cl_set_comp_entry("pmdq202",FALSE)   #分批包裝數量
               CALL cl_set_comp_entry("pmdq002",FALSE)   #分批採購數量
               CALL cl_set_comp_entry("pmdq005",FALSE)   #到庫日期
            END IF
            
          BEFORE ROW 
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
   
            LET g_rec_b = g_pmdq_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND NOT cl_null(g_pmdq_d[l_ac].pmdqdocno)
               AND NOT cl_null(g_pmdq_d[l_ac].pmdqseq) 
               AND NOT cl_null(g_pmdq_d[l_ac].pmdqseq2) THEN
               
               LET l_cmd='u'
			      LET g_pmdq_d_t.* = g_pmdq_d[l_ac].*  #BACKUP
			      LET g_pmdq_d_o.* = g_pmdq_d[l_ac].*  #BACKUP
			      OPEN apmt840_01_bcl USING g_enterprise,g_pmdq_d[l_ac].pmdqdocno,g_pmdq_d[l_ac].pmdqseq,g_pmdq_d[l_ac].pmdqseq2
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "apmt840_01_bcl"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH apmt840_01_bcl
                   INTO g_pmdq_d[l_ac].pmdqsite, g_pmdq_d[l_ac].pmdqdocno,g_pmdq_d[l_ac].pmdqseq, g_pmdq_d[l_ac].pmdqseq2,
                        g_pmdq_d[l_ac].pmdq008,  g_pmdq_d[l_ac].pmdq201,  g_pmdq_d[l_ac].pmdq202, g_pmdq_d[l_ac].pmdq002,
                        g_pmdq_d[l_ac].pmdq003,  g_pmdq_d[l_ac].pmdq004,  g_pmdq_d[l_ac].pmdq005, g_pmdq_d[l_ac].pmdq006,
                        g_pmdq_d[l_ac].pmdq007
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = g_pmdq_d[l_ac].pmdqdocno
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  #採購單位
                  LET g_pmdq_d[l_ac].l_pmdn006 = p_pmdn006
                  CALL s_desc_get_unit_desc(g_pmdq_d[l_ac].l_pmdn006) RETURNING g_pmdq_d[l_ac].l_pmdn006_desc
                  #包裝單位
                  CALL s_desc_get_unit_desc(g_pmdq_d[l_ac].pmdq201) RETURNING g_pmdq_d[l_ac].pmdq201_desc
                  #送貨時段
				      CALL s_desc_get_acc_desc('274',g_pmdq_d[l_ac].pmdq006) RETURNING g_pmdq_d[l_ac].pmdq006_desc
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL apmt840_01_set_entry_b()
            CALL apmt840_01_set_no_entry_b()
        
         BEFORE INSERT
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_pmdq_d[l_ac].* TO NULL          
            
            LET g_pmdq_d[l_ac].pmdqsite = p_pmdnsite
            LET g_pmdq_d[l_ac].pmdqdocno = p_pmdqdocno
            LET g_pmdq_d[l_ac].pmdqseq = p_pmdqseq
            LET g_pmdq_d[l_ac].pmdq006 = l_pmaa274
            
            #到庫日期
            CALL s_apmt840_get_date('1',l_pmdldocdt,p_pmdnunit,l_pmdl004)
               RETURNING g_pmdq_d[l_ac].pmdq005,l_rtka010
            CALL apmt840_01_pmdq005_value(g_pmdq_d[l_ac].pmdq005,l_rtka010)
            
            CALL s_desc_get_acc_desc('274',g_pmdq_d[l_ac].pmdq006)
               RETURNING g_pmdq_d[l_ac].pmdq006_desc
            LET g_pmdq_d[l_ac].pmdq007 = 'N'
            LET g_pmdq_d[l_ac].pmdq008 = '1'
            #採購單位
            LET g_pmdq_d[l_ac].l_pmdn006 = p_pmdn006
            LET g_pmdq_d[l_ac].l_pmdn006_desc = s_desc_get_unit_desc(g_pmdq_d[l_ac].l_pmdn006)
            
            #包裝單位
            LET g_pmdq_d[l_ac].pmdq201 = p_pmdn201
            LET g_pmdq_d[l_ac].pmdq201_desc = s_desc_get_unit_desc(g_pmdq_d[l_ac].pmdq201)
      
            SELECT COALESCE(MAX(pmdqseq2)+1,1) INTO g_pmdq_d[l_ac].pmdqseq2
              FROM pmdq_t
             WHERE pmdqent = g_enterprise
               AND pmdqdocno = p_pmdqdocno
               AND pmdqseq = p_pmdqseq
            
            LET g_pmdq_d_t.* = g_pmdq_d[l_ac].*     #新輸入資料
            LET g_pmdq_d_o.* = g_pmdq_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            LET l_count = 0  
            SELECT COUNT(*) INTO l_count
              FROM pmdq_t 
             WHERE pmdqent = g_enterprise
               AND pmdqdocno = g_pmdq_d[l_ac].pmdqdocno
               AND pmdqseq = g_pmdq_d[l_ac].pmdqseq
               AND pmdqseq2 = g_pmdq_d[l_ac].pmdqseq2
      
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               INSERT INTO pmdq_t(pmdqent, pmdqsite,pmdqdocno,pmdqseq,
                                  pmdqseq2,pmdq002, pmdq003,  pmdq004,
                                  pmdq005, pmdq006, pmdq007,  pmdq008,
                                  pmdq201, pmdq202)
                  VALUES (g_enterprise,           g_pmdq_d[l_ac].pmdqsite,g_pmdq_d[l_ac].pmdqdocno,g_pmdq_d[l_ac].pmdqseq,
                          g_pmdq_d[l_ac].pmdqseq2,g_pmdq_d[l_ac].pmdq002, g_pmdq_d[l_ac].pmdq003,  g_pmdq_d[l_ac].pmdq004,
                          g_pmdq_d[l_ac].pmdq005, g_pmdq_d[l_ac].pmdq006, g_pmdq_d[l_ac].pmdq007,  g_pmdq_d[l_ac].pmdq008,
                          g_pmdq_d[l_ac].pmdq201, g_pmdq_d[l_ac].pmdq202)
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               INITIALIZE g_pmdq_d[l_ac].* TO NULL
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "pmdq_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()               
               CANCEL INSERT
            ELSE
               ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
              
         BEFORE DELETE                            #是否取消單身
            IF NOT cl_null(g_pmdq_d[l_ac].pmdqdocno)
               AND NOT cl_null(g_pmdq_d[l_ac].pmdqseq) 
               AND NOT cl_null(g_pmdq_d[l_ac].pmdqseq2) THEN 
               
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  -263
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CANCEL DELETE
               END IF

               DELETE FROM pmdq_t
                WHERE pmdqent = g_enterprise
                  AND pmdqdocno = g_pmdq_d_t.pmdqdocno
                  AND pmdqseq = g_pmdq_d_t.pmdqseq
                  AND pmdqseq2 = g_pmdq_d_t.pmdqseq2

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "pmdq_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CANCEL DELETE 
               END IF 
               CLOSE apmt840_01_bcl
               LET l_count = g_pmdq_d.getLength()
            END IF 
            
        ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_pmdq_d[l_ac].* = g_pmdq_d_t.*
               CLOSE apmt840_01_bcl
               EXIT DIALOG
            END IF

            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_pmdq_d[l_ac].pmdq002
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_pmdq_d[l_ac].* = g_pmdq_d_t.*
            ELSE
               UPDATE pmdq_t
                  SET (pmdqseq2,pmdq002,pmdq003,pmdq004,
                       pmdq005, pmdq006,pmdq007,pmdq008,
                       pmdq201, pmdq202)
                    = (g_pmdq_d[l_ac].pmdqseq2,g_pmdq_d[l_ac].pmdq002,g_pmdq_d[l_ac].pmdq003,g_pmdq_d[l_ac].pmdq004,
                       g_pmdq_d[l_ac].pmdq005, g_pmdq_d[l_ac].pmdq006,g_pmdq_d[l_ac].pmdq007,g_pmdq_d[l_ac].pmdq008,
                       g_pmdq_d[l_ac].pmdq201, g_pmdq_d[l_ac].pmdq202)
                WHERE pmdqent = g_enterprise 
                  AND pmdqdocno = g_pmdq_d_t.pmdqdocno
                  AND pmdqseq = g_pmdq_d_t.pmdqseq
                  AND pmdqseq2 = g_pmdq_d_t.pmdqseq2

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "pmdq_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_pmdq_d[l_ac].* = g_pmdq_d_t.*
               ELSE
                  IF p_pmdn024 = 'N' THEN
                     EXIT DIALOG
                  END IF
               END IF
            END IF
            
         AFTER ROW
            CLOSE apmt840_01_bcl
            IF p_pmdn024 = 'N' THEN
               EXIT DIALOG
            END IF
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdqsite
            #add-point:BEFORE FIELD pmdqsite name="input.b.page1.pmdqsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdqsite
            
            #add-point:AFTER FIELD pmdqsite name="input.a.page1.pmdqsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdqsite
            #add-point:ON CHANGE pmdqsite name="input.g.page1.pmdqsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdqdocno
            #add-point:BEFORE FIELD pmdqdocno name="input.b.page1.pmdqdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdqdocno
            
            #add-point:AFTER FIELD pmdqdocno name="input.a.page1.pmdqdocno"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdqdocno
            #add-point:ON CHANGE pmdqdocno name="input.g.page1.pmdqdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdqseq
            #add-point:BEFORE FIELD pmdqseq name="input.b.page1.pmdqseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdqseq
            
            #add-point:AFTER FIELD pmdqseq name="input.a.page1.pmdqseq"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdqseq
            #add-point:ON CHANGE pmdqseq name="input.g.page1.pmdqseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdqseq2
            #add-point:BEFORE FIELD pmdqseq2 name="input.b.page1.pmdqseq2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdqseq2
            
            #add-point:AFTER FIELD pmdqseq2 name="input.a.page1.pmdqseq2"
            #此段落由子樣板a05產生
            IF g_pmdq_d[l_ac].pmdqdocno IS NOT NULL AND g_pmdq_d[l_ac].pmdqseq IS NOT NULL AND g_pmdq_d[l_ac].pmdqseq2 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pmdq_d[l_ac].pmdqdocno != g_pmdq_d_t.pmdqdocno OR g_pmdq_d[l_ac].pmdqseq != g_pmdq_d_t.pmdqseq OR g_pmdq_d[l_ac].pmdqseq2 != g_pmdq_d_t.pmdqseq2)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pmdq_t WHERE "||"pmdqent = '" ||g_enterprise|| "' AND "||"pmdqdocno = '"||g_pmdq_d[l_ac].pmdqdocno ||"' AND "|| "pmdqseq = '"||g_pmdq_d[l_ac].pmdqseq ||"' AND "|| "pmdqseq2 = '"||g_pmdq_d[l_ac].pmdqseq2 ||"'",'std-00004',0) THEN 
                     LET g_pmdq_d[l_ac].pmdqseq2 = g_pmdq_d_t.pmdqseq2
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdqseq2
            #add-point:ON CHANGE pmdqseq2 name="input.g.page1.pmdqseq2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdq008
            #add-point:BEFORE FIELD pmdq008 name="input.b.page1.pmdq008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdq008
            
            #add-point:AFTER FIELD pmdq008 name="input.a.page1.pmdq008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdq008
            #add-point:ON CHANGE pmdq008 name="input.g.page1.pmdq008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdq201
            
            #add-point:AFTER FIELD pmdq201 name="input.a.page1.pmdq201"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdq201
            #add-point:BEFORE FIELD pmdq201 name="input.b.page1.pmdq201"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdq201
            #add-point:ON CHANGE pmdq201 name="input.g.page1.pmdq201"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdq202
            #add-point:BEFORE FIELD pmdq202 name="input.b.page1.pmdq202"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdq202
            
            #add-point:AFTER FIELD pmdq202 name="input.a.page1.pmdq202"
            IF NOT cl_null(g_pmdq_d[l_ac].pmdq202) THEN
               IF g_pmdq_d[l_ac].pmdq202 != g_pmdq_d_o.pmdq202 OR cl_null(g_pmdq_d_o.pmdq202) THEN
                  LET l_pmdq202 = 0
                  FOR l_i = 1 TO g_pmdq_d.getLength()
                     LET l_pmdq202 = l_pmdq202 + g_pmdq_d[l_i].pmdq202
                  END FOR
                  #分批包裝數量總和不可大於包裝量！
                  IF l_pmdq202 > p_pmdn202 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apm-00665'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_pmdq_d[l_ac].pmdq202 = g_pmdq_d_o.pmdq202
                     NEXT FIELD CURRENT
                  END IF
                  #數值轉換
                  #150903-00007#1 150903 by sakura mark&add(S)
                  #CALL apmt840_01_num_change(p_pmdn001)
                  IF NOT apmt840_01_num_change(p_pmdn001) THEN
                     NEXT FIELD CURRENT
                  END IF
                  #150903-00007#1 150903 by sakura mark&add(S)
               END IF
            END IF
            LET g_pmdq_d_o.pmdq002 = g_pmdq_d[l_ac].pmdq002
            LET g_pmdq_d_o.pmdq202 = g_pmdq_d[l_ac].pmdq202
            CALL apmt840_01_set_entry_b()
            CALL apmt840_01_set_no_entry_b()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdq202
            #add-point:ON CHANGE pmdq202 name="input.g.page1.pmdq202"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_pmdn006
            
            #add-point:AFTER FIELD l_pmdn006 name="input.a.page1.l_pmdn006"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_pmdn006
            #add-point:BEFORE FIELD l_pmdn006 name="input.b.page1.l_pmdn006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_pmdn006
            #add-point:ON CHANGE l_pmdn006 name="input.g.page1.l_pmdn006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdq002
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmdq_d[l_ac].pmdq002,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD pmdq002
            END IF 
 
 
 
            #add-point:AFTER FIELD pmdq002 name="input.a.page1.pmdq002"
            IF NOT cl_null(g_pmdq_d[l_ac].pmdq002) THEN
               IF g_pmdq_d[l_ac].pmdq002 != g_pmdq_d_o.pmdq002 OR cl_null(g_pmdq_d_o.pmdq002) THEN
                  LET l_pmdq002 = 0
                  FOR l_i = 1 TO g_pmdq_d.getLength()
                     LET l_pmdq002 = l_pmdq002 + g_pmdq_d[l_i].pmdq002
                  END FOR
                  #分批採購數量總和不可大於採購量！
                  IF l_pmdq002 > p_pmdn007 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apm-00665'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_pmdq_d[l_ac].pmdq002 = g_pmdq_d_o.pmdq002
                     NEXT FIELD CURRENT
                  END IF
                  #數值轉換
                  #CALL apmt840_01_num_change(p_pmdn001)
                  IF NOT apmt840_01_num_change(p_pmdn001) THEN
                     NEXT FIELD CURRENT
                  END IF
                  #150903-00007#1 150903 by sakura mark&add(S)                  
               END IF
            END IF
            LET g_pmdq_d_o.pmdq002 = g_pmdq_d[l_ac].pmdq002
            LET g_pmdq_d_o.pmdq202 = g_pmdq_d[l_ac].pmdq202
            CALL apmt840_01_set_entry_b()
            CALL apmt840_01_set_no_entry_b()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdq002
            #add-point:BEFORE FIELD pmdq002 name="input.b.page1.pmdq002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdq002
            #add-point:ON CHANGE pmdq002 name="input.g.page1.pmdq002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdq003
            #add-point:BEFORE FIELD pmdq003 name="input.b.page1.pmdq003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdq003
            
            #add-point:AFTER FIELD pmdq003 name="input.a.page1.pmdq003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdq003
            #add-point:ON CHANGE pmdq003 name="input.g.page1.pmdq003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdq004
            #add-point:BEFORE FIELD pmdq004 name="input.b.page1.pmdq004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdq004
            
            #add-point:AFTER FIELD pmdq004 name="input.a.page1.pmdq004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdq004
            #add-point:ON CHANGE pmdq004 name="input.g.page1.pmdq004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdq005
            #add-point:BEFORE FIELD pmdq005 name="input.b.page1.pmdq005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdq005
            
            #add-point:AFTER FIELD pmdq005 name="input.a.page1.pmdq005"
            IF NOT cl_null(g_pmdq_d[l_ac].pmdq005) THEN
               IF g_pmdq_d[l_ac].pmdq005 != g_pmdq_d_o.pmdq005 OR cl_null(g_pmdq_d_o.pmdq005) THEN
                  #到庫日期
                  CALL s_apmt840_get_date('2',g_pmdq_d[l_ac].pmdq005,p_pmdnunit,l_pmdl004)
                     RETURNING l_pmdq005,l_rtka010
                  #有推算出來的到庫日期
                  IF NOT cl_null(l_pmdq005) THEN
                     #當推算出來的到庫日期 < 系統日，警告使用者
                     IF l_pmdq005 < g_today THEN
                        #供應商的到庫日期%1 小於系統日！
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'apm-00660'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        LET g_errparam.replace[1] = l_pmdq005
                        CALL cl_err()
                        LET g_pmdq_d[l_ac].pmdq005 = g_today
                        CALL apmt840_01_pmdq005_value(l_pmdq005,l_rtka010)
                        LET g_pmdq_d_o.pmdq005 = g_pmdq_d[l_ac].pmdq005
                        NEXT FIELD CURRENT
                     END IF
                     IF l_pmdq005 > g_today THEN
                        #推算出來的供應商送貨日 = %1，是否更新為此日期?
                        IF cl_ask_confirm_parm('apm-00661',l_pmdq005) THEN
                           LET g_pmdq_d[l_ac].pmdq005 = l_pmdq005
                        END IF
                     END IF
                  END IF
                  CALL apmt840_01_pmdq005_value(l_pmdq005,l_rtka010)
               END IF
            END IF
            LET g_pmdq_d_o.pmdq003 = g_pmdq_d[l_ac].pmdq003
            LET g_pmdq_d_o.pmdq004 = g_pmdq_d[l_ac].pmdq004
            LET g_pmdq_d_o.pmdq005 = g_pmdq_d[l_ac].pmdq005
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdq005
            #add-point:ON CHANGE pmdq005 name="input.g.page1.pmdq005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdq006
            
            #add-point:AFTER FIELD pmdq006 name="input.a.page1.pmdq006"
            LET g_pmdq_d[l_ac].pmdq006_desc = ''
            DISPLAY BY NAME g_pmdq_d[l_ac].pmdq006_desc   
            IF NOT cl_null(g_pmdq_d[l_ac].pmdq006) THEN 
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_pmdq_d[l_ac].pmdq006
               #160318-00025#41  2016/04/25  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "apm-00233:sub-01302|aooi715|",cl_get_progname("aooi715",g_lang,"2"),"|:EXEPROGaooi715"
               LET g_chkparam.err_str[2] = "apm-00232:sub-01303|aooi715|",cl_get_progname("aooi715",g_lang,"2"),"|:EXEPROGaooi715"
               #160318-00025#41  2016/04/25  by pengxin  add(E)
               IF NOT cl_chk_exist("v_oocq002_274") THEN
                  LET g_pmdq_d[l_ac].pmdq006 = g_pmdq_d_t.pmdq006
                  CALL s_desc_get_acc_desc('274',g_pmdq_d[l_ac].pmdq006) RETURNING g_pmdq_d[l_ac].pmdq006_desc
                  DISPLAY BY NAME g_pmdq_d[l_ac].pmdq006_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 
            CALL s_desc_get_acc_desc('274',g_pmdq_d[l_ac].pmdq006) RETURNING g_pmdq_d[l_ac].pmdq006_desc
            DISPLAY BY NAME g_pmdq_d[l_ac].pmdq006_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdq006
            #add-point:BEFORE FIELD pmdq006 name="input.b.page1.pmdq006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdq006
            #add-point:ON CHANGE pmdq006 name="input.g.page1.pmdq006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdq007
            #add-point:BEFORE FIELD pmdq007 name="input.b.page1.pmdq007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdq007
            
            #add-point:AFTER FIELD pmdq007 name="input.a.page1.pmdq007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdq007
            #add-point:ON CHANGE pmdq007 name="input.g.page1.pmdq007"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.pmdqsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdqsite
            #add-point:ON ACTION controlp INFIELD pmdqsite name="input.c.page1.pmdqsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdqdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdqdocno
            #add-point:ON ACTION controlp INFIELD pmdqdocno name="input.c.page1.pmdqdocno"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdqseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdqseq
            #add-point:ON ACTION controlp INFIELD pmdqseq name="input.c.page1.pmdqseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdqseq2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdqseq2
            #add-point:ON ACTION controlp INFIELD pmdqseq2 name="input.c.page1.pmdqseq2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdq008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdq008
            #add-point:ON ACTION controlp INFIELD pmdq008 name="input.c.page1.pmdq008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdq201
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdq201
            #add-point:ON ACTION controlp INFIELD pmdq201 name="input.c.page1.pmdq201"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdq202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdq202
            #add-point:ON ACTION controlp INFIELD pmdq202 name="input.c.page1.pmdq202"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_pmdn006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_pmdn006
            #add-point:ON ACTION controlp INFIELD l_pmdn006 name="input.c.page1.l_pmdn006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdq002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdq002
            #add-point:ON ACTION controlp INFIELD pmdq002 name="input.c.page1.pmdq002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdq003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdq003
            #add-point:ON ACTION controlp INFIELD pmdq003 name="input.c.page1.pmdq003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdq004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdq004
            #add-point:ON ACTION controlp INFIELD pmdq004 name="input.c.page1.pmdq004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdq005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdq005
            #add-point:ON ACTION controlp INFIELD pmdq005 name="input.c.page1.pmdq005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdq006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdq006
            #add-point:ON ACTION controlp INFIELD pmdq006 name="input.c.page1.pmdq006"
            #此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdq_d[l_ac].pmdq006

            #給予arg
            LET g_qryparam.arg1 = "274"
            CALL q_oocq002()
            LET g_pmdq_d[l_ac].pmdq006 = g_qryparam.return1
            DISPLAY g_pmdq_d[l_ac].pmdq006 TO pmdq006
            CALL s_desc_get_acc_desc('274',g_pmdq_d[l_ac].pmdq006) RETURNING g_pmdq_d[l_ac].pmdq006_desc
            DISPLAY BY NAME g_pmdq_d[l_ac].pmdq006_desc
            NEXT FIELD pmdq006
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdq007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdq007
            #add-point:ON ACTION controlp INFIELD pmdq007 name="input.c.page1.pmdq007"
            
            #END add-point
 
 
 
 
         #自訂ACTION
         #add-point:單身其他段落處理(EX:on row change, etc...) name="input.other"
         
         #end add-point
 
         AFTER INPUT
            #add-point:單身輸入後處理 name="input.after_input"
            IF p_pmdn024 = 'N' THEN
               CALL cl_set_act_visible("insert,delete", TRUE)
               CALL cl_set_comp_entry("pmdq202",TRUE)   #分批包裝數量
               CALL cl_set_comp_entry("pmdq002",TRUE)   #分批採購數量
               CALL cl_set_comp_entry("pmdq005",TRUE)   #到庫日期
            END IF
            
            #1.確認維護的多交期總數量與單身數量是否一致
            #  l_type 0.檢查的數量都相同　　　1.出貨數量不相同
            #         2.出貨包裝數量不相同
            LET l_type = ''
            CALL apmt840_01_chk_total_num() RETURNING l_type
            
            #2.檢查數量是否有錯誤
            # 把total數，放入回傳值
            IF l_type = 0 THEN
               LET r_pmdq002 = g_pmdn.pmdn007     #採購數量
               LET r_pmdq202 = g_pmdn.pmdn202     #包裝數量
               LET r_pmdn020 = g_pmdn.pmdn020     #緊急度
               LET r_pmdn024 = g_pmdn.pmdn024     #多交期
            ELSE
               #3.當有錯誤時詢問使用者
               # 3-1.依照檢查總數量回傳值，判斷哪個欄位有不相同
               LET l_field_no = ''
               CASE l_type
                  WHEN 1       #出貨數量不相同
                     LET l_field_no = 'pmdn007'
                  WHEN 2       #出貨包裝數量不相同
                     LET l_field_no = 'pmdn202'
                  WHEN 3       #該項次有關連單據資料
                     #該項次有關聯單據資料，交期明細總數量必須與單身採購數量相同！
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "apm-00814"
                     LET g_errparam.extend = ""
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD pmdq002
               END CASE
               
               # 3-2.取出此作業時的欄位名稱
               LET l_field_name = ''
               CALL s_apmt860_get_field_name(l_field_no) RETURNING l_field_name
               
               # 3-3.詢問使用者
               #  錯誤訊息：多交期%1總和需等於單身%1！是否依多交期%1回寫單身%1？
               #  如回答Y：計算total量
               #  　　　N：回到該對應的欄位上繼續給使用者維護
               IF cl_ask_confirm_parm('apm-00815',l_field_name) THEN
                  LET r_pmdq002 = g_total.pmdn007     #採購數量
                  LET r_pmdq202 = g_total.pmdn202     #包裝數量
               ELSE
                  CASE l_type
                     WHEN 1       #採購數量不相同
                        NEXT FIELD pmdq002
                     WHEN 2       #包裝數量不相同
                        NEXT FIELD pmdq202
                  END CASE
               END IF
            END IF
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
   #150407-00020#1 Add By Ken 150413
   #SELECT MAX(pmdq005) INTO l_pmdq005
   #  FROM pmdq_t
   # WHERE pmdqent = g_enterprise
   #   AND pmdqdocno = g_pmdn.pmdqdocno
   #   
   #SELECT pmdl205 INTO l_pmdl205
   #  FROM pmdl_t
   # WHERE pmdlent = g_enterprise
   #   AND pmdldocno = g_pmdn.pmdqdocno
   #
   #IF l_pmdl205 < l_pmdq005 THEN
   #   LET l_replace = l_pmdl205 ,"|", l_pmdq005
   #   LET l_msg = cl_getmsg_parm('apm-00884',g_dlang,l_replace)            
   #   IF cl_ask_confirm_parm('std-00008',l_msg) THEN 
   #      IF NOT apmt840_pmdn224_upd(g_pmdn.pmdqdocno,l_pmdq005) THEN
   #         RETURN
   #      END IF  
   #   ELSE
   #      RETURN
   #   END IF 
   #END IF      
   #150407-00020#1   
   
   #離開時回傳交貨日期最早的那一分批序的到庫日期
   LET r_pmdq005 = ''
   
   SELECT MIN(pmdq005) INTO r_pmdq005
     FROM pmdq_t
    WHERE pmdqent = g_enterprise
      AND pmdqdocno = g_pmdn.pmdqdocno
      AND pmdqseq = g_pmdn.pmdqseq
   
   #當多交期只有輸入一筆資料 讓多交期等於 = 'N'
   IF p_pmdn024 = 'Y' THEN
      LET l_cnt = 0
      SELECT COUNT(pmdqseq) INTO l_cnt
        FROM pmdq_t
       WHERE pmdqent = g_enterprise
         AND pmdqdocno = g_pmdn.pmdqdocno
         AND pmdqseq = g_pmdn.pmdqseq
      IF l_cnt = 1 THEN
         LET r_pmdn024 = 'N'
      END IF
   END IF
   
   IF INT_FLAG THEN
      #須把原本的資料還原
      LET l_success = ''
      CALL apmt840_01_reduction() RETURNING l_success
      LET r_pmdq002 = g_pmdn.pmdn007     #採購數量
      LET r_pmdq202 = g_pmdn.pmdn202     #包裝數量
      LET r_pmdn020 = g_pmdn.pmdn020     #緊急度
      LET r_pmdn024 = g_pmdn.pmdn024     #多交期
      
      LET INT_FLAG = FALSE
      IF l_success = FALSE THEN
         LET r_success = FALSE
         RETURN r_success,r_pmdq005,r_pmdq002,r_pmdq202,r_pmdn020,r_pmdn024
      END IF
   END IF
      
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_apmt840_01 
   
   #add-point:input段after input name="input.post_input"
   RETURN r_success,r_pmdq005,r_pmdq002,r_pmdq202,r_pmdn020,r_pmdn024
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="apmt840_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="apmt840_01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 撈出單身資料
# Memo...........:
# Usage..........: CALL apmt840_01_b_fill()
# Input parameter: 無
# Date & Author..: 2014/12/01 By pomelo
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt840_01_b_fill()
DEFINE l_sql            STRING
   
   LET l_sql = "SELECT pmdqsite, pmdqdocno, pmdqseq, pmdqseq2,",
               "       pmdq008,  pmdq201,   '',      pmdq202,",
               "       '',       '',        pmdq002, pmdq003,",
               "       pmdq004,  pmdq005,   pmdq006, '',",
               "       pmdq007",
               "  FROM pmdq_t",
               " WHERE pmdqent = ",g_enterprise,
               "   AND pmdqdocno = '",g_pmdn.pmdqdocno,"'",
               "   AND pmdqseq = '",g_pmdn.pmdqseq,"' "
   PREPARE apmt840_01_pb FROM l_sql
   DECLARE b_fill_curs CURSOR FOR apmt840_01_pb
   
   CALL g_pmdq_d.clear()
   LET l_ac = 1
   FOREACH b_fill_curs INTO g_pmdq_d[l_ac].pmdqsite, g_pmdq_d[l_ac].pmdqdocno,     g_pmdq_d[l_ac].pmdqseq,      g_pmdq_d[l_ac].pmdqseq2,
                            g_pmdq_d[l_ac].pmdq008,  g_pmdq_d[l_ac].pmdq201,       g_pmdq_d[l_ac].pmdq201_desc, g_pmdq_d[l_ac].pmdq202,
                            g_pmdq_d[l_ac].l_pmdn006,g_pmdq_d[l_ac].l_pmdn006_desc,g_pmdq_d[l_ac].pmdq002,      g_pmdq_d[l_ac].pmdq003,
                            g_pmdq_d[l_ac].pmdq004,  g_pmdq_d[l_ac].pmdq005,       g_pmdq_d[l_ac].pmdq006,      g_pmdq_d[l_ac].pmdq006_desc,
                            g_pmdq_d[l_ac].pmdq007
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      #採購單位
      LET g_pmdq_d[l_ac].l_pmdn006 = g_pmdn.pmdn006
      CALL s_desc_get_unit_desc(g_pmdq_d[l_ac].l_pmdn006) RETURNING g_pmdq_d[l_ac].l_pmdn006_desc
      
      #包裝單位
      CALL s_desc_get_unit_desc(g_pmdq_d[l_ac].pmdq201) RETURNING g_pmdq_d[l_ac].pmdq201_desc
      
      #送貨時段
      CALL s_desc_get_acc_desc('274',g_pmdq_d[l_ac].pmdq006) RETURNING g_pmdq_d[l_ac].pmdq006_desc
          
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend =  ''
         LET g_errparam.code   =  9035
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
   
   END FOREACH
   CALL g_pmdq_d.deleteElement(g_pmdq_d.getLength())
   LET g_rec_b = l_ac - 1
   DISPLAY g_rec_b TO FORMONLY.cnt
   CLOSE b_fill_curs
   FREE apmt840_01_pb
END FUNCTION

################################################################################
# Descriptions...: 單位間的轉換數量
# Memo...........: 當銷售數量為空，由包裝數量轉換成銷售數量及計價數量及參考數量
#                : 當銷售數量有值，由銷售數量轉換成包裝數量及計價數量及參考數量
# Usage..........: CALL apmt840_01_num_change(p_pmdn001)
# Input parameter: p_pmdn001     商品編號
# Return code....: r_success  True/False
# Date & Author..: 2014/11/28 By pomelo
# Modify.........: 2015/09/07 By sakura 新增回傳值
################################################################################
PRIVATE FUNCTION apmt840_01_num_change(p_pmdn001)
DEFINE p_pmdn001        LIKE pmdn_t.pmdn001
DEFINE r_success        LIKE type_t.num5   #150903-00007#1 150903 by sakura add
DEFINE l_success        LIKE type_t.num5
    
    LET r_success = TRUE   #150903-00007#1 150903 by sakura add
    
    #當包裝單位或銷售單位都為空，表示無法轉換
    IF cl_null(g_pmdq_d[l_ac].pmdq201) OR
       cl_null(g_pmdq_d[l_ac].l_pmdn006) THEN
       #150903-00007#1 150903 by sakura mark&add(S)
       #RETURN
       RETURN r_success
       #150903-00007#1 150903 by sakura mark&add(S)
    END IF
    
    #當銷售數量為空
    IF cl_null(g_pmdq_d[l_ac].pmdq002) THEN
       #當包裝數量為空
       IF cl_null(g_pmdq_d[l_ac].pmdq202) THEN
          #150903-00007#1 150903 by sakura mark&add(S)
          #RETURN
          RETURN r_success
          #150903-00007#1 150903 by sakura mark&add(S)
       ELSE
          #當銷售數量為空，由包裝數量轉換成銷售數量
          CALL s_aooi250_convert_qty(p_pmdn001,g_pmdq_d[l_ac].pmdq201,g_pmdq_d[l_ac].l_pmdn006,g_pmdq_d[l_ac].pmdq202)
             RETURNING l_success,g_pmdq_d[l_ac].pmdq002
          #150903-00007#1 150903 by sakura add(S)
          IF l_success = FALSE THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
          #150903-00007#1 150903 by sakura add(E)           
       END IF
    ELSE
       #當銷售數量有值，由銷售數量轉換成包裝數量
       CALL s_aooi250_convert_qty(p_pmdn001,g_pmdq_d[l_ac].l_pmdn006,g_pmdq_d[l_ac].pmdq201,g_pmdq_d[l_ac].pmdq002)
          RETURNING l_success,g_pmdq_d[l_ac].pmdq202
       #150903-00007#1 150903 by sakura add(S)
       IF l_success = FALSE THEN
          LET r_success = FALSE
          RETURN r_success
       END IF
       #150903-00007#1 150903 by sakura add(E)           
    END IF
    RETURN r_success #150903-00007#1 150903 by sakura add r_success
END FUNCTION

################################################################################
# Descriptions...: 到庫日期影響其他欄位值
# Memo...........:
# Usage..........: CALL apmt840_01_pmdq005_value(p_pmdq005,p_rtka010)
# Input parameter: p_pmdq005     推算出來的到庫日期
#                : p_rtka010     訂單有效期
# Return code....: 無
# Date & Author..: 2014/12/02 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION apmt840_01_pmdq005_value(p_pmdq005,p_rtka010)
DEFINE p_pmdq005           LIKE pmdq_t.pmdq005
DEFINE p_rtka010           LIKE rtka_t.rtka010

   #判斷緊急度
   IF p_pmdq005 < g_today AND g_pmdn.pmdn020 = '1' THEN
      LET g_pmdn.pmdn020 = '2'
   END IF
   
   #到廠日期，交貨日期 = 到庫日期
   LET g_pmdq_d[l_ac].pmdq003 = g_pmdq_d[l_ac].pmdq005
   LET g_pmdq_d[l_ac].pmdq004 = g_pmdq_d[l_ac].pmdq005
END FUNCTION

################################################################################
# Descriptions...: 單身欄位開啟
# Memo...........:
# Usage..........: CALL apmt840_01_set_entry_b()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/02/02 By pomelo
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt840_01_set_entry_b()

   CALL cl_set_comp_entry("pmdq202",TRUE)
END FUNCTION

################################################################################
# Descriptions...: 單身欄位關閉
# Memo...........:
# Usage..........: CALL apmt840_01_set_no_entry_b()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/02/02 By pomelo
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt840_01_set_no_entry_b()

   IF NOT cl_null(g_pmdq_d[l_ac].pmdq002) THEN
      CALL cl_set_comp_entry("pmdq202",FALSE)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 建立處理多交期所需的temp table
# Memo...........: 當使用者已有修改多交期資料，可是按放棄
#                : 表示使用者不要維護多交期資料，必須要把原本的資料還原
# Usage..........: CALL apmt840_01_create_temp_table()
#                     RETURNING r_success
# Input parameter: 無
# Return code....: r_success      True/False
# Date & Author..: 2015/02/02 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION apmt840_01_create_temp_table()
DEFINE r_success            LIKE type_t.num5

   LET r_success = TRUE
   CALL apmt840_01_drop_temp_table()
   
   CREATE TEMP TABLE apmt840_01_temp(
      pmdqent         SMALLINT,            #企業編號
      pmdqsite        VARCHAR(10),           #營運據點
      pmdqdocno       VARCHAR(20),          #採購單號
      pmdqseq         INTEGER,            #採購項次
      pmdqseq2        INTEGER,           #分批序
      pmdq002         DECIMAL(20,6),            #分批數量
      pmdq003         DATE,            #交貨日期
      pmdq004         DATE,            #到廠日期
      pmdq005         DATE,            #到庫日期
      pmdq006         VARCHAR(10),            #收貨時段
      pmdq007         VARCHAR(1),            #MRP凍結否
      pmdq008         VARCHAR(10),            #交期類型
      pmdq201         VARCHAR(10),            #分批包裝單位
      pmdq202         DECIMAL(20,6))            #分批包裝數量
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Create Temp Table apmt840_01_temp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 刪除建立的temp table
# Memo...........:
# Usage..........: CALL apmt840_01_drop_temp_table()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/02/02 By pomelo
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt840_01_drop_temp_table()

   DROP TABLE apmt840_01_temp
   
END FUNCTION
################################################################################
# Descriptions...: Copy pmdu_t To apmt840_01_temp
# Memo...........: 當使用這放棄時，可以還原原始資料
# Usage..........: CALL apmt840_01_copy_pmdq_t()
#                :    RETURNING r_success
# Input parameter: 無
# Return code....: r_success      True/False
# Date & Author..: 2015/02/02 By pomelo
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt840_01_copy_pmdq_t()
DEFINE r_success         LIKE type_t.num5

   LET r_success = TRUE

   #1.刪除tepm table 裡資料(確保資料正確性)
   DELETE FROM apmt840_01_temp

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Del apmt840_01_temp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   #2.複製此單號+項次 的原始資料
   INSERT INTO apmt840_01_temp(pmdqent,  pmdqsite, pmdqdocno, pmdqseq,
                               pmdqseq2, pmdq002,  pmdq003,   pmdq004,
                               pmdq005,  pmdq006,  pmdq007,   pmdq008,
                               pmdq201,  pmdq202)
   SELECT pmdqent,  pmdqsite, pmdqdocno, pmdqseq,
          pmdqseq2, pmdq002,  pmdq003,   pmdq004,
          pmdq005,  pmdq006,  pmdq007,   pmdq008,
          pmdq201,  pmdq202
     FROM pmdo_t
    WHERE pmdqent = g_enterprise
      AND pmdqdocno = g_pmdn.pmdqdocno
      AND pmdqseq = g_pmdn.pmdqseq

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Ins apmt840_01_temp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: 確認維護的多交期總數量與單身數量是否一致
# Memo...........:
# Usage..........: CALL apmt840_01_chk_total_num()
#                  RETURNING r_type
# Input parameter: 無
# Return code....: r_type         0.檢查的數量都相同
#                :                1.採購數量不相同
#                :                2.包裝數量不相同
#                :                3.有關聯單據資料，數量不可不相同
# Date & Author..: 2015/02/02 By pomelo
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt840_01_chk_total_num()
DEFINE r_type          LIKE type_t.num5
DEFINE l_cnt           LIKE type_t.num5

   LET r_type = 0
   
   LET l_cnt = 0
   #1.該項次是否有關聯單據資料
   SELECT COUNT(pmdpseq) INTO l_cnt
     FROM pmdp_t
    WHERE pmdpent = g_enterprise
      AND pmdpdocno = g_pmdn.pmdqdocno
      AND pmdpseq = g_pmdn.pmdqseq
   
   #2.計算輸入的總total數量
   INITIALIZE g_total.* TO NULL
   SELECT COALESCE(SUM(pmdq002),0),COALESCE(SUM(pmdq202),0)
     INTO g_total.pmdn007,g_total.pmdn202
     FROM pmdq_t
    WHERE pmdqent = g_enterprise
      AND pmdqdocno = g_pmdn.pmdqdocno
      AND pmdqseq = g_pmdn.pmdqseq
    
   #3.多交期採購數量加總是否與該項次採購數量相同
   IF g_pmdn.pmdn007 != g_total.pmdn007 THEN
      IF l_cnt = 0 THEN
         LET r_type = 1
         RETURN r_type
      ELSE
         LET r_type = 3
         RETURN r_type
      END IF
   END IF
   
   #4.多交期包裝數量加總是否與該項次包裝數量相同
   IF g_pmdn.pmdn202 != g_total.pmdn202 THEN
      IF l_cnt = 0 THEN
         LET r_type = 2
         RETURN r_type
      ELSE
         LET r_type = 3
         RETURN r_type
      END IF
   END IF
   
   RETURN r_type
END FUNCTION
################################################################################
# Descriptions...: 把原本的多交期資料還原
# Memo...........:
# Usage..........: CALL apmt840_01_reduction()
#                :    RETURNING r_success
# Input parameter: 無
# Return code....: r_success      True/False
# Date & Author..: 2015/02/02 By pomelo
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt840_01_reduction()
DEFINE r_success        LIKE type_t.num5

   LET r_success = TRUE
   
   DELETE FROM pmdq_t
    WHERE pmdqent = g_enterprise
      AND pmdqdocno = g_pmdn.pmdqdocno
      AND pmdqseq = g_pmdn.pmdqseq
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "Del pmdu_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   INSERT INTO pmdq_t(pmdqent,  pmdqsite, pmdqdocno, pmdqseq,
                      pmdqseq2, pmdq002,  pmdq003,   pmdq004,
                      pmdq005,  pmdq006,  pmdq007,   pmdq008,
                      pmdq201,  pmdq202)
      SELECT pmdqent,  pmdqsite, pmdqdocno, pmdqseq,
             pmdqseq2, pmdq002,  pmdq003,   pmdq004,
             pmdq005,  pmdq006,  pmdq007,   pmdq008,
             pmdq201,  pmdq202
        FROM apmt840_01_temp
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "Ins pmdq_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

 
{</section>}
 
