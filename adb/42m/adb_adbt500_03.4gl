#該程式未解開Section, 採用最新樣板產出!
{<section id="adbt500_03.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2015-04-27 09:13:07), PR版次:0006(2016-12-30 14:47:20)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000220
#+ Filename...: adbt500_03
#+ Description: 分銷訂單多交期明細維護作業
#+ Creator....: 02748(2014-05-16 09:45:06)
#+ Modifier...: 04226 -SD/PR- 06137
 
{</section>}
 
{<section id="adbt500_03.global" >}
#應用 c02b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#3   2016/04/11  By 07675       將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#161228-00033#1   2016/12/29  By 06137       後續T100 應會有不同的DB支持  ROWNUM只適用於ORACLE DB 予以改寫 應將rownum寫法移除，ORDER BY 後FETCH FIRST抓第一筆
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
PRIVATE TYPE type_g_xmdf_d        RECORD
       xmdfdocno LIKE xmdf_t.xmdfdocno, 
   xmdfseq LIKE xmdf_t.xmdfseq, 
   xmdfseq2 LIKE xmdf_t.xmdfseq2, 
   l_xmdc001 LIKE type_t.chr500, 
   l_xmdc001_desc LIKE type_t.chr500, 
   l_xmdc001_desc_desc LIKE type_t.chr500, 
   l_xmdc002 LIKE type_t.chr500, 
   xmdf002 LIKE xmdf_t.xmdf002, 
   xmdf007 LIKE xmdf_t.xmdf007, 
   xmdf003 LIKE xmdf_t.xmdf003, 
   xmdf004 LIKE xmdf_t.xmdf004, 
   xmdf005 LIKE xmdf_t.xmdf005, 
   xmdf005_desc LIKE type_t.chr500, 
   xmdfsite LIKE xmdf_t.xmdfsite, 
   xmdfunit LIKE xmdf_t.xmdfunit, 
   xmdfunit_desc LIKE type_t.chr500, 
   xmdf006 LIKE xmdf_t.xmdf006, 
   xmdf200 LIKE xmdf_t.xmdf200, 
   xmdf200_desc LIKE type_t.chr500, 
   xmdf201 LIKE xmdf_t.xmdf201, 
   xmdf201_desc LIKE type_t.chr500, 
   xmdf202 LIKE xmdf_t.xmdf202, 
   xmdf203 LIKE xmdf_t.xmdf203
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_xmdfdocno     LIKE xmdf_t.xmdfdocno
DEFINE g_xmdfseq       LIKE xmdf_t.xmdfseq
DEFINE g_xmja003       LIKE xmja_t.xmja003
DEFINE g_xmja004       LIKE xmja_t.xmja004
DEFINE g_xmja025       LIKE xmja_t.xmja025
DEFINE g_xmda201       LIKE xmda_t.xmda201
#end add-point
 
DEFINE g_xmdf_d          DYNAMIC ARRAY OF type_g_xmdf_d
DEFINE g_xmdf_d_t        type_g_xmdf_d
 
 
DEFINE g_xmdfdocno_t   LIKE xmdf_t.xmdfdocno    #Key值備份
DEFINE g_xmdfseq_t      LIKE xmdf_t.xmdfseq    #Key值備份
DEFINE g_xmdfseq2_t      LIKE xmdf_t.xmdfseq2    #Key值備份
 
 
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
 
{<section id="adbt500_03.input" >}
#+ 資料輸入
PUBLIC FUNCTION adbt500_03(--)
   #add-point:input段變數傳入 name="input.get_var"
          p_xmdfdocno,p_xmdfseq,p_xmja003,p_xmja004,p_xmja014,p_xmja030,p_xmjasite,p_xmja025
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
   DEFINE p_xmdfdocno     LIKE xmdf_t.xmdfdocno
   DEFINE p_xmdfseq       LIKE xmdf_t.xmdfseq
   DEFINe p_xmja003       LIKE xmja_t.xmja003
   DEFINE p_xmja004       LIKE xmja_t.xmja004
   DEFINE p_xmja014       LIKE xmja_t.xmja014
   DEFINE p_xmja030       LIKE xmja_t.xmja030
   DEFINE p_xmjasite      LIKE xmja_t.xmjasite
   DEFINE p_xmja025       LIKE xmja_t.xmja025
   DEFINE r_xmdf002       LIKE xmdf_t.xmdf002
   DEFINE r_xmdf003       LIKE xmdf_t.xmdf003
   DEFINE r_xmdf004       LIKE xmdf_t.xmdf004
   DEFINE r_xmdf005       LIKE xmdf_t.xmdf005
   DEFINE l_lock_sw       LIKE type_t.chr1
   DEFINE l_forupd_sql    STRING
   DEFINE l_n             LIKE type_t.num5                #檢查重複用  
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_xmdf002       LIKE xmdf_t.xmdf002
   DEFINE l_xmdf003       LIKE xmdf_t.xmdf003
   DEFINE l_xmdaunit      LIKE xmdf_t.xmdfunit
   DEFINE l_xmda004       LIKE xmda_t.xmda004
   DEFINE l_xmda022       LIKE xmda_t.xmda022
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_xmja003       LIKE xmja_t.xmja003 
   DEFINE l_xmja004       LIKE xmja_t.xmja004
   DEFINE l_xmja014       LIKE xmja_t.xmja014
   DEFINE l_xmja030       LIKE xmja_t.xmja030
   DEFINE l_xmjasite      LIKE xmja_t.xmjasite
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_errno         LIKE type_t.chr10
   #lori522612  150122 add ----------------------(S)
   DEFINE l_xmda023       LIKE xmda_t.xmda023  
   DEFINE l_xmja040       LIKE xmja_t.xmja040  
   DEFINE l_xmja039       LIKE xmja_t.xmja039  
   DEFINE l_xmja038       LIKE xmja_t.xmja038  
   DEFINE l_xmja037       LIKE xmja_t.xmja037  
   DEFINE l_org           LIKE xmdf_t.xmdfunit
   #lori522612  150122 add ----------------------(E)    
   DEFINE l_sql           STRING
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_adbt500_03 WITH FORM cl_ap_formpath("adb","adbt500_03")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單身前置處理 name="input.pre_input"
   WHENEVER ERROR CONTINUE
   LET r_xmdf003 = ''
   LET r_xmdf004 = ''
   LET r_xmdf002 = ''
   #必須包在transaction裡面
   IF NOT s_transaction_chk('Y',1) THEN
      RETURN r_xmdf003,r_xmdf004,r_xmdf002
   END IF
   
   CALL cl_set_combo_scc_part('xmdf007','2057','1,2')
   
   LET g_xmdfdocno = p_xmdfdocno
   LET g_xmdfseq = p_xmdfseq
   LET g_xmja003 = p_xmja003
   LET g_xmja004 = p_xmja004

   LET g_xmda201 = ''
   LET l_xmdaunit = ''
   
   SELECT xmda201,xmdaunit,xmda022,xmda023           #lori522612 150122 add xmda023 
     INTO g_xmda201,l_xmdaunit,l_xmda022,l_xmda023   #lori522612 150122 add l_xmda023
     FROM xmda_t
    WHERE xmdaent = g_enterprise
      AND xmdadocno = p_xmdfdocno
   
   IF NOT cl_null(p_xmja025) THEN
      LET g_xmja025 = p_xmja025
   ELSE
      LET g_xmja025 = l_xmda022
   END IF
   
   SELECT xmja014,xmja030,xmjasite,xmja004,
          xmja003,xmja040,xmja039,xmja038,xmja037              #lori522612  150122 add
     INTO l_xmja014,l_xmja030,l_xmjasite,
          l_xmja003,l_xmja040,l_xmja039,l_xmja038,l_xmja037    #lori522612  150122 add 
     FROM xmja_t
    WHERE xmjaent = g_enterprise
      AND xmjadocno = p_xmdfdocno
      AND xmjaseq = p_xmdfseq
   
   IF cl_null(p_xmja014) THEN
      LET p_xmja014 = l_xmja014
   END IF
   
   IF cl_null(p_xmja030) THEN
      LET p_xmja030 = l_xmja030
   END IF
   
   IF cl_null(p_xmjasite) THEN
      LET p_xmjasite = l_xmjasite
   END IF
   
   IF NOT cl_null(p_xmja003) THEN
      LET g_xmja003 = p_xmja003
   ELSE
      LET g_xmja003 = l_xmja003
   END IF
   
   IF NOT cl_null(p_xmja004) THEN
      LET g_xmja004 = p_xmja004
   ELSE
      LET g_xmja004 = l_xmja004
   END IF
   
   #160803-00016#1 160804 by lori mark and add---(S)
   #LET l_forupd_sql = "SELECT xmdfdocno,xmdfseq,xmdfseq2,'','','','',xmdf002,xmdf007,xmdf003,xmdf004,xmdf005,'',xmdfsite,xmdfunit,'',xmdf006,xmdf200,'',xmdf201,'',xmdf202,xmdf203 FROM xmdf_t WHERE xmdfent = ? AND xmdfdocno = ? AND xmdfseq = ? AND xmdfseq2 = ? FOR UPDATE"
   LET l_forupd_sql = "SELECT xmdfdocno,xmdfseq,xmdfseq2,xmdf002, xmdf007, ",
                      "       xmdf003,  xmdf004,xmdf005, xmdfsite,xmdfunit, ",
                      "       xmdf006,  xmdf200,xmdf201, xmdf202, xmdf203 ",
                      "  FROM xmdf_t WHERE xmdfent = ? AND xmdfdocno = ? AND xmdfseq = ? AND xmdfseq2 = ? FOR UPDATE"
   #160803-00016#1 160804 by lori mark and add---(E)
   LET l_forupd_sql = cl_sql_forupd(l_forupd_sql)
   DECLARE adbt500_03_bcl CURSOR FROM l_forupd_sql

   WHILE TRUE 
      CALL adbt500_03_b_fill()
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT ARRAY g_xmdf_d FROM s_detail1.*
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
            #CALL adbt500_03_b_fill()
            LET g_rec_b = g_xmdf_d.getLength()
            IF p_xmja030 = 'N' THEN
               CALL cl_set_act_visible("insert,delete", FALSE)
               CALL cl_set_comp_entry("xmdf002,xmdf003,xmdf004",FALSE) 
               CALL cl_set_comp_required("xmdf005",FALSE)           
            END IF
            IF NOT cl_null(g_xmda201) THEN
               CALL cl_set_comp_required("xmdf200",TRUE)
            ELSE
               CALL cl_set_comp_required("xmdf200",FALSE)
            END IF
            IF NOT cl_null(l_xmdaunit) THEN
               CALL cl_set_comp_entry("xmdfunit",FALSE)
            ELSE
               CALL cl_set_comp_entry("xmdfunit",TRUE)
            END IF
          BEFORE ROW 
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            #CALL s_transaction_begin()
   
            LET g_rec_b = g_xmdf_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND NOT cl_null(g_xmdf_d[l_ac].xmdfdocno)
               AND NOT cl_null(g_xmdf_d[l_ac].xmdfseq) 
               AND NOT cl_null(g_xmdf_d[l_ac].xmdfseq2) 
            THEN
               LET l_cmd='u'
			   LET g_xmdf_d_t.* = g_xmdf_d[l_ac].*  #BACKUP
			   
			   OPEN adbt500_03_bcl USING g_enterprise,g_xmdf_d[l_ac].xmdfdocno,g_xmdf_d[l_ac].xmdfseq,g_xmdf_d[l_ac].xmdfseq2
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "adbt500_03_bcl"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET l_lock_sw='Y'
               ELSE
                  FETCH adbt500_03_bcl
                   #160803-00016#1 160804 by lori mark and add---(S)
                   #INTO g_xmdf_d[l_ac].xmdfdocno,     g_xmdf_d[l_ac].xmdfseq,        g_xmdf_d[l_ac].xmdfseq2,
                   #     g_xmdf_d[l_ac].l_xmdc001,     g_xmdf_d[l_ac].l_xmdc001_desc, g_xmdf_d[l_ac].l_xmdc001_desc_desc,
                   #     g_xmdf_d[l_ac].l_xmdc002,     g_xmdf_d[l_ac].xmdf002,        g_xmdf_d[l_ac].xmdf007,
                   #     g_xmdf_d[l_ac].xmdf003,       g_xmdf_d[l_ac].xmdf004,        g_xmdf_d[l_ac].xmdf005,
                   #     g_xmdf_d[l_ac].xmdf005_desc,  g_xmdf_d[l_ac].xmdfsite,       g_xmdf_d[l_ac].xmdfunit,
                   #     g_xmdf_d[l_ac].xmdfunit_desc, g_xmdf_d[l_ac].xmdf006,        g_xmdf_d[l_ac].xmdf200,
                   #     g_xmdf_d[l_ac].xmdf200_desc,  g_xmdf_d[l_ac].xmdf201,        g_xmdf_d[l_ac].xmdf201_desc,
                   #     g_xmdf_d[l_ac].xmdf202,       g_xmdf_d[l_ac].xmdf203
                   INTO g_xmdf_d[l_ac].xmdfdocno, g_xmdf_d[l_ac].xmdfseq, g_xmdf_d[l_ac].xmdfseq2, g_xmdf_d[l_ac].xmdf002,  g_xmdf_d[l_ac].xmdf007,   
                        g_xmdf_d[l_ac].xmdf003,   g_xmdf_d[l_ac].xmdf004,  g_xmdf_d[l_ac].xmdf005, g_xmdf_d[l_ac].xmdfsite, g_xmdf_d[l_ac].xmdfunit, 
                        g_xmdf_d[l_ac].xmdf006,   g_xmdf_d[l_ac].xmdf200,  g_xmdf_d[l_ac].xmdf201, g_xmdf_d[l_ac].xmdf202,  g_xmdf_d[l_ac].xmdf203                                                
                  #160803-00016#1 160804 by lori mark and add---(E)
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = g_xmdf_d[l_ac].xmdfdocno
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                  END IF
                  
                  CALL s_desc_get_item_desc(g_xmdf_d[l_ac].l_xmdc001) RETURNING g_xmdf_d[l_ac].l_xmdc001_desc,g_xmdf_d[l_ac].l_xmdc001_desc_desc
				      CALL s_desc_get_acc_desc('274',g_xmdf_d[l_ac].xmdf005) RETURNING g_xmdf_d[l_ac].xmdf005_desc
				      CALL s_desc_get_department_desc(g_xmdf_d[l_ac].xmdfunit) RETURNING g_xmdf_d[l_ac].xmdfunit_desc
                  CALL s_desc_get_stock_desc(g_xmdf_d[l_ac].xmdfunit,g_xmdf_d[l_ac].xmdf200) RETURNING g_xmdf_d[l_ac].xmdf200_desc
                  CALL s_desc_get_locator_desc(g_xmdf_d[l_ac].xmdfunit,g_xmdf_d[l_ac].xmdf200,g_xmdf_d[l_ac].xmdf201) RETURNING g_xmdf_d[l_ac].xmdf201_desc
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
        
         BEFORE INSERT
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xmdf_d[l_ac].* TO NULL          
            
            IF cl_null(p_xmjasite) THEN
               LET g_xmdf_d[l_ac].xmdfsite = g_site
            ELSE
               LET g_xmdf_d[l_ac].xmdfsite = p_xmjasite
            END IF

            IF cl_null(l_xmdaunit) THEN
               LET g_xmdf_d[l_ac].xmdfunit = g_site
            ELSE
               LET g_xmdf_d[l_ac].xmdfunit = l_xmdaunit
            END IF
            IF NOT cl_null(g_xmda201) THEN
               CALL adbt500_03_get_xmdf200(p_xmdfdocno,p_xmdfseq)
            #lori522612  150122 add ----------------------(S)
            #依發貨組織範圍設定取預設庫位
            ELSE
               LET l_org = ''
               CALL s_adbi260_inv_scope_def(g_xmdf_d[l_ac].xmdfunit,l_xmja003,l_xmda023,l_xmja040,l_xmja039,l_xmja038,l_xmja037)
                  RETURNING l_org,g_xmdf_d[l_ac].xmdf200
            #lori522612  150122 add ----------------------(E)            
            END IF
            
            LET g_xmdf_d[l_ac].xmdfdocno = g_xmdfdocno
            LET g_xmdf_d[l_ac].xmdfseq = g_xmdfseq
            LET g_xmdf_d[l_ac].l_xmdc001 = g_xmja003
            LET g_xmdf_d[l_ac].l_xmdc002 = g_xmja004
            CALL s_desc_get_acc_desc('274',g_xmdf_d[l_ac].xmdf005) RETURNING g_xmdf_d[l_ac].xmdf005_desc  
            CALL s_desc_get_department_desc(g_xmdf_d[l_ac].xmdfunit) RETURNING g_xmdf_d[l_ac].xmdfunit_desc
            
            LET g_xmdf_d[l_ac].xmdf006 = 'N'
            LET g_xmdf_d[l_ac].xmdf007 = '1'
            
            SELECT MAX(xmdfseq2)+1 INTO g_xmdf_d[l_ac].xmdfseq2 FROM xmdf_t WHERE xmdfent = g_enterprise AND xmdfdocno = g_xmdfdocno AND xmdfseq = g_xmdfseq
            IF cl_null(g_xmdf_d[l_ac].xmdfseq2) OR g_xmdf_d[l_ac].xmdfseq2 = 0 THEN
               LET g_xmdf_d[l_ac].xmdfseq2 = 1
            END IF
            CALL s_desc_get_item_desc(g_xmdf_d[l_ac].l_xmdc001)
               RETURNING g_xmdf_d[l_ac].l_xmdc001_desc,g_xmdf_d[l_ac].l_xmdc001_desc_desc
                          
            LET g_xmdf_d_t.* = g_xmdf_d[l_ac].*     #新輸入資料

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
               
            IF cl_null(g_xmdf_d[l_ac].xmdf200) THEN
               LET g_xmdf_d[l_ac].xmdf200 = ' '
            END IF
            IF cl_null(g_xmdf_d[l_ac].xmdf201) THEN
               LET g_xmdf_d[l_ac].xmdf201 = ' '
            END IF
            IF cl_null(g_xmdf_d[l_ac].xmdf202) THEN
               LET g_xmdf_d[l_ac].xmdf202 = ' '
            END IF
            IF cl_null(g_xmdf_d[l_ac].xmdf203) THEN
               LET g_xmdf_d[l_ac].xmdf203 = ' '
            END IF
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM xmdf_t 
             WHERE xmdfent = g_enterprise AND xmdfdocno = g_xmdf_d[l_ac].xmdfdocno
               AND xmdfseq = g_xmdf_d[l_ac].xmdfseq
               AND xmdfseq2 = g_xmdf_d[l_ac].xmdfseq2
      
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               INSERT INTO xmdf_t (xmdfent,xmdfsite,xmdfunit,xmdfdocno,xmdfseq,xmdfseq2,xmdf002,xmdf003,xmdf004,xmdf005,xmdf006,xmdf007,xmdf200,xmdf201,xmdf202,xmdf203)
                  VALUES (g_enterprise,g_xmdf_d[l_ac].xmdfsite,g_xmdf_d[l_ac].xmdfunit,g_xmdf_d[l_ac].xmdfdocno,g_xmdf_d[l_ac].xmdfseq,g_xmdf_d[l_ac].xmdfseq2,g_xmdf_d[l_ac].xmdf002,g_xmdf_d[l_ac].xmdf003,g_xmdf_d[l_ac].xmdf004,g_xmdf_d[l_ac].xmdf005,g_xmdf_d[l_ac].xmdf006,g_xmdf_d[l_ac].xmdf007,g_xmdf_d[l_ac].xmdf200,g_xmdf_d[l_ac].xmdf201,g_xmdf_d[l_ac].xmdf202,g_xmdf_d[l_ac].xmdf203)
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_xmdf_d[l_ac].* TO NULL
               #CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "xmdf_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               #CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
              
         BEFORE DELETE                            #是否取消單身
            IF NOT cl_null(g_xmdf_d[l_ac].xmdfdocno)
               AND NOT cl_null(g_xmdf_d[l_ac].xmdfseq) 
               AND NOT cl_null(g_xmdf_d[l_ac].xmdfseq2) THEN 
               
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

               DELETE FROM xmdf_t
                WHERE xmdfent = g_enterprise AND xmdfdocno = g_xmdf_d_t.xmdfdocno
                  AND xmdfseq = g_xmdf_d_t.xmdfseq
                  AND xmdfseq2 = g_xmdf_d_t.xmdfseq2

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "xmdf_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

                  #CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  #CALL s_transaction_end('Y','0')
               END IF 
               CLOSE adbt500_03_bcl
               LET l_count = g_xmdf_d.getLength()
            END IF 
            
        ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_xmdf_d[l_ac].* = g_xmdf_d_t.*
               CLOSE adbt500_03_bcl
               #CALL s_transaction_end('N','0')
               EXIT DIALOG
            END IF
            IF cl_null(g_xmdf_d[l_ac].xmdf200) THEN
               LET g_xmdf_d[l_ac].xmdf200 = ' '
            END IF
            IF cl_null(g_xmdf_d[l_ac].xmdf201) THEN
               LET g_xmdf_d[l_ac].xmdf201 = ' '
            END IF
            IF cl_null(g_xmdf_d[l_ac].xmdf202) THEN
               LET g_xmdf_d[l_ac].xmdf202 = ' '
            END IF
            IF cl_null(g_xmdf_d[l_ac].xmdf203) THEN
               LET g_xmdf_d[l_ac].xmdf203 = ' '
            END IF
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_xmdf_d[l_ac].xmdf002
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_xmdf_d[l_ac].* = g_xmdf_d_t.*
            ELSE
               UPDATE xmdf_t SET (xmdfseq2,xmdf002,xmdf003,xmdf004,xmdf005,xmdf006,xmdf007,xmdf200,xmdf201,xmdf202,xmdfunit,xmdf203) = (g_xmdf_d[l_ac].xmdfseq2,g_xmdf_d[l_ac].xmdf002,g_xmdf_d[l_ac].xmdf003,g_xmdf_d[l_ac].xmdf004,g_xmdf_d[l_ac].xmdf005,g_xmdf_d[l_ac].xmdf006,g_xmdf_d[l_ac].xmdf007,g_xmdf_d[l_ac].xmdf200,g_xmdf_d[l_ac].xmdf201,g_xmdf_d[l_ac].xmdf202,g_xmdf_d[l_ac].xmdfunit,g_xmdf_d[l_ac].xmdf203)
                WHERE xmdfent = g_enterprise 
                  AND xmdfdocno = g_xmdf_d_t.xmdfdocno
                  AND xmdfseq = g_xmdf_d_t.xmdfseq
                  AND xmdfseq2 = g_xmdf_d_t.xmdfseq2

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "xmdf_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

                  LET g_xmdf_d[l_ac].* = g_xmdf_d_t.*
                  #CALL s_transaction_end('N','0')
               ELSE
                  #CALL s_transaction_end('Y','0')
                  IF p_xmja030 = 'N' THEN
                     EXIT DIALOG
                  END IF
               END IF
            END IF
            
         AFTER ROW
            CLOSE adbt500_03_bcl
            #CALL s_transaction_end('Y','0')
            IF p_xmja030 = 'N' THEN
               #NEXT FIELD CURRENT
               EXIT DIALOG
            END IF
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdfdocno
            #add-point:BEFORE FIELD xmdfdocno name="input.b.page1.xmdfdocno"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdfdocno
            
            #add-point:AFTER FIELD xmdfdocno name="input.a.page1.xmdfdocno"
                                    #此段落由子樣板a05產生
            IF  g_xmdf_d[g_detail_idx].xmdfdocno IS NOT NULL AND g_xmdf_d[g_detail_idx].xmdfseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xmdf_d[g_detail_idx].xmdfdocno != g_xmdf_d_t.xmdfdocno OR g_xmdf_d[g_detail_idx].xmdfseq != g_xmdf_d_t.xmdfseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmdf_t WHERE "||"xmdfent = '" ||g_enterprise|| "' AND "||"xmdfdocno = '"||g_xmdf_d[g_detail_idx].xmdfdocno ||"' AND "|| "xmdfseq = '"||g_xmdf_d[g_detail_idx].xmdfseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdfdocno
            #add-point:ON CHANGE xmdfdocno name="input.g.page1.xmdfdocno"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdfseq
            #add-point:BEFORE FIELD xmdfseq name="input.b.page1.xmdfseq"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdfseq
            
            #add-point:AFTER FIELD xmdfseq name="input.a.page1.xmdfseq"
                                    #此段落由子樣板a05產生
            IF  g_xmdf_d[g_detail_idx].xmdfdocno IS NOT NULL AND g_xmdf_d[g_detail_idx].xmdfseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xmdf_d[g_detail_idx].xmdfdocno != g_xmdf_d_t.xmdfdocno OR g_xmdf_d[g_detail_idx].xmdfseq != g_xmdf_d_t.xmdfseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmdf_t WHERE "||"xmdfent = '" ||g_enterprise|| "' AND "||"xmdfdocno = '"||g_xmdf_d[g_detail_idx].xmdfdocno ||"' AND "|| "xmdfseq = '"||g_xmdf_d[g_detail_idx].xmdfseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdfseq
            #add-point:ON CHANGE xmdfseq name="input.g.page1.xmdfseq"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdfseq2
            #add-point:BEFORE FIELD xmdfseq2 name="input.b.page1.xmdfseq2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdfseq2
            
            #add-point:AFTER FIELD xmdfseq2 name="input.a.page1.xmdfseq2"
            #此段落由子樣板a05產生
            IF  g_xmdf_d[g_detail_idx].xmdfdocno IS NOT NULL AND g_xmdf_d[g_detail_idx].xmdfseq IS NOT NULL AND g_xmdf_d[g_detail_idx].xmdfseq2 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xmdf_d[g_detail_idx].xmdfdocno != g_xmdf_d_t.xmdfdocno OR g_xmdf_d[g_detail_idx].xmdfseq != g_xmdf_d_t.xmdfseq OR g_xmdf_d[g_detail_idx].xmdfseq2 != g_xmdf_d_t.xmdfseq2)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmdf_t WHERE "||"xmdfent = '" ||g_enterprise|| "' AND "||"xmdfdocno = '"||g_xmdf_d[g_detail_idx].xmdfdocno ||"' AND "|| "xmdfseq = '"||g_xmdf_d[g_detail_idx].xmdfseq ||"' AND "|| "xmdfseq2 = '"||g_xmdf_d[g_detail_idx].xmdfseq2 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdfseq2
            #add-point:ON CHANGE xmdfseq2 name="input.g.page1.xmdfseq2"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xmdc001
            
            #add-point:AFTER FIELD l_xmdc001 name="input.a.page1.l_xmdc001"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xmdf_d[l_ac].l_xmdc001
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xmdf_d[l_ac].l_xmdc001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xmdf_d[l_ac].l_xmdc001_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xmdc001
            #add-point:BEFORE FIELD l_xmdc001 name="input.b.page1.l_xmdc001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xmdc001
            #add-point:ON CHANGE l_xmdc001 name="input.g.page1.l_xmdc001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xmdc002
            #add-point:BEFORE FIELD l_xmdc002 name="input.b.page1.l_xmdc002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xmdc002
            
            #add-point:AFTER FIELD l_xmdc002 name="input.a.page1.l_xmdc002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xmdc002
            #add-point:ON CHANGE l_xmdc002 name="input.g.page1.l_xmdc002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdf002
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmdf_d[l_ac].xmdf002,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD xmdf002
            END IF 
 
 
 
            #add-point:AFTER FIELD xmdf002 name="input.a.page1.xmdf002"
            IF NOT cl_null(g_xmdf_d[l_ac].xmdf002) THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xmdf_d[l_ac].xmdf002 != g_xmdf_d_t.xmdf002 OR cl_null(g_xmdf_d_t.xmdf002))) THEN
                  LET l_xmdf002 = 0
                  #已維護的分批數量
                  #SELECT SUM(xmdf002) INTO l_xmdf002 FROM xmdf_t 
                  # WHERE xmdfent = g_enterprise AND xmdfdocno = g_xmdfdocno AND xmdfseq = g_xmdfseq
                  #   AND xmdfseq2 <> g_xmdf_d[l_ac].xmdfseq2

                  FOR l_i = 1 TO g_xmdf_d.getLength()
                     LET l_xmdf002 = l_xmdf002 + g_xmdf_d[l_i].xmdf002
                  END FOR
                  #分批數量總合+本分批數量不可以大於採購數量
                  IF l_xmdf002 > p_xmja014 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axm-00294'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_xmdf_d[l_ac].xmdf002 = g_xmdf_d_t.xmdf002
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdf002
            #add-point:BEFORE FIELD xmdf002 name="input.b.page1.xmdf002"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdf002
            #add-point:ON CHANGE xmdf002 name="input.g.page1.xmdf002"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdf007
            #add-point:BEFORE FIELD xmdf007 name="input.b.page1.xmdf007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdf007
            
            #add-point:AFTER FIELD xmdf007 name="input.a.page1.xmdf007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdf007
            #add-point:ON CHANGE xmdf007 name="input.g.page1.xmdf007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdf003
            #add-point:BEFORE FIELD xmdf003 name="input.b.page1.xmdf003"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdf003
            
            #add-point:AFTER FIELD xmdf003 name="input.a.page1.xmdf003"
            IF g_xmdf_d[l_ac].xmdf003 > g_xmdf_d[l_ac].xmdf004 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'adb-00079'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               NEXT FIELD xmdf003
            END IF      
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdf003
            #add-point:ON CHANGE xmdf003 name="input.g.page1.xmdf003"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdf004
            #add-point:BEFORE FIELD xmdf004 name="input.b.page1.xmdf004"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdf004
            
            #add-point:AFTER FIELD xmdf004 name="input.a.page1.xmdf004"
            IF g_xmdf_d[l_ac].xmdf004 < g_xmdf_d[l_ac].xmdf003 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'adb-00079'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               NEXT FIELD xmdf004
            END IF            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdf004
            #add-point:ON CHANGE xmdf004 name="input.g.page1.xmdf004"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdf005
            
            #add-point:AFTER FIELD xmdf005 name="input.a.page1.xmdf005"
            LET g_xmdf_d[l_ac].xmdf005_desc = '' 
            IF NOT cl_null(g_xmdf_d[l_ac].xmdf005) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xmdf_d[l_ac].xmdf005 != g_xmdf_d_t.xmdf005 OR cl_null(g_xmdf_d_t.xmdf005))) THEN
                  IF NOT s_azzi650_chk_exist('274',g_xmdf_d[l_ac].xmdf005) THEN
                     LET g_xmdf_d[l_ac].xmdf005 = g_xmdf_d_t.xmdf005
                     CALL s_desc_get_acc_desc('274',g_xmdf_d[l_ac].xmdf005) RETURNING g_xmdf_d[l_ac].xmdf005_desc
                     DISPLAY BY NAME g_xmdf_d[l_ac].xmdf005_desc 
                     NEXT FIELD CURRENT
                  END IF
               END IF   
            END IF 
            CALL s_desc_get_acc_desc('274',g_xmdf_d[l_ac].xmdf005) RETURNING g_xmdf_d[l_ac].xmdf005_desc
            DISPLAY BY NAME g_xmdf_d[l_ac].xmdf005_desc 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdf005
            #add-point:BEFORE FIELD xmdf005 name="input.b.page1.xmdf005"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdf005
            #add-point:ON CHANGE xmdf005 name="input.g.page1.xmdf005"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdfsite
            
            #add-point:AFTER FIELD xmdfsite name="input.a.page1.xmdfsite"
       
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdfsite
            #add-point:BEFORE FIELD xmdfsite name="input.b.page1.xmdfsite"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdfsite
            #add-point:ON CHANGE xmdfsite name="input.g.page1.xmdfsite"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdfunit
            
            #add-point:AFTER FIELD xmdfunit name="input.a.page1.xmdfunit"
            IF NOT cl_null(g_xmdf_d[l_ac].xmdfunit) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xmdf_d[l_ac].xmdfunit != g_xmdf_d_t.xmdfunit OR cl_null(g_xmdf_d_t.xmdfunit))) THEN
                  #此段落由子樣板a19產生
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#                  INITIALIZE g_chkparam.* TO NULL
#                  
#                  #設定g_chkparam.*的參數
#                  LET g_chkparam.arg1 = g_xmdf_d[l_ac].xmdfunit
#                  LET g_chkparam.arg2 = '2'
#                  LET g_chkparam.arg3 = g_site
#                     
#                  #呼叫檢查存在並帶值的library
#                  IF cl_chk_exist("v_ooed004") THEN
                  CALL s_aooi500_chk(g_prog,'xmdfunit',g_xmdf_d[l_ac].xmdfunit,g_site) RETURNING l_success,l_errno
                  IF l_success THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
                     IF NOT cl_null(g_xmda201) THEN
                        CALL adbt500_03_get_xmdf200(p_xmdfdocno,p_xmdfseq)
                        CALL s_desc_get_stock_desc(g_xmdf_d[l_ac].xmdfunit,g_xmdf_d[l_ac].xmdf200) RETURNING g_xmdf_d[l_ac].xmdf200_desc
                        CALL s_desc_get_locator_desc(g_xmdf_d[l_ac].xmdfunit,g_xmdf_d[l_ac].xmdf200,g_xmdf_d[l_ac].xmdf201) RETURNING g_xmdf_d[l_ac].xmdf201_desc
                        DISPLAY BY NAME g_xmdf_d[l_ac].xmdf200_desc,g_xmdf_d[l_ac].xmdf201_desc
                    END IF
                  ELSE
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = '' 
                     LET g_errparam.code   = l_errno 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     #檢查失敗時後續處理
                     LET g_xmdf_d[l_ac].xmdfunit = g_xmdf_d_t.xmdfunit
                     CALL s_desc_get_department_desc(g_xmdf_d[l_ac].xmdfunit) RETURNING g_xmdf_d[l_ac].xmdfunit_desc
                     DISPLAY BY NAME g_xmdf_d[l_ac].xmdfunit_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
            CALL s_desc_get_department_desc(g_xmdf_d[l_ac].xmdfunit) RETURNING g_xmdf_d[l_ac].xmdfunit_desc
            DISPLAY BY NAME g_xmdf_d[l_ac].xmdfunit_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdfunit
            #add-point:BEFORE FIELD xmdfunit name="input.b.page1.xmdfunit"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdfunit
            #add-point:ON CHANGE xmdfunit name="input.g.page1.xmdfunit"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdf006
            #add-point:BEFORE FIELD xmdf006 name="input.b.page1.xmdf006"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdf006
            
            #add-point:AFTER FIELD xmdf006 name="input.a.page1.xmdf006"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdf006
            #add-point:ON CHANGE xmdf006 name="input.g.page1.xmdf006"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdf200
            
            #add-point:AFTER FIELD xmdf200 name="input.a.page1.xmdf200"
            IF NOT cl_null(g_xmdf_d[l_ac].xmdf200) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xmdf_d[l_ac].xmdf200 != g_xmdf_d_t.xmdf200 OR cl_null(g_xmdf_d_t.xmdf200))) THEN
                  #此段落由子樣板a19產生
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_xmdf_d[l_ac].xmdfunit
                  LET g_chkparam.arg2 = g_xmdf_d[l_ac].xmdf200
                  IF cl_chk_exist("v_inaa001_1") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
                     IF NOT cl_null(g_xmda201) THEN
                        IF NOT adbt500_03_chk_xmdf200(p_xmdfdocno,p_xmdfseq,'1') THEN
                           LET g_xmdf_d[l_ac].xmdf200 = g_xmdf_d_t.xmdf200
                           CALL s_desc_get_stock_desc(g_xmdf_d[l_ac].xmdfunit,g_xmdf_d[l_ac].xmdf200) RETURNING g_xmdf_d[l_ac].xmdf200_desc
                           DISPLAY BY NAME g_xmdf_d[l_ac].xmdf200_desc 
                           NEXT FIELD CURRENT
                        END IF
                     #lori522612  150122 add ----------------------(S)
                     ELSE
                        INITIALIZE g_chkparam.* TO NULL
                        LET g_chkparam.arg1 = g_xmdf_d[l_ac].xmdfunit   #發貨組織
                        LET g_chkparam.arg2 = g_xmdf_d[l_ac].xmdf200    #庫位
                        LET g_chkparam.arg3 = l_xmja003                 #料件編號
                        LET g_chkparam.arg4 = l_xmda023                 #銷售渠道編號
                        LET g_chkparam.arg5 = l_xmja040                 #區域編號
                        LET g_chkparam.arg6 = l_xmja039                 #省州編號
                        LET g_chkparam.arg7 = l_xmja038                 #縣市編號
                        LET g_chkparam.arg8 = l_xmja037                 #地區編號
                        #160318-00025#3--add--str
                        LET g_errshow = TRUE 
                        LET g_chkparam.err_str[1] = "aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
                        #160318-00025#3--add--end
                        IF NOT cl_chk_exist("v_inaa001_16") THEN
                           LET g_xmdf_d[l_ac].xmdf200 = g_xmdf_d_t.xmdf200
                           CALL s_desc_get_stock_desc(g_xmdf_d[l_ac].xmdfunit,g_xmdf_d[l_ac].xmdf200) RETURNING g_xmdf_d[l_ac].xmdf200_desc
                           DISPLAY BY NAME g_xmdf_d[l_ac].xmdf200_desc 
                           NEXT FIELD CURRENT                        
                        END IF                        
                     #lori522612  150122 add ----------------------(E)
                     END IF
                  ELSE
                     #檢查失敗時後續處理
                     LET g_xmdf_d[l_ac].xmdf200 = g_xmdf_d_t.xmdf200
                     CALL s_desc_get_stock_desc(g_xmdf_d[l_ac].xmdfunit,g_xmdf_d[l_ac].xmdf200) RETURNING g_xmdf_d[l_ac].xmdf200_desc
                     DISPLAY BY NAME g_xmdf_d[l_ac].xmdf200_desc 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
            CALL s_desc_get_stock_desc(g_xmdf_d[l_ac].xmdfunit,g_xmdf_d[l_ac].xmdf200) RETURNING g_xmdf_d[l_ac].xmdf200_desc
            DISPLAY BY NAME g_xmdf_d[l_ac].xmdf200_desc 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdf200
            #add-point:BEFORE FIELD xmdf200 name="input.b.page1.xmdf200"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdf200
            #add-point:ON CHANGE xmdf200 name="input.g.page1.xmdf200"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdf201
            
            #add-point:AFTER FIELD xmdf201 name="input.a.page1.xmdf201"
            IF NOT cl_null(g_xmdf_d[l_ac].xmdf201) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xmdf_d[l_ac].xmdf201 != g_xmdf_d_t.xmdf201 OR cl_null(g_xmdf_d_t.xmdf201))) THEN
                  #此段落由子樣板a19產生
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  LET g_chkparam.arg1 = g_xmdf_d[l_ac].xmdfunit
                  LET g_chkparam.arg2 = g_xmdf_d[l_ac].xmdf200
                  LET g_chkparam.arg3 = g_xmdf_d[l_ac].xmdf201
                  #160318-00025#3--add--str
                  LET g_errshow = TRUE 
                  LET g_chkparam.err_str[1] = "aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
                  #160318-00025#3--add--end
                  #lori522612  150122 add ----------------------(S)
                  #IF cl_chk_exist("v_inab002_1") THEN
                  IF cl_chk_exist("v_inab002") THEN
                  #lori522612  150122 add ----------------------(E)
                     IF NOT cl_null(g_xmda201) THEN
                        IF NOT adbt500_03_chk_xmdf200(p_xmdfdocno,p_xmdfseq,'2') THEN
                           LET g_xmdf_d[l_ac].xmdf201 = g_xmdf_d_t.xmdf201
                           CALL s_desc_get_locator_desc(g_xmdf_d[l_ac].xmdfunit,g_xmdf_d[l_ac].xmdf200,g_xmdf_d[l_ac].xmdf201) RETURNING g_xmdf_d[l_ac].xmdf201_desc
                           DISPLAY BY NAME g_xmdf_d[l_ac].xmdf201_desc 
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  ELSE
                     #檢查失敗時後續處理
                     LET g_xmdf_d[l_ac].xmdf201 = g_xmdf_d_t.xmdf201
                     CALL s_desc_get_locator_desc(g_xmdf_d[l_ac].xmdfunit,g_xmdf_d[l_ac].xmdf200,g_xmdf_d[l_ac].xmdf201) RETURNING g_xmdf_d[l_ac].xmdf201_desc
                     DISPLAY BY NAME g_xmdf_d[l_ac].xmdf201_desc 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
            CALL s_desc_get_locator_desc(g_xmdf_d[l_ac].xmdfunit,g_xmdf_d[l_ac].xmdf200,g_xmdf_d[l_ac].xmdf201) RETURNING g_xmdf_d[l_ac].xmdf201_desc
            DISPLAY BY NAME g_xmdf_d[l_ac].xmdf201_desc 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdf201
            #add-point:BEFORE FIELD xmdf201 name="input.b.page1.xmdf201"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdf201
            #add-point:ON CHANGE xmdf201 name="input.g.page1.xmdf201"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdf202
            #add-point:BEFORE FIELD xmdf202 name="input.b.page1.xmdf202"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdf202
            
            #add-point:AFTER FIELD xmdf202 name="input.a.page1.xmdf202"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdf202
            #add-point:ON CHANGE xmdf202 name="input.g.page1.xmdf202"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdf203
            #add-point:BEFORE FIELD xmdf203 name="input.b.page1.xmdf203"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdf203
            
            #add-point:AFTER FIELD xmdf203 name="input.a.page1.xmdf203"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdf203
            #add-point:ON CHANGE xmdf203 name="input.g.page1.xmdf203"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.xmdfdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdfdocno
            #add-point:ON ACTION controlp INFIELD xmdfdocno name="input.c.page1.xmdfdocno"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdfseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdfseq
            #add-point:ON ACTION controlp INFIELD xmdfseq name="input.c.page1.xmdfseq"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdfseq2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdfseq2
            #add-point:ON ACTION controlp INFIELD xmdfseq2 name="input.c.page1.xmdfseq2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xmdc001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xmdc001
            #add-point:ON ACTION controlp INFIELD l_xmdc001 name="input.c.page1.l_xmdc001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xmdc002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xmdc002
            #add-point:ON ACTION controlp INFIELD l_xmdc002 name="input.c.page1.l_xmdc002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdf002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdf002
            #add-point:ON ACTION controlp INFIELD xmdf002 name="input.c.page1.xmdf002"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdf007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdf007
            #add-point:ON ACTION controlp INFIELD xmdf007 name="input.c.page1.xmdf007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdf003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdf003
            #add-point:ON ACTION controlp INFIELD xmdf003 name="input.c.page1.xmdf003"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdf004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdf004
            #add-point:ON ACTION controlp INFIELD xmdf004 name="input.c.page1.xmdf004"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdf005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdf005
            #add-point:ON ACTION controlp INFIELD xmdf005 name="input.c.page1.xmdf005"
                                    INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmdf_d[l_ac].xmdf005             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "274" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_xmdf_d[l_ac].xmdf005 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_xmdf_d[l_ac].xmdf005 TO xmdf005              #顯示到畫面上
            CALL s_desc_get_acc_desc('274',g_xmdf_d[l_ac].xmdf005) RETURNING g_xmdf_d[l_ac].xmdf005_desc
            DISPLAY BY NAME g_xmdf_d[l_ac].xmdf005_desc
            NEXT FIELD xmdf005                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdfsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdfsite
            #add-point:ON ACTION controlp INFIELD xmdfsite name="input.c.page1.xmdfsite"
                
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdfunit
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdfunit
            #add-point:ON ACTION controlp INFIELD xmdfunit name="input.c.page1.xmdfunit"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmdf_d[l_ac].xmdfunit             #給予default值

            #給予arg
#            LET g_qryparam.arg1 = g_site
#            LET g_qryparam.arg2 = '2'
#            
#            CALL q_ooed004_3()                                #呼叫開窗
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'xmdfunit',g_site,'i') #150308-00001#3 150309 pomelo add 'i'
            CALL q_ooef001_24()
            LET g_xmdf_d[l_ac].xmdfunit = g_qryparam.return1              

            DISPLAY g_xmdf_d[l_ac].xmdfunit TO xmdfunit              #
            CALL s_desc_get_department_desc(g_xmdf_d[l_ac].xmdfunit) RETURNING g_xmdf_d[l_ac].xmdfunit_desc
            DISPLAY BY NAME g_xmdf_d[l_ac].xmdfunit_desc
            NEXT FIELD xmdfunit                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdf006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdf006
            #add-point:ON ACTION controlp INFIELD xmdf006 name="input.c.page1.xmdf006"
             
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdf200
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdf200
            #add-point:ON ACTION controlp INFIELD xmdf200 name="input.c.page1.xmdf200"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmdf_d[l_ac].xmdf200             #給予default值
            IF cl_null(g_xmda201) THEN
#               LET g_qryparam.default1 = g_xmdf_d[l_ac].xmdf200    #給予default值
#               LET g_qryparam.default2 = g_xmdf_d[l_ac].xmdf201
#               LET g_qryparam.default3 = g_xmdf_d[l_ac].xmdf202
#                  
#               CALL adbt500_03_get_xmja003(p_xmdfdocno,p_xmdfseq) RETURNING l_xmja003,l_xmja004   
#               LET g_qryparam.arg1 = l_xmja003
#               LET g_qryparam.arg2 = l_xmja004
#               LET g_qryparam.arg3 = g_xmdf_d[l_ac].xmdfunit
#               CALL q_inag004_1()                                   #呼叫開窗
#               LET g_xmdf_d[l_ac].xmdf200 = g_qryparam.return1     #將開窗取得的值回傳到變數
#               LET g_xmdf_d[l_ac].xmdf201 = g_qryparam.return2
#               LET g_xmdf_d[l_ac].xmdf202 = g_qryparam.return3
#               
#               DISPLAY g_xmdf_d[l_ac].xmdf200 TO xmdf200
#               DISPLAY g_xmdf_d[l_ac].xmdf201 TO xmdf201
#               DISPLAY g_xmdf_d[l_ac].xmdf202 TO xmdf202
               
               #lori522612  150122 add ----------------------(S)
               #LET g_qryparam.arg1 = g_xmdf_d[l_ac].xmdfunit     
               #CALL q_inaa001_4()                             #呼叫開窗
               #依發貨組織範圍設定提供符合的庫位清單
               LET g_qryparam.arg1 = l_xmja003                 #料件編號
               LET g_qryparam.arg2 = l_xmda023                 #銷售渠道編號
               LET g_qryparam.arg3 = l_xmja040                 #區域編號
               LET g_qryparam.arg4 = l_xmja039                 #省州編號
               LET g_qryparam.arg5 = l_xmja038                 #縣市編號
               LET g_qryparam.arg6 = l_xmja037                 #地區編號
               LET g_qryparam.arg7 = g_xmdf_d[l_ac].xmdfunit   #發貨組織
               CALL q_inaa001_24()                                              
               #lori522612  150122 add ----------------------(E)
               LET g_xmdf_d[l_ac].xmdf200 = g_qryparam.return1           
            ELSE
               LET g_qryparam.arg1 = g_xmdf_d[l_ac].xmdfunit
               LET g_qryparam.arg2 = g_xmda201
               CALL q_dbag004_1()
               LET g_xmdf_d[l_ac].xmdf200 = g_qryparam.return1 
               
            END IF
            DISPLAY g_xmdf_d[l_ac].xmdf200 TO xmdf200             
            CALL s_desc_get_stock_desc(g_xmdf_d[l_ac].xmdfunit,g_xmdf_d[l_ac].xmdf200) RETURNING g_xmdf_d[l_ac].xmdf200_desc
            CALL s_desc_get_locator_desc(g_xmdf_d[l_ac].xmdfunit,g_xmdf_d[l_ac].xmdf200,g_xmdf_d[l_ac].xmdf201) RETURNING g_xmdf_d[l_ac].xmdf201_desc
            DISPLAY BY NAME g_xmdf_d[l_ac].xmdf200_desc,g_xmdf_d[l_ac].xmdf201_desc
            NEXT FIELD xmdf200                          #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdf201
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdf201
            #add-point:ON ACTION controlp INFIELD xmdf201 name="input.c.page1.xmdf201"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmdf_d[l_ac].xmdf201             #給予default值
            IF cl_null(g_xmda201) THEN   
               #給予arg
               IF NOT cl_null(g_xmdf_d[l_ac].xmdf200) THEN
#                  CALL adbt500_03_get_xmja003(p_xmdfdocno,p_xmdfseq) RETURNING l_xmja003,l_xmja004
#                  LET g_qryparam.arg1 = l_xmja003
#                  LET g_qryparam.arg2 = l_xmja004
#                  LET g_qryparam.arg3 = g_xmdf_d[l_ac].xmdf200
#                  LET g_qryparam.arg4 = g_xmdf_d[l_ac].xmdfunit
#                  CALL q_inag005_5()                                      #呼叫開窗
#                  LET g_xmdf_d[l_ac].xmdf201 = g_qryparam.return1      #將開窗取得的值回傳到變數
               
                  LET g_qryparam.arg1 = g_xmdf_d[l_ac].xmdfunit
                  LET g_qryparam.arg2 = g_xmdf_d[l_ac].xmdf200
               
                  CALL q_inab002_8()                                #呼叫開窗
                  LET g_xmdf_d[l_ac].xmdf201 = g_qryparam.return1
               ELSE
                  LET g_qryparam.arg1 = g_xmdf_d[l_ac].xmdfunit
               
                  CALL q_inab002_10()                                #呼叫開窗
                  LET g_xmdf_d[l_ac].xmdf201 = g_qryparam.return1
               END IF
            ELSE
               LET g_qryparam.arg1 = g_xmdf_d[l_ac].xmdfunit
               LET g_qryparam.arg2 = g_xmda201
               CALL q_dbag004_2()
               LET g_xmdf_d[l_ac].xmdf201 = g_qryparam.return1 
            END IF
            DISPLAY g_xmdf_d[l_ac].xmdf201 TO xmdf201              #
            CALL s_desc_get_locator_desc(g_xmdf_d[l_ac].xmdfunit,g_xmdf_d[l_ac].xmdf200,g_xmdf_d[l_ac].xmdf201) RETURNING g_xmdf_d[l_ac].xmdf201_desc
            DISPLAY BY NAME g_xmdf_d[l_ac].xmdf201_desc
            NEXT FIELD xmdf201                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdf202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdf202
            #add-point:ON ACTION controlp INFIELD xmdf202 name="input.c.page1.xmdf202"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdf203
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdf203
            #add-point:ON ACTION controlp INFIELD xmdf203 name="input.c.page1.xmdf203"
            
            #END add-point
 
 
 
 
         #自訂ACTION
         #add-point:單身其他段落處理(EX:on row change, etc...) name="input.other"
         
         #end add-point
 
         AFTER INPUT
            #add-point:單身輸入後處理 name="input.after_input"
            IF p_xmja030 = 'N' THEN
               CALL cl_set_act_visible("insert,delete", TRUE)
               CALL cl_set_comp_entry("xmdf002,xmdf003,xmdf004",TRUE) 
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
      IF INT_FLAG THEN
         LET INT_FLAG = FALSE
         CLOSE adbt500_03_bcl
         #CALL s_transaction_end('N','0')
         #EXIT WHILE
      END IF
      LET l_xmdf002 = 0
      SELECT SUM(xmdf002) INTO l_xmdf002
        FROM xmdf_t WHERE xmdfent = g_enterprise
         AND xmdfdocno = g_xmdfdocno
         AND xmdfseq = g_xmdfseq
      IF cl_null(l_xmdf002) THEN
         LET l_xmdf002 = 0
      END IF 
      
      IF l_xmdf002 <> p_xmja014 THEN
         #是否依交期明細數量回寫銷售數量?
         IF NOT cl_ask_confirm('adb-00388') THEN
            CONTINUE WHILE
         END IF
      END IF  
      LET r_xmdf002 = l_xmdf002      
      EXIT WHILE
   END WHILE 
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_adbt500_03 
   
   #add-point:input段after input name="input.post_input"
   #離開時回傳交貨日期最早的那一分批序的約定交貨日期、預計簽收日期
   LET l_xmdf003 = ''
   LET r_xmdf003 = ''
   LET r_xmdf004 = ''


   SELECT MIN(xmdf003) INTO l_xmdf003 FROM xmdf_t WHERE xmdfent = g_enterprise AND xmdfdocno = g_xmdfdocno AND xmdfseq = g_xmdfseq
   IF NOT cl_null(l_xmdf003) THEN
      #161228-00033#1 Mark By Ken 161229(S)
      #SELECT xmdf003,xmdf004 INTO r_xmdf003,r_xmdf004 FROM xmdf_t
      #   WHERE xmdfent = g_enterprise AND xmdfdocno = g_xmdfdocno AND xmdfseq = g_xmdfseq AND xmdf003 = l_xmdf003 AND rownum = 1
      #161228-00033#1 Mark By Ken 161229(E)
      #161228-00033#1 Add By Ken 161229(S)      
      LET l_sql = "SELECT xmdf003,xmdf004 ",
                  "  FROM xmdf_t ",
                  " WHERE xmdfent = ",g_enterprise,
                  "   AND xmdfdocno = '", g_xmdfdocno ,"'",
                  "   AND xmdfseq = '", g_xmdfseq ,"'",
                  "   AND xmdf003 = '",l_xmdf003,"' "
      PREPARE adbt500_03_xmdf_sel FROM l_sql
      DECLARE adbt500_03_xmdf_sel_cur SCROLL CURSOR FOR adbt500_03_xmdf_sel
      OPEN adbt500_03_xmdf_sel_cur
      FETCH FIRST adbt500_03_xmdf_sel_cur INTO r_xmdf003,r_xmdf004
      FREE adbt500_03_xmdf_sel
      CLOSE adbt500_03_xmdf_sel_cur
      #161228-00033#1 Add By Ken 161229(E)
   END IF
   
   RETURN r_xmdf003,r_xmdf004,r_xmdf002
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="adbt500_03.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="adbt500_03.other_function" readonly="Y" >}

PRIVATE FUNCTION adbt500_03_b_fill()
DEFINE l_sql       STRING
   
       LET l_sql = "SELECT xmdfdocno, xmdfseq,  xmdfseq2, xmdc001,",
                   "       imaal003,  imaal004, xmdc002,  xmdf002,",
                   "       xmdf007,   xmdf003,  xmdf004,  xmdf005,",
                   "       oocql004,  xmdfsite, xmdfunit, ooefl003,",
                   "       xmdf006,   xmdf200,  inayl003, xmdf201,",
                   "       inab003,   xmdf202,  xmdf203",
                   "  FROM xmdf_t",
                   "  LEFT OUTER JOIN oocql_t ON oocqlent = xmdfent",
                   "                         AND oocql001 = '274'",
                   "                         AND oocql002 = xmdf005",
                   "                         AND oocql003 = '",g_dlang,"'",
                   "  LEFT OUTER JOIN ooefl_t ON ooeflent = xmdfent",
                   "                         AND ooefl001 = xmdfunit",
                   "                         AND ooefl002 = '",g_dlang,"'",
                   "  LEFT OUTER JOIN inayl_t ON inaylent = xmdfent",
                   "                         AND inayl001 = xmdf200",
                   "                         AND inayl002 = '",g_dlang,"'",
                   "  LEFT OUTER JOIN inab_t ON inabent = xmdfent",
                   "                        AND inabsite = xmdfunit",
                   "                        AND inab001 = xmdf200",
                   "                        AND inab002 = xmdf201,",
                   "       xmdc_t",
                   "  LEFT OUTER JOIN imaal_t ON imaalent = xmdcent",
                   "                         AND imaal001 = xmdc001",
                   "                         AND imaal002 = '",g_dlang,"'",
                   " WHERE xmdcent = xmdfent",
                   "   AND xmdcdocno = xmdfdocno",
                   "   AND xmdcseq = xmdfseq",
                   "   AND xmdfent = ",g_enterprise,
                   "   AND xmdfdocno = '",g_xmdfdocno,"'",
                   "   AND xmdfseq = ",g_xmdfseq
                   
       PREPARE adbt500_03_pb FROM l_sql
       DECLARE b_fill_curs CURSOR FOR adbt500_03_pb
    
       CALL g_xmdf_d.clear()
       LET l_ac = 1
       FOREACH b_fill_curs
          INTO g_xmdf_d[l_ac].xmdfdocno,     g_xmdf_d[l_ac].xmdfseq,        g_xmdf_d[l_ac].xmdfseq2,
               g_xmdf_d[l_ac].l_xmdc001,     g_xmdf_d[l_ac].l_xmdc001_desc, g_xmdf_d[l_ac].l_xmdc001_desc_desc,
               g_xmdf_d[l_ac].l_xmdc002,     g_xmdf_d[l_ac].xmdf002,        g_xmdf_d[l_ac].xmdf007,
               g_xmdf_d[l_ac].xmdf003,       g_xmdf_d[l_ac].xmdf004,        g_xmdf_d[l_ac].xmdf005,
               g_xmdf_d[l_ac].xmdf005_desc,  g_xmdf_d[l_ac].xmdfsite,       g_xmdf_d[l_ac].xmdfunit,
               g_xmdf_d[l_ac].xmdfunit_desc, g_xmdf_d[l_ac].xmdf006,        g_xmdf_d[l_ac].xmdf200,
               g_xmdf_d[l_ac].xmdf200_desc,  g_xmdf_d[l_ac].xmdf201,        g_xmdf_d[l_ac].xmdf201_desc,
               g_xmdf_d[l_ac].xmdf202,       g_xmdf_d[l_ac].xmdf203
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = "FOREACH:"
             LET g_errparam.popup = TRUE
             CALL cl_err()
             EXIT FOREACH
          END IF
          
          #CALL s_desc_get_acc_desc('274',g_xmdf_d[l_ac].xmdf005) RETURNING g_xmdf_d[l_ac].xmdf005_desc
			 #CALL s_desc_get_department_desc(g_xmdf_d[l_ac].xmdfunit) RETURNING g_xmdf_d[l_ac].xmdfunit_desc
          #CALL s_desc_get_stock_desc(g_xmdf_d[l_ac].xmdfunit,g_xmdf_d[l_ac].xmdf200) RETURNING g_xmdf_d[l_ac].xmdf200_desc
          #CALL s_desc_get_locator_desc(g_xmdf_d[l_ac].xmdfunit,g_xmdf_d[l_ac].xmdf200,g_xmdf_d[l_ac].xmdf201) RETURNING g_xmdf_d[l_ac].xmdf201_desc
          
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
       CALL g_xmdf_d.deleteElement(g_xmdf_d.getLength())
       LET g_rec_b = l_ac - 1
       DISPLAY g_rec_b TO FORMONLY.cnt
       CLOSE b_fill_curs
       FREE adbt500_03_pb
END FUNCTION

PRIVATE FUNCTION adbt500_03_get_xmdf200(p_xmdadocno,p_xmjaseq)
   DEFINE p_xmdadocno     LIKE xmda_t.xmdadocno
   DEFINE p_xmjaseq       LIKE xmja_t.xmjaseq
   DEFINE l_xmda004       LIKE xmda_t.xmda004
   DEFINE l_success       LIKE type_t.num5
   
   SELECT dbag004,dbag005
     INTO g_xmdf_d[l_ac].xmdf200,g_xmdf_d[l_ac].xmdf201
     FROM dbag_t
    WHERE dbagent = g_enterprise
      AND dbagsite = g_xmdf_d[l_ac].xmdfunit
      AND dbag001 = '1'
      AND dbag002 = g_xmda201
      #AND dbag003 = g_xmja025

   
END FUNCTION

PRIVATE FUNCTION adbt500_03_chk_xmdf200(p_xmdadocno,p_xmjaseq,p_type)
   DEFINE p_xmdadocno     LIKE xmda_t.xmdadocno
   DEFINE p_xmjaseq       LIKE xmja_t.xmjaseq
   DEFINE p_type          LIKE type_t.chr1
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_xmda004       LIKE xmda_t.xmda004
   DEFINE l_cnt           LIKE type_t.num5
     
   LET r_success = TRUE     
   
   IF p_type = '1' THEN
      INITIALIZE g_chkparam.* TO NULL
      LET g_chkparam.arg1 = g_xmdf_d[l_ac].xmdfunit
      LET g_chkparam.arg2 = g_xmda201
      LET g_chkparam.arg3 = g_xmdf_d[l_ac].xmdf200
      #160318-00025#3--add--str
      LET g_errshow = TRUE 
      LET g_chkparam.err_str[1] = "adb-00027:sub-01302|adbi251|",cl_get_progname("adbi251",g_lang,"2"),"|:EXEPROGadbi251"
      #160318-00025#3--add--end
      IF NOT cl_chk_exist("v_dbag004_1") THEN
         LET r_success = FALSE
      END IF
   ELSE
      INITIALIZE g_chkparam.* TO NULL
      LET g_chkparam.arg1 = g_xmdf_d[l_ac].xmdfunit
      LET g_chkparam.arg2 = g_xmda201
      LET g_chkparam.arg3 = g_xmdf_d[l_ac].xmdf200
      LET g_chkparam.arg4 = g_xmdf_d[l_ac].xmdf201
      #160318-00025#3--add--str
      LET g_errshow = TRUE 
      LET g_chkparam.err_str[1] = "adb-00027:sub-01302|adbi251|",cl_get_progname("adbi251",g_lang,"2"),"|:EXEPROGadbi251"
      #160318-00025#3--add--end
      IF NOT cl_chk_exist("v_dbag004_2") THEN
         LET r_success = FALSE
      END IF
   END IF
   RETURN r_success
END FUNCTION

PRIVATE FUNCTION adbt500_03_get_xmja003(p_xmdfdocno,p_xmdfseq)
   DEFINE p_xmdfdocno     LIKE xmdf_t.xmdfdocno
   DEFINE p_xmdfseq       LIKE xmdf_t.xmdfseq
   DEFINE r_xmja003       LIKE xmja_t.xmja003 
   DEFINE r_xmja004       LIKE xmja_t.xmja004 
               
    SELECT xmja003,xmja004
      INTO r_xmja003,r_xmja004
      FROM xmja_t
     WHERE xmjaent = g_enterprise
       AND xmjadocno = p_xmdfdocno
       AND xmjaseq = p_xmdfseq
       
   RETURN r_xmja003,r_xmja004    
END FUNCTION

 
{</section>}
 
