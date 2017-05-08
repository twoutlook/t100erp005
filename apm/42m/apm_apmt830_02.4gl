#該程式未解開Section, 採用最新樣板產出!
{<section id="apmt830_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0007(2015-12-04 15:32:16), PR版次:0007(2017-01-19 16:30:26)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000060
#+ Filename...: apmt830_02
#+ Description: 依供應商資料要貨
#+ Creator....: 06137(2015-05-27 10:04:47)
#+ Modifier...: 06137 -SD/PR- 08172
 
{</section>}
 
{<section id="apmt830_02.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"
#160303-00028#20 2016/03/14 By sakura 修正自動帶出的單身，補貨規格說明沒有帶出
#Modify...........:No.160318-00005#37  2016/04/01  By 07900  修改重复错误讯息
#Modify...........:No.160318-00005#40  2016/04/22  By 07959  將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#Modify...........:No.170116-00018#1   2017/01/19  by 08172  要货单身配送仓赋值
#end add-point
#add-point:填寫註解說明(客製用) name="main.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="main.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
{</section>}
 
{<section id="apmt830_02.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
 TYPE type_g_rtdx_d RECORD
       sel LIKE type_t.chr500, 
   l_imaz003 LIKE type_t.chr500,       
   rtdx001 LIKE rtdx_t.rtdx001, 
   rtdx001_desc LIKE type_t.chr500,
   rtdx001_desc_desc LIKE type_t.chr500,   
   rtdx002 LIKE rtdx_t.rtdx002,
   imaz006 LIKE imaz_t.imaz006,   #150710-00016#3 加補貨規格說明   
   l_pmdb212 LIKE pmdb_t.pmdb212, 
   rtdx004 LIKE rtdx_t.rtdx004, 
   rtdx004_desc LIKE type_t.chr500,  
   l_pmdb213 LIKE pmdb_t.pmdb213, # 151104-00005#1 加参考价格   
   l_pmdb006 LIKE pmdb_t.pmdb006,    
   l_pmdb007 LIKE type_t.chr500, 
   pmdb007_desc LIKE type_t.chr500, 
   rtdx044 LIKE rtdx_t.rtdx044,
   rtdx044_desc LIKE type_t.chr500,   
   l_pmdb252 LIKE pmdb_t.pmdb252, 
   l_pmdb259 LIKE pmdb_t.pmdb259
       END RECORD
 
 
 
#模組變數(Module Variables)
DEFINE g_rtdx_d          DYNAMIC ARRAY OF type_g_rtdx_d #單身變數
DEFINE g_rtdx_d_t        type_g_rtdx_d                  #單身備份
DEFINE g_rtdx_d_o        type_g_rtdx_d                  #單身備份
DEFINE g_rtdx_d_mask_o   DYNAMIC ARRAY OF type_g_rtdx_d #單身變數
DEFINE g_rtdx_d_mask_n   DYNAMIC ARRAY OF type_g_rtdx_d #單身變數
 
 
DEFINE g_rec_b              LIKE type_t.num10           #161117-00022#1 161118 by lori mod:num5 to num10 
DEFINE g_wc                 STRING      
DEFINE g_wc2                STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                        #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10    
DEFINE l_ac                 LIKE type_t.num10             #目前處理的ARRAY CNT 
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_temp_idx           LIKE type_t.num10             #單身 所在筆數(暫存用)
DEFINE g_detail_idx         LIKE type_t.num10             #單身 所在筆數(所有資料)
DEFINE g_detail_cnt         LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_chk                BOOLEAN
DEFINE g_aw                 STRING                        #確定當下點擊的單身
DEFINE g_log1               STRING                        #log用
DEFINE g_log2               STRING                        #log用
 
#多table用wc
DEFINE g_wc_table           STRING
#end add-point
 
{</section>}
 
{<section id="apmt830_02.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_where_sql           STRING
DEFINE g_type                LIKE type_t.num5
DEFINE g_pmdasite            LIKE pmda_t.pmdasite    #要貨組織
DEFINE g_pmdadocdt           LIKE pmda_t.pmdadocdt   #要貨日期
DEFINE g_pmdadocno           LIKE pmda_t.pmdadocno   #要貨單號
DEFINE g_pmda                RECORD
       pmdadocdt             LIKE pmda_t.pmdadocdt,  #單據日期
       pmdasite              LIKE pmda_t.pmdasite,   #要貨組織
       pmda003               LIKE pmda_t.pmda003,    #要貨部門
       pmda201               LIKE pmda_t.pmda201,    #採購方式
       pmda202               LIKE pmda_t.pmda202,    #所屬品類
       pmda203               LIKE pmda_t.pmda203,    #需求組織
       pmda204               LIKE pmda_t.pmda204,    #採購組織
       pmda205               LIKE pmda_t.pmda205,    #配送中心
       pmda206               LIKE pmda_t.pmda206,    #配送倉
       pmda207               LIKE pmda_t.pmda207     #到貨日期  #151113-00003#11 151130 By pomelo add
                             END RECORD
DEFINE l_imaa009             LIKE imaa_t.imaa009     #所屬品類
DEFINE imaa009_desc          LIKE type_t.chr100      #品類說明
#DEFINE g_success             LIKE type_t.num5
#end add-point
 
{</section>}
 
{<section id="apmt830_02.other_dialog" >}

 
{</section>}
 
{<section id="apmt830_02.other_function" readonly="Y" >}

PUBLIC FUNCTION apmt830_02(--)
   #add-point:main段變數傳入
   p_type,
   p_pmdadocno,
   p_pmdadocdt,
   p_pmdasite
   #end add-point
   )
   #add-point:main段define
   DEFINE p_type          LIKE type_t.num5        #來源類別
   DEFINE p_pmdadocdt     LIKE pmda_t.pmdadocdt   #要貨日期
   DEFINE p_pmdadocno     LIKE pmda_t.pmdadocno   #要貨單號
   DEFINE p_pmdasite      LIKE pmda_t.pmdasite    #要貨組織
   #end add-point
   #add-point:main段define(客製用)

   #end add-point

   IF cl_null(p_pmdadocno) THEN
      RETURN
   END IF

   CREATE TEMP TABLE apmt830_02_tmp (
       sel           VARCHAR(1),            #選擇
       rtdx001       VARCHAR(40),         #商品編號
       rtdx002       VARCHAR(40),         #商品主條碼
       pmdb007       VARCHAR(10),         #要貨單位
       pmdb213       DECIMAL(20,6),         #151104-00005#1 增肌参考价格
       pmdb006       DECIMAL(20,6),         #要貨數量
       imaz003       VARCHAR(40),         #補貨條碼
       imaz006       VARCHAR(80),         #補貨規格說明 #150710-00016#3
       rtdx004       VARCHAR(10),         #包裝單位
       pmdb212       DECIMAL(20,6),         #要貨包裝數量
       rtdx044       VARCHAR(10),         #庫位編號
       pmdb252       DECIMAL(20,6),         #現有庫存
       pmdb259       DECIMAL(20,6),         #週平均銷量
       pmdb254       DECIMAL(20,6),         #前一週銷量
       pmdb255       DECIMAL(20,6),         #前二週銷量
       pmdb256       DECIMAL(20,6),         #前三週銷量
       pmdb257       DECIMAL(20,6),         #前四週銷量
       pmdb258       DECIMAL(20,6),         #要貨在途量  
       rtdx028       VARCHAR(10),         #採購中心
       rtdx029       VARCHAR(10));        #配送中心
  
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log

   #add-point:作業初始化

   #end add-point



   #LOCK CURSOR (identifier)


   #add-point:main段define_sql

   #end add-point
   LET g_forupd_sql = "SELECT rtdx001,rtdx002,rtdx004,rtdx044 FROM rtdx_t WHERE rtdxent=? AND rtdxsite=?
       AND rtdx001=? FOR UPDATE"
   #add-point:main段define_sql

   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apmt830_02_bcl CURSOR FROM g_forupd_sql



   #畫面開啟 (identifier)
   OPEN WINDOW w_apmt830_02 WITH FORM cl_ap_formpath("apm","apmt830_02")

   #瀏覽頁簽資料初始化
   CALL cl_ui_init()

   #程式初始化
   CALL apmt830_02_init()
   
   LET g_type = p_type
   LET g_pmdasite = p_pmdasite
   LET g_pmdadocdt = p_pmdadocdt
   LET g_pmdadocno = p_pmdadocno

   CALL apmt830_02_get_pmda()

   #LET g_success = TRUE
   #進入選單 Menu (="N")
   #CALL apmt830_02_ui_dialog()
   CALL apmt830_02_input()

   #畫面關閉
   CLOSE WINDOW w_apmt830_02




   #add-point:離開前
   DROP TABLE apmt830_02_tmp
   #end add-point
   #RETURN g_success
END FUNCTION

################################################################################

################################################################################
PRIVATE FUNCTION apmt830_02_input()
DEFINE l_cnt        LIKE type_t.num5
DEFINE l_success    LIKE type_t.num5
DEFINE l_where      STRING
DEFINE l_sql        STRING
DEFINE l_sys        LIKE type_t.num5   
DEFINE l_n          LIKE type_t.num5
DEFINE li_idx       LIKE type_t.num10

   CLEAR FORM
   CALL g_rtdx_d.clear()

   INITIALIZE g_wc TO NULL

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      INPUT BY NAME l_imaa009 ATTRIBUTE(WITHOUT DEFAULTS) 
         
         
         BEFORE INPUT
            LET l_imaa009 = g_pmda.pmda202
            DISPLAY BY NAME l_imaa009
            
         AFTER FIELD l_imaa009
            LET imaa009_desc = ''
            DISPLAY BY NAME imaa009_desc    
            IF NOT cl_null(l_imaa009) THEN                            
                 INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = l_imaa009
                  CALL cl_get_para(g_enterprise,g_site,'E-CIR-0001') RETURNING l_sys
                  LET g_chkparam.arg2 = l_sys
                  #160318-00025#40  2016/04/22  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "ast-00215:sub-01302|arti202|",cl_get_progname("arti202",g_lang,"2"),"|:EXEPROGarti202"
                  #160318-00025#40  2016/04/22  by pengxin  add(E)
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_rtax001_2") THEN
                     LET l_imaa009 = ''
                     #檢查失敗時後續處理
                     NEXT FIELD CURRENT
                  END IF
               
               IF NOT cl_null(g_pmda.pmda003) THEN
                  #檢查是否屬於arti204設置的部門品類
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n FROM rtaz_t
                   WHERE rtazent = g_enterprise
                     AND rtaz001 = g_prog
                     AND rtazstus = 'Y'
                  IF l_n > 0 THEN
                     #當rtaz_t設定該程式代號 代表 該程式受arti204的控管
                     SELECT COUNT(*) INTO l_n FROM rtay_t
                      WHERE rtayent = g_enterprise
                        AND rtay001 = g_pmda.pmda003
                        AND rtay002 = l_imaa009
                        AND rtaystus = 'Y'
                     IF l_n < 1 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'apr-00357'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()                  
                        LET l_imaa009 = ''
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF         
            
            CALL s_desc_get_rtaxl003_desc(l_imaa009) RETURNING imaa009_desc
            DISPLAY BY NAME imaa009_desc          

         BEFORE FIELD l_imaa009
            IF NOT cl_null(l_imaa009) THEN
               NEXT FIELD NEXT
            END IF

         #----<<l_imaa009>>----
         #Ctrlp:construct.c.limaa009
         ON ACTION controlp INFIELD l_imaa009
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = l_imaa009             #給予default值
			   CALL cl_get_para(g_enterprise,g_site,'E-CIR-0001') RETURNING l_sys #取得品類層級
            LET g_qryparam.arg1 = l_sys #

            SELECT COUNT(*) INTO l_n
              FROM rtaz_t
             WHERE rtazent = g_enterprise
               AND rtaz001 = g_prog
               AND rtazstus = 'Y'
            IF l_n > 0 THEN
               LET g_qryparam.where = " rtax001 IN (SELECT rtay002 FROM rtay_t WHERE rtayent = ",g_enterprise," ",
                                      "                AND rtay001 = '",g_pmda.pmda003,"' AND rtaystus = 'Y') "
            END IF
            CALL q_rtax001_3()                  #呼叫開窗
            LET l_imaa009 = g_qryparam.return1
            DISPLAY BY NAME l_imaa009
            CALL s_desc_get_rtaxl003_desc(l_imaa009) RETURNING imaa009_desc
            DISPLAY BY NAME imaa009_desc              
            NEXT FIELD l_imaa009                     #返回原欄位
                    
      END INPUT
      
      
      CONSTRUCT BY NAME g_wc ON imaf153,pmaal004         
         #一般欄位開窗相關處理
         #---------------------------<  Master  >---------------------------
         ON ACTION controlp INFIELD imaf153
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaf153  #顯示到畫面上
            NEXT FIELD imaf153                     #返回原欄位
            
      END CONSTRUCT
      
      INPUT ARRAY g_rtdx_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
         
         BEFORE INPUT
            CALL apmt830_02_b_fill()
            #CALL apmt830_02_set_entry_b("a")
            #CALL apmt830_02_set_no_entry_b("a")               
            LET g_rec_b = g_rtdx_d.getLength()
            DISPLAY "g_rec_b:",g_rec_b
            
         BEFORE ROW
            LET l_ac = ARR_CURR()
            LET g_rtdx_d_t.* = g_rtdx_d[l_ac].*
            LET g_rtdx_d_o.* = g_rtdx_d[l_ac].*            
            CALL apmt830_02_set_entry_b("a")
            CALL apmt830_02_set_no_entry_b("a")           

         #要貨包裝數量
         AFTER FIELD l_pmdb212
            IF NOT cl_ap_chk_range(g_rtdx_d[l_ac].l_pmdb212,"0","1","","","azz-00079",1) THEN
               NEXT FIELD l_pmdb212
            END IF
            
            IF NOT cl_null(g_rtdx_d[l_ac].l_pmdb212) THEN
               IF g_rtdx_d[l_ac].l_pmdb212 != g_rtdx_d_o.l_pmdb212 OR cl_null(g_rtdx_d_o.l_pmdb212) THEN                         
                  CALL apmt830_02_num_change()
               END IF
            END IF
            CALL apmt830_02_pmdb006_upd()  
            LET g_rtdx_d_o.l_pmdb212 = g_rtdx_d[l_ac].l_pmdb212
            LET g_rtdx_d_o.l_pmdb006 = g_rtdx_d[l_ac].l_pmdb006
            CALL apmt830_02_set_entry_b("a")
            CALL apmt830_02_set_no_entry_b("a")
         
         #要貨數量
         AFTER FIELD l_pmdb006
            IF NOT cl_ap_chk_range(g_rtdx_d[l_ac].l_pmdb006,"0","1","","","azz-00079",1) THEN
               NEXT FIELD l_pmdb006
            END IF                 
            
            IF NOT cl_null(g_rtdx_d[l_ac].l_pmdb006) THEN
               IF g_rtdx_d[l_ac].l_pmdb006 != g_rtdx_d_o.l_pmdb006 OR cl_null(g_rtdx_d_o.l_pmdb006) THEN          
                  CALL apmt830_02_num_change()
               END IF
            END IF
            CALL apmt830_02_pmdb006_upd()                
            LET g_rtdx_d_o.l_pmdb212 = g_rtdx_d[l_ac].l_pmdb212
            LET g_rtdx_d_o.l_pmdb006 = g_rtdx_d[l_ac].l_pmdb006
            CALL apmt830_02_set_entry_b("a")
            CALL apmt830_02_set_no_entry_b("a")

         ON CHANGE sel
            UPDATE apmt830_02_tmp
               SET sel = g_rtdx_d[l_ac].sel
             WHERE rtdx001 = g_rtdx_d[l_ac].rtdx001
               #AND rtdx002 = g_rtdx_d[l_ac].rtdx002
            #DISPLAY BY NAME g_rtdx_d[l_ac].sel
            CALL apmt830_02_set_entry_b("a")
            CALL apmt830_02_set_no_entry_b("a")             
         ON ROW CHANGE
            CALL apmt830_02_pmdb006_upd()               
      END INPUT
      
      ON ACTION data_ok
         #產生要貨明細單身
         CALL apmt830_02_gen_rtdx()      
                  
      ON ACTION check_all
         #採購明細單身全選
         CALL apmt830_02_check_all() 
      
      ON ACTION check_no_all
         #採購明細單身全不選
         CALL apmt830_02_check_no_all()
         
      ON ACTION gen_pmdb
         ##產生要貨明細單身
      
         #檢查單身的必輸欄位不可為空
         #CALL apmt830_02_b_fill()
         #LET g_rec_b = g_rtdx_d.getLength()
         
         IF g_rec_b > 0 THEN                             
            #IF NOT cl_ap_chk_range(g_rtdx_d[l_ac].l_pmdb212,"0","0","","","azz-00079",1) THEN
            #   NEXT FIELD l_pmdb212
            #END IF  
            #IF NOT cl_ap_chk_range(g_rtdx_d[l_ac].l_pmdb006,"0","0","","","azz-00079",1) THEN
            #   NEXT FIELD l_pmdb006
            #END IF    
            
            #150512-00026#1 Add By Ken 151214(S)
            IF l_ac > 0 THEN
               CALL apmt830_02_num_change()
               CALL apmt830_02_pmdb006_upd()
            END IF 
            #150512-00026#1 Add By Ken 151214(E)            
            
             FOR li_idx = 1 TO g_rtdx_d.getLength()
                IF g_rtdx_d[li_idx].sel = "Y" THEN
                   IF cl_null(g_rtdx_d[li_idx].l_pmdb212) THEN  
                      NEXT FIELD l_pmdb212
                   END IF
                   
                   IF cl_null(g_rtdx_d[li_idx].l_pmdb006) THEN
                      NEXT FIELD l_pmdb006
                   END IF
                END IF
             END FOR            
            
             LET g_success = TRUE
             IF NOT apmt830_02_gen_detail() THEN
                IF NOT cl_ask_confirm('apm-00284') THEN #產生失敗，是否繼續
                   LET g_success = FALSE                 
                   RETURN
                END IF
             ELSE
                IF cl_ask_confirm('apm-00285') THEN #產生成功，是否繼續
                   CALL g_rtdx_d.clear()
                   DELETE FROM apmt830_02_tmp
                   IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = SQLCA.sqlcode
                      LET g_errparam.extend = 'Del apmt830_02_tmp'
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                   END IF
                   CALL apmt830_02_gen_rtdx() 
                   CALL apmt830_02_set_entry_b("a")
                   CALL apmt830_02_set_no_entry_b("a")                                       
                   NEXT FIELD sel 
                ELSE
                   LET INT_FLAG = TRUE 
                   EXIT DIALOG
                END IF
             END IF
         ELSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'apm-00292'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()      
         END IF
          
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
   
   IF INT_FLAG THEN
      RETURN
   END IF
END FUNCTION

PRIVATE FUNCTION apmt830_02_b_fill()
DEFINE l_sql          STRING
DEFINE l_success      LIKE type_t.num5

    CALL g_rtdx_d.clear()
    LET l_ac = 1
    
    LET l_sql = "SELECT sel,         imaz003,     rtdx001,     ",
                "       t1.imaal003, t1.imaal004, imaz006,     ",          #刪rtdx002  #加imaz006
                "       0,          rtdx004,     t3.oocal003, pmdb213 ,",  #pmdb212  #增加参考价格151104-00005#1
                "       0,          pmdb007,     t2.oocal003, ",  #pmdb006 #Mod By baogc 20151104
                "       rtdx044,     t6.inayl003, pmdb252,    ",
                "       pmdb259     ",
                "  FROM apmt830_02_tmp ",
                "  LEFT OUTER JOIN imaal_t t1 ON t1.imaalent = ",g_enterprise,
                "                            AND t1.imaal001 = rtdx001",
                "                            AND t1.imaal002 = '",g_dlang,"'",
                "  LEFT OUTER JOIN oocal_t t2 ON t2.oocalent = ",g_enterprise,
                "                            AND t2.oocal001 = pmdb007",
                "                            AND t2.oocal002 = '",g_dlang,"'",
                "  LEFT OUTER JOIN oocal_t t3 ON t3.oocalent = ",g_enterprise,
                "                            AND t3.oocal001 = rtdx004",
                "                            AND t3.oocal002 = '",g_dlang,"'",
                "  LEFT OUTER JOIN inayl_t t6 ON t6.inaylent = ",g_enterprise,
                "                            AND t6.inayl001 = rtdx044",
                "                            AND t6.inayl002 = '",g_dlang,"'",
                "  ORDER BY rtdx001 "
    PREPARE apmt830_02_rtdx_pb FROM l_sql
    DECLARE apmt830_02_rtdx_cs CURSOR FOR apmt830_02_rtdx_pb
    FOREACH apmt830_02_rtdx_cs
       INTO g_rtdx_d[l_ac].sel,                   g_rtdx_d[l_ac].l_imaz003,           g_rtdx_d[l_ac].rtdx001,      
            g_rtdx_d[l_ac].rtdx001_desc,          g_rtdx_d[l_ac].rtdx001_desc_desc,   g_rtdx_d[l_ac].imaz006,
            #g_rtdx_d[l_ac].rtdx002,   
            g_rtdx_d[l_ac].l_pmdb212,             g_rtdx_d[l_ac].rtdx004,             g_rtdx_d[l_ac].rtdx004_desc, 
            g_rtdx_d[l_ac].l_pmdb213,   #增加参考价格 151104-00005#1
            g_rtdx_d[l_ac].l_pmdb006,             g_rtdx_d[l_ac].l_pmdb007,           g_rtdx_d[l_ac].pmdb007_desc,                         
            g_rtdx_d[l_ac].rtdx044,               g_rtdx_d[l_ac].rtdx044_desc,        g_rtdx_d[l_ac].l_pmdb252,
            g_rtdx_d[l_ac].l_pmdb259
                        
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "Foreach apmt830_02_rtdx_cs"
          LET g_errparam.popup = TRUE
          CALL cl_err()
          EXIT FOREACH
       END IF
       
             
       LET l_ac = l_ac + 1
       IF l_ac > g_max_rec AND g_error_show = 1 THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code =  9035
          LET g_errparam.extend =  ''
          LET g_errparam.popup = TRUE
          CALL cl_err()
          EXIT FOREACH
       END IF
    END FOREACH
    
    CALL g_rtdx_d.deleteElement(g_rtdx_d.getLength()) 
    LET l_ac = g_rtdx_d.getLength()    
    
   
   #DEFINE p_wc2    STRING
   ##add-point:b_fill段define
   #
   ##end add-point
   ##add-point:b_fill段define(客製用)
   #
   ##end add-point
   #
   #IF cl_null(p_wc2) THEN
   #   LET p_wc2 = " 1=1"
   #END IF
   #
   ##add-point:b_fill段sql之前
   #
   ##end add-point
   #
   #LET g_sql = "SELECT  UNIQUE t0.rtdx001,t0.rtdx002,t0.rtdx004,t0.rtdx044 ,t1.imaal003 ,t3.oocal003 FROM rtdx_t t0",
   #
   #            "",
   #                           " LEFT JOIN imaal_t t1 ON t1.imaalent='"||g_enterprise||"' AND t1.imaal001=t0.rtdx001 AND t1.imaal002='"||g_dlang||"' ",
   #            " LEFT JOIN oocal_t t3 ON t3.oocalent='"||g_enterprise||"' AND t3.oocal001=t0.rtdx004 AND t3.oocal002='"||g_dlang||"' ",
   #
   #            " WHERE t0.rtdxent= ?  AND t0. rtdxsite= ?  AND  1=1 AND (", p_wc2, ") "
   ##add-point:b_fill段sql wc
   #
   ##end add-point
   #LET g_sql = g_sql, cl_sql_add_filter("rtdx_t"),
   #                   " ORDER BY t0.rtdx001"
   #
   ##add-point:b_fill段sql之後
   #
   ##end add-point
   #
   ##LET g_sql = cl_sql_add_tabid(g_sql,"rtdx_t")            #WC重組
   #LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #PREPARE apmt830_02_pb FROM g_sql
   #DECLARE b_fill_curs CURSOR FOR apmt830_02_pb
   #
   #OPEN b_fill_curs USING g_enterprise, g_site
   #
   #CALL g_rtdx_d.clear()
   #
   #
   #LET g_cnt = l_ac
   #LET l_ac = 1
   #ERROR "Searching!"
   #
   #FOREACH b_fill_curs INTO g_rtdx_d[l_ac].rtdx001,g_rtdx_d[l_ac].rtdx002,g_rtdx_d[l_ac].rtdx004,g_rtdx_d[l_ac].rtdx044,
   #    g_rtdx_d[l_ac].rtdx001_desc,g_rtdx_d[l_ac].rtdx004_desc
   #   IF SQLCA.sqlcode THEN
   #      INITIALIZE g_errparam TO NULL
   #      LET g_errparam.extend = "FOREACH:"
   #      LET g_errparam.code   = SQLCA.sqlcode
   #      LET g_errparam.popup  = TRUE
   #      CALL cl_err()
   #      EXIT FOREACH
   #   END IF
   #
   #   #add-point:b_fill段資料填充
   #
   #   #end add-point
   #
   #   CALL apmt830_02_detail_show()
   #
   #   IF l_ac > g_max_rec THEN
   #      IF g_error_show = 1 THEN
   #         INITIALIZE g_errparam TO NULL
   #         LET g_errparam.extend = l_ac
   #         LET g_errparam.code   = 9035
   #         LET g_errparam.popup  = TRUE
   #         CALL cl_err()
   #      END IF
   #      EXIT FOREACH
   #   END IF
   #
   #   LET l_ac = l_ac + 1
   #
   #END FOREACH
   #
   #LET g_error_show = 0
   #
   #
   #
   #CALL g_rtdx_d.deleteElement(g_rtdx_d.getLength())
   #
   #
   ##將key欄位填到每個page
   #FOR l_ac = 1 TO g_rtdx_d.getLength()
   #
   #   #add-point:b_fill段key值相關欄位
   #
   #   #end add-point
   #END FOR
   #
   #IF g_cnt > g_rtdx_d.getLength() THEN
   #   LET l_ac = g_rtdx_d.getLength()
   #ELSE
   #   LET l_ac = g_cnt
   #END IF
   #LET g_cnt = l_ac
   #
   ##遮罩相關處理
   #FOR l_ac = 1 TO g_rtdx_d.getLength()
   #   LET g_rtdx_d_mask_o[l_ac].* =  g_rtdx_d[l_ac].*
   #   CALL apmt830_02_rtdx_t_mask()
   #   LET g_rtdx_d_mask_n[l_ac].* =  g_rtdx_d[l_ac].*
   #END FOR
   #
   #
   #
   ##add-point:b_fill段資料填充(其他單身)
   #
   ##end add-point
   #
   #ERROR ""
   #
   #LET g_detail_cnt = g_rtdx_d.getLength()
   #DISPLAY g_detail_idx TO FORMONLY.idx
   #DISPLAY g_detail_cnt TO FORMONLY.cnt
   #
   #CLOSE b_fill_curs
   #FREE apmt830_02_pb

END FUNCTION

PRIVATE FUNCTION apmt830_02_default_search()
   DEFINE li_idx  LIKE type_t.num10
   DEFINE li_cnt  LIKE type_t.num10
   DEFINE ls_wc   STRING
   #add-point:default_search段define

   #end add-point
   #add-point:default_search段define(客製用)

   #end add-point

   #add-point:default_search段開始前

   #end add-point

   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " rtdx001 = '", g_argv[01], "' AND "
   END IF



   #add-point:default_search段after sql

   #end add-point

   IF NOT cl_null(ls_wc) THEN
      LET ls_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_wc2 = ls_wc
   ELSE
      LET g_wc2 = " 1=1"
      #預設查詢條件
      LET g_wc2 = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc2) THEN
         LET g_wc2 = " 1=1"
      END IF
   END IF

   #add-point:default_search段結束前

   #end add-point

END FUNCTION

PRIVATE FUNCTION apmt830_02_delete()
   DEFINE li_idx          LIKE type_t.num10
   DEFINE li_ac_t         LIKE type_t.num10
   DEFINE li_detail_tmp   LIKE type_t.num10
   DEFINE l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE l_vars          DYNAMIC ARRAY OF STRING
   DEFINE l_fields        DYNAMIC ARRAY OF STRING
   #add-point:delete段define

   #end add-point
   #add-point:delete段define(客製用)

   #end add-point

   #add-point:單身刪除前

   #end add-point

   CALL s_transaction_begin()

   LET li_ac_t = l_ac

   LET li_detail_tmp = g_detail_idx

   #lock所有所選資料
   FOR li_idx = 1 TO g_rtdx_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN
         #確定是否有被鎖定
         IF NOT apmt830_02_lock_b("rtdx_t") THEN
            #已被他人鎖定
            RETURN
         END IF
      END IF
   END FOR

   #add-point:單身刪除詢問前

   #end add-point

   #詢問是否確定刪除所選資料
   IF NOT cl_ask_del_detail() THEN
      RETURN
   END IF

   FOR li_idx = 1 TO g_rtdx_d.getLength()
      IF g_rtdx_d[li_idx].rtdx001 IS NOT NULL

         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN

         #add-point:單身刪除前

         #end add-point

         DELETE FROM rtdx_t
          WHERE rtdxent = g_enterprise AND rtdxsite = g_site AND
                rtdx001 = g_rtdx_d[li_idx].rtdx001

         #add-point:單身刪除中

         #end add-point

         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "rtdx_t"
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            RETURN
         ELSE
            LET g_detail_cnt = g_detail_cnt-1
            LET l_ac = li_idx




            #add-point:單身同步刪除前(同層table)

            #end add-point
            LET g_detail_idx = li_idx
                           INITIALIZE gs_keys TO NULL
               LET gs_keys[1] = g_rtdx_d_t.rtdx001

            #add-point:單身同步刪除中(同層table)

            #end add-point
                           CALL apmt830_02_delete_b('rtdx_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table)

            #end add-point
         END IF
      END IF

   END FOR

   LET g_detail_idx = li_detail_tmp

   #add-point:單身刪除後

   #end add-point

   LET l_ac = li_ac_t

   #刷新資料
   CALL apmt830_02_b_fill()

END FUNCTION

PRIVATE FUNCTION apmt830_02_delete_b(ps_table,ps_keys_bak,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:delete_b段define

   #end add-point
   #add-point:delete_b段define(客製用)

   #end add-point

   #判斷是否是同一群組的table
   LET ls_group = "rtdx_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'rtdx_t' THEN
         #add-point:delete_b段刪除前

         #end add-point

         DELETE FROM rtdx_t
          WHERE rtdxent = g_enterprise AND rtdxsite = g_site AND
            rtdx001 = ps_keys_bak[1]

         #add-point:delete_b段刪除中

         #end add-point

         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = ""
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = FALSE
            CALL cl_err()
         END IF
      END IF

      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN
         CALL g_rtdx_d.deleteElement(li_idx)
      END IF


      #add-point:delete_b段刪除後

      #end add-point

      RETURN
   END IF



END FUNCTION

PRIVATE FUNCTION apmt830_02_detail_show()
   #add-point:show段define

   #end add-point
   #add-point:detail_show段define(客製用)

   #end add-point

   #add-point:detail_show段之前

   #end add-point



   #帶出公用欄位reference值page1




   #讀入ref值
   #add-point:show段單身reference

   #end add-point


   #add-point:detail_show段之後

   #end add-point

END FUNCTION

PRIVATE FUNCTION apmt830_02_init()
   #add-point:init段define

   #end add-point
   #add-point:init段define(客製用)

   #end add-point

   CALL g_rtdx_d.clear()
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()
   LET g_error_show = 1

   #add-point:畫面資料初始化
   #隐藏
   CALL cl_set_comp_visible('sel',FALSE)
   CALL cl_set_comp_visible('check_all',FALSE)
   CALL cl_set_comp_visible('check_no_all',FALSE)
   #end add-point

   #CALL apmt830_02_default_search()

END FUNCTION

PRIVATE FUNCTION apmt830_02_insert()
   #add-point:delete段define

   #end add-point
   #add-point:insert段define(客製用)

   #end add-point

   #add-point:單身新增前

   #end add-point

   LET g_insert = 'Y'
   #CALL apmt830_02_modify()

   #add-point:單身新增後

   #end add-point

END FUNCTION

PRIVATE FUNCTION apmt830_02_insert_b(ps_table,ps_keys,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:insert_b段define

   #end add-point
   #add-point:insert_b段define(客製用)

   #end add-point

   #判斷是否是同一群組的table
   LET ls_group = "rtdx_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN

      #add-point:insert_b段新增前

      #end add-point
      #INSERT INTO rtdx_t
      #            (rtdxent, rtdxsite,
      #             rtdx001
      #             ,rtdx002,rtdx004,rtdx044)
      #      VALUES(g_enterprise, g_site,
      #             ps_keys[1]
      #             ,g_rtdx_d[l_ac].rtdx002,g_rtdx_d[l_ac].rtdx004,g_rtdx_d[l_ac].rtdx044)
      #add-point:insert_b段新增中

      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "rtdx_t"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = FALSE
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後

      #end add-point
   #END IF



END FUNCTION

PRIVATE FUNCTION apmt830_02_lock_b(ps_table)
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define

   #end add-point
   #add-point:lock_b段define(客製用)

   #end add-point

   #先刷新資料
   #CALL apmt830_02_b_fill()

   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "rtdx_t"

   IF ls_group.getIndexOf(ps_table,1) THEN

      OPEN apmt830_02_bcl USING g_enterprise, g_site,
                                       g_rtdx_d[g_detail_idx].rtdx001

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "apmt830_02_bcl"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         RETURN FALSE
      END IF

   END IF



   RETURN TRUE

END FUNCTION

PRIVATE FUNCTION apmt830_02_modify()
 #  DEFINE  l_cmd                  LIKE type_t.chr1
 #  DEFINE  l_ac_t                 LIKE type_t.num10               #未取消的ARRAY CNT
 #  DEFINE  l_n                    LIKE type_t.num10               #檢查重複用
 #  DEFINE  l_cnt                  LIKE type_t.num10               #檢查重複用
 #  DEFINE  l_lock_sw              LIKE type_t.chr1                #單身鎖住否
 #  DEFINE  l_allow_insert         LIKE type_t.num5                #可新增否
 #  DEFINE  l_allow_delete         LIKE type_t.num5                #可刪除否
 #  DEFINE  l_count                LIKE type_t.num10
 #  DEFINE  l_i                    LIKE type_t.num10
 #  DEFINE  ls_return              STRING
 #  DEFINE  l_var_keys             DYNAMIC ARRAY OF STRING
 #  DEFINE  l_field_keys           DYNAMIC ARRAY OF STRING
 #  DEFINE  l_vars                 DYNAMIC ARRAY OF STRING
 #  DEFINE  l_fields               DYNAMIC ARRAY OF STRING
 #  DEFINE  l_var_keys_bak         DYNAMIC ARRAY OF STRING
 #  DEFINE  li_reproduce           LIKE type_t.num10
 #  DEFINE  li_reproduce_target    LIKE type_t.num10
 #  DEFINE  lb_reproduce           BOOLEAN
 #  #add-point:modify段define
 #
 #  #end add-point
 #  #add-point:modify段define(客製用)
 #
 #  #end add-point
 #  LET g_action_choice = ""
 #
 #  LET g_qryparam.state = "i"
 #
 #  LET l_allow_insert = cl_auth_detail_input("insert")
 #  LET l_allow_delete = cl_auth_detail_input("delete")
 #
 #  #add-point:modify開始前
 #
 #  #end add-point
 #
 #  LET INT_FLAG = FALSE
 #  LET lb_reproduce = FALSE
 #
 #  #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
 #  #因此先行關閉, 若有需要可於下方add-point中自行開啟
 #  CALL cl_mask_set_no_entry()
 #
 #  #add-point:modify段修改前
 #
 #  #end add-point
 #
 #  DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 #
 #     #Page1 預設值產生於此處
 #     INPUT ARRAY g_rtdx_d FROM s_detail1.*
 #         ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
 #                 INSERT ROW = l_allow_insert,
 #                 DELETE ROW = l_allow_delete,
 #                 APPEND ROW = l_allow_insert)
 #
 #        #自訂ACTION(detail_input,page_1)
 #
 #
 #        BEFORE INPUT
 #           IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN
 #             CALL FGL_SET_ARR_CURR(g_rtdx_d.getLength()+1)
 #             LET g_insert = 'N'
 #          END IF
 #
 #           CALL apmt830_02_b_fill()
 #           LET g_detail_cnt = g_rtdx_d.getLength()
 #
 #        BEFORE ROW
 #           #add-point:modify段before row
 #
 #           #end add-point
 #           LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
 #           LET l_cmd = ''
 #           LET l_ac = g_detail_idx
 #           LET l_lock_sw = 'N'            #DEFAULT
 #           LET l_n = ARR_COUNT()
 #           DISPLAY l_ac TO FORMONLY.idx
 #           DISPLAY g_rtdx_d.getLength() TO FORMONLY.cnt
 #
 #           CALL s_transaction_begin()
 #           LET g_detail_cnt = g_rtdx_d.getLength()
 #
 #           IF g_detail_cnt >= l_ac
 #              AND g_rtdx_d[l_ac].rtdx001 IS NOT NULL
 #
 #           THEN
 #              LET l_cmd='u'
 #              LET g_rtdx_d_t.* = g_rtdx_d[l_ac].*  #BACKUP
 #              LET g_rtdx_d_o.* = g_rtdx_d[l_ac].*  #BACKUP
 #              IF NOT apmt830_02_lock_b("rtdx_t") THEN
 #                 LET l_lock_sw='Y'
 #              ELSE
 #                 FETCH apmt830_02_bcl INTO g_rtdx_d[l_ac].rtdx001,g_rtdx_d[l_ac].rtdx002,g_rtdx_d[l_ac].rtdx004,
 #                     g_rtdx_d[l_ac].rtdx044
 #                 IF SQLCA.sqlcode THEN
 #                    INITIALIZE g_errparam TO NULL
 #                    LET g_errparam.extend = g_rtdx_d_t.rtdx001
 #                    LET g_errparam.code   = SQLCA.sqlcode
 #                    LET g_errparam.popup  = TRUE
 #                    CALL cl_err()
 #                    LET l_lock_sw = "Y"
 #                 END IF
 #
 #                 #遮罩相關處理
 #                 LET g_rtdx_d_mask_o[l_ac].* =  g_rtdx_d[l_ac].*
 #                 CALL apmt830_02_rtdx_t_mask()
 #                 LET g_rtdx_d_mask_n[l_ac].* =  g_rtdx_d[l_ac].*
 #
 #                 CALL apmt830_02_detail_show()
 #                 CALL cl_show_fld_cont()
 #              END IF
 #           ELSE
 #              LET l_cmd='a'
 #           END IF
 #           #add-point:modify段before row
 #
 #           #end add-point
 #           #其他table資料備份(確定是否更改用)
 #
 #           #其他table進行lock
 #
 #
 #        BEFORE INSERT
 #
 #           CALL s_transaction_begin()
 #           LET l_n = ARR_COUNT()
 #           LET l_cmd = 'a'
 #           INITIALIZE g_rtdx_d_t.* TO NULL
 #           INITIALIZE g_rtdx_d_o.* TO NULL
 #           INITIALIZE g_rtdx_d[l_ac].* TO NULL
 #           #公用欄位給值(單身)
 #
 #           #自定義預設值(單身1)
 #                 LET g_rtdx_d[l_ac].sel = "N"
 #     LET g_rtdx_d[l_ac].pmdb006 = "0"
 #     LET g_rtdx_d[l_ac].pmdb212 = "0"
 #     LET g_rtdx_d[l_ac].pmdb252 = "0"
 #
 #           #add-point:modify段before備份
 #
 #           #end add-point
 #           LET g_rtdx_d_t.* = g_rtdx_d[l_ac].*     #新輸入資料
 #           LET g_rtdx_d_o.* = g_rtdx_d[l_ac].*     #新輸入資料
 #           CALL cl_show_fld_cont()
 #           CALL apmt830_02_set_entry_b("a")
 #           CALL apmt830_02_set_no_entry_b("a")
 #           IF lb_reproduce THEN
 #              LET lb_reproduce = FALSE
 #              LET g_rtdx_d[li_reproduce_target].* = g_rtdx_d[li_reproduce].*
 #
 #              LET g_rtdx_d[g_rtdx_d.getLength()].rtdx001 = NULL
 #
 #           END IF
 #
 #           #add-point:modify段before insert
 #
 #           #end add-point
 #
 #        AFTER INSERT
 #           IF INT_FLAG THEN
 #              INITIALIZE g_errparam TO NULL
 #              LET g_errparam.extend = ''
 #              LET g_errparam.code   = 9001
 #              LET g_errparam.popup  = FALSE
 #              CALL cl_err()
 #              LET INT_FLAG = 0
 #              CANCEL INSERT
 #           END IF
 #
 #           LET l_count = 1
 #           SELECT COUNT(*) INTO l_count FROM rtdx_t
 #            WHERE rtdxent = g_enterprise AND rtdxsite = g_site AND rtdx001 = g_rtdx_d[l_ac].rtdx001
 #
 #
 #           #資料未重複, 插入新增資料
 #           IF l_count = 0 THEN
 #              #add-point:單身新增前
 #
 #              #end add-point
 #
 #                             INITIALIZE gs_keys TO NULL
 #              LET gs_keys[1] = g_rtdx_d[g_detail_idx].rtdx001
 #              CALL apmt830_02_insert_b('rtdx_t',gs_keys,"'1'")
 #
 #              #add-point:單身新增後
 #
 #              #end add-point
 #           ELSE
 #              INITIALIZE g_errparam TO NULL
 #              LET g_errparam.extend = 'INSERT'
 #              LET g_errparam.code   = "std-00006"
 #              LET g_errparam.popup  = TRUE
 #              CALL cl_err()
 #              INITIALIZE g_rtdx_d[l_ac].* TO NULL
 #              CANCEL INSERT
 #           END IF
 #
 #           IF SQLCA.SQLcode  THEN
 #              INITIALIZE g_errparam TO NULL
 #              LET g_errparam.extend = "rtdx_t"
 #              LET g_errparam.code   = SQLCA.sqlcode
 #              LET g_errparam.popup  = TRUE
 #              CALL cl_err()
 #              CANCEL INSERT
 #           ELSE
 #              #先刷新資料
 #              #CALL apmt830_02_b_fill()
 #              #資料多語言用-增/改
 #
 #              #add-point:input段-after_insert
 #
 #              #end add-point
 #              ##ERROR 'INSERT O.K'
 #              LET g_detail_cnt = g_detail_cnt + 1
 #
 #              LET g_wc2 = g_wc2, " OR (rtdx001 = '", g_rtdx_d[l_ac].rtdx001, "' "
 #
 #                                 ,")"
 #           END IF
 #
 #        BEFORE DELETE                            #是否取消單身
 #           IF l_cmd = 'a' THEN
 #              LET l_cmd='d'
 #           ELSE
 #              #add-point:單身刪除ask前
 #
 #              #end add-point
 #
 #              IF NOT cl_ask_del_detail() THEN
 #                 CANCEL DELETE
 #              END IF
 #              IF l_lock_sw = "Y" THEN
 #                 INITIALIZE g_errparam TO NULL
 #                 LET g_errparam.extend = ""
 #                 LET g_errparam.code   = -263
 #                 LET g_errparam.popup  = TRUE
 #                 CALL cl_err()
 #                 CANCEL DELETE
 #              END IF
 #
 #              #add-point:單身刪除前
 #
 #              #end add-point
 #
 #              DELETE FROM rtdx_t
 #               WHERE rtdxent = g_enterprise AND rtdxsite = g_site AND
 #                     rtdx001 = g_rtdx_d_t.rtdx001
 #
 #
 #              #add-point:單身刪除中
 #
 #              #end add-point
 #
 #              IF SQLCA.sqlcode THEN
 #                 INITIALIZE g_errparam TO NULL
 #                 LET g_errparam.extend = "rtdx_t"
 #                 LET g_errparam.code   = SQLCA.sqlcode
 #                 LET g_errparam.popup  = TRUE
 #                 CALL cl_err()
 #                 CANCEL DELETE
 #              ELSE
 #                 LET g_detail_cnt = g_detail_cnt-1
 #
 #                 #add-point:單身刪除後
 #
 #                 #end add-point
 #                 #修改歷程記錄(刪除)
 #                 CALL apmt830_02_set_pk_array()
 #                 IF NOT cl_log_modified_record('','') THEN
 #                 ELSE
 #                 END IF
 #              END IF
 #              CLOSE apmt830_02_bcl
 #              #add-point:單身關閉bcl
 #
 #              #end add-point
 #              LET l_count = g_rtdx_d.getLength()
 #                             INITIALIZE gs_keys TO NULL
 #              LET gs_keys[1] = g_rtdx_d_t.rtdx001
 #
 #              #應用 a47 樣板自動產生(Version:2)
 #     #刪除相關文件
 #     CALL apmt830_02_set_pk_array()
 #     #add-point:相關文件刪除前
 #
 #     #end add-point
 #     CALL cl_doc_remove()
 #
 #
 #
 #           END IF
 #
 #        AFTER DELETE
 #           IF l_cmd <> 'd' THEN
 #              #add-point:單身刪除後2
 #
 #              #end add-point
 #                             CALL apmt830_02_delete_b('rtdx_t',gs_keys,"'1'")
 #           END IF
 #           #如果是最後一筆
 #           IF l_ac = (g_rtdx_d.getLength() + 1) THEN
 #              CALL FGL_SET_ARR_CURR(l_ac-1)
 #           END IF
 #
 #                 #應用 a01 樣板自動產生(Version:1)
 #        BEFORE FIELD sel
 #           #add-point:BEFORE FIELD sel
 #
 #           #END add-point
 #
 #        #應用 a02 樣板自動產生(Version:1)
 #        AFTER FIELD sel
 #
 #           #add-point:AFTER FIELD sel
 #
 #           #END add-point
 #
 #
 #        #應用 a04 樣板自動產生(Version:2)
 #        ON CHANGE sel
 #           #add-point:ON CHANGE sel
 #
 #           #END add-point
 #
 #        #應用 a02 樣板自動產生(Version:1)
 #        AFTER FIELD rtdx001
 #
 #           #add-point:AFTER FIELD rtdx001
 #           #應用 a05 樣板自動產生(Version:2)
 #           #確認資料無重複
 #           IF  g_rtdx_d[g_detail_idx].rtdx001 IS NOT NULL THEN
 #              IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_rtdx_d[g_detail_idx].rtdx001 != g_rtdx_d_t.rtdx001)) THEN
 #                 IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM rtdx_t WHERE "||"rtdxent = '" ||g_enterprise|| "' AND rtdxsite = '" ||g_site|| "' AND "||"rtdx001 = '"||g_rtdx_d[g_detail_idx].rtdx001 ||"'",'std-00004',0) THEN
 #                    NEXT FIELD CURRENT
 #                 END IF
 #              END IF
 #           END IF
 #
 #
 #           INITIALIZE g_ref_fields TO NULL
 #           LET g_ref_fields[1] = g_rtdx_d[l_ac].rtdx001
 #           CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
 #           LET g_rtdx_d[l_ac].rtdx001_desc = '', g_rtn_fields[1] , ''
 #           DISPLAY BY NAME g_rtdx_d[l_ac].rtdx001_desc
 #
 #
 #           #END add-point
 #
 #
 #        #應用 a01 樣板自動產生(Version:1)
 #        BEFORE FIELD rtdx001
 #           #add-point:BEFORE FIELD rtdx001
 #
 #           #END add-point
 #
 #        #應用 a04 樣板自動產生(Version:2)
 #        ON CHANGE rtdx001
 #           #add-point:ON CHANGE rtdx001
 #
 #           #END add-point
 #
 #        #應用 a01 樣板自動產生(Version:1)
 #        BEFORE FIELD rtdx002
 #           #add-point:BEFORE FIELD rtdx002
 #
 #           #END add-point
 #
 #        #應用 a02 樣板自動產生(Version:1)
 #        AFTER FIELD rtdx002
 #
 #           #add-point:AFTER FIELD rtdx002
 #
 #           #END add-point
 #
 #
 #        #應用 a04 樣板自動產生(Version:2)
 #        ON CHANGE rtdx002
 #           #add-point:ON CHANGE rtdx002
 #
 #           #END add-point
 #
 #        #應用 a02 樣板自動產生(Version:1)
 #        AFTER FIELD pmdb007
 #
 #           #add-point:AFTER FIELD pmdb007
 #           IF NOT cl_null(g_rtdx_d[l_ac].pmdb007) THEN
#應用 a17 樣板自動產生(Version:2)
  #             #欄位存在檢查
  #             #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
  #             INITIALIZE g_chkparam.* TO NULL
  #
  #             #設定g_chkparam.*的參數
  #             LET g_chkparam.arg1 = g_rtdx_d[l_ac].pmdb007
  #
  #
  #             #呼叫檢查存在並帶值的library
  #             IF cl_chk_exist("v_ooca001") THEN
  #                #檢查成功時後續處理
  #             ELSE
  #                #檢查失敗時後續處理
  #                NEXT FIELD CURRENT
  #             END IF
  #
  #
  #          END IF
  #          INITIALIZE g_ref_fields TO NULL
  #          LET g_ref_fields[1] = g_rtdx_d[l_ac].pmdb007
  #          CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
  #          LET g_rtdx_d[l_ac].pmdb007_desc = '', g_rtn_fields[1] , ''
  #          DISPLAY BY NAME g_rtdx_d[l_ac].pmdb007_desc
  #
  #
  #          #END add-point
  #
  #
  #       #應用 a01 樣板自動產生(Version:1)
  #       BEFORE FIELD pmdb007
  #          #add-point:BEFORE FIELD pmdb007
  #
  #          #END add-point
  #
  #       #應用 a04 樣板自動產生(Version:2)
  #       ON CHANGE pmdb007
  #          #add-point:ON CHANGE pmdb007
  #
  #          #END add-point
  #
  #       #應用 a02 樣板自動產生(Version:1)
  #       AFTER FIELD pmdb006
  #          #應用 a15 樣板自動產生(Version:2)
  #          #確認欄位值在特定區間內
  #          IF NOT cl_ap_chk_range(g_rtdx_d[l_ac].pmdb006,"0.000","0","","","azz-00079",1) THEN
  #             NEXT FIELD pmdb006
  #          END IF
  #
  #
  #          #add-point:AFTER FIELD pmdb006
  #          IF NOT cl_null(g_rtdx_d[l_ac].pmdb006) THEN
  #          END IF
  #
  #
  #          #END add-point
  #
  #
  #       #應用 a01 樣板自動產生(Version:1)
  #       BEFORE FIELD pmdb006
  #          #add-point:BEFORE FIELD pmdb006
  #
  #          #END add-point
  #
  #       #應用 a04 樣板自動產生(Version:2)
  #       ON CHANGE pmdb006
  #          #add-point:ON CHANGE pmdb006
  #
  #          #END add-point
  #
  #       #應用 a02 樣板自動產生(Version:1)
  #       AFTER FIELD rtdx004
  #
  #          #add-point:AFTER FIELD rtdx004
  #          INITIALIZE g_ref_fields TO NULL
  #          LET g_ref_fields[1] = g_rtdx_d[l_ac].rtdx004
  #          CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
  #          LET g_rtdx_d[l_ac].rtdx004_desc = '', g_rtn_fields[1] , ''
  #          DISPLAY BY NAME g_rtdx_d[l_ac].rtdx004_desc
  #
  #
  #          #END add-point
  #
  #
  #       #應用 a01 樣板自動產生(Version:1)
  #       BEFORE FIELD rtdx004
  #          #add-point:BEFORE FIELD rtdx004
  #
  #          #END add-point
  #
  #       #應用 a04 樣板自動產生(Version:2)
  #       ON CHANGE rtdx004
  #          #add-point:ON CHANGE rtdx004
  #
  #          #END add-point
  #
  #       #應用 a01 樣板自動產生(Version:1)
  #       BEFORE FIELD pmdb212
  #          #add-point:BEFORE FIELD pmdb212
  #
  #          #END add-point
  #
  #       #應用 a02 樣板自動產生(Version:1)
  #       AFTER FIELD pmdb212
  #
  #          #add-point:AFTER FIELD pmdb212
  #
  #          #END add-point
  #
  #
  #       #應用 a04 樣板自動產生(Version:2)
  #       ON CHANGE pmdb212
  #          #add-point:ON CHANGE pmdb212
  #
  #          #END add-point
  #
  #       #應用 a01 樣板自動產生(Version:1)
  #       BEFORE FIELD rtdx044
  #          #add-point:BEFORE FIELD rtdx044
  #
  #          #END add-point
  #
  #       #應用 a02 樣板自動產生(Version:1)
  #       AFTER FIELD rtdx044
  #
  #          #add-point:AFTER FIELD rtdx044
  #
  #          #END add-point
  #
  #
  #       #應用 a04 樣板自動產生(Version:2)
  #       ON CHANGE rtdx044
  #          #add-point:ON CHANGE rtdx044
  #
  #          #END add-point
  #
  #       #應用 a01 樣板自動產生(Version:1)
  #       BEFORE FIELD pmdb252
  #          #add-point:BEFORE FIELD pmdb252
  #
  #          #END add-point
  #
  #       #應用 a02 樣板自動產生(Version:1)
  #       AFTER FIELD pmdb252
  #
  #          #add-point:AFTER FIELD pmdb252
  #
  #          #END add-point
  #
  #
  #       #應用 a04 樣板自動產生(Version:2)
  #       ON CHANGE pmdb252
  #          #add-point:ON CHANGE pmdb252
  #
  #          #END add-point
  #
  #       #應用 a01 樣板自動產生(Version:1)
  #       BEFORE FIELD pmdb259
  #          #add-point:BEFORE FIELD pmdb259
  #
  #          #END add-point
  #
  #       #應用 a02 樣板自動產生(Version:1)
  #       AFTER FIELD pmdb259
  #
  #          #add-point:AFTER FIELD pmdb259
  #
  #          #END add-point
  #
  #
  #       #應用 a04 樣板自動產生(Version:2)
  #       ON CHANGE pmdb259
  #          #add-point:ON CHANGE pmdb259
  #
  #          #END add-point
  #
  #
  #                #Ctrlp:input.c.page1.sel
# #        #應用 a03 樣板自動產生(Version:2)
  #       ON ACTION controlp INFIELD sel
  #          #add-point:ON ACTION controlp INFIELD sel
  #
  #          #END add-point
  #
  #       #Ctrlp:input.c.page1.rtdx001
  #       #應用 a03 樣板自動產生(Version:2)
  #       ON ACTION controlp INFIELD rtdx001
  #          #add-point:ON ACTION controlp INFIELD rtdx001
  #          #應用 a07 樣板自動產生(Version:2)
  #          #開窗i段
  #          INITIALIZE g_qryparam.* TO NULL
  #          LET g_qryparam.state = 'i'
  #          LET g_qryparam.reqry = FALSE
  #
  #          LET g_qryparam.default1 = g_rtdx_d[l_ac].rtdx001             #給予default值
  #          LET g_qryparam.default2 = "" #g_rtdx_d[l_ac].imaal003 #品名
  #          LET g_qryparam.default3 = "" #g_rtdx_d[l_ac].imaal004 #規格
  #          #給予arg
  #          LET g_qryparam.arg1 = "" #
  #
  #
  #          CALL q_imaa001()                                #呼叫開窗
  #
  #          LET g_rtdx_d[l_ac].rtdx001 = g_qryparam.return1
  #          #LET g_rtdx_d[l_ac].imaal003 = g_qryparam.return2
  #          #LET g_rtdx_d[l_ac].imaal004 = g_qryparam.return3
  #          DISPLAY g_rtdx_d[l_ac].rtdx001 TO rtdx001              #
  #          #DISPLAY g_rtdx_d[l_ac].imaal003 TO imaal003 #品名
  #          #DISPLAY g_rtdx_d[l_ac].imaal004 TO imaal004 #規格
  #          NEXT FIELD rtdx001                          #返回原欄位
  #
  #
  #          #END add-point
  #
  #       #Ctrlp:input.c.page1.rtdx002
  #       #應用 a03 樣板自動產生(Version:2)
  #       ON ACTION controlp INFIELD rtdx002
  #          #add-point:ON ACTION controlp INFIELD rtdx002
  #          #應用 a07 樣板自動產生(Version:2)
  #          #開窗i段
  #          INITIALIZE g_qryparam.* TO NULL
  #          LET g_qryparam.state = 'i'
  #          LET g_qryparam.reqry = FALSE
  #
  #          LET g_qryparam.default1 = g_rtdx_d[l_ac].rtdx002             #給予default值
  #
  #          #給予arg
  #          LET g_qryparam.arg1 = "" #
  #
  #
  #          CALL q_imay001()                                #呼叫開窗
  #
  #          LET g_rtdx_d[l_ac].rtdx002 = g_qryparam.return1
  #
  #          DISPLAY g_rtdx_d[l_ac].rtdx002 TO rtdx002              #
  #
  #          NEXT FIELD rtdx002                          #返回原欄位
  #
  #
  #          #END add-point
  #
  #       #Ctrlp:input.c.page1.pmdb007
  #       #應用 a03 樣板自動產生(Version:2)
  #       ON ACTION controlp INFIELD pmdb007
  #          #add-point:ON ACTION controlp INFIELD pmdb007
  #          #應用 a07 樣板自動產生(Version:2)
  #          #開窗i段
  #          INITIALIZE g_qryparam.* TO NULL
  #          LET g_qryparam.state = 'i'
  #          LET g_qryparam.reqry = FALSE
  #
  #          LET g_qryparam.default1 = g_rtdx_d[l_ac].pmdb007             #給予default值
  #
  #          #給予arg
  #          LET g_qryparam.arg1 = "" #
  #
  #
  #          CALL q_ooca001_1()                                #呼叫開窗
  #
  #          LET g_rtdx_d[l_ac].pmdb007 = g_qryparam.return1
  #
  #          DISPLAY g_rtdx_d[l_ac].pmdb007 TO pmdb007              #
  #
  #          NEXT FIELD pmdb007                          #返回原欄位
  #
  #
  #          #END add-point
  #
  #       #Ctrlp:input.c.page1.pmdb006
# #        #應用 a03 樣板自動產生(Version:2)
  #       ON ACTION controlp INFIELD pmdb006
  #          #add-point:ON ACTION controlp INFIELD pmdb006
  #
  #          #END add-point
  #
  #       #Ctrlp:input.c.page1.rtdx004
  #       #應用 a03 樣板自動產生(Version:2)
  #       ON ACTION controlp INFIELD rtdx004
  #          #add-point:ON ACTION controlp INFIELD rtdx004
  #          #應用 a07 樣板自動產生(Version:2)
  #          #開窗i段
  #          INITIALIZE g_qryparam.* TO NULL
  #          LET g_qryparam.state = 'i'
  #          LET g_qryparam.reqry = FALSE
  #
  #          LET g_qryparam.default1 = g_rtdx_d[l_ac].rtdx004             #給予default值
  #
  #          #給予arg
  #          LET g_qryparam.arg1 = "" #
  #
  #
  #          CALL q_ooca001_1()                                #呼叫開窗
  #
  #          LET g_rtdx_d[l_ac].rtdx004 = g_qryparam.return1
  #
  #          DISPLAY g_rtdx_d[l_ac].rtdx004 TO rtdx004              #
  #
  #          NEXT FIELD rtdx004                          #返回原欄位
  #
  #
  #          #END add-point
  #
  #       #Ctrlp:input.c.page1.pmdb212
# #        #應用 a03 樣板自動產生(Version:2)
  #       ON ACTION controlp INFIELD pmdb212
  #          #add-point:ON ACTION controlp INFIELD pmdb212
  #
  #          #END add-point
  #
  #       #Ctrlp:input.c.page1.rtdx044
# #        #應用 a03 樣板自動產生(Version:2)
  #       ON ACTION controlp INFIELD rtdx044
  #          #add-point:ON ACTION controlp INFIELD rtdx044
  #
  #          #END add-point
  #
  #       #Ctrlp:input.c.page1.pmdb252
# #        #應用 a03 樣板自動產生(Version:2)
  #       ON ACTION controlp INFIELD pmdb252
  #          #add-point:ON ACTION controlp INFIELD pmdb252
  #
  #          #END add-point
  #
  #       #Ctrlp:input.c.page1.pmdb259
# #        #應用 a03 樣板自動產生(Version:2)
  #       ON ACTION controlp INFIELD pmdb259
  #          #add-point:ON ACTION controlp INFIELD pmdb259
  #
  #          #END add-point
  #
  #
  #
  #       ON ROW CHANGE
  #          IF INT_FLAG THEN
  #             INITIALIZE g_errparam TO NULL
  #             LET g_errparam.extend = ''
  #             LET g_errparam.code   = 9001
  #             LET g_errparam.popup  = FALSE
  #             CALL cl_err()
  #             LET INT_FLAG = 0
  #             LET g_rtdx_d[l_ac].* = g_rtdx_d_t.*
  #             CLOSE apmt830_02_bcl
  #             #add-point:單身取消時
  #
  #             #end add-point
  #             EXIT DIALOG
  #          END IF
  #
  #          IF l_lock_sw = 'Y' THEN
  #             INITIALIZE g_errparam TO NULL
  #             LET g_errparam.extend = g_rtdx_d[l_ac].rtdx001
  #             LET g_errparam.code   = -263
  #             LET g_errparam.popup  = TRUE
  #             CALL cl_err()
  #             LET g_rtdx_d[l_ac].* = g_rtdx_d_t.*
  #          ELSE
  #             #寫入修改者/修改日期資訊(單身)
  #
  #
  #             #add-point:單身修改前
  #
  #             #end add-point
  #
  #             #將遮罩欄位還原
  #             CALL apmt830_02_rtdx_t_mask_restore('restore_mask_o')
  #
  #             UPDATE rtdx_t SET (rtdx001,rtdx002,rtdx004,rtdx044) = (g_rtdx_d[l_ac].rtdx001,g_rtdx_d[l_ac].rtdx002,
  #                 g_rtdx_d[l_ac].rtdx004,g_rtdx_d[l_ac].rtdx044)
  #              WHERE rtdxent = g_enterprise AND rtdxsite = g_site AND
  #                rtdx001 = g_rtdx_d_t.rtdx001 #項次
  #
  #
  #             #add-point:單身修改中
  #
  #             #end add-point
  #
  #             CASE
  #                WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
  #                   INITIALIZE g_errparam TO NULL
  #                   LET g_errparam.extend = "rtdx_t"
  #                   LET g_errparam.code   = "std-00009"
  #                   LET g_errparam.popup  = TRUE
  #                   CALL cl_err()
  #                  WHEN SQLCA.sqlcode #其他錯誤
  #                   INITIALIZE g_errparam TO NULL
  #                   LET g_errparam.extend = "rtdx_t"
  #                   LET g_errparam.code   = SQLCA.sqlcode
  #                   LET g_errparam.popup  = TRUE
  #                   CALL cl_err()
  #                OTHERWISE
  #                                  INITIALIZE gs_keys TO NULL
  #             LET gs_keys[1] = g_rtdx_d[g_detail_idx].rtdx001
  #             LET gs_keys_bak[1] = g_rtdx_d_t.rtdx001
  #             CALL apmt830_02_update_b('rtdx_t',gs_keys,gs_keys_bak,"'1'")
  #                   #資料多語言用-增/改
  #
  #                   #修改歷程記錄(修改)
  #                   #LET g_log1 = util.JSON.stringify(g_rtdx_d_t)
  #                   #LET g_log2 = util.JSON.stringify(g_rtdx_d[l_ac])
  #                   IF NOT cl_log_modified_record(g_log1,g_log2) THEN
  #                   END IF
  #             END CASE
  #
  #             #將遮罩欄位進行遮蔽
  #             CALL apmt830_02_rtdx_t_mask_restore('restore_mask_n')
  #
  #             #add-point:單身修改後
  #
  #             #end add-point
  #
  #          END IF
  #
  #       AFTER ROW
  #          CALL apmt830_02_unlock_b("rtdx_t")
  #          #其他table進行unlock
  #
  #           #add-point:單身after row
  #
  #          #end add-point
  #
  #       AFTER INPUT
  #          #add-point:單身input後
  #
  #          #end add-point
  #          #錯誤訊息統整顯示
  #          #CALL cl_err_collect_show()
  #          #CALL cl_showmsg()
  #
  #       ON ACTION controlo
  #          CALL FGL_SET_ARR_CURR(g_rtdx_d.getLength()+1)
  #          LET lb_reproduce = TRUE
  #          LET li_reproduce = l_ac
  #          LET li_reproduce_target = g_rtdx_d.getLength()+1
  #
  #    END INPUT
  #
  #
  #
  #
  #
  #    #add-point:before_more_input
  #
  #    #end add-point
  #
  #    BEFORE DIALOG
  #       #CALL cl_err_collect_init()
  #       IF g_temp_idx > 0 THEN
  #          LET l_ac = g_temp_idx
  #          CALL DIALOG.setCurrentRow("s_detail1",l_ac)
  #          LET g_temp_idx = 1
  #       END IF
  #       #LET g_curr_diag = ui.DIALOG.getCurrent()
  #       #add-point:before_dialog
  #
  #       #end add-point
  #       CASE g_aw
  #          WHEN "s_detail1"
  #             NEXT FIELD sel
  #
  #       END CASE
  #
  #    ON ACTION accept
  #       ACCEPT DIALOG
  #
  #    ON ACTION cancel
  #       LET INT_FLAG = TRUE
  #       CANCEL DIALOG
  #
  #    ON ACTION controlr
  #       CALL cl_show_req_fields()
  #
  #    ON ACTION controlf
  #       CALL cl_set_focus_form(ui.Interface.getRootNode())
  #            RETURNING g_fld_name,g_frm_name
  #       CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang)
  #
  #    #交談指令共用ACTION
  #    &include "common_action.4gl"
  #       CONTINUE DIALOG
  #
  # END DIALOG
  #
  # #新增後取消
  # IF l_cmd = 'a' THEN
  #    #當取消或無輸入資料按確定時刪除對應資料
  #    IF INT_FLAG OR cl_null(g_rtdx_d[g_detail_idx].rtdx001) THEN
  #       CALL g_rtdx_d.deleteElement(g_detail_idx)
  #
  #    END IF
  # END IF
  #
  # #修改後取消
  # IF l_cmd = 'u' AND INT_FLAG THEN
  #    LET g_rtdx_d[g_detail_idx].* = g_rtdx_d_t.*
  # END IF
  #
  # #add-point:modify段修改後
  #
  # #end add-point
  #
  # CLOSE apmt830_02_bcl

END FUNCTION

PRIVATE FUNCTION apmt830_02_modify_detail_chk(ps_record)
   DEFINE ps_record STRING
   DEFINE ls_return STRING
   #add-point:modify_detail_chk段define

   #end add-point
   #add-point:modify_detail_chk段define(客製用)

   #end add-point

   #add-point:modify_detail_chk段開始前

   #end add-point

   #根據sr名稱確定該page第一個欄位的名稱
   CASE ps_record
      WHEN "s_detail1"
         LET ls_return = "sel"

      #add-point:modify_detail_chk段自訂page控制

      #end add-point
   END CASE

   #add-point:modify_detail_chk段結束前

   #end add-point

   RETURN ls_return

END FUNCTION

PRIVATE FUNCTION apmt830_02_query()
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING
   #add-point:query段define

   #end add-point
   #add-point:query段define(客製用)

   #end add-point

   #LET INT_FLAG = 0
   #CLEAR FORM
   #CALL g_rtdx_d.clear()
   #
   #LET g_qryparam.state = "c"
   #
   ##wc備份
   #LET ls_wc = g_wc2
   #
   #DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #CONSTRUCT g_wc2 ON rtdx001,rtdx002,pmdb007,pmdb006,rtdx004,pmdb212,rtdx044,pmdb252,pmdb259
      #
      #   FROM s_detail1[1].rtdx001,s_detail1[1].rtdx002,s_detail1[1].pmdb007,s_detail1[1].pmdb006,s_detail1[1].rtdx004,
      #       s_detail1[1].pmdb212,s_detail1[1].rtdx044,s_detail1[1].pmdb252,s_detail1[1].pmdb259
      #
      #
      #
      #            #Ctrlp:construct.c.page1.rtdx001
      #   #應用 a03 樣板自動產生(Version:2)
      #   ON ACTION controlp INFIELD rtdx001
      #      #add-point:ON ACTION controlp INFIELD rtdx001
      #      #應用 a08 樣板自動產生(Version:2)
      #      #開窗c段
      #      INITIALIZE g_qryparam.* TO NULL
      #      LET g_qryparam.state = 'c'
      #      LET g_qryparam.reqry = FALSE
      #      CALL q_imaa001()                           #呼叫開窗
      #      DISPLAY g_qryparam.return1 TO rtdx001  #顯示到畫面上
      #      NEXT FIELD rtdx001                     #返回原欄位
      #
      #
      #
      #      #END add-point
      #
      #   #應用 a01 樣板自動產生(Version:1)
      #   BEFORE FIELD rtdx001
      #      #add-point:BEFORE FIELD rtdx001
      #
      #      #END add-point
      #
      #   #應用 a02 樣板自動產生(Version:1)
      #   AFTER FIELD rtdx001
      #
      #      #add-point:AFTER FIELD rtdx001
      #
      #      #END add-point
      #
      #
      #   #Ctrlp:construct.c.page1.rtdx002
      #   #應用 a03 樣板自動產生(Version:2)
      #   ON ACTION controlp INFIELD rtdx002
      #      #add-point:ON ACTION controlp INFIELD rtdx002
      #      #應用 a08 樣板自動產生(Version:2)
      #      #開窗c段
      #      INITIALIZE g_qryparam.* TO NULL
      #      LET g_qryparam.state = 'c'
      #      LET g_qryparam.reqry = FALSE
      #      CALL q_imay001()                           #呼叫開窗
      #      DISPLAY g_qryparam.return1 TO rtdx002  #顯示到畫面上
      #      NEXT FIELD rtdx002                     #返回原欄位
      #
      #
      #
      #      #END add-point
      #
      #   #應用 a01 樣板自動產生(Version:1)
      #   BEFORE FIELD rtdx002
      #      #add-point:BEFORE FIELD rtdx002
      #
      #      #END add-point
      #
      #   #應用 a02 樣板自動產生(Version:1)
      #   AFTER FIELD rtdx002
      #
      #      #add-point:AFTER FIELD rtdx002
      #
      #      #END add-point
      #
      #
      #   #Ctrlp:construct.c.page1.pmdb007
      #   #應用 a03 樣板自動產生(Version:2)
      #   ON ACTION controlp INFIELD pmdb007
      #      #add-point:ON ACTION controlp INFIELD pmdb007
      #      #應用 a08 樣板自動產生(Version:2)
      #      #開窗c段
      #      INITIALIZE g_qryparam.* TO NULL
      #      LET g_qryparam.state = 'c'
      #      LET g_qryparam.reqry = FALSE
      #      CALL q_ooca001_1()                           #呼叫開窗
      #      DISPLAY g_qryparam.return1 TO pmdb007  #顯示到畫面上
      #      NEXT FIELD pmdb007                     #返回原欄位
      #
      #
      #
      #      #END add-point
      #
      #   #應用 a01 樣板自動產生(Version:1)
      #   BEFORE FIELD pmdb007
      #      #add-point:BEFORE FIELD pmdb007
      #
      #      #END add-point
      #
      #   #應用 a02 樣板自動產生(Version:1)
      #   AFTER FIELD pmdb007
      #
      #      #add-point:AFTER FIELD pmdb007
      #
      #      #END add-point
      #
      #
      #   #應用 a01 樣板自動產生(Version:1)
      #   BEFORE FIELD pmdb006
      #      #add-point:BEFORE FIELD pmdb006
      #
      #      #END add-point
      #
      #   #應用 a02 樣板自動產生(Version:1)
      #   AFTER FIELD pmdb006
      #
      #      #add-point:AFTER FIELD pmdb006
      #
      #      #END add-point
      #
      #
      #   #Ctrlp:query.c.page1.pmdb006
#     #    #應用 a03 樣板自動產生(Version:2)
      #   ON ACTION controlp INFIELD pmdb006
      #      #add-point:ON ACTION controlp INFIELD pmdb006
      #
      #      #END add-point
      #
      #   #Ctrlp:construct.c.page1.rtdx004
      #   #應用 a03 樣板自動產生(Version:2)
      #   ON ACTION controlp INFIELD rtdx004
      #      #add-point:ON ACTION controlp INFIELD rtdx004
      #      #應用 a08 樣板自動產生(Version:2)
      #      #開窗c段
      #      INITIALIZE g_qryparam.* TO NULL
      #      LET g_qryparam.state = 'c'
      #      LET g_qryparam.reqry = FALSE
      #      CALL q_ooca001_1()                           #呼叫開窗
      #      DISPLAY g_qryparam.return1 TO rtdx004  #顯示到畫面上
      #      NEXT FIELD rtdx004                     #返回原欄位
      #
      #
      #
      #      #END add-point
      #
      #   #應用 a01 樣板自動產生(Version:1)
      #   BEFORE FIELD rtdx004
      #      #add-point:BEFORE FIELD rtdx004
      #
      #      #END add-point
      #
      #   #應用 a02 樣板自動產生(Version:1)
      #   AFTER FIELD rtdx004
      #
      #      #add-point:AFTER FIELD rtdx004
      #
      #      #END add-point
      #
      #
      #   #應用 a01 樣板自動產生(Version:1)
      #   BEFORE FIELD pmdb212
      #      #add-point:BEFORE FIELD pmdb212
      #
      #      #END add-point
      #
      #   #應用 a02 樣板自動產生(Version:1)
      #   AFTER FIELD pmdb212
      #
      #      #add-point:AFTER FIELD pmdb212
      #
      #      #END add-point
      #
      #
      #   #Ctrlp:query.c.page1.pmdb212
#     #    #應用 a03 樣板自動產生(Version:2)
      #   ON ACTION controlp INFIELD pmdb212
      #      #add-point:ON ACTION controlp INFIELD pmdb212
      #
      #      #END add-point
      #
      #   #應用 a01 樣板自動產生(Version:1)
      #   BEFORE FIELD rtdx044
      #      #add-point:BEFORE FIELD rtdx044
      #
      #      #END add-point
      #
      #   #應用 a02 樣板自動產生(Version:1)
      #   AFTER FIELD rtdx044
      #
      #      #add-point:AFTER FIELD rtdx044
      #
      #      #END add-point
      #
      #
      #   #Ctrlp:query.c.page1.rtdx044
#     #    #應用 a03 樣板自動產生(Version:2)
      #   ON ACTION controlp INFIELD rtdx044
      #      #add-point:ON ACTION controlp INFIELD rtdx044
      #
      #      #END add-point
      #
      #   #應用 a01 樣板自動產生(Version:1)
      #   BEFORE FIELD pmdb252
      #      #add-point:BEFORE FIELD pmdb252
      #
      #      #END add-point
      #
      #   #應用 a02 樣板自動產生(Version:1)
      #   AFTER FIELD pmdb252
      #
      #      #add-point:AFTER FIELD pmdb252
      #
      #      #END add-point
      #
      #
      #   #Ctrlp:query.c.page1.pmdb252
#     #    #應用 a03 樣板自動產生(Version:2)
      #   ON ACTION controlp INFIELD pmdb252
      #      #add-point:ON ACTION controlp INFIELD pmdb252
      #
      #      #END add-point
      #
      #   #應用 a01 樣板自動產生(Version:1)
      #   BEFORE FIELD pmdb259
      #      #add-point:BEFORE FIELD pmdb259
      #
      #      #END add-point
      #
      #   #應用 a02 樣板自動產生(Version:1)
      #   AFTER FIELD pmdb259
      #
      #      #add-point:AFTER FIELD pmdb259
      #
      #      #END add-point
      #
      #
      #   #Ctrlp:query.c.page1.pmdb259
#     #    #應用 a03 樣板自動產生(Version:2)
      #   ON ACTION controlp INFIELD pmdb259
      #      #add-point:ON ACTION controlp INFIELD pmdb259
      #
      #      #END add-point
      #
      #
      #
      #
      #
      #   BEFORE CONSTRUCT
      #      #add-point:cs段more_construct
      #
      #      #end add-point
      #
      #END CONSTRUCT

      #add-point:query段more_construct

      #end add-point

      #BEFORE DIALOG
      #   CALL cl_qbe_init()
      #   #add-point:query段before_dialog
      #
      #   #end add-point
      #
      #ON ACTION qbe_select
      #   LET ls_wc = ""
      #   CALL cl_qbe_list("c") RETURNING ls_wc
      #
      #ON ACTION qbe_save
      #   CALL cl_qbe_save()
      #
      #ON ACTION accept
      #   ACCEPT DIALOG
      #
      #ON ACTION cancel
      #   LET INT_FLAG = 1
      #   CANCEL DIALOG
      #
      ##交談指令共用ACTION
      #&include "common_action.4gl"
      #CONTINUE DIALOG
   #END DIALOG

   #add-point:query段after_construct

   #end add-point

   #IF INT_FLAG THEN
   #   LET INT_FLAG = 0
   #   #還原
   #   LET g_wc2 = ls_wc
   #ELSE
   #   LET g_error_show = 1
   #   LET g_detail_idx = 1
   #END IF
   #
   #CALL apmt830_02_b_fill()
   #
   #IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.extend = ""
   #   LET g_errparam.code   = -100
   #   LET g_errparam.popup  = TRUE
   #   CALL cl_err()
   #END IF
   #
   #LET INT_FLAG = FALSE

END FUNCTION

PRIVATE FUNCTION apmt830_02_set_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1
   #add-point:set_entry_b段define

   #end add-point
   #add-point:set_entry_b段define(客製用)

   #end add-point

   #add-point:set_entry_b段control
   CALL cl_set_comp_entry("l_pmdb006,l_pmdb212",TRUE)   
   #end add-point

END FUNCTION

PRIVATE FUNCTION apmt830_02_set_no_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1
   #add-point:set_no_entry_b段define

   #end add-point
   #add-point:set_no_entry_b段define(客製用)

   #end add-point

   #add-point:set_no_entry_b段control
  #Mark By baogc 20151104 Begin ---
  #IF g_rtdx_d[l_ac].sel ='N' THEN
  #   CALL cl_set_comp_entry("l_pmdb006,l_pmdb212",FALSE) 
  #END IF
  #IF NOT cl_null(g_rtdx_d[l_ac].l_pmdb006) THEN
  #   CALL cl_set_comp_entry("l_pmdb212",FALSE) 
  #END IF
  #Mark By baogc 20151104 Begin ---
   #end add-point

END FUNCTION

PRIVATE FUNCTION apmt830_02_set_pk_array()
   #add-point:set_pk_array段define

   #end add-point
   #add-point:set_pk_array段define

   #end add-point

   #add-point:set_pk_array段之前

   #end add-point

   #若l_ac<=0代表沒有資料
   IF l_ac <= 0 THEN
      RETURN
   END IF

   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_rtdx_d[l_ac].rtdx001
   LET g_pk_array[1].column = 'rtdx001'


   #add-point:set_pk_array段之後

   #end add-point

END FUNCTION

PRIVATE FUNCTION apmt830_02_ui_dialog()
   #DEFINE li_idx   LIKE type_t.num10
   #DEFINE la_param  RECORD #串查用
   #          prog   STRING,
   #          param  DYNAMIC ARRAY OF STRING
   #                 END RECORD
   #DEFINE ls_js     STRING
   ##add-point:ui_dialog段define
   #
   ##end add-point
   ##add-point:ui_dialog段define(客製用)
   #
   ##end add-point
   #
   #LET g_action_choice = " "
   #LET gwin_curr = ui.Window.getCurrent()
   #LET gfrm_curr = gwin_curr.getForm()
   #
   #CALL cl_set_act_visible("accept,cancel", FALSE)
   #
   #LET g_detail_idx = 1
   #
   ##add-point:ui_dialog段before dialog
   #
   ##end add-point
   #
   #WHILE TRUE
   #
   #   IF g_action_choice = "logistics" THEN
   #      #清除畫面及相關資料
   #      CLEAR FORM
   #      CALL g_rtdx_d.clear()
   #
   #      LET g_wc2 = ' 1=2'
   #      LET g_action_choice = ""
   #      CALL apmt830_02_init()
   #   END IF
   #
   #   CALL apmt830_02_b_fill()
   #
   #   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   #      DISPLAY ARRAY g_rtdx_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
   #
   #         BEFORE DISPLAY
   #            #add-point:ui_dialog段before display
   #
   #            #end add-point
   #            #讓各頁籤能夠同步指到特定資料
   #            CALL FGL_SET_ARR_CURR(g_detail_idx)
   #            #add-point:ui_dialog段before display2
   #
   #            #end add-point
   #
   #         BEFORE ROW
   #            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
   #            LET l_ac = g_detail_idx
   #            LET g_temp_idx = l_ac
   #            DISPLAY g_detail_idx TO FORMONLY.idx
   #            CALL cl_show_fld_cont()
   #            #顯示followup圖示
   #            #應用 a48 樣板自動產生(Version:2)
   #CALL apmt830_02_set_pk_array()
   ##add-point:ON ACTION agendum
   #
   ##END add-point
   #CALL cl_user_overview_set_follow_pic()
   #
   #
   #
   #            #add-point:display array-before row
   #
   #            #end add-point
   #
   #         #自訂ACTION(detail_show,page_1)
   #
   #
   #      END DISPLAY
   #
   #
   #
   #      #add-point:ui_dialog段自定義display array
   #
   #      #end add-point
   #
   #      BEFORE DIALOG
   #         IF g_temp_idx > 0 THEN
   #            LET l_ac = g_temp_idx
   #            CALL DIALOG.setCurrentRow("s_detail1",l_ac)
   #            LET g_temp_idx = 1
   #         END IF
   #         LET g_curr_diag = ui.DIALOG.getCurrent()
   #         CALL DIALOG.setSelectionMode("s_detail1", 1)
   #
   #         #add-point:ui_dialog段before
   #
   #         #end add-point
   #         NEXT FIELD CURRENT
   #
   #
   #      #應用 a43 樣板自動產生(Version:2)
   #      ON ACTION modify
   #         LET g_action_choice="modify"
   #         IF cl_auth_chk_act("modify") THEN
   #            LET g_aw = ''
   #            CALL apmt830_02_modify()
   #            #add-point:ON ACTION modify
   #
   #            #END add-point
   #
   #         END IF
   #
   #
   #
   #      #應用 a43 樣板自動產生(Version:2)
   #      ON ACTION modify_detail
   #         LET g_action_choice="modify_detail"
   #         IF cl_auth_chk_act("modify") THEN
   #            LET g_aw = g_curr_diag.getCurrentItem()
   #            CALL apmt830_02_modify()
   #            #add-point:ON ACTION modify_detail
   #
   #            #END add-point
   #
   #         END IF
   #
   #
   #
   #      #應用 a43 樣板自動產生(Version:2)
   #      ON ACTION delete
   #         LET g_action_choice="delete"
   #         IF cl_auth_chk_act("delete") THEN
   #            CALL apmt830_02_delete()
   #            #add-point:ON ACTION delete
   #
   #            #END add-point
   #
   #         END IF
   #
   #
   #
   #      #應用 a43 樣板自動產生(Version:2)
   #      ON ACTION insert
   #         LET g_action_choice="insert"
   #         IF cl_auth_chk_act("insert") THEN
   #            CALL apmt830_02_insert()
   #            #add-point:ON ACTION insert
   #
   #            #END add-point
   #
   #         END IF
   #
   #
   #
   #      #應用 a43 樣板自動產生(Version:2)
   #      ON ACTION output
   #         LET g_action_choice="output"
   #         IF cl_auth_chk_act("output") THEN
   #
   #            #add-point:ON ACTION output
   #
   #            #END add-point
   #
   #         END IF
   #
   #
   #
   #      #應用 a43 樣板自動產生(Version:2)
   #      ON ACTION reproduce
   #         LET g_action_choice="reproduce"
   #         IF cl_auth_chk_act("reproduce") THEN
   #
   #            #add-point:ON ACTION reproduce
   #
   #            #END add-point
   #
   #         END IF
   #
   #
   #
   #      #應用 a43 樣板自動產生(Version:2)
   #      ON ACTION query
   #         LET g_action_choice="query"
   #         IF cl_auth_chk_act("query") THEN
   #            CALL apmt830_02_query()
   #            #add-point:ON ACTION query
   #
   #            #END add-point
   #            #應用 a59 樣板自動產生(Version:2)
   #            CALL g_curr_diag.setCurrentRow("s_detail1",1)
   #
   #
   #
   #         END IF
   #
   #
   #
   #
   #      ON ACTION exporttoexcel
   #         LET g_action_choice="exporttoexcel"
   #         IF cl_auth_chk_act("exporttoexcel") THEN
   #            CALL g_export_node.clear()
   #            LET g_export_node[1] = base.typeInfo.create(g_rtdx_d)
   #            LET g_export_id[1]   = "s_detail1"
   #
   #            #add-point:ON ACTION exporttoexcel
   #
   #            #END add-point
   #            CALL cl_export_to_excel_getpage()
   #            CALL cl_export_to_excel()
   #         END IF
   #
   #      ON ACTION close
   #         LET INT_FLAG=FALSE
   #         LET g_action_choice="exit"
   #         CANCEL DIALOG
   #
   #      ON ACTION exit
   #         LET g_action_choice="exit"
   #         CANCEL DIALOG
   #
   #
   #
   #      #應用 a46 樣板自動產生(Version:2)
   #      #新增相關文件
   #      ON ACTION related_document
   #         CALL apmt830_02_set_pk_array()
   #         IF cl_auth_chk_act("related_document") THEN
   #            #add-point:ON ACTION related_document
   #
   #            #END add-point
   #            CALL cl_doc()
   #         END IF
   #
   #      ON ACTION agendum
   #         CALL apmt830_02_set_pk_array()
   #         #add-point:ON ACTION agendum
   #
   #         #END add-point
   #         CALL cl_user_overview()
   #         CALL cl_user_overview_set_follow_pic()
   #
   #      ON ACTION followup
   #         CALL apmt830_02_set_pk_array()
   #         #add-point:ON ACTION followup
   #
   #         #END add-point
   #         CALL cl_user_overview_follow('')
   #
   #
   #
   #      #主選單用ACTION
   #      &include "main_menu_exit_dialog.4gl"
   #      &include "relating_action.4gl"
   #      #交談指令共用ACTION
   #      &include "common_action.4gl"
   #         CONTINUE DIALOG
   #   END DIALOG
   #
   #   IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
   #      #add-point:ui_dialog段離開dialog前
   #
   #      #end add-point
   #      EXIT WHILE
   #   END IF
   #
   #END WHILE
   #
   #CALL cl_set_act_visible("accept,cancel", TRUE)
   #
END FUNCTION

PRIVATE FUNCTION apmt830_02_unlock_b(ps_table)
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:unlock_b段define

   #end add-point
   #add-point:unlock_b段define(客製用)

   #end add-point

   LET ls_group = ""

   #IF ls_group.getIndexOf(ps_table,1) THEN
      CLOSE apmt830_02_bcl
   #END IF



   #add-point:unlock_b段結束前

   #end add-point

END FUNCTION

PRIVATE FUNCTION apmt830_02_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   DEFINE ps_page          STRING
   DEFINE ps_table         STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num10
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   #add-point:update_b段define

   #end add-point
   #add-point:update_b段define(客製用)

   #end add-point

   #比對新舊值, 判斷key是否有改變
   LET lb_chk = TRUE
   FOR li_idx = 1 TO ps_keys.getLength()
      IF ps_keys[li_idx] <> ps_keys_bak[li_idx] THEN
         LET lb_chk = FALSE
         EXIT FOR
      END IF
   END FOR

   #若key無變動, 不需要做處理
   IF lb_chk THEN
      RETURN
   END IF

   #若key有變動, 則連動其他table的資料
   #判斷是否是同一群組的table
   LET ls_group = "rtdx_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "rtdx_t" THEN
      #add-point:update_b段修改前

      #end add-point
      #UPDATE rtdx_t
      #   SET (rtdx001
      #        ,rtdx002,rtdx004,rtdx044)
      #        =
      #       (ps_keys[1]
      #        ,g_rtdx_d[l_ac].rtdx002,g_rtdx_d[l_ac].rtdx004,g_rtdx_d[l_ac].rtdx044)
      #   WHERE rtdx001 = ps_keys_bak[1]
      #add-point:update_b段修改中

      #end add-point
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "rtdx_t"
            LET g_errparam.code   = "std-00009"
            LET g_errparam.popup  = TRUE
            CALL cl_err()
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "rtdx_t"
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
         OTHERWISE

      END CASE
      #add-point:update_b段修改後

      #end add-point
      RETURN
   END IF



END FUNCTION

################################################################################
# Descriptions...: 產生要貨單明細相關語法
# Memo...........:
# Usage..........: CALL apmt830_02_gen_detail_pre()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/05/27 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt830_02_gen_detail_pre()
DEFINE l_sql     STRING

   LET l_sql = "SELECT rtdx001,  rtdx002,  pmdb007,  pmdb213,  pmdb006, ",   #add by guomy 2015/11/4
               "       imaz003,  imaz006,  rtdx004,  pmdb212,  rtdx044, ",   #160303-00028#20 add imaz006
               "       pmdb252,  pmdb259,  pmdb254,  pmdb255, ",
               "       pmdb256,  pmdb257,  pmdb258,  rtdx028, ",
               "       rtdx029 ",
               "  FROM apmt830_02_tmp  ",
               " WHERE sel='Y' "
   PREPARE apmt830_02_sel_pre FROM l_sql
   DECLARE apmt830_02_sel_cs CURSOR FOR apmt830_02_sel_pre
   
   #項次
   LET l_sql = "SELECT COALESCE(MAX(pmdbseq),0)+1",
               "  FROM pmdb_t",
               " WHERE pmdbent = ",g_enterprise,
               "   AND pmdbdocno = '",g_pmdadocno,"'"
   PREPARE apmt830_02_pmdbseq FROM l_sql
   
   #供應商
   LET l_sql = "SELECT imaf153",
               "  FROM imaf_t",
               " WHERE imafent = ",g_enterprise,
               "   AND imafsite = ?",
               "   AND imaf001 = ?"
   PREPARE apmt830_02_imaf153 FROM l_sql
   
   #結算方式、採購員
   LET l_sql = "SELECT DISTINCT star006,stas009",
               "  FROM stan_t,star_t,stas_t",
               " WHERE starent = stasent",
               "   AND starsite = stassite ",
               "   AND star001 = stas001",
               "   AND stanent = starent",
               "   AND stan001 = star004",
               "   AND stanent = ",g_enterprise,
               "   AND starsite = ? ", #add by geza 20150603
               "   AND stas003 = ?",
               "   AND star003 = ?",
               "   AND starstus = 'Y'",
               #"   AND '",g_pmda.pmdadocdt,"' BETWEEN stan017 AND stan018"   #160104-00014#1 20160104 mark by beckxie
               "   AND '",g_pmda.pmdadocdt,"' BETWEEN stas018 AND stas019"    #160104-00014#1 20160104  add by beckxie
   PREPARE apmt830_02_get_star FROM l_sql
   
   #採購方式
   LET l_sql = "SELECT rtdx027,rtdx003",
               "  FROM rtdx_t",
               " WHERE rtdxent = ",g_enterprise,
               "   AND rtdxsite = ?",
               "   AND rtdx001 = ?"
   PREPARE apmt830_02_get_rtdx FROM l_sql
END FUNCTION

################################################################################
# Descriptions...: 產生要貨單明細資料
# Memo...........:
# Usage..........: CALL apmt830_02_gen_detail()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/05/27 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt830_02_gen_detail()
DEFINE l_i              LIKE type_t.num5
DEFINE l_rtdx            RECORD
       rtdx001           LIKE rtdx_t.rtdx001,     #商品編號
       rtdx002           LIKE rtdx_t.rtdx002,     #商品主條碼
       pmdb007           LIKE pmdb_t.pmdb007,     #要貨單位
       pmdb213           like pmdb_t.pmdb213,     #参考价格 add  by guomy 2015/11/4
       pmdb006           LIKE pmdb_t.pmdb006,     #要貨數量 
       imaz003           LIKE imaz_t.imaz003,     #補貨條碼
       imaz006           LIKE imaz_t.imaz006,     #補貨規格說明   #160303-00028#20
       rtdx004           LIKE rtdx_t.rtdx004,     #包裝單位
       pmdb212           LIKE pmdb_t.pmdb212,     #要貨包裝數量
       rtdx044           LIKE rtdx_t.rtdx044,     #庫位  
       pmdb252           LIKE pmdb_t.pmdb252,     #現有庫存
       pmdb259           LIKE pmdb_t.pmdb259,     #週平均銷量
       pmdb254           LIKE pmdb_t.pmdb254,     #前一週銷量
       pmdb255           LIKE pmdb_t.pmdb255,     #前二週銷量
       pmdb256           LIKE pmdb_t.pmdb256,     #前三週銷量
       pmdb257           LIKE pmdb_t.pmdb257,     #前四週銷量
       pmdb258           LIKE pmdb_t.pmdb258,     #要貨在途量
       rtdx028           LIKE rtdx_t.rtdx028,     #採購中心
       rtdx029           LIKE rtdx_t.rtdx029      #配迗中心
                         END RECORD
DEFINE l_pmdb           RECORD
       pmdbent          LIKE pmdb_t.pmdbent,     #企業編號
       pmdbsite         LIKE pmdb_t.pmdbsite,    #營運據點
       pmdbdocno        LIKE pmdb_t.pmdbdocno,   #請購單號
       pmdbseq          LIKE pmdb_t.pmdbseq,     #項次
       pmdb001          LIKE pmdb_t.pmdb001,     #來源單號
       pmdb002          LIKE pmdb_t.pmdb002,     #來源項次
       pmdb003          LIKE pmdb_t.pmdb003,     #來源項序
       pmdb004          LIKE pmdb_t.pmdb004,     #料件編號
       pmdb005          LIKE pmdb_t.pmdb005,     #產品特徵
       pmdb006          LIKE pmdb_t.pmdb006,     #需求數量
       pmdb007          LIKE pmdb_t.pmdb007,     #單位
       pmdb015          LIKE pmdb_t.pmdb015,     #供應商編號
       pmdb019          LIKE pmdb_t.pmdb019,     #參考單價
       pmdb020          LIKE pmdb_t.pmdb020,     #參考未稅金額
       pmdb021          LIKE pmdb_t.pmdb021,     #參考含稅金額
       pmdb030          LIKE pmdb_t.pmdb030,     #需求日期
       pmdb032          LIKE pmdb_t.pmdb032,     #行狀態
       pmdb033          LIKE pmdb_t.pmdb033,     #緊急度
       pmdb037          LIKE pmdb_t.pmdb037,     #收貨據點
       pmdb038          LIKE pmdb_t.pmdb038,     #收貨庫位
       pmdb039          LIKE pmdb_t.pmdb039,     #收貨儲位
       pmdb044          LIKE pmdb_t.pmdb044,     #納入MRP
       pmdb046          LIKE pmdb_t.pmdb046,     #費用部門
       pmdb048          LIKE pmdb_t.pmdb048,     #收貨時段
       pmdb049          LIKE pmdb_t.pmdb049,     #已轉採購量
       pmdb050          LIKE pmdb_t.pmdb050,     #備註
       pmdb051          LIKE pmdb_t.pmdb051,     #結案/留置理由
       pmdb200          LIKE pmdb_t.pmdb200,     #商品條碼
       pmdb201          LIKE pmdb_t.pmdb201,     #包裝單位
       pmdb202          LIKE pmdb_t.pmdb202,     #件裝數
       pmdb203          LIKE pmdb_t.pmdb203,     #配送中心
       pmdb204          LIKE pmdb_t.pmdb204,     #配送倉庫
       pmdb205          LIKE pmdb_t.pmdb205,     #採購中心
       pmdb206          LIKE pmdb_t.pmdb206,     #採購員
       pmdb207          LIKE pmdb_t.pmdb207,     #採購方式
       pmdb208          LIKE pmdb_t.pmdb208,     #經營方式
       pmdb209          LIKE pmdb_t.pmdb209,     #結算方式
       pmdb210          LIKE pmdb_t.pmdb210,     #促銷開始日
       pmdb211          LIKE pmdb_t.pmdb211,     #促銷結束日
       pmdb212          LIKE pmdb_t.pmdb212,     #要貨件數
       pmdb250          LIKE pmdb_t.pmdb250,     #合理庫存
       pmdb251          LIKE pmdb_t.pmdb251,     #最高庫存
       pmdb252          LIKE pmdb_t.pmdb252,     #現有庫存
       pmdb253          LIKE pmdb_t.pmdb253,     #入庫在途量
       pmdb254          LIKE pmdb_t.pmdb254,     #前一週銷量
       pmdb255          LIKE pmdb_t.pmdb255,     #前二週銷量
       pmdb256          LIKE pmdb_t.pmdb256,     #前三週銷量
       pmdb257          LIKE pmdb_t.pmdb257,     #前四周銷量
       pmdb258          LIKE pmdb_t.pmdb258,     #要貨在途量
       pmdb259          LIKE pmdb_t.pmdb259,     #周平均銷量
       pmdb260          LIKE pmdb_t.pmdb260,     #收貨部門
       pmdb227          LIKE pmdb_t.pmdb227,      #補貨規格說明
       pmdb213          LIKE pmdb_t.pmdb213       #增加参考价格  add by guom y2015/11/4
                        END RECORD
DEFINE l_rtdx027        LIKE rtdx_t.rtdx027
DEFINE l_sys2           LIKE type_t.num5
DEFINE r_success   LIKE type_t.num5
#170116-00018#1 -s by 08172
DEFINE l_inaasite       LIKE inaa_t.inaasite
DEFINE l_inaa142        LIKE inaa_t.inaa142
DEFINE l_inaa010        LIKE inaa_t.inaa010
DEFINE l_sql            STRING
DEFINE l_sel_sql        STRING
DEFINE l_sql3           STRING
#170116-00018#1 -e by 08172

   LET r_success = TRUE
   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   #170116-00018#1 -s by 08172
   #抓取库位
   LET l_sel_sql = "SELECT UNIQUE inaasite, inaa001,inaa142,inaa010 " 
   LET l_sql3 = s_aint700_adbi261_sql('N','Y')  
   LET l_sql = l_sel_sql,l_sql3
   PREPARE apmt830_02_adbi261_sel_pr FROM l_sql
   DECLARE apmt830_02_adbi261_sel_cur SCROLL CURSOR FOR apmt830_02_adbi261_sel_pr
   #170116-00018#1 -e by 08172
   CALL apmt830_02_gen_detail_pre()
   
   FOREACH apmt830_02_sel_cs
      INTO l_rtdx.rtdx001,  l_rtdx.rtdx002, l_rtdx.pmdb007, l_rtdx.pmdb213, l_rtdx.pmdb006, #add by guomy 015/11/4
           l_rtdx.imaz003,  l_rtdx.imaz006, l_rtdx.rtdx004, l_rtdx.pmdb212, l_rtdx.rtdx044, #160303-00028#20 add imaz006 
           l_rtdx.pmdb252,  l_rtdx.pmdb259, l_rtdx.pmdb254, l_rtdx.pmdb255,
           l_rtdx.pmdb256,  l_rtdx.pmdb257, l_rtdx.pmdb258, l_rtdx.rtdx028,
           l_rtdx.rtdx029
               
           
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "Foreach apmt830_02_sel_cs"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      
      LET l_pmdb.pmdbent   = g_enterprise       #企業編號
      
      #營運據點
      #單頭需求組織(pmda203)非空白時，Default = 需求組織(pmda203)
      IF NOT cl_null(g_pmda.pmda203) THEN
         LET l_pmdb.pmdbsite = g_pmda.pmda203
      ELSE
         #LET l_pmdb.pmdbsite = g_site           #151113-00003#11 151130 By pomelo mark
         LET l_pmdb.pmdbsite = g_pmda.pmdasite   #151113-00003#11 151130 By pomelo add
      END IF
      
      LET l_pmdb.pmdbdocno = g_pmdadocno        #請購單號
      
      #來源單號、項次、項序
      LET l_pmdb.pmdb001   = ''
      LET l_pmdb.pmdb002   = ''
      LET l_pmdb.pmdb003   = ''
      
      #項次
      EXECUTE apmt830_02_pmdbseq INTO l_pmdb.pmdbseq
      LET l_pmdb.pmdb004   = l_rtdx.rtdx001     #商品編號
      LET l_pmdb.pmdb005   = ' '                #產品特徵
      LET l_pmdb.pmdb006   = l_rtdx.pmdb006     #要貨數量
      LET l_pmdb.pmdb007   = l_rtdx.pmdb007     #要貨單位
      
      #先抓取採購方式; rtdx027 用來判斷是否需要有主供應商(採購方式為2:統採配送時主供應商可為空)
      SELECT rtdx027  INTO l_rtdx027 FROM rtdx_t 
       WHERE rtdxent = g_enterprise AND rtdxsite = l_pmdb.pmdbsite AND rtdx001 = l_rtdx.rtdx001      
      
      #供應商編號
      EXECUTE apmt830_02_imaf153 USING l_pmdb.pmdbsite,l_pmdb.pmdb004
         INTO l_pmdb.pmdb015
      #商品編號的採購主要供應商不可為空！
      IF cl_null(l_pmdb.pmdb015) THEN
         IF l_rtdx027 <> '2' THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'apm-00846'
            LET g_errparam.extend = l_pmdb.pmdb004
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CONTINUE FOREACH
         END IF
      END IF
      
      #160304-00021#1 150309 By pomelo mark(S)
      #應該依照子程式畫面的資料直接寫入要貨單單身，不應該重新抓取相關資料
      ##150710-00016#4 Add By Ken 150713(S) 取商品符合補貨規格的包裝單位、件裝數、補貨規格
      #CALL cl_get_para(g_enterprise,l_pmdb.pmdbsite,'S-CIR-1001') RETURNING l_sys2
      #SELECT imaz004,imaz005,imaz006 INTO l_pmdb.pmdb201,l_pmdb.pmdb202,l_pmdb.pmdb227
      #  FROM imaz_t
      # WHERE imazent = g_enterprise 
      #   AND imaz001 = l_pmdb.pmdb004
      #   AND imaz002 = l_sys2   
      ##150710-00016#4 Add By Ken 150713(E)
      #160304-00021#1 150309 By pomelo mark(E)
      
      LET l_pmdb.pmdb019   = 0                  #參考單價
      LET l_pmdb.pmdb020   = 0                  #參考未稅金額
      LET l_pmdb.pmdb021   = 0                  #參考含稅金額
      #LET l_pmdb.pmdb030   = g_pmda.pmdadocdt   #需求日期   #151113-00003#11 151130 By pomelo mark
      #151113-00003#11 151130 By pomelo add(S)
      #需求日期
      IF cl_null(g_pmda.pmda207) THEN
         LET l_pmdb.pmdb030   = g_pmda.pmdadocdt
      ELSE
         LET l_pmdb.pmdb030   = g_pmda.pmda207
      END IF
      #151113-00003#11 151130 By pomelo add(E)
      LET l_pmdb.pmdb032   = '1'                #行狀態
      LET l_pmdb.pmdb033   = '1'                #緊急度
      LET l_pmdb.pmdb037   = l_pmdb.pmdbsite    #收貨據點
      LET l_pmdb.pmdb038   = l_rtdx.rtdx044     #收貨庫位
      LET l_pmdb.pmdb039   = ''                 #收貨儲位
      LET l_pmdb.pmdb044   = 'Y'                #納入MRP
      LET l_pmdb.pmdb046   = g_pmda.pmda003     #費用部門
      LET l_pmdb.pmdb048   = ''                 #收貨時段
      LET l_pmdb.pmdb049   = 0                  #已轉採購量
      LET l_pmdb.pmdb050   = ''                 #備註
      LET l_pmdb.pmdb051   = ''                 #結案/留置理由
      LET l_pmdb.pmdb200   = l_rtdx.imaz003     #商品條碼
      LET l_pmdb.pmdb227   = l_rtdx.imaz006     #補貨規格說明   #160303-00028#20
      LET l_pmdb.pmdb201   = l_rtdx.rtdx004     #包裝單位   #160304-00021#1 150309 By pomelo remark
      #LET l_pmdb.pmdb202   = 0   #件裝數
      LET l_pmdb.pmdb213   = l_rtdx.pmdb213    #参考价格 add by guomy 2015/11/4
      
      #配送中心
      #當單頭有指定配送中心時，單身配送中心預設為單頭配送中心
      IF NOT cl_null(g_pmda.pmda205) THEN
         LET l_pmdb.pmdb203 = g_pmda.pmda205
      ELSE
         LET l_pmdb.pmdb203 = l_rtdx.rtdx029
      END IF
      
      #配送倉庫
      #當單頭有指定配送倉時，單身等於單頭的配送倉且不可修改
      IF NOT cl_null(g_pmda.pmda206) THEN
         LET l_pmdb.pmdb204 = g_pmda.pmda206
      #170116-00018#1 -s by 08172
      ELSE
         OPEN apmt830_02_adbi261_sel_cur USING l_pmdb.pmdb203,l_pmdb.pmdb004,l_pmdb.pmdbsite
         FETCH FIRST apmt830_02_adbi261_sel_cur INTO l_inaasite,l_pmdb.pmdb204,l_inaa142,l_inaa010
         CLOSE apmt830_02_adbi261_sel_cur
      #170116-00018#1 -e by 08172
      END IF
      
      #採購中心
      #當單頭有指定採購中心時，單身採購中心預設為採購配送中心
      IF NOT cl_null(g_pmda.pmda204) THEN
         LET l_pmdb.pmdb205 = g_pmda.pmda204
      ELSE 
         LET l_pmdb.pmdb205 = l_rtdx.rtdx028
      END IF
      
      #結算方式、採購員
      EXECUTE apmt830_02_get_star USING l_pmdb.pmdbsite,l_pmdb.pmdb004,l_pmdb.pmdb015
         INTO l_pmdb.pmdb209,l_pmdb.pmdb206
         
      #採購方式、經營方式
      EXECUTE apmt830_02_get_rtdx USING l_pmdb.pmdbsite,l_pmdb.pmdb004
         INTO l_pmdb.pmdb207,l_pmdb.pmdb208
      
      LET l_pmdb.pmdb210   = ''                 #促銷開始日
      LET l_pmdb.pmdb211   = ''                 #促銷結束日
      LET l_pmdb.pmdb212   = l_rtdx.pmdb212     #要貨件數
      LET l_pmdb.pmdb250   = 0                  #合理庫存
      LET l_pmdb.pmdb251   = 0                  #最高庫存
      LET l_pmdb.pmdb252   = l_rtdx.pmdb252     #現有庫存
      LET l_pmdb.pmdb254   = l_rtdx.pmdb254     ##前一週銷量
      LET l_pmdb.pmdb255   = l_rtdx.pmdb255     #前二週銷量
      LET l_pmdb.pmdb256   = l_rtdx.pmdb256     #前三週銷量
      LET l_pmdb.pmdb257   = l_rtdx.pmdb257     #前四週銷量
      LET l_pmdb.pmdb258   = l_rtdx.pmdb258     #要貨在途量
      LET l_pmdb.pmdb259   = l_rtdx.pmdb259     #週平均銷量
      
      #入庫在途量
      CALL s_apmt840_sum_in_way(l_pmdb.pmdbsite,l_pmdb.pmdb004,l_pmdb.pmdb005) #150413-00018#1 sakura add
         RETURNING l_pmdb.pmdb253
                    
      LET l_pmdb.pmdb260   = g_pmda.pmda003     #收貨部門
      
      INSERT INTO pmdb_t(pmdbent, pmdbsite, pmdbdocno, pmdbseq,
                         pmdb001, pmdb002,  pmdb003,   pmdb004,
                         pmdb005, pmdb006,  pmdb007,   pmdb015,
                         pmdb019, pmdb020,  pmdb021,   pmdb030,
                         pmdb032, pmdb033,  pmdb037,   pmdb038,
                         pmdb039, pmdb044,  pmdb046,   pmdb048,
                         pmdb049, pmdb050,  pmdb051,   pmdb200,
                         pmdb201, pmdb202,  pmdb203,   pmdb204,
                         pmdb205, pmdb206,  pmdb207,   pmdb208,
                         pmdb209, pmdb210,  pmdb211,   pmdb212,
                         pmdb250, pmdb251,  pmdb252,   pmdb253,
                         pmdb254, pmdb255,  pmdb256,   pmdb257,
                         pmdb258, pmdb259,  pmdb260,   pmdb227,  pmdb213)  #增加参考价格 guomy 
         VALUES(l_pmdb.pmdbent, l_pmdb.pmdbsite, l_pmdb.pmdbdocno, l_pmdb.pmdbseq,
                l_pmdb.pmdb001, l_pmdb.pmdb002,  l_pmdb.pmdb003,   l_pmdb.pmdb004,
                l_pmdb.pmdb005, l_pmdb.pmdb006,  l_pmdb.pmdb007,   l_pmdb.pmdb015,
                l_pmdb.pmdb019, l_pmdb.pmdb020,  l_pmdb.pmdb021,   l_pmdb.pmdb030,
                l_pmdb.pmdb032, l_pmdb.pmdb033,  l_pmdb.pmdb037,   l_pmdb.pmdb038,
                l_pmdb.pmdb039, l_pmdb.pmdb044,  l_pmdb.pmdb046,   l_pmdb.pmdb048,
                l_pmdb.pmdb049, l_pmdb.pmdb050,  l_pmdb.pmdb051,   l_pmdb.pmdb200,
                l_pmdb.pmdb201, l_pmdb.pmdb202,  l_pmdb.pmdb203,   l_pmdb.pmdb204,
                l_pmdb.pmdb205, l_pmdb.pmdb206,  l_pmdb.pmdb207,   l_pmdb.pmdb208,
                l_pmdb.pmdb209, l_pmdb.pmdb210,  l_pmdb.pmdb211,   l_pmdb.pmdb212,
                l_pmdb.pmdb250, l_pmdb.pmdb251,  l_pmdb.pmdb252,   l_pmdb.pmdb253,
                l_pmdb.pmdb254, l_pmdb.pmdb255,  l_pmdb.pmdb256,   l_pmdb.pmdb257,
                l_pmdb.pmdb258, l_pmdb.pmdb259,  l_pmdb.pmdb260,   l_pmdb.pmdb227,l_pmdb.pmdb213 )#增加参考价格 guomy 
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "Ins pmdb_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      INITIALIZE l_pmdb.* TO NULL
      INITIALIZE l_rtdx.* TO NULL
   END FOREACH
   
   IF r_success THEN
      CALL s_transaction_end('Y',0)
   ELSE
      CALL s_transaction_end('N',0)
   END IF
   CALL cl_err_collect_show()
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 單頭相關條件SQL語法
# Memo...........:
# Usage..........: CALL apmt830_02_get_pmda()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/05/28 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt830_02_get_pmda()
DEFINE l_sys     LIKE type_t.num5 

   INITIALIZE g_pmda.* TO NULL
   
   SELECT pmdadocdt, pmdasite, pmda003, pmda201,
          pmda202,   pmda203,  pmda204, pmda205,
          pmda206,   pmda207                      #151113-00003#11 151130 By pomelo add pmda207
     INTO g_pmda.pmdadocdt, g_pmda.pmdasite, g_pmda.pmda003, g_pmda.pmda201,
          g_pmda.pmda202,   g_pmda.pmda203,  g_pmda.pmda204, g_pmda.pmda205,
          g_pmda.pmda206,   g_pmda.pmda207        #151113-00003#11 151130 By pomelo add pmda207
     FROM pmda_t
    WHERE pmdaent = g_enterprise
      AND pmdadocno = g_pmdadocno

   #品類設定加上部門過濾該作業可使用的商品
   LET g_where_sql = s_arti204_control_where(g_prog,g_pmda.pmda003,'1')
   
   #採購方式
   IF NOT cl_null(g_pmda.pmda201) THEN
      LET g_where_sql = g_where_sql," AND rtdx027 = '",g_pmda.pmda201,"'"
   END IF
   
   ##所屬品類
   #IF NOT cl_null(g_pmda.pmda202) THEN
   #   LET l_sys = 0
   #   CALL cl_get_para(g_enterprise,g_site,'E-CIR-0001') RETURNING l_sys
   #   LET g_where_sql = g_where_sql," AND imaa009 IN (SELECT DISTINCT rtax001",
   #                                 "                   FROM rtax_t ",
   #                                 "                  WHERE rtaxent =",g_enterprise,
   #                                 "                    AND rtax004 >= ",l_sys,
   #                                 "                    AND rtaxstus = 'Y'",
   #                                 "                  START WITH rtax003 = '",g_pmda.pmda202,"'",
   #                                 "                    AND rtaxstus = 'Y'",
   #                                 "                CONNECT BY NOCYCLE PRIOR rtax001 = rtax003)"                                    
   #END IF
   
   #採購中心
   IF NOT cl_null(g_pmda.pmda204) THEN
      LET g_where_sql = g_where_sql," AND rtdx028 = '",g_pmda.pmda204,"'"
   END IF
   
   #配送中心
   IF NOT cl_null(g_pmda.pmda205) THEN
      LET g_where_sql = g_where_sql," AND rtdx029 = '",g_pmda.pmda205,"'"
   END IF
END FUNCTION

################################################################################
# Descriptions...: 按查詢後把資料寫到tmp
# Memo...........:
# Usage..........: CALL apmt830_02_gen_rtdx()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/05/27 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt830_02_gen_rtdx()
DEFINE l_sql             STRING
DEFINE l_where_sql       STRING
DEFINE l_success         LIKE type_t.num5
DEFINE l_ooba002         LIKE ooba_t.ooba002
DEFINE l_sys             LIKE type_t.num5 
DEFINE l_sys2            LIKE type_t.num5 
DEFINE l_pmdbsite        LIKE pmdb_t.pmdbsite
DEFINE l_rtdx            RECORD
       rtdx001           LIKE rtdx_t.rtdx001,     #商品編號
       rtdx002           LIKE rtdx_t.rtdx002,     #
       imaz003           LIKE imaz_t.imaz003,
       imaz006           LIKE imaz_t.imaz006,     #補貨規格說明 #150710-00016#3
       rtdx004           LIKE rtdx_t.rtdx004,
       pmdb252           LIKE pmdb_t.pmdb252,
       pmdb259           LIKE pmdb_t.pmdb259,
       pmdb254           LIKE pmdb_t.pmdb254,
       pmdb255           LIKE pmdb_t.pmdb255,
       pmdb256           LIKE pmdb_t.pmdb256,
       pmdb257           LIKE pmdb_t.pmdb257,
       pmdb258           LIKE pmdb_t.pmdb258
                         END RECORD

   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   
   DELETE FROM apmt830_02_tmp
   
   LET l_where_sql = ''
   #所屬品類
   IF NOT cl_null(l_imaa009) THEN
      LET l_sys = 0
      CALL cl_get_para(g_enterprise,g_site,'E-CIR-0001') RETURNING l_sys
      LET l_where_sql = " AND imaa009 IN (SELECT DISTINCT rtax001",
                                    "                FROM rtax_t ",
                                    "               WHERE rtaxent =",g_enterprise,
                                    "                 AND rtax004 >= ",l_sys,
                                    "                 AND rtaxstus = 'Y'",
                                    "               START WITH rtax003 = '",l_imaa009,"'",
                                    "             CONNECT BY NOCYCLE PRIOR rtax001 = rtax003 ",
                                    "     UNION ",
                                    "    SELECT DISTINCT rtax001",
                                    "               FROM rtax_t ",
                                    "              WHERE rtaxent =",g_enterprise,
                                    "                AND rtax004 = ",l_sys,
                                    "                AND rtax005 = 0 ",
                                    "                AND rtaxstus = 'Y' ",
                                    "                AND rtax001 = '",l_imaa009,"' )"                                    
   END IF   

   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Del apmt830_02_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   LET l_sql = "INSERT INTO apmt830_02_tmp(sel,       rtdx001,      rtdx002,       pmdb007,       pmdb213, ", #加参考价格
               "                           pmdb006,   imaz003,      imaz006,       rtdx004,       pmdb212, ", #加imaz006
               "                           rtdx044,   pmdb252,      pmdb259,       rtdx028, ",
               "                           rtdx029 ) ",
               "SELECT DISTINCT 'N',       rtdx001,   rtdx002,      imaa104,      ",
               "     CASE   WHEN ('",g_pmdadocdt,"' between rtdx041 and rtdx042 )   THEN   rtdx032 ELSE rtdx034 END ,", #加参考价格
               "                 0,        rtdx002,   '',           rtdx004,      0,       ",
               "                 rtdx044,  0,         0,            rtdx028, ",
               "                 rtdx029 ",
               "  FROM rtdx_t,imaa_t,imaf_t ",
               "  LEFT OUTER JOIN pmaal_t ON imafent=pmaalent AND imaf153=pmaal001 AND pmaal002 = '",g_dlang,"'",
               " WHERE rtdxent = imaaent ",
               "  AND rtdx001  = imaa001 ",
               "  AND rtdxent  = imafent ",
               "  AND rtdxsite = imafsite ",
               "  AND rtdx001  = imaf001 ",
               "  AND rtdxent  =",g_enterprise,
               "  AND rtdxsite = '",g_pmdasite,"'",
               "  AND rtdxstus ='Y' ",
               "  AND imaastus ='Y' ",
               
               "  AND (imaf153 IS NULL OR  EXISTS(SELECT 1 FROM stan_t,star_t,stas_t WHERE stan001 = star004 AND starsite = stassite AND star001 = stas001 ",
               #"  AND stas003 = rtdx001 AND star003 = imaf153 AND starstus = 'Y' AND starsite = rtdxsite AND '",g_pmdadocdt,"' between stan017 AND stan018 AND imaf153 IS NOT NULL  )) "   #160104-00014#1 20160104 mark by beckxie
               "  AND stas003 = rtdx001 AND star003 = imaf153 AND starstus = 'Y' AND starsite = rtdxsite AND '",g_pmdadocdt,"' BETWEEN stas018 AND stas019 AND imaf153 IS NOT NULL  )) "    #160104-00014#1 20160104  add by beckxie
   LET l_sql = l_sql ," AND ",g_wc
   LET l_sql = l_sql ," AND ",g_where_sql
   LET l_sql = l_sql ,l_where_sql
   LET l_sql = l_sql ," ORDER BY rtdx001  "
   
   DISPLAY ' QBE SQL = ',l_sql
   
   PREPARE apmt830_02_ins_tmp FROM l_sql
   EXECUTE apmt830_02_ins_tmp
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Ins apmt830_02_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   
   #營運據點
   #單頭需求組織(pmda203)非空白時，Default = 需求組織(pmda203)
   IF NOT cl_null(g_pmda.pmda203) THEN
      LET l_pmdbsite = g_pmda.pmda203
   ELSE
      LET l_pmdbsite = g_site
   END IF   
   
   CALL cl_get_para(g_enterprise,g_pmdasite,'S-CIR-1001') RETURNING l_sys  
      
   LET l_sql = "SELECT DISTINCT rtdx001,rtdx002",
               "  FROM apmt830_02_tmp"
               
   INITIALIZE l_rtdx.* TO NULL               
   PREPARE apmt830_sel_imaz_pre FROM l_sql
   DECLARE apmt830_sel_imaz_cs CURSOR FOR apmt830_sel_imaz_pre
   FOREACH apmt830_sel_imaz_cs INTO l_rtdx.rtdx001,l_rtdx.rtdx002
       
       
      #150710-00016#4 Add By Ken 150713(S) 取商品符合補貨規格的包裝單位、件裝數、補貨規格
      ##補貨條碼、包裝單位       
      #SELECT imaz003,imaz004 INTO l_rtdx.imaz003,l_rtdx.rtdx004
      #  FROM imaz_t
      # WHERE imazent = g_enterprise
      #   AND imaz001 = l_rtdx.rtdx001
      #
      #IF NOT cl_null(l_rtdx.imaz003) THEN
      #   UPDATE apmt830_02_tmp
      #      SET imaz003 = l_rtdx.imaz003,
      #          rtdx004 = l_rtdx.rtdx004
      #    WHERE rtdx001 = l_rtdx.rtdx001
      #      AND rtdx002 = l_rtdx.rtdx002                      
      #END IF
                 

      LET l_rtdx.rtdx004 = ''
      LET l_rtdx.imaz006 = ''
      CALL cl_get_para(g_enterprise,g_pmdasite,'S-CIR-1001') RETURNING l_sys2
      SELECT imaz004,imaz006 INTO l_rtdx.rtdx004,l_rtdx.imaz006
        FROM imaz_t
       WHERE imazent = g_enterprise 
         AND imaz001 = l_rtdx.rtdx001
         AND imaz002 = l_sys2   
         
       IF cl_null(l_rtdx.rtdx004) THEN
          SELECT imay004 
            INTO l_rtdx.rtdx004
            FROM imay_t 
           WHERE imayent= g_enterprise 
             AND imay001 = l_rtdx.rtdx001 
             AND imay003 = l_rtdx.rtdx002  
       END IF         
         
       UPDATE apmt830_02_tmp
          SET rtdx004 = l_rtdx.rtdx004,
              imaz006 = l_rtdx.imaz006
        WHERE rtdx001 = l_rtdx.rtdx001
          AND rtdx002 = l_rtdx.rtdx002         
      #150710-00016#4 Add By Ken 150713(E)       
      
      #可用庫存量
      CALL s_apmt840_sum_inag008(l_pmdbsite,l_rtdx.rtdx001,' ') 
         RETURNING l_rtdx.pmdb252

      #前一週銷量
      CALL s_daily_sale(l_pmdbsite,g_pmdadocdt,1,7,l_rtdx.rtdx001,' ')
         RETURNING l_rtdx.pmdb254
      
      #前二週銷量
      CALL s_daily_sale(l_pmdbsite,g_pmdadocdt,8,14,l_rtdx.rtdx001,' ')
         RETURNING l_rtdx.pmdb255
         
      #前三週銷量
      CALL s_daily_sale(l_pmdbsite,g_pmdadocdt,15,21,l_rtdx.rtdx001,' ')
         RETURNING l_rtdx.pmdb256
         
      #前四周銷量
      CALL s_daily_sale(l_pmdbsite,g_pmdadocdt,22,28,l_rtdx.rtdx001,' ')
         RETURNING l_rtdx.pmdb257
      
      #要貨在途量
      CALL s_apmt830_sum_pmdb258(l_pmdbsite,l_rtdx.rtdx001,' ')
         RETURNING l_rtdx.pmdb258
      
      #週平均銷量
      LET l_rtdx.pmdb259 = (l_rtdx.pmdb254 + l_rtdx.pmdb255 + l_rtdx.pmdb256 + l_rtdx.pmdb257)/4
           
      UPDATE apmt830_02_tmp
         SET pmdb252 = l_rtdx.pmdb252,
             pmdb254 = l_rtdx.pmdb254,
             pmdb255 = l_rtdx.pmdb255,
             pmdb256 = l_rtdx.pmdb256,
             pmdb257 = l_rtdx.pmdb257,
             pmdb258 = l_rtdx.pmdb258,
             pmdb259 = l_rtdx.pmdb259
       WHERE rtdx001 = l_rtdx.rtdx001
         AND rtdx002 = l_rtdx.rtdx002      
   END FOREACH
   
   CALL apmt830_02_b_fill()
   
   LET g_rec_b = g_rtdx_d.getLength()
   IF g_rec_b = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-01321'  #apm-00294   #160318-00005#38  By 07900--mod
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
END FUNCTION

################################################################################
# Descriptions...: 全選
# Memo...........:
# Usage..........: CALL apmt830_02_check_all()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/05/27 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt830_02_check_all()
   UPDATE apmt830_02_tmp SET sel = 'Y'
   CALL apmt830_02_set_entry_b("a")
   CALL apmt830_02_set_no_entry_b("a")    
   CALL apmt830_02_b_fill()
END FUNCTION

################################################################################
# Descriptions...: 全不選
# Memo...........:
# Usage..........: CALL apmt830_02_check_no_all()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/05/27 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt830_02_check_no_all()
   UPDATE apmt830_02_tmp SET sel = 'N'
   CALL apmt830_02_set_entry_b("a")
   CALL apmt830_02_set_no_entry_b("a")    
   CALL apmt830_02_b_fill()
END FUNCTION

################################################################################
# Descriptions...: 單位間的轉換數量
# Memo...........: 當要貨數量為空，由要貨包裝數量轉換成要貨數量及計價數量
#                : 當要貨數量有值，由要貨數量轉換成要貨包裝數量及計價數量
# Usage..........: CALL apmt830_02_num_change()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/05/27 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt830_02_num_change()
DEFINE l_success        LIKE type_t.num5

   #當要貨包裝單位或要貨單位都為空，表示無法轉換
   IF cl_null(g_rtdx_d[l_ac].l_pmdb007) OR cl_null(g_rtdx_d[l_ac].rtdx004) THEN
      RETURN
   END IF

  #Mark By baogc 20151104 Begin ---
  ##當要貨數量為空
  #IF cl_null(g_rtdx_d[l_ac].l_pmdb006) THEN
  #   #當要貨包裝數量為空
  #   IF cl_null(g_rtdx_d[l_ac].l_pmdb212) THEN
  #      RETURN
  #   ELSE
  #      #當收貨數量為空，由要貨包裝數量轉換成要貨數量
  #      CALL s_aooi250_convert_qty(g_rtdx_d[l_ac].rtdx001,g_rtdx_d[l_ac].rtdx004,g_rtdx_d[l_ac].l_pmdb007,g_rtdx_d[l_ac].l_pmdb212)
  #         RETURNING l_success,g_rtdx_d[l_ac].l_pmdb006
  #   END IF
  #ELSE
  #   #當要貨數量有值，由要貨數量轉換成要貨包裝數量
  #   CALL s_aooi250_convert_qty(g_rtdx_d[l_ac].rtdx001,g_rtdx_d[l_ac].l_pmdb007,g_rtdx_d[l_ac].rtdx004,g_rtdx_d[l_ac].l_pmdb006)
  #      RETURNING l_success,g_rtdx_d[l_ac].l_pmdb212
  #END IF
  #Mark By baogc 20151104 Begin ---
   
   CASE
      WHEN INFIELD (l_pmdb006)
         CALL s_aooi250_convert_qty(g_rtdx_d[l_ac].rtdx001,g_rtdx_d[l_ac].l_pmdb007,g_rtdx_d[l_ac].rtdx004,g_rtdx_d[l_ac].l_pmdb006)
            RETURNING l_success,g_rtdx_d[l_ac].l_pmdb212
         CALL s_aooi250_take_decimals(g_rtdx_d[l_ac].rtdx004,g_rtdx_d[l_ac].l_pmdb212)
            RETURNING l_success,g_rtdx_d[l_ac].l_pmdb212         
      WHEN INFIELD (l_pmdb212)
         CALL s_aooi250_convert_qty(g_rtdx_d[l_ac].rtdx001,g_rtdx_d[l_ac].rtdx004,g_rtdx_d[l_ac].l_pmdb007,g_rtdx_d[l_ac].l_pmdb212)
            RETURNING l_success,g_rtdx_d[l_ac].l_pmdb006
         CALL s_aooi250_take_decimals(g_rtdx_d[l_ac].l_pmdb007,g_rtdx_d[l_ac].l_pmdb006)
            RETURNING l_success,g_rtdx_d[l_ac].l_pmdb006
      #150512-00026#1 Add By Ken 151214(S)
      OTHERWISE
         IF cl_null(g_rtdx_d[l_ac].l_pmdb006) OR g_rtdx_d[l_ac].l_pmdb006 = 0 THEN
            CALL s_aooi250_convert_qty(g_rtdx_d[l_ac].rtdx001,g_rtdx_d[l_ac].rtdx004,g_rtdx_d[l_ac].l_pmdb007,g_rtdx_d[l_ac].l_pmdb212)
               RETURNING l_success,g_rtdx_d[l_ac].l_pmdb006
         ELSE
            CALL s_aooi250_convert_qty(g_rtdx_d[l_ac].rtdx001,g_rtdx_d[l_ac].l_pmdb007,g_rtdx_d[l_ac].rtdx004,g_rtdx_d[l_ac].l_pmdb006)
               RETURNING l_success,g_rtdx_d[l_ac].l_pmdb212
         END IF
      #150512-00026#1 Add By Ken 151214(E)
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 更新tmp中的要貨數量、要貨包裝數量
# Memo...........:
# Usage..........: CALL apmt830_02_pmdb006_upd()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/05/29 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt830_02_pmdb006_upd()
DEFINE l_sel   LIKE type_t.chr1

   IF g_rtdx_d[l_ac].l_pmdb006 > 0 OR g_rtdx_d[l_ac].l_pmdb212 > 0 THEN
      LET l_sel = 'Y'
   ELSE
      LET l_sel = 'N'
   END IF
   
   UPDATE apmt830_02_tmp 
      SET pmdb006 = g_rtdx_d[l_ac].l_pmdb006,
          pmdb212 = g_rtdx_d[l_ac].l_pmdb212,
          sel = l_sel
    WHERE rtdx001 = g_rtdx_d[l_ac].rtdx001
      #AND rtdx002 = g_rtdx_d[l_ac].rtdx002 
END FUNCTION

 
{</section>}
 
