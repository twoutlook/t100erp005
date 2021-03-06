#該程式未解開Section, 採用最新樣板產出!
{<section id="apmt520_04.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2014-07-31 10:45:55), PR版次:0004(2016-12-20 23:57:51)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000028
#+ Filename...: apmt520_04
#+ Description: 委外拆件收貨料件明細
#+ Creator....: 02294(2014-07-31 09:34:01)
#+ Modifier...: 02294 -SD/PR- 05423
 
{</section>}
 
{<section id="apmt520_04.global" >}
#應用 c02b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#40  2016/04/25  By pengxin  將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#130909-00003#58  2016/04/29  By lixiang  增加委外收貨單拆件元件逻辑
#160512-00016#24  2016/05/27  By lixiang  因為s_asft300_02_bom增加參數，所以call s_asft300_02_bom的地方多傳保稅否欄位 pmdt041
#160816-00064#1   2016/08/16  By lixiang     展BOM时，无需判断返回的bom数组大于1（g_bmba.getLength() > 1）；
#161124-00048#11  2016/12/19  By zhujing   .*整批调整
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
PRIVATE TYPE type_g_pmdt_d        RECORD
       pmdtdocno LIKE pmdt_t.pmdtdocno, 
   pmdtseq LIKE pmdt_t.pmdtseq, 
   pmdt006 LIKE pmdt_t.pmdt006, 
   pmdt006_desc LIKE type_t.chr500, 
   imaal004 LIKE type_t.chr500, 
   pmdt019 LIKE pmdt_t.pmdt019, 
   pmdt019_desc LIKE type_t.chr500, 
   pmdt020 LIKE pmdt_t.pmdt020, 
   pmdt021 LIKE pmdt_t.pmdt021, 
   pmdt021_desc LIKE type_t.chr500, 
   pmdt022 LIKE pmdt_t.pmdt022
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_success       LIKE type_t.num5
DEFINE g_count         LIKE type_t.num10  #記錄插入數據庫的筆數
DEFINE g_choice        LIKE type_t.chr1
DEFINE g_error_show    LIKE type_t.num5              #
DEFINE g_cnt           LIKE type_t.num10
DEFINE g_sql           STRING
DEFINE g_pmdt001       LIKE pmdt_t.pmdt001
DEFINE g_pmdt002       LIKE pmdt_t.pmdt002
DEFINE g_pmdt006       LIKE pmdt_t.pmdt006
DEFINE g_pmdt020       LIKE pmdt_t.pmdt020
DEFINE g_pmdt_d_o      type_g_pmdt_d
DEFINE g_pmdtdocno     LIKE pmdt_t.pmdtdocno
DEFINE g_pmdtseq       LIKE pmdt_t.pmdtseq
DEFINE g_forupd_sql    STRING
DEFINE g_bmba                 DYNAMIC ARRAY OF RECORD #回传数组
       bmba001                LIKE bmba_t.bmba001,    #bom相关资料都可以通过回传的key值抓取
       bmba002                LIKE bmba_t.bmba002,
       bmba003                LIKE bmba_t.bmba003,
       bmba004                LIKE bmba_t.bmba004,
       bmba005                DATETIME YEAR TO SECOND,
       bmba007                LIKE bmba_t.bmba007,
       bmba008                LIKE bmba_t.bmba008,
       bmba035                LIKE bmba_t.bmba035,         #保稅否  #160512-00016#24
       l_bmba011              LIKE bmba_t.bmba011,     #QPA 分子，对应于原始的主件料号
       l_bmba012              LIKE bmba_t.bmba012,     #QPA 分母，对应于原始的主件料号
       l_inam002              LIKE inam_t.inam002      #元件对应特征
                              END RECORD
#end add-point
 
DEFINE g_pmdt_d          DYNAMIC ARRAY OF type_g_pmdt_d
DEFINE g_pmdt_d_t        type_g_pmdt_d
 
 
DEFINE g_pmdtdocno_t   LIKE pmdt_t.pmdtdocno    #Key值備份
DEFINE g_pmdtseq_t      LIKE pmdt_t.pmdtseq    #Key值備份
 
 
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
 
{<section id="apmt520_04.input" >}
#+ 資料輸入
PUBLIC FUNCTION apmt520_04(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_pmdtdocno,p_pmdtseq
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
   DEFINE p_pmdtdocno     LIKE pmdt_t.pmdtdocno
   DEFINE p_pmdtseq       LIKE pmdt_t.pmdtseq
   
   DEFINE lwin_curr       ui.Window
   DEFINE lfrm_curr       ui.Form
   DEFINE ls_path         STRING
   DEFINE l_n             LIKE type_t.num10           
   DEFINE l_cnt           LIKE type_t.num10           
   DEFINE l_lock_sw       LIKE type_t.chr1           
   DEFINE l_success       LIKE type_t.num5
   
   LET g_success = TRUE
   LET g_count = 0
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CONTINUE
   WHENEVER ERROR CALL cl_err_msg_log
   
   #開啟子畫面，選擇資料產生來源
   OPEN WINDOW w_apmt520_04_s01 WITH FORM cl_ap_formpath("apm","apmt520_04_s01")
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   LET lwin_curr = ui.Window.getCurrent()
   LET lfrm_curr = lwin_curr.getForm()
   LET ls_path = os.Path.join(os.Path.join(FGL_GETENV("ERP"),"cfg"),"4tb")
   LET ls_path = os.Path.join(ls_path,"toolbar_lib.4tb")
   CALL lfrm_curr.loadToolBar(ls_path)
   
   #1.依工單指定  #2.自行輸入  #3.依BOM展至下階 #4.依BOM展至尾階
   INPUT g_choice FROM formonly.choice
       BEFORE INPUT
          LET g_choice = '1'
   END INPUT
   
   IF INT_FLAG THEN
      LET INT_FLAG = FALSE
      CLOSE WINDOW w_apmt520_04_s01
      LET g_success = FALSE
      #RETURN g_success,g_count
   END IF
   
   IF g_choice NOT MATCHES '[1234]' OR cl_null(g_choice) THEN
      LET INT_FLAG = FALSE
      CLOSE WINDOW w_apmt520_04_s01
      LET g_success = FALSE
      #RETURN g_success,g_count
   END IF
   
   CLOSE WINDOW w_apmt520_04_s01
   
   LET g_pmdtdocno = p_pmdtdocno
   LET g_pmdtseq = p_pmdtseq
   
   SELECT pmdt001,pmdt002,pmdt006,pmdt020 INTO g_pmdt001,g_pmdt002,g_pmdt006,g_pmdt020 FROM pmdt_t
      WHERE pmdtent = g_enterprise AND pmdtdocno = g_pmdtdocno AND pmdtseq = g_pmdtseq
   
   IF cl_null(g_pmdt001) AND cl_null(g_pmdt002) AND cl_null(g_pmdt006) THEN
      LET g_success = FALSE
      #RETURN g_success,g_count
   END IF
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_apmt520_04 WITH FORM cl_ap_formpath("apm","apmt520_04")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單身前置處理 name="input.pre_input"
   #判斷據點參數若不使用參考單位時，則參考單位、數量需隱藏不可以維護(據點參數:S-BAS-0028)
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0028') = 'N' THEN
      CALL cl_set_comp_visible("pmdt021,pmdt021_desc,pmdt022",FALSE)
   END IF
   
   CALL apmt520_04_gen_pmdt_tmp()
   CALL apmt520_04_pmdt_tmp_fill()
   
   LET g_forupd_sql = "SELECT pmdtseq,pmdt006,pmdt019,pmdt020,pmdt021,pmdt022 FROM pmdt_tmp WHERE pmdtseq = ?  FOR UPDATE"
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apmt520_04_pmdt_bcl CURSOR FROM g_forupd_sql
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT ARRAY g_pmdt_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
         
         #自訂ACTION
         #add-point:單身前置處理 name="input.action"
         BEFORE ROW
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()

            LET g_rec_b = g_pmdt_d.getLength()
            
            IF g_rec_b >= l_ac  AND g_pmdt_d[l_ac].pmdtseq IS NOT NULL THEN
               LET l_cmd='u'
               LET g_pmdt_d_t.* = g_pmdt_d[l_ac].*  #BACKUP
               LET g_pmdt_d_o.* = g_pmdt_d[l_ac].*  #BACKUP
               OPEN apmt520_04_pmdt_bcl USING g_pmdt_d[l_ac].pmdtseq

               FETCH apmt520_04_pmdt_bcl INTO g_pmdt_d[l_ac].pmdtseq,g_pmdt_d[l_ac].pmdt006,g_pmdt_d[l_ac].pmdt019,
                                              g_pmdt_d[l_ac].pmdt020,g_pmdt_d[l_ac].pmdt021,g_pmdt_d[l_ac].pmdt022
                   
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_pmdt_d_t.pmdtseq
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
               END IF
                
               CALL cl_show_fld_cont()
            ELSE
               LET l_cmd='a'
            END IF

        
         BEFORE INSERT
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_pmdt_d[l_ac].* TO NULL 
            INITIALIZE g_pmdt_d_t.* TO NULL 
            INITIALIZE g_pmdt_d_o.* TO NULL 
            
            LET g_pmdt_d_t.* = g_pmdt_d[l_ac].*
            LET g_pmdt_d_o.* = g_pmdt_d[l_ac].*
            SELECT MAX(pmdtseq)+1 INTO g_pmdt_d[l_ac].pmdtseq FROM pmdt_tmp
            IF cl_null(g_pmdt_d[l_ac].pmdtseq) THEN
               LET g_pmdt_d[l_ac].pmdtseq = 1
            END IF
        
         AFTER INSERT
            LET l_insert = FALSE
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
            
            SELECT COUNT(*) INTO l_count FROM pmdt_tmp 
             WHERE pmdt001 = g_pmdt_d[l_ac].pmdtseq

            IF l_count = 0 THEN 
               INSERT INTO pmdt_tmp(pmdtseq,pmdt006,pmdt019,pmdt020,pmdt021,pmdt022)
                 VALUES (g_pmdt_d[l_ac].pmdtseq,g_pmdt_d[l_ac].pmdt006,g_pmdt_d[l_ac].pmdt019,g_pmdt_d[l_ac].pmdt020,
                         g_pmdt_d[l_ac].pmdt021,g_pmdt_d[l_ac].pmdt022)     
                
               LET g_rec_b = g_rec_b + 1
            END IF
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF

               DELETE FROM pmdt_tmp WHERE pmdt001 = g_pmdt_d[l_ac].pmdtseq
                       
               CLOSE apmt520_04_pmdt_bcl
            
               LET g_rec_b = g_rec_b-1
               LET l_count = g_pmdt_d.getLength()
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_pmdt_d.getLength() + 1) THEN
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
               LET g_pmdt_d[l_ac].* = g_pmdt_d_t.*
               CLOSE apmt520_04_pmdt_bcl
               EXIT DIALOG 
            END IF
    
            UPDATE pmdt_tmp SET (pmdt006,pmdt019,pmdt020,pmdt021,pmdt022) = 
                   (g_pmdt_d[l_ac].pmdt006,g_pmdt_d[l_ac].pmdt019,g_pmdt_d[l_ac].pmdt020,
                    g_pmdt_d[l_ac].pmdt021,g_pmdt_d[l_ac].pmdt022)
                WHERE pmdtseq = g_pmdt_d[l_ac].pmdtseq
            

         #end add-point
         
         #自訂ACTION(detail_input)
         
         
         BEFORE INPUT
            #add-point:單身輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdtdocno
            #add-point:BEFORE FIELD pmdtdocno name="input.b.page1.pmdtdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdtdocno
            
            #add-point:AFTER FIELD pmdtdocno name="input.a.page1.pmdtdocno"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdtdocno
            #add-point:ON CHANGE pmdtdocno name="input.g.page1.pmdtdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdtseq
            #add-point:BEFORE FIELD pmdtseq name="input.b.page1.pmdtseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdtseq
            
            #add-point:AFTER FIELD pmdtseq name="input.a.page1.pmdtseq"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdtseq
            #add-point:ON CHANGE pmdtseq name="input.g.page1.pmdtseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdt006
            
            #add-point:AFTER FIELD pmdt006 name="input.a.page1.pmdt006"
            CALL s_desc_get_item_desc(g_pmdt_d[l_ac].pmdt006) RETURNING g_pmdt_d[l_ac].pmdt006_desc,g_pmdt_d[l_ac].imaal004
            DISPLAY BY NAME g_pmdt_d[l_ac].pmdt006_desc,g_pmdt_d[l_ac].imaal004

            IF NOT cl_null(g_pmdt_d[l_ac].pmdt006) AND (g_pmdt_d[l_ac].pmdt006 != g_pmdt_d_o.pmdt006 OR cl_null(g_pmdt_d_o.pmdt006)) THEN 
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pmdt_d[l_ac].pmdt006
                  
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_imaf001_14") THEN
                  LET g_pmdt_d[l_ac].pmdt006 = g_pmdt_d_o.pmdt006
                  CALL s_desc_get_item_desc(g_pmdt_d[l_ac].pmdt006) RETURNING g_pmdt_d[l_ac].pmdt006_desc,g_pmdt_d[l_ac].imaal004
                  DISPLAY BY NAME g_pmdt_d[l_ac].pmdt006_desc,g_pmdt_d[l_ac].imaal004
                  NEXT FIELD CURRENT
               END IF
            
               #參考單位=料件設定的參考單位
               SELECT imaf015 INTO g_pmdt_d[l_ac].pmdt021 FROM imaf_t WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = g_pmdt_d[l_ac].pmdt006
               IF NOT cl_null(g_pmdt_d[l_ac].pmdt021) AND NOT cl_null(g_pmdt_d[l_ac].pmdt019) AND g_pmdt_d[l_ac].pmdt020 > 0 THEN
                  CALL s_aooi250_convert_qty(g_pmdt_d[l_ac].pmdt006,g_pmdt_d[l_ac].pmdt019,g_pmdt_d[l_ac].pmdt021,g_pmdt_d[l_ac].pmdt020)
                     RETURNING l_success,g_pmdt_d[l_ac].pmdt022
               ELSE
                  LET g_pmdt_d[l_ac].pmdt022 = 0
               END IF
               CALL s_desc_get_unit_desc(g_pmdt_d[l_ac].pmdt021) RETURNING g_pmdt_d[l_ac].pmdt021_desc
               DISPLAY BY NAME g_pmdt_d[l_ac].pmdt021_desc,g_pmdt_d[l_ac].pmdt022
               
               UPDATE pmdt_tmp SET (pmdt006,pmdt019,pmdt020,pmdt021,pmdt022) = 
                   (g_pmdt_d[l_ac].pmdt006,g_pmdt_d[l_ac].pmdt019,g_pmdt_d[l_ac].pmdt020,
                    g_pmdt_d[l_ac].pmdt021,g_pmdt_d[l_ac].pmdt022)
                WHERE pmdtseq = g_pmdt_d[l_ac].pmdtseq
            END IF 
            


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdt006
            #add-point:BEFORE FIELD pmdt006 name="input.b.page1.pmdt006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdt006
            #add-point:ON CHANGE pmdt006 name="input.g.page1.pmdt006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdt019
            
            #add-point:AFTER FIELD pmdt019 name="input.a.page1.pmdt019"
            CALL s_desc_get_unit_desc(g_pmdt_d[l_ac].pmdt019) RETURNING g_pmdt_d[l_ac].pmdt019_desc
            DISPLAY BY NAME g_pmdt_d[l_ac].pmdt019_desc
            IF NOT cl_null(g_pmdt_d[l_ac].pmdt019) AND ( g_pmdt_d[l_ac].pmdt019 != g_pmdt_d_o.pmdt019 OR cl_null(g_pmdt_d_o.pmdt019)) THEN 
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pmdt_d[l_ac].pmdt006
               LET g_chkparam.arg2 = g_pmdt_d[l_ac].pmdt019
                  
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_imao002") THEN
                  LET g_pmdt_d[l_ac].pmdt019 = g_pmdt_d_o.pmdt019
                  CALL s_desc_get_unit_desc(g_pmdt_d[l_ac].pmdt019) RETURNING g_pmdt_d[l_ac].pmdt019_desc
                  DISPLAY BY NAME g_pmdt_d[l_ac].pmdt019_desc
                  NEXT FIELD CURRENT
               END IF
               IF NOT cl_null(g_pmdt_d[l_ac].pmdt021) AND NOT cl_null(g_pmdt_d[l_ac].pmdt019) AND g_pmdt_d[l_ac].pmdt020 > 0 THEN
                  CALL s_aooi250_convert_qty(g_pmdt_d[l_ac].pmdt006,g_pmdt_d[l_ac].pmdt019,g_pmdt_d[l_ac].pmdt021,g_pmdt_d[l_ac].pmdt020)
                     RETURNING l_success,g_pmdt_d[l_ac].pmdt022
               ELSE
                  LET g_pmdt_d[l_ac].pmdt022 = 0
               END IF
               DISPLAY BY NAME g_pmdt_d[l_ac].pmdt022
               
               UPDATE pmdt_tmp SET (pmdt006,pmdt019,pmdt020,pmdt021,pmdt022) = 
                   (g_pmdt_d[l_ac].pmdt006,g_pmdt_d[l_ac].pmdt019,g_pmdt_d[l_ac].pmdt020,
                    g_pmdt_d[l_ac].pmdt021,g_pmdt_d[l_ac].pmdt022)
                WHERE pmdtseq = g_pmdt_d[l_ac].pmdtseq
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdt019
            #add-point:BEFORE FIELD pmdt019 name="input.b.page1.pmdt019"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdt019
            #add-point:ON CHANGE pmdt019 name="input.g.page1.pmdt019"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdt020
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmdt_d[l_ac].pmdt020,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD pmdt020
            END IF 
 
 
 
            #add-point:AFTER FIELD pmdt020 name="input.a.page1.pmdt020"
            IF NOT cl_null(g_pmdt_d[l_ac].pmdt020) AND ( g_pmdt_d[l_ac].pmdt020 != g_pmdt_d_o.pmdt020 OR cl_null(g_pmdt_d_o.pmdt020)) THEN 
               IF NOT cl_null(g_pmdt_d[l_ac].pmdt021) AND NOT cl_null(g_pmdt_d[l_ac].pmdt019) AND g_pmdt_d[l_ac].pmdt020 > 0 THEN
                  CALL s_aooi250_convert_qty(g_pmdt_d[l_ac].pmdt006,g_pmdt_d[l_ac].pmdt019,g_pmdt_d[l_ac].pmdt021,g_pmdt_d[l_ac].pmdt020)
                     RETURNING l_success,g_pmdt_d[l_ac].pmdt022
               ELSE
                  LET g_pmdt_d[l_ac].pmdt022 = 0
               END IF
               DISPLAY BY NAME g_pmdt_d[l_ac].pmdt022
               
               UPDATE pmdt_tmp SET (pmdt006,pmdt019,pmdt020,pmdt021,pmdt022) = 
                   (g_pmdt_d[l_ac].pmdt006,g_pmdt_d[l_ac].pmdt019,g_pmdt_d[l_ac].pmdt020,
                    g_pmdt_d[l_ac].pmdt021,g_pmdt_d[l_ac].pmdt022)
                WHERE pmdtseq = g_pmdt_d[l_ac].pmdtseq
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdt020
            #add-point:BEFORE FIELD pmdt020 name="input.b.page1.pmdt020"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdt020
            #add-point:ON CHANGE pmdt020 name="input.g.page1.pmdt020"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdt021
            
            #add-point:AFTER FIELD pmdt021 name="input.a.page1.pmdt021"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdt021
            #add-point:BEFORE FIELD pmdt021 name="input.b.page1.pmdt021"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdt021
            #add-point:ON CHANGE pmdt021 name="input.g.page1.pmdt021"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdt022
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmdt_d[l_ac].pmdt022,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD pmdt022
            END IF 
 
 
 
            #add-point:AFTER FIELD pmdt022 name="input.a.page1.pmdt022"
            IF NOT cl_null(g_pmdt_d[l_ac].pmdt022) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdt022
            #add-point:BEFORE FIELD pmdt022 name="input.b.page1.pmdt022"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdt022
            #add-point:ON CHANGE pmdt022 name="input.g.page1.pmdt022"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.pmdtdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdtdocno
            #add-point:ON ACTION controlp INFIELD pmdtdocno name="input.c.page1.pmdtdocno"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdtseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdtseq
            #add-point:ON ACTION controlp INFIELD pmdtseq name="input.c.page1.pmdtseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdt006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdt006
            #add-point:ON ACTION controlp INFIELD pmdt006 name="input.c.page1.pmdt006"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdt_d[l_ac].pmdt006             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_imaf001_15()                                #呼叫開窗

            LET g_pmdt_d[l_ac].pmdt006 = g_qryparam.return1              

            DISPLAY g_pmdt_d[l_ac].pmdt006 TO pmdt006              #
            CALL s_desc_get_item_desc(g_pmdt_d[l_ac].pmdt006) RETURNING g_pmdt_d[l_ac].pmdt006_desc,g_pmdt_d[l_ac].imaal004
            DISPLAY BY NAME g_pmdt_d[l_ac].pmdt006_desc,g_pmdt_d[l_ac].imaal004

            NEXT FIELD pmdt006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdt019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdt019
            #add-point:ON ACTION controlp INFIELD pmdt019 name="input.c.page1.pmdt019"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdt_d[l_ac].pmdt019             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_pmdt_d[l_ac].pmdt006 #

            
            CALL q_imao002()                                #呼叫開窗

            LET g_pmdt_d[l_ac].pmdt019 = g_qryparam.return1              

            DISPLAY g_pmdt_d[l_ac].pmdt019 TO pmdt019              #
            CALL s_desc_get_unit_desc(g_pmdt_d[l_ac].pmdt019) RETURNING g_pmdt_d[l_ac].pmdt019_desc
            DISPLAY BY NAME g_pmdt_d[l_ac].pmdt019_desc

            NEXT FIELD pmdt019                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdt020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdt020
            #add-point:ON ACTION controlp INFIELD pmdt020 name="input.c.page1.pmdt020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdt021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdt021
            #add-point:ON ACTION controlp INFIELD pmdt021 name="input.c.page1.pmdt021"
 
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdt022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdt022
            #add-point:ON ACTION controlp INFIELD pmdt022 name="input.c.page1.pmdt022"
            
            #END add-point
 
 
 
 
         #自訂ACTION
         #add-point:單身其他段落處理(EX:on row change, etc...) name="input.other"
     
         #end add-point
 
         AFTER INPUT
            #add-point:單身輸入後處理 name="input.after_input"
            CLOSE apmt520_04_pmdt_bcl
            #end add-point
            
      END INPUT
      
 
      
      #add-point:自定義input name="input.more_input"
      #重新產生
      #按下後詢問是否刪除目前資料，如果選是則顯示第一個畫面，再選擇完後再重新產生
      ON ACTION gen_back  
         IF cl_ask_confirm('axm-00175') THEN
            CLOSE WINDOW w_apmt520_04 
            DELETE FROM pmdt_tmp
            CALL apmt520_04(g_pmdtdocno,g_pmdtseq)
         END IF
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
   CLOSE WINDOW w_apmt520_04 
   
   #add-point:input段after input name="input.post_input"
   IF NOT INT_FLAG THEN
      CALL apmt520_04_gen_pmdt()
   END IF
   
   DELETE FROM pmdt_tmp
   
   LET INT_FLAG = FALSE
   
   #RETURN g_success,g_count
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="apmt520_04.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="apmt520_04.other_function" readonly="Y" >}
#建立臨時表
PUBLIC FUNCTION apmt520_04_create_tmp()

   CREATE TEMP TABLE pmdt_tmp(
   pmdtseq      DECIMAL(10,0),
   pmdt006      VARCHAR(40),
   pmdt019      VARCHAR(10),
   pmdt020      DECIMAL(20,6),
   pmdt021      VARCHAR(10),
   pmdt022      DECIMAL(20,6)
   );
   
END FUNCTION

#从临时表资料填充到单身
PRIVATE FUNCTION apmt520_04_pmdt_tmp_fill()

    CALL g_pmdt_d.clear()
    LET g_sql = "SELECT pmdtseq,pmdt006,pmdt019,pmdt020,pmdt021,pmdt022 FROM pmdt_tmp ORDER BY pmdt006"
    LET g_sql = cl_sql_add_mask(g_sql)
    PREPARE apmt520_04_pmdt_pb FROM g_sql
    DECLARE apmt520_04_pmdt_cs CURSOR FOR apmt520_04_pmdt_pb
         
    LET g_cnt = l_ac
    LET l_ac = 1
    FOREACH apmt520_04_pmdt_cs INTO g_pmdt_d[l_ac].pmdtseq,g_pmdt_d[l_ac].pmdt006,g_pmdt_d[l_ac].pmdt019,g_pmdt_d[l_ac].pmdt020,
                                    g_pmdt_d[l_ac].pmdt021,g_pmdt_d[l_ac].pmdt022
                                    
       CALL s_desc_get_item_desc(g_pmdt_d[l_ac].pmdt006) RETURNING g_pmdt_d[l_ac].pmdt006_desc,g_pmdt_d[l_ac].imaal004
       DISPLAY BY NAME g_pmdt_d[l_ac].pmdt006_desc,g_pmdt_d[l_ac].imaal004

       CALL s_desc_get_unit_desc(g_pmdt_d[l_ac].pmdt019) RETURNING g_pmdt_d[l_ac].pmdt019_desc
       DISPLAY BY NAME g_pmdt_d[l_ac].pmdt019_desc
       
       CALL s_desc_get_unit_desc(g_pmdt_d[l_ac].pmdt021) RETURNING g_pmdt_d[l_ac].pmdt021_desc
       DISPLAY BY NAME g_pmdt_d[l_ac].pmdt021_desc
    
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
    
    CALL g_pmdt_d.deleteElement(g_pmdt_d.getLength())
    LET l_ac = g_cnt
    LET g_cnt = 0  
    
END FUNCTION
#删除临时表
PUBLIC FUNCTION apmt520_04_drop_tmp()

    DROP TABLE pmdt_tmp
    
END FUNCTION

#依据来源写入临时表
PRIVATE FUNCTION apmt520_04_gen_pmdt_tmp()
DEFINE l_pmdp003    LIKE pmdp_t.pmdp003
DEFINE l_sfaa012    LIKE sfaa_t.sfaa012
DEFINE l_pmdt006    LIKE pmdt_t.pmdt006
DEFINE l_pmdt007    LIKE pmdt_t.pmdt007
DEFINE l_sfac003    LIKE sfac_t.sfac003
DEFINE l_sfac004    LIKE sfac_t.sfac004
DEFINE l_pmdt019    LIKE pmdt_t.pmdt019
DEFINE l_pmdt020    LIKE pmdt_t.pmdt020
DEFINE l_pmdt021    LIKE pmdt_t.pmdt021
DEFINE l_pmdt022    LIKE pmdt_t.pmdt022
DEFINE l_success    LIKE type_t.num5
DEFINE l_type       LIKE type_t.chr1
DEFINE l_pmdt019_1  LIKE pmdt_t.pmdt019
DEFINE l_pmdtseq    LIKE pmdt_t.pmdtseq
DEFINE l_i          LIKE type_t.num10  
DEFINE l_pmdt041    LIKE pmdt_t.pmdt041   #160512-00016#24

    DELETE FROM pmdt_tmp
    
    IF cl_null(g_pmdt020) THEN
       LET g_pmdt020 = 0
    END IF
    
    IF g_choice = '1' THEN
       DECLARE pmdp_cs CURSOR FOR
          SELECT DISTINCT pmdp003 FROM pmdp_t WHERE pmdpent = g_enterprise AND pmdpdocno = g_pmdt001 AND pmdpseq = g_pmdt002
       
       FOREACH pmdp_cs INTO l_pmdp003
          SELECT sfaa012 INTO l_sfaa012 FROM sfaa_t WHERE sfaaent = g_enterprise AND sfaadocno = l_pmdp003
          
          DECLARE sfac_cs CURSOR FOR
             SELECT sfac001,SUM(sfac003),sfac004 FROM sfac_t
                WHERE sfacent = g_enterprise AND sfacdocno = l_pmdp003 AND sfac002 = '4' #4.拆件入庫的資料
             GROUP BY sfac001,sfac004
          FOREACH sfac_cs INTO l_pmdt006,l_sfac003,l_sfac004
             #數量=(預計產出量(sfac003)/工單生產數量(sfaa012))*拆件主件的收貨數量
             LET l_pmdt020 = l_sfac003 / l_sfaa012 * g_pmdt020
             IF cl_null(l_pmdt020) THEN
                LET l_pmdt020 = 0
             END IF
             #參考單位=料件設定的參考單位
             SELECT imaf015 INTO l_pmdt021 FROM imaf_t WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = l_pmdt006
             IF NOT cl_null(l_pmdt021) AND NOT cl_null(l_sfac004) THEN
                CALL s_aooi250_convert_qty(l_pmdt006,l_sfac004,l_pmdt021,l_pmdt020)
                   RETURNING l_success,l_pmdt022
             ELSE
                LET l_pmdt022 = 0
             END IF
             SELECT MAX(pmdtseq)+1 INTO l_pmdtseq FROM pmdt_tmp
             IF cl_null(l_pmdtseq) THEN
                LET l_pmdtseq = 1
             END IF
             INSERT INTO pmdt_tmp(pmdtseq,pmdt006,pmdt019,pmdt020,pmdt021,pmdt022)
                 VALUES (l_pmdtseq,l_pmdt006,l_sfac004,l_pmdt020,l_pmdt021,l_pmdt022)             
          END FOREACH
       END FOREACH
    END IF
    
    #3.用拆件主件的料號展BOM，只展一階
    #4.用拆件主件的料號展BOM，展至尾階
    IF g_choice MATCHES '[34]' THEN
       IF cl_null(g_pmdt006) THEN
          RETURN
       END IF
       SELECT pmdt019,pmdt041 INTO l_pmdt019,l_pmdt041   #160512-00016#24 add pmdt041
          FROM pmdt_t WHERE pmdtent = g_enterprise AND pmdtdocno = g_pmdtdocno AND pmdtseq = g_pmdtseq
       IF cl_null(l_pmdt019) THEN
          RETURN
       END IF
       IF g_choice = '3' THEN
          LET l_type = 'S' #展單階
       ELSE
          LET l_type = 'Y' #展尾階
       END IF 
       #160512-00016#24--s
       #CALL s_asft300_02_bom(0,g_pmdt006,' ',l_pmdt019,1,1,'',l_type,'','','N') RETURNING g_bmba
       CALL s_asft300_02_bom(0,g_pmdt006,' ',l_pmdt019,1,1,'',l_type,'','','N',l_pmdt041) RETURNING g_bmba
       #160512-00016#24---e
       
       #IF g_bmba.getLength() > 1 THEN  #因為第一筆資料已呈現在畫面並寫入DB, 從第二筆開始處理  #160816-00064#1
       IF g_bmba.getLength() > 0 THEN    #160816-00064#1         
          FOR l_i = 1 TO g_bmba.getLength()
              LET l_pmdt006 = g_bmba[l_i].bmba003     #元件料號  
              LET l_pmdt007 = g_bmba[l_i].l_inam002   #元件对应特征
              
              #g_bmba[l_i].l_bmba011         #QPA 分子，对应于原始的主件料号
              #g_bmba[l_i].l_bmba012         #QPA 分母，对应于原始的主件料号
              LET l_pmdt020 = g_bmba[l_i].l_bmba011/g_bmba[l_i].l_bmba012 * g_pmdt020
              IF cl_null(l_pmdt020) THEN
                 LET l_pmdt020 = 0
              END IF
              #取得發料單位
              SELECT bmba010 INTO l_pmdt019_1 FROM bmba_t
                 WHERE bmbaent = g_enterprise AND bmbasite = g_site AND bmba001 = g_bmba[l_i].bmba001 AND bmba002 = g_bmba[l_i].bmba002
                   AND bmba003 = g_bmba[l_i].bmba003 AND bmba004 = g_bmba[l_i].bmba004 AND bmba005 = g_bmba[l_i].bmba005
                   AND bmba007 = g_bmba[l_i].bmba007 AND bmba008 = g_bmba[l_i].bmba008
              IF l_pmdt019_1 <> l_pmdt019 AND (NOT cl_null(l_pmdt019_1)) AND (NOT cl_null(l_pmdt019)) THEN
                 CALL s_aooi250_convert_qty(g_pmdt006,l_pmdt019,l_pmdt019_1,l_pmdt020)
                    RETURNING l_success,l_pmdt020
              END IF
              #參考單位=料件設定的參考單位
              SELECT imaf015 INTO l_pmdt021 FROM imaf_t WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = l_pmdt006
              IF NOT cl_null(l_pmdt021) AND NOT cl_null(l_pmdt019_1) THEN
                 CALL s_aooi250_convert_qty(l_pmdt006,l_pmdt019_1,l_pmdt021,l_pmdt020)
                    RETURNING l_success,l_pmdt022
              ELSE
                 LET l_pmdt022 = 0
              END IF
             
              SELECT MAX(pmdtseq)+1 INTO l_pmdtseq FROM pmdt_tmp
              IF cl_null(l_pmdtseq) THEN
                 LET l_pmdtseq = 1
              END IF
              INSERT INTO pmdt_tmp(pmdtseq,pmdt006,pmdt019,pmdt020,pmdt021,pmdt022)
                 VALUES (l_pmdtseq,l_pmdt006,l_pmdt019_1,l_pmdt020,l_pmdt021,l_pmdt022)     
          END FOR
       END IF
    END IF
    
END FUNCTION

#產生委外收貨單單身資料
PRIVATE FUNCTION apmt520_04_gen_pmdt()
#161124-00048#11 mod-S
#DEFINE l_pmdt           RECORD LIKE pmdt_t.*
DEFINE l_pmdt RECORD  #收貨/入庫單身明細檔
       pmdtent LIKE pmdt_t.pmdtent, #企业编号
       pmdtsite LIKE pmdt_t.pmdtsite, #营运据点
       pmdtdocno LIKE pmdt_t.pmdtdocno, #单据编号
       pmdtseq LIKE pmdt_t.pmdtseq, #项次
       pmdt001 LIKE pmdt_t.pmdt001, #采购单号
       pmdt002 LIKE pmdt_t.pmdt002, #采购项次
       pmdt003 LIKE pmdt_t.pmdt003, #采购项序
       pmdt004 LIKE pmdt_t.pmdt004, #采购分批序
       pmdt005 LIKE pmdt_t.pmdt005, #子件特性
       pmdt006 LIKE pmdt_t.pmdt006, #料件编号
       pmdt007 LIKE pmdt_t.pmdt007, #产品特征
       pmdt008 LIKE pmdt_t.pmdt008, #包装容器
       pmdt009 LIKE pmdt_t.pmdt009, #作业编号
       pmdt010 LIKE pmdt_t.pmdt010, #作业序
       pmdt011 LIKE pmdt_t.pmdt011, #冲销顺序
       pmdt016 LIKE pmdt_t.pmdt016, #库位
       pmdt017 LIKE pmdt_t.pmdt017, #储位
       pmdt018 LIKE pmdt_t.pmdt018, #批号
       pmdt019 LIKE pmdt_t.pmdt019, #收货/入库单位
       pmdt020 LIKE pmdt_t.pmdt020, #收货/入库数量
       pmdt021 LIKE pmdt_t.pmdt021, #参考单位
       pmdt022 LIKE pmdt_t.pmdt022, #参考数量
       pmdt023 LIKE pmdt_t.pmdt023, #计价单位
       pmdt024 LIKE pmdt_t.pmdt024, #计价数量
       pmdt025 LIKE pmdt_t.pmdt025, #紧急度
       pmdt026 LIKE pmdt_t.pmdt026, #检验否
       pmdt027 LIKE pmdt_t.pmdt027, #收货单号
       pmdt028 LIKE pmdt_t.pmdt028, #收货项次
       pmdt036 LIKE pmdt_t.pmdt036, #单价
       pmdt037 LIKE pmdt_t.pmdt037, #税率
       pmdt038 LIKE pmdt_t.pmdt038, #税前金额
       pmdt039 LIKE pmdt_t.pmdt039, #含税金额
       pmdt040 LIKE pmdt_t.pmdt040, #价格核决
       pmdt041 LIKE pmdt_t.pmdt041, #保税否
       pmdt042 LIKE pmdt_t.pmdt042, #取价来源
       pmdt043 LIKE pmdt_t.pmdt043, #价格参考单号
       pmdt044 LIKE pmdt_t.pmdt044, #取出单价
       pmdt045 LIKE pmdt_t.pmdt045, #价差比
       pmdt046 LIKE pmdt_t.pmdt046, #税种
       pmdt047 LIKE pmdt_t.pmdt047, #税额
       pmdt051 LIKE pmdt_t.pmdt051, #理由码
       pmdt052 LIKE pmdt_t.pmdt052, #状态码
       pmdt053 LIKE pmdt_t.pmdt053, #允收数量
       pmdt054 LIKE pmdt_t.pmdt054, #已入库量
       pmdt055 LIKE pmdt_t.pmdt055, #验退量
       pmdt056 LIKE pmdt_t.pmdt056, #主账套已请款数量
       pmdt057 LIKE pmdt_t.pmdt057, #账套二已请款数量
       pmdt058 LIKE pmdt_t.pmdt058, #账套三已请款数量
       pmdt059 LIKE pmdt_t.pmdt059, #备注
       pmdt060 LIKE pmdt_t.pmdt060, #供应商批号
       pmdt061 LIKE pmdt_t.pmdt061, #供应商送货数量
       pmdt062 LIKE pmdt_t.pmdt062, #多库储批收货入库
       pmdt063 LIKE pmdt_t.pmdt063, #库存管理特征
       pmdt064 LIKE pmdt_t.pmdt064, #出货单号
       pmdt065 LIKE pmdt_t.pmdt065, #出货单项次
       pmdt066 LIKE pmdt_t.pmdt066, #主账套暂估数量
       pmdt067 LIKE pmdt_t.pmdt067, #账套二暂估数量
       pmdt068 LIKE pmdt_t.pmdt068, #账套三暂估数量
       pmdt069 LIKE pmdt_t.pmdt069, #已开发票数量
       pmdt081 LIKE pmdt_t.pmdt081, #QC单号
       pmdt082 LIKE pmdt_t.pmdt082, #QC判定项次
       pmdt083 LIKE pmdt_t.pmdt083, #判定结果
       pmdt084 LIKE pmdt_t.pmdt084, #须自立AP否
       pmdt085 LIKE pmdt_t.pmdt085, #多角流程编号
       pmdt086 LIKE pmdt_t.pmdt086, #采购多角性质
       pmdt087 LIKE pmdt_t.pmdt087, #采购单开立据点
       pmdt088 LIKE pmdt_t.pmdt088, #存货备注
       pmdt089 LIKE pmdt_t.pmdt089, #有效日期
       pmdt900 LIKE pmdt_t.pmdt900, #保留字段str
       pmdt999 LIKE pmdt_t.pmdt999, #保留字段end
       pmdt200 LIKE pmdt_t.pmdt200, #商品条码
       pmdt201 LIKE pmdt_t.pmdt201, #收货包装单位
       pmdt202 LIKE pmdt_t.pmdt202, #收货包装数量
       pmdt203 LIKE pmdt_t.pmdt203, #采购组织
       pmdt204 LIKE pmdt_t.pmdt204, #采购中心
       pmdt205 LIKE pmdt_t.pmdt205, #要货组织
       pmdt206 LIKE pmdt_t.pmdt206, #预约收货单号
       pmdt207 LIKE pmdt_t.pmdt207, #预约收货项次
       pmdt208 LIKE pmdt_t.pmdt208, #采购渠道
       pmdt209 LIKE pmdt_t.pmdt209, #渠道性质
       pmdt210 LIKE pmdt_t.pmdt210, #经营方式
       pmdt211 LIKE pmdt_t.pmdt211, #结算方式
       pmdt212 LIKE pmdt_t.pmdt212, #合同编号
       pmdt213 LIKE pmdt_t.pmdt213, #协议编号
       pmdtorga LIKE pmdt_t.pmdtorga, #账务组织
       pmdt070 LIKE pmdt_t.pmdt070, #参考单号
       pmdt071 LIKE pmdt_t.pmdt071, #参考项次
       pmdt214 LIKE pmdt_t.pmdt214, #采购方式
       pmdt215 LIKE pmdt_t.pmdt215, #最终收货组织
       pmdt048 LIKE pmdt_t.pmdt048, #价格参考项次
       pmdt216 LIKE pmdt_t.pmdt216, #退货申请单号
       pmdt217 LIKE pmdt_t.pmdt217, #退货申请项次
       pmdt090 LIKE pmdt_t.pmdt090, #借货还价数量
       pmdt091 LIKE pmdt_t.pmdt091, #借货还价参考数量
       pmdt092 LIKE pmdt_t.pmdt092, #还价税前金额
       pmdt093 LIKE pmdt_t.pmdt093, #还价含税金额
       pmdt218 LIKE pmdt_t.pmdt218, #采购价
       pmdt219 LIKE pmdt_t.pmdt219, #制造日期
       pmdt072 LIKE pmdt_t.pmdt072, #项目编号
       pmdt073 LIKE pmdt_t.pmdt073, #WBS
       pmdt074 LIKE pmdt_t.pmdt074, #活动编号
       pmdt227 LIKE pmdt_t.pmdt227, #补货规格说明
       pmdt049 LIKE pmdt_t.pmdt049, #发票编号
       pmdt050 LIKE pmdt_t.pmdt050, #发票号码
       pmdt075 LIKE pmdt_t.pmdt075, #预算细项
       pmdt220 LIKE pmdt_t.pmdt220, #商品品类
       pmdt221 LIKE pmdt_t.pmdt221  #来源单据商品品类
END RECORD
#161124-00048#11 mod-E
DEFINE l_sql            STRING
DEFINE l_success        LIKE type_t.num5
DEFINE l_pmduseq1       LIKE pmdu_t.pmduseq1
DEFINE l_pmds007        LIKE pmds_t.pmds007
#161124-00048#11 mod-S
#DEFINE l_pmdv           RECORD LIKE pmdv_t.*
DEFINE l_pmdv RECORD  #收貨/入庫需求分配明細檔
       pmdvent LIKE pmdv_t.pmdvent, #企业编号
       pmdvsite LIKE pmdv_t.pmdvsite, #营运据点
       pmdvdocno LIKE pmdv_t.pmdvdocno, #单据编号
       pmdvseq LIKE pmdv_t.pmdvseq, #项次
       pmdvseq1 LIKE pmdv_t.pmdvseq1, #项序
       pmdv001 LIKE pmdv_t.pmdv001, #收货料件编号
       pmdv002 LIKE pmdv_t.pmdv002, #收货产品特征
       pmdv003 LIKE pmdv_t.pmdv003, #作业编号
       pmdv004 LIKE pmdv_t.pmdv004, #作业序
       pmdv005 LIKE pmdv_t.pmdv005, #子件特性
       pmdv006 LIKE pmdv_t.pmdv006, #QPA
       pmdv011 LIKE pmdv_t.pmdv011, #采购单号
       pmdv012 LIKE pmdv_t.pmdv012, #采购项次
       pmdv013 LIKE pmdv_t.pmdv013, #采购项序
       pmdv014 LIKE pmdv_t.pmdv014, #需求单号
       pmdv015 LIKE pmdv_t.pmdv015, #需求项次
       pmdv016 LIKE pmdv_t.pmdv016, #需求项序
       pmdv017 LIKE pmdv_t.pmdv017, #需求分批序
       pmdv018 LIKE pmdv_t.pmdv018, #收货/入库单位
       pmdv019 LIKE pmdv_t.pmdv019, #收货/入库分配数量
       pmdv900 LIKE pmdv_t.pmdv900, #保留字段str
       pmdv999 LIKE pmdv_t.pmdv999, #保留字段end
       pmdv200 LIKE pmdv_t.pmdv200, #包装单位
       pmdv201 LIKE pmdv_t.pmdv201  #包装数量
END RECORD
#161124-00048#11 mod-S

    CALL cl_err_collect_init() 
    #161124-00048#11 mod-S
#    SELECT * INTO l_pmdt.* FROM pmdt_t WHERE pmdtent = g_enterprise AND pmdtdocno = g_pmdtdocno AND pmdtseq = g_pmdtseq
    SELECT pmdtent,pmdtsite,pmdtdocno,pmdtseq,pmdt001,
           pmdt002,pmdt003,pmdt004,pmdt005,pmdt006,
           pmdt007,pmdt008,pmdt009,pmdt010,pmdt011,
           pmdt016,pmdt017,pmdt018,pmdt019,pmdt020,
           pmdt021,pmdt022,pmdt023,pmdt024,pmdt025,
           pmdt026,pmdt027,pmdt028,pmdt036,pmdt037,
           pmdt038,pmdt039,pmdt040,pmdt041,pmdt042,
           pmdt043,pmdt044,pmdt045,pmdt046,pmdt047,
           pmdt051,pmdt052,pmdt053,pmdt054,pmdt055,
           pmdt056,pmdt057,pmdt058,pmdt059,pmdt060,
           pmdt061,pmdt062,pmdt063,pmdt064,pmdt065,
           pmdt066,pmdt067,pmdt068,pmdt069,pmdt081,
           pmdt082,pmdt083,pmdt084,pmdt085,pmdt086,
           pmdt087,pmdt088,pmdt089,pmdt900,pmdt999,
           pmdt200,pmdt201,pmdt202,pmdt203,pmdt204,
           pmdt205,pmdt206,pmdt207,pmdt208,pmdt209,
           pmdt210,pmdt211,pmdt212,pmdt213,pmdtorga,
           pmdt070,pmdt071,pmdt214,pmdt215,pmdt048,
           pmdt216,pmdt217,pmdt090,pmdt091,pmdt092,
           pmdt093,pmdt218,pmdt219,pmdt072,pmdt073,
           pmdt074,pmdt227,pmdt049,pmdt050,pmdt075,
           pmdt220,pmdt221 
      INTO l_pmdt.* 
      FROM pmdt_t 
     WHERE pmdtent = g_enterprise AND pmdtdocno = g_pmdtdocno AND pmdtseq = g_pmdtseq
    #161124-00048#11 mod-E
    
    SELECT pmds007 INTO l_pmds007 FROM pmds_t WHERE pmdsent = g_enterprise AND pmdsdocno = g_pmdtdocno
    
    LET l_sql = "SELECT pmdt006,(CASE WHEN pmdt019 IS NULL THEN ' ' ELSE pmdt019 END ),SUM(pmdt020), ",
                "       (CASE WHEN pmdt021 IS NULL THEN ' ' ELSE pmdt021 END ),SUM(pmdt022) FROM pmdt_tmp ",
                "  GROUP BY pmdt006,(CASE WHEN pmdt019 IS NULL THEN ' ' ELSE pmdt019 END ) ,(CASE WHEN pmdt021 IS NULL THEN ' ' ELSE pmdt021 END ) ",   
                "  ORDER BY pmdt006"
   
    PREPARE apmt520_04_ins_pb FROM l_sql
    DECLARE apmt520_04_ins_cs CURSOR FOR apmt520_04_ins_pb
    
    FOREACH apmt520_04_ins_cs INTO l_pmdt.pmdt006,l_pmdt.pmdt019,l_pmdt.pmdt020,l_pmdt.pmdt021,l_pmdt.pmdt022
       
       LET l_pmdt.pmdt005 = '11' #拆件元件
       
       LET l_pmdt.pmdt007 = ' '
       LET l_pmdt.pmdt008 = ''
       #LET l_pmdt.pmdt009 = ''
       #LET l_pmdt.pmdt010 = ''
       
       LET l_pmdt.pmdt011 = 1
       
       IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = "Y" THEN  
          SELECT imaf144 INTO l_pmdt.pmdt023 FROM imaf_t
              WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = l_pmdt.pmdt006
          IF (NOT cl_null(l_pmdt.pmdt023)) AND (NOT cl_null(l_pmdt.pmdt006)) AND (NOT cl_null(l_pmdt.pmdt019)) THEN
             CALL s_aooi250_convert_qty(l_pmdt.pmdt006,l_pmdt.pmdt019,l_pmdt.pmdt023,l_pmdt.pmdt020)
                RETURNING l_success,l_pmdt.pmdt024
          END IF              
       ELSE
          LET l_pmdt.pmdt023 = l_pmdt.pmdt019
          LET l_pmdt.pmdt024 = l_pmdt.pmdt020
       END IF
       IF cl_null(l_pmdt.pmdt023) THEN
          LET l_pmdt.pmdt023 = l_pmdt.pmdt019
          LET l_pmdt.pmdt024 = l_pmdt.pmdt020
       END IF   
       
       #是否檢驗
       LET l_sql = " SELECT qcap006 FROM qcap_t ",
                 " WHERE qcapent = '",g_enterprise,"' ",
                 "  AND qcapsite = '",g_site,"' ",
                 "  AND qcap001 = '",l_pmdt.pmdt006,"' ",
                 "  AND qcap002 = '",l_pmds007,"' "
                 
      IF l_pmdt.pmdt007 IS NOT NULL THEN
         LET l_sql = l_sql ," AND ( qcap005 = '",l_pmdt.pmdt007,"' OR qcap005 = 'ALL') "
      END IF
      IF (NOT cl_null(l_pmdt.pmdt009)) AND (NOT cl_null(l_pmdt.pmdt010)) THEN
         LET l_sql = l_sql ," AND ( qcap003 = '",l_pmdt.pmdt009,"' OR qcap003 = 'ALL') AND qcap004 = '",l_pmdt.pmdt010,"' "
      END IF
      
      PREPARE get_qcap FROM l_sql
      EXECUTE get_qcap INTO l_pmdt.pmdt026
      FREE get_qcap
      
      IF cl_null(l_pmdt.pmdt026) THEN
         #若沒有維護aqci050,再從aqci040中帶值
         SELECT imae114 INTO l_pmdt.pmdt026 FROM imae_t 
             WHERE imaeent = g_enterprise AND imaesite = g_site AND imae001 = l_pmdt.pmdt006
             
      END IF
      
      IF cl_null(l_pmdt.pmdt026) THEN
         LET l_pmdt.pmdt026 = 'N'
      END IF
      
      LET l_pmdt.pmdt036 = 0  #单价
       
      LET l_pmdt.pmdt038 = 0  #未税金额
      LET l_pmdt.pmdt039 = 0  #含税金额
      LET l_pmdt.pmdt047 = 0  #税额
      
      LET l_pmdt.pmdt052 = '1'  #状态码
      LET l_pmdt.pmdt053 = 0
      LET l_pmdt.pmdt054 = 0
      LET l_pmdt.pmdt055 = 0
      LET l_pmdt.pmdt056 = 0
      LET l_pmdt.pmdt057 = 0
      LET l_pmdt.pmdt058 = 0
      
      LET l_pmdt.pmdt062 = 'N'  #多库储批收货入库
      
      SELECT MAX(pmdtseq)+1 INTO l_pmdt.pmdtseq FROM pmdt_t
         WHERE pmdtent = g_enterprise AND pmdtdocno = g_pmdtdocno
       IF cl_null(l_pmdt.pmdtseq) OR l_pmdt.pmdtseq = 0 THEN
          LET l_pmdt.pmdtseq = 1
       END IF
        
       INSERT INTO pmdt_t
           (pmdtent,pmdtsite,pmdtdocno,pmdtseq,
            pmdt001,pmdt002,pmdt003,pmdt004,pmdt005,pmdt006,pmdt007,pmdt009,pmdt010,pmdt025,pmdt011,pmdt019,pmdt020,pmdt021,pmdt022,
            pmdt008,pmdt023,pmdt024,pmdt036,pmdt046,pmdt037,pmdt038,pmdt039,pmdt047,pmdt026,pmdt041,pmdt016,pmdt017,pmdt018,pmdt063,pmdt040,pmdt051,
            pmdt052,pmdt059,pmdt053,pmdt054,pmdt055,pmdt060,pmdt061,pmdt062,pmdt056,pmdt057,pmdt058,pmdt066,pmdt067,pmdt068,pmdt069,pmdt084,
            pmdt088,pmdt089,pmdt042,pmdt043,pmdt044,pmdt045,pmdt048,
            pmdt072,pmdt073,pmdt074) 
        VALUES(l_pmdt.pmdtent,l_pmdt.pmdtsite,
               l_pmdt.pmdtdocno,l_pmdt.pmdtseq,
               l_pmdt.pmdt001,l_pmdt.pmdt002, 
               l_pmdt.pmdt003,l_pmdt.pmdt004,l_pmdt.pmdt005, 
               l_pmdt.pmdt006,l_pmdt.pmdt007,l_pmdt.pmdt009, 
               l_pmdt.pmdt010,l_pmdt.pmdt025,l_pmdt.pmdt011, 
               l_pmdt.pmdt019,l_pmdt.pmdt020,l_pmdt.pmdt021, 
               l_pmdt.pmdt022,l_pmdt.pmdt008,l_pmdt.pmdt023, 
               l_pmdt.pmdt024,l_pmdt.pmdt036,l_pmdt.pmdt046, 
               l_pmdt.pmdt037,l_pmdt.pmdt038,l_pmdt.pmdt039,l_pmdt.pmdt047, 
               l_pmdt.pmdt026,l_pmdt.pmdt041,l_pmdt.pmdt016, 
               l_pmdt.pmdt017,l_pmdt.pmdt018,l_pmdt.pmdt063,l_pmdt.pmdt040, 
               l_pmdt.pmdt051,l_pmdt.pmdt052,l_pmdt.pmdt059,
               l_pmdt.pmdt053,l_pmdt.pmdt054,l_pmdt.pmdt055,
               l_pmdt.pmdt060,l_pmdt.pmdt061,l_pmdt.pmdt062,l_pmdt.pmdt056,l_pmdt.pmdt057,l_pmdt.pmdt058,
               l_pmdt.pmdt066,l_pmdt.pmdt067,l_pmdt.pmdt068,l_pmdt.pmdt069,l_pmdt.pmdt084,l_pmdt.pmdt088,l_pmdt.pmdt089,
               l_pmdt.pmdt042,l_pmdt.pmdt043,l_pmdt.pmdt044,l_pmdt.pmdt045,l_pmdt.pmdt048,
               l_pmdt.pmdt072,l_pmdt.pmdt073,l_pmdt.pmdt074)
           
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "pmdb_t"
          LET g_errparam.popup = TRUE
          CALL cl_err()
          RETURN
       ELSE
          LET g_count = g_count + 1
       END IF
       
       LET l_pmduseq1 = 0
         
       SELECT MAX(pmduseq1)+1 INTO l_pmduseq1 FROM pmdu_t
         WHERE pmduent = g_enterprise AND pmdudocno = l_pmdt.pmdtdocno AND pmduseq = l_pmdt.pmdtseq
       IF cl_null(l_pmduseq1) OR l_pmduseq1 = 0 THEN
          LET l_pmduseq1 = 1
       END IF
         
       INSERT INTO pmdu_t(pmduent,pmdusite,pmdudocno,pmduseq,pmduseq1,pmdu001,pmdu002,pmdu003,pmdu004,pmdu005,
                          pmdu006,pmdu007,pmdu008,pmdu009,pmdu010,pmdu011,pmdu012,pmdu013,pmdu014,pmdu015,pmdu016,pmdu017)
         VALUES (l_pmdt.pmdtent,l_pmdt.pmdtsite,
                 l_pmdt.pmdtdocno,l_pmdt.pmdtseq,l_pmduseq1,l_pmdt.pmdt006,
                 l_pmdt.pmdt007,l_pmdt.pmdt009,l_pmdt.pmdt010,l_pmdt.pmdt063,
                 l_pmdt.pmdt016,l_pmdt.pmdt017,l_pmdt.pmdt018,l_pmdt.pmdt019,
                 l_pmdt.pmdt020,l_pmdt.pmdt021,l_pmdt.pmdt022,l_pmdt.pmdt053,
                 l_pmdt.pmdt054,l_pmdt.pmdt055,l_pmdt.pmdt088,l_pmdt.pmdt089)
                 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "pmdu_t"
          LET g_errparam.popup = FALSE
          CALL cl_err()
          RETURN
       END IF       
         
       #產生pmdv
       #161124-00048#11 mod-S
#       DECLARE pmdv_cs CURSOR FOR
#          SELECT * FROM pmdv_t WHERE pmdvent = g_enterprise AND pmdvdocno = l_pmdt.pmdtdocno AND pmdvseq = l_pmdt.pmdtseq AND pmdv005 = '10'
       DECLARE pmdv_cs CURSOR FOR
          SELECT pmdvent,pmdvsite,pmdvdocno,pmdvseq,pmdvseq1,
                 pmdv001,pmdv002,pmdv003,pmdv004,pmdv005,
                 pmdv006,pmdv011,pmdv012,pmdv013,pmdv014,
                 pmdv015,pmdv016,pmdv017,pmdv018,pmdv019,
                 pmdv900,pmdv999,pmdv200,pmdv201 
            FROM pmdv_t 
           WHERE pmdvent = g_enterprise AND pmdvdocno = l_pmdt.pmdtdocno AND pmdvseq = l_pmdt.pmdtseq AND pmdv005 = '10'
       #161124-00048#11 mod-E
       FOREACH pmdv_cs INTO l_pmdv.*
       
           LET l_pmdv.pmdv005 = '11'
           
           LET l_pmdv.pmdv018 = l_pmdt.pmdt019
           LET l_pmdv.pmdv019 = l_pmdt.pmdt020
           
           SELECT MAX(pmdvseq1)+1 INTO l_pmdv.pmdvseq1
            FROM pmdv_t
           WHERE pmdvent = g_enterprise
             AND pmdvdocno = l_pmdv.pmdvdocno
             AND pmdvseq = l_pmdv.pmdvseq
          IF cl_null(l_pmdv.pmdvseq1) OR l_pmdv.pmdvseq1 = 0 THEN
             LET l_pmdv.pmdvseq1 = 1
          END IF
       END FOREACH
       
    END FOREACH
    
    CALL cl_err_collect_show()
    
END FUNCTION

 
{</section>}
 
