#該程式未解開Section, 採用最新樣板產出!
{<section id="aint700_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2015-01-07 15:28:04), PR版次:0002(2016-04-14 16:02:40)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000074
#+ Filename...: aint700_01
#+ Description: 多庫儲批分配作業
#+ Creator....: 01752(2014-12-30 19:57:13)
#+ Modifier...: 01752 -SD/PR- 07900
 
{</section>}
 
{<section id="aint700_01.global" >}
#應用 c02b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#19  16/04/14  BY 07900   校验代码重复错误讯息的修改
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
PRIVATE TYPE type_g_indk_d        RECORD
       indkdocno LIKE indk_t.indkdocno, 
   indkseq LIKE indk_t.indkseq, 
   indksite LIKE indk_t.indksite, 
   indkunit LIKE indk_t.indkunit, 
   indk001 LIKE indk_t.indk001, 
   indk002 LIKE indk_t.indk002, 
   indkseq1 LIKE indk_t.indkseq1, 
   indk003 LIKE indk_t.indk003, 
   indk003_desc LIKE type_t.chr500, 
   indk004 LIKE indk_t.indk004, 
   indk005 LIKE indk_t.indk005, 
   indk005_desc LIKE type_t.chr500, 
   indk006 LIKE indk_t.indk006, 
   indk007 LIKE indk_t.indk007, 
   indk007_desc LIKE type_t.chr500, 
   indk008 LIKE indk_t.indk008, 
   indk008_desc LIKE type_t.chr500, 
   indk009 LIKE indk_t.indk009, 
   indk009_desc LIKE type_t.chr500, 
   indk010 LIKE indk_t.indk010, 
   indk015 LIKE indk_t.indk015, 
   indk011 LIKE indk_t.indk011, 
   indk011_desc LIKE type_t.chr500, 
   indk012 LIKE indk_t.indk012, 
   indk012_desc LIKE type_t.chr500, 
   indk013 LIKE indk_t.indk013, 
   indk013_desc LIKE type_t.chr500, 
   indk014 LIKE indk_t.indk014
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_forupd_sql          STRING
DEFINE g_sql                 STRING
DEFINE g_error_show          LIKE type_t.num5
DEFINE g_cnt                 LIKE type_t.num5
DEFINE g_indk_d_o            type_g_indk_d
DEFINE gs_keys               DYNAMIC ARRAY OF VARCHAR(500) 
DEFINE g_indk006             LIKE indk_t.indk006
 TYPE type_g_inag_d        RECORD
        l_inag004           LIKE inag_t.inag004,
        l_inag004_desc      LIKE inayl_t.inayl003,
        l_inag005           LIKE inag_t.inag005,
        l_inag005_desc      LIKE inab_t.inab003,
        l_inag006           LIKE inag_t.inag006,
        l_inag009           LIKE inag_t.inag009
                                  END RECORD
DEFINE g_inag_d          DYNAMIC ARRAY OF type_g_inag_d   
DEFINE g_rec_b2          LIKE type_t.num5
#end add-point
 
DEFINE g_indk_d          DYNAMIC ARRAY OF type_g_indk_d
DEFINE g_indk_d_t        type_g_indk_d
 
 
DEFINE g_indkdocno_t   LIKE indk_t.indkdocno    #Key值備份
DEFINE g_indkseq_t      LIKE indk_t.indkseq    #Key值備份
DEFINE g_indkseq1_t      LIKE indk_t.indkseq1    #Key值備份
 
 
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
 
{<section id="aint700_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION aint700_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_indjdocno,
   p_indjseq,
   p_indjsite,
   p_indj001,
   p_indj002
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
   DEFINE p_indjdocno     LIKE indj_t.indjdocno
   DEFINE p_indjseq       LIKE indj_t.indjseq
   DEFINE p_indjsite      LIKE indj_t.indjsite
   DEFINE p_indj001       LIKE indj_t.indj001
   DEFINE p_indj002       LIKE indj_t.indj002

   DEFINE r_success       LIKE type_t.num5
   DEFINE r_multi_flag    LIKE type_t.chr1
   DEFINE l_wc            STRING
   
   DEFINE l_indk001       LIKE indk_t.indk001
   DEFINE l_indk002       LIKE indk_t.indk002
   DEFINE l_indk003       LIKE indk_t.indk003
   DEFINE l_indk004       LIKE indk_t.indk004
   DEFINE l_indk005       LIKE indk_t.indk005
   DEFINE l_indk006       LIKE indk_t.indk006
   DEFINE l_indk008       LIKE indk_t.indk008
   DEFINE l_indk011       LIKE indk_t.indk011
   DEFINE l_indk012       LIKE indk_t.indk012
   DEFINE l_indk013       LIKE indk_t.indk013
   DEFINE l_imaal003      LIKE imaal_t.imaal003
   DEFINE l_imaal004      LIKE imaal_t.imaal004
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_lock_sw       LIKE type_t.chr1
   DEFINE l_n             LIKE type_t.num5
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_inaa010       LIKE inaa_t.inaa010
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_aint700_01 WITH FORM cl_ap_formpath("ain","aint700_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單身前置處理 name="input.pre_input"
   WHENEVER ERROR CONTINUE
   SELECT pmdb004,pmdb005,pmdb201,
          pmdb212, pmdb007,pmdb006,pmdb204,
          pmdb037, pmdb038,pmdb039
     INTO l_indk001,l_indk002,l_indk003,
          l_indk004,l_indk005,l_indk006,l_indk008,
          l_indk011,l_indk012,l_indk013
     FROM pmdb_t
    WHERE pmdbent = g_enterprise
      AND pmdbdocno = p_indj001
      AND pmdbseq = p_indj002
   CALL s_desc_get_item_desc(l_indk001)
    RETURNING l_imaal003,l_imaal004
   IF cl_null(l_indk008) THEN
      SELECT ooef124 INTO l_indk008 FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = p_indjsite
   END IF
   LET r_success = TRUE

   LET r_multi_flag = 'N'
   IF NOT s_transaction_chk('Y','0') THEN
      LET r_success = FALSE
      RETURN r_success,r_multi_flag
   END IF
    
   LET g_forupd_sql = "SELECT indkdocno,indkseq,indksite,indkunit,indk001,indk002,indkseq1,indk003,indk004, 
       indk005,indk006,indk007,indk008,indk009,indk010,indk015,indk011,indk012,indk013,indk014 FROM indk_t WHERE  
       indkent=? AND indkdocno=? AND indkseq=? AND indkseq1=? FOR UPDATE"
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aint700_01_bcl CURSOR FROM g_forupd_sql
   
   DISPLAY BY NAME l_indk001,l_indk002,l_indk003,l_indk004,l_indk005,l_indk006,l_imaal003,l_imaal004
   LET g_indk006 = l_indk006
   LET l_wc = "indkdocno = '",p_indjdocno CLIPPED,"' AND indkseq = ",p_indjseq CLIPPED
   LET g_error_show = 1
   CALL aint700_01_b_fill(l_wc)
   CALL aint700_01_inag_b_fill(p_indjsite,l_indk001,l_indk002,l_indk005)
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT ARRAY g_indk_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
         
         #自訂ACTION
         #add-point:單身前置處理 name="input.action"
         BEFORE ROW
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_cmd = ''
            LET l_ac = g_detail_idx
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            DISPLAY g_indk_d.getLength() TO FORMONLY.cnt
         
            #CALL s_transaction_begin()
            LET g_rec_b = g_indk_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_indk_d[l_ac].indkdocno IS NOT NULL
               AND g_indk_d[l_ac].indkseq IS NOT NULL
               AND g_indk_d[l_ac].indkseq1 IS NOT NULL 
            THEN
               LET l_cmd='u'
               LET g_indk_d_t.* = g_indk_d[l_ac].*  #BACKUP
               LET g_indk_d_o.* = g_indk_d[l_ac].*  #BACKUP
               IF NOT aint700_01_lock_b() THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aint700_01_bcl INTO g_indk_d[l_ac].indkdocno,g_indk_d[l_ac].indkseq,g_indk_d[l_ac].indksite, 
                      g_indk_d[l_ac].indkunit,g_indk_d[l_ac].indk001,g_indk_d[l_ac].indk002,g_indk_d[l_ac].indkseq1, 
                      g_indk_d[l_ac].indk003,g_indk_d[l_ac].indk004,g_indk_d[l_ac].indk005,g_indk_d[l_ac].indk006, 
                      g_indk_d[l_ac].indk007,g_indk_d[l_ac].indk008,g_indk_d[l_ac].indk009,g_indk_d[l_ac].indk010,
                      g_indk_d[l_ac].indk015,                      
                      g_indk_d[l_ac].indk011,g_indk_d[l_ac].indk012,g_indk_d[l_ac].indk013,g_indk_d[l_ac].indk014 

                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_indk_d_t.indkdocno 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     LET l_lock_sw = "Y"
                  END IF
                  
                  CALL aint700_01_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL aint700_01_set_entry_b(l_cmd)
            CALL aint700_01_set_no_entry_b(l_cmd)
            
         BEFORE INSERT            
            #CALL s_transaction_begin()
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_indk_d_t.* TO NULL
            INITIALIZE g_indk_d_o.* TO NULL
            INITIALIZE g_indk_d[l_ac].* TO NULL 
            LET g_indk_d[l_ac].indkdocno = p_indjdocno
            LET g_indk_d[l_ac].indkseq = p_indjseq
            LET l_cnt = 0
            SELECT MAX(indkseq1) INTO l_cnt FROM indk_t
             WHERE indkent = g_enterprise
               AND indkdocno = p_indjdocno
               AND indkseq = p_indjseq
            IF cl_null(l_cnt) OR l_cnt = 0 THEN
               LET g_indk_d[l_ac].indkseq1 = 1
            ELSE
               LET g_indk_d[l_ac].indkseq1 = l_cnt + 1
            END IF
            LET g_indk_d[l_ac].indksite = p_indjsite
            LET g_indk_d[l_ac].indkunit = l_indk011
            LET g_indk_d[l_ac].indk001 = l_indk001
            LET g_indk_d[l_ac].indk002 = l_indk002
            LET g_indk_d[l_ac].indk003 = l_indk003
            LET g_indk_d[l_ac].indk005 = l_indk005
            LET g_indk_d[l_ac].indk007 = p_indjsite
            LET g_indk_d[l_ac].indk008 = l_indk008
            LET g_indk_d[l_ac].indk011 = l_indk011
            LET g_indk_d[l_ac].indk012 = l_indk012
            LET g_indk_d[l_ac].indk013 = l_indk013
            
            LET g_errshow = 0
            IF NOT cl_null(g_indk_d[l_ac].indk008) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_indk_d[l_ac].indk007
               LET g_chkparam.arg2 = g_indk_d[l_ac].indk008
               #160318-00025#19  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
               #160318-00025#19  by 07900 --add-end
               IF NOT cl_chk_exist("v_inaa001_18") THEN
                  LET g_indk_d[l_ac].indk008 = ''
               END IF
            END IF
            
            IF cl_null(g_indk_d[l_ac].indk008) THEN
               SELECT ooef124 INTO g_indk_d[l_ac].indk008 FROM ooef_t
                WHERE ooefent = g_enterprise
                  AND ooef001 = g_indk_d[l_ac].indk007
               IF NOT cl_null(g_indk_d[l_ac].indk008) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_indk_d[l_ac].indk007
                  LET g_chkparam.arg2 = g_indk_d[l_ac].indk008
                  #160318-00025#19  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
                  #160318-00025#19  by 07900 --add-end
                  IF NOT cl_chk_exist("v_inaa001_18") THEN
                     LET g_indk_d[l_ac].indk008 = ''
                  END IF
               END IF
            END IF   
            
            IF NOT cl_null(g_indk_d[l_ac].indk012) THEN
               IF g_indk_d[l_ac].indk013 IS NULL THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_indk_d[l_ac].indk011
                  LET g_chkparam.arg2 = g_indk_d[l_ac].indk012
                  #160318-00025#19  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
                  #160318-00025#19  by 07900 --add-end
                  IF NOT cl_chk_exist("v_inaa001_18") THEN
                     LET g_indk_d[l_ac].indk012 = ''
                  END IF
               ELSE
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_indk_d[l_ac].indk011
                  LET g_chkparam.arg2 = g_indk_d[l_ac].indk012
                  LET g_chkparam.arg2 = g_indk_d[l_ac].indk013
                  #160318-00025#19  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
                  #160318-00025#19  by 07900 --add-end 
                  IF NOT cl_chk_exist("v_inab002_4") THEN
                     LET g_indk_d[l_ac].indk012 = ''
                     LET g_indk_d[l_ac].indk013 = ''
                  END IF
               END IF
            END IF
            LET g_errshow = 1
            CALL s_desc_get_unit_desc(g_indk_d[l_ac].indk003)
             RETURNING g_indk_d[l_ac].indk003_desc
           
            CALL s_desc_get_unit_desc(g_indk_d[l_ac].indk005)
             RETURNING g_indk_d[l_ac].indk005_desc
           
            CALL s_desc_get_department_desc(g_indk_d[l_ac].indk007)
             RETURNING g_indk_d[l_ac].indk007_desc
            
            CALL s_desc_get_stock_desc(g_indk_d[l_ac].indk007,g_indk_d[l_ac].indk008)
             RETURNING g_indk_d[l_ac].indk008_desc
           
            CALL s_desc_get_department_desc(g_indk_d[l_ac].indk011)
             RETURNING g_indk_d[l_ac].indk011_desc
           
            CALL s_desc_get_stock_desc(g_indk_d[l_ac].indk011,g_indk_d[l_ac].indk012)
             RETURNING g_indk_d[l_ac].indk012_desc
           
            CALL s_desc_get_locator_desc(g_indk_d[l_ac].indk011,g_indk_d[l_ac].indk012,g_indk_d[l_ac].indk013)
             RETURNING g_indk_d[l_ac].indk013_desc
             
            LET g_indk_d_t.* = g_indk_d[l_ac].*     #新輸入資料
            LET g_indk_d_o.* = g_indk_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aint700_01_set_entry_b("a")
            CALL aint700_01_set_no_entry_b("a")
#            IF lb_reproduce THEN
#               LET lb_reproduce = FALSE
#               LET g_indk_d[li_reproduce_target].* = g_indk_d[li_reproduce].*
#               LET g_indk_d[g_indk_d.getLength()].indkdocno = NULL
#               LET g_indk_d[g_indk_d.getLength()].indkseq = NULL
#               LET g_indk_d[g_indk_d.getLength()].indkseq1 = NULL 
#            END IF
         AFTER INSERT
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err() 
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM indk_t 
             WHERE indkent = g_enterprise AND indkdocno = g_indk_d[l_ac].indkdocno
                                       AND indkseq = g_indk_d[l_ac].indkseq
                                       AND indkseq1 = g_indk_d[l_ac].indkseq1
            IF l_count = 0 THEN     
               INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_indk_d[g_detail_idx].indkdocno
               LET gs_keys[2] = g_indk_d[g_detail_idx].indkseq
               LET gs_keys[3] = g_indk_d[g_detail_idx].indkseq1
               CALL aint700_01_insert_b(gs_keys)
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               INITIALIZE g_indk_d[l_ac].* TO NULL
               #CALL s_transaction_end('N','0')
               LET r_success = FALSE
               EXIT DIALOG
               CANCEL INSERT
            END IF
            
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "indk_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               #CALL s_transaction_end('N','0')  
               LET r_success = FALSE
               EXIT DIALOG               
               CANCEL INSERT
            ELSE
               #CALL s_transaction_end('Y','0')
               LET g_rec_b = g_rec_b + 1
            END IF    
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd = 'd'
            ELSE
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = -263 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  CANCEL DELETE
               END IF
               
               DELETE FROM indk_t
                WHERE indkent = g_enterprise AND 
                      indkdocno = g_indk_d_t.indkdocno
                      AND indkseq = g_indk_d_t.indkseq
                      AND indkseq1 = g_indk_d_t.indkseq1
 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "indk_t" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  #CALL s_transaction_end('N','0')
                  LET r_success = FALSE
                  EXIT DIALOG
                  CANCEL DELETE   
               ELSE
                  LET g_rec_b = g_rec_b-1
                  #CALL s_transaction_end('Y','0')
               END IF 
               CALL aint700_01_unlock_b()
            END IF
         AFTER DELETE 
            IF l_ac = (g_indk_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_indk_d[l_ac].* = g_indk_d_t.*
               CALL aint700_01_unlock_b()
               #CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_indk_d[l_ac].indkdocno 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_indk_d[l_ac].* = g_indk_d_t.*
            ELSE
               #儲位、批號為空時 給一格空白
               IF cl_null(g_indk_d[l_ac].indk009) THEN
                  LET g_indk_d[l_ac].indk009 = ' '
               END IF 
               IF cl_null(g_indk_d[l_ac].indk010) THEN
                  LET g_indk_d[l_ac].indk010 = ' '
               END IF
               IF cl_null(g_indk_d[l_ac].indk013) THEN
                  LET g_indk_d[l_ac].indk013 = ' '
               END IF
               IF cl_null(g_indk_d[l_ac].indk014) THEN
                  LET g_indk_d[l_ac].indk014 = ' '
               END IF
               #庫存管理特徵為空時 給一格空白
               IF cl_null(g_indk_d[l_ac].indk015) THEN
                  LET g_indk_d[l_ac].indk015 = ' '
               END IF
               UPDATE indk_t SET (indkdocno,indkseq,indksite,indkunit,indk001,indk002,indkseq1,indk003, 
                   indk004,indk005,indk006,indk007,indk008,indk009,indk010,indk015,indk011,indk012,indk013,indk014) = (g_indk_d[l_ac].indkdocno, 
                   g_indk_d[l_ac].indkseq,g_indk_d[l_ac].indksite,g_indk_d[l_ac].indkunit,g_indk_d[l_ac].indk001, 
                   g_indk_d[l_ac].indk002,g_indk_d[l_ac].indkseq1,g_indk_d[l_ac].indk003,g_indk_d[l_ac].indk004, 
                   g_indk_d[l_ac].indk005,g_indk_d[l_ac].indk006,g_indk_d[l_ac].indk007,g_indk_d[l_ac].indk008, 
                   g_indk_d[l_ac].indk009,g_indk_d[l_ac].indk010,g_indk_d[l_ac].indk015,g_indk_d[l_ac].indk011,g_indk_d[l_ac].indk012, 
                   g_indk_d[l_ac].indk013,g_indk_d[l_ac].indk014)
                WHERE indkent = g_enterprise AND
                  indkdocno = g_indk_d_t.indkdocno #項次   
                  AND indkseq = g_indk_d_t.indkseq  
                  AND indkseq1 = g_indk_d_t.indkseq1  
 
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "indk_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     #CALL s_transaction_end('N','0')
                     LET r_success = FALSE
                     EXIT DIALOG
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "indk_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()

                     #CALL s_transaction_end('N','0')
                     LET r_success = FALSE
                     EXIT DIALOG
                  OTHERWISE
               END CASE
            END IF
            
         AFTER ROW
            CALL aint700_01_unlock_b()
            #CALL s_transaction_end('Y','0')
            
         #end add-point
         
         #自訂ACTION(detail_input)
         
         
         BEFORE INPUT
            #add-point:單身輸入前處理 name="input.before_input"
 
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indkdocno
            #add-point:BEFORE FIELD indkdocno name="input.b.page1.indkdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indkdocno
            
            #add-point:AFTER FIELD indkdocno name="input.a.page1.indkdocno"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_indk_d[g_detail_idx].indkdocno IS NOT NULL AND g_indk_d[g_detail_idx].indkseq IS NOT NULL AND g_indk_d[g_detail_idx].indkseq1 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_indk_d[g_detail_idx].indkdocno != g_indk_d_t.indkdocno OR g_indk_d[g_detail_idx].indkseq != g_indk_d_t.indkseq OR g_indk_d[g_detail_idx].indkseq1 != g_indk_d_t.indkseq1)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM indk_t WHERE "||"indkent = '" ||g_enterprise|| "' AND "||"indkdocno = '"||g_indk_d[g_detail_idx].indkdocno ||"' AND "|| "indkseq = '"||g_indk_d[g_detail_idx].indkseq ||"' AND "|| "indkseq1 = '"||g_indk_d[g_detail_idx].indkseq1 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indkdocno
            #add-point:ON CHANGE indkdocno name="input.g.page1.indkdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indkseq
            #add-point:BEFORE FIELD indkseq name="input.b.page1.indkseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indkseq
            
            #add-point:AFTER FIELD indkseq name="input.a.page1.indkseq"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_indk_d[g_detail_idx].indkdocno IS NOT NULL AND g_indk_d[g_detail_idx].indkseq IS NOT NULL AND g_indk_d[g_detail_idx].indkseq1 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_indk_d[g_detail_idx].indkdocno != g_indk_d_t.indkdocno OR g_indk_d[g_detail_idx].indkseq != g_indk_d_t.indkseq OR g_indk_d[g_detail_idx].indkseq1 != g_indk_d_t.indkseq1)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM indk_t WHERE "||"indkent = '" ||g_enterprise|| "' AND "||"indkdocno = '"||g_indk_d[g_detail_idx].indkdocno ||"' AND "|| "indkseq = '"||g_indk_d[g_detail_idx].indkseq ||"' AND "|| "indkseq1 = '"||g_indk_d[g_detail_idx].indkseq1 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indkseq
            #add-point:ON CHANGE indkseq name="input.g.page1.indkseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indksite
            #add-point:BEFORE FIELD indksite name="input.b.page1.indksite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indksite
            
            #add-point:AFTER FIELD indksite name="input.a.page1.indksite"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indksite
            #add-point:ON CHANGE indksite name="input.g.page1.indksite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indkunit
            #add-point:BEFORE FIELD indkunit name="input.b.page1.indkunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indkunit
            
            #add-point:AFTER FIELD indkunit name="input.a.page1.indkunit"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indkunit
            #add-point:ON CHANGE indkunit name="input.g.page1.indkunit"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indk001
            #add-point:BEFORE FIELD indk001 name="input.b.page1.indk001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indk001
            
            #add-point:AFTER FIELD indk001 name="input.a.page1.indk001"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indk001
            #add-point:ON CHANGE indk001 name="input.g.page1.indk001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indk002
            #add-point:BEFORE FIELD indk002 name="input.b.page1.indk002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indk002
            
            #add-point:AFTER FIELD indk002 name="input.a.page1.indk002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indk002
            #add-point:ON CHANGE indk002 name="input.g.page1.indk002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indkseq1
            #add-point:BEFORE FIELD indkseq1 name="input.b.page1.indkseq1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indkseq1
            
            #add-point:AFTER FIELD indkseq1 name="input.a.page1.indkseq1"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_indk_d[g_detail_idx].indkdocno IS NOT NULL AND g_indk_d[g_detail_idx].indkseq IS NOT NULL AND g_indk_d[g_detail_idx].indkseq1 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_indk_d[g_detail_idx].indkdocno != g_indk_d_t.indkdocno OR g_indk_d[g_detail_idx].indkseq != g_indk_d_t.indkseq OR g_indk_d[g_detail_idx].indkseq1 != g_indk_d_t.indkseq1)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM indk_t WHERE "||"indkent = '" ||g_enterprise|| "' AND "||"indkdocno = '"||g_indk_d[g_detail_idx].indkdocno ||"' AND "|| "indkseq = '"||g_indk_d[g_detail_idx].indkseq ||"' AND "|| "indkseq1 = '"||g_indk_d[g_detail_idx].indkseq1 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indkseq1
            #add-point:ON CHANGE indkseq1 name="input.g.page1.indkseq1"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indk003
            
            #add-point:AFTER FIELD indk003 name="input.a.page1.indk003"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_indk_d[l_ac].indk003
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_indk_d[l_ac].indk003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_indk_d[l_ac].indk003_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indk003
            #add-point:BEFORE FIELD indk003 name="input.b.page1.indk003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indk003
            #add-point:ON CHANGE indk003 name="input.g.page1.indk003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indk004
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_indk_d[l_ac].indk004,"0","0","","","azz-00079",1) THEN
               NEXT FIELD indk004
            END IF 
 
 
 
            #add-point:AFTER FIELD indk004 name="input.a.page1.indk004"
            IF NOT cl_null(g_indk_d[l_ac].indk004) THEN 
               CALL s_aooi250_take_decimals(g_indk_d[l_ac].indk003,g_indk_d[l_ac].indk004) RETURNING l_success,g_indk_d[l_ac].indk004
               IF NOT cl_ap_chk_range(g_indk_d[l_ac].indk004,"0","0","","","azz-00079",1) THEN
                  LET g_indk_d[l_ac].indk004 = g_indk_d_o.indk004
                  NEXT FIELD indk004
               END IF 

               IF NOT cl_null(g_indk_d[l_ac].indk005) THEN
                  CALL s_aooi250_convert_qty(g_indk_d[l_ac].indk001,g_indk_d[l_ac].indk003,g_indk_d[l_ac].indk005,g_indk_d[l_ac].indk004) 
                   RETURNING l_success,g_indk_d[l_ac].indk006
                  IF NOT cl_null(g_indk_d[l_ac].indk006) THEN
                     IF NOT aint700_01_chk_indk006() THEN
                        LET g_indk_d[l_ac].indk004 = g_indk_d_o.indk004
                        LET g_indk_d[l_ac].indk006 = g_indk_d_o.indk006
                        NEXT FIELD indk004
                     END IF
                  END IF
               END IF               
            END IF 
            LET  g_indk_d_o.indk004 = g_indk_d[l_ac].indk004
            LET  g_indk_d_o.indk006 = g_indk_d[l_ac].indk006
            CALL aint700_01_set_entry_b(l_cmd)
            CALL aint700_01_set_no_entry_b(l_cmd)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indk004
            #add-point:BEFORE FIELD indk004 name="input.b.page1.indk004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indk004
            #add-point:ON CHANGE indk004 name="input.g.page1.indk004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indk005
            
            #add-point:AFTER FIELD indk005 name="input.a.page1.indk005"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_indk_d[l_ac].indk005
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_indk_d[l_ac].indk005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_indk_d[l_ac].indk005_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indk005
            #add-point:BEFORE FIELD indk005 name="input.b.page1.indk005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indk005
            #add-point:ON CHANGE indk005 name="input.g.page1.indk005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indk006
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_indk_d[l_ac].indk006,"0","0","","","azz-00079",1) THEN
               NEXT FIELD indk006
            END IF 
 
 
 
            #add-point:AFTER FIELD indk006 name="input.a.page1.indk006"
            IF NOT cl_null(g_indk_d[l_ac].indk006) THEN 
               CALL s_aooi250_take_decimals(g_indk_d[l_ac].indk005,g_indk_d[l_ac].indk006) RETURNING l_success,g_indk_d[l_ac].indk006
               IF NOT cl_ap_chk_range(g_indk_d[l_ac].indk006,"0","0","","","azz-00079",1) THEN
                  LET g_indk_d[l_ac].indk006 = g_indk_d_o.indk006
                  NEXT FIELD indk006
               END IF 

               IF NOT cl_null(g_indk_d[l_ac].indk006) THEN
                  IF NOT aint700_01_chk_indk006() THEN
                     LET g_indk_d[l_ac].indk006 = g_indk_d_o.indk006
                     LET g_indk_d[l_ac].indk004 = g_indk_d_o.indk004
                     NEXT FIELD indk006
                  END IF
               END IF

               IF NOT cl_null(g_indk_d[l_ac].indk003) THEN
                  CALL s_aooi250_convert_qty(g_indk_d[l_ac].indk001,g_indk_d[l_ac].indk005,g_indk_d[l_ac].indk003,g_indk_d[l_ac].indk006) 
                   RETURNING l_success,g_indk_d[l_ac].indk004
               END IF               
            END IF 
            LET  g_indk_d_o.indk006 = g_indk_d[l_ac].indk006
            LET  g_indk_d_o.indk004 = g_indk_d[l_ac].indk004
            CALL aint700_01_set_entry_b(l_cmd)
            CALL aint700_01_set_no_entry_b(l_cmd)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indk006
            #add-point:BEFORE FIELD indk006 name="input.b.page1.indk006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indk006
            #add-point:ON CHANGE indk006 name="input.g.page1.indk006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indk007
            
            #add-point:AFTER FIELD indk007 name="input.a.page1.indk007"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_indk_d[l_ac].indk007
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_indk_d[l_ac].indk007_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_indk_d[l_ac].indk007_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indk007
            #add-point:BEFORE FIELD indk007 name="input.b.page1.indk007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indk007
            #add-point:ON CHANGE indk007 name="input.g.page1.indk007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indk008
            
            #add-point:AFTER FIELD indk008 name="input.a.page1.indk008"
            LET g_indk_d[l_ac].indk008_desc = ''
            IF NOT cl_null(g_indk_d[l_ac].indk008) THEN
               IF g_indk_d[l_ac].indk008 != g_indk_d_o.indk008 OR g_indk_d_o.indk008 IS NULL THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_indk_d[l_ac].indk007
                  LET g_chkparam.arg2 = g_indk_d[l_ac].indk008
                  #160318-00025#19  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
                  #160318-00025#19  by 07900 --add-end
                  IF NOT cl_chk_exist("v_inaa001_18") THEN
                     LET g_indk_d[l_ac].indk008 = g_indk_d_o.indk008
                     LET g_indk_d[l_ac].indk009 = g_indk_d_o.indk009 #150324-00007#5 2015/04/10 By sakura add
                     LET g_indk_d[l_ac].indk010 = g_indk_d_o.indk010 #150324-00007#5 2015/04/10 By sakura add
                     LET g_indk_d[l_ac].indk015 = g_indk_d_o.indk015 #150324-00007#5 2015/04/10 By sakura add
                     CALL s_desc_get_stock_desc(g_indk_d[l_ac].indk007,g_indk_d[l_ac].indk008) 
                      RETURNING g_indk_d[l_ac].indk008_desc
                     NEXT FIELD CURRENT
                  #150324-00007#5 2015/04/10 By sakura modify ---- S
                  ELSE                     
                     LET g_indk_d_o.indk008 = g_indk_d[l_ac].indk008 
                     LET g_indk_d_o.indk009 = g_indk_d[l_ac].indk009 
                     LET g_indk_d_o.indk010 = g_indk_d[l_ac].indk010 
                     LET g_indk_d_o.indk015 = g_indk_d[l_ac].indk015                     
                     CALL s_desc_get_stock_desc(g_indk_d[l_ac].indk007,g_indk_d[l_ac].indk008) 
                      RETURNING g_indk_d[l_ac].indk008_desc
                     CALL s_desc_get_locator_desc(g_indk_d[l_ac].indk007,g_indk_d[l_ac].indk008,g_indk_d[l_ac].indk009) 
                      RETURNING g_indk_d[l_ac].indk009_desc                      
                  #150324-00007#5 2015/04/10 By sakura modify ---- E
                  END IF

                  #當庫位調整確定的情況下,儲位暫時清空 讓判斷正常進行
                  #LET g_indk_d[l_ac].indk009 = ''      #150324-00007#5 2015/04/10 By sakura mark
                  #LET g_indk_d[l_ac].indk009_desc = '' #150324-00007#5 2015/04/10 By sakura mark
                  IF NOT aint700_01_chk_stock(g_indk_d[l_ac].indk007,g_indk_d[l_ac].indk008,
                                              g_indk_d[l_ac].indk011,g_indk_d[l_ac].indk012) THEN
                     LET g_indk_d[l_ac].indk008 = g_indk_d_o.indk008
                     CALL s_desc_get_stock_desc(g_indk_d[l_ac].indk007,g_indk_d[l_ac].indk008) 
                      RETURNING g_indk_d[l_ac].indk008_desc
                     LET g_indk_d[l_ac].indk009 = g_indk_d_o.indk009
                     CALL s_desc_get_locator_desc(g_indk_d[l_ac].indk007,g_indk_d[l_ac].indk008,g_indk_d[l_ac].indk009) 
                      RETURNING g_indk_d[l_ac].indk009_desc
                     NEXT FIELD CURRENT
                  END IF
                  LET g_indk_d_o.indk008 = g_indk_d[l_ac].indk008 
                  LET g_indk_d_o.indk009 = g_indk_d[l_ac].indk009 
                  CALL s_desc_get_stock_desc(g_indk_d[l_ac].indk007,g_indk_d[l_ac].indk008) 
                   RETURNING g_indk_d[l_ac].indk008_desc
                  NEXT FIELD indk009
               END IF
            ELSE
               LET g_indk_d[l_ac].indk009 = ''
               LET g_indk_d[l_ac].indk009_desc = ''
               LET g_indk_d_o.indk008 = g_indk_d[l_ac].indk008 
               LET g_indk_d_o.indk009 = g_indk_d[l_ac].indk009 
            END IF
            CALL s_desc_get_stock_desc(g_indk_d[l_ac].indk007,g_indk_d[l_ac].indk008) 
             RETURNING g_indk_d[l_ac].indk008_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indk008
            #add-point:BEFORE FIELD indk008 name="input.b.page1.indk008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indk008
            #add-point:ON CHANGE indk008 name="input.g.page1.indk008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indk009
            
            #add-point:AFTER FIELD indk009 name="input.a.page1.indk009"
            #150324-00007#5 2015/04/17 By sakura modify ---- S
            LET g_indk_d[l_ac].indk009_desc = ''
            IF cl_null(g_indk_d[l_ac].indk009) THEN
               LET g_indk_d[l_ac].indk009 = ' '
            ELSE 
               IF g_indk_d[l_ac].indk009 != g_indk_d_o.indk009 OR g_indk_d_o.indk009 IS NULL THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_indk_d[l_ac].indk007
                  LET g_chkparam.arg2 = g_indk_d[l_ac].indk008
                  LET g_chkparam.arg3 = g_indk_d[l_ac].indk009
                  #160318-00025#19  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                 LET g_chkparam.err_str[1] ="aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
                 #160318-00025#19  by 07900 --add-end 
                  IF NOT cl_chk_exist("v_inab002_4") THEN
                     LET g_indk_d[l_ac].indk009 = g_indk_d_o.indk009
                     CALL s_desc_get_locator_desc(g_indk_d[l_ac].indk007,g_indk_d[l_ac].indk008,g_indk_d[l_ac].indk009) 
                      RETURNING g_indk_d[l_ac].indk009_desc
                     IF cl_null(g_indk_d[l_ac].indk009) THEN
                        NEXT FIELD indk008
                     ELSE
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            #150324-00007#5 2015/04/17 By sakura modify ---- E
            LET g_indk_d_o.indk009 = g_indk_d[l_ac].indk009 
            CALL s_desc_get_locator_desc(g_indk_d[l_ac].indk007,g_indk_d[l_ac].indk008,g_indk_d[l_ac].indk009) 
             RETURNING g_indk_d[l_ac].indk009_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indk009
            #add-point:BEFORE FIELD indk009 name="input.b.page1.indk009"
            IF cl_null(g_indk_d[l_ac].indk008) THEN
               NEXT FIELD indk008
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indk009
            #add-point:ON CHANGE indk009 name="input.g.page1.indk009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indk010
            #add-point:BEFORE FIELD indk010 name="input.b.page1.indk010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indk010
            
            #add-point:AFTER FIELD indk010 name="input.a.page1.indk010"
            LET g_indk_d[l_ac].indk014 = g_indk_d[l_ac].indk010
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indk010
            #add-point:ON CHANGE indk010 name="input.g.page1.indk010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indk015
            #add-point:BEFORE FIELD indk015 name="input.b.page1.indk015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indk015
            
            #add-point:AFTER FIELD indk015 name="input.a.page1.indk015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indk015
            #add-point:ON CHANGE indk015 name="input.g.page1.indk015"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indk011
            
            #add-point:AFTER FIELD indk011 name="input.a.page1.indk011"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_indk_d[l_ac].indk011
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_indk_d[l_ac].indk011_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_indk_d[l_ac].indk011_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indk011
            #add-point:BEFORE FIELD indk011 name="input.b.page1.indk011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indk011
            #add-point:ON CHANGE indk011 name="input.g.page1.indk011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indk012
            
            #add-point:AFTER FIELD indk012 name="input.a.page1.indk012"
            LET g_indk_d[l_ac].indk012_desc = ''
            IF NOT cl_null(g_indk_d[l_ac].indk012) THEN
               IF g_indk_d[l_ac].indk012 != g_indk_d_o.indk012 OR g_indk_d_o.indk012 IS NULL THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_indk_d[l_ac].indk011
                  LET g_chkparam.arg2 = g_indk_d[l_ac].indk012
                  #160318-00025#19  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
                  #160318-00025#19  by 07900 --add-end
                  IF NOT cl_chk_exist("v_inaa001_18") THEN
                     LET g_indk_d[l_ac].indk012 = g_indk_d_o.indk012
                     CALL s_desc_get_stock_desc(g_indk_d[l_ac].indk011,g_indk_d[l_ac].indk012) 
                      RETURNING g_indk_d[l_ac].indk012_desc
                     NEXT FIELD CURRENT
                  END IF

                  #當庫位調整確定的情況下,儲位暫時清空 讓判斷正常進行
                  LET g_indk_d[l_ac].indk013 = ''
                  LET g_indk_d[l_ac].indk013_desc = ''
                  IF NOT aint700_01_chk_stock(g_indk_d[l_ac].indk007,g_indk_d[l_ac].indk008,
                                              g_indk_d[l_ac].indk011,g_indk_d[l_ac].indk012) THEN
                     LET g_indk_d[l_ac].indk012 = g_indk_d_o.indk012
                     CALL s_desc_get_stock_desc(g_indk_d[l_ac].indk011,g_indk_d[l_ac].indk012) 
                      RETURNING g_indk_d[l_ac].indk012_desc
                     LET g_indk_d[l_ac].indk013 = g_indk_d_o.indk013
                     CALL s_desc_get_locator_desc(g_indk_d[l_ac].indk011,g_indk_d[l_ac].indk012,g_indk_d[l_ac].indk013) 
                      RETURNING g_indk_d[l_ac].indk013_desc
                     NEXT FIELD CURRENT
                  END IF
                  LET g_indk_d_o.indk012 = g_indk_d[l_ac].indk012 
                  LET g_indk_d_o.indk013 = g_indk_d[l_ac].indk013 
                  CALL s_desc_get_stock_desc(g_indk_d[l_ac].indk011,g_indk_d[l_ac].indk012) 
                   RETURNING g_indk_d[l_ac].indk012_desc
                  #要再讓儲位檢查一次是否為可用儲位
                  NEXT FIELD indk013
               END IF

            ELSE
               LET g_indk_d[l_ac].indk013 = ''
               LET g_indk_d[l_ac].indk013_desc = ''
               LET g_indk_d_o.indk012 = g_indk_d[l_ac].indk012 
               LET g_indk_d_o.indk013 = g_indk_d[l_ac].indk013 
            END IF
            CALL s_desc_get_stock_desc(g_indk_d[l_ac].indk011,g_indk_d[l_ac].indk012) 
             RETURNING g_indk_d[l_ac].indk012_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indk012
            #add-point:BEFORE FIELD indk012 name="input.b.page1.indk012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indk012
            #add-point:ON CHANGE indk012 name="input.g.page1.indk012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indk013
            
            #add-point:AFTER FIELD indk013 name="input.a.page1.indk013"
            LET g_indk_d[l_ac].indk013_desc = ''
            IF cl_null(g_indk_d[l_ac].indk013) THEN
               LET g_indk_d[l_ac].indk013 = ' '
            END IF 
            IF g_indk_d[l_ac].indk013 != g_indk_d_o.indk013 OR g_indk_d_o.indk013 IS NULL THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_indk_d[l_ac].indk011
               LET g_chkparam.arg2 = g_indk_d[l_ac].indk012
               LET g_chkparam.arg3 = g_indk_d[l_ac].indk013
               #160318-00025#19  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
               #160318-00025#19  by 07900 --add-end 
               IF NOT cl_chk_exist("v_inab002_4") THEN
                  LET g_indk_d[l_ac].indk013 = g_indk_d_o.indk013
                  CALL s_desc_get_locator_desc(g_indk_d[l_ac].indk011,g_indk_d[l_ac].indk012,g_indk_d[l_ac].indk013) 
                   RETURNING g_indk_d[l_ac].indk013_desc
                  IF cl_null(g_indk_d[l_ac].indk013) THEN
                     NEXT FIELD indk012
                  ELSE
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_indk_d_o.indk013 = g_indk_d[l_ac].indk013 
            CALL s_desc_get_locator_desc(g_indk_d[l_ac].indk011,g_indk_d[l_ac].indk012,g_indk_d[l_ac].indk013) 
             RETURNING g_indk_d[l_ac].indk013_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indk013
            #add-point:BEFORE FIELD indk013 name="input.b.page1.indk013"
            IF cl_null(g_indk_d[l_ac].indk012) THEN
               NEXT FIELD indk012
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indk013
            #add-point:ON CHANGE indk013 name="input.g.page1.indk013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indk014
            #add-point:BEFORE FIELD indk014 name="input.b.page1.indk014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indk014
            
            #add-point:AFTER FIELD indk014 name="input.a.page1.indk014"
            LET g_indk_d[l_ac].indk010 = g_indk_d[l_ac].indk014
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indk014
            #add-point:ON CHANGE indk014 name="input.g.page1.indk014"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.indkdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indkdocno
            #add-point:ON ACTION controlp INFIELD indkdocno name="input.c.page1.indkdocno"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.indkseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indkseq
            #add-point:ON ACTION controlp INFIELD indkseq name="input.c.page1.indkseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.indksite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indksite
            #add-point:ON ACTION controlp INFIELD indksite name="input.c.page1.indksite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.indkunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indkunit
            #add-point:ON ACTION controlp INFIELD indkunit name="input.c.page1.indkunit"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.indk001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indk001
            #add-point:ON ACTION controlp INFIELD indk001 name="input.c.page1.indk001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.indk002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indk002
            #add-point:ON ACTION controlp INFIELD indk002 name="input.c.page1.indk002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.indkseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indkseq1
            #add-point:ON ACTION controlp INFIELD indkseq1 name="input.c.page1.indkseq1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.indk003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indk003
            #add-point:ON ACTION controlp INFIELD indk003 name="input.c.page1.indk003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.indk004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indk004
            #add-point:ON ACTION controlp INFIELD indk004 name="input.c.page1.indk004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.indk005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indk005
            #add-point:ON ACTION controlp INFIELD indk005 name="input.c.page1.indk005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.indk006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indk006
            #add-point:ON ACTION controlp INFIELD indk006 name="input.c.page1.indk006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.indk007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indk007
            #add-point:ON ACTION controlp INFIELD indk007 name="input.c.page1.indk007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.indk008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indk008
            #add-point:ON ACTION controlp INFIELD indk008 name="input.c.page1.indk008"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            #150324-00007#5 2015/04/10 By sakura modify ---- S            
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_indk_d[l_ac].indk008   #給予default值
            LET g_qryparam.default2 = g_indk_d[l_ac].indk009
            LET g_qryparam.default3 = g_indk_d[l_ac].indk010
            LET g_qryparam.default4 = g_indk_d[l_ac].indk015
            LET g_qryparam.arg1 = g_indk_d[l_ac].indk007   #發貨組織
            LET g_qryparam.arg2 = g_indk_d[l_ac].indk001   #商品編號
            #產品特徵
            IF cl_null(g_indk_d[l_ac].indk002) THEN
               LET g_indk_d[l_ac].indk002 = ' '
            END IF
            LET g_qryparam.arg3 = g_indk_d[l_ac].indk002
            #庫存管理特徵
            IF cl_null(g_indk_d[l_ac].indk015) THEN
               LET g_qryparam.arg4 = ''
            ELSE
               LET g_qryparam.arg4 = g_indk_d[l_ac].indk015
            END IF
            #發貨庫位
            LET g_qryparam.arg5 = ''                        
			   #發貨儲位
            IF cl_null(g_indk_d[l_ac].indk009) THEN
               LET g_qryparam.arg6 = ''
            ELSE
               LET g_qryparam.arg6 = g_indk_d[l_ac].indk009
            END IF
            #發貨批號
            IF cl_null(g_indk_d[l_ac].indk010) THEN
               LET g_qryparam.arg7 = ''
            ELSE
               LET g_qryparam.arg7 = g_indk_d[l_ac].indk010
            END IF
            
            #給予arg
            #LET g_qryparam.arg1 = g_indk_d[l_ac].indk007
            IF NOT cl_null( g_indk_d[l_ac].indk012) THEN
               LET l_inaa010 = ''
               SELECT inaa010 INTO l_inaa010 FROM inaa_t
                WHERE inaaent = g_enterprise
                  AND inaasite = g_indk_d[l_ac].indk011
                  AND inaa001 = g_indk_d[l_ac].indk012
               LET g_qryparam.where = "inaa010 = '",l_inaa010 CLIPPED,"'"
            END IF
            #CALL q_inaa001_23()                                #呼叫開窗
            CALL q_inag004_18()            
            LET g_indk_d[l_ac].indk008 = g_qryparam.return1   #發貨庫位
            LET g_indk_d[l_ac].indk009 = g_qryparam.return2   #發貨儲位
            LET g_indk_d[l_ac].indk010 = g_qryparam.return3   #發貨批號
            LET g_indk_d[l_ac].indk015 = g_qryparam.return4   #庫存管理特徵            
            DISPLAY g_indk_d[l_ac].indk008 TO indk008
            DISPLAY g_indk_d[l_ac].indk009 TO indk009
            DISPLAY g_indk_d[l_ac].indk010 TO indk010
            DISPLAY g_indk_d[l_ac].indk015 TO indk015
            #發貨庫位            
            CALL s_desc_get_stock_desc(g_indk_d[l_ac].indk007,g_indk_d[l_ac].indk008)
             RETURNING g_indk_d[l_ac].indk008_desc
            #發貨儲位
            CALL s_desc_get_locator_desc(g_indk_d[l_ac].indk007,g_indk_d[l_ac].indk008,g_indk_d[l_ac].indk009)
             RETURNING g_indk_d[l_ac].indk009_desc            
            NEXT FIELD indk008                          #返回原欄位
            #150324-00007#5 2015/04/10 By sakura modify ---- E            
            #END add-point
 
 
         #Ctrlp:input.c.page1.indk009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indk009
            #add-point:ON ACTION controlp INFIELD indk009 name="input.c.page1.indk009"
            #150324-00007#5 2015/04/10 By sakura modify ---- S            
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.default1 = g_indk_d[l_ac].indk009             #給予default值
            #LET g_qryparam.arg1 = g_indk_d[l_ac].indk007
            #LET g_qryparam.arg2 = g_indk_d[l_ac].indk008
            #LET g_qryparam.where = "inab006 = 'Y'"
            #CALL q_inab002_6()                                #呼叫開窗
            #LET g_indk_d[l_ac].indk009 = g_qryparam.return1              
            #DISPLAY g_indk_d[l_ac].indk009 TO indk009          
            LET g_qryparam.default1 = g_indk_d[l_ac].indk008
            LET g_qryparam.default2 = g_indk_d[l_ac].indk009
            LET g_qryparam.default3 = g_indk_d[l_ac].indk010
            LET g_qryparam.default4 = g_indk_d[l_ac].indk015
            LET g_qryparam.arg1 = g_indk_d[l_ac].indk007   #發貨組織
            LET g_qryparam.arg2 = g_indk_d[l_ac].indk001   #商品編號
            #產品特徵
            IF cl_null(g_indk_d[l_ac].indk002) THEN
               LET g_indk_d[l_ac].indk002 = ' '
            END IF
            LET g_qryparam.arg3 = g_indk_d[l_ac].indk002
            #庫存管理特徵
            IF cl_null(g_indk_d[l_ac].indk015) THEN
               LET g_qryparam.arg4 = ''
            ELSE
               LET g_qryparam.arg4 = g_indk_d[l_ac].indk015
            END IF
            #發貨庫位
            LET g_qryparam.arg5 = g_indk_d[l_ac].indk008
			   #發貨儲位
            LET g_qryparam.arg6 = ''
            #發貨批號
            IF cl_null(g_indk_d[l_ac].indk010) THEN
               LET g_qryparam.arg7 = ''
            ELSE
               LET g_qryparam.arg7 = g_indk_d[l_ac].indk010
            END IF
            CALL q_inag004_18()
            LET g_indk_d[l_ac].indk008 = g_qryparam.return1   #發貨庫位
            LET g_indk_d[l_ac].indk009 = g_qryparam.return2   #發貨儲位
            LET g_indk_d[l_ac].indk010 = g_qryparam.return3   #發貨批號
            LET g_indk_d[l_ac].indk015 = g_qryparam.return4   #庫存管理特徵
            DISPLAY g_indk_d[l_ac].indk008 TO indk008
            DISPLAY g_indk_d[l_ac].indk009 TO indk009
            DISPLAY g_indk_d[l_ac].indk010 TO indk010
            DISPLAY g_indk_d[l_ac].indk015 TO indk015            
            #發貨庫位           
            CALL s_desc_get_stock_desc(g_indk_d[l_ac].indk007,g_indk_d[l_ac].indk008) 
             RETURNING g_indk_d[l_ac].indk008_desc            
            #發貨儲位
            CALL s_desc_get_locator_desc(g_indk_d[l_ac].indk007,g_indk_d[l_ac].indk008,g_indk_d[l_ac].indk009) 
             RETURNING g_indk_d[l_ac].indk009_desc
            NEXT FIELD indk009                                #返回原欄位
            #150324-00007#5 2015/04/10 By sakura modify ---- E            
            #END add-point
 
 
         #Ctrlp:input.c.page1.indk010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indk010
            #add-point:ON ACTION controlp INFIELD indk010 name="input.c.page1.indk010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.indk015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indk015
            #add-point:ON ACTION controlp INFIELD indk015 name="input.c.page1.indk015"
            #開窗i段
            #150324-00007#5 2015/04/10 By sakura mark ---- S
            #INITIALIZE g_qryparam.* TO NULL
            #LET g_qryparam.state = 'i'
            #LET g_qryparam.reqry = FALSE
            #LET g_qryparam.default1 = g_indk_d[l_ac].indk015
            #LET g_qryparam.arg1 = g_indk_d[l_ac].indk007
            #LET g_qryparam.arg2 = g_indk_d[l_ac].indk001
            #LET g_qryparam.arg3 = g_indk_d[l_ac].indk002
            #LET g_qryparam.arg4 = g_indk_d[l_ac].indk008
            #LET g_qryparam.arg5 = g_indk_d[l_ac].indk009
            #LET g_qryparam.arg6 = g_indk_d[l_ac].indk010
            #
            #CALL q_inag003_4()                                #呼叫開窗
            #LET g_indk_d[l_ac].indk015 = g_qryparam.return1
            #DISPLAY BY NAME g_indk_d[l_ac].indk015
            #NEXT FIELD indk015                                #返回原欄位
            #150324-00007#5 2015/04/10 By sakura mark ---- S
            #END add-point
 
 
         #Ctrlp:input.c.page1.indk011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indk011
            #add-point:ON ACTION controlp INFIELD indk011 name="input.c.page1.indk011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.indk012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indk012
            #add-point:ON ACTION controlp INFIELD indk012 name="input.c.page1.indk012"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_indk_d[l_ac].indk012   #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_indk_d[l_ac].indk011
            IF NOT cl_null( g_indk_d[l_ac].indk008) THEN
               LET l_inaa010 = ''
               SELECT inaa010 INTO l_inaa010 FROM inaa_t
                WHERE inaaent = g_enterprise
                  AND inaasite = g_indk_d[l_ac].indk007
                  AND inaa001 = g_indk_d[l_ac].indk008
               LET g_qryparam.where = "inaa010 = '",l_inaa010 CLIPPED,"'"
            END IF
            CALL q_inaa001_23()                                #呼叫開窗
            LET g_indk_d[l_ac].indk012 = g_qryparam.return1     
            DISPLAY g_indk_d[l_ac].indk012 TO indk012
            CALL s_desc_get_stock_desc(g_indk_d[l_ac].indk011,g_indk_d[l_ac].indk012)
             RETURNING g_indk_d[l_ac].indk012_desc
            NEXT FIELD indk012                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.indk013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indk013
            #add-point:ON ACTION controlp INFIELD indk013 name="input.c.page1.indk013"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_indk_d[l_ac].indk013             #給予default值
            LET g_qryparam.arg1 = g_indk_d[l_ac].indk011
            LET g_qryparam.arg2 = g_indk_d[l_ac].indk012
            LET g_qryparam.where = "inab006 = 'Y'"
            CALL q_inab002_6()                                #呼叫開窗
            LET g_indk_d[l_ac].indk013 = g_qryparam.return1              
            DISPLAY g_indk_d[l_ac].indk013 TO indk013          
            CALL s_desc_get_locator_desc(g_indk_d[l_ac].indk011,g_indk_d[l_ac].indk012,g_indk_d[l_ac].indk013) 
             RETURNING g_indk_d[l_ac].indk013_desc
            NEXT FIELD indk013                                #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.indk014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indk014
            #add-point:ON ACTION controlp INFIELD indk014 name="input.c.page1.indk014"
            
            #END add-point
 
 
 
 
         #自訂ACTION
         #add-point:單身其他段落處理(EX:on row change, etc...) name="input.other"
         
         #end add-point
 
         AFTER INPUT
            #add-point:單身輸入後處理 name="input.after_input"
            
            #end add-point
            
      END INPUT
      
 
      
      #add-point:自定義input name="input.more_input"
      DISPLAY ARRAY g_inag_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b2)
         BEFORE DISPLAY 
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
   CALL aint700_01_unlock_b()
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_aint700_01 
   
   #add-point:input段after input name="input.post_input"
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt 
    FROM indk_t 
    WHERE indkent = g_enterprise
      AND indkdocno = p_indjdocno
      AND indkseq = p_indjseq
   CASE 
      #多庫儲批
      WHEN l_cnt > 1 
         LET r_multi_flag = 'Y'
      #只有一筆
      WHEN l_cnt = 1 
         LET r_multi_flag = 'N'
      #沒有輸入資料
      OTHERWISE
         LET r_multi_flag = 'X'
   END CASE
   
   RETURN r_success,r_multi_flag 
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aint700_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aint700_01.other_function" readonly="Y" >}

PRIVATE FUNCTION aint700_01_b_fill(p_wc2)
DEFINE p_wc2     STRING
   
   IF cl_null(p_wc2) THEN
      LET p_wc2 = " 1=1"
   END IF
   
   LET g_sql = "SELECT  UNIQUE t0.indkdocno,t0.indkseq,t0.indksite,t0.indkunit,t0.indk001,t0.indk002, 
       t0.indkseq1,t0.indk003,t0.indk004,t0.indk005,t0.indk006,t0.indk007,t0.indk008,t0.indk009,t0.indk010,t0.indk015, 
       t0.indk011,t0.indk012,t0.indk013,t0.indk014 ,t1.oocal003 ,t2.oocal003 ,t3.ooefl003 ,t4.inayl003 , 
       t5.inab003 ,t6.ooefl003 ,t7.inayl003 ,t8.inab003 FROM indk_t t0",
               " LEFT JOIN oocal_t t1 ON t1.oocalent='"||g_enterprise||"' AND t1.oocal001=t0.indk003 AND t1.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t2 ON t2.oocalent='"||g_enterprise||"' AND t2.oocal001=t0.indk005 AND t2.oocal002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent='"||g_enterprise||"' AND t3.ooefl001=t0.indk007 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t4 ON t4.inaylent='"||g_enterprise||"' AND t4.inayl001=t0.indk008 AND t4.inayl002='"||g_dlang||"' ",
               " LEFT JOIN inab_t t5 ON t5.inabent='"||g_enterprise||"' AND t5.inabsite = t0.indk007 AND t5.inab001=t0.indk008 AND t5.inab002=t0.indk009  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent='"||g_enterprise||"' AND t6.ooefl001=t0.indk011 AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t7 ON t7.inaylent='"||g_enterprise||"' AND t7.inayl001=t0.indk012 AND t7.inayl002='"||g_dlang||"' ",
               " LEFT JOIN inab_t t8 ON t8.inabent='"||g_enterprise||"' AND t8.inabsite = t0.indk011 AND t8.inab001=t0.indk012 AND t8.inab002=t0.indk013  ",
 
               " WHERE t0.indkent= ?  AND  1=1 AND (", p_wc2, ") " 
   LET g_sql = g_sql, cl_sql_add_filter("indk_t"),
                      " ORDER BY t0.indkdocno,t0.indkseq,t0.indkseq1"
                      
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aint700_01_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aint700_01_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_indk_d.clear()
  
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_indk_d[l_ac].indkdocno,g_indk_d[l_ac].indkseq,g_indk_d[l_ac].indksite, 
       g_indk_d[l_ac].indkunit,g_indk_d[l_ac].indk001,g_indk_d[l_ac].indk002,g_indk_d[l_ac].indkseq1, 
       g_indk_d[l_ac].indk003,g_indk_d[l_ac].indk004,g_indk_d[l_ac].indk005,g_indk_d[l_ac].indk006,g_indk_d[l_ac].indk007, 
       g_indk_d[l_ac].indk008,g_indk_d[l_ac].indk009,g_indk_d[l_ac].indk010,g_indk_d[l_ac].indk015,g_indk_d[l_ac].indk011,g_indk_d[l_ac].indk012, 
       g_indk_d[l_ac].indk013,g_indk_d[l_ac].indk014,g_indk_d[l_ac].indk003_desc,g_indk_d[l_ac].indk005_desc, 
       g_indk_d[l_ac].indk007_desc,g_indk_d[l_ac].indk008_desc,g_indk_d[l_ac].indk009_desc,g_indk_d[l_ac].indk011_desc, 
       g_indk_d[l_ac].indk012_desc,g_indk_d[l_ac].indk013_desc
       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
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
   
   
   CALL g_indk_d.deleteElement(g_indk_d.getLength())   
 
     
   IF g_cnt > g_indk_d.getLength() THEN
      LET l_ac = g_indk_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
   
   ERROR "" 
 
   LET g_rec_b = g_indk_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_rec_b TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE aint700_01_pb
END FUNCTION

PRIVATE FUNCTION aint700_01_lock_b()
DEFINE r_success     LIKE type_t.num5

   LET r_success = TRUE
   
   OPEN aint700_01_bcl USING g_enterprise,g_indk_d[g_detail_idx].indkdocno,
                                          g_indk_d[g_detail_idx].indkseq,g_indk_d[g_detail_idx].indkseq1
                                    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "aint700_01_bcl" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

PRIVATE FUNCTION aint700_01_detail_show()
   CALL s_desc_get_unit_desc(g_indk_d[l_ac].indk003)
    RETURNING g_indk_d[l_ac].indk003_desc

   CALL s_desc_get_unit_desc(g_indk_d[l_ac].indk005)
    RETURNING g_indk_d[l_ac].indk005_desc

   CALL s_desc_get_department_desc(g_indk_d[l_ac].indk007)
    RETURNING g_indk_d[l_ac].indk007_desc
   
   CALL s_desc_get_stock_desc(g_indk_d[l_ac].indk007,g_indk_d[l_ac].indk008)
    RETURNING g_indk_d[l_ac].indk008_desc

   CALL s_desc_get_locator_desc(g_indk_d[l_ac].indk007,g_indk_d[l_ac].indk008,g_indk_d[l_ac].indk009)
    RETURNING g_indk_d[l_ac].indk009_desc

   CALL s_desc_get_department_desc(g_indk_d[l_ac].indk011)
    RETURNING g_indk_d[l_ac].indk011_desc

   CALL s_desc_get_stock_desc(g_indk_d[l_ac].indk011,g_indk_d[l_ac].indk012)
    RETURNING g_indk_d[l_ac].indk012_desc

   CALL s_desc_get_locator_desc(g_indk_d[l_ac].indk011,g_indk_d[l_ac].indk012,g_indk_d[l_ac].indk013)
    RETURNING g_indk_d[l_ac].indk013_desc

END FUNCTION

PRIVATE FUNCTION aint700_01_set_entry_b(p_cmd)
DEFINE p_cmd    LIKE type_t.chr1
   CALL cl_set_comp_entry("indk004",TRUE)
   CALL cl_set_comp_entry("indk010,indk014",TRUE)   #150427-00001#8 1500601 by lori522612 add
END FUNCTION

PRIVATE FUNCTION aint700_01_set_no_entry_b(p_cmd)
   DEFINE p_cmd    LIKE type_t.chr1
   #150427-00001#8 150601 by lori522612 add---(S)
   DEFINE l_success         LIKE type_t.num5      
   DEFINE l_set_entry       LIKE type_t.num5    
   DEFINE l_type            LIKE type_t.num5    
   #150427-00001#8 150514 by lori522612 add---(E)
   
   IF NOT cl_null(g_indk_d[l_ac].indk006) THEN
      CALL cl_set_comp_entry("indk004",FALSE)
   END IF
   
   #150427-00001#8 150601 by lori522612 add---(S)
   #發貨批號
   LET l_success = ''  
   LET l_set_entry = ''
   LET l_type = -1
   CALL s_lot_out_entry(l_type,g_indk_d[l_ac].indkdocno,g_indk_d[l_ac].indksite,g_indk_d[l_ac].indk001)  
      RETURNING l_success,l_set_entry
   IF l_success THEN
      CALL cl_set_comp_entry("indk010",l_set_entry) 
   END IF      
   #收貨批號
   LET l_success = ''  
   LET l_set_entry = ''
   LET l_type = 1
   CALL s_lot_out_entry(l_type,g_indk_d[l_ac].indkdocno,g_indk_d[l_ac].indksite,g_indk_d[l_ac].indk001)  
      RETURNING l_success,l_set_entry
   IF l_success THEN
      CALL cl_set_comp_entry("indk014",l_set_entry) 
   END IF      
   #150427-00001#8 1500601 by lori522612 add---(E)   
END FUNCTION

PRIVATE FUNCTION aint700_01_unlock_b()
   CLOSE aint700_01_bcl
END FUNCTION

PRIVATE FUNCTION aint700_01_insert_b(ps_keys)
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)

   #特徵碼為空時 給一格空白
   IF cl_null(g_indk_d[l_ac].indk002) THEN
      LET g_indk_d[l_ac].indk002 = ' '
   END IF
   
   #儲位、批號為空時 給一格空白
   IF cl_null(g_indk_d[l_ac].indk009) THEN
      LET g_indk_d[l_ac].indk009 = ' '
   END IF 
   IF cl_null(g_indk_d[l_ac].indk010) THEN
      LET g_indk_d[l_ac].indk010 = ' '
   END IF
   IF cl_null(g_indk_d[l_ac].indk013) THEN
      LET g_indk_d[l_ac].indk013 = ' '
   END IF
   IF cl_null(g_indk_d[l_ac].indk014) THEN
      LET g_indk_d[l_ac].indk014 = ' '
   END IF
   #庫存管理特徵為空時 給一格空白
   IF cl_null(g_indk_d[l_ac].indk015) THEN
      LET g_indk_d[l_ac].indk015 = ' '
   END IF 
   INSERT INTO indk_t
               (indkent,
                indkdocno,indkseq,indkseq1
                ,indksite,indkunit,indk001,indk002,indk003,indk004,indk005,indk006,indk007,indk008,indk009,indk010,indk015,indk011,indk012,indk013,indk014) 
         VALUES(g_enterprise,
                ps_keys[1],ps_keys[2],ps_keys[3]
                ,g_indk_d[l_ac].indksite,g_indk_d[l_ac].indkunit,g_indk_d[l_ac].indk001,g_indk_d[l_ac].indk002, 
                    g_indk_d[l_ac].indk003,g_indk_d[l_ac].indk004,g_indk_d[l_ac].indk005,g_indk_d[l_ac].indk006, 
                    g_indk_d[l_ac].indk007,g_indk_d[l_ac].indk008,g_indk_d[l_ac].indk009,g_indk_d[l_ac].indk010,g_indk_d[l_ac].indk015, 
                    g_indk_d[l_ac].indk011,g_indk_d[l_ac].indk012,g_indk_d[l_ac].indk013,g_indk_d[l_ac].indk014) 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "indk_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   
   END IF      
      
END FUNCTION

PRIVATE FUNCTION aint700_01_chk_indk006()
DEFINE l_indk006     LIKE indk_t.indk006
DEFINE r_success     LIKE type_t.num5
   
   LET r_success = TRUE
   LET l_indk006 = 0 
   SELECT SUM(COALESCE(indk006,0)) INTO l_indk006 FROM indk_t
    WHERE indkent = g_enterprise
      AND indkdocno = g_indk_d[l_ac].indkdocno
      AND indkseq = g_indk_d[l_ac].indkseq
      AND indkseq1 != g_indk_d[l_ac].indkseq1
   IF cl_null(l_indk006) THEN 
      LET l_indk006 = 0 
   END IF
   
   LET l_indk006 = l_indk006 + g_indk_d[l_ac].indk006
   
   IF l_indk006 > g_indk006 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ain-00354'
      LET g_errparam.extend = l_indk006
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION
#檢查 發貨和收貨的庫位 是否為成本對成本 非成本對非成本
PUBLIC FUNCTION aint700_01_chk_stock(p_site1,p_stock1,p_site2,p_stock2)
DEFINE p_site1       LIKE indk_t.indk007
DEFINE p_stock1      LIKE indk_t.indk008
DEFINE p_site2       LIKE indk_t.indk011
DEFINE p_stock2      LIKE indk_t.indk012
DEFINE r_success     LIKE type_t.num5
DEFINE l_inaa010_1   LIKE type_t.chr1
DEFINE l_inaa010_2   LIKE type_t.chr1

   LET r_success = TRUE
   
   #無法比對 不算錯
   IF cl_null(p_site1) OR cl_null(p_stock1) OR
      cl_null(p_site2) OR cl_null(p_stock2) THEN      
      RETURN r_success 
   END IF
   
   LET l_inaa010_1 = ''
   SELECT inaa010 INTO l_inaa010_1 FROM inaa_t
    WHERE inaaent = g_enterprise
      AND inaasite = p_site1
      AND inaa001 = p_stock1
   
   LET l_inaa010_2 = ''
   SELECT inaa010 INTO l_inaa010_2 FROM inaa_t
    WHERE inaaent = g_enterprise
      AND inaasite = p_site2
      AND inaa001 = p_stock2
   
   IF l_inaa010_1 != l_inaa010_2 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ain-00381'
      LET g_errparam.columns[1] = 'lbl_indk008'
      LET g_errparam.values[1] = p_stock1
      LET g_errparam.columns[2] = 'lbl_inaa010'
      LET g_errparam.values[2] = l_inaa010_1
      LET g_errparam.columns[3] = 'lbl_inaa012'
      LET g_errparam.values[3] = p_stock2
      LET g_errparam.columns[4] = 'lbl_inaa010'
      LET g_errparam.values[4] = l_inaa010_2
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success 

END FUNCTION

PUBLIC FUNCTION aint700_01_inag_b_fill(p_inagsite,p_inag001,p_inag002,p_inag007)
DEFINE l_sql             STRING
DEFINE p_inagsite        LIKE inag_t.inagsite
DEFINE p_inag001         LIKE inag_t.inag001
DEFINE p_inag002         LIKE inag_t.inag002
DEFINE p_inag007         LIKE inag_t.inag007
DEFINE l_cnt             LIKE type_t.num5

   CALL g_inag_d.clear()
   
   LET l_sql = "SELECT inag004,t1.inayl003,inag005,t2.inab003,inag006,SUM(inag009) ",
               " FROM inag_t ",
               " LEFT OUTER JOIN inayl_t t1 ON t1.inaylent="||g_enterprise||" AND t1.inayl001=inag004 AND t1.inayl002='"||g_dlang||"' ",
               " LEFT OUTER JOIN inab_t t2 ON t2.inabent="||g_enterprise||" AND t2.inabsite = inagsite AND t2.inab001=inag005 AND t2.inab002=inag006  ",
               " WHERE inagent = ",g_enterprise,
               "   AND inagsite = '",p_inagsite CLIPPED,"'",
               "   AND inag001 = '",p_inag001,"'",
               "   AND inag002 = '",p_inag002,"'",
               "   AND inag007 = '",p_inag007,"'",
               "   AND inag010 = 'Y'",
               " GROUP BY inag004,t1.inayl003,inag005,t2.inab003,inag006 "
   PREPARE aint700_01_inag_pre FROM l_sql
   DECLARE aint700_01_inag_curs CURSOR FOR aint700_01_inag_pre 
   
   LET l_cnt = 1
   FOREACH aint700_01_inag_curs INTO g_inag_d[l_cnt].*
   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      IF l_cnt > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code   = 9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF
 
      LET l_cnt = l_cnt + 1
   END FOREACH
   
   LET g_error_show = 0   
   
   CALL g_inag_d.deleteElement(g_inag_d.getLength())   
   LET g_rec_b2 = g_inag_d.getLength()
END FUNCTION

 
{</section>}
 
